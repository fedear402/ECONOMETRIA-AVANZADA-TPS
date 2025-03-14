# -------------------------- ECONOMETRIA AVANZADA  ----------------------------#
# --------------------------    MAE UdeSA 2024    ----------------------------#
# --------------------------       TUTORIAL 1      ----------------------------#
# --------------------------   Introducción a R    ----------------------------#

# Página útil: https://www.rstudio.com/wp-content/uploads/2016/10/r-cheat-sheet-3.pdf

# Numeral para comentar esa línea de código
# Oprimir Run o Ctrl+Enter para ejecutar una línea de código

# -------->  Directorio ####
getwd() # si no estoy en el directorio que quiero, lo seteo
setwd("/Users/federicolopez/Library/CloudStorage/OneDrive-Personal/Documents/UDESA/MAESTRIA/ECONOMETRIA-AVANAZADA/TUTORIALES/01/TUT1")
dir()  #Nos muestra los archivos que hay en el directorio que configuramos


# -------->  Algunos tipos de datos ####

## Numeric

5 + 8 # R funciona como calculadora si corremos esta línea (útil directo en la consola)
sqrt(4)**2  + 4/2

resultado <-  sqrt(4)**2  + 4/2 # también lo podemos guardar, asignándole un nombre (SHORTCUT para <- : Alt+guión)
resultado
resultado + 5 

resultado = 3 # ojo que sobreescribe. También puedo asignar con = 
resultado
Resultado # y es case sensitive

## Character: van entre comillas (simples o dobles!)
string <- "Hola"  
class(string) #vemos el tipo de objeto
string

## Booleano
TRUE
T
FALSE
F
7 == 8
7 != 8

## Vectores (estructura básica de datos)

# creamos un vector columna x
x <- c(1,6,2,45) 
# la "c" es de concatenar elementos
# <- es otra forma de asignar
x

# creamos un segundo vector y (probamos distintas formas)
y <- c(1:4) # los dos puntos indican "desde uno, hasta 4"
y  <-  c(2:4, 135) # concateno los numeros del 2 al cuatro con 135
y <- seq(1,8,2)
?seq

# A veces es útil crear un vector vacío
vectorvacio <- vector()

## Matrices
cbind(x,y)
rbind(x,y)
cbind(c('John','Paul'),c('George','Ringo')) # deben ser todos el mismo tipo de objeto (character en este caso)

## Lists
mezcla <-  c('hola',T,35) # más flexibles que los vectores, puedo guardar cualquier cosa
mezcla

## Funciones 
class(setwd) 
?setwd
help(setwd)
?matrix
# Muchas vienen en R base

# Además hay librerías o paquetes con funciones extra
# install.packages("ggplot2") # así las instalo. Esta es una para gráficos, muy usada
# library('ggplot2') #siempre debo abrirla antes de usar las funciones que trae adentro
# Y podemos crear nuestras propias  funciones


## arrays
## DataFrames
## factors
## tables
## Ver más en https://www.cyclismo.org/tutorial/R/types.html
##           https://www.statmethods.net/input/datatypes.html 

# -------->  Algunas operaciones ####

#Elementos de un objeto:
length(x)
length(y)
length(resultado)

#Si tienen el mismo tamaño, adición de vectores
x+y
w = x+y #lo guardamos

# Entre otras...
min(w) # valor mínimo del vector
max(w)  # valor máximo del vector
range(w) # rango del vector
mean(w) # media del vector
sd(w) # desvío estándar del vector
sum(w)/length(w) # otra forma de calcular la media del vector



# -------->  Administrando los objetos  ####

# Si queremos ver todos los objetos de "Enviroment":    
ls()

# Para borrar objetos:
rm(x,y)
ls() # Chequeamos lo que nos queda

#Para borrar todo lo que tenemos:
rm(list=ls())


# --------> VECTORES ALEATORIOS Y CORRELACIONES ####
rnorm(5)

set.seed(444)

# Veámoslo:
set.seed(444)
rnorm(5)
rnorm(5)
set.seed(444)
rnorm(5)
rnorm(5)

#Creamos dos vectores aleatorios
set.seed(444)
x <- rnorm(10) # normal estándar
y <- x+rnorm(10,mean=50,sd=0.1) # normal indicando media y varianza

cor(x,y) # correlación 
mean(y) # media 
var(y) # varianza
sd(y) # desvío estándar
#-- Alternativa:  sqrt(var(y))

?rbinom
?rpois

#--------> BASES DE DATOS

# La próxima vemos un ejemplo de como abrir una base de datos desde un archivo (está relatado en las slides)
# Hoy, usaremos la base Boston que viene guardada en una librería

