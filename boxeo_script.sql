-- Traballo Tutelado Bases de Datos
-- Xabier Jimenez Gomez

-- Drop all tables

drop table entrada cascade constraints;
drop table zona cascade constraints;
drop table valora cascade constraints;
drop table puntua cascade constraints;
drop table juez cascade constraints;
drop table asalto cascade constraints;
drop table combate cascade constraints;
drop table recinto cascade constraints;
drop table historico cascade constraints;
drop table club cascade constraints;
drop table campeonato cascade constraints;
drop table boxeador cascade constraints;

-- Create tables

create table boxeador (
    DNI_Boxeador varchar2(9) constraint pk_box primary key,
    Nombre varchar2(50) constraint nn_nombrebox not null,
    Categoria varchar2(25) constraint nn_cat not null,
    Victorias number(4),
    Derrotas number(4),
    Peso number(3)
);

create table campeonato (
    Cod_Campeonato number(5) constraint pk_camp primary key,
    Nombre_Campeonato varchar2(50) constraint nn_nombrecamp not NULL,
    Fecha_Inicio date,
    Fecha_Fin date
);

create table club (
	Cod_Campeonato number(5),
    Cod_Club number(5) constraint pk_club primary key,
    Nombre_Club varchar2(50) constraint nn_nombreclub not null,
    constraint fk_campclub foreign key (Cod_Campeonato) references campeonato
);

create table historico (
	Cod_Club number(5),
	DNI_Boxeador varchar2(9),
    Fecha_Inscripcion date,
    Fecha_Desvinculacion date,
    constraint fk_historicoDNI foreign key (DNI_Boxeador) references boxeador,
    constraint fk_historicoClub foreign key (Cod_Club) references club,
    constraint pk_histor primary key (DNI_Boxeador, Fecha_Inscripcion)
);

create table recinto (
    Id_recinto number(5) constraint pk_rec primary key,
    Nombre_recinto varchar2(50) constraint nn_nombrerec not null  
);

create table combate (
	DNI_Boxeador1 varchar2(9),
	DNI_Boxeador2 varchar2(9),
	Ganador varchar2(9),
	Cod_Campeonato number(5),
	Id_recinto number(5),
    Cod_Combate number(5) constraint pk_comb primary key,
    Asaltos_Totales number(2),
    Fase varchar2(50) constraint nn_fase not NULL,
    constraint fk_boxcombate foreign key (DNI_Boxeador1) references boxeador,
    constraint fk_boxcombate2 foreign key (DNI_Boxeador2) references boxeador,
    constraint fk_boxcombate3 foreign key (Ganador) references boxeador,
    constraint fk_campcomb foreign key (Cod_Campeonato) references campeonato,
    constraint fk_recintocomb foreign key (Id_recinto) references recinto
);

create table asalto (
	Cod_Combate number(5),
	Num_Asalto number(2) not null,
	Duracion varchar2(25),
    Puntos_A number(3) constraint nn_puntA not null,
    Puntos_B number(3) constraint nn_puntB not null,
    Faltas_A number(2) DEFAULT 0,
    Faltas_B number(2) DEFAULT 0,
    constraint pk_asalto primary key (Cod_Combate, Num_Asalto),
    constraint fk_asaltocomb foreign key (Cod_Combate) references combate
);

create table juez (
    DNI_Juez varchar2(9) constraint pk_juez primary key,
    Nombre varchar2(50) constraint nn_nombrejuez not null
);

create table puntua (
	DNI_Juez varchar2(9),
	Cod_Combate number(5),
	Num_Asalto number(2),
    PuntuacionA number(3) constraint nn_puntAA not null,
    PuntuacionB number(3) constraint nn_puntBB not null,
    CONSTRAINT pk_punt primary key (Num_Asalto, DNI_Juez,Cod_Combate),
    foreign key (Num_Asalto,Cod_Combate) references asalto(Num_Asalto,Cod_Combate),
    constraint fk_puntuajuez foreign key (DNI_Juez) references juez (DNI_Juez)
);

create table valora (
	DNI_Juez varchar2(9),
	Cod_Combate number(5),
    Asistio varchar2(2) constraint nn_asist not null,
    Posicion varchar2(25) constraint nn_pos not null,
    constraint pk_valora primary key (Cod_Combate, DNI_Juez),
    constraint fk_valoracomb foreign key (Cod_Combate) references combate,
    constraint fk_valorajuez foreign key (DNI_Juez) references juez
);

create table zona (
    Id_zona number(5) constraint pk_recin primary key,
    Id_recinto number(5),
    Maximo_localidades number(6),  
    constraint fk_zona foreign key (Id_recinto) references recinto
);

