unit Services.Exportacao.Tintometrico;

interface

uses
  System.DateUtils, System.Classes, System.SysUtils,
  System.Generics.Collections, System.StrUtils, System.Math,
  Data.DB, Uni, Faturamento.Classes.TFatVendaBase,
  untFuncFatTypes, System.Variants, untTypesSistema, untGTinForTipos,
  Shared.Core, untFuncoesGenerica, untMovGer, Services.ConsultarPreco.Tinta,
{$I '..\..\..\core\services.core.uses.inc'};

procedure ExportacaoTintometricosTerceiros();

implementation

uses
  untFuncTinta, untTMatrizSaldosColorantes, untFuncoesSaldos,
  untImportaTintometricosTerceirosTabelas, untTipoTinta,
  untParCalculaPrecoCusto, untTConfiguracao, untCadPro,
  untFatVendasCalculadorWrapper, Promocao.Regra.Preco.Sugestao,
  untFatVendasCalculadorWrapperTAB, untTransferencias, untITransferencias,
  untIFatOrdProTintaMaquina, untFatOrdProTintaMaquina, untLiberacao,
  untExecutaSQLReplicacaoTinta, untFatDefineLotesPedidoWMSWrapper,
  untFuncoesCRM, untExportaTintometricosTerceiros;

procedure pFreeLibTintaMaquina;
begin
  if HandleDllTinta <> 0 then
    FreeLibrary(HandleDllTinta);
end;

procedure pLoadLibTintaMaquina;
begin
  pCarregaFuncoesDll(fGravaMovGer, fGravaMovDet, TTransferencias.Create,
    TFatOrdProTintaMaquina.Create, TLiberacao.Create,
    nil { VS_objTraceViewer } , TExecutaSQLReplicacaoTinta.Create,
    TFatDefineLotesPedidoWMSWrapper.Create, TFuncoesCRM.Create,
    TFuncoesSaldos.Create, nil { pImprimeFatImpTin } );
end;

procedure pVerificaConfigTinta;
begin
  If Not fCfgSis('USATMQ', varBoolean) Then
    raise Exception.Create('Empresa nao utiliza Tinta de Maquina (' +
      VS_strCodEmp + ')');
end;

procedure ExportacaoTintometricosTerceiros();
var
  objExpTinTer: TExportarAutomaticoTintometricosTerceiros;
begin
  objConnectionsManager := nil;
  try
    pIniciarConexao;
    pDefinirEmpresa;
    pDefinirUsuario;
    pIniciarVariaveis;
    pVerificaConfigTinta;
    pLoadLibTintaMaquina;
    try
      objExpTinTer := TExportarAutomaticoTintometricosTerceiros.Create;
      try
        objExpTinTer.pExportarAutomaticoTintometricosTerceiros(ParamStr(1), True);
        while objExpTinTer.fExportacaoAtiva do
          Sleep(10000);
      finally
        FreeAndNil(objExpTinTer);
      end;
    except
      on E: Exception Do
        WriteError(E.ClassName + ': ' + E.Message);
    end;
  finally
    if Assigned(objConnectionsManager) then
      objConnectionsManager.EndConnection;
  end;
end;

end.
