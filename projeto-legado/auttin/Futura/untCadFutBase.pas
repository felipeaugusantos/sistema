{*****************************************}
{* frmModuloCons.qryCon001 -> CADUNI     *}
{*               qryCon002 -> CADITE     *}
{**************************************MV*}

unit untCadFutBase;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls, DBCtrls,
  Mask, DBEditFocus, DB, EditFocus, StrUtils, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadFutBase = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodFml: TDBEditFocus;
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
    lblProduto: TLabel;
    dbeProduto: TDBEditFocus;
    dtsFutCadBas: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCon002: TUniQuery;
    procedure pCarregaUnidade;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadFutBase: TfrmCadFutBase;

implementation

uses untModuloTinta,untPesqAux,
  untConsultaFatItem, untPai,
  untFuncoesSimples, untFuncTinta,
  untConsultaCompRelacionamento, untFuncoesConsulta, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadFutBase.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryFut_CadBas;
  strNomeTabela := 'FUT_CADBAS';
  strNomeCampo  := 'BAS_CODFML';

  dtsFutCadBas.DataSet := frmModuloTinta.qryFut_CadBas;

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'BAS_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsFut_CadBas;

  SetLength(arrCamposChave, 4);
  arrCamposChave[0] := dbeCodFml;
  arrCamposChave[1] := dbeCodBas;
  arrCamposChave[2] := dbeCodUni;
  arrCamposChave[3] := dbeCodEmp;

  qryCon002 := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

{*****************************************}
{* CALCULA O PREÇO DE VENDA              *}
{**************************************MV*}
function TfrmCadFutBase.fRetPrecoVenda(intOpcao: Integer): Double;
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

function TfrmCadFutBase.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDesUni: String;
    strSigUni: String;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO                       *}
    {**************************************MV*}
    If (Sender = dbeCodFml) Then
    Begin

      If (fEmptyStr(dbeCodFml.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&O k']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA A BASE                         *}
    {**************************************MV*}
    Else If (Sender = dbeCodBas) Then
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

        Else If (Pos(edtSigUni.Text, 'QT_GL_LA_') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa não é uma unidade válida (' + AnsiReplaceStr('QT_GL_LA_', '_', ' ') + ')', ['&Ok']);
          dbeCodUni.Clear;
          edtDesUni.Clear;
          edtSigUni.Clear;
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

            //Adicionado a linha abaixo pq ao passar pela função acima
            // estava apagando o campo produto.
            dbeProduto.text := dtsFutCadBas.dataset.FieldByName('BAS_PRODUT').AsString;

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
    {* VALIDA O PRODUTO                      *}
    {**************************************AC*}
    Else If (Sender = dbeProduto) Then
    Begin

      If (fEmptyStr(dbeProduto.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&O k']);
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
        fMensagem('ATENÇÃO!', 'O Item Base deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'FUT_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
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

    End

    {*****************************************}
    {* VALIDA A MARGEM                       *}
    {**************************************MV*}
    Else If (Sender = dbeMargem) Then
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

    End

    {*****************************************}
    {* VALIDA O PREÇO DE VENDA               *}
    {**************************************MV*}
    Else If (Sender = dbePreVen) Then
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

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadFutBase.pCarregaItem;
begin
  pPesquisaCadIte(qryCon002, qryCon002, dbeCodIte.Text);
  With qryCon002 Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;

procedure TfrmCadFutBase.pCarregaUnidade;
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

procedure TfrmCadFutBase.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODFML');
  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_CODUNI');
  stlCampos.Add('BAS_CODEMP');
  stlCampos.Add('BAS_CODITE');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('BAS_PRECUS');
  stlCampos.Add('BAS_MARGEM');
  stlCampos.Add('BAS_PREVEN');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('BAS_CODBAS+BAS_PRODUT');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Base/Produto');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadFutBase.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqUnidade(Self, dbeCodUni, nil, nil, nil, Key,  arrSel, True, False, False, ' AND UNI_CODUNI IN ("QT","GL","LA")') Then
    If fValidaCampos(dbeCodUni, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadFutBase.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadFutBase.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  qryTabela.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodFml);

  edtDesUni.Clear;
  edtDesIte.Clear;
  edtSigUni.Clear;
end;

procedure TfrmCadFutBase.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(self, conFut, Nil, Nil, qryTabela, key, arrSel, True, '', '', False) Then
  Begin
    pCarregaUnidade;
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadFutBase.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
  edtSigUni.Clear;
end;

procedure TfrmCadFutBase.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
  pCarregaItem;
end;

procedure TfrmCadFutBase.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodFml.Enabled := False;
  dbeCodBas.Enabled := False;
  dbeCodUni.Enabled := False;

  If dbeDescri.Enabled Then
    pSetFocus(dbeDescri);
end;

end.

