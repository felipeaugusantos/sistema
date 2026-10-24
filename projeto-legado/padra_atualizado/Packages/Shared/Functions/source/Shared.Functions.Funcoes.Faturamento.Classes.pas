unit Shared.Functions.Funcoes.Faturamento.Classes;

interface

Uses System.StrUtils,
     System.SysUtils,
     Shared.Functions.Configuracoes,
     Shared.Functions.FloatUtils,
     Shared.Functions.Constantes,
     Shared.Functions.Funcoes.Faturamento,
     System.DateUtils,
     Shared.Functions.Types,
     System.Classes;

Type
  TFunctionFuncoesFaturamentoClasses = Class
  Public
    class function RetornarNotaDeImportacao(
      AClassificacaoFiscalDoItem: String): String; static;

    Class function VendaDentroDoEstado(AEstadoEntrega, AEmpresaEstado: String;
      AVendaPresencial: Boolean): Boolean;


  End;

implementation


Class function TFunctionFuncoesFaturamentoClasses.RetornarNotaDeImportacao(AClassificacaoFiscalDoItem : String): String;
begin
  Result := 'S';

  If Copy(AClassificacaoFiscalDoItem,1,1) = '3' Then
    Exit;

  Result := 'N';
end;

Class function TFunctionFuncoesFaturamentoClasses.
  VendaDentroDoEstado(AEstadoEntrega, AEmpresaEstado : String;
  AVendaPresencial :Boolean ): Boolean;
Var
  LDentroDoEstado : Boolean;
begin
  LDentroDoEstado :=
    TFunctionFuncoesFaturamento.
      fDentroDoEstado(AEstadoEntrega,
                      AEmpresaEstado);

  Result :=
    TFunctionFuncoesFaturamento.
      fDentroDoEstadoFaturamento(LDentroDoEstado,
                                 AVendaPresencial);
end;


end.
