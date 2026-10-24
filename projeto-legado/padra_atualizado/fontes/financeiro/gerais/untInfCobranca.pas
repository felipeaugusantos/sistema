{***********************}
{* qryConCli -> CADCLI *}
{********************JB*}

unit untInfCobranca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, Mask, MaskEditFocus, System.StrUtils, DB, Uni, untTypesSistema,
  AppEvnts, UniClientDataSet, UniDataSetProvider, ComCtrls, DBCtrls, DBEditFocus, ImgList,
  BitBtnLockedIncrem, Datasnap.Provider, frxClass, frxExportCSVTestabilidade,
  System.ImageList, Datasnap.DBClient, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, System.Types,
  untFrameCentroCustoEditFocus, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxLabel,
  DBMemoFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, MemDS,
  DBAccess, QColorLabel, untMostraDebCtrChq2, Vcl.OleCtrls, SHDocVw,
  dxScreenTip, dxCustomHint, cxHint, dxGDIPlusClasses, cxImage;

type
  TfrmInfCobranca = class(TfrmPai)
    pnlFiltros: TPanel;
    pnlDados: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    dbgDados: TDBGridCitel;
    dtsInfCob: TDataSource;
    dspConsulta: TUniDataSetProvider;
    cdsInfCob: TUniClientDataSet;
    pnlInfCliente: TPanel;
    imglStatus: TImageList;
    Panel2: TPanel;
    pnlLegendas: TPanel;
    Shape1: TShape;
    Label5: TLabel;
    shpPriCom: TShape;
    lblPriCom: TLabel;
    chkPrimeiraCompra: TCheckBox;
    Shape2: TShape;
    Label7: TLabel;
    btnAgeHis: TBitBtnLocked;
    btnAgendamentoReligacao: TBitBtnLocked;
    btnHistorico: TBitBtnLocked;
    btnMudaOrdem: TBitBtnLocked;
    Label9: TLabel;
    edtCodPortador: TEditFocus;
    edtDesPortador: TEditFocus;
    edtCliVen: TEditFocus;
    edtDesCliVen: TEditFocus;
    edtVenDup: TEditFocus;
    edtDesVenDup: TEditFocus;
    Label12: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    btnCadCli: TBitBtnLocked;
    chkReligacao: TCheckBox;
    pnlReligacao: TPanel;
    fraCentroCusto: TfraCentroCustoEditFocus;
    grdDados: TcxGridCitel;
    grdDadosTableView1: TcxGridDBTableViewCitel;
    grdDadosDATA: TcxGridDBColumn;
    grdDadosAGEREL: TcxGridDBColumn;
    grdDadosTableCOB_CODOPE: TcxGridDBColumn;
    grdDadosLevel1: TcxGridLevel;
    btnRelAgendRelig: TBitBtnLocked;
    rdgEmpresa: TRadioGroup;
    edtDesCnd: TEditFocus;
    edtCodCnd: TEditFocus;
    lblCndPag: TLabel;
    lblLegenda: TColorLabel;
    edtAgeRel: TEditFocus;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnAgendarHistorico: TBitBtnLocked;
    grdDadosCob_DtaLan: TcxGridDBColumn;
    fraCentroCustoExceto: TfraCentroCustoEditFocus;
    Label27: TLabel;
    edtCodPortadorExceto: TEditFocus;
    edtDesPortadorExceto: TEditFocus;
    Panel1: TPanel;
    edtTotRecOrig: TEditFocus;
    edtTotRecCorr: TEditFocus;
    edtTotCheques: TEditFocus;
    edtTotVencido: TEditFocus;
    edtTotAVencer: TEditFocus;
    edtTotJuros: TEditFocus;
    edtTotGeral: TEditFocus;
    shpMultSel: TShape;
    pnlInfoCli: TPanel;
    Label14: TLabel;
    spbFone1: TSpeedButton;
    Label15: TLabel;
    Label16: TLabel;
    spbFone2: TSpeedButton;
    Label17: TLabel;
    Label18: TLabel;
    spbFax: TSpeedButton;
    Label19: TLabel;
    Label20: TLabel;
    spbCel: TSpeedButton;
    Label23: TLabel;
    Label24: TLabel;
    Label192: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label21: TLabel;
    Label13: TLabel;
    Label26: TLabel;
    dbeFone01: TDBEditFocus;
    dbeRamal1: TDBEditFocus;
    dbeFone02: TDBEditFocus;
    dbeRama2: TDBEditFocus;
    dbeNumFax: TDBEditFocus;
    dbeRama3: TDBEditFocus;
    dbeNumCel: TDBEditFocus;
    dbeContat: TDBEditFocus;
    dbeEmail: TDBEditFocus;
    dbeEmail2: TDBEditFocus;
    DBEditFocus1: TDBEditFocus;
    dbeUltAge: TDBEditFocus;
    dbeUltRel: TDBEditFocus;
    dbemailCob1: TDBEditFocus;
    dbemailCob2: TDBEditFocus;
    Panel3: TPanel;
    lblHist: TLabel;
    btnDpAberto: TBitBtnLocked;
    Panel4: TPanel;
    Label2: TLabel;
    mskDtaIni: TcxDateEdit;
    Label3: TLabel;
    mskDtaFin: TcxDateEdit;
    Label4: TLabel;
    edtVrMinimo: TEditFocus;
    btnCarrTitulos: TBitBtnLocked;
    Label29: TLabel;
    edtCodRep: TEditFocus;
    edtDescRep: TEditFocus;
    Label30: TLabel;
    dbeNomCac: TDBEditFocus;
    btnResFin: TBitBtnLocked;
    mskDtaIniRelig: TcxDateEdit;
    Label25: TLabel;
    mskDtaFinRelig: TcxDateEdit;
    Label22: TLabel;
    btnRelatorio: TBitBtnLocked;
    btnAcompEntrega: TBitBtnLocked;
    pnlweb: TPanel;
    mdbHisCob: TDBMemoFocus;
    WebBrowser: TWebBrowser;
    imgInformacoes: TcxImage;
    balInformacoes: TcxHintStyleController;
    Label31: TLabel;
    edtCodRed: TEditFocus;
    edtDesRed: TEditFocus;
    pnlTipCli: TPanel;
    Label28: TLabel;
    edtTipCli: TEditFocus;
    edtDescTipCli: TEditFocus;
    procedure pCarregaCliente;
    procedure pLimpaCampos;

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;

    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAgendamentoReligacaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnHistoricoClick(Sender: TObject);
    procedure btnDpAbertoClick(Sender: TObject);
    procedure btnAgeHisClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgDadosTitleClick(Column: TColumn);
    procedure dbgDadosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure spbFone1Click(Sender: TObject);
    procedure cdsInfCobAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodPortadorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPortadorExit(Sender: TObject);
    procedure edtCliVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtVenDupKeyPress(Sender: TObject; var Key: Char);
    procedure edtCliVenExit(Sender: TObject);
    procedure edtVenDupExit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnCarrTitulosClick(Sender: TObject);
    procedure btnCadCliClick(Sender: TObject);
    procedure chkReligacaoClick(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure grdDadosAGERELGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure btnRelAgendReligClick(Sender: TObject);
    procedure edtCodCndExit(Sender: TObject);
    procedure edtCodCndKeyPress(Sender: TObject; var Key: Char);
    procedure fraCentroCustoExcetoedtCodEveExit(Sender: TObject);
    procedure edtCodPortadorExcetoExit(Sender: TObject);
    procedure edtCodPortadorExcetoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAgendarHistoricoClick(Sender: TObject);
    procedure fraCentroCustoExcetoedtCodEveKeyPress(Sender: TObject;
      var Key: Char);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure edtAgeRelExit(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edtTipCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtTipCliExit(Sender: TObject);
    procedure fraCentroCustoedtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepExit(Sender: TObject);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure btnResFinClick(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure btnAcompEntregaClick(Sender: TObject);
    procedure dtsInfCobDataChange(Sender: TObject; Field: TField);
    procedure imgInformacoesMouseEnter(Sender: TObject);
    procedure imgInformacoesMouseLeave(Sender: TObject);
    procedure edtCodRedExit(Sender: TObject);
    procedure edtCodRedKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryInfCob: TUniQuery;
    qryConCli: TUniQuery;
    qryConEmp: TUniQuery;
    qryConOpe: TUniQuery;

    cdsHistCob: TUniClientDataSet;
    dtsHistCob: TDataSource;

    cdsUltDadosAgCob: TUniClientDataSet;
    dtsUltDadosAgCob: TDataSource;

    cdsDuplicatas: TUniClientDataSet;

    cdsDadosBaixa : TUniClientDataSet;

    cdsDuplicatasClientes : TUniClientDataSet;  //dataset de cups e clientes marcados;

    blnDescFinanSomenteAteVenc: Boolean;

    arrRede    : TConsultasArray;
    arrVenDup  : TConsultasArray;
    arrEmp     : TConsultasArray;
    arrCliVen  : TConsultasArray;
    arrPortador: TConsultasArray;
    arrEvento  : TConsultasArray;
    arrEventoExceto : TConsultasArray;
    arrPortadorExceto : TConsultasArray;
    arrCndPag  : TConsultasArray;
    arrTipCli  : TConsultasArray;

    strEmpresa : String;
    strPortador: String;
    strAceCtr  : String;
    strEvento  : String;

    strRede    : String;

    fltTotRecOrig : Real;
    fltTotRecCorr : Real;
    fltTotCheques : Real;
    fltTotVencido : Real;
    fltTotAVencer : Real;
    fltTotGeral   : Real;
    fltTotJuros   : Real;

    Doc: Variant;

    procedure pStatusTelefone(btnTel: TSpeedButton; blnClick: Boolean = False);
    procedure pAtualizaStatusFones;
    procedure pCarregaEmpresa;
    procedure pCarregaEvento;
    function fFormataClafis(strClafis: String): String;
    procedure pBuscaHistoricoCobranca(strCodCli : String);
    function fGetSqlTemporaria(AListaClientes: TStringBuilder) : String;
    function fGetSqlQtdeAgendamentosEmAberto : String;
    procedure pCarregaEventoExceto;
    procedure pSelecionaCliente;
    function fRetornaDuplicatasClientesSelecionados(cdsGen: TUniClientDataSet): TUniClientDataSet;
    function fTemRegistrosMarcados: Boolean;
    procedure pMostraTotalizador;
    procedure pLimpaTotalizadores;
    function fBaixaCliente: Boolean;
    function fRetornaFiltroCliente: string;
    procedure pBaixaAgClientes;
    procedure pCarregaDadosBaixa;
    procedure pDesmarcarTodos;
    procedure pMarcarTodos;
    procedure VerificaRegMarcados;
    function fSqlAgendadosParaHoje: string;
    procedure pAcertaExibicao;
    procedure pBuscaUltimosDadosAg(strCodCli: String);
    procedure pAjustarBtnSair;
    procedure pAtualizaAgendadosHoje;
    procedure pCarregaRepr(strCodigo: String; edtDescricao: TEditFocus);
    procedure pCriaTemporariaRel;
    procedure pInsereRegTemporariaRel;
    procedure pExcluiTemporariaRel;
    procedure cdsHistCobAfterScroll(DataSet: TDataSet);
    procedure pCarregaRede;
    procedure MontarFiltroClientes(ADataSet: TDataSet;
                                   var AClientes: TStringBuilder;
                                   const ACampoChave: string = 'CODCLI');
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strAgeRel     : String;
    blnFiltraCli  : Boolean;

    { Public declarations }
  end;


implementation

uses  untConsultas, untPesqAux,untFuncoesGenerica,untfuncoesSimples,
      untInfCobrancaAgeRelHist, untInfCobrancaAgeRel,
      untFuncoesAuxiliares, System.UITypes, untFuncoesConsulta,
      untGravando, untCadClientes, untDocumento, untIDocumento, untFuncoesRel, untFuncoesRel2,
      untResFinanceiro, untConsultaPedidos;

{$R *.dfm}

procedure TfrmInfCobranca.edtAgeRelExit(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtAgeRel, True) Then
     pSetFocus(EdtVenDup);
end;

procedure TfrmInfCobranca.edtCliVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCliVen, edtDesCliVen, arrCliVen, fRetNomeOperador, nil, 'do Vendedor',0, False, 'Código', False);

end;

procedure TfrmInfCobranca.edtCliVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtCliVen, edtDesCliVen, Nil, Key, arrCliVen, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmInfCobranca.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobranca.edtCodCndExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCnd,edtDesCnd,arrCndPag,fRetDesConPag,Nil,'da Condição de Pagamento',0, False, 'Código', False);
end;

procedure TfrmInfCobranca.edtCodCndKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not fCfgSisL('USACND', varBoolean) Then
    Exit;

  If fPesqCondicoesPgto(Self, edtCodCnd, edtDesCnd, Nil, Key, arrCndPag, False) Then
  Begin
    If fValidaCampos(edtCodCnd, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobranca.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  // seleção multi empresa com controle dos digitos 000 quando mais de uma empresa
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);

end;

procedure TfrmInfCobranca.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobranca.edtCodPortadorExcetoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPortadorExceto, edtDesPortadorExceto, arrPortadorExceto, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmInfCobranca.edtCodPortadorExcetoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPortadorExceto,
                   edtDesPortadorExceto,
                   nil,
                   Key,
                   arrPortadorExceto,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) then
  Begin
    If (fValidaCampos(edtCodPortadorExceto, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobranca.edtCodPortadorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPortador, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmInfCobranca.edtCodPortadorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPortador,
                   edtDesPortador,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) then
  Begin
    If (fValidaCampos(edtCodPortador, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobranca.edtCodRedExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodRed,edtDesRed,arrRede,nil,fRetNomeRedeLoja,'da rede', 5);
end;

procedure TfrmInfCobranca.edtCodRedKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqRedeLojas(Self, edtCodRed, edtDesRed, Nil, Key, arrRede, False) Then
  Begin
    If fValidaCampos(edtCodRed, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobranca.edtCodRepExit(Sender: TObject);
begin
  inherited;
  //pEdtCodSelectExit(edtCodRep, edtDescRep, arrRepCli, Nil, fRetNomVendRep, 'do Representante');
end;

procedure TfrmInfCobranca.edtCodRepKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodRep, edtDescRep, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodRep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobranca.edtTipCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtTipCli, edtDescTipCli, arrTipCli, Nil, fRetDescTipoCli, 'do Tipo Cliente');
end;

procedure TfrmInfCobranca.edtTipCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqTipoCliente(Self, edtTipCli, edtDescTipCli, nil, Key, arrSel) Then
  Begin
    If (fValidaCampos(edtTipCli, True)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmInfCobranca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {********************************}
    {* VALIDA O CODIGO DO CLIENTE   *}
    {*****************************LB*}
    If (Sender = edtCodCli) Then
    Begin

      pCarregaCliente;
      If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO','Cliente não cadastrado!',['&O K']);
        Result := False;
      End;

    End
    else If (Sender = edtTipCli) and (pnlTipCli.Visible) Then
    Begin

      edtTipCliExit(nil);
      If fEmptyStr(edtDescTipCli.Text) Then
      Begin
        fMensagem('ATENÇÃO','Tipo de Cliente não cadastrado!',['&O K']);
        Result := False;
      End;

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA REDE DE LOJAS      *}
    {**************************************IC*}
    Else If (Sender = edtCodRed) Then
    Begin
      If Not fEmptyStr(edtCodRed.Text) Then
      Begin
        If Not SameText(edtCodRed.Text, '00000') Then
        Begin
          SetLength(arrRede, 0);
          strRede := '';

          pCarregaRede;
          If fEmptyStr(edtDesRed.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa rede de lojas não está cadastrada!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        if (edtCodRep.Text = '00000') Then
            edtDesRed.Text := '+1'
        else
            edtDesRed.Text := 'TODOS';
      End;

    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO REPRESENTANTE      *}
    {**************************************MV*}
    Else If (Sender = edtCodRep) Then
    Begin

      If Not fEmptyStr(edtCodRep.Text) And (edtCodRep.Text <> '00000') Then
      Begin

        pCarregaRepr(edtCodRep.Text, edtDescRep);
        If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse representante não está cadastrado!', ['&Ok']);
          Result := False;
        End

      End
      Else
      Begin

        if (edtCodRep.Text = '00000') Then
            edtDescRep.Text := '+1'
        else
            edtDescRep.Text := 'TODOS';

      End;

    End

    Else If Sender = edtCodPortador Then
    Begin
      If Not fEmptyStr(edtCodPortador.Text) And (edtCodPortador.Text <> '00000') Then
      Begin

        edtDesPortador.Text := fRetNomPortador(edtCodPortador.Text);

        If fEmptyStr(edtDesPortador.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If (High(arrEmp) > 0) Then
        Begin
            If Not fEmpresaTemAcessoPortador(edtCodPortador.Text,arrEmp) Then
              Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtCodPortador.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPortador.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        if (edtCodPortador.Text = '00000') Then
          edtDesPortador.Text := '+1'
        else
          edtDesPortador.Text := 'TODOS';

    End

    Else If Sender = edtCodPortadorExceto Then
    Begin
      If Not fEmptyStr(edtCodPortadorExceto.Text) And (edtCodPortadorExceto.Text <> '00000') Then
      Begin

        edtDesPortadorExceto.Text := fRetNomPortador(edtCodPortadorExceto.Text);

        If fEmptyStr(edtDesPortadorExceto.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPortadorExceto.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPortadorExceto.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
        if (edtCodPortadorExceto.Text = '00000') Then
          edtDesPortadorExceto.Text := '+1'
        else
          edtDesPortadorExceto.Text := 'TODOS';

    End

    Else
    {********************************}
    {* VALIDA A DATA INICIAL       *}
    {*****************************LB*}
    If (Sender = mskDtaIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      begin
        mskDtaFin.Clear;
        mskDtaFin.Enabled := False;
      end
      Else
        mskDtaFin.Enabled := True;

    End

    Else
    {********************************}
    {* VALIDA A DATA FINAL          *}
    {*****************************LB*}
    If (Sender = mskDtaFin) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else
        If Not fValidaPeriodo(mskDtaIni.Text,mskDtaFin.Text) Then
        Begin
          fMensagem('ATENÇÃO','A Data Final deve ser maior ou igual a Data Inicial!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else

    If chkReligacao.Checked And (Sender = mskDtaIniRelig) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIniRelig.Text)) Then
      begin
        mskDtaFinRelig.Clear;
        mskDtaFinRelig.Enabled := False;
        EdtAgeRel.Enabled := False;
      end
      Else
        mskDtaFinRelig.Enabled := True;
    End
    Else

    If chkReligacao.Checked And (Sender = mskDtaFinRelig) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinRelig.Text)) Then
      begin
        EdtAgeRel.Enabled := False;
      end
      Else
        EdtAgeRel.Enabled := True;
    End
    Else

    If chkReligacao.Checked And (Sender = EdtAgeRel) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniRelig.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinRelig.Text))) Then
      Begin

         If (edtAgeRel.Text <> 'A') And (edtAgeRel.Text <> 'R') And (edtAgeRel.Text <> 'T')  Then
         Begin
           fMensagem('ATENÇÃO','O campo do filtro de Agendamentos deve conter somente A, R ou T!',['&OK']);
           Result := False;
         End;

      End;

    End
    Else

    If chkReligacao.Checked And (Sender = mskDtaFinRelig) Then
    Begin

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniRelig.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFinRelig.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else
        If Not fValidaPeriodo(mskDtaIniRelig.Text,mskDtaFinRelig.Text) Then
        Begin
          fMensagem('ATENÇÃO','A Data Final deve ser maior ou igual a Data Inicial!',['&OK']);
          Result := False;
        End;
      End;
    End

    Else

    {********************************}
    {* VALIDA O VALOR MINIMO        *}
    {*****************************LB*}
    If (Sender = edtVrMinimo) Then
    Begin
      If (edtVrMinimo.Text < '0') Then
      Begin
        fMensagem('ATENÇÃO','O Valor Mínimo deve ser maior ou igual a Zero!',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin
      If (not fEmptyStr(edtCodEmp.text)) and ( Not SameText(edtCodEmp.Text, '000')) Then
      Begin
        SetLength(arrEmp, 0);

        pCarregaEmpresa;
        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin
        If Not SameText(fraCentroCusto.edtCodEve.Text, '00000') Then
        Begin
          SetLength(arrEvento, 0);
          strEvento := '';

          pCarregaEvento;
          If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='P') Then
          Begin
            fMensagem('ATENÇÃO', 'Esse evento pode ser aplicado somente às contas a pagar!',['&OK']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Text := 'TODOS';
      End;
    End

    Else If (Sender = fraCentroCustoExceto.edtCodEve) Then
    Begin

      If Not fEmptyStr(fraCentroCustoExceto.edtCodEve.Text) And (fraCentroCustoExceto.edtCodEve.Text <> '00000') Then
      Begin
          SetLength(arrEvento, 0);
          strEvento := '';

          pCarregaEventoExceto;
          If fEmptyStr(fraCentroCustoExceto.edtDesEve.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If (fRetTipoEvento(fraCentroCustoExceto.edtCodEve.Text)='P') Then
          Begin
            fMensagem('ATENÇÃO', 'Esse evento pode ser aplicado somente às contas a pagar!',['&OK']);
            Result := False;
          End;
      End
      Else
      Begin
        if (fraCentroCustoExceto.edtCodEve.Text = '00000') Then
            fraCentroCustoExceto.edtDesEve.Text := '+1'
        else
            fraCentroCustoExceto.edtDesEve.Text := 'TODOS';
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmInfCobranca.grdDadosAGERELGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  If (AText = 'R') Then
      AText := 'Relig.'
  Else
  If (AText = 'A') Then
    AText := 'Agend.';
end;

procedure TfrmInfCobranca.imgInformacoesMouseEnter(Sender: TObject);
begin
  inherited;
  balInformacoes.ShowHint(Mouse.CursorPos.X + 15,
                          Mouse.CursorPos.Y + 15,
                          'Configuração CFG_EXIPOR ativada',
                          'As duplicatas que estão sendo somadas são:' + #13 +
                            '->que não possuem portador vinculado;' + #13 +
                            '->que possuem portadores que estejam com a opção "Exibir títulos deste portador na ' + #13 +
                            '  conta corrente e no limite de crédito do cliente" marcada.');
end;

procedure TfrmInfCobranca.imgInformacoesMouseLeave(Sender: TObject);
begin
  inherited;
  balInformacoes.HideHint;
end;

procedure TfrmInfCobranca.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  With qryConCli Do
  Begin
    If fEmptyStr(edtCodCli.Text) Then
      edtNomCli.Text := 'TODOS '
    Else
      edtNomCli.Text := FieldbyName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmInfCobranca.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmInfCobranca.FormCreate(Sender: TObject);
begin
  inherited;

  {Se resolução disponível for inferior à (1024 x 768), maximiza o historico de cobrança}
  If (Screen.Width > 1024) Then
  Begin
     mdbHisCob.align  := alNone;
     mdbHisCob.top    := grddados.Top;
     mdbHisCob.left   := grddados.width + 2;
     mdbHisCob.width  := 500;
     mdbHisCob.Height := grddados.Height;

     pnlweb.Align  := AlNone;
     pnlweb.top    := grddados.Top;
     pnlweb.left   := grddados.width + 2;
     pnlweb.width  := 500;
     pnlweb.Height := grddados.Height;

     //pnlBotoes.height := btnMudaOrdem.Height + 2;
     //FlwBotoes.Height := pnlBotoes.height;

     //linha de botoes

     // AUMENTA CAMPOS DOS FILTROS DA TELA
     edtNomEmp.Width  := 280;
     edtDesCnd.Width  := 280;
     edtDescRep.Width := 280;
     edtDescTipCli.Width := 280;
     edtdesPortadorExceto.Width := 280;
     fraCentroCustoExceto.Width := fraCentroCustoExceto.Width + 75;
     fraCentroCustoExceto.edtDesEve.Width := 280;
  End
  Else
  Begin
     pnlBotoes.height := 73;
  End;

  blnDescFinanSomenteAteVenc := (fCfgSis('UTDEFN') = '2');
  qryConCli                  := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConEmp                  := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConOpe                  := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryInfCob                  := fCriaQuery;
  dspConsulta.DataSet        := qryInfCob;
  dtsInfCob.DataSet          := cdsInfCob;

  edtVrMinimo.Text           := '0,00';
  blnFiltraCli               := False;
  //Seleciona a permissão de Baixa do Contas a Receber do usuário logado
  strAceCtr := fCampoTabela('OPE_EMPCTR', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
  chkReligacao.Checked := False;

  cdsHistCob := TUniClientDataSet.Create(Self);
  dtsHistCob := fCriaDataSource(cdsHistCob);
  grdDadosTableView1.DataController.DataSource := dtsHistCob;
  mdbHisCob.DataSource := dtsHistCob;

  If not Assigned(WebBrowser.Document) then
     WebBrowser.Navigate('about:blank');

  cdsUltDadosAgCob     := TUniClientDataSet.Create(Self);
  dtsUltDadosAgCob     := fCriaDataSource(cdsUltDadosAgCob);
  dbeUltAge.DataField  := 'ULTAGENDAMENTO';
  dbeUltAge.DataSource := dtsUltDadosAgCob;
  dbeUltRel.DataField  := 'ULTRELIGACAO';
  dbeUltRel.DataSource := dtsUltDadosAgCob;

end;

function TfrmInfCobranca.fSqlAgendadosParaHoje: string;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   COB_CODCLI AS CODCLI ';
  Result := Result + ' FROM ';
  Result := Result + '   CADCOB ';
  Result := Result + ' WHERE ';
  Result := Result + '   ( COB_DTAAGE = ' + fCurrentDate + ' OR ';
  Result := Result + '     COB_DTAREL = ' + fCurrentDate + ' )  ';

  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMPCCC') = '1' Then
    Result := Result + '   AND COB_CODEMP IN (' + fRetStrToSqlIn(strEmpAcessoUsuarioLogado) + ') ';

  Result := Result + ' GROUP BY ';
  Result := Result + '   CODCLI ';
end;


procedure TfrmInfCobranca.pCriaTemporaria;
  Var
    qryAgendados: TUniQuery;
    qryCheques: TUniQuery;
    qryDuplicatas: TUniQuery;
    blnMostraChq : Boolean;
    strCndPag: String;
    prcScroll: TprcScroll;
    LClienteAtual: String;
    LListaClientes: TStringBuilder;

begin

  Screen.Cursor         := crHourGlass;
  cdsInfCob.AfterScroll := Nil;
  pDeletaTemporaria;

  pLimpaTotalizadores();

  if Assigned(cdsDuplicatasClientes) then
    pFreeAndNil(cdsDuplicatasClientes);

  cdsDuplicatasClientes := TUniClientDataSet.Create(Self);

  qryAgendados := fCriaQuery(Self);

  qryAgendados.Close;
  qryAgendados.SQL.Clear;
  qryAgendados.SQL.Add(fSqlAgendadosParaHoje);
  qryAgendados.Open;

  qryAgendados.IndexFieldNames := 'CODCLI';


  qryDuplicatas := fCriaQuery(Self);

  qryDuplicatas.Close;
  qryDuplicatas.SQL.Clear;
  qryDuplicatas.SQL.Add(' SELECT ');
  qryDuplicatas.SQL.Add(' ''D'' AS MARDES, C.CTR_NUMDUP, C.CTR_PARCEL, C.CTR_CODEMP, C.CTR_VALJUR, C.AUTOINCREM,  ');
  qryDuplicatas.SQL.Add(' C.CTR_CODCLI AS CODCLI, C.CTR_CODCLI, C.CTR_ESPDOC, C.CTR_VALORI, C.CTR_DTAVEN, C.CTR_DTAREC, C.CTR_JURSUJ, C.CTR_DESSUJ, ');

  //CRIAÇÃO DO CAMPO DE VALCAL UTILIZADO NO HISTORICO DA DUPCOB;
  qryDuplicatas.SQL.Add('CTR_VALORI AS CTR_VALCAL, ');

  If blnDescFinanSomenteAteVenc Then
  begin
    qryDuplicatas.SQL.Add(' IF((C.CTR_DTAVEN < CURDATE()), ');
    qryDuplicatas.SQL.Add('    (C.CTR_VALDUP + IFNULL(C.CTR_JURSUJ, 0) + IFNULL(C.CTR_DESCOB, 0) - 0), ');
    qryDuplicatas.SQL.Add('    (C.CTR_VALDUP + IFNULL(C.CTR_JURSUJ, 0) + IFNULL(C.CTR_DESCOB, 0) - IFNULL(C.CTR_DESSUJ, 0))) AS CTR_VALDUP, ');
    qryDuplicatas.SQL.Add(' IF((C.CTR_DTAVEN < CURDATE()), (C.CTR_VALDUP + IFNULL(C.CTR_JURSUJ, 0) + IFNULL(C.CTR_DESCOB, 0) - 0), 0) AS CTR_DUPVEN, ');
    qryDuplicatas.SQL.Add(' IF((C.CTR_DTAVEN >= CURDATE()), (C.CTR_VALDUP + IFNULL(C.CTR_JURSUJ, 0) + IFNULL(C.CTR_DESCOB, 0) - IFNULL(C.CTR_DESSUJ, 0)), 0) AS CTR_DUPAVE, ');
  end
  Else
  begin
    qryDuplicatas.SQL.Add('(C.CTR_VALDUP + IFNULL(C.CTR_JURSUJ, 0) + IFNULL(C.CTR_DESCOB, 0) - IFNULL(C.CTR_DESSUJ, 0)) AS CTR_VALDUP, ');
    qryDuplicatas.SQL.Add(' IF((C.CTR_DTAVEN < CURDATE()), (C.CTR_VALDUP + IFNULL(C.CTR_JURSUJ, 0) + IFNULL(C.CTR_DESCOB, 0) - IFNULL(C.CTR_DESSUJ, 0)), 0) AS CTR_DUPVEN, ');
    qryDuplicatas.SQL.Add(' IF((C.CTR_DTAVEN >= CURDATE()), (C.CTR_VALDUP + IFNULL(C.CTR_JURSUJ, 0) + IFNULL(C.CTR_DESCOB, 0) - IFNULL(C.CTR_DESSUJ, 0)), 0) AS CTR_DUPAVE, ');
  end;

  //CRIAÇÃO DO CAMPO DE TOTAL DE JUROS PARA DEPOIS SER CALCULADO.
  qryDuplicatas.SQL.Add('C.CTR_VALORI AS TotalJuros ');

  qryDuplicatas.SQL.Add('FROM CADREC C ');
  qryDuplicatas.SQL.Add('LEFT JOIN CADPOR P ');
  qryDuplicatas.SQL.Add('          ON P.POR_CODPOR=CTR_CODPOR ');
  qryDuplicatas.SQL.Add('WHERE TRUE ');

  If rdgEmpresa.ItemIndex = 0 Then   //faturamento
  Begin

    If (Not fEmptyStr(edtCodEmp.Text)) AND (Pos(edtNomEmp.Text,'+1') = 0 ) Then
      qryDuplicatas.SQL.Add(' AND C.CTR_CODEMP = :CODEMP  AND ');

    if Pos(edtNomEmp.Text,'+1') > 0 then
      qryDuplicatas.SQL.Add(fStrLocate(edtCodEmp,  arrEmp,  'C.CTR_CODEMP', 'CODEMP') + ' AND ')
    else
    if (Pos(edtNomEmp.Text,'TODAS') > 0) or (fEmptyStr(edtCodEmp.Text) and fEmptyStr(edtNomEmp.text)) then
      qryDuplicatas.SQL.Add('  AND C.CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') AND ');

  End
  Else                               // Origem
  Begin

    // Somente das empresas que o operador tem direito de acesso.
    If (Not fEmptyStr(edtCodEmp.Text)) AND (Pos(edtNomEmp.Text,'+1') = 0 ) Then
      qryDuplicatas.SQL.Add(' AND IFNULL(C.CTR_EMPORI,C.CTR_CODEMP) = :CODEMP  AND ');

    if Pos(edtNomEmp.Text,'+1') > 0 then
      qryDuplicatas.SQL.Add(fStrLocate(edtCodEmp,  arrEmp,  'IFNULL(C.CTR_EMPORI,C.CTR_CODEMP)', 'CODEMP') + ' AND ')
    else
    if (Pos(edtNomEmp.Text,'TODAS') > 0) or (fEmptyStr(edtCodEmp.Text) and fEmptyStr(edtNomEmp.text)) then
      qryDuplicatas.SQL.Add('  AND IFNULL(C.CTR_EMPORI,C.CTR_CODEMP) IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') AND ');

  End;

  qryDuplicatas.SQL.Add(' C.CTR_DTAREC IS NULL ');

  If Not fEmptyStr(fCfgSis('POOCRE')) Then
    qryDuplicatas.SQL.Add( 'AND IF((C.CTR_VALDUP < 0),IFNULL(C.CTR_CODPOR,"") <> ' + String(fCfgSis('POOCRE')).QuotedString + ',TRUE) ');

  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
  Begin
    qryDuplicatas.SQL.Add(fStrLocate(fraCentroCusto.edtCodEve, arrEvento, 'C.CTR_CODEVE', 'CODEVE'));
    pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryDuplicatas);
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And
     (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
  Begin
    qryDuplicatas.SQL.Add(' AND C.CTR_DTAVEN BETWEEN ' + fCurrentDate(StrToDate(mskDtaIni.Text)) + ' AND ' +
                                                         fCurrentDate(StrToDate(mskDtaFin.Text)) + '     ');
  End;

  If Not fEmptyStr(edtCodCli.Text) Then
    qryDuplicatas.SQL.Add(' AND C.CTR_CODCLI = ' + QuotedStr(edtCodCli.Text) + ' ');

  If Not fEmptyStr(edtVenDup.Text) Then
    qryDuplicatas.SQL.Add(' AND C.CTR_CODVEN = ' + QuotedStr(edtVenDup.Text) + ' ');

  If (edtCodPortador <> Nil) And (arrPortador <> Nil) Then
  Begin
    If Not fEmptyStr(edtCodPortador.Text) Then
    begin
      qryDuplicatas.SQL.Add(' ' + fStrLocate(edtCodPortador,arrPortador,'C.CTR_CODPOR','CODPOR'));
      pSetaParam(edtCodPortador.Text, arrPortador, strPortador, 'CODPOR', qryDuplicatas);
    end
    Else If fCfgSis('DACPOR', VarBoolean) Then
    Begin
      qryDuplicatas.SQL.Add('AND (IFNULL(C.CTR_CODPOR, "") = "" ');
      qryDuplicatas.SQL.Add(' OR LOCATE(C.CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ');
    End;
  End;

  //Cond. Pagto.
  If Not fEmptyStr(edtCodCnd.Text) Then
  begin
     qryDuplicatas.SQL.Add(' ' + fStrLocate(edtCodCnd,  arrCndPag,  'C.CTR_CODCND', 'CODCND'));
     pSetaParam(edtCodCnd.Text, arrCndPag, strCndPag, 'CODCND', qryDuplicatas);
  end;

 //EXCETO PORTADOR
  If (edtCodPortadorExceto <> Nil) And (arrPortadorExceto <> Nil) Then
  Begin
    If Not fEmptyStr(edtCodPortadorExceto.Text) Then
    begin
      qryDuplicatas.SQL.Add(' AND IFNULL(C.CTR_CODPOR," ") NOT IN('+fRetArrToSQLIn(arrPortadorExceto,edtCodPortadorExceto.Text)+')');
    end
    Else If fCfgSis('DACPOR', VarBoolean) Then
    Begin
      qryDuplicatas.SQL.Add('AND (IFNULL(C.CTR_CODPOR, "") = "" ');
      qryDuplicatas.SQL.Add(' OR LOCATE(C.CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ');
    End;
  End;

 //EXCETO EVENTO
  If Not fEmptyStr(fraCentroCustoExceto.edtCodEve.Text) Then
  Begin
    qryDuplicatas.SQL.Add(' AND IFNULL(C.CTR_CODEVE," ") NOT IN('+fRetArrToSQLIn(arrEventoExceto,fraCentroCustoExceto.edtCodEve.Text)+')');
  End;

  If (edtNomEmp.Text = '+1') Then
  Begin
    pSetaParam(edtCodEmp.Text, arrEmp, strEmpresa, 'CODEMP', qryDuplicatas);
  End else
  If (Not fEmptyStr(edtCodEmp.Text)) and ((edtNomEmp.Text <> '+1')) Then
    qryDuplicatas.ParamByName('CODEMP').AsString :=  edtCodEmp.Text;

  If fCfgsis('EXIPOR', VarBoolean) Then
    qryDuplicatas.SQL.Add('  AND (P.POR_EXIPOR IN ("", "S") OR P.POR_EXIPOR IS NULL) ');

  qryDuplicatas.SQL.Add('ORDER BY C.CTR_DTAVEN ');

  qryDuplicatas.Open;

  MontarFiltroClientes(qryDuplicatas,LListaClientes);

  blnMostraChq := (
                   ( not fEmptyStr(edtCodCli.Text) ) or
                   ( not fEmptyStr(edtCliVen.Text) ) or
                   ( not fEmptyStr(edtVenDup.Text) ) or
                   ( not fEmptyStr(edtCodEmp.Text) ) or
                   (     fEmptyStr(edtCodPortador.Text) )

                  ) and
                  (
                    qryDuplicatas.RecordCount > 0
                  );


  // MOSTRAR CHEQUES SOMENTE SE HOUVEREM DUPLICATAS PARA O PORTADOR
  qryCheques := fCriaQuery(Self);

  With qryCheques, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT SQL_NO_CACHE CODCLI, SUM(TOTVEN) AS TOTVEN, SUM(TOTAVE) AS TOTAVE, SUM(TOTAL) AS TOTAL FROM (');
    Add(fSqlTotalChequesAberto(edtCodCli.Text, mskDtaIni.Text, mskDtaFin.Text, edtVenDup.Text, true, edtCodEmp, arrEmp, True) + ' ) AS TMP  ');

    if not blnMostraChq then
      Add(' WHERE CODCLI = ''0X0X0X0X0X0'' ');

    Add('GROUP BY CODCLI');

    If (edtNomEmp.Text = '+1') Then
    Begin
      pSetaParam(edtCodEmp.Text, arrEmp, strEmpresa, 'CODEMP', qryCheques);
    End else
    If (Not fEmptyStr(edtCodEmp.Text)) and ((edtNomEmp.Text <> '+1')) Then
      ParamByName('CODEMP').AsString :=  edtCodEmp.Text;

    Open;

    MontarFiltroClientes(qryCheques,LListaClientes);

    IndexFieldNames := 'CODCLI';
  End;


  cdsDuplicatas := fCriaClientDatSet(qryDuplicatas);
  cdsDuplicatas.Open;


  With qryInfCob Do
  Begin
    Close;
    cdsInfCob.Close;

    SQL.Clear;
    SQL.Add(fGetSqlTemporaria(LListaClientes));

    If Not fEmptyStr(edtCodCli.Text) Then
      ParamByName('CODCLI').AsString :=  edtCodCli.Text;

    If (pnlTipCli.Visible) and (Not fEmptyStr(edtTipCli.Text)) Then
      ParamByName('TIPCLI').AsString :=  edtTipCli.Text;

    If (Not fEmptyStr(edtCodRep.Text)) Then
      ParamByName('CODREP').AsString :=  edtCodRep.Text;

    If not fEmptyStr(edtCliVen.Text) Then
      ParamByName('CODVEN').AsString :=  edtCliVen.Text;

    If not fEmptyStr(edtCodRed.Text) Then
      pSetaParam(edtCodRed.Text, arrRede, strRede, 'CODRED', qryInfCob);

    Open;
    pSetaClient(qryInfCob);

    cdsInfCob.Open;

    pSetaClient(qryInfCob);

    cdsInfCob.IndexName := 'IDX_CLI_CODCLI';

    With cdsInfCob Do
    Begin
      TFloatField(FieldByName('VALDUP')).DisplayFormat   := '#,##0.00';
      TFloatField(FieldByName('VALCHQ')).DisplayFormat   := '#,##0.00';
      TFloatField(FieldByName('TOTVEN')).DisplayFormat   := '#,##0.00';
      TFloatField(FieldByName('TOTAVE')).DisplayFormat   := '#,##0.00';
      TFloatField(FieldByName('TOTAL')).DisplayFormat    := '#,##0.00';
      TFloatField(FieldByName('TOTCORR')).DisplayFormat  := '#,##0.00';
      TFloatField(FieldByName('TOTJUR')).DisplayFormat   := '#,##0.00';
      TStringField(FieldByName('CLI_FONE01')).EditMask := fRetMascaraFonePais;
      TStringField(FieldByName('CLI_FONE02')).EditMask := fRetMascaraFonePais;
      TStringField(FieldByName('CLI_F_A_X_')).EditMask := fRetMascaraFonePais;
      TStringField(FieldByName('CLI_CELULA')).EditMask := fRetMascaraFonePais;
    End;
  End;

  cdsInfCob.First;

  If Not cdsInfCob.IsEmpty Then
  Begin

    With cdsInfCob Do
    Begin
      dbgDados.DataSource := Nil;
      pDisableControls(cdsInfCob, prcScroll);

      pnlInfo.Caption := 'Aguarde processando cadastro...';

      First;

      qryAgendados.First;


      While Not qryAgendados.Eof Do
      Begin
        If FindKey([qryAgendados.FieldByName('CODCLI').AsString]) Then
        Begin
          Edit;
          FieldByName('AGELIG').AsString  := 'S';
          Post;
        End;

        qryAgendados.Next;
      End;

      qryCheques.First;

      While Not qryCheques.Eof Do
      Begin
        If FindKey([qryCheques.FieldByName('CODCLI').AsString]) Then
        Begin
          Edit;

          FieldByName('TOTAL').AsFloat  := FieldByName('TOTAL').AsFloat  + qryCheques.FieldByName('TOTAL').AsFloat;
          FieldByName('VALCHQ').AsFloat := FieldByName('VALCHQ').AsFloat + qryCheques.FieldByName('TOTAL').AsFloat;
          FieldByName('TOTVEN').AsFloat := FieldByName('TOTVEN').AsFloat + qryCheques.FieldByName('TOTVEN').AsFloat;
          FieldByName('TOTAVE').AsFloat := FieldByName('TOTAVE').AsFloat + qryCheques.FieldByName('TOTAVE').AsFloat;

          Post;
        End;

        qryCheques.Next;
      End;

      cdsDuplicatas.IndexFieldNames := 'CODCLI';

      cdsDuplicatas.First;

      While Not cdsDuplicatas.Eof Do
      Begin

        LClienteAtual := cdsDuplicatas.FieldByName('CODCLI').AsString;

        if cdsInfCob.FindKey([LClienteAtual]) then
        begin
          cdsInfCob.Edit;

          while (not cdsDuplicatas.Eof) and
                (cdsDuplicatas.FieldByName('CODCLI').AsString = LClienteAtual) do
          begin
            cdsDuplicatas.Edit;
            cdsDuplicatas.FieldByName('TotalJuros').AsFloat := fCalculaJurosCadCtr(cdsDuplicatas.FieldByName('CTR_DTAVEN').AsDateTime,
                                                                                   cdsDuplicatas.FieldByName('CTR_VALDUP').AsFloat,
                                                                                   fCfgSis('JURATR', varDouble));

            cdsDuplicatas.Post;

            cdsInfCob.FieldByName('TOTAL').AsFloat :=
              cdsInfCob.FieldByName('TOTAL').AsFloat +
              cdsDuplicatas.FieldByName('CTR_DUPVEN').AsFloat +
              cdsDuplicatas.FieldByName('CTR_DUPAVE').AsFloat +
              cdsDuplicatas.FieldByName('TotalJuros').AsFloat;

            cdsInfCob.FieldByName('VALDUP').AsFloat :=
              cdsInfCob.FieldByName('VALDUP').AsFloat +
              cdsDuplicatas.FieldByName('CTR_VALDUP').AsFloat;

            cdsInfCob.FieldByName('TOTVEN').AsFloat :=
              cdsInfCob.FieldByName('TOTVEN').AsFloat +
              cdsDuplicatas.FieldByName('CTR_DUPVEN').AsFloat;

            cdsInfCob.FieldByName('TOTAVE').AsFloat :=
              cdsInfCob.FieldByName('TOTAVE').AsFloat +
              cdsDuplicatas.FieldByName('CTR_DUPAVE').AsFloat;

            cdsInfCob.FieldByName('TOTJUR').AsFloat :=
              cdsInfCob.FieldByName('TOTJUR').AsFloat +
              cdsDuplicatas.FieldByName('TotalJuros').AsFloat;

            cdsInfCob.FieldByName('TOTCORR').AsFloat :=
              cdsInfCob.FieldByName('TOTCORR').AsFloat +
              cdsDuplicatas.FieldByName('CTR_VALDUP').AsFloat +
              cdsDuplicatas.FieldByName('TotalJuros').AsFloat;

            If (cdsDuplicatas.FieldByName('CTR_DTAREC').IsNull) Then
              cdsInfCob.FieldByName('QTD_DUPABE').AsInteger :=
                cdsInfCob.FieldByName('QTD_DUPABE').AsInteger + 1;

            cdsDuplicatas.Next;
          end;

          // Terminou de somar todas as duplicatas deste cliente
          cdsInfCob.Post;
        end
        Else
         cdsDuplicatas.Next;
      End;

      pCloneDataSet(cdsDuplicatasClientes, cdsDuplicatas);

      Filter   := '(TOTAL > 0)';

      If Not fEmptyStr(edtVrMinimo.Text) Then
        Filter   := Filter + ' AND (TOTAL >= ' + AnsiReplaceStr(edtVrMinimo.Text, '.', '') + ')';

      Filtered := True;

      cdsInfCob.First;

      Filtered := False;

      If chkPrimeiraCompra.Checked Then
        Filter   := Filter + ' AND PRICOM = ' + QuotedStr('S');

      Filtered := True;

      cdsInfCob.First;

      While Not cdsInfCob.Eof Do
      Begin

        fltTotGeral   := fltTotGeral   + FieldByName('TOTAL'  ).AsFloat;
        fltTotRecOrig := fltTotRecOrig + FieldByName('VALDUP' ).AsFloat;
        fltTotRecCorr := fltTotRecCorr + FieldByName('TOTCORR').AsFloat;
        fltTotVencido := fltTotVencido + FieldByName('TOTVEN' ).AsFloat;
        fltTotAVencer := fltTotAVencer + FieldByName('TOTAVE' ).AsFloat;
        fltTotJuros   := fltTotJuros   + FieldByName('TOTJUR' ).AsFloat;
        fltTotCheques := fltTotCheques + FieldByName('VALCHQ' ).AsFloat;

        cdsInfCob.Next;
      End;

      cdsInfCob.First;

      pEnableControls(cdsInfCob, prcScroll);
      dbgDados.DataSource := dtsInfCob;

      dbgDados.OnTitleClick(fFindColumnByName(dbgDados, 'TOTAL'));

      pnlInfo.Caption := '';

      First;

    End;

    FreeAndNil(qryCheques);
    FreeAndNil(qryDuplicatas);
  End;

  if cdsInfCob.Isempty then
     plimpaTotalizadores();

  pMostraTotalizador();

  Screen.Cursor := crDefault;

  cdsInfCob.AfterScroll := cdsInfCobAfterScroll;

  cdsInfCobAfterScroll(cdsInfCob);

  ShowScrollBar(dbgDados.Handle,SB_VERT,True);
  ShowScrollBar(dbgDados.Handle,SB_HORZ,False); //não deixar a mostra a barra horizontal

  If Assigned(LListaClientes) Then
    FreeAndNil(LListaClientes);

end;

procedure TfrmInfCobranca.pDeletaTemporaria;
begin
  cdsInfCob.Filter   := '';
  cdsInfCob.Filtered := False;

  qryInfCob.Close;
  cdsInfCob.Close;

  cdsHistCob.Close;
end;

procedure TfrmInfCobranca.pLimpaCampos;
begin

  edtCodCli.Clear;
  edtNomCli.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtVrMinimo.Clear;
  edtVrMinimo.Text := '0,00';

end;

procedure TfrmInfCobranca.dbgDadosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

  procedure pPintaRegistro(color: TColor);
  begin
    dbgDados.Canvas.Brush.Color := color;
    dbgDados.Canvas.Font.Color  := color;
    dbgDados.Canvas.FillRect(Rect);
  end;

begin
  inherited;
  If Not cdsInfCob.Active Then
    Exit;

  if cdsInfCob.FieldByName('MARDES').AsString = 'M' Then
  Begin
      If Canvas.Brush.Color = clhighlight Then
        dbgDados.Canvas.Font.Color := clLime
      Else
        dbgDados.Canvas.Font.Color := clBlue;
  End;

  If Concat('IDX_', Column.FieldName) = cdsInfCob.IndexName Then
  Begin
    dbgDados.Canvas.Brush.Color := clInfoBk;
    dbgDados.Canvas.Font.Color  := clBlack;
    dbgDados.Canvas.FillRect(Rect);
  End;

  If Column.FieldName = 'TEMAGR' Then
  Begin
    If cdsInfCob.FieldByName('TEMAGR').AsString = 'S' Then
      pPintaRegistro(clRed)
    Else
      pPintaRegistro(dbgDados.Canvas.Brush.Color);
  End;

  If Column.FieldName = 'AGELIG' Then
  Begin
    If cdsInfCob.FieldByName('AGELIG').AsString = 'S' Then
      pPintaRegistro(clAqua)
    Else
      pPintaRegistro(dbgDados.Canvas.Brush.Color);
  End;

  If Column.FieldName = 'PRICOM' Then
  Begin
    If cdsInfCob.FieldByName('PRICOM').AsString = 'S' Then
      pPintaRegistro(clGreen)
    Else
      pPintaRegistro(dbgDados.Canvas.Brush.Color);
  End;

  dbgDados.DefaultDrawColumnCell(Rect,DataCol, Column, State);

end;

procedure TfrmInfCobranca.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin

    {********************************}
    {* LIMPA DADOS DA TAB TEMPORARIA*}
    {*****************************LB*}
    pDeletaTemporaria;
    pLimpaCampos;
    pAtualizaStatusFones;

    pSetFocus(edtCodCli);
  End;

  If (Key = VK_Return) Then
  Begin
    {********************************}
    {* MARCA O CLIENTE SELECIONADO  *}
    {*****************************LB*}
    pSelecionaCliente;
    pSetFocus(Self);
  End;

end;

procedure TfrmInfCobranca.dbgDadosTitleClick(Column: TColumn);
Var strIndAnt: String;
begin
  inherited;
  Try
    strIndAnt := cdsInfCob.IndexName;
    If cdsInfCob.IndexDefs.Find('IDX_' + Column.FieldName) <> Nil Then
      cdsInfCob.IndexName := 'IDX_' + Column.FieldName;
  Except
    cdsInfCob.IndexName := strIndAnt;
  End;
  pAtualizaStatusFones;
end;

procedure TfrmInfCobranca.dtsInfCobDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btnAcompEntrega.Enabled := not dtsInfCob.DataSet.IsEmpty;
end;

procedure TfrmInfCobranca.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

procedure TfrmInfCobranca.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pExcluiTemporariaRel();

  {************************************}
  {* EXCLUI A TABELA E LIMPA OS EDITS *}
  {*********************************LB*}
  pDeletaTemporaria;
  pLimpaCampos;
end;

procedure TfrmInfCobranca.btnCadCliClick(Sender: TObject);
var
  strCodCli: String;
  frmCadClientes : TfrmCadClientes;
  intRecNo : Integer;
begin
  inherited;

  strCodCli := '';
  intRecNo := 0;

  If cdsInfCob.Active Then
  Begin
    intRecNo := cdsInfCob.RecNo;
    If Not cdsInfCob.IsEmpty Then
      strCodCli := cdsInfCob.FieldByName('CLI_CODCLI').AsString;
  End;

  if strCodCli.IsEmpty Then
  Begin
    pCarregaCliente;
    If Not fEmptyStr(edtCodCli.Text) Then
      strCodCli := edtCodCli.Text;
  End;

  Try
    pCriarFormularios(TfrmCadClientes, frmCadClientes);
    frmCadClientes.strCodClienteIniciarCadastro := strCodCli;
    frmCadClientes.ShowModal;
  Finally
    pFreeAndNil(frmCadClientes);
  End;
  If (cdsInfCob.Active) Then
  Begin
    If Not cdsInfCob.IsEmpty Then
    Begin
      btnCarrTitulos.Click;
      cdsInfCob.RecNo:= intRecNo;
    End;
  End;
end;

procedure TfrmInfCobranca.btnCarrTitulosClick(Sender: TObject);
begin
  inherited;
  {********************************}
  {* CRIACAO DA TABELA TEMPORARIA *}
  {*****************************LB*}

  If Not fVerificaCampos  Then
     Exit
  else
  begin

    pAcertaExibicao();
    TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Títulos','');
    If cdsInfCob.IsEmpty Then
      fMensagem('ATENÇÃO','Não há dados para ser feita cobrança!',['&O K'])
    else
    Begin
      pSetFocus(dbgDados);
    End;
  end;

end;

procedure TfrmInfCobranca.btnAgendamentoReligacaoClick(Sender: TObject);
var
  intRecNo : Integer;
  strCodCli: String;
  frmInfCobrancaAgeRel : TfrmInfCobrancaAgeRel;
  cdsInfDuplicatas     : TUniClientDataSet;
begin
  inherited;

  pCarregaCliente;

  If Not cdsInfCob.IsEmpty Then
    strCodCli := cdsInfCob.FieldByName('CLI_CODCLI').AsString
  Else If Not fEmptyStr(edtCodCli.Text) Then
    strCodCli := edtCodCli.Text;

  Try
    If Assigned(cdsInfCob) And cdsInfCob.Active Then
    begin

      pCriarFormularios(TfrmInfCobrancaAgeRel, frmInfCobrancaAgeRel);
      If blnFiltraCli Then
        If Not fEmptyStr(EdtCodCli.Text) Then
          frmInfCobrancaAgeRel.strCodCli := EdtCodCli.Text;

      If (Not fEmptyStr(strCodCli)) And
         (fMensagem('','OPÇÃO',['Todos','Selecionados'],1, False) = 2) Then
         Begin

           frmInfCobrancaAgeRel.strCodCli := strCodCli;
           frmInfCobrancaAgeRel.iOpcao    := 2;

           If Not fTemRegistrosMarcados Then
           Begin
              fMensagem('ATENÇÃO!','SELECIONE UM REGISTRO !',['&OK']);
              pSetFocus(dbgDados);
              if Assigned(frmInfCobrancaAgeRel) then
                 pFreeAndNil(frmInfCobrancaAgeRel);
              Exit;
           End;

         End;

      cdsInfDuplicatas := TUniClientDataSet.Create(Self);
      pCloneDataSet(cdsInfDuplicatas, cdsDuplicatasClientes);

      cdsInfCob.DisableControls;
      intRecNo := cdsInfCob.RecNo;
      frmInfCobrancaAgeRel.cdsInfCob        := cdsInfCob;
      frmInfCobrancaAgeRel.cdsInfDuplicatas := cdsInfDuplicatas;
      frmInfCobrancaAgeRel.strCodCli        := ''; // para trazer se for selecionado mais de 1 cliente;
      frmInfCobrancaAgeRel.ShowModal;
      cdsInfCob.RecNo := intRecNo;

      pAtualizaAgendadosHoje(); //Atualiza o Status dos Agendados;

      cdsInfCob.AfterScroll(cdsInfCob);

      cdsInfCob.EnableControls;
      FreeAndnil(cdsInfDuplicatas);
    end
    else
    begin
      fMensagem('ATENÇÃO','É necessário carregar os títulos antes do Agendamento/Religação!',['&O K']);
      Exit;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmInfCobranca.btnAgendamentoReligacaoClick]');
    End;
  End;
  pFreeAndNil(frmInfCobrancaAgeRel);

end;

procedure TfrmInfCobranca.cdsInfCobAfterScroll(DataSet: TDataSet);
begin
  inherited;
  pAtualizaStatusFones;
  If cdsInfCob.Active Then
  Begin
    pBuscaHistoricoCobranca(cdsInfCob.FieldByName('CLI_CODCLI').AsString);
    pBuscaUltimosDadosAg(cdsInfCob.FieldByName('CLI_CODCLI').AsString);
  End;
end;

procedure TfrmInfCobranca.cdsHistCobAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If cdsHistCob.Active Then
  Begin

    If not Assigned(WebBrowser.Document) then
       WebBrowser.Navigate('about:blank');

    Doc := WebBrowser.Document;
    Doc.Clear;
    Doc.Write('<font name="arial" size="2">'+
              AnsiReplaceStr(cdsHistCob.FieldByName('HISCOB').AsString,'<<csq>>',' ')+
              '</font>');
    Doc.Close;

  End
  Else
  Begin
    //If not Assigned(WebBrowser.Document) then
       WebBrowser.Navigate('about:blank');
  End;
end;

procedure TfrmInfCobranca.chkReligacaoClick(Sender: TObject);
begin
  inherited;
  pnlReligacao.Visible := chkReligacao.Checked;
  edtAgeRel.Text := 'T';
  edtAgeRel.Enabled := False;
end;

procedure TfrmInfCobranca.pAtualizaStatusFones;
begin
  pStatusTelefone(spbFone1);
  pStatusTelefone(spbFone2);
  pStatusTelefone(spbFax);
  pStatusTelefone(spbCel);
end;

procedure TfrmInfCobranca.pBuscaHistoricoCobranca(strCodCli: String);
  Var
    strSQL: String;
    qryHistCob : TUniQuery;
begin
  Try
    cdsHistCob.Close;
    qryHistCob := fCriaQuery(Self);

    If cdsInfCob.IsEmpty Then
      Exit;

    Doc := WebBrowser.Document;
    Doc.Clear;
    Doc.Write('');
    Doc.Close;

    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CADCOB.AUTOINCREM, ';
      strSQL := strSQL + '  COB_CODCLI, ';
      strSQL := strSQL + '  CLI_NOMCLI, ';
      strSQL := strSQL + '  COB_BAIXAD, ';
      strSQL := strSQL + '  CONCAT(COB_CODOPE,"-",OPE_NOMOPE) AS COB_CODOPE,';
      strSQL := strSQL + '  COB_OPEBAI, ';
      strSQL := strSQL + '  CONCAT(COB_CODCLI,"-",CLI_NOMCLI) AS CODCLI, ';
      strSQL := strSQL + '  TRIM(CLI_FONE01) AS FONE01, ';
      strSQL := strSQL + '  TRIM(CLI_FONE02) AS FONE02, ';
      strSQL := strSQL + '  TRIM(CLI_CELULA) AS CELULA, ';
      strSQL := strSQL + '  CONCAT(CLI_FONE01,CLI_FONE02,CLI_CELULA) AS FONES, ';
      strSQL := strSQL + '  IF(COB_DTAAGE IS NOT NULL, "A", "R") AS AGEREL,';
      strSQL := strSQL + '  COALESCE(COB_DTAAGE,COB_DTAREL) AS DTA, ';
      strSQL := strSQL + '  COB_DTALAN, ';
      strSQL := strSQL + '  COB_HISCOB AS HISCOB,  ';
      strSQL := strSQL + '  CADCOB.AUTOINCREM AS AUTINC, ';
      strSQL := strSQL + '  " "        AS COB_MARDES ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCOB ';
      strSQL := strSQL + '  JOIN CADCLI ON  COB_CODCLI = CLI_CODCLI ';
      strSQL := strSQL + '  JOIN CADOPE ON  COB_CODOPE = OPE_CODOPE ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  COB_BAIXAD = "N" ';

      If Not fEmptyStr(strCodCli) Then
        strSQL := strSQL + ' AND COB_CODCLI =' + QuotedStr(strCodCli);

      strSQL := strSQL + ' ORDER BY';
      strSQL := strSQL + '  CLI_NOMCLI, COB_DTALAN DESC, CADCOB.AUTOINCREM';

      With qryHistCob Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
        If Not IsEmpty Then
        Begin
          pSetaClient(qryHistCob);
          qryHistCob.First;

          cdsHistCob.DisableControls;
          cdsHistCob.SetProvider(nil);
          cdsHistCob := fCriaClientDatset(qryHistCob);
          dtsHistCob := fCriaDataSource(cdsHistCob);
          cdsHistCob.Open;

          cdsHistCob.First;
          cdsHistCobAfterScroll(cdsHistCob);

          grdDadosTableView1.DataController.DataSource := dtsHistCob;
          mdbHisCob.DataSource := dtsHistCob;

          cdsHistCob.AfterScroll := cdsHistCobAfterScroll;
          cdsHistCob.EnableControls;

        End;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmInfCobranca.pBuscaHistoricoCobranca]');
      End;
    End;
  Finally
    cdsHistCob.SetProvider(nil);
    pFreeAndNil(qryHistCob);
  End;
end;

procedure TfrmInfCobranca.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F1) Then
    btnMudaOrdem.Click

  Else If (Key = VK_F2) Then
    btnMarcarTodos.Click

  Else If (Key = VK_F3) Then
    btnDesmarcarTodos.Click

  Else If (Key = VK_F4) Then
    btnAgendarHistorico.Click

  Else If (Key = VK_F5) Then
  Begin
    if btnAgeHis.enabled then
       btnAgeHis.Click
  End
  Else If (Key = VK_F6) Then
    btnAgendamentoReligacao.Click

  Else If (Key = VK_F7) Then
    btnDpAberto.Click

  Else If (Key = VK_F8) Then
    btnHistorico.Click

  Else If (Key = VK_F9) Then
    btnCadCli.Click

  Else If (Key = VK_F10) Then
    btnRelAgendRelig.Click

  Else If (Key = VK_F11) Then
    btnRelatorio.Click

  Else If (Shift = [ssAlt]) then
  Begin

    If (Key = VK_F2) And (Shift = [ssAlt]) Then
       btnResFin.Click

  End;

end;

procedure TfrmInfCobranca.FormResize(Sender: TObject);
begin
  inherited;
  pAjustarBtnSair();
end;

procedure TfrmInfCobranca.FormShow(Sender: TObject);
begin
  inherited;
  pAjustarBtnSair();
  pSetFocus(edtCodCli);

  {*******************************************}
  {* VERIFICA SE USA O TIPO DE CLIENTE       *}
  {*******************************************}
  pnlTipCli.Visible := fCfgSis('USATPC', varBoolean);

  imgInformacoes.Visible := fCfgSis('EXIPOR', varBoolean);
end;

procedure TfrmInfCobranca.btnHistoricoClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(67, 5147, [],
                        ['CODCLI','CODEMP','DTAINI','DTAFIN'],
                        [edtCodCli.Text,
                        edtCodEmp.Text,
                        mskDtaIni.Text,
                        mskDtaFin.Text],
                        Sender,
                        nil,
                        False);
  End;

end;

procedure TfrmInfCobranca.pDesmarcarTodos;
Var
  iRecNo : integer;
begin

   cdsInfCob.AfterScroll := Nil;

   irecNo :=  cdsInfCob.recNo;
   cdsInfCob.Disablecontrols;

   If Not cdsInfCob.isEmpty Then Begin
    cdsInfCob.First;
    While Not cdsInfCob.Eof Do
    Begin
      cdsInfCob.Edit;
      cdsInfCob.FieldByName('MARDES').asString := 'D';
      cdsInfCob.Post;
      cdsInfCob.Next;
    End;
   End;

   cdsInfCob.EnableControls;

   cdsInfCob.RecNo := irecNo;

   cdsInfCob.AfterScroll := cdsInfCobAfterScroll;

   cdsInfCobAfterScroll(cdsInfCob);

   btnAgeHis.Enabled := True;

end;

procedure TfrmInfCobranca.pMarcarTodos();
Var
  iRecNo : integer;
begin

   cdsInfCob.AfterScroll := Nil;

   irecNo :=  cdsInfCob.recNo;
   cdsInfCob.Disablecontrols;

   If Not cdsInfCob.isEmpty Then Begin
    cdsInfCob.First;
    While Not cdsInfCob.Eof Do
    Begin
      cdsInfCob.Edit;
      cdsInfCob.FieldByName('MARDES').asString := 'M';
      cdsInfCob.Post;
      cdsInfCob.Next;
    End;
   End;

   cdsInfCob.EnableControls;

   cdsInfCob.RecNo := irecNo;

   cdsInfCob.AfterScroll := cdsInfCobAfterScroll;

   cdsInfCobAfterScroll(cdsInfCob);

   btnAgeHis.Enabled := False;

end;

procedure TfrmInfCobranca.btnMarcarTodosClick(Sender: TObject);
begin

  If (Not cdsInfCob.Active) or (cdsInfCob.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO','É necessário ter ao menos uma duplicata listada no grid!',['&O K']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pMarcarTodos,'Aguarde... Marcando Todos Registros','');
end;

procedure TfrmInfCobranca.btnMudaOrdemClick(Sender: TObject);
  Const
    INDICES_SISCRE = 'IDX_TEMAGR_IDX_PRICOM_IDX_AGELIG_';
  var
    intIndex: Integer;
begin
  inherited;

  If (Not cdsInfCob.Active) or (cdsInfCob.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO','É necessário ter ao menos uma duplicata listada no grid!',['&O K']);
    Exit;
  End;

  intIndex := cdsInfCob.IndexDefs.Find(cdsInfCob.IndexName).Index;

  If intIndex = cdsInfCob.IndexDefs.Count -1 Then
    intIndex := 0
  Else
    Inc(intIndex);

  If (Pos(cdsInfCob.IndexDefs[intIndex].Name, INDICES_SISCRE) > 0) Then
    intIndex := 0;

  cdsInfCob.IndexName := cdsInfCob.IndexDefs[intIndex].Name;
end;

procedure TfrmInfCobranca.btnRelAgendReligClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
      prcExecutaRelatorio(55, 4912, [4912,4913],
                          ['CODCLI', 'CODVEN', 'DTAINI', 'DTAFIN'],
                          [edtCodCli.Text, edtCliVen.Text, mskDtaIni.Text, mskDtaFin.Text],
                          Sender);
end;

procedure TfrmInfCobranca.btnRelatorioClick(Sender: TObject);
begin
  inherited;

  If (Not cdsInfCob.Active) or (cdsInfCob.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO','É necessário que existam registros listados no grid para gerar o relatório!',['&O K']);
    Exit;
  End;

  pCriaTemporariaRel();
  pInsereRegTemporariaRel();
end;

procedure TfrmInfCobranca.btnResFinClick(Sender: TObject);
begin
  inherited;

  Try
    If Not cdsInfCob.IsEmpty Then
    Begin
      pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
      frmResFinanceiro.strCodCli := cdsInfCob.FieldByName('CTR_CODCLI').asString;
      frmResFinanceiro.pSetaAjusteData( fMensagem('Ajuste de Datas',
                                         'Ajusta vencimentos considerando Sábado/Domingo/Feriados?',
                                         ['&Sim','&Não'],2) = 1 );
      frmResFinanceiro.ShowModal;
      pFreeAndNil(frmResFinanceiro);
    End
    Else
      fMensagem('ATENÇÃO!', 'É necessário escolher um Cliente!', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmInfCobrancaAgeRel.btnResFinClick]');
    End;
  End;

end;

procedure TfrmInfCobranca.btnDesmarcarTodosClick(Sender: TObject);
begin

  If (Not cdsInfCob.Active) or (cdsInfCob.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO','É necessário ter ao menos uma duplicata listada no grid!',['&O K']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pDesmarcarTodos,'Aguarde... Desmarcando Todos Registros','');
end;

procedure TfrmInfCobranca.btnDpAbertoClick(Sender: TObject);
var
  objDocumento: IDocumento;
begin
  inherited;

  objDocumento := TDocumento.Create;

  If fEmptyStr(edtCodCli.Text) And Not(cdsInfCob.IsEmpty) Then
    TfrmMostraDebCtrChq2.pMostraContaCorrente( cdsInfCob.FieldByName('CLI_CODCLI').AsString,
                                               '',
                                               False,
                                               False,
                                               False,
                                               'A',
                                               objDocumento,
                                               false,
                                               arrPortador,
                                               IIF(mskDtaIni.text = '', 0, mskDtaIni.Date),
                                               IIF(mskDtaFin.text = '', 0, mskDtaFin.Date),
                                               True)
  Else
    TfrmMostraDebCtrChq2.pMostraContaCorrente(edtCodCli.Text,
                                              '',
                                              False,
                                              False,
                                              False,
                                              'A',
                                              objDocumento,
                                              false,
                                              arrPortador,
                                              IIF(mskDtaIni.text = '', 0, mskDtaIni.Date),
                                              IIF(mskDtaFin.text = '', 0, mskDtaFin.Date),
                                              True);
end;

procedure TfrmInfCobranca.btnAgendarHistoricoClick(Sender: TObject);
Var
    frmInfCobrancaAgeRelHist : TfrmInfCobrancaAgeRelHist;
    cdsInfDuplicatas         : TUniClientDataSet;
begin

  If (Not cdsInfCob.Active) or (cdsInfCob.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO','É necessário ter ao menos uma duplicata listada no grid!',['&O K']);
    Exit;
  End;

  Try

     If Not fTemRegistrosMarcados Then
     Begin
        fMensagem('ATENÇÃO!','SELECIONE UM REGISTRO !',['&OK']);
        pSetFocus(dbgDados);
        Exit;
     End;

     Try
       cdsInfDuplicatas := TUniClientDataSet.Create(Self);
       pCloneDataSet(cdsInfDuplicatas, cdsDuplicatasClientes);

       pCriarFormularios(TfrmInfCobrancaAgeRelHist, frmInfCobrancaAgeRelHist);
       frmInfCobrancaAgeRelHist.cdsInfCob          := fRetornaDuplicatasClientesSelecionados(cdsInfCob);
       frmInfCobrancaAgeRelHist.cdsDuplicatas      := cdsInfDuplicatas; // cds das duplicatas de todos os clientes do filtro;
       frmInfCobrancaAgeRelHist.strCodEmp          := VS_strCodEmp;
       frmInfCobrancaAgeRelHist.blnAgendamento     := True;
       frmInfCobrancaAgeRelHist.blnBaixarReagendar := False;
       frmInfCobrancaAgeRelHist.ShowModal;

       If frmInfCobrancaAgeRelHist.blnRetorno Then
          pAtualizaAgendadosHoje();

       pFreeAndNil(frmInfCobrancaAgeRelHist);
     Finally
       FreeAndnil(cdsInfDuplicatas);
     End;

     cdsInfCob.AfterScroll(cdsInfCob);

  Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmInfCobranca.btnAgendarHistoricoClick]');
      End;
  End;

end;

procedure TfrmInfCobranca.pExcluiTemporariaRel();
 Var
   qryDrp : TUniQuery;
Begin

  Try
    qryDrp := fCriaQuery;
    qryDrp.SQL.Clear;
    qryDrp.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_INFCOB;');
    qryDrp.ExecSQL;

    FreeAndNil(qryDrp);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[pExcluiTemporariaRel]');
    End;
  End;

End;

procedure TfrmInfCobranca.pCriaTemporariaRel();
 Var
   qryGen : TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_INFCOB;');
    qryGen.SQL.Add('CREATE TEMPORARY TABLE TMP_INFCOB(        ');
    qryGen.SQL.Add('  TMP_DTAINI DATE DEFAULT NULL,           ');
    qryGen.SQL.Add('  TMP_DTAFIM DATE DEFAULT NULL,           ');
    qryGen.SQL.Add('  TMP_CODCLI VARCHAR(8),                  ');
    qryGen.SQL.Add('  TMP_NOMCLI VARCHAR(60),                 ');
    qryGen.SQL.Add('  TMP_TELEFO VARCHAR(15),                 ');
    qryGen.SQL.Add('  TMP_TOTORI DECIMAL(12,4) DEFAULT NULL,  ');
    qryGen.SQL.Add('  TMP_TOTCOR DECIMAL(12,4) DEFAULT NULL,  ');
    qryGen.SQL.Add('  TMP_TOTCHQ DECIMAL(12,4) DEFAULT NULL,  ');
    qryGen.SQL.Add('  TMP_TOTVEN DECIMAL(12,4) DEFAULT NULL,  ');
    qryGen.SQL.Add('  TMP_TOTAVE DECIMAL(12,4) DEFAULT NULL,  ');
    qryGen.SQL.Add('  TMP_TOTJUR DECIMAL(12,4) DEFAULT NULL,  ');
    qryGen.SQL.Add('  TMP_TOTGER DECIMAL(12,4) DEFAULT NULL,  ');
    qryGen.SQL.Add('  TMP_QTDDUP INTEGER DEFAULT NULL,        ');
    qryGen.SQL.Add('  TMP_QTDAGE INTEGER DEFAULT NULL,        ');
    qryGen.SQL.Add('  TMP_PRICOM VARCHAR(1),                  ');
    qryGen.SQL.Add('  TMP_TEMAGR VARCHAR(1),                  ');
    qryGen.SQL.Add('  TMP_AGELIG VARCHAR(1)                   ');
    qryGen.SQL.Add(');                                        ');
    qryGen.ExecSQL;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[pCriaTemporariaRel]');
    End;
  End;

End;

procedure TfrmInfCobranca.pInsereRegTemporariaRel();
 Var
   qryIns : TUniQuery;
   irec : Integer;
Begin

  If cdsInfCob.IsEmpty Then
     Exit;

  If fTabelaExiste('TMP_INFCOB') Then
  Begin

     cdsInfCob.DisableControls;
     cdsInfCob.AfterScroll := Nil;
     irec := cdsInfCob.recno;

     Try

       cdsInfCob.First;
       While Not cdsInfCob.Eof Do
       Begin
         qryIns := fCriaQuery;
         qryIns.SQL.Clear;
         qryIns.SQL.Add(' INSERT INTO TMP_INFCOB(');
         qryIns.SQL.Add(' TMP_DTAINI,  ');
         qryIns.SQL.Add(' TMP_DTAFIM,  ');
         qryIns.SQL.Add(' TMP_CODCLI,  ');
         qryIns.SQL.Add(' TMP_NOMCLI,  ');
         qryIns.SQL.Add(' TMP_TELEFO,  ');
         qryIns.SQL.Add(' TMP_TOTORI,  ');
         qryIns.SQL.Add(' TMP_TOTCOR,  ');
         qryIns.SQL.Add(' TMP_TOTCHQ,  ');
         qryIns.SQL.Add(' TMP_TOTVEN,  ');
         qryIns.SQL.Add(' TMP_TOTAVE,  ');
         qryIns.SQL.Add(' TMP_TOTJUR,  ');
         qryIns.SQL.Add(' TMP_TOTGER,  ');
         qryIns.SQL.Add(' TMP_QTDDUP,  ');
         qryIns.SQL.Add(' TMP_QTDAGE,  ');
         qryIns.SQL.Add(' TMP_PRICOM,  ');
         qryIns.SQL.Add(' TMP_TEMAGR,  ');
         qryIns.SQL.Add(' TMP_AGELIG   ');
         qryIns.SQL.Add(' )VALUES(     ');
         qryIns.SQL.Add(' :TMP_DTAINI, ');
         qryIns.SQL.Add(' :TMP_DTAFIM, ');
         qryIns.SQL.Add(' :TMP_CODCLI, ');
         qryIns.SQL.Add(' :TMP_NOMCLI, ');
         qryIns.SQL.Add(' :TMP_TELEFO, ');
         qryIns.SQL.Add(' :TMP_TOTORI, ');
         qryIns.SQL.Add(' :TMP_TOTCOR, ');
         qryIns.SQL.Add(' :TMP_TOTCHQ, ');
         qryIns.SQL.Add(' :TMP_TOTVEN, ');
         qryIns.SQL.Add(' :TMP_TOTAVE, ');
         qryIns.SQL.Add(' :TMP_TOTJUR, ');
         qryIns.SQL.Add(' :TMP_TOTGER, ');
         qryIns.SQL.Add(' :TMP_QTDDUP, ');
         qryIns.SQL.Add(' :TMP_QTDAGE, ');
         qryIns.SQL.Add(' :TMP_PRICOM, ');
         qryIns.SQL.Add(' :TMP_TEMAGR, ');
         qryIns.SQL.Add(' :TMP_AGELIG  ');
         qryIns.SQL.Add(' ); ');

         If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
            qryIns.ParamByName('TMP_DTAINI').AsDateTime := StrToDate(MskDtaIni.Text);
         If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
            qryIns.ParamByName('TMP_DTAFIM').AsDateTime := StrToDate(MskDtaFin.Text);
         qryIns.ParamByName('TMP_CODCLI').AsString  := cdsInfCob.FieldByName('CLI_CODCLI').AsString;
         qryIns.ParamByName('TMP_NOMCLI').AsString  := cdsInfCob.FieldByName('CLI_NOMCLI').AsString;
         qryIns.ParamByName('TMP_TELEFO').AsString  := cdsInfCob.FieldByName('CLI_FONE01').AsString;
         qryIns.ParamByName('TMP_TOTORI').AsFloat   := cdsInfCob.FieldByName('VALDUP').AsFloat;
         qryIns.ParamByName('TMP_TOTCOR').AsFloat   := cdsInfCob.FieldByName('TOTCORR').AsFloat;
         qryIns.ParamByName('TMP_TOTCHQ').AsFloat   := cdsInfCob.FieldByName('VALCHQ').AsFloat;
         qryIns.ParamByName('TMP_TOTVEN').AsFloat   := cdsInfCob.FieldByName('TOTVEN').AsFloat;
         qryIns.ParamByName('TMP_TOTAVE').AsFloat   := cdsInfCob.FieldByName('TOTAVE').AsFloat;
         qryIns.ParamByName('TMP_TOTJUR').AsFloat   := cdsInfCob.FieldByName('TOTJUR').AsFloat;
         qryIns.ParamByName('TMP_TOTGER').AsFloat   := cdsInfCob.FieldByName('TOTAL').AsFloat;
         qryIns.ParamByName('TMP_QTDDUP').AsInteger := cdsInfCob.FieldByName('QTD_DUPABE').AsInteger;
         qryIns.ParamByName('TMP_QTDAGE').AsInteger := cdsInfCob.FieldByName('QTD_DUPAGEABE').AsInteger;
         qryIns.ParamByName('TMP_PRICOM').AsString  := cdsInfCob.FieldByName('PRICOM').AsString;
         qryIns.ParamByName('TMP_TEMAGR').AsString  := cdsInfCob.FieldByName('TEMAGR').AsString;
         qryIns.ParamByName('TMP_AGELIG').AsString  := cdsInfCob.FieldByName('AGELIG').AsString;
         qryIns.ExecSQL;

         cdsInfCob.Next;
       End;

     Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message,'[pInsereRegTemporariaRel]');
        End;
     End;

     cdsInfCob.recno := irec;
     cdsInfCob.AfterScroll := cdsInfCobAfterScroll;
     cdsInfCob.EnableControls;

  End;

End;


procedure TfrmInfCobranca.btnAcompEntregaClick(Sender: TObject);
Var
  frmConsultaPedidos : TfrmConsultaPedidos;
  intRecNo : Integer;
  cdsInfDuplicatas     : TUniClientDataSet;
begin
  inherited;

  If (Not fVerificaAcessoSistema('PERACOMENT')) Then Begin
    fMensagem('', 'Operador não tem direito de acesso ao Acompanhamento da Entrega!', ['&OK']);
    Exit;
  End;

  If (Not cdsInfCob.Active) or (cdsInfCob.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO','É necessário ter ao menos uma duplicata listada no grid!',['&O K']);
    Exit;
  End;

  If Not fTemRegistrosMarcados Then
  Begin
    fMensagem('ATENÇÃO!','Selecione um registro !',['&OK']);
    pSetFocus(dbgDados);
    Exit;
  End;

  pCriarFormularios(TfrmConsultaPedidos, frmConsultaPedidos);
  cdsInfDuplicatas := TUniClientDataSet.Create(Self);

  Try
    pCloneDataSet(cdsInfDuplicatas, cdsDuplicatasClientes);
    If (not cdsInfDuplicatas.IsEmpty) Then
    Begin
      intRecNo := cdsInfCob.RecNo;
      frmConsultaPedidos.cdsInfCob        := fRetornaDuplicatasClientesSelecionados(cdsInfCob);
      frmConsultaPedidos.cdsInfDuplicatas := cdsInfDuplicatas;
      frmConsultaPedidos.CodCli           := IIF(fEmptyStr(edtCodCli.Text), '', edtCodCli.Text);
      frmConsultaPedidos.EmpFat           := IIF(fEmptyStr(edtCodEmp.Text), '', edtCodEmp.Text);
      frmConsultaPedidos.blnInfCobranca   := True;
      cdsInfCob.RecNo := intRecNo;
    End;

    frmConsultaPedidos.ShowModal;
  Finally
    FreeAndNil(frmConsultaPedidos);
    FreeAndNil(cdsInfDuplicatas);
  End;
end;

procedure TfrmInfCobranca.btnAgeHisClick(Sender: TObject);
  Var
    strCodCli: String;
    frmInfCobrancaAgeRelHist : TfrmInfCobrancaAgeRelHist;
    cdsInfDuplicatas         : TUniClientDataSet;
begin
  inherited;

  If (Not cdsInfCob.Active) or (cdsInfCob.RecordCount = 0) Then
  Begin
    fMensagem('ATENÇÃO','É necessário ter ao menos uma duplicata listada no grid!',['&O K']);
    Exit;
  End;

  If Not fTemRegistrosMarcados Then
  Begin
     fMensagem('ATENÇÃO!','SELECIONE UM REGISTRO !',['&OK']);
     pSetFocus(dbgDados);
     Exit;
  End;

  pCarregaCliente;
  If Not cdsInfCob.IsEmpty Then
    strCodCli := cdsInfCob.FieldByName('CLI_CODCLI').AsString
  Else If Not fEmptyStr(edtCodCli.Text) Then
    strCodCli := edtCodCli.Text;

  If Not fEmptyStr(strCodCli) Then
  Begin
    Try

      cdsDadosBaixa := TUniClientDataSet.Create(Self);
      pCarregaDadosBaixa(); // Carrega dados para baixar os ag existentes;

      cdsInfDuplicatas := TUniClientDataSet.Create(Self);
      pCloneDataSet(cdsInfDuplicatas, cdsDuplicatasClientes);

      pCriarFormularios(TfrmInfCobrancaAgeRelHist, frmInfCobrancaAgeRelHist);
      frmInfCobrancaAgeRelHist.cdsInfCob           := fRetornaDuplicatasClientesSelecionados(cdsInfCob);
      frmInfCobrancaAgeRelHist.cdsDuplicatas       := cdsInfDuplicatas; // cds das duplicatas de todos os clientes do filtro;
      frmInfCobrancaAgeRelHist.strCodCli           := strCodCli;
      frmInfCobrancaAgeRelHist.strCodEmp           := VS_strCodEmp;
      frmInfCobrancaAgeRelHist.blnBaixarReagendar  := True;
      frmInfCobrancaAgeRelHist.blnApagarInfoClient := False;
      frmInfCobrancaAgeRelHist.ShowModal;

      If (frmInfCobrancaAgeRelHist.blnRetorno) Then
          pBaixaAgClientes();

      pAtualizaAgendadosHoje();// Atualiza o status do agendamento;

      cdsInfCob.AfterScroll(cdsInfCob);
      FreeAndnil(cdsInfDuplicatas);
      FreeAndnil(cdsDadosBaixa);

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmInfCobranca.btnAgeHisClick]');
      End;
    End;

    pFreeAndNil(frmInfCobrancaAgeRelHist);
  End
  Else
  Begin
    fMensagem('ATENÇÃO','Selecione um Cliente!',['&OK']);
    pSetFocus(edtCodCli);
  End;

end;

procedure TfrmInfCobranca.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryInfCob);
end;

procedure TfrmInfCobranca.fraCentroCustoedtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEventos(Self, fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, Nil, Key, arrEvento, False, True) Then
  Begin
    If fValidaCampos(fraCentroCusto.edtDesEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmInfCobranca.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  If fraCentroCusto.edtCodEve.Text <> '00000' then
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Evento');
end;

procedure TfrmInfCobranca.fraCentroCustoExcetoedtCodEveExit(Sender: TObject);
begin
  inherited;
  if fraCentroCustoExceto.edtCodEve.Text <> '00000' then
     pEdtCodSelectExit(fraCentroCustoExceto.edtCodEve, fraCentroCustoExceto.edtDesEve, arrEventoExceto, fRetNomEvento, Nil, 'do Evento');
end;

procedure TfrmInfCobranca.fraCentroCustoExcetoedtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqEventos(Self, fraCentroCustoExceto.edtCodEve, fraCentroCustoExceto.edtDesEve, Nil, Key, arrEventoExceto, False) Then
  Begin
    If fValidaCampos(fraCentroCustoExceto.edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmInfCobranca.pStatusTelefone(btnTel: TSpeedButton; blnClick: Boolean = False);
  Var
    strCampo: String;
    imgStatus: TBitmap;
begin
  If (Not cdsInfCob.Active) Or cdsInfCob.IsEmpty Then
    btnTel.Tag := 0
  Else
  Begin
    strCampo := btnTel.Hint;

    btnTel.Tag := cdsInfCob.FieldByName('CLI_' + strCampo).AsInteger;

    If blnClick Then
    Begin
      btnTel.Tag := btnTel.Tag + 1;

      If btnTel.Tag > imglStatus.Count -1 Then
        btnTel.Tag := 0;

      cdsInfCob.Edit;
      cdsInfCob.FieldByName('CLI_' + strCampo).AsInteger := btnTel.Tag;
      cdsInfCob.Post;

      fExecutaSQL(' UPDATE CADCLI SET CLI_' + strCampo + ' = ' + IntToStr(btnTel.Tag) +
                  ' WHERE CLI_CODCLI = ' + QuotedStr(cdsInfCob.FieldByName('CLI_CODCLI').AsString));
    End;

  End;

  imgStatus := btnTel.Glyph;

  imglStatus.GetBitmap(btnTel.Tag, imgStatus);

  btnTel.Glyph.Assign(imgStatus);

end;

procedure TfrmInfCobranca.spbFone1Click(Sender: TObject);
begin
  inherited;
  pStatusTelefone(TSpeedButton(Sender), True);
end;

procedure TfrmInfCobranca.edtVenDupExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtVenDup, edtDesVenDup, arrVenDup, fRetNomeOperador, nil, 'do Vendedor',0, False, 'Código', False);
end;

procedure TfrmInfCobranca.edtVenDupKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqOperador(Self, edtVenDup, edtDesVenDup, Nil, Key, arrVenDup, False) then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;


function TfrmInfCobranca.fFormataClafis(strClafis: String): String;
var
  arrClafis: TStringDynArray;
  i: Integer;
begin
  arrClafis := SplitString(strClafis,'_');

  for i := 0 to Length(arrClafis)-1 do
  begin
    if arrClafis[i] <> '' then
      Result := Result + arrClafis[i]+'","';
  end;

  if Trim(Result) = '' then
    Result := '""'
  else
    Result := '"' + Copy(Trim(Result), 1, Length(Trim(Result))-2);
end;

function TfrmInfCobranca.fGetSqlQtdeAgendamentosEmAberto : String;
Var
 strSQL :String;
begin

  strSQL := '';
  strSQL := strSQL + 'IFNULL( ';
  strSQL := strSQL + '(SELECT COUNT(COB_DTAAGE) FROM CADCOB ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '       COB_BAIXAD = ''N'' ';
  strSQL := strSQL + '   AND COB_CODCLI = CTR_CODCLI ';

  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMPCCC') = '1' Then
    Result := Result + '   AND COB_CODEMP IN (' + fRetStrToSqlIn(strEmpAcessoUsuarioLogado) + ') ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSQL + ' COB_CODCLI ';

  strSQL := strSQL + ' ),0) ';

  Result := strSQL;

End;

function TfrmInfCobranca.fGetSqlTemporaria(AListaClientes: TStringBuilder): String;
  Var
    strSQL : String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT DISTINCT                                           ';
  strSQL := strSQL + '  ''D'' AS MARDES,                                        ';
  strSQL := strSQL + '  CADCLI.CLI_CODCLI AS CTR_CODCLI,                        ';
  strSQL := strSQL + '  CADCLI.CLI_CODCLI,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_NOMCLI,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_FONE01 AS CLI_FONE01,                        ';
  strSQL := strSQL + '  CADCLI.CLI_FONE02 AS CLI_FONE02,                        ';
  strSQL := strSQL + '  CADCLI.CLI_F_A_X_ AS CLI_F_A_X_,                        ';
  strSQL := strSQL + '  CADCLI.CLI_CELULA AS CLI_CELULA,                        ';
  strSQL := strSQL + '  CADCLI.CLI_RAMAL1,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_RAMAL2,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_RAMAL3,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_CONTAT,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_EMAIL_,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_EMAIL2,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_EMCOB1,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_EMCOB2,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_ID_FO1,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_ID_FO2,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_ID_CEL,                                      ';
  strSQL := strSQL + '  CADCLI.CLI_ID_FAX,                                      ';
  strSQL := strSQL + '  CADCAC.CAC_NOMCAC,                                      ';

  strSQL := strSQL + '  CASE                                                                ';
  strSQL := strSQL + '    WHEN (                                                            ';
  strSQL := strSQL + '      SELECT COUNT(*)                                                 ';
  strSQL := strSQL + '      FROM MOVGER M                                                   ';
  strSQL := strSQL + '      WHERE M.GER_CODCLI = CADCLI.CLI_CODCLI                          ';
  strSQL := strSQL + '        AND M.GER_TIP_FC = "C"                                        ';
  strSQL := strSQL + '        AND M.GER_CLAFIS IN  (' + fFormataClafis(VS_strClaVen) +')    ';
  strSQL := strSQL + '    ) = 1 THEN "S"                                                    ';
  strSQL := strSQL + '    ELSE "N"                                                          ';
  strSQL := strSQL + '  END AS PRICOM,                                                      ';


  strSQL := strSQL + '  CASE                                                ';
  strSQL := strSQL + '    WHEN EXISTS (                                     ';
  strSQL := strSQL + '      SELECT 1                                        ';
  strSQL := strSQL + '      FROM CADREC                                     ';
  strSQL := strSQL + '      WHERE CTR_CODCLI = CADCLI.CLI_CODCLI            ';
  strSQL := strSQL + '        AND CTR_ESPDOC = "AG"                         ';
  strSQL := strSQL + '        AND CTR_DTAREC IS NULL                        ';
  strSQL := strSQL + '      LIMIT 1                                         ';
  strSQL := strSQL + '    )                                                 ';
  strSQL := strSQL + '    THEN "S"                                          ';
  strSQL := strSQL + '    ELSE "N"                                          ';
  strSQL := strSQL + '  END AS TEMAGR,                                      ';


  strSQL := strSQL + '  "N" AS AGELIG,                                          ';
  strSQL := strSQL + '  0.00 AS VALDUP,                                         ';
  strSQL := strSQL + '  0.00 AS VALCHQ,                                         ';
  strSQL := strSQL + '  0.00 AS TOTVEN,                                         ';
  strSQL := strSQL + '  0.00 AS TOTAVE,                                         ';
  strSQL := strSQL + '  0.00 AS TOTAL,                                          ';
  strSQL := strSQL + '  0.00 AS TOTCORR,                                        ';
  strSQL := strSQL + '  0.00 AS TOTJUR,                                         ';
  strSQL := strSQL + '  MAX(COB_DTAAGE) AS ULTAGE,                              ';
  strSQL := strSQL + '  MAX(COB_DTAREL) AS ULTREL,                              ';
  strSQL := strSQL + '  0 AS QTD_DUPABE,                                        ';
  strSQL := strSQL + fGetSqlQtdeAgendamentosEmAberto + ' AS QTD_DUPAGEABE ';
  strSQL := strSQL + 'FROM                                                      ';
  strSQL := strSQL + '  CADCLI                                                  ';
  strSQL := strSQL + '  LEFT JOIN CADCOB                                        ';
  strSQL := strSQL + '    ON COB_CODCLI = CLI_CODCLI                            ';
  strSQL := strSQL + '  LEFT JOIN CADCAC                                        ';
  strSQL := strSQL + '    ON CAC_CODCAC = CLI_CODCAC                            ';
  strSQL := strSQL + 'WHERE TRUE                                                ';

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    strSQL := strSQL + '  AND CADCLI.CLI_CODCLI = :CODCLI ';
  End
  Else
  Begin
    If Not fEmptyStr(AListaClientes.ToString) Then
      strSQL := strSQL + '  AND CADCLI.CLI_CODCLI IN (' + AListaClientes.ToString + ') '
    Else
      strSQL := strSQL + '  AND CADCLI.CLI_CODCLI IN ("0X0X0X0X0X0") ';
  End;

  If (pnlTipCli.Visible) and (Not fEmptyStr(edtTipCli.Text)) Then
    strSQL := strSQL + '  AND CADCLI.CLI_TIPCLI = :TIPCLI ';

  If Not fEmptyStr(edtCodRed.Text) Then
      strSQL := strSQL + fStrLocate(edtCodRed, arrRede, 'CADCLI.CLI_CODRED', 'CODRED');

  If (Not fEmptyStr(edtCodRep.Text)) Then
    strSQL := strSQL + '  AND CADCLI.CLI_CODREP = :CODREP ';

  If not fEmptyStr(edtCliVen.Text) Then
  Begin
    strSQL := strSQL + '  AND CADCLI.CLI_CODVEN = :CODVEN ';
  End;

  If chkReligacao.Checked Then
  Begin

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniRelig.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinRelig.Text))) Then
    Begin

       if edtAgeRel.text = 'A' then
       Begin
          strSQL := strSQL + ' AND COB_DTAAGE BETWEEN ' + fCurrentDate(StrToDate(mskDtaIniRelig.Text)) + ' AND '
                                                        + fCurrentDate(StrToDate(mskDtaFinRelig.Text)) + ' '
                                                        + ' AND COB_DTAREL IS NULL ';

       End
       else
       if edtAgeRel.text = 'R' then
       Begin
          strSQL := strSQL + ' AND COB_DTAREL BETWEEN ' + fCurrentDate(StrToDate(mskDtaIniRelig.Text)) + ' AND '
                                                        + fCurrentDate(StrToDate(mskDtaFinRelig.Text)) + ' ';

       End
       else
       if edtAgeRel.text = 'T' then
       Begin
          strSQL := strSQL + ' AND ( (COB_DTAAGE BETWEEN ' + fCurrentDate(StrToDate(mskDtaIniRelig.Text)) + ' AND '
                                                           + fCurrentDate(StrToDate(mskDtaFinRelig.Text)) + ') ';
          strSQL := strSQL + '    OR (COB_DTAREL BETWEEN ' + fCurrentDate(StrToDate(mskDtaIniRelig.Text)) + ' AND '
                                                           + fCurrentDate(StrToDate(mskDtaFinRelig.Text)) + ')  ) ';

       End;

    End;

    strSQL := strSQL + ' AND COB_BAIXAD = "N" ';

  End;

  strSQL := strSQL + 'GROUP BY CLI_CODCLI                                       ';


  Result := strSQL;
end;

procedure TfrmInfCobranca.pCarregaEvento;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmInfCobranca.pCarregaEventoExceto;
begin
  If Not fEmptyStr(fraCentroCustoExceto.edtCodEve.Text) Then
    fraCentroCustoExceto.edtDesEve.Text := fRetNomEvento(fraCentroCustoExceto.edtCodEve)
  Else
    fraCentroCustoExceto.edtDesEve.Clear;
end;


procedure TfrmInfCobranca.pSelecionaCliente;
  Var
    intRecNo: Integer;
begin
  If (Not cdsInfCob.Active) Or
     (cdsInfCob.IsEmpty)    Then
      Exit;

  intRecNo := cdsInfCob.RecNo;

  cdsInfCob.Edit;
  cdsInfCob.FieldByName('MARDES').AsString := IIF( cdsInfCob.FieldByName('MARDES').AsString = 'M', 'D', 'M' );
  cdsInfCob.Post;

  cdsInfCob.RecNo := intRecNo;

  VerificaRegMarcados();

end;

function TfrmInfCobranca.fRetornaDuplicatasClientesSelecionados( cdsGen : TUniClientDataSet ) : TUniClientDataSet;
 Var
     cdsAuxInfCob   : TUniClientDataSet;
begin
   Result := nil;

   Try
     cdsAuxInfCob      := TUniClientDataSet.Create(Nil);
     cdsAuxInfCob.Data := cdsGen.Data;

     cdsAuxInfCob.Filtered := False;
     cdsAuxInfCob.Filter   := ' MARDES = ' + QuotedStr('M');
     cdsAuxInfCob.Filtered := True;

     Result := cdsAuxInfCob;

   Except
     pFreeAndNil(cdsAuxInfCob);
   End;

End;

function TfrmInfCobranca.fTemRegistrosMarcados : Boolean;
Var
  cdsMarc : TUniClientDataSet;
Begin
  cdsMarc := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsMarc, cdsInfcob);

  cdsMarc.Filtered := False;
  cdsMarc.Filter := ' MARDES = ' + QuotedStr('M');
  cdsMarc.Filtered := True;

  Result := cdsMarc.RecordCount > 0;

  FreeAndNil(cdsMarc);
