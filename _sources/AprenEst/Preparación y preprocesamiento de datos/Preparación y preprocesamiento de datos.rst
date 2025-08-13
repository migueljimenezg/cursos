Preparación y preprocesamiento de datos
---------------------------------------

En **Machine Learning**, los datos de entrada pueden ser de diferentes
tipos. Conocer el tipo de dato es fundamental para elegir el
preprocesamiento y el modelo adecuado.

Tipos principales
~~~~~~~~~~~~~~~~~

1. **Numéricos (cuantitativos)**

   Son valores que representan cantidades medibles.

   -  **Continuos:** pueden tomar cualquier valor en un rango. Ejemplo:
      altura, peso, temperatura.

   -  **Discretos:** toman valores enteros. Ejemplo: número de hijos,
      cantidad de ventas.

2. **Categóricos (cualitativos)**

   Representan categorías o grupos.

   -  **Nominales:** categorías sin orden inherente. Ejemplo: color,
      país.

   -  **Ordinales:** categorías con un orden lógico. Ejemplo: nivel de
      educación (bajo, medio, alto), estrato socio económico (1, 2, 3,
      4, 5, 6).

3. **Binarios**

   Tienen solo dos valores posibles. Ejemplo: sí/no, 0/1.

4. **Texto**

   Secuencias de caracteres. Ejemplo: comentarios, descripciones.

5. **Fecha y hora**

   Representan momentos específicos en el tiempo. Ejemplo:
   ``2025-08-13 14:35:00``.

**Ejemplo en tabla:**

+----+------+-------+-------+-------+-------+-------+-------+
| ID | Edad | G     | Ing   | Nivel | C     | Comen | Fecha |
|    |      | énero | resos | educ  | ompra | tario | reg   |
|    |      |       |       | ación | p     |       | istro |
|    |      |       |       |       | revia |       |       |
+====+======+=======+=======+=======+=======+=======+=======+
| 1  | 25   | M     | 3000  | Medio | Sí    | Buen  | 2025- |
|    |      |       |       |       |       | ser   | 08-01 |
|    |      |       |       |       |       | vicio | 09:15 |
+----+------+-------+-------+-------+-------+-------+-------+
| 2  | 40   | F     | 5500  | Alto  | No    | P     | 2025- |
|    |      |       |       |       |       | odría | 08-02 |
|    |      |       |       |       |       | me    | 14:40 |
|    |      |       |       |       |       | jorar |       |
+----+------+-------+-------+-------+-------+-------+-------+
| 3  | 31   | F     | 4200  | Bajo  | Sí    | Exce  | 2025- |
|    |      |       |       |       |       | lente | 08-05 |
|    |      |       |       |       |       | ate   | 17:10 |
|    |      |       |       |       |       | nción |       |
+----+------+-------+-------+-------+-------+-------+-------+

-  **Numéricos:** ``Edad``, ``Ingresos``

-  **Categóricos nominales:** ``Género``

-  **Categóricos ordinales:** ``Nivel educación``

-  **Binarios:** ``Compra previa``

-  **Texto:** ``Comentario``

-  **Fecha y hora:** ``Fecha registro``

.. figure:: DataTypes1.PNG
   :alt: DataTypes1

   DataTypes1

Codificación de variables categóricas:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Las **variables categóricas** representan información no numérica, como
el color, el país o el tipo de producto. La mayoría de los algoritmos de
Machine Learning trabajan únicamente con datos numéricos, por lo que es
necesario **codificarlas**.

**¿Por qué codificar?**

-  Los modelos no pueden interpretar directamente texto o etiquetas como
   “Rojo” o “Alto”.

-  La codificación traduce estas categorías a valores numéricos que los
   algoritmos puedan procesar.

-  La forma de codificación influye en el rendimiento y la
   interpretación del modelo.

**Tipos de codificación:**

1. **Codificación ordinal:**

   Se asigna un número entero a cada categoría respetando un orden
   lógico.

   Ejemplo: Nivel educativo — Bajo = 1, Medio = 2, Alto = 3.

   Útil para variables **ordinales** donde el orden importa.

   No es necesario crear variables booleanas, ya que el orden tiene
   significado.

