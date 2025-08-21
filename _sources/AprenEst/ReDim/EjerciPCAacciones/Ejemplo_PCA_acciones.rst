Ejercicio PCA - acciones
------------------------

.. code:: ipython3

    import yfinance as yf
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt

Descargar precios de acciones con diferentes características.

.. code:: ipython3

    acciones = [
        # 🟢 Acciones de bajo Beta (< 0.8) — defensivas
        'JNJ',   # Johnson & Johnson
        'PG',    # Procter & Gamble
        'KO',    # Coca-Cola
        'PEP',   # PepsiCo
        'WMT',   # Walmart
    
        # 🟡 Acciones de Beta cercano a 1 (≈ 0.9 - 1.1) — mercado promedio
        'AAPL',  # Apple
        'MSFT',  # Microsoft
        'V',     # Visa
        'MA',    # Mastercard
        'UNH',   # UnitedHealth
    
        # 🔴 Acciones de Beta alto (> 1.2) — más volátiles que el mercado
        'TSLA',  # Tesla
        'NVDA',  # Nvidia
        'META',  # Meta (Facebook)
        'AMZN',  # Amazon
        'NFLX',  # Netflix
    
        # 🔁 Adicionales mixtas para aumentar diversidad
        'GOOGL', # Alphabet (Google)
        'AMD',   # Advanced Micro Devices
        'CRM',   # Salesforce
        'BA',    # Boeing
        'NKE'    # Nike
    ]
    
    indice = '^GSPC'  # S&P500
    
    datos = yf.download(acciones + [indice], start='2020-07-01', end='2025-07-31', interval='1mo')['Close']
    datos.dropna(inplace=True)
    
    datos.describe()


.. parsed-literal::

    /tmp/ipython-input-4028798923.py:33: FutureWarning: YF.download() has changed argument auto_adjust default to True
      datos = yf.download(acciones + [indice], start='2020-07-01', end='2025-07-31', interval='1mo')['Close']
    [*********************100%***********************]  21 of 21 completed
    



.. raw:: html

    
      <div id="df-00d12e1c-c049-4a7d-9b01-8071afaec7ff" class="colab-df-container">
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
          <th>Ticker</th>
          <th>AAPL</th>
          <th>AMD</th>
          <th>AMZN</th>
          <th>BA</th>
          <th>CRM</th>
          <th>GOOGL</th>
          <th>JNJ</th>
          <th>KO</th>
          <th>MA</th>
          <th>META</th>
          <th>...</th>
          <th>NFLX</th>
          <th>NKE</th>
          <th>NVDA</th>
          <th>PEP</th>
          <th>PG</th>
          <th>TSLA</th>
          <th>UNH</th>
          <th>V</th>
          <th>WMT</th>
          <th>^GSPC</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>count</th>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>...</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
          <td>61.000000</td>
        </tr>
        <tr>
          <th>mean</th>
          <td>168.308615</td>
          <td>111.604426</td>
          <td>157.696810</td>
          <td>192.557214</td>
          <td>234.247294</td>
          <td>130.157316</td>
          <td>149.466882</td>
          <td>56.029760</td>
          <td>398.977761</td>
          <td>351.281430</td>
          <td>...</td>
          <td>555.438689</td>
          <td>106.611316</td>
          <td>53.068235</td>
          <td>149.308490</td>
          <td>141.179571</td>
          <td>246.167060</td>
          <td>444.539696</td>
          <td>241.869444</td>
          <td>56.422426</td>
          <td>4591.564901</td>
        </tr>
        <tr>
          <th>std</th>
          <td>37.929746</td>
          <td>32.599924</td>
          <td>35.406763</td>
          <td>31.330118</td>
          <td>48.640246</td>
          <td>32.428267</td>
          <td>10.006478</td>
          <td>8.197990</td>
          <td>82.631453</td>
          <td>165.833288</td>
          <td>...</td>
          <td>256.862147</td>
          <td>26.270569</td>
          <td>47.606693</td>
          <td>17.191153</td>
          <td>16.928583</td>
          <td>67.619500</td>
          <td>87.096891</td>
          <td>50.515680</td>
          <td>18.549609</td>
          <td>813.091153</td>
        </tr>
        <tr>
          <th>min</th>
          <td>103.174973</td>
          <td>60.060001</td>
          <td>84.000000</td>
          <td>121.080002</td>
          <td>131.438278</td>
          <td>72.843140</td>
          <td>119.756897</td>
          <td>40.592751</td>
          <td>279.303253</td>
          <td>92.651718</td>
          <td>...</td>
          <td>174.869995</td>
          <td>56.027664</td>
          <td>10.579879</td>
          <td>112.904655</td>
          <td>110.428238</td>
          <td>95.384003</td>
          <td>249.559998</td>
          <td>173.635727</td>
          <td>38.834499</td>
          <td>3269.959961</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>138.524902</td>
          <td>85.519997</td>
          <td>133.089996</td>
          <td>171.820007</td>
          <td>201.018570</td>
          <td>103.111603</td>
          <td>144.014450</td>
          <td>50.373863</td>
          <td>346.991150</td>
          <td>252.285919</td>
          <td>...</td>
          <td>394.519989</td>
          <td>88.638336</td>
          <td>16.206352</td>
          <td>134.108490</td>
          <td>127.865417</td>
          <td>201.880005</td>
          <td>386.012970</td>
          <td>206.614471</td>
          <td>44.324261</td>
          <td>4076.600098</td>
        </tr>
        <tr>
          <th>50%</th>
          <td>167.575714</td>
          <td>102.900002</td>
          <td>160.309998</td>
          <td>194.190002</td>
          <td>236.031769</td>
          <td>131.928772</td>
          <td>151.222504</td>
          <td>56.363876</td>
          <td>364.622620</td>
          <td>316.861664</td>
          <td>...</td>
          <td>517.570007</td>
          <td>105.146385</td>
          <td>27.729065</td>
          <td>153.950912</td>
          <td>140.274200</td>
          <td>240.080002</td>
          <td>472.730499</td>
          <td>225.511032</td>
          <td>47.488297</td>
          <td>4395.259766</td>
        </tr>
        <tr>
          <th>75%</th>
          <td>191.829453</td>
          <td>137.179993</td>
          <td>176.759995</td>
          <td>212.009995</td>
          <td>267.514801</td>
          <td>154.275345</td>
          <td>155.431381</td>
          <td>59.936260</td>
          <td>447.335083</td>
          <td>473.209625</td>
          <td>...</td>
          <td>641.619995</td>
          <td>125.442932</td>
          <td>90.315811</td>
          <td>161.462906</td>
          <td>155.858002</td>
          <td>282.160004</td>
          <td>498.170715</td>
          <td>269.519684</td>
          <td>59.013657</td>
          <td>5254.350098</td>
        </tr>
        <tr>
          <th>max</th>
          <td>249.534180</td>
          <td>192.529999</td>
          <td>237.679993</td>
          <td>260.660004</td>
          <td>340.623810</td>
          <td>203.538910</td>
          <td>164.740005</td>
          <td>72.037811</td>
          <td>584.808716</td>
          <td>773.440002</td>
          <td>...</td>
          <td>1339.130005</td>
          <td>160.342422</td>
          <td>177.869995</td>
          <td>177.486206</td>
          <td>175.867111</td>
          <td>404.600006</td>
          <td>601.015259</td>
          <td>363.944122</td>
          <td>98.252411</td>
          <td>6339.390137</td>
        </tr>
      </tbody>
    </table>
    <p>8 rows × 21 columns</p>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-00d12e1c-c049-4a7d-9b01-8071afaec7ff')"
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
            document.querySelector('#df-00d12e1c-c049-4a7d-9b01-8071afaec7ff button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-00d12e1c-c049-4a7d-9b01-8071afaec7ff');
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
    
        </div>
      </div>
    



