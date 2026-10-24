unit untFatCalcularImpostos;

interface

uses
  Rest.Json, Winapi.Windows, System.SysUtils, Forms, Classes,
  Faturamento.Impostos.Interfaces.Difal,
  Faturamento.Impostos.Interfaces.FCP,
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Interfaces.Ipi,
  Faturamento.Impostos.Interfaces.Icms,
  Faturamento.Impostos.Interfaces.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.ST,
  Faturamento.Impostos.Interfaces.StCustoAquisicao,
  Faturamento.Impostos.Interfaces.IcmsOrgaoPublico,

  untParametrosComparacaoIcmsEfetivo,
  untParametrosResultadoIcmsEfetivo,
  untParametrosResultadoST,
  untParametrosComparacaoST,
  untParametrosResultadoStCustoAquisicao,
  untParametrosComparacaoStCustoAquisicao,
  untParametrosResultadoDifal,
  untParametrosComparacaoDifal,
  untParametrosResultadoIcms,
  untParametrosComparacaoIcms,
  untParametrosComparacaoFcp,
  untParametrosResultadoFcp,
  untParametrosComparacaoIPI,
  untParametrosResultadoIPI,
  untParametrosResultadoIcmsOrgaoPublico,
  untParametrosComparacaoIcmsOrgaoPublico;

  function CalcularValorDifal(AParametros: IParametrosCalculoDifal; AResultado : IParametrosResultadoDifal): IResultadoCalculoDifal;
  function CalcularValorFCPDifal(AParametros: IParametrosCalculoDifalFCP; AResultado : IParametrosResutladoDifalFCP): IResultadoCalculoDifalFCP;
  function CalcularValorICMS(AParametros: IParametrosCalculoIcms; AResultado: IParametrosResultadoIcms): IResultadoCalculoIcms;
  function CalcularValorFCP(AParametros: IParametrosCalculoFCP; AResultado: IParametrosResultadoFcp): IResultadoCalculoFCP;
  function CalcularValorST(AParametros: IParametrosCalculoST; AResultado: IParametrosResultadoST): IResultadoCalculoST;
//  function CalcularValorIPI(AParametros: IParametrosCalculoIPI; AResultado: IParametrosResultadoIPI): IResultadoCalculoIPI;
//  function CalcularValorIcmsOrgaoPublico(AParametros: IParametrosCalculoIcmsOrgaoPublico; AResultado: IParametrosResultadoIcmsOrgaoPublico): IResultadoCalculoIcmsOrgaoPublico;
  function CalcularValorIcmsEfetivo(AParametros: IParametrosCalculoIcmsEfetivo; AResultado: IParametrosResultadoIcmsEfetivo): IResultadoCalculoIcmsEfetivo;
//  function CalcularValorStCustoAquisicao(AParametros: IParametrosCalculoStCustoAquisicao; AResultado: IParametrosResultadoStCustoAquisicao): IResultadoCalculoStCustoAquisicao;

implementation

uses
  Faturamento.Impostos.Calculos.TesteUnitarioLog;

var
  FaturamentoImpostosBplHandle: THandle;

Const
  FaturamentoImpostosBpl = 'faturamento.impostos.calculos.bpl';

function GetFaturamentoImpostosBpl: THandle;
begin
  If FaturamentoImpostosBplHandle = 0 Then
    FaturamentoImpostosBplHandle := LoadPackage(FaturamentoImpostosBpl);
  Result := FaturamentoImpostosBplHandle;
end;

function CalcularValorDifal(AParametros: IParametrosCalculoDifal; AResultado : IParametrosResultadoDifal): IResultadoCalculoDifal;
Var
  LCalcularValorDifal : function(AParametros: IParametrosCalculoDifal): IResultadoCalculoDifal; StdCall;
begin
  LCalcularValorDifal:= GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorDifal'));
  Result := LCalcularValorDifal(AParametros);
  SetarResultadosComparacao(Result);

  SetarParametrosComparacao(
    TParametrosComparacaoDifal.New()
      .TipoOperacao('Difal')
      .ValorBaseDestino(AResultado.ValorBaseDestino)
      .ValorIcmsDestino(AResultado.ValorIcmsDestino)
      .ValorIcmsOrigem(AResultado.ValorIcmsOrigem)
      .AliquotaInterestadualCalc(AResultado.AliquotaInterestadualCalc)
      .RecordDifalFCP(AResultado.RecordDifalFCP));

  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), Nil, 'CalcularValorDifal');
end;

function CalcularValorFCPDifal(AParametros: IParametrosCalculoDifalFCP; AResultado : IParametrosResutladoDifalFCP): IResultadoCalculoDifalFCP;
Var
  LCalcularValorFCPDifal : function(AParametros: IParametrosCalculoDifalFCP): IResultadoCalculoDifalFCP; StdCall;
