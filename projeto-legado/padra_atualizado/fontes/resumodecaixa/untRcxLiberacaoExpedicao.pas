unit untRcxLiberacaoExpedicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  UniDataSetProvider, Uni, DB, UniClientDataSet, StrUtils, AppEvnts, BitBtnLockedIncrem, MemDS,
  DBAccess, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient;

type
  TfrmRcxLiberacaoExpedicao = class(TfrmPai)
    dbgDocumentos: TDBGridCitel;
    cdsDocumentos: TUniClientDataSet;
    dtsDocumentos: TDataSource;
    qryDocumentos: TUniQuery;
    dspDocumentos: TUniDataSetProvider;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    intQtdSel: Integer;
    procedure pCarregaDocumentos;
    procedure pSelecionaDocumento;

    procedure pConfirmaLiberacao;
  public
    { Public declarations }
  end;

var
  frmRcxLiberacaoExpedicao: TfrmRcxLiberacaoExpedicao;

implementation

uses untfuncoesSimples, untFuncoes;

{$R *.dfm}

{ TfrmRcxLiberacaoExpedicao }

procedure TfrmRcxLiberacaoExpedicao.pCarregaDocumentos;
  Var
    strSQL: String;
begin

  intQtdSel := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GER_DTAENT AS DTAENT, ';
  strSQL := strSQL + '  GER_HORENT AS HORENT, ';
  strSQL := strSQL + '  GER_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC AS ESPDOC, ';
  strSQL := strSQL + '  GER_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  CONCAT(GER_CODCLI, "-", ';
  strSQL := strSQL + '         IF((LOCATE("CONSUMIDOR", CLI_NOMCLI) > 0) OR (LOCATE("SEGURADORA", CLI_NOMCLI) > 0), ';
  strSQL := strSQL + '            GER_NOMCON, ';
  strSQL := strSQL + '            CLI_NOMCLI)) AS NOMCLI, ';
  strSQL := strSQL + '  GER_CODVEN AS CODVEN, ';
  strSQL := strSQL + '  IF((LEFT(GER_CLAFIS,1) < 5) AND (GER_ESPDOC <> "TR"), -GER_VLRCON, GER_VLRCON) AS VALDOC, ';
  strSQL := strSQL + '  "MOVGER"   AS NOMTAB, ';
  strSQL := strSQL + '  "D"        AS MARDES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER ';
  strSQL := strSQL + 'JOIN CADCLI ON GER_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';

  strSQL := strSQL + '  ('+ fRetSQLEspDocsNaoListadosNaExpedicao;
  If (fCfgSis('EESFAE') = 'S') Then
    strSQL := strSQL + '  OR (GER_ESPDOC = "EP" AND LEFT(GER_CLAFIS,1) >= "5")';
  strSQL := strSQL + '  ) AND ';

  strSQL := strSQL + '  GER_DTLBRC IS NULL  ';

  strSQL := strSQL + ' ORDER BY 1 DESC, 2 DESC ';

  qryDocumentos.Close;
  qryDocumentos.SQL.Clear;
  qryDocumentos.SQL.Add(strSQL);
  qryDocumentos.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDocumentos.Open;

  pSetaClient(qryDocumentos);

  Screen.Cursor := crHourGlass;
  Application.ProcessMessages;

  cdsDocumentos.DisableControls;
  cdsDocumentos.Close;
  cdsDocumentos.Open;

  cdsDocumentos.EnableControls;
  Screen.Cursor := crDefault;

  TFloatField(cdsDocumentos.FieldByName('VALDOC')).DisplayFormat := '#,##0.00';
end;

procedure TfrmRcxLiberacaoExpedicao.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDocumentos;
end;

procedure TfrmRcxLiberacaoExpedicao.pSelecionaDocumento;
begin

  If cdsDocumentos.IsEmpty Then
    Exit;

  cdsDocumentos.Edit;
  If (cdsDocumentos.FieldByName('MARDES').AsString = 'M') Then
  Begin
    cdsDocumentos.FieldByName('MARDES').AsString := 'D';
    Dec(intQtdSel);
  End
  Else
  Begin
    cdsDocumentos.FieldByName('MARDES').AsString := 'M';
    Inc(intQtdSel);
  End;
  cdsDocumentos.Post;

  If (intQtdSel < 0) Then
    intQtdSel := 0;
