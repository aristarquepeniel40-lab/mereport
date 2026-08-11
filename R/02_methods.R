# Meme piege que dans meindicator/medata (voir ARCHITECTURE.md section 5) :
# `generate_report` est un generique DEFINI DANS mecore. Alias local
# explicite plutot que @importFrom (poule et oeuf avec document()).
generate_report <- mecore::generate_report

#' @noRd
S7::method(generate_report, mecore::me_project) <- function(x, ..., path, narrative = NULL,
                                                              check = FALSE, block_on_failure = FALSE) {
  rapport_qualite <- if (check) check_before_report(x, block_on_failure = block_on_failure) else NULL
  r <- build_report(x, narrative = narrative)
  render_markdown(r, path, check_report = rapport_qualite)
  invisible(r)
}
