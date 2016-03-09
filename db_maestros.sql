drop database if exists db_maestros;
create database db_maestros;
use db_maestros;

create table maestros(
idMaestros				int not null primary key,
numeroDeTrab			int not null);

insert into maestros(idMaestros,numeroDeTrab)values(1,012345678);
insert into maestros(idMaestros,numeroDeTrab)values(2,123456789);
insert into maestros(idMaestros,numeroDeTrab)values(3,234567891);