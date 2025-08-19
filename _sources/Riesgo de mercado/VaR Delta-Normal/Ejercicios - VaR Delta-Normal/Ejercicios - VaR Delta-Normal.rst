Ejercicios: VaR Delta-Normal
----------------------------

Para el siguiente portafolio de inversión escriba el código en R para
responder los ejercicios.

Proporciones de inversión:
~~~~~~~~~~~~~~~~~~~~~~~~~~

**PFBCOLOM:** 30%

**GRUPOSURA:** 45%

**CELSIA:** 25%

Valor de mercado portafolio de inversión: Dos mil millones de pesos.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Utilizar el archivo: Tres acciones 2020.csv.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Ejercicios
~~~~~~~~~~

1. Valor de mercado de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

**PFBCOLOM:** $600.000.000.

**GRUPOSURA:** $900.000.000.

**CELSIA:** $500.000.000.

2. Rendimiento esperado de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

**PFBCOLOM:** -0,000414968788186442 diario

**GRUPOSURA:** -0,00107596325774145 diario

**CELSIA:** -7,97826580546044e-05 diario

3. Volatilidad de cada acción.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

**PFBCOLOM:** 0.021927313918065 diaria

**GRUPOSURA:** 0.0233817070399678 diaria

**CELSIA:** 0.0164997698216524 diaria

4. Coeficiente de correlación.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

:math:`\rho_{PFBCOLOM,GRUPOSURA}=0,7009251`

:math:`\rho_{PFBCOLOM,CELSIA}=0,4294552`

:math:`\rho_{GRUPOSURA,CELSIA}=0,4220854`

5. Rendimiento esperado del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

-0,000628619766953236 diario

6. Volatilidad del portafolio de inversión.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

0,0181098889699652 diaria

7. Gráfico: precios.
~~~~~~~~~~~~~~~~~~~~

.. figure:: Precios.jpg
   :alt: 1

   1

8. Gráfico: rendimientos de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

|image0|

.. |image0| image:: Rendimientos.jpg

9. Gráfico: histograma de los rendimientos de las acciones.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: Histogramas1.jpg
   :alt: 2

   2

10. Gráfico: histograma de los rendimientos de las acciones y distribución normal con frecuencia diaria (:math:`\mu\neq 0`).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: Histogramas2.jpg
   :alt: 3

   3

11. Gráfico: histograma de los rendimientos del portafolio de inversión y distribución normal con frecuencia diaria (:math:`\mu\neq 0`).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: Histograma1.jpg
   :alt: 4

   4

12. Estadísticas básicas de los rendimientos.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: Tabla1.jpg
   :alt: 5

   5

13. VaR individuales (sin promedios) diario con un nivel de confianza del 95%.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

**PFBCOLOM:** 0,0360672218274327

**GRUPOSURA:** 0,0384594856290077

**CELSIA:** 0,0271397062350094

**PFBCOLOM:** $21.640.333,0964596

**GRUPOSURA:** $34.613.537,066107

**CELSIA:** $13.569.853,1175047

14. VaR portafolio de inversión (sin promedios) diario con un nivel de confianza del 95%.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

$VaR_P: $ $59.576.233,1118715

$VaR_P: $ 0,0297881165559357

15. BD del método VaR (sin promedios) diario con un nivel de confianza del 95%.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

**BD:** $10.247.490.1681998

16. Comparación VaR (sin promedios).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: Histograma2.jpg
   :alt: 6

   6

17. VaR individuales (con promedios) semanal con un nivel de confianza del 99%.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuestas:**

**PFBCOLOM:** 0,11613792393225.

**GRUPOSURA:** 0,127008463116999.

**CELSIA:** 0,0862286036954877.

**PFBCOLOM:** $69.682.754,3593502.

**GRUPOSURA:** $114.307.616,805299.

**CELSIA:** $43.114.301,8477439.

18. VaR portafolio de inversión (con promedios) semanal con un nivel de confianza del 99%.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

$VaR_P: $ $194.133.051,394595.

$VaR_P: $ 0,0970665256972973.

19. BD del método VaR (con promedios) semanal con un nivel de confianza del 99%.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

**Respuesta:**

**BD:** $32.971.621,6177982.

20. Comparación VaR (con promedios).
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. figure:: Histograma3.jpg
   :alt: 7

   7
