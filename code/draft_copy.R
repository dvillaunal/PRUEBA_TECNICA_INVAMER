preguntas_raw %>% 
  filter(codigo_pregunta %in% c("FB", "FG"))

codp_raw %>% 
  filter(codigo_pregunta %in% c("FB", "FG")) %>% 
  group_split(codigo_pregunta)


label_p2 <- codp_raw %>% 
  filter(codigo_pregunta == "FG") %>% 
  arrange(codigo_opcion_respuesta) %>% 
  pull(descripcion_opcion_respuesta)


preguntas_raw %>% 
  filter(codigo_pregunta == "P3")


codp_raw %>% 
  filter(codigo_pregunta == "P3")

preguntas_raw %>% 
  filter(codigo_pregunta == "FC")

codp_raw %>% 
  filter(codigo_pregunta == "FC") %>% 
  select(codigo_opcion_respuesta, descripcion_opcion_respuesta) %>% 
  rename(
    fc = codigo_opcion_respuesta,
    estacion = descripcion_opcion_respuesta
  )
  

preguntas_raw %>% 
  filter(codigo_pregunta == "FF")

codp_raw %>% 
  filter(codigo_pregunta == "FF")

codp_raw %>% 
  filter(codigo_pregunta == "P27")


codp_raw %>% 
  filter(codigo_pregunta == "FF")




library(dplyr)
library(tidyr)
library(gt)

tab_dimensiones <- data_eda_iisn_m %>%
  summarise(
    Seguridad   = mean(impacto_seguridad, na.rm = TRUE),
    Informacion = mean(impacto_informacion, na.rm = TRUE),
    Entorno     = mean(impacto_entorno, na.rm = TRUE)
  ) %>%
  pivot_longer(everything(), names_to = "dimension", values_to = "impacto_prom") %>%
  mutate(row_id = row_number()) %>%
  gt() %>%
  tab_header(
    title = md("**Impacto social negativo promedio por dimensión**"),
    subtitle = "Proporción de aspectos evaluados negativamente (mayor valor = mayor impacto negativo)"
  ) %>%
  cols_label(
    dimension    = md("**Dimensión**"),
    impacto_prom = md("**Impacto social negativo promedio**")
  ) %>%
  fmt_percent(
    columns = impacto_prom,
    decimals = 1
  ) %>%
  cols_align(align = "left",  columns = dimension) %>%
  cols_align(align = "right", columns = impacto_prom) %>%
  tab_options(
    table.font.size = px(13),
    heading.title.font.size = px(18),
    heading.subtitle.font.size = px(12),
    data_row.padding = px(6),
    table.border.top.style = "solid",
    table.border.bottom.style = "solid",
    table_body.border.bottom.style = "solid"
  ) %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_column_labels(everything())
  ) %>%
  tab_style(
    style = cell_fill(color = "#F7F7F7"),
    locations = cells_body(rows = row_id %% 2 == 1)
  ) %>%
  tab_style(
    style = list(cell_text(weight = "bold"), cell_fill(color = "#FFF3CD")),
    locations = cells_body(
      columns = impacto_prom,
      rows = impacto_prom == max(impacto_prom, na.rm = TRUE)
    )
  ) %>%
  cols_hide(columns = row_id)

tab_dimensiones




# -------------------------------------------------------------------------

library(dplyr)
library(gt)

