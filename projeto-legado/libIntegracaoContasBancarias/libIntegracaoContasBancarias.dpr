library libIntegracaoContasBancarias;

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
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Windows,
  SysUtils,
  Classes,
  RlConsts,
  System.UiTypes,
  Vcl.Dialogs,
  dxCore,
  untILibContaBancariaWrapper in 'fontes\interfaces\untILibContaBancariaWrapper.pas',
  untLibContaBancariaInterfacesTipos in 'fontes\interfaces\untLibContaBancariaInterfacesTipos.pas',
  untTLibContasBancariasFuncoes in 'fontes\genericos\untTLibContasBancariasFuncoes.pas',
  untILibContaBancariaFactory in 'fontes\factorys\untILibContaBancariaFactory.pas',
  untLibContaBancariaGravando in 'fontes\views\untLibContaBancariaGravando.pas' {frmGravando},
  untLibContaBancariaGravandoOld in 'fontes\views\untLibContaBancariaGravandoOld.pas' {frmGravandoOld},
  untLibContaBancariaTelasAbertas in 'fontes\classes\untLibContaBancariaTelasAbertas.pas',
  untLibContaBancariaConstantes in 'fontes\genericos\untLibContaBancariaConstantes.pas',
  untGenericProcedureFormGravando in 'fontes\views\untGenericProcedureFormGravando.pas',
  untLibContaBancariaHorarioSistema in 'fontes\genericos\untLibContaBancariaHorarioSistema.pas',
  untLibContaBancariaAutcomExports in 'fontes\genericos\untLibContaBancariaAutcomExports.pas',
  untLibContaBancariaPai in 'fontes\views\untLibContaBancariaPai.pas' {frmPai},
  ContasBancarias.View.ImportacaoExtrato in 'fontes\views\ContasBancarias.View.ImportacaoExtrato.pas' {frmImportacaoExtrato},
  ContasBancarias.View.Frame.ContaBancaria in 'Fontes\views\ContasBancarias.View.Frame.ContaBancaria.pas' {frameContaBancaria: TFrame},
  ContasBancarias.Model.ContaBancaria in 'fontes\model\ContasBancarias.Model.ContaBancaria.pas',
  ContasBancarias.Controller.ContaBancaria in 'Fontes\controller\ContasBancarias.Controller.ContaBancaria.pas',
  untMenuContaBancaria in 'fontes\genericos\untMenuContaBancaria.pas',
  untMensagem in 'fontes\views\untMensagem.pas' {frmMensagem},
  ContasBancarias.Model.CredenciaisAutenticacao in 'fontes\model\ContasBancarias.Model.CredenciaisAutenticacao.pas',
  BancoDoBrasil.Controller.ImportacaoExtrato in 'Banco do Brasil\src\controller\BancoDoBrasil.Controller.ImportacaoExtrato.pas',
  BancoDoBrasil.Model.ImportacaoExtrato in 'Banco do Brasil\src\model\BancoDoBrasil.Model.ImportacaoExtrato.pas',
  BancoDoBrasil.Model.LancamentoExtrato in 'Banco do Brasil\src\model\BancoDoBrasil.Model.LancamentoExtrato.pas',
  blcksock in 'synalist\blcksock.pas',
  httpsend in 'synalist\httpsend.pas',
  ssl_openssl in 'synalist\ssl_openssl.pas',
  ssl_openssl_lib in 'synalist\ssl_openssl_lib.pas',
  synacode in 'synalist\synacode.pas',
  synafpc in 'synalist\synafpc.pas',
  synaip in 'synalist\synaip.pas',
  synautil in 'synalist\synautil.pas',
  synsock in 'synalist\synsock.pas',
  ContasBancarias.View.InformaPeriodo in 'fontes\views\ContasBancarias.View.InformaPeriodo.pas' {frmInformaPeriodo},
  untExtratoBaseClass in 'fontes\classes\untExtratoBaseClass.pas',
  Faturamento.Classes.CNPJ in '..\padra_atualizado\fontes\FuncoesCentralizadas\Faturamento.Classes.CNPJ.pas',
  Itau.Model.ImportacaoExtrato in 'Banco Itau\src\model\Itau.Model.ImportacaoExtrato.pas',
  Itau.Model.LancamentoExtrato in 'Banco Itau\src\model\Itau.Model.LancamentoExtrato.pas',
  Itau.Controller.ImportacaoExtrato in 'Banco Itau\src\controller\Itau.Controller.ImportacaoExtrato.pas';

{$SetPEFlags IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP}
{$SetPEFlags IMAGE_FILE_NET_RUN_FROM_SWAP}
{$R VCLStyles.res}
{$R *.res}

Exports
  dxInitialize,
  dxFinalize,
  InicializaObjetoLibContasBancarias,
  pAtualizaObjetoTelasAbertas,
  SetStyleAutcom,
  ImportarContasBancarias,
  ConsultaSaldoContasBancarias;


begin
end.

