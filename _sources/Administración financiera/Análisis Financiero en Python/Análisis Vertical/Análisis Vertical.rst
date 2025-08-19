Análisis Vertical
-----------------

Análisis Vertical Balance General:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

El código crea un gráfico de barras horizontal para las principales
cuentas del Balance General, omitiendo aquellas con menores
proporciones. Facilita el análisis de cuentas negativas, como las
Ganancias acumuladas.

El siguiente ejemplo se realizó con el archivo
``AnalisisVertical-BG.csv``

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    
    # Paso 1: Leer el archivo CSV
    # Se utiliza 'sep=None' y 'engine=python' para detectar automáticamente el delimitador.
    csv_file_path = "AnalisisVertical-BG.csv"
    data = pd.read_csv(csv_file_path, sep=None, engine="python")
    
    # Paso 2: Preprocesamiento de los datos
    # Convertir cadenas de porcentaje a flotantes y manejar caracteres invisibles en la columna de etiquetas
    for col in data.columns[1:]:
        data[col] = data[col].str.replace("%", "").astype(float)
    
    # Renombrar la primera columna a 'Etiquetas' si contiene un carácter invisible
    data.columns = ["Etiquetas" if "﻿" in col else col for col in data.columns]
    
    # Paso 3: Invertir el orden del DataFrame para la visualización
    # Utilizamos [::-1] para invertir el DataFrame, de manera que la primera entrada esté en la parte superior del gráfico de barras.
    data_inverted = data.iloc[::-1]
    
    # Paso 4: Crear un gráfico de barras
    # Establecer el tamaño de la figura y el ancho de las barras
    fig, ax = plt.subplots(figsize=(14, 10))
    bar_width = 0.15
    
    # Usar el mapa de colores tab20 para las barras
    tab20_colors = plt.cm.tab20.colors
    
    # Determinar el número de barras por grupo (número de años en este caso)
    n_bars = len(data.columns) - 1
    
    # Crear las posiciones del eje y para las barras usando numpy
    indices_inverted_csv = np.arange(len(data_inverted))
    
    # Graficar las barras para cada año utilizando un bucle
    for i, year in enumerate(data_inverted.columns[1:]):
        bar_positions = indices_inverted_csv - (n_bars / 2 - i) * bar_width
        ax.barh(
            bar_positions,
            data_inverted[year],
            height=bar_width,
            color=tab20_colors[i],
            edgecolor="black",
            label=year,
        )
    
    # Paso 5: Etiquetar el gráfico
    # Establecer las etiquetas del eje y usando la columna 'Etiquetas' del DataFrame invertido
    ax.set_yticks(indices_inverted_csv)
    ax.set_yticklabels(data_inverted["Etiquetas"])
    
    # Especificar qué etiquetas poner en negrita creando un mapeo basado en las cuentas proporcionadas
    cuentas_en_negrita = [
        "Activos corrientes totales",
        "Total de activos no corrientes",
        "Total de activos",
        "Pasivos corrientes totales",
        "Total de pasivos no corrientes",
        "Total pasivos",
        "Patrimonio total",
    ]
    mapeo_negritas = {
        etiqueta: etiqueta in cuentas_en_negrita for etiqueta in data["Etiquetas"]
    }
    
    # Aplicar el estilo negrita condicionalmente basado en el mapeo
    for etiqueta in ax.get_yticklabels():
        if mapeo_negritas[etiqueta.get_text()]:
            etiqueta.set_weight("bold")
    
    # Añadir una leyenda, etiqueta del eje x y un título al gráfico
    ax.legend(title="Año", loc="upper right")
    ax.set_xlabel("Porcentaje (%)")
    ax.set_title("Análisis Vertical del Balance General de H&M")
    
    # Paso 6: Ajustar el diseño y mostrar la gráfica
    plt.tight_layout()
    plt.show()



.. image:: output_4_0.png


Este gráfico ofrece una alternativa para el análisis vertical del
Balance General, situando las cuentas negativas en la parte inferior. Se
aconseja excluir cuentas totales como Activos corrientes totales,
Activos no corrientes totales, entre otros.

