unit untReqEnvioMatVidroSelDoc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids,
  DBGridCitel, DBGrids, Buttons, ExtCtrls, BitBtnLockedIncrem, MemDS,DBAccess,
  Provider, frxClass, frxExportCSVTestabilidade, strUtils, Datasnap.DBClient,
  Vcl.DBCtrls;

type
  TfrmReqEnvioMatVidroSelDoc = class(TfrmPaiOrdena)
    pnlMenExp: TPanel;
    dbtxtMENEXP2: TDBText;
    lbl5: TLabel;
    dbtxtMENEXP: TDBText;
    Panel1: TPanel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label1: TLabel;
    DBText4: TDBText;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
    function fGetOrderBy: String; Override;
    { Private declarations }
  public
    { Public declarations }
    strDocSel: String;
    strEspSel: String;
    strSQLDoc: String;

    class function fGetSQLDocumentos(strNumDoc, strEspDoc: String;
      strObrFin: String = ''; strCodCli: String = ''; dtaDataIni: TDateTime = 0; dtaDataFin: TDateTime = 0): String;

    class function fPesquisaDocumentos(edtNumDoc, edtEspDoc: TEditFocus;
      strObrFin: String = ''; strCodCli: String = ''; dtaDataIni: TDateTime = 0; dtaDataFin: TDateTime = 0): Boolean;
  end;

implementation

uses untOrdPro, untFuncoesSimples;

{$R *.dfm}

function TfrmReqEnvioMatVidroSelDoc.fGetSql(blnLike: Boolean): String;
begin
  Result := strSQLDoc;
end;

class function TfrmReqEnvioMatVidroSelDoc.fGetSQLDocumentos(strNumDoc, strEspDoc: String;
   strObrFin: String = ''; strCodCli: String = ''; dtaDataIni: TDateTime = 0; dtaDataFin: TDateTime = 0): String;
begin
  Result := '';
  Result := Result  + 'SELECT DISTINCT ';
  Result := Result  + '  GER_CODCLI AS CODCLI, ';
  Result := Result  + '  GER_NUMDOC AS NUMDOC, ';
  Result := Result  + '  GER_ESPDOC AS ESPDOC, ';
  Result := Result  + '  GER_CODEMP AS CODEMP, ';
  Result := Result  + '  GER_DTAENT AS DTAENT, ';
  Result := Result  + '  GER_CODVEN AS CODVEN, ';
  Result := Result  + '  GER_CONPAG AS CONPAG, ';
  Result := Result  + '  GER_TABPRE AS TABPRE, ';

  //Dados do cliente consumidor
  Result := Result  + '  GER_NOMCON AS NOMCON, ';
  Result := Result  + '  GER_ENDCON AS ENDCON, ';
  Result := Result  + '  GER_BAICON AS BAICON, ';
  Result := Result  + '  GER_CEPCON AS CEPCON, ';
  Result := Result  + '  GER_CIDCON AS CIDCON, ';
  Result := Result  + '  GER_ESTCON AS ESTCON, ';
  Result := Result  + '  GER_TELCON AS TELCON, ';
  Result := Result  + '  AUX_NASCON AS NASCON, ';
  Result := Result  + '  GER_CGCCPF AS CGCCPF, ';
  Result := Result  + '  GER_CGCCON AS CGCCON, ';
  Result := Result  + '  GER_IESCON AS IESCON, ';
  Result := Result  + '  GER_EMLCON AS EMLCON, ';
  Result := Result  + '  GER_R_GCON AS R_GCON, ';

  Result := Result  + '  DET_COMPEC AS COMPEC, ';
  Result := Result  + '  DET_LARPEC AS LARPEC, ';
  Result := Result  + '  DET_ESPPEC AS ESPPEC, ';

  Result := Result  + '  CLI_TABPRE AS CLITAB, ';
  Result := Result  + '  CLI_DESOPE AS CLIDOP, ';
  Result := Result  + '  GER_VLRCON AS VLRCON, ';
  Result := Result  + '  FGO_DTAENT AS DTAORC, ';
  Result := Result  + '  FGO_VLRCON AS VALORC, ';
  Result := Result  + '  GER_DTAENT AS DTAFAT, ';
  Result := Result  + '  GER_VLRCON AS VALFAT, ';
  Result := Result  + '  CONCAT(GER_CODVEN, " - ", OPE_NOMOPE) AS VENFAT, ';
  Result := Result  + '  CONCAT(GER_CODCLI, " - ", CLI_NOMCLI) AS CLIFAT, ';
  Result := Result  + '  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS NUMORC, ';
  Result := Result  + '  CONCAT(GER_NUMDOC, "-", GER_ESPDOC, "-", GER_CODEMP) AS DOCFAT, ';
  Result := Result  + '  IFNULL(GER_MEN001, "") AS MEN001, ';
  Result := Result  + '  IFNULL(GER_MEN002, "") AS MEN002, ';
  Result := Result  + '  IFNULL(GER_MENEXP, "") AS MENEXP, ';
  Result := Result  + '  IFNULL(GER_MENEX2, "") AS MENEX2, ';
  Result := Result  + '  IFNULL(GER_MENEX3, "") AS MENEX3, ';
  Result := Result  + '  IFNULL(GER_MENEX4, "") AS MENEX4, ';
  Result := Result  + '  AUX_OBRFIN AS OBRFIN, ';
  Result := Result  + '  "AUXMOV"   AS TABAUX, ';
  Result := Result  + '  "MOVGER"   AS TABGER, ';
  Result := Result  + '  MOVGER.AUTOINCREM   ';
  Result := Result  + 'FROM          ';
  Result := Result  + '  MOVDET      ';
  Result := Result  + '  LEFT  JOIN MOVMAD ON MOVMAD.DET_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result  + '  INNER JOIN MOVGER ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result  + '  INNER JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result  + '  INNER JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  Result := Result  + '  INNER JOIN CADOPE ON GER_CODVEN = OPE_CODOPE ';
  Result := Result  + '  LEFT  JOIN FATGOR ON FGO_NUMDOC = DET_NUM_PD AND ';
  Result := Result  + '                       FGO_ESPDOC = DET_ESP_PD AND ';
  Result := Result  + '                       FGO_CODEMP = DET_EMP_PD     ';
  Result := Result  + '  INNER JOIN CADITE ON ITE_CODITE = DET_CODITE     ';
  Result := Result  + 'WHERE                                              ';
  Result := Result  + '  ((DET_CODITE = ' + QuotedStr(fCfgSis('ITEVID')) + ') OR ';
  Result := Result  + '   (DET_CODITE = '+ QuotedStr(fCfgSis('ITESER'))+') OR';
  Result := Result  + '   (DET_CODITE = ' + QuotedStr(fCfgSis('SERTER'))+ ') OR';
  Result := Result  + '   (LOCATE("ITEM ESPECIAL", ITE_DESITE) > 0)) AND ';
  Result := Result  + '  LOCATE(DET_CLAFIS, ' + QuotedStr(VS_strClaVen) + ') AND ';
  Result := Result  + '  DET_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  If dtaDataIni > 0 Then
    Result := Result  + '  AND DET_DTAENT >= ' + fCurrentDate(dtaDataIni);

  If dtaDataFin > 0 Then
    Result := Result  + '  AND DET_DTAENT <= ' + fCurrentDate(dtaDataFin);

  If strObrFin <> '' Then
    Result := Result  + '  AND IFNULL(AUX_OBRFIN,"N") = "' + strObrFin + '" ';

  If Not fEmptyStr(strCodCli) Then
    Result := Result  + '  AND DET_CODCLI = ' + QuotedStr(strCodCli) + ' ';

  If Not fEmptyStr(strNumDoc) Then
    Result := Result  + '  AND DET_NUMDOC = ' + QuotedStr(strNumDoc) + ' ';

  If Not fEmptyStr(strEspDoc) Then
    Result := Result  + '  AND DET_ESPDOC = ' + QuotedStr(strEspDoc) + ' ';
