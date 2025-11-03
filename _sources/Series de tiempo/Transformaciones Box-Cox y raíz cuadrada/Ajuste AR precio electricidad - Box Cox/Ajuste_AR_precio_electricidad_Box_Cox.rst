Ajuste AR precio electricidad - Box Cox
---------------------------------------

.. code:: ipython3

    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    import matplotlib.dates as mdates
    from statsmodels.tsa.stattools import adfuller
    from statsmodels.graphics.tsaplots import plot_acf, plot_pacf
    from scipy.stats import boxcox
    from statsmodels.tsa.statespace.sarimax import SARIMAX

Funciones:
~~~~~~~~~~

Se reemplaza la función ``analisis_estacionariedad`` por
``analisis_estacionariedad_full``

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

    
      <div id="df-b0d52877-644d-42a0-8495-a9525da83243" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-b0d52877-644d-42a0-8495-a9525da83243')"
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
            document.querySelector('#df-b0d52877-644d-42a0-8495-a9525da83243 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-b0d52877-644d-42a0-8495-a9525da83243');
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
    
    
        <div id="df-8db797fc-8dbe-497a-b5f5-6fa6e8a01253">
          <button class="colab-df-quickchart" onclick="quickchart('df-8db797fc-8dbe-497a-b5f5-6fa6e8a01253')"
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
                document.querySelector('#df-8db797fc-8dbe-497a-b5f5-6fa6e8a01253 button');
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



.. image:: output_7_0.png


.. code:: ipython3

    adf_resultados = analisis_estacionariedad_full(
          precio_electricidad['Precio'],
          nombre="Precio de electricidad",
          lags=36,
          xtick_interval=3
    )



.. image:: output_8_0.png


Transformación Box–Cox
~~~~~~~~~~~~~~~~~~~~~~

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



.. image:: output_12_0.png


**Conjunto de train y test:**

.. code:: ipython3

    # Dividir en train y test (por ejemplo, 80% train, 20% test)
    split = int(len(y_boxcox) * 0.8)
    train, test = y_boxcox[:split], y_boxcox[split:]
    
    # Graficar train y test:
    
    plt.figure(figsize=(12, 5))
    plt.plot(train, label='Train', color='navy')
    plt.plot(test, label='Test', color='orange')
    plt.title("Conjunto de train y test")
    plt.xlabel("Fecha")
    plt.ylabel("Valor")
    plt.legend()
    plt.grid(True, alpha=0.3)
    plt.tight_layout()



.. image:: output_14_0.png


Ajuste modelo AR
~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Definir los parámetros del modelo AR (p, 0, 0)
    order = (1, 0, 0)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'ct'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(1, 0, 0)   Log Likelihood                 408.211
    Date:                Mon, 03 Nov 2025   AIC                           -808.422
    Time:                        04:31:42   BIC                           -794.635
    Sample:                    01-01-2000   HQIC                          -802.862
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    intercept      0.3965      0.076      5.251      0.000       0.249       0.545
    drift          0.0002   5.78e-05      3.911      0.000       0.000       0.000
    ar.L1          0.8089      0.037     22.106      0.000       0.737       0.881
    sigma2         0.0017      0.000     11.239      0.000       0.001       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.64   Jarque-Bera (JB):                 0.31
    Prob(Q):                              0.42   Prob(JB):                         0.86
    Heteroskedasticity (H):               1.61   Skew:                             0.02
    Prob(H) (two-sided):                  0.04   Kurtosis:                         3.18
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

-  **Prueba de Ljung–Box (L1) (Q): 0.64 — Prob(Q): 0.42**

Como el valor p es mayor que 0.05, no hay evidencia de autocorrelación
en los residuales; el modelo captura bien la dinámica temporal.

-  **Prueba de Jarque–Bera (JB): 0.31 — Prob(JB): 0.86**

El valor p es mucho mayor que 0.05, por tanto los residuales siguen una
distribución aproximadamente normal.

Esto se respalda con:

**Skew = 0.02** (asimetría prácticamente nula).

**Kurtosis = 3.18**, muy cercana a 3 (kurtosis de una distribución
normal).

-  **Prueba de Heterocedasticidad (H): 1.61 — Prob(H): 0.04**

El valor p es menor que 0.05, por tanto hay evidencia de
heterocedasticidad, es decir, la varianza de los residuales no es
constante en el tiempo.

