# Cross-Repo Documentation Architecture Plan

Status: Proposed (architecture-only, no migration executed)  
Audit date: March 6, 2026  
Scope: `yai-law`, `yai-sdk`, `yai-cli`, `yai` (with constrained references to `yai-ops`/`yai-infra`)

## 1. Executive Summary

La documentazione cross-repo e diventata difficile da governare per 4 cause strutturali:
- autorevolezza non sempre chiara (normativo vs informativo);
- stratificazione storica con naming legacy e path rinominati a meta;
- uso non uniforme di pointer, guide, program artifacts, generated ed evidence;
- mancanza di una grammatica di collocazione condivisa.

Direzione proposta:
- `yai-law` resta unica fonte normativa e viene rafforzato come authority repo;
- `yai-sdk` e `yai-cli` diventano repo consumer con docs locali forti ma non normative;
- `yai` viene semplificato: runtime/platform docs locali + program governance ben confinata + evidenze non inline dove non servono;
- pointer-first per tutto cio che e cross-repo o normativo;
- migrazione incrementale in PR piccole (1-2 giorni), law-first quando necessario.

## 2. Current-State Diagnosis

### 2.1 Sintesi per repo

- `yai-law`
  - Struttura normativa robusta (`foundation/`, `contracts/`, `registry/`, `schema/`, `runtime/`, `formal/`, `packs/`).
  - `docs/` usato correttamente come layer informativo.
  - Criticita: file authority chiave vuoti (`charter.md`, `compatibility-policy.md`, `deprecation-policy.md`, `publication-policy.md`, `status-model.md`).

- `yai-sdk`
  - Surface docs molto sottile (solo `docs/README.md` + `docs/SDK_SURFACE_CONTRACT.md`).
  - Buona chiarezza nel README su boundary con law.
  - Criticita: mancano guide operative locali (onboarding, upgrade pin, test/release flow, API reference navigabile).

- `yai-cli`
  - Struttura docs classica (`guide`, `reference`, `development`, `api`, `proof`).
  - Criticita: assenza README di sottocartella; alcuni reference con path normativi errati/storici; `proof` pointer punta a path non esistente.

- `yai`
  - Surface molto ricca ma stratificata e incoerente.
  - Criticita maggiori: mismatch tra struttura reale e riferimenti legacy (`docs/10-platform`, `docs/20-program`, `docs/60-guides`, `docs/60-validation`), conflitto di messaggio su governance residency, presenza di raw evidence dentro tree program/runtime docs, profondita alta.

### 2.2 Problemi rilevati con severita

| ID | Severita | Repo | Problema | Evidenza |
|---|---|---|---|---|
| P01 | HIGH | yai-law | Authority model incompleto: policy files vuoti ma dichiarati canonici | `authority/*.md` vuoti |
| P02 | HIGH | yai-cli | Reference contrattuale con path non validi/legacy (rischio drift normativo) | `docs/reference/contract.md` |
| P03 | HIGH | yai-cli | Proof pointer su path non esistente | `docs/proof/PROOF_POINTER.md` |
| P04 | HIGH | yai | Oltre 100 riferimenti a path legacy non presenti | molte occorrenze `docs/10-platform`, `docs/20-program`, `docs/60-*` |
| P05 | HIGH | yai | Contraddizione tra messaggio “docs runtime-minimal/externalized” e volume program docs locale | `GOVERNANCE.md` vs `docs/program/**` |
| P06 | HIGH | yai | `README.md` punta a file non esistente (`docs/00-dashboard.md`) | `README.md` |
| P07 | HIGH | cross-repo | Boundary generated/evidence/program non uniforme; rischio “docs forest” | `yai/docs/program/**/evidence`, `_generated/` |
| P08 | MEDIUM | yai-cli | Nessun README nei sottolivelli docs principali (`guide/reference/development/...`) | struttura `docs/*` |
| P09 | MEDIUM | yai-sdk | Docs troppo sottili per consumer/maintainer reali | solo 2 file in `docs/` |
| P10 | MEDIUM | yai | Profondita e numerazione mista (`21-rfc`, `22-adr`, ecc.) con semantica non autoesplicativa | `docs/program/*` |
| P11 | MEDIUM | yai | File legacy esplicito (`README-legacy-60-guides.md`) che perpetua naming vecchio | `docs/developer/guides/README-legacy-60-guides.md` |
| P12 | MEDIUM | yai | Link cross-repo a `yai-ops` non sempre allineati al path reale evidence | pointer/proof riferimenti |
| P13 | LOW | yai-law | `docs/pointers/` senza README locale | navigazione |
| P14 | LOW | yai-cli/yai | Mix di “pointer/policy/guide/reference/program” senza convenzione comune dei nomi | naming eterogeneo |

