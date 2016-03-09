drop database if exists db_agendas;
-----------------------------------------------------------------------------------------------
create database db_agendas;
------------------------------------------------------------------------------------------------
use db_agendas;
------------------------------------------------------------------------------------------------
create table tbl_Cuenta(
idCuenta 			int not null primary key,
idEstadoCuenta		int default 1,
Correo				nvarchar(40)not null,
Boleta				nvarchar(25)not null,	
Psw					nvarchar(32)not null,
FechaCreacion		date not null);
------------------------------------------------------------------------------------------------
create table tbl_estadoCuenta(
idEstadoCuenta		int not null primary key,
descEstadoCuenta	nvarchar(20)not null);
------------------------------------------------------------------------------------------------
create table tbl_Persona(
idPersona			int not null primary key,
idCuenta			int not null,
Nombre				nvarchar(40)not null,
aPaterno			nvarchar(40)not null,
aMaterno			nvarchar(40)not null,
fechaN				date);
------------------------------------------------------------------------------------------------
create table tbl_RelRolCta(
idRelRolCta		int not null primary key,
idCuenta			int not null,
idRol				int not null);
------------------------------------------------------------------------------------------------
create table tbl_CatRol(
idRol				int not null primary key,
rolDescripcion		nvarchar(20)not null);
------------------------------------------------------------------------------------------------
create table tbl_CatGrupos(
idGrupo				int not null primary key,
gpoDescripcion		nvarchar(10)not null);
------------------------------------------------------------------------------------------------
create table tbl_RelActGpo(
idRelActGpo			int not null primary key,
idActividad			int not null,
idGrupo				int not null,
fechaActividad		date not null);
------------------------------------------------------------------------------------------------
create table tbl_Actividad(
idActividad 		int not null primary key,
idAgenda 			int not null,
nomActividad		nvarchar(30)not null,
Contenido			nvarchar(500)not null);
------------------------------------------------------------------------------------------------
create table tbl_Agenda(
idAgenda			int not null primary key,
idMateria			int not null,
agenDescripcion		nvarchar(100)not null);
------------------------------------------------------------------------------------------------
create table tbl_RelCtaAgnd(
idRelCtaAgnd		int not null primary key,
idAgenda			int not null,
idCuenta			int not null);
------------------------------------------------------------------------------------------------
create table tbl_CatMaterias(
idMateria			int not null primary key,
matDescripcion		nvarchar(30)not null);
------------------------------------------------------------------------------------------------
create table tbl_relCtaGrp(
idRelCtaGrp			int not null primary key,
idCuenta			int not null,
idGrupo				int default 1);

------------------------------------------------------------------------------------------------
						#FK'S#
## Creacion de FK tbl_cuenta -> tbl_persona
alter table tbl_persona
	add foreign key(idCuenta)
	references tbl_cuenta(idCuenta)on delete cascade on update cascade;
	#describe tbl_persona;
    
## Creacion de FK tbl_estadoCuenta -> tbl_Cuenta
alter table tbl_Cuenta
	add foreign key(idEstadoCuenta)
    references tbl_estadoCuenta(idEstadoCuenta) on delete cascade on update cascade;
    #describe tbl_Cuenta;

## Creacion de FK tbl_catrol -> tbl_relrolcta
alter table tbl_relrolcta
	add foreign key(idRol)
    references tbl_catrol(idRol) on delete cascade on update cascade;
    #describe tbl_relrolcta;
    
## Creacion de FK tbl_cuenta -> tbl_relrolcta
alter table tbl_relrolcta
	add foreign key(idCuenta)
    references tbl_cuenta(idCuenta) on delete cascade on update cascade;
    #describe tbl_relrolcta;   
    
## Creacion de FK tbl_catgrupos -> tbl_catgrupos
alter table tbl_relctaagnd
	add foreign key(idCuenta)
    references tbl_cuenta(idCuenta) on delete cascade on update cascade;
    #describe tbl_relctaagnd;
    
## Creacion de FK tbl_agenda -> tbl_relctaagnd
alter table tbl_relctaagnd
	add foreign key(idAgenda)
    references tbl_agenda(idAgenda) on delete cascade on update cascade;
    #describe tbl_relctaagnd;
    
