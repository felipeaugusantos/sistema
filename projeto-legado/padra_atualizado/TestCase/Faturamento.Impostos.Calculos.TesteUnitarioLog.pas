unit Faturamento.Impostos.Calculos.TesteUnitarioLog;

interface

Uses
  system.Rtti, System.SysUtils, Classes, Vcl.Forms, untFuncoes,
  System.StrUtils,
  untParametrosComparacaoCfop,
  untParametrosComparacaoDifal,
  untParametrosComparacaoFcp,
  untParametrosComparacaoST,
  untParametrosComparacaoStCustoAquisicao,
  untParametrosComparacaoIcms,
  untParametrosComparacaoIpi,
  untParametrosComparacaoIcmsEfetivo,
  untParametrosComparacaoMargemVenda,
  untParametrosComparacaoIcmsOrgaoPublico,
  untParametrosComparacaoPrecoCusto,
  Faturamento.Impostos.Interfaces.ClassificacaoItem,
  Faturamento.Impostos.Interfaces.Difal,
  Faturamento.Impostos.Interfaces.ST,
  Faturamento.Impostos.Interfaces.StCustoAquisicao,
  Faturamento.Impostos.Interfaces.FCP,
  Faturamento.Impostos.Interfaces.Icms,
  Faturamento.Impostos.Interfaces.Ipi,
  Faturamento.Impostos.Interfaces.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.IcmsOrgaoPublico,
  Faturamento.Margem.Interfaces.MargemVenda,
  Faturamento.Precos.Interfaces.PrecoCusto;

  procedure pGerarLogTesteUnitario(AParamEntrada :TObject; AParamResultado: TObject;
    AParamObjCliente: TObject; ANomeMetodo : String);

  function RetornarReturnValue(const ANomeMetodo: string): string;
  function RetornarReturnValueDefault(const ANomeMetodo: string): string;
  function RetornarReturnValueIPI(const ANomeMetodo: string): string;
  function RetornarReturnValueIcms(const ANomeMetodo: string): string;
  function RetornarReturnValueST(const ANomeMetodo: string): string;
  function RetornarReturnValueIcmsOrgaoPublico(const ANomeMetodo: string): string;
  function RetornarReturnValueSTCustoAquisicao(const ANomeMetodo: string): string;
  function RetornarReturnValueFCP(const ANomeMetodo: string): string;
  function RetornarReturnValueDifal(const ANomeMetodo: string): string;
  function RetornarReturnValueDifalFCP(const ANomeMetodo: string): string;
  function RetornarReturnValuePrecoCustoRealVenda(const ANomeMetodo: string): string;
  function RetornarReturnValuePrecoCustoMargemMarkup(const ANomeMetodo: string): string;
  function RetornarReturnValueMargemVenda(const ANomeMetodo: string): string;

  function fGerarLogParametrosEntrada(AParamEntrada :TObject; AParamResultado: TObject;  AParamObjCliente : TObject;
    ANomeMetodo : String; AInterfaceParametros : String; AInterfaceResult : String; const AMetodoImposto: string) : TStringList;

  function fGerarLogParametrosSaida(AMetodoImposto : String) : TStringList;

  function fGerarLogParametrosSaidaCfop            : TStringList;
  function fGerarLogParametrosSaidaDifal           : TStringList;
  function fGerarLogParametrosSaidaFCPDifal        : TStringList;
  function fGerarLogParametrosSaidaFCP             : TStringList;
  function fGerarLogParametrosSaidaIpi             : TStringList;
  function fGerarLogParametrosSaidaIcmsEfetivo     : TStringList;
  function fGerarLogParametrosSaidaIcms            : TStringList;
  function fGerarLogParametrosSaidaST              : TStringList;
  function fGerarLogParametrosSaidaStCustoAquisicao: TStringList;
  function fGerarLogParametrosSaidaIcmsOrgaoPublico: TStringList;
  function fGerarLogParametrosSaidaPrecoCustoRealVenda: TStringList;
  function fGerarLogParametrosSaidaPrecoCustoMargemMarkup: TStringList;
  function fGerarLogParametrosSaidaMargemVenda : TStringList;

  function fRetornarNomeInterface(ADescricao : String) : String;

  procedure pCarregarListParametros(AParam : TObject);
  Procedure pCriarObjetos(AParam : TObject);
  Procedure pDestruirObjetos;
  procedure pGravarLogTesteUnitario;
  procedure pGravarArquivoLogTesteUnitario(const AFolder, ALog: string);
  procedure pGerarLog(AParamEntrada, AParamResultado, AParamObjCliente: TObject; ANomeMetodo , LInterfaceIn , LInterfaceOut: string);

  function fGerarArquivoLogImposto(AMetodoImposto : String; Var AArquivoImposto : String;
    AParamEntrada, AParamResultado, AParamObjCliente: TObject; ANomeMetodo , LInterfaceIn , LInterfaceOut: string  ) : Boolean;

  procedure pGravaLogImposto(ALogImposto : String; AFolder : String);

  function fRetonarCaseOpcaoSelecionada(ANomeMetodo: String) : Integer;

  function fRetornaNomePastaImposto(const ANomeMetodo: string): string;
  procedure pLimparVariaveisTesteUnitario;

  function fTipoDoValor(strValor : TValue) : TTypeKind;

  function fGetVariavelLogCfop                  : String;
  function fGetVariavelLogDifal                 : String;
  function fGetVariavelLogFCPDifal              : String;
  function fGetVariavelLogFCP                   : String;
  function fGetVariavelLogST                    : String;
  function fGetVariavelLogIpi                   : String;
  function fGetVariavelLogIcmsOrgaoPublico      : String;
  function fGetVariavelLogIcmsEfetivo           : String;
  function fGetVariavelLogStCustoAquisicao      : String;
  function fGetVariavelLogPrecoCustoRealVenda   : String;
  function fGetVariavelLogMargemVenda           : String;
  function fGetVariavelLogPrecoCustoMargemMarkup: String;

  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoCfop); Overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoDifal);Overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoDifalFCP);Overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoFCP);Overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoIcms); overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoST); overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoIpi); overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoIcmsOrgaoPublico); overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoIcmsEfetivo); overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoStCustoAquisicao); overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoPrecoCustoRealVenda); overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoPrecoCustoMargemMarkup); overload;
  procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoMargemVenda); overload;

  function RetornarDadosIniciais(const AMetodoImposto: String): string;

  function RetornarDadosIniciaisDifal: string;


  function fGetVariavelLogIcms: String;

  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoRegraClassificacaoItem); Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoDifal);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoDifalFCP);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoIcms);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoFCP);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoST);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoIpi);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoIcmsOrgaoPublico); Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoIcmsEfetivo);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoStCustoAquisicao);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoPrecoCusto);Overload;
  procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoMargemVenda);Overload;

