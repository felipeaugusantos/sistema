unit untCadGlobalColorDinNfm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, EditFocus, DBEditFocus, Uni, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadGlobalColorDinNfm = class(TfrmPaiCad)
    pnlCampos: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeCodBas: TDBEditFocus;
    dbeProd: TDBEditFocus;
    dbeUnid: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeEmbala: TDBEditFocus;
    edtQtdEmb: TEditFocus;
    edtUniEmb: TEditFocus;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    dbeForm01: TDBEditFocus;
    Label10: TLabel;
    dbeForm02: TDBEditFocus;
    Label11: TLabel;
    dbeForm03: TDBEditFocus;
    Label12: TLabel;
    dbeForm04: TDBEditFocus;
    Label13: TLabel;
    dbeForm05: TDBEditFocus;
    Label15: TLabel;
    dbeQtd01: TDBEditFocus;
    Label16: TLabel;
    dbeQtd02: TDBEditFocus;
    Label17: TLabel;
    dbeQtd03: TDBEditFocus;
    Label18: TLabel;
    dbeQtd04: TDBEditFocus;
    Label19: TLabel;
    dbeQtd05: TDBEditFocus;
    Label21: TLabel;
    dbeForm06: TDBEditFocus;
    Label22: TLabel;
    dbeForm07: TDBEditFocus;
    Label23: TLabel;
    dbeForm08: TDBEditFocus;
    Label24: TLabel;
    dbeForm09: TDBEditFocus;
    Label25: TLabel;
    dbeForm10: TDBEditFocus;
    dbeQtd10: TDBEditFocus;
    Label28: TLabel;
    Label29: TLabel;
    dbeQtd09: TDBEditFocus;
    dbeQtd08: TDBEditFocus;
    Label30: TLabel;
    Label31: TLabel;
    dbeQtd07: TDBEditFocus;
    dbeQtd06: TDBEditFocus;
    Label32: TLabel;
    Label55: TLabel;
    dbeDtaCad: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodBasKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEmbalaKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeForm01KeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeEmbalaExit(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    qryCadNfm: TUniQuery;
    dtsCadNfm: TDataSource;
    procedure pCarregaEmbalagem();
    function VerificarNovaFormulaMovimentada: Boolean;
    function fJaExisteEssaBaseNaFormulacao(strCodBas: String; dbeForm: TObject): Boolean;
  protected
    procedure pCriaDataSet;
    procedure pLigaDataSet;
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fValidaBase: Boolean;
    function fValidaEmbala: Boolean;
    function fValidaColorante(strCodCol: String): Boolean;
  public
    { Public declarations }
  end;

var
  frmCadGlobalColorDinNfm: TfrmCadGlobalColorDinNfm;

implementation

uses untFuncoesSimples, StrUtils, untIConfTinta,
  untFuncTinta, untGlobalColorNova, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmCadGlobalColorDinNfm }

