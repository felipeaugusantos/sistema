unit TestFaturamento.Impostos.Calculos.Fcp.CS_FERRAMENTAS_Lj001_20191209;

{--------------------------------------------------------------------------
                    RESUMO FCP                 
--------------------------------------------------------------------------
Empresa            : 001 - CS FERRAMENTAS LTDA
Período Selecionado: 09/12/2019 até 09/12/2019
Data do Processo   : 10/12/2019 
Hora Inicio        : 15:38:10
Hora Fim           : 15:42:16
Tempo Total        : 00:04:06
                                           
Total Registros    : 546
Total Processados  : 546
Total de Acertos   : 3
Total de Erros     : 0
Total Ignorados    : 278
Total Duplicados   : 265
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
TestCSFERRAMENTAS = class(TTestCase)
strict private
private


  FRecordDifalFCP: TRecDifalFCP;


published

Procedure FCP_CSFERRAMENTAS_000001;
Procedure FCP_CSFERRAMENTAS_000002;
Procedure FCP_CSFERRAMENTAS_000003;


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

Procedure TestCSFERRAMENTAS.FCP_CSFERRAMENTAS_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220740" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "18141" AND DET_CODCLI = "00014387";
    DOCUMENTO: 000000220740
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00014387
       ESTADO: SP
         ITEM: 18141
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 09/12/2019
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


Procedure TestCSFERRAMENTAS.FCP_CSFERRAMENTAS_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000000012" AND DET_ESPDOC = "TA" AND DET_CODEMP = "001" AND DET_CODITE = "18327" AND DET_CODCLI = "00037228";
    DOCUMENTO: 000000000012
      ESPECIE: TA
      EMPRESA: 001
      CLIENTE: 00037228
       ESTADO: 
         ITEM: 18327
 ITEM SERVIÇO: NÃO
         CFOP: 5999
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


Procedure TestCSFERRAMENTAS.FCP_CSFERRAMENTAS_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000023679" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "001" AND DET_CODITE = "20943" AND DET_CODCLI = "00000674";
    DOCUMENTO: 000000023679
      ESPECIE: AJ
      EMPRESA: 001
      CLIENTE: 00000674
       ESTADO: SP
         ITEM: 20943
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




initialization
  RegisterTest(TestCSFERRAMENTAS.Suite);
end.