Ajuste y pronóstico en la serie original:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    ###### Pronóstico dentro de la muestra (train) ######
    fitted_values = results.fittedvalues
    
    # Alinear por si el índice de train y fitted_values difieren en los primeros p rezagos
    fitted_values = fitted_values.reindex(train.index)
    
    ###### Pronóstico fuera de la muestra (test) #####
    
    current_results = results  # Modelo ajustado
    
    forecasted_test = []
    lower_ci_test = []
    upper_ci_test = []
    
    for i in range(len(test)):
        forecaster = current_results.get_forecast(steps=1)       # Un pronóstico hacia adelante
        forecast_mean_test = forecaster.predicted_mean.iloc[0]   # Media del pronóstico
        ci_i_test = forecaster.conf_int(alpha=0.05).iloc[0]      # Intervalo de confianza del 95%
    
    
        forecasted_test.append(forecast_mean_test)
        lower_ci_test.append(ci_i_test.iloc[0])  # límite inferior
        upper_ci_test.append(ci_i_test.iloc[1])  # límite superior
    
        # Actualiza el estado con el valor real (método recursivo)
        current_results = current_results.append(endog=[test.iloc[i]], refit=False)
    
    forecasted_test = pd.Series(forecasted_test, index=test.index, name='forecast_test')
    lower_ci_test   = pd.Series(lower_ci_test,   index=test.index, name='lower_test')
    upper_ci_test   = pd.Series(upper_ci_test,   index=test.index, name='upper_test')
    
    ###### Pronóstico fuera de la muestra: futuro #####
    
    n_forecast = 6  # Pronóstico para 6 meses
    
    # Actualiza el estado con el dataset de test
    current_results = results.append(endog=test, refit=False)
    
    forecasting = []
    lower_ci = []
    upper_ci = []
    
    for i in range(n_forecast):
        forecaster = current_results.get_forecast(steps=1)      # Un pronóstico hacia adelante
        forecast_mean = forecaster.predicted_mean.iloc[0]       # Media del pronóstico
        ci_i = forecaster.conf_int(alpha=0.05).iloc[0]          # Intervalo de confianza del 95%
    
        forecasting.append(forecast_mean)
        lower_ci.append(ci_i.iloc[0])  # límite inferior
        upper_ci.append(ci_i.iloc[1])  # límite superior
    
        # Alimenta el modelo con el valor pronosticado (pronóstico puro hacia adelante)
        current_results = current_results.append(endog=[forecast_mean], refit=False)
    
    # Fechas futuras (mensuales inicio de mes)
    last_date = test.index[-1]
    future_dates = pd.date_range(start=last_date + pd.offsets.MonthBegin(1),
                                 periods=n_forecast, freq='MS')
    
    # Asegura Series con índice de fechas
    forecasting = pd.Series(forecasting, index=future_dates, name='forecast')
    lower_ci   = pd.Series(lower_ci,   index=future_dates, name='lower')
    upper_ci   = pd.Series(upper_ci,   index=future_dates, name='upper')
    
    # Inversa de la transformación Box Cox - SARIMAX devuelve automáticamente la diferenciación  ##################
    y_pred_train = np.power((lambda_bc * fitted_values + 1), 1 / lambda_bc)
    y_pred_test = np.power((lambda_bc * forecasted_test + 1), 1 / lambda_bc)
    forcasting_orig = np.power((lambda_bc * forecasting + 1), 1 / lambda_bc) # pronóstico futuro
    
    
    # Intervalos de confianza
    lower_bt      = np.power((lambda_bc * lower_ci + 1), 1 / lambda_bc)
    upper_bt      = np.power((lambda_bc * upper_ci + 1), 1 / lambda_bc)
    
    # Graficar sobre la serie original
    plt.figure(figsize=(12,6))
    
    # Serie original
    plt.plot(precio_electricidad[1:], label='Precio de electricidad', color='black')
    
    # Ajuste en train
    plt.plot(y_pred_train[1:], label='Ajuste en train', color='tab:blue')
    
    # Ajuste en test
    plt.plot(y_pred_test, label='Pronóstico en test', color='tab:green')
    
    # Pronóstico futuro + IC
    plt.plot(forcasting_orig, label='Pronóstico futuro', color='tab:red', linestyle='--')
    plt.fill_between(future_dates, lower_bt.values, upper_bt.values, color='tab:red', alpha=0.2, label='IC 95%')
    
    plt.title('Ajuste y pronóstico')
    plt.xlabel('Tiempo')
    plt.ylabel('Valor')
    plt.legend()
    plt.tight_layout()
    plt.show()



.. image:: output_19_0.png


