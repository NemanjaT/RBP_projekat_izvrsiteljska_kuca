-- ### create_users.sql ###

use [master]
go
begin
	create login DB_ADMIN with password = 'lozinka';
	create login DB_KORISNIK with password = 'lozinka';
	create login DB_PRIV with password = 'lozinka';
	alter login DB_ADMIN enable;
	alter login DB_KORISNIK enable;
	alter login DB_PRIV enable;
end
go
use [IZVRSITELJSKA_KUCA]
go
begin
	create user DB_ADMIN for login DB_ADMIN;
	create user DB_KORISNIK for login DB_KORISNIK;
	create user DB_PRIV for login DB_PRIV;
	
	-- admin grantovi ...
	exec sp_addrolemember 'db_owner', 'DB_ADMIN';
	
	-- korisnik grantovi ...
	grant select on dbo.V_DUGOVANJA to DB_KORISNIK;
	grant select on dbo.V_GRUPE_ORG_JEDINICA to DB_KORISNIK;
	grant select on [dbo].[V_IZVR_KUCA_GRUPE] to DB_KORISNIK;
	grant select on [dbo].[V_IZVRSITELJI] to DB_KORISNIK;
	grant select on [dbo].[V_IZVRSITELJSKE_KUCE] to DB_KORISNIK;
	grant select on [dbo].[V_LICA] to DB_KORISNIK;
	grant select on [dbo].[V_ORG_JED_GRUPE] to DB_KORISNIK;
	grant select on [dbo].[V_ORGANIZACIONE_JEDINICE] to DB_KORISNIK;
	grant select on [dbo].[V_TIPOVI_IZVRSITELJA] to DB_KORISNIK;
	grant select on [dbo].[V_TRANSAKCIJE] to DB_KORISNIK;
	
	-- priv grantovi
	grant select on dbo.V_DUGOVANJA to DB_PRIV;
	grant select on dbo.V_GRUPE_ORG_JEDINICA to DB_PRIV;
	grant select on [dbo].[V_IZVR_KUCA_GRUPE] to DB_PRIV;
	grant select on [dbo].[V_IZVRSITELJI] to DB_PRIV;
	grant select on [dbo].[V_IZVRSITELJSKE_KUCE] to DB_PRIV;
	grant select on [dbo].[V_LICA] to DB_PRIV;
	grant select on [dbo].[V_ORG_JED_GRUPE] to DB_PRIV;
	grant select on [dbo].[V_ORGANIZACIONE_JEDINICE] to DB_PRIV;
	grant select on [dbo].[V_TIPOVI_IZVRSITELJA] to DB_PRIV;
	grant select on [dbo].[V_TRANSAKCIJE] to DB_PRIV;

	grant execute on dbo.SP_NAPRAVI_TABELU to DB_PRIV;
	grant execute on dbo.SP_DODAJ_FK_CONSTRAINT to DB_PRIV;
	grant execute on dbo.SP_DODAJ_UK_CONSTRAINT to DB_PRIV;

	-- stari grantovi su sada zamenjeni sa stornim procedurama koje to rade...
	-- ostavljeni su update grant-ovi zato sto se recordi brisu tako sto se STATUS update-uje na '99'
	grant update on [dbo].[T_DUGOVANJA] to DB_PRIV;
	grant update on [dbo].[T_GRUPE_ORG_JEDINICA] to DB_PRIV;
	grant update on [dbo].[T_IZVR_KUCA_GRUPE] to DB_PRIV;
	grant update on [dbo].[T_IZVRSITELJI] to DB_PRIV;
	grant update on [dbo].[T_IZVRSITELJSKE_KUCE] to DB_PRIV;
	grant update on [dbo].[T_LICA] to DB_PRIV;
	grant update on [dbo].[T_ORG_JED_GRUPE] to DB_PRIV;
	grant update on [dbo].[T_ORGANIZACIONE_JEDINICE] to DB_PRIV;
	grant update on [dbo].[T_TIPOVI_IZVRSITELJA] to DB_PRIV;
	grant update on [dbo].[T_TRANSAKCIJE] to DB_PRIV;

	grant execute on [dbo].[SP_DODAJ_DUGOVANJE] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_GRUPU_ORG_JEDINICA] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_IZVR_KUCA_GRUPU] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_IZVRSITELJA] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_IZVRSITELJSKU_KUCU] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_LICE] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_ORG_JED_GRUPU] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_ORGANIZACIONU_JEDINICU] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_TIPA_IZVRSITELJA] to DB_PRIV;
	grant execute on [dbo].[SP_DODAJ_TRANSAKCIJU] to DB_PRIV;
end
go
use [master]
go
begin
	create user DB_ADMIN for login DB_ADMIN;
	create user DB_KORISNIK for login DB_KORISNIK;
	create user DB_PRIV for login DB_PRIV;
	exec sp_addrolemember 'db_owner', 'DB_ADMIN';
end
