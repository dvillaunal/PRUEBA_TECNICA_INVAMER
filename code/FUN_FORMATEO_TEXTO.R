# Función para limpiar texto eliminando acentos y normalizando espacios
formateo_texto <- function(text) {
  require(magrittr)
  text <- tolower(text)
  text <- iconv(text, from = "UTF-8", to = "ASCII//TRANSLIT") # Eliminar acentos
  text <- gsub("[^a-z0-9 ]", "", text) # Mantener solo letras, números y espacios # nolint
  text <- stringr::str_trim(text) # Eliminar espacios iniciales y finales
  text <- stringr::str_squish(text) # Reducir múltiples espacios a uno
  return(text) # nolint
}