## 3. Documentation Taxonomy

| Categoria | Scopo | Cosa puo contenere | Cosa NON deve contenere | Owner naturale | Stabilita attesa | Duplicazione |
|---|---|---|---|---|---|---|
| Normative | Definire regole/contratti vincolanti | contracts, registries, schema, foundation law, runtime law, deprecation/compat policy vincolanti | tutorial, opinioni, how-to locale | `yai-law` | Alta | No mirror semantico; solo pointer |
| Architecture | Spiegare disegno tecnico e tradeoff implementativi | overview, component boundaries, law bridge, traceability map | testo normativo duplicato | `yai` (runtime), `yai-cli`/`yai-sdk` solo locale | Media/Alta | Solo estratti locali + pointer |
| Developer Guides | Onboarding e workflow dev | build, test, debug, contribution flow | policy normativa, evidence raw | repo locale (`yai`, `yai-cli`, `yai-sdk`) | Media | Duplicazione minima; preferire standard condivisi via pointer |
| Operator/Runbooks | Esecuzione operativa e recovery | runbook di deployment/incident/gate execution | design decision records | `yai` (platform), `yai-cli` (CLI operations) | Media | No copy tra repo; pointer ammesso |
| Program/Governance | Decisioni e governance delivery | RFC, ADR, roadmap, milestone program docs | contratti normativi | `yai` (program runtime), `yai-infra` (standard comuni) | Media | No duplicate full-text |
| Reference | Schede tecniche e mappe navigazione | command reference, API contract summary, compatibility matrix | normative source clone | repo consumer + `yai-law` per source map | Alta | Pointer-first |
| Generated | Artifact prodotti da tool | graph json, lock/index generati | editing manuale, narrative | repo che genera artifact | Bassa/derivata | Mai duplicare a mano |
| Proof/Evidence | Prove esecutive e output gate | manifest, report, log/output pack | manuale operativo generale | `yai-ops` primario, `yai` solo index/pointer o sample minimo | Media/Bassa | No copia massiva |
| Migration/Deprecation | Transizione controllata | old->new map, deprecation notice, sunset date | documentazione evergreen | repo locale + `yai-infra` per standard | Bassa/temporanea | Consentita se scoped e datata |
| Pointers/Indexes | Navigazione e boundary | README indice, `*.pointer.md`, policy pointer | contenuto sostanziale duplicato | tutti i repo | Alta | Pointer-only |

## 4. Cross-Repo Boundaries

| Document concern | Authoritative repo | Allowed mirrors? | Allowed pointers? | Notes |
|---|---|---|---|---|
| Foundation axioms/invariants/boundaries | yai-law | No | Yes | Mai ridefinire fuori da law |
| Protocol/control/vault/providers contracts | yai-law | No | Yes | CLI/SDK solo consumption docs |
| Registry commands/primitives/artifacts schemas | yai-law | No | Yes | Nei consumer: reference sintetica + link |
| Publication/deprecation/status policy di law | yai-law | No | Yes | Da completare in `authority/` |
| SDK API/ABI compatibility contract | yai-sdk | Summary mirror in `yai-cli`/`yai` ammesso | Yes | Mirror solo informativo e corto |
| CLI UX/help behavior e command usage | yai-cli | Summary in `yai` ammesso | Yes | Nessuna semantica normativa duplicata |
| Runtime architecture implementation notes | yai | No full mirror | Yes | Boundaries legali sempre verso law |
| Program ADR/RFC/runbooks runtime delivery | yai | No full mirror | Yes | Standard di processo in `yai-infra` |
| Governance standards cross-repo (template/process) | yai-infra | No full mirror | Yes | Repo product consumano via pointer |
| Evidence bundles complete | yai-ops | No | Yes | In repo product: index minimo/pointer |
| Security policy repo-specific | repo locale | No | Yes | Solo scope del repo |
| CONTRIBUTING/CODE_OF_CONDUCT repo-specific | repo locale | No | N/A | Coerenza formale, non centralizzare forzatamente |

