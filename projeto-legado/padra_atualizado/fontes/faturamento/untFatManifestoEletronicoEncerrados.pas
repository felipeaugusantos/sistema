unit untFatManifestoEletronicoEncerrados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.Buttons, BitBtnLockedIncrem,
  untFuncoesSimples, untTypesSistema, untConsultas, System.StrUtils;

type
  TfrmFatManifestoEletronicoEncerrados = class(TfrmPaiOrdena)
    Label7: TLabel;
    edtNumMan: TEditFocus;
    btnGravar: TBitBtnLocked;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtNumManKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
  private
    procedure pLiberarDocumentosManifesto;
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

{$R *.dfm}

procedure TfrmFatManifestoEletronicoEncerrados.btnDesmarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  pDesmarcaTodos;
end;

procedure TfrmFatManifestoEletronicoEncerrados.btnGravarClick(Sender: TObject);
begin
  inherited;
  If stlListSelecao.Count <= 0 Then
  Begin
    pMensagemOk('É necessário selecionar pelo menos 1 documento para liberar do manifesto.');
    Exit;
  End;

  If fMensagem('', 'Confirma a liberação dos documentos marcados deste manifesto?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  pLiberarDocumentosManifesto;

  pLimparTela;
end;

procedure TfrmFatManifestoEletronicoEncerrados.btnMarcaTodosClick(
  Sender: TObject);
begin
  inherited;
  pMarcaTodos;
end;

procedure TfrmFatManifestoEletronicoEncerrados.edtNumManKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrMan: TConsultasArray;
begin
  If fPesqManifestosEncerrados(Self, edtNumMan, nil, Key, arrMan) Then
  Begin
    If fValidaCampos(edtNumMan, True) Then
      pSetFocus(dbgConsulta);
  End;
end;

function TfrmFatManifestoEletronicoEncerrados.fGetSql(blnLike: Boolean): String;
begin
  if (fTipoDocManifesto(edtNumMan.Text) = 'CTe') then
    Result := fGetSqlCTe
  else
    Result := fGetSqlNFe;
end;

function TfrmFatManifestoEletronicoEncerrados.fGetSqlCTe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  FIS_DTAENT AS DTAENT, ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  FIS_TIP_FC AS CLIFOR, ';
  Result := Result + '  CONCAT(FIS_FORCLI, " - ", ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_NOMCON, CLI_NOMCLI)) AS NOMDES, ';
  Result := Result + '  CID_NOMCID AS NOMCID, ';
  Result := Result + '  CID_ESTADO AS ESTADO, ';
  Result := Result + '  GER_VLRCON AS VLRCON, ';
  Result := Result + '  CADFIS.AUTOINCREM AS AUTOINCREM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS ';
  Result := Result + '  JOIN MOVCTE ON FIS_NUMDOC = CONCAT("000", CTE_NUMCTE) ';
  Result := Result + '             AND FIS_CODEMP =  CTE_CODEMP ';
  Result := Result + '  LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI AND FIS_TIP_FC = "C" ';
  Result := Result + '  JOIN MOVGER ON CTE_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN ENTCLI ON ENTCLI.AUTOINCREM = AUX_ENTGER ';
  Result := Result + '  LEFT JOIN CADCID ON CID_CODCID = IF(IFNULL(GER_CIDCON,"") <> "", GER_CIDCON, ';
  Result := Result + '                                      IF(IFNULL(ETC_CIDENT,"")<>"", ETC_CIDENT, CLI_CODCID)) ';
  Result := Result + 'WHERE ';
  Result := Result + '  FIS_ENCERR = 1 AND ';
  Result := Result + '  IFNULL(FIS_ACEMAN, "") <> "" AND ';
  Result := Result + '  FIS_ESPDOC = "CT" AND ';
  Result := Result + '  FIS_ENTSAI = "S" AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN = :NUMMAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT'), 'MOVCTE', 'NOTCTE');
end;

