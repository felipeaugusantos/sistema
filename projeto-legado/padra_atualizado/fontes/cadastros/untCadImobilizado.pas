unit untCadImobilizado;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls, StrUtils,
  Buttons, ExtCtrls, Mask, DBCtrls, DBEditFocus, untCadImo, DB, EditFocus, Uni,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, ComboBoxFocus, DateUtils, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, untZClient, math,
  DBMemoFocus,
  System.Variants;

type
  TTipoCalculo = (tcVidaUtil, tcFiscal, tcContabil);


  TDepreciacao = Record
    DataBase: TDateTime;
    Parcela: integer;
    vlrDepreciacao: Double;
    vlrDepreciacaoAcumulada: Double;
  end;

  TDepreciacoes = array of TDepreciacao;

  TImobilizadoDepreciacao = class
    FDepreciacoes: TDepreciacoes;
    FDepreciacaoMensal: Double;
    FDepreciacaoAnual: Double;
    FCodigoImobilizado: String;
    FQryConsulta: TUniQuery;
    FDepreciacaoRestante: Double;
    FTipoDep: string ;
  private
    function GetDepreciacoes(intIndex: integer): TDepreciacao;
    function fAjustaDataFinal(const AData: TDateTime): TDateTime ;
    function fAjustaDataInicial(const AData: TDateTime): TDateTime ;
  public
    procedure pCalcularDepreciacao(TipoCalculo: TTipoCalculo; DataAquisicao: TDate; intVidaUtil: Integer; fltTaxaDepreciacao: Double; fltVlrItem: Double; fltValorResidual: Double);
    procedure pInicia;
    function fGetQtdTotalMeses: Integer;
    function fGetParcelaAtual(DataAquisicao: TDate): Integer;
    procedure pGravaDepreciacaoImobilizados(strCodImobilizado: string);

    destructor Destroy; override;
    constructor Create(const ATipo: string); reintroduce;

    property Depreciacoes[intIndex: integer]: TDepreciacao read GetDepreciacoes;
    property qryConsulta: TUniQuery read FqryConsulta write FqryConsulta;
    property DepreciacaoMensal: Double read FDepreciacaoMensal;
    property DepreciacaoAnual: Double read FDepreciacaoAnual;
    property CodigoImobilizado: String read FCodigoImobilizado write FCodigoImobilizado;
    property DepreciacaoRestante: Double read FDepreciacaoRestante ;
  end;

  TPatrimoniosLocoalizacaoAcao = (tplaEdicao, tplaInclusao) ;

  TPatrimoniosLocalizacao = class
  private
    FKeyImobilizado: String;
    FPatrimoniosLocoalizacaoAcao: TPatrimoniosLocoalizacaoAcao;
    FQuerySQL: TUniQuery;
  protected
    cdsPatrimonios: TZClient;
  public
    intSequencialEdicao: integer;
    constructor create(AKeyImobilizado: String; DataSource: TDataSource);
    Destructor Destroy; override;
    function fTemNumPat: Boolean;
    procedure pGravar(AKeyImobilizado: String);
    procedure pCarregar(AKeyImobilizado: String);
    procedure pIncluir(strLocFis, strNumpat: String; intSequencial: integer = -1);
    procedure pExcluir(intSequencial: integer = -1);
  End;

  TfrmCadImobilizado = class(TfrmPaiCad)
    pnlDados: TPanel;
    dtsCadImo: TDataSource;
    dsIndicadorCentroCusto: TDataSource;
    Panel1: TPanel;
    Label22: TLabel;
    lblConfiguracao: TLabel;
    pctImobilizado: TPageControl;
    tstBem: TTabSheet;
    tstAquisicao: TTabSheet;
    tstDepreciacao: TTabSheet;
    Label1: TLabel;
    dbeCodImo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    lblEmpresa: TLabel;
    dbeCodEmp: TDBEditFocus;
    edtDesEmpresa: TEditFocus;
    dbcVendid: TDBCheckBox;
    Label28: TLabel;
    Label30: TLabel;
    dbeCODBAR: TDBEditFocus;
    Label7: TLabel;
    dbeTIPIMO: TDBEditFocus;
    edtDesTipImo: TEditFocus;
    gpInfoSped: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    dbeFunCta: TDBEditFocus;
    lcbCentroCusto: TDBLookupComboBox;
    gbDadosAquisicao: TGroupBox;
    Label43: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lblDocumento: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblForNot: TLabel;
    Label6: TLabel;
    Label16: TLabel;
    Label14: TLabel;
    Label49: TLabel;
    Label21: TLabel;
    dbeDtaAqu: TDBEditFocus;
    dbeValAqu: TDBEditFocus;
    dbeValIcm: TDBEditFocus;
    dbeQtdParcel: TDBEditFocus;
    edtDesForNot: TEditFocus;
    edtDesIte: TEditFocus;
    dbeQtdImo: TDBEditFocus;
    dbeDocAqu: TDBEditFocus;
    dbeForAqu: TDBEditFocus;
    dbeSerAqu: TDBEditFocus;
    dbeEspAqu: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbeVlrTot: TDBEditFocus;
    edtNCM: TEditFocus;
    edtCST: TEditFocus;
    gpDadosVenda: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    dbeDtaVen: TDBEditFocus;
    dbeValVen: TDBEditFocus;
    dbeValIcmVen: TDBEditFocus;
    edtDesCli: TEditFocus;
    dbeDocVen: TDBEditFocus;
    dbeEspVen: TDBEditFocus;
    dbeSerVen: TDBEditFocus;
    dbeCliVen: TDBEditFocus;
    grpDepreciacao: TGroupBox;
    lblVidUti: TLabel;
    lblDepAn: TLabel;
    lblPerSimbDepAn: TLabel;
    lblPerRes: TLabel;
    lblSimbperResidual: TLabel;
    lblVlrRes: TLabel;
    lblVlrRepAn: TLabel;
    lblVlrRepMes: TLabel;
    lblVlrRepAtu: TLabel;
    dbeVIDUTI: TDBEditFocus;
    dbeDepAnu: TDBEditFocus;
    dbePerRes: TDBEditFocus;
    dbeVLRRES: TDBEditFocus;
    edtDepAnual: TEditFocus;
    edtDepMensal: TEditFocus;
    edtDepAtual: TEditFocus;
    chkTemDep: TDBCheckBox;
    grpDepreciacaoSoc: TGroupBox;
    lblVidUtiSoc: TLabel;
    lblDepAnSoc: TLabel;
    lblPerSimbDepAnSoc: TLabel;
    lblPerResSoc: TLabel;
    lblSimbperResidualSoc: TLabel;
    lblVlrResSoc: TLabel;
    lblVlrRepAnSoc: TLabel;
    lblVlrRepMesSoc: TLabel;
    lblVlrRepAtuSoc: TLabel;
    dbeVIDUTS: TDBEditFocus;
    dbeDEPANS: TDBEditFocus;
    dbePERRSS: TDBEditFocus;
    dbeVLRRSS: TDBEditFocus;
    edtDepAnualSoc: TEditFocus;
    edtDepMensalSoc: TEditFocus;
    edtDepAtualSoc: TEditFocus;
    chkTEMDPS: TDBCheckBox;
    lblVlrRepRest: TLabel;
    edtDepRest: TEditFocus;
    lblVlrRepRestSoc: TLabel;
    edtDepRestSoc: TEditFocus;
    tbsPatrimonio_locfis: TTabSheet;
    Panel2: TPanel;
    Panel4: TPanel;
    lblQtdAqu: TLabel;
    Label5: TLabel;
    Panel3: TPanel;
    lblDescIte: TLabel;
    Label23: TLabel;
    Panel5: TPanel;
    btnAdicionarPat: TBitBtnLocked;
    btnExcluirPat: TBitBtnLocked;
    Panel6: TPanel;
    cxvPatLoc: TcxGridDBTableView;
    cxlPatLoc: TcxGridLevel;
    dtsPatLoc: TDataSource;
    lbl1: TLabel;
    Label29: TLabel;
    edtNumPat: TEditFocus;
    edtLocFis: TEditFocus;
    cxvPatLocColumn1: TcxGridDBColumn;
    cxvPatLocColumn2: TcxGridDBColumn;
    cxvPatLocColumn3: TcxGridDBColumn;
    cxgPatLoc: TcxGrid;
    dbeFUNCAO: TDBMemoFocus;
    grbPlaConSped: TGroupBox;
    Label4: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    cbbIndicadorTipoConta: TComboBoxFocus;
    dbeConCon: TDBEditFocus;
    dbeNivel: TDBEditFocus;
    cbbNaturezaContaContabil: TComboBoxFocus;
    chkConsiderarFrete: TDBCheckBox;
    Label27: TLabel;
    dbeDifAli: TDBEditFocus;
    pctConfiguracoes: TTabSheet;
    Label31: TLabel;
    dbeCodAju: TDBEditFocus;
    dbeDesAju: TDBEditFocus;
    Label32: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure dbeDocVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTIPIMOKeyPress(Sender: TObject; var Key: Char);
    procedure chkTemDepClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure dbeForAquKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForAquExit(Sender: TObject);
    procedure dbeCliVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCliVenExit(Sender: TObject);
    procedure grpDepreciacaoEnter(Sender: TObject);
    procedure gpInfoSpedEnter(Sender: TObject);
    procedure chkTEMDPSClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAdicionarPatClick(Sender: TObject);
    procedure cxvPatLocCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState;
      var AHandled: Boolean);
    procedure btnExcluirPatClick(Sender: TObject);
    procedure cxvPatLocKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tbsPatrimonio_locfisShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure chkConsiderarFreteClick(Sender: TObject);
    procedure dbeTIPIMOExit(Sender: TObject);
    procedure dbeTIPIMOEnter(Sender: TObject);
  private
    { Private declarations }
    FblnDepreciacaoSocietaria: boolean;
    objCadImo: TCadImo;
    qryCadEmp: TUniQuery;
    qryConsul: TUniQuery;
    qryConsulSoc: TUniQuery;
    qryCentroCustoSped: TUniQuery;
    TipoCalculo : TTipoCalculo;
    blnInsert: Boolean;
    blncontroleContabilImobilizado : Boolean;
    ImobilizadoDepreciacao: TImobilizadoDepreciacao;
    ImobilizadoDepreciacaoSoc: TImobilizadoDepreciacao;
    PatrimoniosLocalizacao: TPatrimoniosLocalizacao;
    FstrTipImoAnt: string;
    procedure pCarregaEmpresa;
    procedure pCarregaComBoxInfoSped;
    procedure pSetReadOnly;
    function  fVerificaDocumentoValido(var strErro: string; blnEntrada: Boolean; strCodIte: String = ''; blnCarregaCampos: Boolean = False; blnCarregaFrete: Boolean = False):Boolean;
    function fValidaCFOP(strCfop: String): Boolean;
    function  fValidaDocInformado(blnEntrada: Boolean; blnCarregaCampos: Boolean; var strErro: string): Boolean;
    function  fDocumentoInformado(blnEntrada: Boolean): Boolean;
    function  fCalcResidualPorcentagem(fltValor: Double): Double;
    function  fCalcResidualValor(fltTaxa: Double): Double;
    procedure pManipulaCamposDepreciacao;
    function fVazioToZero(strValue: String): string;
    procedure pIniciaDepreciacaoSocietaria ;
    procedure pLimpaEdtDepreciacao ;
    function fRetNaturezaSelecionada(strNatureza: String): Integer;
    procedure pCarregaVidUtiTipImo;
    function fValidaCodAju(strValue: String): Boolean;
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fCarregaTaxaAnualDoTipo: boolean;
    procedure pCarregaCampos;
  end;

