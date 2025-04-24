// 5.  Realizar  un  programa  para  una  tienda  de  celulares,  que  presente  un  menú  con 
// opciones para: 
// a.  Crear un archivo de registros no ordenados de celulares y cargarlo con datos 
// ingresados desde un archivo de texto denominado “celulares.txt”. Los registros 
// correspondientes  a  los celulares deben contener: código de celular, nombre, 
// descripción, marca, precio, stock mínimo y stock disponible. 
// b.  Listar en pantalla los datos de aquellos celulares que tengan un stock menor al 
// stock mínimo. 
// c.  Listar  en  pantalla  los  celulares  del  archivo  cuya  descripción  contenga  una 
// cadena de caracteres proporcionada por el usuario. 
// d.  Exportar el archivo creado en el inciso a) a un archivo de texto denominado 
// “celulares.txt” con todos los celulares del mismo. El archivo de texto generado 
// podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que 
// debería respetar el formato dado para este tipo de archivos en la NOTA 2. 
 
// NOTA  1:  El  nombre  del  archivo  binario  de  celulares debe ser proporcionado por el 
// usuario. 
// NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique 
// en tres  líneas consecutivas. En la primera se especifica: código de celular,  el precio y 
// marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera 
// nombre  en  ese  orden.  Cada  celular  se  carga  leyendo  tres  líneas  del  archivo 
// “celulares.txt”. 

program Ejercicio5;
type 
    celular = record 
        codCelular : integer;
        nombre:string; 
        det:string;
        marca: string;
        precio:real;
        stockMin:integer;
        stockActual:integer;
    end
    archivo= file of celular;

// Procesos 
// ------------------------- inciso A -------------------------
procedure crearArchivo(var input:Text; var arLogico:archivo);
var 
    nameArchivo:string;
    celu:celular;
begin
    writeln('ingrese el nombre del nuevo Archivo');
    readln(nameArchivo);
    assign(arLogico,nameArchivo); 
    rewrite(arLogico);// creo el archivo de registros 
    reset(input);// abro el archivo otorgrado
    while(not EOF(input))do begin 
        with celu do 
        begin
            readln(input,codCelular,precio,marca);
            readln(input,stock,stockMin,det);
            readln(input,nombre);
            write(arLogico,celu);
        end;
    end;
    writeln('archivo cargado correctamente');
    close(input);
    close(arLogico);
end;
// ------------------------- inciso B -------------------------
procedure imprimirCelular(c: celular);
begin
    with c do
        writeln('Codigo=', codigo, ' Nombre=', nombre, ' Descripcion=', descripcion, ' Marca=', marca, ' Precio=', precio:0:2, ' StockMin=', stockMin, ' Stock=', stock);
end;

procedure listarMin(var arc:archivo );
var
    celu:celular;
begin
    reset(arc);
    while(not EOF(arc))do begin
        read(arc,celu);
        if (c.stock<c.stockMin)then 
            imprimirCelular(celu);
    end;
    close(arc);
end;
// ------------------------- inciso C -------------------------
procedure listaMismaDescripcion(var arc:archivo; );
var 
    des:string;
    c:celular;
begin
    reset(arc);
    writeln('ingrese la despcion para buscar similitudes');
    readln(des);
    while(not EOF(arc))do begin
        read(arc,c);
        if (c.det=des) then
            imprimirCelular(c);
    end;
    close(arc);
end;
procedure exportarArchivo(var arc:archivo; var exportar:Text);
var  
    c:celular;
begin
    reset(arc);
    rewrite(exportar); // tengo que sobreescribir
    while (not EOF(arc))do begin
        read(arc,c);
        with c do
            writeln(exportar, codCelular, '',precio,'',marca); 
            writeln(exportar,stock,'',stockMin,'',det);
            writeln(exportar,nombre);
        end;
    end;
    close(arc);
    close(exportar);
end;
// Programa principal 
var 
    nameTxt:String;
    key:char;
    arLogicoInput:Text;
    archivoCreado:archivo;
begin
    nameTxt:='Celulares.txt';
    assign(nameTxt,arLogicoInput); // asigno el archivo otorgado por el usuario 
    writeln('Bienvenido a la tienda de celulares, que desea hacer? ');
    writeln('(A) Crear Archivos | (B) Listar celulares menor al stock minimo');
    writeln('(C) Lista celular con misma informacion | (D) Exportar archivos creado ');
    writeln('(X) Salir');
    readln(key);
    while (key<> 'x')or (key<>'X') do beign 
        case key of 
            a,A : crearArchivo(arLogicoInput,archivoCreado); 
            b,B: listarMin(archivoCreado);
            c,C: listaMismaDescripcion(archivoCreado);
            d,D: exportarArchivo(archivoCreado,arLogicoInput);
        else
        begin
            writeln('opcion invalida ingrese nuevamente');
            writeln('(A) Crear Archivos | (B) Listar celulares menor al stock minimo');
            writeln('(C) Lista celular con misma informacion | (D) Exportar archivos creado ');
            writeln('(X) Salir');
        end;
        readln(key);
    end;
end.