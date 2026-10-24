unit untEntFreConImpVarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.StdCtrls, UITypes,
  DirectoryEditFocus, Vcl.Mask, MaskEditFocus, EditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxCheckBox, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, Vcl.DBCtrls, DBMemoFocus, untEntFreCon, Datasnap.DBClient, cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTypesSistema, cxDataControllerConditionalFormattingRulesManagerDialog, 
  untFrameDirectoryEditFocus, MaskUtils, untFramePlanoDeContasMaskEdit, cxButtons;

type
  TfrmEntFreConImpVarios = class(TfrmPaiSimples)
    BitBtnLocked1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlTail: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    lblCndPag: TLabel;
    mskDtaEnt: TMaskEditFocus;
    chkCndPag: TCheckBox;
    mskConPag: TMaskEditFocus;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Splitter1: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    dbmLOGIMP: TDBMemoFocus;
    Panel5: TPanel;
    Shape1: TShape;
    Label5: TLabel;
    Shape2: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Shape3: TShape;
    prgProgresso: TProgressBar;
    cxgArquivos: TcxGrid;
    cxgArquivosView: TcxGridDBTableView;
    cxgArquivosIMPORT: TcxGridDBColumn;
    cxgArquivosNOMARQ: TcxGridDBColumn;
    cxgArquivosSTATUS: TcxGridDBColumn;
    cxgArquivosNUMDOC: TcxGridDBColumn;
    cxgArquivosESPDOC: TcxGridDBColumn;
    cxgArquivosCGCTRA: TcxGridDBColumn;
    cxgArquivosCODTRA: TcxGridDBColumn;
    cxgArquivosNOMTRA: TcxGridDBColumn;
    cxgArquivosCNDPAG: TcxGridDBColumn;
    cxgArquivosVALTOT: TcxGridDBColumn;
    cxgArquivosLevel1: TcxGridLevel;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    Label2: TLabel;
    dirPasta: TfraDirectoryEditFocus;
    cxgArquivosABRCOF: TcxGridDBColumn;
    cxgArquivosABRPIS: TcxGridDBColumn;
    pnlLegAbrevicaoPISCOF: TPanel;
    shpAlqPis: TShape;
    Label8: TLabel;
    shpAlqCof: TShape;
    Label9: TLabel;
    cxgArquivosAUTCOF: TcxGridDBColumn;
    cxgArquivosAUTPIS: TcxGridDBColumn;
    Label20: TLabel;
    edtTraLot: TEditFocus;
    cxgArquivosCREICM: TcxGridDBColumn;
    btnDesmarcaCreditaICMS: TBitBtnLocked;
    btnMarcaCreditaICMS: TBitBtnLocked;
    chkGravaFinanceiro: TCheckBox;
    lblEventos: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    cxgArquivosCNDXML: TcxGridDBColumn;
    fraPlanoDeContasPga: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasRec: TfraPlanoDeContasMskEdit;
    shpSemNota: TShape;
    Label10: TLabel;
    cxgArquivosTransf: TcxGridDBColumn;
    cxgArquivosDTADOC: TcxGridDBColumn;
    cxgArquivosCFOP: TcxGridDBColumn;
    cxgArquivosCODTRAN: TcxGridDBColumn;
    chkArquivoComErro: TCheckBox;
    chkErroGravarRegistro: TCheckBox;
    chkDocumentoJaExiste: TCheckBox;
    chkNfeAnexaNaoIdentificada: TCheckBox;
    chkInformarAbreviacaoPIS: TCheckBox;
    lblMenConPag: TLabel;
	btnHlpImp: TCxButton;
    frxHelp: TfrxReport;
    chkVerEndEnt: TCheckBox;
    chkImpCTEComDCe: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cxgArquivosViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure chkCndPagClick(Sender: TObject);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgArquivosABRPISPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxgArquivosABRCOFPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pReiniciaProcesso(blnHabilita: boolean);
    procedure btnMarcaCreditaICMSClick(Sender: TObject);
    procedure btnDesmarcaCreditaICMSClick(Sender: TObject);
    procedure chkGravaFinanceiroClick(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure cxgArquivosCNDPAGPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgArquivosViewCanFocusRecord(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; var AAllow: Boolean);
    procedure cxgArquivosCNDPAGGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure fraPlanoDeContasPgaMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure fraPlanoDeContasRecMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure cxgArquivosCFOPPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgArquivosTransfGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure selecionaFiltroLegenda(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure chkImpCTEComDCeClick(Sender: TObject);
  private
    objFreCon: TFreCon;
    FblnTravouImportacao: Boolean;
    FstrChaveLock: String;
    { Private declarations }
  public
    tpFrete: TTipoFrete;
    { Public declarations }

  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    Procedure pHabilitaForm(blnHabilita: Boolean);
    function fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untFornecedorNaoImportado, untILiberacao, untLiberacaoFactory;

{ TfrmEntFreConImpVarios }

procedure TfrmEntFreConImpVarios.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pHabilitaForm(False);

  If (Not cxgArquivosCREICM.Visible) Then
    objFreCon.pMarcaTodosCreditaICMS(False);

  objFreCon.blnArquivoComErro := chkArquivoComErro.Checked;
  objFreCon.blnErroGravarRegistro := chkErroGravarRegistro.Checked;
  objFreCon.blnDocumentoJaExiste := chkDocumentoJaExiste.Checked;
  objFreCon.blnNfeAnexaNaoIdentificada := chkNfeAnexaNaoIdentificada.Checked;
  objFreCon.blnInformarAbreviacaoPISCOF := chkInformarAbreviacaoPIS.Checked;

  If objFreCon.fConfirmaImportacaoFrete(prgProgresso) Then
    pReiniciaProcesso(True);
  pHabilitaForm(True);
end;

procedure TfrmEntFreConImpVarios.btnDesmarcaCreditaICMSClick(Sender: TObject);
begin
  inherited;
  If (btnDesmarcaCreditaICMS.Visible) Then
    objFreCon.pMarcaTodosCreditaICMS(False);

end;

procedure TfrmEntFreConImpVarios.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  objFreCon.pMarcaTodosArquivos(False);
end;

procedure TfrmEntFreConImpVarios.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  frxHelp.ShowReport;
end;

procedure TfrmEntFreConImpVarios.btnMarcaCreditaICMSClick(Sender: TObject);
begin
  inherited;
  If (btnMarcaCreditaICMS.Visible) Then
    objFreCon.pMarcaTodosCreditaICMS(True);

end;

procedure TfrmEntFreConImpVarios.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  objFreCon.pMarcaTodosArquivos;
end;

procedure TfrmEntFreConImpVarios.selecionaFiltroLegenda(Sender: TObject);
begin
  inherited;
  objFreCon.blnArquivoComErro := chkArquivoComErro.Checked;
  objFreCon.blnErroGravarRegistro := chkErroGravarRegistro.Checked;
  objFreCon.blnDocumentoJaExiste := chkDocumentoJaExiste.Checked;
  objFreCon.blnNfeAnexaNaoIdentificada := chkNfeAnexaNaoIdentificada.Checked;
  objFreCon.blnInformarAbreviacaoPISCOF := chkInformarAbreviacaoPIS.Checked;

  objFreCon.pFiltraLog;
end;

procedure TfrmEntFreConImpVarios.chkCndPagClick(Sender: TObject);
begin
  inherited;
  mskConPag.Enabled := chkCndpag.Checked;
  If Not (chkCndpag.Checked) Then
    mskConPag.Text := '';
end;

procedure TfrmEntFreConImpVarios.chkGravaFinanceiroClick(Sender: TObject);
begin
  inherited;
  edtCodPor.Enabled := chkGravaFinanceiro.Checked;
  edtCodEve.Enabled := chkGravaFinanceiro.Checked;
  fraPlanoDeContasPga.MskCodCta.Enabled := chkGravaFinanceiro.Checked;
  fraPlanoDeContasRec.MskCodCta.Enabled := chkGravaFinanceiro.Checked;
  chkCndPag.Enabled := chkGravaFinanceiro.Checked;
  
  If Not edtCodPor.Enabled Then
  Begin
    edtCodPor.Text := '';
    edtCodEve.Text := '';
    fraPlanoDeContasPga.MskCodCta.Text := '';
    fraPlanoDeContasRec.MskCodCta.Text := '';
    mskConPag.Text := '';
    chkCndPag.Checked := False;
  End;
  objFreCon.blnGraCTP :=  chkGravaFinanceiro.Checked;
end;

procedure TfrmEntFreConImpVarios.cxgArquivosABRCOFPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  objFreCon.fSelecionaAbreviacaoCofins;
end;

procedure TfrmEntFreConImpVarios.cxgArquivosABRPISPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  objFreCon.fSelecionaAbreviacaoPis;
end;

procedure TfrmEntFreConImpVarios.cxgArquivosCFOPPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  var Conteudo: String;
begin
  inherited;
  Conteudo := DisplayValue;
  If Conteudo[1] <> '2' Then
    Conteudo[1] := '2';

  DisplayValue := Conteudo;

  If (Pos(Copy(DisplayValue,2,3) ,'_932_353' ) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'CFOP incorreto, serão permitidos somente os CFOP x932 ou x353', ['&Ok']);
    DisplayValue := '2353';
  End;
end;

procedure TfrmEntFreConImpVarios.cxgArquivosCNDPAGGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := FormatMaskText('(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_', AText);
end;

procedure TfrmEntFreConImpVarios.cxgArquivosCNDPAGPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;  var Error: Boolean);
  Var
   strConPag: String;
   strCondicao: String;
begin
  inherited;

  strConPag := fTiraCaracEspeciaisPonto(DisplayValue);

  If fEmptyStr(fTiraCaracEspeciais(strConPag)) Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('A condição de pagamento deve ser preenchida!');
  End
  Else If fEmptyStr(Copy(strConPag, 1, 2)) Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('Condição de pagamento inválida!');
  End
  Else If StrToInt(Copy(strConPag, 1, 2)) > 24 Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('Não é permitido mais que 24 parcelas!');
  End
  Else If Not fValidaCndPag(strConPag, strCondicao, StrToDateDef(mskDtaEnt.Text, VS_Date)) Then
  Begin
    ErrorText := '';
    Error     := True;
    pMensagemOk('Essa condição de pagamento não é valida!');
  End
  Else
  Begin
    DisplayValue := strCondicao;
  End;
end;

procedure TfrmEntFreConImpVarios.cxgArquivosTransfGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If VarToStr(cxgArquivosView.DataController.Values[ARecord.RecordIndex,cxgArquivosTransf.Index]) = 'S' Then
    AText := 'Sim'
  Else
    AText := 'Não';
end;

procedure TfrmEntFreConImpVarios.cxgArquivosViewCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
   cxgArquivosCNDPAG.Options.Editing := (VarToStr(Sender.DataController.Values[ARecord.RecordIndex,cxgArquivosCNDXML.Index]) = 'N');
   cxgArquivosCFOP.Options.Editing := (fRetEstadoFornecedor(VarToStr(Sender.DataController.Values[ARecord.RecordIndex,cxgArquivosCODTRAN.Index])) <> fCadEmp('ESTADO'));
end;

procedure TfrmEntFreConImpVarios.cxgArquivosViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    intStatus: Integer;
    strAutPisCof: String;
begin
  inherited;
  intStatus := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                           cxgArquivosSTATUS.Index]), -1);

  Case intStatus Of
    {$region 'IMPORTADO_COM_ERRO'}
    IMPORTADO_COM_ERRO:  Begin
                           ACanvas.Brush.Color := clRed;

                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clYellow;
                         End;
    {$endregion}
    {$region 'COM_ERRO_GRAVACAO'}

    COM_ERRO_GRAVACAO:   Begin
                           ACanvas.Brush.Color := clPurple;
                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clYellow;
                         End;
    {$endregion}
    {$region 'DOCUMENTO_JA_EXISTE'}
    DOCUMENTO_JA_EXISTE: Begin
                           ACanvas.Brush.Color := clYellow;
                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clBlack;
                         End;
    {$endregion}


    Else
      If objFreCon.blnUtiAbr Then
      Begin

        strAutPisCof := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                 cxgArquivosAUTPIS.Index]);

        If fEmptyStr(strAutPisCof) Then
        Begin

          ACanvas.Brush.Color := shpAlqPis.Brush.Color;
          If AViewInfo.Selected Then
            ACanvas.Font.Color := clBlack;

        End Else
        Begin

          strAutPisCof := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                    cxgArquivosAUTCOF.Index]);

          If fEmptyStr(strAutPisCof) Then
          Begin

            ACanvas.Brush.Color := shpAlqCof.Brush.Color;
            If AViewInfo.Selected Then
              ACanvas.Font.Color := clBlack;

          End;

        End;
        If (ACanvas.Brush.Color <> shpAlqCof.Brush.Color) And (ACanvas.Brush.Color <> shpAlqPis.Brush.Color) Then
        Begin
          If intStatus = IMPORTADO_OK_SEM_NF Then
          Begin
            ACanvas.Brush.Color := shpSemNota.Brush.Color;
            If AViewInfo.Selected Then
              ACanvas.Font.Color := clBlack;
           End;
        End;

        dirPasta.edtDirectory.text := fCfgSisL('XMLCTE')

       End;
  End;
  If AViewInfo.Item = cxgArquivosTransf then
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgArquivosTransf.Index]) = 'S' Then
    begin
      ACanvas.Brush.Color := clYellow;
      ACanvas.Font.Color := clBlack;
    End;