### Regole hard boundary

- Nessun documento normativo di `yai-law` viene copiato in `yai-sdk`, `yai-cli`, `yai`, `yai-ops`.
- I repo consumer possono avere solo:
  - pointer,
  - sintesi locale orientata al proprio utente,
  - note di implementazione locale.
- Se una frase usa “MUST/SHALL” su semantica contrattuale globale, deve vivere in `yai-law`.

## 5. Target Architecture By Repo

### 5.1 `yai-law` target

Top-level model:
- Normative corpus fuori da `docs/` (gia corretto)
- `docs/` solo informative/pointer/policy di lettura
- `authority/` completo e non placeholder

Proposta struttura:

```text
yai-law/
  authority/
    README.md
    charter.md
    status-model.md
    publication-policy.md
    compatibility-policy.md
    deprecation-policy.md
  foundation/
  contracts/
  runtime/
  registry/
  schema/
  formal/
  packs/
  vectors/
  docs/
    README.md
    pointers/
      README.md
      SPEC_MAP.pointer.md
      REGISTRY.pointer.md
    policy/
      README.md
```

Decisioni:
- mantenere minimale `docs/`;
- rendere `authority/*` completo (niente file vuoti);
- evitare espansione narrativa nel repo normativo.

### 5.2 `yai-sdk` target

Obiettivo: aumentare forza documentativa senza gonfiare.

Proposta struttura:

```text
yai-sdk/
  docs/
    README.md
    guide/
      README.md
      quickstart.md
      integration-patterns.md
      error-model.md
    reference/
      README.md
      sdk-surface-contract.md
      api-modules.md
      compatibility-matrix.md
      law-boundary.pointer.md
    development/
      README.md
      build-test-release.md
      pin-upgrade-playbook.md
    pointers/
      yai-law.pointer.md
```

Decisioni:
- `SDK_SURFACE_CONTRACT.md` resta cuore reference ma rinominato in kebab-case;
- introdurre guide brevi utili a consumer esterni;
- nessuna policy normativa locale.

### 5.3 `yai-cli` target

Obiettivo: separazione netta `guide` / `reference` / `development` / `evidence-pointer`.

Proposta struttura:

```text
yai-cli/
  docs/
    README.md
    guide/
      README.md
      install.md
      quickstart.md
      commands.md
      output.md
      troubleshooting.md
    reference/
      README.md
      contract-boundary.md
      governance-surface.md
      bundle-model.md
      sdk-boundary.pointer.md
      law-boundary.pointer.md
    development/
      README.md
      build.md
      testing.md
      release.md
      repo-tooling.md
      pinning.md
      migration/
        README.md
        layout-migration-2026.md
    pointers/
      README.md
      evidence.pointer.md
      program.pointer.md
    api/
      README.md
      C_MAINPAGE.md
```

Decisioni:
- `docs/proof/` diventa `docs/pointers/evidence.pointer.md`;
- `layout-migration.md` confinato in `development/migration/` con data/versione;
- `reference/contract` corretto e ridotto a boundary doc + link canonici.

### 5.4 `yai` target

Obiettivo: ridurre complessita senza perdere ricchezza.

Proposta struttura:

