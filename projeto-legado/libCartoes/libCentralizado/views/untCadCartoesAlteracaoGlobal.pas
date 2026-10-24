unit untCadCartoesAlteracaoGlobal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, frxClass, Vcl.Graphics,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  Uni, UniClientDataSet, untPaiConfirma, Vcl.ComCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, Datasnap.DBClient, cxProgressBar, untTypesSistema;

type
  TfrmCadCartoesAlteracaoGlobal = class(TfrmPaiConfirma)
    PgcDados: TPageControl;
    TsBaixaOtimizadaPorEmpresa: TTabSheet;
    GridCartoes: TcxGrid;
    TableViewCartoes: TcxGridDBTableView;
    GridCartoesLevel: TcxGridLevel;
    TableViewCartoesCODCAR: TcxGridDBColumn;
    TableViewCartoesDESCAR: TcxGridDBColumn;
    TableViewCartoesEMPRESA: TcxGridDBColumn;
    shpMultSel: TShape;
    dtsCartoes: TDataSource;
    gbPorEmpresaCredito: TGroupBox;
    edtPorEmpresaPORCRE: TEditFocus;
    edtPorEmpresaCTACRE: TEditFocus;
    edtPorEmpresaEVECRE: TEditFocus;
    edtPorEmpresaPORTAX: TEditFocus;
    edtPorEmpresaFORTAX: TEditFocus;
    edtPorEmpresaCTATAX: TEditFocus;
    edtPorEmpresaEVETAX: TEditFocus;
    edtPorEmpresaPORCRENome: TEditFocus;
    edtPorEmpresaCTACRENome: TEditFocus;
    edtPorEmpresaEVECRENome: TEditFocus;
    edtPorEmpresaPORTAXNome: TEditFocus;
    edtPorEmpresaFORTAXNome: TEditFocus;
    edtPorEmpresaCTATAXNome: TEditFocus;
    edtPorEmpresaEVETAXNome: TEditFocus;
    lblPorEmpresaPORBAI: TLabel;
    lblPorEmpresaCTABAI: TLabel;
    lblPorEmpresaEVECRE: TLabel;
    lblPorEmpresaPORTAX: TLabel;
    lblPorEmpresaFORTAX: TLabel;
    lblPorEmpresaCTATAX: TLabel;
    lblPorEmpresaEVETAX: TLabel;
    gbPorEmpresaDebito: TGroupBox;
    edtPorEmpresaEVEDEB: TEditFocus;
    edtPorEmpresaCTADEB: TEditFocus;
    edtPorEmpresaPORDEB: TEditFocus;
    edtPorEmpresaEVEDEBNome: TEditFocus;
    edtPorEmpresaCTADEBNome: TEditFocus;
    edtPorEmpresaPORDEBNome: TEditFocus;
    lblPorEmpresaEVEDEB: TLabel;
    lblPorEmpresaCTABAD: TLabel;
    lblPorEmpresaPORBAD: TLabel;
    gbPorEmpresaCancelamentos: TGroupBox;
    edtPorEmpresaCTAAJUNome: TEditFocus;
    lblPorEmpresaCTAAJU: TLabel;
    gbPorEmpresaAntecipacoes: TGroupBox;
    lblPorEmpresaCTAANT: TLabel;
    edtPorEmpresaCTAANT: TEditFocus;
    edtPorEmpresaCTAANTNome: TEditFocus;
    gbPorEmpresaFretes: TGroupBox;
    lblPorEmpresaCTAFRE: TLabel;
    edtPorEmpresaCTAFRE: TEditFocus;
    edtPorEmpresaCTAFRENome: TEditFocus;
    gbPorEmpresaCupons: TGroupBox;
    lblPorEmpresaCTACUP: TLabel;
    edtPorEmpresaCTACUP: TEditFocus;
    edtPorEmpresaCTACUPNome: TEditFocus;
    edtPorEmpresaCTAAJU: TEditFocus;
    tsBaixaOtimizada: TTabSheet;
    gbCredito: TGroupBox;
    lblPORBAI: TLabel;
    lblCTABAI: TLabel;
    lblEVECRE: TLabel;
    lblPORTAX: TLabel;
    lblFORTAX: TLabel;
    lblCTATAX: TLabel;
    lblEVETAX: TLabel;
    edtPORBAI: TEditFocus;
    edtCTABAI: TEditFocus;
    edtEVECRE: TEditFocus;
    edtPORTAX: TEditFocus;
    edtFORTAX: TEditFocus;
    edtCTATAX: TEditFocus;
    edtEVETAX: TEditFocus;
    edtPORBAINome: TEditFocus;
    edtCTABAINome: TEditFocus;
    edtEVECRENome: TEditFocus;
    edtPORTAXNome: TEditFocus;
    edtFORTAXNome: TEditFocus;
    edtCTATAXNome: TEditFocus;
    edtEVETAXNome: TEditFocus;
    gbDebito: TGroupBox;
    lblEVEDEB: TLabel;
    lblCTABAD: TLabel;
    lblPORBAD: TLabel;
    edtEVEDEB: TEditFocus;
    edtCTABAD: TEditFocus;
    edtPORBAD: TEditFocus;
    edtEVEDEBNome: TEditFocus;
    edtCTABADNome: TEditFocus;
    edtPORBADNome: TEditFocus;
    gbCancelamentos: TGroupBox;
    lblCTAAJU: TLabel;
    edtCTAAJU: TEditFocus;
    edtCTAAJUNome: TEditFocus;
    gbAntecipacoes: TGroupBox;
    lblCTAANT: TLabel;
    edtCTAANT: TEditFocus;
    edtCTAANTNome: TEditFocus;
    gbFretes: TGroupBox;
    lblCTAFRE: TLabel;
    edtCTAFRE: TEditFocus;
    edtCTAFRENome: TEditFocus;
    gbCupons: TGroupBox;
    lblCTACUP: TLabel;
    edtCTACUP: TEditFocus;
    edtCTACUPNome: TEditFocus;
    grpExportacaoEquals: TGroupBox;
    lblEQUADQ: TLabel;
    lblEQUCAP: TLabel;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    TableViewCartoesMARDES: TcxGridDBColumn;
    cmbEQUADQ: TDBLookupComboBox;
    cmbEQUCAP: TDBLookupComboBox;
    styleGridCartoes: TcxStyleRepository;
    styleZebraOdd: TcxStyle;
    pnlPorEmpresaCODEMP: TPanel;
    lblPorEmpresaCODEMP: TLabel;
    edtPorEmpresaCODEMPNome: TEditFocus;
    edtPorEmpresaCODEMP: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPORBAIKeyPress(Sender: TObject; var Key: Char);
    procedure edtPORTAXKeyPress(Sender: TObject; var Key: Char);
    procedure edtPORBADKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTABAIKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTATAXKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTABADKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTAAJUKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTAANTKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTAFREKeyPress(Sender: TObject; var Key: Char);
    procedure edtCTACUPKeyPress(Sender: TObject; var Key: Char);
    procedure edtEVECREKeyPress(Sender: TObject; var Key: Char);
    procedure edtEVETAXKeyPress(Sender: TObject; var Key: Char);
    procedure edtEVEDEBKeyPress(Sender: TObject; var Key: Char);
    procedure edtFORTAXKeyPress(Sender: TObject; var Key: Char);
    procedure TableViewCartoesCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure TableViewCartoesDblClick(Sender: TObject);
    procedure TableViewCartoesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure edtPorEmpresaPORCREExit(Sender: TObject);
    procedure edtPorEmpresaPORTAXExit(Sender: TObject);
    procedure edtPorEmpresaPORDEBExit(Sender: TObject);
    procedure edtPorEmpresaCTACREExit(Sender: TObject);
    procedure edtPorEmpresaCTATAXExit(Sender: TObject);
    procedure edtPorEmpresaCTADEBExit(Sender: TObject);
    procedure edtPorEmpresaCTAAJUExit(Sender: TObject);
    procedure edtPorEmpresaCTAANTExit(Sender: TObject);
    procedure edtPorEmpresaCTAFREExit(Sender: TObject);
    procedure edtPorEmpresaCTACUPExit(Sender: TObject);
    procedure edtPorEmpresaEVEDEBExit(Sender: TObject);
    procedure edtPorEmpresaEVETAXExit(Sender: TObject);
    procedure edtPorEmpresaEVECREExit(Sender: TObject);
    procedure edtPorEmpresaPORCREKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaPORTAXKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaPORDEBKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaCTATAXKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaCTADEBKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaCTAAJUKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaCTAANTKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaCTAFREKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaCTACUPKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaEVECREKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaEVETAXKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaEVEDEBKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaFORTAXExit(Sender: TObject);
    procedure edtPorEmpresaFORTAXKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaCODEMPKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmpresaCODEMPExit(Sender: TObject);
    procedure edtPorEmpresaCTACREKeyPress(Sender: TObject; var Key: Char);
    procedure edtPORBAIExit(Sender: TObject);
    procedure edtPORTAXExit(Sender: TObject);
    procedure edtPORBADExit(Sender: TObject);
    procedure edtCTABAIExit(Sender: TObject);
    procedure edtCTATAXExit(Sender: TObject);
    procedure edtCTABADExit(Sender: TObject);
    procedure edtCTAAJUExit(Sender: TObject);
    procedure edtCTAANTExit(Sender: TObject);
    procedure edtCTAFREExit(Sender: TObject);
    procedure edtCTACUPExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FCdsCartoes: TUniClientDataset;
    FCdsAdquirinteEquals: TUniClientDataset;
    FCdsMeioCapturaEquals: TUniClientDataset;
    FAlteradoComSucesso: Boolean;
    FQtdRegistrosAlterados: Integer;
    FQtdNaoPossuemRegistroCONPOR: Integer;
    FArrEmpresasSelecionadas: TConsultasArray;

    procedure pAlterarCartaoCADCAR(ACodigoCartao: string);
    procedure pAlterarCartaoPorEmpresaCONPOR(ACodigoCartao: string);
    procedure pAtualizarSelecaoCartoes;
    procedure pCarregarGridCartoes;
    procedure pConsultarCentroCustos(AEditCodigo, AEditNome: TEditFocus; var AKey: Char);
    procedure pConsultarEmpresa(AEditCodigo, AEditNome: TEditFocus; var AKey: Char);
    procedure pConsultarFornecedor(AEditCodigo, AEditNome: TEditFocus; var AKey: Char);
    procedure pConsultarPlanoContas(AEditCodigo, AEditNome: TEditFocus; var AKey: Char);
    procedure pConsultarPortador(AEditCodigo, AEditNome: TEditFocus; var AKey: Char);
    procedure pEncerrarDataset(ADataset: TUniClientDataset);
    procedure pExibirMensagemAposAlteracao;
    procedure pPreencherParametros(ADataset: TUniQuery; ANomeParametro, AValor: string);
    procedure pValidarCentroCustos(AEditCodigoCentroCustos, AEditNomeCentroCustos: TEditFocus);
    procedure pValidarEmpresa(AEditCodigoEmpresa, AEditNomeEmpresa: TEditFocus);
    procedure pValidarFornecedor(AEditCodigoFornecedor, AEditNomeFornecedor: TEditFocus);
    procedure pValidarPlanoContas(AEditCodigoPlanoContas, AEditNomePlanoContas: TEditFocus);
    procedure pValidarPortador(AEditCodigoPortador, AEditNomePortador: TEditFocus);

    function fAlterarCartoes(AProgressBar: TcxProgressBar = nil): Boolean;
    function fDesmarcarTodosCartoes(AProgressBar: TcxProgressBar = nil): Boolean;
    function fMarcarDesmarcarCartao: Boolean;
    function fMarcarTodosCartoes(AProgressBar: TcxProgressBar = nil): Boolean;
    function fRetornarChavePrimariaCONPOR(ACodigoCartao, ACodigoEmpresa: string): string;
    function fRetornarDatasetUpdateBaixaOtimizada: TUniQuery;
    function fRetornarDatasetUpdateBaixaOtimizadaPorEmpresa: TUniQuery;
    function fTemCartoesMarcados: Boolean;
    function fTemCampoTabBaixaOtimizadaPreenchido: Boolean;
    function fTemCampoTabBaixaOtimizadaPorEmpresaPreenchido: Boolean;
    function fValidarAlteracao: Boolean;
  public
    function fTemCartoesCadastrados: Boolean;
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untConsultas, untGravando, untTDadosEquals;

