unit TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TELCABOS_PR_Lj002_20191216;

{--------------------------------------------------------------------------
                    RESUMO ICMSORGAOPUBLICO                 
--------------------------------------------------------------------------
Empresa            : 002 - TELCABOS PR
Período Selecionado: 16/12/2019 até 16/12/2019
Data do Processo   : 16/12/2019 
Hora Inicio        : 17:00:29
Hora Fim           : 17:00:48
Tempo Total        : 00:00:18
                                           
Total Registros    : 12
Total Processados  : 12
Total de Acertos   : 11
Total de Erros     : 0
Total Ignorados    : 0
Total Duplicados   : 1
--------------------------------------------------------------------------
}

interface

uses
TestFramework,
Shared.Functions.FloatUtils,
Shared.Functions.Funcoes.Faturamento,
Shared.Functions.Types,
untFuncoes,
Faturamento.Impostos.Calculos.IcmsOrgaoPublico,
Faturamento.Impostos.Tipos.IcmsOrgaoPublico,
Faturamento.Impostos.Interfaces.IcmsOrgaoPublico;

type
TestTELCABOSPR = class(TTestCase)
strict private
private





published

Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000001;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000002;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000003;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000004;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000005;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000006;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000007;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000008;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000009;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000010;
Procedure REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000011;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestTELCABOSPR.SetUp;
begin
end;

procedure TestTELCABOSPR.TearDown;
begin
end;

Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014547" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "03889" AND DET_CODCLI = "00051895";
    DOCUMENTO: 000000014547
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00051895
       ESTADO: RS
         ITEM: 03889
 ITEM SERVIÇO: NÃO
         CFOP: 6403
CODIGO FISCAL: 210
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(180.88)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('210')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(4)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014548" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "08889" AND DET_CODCLI = "00013572";
    DOCUMENTO: 000000014548
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00013572
       ESTADO: PR
         ITEM: 08889
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1232.56)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014548" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02329" AND DET_CODCLI = "00013572";
    DOCUMENTO: 000000014548
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00013572
       ESTADO: PR
         ITEM: 02329
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 010
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1898.68)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('010')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014548" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "11138" AND DET_CODCLI = "00013572";
    DOCUMENTO: 000000014548
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00013572
       ESTADO: PR
         ITEM: 11138
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 060
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1476.2)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('060')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014550" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05414" AND DET_CODCLI = "00044367";
    DOCUMENTO: 000000014550
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00044367
       ESTADO: PR
         ITEM: 05414
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 260
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(131.16)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('260')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014550" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02814" AND DET_CODCLI = "00044367";
    DOCUMENTO: 000000014550
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00044367
       ESTADO: PR
         ITEM: 02814
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 560
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(157.12)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('560')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000200847" AND DET_ESPDOC = "TA" AND DET_CODEMP = "002" AND DET_CODITE = "00767" AND DET_CODCLI = "00043231";
    DOCUMENTO: 000000200847
      ESPECIE: TA
      EMPRESA: 002
      CLIENTE: 00043231
       ESTADO: 
         ITEM: 00767
 ITEM SERVIÇO: NÃO
         CFOP: 5999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(1082.1)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014551" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00767" AND DET_CODCLI = "00044738";
    DOCUMENTO: 000000014551
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00044738
       ESTADO: PR
         ITEM: 00767
 ITEM SERVIÇO: NÃO
         CFOP: 5405
CODIGO FISCAL: 460
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(2001.9)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('460')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(0)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(0)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014552" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06312" AND DET_CODCLI = "00043230";
    DOCUMENTO: 000000014552
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00043230
       ESTADO: SP
         ITEM: 06312
 ITEM SERVIÇO: NÃO
         CFOP: 6152
CODIGO FISCAL: 400
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(405.7)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('400')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014552" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "00749" AND DET_CODCLI = "00043230";
    DOCUMENTO: 000000014552
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00043230
       ESTADO: SP
         ITEM: 00749
 ITEM SERVIÇO: NÃO
         CFOP: 6152
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_TRS
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(1318.48)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(False)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTELCABOSPR.REGRA_ICMSORGAOPUBLICO_TELCABOSPR_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000014553" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02771" AND DET_CODCLI = "00049598";
    DOCUMENTO: 000000014553
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00049598
       ESTADO: AM
         ITEM: 02771
 ITEM SERVIÇO: NÃO
         CFOP: 6110
CODIGO FISCAL: 540
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 16/12/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(9127.6)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('500')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(1483.24)
      .AliquotaDeIcmsDoItem(7)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{9127,6}, objFloatUtils.fStrToFloat('9127,6')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{638,93}, objFloatUtils.fStrToFloat('638,93')));
end;




initialization
  RegisterTest(TestTELCABOSPR.Suite);
end.

