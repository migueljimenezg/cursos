Autocorrelación Parcial-PACF
----------------------------

La **Función de Autocorrelación Parcial (PACF)** mide la **correlación
directa** entre los valores de una serie de tiempo separados por
:math:`k` periodos, **eliminando el efecto de los rezagos intermedios**.

Mientras que la ACF muestra la relación total (directa e indirecta)
entre :math:`y_t` y :math:`y_{t-k}`, la **PACF muestra sólo la parte
directa** entre esos dos puntos.

.. figure:: PACFvsACF.png
   :alt: PACFvsACF

   PACFvsACF

**Motivación: ¿Por qué necesitamos la PACF?**

-  En procesos autorregresivos (AR), los valores pasados afectan al
   presente, pero también entre sí.

-  La **ACF** no distingue entre la influencia **directa** y la
   **indirecta**: por ejemplo, la correlación entre :math:`y_t` y
   :math:`y_{t-2}` incluye la influencia de :math:`y_{t-1}` como
   “puente”.

-  La **PACF** elimina ese “efecto puente” y mide la correlación neta
   entre :math:`y_t` y :math:`y_{t-k}`.

**Definición formal:**

-  El coeficiente de autocorrelación parcial en el lag :math:`k`
   (:math:`\phi_{kk}`) es la correlación entre :math:`y_t` y
   :math:`y_{t-k}` **condicionada** a los valores intermedios
   :math:`y_{t-1}, y_{t-2}, ..., z_{t-k+1}`.

-  Es el **último coeficiente** del modelo AR(:math:`k`) estimado por
   regresión múltiple.

**¿Cómo se interpreta la PACF?**

-  En un proceso **AR(p)**, la **PACF es significativa solo hasta el
   rezago :math:`p`** y para lags mayores cae rápidamente a cero.

-  Por eso, **el número de rezagos significativos en la PACF indica el
   orden :math:`p` de un modelo AR(p)**.

-  La **ACF** es mejor para identificar el orden :math:`q` de un MA(q),
   la **PACF** es clave para determinar el :math:`p` de un AR(p).

**Comparación ACF vs PACF**

+-----------+---------------------------+---------------------------+
|           | ACF                       | PACF                      |
+===========+===========================+===========================+
| Mide      | Correlación total         | Correlación directa       |
|           | (directa + indirecta)     |                           |
+-----------+---------------------------+---------------------------+
| Útil para | Identificar orden MA(q)   | Identificar orden AR(p)   |
+-----------+---------------------------+---------------------------+
| Patrón AR | Caída exponencial o lenta | Corte brusco después de   |
|           |                           | lag p                     |
+-----------+---------------------------+---------------------------+

.. figure:: acf_pacf_series.png
   :alt: acf_pacf_series

   acf_pacf_series

.. figure:: Diagrama_ACF_PACF.png
   :alt: Diagrama_ACF_PACF

   Diagrama_ACF_PACF

+-------+----------------+--------------+------+---------------------+
| **    | **ACF**        | **PACF**     | **Mo | **Patrón visual     |
| Serie |                |              | delo | clave**             |
| /     |                |              | Su   |                     |
| Mod   |                |              | geri |                     |
| elo** |                |              | do** |                     |
+=======+================+==============+======+=====================+
| Ruido | Todos los      | Todos los    | Nin  | No hay              |
| b     | rezagos dentro | rezagos      | guno | correlaciones, ni   |
| lanco | de la franja,  | dentro de la | /    | en ACF ni en PACF   |
|       | no             | franja, no   | P    |                     |
|       | significativos | si           | aseo |                     |
|       |                | gnificativos | a    |                     |
|       |                |              | leat |                     |
|       |                |              | orio |                     |
+-------+----------------+--------------+------+---------------------+
| AR(p) | Decae          | Corte brusco | A    | PACF con corte      |
|       | gradualmente   | en lag p     | R(p) | brusco; ACF decae   |
|       | (exponencial u | (s           |      | lento               |
|       | oscilante)     | ignificativo |      |                     |
|       |                | hasta p,     |      |                     |
|       |                | luego cero)  |      |                     |
+-------+----------------+--------------+------+---------------------+
| MA(q) | Corte brusco   | Decae        | M    | ACF con corte       |
|       | en lag q       | gradualmente | A(q) | brusco; PACF decae  |
|       | (significativo |              |      | lento               |
|       | hasta q, luego |              |      |                     |
|       | cero)          |              |      |                     |
+-------+----------------+--------------+------+---------------------+
| ARMA  | Ambas decaen   | Ambas decaen | A    | Tanto ACF como PACF |
| (p,q) | gradualmente   | gradualmente | RMA( | decaen              |
|       | (sin cortes    |              | p,q) | lento/oscilar sin   |
|       | bruscos)       |              |      | corte claro         |
+-------+----------------+--------------+------+---------------------+
| Esta  | Picos          | Picos o      | SA   | ACF y PACF con      |
| ciona | periódicos en  | patrones     | RIMA | picos fijos (ej.    |
| lidad | múltiplos del  | oscilantes   |      | cada 12 lags si     |
| pura  | periodo        | en múltiplos |      | mensual)            |
|       |                | del periodo  |      |                     |
+-------+----------------+--------------+------+---------------------+
| Tend  | ACF decae muy  | PACF         | Apl  | ACF con caída       |
| encia | lentamente,    | s            | icar | lenta; indica no    |
|       | rara vez cerca | ignificativa | di   | estacionariedad     |
|       | de cero        | solo en      | fere |                     |
|       |                | primeros     | ncia |                     |
|       |                | lags, luego  |      |                     |
|       |                | dispersión   |      |                     |
+-------+----------------+--------------+------+---------------------+
| Tend  | ACF con caída  | PACF con     | Dif  | Combinación de      |
| encia | lenta y picos  | corte brusco | eren | patrones de         |
| y     | periódicos     | y patrones   | ciar | tendencia y         |
| Esta  |                | oscilantes   | y    | estacionalidad en   |
| ciona |                |              | mod  | ACF y PACF          |
| lidad |                |              | elar |                     |
|       |                |              | es   |                     |
|       |                |              | taci |                     |
|       |                |              | onal |                     |
|       |                |              | idad |                     |
+-------+----------------+--------------+------+---------------------+

.. figure:: Gráficos_ACF_PACF.png
   :alt: Gráficos_ACF_PACF

   Gráficos_ACF_PACF