## Creacion de FK tbl_catmaterias -> tbl_agenda
alter table tbl_agenda
	add foreign key(idMateria)
    references tbl_catmaterias(idMateria) on delete cascade on update cascade;
    #describe tbl_agenda;
    
## Creacion de FK tbl_agenda -> tbl_actividad
alter table tbl_actividad
	add foreign key(idAgenda)
    references tbl_agenda(idAgenda) on delete cascade on update cascade;
    #describe tbl_actividad;
    
## Creacion de FK tbl_actividad -> tbl_relactgpo
alter table tbl_relactgpo
	add foreign key(idActividad)
    references tbl_actividad(idActividad) on delete cascade on update cascade;
    #describe tbl_relactgpo;
    
## Creacion de FK tbl_catgrupos -> tbl_relactgpo
alter table tbl_relactgpo
	add foreign key(idGrupo)
    references tbl_catgrupos(idGrupo) on delete cascade on update cascade;
    #describe tbl_relactgpo;
    
    
## Creacion de FK tbl_relctagrp -> tbl_cuenta
alter table tbl_relctagrp
add foreign key(idCuenta)
references tbl_cuenta(idCuenta) on delete cascade on update cascade;

 ## Creacion de FK tbl_relctagrp -> tbl_catgrupos
alter table tbl_relctagrp
	add foreign key(idGrupo)
	references tbl_catgrupos(idGrupo) on delete cascade on update cascade;
	#describe tbl_relctagrp;
 
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		##llenado de tablas estaticas##
        
#drop procedure if exists sp_llenaGrupos;
delimiter $$
create procedure sp_llenaGrupos(in gpo nvarchar(10))
begin
	declare idCont 		int default 0;
    declare existe		int default 0;
    declare msj			nvarchar(40);
    
    set existe =(select count(*)from tbl_catgrupos where tbl_catgrupos.gpoDescripcion=gpo);
    
	if existe = 0 then
		set idCont=(select ifnull(max(idGrupo),0)+1 from tbl_catgrupos);
		insert into tbl_catgrupos(idGrupo,gpoDescripcion)
		values(idCont,gpo);
	else
		set msj='Ya esta registrado el grupo, shabo';
        select msj;
    end if;