.. code:: ipython3

    ### Análisis de residuales
    y_pred = y_pred_train[1:]
    y_real = precio_electricidad['Precio'][1:split]
    plt.figure(figsize=(20,6))
    
    # Serie real
    plt.plot(y_real, label='Serie real', color='black', linewidth=2)
    
    # Valores ajustados o predichos
    plt.plot(y_pred, label='Ajuste del modelo', color='blue', linewidth=2, alpha=0.8)
    
    plt.title("Ajuste sobre Train", fontsize=12)
    plt.xlabel("Tiempo")
    plt.ylabel("Valor")
    plt.legend()
    plt.grid(alpha=0.3)
    plt.tight_layout()
    plt.show()
    # Extraer residuales
    residuals = results.resid[1:]
    
    print(residuals.head())
    ### Gráfico de residuales en el tiempo
    # Gráfico en el tiempo
    plt.figure(figsize=(11,4))
    plt.scatter(residuals.index, residuals, color="darkblue")
    plt.axhline(0, ls="--", color="black")
    plt.title("Residuales en el tiempo")
    plt.xlabel("Tiempo")
    plt.ylabel("Residual")
    plt.tight_layout()
    plt.show()
    ### ACF y PACF de los residuales
    import statsmodels.api as sm
    fig, axes = plt.subplots(1, 2, figsize=(12,4))
    
    # Gráfico ACF
    sm.graphics.tsa.plot_acf(residuals, lags=20, ax=axes[0], zero=False, color='navy')
    axes[0].set_title("ACF de los residuales")
    axes[0].set_xlabel("Rezagos")
    axes[0].set_ylabel("Autocorrelación")
    
    # Gráfico PACF
    sm.graphics.tsa.plot_pacf(residuals, lags=20, ax=axes[1], zero=False, color='navy')
    axes[1].set_title("PACF de los residuales")
    axes[1].set_xlabel("Rezagos")
    axes[1].set_ylabel("Autocorrelación parcial")
    
    plt.tight_layout()
    plt.show()
    ### Histograma de los residuales
    # Histograma de residuales con ajuste Normal
    from scipy.stats import norm
    
    # Parámetros de la normal ajustada (MLE)
    mu = residuals.mean()
    sigma = residuals.std(ddof=1)
    
    # Rango para la curva teórica
    x = np.linspace(residuals.min(), residuals.max(), 400)
    pdf = norm.pdf(x, loc=mu, scale=sigma)
    
    plt.figure(figsize=(8,5))
    plt.hist(residuals, bins="auto", density=True, alpha=0.6, edgecolor="k", color="blue")
    plt.plot(x, pdf, lw=2, label=f"N({mu:.3f}, {sigma:.3f}²)", color="darkred")
    plt.title("Histograma de residuales + ajuste Normal")
    plt.xlabel("Residual")
    plt.ylabel("Densidad")
    plt.legend()
    plt.tight_layout()
    plt.show()
    ### QQ-plot de los residuales
    plt.figure(figsize=(6,6))
    sm.qqplot(residuals, line='45', fit=True)
    plt.title("Q-Q Plot de los residuales")
    plt.xlabel("Cuantiles teóricos (Normal)")
    plt.ylabel("Cuantiles de los residuales")
    plt.tight_layout()
    plt.show()
    ### Gráfico de valores predichos vs. valores reales
    plt.figure(figsize=(6,6))
    plt.scatter(y_real, y_pred, color='blue', alpha=0.6, edgecolor='k')
    
    # Línea de identidad (y = x)
    min_val = min(y_real.min(), y_pred.min())
    max_val = max(y_real.max(), y_pred.max())
    plt.plot([min_val, max_val], [min_val, max_val], color='black', lw=2)
    
    plt.title("Valores predichos vs. valores reales", fontsize=12)
    plt.xlabel("Valores reales")
    plt.ylabel("Valores predichos")
    plt.axis("equal")  # asegura proporciones iguales para la diagonal
    plt.grid(alpha=0.3)
    plt.tight_layout()
    plt.show()



.. image:: output_20_0.png


.. parsed-literal::

    Fecha
    2000-02-01    0.006613
    2000-03-01   -0.042085
    2000-04-01    0.041991
    2000-05-01   -0.080201
    2000-06-01    0.010729
    Freq: MS, dtype: float64
    


.. image:: output_20_2.png



.. image:: output_20_3.png



.. image:: output_20_4.png



.. parsed-literal::

    <Figure size 600x600 with 0 Axes>



.. image:: output_20_6.png



.. image:: output_20_7.png


Aunque las barras de la ACF (Autocorrelation Function) y la PACF
(Partial Autocorrelation Function) están dentro de las bandas de
significancia, lo cual indica en principio ausencia de autocorrelación
significativa, la forma del patrón sí importa.

Un patrón cíclico leve (por ejemplo, alternancia de signos
positivo–negativo o una oscilación suave a lo largo de los rezagos)
puede indicar que:

-  Existe una componente periódica débil en los errores que el modelo no
   ha capturado del todo.

-  La estacionalidad puede no haber sido modelada adecuadamente.

-  El modelo podría estar subajustando o sobreajustando los rezagos
   temporales.

En otras palabras, aunque los valores individuales no sean
“significativos” de manera aislada, el patrón visual puede revelar
estructura temporal residual.
