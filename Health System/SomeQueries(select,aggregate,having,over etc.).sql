--Hastanede calısan doktorların adı soyadı ve calısma saatleri
Select h.hospital_name as hastaneAdı,d.firstname as doktorAdı,d.lastname as doktorSoyadı,d.working_hours as calısmaSaati
from hospitals h inner join doctors d on h.hospital_id = d.hospital_id

--Toplam doktor sayısı 35 den büyük hastaneler
SELECT 
    h.hospital_name,
    SUM((department_details->>'doktor_sayisi')::integer) AS toplamdoktorsayısı  
FROM 
    hospital_departments hd
INNER JOIN 
    hospitals h ON hd.hospital_id = h.hospital_id
GROUP BY 
    h.hospital_name
having SUM((department_details->>'doktor_sayisi')::integer)>35

--Hastanelerdeki bölümlerin(kardiyoloji,göz vs) toplam hasta kapasitesi
SELECT 
h.hospital_name, h.adress,hd.department_name,hd.department_details,
sum((department_details->>'hasta_kapasitesi')::integer) over(partition by department_name ) from hospital_departments  hd INNER JOIN 
    hospitals h ON hd.hospital_id = h.hospital_id
	order by 5 desc

--Hastanelerin departmanlarını görme
Select h.hospital_name,hd.department_name,hd.department_details from hospitals h inner join hospital_departments hd on h.hospital_id=hd.hospital_id

--Hastanalerin ortalama hasta kapasiteleri
SELECT 
h.hospital_name, h.adress,hd.department_name,hd.department_details,
avg((department_details->>'hasta_kapasitesi')::integer) over(partition by h.hospital_name) from hospital_departments  hd INNER JOIN 
    hospitals h ON hd.hospital_id = h.hospital_id
	
--Hastaların doktorlardan aldığı randevu saatleri
select d.firstname as DoctorAd,p.firstname as HastaAd,p.lastname as HastaSoyad,a.appointment_date as RandevuSaati from doctors d inner join appointments a on d.doctor_id=a.doctor_id
inner join patients p on a.identity=p.identity

--Hastaların aldığı randevuların detayları,saati
select a.identity,p.firstname as HastaAd,p.lastname as HastaSoyad,a.appointment_date as RandevuSaati,ad.examination_area as MuayeneBölümü,
ad.examination_type as MuayeneTuru from appointments a inner join appointments_details ad on a.appointment_id=ad.appointment_id
inner join patients p on p.identity=a.identity

--JSON icinde veri aramak. örnek; Hasta kapasitesi 40 ve üzeri olan hastaneleri getir.
select * from hospital_departments 
where department_details  ->>'hasta_kapasitesi'>='40' 

--Hastanelerdeki bölümlerin doktor sayısı
select h.hospital_name,department_name,department_details->>'doktor_sayisi' as doktorsayısı from hospital_departments hd
inner join hospitals h
on hd.hospital_id=h.hospital_id


--Uzmanlık alanları nöroloji olan doktorlar
select * from doctors_expertise
where experts ->>'uzmanlik1'='Nöroloji' or experts ->>'uzmanlik2'='Nöroloji'

--Hastanelerdeki randevuların sayısı
select h.hospital_name,count(*) from appointments a inner join hospitals h on a.hospital_id=h.hospital_id group by h.hospital_name

--Geçmişinde Anjiyo hastalığı olan hastalar
select mh.identity as kımlık,CONCAT(p.firstname,' ',p.lastname) as hastaadsoyad,mh.history_details as tedaviGecmisi from medical_history mh inner join patients p on mh.identity=p.identity
where mh.history_details->>'durum'='Anjiyo'


	


	
