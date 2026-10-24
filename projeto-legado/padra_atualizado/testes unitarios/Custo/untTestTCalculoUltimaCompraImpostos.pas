unit untTestTCalculoUltimaCompraImpostos;

interface

uses
  TestFramework, Windows, Forms, Dialogs, Controls, StrUtils, Classes, SysUtils, Variants,
  Graphics, Messages, untCalculoUltimaCompraImpostos;

type
  TestTCalculoUltimaCompraImpostos = class(TTestCase)
  strict private
    objImpUlt: TCalculoUltimaCompraImpostos;
    blnTotalItem: Boolean;
    blnDescontoEspecial: Boolean;
    blnAliquotaPis: Boolean;
    blnAliquotaCofins: Boolean;
    blnValorIpi: Boolean;
    blnValorIpiNaoCreditado: Boolean;
    blnFrete: Boolean;
    blnConhecimentoFrete: Boolean;
    blnOutrasDespesas: Boolean;
    blnVendor: Boolean;
    blnDespesaAcessoria: Boolean;
    blnValorIcmsAntecipado: Boolean;
    blnValorIcmsAntecipadoFrete: Boolean;
    blnValorGNRE: Boolean;
    blnValorRetido: Boolean;
    blnValorRetidoNaoCreditado: Boolean;

    procedure CriaObjImpUltModelo;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalculoImpUlt;
    procedure TestCalculoUnitarioImpUlt;
    procedure TestQuandoQuantidadeZeroUnitarioComImpostosTambemZero;

    procedure TestValidaObjetoInvalidoTotalItem;
    procedure TestValidaObjetoInvalidoDescontoEspecial;
    procedure TestValidaObjetoInvalidoAliquotaPIS;
    procedure TestValidaObjetoInvalidoAliquotaCOFINS;
    procedure TestValidaObjetoInvalidoValorIPI;
    procedure TestValidaObjetoInvalidoValorIPINaoCreditado;
    procedure TestValidaObjetoInvalidoFrete;
    procedure TestValidaObjetoInvalidoConhecimentoFrete;
    procedure TestValidaObjetoInvalidoOutrasDespesas;
    procedure TestValidaObjetoInvalidoVendor;
    procedure TestValidaObjetoInvalidoDespesaAcessoria;
    procedure TestValidaObjetoInvalidoValorIcmsAntecipado;
    procedure TestValidaObjetoInvalidoValorIcmsAntecipadoFrete;
    procedure TestValidaObjetoInvalidoValorGNRE;
    procedure TestValidaObjetoInvalidoValorRetido;
    procedure TestValidaObjetoInvalidoValorRetidoNaoCreditado;
  end;
implementation

uses untFuncoesLibFuncoes;

{ TestTCalculoUltimaCompraImpostos }

procedure TestTCalculoUltimaCompraImpostos.CriaObjImpUltModelo;
begin
  objImpUlt := TCalculoUltimaCompraImpostos.fCriaImpUlt;

  If blnTotalItem Then                objImpUlt.TotalItem(1000.0);
  If blnDescontoEspecial Then         objImpUlt.DescontoEspecial(100.0);
  If blnAliquotaPis Then              objImpUlt.AliquotaPis(1.65);
  If blnAliquotaCofins Then           objImpUlt.AliquotaCofins(7.60);
  If blnValorIpi Then                 objImpUlt.ValorIpi(50.0);
  If blnValorIpiNaoCreditado Then     objImpUlt.ValorIpiNaoCreditado(60.0);
  If blnFrete Then                    objImpUlt.Frete(10.0);
  If blnConhecimentoFrete Then        objImpUlt.ConhecimentoFrete(40.0);
  If blnOutrasDespesas Then           objImpUlt.OutrasDespesas(30.0);
  If blnVendor Then                   objImpUlt.Vendor(20.0);
  If blnDespesaAcessoria Then         objImpUlt.DespesaAcessoria(10.0);
  If blnValorIcmsAntecipado Then      objImpUlt.ValorIcmsAntecipado(9.0);
  If blnValorIcmsAntecipadoFrete Then objImpUlt.ValorIcmsAntecipadoFrete(8.0);
  If blnValorGNRE Then                objImpUlt.ValorGNRE(7.0);
  If blnValorRetido Then              objImpUlt.ValorRetido(6.0);
  If blnValorRetidoNaoCreditado Then  objImpUlt.ValorRetidoNaoCreditado(5.0);
