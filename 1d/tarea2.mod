set centros; #Conjunto de centro(v)
set puntos; #conjunto de puntos de venta(s)
set anios; #años

param CC{v in centros}; #Costo de instalación de un centro en v
param CT{v in centros}; #Costos de transporte mayorista via camión a v
param CTT{v in centros, s in puntos}; #Costo de transporte por tonelada por minorista de v hasta s
param DM{s in puntos, w in anios}; #demandas en toneladas de s
param CAP{v in centros}; #Capacidad de cada centro de distribucion de toneladas en v
param C; #Capacidad del camion.

var X{v in centros, w in anios} integer >= 0; #Camiones a enviar a v
var H{v in centros, w in anios} binary; #Construcción centro en v(1 si se construye, 0 si no)
var Q{v in centros, s in puntos, w in anios} >= 0; #Cantidad de toneladas a enviar desde el centro v a punto de venta s

minimize Costos:
sum{v in centros, w in anios}CT[v]*X[v,w] + sum{v in centros, s in puntos, w in anios}CTT[v,s]*Q[v,s,w] + sum{v in centros}CC[v]*H[v,1]*0.6 + sum{v in centros}CC[v]*H[v,1]*9*0.4;

subject to capacidad {v in centros, w in anios}:
sum{s in puntos}Q[v,s,w]<=CAP[v]*H[v,1];

subject to demanda {s in puntos, w in anios}:
sum{v in centros}Q[v,s,w]>=DM[s,w];

subject to asignacion_de_camiones {v in centros, w in anios}:
(X[v,w]*C)>=sum{s in puntos}Q[v,s,w];

subject to control{v in centros, w in anios}:
X[v,w]*C <= CAP[v]*H[v,1];