.. code:: ipython3

    datos.info()


.. parsed-literal::

    <class 'pandas.core.frame.DataFrame'>
    DatetimeIndex: 61 entries, 2020-07-01 to 2025-07-01
    Data columns (total 21 columns):
     #   Column  Non-Null Count  Dtype  
    ---  ------  --------------  -----  
     0   AAPL    61 non-null     float64
     1   AMD     61 non-null     float64
     2   AMZN    61 non-null     float64
     3   BA      61 non-null     float64
     4   CRM     61 non-null     float64
     5   GOOGL   61 non-null     float64
     6   JNJ     61 non-null     float64
     7   KO      61 non-null     float64
     8   MA      61 non-null     float64
     9   META    61 non-null     float64
     10  MSFT    61 non-null     float64
     11  NFLX    61 non-null     float64
     12  NKE     61 non-null     float64
     13  NVDA    61 non-null     float64
     14  PEP     61 non-null     float64
     15  PG      61 non-null     float64
     16  TSLA    61 non-null     float64
     17  UNH     61 non-null     float64
     18  V       61 non-null     float64
     19  WMT     61 non-null     float64
     20  ^GSPC   61 non-null     float64
    dtypes: float64(21)
    memory usage: 10.5 KB
    

Variables:
~~~~~~~~~~

Se usaran indicadores financieros para agrupar a las acciones:

-  Rendimiento medio mensual.

-  Volatilidad mensual.

-  Asimetría (Skewness).

-  Curtosis.

-  Coeficiente Beta: mide la sensibilidad del rendimiento de una acción
   frente a los movimientos del mercado, indicando cuánto tiende a
   variar la acción en relación con el índice de referencia.

.. code:: ipython3

    def calcular_indicadores(serie_accion, serie_indice):
        retornos = serie_accion.pct_change().dropna()
        beta = np.cov(retornos, serie_indice.pct_change().dropna())[0, 1] / np.var(serie_indice.pct_change().dropna())
        return {
            'Retorno': retornos.mean(),
            'Volatilidad': retornos.std(),
            'Skewness': retornos.skew(),
            'Kurtosis': retornos.kurt(),
            'Beta': beta
        }
    
    caracteristicas = []
    for accion in acciones:
        caracteristicas.append(calcular_indicadores(datos[accion], datos[indice]))
    
    df_indicadores = pd.DataFrame(caracteristicas, index=acciones)
    
    df_indicadores.describe()




