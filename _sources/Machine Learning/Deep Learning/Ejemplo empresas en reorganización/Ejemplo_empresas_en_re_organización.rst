.. code:: ipython3

    import pandas as pd
    import numpy as np
    import matplotlib.pyplot as plt
    import seaborn as sns
    from sklearn.model_selection import train_test_split
    from sklearn.preprocessing import StandardScaler
    from sklearn.metrics import accuracy_score
    from sklearn.metrics import classification_report, confusion_matrix, accuracy_score, recall_score, precision_score

.. code:: ipython3

    path = "BD empresas en re organización.xlsx"
    
    xls = pd.ExcelFile(path)
    
    df = pd.read_excel(path, sheet_name=xls.sheet_names[0])
    
    df.head()




.. raw:: html

    
      <div id="df-8af91f69-fa6c-459c-81fd-7208d5f2f68a" class="colab-df-container">
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
        <button class="colab-df-convert" onclick="convertToInteractive('df-8af91f69-fa6c-459c-81fd-7208d5f2f68a')"
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
            document.querySelector('#df-8af91f69-fa6c-459c-81fd-7208d5f2f68a button.colab-df-convert');
          buttonEl.style.display =
            google.colab.kernel.accessAllowed ? 'block' : 'none';
    
          async function convertToInteractive(key) {
            const element = document.querySelector('#df-8af91f69-fa6c-459c-81fd-7208d5f2f68a');
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
    
    
        <div id="df-ecb4812f-06c8-4f1b-b688-ec18f8502d41">
          <button class="colab-df-quickchart" onclick="quickchart('df-ecb4812f-06c8-4f1b-b688-ec18f8502d41')"
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
                document.querySelector('#df-ecb4812f-06c8-4f1b-b688-ec18f8502d41 button');
              quickchartButtonEl.style.display =
                google.colab.kernel.accessAllowed ? 'block' : 'none';
            })();
          </script>
        </div>
    
        </div>
      </div>
    



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

.. code:: ipython3

    type(X_train)




.. parsed-literal::

    numpy.ndarray



.. code:: ipython3

    X_train.shape




.. parsed-literal::

    (440, 7)



.. code:: ipython3

    from keras.models import Sequential
    from keras.layers import Dense, Input, Dropout
    from keras import optimizers

.. code:: ipython3

    model = Sequential()
    
    model.add(Input(shape=(X.shape[1],)))   # Definimos la forma de entrada
    model.add(Dense(units=10, activation="relu")) # Primera capa oculta
    model.add(Dense(units=10, activation="relu")) # Segunda capa oculta
    model.add(Dense(units=1, activation="sigmoid")) # Capa de salida
    
    model.compile(loss="binary_crossentropy", metrics=["accuracy"], optimizer=optimizers.Adam(learning_rate=0.001))
    
    history = model.fit(X_train, y_train, epochs=100,
                        validation_data=(X_test, y_test),
                        batch_size=32,
                        verbose=1)


