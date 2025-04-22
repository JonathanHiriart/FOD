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
procedure crearArchivo(input:Text);
var 
    nameArchivo:string;
    arLogico:archivo;
begin
    writeln('ingrese el nombre del nuevo Archivo');
    readln(nameArchivo);
    assign(arLogico,nameArchivo); 
    rewrite(arLogico);
    reset(input);// abro el archivo otorgrado
    
end;
// Programa principal 
var 
    nameTxt:String;
    key:char;
    arLogicoInput:Text;
begin
    nameTxt:='Celulares.txt'
    assign(nameTxt,arLogicoInput); // asigno el archivo otorgado por el usuario 
    writeln('Bienvenido a la tienda de celulares, que desea hacer? ');
    writeln('(A) Crear Archivos | (B) Modificar Empleado');
    writeln('(C) Exportar archivo  | (D) Exportar archivos incompletos ');
    writeln('(E) Listar Empleados  | (F) Listar Jubilados');
    writeln('(X) Salir');
    readln(key);
    while (key<> 'x')or (key<>'X') do beign 
        case key of 
            a,A : crearArchivo(arLogicoInput);
        else
        begin
            writeln('opcion invalida ingrese nuevamente');
            writeln('(A) Crear Archivos | (B) Modificar Empleado');
            writeln('(C) Exportar archivo  | (D) Exportar archivos incompletos ');
            writeln('(E) Listar Empleados  | (F) Listar Jubilados');
            writeln('(X) Salir');
        end;
        readln(key);
    end;
end.