implementation

uses
  untModulo;

Var

  Ctx : TRttiContext;
  RTT : TRttiType;

  LParamEntrada : TStringList;
  LParamTipos   : TStringList;
  LValorEntrada : TStringList;

  LLogIcmsEfetivo     : string;
  LLogOrgaoPublico    : string;
  LLogIpi             : string;
  LLogSTCustoAquisicao: string;
  LLogIcms            : string;
  LLogSt              : string;
  LLogFcp             : string;
  LLogFcpDifal        : string;
  LLogDifal           : string;
  LLogCfop            : string;
  LLogPrecoCustoRealVenda: string;
  LLogPrecoCustoMargemMarkup: string;
  LLogMargemVenda: string;

  AParametrosCFOP             : IParametrosComparacaoCfop;
  AParametrosDifal            : IParametrosComparacaoDifal;
  AParametrosFCPDifal         : IParametrosComparacaoDifalFCP;
  AParametrosIcms             : IParametrosComparacaoIcms;
  AParametrosFCP              : IParametrosComparacaoFCP;
  AParametrosST               : IParametrosComparacaoST;
  AParametrosIpi              : IParametrosComparacaoIpi;
  AParametrosIcmsOrgaoPublico : IParametrosComparacaoIcmsOrgaoPublico;
  AParametrosIcmsEfetivo      : IParametrosComparacaoIcmsEfetivo;
  AParametrosStCustoAquisicao : IParametrosComparacaoStCustoAquisicao;
  AParametrosPrecoCustoRealVenda    : IParametrosComparacaoPrecoCustoRealVenda;
  AParametrosPrecoCustoMargemMarkup : IParametrosComparacaoPrecoCustoMargemMarkup;
  AParametrosMargemVenda            : IParametrosComparacaoMargemVenda;

  FResultadoCFOP             : IResultadoRegraClassificacaoItem;
  FResultadoDifal            : IResultadoCalculoDifal;
  FResultadoFCPDifal         : IResultadoCalculoDifalFCP;
  FResultadoIcms             : IResultadoCalculoIcms;
  FResultadoFCP              : IResultadoCalculoFCP;
  FResultadoST               : IResultadoCalculoST;
  FResultadoStCustoAquisicao : IResultadoCalculoStCustoAquisicao;
  FResultadoIpi              : IResultadoCalculoIpi;
  FResultadoIcmsOrgaoPublico : IResultadoCalculoIcmsOrgaoPublico;
  FResultadoIcmsEfetivo      : IResultadoCalculoIcmsEfetivo;
  FResultadoPrecoCusto       : IResultadoCalculoPrecoCusto;
  FResultadoMargemVenda      : IResultadoCalculoMargemVenda;

 CONST
  FOLDER_ORGAOPUBLICO     = 'OrgaoPublico';
  FOLDER_ICMSEFETIVO      = 'IcmsEfetivo';
  FOLDER_IPI              = 'Ipi';
  FOLDER_STCUSTOAQUISICAO = 'STCustoAquisicao';
  FOLDER_ICMS             = 'Icms';
  FOLDER_ST               = 'St';
  FOLDER_FCP              = 'Fcp';
  FOLDER_FCPDIFAL         = 'FcpDifal';
  FOLDER_DIFAL            = 'Difal';
  FOLDER_CFOP             = 'Cfop';
  FOLDER_PRECOCUSTOREALVENDA = 'PrecoCusto\PrecoCustoRealVenda';
  FOLDER_PRECOCUSTOMARGEMMARKUP = 'PrecoCusto\PrecoCustoMargemMarkup';
  FOLDER_MARGEMVENDA = 'Margem\MargemVenda';

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoCfop);Overload;
begin
  AParametrosCFOP := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoDifal);Overload;
begin
  AParametrosDifal := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoDifalFCP);Overload;
begin
  AParametrosFCPDifal := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoFCP);Overload;
begin
  AParametrosFCP := AParametrosComparacao;
end;

function fGetVariavelLogCfop: String;
begin
  Result := LLogCfop;
end;

function fGetVariavelLogDifal: String;
begin
  Result := LLogDifal;
end;

function fGetVariavelLogFCPDifal: String;
begin
  Result := LLogFcpDifal;
end;

function fGetVariavelLogFCP: String;
begin
  Result := LLogFcp;
end;

function fGetVariavelLogST: String;
begin
  Result := LLogST;
end;
function fGetVariavelLogIpi: String;
begin
  Result := LLogIpi;
end;

function fGetVariavelLogIcmsOrgaoPublico: String;
begin
  Result := LLogOrgaoPublico;
end;

function fGetVariavelLogIcmsEfetivo: String;
begin
  Result := LLogIcmsEfetivo;
end;

function fGetVariavelLogStCustoAquisicao: String;
begin
  Result := LLogStCustoAquisicao;
end;

function fGetVariavelLogPrecoCustoRealVenda: String;
begin
  Result := LLogPrecoCustoRealVenda;
end;

function fGetVariavelLogMargemVenda: String;
begin
  Result := LLogMargemVenda;
end;


function fGetVariavelLogPrecoCustoMargemMarkup: String;
begin
  Result := LLogPrecoCustoMargemMarkup
end;

function fTipoDoValor(strValor : TValue) : TTypeKind;
begin
  Result := strValor.Kind;

end;

