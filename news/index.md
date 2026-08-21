# Changelog

## mereport 1.0.0

Première version stable.

### Fonctionnalités

- [`build_report()`](https://aristarquepeniel40-lab.github.io/mereport/reference/build_report.md)/[`render_markdown()`](https://aristarquepeniel40-lab.github.io/mereport/reference/render_markdown.md)
  — assemble et rend un rapport Markdown (métadonnées, table
  d’indicateurs, synthèse narrative, bloc de provenance).
- Méthode enregistrée sur
  [`mecore::generate_report()`](https://rdrr.io/pkg/mecore/man/generate_report.html),
  pour `project |> generate_report(path = ...)`.
- Intégration optionnelle avec `mecheck` (en `Suggests`) :
  `generate_report(..., check = TRUE, block_on_failure = FALSE)` ajoute
  une section contrôle qualité au rapport, ou bloque sa génération si
  demandé.
