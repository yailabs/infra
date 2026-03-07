#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
YAI_ROOT="${YAI_ROOT:-$(cd "$ROOT/.." && pwd)}"

fail=0

check_forbidden() {
  local repo="$1"
  local scope="$2"
  local pattern="$3"
  local label="$4"
  local base="$YAI_ROOT/$repo"

  [[ -d "$base" ]] || return 0
  if rg -n "$pattern" "$base/$scope" -S >/tmp/yai_runtime_path_check.out 2>/dev/null; then
    echo "[FAIL] $label ($repo/$scope)"
    sed -n '1,40p' /tmp/yai_runtime_path_check.out
    fail=1
  else
    echo "[OK] $label"
  fi
}

check_forbidden "yai-cli" "src" "/home/|/Users/|\.\./yai/|\.\./dist/|\.\./build/" "no hardcoded absolute or repo-relative runtime paths in CLI sources"
check_forbidden "yai-sdk" "src" "/home/|/Users/|\.\./yai/|\.\./dist/|\.\./build/" "no hardcoded absolute or repo-relative runtime paths in SDK sources"
check_forbidden "yai-cli" "src" "pkill -f" "no pkill heuristics in CLI sources"
check_forbidden "yai-sdk" "src" "pkill -f" "no pkill heuristics in SDK sources"

if [[ "$fail" -ne 0 ]]; then
  echo "runtime_path_authority: FAILED"
  exit 1
fi

echo "runtime_path_authority: ok"