.. parsed-literal::

    Epoch 1/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m3s[0m 56ms/step - accuracy: 0.6487 - loss: 0.6540 - val_accuracy: 0.6667 - val_loss: 0.6418
    Epoch 2/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 58ms/step - accuracy: 0.7216 - loss: 0.6285 - val_accuracy: 0.6878 - val_loss: 0.6257
    Epoch 3/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 27ms/step - accuracy: 0.7178 - loss: 0.6154 - val_accuracy: 0.6931 - val_loss: 0.6115
    Epoch 4/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 26ms/step - accuracy: 0.7566 - loss: 0.5849 - val_accuracy: 0.7090 - val_loss: 0.5973
    Epoch 5/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 30ms/step - accuracy: 0.7741 - loss: 0.5819 - val_accuracy: 0.6984 - val_loss: 0.5838
    Epoch 6/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 35ms/step - accuracy: 0.7809 - loss: 0.5538 - val_accuracy: 0.7037 - val_loss: 0.5714
    Epoch 7/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 56ms/step - accuracy: 0.7816 - loss: 0.5547 - val_accuracy: 0.7196 - val_loss: 0.5600
    Epoch 8/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 35ms/step - accuracy: 0.7796 - loss: 0.5158 - val_accuracy: 0.7249 - val_loss: 0.5491
    Epoch 9/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 37ms/step - accuracy: 0.7557 - loss: 0.5264 - val_accuracy: 0.7302 - val_loss: 0.5399
    Epoch 10/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 45ms/step - accuracy: 0.7519 - loss: 0.5069 - val_accuracy: 0.7460 - val_loss: 0.5315
    Epoch 11/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 24ms/step - accuracy: 0.7648 - loss: 0.4940 - val_accuracy: 0.7566 - val_loss: 0.5234
    Epoch 12/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 34ms/step - accuracy: 0.7621 - loss: 0.4989 - val_accuracy: 0.7566 - val_loss: 0.5171
    Epoch 13/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 14ms/step - accuracy: 0.7717 - loss: 0.4844 - val_accuracy: 0.7672 - val_loss: 0.5120
    Epoch 14/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 14ms/step - accuracy: 0.7685 - loss: 0.5119 - val_accuracy: 0.7725 - val_loss: 0.5065
    Epoch 15/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 16ms/step - accuracy: 0.7876 - loss: 0.4653 - val_accuracy: 0.7672 - val_loss: 0.5013
    Epoch 16/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 17ms/step - accuracy: 0.7890 - loss: 0.4694 - val_accuracy: 0.7672 - val_loss: 0.4976
    Epoch 17/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 16ms/step - accuracy: 0.7702 - loss: 0.4673 - val_accuracy: 0.7672 - val_loss: 0.4942
    Epoch 18/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 17ms/step - accuracy: 0.7860 - loss: 0.4590 - val_accuracy: 0.7725 - val_loss: 0.4910
    Epoch 19/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 19ms/step - accuracy: 0.7816 - loss: 0.4466 - val_accuracy: 0.7725 - val_loss: 0.4874
    Epoch 20/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m1s[0m 13ms/step - accuracy: 0.7878 - loss: 0.4385 - val_accuracy: 0.7778 - val_loss: 0.4842
    Epoch 21/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7591 - loss: 0.4712 - val_accuracy: 0.7831 - val_loss: 0.4816
    Epoch 22/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7941 - loss: 0.4304 - val_accuracy: 0.7831 - val_loss: 0.4786
    Epoch 23/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8018 - loss: 0.4240 - val_accuracy: 0.7831 - val_loss: 0.4769
    Epoch 24/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7721 - loss: 0.4767 - val_accuracy: 0.7778 - val_loss: 0.4755
    Epoch 25/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7649 - loss: 0.4617 - val_accuracy: 0.7672 - val_loss: 0.4736
    Epoch 26/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7880 - loss: 0.4148 - val_accuracy: 0.7672 - val_loss: 0.4713
    Epoch 27/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 8ms/step - accuracy: 0.7862 - loss: 0.4458 - val_accuracy: 0.7672 - val_loss: 0.4718
    Epoch 28/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7971 - loss: 0.4291 - val_accuracy: 0.7672 - val_loss: 0.4703
    Epoch 29/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7709 - loss: 0.4286 - val_accuracy: 0.7672 - val_loss: 0.4679
    Epoch 30/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7939 - loss: 0.4301 - val_accuracy: 0.7672 - val_loss: 0.4665
    Epoch 31/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7871 - loss: 0.4393 - val_accuracy: 0.7672 - val_loss: 0.4665
    Epoch 32/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7824 - loss: 0.4321 - val_accuracy: 0.7725 - val_loss: 0.4647
    Epoch 33/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 10ms/step - accuracy: 0.7987 - loss: 0.4359 - val_accuracy: 0.7725 - val_loss: 0.4643
    Epoch 34/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8198 - loss: 0.4110 - val_accuracy: 0.7725 - val_loss: 0.4635
    Epoch 35/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7796 - loss: 0.4268 - val_accuracy: 0.7672 - val_loss: 0.4635
    Epoch 36/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7835 - loss: 0.4394 - val_accuracy: 0.7672 - val_loss: 0.4624
    Epoch 37/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 10ms/step - accuracy: 0.8138 - loss: 0.4157 - val_accuracy: 0.7619 - val_loss: 0.4616
    Epoch 38/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7920 - loss: 0.4308 - val_accuracy: 0.7460 - val_loss: 0.4609
    Epoch 39/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7826 - loss: 0.4411 - val_accuracy: 0.7566 - val_loss: 0.4609
    Epoch 40/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7653 - loss: 0.4597 - val_accuracy: 0.7513 - val_loss: 0.4598
    Epoch 41/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 8ms/step - accuracy: 0.7925 - loss: 0.4191 - val_accuracy: 0.7566 - val_loss: 0.4604
    Epoch 42/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8163 - loss: 0.4024 - val_accuracy: 0.7566 - val_loss: 0.4603
    Epoch 43/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8015 - loss: 0.4214 - val_accuracy: 0.7513 - val_loss: 0.4591
    Epoch 44/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7895 - loss: 0.4372 - val_accuracy: 0.7566 - val_loss: 0.4602
    Epoch 45/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8012 - loss: 0.4219 - val_accuracy: 0.7513 - val_loss: 0.4593
    Epoch 46/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 10ms/step - accuracy: 0.8030 - loss: 0.4299 - val_accuracy: 0.7513 - val_loss: 0.4584
    Epoch 47/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8135 - loss: 0.3938 - val_accuracy: 0.7513 - val_loss: 0.4582
    Epoch 48/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8124 - loss: 0.4165 - val_accuracy: 0.7513 - val_loss: 0.4587
    Epoch 49/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8037 - loss: 0.4129 - val_accuracy: 0.7513 - val_loss: 0.4581
    Epoch 50/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7896 - loss: 0.4202 - val_accuracy: 0.7460 - val_loss: 0.4579
    Epoch 51/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7994 - loss: 0.4367 - val_accuracy: 0.7354 - val_loss: 0.4567
    Epoch 52/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8106 - loss: 0.4146 - val_accuracy: 0.7513 - val_loss: 0.4584
    Epoch 53/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8045 - loss: 0.4196 - val_accuracy: 0.7513 - val_loss: 0.4575
    Epoch 54/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8032 - loss: 0.4253 - val_accuracy: 0.7619 - val_loss: 0.4575
    Epoch 55/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8206 - loss: 0.3812 - val_accuracy: 0.7354 - val_loss: 0.4562
    Epoch 56/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 10ms/step - accuracy: 0.8243 - loss: 0.3859 - val_accuracy: 0.7407 - val_loss: 0.4566
    Epoch 57/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 13ms/step - accuracy: 0.8162 - loss: 0.4148 - val_accuracy: 0.7513 - val_loss: 0.4573
    Epoch 58/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 10ms/step - accuracy: 0.8217 - loss: 0.4149 - val_accuracy: 0.7407 - val_loss: 0.4566
    Epoch 59/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 12ms/step - accuracy: 0.7923 - loss: 0.4262 - val_accuracy: 0.7407 - val_loss: 0.4558
    Epoch 60/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 10ms/step - accuracy: 0.7828 - loss: 0.4501 - val_accuracy: 0.7354 - val_loss: 0.4557
    Epoch 61/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 10ms/step - accuracy: 0.7971 - loss: 0.4353 - val_accuracy: 0.7407 - val_loss: 0.4550
    Epoch 62/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 13ms/step - accuracy: 0.8198 - loss: 0.4084 - val_accuracy: 0.7354 - val_loss: 0.4544
    Epoch 63/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 12ms/step - accuracy: 0.8154 - loss: 0.4011 - val_accuracy: 0.7354 - val_loss: 0.4542
    Epoch 64/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 9ms/step - accuracy: 0.8137 - loss: 0.4137 - val_accuracy: 0.7354 - val_loss: 0.4547
    Epoch 65/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8350 - loss: 0.3822 - val_accuracy: 0.7460 - val_loss: 0.4556
    Epoch 66/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7956 - loss: 0.4270 - val_accuracy: 0.7354 - val_loss: 0.4545
    Epoch 67/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8196 - loss: 0.4190 - val_accuracy: 0.7407 - val_loss: 0.4538
    Epoch 68/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8106 - loss: 0.4313 - val_accuracy: 0.7407 - val_loss: 0.4553
    Epoch 69/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8207 - loss: 0.4226 - val_accuracy: 0.7354 - val_loss: 0.4530
    Epoch 70/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8334 - loss: 0.3974 - val_accuracy: 0.7407 - val_loss: 0.4534
    Epoch 71/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7881 - loss: 0.4449 - val_accuracy: 0.7354 - val_loss: 0.4534
    Epoch 72/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8074 - loss: 0.4221 - val_accuracy: 0.7407 - val_loss: 0.4525
    Epoch 73/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8267 - loss: 0.4023 - val_accuracy: 0.7460 - val_loss: 0.4528
    Epoch 74/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8069 - loss: 0.4141 - val_accuracy: 0.7302 - val_loss: 0.4522
    Epoch 75/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8100 - loss: 0.4160 - val_accuracy: 0.7407 - val_loss: 0.4511
    Epoch 76/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8153 - loss: 0.4101 - val_accuracy: 0.7302 - val_loss: 0.4511
    Epoch 77/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8301 - loss: 0.3827 - val_accuracy: 0.7354 - val_loss: 0.4512
    Epoch 78/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 8ms/step - accuracy: 0.8017 - loss: 0.4064 - val_accuracy: 0.7460 - val_loss: 0.4502
    Epoch 79/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7842 - loss: 0.4210 - val_accuracy: 0.7354 - val_loss: 0.4504
    Epoch 80/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7740 - loss: 0.4259 - val_accuracy: 0.7354 - val_loss: 0.4507
    Epoch 81/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 8ms/step - accuracy: 0.8149 - loss: 0.4102 - val_accuracy: 0.7460 - val_loss: 0.4495
    Epoch 82/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8165 - loss: 0.3984 - val_accuracy: 0.7407 - val_loss: 0.4501
    Epoch 83/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7946 - loss: 0.4188 - val_accuracy: 0.7407 - val_loss: 0.4500
    Epoch 84/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8195 - loss: 0.3983 - val_accuracy: 0.7354 - val_loss: 0.4502
    Epoch 85/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7944 - loss: 0.4191 - val_accuracy: 0.7407 - val_loss: 0.4495
    Epoch 86/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 8ms/step - accuracy: 0.8049 - loss: 0.4199 - val_accuracy: 0.7460 - val_loss: 0.4494
    Epoch 87/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7934 - loss: 0.4107 - val_accuracy: 0.7407 - val_loss: 0.4500
    Epoch 88/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8140 - loss: 0.3881 - val_accuracy: 0.7407 - val_loss: 0.4494
    Epoch 89/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8201 - loss: 0.3780 - val_accuracy: 0.7460 - val_loss: 0.4491
    Epoch 90/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8228 - loss: 0.3836 - val_accuracy: 0.7460 - val_loss: 0.4482
    Epoch 91/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8314 - loss: 0.3716 - val_accuracy: 0.7407 - val_loss: 0.4505
    Epoch 92/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8357 - loss: 0.3735 - val_accuracy: 0.7460 - val_loss: 0.4496
    Epoch 93/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8049 - loss: 0.4131 - val_accuracy: 0.7513 - val_loss: 0.4502
    Epoch 94/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 8ms/step - accuracy: 0.7860 - loss: 0.4454 - val_accuracy: 0.7460 - val_loss: 0.4500
    Epoch 95/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8161 - loss: 0.3831 - val_accuracy: 0.7460 - val_loss: 0.4493
    Epoch 96/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8245 - loss: 0.3851 - val_accuracy: 0.7460 - val_loss: 0.4494
    Epoch 97/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8321 - loss: 0.3715 - val_accuracy: 0.7460 - val_loss: 0.4503
    Epoch 98/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.8168 - loss: 0.3952 - val_accuracy: 0.7460 - val_loss: 0.4498
    Epoch 99/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7912 - loss: 0.4100 - val_accuracy: 0.7460 - val_loss: 0.4510
    Epoch 100/100
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step - accuracy: 0.7942 - loss: 0.4118 - val_accuracy: 0.7513 - val_loss: 0.4502
    

.. code:: ipython3

    model.summary()



.. raw:: html

    <pre style="white-space:pre;overflow-x:auto;line-height:normal;font-family:Menlo,'DejaVu Sans Mono',consolas,'Courier New',monospace"><span style="font-weight: bold">Model: "sequential"</span>
    </pre>
    



.. raw:: html

    <pre style="white-space:pre;overflow-x:auto;line-height:normal;font-family:Menlo,'DejaVu Sans Mono',consolas,'Courier New',monospace">┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┓
    ┃<span style="font-weight: bold"> Layer (type)                    </span>┃<span style="font-weight: bold"> Output Shape           </span>┃<span style="font-weight: bold">       Param # </span>┃
    ┡━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━┩
    │ dense (<span style="color: #0087ff; text-decoration-color: #0087ff">Dense</span>)                   │ (<span style="color: #00d7ff; text-decoration-color: #00d7ff">None</span>, <span style="color: #00af00; text-decoration-color: #00af00">10</span>)             │            <span style="color: #00af00; text-decoration-color: #00af00">80</span> │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ dense_1 (<span style="color: #0087ff; text-decoration-color: #0087ff">Dense</span>)                 │ (<span style="color: #00d7ff; text-decoration-color: #00d7ff">None</span>, <span style="color: #00af00; text-decoration-color: #00af00">10</span>)             │           <span style="color: #00af00; text-decoration-color: #00af00">110</span> │
    ├─────────────────────────────────┼────────────────────────┼───────────────┤
    │ dense_2 (<span style="color: #0087ff; text-decoration-color: #0087ff">Dense</span>)                 │ (<span style="color: #00d7ff; text-decoration-color: #00d7ff">None</span>, <span style="color: #00af00; text-decoration-color: #00af00">1</span>)              │            <span style="color: #00af00; text-decoration-color: #00af00">11</span> │
    └─────────────────────────────────┴────────────────────────┴───────────────┘
    </pre>
    



.. raw:: html

    <pre style="white-space:pre;overflow-x:auto;line-height:normal;font-family:Menlo,'DejaVu Sans Mono',consolas,'Courier New',monospace"><span style="font-weight: bold"> Total params: </span><span style="color: #00af00; text-decoration-color: #00af00">605</span> (2.37 KB)
    </pre>
    



.. raw:: html

    <pre style="white-space:pre;overflow-x:auto;line-height:normal;font-family:Menlo,'DejaVu Sans Mono',consolas,'Courier New',monospace"><span style="font-weight: bold"> Trainable params: </span><span style="color: #00af00; text-decoration-color: #00af00">201</span> (804.00 B)
    </pre>
    



.. raw:: html

    <pre style="white-space:pre;overflow-x:auto;line-height:normal;font-family:Menlo,'DejaVu Sans Mono',consolas,'Courier New',monospace"><span style="font-weight: bold"> Non-trainable params: </span><span style="color: #00af00; text-decoration-color: #00af00">0</span> (0.00 B)
    </pre>
    



.. raw:: html

    <pre style="white-space:pre;overflow-x:auto;line-height:normal;font-family:Menlo,'DejaVu Sans Mono',consolas,'Courier New',monospace"><span style="font-weight: bold"> Optimizer params: </span><span style="color: #00af00; text-decoration-color: #00af00">404</span> (1.58 KB)
    </pre>
    


.. code:: ipython3

    history.history.keys()




.. parsed-literal::

    dict_keys(['accuracy', 'loss', 'val_accuracy', 'val_loss'])



.. code:: ipython3

    # Graficar Loss train y Loss test:
    
    plt.plot(history.history['loss'])
    plt.plot(history.history['val_loss'])
    plt.title('Model loss')
    plt.ylabel('Loss')
    plt.xlabel('Epoch')
    plt.legend(['Train', 'Test'], loc='upper left')
    plt.show()



.. image:: output_9_0.png


.. code:: ipython3

    # Probabilidades:
    y_prob_train = model.predict(X_train)
    y_prob = model.predict(X_test)
    
    # Definición de las clases con umbral:
    y_pred_train  = np.where(y_prob_train > 0.5, 1, 0)
    y_pred = np.where(y_prob > 0.5, 1, 0)


.. parsed-literal::

    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    

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
    
    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))