2. **One-Hot Encoding (Variables Dummy):**

   Convierte cada categoría en una columna booleana (0/1). Útil para
   variables **nominales** (sin orden). • Crea una nueva columna binaria
   (0 o 1) para cada categoría posible.

   Ejemplo: Color — Rojo, Azul, Verde → columnas ``Rojo``, ``Azul``,
   ``Verde``.

   ========== =========== ==========
   color=rojo color=verde color=azul
   ========== =========== ==========
   1          0           0
   0          1           0
   0          0           1
   ========== =========== ==========

   No es correcto asignar números enteros arbitrarios (rojo=0, Azul=1,
   Verde=2) porque:

   -  Introduce un orden ficticio.

   -  Hace que el modelo suponga distancias entre categorías que no
      existen.

**Multicolinealidad en modelos lineales:**

En **modelos lineales** (como regresión lineal o logística), usar
One-Hot Encoding con todas las categorías puede generar
**multicolinealidad**: una dependencia perfecta entre variables.

-  Solución: eliminar una de las columnas creadas (llamado “drop
   first”).

-  Ejemplo: para ``Rojo``, ``Azul``, ``Verde``, se eliminan ``Rojo`` y
   se dejan ``Azul`` y ``Verde``.

En **otros modelos** (árboles de decisión, random forest, XGBoost, redes
neuronales) no es necesario eliminar columnas, ya que no se ven
afectados por la multicolinealidad de la misma forma.

Ejemplo con scikit-learn:
~~~~~~~~~~~~~~~~~~~~~~~~~

| En este ejemplo se codifican dos variables nominales: **Género** y
  **Nivel_educacion**.
| Primero se aplicará One-Hot Encoding **eliminando una columna**
  (``drop='first'``) para evitar la multicolinealidad en modelos
  lineales, y luego se mostrará el resultado **sin eliminar columnas**
  (útil para otros modelos como árboles de decisión o redes neuronales).

.. code:: ipython3

    import pandas as pd
    from sklearn.preprocessing import OneHotEncoder
    
    # Datos de ejemplo
    df = pd.DataFrame({
        'Género': ['M', 'F', 'F', 'M', 'M'],
        'Nivel_educacion': ['Bajo', 'Medio', 'Alto', 'Medio', 'Bajo'],
        'Compra': ['Sí', 'No', 'Sí', 'No', 'Sí']
    })
    
    print("Datos originales:")
    df


.. parsed-literal::

    Datos originales:
    



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
          <th>Género</th>
          <th>Nivel_educacion</th>
          <th>Compra</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>M</td>
          <td>Bajo</td>
          <td>Sí</td>
        </tr>
        <tr>
          <th>1</th>
          <td>F</td>
          <td>Medio</td>
          <td>No</td>
        </tr>
        <tr>
          <th>2</th>
          <td>F</td>
          <td>Alto</td>
          <td>Sí</td>
        </tr>
        <tr>
          <th>3</th>
          <td>M</td>
          <td>Medio</td>
          <td>No</td>
        </tr>
        <tr>
          <th>4</th>
          <td>M</td>
          <td>Bajo</td>
          <td>Sí</td>
        </tr>
      </tbody>
    </table>
    </div>



-  **OneHotEncoder**: transforma variables categóricas en columnas
   binarias (0/1).

-  **drop=‘first’**: elimina la primera categoría de cada variable para
   evitar multicolinealidad en modelos lineales.

-  **sparse=False**: devuelve un arreglo denso (``numpy.ndarray``) en
   lugar de una matriz dispersa, lo que facilita convertirlo en un
   DataFrame.

-  **``encoder_drop.fit_transform(X)``**

   -  Ajusta y transforma en un solo paso las columnas categóricas a
      **one‑hot**.

   -  **Entrada:** ``X`` es un DataFrame/array 2D con las columnas
      categóricas (ej. ``df[['Género', 'Nivel_educacion']]``).

   -  **Durante ``fit``:** aprende las categorías por columna (quedan en
      ``encoder_drop.categories_``) y aplica la regla de
      ``drop='first'`` si corresponde.

   -  **Durante ``transform``:** genera la matriz binaria (0/1).

   -  **Salida:** ``numpy.ndarray`` (porque ``sparse=False``) con forma
      ``(n_muestras, n_features_cod)``.

   -  **Cálculo de columnas:**

      -  Con ``drop='first'``:
         ``n_features_cod = Σ (n_categorías_col − 1)``

      -  Sin ``drop``: ``n_features_cod = Σ (n_categorías_col)``

