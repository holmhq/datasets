# holm datasets

Public flat-file datasets for Holm.

## Geo Country

Current country-level IP mapping artifacts:

- `geo/country/latest/ip2country-v4.tsv.gz`
- `geo/country/latest/ip2country-v6.tsv.gz`
- `geo/country/latest/manifest.json`

These files are consumed by:

- `holm dataset geo-country sync`
- `holm dataset geo-country source`

Default URLs expected by Holm (repo name should be `datasets`):

- `https://raw.githubusercontent.com/holmhq/datasets/main/geo/country/latest/ip2country-v4.tsv.gz`
- `https://raw.githubusercontent.com/holmhq/datasets/main/geo/country/latest/ip2country-v6.tsv.gz`

## Source and License

- Upstream: IPtoASN
- License: PDDL v1.0 (Public Domain Dedication and License)
- Upstream endpoints:
  - `https://iptoasn.com/data/ip2country-v4.tsv.gz`
  - `https://iptoasn.com/data/ip2country-v6.tsv.gz`
