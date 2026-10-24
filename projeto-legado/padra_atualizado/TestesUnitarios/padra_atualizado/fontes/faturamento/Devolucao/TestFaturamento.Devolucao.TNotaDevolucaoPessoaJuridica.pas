unit TestFaturamento.Devolucao.TNotaDevolucaoPessoaJuridica;
interface

uses
  TestFramework, Classes, SysUtils,
  Faturamento.Devolucao.TNotaDevolucaoPessoaJuridica;

type
  // Test methods for class TNotaDevolucaoPessoaJuridica

  TestTNotaDevolucaoPessoaJuridica = class(TTestCase)
  strict private
    FNotaDevolucaoPessoaJuridica: TNotaDevolucaoPessoaJuridica;
  private
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestfVerificaSePermiteDevolucaoEmpresaSemIES_ItensNaoPermiteDevolucao_E_EmpresaComIES;
    procedure TestfVerificaSePermiteDevolucaoEmpresaSemIES_ItensPermiteDevolucao_E_EmpresaComIES;
    procedure TestfVerificaSePermiteDevolucaoEmpresaSemIES_ItensPermiteDevolucao_E_EmpresaSemIES;
    procedure TestfVerificaSePermiteDevolucaoEmpresaSemIES_ComAcesso;

    procedure TestfVerificaSePermiteDevolucaoEmpresaComIES_ItensNaoPermiteDevolucao_E_EmpresaComIES;
    procedure TestfVerificaSePermiteDevolucaoEmpresaComIES_ItensPermiteDevolucao_E_EmpresaComIES;
    procedure TestfVerificaSePermiteDevolucaoEmpresaComIES_ItensPermiteDevolucao_E_EmpresaSemIES;


    procedure TestfFiltroItensEspecieNaoValidaIES;
  end;

implementation

procedure TestTNotaDevolucaoPessoaJuridica.SetUp;
begin
  FNotaDevolucaoPessoaJuridica := TNotaDevolucaoPessoaJuridica.Create;
end;

procedure TestTNotaDevolucaoPessoaJuridica.TearDown;
begin
  FNotaDevolucaoPessoaJuridica.Free;
  FNotaDevolucaoPessoaJuridica := nil;
end;

procedure TestTNotaDevolucaoPessoaJuridica.TestfVerificaSePermiteDevolucaoEmpresaSemIES_ItensNaoPermiteDevolucao_E_EmpresaComIES;
var
  ReturnValue: Boolean;
  strCodigoCliente: string;
begin
  strCodigoCliente := '001';


  FNotaDevolucaoPessoaJuridica.pVerificaAcesso := function ( strChave, strOperador : String ) : boolean
  begin
    Result := False;
  end;

  FNotaDevolucaoPessoaJuridica.pEspecieItensPermiteDevolucao := function ( ) : boolean
  begin
    Result := False;
  end;

  FNotaDevolucaoPessoaJuridica.pPessoaJuridicaSemIES := function ( PCodigoCliente : String ) : boolean
  begin
    Result := strCodigoCliente = pCodigoCliente;
  end;

  ReturnValue := FNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaSemIES(strCodigoCliente);
  CheckFalse(ReturnValue);
end;

procedure TestTNotaDevolucaoPessoaJuridica.TestfVerificaSePermiteDevolucaoEmpresaSemIES_ItensPermiteDevolucao_E_EmpresaComIES;
var
  ReturnValue: Boolean;
  strCodigoCliente: string;
begin
  strCodigoCliente := '001';


  FNotaDevolucaoPessoaJuridica.pVerificaAcesso := function ( strChave, strOperador : String ) : boolean
  begin
    Result := False;
  end;

  FNotaDevolucaoPessoaJuridica.pEspecieItensPermiteDevolucao := function ( ) : boolean
  begin
    Result := True;
  end;

  FNotaDevolucaoPessoaJuridica.pPessoaJuridicaSemIES := function ( PCodigoCliente : String ) : boolean
  begin
    Result := strCodigoCliente = pCodigoCliente;
  end;

  ReturnValue := FNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaSemIES(strCodigoCliente);
  CheckTrue(ReturnValue);
end;

procedure TestTNotaDevolucaoPessoaJuridica.TestfVerificaSePermiteDevolucaoEmpresaSemIES_ItensPermiteDevolucao_E_EmpresaSemIES;
var
  ReturnValue: Boolean;
  strCodigoCliente: string;
