--Örnek Senaryo: Bir hasta kaydının güncellenmesi
--Varsayalım ki sağlık sisteminizde bir hasta veritabanı bulunmakta ve bu veritabanında hastaların bilgileri saklanıyor.
--Bir saklı prosedür yazarak, bu hastalardan birinin bilgilerini güncellemek isteyebiliriz. Örneğin, bir hasta ev adresini veya sigorta bilgilerini güncellemek isteyebilir.


CREATE OR REPLACE PROCEDURE UpdatePatientsInformation
(
    newidentity varchar(11),
    newfirstname varchar(100) DEFAULT NULL,
    newlastname varchar(100) DEFAULT NULL,
    newphone varchar(100) DEFAULT NULL,
    newbirth_date date DEFAULT NULL,
    newgender varchar(1) DEFAULT NULL,
    newaddress varchar(100) DEFAULT NULL,
    newemail varchar(100) DEFAULT NULL
)
AS $$
BEGIN
    UPDATE patients
    SET firstname = COALESCE(newfirstname, firstname),
        lastname = COALESCE(newlastname, lastname),
        phone = COALESCE(newphone, phone),
        birth_date = COALESCE(newbirth_date, birth_date),
        gender = COALESCE(newgender, gender),
        address = COALESCE(newaddress, address),
        email = COALESCE(newemail, email)
    WHERE identity = newidentity;
    RAISE NOTICE 'Bir hasta verisi güncellendi. Kimlik numarası: %', newidentity;
END;
$$ LANGUAGE plpgsql;

--Nuriye isimli hastanın hem soyismini hemde telefon numarasını güncelledik.
call UpdatePatientsInformation ('14251366678','Nuriye','Aydogdu','5050306')
