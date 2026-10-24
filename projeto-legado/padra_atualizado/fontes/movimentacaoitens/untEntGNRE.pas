unit untEntGNRE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, ComboBoxFocus, Mask, MaskEditFocus, QColorLabel,
  untGnre, Uni, BitBtnLockedIncrem, strUtils, frxClass,
  frxExportCSVTestabilidade, Vcl.ComCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxCheckBox, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, cxCurrencyEdit, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxContainer,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,  untZClient,
  cxDBLookupComboBox, Vcl.DBCtrls, untFrameCentroCustoEditFocus, untFechamentoFinanceiro,
  untFramePlanoDeContasMaskEdit, untFrameCtaPagar,ContaPagar.TFrameCtaPagar, untEntPagtoAntecipado;

type
  TfrmEntGNRE = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    pagGNRE: TPageControl;
    tabDados: TTabSheet;
    tabItens: TTabSheet;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensREFERE: TcxGridDBColumn;
    cxgItensUNIDAD: TcxGridDBColumn;
    cxgItensCODCST: TcxGridDBColumn;
    cxgItensCOMGNR: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    cxgItensVALGNR: TcxGridDBColumn;
    btnRateio: TBitBtnLocked;
    dtsTipoTributo: TDataSource;
    pnlDadosBancarios: TPanel;
    pnlFornecedor: TPanel;
    Label2: TLabel;
    ColorLabel2: TColorLabel;
    ColorLabel10: TColorLabel;
    edtInsEst: TEditFocus;
    cbxEstado: TComboBoxFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    pnlDadosApenasCTP: TPanel;
    ColorLabel1: TColorLabel;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    ColorLabel7: TColorLabel;
    mskDtaGnr: TMaskEditFocus;
    edtBcoGnr: TEditFocus;
    edtNumAge: TEditFocus;
    edtAutBan: TEditFocus;
    edtNomBan: TEditFocus;
    pnlBasCalGNRE: TPanel;
    lblBasCal: TColorLabel;
    edtBasCal: TEditFocus;
    pnlDadosGerais: TPanel;
    ColorLabel5: TColorLabel;
    ColorLabel6: TColorLabel;
    ColorLabel8: TColorLabel;
    ColorLabel9: TColorLabel;
    lblCodPor: TLabel;
    edtValGnr: TEditFocus;
    mskDtaVen: TMaskEditFocus;
    mskMesAno: TMaskEditFocus;
    edtConPro: TEditFocus;
    chkGnrFin: TCheckBox;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    cxgItensBASICM: TcxGridDBColumn;
    cxgItensALQICM: TcxGridDBColumn;
    cxgItensVALICM: TcxGridDBColumn;
    cxgItensIVA_ST: TcxGridDBColumn;
    cxgItensBASICMST: TcxGridDBColumn;
    cxgItensVALICMST: TcxGridDBColumn;
    fraCtaPagar: TfraCtaPagar;
    pnlEstado: TPanel;
    cxgItensAlqInt: TcxGridDBColumn;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    cxgItensViewCODFAB: TcxGridDBColumn;
    cxgItensVLRPRO: TcxGridDBColumn;
    cxgItensVLRCTE: TcxGridDBColumn;
    cxgItensPERBAS_ST: TcxGridDBColumn;
    cxgItensVALSTNF: TcxGridDBColumn;
    cxgItensVLRCALGNR: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxgItensVFCPST: TcxGridDBColumn;
    chkPagAnt: TCheckBox;
    btnPagAnt: TBitBtnLocked;
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtBcoGnrKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxEstadoChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxgItensCOMGNRPropertiesChange(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
   procedure cxgItensVALGNRPropertiesChange(Sender: TObject);
    procedure cxgItensViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxgItensViewKeyPress(Sender: TObject; var Key: Char);
    procedure btnRateioClick(Sender: TObject);
    procedure cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure tabDadosShow(Sender: TObject);
    procedure fraCtaPagar1edtCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraCtaPagarLcbTipoTributoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure fraCtaPagaredtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensViewDataControllerSummaryFooterSummaryItemsSummary(
      ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
      var OutArguments: TcxSummaryEventOutArguments);
    procedure btnPagAntClick(Sender: TObject);
    procedure chkPagAntClick(Sender: TObject);
  private
    { Private declarations }
    blnCTPAVI: Boolean;
    FTipoChamada : TTipoChamada;
    blnEhDARE: Boolean;
    cdsBackup: TZClient;
    objFrameCtaPagar: TFrameContaPagar;

    FDupSel: TStringlist;
    FValSel: Double;

    qryConCta : TUniQuery;
    objGnreValidaCampos: TGnre;
    qryTipoTributo: TUniQuery;
    objFechamentoFinanceiro: TFechamentoFinanceiro;
    Procedure pLimparTudo;
    procedure pCarregaCentroCusto;
    procedure pSetaEdit;
    function fVerificaTotalGNRE: boolean;
    procedure OpenQueryTipoTributo;
    procedure pSetTipoChamada(const Value: TTipoChamada);
    procedure pCalculaBaseGnre;
    procedure pMarcarTodos(strMarcar: Boolean = True);
    procedure pAjustaTelaPgoAntecipado;
    function VerificaPagtoAntecipado: boolean;

  public
    { Public declarations }
    objGnre: TGnre;
    blnEditando : Boolean;
    property TipoChamada : TTipoChamada read FTipoChamada write pSetTipoChamada;

  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fValidaDataVencimento: Boolean;
  end;

var
  frmEntGNRE: TfrmEntGNRE;

implementation

uses untPai, untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema,
  untMensagemExplicativa, Math, untCadPag;

{$R *.dfm}

procedure TfrmEntGNRE.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples,  Self, edtCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor,False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntGNRE.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;

  if fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodPor, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmEntGNRE.pCalculaBaseGnre;
var fltBasGnre: Double;
begin
  inherited;
  fltBasGnre := 0;
  If (objGnre.TipoChamada = tcGnreTributado) And (edtBasCal.Text <> '') and (StrToFloat(ReplaceStr(edtBasCal.Text, '.', '')) = 0)  Then
  Begin
    objGnre.cdsItens.First;
    while (not objGnre.cdsItens.Eof) Do
    Begin
      If objGnre.cdsItens.FieldByName('ENT_COMGNR').AsString = 'S' Then
        fltBasGnre :=  fltBasGnre + objGnre.cdsItens.FieldByname('BASCAL').AsFloat;
      objGnre.cdsItens.Next;
    End;
    edtBasCal.Text := FormatFloat('#0.00', fltBasGnre);
  End

end;

procedure TfrmEntGNRE.edtBcoGnrKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  if fPesqBanco(Self, edtBcoGnr, edtNomBan, nil, Key, arrSel) then
  Begin
    If fvalidaCampos(edtBcoGnr,False) Then
      self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntGNRE.fraCtaPagar1edtCodCtaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self,fraCtaPagar.edtCodCta,fraCtaPagar.edtNomCta, Nil, Key, arrCentroCusto) Then
    Begin
      If fValidaCampos(fraCtaPagar.edtCodCta,False) Then
        self.SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    If fPesqCentroCusto(Self,fraCtaPagar.edtCodCta,fraCtaPagar.edtNomCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text) Then
    Begin
      If fvalidaCampos(fraCtaPagar.edtCodCta,False) Then
        self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmEntGNRE.fraCtaPagaredtCodEveKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, fraCtaPagar.edtCodEve, fraCtaPagar.edtDesEve, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(fraCtaPagar.edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmEntGNRE.fraCtaPagarLcbTipoTributoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
  Begin
    If fValidaCampos(fraCtaPagar.LcbTipoTributo, True) Then
      PostMessage(HANDLE, WM_KEYDOWN, VK_TAB, 0);
  End;
end;

procedure TfrmEntGNRE.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Not fCfgSis('USACTF', varBoolean) Then
  Begin
    If fPesqCentroCusto(Self,fraCtaPagar.edtCodCta,fraCtaPagar.edtNomCta, Nil, Key, arrCentroCusto) Then
    Begin
      If fvalidaCampos(fraCtaPagar.edtCodCta,False) Then
        self.SelectNext(ActiveControl, True, True);
    End;
  End
  Else
  Begin
    If fPesqCentroCusto(Self,fraCtaPagar.edtCodCta,fraCtaPagar.edtNomCta, Nil, Key, arrCentroCusto, True, True, edtCodFor.Text) Then
    Begin
      If fvalidaCampos(fraCtaPagar.edtCodCta,False) Then
        self.SelectNext(ActiveControl, True, True);
    End;
  End;

end;

function TfrmEntGNRE.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  With objGnreValidaCampos Do
  Begin

    Try

      if Sender = cbxEstado Then
      Begin
        if cbxEstado.ItemIndex < 0 Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'Informe o Estado!', ['&OK']);

        End
        Else
        strEstFav := cbxEstado.Text;
      end
      Else

      If Sender = edtInsEst Then
      Begin
        If blnValidaIndividual And fEmptyStr(edtInsEst.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'Informe a Inscrição Estadual!', ['&OK']);
        End
        Else
          strI_E_S_ := edtInsEst.Text
      End

      Else If Sender = mskDtaGnr Then
      Begin
        if not fEmptyDate(mskDtaGnr.Text) Then
        Begin
          if StrToDateDef(mskDtaGnr.Text,0) <= 0 Then
          Begin
            mskDtaGnr.Clear;
            Result := False;
          End
          Else
          Begin
            //FECHAMENTO FINANCEIRO
            if (chkGnrFin.Checked) and objFechamentoFinanceiro.FechamentoFinanceiroJaRealizado(VS_StrCodEmp, StrToDate(mskDtaGnr.Text)) then
            begin
              Result := False;
            end
            else
            begin
              mskDtaGnr.Text := FormatDateTime('dd/mm/yyyy', StrToDate(mskDtaGnr.Text));
              strDtaGnr := mskDtaGnr.Text;
            end;
          End;

          Result := Result and fValidaDataVencimento;

        End;
      End

      Else If Sender = edtBcoGnr Then
      Begin
        strBcoGnr := edtBcoGnr.Text;
        edtNomBan.Text := strNomBan;
      End

      Else If Sender = edtNumAge Then
        strAgeGnr := edtNumAge.Text

      Else If Sender = edtAutBan Then
      Begin
        if blnValidaIndividual And fEmptyStr(edtAutBan.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Autenticação Bancária não foi Preenchida!', ['&OK']);
        End
        Else
          strAutBan := edtAutBan.Text
      End

      Else If Sender = edtValGnr Then
      Begin
        strValGnr := edtValGnr.Text;
        If (blnValidaIndividual) And (FTipoChamada = tcTS)And (fStrToFloat(edtValGnr.Text, 0) > 0) Then
        Begin
          objGnre.strValGnr := edtValGnr.Text;
          If fPergunta('Ratear valor entre os itens?') Then
            objGnre.fRateiaTS;
         
        End;
      End

      Else If Sender = mskDtaVen Then
      Begin

        If chkGnrFin.Checked And fEmptyDate(mskDtaVen.Text) Then
        Begin
          Result := False;
          pMensagemOk('Informe a data de vencimento!');
        End

        Else if not fEmptyDate(mskDtaVen.Text) Then
        Begin
          if StrToDateDef(mskDtaVen.Text,0) <= 0 Then
          Begin
            mskDtaVen.Clear;
            Result := False;
          End
          Else
          Begin
            mskDtaVen.Text := FormatDateTime('dd/mm/yyyy', StrToDate( mskDtaVen.Text));
            strDtaVen := mskDtaVen.Text;
          End;
        End;

        Result :=  Result and fValidaDataVencimento;

        If Result Then
        Begin
          if objPortadorFornecedor.fTravaPortador then
          begin
            edtCodPor.Enabled := False;
            edtCodPor.Text := objPortadorFornecedor.strCodPor;
            edtNomPor.Text := objPortadorFornecedor.strNomPor;
          end
          else
          begin
            If (blnCTPAVI And (StrToDateDef(mskDtaVen.Text,0) = VS_Date)) And fEmptyStr(edtCodPor.Text) Then
            Begin
               pMensagemOk('Informe o portador!');
               Result := False;
            End;

            If Not edtCodPor.Enabled Then
            Begin
              edtCodPor.Clear;
              edtNomPor.Clear;
            End
            else if fEmptyStr(edtCodPor.Text) And (Not fEmptyStr(objPortadorFornecedor.strCodPor)) then
            begin
              edtCodPor.Text := objPortadorFornecedor.strCodPor;
              edtNomPor.Text := objPortadorFornecedor.strNomPor;
            end;

          end;

        end;


      End

      Else If Sender = edtCodPor Then
      Begin


        if objPortadorFornecedor.fTravaPortador then
        begin
          edtCodPor.Enabled := False;
          edtCodPor.Text := objPortadorFornecedor.strCodPor;
          edtNomPor.Text := objPortadorFornecedor.strNomPor;
        end
        else
        begin
         if fEmptyStr(edtCodPor.Text) And Not fEmptyStr(objPortadorFornecedor.strCodPor) then
          begin
            edtCodPor.Text := objPortadorFornecedor.strCodPor;
            edtNomPor.Text := objPortadorFornecedor.strNomPor;
          end;

        end;

        If edtCodPor.Enabled Then
        Begin
          If fEmptyStr(edtCodPor.Text) And (blnCTPAVI And (StrToDateDef(mskDtaVen.Text,0) = VS_Date)) Then
          Begin
            Result := False;
            pMensagemOk('Para vencimentos na data de hoje (documento baixado) é necessário informar o portador!');
          End
          Else If (Not fEmptyStr(edtCodPor.Text)) Then
          Begin
            edtNomPor.Text := fRetNomPortador(edtCodPor.Text);

            If fEmptyStr(edtNomPor.Text) Then
            Begin
              Result := False;
              pMensagemOk('Código do portador não encontrado!');
            End
            {*REQ*145940**********RP*}
            Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
              Result := False;
            End;

          End
          Else
          Begin
            edtNomPor.Clear;
            edtCodPor.Clear;
          End;

        End;

      End

      Else If Sender = mskMesAno Then
      Begin
        if not fEmptyDate(mskMesAno.Text) Then
        Begin
          if StrToDateDef('01/' + mskMesAno.Text,0) <= 0 Then
          Begin
            mskMesAno.Clear;
            Result := False;
          End
          Else
          Begin
            mskMesAno.Text := FormatDateTime('mm/yyyy', StrToDate( '01/' + mskMesAno.Text));
            strMesAno := mskMesAno.Text;
          End;
        End;  
      End
      Else If Sender = edtConPro Then
        strConPro := edtConPro.Text

      Else If Sender = edtCodFor Then
      Begin
        If (Not fEmptyStr(edtCodFor.Text)) And (edtCodFor.Text = objGnre.strForDoc) Then
        Begin
          fMensagem('','Fornecedor da GNRE não pode ser o mesmo fornecedor do documento! O Fornecedor da GNRE deve ser um Órgão Público!!', ['&O K']);
          Result := False;
        End
        Else
        Begin
          If (strCodFor <> edtCodFor.Text) Then
          Begin
            btnPagAnt.Enabled := False;
            chkPagAnt.Checked := False;
            If (objGnre.objPgoAntecipadoGnre <> Nil) Then
              objGnre.objPgoAntecipadoGnre := TEntPagtoAntecipado.Create;
          End;
          strCodFor := edtCodFor.Text;

          edtNomFor.Text := strNomFor;

          cbxEstado.ItemIndex := cbxEstado.Items.IndexOf(strEstFav);
          edtInsEst.Text      := strI_E_S_;

          if objPortadorFornecedor.fTravaPortador then
          begin
            edtCodPor.Enabled := False;
            edtCodPor.Text := objPortadorFornecedor.strCodPor;
            edtNomPor.Text := objPortadorFornecedor.strNomPor;
          end
          else
          begin
            If blnValidaIndividual And (Not fEmptyStr(objPortadorFornecedor.strCodPor))  then
            begin
              edtCodPor.Text := objPortadorFornecedor.strCodPor;
              edtNomPor.Text := objPortadorFornecedor.strNomPor;
            end;

          end;
          objFrameCtaPagar.strCodigo_Fornecedor := edtCodFor.Text;
          objFrameCtaPagar.pCarregaDadosBancariosFornecedor;

          If (Not fEmptyStr(edtCodFor.Text)) Then
          Begin
            objGnre.objPgoAntecipadoGnre.pSetaFornecedor(edtCodFor.Text);

            chkPagAnt.Enabled := objGnre.objPgoAntecipadoGnre.fFornecedorTemPagamentoAntecipado(edtCodFor.Text);

            If (Not chkPagAnt.Enabled) Then
            Begin
              btnPagAnt.Enabled := False;
              chkPagAnt.Checked := False;
            End;
          End;
        End;
      End

      Else If Sender =fraCtaPagar.edtCodCta Then
      Begin
        If  fCfgSis('USACTF', varBoolean) Then
        Begin
          pCarregaCentroCusto;

          If fEmptyStr(fraCtaPagar.edtNomCta.Text) Then
          Begin
            fMensagem('','Este Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O K']);
            Result := False;
          End
          Else
          Begin
            if PlanoDeContasAtivo(fraCtaPagar.edtCodCta.Text,True) then
            Begin
              strCodCta :=fraCtaPagar.edtCodCta.Text;
              fraCtaPagar.edtNomCta.Text := strDesCta;
            End;
          End;
        End
        Else
        Begin
          strCodCta :=fraCtaPagar.edtCodCta.Text;
          fraCtaPagar.edtNomCta.Text := strDesCta;
        End;
      End

      Else If Sender =fraCtaPagar.edtCodEve Then
      Begin

        If fEmptyStr(fraCtaPagar.edtCodEve.Text) Then
        Begin
          If (fCfgSis('CTPOBE', varBoolean)) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
            Result := False;
          End;
          fraCtaPagar.edtDesEve.Clear;
        End Else
        Begin
          fraCtaPagar.edtDesEve.Text := fRetNomEvento(fraCtaPagar.edtCodEve);

          If fEmptyStr(fraCtaPagar.edtDesEve.Text) Then
          Begin
            pMensagemOk('Centro de Custos não encontrado!');
            Result := False;
          End;
        End;

      End

      Else
      If (Sender = fraCtaPagar.LcbGuiaTributo) And (fraCtaPagar.LcbGuiaTributo.Visible) Then
      Begin
        strTipGui := fraCtaPagar.LcbGuiaTributo.Text;
      End
      Else

      If (Sender = fraCtaPagar.LcbTipoTributo) and fraCtaPagar.LcbTipoTributo.Visible Then
      Begin
        strCodRec := fraCtaPagar.LcbTipoTributo.Text;
      End

      Else
      If (Sender = edtBasCal) Then
      Begin
        strBasCal := ReplaceStr(edtBasCal.Text, '.', '');
      End;

      blnGraFin := chkGnrFin.Checked;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagemOk(E.Message);
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmEntGNRE.fValidaDataVencimento: Boolean;
begin
  Result := True;
  If (Not fEmptyDate(mskDtaGnr.Text)) And (Not fEmptyDate(mskDtaVen.Text)) Then
     Result := (StrToDate(mskDtaGnr.Text) <= StrToDate(mskDtaVen.Text));
  If not Result Then
    fMensagem('Atenção', 'A Data de Vencimento deve ser maior ou igual a Data da Guia.', ['&OK'])