.. image:: output_11_0.png



.. image:: output_11_1.png


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.74      0.92      0.82       201
               1       0.91      0.72      0.81       239
    
        accuracy                           0.81       440
       macro avg       0.82      0.82      0.81       440
    weighted avg       0.83      0.81      0.81       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.69      0.83      0.75        86
               1       0.83      0.69      0.75       103
    
        accuracy                           0.75       189
       macro avg       0.76      0.76      0.75       189
    weighted avg       0.76      0.75      0.75       189
    
    

Optimización de hiperparámetros:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    from sklearn.metrics import accuracy_score

.. code:: ipython3

    cantidad_modelos = 10
    
    for i in range(cantidad_modelos):
    
      units = np.random.choice([5, 8, 10, 12, 15, 18, 20, 22, 24], 1)[0]
      n_hidden = np.random.choice([1, 2], 1)[0]
      activation = np.random.choice(['relu', 'tanh', 'selu', 'elu'], 1)[0]
      learning_rate = np.random.choice([0.001, 0.01, 0.1], 1)[0]
      batch_size = np.random.choice([16, 32, 64], 1)[0]
      optimizer = np.random.choice(['Adam', 'RMSprop'], 1)[0]
    
      print(f'Modelo: {i+1}, Units: {units}, Hidden: {n_hidden}, Activation: {activation}, Learning Rate: {learning_rate}, Optimizer: {optimizer}, Batch Size: {batch_size}')
    
      epochs = 200
    
      # Definir el modelo
      best_model = Sequential()
      best_model.add(Input(shape=(X.shape[1],)))
    
      # Loop para las capas ocultas:
    
      for _ in range(n_hidden):
        best_model.add(Dense(units, activation=activation))
        best_model.add(Dropout(0.2))
    
      # Capa de salida:
      best_model.add(Dense(1))
    
      # Optimizador:
      if optimizer == 'Adam':
        optimizer = optimizers.Adam(learning_rate=learning_rate)
      else:
        optimizer = optimizers.RMSprop(learning_rate=learning_rate)
    
      # Compilar el modelo:
      best_model.compile(loss="binary_crossentropy", metrics=["accuracy"], optimizer=optimizer)
    
      # Entrenar el modelo:
      history = best_model.fit(X_train, y_train, epochs=epochs,
                          validation_data=(X_test, y_test),
                          batch_size=batch_size,
                          verbose=0)
    
      # Evaluar el modelo con accuracy:
      y_prob_train = best_model.predict(X_train)
      y_prob = best_model.predict(X_test)
    
      y_pred_train  = np.where(y_prob_train > 0.5, 1, 0)
      y_pred = np.where(y_prob > 0.5, 1, 0)
    
      accuracy_train = accuracy_score(y_train, y_pred_train.flatten())
      accuracy_test = accuracy_score(y_test, y_pred.flatten())
    
      recall_train = recall_score(y_train, y_pred_train.flatten())
      recall_test = recall_score(y_test, y_pred.flatten())
    
      precision_train = precision_score(y_train, y_pred_train.flatten())
      precision_test = precision_score(y_test, y_pred.flatten())
    
      print(f'Accuracy train: {accuracy_train}, Accuracy test: {accuracy_test}')
      print(f'Recall train: {recall_train}, Recall test: {recall_test}')
      print(f'Precision train: {precision_train}, Precision test: {precision_test}')
    
      # Graficar Loss train y Loss test:
    
      plt.plot(history.history['loss'])
      plt.plot(history.history['val_loss'])
      plt.title('Model loss')
      plt.ylabel('Loss')
      plt.xlabel('Epoch')
      plt.legend(['Train', 'Test'], loc='upper left')
      plt.show()
    
      # Guardar el modelo:
      best_model.save(f"best_model_{i+1}.keras")


