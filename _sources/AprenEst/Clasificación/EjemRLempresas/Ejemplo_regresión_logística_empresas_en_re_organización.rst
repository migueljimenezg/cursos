Ejemplo regresión logística empresas en re organización
-------------------------------------------------------

**Margen EBIT:**

.. math::


   \text{Margen EBIT} = \frac{\text{EBIT}}{\text{Ventas}}

**Carga Financiera:**

.. math::


   \text{Carga Financiera} = \frac{\text{Intereses}}{\text{Ventas}}

**Margen Neto:**

.. math::


   \text{Margen Neto} = \frac{\text{Utilidad}}{\text{Ventas}}

**Cuentas por Cobrar (CxC):**

.. math::


   \text{CxC} = \frac{\text{Cuentas por Cobrar}}{\text{Ventas}}

**Cuentas por Pagar (CxP):**

.. math::


   \text{CxP} = \frac{\text{Cuentas por Pagar}}{\text{Ventas}}

**Solvencia:**

.. math::


   \text{Solvencia} = \frac{\text{EBIT}}{\text{Deudas}}

**Apalancamiento:**

.. math::


   \text{Apalancamiento} = \frac{\text{Pasivo}}{\text{Patrimonio}}

.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import matplotlib.ticker as mtick
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.linear_model import LogisticRegression
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import classification_report, confusion_matrix, roc_auc_score, roc_curve
    from sklearn.metrics import ConfusionMatrixDisplay, precision_score, precision_recall_curve, recall_score, accuracy_score, f1_score

.. code:: ipython3

    # path = "BD empresas re organización.xlsx"
    
    path = "BD empresas en re organización.xlsx"
    
    xls = pd.ExcelFile(path)
    
    df = pd.read_excel(path, sheet_name=xls.sheet_names[0])
    
    df.head()




