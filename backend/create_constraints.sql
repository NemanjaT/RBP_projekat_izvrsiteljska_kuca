-- ### create_constraints.sql ###

use [IZVRSITELJSKA_KUCA]
go
begin
	-- T_LICA
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 't_lica',
									@imena_kolona = 'jmbg',
									@sufiks       = 'lica_jmbg';

	-- T_TIPOVI_IZVRSITELJA
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 't_tipovi_izvrsitelja',
									@imena_kolona = 'ime_tipa',
									@sufiks       = 'tip_izvr';

	-- T_IZVRSITELJI
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 't_izvrsitelji',
									@ime_glavne_kolone = 'tip_izvrsitelja_id',
									@ime_target_tabele = 't_tipovi_izvrsitelja',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 't_izvrsitelji',
									@imena_kolona = 'sifra_ugovora',
									@sufiks       = 'sif_ugo';

	-- T_GRUPE_ORG_JEDINICA
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 't_grupe_org_jedinica',
									@imena_kolona = 'ime_grupe',
									@sufiks       = 'goj_ime';

	-- T_ORG_JED_GRUPE
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'T_ORG_JED_GRUPE',
									@ime_glavne_kolone = 'ORGANIZACIONA_JEDINICA_ID',
									@ime_target_tabele = 't_organizacione_jedinice',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'T_ORG_JED_GRUPE',
									@ime_glavne_kolone = 'GRUPA_ORG_JEDINICE_ID',
									@ime_target_tabele = 't_grupe_org_jedinica',
									@ime_target_kolone = 'id';

	-- T_IZVRSITELJSKE_KUCE
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'T_IZVRSITELJSKE_KUCE',
									@ime_glavne_kolone = 'lice_id',
									@ime_target_tabele = 't_lica',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'T_IZVRSITELJSKE_KUCE',
									@ime_glavne_kolone = 'organizaciona_jedinica_id',
									@ime_target_tabele = 't_organizacione_jedinice',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'T_IZVRSITELJSKE_KUCE',
									@ime_glavne_kolone = 'izvrsitelj_id',
									@ime_target_tabele = 't_izvrsitelji',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_UK_CONSTRAINT @ime_tabele   = 'T_IZVRSITELJSKE_KUCE',
									@imena_kolona = 'ime_veze',
									@sufiks       = 'ime_veze';

	-- T_IZVR_KUCA_GRUPE
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'T_IZVR_KUCA_GRUPE',
									@ime_glavne_kolone = 'izvrsiteljska_kuca_id',
									@ime_target_tabele = 't_izvrsiteljske_kuce',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 'T_IZVR_KUCA_GRUPE',
									@ime_glavne_kolone = 'GRUPA_ORG_JEDINICE_ID',
									@ime_target_tabele = 't_grupe_org_jedinica',
									@ime_target_kolone = 'id';

	-- T_DUGOVANJA
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 't_dugovanja',
									@ime_glavne_kolone = 'lice_id',
									@ime_target_tabele = 't_lica',
									@ime_target_kolone = 'id';
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 't_dugovanja',
									@ime_glavne_kolone = 'izvrsiteljska_kuca_id',
									@ime_target_tabele = 't_izvrsiteljske_kuce',
									@ime_target_kolone = 'id';

	-- T_TRANSAKCIJE
	exec dbo.SP_DODAJ_FK_CONSTRAINT @ime_glavne_tabele = 't_transakcije',
									@ime_glavne_kolone = 'dugovanje_id',
									@ime_target_tabele = 't_dugovanja',
									@ime_target_kolone = 'id';
end
