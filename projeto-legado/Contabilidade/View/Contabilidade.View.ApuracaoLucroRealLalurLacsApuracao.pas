unit Contabilidade.View.ApuracaoLucroRealLalurLacsApuracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, Vcl.ComCtrls, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  dxBarBuiltInMenu, cxPC, cxCurrencyEdit, CurrencyEditFocus, cxButtons,
  cxGroupBox, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Contabilidade.Interfaces,
  Datasnap.DBClient, UniClientDataSet, MemDS, DBAccess, Uni,
  Contabilidade.Classes.ApuracaoLucroRealLalurLacs, cxCalc, EditFocus;

type
  TfrmApuracaoLucroRealLalurLacsApuracao = class(TfrmPaiConfirmaContabilidade)
    pnlPeriodo: TPanel;
    cxLabel1: TcxLabel;
    edtDataInicio: TcxDateEdit;
    edtDataFin: TcxDateEdit;
    pgcApuracao: TcxPageControl;
    tsLacs: TcxTabSheet;
    tsLalur: TcxTabSheet;
    cxLabel2: TcxLabel;
    edtLucroAntesCSSL: TCurrencyEditFocus;
    gbLacsAdicoesExclusoes: TcxGroupBox;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    edtAdicoesLacs: TCurrencyEditFocus;
    edtExclusoesLacs: TCurrencyEditFocus;
    btnAjustesLacs: TcxButton;
    cxLabel5: TcxLabel;
    edtBCAntesCompesacaoLacs: TCurrencyEditFocus;
    cxGroupBox1: TcxGroupBox;
    cxLabel6: TcxLabel;
    edtCompesacaoLacs: TCurrencyEditFocus;
    btnPrejuizosLacs: TcxButton;
    cxLabel7: TcxLabel;
    edtBaseCalculoCSLL: TCurrencyEditFocus;
    gbAdicoesLacs: TcxGroupBox;
    gbExclusoesLacs: TcxGroupBox;
    gbCompensacoesLacs: TcxGroupBox;
    GridAdicoesLacsTableView: TcxGridDBTableViewCitel;
    GridAdicoesLacsLevel1: TcxGridLevel;
    GridAdicoesLacs: TcxGridCitel;
    GridExclusoesLacsTableView: TcxGridDBTableViewCitel;
    GridExclusoesLacsLevel1: TcxGridLevel;
    GridExclusoesLacs: TcxGridCitel;
    GridCompensacoesLacsTableView: TcxGridDBTableViewCitel;
    GridCompensacoesLacsLevel1: TcxGridLevel;
    GridCompensacoesLacs: TcxGridCitel;
    cxLabel8: TcxLabel;
    edtLucroAntesIRPJ: TCurrencyEditFocus;
    gbLalurAdicoesExclusoes: TcxGroupBox;
    cxLabel9: TcxLabel;
    cxLabel10: TcxLabel;
    edtAdicoesLalur: TCurrencyEditFocus;
    edtExclusoesLalur: TCurrencyEditFocus;
    btnAjustesLalur: TcxButton;
    cxLabel11: TcxLabel;
    edtBCAntesCompesacaoLalur: TCurrencyEditFocus;
    cxGroupBox2: TcxGroupBox;
    cxLabel12: TcxLabel;
    edtCompesacaoLalur: TCurrencyEditFocus;
    btnPrejuizosLalur: TcxButton;
    cxLabel13: TcxLabel;
    edtBaseCalculoIRPJ: TCurrencyEditFocus;
    gbAdicoesLalur: TcxGroupBox;
    GridAdicoesLalur: TcxGridCitel;
    GridAdicoesLalurTableView: TcxGridDBTableViewCitel;
    GridAdicoesLalurLevel1: TcxGridLevel;
    gbExclusoesLalur: TcxGroupBox;
    GridExclusoesLalur: TcxGridCitel;
    GridExclusoesLalurTableView: TcxGridDBTableViewCitel;
    GridExclusoesLalurLevel1: TcxGridLevel;
    gbCompensacoesLalur: TcxGroupBox;
    GridCompensacoesLalur: TcxGridCitel;
    GridCompensacoesLalurTableView: TcxGridDBTableViewCitel;
    GridCompensacoesLalurLevel1: TcxGridLevel;
    dsAdicoesLacs: TDataSource;
    dsExclusoesLacs: TDataSource;
    dsCompensacoesLacs: TDataSource;
    dsAdicoesLalur: TDataSource;
    dsExclusoesLalur: TDataSource;
    dsCompensacoesLalur: TDataSource;
    GridAdicoesLacsTableViewNAT_CODIGO: TcxGridDBColumn;
    GridAdicoesLacsTableViewNAT_DESCRI: TcxGridDBColumn;
    GridAdicoesLacsTableViewNAT_VALRES: TcxGridDBColumn;
    GridExclusoesLacsTableViewNAT_CODIGO: TcxGridDBColumn;
    GridExclusoesLacsTableViewNAT_DESCRI: TcxGridDBColumn;
    GridExclusoesLacsTableViewNAT_VALRES: TcxGridDBColumn;
    GridCompensacoesLacsTableViewNAT_CODIGO: TcxGridDBColumn;
    GridCompensacoesLacsTableViewNAT_DESCRI: TcxGridDBColumn;
    GridCompensacoesLacsTableViewNAT_VALRES: TcxGridDBColumn;
    GridAdicoesLalurTableViewNAT_CODIGO: TcxGridDBColumn;
    GridAdicoesLalurTableViewNAT_DESCRI: TcxGridDBColumn;
    GridAdicoesLalurTableViewNAT_VALRES: TcxGridDBColumn;
    GridExclusoesLalurTableViewNAT_CODIGO: TcxGridDBColumn;
    GridExclusoesLalurTableViewNAT_DESCRI: TcxGridDBColumn;
    GridExclusoesLalurTableViewNAT_VALRES: TcxGridDBColumn;
    GridCompensacoesLalurTableViewNAT_CODIGO: TcxGridDBColumn;
    GridCompensacoesLalurTableViewNAT_DESCRI: TcxGridDBColumn;
    GridCompensacoesLalurTableViewNAT_VALRES: TcxGridDBColumn;
    cxLabel14: TcxLabel;
    edtEmpSel: TEditFocus;
    edtNomEmpSel: TEditFocus;
    GridAdicoesLacsTableViewCREDEB: TcxGridDBColumn;
    GridExclusoesLacsTableViewCREDEB: TcxGridDBColumn;
    GridAdicoesLalurTableViewCREDEB: TcxGridDBColumn;
    GridExclusoesLalurTableViewCREDEB: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnAjustesLalurClick(Sender: TObject);
    procedure btnAjustesLacsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPrejuizosLacsClick(Sender: TObject);
    procedure btnPrejuizosLalurClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FRegValoresLacs: TValoresApuracao ;
    FRegValoresLalur: TValoresApuracao ;
    FStrCodPre: string ;
    FFltLucroAntesCssl: double ;
    FFltLucroAntesIrpj: double ;
    FCdsApuracaoValoresLacs: TUniClientDataSet ;
    FCdsApuracaoValoresLalur: TUniClientDataSet ;
    FCdsResumoAdicoesLacs: TUniClientDataSet ;
    FCdsResumoExclusoesLacs: TUniClientDataSet ;
    FCdsResumoCompensacoesLacs: TUniClientDataSet ;
    FCdsResumoAdicoesLalur: TUniClientDataSet ;
    FCdsResumoExclusoesLalur: TUniClientDataSet ;
    FCdsResumoCompensacoesLalur: TUniClientDataSet ;
    FStrCodigoValoresLacs: string ;
    FStrCodigoValoresLalur: string ;
    FftForma: TFormaTributacao ;
    FecEncerramento: TEncerramentoContabil ;
    FstrContaControladaBaseNegativaLacs: string ;
    FstrContaControladaBaseNegativaLalur: string ;
    FstrCodEmp: string ;
    procedure pAtualizaCamposApuracao(const AllTipo: TLacsLalur; const ARegValores: TValoresApuracao) ;
    function fHabilitaPrejuizosFiscais(const AfltValor: Double; const AllTipo: TLacsLalur): boolean;
    function fInformouContaControladaValida(const AllTipo: TLacsLalur; const AfltBaseCalculo: double): boolean;
    procedure pProcessaAjustes ;
  public
    { Public declarations }
    property CodPre: string read FStrCodPre write FStrCodPre ;
    property LucroAntesCssl: double read FFltLucroAntesCssl write FFltLucroAntesCssl;
    property LucroAntesIrpj: double read FFltLucroAntesIrpj write FFltLucroAntesIrpj;
    property ValoresLacs: TValoresApuracao read FRegValoresLacs ;
    property ValoresLalur: TValoresApuracao read FRegValoresLalur ;
    property CodigoValoresLacs: string read FStrCodigoValoresLacs ;
    property CodigoValoresLalur: string read FStrCodigoValoresLalur ;
    property FormaTributacao: TFormaTributacao read FftForma write FftForma ;
    property EncerramentoContabil: TEncerramentoContabil read FecEncerramento write FecEncerramento ;
    property ContaControladaBaseNegativaLacs: string read FstrContaControladaBaseNegativaLacs ;
    property ContaControladaBaseNegativaLalur: string read FstrContaControladaBaseNegativaLalur ;
    property CodEmp: string read FstrCodEmp write FstrCodEmp ;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, DateUtils;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.btnAjustesLacsClick(
  Sender: TObject);
