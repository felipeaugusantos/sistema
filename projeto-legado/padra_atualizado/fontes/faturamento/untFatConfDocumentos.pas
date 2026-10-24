
{***************************}
{* qryConCli -> CADCLI     *}
{************************JB*}

unit untFatConfDocumentos;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus,
  Grids, DBGridCitel, DBGrids, Menus, ComCtrls, Buttons, ExtCtrls, DB, System.UITypes,
  StrUtils, Uni, AppEvnts, UniClientDataSet, UniDataSetProvider, DBCtrls,
  BitBtnLockedIncrem, untConfDocs, frxClass, frxExportCSVTestabilidade,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, untLiberacao, ComboBoxFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxSplitter;

type
  TfrmFatConfDocumentos = class(TfrmPaiSimples)
    pnlAux2: TPanel;
    dbgDocumentos: TDBGridCitel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    btnItensDoc: TBitBtnLocked;
    btnSairConf: TBitBtnLocked;
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label17: TLabel;
    edtQtdDoc: TEditFocus;
    edtTotGer: TEditFocus;
    edtDupPag: TEditFocus;
    edtTotLiq: TEditFocus;
    edtQtdDocSel: TEditFocus;
    edtTotGerSel: TEditFocus;
    edtDupPagSel: TEditFocus;
    edtTotLiqSel: TEditFocus;
    edtNomCli: TEditFocus;
    Label2: TLabel;
    edtCliFat: TEditFocus;
    edtNomCliFat: TEditFocus;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label5: TLabel;
    Shape2: TShape;
    Label8: TLabel;
    Shape3: TShape;
    Label10: TLabel;
    Shape4: TShape;
    Label13: TLabel;
    Label15: TLabel;
    mskDtaIni: TMaskEditFocus;
    Label18: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    Label19: TLabel;
    Label20: TLabel;
    mskDtaFin: TMaskEditFocus;
    prbProgresso: TProgressBar;
    Label21: TLabel;
    edtDesSujSel: TEditFocus;
    Label22: TLabel;
    edtJurSujSel: TEditFocus;
    Label23: TLabel;
    edtDesSuj: TEditFocus;
    Label24: TLabel;
    edtJurSuj: TEditFocus;
    lblCliSeg: TLabel;
    edtCliSeg: TEditFocus;
    pnlCliSeg: TPanel;
    Label25: TLabel;
    dbeCliSeg: TDBEdit;
    btnConfirma: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnMarca: TBitBtnLocked;
    Label26: TLabel;
    Shape5: TShape;
    btnDupPagas: TBitBtnLocked;
    btnPopMenuMarca: TBitBtnLocked;
    btnPopMenuDesMarca: TBitBtnLocked;
    popMarca: TPopupMenu;
    popEnt: TMenuItem;
    popRet: TMenuItem;
    shpNaoSint: TShape;
    lblNaoSint: TLabel;
    HintControler: TcxHintStyleController;
    HintAlerta: TcxHintStyleController;
    TimerAlerta: TTimer;
    btnBaiDoc: TBitBtnLocked;
    FlwPnlBotoesBaixa: TFlowPanel;
    shpFFBol: TShape;
    lblFFBol: TLabel;
    lblEnderecoEntrega: TLabel;
    cmbClienteEnderecos: TComboBoxFocus;
    lblSituacaoFinanceira: TLabel;
    cmbSituacaoFinanceira: TComboBoxFocus;
    btnCancelarBaixaDocumento: TBitBtnLocked;
    Shape6: TShape;
    Label27: TLabel;
    chkEditaEmail: TCheckBox;
    pnlMsg: TPanel;
    lblMensagem: TLabel;
    splMsg: TcxSplitter;
    dbeMen001: TDBEdit;
    dbeMen002: TDBEdit;
    gbTipoOper: TGroupBox;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    procedure btnSairConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensDocClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCliFatKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtEspDocEnter(Sender: TObject);
    procedure btnMarcaClick(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure btnDupPagasClick(Sender: TObject);
    procedure btnPopMenuMarcaClick(Sender: TObject);
    procedure btnPopMenuDesMarcaClick(Sender: TObject);
    procedure popEntClick(Sender: TObject);
    procedure popRetClick(Sender: TObject);
    procedure dbgDocumentosMouseLeave(Sender: TObject);
    procedure dbgDocumentosMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimerAlertaTimer(Sender: TObject);
    procedure pnlCabecalhoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBaiDocClick(Sender: TObject);
    procedure cmbClienteEnderecosSelect(Sender: TObject);
    procedure btnCancelarBaixaDocumentoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure OnGetTextVLRCON(Sender: TField; var Text: String; DisplayText: Boolean);
    procedure splMsgAfterClose(Sender: TObject);
    procedure splMsgAfterOpen(Sender: TObject);
  private
    { Private declarations }
    blnFecharForm  : Boolean;
    qryCliFat      : TUniQuery;
    qryConCli      : TUniQuery;
    dtsQryTmp      : TDataSource;
    intRecAtu      : Integer;
    strOrgPub      : String;
    strCliFat      : String;

    procedure pMostraAlertaSintetizacao(edt: TEditFocus; strMsg: String);
    procedure pMostraCliSeg;
    procedure pCriaTemporaria;
    procedure pCarregaCliente;
    function  fCarregaNovoCliente: Boolean;

    procedure pAtualizaDados(DataSet: TDataSet);

    procedure pMarcaDocumento(blnMarcar: Boolean);

    procedure pAtualizaTotais;

    Function fFiltroFoiAlterado: Boolean;
    function fVerificaTrocaCliente: Boolean;

   procedure pMarcarDesmarcarTudo(strOpc, strEntRet: String);

   procedure pConfirmar(blnApenasBaixarDocumentos: Boolean = False);

   procedure pCarregarEnderecosEntrega;
   procedure pAjustarFiltrosNoFormulario;

   function fVerificaClienteInativo: Boolean;
   function fValidarTransportadoraDocsSelecionados: Boolean;
   procedure pHintSplitters(splSplitter: TcxSplitter; blnFechado: Boolean);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnBaixouDocumentos: Boolean;
    objConfDocs: TConfirmacaoDocumentos;
    objLiberacao : TLiberacao;
  end;


implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untFuncoesRel, untFuncoesRel2,
  untTypesSistema, untFuncoes, untFuncoesGenerica, untTEntCli, untFatCancelarBaixaDocumentos,
  untFatResolveConflitoPedidos;

{$R *.dfm}

function TfrmFatConfDocumentos.fVerificaClienteInativo: Boolean;
begin
  Result := True;
  If Not(SameText(edtCodCli.Text, edtCliFat.Text)) And (not SameText(edtCliFat.Text, strCliFat)) Then
  Begin
    If (objConfDocs.objFatVenda.fRetornaStatusClienteVenda(edtCliFat.Text) = 'I') And
       (Not objConfDocs.objFatVenda.fPermiteVenderApenasDinheiroECartaoParaInativo(objConfDocs.objFatVenda.strOpcDoc)) Then
    Begin
      If (objConfDocs.objFatVenda.strOpcDoc = 'CF') Then
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('Liberação de Confirmação de Documentos para Clientes Inativos.');

        objLiberacao.strDirAce := 'LIBCIC';
        objLiberacao.strSenLib := fCfgSis('SENCIC');
        objLiberacao.strMsgSen := 'Liberação de Confirmação de Documentos para Clientes Inativos';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCliente := edtCliFat.Text + '-' + fRetNomCliente(edtCliFat.Text);
        objLiberacao.strCpfCnpj := fRetCgcCpf(edtCliFat.Text);

        If (Not objConfDocs.objFatVenda.fFatMensagemLiberacao(objLiberacao)) Then
        Begin
          edtCliFat.Text    := edtCodCli.Text;
          edtNomCliFat.Text := edtNomCli.Text;
          strCliFat         := edtCliFat.Text;
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente está com atividade suspensa!', ['&O k']);
        edtCliFat.Text    := edtCodCli.Text;
        edtNomCliFat.Text := edtNomCli.Text;
        strCliFat         := edtCliFat.Text;
        Result    := False;
      End;
    End;
  End;

  If (Result) Then
    strCliFat := edtCliFat.Text;
end;

procedure TfrmFatConfDocumentos.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;

end;

procedure TfrmFatConfDocumentos.cmbClienteEnderecosSelect(Sender: TObject);
begin
  pCriaTemporaria;
  pSetFocus(TComboBoxFocus(Sender));
end;

function TfrmFatConfDocumentos.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End Else
        Begin
          pMostraCliSeg;
        End;
      End;

    End

    Else If (Sender = edtNumDoc) Then
    Begin
      If Not fEmptyStr(edtNumDoc.Text) Then
        pMostraAlertaSintetizacao(edtNumDoc,'As sintetizações não ocorrem quando apenas um documento é filtrado.');
    End

    Else If (Sender = edtCliFat) Then
    Begin
      If (fEmptyStr(edtCliFat.Text)) Then
      Begin
        edtCliFat.Text := edtCodCli.Text;
        fCarregaNovoCliente;
      End
      Else If (strOrgPub <> fCampoTabela('CLI_ORGPUB', 'CADCLI', ['CLI_CODCLI'], [edtCliFat.Text])) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não é possível trocar um cliente "Orgão Publico" para um cliente "Não Orgão Publico"!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If fCarregaNovoCliente Then
        Begin
          If (qryCliFat.IsEmpty) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End
        Else
          Result := False;
      End;

      If (not fVerificaClienteInativo()) Then
        Result := False;
    End

    Else If (Sender = edtEspDoc) Then
    Begin

      If Not fEmptyStr(edtEspDoc.Text) Then
        pMostraAlertaSintetizacao(edtEspDoc,'As sintetizações não ocorrem quando apenas uma espécie é filtrada.');

      If (Not fEmptyStr(edtNumDoc.Text)) And (Not fEmptyStr(edtEspDoc.Text)) Then
      Begin
        mskDtaIni.Clear;
        mskDtaFin.Clear;
        mskDtaIni.Enabled := False;
        mskDtaFin.Enabled := False;
        edtCliSeg.Enabled := False;
        pCriaTemporaria;
      End Else
      Begin
        edtCliSeg.Enabled := True;
      End;

    End

    Else If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If (StrToDateDef(mskDtaIni.Text, 0) + StrToDateDef(mskDtaFin.Text, 0)) <> 0 Then
        pMostraAlertaSintetizacao(TEditFocus(IIF(Sender = mskDtaFin, mskDtaFin, mskDtaIni)),
                                  'As sintetizações não contemplarão documentos fora do intervalo de datas informado.');

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
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
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End
            Else If Not edtCliSeg.Visible Then
              pCriaTemporaria;
          End;
        End
      End
      Else If Not edtCliSeg.Visible Then
        pCriaTemporaria;

    End

    Else If (Sender = edtCliSeg) And edtCliSeg.Visible And edtCliSeg.Enabled Then
    Begin
      pCriaTemporaria;
      pSetFocus(edtCliSeg);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;


function TfrmFatConfDocumentos.fVerificaTrocaCliente: Boolean;
var
  strCodCid: String;
  strNomCid: String;
  strEstCid: String;
  strCgcCpf: String;
  strNovCli: String;

  objLiberacao: TLiberacao;

  procedure pAtualizaDadosCliente(strCodCliente: String);
  begin
    strCodCid := fRetCodCidByCliente(strCodCliente);
    strNomCid := fRetNomCidade(strCodCid);
    strEstCid := fRetNomCidade(strCodCid, 1);
    strCgcCpf := fRetCgcCpf(strCodCliente);
    strCgcCpf := fFormataCpfCgc(strCgcCpf, fSetaPais);
  end;

begin

  strNovCli := fRetNomCliente(edtCliFat.Text);

  If fEmptyStr(strNovCli) Then
  Begin
    Result := True;
    Exit;
  End;

  objLiberacao := TLiberacao.Create;

  pAtualizaDadosCliente(edtCodCli.Text);

  objLiberacao.objMsgLibera.pAddSeparador;
  objLiberacao.objMsgLibera.pAddTexto('TROCA DE CLIENTE NA CONFIRMAÇÃO DE DOCUMENTOS');
  objLiberacao.objMsgLibera.pAddSeparador;
  objLiberacao.objMsgLibera.pAddTextoCaption('Cliente Atual:' , edtCodCli.Text + '-'+edtNomCli.Text, 22);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cidade:'        , strNomCid + ' - ' + strEstCid, 22);
  objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ:'      , strCgcCpf, 22);

  objLiberacao.objMsgLibera.pAddQuebra;
  pAtualizaDadosCliente(edtCliFat.Text);

  objLiberacao.objMsgLibera.pAddTextoCaption('Novo Cliente:'  , edtCliFat.Text + '-'+ strNovCli, 22);
  objLiberacao.objMsgLibera.pAddTextoCaption('Cidade:'        , strNomCid + ' - ' + strEstCid, 22);
  objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ:'      , strCgcCpf, 22);
  objLiberacao.objMsgLibera.pAddSeparador;

  objLiberacao.strDirAce := 'LBTRCL';
  objLiberacao.strMsgSen := 'TROCA DE CLIENTE NA CONFIRMAÇÃO DE DOCUMENTOS';
  objLiberacao.blnMosMen := True;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  FreeAndNil(objLiberacao);
end;

procedure TfrmFatConfDocumentos.OnGetTextVLRCON(Sender: TField; var Text: String; DisplayText: Boolean);
  Var
    fltVlrCon: Double;
begin
  If (Not Sender.DataSet.IsEmpty) Then
  Begin
    fltVlrCon := Sender.DataSet.FieldByName('TMP_VLRCON').AsFloat+
                 Sender.DataSet.FieldByName('TMP_TOTIPI').AsFloat+
                 Sender.DataSet.FieldByName('TMP_TOTRET').AsFloat+
                 Sender.DataSet.FieldByName('TMP_TOTREF').AsFloat;

    Text := FormatFloat('#,##0.00', fltVlrCon);
  End;
end;

procedure TfrmFatConfDocumentos.pCriaTemporaria;
Begin
  if StrToIntDef(objConfDocs.strQtdDocSel, 0) > 0 then
    objConfDocs.objFatVenda.objLock.pDestravarTodos;

  objConfDocs.strCodCli := edtCodCli.Text;
  objConfDocs.strNumDoc := edtNumDoc.Text;
  objConfDocs.strEspDoc := edtEspDoc.Text;
  objConfDocs.dtaDtaIni := StrToDateDef(mskDtaIni.Text, 0);
  objConfDocs.dtaDtaFim := StrToDateDef(mskDtaFin.Text, 0);

  If edtCliSeg.Visible And edtCliSeg.Enabled Then
    objConfDocs.strCliSeg := edtCliSeg.Text
  Else
    objConfDocs.strCliSeg := EmptyStr;

  if not fEmptyStr(cmbClienteEnderecos.Text) then
  begin
    objConfDocs.AutoIncrenEnderecoEntrega := TClienteEnderecoEntregaRepositorio.
      fGetAutoIncEnderecoEntega(cmbClienteEnderecos);
  end
  Else
    objConfDocs.AutoIncrenEnderecoEntrega := '';

  objConfDocs.SituacaoFinanceira := TSituacaoFinanceira(cmbSituacaoFinanceira.ItemIndex);

  objConfDocs.CarregaItensJaFaturado := False;

  objConfDocs.pCriaTemporariaConfirmacao;
  pAtualizaTotais;

  If Assigned(objConfDocs.qryConfirmacao.FindField('TMP_VLRCON')) Then
    objConfDocs.qryConfirmacao.FieldByName('TMP_VLRCON').OnGetText := OnGetTextVLRCON;

  shpFFBol.Visible := objConfDocs.blnConfTemFFComBol;
  lblFFBol.Visible := shpFFBol.Visible;

  btnPopMenuMarca.Enabled    := False;
  btnPopMenuDesMarca.Enabled := False;

  If fCfgSis('COENRE', varBoolean) Then
  Begin
    btnPopMenuMarca.Enabled    := fTemItensEntregaRetira(objConfDocs.objFatVenda.strTabelaConfMi);
    btnPopMenuDesMarca.Enabled := btnPopMenuMarca.Enabled;
  End;

  If edtCliFat.Visible Then
  Begin
    If mskDtaFin.Enabled Then
      pSetFocus(mskDtaFin)
    Else If mskDtaIni.Enabled Then
      pSetFocus(mskDtaIni)
    Else If dbgDocumentos.Enabled Then
      pSetFocus(dbgDocumentos);
  End
  Else
    pSetFocus(pnlAux2);

End;

procedure TfrmFatConfDocumentos.pHintSplitters(splSplitter: TcxSplitter; blnFechado: Boolean);
  Var
    strAcao: String;
begin
  If Not Assigned(splSplitter) Then
    Exit;

  If Not (splSplitter Is TcxSplitter) Then
    Exit;

  Try
    TcxSplitter(splSplitter).ShowHint := False;

    strAcao := IIF(blnFechado, 'Expandir', 'Retrair');

    TcxSplitter(splSplitter).Hint := strAcao + ' Mensagens';
  Finally
    TcxSplitter(splSplitter).ShowHint := True;
  End;
end;

procedure TfrmFatConfDocumentos.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma    := False;
  blnFecharForm  := False;
  blnBaixouDocumentos := False;
  qryConCli      := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  objLiberacao := TLiberacao.Create;
end;

procedure TfrmFatConfDocumentos.FormDestroy(Sender: TObject);
begin
  inherited;

  If Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);
