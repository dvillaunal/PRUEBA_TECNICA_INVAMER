# Prueba Técnica - Analista Estadístico INVAMER

Este repositorio contiene mi solución a la prueba técnica para el puesto de Analista Estadístico en INVAMER. La prueba evalúa capacidades en análisis estadístico, diseño de muestreo y resolución de situaciones laborales, utilizando datos de un estudio de satisfacción de usuarios del sistema de transporte masivo.

## Estructura del Proyecto

El proyecto está dividido en tres partes principales, cada una documentada en archivos Quarto (.qmd) que incluyen análisis, código y visualizaciones:

- **PARTE_1.qmd**: Análisis estadístico descriptivo y multidimensional de los datos de satisfacción. Incluye propuestas de muestreo, análisis de variables relevantes y modelos para determinar niveles de satisfacción e impacto de atributos del servicio.

- **PARTE_2.qmd**: Diseño de un método de muestreo probabilístico representativo a nivel nacional y regional, con cálculos de tamaño de muestra y márgenes de error. Se considera un presupuesto limitado y se ajusta el diseño en consecuencia.

- **PARTE_3.qmd**: Respuestas a situaciones hipotéticas de trabajo, enfocadas en prioridades, eficiencia y comunicación de resultados.

### Directorios Adicionales

- `data_raw/`: Contiene los datos originales en formato Excel (prueba_tecnica.xlsx).
- `code/`: Scripts auxiliares en R para formateo de texto y otros procesos.
- `outputs/`: Figuras y tablas generadas durante el análisis.
- `_site/`: Versión renderizada del sitio web en HTML.

## Herramientas Utilizadas

- **Lenguaje**: R para análisis estadístico y manipulación de datos.
- **Entorno**: Quarto para la creación del sitio web y documentación reproducible.
- **Paquetes R**: dplyr, ggplot2, factoextra, entre otros para análisis y visualización.

## Cómo Visualizar

Para ver el sitio web completo:
1. Clona el repositorio.
2. Abre `_site/index.html` en un navegador web.
3. Alternativamente, instala Quarto y ejecuta `quarto preview` en el directorio raíz para una vista interactiva.

El sitio incluye navegación entre las partes, tabla de contenidos y enlaces a GitHub y LinkedIn.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo LICENSE para más detalles.
