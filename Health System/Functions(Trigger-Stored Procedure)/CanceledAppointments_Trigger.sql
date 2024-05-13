--Eğer bir hasta randevusunu iptal ederse iptal ettiği randevusunun özellikleri(eski randevu tarihi,iptal ettiği tarih, hasta kimlik numarası) iptal edilmiş randevular tablosunda görülcek.
--is_active (aktif mi) kolonu true dan falsa cekilirse, iptal edilen veri diğer tabloda görüncek.
create or replace function fn_appointments_canceled()
returns trigger
language plpgsql
as
$$
Begin 
if new.is_active<>old.is_active then 
insert into canceled_appointments(identity,appointment_date,cancel_date)
values (old.identity,old.appointment_date,now());
end if;
return new;
end;
$$
CREATE trigger canceled_appointments
before update on appointments
for each row
execute function fn_appointments_canceled()
--İptal edilen randevular tablosunu oluşturalım
create table canceled_appointments 
(
	cancel_id serial not null,
	identity varchar(11),
	appointment_date date,
	cancel_date date
)
--Veride güncelleme yapalım.(54235366417 identity li verinin is_activi'ni truedan false cektik.)
update appointments set is_active=false
where identity ='54235366417'

select * from canceled_appointments

