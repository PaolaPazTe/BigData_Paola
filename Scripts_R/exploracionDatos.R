# ==============================================================================
# SCRIPT 3: BATERÍA DE CONSULTAS DE EXPLORACIÓN (EDA)
# ==============================================================================

library(tidyverse)

# Cargamos el dataset preprocesado y limpio
df <- read_csv("airbnb_sudamerica_clean.csv")
print("🔍 Dataset cargado. Iniciando batería de consultas de exploración...")

# =====================================================================
# EJERCICIO 1: Top 5 de Alojamientos Más Caros
# Muestra cómo ordenar datos y seleccionar columnas específicas.
# =====================================================================
print("\n📌 1. TOP 5 ALOJAMIENTOS MÁS CAROS:")

top_caros <- df %>% 
  arrange(desc(price)) %>% 
  select(name, region_origen, price, room_type) %>% 
  head(5)

print(as.data.frame(top_caros)) # Convertimos a data.frame básico para una impresión limpia en consola


# =====================================================================
# EJERCICIO 2: Precio Promedio y Total de Alojamientos por Región
# Enseña el uso fundamental de group_by() y summarise().
# =====================================================================
print("\n📌 2. RESUMEN DEL MERCADO POR REGIÓN (Precio Promedio y Volumen):")

resumen_region <- df %>% 
  group_by(region_origen) %>% 
  summarise(
    precio_promedio = round(mean(price, na.rm = TRUE), 2),
    total_alojamientos = n() # n() cuenta los registros en R, equivalente a count
  ) %>% 
  arrange(desc(precio_promedio))

print(resumen_region)


# =====================================================================
# EJERCICIO 3: El Efecto "Superhost"
# Filtrado analítico para comprobar métricas de comportamiento de hosts.
# =====================================================================
print("\n📌 3. COMPARATIVA: ¿SER SUPERHOST MARCA LA DIFERENCIA?")

efecto_superhost <- df %>% 
  filter(review_scores_rating > 0) %>% 
  group_by(host_is_superhost) %>% 
  summarise(
    precio_medio = round(mean(price, na.rm = TRUE), 2),
    puntuacion_media = round(mean(review_scores_rating, na.rm = TRUE), 2),
    total_propiedades = n()
  )

print(efecto_superhost)


# =====================================================================
# EJERCICIO 4: Filtrado Avanzado Multicriterio (Oportunidades de Inversión)
# Simula una petición real mediante condiciones lógicas cruzadas complejas.
# =====================================================================
print("\n📌 4. BÚSQUEDA DE OPORTUNIDADES (Filtro Cruzado Complejo):")

# En R se usa el operador lógico & de forma directa dentro de filter()
oportunidades <- df %>% 
  filter(
    region_origen == "Bogota" & 
    room_type == "Entire home/apt" & 
    price < 80 & 
    accommodates >= 4 & 
    review_scores_rating >= 4.5
  )

print(paste("🎯 Se han encontrado", nrow(oportunidades), "opciones que cumplen los requisitos del inversor."))

# Mostramos solo las primeras 5 seleccionando columnas de interés
oportunidades_vista <- oportunidades %>% 
  select(name, neighbourhood_cleansed, price, review_scores_rating) %>% 
  head(5)

print(as.data.frame(oportunidades_vista))


# =====================================================================
# EJERCICIO 5: Distribución del Tipo de Alojamiento por Región (Matriz de Contingencia)
# Muestra cómo cruzar dos variables categóricas. Ideal antes de hacer un ggplot.
# =====================================================================
print("\n📌 5. MATRIZ DE DISTRIBUCIÓN: TIPO DE ALOJAMIENTO POR REGIÓN:")

# En R, la función nativa table() genera la matriz de contingencia exacta de un crosstab
matriz_tipos <- table(df$region_origen, df$room_type)
print(matriz_tipos)

# =====================================================================
# EJERCICIO 6: Top 5 de Alojamientos Más Baratos de Sudamerica
# Muestra cómo ordenar datos y seleccionar columnas específicas para visualización rápida
print("\n📌 6. TOP 5 ALOJAMIENTOS MÁS BARATOS EN SUDAMERICA:")

print("\n📌 1. TOP 5 ALOJAMIENTOS MÁS CAROS:")

top_baratos <- df %>% 
  arrange((price)) %>% 
  select(name, region_origen, price, room_type) %>% 
  head(5)

print(as.data.frame(top_baratos)) # Convertimos a data.frame básico para una impresión limpia en consola

# =====================================================================
# EJERCICIO 7: Distribución del Tipo de Alojamiento por Región (Matriz de Contingencia)
# Muestra cómo cruzar tres variables categóricas usando crosstab, ideal antes de graficar barras apiladas.
# =====================================================================
print("\n📌 7. MATRIZ DE DISTRIBUCIÓN: PRECIO PROMEDIO POR TIPO DE ALOJAMIENTO POR REGIÓN:")

