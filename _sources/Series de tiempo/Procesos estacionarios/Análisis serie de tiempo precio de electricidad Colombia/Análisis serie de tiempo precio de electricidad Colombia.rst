Análisis serie de tiempo precio de electricidad Colombia
--------------------------------------------------------

.. code:: ipython3

    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    import matplotlib.dates as mdates
    from statsmodels.tsa.seasonal import seasonal_decompose
    from statsmodels.tsa.stattools import adfuller
    from statsmodels.graphics.tsaplots import plot_acf, plot_pacf

Funciones:
~~~~~~~~~~

plot_serie_tiempo

plot_estacionalidad_aditiva_multiplicativa

plot_estacionalidad_mensual

tabla_descriptiva_serie

histograma_serie

histogramas_transformaciones

graficar_descomposicion_serie

analisis_estacionariedad

.. code:: ipython3

    def plot_serie_tiempo(
        serie: pd.DataFrame,
        nombre: str,
        unidades: str = None,
        columna: str = None,
        fecha_inicio: str = None,
        fecha_fin: str = None,
        color: str = 'navy',
        linewidth: float = 2,
        num_xticks: int = 12,
        estacionalidad: str = None,         # 'diciembre', 'enero', 'semana', 'semestre', 'custom_month'
        custom_month: int = None,           # Si quieres marcar otro mes (ejemplo: 3 para marzo)
        vline_label: str = None,            # Etiqueta para la(s) línea(s) vertical(es)
        hlines: list = None,                # lista de valores horizontales a marcar
        hlines_labels: list = None,         # lista de etiquetas para líneas horizontales
        color_estacion: str = 'darkgray',     # color de las líneas estacionales
        alpha_estacion: float = 0.3,        # transparencia de líneas estacionales
        color_hline: str = 'gray',          # color de las líneas horizontales
        alpha_hline: float = 0.7            # transparencia de líneas horizontales
    ):
        """
        Gráfico elegante de serie de tiempo.
        - Eje X alineado con la primera fecha real de la serie.
        - Opcional: marcar estacionalidades (diciembres, semanas, semestres, mes personalizado) con etiqueta.
        - Líneas horizontales con etiqueta opcional (legend).
        """
        df = serie.copy()
        if columna is None:
            columna = df.columns[0]
        if fecha_inicio:
            df = df[df.index >= fecha_inicio]
        if fecha_fin:
            df = df[df.index <= fecha_fin]
    
        # Asegura que el índice sea datetime y esté ordenado
        df = df.sort_index()
        df.index = pd.to_datetime(df.index)
    
        plt.style.use('ggplot')
        fig, ax = plt.subplots(figsize=(14, 6))
    
        # Gráfica principal
        ax.plot(df.index, df[columna], color=color, linewidth=linewidth, label=nombre)
        ax.set_title(f"Serie de tiempo: {nombre}", fontsize=20, weight='bold',
                     color='black')
        ax.set_xlabel("Fecha", fontsize=15, color='black')
        ax.set_ylabel(unidades, fontsize=15, color='black')
        ax.tick_params(axis='both', colors='black', labelsize=13)
        for label in ax.get_xticklabels() + ax.get_yticklabels():
            label.set_color('black')
    
        # Limita el rango del eje X exactamente al rango de fechas de la serie (no corrido)
        ax.set_xlim(df.index.min(), df.index.max())
    
        # Ticks equidistantes en eje X, asegurando que empieza en la primera fecha
        idx = df.index
        if len(idx) > num_xticks:
            ticks = np.linspace(0, len(idx)-1, num_xticks, dtype=int)
            ticks[0] = 0  # asegúrate que arranque en la primera fecha
            ticklabels = [idx[i] for i in ticks]
            ax.set_xticks(ticklabels)
            ax.set_xticklabels([pd.to_datetime(t).strftime('%b %Y') for t in ticklabels], rotation=0, color='black')
        else:
            ax.xaxis.set_major_formatter(mdates.DateFormatter('%b %Y'))
            fig.autofmt_xdate(rotation=0)
    
        # ==============================
        # LÍNEAS VERTICALES: Estacionalidad (con etiqueta en leyenda si se desea)
        # ==============================
        vlines_plotted = False
        if estacionalidad is not None:
            if estacionalidad == 'diciembre':
                fechas_mark = df[df.index.month == 12].index
            elif estacionalidad == 'enero':
                fechas_mark = df[df.index.month == 1].index
            elif estacionalidad == 'semana':
                fechas_mark = df[df.index.weekday == 0].index
            elif estacionalidad == 'semestre':
                fechas_mark = df[df.index.month.isin([6, 12])].index
            elif estacionalidad == 'custom_month' and custom_month is not None:
                fechas_mark = df[df.index.month == custom_month].index
            else:
                fechas_mark = []
            for i, f in enumerate(fechas_mark):
                # Solo pone la etiqueta una vez (la primera línea)
                if not vlines_plotted and vline_label is not None:
                    ax.axvline(f, color=color_estacion, alpha=alpha_estacion, linewidth=2, linestyle='--', zorder=0, label=vline_label)
                    vlines_plotted = True
                else:
                    ax.axvline(f, color=color_estacion, alpha=alpha_estacion, linewidth=2, linestyle='--', zorder=0)
    
        # ==============================
        # LÍNEAS HORIZONTALES OPCIONALES, con leyenda
        # ==============================
        if hlines is not None:
            if hlines_labels is None:
                hlines_labels = [None] * len(hlines)
            for i, h in enumerate(hlines):
                if hlines_labels[i] is not None:
                    ax.axhline(h, color=color_hline, alpha=alpha_hline, linewidth=1.5, linestyle='--', zorder=0, label=hlines_labels[i])
                else:
                    ax.axhline(h, color=color_hline, alpha=alpha_hline, linewidth=1.5, linestyle='--', zorder=0)
    
        # Coloca la leyenda solo si hay etiquetas
        handles, labels = ax.get_legend_handles_labels()
        if any(labels):
            ax.legend(loc='best', fontsize=13, frameon=True)
    
        ax.grid(True, alpha=0.4)
        plt.tight_layout()
        plt.show()
    
    ##################################################################################
    
    def plot_estacionalidad_mensual(
        serie: pd.Series,
        tipo: str = "aditiva",  # 'aditiva' o 'multiplicativa'
        window: int = 12,
        nombre: str = None,
        color: str = "navy"
    ):
        """
        Estima y grafica la estacionalidad mensual (aditiva o multiplicativa) de una serie de tiempo.
    
        Argumentos:
            serie: Serie de tiempo (pandas.Series) con índice datetime.
            tipo: 'aditiva' o 'multiplicativa'.
            window: ventana de la media móvil para tendencia (por defecto 12).
            nombre: nombre de la serie (para título y eje Y).
            color: color de la línea.
        """
        serie = serie.copy()
        if nombre is None:
            nombre = serie.name if serie.name is not None else "Serie"
        
        # Tendencia por media móvil centrada
        tendencia = serie.rolling(window=window, center=True).mean()
        # Serie sin tendencia
        if tipo == "aditiva":
            sin_tendencia = serie - tendencia
            # Promedio mensual del componente estacional
            promedio_mensual = sin_tendencia.groupby(sin_tendencia.index.month).mean()
            # Centrar para suma cero
            estacionalidad = promedio_mensual - promedio_mensual.mean()
            ylabel = "Índice estacional aditivo"
            titulo = f"Estacionalidad aditiva: {nombre}"
            ref_line = 0
        elif tipo == "multiplicativa":
            sin_tendencia = serie / tendencia
            promedio_mensual = sin_tendencia.groupby(sin_tendencia.index.month).mean()
            # Centrar para producto 1 (multiplicativa)
            estacionalidad = promedio_mensual / promedio_mensual.mean()
            ylabel = "Índice estacional multiplicativo"
            titulo = f"Estacionalidad multiplicativa: {nombre}"
            ref_line = 1
        else:
            raise ValueError("El tipo debe ser 'aditiva' o 'multiplicativa'.")
    
        estacionalidad.index.name = "Mes"
    
        # --- Gráfico ---
        plt.style.use('ggplot')
        fig, ax = plt.subplots(figsize=(5, 4))
        ax.plot(estacionalidad.index, estacionalidad.values, marker='o', linestyle='-', color=color, label="Índice estacional")
        ax.axhline(ref_line, color='gray', linestyle='--', linewidth=1.5, label='Referencia' if tipo == "aditiva" else 'Sin estacionalidad')
        ax.set_title(titulo, fontsize=10, color='black')
        ax.set_xlabel("Mes (1=Ene ... 12=Dic)", fontsize=10, color='black')
        ax.set_ylabel(ylabel, fontsize=10, color='black')
        ax.set_xticks(range(1, 13))
        ax.tick_params(axis='both', labelsize=9, colors='black')
        for label in ax.get_xticklabels() + ax.get_yticklabels():
            label.set_color('black')
        ax.grid(True, alpha=0.4)
        ax.legend(loc='best', fontsize=9, frameon=True)
        plt.tight_layout()
        plt.show()
    
    ##################################################################################
    
    def plot_estacionalidad_aditiva_multiplicativa(
        serie,
        columna: str = None,
        nombre: str = None,
        window: int = None,      # Puede ser None; se ajusta por frecuencia si es necesario
        color_add: str = 'navy',
        color_mult: str = 'darkgreen',
        frecuencia: str = 'mensual'  
    ):
        """
        Grafica estacionalidad aditiva (izquierda) y multiplicativa (derecha) para diferentes frecuencias de serie de tiempo.
    
        Args:
            serie: pd.Series o pd.DataFrame con índice datetime.
            columna: Si serie es DataFrame, nombre de la columna a usar.
            nombre: Nombre de la serie (para títulos).
            window: Ventana de la media móvil centrada (por defecto ajustada por frecuencia).
            color_add: Color de la línea aditiva.
            color_mult: Color de la línea multiplicativa.
            frecuencia: 'horaria', 'diaria', 'semanal', 'mensual', 'trimestral', 'semestral', 'anual'
        """
        # Mapeo de periodos y etiquetas
        frec_dict = {
            'horaria': (24, [str(h) for h in range(0,24)], "Hora del día"),
            'diaria': (7, ['Lun','Mar','Mié','Jue','Vie','Sáb','Dom'], "Día de la semana"),
            'semanal': (52, [str(i) for i in range(1, 53)], "Semana del año"),
            'mensual': (12, ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'], "Mes del año"),
            'trimestral': (4, ['T1','T2','T3','T4'], "Trimestre"),
            'semestral': (2, ['S1','S2'], "Semestre"),
            'anual': (None, [], "Año"),  # No tiene sentido estacionalidad anual
        }
    
        # Validación de frecuencia
        frecuencia = frecuencia.lower()
        if frecuencia not in frec_dict:
            raise ValueError(f"Frecuencia '{frecuencia}' no soportada.")
        periodos, etiquetas_x, label_x = frec_dict[frecuencia]
        if periodos is None:
            raise ValueError("No tiene sentido calcular estacionalidad anual sobre datos anuales.")
    
        # Procesamiento de entrada
        if isinstance(serie, pd.DataFrame):
            if columna is None:
                columna = serie.columns[0]
            s = serie[columna].dropna()
            if nombre is None:
                nombre = columna
        else:
            s = serie.dropna()
            if nombre is None:
                nombre = s.name if s.name is not None else "Serie"
    
        # Definir ventana de suavizamiento si no se especifica
        if window is None:
            window = periodos
    
        # Tendencia
        tendencia = s.rolling(window=window, center=True).mean()
        # Aditiva
        sin_tendencia_add = s - tendencia
        if frecuencia == 'horaria':
            by_key = sin_tendencia_add.index.hour
        elif frecuencia == 'diaria':
            by_key = sin_tendencia_add.index.dayofweek
        elif frecuencia == 'semanal':
            by_key = sin_tendencia_add.index.isocalendar().week
        elif frecuencia == 'mensual':
            by_key = sin_tendencia_add.index.month
        elif frecuencia == 'trimestral':
            by_key = ((sin_tendencia_add.index.month-1)//3 + 1)
        elif frecuencia == 'semestral':
            by_key = ((sin_tendencia_add.index.month-1)//6 + 1)
        # No se implementa anual porque no hay estacionalidad intrínseca
    
        promedio_mensual_add = sin_tendencia_add.groupby(by_key).mean()
        estacionalidad_add = promedio_mensual_add - promedio_mensual_add.mean()
    
        # Multiplicativa
        sin_tendencia_mult = s / tendencia
        promedio_mensual_mult = sin_tendencia_mult.groupby(by_key).mean()
        estacionalidad_mult = promedio_mensual_mult / promedio_mensual_mult.mean()
    
        # Para graficar: alinear etiquetas en X
        x_axis = np.arange(1, periodos+1)
        if len(etiquetas_x) != periodos:
            etiquetas_x = [str(i) for i in range(1, periodos+1)]
    
        # Gráfico comparativo
        fig, axes = plt.subplots(1, 2, figsize=(11, 4))
        # Aditiva
        axes[0].plot(x_axis, estacionalidad_add.values, marker='o', linestyle='-', color=color_add, label="Índice estacional aditivo")
        axes[0].axhline(0, color='gray', linestyle='--', linewidth=1.5, label='Referencia')
        axes[0].set_title(f"Estacionalidad aditiva", fontsize=12, color='black')
        axes[0].set_xlabel(label_x, fontsize=10, color='black')
        axes[0].set_ylabel("Índice estacional aditivo", fontsize=10, color='black')
        axes[0].set_xticks(x_axis)
        axes[0].set_xticklabels(etiquetas_x, rotation=0)
        axes[0].tick_params(axis='both', labelsize=9, colors='black')
        for label in axes[0].get_xticklabels() + axes[0].get_yticklabels():
            label.set_color('black')
        axes[0].grid(True, alpha=0.4)
        axes[0].legend(loc='best', fontsize=9, frameon=True)
        # Multiplicativa
        axes[1].plot(x_axis, estacionalidad_mult.values, marker='o', linestyle='-', color=color_mult, label="Índice estacional multiplicativo")
        axes[1].axhline(1, color='gray', linestyle='--', linewidth=1.5, label='Sin estacionalidad')
        axes[1].set_title(f"Estacionalidad multiplicativa", fontsize=12, color='black')
        axes[1].set_xlabel(label_x, fontsize=10, color='black')
        axes[1].set_ylabel("Índice estacional multiplicativo", fontsize=10, color='black')
        axes[1].set_xticks(x_axis)
        axes[1].set_xticklabels(etiquetas_x, rotation=0)
        axes[1].tick_params(axis='both', labelsize=9, colors='black')
        for label in axes[1].get_xticklabels() + axes[1].get_yticklabels():
            label.set_color('black')
        axes[1].grid(True, alpha=0.4)
        axes[1].legend(loc='best', fontsize=9, frameon=True)
    
        plt.suptitle(f"Estacionalidad {frecuencia} de: {nombre}", fontsize=14, color='black', y=1.05)
        plt.tight_layout()
        plt.show()
    
    ##################################################################################
    
    def tabla_descriptiva_serie(
        serie,
        columna: str = None,
        nombre: str = None,
        decimals: int = 4,
        exportar_excel: bool = False,
        nombre_archivo: str = "tabla_descriptiva.xlsx"
    ):
        """
        Imprime una tabla descriptiva elegante con estadísticas básicas,
        prueba ADF e interpretación de simetría y curtosis.
        Puede exportar la tabla a Excel.
    
        Argumentos:
            serie: pd.Series o pd.DataFrame con índice de tiempo.
            columna: Si serie es DataFrame, nombre de la columna a usar.
            nombre: Nombre personalizado de la serie.
            decimals: Número de decimales en la tabla.
            exportar_excel: True para guardar la tabla en un archivo Excel.
            nombre_archivo: Nombre del archivo Excel a exportar.
        """
        # Si es DataFrame, selecciona la columna
        if isinstance(serie, pd.DataFrame):
            if columna is None:
                columna = serie.columns[0]
            s = serie[columna].dropna()
            if nombre is None:
                nombre = columna
        else:  # es Serie
            s = serie.dropna()
            if nombre is None:
                nombre = s.name if s.name is not None else "Serie"
    
        # Estadísticas básicas
        mean = s.mean()
        median = s.median()
        std = s.std()
        min_ = s.min()
        max_ = s.max()
        q25 = s.quantile(0.25)
        q75 = s.quantile(0.75)
        skew = s.skew()
        kurt = s.kurtosis()
        n = len(s)
    
        # Prueba ADF
        adf_result = adfuller(s, regression='c')
        adf_stat = adf_result[0]
        adf_p = adf_result[1]
        estacionaria = "Sí" if adf_p < 0.05 else "No"
    
        # Interpretación de curtosis
        if kurt > 0.5:
            curtosis_text = "Leptocúrtica"
        elif kurt < -0.5:
            curtosis_text = "Platicúrtica"
        else:
            curtosis_text = "Mesocúrtica"
    
        # Interpretación de simetría
        if abs(skew) < 0.1:
            simetria_text = "Simétrica"
        elif skew > 0.1:
            simetria_text = "Asimétrica positiva"
        else:
            simetria_text = "Asimétrica negativa"
    
        # Construir la tabla como DataFrame para Excel y también como Markdown
        tabla_df = pd.DataFrame({
            "Estadística": [
                "Nombre de la serie", "Número de datos", "Media", "Mediana", "Desviación estándar",
                "Mínimo", "Percentil 25", "Percentil 75", "Máximo",
                "Coeficiente de asimetría", "Tipo de simetría", "Curtosis", "Tipo de curtosis",
                "ADF estadístico", "ADF p-valor", "¿Estacionaria?"
            ],
            "Valor": [
                nombre, n, round(mean, decimals), round(median, decimals), round(std, decimals),
                round(min_, decimals), round(q25, decimals), round(q75, decimals), round(max_, decimals),
                round(skew, decimals), simetria_text, round(kurt, decimals), curtosis_text,
                round(adf_stat, decimals), round(adf_p, decimals), estacionaria
            ]
        })
    
        # Tabla Markdown (para imprimir en consola o Jupyter)
        tabla_md = "| Estadística              | Valor         |\n"
        tabla_md += "|--------------------------|-------------:|\n"
        for idx, row in tabla_df.iterrows():
            tabla_md += f"| {row['Estadística']:<25} | {row['Valor']} |\n"
    
    
        if exportar_excel:
            tabla_df.to_excel(nombre_archivo, index=False)
    
        return tabla_df  
    
    ##################################################################################
    
    def histograma_serie(
        serie,
        columna: str = None,
        nombre: str = None,
        bins: int = 30,
        color: str = 'navy',
        alpha: float = 0.82
    ):
        """
        Grafica el histograma de la serie original con formato elegante.
    
        Args:
            serie: pd.Series o pd.DataFrame con índice de tiempo.
            columna: Si serie es DataFrame, nombre de la columna a usar.
            nombre: Nombre de la serie (para título).
            bins: Número de bins en el histograma.
            color: Color de las barras.
            alpha: Transparencia de las barras.
        """
        # Selección de serie
        if isinstance(serie, pd.DataFrame):
            if columna is None:
                columna = serie.columns[0]
            s = serie[columna].dropna()
            if nombre is None:
                nombre = columna
        else:
            s = serie.dropna()
            if nombre is None:
                nombre = s.name if s.name is not None else "Serie"
    
        plt.figure(figsize=(7, 5))
        plt.hist(s, bins=bins, color=color, alpha=alpha, edgecolor='black')
        plt.title(f"Histograma de {nombre}", color='black', fontsize=9)
        plt.xlabel("Valor", color='black', fontsize=9)
        plt.ylabel("Frecuencia", color='black', fontsize=9)
        plt.tick_params(axis='both', labelsize=9, colors='black')
        plt.grid(True, alpha=0.18)
        plt.tight_layout()
        plt.show()
    
    ##################################################################################
    
    def graficar_descomposicion_serie(
        serie,
        columna: str = None,
        nombre: str = None,
        periodos: int = 12
    ):
        """
        Grafica la descomposición aditiva (izquierda) y multiplicativa (derecha)
        (Tendencia, Estacionalidad, Residuo) en dos columnas.
    
        Args:
            serie: pd.Series o pd.DataFrame con índice de tiempo.
            columna: Si serie es DataFrame, nombre de la columna a usar.
            nombre: Nombre de la serie (para títulos).
            periodos: Periodo de la estacionalidad (por defecto 12, meses).
        """
        # Selección de serie
        if isinstance(serie, pd.DataFrame):
            if columna is None:
                columna = serie.columns[0]
            s = serie[columna].dropna()
            if nombre is None:
                nombre = columna
        else:
            s = serie.dropna()
            if nombre is None:
                nombre = s.name if s.name is not None else "Serie"
    
        # Descomposición
        result_add = seasonal_decompose(s, model="additive", period=periodos)
        result_mult = seasonal_decompose(s, model="multiplicative", period=periodos)
    
        componentes = ["Serie observada", "Tendencia", "Estacionalidad", "Residuo"]
        datos_add = [result_add.observed, result_add.trend, result_add.seasonal, result_add.resid]
        datos_mult = [result_mult.observed, result_mult.trend, result_mult.seasonal, result_mult.resid]
    
        fig, axes = plt.subplots(4, 2, figsize=(12, 10), sharex=True)
        for i in range(4):
            # Aditiva (izquierda)
            axes[i, 0].plot(datos_add[i], color='black')
            axes[i, 0].set_ylabel(componentes[i], color='black', fontsize=11)
            axes[i, 0].set_title("Aditiva" if i == 0 else "", color='black', fontsize=13)
            axes[i, 0].tick_params(axis='both', labelsize=10, colors='black')
            axes[i, 0].grid(True, alpha=0.18)
            # Multiplicativa (derecha)
            axes[i, 1].plot(datos_mult[i], color='black')
            axes[i, 1].set_title("Multiplicativa" if i == 0 else "", color='black', fontsize=13)
            axes[i, 1].tick_params(axis='both', labelsize=10, colors='black')
            axes[i, 1].grid(True, alpha=0.18)
            # Solo la fila inferior lleva etiqueta x
            if i == 3:
                axes[i, 0].set_xlabel("Fecha", color='black')
                axes[i, 1].set_xlabel("Fecha", color='black')
    
        fig.suptitle(f"Descomposición estacional de la serie: {nombre}", fontsize=15, color='black', y=1.02)
        plt.tight_layout()
        plt.show()
    
    ##################################################################################
    
    def histogramas_transformaciones(
        serie,
        columna: str = None,
        nombre: str = None,
        bins: int = 30,
        color: str = 'navy',
        alpha: float = 0.82
    ):
        """
        Grafica histogramas de:
        - Serie original
        - Primera diferencia
        - Logaritmo
        - Primera diferencia del logaritmo
    
        Args:
            serie: pd.Series o pd.DataFrame con índice de tiempo.
            columna: Si serie es DataFrame, nombre de la columna a usar.
            nombre: Nombre de la serie (para títulos).
            bins: Número de bins en el histograma.
            color: Color de las barras.
            alpha: Transparencia de las barras.
        """
        # Procesamiento de entrada
        if isinstance(serie, pd.DataFrame):
            if columna is None:
                columna = serie.columns[0]
            s = serie[columna].dropna()
            if nombre is None:
                nombre = columna
        else:  # es Serie
            s = serie.dropna()
            if nombre is None:
                nombre = s.name if s.name is not None else "Serie"
    
        # Transformaciones
        serie_1 = s
        serie_2 = s.diff().dropna()
        serie_3 = np.log(s).dropna()
        serie_4 = serie_3.diff().dropna()
    
        series = [
            (serie_1, f"{nombre}"),
            (serie_2, "Primera diferencia"),
            (serie_3, "Logaritmo"),
            (serie_4, "Diferencia del logaritmo")
        ]
    
        fig, axes = plt.subplots(2, 2, figsize=(13, 8))
        axes = axes.flatten()
    
        for i, (data, title) in enumerate(series):
            axes[i].hist(data, bins=bins, color=color, alpha=alpha, edgecolor='black')
            axes[i].set_title(title, color='black', fontsize=13)
            axes[i].set_xlabel("Valor", color='black')
            axes[i].set_ylabel("Frecuencia", color='black')
            axes[i].tick_params(axis='both', labelsize=11, colors='black')
            axes[i].grid(True, alpha=0.2)
    
        plt.tight_layout()
        plt.show()
    
    ##################################################################################
    
    def analisis_estacionariedad(
        serie: pd.Series,
        nombre: str = None,
        lags: int = 24,
        xtick_interval: int = 3
    ):
        """
        Gráfica y análisis de estacionariedad para una serie de tiempo:
        - Serie original, diferencia, logaritmo y diferencia del logaritmo.
        - Muestra la ACF, PACF y resultado ADF en subplots.
    
        Args:
            serie: Serie de tiempo (índice datetime, pandas.Series)
            nombre: Nombre de la serie (para títulos)
            lags: Número de rezagos para ACF/PACF
            xtick_interval: Mostrar ticks en X cada este número de lags, incluyendo siempre el lag 1
        """
        if nombre is None:
            nombre = serie.name if serie.name is not None else "Serie"
    
        # Transformaciones
        serie_1 = serie.copy()
        serie_2 = serie_1.diff().dropna()
        serie_3 = np.log(serie_1)
        serie_4 = serie_3.diff().dropna()
    
        titulos = [
            f"Serie original: {nombre}",
            "Diferenciación",
            "Logaritmo",
            "Diferenciación del Logaritmo"
        ]
        series = [serie_1, serie_2, serie_3, serie_4]
    
        resultados_adf = []
        interpretaciones = []
    
        for i, serie_i in enumerate(series):
            serie_ = serie_i.dropna()
            # Selección de regresión en ADF
            if i in [0, 2]:
                adf = adfuller(serie_, regression='ct')
            else:
                adf = adfuller(serie_, regression='c')
            estadistico = adf[0]
            pvalue = adf[1]
            resultados_adf.append((estadistico, pvalue))
            interpretaciones.append("Estacionaria" if pvalue < 0.05 else "No estacionaria")
    
        fig, axes = plt.subplots(4, 3, figsize=(18, 16))
        colores = ['black', 'black', 'black', 'black']
    
        for fila in range(4):
            # Serie y etiquetas
            axes[fila, 0].plot(series[fila], color=colores[fila])
            axes[fila, 0].set_title(titulos[fila], color='black')
            axes[fila, 0].set_xlabel("Fecha", color='black')
            if fila == 0:
                axes[fila, 0].set_ylabel("Valor", color='black')
            elif fila == 1:
                axes[fila, 0].set_ylabel("Δ Valor", color='black')
            elif fila == 2:
                axes[fila, 0].set_ylabel("Log(Valor)", color='black')
            else:
                axes[fila, 0].set_ylabel("Δ Log(Valor)", color='black')
            axes[fila, 0].grid(True, alpha=0.3)
            axes[fila, 0].tick_params(axis='both', labelsize=11, colors='black')
    
            # ACF
            plot_acf(
                series[fila].dropna(),
                lags=lags,
                ax=axes[fila, 1],
                zero=False,
                color=colores[fila]
            )
            axes[fila, 1].set_title("ACF", color='black')
            # xticks: incluir lag 1 y luego cada xtick_interval (ej: 1, 3, 6, ...)
            xticks = [1] + list(range(xtick_interval, lags + 1, xtick_interval))
            xticks = sorted(set(xticks))  # asegura que no haya duplicados
            axes[fila, 1].set_xticks(xticks)
            axes[fila, 1].tick_params(axis='both', labelsize=11, colors='black')
            axes[fila, 1].set_xlabel("Lag", color='black')
            axes[fila, 1].set_ylabel("Autocorrelación", color='black')
    
            # PACF
            plot_pacf(
                series[fila].dropna(),
                lags=lags,
                ax=axes[fila, 2],
                zero=False,
                color=colores[fila]
            )
            axes[fila, 2].set_title("PACF", color='black')
            axes[fila, 2].set_xticks(xticks)
            axes[fila, 2].tick_params(axis='both', labelsize=11, colors='black')
            axes[fila, 2].set_xlabel("Lag", color='black')
            axes[fila, 2].set_ylabel("Autocorrelación parcial", color='black')
    
            # Indicador estacionariedad (más abajo)
            axes[fila, 0].text(
                0.02, 0.85,
                f"ADF: {resultados_adf[fila][0]:.2f}\np-valor: {resultados_adf[fila][1]:.4f}\n{interpretaciones[fila]}",
                transform=axes[fila, 0].transAxes,
                fontsize=11, bbox=dict(facecolor='white', alpha=0.85), color='black'
            )
    
        plt.tight_layout()
        plt.show()
        
        # Devuelve los resultados en un dict (opcional)
        adf_dict = {
            titulos[i]: {
                "estadístico ADF": resultados_adf[i][0],
                "p-valor": resultados_adf[i][1],
                "interpretación": interpretaciones[i]
            }
            for i in range(4)
        }
        return adf_dict
    
    

Precio de electricidad:
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Cargar el archivo
    precio_electricidad = pd.read_csv("Precio_electricidad.csv")
    
    # Corregir nombres de columnas si tienen espacios
    precio_electricidad.columns = precio_electricidad.columns.str.strip()
    
    # Convertir 'Fecha' a datetime y usar como índice
    precio_electricidad['Fecha'] = pd.to_datetime(precio_electricidad['Fecha'])
    precio_electricidad.set_index('Fecha', inplace=True)
    
    # Ordenar por fecha por si acaso
    precio_electricidad = precio_electricidad.sort_index()
    
    precio_electricidad.head()




.. raw:: html

    <div>
    <style scoped>
        .dataframe tbody tr th:only-of-type {
            vertical-align: middle;
        }
    
        .dataframe tbody tr th {
            vertical-align: top;
        }
    
        .dataframe thead th {
            text-align: right;
        }
    </style>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Precio</th>
        </tr>
        <tr>
          <th>Fecha</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>2000-01-01</th>
          <td>36.539729</td>
        </tr>
        <tr>
          <th>2000-02-01</th>
          <td>39.885205</td>
        </tr>
        <tr>
          <th>2000-03-01</th>
          <td>35.568126</td>
        </tr>
        <tr>
          <th>2000-04-01</th>
          <td>44.957443</td>
        </tr>
        <tr>
          <th>2000-05-01</th>
          <td>33.848903</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    plot_serie_tiempo(
        precio_electricidad,
        nombre="Precio de electricidad",
        columna='Precio',
        unidades='COP/kWh',
        estacionalidad='diciembre',
        vline_label="Diciembre",
        num_xticks = 14
    )



.. image:: output_7_0.png


Estadística descriptiva:
~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Si tienes un DataFrame:
    tabla_descriptiva_serie(precio_electricidad, columna='Precio',
                             nombre="Precio de electricidad",
                            decimals=2,
                            exportar_excel=True,
                            nombre_archivo="tabla_descriptiva_precio_electricidad.xlsx"
    )




.. raw:: html

    <div>
    <style scoped>
        .dataframe tbody tr th:only-of-type {
            vertical-align: middle;
        }
    
        .dataframe tbody tr th {
            vertical-align: top;
        }
    
        .dataframe thead th {
            text-align: right;
        }
    </style>
    <table border="1" class="dataframe">
      <thead>
        <tr style="text-align: right;">
          <th></th>
          <th>Estadística</th>
          <th>Valor</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>Nombre de la serie</td>
          <td>Precio de electricidad</td>
        </tr>
        <tr>
          <th>1</th>
          <td>Número de datos</td>
          <td>291</td>
        </tr>
        <tr>
          <th>2</th>
          <td>Media</td>
          <td>167.58</td>
        </tr>
        <tr>
          <th>3</th>
          <td>Mediana</td>
          <td>108.52</td>
        </tr>
        <tr>
          <th>4</th>
          <td>Desviación estándar</td>
          <td>166.63</td>
        </tr>
        <tr>
          <th>5</th>
          <td>Mínimo</td>
          <td>33.85</td>
        </tr>
        <tr>
          <th>6</th>
          <td>Percentil 25</td>
          <td>71.62</td>
        </tr>
        <tr>
          <th>7</th>
          <td>Percentil 75</td>
          <td>191.54</td>
        </tr>
        <tr>
          <th>8</th>
          <td>Máximo</td>
          <td>1145.23</td>
        </tr>
        <tr>
          <th>9</th>
          <td>Coeficiente de asimetría</td>
          <td>2.87</td>
        </tr>
        <tr>
          <th>10</th>
          <td>Tipo de simetría</td>
          <td>Asimétrica positiva</td>
        </tr>
        <tr>
          <th>11</th>
          <td>Curtosis</td>
          <td>10.21</td>
        </tr>
        <tr>
          <th>12</th>
          <td>Tipo de curtosis</td>
          <td>Leptocúrtica</td>
        </tr>
        <tr>
          <th>13</th>
          <td>ADF estadístico</td>
          <td>-2.09</td>
        </tr>
        <tr>
          <th>14</th>
          <td>ADF p-valor</td>
          <td>0.25</td>
        </tr>
        <tr>
          <th>15</th>
          <td>¿Estacionaria?</td>
          <td>No</td>
        </tr>
      </tbody>
    </table>
    </div>



Histograma de la serie de tiempo:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    histograma_serie(precio_electricidad, 
                    columna='Precio', 
                    nombre="Precio de electricidad", 
                    color='navy', 
                    alpha=0.82)



.. image:: output_11_0.png


Descomposición:
~~~~~~~~~~~~~~~

.. code:: ipython3

    graficar_descomposicion_serie(precio_electricidad, 
                                  columna='Precio', 
                                  nombre="Precio de electricidad", 
                                  periodos=12)



.. image:: output_13_0.png


Estacionalidad:
~~~~~~~~~~~~~~~

.. code:: ipython3

    plot_estacionalidad_aditiva_multiplicativa(precio_electricidad, 
                                               columna='Precio', 
                                               nombre="Precio de electricidad",
                                               frecuencia='mensual')



.. image:: output_15_0.png


.. code:: ipython3

    # Estacionalidad aditiva
    plot_estacionalidad_mensual(precio_electricidad, tipo="aditiva", 
    nombre="Precio de electricidad")
    
    # Estacionalidad multiplicativa
    plot_estacionalidad_mensual(precio_electricidad, tipo="multiplicativa", 
    nombre="Precio de electricidad")
    



.. image:: output_16_0.png



.. image:: output_16_1.png


Transformaciones y prueba ADF:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    adf_resultados = analisis_estacionariedad(
        precio_electricidad['Precio'],
        nombre="Precio de electricidad",
        lags=24,
        xtick_interval=3 
    )



.. image:: output_18_0.png


Histograma de las transformaciones:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    histogramas_transformaciones(precio_electricidad, 
                                columna='Precio', 
                                nombre="Precio de electricidad")



.. image:: output_20_0.png

