unit untRelComissaoVendedorCTRMod2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, Uni, StrUtils, AppEvnts, untFuncoesConsulta,
  UniDataSetProvider, DB, UniClientDataSet, untRelValorRecebidoMod2, BitBtnLockedIncrem,
  frxExportCSVTestabilidade, ComboBoxFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, Vcl.ComCtrls, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmRelComissaoVendedorCTRMod2 = class(TfrmPaiRelatorio)
    frxComissaoVendedorCTR_M: TfrxReport;
    frxCabecalho: TfrxUserDataSet;
    frxComissaoVendedorCTR_J: TfrxReport;
    frxComissaoVendedorSintCTR_M: TfrxReport;
    frxComissaoVendedorSintCTR_J: TfrxReport;
    rdgTipRel: TRadioGroup;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    rdgRelEmp: TRadioGroup;
    mskDtaCor: TMaskEditFocus;
    pnlServico: TPanel;
    rdgServicos: TRadioGroup;
    rdgPosCom: TRadioGroup;
    chkConJur: TCheckBox;
    pnlGerCom: TPanel;
    gpbGravaComi: TGroupBox;
    chkGraCom: TCheckBox;
    mskDtaVen: TMaskEditFocus;
    pnlVendedor: TPanel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    shpVen: TShape;
    chkDocCom: TCheckBox;
    shpDocCom: TShape;
    lblOpcVen: TLabel;
    cbxVenRep: TComboBoxFocus;
    lblTitVen: TLabel;
    pnlPDF: TPanel;
    chkEjeVen: TCheckBox;
    chkPDFVen: TCheckBox;
    fraDirPDF: TfraDirectoryEditFocus;
    prbProgresso: TProgressBar;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure edtCodEmpExit(Sender: TObject);
    procedure pCarregaEmpresa(Var qryCadEmp: TUniQuery);
    procedure pCarregaVendedor(Var qryCadOpe: TUniQuery);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure frxCabecalhoGetValue(const VarName: String; var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkGraComClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    function frxComissaoVendedorSintCTR_MUserFunction(const MethodName: string; var Params: Variant): Variant;
    procedure FormActivate(Sender: TObject);
    procedure rdgTipRelClick(Sender: TObject);
    procedure cbxVenRepChange(Sender: TObject);
    procedure chkPDFVenClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryVendedor   : TUniQuery;
    qryRelatorio  : TUniQuery;
    cdsRelAnalitico,
    cdsRelSintetico: TUniClientDataSet;
    relRecebido   : TValorRecebido;
    qryFaixa: TUniQuery;
    blnLiberado: Boolean;

    function fGetSQLTotalAberto: String;

    function fGetSqlMovDet: String;
    function fGetSQLSintetico(strSQLAnalitico: String): String;
    function fGetSqlSinteticoMovDet(strAnalitico: String): String;

    function fGetSqlCheque(blnAnalitico: Boolean = False): String;
    function fGetSqlChequeSint: String;
    function fGetSqlCartao(blnAnalitico: Boolean = False): String;
    function fGetSqlCartaoSint: String;

    function fGetPercentualComissaoFaixa(fltFat: Double): Double;

    procedure pSetaParametros(qry: TUniQuery; blnClaFis: Boolean = False);
    procedure pSetaParamCheque(qry: TUniQuery);
    procedure pSetaParamCartao(qry: TUniQuery);

    procedure pCalculaComissaoPorFaixa(cdsRel: TUniClientDataSet);

    procedure pGravaComissao(strSQL: String);

    function fEhComissaoPorFator(strTabela: String): Boolean;
    function fRetCampoFator(strTabela: String): String;

    procedure pCriaCdsAnalitico;
    procedure pCriaCdsSintetico;

    function fConcatConsultasArray(arrCons: TConsultasArray): String;
    function fGetCampoCodVenMovCar: String;
    function fGetCampoCodVenCadChq: String;
    procedure pExportarPDFParaCadaVendedor(qckRel: TfrxReport);
    procedure pHabilitaOpcoesPDF;
  public
    { Public declarations }
    strEmpresa,
    strVendedor,
    strCodVen,
    strPeriodo: String;

    arrOperador: TConsultasArray;
    arrEmpresa : TConsultasArray;
    strEmp,
    strVen: String;

    blnComissaoPorFaixa: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelComissaoVendedorCTRMod2: TfrmRelComissaoVendedorCTRMod2;
  arrVenRep: Array[0..3] Of String = ('VENDEDOR', 'REPRESENTANTE', 'QUÍMICO', 'GERENTE');

Const
  TIPREL_ANALITICO = 0;
  TIPREL_SINTETICO = 1;

  POSCOM_TODAS = 0;
  POSCOM_PENDENTES = 1;
  POSCOM_BAIXADAS = 2;

implementation

uses untFuncoesSimples,  untConsultas,
     untCfgRel, untConstantes, untTGravaComissaoVen;

{$R *.dfm}

procedure TfrmRelComissaoVendedorCTRMod2.cbxVenRepChange(Sender: TObject);
begin
  inherited;
  lblTitVen.Caption := Copy(cbxVenRep.Items[cbxVenRep.ItemIndex], 4, Length(cbxVenRep.Items[cbxVenRep.ItemIndex])) + ':';
end;

procedure TfrmRelComissaoVendedorCTRMod2.chkGraComClick(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.MskCodCta.Enabled := chkGraCom.Checked;
  mskDtaVen.Enabled := chkGraCom.Checked;

  // Se for gravar comissão, exibe apenas no vídeo, e sintético
  edtDestino.Enabled := Not chkGraCom.Checked;
  rdgTipRel.Enabled := Not chkGraCom.Checked;
  rdgPosCom.Enabled := Not chkGraCom.Checked;
  If chkGraCom.Checked Then
  Begin
    edtDestino.Text := 'V';
    rdgTipRel.ItemIndex := TIPREL_SINTETICO;
    rdgPosCom.ItemIndex := POSCOM_PENDENTES;
  End
  Else
  Begin
    fraPlanoDeContas.MskCodCta.Clear;
    fraPlanoDeContas.edtDesCta.Clear;
    mskDtaVen.Clear;
  End;
end;

procedure TfrmRelComissaoVendedorCTRMod2.chkPDFVenClick(Sender: TObject);
begin
  inherited;
  pHabilitaOpcoesPDF;
end;

procedure TfrmRelComissaoVendedorCTRMod2.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelComissaoVendedorCTRMod2.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmpresa, False) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelComissaoVendedorCTRMod2.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intContador: Integer;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
    Exit(False);
  //

  Result := True;

  {*********************}
  {* VALIDA DATAS      *}
  {******************LU*}
  If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Begin
      fMensagem('ATENÇÃO', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
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
          fMensagem('ATENÇÃO', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('ATENÇÃO','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
    End;

  End

  Else If (Sender = edtCodEmp) Then
  Begin
    pDesmarcaLista(edtCodEmp, arrEmpresa);

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      If (edtCodEmp.Text <> '000') Then
      Begin
        SetLength(arrEmpresa, 0);

        edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If Not fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            edtDesEmpresa.Text := '';
            Result := False;
          End;
        End
        Else
        Begin
          fMensagem('ATENÇÃO', 'Empresa não cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else If Length(arrEmpresa) > 0 Then
      Begin
        For intContador := Low(arrEmpresa) To High(arrEmpresa) Do
        Begin
          If Pos(arrEmpresa[intContador].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a Empresa ' + arrEmpresa[intContador].strCodigo + '!', ['&O k']);
            edtDesEmpresa.Text := '';
            Result := False;
            Break;
          End;
        End;
      End
      Else
      Begin
        SetLength(arrEmpresa, 0);
        fMensagem('ATENÇÃO', 'Empresa Inválida', ['&OK']);
        edtDesEmpresa.Text := '';
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaCor) Then
  Begin

    If fEmptyDate(mskDtaCor.Text) Then
    Begin
      pMensagemOk('"Data de corte para relatório de comissão" não preenchido em' + Chr(13) +
                  'Configuração do Sistema -> Contas a Receber.'   );
      Result := False;
    End;

  End

  Else If (Sender = edtCodVendedor) Then
  Begin
    pDesmarcaLista(edtCodVendedor, arrOperador);

    If blnLiberado Then
    Begin
      If Not fEmptyStr(edtCodVendedor.Text) Then
      Begin
        If edtCodVendedor.Text <> '000' Then
        Begin
          strCodVen           := edtCodVendedor.Text;
          edtDesVendedor.Text := fRetNomVendRep(strCodVen);

          If fEmptyStr(edtDesVendedor.Text) Then
          Begin
            Result := False;
            fMensagem('ATENÇÃO', arrVenRep[cbxVenRep.ItemIndex] + ' não encontrado.', ['&O K']);
          End;
        End
        Else If Not fEmptyStr(edtCodVendedor.Text) Then
        Begin
          strCodVen := '';
          For intContador := 0 To High(arrOperador) Do
          Begin
            If fEmptyStr(strCodVen) Then
              strCodVen := arrOperador[intContador].strCodigo
            Else
              strCodVen := strCodVen + '_' + arrOperador[intContador].strCodigo;
          End;
        End;

      End
      Else
      Begin
        edtDesVendedor.Text := 'TODOS';
        strCodVen := '';
      End;
    End
    Else
    Begin
      If (fEmptyStr(edtCodVendedor.Text)) Then
      Begin
        fMensagem('ATENÇÃO', 'O ' + arrVenRep[cbxVenRep.ItemIndex] + ' deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(fRetCodVendedor(edtCodVendedor.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Nenhum operador encontrado com esta senha!', ['&Ok']);
          edtDesVendedor.Text := '';
          Result := False;
        End
        Else
        Begin
          strCodVen := fRetCodVendedor(edtCodVendedor.Text);

          If Not fEmptyStr(strCodVen) Then
            edtDesVendedor.Text := fRetNomVendRep(strCodVen)
          Else
          Begin
            fMensagem('ATENÇÃO', arrVenRep[cbxVenRep.ItemIndex] + ' não encontrado.', ['&O K']);
            edtDesVendedor.Text := '';
            Result := False;
          End;
        End;
      End;
    End;
  End

  Else If (Sender = fraPlanoDeContas.MskCodCta) Then
  Begin
    If (fraPlanoDeContas.MskCodCta.Enabled) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text))) Then
      Begin
        fMensagem('ATENÇÃO', 'Plano de Contas deve ser preenchido!', ['&O k']);
        Result := False;
      End
      
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text));

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO', 'Plano de Contas não encontrado!', ['&O k']);
          Result := False;
        End;

      End;
    End;
  End

  Else If (Sender = mskDtaVen) Then
  Begin
    If (mskDtaVen.Enabled) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text)) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'Data de vencimento deve ser preenchida!', ['&O k']);
      End

      Else If StrToDateDef(mskDtaVen.Text, 0) = 0 Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO', 'Digite uma data válida!', ['&O k']);
      End
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelComissaoVendedorCTRMod2.pCalculaComissaoPorFaixa(cdsRel: TUniClientDataSet);
  Var
    qryFat: TUniQuery;
    fltRecCom, fltValFat: Double;
    strCodVen: String;