end;

procedure TestTCalculoUltimaCompraImpostos.SetUp;
begin
  inherited;
  blnTotalItem := True;
  blnDescontoEspecial := True;
  blnAliquotaPis := True;
  blnAliquotaCofins := True;
  blnValorIpi := True;
  blnValorIpiNaoCreditado := True;
  blnFrete := True;
  blnConhecimentoFrete := True;
  blnOutrasDespesas := True;
  blnVendor := True;
  blnDespesaAcessoria := True;
  blnValorIcmsAntecipado := True;
  blnValorIcmsAntecipadoFrete := True;
  blnValorGNRE := True;
  blnValorRetido := True;
  blnValorRetidoNaoCreditado := True;
end;

procedure TestTCalculoUltimaCompraImpostos.TearDown;
begin
  inherited;
  //
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoTotalItem;
begin
  blnTotalItem := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Total do Item inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoDescontoEspecial;
begin
  blnDescontoEspecial := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Desconto Especial inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoAliquotaPis;
begin
  blnAliquotaPis := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Alíquota de PIS inválida.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoAliquotaCofins;
begin
  blnAliquotaCofins := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Alíquota de COFINS inválida.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoValorIPI;
begin
  blnValorIpi := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Valor do IPI inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoValorIPINaoCreditado;
begin
  blnValorIpiNaoCreditado := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Valor de IPI não creditado inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoFrete;
begin
  blnFrete := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Frete inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoConhecimentoFrete;
begin
  blnConhecimentoFrete := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Conhecimento de Frete inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoOutrasDespesas;
begin
  blnOutrasDespesas := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Outras Despesas inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoVendor;
begin
  blnVendor := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Vendor inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoDespesaAcessoria;
begin
  blnDespesaAcessoria := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Despesa Acessória inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoValorIcmsAntecipado;
begin
  blnValorIcmsAntecipado := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Valor ICMS Antecipado inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoValorIcmsAntecipadoFrete;
begin
  blnValorIcmsAntecipadoFrete := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Valor ICMS Antecipado do Frete inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoValorGNRE;
begin
  blnValorGNRE := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Valor GNRE inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoValorRetido;
begin
  blnValorRetido := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Valor Retido inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestValidaObjetoInvalidoValorRetidoNaoCreditado;
begin
  blnValorRetidoNaoCreditado := False;
  CriaObjImpUltModelo;

  StartExpectingException(Exception);
  objImpUlt.fTotal;
  StopExpectingException('Deveria acusar mensagem de Valor Retido não creditado inválido.');
end;

procedure TestTCalculoUltimaCompraImpostos.TestCalculoImpUlt;
  Var
    ReturnValue: Double;
begin
  CriaObjImpUltModelo;

  ReturnValue := objImpUlt.fTotal;
  CheckEquals(fFormataFloat(1071.75, 4), ReturnValue, 'Valor total do custo com impostos incorreto');
end;

procedure TestTCalculoUltimaCompraImpostos.TestCalculoUnitarioImpUlt;
  Var
    ReturnValue: Double;
  Const
    QUANTIDADE  = 1000.00;
begin
  CriaObjImpUltModelo;

  ReturnValue := objImpUlt.fUnitario(QUANTIDADE);
  CheckEquals(fFormataFloat(1.0717, 4), ReturnValue, 'Valor unitário do custo com impostos incorreto');
end;

procedure TestTCalculoUltimaCompraImpostos.TestQuandoQuantidadeZeroUnitarioComImpostosTambemZero;
  Var
    ReturnValue: Double;
begin
  CriaObjImpUltModelo;

  ReturnValue := objImpUlt.fUnitario(0);
  CheckEquals(fFormataFloat(0, 4), ReturnValue, 'Valor unitário do custo com impostos incorreto');
end;

initialization
  RegisterTest(TestTCalculoUltimaCompraImpostos.Suite);

end.
