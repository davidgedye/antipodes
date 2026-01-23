# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Antipodes is a single-page web application that displays two synchronized 3D globes showing antipodal points on Earth (the point diametrically opposite any selected location). Built with vanilla HTML/CSS/JavaScript using Mapbox GL JS for 3D globe rendering and Turf.js for geographic calculations.

## Development

**No build system** - This is a static HTML site with all code in `index.html`.

- **To develop:** Open `index.html` directly in a web browser
- **To deploy:** Push to `gh-pages` branch for GitHub Pages hosting
- **Live site:** Hosted via GitHub Pages

## Architecture

The entire application lives in `index.html` (~320 lines):

- **Dual Map System:** Two Mapbox GL JS maps configured as 3D globes (`projection: 'globe'`)
- **Synchronization:** When one map moves, the other automatically updates to show the antipodal coordinates via `syncMaps()` function
- **Auto-spin Animation:** On load, both globes spin along a great circle path using `requestAnimationFrame`; clicking/dragging stops the animation
- **Geocoding Search:** Mapbox Geocoding API integration for location search

**Key functions:**
- `getAntipode(lng, lat)` - Returns antipodal coordinates: `[lng + 180 or -180, -lat]`
- `syncMaps(sourceMap, targetMap, isSourceLeft)` - Synchronizes map views with antipodal transformation
- `spin()` - Animates maps along great circle path using Turf.js `destination()` and `bearing()`

## External Dependencies (CDN)

- Mapbox GL JS v3.3.0
- Turf.js v7
- Mapbox Geocoding API (token embedded in code)
