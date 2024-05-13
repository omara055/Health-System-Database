

--Saklı Prosedür kullanarak Hastalar tablosuna veri yükleme (İnserting data using a stored procedure)
	create or replace procedure insert_patients(   
	newidentity varchar(11),
    newfirstname varchar(100) DEFAULT NULL,
    newlastname varchar(100) DEFAULT NULL,
    newphone varchar(100) DEFAULT NULL,
    newbirth_date date DEFAULT NULL,
    newgender varchar(1) DEFAULT NULL,
    newaddress varchar(100) DEFAULT NULL,
    newemail varchar(100) DEFAULT NULL)
	language plpgsql
	as
	$$
	Begin
	insert into patients (identity,firstname,lastname,phone,birth_date,gender,address,email)
	values (newidentity,newfirstname,newlastname,newphone,newbirth_date,newgender,newaddress,newemail);
	    RAISE NOTICE 'YENİ HASTA EKLENDİ: %', newfirstname;
		END;
		$$
		
		CALL insert_patients('12345678911','Akile','Uzuner')
	