# ==========================================================
# ALTERNÂNCIA DE IDIOMA PT / EN — apoio do lado do R
# ----------------------------------------------------------
# A tradução da interface é feita no navegador pelo ficheiro
# www/i18n/i18n.js (botão PT | EN na barra superior).
#
# Este ficheiro serve apenas os 4 gráficos estáticos (renderPlot),
# que são imagens e por isso não podem ser traduzidos no navegador.
# Usa o MESMO dicionário central: www/i18n/traducoes.json
#
# i18n_tr(x, idioma) devolve x sem qualquer alteração quando o
# idioma não é "en". Nunca altera dados, apenas rótulos de texto.
# ==========================================================

i18n_dicionario <- local({
  ficheiro <- file.path("www", "i18n", "traducoes.json")
  if (!file.exists(ficheiro)) {
    character(0)
  } else {
    dic <- jsonlite::fromJSON(ficheiro, simplifyVector = FALSE)
    pt <- vapply(dic$entradas, function(p) gsub("\\s+", " ", trimws(p[[1]])), character(1))
    en <- vapply(dic$entradas, function(p) gsub("\\s+", " ", trimws(p[[2]])), character(1))
    stats::setNames(en, pt)[!duplicated(pt)]
  }
})

i18n_tr <- function(x, idioma = NULL) {
  if (!identical(idioma, "en") || length(x) == 0) return(x)
  chave <- gsub("\\s+", " ", trimws(as.character(x)))
  traducao <- unname(i18n_dicionario[chave])
  ifelse(is.na(traducao), as.character(x), traducao)
}
