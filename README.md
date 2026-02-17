# Antipodes

A web application that displays two synchronized 3D globes showing antipodal points on Earth — the point diametrically opposite any selected location.

**Live site:** https://davidgedye.github.io/antipodes/

## Views

### Side-by-Side (`index.html`)

Two synchronized globes side by side. Pan or zoom one globe and the other automatically shows the antipodal view. Features a guided tour through notable antipodal pairs on load.

- Responsive: stacks vertically on mobile/portrait orientation
- Location search via Mapbox Geocoding API
- Click coordinates to toggle display of latitude/longitude lines

### Portal View (`hole.html`)

A single globe with a ragged portal revealing the antipode beneath.

- Tap inside the portal to "fall through" and swap views
- Drag the portal edge to resize
- Spinning animation on load

## Development

No build system required — this is a static HTML site.

```bash
# Start local server
python3 -m http.server 8000

# Open in browser
open http://localhost:8000
```

## Deployment

Push to the `master` branch for GitHub Pages hosting.

## Dependencies

All loaded via CDN:

- [Mapbox GL JS v3.3.0](https://docs.mapbox.com/mapbox-gl-js/) — 3D globe rendering
- [Turf.js v7](https://turfjs.org/) — Geographic calculations
- Mapbox Geocoding API — Location search

## License

MIT
