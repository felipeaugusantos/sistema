unit untQckLoteSeparacaoWMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, untZClient;

type
  TfrmQckLoteSeparacaoWMS = class(TForm)
    frxReport: TfrxReport;
    frxMovGer: TfrxDBDataset;
  private

    function fGetSql : String;
    function fTemFR3 : Boolean;
    { Private declarations }
  public
    { Public declarations }
    FCdsRelatorio : TZClient;
    class procedure pImprime(ANumLot, ACodEmp, ACodSep: string; ASeqSep: integer);
  end;


implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmQckLoteSeparacaoWMS }

function TfrmQckLoteSeparacaoWMS.fGetSql: String;
begin
  Result := EmptyStr;

  Result := Result + 'SELECT EMP.EMP_NOMEMP AS NOMEMP, EMP.EMP_ENDERE AS EENDER, EMP.EMP_ENDNUM AS EENDNU, EMP.EMP_BAIRRO AS EBAIRR, EMP.EMP_C_E_P_ AS EMPCEP, EMP.EMP_C_G_C_ AS CGCEMP, ';
  Result := Result + '       EMP.EMP_I_E_S_ AS IESEMP, EMP.EMP_EMAIL_ AS EMAEMP, EMP.EMP_FONE01 AS EMPFO1, EMP.EMP_F_A_X_ AS FAXEMP,                                                     ';
  Result := Result + '       (SELECT CID.CID_NOMCID FROM CADCID CID INNER JOIN CADEMP EMP ON(CID.CID_CODCID = EMP.EMP_CODCID) WHERE EMP.EMP_CODEMP = G.RLG_CODEMP) AS ENDNCI,            ';
  Result := Result + '       (SELECT CID.CID_ESTADO FROM CADCID CID INNER JOIN CADEMP EMP ON(CID.CID_CODCID = EMP.EMP_CODCID) WHERE EMP.EMP_CODEMP = G.RLG_CODEMP) AS EESTAD,            ';
  Result := Result + '       CLI.CLI_NOMCLI AS NOMCLI, CLI.CLI_FANSOB AS FANSOB, CLI.CLI_ENDERE AS ETENDE, CLI.CLI_C_G_C_ AS CGCCLI, CLI.CLI_CODCLI AS CODCLI, CLI.CLI_FONE01 AS FONE01, ';
  Result := Result + '       CLI.CLI_BAIRRO AS ETBAIR, CLI.CLI_C_E_P_ AS ETRCEP, CLI.CLI_I_E_S_ AS IESRGC,                                                                               ';
  Result := Result + '       (SELECT CID.CID_NOMCID FROM CADCID CID INNER JOIN CADCLI CLI ON(CID.CID_CODCID = CLI.CLI_CODCID) WHERE CLI.CLI_CODCLI = F.FGO_CODCLI) AS ETNCID,            ';
  Result := Result + '       (SELECT CID.CID_ESTADO FROM CADCID CID INNER JOIN CADCLI CLI ON(CID.CID_CODCID = CLI.CLI_CODCID) WHERE CLI.CLI_CODCLI = F.FGO_CODCLI) AS ETESTA,            ';
  Result := Result + '       F.FGO_CONPAG AS CONPAG, CND.CND_CODIGO AS CODCND, CND.CND_DESCRI AS DESCND, FPG.FPG_CODIGO AS CODFPG, FPG.FPG_DESCRI AS DESFPG,                             ';
  Result := Result + '       OPE.OPE_CODOPE AS CODVEN, OPE.OPE_NOMOPE AS NOMVEN, OP.OPE_CODOPE AS CODDIG, OP.OPE_NOMOPE AS NOMDIG,                                                       ';
  Result := Result + '       T.TRA_CODTRA AS CODTRA, T.TRA_NOMTRA AS NOMTRA, T.TRA_FONE01 AS FONTRA, LOT.LOT_LOCFIS AS LOCFIS, SUM(L.LDO_QTDITE) AS QTDITE, UNI.UNI_SIGUNI AS SIGUNI,    ';
  Result := Result + '       D.FDO_CODITE AS CODITE, C.ITE_DESITE AS DESITE, G.RLG_NUMLOT AS NUMLOT, E.FDO_SEQSEP AS SEQSEP                                                              ';
  Result := Result + 'FROM FATGOR F                                                                                                                                                      ';
  Result := Result + 'INNER JOIN FATDOR D                                                                                                                                                ';
  Result := Result + 'ON(F.AUTOINCREM = D.FDO_SEQGER)                                                                                                                                    ';
  Result := Result + 'INNER JOIN EXTGOR EG                                                                                                                                               ';
  Result := Result + 'ON(EG.FGO_SEQFGO = D.FDO_SEQGER)                                                                                                                                   ';
  Result := Result + 'INNER JOIN EXTDOR E                                                                                                                                                ';
  Result := Result + 'ON(D.AUTOINCREM = E.FDO_SEQFDO)                                                                                                                                    ';
  Result := Result + 'INNER JOIN LOTDOR L                                                                                                                                                ';
  Result := Result + 'ON(D.AUTOINCREM = L.LDO_SEQFDO)                                                                                                                                    ';
  Result := Result + 'INNER JOIN ROMLDE R                                                                                                                                                ';
  Result := Result + 'ON(D.FDO_NUMDOC = R.RLD_NUMDOC AND D.FDO_ESPDOC = R.RLD_ESPDOC AND D.FDO_CODEMP = R.RLD_CODEMP)                                                                    ';
  Result := Result + 'INNER JOIN ROMLGE G                                                                                                                                                ';
  Result := Result + 'ON(R.RLD_SEQRLG = G.AUTOINCREM)                                                                                                                                    ';
  Result := Result + 'INNER JOIN CADLOT LOT                                                                                                                                              ';
  Result := Result + 'ON(L.LDO_NUMLOT = LOT.LOT_NUMLOT AND EG.FGO_EMPEXP = LOT.LOT_CODEMP AND D.FDO_CODITE = LOT.LOT_CODITE)                                                             ';
  Result := Result + 'INNER JOIN CADLOC LOC                                                                                                                                              ';
  Result := Result + 'ON(LOT.LOT_LOCFIS = LOC.LOC_CODLOC AND LOT.LOT_CODEMP = LOC.LOC_CODEMP)                                                                                            ';
  Result := Result + 'INNER JOIN CADITE C                                                                                                                                                ';
  Result := Result + 'ON(D.FDO_CODITE = C.ITE_CODITE)                                                                                                                                    ';
  Result := Result + 'INNER JOIN CADUNI UNI                                                                                                                                              ';
  Result := Result + 'ON(C.ITE_CODUNI = UNI.UNI_CODUNI)                                                                                                                                  ';
  Result := Result + 'INNER JOIN CADEMP EMP                                                                                                                                              ';
  Result := Result + 'ON(F.FGO_CODEMP = EMP.EMP_CODEMP)                                                                                                                                  ';
  Result := Result + 'INNER JOIN CADCLI CLI                                                                                                                                              ';
  Result := Result + 'ON(F.FGO_CODCLI = CLI.CLI_CODCLI)                                                                                                                                  ';
  Result := Result + 'INNER JOIN CADOPE OPE                                                                                                                                              ';
  Result := Result + 'ON(F.FGO_CODVEN = OPE.OPE_CODOPE)                                                                                                                                  ';
  Result := Result + 'INNER JOIN CADOPE OP                                                                                                                                               ';
  Result := Result + 'ON(F.FGO_CODDIG = OP.OPE_CODOPE)                                                                                                                                   ';
  Result := Result + 'LEFT JOIN CADTRA T                                                                                                                                                 ';
  Result := Result + 'ON(G.RLG_CODTRA = T.TRA_CODTRA)                                                                                                                                    ';
  Result := Result + 'INNER JOIN CADCND CND                                                                                                                                              ';
  Result := Result + 'ON(F.FGO_CODCND = CND.CND_CODIGO)                                                                                                                                  ';
  Result := Result + 'INNER JOIN CADFPG FPG                                                                                                                                              ';
  Result := Result + 'ON(F.FGO_CODFPG = FPG.FPG_CODIGO)                                                                                                                                  ';
  Result := Result + 'WHERE G.RLG_NUMLOT = :NUMLOT                                                                                                                                       ';
  Result := Result + 'AND G.RLG_CODEMP = :CODEMP                                                                                                                                         ';
  Result := Result + 'AND E.FDO_OPESEP = :CODSEP                                                                                                                                         ';
  Result := Result + 'AND E.FDO_SEQSEP = :SEQSEP                                                                                                                                         ';
  Result := Result + 'GROUP BY NUMLOT, SEQSEP, CODITE                                                                                                                                    ';
  Result := Result + 'ORDER BY LOCFIS, CODITE                                                                                                                                            ';