begin
  strCodigoCliente := '001';


  FNotaDevolucaoPessoaJuridica.pVerificaAcesso := function ( strChave, strOperador : String ) : boolean
  begin
    Result := False;
  end;

  FNotaDevolucaoPessoaJuridica.pEspecieItensPermiteDevolucao := function ( ) : boolean
  begin
    Result := True;
  end;

  FNotaDevolucaoPessoaJuridica.pPessoaJuridicaSemIES := function ( PCodigoCliente : String ) : boolean
  begin
    Result := strCodigoCliente <> pCodigoCliente;
  end;

  ReturnValue := FNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaSemIES(strCodigoCliente);
  CheckFalse(ReturnValue);
end;

procedure TestTNotaDevolucaoPessoaJuridica.TestfVerificaSePermiteDevolucaoEmpresaSemIES_ComAcesso;
var
  ReturnValue: Boolean;
  strCodigoCliente: string;
begin
  strCodigoCliente := '001';


  FNotaDevolucaoPessoaJuridica.pVerificaAcesso := function ( strChave, strOperador : String ) : boolean
  begin
    Result := True;
  end;

  ReturnValue := FNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaSemIES(strCodigoCliente);
  CheckFalse(ReturnValue);
end;

procedure TestTNotaDevolucaoPessoaJuridica.TestfVerificaSePermiteDevolucaoEmpresaComIES_ItensNaoPermiteDevolucao_E_EmpresaComIES;
var
  ReturnValue: Boolean;
  strCodigoCliente: string;
begin
  strCodigoCliente := '001';


  FNotaDevolucaoPessoaJuridica.pVerificaAcesso := function ( strChave, strOperador : String ) : boolean
  begin
    Result := False;
  end;

  FNotaDevolucaoPessoaJuridica.pEspecieItensPermiteDevolucao := function ( ) : boolean
  begin
    Result := False;
  end;

  FNotaDevolucaoPessoaJuridica.pPessoaJuridicaComIES := function ( PCodigoCliente : String ) : boolean
  begin
    Result := strCodigoCliente = pCodigoCliente;
  end;

  ReturnValue := FNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaComIES(strCodigoCliente);
  CheckFalse(ReturnValue);
end;

procedure TestTNotaDevolucaoPessoaJuridica.TestfVerificaSePermiteDevolucaoEmpresaComIES_ItensPermiteDevolucao_E_EmpresaComIES;
var
  ReturnValue: Boolean;
  strCodigoCliente: string;
begin
  strCodigoCliente := '001';

  FNotaDevolucaoPessoaJuridica.pEspecieItensPermiteDevolucao := function ( ) : boolean
  begin
    Result := True;
  end;

  FNotaDevolucaoPessoaJuridica.pPessoaJuridicaComIES := function ( PCodigoCliente : String ) : boolean
  begin
    Result := strCodigoCliente = pCodigoCliente;
  end;

  ReturnValue := FNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaComIES(strCodigoCliente);
  CheckTrue(ReturnValue);
end;

procedure TestTNotaDevolucaoPessoaJuridica.TestfVerificaSePermiteDevolucaoEmpresaComIES_ItensPermiteDevolucao_E_EmpresaSemIES;
var
  ReturnValue: Boolean;
  strCodigoCliente: string;
begin
  strCodigoCliente := '001';


  FNotaDevolucaoPessoaJuridica.pEspecieItensPermiteDevolucao := function ( ) : boolean
  begin
    Result := True;
  end;

  FNotaDevolucaoPessoaJuridica.pPessoaJuridicaComIES := function ( PCodigoCliente : String ) : boolean
  begin
    Result := strCodigoCliente <> pCodigoCliente;
  end;

  ReturnValue := FNotaDevolucaoPessoaJuridica.fVerificaSePermiteDevolucaoEmpresaComIES(strCodigoCliente);
  CheckFalse(ReturnValue);
end;

procedure TestTNotaDevolucaoPessoaJuridica.TestfFiltroItensEspecieNaoValidaIES;
var
  ReturnValue: string;
begin
  ReturnValue := TNotaDevolucaoPessoaJuridica.fFiltroItensEspecieNaoValidaIES;
  CheckEquals('ITE_ESPDEV IN (' + QuotedStr( 'MI' ) + ', ' + QuotedStr( 'FF' ) + ')', ReturnValue);
  // TODO: Validate method results
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTNotaDevolucaoPessoaJuridica.Suite);
end.

