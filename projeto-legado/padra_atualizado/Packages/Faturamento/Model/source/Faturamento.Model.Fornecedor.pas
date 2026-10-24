unit Faturamento.Model.Fornecedor;

interface
uses
  Faturamento.Impostos.Interfaces.Model,
  Faturamento.Impostos.Tipos.Model,
  Shared.Functions.Core,
  Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.DataSet;

type
  TFaturamentoImpostosModelFornecedor = class(TInterfacedObject, IFaturamentoImpostosModelFornecedor)
  public
    function Consultar(const ACodigoDoFornecedor: String): IResultadoFaturamentoImpostosModelClienteFornecedor;


    class function New(): IFaturamentoImpostosModelFornecedor;
  end;

implementation

{ TFaturamentoImpostosModelFornecedor }

function TFaturamentoImpostosModelFornecedor.Consultar(const ACodigoDoFornecedor: String): IResultadoFaturamentoImpostosModelClienteFornecedor;
var
  LSituacaoDoIpi: String;
  LZonaFranca: Boolean;
  LOrgaoPublico: Boolean;
  LFornecedorExterior: Boolean;
  LFornecedorEstado: String;
  LInscricaoEstadual : String;
  LFornecedorFisJur  : String;
  LFornecedorSimples : String;

  LRetornoCampoTabela: IMyCampoTabela;

begin
  LRetornoCampoTabela :=
    objCore.fCampoTabela(['CID_ESTADO AS FOR_ESTADO', 'FOR_I_E_S_', 'FOR_CGCCPF', 'FOR_SIMPAU'],
                         'CADFOR JOIN CADCID ON CID_CODCID = FOR_CODCID',
                         ['FOR_CODFOR'],
                         [ACodigoDoFornecedor],
                         False);


  LSituacaoDoIpi        := '';
  LZonaFranca           := False;
  LOrgaoPublico         := False;
  LFornecedorEstado     := LRetornoCampoTabela.FieldByName('FOR_ESTADO');
  LFornecedorExterior   := LFornecedorEstado = 'EX';

  LInscricaoEstadual    := LRetornoCampoTabela.FieldByName('FOR_I_E_S_');
  LFornecedorSimples    := LRetornoCampoTabela.FieldByName('FOR_SIMPAU');

  LFornecedorFisJur :=
    TFunctionFuncoesFaturamento
      .RetornarClienteFisicoOuJuridico(LRetornoCampoTabela.FieldByName('FOR_CGCCPF').AsInteger);

  Result :=
    TResultadoFaturamentoImpostosModelClienteFornecedor.New
      .Codigo(ACodigoDoFornecedor)
      .SituacaoDoIpi(LSituacaoDoIpi)
      .ZonaFranca(LZonaFranca)
      .OrgaoPublico(LOrgaoPublico)
      .ClienteExterior(LFornecedorExterior)
      .ClienteEstado(LFornecedorEstado)
      .ClienteEstadoEntrega('')
      .ClienteInscricaoEstadual(LInscricaoEstadual)
      .ClienteFisJur(LFornecedorFisJur)
      .FornecedorSimples((LFornecedorSimples = 'S'))
      .ConsumidorFinal(False);

end;

class function TFaturamentoImpostosModelFornecedor.New: IFaturamentoImpostosModelFornecedor;
begin
  Result := Self.Create;
end;

end.