install.packages('MASS') #es una librería que tiene bases de datos guardadas, instalo la librería
library(MASS) #abro la librería
?Boston # tiene un objeto Boston que es una base de datos, si pido ayuda me da una descripción completa de cada variable
class(Boston)

# Miramos los datos

names(Boston) # Vemos los nombres de la base y ubicamos la base como objeto
str(Boston) # vemos variables y tipo

head(Boston) # miro las primeras filas

#--------> Características de los datos

# Dimension   
dim(Boston) #506 filas y 14 columnas

# Subsetting: seleccionar un subconjunto de los datos
# dataset[FILAS,COLUMNAS]
Boston[c(1,2),1:5] #filas 1 y 2 de las columnas 1 a 5
Boston[2,] # fila 2 y todas las columnas
Boston[,c("indus","age")] # también puedo seleccionar columnas por nombre
Boston[1:10,c("indus","age")] #acá miro solo las primeras 10

Boston$chas # con el signo $ también selecciono una columna por su nombre
Boston$chas[40:50]


# Missing values
# En R los missing values aparecen como NA
# La base Boston 
is.na(Boston) # me muestra en cada lugar si hay NA... Impráctico, no se ve nada. "Truco":
sum(is.na(Boston)) # Los FALSE valen 0 y los TRUE 1. Si sumo, veo cuántos NA hay. 
#--- Si hago mean, veo la proporción de NA!

# Supongamos que tuviera valores nulos.... Voy a crear una nueva columna con algunos nulos
Boston_n  <-  Boston # creo una copia de la base en Boston_n
Boston_n$connulos  <-  1 # cree una variable que vale siempre 1
Boston_n$connulos[c(4,3,5,8:13)] <-  NA  # meto NA en algunas filas
sum(is.na(Boston_n)) # Ahora tengo 9 NA en la base!
sum(is.na(Boston_n$connulos)) # todos en la variable que cree

# Dropear missing values   
Boston_n  <-  na.omit(Boston_n)

#Chequeamos la nueva dimensión
dim(Boston_n) # Tiene nueve filas menos: eliminó las filas con NA

#--------> Estadística descriptiva ####

summary(Boston)

# Alternativas con más detalles
install.packages("Hmisc")
library("Hmisc")
describe(Boston$lstat)

install.packages("pastecs")
library("pastecs")
stat.desc(Boston$lstat) 

install.packages("psych")
library("psych")
describe(Boston$lstat)


# ------------------------------------------------------------------------#
#                        REGRESIÓN LINEAL SIMPLE
# ------------------------------------------------------------------------#

#  sintaxis:   lm(FÓRMULA, DATOS, OPCIONES)
#  donde FÓRMULA= y ~ x 
#                "y es respuesta del predictor x"  

# Regresamos la mediana del valor de una casa en porcentaje de las casas
# con menor estatus socioeconomico

lm.fit <- lm(medv~lstat, data = Boston)

# Alternativas:
lm.fit <- lm(Boston$medv~Boston$lstat)

attach(Boston)
lm.fit <- lm(medv~lstat)

#-----> ESTIMACIONES

# Si queremos saber que información guarda el comando lm() usamos names():
names(lm.fit)

# Para ver la estimación de los coeficientes corremos:
lm.fit #Vemos solo los coeficientes
# Alternativas:
coef(lm.fit)
lm.fit$coefficients  # También nos muestra los coeficientes

confint(lm.fit) # Intervalo de confianza al 95% de los coeficientes 

summary(lm.fit) # Información más detallada de los estadísticos.


# ------------------------------------------------------------------------#
#                       REGRESIÓN LINEAL MÚLTIPLE
# ------------------------------------------------------------------------#


#  sintaxis:   lm(F?RMULA, DATOS, OPCIONES)
#  donde F?RMULA= y ~ x1 + X2 + X3
#                "y es respuesta del predictor x"


# Regresión de la mediana del valor de una casa en porcentaje de las casas
# con menor estatus socioeconomico y la edad 

lm.fit.1 = lm(medv~lstat+age,data=Boston)
summary(lm.fit.1)

# Regresión de la mediana del valor de una casa en  TODAS las variables
lm.fit.2=lm(medv~.,data=Boston)
summary(lm.fit.2)

# Regresión de la mediana del valor de una casa en  TODAS las variables menos edad
lm.fit3=lm(medv~.-age,data=Boston)
summary(lm.fit3)
# Alternativa: lm.fit1=update(lm.fit, ~.-age)


#----->  REGRESIÓN LINEAL CON INTERACCIÓN

summary(lm(medv~lstat*age,data=Boston))

#----->  TRANSFORMACIONES NO LINEALES A LOS PREDICTORES

lm.fit4=lm(medv~lstat+I(lstat^2)) #Con la función I() podemos luego elevar al cuadrado la variables
summary(lm.fit4) #Vemos los resultados

