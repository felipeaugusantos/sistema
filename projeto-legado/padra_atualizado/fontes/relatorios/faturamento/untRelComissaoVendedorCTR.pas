unit untRelComissaoVendedorCTR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, untTypesSistema,
  RLFilters, RLDraftFilter, Menus, StdCtrls, EditFocus, QColorLabel,
  ExtCtrls, Buttons, Mask, MaskEditFocus, Uni, StrUtils, AppEvnts,
  UniDataSetProvider, DB, UniClientDataSet, untRelValorRecebido, ComboBoxFocus, Math,
  BitBtnLockedIncrem, untFuncoesSimples, Datasnap.Provider,
  frxExportCSVTestabilidade, Datasnap.DBClient, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, DirectoryEditFocus, Vcl.ComCtrls, untGravando,
  cxProgressBar, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmRelComissaoVendedorCTR = class(TfrmPaiRelatorio)
    frxComissaoVendedorCTR_M: TfrxReport;
    frxCabecalho: TfrxUserDataSet;
    frxComissaoVendedorCTR_J: TfrxReport;
    rdgTipRel: TRadioGroup;
    frxComissaoVendedorSintCTR_M: TfrxReport;
    frxComissaoVendedorSintCTR_J: TfrxReport;
    rdgTpVendRep: TRadioGroup;
    rdgPerCom: TRadioGroup;
    rdgComRes: TRadioGroup;
    frxComissaoVendedorCTRP_J: TfrxReport;
    frxComissaoVendedorCTRP_M: TfrxReport;
    grbRecibo: TGroupBox;
    Label5: TLabel;
    edtHisRec: TEditFocus;
    Label6: TLabel;
    mskDtaRec: TMaskEditFocus;
    Label7: TLabel;
    edtQtdVia: TEditFocus;
    frxUser: TfrxUserDataSet;
    chkConJur: TCheckBox;
    cdsRelatorio: TUniClientDataSet;
    dspRelatorio: TUniDataSetProvider;
    chkResumo: TCheckBox;
    frxResumo: TfrxDBDataset;
    rdgStatus: TRadioGroup;
    chkQueGer: TCheckBox;
    pnlServico: TPanel;
    rdgServicos: TRadioGroup;
    rdgPosCom: TRadioGroup;
    pnlFiltros: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblVendedor: TLabel;
    shpVen: TShape;
    lblOpcVen: TLabel;
    lblDepartamento: TLabel;
    lbl1: TLabel;
    shpGer: TShape;
    lbl2: TLabel;
    lbl3: TLabel;
    Label4: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    rdgRelEmp: TRadioGroup;
    cbxVenRep: TComboBoxFocus;
    edtCodDep: TEditFocus;
    edtDesDep: TEditFocus;
    edtCodGerente: TEditFocus;
    edtDesGerente: TEditFocus;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    edtCliExc: TEditFocus;
    edtDesExc: TEditFocus;
    mskDtaCor: TMaskEditFocus;
    pnlGerCom: TPanel;
    gpbGravaComi: TGroupBox;
    chkGraCom: TCheckBox;
    mskDtaVen: TMaskEditFocus;
    chkDocCom: TCheckBox;
    shpDocCom: TShape;
    chkItens: TCheckBox;
    frxComissaoVendedorItensCTR_J: TfrxReport;
    frxComissaoVendedorItensCTRP_J: TfrxReport;
    frxComissaoVendedorItensCTRP_M: TfrxReport;
    frxComissaoVendedorItensCTR_M: TfrxReport;
    frxDBDupPen: TfrxDBDataset;
    frxDupPen: TfrxReport;
    btnDupPen: TBitBtnLocked;
    pnlPDF: TPanel;
    chkEjeVen: TCheckBox;
    chkPDFVen: TCheckBox;
    fraDirPDF: TfraDirectoryEditFocus;
    prbProgresso: TProgressBar;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure frxCabecalhoGetValue(const VarName: String;
      var Value: Variant);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxVenRepChange(Sender: TObject);
    procedure rdgTipRelClick(Sender: TObject);
    procedure frxUserGetValue(const VarName: String; var Value: Variant);
    procedure frxUserFirst(Sender: TObject);
    procedure frxUserNext(Sender: TObject);
    procedure frxUserCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxUserPrior(Sender: TObject);
    function frxComissaoVendedorCTR_MUserFunction(const MethodName: String;
      var Params: Variant): Variant;
    procedure mskDtaFinExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure edtCodGerenteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCliExcExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCliExcKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure chkGraComClick(Sender: TObject);
    procedure edtCodGerenteExit(Sender: TObject);
    procedure edtCodVendedorExit(Sender: TObject);
    procedure chkItensClick(Sender: TObject);
    procedure btnDupPenClick(Sender: TObject);
    procedure rdgComResClick(Sender: TObject);
    procedure chkPDFVenClick(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strDesTip: String;
    frxRel: TfrxReport;
    strValRec: String;
    intQtdVia: Integer;

    qryVendedor   : TUniQuery;
    qryRelatorio  : TUniQuery;
    qryResumo     : TUniQuery;
    relRecebido   : TValorRecebido;

    blnLibVen: Boolean;
    blnLibGer: Boolean;

    strCodVen  : String;
    strCodGer  : String;
    strCodDep  : String;
    strCodCli  : String;
    strCliExc  : String;
    strTipVen  : String;

    strPerComAna: String;
    strValComAna: String;

    strPerComVenAna: String;
    strValComVenAna: String;

    strPerComTotAna: String;
    strValComTotAna: String;

    strPerComVenSin: String;
    strValComVenSin: String;

    strPerComGer: String;
    strValComGer: String;

    strPerCo2VenSin: String;
    strPerCo2TotSin: String;

    strPerComTotSin: String;
    strValComTotSin: String;

    arrEmp     : TConsultasArray;
    arrOperador: TConsultasArray;
    arrGerente : TConsultasArray;
    arrDepart  : TConsultasArray;
    arrCliente : TConsultasArray;
    arrCliExc  : TConsultasArray;

    strEmp     : String;

    fltPmCmCr: Double;

    cdsResumoMod : TUniClientDataSet;

    strDtaCad_Ini,
    strDtaCad_Fin,
    strDtaVen_Ini,
    strDtaVen_Fin: String;

    function fGetSQLTotalAberto(strAnaSin: String = 'S'): String;
    function fGetSqlAberto(strAnaSin: String = 'S'): String;
    function fGetSqlMovDet: String;
    function fGetSQLSintetico(strSQLAnalitico: String): String;
    function fGetSqlSinteticoMovDet(strAnalitico: String): String;

    Procedure pSetaPeriodoRecibo;

    procedure pAjustaPercentualDeComissao;

    Procedure pSetaOperadorSintetico;
    Procedure pSetaOperadorAnalitico;
    function fVistaPrazo(blnParaClasulaWhere:Boolean=False): String;
    function fFrxCom(blnParaClasulaWhere:Boolean=False): String;

    Procedure pSetaPadraoSintetico;
    Procedure pSetaPadraoAnalitico;

    procedure pMontaResumoModalidades(qryAnalitico: TUniQuery);

    procedure pSetaParametros(qryRel: TUniQuery);

    procedure pGravaComissao(strSQL: String);

    function fGetClienteDuplicata(strDuplic, strTabela: String): String;
    procedure pInicializaStringCamposTotalizadores;
    procedure pSetarDadosValorRecebido;
    procedure pSetaVariaveisRelatorio(frxRel: TfrxReport);
    procedure pExportarPDFParaCadaVendedor(qckRel: TfrxReport);
    procedure pHabilitaOpcoesPDF;
    function fRetSQLQtdPar(): String;
    function fRetSQLDupMod(): String;
    function fImprimeDupPen(pgbStatus: TcxProgressBar = Nil): Boolean;

  public
    { Public declarations }
    strEmpresa,
    strVendedor,
    strPeriodo: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

const
  VEN_TODOS           = 0;
  VEN_INTERNO         = 1;
  VEN_EXTERNO_LOJA    = 2;
  VEN_EXTERNO_DISTRIB = 3;
  
  TIPREL_ANALITICO = 0;
  TIPREL_SINTETICO = 1;

  POSCOM_TODAS = 0;
  POSCOM_PENDENTES = 1;
  POSCOM_BAIXADAS = 2;

implementation

uses  untConsultas,
      untValorPorExtenso, untFuncoesConsulta, untCfgRel,
      untConstantes, untTGravaComissaoVen, untPeriodoDupPendentes;

{$R *.dfm}

var
  {*******************************************************************************************}
  {* FOI ADICIONADO VENDEDOR NOVAMENTE NO ARRAY arrVenRep, POIS QUANDO O USUÁRIO SELECIONAVA *}
  {* A OPÇÃO Vendedor (CadCli) ESTAVA VINDO O TITULO DO RELATÓRIO COMO DINHEIRO.             *}
  {*****************************************************************************************FC}
  arrVenRep: Array[0..5] Of String[20] = ('VENDEDOR', 'REPRESENTANTE', 'SUPERVISOR GERAL', 'SUPERVISOR REGIONAL', 'VENDEDOR', 'DIGITADOR');
  arrModalidade: Array[0..4] Of String[20] = ('DINHEIRO', 'CHEQUE','CARTAO', 'ORDEM', 'FINANCEIRO');

procedure TfrmRelComissaoVendedorCTR.edtCliExcExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCliExc.Text) Then
     edtDesExc.Text := 'NENHUM'
  Else
     pEdtCodSelectExit(edtCliExc, edtDesExc, arrCliExc, Nil, fRetNomCliente, 'do cliente a excluir');
end;

procedure TfrmRelComissaoVendedorCTR.edtCliExcKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCliExc, edtDesExc, Nil, Key, arrCliExc, False) Then
  Begin
    If fValidaCampos(edtCliExc, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoVendedorCTR.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCli, arrCliente, Nil, fRetNomCliente, 'do cliente');
end;

procedure TfrmRelComissaoVendedorCTR.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoVendedorCTR.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesDep, arrDepart, fRetDescDepartamento, Nil, 'do departamento');
end;

procedure TfrmRelComissaoVendedorCTR.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqDepartamento(Self, edtCodDep, edtDesDep, Nil, Key, arrDepart, False) Then
  Begin
    If fValidaCampos(edtCodDep, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelComissaoVendedorCTR.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmpresa, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelComissaoVendedorCTR.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelComissaoVendedorCTR.edtCodGerenteExit(Sender: TObject);
begin
  inherited;

  If (blnLibGer) Then
    pEdtCodSelectExit(edtCodGerente, edtDesGerente, arrGerente, fRetNomVendRep, nil, 'do gerente');
  fValidaCampos(edtCodGerente, True);
end;

procedure TfrmRelComissaoVendedorCTR.edtCodGerenteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (blnLibGer) Then
  Begin
    If (fPesqOperador(Self, edtCodGerente, edtDesGerente, nil, Key, arrGerente, False, True, True)) Then
    Begin
      If fValidaCampos(edtCodGerente, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmRelComissaoVendedorCTR.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
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

  End

  Else If (Sender = edtCodVendedor) Then
  Begin
    Result := fValidaGerSubVen(blnLibVen, 'V', edtCodVendedor, edtDesVendedor, IIF(fCfgSis('VENMET') = '1', 'Vendedor', 'Representante'));
  End

  Else If (Sender = edtCodGerente) Then
  Begin
    Result := fValidaGerSubVen(blnLibGer, 'G', edtCodGerente, edtDesGerente);
  End

  Else If (Sender = edtCodEmp) Then
  Begin

    If (Not fEmptyStr(edtCodEmp.Text)) and (edtCodEmp.Text <> '000') Then
    Begin
      If fEmptyStr(fRetNomeEmpresaSelec(edtCodEmp.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Código da empresa não encontrado!', ['&O k']);
        Result := False;
      End

      Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtHisRec) And grbRecibo.Enabled Then
  Begin

    If fEmptyStr(edtHisRec.Text) Then
    Begin
      fMensagem('', 'O campo Histórico deve ser preenchido!', ['&O k']);
      Result := False;
    End;

  End

  Else If (Sender = mskDtaRec) And grbRecibo.Enabled Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaRec.Text)) Then
    Begin
      fMensagem('', 'O campo Data do Recibo deve ser preenchido!', ['&O k']);
      Result := False;
    End

  End

  Else If (Sender = edtQtdVia) And grbRecibo.Enabled Then
  Begin

    If StrToIntDef(edtQtdVia.Text, 0) <= 0 Then
    Begin
      fMensagem('', 'A quantidade de vias deve ser maior que zero!', ['&O k']);
      Result := False;
    End

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

  Else If (Sender = fraPlanoDeContas.MskCodCta) Then
  Begin
    If (fraPlanoDeContas.MskCodCta.Enabled) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Plano de Contas deve ser preenchido!', ['&O k']);
        Result := False;
      End
      
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Text := fRetNomeConta(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text));

        If fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Plano de Contas não encontrado!', ['&O k']);
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
        fMensagem('ATENÇÃO!', 'Data de vencimento deve ser preenchida!', ['&O k']);
      End

      Else If StrToDateDef(mskDtaVen.Text, 0) = 0 Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Digite uma data válida!', ['&O k']);
      End
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelComissaoVendedorCTR.edtCodVendedorExit(Sender: TObject);
begin
  inherited;

  If (blnLibVen) Then
    pEdtCodSelectExit(edtCodVendedor, edtDesVendedor, arrOperador, fRetNomVendRep, Nil, 'do vendedor');
  fValidaCampos(edtCodVendedor, True);
