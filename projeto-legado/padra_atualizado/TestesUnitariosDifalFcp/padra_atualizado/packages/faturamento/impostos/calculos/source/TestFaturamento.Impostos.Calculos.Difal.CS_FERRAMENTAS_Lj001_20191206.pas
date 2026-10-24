unit TestFaturamento.Impostos.Calculos.Difal.CS_FERRAMENTAS_Lj001_20191206;

{--------------------------------------------------------------------------
                    RESUMO DIFAL                 
--------------------------------------------------------------------------
Empresa            : 001 - CS FERRAMENTAS LTDA
Período Selecionado: 06/12/2019 até 06/12/2019
Data do Processo   : 10/12/2019 
Hora Inicio        : 16:14:23
Hora Fim           : 16:19:04
Tempo Total        : 00:04:40
                                           
Total Registros    : 363
Total Processados  : 363
Total de Acertos   : 51
Total de Erros     : 0
Total Ignorados    : 306
Total Duplicados   : 6
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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220591" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076589";
    DOCUMENTO: 000000220591
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076589
       ESTADO: PE
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 34.43;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 245.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(245.9)
      .TotalDoItem(245.9)
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
            CompararValores(ReturnValue.ValorBaseDestino{245,9}, objFloatUtils.fStrToFloat('245,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{34,426}, objFloatUtils.fStrToFloat('34,426')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{34,426}, objFloatUtils.fStrToFloat('34,43')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{245,9}, objFloatUtils.fStrToFloat('245,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220593" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "13288" AND DET_CODCLI = "00076512";
    DOCUMENTO: 000000220593
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076512
       ESTADO: RJ
         ITEM: 13288
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 5.04;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 36.01;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(16.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(36.01)
      .TotalDoItem(19.11)
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
            CompararValores(ReturnValue.ValorBaseDestino{36,01}, objFloatUtils.fStrToFloat('36,01')) And
            CompararValores(ReturnValue.ValorIcmsDestino{5,0414}, objFloatUtils.fStrToFloat('5,0414')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{5,0414}, objFloatUtils.fStrToFloat('5,04')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{36,01}, objFloatUtils.fStrToFloat('36,01')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220594" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18965" AND DET_CODCLI = "00076588";
    DOCUMENTO: 000000220594
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076588
       ESTADO: RO
         ITEM: 18965
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13.5;
  FRecordDifalFCP.fltDifDes := 134.46;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17.5;
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
      .AliquotaInternaEstadoDestino(17.5)
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
            CompararValores(ReturnValue.ValorIcmsDestino{134,46}, objFloatUtils.fStrToFloat('134,46')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13,5}, objFloatUtils.fStrToFloat('13,5')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{134,46}, objFloatUtils.fStrToFloat('134,46')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17,5}, objFloatUtils.fStrToFloat('17,5')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{996}, objFloatUtils.fStrToFloat('996')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220595" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01792" AND DET_CODCLI = "00076574";
    DOCUMENTO: 000000220595
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076574
       ESTADO: AM
         ITEM: 01792
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 11;
  FRecordDifalFCP.fltDifDes := 23.94;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 217.62;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(45.9)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(217.62)
      .TotalDoItem(171.72)
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
            CompararValores(ReturnValue.ValorBaseDestino{217,62}, objFloatUtils.fStrToFloat('217,62')) And
            CompararValores(ReturnValue.ValorIcmsDestino{23,9382}, objFloatUtils.fStrToFloat('23,9382')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{23,9382}, objFloatUtils.fStrToFloat('23,94')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{217,62}, objFloatUtils.fStrToFloat('217,62')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220600" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "33970" AND DET_CODCLI = "00076760";
    DOCUMENTO: 000000220600
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076760
       ESTADO: CE
         ITEM: 33970
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 36.4;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 260.03;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(260.03)
      .TotalDoItem(260.03)
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
            CompararValores(ReturnValue.ValorBaseDestino{260,03}, objFloatUtils.fStrToFloat('260,03')) And
            CompararValores(ReturnValue.ValorIcmsDestino{36,4042}, objFloatUtils.fStrToFloat('36,4042')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{36,4042}, objFloatUtils.fStrToFloat('36,4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{260,03}, objFloatUtils.fStrToFloat('260,03')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220600" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31747" AND DET_CODCLI = "00076760";
    DOCUMENTO: 000000220600
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076760
       ESTADO: CE
         ITEM: 31747
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 13.98;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 99.88;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(13.03)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(99.88)
      .TotalDoItem(86.85)
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
            CompararValores(ReturnValue.ValorBaseDestino{99,88}, objFloatUtils.fStrToFloat('99,88')) And
            CompararValores(ReturnValue.ValorIcmsDestino{13,9832}, objFloatUtils.fStrToFloat('13,9832')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{13,9832}, objFloatUtils.fStrToFloat('13,98')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{99,88}, objFloatUtils.fStrToFloat('99,88')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220605" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35073" AND DET_CODCLI = "00076716";
    DOCUMENTO: 000000220605
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076716
       ESTADO: RJ
         ITEM: 35073
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 41.43;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 690.51;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(156.48)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(690.51)
      .TotalDoItem(534.03)
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
            CompararValores(ReturnValue.ValorBaseDestino{690,51}, objFloatUtils.fStrToFloat('690,51')) And
            CompararValores(ReturnValue.ValorIcmsDestino{41,4306}, objFloatUtils.fStrToFloat('41,4306')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{41,4306}, objFloatUtils.fStrToFloat('41,43')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{690,51}, objFloatUtils.fStrToFloat('690,51')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220612" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "25374" AND DET_CODCLI = "00076768";
    DOCUMENTO: 000000220612
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076768
       ESTADO: PR
         ITEM: 25374
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 4.75;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 33.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(11.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(33.9)
      .TotalDoItem(22)
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
            CompararValores(ReturnValue.ValorBaseDestino{33,9}, objFloatUtils.fStrToFloat('33,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{4,746}, objFloatUtils.fStrToFloat('4,746')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{4,746}, objFloatUtils.fStrToFloat('4,75')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{33,9}, objFloatUtils.fStrToFloat('33,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220614" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "21615" AND DET_CODCLI = "00076835";
    DOCUMENTO: 000000220614
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076835
       ESTADO: GO
         ITEM: 21615
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 86.97;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 669;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(669)
      .TotalDoItem(669)
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
            CompararValores(ReturnValue.ValorBaseDestino{669}, objFloatUtils.fStrToFloat('669')) And
            CompararValores(ReturnValue.ValorIcmsDestino{86,97}, objFloatUtils.fStrToFloat('86,97')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{86,97}, objFloatUtils.fStrToFloat('86,97')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{669}, objFloatUtils.fStrToFloat('669')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220615" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29238" AND DET_CODCLI = "00076818";
    DOCUMENTO: 000000220615
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076818
       ESTADO: RJ
         ITEM: 29238
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 2.55;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 42.53;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(42.53)
      .TotalDoItem(42.53)
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
            CompararValores(ReturnValue.ValorBaseDestino{42,53}, objFloatUtils.fStrToFloat('42,53')) And
            CompararValores(ReturnValue.ValorIcmsDestino{2,5518}, objFloatUtils.fStrToFloat('2,5518')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{2,5518}, objFloatUtils.fStrToFloat('2,55')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{42,53}, objFloatUtils.fStrToFloat('42,53')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220615" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05832" AND DET_CODCLI = "00076818";
    DOCUMENTO: 000000220615
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076818
       ESTADO: RJ
         ITEM: 05832
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 3.32;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 55.37;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(55.37)
      .TotalDoItem(55.37)
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
            CompararValores(ReturnValue.ValorBaseDestino{55,37}, objFloatUtils.fStrToFloat('55,37')) And
            CompararValores(ReturnValue.ValorIcmsDestino{3,3222}, objFloatUtils.fStrToFloat('3,3222')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{3,3222}, objFloatUtils.fStrToFloat('3,32')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{55,37}, objFloatUtils.fStrToFloat('55,37')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220615" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14652" AND DET_CODCLI = "00076818";
    DOCUMENTO: 000000220615
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076818
       ESTADO: RJ
         ITEM: 14652
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 5.17;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 36.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(36.9)
      .TotalDoItem(36.9)
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
            CompararValores(ReturnValue.ValorBaseDestino{36,9}, objFloatUtils.fStrToFloat('36,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{5,166}, objFloatUtils.fStrToFloat('5,166')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{5,166}, objFloatUtils.fStrToFloat('5,17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{36,9}, objFloatUtils.fStrToFloat('36,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220617" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "27528" AND DET_CODCLI = "00076828";
    DOCUMENTO: 000000220617
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076828
       ESTADO: RJ
         ITEM: 27528
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 11.5;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 191.7;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(18.9)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(191.7)
      .TotalDoItem(172.8)
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
            CompararValores(ReturnValue.ValorBaseDestino{191,7}, objFloatUtils.fStrToFloat('191,7')) And
            CompararValores(ReturnValue.ValorIcmsDestino{11,502}, objFloatUtils.fStrToFloat('11,502')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{11,502}, objFloatUtils.fStrToFloat('11,5')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{191,7}, objFloatUtils.fStrToFloat('191,7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220618" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06189" AND DET_CODCLI = "00076829";
    DOCUMENTO: 000000220618
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076829
       ESTADO: GO
         ITEM: 06189
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 25.99;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
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
            CompararValores(ReturnValue.ValorBaseDestino{199,9}, objFloatUtils.fStrToFloat('199,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{25,987}, objFloatUtils.fStrToFloat('25,987')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{25,987}, objFloatUtils.fStrToFloat('25,99')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{199,9}, objFloatUtils.fStrToFloat('199,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220620" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31983" AND DET_CODCLI = "00076846";
    DOCUMENTO: 000000220620
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076846
       ESTADO: ES
         ITEM: 31983
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 81.91;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 819.05;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(122.9)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(819.05)
      .TotalDoItem(696.15)
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
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{819,05}, objFloatUtils.fStrToFloat('819,05')) And
            CompararValores(ReturnValue.ValorIcmsDestino{81,905}, objFloatUtils.fStrToFloat('81,905')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{81,905}, objFloatUtils.fStrToFloat('81,91')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{819,05}, objFloatUtils.fStrToFloat('819,05')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220621" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06190" AND DET_CODCLI = "00076833";
    DOCUMENTO: 000000220621
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076833
       ESTADO: RS
         ITEM: 06190
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
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


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220622" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "05832" AND DET_CODCLI = "00076825";
    DOCUMENTO: 000000220622
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076825
       ESTADO: MG
         ITEM: 05832
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 10.19;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 169.8;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(169.8)
      .TotalDoItem(169.8)
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
            CompararValores(ReturnValue.ValorBaseDestino{169,8}, objFloatUtils.fStrToFloat('169,8')) And
            CompararValores(ReturnValue.ValorIcmsDestino{10,188}, objFloatUtils.fStrToFloat('10,188')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{10,188}, objFloatUtils.fStrToFloat('10,19')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{169,8}, objFloatUtils.fStrToFloat('169,8')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220623" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06189" AND DET_CODCLI = "00072551";
    DOCUMENTO: 000000220623
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00072551
       ESTADO: GO
         ITEM: 06189
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 25.87;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 199;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(199)
      .TotalDoItem(199)
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
            CompararValores(ReturnValue.ValorBaseDestino{199}, objFloatUtils.fStrToFloat('199')) And
            CompararValores(ReturnValue.ValorIcmsDestino{25,87}, objFloatUtils.fStrToFloat('25,87')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{25,87}, objFloatUtils.fStrToFloat('25,87')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{199}, objFloatUtils.fStrToFloat('199')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220624" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26024" AND DET_CODCLI = "00076845";
    DOCUMENTO: 000000220624
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076845
       ESTADO: MG
         ITEM: 26024
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 15.79;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 112.8;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(22.9)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(112.8)
      .TotalDoItem(89.9)
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
            CompararValores(ReturnValue.ValorBaseDestino{112,8}, objFloatUtils.fStrToFloat('112,8')) And
            CompararValores(ReturnValue.ValorIcmsDestino{15,792}, objFloatUtils.fStrToFloat('15,792')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{15,792}, objFloatUtils.fStrToFloat('15,79')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{112,8}, objFloatUtils.fStrToFloat('112,8')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220626" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "06190" AND DET_CODCLI = "00076816";
    DOCUMENTO: 000000220626
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076816
       ESTADO: MT
         ITEM: 06190
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 12.99;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
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
            CompararValores(ReturnValue.ValorBaseDestino{99,9}, objFloatUtils.fStrToFloat('99,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{12,987}, objFloatUtils.fStrToFloat('12,987')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{12,987}, objFloatUtils.fStrToFloat('12,99')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{99,9}, objFloatUtils.fStrToFloat('99,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220638" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26334" AND DET_CODCLI = "00076844";
    DOCUMENTO: 000000220638
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076844
       ESTADO: MG
         ITEM: 26334
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 11.93;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 85.2;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(6.31)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(85.2)
      .TotalDoItem(78.89)
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
            CompararValores(ReturnValue.ValorBaseDestino{85,2}, objFloatUtils.fStrToFloat('85,2')) And
            CompararValores(ReturnValue.ValorIcmsDestino{11,928}, objFloatUtils.fStrToFloat('11,928')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{11,928}, objFloatUtils.fStrToFloat('11,93')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{85,2}, objFloatUtils.fStrToFloat('85,2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220638" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26335" AND DET_CODCLI = "00076844";
    DOCUMENTO: 000000220638
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076844
       ESTADO: MG
         ITEM: 26335
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 13.25;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 94.61;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(7.01)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(94.61)
      .TotalDoItem(87.6)
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
            CompararValores(ReturnValue.ValorBaseDestino{94,61}, objFloatUtils.fStrToFloat('94,61')) And
            CompararValores(ReturnValue.ValorIcmsDestino{13,2454}, objFloatUtils.fStrToFloat('13,2454')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{13,2454}, objFloatUtils.fStrToFloat('13,25')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{94,61}, objFloatUtils.fStrToFloat('94,61')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220639" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18965" AND DET_CODCLI = "00076812";
    DOCUMENTO: 000000220639
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076812
       ESTADO: RJ
         ITEM: 18965
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
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


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000024;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220643" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35786" AND DET_CODCLI = "00076836";
    DOCUMENTO: 000000220643
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076836
       ESTADO: MS
         ITEM: 35786
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 39.37;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 302.82;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(302.82)
      .TotalDoItem(302.82)
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
            CompararValores(ReturnValue.ValorBaseDestino{302,82}, objFloatUtils.fStrToFloat('302,82')) And
            CompararValores(ReturnValue.ValorIcmsDestino{39,3666}, objFloatUtils.fStrToFloat('39,3666')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{39,3666}, objFloatUtils.fStrToFloat('39,37')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{302,82}, objFloatUtils.fStrToFloat('302,82')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000025;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220643" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34942" AND DET_CODCLI = "00076836";
    DOCUMENTO: 000000220643
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076836
       ESTADO: MS
         ITEM: 34942
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 12.49;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 96.08;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(96.08)
      .TotalDoItem(96.08)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
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
            CompararValores(ReturnValue.ValorBaseDestino{96,08}, objFloatUtils.fStrToFloat('96,08')) And
            CompararValores(ReturnValue.ValorIcmsDestino{12,4904}, objFloatUtils.fStrToFloat('12,4904')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{12,4904}, objFloatUtils.fStrToFloat('12,49')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{96,08}, objFloatUtils.fStrToFloat('96,08')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000026;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220644" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "01792" AND DET_CODCLI = "00074509";
    DOCUMENTO: 000000220644
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074509
       ESTADO: SC
         ITEM: 01792
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 5;
  FRecordDifalFCP.fltDifDes := 10.23;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 204.62;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(32.9)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(204.62)
      .TotalDoItem(171.72)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
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
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{204,62}, objFloatUtils.fStrToFloat('204,62')) And
            CompararValores(ReturnValue.ValorIcmsDestino{10,231}, objFloatUtils.fStrToFloat('10,231')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{5}, objFloatUtils.fStrToFloat('5')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{10,231}, objFloatUtils.fStrToFloat('10,23')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{204,62}, objFloatUtils.fStrToFloat('204,62')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000027;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220648" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076817";
    DOCUMENTO: 000000220648
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076817
       ESTADO: PI
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 33.79;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
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
            CompararValores(ReturnValue.ValorBaseDestino{259,9}, objFloatUtils.fStrToFloat('259,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{33,787}, objFloatUtils.fStrToFloat('33,787')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{33,787}, objFloatUtils.fStrToFloat('33,79')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{259,9}, objFloatUtils.fStrToFloat('259,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000028;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220649" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076838";
    DOCUMENTO: 000000220649
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076838
       ESTADO: PE
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
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


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000029;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220652" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34522" AND DET_CODCLI = "00076822";
    DOCUMENTO: 000000220652
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076822
       ESTADO: MG
         ITEM: 34522
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
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


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000030;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220653" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35786" AND DET_CODCLI = "00076806";
    DOCUMENTO: 000000220653
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076806
       ESTADO: ES
         ITEM: 35786
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 38.87;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 299;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(299)
      .TotalDoItem(299)
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
            CompararValores(ReturnValue.ValorBaseDestino{299}, objFloatUtils.fStrToFloat('299')) And
            CompararValores(ReturnValue.ValorIcmsDestino{38,87}, objFloatUtils.fStrToFloat('38,87')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{38,87}, objFloatUtils.fStrToFloat('38,87')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{299}, objFloatUtils.fStrToFloat('299')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000031;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220655" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29516" AND DET_CODCLI = "00076841";
    DOCUMENTO: 000000220655
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076841
       ESTADO: SC
         ITEM: 29516
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 83.19;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 639.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(639.9)
      .TotalDoItem(639.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
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
            CompararValores(ReturnValue.ValorBaseDestino{639,9}, objFloatUtils.fStrToFloat('639,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{83,187}, objFloatUtils.fStrToFloat('83,187')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{83,187}, objFloatUtils.fStrToFloat('83,19')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{639,9}, objFloatUtils.fStrToFloat('639,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000032;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220659" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35786" AND DET_CODCLI = "00076839";
    DOCUMENTO: 000000220659
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076839
       ESTADO: PR
         ITEM: 35786
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
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


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000033;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220665" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35073" AND DET_CODCLI = "00076025";
    DOCUMENTO: 000000220665
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076025
       ESTADO: ES
         ITEM: 35073
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 59.9;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 599;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(599)
      .TotalDoItem(599)
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
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{599}, objFloatUtils.fStrToFloat('599')) And
            CompararValores(ReturnValue.ValorIcmsDestino{59,9}, objFloatUtils.fStrToFloat('59,9')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{59,9}, objFloatUtils.fStrToFloat('59,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{599}, objFloatUtils.fStrToFloat('599')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000034;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220673" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "30281" AND DET_CODCLI = "00076811";
    DOCUMENTO: 000000220673
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076811
       ESTADO: MG
         ITEM: 30281
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 3.17;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 52.8;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(13.9)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(52.8)
      .TotalDoItem(38.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(100)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(True)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(True)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('10')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{52,8}, objFloatUtils.fStrToFloat('52,8')) And
            CompararValores(ReturnValue.ValorIcmsDestino{3,17}, objFloatUtils.fStrToFloat('3,17')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{3,17}, objFloatUtils.fStrToFloat('3,17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{52,8}, objFloatUtils.fStrToFloat('52,8')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000035;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220674" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "21912" AND DET_CODCLI = "00076823";
    DOCUMENTO: 000000220674
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076823
       ESTADO: PR
         ITEM: 21912
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 53.79;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 384.23;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(384.23)
      .TotalDoItem(384.23)
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
            CompararValores(ReturnValue.ValorBaseDestino{384,23}, objFloatUtils.fStrToFloat('384,23')) And
            CompararValores(ReturnValue.ValorIcmsDestino{53,7922}, objFloatUtils.fStrToFloat('53,7922')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{53,7922}, objFloatUtils.fStrToFloat('53,79')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{384,23}, objFloatUtils.fStrToFloat('384,23')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000036;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220679" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "10111" AND DET_CODCLI = "00074716";
    DOCUMENTO: 000000220679
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00074716
       ESTADO: PR
         ITEM: 10111
 ITEM SERVIÇO: NÃO
         CFOP: 2202
CODIGO FISCAL: 020
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: OE}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 74.76;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 1245.88;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(12)
      .ValorIcmsBase(1245.88)
      .TotalDoItem(1699)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(73.33)
      .PercentualBaseDestino(73.33)
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
            CompararValores(ReturnValue.ValorBaseDestino{1245,8767}, objFloatUtils.fStrToFloat('1245,8767')) And
            CompararValores(ReturnValue.ValorIcmsDestino{74,76}, objFloatUtils.fStrToFloat('74,76')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{74,76}, objFloatUtils.fStrToFloat('74,76')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{1245,8767}, objFloatUtils.fStrToFloat('1245,88')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000037;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220681" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18601" AND DET_CODCLI = "00076581";
    DOCUMENTO: 000000220681
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076581
       ESTADO: PI
         ITEM: 18601
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 1.16;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 11.59;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(11.59)
      .TotalDoItem(11.59)
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
            CompararValores(ReturnValue.ValorBaseDestino{11,59}, objFloatUtils.fStrToFloat('11,59')) And
            CompararValores(ReturnValue.ValorIcmsDestino{1,159}, objFloatUtils.fStrToFloat('1,159')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{1,159}, objFloatUtils.fStrToFloat('1,16')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{11,59}, objFloatUtils.fStrToFloat('11,59')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000038;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220681" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35492" AND DET_CODCLI = "00076581";
    DOCUMENTO: 000000220681
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00076581
       ESTADO: PI
         ITEM: 35492
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 13;
  FRecordDifalFCP.fltDifDes := 32.28;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 248.31;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(248.31)
      .TotalDoItem(248.31)
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
            CompararValores(ReturnValue.ValorBaseDestino{248,31}, objFloatUtils.fStrToFloat('248,31')) And
            CompararValores(ReturnValue.ValorIcmsDestino{32,2803}, objFloatUtils.fStrToFloat('32,2803')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{13}, objFloatUtils.fStrToFloat('13')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{32,2803}, objFloatUtils.fStrToFloat('32,28')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{248,31}, objFloatUtils.fStrToFloat('248,31')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000039;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "34255" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 34255
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 35.57;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 254.05;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(5.05)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(254.05)
      .TotalDoItem(249)
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
            CompararValores(ReturnValue.ValorBaseDestino{254,05}, objFloatUtils.fStrToFloat('254,05')) And
            CompararValores(ReturnValue.ValorIcmsDestino{35,567}, objFloatUtils.fStrToFloat('35,567')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{35,567}, objFloatUtils.fStrToFloat('35,57')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{254,05}, objFloatUtils.fStrToFloat('254,05')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000040;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "28494" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 28494
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 21.29;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 152.04;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(3.04)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(152.04)
      .TotalDoItem(149)
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
            CompararValores(ReturnValue.ValorBaseDestino{152,04}, objFloatUtils.fStrToFloat('152,04')) And
            CompararValores(ReturnValue.ValorIcmsDestino{21,2856}, objFloatUtils.fStrToFloat('21,2856')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{21,2856}, objFloatUtils.fStrToFloat('21,29')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{152,04}, objFloatUtils.fStrToFloat('152,04')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000041;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35626" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 35626
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 21.39;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 152.75;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(3.05)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(152.75)
      .TotalDoItem(149.7)
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
            CompararValores(ReturnValue.ValorBaseDestino{152,75}, objFloatUtils.fStrToFloat('152,75')) And
            CompararValores(ReturnValue.ValorIcmsDestino{21,385}, objFloatUtils.fStrToFloat('21,385')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{21,385}, objFloatUtils.fStrToFloat('21,39')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{152,75}, objFloatUtils.fStrToFloat('152,75')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000042;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "32897" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 32897
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 19.99;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 142.75;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(2.85)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(142.75)
      .TotalDoItem(139.9)
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
            CompararValores(ReturnValue.ValorBaseDestino{142,75}, objFloatUtils.fStrToFloat('142,75')) And
            CompararValores(ReturnValue.ValorIcmsDestino{19,985}, objFloatUtils.fStrToFloat('19,985')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{19,985}, objFloatUtils.fStrToFloat('19,99')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{142,75}, objFloatUtils.fStrToFloat('142,75')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000043;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35627" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 35627
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 35.64;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 254.58;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(5.08)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(254.58)
      .TotalDoItem(249.5)
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
            CompararValores(ReturnValue.ValorBaseDestino{254,58}, objFloatUtils.fStrToFloat('254,58')) And
            CompararValores(ReturnValue.ValorIcmsDestino{35,6412}, objFloatUtils.fStrToFloat('35,6412')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{35,6412}, objFloatUtils.fStrToFloat('35,64')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{254,58}, objFloatUtils.fStrToFloat('254,58')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000044;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20939" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 20939
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 9.93;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 70.92;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(1.42)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(70.92)
      .TotalDoItem(69.5)
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
            CompararValores(ReturnValue.ValorBaseDestino{70,92}, objFloatUtils.fStrToFloat('70,92')) And
            CompararValores(ReturnValue.ValorIcmsDestino{9,9288}, objFloatUtils.fStrToFloat('9,9288')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{9,9288}, objFloatUtils.fStrToFloat('9,93')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{70,92}, objFloatUtils.fStrToFloat('70,92')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000045;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "20941" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 20941
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 15.36;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 109.69;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(2.19)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(109.69)
      .TotalDoItem(107.5)
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
            CompararValores(ReturnValue.ValorBaseDestino{109,69}, objFloatUtils.fStrToFloat('109,69')) And
            CompararValores(ReturnValue.ValorIcmsDestino{15,3566}, objFloatUtils.fStrToFloat('15,3566')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{15,3566}, objFloatUtils.fStrToFloat('15,36')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{109,69}, objFloatUtils.fStrToFloat('109,69')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000046;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "35580" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 35580
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 14.28;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 101.99;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(2.04)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(101.99)
      .TotalDoItem(99.95)
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
            CompararValores(ReturnValue.ValorBaseDestino{101,99}, objFloatUtils.fStrToFloat('101,99')) And
            CompararValores(ReturnValue.ValorIcmsDestino{14,2786}, objFloatUtils.fStrToFloat('14,2786')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{14,2786}, objFloatUtils.fStrToFloat('14,28')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{101,99}, objFloatUtils.fStrToFloat('101,99')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000047;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "29984" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 29984
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 7.14;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 51.02;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(1.02)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(51.02)
      .TotalDoItem(50)
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
            CompararValores(ReturnValue.ValorBaseDestino{51,02}, objFloatUtils.fStrToFloat('51,02')) And
            CompararValores(ReturnValue.ValorIcmsDestino{7,1428}, objFloatUtils.fStrToFloat('7,1428')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{7,1428}, objFloatUtils.fStrToFloat('7,14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{51,02}, objFloatUtils.fStrToFloat('51,02')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000048;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "31338" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 31338
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 17.9;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 127.83;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(9.47)
      .ValorFreteDoItem(2.36)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(127.83)
      .TotalDoItem(116)
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
            CompararValores(ReturnValue.ValorBaseDestino{127,83}, objFloatUtils.fStrToFloat('127,83')) And
            CompararValores(ReturnValue.ValorIcmsDestino{17,8962}, objFloatUtils.fStrToFloat('17,8962')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{17,8962}, objFloatUtils.fStrToFloat('17,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{127,83}, objFloatUtils.fStrToFloat('127,83')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000049;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26883" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 26883
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 13.64;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 97.42;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(7.22)
      .ValorFreteDoItem(1.8)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(97.42)
      .TotalDoItem(88.4)
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
            CompararValores(ReturnValue.ValorBaseDestino{97,42}, objFloatUtils.fStrToFloat('97,42')) And
            CompararValores(ReturnValue.ValorIcmsDestino{13,6388}, objFloatUtils.fStrToFloat('13,6388')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{13,6388}, objFloatUtils.fStrToFloat('13,64')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{97,42}, objFloatUtils.fStrToFloat('97,42')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000050;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26334" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 26334
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 7.7;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 54.99;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(4.07)
      .ValorFreteDoItem(1.02)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(54.99)
      .TotalDoItem(49.9)
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
            CompararValores(ReturnValue.ValorBaseDestino{54,99}, objFloatUtils.fStrToFloat('54,99')) And
            CompararValores(ReturnValue.ValorIcmsDestino{7,6986}, objFloatUtils.fStrToFloat('7,6986')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{7,6986}, objFloatUtils.fStrToFloat('7,7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{54,99}, objFloatUtils.fStrToFloat('54,99')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestCSFERRAMENTAS.Difal_CSFERRAMENTAS_000051;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220699" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "19599" AND DET_CODCLI = "00044486";
    DOCUMENTO: 000000220699
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00044486
       ESTADO: PR
         ITEM: 19599
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 100
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 14;
  FRecordDifalFCP.fltDifDes := 7.71;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 4;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 55.1;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(4.08)
      .ValorFreteDoItem(1.02)
      .AliquotaInterestadualCalc(4)
      .ValorIcmsBase(55.1)
      .TotalDoItem(50)
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
            CompararValores(ReturnValue.ValorBaseDestino{55,1}, objFloatUtils.fStrToFloat('55,1')) And
            CompararValores(ReturnValue.ValorIcmsDestino{7,714}, objFloatUtils.fStrToFloat('7,714')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{14}, objFloatUtils.fStrToFloat('14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{7,714}, objFloatUtils.fStrToFloat('7,71')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{4}, objFloatUtils.fStrToFloat('4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{55,1}, objFloatUtils.fStrToFloat('55,1')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;




initialization
  RegisterTest(TestCSFERRAMENTAS.Suite);
end.

