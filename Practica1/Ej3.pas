// 3. Realizar un programa que presente un menú con opciones para:

// a. Crear un archivo de registros no ordenados de empleados y completarlo con
// datos ingresados desde teclado. De cada empleado se registra: número de
// empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
// DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.

// b. Abrir el archivo anteriormente generado y
    // i. Listar en pantalla los datos de empleados que tengan un nombre o apellido
    // determinado, el cual se proporciona desde el teclado.

    // ii. Listar en pantalla los empleados de a uno por línea.

    // iii. Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
// NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.


// 4. Agregar al menú del programa del ejercicio 3, opciones para:

// a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
// teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
// un número de empleado ya registrado (control de unicidad).

// b. Modificar la edad de un empleado dado.

// c. Exportar el contenido del archivo a un archivo de texto llamado
// “todos_empleados.txt”.

// d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
// que no tengan cargado el DNI (DNI en 00).
// NOTA: Las búsquedas deben realizarse por número de empleado.



program Ej3;
type
    empleado = record
        nroEmpleado:integer;
        apellido:string;
        nombre:string;
        edad:integer;
        dni:integer;
    end;
    archivo=file of empleado;
procedure incisoB(var arc_logico:archivo);
var 
    readEmpleado:empleado;
begin
    reset(arc_logico);
    writeln('los empleados con nombre y apellidos son :');
    while(not EOF(arc_logico))do begin
        read(arc_logico,readEmpleado); 
        if (readEmpleado.nombre<> '') or ( readEmpleado.apellido<>'')then begin 
            writeln('-------------');
            writeln('Nombre:',readEmpleado.nombre); 
            writeln('Apellido:',readEmpleado.apellido);
            writeln('DNI:',readEmpleado.dni);
            writeln('Numero de Empleado:',readEmpleado.nroEmpleado);
            writeln('Edad:',readEmpleado.edad);
            writeln('-------------');
        end;
    end;    
    close(arc_logico);
end;
procedure jubilados(var arc_logico:archivo);
var 
    readEmpleado:empleado;
begin
    reset(arc_logico);
    writeln('las personas proximas a jubilarse/jubilados son:');
    while(not EOF(arc_logico))do begin
        read(arc_logico,readEmpleado);
        if(readEmpleado.edad>=65)then begin
            writeln('-------------');
            writeln('Nombre:',readEmpleado.nombre); 
            writeln('Apellido:',readEmpleado.apellido);
            writeln('DNI:',readEmpleado.dni);
            writeln('Numero de Empleado:',readEmpleado.nroEmpleado);
            writeln('Edad:',readEmpleado.edad);
            writeln('-------------');
        end;
    end;
    close(arc_logico);
end;
procedure addEmpleado(var inpEmpleado:empleado);
begin
    writeln('ingrese el apellido');
    readln(inpEmpleado.apellido);
    if (inpEmpleado.apellido <> 'fin')then begin
        writeln('ingrese el nombre');
        readln(inpEmpleado.nombre);
        writeln('ingrese el dni');
        readln(inpEmpleado.dni);
        writeln('ingrese la edad');
        readln(inpEmpleado.edad);
        writeln('ingrese el numero de empleado');
        readln(inpEmpleado.nroEmpleado);
    end;
end;
var
    arc_logico:archivo;
    arc_fisico:string;
    inputEmpleado:empleado;
    key:string;
    inputNroEmpleado:integer;
    readEmpleado:empleado;
    readEdad:integer;
    exportTxt:text;
    nameTxt:string;
begin
    writeln('ingresa el nombre del archivo');
    readln(arc_fisico);
    assign(arc_logico,arc_fisico);
    rewrite(arc_logico);  
    writeln('Bienvenido al sistema de archivos, que desea hacer? ');
    writeln('(A) Agregar empleados | (B) Modificar Empleado');
    writeln('(C) Exportar archivo  | (D) Exportar archivos incompletos ');
    writeln('(E) Listar Empleados  | (F) Listar Jubilados');
    writeln('(X) Salir');
    readln(key);
    while (key <> 'X') and (key <> 'x') do begin 
        if (key = 'A') or (key = 'a') then begin // agregar empleados al final 
            reset(arc_logico);
            while (not EOF(arc_logico))do 
                seek(arc_logico,filepos(arc_logico)+1);// me posiciono al final para no perder data 
            addEmpleado(inputEmpleado);
            while (inputEmpleado.apellido<>'fin') do begin
                write(arc_logico,inputEmpleado);
                addEmpleado(inputEmpleado);
            end;
            close(arc_logico);
        end;
        if (key = 'B')or(key='b')then begin // modificar edad de empleado
            reset(arc_logico);
            writeln('ingrese el numero de empleado para modificar');
            readln(inputNroEmpleado);
            writeln('buscando el empleado aguarde ...');
            while(not EOF(arc_logico))do begin
                read(arc_logico,readEmpleado);
                if (readEmpleado.nroEmpleado= inputNroEmpleado)then begin
                    writeln('Se encontro el empleado. Ingrese la edad a modificar');
                    readln(readEdad);
                    readEmpleado.edad:=readEdad;
                    seek(arc_logico,filepos(arc_logico)-1);
                    write(arc_logico,readEmpleado);
                    break;
                end;
            end;
            close(arc_logico);
        end;
        if (key= 'E')or (key ='e')then begin
            incisoB(arc_logico);
        end;
        if (key= 'F')or (key = 'f') then begin
            jubilados(arc_logico);
        end;
        if (key= 'C') or (key='c')then begin // exportacion de archivos 
            nameTxt:='todos_empleados.txt';
            assign(exportTxt,nameTxt);
            rewrite(exportTxt); // creo el archivo de txt
            reset(arc_logico);// abro el archivo binario
            while (not EOF(arc_logico))do begin 
                read(arc_logico,readEmpleado);
                writeln(exportTxt,readEmpleado.nombre,' ',readEmpleado.apellido,' ',readEmpleado.dni,' ',readEmpleado.nroEmpleado,' ',readEmpleado.edad);
            end;
            close(arc_logico);
            close(exportTxt);
        end;
        if (key='D')or (key='d')then begin // exportar empleados que les falte el dni 
            nameTxt:='faltaDNIEmpleado.txt';
            assign(exportTxt,nameTxt);
            rewrite(exportTxt);
            reset(arc_logico);
            while(not EOF(arc_logico))do begin
                read(arc_logico,readEmpleado);
                if (readEmpleado.dni=00)then
                writeln(exportTxt,readEmpleado.nombre,' ',readEmpleado.apellido,' ',readEmpleado.dni,' ',readEmpleado.nroEmpleado,' ',readEmpleado.edad);
            end;
            close(arc_logico);
            close(exportTxt);
        end;
        writeln('ingrese una opcion');
        writeln('(A) Agregar empleados | (B) Modificar Empleado');
        writeln('(C) Exportar archivo  | (D) Exportar archivos incompletos ');
        writeln('(E) Listar Empleados  | (F) Listar Jubilados');
        writeln('(X) Salir');
        readln(key);
    end;
end.