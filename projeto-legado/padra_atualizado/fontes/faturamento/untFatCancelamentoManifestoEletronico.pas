unit untFatCancelamentoManifestoEletronico;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, BitBtnLockedIncrem, ExtCtrls,
  StrUtils, MemDS, DBAccess, Datasnap.DBClient, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatCancelamentoManifestoEletronico = class(TfrmPaiOrdena)
    Label7: TLabel;
    edtNumMan: TEditFocus;
    btnGravar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure pEnviarCancelamentoManifesto(strNumMan, strJustificativa: String);
    procedure pLiberarDocumentosManifesto(strNumMan: String);

    procedure pLimparTela;
    function fGetSqlNFe: string;
    function fGetSqlCTe: string;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fGetSql(blnLike: Boolean): String; Override;
    function fSetParametros: Boolean; Override;
  end;


implementation

uses untFuncoesSimples, untDigOcorrencia, untLibNfe;

{$R *.dfm}

{ TfrmFatCancelamentoManifestoEletronico }

procedure TfrmFatCancelamentoManifestoEletronico.btnGravarClick(
  Sender: TObject);
  Var
    strMotCan: String;
    strDesMotCan: String;
begin
  inherited;
  If fMensagem('', 'Confirma o cancelamento deste manifesto?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  strMotCan := '';
  strDesMotCan := '';

  pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);
  Try
    frmDigOcorrencia.ShowModal;
    If (frmDigOcorrencia.ModalResult = mrOk) Then
    Begin
      strMotCan := frmDigOcorrencia.strCodOco;
      strDesMotCan := frmDigOcorrencia.strDesOco;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmDigOcorrencia);

  If fEmptyStr(strMotCan) Then
  Begin
    Exit;
  End;

  pEnviarCancelamentoManifesto(edtNumMan.Text, strMotCan + '-' + strDesMotCan);
  pLiberarDocumentosManifesto(edtNumMan.Text);

  pLimparTela;
end;

function TfrmFatCancelamentoManifestoEletronico.fGetSql(
  blnLike: Boolean): String;
begin
  if (fTipoDocManifesto(edtNumMan.Text) = 'CTe') then
    Result := fGetSqlCTe
  else
    Result := fGetSqlNFe;
end;

function TfrmFatCancelamentoManifestoEletronico.fGetSqlCTe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_CGCCON, CLI_C_G_C_) AS CNPJDE, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_NOMCON, CLI_NOMCLI) AS NOMDES, ';
  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  JOIN MOVCTE ON FIS_NUMDOC = CONCAT("000", CTE_NUMCTE) ';
  Result := Result + '             AND FIS_CODEMP =  CTE_CODEMP ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + 'WHERE ';
  Result := Result + '  IFNULL(FIS_ACEMAN, "") <> "" AND ';
  Result := Result + '  FIS_ENCERR IS NULL AND ';
  Result := Result + '  FIS_ESPDOC = "CT" AND ';
  Result := Result + '  FIS_ENTSAI = "S" AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN = :NUMMAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'MOVCTE', 'NOTCTE');
end;

function TfrmFatCancelamentoManifestoEletronico.fGetSqlNFe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_CGCCON, IFNULL(CLI_C_G_C_, FOR_C_G_C_)) AS CNPJDE, ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_NOMCON, IFNULL(CLI_NOMCLI, FOR_NOMFOR)) AS NOMDES, ';
  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI AND FIS_TIP_FC = "F" ';
  Result := Result + '  JOIN MOVGER ON GER_NUMDOC = FIS_NUMDOC AND ';
  Result := Result + '                 GER_ESPDOC = FIS_ESPDOC AND ';
  Result := Result + '                 GER_CODEMP = FIS_CODEMP AND ';
  Result := Result + '                 GER_TIP_FC = FIS_TIP_FC AND ';
  Result := Result + '                 IFNULL(GER_CODCLI, FOR_CODFOR) = FIS_FORCLI AND ';
  Result := Result + '                 IFNULL(GER_SERIE_, "") = IFNULL(FIS_SERIE_, "") ';
  Result := Result + 'WHERE ';
  Result := Result + '  IFNULL(FIS_ACEMAN, "") <> "" AND ';
  Result := Result + '  FIS_ENCERR IS NULL AND ';
  Result := Result + '  FIS_ESPDOC IN ("NF", "EL") AND ';
  Result := Result + ' '+fSqlManifestoDocumentosPermitidos+' AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN = :NUMMAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(Result, 'MOVGER', 'NOTGER');
end;