End;

Procedure TfrmInfCobranca.pMostraTotalizador();
Begin
  edtTotRecOrig.text := FormatFloat('#,##0.00;-#,##0.00', fltTotRecOrig);
  edtTotRecCorr.text := FormatFloat('#,##0.00;-#,##0.00', fltTotRecCorr);
  edtTotCheques.text := FormatFloat('#,##0.00;-#,##0.00', fltTotCheques);
  edtTotVencido.text := FormatFloat('#,##0.00;-#,##0.00', fltTotVencido);
  edtTotAVencer.Text := FormatFloat('#,##0.00;-#,##0.00', fltTotAVencer);
  edtTotjuros.Text   := FormatFloat('#,##0.00;-#,##0.00', fltTotJuros);
  edtTotGeral.Text   := FormatFloat('#,##0.00;-#,##0.00', fltTotGeral);
End;

Procedure TfrmInfCobranca.pLimpaTotalizadores();
Begin
  fltTotRecOrig := 0.00;
  fltTotRecCorr := 0.00;
  fltTotCheques := 0.00;
  fltTotVencido := 0.00;
  fltTotAVencer := 0.00;
  fltTotJuros   := 0.00;
  fltTotGeral   := 0.00;
End;

function TfrmInfCobranca.fRetornaFiltroCliente: string;
var
  prcScroll: TprcScroll;
  irecno : Integer;
