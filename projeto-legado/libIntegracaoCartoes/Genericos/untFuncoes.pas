unit untFuncoes;

interface

uses StrUtils, SysUtils, untIIntegracaoCartoes, untIDataset, Variants, frxClass, frxPreview,
     frxExportPDF,
     untRedeDebito, untRedeCredito, Windows, dxCore, untElavonCredito,
     untElavonPagto, untEquals, untEqualsPagto, Classes, untAmexPgto,
     untBanesCardPgto,untBanesCard, untChartCielo,
     untChartCieloPgto, untConcil, untConcilPgto,
     untSafrapay, untSafrapayPgto, Dialogs, stdActns, StdCtrls, Forms,
     untRedeSite, untRedeSitePgto, untPagSeguro, untPagSeguroPgto,
     untBoaVista, untBoaVistaPgto,
     {$IF Defined(VER180)}
     {$ELSE}
       System.ZLib, IdCompressorZlib, untStonePgto,
       untMercadoLivre, untMercadoLivrePgto, untWalmart, untWalmartPgto,
       untTImportacaoCartao, untB2W, untB2WPgto, untKonciliaPgto,
       untMagazineLuiza, untMagazineLuizaPgto, untBanrisul, untBanrisulPgto,
       untTYapay, untYapay, untRedeCardAPIPgto,Registry, untAlpePgto,
       untLucreePgto,untPagarMePgto,
       EditFocus, untPagSeguroAPIPgto, untConcilAPIPgto, untCielo, untCieloPgto,
       untTCielo, untTGetNet, untGetNetPgto, untGetNet,
       {$IF Defined(VER270)}
       {$ELSE}
         System.Hash,untPagSeguroAPI,untConcilAPI,untTImportaPagamentosPagarMe,
         untTImportaPagamentosAlpe,untImportaPagamentosLucree,untRedeCardAPI,
         untStone,untKoncilia, untMadeiraMadeira, untMadeiraMadeiraPgto,
         untFuncoesSimples,untConfirmacaoDeCartoes,Uni,untConstantes,untSicredi,
         untSicrediPgto, untGranito, untGranitoPgto, untSipag, untSipagPgto,
         untSipagPgtoV2, untFiservBin, untFiservBinPgto, untShopeePayPgto,
         untShopeePay,
       {$IFEND}
     {$IFEND}
     {$WARN UNIT_PLATFORM OFF}
     FileCtrl,
     {$WARN UNIT_PLATFORM ON}
     ShellAPI, ShlObj, AppEvnts, Messages;

type
  TReport = class(TInterfacedObject, IReport)
  private
    FReport: TfrxReport;
    FAppEvents: TApplicationEvents;
  private
    procedure OnMessage(var Msg: tagMSG; var Handled: Boolean);
  public
    class function New(AReport: TfrxReport): IReport;
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
  public
    constructor Create;
    destructor Destroy; override;
  end;

type
   TThreadDirectoryExists = class(TThread)
   public type
     ExceptionClass = Class Of Exception;
     TTestResult = (trNoDirectory, trDirectoryExists, trTimeout);
   private
     FDirname: String;
     FErr    : String;
     FErrclass: ExceptionClass;
     FResult : Boolean;
   protected
     procedure Execute; override;
   public
     Function TestForDir( const dirname: String; timeoutMSecs: Dword): TTestResult;
   end;

  function fStrToFloat(strValorUnico: String): Double;
  function TryDirectoryExists(APath: string; ATimeoutSecs: Integer = 10): Boolean;
  function SafeFilePath(const FilePath: string): Boolean;
  function fTabelaExiste(strNomTab: String): Boolean;
  function fRetData(strData: String; blnColocaBarra: Boolean = True): Variant;
  function fRetHora(strHora: String; blnColocaPontos: Boolean = True): Variant;
  function fEmptyStr(strString: String): Boolean;
  function fSelecionaPasta: String;
  function fPegarVersaoSO(var MajorVersion, MinorVersion, Build: DWORD) : String;
  function fConverteParaAcento(strLinha: String): String; //solução provisória
  function fArquivoFolder(strNomCon: String; blnSalvar: Boolean = False): String;
  function RetornaEstruturaTabelaCaminhoArquivo:String;
  function RetornaCaminhoPastaDosArquivos(ANomCon:String):String;
  procedure SalvaCaminhoPastaDosArquivos(ANomCon,ACaminhoArquivos:String);
  procedure ImportarCaminhoPastaDosArquivos;

  function RetornaSequencial(ATabela: String; ACodEmp: String = ''):String;

  function RetornaSQLReplace(ANomeTabela: String;
                             ACamposDoModelo: TStringList;
                             ACamposIgnorados: Array of String): String;

  procedure CarregaRegistrosJaImportados(ANomeTabela: String;
                                         ACamposChavePrimaria: Array Of String;
                                         AValoresChavePrimaria: Array Of Variant);


  {$IF Defined(VER180)}
  {$ELSE}
    function fDecodeGZIPContent(RawBytes: TArray<Byte>): String;

    {$IF Defined(VER270)}
    {$ELSE}
    procedure pImportaStone(Aplicacao: HWND); StdCall;
    procedure pImportaConcilAPI(Aplicacao: HWND); StdCall;
    procedure pImportaPagSeguroAPI(Aplicacao: HWND); StdCall;
    procedure pImportaMadeiraMadeira(Aplicacao: HWND); StdCall;
    procedure pImportaPagarMe(Aplicacao: HWND); StdCall;
    procedure pImportaRedeCardAPI(Aplicacao: HWND); StdCall;
    procedure pImportaAlpe(Aplicacao: HWND); StdCall;
    procedure pImportaLucree(Aplicacao: HWND); StdCall;
    procedure pImportaKoncilia(Aplicacao: HWND; strAmbiente: String); StdCall;
    procedure pImportaKoncili(Aplicacao: HWND; strAmbiente: String); StdCall;
    procedure pShowConfirmacaoDeCartoes; StdCall;
    procedure pImportaSicredi(Aplicacao: HWND); StdCall;
    procedure pImportaGranito(Aplicacao: HWND); StdCall;
    procedure pIniciaEditorRelatorio(AObjetoEditor: ICartoesEditorRelatorios); StdCall;
    {$IFEND}

    procedure dxInitializeStone; StdCall;
    procedure pImportaCartoes(Aplicacao: HWND; strFolder: String; strNomCon: String; strNomEmp: String = ''); StdCall;
    function fRetOperadora(strNomCon: String): TImportacaoCartao;
    function fRetornaVersao(strNomArq: String = ''): String;
    function fRetornaAmbienteKoncilia(strCodEmp: String): String;
    function fRetSomenteNumeros(strTexto: String): String;

    function fRetornaHMACSHA512Stone(strCodEmp, strTextoValidacao: String): String;
    procedure pValidaLibsWebService;

    function fRetornaValorConfiguracao(strConfiguracao: String;
                                       strCodigoEmpresa: String = ''): String;
    function fRetornaValorConfiguracaoHub(strConfiguracao: String;
                                          strCodigoEmpresa: String): String;
    function ImportacaoSelecionandoArquivo(ANomCon,ACodEmp : String): Boolean;
    function RetornaNomeEmpresa(ACodEmp: String): String;

    procedure pImportaRedeMenil(Aplicacao: HWND; strNomEmp: String = ''); StdCall;

    function ArquivoValidoParaImportacao(arqArquivo: TSearchRec): Boolean;

    function RetornaBuildNumberVersaoWindows: Integer;
    procedure pExibirRelatorio(strNomPro, strDesPro: String; AReport: IReport);
    function fIPesqEmpresa(ASelf    : TForm;                           {* Formulário                                  *}
                           edtCodigo: TCustomEdit;                     {* Edit do Código                              *}
                           edtNomEmp: TEditFocus;                      {* Edit do Nome da Empresa                     *}
                           Var chrKey: Char): Boolean;

    function fIPesquisar(ASelf     : TForm;                          {* Formulário         *}
                        edtCodigo: TCustomEdit;                     {* Edit do Código     *}
                        edtDescri: TEditFocus;                      {* Edit Descrição     *}
                        Var chrKey: Char;
                        ACodPesquisa: String): Boolean;

    function PedirLiberacao(ADirAcesso:String; AMsgSenha:String;ATexto: String): Boolean;

    function ExisteScriptsDaCieloVersao015: Boolean;

    procedure pImportaCielo(Aplicacao: HWND); StdCall;

    procedure pImportaGetNet(Aplicacao: HWND); StdCall;
    procedure dxInitializeGetNet; StdCall;

    procedure pInstrucoesMercadoLivreIntegracao; stdcall;

    {$IF Defined(VER270)}
    {$ELSE}
    function CriarQueryDLL: TUniQuery;    function IncluirCartaoVenda(AAutoincremExtratoVenda: String): Boolean;
  {$IFEND}
    procedure ChamaConciliacaoCartoes(ANomCon: String);

    function AlterarCartaoVenda(AAutoincremCartao: String): Boolean;

  {$IFEND}

  function KeyIsDown(const Key: Integer): Boolean;
  function fStrZero(Zeros:string;Quant:integer):String;


  function IIF(blnCondicao: Boolean; varValorVerdadeiro, varValorFalso: Variant): Variant;
  function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime): TDateTime;
  function fEhFeriado(dtaDta: TDateTime): Boolean;
  function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True): Boolean;
  function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;

  procedure pVerificaIntegridade(strTabela: String);
  procedure pIniciaIntegacaoCartoes(objFunc: IIntegracaoCartoes); StdCall;
  procedure pSetProcPreviewReport(AProc: TProcPreviewReport); stdcall;
  procedure pSetFuncPesquisaEmpresa(AFunc: TFuncPesquisaEmpresa); stdcall;
  procedure pSetFuncPesquisa(AFunc: TFuncPesquisar); stdcall;
  procedure pSetFuncPedirLiberacao(AFunc: TFuncPedirLiberacao); stdcall;
  procedure pSetFuncCriarQueryDLL(AFunc: TFuncCriarQueryDLL); stdcall;
  procedure pSetFuncIncluirCartaoVenda(AFunc: TFuncIncluirCartaoVenda); stdcall;
  procedure pSetFuncAlterarCartaoVenda(AFunc: TFuncAlterarCartaoVenda); stdcall;
  procedure pSetProcChamaConciliacaoCartoes(AProc: TProcChamaConciliacaoCartoes); stdcall;
  procedure pVerificaTabelas; StdCall;
  procedure pImportaRede(Aplicacao: HWND; strNomEmp: String = ''); StdCall;
  procedure pImportaElavon(Aplicacao: HWND); StdCall;
  procedure pImportaEquals(Aplicacao: HWND); StdCall;
  procedure pImportaAmex(Aplicacao: HWND); StdCall;
  procedure pImportaChartCielo(Aplicacao: HWND); StdCall;
  procedure pImportaConcil(Aplicacao: HWND); StdCall;
  {$IF Defined(VER270) OR Defined(VER180)}
  {$ELSE}
  procedure pImportaSipag(Aplicacao: HWND); StdCall;
  {$ENDIF}
  function CorrigirTexto(const Texto: string): string;
  procedure pImportaSafrapay(Aplicacao: HWND); StdCall;
  procedure pImportaBoaVista(Aplicacao: HWND); StdCall;
  procedure pRenomeiaAquivo(strNomVel, strNomNov: String);
  procedure dxInitializeRedeCard; StdCall;
  procedure dxInitializeElavon; StdCall;
  procedure dxInitializeEquals; StdCall;
  procedure dxInitializeAmex; StdCall;
  procedure dxInitializeCielo; StdCall;
  procedure dxInitializeChartCielo; StdCall;
  procedure dxInitializeConcil; StdCall;
  procedure dxInitializeDefault; StdCall;
  procedure dxInitializeBoaVista; StdCall;
  {$IF Defined(VER270) OR Defined(VER180)}
  {$ELSE}
  function fTime() : TDateTime;
  function LocalTimeToUTC(const AValue: TDateTime): TDateTime;
  function TimeZoneLocal : Integer;
  function TimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  {$IFEND}

