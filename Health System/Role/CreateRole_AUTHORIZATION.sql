--Tıbbi sekreter rolü oluşturup bazı tablolara yetki verelim.(Let's create a medical secretary role and authorize some tables.)

create role medical_secretary nosuperuser nocreatedb nocreaterole login

--Hastaların randevu,isim soyisim vs bilgilerini görmek için yetki verelim.(Let's authorize patients to see their appointment, name, surname, etc. information.)
Grant select on table patients to medical_secretary
Grant select on table appointments to medical_secretary

--Hasta kaydı girmesi ve randevu oluşturması icin yetki verelim.(Let's authorize the patient to enter a patient record and create an appointment.)
Grant INSERT ON TABLE patients to medical_secretary
Grant INSERT ON TABLE appointments to medical_secretary

-- Hastaların hangi alanda randevu aldıklarını görmek için yetki verelim. (Let's authorize patients to see in which area they made an appointment)
Grant select (id,examination_area,examination_type) on appointments_details to medical_secretary; 