end;

function TfrmEntGNRE.fVerificaTotalGNRE: boolean;
  var
    strMensagem: String;
begin

  Result := RoundTo(fStrToFloat(edtValGnr.Text), -2) > 0 ;
  Result := Result And (RoundTo(IfNull(cxgItensView.DataController.Summary.FooterSummaryValues[0], 0), -2) = RoundTo(fStrToFloat(edtValGnr.Text), -2));

  If Not Result Then
  Begin
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    try
      frmMensagemExplicativa.mmoInstru.Lines.Add('ATENÇÃO!');
      frmMensagemExplicativa.mmoInstru.Lines.Add('A SOMATÓRIA DO VALOR DA GNRE POR PRODUTO DEVE SER IGUAL AO VALOR RECOLHIDO INFORMADO');
      frmMensagemExplicativa.mmoInstru.Lines.Add('NA ABA 1 - INFORMAÇÕES DA GNRE. SERÁ PRECISO ACERTAR OS VALORES ANTES DE CONTINUAR.');
      frmMensagemExplicativa.mmoInstru.Lines.Add('');
      frmMensagemExplicativa.mmoInstru.Lines.Add('    TOTALIZADOR DO VALOR DA GNRE POR PRODUTO: ' + cxgItensView.DataController.Summary.FooterSummaryTexts[0]);
      frmMensagemExplicativa.mmoInstru.Lines.Add('                             VALOR RECOLHIDO: ' + edtValGnr.Text);
      frmMensagemExplicativa.mmoInstru.Lines.Add(strMensagem);

      frmMensagemExplicativa.mmoInstru.Lines.Text := fTrocaNomeGNRE(blnEhDARE, frmMensagemExplicativa.mmoInstru.Lines.Text);

      frmMensagemExplicativa.Showmodal;
    Finally
      FreeAndNil(frmMensagemExplicativa);
    End;
  End;
