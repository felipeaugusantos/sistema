unit untRetificarPrecoCheckout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, 
  Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, Vcl.Mask,
  Vcl.DBCtrls;

type
  TfrmRetificarPrecoCheckout = class(TfrmPai)
    pnlCodBarra: TPanel;
    Panel2: TPanel;
    Shape4: TShape;
    shpCodBarra: TShape;
    StaticText6: TStaticText;
    edtCodBarra: TEditFocus;
    pnlTotais: TPanel;
    Shape1: TShape;
    StaticText4: TStaticText;
    pnlNomeProduto: TPanel;
    Shape5: TShape;
    StaticText1: TStaticText;
    pnlReferencia: TPanel;
    Shape6: TShape;
    StaticText2: TStaticText;
    pnlMarca: TPanel;
    Shape8: TShape;
    StaticText3: TStaticText;
    pnlUnidade: TPanel;
    Shape9: TShape;
    StaticText7: TStaticText;
    Shape2: TShape;
    edtQuantidade: TEditFocus;
    edtPreco: TEditFocus;
    Shape7: TShape;
    StaticText5: TStaticText;
    edtTotal: TEditFocus;
    Shape10: TShape;
    StaticText8: TStaticText;
    Shape3: TShape;
    procedure FormCreate(Sender: TObject);
    procedure edtCodBarraKeyPress(Sender: TObject; var Key: Char);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodBarraExit(Sender: TObject);
  private
    { Private declarations }
    class Var FSeqLib: Integer;
    intDecUni: Integer;
    intDecQtd: Integer;
    strOpeRcx: String;
    strCodCli: String;
    strTabPre: String;
    blnConfirma: Boolean;
    qryProduto: TUniQuery;
    procedure pCarregarItem;
    function fConfirmarRetificacaoPreco: Boolean;
  public
    { Public declarations }
    class function fRetificarPreco(strOpeRcx, strCodCli, strTabPre: String; var strCodIte: String;
      var fltQtdIte, fltUnitar: Double): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untConsultas, untFuncoesSimples, untPesqAux, Data.DB, untCadPro, untTypesSistema,
  untLiberacao, untFuncoes;

{$R *.dfm}

{ TfrmRetificarPrecoCheckout }

{*******************************************}
{* CONSULTA PREÇO DO PRODUTO               *}
{****************************************RL*}
procedure TfrmRetificarPrecoCheckout.pCarregarItem;
  Var
    fltUnitar,
    fltQtdEmb,
    fltPreCus,
    fltPreVen,
    fltComVar,
    fltComAta,
    fltComDis,
    fltQtdDis,
    fltDesF07: Double;
    blnParticiona,
    blnPromo: Boolean;
    strComPro,
    strCodPro: String;