end;

procedure TfrmFatConfDocumentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    fltFator : Double;
    fltFatValAnt : Double;
    objLiberacao : TLiberacao;
begin
  inherited;
  fltFatValAnt := 0;
  If (Assigned(ActiveControl)) And ((ActiveControl) = edtNumDoc) And
     (Shift = [ssAlt]) And (Key = VK_NEXT) And
     (Not fCfgSis('CADFAZ', varBoolean)) Then
  Begin
    fltFator := objConfDocs.objFatVenda.fltFatNot;

    {SE E SOMENTE SE ESTIVERMOS NA CONFIGURAÇÃO DE CONTROLE DE DIMINUIÇÃO DO FATOR, TRAREMOS O FATOR DO CADASTRO
    DE CLIENTES (NOVO OU ATUAL), CASO O FATOR ORIGINAL OU GRAVADO VIER ZERADO - KM}
    If (fCfgSis('FATNSP',varBoolean)) Then
    Begin
      If fltFator <= 0 Then
      Begin
        {NOVO CLIENTE}
        If not fEmptyStr(edtCliFat.Text) Then
        Begin
          fCarregaNovoCliente;
          fltFator := qryCliFat.FieldByName('CLI_FTNFES').asFloat;
        End
        Else
        Begin
          {CLIENTE ATUAL}
          If not fEmptyStr(edtCodCli.Text) Then
            fltFator := qryConCli.FieldByName('CLI_FTNFES').asFloat;
        End;
      End;

      fltFatValAnt := fltFator;
    End;

    If (fDigQuantidade('Fator para nota especial',
                       'Fator',
                       fltFator,
                       0,
                       9999999999,
                       4)) And
       (fFormataFloat(fltFator, 4) > 0) Then
    Begin
      {TRATAR A LIBERAÇÃO PARA A DIMINUIÇÃO DO FATOR - KM}
      If (fCfgSis('FATNSP',varBoolean)) Then
      Begin
        If (fltFatValAnt > fltFator) And Assigned(objConfDocs.objFatVenda) Then
        Try
          objLiberacao := TLiberacao.Create;

          objLiberacao.objMsgLibera.pAddTexto('Permissão para diminuir o fator de nota especial');
          objLiberacao.objMsgLibera.pAddSeparador(100);
          objLiberacao.objMsgLibera.pAddTextoCaption('Fator Digitado', FloatToStrF(fltFator, ffNumber, 12, 3));
          objLiberacao.objMsgLibera.pAddTextoCaption('Fator Anterior', FloatToStrF(fltFatValAnt, ffNumber, 12, 3));
          objLiberacao.strDirAce  := 'DIMFNE';
          objLiberacao.strSenLib  := fCfgSis('SENLBD');
          objLiberacao.strMsgSen  := 'Liberacao de Diminuição do Fator de Nota Especial';
          objLiberacao.blnMosMen  := True;
          objLiberacao.strCodOpe  := strLoginUsuarioLogado;
          objLiberacao.strCodDig  := strLoginUsuarioLogado;
          objLiberacao.strCliente := objConfDocs.objFatVenda.strCodCli + '-' + objConfDocs.objFatVenda.strCliNom;
          objLiberacao.strCpfCnpj := objConfDocs.objFatVenda.strCliCgc;
          objLiberacao.blnUsarSenhaFixa         := False;
          objLiberacao.blnSempreVariavelUsuario := True;

          If (not objConfDocs.objFatVenda.fFatMensagemLiberacao(objLiberacao)) Then
          Begin
            fltFator  := fltFatValAnt;
            objConfDocs.objFatVenda.fltFatNot := fltFator;
            Exit;
          End;
        Finally
          FreeAndNil(objLiberacao);
        End;
      End;
      objConfDocs.objFatVenda.fltFatNot := fltFator;
      objConfDocs.objFatVenda.strTipFatNEs := 'V';
      objConfDocs.objFatVenda.blnMeiaNota := True;
    End
    Else
    Begin
      objConfDocs.objFatVenda.fltFatNot := 0;
      objConfDocs.objFatVenda.strTipFatNEs := 'V';
      objConfDocs.objFatVenda.blnMeiaNota := False;
    End;
  End