end$$
delimiter ;

        
call sp_llenaGrupos('Sin grupo');
call sp_llenaGrupos('1IM1');
call sp_llenaGrupos('1IM2');
call sp_llenaGrupos('1IM3');
call sp_llenaGrupos('1IM4');
call sp_llenaGrupos('1IM5');
call sp_llenaGrupos('1IM6');
call sp_llenaGrupos('1IM7');
call sp_llenaGrupos('1IM8');
call sp_llenaGrupos('1IM9');
call sp_llenaGrupos('1IV1');
call sp_llenaGrupos('1IV2');
call sp_llenaGrupos('1IV3');
call sp_llenaGrupos('1IV4');
call sp_llenaGrupos('1IV5');
call sp_llenaGrupos('1IV6');
call sp_llenaGrupos('1IV7');
call sp_llenaGrupos('1IV8');
call sp_llenaGrupos('1IV9');
call sp_llenaGrupos('2IM1');
call sp_llenaGrupos('2IM2');
call sp_llenaGrupos('2IM3');
call sp_llenaGrupos('2IM4');
call sp_llenaGrupos('2IM5');
call sp_llenaGrupos('2IM6');
call sp_llenaGrupos('2IM7');
call sp_llenaGrupos('2IM8');
call sp_llenaGrupos('2IM9');
call sp_llenaGrupos('2IV1');
call sp_llenaGrupos('2IV2');
call sp_llenaGrupos('2IV3');
call sp_llenaGrupos('2IV4');
call sp_llenaGrupos('2IV5');
call sp_llenaGrupos('2IV6');
call sp_llenaGrupos('2IV7');
call sp_llenaGrupos('2IV8');
call sp_llenaGrupos('2IV9');
call sp_llenaGrupos('3IM1');
call sp_llenaGrupos('3IM2');
call sp_llenaGrupos('3IM3');
call sp_llenaGrupos('3IM4');
call sp_llenaGrupos('3IM5');
call sp_llenaGrupos('3IM6');
call sp_llenaGrupos('3IM7');
call sp_llenaGrupos('3IM8');
call sp_llenaGrupos('3IM9');
call sp_llenaGrupos('3IV1');
call sp_llenaGrupos('3IV2');
call sp_llenaGrupos('3IV3');
call sp_llenaGrupos('3IV4');
call sp_llenaGrupos('3IV5');
call sp_llenaGrupos('3IV6');
call sp_llenaGrupos('3IV7');
call sp_llenaGrupos('3IV8');
call sp_llenaGrupos('3IV9');
call sp_llenaGrupos('4IM1');
call sp_llenaGrupos('4IM2');
call sp_llenaGrupos('4IM3');
call sp_llenaGrupos('4IM4');
call sp_llenaGrupos('4IM5');
call sp_llenaGrupos('4IM6');
call sp_llenaGrupos('4IM7');
call sp_llenaGrupos('4IM8');
call sp_llenaGrupos('4IM9');
call sp_llenaGrupos('4IV1');
call sp_llenaGrupos('4IV2');
call sp_llenaGrupos('4IV3');
call sp_llenaGrupos('4IV4');
call sp_llenaGrupos('4IV5');
call sp_llenaGrupos('4IV6');
call sp_llenaGrupos('4IV7');
call sp_llenaGrupos('4IV8');
call sp_llenaGrupos('4IV9');
call sp_llenaGrupos('5IM1');
call sp_llenaGrupos('5IM2');
call sp_llenaGrupos('5IM3');
call sp_llenaGrupos('5IM4');
call sp_llenaGrupos('5IM5');
call sp_llenaGrupos('5IM6');
call sp_llenaGrupos('5IM7');
call sp_llenaGrupos('5IM8');
call sp_llenaGrupos('5IV1');
call sp_llenaGrupos('5IV2');
call sp_llenaGrupos('5IV3');
call sp_llenaGrupos('5IV4');
call sp_llenaGrupos('5IV5');
call sp_llenaGrupos('5IV6');
call sp_llenaGrupos('5IV7');
call sp_llenaGrupos('5IV8');
call sp_llenaGrupos('6IM1');
call sp_llenaGrupos('6IM2');
call sp_llenaGrupos('6IM3');
call sp_llenaGrupos('6IM4');
call sp_llenaGrupos('6IM5');
call sp_llenaGrupos('6IM6');
call sp_llenaGrupos('6IM7');
call sp_llenaGrupos('6IM8');
call sp_llenaGrupos('6IV1');
call sp_llenaGrupos('6IV2');
call sp_llenaGrupos('6IV3');
call sp_llenaGrupos('6IV4');
call sp_llenaGrupos('6IV5');
call sp_llenaGrupos('6IV6');
call sp_llenaGrupos('6IV7');
call sp_llenaGrupos('6IV8');

#################################################################################

insert into tbl_catrol values(1,'Profesor');
insert into tbl_catrol values(2,'Alumno');
insert into tbl_catrol values(3,'Administrador');

insert into tbl_estadocuenta values(1,'Cuenta Activa');
insert into tbl_estadocuenta values(2,'Cuenta Eliminada');

##################################################################################

#drop procedure if exists sp_altaMaterias;
delimiter $$
create procedure sp_altaMaterias(in materia nvarchar(25))
begin
	declare idCont 		int default 0;
    declare existe		int default 0;
    declare msj			nvarchar(50);
    
    set existe =(select count(*)from tbl_catmaterias where tbl_catmaterias.matDescripcion=materia);
    
	if existe = 0 then
		set idCont=(select ifnull(max(idMateria),0)+1 from tbl_catmaterias);
		insert into tbl_catmaterias(idMateria,matDescripcion)
		values(idCont,materia);
	else
		set msj='Ya esta registrada materia, lince :v';
        select msj;
    end if;
end$$
delimiter ;

call sp_altaMaterias('Algebra');
call sp_altaMaterias('Trigonometria');
call sp_altaMaterias('Historia');

