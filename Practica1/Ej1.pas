// 1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
// incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
// cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
// archivo debe ser proporcionado por el usuario desde teclado.

// 2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
// creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
// promedio de los números ingresados. El nombre del archivo a procesar debe ser
// proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
// contenido del archivo en pantalla.

program Ej1;
type
    archivo = file of integer;

procedure Ejercico2(var arc_logico:archivo);
var
    nro:integer;
    cantMenores:integer;
    cantNumeros:integer;
    promedio:real;
    sumaTotal:integer;
begin
    cantMenores:=0;
    sumaTotal:=0;
    cantNumeros:=0;
    reset(arc_logico);
    writeln('-------------');
    while(not EOF(arc_logico))do begin
        read(arc_logico,nro);
        if(nro< 1500) then 
            cantMenores:=cantMenores +1;
        writeln(nro);
        sumaTotal:=sumaTotal + nro;
        cantNumeros:=cantNumeros + 1;
    end;
    writeln('-------------');
    promedio:=sumaTotal/cantNumeros;
    writeln('la cantidad de menores de 1500 es :',cantMenores);
    writeln('el promedio de los numeros ingresados es de: ',promedio);
    close(arc_logico);
end;
var 
    arc_logico:archivo;
    nro:integer;
    nom_fisico: string;
begin
    writeln('ingrese el nombre del archivo');
    readln(nom_fisico);
    assign(arc_logico,nom_fisico);
    rewrite(arc_logico);
    writeln('ingrese un numero que quiera agregar');
    readln(nro);
    while (nro<> 30000) do begin
        write(arc_logico,nro);
        read(nro);
    end;
    // imprimo para saber si esta bien 
    seek(arc_logico,0);
    while (not EOF(arc_logico)) do begin
        read (arc_logico,nro);
        writeln(nro);   
    end;
    close(arc_logico);
    Ejercico2(arc_logico);
end.