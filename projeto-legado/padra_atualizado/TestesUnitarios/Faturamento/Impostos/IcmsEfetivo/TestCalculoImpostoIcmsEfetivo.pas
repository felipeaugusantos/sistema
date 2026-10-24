unit TestCalculoImpostoIcmsEfetivo;

interface

uses
  TestFramework,
  Shared.Functions.Configuracoes,
  Shared.Functions.Core,
  untConsultaModelFaturamento;

type
  TestTCalculoImpostoIcmsEfetivo = class(TTestCase)
  strict private
    FConsultaModel: IConsultaModelFaturamento;
    procedure SetarConfiguracoesDefault;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCalcularValorIcmsEfetivoRetidoClienteConsumidorFinal;
    procedure TestCalcularValorIcmsEfetivoRetidoClienteConsumidorFinal3;
    procedure TestCalcularValorIcmsEfetivoRetido;
    procedure TestCalcularValorIcmsEfetivoRetido2;
    procedure TestCalcularValorIcmsEfetivoQuantidadeZerada;
    procedure TestCalcularComPercentualReducaoBaseCalcEfetiva;
    procedure TestCalcularValorBaseCalculoIcmsStRetidoItemZerado;

    procedure TestCalcularValorOperacaoPropriaIcmsEntradaComDocumentoDeCompra;
    procedure TestCalcularValorOperacaoPropriaIcmsEntradaSemDocumentoDeCompra;
  end;

implementation

uses untCalculoImpostoIcmsEfetivo, untTypesIcmsEfetivo, untConsultaModelFaturamentoMemory,
  Shared.Functions.DataSet, Shared.Functions.Faturamento.TintaDeMaquina, Shared.Functions.Constantes,
  System.SysUtils;

{ TestTCalculoImpostoIcmsEfetivo }

procedure TestTCalculoImpostoIcmsEfetivo.SetarConfiguracoesDefault;
begin

end;

procedure TestTCalculoImpostoIcmsEfetivo.SetUp;
begin
  inherited;
  FConsultaModel := TConsultaModelFaturamentoMemory.Create;
  SetarConfiguracoesDefault;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TearDown;
begin
  inherited;

end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularComPercentualReducaoBaseCalcEfetiva;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
Begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := True;
  AParametros.Quantidade := 1;
  AParametros.QuantidadeItem := 1;
  AParametros.ClienteConsumidorFinal := False;
  AParametros.PercentualReducaoBaseCalcEfetiva := 0;
  AParametros.ValorBaseCalculoEfetiva := 110;
  AParametros.AliquotaIcmsEfetiva := 12;
  AParametros.ValorBaseRetida := 278.17;
  AParametros.ValorRetido := 17.99;
  AParametros.ValorIcmsSubstitutoItem := 0;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);

    CheckTrue(
             (ReturnValue.PercentualReducaoBaseCalcEfetivaItem = 0) And
             (ReturnValue.ValorBaseCalculoEfetivaItem = 0) And
             (ReturnValue.ValorIcmsEfetivaItem = 0) And
             (ReturnValue.AliquotaIcmsEfetivaItem = 0) And
             (ReturnValue.ValorBaseCalculoIcmsStRetidoItem = objCore.fStrToFloat('278,17')) And
             (ReturnValue.ValorIcmsStRetidoItem = objCore.fStrToFloat('17,99')) And
             (ReturnValue.ValorIcmsSubstitutoItem = 0));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularValorBaseCalculoIcmsStRetidoItemZerado;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
Begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := True;
  AParametros.Quantidade := 1;
  AParametros.QuantidadeItem := 1;
  AParametros.ClienteConsumidorFinal := False;
  AParametros.PercentualReducaoBaseCalcEfetiva := 51.11;
  AParametros.ValorBaseCalculoEfetiva := 100;
  AParametros.AliquotaIcmsEfetiva := 0;
  AParametros.ValorBaseRetida := 816.7;
  AParametros.ValorRetido := 81.01;
  AParametros.ValorIcmsSubstitutoItem := 0;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);

    CheckTrue(
             (ReturnValue.PercentualReducaoBaseCalcEfetivaItem = 0) And
             (ReturnValue.ValorBaseCalculoEfetivaItem = 0) And
             (ReturnValue.ValorIcmsEfetivaItem = 0) And
             (ReturnValue.AliquotaIcmsEfetivaItem = 0) And
             (ReturnValue.ValorBaseCalculoIcmsStRetidoItem = objCore.fStrToFloat('816,70')) And
             (ReturnValue.ValorIcmsStRetidoItem = objCore.fStrToFloat('81,01')) And
             (ReturnValue.ValorIcmsSubstitutoItem = 0));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularValorIcmsEfetivoQuantidadeZerada;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
