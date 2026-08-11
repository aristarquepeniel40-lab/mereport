#' Verifier la qualite d'un projet avant de generer son rapport
#'
#' Pont optionnel vers `mecheck` (en `Suggests`, pas `Imports` -- meme
#' logique que `readxl` dans `medata`). `mereport` fonctionne sans
#' `mecheck` installe ; cette fonction degrade proprement (avertissement,
#' pas d'erreur) si le package est absent.
#'
#' @param project Un `mecore::me_project`.
#' @param block_on_failure Si `TRUE`, leve une erreur si au moins une
#'   regle de controle qualite echoue (bloque la generation du rapport).
#'   Si `FALSE` (par defaut), le rapport de controle est simplement
#'   retourne pour etre integre au document (voir `render_markdown()`).
#' @return Un `mecheck::me_check_report`, ou `NULL` si `mecheck` n'est
#'   pas installe.
#' @export
check_before_report <- function(project, block_on_failure = FALSE) {
  if (!requireNamespace("mecheck", quietly = TRUE)) {
    warning(
      "Le package 'mecheck' n'est pas installe : le controle qualite est ignore. ",
      "Installe-le localement pour l'activer (voir ARCHITECTURE.md).",
      call. = FALSE
    )
    return(NULL)
  }

  rapport <- mecheck::run_checks(project)

  if (block_on_failure && mecheck::has_failures(rapport)) {
    n_echecs <- sum(rapport@results$status == "ECHEC")
    mecore::me_validation_error(sprintf(
      "generation du rapport bloquee : %d regle(s) de controle qualite en echec. %s",
      n_echecs,
      paste(rapport@results$message[rapport@results$status == "ECHEC"], collapse = " ; ")
    ))
  }

  rapport
}
