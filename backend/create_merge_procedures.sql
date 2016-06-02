-- ## create_merge_procedures.sql ##

use [IZVRSITELJSKA_KUCA]
go
create procedure SP_DODAJ_DUGOVANJE
@lice_id int,
@izvrsiteljska_kuca_id int,
@suma_dugovanja numeric(10,2),
@datum_unosa datetime,
@rok_isplate date,
@razlog nchar(400)
as
begin
	merge dbo.T_DUGOVANJA as t
	using (select @lice_id, @izvrsiteljska_kuca_id, @suma_dugovanja, @datum_unosa, @rok_isplate, @razlog)
	as s (LICE_ID, IZVRSITELJSKA_KUCA_ID, SUMA_DUGOVANJA, DATUM_UNOSA, ROK_ISPLATE, RAZLOG)
	on (t.LICE_ID = s.LICE_ID and t.IZVRSITELJSKA_KUCA_ID = s.IZVRSITELJSKA_KUCA_ID and t.SUMA_DUGOVANJA =
		s.SUMA_DUGOVANJA and t.DATUM_UNOSA = s.DATUM_UNOSA and t.ROK_ISPLATE = s.ROK_ISPLATE and t.RAZLOG =
		s.RAZLOG)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (LICE_ID, IZVRSITELJSKA_KUCA_ID, SUMA_DUGOVANJA, DATUM_UNOSA, ROK_ISPLATE, RAZLOG, STATUS)
		values (@lice_id, @izvrsiteljska_kuca_id, @suma_dugovanja, @datum_unosa, @rok_isplate, @razlog, 1);
end
go
create procedure SP_DODAJ_GRUPU_ORG_JEDINICA
@ime_grupe nchar(20),
@datum_dodavanja date,
@prioritet int,
@dodatne_informacije nchar(400)
as
begin
	merge dbo.T_GRUPE_ORG_JEDINICA as t
	using (select @ime_grupe, @datum_dodavanja, @prioritet, @dodatne_informacije)
	as s (IME_GRUPE, DATUM_DODAVANJA, PRIORITET, DODATNE_INFORMACIJE)
	on (t.IME_GRUPE = s.IME_GRUPE and t.DATUM_DODAVANJA = s.DATUM_DODAVANJA and t.PRIORITET = s.PRIORITET
		and t.DODATNE_INFORMACIJE = s.DODATNE_INFORMACIJE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME_GRUPE, DATUM_DODAVANJA, PRIORITET, DODATNE_INFORMACIJE, STATUS)
		values (@ime_grupe, @datum_dodavanja, @prioritet, @dodatne_informacije, 1);
end
go
create procedure SP_DODAJ_IZVR_KUCA_GRUPU
@izvrsiteljska_kuca_id int,
@grupa_org_jedinice_id int,
@informacije_veze nchar(100)
as
begin
	merge dbo.T_IZVR_KUCA_GRUPE as t
	using (select @izvrsiteljska_kuca_id, @grupa_org_jedinice_id, @informacije_veze)
	as s (IZVRSITELJSKA_KUCA_ID, GRUPA_ORG_JEDINICE_ID, INFORMACIJE_VEZE)
	on (t.IZVRSITELJSKA_KUCA_ID = s.IZVRSITELJSKA_KUCA_ID and t.GRUPA_ORG_JEDINICE_ID = s.GRUPA_ORG_JEDINICE_ID
		and t.INFORMACIJE_VEZE = s.INFORMACIJE_VEZE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IZVRSITELJSKA_KUCA_ID, GRUPA_ORG_JEDINICE_ID, INFORMACIJE_VEZE, STATUS)
		values (@izvrsiteljska_kuca_id, @grupa_org_jedinice_id, @informacije_veze, 1); 
end
go
create procedure SP_DODAJ_IZVRSITELJA
@ime nchar(20),
@prezime nchar(20),
@sifra_ugovora nchar(15),
@plata numeric(10,2),
@datum_zaposljavanja date,
@tip_izvrsitelja_id int
as
begin
	merge dbo.T_IZVRSITELJI as t
	using (select @ime, @prezime, @sifra_ugovora, @plata, @datum_zaposljavanja, @tip_izvrsitelja_id)
	as s (IME, PREZIME, SIFRA_UGOVORA, PLATA, DATUM_ZAPOSLJAVANJA, TIP_IZVRSITELJA_ID)
	on (t.IME = s.IME and t.PREZIME = s.PREZIME and t.SIFRA_UGOVORA = s.SIFRA_UGOVORA and t.PLATA = s.PLATA
		and t.DATUM_ZAPOSLJAVANJA = s.DATUM_ZAPOSLJAVANJA and t.TIP_IZVRSITELJA_ID = s.TIP_IZVRSITELJA_ID)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME, PREZIME, SIFRA_UGOVORA, PLATA, DATUM_ZAPOSLJAVANJA, TIP_IZVRSITELJA_ID, STATUS)
		values (@ime, @prezime, @sifra_ugovora, @plata, @datum_zaposljavanja, @tip_izvrsitelja_id, 1);