```text
yai/
  docs/
    README.md
    platform/
      README.md
      architecture/
        README.md
        overview.md
        runtime-model.md
        law-bridge.md
        traceability.md
        components/
          README.md
          root.md
          kernel.md
          engine.md
          boot.md
          mind-overview.md
          mind-boundaries.md
      interfaces/
        README.md
        law-contracts.pointer.md
        law-formal.pointer.md
    developer/
      README.md
      onboarding/
        README.md
        quickstart.md
      guides/
        README.md
        build.md
        testing.md
        debugging.md
        release.md
        workspace-flow.md
    program/
      README.md
      rfc/
      adr/
      runbooks/
      milestones/
      policies/
      migration/
    governance/
      README.md
      foundation.md
      governance.md
      data-policy.md
    pointers/
      README.md
      official.pointer.md
      collateral.pointer.md
      evidence.pointer.md
    generated/
      README.md
      *.json
```

Decisioni forti:
- rimuovere numerazione prefissata di cartelle (`21-rfc`, `22-adr`, ...), mantenendola solo nei file quando serve tracciabilita;
- eliminare riferimenti `10-platform/20-program/60-*` dal corpus vivo;
- confinare raw evidence fuori dal percorso primario docs runtime (pointer verso `yai-ops` + eventuale sample minimale);
- allineare `GOVERNANCE.md` con stato reale (niente messaggi contraddittori).

## 6. Old-to-New Migration Map

Nota: mapping proposto, non eseguito.

### 6.1 `yai-law`

| Current | Destination | Action | Rationale |
|---|---|---|---|
| `authority/charter.md` (vuoto) | `authority/charter.md` | KEEP+FILL | file corretto ma incompleto |
| `authority/status-model.md` (vuoto) | `authority/status-model.md` | KEEP+FILL | necessario per status taxonomy |
| `authority/publication-policy.md` (vuoto) | `authority/publication-policy.md` | KEEP+FILL | policy publication mancante |
| `authority/compatibility-policy.md` (vuoto) | `authority/compatibility-policy.md` | KEEP+FILL | regole compatibilita esplicite |
| `authority/deprecation-policy.md` (vuoto) | `authority/deprecation-policy.md` | KEEP+FILL | deprecation governance assente |
| `docs/pointers/` senza README | `docs/pointers/README.md` | ADD | orientamento minimo |
| `docs/pointers/SPEC_MAP.pointer.md` | `docs/pointers/SPEC_MAP.pointer.md` | KEEP | pointer utile |

### 6.2 `yai-sdk`

| Current | Destination | Action | Rationale |
|---|---|---|---|
| `docs/SDK_SURFACE_CONTRACT.md` | `docs/reference/sdk-surface-contract.md` | MOVE+RENAME | semantica reference |
| `docs/README.md` | `docs/README.md` | KEEP+REWRITE | diventare vero indice |
| N/A | `docs/guide/quickstart.md` | ADD | onboarding consumer |
| N/A | `docs/guide/integration-patterns.md` | ADD | pattern pratici senza normativa |
| N/A | `docs/guide/error-model.md` | ADD | mapping errori/ritorni operativi |
| N/A | `docs/reference/api-modules.md` | ADD | mappa moduli pubblici |
| N/A | `docs/reference/compatibility-matrix.md` | ADD | vista veloce compat API/ABI |
| N/A | `docs/reference/law-boundary.pointer.md` | ADD | boundary law esplicito |
| N/A | `docs/development/build-test-release.md` | ADD | manutenibilita maintainer |
| N/A | `docs/development/pin-upgrade-playbook.md` | ADD | disciplina upgrade pin |

### 6.3 `yai-cli`