-  **``encoder_drop.get_feature_names_out(input_features)``**

   -  Devuelve los **nombres de las columnas** generadas tras la
      codificación.

   -  **Parámetro:** ``input_features`` es la lista de nombres
      originales (ej. ``['Género', 'Nivel_educacion']``).

   -  **Formato de nombre:** ``"<col>_<categoría>"`` (ej. ``Género_M``,
      ``Nivel_educacion_Alto``).

   -  Con ``drop='first'``, la primera categoría de cada variable **no**
      aparece en los nombres.

   -  Útil para construir el DataFrame final:

      ``pd.DataFrame(encoded_drop, columns=encoder_drop.get_feature_names_out(['Género', 'Nivel_educacion']))``

.. code:: ipython3

    # ---- One-Hot Encoding eliminando una columna (para evitar multicolinealidad en modelos lineales) ----
    encoder_drop = OneHotEncoder(drop='first', sparse=False)
    encoded_drop = encoder_drop.fit_transform(df[['Género', 'Nivel_educacion']])
    cols_drop = encoder_drop.get_feature_names_out(['Género', 'Nivel_educacion'])
    df_encoded_drop = pd.DataFrame(encoded_drop, columns=cols_drop)
    df_encoded_drop




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
          <th>Género_M</th>
          <th>Nivel_educacion_Bajo</th>
          <th>Nivel_educacion_Medio</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>1.0</td>
          <td>1.0</td>
          <td>0.0</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.0</td>
          <td>0.0</td>
          <td>1.0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.0</td>
        </tr>
        <tr>
          <th>3</th>
          <td>1.0</td>
          <td>0.0</td>
          <td>1.0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>1.0</td>
          <td>1.0</td>
          <td>0.0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # ---- One-Hot Encoding sin eliminar columnas (para modelos no lineales) ----
    encoder_full = OneHotEncoder(sparse=False)
    encoded_full = encoder_full.fit_transform(df[['Género', 'Nivel_educacion']])
    cols_full = encoder_full.get_feature_names_out(['Género', 'Nivel_educacion'])
    df_encoded_full = pd.DataFrame(encoded_full, columns=cols_full)
    df_encoded_full




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
          <th>Género_F</th>
          <th>Género_M</th>
          <th>Nivel_educacion_Alto</th>
          <th>Nivel_educacion_Bajo</th>
          <th>Nivel_educacion_Medio</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
        </tr>
        <tr>
          <th>1</th>
          <td>1.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>1.0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>1.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>0.0</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>1.0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # ---- Codificación binaria para 'Compra' ----
    df['Compra_cod'] = df['Compra'].map({'Sí': 1, 'No': 0})
    df




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
          <th>Género</th>
          <th>Nivel_educacion</th>
          <th>Compra</th>
          <th>Compra_cod</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>M</td>
          <td>Bajo</td>
          <td>Sí</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>F</td>
          <td>Medio</td>
          <td>No</td>
          <td>0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>F</td>
          <td>Alto</td>
          <td>Sí</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>M</td>
          <td>Medio</td>
          <td>No</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>M</td>
          <td>Bajo</td>
          <td>Sí</td>
          <td>1</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # Resultados
    print("\n--- One-Hot Encoding eliminando una columna ---")
    pd.concat([df_encoded_drop, df["Compra_cod"]], axis=1)


.. parsed-literal::

    
    --- One-Hot Encoding eliminando una columna ---
    



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
          <th>Género_M</th>
          <th>Nivel_educacion_Bajo</th>
          <th>Nivel_educacion_Medio</th>
          <th>Compra_cod</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>1.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>1.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>1.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>1</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # Resultados
    print("\n--- One-Hot Encoding sin eliminar columnas ---")
    pd.concat([df_encoded_full, df["Compra_cod"]], axis=1)


.. parsed-literal::

    
    --- One-Hot Encoding sin eliminar columnas ---
    



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
          <th>Género_F</th>
          <th>Género_M</th>
          <th>Nivel_educacion_Alto</th>
          <th>Nivel_educacion_Bajo</th>
          <th>Nivel_educacion_Medio</th>
          <th>Compra_cod</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>1.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>1.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>1.0</td>
          <td>0.0</td>
          <td>1</td>
        </tr>
      </tbody>
    </table>
    </div>