# 1. Calculamos los promedios y pivotamos a formato de matriz (crosstab)
matriz_promedios <- df %>%
  group_by(region_origen, room_type) %>%
  summarise(
    price = round(mean(price, na.rm = TRUE), 2), .groups = 'drop') %>%
  pivot_wider(names_from = room_type, values_from = price)

# 2. Aplicamos el formato corregido usando format() para la coma de miles y decimales
matriz_formateada <- matriz_promedios %>%
  mutate(across(-region_origen, ~ ifelse(is.na(.), "N/A", 
                                         paste0("€", format(., big.mark = ",", nsmall = 2, trim = TRUE))
  )))

# Imprimimos el resultado
print(matriz_formateada)

# =====================================================================
# EJERCICIO 8: Top 5 Barrios Más Caros por región de Sudamerica
# =====================================================================
print("\n📌 8. TOP 5 BARRIOS MÁS COSTOSOS POR REGIÓN EN SUDAMERICA:")

top_5_promedio_region <- df %>%
  # 1 y 2. Agrupamos por región y barrio, calculamos el promedio y redondeamos
  group_by(region_origen, neighbourhood_cleansed) %>%
  summarise(precio_promedio = round(mean(price, na.rm = TRUE), 2), .groups = "drop") %>%
  
  # 3 y 4. Ordenamos de mayor a menor y extraemos los 5 barrios más altos de cada región
  group_by(region_origen) %>%
  arrange(desc(precio_promedio), .by_group = TRUE) %>%
  slice_head(n = 5) %>%
  ungroup() %>%
  
  # 5. Ordenamos estéticamente por Región (A-Z) y Precio Promedio (Mayor a Menor)
  arrange(region_origen, desc(precio_promedio)) %>%
  
  # Si quieres mostrar el símbolo de euros (€) en el reporte final:
  mutate(precio_promedio = paste0("€", format(precio_promedio, big.mark = ",", decimal.mark = ".", nsmall = 2, trim = TRUE)))

# Imprimimos el resultado final sin índices de fila
print(as.data.frame(top_5_promedio_region), row.names = FALSE)

# =====================================================================
# EJERCICIO 9: (Identificar Rangos de Precio)
# =====================================================================
print("\n📌 9. MATRIZ DE DISTRIBUCIÓN: CANTIDAD DE ALOJAMIENTOS POR REGIÓN Y RANGO DE PRECIOS:")

# 1. Definimos los límites usando Inf para representar el infinito y las etiquetas
limites <- c(10, 200, 400, 600, 800, Inf)
etiquetas <- c("10-200", "200-400", "400-600", "600-800", ">800")

# 2. Creamos la nueva columna con el rango asignado a cada precio
df <- df %>%
  mutate(rango_precio = cut(price, breaks = limites, labels = etiquetas, right = FALSE))

# 3. Generamos la matriz cruzada (crosstab) por Región y Rango de Precio
matriz_rangos <- df %>%
  # Contamos cuántos registros hay por combinación (filtra los NA si existieran en los rangos)
  filter(!is.na(rango_precio)) %>% 
  count(region_origen, rango_precio) %>%
  # Pivotamos para transformarlo en una matriz (tabla de contingencia)
  pivot_wider(names_from = rango_precio, values_from = n, values_fill = 0)

# Imprimimos el resultado de la matriz
print(matriz_rangos)

# =====================================================================
# EJERCICIO 10: MATRIZ DE DISTRIBUCIÓN: CANTIDAD DE ALOJAMIENTOS POR REGIÓN Y RANGO DE PRECIOS %

# =====================================================================
print("\n📌 10. MATRIZ DE DISTRIBUCIÓN: CANTIDAD DE ALOJAMIENTOS POR REGIÓN Y RANGO DE PRECIOS %:")


matriz_porcentajes <- df %>%
  filter(!is.na(rango_precio)) %>% 
  # 1. Contamos las frecuencias
  count(region_origen, rango_precio) %>%
  # 2. Calculamos el porcentaje por cada región (fila)
  group_by(region_origen) %>%
  mutate(porcentaje = (n / sum(n)) * 100) %>%
  ungroup() %>%
  # 3. Formateamos estéticamente a texto con "%"
  mutate(porcentaje = paste0(format(round(porcentaje, 2), nsmall = 2), "%")) %>%
  # 4. Seleccionamos las columnas necesarias y pivotamos a matriz
  select(region_origen, rango_precio, porcentaje) %>%
  pivot_wider(names_from = rango_precio, values_from = porcentaje, values_fill = "0.00%")