.. raw:: html

    
      <div id="df-1eac0771-c0c5-447d-b66d-39f180ab2871" class="colab-df-container">
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
          <th>Razón Social</th>
          <th>Margen EBIT</th>
          <th>Carga financiera</th>
          <th>Margen neto</th>
          <th>CxC</th>
          <th>CxP</th>
          <th>Solvencia</th>
          <th>Apalancamiento</th>
          <th>En Reorganización</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>AACER SAS</td>
          <td>0.071690</td>
          <td>0.000000</td>
          <td>0.042876</td>
          <td>0.104095</td>
          <td>0.153192</td>
          <td>1.877078</td>
          <td>1.642505</td>
          <td>0</td>
        </tr>
        <tr>
          <th>1</th>
          <td>ABARROTES EL ROMPOY SAS</td>
          <td>0.017816</td>
          <td>0.000000</td>
          <td>0.010767</td>
          <td>0.018414</td>
          <td>0.000000</td>
          <td>0.000000</td>
          <td>0.865044</td>
          <td>0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>ABASTECIMIENTOS INDUSTRIALES SAS</td>
          <td>0.144646</td>
          <td>0.054226</td>
          <td>0.059784</td>
          <td>0.227215</td>
          <td>0.025591</td>
          <td>1.077412</td>
          <td>1.272299</td>
          <td>0</td>
        </tr>
        <tr>
          <th>3</th>
          <td>ACME LEON PLASTICOS SAS</td>
          <td>0.004465</td>
          <td>0.000000</td>
          <td>-0.013995</td>
          <td>0.073186</td>
          <td>0.127866</td>
          <td>0.000000</td>
          <td>1.391645</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>ADVANCED PRODUCTS COLOMBIA SAS</td>
          <td>0.141829</td>
          <td>0.050810</td>
          <td>0.053776</td>
          <td>0.398755</td>
          <td>0.147678</td>
          <td>0.675073</td>
          <td>2.118774</td>
          <td>0</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-1eac0771-c0c5-447d-b66d-39f180ab2871')"
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
            document.querySelector('#df-1eac0771-c0c5-447d-b66d-39f180ab2871 button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-1eac0771-c0c5-447d-b66d-39f180ab2871');
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
    
    
        <div id="df-c75d1197-ed11-4036-a950-b097e7d449b0">
          <button class="colab-df-quickchart" onclick="quickchart('df-c75d1197-ed11-4036-a950-b097e7d449b0')"
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
                document.querySelector('#df-c75d1197-ed11-4036-a950-b097e7d449b0 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



.. code:: ipython3

    df.info()


.. parsed-literal::

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 629 entries, 0 to 628
    Data columns (total 9 columns):
     #   Column             Non-Null Count  Dtype  
    ---  ------             --------------  -----  
     0   Razón Social       629 non-null    object 
     1   Margen EBIT        629 non-null    float64
     2   Carga financiera   629 non-null    float64
     3   Margen neto        629 non-null    float64
     4   CxC                629 non-null    float64
     5   CxP                629 non-null    float64
     6   Solvencia          629 non-null    float64
     7   Apalancamiento     629 non-null    float64
     8   En Reorganización  629 non-null    int64  
    dtypes: float64(7), int64(1), object(1)
    memory usage: 44.4+ KB
    

.. code:: ipython3

    # Conteo absoluto
    conteo_clases = df['En Reorganización'].value_counts()
    # Porcentaje
    porcentaje_clases = df['En Reorganización'].value_counts(normalize=True) * 100
    
    # Mostrar conteo y porcentaje
    print("Cantidad de empresas por clase:")
    print(conteo_clases)
    print("\nPorcentaje de empresas por clase:")
    print(porcentaje_clases.round(2))


.. parsed-literal::

    Cantidad de empresas por clase:
    En Reorganización
    1    342
    0    287
    Name: count, dtype: int64
    
    Porcentaje de empresas por clase:
    En Reorganización
    1    54.37
    0    45.63
    Name: proportion, dtype: float64
    

Análisis de las variable:
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Filtrar solo las variables numéricas
    df_numericas = df.select_dtypes(include=['number'])
    
    # Calcular la matriz de correlación
    matriz_corr = df_numericas.corr()
    
    # Crear el heatmap
    plt.figure(figsize=(10, 8))
    sns.heatmap(matriz_corr, annot=True, fmt='.2f', cmap='coolwarm', center=0)
    plt.title('Matriz de Correlación')
    plt.tight_layout()
    plt.show()



.. image:: output_7_0.png


.. code:: ipython3

    variables = df_numericas.columns.tolist()
    variables.remove('En Reorganización')
    
    n_vars = len(variables)
    
    # Configurar el grid de subplots
    n_cols = 3
    n_rows = (n_vars + n_cols - 1) // n_cols  # redondeo hacia arriba
    fig, axes = plt.subplots(n_rows, n_cols, figsize=(16, 4 * n_rows))
    axes = axes.flatten()
    
    # Graficar cada variable
    for i, var in enumerate(variables):
        sns.kdeplot(data=df, x=var, hue='En Reorganización',
                    common_norm=False, fill=True, ax=axes[i])
        axes[i].set_title(f'Distribución de {var}')
        axes[i].set_xlabel(var)
        axes[i].set_ylabel('Densidad')
    
    # Eliminar subplots vacíos
    for j in range(i+1, len(axes)):
        fig.delaxes(axes[j])
    
    plt.tight_layout()
    plt.show()



.. image:: output_8_0.png


.. code:: ipython3

    # Configurar subplots
    n_rows = (len(variables) + 1) // 2
    fig, axs = plt.subplots(n_rows, 2, figsize=(14, n_rows * 4))
    axs = axs.flatten()
    
    # Crear un boxplot por variable
    for i, var in enumerate(variables):
        sns.boxplot(data=df, x='En Reorganización', y=var, hue='En Reorganización',
                    ax=axs[i], palette='Set2', legend=False)
        axs[i].set_title(f'Distribución de {var} por clase')
        axs[i].set_xlabel('En Reorganización')
        axs[i].set_ylabel(var)
    
    # Eliminar subplots vacíos si hay un número impar de variables
    for j in range(i + 1, len(axs)):
        fig.delaxes(axs[j])
    
    plt.tight_layout()
    plt.show()



.. image:: output_9_0.png


Los gráficos de distribución por clase permiten visualizar cómo se
comporta cada variable para las dos categorías del problema (por
ejemplo, empresas en reorganización vs. empresas no en reorganización).
Estos gráficos son fundamentales para evaluar la capacidad
discriminativa de cada variable. A continuación se explican los
principales elementos que se deben observar:

**1. Separación entre distribuciones:**

Se debe observar si las distribuciones de ambas clases están desplazadas
entre sí. Si una clase tiende a tener valores más altos o más bajos que
la otra, esto indica que la variable podría ser útil para predecir la
clase. Una separación clara entre las curvas sugiere un alto poder
discriminativo.

**2. Diferencias en la forma o dispersión:**

Incluso si las distribuciones se superponen parcialmente, puede haber
diferencias importantes en su forma (asimetría, curtosis, colas). Por
ejemplo, una clase puede concentrarse en un rango estrecho, mientras que
la otra está más dispersa.

**3. Presencia de comportamientos no lineales:**

Es posible encontrar relaciones no lineales entre la variable y la clase
objetivo. Por ejemplo, si la probabilidad de estar en reorganización es
alta tanto para valores muy bajos como muy altos de una variable (forma
de U), se sugiere una relación no lineal.

**4. Superposición completa entre clases:**

Si las curvas de distribución son prácticamente iguales entre clases, la
variable probablemente no tenga valor predictivo. Esto puede orientar su
exclusión del modelo o su transformación.

**5. Validación de intuiciones económicas o contables:**

Las diferencias encontradas deben tener sentido desde una perspectiva
contable o financiera. Por ejemplo, es esperable que empresas con
márgenes operativos negativos o altos niveles de apalancamiento tengan
mayor probabilidad de estar en reorganización.

.. code:: ipython3

    # Número de bins (cuantiles)
    n_bins = 10
    
    # Crear una copia del DataFrame original para no alterar el original
    df_binned = df.copy()
    
    # Calcular la tasa base de reorganización (proporción de clase 1)
    tasa_base = df_binned['En Reorganización'].mean()
    
    # Crear una figura para múltiples gráficos
    fig, axs = plt.subplots(nrows=4, ncols=2, figsize=(15, 18))
    axs = axs.flatten()
    
    for i, var in enumerate(variables):
        # Binning por cuantiles
        df_binned[f'{var}_bin'] = pd.qcut(df_binned[var], q=n_bins, duplicates='drop')
    
        # Calcular la tasa de empresas en reorganización por bin
        tasa_bin = df_binned.groupby(f'{var}_bin', observed=False)['En Reorganización'].agg(['count', 'mean']).reset_index()
        tasa_bin.columns = [f'{var}_bin', 'n_empresas', 'tasa_reorganizacion']
    
        # Gráfico de barras
        sns.barplot(data=tasa_bin, x=f'{var}_bin', y='tasa_reorganizacion', ax=axs[i], color='skyblue')
        axs[i].set_title(f'Tasa de Reorganización por Decil de {var}')
        axs[i].tick_params(axis='x', rotation=45)
        axs[i].set_ylabel('Tasa de Reorganización')
        axs[i].set_xlabel('Decil')
        axs[i].set_ylim(0, 1)
    
        # Línea horizontal con la tasa base
        axs[i].axhline(y=tasa_base, color='red', linestyle='--', linewidth=2, label='Tasa base')
        axs[i].legend()
    
    # Eliminar los subplots vacíos si hay más subplots que variables
    for j in range(len(variables), len(axs)):
        fig.delaxes(axs[j])
    
    plt.tight_layout()
    plt.show()



.. image:: output_11_0.png


Interpretación de los gráficos por decil:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Los gráficos presentados muestran la tasa de empresas en reorganización
dentro de cada decil (binning por cuantiles) de diferentes variables
financieras.

Estos gráficos permiten evaluar visualmente la capacidad discriminante
de cada variable con respecto al evento de reorganización empresarial. A
continuación, se detalla qué aspectos se deben analizar:

**1. Tendencia de la tasa de reorganización:**

Es importante observar si existe una relación creciente o decreciente
entre los valores de la variable y la tasa de reorganización. Una
tendencia clara sugiere que la variable puede tener un buen poder
predictivo. Por ejemplo, si a menor margen Neto se observa una mayor
tasa de reorganización, esta variable podría ser útil para identificar
empresas con alto riesgo.

**2. Comparación con la tasa base:**

Cada gráfico incluye una línea horizontal que representa la tasa base de
reorganización del conjunto total de empresas. Se debe evaluar si
existen deciles cuya tasa se encuentra sustancialmente por encima o por
debajo de esta línea. Aquellos deciles con tasas significativamente
mayores pueden señalar zonas de alto riesgo, mientras que tasas menores
indican menor probabilidad de reorganización.

**3. Monotonía:**

Una tasa que aumenta o disminuye de forma monótona a lo largo de los
deciles sugiere que la variable tiene una relación estable y predecible
con el resultado, lo cual es especialmente útil en modelos de
clasificación lineales como la regresión logística. Por el contrario, si
la tasa fluctúa de manera errática entre deciles, puede indicar una
relación débil o no lineal, o bien la necesidad de transformar la
variable.

**4. Estabilidad y confiabilidad de los deciles:**

Aunque los deciles se construyen para contener un número similar de
observaciones, es importante verificar que no haya bins con muy pocos
datos o dominados por valores atípicos, ya que esto puede comprometer la
confiabilidad de las tasas observadas.

Regresión logística:
~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    from sklearn.model_selection import train_test_split
    from sklearn.linear_model import LogisticRegression
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import classification_report, confusion_matrix, roc_auc_score, roc_curve, ConfusionMatrixDisplay

.. code:: ipython3

    # ------------------------
    # Selección de variables
    # ------------------------
    variables_seleccionadas = ['Margen EBIT',
                               'Carga financiera',
                               'Margen neto',
                               'CxC',
                               'CxP',
                               'Solvencia',
                               'Apalancamiento']
    
    # Variable objetivo
    target = 'En Reorganización'
    
    # ------------------------
    # Preparar datos
    # ------------------------
    X = df[variables_seleccionadas]
    y = df[target]
    
    # Estandarizar variables
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)
    
    # Dividir en entrenamiento y prueba (70%-30%)
    X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.3, random_state=35, stratify=y)

