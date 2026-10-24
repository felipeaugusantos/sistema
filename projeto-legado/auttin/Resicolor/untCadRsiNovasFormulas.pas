unit untCadRsiNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, Uni, AppEvnts,
  BitBtnLockedIncrem, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadRsiNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbeCodNfm: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    gpbColorantes: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    dbeForm01: TDBEditFocus;
    dbeQtdC01: TDBEditFocus;
    dbeForm02: TDBEditFocus;
    dbeQtdC02: TDBEditFocus;
    dbeForm03: TDBEditFocus;
    dbeQtdC03: TDBEditFocus;
    dbeForm04: TDBEditFocus;
    dbeQtdC04: TDBEditFocus;
    dbeForm05: TDBEditFocus;
    dbeQtdC05: TDBEditFocus;
    dbeForm06: TDBEditFocus;
    dbeQtdC06: TDBEditFocus;
    dbeForm07: TDBEditFocus;
    dbeQtdC07: TDBEditFocus;
    dbeForm08: TDBEditFocus;
    dbeQtdC08: TDBEditFocus;
    dbeForm09: TDBEditFocus;
    dbeQtdC09: TDBEditFocus;
    dbeForm10: TDBEditFocus;
    dbeQtdC10: TDBEditFocus;
    dbeCodBas: TDBEditFocus;
    Label2: TLabel;
    dbeProKey: TDBEditFocus;
    Label6: TLabel;
    dbeUnidad: TDBEditFocus;
    Label5: TLabel;
    Label27: TLabel;
    dbeSubKey: TDBEditFocus;
    qryRsi_CadNfm: TUniQuery;
    qryRsi_CadNfmNFM_CODPRO: TStringField;
    qryRsi_CadNfmNFM_BASE__: TStringField;
    qryRsi_CadNfmNFM_DESCRI: TStringField;
    qryRsi_CadNfmNFM_COL001: TStringField;
    qryRsi_CadNfmNFM_COL002: TStringField;
    qryRsi_CadNfmNFM_COL003: TStringField;
    qryRsi_CadNfmNFM_COL004: TStringField;
    qryRsi_CadNfmNFM_COL005: TStringField;
    qryRsi_CadNfmNFM_COL006: TStringField;
    qryRsi_CadNfmNFM_COL007: TStringField;
    qryRsi_CadNfmNFM_COL008: TStringField;
    qryRsi_CadNfmNFM_COL009: TStringField;
    qryRsi_CadNfmNFM_COL010: TStringField;
    qryRsi_CadNfmNFM_QTD001: TFloatField;
    qryRsi_CadNfmNFM_QTD002: TFloatField;
    qryRsi_CadNfmNFM_QTD003: TFloatField;
    qryRsi_CadNfmNFM_QTD004: TFloatField;
    qryRsi_CadNfmNFM_QTD005: TFloatField;
    qryRsi_CadNfmNFM_QTD006: TFloatField;
    qryRsi_CadNfmNFM_QTD007: TFloatField;
    qryRsi_CadNfmNFM_QTD008: TFloatField;
    qryRsi_CadNfmNFM_QTD009: TFloatField;
    qryRsi_CadNfmNFM_QTD010: TFloatField;
    qryRsi_CadNfmNFM_EMBALA: TFloatField;
    qryRsi_CadNfmNFM_UNIDAD: TStringField;
    qryRsi_CadNfmNFM_PROKEY: TStringField;
    qryRsi_CadNfmNFM_SUBKEY: TStringField;
    qryRsi_CadNfmNFM_CODEMP: TStringField;
    qryRsi_CadNfmAUTOINCREM: TStringField;
    dtsRsi_CadNfm: TDataSource;
    dbeDtaCad: TDBEditFocus;
    Label28: TLabel;
    qryRsi_CadNfmNFM_DTACAD: TDateField;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodBasKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strCodBas: String; strProKey: String = ''; strSubKey: String = ''; strUnidad: String = ''): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pApagaCadRsiNfm(CodPro : String);
  public
    { Public declarations }
  end;

var
  frmCadRsiNovasFormulas: TfrmCadRsiNovasFormulas;

