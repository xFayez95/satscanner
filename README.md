# SatScanner (DreamOS)

Hosting repo for the **SatScanner** DreamOS `.deb` package, one-line installer, and update info.

- **`.deb` package** → uploaded to **GitHub Releases** (fixed name `satscanner-dreamos.deb`).
- **installer / version.json / changelog** → served from **GitHub Pages** (`docs/` folder).

## Stable links

| Purpose | URL |
|---------|-----|
| Installer | `https://xfayez95.github.io/satscanner/installer.sh` |
| Update info | `https://xfayez95.github.io/satscanner/version.json` |
| Changelog | `https://xfayez95.github.io/satscanner/changelog.txt` |
| Latest package | `https://github.com/xFayez95/satscanner/releases/latest/download/satscanner-dreamos.deb` |

## One-time setup

URLs are already configured for **github.com/xFayez95** (Pages host `xfayez95.github.io`).

1. Create a repo named **`satscanner`** under your account and push this folder's contents.
2. **Settings → Pages** → Source: *Deploy from a branch*, Branch: `main`, Folder: `/docs` → Save.

## User install command

```sh
wget -O - https://xfayez95.github.io/satscanner/installer.sh | sh
```

## Publishing a new version

The build repo has a helper that keeps `docs/version.json` + `docs/changelog.txt` in sync with the plugin's `VERSION` and stages the `.deb` with the fixed name:

```sh
python3 publish_satscanner_release.py            # uses newest built .deb
```

Then:
1. Create a GitHub **Release** (tag e.g. `v1.4.0`).
2. Upload `release/satscanner-dreamos.deb` (fixed name — never changes).
3. Commit & push the `docs/` changes.

Keeping the `.deb` name constant means the installer and in-plugin update check URLs never change.

## In-plugin update check (planned)

When SatScanner opens it will fetch `version.json`, compare `latest_version` against the on-screen plugin version, and offer to download `download_url` + `dpkg -i` if newer. `version.json` already carries every field that needs.

## Notes for old DreamOS images

- The installer tries `wget --no-check-certificate` then `curl -k` (many boxes have a wrong RTC / outdated CA bundle).
- GitHub Pages caches for a few minutes, so `version.json` changes propagate with a short delay.