print(matriz_porcentajes)

# =====================================================================
# EJERCICIO 11: Precio Promedio por Región graph
# =====================================================================
print("\n📌 11. RESUMEN DEL MERCADO POR REGIÓN GRÁFICO (Precio Promedio):")

# =====================================================================
# 1 y 2. AGRUPACIÓN, RESUMEN Y ORDENACIÓN (Pandas -> dplyr)
# =====================================================================
resumen_region <- df %>%
  group_by(region_origen) %>%
  summarise(
    precio_promedio = round(mean(price, na.rm = TRUE), 2),
    total_alojamientos = n() # n() equivale a 'count' en R
  ) %>%
  # Para que el gráfico mantenga el orden de mayor a menor precio promedio,
  # convertimos la región en un factor ordenado por el precio.
  mutate(region_origen = reorder(region_origen, -precio_promedio))

# =====================================================================
# 3 a 7. CREACIÓN Y CONFIGURACIÓN DEL GRÁFICO (Seaborn -> ggplot2)
# =====================================================================
# Ajustamos las dimensiones de salida por defecto en la consola si fuera necesario, 
# pero ggplot se adapta automáticamente al contenedor.

ggplot(resumen_region, aes(x = region_origen, y = precio_promedio, fill = precio_promedio)) +
  # 4. Crear el gráfico de barras (stat = "identity" asegura usar el valor numérico de 'y')
  geom_bar(stat = "identity", show.legend = FALSE) +
  
  # Usamos una paleta degradada azul invertida ('Blues') como 'Blues_r' de Seaborn
  scale_fill_distiller(palette = "Blues", direction = 1) +
  
  # 5. Añadir etiquetas de datos sobre cada barra con formato numérico (.2f)
  geom_text(
    aes(label = sprintf("%.2f", precio_promedio)),
    vjust = -0.5,           # Empuja el texto ligeramente hacia arriba de la barra
    fontface = "bold",
    size = 3.5
  ) +
  
  # 6. Personalizar títulos, ejes y estilo de fondo (theme_minimal es el whitegrid de R)
  labs(
    title = "Precio Promedio de Alojamientos por Región",
    x = "Región de Origen",
    y = "Precio Promedio ($)"
  ) +
  theme_minimal(base_size = 12) + # Define el tamaño de fuente general
  theme(
    plot.title = element_text(face = "bold", size = 16, hjust = 0.5), # Título en negrita y centrado
    axis.title = element_text(size = 12),
    axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)      # Rotación de etiquetas a 45°
  ) +
  
  # 7. Ajustar límites del eje Y para que las etiquetas de texto no se corten arriba
  ylim(0, max(resumen_region$precio_promedio) * 1.1)


# =====================================================================
# EJERCICIO 12: Precio Promedio y Total Alojamientos Por Región
# =====================================================================
print("\n📌 12. RESUMEN DEL MERCADO POR REGIÓN GRÁFICO (Precio Promedio Y Volumen):")


# 1. Agrupación y Resumen de Datos
resumen_region <- df %>%
  group_by(region_origen) %>%
  summarise(
    precio_promedio = round(mean(price, na.rm = TRUE), 2),
    total_alojamientos = n(),
    .groups = "drop"
  )

# 2. Paso clave para simplificar el gráfico: Convertir a formato largo
resumen_largo <- resumen_region %>%
  pivot_longer(
    cols = c(precio_promedio, total_alojamientos), 
    names_to = "metrica", 
    values_to = "valor"
  ) %>%
  # Modificamos los nombres de los paneles para que queden estéticos en el gráfico
  mutate(
    metrica = ifelse(metrica == "precio_promedio", "Precio Promedio ($)", "Cantidad Total de Alojamientos"),
    region_origen = reorder(region_origen, -valor) # Ordena de mayor a menor
  )