.. raw:: html

    
      <div id="df-7568d366-97de-4ff8-b4f0-479c18093676" class="colab-df-container">
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
          <th>Retorno</th>
          <th>Volatilidad</th>
          <th>Skewness</th>
          <th>Kurtosis</th>
          <th>Beta</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>count</th>
          <td>20.000000</td>
          <td>20.000000</td>
          <td>20.000000</td>
          <td>20.000000</td>
          <td>20.000000</td>
        </tr>
        <tr>
          <th>mean</th>
          <td>0.016279</td>
          <td>0.092425</td>
          <td>0.051634</td>
          <td>0.542927</td>
          <td>1.153155</td>
        </tr>
        <tr>
          <th>std</th>
          <td>0.013544</td>
          <td>0.041562</td>
          <td>0.562000</td>
          <td>1.361422</td>
          <td>0.589540</td>
        </tr>
        <tr>
          <th>min</th>
          <td>0.001234</td>
          <td>0.045147</td>
          <td>-1.143828</td>
          <td>-0.827875</td>
          <td>0.392903</td>
        </tr>
        <tr>
          <th>25%</th>
          <td>0.008797</td>
          <td>0.062848</td>
          <td>-0.288277</td>
          <td>-0.358962</td>
          <td>0.615435</td>
        </tr>
        <tr>
          <th>50%</th>
          <td>0.012891</td>
          <td>0.079984</td>
          <td>0.123930</td>
          <td>-0.230196</td>
          <td>1.125789</td>
        </tr>
        <tr>
          <th>75%</th>
          <td>0.020063</td>
          <td>0.119030</td>
          <td>0.306699</td>
          <td>1.171872</td>
          <td>1.420758</td>
        </tr>
        <tr>
          <th>max</th>
          <td>0.058650</td>
          <td>0.203409</td>
          <td>1.035206</td>
          <td>4.428854</td>
          <td>2.369970</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-7568d366-97de-4ff8-b4f0-479c18093676')"
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
            document.querySelector('#df-7568d366-97de-4ff8-b4f0-479c18093676 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-7568d366-97de-4ff8-b4f0-479c18093676');
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
    
        </div>
      </div>
    



**Matriz de correlación:**

.. code:: ipython3

    # Matriz de correlación entre las variables:
    import seaborn as sns
    
    plt.figure(figsize=(8, 6))
    sns.heatmap(df_indicadores.corr(), annot=True, cmap='coolwarm', fmt=".2f", linewidths=.5)
    plt.title('Mapa de Calor de Correlaciones de Indicadores')
    plt.show()
    



.. image:: output_9_0.png


PCA:
~~~~

.. code:: ipython3

    # Escalado de datos:
    from sklearn.preprocessing import StandardScaler
    
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(df_indicadores)

.. code:: ipython3

    from sklearn.decomposition import PCA
    
    # Aplicación de PCA estándar
    pca = PCA()
    pca.fit(X_scaled)
    
    # Cálculo de las varianzas explicadas
    explained_variance = pca.explained_variance_ratio_
    
    print("Varianza explicada por cada componente principal:")
    print(explained_variance)
    
    # Cálculo de la varianza explicada acumulada
    explained_variance_cum = np.cumsum(pca.explained_variance_ratio_)
    
    # Visualización del gráfico de varianza explicada
    plt.figure(figsize=(8, 6))
    plt.plot(
        range(1, len(explained_variance_cum) + 1),
        explained_variance_cum,
        marker="o",
        linestyle="--",
    )
    plt.xlabel("Número de Componentes Principales")
    plt.ylabel("Varianza Explicada Acumulada")
    plt.title("Gráfico de Varianza Explicada Acumulada")
    plt.grid()
    plt.show()


.. parsed-literal::

    Varianza explicada por cada componente principal:
    [0.54110558 0.24154776 0.16562478 0.04064715 0.01107473]
    


.. image:: output_12_1.png


**Cargas:**

El análisis de cargas factoriales muestra que la Componente 1 está
fuertemente asociada con retorno, volatilidad y beta, lo que sugiere que
esta dimensión captura principalmente la dinámica conjunta entre
rendimiento y riesgo sistemático de los activos.

Por su parte, la Componente 2 presenta una elevada correlación con
asimetría y curtosis, aunque en el caso de la curtosis la relación es de
signo inverso. Esto indica que esta componente refleja patrones de
distribución no normales en los retornos (asimetrías y concentraciones
de probabilidad en las colas).

En conjunto, las dos primeras componentes explican aproximadamente el
78% de la varianza total de los datos, lo cual evidencia una
representación adecuada de la estructura de las variables originales. De
esta manera, las cinco variables se encuentran bien representadas en las
dos primeras dimensiones.

Cabe resaltar que en la Componente 3, tanto la asimetría como la
curtosis exhiben una correlación positiva de magnitud moderada, lo que
sugiere la existencia de un factor adicional que captura ciertos rasgos
residuales de la forma de la distribución.

.. code:: ipython3

    loadings = pca.components_.T * np.sqrt(pca.explained_variance_)
    loadings_df = pd.DataFrame(
        loadings,
        columns=[f"PC{i+1}" for i in range(df_indicadores.shape[1])],
        index=df_indicadores.columns,
    )
    loadings_df