end;

procedure TfrmFatConfDocumentos.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmFatConfDocumentos.pCarregarEnderecosEntrega;
begin
  Try
    if fClienteConsumidor(edtNomCli.Text) then
    begin
      lblEnderecoEntrega.Visible  := False;
      cmbClienteEnderecos.Visible := False;
    end
    else
      TClienteEnderecoEntregaRepositorio.
        pCarregaEnderecosEntrega(edtCodCli.Text, cmbClienteEnderecos);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pCarregarEnderecosEntrega]');
  End;
end;

procedure TfrmFatConfDocumentos.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    If fMensagem('', 'Abandona?', ['&Sim', '&Não']) = 1 Then
    Begin
      objConfDocs.pDeletaTemporariaConfirmacao;
      Close;
    End;
  End
  Else If (Key = VK_Return) Then
  Begin
    If Not objConfDocs.qryConfirmacao.IsEmpty Then
      pMarcaDocumento(objConfDocs.qryConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
  End

  Else If (Key = VK_F4) Then
    btnBaiDoc.Click

  Else If (Key = VK_F5) Then
  Begin
    btnItensDoc.Click;
  End

  Else If (Key = VK_F6) Then
    btnDupPagas.Click
    
  Else If (Key = VK_F7) Then
    btnMarca.Click

  Else If (Key = VK_F8) Then
    btnDesmarca.Click

  Else If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirma.Click;
  End

  Else If (Key = VK_F11) Then
    btnCancelarBaixaDocumento.Click;
end;

procedure TfrmFatConfDocumentos.dbgDocumentosMouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmFatConfDocumentos.dbgDocumentosMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  With objConfDocs.qryConfirmacao Do
  Begin
    If Not Active Then
      Exit;

    If (Button = mbRight) And (FieldByName('TMP_ESPDOC').AsString = 'DV') Then
      HintControler.ShowHint(Self.Left+dbgDocumentos.Left+X+5, Self.Top+dbgDocumentos.Top+Y+115, '',
                            objConfDocs.pMontaListaComDocFatDaDV(FieldByName('TMP_NUMDOC').AsString,
                                                                 FieldByName('TMP_CODEMP').AsString));
  End;
end;

procedure TfrmFatConfDocumentos.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With objConfDocs.qryConfirmacao Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************JB*}
    If Not Active Then
      Exit;

    {*******************************************************}
    {* MODIFICA A COR DA FONTE P\ VERDE CASO SEJA DUP.AGR. *}
    {****************************************************LU*}
    If FieldByName('TMP_REGCOR').AsString = 'G' Then
        dbgDocumentos.Canvas.Font.Color := clGreen

    {*******************************************************}
    {* FF COM BOLETO EMITIDO                               *}
    {****************************************************VA*}
    Else If FieldByName('TMP_FF_BOL').AsString = 'S' Then  
       dbgDocumentos.Canvas.Font.Color := shpFFBol.Brush.Color

    {*****************************************************************}
    {* MODIFICA A COR DA FONTE P\ VERMELHO CASO SEJA DOC.BAIX. TOTAL *}
    {**************************************************************LU*}
    Else If FieldByName('TMP_REGCOR').AsString = 'V' Then
        dbgDocumentos.Canvas.Font.Color := clRed

    {*****************************************************************}
    {* MODIFICA A COR DA FONTE P\ MARROM CASO SEJA DOC.BAIX. PARCIAL *}
    {**************************************************************AZ*}
    Else If FieldByName('TMP_REGCOR').AsString = 'M' Then
      dbgDocumentos.Canvas.Font.Color := clMaroon

    {**********************************************}
    {* MODIFICA A COR DA FONTE P\ ROXO CASO       *}
    {* NÃO EXISTA O CONTAS A RECEBER NO CADREC/X  *}
    {********************************************FC}
    Else If FieldByName('TMP_REGCOR').AsString = 'N' Then
      dbgDocumentos.Canvas.Font.Color := clPurple

    {***********************************************}
    {* DOCUMENTOS NÃO SINTETIZADOS.                *}
    {* CASO INCLUA NOVAS LEGENDAS DEIXAR ESSA POR  *}
    {* ÚLTIMA                                      *}
    {*********************************************VA}
    Else If FieldByName('TMP_PODSIN').AsString = 'N' Then
      dbgDocumentos.Canvas.Font.Color := shpNaoSint.Brush.Color;

    If FieldByName('TMP_MARDES').AsString = 'M' Then
    Begin
      If (intRecAtu = RecNo) Then
        dbgDocumentos.Canvas.Font.Color := clLime
      Else
        dbgDocumentos.Canvas.Font.Color := clBlue;
    End;

  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  if (Column.FieldName = 'TMP_TPOPER') then
  begin
    Column.Visible := fCfgSis('USOREV', varBoolean);

    if (Column.Visible) then
    begin
      dbgDocumentos.Canvas.FillRect(Rect);
      case AnsiIndexStr(Column.Field.AsString, ['USO/CONSUMO', 'REVENDA', 'INDUSTRIALIZAÇÃO']) of
        0: dbgDocumentos.Canvas.TextOut((Rect.Left - 3) + (Rect.Width div 2), Rect.Top, 'U');
        1: dbgDocumentos.Canvas.TextOut((Rect.Left - 3) + (Rect.Width div 2), Rect.Top, 'R');
        2: dbgDocumentos.Canvas.TextOut((Rect.Left - 2) + (Rect.Width div 2), Rect.Top, 'I');
      end;
    end;
  end;

