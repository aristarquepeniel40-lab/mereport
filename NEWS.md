# mereport 1.0.0

Première version stable.

## Fonctionnalités

* `build_report()`/`render_markdown()` — assemble et rend un rapport
  Markdown (métadonnées, table d'indicateurs, synthèse narrative, bloc
  de provenance).
* Méthode enregistrée sur `mecore::generate_report()`, pour
  `project |> generate_report(path = ...)`.
* Intégration optionnelle avec `mecheck` (en `Suggests`) :
  `generate_report(..., check = TRUE, block_on_failure = FALSE)` ajoute
  une section contrôle qualité au rapport, ou bloque sa génération si
  demandé.
