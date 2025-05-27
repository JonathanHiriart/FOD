program ejercicio2Parte2;
const valorAlto= 99999999;
type
    mesas= record 
        codLocalidad:integer;
        numMesa:integer;
        cantVotos:integer;
    end;
    archivo= file of mesas;
    aux =file of integer;
procedure leerMesa(var m:archivo; var r:mesas);
begin
    if (not EOF(m))then 
        read(m,r);
    else
    begin
        r.codLocalidad:=valorAlto;
    end;
end;
function codigoProcesado(cod:integer; var a:aux):boolean;
var
    codigosProcesados:integer;
begin
    reset(a);
    codigoProcesado:=false;
    while(not EOF(a))and (not codigoProcesado) do begin
        read(a,codigosProcesados);
        if(cod = codigosProcesados)then
            codigoProcesado:=true;
    end;
    if(codigoProcesado = false)then begin 
        seek(a,filepos(a));
        write(a,cod);   
    end;
    close(a);
end;
procedure contabilizar(var m:archivo);
var 
    a:aux;
    actual:integer;
    totalVotos:integer;
    rM:mesas;
    pos:integer;
    termine:boolean;
    totalGeneral:integer;
begin
    assign(a,'procesados.dat');
    rewrite(a);
    reset(m);
    totalGeneral:= 0;
    while(not EOF(m)) do begin
        pos:=filepos(m);
        read(m,rM);
        actual:=rM.codLocalidad;
        totalVotos:=0;
        if (not codigoProcesado(actual,a))then begin
            seek(m,0);{ reseto porque me voy a perder comparaciones }
            while(not EOF(m))do begin
                read(m,rM);
                if(rM.codLocalidad = actual) then
                    totalVotos:= totalVotos + rM.cantVotos;
            end;
            {si salgo ya procese todo mi codigo actual}
            {imprimo }
            writeln('la localidad con codigo ',actual,' tuvo ',totalVotos,'votos ' );
            totalGeneral:= totalGeneral + totalVotos;
        end;
        seek(m,pos+1);
    end;
    writeln('El total de votos fue',totalGeneral);
    close(a);
    close(m);
end;
var 
    mae:archivo;
begin
    assign(mae,'mesas.dat');
    contabilizar(mae);
end;