function TfrmFatManifestoEletronicoEncerrados.fGetSqlNFe: string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  FIS_DTAMAN AS DTAMAN, ';
  Result := Result + '  FIS_DTAENT AS DTAENT, ';
  Result := Result + '  CONCAT_WS("-", FIS_NUMDOC, FIS_ESPDOC, FIS_CODEMP) AS NUMDOC, ';
  Result := Result + '  FIS_TIP_FC AS CLIFOR, ';
  Result := Result + '  CONCAT(FIS_FORCLI, " - ", ';
  Result := Result + '  IF(IFNULL(GER_NOMCON,"") <> "", GER_NOMCON, IFNULL(CLI_NOMCLI, FOR_NOMFOR))) AS NOMDES, ';
  Result := Result + '  CID_NOMCID AS NOMCID, ';
  Result := Result + '  CID_ESTADO AS ESTADO, ';
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
  Result := Result + '  JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN ENTCLI ON ENTCLI.AUTOINCREM = AUX_ENTGER ';
  Result := Result + '  LEFT JOIN CADCID ON CID_CODCID = IF(FIS_TIP_FC = "C", IF(IFNULL(GER_CIDCON,"") <> "", GER_CIDCON, ';
  Result := Result + '                                                           IF(IFNULL(ETC_CIDENT,"")<>"", ETC_CIDENT, CLI_CODCID)), ';
  Result := Result + '                                       FOR_CODCID) ';
  Result := Result + 'WHERE ';
  Result := Result + '  FIS_ENCERR = 1 AND ';
  Result := Result + '  IFNULL(FIS_ACEMAN, "") <> "" AND ';
  Result := Result + '  FIS_ESPDOC IN ("NF", "EL") AND ';
  Result := Result + ' '+fSqlManifestoDocumentosPermitidos+' AND ';
  Result := Result + '  FIS_EMPMAN = :CODEMP AND ';
  Result := Result + '  FIS_NUMMAN = :NUMMAN ';

  Result := Result + 'UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'), 'AUXMOV', 'AUXNOT');
end;

procedure TfrmFatManifestoEletronicoEncerrados.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
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
  Else If Key = VK_F6 Then
  Begin
    btnMarcaTodos.Click;
  End
  Else If Key = VK_F7 Then
  Begin
    btnDesmarcaTodos.Click;
  End
  Else
    inherited;
end;

procedure TfrmFatManifestoEletronicoEncerrados.FormShow(Sender: TObject);
begin
  inherited;
  blnSempreRelerBanco := False;
  btnPesquisar.Visible := False;

  pSetFocus(edtNumMan);
end;

function TfrmFatManifestoEletronicoEncerrados.fSetParametros: Boolean;
begin
  qryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryConsulta.ParamByName('NUMMAN').AsString := edtNumMan.Text;

  Result := True;
end;

function TfrmFatManifestoEletronicoEncerrados.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
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
        fAbreConsulta(True);
        pMarcaTodos;
        If cdsConsulta.IsEmpty Then
        Begin
          pMensagemOk('Não há manifesto eletrônico com este número, ou ainda não está encerrado!');
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

procedure TfrmFatManifestoEletronicoEncerrados.pLiberarDocumentosManifesto;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
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

  if fCampoExiste('CADFIS', 'FIS_CARPOS', True) then
    qryAux.SQL.Add('  FIS_CARPOS = "N", ');

  qryAux.SQL.Add('  FIS_ENCERR = NULL  ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  AUTOINCREM IN (' + stlListSelecao.CommaText + '); ');

  qryAux.SQL.Add('DELETE FROM FISMOT WHERE FMO_SEQGER IN (' + stlListSelecao.CommaText + '); ');

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmFatManifestoEletronicoEncerrados.pLimparTela;
begin
  pDesmarcaTodos;
  qryConsulta.Close;
  cdsConsulta.Close;
  edtNumMan.Clear;
  pSetFocus(edtNumMan);
end;

end.
