// 2.  Definir un programa que genere un archivo con registros de longitud fija conteniendo 
// información  de  asistentes  a  un  congreso  a  partir  de  la  información  obtenida  por 
// teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y 
// nombre,  email,  teléfono  y  D.N.I.  Implementar  un  procedimiento  que,  a  partir  del 
// archivo de datos generado, elimine de forma lógica todos los asistentes con nro de 
// asistente inferior a 1000.  
// Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo 
// String a su elección.  Ejemplo:  ‘@Saldaño’.

program ejercicio2;
type 
    asistencia = record
        nroAsistente:integer;
        apellido:String[15];
        nombre:String[15];
        email:String[30];
        telefono:integer;
        dni:integer;
    end;
    archivo = file of asistencia;
{---------------------Procesos--------------------- }
procedure leerAsistente(var a: asistencia);
begin
    writeln('Ingrese un numero del asistente');
    readln(a.nroAsistente);
    if(a.nroAsistente <> -1) then begin
        writeln('Ingrese el apellido del asistente');
        readln(a.apellido);
        writeln('Ingrese el nombre del asistente');
        readln(a.nombre);
        writeln('Ingrese el email del asistente');
        readln(a.email);
        writeln('Ingrese el telefono del asistente');
        readln(a.telefono);
        writeln('Ingrese el dni del asistente');
        readln(a.dni);
    end;
end;
procedure crearArchivo(var m: archivo);
var
    a: asistencia;
begin
    assign(m,'AsistenciaCongreso');
    rewrite(m);
    leerAsistente(a);
    while(a.nroAsistente <> -1) do
        begin
            write(m, a);
            leerAsistente(a);
        end;
    close(m);
end;

procedure borrar(var m:archivo);
var
    r:asistencia;
begin
    reset(m);
    while (not EOF(m))do begin
        read(m,r);
        if(r.nroAsistente<1000)then begin
            r.nombre:='@'+ r.nombre;
            seek(m,filepos(m)-1);
            write(m,r);
        end
    end;
    close(m);
end;
procedure imprimirAsistente(a: asistente);
begin
    writeln('Numero: ', a.nroAsistente, ' Apellido: ', a.apellido, ' Nombre: ', a.nombre, ' DNI: ', a.dni);
end;
procedure imprimir(var m: archivo);
var
    a: asistente;
begin
    reset(m);
    while(not eof(m)) do
        begin
            read(m, a);
            imprimirAsistente(a);
        end;
    close(m);
end;
{---------------------Programa Principal--------------------- }
var 
    mae:archivo;
begin
    crearArchivo(mae);
    
    writeln('archivo original'); 
    imprimir(mae);
    
    writeln('archivo despues de la eliminacion');
    borrar(mae);
    imprimir(mae);
end;