end;

procedure TfrmFatConfDocumentos.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  If not (objConfDocs.qryConfirmacao.IsEmpty) Then
    pMarcaDocumento(objConfDocs.qryConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
end;

procedure TfrmFatConfDocumentos.pMostraAlertaSintetizacao(edt: TEditFocus; strMsg: String);
begin
  If (shpNaoSint.Visible) Then
  Begin
    HintAlerta.ShowHint(Self.Left+pnlCabecalho.Left+edt.Left+edt.Width,
                        Self.Top +pnlCabecalho.Top +edt.Top +edt.Height+5, '',
                        'O sistema está configurado para realizar a sintetização de documentos "CFG_SINCNF = SIM".'+#10#13+strMsg);
    TimerAlerta.Enabled := True;
  End;
end;

procedure TfrmFatConfDocumentos.pMostraCliSeg;
Begin
  lblCliSeg.Visible := fClienteSeguradora(qryConCli.FieldByName('CLI_NOMCLI').AsString);
  edtCliSeg.Visible := fClienteSeguradora(qryConCli.FieldByName('CLI_NOMCLI').AsString);
  pnlCliSeg.Visible := fClienteSeguradora(qryConCli.FieldByName('CLI_NOMCLI').AsString);
End;

procedure TfrmFatConfDocumentos.pnlCabecalhoExit(Sender: TObject);
begin
  inherited;
  HintAlerta.HideHint;
  TimerAlerta.Enabled := False;
end;

procedure TfrmFatConfDocumentos.popEntClick(Sender: TObject);
begin
  inherited;

  pMarcarDesmarcarTudo(IfThen(popMarca.Tag = 0, 'M', 'D'), 'E');
end;

procedure TfrmFatConfDocumentos.popRetClick(Sender: TObject);
begin
  inherited;

  pMarcarDesmarcarTudo(IfThen(popMarca.Tag = 0, 'M', 'D'), 'R');
end;

procedure TfrmFatConfDocumentos.splMsgAfterClose(Sender: TObject);
begin
  inherited;
  pHintSplitters(TcxSplitter(Sender), True);
end;

procedure TfrmFatConfDocumentos.splMsgAfterOpen(Sender: TObject);
begin
  inherited;
  pHintSplitters(TcxSplitter(Sender), False);
end;

function TfrmFatConfDocumentos.fValidarTransportadoraDocsSelecionados: Boolean;
  Var
    frmFatResolveConflitoPedidos : TfrmFatResolveConflitoPedidos;
    strCodTraSel : String;
    blnCodTraDif : Boolean;
    blnResolveuConflitos : Boolean;
    blnPrimeiroSelecionado: Boolean;
begin

  Result := True;

  strCodTraSel := '';
  blnCodTraDif := False;

  if ( objConfDocs.objfatVenda.qryTemporariaConfirmacao = Nil ) then
    Exit;

  If fCfgSis('TRADOC', varBoolean) then
  Begin
    pCriarFormularios(TfrmFatResolveConflitoPedidos, frmFatResolveConflitoPedidos);

    Try

      frmFatResolveConflitoPedidos.fatVenda := objConfDocs.objFatVenda;
      frmFatResolveConflitoPedidos.strOpcDoc := objConfDocs.objFatVenda.strOpcDoc;

      With objConfDocs.objfatVenda.qryTemporariaConfirmacao do
      begin
        First;

        blnPrimeiroSelecionado := True;

        While not Eof do
        begin

          If Assigned(frmFatResolveConflitoPedidos) Then
          Begin

            If FieldByName('TMP_MARDES').AsString = 'M' Then
            Begin

              If blnPrimeiroSelecionado Then
              Begin
                strCodTraSel := FieldByName('TMP_CODTRA').AsString;
                blnPrimeiroSelecionado := False;
              End
              Else
              Begin
                If (Not blnCodTraDif) Then
                Begin
                  If (Not fEmptyStr(strCodTraSel)) And
                     (strCodTraSel <> FieldByName('TMP_CODTRA').AsString) Then
                    blnCodTraDif := True;
                End;
              End;

              frmFatResolveConflitoPedidos.pAddDocumentos(FieldByName('TMP_NUMDOC').AsString,
                                                          FieldByName('TMP_ESPDOC').AsString,
                                                          FieldByName('TMP_CODEMP').AsString,
                                                          FieldByName('TMP_CODCLI').AsString);
            End;
          End;

          Next;
        end;

      end;

      objConfDocs.objfatVenda.blnResolveuConflitoDeTransportadora := True;

      If Assigned(frmFatResolveConflitoPedidos) Then
      Begin

        If (blnCodTraDif) Then
        Begin
          blnResolveuConflitos := True;

          If (blnResolveuConflitos) And (blnCodTraDif) Then
          Begin
            frmFatResolveConflitoPedidos.tipConflPedido := cpDocTransportadora;
            frmFatResolveConflitoPedidos.ShowModal;
            blnResolveuConflitos := frmFatResolveConflitoPedidos.blnConfirma;

            If (blnResolveuConflitos) Then
            Begin
              objConfDocs.objfatVenda.strCodTra := frmFatResolveConflitoPedidos.edtCodTra.Text;
              objConfDocs.objfatVenda.blnResolveuConflitoDeTransportadora := True;
            End;
          End;

          If (Not blnResolveuConflitos) Then
            objConfDocs.objfatVenda.blnResolveuConflitoDeTransportadora := False;
        End;

      End;

      Result := objConfDocs.objFatVenda.blnResolveuConflitoDeTransportadora;

    Finally
      pFreeAndNil(frmFatResolveConflitoPedidos);
    End;

  End;
end;

procedure TfrmFatConfDocumentos.TimerAlertaTimer(Sender: TObject);
begin
  inherited;
  HintAlerta.HideHint;
  TimerAlerta.Enabled := False;
end;

procedure TfrmFatConfDocumentos.FormShow(Sender: TObject);
begin
  inherited;
  dtsQryTmp := fCriaDataSource(objConfDocs.qryConfirmacao);
  dbgDocumentos.DataSource := dtsQryTmp;
  dbeCliSeg.DataSource     := dtsQryTmp;
  dbeMen001.DataSource     := dtsQryTmp;
  dbeMen002.DataSource     := dtsQryTmp;

  edtCodCli.Text           := objConfDocs.strCodCli;
  strOrgPub := fCampoTabela('CLI_ORGPUB', 'CADCLI', ['CLI_CODCLI'], [objConfDocs.strCodCli]);
  pCarregaCliente;

  pMostraCliSeg;

  objConfDocs.pAtualizaDados := pAtualizaDados;
  objConfDocs.prbProgresso := prbProgresso;

  qryCliFat := fCriaQuery(Self);
  qryCliFat.SQL.Add('SELECT SQL_NO_CACHE * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');

  edtCliFat.Text := edtCodCli.Text;

  If (Not fCfgSis('TRCLCF', varBoolean)) Then
  Begin
    pnlCabecalho.Height  := 57;
    edtCliFat.Visible    := False;
    edtNomCliFat.Visible := False;
  End;

  shpNaoSint.Visible := fCfgSis('SINCNF', varBoolean);
  lblNaoSint.Visible := shpNaoSint.Visible;
  lblNaoSint.Hint := shpNaoSint.Hint;

  pAjustarFiltrosNoFormulario;

  chkEditaEmail.Visible := fCfgSis('MOVDIG', varBoolean);
  chkEditaEmail.Enabled := True;
  chkEditaEmail.Checked := fCfgSis('EDTEMA', varBoolean);

  gbTipoOper.Visible := fCfgSis('USOREV', varBoolean);
end;

procedure TfrmFatConfDocumentos.btnDesmarcaClick(Sender: TObject);
begin
  inherited;

  If btnPopMenuDesMarca.Enabled Then
    btnPopMenuDesMarca.Click
  Else
    pMarcarDesmarcarTudo('D','');

end;

procedure TfrmFatConfDocumentos.btnDupPagasClick(Sender: TObject);
  Var
    strDocsDev: String;
begin

  inherited;

  strDocsDev := '';

  With dbgDocumentos.DataSource.DataSet Do
  Begin
    If FieldByName('TMP_DUPREC').AsFloat <> 0 Then
    Begin

      objConfDocs.cdsDocsDevSintetizado.Filtered := False;
      objConfDocs.cdsDocsDevSintetizado.Filter   := 'DOCUMENTO = ' +
                                                    QuotedStr(FieldByName('TMP_NUMDOC').AsString + '-' +
                                                              FieldByName('TMP_ESPDOC').AsString + '-' +
                                                              FieldByName('TMP_CODEMP').AsString);
      objConfDocs.cdsDocsDevSintetizado.Filtered := True;

      If Not objConfDocs.cdsDocsDevSintetizado.IsEmpty Then
      Begin
        objConfDocs.cdsDocsDevSintetizado.First;
        While Not objConfDocs.cdsDocsDevSintetizado.Eof Do
        Begin
          strDocsDev := strDocsDev +
                        objConfDocs.cdsDocsDevSintetizado.FieldByName('DEVOLUCAO').AsString + ',';

          objConfDocs.cdsDocsDevSintetizado.Next;
        End;

        If Not fEmptyStr(strDocsDev) Then
        Begin
          If strDocsDev[Length(strDocsDev)] = ',' Then
          Begin
            strDocsDev[Length(strDocsDev)] := ' ';
            strDocsDev := Trim(strDocsDev);
          End;
        End;
      End;

      If Assigned(prcExecutaRelatorio) Then
      begin
        prcExecutaRelatorio(137, 6351, [],
                            ['NUMDOC','ESPDOC','CODEMP','DOCDEV'],
                            [FieldByName('TMP_NUMDOC').AsString,
                            FieldByName('TMP_ESPDOC').AsString,
                            FieldByName('TMP_CODEMP').AsString,
                            strDocsDev],
                            Sender,
                            nil,
                            True);
      End;

    End;

  End;

end;

procedure TfrmFatConfDocumentos.btnItensDocClick(Sender: TObject);
begin
  inherited;

  objConfDocs.pCarregaItensDocumento;

  pSetFocus(dbgDocumentos);

end;

procedure TfrmFatConfDocumentos.btnMarcaClick(Sender: TObject);
begin
  inherited;

  If btnPopMenuMarca.Enabled Then
    btnPopMenuMarca.Click
  Else
    pMarcarDesmarcarTudo('M','');

end;

procedure TfrmFatConfDocumentos.btnPopMenuDesMarcaClick(Sender: TObject);
begin
  inherited;

  With TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) Do
  Begin
     popMarca.Tag := 1; //DESMARCA
     popMarca.Popup(X, Y);
  End;
end;

procedure TfrmFatConfDocumentos.btnPopMenuMarcaClick(Sender: TObject);
begin
  inherited;

  With TButton(Sender).ClientToScreen(Point(0, TButton(Sender).Height)) Do
  Begin
     popMarca.Tag := 0; //MARCA
     popMarca.Popup(X, Y);
  End;
end;

procedure TfrmFatConfDocumentos.btnCancelarBaixaDocumentoClick(Sender: TObject);
var frmFatCancelarBaixaDocumentos : TfrmFatCancelarBaixaDocumentos;
begin
  If not (fVerificaAcessoSistema('CANBAI')) Then
  begin
    fMensagem('', 'Operador não tem direito de acesso ao botão "Cancelar Baixa Documentos"!', ['&OK']);
    Exit;
  end;

  Try
    dbgDocumentos.DataSource := nil;

    Try
      pCriarFormularios(TfrmFatCancelarBaixaDocumentos, frmFatCancelarBaixaDocumentos);
      frmFatCancelarBaixaDocumentos.ConfirmacaoDocumentos := objConfDocs;
      frmFatCancelarBaixaDocumentos.showModal;

      dbgDocumentos.DataSource := dtsQryTmp;
      objConfDocs.prbProgresso := prbProgresso;

      pCriaTemporaria;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmFatConfDocumentos.btnCancelarBaixaDocumento]');
      End;
    End;
  Finally
    pFreeAndNil(frmFatCancelarBaixaDocumentos);
  End;