procedure TfrmCadCartoesAlteracaoGlobal.FormCreate(Sender: TObject);
begin
  inherited;
  FCdsCartoes := nil;
  pCarregarGridCartoes;

  FCdsAdquirinteEquals := TDadosEquals.RetornaDatasetAdquirinte;
  FCdsMeioCapturaEquals := TDadosEquals.RetornaDatasetMeiosCaptura;

  cmbEQUADQ.ListSource := fCriaDataSource(FCdsAdquirinteEquals);
  cmbEQUCAP.ListSource := fCriaDataSource(FCdsAdquirinteEquals);

  PgcDados.ActivePage := TsBaixaOtimizada;
  btnConfirma.Enabled := False;
  FAlteradoComSucesso := False;
  FQtdNaoPossuemRegistroCONPOR := 0;
  FQtdRegistrosAlterados := 0;
  FArrEmpresasSelecionadas := [];
end;

procedure TfrmCadCartoesAlteracaoGlobal.FormDestroy(Sender: TObject);
begin
  pEncerrarDataset(FCdsAdquirinteEquals);
  pEncerrarDataset(FCdsMeioCapturaEquals);
  pEncerrarDataset(FCdsCartoes);

  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F10) then
  begin
    Key := 0;
    if (btnConfirma.Enabled) then
      btnConfirma.Click;
  end
  else if  (Key = VK_F7) then
  begin
    Key := 0;
    btnMarcarTodas.Click;
  end
  else if (Key = VK_F8) then
  begin
    Key := 0;
    btnDesmarcarTodas.Click;
  end;

  inherited;
