unit untEntImportacaoNFSe;

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
  cxGridCustomView, cxGrid, Vcl.DBCtrls, DBMemoFocus, untEntImpNFSe, Datasnap.DBClient, cxContainer, cxTextEdit, cxMaskEdit, cxButtonEdit,
  untTypesSistema, cxDataControllerConditionalFormattingRulesManagerDialog, 
  untFrameDirectoryEditFocus, MaskUtils, untFramePlanoDeContasMaskEdit,
  untCadLayoutXMLNFSe;

type
  TfrmEntImpNFSe = class(TfrmPaiSimples)
    BitBtnLocked1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlTail: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    lblCndPag: TLabel;
    mskDtaEnt: TMaskEditFocus;
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
    cxgArquivosAUTCOF: TcxGridDBColumn;
    cxgArquivosAUTPIS: TcxGridDBColumn;
    chkGravaFinanceiro: TCheckBox;
    lblEventos: TLabel;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    cxgArquivosCNDXML: TcxGridDBColumn;
    fraPlanoDeContasPga: TfraPlanoDeContasMskEdit;
    cxgArquivosDTADOC: TcxGridDBColumn;
    cxgArquivosCFOP: TcxGridDBColumn;
    cxgArquivosCODTRAN: TcxGridDBColumn;
    chkArquivoComErro: TCheckBox;
    chkErroGravarRegistro: TCheckBox;
    lblMenConPag: TLabel;
    btnEditorLayout: TBitBtnLocked;
    Label7: TLabel;
    Shape3: TShape;
    chkDocumentoJaExiste: TCheckBox;
    cxgArquivosViewColumn1: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cxgArquivosViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxgArquivosABRPISPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure cxgArquivosABRCOFPropertiesButtonClick(Sender: TObject; AButtonIndex: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pReiniciaProcesso(blnHabilita: boolean);
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
    procedure cxgArquivosCFOPPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure selecionaFiltroLegenda(Sender: TObject);
    procedure btnEditorLayoutClick(Sender: TObject);
  private
    objImpNFSe: TEntImpNFSe;
    { Private declarations }
  public
    tpNFSe: TTipoFrete;
    { Public declarations }

  protected
    { Protected declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
    Procedure pHabilitaForm(blnHabilita: Boolean);
    function fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untEditorLayoutNFSe;

{ TfrmEntFreConImpVarios }

procedure TfrmEntImpNFSe.btnEditorLayoutClick(Sender: TObject);
Var
  strArquivo: String;
begin
  inherited;
  strArquivo := dirPasta.edtDirectory.text + '\' + objImpNFSe.dtsTabela.DataSet.FieldByName('NOMARQ').AsString;
  If objImpNFSe.fCarregarEditorLayout(strArquivo) Then
    fValidaCampos(dirPasta.edtDirectory);
end;

procedure TfrmEntImpNFSe.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pHabilitaForm(False);

  If objImpNFSe.fConfirmaImportacaoNFSe(prgProgresso) Then
    pReiniciaProcesso(True);
  pHabilitaForm(True);
end;

procedure TfrmEntImpNFSe.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  objImpNFSe.pMarcaTodosArquivos(False);
end;

procedure TfrmEntImpNFSe.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  objImpNFSe.pMarcaTodosArquivos;
end;

procedure TfrmEntImpNFSe.selecionaFiltroLegenda(Sender: TObject);
begin
  inherited;
  objImpNFSe.blnArquivoComErro := chkArquivoComErro.Checked;
  objImpNFSe.blnErroGravarRegistro := chkErroGravarRegistro.Checked;
  objImpNFSe.blnDocumentoJaExiste := chkDocumentoJaExiste.Checked;

  objImpNFSe.pFiltraLog;
end;

procedure TfrmEntImpNFSe.chkGravaFinanceiroClick(Sender: TObject);
begin
  inherited;
  edtCodPor.Enabled := chkGravaFinanceiro.Checked;
  edtCodEve.Enabled := chkGravaFinanceiro.Checked;
  fraPlanoDeContasPga.MskCodCta.Enabled := chkGravaFinanceiro.Checked;

  If Not edtCodPor.Enabled Then
  Begin
    edtCodPor.Text := '';
    edtCodEve.Text := '';
    fraPlanoDeContasPga.MskCodCta.Text := '';
    mskConPag.Text := '';
  End;
  objImpNFSe.fGraCTP(chkGravaFinanceiro.Checked);
end;

procedure TfrmEntImpNFSe.cxgArquivosABRCOFPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  objImpNFSe.fSelecionaAbreviacaoCofins;
end;

procedure TfrmEntImpNFSe.cxgArquivosABRPISPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  objImpNFSe.fSelecionaAbreviacaoPis;
end;

procedure TfrmEntImpNFSe.cxgArquivosCFOPPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
  var Conteudo: String;
begin
  inherited;
  Conteudo := DisplayValue;
  If Conteudo[1] <> '2' Then
    Conteudo[1] := '2';

  DisplayValue := Conteudo;

  If (Pos(Copy(DisplayValue,2,3) ,'_933' ) <= 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'CFOP incorreto, serão permitidos somente os CFOP x933', ['&Ok']);
  End;
end;

procedure TfrmEntImpNFSe.cxgArquivosCNDPAGGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  AText := FormatMaskText('(99)999.999.999.999.999.999.999.999.999.999.999.999;0;_', AText);
end;

procedure TfrmEntImpNFSe.cxgArquivosCNDPAGPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;  var Error: Boolean);
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

procedure TfrmEntImpNFSe.cxgArquivosViewCanFocusRecord(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  var AAllow: Boolean);
begin
  inherited;
   cxgArquivosCNDPAG.Options.Editing := (VarToStr(Sender.DataController.Values[ARecord.RecordIndex,cxgArquivosCNDXML.Index]) = 'N');
   cxgArquivosCFOP.Options.Editing := (fRetEstadoFornecedor(VarToStr(Sender.DataController.Values[ARecord.RecordIndex,cxgArquivosCODTRAN.Index])) <> fCadEmp('ESTADO'));
end;

procedure TfrmEntImpNFSe.cxgArquivosViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
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
                           ACanvas.Font.Color := clRed;
                           If Not AViewInfo.Selected Then
                             ACanvas.Brush.Color := clWindow;
                         End;
    {$endregion}

    {$region 'DOCUMENTO_JA_EXISTE'}
    DOCUMENTO_JA_EXISTE: Begin
                           ACanvas.Brush.Color := clYellow;
                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clBlack;
                         End;
    {$endregion}

    {$region 'COM_ERRO_GRAVACAO'}
    COM_ERRO_GRAVACAO:   Begin
                           ACanvas.Brush.Color := clPurple;
                           If AViewInfo.Selected Then
                             ACanvas.Font.Color := clYellow;
                         End;
    {$endregion}
    Else
      If objImpNFSe.blnUtiAbr Then
      Begin
        If AViewInfo.Selected Then
        Begin
          strAutPisCof := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                   cxgArquivosAUTPIS.Index]);
          If fEmptyStr(strAutPisCof) Then
              ACanvas.Font.Color := clBlack
          Else
          Begin
            strAutPisCof := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,
                                      cxgArquivosAUTCOF.Index]);
            If fEmptyStr(strAutPisCof) Then
                ACanvas.Font.Color := clBlack;
          End;
        End;
        dirPasta.edtDirectory.text := fCfgSisL('XMLNFS')
      End;
  End;