var
  frmCadImobilizado: TfrmCadImobilizado;

implementation

{$R *.dfm}

uses SysUtils, Forms, untConstantes, untFuncoesSimples, untPesqAux, untPai,
  untConsultas, Contabilidade.Consultas, untTypesSistema, untFuncoes;

procedure TfrmCadImobilizado.FormCreate(Sender: TObject);
begin
  FblnDepreciacaoSocietaria := false ;
  blncontroleContabilImobilizado := Not fCfgSis('IMOSCO', varBoolean);
  objCadImo := TCadImo.Create(Self);
  blnInsert := False;
  case fCfgSis('DEPIMO', varInteger) Of
    1: Begin
         TipoCalculo := tcVidaUtil;
         lblConfiguracao.Caption := 'Pela Vida Útil';
       End;
    2: Begin
         TipoCalculo := tcFiscal;
         lblConfiguracao.Caption := 'Pela Deprecição Fiscal';
       End;
    3: Begin
         TipoCalculo := tcContabil;
         lblConfiguracao.Caption := 'Pela Deprecição Contábil';
       End;
  end;

  ////depreciação fiscal
  dbePerRes.Visible := (TipoCalculo = tcVidaUtil);
  dbeVLRRES.Visible := (TipoCalculo = tcVidaUtil);
  lblPerRes.Visible := (TipoCalculo = tcVidaUtil);
  lblVlrRes.Visible := (TipoCalculo = tcVidaUtil);
  lblSimbperResidual.Visible := (TipoCalculo = tcVidaUtil);

  dbeDepAnu.Visible := Not (TipoCalculo = tcVidaUtil);
  lblDepAn.Visible := Not (TipoCalculo = tcVidaUtil);
  lblPerSimbDepAn.Visible := Not (TipoCalculo = tcVidaUtil);

  ////depreciação societária
  dbePerRss.Visible := (TipoCalculo = tcVidaUtil);
  dbeVLRRSS.Visible := (TipoCalculo = tcVidaUtil);
  lblPerResSoc.Visible := (TipoCalculo = tcVidaUtil);
  lblVlrResSoc.Visible := (TipoCalculo = tcVidaUtil);
  lblSimbperResidualSoc.Visible := (TipoCalculo = tcVidaUtil);

  dbeDepAns.Visible := Not (TipoCalculo = tcVidaUtil);
  lblDepAnSoc.Visible := Not (TipoCalculo = tcVidaUtil);
  lblPerSimbDepAnSoc.Visible := Not (TipoCalculo = tcVidaUtil);

  pCarregaComBoxInfoSped;

  qryConsul := fCriaQuery;
  qryConsulSoc := fCriaQuery;


  inherited;

  strNomeTabela     := 'CADIMO';
  strNomeCampo      := 'IMO_CODIMO';
  qryTabela         := objCadImo.qryTabela;
  dtsCadImo.DataSet := qryTabela;
  pIniciaDepreciacaoSocietaria ;

  qryCadEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodImo;

  ImobilizadoDepreciacao := TImobilizadoDepreciacao.Create('F');
  ImobilizadoDepreciacao.qryConsulta := qryConsul;

  ImobilizadoDepreciacaoSoc := TImobilizadoDepreciacao.Create('S');
  ImobilizadoDepreciacaoSoc.qryConsulta := qryConsulSoc;

  pctImobilizado.ActivePageIndex := 0 ;
  FstrTipImoAnt := '';
end;

procedure TfrmCadImobilizado.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCentroCustoSped);
  FreeAndNil(qryCadEmp);
  FreeAndNil(ImobilizadoDepreciacao);
  FreeAndNil(ImobilizadoDepreciacaoSoc);
  FreeAndNil(qryConsul);
  FreeAndNil(qryConsulSoc);
  inherited;
end;

procedure TfrmCadImobilizado.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If pctImobilizado.ActivePage = tbsPatrimonio_locfis Then
  Begin
    Case Key of
      VK_F10: btnAdicionarPat.Click;
      VK_F11: btnExcluirPat.Click;
    End;
  End;
end;

procedure TfrmCadImobilizado.FormShow(Sender: TObject);
begin
  inherited;
  TFloatField(qryTabela.FieldByName('IMO_VALAQU')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('IMO_TOTAQU')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('IMO_VALICM')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldByName('IMO_DIFALI')).DisplayFormat := '#,##0.00';

end;

function TfrmCadImobilizado.fVazioToZero(strValue: String): string;
Begin
  If fEmptyStr(strValue) Then
     Result := '0'
  Else
     Result := strValue;
End;

function TfrmCadImobilizado.fValidaCodAju(strValue: String): Boolean;
begin
  Result := True;

  if Length(strValue) < 8 then
    Exit(False);

  if EhNumero(Copy(strValue, 1, 2)) then
    Exit(False);

  if Not EhNumero(Copy(strValue, 3, 6)) then
    Exit(False);
end;

