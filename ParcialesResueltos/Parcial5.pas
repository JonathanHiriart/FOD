program parcial5;
type 
    prenda=record
        cod_prenda:integer;
        descripcion:string[30];
        colores:string;
        tipo_prenda:integer;
        stock:integer;
        precio_unitario:real;
    end;
    maestro=file of prenda; 
    prendas_eliminar= record
        cod_prenda:integer;
    end;
    nuevaTemporada = file of prendas_eliminar;

{Procesos}
procedure bajalogica(var m:maestro; var nt:nuevaTemporada);
var 
    rm:prenda;
    rd:prendas_eliminar;
    elimine:boolean;
begin
    reste(m);reset(nt);
    while(not EOF(nt)) do begin
        read(nt,rd);
        elimine:=false;
        seek(m,0);
        while(not elimine)and(not EOF(m))do begin
            read(m,rm);
            if(rd.cod_prenda=rm.cod_prenda)then begin
                elimine:=true;
                rm.stock:=-1;
                seek(m,filepos(m)-1);
                write(m,rm);
            end;
        end;
    end;
    close(m);close(nt);
end;
procedure compactar(var m:maestro);
var 
    pos:integer;
    rm:prenda;
begin
    reset(m);
    while(not eof(m))do begin
        read(m,rm);
        if(rm.stock<0)then begin
            pos:=filepos(m)-1;
            seek(m,filesize(m)-1);
            read(m,rm)
            if(filepos(m)-1<>0)then 
                while(rm.stock < 0)do begin // puede que el ultimo sea tambien una baja logica 
                    seek(m,filesize(m)-1);
                    truncate(m);
                    seek(m,filesize(m)-1);
                    read(m,rm);
                end;
            seek(m,pos);
            write(m,rm);
            seek(m,filesize(m)-1);
            truncate(m);
            seek(m,pos);
        end;
    end;
    close(m);
end;
{Programa principal}
var 
    mae:maestro;
    nt:nuevaTemporada;
begin
    assign(mae,'Temporada2024');
    assign(nt,'Temporada2025');
    bajalogica(mae,nt);
    compactar(mae);
end.