begin
  Result := '';

  irecno := cdsInfCob.recno;
  pDisableControls(cdsInfCob, prcScroll);
  try
    if not cdsinfcob.isempty then
    begin
       cdsinfcob.first;
       result := ' AND COB_CODCLI IN ( ';
       while not cdsinfcob.eof do
       begin
         If cdsinfcob.fieldbyname('MARDES').asstring = 'M' then
            Result := Result + '"' + cdsinfcob.fieldbyname('CLI_CODCLI').asstring + '",';

         cdsinfcob.next;
       end;

       Result := LeftStr(Result, Result.Length - 1) + ')';
    end;
  finally
    pEnableControls(cdsInfCob, prcScroll);
    cdsInfCob.recno := iRecNo;
  end;
end;

procedure TfrmInfCobranca.pCarregaDadosBaixa;
  Var
    strSQL: String;
    qryDadosBaixa: TUniQuery;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADCOB.AUTOINCREM, ';
  strSQL := strSQL + '  COB_CODCLI, ';
  strSQL := strSQL + '  COB_CODCLI AS CTR_CODCLI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  COB_BAIXAD, ';
  strSQL := strSQL + '  COB_CODOPE, ';
  strSQL := strSQL + '  OPC.OPE_NOMOPE NOM_OPECAD, ';
  strSQL := strSQL + '  COB_OPEBAI, ';
  strSQL := strSQL + '  OPB.OPE_NOMOPE NOM_OPEBAI, ';
  strSQL := strSQL + '  CONCAT(COB_CODCLI,"-",CLI_NOMCLI) AS CODCLI, ';
  strSQL := strSQL + '  TRIM(CLI_FONE01) AS FONE01, ';
  strSQL := strSQL + '  TRIM(CLI_FONE02) AS FONE02, ';
  strSQL := strSQL + '  TRIM(CLI_CELULA) AS CELULA, ';
  strSQL := strSQL + '  CONCAT(CLI_FONE01,CLI_FONE02,CLI_CELULA) AS FONES, ';
  strSQL := strSQL + '  IF(COB_DTAAGE IS NOT NULL, "A", "R") AS AGEREL,';
  strSQL := strSQL + '  COB_DTALAN AS DTALAN, ';
  strSQL := strSQL + '  COALESCE(COB_DTAAGE,COB_DTAREL) AS DTA, ';
  strSQL := strSQL + '  COB_HISCOB AS HISCOB,  ';
  strSQL := strSQL + '  CADCOB.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '  " "        AS COB_MARDES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCOB ';
  strSQL := strSQL + '  JOIN CADCLI ON  COB_CODCLI = CLI_CODCLI ';

  strSQL := strSQL + '  LEFT JOIN CADOPE OPC ';
  strSQL := strSQL + '    ON COB_CODOPE = OPC.OPE_CODOPE ';
  strSQL := strSQL + '  LEFT JOIN CADOPE OPB ';
  strSQL := strSQL + '    ON COB_OPEBAI = OPB.OPE_CODOPE ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COB_BAIXAD = "N" ';

  strSQL := strSQL + fRetornaFiltroCliente;

  strSQL := strSQL + ' ORDER BY';
  strSQL := strSQL + '  CLI_NOMCLI, DTA, CADCOB.AUTOINCREM';

  qryDadosBaixa := fCriaQuery(Self);

  With qryDadosBaixa Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    cdsDadosBaixa := fCriaClientDatset(qryDadosBaixa);

  End;