begin
  qryFat := fCriaQuery;

  Try
    qryFat.SQL.Add(fGetSqlMovDet);
    pSetaParametros(qryFat, True);
    qryFat.Open;

    cdsRel.First;
    While Not cdsRel.Eof Do
    Begin
      If cdsRel.Fields.FindField('CTR_CODVEN') <> Nil Then
        strCodVen := cdsRel.FieldByName('CTR_CODVEN').AsString

      Else If cdsRel.Fields.FindField('CODVEN') <> Nil Then
        strCodVen := cdsRel.FieldByName('CODVEN').AsString;

      qryFat.Filtered := False;
      qryFat.Filter := 'CTR_CODVEN = ' + QuotedStr(strCodVen);
      qryFat.Filtered := True;

      cdsRel.Edit;
      fltValFat := qryFat.FieldByName('CTR_VALFAT').AsFloat;
      fltRecCom := 0;

      If cdsRel.Fields.FindField('CTR_RECCOM') <> Nil Then
        fltRecCom := fltRecCom + cdsRel.FieldByName('CTR_RECCOM').AsFloat;

      //If cdsRel.Fields.FindField('VALCHQ') <> Nil Then
      //  fltRecCom := fltRecCom + cdsRel.FieldByName('VALCHQ').AsFloat;

      //If cdsRel.Fields.FindField('VALCAR') <> Nil Then
      //  fltRecCom := fltRecCom + cdsRel.FieldByName('VALCAR').AsFloat;

      cdsRel.FieldByName('VALOR_COMISSAO').AsFloat := fltRecCom * (fGetPercentualComissaoFaixa(fltValFat) / 100);
      cdsRel.Post;

      cdsRel.Next;
    End;    
  Finally
    FreeAndNil(qryFat);
  End;              
end;

procedure TfrmRelComissaoVendedorCTRMod2.pCarregaEmpresa(Var qryCadEmp: TUniQuery);
Begin

  If Not (fEmptyStr(edtCodEmp.Text)) Then
    edtDesEmpresa.Text := qryCadEmp.FieldByName('EMP_NOMEMP').AsString
  Else
    edtDesEmpresa.Text := '';
    
End;

