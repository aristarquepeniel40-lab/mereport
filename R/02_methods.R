# Meme piege que dans meindicator/medata (voir ARCHITECTURE.md §5) :
# `generate_report` est un generique DEFINI DANS mecore. Alias local
# explicite plutot que @importFrom (poule et oeuf avec document()).
generate_report <- mecore::generate_report

#' @noRd
S7::method(generate_report, mecore::me_project) <- function(x, ..., path, narrative = NULL) {
  r <- build_report(x, narrative = narrative)
  render_markdown(r, path)
  invisible(r)
}
