# Runtime Resolution Convergence Report v1

## Scope
Cross-repo refoundation pass for runtime resolution and path authority.

## Implemented

### yai-law
- Added normative pointer:
  - `docs/pointers/RUNTIME_RESOLUTION.pointer.md`
- Defined concepts: `runtime_home`, `install_root`, `workspace_root`, `control_endpoint`, deploy modes, and precedence rules.

### yai-sdk
- Extended path authority APIs in `include/yai_sdk/paths.h`:
  - runtime/install context resolution
  - deploy mode detection
  - runtime binary lookup (`boot/root/kernel/engine`)
  - root/workspace path derivation
- Reworked `src/platform/paths.c` to centralize resolver behavior and env override precedence.
- Added policy doc:
  - `docs/RUNTIME_RESOLUTION_POLICY.md`
- Added smoke test:
  - `tests/runtime_locator_smoke.c`
- Updated `Makefile` test graph to include runtime locator smoke.

### yai-cli
- Refactored `src/app/lifecycle.c`:
  - removed machine-specific absolute paths and local repo-relative binary lists
  - removed PATH mutation fallback logic
  - switched boot discovery to SDK resolver (`yai_path_boot_bin`)
  - moved stop behavior to pidfile-driven termination under runtime home (no primary `pkill -f`)

### yai-infra
- Added audit tool:
  - `tools/bin/yai-runtime-resolution-audit`
- Added anti-regression check:
  - `tools/validate/runtime_path_authority.sh`
- Generated audit report:
  - `docs/reports/runtime-resolution-audit-v1.md`

## Known Residuals
- `yai` runtime still contains process/bootstrap patterns that should be migrated to control-endpoint-first lifecycle control.
- `yai-ops` evidence snapshots include historical absolute paths; these are archival artifacts, not active resolution logic.
- Additional integration in `yai-cli` beyond lifecycle (watch/tool helpers) can be migrated in follow-up pass.

## Acceptance Snapshot
- Lifecycle no longer depends on hardcoded `/home/...` binary paths.
- Runtime/bin/socket discovery is now centralized in SDK resolver APIs.
- Normative + programmatic policy documents exist and are linked.
- Infra has automated scanning to prevent regression.