create table entrada (
    Cod_Combate number(5),
    Id_zona number(5),
    Precio number(5),
    Vendidas number(8) DEFAULT 0,
    Cantidad_Total number(8) constraint nn_total not null,
    constraint pk_entrada primary key (Cod_Combate, Id_zona), 
    constraint fk_entradacomb foreign key (Cod_Combate) references combate,
 	constraint fk_entradazona foreign key (Id_zona) references zona
);


-- Insertar boxeadores

insert into boxeador values ('32759711B', 'Michael Gerard Tyson', 'Peso pesado', 50, 6, 100);
insert into boxeador values ('32993611T', 'David Benavidez Brant', 'Peso pesado', 27, 4, 100);
insert into boxeador values ('34869427J', 'Billy Joe Saunders', 'Peso pesado', 44, 6, 120);
insert into boxeador values ('43391877D', 'Michael Hunter Jr.', 'Peso pesado', 26, 5, 105);
insert into boxeador values ('41998213D', 'Cassius Marcellus Clay Jr', 'Peso pesado', 56, 5, 105);
insert into boxeador values ('38475112C', 'Oleksandr Usyk Plant ', 'Peso pesado', 30, 3, 95);
insert into boxeador values ('32819113T', 'Anthony Oluwafemi Olaseni Joshua', 'Peso pesado', 24, 1, 110);
insert into boxeador values ('34555189J', 'Andrés Ponce Ruiz Jr', 'Peso pesado', 34, 2, 120);
insert into boxeador values ('37639854Y', 'Tyson Fury Smith', 'Pluma', 24, 2, 54);
insert into boxeador values ('32113854Y', 'Daniel Jacobs Ryder', 'Pluma', 40, 4, 77);
insert into boxeador values ('31119857A', 'Deontay Wilder Dirrell', 'Mosca', 21, 3, 57);
insert into boxeador values ('32739257A', 'Gabriel Jesus Rodriguez', 'Mosca', 20, 3, 50);
insert into boxeador values ('35743455F', 'Alexander Povetkin Eubank', 'Gallo', 44, 7, 53);
insert into boxeador values ('35749287C', 'Jose Armando Maradona Del Castro', 'Gallo', 41, 1, 53);
insert into boxeador values ('32992817J', 'Canelo Álvarez Falcao ', 'Ligero', 72, 24, 68);
insert into boxeador values ('32563971A', 'Emmanuel Dapidran Pacquiao', 'Ligero', 62, 7, 66);

-- Insertar campeonatos

insert into campeonato values (10533,'Combate de tortas nacional',to_date('05/08/2001 13:40', 'DD/MM/YYYY HH24:MI'),to_date('07/08/2002 13:00', 'DD/MM/YYYY HH24:MI'));
insert into campeonato values (10534,'Copa Piston',to_date('05/08/2003 13:40', 'DD/MM/YYYY HH24:MI'),to_date('07/10/2010 13:00', 'DD/MM/YYYY HH24:MI'));
insert into campeonato values (10535,'Consejo Mundial de Boxeo',to_date('05/03/2000 13:40', 'DD/MM/YYYY HH24:MI'),to_date('07/09/2000 13:00', 'DD/MM/YYYY HH24:MI'));
insert into campeonato values (10536,'Juegos de Invierno',to_date('05/08/2010 13:40', 'DD/MM/YYYY HH24:MI'),to_date('07/08/2011 13:00', 'DD/MM/YYYY HH24:MI'));
insert into campeonato values (10537,'Copa Cagallon',to_date('05/05/2020 13:40', 'DD/MM/YYYY HH24:MI'),to_date('07/09/2020 13:00', 'DD/MM/YYYY HH24:MI'));
insert into campeonato values (10538,'International Cup',to_date('05/08/2016 13:00', 'DD/MM/YYYY HH24:MI'),to_date('07/08/2017 13:00', 'DD/MM/YYYY HH24:MI'));

-- Insertar clubes

insert into club values (10534,00001,'SRD Portuarios');
insert into club values (10534,00002,'Racing Ferrol');
insert into club values (10534,00003,'Los Leones de Medellin');
insert into club values (10534,00004,'Vodka Juniors');
insert into club values (10535,00005,'Club Amazonas');
insert into club values (10535,00006,'The Slayers');
insert into club values (10535,00007,'Coca Juniors');
insert into club values (10535,00008,'Forocoches BC');
insert into club values (10536,00009,'Boxing FIC');
insert into club values (10536,00010,'Deportivo Alaves');

-- Insertar historicos

