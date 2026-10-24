unit TestFaturamento.Impostos.Calculos.Fcp.CS_FERRAMENTAS_Lj001_20191206;

{--------------------------------------------------------------------------
                    RESUMO FCP                 
--------------------------------------------------------------------------
Empresa            : 001 - CS FERRAMENTAS LTDA
Período Selecionado: 06/12/2019 até 06/12/2019
Data do Processo   : 10/12/2019 
Hora Inicio        : 16:14:23
Hora Fim           : 16:19:04
Tempo Total        : 00:04:40
                                           
Total Registros    : 363
Total Processados  : 363
Total de Acertos   : 2
Total de Erros     : 0
Total Ignorados    : 231
Total Duplicados   : 130
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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000220587" AND DET_ESPDOC = "NF" AND DET_CODEMP = "001" AND DET_CODITE = "26310" AND DET_CODCLI = "00047860";
    DOCUMENTO: 000000220587
      ESPECIE: NF
      EMPRESA: 001
      CLIENTE: 00047860
       ESTADO: SP
         ITEM: 26310
 ITEM SERVIÇO: NÃO
         CFOP: 1411
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
   AUX_OPCDOC: OE}

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
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000023678" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "001" AND DET_CODITE = "35917" AND DET_CODCLI = "00000674";
    DOCUMENTO: 000000023678
      ESPECIE: AJ
      EMPRESA: 001
      CLIENTE: 00000674
       ESTADO: SP
         ITEM: 35917
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 06/12/2019
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