begin
  inherited;
  fConfiguraAjustes(FCdsApuracaoValoresLalur.FieldByName('AUTOINCREM').AsString, FCdsApuracaoValoresLacs.FieldByName('AUTOINCREM').AsString, llLacs, edtDataInicio.Date, edtDataFin.Date, FecEncerramento, FstrCodEmp) ;
  pProcessaAjustes ;
end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.btnAjustesLalurClick(
  Sender: TObject);
begin
  inherited;
  fConfiguraAjustes(FCdsApuracaoValoresLalur.FieldByName('AUTOINCREM').AsString, FCdsApuracaoValoresLacs.FieldByName('AUTOINCREM').AsString, llLalur, edtDataInicio.Date, edtDataFin.Date, FecEncerramento, FstrCodEmp) ;
  pProcessaAjustes ;
end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.btnConfirmaClick(
  Sender: TObject);
begin
  if not fInformouContaControladaValida(llLacs, edtBaseCalculoCSLL.Value) then
  begin
    exit ;
  end;

  if not fInformouContaControladaValida(llLalur, edtBaseCalculoIRPJ.Value) then
  begin
    exit ;
  end;

  inherited;

end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.btnPrejuizosLacsClick(
  Sender: TObject);
begin
  inherited;
  if fConfiguraCompensacao(FCdsApuracaoValoresLacs.FieldByName('AUTOINCREM').AsString, llLacs, edtBCAntesCompesacaoLacs.Value, edtDataInicio.Date, edtDataFin.Date, FstrCodEmp) then
  begin
    pProcessaCalculosApuracao(FStrCodPre, llLacs, FRegValoresLacs, FCdsResumoAdicoesLacs, FCdsResumoExclusoesLacs, FCdsResumoCompensacoesLacs, FecEncerramento, FstrCodEmp) ;
    pAtualizaCamposApuracao(llLacs, FRegValoresLacs) ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.btnPrejuizosLalurClick(
  Sender: TObject);