Ejemplo de codificación de variables categóricas solo con pandas:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  **``pd.get_dummies()``**: crea columnas binarias (0/1) a partir de
   variables categóricas.

-  **``drop_first=True``**: elimina la primera categoría de cada
   variable para evitar multicolinealidad en modelos lineales.

-  **``drop_first=False``**: mantiene todas las categorías, útil para
   modelos no lineales.

-  **``.map({'Sí': 1, 'No': 0})``**: convierte una variable binaria en
   formato texto a valores 0 y 1.

.. code:: ipython3

    # Datos de ejemplo
    df = pd.DataFrame({
        'Género': ['M', 'F', 'F', 'M', 'M'],
        'Nivel_educacion': ['Bajo', 'Medio', 'Alto', 'Medio', 'Bajo'],
        'Compra': ['Sí', 'No', 'Sí', 'No', 'Sí']
    })
    
    print("Datos originales:")
    df


.. parsed-literal::

    Datos originales:
    



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
          <th>Género</th>
          <th>Nivel_educacion</th>
          <th>Compra</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>M</td>
          <td>Bajo</td>
          <td>Sí</td>
        </tr>
        <tr>
          <th>1</th>
          <td>F</td>
          <td>Medio</td>
          <td>No</td>
        </tr>
        <tr>
          <th>2</th>
          <td>F</td>
          <td>Alto</td>
          <td>Sí</td>
        </tr>
        <tr>
          <th>3</th>
          <td>M</td>
          <td>Medio</td>
          <td>No</td>
        </tr>
        <tr>
          <th>4</th>
          <td>M</td>
          <td>Bajo</td>
          <td>Sí</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # --- One-Hot Encoding eliminando una columna (para evitar multicolinealidad) ---
    df_onehot_drop = pd.get_dummies(df[['Género', 'Nivel_educacion']], drop_first=True)
    df_onehot_drop




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
          <th>Género_M</th>
          <th>Nivel_educacion_Bajo</th>
          <th>Nivel_educacion_Medio</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>1</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0</td>
          <td>0</td>
          <td>0</td>
        </tr>
        <tr>
          <th>3</th>
          <td>1</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>4</th>
          <td>1</td>
          <td>1</td>
          <td>0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # --- One-Hot Encoding sin eliminar columnas (para modelos no lineales) ---
    df_onehot_full = pd.get_dummies(df[['Género', 'Nivel_educacion']], drop_first=False)
    df_onehot_full




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
          <th>Género_F</th>
          <th>Género_M</th>
          <th>Nivel_educacion_Alto</th>
          <th>Nivel_educacion_Bajo</th>
          <th>Nivel_educacion_Medio</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>1</th>
          <td>1</td>
          <td>0</td>
          <td>0</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>2</th>
          <td>1</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>0</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # --- Codificación binaria para 'Compra' ---
    df['Compra_cod'] = df['Compra'].map({'Sí': 1, 'No': 0})
    df




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
          <th>Género</th>
          <th>Nivel_educacion</th>
          <th>Compra</th>
          <th>Compra_cod</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>M</td>
          <td>Bajo</td>
          <td>Sí</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>F</td>
          <td>Medio</td>
          <td>No</td>
          <td>0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>F</td>
          <td>Alto</td>
          <td>Sí</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>M</td>
          <td>Medio</td>
          <td>No</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>M</td>
          <td>Bajo</td>
          <td>Sí</td>
          <td>1</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # Resultados
    print("\n--- One-Hot Encoding eliminando una columna ---")
    pd.concat([df_onehot_drop, df['Compra_cod']], axis=1)


.. parsed-literal::

    
    --- One-Hot Encoding eliminando una columna ---
    



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
          <th>Género_M</th>
          <th>Nivel_educacion_Bajo</th>
          <th>Nivel_educacion_Medio</th>
          <th>Compra_cod</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>1</td>
          <td>1</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0</td>
          <td>0</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>1</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>1</td>
          <td>1</td>
          <td>0</td>
          <td>1</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # Resultados
    print("\n--- One-Hot Encoding sin eliminar columnas ---")
    pd.concat([df_onehot_full, df['Compra_cod']], axis=1)