end;

procedure TfrmEntFreConImpVarios.edtCodEveKeyPress(Sender: TObject;  var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCodEve, edtDesEve, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodEve) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntFreConImpVarios.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(edtCodPor) then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntFreConImpVarios.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fAtuCfgSis('XMLCTE', dirPasta.edtDirectory.text);
  FreeAndNil(objFreCon);

  If FblnTravouImportacao Then
    fLock_Unlock(FstrChaveLock, False);
end;

procedure TfrmEntFreConImpVarios.FormCreate(Sender: TObject);
begin
  inherited;
  objFreCon := TFreCon.Create(Self);
  lblMenConPag.Visible := fCfgSis('USACND', varBoolean);

  objFreCon.blnImpVariosXml := True;
  chkGravaFinanceiro.Checked := fCfgSis('NOCTFI', varBoolean);

  objFreCon.FCdsFornNaoEncontrado := TfrmFornecedorNaoImportado.fGetClientDataSetEstrutura;
end;

procedure TfrmEntFreConImpVarios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = vkEscape) and (Not pnlTail.Enabled) And
     (fMensagem('','Deseja abandonar esta tarefa?', ['&SIM', '&NÃO'], 1) = 1) Then
  Begin
    pReiniciaProcesso(True);
    Exit;
  End;
  If Key = VK_F6 Then
    btnMarcaTodos.Click;
  If Key = VK_F7 Then
    btnDesmarcaTodos.Click;
  If Key = VK_F8 Then
    btnMarcaCreditaICMS.Click;
  If Key = VK_F9 Then
    btnDesmarcaCreditaICMS.Click;
  inherited;