``stratify=y`` le dice a ``train_test_split`` que mantenga la misma
proporción de clases de ``y`` (variable objetivo) en los subconjuntos de
train y test.

.. code:: ipython3

    # ------------------------
    # Ajustar el modelo
    # ------------------------
    model = LogisticRegression()
    model.fit(X_train, y_train)
    
    # ------------------------
    # Predicciones
    # ------------------------
    y_pred_train = model.predict(X_train)
    y_prob_train = model.predict_proba(X_train)[:, 1]
    
    y_pred = model.predict(X_test)
    y_prob = model.predict_proba(X_test)[:, 1]

.. code:: ipython3

    # ------------------------
    # Evaluación del modelo
    # ------------------------
    cm_train = confusion_matrix(y_train, y_pred_train, labels=[0,1])
    cm_df_train = pd.DataFrame(cm_train, index=["Real 0", "Real 1"], columns=["Predicho 0", "Predicho 1"])
    
    plt.figure(figsize=(5.2,4.2))
    sns.heatmap(cm_train, annot=True, fmt="d", cbar=True, linewidths=.5, cmap="coolwarm")
    plt.title("Matriz de confusión - train")
    plt.xlabel("Predicho"); plt.ylabel("Real")
    plt.tight_layout()
    plt.show()
    
    cm = confusion_matrix(y_test, y_pred, labels=[0,1])
    cm_df = pd.DataFrame(cm, index=["Real 0", "Real 1"], columns=["Predicho 0", "Predicho 1"])
    
    plt.figure(figsize=(5.2,4.2))
    sns.heatmap(cm_df, annot=True, fmt="d", cbar=True, linewidths=.5, cmap="coolwarm")
    plt.title("Matriz de confusión - Test")
    plt.xlabel("Predicho"); plt.ylabel("Real")
    plt.tight_layout()
    plt.show()



