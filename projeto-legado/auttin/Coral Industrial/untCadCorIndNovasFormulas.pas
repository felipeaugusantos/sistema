unit untCadCorIndNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, DBEditFocus, StrUtils, DB, AppEvnts, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadCorIndNovasFormulas = class(TfrmPaiCad)
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
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
    dbeCodEmb: TDBEditFocus;
    edtUnidad: TEditFocus;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodBasKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmbKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

  protected
    function fValidaColorante(strCodCol: String): Boolean;
    function fBaseCadastrada(strBase: String): Boolean;
    function fEmbalagemCadastrada(strCodEmb: String): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
  public
    { Public declarations }
  end;

var
  frmCadCorIndNovasFormulas: TfrmCadCorIndNovasFormulas;

implementation

uses  untModuloTinta, untPai, untCoralIndustrial,
      untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadCorIndNovasForumulas }

function TfrmCadCorIndNovasFormulas.fBaseCadastrada(strBase: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_DESCRI, ';
  strSQL := strSQL + '  BAS_UNIDAD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIND_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_BASE__ = :BASE ';

  With frmModuloTinta.qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('BASE').AsString  := strBase;
    Open;
    Result := (Not IsEmpty);
    If (fEmptyStr(dbeDescri.Field.AsString)) And (qryTabela.State <> dsBrowse) Then
    Begin
      dbeDescri.Field.AsString := FieldByName('BAS_DESCRI').AsString;
    End;
    Close;
  End;
end;

function TfrmCadCorIndNovasFormulas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumCol: String;
begin

  Result := True;

  If (Sender = dbeCodigo) Then
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

  Else If (Sender = dbeCodEmb) Then
  Begin

    If (fEmptyStr(dbeCodEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A embalagem deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (Not fEmbalagemCadastrada(dbeCodEmb.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa embalagem não está cadastrada!', ['&Ok']);
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

  Else If (Sender = dbeCodIte) Then
  Begin
    If (fEmptyStr(dbeCodIte.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O item deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);
      If fEmptyStr(edtDesIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
        Result := False;
      End;
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
      fMensagem('ATENÇÃO!', 'Esse colorante não está cadastrado!', ['&O k']);    
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
    If (fEmptyStr((TEdit(Sender).Text))) Then
    Begin
      pSetFocus(dbeQtdC10)
    End
    Else If (Not fValidaColorante(TEdit(Sender).Text)) Then
    Begin
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
  End
end;

function TfrmCadCorIndNovasFormulas.fValidaColorante(
  strCodCol: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COUNT(*) AS QTD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIND_CADCOL ';
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

procedure TfrmCadCorIndNovasFormulas.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODIGO');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_DESCRI');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODIGO');
  stlCamInd.Add('NFM_DESCRI');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadCorIndNovasFormulas.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CORIND_CADNFM';
  strNomeCampo  := 'NFM_CODIGO';
  qryTabela     := frmModuloTinta.qryCorInd_CadNfm;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;
end;

procedure TfrmCadCorIndNovasFormulas.btnIncluirClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  pSetFocus(dbeCodBas);
end;

procedure TfrmCadCorIndNovasFormulas.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodigo.Enabled := False;
  If (dbeCodBas.Enabled) Then
    pSetFocus(dbeCodBas);
end;

procedure TfrmCadCorIndNovasFormulas.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCorIndNovasFormulas.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
begin
  blnInsert := (qryTabela.State = dsInsert);
  If (blnInsert) Then
  Begin
    strNfmBri := fArqIniTinta(0, 'Coral Industrial', 'NFMCOR', '0');
    qryTabela.FieldByName('NFM_CODIGO').AsString := 'ESP ' + fStrZero(strNfmBri, 5);
  End;
  qryTabela.FieldByName('NFM_UNIDAD').AsString := edtUnidad.Text;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      If (fGeraNovasFormulas(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          fArqIniTinta(1, 'Coral Industrial', 'NFMCOR', fStrZero(StrToInt(strNfmBri) + 1, 5));
        End;
        fCommit;
      End;
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

function TfrmCadCorIndNovasFormulas.fEmbalagemCadastrada(
  strCodEmb: String): Boolean;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  EMB_UNIDAD ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIND_CADEMB ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMB_CODEMB = :CODEMB ';

  With frmModuloTinta.qryGen001 Do
  Begin

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMB').AsString := strCodEmb;
    Open;
    Result := (Not IsEmpty);
    edtUnidad.Text := FieldByName('EMB_UNIDAD').AsString;
    Close;

  End;

end;

procedure TfrmCadCorIndNovasFormulas.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  strCodigo := qryTabela.FieldByName('NFM_CODIGO').AsString;
  fStartTransaction;
  inherited;

  Try
    If (blnExcluiu) Then
    Begin
      pDeletaNovaFormula(strCodigo);
      fCommit;
      blnExcluiu := False;
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

  edtDesIte.Clear;
  edtUnidad.Clear;
end;

procedure TfrmCadCorIndNovasFormulas.btnCancelaClick(Sender: TObject);
begin
  inherited;
  fBaseCadastrada(dbeCodBas.Text);
  edtDesIte.Clear;
end;

procedure TfrmCadCorIndNovasFormulas.btnPesquisaClick(Sender: TObject);
  var
    arrSel: TConsultasArray;
    key: char;
begin
  key := '/';
  if fPesqFormulaTinta(self, conCorInd, dbeCodigo, qryTabela, Key, arrSel) then
     edtUnidad.Text := qryTabela.FieldByName('NFM_UNIDAD').AsString;
end;

procedure TfrmCadCorIndNovasFormulas.dbeCodBasKeyPress(Sender: TObject;
  var Key: Char);
  Var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqBaseTinta(self, conCorInd, dbeCodBas, nil, nil, Key, arrSel) Then
    If (fValidaCampos(TDBEditFocus(Sender), True)) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCorIndNovasFormulas.dbeCodEmbKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEmbalagens(self, 'CORIND_CADEMB', TDBEditFocus(Sender), nil, nil, nil, Key, arrSel) Then
    If (fValidaCampos(TDBEditFocus(Sender), True)) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadCorIndNovasFormulas.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqColorantes(Self, conCorInd, TDBEditFocus(Sender), nil, nil, Key, arrSel) Then
    If (fValidaCampos(TDBEditFocus(Sender), True)) Then
        SelectNext(ActiveControl, True, True);
end;

initialization
  RegisterClass(TfrmCadCorIndNovasFormulas);
finalization
  UnRegisterClass(TfrmCadCorIndNovasFormulas);

end.

