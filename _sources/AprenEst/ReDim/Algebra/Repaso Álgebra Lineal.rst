Repaso Álgebra Lineal
---------------------

Determinantes:
~~~~~~~~~~~~~~

**Matrices** :math:`2x2`:

El área del plano se llama **Determinante**.

.. math::  Plano = \begin{bmatrix} 4 & 0 \\ 0 & 4 \end{bmatrix}, Determinante = 16 

El área es igual a :math:`4\times4=16`. Para matrices de orden 2
:math:`(2x2)` el Determinante se calcula multiplicando los valores de la
diagonal principal y restando la multiplicación de la diagonal
secundaria.

.. figure:: Plano.png
   :alt: Plano

   Plano

.. figure:: PlanoA.png
   :alt: PlanoA

   PlanoA

Siendo :math:`A = \begin{bmatrix} a & b \\ c & d \end{bmatrix}`

.. math::  det(A)  = det\begin{bmatrix} a & b  \\ c & d \end{bmatrix} = a\times d - b\times c 

.. math::  det(A)  = det\begin{bmatrix} 3 & 2  \\ 1 & 4 \end{bmatrix} = 3\times 4 - 2\times 1 = 10 

En ocasiones vemos que el Determinante se expresa en valor absoluto así
:math:`det(A) = |A|`, pero también se puede expresar con el signo
negativo. Esto ocurre si cambiamos el orden de los vectores.

.. figure:: Determinante2x2.png
   :alt: Determinante2x2

   Determinante2x2

.. math::  B = \begin{bmatrix} 2 & 2 \\ 1 & 3 \end{bmatrix}, Determinante = 4 

.. figure:: PlanoB.png
   :alt: PlanoB

   PlanoB

.. math::  C = \begin{bmatrix} 1,2 & 2 \\ 1 & 1,2 \end{bmatrix}, Determinante = 0,64 

.. figure:: PlanoC.png
   :alt: PlanoC

   PlanoC

.. math::  A = \begin{bmatrix} 3 & 2 \\ 1 & 4 \end{bmatrix}, Determinante = 10 

.. math::  B = \begin{bmatrix} 2 & 2 \\ 1 & 3 \end{bmatrix}, Determinante = 4 

.. math::  C = \begin{bmatrix} 1,2 & 2 \\ 1 & 1,2 \end{bmatrix}, Determinante = 0,64 

Note que en los ejemplos de las matrices :math:`A`, :math:`B` y
:math:`C` los valores de la diagonal principal disminuyen y se obtiene
un Determinante menor. Es fácil intuir que un Determinante más pequeño,
por ejemplo, igual a cero, el resultado es un solo vector. Este vector,
más adelante se llamará **Autovector.**

**Matrices** :math:`3x3`:

Para matrices :math:`3\times3` el Determinante (volumen, no área) es:

Siendo
:math:`A = \begin{bmatrix} a & b & c \\ d & e & f \\ g & h & i\end{bmatrix}`

.. math::  det(A)  = det\begin{bmatrix} a & b & c \\ d & e & f \\ g & h & i\end{bmatrix}= a\begin{bmatrix} e & f \\ h & i\end{bmatrix}-b\begin{bmatrix} d & f \\ g & i\end{bmatrix}-c\begin{bmatrix}  d & e  \\ g & h \end{bmatrix} 

Transformaciones lineales:
~~~~~~~~~~~~~~~~~~~~~~~~~~

Una matriz podría verse como una transformación lineal porque
transforman linealmente los vectores unitarios (:math:`\hat{i}`,
:math:`\hat{j}`).

Los vectores unitarios conforman el siguiente plano:

.. math::  \begin{bmatrix} 1 & 0 \\ 0 & 1 \end{bmatrix} 

.. figure:: VectoresUnitarios.png
   :alt: VectoresUnitarios

   VectoresUnitarios

Siendo :math:`A =\begin{bmatrix} 3 & 2 \\ 1 & 4 \end{bmatrix}`, la
transformación lineal de los dos vectores unitarios es la siguiente:

.. figure:: TransformaciónLineal.png
   :alt: TransformaciónLineal

   TransformaciónLineal

Analicemos la transformación que realizó la matriz :math:`A` a tres
vectores del plano de vectores unitarios:

-  El vector :math:`\begin{bmatrix} 1 \\ 0 \end{bmatrix}` se transformó
   en el vector :math:`\begin{bmatrix} 3 \\ 1 \end{bmatrix}`. El vector
   nuevo tiene una dirección diferente que el inicial.

