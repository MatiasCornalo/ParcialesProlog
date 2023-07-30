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


encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).


estaEnProblemas(Personaje) :-
    trabajaPara(Jefe,Personaje),
    esPeligroso(Jefe),
    pareja(Jefe,Pareja),
    encargo(Jefe,Personaje,cuidar(Pareja)).

estaEnProblemas(Personaje) :-
    encargo(_,Personaje,buscar(Persona,_)),
    personaje(Persona,boxeador).


estaEnProblemas(butch).


sanCayetano(Personaje) :-
    tieneCerca(_,Personaje),
    forall(tieneCerca(_,Personaje),encargo(_,Personaje,_)).

tieneCerca(Persona,Personaje) :-
    amigo(Persona,Personaje).
