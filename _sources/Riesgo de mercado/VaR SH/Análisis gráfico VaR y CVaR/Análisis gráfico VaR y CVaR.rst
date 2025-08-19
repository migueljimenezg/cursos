Análisis gráfico VaR y CVaR
---------------------------

.. code:: r

    datos=read.csv("Datos primer examen 01-2020.csv",sep = ";")

.. code:: r

    precios=datos[,-1]

.. code:: r

    rendimientos=matrix(,nrow(precios)-1,ncol(precios))
    for(i in 1:ncol(precios)){
      rendimientos[,i]=diff(log(precios[,i]))
    }

Histograma y distribución empírica de ECO
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,1],breaks = 40,col = "gray",xlab = "Rendimientos",ylab = "Frecuencia",main = "Histograma acción ECO",freq =F)
    lines(density(rendimientos[,1]),lwd=3)
    legend(x="topleft","Distribución empírica",col="Black",lwd=3,bty="n")



.. image:: output_5_0.png
   :width: 420px
   :height: 420px


Histograma y distribución empírica de ISA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,2],breaks = 40,col = "gray",xlab = "Rendimientos",ylab = "Frecuencia",main = "Histograma acción ISA",freq =F)
    lines(density(rendimientos[,1]),lwd=3)
    legend(x="topleft","Distribución empírica",col="Black",lwd=3,bty="n")



.. image:: output_7_0.png
   :width: 420px
   :height: 420px


Histograma y distribución empírica de Nutresa
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,3],breaks = 40,col = "gray",xlab = "Rendimientos",ylab = "Frecuencia",main = "Histograma acción Nutresa",freq =F)
    lines(density(rendimientos[,3]),lwd=3)
    legend(x="topleft","Distribución empírica",col="Black",lwd=3,bty="n")



.. image:: output_9_0.png
   :width: 420px
   :height: 420px


Histograma y distribución empírica de PFBCOLOM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,4],breaks = 40,col = "gray",xlab = "Rendimientos",ylab = "Frecuencia",main = "Histograma acción PFBCOLOM",freq =F)
    lines(density(rendimientos[,4]),lwd=3)
    legend(x="topleft","Distribución empírica",col="Black",lwd=3,bty="n")



.. image:: output_11_0.png
   :width: 420px
   :height: 420px


.. code:: r

    proporciones=c(0.25,0.25,0.25,0.25)

.. code:: r

    NC=0.99

.. code:: r

    VaR_individuales_SH_percentil=vector()
    for(i in 1:ncol(rendimientos)){
      VaR_individuales_SH_percentil[i]=abs(quantile(rendimientos[,i],1-NC))
    }
    VaR_individuales_SH_percentil



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.100017529037464</li><li>0.0747062638979077</li><li>0.0623792449456534</li><li>0.0746798926612424</li></ol>
    


.. code:: r

    CVaR=vector()
    for(i in 1:ncol(rendimientos)){
      CVaR[i]=abs(mean(tail(sort(rendimientos[,i],decreasing = T),floor(nrow(rendimientos)*(1-NC)))))
    }
    CVaR



.. raw:: html

    <style>
    .list-inline {list-style: none; margin:0; padding: 0}
    .list-inline>li {display: inline-block}
    .list-inline>li:not(:last-child)::after {content: "\00b7"; padding: 0 .5ex}
    </style>
    <ol class=list-inline><li>0.131734096471733</li><li>0.104054311101083</li><li>0.0763919471659559</li><li>0.0898571003585143</li></ol>
    


.. code:: r

    rendimientos_portafolio=vector()
    for(i in 1:nrow(rendimientos)){
      rendimientos_portafolio[i]=sum(rendimientos[i,]*proporciones)
    }

.. code:: r

    VaR_portafolio_SH_percentil=abs(quantile(rendimientos_portafolio,1-NC))
    VaR_portafolio_SH_percentil



.. raw:: html

    <strong>1%:</strong> 0.0570097464552412


.. code:: r

    CVaR_portafolio=abs(mean(tail(sort(rendimientos_portafolio,decreasing = T),floor(nrow(rendimientos)*(1-NC)))))
    CVaR_portafolio