end;

procedure TfrmRelComissaoVendedorCTR.edtCodVendedorKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;

  If (blnLibVen) And
     (fPesqOperador(Self, edtCodVendedor, edtDesVendedor, qryVendedor, Key, arrOperador, False, False, False)) Then
  Begin
    If fValidaCampos(edtCodVendedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

Function TfrmRelComissaoVendedorCTR.fGetSQLSintetico(strSQLAnalitico: String): String;
Begin
  Result :=          ' SELECT SQL_NO_CACHE                       ';
  Result := Result + '  CTR_CODVEN,                              ';
  Result := Result + '   OPE_NOMOPE,                             ';
  Result := Result + '   IFNULL(OPE_PERCOM,0) AS OPE_PERCOM,     ';
  Result := Result + '   IFNULL(OPE_PERCO2,0) AS OPE_PERCO2,     ';
  Result := Result + '   OPE_INTEXT,                             ';
  Result := Result + '   0 AS CTR_VALFAT,                        ';
  Result := Result + '   VENDEDOR,                               ';
  Result := Result + '   0               AS CTR_ABERTO,          ';
  Result := Result + '   SUM(CTR_VALORI) AS CTR_VALORI,          ';
  Result := Result + '   SUM(CTR_VALJUR) AS CTR_VALJUR,          ';
  Result := Result + '   SUM(CTR_JURVIS) AS CTR_JURVIS,          ';
  Result := Result + '   SUM(CTR_JURPRA) AS CTR_JURPRA,          ';
  Result := Result + '   SUM(CTR_VALDES) AS CTR_VALDES,          ';
  Result := Result + '   SUM(CTR_VALREC) AS CTR_VALREC,          ';
  Result := Result + '   SUM(CTR_RECCOM) AS CTR_RECCOM,          ';
  Result := Result + '   SUM(CTR_RECIPI) AS CTR_RECIPI,          ';
  Result := Result + '   SUM(VLCOM_OPEAVI)   AS VLCOM_OPEAVI,    ';
  Result := Result + '   SUM(VLCOM_OPEAPR)   AS VLCOM_OPEAPR,    ';
  Result := Result + '   SUM(VALOR_COMISSAO) AS VALOR_COMISSAO,  ';
  Result := Result + '   SUM(CTR_AVISTA) AS CTR_AVISTA,          ';
  Result := Result + '   SUM(CTR_APRAZO) AS CTR_APRAZO,          ';
  Result := Result + '   SUM(CTR_AVISTA_LIQ) AS CTR_AVISTA_LIQ,  ';
  Result := Result + '   SUM(CTR_APRAZO_LIQ) AS CTR_APRAZO_LIQ   ';
  Result := Result + ' FROM  (' + strSQLAnalitico + ') AS TABELA ';

  If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
    Result := Result + ' WHERE OPE_INTEXT = :INTEXT ';

  Result := Result + ' GROUP BY CTR_CODVEN ';
End;

Function TfrmRelComissaoVendedorCTR.fGetSqlTotalAberto(strAnaSin: String = 'S'): String;
  Var
    strSQL,
    strSum: String;
Begin
  strSQL := fGetSqlAberto(strAnaSin);

  strSum := '';
  strSum := strSum + ' SELECT SQL_NO_CACHE              ';
  strSum := strSum + '   CTR_CODVEN,                    ';
  strSum := strSum + '   OPE_NOMOPE,                    ';
  strSum := strSum + '   OPE_PERCOM,                    ';
  strSum := strSum + '   OPE_PERCO2,                    ';
  strSum := strSum + '   OPE_INTEXT,                    ';
  strSum := strSum + '   0 AS CTR_VALFAT,               ';
  strSum := strSum + '   VENDEDOR,                      ';
  strSum := strSum + '   SUM(CTR_ABERTO) AS CTR_ABERTO, ';
  strSum := strSum + '   0 AS CTR_VALORI,               ';
  strSum := strSum + '   0 AS CTR_VALJUR,               ';
  strSum := strSum + '   0 AS CTR_JURVIS,               ';
  strSum := strSum + '   0 AS CTR_JURPRA,               ';
  strSum := strSum + '   0 AS CTR_VALDES,               ';
  strSum := strSum + '   0 AS CTR_VALREC,               ';
  strSum := strSum + '   0 AS CTR_RECCOM,               ';
  strSum := strSum + '   0 AS CTR_RECIPI,               ';
  strSum := strSum + '   0 AS VLCOM_OPEAVI,             ';
  strSum := strSum + '   0 AS VLCOM_OPEAPR,             ';
  strSum := strSum + '   0 AS VALOR_COMISSAO,           ';
  strSum := strSum + '   0 AS CTR_AVISTA,               ';
  strSum := strSum + '   0 AS CTR_APRAZO,               ';
  strSum := strSum + '   0 AS CTR_AVISTA_LIQ,           ';
  strSum := strSum + '   0 AS CTR_APRAZO_LIQ            ';
  strSum := strSum + ' FROM (' + strSQL + ') AS TABABE ';

  If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
    strSum := strSum + ' WHERE OPE_INTEXT = :INTEXT ';

  strSum := strSum + ' GROUP BY CTR_CODVEN ';

  Result := strSum;

End;

function TfrmRelComissaoVendedorCTR.fImprimeDupPen(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    qryDupPen : TUniQuery;
    strSQL : String;
begin
  Result := True;

  pInformacao('Aguarde, Gerando o Relatório...', pgbStatus);
  pProgresso(1, 3, pgbStatus);
  pSetarDadosValorRecebido;

  qryDupPen := fCriaQuery(Self);
  Try

    strSQL :=  'SELECT TAB2.*, ';

    strSQL := strSQL +  ' IF(DUPMOD = "FAT", VALDUP, 0.00) AS VALFAT,  ';
    strSQL := strSQL +  ' IF(DUPMOD = "CHQ", VALDUP, 0.00) AS VALCHQ,  ';
    strSQL := strSQL +  ' IF(DUPMOD = "CAR", VALDUP, 0.00) AS VALCAR,   ';

    strSQL := strSQL +  ' IF(DUPMOD = "FAT", PREVCO, 0.00) AS COMFAT,  ';
    strSQL := strSQL +  ' IF(DUPMOD = "CHQ", PREVCO, 0.00) AS COMCHQ,  ';
    strSQL := strSQL +  ' IF(DUPMOD = "CAR", PREVCO, 0.00) AS COMCAR   ';

    strSQL := strSQL +  ' FROM ( ';

    strSQL := strSQL +  ' SELECT TAB1.*, ';

    strSQL := strSQL +  fRetSQLQtdPar()   + ' AS DUPPAR, ';
    strSQL := strSQL +  fRetSQLDupMod()   + ' AS DUPMOD, ';

    If rdgPerCom.ItemIndex = 0 Then
      strSQL := strSQL + ' VALOR_COMISSAO AS PREVCO '
    Else
      strSQL := strSQL + ' VLCOM_OPEAVI+VLCOM_OPEAPR AS PREVCO ';

    strSQL := strSQL + ' FROM ('+ fGetSqlAberto('A') +') TAB1 WHERE TRUE ' ;

    If chkGraCom.Checked Or chkDocCom.Checked Then
    Begin
      If rdgPerCom.ItemIndex = 0 Then
        strSQL := strSQL + ' AND ROUND(VALOR_COMISSAO, 2) <> 0 '
      Else
        strSQL := strSQL + ' AND ROUND(VLCOM_OPEAVI+VLCOM_OPEAPR, 2) <> 0 ';
    End;

    If Not(fEmptyStr(fTiraCaracEspeciais(strDtaCad_Ini))) Then
       strSQL := strSQL + ' AND DTACAD >= :DTACAD_INI ';

    If Not(fEmptyStr(fTiraCaracEspeciais(strDtaCad_Fin))) Then
       strSQL := strSQL + ' AND DTACAD <= :DTACAD_FIN ';

    If Not(fEmptyStr(fTiraCaracEspeciais(strDtaVen_Ini))) Then
       strSQL := strSQL + ' AND DTAVEN >= :DTAVEN_INI ';

    If Not(fEmptyStr(fTiraCaracEspeciais(strDtaVen_Fin))) Then
       strSQL := strSQL + ' AND DTAVEN <= :DTAVEN_FIN ';

    strSQL := strSQL + ' ORDER BY NOMVEN, CODVEN, DUPMOD, DTACAD ';

    strSQL := strSQL + ' ) AS TAB2 ';

    strSQL := strSQL + ' ORDER BY NOMVEN, CODVEN, DUPMOD, DTACAD ';

    With qryDupPen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add( strSQL );
      pSetaParametros(qryDupPen);

      If Not(fEmptyStr(fTiraCaracEspeciais(strDtaCad_Ini))) Then
        ParamByName('DTACAD_INI').AsDateTime := StrToDate(strDtaCad_Ini);

      If Not(fEmptyStr(fTiraCaracEspeciais(strDtaCad_Fin))) Then
        ParamByName('DTACAD_FIN').AsDateTime := StrToDate(strDtaCad_Fin);

      If Not(fEmptyStr(fTiraCaracEspeciais(strDtaVen_Ini))) Then
        ParamByName('DTAVEN_INI').AsDateTime := StrToDate(strDtaVen_Ini);

      If Not(fEmptyStr(fTiraCaracEspeciais(strDtaVen_Fin))) Then
        ParamByName('DTAVEN_FIN').AsDateTime := StrToDate(strDtaVen_Fin);

      Open;

      pProgresso(2, 3, pgbStatus);
      frxDupPen.Script.Variables['VALFAT'] := FormatFloat('##,#0.00', FieldByName('VALFAT').AsFloat);
      frxDupPen.Script.Variables['VALCHQ'] := FormatFloat('##,#0.00', FieldByName('VALCHQ').AsFloat);
      frxDupPen.Script.Variables['VALCAR'] := FormatFloat('##,#0.00', FieldByName('VALCAR').AsFloat);

      If (Not IsEmpty) Then
      Begin
        frxDBDupPen.DataSet := qryDupPen;

        frxDupPen.PrintOptions.Printer := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

        Sleep(500);
        pProgresso(3, 3, pgbStatus);
        pSetaVariaveisRelatorio(frxDupPen);

        If edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, frxDupPen)
        Else
        Begin
          If frxDupPen.PrepareReport Then
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxDupPen);
        End;
      End
      Else
        fMensagem('Informação', 'Não há dados para gerar o relatório!', ['&OK']);
    End;
  Finally
    FreeAndNil(qryDupPen);
  End;

end;