El siguiente ejemplo se realizó con el archivo
``AnalisisVertical-BG-2.csv``

.. code:: ipython3

    # Importar las bibliotecas necesarias
    import matplotlib.pyplot as plt
    import pandas as pd
    
    # Ruta del archivo CSV
    csv_file_path = "AnalisisVertical-BG-2.csv"
    
    # Cargar los datos, usando 'sep=None' y 'engine="python"' para manejar automáticamente el delimitador
    data_csv = pd.read_csv(csv_file_path, sep=None, engine="python")
    
    # Limpiar los datos, eliminando el símbolo de porcentaje y convirtiendo los valores a formato numérico
    data_csv_clean = data_csv.copy()
    for col in data_csv.columns[1:]:  # Excluye la primera columna de etiquetas
        data_csv_clean[col] = data_csv[col].str.replace("%", "").astype(float) / 100
    
    # Convertir la primera columna en el índice del DataFrame
    pivot_data_csv = data_csv_clean.set_index(
        "﻿"
    ).T  # Asume que el nombre de la primera columna es '﻿'
    
    # Configurar el tamaño y el título del gráfico
    fig, ax = plt.subplots(figsize=(12, 8))
    plt.title("Análisis Vertical del Balance General de H&M", fontsize=16)
    
    # Generar el gráfico de barras apiladas
    pivot_data_csv.plot(kind="bar", stacked=True, ax=ax, colormap=plt.cm.tab20)
    
    # Configurar las etiquetas de los ejes y rotar las etiquetas del eje X para mejorar la legibilidad
    plt.xlabel("Año", fontsize=14)
    plt.ylabel("Proporción", fontsize=14)
    plt.xticks(rotation=0)
    
    # Mover la leyenda fuera del gráfico para mejorar la claridad
    plt.legend(title="Cuentas", bbox_to_anchor=(1.05, 1), loc="upper left")
    
    # Ajustar el layout
    plt.tight_layout()
    
    # Mostrar el gráfico
    plt.show()



.. image:: output_7_0.png


Análisis Vertical Estado de Resultados:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para este gráfico, se debe excluir la cuenta base de Ingresos
Operacionales y también omitir cuentas relacionadas con Utilidades o
Ganancias, como Utilidad Bruta y Utilidad Operacional, entre otras.

El siguiente ejemplo se realizó con el archivo
``AnalisisVertical-ER.csv``

.. code:: ipython3

    # Importar las bibliotecas necesarias
    import matplotlib.pyplot as plt
    import pandas as pd
    
    # Ruta del archivo CSV con los datos del Estado de Resultados
    er_file_path = "AnalisisVertical-ER.csv"
    
    # Cargar los datos desde el archivo CSV
    # Se utiliza 'sep=None' y 'engine="python"' para manejar automáticamente el delimitador
    data_er = pd.read_csv(er_file_path, sep=None, engine="python")
    
    # Limpiar los datos, eliminando el símbolo de porcentaje y convirtiendo los valores a formato numérico
    data_er_clean = data_er.copy()
    for col in data_er.columns[1:]:  # Excluye la primera columna de etiquetas
        data_er_clean[col] = data_er[col].str.replace("%", "").astype(float)
    
    # Convertir la primera columna en el índice del DataFrame para facilitar la visualización
    pivot_data_er = data_er_clean.set_index("﻿").T  # '﻿' es el nombre de la primera columna
    
    # Configurar el tamaño y el título del gráfico
    fig, ax = plt.subplots(figsize=(14, 10))
    plt.title("Análisis Vertical del Estado de Resultados de H&M", fontsize=16)
    
    # Generar el gráfico de barras apiladas
    # 'kind='bar'' indica que queremos un gráfico de barras
    # 'stacked=True' para apilar las barras, mostrando la contribución de cada categoría al total
    # 'ax=ax' para dibujar el gráfico en el subplot creado anteriormente
    # 'colormap=plt.cm.tab20c' para usar la paleta de colores especificada
    pivot_data_er.plot(kind="bar", stacked=True, ax=ax, colormap=plt.cm.tab20c)
    
    # Configurar las etiquetas de los ejes y rotar las etiquetas del eje X para mejorar la legibilidad
    plt.xlabel("Año", fontsize=14)
    plt.ylabel("Porcentaje sobre los Ingresos Operacionales", fontsize=14)
    plt.xticks(rotation=0)
    
    # Mover la leyenda fuera del gráfico para evitar que bloquee la visualización
    plt.legend(title="Cuentas", bbox_to_anchor=(1.05, 1), loc="upper left")
    
    # Añadiendo etiquetas de porcentaje en cada segmento de las barras apiladas
    # 'label_type='center'' coloca las etiquetas en el centro de cada segmento
    # 'fontsize=12' y 'color='black'' configuran el tamaño y color del texto de las etiquetas
    for bars in ax.containers:
        ax.bar_label(bars, label_type="center", fontsize=12, color="black", fmt="%.0f%%")
    
    # Ajustar el layout para asegurar que todo el contenido se muestre adecuadamente
    plt.tight_layout()
    
    # Mostrar el gráfico
    plt.show()



