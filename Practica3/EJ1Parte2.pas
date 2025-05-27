program ejercicio1Parte2;
type
    producto = record 
        cod:integer;
        nombre:string;
        stockA:integer;
        stockM:integer;
    end;
    maestro = file of producto;
    ventas = record     
        cod:integer;
        cantVentas:integer;
    end;
    detalle= file of ventas;
{---------------Procesos---------------}
procedure actualizarMaestroIncisoA(var m:maestro; var v:detalle);
var 
    rM:producto;
    rV:ventas;
    actual:producto;
begin
    reset(m);
    reset(v); 
    while(not EOF(m))do begin
        read(m,rM);
        actual:=rM;
        while(not EOF(v))do begin
            read(v,rV);
            if(rV.cod=actual.cod)then 
                actual.stockA:=actual.stockA- rV.cantVentas;
        end;
        {actualizo el maestro }
        seek(m,filepos(m)-1);
        write(m,actual);
    end;
    close(m);
    close(v);
end;
procedure actualizarMaestroIncisoB(var m:maestro; var v:detalle);
var 
    rm:producto;
    rv:ventas;
    actualize:boolean;
begin
    reset(m);
    reset(v);
    while(not EOF(v))do begin
        read(r,rv);
        actualize:=false;
        while(not EOF(m) and (not actualize)) do begin
            read(m,rm);
            if(rv.cod= rm.cod)then begin
                rm.stockA:=rm.stockA - rv.cantVentas;
                actualize:=true;
            end;
        end;
    end;
end;

{---------------Programa Principal---------------}
var
    m:maestro;
    v:detalle;
begin
    assign(m,'maestro');
    assign(v,'ventas');
    actualizarMaestroIncisoA(m,v);
    actualizarMaestroIncisoB(m,v);


end.