end;

procedure TfrmEntImpNFSe.edtCodEveKeyPress(Sender: TObject;  var Key: Char);
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

procedure TfrmEntImpNFSe.edtCodPorKeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmEntImpNFSe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fAtuCfgSis('XMLNFS', dirPasta.edtDirectory.text);
  FreeAndNil(objImpNFSe);
end;

procedure TfrmEntImpNFSe.FormCreate(Sender: TObject);
begin
  inherited;
  objImpNFSe := TEntImpNFSe.Create(Self);
  lblMenConPag.Visible := fCfgSis('USACND', varBoolean);

  objImpNFSe.blnImpVariosXml := True;
  chkGravaFinanceiro.Checked := fCfgSis('NOCTFI', varBoolean);
end;

procedure TfrmEntImpNFSe.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = vkEscape) and (Not pnlTail.Enabled) And
     (fMensagem('','Deseja abandonar esta tarefa?', ['&SIM', '&NÃO'], 1) = 1) Then
  Begin
    pReiniciaProcesso(True);
  End;
  If Key = VK_F4 Then
    btnEditorLayout.Click;
  If Key = VK_F6 Then
    btnMarcaTodos.Click;
  If Key = VK_F7 Then
end;

procedure TfrmEntImpNFSe.FormShow(Sender: TObject);
begin
  inherited;

  mskDtaEnt.Text :=FormatDateTime('dd/mm/yyyy', fNow);

  pSetFocus(edtCodPor);
  Self.Caption := Self.Caption + ' - Entrada ';
  objImpNFSe.tpNFSe := tpNFSe;

  If (Not fCfgSis('UTIABR', varBoolean)) Then
  Begin
    cxgArquivosABRPIS.Visible := False;
    cxgArquivosABRCOF.Visible := False;
  End;
  dirPasta.edtDirectory.text := fCfgSisL('XMLNFS');
