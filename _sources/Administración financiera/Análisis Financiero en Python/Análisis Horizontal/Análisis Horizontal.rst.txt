Análisis Horizontal
-------------------

Análisis Horizontal Balance General:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El siguiente gráfico muestra el Análisis Horizontal de las principales
cuentas del Balance General.

El siguiente ejemplo se realizó con el archivo
``AnalisisHorizontal-BG.csv``

Los valores del Análisis Horizontal están con el formato de porcentajes
dentro del archivo, es por esto que se usa esta parte del código:

``# Eliminar el signo de porcentaje (%) y convertir las cadenas de texto a números flotantes. for year in ["2018", "2019", "2020"]:     data_new[year] = data_new[year].str.replace("%", "").astype(float)``

.. code:: ipython3

    import pandas as pd
    import matplotlib.pyplot as plt
    
    # Cargar los datos desde el archivo CSV
    data_path_new = "AnalisisHorizontal-BG.csv"
    # Intentamos cargar el archivo con punto y coma (;) como separador, ya que el formato CSV puede variar.
    data_new = pd.read_csv(data_path_new, sep=";")
    
    # Limpiar y preparar los datos
    # Eliminar el signo de porcentaje (%) y convertir las cadenas de texto a números flotantes.
    for year in ["2018", "2019", "2020", "2021", "2022"]:
        data_new[year] = data_new[year].str.replace("%", "").astype(float)
    
    # Preparar los datos para el gráfico
    # La variable 'x' representa las posiciones en el eje X para cada grupo de barras.
    x = range(len(data_new))
    # 'categories' contiene los nombres de las categorías financieras para usar como etiquetas en el eje X.
    categories = data_new["Unnamed: 0"]
    
    # Crear el gráfico de barras
    fig, ax = plt.subplots(
        figsize=(14, 8)
    )  # Se inicializa una figura y un eje para el gráfico.
    width = 0.17  # Ancho de las barras, para separar los grupos de barras entre sí.
    
    # Definir la paleta de colores utilizando plt.cm.tab20
    colors = plt.cm.tab20.colors
    
    # Dibujar las barras para cada año con un color específico de la paleta.
    ax.bar(x, data_new["2018"], width, label="2018", color=colors[0])
    ax.bar([p + width for p in x], data_new["2019"], width, label="2019", color=colors[4])
    ax.bar([p + width * 2 for p in x], data_new["2020"], width, label="2020", color=colors[8])
    ax.bar([p + width * 3 for p in x], data_new["2021"], width, label="2021", color=colors[9])
    ax.bar([p + width * 4 for p in x], data_new["2022"], width, label="2022", color=colors[10])
    
    # Configurar las etiquetas y el título del gráfico
    ax.set_ylabel("Cambio Porcentual (%)")  # Establece la etiqueta del eje Y.
    ax.set_title(
        "Análisis Horizontal del Balance General de H&M"
    )  # Establece el título del gráfico.
    ax.set_xticks(
        [p + width for p in x]
    )  # Define la posición de las etiquetas en el eje X.
    ax.set_xticklabels(categories)  # Asigna las etiquetas del eje X.
    plt.xticks(
        rotation=45, ha="right"
    )  # Rota las etiquetas del eje X para mejorar la visibilidad.
    
    # Agregar la leyenda al gráfico
    ax.legend()
    
    # Ajustar el layout y mostrar el gráfico
    plt.tight_layout()
    plt.show()



.. image:: output_4_0.png


Análisis Horizontal Estado de Resultados:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El siguiente gráfico muestra el Análisis Horizontal de las principales
cuentas del Estado de Resultados.

El siguiente ejemplo se realizó con el archivo
``AnalisisHorizontal-BG.csv``

Los valores del Análisis Horizontal están con el formato de porcentajes
dentro del archivo, es por esto que se usa esta parte del código:

``# Eliminar el signo de porcentaje (%) y convertir las cadenas de texto a números flotantes. for year in ["2018", "2019", "2020"]:     data_new[year] = data_new[year].str.replace("%", "").astype(float)``

.. code:: ipython3

    import pandas as pd
    import matplotlib.pyplot as plt
    
    # Cargar los datos desde el archivo CSV
    data_path_new = "AnalisisHorizontal-ER.csv"
    # Intentamos cargar el archivo con punto y coma (;) como separador, ya que el formato CSV puede variar.
    data_new = pd.read_csv(data_path_new, sep=";")
    
    # Limpiar y preparar los datos
    # Eliminar el signo de porcentaje (%) y convertir las cadenas de texto a números flotantes.
    for year in ["2018", "2019", "2020", "2021", "2022"]:
        data_new[year] = data_new[year].str.replace("%", "").astype(float)
    
    # Preparar los datos para el gráfico
    # La variable 'x' representa las posiciones en el eje X para cada grupo de barras.
    x = range(len(data_new))
    # 'categories' contiene los nombres de las categorías financieras para usar como etiquetas en el eje X.
    categories = data_new["Unnamed: 0"]
    
    # Crear el gráfico de barras
    fig, ax = plt.subplots(
        figsize=(14, 8)
    )  # Se inicializa una figura y un eje para el gráfico.
    width = 0.17  # Ancho de las barras, para separar los grupos de barras entre sí.
    
    # Definir la paleta de colores utilizando plt.cm.tab20
    colors = plt.cm.tab20.colors
    
    # Dibujar las barras para cada año con un color específico de la paleta.
    ax.bar(x, data_new["2018"], width, label="2018", color=colors[0])
    ax.bar([p + width for p in x], data_new["2019"], width, label="2019", color=colors[4])
    ax.bar([p + width * 2 for p in x], data_new["2020"], width, label="2020", color=colors[8])
    ax.bar([p + width * 3 for p in x], data_new["2021"], width, label="2021", color=colors[9])
    ax.bar([p + width * 4 for p in x], data_new["2022"], width, label="2022", color=colors[10])
    
    # Configurar las etiquetas y el título del gráfico
    ax.set_ylabel("Cambio Porcentual (%)")  # Establece la etiqueta del eje Y.
    ax.set_title(
        "Análisis Horizontal del Estado de Resultados de H&M"
    )  # Establece el título del gráfico.
    ax.set_xticks(
        [p + width for p in x]
    )  # Define la posición de las etiquetas en el eje X.
    ax.set_xticklabels(categories)  # Asigna las etiquetas del eje X.
    plt.xticks(
        rotation=45, ha="right"
    )  # Rota las etiquetas del eje X para mejorar la visibilidad.
    
    # Agregar la leyenda al gráfico
    ax.legend()
    
    # Ajustar el layout y mostrar el gráfico
    plt.tight_layout()
    plt.show()



.. image:: output_8_0.png