function fRetonarCaseOpcaoSelecionada(ANomeMetodo : String) : Integer;
begin
  Result := AnsiIndexStr(ANomeMetodo, ['CalcularValorIcmsOrgaoPublico', 'CalcularValorIcmsEfetivo','CalcularValorIPI',
                                       'CalcularValorSTCustoAquisicao','CalcularValorIcms', 'CalcularValorST', 'CalcularValorDifal',
                                       'CalcularValorFCP','CalcularValorDifalFCP','ClassificacaoDoItem','CalculaPrecoCustoRealVenda',
                                       'CalculaPrecoCusto', 'CalculaMargemVenda'])
end;

Procedure pCriarObjetos(AParam : TObject);
begin
  Ctx := TRttiContext.Create;

  RTT := Ctx.GetType(AParam.ClassType);

  LParamEntrada := TStringList.Create;
  LParamTipos   := TStringList.Create;
  LValorEntrada := TStringList.Create;
end;

Procedure pCarregarListParametros(AParam : TObject);
Var
  RTM : TRttiMethod;
begin

  For RTM In RTT.GetMethods Do
  Begin
   If (Length(RTM.GetParameters) = 0) Then
   Begin
     Try
       If Pos(RTM.Name, 'New_Destroy')> 0 Then
         Break;

       LParamEntrada.Add(RTM.Name);
       LParamTipos.Add(RTM.ToString);
       LValorEntrada.Add(RTM.Invoke(AParam, []).ToString);
     Except

     End;
   End;

  End;

end;

Procedure pDestruirObjetos;
begin
  Ctx.Free;
  FreeAndNil(LParamEntrada);
  FreeAndNil(LParamTipos);
  FreeAndNil(LValorEntrada);
end;


function fRetornarNomeInterface(ADescricao : String) : String;
Var
  str : String;
begin
  str := Copy(ADescricao, 2, length(ADescricao) -1);
  Result := 'I'+str;
end;


procedure pGravarLogTesteUnitario;
begin
  pGravaLogImposto(LLogIcmsEfetivo, FOLDER_ICMSEFETIVO);
  pGravaLogImposto(LLogOrgaoPublico, FOLDER_ORGAOPUBLICO);
  pGravaLogImposto(LLogIpi, FOLDER_IPI );
  pGravaLogImposto(LLogSTCustoAquisicao, FOLDER_STCUSTOAQUISICAO);
  pGravaLogImposto(LLogIcms, FOLDER_ICMS);
  pGravaLogImposto(LLogSt, FOLDER_ST );
  pGravaLogImposto(LLogFcp, FOLDER_FCP );
  pGravaLogImposto(LLogFcpDifal, FOLDER_FCPDIFAL );
  pGravaLogImposto(LLogDifal, FOLDER_DIFAL );
  pGravaLogImposto(LLogCfop, FOLDER_CFOP);
  pGravaLogImposto(LLogPrecoCustoRealVenda, FOLDER_PRECOCUSTOREALVENDA);
  pGravaLogImposto(LLogPrecoCustoMargemMarkup, FOLDER_PRECOCUSTOMARGEMMARKUP);
  pGravaLogImposto(LLogMargemVenda, FOLDER_MARGEMVENDA);
end;

procedure pGravarArquivoLogTesteUnitario(const AFolder, ALog: string);
Const
  PATH = 'TestesUnitarios\faturamento\Outros\Log\';
Var
  LArquivo     : TStringList;
  LNameFile    : String;
  LDiretorio   : String;
