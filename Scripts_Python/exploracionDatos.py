import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Cargamos el dataset preprocesado y limpio
# df = pd.read_csv("airbnb_sudamerica_clean.csv", low_memory=False) #cuando buscamos el archivo en el PC
file_id = '1EaYOzwb8NLwZh8pUyY3aMhjxNRwCCvbf'
url ='https://drive.google.com/drive/folders/{file_id}'
df = pd.read_csv(url)
#para buscar en una ruta 
print("🔍 Dataset cargado. Iniciando batería de consultas de exploración...")

# =====================================================================
# EJERCICIO 1: Top 5 de Alojamientos Más Caros de Sudamerica
# Muestra cómo ordenar datos y seleccionar columnas específicas para visualización rápida.
# =====================================================================
print("\n📌 1. TOP 5 ALOJAMIENTOS MÁS CAROS EN SUDAMERICA:")
columnas_vista = ['name', 'region_origen', 'price', 'room_type']
top_caros = df.sort_values(by='price', ascending=False)[columnas_vista].head(5)
print(top_caros.to_string(index=False))


# =====================================================================
# EJERCICIO 2: Precio Promedio y Total de Alojamientos por Región
# Enseña el uso fundamental de .groupby() y la agregación de múltiples métricas.
# =====================================================================
print("\n📌 2. RESUMEN DEL MERCADO POR REGIÓN (Precio Promedio y Volumen):")
resumen_region = df.groupby('region_origen').agg(
    precio_promedio=('price', 'mean'),
    total_alojamientos=('id', 'count')
).sort_values(by='precio_promedio', ascending=False)

# Formateamos el precio a dos decimales para una lectura limpia
resumen_region['precio_promedio'] = resumen_region['precio_promedio'].round(2)
print(resumen_region)


# =====================================================================
# EJERCICIO 3: El Efecto "Superhost"
# Filtrado analítico para comprobar si los Superhosts cobran más o tienen mejores notas.
# =====================================================================
print("\n📌 3. COMPARATIVA: ¿SER SUPERHOST MARCA LA DIFERENCIA?")
# Filtramos solo los que tienen reseñas válidas (puntuación > 0)
df_con_resenas = df[df['review_scores_rating'] > 0]

efecto_superhost = df_con_resenas.groupby('host_is_superhost').agg(
    precio_medio=('price', 'mean'),
    puntuacion_media=('review_scores_rating', 'mean'),
    total_propiedades=('id', 'count')
).round(2)
print(efecto_superhost)


# =====================================================================
# EJERCICIO 4: Filtrado Avanzado Multicriterio (Oportunidades de Inversión)
# Simula una petición real de un inversor: "Busco apartamentos enteros en Sudamerica, 
# económicos (<80€), con buena puntuación y capacidad para mínimo 4 personas".
# =====================================================================
print("\n📌 4. BÚSQUEDA DE OPORTUNIDADES (Filtro Cruzado Complejo):")
filtros = (
    (df['region_origen'] == 'Bogota') & 
    (df['room_type'] == 'Entire home/apt') & 
    (df['price'] < 80) & 
    (df['accommodates'] >= 4) & 
    (df['review_scores_rating'] >= 4.5)
)

oportunidades = df[filtros][['name', 'neighbourhood_cleansed', 'price', 'review_scores_rating']]
print(f"🎯 Se han encontrado {len(oportunidades)} opciones que cumplen los requisitos del inversor.")
print(oportunidades.head(5).to_string(index=False))  # Mostramos solo las primeras 5 para no saturar la pantalla


# =====================================================================
# EJERCICIO 5: Distribución del Tipo de Alojamiento por Región (Matriz de Contingencia)
# Muestra cómo cruzar dos variables categóricas usando crosstab, ideal antes de graficar barras apiladas.
# =====================================================================
print("\n📌 5. MATRIZ DE DISTRIBUCIÓN: TIPO DE ALOJAMIENTO POR REGIÓN:")
matriz_tipos = pd.crosstab(df['region_origen'], df['room_type'])
print(matriz_tipos)




# =====================================================================
# EJERCICIO 6: Top 5 de Alojamientos Más Baratos de Sudamerica
# Muestra cómo ordenar datos y seleccionar columnas específicas para visualización rápida
print("\n📌 6. TOP 5 ALOJAMIENTOS MÁS BARATOS EN SUDAMERICA:")
columnas_vista = ['name', 'region_origen', 'price', 'room_type']
top_caros = df.sort_values(by='price', ascending=True)[columnas_vista].head(5)
print(top_caros.to_string(index=False))