| Current | Destination | Action | Rationale |
|---|---|---|---|
| `docs/reference/contract.md` | `docs/reference/contract-boundary.md` | MOVE+REWRITE | oggi contiene path errati |
| `docs/reference/governance.md` | `docs/reference/governance-surface.md` | MOVE+RENAME | chiarire scope |
| `docs/reference/bundle.md` | `docs/reference/bundle-model.md` | MOVE+RENAME | naming consistente |
| `docs/proof/PROOF_POINTER.md` | `docs/pointers/evidence.pointer.md` | MOVE+REWRITE | pointer corretto verso `yai-ops/evidence/...` |
| `docs/development/layout-migration.md` | `docs/development/migration/layout-migration-2026.md` | MOVE+DEPRECATE | storico, non evergreen |
| `docs/development/specs-pinning.md` | `docs/development/pinning.md` | MOVE+RENAME | naming compatto |
| `docs/api/C_MAINPAGE.md` | `docs/api/C_MAINPAGE.md` | KEEP | file API valido |
| `docs/guide/*` | `docs/guide/*` | KEEP+ADD README | area valida ma poco orientata |
| `docs/development/*` | `docs/development/*` | KEEP+ADD README | idem |
| `docs/reference/*` | `docs/reference/*` | KEEP+ADD README | idem |
| N/A | `docs/pointers/README.md` | ADD | indice pointer |
| N/A | `docs/api/README.md` | ADD | spiegare generated/API entry |

### 6.4 `yai`

| Current | Destination | Action | Rationale |
|---|---|---|---|
| `README.md` link `docs/00-dashboard.md` | `docs/README.md` | REWRITE | elimina broken entrypoint |
| `GOVERNANCE.md` (externalized claim) | `GOVERNANCE.md` + `docs/governance/README.md` | REWRITE+SPLIT | allineare con realta |
| `FOUNDATION.md` | `docs/governance/foundation.md` (+ top-level pointer) | MOVE+POINTER | ridurre top-level dispersion |
| `DATA_POLICY.md` | `docs/governance/data-policy.md` (+ top-level pointer) | MOVE+POINTER | coerenza governance area |
| `docs/interfaces/*` | `docs/platform/interfaces/*` | MOVE | interfacce parte di platform map |
| `docs/developer/guides/README-legacy-60-guides.md` | `docs/developer/migration/legacy-60-guides.deprecated.md` | MOVE+DEPRECATE | rimuovere legacy come default |
| `docs/program/21-rfc/*` | `docs/program/rfc/*` | MOVE | eliminare numeric-folder legacy |
| `docs/program/22-adr/*` | `docs/program/adr/*` | MOVE | idem |
| `docs/program/23-runbooks/*` | `docs/program/runbooks/*` | MOVE | idem |
| `docs/program/24-milestone-packs/*` | `docs/program/milestones/*` | MOVE | semantica chiara |
| `docs/program/25-templates/*` | `docs/program/templates/*` | MOVE | semplificazione |
| `docs/program/26-policies/*` | `docs/program/policies/*` | MOVE | semplificazione |
| `docs/program/27-security/*` | `docs/program/security/*` | MOVE | semplificazione |
| `docs/_generated/*` | `docs/generated/*` | MOVE | rimuovere underscore tecnico |
| `docs/pointers/*.md` | `docs/pointers/*.pointer.md` | RENAME | formato uniforme pointer |
| `docs/program/**/evidence/**` raw logs | `yai-ops/evidence/...` (+ pointer index) | MOVE+POINTER | evitare foresta di output runtime repo |
| `docs/platform/*` riferimenti `docs/10-platform/...` | path reali `docs/platform/...` | REWRITE | pulizia link |
| `docs/program/*` riferimenti `docs/20-program/...` | path reali `docs/program/...` | REWRITE | pulizia link |
| `docs/*` riferimenti `docs/60-guides`/`docs/60-validation` | `docs/developer/...` o `yai-ops/evidence/...` | REWRITE | rimozione naming morto |

### 6.5 Regola per contenuti `deps/*`

| Current | Destination | Action | Rationale |
|---|---|---|---|
| `deps/yai-law/**` docs duplicate nei consumer | resta in `deps/` come dipendenza tecnica | KEEP (read-only) | non trattare come docs del repo host |
| riferimenti docs che puntano a path interni `deps/` non canonici | puntare a canonical path del repo autorevole + commit pin | REWRITE | chiarezza ownership |

## 7. Redundant / Obsolete Content Candidates

