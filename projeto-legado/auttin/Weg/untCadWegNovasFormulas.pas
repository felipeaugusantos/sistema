unit untCadWegNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus,  Uni, DB,
  StrUtils,
  BitBtnLockedIncrem, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadWegNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label27: TLabel;
    pnlCabecalho: TPanel;
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
    Label5: TLabel;
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
    dbeProKey: TDBEditFocus;
    dbeUnidad: TDBEditFocus;
    dbeSubKey: TDBEditFocus;
    dtsWeg_CadNfm: TDataSource;
    qryWeg_CadNfm: TUniQuery;
    qryWeg_CadNfmNFM_CODPRO: TStringField;
    qryWeg_CadNfmNFM_BASE__: TStringField;
    qryWeg_CadNfmNFM_DESCRI: TStringField;
    qryWeg_CadNfmNFM_COL001: TStringField;
    qryWeg_CadNfmNFM_COL002: TStringField;
    qryWeg_CadNfmNFM_COL003: TStringField;
    qryWeg_CadNfmNFM_COL004: TStringField;
    qryWeg_CadNfmNFM_COL005: TStringField;
    qryWeg_CadNfmNFM_COL006: TStringField;
    qryWeg_CadNfmNFM_COL007: TStringField;
    qryWeg_CadNfmNFM_COL008: TStringField;
    qryWeg_CadNfmNFM_COL009: TStringField;
    qryWeg_CadNfmNFM_COL010: TStringField;
    qryWeg_CadNfmNFM_QTD001: TFloatField;
    qryWeg_CadNfmNFM_QTD002: TFloatField;
    qryWeg_CadNfmNFM_QTD003: TFloatField;
    qryWeg_CadNfmNFM_QTD004: TFloatField;
    qryWeg_CadNfmNFM_QTD005: TFloatField;
    qryWeg_CadNfmNFM_QTD006: TFloatField;
    qryWeg_CadNfmNFM_QTD007: TFloatField;
    qryWeg_CadNfmNFM_QTD008: TFloatField;
    qryWeg_CadNfmNFM_QTD009: TFloatField;
    qryWeg_CadNfmNFM_QTD010: TFloatField;
    qryWeg_CadNfmNFM_EMBALA: TFloatField;
    qryWeg_CadNfmNFM_UNIDAD: TStringField;
    qryWeg_CadNfmNFM_PROKEY: TStringField;
    qryWeg_CadNfmNFM_SUBKEY: TStringField;
    qryWeg_CadNfmNFM_CODEMP: TStringField;
    qryWeg_CadNfmAUTOINCREM: TStringField;
    qryWeg_CadNfmNFM_DTACAD: TDateField;
    qryWeg_CadNfmNFM_NOMCOR: TStringField;
    Label28: TLabel;
    dbeDtaCad: TDBEditFocus;
    Label29: TLabel;
    dbeNomCor: TDBEditFocus;
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
    procedure pApagaCadWegNfm(CodPro : String);
    function fWegCadEmbCadastrado: Boolean;
    function fProximoCodigoNfmCadastrado: Boolean;
  public
    { Public declarations }
  end;

var
  frmCadWegNovasFormulas: TfrmCadWegNovasFormulas;

implementation

uses untModuloTinta, untWegDinamica, untFuncTinta, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadWegNovasFormulas }

procedure TfrmCadWegNovasFormulas.btnAlterarClick(Sender: TObject);
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

procedure TfrmCadWegNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strWegCod : String;
begin
  strWegCod := qryTabela.FieldByName('NFM_CODPRO').AsString;
  fStartTransaction;
  inherited;
  Try
    If (blnExcluiu) Then
    Begin
      pApagaCadWegNfm(strWegCod);
      blnExcluiu := False;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadWegNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
