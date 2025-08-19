Modelos ARMA
------------

Los modelo ARMA (Autoregressive Moving-Average) combinan las ideas de
los modelos AR y MA en un solo modelo.

Para una serie de tiempo :math:`z_t` que sigue un modelo ARMA(1,1)
satisface que:

.. math::  z_t - \phi_1z_{t-1} = \phi_0+a_t-\theta_1a_{t-1} 

Donde :math:`a_t` es un ruido blanco. El izquierdo de la ecuación es la
componente AR del modelo y el lado derecho es la componente MA. El
término de la constante es :math:`\phi_0`. Para que este modelo sea
significativo se necesita que :math:`\phi_1 \neq \theta_1`; de lo
contrario, hay una cancelación en la ecuación y el modelo se reduce en
un ruido blanco.

**Propiedades de los modelo ARMA(1,1):**

Estas propiedades son generalizadas de los modelos AR(1).

Condición de estacionariedad:

.. math::  E(z_t) - \phi_1E(z_{t-1})=\phi_0+E(a_t)-\theta_1E(a_{t-1})  

Dado que :math:`E(a_i)=0` para todo :math:`i`, entonces la media de
:math:`z_t` es:

.. math::  E(z_t) = \mu = \frac{\phi_0}{1-\phi_1} 

El resultado anterior es el mismo obtenido en AR(1).

Para la varianza, si :math:`z_t` es estacionaria, entonces:
:math:`Var(z_t)=Var(z_{t-1})`.

.. math::  Var(z_t)=\frac{(1+2\phi_1\theta_1+\theta_1^2)\sigma_a^2}{1-\phi_1^2}  

Como la varianza es positiva, se necesita que :math:`\phi_1^2 <1`. Esta
es la misma condición de estacionariedad que se obtuvo en el modleo
AR(1).

El térmimo de ACF es:

.. math::  \rho_1=\phi_1-\frac{\theta_1\sigma_a^2}{Var(z_t)} 

.. math::  \rho_{\ell}=\phi_1\rho_{\ell -1} 

Para :math:`\ell>1`.

Así que el AFC de un modelo ARMA(1,1) se comporta como el del modelo
AR(1) excepto que la caída exponencial empieza en el rezago 2.
Similarmente, el PACF del modelo ARMA(1,1) se parece al del modelo
MA(1), pero con caída exponencial desde el rezago 2.

Modelo ARMA en general:
~~~~~~~~~~~~~~~~~~~~~~~

Los modelo ARMA(:math:`p`, :math:`q`) son de la siguiente forma:

.. math::  z_t = \phi_0+\sum_{i=1}^p{\phi_1z_{t-i}}+a_t-\sum_{i=1}^q{\theta_ia_{t-i}} 

Donde :math:`a_t` es ruido blanco, :math:`p` y :math:`q` son enteros
positivos.

La media incondicional es:

.. math::  E(z_t) = \frac{\phi_0}{1-\phi_1-...-\phi_p}  

Identificación de los modelo ARMA:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Al igual que en los modelo AR y MA se usan el ACF y el PACF de la
siguiente manera:

-  Para el orden :math:`p` se usa el PACF.

-  Para el orden :math:`q` se usa el ACF.

Pronóstico (Forecasting) con ARMA:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Pronóstico para un paso hacia adelante:

.. math::  \hat{z_h}(1) = E(z_{h+1}|F_h)=\phi_0+\sum_{i=1}^p{\phi_iz_{h+1-i}}-\sum_{i=1}^q{\theta_ia_{h+1-i}} 

.. math::  e_h(1) = z_{h+1}-\hat{z_h}(1)=a_{h+1} 

.. math::  Var[e_h(1)]=\sigma_a^2  

.

Pronóstico para múltiples pasos hacia adelante:

.. math::  \hat{z_h}(\ell) = E(z_{h+\ell}|F_h)=\phi_0+\sum_{i=1}^p{\phi_i\hat{z_h}(\ell-i)}-\sum_{i=1}^q{\theta_ia_h(\ell-i)} 

Donde :math:`\hat{z_h}(\ell-i)=z_{h+\ell-i}` si :math:`\ell-i \leq 0`.

Donde :math:`a_h(\ell-i)=0` si :math:`\ell-i > 0`.

Donde :math:`a_h(\ell-i)=a_{h+\ell-i}` si :math:`\ell-i \leq 0`.

El error del pronóstico es:

.. math::  e_h(\ell) = z_{h+\ell}-\hat{z_h}(\ell) 
