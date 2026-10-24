unit TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191220;

{--------------------------------------------------------------------------
                    RESUMO FCP                 
--------------------------------------------------------------------------
Empresa            : 002 - DUPLOR MAQUINAS
Período Selecionado: 20/12/2019 até 20/12/2019
Data do Processo   : 30/12/2019 
Hora Inicio        : 08:56:29
Hora Fim           : 09:06:48
Tempo Total        : 00:10:19
                                           
Total Registros    : 1089
Total Processados  : 1089
Total de Acertos   : 6
Total de Erros     : 0
Total Ignorados    : 174
Total Duplicados   : 367
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.Fcp,
Faturamento.Impostos.Tipos.Fcp,
Faturamento.Impostos.Interfaces.Fcp;

type
TestDUPLORMAQUINAS = class(TTestCase)
strict private
private


  FRecordDifalFCP: TRecDifalFCP;


published

Procedure FCP_DUPLORMAQUINAS_000001;
Procedure FCP_DUPLORMAQUINAS_000002;
Procedure FCP_DUPLORMAQUINAS_000003;
Procedure FCP_DUPLORMAQUINAS_000004;
Procedure FCP_DUPLORMAQUINAS_000005;
Procedure FCP_DUPLORMAQUINAS_000006;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestDUPLORMAQUINAS.SetUp;
begin
end;

procedure TestDUPLORMAQUINAS.TearDown;
begin
end;

Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000301704" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69638" AND DET_CODCLI = "00418184";
    DOCUMENTO: 000000301704
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00418184
       ESTADO: SP
         ITEM: 69638
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(True)
      .BaseDeCalculoDoIcmsDoItem(0)
      .AliquotaFCPAbrevicaoIcms(0)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('SP')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(True)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{0},objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000214997" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "52610" AND DET_CODCLI = "00000002";
    DOCUMENTO: 000000214997
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00000002
       ESTADO: 
         ITEM: 52610
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(0)
      .AliquotaFCPAbrevicaoIcms(0)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(False)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{0},objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302046" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58685" AND DET_CODCLI = "00380029";
    DOCUMENTO: 000000302046
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00380029
       ESTADO: RJ
         ITEM: 58685
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(34.9)
      .AliquotaFCPAbrevicaoIcms(2)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('RJ')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(False)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{34,9}, objFloatUtils.fStrToFloat('34,9')) And
            CompararValores(ReturnValue.ValorFCP{0,7}, objFloatUtils.fStrToFloat('0,7')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0,7},objFloatUtils.fStrToFloat('0,7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{34,9},objFloatUtils.fStrToFloat('34,9')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302092" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "51014" AND DET_CODCLI = "00079016";
    DOCUMENTO: 000000302092
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00079016
       ESTADO: SP
         ITEM: 51014
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: DV}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(True)
      .BaseDeCalculoDoIcmsDoItem(0)
      .AliquotaFCPAbrevicaoIcms(0)
      .DocumentoDeDevolucao(True)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('SP')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(True)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{0},objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302257" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "44406" AND DET_CODCLI = "00002552";
    DOCUMENTO: 000000302257
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00002552
       ESTADO: SP
         ITEM: 44406
 ITEM SERVIÇO: NÃO
         CFOP: 5927
CODIGO FISCAL: 041
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: UC}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(0)
      .AliquotaFCPAbrevicaoIcms(0)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('SP')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(False)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{0},objFloatUtils.fStrToFloat('0')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000302265" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69917" AND DET_CODCLI = "00407422";
    DOCUMENTO: 000000302265
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00407422
       ESTADO: RJ
         ITEM: 69917
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 20/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(334.9)
      .AliquotaFCPAbrevicaoIcms(2)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('RJ')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(False)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.BaseFCP{334,9}, objFloatUtils.fStrToFloat('334,9')) And
            CompararValores(ReturnValue.ValorFCP{6,7}, objFloatUtils.fStrToFloat('6,7')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{6,7},objFloatUtils.fStrToFloat('6,7')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{334,9},objFloatUtils.fStrToFloat('334,9')));
end;




initialization
  RegisterTest(TestDUPLORMAQUINAS.Suite);
end.