##meter mas materias##

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop procedure if exists sp_altaCuenta;                                
delimiter $$
create procedure sp_altaCuenta(in nombre nvarchar(40), in aPaterno nvarchar(40), aMaterno nvarchar(40), in mail nvarchar(50), in pass nvarchar(50),in Bol nvarchar(20))
begin
	declare idCont 		int;
    declare idContt 	int;
    declare idConttt	int;
    declare idContttt	int;
    declare existe		int default 0;
    declare existe2		int default 0;
    declare msj			nvarchar(50);
    declare nPrueba		int default 0;
    declare nPrueba2	int default 0;
    
    
    
    set nPrueba= (select count(*) from db_maestros.maestros where numeroDeTrab=Bol);
    set nPrueba2= (select count(*) from db_alumnos.alumnos where numBoleta=Bol);
	set existe =(select count(*)from tbl_cuenta where tbl_cuenta.Correo=mail);
	set existe2 =(select count(*)from tbl_cuenta where tbl_cuenta.Boleta=Bol);
    
	if (nPrueba or nPrueba2) = 0 then
		set msj='No estas registrado en ninguna base';
    else
		if nPrueba = 1 then
			if existe = 0 then  
				if existe2 = 0 then
					set idCont=(select ifnull(max(idCuenta),0)+1 from tbl_cuenta);
					insert into tbl_cuenta(idCuenta,Correo,Boleta,Psw,FechaCreacion)
					values(idCont,mail,Bol,md5(pass),now());
						
					set idContt=(select ifnull(max(idPersona),0)+1 from tbl_persona);
					insert into tbl_persona(idPersona,idCuenta,Nombre,aPaterno,aMaterno,fechaN)
					values (idContt,idCont,nombre,aPaterno,aMaterno,now());
                    
                    set idConttt=(select ifnull(max(idRelRolCta),0)+1 from tbl_relrolcta);
                    insert into tbl_relrolcta(idRelRolCta,idCuenta,idRol)
                    values(idConttt,idCont,1);
                    
                    set idContttt=(select ifnull(max(idRelCtaGrp),0)+1 from tbl_relctagrp);
                    insert into tbl_relctagrp(idRelCtaGrp,idCuenta)
                    values(idContttt,idCont);
                    
                    
					set msj='Profesor dado de alta correctamente :)';
				else
					set msj='Numero de identificacion ya registrado';
				end if;#existe2
			else
				if (existe and existe2) = 1 then
					set msj='Correo y Numero de identificacion ya registrado';
				else
					set msj='Correo Ya Registrado';
				end if; 
			end if;#existe1
		else
			if existe = 0 then
				if existe2 = 0 then
					set idCont=(select ifnull(max(idCuenta),0)+1 from tbl_cuenta);
					insert into tbl_cuenta(idCuenta,Correo,Boleta,Psw,FechaCreacion)
					values(idCont,mail,Bol,md5(pass),now());
						
					set idContt=(select ifnull(max(idPersona),0)+1 from tbl_persona);
					insert into tbl_persona(idPersona,idCuenta,Nombre,aPaterno,aMaterno,fechaN)
					values (idContt,idCont,nombre,aPaterno,aMaterno,now());
                    
                    set idConttt=(select ifnull(max(idRelRolCta),0)+1 from tbl_relrolcta);
                    insert into tbl_relrolcta(idRelRolCta,idCuenta,idRol)
                    values(idConttt,idCont,2);
                    
                    set idContttt=(select ifnull(max(idRelCtaGrp),0)+1 from tbl_relctagrp);
                    insert into tbl_relctagrp(idRelCtaGrp,idCuenta)
                    values(idContttt,idCont);
						
					set msj='Alumno dado de alta correctamente :)';
				else
					set msj='Boleta ya registrada';
				end if;#existe2
			else
				if (existe and existe2) = 1 then
					set msj='Correo y Boleta ya Registrada';
				else
					set msj='Correo Ya Registrado';
				end if; 
			end if;#existe1
		end if;#existe3
	end if;#nprueba and nprueba2
	select msj;    
end$$
delimiter ;


#call sp_altaCuenta('Erick','Flores','Cordero','zrk@zrk.com','mateguala6','2014090211');
#call sp_altaCuenta('Ana','Cordero','Torres','asdd@asd.com','patito','012345678');



