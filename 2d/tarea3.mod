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
sum{v in centros, w in anios}CT[v]*X[v,w] + sum{v in centros, s in puntos, w in anios}CTT[v,s]*Q[v,s,w] + sum{v in centros}CC[v]*H[v,10]*0.6 + sum{v in centros}CC[v]*(sum{w in anios}(H[v,w])-1)*0.4*H[v,10];

subject to capacidad {v in centros, w in anios}:
sum{s in puntos}Q[v,s,w]<=CAP[v]*H[v,w];

subject to demanda {s in puntos, w in anios}:
sum{v in centros}Q[v,s,w]>=DM[s,w];

subject to asignacion_de_camiones {v in centros, w in anios}:
(X[v,w]*C)>=sum{s in puntos}Q[v,s,w];

subject to control{v in centros, w in anios}:
X[v,w]*C <= CAP[v]*H[v,w];

subject to instalacion{v in centros}:
H[v,1] <= H[v,2];
subject to instalacion2{v in centros}:
H[v,2] <= H[v,3];
subject to instalacion3{v in centros}:
H[v,3] <= H[v,4];
subject to instalacion4{v in centros}:
H[v,4] <= H[v,5];
subject to instalacion5{v in centros}:
H[v,5] <= H[v,6];
subject to instalacion6{v in centros}:
H[v,6] <= H[v,7];
subject to instalacion7{v in centros}:
H[v,7] <= H[v,8];
subject to instalacion8{v in centros}:
H[v,8] <= H[v,9];
subject to instalacion9{v in centros}:
H[v,9] <= H[v,10];





