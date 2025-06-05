program Parcial1;
type
    profesional=Record
        Dni:Integer;
        nombre:String[20];
        apellido:String[20];
        sueldo:Real;
    end;
    tArchivo= File of profesional;
{----------------------------------Procesos ----------------------------------}    
procedure crear(var arch: tArchivo; var info:text);
var 
    rm:profesional;
begin
    rewrite(arch);
    rm.Dni:=0;
    rm.nombre:='';
    rm.apellido:='';
    rm.sueldo:=0;
    write(arc,rm );
    reset(info);
    while (not EOF(info))do begin
        read(rm.Dni);
        read(rm.nombre);
        read(rm.apellido);
        read(rm.sueldo);
        agregar(arch,rm);
    end;
end;

procedure agregar(var arch:tArchivo; var p:profesional);
var
    pos:profesional;
    aux:profesional;
begin
    seek(arch,0); // me posiono en el cabecera 
    read(arch,pos);
    // si es positiva o 0 es decir que no hay espacios eliminados 
    if(pos.Dni=0) then begin
        seek(arch,filesize(arch));
        write(arch,p); // si es 0 es decir que mi cabecera 
    end 
    // si no hay espacios eliminados tengo que ir a la posicion cabecera
    else 
        begin
            pos.Dni:= pos.Dni*(-1);
            seek(arc,pos.Dni);
            // actualizar el cabecera 
            read(arc,aux);
            seek(arc,0);
            write(arc,aux);
            // escribir
            seek(arc,pos.dni);
            write(arc,p);
        end;
end;
procedure eliminar(var arc:tArchivo; dni:Integer; var bajas:text);
var
    aux:profesional;
    encontre:boolean;
    pos:integer;
    cabecera:profesional;
begin
    reset(arc);
    encontre:=false;
    // leo la cabecera 
    read(arc,cabecera);

    while(not EOF(arc)) and (not encontre)do begin
        read(arc,aux);
        if(aux.Dni = dni )then begin 
            encontre:=true;
            pos:=filepos(arc)-1;
            aux.dni:=cabacera.Dni;

            seek(arc,filepos(arc)-1); // vuelvo a la posicion a eliminar
            write(arc,aux);

            seek(arc,0); // actualizo el cabecera
            cabecera.dni:=pos*(-1);
            write(arc,cabacera);

            // actualizar bajas 
            reset(bajas);
            seek(bajas,filesize(bajas));
            writeln(bajas,dni);
        end;
    end;

end;
{----------------------------------Programa Principal----------------------------------}
var
begin

end.