# 3. Construcción del Gráfico Doble en Paralelo
ggplot(resumen_largo, aes(x = region_origen, y = valor, fill = metrica)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  
  # Añadir las etiquetas numéricas de forma inteligente sobre cada barra
  geom_text(
    aes(label = ifelse(grepl("\\$", metrica), sprintf("$%.2f", valor), format(valor, big.mark = ","))),
    vjust = -0.5, fontface = "bold", size = 3
  ) +
  
  # ESTA LÍNEA HACE LA MAGIA: Divide en 2 columnas con escalas independientes para el eje Y
  facet_wrap(~metrica, scales = "free_y", ncol = 2) +
  
  # Paletas de colores personalizadas para cada panel (Azul y Naranja)
  scale_fill_manual(values = c("Cantidad Total de Alojamientos" = "#F97316", "Precio Promedio ($)" = "#2563EB")) +
  
  # Títulos y personalización estética limpia (Estilo whitegrid)
  labs(
    title = "Análisis Comparativo Regional: Tarifas vs Oferta de Mercado",
    x = "Región de Origen", y = NULL
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold", size = 15, hjust = 0.5, margin = margin(b = 15)),
    strip.text = element_text(face = "bold", size = 12), # Título de cada panel
    axis.text.x = element_text(angle = 45, hjust = 1)
  )


# =====================================================================
# EJERCICIO 13: Precio Promedio Por tipo de Alojamiento y Región HeatMap
# =====================================================================
print("\n📌 13. HEAT MAP PRECIO PROMEDIO POR TIPO DE ALOJAMIENTO Y REGIÓN:")

# 1. Calculamos los promedios (sin pivotar a matriz para facilitar el gráfico)
datos_heatmap <- df %>%
  group_by(region_origen, room_type) %>%
  summarise(precio_promedio = round(mean(price, na.rm = TRUE), 2), .groups = "drop")

# =====================================================================
# GENERACIÓN DEL MAPA DE CALOR (HEATMAP)
# =====================================================================
ggplot(datos_heatmap, aes(x = room_type, y = region_origen, fill = precio_promedio)) +
  # Creamos los cuadros del mapa de calor con bordes blancos delgados (linewidths=0.5)
  geom_tile(color = "white", linewidth = 0.5) +
  
  # 'annot=True' y 'fmt=".2f"': Escribimos el texto de los precios dentro de cada celda
  geom_text(aes(label = sprintf("%.2f", precio_promedio)), 
            color = "black", fontface = "bold", size = 3.5) +
  
  # 'cmap="YlOrRd"': Paleta secuencial elegante de Amarillo a Rojo
  scale_fill_distiller(palette = "YlOrRd", direction = 1, 
                       name = "Precio Promedio (€)") +
  
  # Personalización de títulos y etiquetas
  labs(
    title = "Matriz de Distribución: Precio Promedio por Tipo de Alojamiento y Región",
    x = "Tipo de Alojamiento (Room Type)",
    y = "Región de Origen"
  ) +
  
  # Ajuste de estilo (Elimina fondos grises y configura rotaciones)
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5, margin = margin(b = 20)),
    axis.title.x = element_text(margin = margin(t = 10)),
    axis.title.y = element_text(margin = margin(r = 10)),
    axis.text.x = element_text(angle = 15, hjust = 1), # Rotación del eje X
    panel.grid = element_blank()                        # Quita las líneas de cuadrícula del fondo
  )

# =====================================================================
# EJERCICIO 14: Rangos Precio Promedio Por Región (Rango Mayor concentración 200 Euros) 
# =====================================================================
print("\n📌 14. RANGO PRECIO PROMEDIO POR REGIÓN:")

# =====================================================================
# 1, 2 y 3. FILTRADO Y CREACIÓN DE RANGOS
# =====================================================================
df_filtrado <- df %>%
  filter(price <= 200) %>%
  mutate(
    rango_precio = cut(price, 
                       breaks = c(10, 50, 100, 150, 200), 
                       labels = c("10-50", "50-100", "100-150", "150-200"), 
                       right = FALSE)
  ) %>%
  # Quitamos registros que queden fuera de los rangos si los hubiera
  filter(!is.na(rango_precio))

# =====================================================================
# 4. GENERACIÓN DEL GRÁFICO (BARRAS APILADAS)
# =====================================================================
ggplot(df_filtrado, aes(x = region_origen, fill = rango_precio)) +
  # kind="bar", stacked=True: ggplot apila por defecto al usar geom_bar()
  geom_bar(position = "stack", width = 0.8) +
  
  # colormap="YlGnBu": Usamos exactamente la misma paleta secuencial de Amarillo-Verde-Azul
  scale_fill_brewer(palette = "YlGnBu", name = "Rango Detallado (€)") +
  
  # Formatear el eje Y para agregar separadores de miles de forma nativa
  scale_y_continuous(labels = function(x) format(x, big.mark = ",")) +
  
  # Personalización del diseño y títulos
  labs(
    title = "Cantidad de Alojamientos por Rangos de Precios y Región (Hasta 200 €)",
    x = "Región de Origen",
    y = "Cantidad Absoluta de Propiedades"
  ) +
  
  # style="whitegrid": estilo limpio con rejilla blanca de fondo
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold", size = 14, hjust = 0.5, margin = margin(b = 20)),
    axis.text.x = element_text(angle = 45, hjust = 1), # Rotación del eje X a 45°
    legend.position = "right",                         # Leyenda a la derecha de forma limpia
    legend.title = element_text(face = "bold")
  )