#drop view if exists v_cuentas;
create view v_Cuentas as select tbl_Persona.idCuenta, nombre, concat(aPaterno,' ',aMaterno) as Apellidos, FechaCreacion, Correo, Boleta as No_identificacion, rolDescripcion, gpoDescripcion, descEstadoCuenta from tbl_cuenta inner join tbl_persona inner join tbl_relrolcta inner join tbl_catrol inner join tbl_relctagrp inner join tbl_catgrupos inner join tbl_estadocuenta where tbl_cuenta.idCuenta=tbl_persona.idCuenta and tbl_relrolcta.idCuenta=tbl_cuenta.idCuenta and tbl_relctagrp.idCuenta=tbl_cuenta.idCuenta and tbl_relctagrp.idGrupo=tbl_catgrupos.idGrupo and tbl_relrolcta.idRol=tbl_catrol.idRol and tbl_cuenta.idEstadoCuenta=tbl_estadocuenta.idEstadoCuenta;
select * from v_Cuentas;

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop procedure if exists sp_inicioSesion;
delimiter $$
create procedure sp_inicioSesion(in bol nvarchar(50), in pass nvarchar(50))
begin
    declare existe			int default 0;
    declare existe2			int default 0;
    declare existe3			int default 0;
    declare idCta			int;
    declare identificador	nvarchar(50);
    declare msj				nvarchar(50);
    declare msj2				nvarchar(50);
    
    
    
    set existe =(select count(*)from tbl_cuenta  where tbl_cuenta.Psw=md5(pass));
	set existe2 =(select count(*)from tbl_cuenta where tbl_cuenta.Boleta=bol);
    set existe3=(select count(*)from tbl_cuenta where tbl_cuenta.Correo=bol);
    
    
    if (existe and existe2)=1 then
		set idCta = (select idCuenta from tbl_cuenta where tbl_cuenta.Boleta=bol);
        set identificador=(select rolDescripcion from tbl_relrolcta inner join tbl_catrol where tbl_relrolcta.idCuenta=idCta and tbl_relrolcta.idRol=tbl_catrol.idRol);
		set msj =idCta;
        set msj2=identificador;
    else
		if(existe and existe3)=1 then
			set idCta = (select idCuenta from tbl_cuenta where tbl_cuenta.Correo=bol);
			set identificador=(select rolDescripcion from tbl_relrolcta inner join tbl_catrol where tbl_relrolcta.idCuenta=idCta and tbl_relrolcta.idRol=tbl_catrol.idRol);
			set msj =idCta;
			set msj2=identificador;
        else
			set msj = 'No te encuentras registrado, intenta de nuevo';
		end if;
    end if;
select msj, msj2;
end$$
delimiter ;

#call sp_inicioSesion('asd@asd.com','patito');

#call sp_inicioSesion('zrk@zrk.com','mateguala6');

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#hacer que diga "la cuenta ya se eliminado" "la cuenta se encuentra eliminado"
drop procedure if exists sp_eliminarCuenta;
delimiter $$
create procedure sp_eliminarCuenta(in idCta int)
begin
update tbl_cuenta set idEstadoCuenta=2 where idCuenta=idCta;

end$$
delimiter ;

#call sp_eliminarCuenta(1);

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop procedure if exists sp_consultaDatos;
delimiter $$
create procedure sp_consultaDatos(in idCta int)
begin	
		select nombre, aPaterno, aMaterno, Correo, fechaN, gpoDescripcion, tbl_catgrupos.idGrupo from tbl_persona inner join tbl_cuenta inner join tbl_catgrupos inner join tbl_relrolcta inner join tbl_catrol inner join tbl_estadocuenta inner join tbl_relctagrp
        where tbl_cuenta.idCuenta=tbl_persona.idCuenta and tbl_relrolcta.idCuenta=tbl_cuenta.idCuenta and tbl_relctagrp.idCuenta=tbl_cuenta.idCuenta and tbl_relctagrp.idGrupo=tbl_catgrupos.idGrupo and tbl_relrolcta.idRol=tbl_catrol.idRol and tbl_cuenta.idEstadoCuenta=tbl_estadocuenta.idEstadoCuenta and tbl_cuenta.idCuenta=idCta;

end $$
delimiter ;