end
go
create procedure SP_DODAJ_IZVRSITELJSKU_KUCU
@ime_veze nchar(40),
@traje_do date,
@datum_dodavanja datetime,
@lice_odobrilo int,
@lice_id int,
@organizaciona_jedinica_id int,
@izvrsitelj_id int
as
begin
	merge dbo.T_IZVRSITELJSKE_KUCE as t
	using (select @ime_veze, @traje_do, @datum_dodavanja, @lice_odobrilo, @lice_id, @organizaciona_jedinica_id, 
		@izvrsitelj_id)
	as s (IME_VEZE, TRAJE_DO, DATUM_DODAVANJA, LICE_ODOBRILO, LICE_ID, ORGANIZACIONA_JEDINICA_ID, IZVRSITELJ_ID)
	on (t.IME_VEZE = s.IME_VEZE and t.TRAJE_DO = s.TRAJE_DO and t.DATUM_DODAVANJA = s.DATUM_DODAVANJA and
		t.LICE_ODOBRILO = s.LICE_ODOBRILO and t.LICE_ID = s.LICE_ID and t.ORGANIZACIONA_JEDINICA_ID =
		s.ORGANIZACIONA_JEDINICA_ID and t.IZVRSITELJ_ID = s.IZVRSITELJ_ID)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME_VEZE, TRAJE_DO, DATUM_DODAVANJA, LICE_ODOBRILO, LICE_ID, ORGANIZACIONA_JEDINICA_ID, 
			IZVRSITELJ_ID, STATUS)
		values (@ime_veze, @traje_do, @datum_dodavanja, @lice_odobrilo, @lice_id, @organizaciona_jedinica_id, 
			@izvrsitelj_id, 1);
end
go
create procedure SP_DODAJ_LICE
@ime nchar(20),
@prezime nchar(20),
@datum_rodjenja date,
@jmbg nchar(12),
@adresa_stanovanja nchar(200),
@dodatne_informacije nchar(400),
@datum_dodavanja datetime
as
begin
	merge dbo.T_LICA as t
	using (select @ime, @prezime, @datum_rodjenja, @jmbg, @adresa_stanovanja, @dodatne_informacije, @datum_dodavanja)
	as s (IME, PREZIME, DATUM_RODJENJA, JMBG, ADRESA_STANOVANJA, DODATNE_INFORMACIJE, DATUM_DODAVANJA)
	on (t.IME = s.IME and t.PREZIME = s.PREZIME and t.JMBG = s.JMBG and t.ADRESA_STANOVANJA = s.ADRESA_STANOVANJA
		and t.DODATNE_INFORMACIJE = s.DODATNE_INFORMACIJE and t.DATUM_DODAVANJA = s.DATUM_DODAVANJA)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME, PREZIME, DATUM_RODJENJA, JMBG, ADRESA_STANOVANJA, DODATNE_INFORMACIJE, DATUM_DODAVANJA, STATUS)
		values (@ime, @prezime, @datum_rodjenja, @jmbg, @adresa_stanovanja, @dodatne_informacije, @datum_dodavanja, 1);
