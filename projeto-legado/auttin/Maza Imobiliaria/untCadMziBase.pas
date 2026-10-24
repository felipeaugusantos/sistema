{*****************************************}
{* frmModuloCons.qryCon001 -> CADUNI     *}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadMziBase;

interface

uses
  SysUtils, Types, Classes, Variants,  Graphics, Controls, Forms, Uni,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, UniClientDataSet, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, ComboBoxFocus;

type
  TfrmCadMziBase = class(TfrmPaiCad)
    Label2: TLabel;
    dbeCodBas: TDBEditFocus;
    Label3: TLabel;
    dbeCodUni: TDBEditFocus;
    Label4: TLabel;
    dbeDescri: TDBEditFocus;
    Label5: TLabel;
    dbePreCus: TDBEditFocus;
    Label6: TLabel;
    dbeMargem: TDBEditFocus;
    Label7: TLabel;
    dbePreVen: TDBEditFocus;
    Label8: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesUni: TEditFocus;
    edtDesIte: TEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    edtSigUni: TEditFocus;
    dtsMziCadBas: TDataSource;
    Label27: TLabel;
    dbeDescProd: TComboBoxFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dtsMziCadBasDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;
    cdsProd: TUniClientDataSet;

    procedure pCarregaUnidade;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pPreencherProdutos(strDescricao : String = '');
    function fCriaCdsProdutos: TUniClientDataSet;
    procedure pPreencheCdsProdutos;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadMziBase: TfrmCadMziBase;

{Const
  Arr_Produtos : Array[0..14] of String = ('ESMALTE BASE ÁGUA BRILHANTE',
                                           'TEXTURA LATECRYL (GALÃO)',
                                           'TEXTURA RISCADA H-REPELENTE (GALLONS)',
                                           'ACRÍLICO EXTRA',
                                           'ACRÍLICO PREMIUM ACETINADO',
                                           'ACRÍLICO PREMIUM SEMI-BRILHO',
                                           'ACRÍLICO PREMIUM ELÁSTICO',
                                           'ESMALTE SINTÉTICO BRILHANTE',
                                           'ESMALTE SINTETICO ACETINADO',
                                           'GEL ENVELHECEDOR',
                                           'SELADOR ACRÍLICO',
                                           'TEXTURA FINA H-REPELENTE (GALLONS)',
                                           'TEXTURA RUGOSA H-REPELENTE (GALLONS)',
                                           'ACRÍLICO ULTRA',
                                           'ACRÍLICO PREMIUM FOSCO' );}

implementation

uses untModuloTinta,  untPesqAux,
  untPai,
  untFuncoesSimples, untFuncTinta,
  untFuncoesConsulta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadMziBase.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadMziBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If Assigned(cdsProd) Then FreeAndNil(cdsProd);
  inherited;
end;

procedure TfrmCadMziBase.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryMzi_CadBas;
  strNomeTabela := 'MZI_CADBAS';
  strNomeCampo  := 'BAS_CODBAS';

  dtsMziCadBas.DataSet := frmModuloTinta.qryMzi_CadBas;

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsMzi_CadBas;

  SetLength(arrCamposChave, 3);
  arrCamposChave[0] := dbeCodBas;
  arrCamposChave[1] := dbeCodUni;
  arrCamposChave[2] :=
  dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);

  cdsProd := fCriaCdsProdutos;
  pPreencheCdsProdutos;
end;

procedure TfrmCadMziBase.FormShow(Sender: TObject);
begin
  inherited;

end;

