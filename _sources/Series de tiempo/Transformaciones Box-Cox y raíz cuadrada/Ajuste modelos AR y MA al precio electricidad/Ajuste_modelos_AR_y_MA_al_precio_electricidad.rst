Ajuste modelos AR y MA al precio electricidad
---------------------------------------------

.. code:: ipython3

    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    import matplotlib.dates as mdates
    from statsmodels.tsa.stattools import adfuller
    from statsmodels.graphics.tsaplots import plot_acf, plot_pacf
    from scipy.stats import boxcox
    from statsmodels.tsa.statespace.sarimax import SARIMAX
    import statsmodels.api as sm
    from scipy.stats import norm

Funciones:
~~~~~~~~~~

Se agregaron las funciones ``analisis_residuales`` y
``analizar_ajuste_serie``

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
    
    ##################################################################################
    
    def analisis_residuales(
        residuals,
        nombre: str = "Serie de tiempo",
        lags: int = 24,
        color_resid: str = "navy",
        color_qq: str = "navy",
        color_acf_pacf: str = "navy"
    ):
        """
        Análisis gráfico de residuales:
        - Residuales en el tiempo (toda la fila superior)
        - Histograma + curva normal (izq), QQ-plot (der)
        - ACF (izq), PACF (der) con bandas y barras color navy
        """
        residuals = residuals[1:].dropna()
        mu = residuals.mean()
        sigma = residuals.std(ddof=1)
        x = np.linspace(residuals.min(), residuals.max(), 400)
        pdf = norm.pdf(x, loc=mu, scale=sigma)
    
        fig = plt.figure(constrained_layout=True, figsize=(14, 11))
        gs = fig.add_gridspec(3, 2, height_ratios=[1, 1, 1])
    
        # 1. Residuales en el tiempo
        ax_time = fig.add_subplot(gs[0, :])
        ax_time.scatter(residuals.index, residuals, color=color_resid, alpha=0.7, s=20)
        ax_time.axhline(0, ls="--", color="black")
        ax_time.set_title(f"Residuales en el tiempo: {nombre}", color='black')
        ax_time.set_xlabel("Tiempo", color='black')
        ax_time.set_ylabel("Residual", color='black')
        ax_time.tick_params(axis='both', labelsize=11, colors='black')
    
        # 2. Histograma + curva Normal
        ax_hist = fig.add_subplot(gs[1, 0])
        ax_hist.hist(residuals, bins="auto", density=True, alpha=0.6, edgecolor="k", color="royalblue")
        ax_hist.plot(x, pdf, lw=2, label=f"N({mu:.3f}, {sigma:.3f}²)", color="darkred")
        ax_hist.set_title("Histograma residuaes y ajuste Normal", color='black')
        ax_hist.set_xlabel("Residual", color='black')
        ax_hist.set_ylabel("Densidad", color='black')
        ax_hist.legend(fontsize=9)
        ax_hist.grid(alpha=0.18)
        ax_hist.tick_params(axis='both', labelsize=10, colors='black')
    
        # 3. QQ-plot
        ax_qq = fig.add_subplot(gs[1, 1])
        qq = sm.qqplot(residuals, line='45', fit=True, ax=ax_qq, markerfacecolor=color_qq, markeredgecolor=color_qq, marker='o')
        lines = ax_qq.get_lines()
        if len(lines) >= 1:
            lines[0].set_color(color_qq)
            lines[0].set_marker('o')
            lines[0].set_linestyle('None')
        if len(lines) >= 2:
            lines[1].set_color("black")
            lines[1].set_linestyle("--")
        ax_qq.set_title("Q-Q Plot de los residuales", color='black')
        ax_qq.set_xlabel("Cuantiles teóricos (Normal)", color='black')
        ax_qq.set_ylabel("Cuantiles de los residuales", color='black')
        ax_qq.tick_params(axis='both', labelsize=10, colors='black')
        for l in ax_qq.get_xticklabels() + ax_qq.get_yticklabels():
            l.set_color('black')
    
        # 4. ACF (usando color navy en barras y bandas)
        ax_acf = fig.add_subplot(gs[2, 0])
        sm.graphics.tsa.plot_acf(residuals, lags=lags, ax=ax_acf, zero=False, color=color_acf_pacf)
        ax_acf.set_title("ACF de los residuales", color='black')
        ax_acf.set_xlabel("Rezagos", color='black')
        ax_acf.set_ylabel("Autocorrelación", color='black')
        ax_acf.tick_params(axis='both', labelsize=10, colors='black')
    
        # 5. PACF (usando color navy en barras y bandas)
        ax_pacf = fig.add_subplot(gs[2, 1])
        sm.graphics.tsa.plot_pacf(residuals, lags=lags, ax=ax_pacf, zero=False, color=color_acf_pacf)
        ax_pacf.set_title("PACF de los residuales", color='black')
        ax_pacf.set_xlabel("Rezagos", color='black')
        ax_pacf.set_ylabel("Autocorrelación parcial", color='black')
        ax_pacf.tick_params(axis='both', labelsize=10, colors='black')
    
        plt.show()
    
        return
    
    ##################################################################################
    
    def analizar_ajuste_serie(
        serie_original,
        fitted_values,
        results,
        test,
        n_forecast,
        transformacion=None,  # 'log', 'boxcox', 'sqrt', o None
        lambda_bc=None,       # solo si boxcox
        nombre="Serie"
    ):
        """
        Analiza el ajuste de un modelo y grafica ajuste+pronóstico sobre la serie original,
        devolviendo predicciones revertidas a la escala original.
    
        Args:
            serie_original: Serie original (sin transformar, index datetime)
            fitted_values: Serie de fittedvalues (en escala transformada)
            results: Modelo ajustado de statsmodels (debe soportar .append, .get_forecast)
            test: Serie de test (index datetime)
            n_forecast: Períodos a pronosticar por fuera de la muestra
            transformacion: 'log', 'boxcox', 'sqrt' o None
            lambda_bc: Valor de lambda para boxcox (si aplica)
            nombre: Nombre para los ejes y leyenda
        Returns:
            Diccionario con:
                - y_pred_train, y_pred_test, forecasting_orig, lower_bt, upper_bt
                - Fechas de pronóstico futuro: future_dates
        """
    
        # Alinear índices por seguridad
        fitted_values = fitted_values.reindex(serie_original.index.intersection(fitted_values.index))
        test = test.copy()
        # ----------- PRONÓSTICO EN TEST (fuera de muestra, recursivo) -----------
        current_results = results
        forecasted_test = []
        lower_ci_test = []
        upper_ci_test = []
    
        for i in range(len(test)):
            forecaster = current_results.get_forecast(steps=1)
            forecast_mean_test = forecaster.predicted_mean.iloc[0]
            ci_i_test = forecaster.conf_int(alpha=0.05).iloc[0]
            forecasted_test.append(forecast_mean_test)
            lower_ci_test.append(ci_i_test.iloc[0])
            upper_ci_test.append(ci_i_test.iloc[1])
            # Recursivo: alimentar el modelo con el valor real observado
            current_results = current_results.append(endog=[test.iloc[i]], refit=False)
    
        forecasted_test = pd.Series(forecasted_test, index=test.index, name='forecast_test')
        lower_ci_test   = pd.Series(lower_ci_test,   index=test.index, name='lower_test')
        upper_ci_test   = pd.Series(upper_ci_test,   index=test.index, name='upper_test')
    
        # ----------- PRONÓSTICO FUTURO (n_forecast meses) -----------
        current_results = results.append(endog=test, refit=False)
        forecasting = []
        lower_ci = []
        upper_ci = []
        for i in range(n_forecast):
            forecaster = current_results.get_forecast(steps=1)
            forecast_mean = forecaster.predicted_mean.iloc[0]
            ci_i = forecaster.conf_int(alpha=0.05).iloc[0]
            forecasting.append(forecast_mean)
            lower_ci.append(ci_i.iloc[0])
            upper_ci.append(ci_i.iloc[1])
            current_results = current_results.append(endog=[forecast_mean], refit=False)
    
        # Fechas futuras mensuales (puedes personalizar)
        last_date = test.index[-1]
        future_dates = pd.date_range(start=last_date + pd.offsets.MonthBegin(1),
                                     periods=n_forecast, freq='MS')
    
        forecasting = pd.Series(forecasting, index=future_dates, name='forecast')
        lower_ci   = pd.Series(lower_ci,   index=future_dates, name='lower')
        upper_ci   = pd.Series(upper_ci,   index=future_dates, name='upper')
    
        # ----------- REVERSIÓN DE TRANSFORMACIÓN -----------
        if transformacion == "log":
            y_pred_train = np.exp(fitted_values)
            y_pred_test = np.exp(forecasted_test)
            forecasting_orig = np.exp(forecasting)
            lower_bt = np.exp(lower_ci)
            upper_bt = np.exp(upper_ci)
        elif transformacion == "boxcox":
            if lambda_bc is None:
                raise ValueError("Debes indicar lambda_bc para la transformación Box-Cox")
            y_pred_train = np.power((lambda_bc * fitted_values + 1), 1 / lambda_bc)
            y_pred_test = np.power((lambda_bc * forecasted_test + 1), 1 / lambda_bc)
            forecasting_orig = np.power((lambda_bc * forecasting + 1), 1 / lambda_bc)
            lower_bt = np.power((lambda_bc * lower_ci + 1), 1 / lambda_bc)
            upper_bt = np.power((lambda_bc * upper_ci + 1), 1 / lambda_bc)
        elif transformacion == "sqrt":
            y_pred_train = fitted_values ** 2
            y_pred_test = forecasted_test ** 2
            forecasting_orig = forecasting ** 2
            lower_bt = lower_ci ** 2
            upper_bt = upper_ci ** 2
        elif transformacion is None or transformacion == "none":
            y_pred_train = fitted_values
            y_pred_test = forecasted_test
            forecasting_orig = forecasting
            lower_bt = lower_ci
            upper_bt = upper_ci
        else:
            raise ValueError("Transformación no soportada. Usa 'log', 'boxcox', 'sqrt' o None.")
    
        # ----------- GRÁFICO -----------
        plt.figure(figsize=(12,6))
        # Serie original
        plt.plot(serie_original, label=nombre, color='black')
        # Ajuste en train
        plt.plot(y_pred_train, label='Ajuste en train', color='tab:blue')
        # Ajuste en test
        plt.plot(y_pred_test, label='Pronóstico en test', color='tab:green')
        # Pronóstico futuro + IC
        plt.plot(forecasting_orig, label='Pronóstico futuro', color='tab:red', linestyle='--')
        plt.fill_between(future_dates, lower_bt.values, upper_bt.values, color='tab:red', alpha=0.2, label='IC 95%')
    
        plt.title(f'Ajuste y pronóstico - {nombre}')
        plt.xlabel('Tiempo')
        plt.ylabel('Valor')
        plt.legend()
        plt.tight_layout()
        plt.show()
    
        # ----------- Devuelve resultados clave -----------
        return {
            'y_pred_train': y_pred_train,
            'y_pred_test': y_pred_test,
            'forecasting_orig': forecasting_orig,
            'lower_bt': lower_bt,
            'upper_bt': upper_bt,
            'future_dates': future_dates
        }

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

    
      <div id="df-30e8289b-f935-4496-93f6-bd31904340cf" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-30e8289b-f935-4496-93f6-bd31904340cf')"
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
            document.querySelector('#df-30e8289b-f935-4496-93f6-bd31904340cf button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-30e8289b-f935-4496-93f6-bd31904340cf');
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
    
    
        <div id="df-d17d30e1-e4c7-4ad0-b8e7-cb9dfbda693d">
          <button class="colab-df-quickchart" onclick="quickchart('df-d17d30e1-e4c7-4ad0-b8e7-cb9dfbda693d')"
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
                document.querySelector('#df-d17d30e1-e4c7-4ad0-b8e7-cb9dfbda693d button');
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


