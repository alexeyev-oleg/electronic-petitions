# G.E.S.H.E.R. brand assets

**Official design source (do not invent — sync from here):**

```
/Users/duck/Pictures/Projects/gesher/
```

| File | Content |
|------|---------|
| `file_0000000049c471f48165cddb29c6d7b6.png` | Brand guide — logo, colors `#2B2B2B` / `#C6643C`, mini icon **G.** |
| `ChatGPT Image … 11_41_56 (1).png` | Public website mockup |
| `ChatGPT Image … 11_41_57 (2).png` | Mobile app mockup (6 screens) |

## Colors (from brand guide)

| Token | Hex |
|-------|-----|
| Graphite | `#2B2B2B` |
| Terracotta | `#C6643C` |

## App launcher icon

Mini-version **G.** (white rounded square, graphite G, terracotta dot) — cropped from brand guide.

```bash
python3 scripts/generate-gesher-app-icon.py
python3 scripts/apply-android-launcher-icons.py
```

Override design path:

```bash
GESHER_DESIGN_DIR=/path/to/gesher python3 scripts/generate-gesher-app-icon.py
```

Copies of source PNGs are kept in `source/` for reproducible builds.
