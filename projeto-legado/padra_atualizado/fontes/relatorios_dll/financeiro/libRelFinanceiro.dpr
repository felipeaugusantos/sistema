library libRelFinanceiro;

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
  SysUtils,
  Classes,
  untQckCtpAnalDebitos in '..\..\Relatorios\Financeiro\ContasaPagar\untQckCtpAnalDebitos.pas' {frmQckCtpAnalDebitos},
  untRelCtpAnaDebitos in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpAnaDebitos.pas' {frmRelCtpAnaDebitos},
  untPaiQck in '..\..\Genericos\untPaiQck.pas' {frmPaiQck},
  untFuncoesSimples in '..\..\genericos\untFuncoesSimples.pas',
  untConsulta in '..\..\genericos\untConsulta.pas' {frmConsulta},
  untModulo in '..\..\Genericos\untModulo.pas' {frmModulo: TDataModule},
  untConstantes in '..\..\genericos\untConstantes.pas',
  untMensagem in '..\..\genericos\untMensagem.pas' {frmMensagem},
  untMenuFilas in '..\..\genericos\untMenuFilas.pas' {frmMenuFilas},
  untPai in '..\..\Genericos\untPai.pas' {frmPai},
  untMenuTipImp in '..\..\genericos\untMenuTipImp.pas' {frmMenuTipImp},
  untModuloCfgRel in '..\..\cadastros\untModuloCfgRel.pas' {frmModuloCfgRel: TDataModule},
  untModuloCadAbf in '..\..\cadastros\untModuloCadAbf.pas' {frmModuloCadAbf: TDataModule},
  untModuloCadAti in '..\..\cadastros\untModuloCadAti.pas' {frmModuloCadAti: TDataModule},
  untModuloCadCid in '..\..\cadastros\untModuloCadCid.pas' {frmModuloCadCid: TDataModule},
  untModuloCadCta in '..\..\cadastros\untModuloCadCta.pas' {frmModuloCadCta: TDataModule},
  untModuloCadEmp in '..\..\cadastros\untModuloCadEmp.pas' {frmModuloCadEmp: TDataModule},
  untModuloCadFor in '..\..\cadastros\untModuloCadFor.pas' {frmModuloCadFor: TDataModule},
  untModuloCadGru in '..\..\cadastros\untModuloCadGru.pas' {frmModuloCadGru: TDataModule},
  untModuloCadIte in '..\..\cadastros\untModuloCadIte.pas' {frmModuloCadIte: TDataModule},
  untModuloCadMar in '..\..\cadastros\untModuloCadMar.pas' {frmModuloCadMar: TDataModule},
  untModuloCadOpe in '..\..\Cadastros\untModuloCadOpe.pas' {frmModuloCadOpe: TDataModule},
  untModuloCadPor in '..\..\cadastros\untModuloCadPor.pas' {frmModuloCadPor: TDataModule},
  untModuloCadSfz in '..\..\cadastros\untModuloCadSfz.pas' {frmModuloCadSfz: TDataModule},
  untModuloSPR in '..\..\Genericos\untModuloSPR.pas' {frmModuloSPR: TDataModule},
  untModuloCfgAtb in '..\..\genericos\untModuloCfgAtb.pas' {frmModuloCfgAtb: TDataModule},
  untConsultaComp in '..\..\genericos\untConsultaComp.pas' {frmConsultaComp},
  untCadConfRelatorios in '..\..\cadastros\untCadConfRelatorios.pas' {frmCadConfRelatorios},
  untPaiCad in '..\..\Genericos\untPaiCad.pas' {frmPaiCad},
  untModuloCons in '..\..\genericos\untModuloCons.pas' {frmModuloCons: TDataModule},
  untCfgAtb in '..\..\genericos\untCfgAtb.pas' {frmCfgAtb},
  untPaiRelatorio in '..\..\Genericos\untPaiRelatorio.pas' {frmPaiRelatorio},
  untModuloCadEve in '..\..\cadastros\untModuloCadEve.pas' {frmModuloCadEve: TDataModule},
  untRelFinanceiro in 'untRelFinanceiro.pas',
  untFuncoesRel in '..\geral\untFuncoesRel.pas',
  untRelCtpTitAbertoMes in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpTitAbertoMes.pas' {frmRelCtpTitAbertoMes},
  untRelCtpContaCorrente in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpContaCorrente.pas' {frmRelCtpContaCorrente},
  untRelCtpIncDiarias in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpIncDiarias.pas' {frmRelCtpIncDiarias},
  untQckCtpTitContasSint in '..\..\Relatorios\Financeiro\ContasaPagar\untQckCtpTitContasSint.pas' {frmQckCtpTitContasSint},
  untRelCtpTitContas in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpTitContas.pas' {frmRelCtpTitContas},
  untQckCtpTitContas in '..\..\relatorios\financeiro\contasapagar\untQckCtpTitContas.pas' {frmQckCtpTitContas},
  untFuncoesConsulta in '..\..\genericos\untFuncoesConsulta.pas',
  untRelCtpPosContabil in '..\..\Relatorios\Financeiro\ContasaPagar\untRelCtpPosContabil.pas' {frmRelCtpPosContabil},
  untPesqAux in '..\..\genericos\untPesqAux.pas',
  untQckCtrQuitTodos in '..\..\relatorios\financeiro\contasareceber\untQckCtrQuitTodos.pas' {frmQckCtrQuitTodos},
  untQckCtrTitReceb in '..\..\relatorios\financeiro\contasareceber\untQckCtrTitReceb.pas' {frmQckCtrTitReceb},
  untQckCtrAberto in '..\..\relatorios\financeiro\contasareceber\untQckCtrAberto.pas' {frmQckCtrAberto},
  untQckCtrIncDiarias in '..\..\Relatorios\Financeiro\ContasaReceber\untQckCtrIncDiarias.pas' {frmQckCtrIncDiarias},
  untModuloCadCnd in '..\..\cadastros\untModuloCadCnd.pas' {frmModuloCadCnd: TDataModule},
  untRelPosContabil in '..\..\Relatorios\Financeiro\ContasaReceber\untRelPosContabil.pas' {frmRelPosContabil},
  untRelTitDeletados in '..\..\relatorios\financeiro\contasareceber\untRelTitDeletados.pas' {frmRelTitDeletados},
  untPaiSimples in '..\..\Genericos\untPaiSimples.pas' {frmPaiSimples},
  untRelCtrCartoes in '..\..\Relatorios\Financeiro\ContasaReceber\untRelCtrCartoes.pas' {frmRelCtrCartoes},
  untModuloCadCar in '..\..\cadastros\untModuloCadCar.pas' {frmModuloCadCar: TDataModule},
  untRelCtrCartaCob in '..\..\Relatorios\Financeiro\ContasaReceber\untRelCtrCartaCob.pas' {frmRelCartaCob},
  untQckCtrCartaCob in '..\..\Relatorios\Financeiro\ContasaReceber\untQckCtrCartaCob.pas' {frmQckCtrCartaCob},
  untCartaAnuencia in '..\..\Relatorios\Financeiro\ContasaReceber\untCartaAnuencia.pas' {frmCartaAnuencia},
  untDtaEmissao in '..\..\relatorios\financeiro\contasareceber\untDtaEmissao.pas' {frmDtaEmi},
  untRelDupAgr in '..\..\Relatorios\Financeiro\ContasaReceber\untRelDupAgr.pas' {frmRelDupAgr},
  untRelCtrReimpressaoDocs in '..\..\Relatorios\Financeiro\ContasaReceber\untRelCtrReimpressaoDocs.pas' {frmRelCtrReimpressaoDocs},
  untRelCtrReimpressaoDocsList in '..\..\relatorios\financeiro\contasareceber\untRelCtrReimpressaoDocsList.pas' {frmRelCtrReimpressaoDocsList},
  untRelCtrReimpressaoBusca in '..\..\relatorios\financeiro\contasareceber\untRelCtrReimpressaoBusca.pas' {frmRelCtrReimpressaoBusca},
  untQckDocBaixados in '..\..\financeiro\contasareceber\untQckDocBaixados.pas' {frmQckDocBaixados},
  untRelCtrComVendedor in '..\..\Relatorios\Financeiro\ContasaReceber\untRelCtrComVendedor.pas' {frmRelCtrComVendedor},
  untModuloCadUni in '..\..\cadastros\untModuloCadUni.pas' {frmModuloCadUni: TDataModule},
  untModuloCadTra in '..\..\cadastros\untModuloCadTra.pas' {frmModuloCadTra: TDataModule},
  untSenhaEmpresa in '..\..\genericos\untSenhaEmpresa.pas' {frmSenhaEmpresa},
  untConsultas in '..\..\genericos\untConsultas.pas';

exports
  prelfinanceiro;

begin

End.

