program parcial7;
const 
    N= 25;
    valorAlto = 9999999;
type
    venta = record
        nticket:integer;
        cod:integer;
        cant:integer;
    end;
    producto = record
        cod:integer;
        descripcion:string[100];
        stock:integer;
        minStock:integer;
        precio:real;
    end;
    ventas=file of venta;
    cajas = array[1...N]of ventas;
    regDetalle = array[1...N] of venta;
    maestro = file of producto; 
{procesos}
procedure leer(var det:ventas; var r:venta);
begin
    if(not EOF(det)) then
        read(det,r);
    end 
    else    
        r.cod:= valorAlto;
end;
procedure inicializar(var v:cajas);
var 
    i:integer;
begin
    for i:=1 to N  do begin
        reset(v[i]);
        leer(v[i],rv[i]);
    end;
end;
procedure minimo(var v:cajas; var rv:regDetalle; var min:venta);
var 
    i,pos:integer;
begin
    min.cod:= valorAlto;
    pos:=valorAlto;
    for i:=1 to N do begin
        if(rv[i].cod< min.cod) then begin
            min:=rv[i];
            pos:=i;
        end;
        if(min.cod<>valorAlto)then
            leer(v[pos],rv[pos]);
    end;

end;
procedure actualizarMaestro(var m:maestro; var v:cajas; var rv:regDetalle);
var 
    rm:producto;
    min:venta;
    totVenta: integer;
    montoTotal:real;
begin
    inicializar(v,rv);
    reset(m);
    minimo(v,rv,min);
    montoTotal:=0;
    while(min<>valorAlto)do begin

        while(rm.cod<>min.cod)do begin
            read(m,rm);
        totVenta:=0;
        while(min.cod<>valorAlto) and (min.cod=rm.cod)do begin
            if((rm.stock-min.cant) > 0)then
                rm.stock:=rm.stock-min.cant;
                totVenta:=totVenta + min.cant;
            minimo(v,rv,min);
        end;
        montoTotal:=montoTotal + (totVenta*rm.precio);
        if(rm.stock > m.minStock) then
            writeln(rm.cod,'el producto dispone de stock');
        else
            writeln(rm.cod,'el producto no dispone de stock');
        writeln('nombre',rm.cod,'monto total facturado',totVenta*rm.precio)
        seek(m,filepos(m)-1);
        write(m,rm);
    end;
    writeln('el monto total vendido',montoTotal)
end;
var 
    v:cajas;
    rv:regDetalle;
    mae:maestro;
begin
    actualizarMaestro(mae,v,rv);
end;