# Rendre un rapport en fichier Markdown

Ecrit un `.md` avec : titre + metadonnees du projet, table des
indicateurs, texte narratif, et un bloc de provenance (reutilise
[`mecore::build_provenance()`](https://rdrr.io/pkg/mecore/man/build_provenance.html)
– voir idee innovante \#4 de `mecore`).

## Usage

``` r
render_markdown(report, path, check_report = NULL)
```

## Arguments

- report:

  Un
  [`mecore::me_report`](https://rdrr.io/pkg/mecore/man/me_report.html).

- path:

  Chemin du fichier `.md` a ecrire.

- check_report:

  Un
  [`mecheck::me_check_report`](https://rdrr.io/pkg/mecheck/man/me_check_report.html)
  optionnel (voir
  [`check_before_report()`](https://aristarquepeniel40-lab.github.io/mereport/reference/check_before_report.md)).
  Si fourni, ajoute une section "Controle qualite" au rapport, avec un
  avertissement visible en cas d'echec.

## Value

`path`, de maniere invisible.