Call sp_consultaDatos(1);

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop procedure if exists sp_modificaDatos;
delimiter $$
create procedure sp_modificaDatos(in idCta int,in nombr nvarchar(40), in aPatrn nvarchar(40), aMatrn nvarchar(40), in mail nvarchar(50), in pass nvarchar(50),in nPass nvarchar(50), in fNacim date, in idGpo int )
begin
	declare existe 		int;
    declare idRol 		int;
    declare msj			nvarchar(50);
	
    
	set existe =(select count(*)from tbl_cuenta where tbl_cuenta.Psw=md5(pass));
	set idRol=(select tbl_relrolcta.idRol from tbl_relrolcta where tbl_relrolcta.idCuenta=idCta);
    
    
	if existe = 1 then
		if idRol=1 then
				if nPass = '0' then
					update 	tbl_persona
					set		Nombre=nombr,
							aPaterno=aPatrn,
							aMaterno=aMatrn,
							fechaN=fNacim
					where	idCuenta=idCta;
							
					update 	tbl_cuenta
					set		Correo=mail
					where	idCuenta=idCta;
					
					
					set msj='Exito';
				else
					update 	tbl_persona
					set 	Nombre=nombr,
							aPaterno=aPatrn,
							aMaterno=aMatrn,
							fechaN=fNacim
					where 		idCuenta=idCta;
							
					update 	tbl_cuenta
					set		Correo=mail,
							Psw=md5(nPass)
					where 	idCuenta=idCta;
					
					
					set msj='Exito';
				end if;
		else
			if nPass = '0' then
			
				update 	tbl_persona
				set		Nombre=nombr,
						aPaterno=aPatrn,
						aMaterno=aMatrn,
						fechaN=fNacim
				where	idCuenta=idCta;
						
				update 	tbl_cuenta
				set		Correo=mail
				where	idCuenta=idCta;
					
				update 	tbl_relctagrp
				set		idGrupo=idGpo
				where 	idCuenta=idCta;
					
				set msj='Exito';
			else
				update 	tbl_persona
				set 	Nombre=nombr,
						aPaterno=aPatrn,
						aMaterno=aMatrn,
						fechaN=fNacim
				where 	idCuenta=idCta;
						
				update 	tbl_cuenta
				set		Correo=mail,
						Psw=md5(nPass)
				where 	idCuenta=idCta;
				
				update 	tbl_relctagrp
				set		idGrupo=idGpo
				where 	idCuenta=idCta;
					
				set msj='Exito';
			end if;
		end if;
	else
		set msj='Contraseña incorrecta, intente de nuevo';
	end if;
    select msj;
end $$
delimiter ;

call sp_modificaDatos2(1,'Erick','Flores','Cordero','zrk@zrk.com','patito','0','1998-07-15','8');
call sp_modificaDatos2(2,'Ana','Flores','Cordero','asdd@asd.com','patito','0','1998-07-15','64');

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
drop procedure if exists sp_altaGpoProf;
delimiter $$
create procedure sp_altaGpoProf( in idCta int, in idGpo int)
begin
	declare idCont	int;
    declare existe	int;
    declare yaEsta	int;
	declare msj		nvarchar(50);		
            
            set yaEsta=(select count(*)from tbl_relctagrp where tbl_relctagrp.idGrupo=idGpo and tbl_relctagrp.idCuenta=idCta);
            
		if yaEsta=0 then
			set idCont=(select ifnull(max(idRelCtaGrp),0)+1 from tbl_relctagrp);
			insert into tbl_relctagrp(idRelCtaGrp,idCuenta,idGrupo)
			values(idCont,idCta,idGpo);
            set msj=('Correcto');
		else
			set msj=('Grupo ya registrado');
        end if;
	select msj;
end $$
delimiter ;

call sp_altaGpoProf(1,6);

#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

drop procedure if exists sp_consultaGruposProf;
delimiter $$
create procedure sp_consultaGruposProf(in idCta int)
begin

select gpoDescripcion from tbl_relctagrp inner join tbl_catgrupos where tbl_relctagrp.idCuenta=idCta and tbl_relctagrp.idGrupo=tbl_catgrupos.idGrupo;

end$$
delimiter ;

call sp_consultaGruposProf(1);

