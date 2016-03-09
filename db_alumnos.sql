drop database if exists db_alumnos;
create database db_alumnos;
use db_alumnos;


create table alumnos(
idAlumno			int not null primary key,
numBoleta			int not null);



insert into alumnos(idAlumno,numBoleta)values(1,2014090001);
insert into alumnos(idAlumno,numBoleta)values(2,2014090002);
insert into alumnos(idAlumno,numBoleta)values(3,2014090003);
insert into alumnos(idAlumno,numBoleta)values(4,2014090004);
insert into alumnos(idAlumno,numBoleta)values(5,2014090005);
insert into alumnos(idAlumno,numBoleta)values(6,2014090006);
insert into alumnos(idAlumno,numBoleta)values(7,2014090211);