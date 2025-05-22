// El encargado de ventas de un negocio de productos de limpieza desea administrar el stock
// de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los
// productos que comercializa. De cada producto se maneja la siguiente información: código de
// producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se
// genera un archivo detalle donde se registran todas las ventas de productos realizadas. De
// cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide
// realizar un programa con opciones para:
// a. Actualizar el archivo maestro con el archivo detalle, sabiendo que:
// ● Ambos archivos están ordenados por código de producto.
// ● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del
// archivo detalle.
// ● El archivo detalle sólo contiene registros que están en el archivo maestro.
// b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo
// stock actual esté por debajo del stock mínimo permitido.
program Ejercicio2;
type
    producto=record
        codProducto:integer;
        nombreComercial:string;
        precio:real;
        stockActual:integer;
        stockMin:integer;
    end;
    ventas= record
        codProducto:integer;
        cantUnidadesVendidas:integer;
    end;
    maestro=file of producto;
    detalleDiario=file of ventas;
{Modulos}
procedure actualizarMaestro(var mae:maestro; var det:detalleDiario;);
var 
    rMaestro:producto;
    rDetelle:ventas;
begin
    reset(mae);reset(det);
    while(not EOF(det))do begin
        read(mae,rMaestro);
        read(det,rDetelle);
        while(rMaestro.codProducto<>rDetelle.codProducto)do 
            read(det,rDetelle);
        while(not EOF(det))and (rMaestro.codProducto = rDetelle.codProducto ) do begin
            rMaestro.stockActual:=rMaestro.stockActual- rDetelle.cantUnidadesVendidas;{si son iguales acutalizo el stock}
            read(det,rDetelle);{avanzo }
        end;    
        if (not EOF(det))then {defazado}
            seek(det,filepos(det)-1);
        seek(mae,filepos(mae)-1);
        write(mae,rMaestro);
    end;
    close(det);
    close(mae);
end;
procedure agregarListaDeStockMin(var stockMinimo:Text; var mae:maestro;);
var
    rMaestro:producto;
begin
    reset(stockMinimo);
    reset(mae);
    while (not EOF(mae))do begin
        read(mae,rMaestro);
        if (rMaestro.stockActual<rMaestro.stockMin)then 
            with prod do 
                writeln(stockMinimo,codProducto,' ',nombreComercial,' ',precio,' ',stockMin,' ',stockActual);
    end;
    close(mae);
    close(stockMinimo);
end;
{Program Principal}
var
    mae:maestro;
    detDiario:detalleDiario;
    stockMinimo:Text;
begin
    assing(mae,'Maestro');
    assing(detalleDiario,'DetalleDiario');
    assing(stockMin,'stock_minimo.txt');
    actualizarMaestro(mae,detalleDiario);
    agregarListaDeStockMin(stockMinimo,mae);
end.