function TfrmCadImobilizado.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  var strDesIte: String;
      fltTaxaDepAnu: Double;
      strErro: String;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin
    Try

      If (Sender = dbeDescri) Then
      Begin
        objCadImo.strDescri := dbeDescri.Text
      End

      Else If (Sender = edtLocFis)  Then
      Begin
        objCadImo.strLocFis := edtLocFis.Text
      End

      Else If (Sender = edtNUMPAT) Then
      Begin
        If (Not edtNUMPAT.Focused) And (Not PatrimoniosLocalizacao.fTemNumPat) And (Not blncontroleContabilImobilizado) Then
        Begin
          fMensagem('ATENÇÃO!', 'Nº Patrimônio deve ser preenchido!', ['&O k']);
          Result := False;
        End;
      End

      Else If (Sender = dbeDocVen) Then
      Begin
        If (Not fEmptyStr(dbeDocVen.Text)) Then
        Begin
          dbcVendid.Checked := True;
          dbcVendid.Field.AsString := 'S'
        End
        Else
        Begin
          dbcVendid.Checked := False;
          dbcVendid.Field.AsString := 'N';
        End;
        dbeSerVen.ReadOnly := fEmptyStr(dbeDocVen.Text);
        dbeCliVen.ReadOnly := fEmptyStr(dbeDocVen.Text);
        dbeEspVen.ReadOnly := fEmptyStr(dbeDocVen.Text);
        dbeSerVen.Enabled := Not fEmptyStr(dbeDocVen.Text);
        dbeCliVen.Enabled := Not fEmptyStr(dbeDocVen.Text);
        dbeEspVen.Enabled := Not fEmptyStr(dbeDocVen.Text);
        dbeSerVen.TabStop := Not fEmptyStr(dbeDocVen.Text);
        dbeCliVen.TabStop := Not fEmptyStr(dbeDocVen.Text);
        dbeEspVen.TabStop := Not fEmptyStr(dbeDocVen.Text);
        If fDocumentoInformado(False) And blncontroleContabilImobilizado Then
          If Not fValidaDocInformado(False, False, strErro) Then
          Begin
            fMensagem('ATENÇÃO!', 'Documento de Venda não foi encontrado!', ['&O k']);
            Result := False;
          End;
      End


      Else If (Sender = dbeTIPIMO) Then
      Begin
        If fEmptyStr(dbeTIPIMO.Text) And blncontroleContabilImobilizado Then
        Begin
          fMensagem('ATENÇÃO!', 'O Tipo Imobilizado/Patrimônio deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else  If Not fEmptyStr(dbeTIPIMO.Text) Then
        begin
          edtDesTipImo.Text  := fRetDesTipo_E_TaxaAnual_Imobilizado(fltTaxaDepAnu, dbeTIPIMO.Text);
          If fEmptyStr(edtDesTipImo.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Código Tipo Imobilizado/Patrimônio não esta cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
        If Result Then
        Begin
          If (blnBuscaPorChave) And fCarregaTaxaAnualDoTipo Then
            dbeDepAnu.Field.Value := fltTaxaDepAnu;

          Try
            objCadImo.fltDepAnu := fStrToFloat(dbeDepAnu.Text);
          Except
            // Silencia a mensagem de validação do objeto objCadImo
          End
        End;
      End


      Else If (Not dbeCliVen.ReadOnly) And ((Sender = dbeEspVen) Or (Sender = dbeSerVen) Or (Sender = dbeCliVen)) Then
      Begin
        If Not fEmptyStr(dbeDocVen.Text) Then
        begin
          If (Sender = dbeCliVen) Then
          Begin
            If (fEmptyStr(dbeCliVen.Text)) And (Not fEmptyStr(dbeDocVen.Text)) Then
            Begin
              fMensagem('', 'Informe o código do cliente!', ['&O K']);
              Result := False;
            End
            Else If Not fEmptyStr(dbeCliVen.Text) Then
            Begin
              edtDesCli.Text := fRetNomCliente(dbeCliVen.Text);

              If fEmptyStr(edtDesCli.Text) Then
              Begin
                fMensagem('','Cliente não encontrado!', ['&O K']);
                dbeCliVen.Clear;
                Result := False;
              End;

            End
            Else
            Begin
              edtDesCli.Clear;
              dbeCliVen.Clear;
            End;
          End;
        End;

        If Result And fDocumentoInformado(False) Then
          If Not fValidaDocInformado(False, True, strErro) Then
          Begin
            fMensagem('ATENÇÃO!', 'Documento de Venda não foi encontrado, ou esse documento não tem o item.', ['&O k']);
            Result := False;
          End
      End

      Else If Sender = dbeCodIte Then
      Begin
        If fEmptyStr(dbeCodIte.Text) And blncontroleContabilImobilizado Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Item deve ser informado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          strDesIte := fRetNomProduto(dbeCodIte.Text);
          If strDesIte <> edtDesIte.Text Then
          Begin
            edtDesIte.Text := strDesIte;
            If fEmptyStr(edtDesIte.Text) And blncontroleContabilImobilizado Then
            Begin
              fMensagem('ATENÇÃO!', 'O Item informado não foi encontrado!', ['&O k']);
              Result := False;
            End
            Else If Not fEmptyStr(edtDesIte.Text) Then
            Begin
              If Not fVerificaDocumentoValido(strErro, True, dbeCodIte.Text, True) Then
              Begin
                fMensagem('ATENÇÃO!', 'O Item não foi encontrado nesse documento!', ['&O k']);
                strDesIte := '';
                edtDesIte.Clear ;
                edtNCM.Clear;
                edtCST.Clear;
                dbeDtaAqu.Clear;
                dbeValAqu.Clear;
                dbeVlrTot.Clear;
                dbeValIcm.Clear;
                dbeQtdParcel.Clear;
                dbeCodIte.Clear;
                dbeCodIte.Field.Clear;
                edtDesIte.Clear;
                Result := False;
              End;
            End;
          End;
        End;
      End
      Else If (Sender = dbeDocAqu) And blncontroleContabilImobilizado Then
      Begin
        objCadImo.strDocAqu := (dbeDocAqu.Text);
        If fEmptyStr(dbeDocAqu.Text) Then
        begin
          fMensagem('', 'O Documento de entrada deve ser  preenchido!', ['&OK']);
          Result := False;
        End
        Else If fDocumentoInformado(True) Then
        Begin
          If Not fValidaDocInformado(True, False, strErro) Then
          Begin
            fMensagem('ATENÇÃO!', 'Documento de entrada não foi encontrado!', ['&O k']);
            Result := False;
            edtDesIte.Text := '';
          End;
        End;
        chkConsiderarFrete.Enabled := Result;
      End

      Else If (Sender = dbeEspAqu) Or (Sender = dbeSerAqu) Or (Sender = dbeForAqu) Then
      Begin
        If (Sender = dbeForAqu) Then
        Begin
          If fEmptyStr(dbeForAqu.Text)  And blncontroleContabilImobilizado Then
          Begin
            fMensagem('', 'Informe o código do Fornecedor!', ['&O K']);
            Result := False;
          End
          Else If Not fEmptyStr(dbeForAqu.Text) Then
          Begin
            edtDesForNot.Text := fRetNomFornecedor(dbeForAqu.Text);

            If fEmptyStr(edtDesForNot.Text)  And blncontroleContabilImobilizado Then
            Begin
              fMensagem('','Fornecedor não encontrado!', ['&O K']);
              dbeForAqu.Clear;
              Result := False;
            End;

            If (Not fValidaCampos(dbeCodEmp)) Then
              Result := False;
          End
          Else
          Begin
            edtDesForNot.Clear;
            dbeForAqu.Clear;
          End;
        End;

        If Result And fDocumentoInformado(True) Then
          If Not fValidaDocInformado(True, False, strErro) Then
           Begin
            If strErro <> '' Then
              fMensagem('ATENÇÃO!', strErro, ['&O k'])
            Else
              fMensagem('ATENÇÃO!', 'Documento de entrada não foi encontrado!', ['&O k']);
            Result := False;
          End;

      End


      Else If (Sender = dbeDepAnu) Then
      Begin
        Try
          objCadImo.fltDepAnu := fStrToFloat(dbeDepAnu.Text);
        Except
        End;
      End

      {*********************************}
      {* VALIDA O CODIGO DA EMPRESA    *}
      {******************************AA*}
      Else If (Sender = dbeCodEmp) Then
      Begin
        If fEmptyStr(dbeCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
          pctImobilizado.ActivePageIndex := 0;
          Result := False;
        End
        Else
        Begin
          pCarregaEmpresa;
          If qryCadEmp.FieldByName('EMP_CODEMP').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
            Result := False;
          End
        End;
      End

      Else If (Sender = dbcVendid) Then
      Begin
        If (Not fEmptyStr(dbeDocVen.Text)) Then
        Begin
          dbcVendid.Checked := True;
          dbcVendid.Field.AsString := 'S'
        End
        Else
        Begin
          dbcVendid.Checked := False;
          dbcVendid.Field.AsString := 'N';
        End;
        If blnBuscaPorChave  Then
        Begin
{          blnMudarFoco := False;
          pSetFocus(dbeTipImo);}
        End;
      End
      Else If Sender = dbePerRes Then
      begin
        If StrToFloatDef(dbePerRes.Text, 0) >= 0 Then
          dbeVLRRES.Field.Value :=  fCalcResidualValor(StrToFloatDef(dbePerRes.Text, 0));
      End
      Else If Sender = dbePERRSS Then
      begin
        If StrToFloatDef(dbePERRSS.Text, 0) >= 0 Then
          dbeVLRRSS.Field.Value :=  fCalcResidualValor(StrToFloatDef(dbePERRSS.Text, 0));
      End
      Else If Sender = dbeVLRRES Then
      Begin
        If StrToFloatDef(dbeVLRRES.Text, 0) >= 0 Then
          dbePerRes.Field.Value :=  fCalcResidualPorcentagem(StrToFloatDef(StringReplace(dbeVLRRES.Text, '.', '', []), 0));
      End
      Else If Sender = dbeVLRRSS Then
      Begin
        If StrToFloatDef(dbeVLRRSS.Text, 0) >= 0 Then
          dbePERRSS.Field.Value :=  fCalcResidualPorcentagem(StrToFloatDef(StringReplace(dbeVLRRSS.Text, '.', '', []), 0));
      End
      Else If (Sender = dbeCodAju) Then
      Begin
        If (Not fEmptyStr(dbeCodAju.Text)) Then
        Begin
          if Not fValidaCodAju(dbeCodAju.Text) Then
          begin
            fMensagem('ATENÇÃO!', 'Código de Ajuste Inválido.' + #13 +
                                  'Informar código no formato XXNNNNNN.' + #13 +
                                  'Ex: SP010307', ['&O k']);
            Result := False;
          end
          else
          begin
            if fEmptyStr(dbeDesAju.Text) then
            begin
              fMensagem('ATENÇÃO!', 'Descrição do Ajuste não informado.', ['&O k']);
              Result := False;
            end;
          end;
        End;
      End;

      If (chkTemDep.Checked) And
         ((Sender = dbeVLRRES) Or (Sender = dbeDepAnu) Or (Sender = dbePerRes) Or
         (Sender = dbeVLRRES) Or (Sender = dbeVlrTot) Or (Sender = dbeVIDUTI)) And
         (strToInt(fVazioToZero(StringReplace(dbeVIDUTI.Text, '.', '', []))) >= 0) Then
      Begin

        ImobilizadoDepreciacao.pCalcularDepreciacao(TipoCalculo,
                                                    qryTabela.FieldByName('IMO_DTAAQU').AsDateTime,
                                                    strToInt(fVazioToZero(StringReplace(dbeVIDUTI.Text, '.', '', []))),
                                                    strToFloat(fVazioToZero(StringReplace(dbeDepAnu.Text, '.', '', []))),   //fltTaxaDepreciacao: Double;
                                                    strToFloat(fVazioToZero(StringReplace(dbeValAqu.Text, '.', '', []))),   //Valor da Aquisicao
                                                    strToFloat(fVazioToZero(StringReplace(dbeVLRRES.Text, '.', '', []))));  //Valor Residual

        edtDepAnual.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoAnual);
        edtDepMensal.Text := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoMensal);
        edtDepAtual.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacao.Depreciacoes[ImobilizadoDepreciacao.fGetParcelaAtual(dbeDtaAqu.Field.AsDateTime)].vlrDepreciacaoAcumulada);
        edtDepRest.Text   := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoRestante);
      End;

      If (FblnDepreciacaoSocietaria) and
         (chkTEMDPS.Checked) And
         ((Sender = dbeVLRRSS) Or (Sender = dbeDEPANS) Or (Sender = dbePERRSS) Or
         (Sender = dbeVLRRSS) Or (Sender = dbeVlrTot) Or (Sender = dbeVIDUTS)) And
         (strToInt(fVazioToZero(StringReplace(dbeVIDUTS.Text, '.', '', []))) >= 0) Then
      Begin

        ImobilizadoDepreciacaoSoc.pCalcularDepreciacao(TipoCalculo,
                                                    qryTabela.FieldByName('IMO_DTAAQU').AsDateTime,
                                                    strToInt(fVazioToZero(StringReplace(dbeVIDUTS.Text, '.', '', []))),
                                                    strToFloat(fVazioToZero(StringReplace(dbeDEPANS.Text, '.', '', []))),   //fltTaxaDepreciacao: Double;
                                                    strToFloat(fVazioToZero(StringReplace(dbeValAqu.Text, '.', '', []))),   //Valor da Aquisicao
                                                    strToFloat(fVazioToZero(StringReplace(dbeVLRRSS.Text, '.', '', []))));  //Valor Residual

        edtDepAnualSoc.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoAnual);
        edtDepMensalSoc.Text := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoMensal);
        edtDepAtualSoc.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.Depreciacoes[ImobilizadoDepreciacaoSoc.fGetParcelaAtual(dbeDtaAqu.Field.AsDateTime)].vlrDepreciacaoAcumulada);
        edtDepRestSoc.Text      := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoRestante);
      End;


    Except
      On E: ExceptionAutcom Do
      Begin
				fMensagem('',E.Message,['&OK']);
        Result := False;
      End;

      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmCadImobilizado.fValidaCampos]');
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadImobilizado.fValidaCFOP(strCfop: String): Boolean;
var CfopValida: String;
begin
  CfopValida := fTransform(fCfgSis('CFOIMO'), 3);
  Result := Pos(Copy(strCfop, 2, 3), CfopValida)  > 0;
