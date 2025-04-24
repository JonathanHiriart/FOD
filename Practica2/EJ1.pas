// Una empresa posee un archivo con información de los ingresos percibidos por diferentes
// empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
// nombre y monto de la comisión. La información del archivo se encuentra ordenada por
// código de empleado y cada empleado puede aparecer más de una vez en el archivo de
// comisiones.
// Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En
// consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
// única vez con el valor total de sus comisiones.
// NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
// recorrido una única vez.
program Ejercicio1;
type 
    comision = record 
        codEmpleado: integer;
        nombre:string;
        monto:real;
    end;
    totalComision = record 
        codEmpleado:integer;
        nombre:string;
        total:real;
    end
    detalle =file of comision;{Archivo dado}
    maestro = file of totalComision; { Archivo solicitado}
procedure comprimirArchivo(var det1:detalle; var mae1:maestro);
var 
    rDet:comison;
    rMae:maestro;
begin
    reset(mae1);
    reset(det1);
    while (not EOF(det1))do begin
        read(mae1,rMae);
        read(det1,rDet);
        while (rMae.codEmpleado<>rDet.codEmpleado) do {como esta organizado por codigo de empleado}
            read(mae1,rMae);{si es distinto tengo leer el sig}
        while(not EOF(det1)) and (rMae.codEmpleado= rDet.codEmpleado)do begin
            rMae.total:=rMae.total + rDet.monto;
            read(det1,rDet);{leo el siguiente}
        end;
        if (not EOF(det1)) {verifico si no termine el archivo detalle }
            seek(det1,filepos(det1)-1){si no es asi entonces me hago uno para atras por que me quedaria defazado }
        seek(mae1,filepos(mae1)-1);{ aca sucede lo mismo }
        write(mae1,rMae);
    end;
    end.
end;
var {Programa Principal}
    det1:detalle;
    mae1:maestro;
begin
    assing(det1,'Detalle');
    assing(mae1,'Maestro');
    comprimirArchivo(det1,mae1);
end.