begin
  Fillchar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := true;
  AParametros.Quantidade := 0;
  AParametros.QuantidadeItem := 0;
  AParametros.ClienteConsumidorFinal := false;
  AParametros.PercentualReducaoBaseCalcEfetiva := 51.11;
  AParametros.ValorBaseCalculoEfetiva := 110;
  AParametros.AliquotaIcmsEfetiva := 0;
  AParametros.ValorBaseRetida := 816.7;
  AParametros.ValorRetido := 81.01;
  AParametros.ValorIcmsSubstitutoItem := 0;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);

    CheckTrue ((ReturnValue.PercentualReducaoBaseCalcEfetivaItem = 0) And
              (ReturnValue.ValorBaseCalculoEfetivaItem = 0) And
              (ReturnValue.AliquotaIcmsEfetivaItem = 0) And
              (ReturnValue.ValorIcmsEfetivaItem = 0) And
              (ReturnValue.ValorBaseCalculoIcmsStRetidoItem = 0) And
              (ReturnValue.ValorIcmsStRetidoItem = 0) And
              (ReturnValue.ValorIcmsSubstitutoItem = 0));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularValorIcmsEfetivoRetido;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := true;
  AParametros.Quantidade := 1;
  AParametros.QuantidadeItem := 1;
  AParametros.ClienteConsumidorFinal := false;
  AParametros.PercentualReducaoBaseCalcEfetiva := 51.11;
  AParametros.ValorBaseCalculoEfetiva := 110;
  AParametros.AliquotaIcmsEfetiva := 0;
  AParametros.ValorBaseRetida := 816.7;
  AParametros.ValorRetido := 81.01;
  AParametros.ValorIcmsSubstitutoItem := 0;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);
    CheckTrue ((ReturnValue.PercentualReducaoBaseCalcEfetivaItem = 0) And
              (ReturnValue.ValorBaseCalculoEfetivaItem = 0) And
              (ReturnValue.AliquotaIcmsEfetivaItem = 0) And
              (ReturnValue.ValorIcmsEfetivaItem = 0) And
              (ReturnValue.ValorBaseCalculoIcmsStRetidoItem = objCore.fStrToFloat('816,70')) And
              (ReturnValue.ValorIcmsStRetidoItem = objCore.fStrToFloat('81,01')) And
              (ReturnValue.ValorIcmsSubstitutoItem = 0));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularValorIcmsEfetivoRetido2;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := true;
  AParametros.Quantidade := 1;
  AParametros.QuantidadeItem := 1;
  AParametros.ClienteConsumidorFinal := false;
  AParametros.PercentualReducaoBaseCalcEfetiva := 0;
  AParametros.ValorBaseCalculoEfetiva := 110;
  AParametros.AliquotaIcmsEfetiva := 12;
  AParametros.ValorBaseRetida := 278.17;
  AParametros.ValorRetido := 17.99;
  AParametros.ValorIcmsSubstitutoItem := 0;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);
    CheckTrue ((ReturnValue.PercentualReducaoBaseCalcEfetivaItem = 0) And
              (ReturnValue.ValorBaseCalculoEfetivaItem = 0) And
              (ReturnValue.AliquotaIcmsEfetivaItem = 0) And
              (ReturnValue.ValorIcmsEfetivaItem = 0) And
              (ReturnValue.ValorBaseCalculoIcmsStRetidoItem = objCore.fStrToFloat('278,17')) And
              (ReturnValue.ValorIcmsStRetidoItem = objCore.fStrToFloat('17,99')) And
              (ReturnValue.ValorIcmsSubstitutoItem = 0));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularValorIcmsEfetivoRetidoClienteConsumidorFinal;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := true;
  AParametros.Quantidade := 3;
  AParametros.QuantidadeItem := 1;
  AParametros.ClienteConsumidorFinal := true;
  AParametros.PercentualReducaoBaseCalcEfetiva := 0;
  AParametros.ValorBaseCalculoEfetiva := 110;
  AParametros.AliquotaIcmsEfetiva := 12;
  AParametros.ValorBaseRetida := 278.17;
  AParametros.ValorRetido := 17.99;
  AParametros.ValorIcmsSubstitutoItem := 0;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);

    CheckTrue ((ReturnValue.PercentualReducaoBaseCalcEfetivaItem = 0) And
              (ReturnValue.ValorBaseCalculoEfetivaItem = 110) And
              (ReturnValue.AliquotaIcmsEfetivaItem = 12) And
              (ReturnValue.ValorIcmsEfetivaItem = objCore.fStrToFloat('13,2')) And
              (ReturnValue.ValorBaseCalculoIcmsStRetidoItem = 0) And
              (ReturnValue.ValorIcmsStRetidoItem = 0) And
              (ReturnValue.ValorIcmsSubstitutoItem = 0));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularValorIcmsEfetivoRetidoClienteConsumidorFinal3;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := true;
  AParametros.Quantidade := 10;
  AParametros.QuantidadeItem := 1;
  AParametros.ClienteConsumidorFinal := true;
  AParametros.PercentualReducaoBaseCalcEfetiva := 51.11;
  AParametros.ValorBaseCalculoEfetiva := 100;
  AParametros.AliquotaIcmsEfetiva := 12;
  AParametros.ValorBaseRetida := 816.7;
  AParametros.ValorRetido := 81.01;
  AParametros.ValorIcmsSubstitutoItem := 0;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);

    CheckTrue ((ReturnValue.PercentualReducaoBaseCalcEfetivaItem = objCore.fStrToFloat('51,11')) And
              (ReturnValue.ValorBaseCalculoEfetivaItem = 100) And
              (ReturnValue.AliquotaIcmsEfetivaItem = 12) And
              (ReturnValue.ValorIcmsEfetivaItem = 12) And
              (ReturnValue.ValorBaseCalculoIcmsStRetidoItem = 0) And
              (ReturnValue.ValorIcmsStRetidoItem = 0) And
              (ReturnValue.ValorIcmsSubstitutoItem = 0));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularValorOperacaoPropriaIcmsEntradaComDocumentoDeCompra;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := true;
  AParametros.Quantidade := 3;
  AParametros.QuantidadeItem := 2;
  AParametros.ClienteConsumidorFinal := true;
  AParametros.ValorBaseOperacaoPropriaICMSEntrada := 100;
  AParametros.AliquotaOperacaoPropriaICMSEntrada := 12;
  AParametros.ValorOperacaoPropriaICMSEntrada := 12;
  AParametros.EncontrouDocumentoOperacaoPropriaICMSEntrada := True;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);
    CheckTrue ((ReturnValue.ValorBaseOperacaoPropriaICMSEntrada = 200) And
              (ReturnValue.AliquotaOperacaoPropriaICMSEntrada = 12) And
              (ReturnValue.ValorOperacaoPropriaICMSEntrada = 24));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