end;

function TfrmInfCobranca.fBaixaCliente: Boolean;
  Var
    strSQL: String;
    qryCadCob: TUniQuery;
begin
  Result := True;

  Try
    Try
      With cdsDadosBaixa Do
      Begin
        qryCadCob := fCriaQuery(Self);

        First;
        While Not Eof Do
        Begin
          strSQL := '';
          strSQL := strSQL + 'UPDATE ';
          strSQL := strSQL + '  CADCOB ';
          strSQL := strSQL + 'SET ';
          strSQL := strSQL + '  COB_BAIXAD = "S", ';
          strSQL := strSQL + '  COB_OPEBAI = "' + strLoginUsuarioLogado + '"';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

          With qryCadCob Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('AUTINC').AsString := cdsDadosBaixa.FieldByName('AUTOINCREM').AsString;
            ExecSQL;
            Close;
          End;
          Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fBaixaCliente]');
        Result := False;
      End;
    End;
  Finally
    If Assigned(qryCadCob) Then
       FreeAndNil(qryCadCob);
  End;
end;

procedure TfrmInfCobranca.pBaixaAgClientes;
Var
  blnRetorno: Boolean;
Begin
   fStartTransaction;

  {*************************************}
  {* REALIZA O UPDATE NA TABELA CADCOB *}
  {**********************************LB*}
  blnRetorno := fBaixaCliente;

  If (Not blnRetorno) Then
    fRollBack
  Else
    fCommit;