Procedure TfrmRelComissaoVendedorCTR.pSetaOperadorSintetico;

  function fCampoStrValAVista: String;
  begin
    Result := 'CTR_AVISTA';
    If (rdgPerCom.ItemIndex = 1) Then
      Result := 'CTR_AVISTA_LIQ';
  end;

  function fCampoStrValAPrazo: String;
  begin
    Result := 'CTR_APRAZO';
    If (rdgPerCom.ItemIndex = 1) Then
      Result := 'CTR_APRAZO_LIQ';
  end;

Begin
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[IIF(<frxRelatorio."'+fCampoStrValAVista+'"> <> 0,<frxRelatorio."OPE_PERCOM">,0)]');

  TfrxMemoView(frxRel.FindObject('rllPerCo2Ven')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Ven')).Memo.Add('[IIF(<frxRelatorio."'+fCampoStrValAPrazo+'"> <> 0,<frxRelatorio."OPE_PERCO2">,0)]');

  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add('[(((<frxRelatorio."'+fCampoStrValAVista+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURVIS">')+') * <frxRelatorio."OPE_PERCOM">)/100) + (((<frxRelatorio."'+fCampoStrValAPrazo+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURPRA">')+') * <frxRelatorio."OPE_PERCO2">)/100)]');

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[IIF(SUM(<frxRelatorio."'+fCampoStrValAVista+'">) <> 0, (SUM((((<frxRelatorio."'+fCampoStrValAVista+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURVIS">')+') * <frxRelatorio."OPE_PERCOM">)/100)) / SUM(<frxRelatorio."'+fCampoStrValAVista+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURVIS">')+') ) * 100, 0)]');
  TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Add('[IIF(SUM(<frxRelatorio."'+fCampoStrValAVista+'">) <> 0, (SUM((((<frxRelatorio."'+fCampoStrValAVista+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURVIS">')+') * <frxRelatorio."OPE_PERCOM">)/100)) / SUM(<frxRelatorio."'+fCampoStrValAVista+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURVIS">')+') ) * 100, 0)]');

  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot2')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Memo.Add('[IIF(SUM(<frxRelatorio."'+fCampoStrValAPrazo+'">) <> 0, (SUM((((<frxRelatorio."'+fCampoStrValAPrazo+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURPRA">')+') * <frxRelatorio."OPE_PERCO2">)/100)) / SUM(<frxRelatorio."'+fCampoStrValAPrazo+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURPRA">')+') ) * 100, 0)]');
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot2')).Memo.Add('[IIF(SUM(<frxRelatorio."'+fCampoStrValAPrazo+'">) <> 0, (SUM((((<frxRelatorio."'+fCampoStrValAPrazo+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURPRA">')+') * <frxRelatorio."OPE_PERCO2">)/100)) / SUM(<frxRelatorio."'+fCampoStrValAPrazo+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURPRA">')+') ) * 100, 0)]');

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add('[SUM((((<frxRelatorio."'+fCampoStrValAVista+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURVIS">')+') * <frxRelatorio."OPE_PERCOM">)/100) + (((<frxRelatorio."'+fCampoStrValAPrazo+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURPRA">')+') * <frxRelatorio."OPE_PERCO2">)/100))]');

  TfrxMemoView(frxRel.FindObject('rllValComTot2')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot2')).Memo.Add('[SUM((((<frxRelatorio."'+fCampoStrValAVista+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURVIS">')+') * <frxRelatorio."OPE_PERCOM">)/100) + (((<frxRelatorio."'+fCampoStrValAPrazo+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_JURPRA">')+') * <frxRelatorio."OPE_PERCO2">)/100))]');

  {**********************************************}
  {* COMISSÃO E VALORES RELACIONADOS AO GERENTE *}
  {*******************************************MM*}
  if (chkQueGer.Checked) then
  Begin
    TfrxMemoView(frxRel.FindObject('rllValComGer')).Memo.Clear;
    TfrxMemoView(frxRel.FindObject('rllValComGer')).Memo.Add('[((SUM(<frxRelatorio."'+fCampoStrValAVista+'">) * <frxRelatorio."PERGER">)/100) + ((SUM(<frxRelatorio."'+fCampoStrValAPrazo+'">) * <frxRelatorio."PERGER">)/100)]');

    TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Clear;
    If relRecebido.blnConJur Then
      TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Add('[IIF(SUM(<frxRelatorio."'+fCampoStrValAVista+'">) <> 0, (SUM(((<frxRelatorio."'+fCampoStrValAVista+'"> * <frxRelatorio."PERGER">)/100)) / SUM(<frxRelatorio."'+fCampoStrValAVista+'">) ) * 100, 0)]')
    Else
      TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Add('[IIF(SUM(<frxRelatorio."'+fCampoStrValAVista+'">) <> 0, (SUM(((<frxRelatorio."'+fCampoStrValAVista+'"> * <frxRelatorio."PERGER">)/100) - <frxRelatorio."CTR_JURVIS">) / SUM(<frxRelatorio."'+fCampoStrValAVista+'">) ) * 100, 0)]');
  End;
End;

function TfrmRelComissaoVendedorCTR.fVistaPrazo(blnParaClasulaWhere:Boolean=False): String;
begin
  Result := 'IIF(<frxRelatorio."CTR_FORMAPG"> = ' + #39 + 'A' + #39 + ', <frxRelatorio."OPE_PERCOM">, <frxRelatorio."OPE_PERCO2">)';
  If blnParaClasulaWhere Then
    Result := ' IF(CTR_FORMAPG = "A", OPE_PERCOM, OPE_PERCO2) ';
end;

function TfrmRelComissaoVendedorCTR.fFrxCom(blnParaClasulaWhere:Boolean=False): String;

  function fCampoStrValRec: String;
  begin
    Result := 'CTR_VALREC';
    If (rdgPerCom.ItemIndex = 1) Then
      Result := 'CTR_RECIPI';
  end;
  
begin
  If relRecebido.blnConJur Then
  Begin
    Result := '(' + fVistaPrazo(blnParaClasulaWhere) + ' * <frxRelatorio."'+fCampoStrValRec+'">) / 100';
    If blnParaClasulaWhere Then
      Result := ' ((' + fVistaPrazo(blnParaClasulaWhere) + ' * '+fCampoStrValRec+') / 100) ';
  End
  Else
  Begin
    Result := '(' + fVistaPrazo(blnParaClasulaWhere) + ' * (<frxRelatorio."'+fCampoStrValRec+'"> - <frxRelatorio."CTR_VALJUR">)) / 100';
    If blnParaClasulaWhere Then
      Result := ' ((' + fVistaPrazo(blnParaClasulaWhere) + ' * ('+fCampoStrValRec+' - CTR_VALJUR)) / 100) '
  End;
end;

Procedure TfrmRelComissaoVendedorCTR.pSetaOperadorAnalitico;

  function fCampoStrValRec: String;
  begin
    Result := 'CTR_VALREC';
    If (rdgPerCom.ItemIndex = 1) Then
      Result := 'CTR_RECIPI';
  end;
  
Begin
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Add('['+ fVistaPrazo +']');

  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Add('[' + fFrxCom + ']');

  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."'+fCampoStrValRec+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_VALJUR">')+') * 100]');

  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add('[SUM(' + fFrxCom + ')]');

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."'+fCampoStrValRec+'">'+IIF(relRecebido.blnConJur,'','-<frxRelatorio."CTR_VALJUR">')+') * 100]');

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add('[SUM(' + fFrxCom + ')]');

//  If (Not chkItens.Checked) Then Begin
//    If relRecebido.blnConJur Then
//      TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC">) * 100]')
//    Else
//      TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">) * 100]');
//
//    TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
//    TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add('[SUM(' + fFrxCom + ')]');
//
//    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
//    If relRecebido.blnConJur Then
//      TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC">) * 100]')
//    Else
//      TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[SUM(' + fFrxCom + ') / SUM(<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">) * 100]');
//
//    TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
//    TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add('[' + fFrxCom + ']');
//  End Else Begin
//    If relRecebido.blnConJur Then
//      TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[' + fFrxCom + ' / <frxRelatorio."CTR_VALREC"> * 100]')
//    Else
//      TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add('[' + fFrxCom + ' / (<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">) * 100]');
//
//    TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
//    TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add('[' + fFrxCom + ']');
//
//    TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
//    If relRecebido.blnConJur Then
//      TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[' + fFrxCom + ' / <frxRelatorio."CTR_VALREC"> * 100]')
//    Else
//      TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add('[' + fFrxCom + ' / (<frxRelatorio."CTR_VALREC"> - <frxRelatorio."CTR_VALJUR">) * 100]');
//
//    TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
//    TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add('[' + fFrxCom + ']');
//  End;
End;

Procedure TfrmRelComissaoVendedorCTR.pSetaPadraoSintetico;
Begin
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tit')).Visible := False;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Ven')).Visible := False;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot')).Visible := False;
  TfrxMemoView(frxRel.FindObject('rllPerCo2Tot2')).Visible := False;

  {**********************************************}
  {* COMISSÃO E VALORES RELACIONADOS AO GERENTE *}
  {*******************************************MM*}
  if (chkQueGer.Checked) then
  Begin
    TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Clear;
    TfrxMemoView(frxRel.FindObject('rllPerComGer')).Memo.Add(strPerComGer);

    TfrxMemoView(frxRel.FindObject('rllValComGer')).Memo.Clear;
    TfrxMemoView(frxRel.FindObject('rllValComGer')).Memo.Add(strValComGer);
  End;

  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add(strPerComVenSin);

  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add(strValComVenSin);

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add(strPerComTotSin);

  TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot2')).Memo.Add(strPerComTotSin);

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add(strValComTotSin);

  TfrxMemoView(frxRel.FindObject('rllValComTot2')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot2')).Memo.Add(strValComTotSin);
End;

procedure TfrmRelComissaoVendedorCTR.pSetaParametros(qryRel: TUniQuery);
begin
  With qryRel Do
  Begin
    If (Params.FindParam('DTAINI') <> Nil) Then
      ParamByName('DTAINI').AsDateTime := StrToDate(mskDtaIni.Text);

    If (Params.FindParam('DTAFIM') <> Nil) Then
      ParamByName('DTAFIM').AsDateTime := StrToDate(mskDtaFin.Text);

    ParamByName('DTACOR').AsDateTime := StrToDate(mskDtaCor.Text);

    If Not fEmptyStr(edtCodEmp.Text) Then
      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryRel);

    If (Not fEmptyStr(edtCodVendedor.Text)) Then
    Begin
      If (blnLibVen) Then
        pSetaParam(edtCodVendedor.Text,arrOperador,strCodVen,'CODVEN', qryRel)
      Else
        ParamByName('CODVEN').AsString := fRetCodVendedor(edtCodVendedor.Text);
    End;

    If (Not fEmptyStr(edtCodGerente.Text)) Then
    Begin
      If (blnLibGer) Then
        pSetaParam(edtCodGerente.Text,arrGerente,strCodGer,'CODGER', qryRel)
      Else
        ParamByName('CODGER').AsString := fRetCodVendedor(edtCodGerente.Text);
    End;

    pSetaParam(edtCodDep.Text, arrDepart, strCodDep, 'CODDEP', qryRel);

    pSetaParam(edtCodCli.Text, arrCliente, strCodCli, 'CODCLI', qryRel);

    pSetaParam(edtCliExc.Text, arrCliExc, strCliExc, 'CLIEXC', qryRel);

    If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
      ParamByName('INTEXT').AsString := strTipVen;

    If (Params.FindParam('CLAFIS') <> Nil) Then
      ParamByName('CLAFIS').AsString := VS_strClaVen;

    If (Params.FindParam('CLADEV') <> Nil) Then
      ParamByName('CLADEV').AsString := VS_strClaDev;
  End;
end;

Procedure TfrmRelComissaoVendedorCTR.pSetaPadraoAnalitico;
Begin
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComAna')).Memo.Add(strPerComAna);

  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComAna')).Memo.Add(strValComAna);

  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComVen')).Memo.Add(strPerComVenAna);

  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComVen')).Memo.Add(strValComVenAna);

  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllPerComTot')).Memo.Add(strPerComTotAna);

  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Clear;
  TfrxMemoView(frxRel.FindObject('rllValComTot')).Memo.Add(strValComTotAna);
