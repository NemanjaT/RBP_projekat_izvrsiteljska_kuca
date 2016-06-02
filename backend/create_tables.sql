-- ### create_tables.sql ###

use [IZVRSITELJSKA_KUCA]
go
begin
	declare @definicija_tabele nchar(4000);
	
	-- T_LICA
	set @definicija_tabele = 
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime', 20, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('prezime', 20, 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_rodjenja', 1, 0) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('jmbg', 12, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('adresa_stanovanja', 200, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 400, 0, '') +
		dbo.FU_NAPRAVI_DATETIME_KOLONU('datum_dodavanja', 1, 1) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_lica',
							   @parametri  = @definicija_tabele;

	-- T_TIPOVI_IZVRSITELJA
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime_tipa', 20, 1, null) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('naplata_usluge', 10, 2, 1, 0.0) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 400, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_tipovi_izvrsitelja',
							   @parametri  = @definicija_tabele;

	-- T_IZVRSITELJI
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime', 20, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('prezime', 20, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('sifra_ugovora', 15, 1, null) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('plata', 10, 2, 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_zaposljavanja', 1, 1) +
		dbo.FU_NAPRAVI_INT_KOLONU('tip_izvrsitelja_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_izvrsitelji',
							   @parametri  = @definicija_tabele;

	-- T_GRUPE_ORG_JEDINICA
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime_grupe', 20, 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_dodavanja', 1, 1) +
		dbo.FU_NAPRAVI_INT_KOLONU('prioritet', 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 400, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_grupe_org_jedinica',
							   @parametri  = @definicija_tabele;

	-- T_ORGANIZACIONE_JEDINICE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime_org_jedinice', 40, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('kontakt_telefon', 20, 1, null) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('finansijsko_stanje', 15, 2, 1, 0.0) +
		dbo.FU_NAPRAVI_DATE_KOLONU('datum_dodavanja', 1, 1) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('glavna_lokacija', 40, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('email_adresa', 40, 0, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('broj_zaposlenih', 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('dodatne_informacije', 400, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_organizacione_jedinice',
							   @parametri  = @definicija_tabele;

	-- T_ORG_JED_GRUPE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('organizaciona_jedinica_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('grupa_org_jedinice_id', 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('informacije_veze', 100, 0, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_org_jed_grupe',
							   @parametri  = @definicija_tabele;

	-- T_IZVRSITELJSKE_KUCE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_NCHAR_KOLONU('ime_veze', 40, 1, null) +
		dbo.FU_NAPRAVI_DATE_KOLONU('traje_do', 1, 0) +
		dbo.FU_NAPRAVI_DATETIME_KOLONU('datum_dodavanja', 1, 1) +
		dbo.FU_NAPRAVI_INT_KOLONU('lice_odobrilo', 1, 99) +
		dbo.FU_NAPRAVI_INT_KOLONU('lice_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('organizaciona_jedinica_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('izvrsitelj_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_izvrsiteljske_kuce',
							   @parametri  = @definicija_tabele;

	-- T_IZVR_KUCA_GRUPE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('izvrsiteljska_kuca_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('grupa_org_jedinice_id', 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('informacije_veze', 100, 0, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_izvr_kuca_grupe',
							   @parametri  = @definicija_tabele;

	-- T_DUGOVANJA
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('lice_id', 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('izvrsiteljska_kuca_id', 1, null) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('suma_dugovanja', 10, 2, 1, null) +
		dbo.FU_NAPRAVI_DATETIME_KOLONU('datum_unosa', 1, 1) +
		dbo.FU_NAPRAVI_DATE_KOLONU('rok_isplate', 1, 0) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('razlog', 400, 1, null) +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_dugovanja',
							   @parametri  = @definicija_tabele;

	-- T_TRANSAKCIJE
	set @definicija_tabele =
		dbo.FU_NAPRAVI_INT_KOLONU('dugovanje_id', 1, null) +
		dbo.FU_NAPRAVI_DATETIME_KOLONU('datum_uplate', 1, 1) +
		dbo.FU_NAPRAVI_NUMERIC_KOLONU('uplata', 10, 2, 1, null) +
		dbo.FU_NAPRAVI_NCHAR_KOLONU('poruka', 300, 0, '') +
		dbo.FU_NAPRAVI_INT_KOLONU('status', 1, 1);
	exec dbo.SP_NAPRAVI_TABELU @ime_tabele = 't_transakcije',
							   @parametri  = @definicija_tabele;
end