end;

function TfrmCadImobilizado.fValidaDocInformado(blnEntrada: Boolean; blnCarregaCampos: Boolean; var strErro: string): Boolean;
begin
  Result := True;
  If fDocumentoInformado(blnEntrada) Then
    Result := fVerificaDocumentoValido(strErro, blnEntrada, dbeCodIte.Text, blnCarregaCampos)
end;

function TfrmCadImobilizado.fVerificaDocumentoValido(var strErro: string;
                                                     blnEntrada: Boolean;
                                                     strCodIte: String = '';
                                                     blnCarregaCampos: Boolean = False;
                                                     blnCarregaFrete: Boolean = False): Boolean;
  var
    strNumDoc,
    strEspDoc,
    strSerie_,
    strCliFor: string;
    objDbeDta,
    objDbeVal,
    objDbeIcm: TDBEditFocus;

begin
  strErro := '';
  strNumDoc := IIf(blnEntrada, dbeDocAqu.Text, dbeDocVen.Text);
  strEspDoc := IIf(blnEntrada, dbeEspAqu.Text, dbeEspVen.Text);
  strSerie_ := IIf(blnEntrada, dbeSerAqu.Text, dbeSerVen.Text);
  strCliFor := IIf(blnEntrada, dbeForAqu.Text, dbeCliVen.Text);

  If blnEntrada Then
  Begin
    objDbeDta := dbeDtaAqu;
    objDbeVal := dbeValAqu;
    objDbeIcm := dbeValIcm;
  End
  Else
  Begin
    objDbeDta := dbeDtaVen;
    objDbeVal := dbeValVen;
    objDbeIcm := dbeValIcmVen;
  End;

  qryConsul.sql.Clear;
  qryConsul.SQL.Add('SELECT COUNT(1) AS QTD');
  qryConsul.SQL.Add('       ,GER_CLAFIS');
  If not fEmptyStr(strCodIte) Then
  Begin
    qryConsul.SQL.Add(',DET_QTDITE');
    qryConsul.SQL.Add(',DET_DTAENT');
    qryConsul.SQL.Add(',DET_VLRCON');
    qryConsul.SQL.Add(',DET_VALICM');
    qryConsul.SQL.Add(',DET_TOTFRE');
    qryConsul.SQL.Add(',( DET_TOTITE - DET_DESESP ) / DET_QTDITE AS VALAQU');

    If chkConsiderarFrete.checked Then
      qryConsul.SQL.Add(',DET_TOTITE - DET_DESESP + DET_TOTFRE AS TOTAQU')
    Else
      qryConsul.SQL.Add(',DET_TOTITE - DET_DESESP AS TOTAQU');

    If Not fEmptyStr(strCodIte) Then
    begin
      qryConsul.SQL.Add(',ITE_CLAIPI ');
      qryConsul.SQL.Add(',MOVDET.DET_CODFIS ');
    End;
    qryConsul.SQL.Add(',LEFT(DET_CONPAG, 2)AS DET_CONPAG');
  End;
  qryConsul.SQL.Add('  FROM MOVGER');
  If Not fEmptyStr(strCodIte) Then
  Begin
    qryConsul.SQL.Add(' INNER JOIN MOVDET ON DET_SEQGER = MOVGER.AUTOINCREM ');
    qryConsul.SQL.Add(' INNER JOIN CADITE ON ITE_CODITE = MOVDET.DET_CODITE ');

  End;
  qryConsul.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
  qryConsul.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
  qryConsul.SQL.Add('   AND IFNULL(GER_SERIE_, "") = :SERIE_');
  qryConsul.SQL.Add('   AND GER_CODEMP = :CODEMP');
  If Not fEmptyStr(strCodIte) Then
    qryConsul.SQL.Add('   AND DET_CODITE = "'+ strCodIte + '"');
  If blnEntrada Then
  Begin
    qryConsul.SQL.Add('   AND GER_CODFOR = :CLIFOR');
//    qryConsul.SQL.Add('   AND IFNULL(GER_ORIDOC, "") = ""');
    qryConsul.SQL.Add('   AND GER_CLAFIS < "5000"');
  End
  Else
  Begin
    qryConsul.SQL.Add('   AND GER_CODCLI = :CLIFOR');
    qryConsul.SQL.Add('   AND IFNULL(GER_ORIDOC, "") = "V"');
    qryConsul.SQL.Add('   AND GER_CLAFIS > "5000"');
  End;
  qryConsul.ParamByName('NUMDOC').AsString := strNumDoc;
  qryConsul.ParamByName('ESPDOC').AsString := strEspDoc;
  qryConsul.ParamByName('SERIE_').AsString := strSerie_;
  qryConsul.ParamByName('CLIFOR').AsString := strCliFor;
  qryConsul.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
  qryConsul.Open;

  Result := (qryConsul.FieldByName('QTD').AsInteger > 0);

  If Result Then
    result := fValidaCFOP(qryConsul.FieldByName('GER_CLAFIS').AsString);

 If (Not result) And (Not fEmptyStr(qryConsul.FieldByName('GER_CLAFIS').AsString)) And (not fValidaCFOP(qryConsul.FieldByName('GER_CLAFIS').AsString)) then
   strErro := 'A Classificação [' + qryConsul.FieldByName('GER_CLAFIS').AsString + '] do documento informado não esta declarada na Configuração [CFG_CFOIMO]';

  If Result And blnCarregaCampos And (not fEmptyStr(strCodIte)) Then
  Begin
    If qryTabela.State in dsEditModes Then
    Begin
      If Not blnCarregaFrete Then
      Begin
        objDbeDta.Field.Value := qryConsul.FieldByName('DET_DTAENT').Value;
        objDbeVal.Field.Value := qryConsul.FieldByName('VALAQU').Value;
        objDbeIcm.Field.Value := qryConsul.FieldByName('DET_VALICM').Value;
      End;

      If blnEntrada Then
      Begin
        dbeQtdImo.Field.Value := qryConsul.FieldByName('DET_QTDITE').Value;
        dbeQtdParcel.Field.Value := 1;
        if Not fEmptyStr(qryConsul.FieldByName('DET_CONPAG').AsString) Then
          dbeQtdParcel.Field.Value := qryConsul.FieldByName('DET_CONPAG').Value;
        dbeVlrTot.Field.Value := qryConsul.FieldByName('TOTAQU').Value;
      End;
    End;
    edtNCM.Text := qryConsul.FieldByName('ITE_CLAIPI').AsString;
    edtCST.Text := qryConsul.FieldByName('DET_CODFIS').AsString;
  End;
end;

procedure TfrmCadImobilizado.gpInfoSpedEnter(Sender: TObject);
begin
  inherited;
  SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadImobilizado.grpDepreciacaoEnter(Sender: TObject);
begin
  inherited;
  //SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadImobilizado.pIniciaDepreciacaoSocietaria;
begin
  if Assigned(qryTabela.FindField('IMO_TEMDPS')) then
  begin
    chkTEMDPS.DataField := 'IMO_TEMDPS' ;
    chkTEMDPS.Tag := 99 ;
    dbeVIDUTS.DataField := 'IMO_VIDUTS' ;
    dbeVIDUTS.Tag := 99 ;
    dbeDEPANS.DataField := 'IMO_DEPANS' ;
    dbeDEPANS.Tag := 99 ;
    dbePERRSS.DataField := 'IMO_PERRSS' ;
    dbePERRSS.Tag := 99 ;
    dbeVLRRSS.DataField := 'IMO_VLRRSS' ;
    dbeVLRRSS.Tag := 99 ;

    grpDepreciacaoSoc.Visible := True ;
    chkTEMDPS.Visible := True ;
    FblnDepreciacaoSocietaria := True ;
  end;
end;

