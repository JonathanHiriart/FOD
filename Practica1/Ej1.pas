// 1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
// incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
// cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
// archivo debe ser proporcionado por el usuario desde teclado.

program Ej1;
type
    archivo = file of integer;
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
end.