end;

procedure TfrmReqEnvioMatVidroSelDoc.dbgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Not cdsConsulta.Active) Or (cdsConsulta.IsEmpty) Then
    Exit;

  If Key = VK_RETURN Then
  Begin
    strDocSel := cdsConsulta.FieldByName('NUMDOC').AsString;
    strEspSel := cdsConsulta.FieldByName('ESPDOC').AsString;
    Close;
    ModalResult := mrOk;
  End;
end;

function TfrmReqEnvioMatVidroSelDoc.fAbreConsulta(blnLike: Boolean): Boolean;
begin
  Result := inherited fAbreConsulta(blnLike);
end;

procedure TfrmReqEnvioMatVidroSelDoc.FormCreate(Sender: TObject);
begin
  inherited;
  strDocSel := '';
  strEspSel := '';

  blnTemSelecao       := False;
  blnSempreRelerBanco := False;
end;

procedure TfrmReqEnvioMatVidroSelDoc.FormShow(Sender: TObject);
begin
  inherited;
  If fAbreConsulta(True) Then
    dbgConsultaTitleClick(fFindColumnByName(dbgConsulta, 'NUMORC'));
end;

class function TfrmReqEnvioMatVidroSelDoc.fPesquisaDocumentos(edtNumDoc, edtEspDoc: TEditFocus;
  strObrFin: String = ''; strCodCli: String = ''; dtaDataIni: TDateTime = 0; dtaDataFin: TDateTime = 0): Boolean;
  Var
    frmReqEnvioMatVidroSelDoc: TfrmReqEnvioMatVidroSelDoc;
begin
  Result := False;
  Try
    pCriarFormularios(TfrmReqEnvioMatVidroSelDoc, frmReqEnvioMatVidroSelDoc);
    frmReqEnvioMatVidroSelDoc.strSQLDoc := fGetSQLDocumentos('', '', strObrFin, strCodCli, dtaDataIni, dtaDataFin);
    If frmReqEnvioMatVidroSelDoc.ShowModal = mrOk Then
    Begin
      edtNumDoc.Text := frmReqEnvioMatVidroSelDoc.strDocSel;
      edtEspDoc.Text := frmReqEnvioMatVidroSelDoc.strEspSel;
      Result         := True;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  pFreeAndNil(frmReqEnvioMatVidroSelDoc);
end;

function TfrmReqEnvioMatVidroSelDoc.fGetOrderBy: String;
begin
  Result := '';
end;

end.
