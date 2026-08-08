helper_project <- function(n_indicators = 1) {
  meta <- mecore::me_metadata(
    project_name = "p", organization = "o", country = "c", donor = "d", manager = "m",
    start_date = Sys.Date(), end_date = Sys.Date() + 1,
    version = "0.1", description = "d", objectives = "o", sdgs = character(0)
  )
  d <- mecore::me_dataset(name = "d1", data = data.frame(age = c(20, 22, 25)), metadata = meta)
  ind <- mecore::me_indicator(label = "Age moyen", formula = ~ mean(age),
                                datasets = list(d), value = mean(c(20, 22, 25)), unit = "annees")
  mecore::me_project(name = "p", metadata = meta, datasets = list(d),
                       indicators = if (n_indicators > 0) list(ind) else list(), logframe = NULL)
}

test_that("build_report inclut tous les indicateurs du projet par defaut", {
  p <- helper_project()
  r <- build_report(p)
  expect_true(S7::S7_inherits(r, mecore::me_report))
  expect_equal(length(r@indicators), 1)
})

test_that("build_report genere une narrative par defaut si non fournie", {
  p <- helper_project()
  r <- build_report(p)
  expect_true(nzchar(r@narrative))
})

test_that("render_markdown ecrit un fichier contenant le nom du projet et les indicateurs", {
  p <- helper_project()
  r <- build_report(p, narrative = "Synthese test")
  path <- tempfile(fileext = ".md")
  render_markdown(r, path)
  expect_true(file.exists(path))
  contenu <- readLines(path)
  expect_true(any(grepl("^# p$", contenu)))
  expect_true(any(grepl("Age moyen", contenu)))
  expect_true(any(grepl("Synthese test", contenu)))
})

test_that("render_markdown gere un rapport sans indicateur", {
  p <- helper_project(n_indicators = 0)
  r <- build_report(p)
  path <- tempfile(fileext = ".md")
  render_markdown(r, path)
  contenu <- readLines(path)
  expect_true(any(grepl("Aucun indicateur", contenu)))
})

test_that("le generique mecore::generate_report() dispatche vers me_project", {
  p <- helper_project()
  path <- tempfile(fileext = ".md")
  p |> mecore::generate_report(path = path)
  expect_true(file.exists(path))
})