end;

procedure TfrmEntFreConImpVarios.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaEnt.Text :=FormatDateTime('dd/mm/yyyy', fNow);
  mskConPag.Enabled := False;
  pSetFocus(edtCodPor);
  Self.Caption := Self.Caption + IIf(tpFrete = tpfEntrada, ' - Entrada ', ' - Saída');
  lblMenConPag.Visible :=  (tpFrete = tpfEntrada);
  objFreCon.tpFrete := tpFrete;
  chkImpCTEComDCe.Checked := False;
  If (tpFrete = tpfEntrada) Then
  Begin
    cxgArquivosCREICM.Visible      := Not fCfgSis('SIMPAU', varBoolean);
    btnMarcaCreditaICMS.Visible    := cxgArquivosCREICM.Visible;
    btnDesmarcaCreditaICMS.Visible := cxgArquivosCREICM.Visible;
  End;

  If (Not fCfgSis('UTIABR', varBoolean)) {Or (tpFrete <> tpfEntrada)} Then
  Begin
    cxgArquivosABRPIS.Visible := False;
    cxgArquivosABRCOF.Visible := False;
    pnlLegAbrevicaoPISCOF.Visible := False;
    chkInformarAbreviacaoPIS.Visible := False;
  End;
  dirPasta.edtDirectory.text := fCfgSisL('XMLCTE');

  fraPlanoDeContasRec.Visible := tpFrete = tpfSaida;

  FstrChaveLock := IIf(tpFrete = tpfEntrada, 'IMPORTACAO_CTE_ENTRADA', 'IMPORTACAO_CTE_SAIDA');
  FblnTravouImportacao := fLock_Unlock(FstrChaveLock, True, False);
  If Not FblnTravouImportacao Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta importação já está sendo executada em outra estação por ' +
                         fGetHostLock(FstrChaveLock) + '!', ['&Ok']);
    PostMessage(Handle, WM_CLOSE, 0, 0);
  End;
