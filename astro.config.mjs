// @ts-check
import { defineConfig, fontProviders } from 'astro/config';

// Fonts are self-hosted from src/fonts (latin subsets, variable axes, OFL).
export default defineConfig({
  site: 'https://ahmedzein.dev',
  // The dev toolbar only shows on the local dev server; off, so reviews see the page as published.
  devToolbar: { enabled: false },
  fonts: [
    {
      provider: fontProviders.local(),
      name: 'Hubot Sans',
      cssVariable: '--font-display',
      fallbacks: ['system-ui', 'sans-serif'],
      options: {
        variants: [
          {
            src: ['./src/fonts/hubot-sans-latin-var.woff2'],
            weight: '600 800',
            stretch: '100% 125%',
            style: 'normal',
          },
        ],
      },
    },
    {
      provider: fontProviders.local(),
      name: 'Mona Sans',
      cssVariable: '--font-body',
      fallbacks: ['system-ui', 'sans-serif'],
      options: {
        variants: [
          { src: ['./src/fonts/mona-sans-latin-var.woff2'], weight: '400 600', style: 'normal' },
        ],
      },
    },
    {
      provider: fontProviders.local(),
      name: 'Martian Mono',
      cssVariable: '--font-mono',
      fallbacks: ['ui-monospace', 'monospace'],
      options: {
        variants: [
          {
            src: ['./src/fonts/martian-mono-latin-var.woff2'],
            weight: '400 500',
            stretch: '87.5%',
            style: 'normal',
          },
        ],
      },
    },
    // The Arabic pages (/ar/). Arabic letters only (subset and unicode range), and no fallbacks of their
    // own: global.css lists them before the Latin fonts, so Arabic takes these and Latin words (Flutter,
    // Taggo) still take Hubot Sans and Mona Sans. Fetched from Google Fonts at build and served from here.
    {
      provider: fontProviders.google(),
      name: 'Noto Kufi Arabic',
      cssVariable: '--font-ar-display',
      weights: ['500 800'],
      styles: ['normal'],
      subsets: ['arabic'],
      fallbacks: [],
      optimizedFallbacks: false,
    },
    {
      provider: fontProviders.google(),
      name: 'IBM Plex Sans Arabic',
      cssVariable: '--font-ar-body',
      weights: [400, 500, 600],
      styles: ['normal'],
      subsets: ['arabic'],
      fallbacks: [],
      optimizedFallbacks: false,
    },
  ],
});
