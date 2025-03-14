# Ejercicio 1


# Ejercicio 2


# Ejercicio 3
$$
\hat{\beta} = \frac{\sum x_i y_i}{\sum x_i^2}
$$
Usó: Al menos un $x_{i}$ es distinto de 0. 
$$
E(\hat{\beta}) = E \left( \frac{\sum x_i y_i}{\sum x_i^2} \right)
$$
Toma esperanza de ambos lados.
$$
E(\hat{\beta}) = \sum w_i E(y_i)
$$
Usó: Define $w_{i}=\frac{\sum x_i }{\sum x_i^2}$. Las $x$ no son aleatorias y linealidad de las esperanzas.

$$
E(\hat{\beta}) = \sum w_i E(x_i \beta + \mu_i - \bar{\mu})
$$
Usó: Linealidad, modelo. 

$$
E(\hat{\beta}) = \sum w_i \left[ E(x_i \beta) + E(\mu_i) - E(\bar{\mu}) \right]
$$
Usó: Linealidad de la esperanza

$$
E(\hat{\beta}) = \sum w_i \left[ x_i \beta + E(\mu_i) - E \left( \frac{\sum \mu_i}{n} \right) \right]
$$
Usó: Reexpresó el promedio y asume que todos los errores son iguales  $E(\mu_i)=k$, constantes. 

$$
E(\hat{\beta}) = \sum w_i \left( x_i \beta + k - \frac{n k}{n} \right)
$$
Usó: la esperanza de valores constantes que no dependen de $i$ es $n$ veces ese valor.

$$
E(\hat{\beta}) = \sum w_i (x_i \beta + k - k)
$$
$k-k=0$

$$
E(\hat{\beta}) = \sum w_i x_i \beta
$$

$$
E(\hat{\beta}) = \beta \sum w_i x_i
$$
Porque $\beta$ es un número constante se multiplica a la suma en vez de cada termino.

$$
E(\hat{\beta}) = \beta \frac{\sum x_i^2}{\sum x_i^2}
$$
Reemplazó $w_{i}=\frac{\sum x_i }{\sum x_i^2}$, como quedaba multiplicando cada $x$ por sí mismo se cancelan
$$
E(\hat{\beta}) = \beta
$$
