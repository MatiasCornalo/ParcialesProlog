mago(harry,mestiza,[coraje,amistoso,orgullo,inteligencia],slytherin).
mago(draco,pura,[orgullo,inteligencia],hufflepuff).
mago(hermione,impura,[responsabilidad,orgullo,inteligencia],_). % revisar

requisitosDeCasa(gryffindor,[coraje]).
requisitosDeCasa(slytherin,[orgullo,inteligencia]).
requisitosDeCasa(ravenclaw,[inteligencia,responsabilidad]).
requisitosDeCasa(hufflepuff,[amistoso]).

% Punto 1
noPermiteEntrar(slytherin,Mago) :-
    mago(Mago,impura,_,_).

% Punto 2
tieneCaracterApropiado(Mago,Casa) :-
    mago(Mago,_,Caracteristicas,_),
    requisitosDeCasa(Casa,Requisitos),
    forall(member(Caracteristica,Requisitos),member(Caracteristica,Caracteristicas)).

% Punto 3

podriaQuedarQuedar(hermione,gryffindor).
podriaQuedar(Mago,Casa) :-
    tieneCaracterApropiado(Mago,Casa),
    not(noPermiteEntrar(Casa,Mago)),
    not(mago(Mago,_,_,Casa)).

% Punto 4

cadenaDeAmistades(Magos) :-
    forall(member(Mago,Magos),esAmistoso(Mago)).

esAmistoso(Mago) :-
    mago(Mago,_,Caracteristicas,_),
    member(amistoso,Caracteristicas).

% PARTE 2

realizo(harry,accion(mala,andarfueraDeLaCama,50)).
realizo(harry,accion(mala,irABosque,50)).
realizo(harry,accion(mala,irATercerPiso,75)).

realizo(hermione,accion(mala,irATercerPiso,75)).
realizo(hermione,accion(mala,irAZonaReestringida,10)).

realizo(hermione,accion(buena,salvarASusAmigos,50)).
realizo(harry,accion(buena,ganarleAVoldemort,60)).

esDe(hermione,gryffindor).
esDe(ron,gryffindor).
esDe(harry,gryffindor).
esDe(draco,slytherin).
esDe(luna,ravenclaw).

esBuenAlumno(Mago) :-
    realizo(Mago,accion(buena,_,_)),
    not(realizo(Mago,accion(mala,_,_))).

esRecurrente(Accion) :-
    realizo(Mago,Accion),
    realizo(OtroMago,Accion),
    Mago \= OtroMago.

%  Punto 2
puntosTotalesDeUnaCasa(Casa,CantidadDePuntos) :-
    findall(Punto,puntosDeUnAlumnoDeUnaCasa(_,Casa,Punto),Puntos),
    sumlist(Puntos,CantidadDePuntos).


puntosDeUnAlumnoDeUnaCasa(Alumno,Casa,CantidadDePuntos) :-
    esDe(Alumno,Casa),
    sumatoriaDeAcciones(Alumno,buena,SumaDeBuenasAcciones),
    sumatoriaDeAcciones(Alumno,mala,SumaDeMalasAcciones),
    CantidadDePuntos is SumaDeBuenasAcciones - SumaDeMalasAcciones.

sumatoriaDeAcciones(Alumno,Tipo,Sumatoria) :-
    findall(Puntaje,realizo(Alumno,accion(Tipo,_,Puntaje)),Puntajes),
    sumlist(Puntajes,Sumatoria).

% Punto 3

ganoLaCopa(Casa) :-
    puntosTotalesDeUnaCasa(Casa,CantidadMaxima)
    forall(puntosTotalesDeUnaCasa(_,CantidadDePuntos), CantidadMaxima <= CantidadDePuntos).

% Punto 4
% respuesta(Pregunta,Profesor,Dificultado)

respondio(hermione,respuesta(dondeSeEncuentraBezoar,snape,20)).
respondio(hermione,respuesta(comoHacerLevitarUnaPluma,flitwick,25)).