.. parsed-literal::

    
    --- One-Hot Encoding sin eliminar columnas ---
    



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
          <th>Género_F</th>
          <th>Género_M</th>
          <th>Nivel_educacion_Alto</th>
          <th>Nivel_educacion_Bajo</th>
          <th>Nivel_educacion_Medio</th>
          <th>Compra_cod</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>1</td>
          <td>0</td>
          <td>0</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>1</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>1</td>
          <td>0</td>
          <td>1</td>
        </tr>
      </tbody>
    </table>
    </div>



Escalado de variables:
----------------------

El **escalado de variables** es el proceso de transformar los valores
numéricos para que estén en un rango o distribución específica.

Se utiliza porque muchos algoritmos de Machine Learning son sensibles a
la magnitud de las variables, y sin escalado, las variables con valores
más grandes pueden dominar el modelo.

Ejemplos de modelos sensibles al escalado: regresión logística, SVM,
KNN, redes neuronales, PCA.

Modelos poco sensibles al escalado: árboles de decisión, random forest,
XGBoost (basados en árboles).

**¿Por qué escalar?**

-  Evita que variables con rangos muy diferentes tengan mayor influencia
   en el modelo.

-  Acelera la convergencia de algoritmos de optimización como gradiente
   descendente.

-  Mejora la estabilidad numérica de los cálculos.

Alternativas de escalado:
~~~~~~~~~~~~~~~~~~~~~~~~~

**1. Min-Max Scaling (Normalización):**

Transforma los datos a un rango fijo, comúnmente [0, 1].

**Fórmula:**

.. math::


   X' = \frac{X - X_{min}}{X_{max} - X_{min}}

**Ventajas:**

-  Mantiene la forma de la distribución original.

-  Útil cuando se requiere un rango específico (ej. redes neuronales con
   activación sigmoide).

**Desventajas:**

-  Muy sensible a valores atípicos (outliers).

**2. Standard Scaling (Estandarización):**

Transforma los datos para que tengan media 0 y desviación estándar 1.

**Fórmula:**

.. math::


   X' = \frac{X - \mu}{\sigma}

donde :math:`\mu` es la media y :math:`\sigma` la desviación estándar.

**Ventajas:**

-  Menos sensible a cambios de escala que Min-Max.

-  Útil para algoritmos que asumen datos centrados en 0 (ej. PCA, SVM).

**Desventajas:**

-  Puede verse afectado por outliers, aunque menos que Min-Max.

**3. Robust Scaling:**

Escala los datos usando la mediana y el rango intercuartílico (IQR), lo
que lo hace resistente a outliers.

**Fórmula:**

.. math::


   X' = \frac{X - \text{mediana}(X)}{IQR}

| donde
| :math:`IQR = Q3 - Q1`.

**Ventajas:**

-  Robusto ante outliers.

**Desventajas:**

-  No garantiza un rango fijo como [0, 1].

**4. MaxAbs Scaling:**

Escala los datos dividiendo por el valor absoluto máximo.

**Fórmula:**

.. math::


   X' = \frac{X}{|X_{max}|}

**Ventajas:**

-  Mantiene la dispersión de los datos.

-  Útil cuando los datos ya están centrados en 0 y se quiere solo
   ajustar magnitudes.

**Desventajas:**

-  Sensible a outliers.

**Alternativa más común:**

La **estandarización** (``StandardScaler``) es la más usada en Machine
Learning, especialmente para algoritmos lineales y métodos basados en
distancia, porque centra los datos y les da varianza unitaria.

¿El escalado cambia las propiedades estadísticas de las variables?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Sí, al aplicar métodos como **MinMaxScaler** o **StandardScaler**, las
propiedades estadísticas de las variables cambian.

**MinMaxScaler:**

-  **Media**: cambia, ya que los valores se ajustan a un nuevo rango
   (por ejemplo, [0, 1]).

-  **Desviación estándar**: cambia, porque la dispersión ahora está
   limitada al rango elegido.

-  **Distribución**: la forma relativa de la distribución se mantiene
   (no altera la relación entre los valores), pero los valores absolutos
   cambian.

**StandardScaler:**

