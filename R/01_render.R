#' Rendre un rapport en fichier Markdown
#'
#' Ecrit un `.md` avec : titre + metadonnees du projet, table des
#' indicateurs, texte narratif, et un bloc de provenance (reutilise
#' `mecore::build_provenance()` — voir idee innovante #4 de `mecore`).
#'
#' @param report Un `mecore::me_report`.
#' @param path Chemin du fichier `.md` a ecrire.
#' @return `path`, de maniere invisible.
#' @export
render_markdown <- function(report, path) {
  if (!S7::S7_inherits(report, mecore::me_report)) {
    mecore::me_validation_error("`report` doit etre un mecore::me_report")
  }

  p <- report@project
  m <- p@metadata

  lignes <- c(
    sprintf("# %s", p@name),
    "",
    sprintf("**Organisation :** %s  ", m@organization),
    sprintf("**Pays :** %s  ", m@country),
    sprintf("**Responsable :** %s  ", m@manager),
    sprintf("**Periode :** %s -- %s  ", format(m@start_date), format(m@end_date)),
    "",
    "## Indicateurs",
    ""
  )

  if (length(report@indicators) == 0) {
    lignes <- c(lignes, "_Aucun indicateur inclus dans ce rapport._", "")
  } else {
    lignes <- c(lignes, "| Indicateur | Valeur | Unite |", "|---|---|---|")
    for (i in report@indicators) {
      valeur_txt <- if (is.null(i@value) || (length(i@value) == 1 && is.na(i@value))) {
        "n/a"
      } else {
        format(i@value)
      }
      lignes <- c(lignes, sprintf("| %s | %s | %s |", i@label, valeur_txt, i@unit))
    }
    lignes <- c(lignes, "")
  }

  lignes <- c(lignes, "## Synthese", "", report@narrative, "")

  prov <- mecore::build_provenance(report)
  lignes <- c(
    lignes,
    "---",
    sprintf(
      "_Genere le %s avec mecore %s -- %d dataset(s) source(s)._",
      prov$generated_at, prov$mecore_version, length(prov$datasets)
    )
  )

  writeLines(lignes, path)
  invisible(path)
}
