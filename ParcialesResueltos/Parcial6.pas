program parcial6;
type 
    tProducto = record
        codigo:integer;
        nombre:string[50];
        presentacion:string[100];
    end;
    tArchProductos = file of tProducto;

{Procedure}
procedure agregar(var a:tArchProductos; producto:tProducto);
var 
    cabecera:tProducto;
    pos:integer;
begin
    reset(a);
    read(a,cabecera);
    if(cabecera.codigo>0)then begin //agregar al final 
        seek(a,filesize(a));
        write(a,producto);
    end
    else begin
        pos:cabecera.codigo*(-1);
        seek(a,pos);
        read(a,cabecera);
        seek(a,0);
        write(a,cabecera);
        seek(a,pos);
        write(a,producto);
    end;
    close(a);
end;
function existe(var a:tArchProductos; codigo:integer):boolean;
var 
    ex:boolean;
    rm:tProducto;
begin
    ex:=false;
    reset(a);
    while(not EOF(a))and (not ex) do begin
        read(a,rm);
        if(rm.codigo=codigo)then
            ex:=true;
    end;
    close(a);
    existe:=ex;
end;
procedure eliminar(var a:tArchProductos; producto:tProducto);
var 
    cabecera,rm:tProducto;
    elimine:boolean;
    pos:integer;
begin
    if(existe(a,producto.codigo))then begin
        reset(a);
        read(a,cabecera);
        while(not elimine) do begin
            read(a,rm);
            elimine:=false;
            if(rm.codigo=producto.codigo)then begin
                pos:filepos(a)-1;
                seek(a,pos);
                write(a,cabecera);
                seek(a,0);
                rm.codigo:=pos*(-1);
                write(a,rm);
                elimine:=true;
            end;
        end;
        close(a);
    end;
end;

{Programa principal}
var
    arc:tArchProductos;
begin
    
end.