# =====================================================================
# EJERCICIO 7: Distribución del Tipo de Alojamiento por Región (Matriz de Contingencia)
# Muestra cómo cruzar tres variables categóricas usando crosstab, ideal antes de graficar barras apiladas.
# =====================================================================
print("\n📌 7. MATRIZ DE DISTRIBUCIÓN: PRECIO PROMEDIO POR TIPO DE ALOJAMIENTO POR REGIÓN:")
matriz_promedios = pd.crosstab(df['region_origen'], df['room_type'], df['price'], aggfunc='mean')
matriz_promedios = matriz_promedios.round(2)
print(matriz_promedios.map(
    lambda x: f"€{x:,.2f}" if pd.notna(x) else "N/A"))



# =====================================================================
# EJERCICIO 8: Top 5 Barrios Más Caros por región de Sudamerica
# =====================================================================
print("\n📌 8. TOP 5 BARRIOS MÁS COSTOSOS POR REGIÓN EN SUDAMERICA:")

# 1. Agrupamos por región y barrio para calcular el precio promedio de cada uno

barrios_promedio = (
    df.groupby(["region_origen", "neighbourhood_cleansed"])["price"]
    .mean()
    .reset_index()
)

# 2. Renombramos la columna para dejar claro que ahora es un promedio y redondeamos

barrios_promedio = barrios_promedio.rename(columns={"price": "precio_promedio"})
barrios_promedio["precio_promedio"] = barrios_promedio["precio_promedio"].round(
    2
)

# 3. Ordenamos de mayor a menor por el precio promedio obtenido

barrios_ordenados = barrios_promedio.sort_values(
    by="precio_promedio", ascending=False
)

# 4. Agrupamos por región y extraemos los 5 barrios con el promedio más alto de cada una

top_5_promedio_region = barrios_ordenados.groupby("region_origen").head(5)

# 5. Ordenamos estéticamente por Nombre de Región (A-Z) y Precio Promedio (Mayor a Menor)
top_5_promedio_region = top_5_promedio_region.sort_values(
    by=["region_origen", "precio_promedio"], ascending=[True, False]
)

# Si quieres mostrar el símbolo de euros (€) en el reporte final:
top_5_promedio_region['precio_promedio'] = top_5_promedio_region['precio_promedio'].map(lambda x: f"€{x:,.2f}")

print(top_5_promedio_region.to_string(index=False))

# =====================================================================
# EJERCICIO 9: Filtrado Avanzado Multicriterio (Identificar Rangos de Precio)
# Simula una petición real de un inversor: "Busco ALOJAMIENTO en Sudamerica, 
# Costosos (>300€), con buena puntuación".
# =====================================================================
print("\n📌 9. MATRIZ DE DISTRIBUCIÓN: CANTIDAD DE ALOJAMIENTOS POR REGIÓN Y RANGO DE PRECIOS:")

# 1. Definimos los límites usando float('inf') para representar el infinito (>800)
limites = [10, 200, 400, 600, 800, float("inf")]
etiquetas = ["10-200", "200-400", "400-600", "600-800", ">800"]

# 2. Creamos una nueva columna temporal en el DataFrame con el rango asignado a cada precio
df["rango_precio"] = pd.cut(
    df["price"], bins=limites, labels=etiquetas, right=False
)

# 3. Generamos la matriz cruzada (crosstab) por Región y Rango de Precio
matriz_rangos = pd.crosstab(df["region_origen"], df["rango_precio"])
print(matriz_rangos)

# =====================================================================
# EJERCICIO 10: MATRIZ DE DISTRIBUCIÓN: CANTIDAD DE ALOJAMIENTOS POR REGIÓN Y RANGO DE PRECIOS %

# =====================================================================
print("\n📌 10. MATRIZ DE DISTRIBUCIÓN: CANTIDAD DE ALOJAMIENTOS POR REGIÓN Y RANGO DE PRECIOS %:")

# 1. Definimos los límites usando float('inf') para representar el infinito (>800)
limites = [10, 200, 400, 600, 800, float("inf")]
etiquetas = ["10-200", "200-400", "400-600", "600-800", ">800"]

# 2. Creamos una nueva columna temporal en el DataFrame con el rango asignado a cada precio
df["rango_precio"] = pd.cut(
    df["price"], bins=limites, labels=etiquetas, right=False
)

# 3. Generamos la matriz cruzada (crosstab) por Región y Rango de Precio
matriz_rangos = pd.crosstab(df["region_origen"], df["rango_precio"],normalize='index'
) * 100

print(matriz_rangos.to_string(float_format=lambda valor: f'{valor:.2f}%'))


# =====================================================================
# EJERCICIO 11: Precio Promedio por Región graph
# =====================================================================
print("\n📌 11. RESUMEN DEL MERCADO POR REGIÓN GRÁFICO (Precio Promedio):")

