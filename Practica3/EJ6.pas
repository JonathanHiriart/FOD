// 6.  Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con 
// la información correspondiente a las prendas que se encuentran a la venta. De cada 
// prenda  se  registra:  cod_prenda,  descripción,  colores,  tipo_prenda,  stock  y 
// precio_unitario.  Ante  un  eventual  cambio  de  temporada,  se  deben  actualizar  las 
// prendas  a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las 
// prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba 
// ambos archivos y  realice la baja lógica de las prendas, para ello deberá modificar el 
// stock de la prenda correspondiente a valor negativo. 
// Adicionalmente,  deberá  implementar  otro  procedimiento  que  se  encargue  de 
// efectivizar  las  bajas  lógicas  que  se  realizaron  sobre  el  archivo  maestro  con  la 
// información  de  las  prendas  a  la  venta.  Para  ello  se deberá utilizar una estructura 
// auxiliar (esto es, un archivo nuevo),  en el cual se copien únicamente aquellas prendas 
// que no están marcadas como borradas. Al finalizar este proceso de compactación 
// del archivo, se deberá renombrar el archivo nuevo con el nombre del archivo maestro 
// original. 
program ejercicio6; 
type 
    venta = record 
        cod:integer;
        descripcion:String;
        color:String;
        tipo:integer;
        stock:integer;
        precio:real;
    end;
    eliminarCod = file of integer;{me lo dan con info}
    maestro= file of venta;
{-----------------------Procesos-----------------------}
procedure eliminacion(var m:maestro; var e:eliminarCod);
var 
    rM:venta;
    cod:integer;
    bajaConfirmada:boolean;
begin
    reset(m);
    reset(e);
    while(not EOF(e))do begin
        read(e,cod);
        seek(m,0); {vuelvo al inicio del maestro porque no esta ordenado }
        bajaConfirmada:=false;
        while(not EOF(m)) and (not(bajaConfirmada))do begin
            read(m,rM);
            if(rM.cod = cod)then begin
                rM.stock:=-9999;
                seek(m,filepos(m)-1);
                write(m,rm);
                bajaConfirmada:=true;
            end;
        end;
    end;
    close(m);
    close(e);
end;
procedure actualizarMaestro(var m:maestro; var aux:maestro);
var
    rM:venta;
    rAux:venta;
begin
    reset(m);
    rewrite(aux);
    while(not EOF(m))do begin
        read(m,rM);
        if(rM.stock>-1)then
            write(aux,rM);        
    end;
    close(m);
    close(aux);
end;
{-----------------------Programa Principal-----------------------}

var 
    mae:maestro;
    eliminar:String;
    eCod:eliminarCod;
    aux:maestro;
begin
    assign(mae,'Ventas2024.dat');
    writeln('ingrese el nombre del archivo para dar debaja sus codigos');
    readln(eliminar);
    assign(eCod,eliminar);
    eliminacion(mae,eCod);
    assign(aux,'aux.dat');
    actualizarMaestro(mae,aux);
    erase(mae);
    rename(aux,'Ventas2024.dat');
end.