end;

function TfrmCadCartoesAlteracaoGlobal.fRetornarChavePrimariaCONPOR(
  ACodigoCartao, ACodigoEmpresa: string): string;
var
  LConsulta: TUniQuery;
begin
  Result := '';
  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add(
      'SELECT AUTOINCREM FROM CONPOR '+
      'WHERE CON_CODCAR = :CON_CODCAR '+
      'AND CON_CODEMP = :CON_CODEMP');

    LConsulta.ParamByName('CON_CODCAR').AsString := ACodigoCartao;
    LConsulta.ParamByName('CON_CODEMP').AsString := ACodigoEmpresa;
    LConsulta.Open;

    if (not LConsulta.Eof) then
      Result := LConsulta.Fields[0].AsString;
  finally
    FreeAndNil(LConsulta);
  end;
end;

function TfrmCadCartoesAlteracaoGlobal.fRetornarDatasetUpdateBaixaOtimizadaPorEmpresa: TUniQuery;
begin
  Result := fCriaQuery;
  Result.SQL.Text :=
    'UPDATE CONPOR SET '+
      IIF(fEmptyStr(edtPorEmpresaPORCRE.Text), '', 'CON_PORCRE = :CON_PORCRE, ')+
      IIF(fEmptyStr(edtPorEmpresaCTACRE.Text), '', 'CON_CTACRE = :CON_CTACRE, ')+
      IIF(fEmptyStr(edtPorEmpresaEVECRE.Text), '', 'CON_EVECRE = :CON_EVECRE, ')+
      IIF(fEmptyStr(edtPorEmpresaPORTAX.Text), '', 'CON_PORTAX = :CON_PORTAX, ')+
      IIF(fEmptyStr(edtPorEmpresaFORTAX.Text), '', 'CON_FORTAX = :CON_FORTAX, ')+
      IIF(fEmptyStr(edtPorEmpresaCTATAX.Text), '', 'CON_CTATAX = :CON_CTATAX, ')+
      IIF(fEmptyStr(edtPorEmpresaEVETAX.Text), '', 'CON_EVETAX = :CON_EVETAX, ')+
      IIF(fEmptyStr(edtPorEmpresaPORDEB.Text), '', 'CON_PORDEB = :CON_PORDEB, ')+
      IIF(fEmptyStr(edtPorEmpresaCTADEB.Text), '', 'CON_CTADEB = :CON_CTADEB, ')+
      IIF(fEmptyStr(edtPorEmpresaEVEDEB.Text), '', 'CON_EVEDEB = :CON_EVEDEB, ')+
      IIF(fEmptyStr(edtPorEmpresaCTAAJU.Text), '', 'CON_CTAAJU = :CON_CTAAJU, ')+
      IIF(fEmptyStr(edtPorEmpresaCTAANT.Text), '', 'CON_CTAANT = :CON_CTAANT, ')+
      IIF(fEmptyStr(edtPorEmpresaCTAFRE.Text), '', 'CON_CTAFRE = :CON_CTAFRE, ')+
      IIF(fEmptyStr(edtPorEmpresaCTACUP.Text), '', 'CON_CTACUP = :CON_CTACUP, ')+
      'CON_CODCAR = CON_CODCAR '+
    'WHERE AUTOINCREM = :AUTOINCREM';
end;

function TfrmCadCartoesAlteracaoGlobal.fRetornarDatasetUpdateBaixaOtimizada: TUniQuery;
begin
  Result := fCriaQuery;
  Result.SQL.Text :=
    'UPDATE CADCAR SET '+
      IIF(fEmptyStr(edtPORBAI.Text), '', 'CAR_PORBAI = :CAR_PORBAI, ')+
      IIF(fEmptyStr(edtCTABAI.Text), '', 'CAR_CTABAI = :CAR_CTABAI, ')+
      IIF(fEmptyStr(edtEVECRE.Text), '', 'CAR_EVECRE = :CAR_EVECRE, ')+
      IIF(fEmptyStr(edtPORTAX.Text), '', 'CAR_PORTAX = :CAR_PORTAX, ')+
      IIF(fEmptyStr(edtFORTAX.Text), '', 'CAR_FORTAX = :CAR_FORTAX, ')+
      IIF(fEmptyStr(edtCTATAX.Text), '', 'CAR_CTATAX = :CAR_CTATAX, ')+
      IIF(fEmptyStr(edtEVETAX.Text), '', 'CAR_EVETAX = :CAR_EVETAX, ')+
      IIF(fEmptyStr(edtPORBAD.Text), '', 'CAR_PORBAD = :CAR_PORBAD, ')+
      IIF(fEmptyStr(edtCTABAD.Text), '', 'CAR_CTABAD = :CAR_CTABAD, ')+
      IIF(fEmptyStr(edtEVEDEB.Text), '', 'CAR_EVEDEB = :CAR_EVEDEB, ')+
      IIF(fEmptyStr(edtCTAAJU.Text), '', 'CAR_CTAAJU = :CAR_CTAAJU, ')+
      IIF(fEmptyStr(edtCTAANT.Text), '', 'CAR_CTAANT = :CAR_CTAANT, ')+
      IIF(fEmptyStr(edtCTAFRE.Text), '', 'CAR_CTAFRE = :CAR_CTAFRE, ')+
      IIF(fEmptyStr(edtCTACUP.Text), '', 'CAR_CTACUP = :CAR_CTACUP, ')+
      IIF(fEmptyStr(cmbEQUADQ.Text), '', 'CAR_EQUADQ = :CAR_EQUADQ, ')+
      IIF(fEmptyStr(cmbEQUCAP.Text), '', 'CAR_EQUCAP = :CAR_EQUCAP, ')+
      'CAR_DESCAR = CAR_DESCAR '+
    'WHERE CAR_CODCAR = :CAR_CODCAR';
end;

function TfrmCadCartoesAlteracaoGlobal.fTemCampoTabBaixaOtimizadaPorEmpresaPreenchido: Boolean;
var
  LCamposContatenados: string;