end;

procedure TfrmEntGNRE.pCarregaCentroCusto;
begin
  qryConCta := fCriaQuery;

  pPesquisaCadCta(qryConCta, qryConCta,fraCtaPagar.edtCodCta.Text, True, edtCodFor.Text);

  With qryConCta Do
  Begin
   fraCtaPagar.edtNomCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;

  If fEmptyStr(fraCtaPagar.edtNomCta.Text) Then
   fraCtaPagar.edtCodCta.Clear;

  FreeAndNil(qryConCta);
end;

Procedure TfrmEntGNRE.pLimparTudo;
Begin
  cbxEstado.ItemIndex := -1;
  edtInsEst.Clear;
  mskDtaGnr.Clear;
  edtBcoGnr.Clear;
  edtNomBan.Clear;
  edtNumAge.Clear;
  edtAutBan.Clear;
  edtValGnr.Clear;
  mskDtaVen.Clear;
  mskMesAno.Clear;
  edtConPro.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
 fraCtaPagar.edtCodCta.Clear;
 fraCtaPagar.edtNomCta.Clear;

 fraCtaPagar.edtCodEve.Clear;
  fraCtaPagar.edtDesEve.Clear;

  edtCodPor.Clear;
  edtNomPor.Clear;

  edtBasCal.Clear;
  fraCtaPagar.LcbTipoTributo.KeyValue := -1;

  chkGnrFin.Checked := True;

  objGnreValidaCampos.pLimparTudo;