End;

Procedure TfrmInfCobranca.VerificaRegMarcados();
Var
  cdsClone : TUniClientDataSet;
Begin
  cdsClone := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsClone, cdsInfCob);

  With cdsClone Do
  Begin
    Filtered := False;
    Filter := ' MARDES = ' + QuotedStr('M');
    Filtered := True;

    If RecordCount > 1 Then
       btnAgeHis.enabled := False
    Else
       btnAgeHis.enabled := True;
  End;

  FreeAndNil(cdsClone);
End;

Procedure TfrmInfCobranca.pAcertaExibicao();
Begin
   If fEmptyStr(edtCliven.Text) Then edtCliVenExit(edtCliVen);
   If fEmptyStr(edtVenDup.Text) Then edtVenDupExit(edtVenDup);
   If fEmptyStr(edtCodEmp.Text) Then edtCodEmpExit(edtCodEmp);
   If fEmptyStr(edtCodCnd.Text) Then edtCodCndExit(edtCodCnd);
End;

procedure TfrmInfCobranca.pBuscaUltimosDadosAg(strCodCli: String);
  Var
    strSQL           : String;
    qryUltDadosAgCob : TUniQuery;
    dspUltDadosAgCob : TUniDataSetProvider;
begin

  Try
    cdsUltDadosAgCob.Close;
    qryUltDadosAgCob         := fCriaQuery(Self);
    dspUltDadosAgCob         := TUniDataSetProvider.Create(Self);
    dspUltDadosAgCob.DataSet := qryUltDadosAgCob;
    cdsUltDadosAgCob.SetProvider(dspUltDadosAgCob);

    If cdsInfCob.IsEmpty Then
      Exit;

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT      ';
      strSQL := strSQL + '   MAX(COB_DTAAGE) AS ULTAGENDAMENTO,  ';
      strSQL := strSQL + '   MAX(COB_DTAREL) AS ULTRELIGACAO ';
      strSQL := strSQL + ' FROM CADCOB ';
      strSQL := strSQL + ' WHERE       ';
      strSQL := strSQL + ' COB_CODCLI = :CODCLI ';

      qryUltDadosAgCob.Close;
      qryUltDadosAgCob.SQL.Clear;
      qryUltDadosAgCob.SQL.Add(strSQL);
      qryUltDadosAgCob.ParamByName('CODCLI').AsString := strCodCli;

      qryUltDadosAgCob.Open;
      If Not qryUltDadosAgCob.IsEmpty Then
      Begin
         pSetaClient(qryUltDadosAgCob);
         cdsUltDadosAgCob.Open;
         pSetaClient(cdsUltDadosAgCob);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmInfCobranca.pBuscaUltimosDadosAg]');
      End;
    End;

  Finally
    cdsUltDadosAgCob.SetProvider(nil);
    pFreeAndNil(dspUltDadosAgCob);
    pFreeAndNil(qryUltDadosAgCob);
  End;