begin
  LCamposContatenados :=
    Trim(edtPorEmpresaPORCRE.Text) +
    Trim(edtPorEmpresaCTACRE.Text) +
    Trim(edtPorEmpresaEVECRE.Text) +
    Trim(edtPorEmpresaPORTAX.Text) +
    Trim(edtPorEmpresaFORTAX.Text) +
    Trim(edtPorEmpresaCTATAX.Text) +
    Trim(edtPorEmpresaEVETAX.Text) +
    Trim(edtPorEmpresaPORDEB.Text) +
    Trim(edtPorEmpresaCTADEB.Text) +
    Trim(edtPorEmpresaEVEDEB.Text) +
    Trim(edtPorEmpresaCTAAJU.Text) +
    Trim(edtPorEmpresaCTAANT.Text) +
    Trim(edtPorEmpresaCTAFRE.Text) +
    Trim(edtPorEmpresaCTACUP.Text);

  Result := not fEmptyStr(LCamposContatenados);
end;

function TfrmCadCartoesAlteracaoGlobal.fTemCampoTabBaixaOtimizadaPreenchido: Boolean;
var
  LCamposContatenados: string;
begin
  LCamposContatenados :=
    Trim(edtPORBAI.Text) +
    Trim(edtCTABAI.Text) +
    Trim(edtEVECRE.Text) +
    Trim(edtPORTAX.Text) +
    Trim(edtFORTAX.Text) +
    Trim(edtCTATAX.Text) +
    Trim(edtEVETAX.Text) +
    Trim(edtPORBAD.Text) +
    Trim(edtCTABAD.Text) +
    Trim(edtEVEDEB.Text) +
    Trim(edtCTAAJU.Text) +
    Trim(edtCTAANT.Text) +
    Trim(edtCTAFRE.Text) +
    Trim(edtCTACUP.Text) +
    Trim(cmbEQUADQ.Text) +
    Trim(cmbEQUCAP.Text);

  Result := not fEmptyStr(LCamposContatenados);
end;

function TfrmCadCartoesAlteracaoGlobal.fTemCartoesCadastrados: Boolean;
begin
  Result := FCdsCartoes.RecordCount > 0;
end;

function TfrmCadCartoesAlteracaoGlobal.fTemCartoesMarcados: Boolean;
begin
  Result := FCdsCartoes.Locate('MARDES', 'M', []);
end;

function TfrmCadCartoesAlteracaoGlobal.fValidarAlteracao: Boolean;
var
  LTemCampoTabBaixaOtimizadaPreenchido,
  LTemCampoTabBaixaOtimizadaPorEmpresaPreenchido: Boolean;
  LEmpresaSelecionada: untTypesSistema.TConsultas;
begin
  Result := False;

  if (not fTemCartoesMarcados) then
  begin
    fMensagem('', 'Nenhum cartão foi marcado para alteração.', ['&Ok']);
    Exit;
  end;

  LTemCampoTabBaixaOtimizadaPreenchido := fTemCampoTabBaixaOtimizadaPreenchido;
  LTemCampoTabBaixaOtimizadaPorEmpresaPreenchido := fTemCampoTabBaixaOtimizadaPorEmpresaPreenchido;

  if ((not LTemCampoTabBaixaOtimizadaPreenchido) and
      (not LTemCampoTabBaixaOtimizadaPorEmpresaPreenchido)) then
  begin
    fMensagem('', 'Não há nenhuma alteração a ser feita.', ['&Ok']);
    Exit;
  end;

  if (LTemCampoTabBaixaOtimizadaPorEmpresaPreenchido) then
  begin
    if (Length(FArrEmpresasSelecionadas) = 0) then
    begin
      fMensagem('', 'A empresa deve ser preenchida.', ['&Ok']);
      Exit;
    end;

    for LEmpresaSelecionada in FArrEmpresasSelecionadas do
    begin
      if Pos(LEmpresaSelecionada.strCodigo, strEmpAcessoUsuarioLogado) <= 0 then
      begin
        fMensagem('ATENÇÃO', 'Usuário sem permissão de acesso a essa empresa.', ['&Ok']);
        Exit;
      end;
    end;
  end;

  Result := True;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pValidarCentroCustos(
  AEditCodigoCentroCustos, AEditNomeCentroCustos: TEditFocus);
var
  LConsulta: TUniQuery;
  LCodigoCentroCustos: string;
begin
  LCodigoCentroCustos := Trim(AEditCodigoCentroCustos.Text);

  if fEmptyStr(LCodigoCentroCustos) then
  begin
    AEditCodigoCentroCustos.Clear;
    AEditNomeCentroCustos.Clear;
    Exit;
  end;

  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add('SELECT EVE_CODEVE, EVE_DESEVE FROM CADEVE WHERE EVE_CODEVE = :EVE_CODEVE');
    LConsulta.ParamByName('EVE_CODEVE').AsInteger := StrToInt(LCodigoCentroCustos);
    LConsulta.Open;

    if LConsulta.Eof then
    begin
      fMensagem('ATENÇÃO!', 'Centro de custos não cadastrado.', ['&Ok']);
      AEditNomeCentroCustos.Clear;
      pSetFocus(AEditCodigoCentroCustos);
      Exit;
    end;

    AEditCodigoCentroCustos.Text := LConsulta.FieldByName('EVE_CODEVE').AsString;
    AEditNomeCentroCustos.Text := LConsulta.FieldByName('EVE_DESEVE').AsString;
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pValidarEmpresa(AEditCodigoEmpresa,
  AEditNomeEmpresa: TEditFocus);
var
  LEmpresaDigitada: TConsultas;
  LConsulta: TUniQuery;
  LCodigoEmpresa: string;
begin
  if (Length(FArrEmpresasSelecionadas) > 0) then
    Exit;

  LCodigoEmpresa := Trim(AEditCodigoEmpresa.Text);

  if fEmptyStr(LCodigoEmpresa) then
  begin
    AEditCodigoEmpresa.Clear;
    AEditNomeEmpresa.Clear;
    Exit;
  end;

  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add('SELECT EMP_CODEMP, EMP_NOMEMP FROM CADEMP WHERE EMP_CODEMP = :EMP_CODEMP');
    LConsulta.ParamByName('EMP_CODEMP').AsInteger := StrToInt(LCodigoEmpresa);
    LConsulta.Open;

    if LConsulta.Eof then
    begin
      fMensagem('ATENÇÃO!', 'Empresa não cadastrado.', ['&Ok']);
      AEditNomeEmpresa.Clear;
      pSetFocus(AEditCodigoEmpresa);
      Exit;
    end;

    LEmpresaDigitada.strCodigo := LConsulta.FieldByName('EMP_CODEMP').AsString;
    LEmpresaDigitada.strDescri := LConsulta.FieldByName('EMP_NOMEMP').AsString;

    AEditCodigoEmpresa.Text := LEmpresaDigitada.strCodigo;
    AEditNomeEmpresa.Text := LEmpresaDigitada.strDescri;

    SetLength(FArrEmpresasSelecionadas, 1);
    FArrEmpresasSelecionadas[0] := LEmpresaDigitada;
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pValidarFornecedor(
  AEditCodigoFornecedor, AEditNomeFornecedor: TEditFocus);
var
  LConsulta: TUniQuery;
  LCodigoFornecedor: string;
