import numpy as np
import os
import pandas as pd

# 1. Configuración de nombres de archivos
archivo_entrada = "airbnb_sudamerica_master.csv"
archivo_salida = "airbnb_sudamerica_precios_convertidos.csv"

print("🚀 Iniciando el proceso de conversión de precios...")

try:
    # 2. Cargar el archivo CSV
    df = pd.read_csv(archivo_entrada)
    print(f"   📊 Archivo cargado con éxito. Total de registros: {len(df)}")

    # =========================================================================
    # 3. LIMPIEZA SEGURA CON EXPRESIONES REGULARES (Evita el borrado total)
    # =========================================================================
    
    # Eliminamos espacios en blanco al inicio y al final de los textos
    df['price'] = df['price'].astype(str).str.strip()
    
    # Reemplazamos de golpe el signo $ y las comas usando expresiones regulares
    df['price'] = df['price'].str.replace(r'[\$,]', '', regex=True)
    
    # Convertimos a tipo numérico de Pandas. Las celdas corruptas o vacías pasarán a ser NaN
    df['price'] = pd.to_numeric(df['price'], errors='coerce')
    
    # Ahora sí, eliminamos únicamente las filas que realmente no tienen precio registrado
    df = df.dropna(subset=['price'])
    
    print(f"   🧹 Filas vacías eliminadas. Registros válidos a procesar: {len(df)}")
    # =========================================================================

    # 4. Definición de las condiciones y factores de conversión de moneda
    condiciones = [
        df["region_origen"] == "Rio De Janeiro",
        df["region_origen"] == "Sao Paulo",
        df["region_origen"] == "Bogota",
        df["region_origen"] == "Buenos Aires",
        df["region_origen"] == "Santiago",
    ]

    factores = [
        df["price"] * 0.18,      # Rio De Janeiro
        df["price"] * 0.18,      # Sao Paulo
        df["price"] * 0.00028,   # Bogota
        df["price"] * 0.00059,   # Buenos Aires
        df["price"] * 0.00091,   # Santiago
    ]

    # 5. Aplicar la conversión vectorizada
    df["price"] = np.select(condiciones, factores, default=df["price"])

    # Redondeamos a 2 decimales para obtener precios limpios
    df["price"] = df["price"].round(2)

    print("   ✅ Conversión de precios aplicada correctamente.")

    # 6. Guardar los resultados en un nuevo archivo
    df.to_csv(archivo_salida, index=False)
    print(f"💾 Archivo guardado con éxito como: '{archivo_salida}'")

except FileNotFoundError:
    print(f"❌ Error: No se pudo encontrar el archivo '{archivo_entrada}'.")
except KeyError as e:
    print(f"❌ Error: Falta una columna obligatoria en tu archivo CSV. Detalle: {e}")
except Exception as e:
    print(f"❌ Ocurrió un error inesperado: {e}")