end;

procedure TfrmEntImpNFSe.fraPlanoDeContasPgaMskCodCtaKeyPress(
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

function TfrmEntImpNFSe.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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
         dirPasta.edtDirectory.text := fCfgSisL('XMLNFS')
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
          fAtuCfgSis('XMLNFS', dirPasta.edtDirectory.text);
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
      If chkGravaFinanceiro.Checked Then
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

          If Not Assigned(objImpNFSe) Then
          Begin
            Result := False;
          End Else
          Begin

            objImpNFSe.strCodOpe := strLoginUsuarioLogado;
            If chkGravaFinanceiro.Checked Then
            Begin
              objImpNFSe
                .fPorBai(edtCodPor.Text)
                .fCodEve(edtCodEve.Text)
                .fCodCta(fraPlanoDeContasPga.MskCodCta.Text)
                .fCndVaz(mskConPag.Text);
            end;
            objImpNFSe.fDtaEnt(StrToDate(mskDtaEnt.Text));

            pHabilitaForm(False);
            If objImpNFSe.fCarregaArquivos(dirPasta.edtDirectory.text, 'xml') Then
            Begin
              cxgArquivosView.DataController.DataSource := objImpNFSe.dtsTabela;
              dbmLOGIMP.DataSource := objImpNFSe.dtsTabela;
              objImpNFSe.fXmlToBanco(prgProgresso);
            End;
            pHabilitaForm(True);
            pReiniciaProcesso(False);
          End;

        End;

      End;
      If Result Then
        fAtuCfgSis('XMLNFS', dirPasta.edtDirectory.text);
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
        Else If (fRetTipoEvento(edtCodEve.Text)='R') And (tpNFSe = tpfEntrada) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End
        Else If (fRetTipoEvento(edtCodEve.Text)='P') And (tpNFSe = tpfSaida) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a pagar!',['&OK']);
          Result := False;
        End
      End
      Else
      Begin
        If (fCfgSis('CTPOBE', varBoolean)) And (tpNFSe = tpfEntrada) And chkGravaFinanceiro.Checked Then
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

procedure TfrmEntImpNFSe.pHabilitaForm(blnHabilita: Boolean);
begin
  //pnlTopo.Enabled     := blnHabilita;
  cxgArquivos.Enabled := blnHabilita;
  pnlBotoes.Enabled   := blnHabilita;
end;


procedure TfrmEntImpNFSe.pReiniciaProcesso(blnHabilita: boolean);
begin
  pnlTail.Enabled     := blnHabilita;
  chkGravaFinanceiro.Enabled := blnHabilita;

  edtCodPor.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  edtCodEve.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  fraPlanoDeContasPga.MskCodCta.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  mskConPag.Enabled := blnHabilita and chkGravaFinanceiro.Checked;
  mskDtaEnt.Enabled := blnHabilita;
  dirPasta.Enabled  := blnHabilita;

  If blnHabilita Then
  Begin
    edtCodPor.Clear;
    edtNomPor.Clear;
    edtCodEve.Clear;
    edtDesEve.Clear;
    fraPlanoDeContasPga.edtDesCta.Clear;
    fraPlanoDeContasPga.MskCodCta.Clear;
    mskDtaEnt.Clear;
    mskConPag.Clear;
    mskConPag.Enabled := False;
    dirPasta.edtDirectory.text := fCfgSisL('XMLNFS');
    If Assigned(objImpNFSe) Then
      objImpNFSe.qryTabela.EmptyDataSet;
    pSetFocus(edtCodPor);
  End;

  cxgArquivosCNDPAG.Options.Editing := chkGravaFinanceiro.Checked;
end;

function TfrmEntImpNFSe.fValidaCondPagamento(blnBuscaPorChave: Boolean): Boolean;
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


end.