End;

procedure TfrmEntGNRE.btnGravarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    fValidaCampos(fraCtaPagar.LcbTipoTributo, True);

    If Not (FTipoChamada in [tcTCIF, tcTS]) Then
    Begin
      If Not objGnre.fTemItensSelecionados Then
      Begin
        pagGNRE.ActivePage := tabItens;
        Exit;
      End;
    End;

    If Not fVerificaTotalGNRE Then
       Exit;

    If Not VerificaPagtoAntecipado Then
       Exit;

    With objGnre Do
    Begin
      strEstFav := cbxEstado.Text;
      strI_E_S_ := edtInsEst.Text;
      strDtaGnr := mskDtaGnr.Text;
      strBcoGnr := edtBcoGnr.Text;
      strAgeGnr := edtNumAge.Text;
      strAutBan := edtAutBan.Text;
      objGnre.strValGnr := edtValGnr.Text;
      strDtaVen := mskDtaVen.Text;
      strMesAno := mskMesAno.Text;
      strConPro := edtConPro.Text;
      strCodFor := edtCodFor.Text;
      strCodCta :=fraCtaPagar.edtCodCta.Text;
      strCodEve :=fraCtaPagar.edtCodEve.Text;
      strCodPor := edtCodPor.Text;
      blnGraFin := chkGnrFin.Checked;
      strTipGui := fraCtaPagar.LcbGuiaTributo.Text;
      strGuiTri := IIF((fraCtaPagar.LcbGuiaTributo.KeyValue = Null),' ',fraCtaPagar.LcbGuiaTributo.KeyValue);
      strCodRec := fraCtaPagar.LcbTipoTributo.Text;
      strBasCal := edtBasCal.Text;

      strVeiBol := fraCtaPagar.edtVeiobo.Text;
      strVeioNF := fraCtaPagar.edtVeioNf.Text;
      strUsaCHQ := fraCtaPagar.edtUsaChq.Text;
      strDeposi := fraCtaPagar.edtDeposi.Text;
      strPrevis := fraCtaPagar.edtPrevis.Text;
      strPagAnt := fraCtaPagar.edtPagAnt.Text;
      strUsoCon := fraCtaPagar.edtUsoCon.Text;
      strTipDoc := fraCtaPagar.edtTipDoc.Text;
      strCompet := fraCtaPagar.edtCompet.Text;
      strBcoFor := IIF(fEmptyStr(fraCtaPagar.strBcoFor),strBcoFor,fraCtaPagar.strBcoFor);
      strHist01 := fraCtaPagar.MemHisto.Text;
    End;

    ModalResult := mrOk;
  end;

