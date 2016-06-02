-- ### create_triggers.sql ###

use [IZVRSITELJSKA_KUCA]
go
create trigger TRG_DUGOVANJA
on dbo.T_DUGOVANJA
after insert
as
begin
	set nocount on;
	update dbo.T_DUGOVANJA
	set DATUM_UNOSA = getdate()
	from dbo.T_DUGOVANJA inc
	join inserted i on i.ID = inc.ID
	where i.ID = inc.ID;
end
go
create trigger TRG_GRUPE_ORG_JEDINICA
on dbo.T_GRUPE_ORG_JEDINICA
after insert
as
begin
	set nocount on;
	update dbo.T_GRUPE_ORG_JEDINICA
	set DATUM_DODAVANJA = getdate()
	from dbo.T_GRUPE_ORG_JEDINICA inc
	join inserted i on i.ID = inc.ID
	where i.ID = inc.ID;
end
go
create trigger TRG_IZVRSITELJI
on dbo.T_IZVRSITELJI
after insert
as
begin
	set nocount on;
	update dbo.T_IZVRSITELJI
	set DATUM_ZAPOSLJAVANJA = getdate()
	from dbo.T_IZVRSITELJI inc
	join inserted i on i.ID = inc.ID
	where i.ID = inc.ID;
end
go
create trigger TRG_IZVRSITELJSKE_KUCE
on dbo.T_IZVRSITELJSKE_KUCE
after insert
as
begin
	set nocount on;
	update dbo.T_IZVRSITELJSKE_KUCE
	set DATUM_DODAVANJA = getdate()
	from dbo.T_IZVRSITELJSKE_KUCE inc
	join inserted i on i.ID = inc.ID
	where i.ID = inc.ID;
end
go
create trigger TRG_LICA
on dbo.T_LICA
after insert
as
begin
	set nocount on;
	update dbo.T_LICA
	set DATUM_DODAVANJA = getdate()
	from dbo.T_LICA inc
	join inserted i on i.ID = inc.ID
	where i.ID = inc.ID;
end
go
create trigger TRG_ORGANIZACIONE_JEDINICE
on dbo.T_ORGANIZACIONE_JEDINICE
after insert
as
begin
	set nocount on;
	update dbo.T_ORGANIZACIONE_JEDINICE
	set DATUM_DODAVANJA = getdate()
	from dbo.T_ORGANIZACIONE_JEDINICE inc
	join inserted i on i.ID = inc.ID
	where i.ID = inc.ID;
end
go
create trigger TRG_TRANSAKCIJE
on dbo.T_TRANSAKCIJE
after insert
as
begin
	set nocount on;
	update dbo.T_TRANSAKCIJE
	set DATUM_UPLATE = getdate()
	from dbo.T_TRANSAKCIJE inc
	join inserted i on i.ID = inc.ID
	where i.ID = inc.ID;
end