.. raw:: html

    
      <div id="df-c1985ff5-32fc-4260-9a8b-1857d44de59f" class="colab-df-container">
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
          <th>PC1</th>
          <th>PC2</th>
          <th>PC3</th>
          <th>PC4</th>
          <th>PC5</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>Retorno</th>
          <td>0.856260</td>
          <td>0.063447</td>
          <td>-0.457865</td>
          <td>0.324702</td>
          <td>-0.018812</td>
        </tr>
        <tr>
          <th>Volatilidad</th>
          <td>0.987746</td>
          <td>-0.052716</td>
          <td>0.090212</td>
          <td>-0.197655</td>
          <td>-0.164328</td>
        </tr>
        <tr>
          <th>Skewness</th>
          <td>0.212222</td>
          <td>0.805643</td>
          <td>0.584004</td>
          <td>0.131967</td>
          <td>-0.007552</td>
        </tr>
        <tr>
          <th>Kurtosis</th>
          <td>0.324036</td>
          <td>-0.780401</td>
          <td>0.559344</td>
          <td>0.159228</td>
          <td>0.019692</td>
        </tr>
        <tr>
          <th>Beta</th>
          <td>0.994516</td>
          <td>0.080084</td>
          <td>-0.002253</td>
          <td>-0.163293</td>
          <td>0.174601</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-c1985ff5-32fc-4260-9a8b-1857d44de59f')"
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
            document.querySelector('#df-c1985ff5-32fc-4260-9a8b-1857d44de59f button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-c1985ff5-32fc-4260-9a8b-1857d44de59f');
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
    
        </div>
      </div>
    



Componentes: 2
~~~~~~~~~~~~~~

.. code:: ipython3

    # Aplicación de PCA estándar
    num_components = 2
    pca = PCA(n_components=num_components)
    X_pca = pca.fit_transform(X_scaled)
    
    # Varianza explicada:
    explained_variance_ratio = pca.explained_variance_ratio_
    cumulative_variance = np.cumsum(explained_variance_ratio)
    cumulative_variance




.. parsed-literal::

    array([0.54110558, 0.78265334])



**Matríz de rotación:**

.. code:: ipython3

    rotation_matrix = pd.DataFrame(
        pca.components_.T,
        columns=[f"PC{i+1}" for i in range(num_components)],
        index=df_indicadores.columns,
    )
    
    print(rotation_matrix)


.. parsed-literal::

                      PC1       PC2
    Retorno      0.507389  0.056272
    Volatilidad  0.585304 -0.046753
    Skewness     0.125755  0.714526
    Kurtosis     0.192012 -0.692138
    Beta         0.589315  0.071027
    

**Cargas de las variables:**

.. code:: ipython3

    loadings = pca.components_.T * np.sqrt(pca.explained_variance_)
    loadings_df = pd.DataFrame(
        loadings,
        columns=[f"PC{i+1}" for i in range(num_components)],
        index=df_indicadores.columns,
    )
    loadings_df




.. raw:: html

    
      <div id="df-ddebecff-31c4-4254-a459-e5b06dd30ca8" class="colab-df-container">
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
          <th>PC1</th>
          <th>PC2</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>Retorno</th>
          <td>0.856260</td>
          <td>0.063447</td>
        </tr>
        <tr>
          <th>Volatilidad</th>
          <td>0.987746</td>
          <td>-0.052716</td>
        </tr>
        <tr>
          <th>Skewness</th>
          <td>0.212222</td>
          <td>0.805643</td>
        </tr>
        <tr>
          <th>Kurtosis</th>
          <td>0.324036</td>
          <td>-0.780401</td>
        </tr>
        <tr>
          <th>Beta</th>
          <td>0.994516</td>
          <td>0.080084</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-ddebecff-31c4-4254-a459-e5b06dd30ca8')"
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
            document.querySelector('#df-ddebecff-31c4-4254-a459-e5b06dd30ca8 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-ddebecff-31c4-4254-a459-e5b06dd30ca8');
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
    
        </div>
      </div>
    



**Cálculo de la matriz de proyección:**

.. code:: ipython3

    projected_data = X_scaled @ pca.components_.T
    projected_df = pd.DataFrame(
        projected_data,
        columns=[f"PC{i+1}" for i in range(num_components)],
        index=df_indicadores.index,
    )
    projected_df




