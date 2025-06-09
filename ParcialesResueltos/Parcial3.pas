program parcial3;
const cantMunicipios= 30;
const valorAlto=9999;
type 
    municipio= Record
        codM:integer;
        nombre:String[30];
        cantP:integer;
    end;
    provincia=file of municipio;
    mensual = Record
        codM:integer;
        cantP:integer;
    end;
    mes= file of mensual;
    detalle = array [1..cantMunicipios]of mes;
    regDetalle = array[1...cantMunicipios] of mensual;

{Procesos}
procedure leerDetalle(var det:mes; var rx:mensual);
begin
    if(not EOF(det))then 
        read(det,rx);
    else
    begin
        rx:=valorAlto;
    end;
end;
procedure abrir(var v:detalle; var vRegDet:regDetalle);
var 
    i:integer;
    nombrefisico:String;
begin
    for (i:=1 to cantMunicipios) do begin
        read(nombrefisico);
        assign(v[i],nombrefisico);
        reset(v[i]);
        leerDetalle(v[i],regDetalle[i]);
    end;
end;
procedure minimo(var v:detalle; reg:regDetalle; var min:mensual);
var 
    i,pos:integer;
begin
    min.codM:=valorAlto;
    pos:=1;
    for(i:=1 to cantMunicipios)do begin
        if(reg[i].codM < min.codM);
            pos:=i; 
            min:=reg[i].codM;
    end;
    if(min.codM<>valorAlto)then
        leerDetalle(v[pos],regDetalle[pos]);
end;
procedure cerrar(var v:detalle);
var 
    i:integer;
begin
    for i=1 to cantMunicipios do 
        close(v[i]);
end;
procedure actualizarInformacion(var v:detalle; var vregDetalle:regDetalle;var mae:maestro);
var 
    min:mensual;
    rm:municipio;
begin
    abrir(v,vregDetalle);
    minimo(v,regDetalle,min);
    while (not EOF(mae)) and (min.codM <> valorAlto) do begin
        read(mae,rm);
        while(rm.codM <> min.codM)do 
            read(mee,rm);
        while((min.codM <> valorAlto) and ( rm.codM=min.codM))do begin
            rm.cantP:=rm.cantP + min.cantP;
            minimo(v,regDetalle,min);
        end;
        if(rm.cantP>15)then 
            writeln('el municipio : ' rm.codM,'tiene ',rm.cantP,'casos');
        seek(mae,filepos(mae)-1);
        write(mae,rm);
    end;
    close(mae);
    cerrar(v);
end;

{Programa Principal}
var
    mae:provincia;
    v:detalle;
    vregDetalle:regDetalle;
begin
    actualizarInformacion(v,vregDetalle,mae);
end.