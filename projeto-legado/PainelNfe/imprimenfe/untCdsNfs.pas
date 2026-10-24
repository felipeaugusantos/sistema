unit untCdsNfs;

interface

uses
{$IF Defined(LINUX)}
  untUtil, DB, untUniClientDataSet;
{$ELSE}
  {$IF Defined(UNIDAC)}
    UniClientDataSet, Uni, MySQLUniProvider, UniProvider,
  {$ELSE}
   ZConnection, ZDataset, ZDbcIntfs,
  {$IFEND}
  untUniClientDataSet, DB;
{$IFEND}

type
  TCdsNfs = class
    public
      class function fCriaCdsNfs: TUniClientDataSet;
      class function fCriaCdsFaturas: TUniClientDataSet;
      class function fCriaCdsItens: TUniClientDataSet;
 end;

implementation

{ TCriaCdsNfs }

class function TCdsNfs.fCriaCdsItens: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODSER'; DataType := ftString; Size := 5;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMNFS'; DataType := ftString; Size := 15;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITEDES'; DataType := ftString; Size := 500; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITEQTD'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRUNT'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRTOT'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'UNIDAD'; DataType := ftString; Size := 2;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRSRV'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BASCAL'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALIISS'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRISS'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRDES'; DataType := ftFloat;               End;
  Result.CreateDataSet;
end;

class function TCdsNfs.fCriaCdsFaturas: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMNFS'; DataType := ftString; Size := 15; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'FATNUM'; DataType := ftString; Size := 5;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALFAT'; DataType := ftFloat;              End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTAVEN'; DataType := ftString; Size := 10; End;
  Result.CreateDataSet;
end;