begin

  If (Not fEmptyStr(edtCodBarra.Text)) And (edtCodBarra.Text <> '000000000000000') Then
  Begin

    pPesquisaCadIte(qryProduto, qryProduto, edtCodBarra.Text, '', True);
    If Not qryProduto.IsEmpty Then
    Begin
      {*******************************************}
      {* CONSULTA PREÇOS DE PROMOÇÃO DO PRODUTO  *}
      {****************************************RL*}
      If fRetornaPrecosPromocao(qryProduto.FieldByName('ITE_CODITE').AsString,
                                strCodCli,
                                VS_Date,
                                1,
                                0,
                                0,
                                0,
                                fltPreCus,
                                fltPreVen,
                                fltComVar,
                                fltComAta,
                                fltComDis,
                                fltQtdDis,
                                fltDesF07,
                                strComPro,
                                strCodPro,
                                blnParticiona,
                                blnPromo,
                                strTabPre,
                                '') Then
      Begin
        fltUnitar := fltPreVen;
      End
      Else
      Begin
        fltUnitar := qryProduto.FieldByName('ITE_PREVE' + strTabPre).AsFloat;
      End;

      fltQtdEmb := 1;

      If qryProduto.FieldByName('BAR_EMBALA').AsFloat > 0 Then
        fltQtdEmb := qryProduto.FieldByName('BAR_EMBALA').AsFloat;

      If qryProduto.FieldByName('BAR_PREVEN').AsFloat > 0 Then
        fltUnitar := qryProduto.FieldByName('BAR_PREVEN').AsFloat;

      pnlNomeProduto.Caption  := qryProduto.FieldByName('ITE_DESITE').AsString;
      pnlReferencia.Caption   := qryProduto.FieldByName('ITE_REFERE').AsString;
      pnlMarca.Caption        := qryProduto.FieldByName('MAR_DESMAR').AsString;
      pnlUnidade.Caption      := fRetSiglaUnidadePorCodIte(qryProduto.FieldByName('ITE_CODITE').AsString);
      edtQuantidade.Text      := FormatFloat(fMskDigitos(intDecUni), fltQtdEmb);
      edtPreco.Text           := FormatFloat(fMskDigitos(intDecUni), fltUnitar);
      edtTotal.Text           := FormatFloat(fMskDigitos(2), fltUnitar * fltQtdEmb);
      edtQuantidade.ReadOnly  := False;
      edtPreco.ReadOnly       := False;
      pSetFocus(edtQuantidade);
    End
    Else
    Begin
      pnlNomeProduto.Caption  := 'Produto não cadastrado !';
      pnlReferencia.Caption   := '...';
      pnlMarca.Caption        := '...';
      pnlUnidade.Caption      := '...';
      edtQuantidade.Text      := FormatFloat(fMskDigitos(intDecUni), 0);
      edtPreco.Text           := FormatFloat(fMskDigitos(intDecUni), 0);
      edtTotal.Text           := FormatFloat(fMskDigitos(2), 0);
      edtQuantidade.ReadOnly  := True;
      edtPreco.ReadOnly       := True;
      pSetFocus(edtCodBarra);
    End;
  End;
  edtCodBarra.Clear;
end;

procedure TfrmRetificarPrecoCheckout.edtQuantidadeChange(Sender: TObject);
begin
  inherited;
  edtTotal.Text := FormatFloat(fMskDigitos(2), fStrToFloat(edtQuantidade.Text) * fStrToFloat(edtPreco.Text));
end;

function TfrmRetificarPrecoCheckout.fConfirmarRetificacaoPreco: Boolean;
Var
  objLiberacao: TLiberacao;
  blnAbaixoPrecoCusto: Boolean;
begin
  blnAbaixoPrecoCusto := fStrToFloat(edtPreco.Text) < fRetPreCus(VS_strCodEmp, qryProduto.FieldByName('ITE_CODITE').AsString);

  If blnAbaixoPrecoCusto Then
    If Not fPergunta('O preço informado está abaixo do custo. Continua mesmo assim ?') Then
      Exit(False);

  Inc(FSeqLib);

  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Retificar preço de item no F3-Checkout');

    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente', strCodCli + '-' + fRetNomCliente(strCodCli), 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Produto', pnlNomeProduto.Caption, 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Referência', pnlReferencia.Caption, 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Unidade', pnlUnidade.Caption, 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Marca', pnlMarca.Caption, 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade', edtQuantidade.Text, 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Preço', edtPreco.Text, 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Total', edtTotal.Text, 14);

    If blnAbaixoPrecoCusto Then
      objLiberacao.objMsgLibera.pAddTexto('** O preço informado está abaixo do custo.');

    objLiberacao.strDirAce := 'RETPREF3';
    objLiberacao.strMsgSen := 'Retificar preço de item no F3-Checkout';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strOpeRcx;
    objLiberacao.strCodDig := strOpeRcx;
    objLiberacao.strCodIte := qryProduto.FieldByName('ITE_CODITE').AsString;
    objLiberacao.intAutInc := -FSeqLib;//pGeraMatrizLiberacao nao sobrescreve o item e funcao pDefinirAutIncItemLogLib atribui
    objLiberacao.blnUsarSenhaFixa := False;

    Result := objLiberacao.fLibera;

    If Result Then
    Begin
      blnConfirma := True;
      Self.Close;
    End;

  Finally
    objLiberacao.Free;
  End;

end;

procedure TfrmRetificarPrecoCheckout.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  qryProduto  := fCriaQuery(Self);
  intDecUni   := fCfgSis('DECUNI', VarBoolean);
  intDecQtd   := fCfgSis('DECQTD', VarBoolean);

  If fCfgSis('TIPBAR', varString) = '2' Then
   edtCodBarra.MaxLength := 43;

