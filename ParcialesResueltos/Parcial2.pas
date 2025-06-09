program parcial2;
const valorAlto=9999;
type
    producto = Record 
        codProducto:integer;
        nombre:String[20];
        descripcion:String[40];
        codBarra:integer;
        categoria:integer;
        stockA:integer;
        stockMin:integer;
    end;
    pedido = Record
        codProducto:integer;
        cantPedida:integer;
        descripcion:String[40];
    end;
    almacen = file of producto;
    pedidos =  file of pedido;
{Procesos}

procedure leerDetalle(var arc:pedidos;var  rx:pedido);
begin
    if(not EOF(arc))then
        read(arc,rx);
    else 
        rx.codProducto:=valorAlto;
end;
procedure minimo(var r1,r2,r3:pedido; var res1,res2,res3:pedidos; var min: pedido);
begin
    if((r1.codProducto <=r2.codProducto)and(r1.codProducto<=r3.codProducto))then begin
        min:=r1;
        leerDetalle(res1,r1);
    end
        else if((r2.codProducto<=r3.codProducto)and(r2.codProducto<=r1.codProducto))then begin
            min:=r2;
            leerDetalle(res2,r2);
        end 
            else begin
                min:=r3;
                leerDetalle(res3,r3);
            end;
end;
procedure actualizarAlmacen(var res1,res2,res3:pedidos; var a:almacen; var faltantes:text);
var
    r1,r2,r3,min:pedido;
    ra:producto;
    totPedido:producto;
    desconte:boolean;
    diferencia:integer;
begin
    reset(res1);reset(res2);reset(res3);reset(a);
    leerDetalle(rse1,r1);leerDetalle(res2,r2);leerDetalle(res3,r3);
    minimo(r1,r2,r3,res1,res2,res3,min);
    rewrite(faltantes);
    diferencia:=0;

    while(min.codProducto<>valorAlto)do begin   
        totPedido.codProducto := min.codProducto;
        totPedido.cantPedida := 0;
        while(totPedido.codProducto = min.codProducto) do begin
            totPedido.cantPedida:=  totPedido.cantPedida + min.cantPedida;
            minimo(r1,r2,r3,res1,res2,res3,min);
        end;
        desconte:=false;
        while(not EOF(a)) and (not desconte)do begin
            read(a,ra);
            if(ra.codProducto= totPedido.codProducto)then begin
                if(ra.stockA>=totPedido.cantPedida)then
                    ra.stockA:=ra.stockA - totPedido.cantPedida;
                else 
                    begin 
                        diferencia:=totPedido.cantPedida -ra.stockA;
                        ra.stockA:=0;
                        writeln('el pedido fue insatifecho faltaron: ',diferencia,' productos');
                    end;
                if(ra.stockA<ra.stockMin)then 
                    writeln(faltantes, ra.codProducto, ra.categoria);

                seek(a,filepos(a)-1);
                write(a,ra);
                desconte:=true;
            end;
        end;
    end;
end;

{Programa principal}
var 
    res1,res2,res3:pedidos;
    a:almacen;
    faltantes: file of text;
begin
    actualizarAlmacen(res1,res2,res3,a,faltantes);
end.