.. parsed-literal::

    Modelo: 1, Units: 15, Hidden: 1, Activation: tanh, Learning Rate: 0.1, Optimizer: Adam, Batch Size: 32
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 4ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.75, Accuracy test: 0.708994708994709
    Recall train: 0.6401673640167364, Recall test: 0.6019417475728155
    Precision train: 0.864406779661017, Precision test: 0.8157894736842105
    


.. image:: output_14_1.png


.. parsed-literal::

    Modelo: 2, Units: 15, Hidden: 2, Activation: tanh, Learning Rate: 0.001, Optimizer: Adam, Batch Size: 16
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.7454545454545455, Accuracy test: 0.7142857142857143
    Recall train: 0.7907949790794979, Recall test: 0.7864077669902912
    Precision train: 0.7529880478087649, Precision test: 0.7168141592920354
    


.. image:: output_14_3.png


.. parsed-literal::

    Modelo: 3, Units: 12, Hidden: 2, Activation: selu, Learning Rate: 0.1, Optimizer: Adam, Batch Size: 32
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.7022727272727273, Accuracy test: 0.656084656084656
    Recall train: 0.6694560669456067, Recall test: 0.6504854368932039
    Precision train: 0.7547169811320755, Precision test: 0.6979166666666666
    


.. image:: output_14_5.png


