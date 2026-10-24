unit TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191209;

{--------------------------------------------------------------------------
                    RESUMO FCP                 
--------------------------------------------------------------------------
Empresa            : 002 - DUPLOR MAQUINAS
Período Selecionado: 09/12/2019 até 09/12/2019
Data do Processo   : 10/12/2019 
Hora Inicio        : 16:57:22
Hora Fim           : 17:21:38
Tempo Total        : 00:24:15
                                           
Total Registros    : 1870
Total Processados  : 1870
Total de Acertos   : 4
Total de Erros     : 0
Total Ignorados    : 1278
Total Duplicados   : 588
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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000292538" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "70436" AND DET_CODCLI = "00399533";
    DOCUMENTO: 000000292538
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00399533
       ESTADO: SP
         ITEM: 70436
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000214933" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "52792" AND DET_CODCLI = "00000002";
    DOCUMENTO: 000000214933
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00000002
       ESTADO: 
         ITEM: 52792
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000292624" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00374618";
    DOCUMENTO: 000000292624
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00374618
       ESTADO: SP
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
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


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000293144" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "37639" AND DET_CODCLI = "00375041";
    DOCUMENTO: 000000293144
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00375041
       ESTADO: RJ
         ITEM: 37639
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 09/12/2019
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
      .BaseDeCalculoDoIcmsDoItem(23.84)
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
            CompararValores(ReturnValue.BaseFCP{23,84}, objFloatUtils.fStrToFloat('23,84')) And
            CompararValores(ReturnValue.ValorFCP{0,48}, objFloatUtils.fStrToFloat('0,48')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0,48},objFloatUtils.fStrToFloat('0,48')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{23,84},objFloatUtils.fStrToFloat('23,84')));
end;




initialization
  RegisterTest(TestDUPLORMAQUINAS.Suite);
end.

