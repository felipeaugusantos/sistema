unit untLibDominioSistemasInterfacesTipos;

interface

Uses System.Classes, System.SysUtils,Winapi.Windows, Winapi.Messages, Vcl.Forms,
     System.Generics.Collections,Vcl.StdCtrls, Data.DB, Vcl.AppEvnts,
     Vcl.Controls, Vcl.Menus,

     Uni, EditFocus, cxProgressBar, frxClass, frxPreview;

Type
  TPrintBClick = procedure(Sender: TObject) of Object;
  TOnPreview = procedure(Sender: TObject) of Object;

  IReport = interface
    ['{CE47EE24-0DDF-4856-AB50-0CF90D412D5E}']
    procedure PrepareReport;
    procedure ShowReport;
    procedure Print;
    procedure SaveToFile(AFile: String);
    procedure ExportarParaPDF(ATitle: String);
    function Printer: String;
    function Copies: String;
    function Collate: String;
    function PageNumbers: String;
    function PrintMode: String;
    function PrintOnSheet: String;
    function PrintPages: String;
    function PagesCount: Integer;
    function GetPrintBClick: TPrintBClick;
    procedure SetPrintBClick(AProc: TPrintBClick);
    procedure SetOnPreview(AProc: TOnPreview);
  end;

  ITelasAbertas = interface
    ['{469E5741-FCD6-410E-B16D-8A42632BB767}']
   {$IFNDEF LINUX}
    function Forms : TList<TForm>;
    function LastFormOpened : TForm;
    procedure AddFormAndSetPopupMode(FormOpened: TForm);
    procedure RemoveFormParent(FormClosing: TForm);
   {$ENDIF}
  end;

  ExceptionAutCom = Exception;

  {$IFDEF LINUX}
    TStringArray = TArray<string>;
  {$ELSE}
    TStringArray = Array Of String;
  {$ENDIF}

  {untGravando}
  TFunctionFormGravando = function(pgbProgresso: TcxProgressBar): Boolean Of Object;
  TGenericProcedure = procedure of object;
  TReferenceProcedure = reference to procedure;
  TGenericFunctionWithoutParam = function: Boolean of object;
  TBooleanFunctionWithBooleanParam = function(blnCheck : Boolean = False) : Boolean;
  TReferenceFunctionProgresso = reference to function(pgbProgresso: TcxProgressBar): Boolean;

  TRecConfiguracoes = Record
    strCodCfg,
    strDescri,
    strValCfg,
    strGruCfg,
    strLayout,
    strPerRep,
    strUsoCit: String;
    intNumHlp: Integer;
    blnDefEmp: Boolean;
  End;

  {* Conciliação de Cartões de Crédito *}
  TCamposConcil = Record
    strTabCon,
    strCamCon,
    strNomCon,
    strConfEs,
    strValBru,
    strValLiq,
    strCodCon,
    strCodAut,
    strNumNSU,
    strDtaTra,
    strID,
    strNumPar,
    strTotPar,
    strNumCar,
    strDtaRec,
    strConfPr,
    strConfCt,
    strConfFo,
    strConfCp,
    strTipReg,
    strTipTra,
    strEventoCancelamentoAjuste,
    strChavePrimaria,
    strChavePrimariaAjuste,
    CfgPortadorTransferencia,
    CfgPlanoDeContasTransferencia,
    CfgCentroDeCustosTransferencia,
    CfgVlrTolerancia,
    CfgPlanoDeContasTransferenciaLancDeb,
    CodigoEmpresaFixaParaBaixa: String;
  End;

  TArrBaiSinCar = Record
    fltValDoc,
    fltValTax,
    fltValAnt,
    FreteMarketPlace,
    AjusteMarketPlace,
    CupomMarketPlace,
    SubtrairFrete : Double;

    dtaDtaRec    : TDateTime;

    strCodEmp,
    strSeqLanCre,
    strSeqLanDeb,
    strSeqLanTax,
    strSeqLanAnt,
    strPorBai,
    strCtaBai,
    strEventoCredito,
    strPorTax,
    strCtaTax,
    strForTax,
    strEventoTaxa,
    strPorBad,
    strCtaBad,
    strEveDeb,
    strHisDoc,
    strNumDoc,
    strDocBai,
    strCtaAnt,
    strTipAju,
    strEventoCancelamentoAjuste,
    PlanoDeContasParaCTPDet,

    SeqLanFreteMkt,
    SeqLanAjusteMkt,
    SeqLanCupomMkt,

    PlanoDeContasFreteMkt,
    PlanoDeContasAjusteMkt,
    PlanoDeContasCupomMkt,

    SeqlanTaxaNegociacao,
    PlanoDEContasTaxaNegociacao: String;

    intPagCon,
    intQtdCar    : Integer;
  End;

  TSequenciaisBaixaCartao = class
  public
    intSeqLan,
    intSequencialCadPag,

    intContadorAutIncMovBan,
    intContadorAutIncBanMca,
    intContadorAutIncCadPag,
    intContadorAutIncLogMca,
    intContadorAutIncLogCtp,

    SequencialControleBaixaPagar: Int64;

    NumeroDocumentoBaixa: String;

    constructor Create;
    destructor Destroy; override;
  end;

  TArrConfiguracoes = Array Of TRecConfiguracoes;

  TConsultas = Record
    strCodigo: String;
    strDescri: String;
  End;

  TConsultasArray = Array Of TConsultas;

  TRecSizeField = Record
    Name: String;
    Size: Integer;
  end;

  TLogLib = Record
    strDirAce: String;
    strDirAceAuxiliar: String;
    strOpeLib: String;
    strCodVen: String;
    strCodIte: String;
    intAutInc: Integer;
    dtaDtaCad: TDateTime;
    dtaHraCad: TDateTime;
    dtaDtaLib: TDateTime;
    dtaHraLib: TDateTime;
    dtaDtaEnv: TDateTime;
    dtaHraEnv: TDateTime;
    strMsgSen: String;
    strObserv: String;
    strNumLib: String;
    blnInsLog: Boolean;
    strInfBlo: String;
    blnIgnInc: Boolean;
    strinfoF4: String;
    strTitulo: String;
    strCodLib: String;
    strCodCli: String;
  End;

  TArrLogLib = Array Of TLogLib;

  TTipoConsultaSimples = (conSimples, conParaBaixas, conTransfCx);
  TTipoConsultaFornecedor  = (conForSimples, conForCompleta, conForUltimaCompra);
  TTipoConsultaEmpresa = (conEmpSimples, conEmpCompleta);
  TTipoConsultaCliente     = (conCliSimples, conCliCompleta, conCliEmpresaIdent, conCliFiliais, conCliAgrupDup);

  TfncRetNome      = function (strCodigo: String): String;
  TfncRetNomeConst = function (Const strCodigo: String): String;
  TfncRetNomeParam = function (strCodigo: String; arrCod: TConsultasArray = nil; strAutIncrem: String = ''): string;

  TprcScroll = procedure (DataSet: TDataSet) Of Object;

  TProcMensagemOK = procedure(strmensagem: string);

  TOnMensagem = reference to procedure(ATexto: String);

  TCustomMenuItem = Class(TMenuItem)
  Private
    FProjeto: String;
  Public
    Property Projeto: String Read FProjeto Write FProjeto;
  End;

  TFiltrosRelatorioBaixaCartoes = Record
    AutoIncrem,
    FiltrosDescri,
    ListaEmpresas: String;

    ExibeGrupoBandeira,
    ExibeGrupoPontoDeVenda,
    ExibeArquivos,
    ExibeFaltantes: Boolean;

    Ordenacao: Integer;
  End;

  {EDITOR RELATÓRIOS}
  TArrString = Array Of String;

  TParametrosRelatorio = Class
  Private

  Public
    strCampoRetorno,
    strValorRetorno: String;

    blnRetornaCampoComEnter: Boolean;

    strMensagemRodape: String;
  End;

  TRetornoRelatorio = Class(TComponent)
  private

  public
    intAlturaTela,
    intLarguraTela: Integer;

    arrParametrosInvisiveis: TArrString;

    blnPaiEmEdicao,
    blnExecutandoPeloBotao: Boolean;

    constructor Create(Owner: TComponent); reintroduce;

  published

  End;

  {FIM EDITOR RELATÓRIOS}

