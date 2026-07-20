#!/usr/bin/env python3
"""Sync launcher icon from official G.E.S.H.E.R. design files (no generated artwork)."""

from __future__ import annotations

import shutil
import sys
from pathlib import Path

try:
    from PIL import Image
except ImportError as exc:  # pragma: no cover
    raise SystemExit('Pillow is required: pip install pillow') from exc

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_DESIGN_DIR = Path('/Users/duck/Pictures/Projects/gesher')
DESIGN_DIR = Path(
    __import__('os').environ.get('GESHER_DESIGN_DIR', str(DEFAULT_DESIGN_DIR)),
)
BRAND_GUIDE_NAME = 'file_0000000049c471f48165cddb29c6d7b6.png'
# Mini-version "G." on white rounded square — brand guide, bottom-left panel.
ICON_CROP_BOX = (90, 720, 310, 940)
OUTPUT_SIZE = 1024
SOURCE_DIR = ROOT / 'shared/brand/source'
MASTER_PNG = ROOT / 'shared/brand/app_icon_master.png'
TARGETS = [
    ROOT / 'apps/resident_app/assets/brand/app_icon.png',
    ROOT / 'apps/inspector_app/assets/brand/app_icon.png',
]


def sync_design_sources() -> Path:
    SOURCE_DIR.mkdir(parents=True, exist_ok=True)
    if not DESIGN_DIR.is_dir():
        raise FileNotFoundError(
            f'Design folder not found: {DESIGN_DIR}\n'
            'Set GESHER_DESIGN_DIR to your gesher design directory.',
        )

    brand_guide = DESIGN_DIR / BRAND_GUIDE_NAME
    if not brand_guide.is_file():
        raise FileNotFoundError(
            f'Brand guide missing: {brand_guide}\n'
            f'Expected: {BRAND_GUIDE_NAME}',
        )

    for item in sorted(DESIGN_DIR.glob('*.png')):
        shutil.copy2(item, SOURCE_DIR / item.name)

    return brand_guide


def crop_master_icon(brand_guide: Path) -> Image.Image:
    with Image.open(brand_guide) as image:
        rgb = image.convert('RGB')
        return rgb.crop(ICON_CROP_BOX)


def write_targets(master: Image.Image) -> None:
    resized = master.resize((OUTPUT_SIZE, OUTPUT_SIZE), Image.Resampling.LANCZOS)
    MASTER_PNG.parent.mkdir(parents=True, exist_ok=True)
    resized.save(MASTER_PNG, format='PNG', optimize=True)
    for target in TARGETS:
        target.parent.mkdir(parents=True, exist_ok=True)
        resized.save(target, format='PNG', optimize=True)
        print(f'Wrote {target}')


def main() -> int:
    brand_guide = sync_design_sources()
    master = crop_master_icon(brand_guide)
    write_targets(master)
    print(f'Source: {brand_guide}')
    print(f'Crop: {ICON_CROP_BOX} (G. mini-version from brand guide)')
    return 0


if __name__ == '__main__':
    sys.exit(main())
