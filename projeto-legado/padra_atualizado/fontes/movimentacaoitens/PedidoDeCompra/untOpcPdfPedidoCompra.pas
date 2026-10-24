unit untOpcPdfPedidoCompra;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, QColorLabel, untPaiEdit,
  untOpcoesExcelPedCompra, untFuncoesSimples, untTypesSistema, Uni, untTLayoutPedidoCompra, TypesLayoutPedidoCompra;

type

  TfraOpcPdfPedidoCompra = class(TFrame)
    pnltContainer: TPanel;
    gbExporta: TGroupBox;
    ColorLabel1: TColorLabel;
    edtTipExp: TEditFocus;
    btnOpcoesExcel: TBitBtnLocked;
    pnlEmail: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtEmail: TEditFocus;
    edtContato: TEditFocus;
    grbImprimirDados: TGroupBox;
    chkMarca: TCheckBox;
    chkCodFab: TCheckBox;
    chkImpObs: TCheckBox;
    chkLocFis: TCheckBox;
    chkCodbarras: TCheckBox;
    ChkImpReferencia: TCheckBox;
    chkPreco: TCheckBox;
    chkMltCmp: TCheckBox;
    rdgQuantidade: TRadioGroup;
    gbOrdem: TRadioGroup;
    rdgOrientacao: TRadioGroup;
    pnlModelo: TPanel;
    Label3: TLabel;
    edtCodLay: TEditFocus;
    cbxModeloPedido: TComboBox;
    pnlResumo: TPanel;
    chkResumoMarca: TCheckBox;
    chkResumoReferencia: TCheckBox;
    chkResumoGrupo: TCheckBox;
    chkResumoUnidade: TCheckBox;
    chkResumoAcordoObjetivo: TCheckBox;
    chkImpVen: TCheckBox;
    cbxModeloBoletim: TComboBox;
    procedure btnOpcoesExcelClick(Sender: TObject);
    procedure chkMltCmpClick(Sender: TObject);
    procedure edtTipExpChange(Sender: TObject);
    procedure cbxModeloPedidoChange(Sender: TObject);
    procedure cbxModeloBoletimChange(Sender: TObject);
  private
    { Private declarations }
    procedure pAjustaTela;
    procedure pAjustaTelaOpcaoLayout;
    procedure pAjustaTelaEnvioEmail;
    procedure pAjustaTelaExcel;
    procedure pAjustaOutros;
    procedure pAjustaTelaBoletimRecebimento;
    procedure pCarregaOpcoesBoletimRec;

  protected

  public
    frmPai: TForm;
    blnSomentePDF: Boolean;
    procedure pSetAjustaTela(AOperacaoTela:TOperacaoTela);
    function fValidaCamposFrame(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
    class var RecOpcaoImpressao: TRecOpcaoImpressao;
    class procedure pCarregaSelecaoExcel(AbriCadastro: Boolean);
    class function fRetContatoEmailPedCompra(var strNomCtt : String;strCodFor: String): String;
    procedure pAncoraPainel(AForm: TForm ; AParent: TWinControl; opcTelaOrigem: TTelaOrigem);
    function fGetCharOrdem: Char;
    procedure pAjustacbxModeloPedido;
    { Public declarations }
  end;

  const
    cPedidoCompraEditor = 'Imprimir';
    cPedidoCompraPadraoSemEditor = 'PADRÃO AUTCOM (SEM EDITOR)';
    cEmail = 'E-Mail';
    cBoletimRecebimento = 'Boletim de Recebimento';
    cExcel = 'Excel';
    cTigreExcel = 'Tigre-Excel';
    cPDF = 'Gerar PDF';


implementation

{$R *.dfm}

uses untDigEmailPedidoCompra;

procedure TfraOpcPdfPedidoCompra.btnOpcoesExcelClick(Sender: TObject);
begin
  inherited;
  pCarregaSelecaoExcel(True);
end;

procedure TfraOpcPdfPedidoCompra.cbxModeloBoletimChange(Sender: TObject);
begin
  rdgOrientacao.ItemIndex := 0;

  If (cbxModeloBoletim.ItemIndex = 1) Then
    rdgOrientacao.Enabled := True
  Else
    rdgOrientacao.Enabled := False;
end;

procedure TfraOpcPdfPedidoCompra.cbxModeloPedidoChange(Sender: TObject);
const cHeightPnlInf = 355;
      cHeightForm = 245;
begin

  inherited;
  edtCodLay.Text :=  '';
  If cbxModeloPedido.Text = '' Then
     If cbxModeloPedido.Enabled Then
       cbxModeloPedido.ItemIndex := cbxModeloPedido.Items.IndexOf(cPedidoCompraPadraoSemEditor);
  If (cbxModeloPedido.Text <> cPedidoCompraPadraoSemEditor) Then
    If cbxModeloPedido.ItemIndex > -1 Then
      edtCodLay.Text :=  TLayoutPedidoCompra(cbxModeloPedido.Items.Objects[cbxModeloPedido.ItemIndex]).fCodLay;
  pAjustaTela;

  If edtCodLay.Text <> '' Then
    chkImpVen.Enabled := True
  Else
  begin
    chkImpVen.Enabled := False;
    chkImpVen.Checked := False;
  End;
end;

procedure TfraOpcPdfPedidoCompra.chkMltCmpClick(Sender: TObject);
begin
  chkMltCmp.Enabled := (rdgQuantidade.ItemIndex <> 2) And (fCfgSis('CNVEMB') <> 'N');

  If Not chkMltCmp.Enabled Then
    chkMltCmp.Checked := False;

end;

procedure TfraOpcPdfPedidoCompra.edtTipExpChange(Sender: TObject);
begin
  If blnSomentePDF Then
    Exit;

  btnOpcoesExcel.Visible := (edtTipExp.Text = 'E');

  If (edtTipExp.Text = 'E') then
  Begin
    cbxModeloPedido.Enabled := False;
    chkImpVen.Enabled := False;

    cbxModeloPedido.Text := '';
  End;

  If (edtTipExp.Text = 'E') Then
    If not Assigned(RecOpcaoImpressao.stlCamposExcel) Then
      RecOpcaoImpressao.stlCamposExcel := TfrmOpcoesExcelPedCompra.fRetCampos(False);
  If RecOpcaoImpressao.OperacaoTela in [totExcel, totEmail, totPDF] Then
    pSetAjustaTela(RecOpcaoImpressao.OperacaoTela)
end;

function TfraOpcPdfPedidoCompra.fValidaCamposFrame(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtEmail) Then
  Begin

    If pnlEmail.Visible Then
    Begin
      If (fEmptyStr(edtEmail.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O email deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Pos('@', edtEmail.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', edtEmail.Text + ' não é um email válido!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtContato) Then
  Begin

    If pnlEmail.Visible Then
    Begin
      If (fEmptyStr(edtContato.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O contato deve ser preenchido!', ['&Ok']);
        Result := False;
      End
    End;

  End

  {*****************************}
  {* VERIFICA CAMPO EXPORTACAO *}
  {**************************LU*}
  Else
  If (Sender = edtTipExp) Then
  Begin
    If (edtTipExp.Text <> 'P') And (edtTipExp.Text <> 'E') Then
    Begin
      fMensagem('','O campo Exportar em deve ser P ou E.',['&O K']);
      Result := False;
    End;
  End;


end;

procedure TfraOpcPdfPedidoCompra.pAjustaTelaOpcaoLayout;
var indexOriginal: integer;
begin

  gbExporta.Visible := False;
  cbxModeloPedido.Enabled := True;
  edtEmail.Enabled := False;
  edtContato.Enabled := False;
  gbOrdem.Visible := True;
  gbOrdem.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  chkMarca.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  chkLocFis.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  chkCodFab.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  chkImpObs.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  chkCodbarras.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  ChkImpReferencia.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  chkPreco.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  chkMltCmp.Enabled := True;
  indexOriginal := rdgQuantidade.ItemIndex;
  rdgQuantidade.Items.Clear;
  rdgQuantidade.Items.Add('Total');
  rdgQuantidade.Items.Add('Pendente');
  If indexOriginal >rdgQuantidade.Items.Count Then
    rdgQuantidade.ItemIndex := 0
  Else
    rdgQuantidade.ItemIndex := indexOriginal;

  rdgQuantidade.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) or (Not fEmptyStr(edtCodLay.Text));
  rdgOrientacao.Enabled := cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor;
  chkImpVen.Enabled := cbxModeloPedido.Text <> cPedidoCompraPadraoSemEditor;

End;

procedure TfraOpcPdfPedidoCompra.pCarregaOpcoesBoletimRec;
begin
  cbxModeloBoletim.Items.Clear;
  cbxModeloBoletim.Items.Add('Boletim de Recebimento - Padrão');
  cbxModeloBoletim.Items.Add('Boletim de Recebimento - A4');
  cbxModeloBoletim.ItemIndex := cbxModeloBoletim.Items.IndexOf('Boletim de Recebimento - Padrão');
end;

procedure TfraOpcPdfPedidoCompra.pAncoraPainel(AForm: TForm ; AParent: TWinControl; opcTelaOrigem: TTelaOrigem);
begin
  Self.frmPai   := AForm;
  Self.Parent   := AParent;

  gbExporta.Visible := True;
  pnlModelo.Visible := True;
  pnlEmail.Visible := True;
  grbImprimirDados.Visible := True;
  rdgQuantidade.Visible := True;
  gbOrdem.Visible := True;
  rdgOrientacao.Visible := True;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem := opioIndeifinido;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.OperacaoTela := totIndefinido;
  RecOpcaoImpressao.TelaOrigem := opcTelaOrigem;

  TLayoutPedidoCompra.pCarregarLayout(cbxModeloPedido, False);
  pCarregaOpcoesBoletimRec;

  TLayoutPedidoCompra.pCarregarLayout(cbxModeloPedido, False);
  chkMltCmp.Visible := (fCfgSis('CNVEMB') <> 'N');
  If Not chkMltCmp.Visible Then
    chkMltCmp.Checked := False;
end;

procedure TfraOpcPdfPedidoCompra.pAjustaTelaEnvioEmail;
  var
    strContato: String;
begin
  rdgQuantidade.Items.Clear;
  rdgQuantidade.Items.Add('Total');
  rdgQuantidade.Items.Add('Pendente');
  rdgQuantidade.Items.Add('Não exibir');

  If blnSomentePDF Then
  Begin
    edtTipExp.Text := 'P';
    gbExporta.Visible := False;
  End
  Else
  Begin
    If TfraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem in [opioPdf, opioXls]  Then
      gbExporta.Visible := False
    Else
      gbExporta.Visible := True;
  End;
  gbOrdem.Visible := True;
  cbxModeloPedido.Enabled := (edtTipExp.Text = 'P');
  edtEmail.Enabled := True;
  edtContato.Enabled := True;
  gbOrdem.Enabled :=  (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');
  chkMarca.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');
  chkLocFis.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');
  chkCodFab.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');
  chkImpObs.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');
  chkCodbarras.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');
  ChkImpReferencia.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');
  chkPreco.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) And (edtTipExp.Text = 'P');
  chkMltCmp.Enabled :=  True;
  rdgQuantidade.Enabled := ((cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) or (Not fEmptyStr(edtCodLay.Text))) and (edtTipExp.Text = 'P');
  rdgOrientacao.Enabled := (cbxModeloPedido.Text = cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');
  gbExporta.Visible := RecOpcaoImpressao.OperacaoTela = totEmail;
  If RecOpcaoImpressao.OperacaoTela = totEmail Then
  begin
    If RecOpcaoImpressao.TelaOrigem = ttoImpPedido Then
    Begin
      If Not fEmptyStr(fRetContatoEmailPedCompra(strContato, RecOpcaoImpressao.strCodFor)) Then
      Begin
        edtEmail.Text   := fRetContatoEmailPedCompra(strContato, RecOpcaoImpressao.strCodFor);
        edtContato.Text := strContato;
      End
      Else
      Begin
        edtEmail.Text   := '';
        edtContato.Text := '';
      End;
    End
    Else If fEmptyStr(edtEmail.Text) Then
    Begin
      edtEmail.Text   := fRetContatoEmailPedCompra(strContato, RecOpcaoImpressao.strCodFor);
      edtContato.Text := strContato;
    End;
  End
  Else
  begin
    edtEmail.Text   := '';
    edtContato.Text := '';
    edtEmail.Enabled := false;
    edtContato.Enabled := false;
  end;

  chkImpVen.Enabled := (cbxModeloPedido.Text <> cPedidoCompraPadraoSemEditor) and (edtTipExp.Text = 'P');;

  cbxModeloPedido.Visible  := True;
  cbxModeloBoletim.Visible := False;
End;

procedure TfraOpcPdfPedidoCompra.pAjustaTelaExcel;
begin
  rdgQuantidade.Items.Clear;
  rdgQuantidade.Items.Add('Total');
  rdgQuantidade.Items.Add('Pendente');
  rdgQuantidade.Enabled := True;
  rdgQuantidade.ItemIndex := 1;
  If RecOpcaoImpressao.Origem = opioXls Then
  Begin
    pnlModelo.Visible := False;
    pnlEmail.Visible := False;
    edtTipExp.OnChange := nil;
    edtTipExp.Text := 'E';
    btnOpcoesExcel.Visible := True;
    If not Assigned(RecOpcaoImpressao.stlCamposExcel) Then
      RecOpcaoImpressao.stlCamposExcel := TfrmOpcoesExcelPedCompra.fRetCampos(False);

    rdgQuantidade.ItemIndex := 0;

    gbExporta.Visible := True;
    edtTipExp.Enabled := False;

    rdgQuantidade.Enabled := True;


    pnlModelo.Visible := False;
    pnlEmail.Visible := False;
    grbImprimirDados.Visible := False;

    gbOrdem.Visible := false;
    rdgOrientacao.Visible := false;
  End
  Else
  Begin
    gbExporta.Visible := False;
    cbxModeloPedido.Enabled := False;
    edtEmail.Enabled := False;
    edtContato.Enabled := False;
    gbOrdem.Enabled := false;

    chkMarca.Enabled := False;
    chkLocFis.Enabled := False;
    chkCodFab.Enabled := False;
    chkImpObs.Enabled := False;
    chkCodbarras.Enabled := False;
    ChkImpReferencia.Enabled := False;
    chkPreco.Enabled := False;
    chkMltCmp.Enabled := True;
    rdgQuantidade.Enabled := False;
    rdgOrientacao.Enabled := False;
  End;
  chkImpVen.Enabled := False;

  cbxModeloPedido.Visible  := True;
  cbxModeloBoletim.Visible := False;
end;


procedure TfraOpcPdfPedidoCompra.pAjustacbxModeloPedido;
begin
  If fEmptyStr(edtCodLay.Text) Then
  Begin
    If cbxModeloPedido.Enabled Then
    begin
      cbxModeloPedido.ItemIndex := cbxModeloPedido.Items.IndexOf(cPedidoCompraPadraoSemEditor);
      cbxModeloPedidoChange(cbxModeloPedido);
    End;
  End
  Else
  Begin
    TLayoutPedidoCompra.pSetLayout(cbxModeloPedido, edtCodLay.Text);
  End;
end;

procedure TfraOpcPdfPedidoCompra.pAjustaOutros;
begin
  gbExporta.Visible := False;
  cbxModeloPedido.Enabled := False;
  chkImpVen.Enabled := False;

  edtEmail.Enabled := False;
  edtContato.Enabled := False;

  chkMarca.Enabled := False;
  chkLocFis.Enabled := False;
  chkCodFab.Enabled := False;
  chkImpObs.Enabled := False;
  chkCodbarras.Enabled := False;
  ChkImpReferencia.Enabled := False;
  chkPreco.Enabled := False;
  chkMltCmp.Enabled := False;
  rdgQuantidade.Enabled := False;
  rdgOrientacao.Enabled := False;
  gbOrdem.Enabled := False;

  cbxModeloPedido.Visible  := True;
  cbxModeloBoletim.Visible := False;
end;

procedure TfraOpcPdfPedidoCompra.pAjustaTelaBoletimRecebimento;
begin
  pAjustaOutros;
  cbxModeloPedido.Visible := False;
  cbxModeloBoletim.Visible := True;
  cbxModeloBoletim.Left := cbxModeloPedido.Left;
  cbxModeloBoletim.Top  := cbxModeloPedido.Top;
  pCarregaOpcoesBoletimRec;
end;

procedure TfraOpcPdfPedidoCompra.pAjustaTela;
Var indexOriginal: Integer;
begin
  case  RecOpcaoImpressao.OperacaoTela  of
    totPdLayout:           pAjustaTelaOpcaoLayout;
    totEmail, totPDF:      pAjustaTelaEnvioEmail;
    totExcel:              pAjustaTelaExcel;
    totBoletimRecebimento: pAjustaTelaBoletimRecebimento;
   Else
     pAjustaOutros;
  End;

  If rdgQuantidade.ItemIndex = -1 Then
    rdgQuantidade.ItemIndex := 0;
  If gbOrdem.ItemIndex = -1 Then
    gbOrdem.ItemIndex := 0;
  If RecOpcaoImpressao.TelaOrigem = ttoImpPedido Then
    pnlResumo.Visible := RecOpcaoImpressao.OperacaoTela = totPdLayout
  Else
    pnlResumo.Visible := False;

  indexOriginal := rdgQuantidade.ItemIndex;
  rdgQuantidade.Items.Clear;
  If edtCodLay.Text <> '' then
  Begin
    rdgQuantidade.Items.Add('Total');
    rdgQuantidade.Items.Add('Pendente');
  End
  Else
  begin
    rdgQuantidade.Items.Add('Total');
    rdgQuantidade.Items.Add('Pendente');
    rdgQuantidade.Items.Add('Não Exibir');
  End;

  If indexOriginal > (rdgQuantidade.Items.Count-1) Then
    rdgQuantidade.ItemIndex := 0
  Else
    rdgQuantidade.ItemIndex := indexOriginal;
end;

procedure TfraOpcPdfPedidoCompra.pSetAjustaTela(AOperacaoTela: TOperacaoTela);
begin
  RecOpcaoImpressao.OperacaoTela :=  AOperacaoTela;

  if Assigned(cbxModeloPedido.OnChange) then
  begin
    cbxModeloPedido.OnChange(cbxModeloPedido);
  end
  Else
    pAjustaTela;
end;

class procedure TfraOpcPdfPedidoCompra.pCarregaSelecaoExcel(AbriCadastro: Boolean);
begin
  If AbriCadastro Then
    FreeAndNil(RecOpcaoImpressao.stlCamposExcel);
  If Not Assigned(RecOpcaoImpressao.stlCamposExcel) Then
  Begin
    RecOpcaoImpressao.stlCamposExcel := TStringList.Create;
    RecOpcaoImpressao.stlCamposExcel := TfrmOpcoesExcelPedCompra.fRetCampos(AbriCadastro);
  End;
end;

function TfraOpcPdfPedidoCompra.fGetCharOrdem: Char;
begin
  Result := ' ';
  If gbOrdem.Visible Then
  case gbOrdem.ItemIndex Of
    0: Result := 'D';
    1: Result := 'A';
    2: Result := 'F';
  End;

end;

class function TfraOpcPdfPedidoCompra.fRetContatoEmailPedCompra(var strNomCtt : String;strCodFor: String): String;
var
  qryGen: TUniQuery;
begin
    qryGen := fCriaQuery;
    Try
      qryGen.SQL.Add(' SELECT FOR_EMAPED, FOR_CONTAT, C.FOR_EMACTT, C.FOR_NOMCTT, C.FOR_CMPCTT  ');
      qryGen.SQL.Add('   FROM CADFOR F               ');
      qryGen.SQL.Add('   LEFT JOIN FORCTT C ON       ');
      qryGen.SQL.Add('   F.FOR_CODFOR = C.FOR_CODFOR ');
      qryGen.SQL.Add('  WHERE	F.FOR_CODFOR = :CODFOR ');
      qryGen.SQL.Add('  HAVING IF(IFNULL(FOR_EMAPED,"") <> "" , TRUE, C.FOR_CMPCTT = "S" ) LIMIT 1 ');
      qryGen.ParamByName('CODFOR').AsString := strCodFor;
      qryGen.Open;
      Result := qryGen.FieldByName('FOR_EMAPED').AsString;
      strNomCtt := qryGen.FieldByName('FOR_CONTAT').AsString;
      If fEmptyStr(Result) Then
      Begin
        Result    := qryGen.FieldByName('FOR_EMACTT').AsString;
        strNomCtt := qryGen.FieldByName('FOR_NOMCTT').AsString;
      End;
    Finally
     FreeAndNil(qryGen);
    End;
end;

initialization
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.OperacaoTela := totIndefinido;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.Origem := opioIndeifinido;
  TfraOpcPdfPedidoCompra.RecOpcaoImpressao.TipoBoletim := tobrPadrao;

Finalization
  If Assigned(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel) Then
    FreeAndNil(TfraOpcPdfPedidoCompra.RecOpcaoImpressao.stlCamposExcel)



end.