| Candidate | Tipo | Motivo | Rischio | Redirect/Pointer |
|---|---|---|---|---|
| `yai/docs/developer/guides/README-legacy-60-guides.md` | DEPRECATE | perpetua naming morto | basso | puntare a `docs/developer/README.md` |
| riferimenti a `docs/00-dashboard.md` in `yai/README.md` | DELETE (reference) | path inesistente | basso | `docs/README.md` |
| riferimenti `docs/10-platform`, `docs/20-program`, `docs/60-*` nel corpus vivo `yai` | DELETE/REWRITE | link rotti + confusione | medio | path target reali |
| `yai-cli/docs/proof/PROOF_POINTER.md` (path sbagliato) | REWRITE+MOVE | pointer non valido | basso | `docs/pointers/evidence.pointer.md` |
| `yai-cli/docs/reference/contract.md` path normativi errati | REWRITE | rischio decisioni su fonte sbagliata | medio | boundary doc con link corretti |
| raw output in `yai/docs/program/.../evidence/wave*/` | MOVE out + pointer | rumore nel repo runtime | medio | index verso `yai-ops/evidence/...` |
| `yai-law/authority/*.md` placeholder vuoti | FILL or TEMP DEPRECATE | falsa completezza governance | medio | se temporanei: marcare draft esplicito |

## 8. Placement And Naming Policy

### 8.1 Placement model (regole operative)

1. Nuovo contenuto normativo cross-repo nasce solo in `yai-law`.
2. Se un repo consumer deve spiegare norma, crea `*.pointer.md` + contesto locale breve.
3. Nuovo RFC/ADR di programma runtime nasce in `yai/docs/program/{rfc|adr}`.
4. Nuovo standard cross-repo (template/processo/tooling comune) nasce in `yai-infra/docs/{standards|tooling}`.
5. Nuova runbook operativa runtime nasce in `yai/docs/program/runbooks`.
6. Nuova guida utente CLI nasce in `yai-cli/docs/guide`.
7. Nuova guida consumer SDK nasce in `yai-sdk/docs/guide`.
8. Evidenze complete di gate/qualifica vivono in `yai-ops/evidence`; nei repo product solo index/pointer.
9. `docs/generated/` contiene solo output tool rigenerabili; no editing manuale.
10. Ogni cartella `docs/*` di primo livello deve avere un `README.md` con: scopo, audience, owner, cosa non mettere qui.

### 8.2 Naming policy

- Cartelle: kebab-case semantico (`runbooks`, `migration`, `compatibility-matrix`), no numerazione prefissata salvo legacy transitorio.
- File pointer: suffisso obbligatorio `.pointer.md`.
- File migration/deprecazione: includere anno o release (`*-2026.md`) e sunset.
- RFC/ADR: mantenere id nel filename (`RFC-00x-*`, `ADR-00x-*`), ma non in nome cartella.
- Generated JSON: versione esplicita nel nome (`*.v1.json`).
- Evitare nomi ambigui generici (`notes.md`, `misc.md`, `stuff.md`).

### 8.3 Promozione draft -> programma

- Draft locale in `docs/developer/drafts/` (opzionale) con owner e data.
- Promozione a `docs/program/*` solo con issue/decision linkata e reviewer designato.
- Dopo promozione, il draft resta pointer o viene rimosso.

## 9. Incremental PR Roadmap

### PR-01
- Titolo: `law: complete authority policy baseline`
- Repo: `yai-law`
- Obiettivo: eliminare placeholders authority.
- Contenuto: compilazione `authority/*.md` + allineamento README.
- Rischi: interpretazioni policy divergenti.
- Rollback: revert dei soli file authority.
- Acceptance: nessun file authority vuoto; boundary normativo esplicito.

### PR-02
- Titolo: `law: docs pointers hardening`
- Repo: `yai-law`
- Obiettivo: rafforzare layer informativo senza duplicazione.
- Contenuto: `docs/pointers/README.md`, pointer aggiuntivi a `SPEC_MAP`/`REGISTRY`.
- Rischi: minimi.
- Rollback: revert docs layer.
- Acceptance: navigazione pointer completa e coerente.