tab_dim_x_educ <- data_eda_iisn_m %>%
  filter(!is.na(p26)) %>%
  group_by(p26) %>%
  reframe(
    Seguridad   = mean(impacto_seguridad, na.rm = TRUE),
    Informacion = mean(impacto_informacion, na.rm = TRUE),
    Entorno     = mean(impacto_entorno, na.rm = TRUE)
  ) %>%
  left_join(
    codp_raw %>%
      filter(codigo_pregunta == "P26") %>%
      select(-codigo_pregunta) %>%
      rename(
        p26 = codigo_opcion_respuesta,
        nivel_estudio = descripcion_opcion_respuesta
      ),
    by = "p26"
  ) %>%
  relocate(nivel_estudio, .before = p26) %>%
  select(-p26) %>%
  mutate(row_id = row_number()) %>%
  gt(rowname_col = "nivel_estudio") %>%
  tab_header(
    title = md("**Impacto social negativo por dimensión** según nivel educativo"),
    subtitle = "Proporción promedio de evaluaciones negativas (mayor valor = mayor impacto negativo)"
  ) %>%
  cols_label(
    Seguridad   = md("**Seguridad**"),
    Informacion = md("**Información**"),
    Entorno     = md("**Entorno físico**")
  ) %>%
  fmt_percent(
    columns = c(Seguridad, Informacion, Entorno),
    decimals = 1
  ) %>%
  tab_options(
    table.font.size = px(12),
    heading.title.font.size = px(18),
    heading.subtitle.font.size = px(12),
    data_row.padding = px(6),
    row_group.padding = px(4),
    table.border.top.style = "solid",
    table.border.bottom.style = "solid"
  ) %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_column_labels(everything())
  ) %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_stub()
  ) %>%
  tab_style(
    style = cell_fill(color = "#F7F7F7"),
    locations = cells_body(rows = row_id %% 2 == 1)
  ) %>%
  data_color(
    columns = c(Seguridad, Informacion, Entorno),
    palette = c("#E8F5E9", "#FFEBEE")
  ) %>%
  cols_hide(columns = row_id)

tab_dim_x_educ



# -------------------------------------------------------------------------


preguntas_raw %>% 
  filter(codigo_pregunta %in% c("P3", "P6")) %>% 
  pull(descripcion_pregunta)



codp_raw %>% 
  filter(codigo_pregunta %in% c("P6")) %>% 
  pull(descripcion_opcion_respuesta)

# (Opcional pero recomendado) filtrar No sabe/No responde (999)
df_plot <- data_eda %>%
  filter(!is.na(p3), !is.na(p6)) %>%
  filter(p3 != 999, p6 != 999)

ggplot(df_plot, aes(x = p3, y = p6)) +
  geom_jitter(width = 0.18, height = 0.18, alpha = 0.25, size = 1.6) +
  scale_x_continuous(
    breaks = 1:5,
    labels = c("Pésimo", "Malo", "Regular", "Bueno", "Excelente")
  ) +
  scale_y_continuous(
    breaks = 1:5,
    labels =  c(
      "No def.",
      "No prob.",
      "Indeciso",
      "Sí prob.",
      "Sí def."
    )
  ) +
  labs(
    title = "Relación entre satisfacción del servicio y recomendación",
    x = "Satisfacción con el servicio",
    y = "Recomendación del sistema"
  ) +
  theme_fivethirtyeight() +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold")
  )


# -------------------------------------------------------------------------

codp_raw %>% 
  filter(codigo_pregunta %in% c("P6")) 



data_eda %>%
  filter(!is.na(p3), !is.na(p6)) %>%
  group_by(p3) %>%
  reframe(
    prop_recomienda = mean(p6 %in% c(4,5), na.rm = TRUE) %>% round(2)
  ) %>%
  ggplot(aes(x = p3, y = prop_recomienda)) +
  geom_col(fill = "#7c0041", width = 0.08) +
  geom_label(
    aes(label = prop_recomienda),
    vjust = 0.05, size = 4, color = "white",
    fill = "#7c0041", show.legend = F
  ) +
  scale_y_continuous(labels = scales::percent_format(), limits = c(0,1)) +
  scale_x_continuous(labels = label_p3, breaks = c(1,2,3,4,5)) +
  labs(
    title = "Probabilidad de recomendación según\nsatisfacción con el servicio",
    x = "Satisfacción con el servicio",
    y = "Usuarios que recomendarían el sistema"
  ) +
  theme_fivethirtyeight()
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       2