-  **Media**: pasa a ser 0.

-  **Desviación estándar**: pasa a ser 1.

-  **Distribución**: la forma de la distribución (asimetría, curtosis)
   se mantiene, pero se centra y se escala.

**Conclusión**

-  El escalado **sí modifica** medidas como media y desviación estándar.

-  No altera la **forma relativa** de la distribución (no cambia qué
   valor es mayor o menor que otro), pero sí **cambia su escala y
   centro**.

-  Esto es importante para interpretar coeficientes en modelos lineales,
   ya que estarán en la escala transformada.

¿El escalado cambia las correlaciones entre las variables?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En general, **el escalado no cambia las correlaciones** entre variables.

**Por qué no cambian:**

-  La **correlación de Pearson** mide la relación lineal estandarizada
   entre dos variables.

-  Si se aplica una **transformación lineal** (como en MinMaxScaler o
   StandardScaler), la correlación se mantiene, porque no se altera la
   proporcionalidad entre los valores.

**Cuándo podría cambiar:** Si se usan transformaciones **no lineales**
(logaritmo, raíz cuadrada, exponencial, etc.), la relación entre las
variables puede cambiar, y por tanto la correlación también.

Ejemplo en Python: MinMaxScaler y StandardScaler:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: ipython3

    import pandas as pd
    from sklearn.preprocessing import MinMaxScaler, StandardScaler
    
    # Datos de ejemplo
    df = pd.DataFrame({
        'Variable_continua': [10, 20, 30, 40, 50],
        'Variable_binaria_1': [0, 1, 0, 1, 1],
        'Variable_binaria_2': [1, 1, 1, 1, 0]
    })
    
    print("Datos originales:")
    df


.. parsed-literal::

    Datos originales:
    



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
          <th>Variable_continua</th>
          <th>Variable_binaria_1</th>
          <th>Variable_binaria_2</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>10</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>1</th>
          <td>20</td>
          <td>1</td>
          <td>1</td>
        </tr>
        <tr>
          <th>2</th>
          <td>30</td>
          <td>0</td>
          <td>1</td>
        </tr>
        <tr>
          <th>3</th>
          <td>40</td>
          <td>1</td>
          <td>1</td>
        </tr>
        <tr>
          <th>4</th>
          <td>50</td>
          <td>1</td>
          <td>0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # --- Min-Max Scaling ---
    scaler_minmax = MinMaxScaler()
    df_minmax = pd.DataFrame(scaler_minmax.fit_transform(df), columns=df.columns)
    df_minmax




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
          <th>Variable_continua</th>
          <th>Variable_binaria_1</th>
          <th>Variable_binaria_2</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>0.00</td>
          <td>0.0</td>
          <td>1.0</td>
        </tr>
        <tr>
          <th>1</th>
          <td>0.25</td>
          <td>1.0</td>
          <td>1.0</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.50</td>
          <td>0.0</td>
          <td>1.0</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0.75</td>
          <td>1.0</td>
          <td>1.0</td>
        </tr>
        <tr>
          <th>4</th>
          <td>1.00</td>
          <td>1.0</td>
          <td>0.0</td>
        </tr>
      </tbody>
    </table>
    </div>



.. code:: ipython3

    # --- Standard Scaling ---
    scaler_standard = StandardScaler()
    df_standard = pd.DataFrame(scaler_standard.fit_transform(df), columns=df.columns)
    df_standard




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
          <th>Variable_continua</th>
          <th>Variable_binaria_1</th>
          <th>Variable_binaria_2</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th>0</th>
          <td>-1.414214</td>
          <td>-1.224745</td>
          <td>0.5</td>
        </tr>
        <tr>
          <th>1</th>
          <td>-0.707107</td>
          <td>0.816497</td>
          <td>0.5</td>
        </tr>
        <tr>
          <th>2</th>
          <td>0.000000</td>
          <td>-1.224745</td>
          <td>0.5</td>
        </tr>
        <tr>
          <th>3</th>
          <td>0.707107</td>
          <td>0.816497</td>
          <td>0.5</td>
        </tr>
        <tr>
          <th>4</th>
          <td>1.414214</td>
          <td>0.816497</td>
          <td>-2.0</td>
        </tr>
      </tbody>
    </table>
    </div>