end;

Procedure TfrmInfCobranca.pAtualizaAgendadosHoje();
  Var
    qryAgeMarc: TUniQuery;
    iRec      : Integer;
    prcScroll : TprcScroll;
Begin

  Try
    qryAgeMarc := fCriaQuery(Self);

    qryAgeMarc.Close;
    qryAgeMarc.Sql.Clear;
    qryAgeMarc.Sql.Add(fSqlAgendadosParaHoje);
    qryAgeMarc.Open;

    If Not qryAgeMarc.IsEmpty Then
    Begin

       pDisableControls(cdsInfCob, prcScroll);

       cdsInfCob.AfterScroll := nil;

       iRec := cdsInfCob.RecNo;

       cdsInfCob.first;

       //LIMPA TODOS OS AGENDADOS PARA REMARCAR
       While Not cdsInfCob.Eof Do
       Begin
         cdsInfCob.Edit;
         cdsInfCob.FieldByName('AGELIG').AsString := 'N';
         cdsInfCob.Post;

         cdsInfCob.Next;
       End;

       cdsInfCob.first;
       cdsInfCob.IndexName := 'IDX_CLI_CODCLI';

       qryAgeMarc.First;
       While Not qryAgeMarc.Eof Do
       Begin

         If cdsInfCob.FindKey([qryAgeMarc.FieldByName('CODCLI').AsString]) Then
         Begin
           cdsInfCob.Edit;
           cdsInfCob.FieldByName('AGELIG').AsString := 'S';
           cdsInfCob.Post;
         End;

         qryAgeMarc.Next;
       End;

       cdsInfCob.AfterScroll := cdsInfCobAfterScroll;
       cdsInfCobAfterScroll(cdsInfCob);

       cdsInfCob.IndexName := 'IDX_TOTAL';

       cdsInfCob.recno := iRec;

       pEnableControls(cdsInfCob, prcScroll);

    End;

  Finally
    FreeAndNil(qryAgeMarc);
  End;

