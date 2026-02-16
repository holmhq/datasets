#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

mkdir -p geo/country/latest

curl -fsSL https://iptoasn.com/data/ip2country-v4.tsv.gz -o geo/country/latest/ip2country-v4.tsv.gz
curl -fsSL https://iptoasn.com/data/ip2country-v6.tsv.gz -o geo/country/latest/ip2country-v6.tsv.gz

gzip -t geo/country/latest/ip2country-v4.tsv.gz
gzip -t geo/country/latest/ip2country-v6.tsv.gz

v4=geo/country/latest/ip2country-v4.tsv.gz
v6=geo/country/latest/ip2country-v6.tsv.gz
v4_sha=$(sha256sum "$v4" | awk '{print $1}')
v6_sha=$(sha256sum "$v6" | awk '{print $1}')
v4_bytes=$(wc -c < "$v4" | tr -d ' ')
v6_bytes=$(wc -c < "$v6" | tr -d ' ')
gen=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

jq -n \
  --arg generated_at_utc "$gen" \
  --arg source_v4 "https://iptoasn.com/data/ip2country-v4.tsv.gz" \
  --arg source_v6 "https://iptoasn.com/data/ip2country-v6.tsv.gz" \
  --arg v4_file "geo/country/latest/ip2country-v4.tsv.gz" \
  --arg v6_file "geo/country/latest/ip2country-v6.tsv.gz" \
  --arg v4_sha256 "$v4_sha" \
  --arg v6_sha256 "$v6_sha" \
  --argjson v4_bytes "$v4_bytes" \
  --argjson v6_bytes "$v6_bytes" \
  '{
    generated_at_utc: $generated_at_utc,
    dataset: "ip2country",
    format: "tsv.gz",
    source: {
      provider: "IPtoASN",
      license: "PDDL v1.0",
      upstream_v4: $source_v4,
      upstream_v6: $source_v6
    },
    artifacts: {
      v4: { file: $v4_file, sha256: $v4_sha256, bytes: $v4_bytes },
      v6: { file: $v6_file, sha256: $v6_sha256, bytes: $v6_bytes }
    }
  }' > geo/country/latest/manifest.json

echo "Updated geo/country/latest"