.. image:: output_19_0.png



.. image:: output_19_1.png


.. code:: ipython3

    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.70      0.76      0.73       201
               1       0.78      0.72      0.75       239
    
        accuracy                           0.74       440
       macro avg       0.74      0.74      0.74       440
    weighted avg       0.74      0.74      0.74       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.64      0.71      0.67        86
               1       0.73      0.66      0.69       103
    
        accuracy                           0.68       189
       macro avg       0.68      0.68      0.68       189
    weighted avg       0.69      0.68      0.68       189
    
    

.. code:: ipython3

    # ============================
    # ROC AUC Score
    # ============================
    auc_train = roc_auc_score(y_train, y_prob_train)
    auc_test = roc_auc_score(y_test, y_prob)
    
    print(f"ROC AUC - Train: {auc_train:.3f}")
    print(f"ROC AUC - Test : {auc_test:.3f}")
    
    # ============================
    # Curva ROC (Train y Test)
    # ============================
    fpr_train, tpr_train, _ = roc_curve(y_train, y_prob_train)
    fpr_test, tpr_test, _ = roc_curve(y_test, y_prob)
    
    plt.figure(figsize=(8, 6))
    plt.plot(fpr_train, tpr_train, label=f'Train (AUC = {auc_train:.2f})', color='blue')
    plt.plot(fpr_test, tpr_test, label=f'Test  (AUC = {auc_test:.2f})', color='orange')
    plt.plot([0, 1], [0, 1], 'k--', label='Azar')
    plt.xlabel("False Positive Rate")
    plt.ylabel("True Positive Rate")
    plt.title("Curva ROC - Train y Test")
    plt.legend(loc="lower right")
    plt.grid(True)
    plt.tight_layout()
    plt.show()


.. parsed-literal::

    ROC AUC - Train: 0.819
    ROC AUC - Test : 0.809
    


.. image:: output_21_1.png


.. code:: ipython3

    # Calcular precisión y recall para diferentes umbrales
    precision, recall, thresholds = precision_recall_curve(y_test, y_prob)
    
    # Agregar el umbral 0 para completar el array de thresholds
    thresholds = np.append(thresholds, 1)
    
    # Graficar precisión y recall en función del umbral
    plt.figure(figsize=(10, 6))
    plt.plot(thresholds, precision, label="Precisión")
    plt.plot(thresholds, recall, label="Recall")
    plt.xlabel("Umbral")
    plt.ylabel("Precisión/Recall")
    plt.title("Precisión y Recall en función del umbral")
    plt.legend()
    plt.grid(True)
    plt.show()



.. image:: output_22_0.png


.. code:: ipython3

    plt.figure(figsize=(8, 6))
    plt.plot(recall, precision, marker=".", label="Regresión Logística")
    plt.xlabel("Recall")
    plt.ylabel("Precisión")
    plt.title("Curva de Precisión-Recall")
    plt.legend()
    plt.grid(True)
    plt.show()



