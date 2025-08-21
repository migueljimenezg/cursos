Regresión Logística
-------------------

La **regresión logística** es un clasificador binario que nos permite
predecir la probabilidad de que algo ocurra o no ocurra.

La variable que queremos predecir (dependiente) solo puede tomar dos
valores:

-  0 = “No” / “Fracaso” / “Falso”.

-  1 = “Sí” / “Éxito” / “Verdadero”.

Por ejemplo:

-  ¿Un estudiante aprueba o no aprueba un examen?

-  ¿Un cliente compra o no compra un producto?

-  ¿Un correo es spam o no lo es?

En lugar de predecir directamente 0 o 1, el modelo estima la
**probabilidad** de que ocurra el evento.

--------------

.. figure:: Data.png
   :alt: Data

   Data

.. figure:: Data_3D.png
   :alt: Data_3D

   Data_3D

Variable respuesta
~~~~~~~~~~~~~~~~~~

La variable respuesta :math:`y` sigue una distribución de Bernoulli:

-  :math:`y = 1` con probabilidad :math:`p`.

-  :math:`y = 0` con probabilidad :math:`1-p`.

El valor esperado de :math:`y` es :math:`p`, es decir, la probabilidad
de que ocurra el evento.

--------------

La función logística o sigmoide
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para transformar los valores a probabilidades, se usa una función en
forma de “S”, llamada **función logística**:

.. math::  \sigma(z)= \frac{1}{1+e^{-z}} 

donde :math:`z` es una combinación lineal de las variables de entrada.

Esta función siempre entrega un valor entre 0 y 1, lo que la hace
perfecta para interpretar resultados como probabilidades.

**Ejemplo cotidiano:**

Imagina que quieres predecir si lloverá mañana. No puedes decir “sí o
no” con absoluta certeza, pero sí puedes dar una probabilidad: “hay un
70% de probabilidad de lluvia”. Ese es el papel de la función sigmoide.

--------------

.. figure:: Data_trans.png
   :alt: Data_trans

   Data_trans

.. figure:: S.JPG
   :alt: S

   S

.. figure:: RL.png
   :alt: RL

   RL

Umbral de decisión (Threshold)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Una vez que tenemos la probabilidad, debemos decidir a qué clase
pertenece cada observación.

Por defecto, se usa un umbral de 0,5:

-  Si :math:`p \geq 0,5`, clasificamos como 1 (éxito).

-  Si :math:`p < 0,5`, clasificamos como 0 (fracaso).

**Ejemplo:**

Si la probabilidad de que un cliente compre es 0,7 → se predice
“Compra”.

Si la probabilidad es 0,3 → se predice “No compra”.

Este umbral puede ajustarse según el problema. Por ejemplo, en medicina,
un umbral más bajo puede ser mejor para **detectar enfermedades graves**
y reducir falsos negativos.

--------------

.. figure:: Regression.JPG
   :alt: Regression

   Regression

Interpretación de los coeficientes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

En regresión logística no interpretamos los coeficientes directamente,
sino los **odds ratio**.

La relación es:

.. math::  log \left(\frac{p}{1-p}\right) = \beta_0 + \beta_1 X_1 + ... + \beta_n X_n 

Aplicando exponencial:

.. math::  \frac{p}{1-p} = e^{\beta_0 + \beta_1 X_1 + ... + \beta_n X_n} 

--------------

**Ejemplo de interpretación:**

Supongamos que :math:`\beta_1 = 0,1`.

-  Esto significa que un aumento unitario en :math:`X_1` multiplica las
   probabilidades de éxito por :math:`e^{0,1} \approx 1,105`, es decir,
   un incremento del 10,5%.

-  Si :math:`\beta_1 = -0,1`, entonces :math:`e^{-0,1} \approx 0,905`,
   lo que reduce la probabilidad en un 9,5%.

**Ejemplo cotidiano:**

| Si :math:`X_1` representa las horas de estudio de un alumno:
| \* Cada hora adicional de estudio aumenta en 10% la probabilidad de
  aprobar.

-  Si en cambio el coeficiente fuera negativo, cada hora extra podría
   **reducir** la probabilidad de aprobar (por ejemplo, si muchas horas
   generan fatiga).

--------------