begin
  LArquivo := TStringList.Create;

  Try
    LNameFile := 'Log_'+FormatDateTime('yyyymmdd', Date) +'_' +FormatDateTime('hhnnsszzz', nOw) +'.txt'; ;
    LDiretorio := ExtractFilePath(Application.ExeName) + path + AFolder;

    If Not DirectoryExists(LDiretorio) Then
      CreateDir(LDiretorio);

    Try
      LArquivo.Add(ALog);
      LArquivo.SaveToFile( LDiretorio +'\' + LNameFile  );
    Except
      // Não gerar erro caso não encontre o diretório.
    End;
  finally
    FreeAndNil(LArquivo);
  end;

end;

function fGerarArquivoLogImposto(AMetodoImposto : String; Var AArquivoImposto : String;  AParamEntrada, AParamResultado, AParamObjCliente: TObject;
  ANomeMetodo , LInterfaceIn , LInterfaceOut: string  ) : Boolean;
var
  LLogParametrosEntrada: TStringList;
  LLogParametrosSaida: TStringList;
begin
  Result := False;

  If (ANomeMetodo <>  AMetodoImposto) Then
    Exit;

  LLogParametrosEntrada := fGerarLogParametrosEntrada(AParamEntrada, AParamResultado,
    AParamObjCliente, ANomeMetodo, LInterfaceIn, LInterfaceOut, AMetodoImposto);

  LLogParametrosSaida := fGerarLogParametrosSaida(AMetodoImposto);

  Try
    AArquivoImposto := AArquivoImposto + #13#10 + LLogParametrosEntrada.Text;
    AArquivoImposto := AArquivoImposto + LLogParametrosSaida.Text;
    Result := true;
  Finally
    FreeAndNil(LLogParametrosEntrada);
    FreeAndNil(LLogParametrosSaida);
  End;
end;

procedure pGerarLog(AParamEntrada, AParamResultado, AParamObjCliente: TObject;
  ANomeMetodo , LInterfaceIn , LInterfaceOut: string);
begin
  If fGerarArquivoLogImposto('CalcularValorIcmsOrgaoPublico', LLogOrgaoPublico, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorIcmsEfetivo', LLogIcmsEfetivo, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorIPI', LLogIpi, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorSTCustoAquisicao', LLogSTCustoAquisicao, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorIcms', LLogIcms, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorST', LLogSt, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorDifal', LLogDifal, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorFCP', LLogFcp, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalcularValorDifalFCP', LLogFcpDifal, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('ClassificacaoDoItem', LLogCfop, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalculaPrecoCustoRealVenda', LLogPrecoCustoRealVenda, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalculaPrecoCusto', LLogPrecoCustoMargemMarkup, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;

  If fGerarArquivoLogImposto('CalculaMargemVenda', LLogMargemVenda, AParamEntrada,
   AParamResultado, AParamObjCliente, ANomeMetodo , LInterfaceIn , LInterfaceOut) Then
    Exit;
end;

procedure pGerarLogTesteUnitario(AParamEntrada :TObject ; AParamResultado :TObject ;
   AParamObjCliente: TObject; ANomeMetodo : String);
var
  LInterfaceIn : String;
  LInterfaceOut: String;
begin
  If (not frmModulo.FChaveLogLigada) Then
    Exit;

  LInterfaceIn  := fRetornarNomeInterface(AParamEntrada.ToString);
  LInterfaceOut := fRetornarNomeInterface(AParamResultado.ToString);

  pGerarLog(AParamEntrada, AParamResultado, AParamObjCliente,
    ANomeMetodo, LInterfaceIn, LInterfaceOut);
end;

function RetornarReturnValueDefault(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := '+ ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValueIPI(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoImpostosIPI.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValueIcms(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoImpostosIcms.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValueST(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoImpostosST.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValueIcmsOrgaoPublico(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValueSTCustoAquisicao(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoImpostosSTCustoAquisicao.New.' + ANomeMetodo+'(AParametros);';
end;


function RetornarReturnValueDifal(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoImpostosDifal.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValueDifalFCP(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoImpostosDifalFCP.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValuePrecoCustoRealVenda(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoPrecosPrecoCusto.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValuePrecoCustoMargemMarkup(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoPrecosPrecoCusto.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValueMargemVenda(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoMargemMargemVenda.New.' + ANomeMetodo+'(AParametros);';
end;


function RetornarReturnValueFCP(const ANomeMetodo: string): string;
begin
  result := '  ReturnValue := TCalculoImpostosFCP.New.' + ANomeMetodo+'(AParametros);';
end;

function RetornarReturnValue(const ANomeMetodo: string): string;
begin
  result := RetornarReturnValueDefault(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 0) then
    result := RetornarReturnValueIcmsOrgaoPublico(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 2) then
    result := RetornarReturnValueIPI(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 3) then
    result := RetornarReturnValueSTCustoAquisicao(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 4) then
    result := RetornarReturnValueIcms(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 5) then
    result := RetornarReturnValueST(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 6) then
    result := RetornarReturnValueDifal(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 7) then
    result := RetornarReturnValueFCP(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 8) then
    result := RetornarReturnValueDifalFCP(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 10) then
    result := RetornarReturnValuePrecoCustoRealVenda(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 11) then
    result := RetornarReturnValuePrecoCustoMargemMarkup(ANomeMetodo);

  if (fRetonarCaseOpcaoSelecionada(ANomeMetodo) = 12) then
    result := RetornarReturnValueMargemVenda(ANomeMetodo);

end;

function fGerarLogParametrosEntrada(AParamEntrada :TObject ; AParamResultado: TObject; AParamObjCliente : TObject;
  ANomeMetodo : String; AInterfaceParametros : String; AInterfaceResult : String; const AMetodoImposto: string) : TStringList;
Var
  IntCont         : Integer;
  LQuantidade     : Integer;
  LAdicionarAspas : Boolean;
begin
  Try
    pCriarObjetos(AParamEntrada);

    // Parametros de Entrada
    Result := TStringList.Create;

    pCarregarListParametros(AParamEntrada);

    Result.Add('Var');
    Result.Add('  ReturnValue: '+ AInterfaceResult +';');
    Result.Add('  AParametros: '+ AInterfaceParametros +';' );
    Result.Add('Begin');

    Result.Add(RetornarDadosIniciais(AMetodoImposto));

    Result.Add('  AParametros :=');
    Result.Add('    '+ AParamEntrada.ClassName+'.New()');

    LQuantidade := LParamEntrada.Count -1;

    For IntCont := 0 To  LParamEntrada.Count -1 Do
    Begin
      LAdicionarAspas := true;

      If Pos('string', LParamTipos[IntCont]) = 0 Then
        LAdicionarAspas := false;

      If IntCont < LQuantidade Then
      begin
        If LAdicionarAspas Then
          Result.Add('      .'+LParamEntrada[IntCont]+'('''+ AnsiReplaceStr(LValorEntrada[IntCont],',','.')+''')')
        else
          Result.Add('      .'+LParamEntrada[IntCont]+'('+ AnsiReplaceStr(LValorEntrada[IntCont],',','.')+')')
      end
      else
      begin
        If LAdicionarAspas Then
          Result.Add('      .'+LParamEntrada[IntCont]+'('''+ AnsiReplaceStr(LValorEntrada[IntCont],',','.')+''');')
        else
          Result.Add('      .'+LParamEntrada[IntCont]+'('+ AnsiReplaceStr(LValorEntrada[IntCont],',','.')+');')
      end;
    End;

    Result.Add('');

    Result.Add(RetornarReturnValue(ANomeMetodo));

    Result := Result;
  Finally
    pDestruirObjetos;
  End;
end;

function fGerarLogParametrosSaidaCfop : TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('           (ReturnValue.ClassificacaoDoItem{' + FResultadoCFOP.ClassificacaoDoItem +'}  = '''+ AParametrosCFOP.ClassificacaoDoItem +''') And');
    Result.Add('           (ReturnValue.ClassificacaoDeServico{' + FResultadoCFOP.ClassificacaoDeServico +'}  = '''+ AParametrosCFOP.ClassificacaoDeServico +''') And');
    Result.Add('           (ReturnValue.CodigoDaSubstituicaoTributariaDoItem{' + FResultadoCFOP.CodigoDaSubstituicaoTributariaDoItem +'}  = '''+ AParametrosCFOP.CodigoDaSubstituicaoTributariaDoItem+'''));');
    Result.Add('end;')

  Finally

  End;
end;

function fGerarLogParametrosSaidaDifal: TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('            CompararValores(ReturnValue.ValorBaseDestino{'+ FloatToStr(FResultadoDifal.ValorBaseDestino) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.ValorBaseDestino) +''')) And');
    Result.Add('            CompararValores(ReturnValue.ValorIcmsDestino{'+ FloatToStr(FResultadoDifal.ValorIcmsDestino) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.ValorIcmsDestino) +''')) And');
    Result.Add('            CompararValores(ReturnValue.AliquotaInterestadualCalc{'+ FloatToStr(FResultadoDifal.AliquotaInterestadualCalc) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.AliquotaInterestadualCalc) +''')) And');
    Result.Add('            CompararValores(ReturnValue.ValorIcmsOrigem{'+ FloatToStr(FResultadoDifal.ValorIcmsOrigem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.ValorIcmsOrigem)+''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{'+ FloatToStr(FResultadoDifal.RecordDifalFCP.fltAlDifa) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.RecordDifalFCP.fltAlDifa)+''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{'+ FloatToStr(FResultadoDifal.RecordDifalFCP.fltDifDes) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.RecordDifalFCP.fltDifDes)+''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{'+ FloatToStr(FResultadoDifal.RecordDifalFCP.fltDifOri) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.RecordDifalFCP.fltDifOri)+''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{'+ FloatToStr(FResultadoDifal.RecordDifalFCP.fltAlqIne) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.RecordDifalFCP.fltAlqIne)+''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{'+ FloatToStr(FResultadoDifal.RecordDifalFCP.fltAlqUfd) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.RecordDifalFCP.fltAlqUfd)+''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{'+ FloatToStr(FResultadoDifal.RecordDifalFCP.fltBcuFde) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.RecordDifalFCP.fltBcuFde)+''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{'+ FloatToStr(FResultadoDifal.RecordDifalFCP.fltPerPar) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosDifal.RecordDifalFCP.fltPerPar)+''')));');


    Result.Add('end;')
  Finally

  End;

end;

function fGerarLogParametrosSaidaFCPDifal: TStringList;
Begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('            CompararValores(ReturnValue.AliquotaDifalDoItem{'+ FloatToStr(FResultadoFCPDifal.AliquotaDifalDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCPDifal.AliquotaDifalDoItem) +''')) And');
    Result.Add('            CompararValores(ReturnValue.IcmsDeOrigem{'+ FloatToStr(FResultadoFCPDifal.IcmsDeOrigem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCPDifal.IcmsDeOrigem) +''')) And');
    Result.Add('            CompararValores(ReturnValue.IcmsDeDestino{'+ FloatToStr(FResultadoFCPDifal.IcmsDeDestino) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCPDifal.IcmsDeDestino) +''')) And');
    Result.Add('            CompararValores(ReturnValue.BaseFCP{'+ FloatToStr(FResultadoFCPDifal.BaseFCP) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCPDifal.BaseFCP) +''')) And');
    Result.Add('            CompararValores(ReturnValue.ValorFCP{'+ FloatToStr(FResultadoFCPDifal.ValorFCP) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCPDifal.ValorFCP)+''')));');
    Result.Add('end;')
  Finally

  End;
End;

function fGerarLogParametrosSaidaIpi : TStringList;
begin

  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('            CompararValores(ReturnValue.ValorCalculadoIPI{'+ FloatToStr(FResultadoIpi.ValorCalculadoIPI)+'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIPI.ValorCalculadoIPI) +''')) And');
    Result.Add('            CompararValores(ReturnValue.BaseDeCalculoIPI{'+ FloatToStr(FResultadoIpi.BaseDeCalculoIPI) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIPI.BaseDeCalculoIPI) +''')) And');
    Result.Add('            CompararValores(ReturnValue.AliquotaDeCalculoIPI{'+ FloatToStr(FResultadoIpi.AliquotaDeCalculoIPI) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIPI.AliquotaDeCalculoIPI) +''')));');
    Result.Add('end;')

  Finally

  End;