insert into historico values (00001 ,'32759711B',to_date('10/04/2000 12:30', 'DD/MM/YYYY HH24:MI'),null);
insert into historico values (00002 ,'32739257A',to_date('15/03/2005 16:30', 'DD/MM/YYYY HH24:MI'),null);
insert into historico values (00003 ,'41998213D',to_date('05/08/2001 13:40', 'DD/MM/YYYY HH24:MI'),to_date('07/08/2009 13:00', 'DD/MM/YYYY HH24:MI'));
insert into historico values (00005 ,'32563971A',to_date('10/11/2000 16:30', 'DD/MM/YYYY HH24:MI'),null);
insert into historico values (00009 ,'32819113T',to_date('03/07/2005 18:30', 'DD/MM/YYYY HH24:MI'),null);
insert into historico values (00006 ,'41998213D',to_date('02/09/2010 19:30', 'DD/MM/YYYY HH24:MI'),null);
insert into historico values (00006 ,'34555189J',to_date('21/06/2001 20:00', 'DD/MM/YYYY HH24:MI'),null);
insert into historico values (00010 ,'32113854Y',to_date('21/11/2000 16:30', 'DD/MM/YYYY HH24:MI'),null);
insert into historico values (00007 ,'35749287C',to_date('04/01/2010 15:00', 'DD/MM/YYYY HH24:MI'),null);

-- Insertar recintos

insert into recinto values (30001,'Complejo Deportivo Pablo Piatti');
insert into recinto values (30002,'A Malata');
insert into recinto values (30003,'Mendizorroza');
insert into recinto values (30004,'Anfield');
insert into recinto values (30005,'Narnia');
insert into recinto values (30006,'Centro Pokemon');

-- Insertar combates
insert into combate values ('32992817J','35743455F','32992817J',10533,30004,20021,6,'Octavos de Final');
insert into combate values ('32759711B','32819113T','32759711B',10533,30001,20025,10,'Cuartos de Final');
insert into combate values ('32113854Y','32563971A','32563971A',10533,30002,20022,3,'Semifinal');
insert into combate values ('32759711B','41998213D','32759711B',10533,30003,20023,8,'Final');
insert into combate values ('43391877D','35743455F','43391877D',10534,30005,20026,6,'Octavos de Final');
insert into combate values ('35749287C','32819113T','35749287C',10534,30006,20027,10,'Cuartos de Final');
insert into combate values ('38475112C','34555189J','34555189J',10534,30002,20028,3,'Semifinal');
insert into combate values ('35749287C','34555189J','34555189J',10534,30003,20029,8,'Final');

-- Insertar asaltos

insert into asalto values (20021,4,'51 sec',71,30,1,3);
insert into asalto values (20021,5,'1,01 min',60,42,1,1);
insert into asalto values (20021,6,'70 sec',81,20,2,3);
insert into asalto values (20021,3,'1,35 min',90,10,null,2);
insert into asalto values (20021,2,'1,15 min',55,45,4,1);
insert into asalto values (20021,1,'1,42 min',61,56,1,1);
insert into asalto values (20022,3,'2 min',90,71,0,1);
insert into asalto values (20023,2,'3 min',22,50,4,2);

-- Insertar jueces

insert into juez values ('32542245Z','Jose Juan Ramirez');
insert into juez values ('44234111C','Mikel Alonso Jimenez');
insert into juez values ('32896451B','Pedro Martinez Marcial');
insert into juez values ('32678245C','Jose Pablo Del Rio');
insert into juez values ('44534611A','Pedro Benito Rey Martinez');
insert into juez values ('37996751S','Lionel Dos Nacimento Romo');

-- Insertar puntua

insert into puntua values ('32542245Z',20021,6,81,20);
insert into puntua values ('32542245Z',20021,5,60,42);
insert into puntua values ('32542245Z',20021,4,71,30);
insert into puntua values ('32542245Z',20021,3,90,10);
insert into puntua values ('32542245Z',20021,2,55,45);
insert into puntua values ('32542245Z',20021,1,61,56);
insert into puntua values ('32896451B',20022,3,7,93);
insert into puntua values ('44534611A',20023,2,30,75);

-- Insertar valora

insert into valora values ('32542245Z',20021,'Si','Titular');
insert into valora values ('44234111C',20022,'No','Suplente');
insert into valora values ('32896451B',20023,'Si','Titular');
insert into valora values ('32678245C',20021,'No','Titular');
insert into valora values ('44534611A',20022,'Si','Titular');
insert into valora values ('37996751S',20023,'No','Suplente');

-- Insertar zona

insert into zona values (40001,30001,5000);
insert into zona values (40011,30001,5000);
insert into zona values (40002,30002,null);
insert into zona values (40003,30003,9000);
insert into zona values (40033,30003,8500);
insert into zona values (40004,30004,9000);
insert into zona values (40005,30005,9100);

-- Insertar entrada

insert into entrada values (20021,40001,300,150,5000);
insert into entrada values (20022,40003,null,null,9000);
insert into entrada values (20023,40002,405,null,9500);
insert into entrada values (20025,40033,40,null,1000);
