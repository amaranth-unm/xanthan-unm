# Integration and visual checks

From a site with Jekyll and Nokogiri installed in its bundle:

```sh
bundle exec ruby /path/to/xanthan-unm/test/integration.rb /path/to/xanthan
```

The test builds temporary sites from an unmodified Xanthan checkout plus this extension. It checks the actual generated pages, the preservation of the content grid, document nesting, optional menus/footer, unique IDs, local assets at a project subpath, and the absence of the former global dependencies. The temporary sites are removed after the test.

For visual checks, pass an empty output directory as a second argument. The standard hero and no-hero pages will be copied into its `preview/` folder. Serve that output directory with any static server and visit `/preview/` and `/preview/hero.html`.

Check at 390px, 768px, 1280px, and 1440px viewport widths:

- No horizontal scrolling; header and footer shells share the same centered bounds.
- Desktop shell at most 1170px wide; logo 235 × 70px. Mobile logo 180 × 54px.
- Logo overlaps the hero but does not cover the navigation on a page without a hero.
- Hero and navigation occupy their own rows. Xanthan's `.container` is still a grid and its article width is unchanged.
- Footer columns reflow without clipping or inheriting oversized article list text.
- Mobile UNM menu opens by keyboard; Escape dismisses it and restores focus to its summary. The site navigation toggle still works independently.

Also compare the university components with [unm.edu](https://www.unm.edu/) when updating its branding. Preserve the current site's theme and content styling while making that comparison.