.. image:: output_11_0.png


Análisis Vertical KTNO:
~~~~~~~~~~~~~~~~~~~~~~~

El siguiente gráfico analiza el análisis vertical de las cuentas del
KTNO por cada año junto con el valor del KTNO y los Ingresos
Operacionales.

Se debe especificar cuáles son las cuentas del Activo Corriente y del
Pasivo Corriente en la siguiente parte del código:

``activo_corriente = [     "Efectivo y equivalentes al efectivo",     "Cuentas por cobrar",     "Inventarios corrientes", ] pasivos_corrientes = [     "Cuentas por pagar",     "Pasivos por impuestos corrientes", ]``

En la siguiente parte del código modificar ``ncols=6`` para la cantidad
de años.

``# Preparar la visualización fig, axes = plt.subplots(nrows=1, ncols=6, figsize=(20, 8), sharey=True)``

El siguiente ejemplo se realizó con el archivo
``AnalisisVertical-KTNO.csv``

.. code:: ipython3

    # Importar las librerías necesarias
    import pandas as pd
    import matplotlib.pyplot as plt
    
    # Cargar el archivo CSV que contiene los datos de las cuentas
    # Reemplaza 'ruta_del_archivo.csv' con la ruta real de tu archivo
    file_path = "AnalisisVertical-KTNO.csv"
    data = pd.read_csv(file_path, sep=";", index_col=0)
    data = data.apply(
        lambda x: x.str.replace("%", "").astype(float)
    )  # Eliminar el signo % y convertir a flotante
    
    # Definir las cuentas que van en cada barra
    activo_corriente = [
        "Efectivo y equivalentes al efectivo",
        "Cuentas por cobrar",
        "Inventarios corrientes",
    ]
    pasivos_corrientes = [
        "Cuentas por pagar",
        "Pasivos por impuestos corrientes",
    ]
    
    # Preparar la visualización
    fig, axes = plt.subplots(nrows=1, ncols=6, figsize=(22, 8), sharey=True)
    titulos = [
        "2017",
        "2018",
        "2019",
        "2020",
        "2021",
        "2022"
    ]  # Títulos para cada subgráfico, que corresponden a los años
    
    # Crear un gráfico de barras apiladas para cada año
    for i, ax in enumerate(axes):
        año = titulos[i]
        valores_activos_corriente = data.loc[activo_corriente, año]
        valores_pasivo_corriente = data.loc[pasivos_corrientes, año]
        bottom_1 = 0  # Inicio de la acumulación para la barra 1
        bottom_2 = 0  # Inicio de la acumulación para la barra 2
    
        # Dibujar cada cuenta en la barra 1
        for idx, cuenta in enumerate(activo_corriente):
            ax.bar(
                "Activos Corrientes",
                valores_activos_corriente[cuenta],
                bottom=bottom_1,
                label=cuenta if i == 0 else "",
                color=plt.cm.tab20c(idx),
            )
            ax.text(
                x="Activos Corrientes",
                y=bottom_1 + (valores_activos_corriente[cuenta] / 2),
                s=f"{valores_activos_corriente[cuenta]}%",
                ha="center",
            )
            bottom_1 += valores_activos_corriente[cuenta]
    
        # Dibujar cada cuenta en la barra 2
        for idx, cuenta in enumerate(pasivos_corrientes):
            ax.bar(
                "Pasivos Corrientes",
                valores_pasivo_corriente[cuenta],
                bottom=bottom_2,
                label=cuenta if i == 0 else "",
                color=plt.cm.tab20c(idx + len(activo_corriente)),
            )
            ax.text(
                x="Pasivos Corrientes",
                y=bottom_2 + (valores_pasivo_corriente[cuenta] / 2),
                s=f"{valores_pasivo_corriente[cuenta]}%",
                ha="center",
            )
            bottom_2 += valores_pasivo_corriente[cuenta]
    
        # Configurar título y etiquetas de los ejes para cada subgráfico
        ax.set_title(año)
        ax.set_xlabel("")
        ax.set_ylabel("% del Total")
    
    # Añadir una leyenda fuera del gráfico para identificar las cuentas
    handles, labels = axes[0].get_legend_handles_labels()
    fig.legend(handles, labels, loc="upper left", bbox_to_anchor=(0.85, 1), title="Cuentas")
    
    plt.tight_layout(rect=[0, 0, 0.85, 1])  # Ajustar el layout para no cortar la leyenda
    plt.show()  # Mostrar el gráfico



