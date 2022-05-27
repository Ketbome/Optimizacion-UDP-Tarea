set centros; #Conjunto de centro(v)
set puntos; #conjunto de puntos de venta(s)

param CC{v in centros}; #Costo de instalación de un centro en v
param CT{v in centros}; #Costos de transporte mayorista via camión a v
param CTT{v in centros, s in puntos}; #Costo de transporte por tonelada por minorista de v hasta s
param DM{s in puntos}; #demandas en toneladas de s
param CAP{v in centros}; #Capacidad de cada centro de distribucion de toneladas en v
param C; #Capacidad del camion.

var X{v in centros} integer >= 0; #Camiones a enviar a v
var H{v in centros} binary; #Construcción centro en v(1 si se construye, 0 si no)
var Q{v in centros, s in puntos} >= 0; #Cantidad de toneladas a enviar desde el centro v a punto de venta s

minimize Costos:
sum{v in centros}CT[v]*X[v] + sum{v in centros, s in puntos}CTT[v,s]*Q[v,s] + sum{v in centros}CC[v]*H[v];

subject to capacidad {v in centros}:
sum{s in puntos}Q[v,s]<=CAP[v]*H[v];

subject to demanda {s in puntos}:
sum{v in centros}Q[v,s]>=DM[s];

subject to asignacion_de_camiones {v in centros}:
(X[v]*C)>=sum{s in puntos}Q[v,s];

subject to control{v in centros}:
X[v]*C <= CAP[v]*H[v];