.. image:: output_23_0.png


.. code:: ipython3

    # DataFrame con probas y clase real
    df_deciles = pd.DataFrame({'y_real': y_test, 'y_proba': y_prob})
    
    # Crear deciles (1 = más alto riesgo, 10 = más bajo)
    df_deciles['Decil'] = pd.qcut(df_deciles['y_proba'], 10, labels=False, duplicates='drop') + 1
    df_deciles['Decil'] = 11 - df_deciles['Decil']   # invertir para que el decil 1 sea el de mayor riesgo
    
    # Calcular tasa por decil
    tabla_deciles = df_deciles.groupby('Decil').agg(
        Total=('y_real','count'),
        Positivos=('y_real','sum')
    )
    tabla_deciles['Tasa'] = tabla_deciles['Positivos'] / tabla_deciles['Total']
    tabla_deciles['Lift'] = tabla_deciles['Tasa'] / df_deciles['y_real'].mean()
    tabla_deciles['Captura_Acum'] = tabla_deciles['Positivos'].cumsum() / df_deciles['y_real'].sum()
    
    print(f"Tasa de positivos reales en test: {df_deciles['y_real'].mean():.2f}")
    
    print(tabla_deciles)
    
    # --- 📊 Gráfico ---
    plt.figure(figsize=(8,5))
    plt.plot(tabla_deciles.index, tabla_deciles['Tasa'], marker='o', linestyle='-', color='blue')
    plt.title("Tasa de positivos por decil")
    plt.xlabel("Decil")
    plt.ylabel("Tasa de clase 1")
    plt.grid(True)
    plt.show()


.. parsed-literal::

    Tasa de positivos reales en test: 0.54
           Total  Positivos      Tasa      Lift  Captura_Acum
    Decil                                                    
    1         19         19  1.000000  1.834951      0.184466
    2         19         19  1.000000  1.834951      0.368932
    3         19         17  0.894737  1.641799      0.533981
    4         19          8  0.421053  0.772611      0.611650
    5         18          6  0.333333  0.611650      0.669903
    6         19         11  0.578947  1.062340      0.776699
    7         19          8  0.421053  0.772611      0.854369
    8         19          7  0.368421  0.676035      0.922330
    9         19          5  0.263158  0.482882      0.970874
    10        19          3  0.157895  0.289729      1.000000
    


.. image:: output_24_1.png


El gráfico de tasa por decil muestra la capacidad del modelo para
concentrar los casos positivos en los grupos de mayor probabilidad
predicha. En el eje X se representan los deciles, donde el decil 1
corresponde al 10% de las observaciones con mayor score de probabilidad
de ser clase 1 (empresas con mayor riesgo de estar en reorganización) y
el decil 10 al 10% con menor score. En el eje Y se grafica la proporción
real de casos positivos en cada decil. Así, un valor alto en el decil 1
indica que el modelo efectivamente concentró en ese grupo a la mayoría
de las empresas que realmente estaban en reorganización, mientras que
valores bajos en los deciles finales muestran que el modelo relegó allí
a las empresas sanas. En un modelo discriminante, la curva es
decreciente: alta en los primeros deciles y cercana a cero en los
últimos, lo que refleja un buen poder de clasificación.

**Decil 1** = top 10% de predicciones con mayor probabilidad de ser
clase 1.

Son los casos donde el modelo dijo: “estos tienen altísima chance de
estar en reorganización”.

**Eje Y:** tasa real de positivos en ese decil.

Para el decil 1, de ese 10% con mayor probabilidad, ¿qué proporción
efectivamente resultó ser clase 1 en la realidad?

Si en Decil 1 hay 100 empresas y el modelo les dio los scores más altos,
y en realidad 90 están en reorganización → el punto en el gráfico estará
en 0.90 (90%).

El lift compara la tasa de positivos en un decil con la tasa global de
positivos en toda la muestra.

Si el modelo ordena bien, los positivos deberían estar concentrados
arriba (en los primeros deciles).

A medida que bajas a deciles con menor probabilidad predicha, deberían
aparecer menos positivos y más negativos. Por lo tanto, la tasa de
positivos en esos deciles será menor que la global, y el lift va
acercándose a 1 (rendimiento igual al promedio) o incluso <1 (peor que
el promedio).

Al final (deciles bajos), el modelo debería concentrar casi solo
negativos, por lo que el lift tiende a 0.

.. math::


   \text{Lift}_{decil} = \frac{\text{Tasa de positivos en el decil}}{\text{Tasa global de positivos}}