resumen_region = df.groupby('region_origen').agg(
    precio_promedio=('price', 'mean'),
    total_alojamientos=('id', 'count')
).sort_values(by='precio_promedio', ascending=False)

# Formateamos el precio a dos decimales para una lectura limpia
resumen_region['precio_promedio'] = resumen_region['precio_promedio'].round(2)

# 3. Configurar el estilo y tamaño del gráfico
sns.set_theme(style="whitegrid")
plt.figure(figsize=(12, 6))

# 4. Crear el gráfico de barras
# Usamos un paleta de colores degradada ('Blues_r') para una estética limpia
barplot = sns.barplot(
    x="region_origen",
    y="precio_promedio",
    data=resumen_region,
    palette="Blues_r",
    hue="region_origen",
    legend=False,
)

# 5. Añadir etiquetas de datos sobre cada barra (opcional pero muy útil)
for p in barplot.patches:
    barplot.annotate(
        format(p.get_height(), ".2f"),
        (p.get_x() + p.get_width() / 2.0, p.get_height()),
        ha="center",
        va="center",
        xytext=(0, 9),
        textcoords="offset points",
        fontsize=10,
        fontweight="bold",
    )

# 6. Personalizar títulos y ejes
plt.title(
    "Precio Promedio de Alojamientos por Región", fontsize=16, fontweight="bold"
)
plt.xlabel("Región de Origen", fontsize=12)
plt.ylabel("Precio Promedio ($)", fontsize=12)
plt.xticks(rotation=45, ha="right")  # Rotamos los nombres si son muy largos

# 7. Ajustar y mostrar/guardar la gráfica
plt.tight_layout()
plt.show()  # Muestra la ventana emergente con el gráfico


# =====================================================================
# EJERCICIO 12: Precio Promedio y Total Alojamientos Por Región
# =====================================================================
print("\n📌 12. RESUMEN DEL MERCADO POR REGIÓN GRÁFICO (Precio Promedio Y Volumen):")

resumen_region = df.groupby('region_origen').agg(
    precio_promedio=('price', 'mean'),
    total_alojamientos=('id', 'count')
).sort_values(by='precio_promedio', ascending=False)

# Formateamos el precio a dos decimales para una lectura limpia
resumen_region['precio_promedio'] = resumen_region['precio_promedio'].round(2)


# CONFIGURACIÓN DE LOS DOS GRÁFICOS EN PARALELO

sns.set_theme(style="whitegrid")

# Creamos una figura con 1 fila y 2 columnas independientes
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(16, 7))


# PANEL 1: Gráfico de Barras para PRECIO PROMEDIO

sns.barplot(
    x="region_origen",
    y="precio_promedio",
    data=resumen_region,
    palette="Blues_r",
    hue="region_origen",
    legend=False,
    ax=ax1,  # Le indicamos que va en el primer panel
)
ax1.set_title(
    "Precio Promedio por Región", fontsize=14, fontweight="bold", pad=15
)
ax1.set_xlabel("Región de Origen", fontsize=11)
ax1.set_ylabel("Precio Promedio ($)", fontsize=11)
ax1.set_xticklabels(
    ax1.get_xticklabels(), rotation=45, ha="right"
)  # Corregido para subplots

# Etiquetas de datos para el precio
for p in ax1.patches:
    if p.get_height() > 0:
        ax1.annotate(
            f"${p.get_height():.2f}",
            (p.get_x() + p.get_width() / 2.0, p.get_height()),
            ha="center",
            va="center",
            xytext=(0, 8),
            textcoords="offset points",
            fontsize=9,
            fontweight="bold",
        )


# PANEL 2: Gráfico de Barras para CANTIDAD DE ALOJAMIENTOS

sns.barplot(
    x="region_origen",
    y="total_alojamientos",
    data=resumen_region,
    palette="Oranges_r",  # Color contrastante para diferenciar los datos
    hue="region_origen",
    legend=False,
    ax=ax2,  # Le indicamos que va en el segundo panel
)
ax2.set_title(
    "Cantidad Total de Alojamientos", fontsize=14, fontweight="bold", pad=15
)
ax2.set_xlabel("Región de Origen", fontsize=11)
ax2.set_ylabel("Total de Propiedades", fontsize=11)
ax2.set_xticklabels(
    ax2.get_xticklabels(), rotation=45, ha="right"
)  # Corregido para subplots

# Etiquetas de datos para la cantidad de alojamientos
for p in ax2.patches:
    if p.get_height() > 0:
        ax2.annotate(
            f"{int(p.get_height()):,}",  # Con comas para separar los miles
            (p.get_x() + p.get_width() / 2.0, p.get_height()),
            ha="center",
            va="center",
            xytext=(0, 8),
            textcoords="offset points",
            fontsize=9,
            fontweight="bold",
        )