Ajuste hasta AR(3)
~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Definir los parámetros del modelo AR (p, d, 0)
    order = (1, 1, 0)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'n'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(1, 1, 0)   Log Likelihood                 395.441
    Date:                Mon, 03 Nov 2025   AIC                           -786.882
    Time:                        04:31:08   BIC                           -779.998
    Sample:                    01-01-2000   HQIC                          -784.106
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    ar.L1         -0.0337      0.060     -0.566      0.571      -0.150       0.083
    sigma2         0.0019      0.000     11.213      0.000       0.002       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.01   Jarque-Bera (JB):                 0.69
    Prob(Q):                              0.92   Prob(JB):                         0.71
    Heteroskedasticity (H):               1.52   Skew:                             0.08
    Prob(H) (two-sided):                  0.07   Kurtosis:                         3.21
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

.. code:: ipython3

    # Definir los parámetros del modelo AR (p, d, 0)
    order = (2, 1, 0)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'n'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(2, 1, 0)   Log Likelihood                 398.673
    Date:                Mon, 03 Nov 2025   AIC                           -791.345
    Time:                        04:31:08   BIC                           -781.018
    Sample:                    01-01-2000   HQIC                          -787.180
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    ar.L1         -0.0381      0.060     -0.631      0.528      -0.156       0.080
    ar.L2         -0.1669      0.056     -2.976      0.003      -0.277      -0.057
    sigma2         0.0019      0.000     11.080      0.000       0.002       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.30   Jarque-Bera (JB):                 0.62
    Prob(Q):                              0.58   Prob(JB):                         0.73
    Heteroskedasticity (H):               1.54   Skew:                             0.11
    Prob(H) (two-sided):                  0.06   Kurtosis:                         3.13
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