Var
  objFunctions           : IIntegracaoCartoes;
  FReg5                  : TArrRegistro5;
  FReg6                  : TArrRegistro6;
  FReg8                  : TArrRegistro8;
  FReg10                 : TArrRegistro10;
  FReg12                 : TArrRegistro12;
  FReg14                 : TArrRegistro14;
  FReg34                 : TArrRegistro34;
  FRegElaCred            : TArrRegistroElaCred;
  FRegElaPgto            : TArrRegistroElaPgto;
  FRegEquPgto            : TArrRegistroEquPgto;
  FRegEquAjus            : TArrRegistroEquPgto;
  FRegAmexPgto           : TArrRegistroAmexPgto;

  FRegBanesCardPgto      : TArrRegistroBanesCardPgto;
  FRegChartCieloPgto     : TArrRegistroChaPgto;
  FRegConcPgto           : TArrRegistroConcPgto;
  {$IF Defined(VER270) OR Defined(VER180)}
  {$ELSE}
  FRegSipagPgto          : TArrRegistroSipagPgto;
  FRegSipagPgtoV2        : TArrRegistroSipagPgtoV2;
  VS_EditorRelatorio     : ICartoesEditorRelatorios;
  {$ENDIF}
  FRegSafrapayPgto       : TArrRegistroSafrapayPgto;
  FRegRedeSitePgto       : TArrRegistroRedeSitePgto;
  FRegPagSeguroPgto      : TArrRegistroPagSeguroPgto;
  FRegBovPgto            : TArrRegistroBovPgto;

  FEstReg05              : TArrEstruturaReg05;
  FEstReg06              : TArrEstruturaCred;
  FEstReg08              : TArrEstruturaCred;
  FEstReg10              : TArrEstruturaCred;
  FEstReg12              : TArrEstruturaCred;
  FEstReg14              : TArrEstruturaCred;
  FEstReg34              : TArrEstruturaCred;
  FEstElaCred            : TArrEstruturaElaCred;
  FEstElaPgto            : TArrEstruturaElaPgto;
  FEstEquPgto            : TArrEstruturaEquPgto;
  FEstAmexPgto           : TArrEstruturaAmexPgto;
  FEstChartCieloPgto     : TArrEstruturaChaPgto;
  FEstConcPgto           : TArrEstruturaConcPgto;
  {$IF Defined(VER270) OR Defined(VER180)}
  {$ELSE}
  FEstSipagPgto          : TArrEstruturaSipagPgto;
  {$ENDIF}
  FEstSafrapayPgto       : TArrEstruturaSafrapayPgto;
  FEstRedeSitePgto       : TArrEstruturaRedeSitePgto;
  FEstPagSeguroPgto      : TArrEstruturaPagSeguroPgto;
  FEstBanesCardPgto      : TArrEstruturaBanesCardPgto;
  FEstBovPgto            : TArrEstruturaBovPgto;

  {$IF Defined(VER180)}
  {$ELSE}
    FRegStoneCred  : TArrRegistroStoCred;
    FRegStonePgto  : TArrRegistroStoPgto;
    FEstStoneCred  : TArrEstruturaStoCred;
    FEstStonePgto  : TArrEstruturaStoPgto;

    FRegCieloPgto    : TArrRegistroCieloPgto;
    FRegCieloPgto015 : TArrRegistroCieloPgto015;
    FEstCieloPgto    : TArrEstruturaCieloPgto;

    FRegGetNetPgto    : TArrRegistroGetNetPgto;
    FRegGetNetPgto10_1: TArrRegistroGetNetPgto10_1;
    FEstGetNetPgto    : TArrEstruturaGetNetPgto;

    {$IF Defined(VER270)}
    {$ELSE}
    FRegMadeiraMadeiraPgto  : TArrRegistroMadeiraMadeira;
    FRegistroSicrediMovimentoFinanceiro : TArrRegistroSicrediMovimentoFinanceiro;
    FRegistroSipagMovimentoFinanceiro   : TArrRegistroSipagMovimentoFinanceiro;
    FRegistroSipagMovimentoFinanceiroV2 : TArrRegistroSipagMovimentoFinanceiroV2;
    FRegistroGranitoMovimentoFinanceiro : TArrRegistroGranitoMovimentoFinanceiro;
    FRegistroFiservBinMovimentoFinanceiro : TArrRegistroFiservBinMovimentoFinanceiro;

    FEstShopeePayPgto : TArrEstruturaShopeePayPgto;
    FRegShopeePayPgto : TArrRegistroShopeePayPgto;
    FRegShopeePayPgtoPedido : TArrRegistroShopeePayPedidoPgto;
    FRegShopeePayPgtoRepasse : TArrRegistroShopeePayRepassePgto;
    {$IFEND}

    FRegMLPgto     : TArrRegistroMLPgto;
    FRegWalmartPgto: TArrRegistroWalmartPgto;
    FEstMLPgto     : TArrEstruturaMLPgto;
    FEstWalmartPgto: TArrEstruturaWalmartPgto;
    FEstB2WPgto    : TArrEstruturaB2WPgto;
    FRegB2WPgto    : TArrRegistroB2WPgto;
    FRegKonPgto    : TArrRegistroKonPgto;
    FEstKonPgto    : TArrEstruturaKonPgto;
    FEstruturaBanrisulPgto : TArrEstruturaBanrisulPgto;

    FRegMagazineLuizaPgto: TArrRegistroMagazineLuizaPgto;
    FEstMagazineLuizaPgto: TArrEstruturaMagazineLuizaPgto;

    FEstruturaRedeCardAPIPgto: TArrEstruturaRedeCardAPIPgto;

    FEstruturaAlpePgto: TArrEstruturaAlpePgto;
    FEstruturaPagarMePgto: TArrEstruturaPagarMePgto;
  {$IFEND}

  ProcPreviewReport: TProcPreviewReport;
  FuncPesquisaEmpresa : TFuncPesquisaEmpresa;
  FuncPesquisa : TFuncPesquisar;
  FuncPedirLiberacao : TFuncPedirLiberacao;
  FuncCriarQueryDLL : TFuncCriarQueryDLL;
  FuncIncluirCartaoVenda : TFuncIncluirCartaoVenda;
  FuncAlterarCartaoVenda : TFuncAlterarCartaoVenda;
  ProcChamaConciliacaoCartoes : TProcChamaConciliacaoCartoes;

  ProcChamaImportacaoLibCartoes: procedure(AArquivoDLL: String; ALayoutAPI: Boolean); StdCall;
  ProcChamaConciliacaoLibCartoes: procedure(AArquivoDLL: String; ALayoutAPI: Boolean); StdCall;

  lstEstabel     : TStringList;
  strFolderAplic : String;
  strFolderConcil: String;
  FRegistrosJaImportados: IDataset;
  FDatasPagamento:TStringList;

implementation

uses untRedeCard, untElavon, untAmex, DateUtils
{$IF Defined(VER180)}
{$ELSE}
, untRelCartaoImportacao
{$IFEND}
;


procedure dxInitializeDefault;
Begin
  dxInitialize;
End;

procedure dxInitializeRedeCard;
Begin
  dxInitialize;
End;

procedure dxInitializeElavon;
Begin
  dxInitialize;
End;

procedure dxInitializeEquals;
Begin
  dxInitialize;
End;

procedure dxInitializeAmex;
Begin
  dxInitialize;
End;

procedure dxInitializeCielo;
Begin
  dxInitialize;
End;

procedure dxInitializeChartCielo;
Begin
  dxInitialize;
End;

procedure dxInitializeConcil;
Begin
  dxInitialize;
End;

procedure dxInitializeBoaVista;
Begin
  dxInitialize;
End;

function KeyIsDown(const Key: Integer): Boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

function fStrZero(Zeros:string;Quant:integer):String;
Var
	I,Tamanho:integer;
	Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	If Aux[i] <> ',' Then
	  Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
  Zeros:=Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

{************************************}
{* TRANSFORMA STRING PARA DOUBLE    *}
{* QUANDO USAVA (S)TRTOFLOAT EM UM  *}
{* VALOR DE MILHAR EX 1.005,23      *}
{* OCORRIA ERRO POR CAUSA DO .      *}
{*********************************AF*}
function fStrToFloat(strValorUnico: String): Double;
Begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),0);
End;

procedure pIniciaIntegacaoCartoes(objFunc: IIntegracaoCartoes);
Begin
  objFunctions := objFunc;
End;

{$IF Defined(VER270) OR Defined(VER180)}
{$ELSE}
procedure pIniciaEditorRelatorio(AObjetoEditor: ICartoesEditorRelatorios); StdCall;
Begin
  VS_EditorRelatorio :=  AObjetoEditor;
End;
{$IFEND}

procedure pSetProcPreviewReport(AProc: TProcPreviewReport); stdcall;
begin
  ProcPreviewReport := AProc;
end;

procedure pSetFuncPesquisaEmpresa(AFunc: TFuncPesquisaEmpresa); stdcall;
begin
  FuncPesquisaEmpresa := AFunc;
end;

procedure pSetFuncPesquisa(AFunc: TFuncPesquisar); stdcall;
Begin
  FuncPesquisa := AFunc;
End;

procedure pSetFuncPedirLiberacao(AFunc: TFuncPedirLiberacao); stdcall;
Begin
  FuncPedirLiberacao := AFunc;
End;

procedure pSetFuncCriarQueryDLL(AFunc: TFuncCriarQueryDLL); stdcall;
Begin
  FuncCriarQueryDLL := AFunc;
End;

procedure pSetFuncIncluirCartaoVenda(AFunc: TFuncIncluirCartaoVenda); stdcall;
Begin
  FuncIncluirCartaoVenda := AFunc;
End;

procedure pSetFuncAlterarCartaoVenda(AFunc: TFuncAlterarCartaoVenda); stdcall;
Begin
  FuncAlterarCartaoVenda := AFunc;
End;

procedure pSetProcChamaConciliacaoCartoes(AProc: TProcChamaConciliacaoCartoes); stdcall;
Begin
  ProcChamaConciliacaoCartoes :=  AProc;
End;

procedure pVerificaTabelas;

  procedure pCriaTabela(strSQLCreate: String);
    Var
      qryGen: IDataSet;
  Begin
    Try
      qryGen := objFunctions.fGetDataSet;
      qryGen.SQL := strSQLCreate;
      qryGen.ExecSQL;
    Except
      Raise;
    End;
  End;

