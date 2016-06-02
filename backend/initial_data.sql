-- ### initial_data.sql ###

use [IZVRSITELJSKA_KUCA]
go
begin
	truncate table T_TRANSAKCIJE;
	truncate table T_DUGOVANJA;
	truncate table T_IZVR_KUCA_GRUPE;
	truncate table T_IZVRSITELJSKE_KUCE;
	truncate table T_ORG_JED_GRUPE;
	truncate table T_ORGANIZACIONE_JEDINICE;
	truncate table T_GRUPE_ORG_JEDINICA;
	truncate table T_IZVRSITELJI;
	truncate table T_TIPOVI_IZVRSITELJA;
	truncate table T_LICA;
end
go
begin
	set identity_insert T_LICA on;
	insert into T_LICA (ID, IME, PREZIME, DATUM_RODJENJA, JMBG, ADRESA_STANOVANJA, DODATNE_INFORMACIJE)
	values (1000, 'Nemanja', 'Tozic', cast('09/28/1994' as date), '123456789123', 'Stevana Lukovica 16', ''),
		   (1001, 'Pera', 'Peric', cast('01/02/1989' as date), '234567891234', 'Neki Put 16a', ''),
		   (1002, 'Deni', 'Devito', cast('11/17/1944' as date), '345678912345', 'Nju Dzerzijeva 17b', ''),
		   (1003, 'Dragica', 'Stankovic', cast('04/05/1973' as date), '46789123456', 'Tamo Negde 177', 'dodatna informacija'),
		   (1004, 'Mila', 'Stankovic', cast('07/06/1956' as date), '567891234567', 'Jos Jedna Adresa 18', 'druga  informacija');
	set identity_insert T_LICA off;

	set identity_insert T_TIPOVI_IZVRSITELJA on;
	insert into T_TIPOVI_IZVRSITELJA (ID, IME_TIPA, NAPLATA_USLUGE, DODATNE_INFORMACIJE)
	values (1000, 'Bankarski', 5000.0, ''),
		   (1001, 'Trgovinski', 6500.0, ''),
		   (1002, 'Mobilni', 3000.0, ''),
		   (1003, 'Maloprioritetni', 2500.0, '');
	set identity_insert T_TIPOVI_IZVRSITELJA off;

	set identity_insert T_IZVRSITELJI on;
	insert into T_IZVRSITELJI (ID, IME, PREZIME, SIFRA_UGOVORA, PLATA, DATUM_ZAPOSLJAVANJA, TIP_IZVRSITELJA_ID)
	values (1000, 'Stanko', 'Bregojevic', 'a123b14c', 40000.0, getdate(), 1000),
		   (1001, 'Mirko', 'Stojkovic', 'b234c14c', 45000.0, getdate(), 1001),
		   (1002, 'Marija', 'Sumara', '562cd123g', 43500.0, getdate(), 1000),
		   (1003, 'Gojko', 'Gojkovic', '34ggh123c+1', 60000.0, getdate(), 1002),
		   (1004, 'Trifunovic', 'Sinisa', '35hgg214ff', 3000000.99, getdate(), 1003);
	set identity_insert T_IZVRSITELJI off;

	set identity_insert T_GRUPE_ORG_JEDINICA on;
	insert into T_GRUPE_ORG_JEDINICA (ID, IME_GRUPE, DATUM_DODAVANJA, PRIORITET, DODATNE_INFORMACIJE)
	values (1000, 'Banka', getdate(), 1, ''),
		   (1001, 'Mobilna', getdate(), 2, ''),
		   (1002, 'Trgovinska', getdate(), 3, ''),
		   (1003, 'Maloprioritetna', getdate(), 4, '');
	set identity_insert T_GRUPE_ORG_JEDINICA off;

	set identity_insert T_ORGANIZACIONE_JEDINICE on;
	insert into T_ORGANIZACIONE_JEDINICE (ID, IME_ORG_JEDINICE, KONTAKT_TELEFON, FINANSIJSKO_STANJE, DATUM_DODAVANJA,
		GLAVNA_LOKACIJA, EMAIL_ADRESA, BROJ_ZAPOSLENIH, DODATNE_INFORMACIJE)
	values (1000, 'Telenor', '1234-567', 20000000.0, getdate(), 'Airport City, Novi Beograd', 'telenor@telenor.rs', 1350, ''),
		   (1001, 'Intesa', '2345-678', 50303241.0, getdate(), 'GTC Centar, Novi Beograd', 'intesa@intesa.rs', 1800, ''),
		   (1002, 'Cvecara Bukara', '3456-123', 30000.0, getdate(), 'Neka adresa 18b', 'cvecara.bukara@gmail.com', 3, ''),
		   (1003, 'Komercijalna', '1234-987', 50340123.0, getdate(), 'Airport City, Novi Beograd', 'komercijalna@banka.rs', 1760, '');
	set identity_insert T_ORGANIZACIONE_JEDINICE off;

	set identity_insert T_ORG_JED_GRUPE on;
	insert into T_ORG_JED_GRUPE (ID, ORGANIZACIONA_JEDINICA_ID, GRUPA_ORG_JEDINICE_ID, INFORMACIJE_VEZE)
	values (1000, 1000, 1001, 'telenor je mobilna mreza...'),
		   (1001, 1000, 1000, 'telenor sadrzi telenor banku...'),
		   (1002, 1001, 1000, 'banka intesa'),
		   (1003, 1002, 1002, 'cvecara - trgovinska grupa'),
		   (1004, 1003, 1000, 'komercijalna banka'),
		   (1005, 1003, 1003, 'komercijalna banka vodi niskoprioritetne poslove (pored banke)');
	set identity_insert T_ORG_JED_GRUPE off;

	set identity_insert T_IZVRSITELJSKE_KUCE on;
	insert into T_IZVRSITELJSKE_KUCE (ID, IME_VEZE, TRAJE_DO, DATUM_DODAVANJA, LICE_ODOBRILO, LICE_ID, 
		ORGANIZACIONA_JEDINICA_ID, IZVRSITELJ_ID)
	values (1000, 'veza_1', cast('01/01/2017' as date), getdate(), 99, 1000, 1000, 1001),
		   (1001, 'veza_2', cast('01/01/2017' as date), getdate(), 1, 1000, 1001, 1002),
		   (1002, 'veza_3', cast('01/01/2017' as date), getdate(), 1, 1000, 1003, 1003),
		   (1003, 'veza_4', cast('01/01/2017' as date), getdate(), 99, 1001, 1000, 1004),
		   (1004, 'veza_5', cast('01/01/2017' as date), getdate(), 1, 1001, 1003, 1002),
		   (1005, 'veza_6', cast('01/01/2017' as date), getdate(), 1, 1002, 1000, 1000),
		   (1006, 'veza_7', cast('01/01/2017' as date), getdate(), 99, 1002, 1001, 1000),
		   (1007, 'veza_8', cast('01/01/2017' as date), getdate(), 1, 1002, 1002, 1003),
		   (1008, 'veza_9', cast('01/01/2017' as date), getdate(), 1, 1002, 1003, 1004),
		   (1009, 'veza_10', cast('01/01/2017' as date), getdate(), 1, 1003, 1003, 1004),
		   (1010, 'veza_11', cast('01/01/2017' as date), getdate(), 1, 1004, 1001, 1002),
		   (1011, 'veza_12', cast('01/01/2017' as date), getdate(), 99, 1004, 1002, 1000);
	set identity_insert T_IZVRSITELJSKE_KUCE off;

	set identity_insert T_IZVR_KUCA_GRUPE on;
	insert into T_IZVR_KUCA_GRUPE (ID, IZVRSITELJSKA_KUCA_ID, GRUPA_ORG_JEDINICE_ID, INFORMACIJE_VEZE)
	values (1000, 1000, 1000, ''),
		   (1001, 1001, 1001, ''),
		   (1002, 1002, 1002, ''),
		   (1003, 1003, 1003, ''),
		   (1004, 1004, 1000, ''),
		   (1005, 1005, 1001, ''),
		   (1006, 1006, 1002, ''),
		   (1007, 1007, 1003, ''),
		   (1008, 1008, 1000, ''),
		   (1009, 1009, 1001, ''),
		   (1010, 1010, 1002, ''),
		   (1011, 1011, 1003, '');
	set identity_insert T_IZVR_KUCA_GRUPE off;

	set identity_insert T_DUGOVANJA on;
	insert into T_DUGOVANJA (ID, LICE_ID, IZVRSITELJSKA_KUCA_ID, SUMA_DUGOVANJA, ROK_ISPLATE, RAZLOG)
	values (1000, 1000, 1000, 3500.0, cast('01/01/2017' as date), ''),
		   (1001, 1000, 1001, 4500.0, cast('02/03/2017' as date), ''),
		   (1002, 1000, 1002, 1000.0, cast('03/05/2017' as date), ''),
		   (1003, 1001, 1004, 500.0, cast('01/01/2017' as date), ''),
		   (1004, 1002, 1006, 15000.0, cast('04/05/2017' as date), ''),
		   (1005, 1002, 1008, 3700.0, cast('04/05/2017' as date), '');
	set identity_insert T_DUGOVANJA off;

	set identity_insert T_TRANSAKCIJE on;
	insert into T_TRANSAKCIJE (ID, DUGOVANJE_ID, DATUM_UPLATE, UPLATA, PORUKA)
	values (1000, 1000, getdate(), 3000.0, 'prva rata za isplatu'),
		   (1001, 1000, getdate(), 200.0, 'druga rata za isplatu'),
		   (1002, 1001, getdate(), 4500.0, ''),
		   (1003, 1003, getdate(), 499.0, ''),
		   (1004, 1004, getdate(), 7000.0, 'prva rata'),
		   (1005, 1004, getdate(), 5000.0, 'druga rata');
	set identity_insert T_TRANSAKCIJE off;
end