begin
  LCodigoFornecedor := Trim(AEditCodigoFornecedor.Text);

  if fEmptyStr(LCodigoFornecedor) then
  begin
    AEditCodigoFornecedor.Clear;
    AEditNomeFornecedor.Clear;
    Exit;
  end;

  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add('SELECT FOR_CODFOR, FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = :FOR_CODFOR');
    LConsulta.ParamByName('FOR_CODFOR').AsInteger := StrToInt(LCodigoFornecedor);
    LConsulta.Open;

    if LConsulta.Eof then
    begin
      fMensagem('ATENÇÃO!', 'Fornecedor não cadastrado.', ['&Ok']);
      AEditNomeFornecedor.Clear;
      pSetFocus(AEditCodigoFornecedor);
      Exit;
    end;

    AEditCodigoFornecedor.Text := LConsulta.FieldByName('FOR_CODFOR').AsString;
    AEditNomeFornecedor.Text := LConsulta.FieldByName('FOR_NOMFOR').AsString;
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pValidarPlanoContas(
  AEditCodigoPlanoContas, AEditNomePlanoContas: TEditFocus);
var
  LConsulta: TUniQuery;
  LCodigoPlanoContas: string;
begin
  LCodigoPlanoContas := Trim(AEditCodigoPlanoContas.Text);

  if fEmptyStr(LCodigoPlanoContas) then
  begin
    AEditCodigoPlanoContas.Clear;
    AEditNomePlanoContas.Clear;
    Exit;
  end;

  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add('SELECT CTA_CODCTA, CTA_DESCTA FROM CADCTA WHERE CTA_CODCTA = :CTA_CODCTA');
    LConsulta.ParamByName('CTA_CODCTA').AsInteger := StrToInt(LCodigoPlanoContas);
    LConsulta.Open;

    if LConsulta.Eof then
    begin
      fMensagem('ATENÇÃO!', 'Plano de contas não cadastrado.', ['&Ok']);
      AEditNomePlanoContas.Clear;
      pSetFocus(AEditCodigoPlanoContas);
      Exit;
    end;

    AEditCodigoPlanoContas.Text := LConsulta.FieldByName('CTA_CODCTA').AsString;
    AEditNomePlanoContas.Text := LConsulta.FieldByName('CTA_DESCTA').AsString;
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pValidarPortador(AEditCodigoPortador, AEditNomePortador: TEditFocus);
var
  LConsulta: TUniQuery;
  LCodigoPortador: string;
  LEmpresaSelecionada: TConsultas;
begin
  LCodigoPortador := Trim(AEditCodigoPortador.Text);

  AEditNomePortador.Clear;

  if fEmptyStr(LCodigoPortador) then
  begin
    AEditCodigoPortador.Clear;
    Exit;
  end;

  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add('SELECT POR_CODPOR, POR_NOMPOR FROM CADPOR WHERE POR_CODPOR = :POR_CODPOR');
    LConsulta.ParamByName('POR_CODPOR').AsInteger := StrToInt(LCodigoPortador);
    LConsulta.Open;

    if LConsulta.Eof then
    begin
      fMensagem('ATENÇÃO!', 'Portador não cadastrado.', ['&Ok']);
      pSetFocus(AEditCodigoPortador);
      Exit;
    end;

    for LEmpresaSelecionada in FArrEmpresasSelecionadas do
    begin
      if not fEmpresaTemAcessoPortador(LConsulta.FieldByName('POR_CODPOR').AsString, LEmpresaSelecionada.strCodigo) then
      begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        pSetFocus(AEditCodigoPortador);
        Exit;
      end
    end;

    AEditCodigoPortador.Text := LConsulta.FieldByName('POR_CODPOR').AsString;
    AEditNomePortador.Text := LConsulta.FieldByName('POR_NOMPOR').AsString;
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.btnConfirmaClick(Sender: TObject);
var
  LFrmGravando: TFrmGravando;
begin
  if (not fValidarAlteracao) then
    Exit;

  if (fMensagem('', 'Os cartões marcados serão alterados. Deseja continuar?', ['&Sim', '&Não']) = 2) then
    Exit;

  pCriarFormularios(TFrmGravando, LFrmGravando);
  try
    LFrmGravando.fExecutarAcao := fAlterarCartoes;
    LFrmGravando.lblGravando.Caption := 'Aguarde... Processando alterações.';
    LFrmGravando.ShowModal;
  finally
    pFreeAndNil(LFrmGravando);
  end;

  pExibirMensagemAposAlteracao;

  if (FAlteradoComSucesso) then
  begin
    ModalResult := mrOk;
    inherited;
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.btnMarcarTodasClick(
  Sender: TObject);
var
  LFrmGravando: TFrmGravando;
begin
  inherited;

  if (fMensagem('', 'Confirma marcar todos os cartões?', ['&Sim', '&Não']) = 2) then
    Exit;

  pCriarFormularios(TFrmGravando, LFrmGravando);
  try
    LFrmGravando.fExecutarAcao := fMarcarTodosCartoes;
    LFrmGravando.lblGravando.Caption := 'Aguarde... Marcando todos os cartões.';;
    LFrmGravando.ShowModal;
  finally
    pFreeAndNil(LFrmGravando);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.btnDesmarcarTodasClick(
  Sender: TObject);
var
  LFrmGravando: TFrmGravando;
begin
  inherited;

  if (fMensagem('', 'Confirma desmarcar todos os cartões?', ['&Sim', '&Não']) = 2) then
    Exit;

  pCriarFormularios(TFrmGravando, LFrmGravando);
  try
    LFrmGravando.fExecutarAcao := fDesmarcarTodosCartoes;
    LFrmGravando.lblGravando.Caption := 'Aguarde... Desmarcando todos os cartões.';
    LFrmGravando.ShowModal;
  finally
    pFreeAndNil(LFrmGravando);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTAAJUExit(Sender: TObject);