class function TCdsNfs.fCriaCdsNfs: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMNFS';   DataType := ftString; Size := 15;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODVER';   DataType := ftString; Size := 50;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ASSPRE';   DataType := ftString; Size := 32;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTAHRA';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTAEMI';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMRPS';   DataType := ftString; Size := 15;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'SERRPS';   DataType := ftString; Size := 05;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TPORPS';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'EMIRPS';   DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NATOPE';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NATOPE_XML'; DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODRET';   DataType := ftString; Size := 2;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'EMIOSN';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DEDMAT';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ISSPAG';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'EMIICC';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'COMPET';   DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'OUTINF';   DataType := ftString; Size := 1000; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRSER';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ISS_RET';  DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRISS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BSCISS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALIISS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLISSR';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRLIQ';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODSER';   DataType := ftString; Size := 100; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CDCNAE';   DataType := ftString; Size := 15;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODTRI';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DISCRI';   DataType := ftMemo;                End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODMUN';   DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITEDESC';  DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITEQTD';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ITEVLU';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVCNPJ';  DataType := ftString; Size := 18;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVDOC_';  DataType := ftString; Size := 18;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVIM';    DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVIE';    DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVRAZAO'; DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVFANT';  DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVEND';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVNUM';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVCOMPL'; DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVBAIR';  DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVMUN';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CIDPRE';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVUF';    DataType := ftString; Size := 02;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVCEP';   DataType := ftString; Size := 09;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVFONE';  DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVEMAIL'; DataType := ftString; Size := 256  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PREMAI';   DataType := ftString; Size := 256  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVIBGE';  DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSCNPJ';  DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSIM';    DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSIE';    DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSRAZAO'; DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSFANTA'; DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSEND';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSNUM';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSCOMPL'; DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSBAIR';  DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSPAIS';  DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSMUN';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSIBGE';  DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSUF';    DataType := ftString; Size := 02;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSCEP';   DataType := ftString; Size := 08;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSFONE';  DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSCELU';  DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSEMAIL'; DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ORGMUN';   DataType := ftString; Size := 50;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ORG_UF';   DataType := ftString; Size := 02;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IEPRES';   DataType := ftString; Size := 15;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'FONPRE';   DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'EMAPRE';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTHRCA';   DataType := ftString; Size := 25;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODDES';   DataType := ftString; Size := 12;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ISSRET';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'INSRES';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALEXT';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CNAEFI';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMDAN';   DataType := ftString; Size := 50;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NOMDES';   DataType := ftString; Size := 80;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IMDEST';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NOMPRE';   DataType := ftString; Size := 80;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'SERIE';    DataType := ftString; Size := 05;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALLIQ';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NFSSUB';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'MUNPRE';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'MUNINC';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRDED';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRPIS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRCOF';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRINS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRIR_';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRCSL';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'OUT_RET';  DataType := ftFloat;               End;


  With Result.FieldDefs.AddFieldDef Do Begin Name := 'OUTTRI';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLICMS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLCIDE';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRIPI';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRIOF';   DataType := ftFloat;               End;

  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESCONC';  DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESCONI';  DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODOBR';   DataType := ftString; Size := 7;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODART';   DataType := ftString; Size := 7;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BCINSS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALQINS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALINS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BC_PIS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALQPIS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALPIS';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BCCOFI';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALQCOF';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALCOF';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BCIRRF';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALQIRR';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALIRR';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BCCSLL';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALQCSL';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALCSL';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TIPREC';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := '_LINK_';   DataType := ftString; Size := 512; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'EXIGIB';   DataType := ftInteger;             End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESEXI';   DataType := ftString; Size := 60;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'HRAEMI';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'STSRPS';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'EXIISS';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMPAR';   DataType := ftInteger;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CHANFS';   DataType := ftString; Size := 60;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALCRE';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TOTIMP';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVCODUF'; DataType := ftString; Size := 5;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVCID';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSFANT';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TOMIE';    DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALDED';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALTOT';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VALRET';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IMPDEV';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IMPRET';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DISSER';   DataType := ftMemo;                End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IDNTFIS';  DataType := ftString; Size := 15;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'OBSERV';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTAVEN';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'STATUS';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'LOCPAG';   DataType := ftString; Size := 60;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'FRMPAG';   DataType := ftString; Size := 25;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TMSMUNIC'; DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVCODPA'; DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'STARPS';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RESRET';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESSER';   DataType := ftMemo;                End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTVENISS'; DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TOTRIB';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TRBSIT';   DataType := ftString; Size := 2;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'SERNFS';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RESPTRIB'; DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'INCULT';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODPRE';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'INFCOM';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'HOMEPA';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'MUNTOM';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VENCTO';   DataType := ftString; Size := 15;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PARCEL';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTAVCT';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRPAR';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'FPAGTO';   DataType := ftString; Size := 80;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DISCRDED'; DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'LOCPRE';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'LOCNUM';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'LOCCPL';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'LOCBAI';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'LOCMUN';   DataType := ftString; Size := 256; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'LOCCEP';   DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'LOC_UF';   DataType := ftString; Size := 2;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRCPP';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RETPIS';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RETCFS';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RETINS';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RETIR_';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RETCSL';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RETCPP';   DataType := ftString; Size := 1;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLRCRE';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VCTISS';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'SITUAC';   DataType := ftString; Size := 30;  End;
  //Novos campos por conta da criação do Portal Nacional da NFS-e
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NFSEID';   DataType := ftString; Size := 50;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTANFS';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'HRANFS';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMDPS';   DataType := ftString; Size := 15;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'SERDPS';   DataType := ftString; Size := 05;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DTADPS';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'HRADPS';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVOSN';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVREG';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CDTRNAC';  DataType := ftString; Size := 10;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CDTRMUN';  DataType := ftString; Size := 05;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PAIPRE';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CDISSQN';  DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PAISRES';  DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'REGESP';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TIPIMU';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'SUSEXI';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMPRO';   DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BENMUN';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CALCBM';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VAL_CP';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TRIFED';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TRIEST';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TRIMUN';   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'INFCPL';   DataType := ftString; Size := 1000; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DSTRNAC';  DataType := ftString; Size := 1000; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DSTRMUN';  DataType := ftString; Size := 1000; End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESCOUT';  DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PSVESP';   DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ISSRETIDO'; DataType := ftString; Size := 01;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CODNBS';    DataType := ftString; Size := 15;  End;

  With Result.FieldDefs.AddFieldDef Do Begin Name := 'FINNFS';                 DataType := ftString; Size := 20;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BC____';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IBSUF_';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RedAliqUF';              DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'AliqEfetUF';             DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IBSMun';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RedAliqMun';             DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'AliqEfetMun';            DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'CBS___';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RedAliqCBS';             DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'AliqEfetCBS';            DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'TotNF_';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gTribCompraGov_pIBSUF';  DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gTribCompraGov_vIBSUF';  DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gTribCompraGov_pIBSMun'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gTribCompraGov_vIBSMun'; DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gTribCompraGov_pCBS';    DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gTribCompraGov_vCBS';    DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IBSTot';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gIBS_pCredPresIBS';      DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gIBS_vCredPresIBS';      DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gIBS_vDifUF';            DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gIBS_vIBSUF';            DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gIBS_vDifMun';           DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gIBS_vIBSMun';           DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gCBS_pCredPresCBS';      DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gCBS_vCredPresCBS';      DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gCBS_vDifCBS';           DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gCBS_vCBS';              DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ChaveNFSeNacional';      DataType := ftString; Size := 50;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'BCPISCOFINS';            DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALIQPIS';                DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ALIQCOFINS';             DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'RETPISCOFINS';           DataType := ftString; Size := 1;   End;

  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gIBSCBS_CST';            DataType := ftString; Size := 3;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'gIBSCBS_cClassTrib';     DataType := ftString; Size := 6;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IBSCBS_cIndOp';          DataType := ftString; Size := 6;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'pIBSUF';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'pIBSMun';                DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'pCBS';                   DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'vIBSTot';                DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'IBSCBS_vBC';             DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'cIntContrib';            DataType := ftString; Size := 7;   End;

  With Result.FieldDefs.AddFieldDef Do Begin Name := 'pTotTribFed';            DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'pTotTribEst';            DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'pTotTribMun';            DataType := ftFloat;               End;

  // Campos referente veículo
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'PLAVEI';                 DataType := ftString; Size := 7;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESVEI';                 DataType := ftString; Size := 30;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'KM_VEI';                 DataType := ftInteger;             End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESMAR';                 DataType := ftString; Size := 40;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESMOD';                 DataType := ftString; Size := 60;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'ANOVEI';                 DataType := ftString; Size := 5;   End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'DESCOR';                 DataType := ftString; Size := 40;  End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'NUMVEI';                 DataType := ftString; Size := 20;  End;

  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLTFED';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLTEST';                 DataType := ftFloat;               End;
  With Result.FieldDefs.AddFieldDef Do Begin Name := 'VLTMUN';                 DataType := ftFloat;               End;

  Result.CreateDataSet;

end;

end.