begin
  LCalcularValorFCPDifal := GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorDifalFCP'));
  Result := LCalcularValorFCPDifal(AParametros);
  SetarResultadosComparacao(Result);

  SetarParametrosComparacao(
    TParametrosComparacaoDifalFcp.New()
      .TipoOperacao('DifalFcp')
      .AliquotaDifalDoItem(AResultado.AliquotaDifalDoItem)
      .IcmsDeOrigem(AResultado.IcmsDeOrigem)
      .IcmsDeDestino(AResultado.IcmsDeDestino)
      .BaseFCP(AResultado.BaseFCP)
      .ValorFCP(AResultado.ValorFCP));

  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), Nil, 'CalcularValorDifalFCP');
end;

function CalcularValorICMS(AParametros: IParametrosCalculoIcms; AResultado: IParametrosResultadoIcms): IResultadoCalculoIcms;
Var
  LCalcularValorIcms: function(AParametros: IParametrosCalculoIcms): IResultadoCalculoIcms; StdCall;
begin
  LCalcularValorIcms := GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorIcms'));
  Result := LCalcularValorIcms(AParametros);
  SetarResultadosComparacao(Result);

  SetarParametrosComparacao(
    TParametrosComparacaoIcms.New()
      .TipoOperacao('Icms')
      .AliquotaDoIcms(AResultado.AliquotaDoIcms)
      .BaseDeCalculoDoIcms(AResultado.BaseDeCalculoDoIcms)
      .ValorCalculadoDoIcms(AResultado.ValorCalculadoDoIcms)
      .PercentualDaBaseDeIcms(AResultado.PercentualDaBaseDeIcms)
      .ValorDaDiferencaDeIcms(AResultado.ValorDaDiferencaDeIcms));

  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), Nil, 'CalcularValorIcms');
end;

function CalcularValorFCP(AParametros: IParametrosCalculoFCP; AResultado: IParametrosResultadoFcp): IResultadoCalculoFCP;
Var
  LCalcularValorFCP : function(AParametros: IParametrosCalculoFCP): IResultadoCalculoFCP; StdCall;
begin
  LCalcularValorFCP := GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorFCP'));
  Result := LCalcularValorFCP(AParametros);

  SetarResultadosComparacao(Result);

  SetarParametrosComparacao(
    TParametrosComparacaoFcp.New()
      .BaseDestino(AResultado.BaseDestino)
      .BaseFCP(AResultado.BaseFCP)
      .ValorFCP(AResultado.ValorFCP)
      .AliquotaDoFCPDoItem(AResultado.AliquotaDoFCPDoItem)
      .RecordDifalFCP(AResultado.RecordDifalFCP));

  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), Nil, 'CalcularValorFCP');
end;

function CalcularValorST(AParametros: IParametrosCalculoST; AResultado: IParametrosResultadoST): IResultadoCalculoST;
Var
  LCalcularValorST: function(AParametros: IParametrosCalculoST): IResultadoCalculoST; StdCall;
begin
  LCalcularValorST := GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorST'));
  Result := LCalcularValorST(AParametros);

  SetarResultadosComparacao(Result);

  SetarParametrosComparacao(
    TParametrosComparacaoST.New()
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(AResultado.BaseDeCalculoDaSubstituicaoTributariaDoItem)
      .ValorDaSubstituicaoTributariaDoItem(AResultado.ValorDaSubstituicaoTributariaDoItem)
      .PercentualDoFCPDoItem(AResultado.PercentualDoFCPDoItem)
      .ValorDoFCPDoItem(AResultado.ValorDoFCPDoItem));

  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), Nil, 'CalcularValorST');
end;

//function CalcularValorStCustoAquisicao(AParametros: IParametrosCalculoStCustoAquisicao; AResultado: IParametrosResultadoStCustoAquisicao): IResultadoCalculoStCustoAquisicao;
//Var
//  LCalcularValorStCustoAquisicao: function(AParametros: IParametrosCalculoStCustoAquisicao): IResultadoCalculoStCustoAquisicao; StdCall;
//begin
//  LCalcularValorStCustoAquisicao := GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorSTCustoAquisicao'));
//  Result := LCalcularValorStCustoAquisicao(AParametros);
//
//  SetarResultadosComparacao(Result);
//
//  SetarParametrosComparacao(
//    TParametrosComparacaoStCustoAquisicao.New()
//      .BaseDaSTCustoAquisicao(AResultado.BaseDaSTCustoAquisicao)
//      .ValorDaSTCustoAquisicao(AResultado.ValorDaSTCustoAquisicao)
//      .ValorDoIcmsOperacoesProprias(AResultado.ValorDoIcmsOperacoesProprias)
//      .FatorPositivo(AResultado.FatorPositivo)
//      .FatorNegativo(AResultado.FatorNegativo));
//
//  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), (objCliente as TObject), 'CalcularValorSTCustoAquisicao');
//end;



