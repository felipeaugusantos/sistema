unit TestFaturamento.Impostos.Calculos.Difal.CS_FERRAMENTAS_Lj001_20191209;

{--------------------------------------------------------------------------
                    RESUMO DIFAL                 
--------------------------------------------------------------------------
Empresa            : 001 - CS FERRAMENTAS LTDA
Período Selecionado: 09/12/2019 até 09/12/2019
Data do Processo   : 10/12/2019 
Hora Inicio        : 15:38:10
Hora Fim           : 15:42:16
Tempo Total        : 00:04:06
                                           
Total Registros    : 546
Total Processados  : 546
Total de Acertos   : 54
Total de Erros     : 0
Total Ignorados    : 474
Total Duplicados   : 18
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.Difal,
Faturamento.Impostos.Tipos.Difal,
Faturamento.Impostos.Interfaces.Difal;

type
TestCSFERRAMENTAS = class(TTestCase)
strict private
private


  FRecordDifalFCP: TRecDifalFCP;


published

Procedure Difal_CSFERRAMENTAS_000001;
Procedure Difal_CSFERRAMENTAS_000002;
Procedure Difal_CSFERRAMENTAS_000003;
Procedure Difal_CSFERRAMENTAS_000004;
Procedure Difal_CSFERRAMENTAS_000005;
Procedure Difal_CSFERRAMENTAS_000006;
Procedure Difal_CSFERRAMENTAS_000007;
Procedure Difal_CSFERRAMENTAS_000008;
Procedure Difal_CSFERRAMENTAS_000009;
Procedure Difal_CSFERRAMENTAS_000010;
Procedure Difal_CSFERRAMENTAS_000011;
Procedure Difal_CSFERRAMENTAS_000012;
Procedure Difal_CSFERRAMENTAS_000013;
Procedure Difal_CSFERRAMENTAS_000014;
Procedure Difal_CSFERRAMENTAS_000015;
Procedure Difal_CSFERRAMENTAS_000016;
Procedure Difal_CSFERRAMENTAS_000017;
Procedure Difal_CSFERRAMENTAS_000018;
Procedure Difal_CSFERRAMENTAS_000019;
Procedure Difal_CSFERRAMENTAS_000020;
Procedure Difal_CSFERRAMENTAS_000021;
Procedure Difal_CSFERRAMENTAS_000022;
Procedure Difal_CSFERRAMENTAS_000023;
Procedure Difal_CSFERRAMENTAS_000024;
Procedure Difal_CSFERRAMENTAS_000025;
Procedure Difal_CSFERRAMENTAS_000026;
Procedure Difal_CSFERRAMENTAS_000027;
Procedure Difal_CSFERRAMENTAS_000028;
Procedure Difal_CSFERRAMENTAS_000029;
Procedure Difal_CSFERRAMENTAS_000030;
Procedure Difal_CSFERRAMENTAS_000031;
Procedure Difal_CSFERRAMENTAS_000032;
Procedure Difal_CSFERRAMENTAS_000033;
Procedure Difal_CSFERRAMENTAS_000034;
Procedure Difal_CSFERRAMENTAS_000035;
Procedure Difal_CSFERRAMENTAS_000036;
Procedure Difal_CSFERRAMENTAS_000037;
Procedure Difal_CSFERRAMENTAS_000038;
Procedure Difal_CSFERRAMENTAS_000039;
Procedure Difal_CSFERRAMENTAS_000040;
Procedure Difal_CSFERRAMENTAS_000041;
Procedure Difal_CSFERRAMENTAS_000042;
Procedure Difal_CSFERRAMENTAS_000043;
Procedure Difal_CSFERRAMENTAS_000044;
Procedure Difal_CSFERRAMENTAS_000045;
Procedure Difal_CSFERRAMENTAS_000046;
Procedure Difal_CSFERRAMENTAS_000047;
Procedure Difal_CSFERRAMENTAS_000048;
Procedure Difal_CSFERRAMENTAS_000049;
Procedure Difal_CSFERRAMENTAS_000050;
Procedure Difal_CSFERRAMENTAS_000051;
Procedure Difal_CSFERRAMENTAS_000052;
Procedure Difal_CSFERRAMENTAS_000053;
Procedure Difal_CSFERRAMENTAS_000054;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestCSFERRAMENTAS.SetUp;
begin
end;

procedure TestCSFERRAMENTAS.TearDown;
begin
end;

Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220748" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18965" AND DET_CODCLI = "00076852";
    DOCUMENTO: 000000220748
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076852
       ESTADO: PR
         ITEM: 18965
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 139.44;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 996;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(996)
      .TotalDoItem(996)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(48.89)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{996}, objFloatUtils.fStrToFloat('996')) And
            CompararValores(ReturnValue.ValorIcmsDestino{139,44}, objFloatUtils.fStrToFloat('139,44')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{139,44}, objFloatUtils.fStrToFloat('139,44')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{996}, objFloatUtils.fStrToFloat('996')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220749" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18965" AND DET_CODCLI = "00076853";
    DOCUMENTO: 000000220749
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076853
       ESTADO: PR
         ITEM: 18965
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 139.44;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 996;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(996)
      .TotalDoItem(996)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{996}, objFloatUtils.fStrToFloat('996')) And
            CompararValores(ReturnValue.ValorIcmsDestino{139,44}, objFloatUtils.fStrToFloat('139,44')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{139,44}, objFloatUtils.fStrToFloat('139,44')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{996}, objFloatUtils.fStrToFloat('996')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220750" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19591" AND DET_CODCLI = "00076849";
    DOCUMENTO: 000000220750
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076849
       ESTADO: MS
         ITEM: 19591
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 35.64;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 356.4;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(356.4)
      .TotalDoItem(356.4)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{356,4}, objFloatUtils.fStrToFloat('356,4')) And
            CompararValores(ReturnValue.ValorIcmsDestino{35,64}, objFloatUtils.fStrToFloat('35,64')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{35,64}, objFloatUtils.fStrToFloat('35,64')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{356,4}, objFloatUtils.fStrToFloat('356,4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220756" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01511" AND DET_CODCLI = "00076890";
    DOCUMENTO: 000000220756
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076890
       ESTADO: MG
         ITEM: 01511
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 3.42;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 56.95;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(7.45)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(56.95)
      .TotalDoItem(49.5)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{56,95}, objFloatUtils.fStrToFloat('56,95')) And
            CompararValores(ReturnValue.ValorIcmsDestino{3,417}, objFloatUtils.fStrToFloat('3,417')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{3,417}, objFloatUtils.fStrToFloat('3,42')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{56,95}, objFloatUtils.fStrToFloat('56,95')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220756" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01509" AND DET_CODCLI = "00076890";
    DOCUMENTO: 000000220756
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076890
       ESTADO: MG
         ITEM: 01509
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 2.09;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 34.83;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(4.55)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(34.83)
      .TotalDoItem(30.28)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{34,83}, objFloatUtils.fStrToFloat('34,83')) And
            CompararValores(ReturnValue.ValorIcmsDestino{2,0898}, objFloatUtils.fStrToFloat('2,0898')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{2,0898}, objFloatUtils.fStrToFloat('2,09')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{34,83}, objFloatUtils.fStrToFloat('34,83')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220756" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01510" AND DET_CODCLI = "00076890";
    DOCUMENTO: 000000220756
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076890
       ESTADO: MG
         ITEM: 01510
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 2.71;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 45.12;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(5.9)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(45.12)
      .TotalDoItem(39.22)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{45,12}, objFloatUtils.fStrToFloat('45,12')) And
            CompararValores(ReturnValue.ValorIcmsDestino{2,7072}, objFloatUtils.fStrToFloat('2,7072')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{2,7072}, objFloatUtils.fStrToFloat('2,71')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{45,12}, objFloatUtils.fStrToFloat('45,12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220757" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29976" AND DET_CODCLI = "00076909";
    DOCUMENTO: 000000220757
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076909
       ESTADO: DF
         ITEM: 29976
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 11;
  FRecordDifalFCP.fltDifDes := 96.4;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 878.19;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(878.19)
      .TotalDoItem(1195.95)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(73.33)
      .PercentualBaseDestino(73.43)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(True)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('20')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{878,186085}, objFloatUtils.fStrToFloat('878,186085')) And
            CompararValores(ReturnValue.ValorIcmsDestino{96,4}, objFloatUtils.fStrToFloat('96,4')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{96,4}, objFloatUtils.fStrToFloat('96,4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{878,186085}, objFloatUtils.fStrToFloat('878,19')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220758" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34522" AND DET_CODCLI = "00076879";
    DOCUMENTO: 000000220758
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076879
       ESTADO: MG
         ITEM: 34522
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 29.39;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 209.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(209.9)
      .TotalDoItem(209.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{209,9}, objFloatUtils.fStrToFloat('209,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{29,386}, objFloatUtils.fStrToFloat('29,386')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{29,386}, objFloatUtils.fStrToFloat('29,39')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{209,9}, objFloatUtils.fStrToFloat('209,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220759" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34522" AND DET_CODCLI = "00076891";
    DOCUMENTO: 000000220759
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076891
       ESTADO: PR
         ITEM: 34522
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 33.59;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 239.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(239.9)
      .TotalDoItem(239.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{239,9}, objFloatUtils.fStrToFloat('239,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{33,586}, objFloatUtils.fStrToFloat('33,586')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{33,586}, objFloatUtils.fStrToFloat('33,59')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{239,9}, objFloatUtils.fStrToFloat('239,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220760" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076914";
    DOCUMENTO: 000000220760
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076914
       ESTADO: PI
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 44.95;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 345.8;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(99.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(345.8)
      .TotalDoItem(245.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{345,8}, objFloatUtils.fStrToFloat('345,8')) And
            CompararValores(ReturnValue.ValorIcmsDestino{44,954}, objFloatUtils.fStrToFloat('44,954')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{44,954}, objFloatUtils.fStrToFloat('44,95')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{345,8}, objFloatUtils.fStrToFloat('345,8')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220761" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076913";
    DOCUMENTO: 000000220761
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076913
       ESTADO: AM
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 36.26;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 259;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(259)
      .TotalDoItem(259)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{259}, objFloatUtils.fStrToFloat('259')) And
            CompararValores(ReturnValue.ValorIcmsDestino{36,26}, objFloatUtils.fStrToFloat('36,26')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{36,26}, objFloatUtils.fStrToFloat('36,26')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{259}, objFloatUtils.fStrToFloat('259')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220762" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076900";
    DOCUMENTO: 000000220762
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076900
       ESTADO: CE
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 36.39;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 259.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(259.9)
      .TotalDoItem(259.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{259,9}, objFloatUtils.fStrToFloat('259,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{36,386}, objFloatUtils.fStrToFloat('36,386')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{36,386}, objFloatUtils.fStrToFloat('36,39')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{259,9}, objFloatUtils.fStrToFloat('259,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220763" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35786" AND DET_CODCLI = "00076898";
    DOCUMENTO: 000000220763
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076898
       ESTADO: AC
         ITEM: 35786
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 47.96;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 368.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(59.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(368.9)
      .TotalDoItem(309)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{368,9}, objFloatUtils.fStrToFloat('368,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{47,957}, objFloatUtils.fStrToFloat('47,957')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{47,957}, objFloatUtils.fStrToFloat('47,96')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{368,9}, objFloatUtils.fStrToFloat('368,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220764" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34522" AND DET_CODCLI = "00076860";
    DOCUMENTO: 000000220764
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076860
       ESTADO: RJ
         ITEM: 34522
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 32.19;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 229.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(229.9)
      .TotalDoItem(229.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{229,9}, objFloatUtils.fStrToFloat('229,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{32,186}, objFloatUtils.fStrToFloat('32,186')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{32,186}, objFloatUtils.fStrToFloat('32,19')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{229,9}, objFloatUtils.fStrToFloat('229,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220765" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35786" AND DET_CODCLI = "00076901";
    DOCUMENTO: 000000220765
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076901
       ESTADO: MG
         ITEM: 35786
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 44.66;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 319;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(319)
      .TotalDoItem(319)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{319}, objFloatUtils.fStrToFloat('319')) And
            CompararValores(ReturnValue.ValorIcmsDestino{44,66}, objFloatUtils.fStrToFloat('44,66')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{44,66}, objFloatUtils.fStrToFloat('44,66')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{319}, objFloatUtils.fStrToFloat('319')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220766" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35786" AND DET_CODCLI = "00076904";
    DOCUMENTO: 000000220766
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076904
       ESTADO: PR
         ITEM: 35786
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 43.26;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 309;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(309)
      .TotalDoItem(309)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{309}, objFloatUtils.fStrToFloat('309')) And
            CompararValores(ReturnValue.ValorIcmsDestino{43,26}, objFloatUtils.fStrToFloat('43,26')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{43,26}, objFloatUtils.fStrToFloat('43,26')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{309}, objFloatUtils.fStrToFloat('309')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220775" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31371" AND DET_CODCLI = "00076967";
    DOCUMENTO: 000000220775
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076967
       ESTADO: RS
         ITEM: 31371
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 32.98;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 549.69;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(549.69)
      .TotalDoItem(549.69)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{549,69}, objFloatUtils.fStrToFloat('549,69')) And
            CompararValores(ReturnValue.ValorIcmsDestino{32,9814}, objFloatUtils.fStrToFloat('32,9814')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{32,9814}, objFloatUtils.fStrToFloat('32,98')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{549,69}, objFloatUtils.fStrToFloat('549,69')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220777" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35073" AND DET_CODCLI = "00076928";
    DOCUMENTO: 000000220777
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076928
       ESTADO: MG
         ITEM: 35073
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 35.94;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 599;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(599)
      .TotalDoItem(599)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{599}, objFloatUtils.fStrToFloat('599')) And
            CompararValores(ReturnValue.ValorIcmsDestino{35,94}, objFloatUtils.fStrToFloat('35,94')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{35,94}, objFloatUtils.fStrToFloat('35,94')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{599}, objFloatUtils.fStrToFloat('599')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220778" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35073" AND DET_CODCLI = "00076936";
    DOCUMENTO: 000000220778
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076936
       ESTADO: RS
         ITEM: 35073
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 35.34;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 589;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(589)
      .TotalDoItem(589)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{589}, objFloatUtils.fStrToFloat('589')) And
            CompararValores(ReturnValue.ValorIcmsDestino{35,34}, objFloatUtils.fStrToFloat('35,34')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{35,34}, objFloatUtils.fStrToFloat('35,34')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{589}, objFloatUtils.fStrToFloat('589')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220779" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35072" AND DET_CODCLI = "00076988";
    DOCUMENTO: 000000220779
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076988
       ESTADO: CE
         ITEM: 35072
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 11;
  FRecordDifalFCP.fltDifDes := 106.45;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 967.75;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(338.75)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(967.75)
      .TotalDoItem(629)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{967,75}, objFloatUtils.fStrToFloat('967,75')) And
            CompararValores(ReturnValue.ValorIcmsDestino{106,4525}, objFloatUtils.fStrToFloat('106,4525')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{106,4525}, objFloatUtils.fStrToFloat('106,45')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{967,75}, objFloatUtils.fStrToFloat('967,75')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220781" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076910";
    DOCUMENTO: 000000220781
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076910
       ESTADO: PE
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 37.09;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 264.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(264.9)
      .TotalDoItem(264.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{264,9}, objFloatUtils.fStrToFloat('264,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{37,086}, objFloatUtils.fStrToFloat('37,086')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{37,086}, objFloatUtils.fStrToFloat('37,09')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{264,9}, objFloatUtils.fStrToFloat('264,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220786" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34522" AND DET_CODCLI = "00076992";
    DOCUMENTO: 000000220786
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076992
       ESTADO: MS
         ITEM: 34522
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 29.89;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 229.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(229.9)
      .TotalDoItem(229.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{229,9}, objFloatUtils.fStrToFloat('229,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{29,887}, objFloatUtils.fStrToFloat('29,887')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{29,887}, objFloatUtils.fStrToFloat('29,89')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{229,9}, objFloatUtils.fStrToFloat('229,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220792" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35786" AND DET_CODCLI = "00076981";
    DOCUMENTO: 000000220792
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076981
       ESTADO: PR
         ITEM: 35786
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 46.06;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 329;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(329)
      .TotalDoItem(329)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{329}, objFloatUtils.fStrToFloat('329')) And
            CompararValores(ReturnValue.ValorIcmsDestino{46,06}, objFloatUtils.fStrToFloat('46,06')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{46,06}, objFloatUtils.fStrToFloat('46,06')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{329}, objFloatUtils.fStrToFloat('329')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220796" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17662" AND DET_CODCLI = "00076986";
    DOCUMENTO: 000000220796
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076986
       ESTADO: RJ
         ITEM: 17662
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 90.86;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 649;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(649)
      .TotalDoItem(649)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(8.8)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{649}, objFloatUtils.fStrToFloat('649')) And
            CompararValores(ReturnValue.ValorIcmsDestino{90,86}, objFloatUtils.fStrToFloat('90,86')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{90,86}, objFloatUtils.fStrToFloat('90,86')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{649}, objFloatUtils.fStrToFloat('649')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220797" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31183" AND DET_CODCLI = "00076932";
    DOCUMENTO: 000000220797
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076932
       ESTADO: CE
         ITEM: 31183
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 3.49;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 24.94;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(24.94)
      .TotalDoItem(24.94)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{24,94}, objFloatUtils.fStrToFloat('24,94')) And
            CompararValores(ReturnValue.ValorIcmsDestino{3,4916}, objFloatUtils.fStrToFloat('3,4916')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{3,4916}, objFloatUtils.fStrToFloat('3,49')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{24,94}, objFloatUtils.fStrToFloat('24,94')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220797" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19265" AND DET_CODCLI = "00076932";
    DOCUMENTO: 000000220797
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076932
       ESTADO: CE
         ITEM: 19265
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 23.81;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 170.06;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(170.06)
      .TotalDoItem(170.06)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{170,06}, objFloatUtils.fStrToFloat('170,06')) And
            CompararValores(ReturnValue.ValorIcmsDestino{23,8084}, objFloatUtils.fStrToFloat('23,8084')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{23,8084}, objFloatUtils.fStrToFloat('23,81')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{170,06}, objFloatUtils.fStrToFloat('170,06')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220798" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "25773" AND DET_CODCLI = "00076854";
    DOCUMENTO: 000000220798
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076854
       ESTADO: RN
         ITEM: 25773
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 30.66;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 219;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(219)
      .TotalDoItem(219)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{219}, objFloatUtils.fStrToFloat('219')) And
            CompararValores(ReturnValue.ValorIcmsDestino{30,66}, objFloatUtils.fStrToFloat('30,66')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{30,66}, objFloatUtils.fStrToFloat('30,66')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{219}, objFloatUtils.fStrToFloat('219')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220799" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35786" AND DET_CODCLI = "00076957";
    DOCUMENTO: 000000220799
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076957
       ESTADO: RS
         ITEM: 35786
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 43.56;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 311.17;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(311.17)
      .TotalDoItem(311.17)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{311,17}, objFloatUtils.fStrToFloat('311,17')) And
            CompararValores(ReturnValue.ValorIcmsDestino{43,5638}, objFloatUtils.fStrToFloat('43,5638')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{43,5638}, objFloatUtils.fStrToFloat('43,56')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{311,17}, objFloatUtils.fStrToFloat('311,17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220799" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34942" AND DET_CODCLI = "00076957";
    DOCUMENTO: 000000220799
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076957
       ESTADO: RS
         ITEM: 34942
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 13.82;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 98.73;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(98.73)
      .TotalDoItem(98.73)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{98,73}, objFloatUtils.fStrToFloat('98,73')) And
            CompararValores(ReturnValue.ValorIcmsDestino{13,8222}, objFloatUtils.fStrToFloat('13,8222')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{13,8222}, objFloatUtils.fStrToFloat('13,82')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{98,73}, objFloatUtils.fStrToFloat('98,73')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220800" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05971" AND DET_CODCLI = "00076975";
    DOCUMENTO: 000000220800
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076975
       ESTADO: MG
         ITEM: 05971
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 46.19;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 329.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(329.9)
      .TotalDoItem(329.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{329,9}, objFloatUtils.fStrToFloat('329,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{46,186}, objFloatUtils.fStrToFloat('46,186')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{46,186}, objFloatUtils.fStrToFloat('46,19')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{329,9}, objFloatUtils.fStrToFloat('329,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220804" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18601" AND DET_CODCLI = "00076983";
    DOCUMENTO: 000000220804
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076983
       ESTADO: ES
         ITEM: 18601
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 1.2;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 11.95;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(11.95)
      .TotalDoItem(11.95)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{11,95}, objFloatUtils.fStrToFloat('11,95')) And
            CompararValores(ReturnValue.ValorIcmsDestino{1,195}, objFloatUtils.fStrToFloat('1,195')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{1,195}, objFloatUtils.fStrToFloat('1,2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{11,95}, objFloatUtils.fStrToFloat('11,95')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220804" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076983";
    DOCUMENTO: 000000220804
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076983
       ESTADO: ES
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 32.23;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 247.95;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(247.95)
      .TotalDoItem(247.95)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{247,95}, objFloatUtils.fStrToFloat('247,95')) And
            CompararValores(ReturnValue.ValorIcmsDestino{32,2335}, objFloatUtils.fStrToFloat('32,2335')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{32,2335}, objFloatUtils.fStrToFloat('32,23')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{247,95}, objFloatUtils.fStrToFloat('247,95')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220808" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18965" AND DET_CODCLI = "00076940";
    DOCUMENTO: 000000220808
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076940
       ESTADO: GO
         ITEM: 18965
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 129.48;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 996;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(996)
      .TotalDoItem(996)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{996}, objFloatUtils.fStrToFloat('996')) And
            CompararValores(ReturnValue.ValorIcmsDestino{129,48}, objFloatUtils.fStrToFloat('129,48')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{129,48}, objFloatUtils.fStrToFloat('129,48')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{996}, objFloatUtils.fStrToFloat('996')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220822" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32369" AND DET_CODCLI = "00076927";
    DOCUMENTO: 000000220822
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076927
       ESTADO: RJ
         ITEM: 32369
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 23.66;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 169;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(169)
      .TotalDoItem(169)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{169}, objFloatUtils.fStrToFloat('169')) And
            CompararValores(ReturnValue.ValorIcmsDestino{23,66}, objFloatUtils.fStrToFloat('23,66')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{23,66}, objFloatUtils.fStrToFloat('23,66')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{169}, objFloatUtils.fStrToFloat('169')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220823" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20319" AND DET_CODCLI = "00076929";
    DOCUMENTO: 000000220823
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076929
       ESTADO: MG
         ITEM: 20319
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 47.5;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 339.29;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(339.29)
      .TotalDoItem(339.29)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{339,29}, objFloatUtils.fStrToFloat('339,29')) And
            CompararValores(ReturnValue.ValorIcmsDestino{47,5006}, objFloatUtils.fStrToFloat('47,5006')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{47,5006}, objFloatUtils.fStrToFloat('47,5')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{339,29}, objFloatUtils.fStrToFloat('339,29')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220823" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03536" AND DET_CODCLI = "00076929";
    DOCUMENTO: 000000220823
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076929
       ESTADO: MG
         ITEM: 03536
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 20.42;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 145.85;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(145.85)
      .TotalDoItem(145.85)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{145,85}, objFloatUtils.fStrToFloat('145,85')) And
            CompararValores(ReturnValue.ValorIcmsDestino{20,419}, objFloatUtils.fStrToFloat('20,419')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{20,419}, objFloatUtils.fStrToFloat('20,42')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{145,85}, objFloatUtils.fStrToFloat('145,85')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220825" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "00721" AND DET_CODCLI = "00072569";
    DOCUMENTO: 000000220825
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00072569
       ESTADO: DF
         ITEM: 00721
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 13.17;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 94.09;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(23.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(94.09)
      .TotalDoItem(70.19)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{94,09}, objFloatUtils.fStrToFloat('94,09')) And
            CompararValores(ReturnValue.ValorIcmsDestino{13,1726}, objFloatUtils.fStrToFloat('13,1726')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{13,1726}, objFloatUtils.fStrToFloat('13,17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{94,09}, objFloatUtils.fStrToFloat('94,09')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220826" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "02473" AND DET_CODCLI = "00076880";
    DOCUMENTO: 000000220826
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076880
       ESTADO: GO
         ITEM: 02473
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 7.69;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 59.15;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(20.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(59.15)
      .TotalDoItem(38.25)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{59,15}, objFloatUtils.fStrToFloat('59,15')) And
            CompararValores(ReturnValue.ValorIcmsDestino{7,6895}, objFloatUtils.fStrToFloat('7,6895')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{7,6895}, objFloatUtils.fStrToFloat('7,69')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{59,15}, objFloatUtils.fStrToFloat('59,15')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220827" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "25546" AND DET_CODCLI = "00076855";
    DOCUMENTO: 000000220827
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076855
       ESTADO: RJ
         ITEM: 25546
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 7.1;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 118.34;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(15.9)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(118.34)
      .TotalDoItem(102.44)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{118,34}, objFloatUtils.fStrToFloat('118,34')) And
            CompararValores(ReturnValue.ValorIcmsDestino{7,1004}, objFloatUtils.fStrToFloat('7,1004')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{7,1004}, objFloatUtils.fStrToFloat('7,1')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{118,34}, objFloatUtils.fStrToFloat('118,34')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220830" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14652" AND DET_CODCLI = "00076999";
    DOCUMENTO: 000000220830
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076999
       ESTADO: PR
         ITEM: 14652
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 7.53;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 53.8;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(13.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(53.8)
      .TotalDoItem(39.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{53,8}, objFloatUtils.fStrToFloat('53,8')) And
            CompararValores(ReturnValue.ValorIcmsDestino{7,532}, objFloatUtils.fStrToFloat('7,532')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{7,532}, objFloatUtils.fStrToFloat('7,53')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{53,8}, objFloatUtils.fStrToFloat('53,8')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220832" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14652" AND DET_CODCLI = "00076985";
    DOCUMENTO: 000000220832
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076985
       ESTADO: GO
         ITEM: 14652
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 7.12;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 54.8;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(14.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(54.8)
      .TotalDoItem(39.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{54,8}, objFloatUtils.fStrToFloat('54,8')) And
            CompararValores(ReturnValue.ValorIcmsDestino{7,124}, objFloatUtils.fStrToFloat('7,124')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{7,124}, objFloatUtils.fStrToFloat('7,12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{54,8}, objFloatUtils.fStrToFloat('54,8')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220833" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20942" AND DET_CODCLI = "00076969";
    DOCUMENTO: 000000220833
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076969
       ESTADO: MG
         ITEM: 20942
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 8.13;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 58.1;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(14.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(58.1)
      .TotalDoItem(43.2)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{58,1}, objFloatUtils.fStrToFloat('58,1')) And
            CompararValores(ReturnValue.ValorIcmsDestino{8,134}, objFloatUtils.fStrToFloat('8,134')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{8,134}, objFloatUtils.fStrToFloat('8,13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{58,1}, objFloatUtils.fStrToFloat('58,1')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220834" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "03624" AND DET_CODCLI = "00076930";
    DOCUMENTO: 000000220834
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076930
       ESTADO: MG
         ITEM: 03624
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 67.19;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 479.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(479.9)
      .TotalDoItem(479.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{479,9}, objFloatUtils.fStrToFloat('479,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{67,186}, objFloatUtils.fStrToFloat('67,186')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{67,186}, objFloatUtils.fStrToFloat('67,19')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{479,9}, objFloatUtils.fStrToFloat('479,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220835" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32556" AND DET_CODCLI = "00076998";
    DOCUMENTO: 000000220835
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076998
       ESTADO: RJ
         ITEM: 32556
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 5.39;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 38.48;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(10.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(38.48)
      .TotalDoItem(27.58)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{38,48}, objFloatUtils.fStrToFloat('38,48')) And
            CompararValores(ReturnValue.ValorIcmsDestino{5,3872}, objFloatUtils.fStrToFloat('5,3872')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{5,3872}, objFloatUtils.fStrToFloat('5,39')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{38,48}, objFloatUtils.fStrToFloat('38,48')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220836" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20140" AND DET_CODCLI = "00076997";
    DOCUMENTO: 000000220836
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076997
       ESTADO: DF
         ITEM: 20140
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 5.93;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 42.38;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(42.38)
      .TotalDoItem(42.38)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{42,38}, objFloatUtils.fStrToFloat('42,38')) And
            CompararValores(ReturnValue.ValorIcmsDestino{5,9332}, objFloatUtils.fStrToFloat('5,9332')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{5,9332}, objFloatUtils.fStrToFloat('5,93')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{42,38}, objFloatUtils.fStrToFloat('42,38')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220836" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20139" AND DET_CODCLI = "00076997";
    DOCUMENTO: 000000220836
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076997
       ESTADO: DF
         ITEM: 20139
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 5.25;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 37.47;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(37.47)
      .TotalDoItem(37.47)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{37,47}, objFloatUtils.fStrToFloat('37,47')) And
            CompararValores(ReturnValue.ValorIcmsDestino{5,2458}, objFloatUtils.fStrToFloat('5,2458')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{5,2458}, objFloatUtils.fStrToFloat('5,25')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{37,47}, objFloatUtils.fStrToFloat('37,47')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220836" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16894" AND DET_CODCLI = "00076997";
    DOCUMENTO: 000000220836
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076997
       ESTADO: DF
         ITEM: 16894
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 6.1;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 43.57;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(43.57)
      .TotalDoItem(43.57)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{43,57}, objFloatUtils.fStrToFloat('43,57')) And
            CompararValores(ReturnValue.ValorIcmsDestino{6,0998}, objFloatUtils.fStrToFloat('6,0998')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{6,0998}, objFloatUtils.fStrToFloat('6,1')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{43,57}, objFloatUtils.fStrToFloat('43,57')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220836" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "08422" AND DET_CODCLI = "00076997";
    DOCUMENTO: 000000220836
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076997
       ESTADO: DF
         ITEM: 08422
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 6.16;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 44.01;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(44.01)
      .TotalDoItem(44.01)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{44,01}, objFloatUtils.fStrToFloat('44,01')) And
            CompararValores(ReturnValue.ValorIcmsDestino{6,1614}, objFloatUtils.fStrToFloat('6,1614')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{6,1614}, objFloatUtils.fStrToFloat('6,16')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{44,01}, objFloatUtils.fStrToFloat('44,01')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220843" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06189" AND DET_CODCLI = "00076952";
    DOCUMENTO: 000000220843
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076952
       ESTADO: MA
         ITEM: 06189
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 27.99;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 199.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(199.9)
      .TotalDoItem(199.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{199,9}, objFloatUtils.fStrToFloat('199,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{27,986}, objFloatUtils.fStrToFloat('27,986')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{27,986}, objFloatUtils.fStrToFloat('27,99')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{199,9}, objFloatUtils.fStrToFloat('199,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220844" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32219" AND DET_CODCLI = "00076951";
    DOCUMENTO: 000000220844
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076951
       ESTADO: ES
         ITEM: 32219
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 4.38;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 43.8;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(11.9)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(43.8)
      .TotalDoItem(31.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{43,8}, objFloatUtils.fStrToFloat('43,8')) And
            CompararValores(ReturnValue.ValorIcmsDestino{4,38}, objFloatUtils.fStrToFloat('4,38')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{4,38}, objFloatUtils.fStrToFloat('4,38')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{43,8}, objFloatUtils.fStrToFloat('43,8')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220847" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06190" AND DET_CODCLI = "00076941";
    DOCUMENTO: 000000220847
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076941
       ESTADO: RJ
         ITEM: 06190
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 13.99;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 99.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(99.9)
      .TotalDoItem(99.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(0)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{99,9}, objFloatUtils.fStrToFloat('99,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{13,986}, objFloatUtils.fStrToFloat('13,986')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{13,986}, objFloatUtils.fStrToFloat('13,99')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{99,9}, objFloatUtils.fStrToFloat('99,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000052;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220876" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076719";
    DOCUMENTO: 000000220876
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076719
       ESTADO: CE
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 34.86;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 249;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(249)
      .TotalDoItem(249)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{249}, objFloatUtils.fStrToFloat('249')) And
            CompararValores(ReturnValue.ValorIcmsDestino{34,86}, objFloatUtils.fStrToFloat('34,86')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{34,86}, objFloatUtils.fStrToFloat('34,86')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{249}, objFloatUtils.fStrToFloat('249')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000053;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220877" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33970" AND DET_CODCLI = "00076903";
    DOCUMENTO: 000000220877
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076903
       ESTADO: RS
         ITEM: 33970
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 37.42;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 267.25;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(267.25)
      .TotalDoItem(267.25)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(48.89)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{267,25}, objFloatUtils.fStrToFloat('267,25')) And
            CompararValores(ReturnValue.ValorIcmsDestino{37,415}, objFloatUtils.fStrToFloat('37,415')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{37,415}, objFloatUtils.fStrToFloat('37,42')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{267,25}, objFloatUtils.fStrToFloat('267,25')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000054;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220877" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31747" AND DET_CODCLI = "00076903";
    DOCUMENTO: 000000220877
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076903
       ESTADO: RS
         ITEM: 31747
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 14.37;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 102.65;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(13.39)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(102.65)
      .TotalDoItem(89.26)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(4)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(True)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{102,65}, objFloatUtils.fStrToFloat('102,65')) And
            CompararValores(ReturnValue.ValorIcmsDestino{14,371}, objFloatUtils.fStrToFloat('14,371')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{14,371}, objFloatUtils.fStrToFloat('14,37')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{102,65}, objFloatUtils.fStrToFloat('102,65')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;




initialization
  RegisterTest(TestCSFERRAMENTAS.Suite);
end.

