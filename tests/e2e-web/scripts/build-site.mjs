// Assembles the site under test into tests/e2e-web/.site without touching tracked files:
//   apps/public_web -> .site/
//   apps/admin_web  -> .site/staff/
// SITE_SRC points at a tree that contains apps/ (default: the repository root).
// Use it to run the suite against an older revision, e.g. a `git archive` extract.
// SITE_OUT (default .site) lets two runs coexist, e.g. baseline and working tree.
import { cpSync, existsSync, mkdirSync, rmSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const here = dirname(fileURLToPath(import.meta.url));
const root = resolve(here, '..');
const src = resolve(process.env.SITE_SRC || resolve(root, '..', '..'));
const out = resolve(root, process.env.SITE_OUT || '.site');

const publicWeb = resolve(src, 'apps/public_web');
const adminWeb = resolve(src, 'apps/admin_web');
for (const dir of [publicWeb, adminWeb]) {
  if (!existsSync(dir)) {
    console.error(`build-site: missing ${dir} (SITE_SRC=${src})`);
    process.exit(1);
  }
}

rmSync(out, { recursive: true, force: true });
mkdirSync(out, { recursive: true });
cpSync(publicWeb, out, { recursive: true });
cpSync(adminWeb, resolve(out, 'staff'), { recursive: true });
console.log(`build-site: ${src} -> ${out}`);
