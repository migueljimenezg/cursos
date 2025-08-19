Indicadores de desempeño
------------------------

.. code:: ipython3

    #!pip install yfinance

.. code:: ipython3

    import yfinance as yf
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    import statsmodels.api as sm
    
    # Quitar advertencias (warming):
    import warnings
    
    warnings.filterwarnings("ignore")

.. code:: ipython3

    # Descargar acciones: KO, TSLA, WMT y FDX.
    
    # Definir qué acciones descargar y las fechas:
    stocks = ["KO", "TSLA", "WMT", "FDX"]
    start = "2019-12-01"  # Fecha inicial para descargar
    end = "2025-01-01"  # Fecha final para descargar
    
    # Descargar los datos desde Yahoo Finance: datos mensuales.
    data = yf.download(["KO", "TSLA", "WMT", "FDX"], start=start, end=end, interval="1mo")[
        "Close"].dropna()
    
    # Descargar el índice bursátil:
    index = yf.download("^GSPC", start=start, end=end, interval="1mo")["Close"]
    
    # Cálculo de los rendimientos: mensuales.
    returns_stocks = data.pct_change().dropna()
    returns_index = index.pct_change().dropna()
    
    # Rendimientos esperados:
    returns_stocks_mean = returns_stocks.mean()
    returns_index_mean = returns_index.mean()
    
    # Volatilidades: mensuales
    volatility = returns_stocks.std()
    volatility_index = returns_index.std()
    
    # Correlaciones:
    correlation = returns_stocks.corr()
    correlation_index = returns_index.corr()
    
    # Juntar rendimientos acciones con índice:
    returns = pd.concat([returns_stocks, returns_index], axis=1)
    returns.columns = ["FDX", "KO", "TSLA", "WMT", "Índice"]
    
    # Correlaciones:
    correlation = returns.corr()
    
    # Coeficientes Betas (otra forma):
    betas = []
    for stock in stocks:
        X = returns_index
        y = returns_stocks[stock]
        X = sm.add_constant(X)
        model = sm.OLS(y, X).fit()
        betas.append(model.params[1])
    
    betas = pd.Series(betas, index=stocks)
    
    # Métricas:
    
    # Descargar la tasa libre de riesgo (rendimiento de los T-Bills a 3 meses)
    t_bill_rate_data = yf.download("^IRX", start=start, end=end, interval="1mo")[
        "Close"].dropna()
    # La tasa viene en porcentaje, la convertimos a decimal
    t_bill_rate = t_bill_rate_data / 100
    
    # Rendimiento esperado anual de Rf:
    Rf = t_bill_rate.mean()
    
    # Rf mensual:
    Rf = (1 + Rf) ** (1 / 12) - 1
    
    # CAPM:
    CAPM = Rf.values + betas * (returns_index_mean.values - Rf.values)
    
    # Agregar nombres a CAPM:
    # CAPM = [f"{stock}: {capm:.2f}" for stock, capm in zip(stocks, CAPM)]
    
    # Indicador Sharpe:
    sharpe_ratio = (returns_stocks_mean - Rf.values) / volatility
    
    # Indicador Treynor:
    treynor_ratio = (returns_stocks_mean - Rf.values) / betas
    
    # Indicador Alfa de Jensen:
    jensen_alpha = (returns_stocks_mean - Rf.values) - betas * (
        returns_index_mean.values - Rf.values
    )


.. parsed-literal::

    [*********************100%***********************]  4 of 4 completed
    [*********************100%***********************]  1 of 1 completed
    [*********************100%***********************]  1 of 1 completed
    

**Rendimientos:**

-  **FDX:** 1,72% mensual.

-  **KO:** 0,6% mensual.

-  **TSLA:** 6,7% mensual.

-  **WMT:** 1,7% mensual.

-  **Índice S&P 500:** 1,14% mensual.

**Volatilidades:**

-  **FDX:** 10,4% mensual.

-  **KO:** 5,6% mensual.

-  **TSLA:** 22,2% mensual.

-  **WMT:** 5,6% mensual.

-  **Índice S&P 500:** 5,3% mensual.

**Coeficientes Betas:**

-  **FDX:** 1,21

-  **KO:** 0,62.