.. math::


   \text{Tasa de positivos en el decil} = \frac{\# \text{positivos en el decil}}{\# \text{observaciones en el decil}}

.. math::


   \text{Tasa global de positivos} = \frac{\# \text{positivos en toda la muestra}}{\# \text{observaciones totales}}

Cambio de umbral:
~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # Crear lista de umbrales a evaluar
    umbrales = np.arange(0.1, 0.91, 0.05)
    
    # Lista para almacenar resultados
    resultados = []
    
    for umbral in umbrales:
        y_pred_umbral = (y_prob >= umbral).astype(int)
        tn, fp, fn, tp = confusion_matrix(y_test, y_pred_umbral).ravel()
    
        precision = precision_score(y_test, y_pred_umbral, zero_division=0)
        recall = recall_score(y_test, y_pred_umbral)
        specificity = tn / (tn + fp)
        accuracy = accuracy_score(y_test, y_pred_umbral)
        f1 = f1_score(y_test, y_pred_umbral)
    
        resultados.append({
            'Umbral': umbral,
            'Precision': precision,
            'Recall (Sensibilidad)': recall,
            'Especificidad': specificity,
            'Accuracy': accuracy,
            'F1-score': f1
        })
    
    # Convertir a DataFrame
    df_resultados = pd.DataFrame(resultados)
    
    # Mostrar tabla
    plt.figure(figsize=(12, 6))
    sns.lineplot(data=df_resultados.set_index('Umbral'))
    plt.title('Métricas por Umbral de Decisión')
    plt.ylabel('Valor')
    plt.gca().yaxis.set_major_formatter(mtick.PercentFormatter(1.0))
    plt.grid(True)
    plt.show()
    
    df_resultados
    



.. image:: output_29_0.png




.. raw:: html

    
      <div id="df-e2163b46-353a-4ee5-9018-3a52a787829f" class="colab-df-container">
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
          <th>Umbral</th>
          <th>Precision</th>
          <th>Recall (Sensibilidad)</th>
          <th>Especificidad</th>
          <th>Accuracy</th>
          <th>F1-score</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.10</td>
          <td>0.553763</td>
          <td>1.000000</td>
          <td>0.034884</td>
          <td>0.560847</td>
          <td>0.712803</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.15</td>
          <td>0.560440</td>
          <td>0.990291</td>
          <td>0.069767</td>
          <td>0.571429</td>
          <td>0.715789</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.20</td>
          <td>0.573864</td>
          <td>0.980583</td>
          <td>0.127907</td>
          <td>0.592593</td>
          <td>0.724014</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0.25</td>
          <td>0.584795</td>
          <td>0.970874</td>
          <td>0.174419</td>
          <td>0.608466</td>
          <td>0.729927</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0.30</td>
          <td>0.602410</td>
          <td>0.970874</td>
          <td>0.232558</td>
          <td>0.634921</td>
          <td>0.743494</td>
        </tr>
        <tr>
          <th>5</th>
          <td>0.35</td>
          <td>0.627451</td>
          <td>0.932039</td>
          <td>0.337209</td>
          <td>0.661376</td>
          <td>0.750000</td>
        </tr>
        <tr>
          <th>6</th>
          <td>0.40</td>
          <td>0.656934</td>
          <td>0.873786</td>
          <td>0.453488</td>
          <td>0.682540</td>
          <td>0.750000</td>
        </tr>
        <tr>
          <th>7</th>
          <td>0.45</td>
          <td>0.710526</td>
          <td>0.786408</td>
          <td>0.616279</td>
          <td>0.708995</td>
          <td>0.746544</td>
        </tr>
        <tr>
          <th>8</th>
          <td>0.50</td>
          <td>0.731183</td>
          <td>0.660194</td>
          <td>0.709302</td>
          <td>0.682540</td>
          <td>0.693878</td>
        </tr>
        <tr>
          <th>9</th>
          <td>0.55</td>
          <td>0.810127</td>
          <td>0.621359</td>
          <td>0.825581</td>
          <td>0.714286</td>
          <td>0.703297</td>
        </tr>
        <tr>
          <th>10</th>
          <td>0.60</td>
          <td>0.892308</td>
          <td>0.563107</td>
          <td>0.918605</td>
          <td>0.724868</td>
          <td>0.690476</td>
        </tr>
        <tr>
          <th>11</th>
          <td>0.65</td>
          <td>0.949153</td>
          <td>0.543689</td>
          <td>0.965116</td>
          <td>0.735450</td>
          <td>0.691358</td>
        </tr>
        <tr>
          <th>12</th>
          <td>0.70</td>
          <td>0.979167</td>
          <td>0.456311</td>
          <td>0.988372</td>
          <td>0.698413</td>
          <td>0.622517</td>
        </tr>
        <tr>
          <th>13</th>
          <td>0.75</td>
          <td>1.000000</td>
          <td>0.417476</td>
          <td>1.000000</td>
          <td>0.682540</td>
          <td>0.589041</td>
        </tr>
        <tr>
          <th>14</th>
          <td>0.80</td>
          <td>1.000000</td>
          <td>0.368932</td>
          <td>1.000000</td>
          <td>0.656085</td>
          <td>0.539007</td>
        </tr>
        <tr>
          <th>15</th>
          <td>0.85</td>
          <td>1.000000</td>
          <td>0.262136</td>
          <td>1.000000</td>
          <td>0.597884</td>
          <td>0.415385</td>
        </tr>
        <tr>
          <th>16</th>
          <td>0.90</td>
          <td>1.000000</td>
          <td>0.233010</td>
          <td>1.000000</td>
          <td>0.582011</td>
          <td>0.377953</td>
        </tr>
      </tbody>
    </table>
    </div>
        <div class="colab-df-buttons">
    
      <div class="colab-df-container">
        <button class="colab-df-convert" onclick="convertToInteractive('df-e2163b46-353a-4ee5-9018-3a52a787829f')"
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
            document.querySelector('#df-e2163b46-353a-4ee5-9018-3a52a787829f button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-e2163b46-353a-4ee5-9018-3a52a787829f');
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
    
    
        <div id="df-83509ab5-2dac-405c-b16d-9fc4fe61ea7d">
          <button class="colab-df-quickchart" onclick="quickchart('df-83509ab5-2dac-405c-b16d-9fc4fe61ea7d')"
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
                document.querySelector('#df-83509ab5-2dac-405c-b16d-9fc4fe61ea7d button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
      <div id="id_3f267fc1-9928-469a-984b-f126250be4b6">
        <style>
          .colab-df-generate {
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
    
          .colab-df-generate:hover {
            background-color: #E2EBFA;
            box-shadow: 0px 1px 2px rgba(60, 64, 67, 0.3), 0px 1px 3px 1px rgba(60, 64, 67, 0.15);
            fill: #174EA6;
          }
    
          [theme=dark] .colab-df-generate {
            background-color: #3B4455;
            fill: #D2E3FC;
          }
    
          [theme=dark] .colab-df-generate:hover {
            background-color: #434B5C;
            box-shadow: 0px 1px 3px 1px rgba(0, 0, 0, 0.15);
            filter: drop-shadow(0px 1px 2px rgba(0, 0, 0, 0.3));
            fill: #FFFFFF;
          }
        </style>
        <button class="colab-df-generate" onclick="generateWithVariable('df_resultados')"
                title="Generate code using this dataframe."
                style="display:none;">
    
      <svg xmlns="http://www.w3.org/2000/svg" height="24px"viewBox="0 0 24 24"
           width="24px">
        <path d="M7,19H8.4L18.45,9,17,7.55,7,17.6ZM5,21V16.75L18.45,3.32a2,2,0,0,1,2.83,0l1.4,1.43a1.91,1.91,0,0,1,.58,1.4,1.91,1.91,0,0,1-.58,1.4L9.25,21ZM18.45,9,17,7.55Zm-12,3A5.31,5.31,0,0,0,4.9,8.1,5.31,5.31,0,0,0,1,6.5,5.31,5.31,0,0,0,4.9,4.9,5.31,5.31,0,0,0,6.5,1,5.31,5.31,0,0,0,8.1,4.9,5.31,5.31,0,0,0,12,6.5,5.46,5.46,0,0,0,6.5,12Z"/>
      </svg>
        </button>
        <script>
          (() => {
          const buttonEl =
            document.querySelector('#id_3f267fc1-9928-469a-984b-f126250be4b6 button.colab-df-generate');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          buttonEl.onclick = () => {
            google.colab.notebook.generateWithVariable('df_resultados');
          }
          })();
        </script>
      </div>
    
        </div>
      </div>
    



.. code:: ipython3

    umbral_optimo = 0.47
    
    y_pred_final = (y_prob >= umbral_optimo).astype(int)
    
    cm_df_final = confusion_matrix(y_test, y_pred_final)
    
    plt.figure(figsize=(5.2,4.2))
    sns.heatmap(cm_df_final, annot=True, fmt="d", cbar=True, linewidths=.5, cmap="coolwarm")
    plt.title("Matriz de confusión - Test")
    plt.xlabel("Predicho"); plt.ylabel("Real")
    plt.tight_layout()
    plt.show()
    
    print("\nReporte de Clasificación:")
    print(classification_report(y_test, y_pred_final))
    
    print(f"ROC AUC: {roc_auc_score(y_test, y_prob):.3f}")



.. image:: output_30_0.png


.. parsed-literal::

    
    Reporte de Clasificación:
                  precision    recall  f1-score   support
    
               0       0.69      0.64      0.66        86
               1       0.72      0.76      0.74       103
    
        accuracy                           0.70       189
       macro avg       0.70      0.70      0.70       189
    weighted avg       0.70      0.70      0.70       189
    
    ROC AUC: 0.809
    

.. code:: ipython3

    # DataFrame con probas y clase real
    df_deciles = pd.DataFrame({'y_real': y_pred_final, 'y_proba': y_prob})
    
    # Crear deciles (1 = más alto riesgo, 10 = más bajo)
    df_deciles['Decil'] = pd.qcut(df_deciles['y_proba'], 10, labels=False, duplicates='drop') + 1
    df_deciles['Decil'] = 11 - df_deciles['Decil']   # invertir para que el decil 1 sea el de mayor riesgo
    
    # Calcular tasa por decil
    tabla_deciles = df_deciles.groupby('Decil').agg(
        Total=('y_real','count'),
        Positivos=('y_real','sum')
    )
    tabla_deciles['Tasa'] = tabla_deciles['Positivos'] / tabla_deciles['Total']
    tabla_deciles['Lift'] = tabla_deciles['Tasa'] / df_deciles['y_real'].mean()
    tabla_deciles['Captura_Acum'] = tabla_deciles['Positivos'].cumsum() / df_deciles['y_real'].sum()
    
    print(f"Tasa de positivos reales en test: {df_deciles['y_real'].mean():.2f}")
    
    print(tabla_deciles)
    
    # --- 📊 Gráfico ---
    plt.figure(figsize=(8,5))
    plt.plot(tabla_deciles.index, tabla_deciles['Tasa'], marker='o', linestyle='-', color='blue')
    plt.title("Tasa de positivos por decil")
    plt.xlabel("Decil")
    plt.ylabel("Tasa de clase 1")
    plt.grid(True)
    plt.show()


.. parsed-literal::

    Tasa de positivos reales en test: 0.58
           Total  Positivos      Tasa      Lift  Captura_Acum
    Decil                                                    
    1         19         19  1.000000  1.733945      0.174312
    2         19         19  1.000000  1.733945      0.348624
    3         19         19  1.000000  1.733945      0.522936
    4         19         19  1.000000  1.733945      0.697248
    5         18         18  1.000000  1.733945      0.862385
    6         19         15  0.789474  1.368904      1.000000
    7         19          0  0.000000  0.000000      1.000000
    8         19          0  0.000000  0.000000      1.000000
    9         19          0  0.000000  0.000000      1.000000
    10        19          0  0.000000  0.000000      1.000000
    


.. image:: output_31_1.png


Cambio de parámetros:
~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    # ------------------------
    # Ajustar el modelo
    # ------------------------
    model = LogisticRegression(C=0.01)
    model.fit(X_train, y_train)
    
    # ------------------------
    # Predicciones
    # ------------------------
    y_pred_train = model.predict(X_train)
    y_prob_train = model.predict_proba(X_train)[:, 1]
    
    y_pred = model.predict(X_test)
    y_prob = model.predict_proba(X_test)[:, 1]
    
    # ------------------------
    # Evaluación del modelo
    # ------------------------
    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))
    
    # DataFrame con probas y clase real
    df_deciles = pd.DataFrame({'y_real': y_test, 'y_proba': y_prob})
    
    # Crear deciles (1 = más alto riesgo, 10 = más bajo)
    df_deciles['Decil'] = pd.qcut(df_deciles['y_proba'], 10, labels=False, duplicates='drop') + 1
    df_deciles['Decil'] = 11 - df_deciles['Decil']   # invertir para que el decil 1 sea el de mayor riesgo
    
    # Calcular tasa por decil
    tabla_deciles = df_deciles.groupby('Decil').agg(
        Total=('y_real','count'),
        Positivos=('y_real','sum')
    )
    tabla_deciles['Tasa'] = tabla_deciles['Positivos'] / tabla_deciles['Total']
    tabla_deciles['Lift'] = tabla_deciles['Tasa'] / df_deciles['y_real'].mean()
    tabla_deciles['Captura_Acum'] = tabla_deciles['Positivos'].cumsum() / df_deciles['y_real'].sum()
    
    # --- 📊 Gráfico ---
    plt.figure(figsize=(8,5))
    plt.plot(tabla_deciles.index, tabla_deciles['Tasa'], marker='o', linestyle='-', color='blue')
    plt.title("Tasa de positivos por decil")
    plt.xlabel("Decil")
    plt.ylabel("Tasa de clase 1")
    plt.grid(True)
    plt.show()


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.69      0.53      0.60       201
               1       0.67      0.80      0.73       239
    
        accuracy                           0.68       440
       macro avg       0.68      0.67      0.67       440
    weighted avg       0.68      0.68      0.67       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.71      0.49      0.58        86
               1       0.66      0.83      0.74       103
    
        accuracy                           0.68       189
       macro avg       0.69      0.66      0.66       189
    weighted avg       0.68      0.68      0.67       189
    
    


.. image:: output_33_1.png

