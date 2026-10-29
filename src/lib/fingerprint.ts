import { createHash } from 'node:crypto';
import { readFileSync } from 'node:fs';

/**
 * A file in public/ with the first 8 hex of its SHA-1 as ?v=, so a changed file is a new URL: browsers
 * and LinkedIn keep an image by its URL, even after the file behind it changes.
 */
export const fingerprinted = (path: string) =>
  `${path}?v=${createHash('sha1').update(readFileSync(`public${path}`)).digest('hex').slice(0, 8)}`;
