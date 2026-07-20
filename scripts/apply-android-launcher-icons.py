#!/usr/bin/env python3
"""Apply G.E.S.H.E.R. brand launcher icons to a Flutter Android app."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

try:
    from PIL import Image
except ImportError as exc:  # pragma: no cover
    raise SystemExit('Pillow is required: pip install pillow') from exc

LEGACY_SIZES = {
    'mipmap-mdpi': 48,
    'mipmap-hdpi': 72,
    'mipmap-xhdpi': 96,
    'mipmap-xxhdpi': 144,
    'mipmap-xxxhdpi': 192,
}

FOREGROUND_SIZES = {
    'mipmap-mdpi': 108,
    'mipmap-hdpi': 162,
    'mipmap-xhdpi': 216,
    'mipmap-xxhdpi': 324,
    'mipmap-xxxhdpi': 432,
}

ADAPTIVE_ICON_XML = """<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
  <background android:drawable="@color/ic_launcher_background"/>
  <foreground android:drawable="@mipmap/ic_launcher_foreground"/>
</adaptive-icon>
"""


def resize_icon(source: Path, size: int) -> Image.Image:
    with Image.open(source) as image:
        rgba = image.convert('RGBA')
        return rgba.resize((size, size), Image.Resampling.LANCZOS)


def resize_adaptive_foreground(source: Path, canvas_size: int) -> Image.Image:
    """Fit icon into Android adaptive-icon safe zone (66/108 of canvas)."""
    safe_size = max(1, round(canvas_size * 66 / 108))
    icon = resize_icon(source, safe_size)
    canvas = Image.new('RGBA', (canvas_size, canvas_size), (0, 0, 0, 0))
    offset = (canvas_size - safe_size) // 2
    canvas.paste(icon, (offset, offset), icon)
    return canvas


def write_png(image: Image.Image, target: Path) -> None:
    target.parent.mkdir(parents=True, exist_ok=True)
    image.save(target, format='PNG', optimize=True)


def ensure_launcher_background_color(colors_xml: Path) -> None:
    marker = 'ic_launcher_background'
    content = colors_xml.read_text(encoding='utf-8')
    if marker in content:
        return
    insert = '    <color name="ic_launcher_background">#FFFFFF</color>\n'
    if '</resources>' not in content:
        raise ValueError(f'Unexpected colors.xml format: {colors_xml}')
    colors_xml.write_text(
        content.replace('</resources>', f'{insert}</resources>'),
        encoding='utf-8',
    )


def apply_icons(app_dir: Path) -> None:
    root = Path(__file__).resolve().parents[1]
    shared_png = root / 'apps/resident_app/assets/brand/app_icon.png'
    source = app_dir / 'assets/brand/app_icon.png'
    if not source.is_file() and shared_png.is_file():
        source = shared_png
    if not source.is_file():
        raise FileNotFoundError(
            f'Missing brand icon: {source}. Run scripts/generate-gesher-app-icon.py first.',
        )

    res_dir = app_dir / 'android/app/src/main/res'
    colors_xml = res_dir / 'values/colors.xml'
    ensure_launcher_background_color(colors_xml)

    for folder, size in LEGACY_SIZES.items():
        write_png(resize_icon(source, size), res_dir / folder / 'ic_launcher.png')

    for folder, size in FOREGROUND_SIZES.items():
        write_png(
            resize_adaptive_foreground(source, size),
            res_dir / folder / 'ic_launcher_foreground.png',
        )

    adaptive_dir = res_dir / 'mipmap-anydpi-v26'
    adaptive_dir.mkdir(parents=True, exist_ok=True)
    (adaptive_dir / 'ic_launcher.xml').write_text(ADAPTIVE_ICON_XML, encoding='utf-8')

    print(f'Applied launcher icons for {app_dir.name}')


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        'app_dir',
        nargs='*',
        type=Path,
        help='Flutter app directories (default: resident_app and inspector_app)',
    )
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    app_dirs = args.app_dir or [
        root / 'apps/resident_app',
        root / 'apps/inspector_app',
    ]

    for app_dir in app_dirs:
        apply_icons(app_dir.resolve())

    return 0


if __name__ == '__main__':
    sys.exit(main())