end;

procedure TfrmEntGNRE.btnRateioClick(Sender: TObject);
begin
  If Not btnRateio.Visible Then
    Exit;

  objGnre.strValGnr := edtValGnr.Text;
  If objGnre.strValGnr = '' Then
     fMensagem('ATENÇÃO', 'Este processo só poderá ser executado após informar o campo Valor Recolhido.', ['&OK']);

  If fMensagem('ATENÇÃO', fTrocaNomeGNRE(blnEhDARE, 'Este processo irá zerar todos os valores existentes no campo Valor GNRE, e irá ratear o Valor Recolhido.' +
                          'Deseja executar?'), ['&Sim', '&Não'], 2) =  1 Then
     objGnre.fRateiaGnre;
end;

procedure TfrmEntGNRE.OpenQueryTipoTributo;
begin
  qryTipoTributo.Close;
  qryTipoTributo.SQL.Clear;
  qryTipoTributo.SQL.Add('SELECT G.GUI_CODGUI, G.GUI_DESCRI, T.TRI_CODTRI, T.TRI_CODGUI, T.TRI_DESCRI ');
  qryTipoTributo.SQL.Add('FROM TIPTRI T ');
  qryTipoTributo.SQL.Add('LEFT JOIN GUITRI G ON G.GUI_CODGUI = T.TRI_CODGUI ');
  qryTipoTributo.SQL.Add('WHERE G.GUI_CODGUI IN (7,4,5,6)');
  qryTipoTributo.Open;