{*****************************************}
{* CALCULA O PREÇO DE VENDA              *}
{**************************************MV*}
function TfrmCadMziBase.fRetPrecoVenda(intOpcao: Integer): Double;
begin

  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,00';

  If fEmptyStr(dbeMargem.Text) Then
    dbeMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePreCus.Text),
                               fStrToFloat(dbePreVen.Text),
                               fStrToFloat(dbeMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

function TfrmCadMziBase.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesUni: String;
    strSigUni: String;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA A BASE                         *}
    {**************************************MV*}
    If (Sender = dbeCodBas) Then
    Begin

      If (fEmptyStr(dbeCodBas.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A base deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A UNIDADE                      *}
    {**************************************MV*}
    Else If (Sender = dbeCodUni) Then
    Begin

      If (fEmptyStr(dbeCodUni.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A unidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        pCarregaUnidade;
        If fEmptyStr(edtDesUni.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&O k']);
          Result := False;
        End

        Else If (Pos(edtSigUni.Text, 'LT_GL_LA_') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr('LT_GL_LA_', '_', ' ') + ')', ['&Ok']);
          Result := False;
        End

        Else If blnBuscaPorChave Then
        Begin
          If (Not fBuscaPorCamposChave) Then
          Begin
            strDesUni := edtDesUni.Text;
            strSigUni := edtSigUni.Text;
            pLimparCampos;
            edtDesUni.Text := strDesUni;
            edtSigUni.Text := strSigUni;
          End
          Else
          Begin
            pCarregaItem;
          End;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO                    *}
    {**************************************MV*}
    Else If (Sender = dbeDescri) Then
    Begin

      If (fEmptyStr(dbeDescri.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O ITEM BASE                    *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin

      If (fEmptyStr(dbeCodIte.Text)) Then
      Begin
        dbeCodIte.Field.Value := Null;
      End
      Else If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'MZI_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!', ['OK']);
          Result := False;
        End
        Else If Not fEmptyStr(dbeCodIte.Text) Then
        Begin
          pCarregaItem;
          If (qryCon002.FieldByName('ITE_CODITE').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If fEmptyStr(edtDesIte.Text) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse item não está cadastrado!', ['OK']);
            Result := False;
          End;
        End;
      End;


    End
    {*****************************************}
    {* VALIDA O PREÇO DE CUSTO               *}
    {**************************************MV*}
    else If (Sender = dbePreCus) Then
    Begin

      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If (fEmptyStr(dbePreCus.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreCus.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End;

    End

    {*****************************************}
    {* VALIDA A MARGEM                       *}
    {**************************************MV*}
    Else If (Sender = dbeMargem) Then
    Begin

      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If (fEmptyStr(dbeMargem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMargem.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve maior ou igual a Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;
      End;

    End

    {*****************************************}
    {* VALIDA O PREÇO DE VENDA               *}
    {**************************************MV*}
    Else If (Sender = dbePreVen) Then
    Begin

      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If (fEmptyStr(dbePreVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreVen.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
        End;
      End;

    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadMziBase.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadMziBase.pCarregaUnidade;
begin
  If Not fEmptyStr(dbeCodUni.Text) Then
  Begin
    edtDesUni.Text := fRetNomUnidade(dbeCodUni.Text);
    edtSigUni.Text := fRetSiglaUnidade(dbeCodUni.Text);
  End
  Else
  Begin
    edtDesUni.Clear;
    edtSigUni.Clear;
  End;
end;

procedure TfrmCadMziBase.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_CODUNI');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('BAS_PRECUS');
  stlCampos.Add('BAS_MARGEM');
  stlCampos.Add('BAS_PREVEN');
  stlCampos.Add('BAS_PRODUT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_CODBAS+BAS_DESCRI');
  stlCamInd.Add('BAS_CODITE');

  stlDesInd.Add('Base/Descrição da base');
  stlDesInd.Add('Código do Item');

end;

procedure TfrmCadMziBase.pPreencheCdsProdutos;
var
  qryProd: TUniQuery;
begin
  Try
    qryProd := fCriaQuery;
    With qryProd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT DISTINCT BAS_PRODUT ');
      SQL.Add('   FROM MZI_CADBAS ');
      Open;

      If Not IsEmpty Then
      Begin
        First;
        While Not Eof Do
        Begin
          cdsProd.Append;
          cdsProd.FieldByName('PRODUTO').AsString :=
            FieldByName('BAS_PRODUT').AsString;
          cdsProd.Post;

          Next;
        End;
        cdsProd.IndexFieldNames := 'PRODUTO';
      End;
    End;
  Finally
    FreeAndNil(qryProd);
  End;
end;

procedure TfrmCadMziBase.pPreencherProdutos(strDescricao : String = '');
var
  intIdx  : Integer;
begin
  intIdx := -1;

  dbeDescProd.Items.Clear;

  cdsProd.First;
  While Not cdsProd.Eof Do
  Begin
    If cdsProd.FieldByName('PRODUTO').AsString = strDescricao Then
      intIdx := (cdsProd.RecNo - 1);

    dbeDescProd.items.Add(cdsProd.FieldByName('PRODUTO').AsString);

    cdsProd.Next;
  End;

  dbeDescProd.ItemIndex := intIdx;
end;

procedure TfrmCadMziBase.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
    if fPesqUnidade(Self, dbeCodUni, nil, nil, nil, Key, arrSel) then
      if fValidaCampos(dbeCodUni, True) then
        SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadMziBase.dtsMziCadBasDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  dbeDescProd.Enabled := (dtsMziCadBas.State in [DsInsert, DsEdit]);
end;

function TfrmCadMziBase.fCriaCdsProdutos: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(Self);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PRODUTO';
    DataType := ftString;
    Size     := 70;
  End;

  Result.CreateDataSet;
  Result.Open;
end;

procedure TfrmCadMziBase.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadMziBase.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadMziBase.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;

  pPreencherProdutos('');

  pSetFocus(dbeCodBas);

  edtDesUni.Clear;
  edtDesIte.Clear;
  edtSigUni.Clear;
end;

procedure TfrmCadMziBase.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conMzi, Nil, Nil, qryTabela, key, arrSel, True, '', '', False) Then
  Begin
    pCarregaUnidade;
    pCarregaItem;
    pPreencherProdutos(qryTabela.FieldByName('BAS_PRODUT').AsString);
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadMziBase.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
  dbeDescProd.ItemIndex := -1;

  edtDesUni.Clear;
  edtDesIte.Clear;
  edtSigUni.Clear;
end;

procedure TfrmCadMziBase.btnGravarClick(Sender: TObject);
begin
  if (dbeDescProd.text = '') then
  begin
    fMensagem('ATENÇÃO!', 'É necessário realizar o vínculo do produto!', ['&O k']);
    pSetFocus(dbeDescProd);
    Exit;
  end;

  qryTabela.FieldByName('BAS_PRODUT').AsString := dbeDescProd.text;

  inherited;

end;

procedure TfrmCadMziBase.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
  pPreencherProdutos(qryTabela.FieldByName('BAS_PRODUT').AsString);
end;

procedure TfrmCadMziBase.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodBas.Enabled := False;
  dbeCodUni.Enabled := False;

  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);
end;

end.

