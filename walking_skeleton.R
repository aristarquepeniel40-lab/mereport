library(mecore)
library(medata)
library(meindicator)
library(mereport)
library(S7)

chemin_csv <- tempfile(fileext = ".csv")
writeLines(c("age,revenu", "20,50000", "22,60000", "25,75000", "31,90000"), chemin_csv)

meta <- me_metadata(
  project_name = "Pilote mereport", organization = "Universite de Parakou",
  country = "Benin", donor = "N/A", manager = "Peniel",
  start_date = Sys.Date(), end_date = Sys.Date() + 365,
  version = "0.1", description = "test", objectives = "test", sdgs = character(0)
)

# 1. medata : import
d <- import_csv(chemin_csv, name = "enquete", metadata = meta)

# 2. Projet avec le dataset
p <- me_project(name = "Pilote", metadata = meta, datasets = list(d), indicators = list(), logframe = NULL)

# 3. meindicator : calcul via recette
rec <- list(
  meindicator::me_indicator_recipe(dataset_name = "enquete", label = "Age moyen", formula = ~ mean(age), unit = "annees"),
  meindicator::me_indicator_recipe(dataset_name = "enquete", label = "Revenu median", formula = ~ median(revenu), unit = "FCFA")
)
p <- p |> compute_indicators(recipes = rec)
stopifnot(length(p@indicators) == 2)
cat("Indicateurs calcules : OK (", length(p@indicators), ")\n")

# 4. mereport : construction + rendu, voie directe
r <- build_report(p, narrative = "Premiere note de synthese du projet pilote.")
chemin_md <- tempfile(fileext = ".md")
render_markdown(r, chemin_md)
stopifnot(file.exists(chemin_md))
cat("\n--- CONTENU DU RAPPORT GENERE ---\n")
cat(readLines(chemin_md), sep = "\n")
cat("--- FIN DU RAPPORT ---\n\n")

# 5. mereport : voie generique (pipe), narrative par defaut
chemin_md2 <- tempfile(fileext = ".md")
p |> generate_report(path = chemin_md2)
stopifnot(file.exists(chemin_md2))
cat("Voie generique (pipe) : OK, fichier genere a", chemin_md2, "\n")

cat("\nTOUS LES TESTS MEREPORT PASSENT.\n")