end;

procedure TfrmEntFreConImpVarios.fraPlanoDeContasPgaMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasPga.MskCodCta, fraPlanoDeContasPga.edtDesCta, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(fraPlanoDeContasPga.MskCodCta) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntFreConImpVarios.fraPlanoDeContasRecMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasRec.MskCodCta, fraPlanoDeContasRec.edtDesCta, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(fraPlanoDeContasRec.MskCodCta) then
      SelectNext(ActiveControl, True, True);
  end;
end;

function TfrmEntFreConImpVarios.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodPor) And (edtCodPor.Enabled) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('','O código do portador deve ser informado !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
        If fEmptyStr(edtNomPor.Text) Then
        Begin
          fMensagem('','Código do Portador incorreto !',['&O K']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;
      If (fCfgSisL('XMLCTE') <> '')  And (dirPasta.edtDirectory.text = '') Then
         dirPasta.edtDirectory.text := fCfgSisL('XMLCTE')
    End

    Else If (Sender = fraPlanoDeContasPga.MskCodCta) And (fraPlanoDeContasPga.MskCodCta.Enabled) Then
    Begin
      If fEmptyStr(fraPlanoDeContasPga.MskCodCta.Text) Then
      Begin
        fMensagem('','O código do Plano de Contas a Pagar deve ser informado !',['&O K']);
        Result := False;
      End
      Else
      Begin
        fraPlanoDeContasPga.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasPga.MskCodCta.Text);
        If fEmptyStr(fraPlanoDeContasPga.edtDesCta.Text) Then
        Begin
          fMensagem('','Código do Plano de Contas a Pagar incorreto !',['&O K']);
          Result := False;
        End
        Else
          Result :=  PlanoDeContasAtivo(fraPlanoDeContasPga.MskCodCta.Text,True);

        If Result Then
          fAtuCfgSis('XMLCTE', dirPasta.edtDirectory.text);
      End;
    End

    Else If (Sender = fraPlanoDeContasRec.MskCodCta) And (fraPlanoDeContasRec.MskCodCta.Enabled) Then
    Begin

      If fraPlanoDeContasRec.Visible Then
      Begin

        If fEmptyStr(fraPlanoDeContasRec.MskCodCta.Text) And (fraPlanoDeContasRec.Visible) Then
        Begin
          fMensagem('','O código do Plano de Contas a Receber deve ser informado !',['&O K']);
          Result := False;
        End
        Else
        Begin
          fraPlanoDeContasRec.edtDesCta.Text := fRetNomeConta(fraPlanoDeContasRec.MskCodCta.Text);

          If fEmptyStr(fraPlanoDeContasRec.edtDesCta.Text) Then
          Begin
            fMensagem('','Código do Plano de Contas a Receber incorreto !',['&O K']);
            Result := False;
          End
          Else
            Result :=  PlanoDeContasAtivo(fraPlanoDeContasRec.MskCodCta.Text,True);

        End;
        dirPasta.edtDirectory.text := fCfgSisL('XMLCTE')
      End;

    End

    Else If (Sender = mskDtaEnt) And (mskDtaEnt.Enabled) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaEnt.Text)) Then
      Begin
        fMensagem('','O Data de Entrada deve ser informada !',['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = mskConPag) And (mskConPag.Enabled) Then
    Begin
      If chkCndPag.Checked Then
        Result := fValidaCondPagamento(blnBuscaPorChave);
    End
    Else If (Sender = dirPasta) Then
    Begin
      If fEmptyStr(dirPasta.edtDirectory.text) Then
      Begin
        fMensagem('','A pasta deve ser informada!',['&O K']);
        Result := False;
      End Else
      Begin

        If Not DirectoryExists(dirPasta.edtDirectory.text) Then
        Begin
          fMensagem('','Pasta não encontrada!',['&O K']);
          Result := False;
        End

        Else If blnBuscaPorChave And fVerificaCampos Then
        Begin

          If Not Assigned(objFreCon) Then
          Begin
            Result := False;
          End Else
          Begin

            objFreCon.strCodOpe := strLoginUsuarioLogado;
            If chkGravaFinanceiro.Checked Then
            Begin
              objFreCon.strPorBai := edtCodPor.Text;
              objFreCon.strCodEve := edtCodEve.Text;
              objFreCon.strCodCta := fraPlanoDeContasPga.MskCodCta.Text;

              If fraPlanoDeContasRec.Visible Then
                objFreCon.strCtaRec := fraPlanoDeContasRec.MskCodCta.Text;

              objFreCon.strCndVaz := mskConPag.Text;
            end;
            objFreCon.strDtaEnt := mskDtaEnt.Text;
            objFreCon.strTraLot := edtTraLot.Text;

            objFreCon.blnVerificarEndEntrega := chkVerEndEnt.Checked;

            pHabilitaForm(False);
            If objFreCon.fCarregaArquivos(dirPasta.edtDirectory.text, 'xml') Then
            Begin
              cxgArquivosView.DataController.DataSource := objFreCon.dtsTabela;
              dbmLOGIMP.DataSource := objFreCon.dtsTabela;
              objFreCon.blnImpCTeComDCe := chkImpCTEComDCe.Checked;
              objFreCon.fXmlToBanco(prgProgresso);
            End;
            pHabilitaForm(True);
            pReiniciaProcesso(False);

            If (Assigned(objFreCon.FCdsFornNaoEncontrado) And (objFreCon.FCdsFornNaoEncontrado.Active) And (Not objFreCon.FCdsFornNaoEncontrado.IsEmpty)) Then
              TfrmFornecedorNaoImportado.fExibirFornecedoresNaoImportados(objFreCon.FCdsFornNaoEncontrado);

          End;

        End;

      End;
      If Result Then
        fAtuCfgSis('XMLCTE', dirPasta.edtDirectory.text);
    End

    Else If (Sender = edtCodEve) Then
    Begin
      If Not fEmptyStr(edtCodEve.Text) Then
      Begin
        edtDesEve.Text := fRetNomEvento(edtCodEve.Text);
        If fEmptyStr(edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(edtCodEve.Text)='R') And (tpFrete = tpfEntrada) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End
        Else If (fRetTipoEvento(edtCodEve.Text)='P') And (tpFrete = tpfSaida) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a pagar!',['&OK']);
          Result := False;
        End
      End
      Else
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) And (tpFrete = tpfEntrada) And chkGravaFinanceiro.Checked Then
        Begin
          fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
          Result := False;
        End;
        edtDesEve.Clear;
      End;
    End;

  End;

  If Not Result Then
  Begin
    blnMudarFoco := False;
    pSetFocus(Sender);
  End;

end;

procedure TfrmEntFreConImpVarios.pHabilitaForm(blnHabilita: Boolean);
begin
  //pnlTopo.Enabled     := blnHabilita;
  cxgArquivos.Enabled := blnHabilita;
  pnlBotoes.Enabled   := blnHabilita;
end;


procedure TfrmEntFreConImpVarios.pReiniciaProcesso(blnHabilita: boolean);
begin
  pnlTail.Enabled     := blnHabilita;
  chkGravaFinanceiro.Enabled := blnHabilita;

  edtCodPor.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  edtCodEve.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  fraPlanoDeContasPga.MskCodCta.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  fraPlanoDeContasRec.MskCodCta.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  mskConPag.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  mskDtaEnt.Enabled := blnHabilita;
  chkCndPag.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  dirPasta.Enabled  := blnHabilita;
  edtTraLot.Enabled := blnHabilita;

  If blnHabilita Then
  Begin
    edtCodPor.Clear;
    edtNomPor.Clear;
    edtCodEve.Clear;
    edtDesEve.Clear;
    fraPlanoDeContasPga.edtDesCta.Clear;
    fraPlanoDeContasRec.edtDesCta.Clear;
    fraPlanoDeContasPga.MskCodCta.Clear;
    fraPlanoDeContasRec.MskCodCta.Clear;
    mskDtaEnt.Clear;
    mskDtaEnt.Text :=FormatDateTime('dd/mm/yyyy', fNow);
    mskConPag.Clear;
    chkCndPag.Checked := False;
    mskConPag.Enabled := False;
    dirPasta.edtDirectory.text := fCfgSisL('XMLCTE');
    edtTraLot.Clear;
    If Assigned(objFreCon) Then
      objFreCon.qryTabela.EmptyDataSet;
    pSetFocus(edtCodPor);

    If (Assigned(objFreCon.FCdsFornNaoEncontrado) And (objFreCon.FCdsFornNaoEncontrado.Active) And (Not objFreCon.FCdsFornNaoEncontrado.IsEmpty)) Then
      objFreCon.FCdsFornNaoEncontrado.EmptyDataSet;
  End;

  cxgArquivosCNDPAG.Options.Editing := chkGravaFinanceiro.Checked And chkCndPag.Checked;
end;

function TfrmEntFreConImpVarios.fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;
  Var
   strConPag: String;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(mskConPag.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
    Result := False;
  End

  Else If fEmptyStr(Copy(mskConPag.Text, 1, 2)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Condição de pagamento inválida!', ['&O k']);
    Result := False;
  End
  Else If StrToInt(Copy(mskConPag.Text, 1, 2)) > 24 Then
  Begin
    fMensagem('', 'Não é permitido mais que 24 parcelas!', ['&O k']);
    Result := False;
  End
  Else If Not fValidaCndPag(mskConPag.Text, strConPag, StrToDateDef(mskDtaEnt.Text, VS_Date)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa condição de pagamento não é valida!', ['&O k']);
    Result := False;
  End Else
  Begin
    mskConPag.Text := strConPag;

    If fEmptyStr(strConPag) Then
      Result := False;

  End;

end;

procedure TfrmEntFreConImpVarios.chkImpCTEComDCeClick(Sender: TObject);
var
  objLiberacao : ILiberacao;
begin
  inherited;
  If chkImpCTEComDCe.Checked then
  begin
    objLiberacao :=  TLiberacaoFactory.fGetLiberacao;
    objLiberacao.Clear;

    objLiberacao.strDirAce := 'PERCTEDE';
    objLiberacao.strSenLib := '';
    objLiberacao.strMsgSen := 'CT-e com DC-e';
    objLiberacao.objMsgLibera.pAddTexto('Permitir a importação de CT-e com DC-e referenciado');
    If not objLiberacao.fLibera then
      chkImpCTEComDCe.Checked := False;
  end;
end;

end.