Begin

  If Not fTabelaExiste('ARQCON') Then
    pCriaTabela(RetornaEstruturaTabelaCaminhoArquivo);

  ImportarCaminhoPastaDosArquivos;

  If Not fTabelaExiste('RED_EVDR05') Then
    pCriaTabela(TRedeDebito.fRetSQLTabelaReg5)
  Else
  Begin
    FEstReg05 := TRedeDebito.fRetEstruturaReg05;
    pVerificaIntegridade('RED_EVDR05');
  End;

  If Not fTabelaExiste('RED_EVCR06') Then
    pCriaTabela(TRedeCredito.fRetSQLTabelaReg6)
  Else
  Begin
    FEstReg06 := TRedeCredito.fRetEstruturaCred('RED_EVCR06');
    pVerificaIntegridade('RED_EVCR06');
  End;

  If Not fTabelaExiste('RED_EVCR08') Then
    pCriaTabela(TRedeCredito.fRetSQLTabelaReg8)
  Else
  Begin
    FEstReg08 := TRedeCredito.fRetEstruturaCred('RED_EVCR08');
    pVerificaIntegridade('RED_EVCR08');
  End;

  If Not fTabelaExiste('RED_EVCR10') Then
    pCriaTabela(TRedeCredito.fRetSQLTabelaReg10)
  Else
  Begin
    FEstReg10 := TRedeCredito.fRetEstruturaCred('RED_EVCR10');
    pVerificaIntegridade('RED_EVCR10');
  End;

  If Not fTabelaExiste('RED_EVCR12') Then
    pCriaTabela(TRedeCredito.fRetSQLTabelaReg12)
  Else
  Begin
    FEstReg12 := TRedeCredito.fRetEstruturaCred('RED_EVCR12');
    pVerificaIntegridade('RED_EVCR12');
  End;

  If Not fTabelaExiste('RED_EVCR14') Then
    pCriaTabela(TRedeCredito.fRetSQLTabelaReg14)
  Else
  Begin
    FEstReg14 := TRedeCredito.fRetEstruturaCred('RED_EVCR14');
    pVerificaIntegridade('RED_EVCR14');
  End;

  If Not fTabelaExiste('RED_EFIR34') Then
    pCriaTabela(TRedeCredito.fRetSQLTabelaReg34)
  Else
  Begin
    FEstReg34 := TRedeCredito.fRetEstruturaCred('RED_EFIR34');
    pVerificaIntegridade('RED_EFIR34');
  End;

  If Not fTabelaExiste('ELA_EVCRED') Then
    pCriaTabela(TElavonCredito.fRetSQLTabelaRegCred('ELA_EVCRED'))
  Else
  Begin
    FEstElaCred := TElavonCredito.fRetEstruturaCred('ELA_EVCRED');
    pVerificaIntegridade('ELA_EVCRED');
  End;

  If Not fTabelaExiste('ELA_EVPGTO') Then
    pCriaTabela(TElavonPagto.fRetSQLTabelaRegPgto('ELA_EVPGTO'))
  Else
  Begin
    FEstElaPgto := TElavonPagto.fRetEstruturaPgto('ELA_EVPGTO');
    pVerificaIntegridade('ELA_EVPGTO');
  End;

  If Not fTabelaExiste('EQU_EQPGTO') Then
    pCriaTabela(TEqualsPagto.fRetSQLTabelaRegPgto('EQU_EQPGTO'))
  Else
  Begin
    FEstEquPgto := TEQualsPagto.fRetEstruturaPgto('EQU_EQPGTO');
    pVerificaIntegridade('EQU_EQPGTO');
  End;

  If Not fTabelaExiste('AME_AMPGTO') Then
    pCriaTabela(TAmexPgto.fRetSQLTabelaRegPgto('AME_AMPGTO'))
  Else
  Begin
    FEstAmexPgto := TAmexPgto.fRetEstruturaPgto('AME_AMPGTO');
    pVerificaIntegridade('AME_AMPGTO');
  End;

  If Not fTabelaExiste('CHA_CIPGTO') Then
    pCriaTabela(TChartCieloPgto.fRetSQLTabelaRegPgto('CHA_CIPGTO'))
  Else
  Begin
    FEstChartCieloPgto := TChartCieloPgto.fRetEstruturaPgto('CHA_CIPGTO');
    pVerificaIntegridade('CHA_CIPGTO');
  End;

  If Not fTabelaExiste('CON_COPGTO') Then
    pCriaTabela(TConcilPgto.fRetSQLTabelaRegPgto('CON_COPGTO'))
  Else
  Begin
    FEstConcPgto := TConcilPgto.fRetEstruturaPgto('CON_COPGTO');
    pVerificaIntegridade('CON_COPGTO');
  End;

  {$IF Defined(VER270) OR Defined(VER180)}
  {$ELSE}
  If Not fTabelaExiste('SIP_SIPGTO') Then
    pCriaTabela(TSipagPgto.fRetSQLTabelaRegPgto('SIP_SIPGTO'))
  Else
  Begin
    FEstSipagPgto := TSipagPgto.fRetEstruturaPgto('SIP_SIPGTO');
    pVerificaIntegridade('SIP_SIPGTO');
  End;
  {$ENDIF}

  If Not fTabelaExiste('SAF_SAPGTO') Then
    pCriaTabela(TSafrapayPgto.fRetSQLTabelaRegPgto('SAF_SAPGTO'))
  Else
  Begin
    FEstSafrapayPgto := TSafrapayPgto.fRetEstruturaPgto('SAF_SAPGTO');
    pVerificaIntegridade('SAF_SAPGTO');
  End;

  If Not fTabelaExiste('RED_SITPGTO') Then
    pCriaTabela(TRedeSitePgto.fRetSQLTabelaRegPgto('RED_SITPGTO'))
  Else
  Begin
    FEstRedeSitePgto := TRedeSitePgto.fRetEstruturaPgto('RED_SITPGTO');
    pVerificaIntegridade('RED_SITPGTO');
  End;

  If Not fTabelaExiste('PAG_SEPGTO') Then
    pCriaTabela(TPagSeguroPgto.fRetSQLTabelaRegPgto('PAG_SEPGTO'))
  Else
  Begin
    FEstPagSeguroPgto := TPagSeguroPgto.fRetEstruturaPgto('PAG_SEPGTO');
    pVerificaIntegridade('PAG_SEPGTO');
  End;

  If Not fTabelaExiste('BAN_BAPGTO') Then
    pCriaTabela(TBanesCardPgto.fRetSQLTabelaRegPgto('BAN_BAPGTO'))
  Else
  Begin
    FEstBanesCardPgto := TBanesCardPgto.fRetEstruturaPgto('BAN_BAPGTO');
    pVerificaIntegridade('BAN_BAPGTO');
  End;
 {$IF Defined(VER180)}
 {$ELSE}
  If Not fTabelaExiste('CIE_CIPGTO') Then
    pCriaTabela(TCieloPgto.fRetSQLTabelaRegPgto('CIE_CIPGTO'))
  Else
  Begin
    FEstCieloPgto := TCieloPgto.fRetEstruturaPgto('CIE_CIPGTO');
    pVerificaIntegridade('CIE_CIPGTO');
  End;

  If Not fTabelaExiste('GET_GEPGTO') Then
    pCriaTabela(TGetNetPgto.fRetSQLTabelaRegPgto('GET_GEPGTO'))
  Else
  Begin
    FEstGetNetPgto := TGetNetPgto.fRetEstruturaPgto('GET_GEPGTO');
    pVerificaIntegridade('GET_GEPGTO');
  End;
  {$IFEND}
  If Not fTabelaExiste('BOV_BOPGTO') Then
    pCriaTabela(TBoaVistaPgto.fRetSQLTabelaRegPgto('BOV_BOPGTO'))
  Else
  Begin
    FEstBovPgto := TBoaVistaPgto.fRetEstruturaPgto('BOV_BOPGTO');
    pVerificaIntegridade('BOV_BOPGTO');
  End;

  {$IF Defined(VER180)}
  {$ELSE}
    If Not fTabelaExiste('MER_MLPGTO') Then
      pCriaTabela(TMercadoLivrePgto.fRetSQLTabelaRegPgto('MER_MLPGTO'))
    Else
    Begin
      FEstMLPgto := TMercadoLivrePgto.fRetEstruturaPgto('MER_MLPGTO');
      pVerificaIntegridade('MER_MLPGTO');
    End;

    If Not fTabelaExiste('WAL_WAPGTO') Then
      pCriaTabela(TWalmartPgto.fRetSQLTabelaRegPgto('WAL_WAPGTO'))
    Else
    Begin
      FEstWalmartPgto := TWalmartPgto.fRetEstruturaPgto('WAL_WAPGTO');
      pVerificaIntegridade('WAL_WAPGTO');
    End;

   If Not fTabelaExiste('B2W_B2PGTO') Then
      pCriaTabela(TB2WPgto.fRetSQLTabelaRegPgto('B2W_B2PGTO'))
    Else
    Begin
      FEstB2WPgto := TB2WPgto.fRetEstruturaPgto('B2W_B2PGTO');
      pVerificaIntegridade('B2W_B2PGTO');
    End;

    If Not fTabelaExiste('STO_STPGTO') Then
      pCriaTabela(TStonePgto.fRetSQLTabelaRegPgto('STO_STPGTO'))
    Else
    Begin
      FEstStonePgto := TStonePgto.fRetEstruturaPgto('STO_STPGTO');
      pVerificaIntegridade('STO_STPGTO');
    End;

    If Not fTabelaExiste('STO_STCRED') Then
      pCriaTabela(TStonePgto.fRetSQLTabelaRegCred('STO_STCRED'))
    Else
    Begin
      FEstStoneCred := TStonePgto.fRetEstruturaCred('STO_STCRED');
      pVerificaIntegridade('STO_STCRED');
    End;

    If Not fTabelaExiste('BAN_BSVEND') Then
      pCriaTabela(TBanrisulPgto.fRetSQLTabelaRegPgto('BAN_BSVEND'))
    Else
    Begin
      FEstruturaBanrisulPgto := TBanrisulPgto.fRetEstruturaPgto('BAN_BSVEND');
      pVerificaIntegridade('BAN_BSVEND');
    End;

    If Not fTabelaExiste('BAN_BSCRED') Then
      pCriaTabela(TBanrisulPgto.fRetSQLTabelaRegPgto('BAN_BSCRED'))
    Else
    Begin
      FEstruturaBanrisulPgto := TBanrisulPgto.fRetEstruturaPgto('BAN_BSCRED');
      pVerificaIntegridade('BAN_BSCRED');
    End;

    If Not fTabelaExiste('BAN_BSPGTO') Then
      pCriaTabela(TBanrisulPgto.fRetSQLTabelaRegPgto('BAN_BSPGTO'))
    Else
    Begin
      FEstruturaBanrisulPgto := TBanrisulPgto.fRetEstruturaPgto('BAN_BSPGTO');
      pVerificaIntegridade('BAN_BSPGTO');
    End;

    If Not fTabelaExiste('BAN_BSANTE') Then
      pCriaTabela(TBanrisulPgto.fRetSQLTabelaRegPgto('BAN_BSANTE'))
    Else
    Begin
      FEstruturaBanrisulPgto := TBanrisulPgto.fRetEstruturaPgto('BAN_BSANTE');
      pVerificaIntegridade('BAN_BSANTE');
    End;

    If Not fTabelaExiste('RED_APPGTO') Then
      pCriaTabela(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_APPGTO'))
    Else
    Begin
      FEstruturaRedeCardAPIPgto := TRedeCardAPIPgto.fRetEstruturaPgto('RED_APPGTO');
      pVerificaIntegridade('RED_APPGTO');
    End;

    If Not fTabelaExiste('PGM_PMPGTO') Then
      pCriaTabela(TPagarMePgto.fRetSQLTabelaRegPgto('PGM_PMPGTO'))
    Else
    Begin
      FEstruturaPagarMePgto := TPagarMePgto.fRetEstruturaPgto('PGM_PMPGTO');
      pVerificaIntegridade('PGM_PMPGTO');
    End;

    If Not fTabelaExiste('PGM_PMVEND') Then
      pCriaTabela(TPagarMePgto.fRetSQLTabelaRegPgto('PGM_PMVEND'))
    Else
    Begin
      FEstruturaPagarMePgto := TPagarMePgto.fRetEstruturaPgto('PGM_PMVEND');
      pVerificaIntegridade('PGM_PMVEND');
    End;

     If Not fTabelaExiste('PGM_PMCOBR') Then
      pCriaTabela(TPagarMePgto.fRetSQLTabelaRegPgto('PGM_PMCOBR'))
    Else
    Begin
      FEstruturaPagarMePgto := TPagarMePgto.fRetEstruturaPgto('PGM_PMCOBR');
      pVerificaIntegridade('PGM_PMCOBR');
    End;

    If Not fTabelaExiste('PGM_PMRECE') Then
      pCriaTabela(TPagarMePgto.fRetSQLTabelaRegPgto('PGM_PMRECE'))
    Else
    Begin
      FEstruturaPagarMePgto := TPagarMePgto.fRetEstruturaPgto('PGM_PMRECE');
      pVerificaIntegridade('PGM_PMRECE');
    End;

    If Not fTabelaExiste('PGM_PMTRAN') Then
      pCriaTabela(TPagarMePgto.fRetSQLTabelaRegPgto('PGM_PMTRAN'))
    Else
    Begin
      FEstruturaPagarMePgto := TPagarMePgto.fRetEstruturaPgto('PGM_PMTRAN');
      pVerificaIntegridade('PGM_PMTRAN');
    End;

    If Not fTabelaExiste('ALP_ALPGTO') Then
      pCriaTabela(TAlpePgto.fRetSQLTabelaRegPgto('ALP_ALPGTO'))
    Else
    Begin
      FEstruturaAlpePgto := TAlpePgto.fRetEstruturaPgto('ALP_ALPGTO');
      pVerificaIntegridade('ALP_ALPGTO');
    End;

    If Not fTabelaExiste('RED_APVEND') Then
      pCriaTabela(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_APVEND'))
    Else
    Begin
      FEstruturaRedeCardAPIPgto := TRedeCardAPIPgto.fRetEstruturaPgto('RED_APVEND');
      pVerificaIntegridade('RED_APVEND');
    End;

     If Not fTabelaExiste('RED_APAJUS') Then
      pCriaTabela(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_APAJUS'))
    Else
    Begin
      FEstruturaRedeCardAPIPgto := TRedeCardAPIPgto.fRetEstruturaPgto('RED_APAJUS');
      pVerificaIntegridade('RED_APAJUS');
    End;

     If Not fTabelaExiste('RED_PGODIR') Then
      pCriaTabela(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_PGODIR'))
    Else
    Begin
      FEstruturaRedeCardAPIPgto := TRedeCardAPIPgto.fRetEstruturaPgto('RED_PGODIR');
      pVerificaIntegridade('RED_PGODIR');
    End;

    If Not fTabelaExiste('RED_APVPAR') Then
      pCriaTabela(TRedeCardAPIPgto.fRetSQLTabelaRegPgto('RED_APVPAR'))
    Else
    Begin
      FEstruturaRedeCardAPIPgto := TRedeCardAPIPgto.fRetEstruturaPgto('RED_APVPAR');
      pVerificaIntegridade('RED_APVPAR');
    End;

    If Not fTabelaExiste('PAG_APPGTO') Then
      pCriaTabela(TPagSeguroAPIPgto.fRetSQLTabelaRegPgto('PAG_APPGTO'));

    {$IF Defined(VER270)}
    {$ELSE}
    If Not fTabelaExiste('MAD_APPGTO') Then
      pCriaTabela(TMadeiraMadeiraPgto.fRetSQLTabelaRegPgto);

    If Not fTabelaExiste('SHO_SHPGTO') Then
      pCriaTabela(TShopeePayPgto.fRetSQLTabelaRegPgto('SHO_SHPGTO'))
    Else
    Begin
      FEstShopeePayPgto := TShopeePayPgto.fRetEstruturaPgto('SHO_SHPGTO');
      pVerificaIntegridade('SHO_SHPGTO');
    End;

    If Not fTabelaExiste('SHO_SHAJUS') Then
      pCriaTabela(TShopeePayPgto.fRetSQLTabelaRegPgto('SHO_SHAJUS'))
    Else
    Begin
      FEstShopeePayPgto := TShopeePayPgto.fRetEstruturaPgto('SHO_SHAJUS');
      pVerificaIntegridade('SHO_SHAJUS');
    End;
    {$IFEND}

    If Not fTabelaExiste('CON_APPGTO') Then
      pCriaTabela(TConcilAPIPgto.fRetSQLTabelaRegPgto('CON_APPGTO'));

    If Not fTabelaExiste('CON_APAJUS') Then
      pCriaTabela(TConcilAPIPgto.fRetSQLTabelaRegPgto('CON_APAJUS'));

  {$IFEND}
End;

function fTabelaExiste(strNomTab: String): Boolean;
  Var
    qryGen: IDataSet;
Begin
  qryGen := objFunctions.fGetDataSet;
  qryGen.SQL := 'SHOW TABLES LIKE ' + QuotedStr(strNomTab);
  qryGen.Open;
  Result := Not qryGen.IsEmpty;
End;

function fRetData(strData: String; blnColocaBarra: Boolean = True): Variant;
Begin
  Try
    If blnColocaBarra Then
    Begin
      Insert('/', strData, 3);
      Insert('/', strData, 6);
    End;

    Result := StrToDate(strData);
  Except
    Result := Null;
  End;
End;

function fRetHora(strHora: String; blnColocaPontos: Boolean = True): Variant;
Begin
  Try
    If blnColocaPontos Then
    Begin
      Insert(':', strHora, 3);
      Insert(':', strHora, 6);
    End;

    Result := StrToTime(strHora);
  Except
    Result := Null;
  End;
End;

{*************************************}
{* VERIFICA SE UMA STRING ESTA VAZIA *}
{**********************************AF*}
function fEmptyStr(strString: String): Boolean;
begin
  Result := False;

  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');

  If AnsiReplaceText(strString, ' ', '') = '' Then
    Result := True;
end;

procedure pImportaRede(Aplicacao: HWND; strNomEmp: String = '');
  Var
    objRede: TRedeCard;
Begin
  objRede := TRedeCard.Create(Nil);
  objRede.Aplicacao := Aplicacao;
  objRede.strNomEmp := strNomEmp;
  objRede.pSelecionaFonte;
End;

procedure pImportaElavon(Aplicacao: HWND);
  Var
    objElavon: TElavon;
Begin
  objElavon := TElavon.Create(Nil);
  objElavon.Aplicacao := Aplicacao;
  objElavon.pSelecionaFonte;
End;

procedure pImportaEquals(Aplicacao: HWND);
  Var
    objEquals: TEquals;
Begin
  objEquals := TEquals.Create(Nil);
  objEquals.Aplicacao := Aplicacao;
  objEquals.pSelecionaFonte;
End;

procedure pImportaAmex(Aplicacao: HWND);
  Var
    objAmex: TAmex;
Begin
  objAmex := TAmex.Create(Nil);
  objAmex.Aplicacao := Aplicacao;
  objAmex.pSelecionaFonte;
End;

procedure pImportaChartCielo(Aplicacao: HWND);
  Var
    objChartCielo: TChartCielo;
Begin
  objChartCielo := TChartCielo.Create(Nil);
  objChartCielo.Aplicacao := Aplicacao;
  objChartCielo.pSelecionaFonte;
End;

procedure pImportaConcil(Aplicacao: HWND);
  Var
    objConcil: TConcil;
Begin
  objConcil := TConcil.Create(Nil);
  objConcil.Aplicacao := Aplicacao;
  objConcil.pSelecionaFonte;
End;

{$IF Defined(VER270) OR Defined(VER180)}
{$ELSE}
procedure pImportaSipag(Aplicacao: HWND);
  Var
    objSipag: TSipag;
Begin
  objSipag := TSipag.Create(Nil);
  objSipag.Aplicacao := Aplicacao;
  objSipag.pSelecionaFonte;
End;
{$ENDIF}

function CorrigirTexto(const Texto: string): string;
begin
  Result := Texto;

  // Correções de caracteres comuns de codificação UTF-8 para ANSI
  Result := StringReplace(Result, 'Ã©', 'é', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã¨', 'è', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ãª', 'ê', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã´', 'ô', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã³', 'ó', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ãº', 'ú', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã§', 'ç', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã£', 'ã', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã', 'á', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã‰', 'É', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'ÃŠ', 'Ê', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ãš', 'Ú', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã“', 'Ó', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã”', 'Ô', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Ã‡', 'Ç', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, 'Â', '', [rfReplaceAll, rfIgnoreCase]); // Remove â excessivo
  Result := StringReplace(Result, 'Â°', '°', [rfReplaceAll, rfIgnoreCase]); // Símbolo de grau
  Result := StringReplace(Result, 'â€™', '’', [rfReplaceAll, rfIgnoreCase]); // Apóstrofo correto
  Result := StringReplace(Result, 'â€œ', '“', [rfReplaceAll, rfIgnoreCase]); // Aspas iniciais
  Result := StringReplace(Result, 'â€', '”', [rfReplaceAll, rfIgnoreCase]); // Aspas finais

  // Adicione mais substituições conforme necessário
end;

procedure pImportaSafrapay(Aplicacao: HWND);
  Var
    objSafrapay: TSafrapay;
Begin
  objSafrapay := TSafrapay.Create(Nil);
  objSafrapay.Aplicacao := Aplicacao;
  objSafrapay.pSelecionaFonte;
End;

procedure pImportaBoaVista(Aplicacao: HWND);
  Var
    objBoaVista: TBoaVista;
Begin
  objBoaVista := TBoaVista.Create(Nil);
  objBoaVista.Aplicacao := Aplicacao;
  objBoaVista.pSelecionaFonte;
End;

procedure pRenomeiaAquivo(strNomVel, strNomNov: String);
Begin
  RenameFile(strNomVel, strNomNov);
End;

{***********************************************}
{* VERIFICA SE AS TABELAS AUXILIARES ESTÃO COM *}
{* A MESMA ESTRUTURA NO BANCO DE DADOS E NA DLL*}
{*REQ. 32397 31/03/2015**********************JU*}
procedure pVerificaIntegridade(strTabela: String);
  Var
    strSQL     : String;
    intContador: Integer;
    qryGen     : IDataSet;

  {*************************************}
  {* ATUALIZA TABELA NO BANCO DE DADOS *}
  {*REQ. 32397 31/03/2015************JU*}
  procedure pAlteraTabela(strTabela, strNomCam, strTipCam: String; blnModify: Boolean);
    Var
      strSQL     : String;
      qryAlter   : IDataSet;
  Begin

    Try
      qryAlter := objFunctions.fGetDataSet;

      strSQL := '';
      strSQL := strSQL + 'ALTER TABLE ';
      strSQL := strSQL + strTabela;

      If blnModify Then
        strSQL := strSQL + ' MODIFY COLUMN '
      Else
        strSQL := strSQL + ' ADD ';

      strSQL := strSQL + strNomCam;
      strSQL := strSQL + ' ';
      strSQL := strSQL + strTipCam;
      With qryAlter Do
      Begin
        SQL := strSQL;
        ExecSQL;
      End;

    Finally

    End;

  End;

begin
  Exit;  // ALTERAÇÃO DE TABELA SÓ PELA DIARIO  REQ: 242841


  Try
    qryGen := objFunctions.fGetDataSet;

    Try
      {***************************************************************}
      {* DESCRIÇÃO DAS TABELAS ORIGINAIS COMO ESTÁ NO BANCO DE DADOS *}
      {*REQ. 32397 31/03/2015**************************************JU*}
      strSQL := '';
      strSQL := strSQL + 'DESCRIBE ';
      strSQL := strSQL + strTabela;
      With qryGen Do
      Begin
        SQL := strSQL;
        Open;
      End;

      {**************************************************************}
      {* PERCORRE OS ARRAYS COM A ESTRUTURA DAS TABELAS ATUALIZADAS *}
      {* SEMPRE QUE HOUVER ALTERÇÃO EM ALGUMA DAS TABELAS ATUALIZAR *}
      {* A FUNÇÃO CORRESPONDENTE QUE TRAZ A ESTRUTURA               *}
      {*REQ. 32397 31/03/2015*************************************JU*}
      If strTabela = 'RED_EVDR05' Then
      Begin

        For intContador := 0 To Length(FEstReg05) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstReg05[intContador].strDescri, []) Then
          Begin

            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstReg05[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstReg05[intContador].strDescri, FEstReg05[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstReg05[intContador].strDescri, FEstReg05[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'RED_EVCR06' Then
      Begin

        For intContador := 0 To Length(FEstReg06) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstReg06[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstReg06[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstReg06[intContador].strDescri, FEstReg06[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstReg06[intContador].strDescri, FEstReg06[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'RED_EVCR08' Then
      Begin

        For intContador := 0 To Length(FEstReg08) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstReg08[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstReg08[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstReg08[intContador].strDescri, FEstReg08[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstReg08[intContador].strDescri, FEstReg08[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'RED_EVCR10' Then
      Begin

        For intContador := 0 To Length(FEstReg10) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstReg10[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstReg10[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstReg10[intContador].strDescri, FEstReg10[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstReg10[intContador].strDescri, FEstReg10[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'RED_EVCR12' Then
      Begin

        For intContador := 0 To Length(FEstReg12) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstReg12[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> (FEstReg12[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstReg12[intContador].strDescri, FEstReg12[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstReg12[intContador].strDescri, FEstReg12[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'RED_EVCR14' Then
      Begin

        For intContador := 0 To Length(FEstReg14) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstReg14[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstReg14[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstReg14[intContador].strDescri, FEstReg14[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstReg14[intContador].strDescri, FEstReg14[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'RED_EFIR34' Then
      Begin

        For intContador := 0 To Length(FEstReg34) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstReg34[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstReg34[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstReg34[intContador].strDescri, FEstReg34[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstReg34[intContador].strDescri, FEstReg34[intContador].strTipCmp, False);
        End;
      End
      Else If strTabela = 'ELA_EVCRED' Then
      Begin

      End
      Else If strTabela = 'ELA_EVCRED' Then
      Begin

        For intContador := 0 To Length(FEstElaCred) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstElaCred[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstElaCred[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstElaCred[intContador].strDescri, FEstElaCred[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstElaCred[intContador].strDescri, FEstElaCred[intContador].strTipCmp, False);
        End;
      End
      Else If strTabela = 'ELA_EVPGTO' Then
      Begin

        For intContador := 0 To Length(FEstElaPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstElaPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstElaPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstElaPgto[intContador].strDescri, FEstElaPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstElaPgto[intContador].strDescri, FEstElaPgto[intContador].strTipCmp, False);
         End;
      End
      Else If strTabela = 'EQU_EQPGTO' Then
      Begin

        For intContador := 0 To Length(FEstEquPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstEquPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstEquPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstEquPgto[intContador].strDescri, FEstEquPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstEquPgto[intContador].strDescri, FEstEquPgto[intContador].strTipCmp, False);
         End;
      End
      Else If strTabela = 'AME_AMPGTO' Then
      Begin

        For intContador := 0 To Length(FEstAmexPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstAmexPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstAmexPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstAmexPgto[intContador].strDescri, FEstAmexPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstAmexPgto[intContador].strDescri, FEstAmexPgto[intContador].strTipCmp, False);
        End;
      End
      Else If strTabela = 'CHA_CIPGTO' Then
      Begin

        For intContador := 0 To Length(FEstChartCieloPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstChartCieloPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstChartCieloPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstChartCieloPgto[intContador].strDescri, FEstChartCieloPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstChartCieloPgto[intContador].strDescri, FEstChartCieloPgto[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'CON_COPGTO' Then
      Begin

        For intContador := 0 To Length(FEstConcPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstConcPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstConcPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstConcPgto[intContador].strDescri, FEstConcPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstConcPgto[intContador].strDescri, FEstConcPgto[intContador].strTipCmp, False);
        End;

      End
    {$IF Defined(VER270) OR Defined(VER180)}
    {$ELSE}
      Else If strTabela = 'SIP_SIPGTO' Then
      Begin

        For intContador := 0 To Length(FEstSipagPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstSipagPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstSipagPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstSipagPgto[intContador].strDescri, FEstSipagPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstSipagPgto[intContador].strDescri, FEstSipagPgto[intContador].strTipCmp, False);
        End;

      End
    {$ENDIF}
      Else If strTabela = 'SAF_SAPGTO' Then
      Begin

        For intContador := 0 To Length(FEstSafrapayPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstSafrapayPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstSafrapayPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstSafrapayPgto[intContador].strDescri, FEstSafrapayPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstSafrapayPgto[intContador].strDescri, FEstSafrapayPgto[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'PAG_SEPGTO' Then
      Begin

        For intContador := 0 To Length(FEstPagSeguroPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstPagSeguroPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstPagSeguroPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstPagSeguroPgto[intContador].strDescri, FEstPagSeguroPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstPagSeguroPgto[intContador].strDescri, FEstPagSeguroPgto[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'BAN_BAPGTO' Then
      Begin

        For intContador := 0 To Length(FEstBanesCardPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstBanesCardPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstBanesCardPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstBanesCardPgto[intContador].strDescri, FEstBanesCardPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstBanesCardPgto[intContador].strDescri, FEstBanesCardPgto[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'RED_SITPGTO' Then
      Begin

        For intContador := 0 To Length(FEstRedeSitePgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstRedeSitePgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstRedeSitePgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstRedeSitePgto[intContador].strDescri, FEstRedeSitePgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstRedeSitePgto[intContador].strDescri, FEstRedeSitePgto[intContador].strTipCmp, False);
        End;

      {$IF Defined(VER180)}
      {$ELSE}
      End
      Else If strTabela = 'MER_MLPGTO' Then
      Begin

        For intContador := 0 To Length(FEstMLPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstMLPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstMLPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstMLPgto[intContador].strDescri, FEstMLPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstMLPgto[intContador].strDescri, FEstMLPgto[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'WAL_WAPGTO' Then
      Begin

        For intContador := 0 To Length(FEstWalmartPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstWalmartPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstWalmartPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstWalmartPgto[intContador].strDescri, FEstWalmartPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstWalmartPgto[intContador].strDescri, FEstWalmartPgto[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'B2W_B2PGTO' Then
      Begin

        For intContador := 0 To Length(FEstB2WPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstB2WPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstB2WPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstB2WPgto[intContador].strDescri, FEstB2WPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstB2WPgto[intContador].strDescri, FEstB2WPgto[intContador].strTipCmp, False);
        End;

      End
      Else If strTabela = 'STO_STPGTO' Then
      Begin

        For intContador := 0 To Length(FEstStonePgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstStonePgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstStonePgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstStonePgto[intContador].strDescri, FEstStonePgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstStonePgto[intContador].strDescri, FEstStonePgto[intContador].strTipCmp, False);
        End;
      End
      Else If strTabela = 'STO_STCRED' Then
      Begin

        For intContador := 0 To Length(FEstStoneCred) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstStoneCred[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstStoneCred[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstStoneCred[intContador].strDescri, FEstStoneCred[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstStoneCred[intContador].strDescri, FEstStoneCred[intContador].strTipCmp, False);
        End;
      end
      Else If (strTabela = 'BAN_BSVEND') or
              (strTabela = 'BAN_BSCRED') or
              (strTabela = 'BAN_BSPGTO') or
              (strTabela = 'BAN_BSANTE') Then
      Begin
        For intContador := 0 To Length(FEstruturaBanrisulPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstruturaBanrisulPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstruturaBanrisulPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstruturaBanrisulPgto[intContador].strDescri, FEstruturaBanrisulPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstruturaBanrisulPgto[intContador].strDescri, FEstruturaBanrisulPgto[intContador].strTipCmp, False);
        End;
      End
      Else If strTabela = 'CIE_CIPGTO' Then
      Begin

        For intContador := 0 To Length(FEstCieloPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstCieloPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstCieloPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstCieloPgto[intContador].strDescri, FEstCieloPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstCieloPgto[intContador].strDescri, FEstCieloPgto[intContador].strTipCmp, False);
        End;
      End
      Else If strTabela = 'GET_GEPGTO' Then
      Begin

        For intContador := 0 To Length(FEstGetNetPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstGetNetPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstGetNetPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstGetNetPgto[intContador].strDescri, FEstGetNetPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstGetNetPgto[intContador].strDescri, FEstGetNetPgto[intContador].strTipCmp, False);
        End;
      {$IFEND}
      End
      Else If strTabela = 'BOV_BOPGTO' Then
      Begin

        For intContador := 0 To Length(FEstBovPgto) - 1 Do
        Begin
          If qryGen.Locate('Field', FEstBovPgto[intContador].strDescri, []) Then
          Begin
            If UpperCase(qryGen.FieldByName('Type').AsString) <> UpperCase(FEstBovPgto[intContador].strTipCmp) Then
              pAlteraTabela(strTabela, FEstBovPgto[intContador].strDescri, FEstBovPgto[intContador].strTipCmp, True);
          End
          Else
            pAlteraTabela(strTabela, FEstBovPgto[intContador].strDescri, FEstBovPgto[intContador].strTipCmp, False);
         End;
      End

    Except
      Raise;
    End;

  Finally

  End;

End;

function  fSelecionaPasta: String;
Var
  dlgPasta: TCustomFileOpenDialog;
  MajorVersion, MinorVersion, Build: DWORD;
begin
  fPegarVersaoSO(MajorVersion, MinorVersion, Build);

  //Pego a versão mais recente, pois o componente de seleção de pasta
  //com versão mais agradável só está disponível a partir do Windows Vista.
  if  MajorVersion >= 6 then
  begin
    dlgPasta := TCustomFileOpenDialog.Create(nil);
    dlgPasta.Options := [fdoPickFolders];

    If dlgPasta.Execute Then
      Result := dlgPasta.FileName;

    FreeAndNil(dlgPasta);
  end
  else
    SelectDirectory('', Result, Result, [sdNewUI, sdShowEdit], nil);
end;

function fPegarVersaoSO(var MajorVersion, MinorVersion, Build: DWORD) : String;
var
  VersionInfo: TOSVersionInfo;
  vPlatform: string;
begin
  VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);
  GetVersionEx(VersionInfo);

  with VersionInfo do
  begin
    case dwPlatformId of
      VER_PLATFORM_WIN32s:
        vPlatform := 'Windows 3x';
      VER_PLATFORM_WIN32_WINDOWS:
        vPlatform := 'Windows 95';
      VER_PLATFORM_WIN32_NT:
        vPlatform := 'Windows NT';
    end;

    MajorVersion := dwMajorVersion;
    MinorVersion := dwMinorVersion;
    Build := dwBuildNumber;

    Result := vPlatform;
  end;
end;

function fConverteParaAcento(strLinha: String): String;
  Function fRetiraAspaSimples(strTexto:String):String;
  var
    intCont: Integer;
  begin
    Result := '';
    For intCont := 1 To Length(strTexto) do
    begin
      If Copy(strTexto, intCont, 1) <> Chr(39) then
        Result := Result + Copy(strTexto, intCont, 1);
    end;
  end;

Begin
  Result := fRetiraAspaSimples(strLinha);
  Result := StringReplace(Result, 'Ã§Ã£', 'çã', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ãª', 'ê', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ãº', 'ú', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ã³', 'ó', [rfReplaceAll]);
  Result := StringReplace(Result, 'Ã£', 'ã', [rfReplaceAll]);

  While (Pos('disponÃ', Result) > 0) Do
    Result := Copy(Result, 1, Pos('disponÃ', Result) - 1) + 'disponível' +
              Copy(Result, Pos('vel', Result)  + 3, Length(Result));
End;

function RetornaCaminhoPastaDosArquivos(ANomCon:String):String;
  Var
    LArqCon : IDataSet;
begin
  Try
    LArqCon     := objFunctions.fGetDataSet;
    LArqCon.Close;
    LArqCon.SQL := 'SELECT                      '+
                   '  ARQ_CAMARQ                '+
                   'FROM                        '+
                   '  ARQCON                    '+
                   'WHERE ARQ_NOMCON = :NOMCON  ';

    LArqCon.ParamByName('NOMCON').AsString := ANomCon;
    LArqCon.Open;

    Result := LArqCon.FieldByName('ARQ_CAMARQ').AsString;

    If Not TryDirectoryExists(Result) Then
      Result := '';

  Except
    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure ImportarCaminhoPastaDosArquivos;
  Var
    LArqCon : IDataSet;
    stlArquivo: TStringList;
    intCont   : Integer;
    LNomCon : String;
    LCaminhoArquivos : String;

  procedure ExecutaSQL(strSQLCreate: String);
    Var
      qryGen: IDataSet;
  Begin
    Try
      qryGen := objFunctions.fGetDataSet;
      qryGen.SQL := strSQLCreate;
      qryGen.ExecSQL;
    Except
      Raise;
    End;
  End;

begin
  Try
    stlArquivo := TStringList.Create;

    Try
      LArqCon     := objFunctions.fGetDataSet;
      LArqCon.Close;
      LArqCon.SQL := 'SELECT COUNT(*) AS QTD FROM ARQCON ';
      LArqCon.Open;

      If (LArqCon.FieldByName('QTD').AsInteger > 0) Then
        Exit;

      ExecutaSQL('REPLACE INTO TABNRE (NOMTAB) VALUES ("ARQCON")');

      If SysUtils.FileExists(strFolderAplic + 'folderconcil.txt') Then
      Begin
        stlArquivo.LoadFromFile(strFolderAplic + 'folderconcil.txt');

        For intCont := 0 To stlArquivo.Count - 1 Do
        Begin
          LNomCon := Copy(stlArquivo[intCont], 1, Pos('=', stlArquivo[intCont]) - 1);
          LCaminhoArquivos := Copy(stlArquivo[intCont],Pos('=', stlArquivo[intCont]) + 1, Length(stlArquivo[intCont]));

         SalvaCaminhoPastaDosArquivos(LNomCon,LCaminhoArquivos);
        End;
      End;

    Except
      On E:Exception Do
      Begin
        // se não conseguir importar não faz nada
      End;
    End;
  Finally
    FreeAndNil(stlArquivo);
  End;
end;

procedure SalvaCaminhoPastaDosArquivos(ANomCon,ACaminhoArquivos:String);
  Var
    LArqCon : IDataSet;
Begin

  If fEmptyStr(ACaminhoArquivos) Then
    ACaminhoArquivos := strFolderConcil;

  Try
    LArqCon     := objFunctions.fGetDataSet;
    LArqCon.Close;
    LArqCon.SQL := 'REPLACE INTO ARQCON (ARQ_NOMCON, ARQ_CAMARQ) '+
                   'VALUES (:NOMCON, :CAMARQ)                    ';

    LArqCon.ParamByName('NOMCON').AsString := ANomCon;
    LArqCon.ParamByName('CAMARQ').AsString := ACaminhoArquivos;
    LArqCon.ExecSQL;

  Except
    On E:Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
End;

function RetornaEstruturaTabelaCaminhoArquivo:String;
Begin
  Result := 'CREATE TABLE ARQCON(                 '+
            '  ARQ_NOMCON VARCHAR(100) NOT NULL,  '+
            '  ARQ_CAMARQ TEXT DEFAULT NULL,      '+
            'PRIMARY KEY(ARQ_NOMCON)              '+
            ') ENGINE=INNODB                      ';
End;

function fArquivoFolder(strNomCon: String; blnSalvar: Boolean = False): String;
Begin

  If blnSalvar Then
  Begin
    SalvaCaminhoPastaDosArquivos(strNomCon,strFolderConcil);
  End;

  Result := RetornaCaminhoPastaDosArquivos(strNomCon);

  If fEmptyStr(Result) Then
  Begin
    strFolderConcil := strFolderAplic;
    Result := strFolderAplic;
  End;

End;

function RetornaSequencial(ATabela: String; ACodEmp: String = ''):String;
  Var
    LProCod: IDataset;
Begin
  Try
    Try
      LProCod := objFunctions.fGetDataSet;
      LProCod.SQL := 'SELECT fRetAutoIncrem("'+ATabela+'","'+ACodEmp+'") AS SEQUENCIAL';
      LProCod.Open;

      Result := LProCod.FieldByName('SEQUENCIAL').AsString;
    Except
      On E: Exception Do
      Begin
        Result := '1';
      End;
    End;
  Finally
    If Assigned(LProCod) Then
      LProCod := Nil;
  End;
End;

function RetornaSQLReplace(ANomeTabela: String;
                           ACamposDoModelo: TStringList;
                           ACamposIgnorados: Array of String): String;
  Var
    LTabela: IDataset;

    LCampos,
    LParametros: String;

    LContador: Integer;
Begin
  LTabela := objFunctions.fGetDataSet;
  LTabela.SQL := 'SELECT * FROM ' + ANomeTabela + ' WHERE FALSE';
  LTabela.Open;

  LCampos := '';
  LParametros := '';

  Result := 'REPLACE INTO ' + ANomeTabela + ' (';

  For LContador := 0 To ACamposDoModelo.Count - 1 Do
  Begin
    If MatchStr(ACamposDoModelo[LContador],  ACamposIgnorados) Then
      Continue;

    If LTabela.FindField(ACamposDoModelo[LContador]) = Nil Then
      Continue;

    LCampos := LCampos + ACamposDoModelo[LContador] + ',';

    LParametros := LParametros + ':' + ACamposDoModelo[LContador] + ',';
  End;

  Result := Result + LeftStr(LCampos, Length(LCampos) - 1) + ') VALUES (' +
                     LeftStr(LParametros, Length(LParametros) - 1) + ')';
End;

procedure CarregaRegistrosJaImportados(ANomeTabela: String;
                                       ACamposChavePrimaria: Array Of String;
                                       AValoresChavePrimaria: Array Of Variant);

  Var
    LContador: Integer;
Begin
  If Length(ACamposChavePrimaria) <> Length(AValoresChavePrimaria) Then
    Raise Exception.Create('A função CarregaRegistrosJaImportados foi implementada incorretamente.');


  FRegistrosJaImportados := objFunctions.fGetDataset;
  FRegistrosJaImportados.SQL := 'SELECT * FROM ' + ANomeTabela + ' WHERE ';

  For LContador := 0 To Length(ACamposChavePrimaria) - 1 Do
    FRegistrosJaImportados.SQL := FRegistrosJaImportados.SQL + ACamposChavePrimaria[LContador] +' '+ AValoresChavePrimaria[LContador] + ' AND ';

  FRegistrosJaImportados.SQL := LeftStr(FRegistrosJaImportados.SQL, Length(FRegistrosJaImportados.SQL) - 6); //a concatenação está functionando como o SQL.ADD, por isso tira 6 ao invés de 4

  FRegistrosJaImportados.Open;

End;

function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime): TDateTime;
begin
  Result := dtaOrigem;
  While (fDiaDeFolga(Result)) Do
    Result := Result + 1;
end;

function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True): Boolean;
  Const
    SABADO = 7;
    DOMINGO = 1;
begin
  If blnConsideraSabado Then
    Result := (DayOfWeek(dtaDta) In [DOMINGO, SABADO]) Or (fEhFeriado(dtaDta))
  Else
    Result := (DayOfWeek(dtaDta) = DOMINGO) Or (fEhFeriado(dtaDta));
end;

function fEhFeriado(dtaDta: TDateTime): Boolean;
  Var
    qryAux : IDataSet;
begin

  qryAux     := objFunctions.fGetDataSet;
  qryAux.Close;
  qryAux.SQL := 'SELECT COUNT(*) AS QTD FROM CADFER WHERE FER_DTAFER = "' + FormatDateTime('yyyy/mm/dd', dtaDta) + '"';
  qryAux.Open;

  Result := qryAux.FieldByName('QTD').AsInteger > 0;
end;

function IIF(blnCondicao: Boolean; varValorVerdadeiro, varValorFalso: Variant): Variant;
Begin
  If blnCondicao Then
    Result := varValorVerdadeiro
  Else
    Result := varValorFalso;
End;

function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto, (Length(strTexto) + 1) - intTamanho, intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;

{$IF Defined(VER180)}
{$ELSE}

procedure dxInitializeStone;
Begin
  dxInitialize;
End;

procedure pImportaCielo(Aplicacao: HWND);
  Var
    objCielo: TCielo;
Begin
  objCielo := TCielo.Create(Nil);
  objCielo.Aplicacao := Aplicacao;
  objCielo.pSelecionaFonte;
End;

procedure pImportaGetNet(Aplicacao: HWND);
  Var
    objGetNet: TGetNet;
Begin
  objGetNet := TGetNet.Create(Nil);
  objGetNet.Aplicacao := Aplicacao;
  objGetNet.pSelecionaFonte;
End;

procedure dxInitializeGetNet;
Begin
  dxInitialize;
End;

procedure pInstrucoesMercadoLivreIntegracao; stdcall;
Begin
  dxInitialize;
  frmRelCartaoImportacao := TfrmRelCartaoImportacao.Create(Application);
  try
    pExibirRelatorio('frmRelCartaoImportacao', 'Instruções para Conciliação Mercado Livre', TReport.New(frmRelCartaoImportacao.frxInstrucoesML));
  finally
    FreeAndNil(frmRelCartaoImportacao);
    dxFinalize;
  end;
End;

{$IF Defined(VER270)}
{$ELSE}

procedure pImportaStone(Aplicacao: HWND);
  Var
    objStone: TStone;
Begin

  objStone := TStone.Create(Nil);
  objStone.Aplicacao := Aplicacao;
  objStone.pSelecionaFonte;

End;

procedure pImportaSicredi(Aplicacao: HWND);
  Var
    objSicredi: TSicredi;
Begin
  objSicredi := TSicredi.Create(Nil);
  objSicredi.Aplicacao := Aplicacao;
  objSicredi.pSelecionaFonte;
End;

procedure pImportaGranito(Aplicacao: HWND);
var
  objGranito: TGranito;
begin
  objGranito := TGranito.Create(nil);
  objGranito.Aplicacao := Aplicacao;
  objGranito.pSelecionaFonte;
end;

procedure pShowConfirmacaoDeCartoes; StdCall;
  Var
    LConfirmacaoDeCartoes : TfrmConfirmacaoDeCartoes;
Begin
  Try
    Try
      pCriarFormularios(TfrmConfirmacaoDeCartoes,LConfirmacaoDeCartoes);
      LConfirmacaoDeCartoes.ShowModal;
    Finally
      FreeAndNil(LConfirmacaoDeCartoes);
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.message);
    End;
  End;
End;

procedure pImportaPagSeguroAPI(Aplicacao: HWND); StdCall;
  Var
    LPagSeguroAPI: TPagSeguroAPI;
Begin
  LPagSeguroAPI := TPagSeguroAPI.Create(Nil);
  LPagSeguroAPI.Aplicacao := Aplicacao;
  LPagSeguroAPI.pSelecionaFonte;
End;

procedure pImportaMadeiraMadeira(Aplicacao: HWND); StdCall;
  Var
    LMadeiraMadeira: TMadeiraMadeira;
Begin
  LMadeiraMadeira := TMadeiraMadeira.Create(Nil);
  LMadeiraMadeira.Aplicacao := Aplicacao;
  LMadeiraMadeira.pSelecionaFonte;
End;

procedure pImportaRedeCardAPI(Aplicacao: HWND); StdCall;
  Var
    LRedeCardAPI: TRedeCardAPI;
Begin
  LRedeCardAPI := TRedeCardAPI.Create(Nil);
  LRedeCardAPI.Aplicacao := Aplicacao;
  LRedeCardAPI.pSelecionaFonte;
End;

procedure pImportaConcilAPI(Aplicacao: HWND); StdCall;
  Var
    LConcilAPI: TConcilAPI;
Begin
  LConcilAPI := TConcilAPI.Create(Nil);
  LConcilAPI.Aplicacao := Aplicacao;
  LConcilAPI.pSelecionaFonte;
End;

procedure pImportaPagarMe(Aplicacao: HWND); StdCall;
  Var
    LImportaPagamentosPagarMe: TImportaPagamentosPagarMe;
Begin
  LImportaPagamentosPagarMe := TImportaPagamentosPagarMe.Create(Nil);
  LImportaPagamentosPagarMe.Aplicacao := Aplicacao;
  LImportaPagamentosPagarMe.pSelecionaFonte;
End;

procedure pImportaAlpe(Aplicacao: HWND); StdCall;
  Var
    LImportaPagamentosAlpe: TImportaPagamentosAlpe;
Begin
  LImportaPagamentosAlpe := TImportaPagamentosAlpe.Create(Nil);
  LImportaPagamentosAlpe.Aplicacao := Aplicacao;
  LImportaPagamentosAlpe.pSelecionaFonte;
End;

procedure pImportaLucree(Aplicacao: HWND); StdCall;
  Var
    LImportaPagamentosLucree: TImportaPagamentosLucree;
Begin
  LImportaPagamentosLucree := TImportaPagamentosLucree.Create(Nil);
  LImportaPagamentosLucree.Aplicacao := Aplicacao;
  LImportaPagamentosLucree.pSelecionaFonte;
End;

procedure pImportaKoncilia(Aplicacao: HWND; strAmbiente: String); StdCall;
  Var
    objKoncilia: TKoncilia;
Begin

  objKoncilia := TKoncilia.Create(Nil);
  objKoncilia.Aplicacao   := Aplicacao;
  objKoncilia.strAmbiente := strAmbiente;
  objKoncilia.pSelecionaFonte;

End;

procedure pImportaKoncili(Aplicacao: HWND; strAmbiente: String); StdCall;
  Var
    objKoncilia: TKoncilia;
Begin

  objKoncilia := TKoncilia.Create(Nil);
  objKoncilia.Aplicacao   := Aplicacao;
  objKoncilia.strAmbiente := strAmbiente;
  objKoncilia.pSelecionaFonte;

End;
{$IFEND}



{******************************************}
{* FUNÇÃO QUE DESCOMPACTA O GZIP E MOSTRA *}
{* O TEXTO DO ARQUIVO (XML) DESCOMPACTADO *}
{***************************************AJ*}
function fDecodeGZIPContent(RawBytes: TArray<Byte>): String;
  var
    MSI: TMemoryStream;
    MSO: TStringStream;
    ZLib: TIdCompressorZlib;
begin
  Try
    MSI := TMemoryStream.Create;
    MSO := TStringStream.Create;
    MSI.WriteData(RawBytes,Length(RawBytes));
    MSI.Seek(0,0);
    Zlib := TIdCompressorZlib.Create(Application);
    Zlib.DecompressGZipStream(MSI,MSO);
    MSI.DisposeOf;
    MSO.Seek(0,0);
    Result := MSO.DataString;
    FreeAndNil(MSO);
    FreeAndNil(ZLib);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure pImportaCartoes(Aplicacao: HWND; strFolder: String; strNomCon: String; strNomEmp: String = '');
  Var
    objImport: TImportacaoCartao;
Begin
  objImport           := fRetOperadora(strNomCon);
  objImport.Aplicacao := Aplicacao;
  objImport.strNomEmp := strNomEmp;
  objImport.Empresa := LeftStr(strNomEmp,3);
  objImport.SelecionarArquivos := ImportacaoSelecionandoArquivo(strNomCon,objImport.Empresa);
  strFolderAplic      := strFolder;
  objImport.pSelecionaFonte;
End;

function fRetOperadora(strNomCon: String): TImportacaoCartao;
Begin
  Result := Nil;

  If UpperCase(strNomCon) = 'AMEX' Then
    Result := TAmex.Create(Nil)
  Else If UpperCase(strNomCon) = 'B2W' Then
    Result := TB2W.Create(Nil)
  Else If UpperCase(strNomCon) = 'CIELO' Then
    Result := TCielo.Create(Nil)
  Else If UpperCase(strNomCon) = 'CHARTCIELO' Then
    Result := TChartCielo.Create(Nil)
  Else If UpperCase(strNomCon) = 'CONCIL' Then
    Result := TConcil.Create(Nil)
  Else If UpperCase(strNomCon) = 'ELAVON' Then
    Result := TElavon.Create(Nil)
  Else If UpperCase(strNomCon) = 'EQUALS' Then
    Result := TEquals.Create(Nil)
  Else If UpperCase(strNomCon) = 'GETNET' Then
    Result := TGetNet.Create(Nil)
  {$IF Defined(VER270)}
  {$ELSE}
  Else If UpperCase(strNomCon) = 'SICREDI' Then
    Result := TSicredi.Create(Nil)
  Else If UpperCase(strNomCon) = 'GRANITO' Then
    Result := TGranito.Create(Nil)
  Else If UpperCase(strNomCon) = 'SIPAG' Then
    Result := TSipag.Create(Nil)
  {$IFEND}
  Else If UpperCase(strNomCon) = 'MERCADOLIVRE' Then
    Result := TMercadoLivre.Create(Nil)
  Else If UpperCase(strNomCon) = 'SAFRAPAY' Then
    Result := TSafrapay.Create(Nil)
  Else If UpperCase(strNomCon) = 'REDE' Then
    Result := TRedeCard.Create(Nil)
  Else If UpperCase(strNomCon) = 'REDESITE' Then
    Result := TRedeSite.Create(Nil)
  Else If UpperCase(strNomCon) = 'WALMART' Then
    Result := TWalmart.Create(Nil)
  Else If UpperCase(strNomCon) = 'PAGSEGURO' Then
    Result := TPagSeguro.Create(Nil)
  Else If UpperCase(strNomCon) = 'MAGAZINELUIZA' Then
    Result := TMagazineLuiza.Create(Nil)
  Else If UpperCase(strNomCon) = 'BANRISUL' Then
    Result := TBanrisul.Create(Nil)
  Else If UpperCase(strNomCon) = 'YAPAY' Then
    Result := TYapay.Create(Nil)
  Else If UpperCase(strNomCon) = 'BOAVISTA' Then
    Result := TBoaVista.Create(Nil)
  Else If UpperCase(strNomCon) = 'BANESCARD' Then
    Result := TBanesCard.Create(Nil)
  {$IF Defined(VER270)}
  {$ELSE}
  Else If UpperCase(strNomCon) = 'SHOPEEPAY' Then
    Result := TShopeePay.Create(Nil)
  Else If UpperCase(strNomCon) = 'FISERVBIN' Then
    Result := TFiservBin.Create(Nil)

  {$IFEND};

End;

function fRetornaVersao(strNomArq: String = ''): String;
  var
  _Size: DWORD;
  _VerInfo: Pointer;
  _ValueSize: DWORD;
  _Value: PVSFixedFileInfo;
  _Dummy: DWORD;
  _V1, _V2, _V3, _V4: Word;
begin
  Result := '';

  If (fEmptyStr(strNomArq)) Then
    strNomArq := Application.ExeName;

  If (Not FileExists(strNomArq)) Then
    Exit;

  _Size := GetFileVersionInfoSize(PChar(strNomArq), _Dummy) ;
  GetMem(_VerInfo, _Size);
  GetFileVersionInfo(PChar(strNomArq), 0, _Size, _VerInfo);
  VerQueryValue(_VerInfo, '\', Pointer(_Value), _ValueSize);
  with _Value^ do
  begin
    _V1 := dwFileVersionMS shr 16;
    _V2 := dwFileVersionMS and $FFFF;
    _V3 := dwFileVersionLS shr 16;
    _V4 := dwFileVersionLS and $FFFF;
  end;
  FreeMem(_VerInfo, _Size);
  Result := Copy(IntToStr(100 + _V1), 3, 2) + '.' +
    Copy(IntToStr(100 + _V2), 3, 2) + '.' +
    Copy(IntToStr(100 + _V3), 3, 2) + '.' +
    Copy(IntToStr(100 + _V4), 3, 2);

  //https://www.devmedia.com.br/
end;

function fRetornaAmbienteKoncilia(strCodEmp: String): String;
  Var
    qryDados: IDataset;
Begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := 'SELECT SIS_VALCFG FROM CFGSIS       ' +
                  ' WHERE SIS_CODCFG="CFG_KONAMB" AND  ' +
                  ' SIS_CODEMP = ' + strCodEmp.QuotedString;
  qryDados.Open;

  Result := qryDados.FieldByName('SIS_VALCFG').AsString;
End;

function fRetSomenteNumeros(strTexto: String): String;
  Var
    strTmp: String;
    intIndice: Integer;
begin
  strTmp := '';

  If Not fEmptyStr(strTexto) Then
  Begin
    For intIndice := 1 To Length(strTexto) Do
      If CharInSet(strTexto[intIndice], ['0'..'9']) Then
        strTmp := strTmp + strTexto[intIndice];
  End;

  Result := strTmp;
End;

function fRetornaHMACSHA512Stone(strCodEmp, strTextoValidacao: String): String;
  Var
    strSecretKey: String;
    {$IF Defined(VER270)}
    {$ELSE}
      shaChave    : THashSHA2;
    {$IFEND}
Begin
  strSecretKey := fRetornaValorConfiguracao('CFG_STOSEC', strCodEmp);

  If (strSecretKey = '') Then
    Exit('');

  {$IF Defined(VER270)}
    Result := '';
  {$ELSE}
    shaChave := THashSHA2.Create(SHA512);

    Result := shaChave.GetHMAC(strTextoValidacao, strSecretKey, SHA512);

    FreeAndNil(shaChave);
  {$IFEND}
End;

procedure pValidaLibsWebService;
Begin
  if fEmptyStr(fRetornaVersao(ExtractFilePath(Application.ExeName) + 'ssleay32.dll')) then
    raise Exception.Create('O arquivo ssleay32.dll não foi encontrado.' + #13 +
                           'Entre em contato com a Citel para realizar a atualização do arquivo.')
  Else if fEmptyStr(fRetornaVersao(ExtractFilePath(Application.ExeName) + 'libeay32.dll')) then
    raise Exception.Create('O arquivo libeay32.dll não foi encontrado.' + #13 +
                           'Entre em contato com a Citel para realizar a atualização do arquivo.')
  Else If fRetornaVersao(ExtractFilePath(Application.ExeName) + 'libeay32.dll') = '0.9.8.6' then
    raise Exception.Create('A versão do arquivo libeay32.dll está desatualizada.' + #13 +
                           'Entre em contato com a Citel para realizar a atualização do arquivo.');
End;

function fRetornaValorConfiguracao(strConfiguracao: String;
                                   strCodigoEmpresa: String = ''): String;
  Var
    qryDados: IDataset;
Begin
  {$IF Defined(VER270)}
  {$ELSE}
  If fEmptyStr(strCodigoEmpresa) Then
    strCodigoEmpresa := VS_strCodEmp;
 {$IFEND}
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := 'SELECT SIS_VALCFG FROM CFGSIS ' +
                  ' WHERE SIS_CODCFG=' + strConfiguracao.QuotedString +
                  ' AND SIS_CODEMP = ' + strCodigoEmpresa.QuotedString;
  qryDados.Open;

  If (qryDados.IsEmpty) Then
    Exit('');

  Result := qryDados.FieldByName('SIS_VALCFG').AsString;
End;

function fRetornaValorConfiguracaoHub(strConfiguracao: String;
                                      strCodigoEmpresa: String): String;
  Var
    qryDados: IDataset;
Begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := 'SELECT SIS_VALCFG FROM HUBCIT_CFGSIS ' +
                  ' WHERE SIS_CODCFG=' + strConfiguracao.QuotedString +
                  '  AND SIS_HUBMKP = "HubCitel" ' +
                  '  AND SIS_CODEMP = ' + strCodigoEmpresa.QuotedString;
  qryDados.Open;

  If (qryDados.IsEmpty) Then
    Exit('');

  Result := qryDados.FieldByName('SIS_VALCFG').AsString;
End;

function ImportacaoSelecionandoArquivo(ANomCon,ACodEmp : String): Boolean;
Begin
  Result := False;

  If ANomCon.Equals('MercadoLivre') Then
    Result := fRetornaValorConfiguracao('CFG_MEREMP',ACodEmp).Equals('S');
  If ANomCon.Equals('SHOPEEPAY') Then
    Result := fRetornaValorConfiguracao('CFG_SHOEMP',ACodEmp).Equals('S');
End;

function RetornaNomeEmpresa(ACodEmp: String): String;
  Var
    qryDados: IDataset;
Begin
  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := 'SELECT EMP_NOMEMP FROM CADEMP ' +
                  ' WHERE EMP_CODEMP=' + ACodEmp.QuotedString;
  qryDados.Open;

  If (qryDados.IsEmpty) Then
    Exit('');

  Result := qryDados.FieldByName('EMP_NOMEMP').AsString;
End;

procedure pImportaRedeMenil(Aplicacao: HWND; strNomEmp: String = ''); StdCall;
  Var
    objRede: TRedeCard;
Begin
  objRede := TRedeCard.Create(Nil);
  objRede.Aplicacao := Aplicacao;
  objRede.strNomEmp := strNomEmp;
  objRede.VersaoMenil := True;
  objRede.pSelecionaFonte;
End;

function ArquivoValidoParaImportacao(arqArquivo: TSearchRec): Boolean;
Begin
  Result := False;

  If (arqArquivo.Name = '.') Then
    Exit;

  If (arqArquivo.Name = '..') Then
    Exit;

  If (arqArquivo.Attr = faDirectory) Then
    Exit;

  If (MatchStr(ExtractFileExt(arqArquivo.Name).ToLower, ['.imp', '.dll', '.exe', '.com', '.jpg'])) Then
    Exit;

  Result := True;
End;

procedure pExibirRelatorio(strNomPro, strDesPro: String; AReport: IReport);
begin
  If Assigned(ProcPreviewReport) Then
    ProcPreviewReport(strNomPro, strDesPro, AReport)
  Else
    AReport.ShowReport;
end;

function PedirLiberacao(ADirAcesso:String; AMsgSenha:String;ATexto: String): Boolean;
Begin
  Result := False;

  If Assigned(FuncPedirLiberacao) Then
    Result := FuncPedirLiberacao(ADirAcesso, AMsgSenha, ATexto);

End;

function ExisteScriptsDaCieloVersao015: Boolean;
  Var
    LTeste: IDataset;
Begin
  LTeste := objFunctions.fGetDataSet;
  LTeste.SQL := 'SELECT * FROM CIE_CIPGTO WHERE FALSE';
  LTeste.Open;

  Result := LTeste.FindField('CIE_VERARQ') <> Nil;
End;

{$IF Defined(VER270)}
{$ELSE}
function CriarQueryDLL: TUniQuery;
Begin
  Result := Nil;

  If Assigned(FuncCriarQueryDLL) Then
    Result := FuncCriarQueryDLL;

End;
{$IFEND}
function IncluirCartaoVenda(AAutoincremExtratoVenda: String): Boolean;
Begin
  Result := False;

  If Assigned(FuncIncluirCartaoVenda) Then
    Result := FuncIncluirCartaoVenda(AAutoincremExtratoVenda);
End;

Procedure ChamaConciliacaoCartoes(ANomCon: String);
Begin
  If Assigned(ProcChamaConciliacaoCartoes) Then
    ProcChamaConciliacaoCartoes(ANomCon);
End;

function AlterarCartaoVenda(AAutoincremCartao: String): Boolean;
Begin
  Result := False;

  If Assigned(FuncAlterarCartaoVenda) Then
    Result := FuncAlterarCartaoVenda(AAutoincremCartao);
End;

function fIPesqEmpresa(ASelf    : TForm;
                       edtCodigo: TCustomEdit;
                       edtNomEmp: TEditFocus;
                       Var chrKey: Char): Boolean;
Begin
  Result := True;

  If Assigned(FuncPesquisaEmpresa) Then
    Result := FuncPesquisaEmpresa(ASelf, edtCodigo, edtNomEmp,chrKey);
End;

function fIPesquisar(ASelf     : TForm;
                    edtCodigo: TCustomEdit;
                    edtDescri: TEditFocus;
                    Var chrKey: Char;
                    ACodPesquisa: String): Boolean;
Begin
  Result := True;

  If Assigned(FuncPesquisa) Then
    Result := FuncPesquisa(ASelf, edtCodigo, edtDescri,chrKey,ACodPesquisa);
End;


function RetornaBuildNumberVersaoWindows: Integer;
  Var
    LRegistro: TRegistry;
Begin
  Try
    LRegistro := TRegistry.Create;
    LRegistro.Access := KEY_READ;
    LRegistro.RootKey := HKEY_LOCAL_MACHINE;

    LRegistro.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\', true);

    Result := 0;
    Try
      If LRegistro.ReadString('CurrentBuild') <> '' Then
        Result := StrToInt(LRegistro.ReadString('CurrentBuild'));
    Except

    End;
  Finally
    FreeAndNil(LRegistro);
  End;
End;

{$IFEND}

{ TReport }

function TReport.Collate: String;
begin
  Result := BoolToStr(FReport.PrintOptions.Collate);
end;

function TReport.Copies: String;
begin
  Result := IntToStr(FReport.PrintOptions.Copies);
end;

constructor TReport.Create;
begin
  inherited Create;
  FAppEvents := TApplicationEvents.Create(nil);
  FAppEvents.OnMessage := Self.OnMessage;
end;

destructor TReport.Destroy;
begin
  FreeAndNil(FAppEvents);
  inherited;
end;

procedure TReport.ExportarParaPDF(ATitle: String);
Var
  LSavArq: TSaveDialog;
  LExpPDF: TfrxPDFExport;
Begin
  LSavArq := TSaveDialog.Create(nil);
  try
    LSavArq.Filter     := 'Arquivos PDF|*.pdf';
    LSavArq.DefaultExt := 'pdf';

    LSavArq.FileName := ATitle + '.pdf';

    if not LSavArq.Execute then
      Exit;

    LExpPDF := TfrxPDFExport.Create(nil);
    try
      LExpPDF.PageNumbers := FReport.PrintOptions.PageNumbers;
      LExpPDF.ShowDialog  := False;
      LExpPDF.DefaultPath := ExtractFilePath(LSavArq.FileName);

      LExpPDF.FileName := LSavArq.FileName;
      if assigned(FReport.PreviewForm) then
        TfrxPreviewForm(FReport.PreviewForm).Preview.Export(LExpPDF)
      else
        FReport.Export(LExpPDF);
    finally
      FreeAndNil(LExpPDF);
    end;

    ShellExecute(0, nil, PChar(LSavArq.FileName), nil, nil, SW_SHOWNORMAL);
  finally
    FreeAndNil(LSavArq);
  end;
end;

function TReport.GetPrintBClick: TPrintBClick;
begin
  Result := TfrxPreviewForm(FReport.PreviewForm).PrintB.OnClick;
end;

class function TReport.New(AReport: TfrxReport): IReport;
var
  LReport: TReport;
begin
  LReport := TReport.Create;
  LReport.FReport := AReport;
  Result := LReport;
end;

procedure TReport.OnMessage(var Msg: tagMSG; var Handled: Boolean);
begin
  if Assigned(FReport) and Assigned(FReport.Preview) then
    if Msg.hwnd = FReport.Preview.Handle then
    begin
      if (Msg.message = WM_KEYFIRST) and
        ((Msg.wParam = Ord('p')) or (Msg.wParam = Ord('P'))) then
      begin
        if KeyIsDown(VK_CONTROL) then
        begin
          Msg.message := 0;
          TfrxPreviewForm(FReport.PreviewForm).PrintB.Click;
        end;
      end;
    end;
end;

function TReport.PageNumbers: String;
begin
  Result := FReport.PrintOptions.PageNumbers;
end;

function TReport.PagesCount: Integer;
begin
  Result := FReport.PreviewPages.Count;
end;

procedure TReport.PrepareReport;
begin
  FReport.PrepareReport;
end;

procedure TReport.Print;
begin
  FReport.Print;
end;

function TReport.Printer: String;
begin
  Result := FReport.PrintOptions.Printer;
end;

function TReport.PrintMode: String;
begin
  Result := IntToStr(Ord(FReport.PrintOptions.PrintMode));
end;

function TReport.PrintOnSheet: String;
begin
  Result := IntToStr(FReport.PrintOptions.PrintOnSheet);
end;

function TReport.PrintPages: String;
begin
  Result := IntToStr(Ord(FReport.PrintOptions.PrintPages));
end;

procedure TReport.SaveToFile(AFile: String);
begin
  FReport.PreviewPages.SaveToFile(AFile);
end;

procedure TReport.SetOnPreview(AProc: TOnPreview);
begin
  FReport.OnPreview := AProc;
end;

procedure TReport.SetPrintBClick(AProc: TPrintBClick);
begin
  TfrxPreviewForm(FReport.PreviewForm).PrintB.OnClick := AProc;
end;

procedure TReport.ShowReport;
begin
  FReport.PreviewOptions.Buttons := [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbNavigator];
  FReport.ShowReport;
end;

{TThreadDirectoryExists}

procedure TThreadDirectoryExists.Execute;
begin
  try
    FResult := SysUtils.DirectoryExists( FDirname );
  except
    On E: Exception Do
    begin
      FErr := E.Message;
      FErrclass := ExceptionClass( E.Classtype );
    end;
  end;
end;


function TThreadDirectoryExists.TestForDir(const dirname: String;
   timeoutMSecs: Dword): TTestResult;
 begin
   FDirname := dirname;
   {$WARNINGS OFF}
   Resume;
   {$WARNINGS ON}
   If WaitForSingleObject( Handle, timeoutMSecs ) = WAIT_TIMEOUT Then
   Begin
     Result := trTimeout;
     FreeOnTerminate := true;
   End
   Else
   Begin
     If Assigned( FErrclass ) Then
       raise FErrClass.Create( FErr );
     If FResult Then
       Result := trDirectoryExists
     Else
       Result := trNoDirectory;
   End;
 end;

function TryDirectoryExists(APath: string; ATimeoutSecs: Integer): Boolean;
Var
  res: TThreadDirectoryExists.TTestResult;
  thread: TThreadDirectoryExists;
Begin
  if APath = '' then
  Begin
    Result := False;
    Exit;
  End;
  Assert(ATimeoutSecs > 0, 'TryDirectoryExists: timeout cannot be 0.');
  thread:= TThreadDirectoryExists.Create( true );
  try
    res:= thread.TestForDir( APath, ATimeoutSecs * 1000);
    Result := res = trDirectoryExists;
    If res <> trTimeout Then
      thread.Free;
  except
    thread.free;
    raise
  end;
End;

function SafeFilePath(const FilePath: string): Boolean;
var
  MaxPathLength: Integer;
  FileAttr: Cardinal;
begin
  Result := False;
  MaxPathLength := 255; // Limite padrão do Windows

  try
    // Verifica se o caminho é válido e se existe
    if not TryDirectoryExists(FilePath) then
    begin
      objFunctions.fIMensagem('ATENÇÃO','O caminho: ' + FilePath + ' não existe!',['&OK']);
      Exit;
    end;

    // Verifica se o caminho é muito longo
    if Length(FilePath) > MaxPathLength then
    begin
      objFunctions.fIMensagem('ATENÇÃO','O caminho: ' + FilePath + ' é muito longo.',['&OK']);
      Exit;
    end;

    // Verifica permissões de acesso
    FileAttr := GetFileAttributes(PChar(FilePath));
    if (FileAttr = INVALID_FILE_ATTRIBUTES) then
    begin
      objFunctions.fIMensagem('ATENÇÃO','Você não tem permissão para acessar caminho: ' + FilePath + '',['&OK']);
      Exit;
    end;

    Result := True;
  except
    on E: EFileNotFoundException do
      Raise EFileNotFoundException.Create('Arquivo não encontrado. ' + E.Message);
    on E: EInOutError do
      Raise EInOutError.Create('Erro de entrada/saída. ' + E.Message);
    on E: Exception do
      Raise Exception.Create('Erro desconhecido: ' + E.Message);
  end;
end;

{$IF Defined(VER270) OR Defined(VER180)}
{$ELSE}
function TimeZoneLocal : Integer;
  Var
    LTimeZoneInfo : TTimeZoneInformation;
begin
  GetTimeZoneInformation(LTimeZoneInfo);
  Result := LTimeZoneInfo.Bias div -60;
end;

function LocalTimeToUTC(const AValue: TDateTime): TDateTime;
  Var
    LSysTime1, LSysTime2: TSystemTime;
    LTimeZoneInfo: TTimeZoneInformation;
begin
  GetTimeZoneInformation(LTimeZoneInfo);
  LTimeZoneInfo.Bias := -LTimeZoneInfo.Bias;
  LTimeZoneInfo.StandardBias := -LTimeZoneInfo.StandardBias;
  LTimeZoneInfo.DaylightBias := -LTimeZoneInfo.DaylightBias;
  DateTimeToSystemTime(AValue, LSysTime1);
  SystemTimeToTzSpecificLocalTime(@LTimeZoneInfo, LSysTime1, LSysTime2);
  Result := SystemTimeToDateTime(LSysTime2);
end;

function fTime() : TDateTime;
  Var
    LTimeZoneLocal : Integer;
    LUsaTimeZone : String;
    LTimeZoneConfigurado : Integer;
begin
  If (VS_strCodEmp.IsEmpty) Then
    Exit(Time());

  LUsaTimeZone := fRetornaValorConfiguracao('CFG_USATMZ', VS_strCodEmp);

  If (LUsaTimeZone.IsEmpty) Then
    Exit(Time());

  If (LUsaTimeZone = 'N') Then
    Exit(Time());

  LTimeZoneLocal := TimeZoneLocal();
  LTimeZoneConfigurado := TimeZoneConfigurado(VS_strCodEmp);
  If (LTimeZoneConfigurado <> 0) And (LTimeZoneLocal <> LTimeZoneConfigurado) Then
    Result := IncHour(LocalTimeToUTC(Time()), LTimeZoneConfigurado)
  Else
    Exit(Time());
end;

function TimeZoneConfigurado(const ACodigoEmpresa : String) : Integer;
  Var
    LTimeZone : String;
begin
  Result := 0;

  LTimeZone := fRetornaValorConfiguracao('CFG_TMZONE', ACodigoEmpresa);

  If (LTimeZone.IsEmpty) Then
    Exit;

  Result := StrToIntDef(LTimeZone, 0);
end;
{$IFEND}

initialization
  ProcPreviewReport      := Nil;
  FuncPesquisaEmpresa    := Nil;
  FuncPesquisa           := Nil;
  FuncPedirLiberacao     := Nil;
  FuncCriarQueryDLL      := Nil;
  FuncIncluirCartaoVenda := Nil;
  FuncAlterarCartaoVenda := Nil;
  ProcChamaConciliacaoCartoes := Nil;
end.