.. parsed-literal::

    Modelo: 4, Units: 12, Hidden: 2, Activation: elu, Learning Rate: 0.001, Optimizer: Adam, Batch Size: 16
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.7568181818181818, Accuracy test: 0.7301587301587301
    Recall train: 0.7447698744769874, Recall test: 0.7572815533980582
    Precision train: 0.7946428571428571, Precision test: 0.75
    


.. image:: output_14_7.png


.. parsed-literal::

    Modelo: 5, Units: 8, Hidden: 2, Activation: elu, Learning Rate: 0.1, Optimizer: RMSprop, Batch Size: 16
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.6931818181818182, Accuracy test: 0.7301587301587301
    Recall train: 0.7656903765690377, Recall test: 0.8543689320388349
    Precision train: 0.6984732824427481, Precision test: 0.7096774193548387
    


.. image:: output_14_9.png


.. parsed-literal::

    Modelo: 6, Units: 20, Hidden: 2, Activation: selu, Learning Rate: 0.001, Optimizer: RMSprop, Batch Size: 32
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step 
    Accuracy train: 0.7477272727272727, Accuracy test: 0.7037037037037037
    Recall train: 0.7238493723849372, Recall test: 0.6893203883495146
    Precision train: 0.7935779816513762, Precision test: 0.7473684210526316
    