End;

procedure TfrmRelComissaoVendedorCTR.btnDupPenClick(Sender: TObject);
  Var
    blnInformouPeriodo:Boolean;
    LfrmAguardeRel: TfrmGravando;
    frmPeriodoDupPendentes: TfrmPeriodoDupPendentes;
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  pCriarFormularios(TfrmPeriodoDupPendentes,frmPeriodoDupPendentes);
  frmPeriodoDupPendentes.ShowModal;
  strDtaCad_Ini := frmPeriodoDupPendentes.mskDtaCad_Ini.Text;
  strDtaCad_Fin := frmPeriodoDupPendentes.mskDtaCad_Fin.Text;
  strDtaVen_Ini := frmPeriodoDupPendentes.mskDtaVen_Ini.Text;
  strDtaVen_Fin := frmPeriodoDupPendentes.mskDtaVen_Fin.Text;
  blnInformouPeriodo := frmPeriodoDupPendentes.blnClickImprimir;
  pFreeAndNil(frmPeriodoDupPendentes);

  pCarregaConfImpr(qryCfgRel, Self.Name);
  blnImprime := fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, edtDestino.Text);

  If (blnImprime) and (blnInformouPeriodo) Then
  Begin
    Try
      pCriarFormularios(TfrmGravando, LfrmAguardeRel);
      LfrmAguardeRel.fExecutarAcao := fImprimeDupPen;
      LfrmAguardeRel.ShowModal;
    Finally
      pFreeAndNil(LfrmAguardeRel);
    End;
  End;
end;

procedure TfrmRelComissaoVendedorCTR.btnImprimirClick(Sender: TObject);
  Var
    strSQL: String;
    strSQLAna: String;
