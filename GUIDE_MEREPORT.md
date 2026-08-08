# Guide d'intégration — `mereport`

Même processus que les trois précédents : testé réellement dans mon
environnement, `mecore`, `meindicator` et `medata` installés au préalable.
Aucun bug trouvé cette fois — la chaîne complète (import → calcul →
rapport) a fonctionné du premier coup, signe que les conventions posées
dans `ARCHITECTURE.md` (et les leçons des 3 packages précédents) tiennent.

## 1. Pré-requis

`mereport` dépend de `mecore`. `mecore`, `meindicator` et `medata`
doivent déjà être **installés** (`devtools::install()`, pas juste
`load_all()`) pour que le walking skeleton fonctionne chez toi.

## 2. Installation

```r
setwd("chemin/vers/mereport")
devtools::document()
devtools::load_all(".")
source("walking_skeleton.R")   # doit afficher "TOUS LES TESTS MEREPORT PASSENT."
devtools::test()
devtools::check()
```

## 3. Ce que fait ce package (V1 minimale)

- `build_report(project, narrative = NULL, indicators = NULL, dashboard = NULL)`
  → `mecore::me_report` — assemble un rapport à partir d'un projet
  (tous les indicateurs par défaut).
- `render_markdown(report, path)` — écrit un `.md` avec métadonnées,
  table des indicateurs, synthèse narrative, et un bloc de provenance
  (réutilise `mecore::build_provenance()`, l'idée innovante #4 posée
  dès `mecore`).
- Méthode enregistrée sur `mecore::generate_report()` : `project |> generate_report(path = "rapport.md")`.

## 4. Exemple de rapport généré (testé ici)

```markdown
# Pilote

**Organisation :** Universite de Parakou
**Pays :** Benin
**Responsable :** Peniel
**Periode :** 2026-08-08 -- 2027-08-08

## Indicateurs

| Indicateur | Valeur | Unite |
|---|---|---|
| Age moyen | 24.5 | annees |
| Revenu median | 67500 | FCFA |

## Synthese

Premiere note de synthese du projet pilote.

---
_Genere le 2026-08-08T15:01:01+0000 avec mecore 0.0.0.9000 -- 1 dataset(s) source(s)._
```

## 5. Prochaine étape suggérée après validation

Une fois `devtools::check()` propre : commit, `usethis::use_git()`,
puis mise à jour d'`ARCHITECTURE.md`. C'est le 4e package du même
niveau de rigueur — la "première version utilisable de MEverse" (jalon
du §8) n'est plus très loin : il ne reste que `mecheck`, ou on peut
considérer que la chaîne actuelle (`mecore` → `medata` → `meindicator`
→ `mereport`) constitue déjà un pipeline complet et utilisable sur un
cas réel, pas seulement un jouet.
