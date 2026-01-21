# Librerias y variables necesarias ----------------------------------------

require(tidyverse)
require(magrittr)
require(janitor)
require(glue)
require(readxl)

source('code/FUN_FORMATEO_TEXTO.R')

# Lectura de datos --------------------------------------------------------

# Sacar las hojas del excel en cuestión

sheets <- excel_sheets('data_raw/prueba_tecnica.xlsx')
sheets

# Nota de la variable duplicada 

# La variable p10_1_21 se descartó porque era redundante con p10_1_20.
# Se decidió renombrar p10_1_20 a p10_1 para mantener la coherencia en el dataset final,
# evitando confusiones en el análisis posterior.
# Esto se refleja en el código con rename(p10_1 = p10_1_20).

# Datos

data_raw <- read_excel(
  path = "data_raw/prueba_tecnica.xlsx",
  sheet = sheets[1]
) %>% 
  clean_names() %>% 
  select(-p10_1_21) %>% 
  rename(
    p10_1 = p10_1_20
  )

# Preguntas

preguntas_raw <- read_excel(
  path = 'data_raw/prueba_tecnica.xlsx',
  sheet = sheets[2]
) %>% 
  clean_names()

# Codigo preguntas

codp_raw <- read_excel(
  path = 'data_raw/prueba_tecnica.xlsx',
  sheet = sheets[3]
) %>% 
  clean_names()

# codp_raw %>% 
#   nest(.by = codigo_pregunta, .key = "respuestas")


# Recodificación de “no respuesta / especiales” ---------------------------

# 999 = No sabe/No responde (aparece en muchas P’s) → NA.

codp_raw %>%
  filter(
    codigo_opcion_respuesta == 999,
    str_detect(
      formateo_texto(descripcion_opcion_respuesta),
      'no sabe|no responde'
    )
  ) %>% 
  pull(codigo_pregunta)


# Detecta tipos de variables ----------------------------------------------





