# ahmedzein.dev

Personal site of Ahmed Zein, Senior Mobile Engineer. Built with [Astro](https://astro.build) as a static site and deployed to GitHub Pages.

The previous Flutter-web version of the site lives on the `flutter-legacy` branch.

## Develop

```bash
npm install
npm run dev        # http://localhost:4321
npm run build      # static output in dist/
npm run preview    # serve the build locally
```

Node 22.12 or newer.

## Where things are

| Path | What |
| --- | --- |
| `src/data/site.ts` | All content: profile, projects, experience, packages |
| `src/components/` | Page sections |
| `src/pages/work/[slug].astro` | Case study pages, one per flagship project |
| `src/styles/global.css` | Design tokens and styles (dark first, light theme included) |
| `src/scripts/site.ts` | Small enhancements: status island, route rail, stacking cards, copy, quick views |
| `src/fonts/` | Self-hosted Hubot Sans, Mona Sans and Martian Mono (SIL OFL, licences included) |

To add a project, add an entry to `flagships` or `moreWork` in `src/data/site.ts` and put its images in `src/assets/work/`. Images are resized and converted to AVIF/WebP at build time, and their metadata is stripped.

## Deploy

`.github/workflows/deploy.yml` builds on every push to `main`, and once a day so the pub.dev numbers stay current. In the repository settings, set **Pages → Source** to **GitHub Actions**. The custom domain comes from `public/CNAME`.