end;

procedure TfrmRcxLiberacaoExpedicao.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If (Not cdsDocumentos.Active) Then
  Begin
    Exit;
  End;

  If (cdsDocumentos.FieldByName('MARDES').AsString = 'M') Then
    dbgDocumentos.Canvas.Font.Color := clBlue;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmRcxLiberacaoExpedicao.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (fMensagem('', 'Confirma liberação dos documentos?', ['&Sim', '&Não']) = 2) Then
    Exit;

  pConfirmaLiberacao;
end;

procedure TfrmRcxLiberacaoExpedicao.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pSelecionaDocumento;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

procedure TfrmRcxLiberacaoExpedicao.pConfirmaLiberacao;
  Var
    qryAux: TUniQuery;
    strDocMovGer: String;

    function fRetirarOr(Const s: String): String;
    begin
      Result := Trim(s);
      If (RightStr(Result, 2) = 'OR') Then
        Result := Copy(Result, 1, Length(Result)-2);
    end;
begin

  If (intQtdSel <= 0) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um documento!', ['&Ok']);
    Exit;
  End;


  strDocMovGer  := '';

  qryAux := fCriaQuery(Self);

  Screen.Cursor := crHourGlass;
  pnlInfo.Caption := 'Aguarde, processando...';
  btnConfirma.Enabled := False;

  Application.ProcessMessages;

  cdsDocumentos.DisableControls;

  cdsDocumentos.Filter := 'MARDES = ' + QuotedStr('M');
  cdsDocumentos.Filtered := True;

  cdsDocumentos.First;
  While (Not cdsDocumentos.Eof) Do
  Begin
    If (cdsDocumentos.FieldByName('NOMTAB').AsString = 'MOVGER') Then
    Begin
      strDocMovGer := strDocMovGer + '(GER_NUMDOC = ' + QuotedStr(cdsDocumentos.FieldByName('NUMDOC').AsString) + ' AND ';
      strDocMovGer := strDocMovGer + ' GER_ESPDOC = ' + QuotedStr(cdsDocumentos.FieldByName('ESPDOC').AsString) + ' AND ';
      strDocMovGer := strDocMovGer + ' GER_CODEMP = ' + QuotedStr(cdsDocumentos.FieldByName('CODEMP').AsString) + ' AND ';
      strDocMovGer := strDocMovGer + ' GER_CODCLI = ' + QuotedStr(cdsDocumentos.FieldByName('CODCLI').AsString) + ') ';
    End;

    If (cdsDocumentos.RecNo < cdsDocumentos.RecordCount) Then
      If (cdsDocumentos.FieldByName('NOMTAB').AsString = 'MOVGER') Then
        strDocMovGer := strDocMovGer + ' OR ';

    cdsDocumentos.Next;

  End;

  strDocMovGer  := fRetirarOr(strDocMovGer);

  If (Not fEmptyStr(strDocMovGer)) Then
  Begin

    qryAux.SQL.Add('UPDATE                  ');
    qryAux.SQL.Add('  MOVGER                ');
    qryAux.SQL.Add('  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ');
    qryAux.SQL.Add('SET                     ');
    qryAux.SQL.Add('  GER_OPLBRC = :OPELIB, ');
    qryAux.SQL.Add('  GER_DTLBRC = :DTALIB, ');
    qryAux.SQL.Add('  GER_HRLBRC = :HORLIB, ');
    qryAux.SQL.Add('  AUX_LBRCAU = "N"      ');
    qryAux.SQL.Add('WHERE                   ');
    qryAux.SQL.Add(strDocMovGer);

    qryAux.ParamByName('OPELIB').AsString   := strLoginUsuarioLogado;
    qryAux.ParamByName('DTALIB').AsDateTime := VS_Date;
    qryAux.ParamByName('HORLIB').AsDateTime := fTime();

    qryAux.ExecSQL;
  End;

  cdsDocumentos.Filter := '';
  cdsDocumentos.Filtered := False;
  cdsDocumentos.Close;
  qryDocumentos.Close;
  cdsDocumentos.EnableControls;
  pCarregaDocumentos;
  pnlInfo.Caption := '';
  btnConfirma.Enabled := True;
  Screen.Cursor := crDefault;
end;

end.

