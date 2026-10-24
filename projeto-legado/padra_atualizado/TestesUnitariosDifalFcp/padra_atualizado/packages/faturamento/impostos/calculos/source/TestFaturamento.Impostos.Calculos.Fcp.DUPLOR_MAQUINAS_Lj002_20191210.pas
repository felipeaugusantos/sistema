unit TestFaturamento.Impostos.Calculos.Fcp.DUPLOR_MAQUINAS_Lj002_20191210;

{--------------------------------------------------------------------------
                    RESUMO FCP                 
--------------------------------------------------------------------------
Empresa            : 002 - DUPLOR MAQUINAS
Período Selecionado: 10/12/2019 até 10/12/2019
Data do Processo   : 11/12/2019 
Hora Inicio        : 10:03:45
Hora Fim           : 10:36:19
Tempo Total        : 00:32:34
                                           
Total Registros    : 1924
Total Processados  : 1924
Total de Acertos   : 14
Total de Erros     : 0
Total Ignorados    : 1371
Total Duplicados   : 539
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
Procedure FCP_DUPLORMAQUINAS_000007;
Procedure FCP_DUPLORMAQUINAS_000008;
Procedure FCP_DUPLORMAQUINAS_000009;
Procedure FCP_DUPLORMAQUINAS_000010;
Procedure FCP_DUPLORMAQUINAS_000011;
Procedure FCP_DUPLORMAQUINAS_000012;
Procedure FCP_DUPLORMAQUINAS_000013;
Procedure FCP_DUPLORMAQUINAS_000014;


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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000293587" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "69625" AND DET_CODCLI = "00399418";
    DOCUMENTO: 000000293587
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00399418
       ESTADO: SP
         ITEM: 69625
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000214940" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "53870" AND DET_CODCLI = "00000002";
    DOCUMENTO: 000000214940
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00000002
       ESTADO: 
         ITEM: 53870
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000293899" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "56285" AND DET_CODCLI = "00064480";
    DOCUMENTO: 000000293899
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00064480
       ESTADO: SP
         ITEM: 56285
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000293960" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "33424" AND DET_CODCLI = "00399453";
    DOCUMENTO: 000000293960
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00399453
       ESTADO: RJ
         ITEM: 33424
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
      .BaseDeCalculoDoIcmsDoItem(141.11)
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
            CompararValores(ReturnValue.BaseFCP{141,11}, objFloatUtils.fStrToFloat('141,11')) And
            CompararValores(ReturnValue.ValorFCP{2,82}, objFloatUtils.fStrToFloat('2,82')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{2,82},objFloatUtils.fStrToFloat('2,82')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{141,11},objFloatUtils.fStrToFloat('141,11')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "38951" AND DET_CODCLI = "00352320";
    DOCUMENTO: 000000294182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00352320
       ESTADO: RJ
         ITEM: 38951
 ITEM SERVIÇO: NÃO
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(3.5)
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
            CompararValores(ReturnValue.BaseFCP{3,5}, objFloatUtils.fStrToFloat('3,5')) And
            CompararValores(ReturnValue.ValorFCP{0,07}, objFloatUtils.fStrToFloat('0,07')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0,07},objFloatUtils.fStrToFloat('0,07')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{3,5},objFloatUtils.fStrToFloat('3,5')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "43788" AND DET_CODCLI = "00352320";
    DOCUMENTO: 000000294182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00352320
       ESTADO: RJ
         ITEM: 43788
 ITEM SERVIÇO: NÃO
         CFOP: 6404
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(True)
      .BaseDeCalculoDoIcmsDoItem(7)
      .AliquotaFCPAbrevicaoIcms(2)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(7)
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
            CompararValores(ReturnValue.BaseFCP{7}, objFloatUtils.fStrToFloat('7')) And
            CompararValores(ReturnValue.ValorFCP{0,14}, objFloatUtils.fStrToFloat('0,14')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0,14},objFloatUtils.fStrToFloat('0,14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{7},objFloatUtils.fStrToFloat('7')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "55595" AND DET_CODCLI = "00352320";
    DOCUMENTO: 000000294182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00352320
       ESTADO: RJ
         ITEM: 55595
 ITEM SERVIÇO: NÃO
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(143)
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
            CompararValores(ReturnValue.BaseFCP{143}, objFloatUtils.fStrToFloat('143')) And
            CompararValores(ReturnValue.ValorFCP{2,86}, objFloatUtils.fStrToFloat('2,86')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{2,86},objFloatUtils.fStrToFloat('2,86')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{143},objFloatUtils.fStrToFloat('143')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294182" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "37623" AND DET_CODCLI = "00352320";
    DOCUMENTO: 000000294182
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00352320
       ESTADO: RJ
         ITEM: 37623
 ITEM SERVIÇO: NÃO
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(27.7)
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
            CompararValores(ReturnValue.BaseFCP{27,7}, objFloatUtils.fStrToFloat('27,7')) And
            CompararValores(ReturnValue.ValorFCP{0,55}, objFloatUtils.fStrToFloat('0,55')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0,55},objFloatUtils.fStrToFloat('0,55')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{27,7},objFloatUtils.fStrToFloat('27,7')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294338" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "40966" AND DET_CODCLI = "00263581";
    DOCUMENTO: 000000294338
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00263581
       ESTADO: RJ
         ITEM: 40966
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
      .BaseDeCalculoDoIcmsDoItem(167.9)
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
            CompararValores(ReturnValue.BaseFCP{167,9}, objFloatUtils.fStrToFloat('167,9')) And
            CompararValores(ReturnValue.ValorFCP{3,36}, objFloatUtils.fStrToFloat('3,36')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{3,36},objFloatUtils.fStrToFloat('3,36')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{167,9},objFloatUtils.fStrToFloat('167,9')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294483" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "58199" AND DET_CODCLI = "00402448";
    DOCUMENTO: 000000294483
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00402448
       ESTADO: RJ
         ITEM: 58199
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
      .BaseDeCalculoDoIcmsDoItem(100.47)
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
            CompararValores(ReturnValue.BaseFCP{100,47}, objFloatUtils.fStrToFloat('100,47')) And
            CompararValores(ReturnValue.ValorFCP{2,01}, objFloatUtils.fStrToFloat('2,01')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{2,01},objFloatUtils.fStrToFloat('2,01')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{100,47},objFloatUtils.fStrToFloat('100,47')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294483" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "27568" AND DET_CODCLI = "00402448";
    DOCUMENTO: 000000294483
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00402448
       ESTADO: RJ
         ITEM: 27568
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
      .BaseDeCalculoDoIcmsDoItem(7.2)
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
            CompararValores(ReturnValue.BaseFCP{7,2}, objFloatUtils.fStrToFloat('7,2')) And
            CompararValores(ReturnValue.ValorFCP{0,14}, objFloatUtils.fStrToFloat('0,14')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0,14},objFloatUtils.fStrToFloat('0,14')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{7,2},objFloatUtils.fStrToFloat('7,2')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294483" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "29355" AND DET_CODCLI = "00402448";
    DOCUMENTO: 000000294483
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00402448
       ESTADO: RJ
         ITEM: 29355
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
      .BaseDeCalculoDoIcmsDoItem(32.03)
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
            CompararValores(ReturnValue.BaseFCP{32,03}, objFloatUtils.fStrToFloat('32,03')) And
            CompararValores(ReturnValue.ValorFCP{0,64}, objFloatUtils.fStrToFloat('0,64')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0,64},objFloatUtils.fStrToFloat('0,64')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{32,03},objFloatUtils.fStrToFloat('32,03')));
end;


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294534" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "62716" AND DET_CODCLI = "00055285";
    DOCUMENTO: 000000294534
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00055285
       ESTADO: SP
         ITEM: 62716
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 041
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: 11}

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


Procedure TestDUPLORMAQUINAS.FCP_DUPLORMAQUINAS_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000294638" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "39205" AND DET_CODCLI = "00263581";
    DOCUMENTO: 000000294638
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00263581
       ESTADO: RJ
         ITEM: 39205
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 200
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
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
      .BaseDeCalculoDoIcmsDoItem(822.08)
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
            CompararValores(ReturnValue.BaseFCP{822,08}, objFloatUtils.fStrToFloat('822,08')) And
            CompararValores(ReturnValue.ValorFCP{16,44}, objFloatUtils.fStrToFloat('16,44')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{2}, objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{16,44},objFloatUtils.fStrToFloat('16,44')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{2},objFloatUtils.fStrToFloat('2')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{822,08},objFloatUtils.fStrToFloat('822,08')));
end;




initialization
  RegisterTest(TestDUPLORMAQUINAS.Suite);
end.

