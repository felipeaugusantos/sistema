unit untFatDigEstruturaVidro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, TypInfo,
  Dialogs, untPaiSimples, StdCtrls, EditFocus, Menus, ComCtrls, Buttons, Rest.Json,
  ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, Uni, AppEvnts, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, System.Generics.Collections, System.UITypes,
  untFatEstruturaVidro;

type
  TfrmFatDigEstruturaVidro = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    btnAdicionaItem: TBitBtnLocked;
    dtsItens: TDataSource;
    lblCodigo: TLabel;
    edtCodigo: TEditFocus;
    edtDescricao: TEditFocus;
    edtReferencia: TEditFocus;
    lblSiglaUnidade: TLabel;
    edtSiglaUnidade: TEditFocus;
    lblQuantidade: TLabel;
    edtQuantidade: TEditFocus;
    lblAltura: TLabel;
    edtAltura: TEditFocus;
    lblMedCom: TLabel;
    lblLargura: TLabel;
    edtLargura: TEditFocus;
    lblMedLar: TLabel;
    lblAreaM2: TLabel;
    edtAreaM2: TEditFocus;
    lblPrecoVenda: TLabel;
    edtPrecoVenda: TEditFocus;
    lblPrecoVendaTotal: TLabel;
    edtPrecoVendaTotal: TEditFocus;
    lblReferencia: TLabel;
    btnCancelaItem: TBitBtnLocked;
    dbgItens: TDBGridCitel;
    pnlTotais: TPanel;
    Label1: TLabel;
    edtTotalEstrutura: TEditFocus;
    Label2: TLabel;
    edtComplemento: TEditFocus;
    edtDescricaoComplemento: TEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionaItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgItensEnter(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtComplementoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    subItem : TSubItemVidro;
    cdsItens: TUniClientDataSet;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pCarregaItem(strCodigo: String; blnAlterando: Boolean);
    procedure pSetLabelUnidadeMedida;
    procedure pHabilitarMetragem;
    procedure pCalculaTotaisProduto;
    procedure pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
    procedure pAtualizaTotalEstrutura;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pEscapePressed; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strTabPre: String;
    strEntFut: String;
    subItens : TSubItensVidro;
  end;

var
  frmFatDigEstruturaVidro: TfrmFatDigEstruturaVidro;

implementation

uses untfuncoesSimples, untPai, untConsultas, untTypesSistema, untFuncoes,
  untParCalculaPrecoCusto, untIConfiguracao, untTConfiguracao;

{$R *.dfm}

procedure TfrmFatDigEstruturaVidro.pSetLabelUnidadeMedida;
begin
  lblMedCom.Caption := IIF(subItem.strSiglaUnidade = 'M2', 'mm', 'cm');
  lblMedLar.Caption := IIF(subItem.strSiglaUnidade = 'M2', 'mm', 'cm');
end;

procedure TfrmFatDigEstruturaVidro.pHabilitarMetragem;
begin
  If subItem.strUsaMetragem <> 'S' Then
  Begin
    edtLargura.Text    := fFormataCasaDecimalVIDRO('0,00000');
    edtAltura.Text     := fFormataCasaDecimalVIDRO('0,00000');
    edtAreaM2.Text     := '0,00000';

    edtLargura.Enabled := False;
    edtAltura.Enabled  := False;

    edtLargura.NormalColor := edtAreaM2.NormalColor;
    edtAltura.NormalColor  := edtAreaM2.NormalColor;
  End
  Else
  Begin
    edtLargura.Enabled := True;
    edtAltura.Enabled  := True;

    edtLargura.NormalColor := edtQuantidade.NormalColor;
    edtAltura.NormalColor  := edtQuantidade.NormalColor;
  End;
end;

procedure TfrmFatDigEstruturaVidro.pEscapePressed;
begin
  If Not edtCodigo.Focused Then
    btnCancelaItem.Click
  Else
    inherited;
end;

function TfrmFatDigEstruturaVidro.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodigo) Then
    Begin

      If Not fEmptyStr(edtCodigo.Text) And edtCodigo.Enabled Then
      Begin
        edtCodigo.Text := fStrZero(edtCodigo.Text, edtCodigo.TamCampo);
        pCarregaItem(edtCodigo.Text, False);

        If fEmptyStr(subItem.strDescricao) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não foi encontrado no sistema. Verifique o código informado!', ['&O k']);
          Result := False;
        End
        Else If subItem.strAtivo <> 'S' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse item está Inativo!', ['&O k']);
          Result := False;
        End
        Else If subItem.dtaDataBalanco >= VS_Date Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido vender um item com data de balanço ' + DateToStr(VS_Date) + '. Verifique!', ['&O k']);
          Result := False;
        End
        Else If subItem.strCodigo = fCfgSis('ITESER') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido informar o item de Serviço!', ['&O k']);
          Result := False;
        End
        Else If subItem.strCodigo = fCfgSis('ITEFRE') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido informar o item de Frete!', ['&O k']);
          Result := False;
        End
        Else If (subItem.strCodigo = fCfgSis('ITEBOM')) Or (subItem.strCodigo = fCfgSis('ITETAX')) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido informar o item de Bombeamento!', ['&O k']);
          Result := False;
        End
        Else If (subItem.strCodigo = fCfgSis('ITEMAN')) Or (subItem.strCodigo = fCfgSis('ITELAN')) Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido informar o item de Bombeamento!', ['&O k']);
          Result := False;
        End
        Else If subItem.strCodigo = fCfgSis('ITEVID') Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido informar o item de Vidro!', ['&O k']);
          Result := False;
        End;
      End
      Else
      Begin
        If blnBuscaPorChave Then
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgItens);
        End;
      End;
    End

    Else If (Sender = edtComplemento) Then
    Begin
      If subItem.ComplementoVidro.strCodigo <> edtComplemento.Text Then
        subItem.fltPrecoDigitado := 0;

      subItem.ComplementoVidro.pCarregarComplemento(edtComplemento.Text);

      edtDescricao.Text := subItem.fGetDescricaoCompleta;
      edtDescricaoComplemento.Text := subItem.ComplementoVidro.strDescricao;

      If Not fEmptyStr(edtComplemento.Text) And
             fEmptyStr(subItem.ComplementoVidro.strDescricao) Then
      Begin
        fMensagem('ATENÇÃO!', 'Complemento informado não foi encontrado. ' +
                              'Verifique o código digitado!', ['&O k']);
        Result := False;
      End;

      pCalculaTotaisProduto;
    End

    Else If (Sender = edtQuantidade) Then
    Begin
      If fEmptyStr(edtQuantidade.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtQuantidade.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Quantidade deve ser maior que Zero!', ['&O k']);
        Result := False;
      End;
      pCalculaTotaisProduto;
    End

    Else If (Sender = edtAltura) And
            (edtAltura.Enabled)  Then
    Begin
      If fStrToFloat(edtAltura.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', fRetornaInfMedVIDRO(False,False,False,True) + ' deve ser maior ou igual à Zero!', ['&O k']);
        Result := False;
      End
      Else
        pCalculaTotaisProduto;
    End
    Else If (Sender = edtLargura) And
            (edtLargura.Enabled)  Then
    Begin
      If fStrToFloat(edtLargura.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A largura deve ser maior ou igual à Zero!', ['&O k']);
        Result := False;
      End
      Else
        pCalculaTotaisProduto;
    End
    Else If (Sender = edtPrecoVenda) Then
    Begin
      If fStrToFloat(edtPrecoVenda.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O preço de venda não pode ser negativo!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        subItem.fltPrecoDigitado := 0;

        {* Caso o preco digitado seja diferente do preco sugerido
           grava este preco para nao recalcular o mesmo como por
           exemplo ao trocar a tabela de preco ou quando carregar
           o item para alterar *}
        If FormatFloat(edtPrecoVenda.EditFormat, subItem.fGetPrecoTabela) <>
           FormatFloat(edtPrecoVenda.EditFormat, fStrToFloat(edtPrecoVenda.Text)) Then
        Begin
          subItem.fltPrecoDigitado := fStrToFloat(edtPrecoVenda.Text);
        End;

        pCalculaTotaisProduto;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatDigEstruturaVidro.pCalculaTotaisProduto;
begin
  subItem.strTabelaPreco   := strTabPre;
  subItem.strEntregaFutura := strEntFut;

  subItem.fltQuantidade   := fStrToFloat(edtQuantidade.Text);
  subItem.fltAltura       := fStrToFloat(edtAltura.Text);
  subItem.fltLargura      := fStrToFloat(edtLargura.Text);

  subItem.pCalcularValores;

  edtAreaM2.Text := FormatFloat(edtAreaM2.EditFormat, subItem.fltAreaM2);
  edtPrecoVenda.Text := FormatFloat(edtPrecoVenda.EditFormat, subItem.fltPrecoVenda);
  edtPrecoVendaTotal.Text := FormatFloat(edtPrecoVendaTotal.EditFormat, subItem.ValoresTotais.fltPrecoVendaTotal);
end;

procedure TfrmFatDigEstruturaVidro.pCarregaItem(strCodigo: String; blnAlterando: Boolean);
begin
  subItem.pCarregarProduto(strCodigo);

  edtCodigo.Text := strCodigo;

  If subItem.strItemFracionario <> 'S' Then
  Begin
    edtQuantidade.OnKeyPress := pTravaItemFracionadoKey;
    edtLargura.OnKeyPress    := pTravaItemFracionadoKey;
    edtAltura.OnKeyPress     := pTravaItemFracionadoKey;
    edtAreaM2.OnKeyPress     := pTravaItemFracionadoKey;
  End
  Else
  Begin
    edtQuantidade.OnKeyPress := nil;
    edtLargura.OnKeyPress    := nil;
    edtAltura.OnKeyPress     := nil;
    edtAreaM2.OnKeyPress     := nil;
  End;

  pSetLabelUnidadeMedida;
  pHabilitarMetragem;

  If blnAlterando Then
  Begin
    edtCodigo.Enabled    := False;
    btnAdicionaItem.Tag  := cdsItens.FieldByName('autoincrem').AsInteger;
    edtQuantidade.Text   := FormatFloat(edtQuantidade.EditFormat, cdsItens.FieldByName('quantidade').AsFloat);

    If (subItem.strUsaMetragem = 'S') Then
    Begin
      edtLargura.Text := FormatFloat(fFormataCasaDecimalVIDRO(edtQuantidade.EditFormat), cdsItens.FieldByName('largura').AsFloat);
      edtAltura.Text  := FormatFloat(fFormataCasaDecimalVIDRO(edtQuantidade.EditFormat), cdsItens.FieldByName('altura').AsFloat );
    End;

    edtComplemento.Text := cdsItens.FieldByName('complemento').AsString;
    subItem.ComplementoVidro.pCarregarComplemento(edtComplemento.Text);

    subItem.fltPrecoDigitado := cdsItens.FieldByName('precodigitado').AsFloat;
  End;

  edtDescricao.Text := subItem.fGetDescricaoCompleta;
  edtReferencia.Text := subItem.strReferencia;
  edtSiglaUnidade.Text := subItem.strSiglaunidade;
  edtDescricaoComplemento.Text := subItem.ComplementoVidro.strDescricao;

  pCalculaTotaisProduto;
end;

procedure TfrmFatDigEstruturaVidro.btnConfirmaDadosClick(
  Sender: TObject);
begin
  inherited;
  btnCancelaItem.Click;

  If (cdsItens.IsEmpty) Then
    fMensagem('ATENÇÃO!', 'Ao menos um produto deve ser informado!', ['&O k'])
  Else
  Begin
    subItens := TSubItensVidroManager.fLoadFromClientDataSet(cdsItens);
    blnConfirma := True;
    Close;
  End;

end;

procedure TfrmFatDigEstruturaVidro.pAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If dbgItens.Focused Then
    pCarregaItem(DataSet.FieldByName('codigo').AsString, True);
end;

procedure TfrmFatDigEstruturaVidro.btnCancelaDadosClick(
  Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatDigEstruturaVidro.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtComplemento.Clear;
  edtDescricaoComplemento.Clear;
  edtReferencia.Clear;
  edtReferencia.Clear;
  edtSiglaUnidade.Clear;
  edtQuantidade.Clear;
  edtLargura.Clear;
  edtAltura.Clear;
  edtAreaM2.Clear;
  edtPrecoVenda.Clear;
  edtPrecoVendaTotal.Clear;
  btnAdicionaItem.Tag := 0;
  edtCodigo.Enabled := True;
  pCarregaItem('', False);
  pSetFocus(edtCodigo);
end;

procedure TfrmFatDigEstruturaVidro.FormCreate(Sender: TObject);
begin
  inherited;
  edtQuantidade.EditFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  edtLargura.EditFormat    := fFormataCasaDecimalVIDRO(fMskDigitos(fCfgSis('DECQTD', varInteger)));
  edtAltura.EditFormat     := fFormataCasaDecimalVIDRO(fMskDigitos(fCfgSis('DECQTD', varInteger)));
  edtAreaM2.EditFormat     := fMskDigitos(fCfgSis('DECQTD', varInteger));
  edtPrecoVenda.EditFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  lblAltura.Caption        := fRetornaInfMedVIDRO(True,True);
  blnConfirma  := False;
end;

procedure TfrmFatDigEstruturaVidro.FormShow(Sender: TObject);
begin
  inherited;
  edtComplemento.CompZeros := fUsaProCodigo('CADCPL');

  cdsItens := TSubItensVidroManager.fExportToClientDataSet(subItens);
  cdsItens.AfterScroll := pAfterScroll;
  dtsItens.DataSet := cdsItens;

  TFloatField(cdsItens.FieldByName('quantidade')).DisplayFormat      := edtQuantidade.EditFormat;
  TFloatField(cdsItens.FieldByName('largura')).DisplayFormat         := edtLargura.EditFormat;
  TFloatField(cdsItens.FieldByName('altura')).DisplayFormat          := edtAltura.EditFormat;
  TFloatField(cdsItens.FieldByName('aream2')).DisplayFormat          := edtAreaM2.EditFormat;
  TFloatField(cdsItens.FieldByName('precovenda')).DisplayFormat      := edtPrecoVenda.EditFormat;
  TFloatField(cdsItens.FieldByName('precovendatotal')).DisplayFormat := edtPrecoVendaTotal.EditFormat;

  If fEmptyStr(strTabPre) Then
    strTabPre := '1';

  If fEmptyStr(strEntFut) Then
    strEntFut := 'N';

  pAtualizaTotalEstrutura;

  pSetaCodIte( edtCodigo );

end;

procedure TfrmFatDigEstruturaVidro.btnAdicionaItemClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
  Begin
    Exit;
  End;

  If (fStrToFloat(edtPrecoVendaTotal.Text) < 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possivel confirmar um total negativo!', ['&O k']);
    pSetFocus(edtQuantidade);
    Exit;
  End;

{  If (fStrToFloat(edtPrecoVendaTotal.Text) = 0.0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é possivel confirmar um total Zero!', ['&O k']);
    pSetFocus(edtQuantidade);
    Exit;
  End;}

  TSubItensVidroManager.pAddSubItemClientDataSet(subItem, cdsItens, btnAdicionaItem.Tag > 0);

  btnCancelaItem.Click;

  pAtualizaTotalEstrutura;
end;

procedure TfrmFatDigEstruturaVidro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);
  inherited;
end;

procedure TfrmFatDigEstruturaVidro.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If Assigned(cdsItens) And Not cdsItens.IsEmpty Then
  Begin
    If ((cdsItens.RecNo Mod 2) = 0) And (dbgItens.Canvas.Brush.Color <> clHighlight) Then
    Begin
      dbgItens.Canvas.Brush.Color := strToIntDef(fCfgSis('CORZEB'), clMoneyGreen);
      dbgItens.Canvas.FillRect(Rect);
      dbgItens.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;
  End;
end;

procedure TfrmFatDigEstruturaVidro.dbgItensEnter(Sender: TObject);
begin
  inherited;
  pAfterScroll(cdsItens);
end;

procedure TfrmFatDigEstruturaVidro.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
  Begin
    If cdsItens.Active And (Not cdsItens.IsEmpty) And
       fPergunta('Confirma a exclusão do produto "' +
                 cdsItens.FieldByName('descricao').AsString + '"?') Then
    Begin
      cdsItens.Delete;
      pAtualizaTotalEstrutura;
    End;
  End;

  If Key = VK_RETURN Then
  Begin
    If (cdsItens.Active) And (Not cdsItens.IsEmpty) Then
    Begin
      pCarregaItem(cdsItens.FieldByName('codigo').AsString, True);
      pSetFocus(edtComplemento);
    End;
  End;

  If Key = VK_ESCAPE Then
  Begin
    btnCancelaItem.Click;
  End;

end;

procedure TfrmFatDigEstruturaVidro.edtComplementoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqComplVidro(Self, edtComplemento, edtDescricaoComplemento, nil, Key, arrSel) Then
    Begin
      If (fValidaCampos(edtComplemento, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatDigEstruturaVidro.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtCodigo, edtDescricao, nil, Key,
      arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If (fValidaCampos(edtCodigo, True)) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmFatDigEstruturaVidro.pTravaItemFracionadoKey(Sender: TObject; var Key: Char);
Begin
  If CharInSet(Key, [',','.','-']) Then
    Key := #0;
End;

procedure TfrmFatDigEstruturaVidro.pAtualizaTotalEstrutura;
begin
  With TSubItensVidroManager Do
  Begin
    edtTotalEstrutura.Text := FormatFloat(edtTotalEstrutura.EditFormat,
      fCalcularTotais(fLoadFromClientDataSet(cdsItens)).fltPrecoVendaTotal);
  End;
end;

end.