begin
  If (chkPDFVen.Checked) Then
  Begin
    If (fEmptyStr(fraDirPDF.edtDirectory.text)) Then
    Begin
      fMensagem('ATENÇÃO', 'O caminho para salvar os PDFs deve ser informado!', ['&OK']);
      pSetFocus(fraDirPDF);
      Exit;
    End;
    If (Not DirectoryExists(fraDirPDF.edtDirectory.text)) Then
    Begin
      fMensagem('ATENÇÃO', 'Caminho para salvar os PDFs inválido!', ['&OK']);
      pSetFocus(fraDirPDF);
      Exit;
    End;
  End;

  inherited;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  pSetarDadosValorRecebido;

  If blnImprime Then
  Begin

    Try

      strSQL := '';
      {***************************************************}
      {* CADREC DIRETA - SEM AGRUPAMENTO NEM CONFIRMAÇÃO *}
      {************************************************AC*}
      strSQL := strSQL + relRecebido.fGetSqlSemAgrupamentoNemConfirmacao('CADREC', rdgServicos.ItemIndex, 0, chkItens.Checked);

      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC PROVENIENTE DE CONFIRMAÇÃO DOCUMENTO     *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlComConfirmacao('CADREC', 'CTRCNF', rdgServicos.ItemIndex, 0, chkItens.Checked);

      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC AGRUPAMENTO DIRETO                       *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlComAgrupamentoDireto('CADREC', 'DUPAGR', rdgServicos.ItemIndex, 0, chkItens.Checked);
      strSQL := strSQL + '   UNION ALL  ';

      {***************************************************}
      {* CADREC AGRUPAMENTO CONFIRMAÇÃO                  *}
      {************************************************AC*}
      strSQL := strSQL +  relRecebido.fGetSqlAgrupamentoConfirmacao('CADREC',  'DUPAGR',  'CTRCNF', rdgServicos.ItemIndex, 0, chkItens.Checked);

      If (fCfgSis('ADCOCT', varBoolean)) Then
      Begin
        strSQL := strSQL + ' UNION ALL ';
        strSQL := strSQL +  relRecebido.fGetSqlAdiantamentos(rdgServicos.ItemIndex, 0, chkItens.Checked);
      End;

      strSQL := strSQL + ' ORDER BY  ';
      strSQL := strSQL + '   CTR_CODVEN, ';

      If (relRecebido.blnUltPar) Then
      Begin
        strSQL := strSQL + '   CTR_NUMDUP, ';
        strSQL := strSQL + '   CTR_DTAREC  ';
      End
      Else
      Begin
        strSQL := strSQL + '   CTR_DTAREC, ';
        strSQL := strSQL + '   CTR_NUMDUP  ';
      end;

      If chkItens.Checked Then
        strSQL := strSQL + ',   CHAVE  ';

      strSQLAna := strSQL;

      If rdgTipRel.ItemIndex = 1 Then
        strSQL := fGetSqlSinteticoMovDet(strSQL);

      With qryRelatorio Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        pSetaParametros(qryRelatorio);
        Open;

        cdsResumoMod.EmptyDataSet;
        frxResumo.DataSet := cdsResumoMod;
        If (chkResumo.Checked) Then
        Begin
          If rdgTipRel.ItemIndex = 0 Then
            pMontaResumoModalidades(qryRelatorio)
          Else
          Begin
            qryResumo := fCriaQuery;
            qryResumo.Close;
            qryResumo.SQL.Clear;
            qryResumo.SQL.Add(strSQLAna);
            pSetaParametros(qryResumo);
            qryResumo.Open;
            pMontaResumoModalidades(qryResumo);
            FreeAndNil(qryResumo);
          End;
          frxResumo.Open;
        End;

        If Not IsEmpty Then
        Begin
          frxRelatorio.DataSet := qryRelatorio;

          pAjustaPercentualDeComissao;

          If rdgTipRel.ItemIndex in [0, 2] Then
          Begin
            If strTipImp = 'M' Then
            Begin
              If rdgComRes.ItemIndex = 0 Then Begin
                If (chkItens.Checked) Then
                  frxRel := frxComissaoVendedorItensCTRP_M
                Else
                  frxRel := frxComissaoVendedorCTRP_M;
              End Else Begin
                If (chkItens.Checked) Then
                  frxRel := frxComissaoVendedorItensCTR_M
                Else
                  frxRel := frxComissaoVendedorCTR_M;
              End;
            End Else
            Begin
              If rdgComRes.ItemIndex = 0 Then Begin
                If (chkItens.Checked) Then
                  frxRel := frxComissaoVendedorItensCTRP_J
                Else
                  frxRel := frxComissaoVendedorCTRP_J;
              End Else Begin
                If (chkItens.Checked) Then
                  frxRel := frxComissaoVendedorItensCTR_J
                Else
                  frxRel := frxComissaoVendedorCTR_J;
              End;
            End;

            frxRel.AddFunction('Procedure pSetaTotalVendedor(strTotVen: String)');

            TfrxGroupHeader(frxRel.FindObject('GHComissao')).StartNewPage     := ((rdgTipRel.ItemIndex = 2) Or chkEjeVen.Checked);
            TfrxGroupHeader(frxRel.FindObject('GHComissao')).ResetPageNumbers := ((rdgTipRel.ItemIndex = 2) Or chkEjeVen.Checked);
            TfrxChild(frxRel.FindObject('CRecibo')).Visible                   := rdgTipRel.ItemIndex = 2;
            TfrxReportSummary(frxRel.FindObject('RSComissao')).Visible        := rdgTipRel.ItemIndex <> 2;
            TfrxPageFooter(frxRel.FindObject('PFComissao')).Visible           := rdgTipRel.ItemIndex <> 2;

            //If (Not chkItens.Checked) Then Begin
              If rdgPerCom.ItemIndex = 1 Then
                pSetaOperadorAnalitico
              Else
                pSetaPadraoAnalitico;
            //End;
          End
          Else
          Begin
            If strTipImp = 'M' Then
              frxRel := frxComissaoVendedorSintCTR_M
            Else
              frxRel := frxComissaoVendedorSintCTR_J;

            If rdgPerCom.ItemIndex = 1 Then
              pSetaOperadorSintetico
            Else
              pSetaPadraoSintetico;

            TfrxGroupHeader(frxRel.FindObject('rlbQuebra')).Condition := IIF(chkQueGer.Checked, 'frxRelatorio."CODGER"', 'frxRelatorio."VENDEDOR"');
            TfrxGroupHeader(frxRel.FindObject('rlbQuebra')).Visible   := chkQueGer.Checked;
            TfrxGroupFooter(frxRel.FindObject('rlbGrupo' )).Visible   := chkQueGer.Checked;
            TfrxMemoView(frxRel.FindObject('rllPerComGer')).Visible   := chkQueGer.Checked;

          End;

          If frxRel.FindObject('rllFundoDetalhe') <> Nil Then
            TfrxMemoView(frxRel.FindObject('rllFundoDetalhe')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clSilver);

          frxRel.PrintOptions.Printer    := AnsiReplaceText(strNomImp,'\\' + fRetNomeRede + '\','');

          pSetaVariaveisRelatorio(frxRel);

          If Not chkItens.Checked Then
            TfrxChild(frxRel.FindObject('CResumo')).Visible := chkResumo.Checked;

          If (Not chkPDFVen.Checked) Then
          Begin
            If (edtDestino.Text = 'V') Then
              pPreviewReport(Self.Name, Self.Caption, frxRel)
            Else If frxRel.PrepareReport Then
              pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
          End
          Else
          Begin
            pExportarPDFParaCadaVendedor(frxRel);
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

procedure TfrmRelComissaoVendedorCTR.fraPlanoDeContasMskCodCtaKeyPress(
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

function TfrmRelComissaoVendedorCTR.fRetSQLDupMod: String;
Var
 strSubSQL: String;
begin
    strSubSQL := '';
    strSubSQL := strSubSQL + '  (SELECT  ';
    strSubSQL := strSubSQL + '  CONCAT( ';
    strSubSQL := strSubSQL + '    IF(CTR_CHQAVI <> 0.00 OR CTR_CHQPRE <> 0.00, "CHQ", ""), ';
    strSubSQL := strSubSQL + '    IF(CTR_CARTAO <> 0.00, "CAR", ""), ';
    strSubSQL := strSubSQL + '    IF(CTR_CHQAVI = 0.00 AND CTR_CHQPRE = 0.00 AND CTR_CARTAO = 0.00, "FAT","") ) AS MODALI ';
    strSubSQL := strSubSQL + ' FROM CADREC ';
    strSubSQL := strSubSQL + ' WHERE TRUE ';
    strSubSQL := strSubSQL + '   AND CTR_SEQBAI = 0 ';
    strSubSQL := strSubSQL + '   AND CTR_NUMDUP = IF(LENGTH(DUPLIC) = 21,SUBSTRING(DUPLIC, 1, 12),SUBSTRING(DUPLIC, 1, 12)) ';
    strSubSQL := strSubSQL + '   AND CTR_PARCEL = IF(LENGTH(DUPLIC) = 21,SUBSTRING(DUPLIC, 14, 1),SUBSTRING(DUPLIC, 14, 3)) ';
    strSubSQL := strSubSQL + '   AND CTR_ESPDOC = IF(LENGTH(DUPLIC) = 21,SUBSTRING(DUPLIC, 16, 2),SUBSTRING(DUPLIC, 16, 2)) ';
    strSubSQL := strSubSQL + '   AND CTR_CODEMP = IF(LENGTH(DUPLIC) = 21,SUBSTRING(DUPLIC, 19, 3),SUBSTRING(DUPLIC, 19, 3)) ';
    strSubSQL := strSubSQL + ' GROUP BY CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP HAVING MODALI IS NOT NULL LIMIT 1 ) ';
    Result := strSubSQL;
end;

function TfrmRelComissaoVendedorCTR.fRetSQLQtdPar(): String;
Var
 strSubSQL: String;
begin
    strSubSQL := '';
    strSubSQL := strSubSQL + ' (SELECT  ';
    strSubSQL := strSubSQL + '   CONCAT(R2.CTR_NUMDUP,"-",R2.CTR_PARCEL,"/", ';
    strSubSQL := strSubSQL + '   (SELECT R.CTR_PARCEL ';
    strSubSQL := strSubSQL + '      FROM CADREC R ';
    strSubSQL := strSubSQL + '     WHERE R.CTR_NUMDUP = R2.CTR_NUMDUP ';
    strSubSQL := strSubSQL + '       AND R.CTR_ESPDOC = R2.CTR_ESPDOC ';
    strSubSQL := strSubSQL + '       AND R.CTR_CODEMP = R2.CTR_CODEMP ';
    strSubSQL := strSubSQL + '     ORDER BY R.CTR_PARCEL DESC LIMIT 1), ';
    strSubSQL := strSubSQL + '"-", R2.CTR_ESPDOC, "-", R2.CTR_CODEMP) AS DUP ';
    strSubSQL := strSubSQL + ' FROM CADREC R2';
    strSubSQL := strSubSQL + ' WHERE R2.CTR_SEQBAI = 0 ';
    strSubSQL := strSubSQL + '   AND R2.CTR_NUMDUP = IF(LENGTH(DUPLIC) = 21,SUBSTRING(DUPLIC, 1, 12),SUBSTRING(DUPLIC, 1, 12)) ';
    strSubSQL := strSubSQL + '   AND R2.CTR_PARCEL = IF(LENGTH(DUPLIC) = 21,SUBSTRING(DUPLIC, 14, 1),SUBSTRING(DUPLIC, 14, 3)) ';
    strSubSQL := strSubSQL + '   AND R2.CTR_ESPDOC = IF(LENGTH(DUPLIC) = 21,SUBSTRING(DUPLIC, 16, 2),SUBSTRING(DUPLIC, 16, 2)) ';
    strSubSQL := strSubSQL + '   AND R2.CTR_CODEMP = IF(LENGTH(DUPLIC) = 21,SUBSTRING(DUPLIC, 19, 3),SUBSTRING(DUPLIC, 19, 3)) ';
    strSubSQL := strSubSQL + ' GROUP BY R2.CTR_NUMDUP, R2.CTR_PARCEL, R2.CTR_ESPDOC, R2.CTR_CODEMP LIMIT 1) ';
    Result := strSubSQL;
end;

procedure TfrmRelComissaoVendedorCTR.frxCabecalhoGetValue(
  const VarName: String; var Value: Variant);
begin
  inherited;

  If SameText('EMPRESA',VarName) Then
    Value := strEmpresa

  Else If SameText('VENDEDOR',VarName) Then
    Value := strVendedor

  Else If SameText('PERIODO',VarName) Then
    Value := strPeriodo

end;

procedure TfrmRelComissaoVendedorCTR.FormShow(Sender: TObject);
  Var
    dtaCorte : TDate;
begin
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

  blnLibVen := fVerificaAcessoSistema('RFATCV');
  blnLibGer := fVerificaAcessoSistema('RFATCG');

  pVerdeVermelho(edtCodVendedor, shpVen, blnLibVen);
  pVerdeVermelho(edtCodGerente, shpGer, blnLibGer);
  pVerdeVermelho(chkDocCom, shpDocCom, fVerificaAcessoSistema('DOCCOM'), True);

  mskDtaRec.Text := FormatDateTime('dd/mm/yyyy',VS_Date);

  inherited;

  shpMultSel.Visible := True;

  dtaCorte := fCfgSis('DTCOCR', varDate);

  If dtaCorte = 0 Then
    mskDtaCor.Clear
  Else
    mskDtaCor.Text := FormatDateTime('dd/mm/yyyy', dtaCorte);

  {  VERIFICA SE GERA COMISSÃO A CADA VENDA OU NÃO, CASO NÃO, pnlMeio fica visível }
  if (fCfgSis('GCCVEN') = 'S') then
    pnlGerCom.Visible := False;

  if (Not pnlGerCom.Visible  ) then
    Self.ClientHeight := Self.ClientHeight - pnlGerCom.Height;

  pHabilitaOpcoesPDF;

  pSetFocus(mskDtaIni);
end;

procedure TfrmRelComissaoVendedorCTR.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
    VK_RETURN: If ActiveControl Is TRadioGroup Then
                 Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmRelComissaoVendedorCTR.fGetClienteDuplicata(
  strDuplic, strTabela: String): String;
  Var
    strNumDup : String;
    strEspDoc : String;
    strParcel : String;
    strCodEmp : String;
    qryCadRec : TUniQuery;
begin
  Result := '';
  strNumDup := LeftStr(strDuplic, Pos('-', strDuplic) -1);
  System.Delete(strDuplic, 1, Pos('-', strDuplic));

  strParcel := MidStr(strDuplic, 1, Pos('-', strDuplic) -1);
  System.Delete(strDuplic, 1, Pos('-', strDuplic));

  strEspDoc := MidStr(strDuplic, 1, Pos('-', strDuplic) -1);
  System.Delete(strDuplic, 1, Pos('-', strDuplic));

  strCodEmp := RightStr(strDuplic, 3);

  qryCadRec := fCriaQuery(Self);

  With qryCadRec Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT CTR_CODCLI ');
    SQL.Add('   FROM ' + strTabela);
    SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP ');
    SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
    SQL.Add('    AND CTR_PARCEL = :PARCEL ');
    SQL.Add('    AND CTR_CODEMP = :CODEMP ');
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (Not IsEmpty) Then
      Result := FieldByName('CTR_CODCLI').AsString;

    Close;
  End;

  FreeAndNil(qryCadRec);
end;

function TfrmRelComissaoVendedorCTR.fGetSqlAberto(strAnaSin: String): String;
  Var
    strSQL : String;
begin
  strSQL := '';
  {***************************************************}
  {* CADREC DIRETA - SEM AGRUPAMENTO NEM CONFIRMAÇÃO *}
  {************************************************AC*}
  strSQL := strSQL + relRecebido.fGetSqlSemAgrupamentoNemConfirmacaoAberto('CADREC', rdgServicos.ItemIndex, strAnaSin);

  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC PROVENIENTE DE CONFIRMAÇÃO DOCUMENTO     *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlComConfirmacaoAberto('CADREC', 'CTRCNF', rdgServicos.ItemIndex, strAnaSin);
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO DIRETO                       *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlComAgrupamentoDiretoAberto('CADREC', 'DUPAGR', rdgServicos.ItemIndex, strAnaSin);
  strSQL := strSQL + '   UNION ALL  ';

  {***************************************************}
  {* CADREC AGRUPAMENTO CONFIRMAÇÃO                  *}
  {************************************************AC*}
  strSQL := strSQL +  relRecebido.fGetSqlAgrupamentoConfirmacaoAberto('CADREC',  'DUPAGR',  'CTRCNF', rdgServicos.ItemIndex, strAnaSin);

  Result := strSQL;
end;

Function TfrmRelComissaoVendedorCTR.fGetSqlMovDet: String;
  Var
    strAux,
    strSQLMovDet: String;

  function fGetSql(strTabela: String): String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   ' + relRecebido.fGetVenDigDet + ', ';
    strSQL := strSQL + '   SUM(IF((DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + '), 0.00, IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP - DET_DESCFF), DET_TOTITE - DET_DESESP - DET_DESCFF))) AS TOTITE ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '   ' + strTabela + ' ';

    If cbxVenRep.ItemIndex in [2, 3, 4] Then  // SUPEVISOR GERAL/REGIONAL OU VENDCADCLI
      strSQL := strSQL + ' INNER JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';

    strSQL := strSQL + ' INNER JOIN CADOPE ON OPE_CODOPE = ' + relRecebido.fGetVenDigDet;

    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '   DET_TIP_FC = "C"  AND ';
    strSQL := strSQL + '   DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + cnsFiltroFFDVTR;
    strSQL := strSQL + '   DET_DTAENT BETWEEN :DTAINI AND :DTAFIM   AND ';

    Case rdgServicos.ItemIndex of
      0 :  strSQL := strSQL + '  DET_ESPDOC = "NS" AND ';// Somente Notas de Serviço
      1 :  strSQL := strSQL + '  DET_ESPDOC <> "NS" AND ';// Exeto Notas de Serviço
    End;    

    strSQL := strSQL + '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0)';
    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
    Else
      strSQL := strSQL + ') ';

    If Not fEmptyStr(edtCodEmp.Text) Then
    Begin
      If rdgRelEmp.ItemIndex = 1 Then
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp,  'OPE_CODEMP', 'CODEMP')
      Else
        strSQL := strSQL + fStrLocate(edtCodEmp,  arrEmp,  'DET_CODEMP', 'CODEMP');
    End
    Else
    Begin
      If rdgRelEmp.ItemIndex = 1 Then
        strSQL := strSQL + '    AND LOCATE(OPE_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 '
      Else
        strSQL := strSQL + '    AND LOCATE(DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;

    If (Not fEmptyStr(edtCodVendedor.Text)) Then
    Begin
      Case cbxVenRep.ItemIndex Of
        0: strAux := 'DET_CODVEN';
        1: strAux := 'DET_CODREP';
        2: strAux := 'CLI_SUPGER';
        3: strAux := 'CLI_SUPREG';
        4: strAux := 'CLI_CODVEN';
        5: strAux := 'DET_CODDIG';
      End;

      If (blnLibVen) Then
        strSQL := strSQL + fStrLocate(edtCodVendedor, arrOperador, strAux, 'CODVEN')
      Else
        strSQL := strSQL + ' AND ' + strAux + ' = :CODVEN ';
    End;

    If (Not fEmptyStr(edtCodGerente.Text)) Then
    Begin
      If (blnLibGer) Then
        strSQL := strSQL + fStrLocate(edtCodGerente, arrGerente, 'OPE_CODGER', 'CODGER')
      Else
        strSQL := strSQL + ' AND OPE_CODGER = :CODGER ';

      strSQL := strSQL + ' AND (IFNULL(OPE_CODGER,"") <> "")  ';
    End;

    If (Not fEmptyStr(edtCodDep.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodDep, arrDepart, 'OPE_CODDEP', 'CODDEP');

    If (Not fEmptyStr(edtCodCli.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodCli, arrCliente, 'DET_CODCLI', 'CODCLI');

    If (Not fEmptyStr(relRecebido.strStaVen)) Then
      strSQL := strSQL + '  AND OPE_STATUS = "' +relRecebido.strStaVen+ '" ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  ' + relRecebido.fGetVenDigDet;

    Result := strSQL;
  End;

Begin
  strSQLMovDet := fGetSql('MOVDET');

  strSQLMovDet := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQLMovDet);

  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE         ';
  Result := Result + '   ' + relRecebido.fGetVenDigDet + ' AS CTR_CODVEN,  ';
  Result := Result + '   OPE_NOMOPE,                           ';
  Result := Result + '   IFNULL(OPE_PERCOM, 0) AS OPE_PERCOM,  ';
  Result := Result + '   IFNULL(OPE_PERCO2, 0) AS OPE_PERCO2,  ';
  Result := Result + '   OPE_INTEXT,                           ';
  Result := Result + '   SUM(TOTITE) AS CTR_VALFAT,';
  Result := Result + '   CONCAT(' + relRecebido.fGetVenDigDet + '," - ",OPE_NOMOPE) AS VENDEDOR, ';
  Result := Result + '   0 AS CTR_ABERTO,          ';
  Result := Result + '   0 AS CTR_VALORI,          ';
  Result := Result + '   0 AS CTR_VALJUR,          ';
  Result := Result + '   0 AS CTR_JURVIS,          ';
  Result := Result + '   0 AS CTR_JURPRA,          ';
  Result := Result + '   0 AS CTR_VALDES,          ';
  Result := Result + '   0 AS CTR_VALREC,          ';
  Result := Result + '   0 AS CTR_RECCOM,          ';
  Result := Result + '   0 AS CTR_RECIPI,          ';
  Result := Result + '   0 AS VLCOM_OPEAVI,        ';
  Result := Result + '   0 AS VLCOM_OPEAPR,        ';
  Result := Result + '   0 AS VALOR_COMISSAO,      ';
  Result := Result + '   0 AS CTR_AVISTA,          ';
  Result := Result + '   0 AS CTR_APRAZO,          ';
  Result := Result + '   0 AS CTR_AVISTA_LIQ,      ';
  Result := Result + '   0 AS CTR_APRAZO_LIQ       ';
  Result := Result + ' FROM ( '+strSQLMovDet+' ) AS TABDET ';
  Result := Result + ' INNER JOIN CADOPE ON OPE_CODOPE = ' + relRecebido.fGetVenDigDet;

  If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
    Result := Result + ' WHERE OPE_INTEXT = :INTEXT ';

  Result := Result + ' GROUP BY ';
  Result := Result + relRecebido.fGetVenDigDet;
End;

Function TfrmRelComissaoVendedorCTR.fGetSqlSinteticoMovDet(strAnalitico: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE                       ';

  if (chkQueGer.Checked) then
  Begin
    strSQL := strSQL + '   G.OPE_CODOPE AS CODGER,               ';
    strSQL := strSQL + '   G.OPE_NOMOPE AS NOMGER,               ';
    strSQL := strSQL + '   G.OPE_COMCFA AS PERGER,               ';
  End;

  strSQL := strSQL + '   CTR_CODVEN,                             ';
  strSQL := strSQL + '   T.OPE_NOMOPE,                           ';
  strSQL := strSQL + '   T.OPE_PERCOM,                           ';
  strSQL := strSQL + '   T.OPE_PERCO2,                           ';
  strSQL := strSQL + '   T.OPE_INTEXT,                           ';
  strSQL := strSQL + '   SUM(CTR_VALFAT) AS CTR_VALFAT,          ';
  strSQL := strSQL + '   VENDEDOR,                               ';
  strSQL := strSQL + '   SUM(CTR_ABERTO) AS CTR_ABERTO,          ';
  strSQL := strSQL + '   SUM(CTR_VALORI) AS CTR_VALORI,          ';
  strSQL := strSQL + '   SUM(CTR_VALJUR) AS CTR_VALJUR,          ';
  strSQL := strSQL + '   SUM(CTR_JURVIS) AS CTR_JURVIS,          ';
  strSQL := strSQL + '   SUM(CTR_JURPRA) AS CTR_JURPRA,          ';
  strSQL := strSQL + '   SUM(CTR_VALDES) AS CTR_VALDES,          ';
  strSQL := strSQL + '   SUM(CTR_VALREC) AS CTR_VALREC,          ';
  strSQL := strSQL + '   SUM(CTR_RECCOM) AS CTR_RECCOM,          ';
  strSQL := strSQL + '   SUM(CTR_RECIPI) AS CTR_RECIPI,          ';

  If rdgPerCom.ItemIndex = 0 Then
    strSQL := strSQL + '   SUM(VALOR_COMISSAO) AS VALOR_COMISSAO, '
  Else
    strSQL := strSQL + '   SUM(VLCOM_OPEAVI+VLCOM_OPEAPR) AS VALOR_COMISSAO, ';

  strSQL := strSQL + '   SUM(VLCOM_OPEAVI)   AS VLCOM_OPEAVI,   ';
  strSQL := strSQL + '   SUM(VLCOM_OPEAPR)   AS VLCOM_OPEAPR,   ';
  strSQL := strSQL + '   SUM(CTR_AVISTA)     AS CTR_AVISTA,     ';
  strSQL := strSQL + '   SUM(CTR_APRAZO)     AS CTR_APRAZO,     ';
  strSQL := strSQL + '   SUM(CTR_AVISTA_LIQ) AS CTR_AVISTA_LIQ, ';
  strSQL := strSQL + '   SUM(CTR_APRAZO_LIQ) AS CTR_APRAZO_LIQ  ';

  strSQL := strSQL + ' FROM ( ';

  strSQL := strSQL + fGetSQLSintetico(strAnalitico) + ' UNION ALL ' +
                     fGetSqlMovDet + ' UNION ALL ' +
                     fGetSQLTotalAberto;

  strSQL := strSQL + ' ) AS T ';

  if (chkQueGer.Checked) then
  Begin
    strSQL := strSQL + ' LEFT  JOIN CADOPE G ON G.OPE_CODOPE = (SELECT OPE_CODGER FROM CADOPE WHERE OPE_CODOPE = T.CTR_CODVEN) ';
  End;

  If (rdgTpVendRep.ItemIndex <> VEN_TODOS) Then
    Result := Result + ' WHERE OPE_INTEXT = :INTEXT ';

  if (chkQueGer.Checked) then
  Begin
    strSQL := strSQL + ' GROUP BY CTR_CODVEN, NOMGER ';
    strSQL := strSQL + ' ORDER BY NOMGER, T.OPE_NOMOPE ';
  End
  Else
  Begin
    strSQL := strSQL + ' GROUP BY CTR_CODVEN ';
    strSQL := strSQL + ' ORDER BY OPE_NOMOPE ';
  End;

  If chkGraCom.Checked Or chkDocCom.Checked Then
    strSQL := 'SELECT * FROM ('+ strSQL +') TAB WHERE ((ROUND(VALOR_COMISSAO, 2) <> 0) ' + IIF(chkDocCom.Checked, ' OR (CTR_VALFAT <> 0)) ', ')');

  Result := strSQL;
End;

procedure TfrmRelComissaoVendedorCTR.FormCreate(Sender: TObject);
begin
  inherited;
  qryRelatorio   := fCriaQuery;
  qryVendedor    := fCriaQuery;
  relRecebido    := TValorRecebido.Create;

  pInicializaStringCamposTotalizadores();

  fltPmCmCr := fCfgSis('PMCMCR', varDouble);

  If (fCfgSis('VENMET') = '1') Then
  Begin
    lblOpcVen.Caption := 'Opção de Vendedor';
    cbxVenRep.Items.Clear;
    cbxVenRep.Items.Add('1- Vendedor');
    cbxVenRep.Items.Add(IIF((fCfgSis('VENCOM') = '1'), '2- Representante', '2- Vendedor-2'));
    cbxVenRep.Items.Add('3- Supervisor Geral');
    cbxVenRep.Items.Add('4- Supervisor Regional');
    cbxVenRep.Items.Add('5- Vendedor CadCli');
    cbxVenRep.Items.Add('6- Digitador');
    cbxVenRep.ItemIndex := 0;
    rdgRelEmp.Items.Clear;
    rdgRelEmp.Items.Add('Empresa');
    rdgRelEmp.Items.Add('Vendedor');
    rdgRelEmp.ItemIndex := 0;
    lblVendedor.Caption  := 'Vendedor';
    rdgTpVendRep.Caption := 'Tipo de Vendedor';
    arrVenRep[0] := 'VENDEDOR';
    If(fCfgSis('VENCOM') = '1') Then
      arrVenRep[1] := 'REPRESENTANTE'
    Else
      arrVenRep[1] := 'VENDEDOR-2';
    arrVenRep[2] := 'SUPERVISOR GERAL';
    arrVenRep[3] := 'SUPERVISOR REGIONAL';
    arrVenRep[4] := 'VENDEDOR';
    arrVenRep[5] := 'DIGITADOR';
  End
  Else
  Begin
    lblOpcVen.Caption := 'Opção de Representante (I)';
    cbxVenRep.Items.Clear;
    cbxVenRep.Items.Add('1- Representante (I)');
    cbxVenRep.Items.Add(IIF((fCfgSis('VENCOM') = '1'), '2- Representante (E)', '2- Vendedor-2'));
    cbxVenRep.Items.Add('3- Supervisor Geral');
    cbxVenRep.Items.Add('4- Supervisor Regional');
    cbxVenRep.Items.Add('5- Representante (I) CadCli');
    cbxVenRep.Items.Add('6- Digitador');
    cbxVenRep.ItemIndex := 0;
    rdgRelEmp.Items.Clear;
    rdgRelEmp.Items.Add('Empresa');
    rdgRelEmp.Items.Add('Representante (I)');
    rdgRelEmp.ItemIndex := 0;
    lblVendedor.Caption  := 'Representante (I)';
    rdgTpVendRep.Caption := 'Tipo de Representante';
    arrVenRep[0] := 'REPRESENTANTE (I)';
    If(fCfgSis('VENCOM') = '1') Then
      arrVenRep[1] := 'REPRESENTANTE (E)'
    Else
      arrVenRep[1] := 'VENDEDOR-2';
    arrVenRep[2] := 'SUPERVISOR GERAL';
    arrVenRep[3] := 'SUPERVISOR REGIONAL';
    arrVenRep[4] := 'REPRESENTANTE (I)';
    arrVenRep[5] := 'DIGITADOR';
  End;

  {****************************************}
  {* CRIA CLIENTDATASET USADO NO RESUMO   *}
  {*************************************MM*}
  cdsResumoMod                  := TUniClientDataSet.Create(Self);
  cdsResumoMod.AggregatesActive := True;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_CODVEN';
    DataType := ftString;
    Size := 3;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_NOMVEN';
    DataType := ftString;
    Size := 30;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_DESMOD';
    DataType := ftString;
    Size := 20;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_COMIMP';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_SEMIMP';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_VALCOM';
    DataType := ftFloat;
    Required := False;
  End;

  With cdsResumoMod.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RMO_TOTCOM';
    DataType := ftFloat;
    Required := False;
  End;

  cdsResumoMod.CreateDataSet;
  cdsResumoMod.IndexFieldNames := 'RMO_CODVEN';
  cdsResumoMod.LogChanges := False;

  pnlServico.Visible := fCfgSis('USASER', varBoolean);

  if not pnlServico.Visible Then
    Self.Height := Self.Height - pnlServico.Height;

end;

procedure TfrmRelComissaoVendedorCTR.FormDestroy(Sender: TObject);
begin
  inherited;
  qryVendedor.Close;
  qryRelatorio.Close;
  cdsResumoMod.Close;

  FreeAndNil(qryVendedor);
  FreeAndNil(qryRelatorio);
  FreeAndNil(relRecebido);
  FreeAndNil(cdsResumoMod);
end;

procedure TfrmRelComissaoVendedorCTR.cbxVenRepChange(Sender: TObject);
begin
  inherited;

  If cbxVenRep.ItemIndex in [2,3] Then  // SUPERVISOR GERAL/REGIONAL
  Begin
    rdgPerCom.ItemIndex := 1;
    rdgPerCom.Enabled := False;
  End Else
  Begin
    rdgPerCom.Enabled := True;
  End;
end;

procedure TfrmRelComissaoVendedorCTR.chkGraComClick(Sender: TObject);
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

procedure TfrmRelComissaoVendedorCTR.chkItensClick(Sender: TObject);
begin
  inherited;

  pInicializaStringCamposTotalizadores();
end;

procedure TfrmRelComissaoVendedorCTR.chkPDFVenClick(Sender: TObject);
begin
  inherited;
  pHabilitaOpcoesPDF;
end;

procedure TfrmRelComissaoVendedorCTR.rdgComResClick(Sender: TObject);
begin
  inherited;
  pHabilitaOpcoesPDF;
end;

procedure TfrmRelComissaoVendedorCTR.rdgTipRelClick(Sender: TObject);
begin
  inherited;

  rdgComRes.Enabled := rdgTipRel.ItemIndex <> 1;

  If Not rdgComRes.Enabled Then
    rdgComRes.ItemIndex := 1;

  grbRecibo.Enabled := rdgTipRel.ItemIndex = 2;

  //chkResumo.Checked := Not (rdgTipRel.ItemIndex = 2);
  chkResumo.Enabled := Not (rdgTipRel.ItemIndex = 2);

  chkQueGer.Enabled := (rdgTipRel.ItemIndex = 1);
  chkQueGer.Checked := IIF(rdgTipRel.ItemIndex = 1,chkQueGer.Checked,False);

  pSetaPeriodoRecibo;

  If (rdgTipRel.ItemIndex = 0) Or (rdgTipRel.ItemIndex = 2) Then
    chkDocCom.Caption := 'Exibir somente documentos com valor de comissão'
  Else
    chkDocCom.Caption := 'Exibir somente documentos com valor de comissão ou faturado';

  chkItens.Enabled := (rdgTipRel.ItemIndex = 0);

  If (Not chkItens.Enabled) Then
    chkItens.Checked := False;

  btnDupPen.Enabled := rdgTipRel.ItemIndex = 1;

  pHabilitaOpcoesPDF;
end;

procedure TfrmRelComissaoVendedorCTR.frxUserGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If SameText('DTAREC', VarName) Then
    Value := fRetDataExtenso(StrToDate(mskDtaRec.Text), True)

  Else If SameText('VALREC', VarName) Then
    Value := fStrToFloat(strValRec)

  Else If SameText('NOMREC', VarName) Then
    Value := fRetNomeEmpresa

  Else If SameText('NOMASS', VarName) Then
    Value := qryRelatorio.FieldByName('OPE_NOMOPE').AsString

  Else If SameText('HISREC', VarName) Then
    Value := edtHisRec.Text

  Else If SameText('NROVIA', VarName) Then
    Value := intQtdVia

  Else If SameText('VLREXT', VarName) Then
    Value := UpperCase(fRetExtensoNumero(strValRec))

  Else If SameText('BLNJUR', VarName) Then
    Value := chkConJur.Checked;
end;

procedure TfrmRelComissaoVendedorCTR.frxUserFirst(Sender: TObject);
begin
  inherited;

  intQtdVia := 1;
end;

procedure TfrmRelComissaoVendedorCTR.frxUserNext(Sender: TObject);
begin
  inherited;

  inc(intQtdVia);

end;

procedure TfrmRelComissaoVendedorCTR.frxUserCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;

  Eof := intQtdVia > StrToIntDef(edtQtdVia.Text, 0);

  If Eof Then
  Begin
    TfrxChild(frxRel.FindObject('CHeader')).Visible := True;
    TfrxPageHeader(frxRel.FindObject('PageHeader')).Visible := True;
  End;

end;

procedure TfrmRelComissaoVendedorCTR.frxUserPrior(Sender: TObject);
begin
  inherited;

  Dec(intQtdVia);

end;

function TfrmRelComissaoVendedorCTR.frxComissaoVendedorCTR_MUserFunction(
  const MethodName: String; var Params: Variant): Variant;
begin
  inherited;

  If SameText(MethodName, 'pSetaTotalVendedor') Then
    strValRec := FloatToStr(fStrToFloat(Trim(Params[0])))

end;

Procedure TfrmRelComissaoVendedorCTR.pSetaPeriodoRecibo;
Begin
  If rdgTipRel.ItemIndex = 2 Then
    edtHisRec.Text := 'A COMISSAO DO PERIODO DE ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' a ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text))
  Else
    edtHisRec.Text := '';
