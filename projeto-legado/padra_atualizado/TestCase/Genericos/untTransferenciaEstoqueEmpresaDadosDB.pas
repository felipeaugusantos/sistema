unit untTransferenciaEstoqueEmpresaDadosDB;

interface

uses Faturamento.Impostos.Interfaces.ClassificacaoItem.TransferenciaEstoqueEmpresa,
  Faturamento.Impostos.Tipos.ClassificacaoItem.TransferenciaEstoqueEmpresa,
  untFuncoes, Uni, DB, System.SysUtils;

type
  TTransferenciaEstoqueEmpresaDadosDB = class(TInterfacedObject, ITransferenciaEstoqueEmpresaDadosDB)
  public
    function TransferenciaEstoqueEmpresa(ASQL: String; ACodigoDoCliente:
      String; ACodigoDaEmpresa: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
    class function New: ITransferenciaEstoqueEmpresaDadosDB;
  end;


implementation

{ TTransferenciaEstoqueEmpresaDadosDB }

class function TTransferenciaEstoqueEmpresaDadosDB.New: ITransferenciaEstoqueEmpresaDadosDB;
begin
  Result := Self.Create;
end;

function TTransferenciaEstoqueEmpresaDadosDB.TransferenciaEstoqueEmpresa(ASQL,
  ACodigoDoCliente, ACodigoDaEmpresa: String): IResultadoClassificacaoItemTransferenciaEstoqueEmpresa;
  Var
    qryEmp: TUniQuery;
begin
  qryEmp := fCriaQuery(Nil);
  Try
    With qryEmp Do
    Begin
      SQL.Clear;
      SQL.Add(ASQL);
      ParamByName('CODCLI').AsString := ACodigoDoCliente;
      ParamByName('CODEMP').AsString := ACodigoDaEmpresa;
      Open;

      Result :=
        TResultadoClassificacaoItemTransferenciaEstoqueEmpresa.New
          .TipoDeOperacao(FieldByName('TIPOPE').AsString)
          .ClassificacaoDeVendaTributadoSaida(FieldByName('EMP_CLAT01').AsString)
          .ClassificacaoDeVendaSubstCombLubrificanteSaida(FieldByName('EMP_CLAT02').AsString)
          .ClassificacaoDeVendaSubstDemaisProdutosSaida(FieldByName('EMP_CLAT03').AsString)

          .ClassificacaoDeTransferenciaTributadoSaida(FieldByName('EMP_CLATT1').AsString)
          .ClassificacaoDeTransferenciaSubstCombLubrificanteSaida(FieldByName('EMP_CLATT2').AsString)
          .ClassificacaoDeTransferenciaSubstDemaisProdutosSaida(FieldByName('EMP_CLATT3').AsString)

          .ClassificacaoDeCompraSubstDemaisProdutosEntrada(FieldByName('EMP_CLTEV2').AsString)
          .ClassificacaoDeCompraTributadoEntrada(FieldByName('EMP_CLTEV1').AsString)

          .ClassificacaoDeTransferenciaSubstDemaisProdutosEntrada(FieldByName('EMP_CLATE2').AsString)
          .ClassificacaoDeTransferenciaTributadoEntrada(FieldByName('EMP_CLATE1').AsString)

          .RetornouInformacoes(Not IsEmpty);
    End;
  Finally
    FreeAndNil(qryEmp);
  End;
end;

initialization

SetObjTransferenciaEstoqueEmpresaDadosDB(TTransferenciaEstoqueEmpresaDadosDB.New());

end.