.. image:: output_14_11.png


.. parsed-literal::

    Modelo: 7, Units: 8, Hidden: 1, Activation: elu, Learning Rate: 0.1, Optimizer: RMSprop, Batch Size: 32
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step 
    Accuracy train: 0.775, Accuracy test: 0.7248677248677249
    Recall train: 0.6569037656903766, Recall test: 0.6407766990291263
    Precision train: 0.9022988505747126, Precision test: 0.8148148148148148
    


.. image:: output_14_13.png


.. parsed-literal::

    Modelo: 8, Units: 22, Hidden: 1, Activation: selu, Learning Rate: 0.001, Optimizer: RMSprop, Batch Size: 16
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 4ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.7522727272727273, Accuracy test: 0.6984126984126984
    Recall train: 0.7364016736401674, Recall test: 0.6796116504854369
    Precision train: 0.7927927927927928, Precision test: 0.7446808510638298
    


.. image:: output_14_15.png


.. parsed-literal::

    Modelo: 9, Units: 10, Hidden: 2, Activation: relu, Learning Rate: 0.01, Optimizer: Adam, Batch Size: 64
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 7ms/step 
    Accuracy train: 0.8386363636363636, Accuracy test: 0.7566137566137566
    Recall train: 0.7196652719665272, Recall test: 0.6699029126213593
    Precision train: 0.9772727272727273, Precision test: 0.8518518518518519
    