End;

procedure TfrmRelComissaoVendedorCTR.pSetarDadosValorRecebido;
begin
  relRecebido.blnConJur := chkConJur.Checked;
  relRecebido.blnUltPar := (fCfgSis('COMCTR', varString) = '2');
  relRecebido.intPosCom := rdgPosCom.ItemIndex;
  relRecebido.blnDocCom := chkDocCom.Checked;
  relRecebido.relRelEmp := IIF(rdgRelEmp.ItemIndex = 0, reMovimentacao, reVendedor);

  relRecebido.blnCalcularPeloCadastroOperador := False;
  relRecebido.blnValorBaseLiquido:= False;
  If (rdgPerCom.ItemIndex = 1) Then
  Begin
    //Comissão pelo cad. de operadores
    relRecebido.strCampoComissao := fFrxCom(True);
    relRecebido.blnValorBaseLiquido := True;

    //Modo sintético
    If (rdgTipRel.ItemIndex = 1) Then
      relRecebido.blnCalcularPeloCadastroOperador := True;
  End
  Else
  Begin
    relRecebido.strCampoComissao := 'VALOR_COMISSAO';
  End;

  {**********************************************}
  {* OS VALORES NAS PROPRIEDADES A SEGUIR, PELO *}
  {* MENOS NESSE RELATÓRIO, SÓ INDICAM À CLASSE *}
  {* SE ELA MONTARÁ OU NÃO O RESPECTIVO FILTRO  *}
  {*******************************************VA*}
  relRecebido.strCodVen := IIF(fEmptyStr(edtCodVendedor.Text), '', edtCodVendedor.Text);
  relRecebido.strCodGer := IIF(fEmptyStr(edtCodGerente.Text), '', edtCodGerente.Text);
  relRecebido.strCodDep := IIF(fEmptyStr(edtCodDep.Text), '', edtCodDep.Text);
  relRecebido.strCodEmp := IIF(fEmptyStr(edtCodEmp.Text), '', edtCodEmp.Text);
  relRecebido.strCodCli := IIF(fEmptyStr(edtCodCli.Text), '', edtCodCli.Text);
  relRecebido.strCliExc := IIF(fEmptyStr(edtCliExc.Text), '', edtCliExc.Text);
  {**********************************************}

  Case rdgStatus.ItemIndex Of
    0: relRecebido.strStaVen := 'A';
    1: relRecebido.strStaVen := 'I';
    2: relRecebido.strStaVen := EmptyStr;
  End;

  Case cbxVenRep.ItemIndex Of
    0: relRecebido.opcVenRep := opVendedor;
    1: relRecebido.opcVenRep := opRepresentante;
    2: relRecebido.opcVenRep := opSupGeral;
    3: relRecebido.opcVenRep := opSupRegional;
    4: relRecebido.opcVenRep := opVenCadCli;
    5: relRecebido.opcVenRep := opDigitador;
  End;

  {*******************************************************}
  {**CONTROLA O FILTRO TIPO DE VENDEDOR OU REPRESENTANTE**}
  {**SE FOR 1 É INTERNO, 2 É EXTERNO                    **}
  {*****************************************************PZ}
  Case rdgTpVendRep.ItemIndex Of
    VEN_TODOS           : Begin strTipVen := '';  strDesTip := 'TODOS';                  End;
    VEN_INTERNO         : Begin strTipVen := 'I'; strDesTip := 'INTERNO'                 End;
    VEN_EXTERNO_LOJA    : Begin strTipVen := 'E'; strDesTip := 'REPRES. EXTERNO LOJA'    End;
    VEN_EXTERNO_DISTRIB : Begin strTipVen := 'D'; strDesTip := 'REPRES. EXTERNO DISTRIB' End;
  End;

  relRecebido.strTipVenRep := strTipVen;

  {*******************************************}
  {* CABEÇALHO                               *}
  {****************************************AC*}
  strPeriodo := 'PERÍODO DE: ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaIni.Text)) + ' a ' + FormatDateTime('dd/mm/yyyy',StrToDate(mskDtaFin.Text));

  relRecebido.strDtaIni := mskDtaIni.Text;
  relRecebido.strDtaFim := mskDtaFin.Text;

  strEmpresa :=  fStrTitulo(edtCodEmp.Text, edtDesEmpresa, arrEmp, strEmp, 'EMPRESA', True);
  strVendedor := fStrTitulo(edtCodVendedor, edtDesVendedor, arrOperador, strCodVen, String(arrVenRep[cbxVenRep.ItemIndex]));
