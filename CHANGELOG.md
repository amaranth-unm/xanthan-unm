# Changelog

All notable changes to the Xanthan UNM Extension will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Rebuilt the extension around UNM’s narrow utility bar, hanging white logo, and cherry university footer.
- Scoped all branding CSS to `unm-` components, preserving Xanthan’s content grid and reading widths.
- Replaced retired core includes and split document wrappers with a complete current Xanthan layout.
- Kept site navigation below the hero and reserved logo space on pages without a hero.
- Made university analytics an explicit, production-only configuration option.
- Updated installation instructions to include the packaged styles, scripts, and brand images.

### Added
- Responsive utility menus with native keyboard interaction and Escape/outside-click dismissal.
- Shared shell-width and gutter variables, optional site footer, and compact university footer configuration.
- Root/subpath integration checks and visual regression guidance.

### Removed
- Bootstrap, jQuery, global UNM homepage CSS, unrelated `csw.css`, and the university secondary navigation row.

## [1.0.0] - 2024-12-23

### Added
- Initial release of Xanthan UNM Extension
- `base-unm.html` layout with UNM branding
- UNM departmental navigation (`nav-unm.html`)
- Site navigation component (`nav-site.html`)
- UNM footer with official branding (`footer-unm.html`)
- Alternative footer option (`footer-site.html`)
- Google Tag Manager integration for UNM analytics
- Comprehensive README with installation instructions
- Support for both manual (GitHub web) and command-line installation

### Notes
- Compatible with Xanthan core v1.0+
- Requires existing Xanthan installation
- Follows UNM branding guidelines (as of December 2024)