end;

procedure TfrmFatConfDocumentos.btnBaiDocClick(Sender: TObject);
begin
  inherited;
  If (fVerificaAcessoSistema('PEBACF')) Then
    pConfirmar(True)
  Else
    fMensagem('', 'Operador não tem direito de acesso ao botão "Baixar Documentos"!', ['&OK']);
end;

procedure TfrmFatConfDocumentos.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pConfirmar();
end;

procedure TfrmFatConfDocumentos.FormActivate(Sender: TObject);
begin
  inherited;

  {*****************************************}
  {* CASO NÃO TENHA NENHUM DOCUMENTO, SAI  *}
  {**************************************MV*}
  If blnFecharForm Then
  Begin
    fMensagem('', 'Não há documentos para esse cliente!', ['&O k']);
    Self.Close;
  End;
  
end;

function TfrmFatConfDocumentos.fCarregaNovoCliente: Boolean;
begin
  Result := False;
  If (fCfgSis('LBTRCL', varBoolean))    And
     (edtCliFat.Text <> edtCodCli.Text) Then
  Begin
    If ((Not qryCliFat.isEmpty) And
       (qryCliFat.FieldByName('CLI_CODCLI').AsString <> edtCliFat.Text)) Or
       (qryCliFat.isEmpty) Then
    Begin
      If (Not fVerificaTrocaCliente) Then
        Exit;
    End;
  End;
  qryCliFat.Close;
  qryCliFat.ParamByName('CODCLI').AsString := edtCliFat.Text;
  qryCliFat.Open;
  edtNomCliFat.Text := qryCliFat.FieldByName('CLI_NOMCLI').AsString;
  Result := True;