.. raw:: html

    0.0700265657963683


Histograma, distribución empírica de VaR y CVaR de ECO
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,1],breaks = 40,col = "gray",xlab = "Rendimientos",ylab = "Frecuencia",main = "Histograma acción ECO",freq =F)
    lines(density(rendimientos[,1]),lwd=3)
    abline(v=-VaR_individuales_SH_percentil[1],col="darkblue",lwd=4)
    abline(v=-CVaR[1],col="darkred",lwd=4)
    legend(x="topright",c("Distribución empírica","VaR","CVaR"),col=c("Black","darkblue","darkred"),lwd=c(3,4,4),bty="n")



.. image:: output_20_0.png
   :width: 420px
   :height: 420px


Histograma, distribución empírica de VaR y CVaR de ISA
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,2],breaks = 40,col = "gray",xlab = "Rendimientos",ylab = "Frecuencia",main = "Histograma acción ISA",freq =F)
    lines(density(rendimientos[,2]),lwd=3)
    abline(v=-VaR_individuales_SH_percentil[2],col="darkblue",lwd=4)
    abline(v=-CVaR[2],col="darkred",lwd=4)
    legend(x="topright",c("Distribución empírica","VaR","CVaR"),col=c("Black","darkblue","darkred"),lwd=c(3,4,4),bty="n")



.. image:: output_22_0.png
   :width: 420px
   :height: 420px


Histograma, distribución empírica de VaR y CVaR de Nutresa
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,3],breaks = 40,col = "gray",xlab = "Rendimientos",ylab = "Frecuencia",main = "Histograma acción Nutresa",freq =F)
    lines(density(rendimientos[,3]),lwd=3)
    abline(v=-VaR_individuales_SH_percentil[3],col="darkblue",lwd=4)
    abline(v=-CVaR[3],col="darkred",lwd=4)
    legend(x="topright",c("Distribución empírica","VaR","CVaR"),col=c("Black","darkblue","darkred"),lwd=c(3,4,4),bty="n")



.. image:: output_24_0.png
   :width: 420px
   :height: 420px


Histograma, distribución empírica de VaR y CVaR de PFBCOLOM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,4],breaks = 40,col = "gray",xlab = "Rendimientos",ylab = "Frecuencia",main = "Histograma acción PFBCOLOM",freq =F)
    lines(density(rendimientos[,4]),lwd=3)
    abline(v=-VaR_individuales_SH_percentil[4],col="darkblue",lwd=4)
    abline(v=-CVaR[4],col="darkred",lwd=4)
    legend(x="topright",c("Distribución empírica","VaR","CVaR"),col=c("Black","darkblue","darkred"),lwd=c(3,4,4),bty="n")



.. image:: output_26_0.png
   :width: 420px
   :height: 420px


Distribuciones empíricas y VaR de las cuatro acciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,1],breaks = 40,col = "white",border = "white",xlab = "Rendimientos",ylab = "Frecuencia",main = "",freq =F,ylim=c(0,20))
    lines(density(rendimientos[,1]),lwd=3,col="brown")
    lines(density(rendimientos[,2]),lwd=3,col="darkblue")
    lines(density(rendimientos[,3]),lwd=3,col="darkgreen")
    lines(density(rendimientos[,4]),lwd=3,col="purple")
    abline(v=-VaR_individuales_SH_percentil[1],col="brown",lwd=4)
    abline(v=-VaR_individuales_SH_percentil[2],col="darkblue",lwd=4)
    abline(v=-VaR_individuales_SH_percentil[3],col="darkgreen",lwd=4)
    abline(v=-VaR_individuales_SH_percentil[4],col="purple",lwd=4)
    legend(x="topright",c("ECO","ISA","Nutresa","PFBCOLOM"),col=c("brown","darkblue","darkgreen","purple"),lwd=c(4,4,4,4),bty="n")



.. image:: output_28_0.png
   :width: 420px
   :height: 420px