end;

procedure TfrmRelComissaoVendedorCTR.pSetaVariaveisRelatorio(
  frxRel: TfrxReport);
begin
  frxRel.PrintOptions.ShowDialog := True;

  frxRel.Script.Variables['VENDEDOR']     := arrVenRep[cbxVenRep.ItemIndex];
  frxRel.Script.Variables['TIPO']         :=  'TIPO DE ' + String(arrVenRep[cbxVenRep.ItemIndex]) + ': ' + strDesTip;
  frxRel.Script.Variables['CONJUR']       := relRecebido.blnConJur;
  frxrel.Script.Variables['STATUS']       := 'STATUS: ' + IIF(rdgStatus.ItemIndex = 0,'ATIVO',IIF(rdgStatus.ItemIndex = 1,'INATIVO','TODOS'));
  frxRel.Script.Variables['DEPARTAMENTO'] := fStrTitulo(edtCodDep.Text, edtDesDep, arrDepart, strCodDep, 'DEPARTAMENTO');
  frxRel.Script.Variables['GERENTE']      := fStrTitulo(edtCodGerente.Text, edtDesGerente, arrGerente, strCodGer, 'GERENTE');
  frxRel.Script.Variables['CLIENTE']      := fStrTitulo(edtCodCli.Text, edtDesCli, arrCliente, strCodCli, 'CLIENTE');
  frxRel.Script.Variables['CLIENTEEXC']   := IIF(fEmptyStr(edtCliExc.Text), 'CLIENTE EXCLUIR: NENHUM', fStrTitulo(edtCliExc.Text, edtDesExc, arrCliExc, strCliExc, 'CLIENTE EXCLUIR'));

  If strTipImp = 'M' Then
    frxRel.Script.Variables['DOCCOM'] := AnsiUpperCase(fRemoveAcento(chkDocCom.Caption)) + IIF(chkDocCom.Checked, ': SIM', ': TODOS')
  Else
    frxRel.Script.Variables['DOCCOM'] := AnsiUpperCase(chkDocCom.Caption) + IIF(chkDocCom.Checked, ': SIM', ': TODOS');
end;

procedure TfrmRelComissaoVendedorCTR.mskDtaFinExit(Sender: TObject);
begin
  inherited;

  pSetaPeriodoRecibo;
end;

{*****************************************}
{* AJUSTA O PERCENTUAL DE COMISSÃO PARA  *}
{* NÃO ULTRAPASSAR O VALOR CONFIGURADO.  *}
{**************************************MV*}
procedure TfrmRelComissaoVendedorCTR.pAjustaPercentualDeComissao;
  Var
    fltPerCom: Double;
    fltNovaComissao: Double;
    intContador: Integer;
begin

  Try

    If (fltPmCmCr > 0) And (rdgPerCom.ItemIndex = 0) Then
    Begin
      qryRelatorio.Close;
      qryRelatorio.Open;

      pSetaClient(qryRelatorio);
      
      cdsRelatorio.Close;
      dspRelatorio.DataSet := qryRelatorio;
      cdsRelatorio.SetProvider(dspRelatorio);
      cdsRelatorio.Open;

      For intContador := 0 To cdsRelatorio.FieldCount -1 Do
      Begin
        cdsRelatorio.Fields[intContador].Required := False;
      End;

      cdsRelatorio.First;
      While (Not cdsRelatorio.Eof) Do
      Begin
        If (cdsRelatorio.FieldByName('CTR_RECCOM').AsFloat <> 0) Then
        Begin
          fltPerCom := cdsRelatorio.FieldByName('VALOR_COMISSAO').AsFloat /
                       cdsRelatorio.FieldByName('CTR_RECCOM').AsFloat * 100;

          fltPerCom := fFormataFloat(fltPerCom, 6);

          {*****************************************}
          {* RECALCULA O CAMPO "CTR_RECCOM", POIS  *}
          {* ASSIM NÃO PRECISA MUDAR O RESTANTE DO *}
          {* RELATÓRIO.                            *}
          {**************************************MV*}
          If (fltPerCom > fltPmCmCr) Then
          Begin
            fltPerCom := fltPmCmCr;
            fltNovaComissao := fFormataFloat(cdsRelatorio.FieldByName('CTR_VALREC').AsFloat * fltPerCom / 100, 6);

            cdsRelatorio.Edit;
            cdsRelatorio.FieldByName('VALOR_COMISSAO').AsFloat := fltNovaComissao;
            cdsRelatorio.Post;
          End;
        End;

        cdsRelatorio.Next;
      End;

      frxRelatorio.DataSet := cdsRelatorio;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAjustaPercentualDeComissao]');
    End;
  End;

end;

procedure TfrmRelComissaoVendedorCTR.pMontaResumoModalidades(
  qryAnalitico: TUniQuery);
  Var
    intContador : Integer;
    fltDinRec,
    fltChqRec,
    fltCarRec,
    fltOrdRec,
    fltFinRec,
    fltComImp,
    fltSemImp,
    fltFator,
    fltFatorCom,
    fltTotMod,
    fltTotRec,
    fltValCom: Double;
    strModalidade: String;
    blnProssegue: Boolean;
    strAutoInc: String;

  function fCampoStrValRec: String;
  begin
    Result := 'CTR_VALREC';
    If (rdgPerCom.ItemIndex = 1) Then
      Result := 'CTR_RECIPI';
  end;

  function fVistaPrazo: Double;
  begin
    If qryAnalitico.FieldByName('CTR_FORMAPG').AsString = 'A' Then
      Result := qryAnalitico.FieldByName('OPE_PERCOM').AsFloat
    Else
      Result := qryAnalitico.FieldByName('OPE_PERCO2').AsFloat;
  end;

  function fCalcValComOperador: Double;
  begin
    If relRecebido.blnConJur Then
      Result := fVistaPrazo * qryAnalitico.FieldByName(fCampoStrValRec).AsFloat / 100
    Else
      Result := fVistaPrazo * (qryAnalitico.FieldByName(fCampoStrValRec).AsFloat - qryAnalitico.FieldByName('CTR_VALJUR').AsFloat) / 100;
  end;

