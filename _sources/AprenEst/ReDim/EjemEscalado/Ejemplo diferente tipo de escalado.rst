Ejemplo diferente tipo de escalado
----------------------------------

Vamos a construir un conjunto de datos artificial con tres variables de
distinta naturaleza:

-  ``X1``: variable continua con valores grandes (alta varianza).

-  ``X2``: variable continua con valores moderados (varianza media).

-  ``X3``: variable binaria (0 o 1), que representará una característica
   categórica codificada.

El objetivo es ver cómo estas diferencias de escala afectan el análisis
si no se escalan adecuadamente.

.. code:: ipython3

    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    from mpl_toolkits.mplot3d import Axes3D
    
    # Crear los datos
    np.random.seed(42)
    n = 150
    X1 = np.random.normal(5000, 1000, n)
    X2 = np.random.normal(50, 10, n)
    X3 = np.random.binomial(1, 0.3, n)
    
    df_mixed = pd.DataFrame({'X1': X1, 'X2': X2, 'X3': X3})
    
    # Visualizar distribuciones individuales
    fig, axs = plt.subplots(1, 3, figsize=(15, 4))
    axs[0].hist(df_mixed['X1'], bins=20, color='skyblue')
    axs[0].set_title('Distribución de X1 (Alta varianza)')
    
    axs[1].hist(df_mixed['X2'], bins=20, color='orange')
    axs[1].set_title('Distribución de X2 (Varianza media)')
    
    axs[2].hist(df_mixed['X3'], bins=2, color='green', rwidth=0.5)
    axs[2].set_title('Distribución de X3 (Binaria)')
    
    plt.tight_layout()
    plt.show()
    
    # Gráfico de dispersión 3D
    fig = plt.figure(figsize=(8, 6))
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(df_mixed['X1'], df_mixed['X2'], df_mixed['X3'],
               c=df_mixed['X3'], cmap='coolwarm', alpha=0.6)
    ax.set_xlabel('X1')
    ax.set_ylabel('X2')
    ax.set_zlabel('X3')
    ax.set_title('Gráfico de dispersión 3D - Datos originales')
    plt.tight_layout()
    plt.show()



.. image:: output_2_0.png



.. image:: output_2_1.png


Escalado de los datos:
~~~~~~~~~~~~~~~~~~~~~~

A continuación, escalaremos los datos utilizando dos enfoques
diferentes:

-  **Estandarización (z-score)**: centra los datos en media 0 y varianza
   1.

-  **Normalización Min-Max**: transforma los datos para que estén en el
   rango :math:`[0, 1]`.

Vamos a visualizar los efectos de cada método.

.. code:: ipython3

    from sklearn.preprocessing import StandardScaler, MinMaxScaler
    
    # Estandarización
    scaler_std = StandardScaler()
    data_std = scaler_std.fit_transform(df_mixed)
    
    # Normalización Min-Max
    scaler_mm = MinMaxScaler()
    data_mm = scaler_mm.fit_transform(df_mixed)
    
    # Dispersión 3D de los datos escalados
    fig = plt.figure(figsize=(8, 6))
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(data_std[:, 0], data_std[:, 1], data_std[:, 2], alpha=0.6, c=data_std[:, 2], cmap='coolwarm')
    ax.set_title('Datos estandarizados (z-score)')
    ax.set_xlabel('X1')
    ax.set_ylabel('X2')
    ax.set_zlabel('X3')
    plt.tight_layout()
    plt.show()
    
    fig = plt.figure(figsize=(8, 6))
    ax = fig.add_subplot(111, projection='3d')
    ax.scatter(data_mm[:, 0], data_mm[:, 1], data_mm[:, 2], alpha=0.6, c=data_mm[:, 2], cmap='coolwarm')
    ax.set_title('Datos normalizados (Min-Max)')
    ax.set_xlabel('X1')
    ax.set_ylabel('X2')
    ax.set_zlabel('X3')
    plt.tight_layout()
    plt.show()



.. image:: output_5_0.png



.. image:: output_5_1.png


Aplicar PCA:
~~~~~~~~~~~~

.. code:: ipython3

    from sklearn.decomposition import PCA
    
    # PCA con estandarización
    pca_std = PCA(n_components=2)
    pca_std_result = pca_std.fit_transform(data_std)
    
    # PCA con Min-Max
    pca_mm = PCA(n_components=2)
    pca_mm_result = pca_mm.fit_transform(data_mm)
    
    # Graficar resultados
    fig, axs = plt.subplots(1, 2, figsize=(12, 5))
    
    axs[0].scatter(pca_std_result[:, 0], pca_std_result[:, 1], alpha=0.6, color='blue')
    axs[0].set_title('PCA con estandarización (z-score)')
    axs[0].set_xlabel('PC1')
    axs[0].set_ylabel('PC2')
    axs[0].grid(True)
    
    axs[1].scatter(pca_mm_result[:, 0], pca_mm_result[:, 1], alpha=0.6, color='green')
    axs[1].set_title('PCA con normalización Min-Max')
    axs[1].set_xlabel('PC1')
    axs[1].set_ylabel('PC2')
    axs[1].grid(True)
    
    plt.tight_layout()
    plt.show()



.. image:: output_7_0.png