Distribuciones empíricas y CVaR de las cuatro acciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos[,1],breaks = 40,col = "white",border = "white",xlab = "Rendimientos",ylab = "Frecuencia",main = "",freq =F,ylim=c(0,20))
    lines(density(rendimientos[,1]),lwd=3,col="brown")
    lines(density(rendimientos[,2]),lwd=3,col="darkblue")
    lines(density(rendimientos[,3]),lwd=3,col="darkgreen")
    lines(density(rendimientos[,4]),lwd=3,col="purple")
    abline(v=-CVaR[1],col="brown",lwd=4)
    abline(v=-CVaR[2],col="darkblue",lwd=4)
    abline(v=-CVaR[3],col="darkgreen",lwd=4)
    abline(v=-CVaR[4],col="purple",lwd=4)
    legend(x="topright",c("ECO","ISA","Nutresa","PFBCOLOM"),col=c("brown","darkblue","darkgreen","purple"),lwd=c(4,4,4,4),bty="n")



.. image:: output_30_0.png
   :width: 420px
   :height: 420px


Histograma, distribución empírica, VaR y CVaR del portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos_portafolio,breaks = 40,col = "gray",border = "white",xlab = "Rendimientos",ylab = "Frecuencia",main = "",freq =F)
    lines(density(rendimientos_portafolio),lwd=3,col="black")
    abline(v=-VaR_portafolio_SH_percentil,col="darkgreen",lwd=4)
    abline(v=-CVaR_portafolio,col="darkred",lwd=4)
    legend(x="topright",c("Distribución empírica","VaR","CVaR"),col=c("Black","darkgreen","darkred"),lwd=c(3,4,4),bty="n")



.. image:: output_32_0.png
   :width: 420px
   :height: 420px


Comparación VaR acciones con VaR portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos_portafolio,breaks = 40,col = "white",border = "white",xlab = "Rendimientos",ylab = "Frecuencia",main = "VaR",freq =F,xlim=c(-0.15,0.15))
    lines(density(rendimientos[,1]),lwd=3,col="gray")
    lines(density(rendimientos[,2]),lwd=3,col="gray")
    lines(density(rendimientos[,3]),lwd=3,col="gray")
    lines(density(rendimientos[,4]),lwd=3,col="gray")
    lines(density(rendimientos_portafolio),lwd=4,col="black")
    legend(x="topright",c("Acciones","Portafolio"),col=c("gray","black"),lwd=c(3,4),bty="n")
    abline(v=-VaR_individuales_SH_percentil[1],col="gray",lwd=4)
    abline(v=-VaR_individuales_SH_percentil[2],col="gray",lwd=4)
    abline(v=-VaR_individuales_SH_percentil[3],col="gray",lwd=4)
    abline(v=-VaR_individuales_SH_percentil[4],col="gray",lwd=4)
    abline(v=-VaR_portafolio_SH_percentil,col="black",lwd=4)



.. image:: output_34_0.png
   :width: 420px
   :height: 420px


Comparación CVaR acciones con CVaR portafolio de inversión
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code:: r

    hist(rendimientos_portafolio,breaks = 40,col = "white",border = "white",xlab = "Rendimientos",ylab = "Frecuencia",main = "CVaR",freq =F,xlim=c(-0.15,0.15))
    lines(density(rendimientos[,1]),lwd=3,col="gray")
    lines(density(rendimientos[,2]),lwd=3,col="gray")
    lines(density(rendimientos[,3]),lwd=3,col="gray")
    lines(density(rendimientos[,4]),lwd=3,col="gray")
    lines(density(rendimientos_portafolio),lwd=4,col="black")
    legend(x="topright",c("Acciones","Portafolio"),col=c("gray","black"),lwd=c(3,4),bty="n")
    abline(v=-CVaR[1],col="gray",lwd=4)
    abline(v=-CVaR[2],col="gray",lwd=4)
    abline(v=-CVaR[3],col="gray",lwd=4)
    abline(v=-CVaR[4],col="gray",lwd=4)
    abline(v=-CVaR_portafolio,col="black",lwd=4)



.. image:: output_36_0.png
   :width: 420px
   :height: 420px