.. image:: output_14_17.png


.. parsed-literal::

    Modelo: 10, Units: 22, Hidden: 2, Activation: elu, Learning Rate: 0.01, Optimizer: RMSprop, Batch Size: 16
    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    Accuracy train: 0.8113636363636364, Accuracy test: 0.7619047619047619
    Recall train: 0.6610878661087866, Recall test: 0.6213592233009708
    Precision train: 0.9875, Precision test: 0.9142857142857143
    


.. image:: output_14_19.png


**Mejor modelo:**

.. code:: ipython3

    from keras.models import load_model

.. code:: ipython3

    model = load_model("best_model_2.keras")
    
    # Probabilidades:
    y_prob_train = model.predict(X_train)
    y_prob = model.predict(X_test)
    
    # Definición de las clases con umbral:
    y_pred_train  = np.where(y_prob_train > 0.5, 1, 0)
    y_pred = np.where(y_prob > 0.5, 1, 0)
    
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
    
    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))


.. parsed-literal::

    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 20ms/step
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 18ms/step
    


.. image:: output_17_1.png



.. image:: output_17_2.png


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.74      0.69      0.71       201
               1       0.75      0.79      0.77       239
    
        accuracy                           0.75       440
       macro avg       0.74      0.74      0.74       440
    weighted avg       0.74      0.75      0.74       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.71      0.63      0.67        86
               1       0.72      0.79      0.75       103
    
        accuracy                           0.71       189
       macro avg       0.71      0.71      0.71       189
    weighted avg       0.71      0.71      0.71       189
    
    

.. code:: ipython3

    # !pip install keras-tuner -q

.. code:: ipython3

    import keras_tuner
    from keras_tuner.tuners import RandomSearch
    from keras_tuner import HyperParameters
    import keras

