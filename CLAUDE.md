# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## User Preferences

- When I say "pages" I mean the `gh-pages` branch (applies to all GitHub projects)

## Project Overview

Antipodes is a single-page web application that displays two synchronized 3D globes showing antipodal points on Earth (the point diametrically opposite any selected location). Built with vanilla HTML/CSS/JavaScript using Mapbox GL JS for 3D globe rendering and Turf.js for geographic calculations.

## Development

**No build system** - This is a static HTML site.

- **To develop:** Run `python3 -m http.server 8000` and open in browser
- **To deploy:** Push to `gh-pages` branch for GitHub Pages hosting
- **Live site:** https://davidgedye.github.io/antipodes/

## Entry Points

- **index.html** - Side-by-side dual globe view. In portrait orientation (mobile), stacks vertically and hides UI chrome.
- **hole.html** - Portal/tunnel view. Shows one globe with a ragged hole revealing the antipode beneath. Tap inside the portal to "fall through" and swap the views. Drag the portal edge to resize.

## Architecture

### index.html (~350 lines):

- **Dual Map System:** Two Mapbox GL JS maps configured as 3D globes (`projection: 'globe'`)
- **Synchronization:** When one map moves, the other automatically updates to show the antipodal coordinates via `syncMaps()` function
- **Auto-spin Animation:** On load, both globes spin along a great circle path using `requestAnimationFrame`; clicking/dragging stops the animation
- **Geocoding Search:** Mapbox Geocoding API integration for location search

**Key functions:**
- `getAntipode(lng, lat)` - Returns antipodal coordinates: `[lng + 180 or -180, -lat]`
- `syncMaps(sourceMap, targetMap, isSourceLeft)` - Synchronizes map views with antipodal transformation
- `spin()` - Animates maps along great circle path using Turf.js `destination()` and `bearing()`
- `calcZoomForContainer()` - Calculates zoom level to fit globe with padding in any container size

### hole.html (~500 lines):

- **Stacked Maps:** Back map (location) underneath, front map (antipode) on top with CSS clip-path
- **Ragged Portal:** SVG polygon clip-path with randomized points creates organic tunnel edge
- **Fall-through Animation:** Tap inside portal to animate expansion, swap maps, and contract
- **Resize:** Drag near portal edge to resize; pointer events route to correct map based on position

**Key functions:**
- `generateRaggedPaths()` - Creates randomized polygon for clip-path and SVG ring
- `fallThrough()` - Animates portal expansion, swaps maps at midpoint, contracts
- `swapMaps()` - Toggles z-index and clip-path between the two map layers
- `updatePointerEvents()` - Routes interactions to correct map based on pointer position

## External Dependencies (CDN)

- Mapbox GL JS v3.3.0
- Turf.js v7
- Mapbox Geocoding API (token embedded in code)
