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
            writeln(readEmpleado.nombre); 
            writeln(readEmpleado.apellido);
            writeln(readEmpleado.dni);
            writeln(readEmpleado.nroEmpleado);
            writeln(readEmpleado.edad);
            writeln('-------------');
        end;
    end;    
    close(arc_logico);
end;
procedure mayoresDe70(var arc_logico:archivo);
var 
    readEmpleado:empleado;
begin
    reset(arc_logico);
    writeln('las personas proximas a jubilarse/jubilados son:');
    while(not EOF(arc_logico))do begin
        read(arc_logico,readEmpleado);
        if(readEmpleado.edad>=65)then begin
             writeln('-------------');
            writeln(readEmpleado.nombre); 
            writeln(readEmpleado.apellido);
            writeln(readEmpleado.dni);
            writeln(readEmpleado.nroEmpleado);
            writeln(readEmpleado.edad);
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
begin
    writeln('ingresa el nombre del archivo');
    readln(arc_fisico);
    assign(arc_logico,arc_fisico);  
    rewrite(arc_logico);
    addEmpleado(inputEmpleado);
    while (inputEmpleado.apellido<>'fin') do begin
        write(arc_logico,inputEmpleado);
        addEmpleado(inputEmpleado);
    end;
    close(arc_logico);
    incisoB(arc_logico);
    mayoresDe70(arc_logico);
end.