Desventajas de la regresión logística
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**1. Relación lineal entre variables independientes y el logit**

| La regresión logística asume que existe una relación lineal entre las
  variables independientes y el logit (la transformación log-odds de la
  variable dependiente).
| Si la relación real no es lineal, el modelo puede no ajustarse bien a
  los datos.

--------------

**2. Limitada a problemas binarios**

| El modelo básico solo funciona para clasificación binaria (dos
  clases).
| Aunque existen extensiones como la regresión logística multinomial,
  estas pueden ser más complejas y no siempre son la mejor opción frente
  a otros algoritmos.

--------------

**3. Sensibilidad a outliers**

| La regresión logística es sensible a valores atípicos.
| Unos pocos datos extremos pueden cambiar significativamente los
  coeficientes y afectar el rendimiento del modelo.

--------------

**4. Suposición de independencia entre variables**

| Asume que las variables independientes no están fuertemente
  correlacionadas entre sí (no hay multicolinealidad).
| Si esta condición no se cumple, los coeficientes pueden volverse
  inestables.

La regresión logística no maneja bien la multicolinealidad. En estos
casos, conviene usar **reducción de dimensionalidad (PCA)** o algoritmos
más robustos.

--------------

**5. No captura relaciones complejas**

En problemas donde la frontera entre clases es curva o muy irregular,
algoritmos como **SVM con kernels**, **árboles de decisión**, **random
forest** o **redes neuronales** suelen dar mejores resultados.

--------------

**6. Problemas con datos desbalanceados**

| Cuando una clase es mucho más frecuente que la otra, el modelo tiende
  a favorecer la clase mayoritaria.
| Esto puede hacer que ignore la clase minoritaria, incluso si es la más
  importante en la práctica.

--------------

**7. Escalabilidad limitada**

En conjuntos de datos muy grandes, el entrenamiento puede volverse lento
y costoso computacionalmente, sobre todo si hay muchas variables y se
requiere ajuste fino.

--------------

**8. Interpretación en modelos complejos**

Aunque los coeficientes son interpretables en teoría, cuando el modelo
tiene muchas variables o interacciones, la interpretación práctica se
vuelve difícil y poco intuitiva.

.. figure:: Nonlinear.png
   :alt: Nonlinear

   Nonlinear

.. figure:: No_S.JPG
   :alt: No_S

   No_S

Ajuste en scikit-learn
~~~~~~~~~~~~~~~~~~~~~~

``LogisticRegression()``