end;

function fGerarLogParametrosSaidaIcmsEfetivo: TStringList;
begin

  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('            CompararValores(ReturnValue.PercentualReducaoBaseCalcEfetivaItem{'+ FloatToStr(FResultadoIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem)+'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsEfetivo.PercentualReducaoBaseCalcEfetivaItem) +''')) And');
    Result.Add('            CompararValores(ReturnValue.ValorBaseCalculoEfetivaItem{'+ FloatToStr(FResultadoIcmsEfetivo.ValorBaseCalculoEfetivaItem)+'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsEfetivo.ValorBaseCalculoEfetivaItem) +''')) And');
    Result.Add('            CompararValores(ReturnValue.AliquotaIcmsEfetivaItem{'+ FloatToStr(FResultadoIcmsEfetivo.AliquotaIcmsEfetivaItem)+'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsEfetivo.AliquotaIcmsEfetivaItem) +''')) And');
    Result.Add('            CompararValores(ReturnValue.ValorIcmsEfetivaItem{'+ FloatToStr(FResultadoIcmsEfetivo.ValorIcmsEfetivaItem)+'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsEfetivo.ValorIcmsEfetivaItem) +''')) And');
    Result.Add('            CompararValores(ReturnValue.ValorBaseCalculoIcmsStRetidoItem{'+ FloatToStr(FResultadoIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem)+'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsEfetivo.ValorBaseCalculoIcmsStRetidoItem) +''')) And');
    Result.Add('            CompararValores(ReturnValue.ValorIcmsStRetidoItem{'+ FloatToStr(FResultadoIcmsEfetivo.ValorIcmsStRetidoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsEfetivo.ValorIcmsStRetidoItem) +''')));');
    Result.Add('end;')
  Finally

  End;

end;



function fGerarLogParametrosSaidaFCP : TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('            CompararValores(ReturnValue.BaseDestino{'+ FloatToStr(FResultadoFCP.BaseDestino)+'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCP.BaseDestino) +''')) And');
    Result.Add('            CompararValores(ReturnValue.BaseFCP{'+ FloatToStr(FResultadoFCP.BaseFCP) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCP.BaseFCP) +''')) And');
    Result.Add('            CompararValores(ReturnValue.ValorFCP{'+ FloatToStr(FResultadoFCP.ValorFCP) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCP.ValorFCP) +''')) And');
    Result.Add('            CompararValores(ReturnValue.AliquotaDoFCPDoItem{'+ FloatToStr(FResultadoFCP.AliquotaDoFCPDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFCP.AliquotaDoFCPDoItem) +''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{'+ FloatToStr(FResultadoFcp.RecordDifalFCP.fltValFcp) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFcp.RecordDifalFCP.fltValFcp) +''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{'+ FloatToStr(FResultadoFcp.RecordDifalFCP.fltPerFcp) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFcp.RecordDifalFCP.fltPerFcp) +''')) And');
    Result.Add('            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{'+ FloatToStr(FResultadoFcp.RecordDifalFCP.fltBasFcp) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosFcp.RecordDifalFCP.fltBasFcp) +''')));');
    Result.Add('end;')

  Finally

  End;

