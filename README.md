# Xanthan UNM extension

University of New Mexico branding for [Xanthan](https://github.com/xanthan-web/xanthan-web.github.io): the narrow cherry utility bar, white UNM wordmark hanging over a hero image, and university footer, adapted from [unm.edu](https://www.unm.edu/) on September 13, 2026.

The extension owns only these university components. It preserves Xanthan’s content grid, typography, hero images, menus, and search. It does not load Bootstrap, jQuery, UNM’s global homepage styles, or the university’s secondary navigation row.

## Install

Start with a current Xanthan site. Copy these paths into the matching locations in that site:

- `_layouts/base-unm.html`
- `_includes/unm/` (the entire folder)
- `assets/css/unm.css`
- `assets/js/unm.js`
- `assets/unm/` (the entire folder)

Use `layout: base-unm` in a page’s front matter, or make it the default in `_config.yml`:

```yaml
defaults:
  - scope:
      path: ""
    values:
      layout: base-unm
```

Explicit `layout` values in individual pages take precedence over defaults. See [INSTALLATION.md](INSTALLATION.md) for copying, upgrades, and troubleshooting.

## Hero images and navigation

Use Xanthan’s normal hero settings:

```yaml
---
layout: base-unm
title: Department of Example
header-image: /assets/images/campus.jpg
header-title: Department of Example
header-tier: section
---
```

The UNM logo extends below the utility bar over the hero. Pages without `header-image` reserve space beneath the logo so it cannot cover the site navigation or content. The site’s Xanthan menu appears below the hero; edit `_data/nav-top.yml` to change its links.

Configuration options in `_config.yml`:

```yaml
unm:
  site_navigation: true     # Xanthan navigation below the hero
  site_footer: false       # optional Xanthan site-specific footer
  footer_directory: true   # university directory and Apply / Visit / Give

# Optional: supply your own authorized container ID; disabled by default.
# unm_gtm_id: GTM-XXXXXXX
```

The UNM identity, social, and legal footer remain when `footer_directory` is false. Analytics runs only in production builds with a configured ID.

## Widths and custom layouts

The UNM shell is fluid with a **1170px maximum including 15px side gutters**. The desktop logo is 235 × 70px, over a 32px bar. On phones the logo is 180 × 54px over a 36px bar, with a keyboard-accessible disclosure menu.

All branding selectors use `unm-` classes. In particular, the extension never redefines Xanthan’s `.container` grid. Reading width and full-width content remain Xanthan’s responsibility.

To align a site-specific region with the university footer text, use the shell directly:

```html
<div class="unm-shell">Your site-specific region</div>
```

Or reference `var(--unm-shell-width)` and `var(--unm-gutter)` from your own styles. Override `--unm-shell-width` on `.unm-site` if a different site-wide width is needed. Do not apply `.unm-shell` to Xanthan’s `.container`.

For a custom layout, use `unm/page-header-unm.html` instead of `html/html-head.html`, put `class="unm-site"` on the body, and place `{% include unm/nav-unm.html overlap=true %}` immediately before your hero, outside the content grid. Omit `overlap=true` when there is no hero. Include `unm/footer-unm.html` near the end of the page and load `assets/js/unm.js` with `relative_url` and `defer`. Each include emits only its own component; the layout owns the document wrappers. You may customize `unm/footer-site.html` for department contact information.

## Dependencies and verification

Requires the current Xanthan includes `html/html-head.html`, `html/html-js.html`, `nav/skip-link.html`, `nav/nav-top.html`, `nav/search.html`, `layout/page-header.html`, `layout/footer.html`, and `google_analytics.html`. This update was tested against Xanthan commit `5e106aac8ba5c93467d638db02ffe8430346ecd6` with Jekyll 4.4.

Brand images are packaged locally. UNM fonts load from `webcore.unm.edu` with an Arial fallback. Footer social icons use Font Awesome already loaded by Xanthan. University search submits to `search.unm.edu`; site search remains Xanthan’s own search.

From a Xanthan site with Jekyll and Nokogiri available in its bundle:

```sh
bundle exec ruby /path/to/xanthan-unm/test/integration.rb /path/to/xanthan
```

This builds a fresh integration with and without a hero at both a root URL and a project subpath, verifies the asset URLs and document structure, and checks the optional footer/menu settings. See [test/README.md](test/README.md) for visual width checks.

## Credits and rights

Xanthan: Fred Gibbs and contributors. University wordmarks and the footer background come from [UNM Webcore](https://webcore.unm.edu/). University trademarks retain their respective rights. The extension follows Xanthan’s GPL-3.0 code license; branding assets are not relicensed by this repository.
