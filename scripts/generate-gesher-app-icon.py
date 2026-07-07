#!/usr/bin/env python3
"""Generate 1024x1024 G.E.S.H.E.R. launcher icon PNG for Flutter apps."""

from __future__ import annotations

import struct
import zlib
from pathlib import Path

GRAPHITE = (0x2B, 0x2B, 0x2B)
TERRACOTTA = (0xC6, 0x64, 0x3C)
WHITE = (0xFF, 0xFF, 0xFF)


def _chunk(tag: bytes, data: bytes) -> bytes:
    crc = zlib.crc32(tag + data) & 0xFFFFFFFF
    return struct.pack('>I', len(data)) + tag + data + struct.pack('>I', crc)


def write_png(path: Path, width: int, height: int, rgba_pixels: bytes) -> None:
    raw = b''.join(
        b'\x00' + rgba_pixels[y * width * 4 : (y + 1) * width * 4]
        for y in range(height)
    )
    compressed = zlib.compress(raw, 9)
    ihdr = struct.pack('>IIBBBBB', width, height, 8, 6, 0, 0, 0)
    png = (
        b'\x89PNG\r\n\x1a\n'
        + _chunk(b'IHDR', ihdr)
        + _chunk(b'IDAT', compressed)
        + _chunk(b'IEND', b'')
    )
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(png)


def inside_rounded_rect(x: int, y: int, size: int, radius: int) -> bool:
    if x < 0 or y < 0 or x >= size or y >= size:
        return False
    r = radius
    if x < r and y < r:
        return (x - r) ** 2 + (y - r) ** 2 <= r ** 2
    if x >= size - r and y < r:
        return (x - (size - r - 1)) ** 2 + (y - r) ** 2 <= r ** 2
    if x < r and y >= size - r:
        return (x - r) ** 2 + (y - (size - r - 1)) ** 2 <= r ** 2
    if x >= size - r and y >= size - r:
        return (x - (size - r - 1)) ** 2 + (y - (size - r - 1)) ** 2 <= r ** 2
    return True


def draw_icon(size: int = 1024) -> bytes:
    pixels = bytearray(size * size * 4)
    radius = int(size * 0.18)
    cx = int(size * 0.38)
    cy = int(size * 0.52)
    dot_x = int(size * 0.72)
    dot_y = int(size * 0.72)
    dot_r = int(size * 0.055)

    for y in range(size):
        for x in range(size):
            i = (y * size + x) * 4
            if not inside_rounded_rect(x, y, size, radius):
                pixels[i : i + 4] = (*GRAPHITE, 0)
                continue

            pixels[i : i + 4] = (*GRAPHITE, 255)

            # Stylized G stem and bar
            if (
                abs(x - cx) <= int(size * 0.09)
                and int(size * 0.28) <= y <= int(size * 0.76)
            ) or (
                int(size * 0.28) <= x <= int(size * 0.58)
                and abs(y - int(size * 0.28)) <= int(size * 0.05)
            ) or (
                int(size * 0.42) <= x <= int(size * 0.58)
                and abs(y - int(size * 0.52)) <= int(size * 0.05)
            ):
                pixels[i : i + 4] = (*WHITE, 255)

            if (x - dot_x) ** 2 + (y - dot_y) ** 2 <= dot_r ** 2:
                pixels[i : i + 4] = (*TERRACOTTA, 255)

    return bytes(pixels)


def main() -> None:
    root = Path(__file__).resolve().parents[1]
    png_bytes = draw_icon()
    targets = [
        root / 'apps/resident_app/assets/brand/app_icon.png',
        root / 'apps/inspector_app/assets/brand/app_icon.png',
    ]
    for target in targets:
        write_png(target, 1024, 1024, png_bytes)
        print(f'Wrote {target}')


if __name__ == '__main__':
    main()