begin
  inherited;
  if fConfiguraCompensacao(FCdsApuracaoValoresLalur.FieldByName('AUTOINCREM').AsString, llLalur, edtBCAntesCompesacaoLalur.Value, edtDataInicio.Date, edtDataFin.Date, FstrCodEmp) then
  begin
    pProcessaCalculosApuracao(FStrCodPre, llLalur, FRegValoresLalur, FCdsResumoAdicoesLalur, FCdsResumoExclusoesLalur, FCdsResumoCompensacoesLalur, FecEncerramento, FstrCodEmp) ;
    pAtualizaCamposApuracao(llLalur, FRegValoresLalur) ;
  end;
end;

function TfrmApuracaoLucroRealLalurLacsApuracao.fHabilitaPrejuizosFiscais(
  const AfltValor: Double; const AllTipo: TLacsLalur): boolean;
var
  LfltOperacionalOuBaseNegativa, LfltNaoOperacional: double ;
begin
  result := False ;
  if AfltValor <= 0.00 then
  begin
    exit ;
  end;

  ///verifica se há saldo anterior, se for zerado desabilita.
  pRetornaSaldoCompesacao(edtDataFin.Date, AllTipo, LfltOperacionalOuBaseNegativa, LfltNaoOperacional, FstrCodEmp) ;

  if LfltOperacionalOuBaseNegativa <= 0.00 then
  begin
    exit ;
  end;

  result := True ;