end;

procedure TfrmEntGNRE.cbxEstadoChange(Sender: TObject);
begin
  inherited;
  fValidaCampos(cbxEstado, True);
end;

procedure TfrmEntGNRE.chkPagAntClick(Sender: TObject);
begin
  inherited;
  pAjustaTelaPgoAntecipado;
end;

procedure TfrmEntGNRE.cxgItensCOMGNRPropertiesChange(Sender: TObject);
begin
  inherited;

  With objGnre.cdsItens Do
  If State = dsEdit Then
  Begin
    If FieldByName('ENT_GNRFIX').AsString = 'S' Then
      FieldByName('ENT_COMGNR').AsString := 'S';

    Post;
  End;
end;

procedure TfrmEntGNRE.cxgItensVALGNRPropertiesChange(Sender: TObject);
begin
  inherited;
  If FTipoChamada in [tcTCIF, tcTS] Then
    Exit;
  If (objGnre.cdsItens.State = dsEdit) And
     (objGnre.cdsItens.FieldByName('ENT_COMGNR').AsString <> 'S') Then
    objGnre.cdsItens.FieldByName('ENT_VALGNR').AsFloat := 0
end;

procedure TfrmEntGNRE.cxgItensViewDataControllerSummaryFooterSummaryItemsSummary(
  ASender: TcxDataSummaryItems; Arguments: TcxSummaryEventArguments;
  var OutArguments: TcxSummaryEventOutArguments);
var
  strMarcado: String;
begin
  inherited;
  strMarcado := cxgItensView.DataController.Values[Arguments.RecordIndex, cxgItensCOMGNR.Index];

  OutArguments.Done := strMarcado = 'N';
end;

procedure TfrmEntGNRE.cxgItensViewEditKeyPress(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  if Key = '-' then
     Key := #0;
end;

procedure TfrmEntGNRE.cxgItensViewKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = '-' then
     Key := #0;
end;

procedure TfrmEntGNRE.cxgItensViewTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  If Not blnEditando Then
  Begin
    edtValGnr.Text := AText;
    If FTipoChamada in [tcTCIF, tcTS] Then
      edtBasCal.Text := AText;
  End;
end;

procedure TfrmEntGNRE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If Not (ModalResult = mrOk) Then
    objGnre.cdsItens.Data := cdsBackup.Data;

  If Assigned(objFrameCtaPagar) Then
    FreeAndNil(objFrameCtaPagar);

  inherited;

end;

procedure TfrmEntGNRE.FormCreate(Sender: TObject);
begin
  inherited;
  objGnreValidaCampos := TGNRE.Create(Self);

  cdsBackup := TZClient.Create(Self);

  FDupSel :=  TStringList.Create;
  FValSel := 0;

  blnCTPAVI := fCfgSis('CTPAVI', varBoolean);
  btnRateio.Visible := fCfgSis('GNRRAT') = 1;
  qryTipoTributo := fCriaQuery(Self);
  OpenQueryTipoTributo;
  dtsTipoTributo.DataSet := qryTipoTributo;
  objFrameCtaPagar:= TFrameContaPagar.Create;
  fraCtaPagar.objFrameCtaPagar := objFrameCtaPagar;
  cxgItensVFCPST.Visible := fCfgSis('IFCPST', varBoolean);
end;

procedure TfrmEntGNRE.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objGnreValidaCampos);
  FreeAndNil(cdsBackup);
  FreeAndNil(FDupSel);
end;

procedure TfrmEntGNRE.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F4: btnMarcarTodos.Click;
    VK_F5: btnDesmarcarTodos.Click;
  end;
end;

procedure TfrmEntGNRE.pMarcarTodos(strMarcar: Boolean = True);
Begin
  TrueBoolStrs := ['S'];
  FalseBoolStrs := ['N'];
  objGnre.cdsItens.DisableControls;
  objGnre.cdsItens.First;
  while Not objGnre.cdsItens.Eof do
  Begin
    objGnre.cdsItens.Edit;
    objGnre.cdsItens.FieldByName('ENT_COMGNR').AsString := BoolToStr(strMarcar, true);

    If objGnre.cdsItens.FieldByName('ENT_GNRFIX').AsString = 'S' Then
      objGnre.cdsItens.FieldByName('ENT_COMGNR').AsString := 'S';

    objGnre.cdsItens.Post;
    objGnre.cdsItens.Next;
  End;
  objGnre.cdsItens.EnableControls;