Var
  VS_ExibirMensagemAoUsuario: Boolean;
  VS_ExibirMensagemDeErro: Boolean;
  VS_ExibirMensagemAguarde: Boolean;
  VS_ExibirMensagemStayOnTop: Boolean;

  VS_OnMensagemAoUsuario: TOnMensagem;
  VS_OnMensagemDeErro: TOnMensagem;
  VS_OnMensagemAguarde: TOnMensagem;

implementation

{ TSequenciaisBaixaCartao }

constructor TSequenciaisBaixaCartao.Create;
begin
  inherited;
  intSeqLan := 0;
  intSequencialCadPag := 0;

  intContadorAutIncMovBan := 0;
  intContadorAutIncBanMca := 0;
  intContadorAutIncCadPag := 0;
  intContadorAutIncLogMca := 0;
  intContadorAutIncLogCtp := 0;

  SequencialControleBaixaPagar := 0;

  NumeroDocumentoBaixa := EmptyStr;
end;

destructor TSequenciaisBaixaCartao.Destroy;
begin
  intSeqLan := 0;
  intSequencialCadPag := 0;

  intContadorAutIncMovBan := 0;
  intContadorAutIncBanMca := 0;
  intContadorAutIncCadPag := 0;
  intContadorAutIncLogMca := 0;
  intContadorAutIncLogCtp := 0;

  SequencialControleBaixaPagar := 0;

  NumeroDocumentoBaixa := EmptyStr;

  inherited;
end;

{ TRetornoRelatorio }

constructor TRetornoRelatorio.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  intAlturaTela := 0;
  intLarguraTela:= 0;

  blnPaiEmEdicao := False;
  blnExecutandoPeloBotao := False;

  arrParametrosInvisiveis := Nil;
end;

Initialization
  VS_ExibirMensagemAoUsuario := True;
  VS_ExibirMensagemDeErro    := True;
  VS_ExibirMensagemAguarde   := True;
  VS_ExibirMensagemStayOnTop := False;

  VS_OnMensagemAoUsuario := nil;
  VS_OnMensagemDeErro    := nil;
  VS_OnMensagemAguarde   := nil;

end.