end
go
create procedure SP_DODAJ_ORG_JED_GRUPU
@organizaciona_jedinica_id int,
@grupa_org_jedinice_id int,
@informacije_veze nchar(100)
as
begin
	merge dbo.T_ORG_JED_GRUPE as t
	using (select @organizaciona_jedinica_id, @grupa_org_jedinice_id, @informacije_veze)
	as s (ORGANIZACIONA_JEDINICA_ID, GRUPA_ORG_JEDINICE_ID, INFORMACIJE_VEZE)
	on (t.ORGANIZACIONA_JEDINICA_ID = s.ORGANIZACIONA_JEDINICA_ID and t.GRUPA_ORG_JEDINICE_ID = s.GRUPA_ORG_JEDINICE_ID
		and t.INFORMACIJE_VEZE = s.INFORMACIJE_VEZE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (ORGANIZACIONA_JEDINICA_ID, GRUPA_ORG_JEDINICE_ID, INFORMACIJE_VEZE, STATUS)
		values (@organizaciona_jedinica_id, @grupa_org_jedinice_id, @informacije_veze, 1); 
end
go
create procedure SP_DODAJ_ORGANIZACIONU_JEDINICU
@ime_org_jedinice nchar(40),
@kontakt_telefon nchar(20),
@finansijsko_stanje numeric(15,2),
@datum_dodavanja date,
@glavna_lokacija nchar(40),
@email_adresa nchar(40),
@broj_zaposlenih int,
@dodatne_informacije nchar(400)
as
begin
	merge dbo.T_ORGANIZACIONE_JEDINICE as t
	using (select @ime_org_jedinice, @kontakt_telefon, @finansijsko_stanje, @datum_dodavanja, @glavna_lokacija,
		@email_adresa, @broj_zaposlenih, @dodatne_informacije)
	as s (IME_ORG_JEDINICE, KONTAKT_TELEFON, FINANSIJSKO_STANJE, DATUM_DODAVANJA, GLAVNA_LOKACIJA, EMAIL_ADRESA,
		BROJ_ZAPOSLENIH, DODATNE_INFORMACIJE)
	on (t.IME_ORG_JEDINICE = s.IME_ORG_JEDINICE and t.KONTAKT_TELEFON = s.KONTAKT_TELEFON and t.FINANSIJSKO_STANJE =
		s.FINANSIJSKO_STANJE and t.DATUM_DODAVANJA = s.DATUM_DODAVANJA and t.GLAVNA_LOKACIJA = s.GLAVNA_LOKACIJA
		and t.EMAIL_ADRESA = s.EMAIL_ADRESA and t.BROJ_ZAPOSLENIH = s.BROJ_ZAPOSLENIH and t.DODATNE_INFORMACIJE =
		s.DODATNE_INFORMACIJE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME_ORG_JEDINICE, KONTAKT_TELEFON, FINANSIJSKO_STANJE, DATUM_DODAVANJA, GLAVNA_LOKACIJA, EMAIL_ADRESA,
			BROJ_ZAPOSLENIH, DODATNE_INFORMACIJE, STATUS)
		values (@ime_org_jedinice, @kontakt_telefon, @finansijsko_stanje, @datum_dodavanja, @glavna_lokacija,
			@email_adresa, @broj_zaposlenih, @dodatne_informacije, 1);
end
go
create procedure SP_DODAJ_TIPA_IZVRSITELJA
@ime_tipa nchar(20),
@naplata_usluge numeric(10,2),
@dodatne_informacije nchar(400)
as
begin
	merge dbo.T_TIPOVI_IZVRSITELJA as t
	using (select @ime_tipa, @naplata_usluge, @dodatne_informacije)
	as s (IME_TIPA, NAPLATA_USLUGE, DODATNE_INFORMACIJE)
	on (s.IME_TIPA = t.IME_TIPA and s.NAPLATA_USLUGE = t.NAPLATA_USLUGE and t.DODATNE_INFORMACIJE =
		s.DODATNE_INFORMACIJE)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (IME_TIPA, NAPLATA_USLUGE, DODATNE_INFORMACIJE, STATUS)
		values (@ime_tipa, @naplata_usluge, @dodatne_informacije, 1);
end
go
create procedure SP_DODAJ_TRANSAKCIJU
@dugovanje_id int,
@datum_uplate datetime,
@uplata numeric(10,2),
@poruka nchar(300)
as
begin
	merge dbo.T_TRANSAKCIJE as t
	using (select @dugovanje_id, @datum_uplate, @uplata, @poruka)
	as s (DUGOVANJE_ID, DATUM_UPLATE, UPLATA, PORUKA)
	on (t.DUGOVANJE_ID = s.DUGOVANJE_ID and t.DATUM_UPLATE = s.DATUM_UPLATE and t.UPLATA = s.UPLATA and
		t.PORUKA = s.PORUKA)
	when matched then
		update set STATUS = 1
	when not matched then
		insert (DUGOVANJE_ID, DATUM_UPLATE, UPLATA, PORUKA, STATUS)
		values (@dugovanje_id, @datum_uplate, @uplata, @poruka, 1);
end