End;

procedure TfrmEntGNRE.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos;
end;

procedure TfrmEntGNRE.btnPagAntClick(Sender: TObject);
begin  
  chkPagAnt.Checked := objGnre.objPgoAntecipadoGnre.fSelecionaDuplicatas(fStrToFloat(edtValGnr.Text), 0, False);
end;

procedure TfrmEntGNRE.pAjustaTelaPgoAntecipado;
begin
  If chkPagAnt.Checked Then
  Begin
    btnPagAnt.Enabled := True;
  End
  Else
  Begin
    btnPagAnt.Enabled := False;
  End;
end;

procedure TfrmEntGNRE.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos(False);
end;

procedure TfrmEntGNRE.btnExcluirClick(Sender: TObject);
begin
  inherited;

  pLimparTudo;
  pagGNRE.ActivePageIndex := 0;
end;

procedure TfrmEntGNRE.pSetaEdit;
  Var
    intIndex : Integer;
Begin
  For intIndex := 0 To frmEntGNRE.ComponentCount -1 Do
  Begin
    if (Pos(frmEntGNRE.Components[intIndex].ClassName, 'TComboBoxFocus_TEditFocus_TMaskEditFocus_TCheckBox_TcxLookupComboBox') > 0 ) And
       (frmEntGNRE.Components[intIndex].Name <> edtAutBan.Name) Then
      TControl(frmEntGNRE.Components[intIndex]).Enabled := False;

  End;

End;

procedure TfrmEntGNRE.pSetTipoChamada(const Value: TTipoChamada);
begin
  FTipoChamada := Value;
  case FTipoChamada of
    tcTCIF,
    tcTS:  Begin
             cxgItensCODCST.Visible     := False;
             cxgItensCOMGNR.Visible     := False;
             fraCtaPagar.edtTipDoc.Enabled := False;
             pnlBasCalGNRE.Visible      := False;
             btnRateio.Visible          := False;
             If FTipoChamada = tcTCIF Then
             begin
               tabDados.Caption := '&1 - Informações da TCIF';
               tabItens.Caption := '&2 - Itens que terão TCIF';
               cxgItensVALGNR. Caption := 'Valor TCIF';
               cxgItensVALGNR.DataBinding.FieldName := 'ENT_VLTCIF';
               TCxGridDbTableSummaryItem(cxgItensView.DataController.Summary.FooterSummaryItems.Items[0]).FieldName := 'ENT_VLTCIF';
               Self.Caption  := 'TCIF';
             End
             Else
             Begin
               tabDados.Caption := '&1 - Informações da TS';
               tabItens.Caption := '&2 - Itens que terão TS';
               cxgItensVALGNR.Caption := 'Valor TS';
               cxgItensVALGNR.DataBinding.FieldName := 'ENT_VAL_TS';
               TCxGridDbTableSummaryItem(cxgItensView.DataController.Summary.FooterSummaryItems.Items[0]).FieldName := 'ENT_VAL_TS';
               Self.Caption  := 'TS';
             End;
           End;
  end;
end;

procedure TfrmEntGNRE.tabDadosShow(Sender: TObject);
begin
  pCalculaBaseGnre;
end;

function TfrmEntGNRE.VerificaPagtoAntecipado: boolean;
begin
  If (objGnre.objPgoAntecipadoGnre.fltTotSel = 0) And (chkPagAnt.Checked) Then
  Begin
    fMensagem('Atenção', 'Nenhuma duplicata com Pagamento Antecipado selecionada!', ['&OK']);
    Result := False;
  End
  Else
    Result := True;
end;

procedure TfrmEntGNRE.FormShow(Sender: TObject);
var
  strGIAINT : string;
  strGIAPRO : string;
