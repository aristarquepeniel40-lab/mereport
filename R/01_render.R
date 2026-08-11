#' Rendre un rapport en fichier Markdown
#'
#' Ecrit un `.md` avec : titre + metadonnees du projet, table des
#' indicateurs, texte narratif, et un bloc de provenance (reutilise
#' `mecore::build_provenance()` -- voir idee innovante #4 de `mecore`).
#'
#' @param report Un `mecore::me_report`.
#' @param path Chemin du fichier `.md` a ecrire.
#' @param check_report Un `mecheck::me_check_report` optionnel (voir
#'   `check_before_report()`). Si fourni, ajoute une section "Controle
#'   qualite" au rapport, avec un avertissement visible en cas d'echec.
#' @return `path`, de maniere invisible.
#' @export
render_markdown <- function(report, path, check_report = NULL) {
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

  if (!is.null(check_report)) {
    lignes <- c(lignes, "## Controle qualite", "")
    n_echecs <- sum(check_report@results$status == "ECHEC")
    if (n_echecs > 0) {
      lignes <- c(lignes, sprintf(
        "> **ATTENTION : %d regle(s) de controle qualite en echec.** Les resultats ci-dessous doivent etre interpretes avec prudence.",
        n_echecs
      ), "")
    } else {
      lignes <- c(lignes, "Toutes les regles de controle qualite sont respectees.", "")
    }
    lignes <- c(lignes, "| Regle | Severite | Statut | Message |", "|---|---|---|---|")
    for (i in seq_len(nrow(check_report@results))) {
      r <- check_report@results[i, ]
      lignes <- c(lignes, sprintf("| %s | %s | %s | %s |", r$rule, r$severity, r$status, r$message))
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
