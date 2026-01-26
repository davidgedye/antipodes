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

## File Structure

```
antipodes/
├── index.html     # Side-by-side dual globe view
├── hole.html      # Portal/tunnel view with fall-through effect
└── CLAUDE.md      # This file
```

## Entry Points

- **index.html** - Side-by-side dual globe view. In portrait orientation (mobile), stacks vertically and hides UI chrome.
- **hole.html** - Portal/tunnel view. Shows one globe with a ragged hole revealing the antipode beneath. Tap inside the portal to "fall through" and swap the views. Drag the portal edge to resize.

## Architecture

### index.html

- **Dual Map System:** Two Mapbox GL JS maps configured as 3D globes (`projection: 'globe'`)
- **Synchronization:** When one map moves, the other automatically updates to show the antipodal coordinates via `syncMaps()` function
- **Guided Tour:** On load, maps fly through a sequence of antipodal pairs (`tourPoints` array); clicking/dragging stops the tour
- **Geocoding Search:** Mapbox Geocoding API integration for location search
- **Responsive:** Portrait mode hides header and labels, shows overlay hint

**Key functions:**
- `getAntipode(lng, lat)` - Returns antipodal coordinates: `{lng: lng +/- 180, lat: -lat}`
- `syncMaps(sourceMap, targetMap, isSourceLeft)` - Synchronizes map views with antipodal transformation
- `runTour()` - Flies through `tourPoints` array with 6s flight + 3s pause per location
- `calcZoomForContainer(container)` - Calculates zoom level to fit globe with 90% diameter in container
- `stopTour()` - Stops the tour animation and hides instruction hints

### hole.html

- **Stacked Maps:** Back map (location) underneath, front map (antipode) on top with CSS clip-path
- **Ragged Portal:** SVG polygon clip-path with randomized points creates organic tunnel edge
- **Fall-through Animation:** Tap inside portal to animate expansion, swap maps, and contract
- **Resize:** Drag near portal edge to resize; pointer events route to correct map based on position
- **Spinning:** Random great circle spinning animation on load using Turf.js

**Key functions:**
- `getAntipode(lng, lat)` - Returns antipodal coordinates
- `syncMaps(sourceMap, targetMap, sourceIsFront)` - Synchronizes map views
- `generateRaggedPaths(radiusPx)` - Creates randomized polygon for clip-path and SVG ring
- `updatePortal(radiusPx)` - Updates portal clip-path and SVG ring size
- `animatePortalOpen()` - Animates portal opening on page load
- `spin()` - Animates maps along great circle path using Turf.js `destination()` and `bearing()`
- `fallThrough()` - Animates portal expansion, swaps maps at midpoint, contracts
- `swapMaps()` - Toggles z-index and clip-path between the two map layers
- `updatePointerEvents(e)` - Routes interactions to correct map based on pointer position
- `getGlobeRadiusPixels(map)` - Calculates rendered globe radius by projecting map coordinates

## Code Conventions

- **Vanilla JS only** - No frameworks, bundlers, or transpilation
- **All code inline** - CSS in `<style>`, JS in `<script>` within HTML files
- **Coordinates:** Displayed with 2 decimal places (e.g., `lat.toFixed(2)`)
- **Map rotation disabled** - `dragRotate.disable()` and `touchZoomRotate.disableRotation()`
- **Atmosphere effect** - Both pages use `setFog()` for globe atmosphere styling

## External Dependencies (CDN)

- **Mapbox GL JS v3.3.0** - 3D globe rendering
- **Turf.js v7** - Geographic calculations (used in hole.html for spinning)
- **Mapbox Geocoding API** - Location search (token embedded in code)

## Testing

No automated tests. Manual testing:
1. Run local server: `python3 -m http.server 8000`
2. Test both pages in browser at `http://localhost:8000`
3. Test portrait/landscape orientations (use browser dev tools device mode)
4. Test touch interactions on mobile or via dev tools