begin
  inherited;
  If Not fCfgSis('AJUGIA', varBoolean) Then
  begin
    cxgItensBASICM.Visible := False;
    cxgItensALQICM.Visible := False;
    cxgItensVALICM.Visible := False;
    cxgItensIVA_ST.Visible := False;
    cxgItensBASICMST.Visible := False;
    cxgItensVALICMST.Visible := False;
    cxgItensALQINT.Visible := False;

  End
  Else
  Begin
    strGIAINT := fCfgSis('GIAINT');
    strGIAPRO := fCfgSis('GIAPRO');

    If (strGIAINT = '') Or (strGIAPRO = '') Then
    Begin
      pMensagemOk('Quando a configuração "CFG_AJUGIA" PORTARIA CAT 54/2020 - GERAR AJUSTES SOBRE GNRE PARA SPED/GIA EFD, CONFORME PORTARIA CAT 54/2020 ' +
                             ' estiver ativa é preciso definir os ajuste nas configurações "CFG_GIAINT" e "CFG_GIAPRO"');
    End;
  End;

  pagGNRE.ActivePageIndex := 0;
  With objGnre Do
  Begin
    objGnreValidaCampos.objPortadorFornecedor.blnUtilizaTrava := objGnre.objPortadorFornecedor.blnUtilizaTrava;
    cbxEstado.ItemIndex := cbxEstado.Items.IndexOf(strEstFav);

    if not fEmptyStr(cbxEstado.Text) Then
      fValidaCampos(cbxEstado, False);

    edtInsEst.Text      := strI_E_S_;
    mskDtaGnr.Text      := strDtaGnr;
    edtBcoGnr.Text      := strBcoGnr;
    edtNomBan.Text      := strNomBan;
    edtNumAge.Text      := strAgeGnr;
    edtAutBan.Text      := strAutBan;

    edtValGnr.Text      := strValGnr;
    If fEmptyStr(edtValGnr.Text) Then
      edtValGnr.Text := '0,00';

    mskDtaVen.Text      := strDtaVen;
    if not fEmptyDate(mskDtaVen.Text) then
      fValidaCampos(mskDtaVen, true);

    mskMesAno.Text      := strMesAno;
    edtConPro.Text      := strConPro;
    edtCodFor.Text      := strCodFor;
    // Carrega dados bancarios do fornecedor
    objFrameCtaPagar.strCodigo_Fornecedor := edtCodFor.Text;
    objFrameCtaPagar.pCarregaDadosBancariosFornecedor;
    objFrameCtaPagar.pPosicionaContaFornecedor(strBcoFor);

    edtNomFor.Text      := strNomFor;
   fraCtaPagar.edtCodCta.Text := fTiraCaracEspeciais(strCodCta);
   fraCtaPagar.edtNomCta.Text := strDesCta;

   fraCtaPagar.edtCodEve.Text := strCodEve;
   fraCtaPagar.edtDesEve.Text := fRetNomEvento(fraCtaPagar.edtCodEve.Text);

    edtCodPor.Text      := strCodPor;
    edtNomPor.Text      := fRetNomPortador(edtCodPor.Text);

    chkGnrFin.Checked   := blnGraFin;

   { if (strTipGui = 'GNRE') Or fEmptyStr(strTipGui) Then
      fraCtaPagar.LcbGuiaTributo.ItemIndex := 0
    Else
      fraCtaPagar.LcbGuiaTributo.ItemIndex := 1; }

    edtBasCal.Text      := strBasCal;
    If fEmptyStr(edtBasCal.Text) Then
      edtBasCal.Text := '0,00';

    cxgItensView.DataController.DataSource := cdsItens.dtsSource;
    cdsBackup.Data := cdsItens.Data;
    btnRateio.Visible := ((btnRateio.Visible) And  (IIf(fCfgSis('VALELE', varBoolean), (Not objGnre.FblnComNFE), True)));

    fraCtaPagar.edtVeiobo.Text := IIF(fEmptyStr(strVeiBol),fraCtaPagar.edtVeiobo.Text,strVeiBol);
    fraCtaPagar.edtVeioNf.Text := IIF(fEmptyStr(strVeioNF),fraCtaPagar.edtVeioNf.Text,strVeioNF);
    fraCtaPagar.edtUsaChq.Text := IIF(fEmptyStr(strUsaCHQ),fraCtaPagar.edtUsaChq.Text,strUsaCHQ);
    fraCtaPagar.edtDeposi.Text := IIF(fEmptyStr(strDeposi),fraCtaPagar.edtDeposi.Text,strDeposi);
    fraCtaPagar.edtPrevis.Text := IIF(fEmptyStr(strPrevis),fraCtaPagar.edtPrevis.Text,strPrevis);
    fraCtaPagar.edtPagAnt.Text := IIF(fEmptyStr(strPagAnt),fraCtaPagar.edtPagAnt.Text,strPagAnt);
    fraCtaPagar.edtUsoCon.Text := IIF(fEmptyStr(strUsoCon),fraCtaPagar.edtUsoCon.Text,strUsoCon);
    fraCtaPagar.edtTipDoc.Text := IIF(fEmptyStr(strTipDoc),'2',strTipDoc);
    objFrameCtaPagar.pValidaGuiaTributo;
    fraCtaPagar.edtCompet.Text := IIF(fEmptyStr(strCompet),fraCtaPagar.edtCompet.Text,strCompet);
    fraCtaPagar.MemHisto.Text  := IIF(fEmptyStr(strHist01),fraCtaPagar.MemHisto.Text,strHist01);

  End;

  if blnEditando Then
  Begin
    btnExcluir.Visible := False;
    pSetaEdit;
    pSetFocus(edtAutBan);
  End
  Else
    pSetFocus(edtCodFor);

  blnEhDARE := fEhEmpresaDARE;

  SElf.Caption := fTrocaNomeGNRE(blnEhDARE, SElf.Caption);
 // fraCtaPagar.LcbGuiaTributo.itemIndex := fTrocaNomeGNRE(blnEhDARE, fraCtaPagar.LcbGuiaTributo.Text);
 If blnEhDARE Then
    fraCtaPagar.objFrameCtaPagar.pCarregaGuiasETributos(False,'7_4_5_6',blnEhDARE);

  tabDados.Caption := fTrocaNomeGNRE(blnEhDARE, tabDados.Caption);
  tabItens.Caption := fTrocaNomeGNRE(blnEhDARE, tabItens.Caption);
  pCalculaBaseGnre;

  cxgItensView.ApplyBestFit;
end;

end.

