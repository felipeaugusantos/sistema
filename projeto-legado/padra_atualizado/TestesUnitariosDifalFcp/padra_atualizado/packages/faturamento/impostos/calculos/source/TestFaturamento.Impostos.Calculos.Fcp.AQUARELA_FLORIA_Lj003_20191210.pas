unit TestFaturamento.Impostos.Calculos.Fcp.AQUARELA_FLORIA_Lj003_20191210;

{--------------------------------------------------------------------------
                    RESUMO FCP                 
--------------------------------------------------------------------------
Empresa            : 003 - AQUARELA FLORIANO
Período Selecionado: 10/12/2019 até 10/12/2019
Data do Processo   : 11/12/2019 
Hora Inicio        : 11:16:34
Hora Fim           : 11:23:39
Tempo Total        : 00:07:04
                                           
Total Registros    : 519
Total Processados  : 519
Total de Acertos   : 7
Total de Erros     : 0
Total Ignorados    : 149
Total Duplicados   : 363
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
TestAQUARELAFLORIA = class(TTestCase)
strict private
private


  FRecordDifalFCP: TRecDifalFCP;


published

Procedure FCP_AQUARELAFLORIA_000001;
Procedure FCP_AQUARELAFLORIA_000002;
Procedure FCP_AQUARELAFLORIA_000003;
Procedure FCP_AQUARELAFLORIA_000004;
Procedure FCP_AQUARELAFLORIA_000005;
Procedure FCP_AQUARELAFLORIA_000006;
Procedure FCP_AQUARELAFLORIA_000007;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestAQUARELAFLORIA.SetUp;
begin
end;

procedure TestAQUARELAFLORIA.TearDown;
begin
end;

Procedure TestAQUARELAFLORIA.FCP_AQUARELAFLORIA_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000080780" AND DET_ESPDOC = "NF" AND DET_CODEMP = "003" AND DET_CODITE = "07313" AND DET_CODCLI = "30000860";
    DOCUMENTO: 000000080780
      ESPECIE: NF
      EMPRESA: 003
      CLIENTE: 30000860
       ESTADO: RS
         ITEM: 07313
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: VN}

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
      .ClienteEstado('RS')
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


Procedure TestAQUARELAFLORIA.FCP_AQUARELAFLORIA_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000063369" AND DET_ESPDOC = "IF" AND DET_CODEMP = "003" AND DET_CODITE = "08021" AND DET_CODCLI = "00000000";
    DOCUMENTO: 000000063369
      ESPECIE: IF
      EMPRESA: 003
      CLIENTE: 00000000
       ESTADO: RS
         ITEM: 08021
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NEX
TIPO DA ABREV: _SAI_NCO
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
      .ClienteEstado('RS')
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


Procedure TestAQUARELAFLORIA.FCP_AQUARELAFLORIA_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000080799" AND DET_ESPDOC = "NF" AND DET_CODEMP = "003" AND DET_CODITE = "13010" AND DET_CODCLI = "00139480";
    DOCUMENTO: 000000080799
      ESPECIE: NF
      EMPRESA: 003
      CLIENTE: 00139480
       ESTADO: SC
         ITEM: 13010
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: VN}

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
      .ClienteEstado('SC')
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


Procedure TestAQUARELAFLORIA.FCP_AQUARELAFLORIA_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000080799" AND DET_ESPDOC = "NF" AND DET_CODEMP = "003" AND DET_CODITE = "05754" AND DET_CODCLI = "00139480";
    DOCUMENTO: 000000080799
      ESPECIE: NF
      EMPRESA: 003
      CLIENTE: 00139480
       ESTADO: SC
         ITEM: 05754
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(159.15)
      .AliquotaFCPAbrevicaoIcms(0)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('SC')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(False)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{159,15}, objFloatUtils.fStrToFloat('159,15')) And
            CompararValores(ReturnValue.BaseFCP{159,15}, objFloatUtils.fStrToFloat('159,15')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{159,15},objFloatUtils.fStrToFloat('159,15')));
end;


Procedure TestAQUARELAFLORIA.FCP_AQUARELAFLORIA_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000080799" AND DET_ESPDOC = "NF" AND DET_CODEMP = "003" AND DET_CODITE = "08676" AND DET_CODCLI = "00139480";
    DOCUMENTO: 000000080799
      ESPECIE: NF
      EMPRESA: 003
      CLIENTE: 00139480
       ESTADO: SC
         ITEM: 08676
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(54.3)
      .AliquotaFCPAbrevicaoIcms(0)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('SC')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(False)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{54,3}, objFloatUtils.fStrToFloat('54,3')) And
            CompararValores(ReturnValue.BaseFCP{54,3}, objFloatUtils.fStrToFloat('54,3')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{54,3},objFloatUtils.fStrToFloat('54,3')));
end;


Procedure TestAQUARELAFLORIA.FCP_AQUARELAFLORIA_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000080799" AND DET_ESPDOC = "NF" AND DET_CODEMP = "003" AND DET_CODITE = "06432" AND DET_CODCLI = "00139480";
    DOCUMENTO: 000000080799
      ESPECIE: NF
      EMPRESA: 003
      CLIENTE: 00139480
       ESTADO: SC
         ITEM: 06432
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 10/12/2019
   AUX_OPCDOC: VN}

Var
  ReturnValue: IResultadoCalculoFCP;
  AParametros: IParametrosCalculoFCP;
Begin

  AParametros :=
    TParametrosCalculoFCP.New()
      .AtendeRegrasDIFAL(False)
      .VendaPresencial(False)
      .SubstituicaoTributariaDoItem(False)
      .BaseDeCalculoDoIcmsDoItem(168)
      .AliquotaFCPAbrevicaoIcms(0)
      .DocumentoDeDevolucao(False)
      .DiferencaFCPST(False)
      .BaseDeCalculoDaSubstituicaoTributariaDoItem(0)
      .AliquotaFCPST(0)
      .CalcularBeneficioReducaoBaseIcmsST(False)
      .ClienteEstado('SC')
      .OutrasSaidasParaFornecedores(False)
      .RecordDifalFCP(FRecordDifalFCP)
      .ZerarFCP(False)
      .ProdutoIndustrializadoDentroDoEstado(False)
      .SimplesNacional(False);

  ReturnValue := TCalculoImpostosFCP.New.CalcularValorFCP(AParametros);

  CheckTrue( 
            CompararValores(ReturnValue.BaseDestino{168}, objFloatUtils.fStrToFloat('168')) And
            CompararValores(ReturnValue.BaseFCP{168}, objFloatUtils.fStrToFloat('168')) And
            CompararValores(ReturnValue.ValorFCP{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.AliquotaDoFCPDoItem{0}, objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltValFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltPerFcp{0},objFloatUtils.fStrToFloat('0')) And
            CompararValores(ReturnValue.RecordDifalFCP.fltBasFcp{168},objFloatUtils.fStrToFloat('168')));
end;


Procedure TestAQUARELAFLORIA.FCP_AQUARELAFLORIA_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000080805" AND DET_ESPDOC = "NF" AND DET_CODEMP = "003" AND DET_CODITE = "08183" AND DET_CODCLI = "00002747";
    DOCUMENTO: 000000080805
      ESPECIE: NF
      EMPRESA: 003
      CLIENTE: 00002747
       ESTADO: RS
         ITEM: 08183
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
      .ClienteEstado('RS')
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




initialization
  RegisterTest(TestAQUARELAFLORIA.Suite);
end.

