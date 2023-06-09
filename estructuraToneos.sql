#Inventat una estructura de tornejos i els carregues a la taula tornejos. Els tornejos han de formar part del load_data.sql
insert into Torneo (id,nombre) values (1,España);
insert into Torneo (id,nombreid_torneo_dependiente) values (2,"Madrid",1);
insert into Torneo (id,nombreid_torneo_dependiente) values (2,"Barcelona",1);
insert into Torneo (id,nombreid_torneo_dependiente) values (3,"Baleares",1);
insert into Torneo (id,nombreid_torneo_dependiente) values (4,"Menorca",3);
insert into Torneo (id,nombreid_torneo_dependiente) values (5,"Mallorca",3);
insert into Torneo (id,nombreid_torneo_dependiente) values (5,"Manacor",5);
insert into Torneo (id,nombreid_torneo_dependiente) values (5,"Inca",5);


