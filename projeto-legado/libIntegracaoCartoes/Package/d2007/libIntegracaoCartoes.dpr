library libIntegracaoCartoes;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  ShareMem,
  Windows,
  SysUtils,
  Classes,
  untRedeDebito in '..\..\Redecard\untRedeDebito.pas',
  untFuncoes in '..\..\Genericos\untFuncoes.pas',
  untDataSetIDataSetWrapper in '..\..\Dataset\untDataSetIDataSetWrapper.pas',
  untFieldDataSetFieldWrapper in '..\..\Dataset\untFieldDataSetFieldWrapper.pas',
  untParamDataSetWrapper in '..\..\Dataset\untParamDataSetWrapper.pas',
  untIIntegracaoCartoes in '..\..\Interfaces\IntegracaoCartoes\untIIntegracaoCartoes.pas',
  untRedeCard in '..\..\Redecard\untRedeCard.pas',
  untIDataSet in '..\..\Dataset\untIDataSet.pas',
  untRedeCredito in '..\..\Redecard\untRedeCredito.pas',
  untElavon in '..\..\Elavon\untElavon.pas',
  untElavonCredito in '..\..\Elavon\untElavonCredito.pas',
  untElavonPagto in '..\..\Elavon\untElavonPagto.pas',
  untEquals in '..\..\Equals\untEquals.pas',
  untEqualsPagto in '..\..\Equals\untEqualsPagto.pas',
  untAmex in '..\..\Amex\untAmex.pas',
  untAmexPgto in '..\..\Amex\untAmexPgto.pas',
  untChartCielo in '..\..\ChartCielo\untChartCielo.pas',
  untChartCieloPgto in '..\..\ChartCielo\untChartCieloPgto.pas',
  untConcil in '..\..\Concil\untConcil.pas',
  untConcilPgto in '..\..\Concil\untConcilPgto.pas',
  untSipag in '..\..\Sipag\untSipag.pas',
  untSipagPgto in '..\..\Sipag\untSipagPgto.pas',
  untSafrapay in '..\..\Safrapay\untSafrapay.pas',
  untSafrapayPgto in '..\..\Safrapay\untSafrapayPgto.pas',
  untTImportacaoCartao in '..\..\Genericos\untTImportacaoCartao.pas',
  untRedeSite in '..\..\RedeSite\untRedeSite.pas',
  untRedeSitePgto in '..\..\RedeSite\untRedeSitePgto.pas',
  untPagSeguro in '..\..\PagSeguro\untPagSeguro.pas',
  untPagSeguroPgto in '..\..\PagSeguro\untPagSeguroPgto.pas',
  untBoaVista in '..\..\BoaVista\untBoaVista.pas',
  untBoaVistaPgto in '..\..\BoaVista\untBoaVistaPgto.pas',
  untBanesCardPgto in '..\..\BanesCard\untBanesCardPgto.pas',
  untBanesCard in '..\..\BanesCard\untBanesCard.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R *.res}
{$R .\icones.res}

Exports
  pIniciaIntegacaoCartoes,
  pVerificaTabelas,
  pImportaRede,
  pImportaElavon,
  dxInitializeRedeCard,
  dxInitializeElavon,
  dxInitializeEquals;
begin
end.
