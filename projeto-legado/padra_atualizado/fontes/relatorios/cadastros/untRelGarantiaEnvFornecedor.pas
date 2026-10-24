unit untRelGarantiaEnvFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus,
  untfuncoesSimples, untGarant, frxDesgn, frxClass, frxDBSet,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  frxExportTXT, AppEvnts, BitBtnLockedIncrem, untTypesSistema,
  frxExportCSVTestabilidade, Data.DB, ComboBoxFocus;

type
  TfrmRelGarantiaEnvFornecedor = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblOpcDtaIni: TLabel;
    lblOpcDtaFin: TLabel;
    Label10: TLabel;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    rdgFiltros: TRadioGroup;
    rdgOpcDta: TRadioGroup;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    Label1: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    Label3: TLabel;
    edtProdutos: TEditFocus;
    edtDesProduto: TEditFocus;
    rdgOpcRel: TRadioGroup;
    Label2: TLabel;
    cbbTipoRel: TComboBoxFocus;
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rdgOpcDtaClick(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);
    procedure rdgOpcRelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    objMovGag: TMovGag;

    arrFornecedor: TConsultasArray;

  public
    { Public declarations }


  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  end;

var
  frmRelGarantiaEnvFornecedor: TfrmRelGarantiaEnvFornecedor;

implementation

uses
    untFuncoesConsulta, untConsultas;

{$R *.dfm}

{*****************}
{* VALIDA CAMPOS *}
{**************RL*}
function TfrmRelGarantiaEnvFornecedor.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelGarantiaEnvFornecedor.mskLinGruExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(mskLinGru, edtDesGru, objMovGag.arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);

end;

procedure TfrmRelGarantiaEnvFornecedor.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, nil, Key, objMovGag.arrLinGru, False) then
  Begin
    If fvalidaCampos(mskLinGru,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelGarantiaEnvFornecedor.rdgOpcDtaClick(Sender: TObject);
begin
  inherited;
  lblOpcDtaIni.Caption := IIF(rdgOpcDta.ItemIndex = 0, '(ENVIO)', '(ENTRADA)');
  lblOpcDtaFin.Caption := lblOpcDtaIni.Caption;
end;

procedure TfrmRelGarantiaEnvFornecedor.rdgOpcRelClick(Sender: TObject);
begin
  inherited;
  // relatório sintetico funciona apenas para itens enviados senão não tem informação
  cbbTipoRel.Enabled := rdgOpcRel.ItemIndex = 0;
  If (rdgOpcRel.ItemIndex = 1) Then
  Begin
    rdgFiltros.ItemIndex := 0;
    rdgFiltros.Enabled   := False;
    rdgOpcDta.ItemIndex  := 1;
    rdgOpcDta.Enabled    := False;
    lblOpcDtaIni.Caption := '(ENTRADA)';
    lblOpcDtaFin.Caption := lblOpcDtaIni.Caption;
    cbbTipoRel.ItemIndex := 0;
  End
  Else
  Begin
    rdgFiltros.Enabled := True;
    rdgOpcDta.Enabled  := True;

  End;
  
end;

procedure TfrmRelGarantiaEnvFornecedor.edtFornecedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelGarantiaEnvFornecedor.edtMarcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtMarca,edtDesMarca, objMovGag.arrMarca, fRetNomMarca,nil,'da Marca');

end;

procedure TfrmRelGarantiaEnvFornecedor.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, objMovGag.arrMarca, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelGarantiaEnvFornecedor.edtProdutosExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtProdutos, edtDesProduto, objMovGag.arrProduto, nil, fRetNomProduto, 'do Produto');

end;

procedure TfrmRelGarantiaEnvFornecedor.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, nil, Key, objMovGag.arrProduto, False, nil, 'Consulta de Itens', '1') Then
  Begin
    If fvalidaCampos(edtProdutos, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelGarantiaEnvFornecedor.edtFornecedorExit(
  Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,Nil ,'do forncedor');

end;

procedure TfrmRelGarantiaEnvFornecedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
  End;

end;

procedure TfrmRelGarantiaEnvFornecedor.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelGarantiaEnvFornecedor.btnImprimirClick(
  Sender: TObject);
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

      Try
        objMovGag.edtMarca   := edtMarca;
        objMovGag.mskLinGru  := mskLinGru;
        objMovGag.edtProduto := edtProdutos;

        objMovGag.edtDesGru  := edtDesGru;
        objMovGag.edtDesMar  := edtDesMarca;
        objMovGag.edtDesIte  := edtDesProduto;
        objMovGag.pImprimirRelatorio(1,
                                     StrToDate(mskDtaIni.Text),
                                     StrToDate(mskDtaFin.Text),
                                     edtDestino.Text,
                                     rdgFiltros.ItemIndex,
                                     rdgOpcRel.ItemIndex,
                                     rdgOpcDta.ItemIndex,
                                     edtFornecedor,
                                     nil,
                                     nil,
                                     edtDesFornecedor,
                                     Nil,
                                     Nil,
                                     arrFornecedor,
                                     nil,
                                     nil,
                                     IIf(cbbTipoRel.ItemIndex = 0, trAnalitico, trSintetico));

      Except
        On E: Exception Do
        Begin
					pMensagensErro(E.Message,'[TfrmRelGarantiaEnvFornecedor.btnImprimirClick]');
        End;
      End;

   End;

  If objMovGag.qryRelatorio.IsEmpty Then
    pTabelaVazia;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
  pSetFocus(mskDtaIni);

end;

procedure TfrmRelGarantiaEnvFornecedor.FormCreate(Sender: TObject);
begin
  inherited;

  objMovGag := TMovGag.Create(Self);

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);  

end;

end.