### PR-03
- Titolo: `cli: fix contract boundary references`
- Repo: `yai-cli`
- Obiettivo: eliminare path normativi errati.
- Contenuto: rewrite `docs/reference/contract*`, add README `docs/reference`.
- Rischi: link esterni/documentazione interna da aggiornare.
- Rollback: revert docs/reference.
- Acceptance: tutti i path law referenziati esistono.

### PR-04
- Titolo: `cli: evidence pointer normalization`
- Repo: `yai-cli`
- Obiettivo: sostituire `docs/proof` con pointer corretto.
- Contenuto: move a `docs/pointers/evidence.pointer.md`, README pointers.
- Rischi: bookmark utenti.
- Rollback: reintroduzione file vecchio con deprecation note.
- Acceptance: pointer risolto a path reale `yai-ops/evidence/...`.

### PR-05
- Titolo: `cli: docs subindex readme baseline`
- Repo: `yai-cli`
- Obiettivo: navigazione locale coerente.
- Contenuto: README per `guide`, `development`, `api`.
- Rischi: minimi.
- Rollback: revert README.
- Acceptance: ogni area docs top-level con scope chiaro.

### PR-06
- Titolo: `sdk: bootstrap docs architecture`
- Repo: `yai-sdk`
- Obiettivo: passare da docs minima a surface completa ma snella.
- Contenuto: nuove cartelle `guide/reference/development/pointers`, move `SDK_SURFACE_CONTRACT`.
- Rischi: collegamenti README da aggiornare.
- Rollback: mantenere file vecchio e pointer fallback.
- Acceptance: docs entrypoint con 4 aree + boundary law esplicito.

### PR-07
- Titolo: `yai: docs path hygiene pass (broken links batch 1)`
- Repo: `yai`
- Obiettivo: correggere path rotti ad alto impatto.
- Contenuto: fix `README.md` (`docs/00-dashboard`), fix `docs/platform/**` riferimenti `10-platform`.
- Rischi: regressione link interni.
- Rollback: revert batch 1.
- Acceptance: zero riferimenti a file inesistenti nei path toccati.

### PR-08
- Titolo: `yai: docs legacy namespace deprecation`
- Repo: `yai`
- Obiettivo: uscita da `60-*` namespace.
- Contenuto: deprecate `README-legacy-60-guides.md`, pointer ai nuovi path.
- Rischi: utenti abituati ai vecchi path.
- Rollback: re-add pointer legacy.
- Acceptance: nessun percorso consigliato usa `docs/60-*`.

### PR-09
- Titolo: `yai: program tree flattening phase 1`
- Repo: `yai`
- Obiettivo: semplificare cartelle numerate.
- Contenuto: introduzione `program/{rfc,adr,runbooks,milestones,...}` + pointer dalle vecchie cartelle.
- Rischi: alto numero link.
- Rollback: mantenere vecchie cartelle come canonical temporanee.
- Acceptance: nuovo tree navigabile e backward pointers attivi.

### PR-10
- Titolo: `yai: generated/evidence governance split`
- Repo: `yai`
- Obiettivo: confinare generated/evidence.
- Contenuto: `_generated -> generated`, definizione policy README; plan spostamento evidence raw a `yai-ops` con index pointer.
- Rischi: dipendenze tool.
- Rollback: mantenere alias `_generated` temporaneo.
- Acceptance: policy chiara su cosa resta in repo e cosa no.

### PR-11
- Titolo: `yai: governance residency alignment`
- Repo: `yai`
- Obiettivo: rimuovere contraddizioni narrative.
- Contenuto: rewrite `GOVERNANCE.md`, allineamento con `docs/program` e `yai-infra`.
- Rischi: discussione ownership.
- Rollback: revert documento.
- Acceptance: testo coerente con struttura reale.

