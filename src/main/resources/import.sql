insert into doctor(id, name, type, email, contact_number) values (1, 'DR. A', 'A', 'a@gmail.com', '1');
insert into doctor(id, name, type, email) values (2, 'DR. B', 'B', 'b@ymail.com');
insert into doctor(id, name, type, email) values (3, 'DR. C', 'C', 'c@gmail.com');
insert into doctor(id, name, type, email, contact_number) values (4, 'DR. D', 'D', 'd@yahoo.com', '4');
insert into doctor(id, name, type, email, contact_number) values (5, 'DR. E', 'E', 'e@ymail.com', '5');
insert into doctor(id, name, type, email) values (6, 'DR. F', 'F', 'f@gmail.com');

insert into appointment(id, contact_number, doctor_id, email, name, start_time, end_time) values (1, '11', 1, '1@test.int', 'Kishan A', {ts '2012-09-17 18:00:00.69'}, {ts '2012-09-17 18:30:00.69'});
insert into appointment(id, contact_number, doctor_id, email, name, start_time, end_time) values (2, '22', 2, '2@test.int', 'Kishan B', {ts '2012-09-17 11:00:00.69'}, {ts '2012-09-17 11:30:00.69'});
insert into appointment(id, contact_number, doctor_id, email, name, start_time, end_time) values (3, '33', 3, '3@test.int', 'Kishan C', {ts '2012-09-17 12:00:00.69'}, {ts '2012-09-17 13:00:00.69'});
insert into appointment(id, contact_number, doctor_id, email, name, start_time, end_time) values (4, '44', 1, '4@test.int', 'Kishan D', {ts '2012-09-17 14:00:00.69'}, {ts '2012-09-17 14:30:00.69'});
insert into appointment(id, contact_number, doctor_id, email, name, start_time, end_time) values (5, '55', 5, '5@test.int', 'Kishan E', {ts '2012-09-17 18:00:00.69'}, {ts '2012-09-17 18:30:00.69'});