.. raw:: html

    
      <div id="df-21dd1f64-8810-4942-967a-384776a59d35" class="colab-df-container">
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
          <th>PC1</th>
          <th>PC2</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>JNJ</th>
          <td>-2.009927</td>
          <td>0.571023</td>
        </tr>
        <tr>
          <th>PG</th>
          <td>-1.862686</td>
          <td>0.698475</td>
        </tr>
        <tr>
          <th>KO</th>
          <td>-1.628735</td>
          <td>-0.195235</td>
        </tr>
        <tr>
          <th>PEP</th>
          <td>-1.904777</td>
          <td>0.749386</td>
        </tr>
        <tr>
          <th>WMT</th>
          <td>-1.077136</td>
          <td>-0.514352</td>
        </tr>
        <tr>
          <th>AAPL</th>
          <td>-0.340766</td>
          <td>0.870143</td>
        </tr>
        <tr>
          <th>MSFT</th>
          <td>-0.463062</td>
          <td>0.726591</td>
        </tr>
        <tr>
          <th>V</th>
          <td>-0.846577</td>
          <td>0.742175</td>
        </tr>
        <tr>
          <th>MA</th>
          <td>-0.636976</td>
          <td>0.384738</td>
        </tr>
        <tr>
          <th>UNH</th>
          <td>-1.443072</td>
          <td>-2.101111</td>
        </tr>
        <tr>
          <th>TSLA</th>
          <td>4.017179</td>
          <td>0.810890</td>
        </tr>
        <tr>
          <th>NVDA</th>
          <td>3.314539</td>
          <td>0.545678</td>
        </tr>
        <tr>
          <th>META</th>
          <td>0.854471</td>
          <td>-1.035090</td>
        </tr>
        <tr>
          <th>AMZN</th>
          <td>-0.003152</td>
          <td>0.022272</td>
        </tr>
        <tr>
          <th>NFLX</th>
          <td>1.473487</td>
          <td>-3.536336</td>
        </tr>
        <tr>
          <th>GOOGL</th>
          <td>-0.469659</td>
          <td>-0.278302</td>
        </tr>
        <tr>
          <th>AMD</th>
          <td>1.848918</td>
          <td>1.107993</td>
        </tr>
        <tr>
          <th>CRM</th>
          <td>0.695677</td>
          <td>0.488226</td>
        </tr>
        <tr>
          <th>BA</th>
          <td>1.065754</td>
          <td>-0.027128</td>
        </tr>
        <tr>
          <th>NKE</th>
          <td>-0.583498</td>
          <td>-0.030033</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-21dd1f64-8810-4942-967a-384776a59d35')"
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
            document.querySelector('#df-21dd1f64-8810-4942-967a-384776a59d35 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-21dd1f64-8810-4942-967a-384776a59d35');
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
    
        </div>
      </div>
    



.. code:: ipython3

    X_pca




.. parsed-literal::

    array([[-2.00992661e+00,  5.71023056e-01],
           [-1.86268621e+00,  6.98474566e-01],
           [-1.62873530e+00, -1.95235456e-01],
           [-1.90477735e+00,  7.49385720e-01],
           [-1.07713606e+00, -5.14352008e-01],
           [-3.40766071e-01,  8.70143063e-01],
           [-4.63062470e-01,  7.26590620e-01],
           [-8.46576773e-01,  7.42174674e-01],
           [-6.36975870e-01,  3.84738442e-01],
           [-1.44307229e+00, -2.10111131e+00],
           [ 4.01717943e+00,  8.10889523e-01],
           [ 3.31453916e+00,  5.45678433e-01],
           [ 8.54470784e-01, -1.03509043e+00],
           [-3.15242929e-03,  2.22716935e-02],
           [ 1.47348699e+00, -3.53633606e+00],
           [-4.69659069e-01, -2.78301948e-01],
           [ 1.84891788e+00,  1.10799255e+00],
           [ 6.95676720e-01,  4.88225688e-01],
           [ 1.06575383e+00, -2.71275852e-02],
           [-5.83498308e-01, -3.00332323e-02]])



.. code:: ipython3

    plt.figure(figsize=(10, 6))
    
    # Gráfico de las observaciones (acciones)
    plt.scatter(X_pca[:, 0], X_pca[:, 1], c='blue')
    
    # Etiquetas de las observaciones (acciones)
    for i, label in enumerate(df_indicadores.index):
        plt.annotate(label, (X_pca[i, 0], X_pca[i, 1]),
                     fontsize=8, alpha=0.7)
    
    # Añadir las cargas (loadings) como flechas rojas
    for i, var in enumerate(df_indicadores.columns):
        plt.arrow(0, 0, loadings[i, 0], loadings[i, 1],
                  color='crimson', alpha=0.8,
                  head_width=0.05, length_includes_head=True)
        plt.text(loadings[i, 0]*1.4, loadings[i, 1]*1.1, var,
                 color='crimson', ha='center', va='center', fontsize=9)
    
    # Configuración del gráfico
    plt.title('PCA de Indicadores Financieros (Biplot)')
    plt.xlabel(f'Componente Principal 1 ({explained_variance_ratio[0]*100:.1f}%)')
    plt.ylabel(f'Componente Principal 2 ({explained_variance_ratio[1]*100:.1f}%)')
    plt.axhline(0, color='gray', lw=1)
    plt.axvline(0, color='gray', lw=1)
    plt.grid(True)
    plt.tight_layout()
    plt.show()



.. image:: output_24_0.png


Dato nuevo:
~~~~~~~~~~~

.. code:: ipython3

    # Nueva acción:
    new_data = yf.download(["DIS"], start='2020-07-01', end='2025-07-31', interval='1mo')['Close']
    new_data.dropna(inplace=True)


.. parsed-literal::

    /tmp/ipython-input-1044502549.py:2: FutureWarning: YF.download() has changed argument auto_adjust default to True
      new_data = yf.download(["DIS"], start='2020-07-01', end='2025-07-31', interval='1mo')['Close']
    [*********************100%***********************]  1 of 1 completed
    

.. code:: ipython3

    # Calcular indicadores con la misma función:
    indicadores_new = calcular_indicadores(new_data["DIS"], datos[indice])
    
    # Convertir a DataFrame para que tenga el mismo formato:
    df_new = pd.DataFrame([indicadores_new], index=["DIS"])
    df_new