+-------------+-------------+-------------+-------------+-------------+
| **Parámetro | **¿Para qué | **Cómo      | **Cómo      | **          |
| (valor por  | sirve?**    | ajustarlo   | ajustarlo   | Notas/compa |
| defecto)**  |             | si hay      | si hay      | tibilidad** |
|             |             | sobreajuste | subajuste   |             |
|             |             | (ove        | (unde       |             |
|             |             | rfitting)** | rfitting)** |             |
+=============+=============+=============+=============+=============+
| **C = 1.0** | Controla la | **Disminuye | **Aumenta   | Es el       |
|             | **fuerza de | ``C``**     | ``C``** (1  | parámetro   |
|             | regul       | (ej. 1 →    | → 10 → 100) | más         |
|             | arización** | 0.1 → 0.01) | para menos  | importante  |
|             | (es 1/λ).   | para más    | regu        | de tuning.  |
|             |             | regu        | larización. | Escalar     |
|             |             | larización. |             | datos ayuda |
|             |             |             |             | a           |
|             |             |             |             | co          |
|             |             |             |             | nvergencia. |
+-------------+-------------+-------------+-------------+-------------+
| **penalty = | Tipo de     | Mantén      | Considera   | ``'l1'`` y  |
| ‘l2’**      | regu        | ``'l2'`` o  | ``'none'``  | ``'el       |
|             | larización. | prueba      | si tienes   | asticnet'`` |
|             |             | ``'l1'/'el  | muchos      | requieren   |
|             |             | asticnet'`` | datos y     | ``solv      |
|             |             |             | pocas       | er='saga'`` |
|             |             |             | features.   | (o          |
|             |             |             |             | ``'l        |
|             |             |             |             | iblinear'`` |
|             |             |             |             | para L1     |
|             |             |             |             | binaria).   |
+-------------+-------------+-------------+-------------+-------------+
| **solver =  | Algoritmo   | Para        | Para        | ``'saga'``: |
| ‘lbfgs’**   | de          | ``l1``/``e  | multiclase  | grand       |
|             | op          | lasticnet`` | estable usa | es/escasos; |
|             | timización. | usa         | ``'lbfgs'`` | ``'li       |
|             |             | ``'saga'``  | o           | blinear'``: |
|             |             | (o          | ``'ne       | binario,    |
|             |             | ``'l        | wton-cg'``. | pequeño;    |
|             |             | iblinear'`` |             | `           |
|             |             | si es       |             | `'lbfgs'``: |
|             |             | binario).   |             | general/    |
|             |             |             |             | multiclase. |
+-------------+-------------+-------------+-------------+-------------+
| **c         | Pondera     | Usa         | Aumenta     | Complementa |
| lass_weight | clases      | ``'         | peso de la  | con ajuste  |
| = None**    | (manejo de  | balanced'`` | minoritaria | del         |
|             | d           | o pesos     | si la       | **umbral**  |
|             | esbalance). | ``{0        | ignora.     | tras        |
|             |             | :w0,1:w1}`` |             | entrenar.   |
|             |             | si favorece |             |             |
|             |             | a la        |             |             |
|             |             | m           |             |             |
|             |             | ayoritaria. |             |             |
+-------------+-------------+-------------+-------------+-------------+
| **max_iter  | Número      | Sube a      | —           | Escalar     |
| = 100**     | máximo de   | 300–1000 si |             | datos       |
|             | i           | no          |             | ayuda.      |
|             | teraciones. | converge.   |             | Error “did  |
|             |             |             |             | not         |
|             |             |             |             | converge” ⇒ |
|             |             |             |             | subir       |
|             |             |             |             | ``          |
|             |             |             |             | max_iter``. |
+-------------+-------------+-------------+-------------+-------------+
| **tol =     | Tolerancia  | **Bájalo**  | **Súbelo**  | Impacta     |
| 1e-4**      | de parada.  | (1e-5,      | (1e-3) si   | tiempo de   |
|             |             | 1e-6) para  | ya es       | en          |
|             |             | ajuste más  | suficiente  | trenamiento |
|             |             | fino (más   | y quieres   | y           |
|             |             | lento).     | rapidez.    | co          |
|             |             |             |             | nvergencia. |
+-------------+-------------+-------------+-------------+-------------+
| **l1_ratio  | Mezcla      | **Súbelo**  | **Bájalo**  | Requiere    |
| = None**    | L1/L2 (solo | hacia 1     | hacia 0     | ``          |
|             | con         | para más    | (más L2) si | penalty='el |
|             | ``ela       | sparsidad.  | el modelo   | asticnet'`` |
|             | sticnet``). |             | es muy      | y           |
|             |             |             | simple.     | ``solve     |
|             |             |             |             | r='saga'``. |
+-------------+-------------+-------------+-------------+-------------+
| **fi        | Añade       | Mantén      | Puede       | Usualmente  |
| t_intercept | intercepto  | **True**;   | **False**   | se deja en  |
| = True**    | (bias).     | ce          | si datos ya | **True**.   |
|             |             | ntra/escala | están       |             |
|             |             | features.   | centrados.  |             |
+-------------+-------------+-------------+-------------+-------------+
| **r         | Reprod      | —           | —           | Fija un     |
| andom_state | ucibilidad. |             |             | número (ej. |
| = None**    |             |             |             | 35) para    |
|             |             |             |             | resultados  |
|             |             |             |             | repetibles, |
|             |             |             |             | sobre todo  |
|             |             |             |             | con         |
|             |             |             |             | ``saga``.   |
+-------------+-------------+-------------+-------------+-------------+
| **n_jobs =  | Núcleos de  | Usa **-1**  | —           | Solo afecta |
| None**      | CPU         | para        |             | a           |
|             | (``         | p           |             | ``          |
|             | liblinear`` | aralelizar. |             | liblinear`` |
|             | OVR).       |             |             | multiclase. |
+-------------+-------------+-------------+-------------+-------------+