//function CalcularValorIPI(AParametros: IParametrosCalculoIPI; AResultado: IParametrosResultadoIPI): IResultadoCalculoIPI;
//Var
//  LCalcularValorIPI : function(AParametros: IParametrosCalculoIPI): IResultadoCalculoIPI; StdCall;
//begin
//  LCalcularValorIPI:= GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorIPI'));
//  Result := LCalcularValorIPI(AParametros);
//
//  SetarResultadosComparacao(Result);
//
//  SetarParametrosComparacao(
//    TParametrosComparacaoIpi.New()
//      .ValorCalculadoIPI(AResultado.ValorCalculadoIPI)
//      .BaseDeCalculoIPI(AResultado.BaseDeCalculoIPI));
//
//  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), (objCliente as TObject), 'CalcularValorIPI');
//end;

function CalcularValorIcmsEfetivo(AParametros: IParametrosCalculoIcmsEfetivo; AResultado: IParametrosResultadoIcmsEfetivo): IResultadoCalculoIcmsEfetivo;
Var
  LCalcularValorIcmsEfetivo : function(AParametros: IParametrosCalculoIcmsEfetivo): IResultadoCalculoIcmsEfetivo; StdCall;
begin
  LCalcularValorIcmsEfetivo:= GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorIcmsEfetivo'));
  Result := LCalcularValorIcmsEfetivo(AParametros);

  SetarResultadosComparacao(Result);

  SetarParametrosComparacao(
    TParametrosComparacaoIcmsEfetivo.New()
      .PercentualReducaoBaseCalcEfetivaItem(AResultado.PercentualReducaoBaseCalcEfetivaItem)
      .ValorBaseCalculoEfetivaItem(AResultado.ValorBaseCalculoEfetivaItem)
      .ValorIcmsEfetivaItem(AResultado.ValorIcmsEfetivaItem)
      .AliquotaIcmsEfetivaItem(AResultado.AliquotaIcmsEfetivaItem)
      .ValorBaseCalculoIcmsStRetidoItem(AResultado.ValorBaseCalculoIcmsStRetidoItem)
      .ValorIcmsStRetidoItem(AResultado.ValorIcmsStRetidoItem));

  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), Nil, 'CalcularValorIcmsEfetivo');

end;

//function CalcularValorIcmsOrgaoPublico(AParametros: IParametrosCalculoIcmsOrgaoPublico; AResultado: IParametrosResultadoIcmsOrgaoPublico): IResultadoCalculoIcmsOrgaoPublico;
//Var
//  LCalcularValorIcmsOrgaoPublico : function(AParametros: IParametrosCalculoIcmsOrgaoPublico): IResultadoCalculoIcmsOrgaoPublico; StdCall;
//begin
//  LCalcularValorIcmsOrgaoPublico := GetProcAddress(GetFaturamentoImpostosBpl, PChar('CalcularValorIcmsOrgaoPublico'));
//  Result := LCalcularValorIcmsOrgaoPublico(AParametros);
//
//  SetarResultadosComparacao(Result);
//
//  SetarParametrosComparacao(
//    TParametrosComparacaoIcmsOrgaoPublico.New()
//      .BaseDeIcmsDeOrgaoPublicoDoItem(AResultado.BaseDeIcmsDeOrgaoPublicoDoItem)
//      .ValorDoIcmsDeOrgaoPublicoDoItem(AResultado.ValorDoIcmsDeOrgaoPublicoDoItem)
//      .TotalDaBaseDeIcmsDeOrgaoPublico(AResultado.TotalDaBaseDeIcmsDeOrgaoPublico)
//      .AliquotaDeIcmsDoItem(AResultado.AliquotaDeIcmsDoItem)
//      .BaseDeCalculoDoIcmsDoItem(AResultado.BaseDeCalculoDoIcmsDoItem)
//      .ValorDoIcmsDoItem(AResultado.ValorDoIcmsDoItem)
//      .TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao(AResultado.TotalDaBaseDeIcmsDeOrgaoPublicoConfirmacao)
//      .TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao(AResultado.TotalDoValorDeIcmsDeOrgaoPublicoConfirmacao));
//
//  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), (objCliente as TObject), 'CalcularValorIcmsOrgaoPublico');
//end;

initialization

finalization
  If FaturamentoImpostosBplHandle <> 0 Then
    UnloadPackage(FaturamentoImpostosBplHandle);

end.