end;

procedure TfrmFatConfDocumentos.pConfirmar(blnApenasBaixarDocumentos: Boolean = False);
begin
  Try
    If fFiltroFoiAlterado Then
      Exit;

    btnConfirma.Enabled := False;
    btnBaiDoc.Enabled := False;

    If (Not fValidaCampos(edtCliFat, False)) Then
      Exit;

    If StrToIntDef(edtQtdDocSel.Text, 0) <= 0 Then
    Begin
      fMensagem('', 'É necessário escolher pelo menos um documento!', ['&O k']);
      pSetFocus(dbgDocumentos);
      Exit;
    End;

    If (Not blnApenasBaixarDocumentos) Then
    Begin
      If (fStrToFloat(objConfDocs.strTotTrvSel) < 0.0) Then
      Begin
        fMensagem('', 'Não é possível confirmar um valor negativo!', ['&OK']);
        pSetFocus(dbgDocumentos);
        Exit;
      End;
    End;

    If fBloqueiaConfirmacaoOndeTodosDocumentosEstaoQuitados(fStrToFloat(edtTotLiqSel.Text)) Then
    Begin
      pSetFocus(dbgDocumentos);
      Exit;
    End;

    If (Not objConfDocs.fValidaValorRecebidoDocumentosSelecionados) Then
    Begin
      pSetFocus(dbgDocumentos);
      Exit;
    End;

    If (Not objConfDocs.fVerificaDocumentosDigitalizados) Then
    Begin
      pSetFocus(dbgDocumentos);
      Exit;
    End;

    If (Not objConfDocs.fVerificaDocumentosFinanceiroAberto) Then
    Begin
      pSetFocus(dbgDocumentos);
      Exit;
    End;


    If fMensagem('', 'Confirma ' + IIF(blnApenasBaixarDocumentos, 'baixa dos ', '') + 'documentos?', ['&Sim', '&Não']) = 1 Then
    Begin

      If (Not fValidarTransportadoraDocsSelecionados) Then
      Begin
        pSetFocus(dbgDocumentos);
        Exit;
      End;

      If (Not blnApenasBaixarDocumentos) And (Not objConfDocs.fValidaDVsCorrelatasMarcadas) Then
      Begin
        pSetFocus(dbgDocumentos);
        Exit;
      End;

      objConfDocs.pDeletaDocDesmarcados;

      If (blnApenasBaixarDocumentos) Then
        objConfDocs.pAtualizaTemporariaConfirmacao(True)
      Else If objConfDocs.blnSintetizarDevolucao Then
      Begin
        dbgDocumentos.DataSource := nil;
        Try
          objConfDocs.pResintetizaDevolucoes;
        Finally
          dbgDocumentos.DataSource := dtsQryTmp;
        End;
        objConfDocs.pAtualizaTemporariaConfirmacao(True);
      End
      Else
        objConfDocs.pAtualizaTemporariaConfirmacao(False);

      If (Not blnApenasBaixarDocumentos) Then
      Begin
        objConfDocs.pGeraStringDocsConfirmados;
        objConfDocs.pPegaPlacaAndKmVeiculo;
        blnConfirma := True;
      End
      Else
      Begin
        objConfDocs.pBaixarDocumentosMarcados;
        blnConfirma := True;
        blnBaixouDocumentos := True;
      End;

      If objConfDocs.objFatVenda.blnMeiaNota Then
      Begin
        objConfDocs.pMarcarDocumentosMeiaNota;
      End;

      objConfDocs.objFatVenda.objLogConfir.FilDoc := edtNumDoc.Text;
      objConfDocs.objFatVenda.objLogConfir.FilEsp := edtNumDoc.Text;
      objConfDocs.objFatVenda.objLogConfir.FilDoc := edtEspDoc.Text;
      objConfDocs.objFatVenda.objLogConfir.Dtaini := mskDtaIni.Text;
      objConfDocs.objFatVenda.objLogConfir.DtaFin := mskDtaFin.Text;
      objConfDocs.objFatVenda.objLogConfir.NovCli := edtCliFat.Text;
      objConfDocs.objFatVenda.objLogConfir.Endere := cmbClienteEnderecos.Text;
      objConfDocs.objFatVenda.objLogConfir.SitFin := cmbSituacaoFinanceira.Text;
      Close;
    End;

  Finally
    btnConfirma.Enabled := True;
    btnBaiDoc.Enabled := True;
  End;
