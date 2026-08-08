#' Construire un rapport a partir d'un projet
#'
#' Assemble un `mecore::me_report` a partir d'un `mecore::me_project` :
#' par defaut, inclut TOUS les indicateurs du projet. Ne rend rien a ce
#' stade (voir `render_markdown()`), ne fait que construire l'objet.
#'
#' @param project Un `mecore::me_project`.
#' @param narrative Texte narratif. Si `NULL`, un texte minimal est
#'   genere automatiquement a partir du nombre d'indicateurs.
#' @param indicators Liste de `mecore::me_indicator` a inclure. Par
#'   defaut : tous les indicateurs de `project@indicators`.
#' @param dashboard Un `mecore::me_dashboard` optionnel.
#' @return Un `mecore::me_report`.
#' @export
build_report <- function(project, narrative = NULL, indicators = NULL, dashboard = NULL) {
  if (!S7::S7_inherits(project, mecore::me_project)) {
    mecore::me_validation_error("`project` doit etre un mecore::me_project")
  }

  if (is.null(indicators)) indicators <- project@indicators

  if (is.null(narrative)) {
    narrative <- sprintf(
      "Ce rapport presente %d indicateur(s) pour le projet '%s'.",
      length(indicators), project@name
    )
  }

  mecore::me_report(
    project = project,
    indicators = indicators,
    dashboard = dashboard,
    narrative = narrative
  )
}
