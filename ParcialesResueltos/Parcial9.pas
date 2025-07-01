program parcial9;
const 
    valorAlto= 99999;
    suc = 30;
type    
    venta = record 
        cod:integer;
        nom: string[40];
        fecha: string[29];
        cant:integer;
        fPago:string[10];
    end;
    arcVentas= file of venta;
    sucursales = array [1...suc] of arcVentas;
    vecDetalles = array [1...suc] of venta;
{procesos}
procedure leer(var det:arcVentas; var r:venta);
begin
    if(not EOF(det))then 
        read(det,r);
    else
        r.cod:= valorAlto;
    end;
end;
procedure minimo(var vArch:sucursales; var vecR:vecDetalles; var min:venta );
var 
    i,pos:integer;
begin
    min.cod:=valorAlto;
    min.fecha:=valorAlto;
    for i:=1 to suc do begin
        if((vecR[i].cod< min.cod)or          ((.vecR[i].cod=min.cod ) and(vecR[i].fecha < min.fecha)))then begin
            min.cod:=vecR[i].cod;
            min.fecha:=vecR[i].fecha;
            pos:=i;
        end;   
    end;
    if(min.cod<>valorAlto)then
        leer(vArch[pos],vecR[pos]);
end;
procedure inicializar(var vArch:sucursales; var vecR:vecDetalles);
var 
    i:integer;
begin
    for 1 to suc do begin
        reset(vArch[i]);
        leer(vArch[i],vecR[i]);
    end;
end;
procedure maxventas(act:integer;var max:integer;var cod:integer; codActual:integer);
begin
    if(act>max)then
        codmax:=codActual;
end;
procedure incisoAyC(var vecArc:sucursales);
var
    vecR:vecDetalles;
    min:venta;
    i:integer;
    nomActual:string[40];
    codigoActual,cantVendida,max,codmax,fechaActual:integer;
begin
    inicializar(vecArc,vecR);
    reset(txt);
    minimo(vecArc,vecR,min);
    while(min.cod<>valorAlto)do begin
        codigoActual:=min.cod;
        nomActual:=min.nom;
        write(txt,codigoActual);
        cantVendida:=0;
        while(min.cod=codigoActual)do begin
            fechaActual:=min.fecha;
            cantFecha:=0;
            while(min.cod=codigoActual) and (min.fecha = echaActual) do begin
                cantFecha:=cantFecha + min.cant;
                minimo(vecArc,vecR,min);
            end;
            cantVendida:=cantVendida + cantFecha;
            writeln(txt,codigoActual,' ',nomActual,' ',fechaActual,' ',cantFecha);
        end;
        maxventas(cantVendida,max,codmax,codigoActual);
    end;
    writeln('el codigo con mas ventas es ', codmax);
    for i:=1 to suc do begin
        close(vecArc[i]);
    end; 
end;
var 
    vec:sucursales;
    txt:TEXT;
    nom:string;
begin
    rewrite(txt);
    writeln('ingrese el nombre del resumen de las ventas');
    readln(nom);
    assing(txt,nom);

    incisoA(vec,txt);

end;