begin
  pValidarPlanoContas(edtCTAAJU, edtCTAAJUNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTAAJUKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtCTAAJU, edtCTAAJUNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTAANTExit(Sender: TObject);
begin
  pValidarPlanoContas(edtCTAANT, edtCTAANTNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTAANTKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtCTAANT, edtCTAANTNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTABADExit(Sender: TObject);
begin
  pValidarPlanoContas(edtCTATAX, edtCTATAXNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTABADKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtCTABAD, edtCTABADNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTABAIExit(Sender: TObject);
begin
  pValidarPlanoContas(edtCTABAI, edtCTABAINome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTABAIKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtCTABAI, edtCTABAINome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTACUPExit(Sender: TObject);
begin
  pValidarPlanoContas(edtCTACUP, edtCTACUPNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTACUPKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtCTACUP, edtCTACUPNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTAFREExit(Sender: TObject);
begin
  pValidarPlanoContas(edtCTAFRE, edtCTAFRENome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTAFREKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtCTAFRE, edtCTAFRENome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTATAXExit(Sender: TObject);
begin
  pValidarPlanoContas(edtCTATAX, edtCTATAXNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtCTATAXKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtCTATAX, edtCTATAXNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtEVECREKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarCentroCustos(edtEVECRE, edtEVECRENome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtEVEDEBKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarCentroCustos(edtEVEDEB, edtEVEDEBNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtEVETAXKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarCentroCustos(edtEVETAX, edtEVETAXNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtFORTAXKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarFornecedor(edtFORTAX, edtFORTAXNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPORBADExit(Sender: TObject);
begin
  pValidarPortador(edtPORBAD, edtPORBADNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPORBADKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPortador(edtPORBAD, edtPORBADNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPORBAIExit(Sender: TObject);
begin
  pValidarPortador(edtPORBAI, edtPORBAINome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPORBAIKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPortador(edtPORBAI, edtPORBAINome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCODEMPExit(
  Sender: TObject);
begin
  pValidarEmpresa(edtPorEmpresaCODEMP, edtPorEmpresaCODEMPNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCODEMPKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarEmpresa(edtPorEmpresaCODEMP, edtPorEmpresaCODEMPNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTAAJUExit(
  Sender: TObject);
begin
  pValidarPlanoContas(edtPorEmpresaCTAAJU, edtPorEmpresaCTAAJUNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTAAJUKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtPorEmpresaCTAAJU, edtPorEmpresaCTAAJUNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTAANTExit(
  Sender: TObject);
begin
  inherited;
  pValidarPlanoContas(edtPorEmpresaCTAANT, edtPorEmpresaCTAANTNome);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTAANTKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtPorEmpresaCTAANT, edtPorEmpresaCTAANTNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTACREExit(
  Sender: TObject);
begin
  pValidarPlanoContas(edtPorEmpresaCTACRE, edtPorEmpresaCTACRENome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTACREKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtPorEmpresaCTACRE, edtPorEmpresaCTACRENome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTACUPExit(
  Sender: TObject);
begin
  pValidarPlanoContas(edtPorEmpresaCTACUP, edtPorEmpresaCTACUPNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTACUPKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtPorEmpresaCTACUP, edtPorEmpresaCTACUPNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTADEBExit(
  Sender: TObject);
begin
  pValidarPlanoContas(edtPorEmpresaCTADEB, edtPorEmpresaCTADEBNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTADEBKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtPorEmpresaCTADEB, edtPorEmpresaCTADEBNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTAFREExit(
  Sender: TObject);
begin
  pValidarPlanoContas(edtPorEmpresaCTAFRE, edtPorEmpresaCTAFRENome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTAFREKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtPorEmpresaCTAFRE, edtPorEmpresaCTAFRENome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTATAXExit(
  Sender: TObject);
begin
  pValidarPlanoContas(edtPorEmpresaCTATAX, edtPorEmpresaCTATAXNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaCTATAXKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPlanoContas(edtPorEmpresaCTATAX, edtPorEmpresaCTATAXNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaEVECREExit(
  Sender: TObject);
begin
  pValidarCentroCustos(edtPorEmpresaEVECRE, edtPorEmpresaEVECRENome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaEVECREKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarCentroCustos(edtPorEmpresaEVECRE, edtPorEmpresaEVECRENome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaEVEDEBExit(
  Sender: TObject);
begin
  pValidarCentroCustos(edtPorEmpresaEVEDEB, edtPorEmpresaEVEDEBNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaEVEDEBKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarCentroCustos(edtPorEmpresaEVEDEB, edtPorEmpresaEVEDEBNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaEVETAXExit(
  Sender: TObject);
begin
  pValidarCentroCustos(edtPorEmpresaEVETAX, edtPorEmpresaEVETAXNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaEVETAXKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarCentroCustos(edtPorEmpresaEVETAX, edtPorEmpresaEVETAXNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaFORTAXExit(
  Sender: TObject);
begin
  pValidarFornecedor(edtPorEmpresaFORTAX, edtPorEmpresaFORTAXNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaFORTAXKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarFornecedor(edtPorEmpresaFORTAX, edtPorEmpresaFORTAXNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaPORCREExit(
  Sender: TObject);
begin
  pValidarPortador(edtPorEmpresaPORCRE, edtPorEmpresaPORCRENome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaPORCREKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPortador(edtPorEmpresaPORCRE, edtPorEmpresaPORCRENome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaPORDEBExit(
  Sender: TObject);
begin
  pValidarPortador(edtPorEmpresaPORDEB, edtPorEmpresaPORDEBNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaPORDEBKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPortador(edtPorEmpresaPORDEB, edtPorEmpresaPORDEBNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaPORTAXExit(
  Sender: TObject);
begin
  inherited;
  pValidarPortador(edtPorEmpresaPORTAX, edtPorEmpresaPORTAXNome);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPorEmpresaPORTAXKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  pConsultarPortador(edtPorEmpresaPORTAX, edtPorEmpresaPORTAXNome, Key);
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPORTAXExit(Sender: TObject);
begin
  pValidarPortador(edtPORTAX, edtPORTAXNome);
  inherited;
end;

procedure TfrmCadCartoesAlteracaoGlobal.edtPORTAXKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  pConsultarPortador(edtPORTAX, edtPORTAXNome, Key);
end;

function TfrmCadCartoesAlteracaoGlobal.fAlterarCartoes(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
  LRecNoBackup: Integer;
  LTemCampoTabBaixaOtimizadaPreenchido,
  LTemCampoTabBaixaOtimizadaPorEmpresaPreenchido: Boolean;
begin
  Result := False;
  FAlteradoComSucesso := False;
  FQtdRegistrosAlterados := 0;
  FQtdNaoPossuemRegistroCONPOR := 0;
  LTemCampoTabBaixaOtimizadaPreenchido := fTemCampoTabBaixaOtimizadaPreenchido;
  LTemCampoTabBaixaOtimizadaPorEmpresaPreenchido := fTemCampoTabBaixaOtimizadaPorEmpresaPreenchido;
  LRecNoBackup := FCdsCartoes.RecNo;
  pDisableControls(FCdsCartoes, LScroll);
  try
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := FCdsCartoes.RecordCount;
    FCdsCartoes.First;
    fStartTransaction;
    try
      while not FCdsCartoes.Eof do
      begin
        pStepStatusGravacao(AProgressBar);

        if FCdsCartoes.FieldByName('MARDES').AsString <> 'M' then
        begin
          FCdsCartoes.Next;
          Continue;
        end;

        if LTemCampoTabBaixaOtimizadaPreenchido then
          pAlterarCartaoCADCAR(FCdsCartoes.FieldByName('CAR_CODCAR').AsString);

        if LTemCampoTabBaixaOtimizadaPorEmpresaPreenchido then
          pAlterarCartaoPorEmpresaCONPOR(FCdsCartoes.FieldByName('CAR_CODCAR').AsString);

        FCdsCartoes.Next;
      end;
      pAtualizarSelecaoCartoes;
      fCommit;
      Result := True;
      FAlteradoComSucesso := FQtdRegistrosAlterados > 0;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(
          'Ocorreu um erro ao alterar os cartões marcados!' + #13 + E.Message,
          '[TfrmCadCartoesAlteracaoGlobal.fAlterarCartoes]');
        Exit;
      end;
    end;
  finally
    pEnableControls(FCdsCartoes, LScroll);
    FCdsCartoes.RecNo := LRecNoBackup;
  end;
end;

function TfrmCadCartoesAlteracaoGlobal.fDesmarcarTodosCartoes(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
  LRecNoBackup: Integer;
begin
  LRecNoBackup := FCdsCartoes.RecNo;
  pDisableControls(FCdsCartoes, LScroll);
  try
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := FCdsCartoes.RecordCount;
    FCdsCartoes.First;

    while not FCdsCartoes.Eof do
    begin
      pStepStatusGravacao(AProgressBar);
      if FCdsCartoes.FieldByName('MARDES').AsString = 'M' then
      begin
        FCdsCartoes.Edit;
        FCdsCartoes.FieldByName('MARDES').AsString := 'D';
        FCdsCartoes.Post;
      end;
      FCdsCartoes.Next;
    end;
    pAtualizarSelecaoCartoes;
    Result := True;
  finally
    pEnableControls(FCdsCartoes, LScroll);
    FCdsCartoes.RecNo := LRecNoBackup;
  end;
end;

function TfrmCadCartoesAlteracaoGlobal.fMarcarDesmarcarCartao: Boolean;
var
  LMarcado: Boolean;
begin
  LMarcado := FCdsCartoes.FieldByName('MARDES').AsString = 'M';

  FCdsCartoes.Edit;

  if (LMarcado) then
    FCdsCartoes.FieldByName('MARDES').AsString := 'D'
  else
    FCdsCartoes.FieldByName('MARDES').AsString := 'M';

  FCdsCartoes.Post;

  Result := True;
end;

function TfrmCadCartoesAlteracaoGlobal.fMarcarTodosCartoes(
  AProgressBar: TcxProgressBar): Boolean;
var
  LScroll: TprcScroll;
  LRecNoBackup: Integer;
begin
  LRecNoBackup := FCdsCartoes.RecNo;
  pDisableControls(FCdsCartoes, LScroll);
  try
    AProgressBar.Position := 0;
    AProgressBar.Properties.Max := FCdsCartoes.RecordCount;
    FCdsCartoes.First;

    while not FCdsCartoes.Eof do
    begin
      pStepStatusGravacao(AProgressBar);
      if FCdsCartoes.FieldByName('MARDES').AsString = 'D' then
      begin
        FCdsCartoes.Edit;
        FCdsCartoes.FieldByName('MARDES').AsString := 'M';
        FCdsCartoes.Post;
      end;
      FCdsCartoes.Next;
    end;
    pAtualizarSelecaoCartoes;
    Result := True;
  finally
    pEnableControls(FCdsCartoes, LScroll);
    FCdsCartoes.RecNo := LRecNoBackup;
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pAlterarCartaoCADCAR(
  ACodigoCartao: string);
var
  LUpdateQuery: TUniQuery;
begin
  LUpdateQuery := fRetornarDatasetUpdateBaixaOtimizada;
  try
    pPreencherParametros(LUpdateQuery, 'CAR_PORBAI', edtPORBAI.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_CTABAI', edtCTABAI.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_EVECRE', edtEVECRE.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_PORTAX', edtPORTAX.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_FORTAX', edtFORTAX.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_CTATAX', edtCTATAX.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_EVETAX', edtEVETAX.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_PORBAD', edtPORBAD.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_CTABAD', edtCTABAD.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_EVEDEB', edtEVEDEB.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_CTAAJU', edtCTAAJU.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_CTAANT', edtCTAANT.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_CTAFRE', edtCTAFRE.Text);
    pPreencherParametros(LUpdateQuery, 'CAR_CTACUP', edtCTACUP.Text);

    if not fEmptyStr(cmbEQUADQ.Text) then
      pPreencherParametros(LUpdateQuery, 'CAR_EQUADQ', FCdsAdquirinteEquals.FieldByName('CODIGO').AsString);

    if not fEmptyStr(cmbEQUCAP.Text) then
      pPreencherParametros(LUpdateQuery, 'CAR_EQUCAP', FCdsMeioCapturaEquals.FieldByName('CODIGO').AsString);

    LUpdateQuery.ParamByName('CAR_CODCAR').AsString := ACodigoCartao;
    LUpdateQuery.ExecSQL;
    Inc(FQtdRegistrosAlterados);
  finally
    FreeAndNil(LUpdateQuery);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pAlterarCartaoPorEmpresaCONPOR(
  ACodigoCartao: string);
var
  LUpdateQuery: TUniQuery;
  LEmpresaSelecionada: untTypesSistema.TConsultas;
  LChavePrimariaCONPOR: string;
begin
  LUpdateQuery := fRetornarDatasetUpdateBaixaOtimizadaPorEmpresa;
  try
    for LEmpresaSelecionada in FArrEmpresasSelecionadas do
    begin
      LChavePrimariaCONPOR := fRetornarChavePrimariaCONPOR(ACodigoCartao, LEmpresaSelecionada.strCodigo);

      if (fEmptyStr(LChavePrimariaCONPOR)) then
      begin
        Inc(FQtdNaoPossuemRegistroCONPOR);
        Continue;
      end;

      LUpdateQuery.ParamByName('AUTOINCREM').AsString := LChavePrimariaCONPOR;
      pPreencherParametros(LUpdateQuery, 'CON_PORCRE', edtPorEmpresaPORCRE.Text);
      pPreencherParametros(LUpdateQuery, 'CON_CTACRE', edtPorEmpresaCTACRE.Text);
      pPreencherParametros(LUpdateQuery, 'CON_EVECRE', edtPorEmpresaEVECRE.Text);
      pPreencherParametros(LUpdateQuery, 'CON_PORTAX', edtPorEmpresaPORTAX.Text);
      pPreencherParametros(LUpdateQuery, 'CON_FORTAX', edtPorEmpresaFORTAX.Text);
      pPreencherParametros(LUpdateQuery, 'CON_CTATAX', edtPorEmpresaCTATAX.Text);
      pPreencherParametros(LUpdateQuery, 'CON_EVETAX', edtPorEmpresaEVETAX.Text);
      pPreencherParametros(LUpdateQuery, 'CON_PORDEB', edtPorEmpresaPORDEB.Text);
      pPreencherParametros(LUpdateQuery, 'CON_CTADEB', edtPorEmpresaCTADEB.Text);
      pPreencherParametros(LUpdateQuery, 'CON_EVEDEB', edtPorEmpresaEVEDEB.Text);
      pPreencherParametros(LUpdateQuery, 'CON_CTAAJU', edtPorEmpresaCTAAJU.Text);
      pPreencherParametros(LUpdateQuery, 'CON_CTAANT', edtPorEmpresaCTAANT.Text);
      pPreencherParametros(LUpdateQuery, 'CON_CTAFRE', edtPorEmpresaCTAFRE.Text);
      pPreencherParametros(LUpdateQuery, 'CON_CTACUP', edtPorEmpresaCTACUP.Text);

      LUpdateQuery.ExecSQL;
      Inc(FQtdRegistrosAlterados);
    end;
  finally
    FreeAndNil(LUpdateQuery);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pAtualizarSelecaoCartoes;
begin
  btnConfirma.Enabled := fTemCartoesMarcados;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pCarregarGridCartoes;
var
  LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add(
      'SELECT '+
        '"D" as MARDES, '+
        'CADCAR.CAR_CODCAR, '+
        'CADCAR.CAR_DESCAR, '+
        'CADEMP.EMP_CODEMP, '+
        'CONCAT(CADEMP.EMP_CODEMP, "-", CADEMP.EMP_NOMEMP) AS EMPRESA '+
      'FROM CADCAR '+
      'LEFT JOIN CADEMP ON CADCAR.CAR_CODEMP = CADEMP.EMP_CODEMP '+
      'ORDER BY CADCAR.CAR_DESCAR');
    LConsulta.Open;
    FCdsCartoes := fCriaClientDatset(LConsulta);
    dtsCartoes.Dataset := FCdsCartoes;
    TableViewCartoes.DataController.DataSource := dtsCartoes;
    FCdsCartoes.First;
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pConsultarCentroCustos(
  AEditCodigo, AEditNome: TEditFocus;
  var AKey: Char);
var
  LArrSel: TConsultasArray;
  LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  try
    fPesqEventos(Self, AEditCodigo, AEditNome, LConsulta, AKey, LArrSel);
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pConsultarEmpresa(
  AEditCodigo, AEditNome: TEditFocus;
  var AKey: Char);
var
  LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  try
    fPesqEmpresa(conEmpSimples, Self, AEditCodigo, AEditNome, LConsulta, AKey, FArrEmpresasSelecionadas, False);
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pConsultarFornecedor(
  AEditCodigo, AEditNome: TEditFocus;
  var AKey: Char);
var
  LArrSel: TConsultasArray;
  LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  try
    fPesqFornecedor(conForSimples, Self, AEditCodigo, AEditNome, LConsulta, AKey, LArrSel);
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pConsultarPlanoContas(
  AEditCodigo, AEditNome: TEditFocus;
  var AKey: Char);
var
  LArrSel: TConsultasArray;
  LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  try
    fPesqCentroCusto(Self, AEditCodigo, AEditNome, LConsulta, AKey, LArrSel);
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pConsultarPortador(
  AEditCodigo, AEditNome: TEditFocus;
  var AKey: Char);
var
  LArrSel: TConsultasArray;
  LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  try
    fPesqPortador(conSimples, Self, AEditCodigo, AEditNome, LConsulta, AKey, LArrSel);
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.pEncerrarDataset(
  ADataset: TUniClientDataset);
begin
  if (ADataset.Active) then
  begin
    ADataset.EmptyDataSet;
    ADataset.Close;
  end;

  FreeAndNil(ADataset);
end;

procedure TfrmCadCartoesAlteracaoGlobal.pExibirMensagemAposAlteracao;
var
  LTextoFinal,
  LSubTextoNaoPossuemRegistroCONPOR,
  LSubTextoEmpresaSelecionada: string;
begin
  LTextoFinal := 'Nenhuma alteração foi realizada.';
  LSubTextoNaoPossuemRegistroCONPOR := '';
  LSubTextoEmpresaSelecionada := '';

  if (FQtdRegistrosAlterados > 0) then
  begin
    LTextoFinal := 'Alterações realizadas com sucesso.';

    if (FQtdRegistrosAlterados = 1) then
      LTextoFinal := 'Alteração realizada com sucesso.';
  end;

  if (FQtdNaoPossuemRegistroCONPOR > 0) then
  begin
    LSubTextoEmpresaSelecionada := 'na empresa selecionada.';

    if (Length(FArrEmpresasSelecionadas) > 1) then
      LSubTextoEmpresaSelecionada := 'nas empresas selecionadas.';

    LSubTextoNaoPossuemRegistroCONPOR :=
      'Alguns cartões marcados não possuem registros '+ LSubTextoEmpresaSelecionada + #13 +
      'É necessário adicioná-los manualmente.';

    if (FQtdNaoPossuemRegistroCONPOR = 1) then
      LSubTextoNaoPossuemRegistroCONPOR :=
        'O cartão marcado não possui registro '+ LSubTextoEmpresaSelecionada + #13 +
        'É necessário adicioná-lo manualmente.';

    LTextoFinal := LTextoFinal + #13 + LSubTextoNaoPossuemRegistroCONPOR;
  end;

  fMensagem('AVISO', LTextoFinal, ['&Ok']);
end;

procedure TfrmCadCartoesAlteracaoGlobal.pPreencherParametros(
  ADataset: TUniQuery; ANomeParametro, AValor: string);
begin
  if (not fEmptyStr(AValor)) then
    ADataset.ParamByName(ANomeParametro).AsString := AValor;
end;

procedure TfrmCadCartoesAlteracaoGlobal.TableViewCartoesCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  LMarcado: Boolean;
begin
  inherited;

  LMarcado := Sender.DataController.Values[
    AViewInfo.GridRecord.RecordIndex,
    TableViewCartoesMARDES.Index] = 'M';

  if (LMarcado) then
    ACanvas.Font.Color := clBlue;
end;

procedure TfrmCadCartoesAlteracaoGlobal.TableViewCartoesDblClick(
  Sender: TObject);
var
  LRecNoBackup: Integer;
begin
  inherited;

  LRecNoBackup := FCdsCartoes.RecNo;
  try
    if (fMarcarDesmarcarCartao) then
      pAtualizarSelecaoCartoes;
  finally
    FCdsCartoes.RecNo := LRecNoBackup;
    pSetFocus(GridCartoes);
  end;
end;

procedure TfrmCadCartoesAlteracaoGlobal.TableViewCartoesKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LRecNoBackup: Integer;
begin
  inherited;
  if (Key = VK_RETURN) then
  begin
    LRecNoBackup := FCdsCartoes.RecNo;
    try
      if (fMarcarDesmarcarCartao) then
        pAtualizarSelecaoCartoes;
    finally
      FCdsCartoes.RecNo := LRecNoBackup;
      pSetFocus(GridCartoes);
    end;
  end;
end;

end.
