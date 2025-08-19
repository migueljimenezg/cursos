SVM para Regresión
------------------

Support Vector Machines (SVM) es un poderoso algoritmo de aprendizaje
supervisado utilizado tanto para clasificación como para regresión.
Cuando se aplica a problemas de regresión, se denomina **Support Vector
Regression (SVR).**

**Conceptos básicos de SVR:**

-  **Margen:** En lugar de intentar minimizar el error absoluto, SVR
   busca encontrar una función que prediga dentro de un margen
   **(épsilon)** definido alrededor de la función real.

-  **Función de pérdida insensible a épsilon:** La pérdida no se
   considera si la predicción cae dentro del margen épsilon.

-  **Vectores de soporte:** Como en SVM para clasificación, solo un
   subconjunto de puntos de datos, llamados vectores de soporte, influye
   en la posición de la función de regresión.

-  **Kernels:** Los kernels permiten que SVR modele relaciones no
   lineales transformando los datos en un espacio de mayor dimensión
   donde se puede aplicar una regresión lineal.

Para usar SVM en regresión el objetivo se invierte que en clasificación:
en lugar de intentar encajar la calle (margen) más grande posible entre
dos clases mientras se limitas las infracciones al margen, SVM
Regression intenta encajar tantas observaciones como sea posible en la
calle mientras limita el margen.

El ancho de la calle está controlado por el hiperparámetro **épsilon**.
Entre mayor sea **épsilon**, mayor es el margen. Agregar más
observaciones dentro del margen no afecta las predicciones del modelo,
por tanto, se dice que el modelo es insensible a **épsilon**.

El hiperparámetro epsilon no se encuentra en clasificación. Por defecto
``epsilon=0.1``.

Por defecto ``C=1.0``, con valores de ``C`` grandes hay poca
regularización y con valores pequeños de ``C`` hay más fuerza de
regularización.

``gamma`` puede cambiar la forma de la campana. Un valor bajo ajustará
libremente el conjunto de datos, mientras que un valor más alto ajustará
exactamente al conjunto de datos, lo que provocaría un ajuste excesivo
(sobreajuste). ``gamma`` es un hiperparámetro que varía de 0 a 1.
Valores altos se ejecutará perfectamente al conjunto de datos y el
modelo se sobreajustará.Un valor de ``gamma`` pequeño hace que la curva
en forma de campana sea más estrecha, el límite de decisión termina
siendo más suave. Si el modelo se sobreajusta, este parámetro se debe
reducir; si es insuficiente, debe aumentarlo (similar al hiperparámetro
``C``).

**Aplicación de SVR en series de tiempo:**

-  **Series de tiempo:** SVR puede ser utilizado para predecir valores
   futuros de una serie de tiempo basándose en valores pasados y otras
   variables relevantes.

-  **Ventana deslizante:** Una técnica común para crear características
   en series de tiempo es utilizar ventanas deslizantes (lags) como
   entradas para el modelo.