procedure TestTCalculoImpostoIcmsEfetivo.TestCalcularValorOperacaoPropriaIcmsEntradaSemDocumentoDeCompra;
  Var
    ReturnValue: TResultadoCalculoIcmsEfetivo;
    AParametros: TParametrosCalculoIcmsEfetivo;
    objCalculoImpostosIcmsEfetivo : TCalculoImpostoIcmsEfetivo;
begin
  FillChar(AParametros, SizeOf(AParametros), #0);
  AParametros.EncontrouDocumento := true;
  AParametros.Quantidade := 3;
  AParametros.QuantidadeItem := 2;
  AParametros.ClienteConsumidorFinal := true;
  AParametros.ValorBaseOperacaoPropriaICMSEntrada := 100;
  AParametros.AliquotaOperacaoPropriaICMSEntrada := 12;
  AParametros.ValorOperacaoPropriaICMSEntrada := 12;
  AParametros.EncontrouDocumentoOperacaoPropriaICMSEntrada := False;

  objCalculoImpostosIcmsEfetivo := TCalculoImpostoIcmsEfetivo.Create(objCore, objDataSet, objConfiguracoes, FConsultaModel, objConstantes, ObjTintaDeMaquina);
  Try
    ReturnValue := objCalculoImpostosIcmsEfetivo.CalcularValorIcmsEfetivo(AParametros);

    CheckTrue ((ReturnValue.ValorBaseOperacaoPropriaICMSEntrada = 100) And
              (ReturnValue.AliquotaOperacaoPropriaICMSEntrada = 12) And
              (ReturnValue.ValorOperacaoPropriaICMSEntrada = 12));
  Finally
    FreeAndNil(objCalculoImpostosIcmsEfetivo);
  End;
end;

initialization
  RegisterTest(TestTCalculoImpostoIcmsEfetivo.Suite);

end.
