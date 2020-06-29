create table lk_geograph (
	geograph_id int not null primary key identity (1,1),
	direccion nvarchar(400),
	codigo_postal nvarchar(255),
	ciudad nvarchar(255),
	pais nvarchar(255),
	region nvarchar(255)
)

create table lk_mes (
	mes_id int not null primary key identity(1,1),
	mes int,
	ano int,
	trimestre int,
	estacion varchar(50)
)

create table lk_dia (
	dia_id int not null primary key identity(1,1),
	dia int,
	mes_id int foreign key references lk_mes(mes_id),
	dia_semana varchar(50)
)


create table lk_proveedor (
	prov_id int not null primary key identity(1,1),
	nombre_comp nvarchar(255),
	nombre_contacto nvarchar(255),
	cargo_contacto nvarchar(255),
	telefono nvarchar(50),
	pagina_web nvarchar(100),
	geograph_id int foreign key references lk_geograph(geograph_id)
)

create table lk_cliente (
	cliente_id int not null primary key identity(1,1),
	nombre_contacto nvarchar(255),
	cargo_contacto nvarchar(255),
	telefono nvarchar(255),
	geograph_id int foreign key references lk_geograph(geograph_id)
)

create table lk_categoria (
	categ_id int not null primary key identity(1,1),
	nombre varchar(255),
	descripcion nvarchar(max),
	imagen nvarchar(max)
)

create table lk_producto (
	prod_id int not null primary key identity(1,1),
	nombre nvarchar(255),
	cant_unidad nvarchar(255),
	precio_unidad decimal(15,2),
	nivel_nuevo_pedido int,
	suspendido bit default(0),
	existencias int, 
	pedidos int, 
	prov_id int foreign key references lk_proveedor(prov_id),
	categ_id int foreign key references lk_categoria(categ_id)
)

create table lk_ano_presupuesto (
	ano_id int not null primary key identity(1,1),
	ano int
)

create table lk_pais_presupuesto (
	pais_id int not null primary key identity(1,1),
	pais varchar(255)
)

create table ft_presupuesto (
	pres_id int not null primary key identity(1,1),
	sourceid int,
	valor_total int,
	categ_id int foreign key references lk_categoria(categ_id),
	ano_id int foreign key references lk_ano_presupuesto(ano_id),
	pais_id int foreign key references lk_pais_presupuesto(pais_id)
)

create table lk_presupuesto_mes (
	pres_categ_mes_id int not null primary key identity(1,1),
	monto int,
	mes varchar(25),
	pres_id int foreign key references ft_presupuesto(pres_id),
)



create table lk_empleados (
	empleado_id int not null primary key identity(1,1),
	apellidos nvarchar(255),
	nombre nvarchar(255),
	cargo nvarchar(255),
	nacimiento date,
	contratacion date,
	geograph_id int foreign key references lk_geograph(geograph_id),
	telefono_particular nvarchar(255),
	extension int,
	foto nvarchar(max),
	notas nvarchar(max),
	jefe int foreign key references lk_empleados(empleado_id)
)


create table ft_ventas (
	venta_id int not null primary key identity(1,1),
	source_id int,
	Tiempo_Entrega_Dias int,
	geograph_id int foreign key references lk_geograph(geograph_id),
	cliente_id int foreign key references lk_cliente(cliente_id),
	venta_dia int foreign key references lk_dia(dia_id),
	envio_dia int foreign key references lk_dia(dia_id),
	entrega_dia int foreign key references lk_dia(dia_id),
	empleado_id int foreign key references lk_empleados(empleado_id)
)

create table lk_venta_producto (
	venta_producto_id int not null primary key identity(1,1),
	venta_id int foreign key references ft_ventas(venta_id),
	prod_id int foreign key references lk_producto(prod_id),
	cantidad int,
	descuento float default(0),
	descuento_pesos decimal(15,2) 

)