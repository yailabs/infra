# YAI Infra

YAI Infra is the delivery and governance layer of the YAI platform.

It defines the standards, automation, and enforcement tooling that keep the ecosystem aligned, reproducible, and governable across repositories.

## Platform role

`yai-law` → `yai-sdk` → `yai-cli` → `yai` → `yai-ops`

YAI Infra supports that stack with shared delivery discipline.  
It does not redefine platform law or product semantics.

## What this repository is

- shared standards
- reusable governance automation
- verification and enforcement tooling
- operational delivery support across repositories

## Design posture

- **Standards must be enforceable**
- **Automation must be reusable**
- **Delivery must be governed**
- **Drift must be visible**

## Boundaries

This repository owns governance and delivery mechanics for the ecosystem.

It does not own law (`yai-law`), systems implementation (`yai`), command surfaces (`yai-cli`), SDK interfaces (`yai-sdk`), or operational proof (`yai-ops`).

## Getting started

```bash
./tools/bin/yai-version
ls ./tools/bin
```

## Documentation

- `docs/standards/README.md`
- `docs/tooling/README.md`

## Contributing

Changes to shared enforcement should be small, scoped, and backed by verification output.