-  El vector :math:`\begin{bmatrix} 0 \\ 1 \end{bmatrix}` se transformó
   en el vector :math:`\begin{bmatrix} 2 \\ 4 \end{bmatrix}`. El vector
   nuevo tiene una dirección diferente que el inicial.

-  El vector :math:`\begin{bmatrix} 1 \\ 1 \end{bmatrix}` se transformó
   en el vector :math:`\begin{bmatrix} 5 \\ 5 \end{bmatrix}`. **El
   vector nuevo sí conservó la dirección, pero tiene una magnitud
   diferente (es un vector escalado).**

Al hacer la transformación lineal de :math:`A`, el vector transformado
:math:`\begin{bmatrix} 5 \\ 5 \end{bmatrix}` es el mismo vector
:math:`\begin{bmatrix} 1 \\ 1 \end{bmatrix}`, pero con una magnitud de
5, es decir:
:math:`\begin{bmatrix} 5 \\ 5 \end{bmatrix} = 5\begin{bmatrix} 1 \\ 1 \end{bmatrix}`.
Así que el vector :math:`\begin{bmatrix} 1 \\ 1 \end{bmatrix}` se llama
**Autovector** o **Eigenvector** de la matriz :math:`A` y el escalar 5
se llama **Autovalor** o **Eigenvalor** de la matriz :math:`A`.

.. figure:: TransformaciónLineal2.png
   :alt: TransformaciónLineal.

   TransformaciónLineal.

Autovalores y Autovectores:
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Con lo anterior podemos concluir que un **Autovector** :math:`(x)` es
aquel que es transformado por una matriz y conserva su dirección, pero
puede aumentar o disminuir de magnitud en :math:`\lambda` veces. Por
tanto, el escalar :math:`\lambda` es un **Autovalor**. Lo anterior
cumple la siguiente ecuación:

.. math::  Ax = \lambda x 

Donde,

:math:`A`: es una matriz del orden :math:`nxn`.

:math:`x`: es el Autovector o Eigenvector de :math:`A`.

:math:`\lambda`: es el Autovalor o Eigenvalor de :math:`A`. Es un
escalar.

Para el ejemplo:

.. math::  \begin{bmatrix} 3 & 2 \\ 1 & 4 \end{bmatrix} \begin{bmatrix} 1  \\ 1 \end{bmatrix} = 5 \begin{bmatrix} 1  \\ 1 \end{bmatrix}  

Para hallar :math:`x` y :math:`\lambda` matemáticamente se hace lo
siguiente:

.. math::  (A - \lambda I)x = 0 

:math:`I`: es la matriz identidad.

.. math::  (A - \lambda I) = \begin{bmatrix} a -\lambda & b \\ c & d-\lambda \end{bmatrix} 

:math:`det(A - \lambda I)=0` es llamada ecuación característica.

Anteriormente, gráficamente habíamos restado solo los valores de la
diagonal principal de la matriz
:math:`A = \begin{bmatrix} 3 & 2 \\ 1 & 4 \end{bmatrix}`, se había
concluido que el Determinante se volvía cero y el vector resultante era
:math:`\begin{bmatrix} 1 \\ 1 \end{bmatrix}`. Este vector es el
Autovector de la matriz :math:`A`.

Entonces, :math:`\lambda` es Autovalor de :math:`A` si y solo si:
:math:`det(A - \lambda I)) = 0`

Para una matriz del orden :math:`nxn` tendremos :math:`n` Autovectores y
:math:`n` Autovalores. En el ejemplo anterior se mencionó un Autovector
y un Autovalor, pero la solución completa es la siguiente:

.. math::  (A - \lambda I) = \begin{bmatrix} 3 -\lambda & 2 \\ 1 & 4-\lambda \end{bmatrix} 

.. math::  det(A - \lambda I)) = 0 

.. math::  (3-\lambda)(4-\lambda)-2 = 0 

.. math::  \lambda^2-7\lambda+10=0 

.. math::  \lambda_1 = 2, \lambda_2 = 5 

Para estos dos Autovalores, los dos Autovectores son:

Para :math:`\lambda_1 = 2`,
:math:`x_1=\begin{bmatrix} -2 \\ 1 \end{bmatrix}`

Para :math:`\lambda_2 = 5`,
:math:`x_2=\begin{bmatrix} 1 \\ 1 \end{bmatrix}`

Los dos Autovectores son ortogonales, tienen un ángulo de 90°.

.. figure:: Autovectores.png
   :alt: Autovectores

   Autovectores