.. raw:: html

    
      <div id="df-ed5f606d-49c1-48ee-a957-d71ffc3ab537" class="colab-df-container">
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
          <th>Retorno</th>
          <th>Volatilidad</th>
          <th>Skewness</th>
          <th>Kurtosis</th>
          <th>Beta</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>DIS</th>
          <td>0.00573</td>
          <td>0.104237</td>
          <td>0.635961</td>
          <td>-0.016636</td>
          <td>1.59273</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-ed5f606d-49c1-48ee-a957-d71ffc3ab537')"
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
            document.querySelector('#df-ed5f606d-49c1-48ee-a957-d71ffc3ab537 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-ed5f606d-49c1-48ee-a957-d71ffc3ab537');
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
    
        </div>
      </div>
    



.. code:: ipython3

    # Escalar con el scaler ya entrenado en tus datos originales:
    X_new_scaled = scaler.transform(df_new)
    
    # Proyectar en el espacio PCA ya entrenado:
    X_new_pca = pca.transform(X_new_scaled)
    
    print(f"Coordenadas de {"DIS"} en PC1 y PC2:", X_new_pca)
    


.. parsed-literal::

    Coordenadas de DIS en PC1 y PC2: [[0.2691755  1.04981175]]
    

.. code:: ipython3

    plt.figure(figsize=(10, 6))
    plt.scatter(X_pca[:, 0], X_pca[:, 1], c='blue', label='Acciones originales')
    
    for i, label in enumerate(df_indicadores.index):
        plt.annotate(label, (X_pca[i, 0], X_pca[i, 1]), fontsize=8, alpha=0.7)
    
    # Nueva acción
    plt.scatter(X_new_pca[0, 0], X_new_pca[0, 1], c='darkgreen', marker='X', s=110, label=df_new.index[0])
    plt.annotate(df_new.index[0], (X_new_pca[0, 0], X_new_pca[0, 1]), fontsize=9, color='red')
    
    # Flechas de cargas (asumiendo 'loadings' ya calculado)
    for i, var in enumerate(df_indicadores.columns):
        plt.arrow(0, 0, loadings[i, 0], loadings[i, 1],
                  color='crimson', alpha=0.8, head_width=0.05, length_includes_head=True)
        plt.text(loadings[i, 0]*1.4, loadings[i, 1]*1.1, var,
                 color='crimson', ha='center', va='center', fontsize=9)
    
    plt.title('PCA de Indicadores Financieros (con nueva acción)')
    plt.xlabel(f'PC1 ({explained_variance_ratio[0]*100:.1f}%)')
    plt.ylabel(f'PC2 ({explained_variance_ratio[1]*100:.1f}%)')
    plt.axhline(0, color='gray', lw=1); plt.axvline(0, color='gray', lw=1)
    plt.legend(); plt.grid(True); plt.tight_layout(); plt.show()
    



.. image:: output_29_0.png


**Advertencia:**

Al aplicar PCA con menos componentes que las variables originales, el
``inverse_transform`` no recupera los datos originales, sino una
aproximación que conserva solo la varianza capturada por esas
componentes.

K-Means:
~~~~~~~~

.. code:: ipython3

    from sklearn.preprocessing import StandardScaler
    from sklearn.cluster import KMeans, DBSCAN
    from sklearn.metrics import silhouette_score, pairwise_distances_argmin_min
    from scipy.cluster.hierarchy import dendrogram, linkage, fcluster

.. code:: ipython3

    # Calcular WCSS para diferentes valores de K:
    wcss = []
    K = range(1, 10)
    for k in K:
        kmeans = KMeans(n_clusters=k, random_state=34)
        kmeans.fit(X_pca)
        wcss.append(kmeans.inertia_)
    
    # Visualizar el método del codo
    plt.figure(figsize=(8, 4))
    plt.plot(K, wcss, "bo-")
    plt.xlabel("Número de clústeres (K)")
    plt.ylabel("WCSS")
    plt.title("Método del Codo para determinar el número óptimo de clústeres")
    plt.show()



.. image:: output_33_0.png


.. code:: ipython3

    # Calcular la puntuación de la silueta para diferentes valores de K:
    from sklearn.metrics import silhouette_score
    
    silhouette_scores = []
    K = range(2, 11)
    for k in K:
        kmeans = KMeans(n_clusters=k, random_state=34)
        kmeans.fit(X_pca)
        labels = kmeans.labels_
        score = silhouette_score(X_scaled, labels)
        silhouette_scores.append(score)
    
    # Visualizar la puntuación de la silueta
    plt.figure(figsize=(8, 4))
    plt.plot(K, silhouette_scores, "bo-")
    plt.xlabel("Número de clústeres (K)")
    plt.ylabel("Puntuación de la Silueta")
    plt.title("Método de la Silueta para determinar el número óptimo de clústeres")
    plt.show()



.. image:: output_34_0.png


**Clusters = 3**

