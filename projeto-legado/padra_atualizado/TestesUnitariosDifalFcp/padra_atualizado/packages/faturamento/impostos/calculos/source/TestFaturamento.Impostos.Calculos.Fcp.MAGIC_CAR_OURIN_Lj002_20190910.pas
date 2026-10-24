unit TestFaturamento.Impostos.Calculos.Fcp.MAGIC_CAR_OURIN_Lj002_20190910;

{--------------------------------------------------------------------------
                    RESUMO FCP                 
--------------------------------------------------------------------------
Empresa            : 002 - MAGIC CAR OURINHOS 
Período Selecionado: 10/09/2019 até 10/09/2019
Data do Processo   : 12/12/2019 
Hora Inicio        : 16:14:58
Hora Fim           : 16:25:12
Tempo Total        : 00:10:13
                                           
Total Registros    : 506
Total Processados  : 506
Total de Acertos   : 3
Total de Erros     : 0
Total Ignorados    : 150
Total Duplicados   : 353
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
TestMAGICCAROURIN = class(TTestCase)
strict private
private


  FRecordDifalFCP: TRecDifalFCP;


published

Procedure FCP_MAGICCAROURIN_000001;
Procedure FCP_MAGICCAROURIN_000002;
Procedure FCP_MAGICCAROURIN_000003;


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

Procedure TestMAGICCAROURIN.FCP_MAGICCAROURIN_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000208464" AND DET_ESPDOC = "ML" AND DET_CODEMP = "002" AND DET_CODITE = "24391" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000208464
      ESPECIE: ML
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 24391
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 000
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
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
      .SimplesNacional(True);

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


Procedure TestMAGICCAROURIN.FCP_MAGICCAROURIN_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000208464" AND DET_ESPDOC = "ML" AND DET_CODEMP = "002" AND DET_CODITE = "23630" AND DET_CODCLI = "20000001";
    DOCUMENTO: 000000208464
      ESPECIE: ML
      EMPRESA: 002
      CLIENTE: 20000001
       ESTADO: SP
         ITEM: 23630
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 060
       IDEPRO: LAZ
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 10/09/2019
   AUX_OPCDOC: }

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
      .SimplesNacional(True);

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


Procedure TestMAGICCAROURIN.FCP_MAGICCAROURIN_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000201085" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "44176" AND DET_CODCLI = "10001255";
    DOCUMENTO: 000000201085
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 10001255
       ESTADO: 
         ITEM: 44176
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_SNA
 DATA ENTRADA: 10/09/2019
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
      .SimplesNacional(True);

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
  RegisterTest(TestMAGICCAROURIN.Suite);
end.