### PR-12
- Titolo: `cross-repo: placement policy adoption`
- Repo: `yai-infra` + pointer PR in product repos
- Obiettivo: institutionalizzare grammar placement.
- Contenuto: standard in `yai-infra`, pointer dai 4 repo.
- Rischi: adozione incompleta.
- Rollback: rollback pointer, mantenere standard draft.
- Acceptance: policy referenziata esplicitamente in tutti i repo.

## 10. Rules For Generated / Evidence / Program Artifacts

### 10.1 Generated artifacts

- Deve stare nel repo che li genera (`yai/docs/generated`, `yai-infra/docs/_generated` se cross-repo).
- Ogni cartella generated ha README con:
  - tool di generazione,
  - comando,
  - editability = no,
  - retention policy.
- Se un generated contiene link legacy, va rigenerato prima di ulteriori migrazioni.

### 10.2 Evidence bundles

- Canonico: `yai-ops/evidence/**`.
- Nei repo product (`yai`, `yai-cli`, `yai-sdk`) consentiti solo:
  - index minimale,
  - pointer a manifest/report canonici,
  - eventuali sample ridotti per test locale.
- Raw logs massivi o wave output completi: fuori da repo product.

### 10.3 Program governance docs

- `yai` mantiene RFC/ADR/runbooks/milestones legati al runtime program.
- `yai-infra` mantiene policy/template/process cross-repo.
- Quando un documento runtime cita standard cross-repo, usa pointer a `yai-infra`, non copia.

### 10.4 Milestone packs

- Tenere in `yai/docs/program/milestones` i pack di decisione/stato.
- Evidenze di esecuzione pack in `yai-ops`; nel pack solo pointer e summary.
- Ogni MP deve avere sezione “Evidence pointers” e “Normative anchors”.

### 10.5 Templates

- Template cross-repo in `yai-infra`.
- In `yai` conservare solo template runtime-specific.
- Vietato mantenere due template equivalenti in repo diversi.

### 10.6 Audit material

- Matrix/plan/claims: mantenere dove ownership e chiara.
- Claim registry machine-readable: preferenza `yai-ops` se execution evidence-driven.
- In `yai`: solo livello program decisionale + pointer alla prova.

### 10.7 Migration notes

- Devono vivere in `docs/*/migration/` con data, owner, sunset.
- Alla chiusura migrazione: deprecate o delete esplicito.

## 11. Risks And Compatibility Strategy

Rischi principali:
- break di link durante spostamenti;
- confusione temporanea tra vecchio e nuovo tree;
- tool/generated che continuano a emettere path legacy;
- disallineamento di ownership tra `yai` e `yai-infra`/`yai-ops`.

Strategia:
- migrazione in due fasi per ogni area: (1) create new + pointer, (2) switch canonical + clean-up;
- mantenere pointer backward-compat per 1-2 release;
- introdurre check CI docs-link + lint naming;
- gate di review obbligatorio su boundary normativo (law-duplication check).

## 12. Review Checklist

Usare questa checklist per approvare/rifiutare il piano.

- [ ] Boundary `yai-law` vs `yai-sdk` vs `yai-cli` vs `yai` e univoco.
- [ ] Nessuna duplicazione normativa fuori da `yai-law`.
- [ ] Ogni repo ha un modello docs semplice e navigabile (max 2-3 livelli “attivi”).
- [ ] `yai-sdk` esce dalla condizione “docs monca” con set minimo sufficiente.
- [ ] `yai-cli` separa chiaramente guide/reference/development/pointers.
- [ ] `yai` riduce stratificazione e rimuove naming legacy (`10/20/60`).
- [ ] Generated/evidence/program artifacts hanno confini netti e sostenibili.
- [ ] Esiste mapping old->new concreto con azione esplicita.
- [ ] Candidati delete/deprecate sono identificati con rischio e redirect.
- [ ] Roadmap PR e realmente incrementale (1-2 giorni/PR, rollback definito).
- [ ] README strategy e orientativa (non decorativa) a ogni livello necessario.
- [ ] Sono presenti regole preventive per evitare nuovo legacy documentale.

