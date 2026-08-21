# Verifier la qualite d'un projet avant de generer son rapport

Pont optionnel vers `mecheck` (en `Suggests`, pas `Imports` – meme
logique que `readxl` dans `medata`). `mereport` fonctionne sans
`mecheck` installe ; cette fonction degrade proprement (avertissement,
pas d'erreur) si le package est absent.

## Usage

``` r
check_before_report(project, block_on_failure = FALSE)
```

## Arguments

- project:

  Un
  [`mecore::me_project`](https://rdrr.io/pkg/mecore/man/me_project.html).

- block_on_failure:

  Si `TRUE`, leve une erreur si au moins une regle de controle qualite
  echoue (bloque la generation du rapport). Si `FALSE` (par defaut), le
  rapport de controle est simplement retourne pour etre integre au
  document (voir
  [`render_markdown()`](https://aristarquepeniel40-lab.github.io/mereport/reference/render_markdown.md)).

## Value

Un
[`mecheck::me_check_report`](https://rdrr.io/pkg/mecheck/man/me_check_report.html),
ou `NULL` si `mecheck` n'est pas installe.
