unit TestFaturamento.Impostos.Calculos.Difal.GLOBALCOLOR_Lj001_20191210;

{--------------------------------------------------------------------------
                    RESUMO DIFAL                 
--------------------------------------------------------------------------
Empresa            : 001 - GLOBALCOLOR
Período Selecionado: 10/12/2019 até 10/12/2019
Data do Processo   : 11/12/2019 
Hora Inicio        : 09:08:05
Hora Fim           : 09:15:17
Tempo Total        : 00:07:12
                                           
Total Registros    : 412
Total Processados  : 412
Total de Acertos   : 7
Total de Erros     : 0
Total Ignorados    : 405
Total Duplicados   : 0
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
TestGLOBALCOLOR = class(TTestCase)
strict private
private


  FRecordDifalFCP: TRecDifalFCP;


published

Procedure Difal_GLOBALCOLOR_000001;
Procedure Difal_GLOBALCOLOR_000002;
Procedure Difal_GLOBALCOLOR_000003;
Procedure Difal_GLOBALCOLOR_000004;
Procedure Difal_GLOBALCOLOR_000005;
Procedure Difal_GLOBALCOLOR_000006;
Procedure Difal_GLOBALCOLOR_000007;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestGLOBALCOLOR.SetUp;
begin
end;

procedure TestGLOBALCOLOR.TearDown;
begin
end;

Procedure TestGLOBALCOLOR.Difal_GLOBALCOLOR_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18508" AND DET_CODCLI = "00000796";
    DOCUMENTO: 000000035955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000796
       ESTADO: BA
         ITEM: 18508
 ITEM SERVIÇO: NÃO
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 11;
  FRecordDifalFCP.fltDifDes := 60.88;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 553.43;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(453.82)
      .TotalDoItem(453.82)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(121.95)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(True)
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
            CompararValores(ReturnValue.ValorBaseDestino{553,43}, objFloatUtils.fStrToFloat('553,43')) And
            CompararValores(ReturnValue.ValorIcmsDestino{60,8773}, objFloatUtils.fStrToFloat('67,85')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{60,8773}, objFloatUtils.fStrToFloat('67,85')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{553,43}, objFloatUtils.fStrToFloat('553,43')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestGLOBALCOLOR.Difal_GLOBALCOLOR_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16050" AND DET_CODCLI = "00000796";
    DOCUMENTO: 000000035955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000796
       ESTADO: BA
         ITEM: 16050
 ITEM SERVIÇO: NÃO
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 11;
  FRecordDifalFCP.fltDifDes := 43.28;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 393.46;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(322.64)
      .TotalDoItem(322.64)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(121.95)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(True)
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
            CompararValores(ReturnValue.ValorBaseDestino{393,46}, objFloatUtils.fStrToFloat('393,46')) And
            CompararValores(ReturnValue.ValorIcmsDestino{43,2806}, objFloatUtils.fStrToFloat('48,24')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{43,2806}, objFloatUtils.fStrToFloat('48,24')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{393,46}, objFloatUtils.fStrToFloat('393,46')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestGLOBALCOLOR.Difal_GLOBALCOLOR_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "16950" AND DET_CODCLI = "00000796";
    DOCUMENTO: 000000035955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000796
       ESTADO: BA
         ITEM: 16950
 ITEM SERVIÇO: NÃO
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 11;
  FRecordDifalFCP.fltDifDes := 115.6;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 1050.89;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(861.74)
      .TotalDoItem(861.74)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(121.95)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(True)
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
            CompararValores(ReturnValue.ValorBaseDestino{1050,89}, objFloatUtils.fStrToFloat('1050,89')) And
            CompararValores(ReturnValue.ValorIcmsDestino{115,5979}, objFloatUtils.fStrToFloat('128,84')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{115,5979}, objFloatUtils.fStrToFloat('128,84')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{1050,89}, objFloatUtils.fStrToFloat('1050,89')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestGLOBALCOLOR.Difal_GLOBALCOLOR_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035955" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "17336" AND DET_CODCLI = "00000796";
    DOCUMENTO: 000000035955
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00000796
       ESTADO: BA
         ITEM: 17336
 ITEM SERVIÇO: NÃO
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 11;
  FRecordDifalFCP.fltDifDes := 112.73;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 18;
  FRecordDifalFCP.fltBcuFde := 1024.84;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(0)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(840.38)
      .TotalDoItem(840.38)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(121.95)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(18)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(True)
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
            CompararValores(ReturnValue.ValorBaseDestino{1024,84}, objFloatUtils.fStrToFloat('1024,84')) And
            CompararValores(ReturnValue.ValorIcmsDestino{112,7324}, objFloatUtils.fStrToFloat('125,64')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{11}, objFloatUtils.fStrToFloat('11')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{112,7324}, objFloatUtils.fStrToFloat('125,64')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{18}, objFloatUtils.fStrToFloat('18')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{1024,84}, objFloatUtils.fStrToFloat('1024,84')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestGLOBALCOLOR.Difal_GLOBALCOLOR_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035956" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "14594" AND DET_CODCLI = "00003242";
    DOCUMENTO: 000000035956
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003242
       ESTADO: GO
         ITEM: 14594
 ITEM SERVIÇO: NÃO
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 47.77;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 477.71;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(18.88)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(396.49)
      .TotalDoItem(377.61)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(126.51)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(True)
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
            CompararValores(ReturnValue.ValorBaseDestino{477,71}, objFloatUtils.fStrToFloat('477,71')) And
            CompararValores(ReturnValue.ValorIcmsDestino{47,771}, objFloatUtils.fStrToFloat('53,46')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{47,771}, objFloatUtils.fStrToFloat('53,46')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{477,71}, objFloatUtils.fStrToFloat('477,71')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestGLOBALCOLOR.Difal_GLOBALCOLOR_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035956" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "12057" AND DET_CODCLI = "00003242";
    DOCUMENTO: 000000035956
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003242
       ESTADO: GO
         ITEM: 12057
 ITEM SERVIÇO: NÃO
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 15.04;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 150.37;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(11.35)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(124.81)
      .TotalDoItem(113.46)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(132.53)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(True)
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
            CompararValores(ReturnValue.ValorBaseDestino{150,37}, objFloatUtils.fStrToFloat('150,37')) And
            CompararValores(ReturnValue.ValorIcmsDestino{15,037}, objFloatUtils.fStrToFloat('16,82')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{15,037}, objFloatUtils.fStrToFloat('16,82')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{150,37}, objFloatUtils.fStrToFloat('150,37')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;


Procedure TestGLOBALCOLOR.Difal_GLOBALCOLOR_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000035956" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "11661" AND DET_CODCLI = "00003242";
    DOCUMENTO: 000000035956
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00003242
       ESTADO: GO
         ITEM: 11661
 ITEM SERVIÇO: NÃO
         CFOP: 6107
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoDifal;
  AParametros: IParametrosCalculoDifal;
Begin
  FRecordDifalFCP.fltAlDifa := 10;
  FRecordDifalFCP.fltDifDes := 247.85;
  FRecordDifalFCP.fltDifOri := 0;
  FRecordDifalFCP.fltAlqIne := 7;
  FRecordDifalFCP.fltAlqUfd := 17;
  FRecordDifalFCP.fltBcuFde := 2478.48;
  FRecordDifalFCP.fltPerPar := 100;

  AParametros :=
    TParametrosCalculoDifal.New()
      .ValorIpiDoItem(97.96)
      .ValorFreteDoItem(0)
      .AliquotaInterestadualCalc(7)
      .ValorIcmsBase(2057.08)
      .TotalDoItem(1959.12)
      .DescontoEspecialDoItem(0)
      .DespesaAcessoriaDoItem(0)
      .PercentualBaseOrigem(100)
      .PercentualBaseDestino(100)
      .PercentualBaseDifalOrigem(100)
      .PercentualBaseDifalDestino(126.51)
      .CalculaAliquotaInterestadual(7)
      .CalculaAliquotaEfetivaOrigem(0)
      .AliquotaInternaEstadoDestino(17)
      .ProdutoSt(False)
      .SimplesNacional(False)
      .AbreviacaoIcmsProduto(True)
      .AbreviacaoIcmsProdutoUfEmpresa(True)
      .HabilitarPercentualBase(True)
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
            CompararValores(ReturnValue.ValorBaseDestino{2478,48}, objFloatUtils.fStrToFloat('2478,48')) And
            CompararValores(ReturnValue.ValorIcmsDestino{247,848}, objFloatUtils.fStrToFloat('277,34')) And
            CompararValores(ReturnValue.AliquotaInterestadualCalc{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorIcmsOrigem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlDifa{10}, objFloatUtils.fStrToFloat('10')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifDes{247,848}, objFloatUtils.fStrToFloat('277,34')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltDifOri{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqIne{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltAlqUfd{17}, objFloatUtils.fStrToFloat('17')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBcuFde{2478,48}, objFloatUtils.fStrToFloat('2478,48')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerPar{100}, objFloatUtils.fStrToFloat('100')));
end;




initialization
  RegisterTest(TestGLOBALCOLOR.Suite);
end.