end;

function fGerarLogParametrosSaida(AMetodoImposto : String) : TStringList;
begin
  Try
    Result := TStringList.Create;

    Case fRetonarCaseOpcaoSelecionada(AMetodoImposto) Of
      0: Begin
           Result.Add(fGerarLogParametrosSaidaIcmsOrgaoPublico.Text);
           fGerarLogParametrosSaidaIcmsOrgaoPublico.Free;
         End;
      1 : begin
            Result.Add(fGerarLogParametrosSaidaIcmsEfetivo.Text);
            fGerarLogParametrosSaidaIcmsEfetivo.Free;
          end;
      2 : begin
            Result.Add(fGerarLogParametrosSaidaIpi.Text);
            fGerarLogParametrosSaidaIpi.Free;
          end;
      3:  begin
            Result.Add(fGerarLogParametrosSaidaSTCustoAquisicao.Text);
            fGerarLogParametrosSaidaSTCustoAquisicao.Free;
          end;
      4: Begin
           Result.Add(fGerarLogParametrosSaidaIcms.Text);
           fGerarLogParametrosSaidaIcms.Free;
         End;
      5: Begin
           Result.Add(fGerarLogParametrosSaidaST.Text);
           fGerarLogParametrosSaidaST.Free;
         End;
      6: Begin
           Result.Add(fGerarLogParametrosSaidaDifal.Text);
           fGerarLogParametrosSaidaDifal.Free;
         End;
      7: Begin
           Result.Add(fGerarLogParametrosSaidaFCP.Text);
           fGerarLogParametrosSaidaFCP.Free;
         End;
      8: Begin
           Result.Add(fGerarLogParametrosSaidaFCPDifal.Text);
           fGerarLogParametrosSaidaFCPDifal.Free;
         End;
      9: Begin
           Result.Add(fGerarLogParametrosSaidaCfop.Text);
           fGerarLogParametrosSaidaCfop.Free;
         End;
      10: Begin
           Result.Add(fGerarLogParametrosSaidaPrecoCustoRealVenda.Text);
           fGerarLogParametrosSaidaPrecoCustoRealVenda.Free;
         End;
      11: Begin
           Result.Add(fGerarLogParametrosSaidaPrecoCustoMargemMarkup.Text);
           fGerarLogParametrosSaidaPrecoCustoMargemMarkup.Free;
         End;
      12: Begin
           Result.Add(fGerarLogParametrosSaidaMargemVenda.Text);
           fGerarLogParametrosSaidaMargemVenda.Free;
         End;

    End;

  finally

  end;
end;

function fRetornaNomePastaImposto(const ANomeMetodo: string): string;
begin
  Result := EmptyStr;

  Case fRetonarCaseOpcaoSelecionada(ANomeMetodo) of
    0 : Result := FOLDER_ORGAOPUBLICO;
    1 : Result := FOLDER_ICMSEFETIVO;
    2 : Result := FOLDER_IPI;
    3:  Result := FOLDER_STCUSTOAQUISICAO;
    4:  Result := FOLDER_ICMS;
    5:  Result := FOLDER_ST;
    6:  Result := FOLDER_DIFAL;
    7:  Result := FOLDER_FCP;
    8:  Result := FOLDER_FCPDIFAL;
    9:  Result := FOLDER_CFOP;
    10:  Result := FOLDER_PRECOCUSTOREALVENDA;
    11:  Result := FOLDER_PRECOCUSTOMARGEMMARKUP;
    12:  Result := FOLDER_MARGEMVENDA;
  end

end;

procedure pLimparVariaveisTesteUnitario;
begin
  LLogIcmsEfetivo      := EmptyStr;
  LLogOrgaoPublico     := EmptyStr;

  LLogIpi              := EmptyStr;
  LLogSTCustoAquisicao := EmptyStr;
  LLogIcms             := EmptyStr;
  LLogSt               := EmptyStr;

  LLogFcp              := EmptyStr;
  LLogFcpDifal         := EmptyStr;
  LLogDifal            := EmptyStr;
  LLogCFOP             := EmptyStr;

  LLogPrecoCustoRealVenda    := EmptyStr;
  LLogPrecoCustoMargemMarkup := EmptyStr;
  LLogMargemVenda            := EmptyStr;
end;


procedure pGravaLogImposto(ALogImposto : String; AFolder : String);
begin
  if (fEmptyStr(ALogImposto)) then
    Exit;

  pGravarArquivoLogTesteUnitario(AFolder, ALogImposto);
end;

function RetornarDadosIniciais(const AMetodoImposto: String): string;
begin
  Case fRetonarCaseOpcaoSelecionada(AMetodoImposto) Of
    0: Result := EmptyStr;
    1: Result := EmptyStr;
    2: Result := EmptyStr;
    3: Result := EmptyStr;
    4: Result := EmptyStr;
    5: Result := EmptyStr;
    6: Result := RetornarDadosIniciaisDifal;
    7: Result := EmptyStr;
    8: Result := EmptyStr;
    9: Result := EmptyStr;
    10: Result := EmptyStr;
    11: Result := EmptyStr;
    12: Result := EmptyStr;
  End;
end;

function fGetVariavelLogIcms: String;
begin
  Result := LLogIcms;
end;

