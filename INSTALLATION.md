# Installing or updating Xanthan UNM

Use a current [Xanthan](https://github.com/xanthan-web/xanthan-web.github.io) site. This is a branding extension, not a standalone Jekyll theme.

## Copy the extension

Download this repository’s ZIP from GitHub, or clone it locally. Copy these files and folders, preserving their paths:

| Source in this repository | Destination in your Xanthan site |
| --- | --- |
| `_layouts/base-unm.html` | `_layouts/base-unm.html` |
| `_includes/unm/` | `_includes/unm/` |
| `assets/css/unm.css` | `assets/css/unm.css` |
| `assets/js/unm.js` | `assets/js/unm.js` |
| `assets/unm/` | `assets/unm/` |

For GitHub’s web editor, create any missing destination folders by entering a full file path with **Add file → Create new file**, then upload the remaining files into those folders. Include the images and JavaScript as well as the layout and includes.

For a local checkout, run these commands from the Xanthan site, replacing the extension path:

```sh
mkdir -p _layouts _includes/unm assets/css assets/js assets/unm
cp /path/to/xanthan-unm/_layouts/base-unm.html _layouts/
cp /path/to/xanthan-unm/_includes/unm/* _includes/unm/
cp /path/to/xanthan-unm/assets/css/unm.css assets/css/
cp /path/to/xanthan-unm/assets/js/unm.js assets/js/
cp /path/to/xanthan-unm/assets/unm/* assets/unm/
```

Set a page’s front matter to `layout: base-unm`, or configure the default layout as shown in [README.md](README.md). Keep the normal GitHub Pages `url` and `baseurl` settings; all extension asset URLs respect them.

## Upgrade from the original extension

Save any local department menus or footer customizations before replacing files. The new `nav-unm.html` is the university utility bar only. Put departmental menu links in `_data/nav-top.yml`, and put custom department contact information in `unm/footer-site.html` or your own include.

Replace the complete file set in the table above. Remove old custom references to Bootstrap, jQuery, `site-styles.css`, `unm-styles.min.css`, and `csw.css` from your UNM layout/head integration. These global styles conflict with Xanthan’s `.container` and typography. The new head adapter supplies the small scoped stylesheet and the UNM font stylesheet.

The layout now uses current Xanthan include paths. The retired `breadcrumbs.html`, `header-image.html`, and `page-js.html` includes are no longer needed by this extension. The layout owns every opening and closing document wrapper; the footer includes no longer close elements opened elsewhere.

The previously hardcoded Tag Manager container has been removed. If this site uses university analytics, explicitly set its authorized `unm_gtm_id` in `_config.yml`. Preserve an existing site’s ID when upgrading. The optional core `analytics_id` setting is unchanged.

## Preview and publish

Build or serve the site using its existing Jekyll workflow. Check a page with a hero and another without one, then check a narrow phone screen. The logo should overlap only the hero, the footer should fit the viewport, and the content grid should retain its original layout.

Commit the copied files and publish using your site’s existing GitHub Pages workflow. No special plugins or separate build step are required for the extension.

## Troubleshooting

- **Missing logo or footer background:** copy the entire `assets/unm/` folder and check `baseurl`.
- **Missing styles:** confirm the page uses `base-unm`, or that its custom layout includes `unm/page-header-unm.html`.
- **Unchanged old layout:** explicit page-level `layout` values override `_config.yml` defaults.
- **Unexpected widths:** remove old global UNM/Bootstrap styles. Keep `.unm-shell` outside Xanthan’s `.container`; do not combine the two classes on the same element.
- **Logo covers navigation:** use the default standalone header when there is no hero. In a custom layout, pass `overlap=true` only when the hero immediately follows the utility bar.
- **Missing core includes:** update Xanthan to a version with the paths listed in README, or adapt your custom layout to its installed version.

To uninstall, switch pages back to their Xanthan layout, then remove the extension paths from the installation table. Keep any department-specific content you added.