# AJUSTES GENERALES Y DESPLIEGUE

plt.suptitle(
    "Análisis Comparativo Regional: Tarifas vs Oferta de Mercado",
    fontsize=18,
    fontweight="bold",
    y=0.98,
)
plt.tight_layout()
plt.show()

# =====================================================================
# EJERCICIO 13: Precio Promedio Por tipo de Alojamiento y Región HeatMap
# =====================================================================
print("\n📌 13. HEAT MAP PRECIO PROMEDIO POR TIPO DE ALOJAMIENTO Y REGIÓN:")


# 1. Tu matriz original (asegúrate de que ya esté ejecutada arriba)
matriz_promedios = pd.crosstab(
    df["region_origen"], df["room_type"], values=df["price"], aggfunc="mean"
)
matriz_promedios = matriz_promedios.round(2)

# =====================================================================
# GENERACIÓN DEL MAPA DE CALOR (HEATMAP)
# =====================================================================
# Configuramos el estilo general del gráfico
sns.set_theme(style="white")
plt.figure(figsize=(12, 8))

# Creamos el mapa de calor
# - 'annot=True' escribe los precios dentro de cada cuadro.
# - 'fmt=".2f"' asegura que muestre siempre dos decimales.
# - 'cmap="YlOrRd"' usa una paleta elegante que va de Amarillo (barato) a Rojo (caro).
sns.heatmap(
    matriz_promedios,
    annot=True,
    fmt=".2f",
    cmap="YlOrRd",
    linewidths=0.5,  # Añade una línea delgada blanca divisoria entre celdas
    linecolor="white",
    cbar_kws={"label": "Precio Promedio (€)"},  # Título de la barra de color a la derecha
)

# Personalización de títulos y etiquetas
plt.title(
    "Matriz de Distribución: Precio Promedio por Tipo de Alojamiento y Región",
    fontsize=14,
    fontweight="bold",
    pad=20,
)
plt.xlabel("Tipo de Alojamiento (Room Type)", fontsize=12, labelpad=10)
plt.ylabel("Región de Origen", fontsize=12, labelpad=10)

# Rotamos ligeramente las etiquetas de los ejes para que se lean perfectamente
plt.xticks(rotation=15, ha="right")
plt.yticks(rotation=0)

# Ajustar diseño para evitar que se corten los textos laterales
plt.tight_layout()
plt.show()

# =====================================================================
# EJERCICIO 14: Rangos Precio Promedio Por Región (Rango Mayor concentración 200 Euros) 
# =====================================================================
print("\n📌 14. RANGO PRECIO PROMEDIO POR REGIÓN:")

# Filtramos para quedarnos SOLO con propiedades menores o iguales a 200
df_filtrado = df[df["price"] <= 200].copy()

# 1. Definimos los límites 
limites = [10, 50, 100, 150, 200]
etiquetas = ["10-50", "50-100", "100-150", "150-200"]

# 2. Creamos una nueva columna temporal en el DataFrame con el rango asignado a cada precio
df["rango_precio"] = pd.cut(
    df["price"], bins=limites, labels=etiquetas, right=False
)

# 3. Generamos la matriz cruzada (crosstab) por Región y Rango de Precio
matriz_rangos = pd.crosstab(df["region_origen"], df["rango_precio"])
print(matriz_rangos)


# 4. GENERACIÓN DEL GRÁFICO

sns.set_theme(style="whitegrid")

# Crear el gráfico de barras apiladas con cantidades absolutas
ax = matriz_rangos.plot(
    kind="bar", stacked=True, figsize=(14, 7), colormap="YlGnBu", width=0.8
)

# Formatear el eje Y para agregar separadores de miles (ej: 10,000 en vez de 10000)
import matplotlib.ticker as mtick

ax.yaxis.set_major_formatter(mtick.StrMethodFormatter("{x:,.0f}"))

# Personalización del diseño y títulos
plt.title(
    "Cantidad de Alojamientos por Rangos de Precios y Región (Hasta 200 €)",
    fontsize=16,
    fontweight="bold",
    pad=20,
)
plt.xlabel("Región de Origen", fontsize=12, labelpad=10)
plt.ylabel(
    "Cantidad Absoluta de Propiedades", fontsize=12, labelpad=10
)

# Colocar la leyenda de manera limpia a la derecha
plt.legend(
    title="Rango Detallado (€)",
    bbox_to_anchor=(1.02, 1),
    loc="upper left",
    fontsize=10,
    title_fontsize=11,
)

plt.xticks(rotation=45, ha="right")
plt.tight_layout()
plt.show()