procedure TfrmRelComissaoVendedorCTRMod2.edtCodVendedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If blnLiberado Then
  Begin
    if fPesqOperador(self, edtCodVendedor, edtDesVendedor, qryVendedor, Key, arrOperador, False) then
    Begin
      If fValidaCampos(edtCodVendedor, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmRelComissaoVendedorCTRMod2.pCarregaVendedor(Var qryCadOpe: TUniQuery);
Begin
  If Not (fEmptyStr(edtCodVendedor.Text)) Then
    edtDesVendedor.Text := qryCadOpe.FieldByName('OPE_NOMOPE').AsString
  Else
    edtDesVendedor.Text := '';
End;

procedure TfrmRelComissaoVendedorCTRMod2.pCriaCdsAnalitico;
  Var
    qryChq, qryCar: TUniQuery;
begin
  cdsRelAnalitico.Open;
  cdsRelAnalitico.EmptyDataSet;

  qryRelatorio.Filtered := False;
  qryRelatorio.Filter := '(CTR_AVISTA <> 0)'+IIF(chkDocCom.Checked, ' AND (VALOR_COMISSAO <> 0)','');
  qryRelatorio.Filtered := True;
  qryRelatorio.First;
  While Not qryRelatorio.Eof Do
  Begin
    cdsRelAnalitico.Append;
    cdsRelAnalitico.FieldByName('SETOR').AsString          := 'DOCUMENTOS RECEBIDOS A VISTA';
    cdsRelAnalitico.FieldByName('NSETOR').AsInteger        := 0;
    cdsRelAnalitico.FieldByName('CTR_CODVEN').AsString     := qryRelatorio.FieldByName('CTR_CODVEN').AsString;
    cdsRelAnalitico.FieldByName('VENDEDOR').AsString       := qryRelatorio.FieldByName('VENDEDOR').AsString;
    cdsRelAnalitico.FieldByName('CTR_DTAREC').AsDateTime   := qryRelatorio.FieldByName('CTR_DTAREC').AsDateTime;
    cdsRelAnalitico.FieldByName('CTR_DTACAD').AsDateTime   := qryRelatorio.FieldByName('CTR_DTACAD').AsDateTime;
    cdsRelAnalitico.FieldByName('CTR_NUMDUP').AsString     := qryRelatorio.FieldByName('CTR_NUMDUP').AsString;
    cdsRelAnalitico.FieldByName('DOCUME').AsString         := qryRelatorio.FieldByName('DOCUME').AsString;
    cdsRelAnalitico.FieldByName('CLIENTE').AsString        := qryRelatorio.FieldByName('CLIENTE').AsString;
    cdsRelAnalitico.FieldByName('CTR_VALREC').AsFloat      := qryRelatorio.FieldByName('CTR_VALREC').AsFloat;
    cdsRelAnalitico.FieldByName('CTR_VALJUR').AsFloat      := qryRelatorio.FieldByName('CTR_VALJUR').AsFloat;
    cdsRelAnalitico.FieldByName('CTR_VALDES').AsFloat      := qryRelatorio.FieldByName('CTR_VALDES').AsFloat;
    cdsRelAnalitico.FieldByName('CTR_RECIPI').AsFloat      := qryRelatorio.FieldByName('CTR_RECIPI').AsFloat;
    cdsRelAnalitico.FieldByName('CTR_RECCOM').AsFloat      := qryRelatorio.FieldByName('CTR_RECCOM').AsFloat;
    cdsRelAnalitico.FieldByName('VALOR_COMISSAO').AsFloat  := qryRelatorio.FieldByName('VALOR_COMISSAO').AsFloat;
    cdsRelAnalitico.Post;

    qryRelatorio.Next;
  End;

  qryRelatorio.Filtered := False;
  qryRelatorio.Filter := '(CTR_APRAZO <> 0)'+IIF(chkDocCom.Checked, ' AND (VALOR_COMISSAO <> 0)','');
  qryRelatorio.Filtered := True;
  qryRelatorio.First;
  While Not qryRelatorio.Eof Do
  Begin
    cdsRelAnalitico.Append;
    cdsRelAnalitico.FieldByName('SETOR').AsString          := 'DOCUMENTOS RECEBIDOS A PRAZO';
    cdsRelAnalitico.FieldByName('NSETOR').AsInteger        := 1;
    cdsRelAnalitico.FieldByName('CTR_CODVEN').AsString     := qryRelatorio.FieldByName('CTR_CODVEN').AsString;
    cdsRelAnalitico.FieldByName('VENDEDOR').AsString       := qryRelatorio.FieldByName('VENDEDOR').AsString;
    cdsRelAnalitico.FieldByName('CTR_DTAREC').AsDateTime   := qryRelatorio.FieldByName('CTR_DTAREC').AsDateTime;
    cdsRelAnalitico.FieldByName('CTR_DTACAD').AsDateTime   := qryRelatorio.FieldByName('CTR_DTACAD').AsDateTime;
    cdsRelAnalitico.FieldByName('CTR_NUMDUP').AsString     := qryRelatorio.FieldByName('CTR_NUMDUP').AsString;
    cdsRelAnalitico.FieldByName('DOCUME').AsString         := qryRelatorio.FieldByName('DOCUME').AsString;
    cdsRelAnalitico.FieldByName('CLIENTE').AsString        := qryRelatorio.FieldByName('CLIENTE').AsString;
    cdsRelAnalitico.FieldByName('CTR_VALREC').AsFloat      := qryRelatorio.FieldByName('CTR_VALREC').AsFloat;
    cdsRelAnalitico.FieldByName('CTR_VALJUR').AsFloat      := qryRelatorio.FieldByName('CTR_VALJUR').AsFloat;
    cdsRelAnalitico.FieldByName('CTR_VALDES').AsFloat      := qryRelatorio.FieldByName('CTR_VALDES').AsFloat;
    cdsRelAnalitico.FieldByName('CTR_RECIPI').AsFloat      := qryRelatorio.FieldByName('CTR_RECIPI').AsFloat;
    cdsRelAnalitico.FieldByName('CTR_RECCOM').AsFloat      := qryRelatorio.FieldByName('CTR_RECCOM').AsFloat;
    cdsRelAnalitico.FieldByName('VALOR_COMISSAO').AsFloat  := qryRelatorio.FieldByName('VALOR_COMISSAO').AsFloat;
    cdsRelAnalitico.Post;

    qryRelatorio.Next;
  End;

  qryRelatorio.Filtered := False;
  qryRelatorio.Filter := '';

  qryChq := fCriaQuery;
  Try
    qryChq.SQL.Text := fGetSqlCheque(True);
    pSetaParamCheque(qryChq);

    If (chkDocCom.Checked) Then
    Begin
      qryChq.Filtered := False;
      qryChq.Filter := '(COMCHQ <> 0)';
      qryChq.Filtered := True;
    End;

    qryChq.Open;
    qryChq.First;
    While Not qryChq.Eof Do
    Begin
      cdsRelAnalitico.Append;
      cdsRelAnalitico.FieldByName('SETOR').AsString          := 'DOCUMENTOS RECEBIDOS EM CHEQUE';
      cdsRelAnalitico.FieldByName('NSETOR').AsInteger        := 2;
      cdsRelAnalitico.FieldByName('CTR_CODVEN').AsString     := qryChq.FieldByName('CODVEN').AsString;
      cdsRelAnalitico.FieldByName('VENDEDOR').AsString       := qryChq.FieldByName('VENDEDOR').AsString;
      cdsRelAnalitico.FieldByName('CTR_DTAREC').AsDateTime   := qryChq.FieldByName('DTADEP').AsDateTime;
      cdsRelAnalitico.FieldByName('CTR_DTACAD').AsDateTime   := qryChq.FieldByName('DTACAD').AsDateTime;
      cdsRelAnalitico.FieldByName('CTR_NUMDUP').AsString     := qryChq.FieldByName('NUMDUP').AsString;
      cdsRelAnalitico.FieldByName('DOCUME').AsString         := '';
      cdsRelAnalitico.FieldByName('CLIENTE').AsString        := qryChq.FieldByName('CLIENTE').AsString;
      cdsRelAnalitico.FieldByName('CTR_VALREC').AsFloat      := qryChq.FieldByName('VALIMP').AsFloat;
      cdsRelAnalitico.FieldByName('CTR_VALJUR').AsFloat      := 0;
      cdsRelAnalitico.FieldByName('CTR_VALDES').AsFloat      := 0;
      cdsRelAnalitico.FieldByName('CTR_RECIPI').AsFloat      := qryChq.FieldByName('VALCHQ').AsFloat;
      cdsRelAnalitico.FieldByName('CTR_RECCOM').AsFloat      := qryChq.FieldByName('VALCHQ').AsFloat;
      cdsRelAnalitico.FieldByName('VALOR_COMISSAO').AsFloat  := qryChq.FieldByName('COMCHQ').AsFloat;
      cdsRelAnalitico.Post;

      qryChq.Next;
    End;    
  Finally
    FreeAndNil(qryChq);
  End;

  qryCar := fCriaQuery;
  Try
    qryCar.SQL.Text := fGetSqlCartao(True);
    pSetaParamCartao(qryCar);

    If (chkDocCom.Checked) Then
    Begin
      qryCar.Filtered := False;
      qryCar.Filter := '(COMCAR <> 0)';
      qryCar.Filtered := True;
    End;

    qryCar.Open;
    qryCar.First;
    While Not qryCar.Eof Do
    Begin
      cdsRelAnalitico.Append;
      cdsRelAnalitico.FieldByName('SETOR').AsString         := 'DOCUMENTOS RECEBIDOS EM CARTÃO';
      cdsRelAnalitico.FieldByName('NSETOR').AsInteger       := 3;
      cdsRelAnalitico.FieldByName('VENDEDOR').AsString      := qryCar.FieldByName('VENDEDOR').AsString;
      cdsRelAnalitico.FieldByName('CTR_CODVEN').AsString    := qryCar.FieldByName('CODVEN').AsString;
      cdsRelAnalitico.FieldByName('CTR_DTAREC').AsDateTime  := qryCar.FieldByName('DTAREC').AsDateTime;
      cdsRelAnalitico.FieldByName('CTR_DTACAD').AsDateTime  := qryCar.FieldByName('DTACAD').AsDateTime;
      cdsRelAnalitico.FieldByName('CTR_NUMDUP').AsString    := qryCar.FieldByName('NUMDUP').AsString;
      cdsRelAnalitico.FieldByName('DOCUME').AsString        := qryCar.FieldByName('DOCUME').AsString;
      cdsRelAnalitico.FieldByName('CLIENTE').AsString       := qryCar.FieldByName('CLIENTE').AsString;
      cdsRelAnalitico.FieldByName('CTR_VALREC').AsFloat     := qryCar.FieldByName('VALIMP').AsFloat;
      cdsRelAnalitico.FieldByName('CTR_VALJUR').AsFloat     := 0;
      cdsRelAnalitico.FieldByName('CTR_VALDES').AsFloat     := 0;
      cdsRelAnalitico.FieldByName('CTR_RECIPI').AsFloat     := qryCar.FieldByName('VALCAR').AsFloat;
      cdsRelAnalitico.FieldByName('CTR_RECCOM').AsFloat     := qryCar.FieldByName('VALCAR').AsFloat;
      cdsRelAnalitico.FieldByName('VALOR_COMISSAO').AsFloat := qryCar.FieldByName('COMCAR').AsFloat;
      cdsRelAnalitico.Post;

      qryCar.Next;
    End;

    If blnComissaoPorFaixa Then
      pCalculaComissaoPorFaixa(cdsRelAnalitico);
  Finally
    FreeAndNil(qryCar);
  End;

  cdsRelAnalitico.IndexFieldNames := 'VENDEDOR;NSETOR;CTR_DTAREC';                                            
end;

procedure TfrmRelComissaoVendedorCTRMod2.pCriaCdsSintetico;
  Var
    cds: TUniClientDataSet;
begin
  cds := fCriaClientDatset(qryRelatorio);
  Try
    cdsRelSintetico.Data := cds.Data;
    
    If blnComissaoPorFaixa Then
      pCalculaComissaoPorFaixa(cdsRelSintetico);
  Finally
    cds.Free;
  End;
end;

procedure TfrmRelComissaoVendedorCTRMod2.pGravaComissao(strSQL: String);
  Var
    qryCom: TUniQuery;
    cdsCom: TUniClientDataSet;
    objGravaComissao: TGravaComissaoVen;
begin
  qryCom := fCriaQuery;
  objGravaComissao := TGravaComissaoVen.Create;
  Try
    objGravaComissao.pSetDtaVen(StrToDateDef(mskDtaVen.Text, 0));
    objGravaComissao.pSetCodCta(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text));

    // Adiciona duplicatas da CADREC/X
    If blnComissaoPorFaixa Then
      qryCom.SQL.Text := 'SELECT * FROM ('+ strSQL + ') TAB WHERE ROUND(CTR_RECCOM, 2) <> 0'
    Else
      qryCom.SQL.Text := 'SELECT * FROM ('+ strSQL + ') TAB WHERE ROUND(VALOR_COMISSAO, 2) <> 0';
    pSetaParametros(qryCom);

    qryCom.Open;
    cdsCom := fCriaClientDatset(qryCom);
    Try
      If blnComissaoPorFaixa Then
        pCalculaComissaoPorFaixa(cdsCom);

      cdsCom.First;
      While Not cdsCom.Eof Do
      Begin
        objGravaComissao.pAddDup(cdsCom.FieldByName('CTR_NUMDUP').AsString,
                                 IIF(cdsCom.FindField('DOCUME') <> Nil, cdsCom.FieldByName('DOCUME').AsString, ''),
                                 cdsCom.FieldByName('CTR_CODCLI').AsString,
                                 cdsCom.FieldByName('CTR_CODVEN').AsString,
                                 cdsCom.FieldByName('TABCTR').AsString,
                                 cdsCom.FieldByName('TABELAUPDATE').AsString,
                                 cdsCom.FieldByName('VALOR_COMISSAO').AsFloat);
        cdsCom.Next;
      End;
    Finally
      cdsCom.Free;
    End;

    // Adiciona duplicatas da CADCHQ/X (Cheque)
    qryCom.Close;
    If blnComissaoPorFaixa Then
      qryCom.SQL.Text := 'SELECT TAB.*, TAB.COMCHQ AS VALOR_COMISSAO FROM ('+ fGetSqlCheque +') TAB WHERE ROUND(VALCHQ, 2) <> 0'
    Else
      qryCom.SQL.Text := 'SELECT TAB.*, TAB.COMCHQ AS VALOR_COMISSAO FROM ('+ fGetSqlCheque +') TAB WHERE ROUND(COMCHQ, 2) <> 0';
    pSetaParamCheque(qryCom);
    qryCom.Open;
    cdsCom := fCriaClientDatset(qryCom);
    Try
      If blnComissaoPorFaixa Then
        pCalculaComissaoPorFaixa(cdsCom);

      cdsCom.First;
      While Not cdsCom.Eof Do
      Begin
        objGravaComissao.pAddChq(cdsCom.FieldByName('AUTOINCREM').AsString,
                                 cdsCom.FieldByName('CODVEN').AsString,
                                 cdsCom.FieldByName('TABELA').AsString,
                                 cdsCom.FieldByName('VALOR_COMISSAO').AsFloat);
        cdsCom.Next;
      End;
    Finally
      cdsCom.Free;
    End;

    // Adiciona duplicatas da MOVCAR (Cartão)
    qryCom.Close;
    If blnComissaoPorFaixa Then
      qryCom.SQL.Text := 'SELECT TAB.*, TAB.COMCAR AS VALOR_COMISSAO FROM ('+ fGetSqlCartao +') TAB WHERE ROUND(VALCAR, 2) <> 0 '
    Else
      qryCom.SQL.Text := 'SELECT TAB.*, TAB.COMCAR AS VALOR_COMISSAO FROM ('+ fGetSqlCartao +') TAB WHERE ROUND(COMCAR, 2) <> 0 ';
    pSetaParamCartao(qryCom);
    qryCom.Open;
    cdsCom := fCriaClientDatset(qryCom);
    Try
      If blnComissaoPorFaixa Then
        pCalculaComissaoPorFaixa(cdsCom);

      cdsCom.First;
      While Not cdsCom.Eof Do
      Begin
        objGravaComissao.pAddCar(cdsCom.FieldByName('AUTOINCREM').AsString,
                                 cdsCom.FieldByName('CODVEN').AsString,
                                 cdsCom.FieldByName('VALOR_COMISSAO').AsFloat);
        cdsCom.Next;
      End;
    Finally
      cdsCom.Free;
    End;

    If objGravaComissao.fGravaComissao Then
      fMensagem('', 'Contas a pagar gravadas com sucesso!', ['&O k']);
  Finally
    FreeAndNil(qryCom);
    FreeAndNil(objGravaComissao);
  End;