.. code:: ipython3

    # Definir los parámetros del modelo AR (p, d, 0)
    order = (3, 1, 0)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'n'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(3, 1, 0)   Log Likelihood                 403.121
    Date:                Mon, 03 Nov 2025   AIC                           -798.243
    Time:                        04:31:09   BIC                           -784.473
    Sample:                    01-01-2000   HQIC                          -792.689
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    ar.L1         -0.0724      0.057     -1.267      0.205      -0.184       0.040
    ar.L2         -0.1729      0.056     -3.094      0.002      -0.282      -0.063
    ar.L3         -0.1947      0.066     -2.951      0.003      -0.324      -0.065
    sigma2         0.0018      0.000     11.322      0.000       0.001       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.14   Jarque-Bera (JB):                 1.11
    Prob(Q):                              0.71   Prob(JB):                         0.57
    Heteroskedasticity (H):               1.57   Skew:                             0.11
    Prob(H) (two-sided):                  0.05   Kurtosis:                         3.25
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

De acuerdo con el criterio del AIC, se selecciona el modelo AR(3) por
tener el menor valor de AIC, sin importar la significancia de los
coeficientes.

Ajuste hasta MA(4)
~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Definir los parámetros del modelo MA (0, d, q)
    order = (0, 1, 1)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'n'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(0, 1, 1)   Log Likelihood                 395.512
    Date:                Mon, 03 Nov 2025   AIC                           -787.023
    Time:                        04:31:09   BIC                           -780.138
    Sample:                    01-01-2000   HQIC                          -784.246
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    ma.L1         -0.0525      0.058     -0.900      0.368      -0.167       0.062
    sigma2         0.0019      0.000     11.171      0.000       0.002       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.02   Jarque-Bera (JB):                 0.59
    Prob(Q):                              0.90   Prob(JB):                         0.75
    Heteroskedasticity (H):               1.52   Skew:                             0.08
    Prob(H) (two-sided):                  0.07   Kurtosis:                         3.19
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

