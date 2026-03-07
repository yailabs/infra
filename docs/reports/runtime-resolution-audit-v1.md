# Runtime Resolution Audit v1

Generated: 2026-03-07T10:56:27Z

| repo | file:line | class | severity | recommended_action |
|---|---|---|---|---|
| yai-cli | `yai-cli/docs/development/layout-migration.md:59` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:60` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:61` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:62` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:63` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:64` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:65` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:68` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:69` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:70` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:71` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:72` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:73` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:74` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:75` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:76` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:77` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:78` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:79` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:80` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:81` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:82` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:83` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/docs/development/layout-migration.md:212` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-cli | `yai-cli/src/watch/watch.c:127` | process_shell | P1 | Replace shell side-effects with direct API/system calls where possible. |
| yai-cli | `yai-cli/src/term/pager.c:86` | process_shell | P1 | Replace shell side-effects with direct API/system calls where possible. |
| yai-cli | `yai-cli/src/app/lifecycle.c:87` | binary_exec | P1 | Use canonical binary resolver; remove local fallback lists. |
| yai | `yai/runtime-protocol/Makefile:12` | repo_relative_runtime | P1 | Move discovery into canonical resolver with deploy_mode gating. |
| yai | `yai/kernel/Makefile:53` | repo_relative_runtime | P1 | Move discovery into canonical resolver with deploy_mode gating. |
| yai | `yai/root/Makefile:38` | repo_relative_runtime | P1 | Move discovery into canonical resolver with deploy_mode gating. |
| yai | `yai/engine/Makefile:29` | repo_relative_runtime | P1 | Move discovery into canonical resolver with deploy_mode gating. |
| yai | `yai/docs/program/23-runbooks/root-hardening.md:138` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/root-hardening.md:139` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/root-hardening.md:140` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/mind-redis-stm.md:105` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/mind-redis-stm.md:106` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/mind-redis-stm.md:107` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/mind-redis-stm.md:108` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/mind-redis-stm.md:109` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/kernel-sovereignty.md:116` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/kernel-sovereignty.md:117` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/docs/program/23-runbooks/kernel-sovereignty.md:118` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai | `yai/boot/src/bootstrap.c:29` | binary_exec | P1 | Use canonical binary resolver; remove local fallback lists. |
| yai-infra | `yai-infra/tools/validate/runtime_path_authority.sh:26` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-infra | `yai-infra/tools/validate/runtime_path_authority.sh:27` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-infra | `yai-infra/tools/bin/yai-runtime-resolution-audit:13` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-infra | `yai-infra/tools/bin/yai-runtime-resolution-audit:65` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-infra | `yai-infra/docs/reports/runtime-resolution-convergence-v1.md:47` | absolute_path | P0 | Replace with SDK runtime/install resolver API. |
| yai-infra | `yai-infra/tools/bin/yai-runtime-resolution-audit:66` | repo_relative_runtime | P1 | Move discovery into canonical resolver with deploy_mode gating. |
| yai-infra | `yai-infra/tools/validate/runtime_path_authority.sh:28` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai-infra | `yai-infra/tools/validate/runtime_path_authority.sh:29` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai-infra | `yai-infra/tools/bin/yai-runtime-resolution-audit:15` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai-infra | `yai-infra/tools/bin/yai-runtime-resolution-audit:67` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai-infra | `yai-infra/docs/reports/runtime-resolution-convergence-v1.md:31` | process_kill | P0 | Use pidfile/control-endpoint shutdown; keep pkill only as documented fallback. |
| yai-infra | `yai-infra/tools/bin/yai-runtime-resolution-audit:68` | process_shell | P1 | Replace shell side-effects with direct API/system calls where possible. |
| yai-infra | `yai-infra/tools/bin/yai-runtime-resolution-audit:69` | binary_exec | P1 | Use canonical binary resolver; remove local fallback lists. |