end;

procedure TfrmRelComissaoVendedorCTRMod2.pSetaParametros(qry: TUniQuery; blnClaFis: Boolean = False);
begin
  qry.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
  qry.ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

  If qry.Params.FindParam('DTACOR') <> Nil Then
    qry.ParamByName('DTACOR').AsDateTime := StrToDate(mskDtaCor.Text);

  If Not fEmptyStr(edtCodEmp.Text) Then
    pSetaParam(edtCodEmp.Text, arrEmpresa,strEmp,'CODEMP',qry);

  If (Not fEmptyStr(edtCodVendedor.Text)) Then
    pSetaParam(edtCodVendedor.Text,arrOperador,strVen,'CODVEN', qry);

  If (rdgTipRel.ItemIndex = TIPREL_SINTETICO) Or (blnClaFis) Then
  Begin
    If qry.Params.FindParam('CLAFIS') <> Nil Then
      qry.ParamByName('CLAFIS').AsString := VS_strClaVen;
      
    If qry.Params.FindParam('CLADEV') <> Nil Then
      qry.ParamByName('CLADEV').AsString := VS_strClaDev;
  End;
end;

procedure TfrmRelComissaoVendedorCTRMod2.pSetaParamCartao(qry: TUniQuery);
begin
  qry.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
  qry.ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

  If Not fEmptyStr(edtCodEmp.Text) Then
    pSetaParam(edtCodEmp.Text,arrEmpresa,strEmp,'CODEMP',qry);

  If (Not fEmptyStr(edtCodVendedor.Text)) Then
    pSetaParam(edtCodVendedor.Text,arrOperador,strVen,'CODVEN', qry);
end;

procedure TfrmRelComissaoVendedorCTRMod2.pSetaParamCheque(qry: TUniQuery);
begin
  qry.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
  qry.ParamByName('DTAFIM').AsDate := StrToDate(mskDtaFin.Text);

  If Not fEmptyStr(edtCodEmp.Text) Then
    pSetaParam(edtCodEmp.Text,arrEmpresa,strEmp,'CODEMP',qry);

  If (Not fEmptyStr(edtCodVendedor.Text)) Then
    pSetaParam(edtCodVendedor.Text,arrOperador,strVen,'CODVEN', qry);
end;

procedure TfrmRelComissaoVendedorCTRMod2.rdgTipRelClick(Sender: TObject);
begin
  inherited;

  If rdgTipRel.ItemIndex = 0 Then
    chkDocCom.Caption := 'Exibir somente documentos com valor de comissão'
  Else
    chkDocCom.Caption := 'Exibir somente documentos com valor de comissão ou faturado';

  pHabilitaOpcoesPDF;
end;

Function TfrmRelComissaoVendedorCTRMod2.fGetSQLSintetico(strSQLAnalitico: String): String;
Begin
  Result :=          ' SELECT                                    ';
  Result := Result + '   CTR_CODVEN,                             ';
  Result := Result + '   OP.OPE_NOMOPE,                          ';
  Result := Result + '   0 AS CTR_VALFAT,                        ';
  Result := Result + '   VENDEDOR,                               ';
  Result := Result + '   0               AS CTR_ABERTO,          ';
  Result := Result + '   SUM(CTR_VALORI) AS CTR_VALORI,          ';
  Result := Result + '   SUM(CTR_VALJUR) AS CTR_VALJUR,          ';
  Result := Result + '   SUM(CTR_VALDES) AS CTR_VALDES,          ';
  Result := Result + '   SUM(CTR_VALREC) AS CTR_VALREC,          ';
  Result := Result + '   SUM(CTR_RECCOM) AS CTR_RECCOM,          ';
  Result := Result + '   SUM(CTR_RECIPI) AS CTR_RECIPI,          ';
  Result := Result + '   SUM(VALOR_COMISSAO) AS VALOR_COMISSAO,  ';
  Result := Result + '   SUM(CTR_AVISTA) AS CTR_AVISTA,          ';
  Result := Result + '   SUM(CTR_APRAZO) AS CTR_APRAZO           ';
  Result := Result + ' FROM  (' + strSQLAnalitico + ') AS TABELA ';
  Result := Result + ' INNER JOIN CADOPE OP ON OP.OPE_CODOPE = CTR_CODVEN ';
  Result := Result + ' GROUP BY CTR_CODVEN                       ';
End;

Function TfrmRelComissaoVendedorCTRMod2.fGetSqlTotalAberto: String;
  Var
    strSQL,
    strSum: String;
Begin
  strSQL := '';
  {***************************************************}
  {* CADREC DIRETA - SEM AGRUPAMENTO NEM CONFIRMAÇÃO *}
  {************************************************AC*}
  strSQL := strSQL + relRecebido.fGetSqlSemAgrupamentoNemConfirmacaoAberto('CADREC', rdgServicos.ItemIndex);
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC PROVENIENTE DE CONFIRMAÇÃO DOCUMENTO     *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlComConfirmacaoAberto('CADREC', 'CTRCNF', rdgServicos.ItemIndex);
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO DIRETO                       *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlComAgrupamentoDiretoAberto('CADREC', 'DUPAGR', rdgServicos.ItemIndex);
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO CONFIRMAÇÃO                  *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlAgrupamentoConfirmacaoAberto('CADREC',  'DUPAGR',  'CTRCNF', rdgServicos.ItemIndex);

  strSum := '';
  strSum := strSum + ' SELECT ';
  strSum := strSum + '   CTR_CODVEN,                    ';
  strSum := strSum + '   OPE_NOMOPE,                    ';
  strSum := strSum + '   0 AS CTR_VALFAT,               ';
  strSum := strSum + '   VENDEDOR,                      ';
  strSum := strSum + '   SUM(CTR_ABERTO) AS CTR_ABERTO, ';
  strSum := strSum + '   0 AS CTR_VALORI,               ';
  strSum := strSum + '   0 AS CTR_VALJUR,               ';
  strSum := strSum + '   0 AS CTR_VALDES,               ';
  strSum := strSum + '   0 AS CTR_VALREC,               ';
  strSum := strSum + '   0 AS CTR_RECCOM,               ';
  strSum := strSum + '   0 AS CTR_RECIPI,               ';
  strSum := strSum + '   0 AS VALOR_COMISSAO,           ';
  strSum := strSum + '   0 AS CTR_AVISTA,               ';
  strSum := strSum + '   0 AS CTR_APRAZO                ';
  strSum := strSum + ' FROM (' + strSQL + ') AS TABABE ';
  strSum := strSum + ' GROUP BY CTR_CODVEN ';

  Result := strSum;

End;

procedure TfrmRelComissaoVendedorCTRMod2.btnImprimirClick(Sender: TObject);
  Var
    strSQL,
    strSQLAna: String;