end;

function TfrmApuracaoLucroRealLalurLacsApuracao.fInformouContaControladaValida(
  const AllTipo: TLacsLalur; const AfltBaseCalculo: double): boolean;
var
  LBlnPodeLancar: boolean ;
  LstrContaControlada: string ;
begin
  result := False ;
  /// quando é trimestral lança a cada final de periodo, se anual lança somente em dezembro.
  LBlnPodeLancar := (AfltBaseCalculo < 0.00) and iif(FecEncerramento = ecTrimestral, True, MonthOf(edtDataFin.Date)=12) ;

  LstrContaControlada := fRetornaContaControladaBCNegativa(LBlnPodeLancar, AllTipo) ; ///função para retornar a conta controlada informada pelo usuário
  if (LBlnPodeLancar) and (fEmptyStr(LstrContaControlada)) then
  begin
    fMensagem('ATENÇÃO!', 'Nenhuma conta controlada informada!', ['&Ok']);
    exit ;
  end;

  if AllTipo = llLacs then
  begin
    FstrContaControladaBaseNegativaLacs := LstrContaControlada ;
  end
  else if AllTipo = llLalur then
  begin
    FstrContaControladaBaseNegativaLalur := LstrContaControlada ;
  end;

  result := True ;
end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.pAtualizaCamposApuracao(
  const AllTipo: TLacsLalur; const ARegValores: TValoresApuracao);
var
  LblnHabilita: boolean ;
begin
  if AllTipo = llLacs then
  begin
    edtLucroAntesCSSL.Value := ARegValores.fltLucroAntes ;
    edtAdicoesLacs.Value := ARegValores.fltAdicoes ;
    edtExclusoesLacs.Value := ARegValores.fltExclusoes ;
    edtBCAntesCompesacaoLacs.Value := ARegValores.fltBcAntesCompensacao ;
    edtCompesacaoLacs.Value := ARegValores.fltCompensacaoBCNegativa ;
    edtBaseCalculoCSLL.Value := ARegValores.fltBaseCalculo ;

    LblnHabilita := fHabilitaPrejuizosFiscais(edtBCAntesCompesacaoLacs.Value, AllTipo) ;

    btnPrejuizosLacs.Enabled := LblnHabilita ;
  end
  else if AllTipo = llLalur then
  begin
    edtLucroAntesIRPJ.Value := ARegValores.fltLucroAntes ;
    edtAdicoesLalur.Value := ARegValores.fltAdicoes ;
    edtExclusoesLalur.Value := ARegValores.fltExclusoes ;
    edtBCAntesCompesacaoLalur.Value := ARegValores.fltBcAntesCompensacao ;
    edtCompesacaoLalur.Value := ARegValores.fltCompensacaoBCNegativa ;
    edtBaseCalculoIRPJ.Value := ARegValores.fltBaseCalculo ;

    LblnHabilita := fHabilitaPrejuizosFiscais(edtBCAntesCompesacaoLalur.Value, AllTipo) ;

    btnPrejuizosLalur.Enabled := LblnHabilita ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.pProcessaAjustes;
