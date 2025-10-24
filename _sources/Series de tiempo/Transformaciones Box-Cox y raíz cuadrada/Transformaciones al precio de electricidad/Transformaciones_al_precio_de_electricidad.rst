Transformaciones al precio de electricidad
------------------------------------------

.. code:: ipython3

    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    import matplotlib.dates as mdates
    from statsmodels.tsa.stattools import adfuller
    from statsmodels.graphics.tsaplots import plot_acf, plot_pacf

Funciones:
~~~~~~~~~~

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

Precio de electricidad
~~~~~~~~~~~~~~~~~~~~~~

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
    
    # Establecer frecuencia explícita para evitar el warning de statsmodels
    precio_electricidad.index.freq = precio_electricidad.index.inferred_freq
    
    precio_electricidad.head()




.. raw:: html

    
      <div id="df-0edef2db-4dd1-407e-b6c6-ef43a4a7e517" class="colab-df-container">
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
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-0edef2db-4dd1-407e-b6c6-ef43a4a7e517')"
                title="Convert this dataframe to an interactive table."
                style="display:none;">
    
      <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
        <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
      </svg>
        </button>
    
      <style>
        .colab-df-container {
          display:flex;
          gap: 12px;
        }
    
        .colab-df-convert {
          background-color: #E8F0FE;
          border: none;
          border-radius: 50%;
          cursor: pointer;
          display: none;
          fill: #1967D2;
          height: 32px;
          padding: 0 0 0 0;
          width: 32px;
        }
    
        .colab-df-convert:hover {
          background-color: #E2EBFA;
          box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
          fill: #174EA6;
        }
    
        .colab-df-buttons div {
          margin-bottom: 4px;
        }
    
        [theme=dark] .colab-df-convert {
          background-color: #3B4455;
          fill: #D2E3FC;
        }
    
        [theme=dark] .colab-df-convert:hover {
          background-color: #434B5C;
          box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
          filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
          fill: #FFFFFF;
        }
      </style>
    
        <script>
          const buttonEl =
            document.querySelector('#df-0edef2db-4dd1-407e-b6c6-ef43a4a7e517 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-0edef2db-4dd1-407e-b6c6-ef43a4a7e517');
            const dataTable =
              await google.colab.kernel.invokeFunction('convertToInteractive',
                                                        [key], {});
            if (!dataTable) return;
    
            const docLinkHtml = 'Like what you see? Visit the ' +
              '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
              + ' to learn more about interactive tables.';
            element.innerHTML = '';
            dataTable['output_type'] = 'display_data';
            await google.colab.output.renderOutput(dataTable, element);
            const docLink = document.createElement('div');
            docLink.innerHTML = docLinkHtml;
            element.appendChild(docLink);
          }
        </script>
      </div>
    
    
        <div id="df-63314a9b-004f-46e7-80e8-328b6cdab9d7">
          <button class="colab-df-quickchart" onclick="quickchart('df-63314a9b-004f-46e7-80e8-328b6cdab9d7')"
                    title="Suggest charts"
                    style="display:none;">
    
    <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
         width="24px">
        <g>
            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
        </g>
    </svg>
          </button>
    
    <style>
      .colab-df-quickchart {
          --bg-color: #E8F0FE;
          --fill-color: #1967D2;
          --hover-bg-color: #E2EBFA;
          --hover-fill-color: #174EA6;
          --disabled-fill-color: #AAA;
          --disabled-bg-color: #DDD;
      }
    
      [theme=dark] .colab-df-quickchart {
          --bg-color: #3B4455;
          --fill-color: #D2E3FC;
          --hover-bg-color: #434B5C;
          --hover-fill-color: #FFFFFF;
          --disabled-bg-color: #3B4455;
          --disabled-fill-color: #666;
      }
    
      .colab-df-quickchart {
        background-color: var(--bg-color);
        border: none;
        border-radius: 50%;
        cursor: pointer;
        display: none;
        fill: var(--fill-color);
        height: 32px;
        padding: 0;
        width: 32px;
      }
    
      .colab-df-quickchart:hover {
        background-color: var(--hover-bg-color);
        box-shadow: 0 1px 2px rgba(60, 64, 67, 0.3), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
        fill: var(--button-hover-fill-color);
      }
    
      .colab-df-quickchart-complete:disabled,
      .colab-df-quickchart-complete:disabled:hover {
        background-color: var(--disabled-bg-color);
        fill: var(--disabled-fill-color);
        box-shadow: none;
      }
    
      .colab-df-spinner {
        border: 2px solid var(--fill-color);
        border-color: transparent;
        border-bottom-color: var(--fill-color);
        animation:
          spin 1s steps(1) infinite;
      }
    
      @keyframes spin {
        0% {
          border-color: transparent;
          border-bottom-color: var(--fill-color);
          border-left-color: var(--fill-color);
        }
        20% {
          border-color: transparent;
          border-left-color: var(--fill-color);
          border-top-color: var(--fill-color);
        }
        30% {
          border-color: transparent;
          border-left-color: var(--fill-color);
          border-top-color: var(--fill-color);
          border-right-color: var(--fill-color);
        }
        40% {
          border-color: transparent;
          border-right-color: var(--fill-color);
          border-top-color: var(--fill-color);
        }
        60% {
          border-color: transparent;
          border-right-color: var(--fill-color);
        }
        80% {
          border-color: transparent;
          border-right-color: var(--fill-color);
          border-bottom-color: var(--fill-color);
        }
        90% {
          border-color: transparent;
          border-bottom-color: var(--fill-color);
        }
      }
    </style>
    
          <script>
            async function quickchart(key) {
              const quickchartButtonEl =
                document.querySelector('#' + key + ' button');
              quickchartButtonEl.disabled = true;  // To prevent multiple clicks.
              quickchartButtonEl.classList.add('colab-df-spinner');
              try {
                const charts = await google.colab.kernel.invokeFunction(
                    'suggestCharts', [key], {});
              } catch (error) {
                console.error('Error during call to suggestCharts:', error);
              }
              quickchartButtonEl.classList.remove('colab-df-spinner');
              quickchartButtonEl.classList.add('colab-df-quickchart-complete');
            }
            (() => {
              let quickchartButtonEl =
                document.querySelector('#df-63314a9b-004f-46e7-80e8-328b6cdab9d7 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
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



.. image:: output_6_0.png


.. code:: ipython3

    adf_resultados = analisis_estacionariedad(
        precio_electricidad['Precio'],
        nombre="Precio de electricidad",
        lags=36,
        xtick_interval=3
    )



.. image:: output_7_0.png


Transformación de raíz cuadrada
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Aplicar la transformación de raíz cuadrada
    precio_electricidad_sqrt = np.sqrt(precio_electricidad)
    
    # Cambiar el nombre de la columna
    precio_electricidad_sqrt.columns = [col + '_sqrt' for col in precio_electricidad.columns]
    
    # Mostrar los primeros valores
    print(precio_electricidad_sqrt.head())


.. parsed-literal::

                Precio_sqrt
    Fecha                  
    2000-01-01     6.044810
    2000-02-01     6.315473
    2000-03-01     5.963902
    2000-04-01     6.705031
    2000-05-01     5.817981
    

.. code:: ipython3

    plot_serie_tiempo(
        precio_electricidad_sqrt,
        nombre="Transformación raíz cuadrada precio de electricidad",
        columna='Precio_sqrt',
        unidades='',
        num_xticks = 14
    )



.. image:: output_10_0.png


**Para revertir la transformación (volver a la escala original):**

.. code:: ipython3

    precio_electricidad_revertida = precio_electricidad_sqrt ** 2
    
    precio_electricidad_revertida.head()




.. raw:: html

    
      <div id="df-7d26a25d-5b48-4f70-bd2c-3d8e4e2d9f7f" class="colab-df-container">
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
          <th>Precio_sqrt</th>
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
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-7d26a25d-5b48-4f70-bd2c-3d8e4e2d9f7f')"
                title="Convert this dataframe to an interactive table."
                style="display:none;">
    
      <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
        <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
      </svg>
        </button>
    
      <style>
        .colab-df-container {
          display:flex;
          gap: 12px;
        }
    
        .colab-df-convert {
          background-color: #E8F0FE;
          border: none;
          border-radius: 50%;
          cursor: pointer;
          display: none;
          fill: #1967D2;
          height: 32px;
          padding: 0 0 0 0;
          width: 32px;
        }
    
        .colab-df-convert:hover {
          background-color: #E2EBFA;
          box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
          fill: #174EA6;
        }
    
        .colab-df-buttons div {
          margin-bottom: 4px;
        }
    
        [theme=dark] .colab-df-convert {
          background-color: #3B4455;
          fill: #D2E3FC;
        }
    
        [theme=dark] .colab-df-convert:hover {
          background-color: #434B5C;
          box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
          filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
          fill: #FFFFFF;
        }
      </style>
    
        <script>
          const buttonEl =
            document.querySelector('#df-7d26a25d-5b48-4f70-bd2c-3d8e4e2d9f7f button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-7d26a25d-5b48-4f70-bd2c-3d8e4e2d9f7f');
            const dataTable =
              await google.colab.kernel.invokeFunction('convertToInteractive',
                                                        [key], {});
            if (!dataTable) return;
    
            const docLinkHtml = 'Like what you see? Visit the ' +
              '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
              + ' to learn more about interactive tables.';
            element.innerHTML = '';
            dataTable['output_type'] = 'display_data';
            await google.colab.output.renderOutput(dataTable, element);
            const docLink = document.createElement('div');
            docLink.innerHTML = docLinkHtml;
            element.appendChild(docLink);
          }
        </script>
      </div>
    
    
        <div id="df-935e80b2-f38a-4073-a176-ec34263475c4">
          <button class="colab-df-quickchart" onclick="quickchart('df-935e80b2-f38a-4073-a176-ec34263475c4')"
                    title="Suggest charts"
                    style="display:none;">
    
    <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
         width="24px">
        <g>
            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
        </g>
    </svg>
          </button>
    
    <style>
      .colab-df-quickchart {
          --bg-color: #E8F0FE;
          --fill-color: #1967D2;
          --hover-bg-color: #E2EBFA;
          --hover-fill-color: #174EA6;
          --disabled-fill-color: #AAA;
          --disabled-bg-color: #DDD;
      }
    
      [theme=dark] .colab-df-quickchart {
          --bg-color: #3B4455;
          --fill-color: #D2E3FC;
          --hover-bg-color: #434B5C;
          --hover-fill-color: #FFFFFF;
          --disabled-bg-color: #3B4455;
          --disabled-fill-color: #666;
      }
    
      .colab-df-quickchart {
        background-color: var(--bg-color);
        border: none;
        border-radius: 50%;
        cursor: pointer;
        display: none;
        fill: var(--fill-color);
        height: 32px;
        padding: 0;
        width: 32px;
      }
    
      .colab-df-quickchart:hover {
        background-color: var(--hover-bg-color);
        box-shadow: 0 1px 2px rgba(60, 64, 67, 0.3), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
        fill: var(--button-hover-fill-color);
      }
    
      .colab-df-quickchart-complete:disabled,
      .colab-df-quickchart-complete:disabled:hover {
        background-color: var(--disabled-bg-color);
        fill: var(--disabled-fill-color);
        box-shadow: none;
      }
    
      .colab-df-spinner {
        border: 2px solid var(--fill-color);
        border-color: transparent;
        border-bottom-color: var(--fill-color);
        animation:
          spin 1s steps(1) infinite;
      }
    
      @keyframes spin {
        0% {
          border-color: transparent;
          border-bottom-color: var(--fill-color);
          border-left-color: var(--fill-color);
        }
        20% {
          border-color: transparent;
          border-left-color: var(--fill-color);
          border-top-color: var(--fill-color);
        }
        30% {
          border-color: transparent;
          border-left-color: var(--fill-color);
          border-top-color: var(--fill-color);
          border-right-color: var(--fill-color);
        }
        40% {
          border-color: transparent;
          border-right-color: var(--fill-color);
          border-top-color: var(--fill-color);
        }
        60% {
          border-color: transparent;
          border-right-color: var(--fill-color);
        }
        80% {
          border-color: transparent;
          border-right-color: var(--fill-color);
          border-bottom-color: var(--fill-color);
        }
        90% {
          border-color: transparent;
          border-bottom-color: var(--fill-color);
        }
      }
    </style>
    
          <script>
            async function quickchart(key) {
              const quickchartButtonEl =
                document.querySelector('#' + key + ' button');
              quickchartButtonEl.disabled = true;  // To prevent multiple clicks.
              quickchartButtonEl.classList.add('colab-df-spinner');
              try {
                const charts = await google.colab.kernel.invokeFunction(
                    'suggestCharts', [key], {});
              } catch (error) {
                console.error('Error during call to suggestCharts:', error);
              }
              quickchartButtonEl.classList.remove('colab-df-spinner');
              quickchartButtonEl.classList.add('colab-df-quickchart-complete');
            }
            (() => {
              let quickchartButtonEl =
                document.querySelector('#df-935e80b2-f38a-4073-a176-ec34263475c4 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



Transformación Box–Cox
~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    from scipy.stats import boxcox

.. code:: ipython3

    # Aplicar la transformación Box–Cox:
    y_boxcox, lambda_bc = boxcox(precio_electricidad.iloc[:, 0])
    
    # Convertir el resultado en pandas.Series
    y_boxcox = pd.DataFrame(y_boxcox, index=precio_electricidad.index, columns=['Precio_boxcox'])
    
    print(f"Lambda Box–Cox óptimo: {lambda_bc:.4f}")
    print(y_boxcox.head())


.. parsed-literal::

    Lambda Box–Cox óptimo: -0.3692
                Precio_boxcox
    Fecha                    
    2000-01-01       1.991101
    2000-02-01       2.013932
    2000-03-01       1.983928
    2000-04-01       2.043960
    2000-05-01       1.970553
    

.. code:: ipython3

    plot_serie_tiempo(
        y_boxcox,
        nombre="Transformación Box-Cox precio de electricidad",
        columna='Precio_boxcox',
        unidades='',
        num_xticks = 14
    )



.. image:: output_16_0.png


**Para revertir la transformación Box–Cox (volver a la escala
original):**

.. code:: ipython3

    y_revertida = np.power((lambda_bc * y_boxcox + 1), 1 / lambda_bc)
    
    y_revertida.head()




.. raw:: html

    
      <div id="df-e72441ae-2ef4-4c03-8d3d-2edba8b70fc4" class="colab-df-container">
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
          <th>Precio_boxcox</th>
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
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-e72441ae-2ef4-4c03-8d3d-2edba8b70fc4')"
                title="Convert this dataframe to an interactive table."
                style="display:none;">
    
      <svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960">
        <path d="M120-120v-720h720v720H120Zm60-500h600v-160H180v160Zm220 220h160v-160H400v160Zm0 220h160v-160H400v160ZM180-400h160v-160H180v160Zm440 0h160v-160H620v160ZM180-180h160v-160H180v160Zm440 0h160v-160H620v160Z"/>
      </svg>
        </button>
    
      <style>
        .colab-df-container {
          display:flex;
          gap: 12px;
        }
    
        .colab-df-convert {
          background-color: #E8F0FE;
          border: none;
          border-radius: 50%;
          cursor: pointer;
          display: none;
          fill: #1967D2;
          height: 32px;
          padding: 0 0 0 0;
          width: 32px;
        }
    
        .colab-df-convert:hover {
          background-color: #E2EBFA;
          box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
          fill: #174EA6;
        }
    
        .colab-df-buttons div {
          margin-bottom: 4px;
        }
    
        [theme=dark] .colab-df-convert {
          background-color: #3B4455;
          fill: #D2E3FC;
        }
    
        [theme=dark] .colab-df-convert:hover {
          background-color: #434B5C;
          box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
          filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
          fill: #FFFFFF;
        }
      </style>
    
        <script>
          const buttonEl =
            document.querySelector('#df-e72441ae-2ef4-4c03-8d3d-2edba8b70fc4 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-e72441ae-2ef4-4c03-8d3d-2edba8b70fc4');
            const dataTable =
              await google.colab.kernel.invokeFunction('convertToInteractive',
                                                        [key], {});
            if (!dataTable) return;
    
            const docLinkHtml = 'Like what you see? Visit the ' +
              '<a target="_blank" href=https://colab.research.google.com/notebooks/data_table.ipynb>data table notebook</a>'
              + ' to learn more about interactive tables.';
            element.innerHTML = '';
            dataTable['output_type'] = 'display_data';
            await google.colab.output.renderOutput(dataTable, element);
            const docLink = document.createElement('div');
            docLink.innerHTML = docLinkHtml;
            element.appendChild(docLink);
          }
        </script>
      </div>
    
    
        <div id="df-52bc9db3-9344-46dd-aa26-ce2da5f6a8c7">
          <button class="colab-df-quickchart" onclick="quickchart('df-52bc9db3-9344-46dd-aa26-ce2da5f6a8c7')"
                    title="Suggest charts"
                    style="display:none;">
    
    <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
         width="24px">
        <g>
            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
        </g>
    </svg>
          </button>
    
    <style>
      .colab-df-quickchart {
          --bg-color: #E8F0FE;
          --fill-color: #1967D2;
          --hover-bg-color: #E2EBFA;
          --hover-fill-color: #174EA6;
          --disabled-fill-color: #AAA;
          --disabled-bg-color: #DDD;
      }
    
      [theme=dark] .colab-df-quickchart {
          --bg-color: #3B4455;
          --fill-color: #D2E3FC;
          --hover-bg-color: #434B5C;
          --hover-fill-color: #FFFFFF;
          --disabled-bg-color: #3B4455;
          --disabled-fill-color: #666;
      }
    
      .colab-df-quickchart {
        background-color: var(--bg-color);
        border: none;
        border-radius: 50%;
        cursor: pointer;
        display: none;
        fill: var(--fill-color);
        height: 32px;
        padding: 0;
        width: 32px;
      }
    
      .colab-df-quickchart:hover {
        background-color: var(--hover-bg-color);
        box-shadow: 0 1px 2px rgba(60, 64, 67, 0.3), 0 1px 3px 1px rgba(60, 64, 67, 0.15);
        fill: var(--button-hover-fill-color);
      }
    
      .colab-df-quickchart-complete:disabled,
      .colab-df-quickchart-complete:disabled:hover {
        background-color: var(--disabled-bg-color);
        fill: var(--disabled-fill-color);
        box-shadow: none;
      }
    
      .colab-df-spinner {
        border: 2px solid var(--fill-color);
        border-color: transparent;
        border-bottom-color: var(--fill-color);
        animation:
          spin 1s steps(1) infinite;
      }
    
      @keyframes spin {
        0% {
          border-color: transparent;
          border-bottom-color: var(--fill-color);
          border-left-color: var(--fill-color);
        }
        20% {
          border-color: transparent;
          border-left-color: var(--fill-color);
          border-top-color: var(--fill-color);
        }
        30% {
          border-color: transparent;
          border-left-color: var(--fill-color);
          border-top-color: var(--fill-color);
          border-right-color: var(--fill-color);
        }
        40% {
          border-color: transparent;
          border-right-color: var(--fill-color);
          border-top-color: var(--fill-color);
        }
        60% {
          border-color: transparent;
          border-right-color: var(--fill-color);
        }
        80% {
          border-color: transparent;
          border-right-color: var(--fill-color);
          border-bottom-color: var(--fill-color);
        }
        90% {
          border-color: transparent;
          border-bottom-color: var(--fill-color);
        }
      }
    </style>
    
          <script>
            async function quickchart(key) {
              const quickchartButtonEl =
                document.querySelector('#' + key + ' button');
              quickchartButtonEl.disabled = true;  // To prevent multiple clicks.
              quickchartButtonEl.classList.add('colab-df-spinner');
              try {
                const charts = await google.colab.kernel.invokeFunction(
                    'suggestCharts', [key], {});
              } catch (error) {
                console.error('Error during call to suggestCharts:', error);
              }
              quickchartButtonEl.classList.remove('colab-df-spinner');
              quickchartButtonEl.classList.add('colab-df-quickchart-complete');
            }
            (() => {
              let quickchartButtonEl =
                document.querySelector('#df-52bc9db3-9344-46dd-aa26-ce2da5f6a8c7 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



Diferenciación del Box Cox
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    diff_y_boxcox = y_boxcox.diff().dropna()
    
    plot_serie_tiempo(
        diff_y_boxcox,
        nombre="Transformación diferenciación Box-Cox precio de electricidad",
        columna='Precio_boxcox',
        unidades='',
        num_xticks = 14
    )



.. image:: output_20_0.png


Función para todas las transformaciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    def analisis_estacionariedad_full(
          serie: pd.Series,
          nombre: str = None,
          lags: int = 24,
          xtick_interval: int = 3
    ):
        """
        Gráfica y análisis de estacionariedad para una serie de tiempo con múltiples transformaciones:
        - Serie original
        - Diferenciación
        - Logaritmo
        - Diferenciación del Logaritmo
        - Raíz cuadrada
        - Diferenciación de la raíz cuadrada
        - Box-Cox (con corrimiento si hay valores <= 0)
        - Diferenciación del Box-Cox
    
        Para cada transformación se grafica:
        - Serie transformada en el tiempo
        - ACF
        - PACF
        - Resultado de la prueba ADF con interpretación
    
        Args:
            serie: Serie de tiempo (índice datetime, pandas.Series)
            nombre: Nombre de la serie (para títulos)
            lags: Número de rezagos para ACF/PACF
            xtick_interval: Mostrar ticks en X cada este número de lags, incluyendo siempre el lag 1
    
        Return:
            dict con los resultados de la ADF para cada transformación
        """
    
        if nombre is None:
            nombre = serie.name if serie.name is not None else "Serie"
    
        serie = serie.astype(float).copy()
    
        serie_orig = serie.copy()
        serie_diff = serie_orig.diff().dropna()
    
        # Logaritmo
        if (serie_orig <= 0).any():
            log_ok = False
            serie_log = pd.Series([np.nan]*len(serie_orig), index=serie_orig.index)
            serie_log_diff = pd.Series([np.nan]*len(serie_orig), index=serie_orig.index)
        else:
            log_ok = True
            serie_log = np.log(serie_orig)
            serie_log_diff = serie_log.diff().dropna()
    
        # Raíz cuadrada
        if (serie_orig < 0).any():
            sqrt_ok = False
            serie_sqrt = pd.Series([np.nan]*len(serie_orig), index=serie_orig.index)
            serie_sqrt_diff = pd.Series([np.nan]*len(serie_orig), index=serie_orig.index)
        else:
            sqrt_ok = True
            serie_sqrt = np.sqrt(serie_orig)
            serie_sqrt_diff = serie_sqrt.diff().dropna()
    
        # Box–Cox
        if (serie_orig <= 0).any():
            shift_bc = 1 - serie_orig.min()
        else:
            shift_bc = 0.0
    
        serie_bc_input = serie_orig + shift_bc
    
        if (serie_bc_input <= 0).any():
            bc_ok = False
            serie_boxcox = pd.Series([np.nan]*len(serie_orig), index=serie_orig.index)
            serie_boxcox_diff = pd.Series([np.nan]*len(serie_orig), index=serie_orig.index)
            lambda_bc = np.nan
        else:
            bc_ok = True
            bc_vals, lambda_bc = boxcox(serie_bc_input.values)
            serie_boxcox = pd.Series(bc_vals, index=serie_orig.index)
            serie_boxcox_diff = serie_boxcox.diff().dropna()
    
        # --- Títulos actualizados ---
        titulos = [
            f"Serie original: {nombre}",
            "Diferenciación",
            "Logaritmo" + ("" if log_ok else " (no aplicable)"),
            "Diferenciación del Logaritmo" + ("" if log_ok else " (no aplicable)"),
            "Raíz cuadrada" + ("" if sqrt_ok else " (no aplicable)"),
            "Diferenciación de la raíz cuadrada" + ("" if sqrt_ok else " (no aplicable)"),
            "Box-Cox" + (f" (λ = {lambda_bc:.4f})" if bc_ok else " (no aplicable)"),
            "Diferenciación del Box-Cox" + ("" if bc_ok else " (no aplicable)")
        ]
    
        series = [
            serie_orig,
            serie_diff,
            serie_log,
            serie_log_diff,
            serie_sqrt,
            serie_sqrt_diff,
            serie_boxcox,
            serie_boxcox_diff
        ]
    
        # --- ADF ---
        resultados_adf = []
        interpretaciones = []
    
        for i, s in enumerate(series):
            s_ = s.dropna()
    
            if len(s_) < 5:
                resultados_adf.append((np.nan, np.nan))
                interpretaciones.append("No evaluable")
                continue
    
            regression_type = 'ct' if i in [0, 2, 4, 6] else 'c'
    
            try:
                adf_res = adfuller(s_, regression=regression_type, autolag='AIC')
                estadistico = adf_res[0]
                pvalue = adf_res[1]
            except Exception:
                estadistico = np.nan
                pvalue = np.nan
    
            resultados_adf.append((estadistico, pvalue))
            interpretaciones.append("Estacionaria" if (pvalue is not None and pvalue < 0.05) else "No estacionaria")
    
        # --- Gráficos ---
        filas = len(series)
        fig, axes = plt.subplots(filas, 3, figsize=(18, 4*filas), squeeze=False)
        colores = ['black'] * filas
    
        for fila in range(filas):
            serie_fila = series[fila]
    
            # Serie temporal
            axes[fila, 0].plot(serie_fila, color=colores[fila], lw=1)
            axes[fila, 0].set_title(titulos[fila], color='black')
            axes[fila, 0].set_xlabel("Fecha", color='black')
    
            if fila == 0:
                ylabel = "Valor"
            elif fila == 1:
                ylabel = "Δ Valor"
            elif fila == 2:
                ylabel = "Log(Valor)"
            elif fila == 3:
                ylabel = "Δ Log(Valor)"
            elif fila == 4:
                ylabel = "√Valor"
            elif fila == 5:
                ylabel = "Δ √Valor"
            elif fila == 6:
                ylabel = "Box-Cox"
            else:
                ylabel = "Δ Box-Cox"
    
            axes[fila, 0].set_ylabel(ylabel, color='black')
            axes[fila, 0].grid(True, alpha=0.3)
            axes[fila, 0].tick_params(axis='both', labelsize=11, colors='black')
    
            adf_est, adf_p = resultados_adf[fila]
            axes[fila, 0].text(
                0.02, 0.85,
                f"ADF: {adf_est:.2f}\np-valor: {adf_p:.4f}\n{interpretaciones[fila]}",
                transform=axes[fila, 0].transAxes,
                fontsize=11,
                bbox=dict(facecolor='white', alpha=0.85),
                color='black'
            )
    
            # ACF
            try:
                plot_acf(serie_fila.dropna(), lags=lags, ax=axes[fila, 1], zero=False, color=colores[fila])
            except Exception:
                axes[fila, 1].text(0.5, 0.5, "ACF no disponible", ha='center', va='center')
            axes[fila, 1].set_title("ACF", color='black')
            xticks = [1] + list(range(xtick_interval, lags + 1, xtick_interval))
            axes[fila, 1].set_xticks(sorted(set(xticks)))
            axes[fila, 1].tick_params(axis='both', labelsize=11, colors='black')
            axes[fila, 1].set_xlabel("Lag", color='black')
    
            # PACF
            try:
                plot_pacf(serie_fila.dropna(), lags=lags, ax=axes[fila, 2], zero=False, color=colores[fila])
            except Exception:
                axes[fila, 2].text(0.5, 0.5, "PACF no disponible", ha='center', va='center')
            axes[fila, 2].set_title("PACF", color='black')
            axes[fila, 2].set_xticks(sorted(set(xticks)))
            axes[fila, 2].tick_params(axis='both', labelsize=11, colors='black')
            axes[fila, 2].set_xlabel("Lag", color='black')
    
        plt.tight_layout()
        plt.show()
    
        # --- Resumen ADF ---
        adf_dict = {
            titulos[i]: {
                "estadístico ADF": resultados_adf[i][0],
                "p-valor": resultados_adf[i][1],
                "interpretación": interpretaciones[i],
                "nota_boxcox": (
                    f"lambda Box-Cox = {lambda_bc:.4f}, shift aplicado = {shift_bc:.4f}"
                    if ("Box-Cox" in titulos[i] and bc_ok)
                    else ("Box-Cox no aplicable" if "Box-Cox" in titulos[i] and not bc_ok else None)
                )
            }
            for i in range(filas)
        }
    
        return adf_dict
    

.. code:: ipython3

    adf_resultados = analisis_estacionariedad_full(
          precio_electricidad['Precio'],
          nombre="Precio de electricidad",
          lags=36,
          xtick_interval=3
    )



.. image:: output_23_0.png

