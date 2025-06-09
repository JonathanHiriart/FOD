program parcial4;
type 
    cliente=Record
        nombre:string;
        apellido:string;
        domicilio:string;
        telefono:integer;
    end;
    archivo= text;
procedure cargarCliente(var a:arc;);
var 
    cli:cliente;
begin
    reset(a);
    leerCliente(cli);
    while(cli.telefono<>0)do begin
        with cli do 
            begin
                write(a,nombre,'$',apellido,'$',domicilio,'$',telefono,'$','&');
            end;
        leerCliente(cli);
    end;
    close(a);
end;
procedure leer(var a:arc; var rm:cliente;);
var
    basura:string;
begin
    read(a,rm.nobmre);
    read(a,basura);
    read(a,rm.apellido);
    read(a,basura);
    read(a,rm.domicilio);
    read(a,basura);
    read(a,rm.telefono);
    read(a,basura);
    read(a,basura);
end;
procedure encontrarDireccionPorTelefono(var a:arc; tel:integer; var dire:integer; );
var 
    rm:cliente;
    encontre:boolean;
begin
    dire:=-1;
    reset(a);
    encontre:=false;
    while(not EOF(a)) and (not encontre)do begin
        leer(a,rm);
        if(rm.telefono= tel)then begin
            dire:=rm.domicilio;
            encontre:=true;
        end; 
    end;
end;
var 
    a:archivo;
    tel:integer;
    dire:string;
begin
    cargarCliente(a);
    readln(telefono);
    encontrarDireccionPorTelefono(a,tel,dire);
    if(dire<>-1)then
        writeln('no se encontro');
    else    
        writeln(dire);
end.