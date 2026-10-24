unit TestFaturamento.Impostos.Calculos.Difal.MAGIC_CAR_OURIN_Lj002_20190910;

{--------------------------------------------------------------------------
                    RESUMO DIFAL                 
--------------------------------------------------------------------------
Empresa            : 002 - MAGIC CAR OURINHOS 
Período Selecionado: 10/09/2019 até 10/09/2019
Data do Processo   : 12/12/2019 
Hora Inicio        : 16:14:58
Hora Fim           : 16:25:12
Tempo Total        : 00:10:14
                                           
Total Registros    : 506
Total Processados  : 506
Total de Acertos   : 15
Total de Erros     : 0
Total Ignorados    : 488
Total Duplicados   : 3
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
TestMAGICCAROURIN = class(TTestCase)
strict private
private


  FRecordDifalFCP: TRecDifalFCP;


published

Procedure Difal_MAGICCAROURIN_000001;
Procedure Difal_MAGICCAROURIN_000002;
Procedure Difal_MAGICCAROURIN_000003;
Procedure Difal_MAGICCAROURIN_000004;
Procedure Difal_MAGICCAROURIN_000005;
Procedure Difal_MAGICCAROURIN_000006;
Procedure Difal_MAGICCAROURIN_000007;
Procedure Difal_MAGICCAROURIN_000008;
Procedure Difal_MAGICCAROURIN_000009;
Procedure Difal_MAGICCAROURIN_000010;
Procedure Difal_MAGICCAROURIN_000011;
Procedure Difal_MAGICCAROURIN_000012;
Procedure Difal_MAGICCAROURIN_000013;
Procedure Difal_MAGICCAROURIN_000014;
Procedure Difal_MAGICCAROURIN_000015;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestMAGICCAROURIN.SetUp;
begin
end;

procedure TestMAGICCAROURIN.TearDown;
begin
end;

Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228141" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23326" AND DET_CODCLI = "20000225";
    DOCUMENTO: 000000228141
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000225
       ESTADO: PR
         ITEM: 23326
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 4.2;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 70;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(0)
      .ValorIcmsBase(0)
      .TotalDoItem(76.5)
      .DescontoEspecialDoItem(6.5)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(True)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('60')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{70}, objFloatUtils.fStrToFloat('70')) And
            CompararValores(ReturnValue.ValorIcmsDestino{4,2}, objFloatUtils.fStrToFloat('4,2')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{4,2}, objFloatUtils.fStrToFloat('4,2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{70}, objFloatUtils.fStrToFloat('70')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43887" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 43887
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 0.45;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 7.5;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(7.5)
      .TotalDoItem(7.5)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{7,5}, objFloatUtils.fStrToFloat('7,5')) And
            CompararValores(ReturnValue.ValorIcmsDestino{0,45}, objFloatUtils.fStrToFloat('0,45')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{0,45}, objFloatUtils.fStrToFloat('0,45')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{7,5}, objFloatUtils.fStrToFloat('7,5')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "23701" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 23701
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 1.56;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 26;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(26)
      .TotalDoItem(26)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{26}, objFloatUtils.fStrToFloat('26')) And
            CompararValores(ReturnValue.ValorIcmsDestino{1,56}, objFloatUtils.fStrToFloat('1,56')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{1,56}, objFloatUtils.fStrToFloat('1,56')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{26}, objFloatUtils.fStrToFloat('26')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43429" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 43429
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 4.44;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 74;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(74)
      .TotalDoItem(74)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{74}, objFloatUtils.fStrToFloat('74')) And
            CompararValores(ReturnValue.ValorIcmsDestino{4,44}, objFloatUtils.fStrToFloat('4,44')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{4,44}, objFloatUtils.fStrToFloat('4,44')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{74}, objFloatUtils.fStrToFloat('74')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "43927" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 43927
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 8.09;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 134.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(134.9)
      .TotalDoItem(134.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{134,9}, objFloatUtils.fStrToFloat('134,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{8,094}, objFloatUtils.fStrToFloat('8,094')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{8,094}, objFloatUtils.fStrToFloat('8,09')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{134,9}, objFloatUtils.fStrToFloat('134,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "45091" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 45091
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 2.4;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 40;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(40)
      .TotalDoItem(40)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{40}, objFloatUtils.fStrToFloat('40')) And
            CompararValores(ReturnValue.ValorIcmsDestino{2,4}, objFloatUtils.fStrToFloat('2,4')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{2,4}, objFloatUtils.fStrToFloat('2,4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{40}, objFloatUtils.fStrToFloat('40')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "45321" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 45321
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 8.99;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 149.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(0)
      .ValorIcmsBase(0)
      .TotalDoItem(149.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(True)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(True)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('60')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{149,9}, objFloatUtils.fStrToFloat('149,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{8,99}, objFloatUtils.fStrToFloat('8,99')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{8,99}, objFloatUtils.fStrToFloat('8,99')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{149,9}, objFloatUtils.fStrToFloat('149,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "44741" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 44741
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 1.68;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 28;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(28)
      .TotalDoItem(28)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{28}, objFloatUtils.fStrToFloat('28')) And
            CompararValores(ReturnValue.ValorIcmsDestino{1,68}, objFloatUtils.fStrToFloat('1,68')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{1,68}, objFloatUtils.fStrToFloat('1,68')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{28}, objFloatUtils.fStrToFloat('28')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "24075" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 24075
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 7.79;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 129.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(129.9)
      .TotalDoItem(129.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{129,9}, objFloatUtils.fStrToFloat('129,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{7,794}, objFloatUtils.fStrToFloat('7,794')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{7,794}, objFloatUtils.fStrToFloat('7,79')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{129,9}, objFloatUtils.fStrToFloat('129,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22778" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 22778
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 0.29;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 4.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(4.9)
      .TotalDoItem(4.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{4,9}, objFloatUtils.fStrToFloat('4,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{0,294}, objFloatUtils.fStrToFloat('0,294')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{0,294}, objFloatUtils.fStrToFloat('0,29')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{4,9}, objFloatUtils.fStrToFloat('4,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22742" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 22742
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 0.92;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 15.4;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(15.4)
      .TotalDoItem(15.4)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{15,4}, objFloatUtils.fStrToFloat('15,4')) And
            CompararValores(ReturnValue.ValorIcmsDestino{0,924}, objFloatUtils.fStrToFloat('0,924')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{0,924}, objFloatUtils.fStrToFloat('0,92')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{15,4}, objFloatUtils.fStrToFloat('15,4')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22735" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 22735
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 2.39;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 39.8;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(39.8)
      .TotalDoItem(39.8)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{39,8}, objFloatUtils.fStrToFloat('39,8')) And
            CompararValores(ReturnValue.ValorIcmsDestino{2,388}, objFloatUtils.fStrToFloat('2,388')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{2,388}, objFloatUtils.fStrToFloat('2,39')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{39,8}, objFloatUtils.fStrToFloat('39,8')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "44689" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 44689
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 0.6;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 9.95;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(9.95)
      .TotalDoItem(9.95)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{9,95}, objFloatUtils.fStrToFloat('9,95')) And
            CompararValores(ReturnValue.ValorIcmsDestino{0,597}, objFloatUtils.fStrToFloat('0,597')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{0,597}, objFloatUtils.fStrToFloat('0,6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{9,95}, objFloatUtils.fStrToFloat('9,95')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "22558" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 22558
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 0.01;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 0.1;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(0)
      .ValorIcmsBase(0)
      .TotalDoItem(0.1)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{0,1}, objFloatUtils.fStrToFloat('0,1')) And
            CompararValores(ReturnValue.ValorIcmsDestino{0,006}, objFloatUtils.fStrToFloat('0,006')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{0,006}, objFloatUtils.fStrToFloat('0,01')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{0,1}, objFloatUtils.fStrToFloat('0,1')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestMAGICCAROURIN.Difal_MAGICCAROURIN_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000228146" AND DET_ESPDOC = "FF" AND DET_CODEMP = "002" AND DET_CODITE = "46932" AND DET_CODCLI = "20000242";
    DOCUMENTO: 000000228146
      ESPECIE: FF
      EMPRESA: 002
      CLIENTE: 20000242
       ESTADO: PR
         ITEM: 46932
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 6;
  FRecordDifalFCP.fltDifDes := 1.19;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 12;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 19.9;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(3.07)
      .ValorIcmsBase(19.9)
      .TotalDoItem(19.9)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(0)
      .PercentualBaseDifalDestino(0)
      .CalculaAliquotaInterestadual(12)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(True)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(False)
      .SituacaoReducaoBaseCalculo(False)
      .CalculaBaseReduzidaAliquotaEfetiva(False)
      .CalculaDiferencialAliquotaProdutosSt(True)
      .CalculaTipoDeAbreviacaoFiscal(False)
      .PercentualProvisorioPartilha(100)
      .CodigoSituacaoTributaria('00')
      .RecordDifalFCP(FRecordDifalFCP)
      .ProdutoDeOrigemEstrangeira(False)
      .ConsiderarAliquotaEfetivaProdutosImportados(False);

  ReturnValue := TCalculoImpostosDifal.New.CalcularValorDifal(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.ValorBaseDestino{19,9}, objFloatUtils.fStrToFloat('19,9')) And
            CompararValores(ReturnValue.ValorIcmsDestino{1,194}, objFloatUtils.fStrToFloat('1,194')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{6}, objFloatUtils.fStrToFloat('6')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{1,194}, objFloatUtils.fStrToFloat('1,19')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{12}, objFloatUtils.fStrToFloat('12')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{19,9}, objFloatUtils.fStrToFloat('19,9')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;




initialization
  RegisterTest(TestMAGICCAROURIN.Suite);
end.

