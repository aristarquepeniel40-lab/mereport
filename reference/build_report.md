# Construire un rapport a partir d'un projet

Assemble un
[`mecore::me_report`](https://rdrr.io/pkg/mecore/man/me_report.html) a
partir d'un
[`mecore::me_project`](https://rdrr.io/pkg/mecore/man/me_project.html) :
par defaut, inclut TOUS les indicateurs du projet. Ne rend rien a ce
stade (voir
[`render_markdown()`](https://aristarquepeniel40-lab.github.io/mereport/reference/render_markdown.md)),
ne fait que construire l'objet.

## Usage

``` r
build_report(project, narrative = NULL, indicators = NULL, dashboard = NULL)
```

## Arguments

- project:

  Un
  [`mecore::me_project`](https://rdrr.io/pkg/mecore/man/me_project.html).

- narrative:

  Texte narratif. Si `NULL`, un texte minimal est genere automatiquement
  a partir du nombre d'indicateurs.

- indicators:

  Liste de
  [`mecore::me_indicator`](https://rdrr.io/pkg/mecore/man/me_indicator.html)
  a inclure. Par defaut : tous les indicateurs de `project@indicators`.

- dashboard:

  Un
  [`mecore::me_dashboard`](https://rdrr.io/pkg/mecore/man/me_dashboard.html)
  optionnel.

## Value

Un [`mecore::me_report`](https://rdrr.io/pkg/mecore/man/me_report.html).
