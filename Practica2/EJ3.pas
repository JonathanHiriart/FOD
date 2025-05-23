program Ejercicio3;
const valorAlto = 'zzz';
type 
    censoGeneral=record
        nombreProvincia:string;
        cantidadAlfabetos:integer;
        totalEncuestas: integer;
    end;
    censoEmpresa=record
        nombreProvincia:string;
        codigoLocalidad:integer;
        cantidadAlfabetos:integer;
        cantidadEncuestas:integer;
    end;
    detalle = file of censoEmpresa;
    maestro = file of censoGeneral;
{Los archivos estan organizados por nombre Provincia y en los archivos detalles pueden venir mas registros por provincia}
// -------------Procesos-------------------
procedure leerDetalle(var archivo: detalle; var regDetalle:censoEmpresa );
begin
    if(not EOF(archivo))then
        read(archivo,regDetalle);
    else
        regDetalle.nombre = valorAlto;
end;

procedure actualizarMinimo(var det1,det2: detalle; var dato1,dato2:censoEmpresa; var min: censoEmpresa );
begin
    if(dato1.nombreProvincia<= dato2.nombreProvincia) then begin 
        min:=dato1;
        leerDetalle(det1,dato1);
    end
    else begin
        min:=dato2;
        leerDetalle(det2,dato2);
    end;
end;

// -------------Programa Principal-------------------
var 
    mae: maestro;
    reg_mae:censoGeneral;
   
    det1: detalle;
    det2:detalle;
    reg_det1:censoEmpresa;
    reg_det2:censoEmpresa;
    
    min:censoEmpresa;
    datosProvincia:censoGeneral;
    rescribir:boolean;

begin
    assign(mae,'maestro');
    assign(det1,'censoEmpresa1');
    assign(det2,'censoEmpresa2');
    reset(mae);
    reset(det1);
    reset(det2);

    leerDetalle(det1,reg_det1);
    leerDetalle(det2,reg_det2);
    actualizarMinimo(det1,det2,reg_det1,reg_det2,min);
    while(min.nombreProvincia <> valorAlto)do begin

        datosProvincia.cantidadAlfabetos:=0;
        datosProvincia.cantidadEncuestas:=0;
        datosProvincia.nombreProvincia:=min.nombreProvincia;

        while(min.nombreProvincia = datosProvincia.nombreProvincia)do begin

            datosProvincia.cantidadAlfabetos:=datosProvincia.cantidadAlfabetos + min.cantidadAlfabetos;
            datosProvincia.cantidadEncuestas:=datosProvincia.cantidadEncuestas + min.cantidadEncuestas;
            actualizarMinimo(det1,det2,reg_det1,reg_det2,min);
        end;
        rescribir:=false;
        {si salgo es porque tengo que actualizar el maestro}
        while(not EOF(mae)) and (not rescribir) do begin
            read(mae,reg_mae);
            if(reg_mae.nombreProvincia=datosProvincia.nombreProvincia)then begin 
                reg_mae.cantidadAlfabetos:=reg_mae.cantidadAlfabetos + datosProvincia.cantidadAlfabetos;
                reg_mae.cantidadEncuestas:=reg_mae.cantidadEncuestas + datosProvincia.cantidadEncuestas;
                // rescribir el registro 
                seek(mae,filepos(mae)-1);
                write(mae,reg_mae);
                rescribir:=true;
            end;
        end;
    end;
    close(det1);
    close(det2);
    close(mae);
end.