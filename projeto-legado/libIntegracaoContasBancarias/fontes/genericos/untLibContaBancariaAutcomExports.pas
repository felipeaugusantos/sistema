unit untLibContaBancariaAutcomExports;

interface

Uses System.Classes, System.SysUtils, Vcl.Menus, Vcl.Forms,
     System.Generics.Collections,

     dxCore, cxEdit, cxRadioGroup, cxEditRepositoryItems, cxCurrencyEdit,
     Uni, UniClientDataset,

     untILibContaBancariaFactory, untILibContaBancariaWrapper,
     untTLibContasBancariasFuncoes, untLibContaBancariaTelasAbertas,
     untMenuContaBancaria,untLibContaBancariaConstantes,untExtratoBaseClass;

  procedure dxInitialize; StdCall;
  procedure dxFinalize; StdCall;

  procedure InicializaObjetoLibContasBancarias(AObjetoLibContaBancaria: ILibContaBancaria); StdCall;
  procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: TInterfacedObject); StdCall;
  procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
  function ImportarContasBancarias: String; stdcall;
  procedure ConsultaSaldoContasBancarias; StdCall;

implementation

function ImportarContasBancarias: String; stdcall;
Begin
  Result := untMenuContaBancaria.MenuImportarContasBancarias;
End;

procedure ConsultaSaldoContasBancarias; StdCall;
Begin
  untMenuContaBancaria.MenuConsultaSaldoContasBancarias;
End;

procedure InicializaObjetoLibContasBancarias(AObjetoLibContaBancaria: ILibContaBancaria); StdCall;
Begin
  TLibContaBancariaFactory.Registrar(AObjetoLibContaBancaria);
  untTLibContasBancariasFuncoes.VS_FuncoesExternas := TLibContaBancariaFactory.Get;
  VS_strCodEmp := VS_FuncoesExternas.fIRetEmpresaLogada;
End;

procedure pAtualizaObjetoTelasAbertas(ATelaAbertas: TInterfacedObject); StdCall;
Begin
  untLibContaBancariaTelasAbertas.objTelasAbertas := ATelaAbertas As TTelasAbertas;
End;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  VS_AutcomModoClassico := AModoClassico;
  TLibContaBancariaFuncoes.CarregaEstiloAutcom;
End;


procedure dxInitialize; StdCall;
Begin
  dxCore.dxInitialize;
End;

procedure dxFinalize; StdCall;
Begin
  Try
    dxCore.dxFinalize;
  Except

  End;
End;

end.
