unit untVendaBaseTrocaInfProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus,
  cxContainer, cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, Datasnap.DBClient,
  UniClientDataSet, Faturamento.Classes.VendaBaseTrocaRecebimento, QColorLabel, Uni,
  cxButtonEdit;

type

  TfrmVendaBaseTrocaInfProduto = class(TfrmPaiConfirma)
    pnlAdicionar: TPanel;
    cxGridProdutosDBTableView: TcxGridDBTableViewCitel;
    cxGridProdutosLevel1: TcxGridLevel;
    cxGridProdutos: TcxGridCitel;
    pnlTotal: TPanel;
    lblCodCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblDocumento: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtEmpDoc: TEditFocus;
    lblProduto: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lblTipRec: TLabel;
    edtVlrUni: TCurrencyEditFocus;
    lblVlrUnit: TLabel;
    lblQuantidade: TLabel;
    edtQtdIte: TEditFocus;
    btnAddProduto: TBitBtnLocked;
    dtsProdutos: TDataSource;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosIRC_CODITE: TStringField;
    cdsProdutosITE_DESITE: TStringField;
    cdsProdutosPRODUTO: TStringField;
    cdsProdutosIRC_TIPREC: TStringField;
    cdsProdutosSTR_TIPREC: TStringField;
    cdsProdutosIRC_QTDITE: TFloatField;
    cdsProdutosIRC_UNITAR: TFloatField;
    cdsProdutosIRC_TOTITE: TFloatField;
    cxGridProdutosDBTableViewPRODUTO: TcxGridDBColumn;
    cxGridProdutosDBTableViewSTR_TIPREC: TcxGridDBColumn;
    cxGridProdutosDBTableViewIRC_QTDITE: TcxGridDBColumn;
    cxGridProdutosDBTableViewIRC_UNITAR: TcxGridDBColumn;
    cxGridProdutosDBTableViewIRC_TOTITE: TcxGridDBColumn;
    clrlblPesoUnit: TColorLabel;
    edtVltTot: TCurrencyEditFocus;
    lblVlrTotal: TLabel;
    edtTipRec: TEditFocus;
    cdsProdutosAUTOINCREM: TStringField;
    procedure FormShow(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAddProdutoClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure cxGridProdutosDBTableViewKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cdsProdutosIRC_QTDITEChange(Sender: TField);
  private
    { Private declarations }
    qryCadIte: TUniQuery;

    procedure pCarregarDados;
    procedure pCarregarProduto(const strCodIte: String);
    procedure pAdicionarGrid(const item: TItemRecebido);
    procedure pAtualizarTotais;
    procedure pHabilitarDesabilitarCampos(const blnHabilitar: Boolean);
    procedure pFormatarCampos;
    function fConfirmar: Boolean;
    function fValidarValorTotalRecebido: Boolean;
    function fCancelar: Boolean;
    procedure pLimparLancamentoItem;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    objItemRecebimento: TItemRecebimento;
  end;

implementation

uses
  untFuncoesSimples, untTypesSistema, untConsultas, untPesqAux, StrUtils,
  untTypesVndBaseTroca, untLiberacao, untMsgLiberacao;

{$R *.dfm}

procedure TfrmVendaBaseTrocaInfProduto.btnAddProdutoClick(Sender: TObject);
var
  itemRecebido: TItemRecebido;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If fEmptyStr(edtCodIte.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Código do Produto deve ser preenchido!', ['&O k']);
    pSetFocus(edtCodIte);
    Exit;
  End;

  If Not Assigned(objItemRecebimento) Then
    Exit;

  If Not objItemRecebimento.fVerificaPodeIncluirProduto(edtCodIte.Text) Then
  Begin
    If Not fEmptyStr(objItemRecebimento.strMensagemRetorno) Then
      fMensagem('ATENÇÃO!', objItemRecebimento.strMensagemRetorno, ['&O k']);
    Exit;
  End;

  itemRecebido := objItemRecebimento.fAddProdutoRecebido; 

  If Assigned(itemRecebido) Then
  Begin
    itemRecebido.strCodIte := edtCodIte.Text;
    itemRecebido.strDesIte := edtDesIte.Text;
    itemRecebido.TipRec := TItemRecebido.fstrToTipRec(edtTipRec.Text);
    itemRecebido.fltVlrUni := StrToFloatDef(edtVlrUni.Text, 0);
    itemRecebido.fltQtdIte := StrToFloatDef(edtQtdIte.Text, 0);

    pAtualizarTotais;
    pAdicionarGrid(itemRecebido);
    pLimparLancamentoItem;
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmVendaBaseTrocaInfProduto.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
var
  arrProduto: TConsultasArray;
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto, False, nil, 'Consulta de Produtos', '1',
     '', 0, False, False, 0, cdrCodIte, '', False, '', '', True, False, True, '', False, False, False, False, False, False, False, False, '', -1,
     False, '', True, '', '', '', '', '', '', True, False, False, Nil, Nil, '', '', '', '', '', '', '', '', False, False, False, True) Then
  Begin
    fValidaCampos(edtCodIte, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmVendaBaseTrocaInfProduto.fConfirmar: Boolean;
begin
  Result := fValidarValorTotalRecebido;
end;

procedure TfrmVendaBaseTrocaInfProduto.btnConfirmaClick(Sender: TObject);
begin
  If Not btnConfirma.Enabled Then
    Exit;

  blnVerificaCampos := False;

  inherited;

  If Not fConfirmar Then
  Begin
    ModalResult := mrNone;
  End;
end;

procedure TfrmVendaBaseTrocaInfProduto.btnSairClick(Sender: TObject);
begin

  If Not fCancelar Then
    Exit;

  inherited;

end;

procedure TfrmVendaBaseTrocaInfProduto.cdsProdutosIRC_QTDITEChange(
  Sender: TField);
var
  intCnt: Integer;
begin
  inherited;

  if cdsProdutosIRC_QTDITE.NewValue <= 0 then
  begin
    cdsProdutosIRC_QTDITE.AsFloat := cdsProdutosIRC_QTDITE.OldValue;
  end;

  if cdsProdutosIRC_QTDITE.OldValue <= 0 then
    Exit;

  If Not Assigned(objItemRecebimento) Then
    Exit;

  For intCnt:= 0 To objItemRecebimento.Produtos.Count-1 Do
  Begin
    if objItemRecebimento.Produtos[intCnt].strAutInc = cdsProdutosAUTOINCREM.AsString then
    begin    
      objItemRecebimento.Produtos[intCnt].fltQtdIte := cdsProdutosIRC_QTDITE.AsFloat;
      cdsProdutosIRC_TOTITE.AsFloat := cdsProdutosIRC_QTDITE.AsFloat * cdsProdutosIRC_UNITAR.AsFloat;
    end;
  End;

  pAtualizarTotais;  
end;

procedure TfrmVendaBaseTrocaInfProduto.cxGridProdutosDBTableViewKeyUp(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If cdsProdutos.IsEmpty Then
    Exit;

  If (Key = VK_DELETE) Then
  Begin
    If (fMensagem('Confirmação', 'Deseja realmente excluir este produto?', ['&Sim', '&Não']) = 1) Then
    Begin
      If objItemRecebimento.fRemoveItem(cdsProdutos.FieldByName('IRC_CODITE').AsString) Then
      Begin
        cdsProdutos.Delete;

        pCarregarDados;
        pAtualizarTotais;
      End;
    End;
  End;
end;

procedure TfrmVendaBaseTrocaInfProduto.FormCreate(Sender: TObject);
begin
  inherited;

  pHabilitarDesabilitarCampos(False);

  qryCadIte := fCriaQuery(Self);

  pnlInfo.Caption := '[DELETE - Para excluir registro]';

  cdsProdutos.CreateDataSet;

  pFormatarCampos;
end;

procedure TfrmVendaBaseTrocaInfProduto.FormShow(Sender: TObject);
begin
  inherited;

  If Assigned(objItemRecebimento) Then
  Begin
    edtNumDoc.Text := objItemRecebimento.strNumDoc;
    edtEspDoc.Text := objItemRecebimento.strEspDoc;
    edtEmpDoc.Text := objItemRecebimento.strCodEmp;
    edtCodCli.Text := objItemRecebimento.objVendaBaseTroca.strCodCli;
    edtNomCli.Text := objItemRecebimento.objVendaBaseTroca.strNomCli;
  End;

  pCarregarDados;
  pAtualizarTotais;
  pSetFocus(edtCodIte);
end;

function TfrmVendaBaseTrocaInfProduto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodIte) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do produto deve ser informado.', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregarProduto(edtCodIte.Text);
        If fEmptyStr(edtDesIte.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Produto não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Not SameText(qryCadIte.FieldByName('ITE_BASTRO').AsString, 'S') Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Produto não está habilitado para a venda com base em troca!', ['&O k']);
            Result := False;
          End;

          If Not SameText(qryCadIte.FieldByName('ITE_TPPROD').AsString, 'R') Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Produto não é do tipo recebimento!', ['&O k']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtTipRec) Then
    Begin
      If fEmptyStr(edtTipRec.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O tipo do recebimento deve ser informado.', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If Not MatchStr(edtTipRec.Text, arrTipoRecebido) Then
        Begin
          fMensagem('ATENÇÃO!', 'O tipo do recebimento inválido.', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtVlrUni) Then
    Begin
      If StrToFloatDef(edtVlrUni.Text, 0) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ter valor unitário informado.', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtQtdIte) Then
    Begin
      If StrToFloatDef(edtQtdIte.Text, 0) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ter a quantidade informada.', ['&O k']);
        Result := False;
      End
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmVendaBaseTrocaInfProduto.fValidarValorTotalRecebido: Boolean;
var
  objLiberacao : TLiberacao;
begin
  If objItemRecebimento.blnAvulso Then
    Exit(True);

  If objItemRecebimento.fltTotRec <= objItemRecebimento.fltTotIte Then
    Exit(True);

  objItemRecebimento.objVendaBaseTroca.pCarregarDadosCliente;

  objLiberacao := TLiberacao.Create;
  Try
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(99);
    objLiberacao.objMsgLibera.pAddTexto('Gerar crédito de recebimento maior que a venda', alCentro, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddSeparador(99);

    objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + objItemRecebimento.objVendaBaseTroca.strCodCli + '-' +
                                                      objItemRecebimento.objVendaBaseTroca.strNomCli, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Cpf/Cnpj: ' + objItemRecebimento.objVendaBaseTroca.strCpfCgc_Cli, alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Nome Fantasia: ' + objItemRecebimento.objVendaBaseTroca.strNomFan_Cli , alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Documento: ' + objItemRecebimento.strNumDoc + '-' +
                                                        objItemRecebimento.strEspDoc + '-' +
                                                        objItemRecebimento.strCodEmp,  alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Produto Venda: ' + objItemRecebimento.strCodIte + '-' + objItemRecebimento.strDesIte , alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Valor da Venda: ' + FormatFloat('#,##0.00', objItemRecebimento.fltTotIte), alEsquerda, teAmbos, '', 99);
    objLiberacao.objMsgLibera.pAddTexto('Valor Recebido: ' + FormatFloat('#,##0.00', objItemRecebimento.fltTotRec), alEsquerda, teAmbos, '', 99);

    objLiberacao.objMsgLibera.pAddSeparador(99);
    objLiberacao.strDirAce := 'VBTCRE';

    objLiberacao.strMsgSen := 'Gerar crédito de recebimento maior que a venda.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  Finally
    FreeAndNil(objLiberacao);
  End;
End;

procedure TfrmVendaBaseTrocaInfProduto.pAdicionarGrid(
  const item: TItemRecebido);
begin
  If Not Assigned(item) Then
    Exit;

  cdsProdutos.Insert;
  cdsProdutos.FieldByName('PRODUTO').AsString := item.strCodIte + ' - ' + item.strDesIte;
  cdsProdutos.FieldByName('IRC_CODITE').AsString := item.strCodIte;
  cdsProdutos.FieldByName('ITE_DESITE').AsString := item.strDesIte;
  cdsProdutos.FieldByName('STR_TIPREC').AsString := item.strTipRec;
  cdsProdutos.FieldByName('IRC_QTDITE').AsFloat  := item.fltQtdIte;
  cdsProdutos.FieldByName('IRC_UNITAR').AsFloat  := item.fltVlrUni;
  cdsProdutos.FieldByName('IRC_TOTITE').AsFloat  := item.fltVlrTot;
  cdsProdutos.FieldByName('AUTOINCREM').AsString := item.strAutInc;
  cdsProdutos.Post;
end;

procedure TfrmVendaBaseTrocaInfProduto.pAtualizarTotais;
begin
  If Not Assigned(objItemRecebimento) Then
    Exit;
      
  objItemRecebimento.pCalcularTotais;
  edtVltTot.Text := FormatFloat('#,##0.00', objItemRecebimento.fltTotRec);
end;

function TfrmVendaBaseTrocaInfProduto.fCancelar: Boolean;
begin
  Result := (fMensagem('Confirmação', 'Deseja realmente cancelar a inclusão de produto(s)?', ['&Sim', '&Não']) = 1);

  If Result Then
  Begin
    objItemRecebimento.pLimparProdutosRecebidos;
  End;
end;

procedure TfrmVendaBaseTrocaInfProduto.pCarregarDados;
var
  intCnt: Integer;
begin
  cdsProdutos.EmptyDataSet;

  For intCnt:= 0 To objItemRecebimento.Produtos.Count-1 Do
  Begin
    pAdicionarGrid(objItemRecebimento.Produtos[intCnt]);
  End;
end;

procedure TfrmVendaBaseTrocaInfProduto.pCarregarProduto(const strCodIte: String);
begin
  edtDesIte.Text := EmptyStr;

  qryCadIte.SQL.Clear;
  qryCadIte.SQL.Add('SELECT * FROM CADITE ');
  qryCadIte.SQL.Add('  WHERE ITE_CODITE = :CODITE');
  qryCadIte.ParamByName('CODITE').AsString := strCodIte;
  qryCadIte.Open;

  If Not qryCadIte.IsEmpty Then
  Begin
    edtDesIte.Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
    edtTipRec.Text := qryCadIte.FieldByName('ITE_TIPREC').AsString;
    edtVlrUni.Text := FormatFloat('#,##0.00', qryCadIte.FieldByName('ITE_VLRCRE').AsFloat);
  End;
end;

procedure TfrmVendaBaseTrocaInfProduto.pFormatarCampos;
begin
  TFloatField(cdsProdutos.FieldByName('IRC_QTDITE')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('IRC_UNITAR')).DisplayFormat := '#,##0.00';
  TFloatField(cdsProdutos.FieldByName('IRC_TOTITE')).DisplayFormat := '#,##0.00';
end;

procedure TfrmVendaBaseTrocaInfProduto.pHabilitarDesabilitarCampos(const blnHabilitar: Boolean);
begin
  edtNumDoc.Enabled := blnHabilitar;
  edtEspDoc.Enabled := blnHabilitar;
  edtEmpDoc.Enabled := blnHabilitar;
  edtCodCli.Enabled := blnHabilitar;
  edtNomCli.Enabled := blnHabilitar;
  edtTipRec.Enabled := blnHabilitar;
  edtVlrUni.Enabled := blnHabilitar;

  edtNumDoc.ReadOnly := Not blnHabilitar;
  edtEspDoc.ReadOnly := Not blnHabilitar;
  edtEmpDoc.ReadOnly := Not blnHabilitar;
  edtCodCli.ReadOnly := Not blnHabilitar;
  edtNomCli.ReadOnly := Not blnHabilitar;
  edtTipRec.ReadOnly := Not blnHabilitar;
end;

procedure TfrmVendaBaseTrocaInfProduto.pLimparLancamentoItem;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtTipRec.Clear;
  edtVlrUni.Clear;
  edtQtdIte.Clear;
end;

end.
