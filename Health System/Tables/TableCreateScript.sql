--Hastaneler tablosunu oluşturdum.
create table hospitals
( 
	hospital_id uuid primary key not null default uuid_generate_v4(),
	 hospital_name varchar(100) not null,
 	adress varchar(200),
 	phone varchar(20)
)
--Hastanenin bölümler tablosu, departmen detayları bölümü jsonb olarak oluşturdum cünkü bölümlerin detayları yazılcak.
create table hospital_departments
(
	department_id uuid primary key not null default uuid_generate_v4(),
	hospital_id uuid not null references hospitals(hospital_id),
	department_name varchar(100),
	department_details jsonb
)
--Doktorlar tablosu, calısma saatleri jsonb olarak olusturdum. Doktorun hangi hastanede calıstıgını görmek icin hosptial id bölümü foreign key.
create table doctors
(
	doctor_id uuid primary key not null default uuid_generate_v4(),
	hospital_id uuid not null references hospitals(hospital_id),
	firstname varchar(100),
	lastname varchar(100),
	mail varchar(100),
	phone varchar(100),
	working_hours jsonb
)
--Doktorun uzmanlık alanı tablosu, Bir doktorun birden cok uzmanlığı olabilir o yüzden experts jsonb.
create table doctors_expertise
(
	expertise_id uuid primary key not null default uuid_generate_v4(),
	doctor_id uuid not null references doctors(doctor_id),
	experts jsonb
)
--Hastalar tablosu, kimlik 11 haneli olmalı.
create table patients
(
	identity varchar(11) primary key not null,
	firstname varchar(100),
	lastname varchar(100),
	phone varchar(100),
	birt_date date,
	gender varchar(1),
	address varchar(100),
	email varchar(100)
)
--Randevu tablosu. created_date(randevunun oluşturulma tarihi), appointment_date (randevu tarihi). randevu iptal edilmez ise default true.
create table appointments
(
	appointment_id uuid primary key not null default uuid_generate_v4(),
	identity varchar(11) not null references patients(identity),
	doctor_id uuid not null references doctors(doctor_id),
	hospital_id uuid not null references hospitals(hospital_id),
	created_date timestamp not null,
	appointment_date timestamp not null,
	is_active boolean default true
)
--Randevu detayları tablosu.
create table appointments_details
(
	id uuid primary key not null default uuid_generate_v4(),
	appointment_id uuid not null references appointments(appointment_id),
	examination_area varchar(100),
	examination_type varchar(100)
)
--Tıbbi geçmiş tablosu, geçmişte birden cok rahatsızlıgı olabilir bu sebeble history_details jsonb oluşturuldu.
create table medical_history
(
	history_id uuid primary key not null default uuid_generate_v4(),
	identity varchar(11) not null references patients(identity),
	history_details jsonb
)
--İlaçlar tablosu. Birden fazla ilaç yada kullanım şekli yazabılır bu yüzden medication_detals jsonb tarzında.
create table prescription
(
	prescription_id uuid primary key not null default uuid_generate_v4(),
	doctor_id uuid not null references doctors(doctor_id),
	identity varchar(11) not null references patients(identity),
	prescription_date timestamp,
	medication_detals jsonb
)