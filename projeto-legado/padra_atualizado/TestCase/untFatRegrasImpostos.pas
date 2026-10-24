unit untFatRegrasImpostos;

interface


uses
  Rest.Json, Winapi.Windows, System.SysUtils, Forms, Classes,
  Faturamento.Impostos.Interfaces.ClassificacaoItem,
  Faturamento.Impostos.Interfaces.ClassificacoesTransferencias,
  Faturamento.Impostos.Interfaces.Difal,
  Faturamento.Impostos.Interfaces.FCP,
  Faturamento.Impostos.Interfaces.Model,
  untParametrosComparacaoCfop,
  Faturamento.Impostos.Interfaces.ZerarImpostos;

  function ClassificacaoDoItem(AParametros: IParametrosRegraClassificacaoItem): IResultadoRegraClassificacaoItem;
  function ClassificacoesTransferencias: IRegraImpostosClassificacoesTransferencias;
  function ZerarImpostos: IRegraImpostosZerarImpostos;

implementation

uses
  Faturamento.Impostos.Calculos.TesteUnitarioLog;

var
  FaturamentoImpostosBplHandle: THandle;

Const
  FaturamentoImpostosBpl = 'faturamento.impostos.regras.bpl';


function GetFaturamentoImpostosBpl: THandle;
begin
  If FaturamentoImpostosBplHandle = 0 Then
    FaturamentoImpostosBplHandle := LoadPackage(FaturamentoImpostosBpl);
  Result := FaturamentoImpostosBplHandle;
end;

function ClassificacaoDoItem(AParametros: IParametrosRegraClassificacaoItem): IResultadoRegraClassificacaoItem;
Var
  LRegraClassificacaoItem : function(AParametros: IParametrosRegraClassificacaoItem): IResultadoRegraClassificacaoItem; StdCall;
begin
  LRegraClassificacaoItem := GetProcAddress(GetFaturamentoImpostosBpl, PChar('ClassificacaoDoItem'));
  Result := LRegraClassificacaoItem(AParametros);
  SetarResultadosComparacao(Result);

  SetarParametrosComparacao(
    TParametrosComparacaoCfop.New()
      .TipoOperacao('CFOP')
      .ClassificacaoDoItem(AParametros.ClassificacaoDoItem)
      .ClassificacaoDeServico(AParametros.ClassificacaoDeServico)
      .CodigoDaSubstituicaoTributariaDoItem(AParametros.CodigoDaSubstituicaoTributariaDoItem));


  pGerarLogTesteUnitario((AParametros as TObject),(Result as TObject), Nil, 'ClassificacaoDoItem');
end;

function ClassificacoesTransferencias: IRegraImpostosClassificacoesTransferencias;
Var
  LRegraClassificacoesTransferencias : function(): IRegraImpostosClassificacoesTransferencias; StdCall;
begin
  LRegraClassificacoesTransferencias := GetProcAddress(GetFaturamentoImpostosBpl, PChar('ClassificacoesTransferencias'));
  Result := LRegraClassificacoesTransferencias;
end;

function ZerarImpostos: IRegraImpostosZerarImpostos;
Var
  LRegraZerarImpostos : function(): IRegraImpostosZerarImpostos; StdCall;
begin
  LRegraZerarImpostos := GetProcAddress(GetFaturamentoImpostosBpl, PChar('ZerarImpostos'));
  Result := LRegraZerarImpostos;
end;

initialization

finalization
  If FaturamentoImpostosBplHandle <> 0 Then
    UnloadPackage(FaturamentoImpostosBplHandle);

end.