begin
  inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  relRecebido.strCodVen := strCodVen;
  relRecebido.strCodEmp := fConcatConsultasArray(arrEmpresa);
  relRecebido.intPosCom := rdgPosCom.ItemIndex;
  relRecebido.blnConJur := chkConJur.Checked;
  relRecebido.relRelEmp := IIF(rdgRelEmp.ItemIndex = 0, reMovimentacao, reVendedor);
  relRecebido.strRelCt2 := fCfgSis('RELCT2');
  relRecebido.blnDocCom := chkDocCom.Checked;

  Case cbxVenRep.ItemIndex Of
    0: relRecebido.opcVenRep := opVendedor;
    1: relRecebido.opcVenRep := opRepresentante;
    2: relRecebido.opcVenRep := opQuimico;
    3: relRecebido.opcVenRep := opGerente;
  End;

  If fEmptyStr(strCodVen) And (Not blnLiberado) Then
  Begin
    blnImprime := False;
    fMensagem('', 'Informe a senha para o Vendedor!', ['&Ok']);
  End;

  If blnImprime Then
  Begin
    Try
      strSQL := '';
      {***************************************************}
      {* CADREC DIRETA - SEM AGRUPAMENTO NEM CONFIRMAÇÃO *}
      {************************************************AC*}
      strSQL := strSQL + relRecebido.fGetSqlSemAgrupamentoNemConfirmacao('CADREC', rdgServicos.ItemIndex);
      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC PROVENIENTE DE CONFIRMAÇÃO DOCUMENTO     *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlComConfirmacao('CADREC', 'CTRCNF', rdgServicos.ItemIndex);
      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC AGRUPAMENTO DIRETO                       *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlComAgrupamentoDireto('CADREC', 'DUPAGR', rdgServicos.ItemIndex);
      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC AGRUPAMENTO CONFIRMAÇÃO                  *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlAgrupamentoConfirmacao('CADREC',  'DUPAGR',  'CTRCNF', rdgServicos.ItemIndex);

      strSQL := strSQL + ' ORDER BY  ';
      strSQL := strSQL + '   CTR_CODVEN, ';
      strSQL := strSQL + '   CTR_DTAREC, ';
      strSQL := strSQL + '   CTR_NUMDUP  ';

      strSQLAna := strSQL;

      If rdgTipRel.ItemIndex = TIPREL_SINTETICO Then
        strSQL := fGetSqlSinteticoMovDet(strSQLAna);

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        pSetaParametros(qryRelatorio);

        Open;

        If (Not fEmptyStr(edtCodEmp.Text)) Then
          strEmpresa := fStrTitulo(edtCodEmp.Text, edtDesEmpresa, arrEmpresa, strEmp, 'EMPRESA')
        Else
          strEmpresa := 'EMPRESA :' + strEmpAcessoUsuarioLogado;

        If (Not fEmptyStr(strCodVen)) Then
          strVendedor := fStrTitulo(edtCodVendedor.Text, edtDesVendedor, arrOperador, strVen, arrVenRep[cbxVenRep.ItemIndex])
        Else
          strVendedor := arrVenRep[cbxVenRep.ItemIndex] + ': TODOS';

        strPeriodo := 'PERIODO : ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' a ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text));

        If rdgTipRel.ItemIndex = TIPREL_ANALITICO Then
        Begin
          pCriaCdsAnalitico;
          frxRelatorio.DataSet := cdsRelAnalitico
        End
        Else
        Begin
          pCriaCdsSintetico;
          frxRelatorio.DataSet := cdsRelSintetico;
        End;

        If Not frxRelatorio.DataSet.IsEmpty Then
        Begin

          If rdgTipRel.ItemIndex = 0 Then // ANALITICO
          Begin

            If strTipImp = 'M' Then
            Begin
              TfrxGroupHeader(frxComissaoVendedorCTR_M.FindObject('GHComissao')).StartNewPage     := chkEjeVen.Checked;
              TfrxGroupHeader(frxComissaoVendedorCTR_M.FindObject('GHComissao')).ResetPageNumbers := chkEjeVen.Checked;

              frxComissaoVendedorCTR_M.PrintOptions.ShowDialog := fEmptyStr(frxComissaoVendedorCTR_M.PrintOptions.Printer);
              frxComissaoVendedorCTR_M.Script.Variables['DOCCOM'] := AnsiUpperCase(fRemoveAcento(chkDocCom.Caption)) + IIF(chkDocCom.Checked, ': SIM', ': TODOS');

              if (not chkPDFVen.Checked) Then
              begin
                If edtDestino.Text = 'V' Then
                  pPreviewReport(Self.Name, Self.Caption, frxComissaoVendedorCTR_M)
                Else
                Begin
                  If frxComissaoVendedorCTR_M.PrepareReport Then
                    pPrintReport(Self.Name, Self.Caption, strNomImp, frxComissaoVendedorCTR_M);
                End;
              end
              else
                pExportarPDFParaCadaVendedor(frxComissaoVendedorCTR_M);
            End Else
            Begin
              TfrxGroupHeader(frxComissaoVendedorCTR_J.FindObject('GHComissao')).StartNewPage     := chkEjeVen.Checked;
              TfrxGroupHeader(frxComissaoVendedorCTR_J.FindObject('GHComissao')).ResetPageNumbers := chkEjeVen.Checked;

              frxComissaoVendedorCTR_J.PrintOptions.ShowDialog := fEmptyStr(frxComissaoVendedorCTR_M.PrintOptions.Printer);
              frxComissaoVendedorCTR_J.Script.Variables['DOCCOM'] := AnsiUpperCase(chkDocCom.Caption) + IIF(chkDocCom.Checked, ': SIM', ': TODOS');

              if (not chkPDFVen.Checked) Then
              begin
                If edtDestino.Text = 'V' Then
                  pPreviewReport(Self.Name, Self.Caption, frxComissaoVendedorCTR_J)
                Else
                Begin
                  If frxComissaoVendedorCTR_J.PrepareReport Then
                    pPrintReport(Self.Name, Self.Caption, strNomImp, frxComissaoVendedorCTR_J);
                End;
              end
              else
                pExportarPDFParaCadaVendedor(frxComissaoVendedorCTR_J);
            End;

          End Else // SINTETICO
          Begin

            If strTipImp = 'M' Then
            Begin
              frxComissaoVendedorSintCTR_M.PrintOptions.ShowDialog := fEmptyStr(frxComissaoVendedorCTR_M.PrintOptions.Printer);
              frxComissaoVendedorSintCTR_M.Script.Variables['DOCCOM'] := AnsiUpperCase(fRemoveAcento(chkDocCom.Caption)) + IIF(chkDocCom.Checked, ': SIM', ': TODOS');
              frxComissaoVendedorSintCTR_M.Script.Variables['TITVEN'] := arrVenRep[cbxVenRep.ItemIndex];

              If edtDestino.Text = 'V' Then
                pPreviewReport(Self.Name, Self.Caption, frxComissaoVendedorSintCTR_M)
              Else
              Begin
                If frxComissaoVendedorSintCTR_M.PrepareReport Then
                  pPrintReport(Self.Name, Self.Caption, strNomImp, frxComissaoVendedorSintCTR_M);
              End;
            End Else
            Begin
              frxComissaoVendedorSintCTR_J.PrintOptions.ShowDialog := fEmptyStr(frxComissaoVendedorCTR_M.PrintOptions.Printer);
              frxComissaoVendedorSintCTR_J.Script.Variables['DOCCOM'] := AnsiUpperCase(chkDocCom.Caption) + IIF(chkDocCom.Checked, ': SIM', ': TODOS');
              frxComissaoVendedorSintCTR_J.Script.Variables['TITVEN'] := arrVenRep[cbxVenRep.ItemIndex];

              If edtDestino.Text = 'V' Then
                pPreviewReport(Self.Name, Self.Caption, frxComissaoVendedorSintCTR_J)
              Else
              Begin
                If frxComissaoVendedorSintCTR_J.PrepareReport Then
                  pPrintReport(Self.Name, Self.Caption, strNomImp, frxComissaoVendedorSintCTR_J);
              End;
            End;

          End;

          If chkGraCom.Checked Then
          Begin
            If fMensagem('', 'Deseja gravar a comissão?', ['&Sim','&Não']) = 1 Then
              pGravaComissao(strSQLAna);
          End;

        End
        Else
          fMensagem('Informação', 'Não há dados para gerar o relatório!', ['&Ok']);

      End;

    Finally
    End;

    pSetFocus(mskDtaIni);

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

end;

function TfrmRelComissaoVendedorCTRMod2.fEhComissaoPorFator(strTabela: String): Boolean;
  Var
   strPrefixo: String;
begin
  If strTabela = 'CADCHQ' Then
    strPrefixo := 'CHQ_'
  Else
    strPrefixo := 'MCA_';

  Case cbxVenRep.ItemIndex Of
    0: Result := fCampoExiste(strTabela,strPrefixo+'FATCOM', True);
    1: Result := fCampoExiste(strTabela,strPrefixo+'FATREP', True);
    2: Result := fCampoExiste(strTabela,strPrefixo+'FATQUI', True);
    3: Result := fCampoExiste(strTabela,strPrefixo+'FATGER', True);
    Else Result := False;
  End;
end;

procedure TfrmRelComissaoVendedorCTRMod2.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
begin
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelComissaoVendedorCTRMod2.fRetCampoFator(strTabela: String): String;
  Var
   strPrefixo: String;
begin
  If strTabela = 'CADCHQ' Then
    strPrefixo := 'CHQ_'
  Else
    strPrefixo := 'MCA_';

  Case cbxVenRep.ItemIndex OF
    0: Result := strPrefixo+'FATCOM';
    1: Result := strPrefixo+'FATREP';
    2: Result := strPrefixo+'FATQUI';
    3: Result := strPrefixo+'FATGER';
  End;
end;

procedure TfrmRelComissaoVendedorCTRMod2.frxCabecalhoGetValue(
  const VarName: String; var Value: Variant);
begin
  inherited;

  If SameText('EMPRESA',VarName) Then
    Value := strEmpresa

  Else If SameText('VENDEDOR',VarName) Then
    Value := strVendedor

  Else If SameText('PERIODO',VarName) Then
    Value := strPeriodo

  Else If SameText('JUROS', VarName) Then
    Value := 'CONSIDERAR JUROS COBRADO: '+ IIF(chkConJur.Checked, 'SIM', 'NÃO');

end;

