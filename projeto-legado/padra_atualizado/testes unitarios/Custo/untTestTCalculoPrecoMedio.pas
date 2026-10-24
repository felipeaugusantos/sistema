unit untTestTCalculoPrecoMedio;

interface

uses TestFramework, SysUtils, untCalculoPrecoMedio, untConfiguracoesStub;

type
  TestTParCalculoPrecoMedio = class(TTestCase)
  strict private
    objPreMed: TCalculoPrecoMedio;
    objCfg: TConfiguracaoStub;

    blnCst: Boolean;
    blnPrecoMedio: Boolean;
    blnSaldo: Boolean;
    blnNovaQuantidade: Boolean;
    blnNovoUnitario: Boolean;
    blnAliquotaIcms: Boolean;
    blnValorIpi: Boolean;
    blnValorRetido: Boolean;
    blnIcmsAntecipado: Boolean;
    blnContribuinteIPI: Boolean;
    blnIncidePIS: Boolean;
    blnFrete: Boolean;

    const NOVO_PRECO_MEDIO_CANONICO = 99.0909;
    const ACRESCIMO_PADRAO = 10;
    const NOVO_PRECO_MEDIO_CANONICO_ACRESCIMO_PADRAO = 99.1818;

    procedure pCriaObjPreMedModelo;
  public
    procedure SetUp; override;
    procedure TearDown; override;
    constructor Create(MethodName: String); override;
  published
    //Metodos de teste vem aqui
    procedure TestValidaObjetoInvalidoPrecoMedio;
    procedure TestValidaObjetoInvalidoNovaQuantidade;
    procedure TestValidaObjetoInvalidoNovoUnitario;
    procedure TestValidaObjetoInvalidoAliquotaIcms;
    procedure TestValidaObjetoInvalidoValorIPI;
    procedure TestValidaObjetoInvalidoValorRetido;
    procedure TestValidaObjetoInvalidoIcmsAntecipado;
    procedure TestValidaObjetoInvalidoFrete;

    procedure TestPrecoMedioSemImpostos;
    procedure TestPrecoMedioComIcmsNormal;
    procedure TestPrecoMedioComIcmsNormalMasConfiguradoParaNaoDeduzir;
    procedure TestPrecoMedioComIPIEContribuinte;
    procedure TestPrecoMedioComIPIENaoContribuinte;
    procedure TestPrecoMedioComRetido;
    procedure TestPrecoMedioComRetidoMasCstNaoSubstituicao;
    procedure TestPrecoMedioComPisCofinsItemIncidePISCOFINS;
    procedure TestPrecoMedioComFrete;
    procedure TestPrecoMedioComFreteMasConfiguradoParaNaoSomar;
    procedure TestPrecoMedioComICMSAntecipado;
  end;
implementation

uses untFuncoesLibFuncoes;

{ TestTParCalculoPrecoMedio }

constructor TestTParCalculoPrecoMedio.Create(MethodName: String);
begin
  inherited Create(MethodName);
end;

procedure TestTParCalculoPrecoMedio.pCriaObjPreMedModelo;
begin
  if blnCst Then              objPreMed.CstIcms('000');
  if blnPrecoMedio Then       objPreMed.PrecoMedio(100.00);
  if blnSaldo Then            objPreMed.Saldo(100.00);
  if blnNovaQuantidade Then   objPreMed.NovaQuantidade(10.00);
  if blnNovoUnitario Then     objPreMed.NovoUnitario(90.00);
  if blnAliquotaIcms Then     objPreMed.AliquotaIcms(0);
  if blnValorIpi Then         objPreMed.ValorIpi(0);
  if blnValorRetido Then      objPreMed.ValorRetido(0);
  if blnIcmsAntecipado Then   objPreMed.IcmsAntecipado(0);
  if blnContribuinteIPI Then  objPreMed.ContribuinteIPI(False);
  if blnIncidePIS Then        objPreMed.IncidePIS(False);
  if blnFrete Then            objPreMed.Frete(0);
end;

procedure TestTParCalculoPrecoMedio.SetUp;
begin
  inherited;
  objCfg := TConfiguracaoStub.Create;
  objPreMed := TCalculoPrecoMedio.fCriaPreMed(objCfg);
  blnCst := True;
  blnPrecoMedio := True;
  blnSaldo := True;
  blnNovaQuantidade := True;
  blnNovoUnitario := True;
  blnAliquotaIcms := True;
  blnValorIpi := True;
  blnValorRetido := True;
  blnIcmsAntecipado := True;
  blnContribuinteIPI := True;
  blnIncidePIS := True;
  blnFrete := True;
end;