procedure TfrmCadImobilizado.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('IMO_CODIMO');
  stlCampos.Add('IMO_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('IMO_DESCRI');
  stlCamInd.Add('IMO_CODIMO');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmCadImobilizado.pLimpaEdtDepreciacao;
begin
  edtDepAnualSoc.Clear;
  edtDepMensalSoc.Clear;
  edtDepAtualSoc.Clear;
  edtDepRestSoc.Clear;

  edtDepAnual.Clear;
  edtDepMensal.Clear;
  edtDepAtual.Clear;
  edtDepRest.Clear;
end;

procedure TfrmCadImobilizado.pSetReadOnly;
begin
  edtDesIte.ReadOnly := True;
  dbeQtdImo.ReadOnly := blncontroleContabilImobilizado;
  dbeEspAqu.Readonly := True;
  dbeEspVen.Readonly := True;
  dbeDtaAqu.ReadOnly := blncontroleContabilImobilizado;
  dbeValAqu.ReadOnly := blncontroleContabilImobilizado;
  If Not blncontroleContabilImobilizado Then
  Begin
   dbeValIcm.ReadOnly := False;
   dbeQtdParcel.ReadOnly := False;
   dbeVlrTot.ReadOnly := False;
  End;
  dbeDtaVen.ReadOnly := blncontroleContabilImobilizado;
  dbeValVen.ReadOnly := blncontroleContabilImobilizado;
  dbeValIcmVen.ReadOnly := blncontroleContabilImobilizado;
  edtDesForNot.ReadOnly := True;
  edtDesIte.ReadOnly := True;
  edtDesCli.ReadOnly := True;

  edtDesForNot.TabStop := False;
  edtDesIte.TabStop := False;
  edtDesCli.TabStop := False;

  dbeSerVen.ReadOnly := True;
  dbeCliVen.ReadOnly := fEmptyStr(dbeDocVen.Text);
  dbeEspVen.ReadOnly := fEmptyStr(dbeDocVen.Text);
  dbeSerVen.Enabled := Not fEmptyStr(dbeDocVen.Text);
  dbeCliVen.Enabled := Not fEmptyStr(dbeDocVen.Text);
  dbeEspVen.Enabled := Not fEmptyStr(dbeDocVen.Text);
  dbeEspVen.TabStop := Not fEmptyStr(dbeDocVen.Text);
  dbeSerVen.TabStop := Not fEmptyStr(dbeDocVen.Text);
  dbeCliVen.TabStop := Not fEmptyStr(dbeDocVen.Text);

  dbeDocAqu.ReadOnly := Not blnInsert;
  dbeDocAqu.TabStop  := blnInsert;

  dbeEspAqu.ReadOnly := Not blnInsert;
  dbeEspAqu.TabStop  := blnInsert;

  dbeSerAqu.ReadOnly := Not blnInsert;
  dbeSerAqu.TabStop  := blnInsert;

  dbeForAqu.ReadOnly := Not blnInsert;
  dbeForAqu.TabStop  := blnInsert;

  If TipoCalculo = tcFiscal Then
  Begin
    dbeDepAnu.ReadOnly := True;
    dbeDepAnu.TabStop  := False;
  End;

  If (TipoCalculo <> tcVidaUtil) Then
  Begin
    dbePerRes.Field.Value := 0;
    dbeVLRRES.Field.Value := 0;

    dbePERRSS.Field.Value := 0;
    dbeVLRRSS.Field.Value := 0;
  End;
end;

procedure TfrmCadImobilizado.tbsPatrimonio_locfisShow(Sender: TObject);
begin
  inherited;
  lblDescIte.Caption := dbeCodIte.Text + ' ' + edtDesIte.Text;
  lblQtdAqu.Caption  := dbeQtdImo.Text;
end;

procedure TfrmCadImobilizado.btnCancelaClick(Sender: TObject);
begin
  inherited;
  blnInsert := False;
  pCarregaCampos;

  If Assigned(PatrimoniosLocalizacao) Then
    FreeAndNil(PatrimoniosLocalizacao);
  PatrimoniosLocalizacao := TPatrimoniosLocalizacao.create(qryTabela.FieldByName('AUTOINCREM').AsString, dtsPatLoc);


  ////fiscal
  ImobilizadoDepreciacao.pCalcularDepreciacao(TipoCalculo,
                                              qryTabela.FieldByName('IMO_DTAAQU').AsDateTime,
                                              qryTabela.FieldByName('IMO_VIDUTI').AsInteger,
                                              qryTabela.FieldByName('IMO_DEPANU').AsFloat,   //fltTaxaDepreciacao: Double;
                                              qryTabela.FieldByName('IMO_VALAQU').AsFloat,   //Valor da Aquisicao
                                              qryTabela.FieldByName('IMO_VLRRES').AsFloat);  //Valor Residual
  edtDepAnual.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoAnual);
  edtDepMensal.Text := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoMensal);
  edtDepAtual.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacao.Depreciacoes[ImobilizadoDepreciacao.fGetParcelaAtual(dbeDtaAqu.Field.AsDateTime)].vlrDepreciacaoAcumulada);
  edtDepRest.Text   := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoRestante);

  ///societaria
  if FblnDepreciacaoSocietaria then
  begin
    ImobilizadoDepreciacaoSoc.pCalcularDepreciacao(TipoCalculo,
                                                qryTabela.FieldByName('IMO_DTAAQU').AsDateTime,
                                                qryTabela.FieldByName('IMO_VIDUTS').AsInteger,
                                                qryTabela.FieldByName('IMO_DEPANS').AsFloat,   //fltTaxaDepreciacao: Double;
                                                qryTabela.FieldByName('IMO_VALAQU').AsFloat,   //Valor da Aquisicao
                                                qryTabela.FieldByName('IMO_VLRRSS').AsFloat);  //Valor Residual
    edtDepAnualSoc.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoAnual);
    edtDepMensalSoc.Text := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoMensal);
    edtDepAtualSoc.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.Depreciacoes[ImobilizadoDepreciacaoSoc.fGetParcelaAtual(dbeDtaAqu.Field.AsDateTime)].vlrDepreciacaoAcumulada);
    edtDepRestSoc.Text   := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoRestante);
  end;

  edtLocFis.Text := '';
  edtNumPat.Text := '';
end;

procedure TfrmCadImobilizado.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadImobilizado.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

end;

procedure TfrmCadImobilizado.btnExcluirPatClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State in dsEditModes Then
  Begin

    If PatrimoniosLocalizacao.intSequencialEdicao > -1 Then
    Begin
      If fPergunta('Deseja excluir o registro Sequencial ' + IntToStr(PatrimoniosLocalizacao.intSequencialEdicao)) Then
      Begin
        PatrimoniosLocalizacao.pExcluir(PatrimoniosLocalizacao.intSequencialEdicao);
        edtLocFis.Text := '';
        edtNumpat.Text := '';
        PatrimoniosLocalizacao.intSequencialEdicao := -1;
      End;
    End
    Else
    Begin
      If fPergunta('Deseja excluir o registro Sequencial ' + PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_SEQUEN').AsString) Then
      Begin
        PatrimoniosLocalizacao.pExcluir(PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_SEQUEN').aSiNTEGER);
        edtLocFis.Text := '';
        edtNumpat.Text := '';
        PatrimoniosLocalizacao.intSequencialEdicao := -1;
      End;
    End;
  End;
end;

procedure TfrmCadImobilizado.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  pSetFocus(btnGravar);

  If (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    qryTabela.FieldByName('IMO_INDTPC').AsString := IIF(cbbIndicadorTipoConta.ItemIndex = 0, 'A', 'S');
    qryTabela.FieldByName('IMO_NATCON').AsString := Copy(cbbNaturezaContaContabil.Items[cbbNaturezaContaContabil.ItemIndex], 0, 2);
  End;

  Try
    inherited;

    If chkTemDep.Checked Then
      ImobilizadoDepreciacao.pGravaDepreciacaoImobilizados(dbeCodImo.Text);

    If (FblnDepreciacaoSocietaria) and (chkTEMDPS.Checked) Then
      ImobilizadoDepreciacaoSoc.pGravaDepreciacaoImobilizados(dbeCodImo.Text);

    If BlnGravou Then
    begin
      PatrimoniosLocalizacao.pGravar(qryTabela.FieldByName('AUTOINCREM').AsString);
      FreeAndNil(PatrimoniosLocalizacao);
      PatrimoniosLocalizacao := TPatrimoniosLocalizacao.Create(qryTabela.FieldByName('AUTOINCREM').AsString, dtsPatLoc);
      edtLocFis.Text := '';
      edtNumPat.Text := '';
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadImobilizado.btnGravarClick]');
    End;
  End;
  blnInsert := False;
end;

procedure TfrmCadImobilizado.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnInsert := True;

  cbbIndicadorTipoConta.ItemIndex := 0;
  cbbNaturezaContaContabil.ItemIndex := 5;

  dbcVendid.Checked := FALSE;
  dbcVendid.Field.AsString := 'N';

  chkTemDep.Checked := FALSE;
  chkTemDep.Field.AsString := 'N';
  dbeVIDUTI.Field.AsFloat := 0.00 ;
  dbeDepAnu.Field.AsFloat := 0.00 ;
  dbePerRes.Field.AsFloat := 0.00 ;
  dbeVLRRES.Field.AsFloat := 0.00 ;

  chkConsiderarFrete.Checked := False;
  chkConsiderarFrete.Field.AsString := 'N';
  chkConsiderarFrete.Enabled := False;

  if FblnDepreciacaoSocietaria then
  begin
    chkTemDPS.Checked := FALSE;
    chkTemDPS.Field.AsString := 'N' ;
    dbeVIDUTS.Field.AsFloat := 0.00 ;
    dbeDEPANS.Field.AsFloat := 0.00 ;
    dbePERRSS.Field.AsFloat := 0.00 ;
    dbeVLRRSS.Field.AsFloat := 0.00 ;
  end;
  edtLocFis.Text := '';
  edtNumPat.Text := '';

  edtDesEmpresa.Text := '';
  ImobilizadoDepreciacao.pInicia;
  ImobilizadoDepreciacaoSoc.pInicia;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodImo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodImo, dbeCodImo, True);
  dbeEspAqu.Field.Value := 'NF';
  dbeEspVen.Field.Value := 'NF';
  pSetReadOnly;

  edtDesForNot.Clear;
  edtDesCli.Clear;
  edtDesIte.Clear;
  edtDesTipImo.Clear;
  pLimpaEdtDepreciacao ;
  chkTemDep.Checked := False;
  edtNCM.Clear;
  edtCST.Clear;
  If Assigned(PatrimoniosLocalizacao) Then
    FreeAndNil(PatrimoniosLocalizacao);
  PatrimoniosLocalizacao := TPatrimoniosLocalizacao.create('', dtsPatLoc);

end;

procedure TfrmCadImobilizado.btnAdicionarPatClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State in dsEditModes Then
  Begin

    If (PatrimoniosLocalizacao.intSequencialEdicao = -1) And ((PatrimoniosLocalizacao.cdsPatrimonios.RecordCount) = Ceil(qryTabela.FieldByName('IMO_QTDIMO').AsFloat)) Then
    Begin
      pMensagemOk('Quantidade de Localização fisica Excede a quantidade de aquisição.');
      edtLocFis.Text := '';
      edtNumpat.Text := '';
      Exit;
    End;


    If fEmptyStr(edtLocFis.Text) And fEmptyStr(edtNumPat.Text) Then
    Begin
      pMensagemOk('Precisa ser informado "Nº do patrimônio" ou "Localização Física"');
      Exit;
    End;
    PatrimoniosLocalizacao.pIncluir(edtLocFis.Text, edtNumpat.Text, PatrimoniosLocalizacao.intSequencialEdicao);
    edtLocFis.Text := '';
    edtNumpat.Text := '';
    PatrimoniosLocalizacao.intSequencialEdicao := -1;
    pSetFocus(edtNumPat);
  End;
end;

procedure TfrmCadImobilizado.btnAlterarClick(Sender: TObject);
begin
  inherited;

  pHabilitaCodigo(dbeCodImo, dbeDescri, False);
  pSetReadOnly;
  pCarregaCampos;
  pManipulaCamposDepreciacao;
  If Assigned(PatrimoniosLocalizacao) Then
    PatrimoniosLocalizacao.intSequencialEdicao := -1;
  edtLocFis.Text := '';
  edtNumPat.Text := '';
end;

function TfrmCadImobilizado.fRetNaturezaSelecionada(strNatureza: String): Integer;
Var
  intIndex: Integer;
begin
  intIndex := AnsiIndexStr(strNatureza,['01','02','03','04','05','09']);
  if intIndex = -1 then
    intIndex := 0;
  Result := intIndex;
end;

procedure TfrmCadImobilizado.btnPesquisaClick(Sender: TObject);
  Var
  arrImob : TConsultasArray;
  chrKey  : Char;
  strErro: String;
begin
  {****************************************}
  {* NOVA CONSULTA DE ATIVO / IMOBILIZADO *}
  {*************************************DP*}
  chrKey := '/';
  If fPesqAtivoImob(Self, Nil, Nil, qryTabela, chrKey, arrImob) Then
  Begin
    cbbIndicadorTipoConta.ItemIndex := IIF(qryTabela.FieldByName('IMO_INDTPC').AsString = 'A', 0, 1);
    cbbNaturezaContaContabil.ItemIndex := fRetNaturezaSelecionada(qryTabela.FieldByName('IMO_NATCON').AsString);

    pLimpaEdtDepreciacao ;
    pCarregaEmpresa;
    pCarregaCampos;

    If Not fEmptyStr(dbeCodIte.Text) Then
    begin
      fVerificaDocumentoValido(strErro, True, dbeCodIte.Text, True)
    end;

    dbeSerVen.ReadOnly := fEmptyStr(dbeDocVen.Text);
    dbeCliVen.ReadOnly := fEmptyStr(dbeDocVen.Text);
    dbeEspVen.ReadOnly := fEmptyStr(dbeDocVen.Text);
    dbeSerVen.TabStop := Not fEmptyStr(dbeDocVen.Text);
    dbeCliVen.TabStop := Not fEmptyStr(dbeDocVen.Text);
    dbeEspVen.TabStop := Not fEmptyStr(dbeDocVen.Text);

    ////fiscal
    ImobilizadoDepreciacao.pCalcularDepreciacao(TipoCalculo,
                                                qryTabela.FieldByName('IMO_DTAAQU').AsDateTime,
                                                qryTabela.FieldByName('IMO_VIDUTI').AsInteger,
                                                qryTabela.FieldByName('IMO_DEPANU').AsFloat,   //fltTaxaDepreciacao: Double;
                                                qryTabela.FieldByName('IMO_VALAQU').AsFloat,   //Valor da Aquisicao
                                                qryTabela.FieldByName('IMO_VLRRES').AsFloat);  //Valor Residual
    edtDepAnual.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoAnual);
    edtDepMensal.Text := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoMensal);
    edtDepAtual.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacao.Depreciacoes[ImobilizadoDepreciacao.fGetParcelaAtual(dbeDtaAqu.Field.AsDateTime)].vlrDepreciacaoAcumulada);
    edtDepRest.Text   := FormatFloat('#,##0.00', ImobilizadoDepreciacao.FDepreciacaoRestante);

    If Assigned(PatrimoniosLocalizacao) Then
      FreeAndNil(PatrimoniosLocalizacao);
    PatrimoniosLocalizacao := TPatrimoniosLocalizacao.create(qryTabela.FieldByName('AUTOINCREM').AsString, dtsPatLoc);


    ///societaria
    if (FblnDepreciacaoSocietaria) then
    begin
      ImobilizadoDepreciacaoSoc.pCalcularDepreciacao(TipoCalculo,
                                                  qryTabela.FieldByName('IMO_DTAAQU').AsDateTime,
                                                  qryTabela.FieldByName('IMO_VIDUTS').AsInteger,
                                                  qryTabela.FieldByName('IMO_DEPANS').AsFloat,   //fltTaxaDepreciacao: Double;
                                                  qryTabela.FieldByName('IMO_VALAQU').AsFloat,   //Valor da Aquisicao
                                                  qryTabela.FieldByName('IMO_VLRRSS').AsFloat);  //Valor Residual
      edtDepAnualSoc.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoAnual);
      edtDepMensalSoc.Text := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoMensal);
      edtDepAtualSoc.Text  := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.Depreciacoes[ImobilizadoDepreciacaoSoc.fGetParcelaAtual(dbeDtaAqu.Field.AsDateTime)].vlrDepreciacaoAcumulada);
      edtDepRestSoc.Text   := FormatFloat('#,##0.00', ImobilizadoDepreciacaoSoc.FDepreciacaoRestante);
    end;

  End;