function TfrmRelComissaoVendedorCTRMod2.frxComissaoVendedorSintCTR_MUserFunction(const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fPercent') Then
  Begin
    // Params[0] = Parte do Valor
    // Params[1] = Valor Total
    If Params[1] = 0 Then
      Result := 0
    Else
      Result := Params[0] / Params[1] * 100;
  End;
end;

procedure TfrmRelComissaoVendedorCTRMod2.FormShow(Sender: TObject);
  Var
    dtaCorte : TDate;
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  dtaCorte := fCfgSis('DTCOCR', varDate);

  If dtaCorte = 0 Then
    mskDtaCor.Clear
  Else
    mskDtaCor.Text := FormatDateTime('dd/mm/yyyy', dtaCorte);

  If blnComissaoPorFaixa Then
  Begin
    Caption := 'Comissão por Faixa de Faturamento - Contas a Receber';
    qryFaixa.SQL.Text := 'SELECT * FROM CADFCT';
    qryFaixa.Open;
  End;

  {  VERIFICA SE GERA COMISSÃO A CADA VENDA OU NÃO, CASO NÃO, pnlMeio fica visível }
  if (fCfgSis('GCCVEN') = 'S') then
    pnlGerCom.Visible := False;

  if (Not pnlGerCom.Visible  ) then
    Self.ClientHeight := Self.ClientHeight - pnlGerCom.Height;

  blnLiberado := fVerificaAcessoSistema('RFATCV');
  pVerdeVermelho(edtCodVendedor, shpVen, blnLiberado);
  pVerdeVermelho(chkDocCom, shpDocCom, fVerificaAcessoSistema('DOCCOM'), True);

  inherited;

  shpMultSel.Visible := True;

  pHabilitaOpcoesPDF;
end;

procedure TfrmRelComissaoVendedorCTRMod2.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
    VK_RETURN: If (ActiveControl) Is TRadioGroup Then
                 Self.SelectNext(ActiveControl, True, True);
  End;
end;

Function TfrmRelComissaoVendedorCTRMod2.fGetSqlMovDet: String;

  function fGetSql: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '   ' + relRecebido.fGetVenDigDet + ', ';
    strSQL := strSQL + '   SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP), DET_TOTITE - DET_DESESP))) AS TOTITE ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '   MOVDET ';
    strSQL := strSQL + '     INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM   ';
    strSQL := strSQL + '     INNER JOIN CADOPE ON OPE_CODOPE = ' + relRecebido.fGetVenDigDet;
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '   DET_TIP_FC = "C"  AND ';
    strSQL := strSQL + '   DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';

    strSQL := strSQL + cnsFiltroFFDVTR;

    strSQL := strSQL + '   DET_DTAENT BETWEEN :DTAINI AND :DTAFIM   AND ';

    Case rdgServicos.ItemIndex of
      0 :  strSQL := strSQL + '  DET_ESPDOC = "NS" AND ';// Somente Notas de Serviço
      1 :  strSQL := strSQL + '  DET_ESPDOC <> "NS" AND ';// Exceto Notas de Serviço
    End;

    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      If rdgRelEmp.ItemIndex = 1 Then
        strSQL := strSQL + fStrLocate(edtCodEmp, arrEmpresa, 'OPE_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + fStrLocate(edtCodEmp, arrEmpresa, 'DET_CODEMP', 'CODEMP');
    End
    Else
    Begin
      If rdgRelEmp.ItemIndex = 1 Then
        strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
      Else
        strSQL := strSQL + '    AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;

    If (Not fEmptyStr(edtCodVendedor.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodVendedor, arrOperador, relRecebido.fGetVenDigDet, 'CODVEN');

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  ' + relRecebido.fGetVenDigDet;

    Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL);
  End;

Begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   ' + relRecebido.fGetVenDigDet + ' AS CTR_CODVEN,  ';
  Result := Result + '   OP.OPE_NOMOPE,                           ';
  Result := Result + '   SUM(TOTITE) AS CTR_VALFAT, ';
  Result := Result + '   CONCAT(' + relRecebido.fGetVenDigDet + ',"-",OPE_NOMOPE) AS VENDEDOR, ';
  Result := Result + '   0 AS CTR_ABERTO,          ';
  Result := Result + '   0 AS CTR_VALORI,          ';
  Result := Result + '   0 AS CTR_VALJUR,          ';
  Result := Result + '   0 AS CTR_VALDES,          ';
  Result := Result + '   0 AS CTR_VALREC,          ';
  Result := Result + '   0 AS CTR_RECCOM,          ';
  Result := Result + '   0 AS CTR_RECIPI,          ';
  Result := Result + '   0 AS VALOR_COMISSAO,      ';
  Result := Result + '   0 AS CTR_AVISTA,          ';
  Result := Result + '   0 AS CTR_APRAZO           ';
  Result := Result + ' FROM ( ';
  Result := Result + fGetSql;
  Result := Result + ' ) AS TABDET ';
  Result := Result + ' INNER JOIN CADOPE OP ON OP.OPE_CODOPE = ' + relRecebido.fGetVenDigDet;
  Result := Result + ' GROUP BY ';
  Result := Result + relRecebido.fGetVenDigDet;
End;

function TfrmRelComissaoVendedorCTRMod2.fGetSqlSinteticoMovDet(strAnalitico: String): String;
  procedure pAddSQL(strSQL: String);
  begin
    Result := Result + IIF(Length(Result) = 0, '', #13#10) + strSQL;
  end;
begin
  Result := '';

  pAddSQL(' SELECT ');

  pAddSQL('   CTR_CODVEN,');
  pAddSQL('   OPE_NOMOPE,');
  pAddSQL('   SUM(CTR_VALFAT) AS CTR_VALFAT,');
  pAddSQL('   VENDEDOR,');
  pAddSQL('   SUM(CTR_ABERTO) AS CTR_ABERTO,');
  pAddSQL('   SUM(CTR_VALORI) AS CTR_VALORI,');
  pAddSQL('   SUM(CTR_VALJUR) AS CTR_VALJUR,');
  pAddSQL('   SUM(CTR_VALDES) AS CTR_VALDES,');
  pAddSQL('   SUM(CTR_VALREC) AS CTR_VALREC,');
  pAddSQL('   SUM(CTR_RECCOM) AS CTR_RECCOM,');
  pAddSQL('   SUM(CTR_RECIPI) AS CTR_RECIPI,');
  pAddSQL('   SUM(IFNULL(VALOR_COMISSAO, 0)) AS VALOR_COMISSAO,');
  pAddSQL('   SUM(CTR_AVISTA) AS CTR_AVISTA,');
  pAddSQL('   SUM(CTR_APRAZO) AS CTR_APRAZO,');
  pAddSQL('   SUM(IFNULL(VALCHQ, 0)) AS VALCHQ,');
  pAddSQL('   SUM(IFNULL(VALCAR, 0)) AS VALCAR');

  pAddSQL(' FROM ( ');

  pAddSQL(' SELECT ');
  pAddSQL('   CTR_CODVEN,');
  pAddSQL('   OP.OPE_NOMOPE,');
  pAddSQL('   SUM(CTR_VALFAT) AS CTR_VALFAT,');
  pAddSQL('   VENDEDOR,');
  pAddSQL('   SUM(CTR_ABERTO) AS CTR_ABERTO,');
  pAddSQL('   SUM(CTR_VALORI) AS CTR_VALORI,');
  pAddSQL('   SUM(CTR_VALJUR) AS CTR_VALJUR,');
  pAddSQL('   SUM(CTR_VALDES) AS CTR_VALDES,');
  pAddSQL('   SUM(CTR_VALREC) + IFNULL(CHQ.VALIMP, 0) + IFNULL(CAR.VALIMP, 0) AS CTR_VALREC,');
  pAddSQL('   SUM(CTR_RECCOM) AS CTR_RECCOM,');
  pAddSQL('   SUM(CTR_RECIPI) + IFNULL(CHQ.VALCHQ, 0) + IFNULL(CAR.VALCAR, 0) AS CTR_RECIPI,');
  pAddSQL('   SUM(IFNULL(VALOR_COMISSAO, 0)) + IFNULL(CHQ.COMCHQ, 0) + IFNULL(CAR.COMCAR, 0) AS VALOR_COMISSAO,');
  pAddSQL('   SUM(CTR_AVISTA) AS CTR_AVISTA,');
  pAddSQL('   SUM(CTR_APRAZO) AS CTR_APRAZO,');
  pAddSQL('   IFNULL(CHQ.VALCHQ, 0) AS VALCHQ,');
  pAddSQL('   IFNULL(CAR.VALCAR, 0) AS VALCAR');
  pAddSQL(' FROM');
  pAddSQL('   ('+ fGetSQLSintetico(strAnalitico) + ' UNION ALL '+ fGetSqlMovDet + ' UNION ALL '+ fGetSQLTotalAberto +' ) AS TAB_SINT');
  pAddSQL('   LEFT JOIN ('+ fGetSqlChequeSint +') CHQ ON CHQ.CODVEN = TAB_SINT.CTR_CODVEN');
  pAddSQL('   LEFT JOIN ('+ fGetSqlCartaoSint +') CAR ON CAR.CODVEN = TAB_SINT.CTR_CODVEN');
  pAddSQL('   INNER JOIN CADOPE OP ON OP.OPE_CODOPE = CTR_CODVEN ');

  If chkGraCom.Checked Then
  Begin
    If blnComissaoPorFaixa Then
      pAddSQL(' WHERE ROUND(CTR_RECCOM + IFNULL(CHQ.VALCHQ, 0) + IFNULL(CAR.VALCAR, 0), 2) <> 0 ')
    Else
      pAddSQL(' WHERE ROUND(VALOR_COMISSAO, 2) <> 0 ');
  End;

  pAddSQL(' GROUP BY CTR_CODVEN ');

  pAddSQL(' UNION ALL ');

  pAddSQL('SELECT');
  pAddSQL('  CODVEN AS CTR_CODVEN,');
  pAddSQL('  OP.OPE_NOMOPE, ');
  pAddSQL('  0.00  AS CTR_VALFAT,');
  pAddSQL('  VENDEDOR,');
  pAddSQL('  0.00  AS CTR_ABERTO,');
  pAddSQL('  0.00  AS CTR_VALORI,');
  pAddSQL('  0.00  AS CTR_VALJUR,');
  pAddSQL('  0.00  AS CTR_VALDES,');
  pAddSQL('  0.00  AS CTR_VALREC,');

  If chkDocCom.Checked Then
    pAddSQL('  SUM(IF(IFNULL(COMCHQ, 0) = 0, 0, VALCHQ)) AS RECCOM,')
  Else
    pAddSQL('  SUM(VALCHQ) AS RECCOM,');

  pAddSQL('  0.00  AS CTR_RECIPI,');
  //pAddSQL('  SUM(IFNULL(COMCHQ, 0)) AS VALOR_COMISSAO,');
  pAddSQL('  0.00 AS VALOR_COMISSAO,');
  pAddSQL('  0.00 AS CTR_AVISTA,');
  pAddSQL('  0.00 AS CTR_APRAZO,');
  pAddSQL('  0.00 AS VALCHQ,');
  pAddSQL('  0.00 AS VALCAR');
  pAddSQL('FROM');
  pAddSQL('  ('+ fGetSqlCheque +') TAB ');
  pAddSQL('  INNER JOIN CADOPE OP ON OP.OPE_CODOPE = TAB.CODVEN ');
  pAddSQL('GROUP BY');
  pAddSQL('  CODVEN');

  pAddSQL(' UNION ALL ');

  pAddSQL('SELECT');
  pAddSQL('  CODVEN AS CTR_CODVEN,');
  pAddSQL('  OP.OPE_NOMOPE, ');
  pAddSQL('  0.00  AS CTR_VALFAT,');
  pAddSQL('  VENDEDOR,');
  pAddSQL('  0.00  AS CTR_ABERTO,');
  pAddSQL('  0.00  AS CTR_VALORI,');
  pAddSQL('  0.00  AS CTR_VALJUR,');
  pAddSQL('  0.00  AS CTR_VALDES,');
  pAddSQL('  0.00  AS CTR_VALREC,');

  If chkDocCom.Checked Then
    pAddSQL('  SUM(IF(IFNULL(COMCAR, 0) = 0, 0, VALCAR)) AS RECCOM,')
  Else
    pAddSQL('  SUM(VALCAR) AS RECCOM,');

  pAddSQL('  0.00  AS CTR_RECIPI,');
  //pAddSQL('  SUM(IFNULL(COMCAR, 0)) AS VALOR_COMISSAO,');
  pAddSQL('  0.00 AS VALOR_COMISSAO,');
  pAddSQL('  0.00 AS CTR_AVISTA,');
  pAddSQL('  0.00 AS CTR_APRAZO,');
  pAddSQL('  0.00 AS VALCHQ,');
  pAddSQL('  0.00 AS VALCAR');
  pAddSQL('FROM');
  pAddSQL('  ('+ fGetSqlCartao +') TAB ');
  pAddSQL('  INNER JOIN CADOPE OP ON OP.OPE_CODOPE = TAB.CODVEN ');
  pAddSQL('GROUP BY');
  pAddSQL('  CODVEN');

  pAddSQL(') AS TAB ');

  pAddSQL('GROUP BY');
  pAddSQL(' CTR_CODVEN');

  If chkDocCom.Checked Then
  Begin
    pAddSQL('HAVING');
    pAddSQL(' (VALOR_COMISSAO <> 0) OR (CTR_VALFAT <> 0) ');
  End;

  pAddSQL(' ORDER BY OPE_NOMOPE ');
end;

procedure TfrmRelComissaoVendedorCTRMod2.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmRelComissaoVendedorCTRMod2.FormCreate(Sender: TObject);
begin
  inherited;
  cbxVenRep.Items.Clear;
  cbxVenRep.Items.Add('1- Vendedor');
  cbxVenRep.Items.Add('2- Representante');
  If fCampoExiste('CADREC','CTR_CODQUI', True) Then
    cbxVenRep.Items.Add('3- Químico');
  If fCampoExiste('CADREC','CTR_CODGER', True) Then
    cbxVenRep.Items.Add('4- Gerente');
  cbxVenRep.ItemIndex := 0;

  qryRelatorio := fCriaQuery;
  qryVendedor  := fCriaQuery;
  qryFaixa     := fCriaQuery;

  cdsRelAnalitico := TUniClientDataSet.Create(Nil);
  cdsRelSintetico := TUniClientDataSet.Create(Nil);
  relRecebido  := TValorRecebido.Create;
  pnlServico.Visible := fCfgSis('USASER', varBoolean);
  blnComissaoPorFaixa:= False;

  if not pnlServico.Visible Then
    TfrmRelComissaoVendedorCTRMod2(Self).Height := TfrmRelComissaoVendedorCTRMod2(Self).Height - pnlServico.Height;

  frxComissaoVendedorSintCTR_M.AddFunction('function fPercent(fltParte, fltTotal: Double): Double');
  frxComissaoVendedorSintCTR_J.AddFunction('function fPercent(fltParte, fltTotal: Double): Double');

  cdsRelAnalitico.FieldDefs.Add('SETOR'         , ftString, 35 );
  cdsRelAnalitico.FieldDefs.Add('NSETOR'        , ftInteger    );
  cdsRelAnalitico.FieldDefs.Add('CTR_CODVEN'    , ftString,  3 );
  cdsRelAnalitico.FieldDefs.Add('VENDEDOR'      , ftString, 100);
  cdsRelAnalitico.FieldDefs.Add('CTR_DTAREC'    , ftDate       );
  cdsRelAnalitico.FieldDefs.Add('CTR_DTACAD'    , ftDate       );
  cdsRelAnalitico.FieldDefs.Add('CTR_NUMDUP'    , ftString, 50 );
  cdsRelAnalitico.FieldDefs.Add('DOCUME'        , ftString, 50 );
  cdsRelAnalitico.FieldDefs.Add('CLIENTE'       , ftString, 100);
  cdsRelAnalitico.FieldDefs.Add('CTR_VALREC'    , ftFloat      );
  cdsRelAnalitico.FieldDefs.Add('CTR_VALJUR'    , ftFloat      );
  cdsRelAnalitico.FieldDefs.Add('CTR_VALDES'    , ftFloat      );
  cdsRelAnalitico.FieldDefs.Add('CTR_RECIPI'    , ftFloat      );
  cdsRelAnalitico.FieldDefs.Add('CTR_RECCOM'    , ftFloat      );
  cdsRelAnalitico.FieldDefs.Add('VALOR_COMISSAO', ftFloat      );
  cdsRelAnalitico.CreateDataSet;
end;

procedure TfrmRelComissaoVendedorCTRMod2.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryVendedor);
  FreeAndNil(qryRelatorio);
  FreeAndNil(qryFaixa);
  FreeAndNil(cdsRelAnalitico);
  FreeAndNil(cdsRelSintetico);
  FreeAndNil(relRecebido);
  
  inherited;
end;

function TfrmRelComissaoVendedorCTRMod2.fConcatConsultasArray(
  arrCons: TConsultasArray): String;
  Var
    intCnt : Integer;
begin
  If Length(arrCons) > 0 Then
  Begin
    Result := '';
    For intCnt := Low(arrCons) to High(arrCons) Do
      Result := Result + arrCons[intCnt].strCodigo + '_';
  End
  Else
    Result := '';
end;

function TfrmRelComissaoVendedorCTRMod2.fGetCampoCodVenCadChq: String;
begin
  Case cbxVenRep.ItemIndex Of
    0: Result := 'CHQ_CODVEN';
    1: Result := 'CHQ_CODREP';
    2: Result := 'CHQ_CODQUI';
    3: Result := 'CHQ_CODGER';
  End;
end;

function TfrmRelComissaoVendedorCTRMod2.fGetCampoCodVenMovCar: String;
begin
  Case cbxVenRep.ItemIndex Of
    0: Result := 'MCA_CODVEN';
    1: Result := 'MCA_CODREP';
    2: Result := 'MCA_CODQUI';
    3: Result := 'MCA_CODGER';
  End;
end;

function TfrmRelComissaoVendedorCTRMod2.fGetPercentualComissaoFaixa(fltFat: Double): Double;
begin
  Result := 0;
  qryFaixa.First;
  While Not qryFaixa.Eof Do
  Begin
    If (fltFat >= qryFaixa.FieldByName('FCT_FATINI').AsFloat) And (fltFat <= qryFaixa.FieldByName('FCT_FATFIN').AsFloat) Then
    Begin
      Result := qryFaixa.FieldByName('FCT_PERCEN').AsFloat;
      Exit;
    End;
    
    qryFaixa.Next;
  End;    
end;

function TfrmRelComissaoVendedorCTRMod2.fGetSqlCartao(blnAnalitico: Boolean = False): String;
  procedure pAddSQL(strSQL: String);
  begin
    Result := Result + IIF(Length(Result) = 0, '', #13#10) + strSQL;
  end;

  Const
    C_IMPOSTO = '( IFNULL(MCA_VALIPI, 0) + IFNULL(MCA_VALRET, 0) + IFNULL(MCA_VALCBS, 0) + IFNULL(MCA_VALIBS, 0) + IFNULL(MCA_VAL_IS, 0) + IFNULL(MCA_VALACE, 0) + IFNULL(MCA_VALFRE, 0) )';
//    C_JUROS   = ' IFNULL((IFNULL(CTR_VALJUR,0) * (IFNULL(MCA_VALREC,0) / IFNULL(CTR_VALREC,0))),0) ';
begin
  Result := '';

  pAddSQL('SELECT');
  pAddSQL('  MOVCAR.AUTOINCREM,');
  pAddSQL('  ' + fGetCampoCodVenMovCar + ' AS CODVEN,');
  pAddSQL('  CONCAT(OPE_CODOPE,"-",OPE_NOMOPE) AS VENDEDOR,');

  If blnAnalitico Then
  Begin
    pAddSQL('   MCA_DTACAD AS DTACAD,');
    pAddSQL('   MCA_DTAREC AS DTAREC,');
    pAddSQL('   CONCAT(CAR_DESCAR,"-",MCA_NUMCCD) AS NUMDUP,');
    pAddSQL('   MCA_DOCUME AS DOCUME,');
    pAddSQL('   CONCAT(CLI_CODCLI,"-", CLI_NOMCLI) AS CLIENTE,');
  End;

  pAddSQL('  MCA_VALSTA AS VALIMP,');

  pAddSQL('  MCA_VALSTA - '+ C_IMPOSTO + ' AS VALCAR,');
  pAddSQL('  (MCA_VALSTA - '+ C_IMPOSTO + ') * ('+IIF(fEhComissaoPorFator('MOVCAR'),'IFNULL('+fRetCampoFator('MOVCAR')+', 0)','IFNULL(OPE_PERCOM, 0) / 100')+') AS COMCAR');

  pAddSQL('FROM');
  pAddSQL('  MOVCAR');
  pAddSQL('  JOIN CADOPE ON OPE_CODOPE = ' + fGetCampoCodVenMovCar + '');

  If blnAnalitico Then
  Begin
    pAddSQL('   JOIN CADCLI ON CLI_CODCLI = MCA_CODCLI ');
    pAddSQL('   JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR');
  End;

  If Not chkConJur.Checked Then
  Begin
  //  pAddSQL(' LEFT JOIN CADREC ON CTR_SEQCON = MCA_SEQCON ');
  //  pAddSQL('                 AND CTR_EMPBAI = MCA_EMPRCX ');
  //  pAddSQL('                 AND CTR_DTAREC = MCA_DTACAD ');
  End;

  pAddSQL('WHERE');
  pAddSQL('  MCA_DTAREC IS NOT NULL AND');
  pAddSQL('  MCA_DTAREC BETWEEN :DTAINI AND :DTAFIM AND');
  pAddSQL('  MCA_DTACAD >= "2009-07-01"');

  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    If rdgRelEmp.ItemIndex = 1 Then
      pAddSQL(fStrLocate(edtCodEmp, arrEmpresa, 'OPE_CODEMP', 'CODEMP'))
    Else
      pAddSQL(fStrLocate(edtCodEmp, arrEmpresa, 'MCA_CODEMP', 'CODEMP'));
  End
  Else
  Begin
    If rdgRelEmp.ItemIndex = 1 Then
      pAddSQL('  AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ')
    Else
      pAddSQL('  AND LOCATE(MCA_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ');
  End;

  If (Not fEmptyStr(edtCodVendedor.Text)) Then
    pAddSQL(fStrLocate(edtCodVendedor, arrOperador, fGetCampoCodVenMovCar, 'CODVEN'));

  Case rdgPosCom.ItemIndex Of
    POSCOM_PENDENTES : pAddSQL('  AND MCA_CTPCOM IS NULL');
    POSCOM_BAIXADAS  : pAddSQL('  AND MCA_CTPCOM IS NOT NULL');
  End;
end;

function TfrmRelComissaoVendedorCTRMod2.fGetSqlCartaoSint: String;
  procedure pAddSQL(strSQL: String);
  begin
    Result := Result + IIF(Length(Result) = 0, '', #13#10) + strSQL;
  end;
begin
  Result := '';

  pAddSQL('SELECT');
  pAddSQL('  CODVEN,');
  pAddSQL('  SUM(COMCAR) AS COMCAR,');
  pAddSQL('  SUM(VALCAR) AS VALCAR,');
  pAddSQL('  SUM(VALIMP) AS VALIMP');
  pAddSQL('FROM');
  pAddSQL('  ('+ fGetSqlCartao +') TAB');
  pAddSQL('GROUP BY');
  pAddSQL('  CODVEN');
end;

function TfrmRelComissaoVendedorCTRMod2.fGetSqlCheque(blnAnalitico: Boolean = False): String;
  procedure pAddSQL(strSQL: String);
  begin
    Result := Result + IIF(Length(Result) = 0, '', #13#10) + strSQL;
  end;

  Const
    C_IMPOSTO = '( IFNULL(CHQ_VALIPI, 0) + IFNULL(CHQ_VALRET, 0) + IFNULL(CHQ_VALCBS, 0) + IFNULL(CHQ_VALIBS, 0) + IFNULL(CHQ_VAL_IS, 0) + IFNULL(CHQ_VALACE, 0) + IFNULL(CHQ_VALFRE, 0) )';
//    C_JUROS   = ' IFNULL((IFNULL(CTR_VALJUR,0) * (IFNULL(CHQ_VALCHQ,0) / IFNULL(CTR_VALREC,0))),0) ';
begin
  Result := '';

  pAddSQL(' SELECT SQL_NO_CACHE');
  pAddSQL('   CADCHQ.AUTOINCREM,');
  pAddSQL('   "CADCHQ" AS TABELA,');
  pAddSQL('   '+ fGetCampoCodVenCadChq +' CODVEN,');
  pAddSQL('   CONCAT(OPE_CODOPE,"-",OPE_NOMOPE) AS VENDEDOR,');

  If blnAnalitico Then
  Begin
    pAddSQL('   CHQ_DTACAD AS DTACAD,');
    pAddSQL('   CAST(IF(CHQ_DTADP2 IS NULL, CHQ_DTADEP, CHQ_DTADP2) AS DATE) AS DTADEP,');
    pAddSQL('   CONCAT(CHQ_CODBCO,"-",CHQ_NUMAGE,"-",CHQ_CONCOR,"-",CHQ_NUMCHQ) AS NUMDUP,');
    pAddSQL('   CONCAT(CLI_CODCLI,"-", CLI_NOMCLI) AS CLIENTE,');
  End;

  pAddSQL('   CHQ_VALCHQ AS VALIMP,');

  pAddSQL('   CHQ_VALCHQ - '+ C_IMPOSTO + ' AS VALCHQ,');
  pAddSQL('   (CHQ_VALCHQ - '+ C_IMPOSTO + ') * ('+IIF(fEhComissaoPorFator('CADCHQ'),'IFNULL('+fRetCampoFator('CADCHQ')+', 0)','IFNULL(OPE_PERCOM, 0) / 100')+') AS COMCHQ');

  pAddSQL(' FROM');
  pAddSQL('   CADCHQ ');
  pAddSQL('   JOIN CADOPE ON OPE_CODOPE = ' + fGetCampoCodVenCadChq + ' ');

  If blnAnalitico Then
    pAddSQL('   JOIN CADCLI ON CLI_CODCLI = CHQ_CODCLI ');

  pAddSQL(' WHERE');
  //pAddSQL('   (NOT ((CHQ_DTADEP IS NULL) OR ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADEV IS NOT NULL)))) AND ');
  pAddSQL('   IF(CHQ_DTADP2 IS NULL, CHQ_DTADEP, CHQ_DTADP2) BETWEEN :DTAINI AND :DTAFIM AND ');
  pAddSQL('   CHQ_DTACAD >= "2009-07-01" AND ');
  pAddSQL('   IFNULL(CHQ_INCCTR, "N") = "N" AND ');
  pAddSQL('   (CHQ_DTADEV IS NULL) ');

  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    If rdgRelEmp.ItemIndex = 1 Then
      pAddSQL(fStrLocate(edtCodEmp, arrEmpresa, 'OPE_CODEMP', 'CODEMP'))
    Else
      pAddSQL(fStrLocate(edtCodEmp, arrEmpresa, 'CHQ_CODEMP', 'CODEMP'));
  End
  Else
  Begin
    If rdgRelEmp.ItemIndex = 1 Then
      pAddSQL(' AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ')
    Else
      pAddSQL(' AND LOCATE(CHQ_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ');
  End;

  If (Not fEmptyStr(edtCodVendedor.Text)) Then
    pAddSQL(fStrLocate(edtCodVendedor, arrOperador, fGetCampoCodVenCadChq, 'CODVEN'));

  Case rdgPosCom.ItemIndex Of
    POSCOM_PENDENTES : pAddSQL('  AND CHQ_CTPCOM IS NULL');
    POSCOM_BAIXADAS  : pAddSQL('  AND CHQ_CTPCOM IS NOT NULL');
  End;

end;

function TfrmRelComissaoVendedorCTRMod2.fGetSqlChequeSint: String;
  procedure pAddSQL(strSQL: String);
  begin
    Result := Result + IIF(Length(Result) = 0, '', #13#10) + strSQL;
  end;
begin
  Result := '';

  pAddSQL('SELECT');
  pAddSQL('  CODVEN,');
  pAddSQL('  SUM(COMCHQ) AS COMCHQ,');
  pAddSQL('  SUM(VALCHQ) AS VALCHQ,');
  pAddSQL('  SUM(VALIMP) AS VALIMP');
  pAddSQL('FROM');
  pAddSQL('  ('+ fGetSqlCheque +') TAB');
  pAddSQL('GROUP BY');
  pAddSQL('  CODVEN');
end;

procedure TfrmRelComissaoVendedorCTRMod2.pHabilitaOpcoesPDF;
begin
  chkEjeVen.Enabled := (rdgTipRel.ItemIndex = 0) And (Not chkPDFVen.Checked);
  If (Not chkEjeVen.Enabled) Then
    chkEjeVen.Checked := False;

  chkPDFVen.Enabled := (rdgTipRel.ItemIndex = 0);
  If (Not chkPDFVen.Enabled) Then
    chkPDFVen.Checked := False;

  fraDirPDF.Enabled := (rdgTipRel.ItemIndex = 0) And (chkPDFVen.Checked);
  If (Not fraDirPDF.Enabled) Then
    fraDirPDF.edtDirectory.Clear;
end;

procedure TfrmRelComissaoVendedorCTRMod2.pExportarPDFParaCadaVendedor(qckRel: TfrxReport);
  Var
    stlVend : TStringList;
    intCnt : Integer;
begin
  stlVend := TStringList.Create;
  Try
    frxRelatorio.DataSet.First;
    While Not frxRelatorio.DataSet.Eof Do
    Begin
      If stlVend.IndexOF(frxRelatorio.DataSet.FieldByName('CTR_CODVEN').AsString) < 0 Then
        stlVend.Add(frxRelatorio.DataSet.FieldByName('CTR_CODVEN').AsString);
      frxRelatorio.DataSet.Next;
    End;

    frxExpPDF.DefaultPath := fraDirPDF.edtDirectory.text + '\';
    frxExpPDF.ShowDialog := False;
    frxExpPDF.ShowProgress := False;
    frxExpPDF.OverwritePrompt := False;

    prbProgresso.Max := stlVend.Count;
    prbProgresso.Position := 0;
    Application.ProcessMessages;

    For intCnt := 0 To stlVend.Count-1 Do
    Begin
      prbProgresso.StepBy(1);
      Application.ProcessMessages;

      frxRelatorio.DataSet.Filter := 'CTR_CODVEN = ' + QuotedStr(stlVend.Strings[intCnt]);
      frxRelatorio.DataSet.Filtered := True;
      Try
        frxExpPDF.FileName := stlVend.Strings[intCnt] + '.pdf';
        If (qckRel.PrepareReport()) Then
          qckRel.Export(frxExpPDF);
      Finally
        frxRelatorio.DataSet.Filtered := False;
        frxRelatorio.DataSet.Filter := '';
      End;
    End;

    fMensagem('ATENÇÃO', 'Exportação para PDF concluída!' + sLineBreak +
                         frxExpPDF.DefaultPath, ['&Ok']);
    prbProgresso.Position := 0;
  Finally
    FreeAndNil(stlVend);
  End;
end;

end.