end;

procedure TfrmRetificarPrecoCheckout.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
  If fEmptyStr(strTabPre) Then
    strTabPre := '1';
end;

class function TfrmRetificarPrecoCheckout.fRetificarPreco(strOpeRcx, strCodCli,
  strTabPre: String; var strCodIte: String; var fltQtdIte, fltUnitar: Double): Boolean;
  Var
    frmRetificarPrecoCheckout: TfrmRetificarPrecoCheckout;
begin
  strCodIte := '';
  fltQtdIte := 0.00;
  fltUnitar := 0.00;

  pCriarFormularios(TfrmRetificarPrecoCheckout, frmRetificarPrecoCheckout);
  Try
    frmRetificarPrecoCheckout.strCodCli := strCodCli;
    frmRetificarPrecoCheckout.strTabPre := strTabPre;
    frmRetificarPrecoCheckout.strOpeRcx := strOpeRcx;
    frmRetificarPrecoCheckout.ShowModal;
    Result := frmRetificarPrecoCheckout.blnConfirma;
    If Result Then
    Begin
      If fCfgSis('ITEBAR', varBoolean) Then
        strCodIte := fCampoTabela('BAR_CODBAR', 'ITEBAR', ['BAR_CODITE', 'BAR_PRINCI'], [frmRetificarPrecoCheckout.qryProduto.FieldByName('ITE_CODITE').AsString, 1])
      else
        strCodIte := frmRetificarPrecoCheckout.qryProduto.FieldByName('ITE_CODITE').AsString;
      fltQtdIte := fStrToFloat(frmRetificarPrecoCheckout.edtQuantidade.Text);
      fltUnitar := fStrToFloat(frmRetificarPrecoCheckout.edtPreco.Text);
    End;
  Finally
    pFreeAndNil(frmRetificarPrecoCheckout);
  End;

end;

function TfrmRetificarPrecoCheckout.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodBarra) Then
    Begin
      Result := Not fEmptyStr(edtCodBarra.Text);
    End
    Else If (Sender = edtQuantidade) And (Not edtQuantidade.ReadOnly) Then
    Begin
      edtQuantidade.Text  := FormatFloat(fMskDigitos(intDecUni), fStrToFloat(edtQuantidade.Text));
      If fStrToFloat(edtQuantidade.Text) <= 0 Then
      Begin
        pMensagemOk('A quantidade do produto deve ser maior que zero!');
        Result := False;
      End;
    End
    Else If (Sender = edtPreco) And (Not edtPreco.ReadOnly)  Then
    Begin
      edtPreco.Text  := FormatFloat(fMskDigitos(intDecUni), fStrToFloat(edtPreco.Text));
      If fStrToFloat(edtPreco.Text) <= 0 Then
      Begin
        pMensagemOk('O preço do produto deve ser maior que zero!');
        Result := False;
      End
      Else Result := fValidaCampos(edtQuantidade, True) And fConfirmarRetificacaoPreco();
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

{*******************************************}
{* CONSULTA DO PRODUTO                     *}
{****************************************RL*}
procedure TfrmRetificarPrecoCheckout.edtCodBarraExit(Sender: TObject);
begin
  inherited;
  pCarregarItem;
end;

procedure TfrmRetificarPrecoCheckout.edtCodBarraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryItem: TUniQuery;
    arrSel: TConsultasArray;
begin
  inherited;
  qryItem := fCriaQuery(Self);
  Try
    If fPesqItem(conIteSimples, Self, Nil, Nil, qryItem, Key, arrSel, True, Nil, 'Consulta de Itens', strTabPre) Then
    Begin
      edtCodBarra.Text := fCampoTabela('BAR_CODBAR', 'ITEBAR',
                                      ['BAR_CODITE', 'BAR_PRINCI'],
                                      [qryItem.FieldByName('ITE_CODITE').AsString, 1]);

      SelectNext(edtCodBarra, True, True);
    End;
  Finally
    FreeAndNil(qryItem);
  End;
end;

initialization
  TfrmRetificarPrecoCheckout.FSeqLib := 0;

end.