# Regresi?n con un polinomio de grado 5 usando la función poly()
lm.fit5=lm(medv~poly(lstat,5))
summary(lm.fit5) #Nuevamente la predicción mejora

# Regresión de la mediana del valor de una casa en logaritmo del numero promedio
# de habitaciones de la casa   
summary(lm(medv~log(rm),data=Boston))

#-----> EXPORTAR ESTIMACIONES

# En todo trabajo, paper, presentación, etc., se presentan las salidas de regresión.
# El comando stargazer es muy util para las salidas de regresión y cualquier otra table.

install.packages("stargazer")
library(stargazer)

stargazer(lm.fit, lm.fit.1,
          type = "text", # con text eligen como ver el output: texto (text) o latex (latex)
          keep.stat = c("n", "rsq")   # Elijo que muestre la cantidad de obs y el R2      
          )
          
# Pueden ver muchas otras opciones para dejar la tabla prolija
?stargazer


#Limpiamos un poco los datos generados
rm(list=ls())


###--- Guardar y abrir bases desde archivos ---####

# Cargar bases desde Excel:
install.packages("readxl")
library(readxl)

df <- read_excel("df.xlsx")

# Guardamos en csv
write.csv(df, file = "df.csv")
?write.csv
#write.csv2(df, file = "df.csv", row.names = F) # separa con ; y decimales con ,
#write.table(df, file = "df.csv", dec = ".", sep = ",",row.names = F) # ac? puedo elegir con qu? decimales, separaci?n, guardarlo como archivo de texto, etc.

# Guardamos en Excel
#install.packages("xlsx") # tenemos que instalar una librería
#library("xlsx")
#write.xlsx(df, file = "df.xlsx", sheetName="Sheet1", row.names = F)


###--- Gráficos de correlaciones ---####

# Gráfico de dispersión de las variables
pairs(df, col="blue")

# De dos variables en particular
plot(df$x1, df$x2)

# Varios gráficos juntos
par(mfrow=c(1,2)) # panel con una fila y dos columnas para hacer dos gráficos 

plot(df$x1, df$x2, xlab = "x1", ylab = "x2")
abline(v = 20, col= "red")
abline(h = 0, col= "blue")

plot(df$x1, df$x3, xlab = "x1", ylab = "x3")

par(mfrow=c(1,1)) # volvemos a poner un lienzo para hacer un solo gráfico

# Matriz de correlaciones
cor(df)
round(cor(df),2) 

# Gráfico de matriz 
install.packages("corrplot")
library(corrplot)
matrizcor <- cor(df)
corrplot(matrizcor, method="ellipse")
# Métodos: "circle" (default), "square", "ellipse", "number", "pie", "shade" y "color".
corrplot.mixed(matrizcor)
# Ver más en https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html

# ggplot2: herramienta MUY usada para gráficos

# Repetimos el grafico de dispersión

library(ggplot2)

# Scatter plot básico
ggplot(data = df, aes(x=x1, y=x2)) + 
  geom_point()

# Cambiamos el tamaño del punto, la forma, le damos nombre a los ejes y título, 
# y cambiamos el fondo.

ggplot(data = df, aes(x=x1, y=x2)) + 
  geom_point(size=2, 
             shape=1, 
             color = 'red') + 
  ggtitle('Gráfico de dispersión') +
  xlab('x1') + 
  ylab('x2') + 
  theme_minimal()

# Cheatsheet MUY útil para ggplot: https://www.maths.usyd.edu.au/u/UG/SM/STAT3022/r/current/Misc/data-visualization-2.1.pdf


###--- Loops, ifs y funciones ---####

# Loops:
for (dia in c(1,2,3,4,5,6,7)){
  print(paste("Días de la semana:", dia))
}
rm(dia)

# notemos que es lo mismo que
for (acapuedoponercualquiercosa in 1:6){
  print(paste("Días de dormir la siesta:", acapuedoponercualquiercosa))
}

# agregando "next":
for (i in 1:10) {
  if (i == 2){ # si el resto es cero
    next
  }
  print(i)
}

# While
i <- 1
while (i < 6) {
  print(i)
  i = i+1
}

# funciones

mifuncion <- function(num) {
  resultado = num*4 - 1
  return(resultado)
}
mifuncion(788586)
mifuncion(0)

mifuncion <- function(tomoestevector) {
  resultado =  max(tomoestevector) - min(tomoestevector)
  return(resultado)
}

mifuncion(c(34, 589, 34))

# Aplicar función a todas las filas o columnas de un dataframe con apply
# el 2 indica que la aplique por columna, el 1 por fila
# ejemplo: calcular el máximo menos el mínimo de cada columna
apply(df, 2, FUN = function(x) mifuncion(x)) 

# Borro todo lo del environment
rm(list = ls())
