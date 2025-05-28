program ejercicio8;
type
    distrubucion = record 
        nombre: string;
        añoLanzamiento: integer;
        kernel:real;
        cantDesa:integer;
        descripcion:string;
    end;
    distribuciones= file of distrubucion;
{------------------Proceso ------------------} 
procedure inicializarArchivo(var arc:distribuciones);
var 
    r:distrubucion;
begin
// el primer registro lo inicializo con 0 para que sea mi registro cabezera 
    reset(arc);
    r.cantDesa:=0;
    write(arc,r);
    close(arc);
end;
function buscarDistribucion(var arc:distribuciones; nombre:integer):integer;
var
    r:distrubucion;
    encontre:boolean;
begin
    buscarDistribucion:=-1;
    reset(arc);
    encontre:=false;
    while(not EOF(arc)) and (not encontre)do begin
        read(arc,r);
        if(r.nombre = nombre) then begin
            buscarDistribucion:=filepos(m)-1; 
            encontre:=true;
        end;
    end;
    close(arc);
end;

procedure nuevaDistrubucion(var r:distrubucion);
begin
    writeln('ingrese el nombre de la distribucion');
    readln(r.nombre);
    writeln('ingrese el año de lanzamiento ');
    readln(r.añoLanzamiento);
    writeln('ingrese el numero de kernel');
    readln(r.kernel);
    writeln('ingrese la cantidad de desarolladores');
    readln(r.cantDesa);
    writeln('ingrese la descripcion');
    readln(r.descripcion);
end;

procedure altaDistribucion(var arc:distribuciones; r:distrubucion);
var 
    cabazera:distrubucion;
    posLibre:integer;
begin
    reset(arc);
    read(arc,cabazera); // leo el cabezera 
    if (cabazera.cantDesa = 0 ) then begin// si el cabecera es 0 tengo que agregar al final 
        seek(arc,filesize(arc));
        write(arc,r);
    end
    else
        begin
            // me posiciono libre
            posLibre:=(cabazera.cantDesa)*(-1);
            seek(arc,posLibre); 
            // leo para guardarme la posicion de cabezera
            read(arc,cabazera);
            // doy de alta la nueva distribucion 
            seek(arc,posLibre); // vuelvo a la posicion donde esta libre
            write(arc,r);
            // y ahora tengo que actualizar mi cabezera 
            seek(arc,0);
            write(arc,cabazera);
        end;
end;
procedure bajaDistribucion(var arc:distribuciones; pos:integer);
var 
    cabezera:distrubucion;
    baja:distrubucion;
begin
    reset(arc);
    read(arc,cabezera);// leo el cabezera 
    seek(arc,pos);// me posiciono a donde quiero eliminar
    // una vez que estoy ahi quiero ponerle la ubicacion del cabezera
    read(arc,baja);
    baja.cantDesa:=cabezera.cantDesa;
    seek(arc,filepos(arc)-1);
    write(arc,baja);
    //luego quiero actualizar donde esta el cabezera 
    seek(arc,0);
    cabazera.cantDesa:=-pos;
    write(arc,cabazera);// actualizo el cabazera con el ultimo eliminado pero negativo
end;
{------------------Program Principal ------------------} 
var 
    arc:distribuciones;
    tecla:integer;
    nombre:string;
    nuevo:distrubucion;
begin
    inicializarArchivo(arc);
    writeln('-------------------------------- Ingrese una opcion ------------------------------');
    writeln('1: Buscar Distribucion  | 2: Alta Distribucion | 3: Baja Distribucion  | 4: Salir ');
    writeln('----------------------------------------------------------------------------------');
    readln(tecla);
    while (tecla <> 4)do begin
        case tecla of 
            1:
                begin
                    writeln('ingrese el nombre a buscar');
                    readln(nombre);
                    pos:=buscarDistribucion(arc,nombre);
                    if(pos<>-1)then 
                        writeln('la distrubucion esta en la posicion', pos);
                    else 
                        writeln('la posicion no existe');
                end;
            2:
                begin
                    nuevaDistrubucion(nuevo);
                    pos:=buscarDistribucion(arc,nuevo.nombre);
                    if(pos=-1) then 
                        altaDistribucion(arc,nuevo);
                    else
                        writeln('ya existe la distrbucion');
                end;
            3:
                begin
                    writeln('Ingrese el nombre para dar de baja');
                    readln(nombre);
                    pos:= buscarDistribucion(arc,nombre);
                    if (pos<>- 1) then
                        bajaDistribucion(arc,pos);
                    else
                        writeln('no existe la distribucion');
                end;
        else
        begin
            writeln('Opcion invalida');
            writeln('-------------------------------- Ingrese una opcion ------------------------------');
            writeln('1: Buscar Distribucion  | 2: Alta Distribucion | 3: Baja Distribucion  | 4: Salir ');
            writeln('----------------------------------------------------------------------------------');
            readln(tecla);
        end;
    end;
end.