.. code:: ipython3

    # Definir los parámetros del modelo MA (0, d, q)
    order = (0, 1, 2)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'n'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(0, 1, 2)   Log Likelihood                 400.618
    Date:                Mon, 03 Nov 2025   AIC                           -795.236
    Time:                        04:31:09   BIC                           -784.908
    Sample:                    01-01-2000   HQIC                          -791.070
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    ma.L1         -0.1252      0.058     -2.144      0.032      -0.240      -0.011
    ma.L2         -0.2250      0.063     -3.547      0.000      -0.349      -0.101
    sigma2         0.0018      0.000     11.094      0.000       0.002       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.22   Jarque-Bera (JB):                 0.47
    Prob(Q):                              0.64   Prob(JB):                         0.79
    Heteroskedasticity (H):               1.58   Skew:                             0.09
    Prob(H) (two-sided):                  0.05   Kurtosis:                         3.11
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

.. code:: ipython3

    # Definir los parámetros del modelo MA (0, d, q)
    order = (0, 1, 3)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'n'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(0, 1, 3)   Log Likelihood                 403.688
    Date:                Mon, 03 Nov 2025   AIC                           -799.377
    Time:                        04:31:11   BIC                           -785.607
    Sample:                    01-01-2000   HQIC                          -793.823
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    ma.L1         -0.1016      0.060     -1.680      0.093      -0.220       0.017
    ma.L2         -0.1952      0.059     -3.299      0.001      -0.311      -0.079
    ma.L3         -0.1692      0.066     -2.581      0.010      -0.298      -0.041
    sigma2         0.0018      0.000     11.255      0.000       0.001       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.00   Jarque-Bera (JB):                 0.85
    Prob(Q):                              0.97   Prob(JB):                         0.65
    Heteroskedasticity (H):               1.58   Skew:                             0.09
    Prob(H) (two-sided):                  0.05   Kurtosis:                         3.24
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

.. code:: ipython3

    # Definir los parámetros del modelo MA (0, d, q)
    order = (0, 1, 4)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'n'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(0, 1, 4)   Log Likelihood                 403.982
    Date:                Mon, 03 Nov 2025   AIC                           -797.964
    Time:                        04:31:13   BIC                           -780.752
    Sample:                    01-01-2000   HQIC                          -791.021
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    ma.L1         -0.0925      0.061     -1.527      0.127      -0.211       0.026
    ma.L2         -0.1856      0.058     -3.181      0.001      -0.300      -0.071
    ma.L3         -0.1664      0.066     -2.538      0.011      -0.295      -0.038
    ma.L4         -0.0643      0.060     -1.077      0.281      -0.181       0.053
    sigma2         0.0018      0.000     11.104      0.000       0.001       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.01   Jarque-Bera (JB):                 0.87
    Prob(Q):                              0.93   Prob(JB):                         0.65
    Heteroskedasticity (H):               1.62   Skew:                             0.10
    Prob(H) (two-sided):                  0.04   Kurtosis:                         3.23
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