begin
  If Not fWegCadEmbCadastrado Then
  Begin
    fMensagem('Informação','O cadastro de embalagens da tinta WEG precisa ser preenchido.' + #13#10 +
                           'Entre em contato com a Citel !',['&Ok']);
    Exit;
  End;

  If Not fProximoCodigoNfmCadastrado Then
  Begin
    fMensagem('ATENÇÃO','O Próximo código Nova Fórmula não está preenchido. ' + #13#10 +
                        'Ele precisa ser preenchido nas configurações da tinta WEG no Auttin !',['&Ok']);
    Exit;
  End;

  qryTabela     := qryWeg_CadNfm;
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := fGetConfTinta('WEG').fGet('NFMWEG');
    qryTabela.FieldByName('NFM_CODPRO').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
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
          fGetConfTinta('WEG').pSet('NFMWEG', IntToStr(StrToInt(strNfmBri) + 1));
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

procedure TfrmCadWegNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  qryTabela.FieldByName('NFM_DTACAD').AsDateTime := Date;
  dbeCodNfm.Enabled := False;
  pSetFocus(dbeCodBas);
end;

procedure TfrmCadWegNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqFormulaTinta(Self, conWeg, Nil, qryTabela, key, arrSel) Then
    pSetFocus(btnAlterar);
end;

procedure TfrmCadWegNovasFormulas.dbeCodBasKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
    qryAux: TUniQuery;
begin
  inherited;
  qryAux := fCriaQuery;
  Try
    If fPesqBaseTinta(Self, conWeg, TDBEditFocus(Sender), Nil, qryAux, Key, arrSel) Then
    Begin
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

procedure TfrmCadWegNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  If fPesqColorantes(Self, conWeg, TEdit(Sender), Nil, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

function TfrmCadWegNovasFormulas.fBaseCadastrada(strCodBas, strProKey,
  strSubKey, strUnidad: String): Boolean;
Var
  strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_DESCRI ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WEG_CADBAS ';
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

function TfrmCadWegNovasFormulas.fJaExisteEssaBaseNaFormulacao(
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

procedure TfrmCadWegNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'WEG_CADNFM';
  strNomeCampo  := 'NFM_CODPRO';
  qryTabela     := qryWeg_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodNfm;
end;

function TfrmCadWegNovasFormulas.fProximoCodigoNfmCadastrado: Boolean;
begin
  Result := Not fEmptyStr(fGetConfTinta('WEG').fGet('NFMWEG'));
end;

function TfrmCadWegNovasFormulas.fValidaCampos(Sender: TWinControl;
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
    End;
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
    Else
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
      End
      Else If (fStrToFloat(TEdit(Sender).Text)) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade do colorante deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadWegNovasFormulas.fValidaColorante(strCodCol: String): Boolean;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WEG_CADCOL ';
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

function TfrmCadWegNovasFormulas.fWegCadEmbCadastrado: Boolean;
var
  qryCons: TUniQuery;
begin

  Try
    qryCons := fCriaQuery;
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) AS QTD ');
      SQL.Add('   FROM WEG_CADEMB ');
      Open;

      Result := FieldByName('QTD').AsInteger > 0;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure TfrmCadWegNovasFormulas.pApagaCadWegNfm(CodPro: String);
  Var
    qryGen : TUniQuery;
begin
  qryGen := fCriaQuery;
  qryGen.SQL.Text := 'DELETE FROM WEG_CADWEG WHERE WEG_CODIGO = :CODPRO';
  qryGen.ParamByName('CODPRO').AsString := CodPro;
  qryGen.ExecSQL;
  FreeAndNil(qryGen);
end;

procedure TfrmCadWegNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODPRO');
  stlCampos.Add('NFM_BASE__');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_NOMCOR');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_BASE__+NFM_PROKEY+NFM_SUBKEY');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Base/Prod. Key/Sub. Key');
  stlDesInd.Add('Descrição');
end;

initialization
  RegisterClass(TfrmCadWegNovasFormulas);
finalization
  UnRegisterClass(TfrmCadWegNovasFormulas);

end.