function RetornarDadosIniciaisDifal: string;
begin
  Result := EmptyStr;
  Result := Result + '  FRecordDifalFCP.fltAlDifa := ' + AjustarValorString(FloatToStr(AParametrosDifal.RecordDifalFCP.fltAlDifa)) + ';' + #13#10;
  Result := Result + '  FRecordDifalFCP.fltDifDes := ' + AjustarValorString(FloatToStr(AParametrosDifal.RecordDifalFCP.fltDifDes)) + ';' + #13#10;
  Result := Result + '  FRecordDifalFCP.fltDifOri := ' + AjustarValorString(FloatToStr(AParametrosDifal.RecordDifalFCP.fltDifOri)) + ';' + #13#10;
  Result := Result + '  FRecordDifalFCP.fltAlqIne := ' + AjustarValorString(FloatToStr(AParametrosDifal.RecordDifalFCP.fltAlqIne)) + ';' + #13#10;
  Result := Result + '  FRecordDifalFCP.fltAlqUfd := ' + AjustarValorString(FloatToStr(AParametrosDifal.RecordDifalFCP.fltAlqUfd)) + ';' + #13#10;
  Result := Result + '  FRecordDifalFCP.fltBcuFde := ' + AjustarValorString(FloatToStr(AParametrosDifal.RecordDifalFCP.fltBcuFde)) + ';' + #13#10;
  Result := Result + '  FRecordDifalFCP.fltPerPar := ' + AjustarValorString(FloatToStr(AParametrosDifal.RecordDifalFCP.fltPerPar)) + ';' + #13#10;
end;

procedure SetarParametrosComparacao(AParametrosComparacao: IParametrosComparacaoIcms);
begin
  AParametrosIcms := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoST);
begin
  AParametrosST := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao: IParametrosComparacaoIpi);
begin
  AParametrosIpi:= AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoIcmsOrgaoPublico); overload;
begin
  AParametrosIcmsOrgaoPublico := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao: IParametrosComparacaoIcmsEfetivo);
begin
  AParametrosIcmsEfetivo:= AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoStCustoAquisicao); overload;
begin
  AParametrosStCustoAquisicao := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoPrecoCustoRealVenda); overload;
begin
  AParametrosPrecoCustoRealVenda := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoPrecoCustoMargemMarkup); overload;
begin
  AParametrosPrecoCustoMargemMarkup := AParametrosComparacao;
end;

procedure SetarParametrosComparacao(AParametrosComparacao : IParametrosComparacaoMargemVenda); overload;
begin
  AParametrosMargemVenda := AParametrosComparacao;
end;


function fGerarLogParametrosSaidaIcms: TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('           CompararValores(ReturnValue.AliquotaDoIcms{'+ FloatToStr(FResultadoIcms.AliquotaDoIcms) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcms.AliquotaDoIcms) +''')) And');
    Result.Add('           CompararValores(ReturnValue.BaseDeCalculoDoIcms{'+ FloatToStr(FResultadoIcms.BaseDeCalculoDoIcms) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcms.BaseDeCalculoDoIcms) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorCalculadoDoIcms{'+ FloatToStr(FResultadoIcms.ValorCalculadoDoIcms) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcms.ValorCalculadoDoIcms)+''')) And');
    Result.Add('           CompararValores(ReturnValue.PercentualDaBaseDeIcms{'+ FloatToStr(FResultadoIcms.PercentualDaBaseDeIcms) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcms.PercentualDaBaseDeIcms)+''')) And');
    Result.Add('           CompararValores(ReturnValue.PercentualDeReducaoDaBaseDeIcms{'+ FloatToStr(FResultadoIcms.PercentualDeReducaoDaBaseDeIcms) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcms.PercentualDeReducaoDaBaseDeIcms)+''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorDaDiferencaDeIcms{'+ FloatToStr(FResultadoIcms.ValorDaDiferencaDeIcms) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcms.ValorDaDiferencaDeIcms)+''')));');
    Result.Add('end;')
  Finally

  End;
end;

function fGerarLogParametrosSaidaST: TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('           CompararValores(ReturnValue.BaseDeCalculoDaSubstituicaoTributariaDoItem{'+ FloatToStr(FResultadoST.BaseDeCalculoDaSubstituicaoTributariaDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosST.BaseDeCalculoDaSubstituicaoTributariaDoItem) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorDaSubstituicaoTributariaDoItem{'+ FloatToStr(FResultadoST.ValorDaSubstituicaoTributariaDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosST.ValorDaSubstituicaoTributariaDoItem) +''')) And');
    Result.Add('           CompararValores(ReturnValue.PercentualDaSubstituicaoDaBase{'+ FloatToStr(FResultadoST.PercentualDaSubstituicaoDaBase) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosST.PercentualDaSubstituicaoDaBase) +''')) And');
    Result.Add('           CompararValores(ReturnValue.PercentualDoFCPDoItem{'+ FloatToStr(FResultadoST.PercentualDoFCPDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosST.PercentualDoFCPDoItem)+''')) And');
//    Result.Add('           CompararValores(ReturnValue.BaseDaSubstituicaoTributariaSimulada{'+ FloatToStr(FResultadoST.BaseDaSubstituicaoTributariaSimulada) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosST.BaseDaSubstituicaoTributariaSimulada)+''')) And');
//    Result.Add('           CompararValores(ReturnValue.ValorDoIvaMatriz{'+ FloatToStr(FResultadoST.ValorDoIvaMatriz) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosST.ValorDoIvaMatriz)+''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorDoFCPDoItem{'+ FloatToStr(FResultadoST.ValorDoFCPDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosST.ValorDoFCPDoItem)+''')));');
    Result.Add('end;')

  Finally

  End;
end;

function fGerarLogParametrosSaidaIcmsOrgaoPublico: TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{'+ FloatToStr(FResultadoIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsOrgaoPublico.BaseDeIcmsDeOrgaoPublicoDoItem) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{'+ FloatToStr(FResultadoIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsOrgaoPublico.ValorDoIcmsDeOrgaoPublicoDoItem) +''')));');
//    Result.Add('           CompararValores(ReturnValue.TotalDaBaseDeIcmsDeOrgaoPublico{'+ FloatToStr(FResultadoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublico) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublico) +''')) And');
//    Result.Add('           CompararValores(ReturnValue.AliquotaDeIcmsDoItem{'+ FloatToStr(FResultadoIcmsOrgaoPublico.AliquotaDeIcmsDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsOrgaoPublico.AliquotaDeIcmsDoItem)+''')) And');
//    Result.Add('           CompararValores(ReturnValue.BaseDeCalculoDoIcmsDoItem{'+ FloatToStr(FResultadoIcmsOrgaoPublico.BaseDeCalculoDoIcmsDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsOrgaoPublico.BaseDeCalculoDoIcmsDoItem)+''')) And');
//    Result.Add('           CompararValores(ReturnValue.ValorDoIcmsDoItem{'+ FloatToStr(FResultadoIcmsOrgaoPublico.ValorDoIcmsDoItem) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsOrgaoPublico.ValorDoIcmsDoItem)+''')) And');
//    Result.Add('           CompararValores(ReturnValue.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao{'+ FloatToStr(FResultadoIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsOrgaoPublico.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao)+''')) And');
//    Result.Add('           CompararValores(ReturnValue.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao{'+ FloatToStr(FResultadoIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosIcmsOrgaoPublico.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao)+''')));');
    Result.Add('end;')
  Finally

  End;
