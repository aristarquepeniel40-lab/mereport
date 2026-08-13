# mereport

[![R-CMD-check](https://github.com/aristarquepeniel40-lab/mereport/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/aristarquepeniel40-lab/mereport/actions/workflows/R-CMD-check.yaml)

**Génération de rapports pour l'écosystème [MEverse](https://github.com/aristarquepeniel40-lab/mecore).**

Assemble un `mecore::me_report` à partir d'un `mecore::me_project`, et
le rend en fichier Markdown : métadonnées, table des indicateurs,
synthèse narrative, et bloc de provenance (version des packages,
empreinte des datasets sources).

Intègre en option [mecheck](https://github.com/aristarquepeniel40-lab/mecheck)
pour ajouter une section contrôle qualité au rapport — voire bloquer
sa génération si des incohérences sont détectées.

## Installation

```r
install.packages("remotes")
remotes::install_github("aristarquepeniel40-lab/mecore")     # dependance
remotes::install_github("aristarquepeniel40-lab/mecheck")    # optionnelle (integration qualite)
remotes::install_github("aristarquepeniel40-lab/mereport")
```

## Exemple rapide

```r
library(mecore)
library(mereport)

meta <- me_metadata(project_name = "Suivi agricole", organization = "o", country = "Benin",
  donor = "d", manager = "A. Segue", start_date = as.Date("2026-01-01"), end_date = as.Date("2026-12-31"),
  version = "1.0", description = "d", objectives = "o", sdgs = character(0))

d <- me_dataset(name = "exploitants", data = data.frame(rendement = c(1200, 2400, 1800)), metadata = meta)
ind <- me_indicator(label = "Rendement moyen", formula = ~ mean(rendement),
                     datasets = list(d), value = mean(c(1200, 2400, 1800)), unit = "kg/ha")
p <- me_project(name = "Suivi agricole", metadata = meta,
                 datasets = list(d), indicators = list(ind), logframe = NULL)

# Rapport simple
p |> generate_report(path = "rapport.md")

# Avec controle qualite integre (necessite mecheck)
p |> generate_report(path = "rapport.md", check = TRUE)

# Controle qualite BLOQUANT : leve une erreur si une regle echoue
p |> generate_report(path = "rapport.md", check = TRUE, block_on_failure = TRUE)
```

## Fait partie de l'écosystème MEverse

[mecore](https://github.com/aristarquepeniel40-lab/mecore) (fondations) ·
[medata](https://github.com/aristarquepeniel40-lab/medata) ·
[meindicator](https://github.com/aristarquepeniel40-lab/meindicator) ·
[mecheck](https://github.com/aristarquepeniel40-lab/mecheck) ·
**mereport** (ce dépôt)

## Licence

MIT — voir [`LICENSE`](LICENSE).