-  **TSLA:** 2,30.

-  **WMT:** 0,54.

**Tasa libre de riesgo:** 0,18% mensual.

**CAPM:**

-  **FDX:** 1,3% mensual.

-  **KO:** 0,8% mensual.

-  **TSLA:** 2,4% mensual.

-  **WMT:** 0,7% mensual.

**Sharpe:**

-  **FDX:** 0,15.

-  **KO:** 0,08.

-  **TSLA:** 0,29.

-  **WMT:** 0,27.

**Indicador Treynor:**

-  **FDX:** 0,013.

-  **KO:** 0,007.

-  **TSLA:** 0,028.

-  **WMT:** 0,027.

**Indicador Alfa de Jensen:**

-  **FDX:** 0,4%.

-  **KO:** -1,6%.

-  **TSLA:** 4,3%

-  **WMT:** 1%.

.. code:: ipython3

    # Verificar cantidad de datos:
    print("Cantidad de datos acciones: ", data.shape)
    print("Cantidad de datos índice: ", index.shape)
    
    # Rendimientos esperados:
    print("\n Rendimientos esperados acciones: ", returns_stocks_mean)
    print("\n Rendimientos esperados índice: ", returns_index_mean)
    
    # Volatilidades:
    print("\n Volatilidades acciones: ", volatility)
    print("\n Volatilidades índice: ", volatility_index)
    
    # Correlaciones:
    print("\n Correlaciones acciones e índice: \n", correlation)
    
    print("\n Coeficientes Beta de las acciones:")
    for stock, beta in betas.items():
        print(f"{stock}: {beta:.2f}")
    
    # Tasa libre de riesgo: mensual
    print("\n Tasa libre de riesgo mensual:", Rf)
    
    # CAPM:
    print("\n CAPM: \n", CAPM)
    
    # Indicador Sharpe:
    print("\n Indicador Sharpe: \n", sharpe_ratio)
    
    # Indicador Treynor:
    print("\n Indicador Treynor: \n", treynor_ratio)
    
    # Indicador Alfa de Jensen:
    print("\n Indicador Alfa de Jensen: \n", jensen_alpha)


.. parsed-literal::

    Cantidad de datos acciones:  (61, 4)
    Cantidad de datos índice:  (61, 1)
    
     Rendimientos esperados acciones:  Ticker
    FDX     0.017206
    KO      0.006138
    TSLA    0.066933
    WMT     0.016674
    dtype: float64
    
     Rendimientos esperados índice:  Ticker
    ^GSPC    0.011397
    dtype: float64
    
     Volatilidades acciones:  Ticker
    FDX     0.103973
    KO      0.056112
    TSLA    0.221557
    WMT     0.055845
    dtype: float64
    
     Volatilidades índice:  Ticker
    ^GSPC    0.0525
    dtype: float64
    
     Correlaciones acciones e índice: 
                  FDX        KO      TSLA       WMT    Índice
    FDX     1.000000  0.433639  0.328563  0.291799  0.612571
    KO      0.433639  1.000000  0.135087  0.347328  0.581084
    TSLA    0.328563  0.135087  1.000000  0.269969  0.545652
    WMT     0.291799  0.347328  0.269969  1.000000  0.511169
    Índice  0.612571  0.581084  0.545652  0.511169  1.000000
    
     Coeficientes Beta de las acciones:
    KO: 0.62
    TSLA: 2.30
    WMT: 0.54
    FDX: 1.21
    
     Tasa libre de riesgo mensual: Ticker
    ^IRX    0.001797
    dtype: float64
    
     CAPM: 
     KO      0.007759
    TSLA    0.023903
    WMT     0.007017
    FDX     0.013443
    dtype: float64
    
     Indicador Sharpe: 
     Ticker
    FDX     0.148207
    KO      0.077363
    TSLA    0.293992
    WMT     0.266397
    dtype: float64
    
     Indicador Treynor: 
     FDX     0.012702
    KO      0.006990
    TSLA    0.028286
    WMT     0.027360
    dtype: float64
    
     Indicador Alfa de Jensen: 
     FDX     0.003763
    KO     -0.001621
    TSLA    0.043030
    WMT     0.009657
    dtype: float64
    
