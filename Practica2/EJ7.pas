program ejercicio7;
const alto = 99999;
type
    alumno = record
        codAlumno:integer;
        apellido:string;
        nombre:string;
        cantCursadasA:integer;
        cantMateriasFinalA:integer;
    end;

    cursada= record
        codAlumno:integer;
        codMateria:integer;
        añoCursada:integer;
        resultado:integer;
    end;

    final = record
        codAlumno:integer;
        codMateria:integer;
        fechaExamen:integer;
        nota:real;
    end;

    maestros = file of alumno;
    cursadas = file of cursada;
    finals = file of final;
{---------------- Procesos --------------------}
procedure leerCursada(var c:cursadas; var rCursada:cursada);
begin
    if(not EOF(c)) then
        read(c,rCursada);
    else
        rCursada.codAlumno:= alto;
end;

procedure leerFinal(var f:finals; var rFinal:final);
begin
    if (not EOF(f))then
        read(f,rFinal);
    else 
        rFinal.codAlumno:= alto;
end;

procedure actualizarMinimo(var c:cursadas; var f:finals; var rCursada:cursada; var rFinal:final; var codMin:integer );
begin
    if(rCursada.codAlumno < rFinal.codAlumno) or 
    ((rCursada.codAlumno = rFinal.codAlumno) and (rCursada.codMateria< rFinal.codMateria))then begin
        codMin:= rCursada.codAlumno;
        leerCursada(c,rCursada);
    end
    else
    begin
        codMin:=rFinal.codAlumno;
        leerFinal(f,rFinal);
    end;
end;
{----------------Programa Principal--------------------}
var
    mae:maestros;
    cur:cursadas;
    f:finals;
   
    reg_maestro:alumno;
    rC:cursada;
    rF:final;

    codMin:integer;
    totalFinales:integer;
    totalCursadas:integer;
    codActual:integer;  
    actulice:boolean;

begin
    reset(mae);
    reset(cur);
    reset(f);
    leerCursada(cur,rC);
    leerFinal(f,rF);
    codMin:=0;
    actualizarMinimo(cur,f,rC,rF,codMin);
    while(codMin <> alto)do begin
        totalCursadas:=0;
        totalFinales:=0;
        codActual:=codMin;
        // proceso las cursadas 
        while(rC.codAlumno = codActual)do begin
            if(rC.resultado>=4)then
                totalCursadas:=totalCursadas + 1;
            leerCursada(cur,rC);
        end;
        // proceso finales
        while(rF.codAlumno = codActual) do begin
            if(rF.nota >= 4)then
                totalFinales:=totalFinales + 1;
            leerFinal(f,rF);
        end;
        // si sali de los 2 proceso es decir que cambie de alumno y procese todos los finales y cursada 
        actulice:=false;
        while(not EOF(mae)) and (not actulice) do begin
            read(mae,reg_mae);
            if(codActual=reg_mae.codAlumno)then begin
                reg_mae.cantCursadasA:= reg_mae.cantCursadasA + totalCursadas;
                reg_mae.cantMateriasFinalA:= reg_mae.cantMateriasFinalA + totalFinales;
                seek(mae,filepos(mae)-1);
                write(mae,reg_mae);
                actulice:=true;
            end;
        end;
        actualizarMinimo(cur,f,rC,rF,codMin);
    end;
end;