.. image:: output_16_0.png


El siguiente gráfico es complementario al anterior porque las cuentas
del Activo Corriente y Pasivo Corriente dependen del los Ingresos
Operacionales.

El siguiente ejemplo se realizó con el archivo ``KTNO-Ventas.csv``

.. code:: ipython3

    import matplotlib.pyplot as plt
    import pandas as pd
    
    # Cargar los datos desde el archivo CSV.
    kt_data_path = 'KTNO-Ventas.csv'
    kt_data = pd.read_csv(kt_data_path, sep=';', index_col=0)
    
    # Crear una figura y un eje para el gráfico con el tamaño deseado.
    fig, ax1 = plt.subplots(figsize=(10, 5))
    
    # Establecer el color del fondo de la figura a blanco.
    fig.patch.set_facecolor('white')
    
    # Graficar KTNO en barras usando color gris.
    bars = ax1.bar(kt_data.columns, kt_data.loc['KTNO', :], label='KTNO', color='lightblue')
    
    # Configurar el eje y las etiquetas para KTNO.
    ax1.set_xlabel('Año')
    ax1.set_ylabel('KTNO', color='black')
    ax1.tick_params(axis='y', labelcolor='black')
    
    # Establecer el fondo del eje a blanco.
    ax1.set_facecolor('white')
    
    # Crear un segundo eje y para los Ingresos Operacionales.
    ax2 = ax1.twinx()
    line, = ax2.plot(kt_data.columns, kt_data.loc['Ingresos Operacionales', :], label='Ingresos Operacionales', marker='o', color='black')
    
    # Configurar el eje y las etiquetas para los Ingresos Operacionales.
    ax2.set_ylabel('Ingresos Operacionales', color='black')
    ax2.tick_params(axis='y', labelcolor='black')
    
    # Establecer el fondo del eje secundario a blanco.
    ax2.set_facecolor('white')
    
    # Añadir título al gráfico.
    ax1.set_title('KTNO e Ingresos Operacionales')
    
    # Colocar las leyendas por fuera del gráfico en la parte superior derecha.
    ax1.legend(loc='upper left', bbox_to_anchor=(1.07, 1))
    ax2.legend(loc='upper left', bbox_to_anchor=(1.07, 0.9))
    
    # Ajustar el layout de la figura para que las leyendas y los ejes encajen bien.
    fig.tight_layout(rect=[0, 0, 0.85, 1])
    
    # Mostrar el gráfico.
    plt.show()
    



.. image:: output_19_0.png