.. code:: ipython3

    def create_model(hp):
    
        units = hp.Int("units", min_value=5, max_value=24, step=1)
        n_hidden = hp.Int("n_hidden", min_value=1, max_value=2, step=1)
        learning_rate = hp.Float('learning_rate', min_value=1e-4, max_value=1e-2, sampling='log')
        activation = hp.Choice("activation", ['relu', 'tanh', 'selu', 'elu'])
        batch_size = hp.Choice("batch_size", [16, 32, 64])
        optimizer = hp.Choice('optimizer', values=["adam", "rmsprop"])
    
        # Definir el modelo
        best_model = Sequential()
        best_model.add(Input(shape=(X.shape[1],)))
    
        # Loop para las capas ocultas:
        for _ in range(n_hidden):
          best_model.add(Dense(units, activation=activation))
          best_model.add(Dropout(0.2))
    
        # Capa de salida:
        best_model.add(Dense(1))
    
        # Optimizador:
        if optimizer == 'Adam':
          best_model.compile(loss="binary_crossentropy", metrics=["accuracy"], optimizer=keras.optimizers.Adam(learning_rate=learning_rate))
        else:
          best_model.compile(loss="binary_crossentropy", metrics=["accuracy"], optimizer=keras.optimizers.RMSprop(learning_rate=learning_rate))
    
        return best_model

.. code:: ipython3

    # Configurar la búsqueda de hiperparámetros
    tuner = RandomSearch(
        create_model,
        objective='val_accuracy',
        max_trials=10,
        executions_per_trial=3,
        directory='my_dir',
        project_name='Optimización_empresas'
    )


.. parsed-literal::

    Reloading Tuner from my_dir/Optimización_empresas/tuner0.json
    

.. code:: ipython3

    tuner.search(X_train, y_train,
                 validation_data = (X_test, y_test),
                 epochs = 100,
                 batch_size=HyperParameters().Int('batch_size', min_value=16, max_value=128, step=16),
                 verbose = 0)

.. code:: ipython3

    # Hiperparámetros óptimos:
    best_hps = tuner.get_best_hyperparameters()[0]
    
    print(best_hps.get("units"))
    print(best_hps.get("n_hidden"))
    print(best_hps.get("activation"))
    print(best_hps.get("learning_rate"))
    print(best_hps.get("optimizers"))
    print(best_hps.get("batch_size"))


.. parsed-literal::

    23
    2
    tanh
    0.005666324070487912
    Adam
    64
    

.. code:: ipython3

    model = create_model(best_hps)
    
    history = model.fit(X_train, y_train,
                        validation_data = (X_test, y_test),
                        epochs = 200,
                        verbose = 0)
    
    # Graficar Loss train y Loss test:
    
    plt.plot(history.history['loss'])
    plt.plot(history.history['val_loss'])
    plt.title('Model loss')
    plt.ylabel('Loss')
    plt.xlabel('Epoch')
    plt.legend(['Train', 'Test'], loc='upper left')
    plt.show()
    
    # Probabilidades:
    y_prob_train = model.predict(X_train)
    y_prob = model.predict(X_test)
    
    # Definición de las clases con umbral:
    y_pred_train  = np.where(y_prob_train > 0.5, 1, 0)
    y_pred = np.where(y_prob > 0.5, 1, 0)
    
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
    
    print("\n=== Reporte de Clasificación - train ===")
    print(classification_report(y_train, y_pred_train))
    
    print("\n=== Reporte de Clasificación - test ===")
    print(classification_report(y_test, y_pred))



.. image:: output_24_0.png


.. parsed-literal::

    [1m14/14[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 5ms/step 
    [1m6/6[0m [32m━━━━━━━━━━━━━━━━━━━━[0m[37m[0m [1m0s[0m 6ms/step 
    


.. image:: output_24_2.png



.. image:: output_24_3.png


.. parsed-literal::

    
    === Reporte de Clasificación - train ===
                  precision    recall  f1-score   support
    
               0       0.76      0.86      0.81       201
               1       0.87      0.77      0.82       239
    
        accuracy                           0.81       440
       macro avg       0.81      0.82      0.81       440
    weighted avg       0.82      0.81      0.81       440
    
    
    === Reporte de Clasificación - test ===
                  precision    recall  f1-score   support
    
               0       0.72      0.78      0.75        86
               1       0.80      0.75      0.77       103
    
        accuracy                           0.76       189
       macro avg       0.76      0.76      0.76       189
    weighted avg       0.76      0.76      0.76       189
    
    
