#!/usr/bin/env ruby
# Run with the Jekyll site's bundle; no browser or network is needed.
require 'jekyll'
require 'nokogiri'
require 'tmpdir'
require 'fileutils'
require 'yaml'
require 'uri'

extension = File.expand_path('..', __dir__)
core = File.expand_path(ARGV.fetch(0))
preview = ARGV[1] && File.expand_path(ARGV[1])

def assert(condition, message)
  raise message unless condition
end

Dir.mktmpdir('xanthan-unm-check-') do |root|
  source = File.join(root, 'source')
  FileUtils.mkdir_p(source)
  %w[_includes _layouts assets].each do |folder|
    FileUtils.cp_r(File.join(core, folder), source)
  end
  %w[_includes _layouts assets].each do |folder|
    FileUtils.cp_r(File.join(extension, folder, '.'), File.join(source, folder))
  end
  File.write(File.join(source, 'index.md'), <<~PAGE)
    ---
    layout: base-unm
    title: UNM integration — no hero
    ---
    # A page without a hero

    The logo reserves space above the site navigation. This paragraph uses
    Xanthan's normal reading width inside its original content grid.

    [See the hero page]({{ '/hero.html' | relative_url }}).
  PAGE
  File.write(File.join(source, 'hero.md'), <<~PAGE)
    ---
    layout: base-unm
    title: UNM integration — hero
    header-image: /assets/unm/mesa-mountain-red.png
    header-title: A page with a hero
    header-tier: section
    header-height: 340px
    ---
    ## Content below the hero

    The UNM logo overlaps the hero. The site's navigation follows the hero,
    and this text retains Xanthan's normal reading width.

    [See the page without a hero]({{ '/' | relative_url }}).
  PAGE

  ['', '/preview'].each do |baseurl|
    [true, false].each do |full|
      destination = File.join(root, "build-#{baseurl.empty? ? 'root' : 'project'}-#{full}")
      config = {
        'source' => source, 'destination' => destination, 'config' => [],
        'title' => 'UNM template check', 'url' => 'https://example.org',
        'baseurl' => baseurl, 'search' => false, 'quiet' => true,
        'unm' => {'site_navigation' => full, 'footer_directory' => full}
      }
      Jekyll::Site.new(Jekyll.configuration(config)).process
      %w[index.html hero.html].each do |page|
        html = File.read(File.join(destination, page))
        doc = Nokogiri::HTML(html)
        assert(html.scan(/<head>/).size == 1 && html.scan(/<body\b/).size == 1, "#{page}: duplicate document wrappers")
        assert(doc.css('main#main .container').size == 1, "#{page}: missing Xanthan content grid")
        assert(doc.css('.unm-header, .unm-footer').size == 2, "#{page}: missing university identity")
        assert(doc.css('main .unm-header, main .unm-footer').empty?, "#{page}: university component nested in content")
        assert(doc.css('.unm-header--standalone').any? == (page == 'index.html'), "#{page}: incorrect logo overlap")
        assert(doc.css('.top-nav').any? == full, "#{page}: site_navigation setting ignored")
        assert(doc.css('.unm-footer-directory').any? == full, "#{page}: footer_directory setting ignored")
        assert(doc.css('.unm-footer-legal').any?, "#{page}: missing legal links")
        ids = doc.css('[id]').map { |element| element['id'] }
        assert(ids.uniq == ids, "#{page}: duplicate IDs")
        assert(!html.match?(/bootstrap|jquery|csw\.css|unm-styles|site-styles/), "#{page}: global legacy dependency leaked into page")
        assert(!html.include?('googletagmanager'), "#{page}: analytics enabled without a configured ID")
        doc.css('link[rel="stylesheet"], script[src], img').each do |element|
          url = element['href'] || element['src']
          next if url.start_with?('https://', 'http://')
          assert(url.start_with?(baseurl + '/'), "#{page}: missing baseurl on #{url}")
          path = URI::DEFAULT_PARSER.unescape(url.delete_prefix(baseurl))
          assert(File.file?(File.join(destination, path)), "#{page}: missing asset #{url}")
        end
        assert(doc.css('.unm-footer img, .unm-header img').all? { |img| !img['alt'].to_s.empty? }, "#{page}: missing wordmark alternative text")
      end
      if preview && baseurl == '/preview' && full
        FileUtils.mkdir_p(File.join(preview, 'preview'))
        FileUtils.cp_r(File.join(destination, '.'), File.join(preview, 'preview'))
      end
    end
  end
end
puts 'PASS: eight rendered pages; hero/no hero, root/project URL, and full/compact chrome.'
puts "Preview files: #{preview}/preview/" if preview
