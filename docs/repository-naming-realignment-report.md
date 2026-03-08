# Repository Naming Realignment Report (`infra`)

Date: 2026-03-08

## Scope
This patch realigns repository naming references after the rename wave that was already completed on GitHub/local/remotes.

Applied mapping in this repository:
- `yai-labs/yai-infra` -> `yai-labs/infra`
- `yai-labs/yai-law` -> `yai-labs/law`
- `yai-labs/yai-sdk` -> `yai-labs/sdk`
- `yai-labs/yai-cli` -> `yai-labs/cli`
- `yai-labs/yai-ops` -> `yai-labs/ops`
- `yai-labs/yai-studio` -> `yai-labs/studio`

## Areas updated
- `README.md` (repo identity, platform context, reusable workflow example)
- `.github/workflows/*` (reusable workflow defaults/examples)
- `docs/standards/*` and `docs/tooling/*` (repo references and consumption examples)
- `governance/templates/github/*` (template examples and cross-repo pointers)
- `tools/*` docs/messages/default repo URLs that referenced renamed repositories
- `migration/*` planning and mapping docs where old repository names were presented as active references

## Decision on legacy paths/examples/tool outputs
- Kept compatibility markers and compatibility paths where they are part of active tooling contracts:
  - `.github/.managed-by-yai-infra` marker name retained intentionally (compatibility with existing sync/verify tooling).
  - `deps/yai-cli.ref` and `deps/yai-law` references retained where used as compatibility path contracts in release/pin tooling.
- Updated active GitHub repository identity references and reusable workflow `uses:` targets to new repository names.

## Residual legacy intentionally kept
- Historical inventory snapshots under `migration/inventory/snapshots/*` remain unchanged to preserve historical provenance.
- Compatibility aliases and legacy command names (for example `yai-specs-sync`) remain where explicitly marked deprecated/compatibility.

## Impact summary
- Active cross-repo links and examples now point to current repository identities under `yai-labs`.
- Reusable workflow consumption examples now use `yai-labs/infra`.
- Current docs no longer present `yai-infra`, `yai-cli`, `yai-law`, `yai-ops`, `yai-sdk`, `yai-studio` as current GitHub repo identities.
- No governance/workflow redesign was introduced; changes are naming-alignment only.