.. code:: ipython3

    k_base = 3
    
    kmeans = KMeans(n_clusters=k_base, random_state=34)
    df_indicadores_copy = df_indicadores.copy()
    df_indicadores_copy['Cluster_KMeans'] = kmeans.fit_predict(X_pca)
    
    # Valores de Inercia y Silueta:
    inercia = kmeans.inertia_
    silhouette = silhouette_score(X_pca, df_indicadores_copy['Cluster_KMeans'])
    
    print(f"Clusters: {k_base}")
    print(f"Inercia: {inercia}")
    print(f"Puntuación de la Silueta: {silhouette}")


.. parsed-literal::

    Clusters: 3
    Inercia: 25.062446862137296
    Puntuación de la Silueta: 0.4597279703983844
    

.. code:: ipython3

    def graficar_clusters(df, metodo, var_x='Volatilidad', var_y='Retorno'):
        plt.figure(figsize=(10, 6))
        sns.scatterplot(
            data=df,
            x=var_x,
            y=var_y,
            hue=f'Cluster_{metodo}',
            palette='Set1',
            s=120
        )
        for i in range(len(df)):
            plt.text(df[var_x].iloc[i] + 0.002, df[var_y].iloc[i], df.index[i], fontsize=9)
    
        plt.title(f'Clustering por {metodo}: {var_y} vs {var_x}')
        plt.xlabel(var_x)
        plt.ylabel(var_y)
        plt.legend(title='Cluster')
        plt.grid(True)
        plt.show()
    
    # Graficar cada método
    graficar_clusters(df_indicadores_copy, 'KMeans')



.. image:: output_37_0.png


.. code:: ipython3

    # Clustering y variables en escala estandarizada:
    labels = kmeans.labels_
    X_scaled_df = pd.DataFrame(X_scaled, columns=df_indicadores_copy.iloc[:,:-1].columns)
    X_scaled_df['Cluster_KMeans'] = labels

.. code:: ipython3

    import plotly.graph_objects as go
    
    # Columnas a usar
    cols = ['Retorno','Volatilidad','Skewness','Kurtosis','Beta']
    
    # Preparar datos y calcular promedio por cluster
    tmp = X_scaled_df.copy()
    tmp[cols] = tmp[cols].apply(pd.to_numeric, errors='coerce')
    agg = tmp.groupby('Cluster_KMeans')[cols].mean().sort_index()
    
    # Construir radar combinado
    cats = cols + [cols[0]]
    fig = go.Figure()
    
    for cl, row in agg.iterrows():
        vals = row.tolist()
        fig.add_trace(go.Scatterpolar(
            r=vals + [vals[0]],
            theta=cats,
            name=f'Cluster {cl}',
            fill='toself',
            opacity=0.30
        ))
    
    fig.update_layout(
        title='Radar combinado por cluster',
        template='plotly_white',
        polar=dict(radialaxis=dict(showline=False, gridcolor='lightgray'))
    )
    
    fig.show()