implementation

uses
      untModuloTinta, untPai,
      untResicolor, untFuncoesSimples,
      untIConfTinta, untFuncTinta, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadRsiNovasForumulas }

function TfrmCadRsiNovasFormulas.fBaseCadastrada(strCodBas: String;
  strProKey: String = ''; strSubKey: String = ''; strUnidad: String = ''): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  RSI_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_BASE__ = :CODBAS ';
  If (Not fEmptyStr(strProKey)) Then
    strSQL := strSQL + '  AND BAS_PROKEY = :PROKEY ';

  If (Not fEmptyStr(strSubKey)) Then
    strSQL := strSQL + '  AND BAS_SUBKEY = :SUBKEY ';

  If (Not fEmptyStr(strUnidad)) Then
    strSQL := strSQL + '  AND BAS_UNIDAD = :UNIDAD ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBAS').AsString := strCodBas;
    If (Not fEmptyStr(strProKey)) Then
      ParamByName('PROKEY').AsString := strProKey;

    If (Not fEmptyStr(strSubKey)) Then
      ParamByName('SUBKEY').AsString := strSubKey;

    If (Not fEmptyStr(strUnidad)) Then
      ParamByName('UNIDAD').AsString := strUnidad;

    Open;
    Result := (Not IsEmpty);
    If (fEmptyStr(dbeDescri.Field.AsString)) And
       (qryTabela.State <> dsBrowse)         And
       (Result)                              Then
    Begin
      dbeDescri.Field.AsString := FieldByName('BAS_DESCRI').AsString;
    End;
    Close;
  End;
end;

function TfrmCadRsiNovasFormulas.fJaExisteEssaBaseNaFormulacao(
  strCodBas: String; dbeForm: TObject): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 10 Do
  Begin
    If (RightStr(TDBEditFocus(dbeForm).Name, 2) <> fStrZero(intCont,2)) And
       (Not fEmptyStr(TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text)) Then
    Begin
      If TDBEditFocus(FindComponent('dbeForm' + fStrZero(intCont,2))).Text = strCodBas Then
        Result := True;
    End;
  End;
end;

function TfrmCadRsiNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodNfm) Then
  Begin
  End

  Else If (Sender = dbeCodBas) Then
  Begin
    If (fEmptyStr(dbeCodBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeProKey) Then
  Begin
    If (fEmptyStr(dbeProKey.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Prod. Key deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text, dbeProKey.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeSubKey) Then
  Begin
    If (fEmptyStr(dbeSubKey.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Sub. Key deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text, dbeProKey.Text, dbeSubKey.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  {*****************************************}
  {* VALIDA A UNIDADE                      *}
  {**************************************MV*}
  Else If (Sender = dbeUnidad) Then
  Begin

    If (fEmptyStr(dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (Not fBaseCadastrada(dbeCodBas.Text, dbeProKey.Text, dbeSubKey.Text, dbeUnidad.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base nao está cadastrada!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeDescri) Then
  Begin
    If (fEmptyStr(dbeDescri.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeForm01) Then
  Begin
    If (fEmptyStr(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 colorante!', ['&Ok']);
      Result := False;
    End
    Else If (Not fValidaColorante(dbeForm01.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Colorante não encontrado!', ['&Ok']);
      Result := False;
    End

  End

  Else If (Sender = dbeForm02) Or
          (Sender = dbeForm03) Or
          (Sender = dbeForm04) Or
          (Sender = dbeForm05) Or
          (Sender = dbeForm06) Or
          (Sender = dbeForm07) Or
          (Sender = dbeForm08) Or
          (Sender = dbeForm09) Or
          (Sender = dbeForm10) Then
  Begin

    If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End
    else
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdC10)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Colorante não encontrado!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeQtdC01) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC02) Or
          (Sender = dbeQtdC03) Or
          (Sender = dbeQtdC04) Or
          (Sender = dbeQtdC05) Or
          (Sender = dbeQtdC06) Or
          (Sender = dbeQtdC07) Or
          (Sender = dbeQtdC08) Or
          (Sender = dbeQtdC09) Or
          (Sender = dbeQtdC10) Then
  Begin
    strNumCol := RightStr(Sender.Name, 2);
    If (Not fEmptyStr(TEdit(fComponentByName(gpbColorantes, 'dbeForm' + strNumCol)).Text)) Then
    Begin
      If (fEmptyStr(TEdit(Sender).Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário digitar a quantidade do colorante!', ['&Ok']);
        Result := False;
      End;
      If (fStrToFloat(TEdit(Sender).Text)) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade do colorante deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadRsiNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  RSI_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL = :CODCOL ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCOL').AsString := strCodCol;
    Open;
    Result := (FieldByName('QTD').AsInteger > 0);
    Close;
  End;
end;

procedure TfrmCadRsiNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODPRO');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_BASE__+NFM_PROKEY+NFM_SUBKEY');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Base/Prod. Key/Sub. Key');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadRsiNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'RSI_CADNFM';
  strNomeCampo  := 'NFM_CODPRO';
  qryTabela     := qryRsi_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;

end;

procedure TfrmCadRsiNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  dbeCodNfm.Enabled := False;
  pSetFocus(dbeCodBas);
end;

procedure TfrmCadRsiNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conRsi, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadRsiNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodNfm.Enabled := False;
  dbeCodBas.Enabled := False;
  dbeProKey.Enabled := False;
  dbeSubKey.Enabled := False;
  dbeUnidad.Enabled := False;
  If (dbeDescri.Enabled) Then
    pSetFocus(dbeDescri);
end;

procedure TfrmCadRsiNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('RSI');
  qryTabela     := qryRsi_CadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
	strNfmBri := conf.fGet('NFMRSI');
    strNfmBri := IIF(fEmptyStr(strNfmBri), '00001', strNfmBri);
    qryTabela.FieldByName('NFM_CODPRO').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;
  qryTabela.FieldByName('NFM_EMBALA').AsFloat := 1.0;
  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      Screen.Cursor := crHourGlass;
      If (fGravaNovaFormula(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSet('NFMRSI', IntToStr(StrToInt(strNfmBri) + 1));
        End;

        fCommit;
      End
      Else
        fRollBack;

      Screen.Cursor := crDefault;
      blnGravou := False;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadRsiNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strRsiCod : String;
begin
  strRsiCod := qryTabela.FieldByName('NFM_CODPRO').AsString;
  fStartTransaction;
  inherited;
  Try
    If (blnExcluiu) Then
    Begin
      pApagaCadRsiNfm(strRsiCod);
      blnExcluiu := False;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;


procedure TfrmCadRsiNovasFormulas.pApagaCadRsiNfm(CodPro: String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'DELETE FROM RSI_CADRSI WHERE RSI_CODIGO = :CODPRO';
  qryGen.ParamByName('CODPRO').AsString := CodPro;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadRsiNovasFormulas.dbeCodBasKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: tConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  Try
    qryAux := fCriaQuery(Self);
    If fPesqBaseTinta(Self, conRSI, Nil, Nil, qryAux, Key, arrSel) Then
    Begin
      TDBEditFocus(Sender).Text := qryAux.FieldByName('BAS_BASE__').AsString;
      qryTabela.FieldByName('NFM_PROKEY').AsString := qryAux.FieldByName('BAS_PROKEY').AsString;
      qryTabela.FieldByName('NFM_SUBKEY').AsString := qryAux.FieldByName('BAS_SUBKEY').AsString;
      qryTabela.FieldByName('NFM_UNIDAD').AsString := qryAux.FieldByName('BAS_UNIDAD').AsString;
      qryTabela.FieldByName('NFM_DESCRI').AsString := qryAux.FieldByName('BAS_DESCRI').AsString;
      pSetFocus(dbeProKey);
    End;
  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmCadRsiNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conRsi, TEdit(Sender), Nil, Nil, Key, arrSel) Then
    If fValidaCampos(TEdit(Sender), True) Then
      SelectNext(ActiveControl, True, True);
end;

initialization
  RegisterClass(TfrmCadRsiNovasFormulas);
finalization
  UnRegisterClass(TfrmCadRsiNovasFormulas);

end.