begin
  {*******************************************}
  {* MONTA RESUMOS POR VENDEDOR E MODALIDADE *}
  {****************************************MM*}

  prbProgresso.Max := qryAnalitico.RecordCount;
  prbProgresso.Position := 0;
  pnlInfo.Caption := 'Gerando o Resumo de Modalidades...';
  pnlInfo.Repaint;
  
  With qryAnalitico Do
  begin
    First;

    While Not Eof Do
    Begin
      prbProgresso.StepBy(1);
      Application.ProcessMessages;

      blnProssegue := (((strAutoInc <> FieldByName('CTR_AUTOINC').AsString) And (rdgTipRel.ItemIndex = 0) And (chkItens.Checked)) Or ((rdgTipRel.ItemIndex = 0) And (Not chkItens.Checked)) Or (rdgTipRel.ItemIndex <> 0));
      strAutoInc := FieldByName('CTR_AUTOINC').AsString;

      If Not blnProssegue Then
      Begin
        Next;
        Continue;
      End;

      fltTotRec := 0;
      fltFator  := (FieldByName('CTR_RECIPI').AsFloat * 100) / FieldByName('CTR_VALREC').AsFloat;

      For intContador := 0 To High(arrModalidade) Do
      Begin
        strModalidade := String(arrModalidade[intContador]);

        If cdsResumoMod.Locate('RMO_CODVEN;RMO_DESMOD;',
                               VarArrayOf([Trim(FieldByName('CTR_CODVEN').AsString),strModalidade]),[]) Then
          cdsResumoMod.Edit
        Else
          cdsResumoMod.Insert;

        fltValCom   := FieldByName('VALOR_COMISSAO').AsFloat;

        If (rdgPerCom.ItemIndex = 1) Then
          fltValCom := fCalcValComOperador;

        fltComImp   := 0;
        fltSemImp   := 0;
        //fltFatorCom := 0;

        fltDinRec := FieldByName('DINHEI').AsFloat;
        fltChqRec := FieldByName('CHQAVI').AsFloat + FieldByName('CHQPRE').AsFloat;
        fltCarRec := FieldByName('CARTAO').AsFloat;
        fltOrdRec := FieldByName('ORDPAG').AsFloat;
        fltFinRec := FieldByName('VALFIN').AsFloat;

        fltTotMod := Sum([fltDinRec, fltChqRec, fltCarRec, fltOrdRec, fltFinRec]);

        If fFormataFloat(fltTotMod, 2) <> fFormataFloat(FieldByName('CTR_VALREC').AsFloat, 2) Then
        Begin
          fltDinRec := fltDinRec + (FieldByName('CTR_VALREC').AsFloat - fltTotMod);
        End;

        cdsResumoMod.FieldByName('RMO_NOMVEN').AsString := FieldByName('CTR_CODVEN').AsString+'-'+FieldByName('OPE_NOMOPE').AsString; 
        cdsResumoMod.FieldByName('RMO_CODVEN').AsString := FieldByName('CTR_CODVEN').AsString;
        cdsResumoMod.FieldByName('RMO_DESMOD').AsString := strModalidade;

        If (strModalidade = 'DINHEIRO') Then
        Begin
          fltComImp := fltDinRec;
          fltSemImp := fltDinRec * (fltFator / 100);
        End
        Else If (strModalidade = 'CHEQUE') Then
        Begin
          fltComImp := fltChqRec;
          fltSemImp := fltChqRec * (fltFator / 100);
        End
        Else If (strModalidade = 'CARTAO') Then
        Begin
          fltComImp := fltCarRec;
          fltSemImp := fltCarRec * (fltFator / 100);
        End
        Else If (strModalidade = 'ORDEM') Then
        Begin
          fltComImp := fltOrdRec;
          fltSemImp := fltOrdRec * (fltFator / 100);
        End
        Else If (strModalidade = 'FINANCEIRO') Then
        Begin
          fltComImp := fltFinRec;
          fltSemImp := fltFinRec * (fltFator / 100);
        End;

        fltTotRec := fltTotRec + fltComImp;

        If (FieldByName('CTR_VALREC').AsFloat  <> 0) Then
        Begin
          fltFatorCom := (fltComImp /  FieldByName('CTR_VALREC').AsFloat);

          cdsResumoMod.FieldByName('RMO_COMIMP').AsFloat  := cdsResumoMod.FieldByName('RMO_COMIMP').AsFloat + fltComImp;
          cdsResumoMod.FieldByName('RMO_SEMIMP').AsFloat  := cdsResumoMod.FieldByName('RMO_SEMIMP').AsFloat + fltSemImp;
          cdsResumoMod.FieldByName('RMO_VALCOM').AsFloat  := cdsResumoMod.FieldByName('RMO_VALCOM').AsFloat + (fltValCom * fltFatorCom);
          cdsResumoMod.FieldByName('RMO_TOTCOM').AsFloat  := cdsResumoMod.FieldByName('RMO_TOTCOM').AsFloat + fltValCom;
        End;
        cdsResumoMod.Post;

      End;

      Next;
    End;

    First;
  End;

  pnlInfo.Caption := 'Abrindo Relatório...';
  pnlInfo.Repaint;
  prbProgresso.Position := 0;
end;

procedure TfrmRelComissaoVendedorCTR.pGravaComissao(strSQL: String);
  Var
    qryCom: TUniQuery;
    objGravaComissao: TGravaComissaoVen;
    strClient : String;
begin
  qryCom := fCriaQuery;
  objGravaComissao := TGravaComissaoVen.Create;
  Try
    objGravaComissao.pSetDtaVen(StrToDateDef(mskDtaVen.Text, 0));
    objGravaComissao.pSetCodCta(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text));
    objGravaComissao.pSetCodPor(fCfgSis('PGCPCV'));

    // Adiciona duplicatas da CADREC/X
    qryCom.SQL.Text := 'SELECT * FROM ('+ strSQL + ') TAB WHERE ROUND(VALOR_COMISSAO, 2) <> 0';
    pSetaParametros(qryCom);

    qryCom.Open;
    While Not qryCom.Eof Do
    Begin
      strClient := qryCom.FieldByName('CTR_CODCLI').AsString;

      If (qryCom.FindField('MODALIDADE') <> Nil) And
         (SameText(qryCom.FieldByName('MODALIDADE').AsString, relRecebido.strModConfirmacaoDocumento)) Then
      Begin
        strClient := fGetClienteDuplicata(qryCom.FieldByName('CTR_NUMDUP').AsString,
                                          qryCom.FieldByName('TABCTR').AsString);

        If fEmptyStr(strClient) Then
          strClient := qryCom.FieldByName('CTR_CODCLI').AsString;
      End;

      objGravaComissao.pAddDup(qryCom.FieldByName('CTR_NUMDUP').AsString,
                               IIF(qryCom.FindField('DOCUME') <> Nil, qryCom.FieldByName('DOCUME').AsString, ''),
                               strClient,
                               qryCom.FieldByName('CTR_CODVEN').AsString,
                               qryCom.FieldByName('TABCTR').AsString,
                               qryCom.FieldByName('TABELAUPDATE').AsString,
                               qryCom.FieldByName('VALOR_COMISSAO').AsFloat,
                               qryCom.FieldByName('CTR_SEQBAI').AsInteger);

      qryCom.Next;
    End;

    If objGravaComissao.fGravaComissao Then
      fMensagem('', 'Contas a pagar gravadas com sucesso!', ['&O k']);
  Finally
    FreeAndNil(qryCom);
    FreeAndNil(objGravaComissao);
  End;
End;

procedure TfrmRelComissaoVendedorCTR.pInicializaStringCamposTotalizadores;
begin
  If (chkItens.Checked) Then Begin
    strPerComAna    := TfrxMemoView(frxComissaoVendedorItensCTR_J.FindObject('rllPerComAna')).Memo.Text;
    strValComAna    := TfrxMemoView(frxComissaoVendedorItensCTR_J.FindObject('rllValComAna')).Memo.Text;
    strPerComVenAna := TfrxMemoView(frxComissaoVendedorItensCTR_J.FindObject('rllPerComVen')).Memo.Text;
    strValComVenAna := TfrxMemoView(frxComissaoVendedorItensCTR_J.FindObject('rllValComVen')).Memo.Text;
    strPerComTotAna := TfrxMemoView(frxComissaoVendedorItensCTR_J.FindObject('rllPerComTot')).Memo.Text;
    strValComTotAna := TfrxMemoView(frxComissaoVendedorItensCTR_J.FindObject('rllValComTot')).Memo.Text;
  End Else Begin
    strPerComAna    := TfrxMemoView(frxComissaoVendedorCTR_J.FindObject('rllPerComAna')).Memo.Text;
    strValComAna    := TfrxMemoView(frxComissaoVendedorCTR_J.FindObject('rllValComAna')).Memo.Text;
    strPerComVenAna := TfrxMemoView(frxComissaoVendedorCTR_J.FindObject('rllPerComVen')).Memo.Text;
    strValComVenAna := TfrxMemoView(frxComissaoVendedorCTR_J.FindObject('rllValComVen')).Memo.Text;
    strPerComTotAna := TfrxMemoView(frxComissaoVendedorCTR_J.FindObject('rllPerComTot')).Memo.Text;
    strValComTotAna := TfrxMemoView(frxComissaoVendedorCTR_J.FindObject('rllValComTot')).Memo.Text;

    strPerComGer    := TfrxMemoView(frxComissaoVendedorSintCTR_J.FindObject('rllPerComGer')).Memo.Text;
    strValComGer    := TfrxMemoView(frxComissaoVendedorSintCTR_J.FindObject('rllValComGer')).Memo.Text;
    strPerComVenSin := TfrxMemoView(frxComissaoVendedorSintCTR_J.FindObject('rllPerComVen')).Memo.Text;
    strPerCo2VenSin := TfrxMemoView(frxComissaoVendedorSintCTR_J.FindObject('rllPerCo2Ven')).Memo.Text;
    strValComVenSin := TfrxMemoView(frxComissaoVendedorSintCTR_J.FindObject('rllValComVen')).Memo.Text;
    strPerComTotSin := TfrxMemoView(frxComissaoVendedorSintCTR_J.FindObject('rllPerComTot')).Memo.Text;
    strPerCo2TotSin := TfrxMemoView(frxComissaoVendedorSintCTR_J.FindObject('rllPerCo2Tot')).Memo.Text;
    strValComTotSin := TfrxMemoView(frxComissaoVendedorSintCTR_J.FindObject('rllValComTot')).Memo.Text;
  End;
end;

procedure TfrmRelComissaoVendedorCTR.pHabilitaOpcoesPDF;
begin
  chkEjeVen.Enabled := ((rdgTipRel.ItemIndex = 0) And (rdgComRes.ItemIndex = 0)) And (Not chkPDFVen.Checked);
  If (Not chkEjeVen.Enabled) Then
    chkEjeVen.Checked := False;

  chkPDFVen.Enabled := ((rdgTipRel.ItemIndex = 0) And (rdgComRes.ItemIndex = 0));
  If (Not chkPDFVen.Enabled) Then
    chkPDFVen.Checked := False;

  fraDirPDF.Enabled := ((rdgTipRel.ItemIndex = 0) And (rdgComRes.ItemIndex = 0)) And (chkPDFVen.Checked);
  If (Not fraDirPDF.Enabled) Then
    fraDirPDF.edtDirectory.Clear;
end;

procedure TfrmRelComissaoVendedorCTR.pExportarPDFParaCadaVendedor(qckRel: TfrxReport);
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