.. raw:: html

    <html>
    <head><meta charset="utf-8" /></head>
    <body>
        <div>            <script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_SVG"></script><script type="text/javascript">if (window.MathJax && window.MathJax.Hub && window.MathJax.Hub.Config) {window.MathJax.Hub.Config({SVG: {font: "STIX-Web"}});}</script>                <script type="text/javascript">window.PlotlyConfig = {MathJaxConfig: 'local'};</script>
            <script charset="utf-8" src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>                <div id="396742d4-2565-4cf4-a9e1-93502b3456c0" class="plotly-graph-div" style="height:525px; width:100%;"></div>            <script type="text/javascript">                                    window.PLOTLYENV=window.PLOTLYENV || {};                                    if (document.getElementById("396742d4-2565-4cf4-a9e1-93502b3456c0")) {                    Plotly.newPlot(                        "396742d4-2565-4cf4-a9e1-93502b3456c0",                        [{"fill":"toself","name":"Cluster 0","opacity":0.3,"r":[-0.40945298496453925,-0.5660937392742916,0.13040041546368328,-0.37660590179291026,-0.443308795216304,-0.40945298496453925],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"},{"fill":"toself","name":"Cluster 1","opacity":0.3,"r":[-0.04062640422143117,0.4554980533446039,-0.8705854593184936,1.4981538641074397,0.10772666059718061,-0.04062640422143117],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"},{"fill":"toself","name":"Cluster 2","opacity":0.3,"r":[1.8284648071415788,1.8457421323957917,0.5957121454153639,-0.36557957770730837,1.7773692318077412,1.8284648071415788],"theta":["Retorno","Volatilidad","Skewness","Kurtosis","Beta","Retorno"],"type":"scatterpolar"}],                        {"template":{"data":{"barpolar":[{"marker":{"line":{"color":"white","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"barpolar"}],"bar":[{"error_x":{"color":"#2a3f5f"},"error_y":{"color":"#2a3f5f"},"marker":{"line":{"color":"white","width":0.5},"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"bar"}],"carpet":[{"aaxis":{"endlinecolor":"#2a3f5f","gridcolor":"#C8D4E3","linecolor":"#C8D4E3","minorgridcolor":"#C8D4E3","startlinecolor":"#2a3f5f"},"baxis":{"endlinecolor":"#2a3f5f","gridcolor":"#C8D4E3","linecolor":"#C8D4E3","minorgridcolor":"#C8D4E3","startlinecolor":"#2a3f5f"},"type":"carpet"}],"choropleth":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"choropleth"}],"contourcarpet":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"contourcarpet"}],"contour":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"contour"}],"heatmapgl":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"heatmapgl"}],"heatmap":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"heatmap"}],"histogram2dcontour":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"histogram2dcontour"}],"histogram2d":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"histogram2d"}],"histogram":[{"marker":{"pattern":{"fillmode":"overlay","size":10,"solidity":0.2}},"type":"histogram"}],"mesh3d":[{"colorbar":{"outlinewidth":0,"ticks":""},"type":"mesh3d"}],"parcoords":[{"line":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"parcoords"}],"pie":[{"automargin":true,"type":"pie"}],"scatter3d":[{"line":{"colorbar":{"outlinewidth":0,"ticks":""}},"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatter3d"}],"scattercarpet":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattercarpet"}],"scattergeo":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattergeo"}],"scattergl":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattergl"}],"scattermapbox":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scattermapbox"}],"scatterpolargl":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterpolargl"}],"scatterpolar":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterpolar"}],"scatter":[{"fillpattern":{"fillmode":"overlay","size":10,"solidity":0.2},"type":"scatter"}],"scatterternary":[{"marker":{"colorbar":{"outlinewidth":0,"ticks":""}},"type":"scatterternary"}],"surface":[{"colorbar":{"outlinewidth":0,"ticks":""},"colorscale":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"type":"surface"}],"table":[{"cells":{"fill":{"color":"#EBF0F8"},"line":{"color":"white"}},"header":{"fill":{"color":"#C8D4E3"},"line":{"color":"white"}},"type":"table"}]},"layout":{"annotationdefaults":{"arrowcolor":"#2a3f5f","arrowhead":0,"arrowwidth":1},"autotypenumbers":"strict","coloraxis":{"colorbar":{"outlinewidth":0,"ticks":""}},"colorscale":{"diverging":[[0,"#8e0152"],[0.1,"#c51b7d"],[0.2,"#de77ae"],[0.3,"#f1b6da"],[0.4,"#fde0ef"],[0.5,"#f7f7f7"],[0.6,"#e6f5d0"],[0.7,"#b8e186"],[0.8,"#7fbc41"],[0.9,"#4d9221"],[1,"#276419"]],"sequential":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]],"sequentialminus":[[0.0,"#0d0887"],[0.1111111111111111,"#46039f"],[0.2222222222222222,"#7201a8"],[0.3333333333333333,"#9c179e"],[0.4444444444444444,"#bd3786"],[0.5555555555555556,"#d8576b"],[0.6666666666666666,"#ed7953"],[0.7777777777777778,"#fb9f3a"],[0.8888888888888888,"#fdca26"],[1.0,"#f0f921"]]},"colorway":["#636efa","#EF553B","#00cc96","#ab63fa","#FFA15A","#19d3f3","#FF6692","#B6E880","#FF97FF","#FECB52"],"font":{"color":"#2a3f5f"},"geo":{"bgcolor":"white","lakecolor":"white","landcolor":"white","showlakes":true,"showland":true,"subunitcolor":"#C8D4E3"},"hoverlabel":{"align":"left"},"hovermode":"closest","mapbox":{"style":"light"},"paper_bgcolor":"white","plot_bgcolor":"white","polar":{"angularaxis":{"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":""},"bgcolor":"white","radialaxis":{"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":""}},"scene":{"xaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"},"yaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"},"zaxis":{"backgroundcolor":"white","gridcolor":"#DFE8F3","gridwidth":2,"linecolor":"#EBF0F8","showbackground":true,"ticks":"","zerolinecolor":"#EBF0F8"}},"shapedefaults":{"line":{"color":"#2a3f5f"}},"ternary":{"aaxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""},"baxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""},"bgcolor":"white","caxis":{"gridcolor":"#DFE8F3","linecolor":"#A2B1C6","ticks":""}},"title":{"x":0.05},"xaxis":{"automargin":true,"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":"","title":{"standoff":15},"zerolinecolor":"#EBF0F8","zerolinewidth":2},"yaxis":{"automargin":true,"gridcolor":"#EBF0F8","linecolor":"#EBF0F8","ticks":"","title":{"standoff":15},"zerolinecolor":"#EBF0F8","zerolinewidth":2}}},"polar":{"radialaxis":{"showline":false,"gridcolor":"lightgray"}},"title":{"text":"Radar combinado por cluster"}},                        {"responsive": true}                    ).then(function(){
    
    var gd = document.getElementById('396742d4-2565-4cf4-a9e1-93502b3456c0');
    var x = new MutationObserver(function (mutations, observer) {{
            var display = window.getComputedStyle(gd).display;
            if (!display || display === 'none') {{
                console.log([gd, 'removed!']);
                Plotly.purge(gd);
                observer.disconnect();
            }}
    }});
    
    // Listen for the removal of the full notebook cells
    var notebookContainer = gd.closest('#notebook-container');
    if (notebookContainer) {{
        x.observe(notebookContainer, {childList: true});
    }}
    
    // Listen for the clearing of the current output cell
    var outputEl = gd.closest('.output');
    if (outputEl) {{
        x.observe(outputEl, {childList: true});
    }}
    
                            })                };                            </script>        </div>
    </body>
    </html>