end;

function TfrmQckLoteSeparacaoWMS.fTemFR3: Boolean;
begin
  Result := FileExists(fCfgSis('PATETI') + '\SeparacaoWMS.fr3');
end;

class procedure TfrmQckLoteSeparacaoWMS.pImprime(ANumLot, ACodEmp,
  ACodSep: string; ASeqSep: integer);
var
  frmQckLoteSeparacaoWMS: TfrmQckLoteSeparacaoWMS;
begin
  pCriarFormularios(TfrmQckLoteSeparacaoWMS, frmQckLoteSeparacaoWMS);

  try
    frmQckLoteSeparacaoWMS.FCdsRelatorio := TZClient.Create(frmQckLoteSeparacaoWMS, frmQckLoteSeparacaoWMS.fGetSql);
    frmQckLoteSeparacaoWMS.FCdsRelatorio.qryQuery.ParamByName('NUMLOT').AsString := ANumLot;
    frmQckLoteSeparacaoWMS.FCdsRelatorio.qryQuery.ParamByName('CODEMP').AsString := ACodEmp;
    frmQckLoteSeparacaoWMS.FCdsRelatorio.qryQuery.ParamByName('CODSEP').AsString := ACodSep;
    frmQckLoteSeparacaoWMS.FCdsRelatorio.qryQuery.ParamByName('SEQSEP').AsInteger := ASeqSep;
    frmQckLoteSeparacaoWMS.FCdsRelatorio.fAbreClient(True, 'TfrmQckLoteSeparacaoWMS.pImprime');

    if frmQckLoteSeparacaoWMS.FCdsRelatorio.IsEmpty Then
      Exit;

    if frmQckLoteSeparacaoWMS.fTemFR3 then
      frmQckLoteSeparacaoWMS.frxReport.LoadFromFile(fCfgSis('PATETI') + '\SeparacaoWMS.fr3');

    frmQckLoteSeparacaoWMS.frxMovGer.DataSet := frmQckLoteSeparacaoWMS.FCdsRelatorio;

    If frmQckLoteSeparacaoWMS.frxReport.PrepareReport Then
      pPreviewReport('frmQckLoteSeparacaoWMS', 'Lote Separação WMS', frmQckLoteSeparacaoWMS.frxReport);
  finally
    pFreeAndNil(frmQckLoteSeparacaoWMS);
  end;
end;

end.