procedure TestTParCalculoPrecoMedio.TearDown;
begin
  inherited;
  If Assigned(objPreMed) Then
  Begin
    objPreMed.Free;
    objPreMed := Nil;
  End;
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComIcmsNormal;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.AliquotaIcms(18.00);
  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(97.6182, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComIcmsNormalMasConfiguradoParaNaoDeduzir;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.AliquotaIcms(18.00);
  objCfg.fAddConfig('ICMPRM', False);

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComIPIEContribuinte;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.ValorIpi(ACRESCIMO_PADRAO).ContribuinteIPI(True);

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComIPIENaoContribuinte;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.ValorIpi(ACRESCIMO_PADRAO).ContribuinteIPI(False);

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO_ACRESCIMO_PADRAO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComRetido;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.ValorRetido(ACRESCIMO_PADRAO).CstIcms('060');

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO_ACRESCIMO_PADRAO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComRetidoMasCstNaoSubstituicao;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.ValorRetido(ACRESCIMO_PADRAO);

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComPisCofinsItemIncidePISCOFINS;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.IncidePIS(True);

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(98.3341, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComFrete;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.Frete(ACRESCIMO_PADRAO);

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO_ACRESCIMO_PADRAO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComFreteMasConfiguradoParaNaoSomar;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objCfg.fAddConfig('FREMED', False);
  objPreMed.Frete(ACRESCIMO_PADRAO);

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioComICMSAntecipado;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  objPreMed.IcmsAntecipado(ACRESCIMO_PADRAO).CstIcms('090');

  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO_ACRESCIMO_PADRAO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestPrecoMedioSemImpostos;
  Var
    ReturnValue: Double;
begin
  pCriaObjPreMedModelo;
  ReturnValue := objPreMed.fPrecoMedio;

  CheckEquals(fFormataFloat(NOVO_PRECO_MEDIO_CANONICO, 4), ReturnValue, 'Valor de preço médio incorreto');
end;

procedure TestTParCalculoPrecoMedio.TestValidaObjetoInvalidoPrecoMedio;
begin
  blnPrecoMedio := False;
  pCriaObjPreMedModelo;

  StartExpectingException(Exception);
  objPreMed.fPrecoMedio;
  StopExpectingException('Deveria acusar mensagem de Preço Médio inválido.');
end;

procedure TestTParCalculoPrecoMedio.TestValidaObjetoInvalidoNovaQuantidade;
begin
  blnNovaQuantidade := False;
  pCriaObjPreMedModelo;

  StartExpectingException(Exception);
  objPreMed.fPrecoMedio;
  StopExpectingException('Deveria acusar mensagem de Nova Quantidade inválida.');
end;

procedure TestTParCalculoPrecoMedio.TestValidaObjetoInvalidoNovoUnitario;
begin
  blnNovoUnitario := False;
  pCriaObjPreMedModelo;

  StartExpectingException(Exception);
  objPreMed.fPrecoMedio;
  StopExpectingException('Deveria acusar mensagem de Novo Unitario inválido.');
end;

procedure TestTParCalculoPrecoMedio.TestValidaObjetoInvalidoAliquotaIcms;
begin
  blnAliquotaIcms := False;
  pCriaObjPreMedModelo;

  StartExpectingException(Exception);
  objPreMed.fPrecoMedio;
  StopExpectingException('Deveria acusar mensagem de Alíquota de ICMS inválida.');
end;

procedure TestTParCalculoPrecoMedio.TestValidaObjetoInvalidoValorIPI;
begin
  blnValorIpi := False;
  pCriaObjPreMedModelo;

  StartExpectingException(Exception);
  objPreMed.fPrecoMedio;
  StopExpectingException('Deveria acusar mensagem de Valor de IPI inválido.');
end;

procedure TestTParCalculoPrecoMedio.TestValidaObjetoInvalidoValorRetido;
begin
  blnValorRetido := False;
  pCriaObjPreMedModelo;

  StartExpectingException(Exception);
  objPreMed.fPrecoMedio;
  StopExpectingException('Deveria acusar mensagem de Valor do Retido inválido.');
end;

procedure TestTParCalculoPrecoMedio.TestValidaObjetoInvalidoIcmsAntecipado;
begin
  blnIcmsAntecipado := False;
  pCriaObjPreMedModelo;

  StartExpectingException(Exception);
  objPreMed.fPrecoMedio;
  StopExpectingException('Deveria acusar mensagem de ICMS Antecipado inválido.');
end;

procedure TestTParCalculoPrecoMedio.TestValidaObjetoInvalidoFrete;
begin
  blnFrete := False;
  pCriaObjPreMedModelo;

  StartExpectingException(Exception);
  objPreMed.fPrecoMedio;
  StopExpectingException('Deveria acusar mensagem de Frete inválido.');
end;

initialization
  RegisterTest(TestTParCalculoPrecoMedio.Suite);

end.

