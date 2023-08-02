personaje(pumkin,ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny,ladron([licorerias, estacionesDeServicio])).
personaje(vincent,mafioso(maton)).
personaje(jules,mafioso(maton)).
personaje(marsellus,mafioso(capo)).
personaje(winston,mafioso(resuelveProblemas)).
personaje(mia,actriz([foxForceFive])).
personaje(butch,boxeador).

pareja(marsellus,mia).
pareja(pumkin,honeyBunny).

% trabajaPara(Empleador,Empleado)
trabajaPara(marsellus,vincent).
trabajaPara(marsellus,jules).
trabajaPara(marsellus,winston).

amigo(vincent,jules).
amigo(jules,jimmie).
amigo(vincent,elVendedor).

% Punto 1

esPeligroso(Personaje) :-
    realizaActividadPeligrosa(Personaje).

esPeligroso(Personaje) :-
    trabajaPara(Personaje,Empleado),
    realizaActividadPeligrosa(Empleado).

realizaActividadPeligrosa(Personaje) :-
    personaje(Personaje,mafioso(maton)).

realizaActividadPeligrosa(Personaje) :-
    personaje(Personaje,ladron(EstablecimientosDeRobo)),
    member(licorerias,EstablecimientosDeRobo).

% Punto 2

duoTemible(Personaje1,Personaje2) :-
    sonAmbosPeligrosos(Personaje1,Personaje2),
    sonAmigosOPareja(Personaje1,Personaje2).

sonAmbosPeligrosos(Personaje1,Personaje2) :-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2).

sonAmigosOPareja(Personaje1,Personaje2) :-
    amigo(Personaje1,Personaje2).

sonAmigosOPareja(Personaje1,Personaje2) :-
    amigo(Personaje2,Personaje1).

sonAmigosOPareja(Personaje1,Personaje2) :-
    pareja(Personaje1,Personaje2).

sonAmigosOPareja(Personaje1,Personaje2) :-
    pareja(Personaje2,Personaje1).

%encargo(Solicitante, Encargado, Tarea). 
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

% Punto 3
estaEnProblemas(Personaje) :-
    trabajaPara(Jefe,Personaje),
    esPeligroso(Jefe),
    pareja(Jefe,Pareja),
    encargo(Jefe,Personaje,cuidar(Pareja)).

estaEnProblemas(Personaje) :-
    encargo(_,Personaje,buscar(Persona,_)),
    personaje(Persona,boxeador).

estaEnProblemas(butch).

% Punto 4

sanCayetano(Personaje) :-
    tieneCerca(_,Personaje),
    forall(tieneCerca(_,Personaje),encargo(_,Personaje,_)).

% A partir de aca deje  de hacer  las relaciones simetricas, pero tranquilamente se puden realizar

tieneCerca(Persona,Personaje) :-
    amigo(Persona,Personaje).

tieneCerca(Persona,Personaje) :-
    trabajaPara(Persona,Personaje).

% Punto 5 

masAtareado(Personaje) :-
    cantidadDeEncargos(Personaje,EncargosDelPersonaje),
    forall(cantidadDeEncargos(_,CantEncargos),EncargosDelPersonaje >= CantEncargos).

cantidadDeEncargos(Personaje,CantEncargos) :-
    findall(_,encargo(_,Personaje,_),Encargos),
    length(Encargos,CantEncargos).

% Punto 6
personajesRespetables(Personajes) :-
    findall(Personaje,esRespetable(Personaje),Personajes).

esRespetable(Personaje) :-
    personaje(Personaje,Tipo),
    cantidadDeRespeto(Tipo,Respeto),
    Respeto > 9.

cantidadDeRespeto(actriz(Peliculas),Respeto) :-
    length(Peliculas,CantidadDePeliculas),
    Respeto is CantidadDePeliculas / 10.

cantidadDeRespeto(mafioso(resuelveProblemas),10).
cantidadDeRespeto(mafioso(maton),1).
cantidadDeRespeto(mafioso(capo),20).

% Punto 7

hartoDe(Personaje1,Personaje2) :-
    personaje(Personaje1,_),
    personaje(Personaje2,_),
    forall(interactua(Personaje1,_),interactua(Personaje1,Personaje2)).

interactua(Personaje1,Personaje2) :-
   buscaAyudaOCiuda(Personaje1,Personaje2).

interactua(Personaje1,Personaje2) :-
    amigo(Personaje2,Amigo),
    buscaAyudaOCiuda(Personaje1,Amigo).

buscaAyudaOCiuda(Personaje1,Personaje2) :-
    encargo(_,Personaje1,cuidar(Personaje2));
    encargo(_,Personaje1,buscar(Personaje2));
    encargo(_,Personaje1,ayudar(Personaje2)).
% Punto 8


caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).


duoDiferenciable(Personaje1,Personaje2) :-
    esDuo(Personaje1,Personaje2),
    caracteristicas(Personaje1,Caracteristicas),
    member(UnaCaracteristica,Caracteristicas),
    caracteristicas(Personaje2,OtrasCaracteristicas),
    not(member(UnaCaracteristica,OtrasCaracteristicas)).

esDuo(Personaje1,Personaje2) :-
    amigo(Personaje1,Personaje2);
    pareja(Personaje1,Personaje2);
    amigo(Personaje2,Personaje1);
    pareja(Personaje2,Personaje1).