De acuerdo con el criterio del AIC, se selecciona el modelo MA(3) por
tener el menor valor de AIC, sin importar la significancia de los
coeficientes.

====== ============
Modelo AIC
====== ============
AR(1)  -786.882
AR(2)  -791.345
AR(3)  -798.243
MA(1)  -787.023
MA(2)  -795.236
MA(3)  **-799.377**
MA(4)  -797.964
====== ============

De los 7 modelos evaluados, se selecciona cómo el mejor desde el
criterio del AIC el MA(3).

Ahora se volverá a ajustar este modelo y se analizará el ajuste y los
residuales.

Modelo seleccionado:
~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Definir los parámetros del modelo MA (0, d, q)
    order = (0, 1, 3)  # Puedes ajustar según el análisis de ACF y PACF
    trend = 'n'        # 'c' = constante, 't' = tendencia, 'ct' = constante + tendencia, 'n' = sin tendencia
    
    # Ajustar el modelo con los datos de entrenamiento
    model = SARIMAX(train, order=order, trend=trend)
    results = model.fit()
    
    # Mostrar resumen del modelo
    print(results.summary())


.. parsed-literal::

                                   SARIMAX Results                                
    ==============================================================================
    Dep. Variable:          Precio_boxcox   No. Observations:                  232
    Model:               SARIMAX(0, 1, 3)   Log Likelihood                 403.688
    Date:                Mon, 03 Nov 2025   AIC                           -799.377
    Time:                        04:31:14   BIC                           -785.607
    Sample:                    01-01-2000   HQIC                          -793.823
                             - 04-01-2019                                         
    Covariance Type:                  opg                                         
    ==============================================================================
                     coef    std err          z      P>|z|      [0.025      0.975]
    ------------------------------------------------------------------------------
    ma.L1         -0.1016      0.060     -1.680      0.093      -0.220       0.017
    ma.L2         -0.1952      0.059     -3.299      0.001      -0.311      -0.079
    ma.L3         -0.1692      0.066     -2.581      0.010      -0.298      -0.041
    sigma2         0.0018      0.000     11.255      0.000       0.001       0.002
    ===================================================================================
    Ljung-Box (L1) (Q):                   0.00   Jarque-Bera (JB):                 0.85
    Prob(Q):                              0.97   Prob(JB):                         0.65
    Heteroskedasticity (H):               1.58   Skew:                             0.09
    Prob(H) (two-sided):                  0.05   Kurtosis:                         3.24
    ===================================================================================
    
    Warnings:
    [1] Covariance matrix calculated using the outer product of gradients (complex-step).
    

Ajuste y pronóstico en la serie original
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    fitted_values = results.fittedvalues
    y_pred_train = np.power((lambda_bc * fitted_values + 1), 1 / lambda_bc)
    y_pred = y_pred_train[1:]
    y_real = precio_electricidad["Precio"][1:split]
    

.. code:: ipython3

    resultados = analizar_ajuste_serie(
        precio_electricidad,      # Serie original (sin transformar)
        fitted_values,            # Ajuste en train
        results,                  # Modelo ajustado
        test,                     # Datos test
        n_forecast=12,            # Periodos futuros
        transformacion='boxcox',  # 'log', 'boxcox', 'sqrt' o None
        lambda_bc=lambda_bc,            # Solo si es boxcox
        nombre="Precio de electricidad"
    )
    



.. image:: output_32_0.png


.. code:: ipython3

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



.. image:: output_33_0.png


Análisis de los residuales modelo MA(3)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    analisis_residuales(
        results.resid,      # Agregar los residuales
        nombre="Precio de electricidad",
    )



.. image:: output_35_0.png


Desde el análisis visual de los residuales se observa que el modelo
MA(3) logra obtener residuales homocedásticos; sin embargo, estos
presentan desviaciones respecto a la distribución normal, evidenciadas
por la presencia de leptocurtosis. Además, en los gráficos de ACF y PACF
se identifican rezagos significativos en los periodos 8, 13 y 15, lo que
indica que el modelo no logra capturar completamente la estructura
temporal de la serie. Por tanto, sería recomendable ajustar un modelo
que incorpore mayor número de rezagos para mejorar la representación
dinámica del proceso.