begin
  pProcessaCalculosApuracao(FStrCodPre, llLacs, FRegValoresLacs, FCdsResumoAdicoesLacs, FCdsResumoExclusoesLacs, FCdsResumoCompensacoesLacs, FecEncerramento, FstrCodEmp) ;
  pAtualizaCamposApuracao(llLacs, FRegValoresLacs) ;

  pProcessaCalculosApuracao(FStrCodPre, llLalur, FRegValoresLalur, FCdsResumoAdicoesLalur, FCdsResumoExclusoesLalur, FCdsResumoCompensacoesLalur, FecEncerramento, FstrCodEmp) ;
  pAtualizaCamposApuracao(llLalur, FRegValoresLalur) ;
end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.FormCreate(Sender: TObject);
begin
  inherited;
  FCdsApuracaoValoresLacs  := Nil ;
  FCdsApuracaoValoresLalur := Nil ;
  pCriaEstruturaResumoApuracao(FCdsResumoAdicoesLacs, FCdsResumoExclusoesLacs, FCdsResumoCompensacoesLacs) ;
  pCriaEstruturaResumoApuracao(FCdsResumoAdicoesLalur, FCdsResumoExclusoesLalur, FCdsResumoCompensacoesLalur) ;
  ///associa os cds nos datasources
  dsAdicoesLacs.Enabled := False ;
  dsAdicoesLacs.DataSet := FCdsResumoAdicoesLacs ;
  dsAdicoesLacs.Enabled := True ;
  dsExclusoesLacs.Enabled := False ;
  dsExclusoesLacs.DataSet := FCdsResumoExclusoesLacs ;
  dsExclusoesLacs.Enabled := True ;
  dsCompensacoesLacs.Enabled := False ;
  dsCompensacoesLacs.DataSet := FCdsResumoCompensacoesLacs ;
  dsCompensacoesLacs.Enabled := True ;

  dsAdicoesLalur.Enabled := False ;
  dsAdicoesLalur.DataSet := FCdsResumoAdicoesLalur ;
  dsAdicoesLalur.Enabled := True ;
  dsExclusoesLalur.Enabled := False ;
  dsExclusoesLalur.DataSet := FCdsResumoExclusoesLalur ;
  dsExclusoesLalur.Enabled := True ;
  dsCompensacoesLalur.Enabled := False ;
  dsCompensacoesLalur.DataSet := FCdsResumoCompensacoesLalur ;
  dsCompensacoesLalur.Enabled := True ;

  FstrContaControladaBaseNegativaLacs := '' ;
  FstrContaControladaBaseNegativaLalur := '' ;

  pgcApuracao.ActivePageIndex := 0 ;
end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FCdsApuracaoValoresLacs) then
  begin
    FreeAndNil(FCdsApuracaoValoresLacs) ;
  end;

  if Assigned(FCdsApuracaoValoresLalur) then
  begin
    FreeAndNil(FCdsApuracaoValoresLalur) ;
  end;
end;

procedure TfrmApuracaoLucroRealLalurLacsApuracao.FormShow(Sender: TObject);
begin
  inherited;
  edtEmpSel.Text := FstrCodEmp ;
  edtNomEmpSel.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [FstrCodEmp], False) ;
  FRegValoresLacs.fltLucroAntes := FFltLucroAntesCssl ;
  FRegValoresLalur.fltLucroAntes := FFltLucroAntesCssl - FFltLucroAntesIrpj ;

  FStrCodigoValoresLacs := fCarregaApuracao(FStrCodPre, llLacs, FCdsApuracaoValoresLacs) ;
  FStrCodigoValoresLalur := fCarregaApuracao(FStrCodPre, llLalur, FCdsApuracaoValoresLalur) ;

  pProcessaCalculosApuracao(FStrCodPre, llLacs, FRegValoresLacs, FCdsResumoAdicoesLacs, FCdsResumoExclusoesLacs, FCdsResumoCompensacoesLacs, FecEncerramento, FstrCodEmp) ;
  pProcessaCalculosApuracao(FStrCodPre, llLalur, FRegValoresLalur, FCdsResumoAdicoesLalur, FCdsResumoExclusoesLalur, FCdsResumoCompensacoesLalur, FecEncerramento, FstrCodEmp) ;

  pAtualizaCamposApuracao(llLacs, FRegValoresLacs) ;
  pAtualizaCamposApuracao(llLalur, FRegValoresLalur) ;

end;

end.
