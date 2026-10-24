unit untFatRegrasImpostos;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Winapi.Windows,
{$ENDIF}
  System.SysUtils,
  Faturamento.Impostos.Interfaces.ZerarImpostos,
  Faturamento.Impostos.Interfaces.ClassificacoesTransferencias,
  Faturamento.Impostos.Interfaces.DadosFiscais.Aliquota,
  Faturamento.Impostos.Interfaces.DadosFiscais.ClassificacaoItem,
  Faturamento.Impostos.Interfaces.AliquotasDeRetencao;

  function DadosFiscaisClassificacaoDoItem(AParametros: IParametrosDadosFiscaisClassificacaoItem): IResultadoDadosFiscaisClassificacaoItem;
  function DadosFiscaisAliquotaDoItem(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota;
  function ZerarImpostos: IRegraImpostosZerarImpostos;
  function ClassificacoesTransferencias: IRegraImpostosClassificacoesTransferencias;
  function AliquotasDeRetencao(AParametros : IParametrosAliquotasDeRetencao = Nil) : IResultadoAliquotasDeRetencao;

implementation

uses Controller.Faturamento.Interfaces.Cache;

var
  FaturamentoImpostosBplHandle: THandle;

Const
{$IFDEF LINUX}
  FaturamentoImpostosBpl = 'bplfaturamento.impostos.regras.so';
{$ELSE}
  FaturamentoImpostosBpl = 'faturamento.impostos.regras.bpl';
{$ENDIF}

function GetFaturamentoImpostosBpl: THandle;
begin
  If FaturamentoImpostosBplHandle = 0 Then
    FaturamentoImpostosBplHandle := LoadPackage(FaturamentoImpostosBpl);
  Result := FaturamentoImpostosBplHandle;
end;

function GetFaturamentoImpostosProc(Const ANomeFuncao : String) : Pointer;
begin
  Result := GetProcAddress(GetFaturamentoImpostosBpl, PChar(ANomeFuncao));

  If Result = Nil Then
    Raise Exception.CreateFmt('Não foi possível obter a função %s da biblioteca %s. ' +
      'Verifique se o arquivo existe e está atualizado na pasta do sistema. ' +
      'Operação cancelada!', [ANomeFuncao, FaturamentoImpostosBpl]);
end;

function DadosFiscaisClassificacaoDoItem(AParametros: IParametrosDadosFiscaisClassificacaoItem): IResultadoDadosFiscaisClassificacaoItem;
Var
  LRegraDadosFiscaisClassificacaoItem : function(AParametros: IParametrosDadosFiscaisClassificacaoItem): IResultadoDadosFiscaisClassificacaoItem; StdCall;
  LResultadoDadosFiscaisClassificacaoItem: IResultadoDadosFiscaisClassificacaoItem;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache(AParametros, LResultadoDadosFiscaisClassificacaoItem) then
  begin
    LRegraDadosFiscaisClassificacaoItem:= GetFaturamentoImpostosProc('DadosFiscaisClassificacaoDoItem');
    LResultadoDadosFiscaisClassificacaoItem := LRegraDadosFiscaisClassificacaoItem(AParametros);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(AParametros, LResultadoDadosFiscaisClassificacaoItem);
  end;
  Result := LResultadoDadosFiscaisClassificacaoItem;
end;

function DadosFiscaisAliquotaDoItem(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota;
Var
  LRegraDadosFiscaisAliquota : function(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota; StdCall;
  LResultadoDadosFiscaisAliquota: IResultadoDadosFiscaisAliquota;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache(AParametros, LResultadoDadosFiscaisAliquota) then
  begin
    LRegraDadosFiscaisAliquota:= GetFaturamentoImpostosProc('DadosFiscaisAliquotaDoItem');
    LResultadoDadosFiscaisAliquota := LRegraDadosFiscaisAliquota(AParametros);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(AParametros, LResultadoDadosFiscaisAliquota);
  end;
  Result := LResultadoDadosFiscaisAliquota;
end;

function ZerarImpostos: IRegraImpostosZerarImpostos;
Var
  LRegraZerarImpostos : function(): IRegraImpostosZerarImpostos; StdCall;
  LRegraImpostosZerarImpostos: IRegraImpostosZerarImpostos;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache('RegraImpostosZerarImpostos', LRegraImpostosZerarImpostos) then
  begin
    LRegraZerarImpostos := GetFaturamentoImpostosProc('ZerarImpostos');
    LRegraImpostosZerarImpostos := LRegraZerarImpostos;
    TControllerFaturamentoInterfacesCache.AddOrSetCache('RegraImpostosZerarImpostos', LRegraImpostosZerarImpostos);
  end;
  Result := LRegraImpostosZerarImpostos;
end;

function ClassificacoesTransferencias: IRegraImpostosClassificacoesTransferencias;
Var
  LRegraClassificacoesTransferencias : function(): IRegraImpostosClassificacoesTransferencias; StdCall;
  LRegraImpostosClassificacoesTransferencias: IRegraImpostosClassificacoesTransferencias;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache('ClassificacoesTransferencias', LRegraImpostosClassificacoesTransferencias) then
  begin
    LRegraClassificacoesTransferencias := GetFaturamentoImpostosProc('ClassificacoesTransferencias');
    LRegraImpostosClassificacoesTransferencias := LRegraClassificacoesTransferencias;
    TControllerFaturamentoInterfacesCache.AddOrSetCache('RegraImpostosClassificacoesTransferencias', LRegraImpostosClassificacoesTransferencias);
  end;
  Result := LRegraImpostosClassificacoesTransferencias;
end;

function AliquotasDeRetencao(AParametros : IParametrosAliquotasDeRetencao) : IResultadoAliquotasDeRetencao;
Var
  LRegrasAliquotasRetencao : function(AParametros : IParametrosAliquotasDeRetencao = Nil): IResultadoAliquotasDeRetencao; StdCall;
  LResultadoAliquotasDeRetencao: IResultadoAliquotasDeRetencao;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache('ResultadoAliquotasDeRetencao', LResultadoAliquotasDeRetencao) then
  begin
    LRegrasAliquotasRetencao := GetFaturamentoImpostosProc('CarregarAliquotasRetencao');
    LResultadoAliquotasDeRetencao := LRegrasAliquotasRetencao(AParametros);
    TControllerFaturamentoInterfacesCache.AddOrSetCache('ResultadoAliquotasDeRetencao', LResultadoAliquotasDeRetencao);
  end;
  Result := LResultadoAliquotasDeRetencao;
end;

initialization

finalization
  If FaturamentoImpostosBplHandle <> 0 Then
    UnloadPackage(FaturamentoImpostosBplHandle);

end.