end;

procedure TfrmFatConfDocumentos.edtCliFatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliFat, edtNomCliFat, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliFat, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConfDocumentos.pAjustarFiltrosNoFormulario;
begin
  if fCfgSis('TRAMIC', varBoolean) then
  begin
    lblSituacaoFinanceira.Visible := False;
    cmbSituacaoFinanceira.Visible := False;
  end;

  pCarregarEnderecosEntrega;

  if not(cmbClienteEnderecos.Visible) and
     not(cmbSituacaoFinanceira.Visible) then
    pnlCabecalho.Height := 75;
end;

procedure TfrmFatConfDocumentos.pAtualizaDados(DataSet: TDataSet);
begin
  intRecAtu := DataSet.RecNo;
  HintControler.HideHint;
end;

procedure TfrmFatConfDocumentos.pAtualizaTotais;
begin
  edtQtdDoc.Text := objConfDocs.strQtdDoc;
  edtTotGer.Text := objConfDocs.strTotGer;
  edtDupPag.Text := objConfDocs.strDupPag;
  edtDesSuj.Text := objConfDocs.strDesSuj;
  edtJurSuj.Text := objConfDocs.strJurSuj;
  edtTotLiq.Text := objConfDocs.strTotLiq;

  edtQtdDocSel.Text := objConfDocs.strQtdDocSel;
  edtTotGerSel.Text := objConfDocs.strTotGerSel;
  edtDupPagSel.Text := objConfDocs.strDupPagSel;
  edtDesSujSel.Text := objConfDocs.strDesSujSel;
  edtJurSujSel.Text := objConfDocs.strJurSujSel;
  edtTotLiqSel.Text := objConfDocs.strTotLiqSel;
