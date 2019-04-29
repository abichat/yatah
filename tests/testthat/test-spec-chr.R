context("Special characters")

lin_spec <-
  c(
    "k__Bacteria; p__Acidobacteria; c__Acidobacteria-6; o__iii1-15",
    "k__Bacteria; p__Bacteroidetes; c__Bacteroidia; o__Bacteroidales; f__S24-7",
    paste0("k__Bacteria; p__Bacteroidetes; c__Bacteroidia; o__Bacteroidales;",
           " f__[Paraprevotellaceae]; g__[Prevotella]"),
    paste0("k__Bacteria; p__Actinobacteria; c__Actinobacteria;",
           " o__Bifidobacteriales; f__Bifidobacteriaceae; g__Bifidobacterium;",
           " s__breve.longum.pseudocatenulatum")
  )


test_that("special characters are handled correclty in general functions", {
  expect_equal(is_lineage(lin_spec, "; "), rep(TRUE, length(lin_spec)))
  expect_equal(last_clade(lin_spec, sep = "; ", same = FALSE),
               c("iii1-15", "S24-7", "[Prevotella]",
                 "breve.longum.pseudocatenulatum"))
  expect_equal(last_rank(lin_spec, sep = "; ", same = FALSE),
               c("order", "family", "genus", "species"))
  expect_equal(last_rank(lin_spec, sep = "; ", same = FALSE),
               c("order", "family", "genus", "species"))
})

lin_spec2 <-
  c("k__Bacteria; p__Acidobacteria; c__Acidobacteria-6",
    "k__Bacteria; p__Bacteroidetes; c__Bacte.roidia",
    "k__Bacteria; p__Bacteroidetes; c__Bacte_roidia",
    "k__Bacteria; p__Acidobacteria; c__[Acidobacteria]"
  )

tabl_spec2 <- taxtable(lin_spec2, sep = "; ")

test_that("special characters are handled correclty in taxtable", {
  expect_equal(taxtable(lin_spec[1], sep = "; ")$order, "iii1-15")
  expect_equal(taxtable(lin_spec[2], sep = "; ")$family, "S24-7")
  expect_equal(taxtable(lin_spec[3], sep = "; ")$genus, "[Prevotella]")
  expect_equal(taxtable(lin_spec[4], sep = "; ")$species,
               "breve.longum.pseudocatenulatum")
  expect_equal(tabl_spec2$class, c("Acidobacteria-6", "Bacte.roidia",
                                   "Bacte_roidia", "[Acidobacteria]"))
})

df_birds <-
  data.frame(family = c("Parulidae", "Passerellidae", "Passerellidae"),
             genus = c("Setophaga", "Spizelloides", "Zonotrichia"),
             species = c("Setophaga magnolia", "Spizelloides arborea",
                         "Zonotrichia albicollis"), stringsAsFactors = FALSE)

test_that("special characters are handled correclty in taxtree", {
  expect_equal(length(taxtree(tabl_spec2)$tip.label), 4)
  expect_equal(taxtree(tabl_spec2)$tip.label %in%
                 c("Acidobacteria-6", "Bacte.roidia",
                   "Bacte_roidia", "[Acidobacteria]"), rep(TRUE, 4))
  expect_equal(sort(taxtree(df_birds)$tip.label), df_birds$species)
})