procedure TfrmFatCancelamentoManifestoEletronico.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
  Begin
    If dbgConsulta.Focused Then
    Begin
      If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        pLimparTela;
      End;
    End
    Else
      inherited;
  End
  Else If Key = VK_F10 Then
  Begin
    btnGravar.Click;
  End
  Else
    inherited;
end;

procedure TfrmFatCancelamentoManifestoEletronico.FormShow(Sender: TObject);
begin
  inherited;
  blnTemSelecao := False;
  blnTemMarcacao := False;
  blnTemPesquisa := False;
  blnSempreRelerBanco := False;

  pSetFocus(edtNumMan)
end;

function TfrmFatCancelamentoManifestoEletronico.fSetParametros: Boolean;
begin
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConsulta.ParamByName('NUMMAN').AsString := edtNumMan.Text;

  Result := True;
end;

function TfrmFatCancelamentoManifestoEletronico.fValidaCampos(
  Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtNumMan) Then
    Begin
      If fEmptyStr(edtNumMan.Text) Then
      Begin
        pMensagemOk('O número do manifesto deve ser preenchido.');
        Result := False;
      End
      Else
      Begin
        pLimpaPesquisa;
        fAbreConsulta;
        If cdsConsulta.IsEmpty Then
        Begin
          pMensagemOk('Não há manifesto eletrônico com este número, ainda não foi autorizado ou já está encerrado.');
          Result := False;
        End
        Else
        Begin
          pSetFocus(dbgConsulta);
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatCancelamentoManifestoEletronico.pEnviarCancelamentoManifesto(
  strNumMan, strJustificativa: String);
begin
  fEnviarCancelamentoManifesto(strNumMan, strJustificativa);
end;

procedure TfrmFatCancelamentoManifestoEletronico.pLiberarDocumentosManifesto(
  strNumMan: String);
  Var
    qryAux: TUniQuery;
    qryAut: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  qryAut := fCriaQuery(Self);
  try
    qryAut.SQL.Clear;
    qryAut.SQL.Add('SELECT AUTOINCREM ');
    qryAut.SQL.Add('FROM CADFIS ');
    qryAut.SQL.Add('WHERE ');
    qryAut.SQL.Add('  FIS_NUMMAN = :NUMMAN AND ');
    qryAut.SQL.Add('  FIS_EMPMAN = :CODEMP ');
    qryAut.ParamByName('NUMMAN').AsString := strNumMan;
    qryAut.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAut.Open;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('DELETE FROM FISMOT WHERE FMO_SEQGER = :SEQGER ');
    while not qryAut.Eof do
    begin
      qryAux.ParamByName('SEQGER').AsString := qryAut.FieldByName('AUTOINCREM').AsString;
      qryAux.ExecSQL;

      qryAut.Next;
    end;
  finally
    FreeAndNil(qryAut);
  end;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE CADFIS SET ');
  qryAux.SQL.Add('  FIS_NUMMAN = NULL, ');
  qryAux.SQL.Add('  FIS_DTAMAN = NULL, ');
  qryAux.SQL.Add('  FIS_MOTMAN = NULL, ');
  qryAux.SQL.Add('  FIS_PLAMAN = NULL, ');
  qryAux.SQL.Add('  FIS_PLAMA2 = NULL, ');
  qryAux.SQL.Add('  FIS_ACEMAN = NULL, ');
  qryAux.SQL.Add('  FIS_PERCUR = NULL, ');
  qryAux.SQL.Add('  FIS_ESTMAN = NULL, ');
  qryAux.SQL.Add('  FIS_EMPMAN = NULL, ');
  qryAux.SQL.Add('  FIS_ENCERR = NULL  ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  FIS_NUMMAN = :NUMMAN AND ');
  qryAux.SQL.Add('  FIS_EMPMAN = :CODEMP ');

  qryAux.ParamByName('NUMMAN').AsString := strNumMan;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ExecSQL;

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE LOGNFE SET ');
  qryAux.SQL.Add('  NFE_STATUS = "CM", NFE_OBSERV = "MDF-e Cancelada." ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  NFE_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  NFE_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  NFE_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  NFE_SERIE_ = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := edtNumMan.Text;
  qryAux.ParamByName('ESPDOC').AsString := 'ME';
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('SERIE_').AsString := fSerieManifesto(VS_strCodEmp);
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmFatCancelamentoManifestoEletronico.pLimparTela;
begin
  pDesmarcaTodos;
  qryConsulta.Close;
  cdsConsulta.Close;
  edtNumMan.Clear;
  pSetFocus(edtNumMan);
end;

end.