end;

procedure TfrmFatConfDocumentos.pMarcaDocumento(blnMarcar: Boolean);
  Var
    strMsg: String;
begin
  objConfDocs.strMsgTinta := '';
  objConfDocs.fMarcaDocumento(blnMarcar, strMsg);
  pAtualizaTotais;
end;

procedure TfrmFatConfDocumentos.pMarcarDesmarcarTudo(strOpc, strEntRet: String);
begin

  If (strOpc = 'M') Then
  Begin
    If fFiltroFoiAlterado Then
      Exit;
    objConfDocs.pMarcarTodosDocumentos(True, strEntRet);
  End
  Else
  Begin
    objConfDocs.pMarcarTodosDocumentos(False, strEntRet);
  End;

  pAtualizaTotais;
end;

procedure TfrmFatConfDocumentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(objConfDocs.cdsDocsDevSintetizado) Then
    objConfDocs.cdsDocsDevSintetizado.Free;

  objConfDocs.pAtualizaDados := Nil;
  objConfDocs.prbProgresso := Nil;

  If Not blnConfirma Then
  Begin
    objConfDocs.pDeletaTemporariaConfirmacao;
    objConfDocs.objFatVenda.objLock.pDestravarTodos;
  End;
  
end;

procedure TfrmFatConfDocumentos.edtEspDocEnter(Sender: TObject);
begin
  inherited;
  mskDtaIni.Enabled := True;
  mskDtaFin.Enabled := True;
end;

function TfrmFatConfDocumentos.fFiltroFoiAlterado: Boolean;
begin
  Result := (objConfDocs.strNumDoc <> edtNumDoc.Text) Or
            (objConfDocs.strEspDoc <> edtEspDoc.Text) Or
            (objConfDocs.strCliSeg <> edtCliSeg.Text) Or
            (objConfDocs.dtaDtaIni <> StrToDateDef(mskDtaIni.Text,0)) Or
            (objConfDocs.dtaDtaFim <> StrToDateDef(mskDtaFin.Text,0));
            
  If (Result) Then
  Begin
    fMensagem('ATENÇÃO!', 'Os filtros dos documentos sofreram alteração.' + Chr(13) +
                          'Será preciso realizar uma nova consulta dos documentos. ' +  Chr(13) +
                          'Valide todos os campos com enter para carregar os documentos corretamente!', ['&OK']);

    If edtNumDoc.CanFocus Then
      pSetFocus(edtNumDoc)
    Else If mskDtaIni.CanFocus Then
      pSetFocus(mskDtaIni);
  End;
end;

end.