End;

procedure TfrmInfCobranca.pAjustarBtnSair;
begin

  {*********************************************************************************}
  {* MANTÉM O btnSairBaixa SEMPRE ALINHADO COM O ÚLTIMO BOTÃO DA PRIMEIRA FILEIRA, *}
  {* AO ALTERAR O TAMANHO OU ADICIONAR ALGUM BOTÃO, VERIFICAR SE ESTÁ ALINHADO     *}
  {******************************************************************************AM*}
  btnSair.width := btnhistorico.width;
  btnSair.Top   := FlwBotoes.Height - btnSair.Height ;
  btnSair.Left  := FlwBotoes.Width  - btnSair.Width  - 3;

  // No Layout novo os botões se perdiam, por isso é feito essa verifcação
//  If Not untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico Then
//    btnSair.Left := FlwBotoes.Width - btnSair.Width - 3
//  Else
//  Begin
//    If Self.WindowState = wsMaximized Then
//       btnSair.Left := FlwBotoes.Width - btnSair.Width - 62
//    Else
//       btnSair.Left := FlwBotoes.Width - btnSair.Width - 1;
//  End;

 {   if btnRelAgendRelig.top = 22 then
       btnSair.Left := btnRelAgendRelig.Left
    Else
       btnSair.Left := FlwBotoes.Width - btnSair.Width - 4;}

