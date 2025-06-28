program parcial8;
const valorAlto= 88888888;
type 
    tVta = record 
        codSucursal:integer;
        idAutor:integer;
        isbn:integer;
        idEj:integer;
    end;
    tArchVtas= file of tVta;
{procesos}
procedure leer(var a:tArchVtas;var r:tVta);
begin
    if(not EOF(a))then
        read(a,r);
    else
        r.codSucursal:=valorAlto;
end;
procedure totalizar(var a:tArchVtas; var txt:TEXT; nom:string);
var 
    totEjVendidos:integer;
    ventAutor:integer;
    cantSuc:integer;
    total:integer;
    rm:tVta;
    act:tVta;
begin
    assing(txt,nom);
    rewrite(txt);
    reset(a);
    leer(a,rm);
    total:=0;
    while(rm.codSucursal<>valorAlto)do begin
        writeln(txt,'Codigo de sucursal: ',rm.codSucursal);
        act.codSucursal:=rm.codSucursal;
        cantSuc:=0;
        while(act.codSucursal=rm.codSucursal) do begin
            writeln(txt,'Identificador de autor: ',rm.idAutor);
            act.idAutor:=rm.idAutor;
            ventAutor:=0;
            while(act.codSucursal=rm.codSucursal)and (act.idAutor=rm.idAutor)do begin
                act.isbn:=rm.isbn;
                totEjVendidos:=0;
                while(act.codSucursal=rm.codSucursal)and (act.idAutor=rm.idAutor)and (act.isbn= rm.isbn)do begin
                    totEjVendidos:=totEjVendidos + 1;
                    leer(a,rm);
                end;
                writeln('ISBN: ',act.isbn,'total de ejemplares vendidos:',totEjVendidos);
                ventAutor:=ventAutor+ totEjVendidos;
            end;
            writeln('total de ejemplares vendidos del autor:', ventAutor);
            cantSuc:=cantSuc+ ventAutor;
        end;
        writeln('total de ejemplares vendidos en la sucursal: ',cantSuc);
        total:=total + cantSuc;
    end;
    writeln('total general de ejemplares vendidos en la cadena:',total);
end;
var 
    arch:tArchVtas;
    txt:TEXT;
    nombre:string;
begin
    writeln('ingrese el nombre del archivo');
    readln(nombre);
    totalizar(arch,txt,nombre);
end;

