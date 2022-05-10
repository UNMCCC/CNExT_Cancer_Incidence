use UNM_CNExTCases;
select 
     RTRIM(F00009) as fname ,RTRIM(F00008) as lastname 
	,RTRIM(F00006) as mrn
    ,F00022 as sex -- 1 male, 2 fem.
    ,F00021 as race -- codes
	,f00029 as tumorDateDx
	,RTRIM(f00089) as primsite
	,f00152 as siteICD_0_3
	,f01075 as histTypeICD_O_32-- subset minus 1 of 1074 --- ,F02502 as HistType2 (same)
	,f01076 as behavior      --			 ,F02504 as behavior2 (same)  
	,RTRIM(F00015) as zipAtDx
	,RTRIM(F00020) as AgeAtDX
from DxStg 
join tumor   on DxStg.fk2 = tumor.UK
join patient on patient.uk = tumor.FK1
left join hospital on tumor.uk = hospital.fk2
left join PatExtended on Patient.UK=PatExtended.UK
where 
  F00029 >= '20160101' -- Since 2016 (unreliable before)
  and f01076<=4
  and f01350 like '%UNM%' --UNMCC','UNM, Albuquerque, NM','UNMH; Albuquerque, NM','UNM~~','UNMH','UNMH Albuquerque, NM (0006850037)'
  OR f01350 like '%University of New Mexico%' --'0006850037 University of New Mexico Hospital','University of New Mexico','University of New Mexico Hosp in Albuq, NM',,'University of New Mexico Hosp in Albuq, NM','
  
order by siteICD_0_3,mrn
   ------- example counts;  for 2018
  --LIP <150:        108 (105)
  --esoph <160:       27 (32)  Curious case.
  --stom <170:        56 (45)
  --small intes<179:  12 (11)
  --colon <199:      114 (99)
  --rectum =209       63 (55)
  --anus 210-218      10 (10)
  --liver 220         52 (34)
  --pancreas 250-59  105 (92)
  --oth dig  221-269 143 (24)
  --kaposi 9140
  --ovarie 569        19 (22)  Weird
  --prosta c619     181 (174)
  --kidney 649       92 (75)