end;

procedure TfrmCadImobilizado.chkConsiderarFreteClick(Sender: TObject);
var
  strErro:String;
begin
  inherited;
  If Not fEmptyStr(dbeCodIte.Text) Then
  begin
    fVerificaDocumentoValido(strErro, True, dbeCodIte.Text, True, True)
  end;
end;

procedure TfrmCadImobilizado.chkTemDepClick(Sender: TObject);
begin
  inherited;
  If Not (qryTabela.State in dsEditModes) Then
    Exit;

  pManipulaCamposDepreciacao;
end;

procedure TfrmCadImobilizado.chkTEMDPSClick(Sender: TObject);
begin
  inherited;
  If Not (qryTabela.State in dsEditModes) Then
    Exit;

  pManipulaCamposDepreciacao;
end;

procedure TfrmCadImobilizado.cxvPatLocCellDblClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If qryTabela.State in dsEditModes Then
  Begin
    edtNumPat.Text := PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_NUMPAT').AsString;
    edtLocFis.Text := PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_LOCFIS').AsString;
    PatrimoniosLocalizacao.intSequencialEdicao := PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_SEQUEN').AsInteger;
  End;
end;

procedure TfrmCadImobilizado.cxvPatLocKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If qryTabela.State in dsEditModes Then
  Begin
    If Key = VK_DELETE  Then
    Begin
      If fPergunta('Deseja excluir o registro Sequencial ' + PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_SEQUEN').AsString) Then
        PatrimoniosLocalizacao.pExcluir(PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_SEQUEN').AsInteger)
    End
    Else
    If Key = VK_RETURN Then
    Begin
      edtNumPat.Text := PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_NUMPAT').AsString;
      edtLocFis.Text := PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_LOCFIS').AsString;
      PatrimoniosLocalizacao.intSequencialEdicao := PatrimoniosLocalizacao.cdsPatrimonios.FieldByName('PAT_SEQUEN').AsInteger;
    End;

  End;
end;

procedure TfrmCadImobilizado.pManipulaCamposDepreciacao;
Begin
  grpDepreciacao.Enabled := chkTemDep.Checked;
  dbeVIDUTI.Enabled    := chkTemDep.Checked;
  dbeDepAnu.Enabled    := chkTemDep.Checked;
  dbePerRes.Enabled    := chkTemDep.Checked;
  dbeVLRRES.Enabled    := chkTemDep.Checked;
  edtDepAnual.Enabled  := chkTemDep.Checked;
  edtDepMensal.Enabled := chkTemDep.Checked;
  edtDepAtual.Enabled  := chkTemDep.Checked;
  lblVidUti.Enabled    := chkTemDep.Checked;
  lblDepAn.Enabled     := chkTemDep.Checked;
  lblPerRes.Enabled    := chkTemDep.Checked;
  lblVlrRes.Enabled    := chkTemDep.Checked;
  lblVlrRepAn.Enabled  := chkTemDep.Checked;
  lblVlrRepMes.Enabled := chkTemDep.Checked;
  lblVlrRepAtu.Enabled := chkTemDep.Checked;
  lblVlrRepRest.Enabled := chkTemDep.Checked;
  lblSimbperResidual.Enabled := chkTemDep.Checked;
  ////societaria
  edtDepAnualSoc.Enabled     := chkTEMDPS.Checked;
  edtDepMensalSoc.Enabled    := chkTEMDPS.Checked;
  edtDepAtualSoc.Enabled     := chkTEMDPS.Checked;
  grpDepreciacaoSoc.Enabled  := chkTEMDPS.Checked;
  dbeVIDUTS.Enabled          := chkTEMDPS.Checked;
  dbeDEPANS.Enabled          := chkTEMDPS.Checked;
  dbePERRSS.Enabled          := chkTEMDPS.Checked;
  dbeVLRRSS.Enabled          := chkTEMDPS.Checked;
  lblVidUtiSoc.Enabled       := chkTEMDPS.Checked;
  lblDepAnSoc.Enabled        := chkTEMDPS.Checked;
  lblPerResSoc.Enabled       := chkTEMDPS.Checked;
  lblVlrResSoc.Enabled       := chkTEMDPS.Checked;
  lblVlrRepAnSoc.Enabled     := chkTEMDPS.Checked;
  lblVlrRepMesSoc.Enabled    := chkTEMDPS.Checked;
  lblVlrRepAtuSoc.Enabled    := chkTEMDPS.Checked;
  lblVlrRepRestSoc.Enabled   := chkTEMDPS.Checked;
  lblSimbperResidualSoc.Enabled := chkTEMDPS.Checked;
End;

procedure TfrmCadImobilizado.pCarregaComBoxInfoSped;
begin
  qryCentroCustoSped := fCriaQuery(Nil);
  dsIndicadorCentroCusto.DataSet := qryCentroCustoSped;

  With qryCentroCustoSped Do
  Begin
    Close;
    SQL.Clear;
    SQL.Text := 'SELECT * FROM CTASPE WHERE SPE_CONIPI = :CONIPI ';

    If fCfgSis('CONIPI') = 'S' Then
      ParamByName('CONIPI').AsString := 'S'
    Else
      ParamByName('CONIPI').AsString := 'N';

    Open;
  End;
end;

procedure TfrmCadImobilizado.pCarregaEmpresa;
begin

  pPesquisaCadEmp(qryCadEmp, qryCadEmp, dbeCodEmp.Text);

  With qryCadEmp Do
  Begin
    edtDesEmpresa.Text := FieldByName('EMP_NOMEMP').AsString;
  End;

end;

procedure TfrmCadImobilizado.pCarregaVidUtiTipImo;
var
  Lqry: TUniQuery;
begin
  if dbeTIPIMO.Text = FstrTipImoAnt then
    Exit;

  if fEmptyStr(dbeTIPIMO.Text) then
    Exit;

  Lqry := fCriaQuery();
  try
    Lqry.SQL.Text := 'SELECT TIP_VDUTFI FROM TIPIMO WHERE TIP_CODTIP = :CODTIP ';
    Lqry.ParamByName('CODTIP').AsString := dbeTIPIMO.Text;
    Lqry.Open;

    if Lqry.IsEmpty then
      Exit;

    if not chkTemDep.Checked then
    begin
      chkTemDep.Checked := True;
      chkTemDepClick(dbeTIPIMO);
    end;

    if Lqry.FieldByName('TIP_VDUTFI').IsNull then
      dbeVIDUTI.Field.Clear
    else
      dbeVIDUTI.Field.Value := Lqry.FieldByName('TIP_VDUTFI').Value;

    fValidaCampos(dbeVIDUTI, True);

    if dbeVIDUTI.Field.IsNull and chkTemDep.Checked then
    begin
      chkTemDep.Checked := False;
      chkTemDepClick(dbeTIPIMO);
    end;

  finally
    FreeAndNil(Lqry);
  end;
end;

procedure TfrmCadImobilizado.dbeCliVenExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeCliVen.Text) Then
    edtDesCli.Clear
  Else
  Begin
    edtDesCli.Text := fStrZero(edtDesCli.Text, 8);
    fValidaCampos(edtDesCli, True);
  End;
end;

procedure TfrmCadImobilizado.dbeCliVenKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, dbeCliVen, edtDesCli, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeCliVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadImobilizado.dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtDesEmpresa, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadImobilizado.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
var ArrSel: TConsultasArray;
    strErro:String;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If ((fEmptyStr(dbeDocAqu.Field.AsString)) Or (fEmptyStr(dbeEspAqu.Field.AsString)) Or
        (fEmptyStr(dbeSerAqu.Field.AsString)) Or (fEmptyStr(dbeForAqu.Field.AsString))) Then
    Begin
      pMensagemOk('É preciso informar um documento de entrada.');
      Exit;
    End;

    If fVerificaDocumentoValido(strErro, True) Then
    Begin
      If fPesqProdutoNota(Self, dbeDocAqu.Text, dbeSerAqu.Text, dbeEspAqu.Text, dbeForAqu.Text, dbeCodEmp.Text, dbeCodIte, True, qryConsul, ArrSel, Key) Then
        If fValidaCampos(dbeCodIte) Then
           SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadImobilizado.dbeDocVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If Not(CharInSet(Key, ['0'..'9', #8])) Then
    Key := #0;
end;

procedure TfrmCadImobilizado.dbeForAquExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeForAqu.Text) Then
    edtDesForNot.Clear
  Else
  Begin
    dbeForAqu.Text := fStrZero(dbeForAqu.Text, 8);
    fValidaCampos(dbeForAqu, True);
  End;
end;

procedure TfrmCadImobilizado.dbeForAquKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, dbeForAqu, edtDesForNot, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeForAqu, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadImobilizado.dbeTIPIMOEnter(Sender: TObject);
begin
  inherited;
  FstrTipImoAnt := dbeTIPIMO.Text;
end;

procedure TfrmCadImobilizado.dbeTIPIMOExit(Sender: TObject);
begin
  inherited;
  try
    pCarregaVidUtiTipImo;
  finally
    FstrTipImoAnt := '';
  end;
end;

procedure TfrmCadImobilizado.dbeTIPIMOKeyPress(Sender: TObject; var Key: Char);
  var ArrSel: TConsultasArray;
begin
  inherited;
  If fPesqTipoImobilizado(Self, dbeTipImo, edtDesTipImo, nil, Key, ArrSel) Then
    If fValidaCampos(dbeTipImo) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmCadImobilizado.fCalcResidualPorcentagem(fltValor: Double): Double;
begin
  If (fltValor > 0) And (Not(fEmptyStr(dbeValAqu.Text))) Then
    Result := (fltValor * 100)/ fStrToFloat(dbeValAqu.Text)
  Else
    Result := 0;
end;

function TfrmCadImobilizado.fCalcResidualValor(fltTaxa: Double): Double;
begin
  Result := (fStrToFloat(dbeValAqu.Text) * fltTaxa)/ 100
End;

function TfrmCadImobilizado.fCarregaTaxaAnualDoTipo: boolean;
begin
  Result := False;
  If TipoCalculo = tcFiscal Then
    Result := True;
  If blnInsert Then
    Result := TipoCalculo In [tcFiscal, tcContabil];
end;

procedure TfrmCadImobilizado.pCarregaCampos;
begin

  If Not fEmptyStr(dbeCodIte.Text) Then
    edtDesIte.Text := fRetNomProduto(dbeCodIte.Text)
  Else
    edtDesIte.Clear;

  If Not fEmptyStr(dbeForAqu.Text) Then
    edtDesForNot.Text := fRetNomFornecedor(dbeForAqu.Text)
  Else
    edtDesForNot.Clear;

  If Not fEmptyStr(dbeCliVen.Text) Then
    edtDesCli.Text := fRetNomCliente(dbeCliVen.Text)
  Else
    edtDesCli.Clear;

  If Not fEmptyStr(dbeTIPIMO.Text) Then
    edtDesTipImo.Text := fCampoTabela('TIP_DESCRI', 'TIPIMO', ['TIP_CODTIP'], [dbeTIPIMO.Text], False)
  Else
    edtDesTipImo.Clear;
end;

function TfrmCadImobilizado.fDocumentoInformado(blnEntrada: Boolean): Boolean;
begin
   If blnEntrada Then
      Result := Not((fEmptyStr(dbeDocAqu.Field.AsString)) Or (fEmptyStr(dbeEspAqu.Field.AsString)) Or
                   (fEmptyStr(dbeSerAqu.Field.AsString)) Or (fEmptyStr(dbeForAqu.Field.AsString)))
   Else
      Result := Not((fEmptyStr(dbeDocVen.Field.AsString)) Or (fEmptyStr(dbeEspVen.Field.AsString)) Or
                   (fEmptyStr(dbeSerVen.Field.AsString)) Or (fEmptyStr(dbeCliVen.Field.AsString)))

end;

{ TImobilizadoDepreciacao }

constructor TImobilizadoDepreciacao.Create(const ATipo: string);
begin
  FTipoDep := ATipo ;
end;

destructor TImobilizadoDepreciacao.Destroy;
begin
   SetLength(FDepreciacoes, 0);
  inherited;
end;

function TImobilizadoDepreciacao.fAjustaDataFinal(
  const AData: TDateTime): TDateTime;
begin
  result := EndOfTheMonth(AData) ;
  ReplaceTime(result, EncodeTime(23, 59, 59, 999)) ;
end;

function TImobilizadoDepreciacao.fAjustaDataInicial(
  const AData: TDateTime): TDateTime;
begin
  result := StartOfTheMonth(AData) ;
  ReplaceTime(result, EncodeTime(0, 0, 0, 0)) ;
end;

function TImobilizadoDepreciacao.fGetParcelaAtual(
  DataAquisicao: TDate): Integer;
var
  LDataIni, LDataFin: TDateTime ;
begin
  LDataIni := fAjustaDataInicial(DataAquisicao) ;
  LDataFin := fAjustaDataFinal(fNow) ;
  Result := MonthsBetween(LDataIni, LDataFin) ;
  if Result > fGetQtdTotalMeses then
     Result := fGetQtdTotalMeses;
end;

function TImobilizadoDepreciacao.fGetQtdTotalMeses: Integer;
begin
  Result := High(FDepreciacoes) + 1;
end;

function TImobilizadoDepreciacao.GetDepreciacoes(intIndex: integer): TDepreciacao;
begin
  If High(FDepreciacoes) = -1 Then
  Begin
    SetLength(FDepreciacoes, 1);
    Result := FDepreciacoes[0];
  End
  Else If IntIndex > (High(FDepreciacoes)) Then
    Result := FDepreciacoes[High(FDepreciacoes)]
  Else If IntIndex <= 0 Then
    Result := FDepreciacoes[0]
  Else
    Result := FDepreciacoes[intIndex-1]
end;

procedure TImobilizadoDepreciacao.pCalcularDepreciacao(TipoCalculo: TTipoCalculo; DataAquisicao: TDate; intVidaUtil: Integer; fltTaxaDepreciacao: Double; fltVlrItem, fltValorResidual: Double);
  var intQtdParcelas: Integer;
      vlrBaseCalculo: Double;
      UltimaDataUti: TDate;
      fltSomaParcelas, fltDifSomaParcelas, fltValorBem : double ;
begin
  self.pInicia ;
  If intVidaUtil <=0 Then
    Exit;
  If (TipoCalculo <> tcVidaUtil) And (fltTaxaDepreciacao < 0) Then
    Exit;
  If fltVlrItem <= 0 Then
    Exit;

  If TipoCalculo = tcVidaUtil Then
    vlrBaseCalculo := fltVlrItem - fltValorResidual
  Else
     vlrBaseCalculo := fltVlrItem;

  intQtdParcelas := intVidaUtil * 12;


  If TipoCalculo = tcVidaUtil Then
    FDepreciacaoAnual := vlrBaseCalculo/intVidaUtil
  Else
    FDepreciacaoAnual := (vlrBaseCalculo * fltTaxaDepreciacao) / 100;

  FDepreciacaoMensal  := FDepreciacaoAnual/12;

  setlength(FDepreciacoes, 0);

  setlength(FDepreciacoes, intQtdParcelas);

  UltimaDataUti := EndOfTheMonth(DataAquisicao);
  fltSomaParcelas := 0.00 ;
  fltValorBem := fFormataFloat(FDepreciacaoMensal*intQtdParcelas, 2) ;
  For intQtdParcelas := 1 To High(FDepreciacoes) + 1 Do
  Begin
    fltSomaParcelas := fltSomaParcelas + fFormataFloat(FDepreciacaoMensal,2) ;
    FDepreciacoes[intQtdParcelas -1].DataBase := UltimaDataUti;
    FDepreciacoes[intQtdParcelas -1].Parcela  := intQtdParcelas;
    if intQtdParcelas <> High(FDepreciacoes) + 1 then
    begin
      FDepreciacoes[intQtdParcelas -1].vlrDepreciacaoAcumulada := fltSomaParcelas ;
      FDepreciacoes[intQtdParcelas -1].vlrDepreciacao := fFormataFloat(FDepreciacaoMensal,2) ;
    end
    else
    begin
      ///diferença caso tenha
      fltDifSomaParcelas := fFormataFloat(fltValorBem - fltSomaParcelas, 2) ;
      FDepreciacoes[intQtdParcelas -1].vlrDepreciacaoAcumulada := fltValorBem ;
      FDepreciacoes[intQtdParcelas -1].vlrDepreciacao := fFormataFloat(FDepreciacaoMensal,2) + fltDifSomaParcelas  ;
    end;
    UltimaDataUti := EndOfTheMonth(IncMonth(UltimaDataUti));
  End;

  FDepreciacaoRestante := vlrBaseCalculo - self.Depreciacoes[self.fGetParcelaAtual(DataAquisicao)].vlrDepreciacaoAcumulada ;

end;

procedure TImobilizadoDepreciacao.pGravaDepreciacaoImobilizados(
  strCodImobilizado: string);
  var i: Integer;
  strAutInc: String;
begin
  If fEmptystr(strCodImobilizado) Then
    Exit;
  qryConsulta.SQL.Clear;
  qryConsulta.SQL.Add('DELETE FROM IMOAMO WHERE AMO_CODIMO = "' + strCodImobilizado + '" AND AMO_DEPTIP = "' + FTipoDep + '" ');
  qryConsulta.ExecSQL;
  qryConsulta.SQL.Clear;

  strAutInc := fRetAutoIncrem('IMOAMO', VS_StrCodEmp, High(FDepreciacoes));
  For i := 0 To High(FDepreciacoes) Do
  Begin
    qryConsulta.SQL.Add('INSERT INTO IMOAMO (AUTOINCREM, AMO_CODIMO, AMO_DTABAS, AMO_PARCEL, AMO_TOTPAR, AMO_VLRDEP, AMO_DEPTIP)VALUES(');
    qryConsulta.SQL.Add(QuotedStr(strAutInc) + ', ');
    qryConsulta.SQL.Add(QuotedStr(strCodImobilizado) + ', ');
    qryConsulta.SQL.Add(QuotedStr(FormatDateTime('YYYY-MM-DD', FDepreciacoes[i].DataBase)) + ', ');
    qryConsulta.SQL.Add(QuotedStr(IntToStr(FDepreciacoes[i].Parcela)) + ', ');
    qryConsulta.SQL.Add(QuotedStr(IntToStr(fGetQtdTotalMeses)) + ', ');
    qryConsulta.SQL.Add(QuotedStr(StringReplace(Trim(FloatToStr(FDepreciacoes[i].vlrDepreciacao)), ',', '.', []))  + ', ');
    qryConsulta.SQL.Add(QuotedStr(FTipoDep) + '); ');
    strAutInc := fNextAutoIncrem(strAutInc);
  End;
  qryConsulta.ExecSQL;

end;

procedure TImobilizadoDepreciacao.pInicia;
begin
  SetLength(FDepreciacoes, 0);
  FDepreciacaoMensal := 0;
  FDepreciacaoAnual  := 0;
  FDepreciacaoRestante := 0 ;
end;

{ TPatrimoniosLocalizacao }

constructor TPatrimoniosLocalizacao.create(AKeyImobilizado: String; DataSource: TDataSource);
begin
  FQuerySQL := fCriaQuery(nil);
  FKeyImobilizado := AKeyImobilizado;
  If (FKeyImobilizado = '') Then
    FPatrimoniosLocoalizacaoAcao := tplaInclusao
  Else
    FPatrimoniosLocoalizacaoAcao := tplaEdicao;
  pCarregar(FKeyImobilizado);
  DataSource.DataSet := cdsPatrimonios;
  intSequencialEdicao := -1;
end;

destructor TPatrimoniosLocalizacao.Destroy;
begin
  If Assigned(cdsPatrimonios) Then
    FreeAndNil(cdsPatrimonios);
  FreeAndNil(FQuerySQL);

end;

function TPatrimoniosLocalizacao.fTemNumPat: Boolean;
begin
    cdsPatrimonios.Filtered := False;
    cdsPatrimonios.Filter :=  'PAT_NUMPAT <> ' + fQuotedStr('') + ' AND ACAO =1';
    cdsPatrimonios.Filtered := True;

    Result := cdsPatrimonios.RecordCount > 0;

    cdsPatrimonios.Filtered := False;
    cdsPatrimonios.Filter :=  'ACAO =1';
    cdsPatrimonios.Filtered := True;

end;

procedure TPatrimoniosLocalizacao.pCarregar(AKeyImobilizado: String);
  var
    strSQL: String;
begin
  If Assigned(cdsPatrimonios) Then
    FreeAndNil(cdsPatrimonios);

  strSQL := '';
  strSQL := strSQL + 'SELECT PAT_SEQUEN, ';
  strSQL := strSQL + '       PAT_CADIMO, ';
  strSQL := strSQL + '       PAT_NUMPAT, ';
  strSQL := strSQL + '       PAT_LOCFIS,  ';
  strSQL := strSQL + '       1 AS ACAO  ';  //1 Grava
                                            //2 Delete
  strSQL := strSQL + '  FROM IMOPAT ';
  If AKeyImobilizado <> '' Then
    strSQL := strSQL + ' WHERE PAT_CADIMO = "'+AKeyImobilizado+'"'
  Else
    strSQL := strSQL + ' WHERE False';

  cdsPatrimonios := TZClient.Create(nil, strSQL);
  cdsPatrimonios.fAbreClient(True, '[TPatrimoniosLocalizacao.pCarregar]');

  cdsPatrimonios.Filtered := False;
  cdsPatrimonios.Filter :=  'ACAO =1';
  cdsPatrimonios.Filtered := True;

  cdsPatrimonios.IndexFieldNames := 'PAT_SEQUEN';
end;

procedure TPatrimoniosLocalizacao.pExcluir(intSequencial: integer);
begin
  cdsPatrimonios.Locate('PAT_SEQUEN', intSequencial, []);
  cdsPatrimonios.Edit;
  cdsPatrimonios.FieldByName('ACAO').AsInteger := 2;
  cdsPatrimonios.Post;
end;

procedure TPatrimoniosLocalizacao.pGravar(AKeyImobilizado: String);
begin
  If AKeyImobilizado = '' Then
    Exit;
  cdsPatrimonios.IndexFieldNames :=  'PAT_SEQUEN';
  If FPatrimoniosLocoalizacaoAcao = tplaEdicao Then
  Begin
    cdsPatrimonios.Filtered := False;
    //Se for o sequencial 1 quer dizer que pode estar na tabela de imobilizado então deve limpar nela
    //para manter compatibilidade entre versões.
    cdsPatrimonios.Filter :=  'PAT_SEQUEN = 1';
    cdsPatrimonios.Filtered := True;

    cdsPatrimonios.First;

    While not cdsPatrimonios.Eof Do
    Begin
      FQuerySQL.SQL.Text := 'UPDATE CADIMO SET IMO_NUMPAT = :NUMPAT, IMO_LOCFIS = :LOCFIS WHERE AUTOINCREM = "'+AKeyImobilizado+'"';
      FQuerySQL.ParamByName('NUMPAT').AsString := cdsPatrimonios.FieldByname('PAT_NUMPAT').AsString;
      FQuerySQL.ParamByName('LOCFIS').AsString := cdsPatrimonios.FieldByname('PAT_LOCFIS').AsString;
      FQuerySQL.ExecSQL;
      cdsPatrimonios.Next;
    End;
  End;
  cdsPatrimonios.Filtered := False;
  cdsPatrimonios.Filter :=  'ACAO = 1';
  cdsPatrimonios.Filtered := True;


  FQuerySQL.SQL.Text := 'DELETE FROM IMOPAT WHERE PAT_CADIMO = "'+AKeyImobilizado+'"';
  FQuerySQL.ExecSQL;

  cdsPatrimonios.First;

  While not cdsPatrimonios.Eof Do
  Begin
    FQuerySQL.SQL.Clear;
    FQuerySQL.SQL.Add( 'INSERT INTO IMOPAT (PAT_SEQUEN, ');
    FQuerySQL.SQL.Add(  '       PAT_CADIMO, ');
    FQuerySQL.SQL.Add(  '       PAT_NUMPAT, ');
    FQuerySQL.SQL.Add(  '       PAT_LOCFIS  ');
    FQuerySQL.SQL.Add(  ')VALUES (');
    FQuerySQL.SQL.Add(  ':PAT_SEQUEN,');
    FQuerySQL.SQL.Add(  ':PAT_CADIMO,');
    FQuerySQL.SQL.Add(  ':PAT_NUMPAT,');
    FQuerySQL.SQL.Add(  ':PAT_LOCFIS)');

    FQuerySQL.ParamByName('PAT_SEQUEN').AsInteger:= cdsPatrimonios.RecNo;
    FQuerySQL.ParamByName('PAT_CADIMO').AsString := AKeyImobilizado;
    FQuerySQL.ParamByName('PAT_NUMPAT').AsString := cdsPatrimonios.FieldByname('PAT_NUMPAT').AsString;
    FQuerySQL.ParamByName('PAT_LOCFIS').AsString := cdsPatrimonios.FieldByname('PAT_LOCFIS').AsString;
    FQuerySQL.ExecSQL;
    cdsPatrimonios.Next;
  End;
end;

procedure TPatrimoniosLocalizacao.pIncluir(strLocFis, strNumpat: String; intSequencial: integer);
var intSeq: Integer;
begin
  If intSequencial > -1 Then
  Begin
    cdsPatrimonios.Locate('PAT_SEQUEN', intSequencial, []);
    cdsPatrimonios.Edit;
  End
  Else
  Begin
    intSeq := cdsPatrimonios.RecordCount + 1;
    cdsPatrimonios.Append;
    cdsPatrimonios.FieldByName('PAT_SEQUEN').AsInteger := intSeq;
  End;
  cdsPatrimonios.FieldByName('PAT_NUMPAT').AsString := strNumpat;
  cdsPatrimonios.FieldByName('PAT_LOCFIS').AsString := strLocFis;
  cdsPatrimonios.FieldByName('ACAO').AsInteger := 1;
  cdsPatrimonios.Post;

end;

end.
