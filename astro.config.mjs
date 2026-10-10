// @ts-check
import { defineConfig, fontProviders } from 'astro/config';

// Fonts are self-hosted from src/fonts (latin subsets, variable axes, OFL).
export default defineConfig({
  site: 'https://ahmedzein.dev',
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
  ],
});