end;

function fGerarLogParametrosSaidaPrecoCustoRealVenda: TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{'+ FloatToStr(FResultadoPrecoCusto.ValorCalculadoPrecoCusto) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosPrecoCustoRealVenda.TotalDoPrecoCustoRealVenda) +''')));');
    Result.Add('end;')
  Finally

  End;
end;

function fGerarLogParametrosSaidaPrecoCustoMargemMarkup: TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('           CompararValores(ReturnValue.ValorCalculadoPrecoCusto{'+ FloatToStr(FResultadoPrecoCusto.ValorCalculadoPrecoCusto) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosPrecoCustoMargemMarkup.TotalDoPrecoCusto) +''')));');
    Result.Add('end;')
  Finally

  End;
end;

function fGerarLogParametrosSaidaMargemVenda: TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPrecoIdeal{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPrecoIdeal) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPrecoIdeal) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPraticada{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPraticada) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPraticada) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPraticadaSemDespesasOperacionais{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPrecoMedio{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPrecoMedio) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPrecoMedio) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPrecoUltimaCompraComImpostos{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemProposta{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemProposta) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemProposta) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemMinima{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemMinima) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemMinima) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioCustoRealComMargemZero{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioCustoRealComMargemZero) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioCustoRealComMargemZero) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPraticadaCustoReal{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPraticadaCustoReal) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPraticadaCustoReal) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPropostaCustoReal{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPropostaCustoReal) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPropostaCustoReal) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPropostaCusto{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPropostaCusto) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPropostaCusto) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemPraticadaCusto{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemPraticadaCusto) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemPraticadaCusto) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemBrutaPraticadaPrecoMedio{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemLiquidaPraticadaPrecoMedio{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioMarkupPraticado{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMarkupPraticado) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMarkupPraticado) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioMarkupPraticadoSemDespesasOperacionais{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioMarkupProposto{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMarkupProposto) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMarkupProposto) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioMarkupPrecoMedio{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMarkupPrecoMedio) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMarkupPrecoMedio) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorUnitarioMarkupPrecoUltimaCompraComImpostos{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioItemMargemPrecoMedio{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioItemMargemPrecoMedio) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioItemMargemPrecoMedio) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioItemMargemProposta{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioItemMargemProposta) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioItemMargemProposta) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorUnitarioItemMargemPraticadaLucro{'+ FloatToStr(FResultadoMargemVenda.ValorUnitarioItemMargemPraticadaLucro) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorUnitarioItemMargemPraticadaLucro) +''')) And');
	  Result.Add('           CompararValores(ReturnValue.ValorMargemCat17{'+ FloatToStr(FResultadoMargemVenda.ValorMargemCat17) +'},objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosMargemVenda.ValorMargemCat17) +''')));');
    Result.Add('end;')
  Finally

  End;
end;


function fGerarLogParametrosSaidaStCustoAquisicao: TStringList;
begin
  Try
    Result := TStringList.Create;
    Result.Add('');
    Result.Add('  CheckTrue( ');
    Result.Add('           CompararValores(ReturnValue.BaseDaSTCustoAquisicao{'+ FloatToStr(FResultadoStCustoAquisicao.BaseDaSTCustoAquisicao) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosStCustoAquisicao.BaseDaSTCustoAquisicao) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorDaSTCustoAquisicao{'+ FloatToStr(FResultadoStCustoAquisicao.ValorDaSTCustoAquisicao) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosStCustoAquisicao.ValorDaSTCustoAquisicao) +''')) And');
    Result.Add('           CompararValores(ReturnValue.ValorDoIcmsOperacoesProprias{'+ FloatToStr(FResultadoStCustoAquisicao.ValorDoIcmsOperacoesProprias) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosStCustoAquisicao.ValorDoIcmsOperacoesProprias) +''')));');
//    Result.Add('           CompararValores(ReturnValue.FatorPositivo{'+ FloatToStr(FResultadoStCustoAquisicao.FatorPositivo) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosStCustoAquisicao.FatorPositivo)+''')) And');
//    Result.Add('           CompararValores(ReturnValue.FatorNegativo{'+ FloatToStr(FResultadoStCustoAquisicao.FatorNegativo) +'}, objFloatUtils.fStrToFloat('''+ FloatToStr(AParametrosStCustoAquisicao.FatorNegativo)+''')));');
    Result.Add('end;')

  Finally

  End;
end;


procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoRegraClassificacaoItem); Overload;
begin
  FResultadoCFOP := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoDifal);Overload;
begin
  FResultadoDifal := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoDifalFCP);Overload;
begin
  FResultadoFCPDifal := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoIcms);Overload;
begin
  FResultadoIcms := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoFCP);Overload;
begin
  FResultadoFCP := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoST);Overload;
begin
  FResultadoST := AResultadoComparacao;
end;
procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoIPI);Overload;
begin
  FResultadoIpi := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoIcmsOrgaoPublico); Overload;
begin
  FResultadoIcmsOrgaoPublico := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoIcmsEfetivo);Overload;
begin
  FResultadoIcmsEfetivo := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoStCustoAquisicao);Overload;
begin
  FResultadoStCustoAquisicao := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoPrecoCusto);Overload;
begin
  FResultadoPrecoCusto := AResultadoComparacao;
end;

procedure SetarResultadosComparacao(const AResultadoComparacao : IResultadoCalculoMargemVenda);Overload;
begin
  FResultadoMargemVenda := AResultadoComparacao;
end;



end.
