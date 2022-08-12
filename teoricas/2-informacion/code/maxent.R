# Objetivo
## Teórica: Descubrir el concepto de información. Sus propiedades. Su relación con los datos, los modelos y la inferencia. Las conclusiones para las ciencias empíricas.
## Práctica: Entropia de Modelos (sobre probabilidad conjunta), ejemplo Monty Hall y alternativo.

# Teórica.
## Problema Fundamental:
### El problema fundamental es "El contacto con la realidad", pues lo que recibimos no siempre es igual a lo que la realidad nos envía. Esta es lo que ocurre con los "Datos empíricos". La realidad (source, s) envía (-> encoder, e ->) una señal (transmited-signal, ts) y nosotres detectamos (-> canal + ruido, c y r ->) un "indicador" (recived-signal, rs), que podemos decodificar (decoder, d) para estimar (estimate, h) la realidad fuente y el ruido. Quisiéramos que lo que recibimos sea igual a lo enviado, garantizar el contacto con la realidad (perder toda la incertidumbre sobre la fuente).
### Fuente ->[Encoder]-> Señal ->[Canal]-> Indicador ->[Decoder]-> Estimación
### - Fuente (F): El valor de la variable (V) de una Unidad de Análisis (UA).
### - Encoder: Realidad causal
### - Señal-T: Valor de las dimensiones (D).
### - Canal: Procedimiento de determinación (P) transforma la señal de la fuente + el ruido ambiente en
### - Señal-R: Indicador (I), base empírica epistemológica.
### - Decoder: Hipótesis indicadora (HI), donde la inferencia causal-bayesiana es su universal.
### - Estimación: Distribución de creencias sobre el valor de la variable, base empírica metodológica.

# Practica
## ¿Cómo garantizar el contacto con la realidad?
### Las fuentes de datos son rendundantes debido a la realidad causal subyacente que suponemos relativemente estable.

fuente
# Definicion de constantes
joint_prior_A = matrix(NA, nrow=3, ncol=3)
joint_prior_A[1,] = c(0, 1/6, 1/6)
joint_prior_A[2,] = c(1/6, 0, 1/6)
joint_prior_A[3,] = c(1/6, 1/6, 0)

joint_prior_Monty = matrix(NA, nrow=3, ncol=3)
joint_prior_Monty[1,] = c( 0,   0,   0)
joint_prior_Monty[2,] = c(1/6,  0,  1/3)
joint_prior_Monty[3,] = c(1/6, 1/3,  0)

joint_posterior_Monty = matrix(NA, nrow=3, ncol=3)
joint_posterior_Monty[1,] = c(0, 0, 0)
joint_posterior_Monty[2,] = c(1/3, 0, 2/3)
joint_posterior_Monty[3,] = c(0, 0, 0) 

# Definicion de fuinciones

informacion <- function(p){
    return(-log(p,2))
}
#sum(joint_prior_Monty*informacion(joint_prior_Monty),na.rm=TRUE)

p <- c(5/12, 1/6, 5/12)
sum(p*informacion(p))

informacion(1/6) ==93.174.95.29/main/598000/e70cc484c7ff51073859b15779162c25/MacKay%20D.J.C.%20-%20Information%20theory%2C%20inference%20and%20learning%20algorithms-CUP%20%282005%29.pdf informacion(1/3) + informacion(1/2)

entropia <- function(joint_prior = joint_prior_Monty){
    res = 0.0
    joint_prior_vector = as.vector(joint_prior[joint_prior>0.0])
    for(p in joint_prior_vector){
        res = res - (p*log(p))
    }
    return(res)
}

# Pruebas
entropia(joint_prior_Monty) < entropia(joint_prior_A)

function Dkl(p,q)
    res = 0.0
    for i in 1:length(p)
        if p[i]>0.0
            res += p[i]*(log(q[i]/p[i]))
    end end
    return -res 
end

function alternative(i)
    Dkl([ [0 0 0] ; [i/100 0 1-i/100 ] ; [0 0 0] ], _prior_)
end

minimum(alternative.(1:100))
Dkl(_posterior_, _prior_)
plot(alternative.(1:100))