end;

procedure TfrmInfCobranca.pCarregaRede;
begin
  If Not fEmptyStr(edtCodRed.Text) Then
    edtDesRed.Text := fRetNomeRedeLoja(edtCodRed.Text)
  Else
    edtDesRed.Clear;
end;

procedure TfrmInfCobranca.pCarregaRepr(strCodigo: String; edtDescricao: TEditFocus);
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, strCodigo);
  With qryConOpe Do
  Begin
    edtDescricao.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;


procedure TfrmInfCobranca.MontarFiltroClientes(
  ADataSet: TDataSet;
  var AClientes: TStringBuilder;
  const ACampoChave: string = 'CODCLI'
);
var
  ListaCodigos: TStringList;
  i: Integer;
begin
  if not Assigned(ADataSet) then
    Exit;

  if not Assigned(AClientes) then
    AClientes := TStringBuilder.Create;

  if not ADataSet.Active then
    Exit;

  if ADataSet.IsEmpty then
    Exit;

  ListaCodigos := TStringList.Create;
  try
    ListaCodigos.Sorted := True;
    ListaCodigos.Duplicates := dupIgnore;

    ListaCodigos.Capacity := ADataSet.RecordCount;

    ADataSet.DisableControls;
    try
      ADataSet.First;

      while not ADataSet.Eof do
      begin
        ListaCodigos.Add(ADataSet.FieldByName(ACampoChave).AsString);
        ADataSet.Next;
      end;

    finally
      ADataSet.EnableControls;
    end;

    if ListaCodigos.Count = 0 then
      Exit;

    for i := 0 to ListaCodigos.Count - 1 do
    begin

      if Pos(ListaCodigos[i], AClientes.ToString) = 0 then
      begin

        if AClientes.Length > 0 then
          AClientes.Append(', ');

        AClientes.Append(QuotedStr(ListaCodigos[i]));
      end;

    end;


  finally
    ListaCodigos.Free;
  end;
end;

end.