function TfrmCadGlobalColorDinNfm.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    dbeForm: TDBEdit;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = dbeCodBas) Or (Sender = dbeProd) Or (Sender = dbeUnid) Then
    Begin
      Result := fValidaBase Or (fMensagem('ATENÇÃO', 'A base preenchida não é válida!', ['OK']) = 2);
    End

    Else If (Sender = dbeEmbala) Then
    Begin
      Result := fValidaEmbala Or (fMensagem('ATENÇÃO', 'A embalagem preenchida não é válida!', ['OK']) = 2);
    End

    Else If (Sender = dbeDescri) Then
    Begin
      Result := Not fEmptyStr(dbeDescri.Text);

      If Not Result Then
      Begin
        fMensagem('ATENÇÃO', 'A descrição deve ser preenchida!', ['OK']);
      End;
    End

    Else If Sender = dbeForm01 Then
    Begin
      If fEmptyStr(dbeForm01.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Deve der preenchido pelo menos um colorante!', ['OK']);
        Result := False;
      End;
    End

    Else If fJaExisteEssaBaseNaFormulacao(TDBEditFocus(Sender).Text, Sender) Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa base já está cadastrada para essa fórmula!', ['&Ok']);
      Result := False;
    End

    Else If LeftStr(Sender.Name, 6) = 'dbeQtd' Then
    Begin
      dbeForm := TDBEdit(FindComponent('dbeForm' + RightStr(Sender.Name, 2)));

      If Assigned(dbeForm) Then
      Begin

        If fEmptyStr(dbeForm.Text) Then
        Begin
          pSetFocus(dbeQtd10);
        End

        Else If fEmptyStr(TDBEdit(Sender).Text) And (Not fEmptyStr(dbeForm.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'A quantidade deve ser preenchida!', ['OK']);
          Result := False;
        End;
      End;
    End

    Else If LeftStr(Sender.Name, 7) = 'dbeForm' Then
    Begin
      Result := (fEmptyStr(TDBEdit(Sender).Text))
        Or fValidaColorante(TDBEdit(Sender).Text)
        Or (fMensagem('ATENÇÃO', 'O colorante preenchido não é válida!', ['OK']) = 2);
    End;

    If Not Result Then
      pSetFocus(Sender);

  End;
end;

procedure TfrmCadGlobalColorDinNfm.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('NFM_CODIGO');
  stlCampos.Add('NFM_CODBAS');
  stlCampos.Add('NFM_DESPRO');
  stlCampos.Add('NFM_UNIDAD');
  stlCampos.Add('NFM_CODEMB');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('NFM_CODIGO');
  stlCamInd.Add('NFM_CODBAS+NFM_DESPRO');
  stlCamInd.Add('NFM_DESCRI');
  stlCamInd.Add('AUTOINCREM');

  stlDesInd.Add('Código');
  stlDesInd.Add('Base/Produto');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadGlobalColorDinNfm.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSet;
  pLigaDataSet;

  qryTabela := qryCadNfm;
  strNomeTabela := 'GLO_CADNFM';
  strNomeCampo := 'NFM_CODIGO';

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  pCarregaEmbalagem;
end;

procedure TfrmCadGlobalColorDinNfm.pCriaDataSet;
  Var
    intCont: Integer;
begin

  qryCadNfm := fCriaQuery(Self);
  qryCadNfm := fCriarQuery('SELECT * FROM GLO_CADNFM WHERE FALSE', Self);

  qryCadNfm.FieldByName('NFM_CODIGO').DisplayLabel := 'Código';
  qryCadNfm.FieldbyName('NFM_DESCRI').DisplayLabel := 'Descrição';
  qryCadNfm.FieldbyName('NFM_DESPRO').DisplayLabel := 'Produto';
  qryCadNfm.FieldbyName('NFM_UNIDAD').DisplayLabel := 'Unidade';
  qryCadNfm.FieldbyName('NFM_DTACAD').DisplayLabel := 'Data Cadastro';
  qryCadNfm.FieldByName('AUTOINCREM').Visible := False;

  For intCont := 1 To 10 Do
  Begin
    TFloatField(qryCadNfm.FieldByName('NFM_QTDC' + fStrZero(intCont, 2))).DisplayFormat := '0.00';
  End;

  dtsCadNfm := fCriaDataSource(qryCadNfm);
end;

procedure TfrmCadGlobalColorDinNfm.pLigaDataSet;
  Var
    intCont: Integer;
begin

  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadNfm;
    End;
  End;

  dbeCodigo.DataField := 'NFM_CODIGO';
  dbeCodBas.DataField := 'NFM_CODBAS';
  dbeProd.DataField := 'NFM_DESPRO';
  dbeUnid.DataField := 'NFM_UNIDAD';
  dbeEmbala.DataField := 'NFM_CODEMB';
  dbeDescri.DataField := 'NFM_DESCRI';
  dbeDtaCad.DataField := 'NFM_DTACAD';

  For intCont := 1 To 10 Do
  Begin
    TDBEdit(FindComponent('dbeForm' + fStrZero(intCont, 2))).DataField := 'NFM_FORM' + fStrZero(intCont, 2);
    TDBEdit(FindComponent('dbeQtd' + fStrZero(intCont, 2))).DataField := 'NFM_QTDC' + fStrZero(intCont, 2);
  End;
end;

function TfrmCadGlobalColorDinNfm.VerificarNovaFormulaMovimentada: Boolean;
begin
  Try
    Result := False;
    Try
      Result := fVerificarNovaFormulaMovimentada(' SELECT                             ' +
        '   COUNT(0) AS QTD                  ' +
        ' FROM                               ' +
        '   %0:s D                         ' +
        '   INNER JOIN GLO_CADGLO C       ' +
        '     ON D.%1:s_ITETIN = C.GLO_MD5KEY ' +
        '   INNER JOIN GLO_CADNFM N       ' +
        '     ON C.GLO_CODIGO = N.NFM_CODIGO ' +
        ' WHERE D.%1:s_IDEPRO = "GLO"         ' +
        '   AND N.NFM_CODIGO = :CODNFM       ', [qryTabela.FieldByName('NFM_CODIGO').AsString]);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;

procedure TfrmCadGlobalColorDinNfm.pCarregaEmbalagem;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   EMB_QTDEMB               ' +
        '   , EMB_UNIDAD             ' +
        ' FROM                       ' +
        '   GLO_CADEMB            ' +
        ' WHERE EMB_CODEMB = :CODEMB ';
      qryGen.ParamByName('CODEMB').AsString := dbeEmbala.Text;
      qryGen.Open;

      edtQtdEmb.Text := qryGen.FieldByName('EMB_QTDEMB').AsString;
      edtUniEmb.Text := qryGen.FieldByName('EMB_UNIDAD').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

procedure TfrmCadGlobalColorDinNfm.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqFormulaTinta(Self, conGlo, Nil, qryTabela, key, arrSel) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregaEmbalagem;
  End;
end;

procedure TfrmCadGlobalColorDinNfm.dbeCodBasKeyPress(Sender: TObject; var Key: Char);
var
  qryGen : TUniQuery;
  arrSel: TConsultasArray;
begin
  qryGen :=  fCriaQuery(Self);
  Try
    If fPesqBaseTinta(Self, conGlo, dbeCodBas, dbeProd, qryGen, Key, arrSel) Then
    Begin
      dbeUnid.Field.AsString := qryGen.FieldByName('BAS_UNIDAD').AsString;
      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadGlobalColorDinNfm.dbeEmbalaExit(Sender: TObject);
begin
  pCarregaEmbalagem;
end;

procedure TfrmCadGlobalColorDinNfm.dbeEmbalaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
Begin
  If fPesqEmbalagemUnidadeTinta(Self, conGlo, dbeEmbala, edtUniEmb, edtQtdEmb, '', Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadGlobalColorDinNfm.btnAlterarClick(Sender: TObject);
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;

  inherited;
  pSetFocus(dbeCodBas);
end;

procedure TfrmCadGlobalColorDinNfm.btnGravarClick(Sender: TObject);
  Var
    blnInsert: Boolean;
    strNfmBri: String;
    conf : IConfTinta;
begin
  conf := fGetConfTinta('GLO');

  blnInsert := (qryTabela.State = dsInsert);

  qryTabela.FieldByName('NFM_GERUNI').AsInteger := fMensagem('', 'Deseja gerar Litro, Galão e Lata?', ['Sim', 'Não']);

  If qryTabela.FieldByName('NFM_GERUNI').AsInteger = 1 Then
  Begin
    If not Pos('LT_QT_', qryTabela.FieldByName('NFM_UNIDAD').AsString) > 0 Then
    Begin
      fMensagem('ATENÇÃO', 'A Formula deve ser em litro ou quarto!', ['OK']);
      Exit;
    End;
  End;

  If (blnInsert) Then
  Begin
    strNfmBri := conf.fGet('NFMCOR');
    qryTabela.FieldByName('NFM_CODIGO').AsString := 'ESP ' + VS_strCodEmp + fStrZero(strNfmBri, 5);
  End;

  fStartTransaction;
  inherited;

  Try
    If (blnGravou) Then
    Begin
      If (fGravaNovasFormulasDin(qryTabela)) Then
      Begin
        If (blnInsert) Then
        Begin
          conf.pSetInteger('NFMCOR', StrToInt(strNfmBri) + 1);
        End;

        fCommit;
      End
      Else
        fRollBack;

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

function TfrmCadGlobalColorDinNfm.fValidaBase: Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Result := False;
    Try
      qryGen := fCriaQuery(Self);
      qryGen.SQL.Text :=
        ' SELECT                           ' +
        '   COUNT(*) QTD                   ' +
        ' FROM                             ' +
        '   GLO_CADBAS                  ' +
        '   INNER JOIN CADITE              ' +
        '     ON BAS_CODITE = ITE_CODITE   ' +
        ' WHERE BAS_BASE__ = :CODBAS       ' +
        '   AND BAS_DESCRI = :DESPRO       ' +
        '   AND BAS_UNIDAD = :UNIDAD       ';

      qryGen.ParamByName('CODBAS').AsString := dbeCodBas.Text;
      qryGen.ParamByName('DESPRO').AsString := dbeProd.Text;
      qryGen.ParamByName('UNIDAD').AsString := dbeUnid.Text;

      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TfrmCadGlobalColorDinNfm.fValidaEmbala: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  
  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   COUNT(*)    QTD ');
  qryGen.SQL.Add(' FROM GLO_CADEMB ');
  qryGen.SQL.Add(' WHERE EMB_CODEMB = :CODEMB ');
  qryGen.ParamByName('CODEMB').AsString := dbeEmbala.Text;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadGlobalColorDinNfm.dbeForm01KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  fPesqColorantes(Self, conGlo, TDBEdit(Sender), Nil, Nil, Key, arrSel);
end;

function TfrmCadGlobalColorDinNfm.fJaExisteEssaBaseNaFormulacao(
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

function TfrmCadGlobalColorDinNfm.fValidaColorante(strCodCol: String): Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT COUNT(*) QTD FROM GLO_CADCOL WHERE COL_CODCOL = :CODCOL';
  qryGen.ParamByName('CODCOL').AsString := strCodCol;
  qryGen.Open;
  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

procedure TfrmCadGlobalColorDinNfm.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  dbeDtaCad.Field.AsDateTime := Date;
  pSetFocus(dbeCodBas);
  pCarregaEmbalagem;
end;

procedure TfrmCadGlobalColorDinNfm.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaEmbalagem;
end;

procedure TfrmCadGlobalColorDinNfm.btnExcluirClick(Sender: TObject);
  Var
    strCodigo: String;
begin
  if VerificarNovaFormulaMovimentada then
  begin
    fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la', ['&OK']);
    Exit;
  end;
  
  strCodigo := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
  fStartTransaction;
  inherited;
  Try
    If blnExcluiu Then
    Begin
      pDeletaNovaFormula(strCodigo);
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

  pCarregaEmbalagem;
end;

initialization
  RegisterClass(TfrmCadGlobalColorDinNfm);
finalization
  UnRegisterClass(TfrmCadGlobalColorDinNfm);

end.
