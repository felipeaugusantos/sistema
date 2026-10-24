unit Faturamento.Model.AbreviacaoIcms;

interface

uses
  Faturamento.Impostos.Interfaces.Model, Shared.Functions.DataSet,
  Shared.Functions.Funcoes.Faturamento, Shared.Functions.Core,
  Faturamento.Impostos.Tipos.Model, System.SysUtils, System.StrUtils,
  Shared.Functions.Configuracoes;

type
  TFaturamentoImpostosModelAbreviacaoIcms = class(TInterfacedObject, IFaturamentoImpostosModelAbreviacaoIcms)
  public
    function Consultar(const AParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms): IResultadoFaturamentoImpostosModelAbreviacaoIcms;

    class function New(): IFaturamentoImpostosModelAbreviacaoIcms;
  end;

type
  TFaturamentoImpostosModelAbreviacaoIcmsFornecedor = class(TInterfacedObject, IFaturamentoImpostosModelAbreviacaoIcmsFornecedor)
  public
    function Consultar(const AParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;

    class function New(): IFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
  end;

implementation

{ TFaturamentoImpostosModelAbreviacaoIcms }

function TFaturamentoImpostosModelAbreviacaoIcms.Consultar(
  const AParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcms): IResultadoFaturamentoImpostosModelAbreviacaoIcms;
var
  LRetornoCampoTabela: IMyCampoTabela;
//  LQuery: IMyQuery;
  LAliquotaDeIcms: Double;
  LAliquotaDeSt  : Double;

  LPercentualDaBaseDeIcms: Double;
  LCodigoDaSituacaoTributaria: String;
  LSQL: String;

  LPercentualDeIva: Double;
  LPercentualDaBaseDeSt: Double;

  LCalcularSTSaiCCO: String;
  LCalcularSTSaiPRU: String;
  LCodigoDaAbreviacaoFiscal: String;

  LAliquotaDeFcp: Double;

  LAliquotaInternaEstadoDestino: Double;
  LPerBasDifalOrigem: Double;
  LPerBasDifalDestino: Double;
  LAliquotaEfetivaOrigem: Double;
  LRegistroExiste: Boolean;
  LDecretoReducaoRICMPR: Boolean;
  LAliquotaDiferenciadaRICMPR: Double;
  LAliquotaReduzidaDeSt: Double;
begin
  LAliquotaDiferenciadaRICMPR := 0;

  LSQL := TFunctionFuncoesFaturamento.SqlBuscaAbfIcm(AParametros.CodigoDaEmpresaTE,
                                                     IfThen(AParametros.CodigoDaEmpresaAbf.IsEmpty,
                                                            AParametros.CodigoDaEmpresa,
                                                            AParametros.CodigoDaEmpresaAbf));

  LRetornoCampoTabela :=
    objCore.fCampoTabelaDados(LSQL, ['CODITE', 'CODABF', 'ESTADO'], [AParametros.CodigoDoItem, AParametros.CodigoDaAbreviacaoFiscal, AParametros.Estado]);

  LAliquotaDeIcms := LRetornoCampoTabela.FieldByName('ABF_ALQICM' + AParametros.TipoDaAbreviacaoFiscal);
  LAliquotaDeSt   := LRetornoCampoTabela.FieldByName('ABF_ALQRET' + AParametros.TipoDaAbreviacaoFiscal);
  LAliquotaReduzidaDeSt := LRetornoCampoTabela.FieldByName('ABF_ALQRED' + AParametros.TipoDaAbreviacaoFiscal);
  LPercentualDaBaseDeIcms := LRetornoCampoTabela.FieldByName('ABF_BASICM' + AParametros.TipoDaAbreviacaoFiscal);
  LCodigoDaSituacaoTributaria := LRetornoCampoTabela.FieldByName('ABF_CODSIT' + AParametros.TipoDaAbreviacaoFiscal);
  LPercentualDeIva := LRetornoCampoTabela.FieldByName('ABF_IVA_ST' + AParametros.TipoDaAbreviacaoFiscal);
  LPercentualDaBaseDeSt := LRetornoCampoTabela.FieldByName('ABF_BASRET' + AParametros.TipoDaAbreviacaoFiscal).AsFloat;
  LCalcularSTSaiCCO := LRetornoCampoTabela.FieldByName('ABF_CAL_ST_SAI_CCO').AsString;
  LCalcularSTSaiPRU := LRetornoCampoTabela.FieldByName('ABF_CAL_ST_SAI_PRU').AsString;
  LCodigoDaAbreviacaoFiscal := LRetornoCampoTabela.FieldByName('ABF_CODABF').AsString;
  LAliquotaDeFcp := LRetornoCampoTabela.FieldByName('ABF_ALQFCP' + AParametros.TipoDaAbreviacaoFiscal).AsFloat;

  LAliquotaInternaEstadoDestino := LRetornoCampoTabela.FieldByName('ABF_ALQIED' + AParametros.TipoDaAbreviacaoFiscal).AsFloat;
  LPerBasDifalOrigem := LRetornoCampoTabela.FieldByName('ABF_BASDOR' + AParametros.TipoDaAbreviacaoFiscal).AsFloat;
  LPerBasDifalDestino := LRetornoCampoTabela.FieldByName('ABF_BASDDS' + AParametros.TipoDaAbreviacaoFiscal).AsFloat;

  LAliquotaEfetivaOrigem := LRetornoCampoTabela.FieldByName('ABF_ALQEFO' + AParametros.TipoDaAbreviacaoFiscal).AsFloat;

  LRegistroExiste := Not LRetornoCampoTabela.FieldByName('ABF_CODABF').AsString.IsEmpty;

  LDecretoReducaoRICMPR := LRetornoCampoTabela.FieldByName('ABF_RICMPR' + AParametros.TipoDaAbreviacaoFiscal).AsString = 'S';

  if objConfiguracoes.fGetValorConfiguracao(CFG_UTILIZA_DECRETO_5141_2001_REDUCAO_33_33_RICMS_DA_ABREVIACAO_FISCAL_DIFERENCIADA, varBoolean) then
    LAliquotaDiferenciadaRICMPR := LRetornoCampoTabela.FieldByName('ABF_ALQRIC' + AParametros.TipoDaAbreviacaoFiscal).AsFloat;

  If AParametros.CalculandoPrecoDeVendaComDifal And (LPerBasDifalDestino > 0) Then
  Begin
    LAliquotaInternaEstadoDestino := (LAliquotaInternaEstadoDestino * LPerBasDifalDestino) / 100;
  End;

  if LAliquotaDiferenciadaRICMPR > 0 then
    LDecretoReducaoRICMPR := True;

  Result :=
    TResultadoFaturamentoImpostosModelAbreviacaoIcms.New
      .AliquotaDeIcms(LAliquotaDeIcms)
      .PercentualDaBaseDeIcms(LPercentualDaBaseDeIcms)
      .CodigoDaSituacaoTributaria(LCodigoDaSituacaoTributaria)
      .AliquotaDeST(LAliquotaDeSt)
      .PercentualDeIva(LPercentualDeIva)
      .PercentualDaBaseDeSt(LPercentualDaBaseDeSt)
      .CalcularSTSaiCCO(LCalcularSTSaiCCO)
      .CalcularSTSaiPRU(LCalcularSTSaiPRU)
      .CodigoDaAbreviacaoFiscal(LCodigoDaAbreviacaoFiscal)
      .AliquotaDeFcp(LAliquotaDeFcp)
      .AliquotaInternaEstadoDestino(LAliquotaInternaEstadoDestino)
      .PercentualBaseDifalOrigem(LPerBasDifalOrigem)
      .PercentualBaseDifalDestino(LPerBasDifalDestino)
      .AliquotaEfetivaOrigem(LAliquotaEfetivaOrigem)
      .RegistroExiste(LRegistroExiste)
      .DecretoReducaoRICMPR(LDecretoReducaoRICMPR)
      .AliquotaDiferenciadaRICMPR(LAliquotaDiferenciadaRICMPR)
      .AliquotaReduzidaDeSt(LAliquotaReduzidaDeSt);
end;

class function TFaturamentoImpostosModelAbreviacaoIcms.New: IFaturamentoImpostosModelAbreviacaoIcms;
begin
  Result := Self.Create;
end;

{ TFaturamentoImpostosModelAbreviacaoIcmsFornecedor }

function TFaturamentoImpostosModelAbreviacaoIcmsFornecedor.Consultar(
  const AParametros: IParametrosFaturamentoImpostosModelAbreviacaoIcmsFornecedor): IResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
var
  LSQL: String;
  LRetornoCampoTabela: IMyCampoTabela;

  LPercentualDeIvaFornecedor: Double;
  LAliquotaFatorNegativo: Double;
  LAliquotaOperacoesProprias: Double;
  LPercentualDaBaseDeIcmsFornecedor: Double;
  LPercentualDaBaseDeStFornecedor: Double;
begin
  LSQL := TFunctionFuncoesFaturamento.GetDadosAbf;

  LRetornoCampoTabela :=
    objCore.fCampoTabelaDados(LSQL, ['CODABF', 'ESTADO'], [AParametros.CodigoDaAbreviacaoFiscal, AParametros.Estado]);

  LPercentualDeIvaFornecedor := LRetornoCampoTabela.FieldByName('ABF_IVA_ST' + AParametros.TipoDaAbreviacaoFiscal);
  LAliquotaFatorNegativo := LRetornoCampoTabela.FieldByName('ABF_ALQICM' + AParametros.TipoDaAbreviacaoFiscal);
  LAliquotaOperacoesProprias := LRetornoCampoTabela.FieldByName('ABF_ALQICM' + AParametros.TipoDaAbreviacaoFiscal);
  LPercentualDaBaseDeIcmsFornecedor := LRetornoCampoTabela.FieldByName('ABF_BASICM' + AParametros.TipoDaAbreviacaoFiscal);
  LPercentualDaBaseDeStFornecedor := LRetornoCampoTabela.FieldByName('ABF_BASRET' + AParametros.TipoDaAbreviacaoFiscal).AsFloat;

  Result :=
    TResultadoFaturamentoImpostosModelAbreviacaoIcmsFornecedor.New
      .PercentualDeIvaFornecedor(LPercentualDeIvaFornecedor)
      .AliquotaFatorNegativo(LAliquotaFatorNegativo)
      .AliquotaOperacoesProprias(LAliquotaOperacoesProprias)
      .PercentualDaBaseDeIcmsFornecedor(LPercentualDaBaseDeIcmsFornecedor)
      .PercentualDaBaseDeStFornecedor(LPercentualDaBaseDeStFornecedor);
end;

class function TFaturamentoImpostosModelAbreviacaoIcmsFornecedor.New: IFaturamentoImpostosModelAbreviacaoIcmsFornecedor;
begin
  Result := Self.Create;
end;

end.
