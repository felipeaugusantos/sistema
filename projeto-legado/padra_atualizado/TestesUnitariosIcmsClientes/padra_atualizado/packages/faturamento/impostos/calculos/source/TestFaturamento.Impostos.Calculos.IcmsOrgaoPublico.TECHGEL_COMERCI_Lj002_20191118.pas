unit TestFaturamento.Impostos.Calculos.IcmsOrgaoPublico.TECHGEL_COMERCI_Lj002_20191118;

{--------------------------------------------------------------------------
                    RESUMO ICMSORGAOPUBLICO                 
--------------------------------------------------------------------------
Empresa            : 002 - TECHGEL COMERCIAL EIRELI - EPP
Período Selecionado: 18/11/2019 até 18/11/2019
Data do Processo   : 18/11/2019 
Hora Inicio        : 20:08:59
Hora Fim           : 20:09:42
Tempo Total        : 00:00:43
                                           
Total Registros    : 23
Total Processados  : 23
Total de Acertos   : 23
Total de Erros     : 0
Total Ignorados    : 0
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
Faturamento.Impostos.Calculos.IcmsOrgaoPublico,
Faturamento.Impostos.Tipos.IcmsOrgaoPublico,
Faturamento.Impostos.Interfaces.IcmsOrgaoPublico;

type
TestTECHGELCOMERCI = class(TTestCase)
strict private
private




published

Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000001;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000002;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000003;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000004;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000005;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000006;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000007;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000008;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000009;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000010;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000011;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000012;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000013;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000014;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000015;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000016;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000017;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000018;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000019;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000020;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000021;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000022;
Procedure REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000023;


public
  procedure SetUp; override;
  procedure TearDown; override;
end;

implementation

procedure TestTECHGELCOMERCI.SetUp;
begin
end;

procedure TestTECHGELCOMERCI.TearDown;
begin
end;

Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000001;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025671" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01543" AND DET_CODCLI = "00004713";
    DOCUMENTO: 000000025671
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00004713
       ESTADO: PR
         ITEM: 01543
 ITEM SERVIÇO: NÃO
         CFOP: 6101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(390)
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
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000002;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025672" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04899" AND DET_CODCLI = "00001786";
    DOCUMENTO: 000000025672
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00001786
       ESTADO: MG
         ITEM: 04899
 ITEM SERVIÇO: NÃO
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(154.98)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000003;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025673" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "01543" AND DET_CODCLI = "00006909";
    DOCUMENTO: 000000025673
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006909
       ESTADO: MG
         ITEM: 01543
 ITEM SERVIÇO: NÃO
         CFOP: 6101
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(624)
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
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000004;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025674" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05507" AND DET_CODCLI = "00001039";
    DOCUMENTO: 000000025674
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00001039
       ESTADO: MG
         ITEM: 05507
 ITEM SERVIÇO: NÃO
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(680)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000005;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025675" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06896" AND DET_CODCLI = "00001039";
    DOCUMENTO: 000000025675
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00001039
       ESTADO: MG
         ITEM: 06896
 ITEM SERVIÇO: NÃO
         CFOP: 6102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(135)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(12)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000006;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025676" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10101" AND DET_CODCLI = "00006500";
    DOCUMENTO: 000000025676
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006500
       ESTADO: SP
         ITEM: 10101
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(642)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000007;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025677" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05113" AND DET_CODCLI = "00006945";
    DOCUMENTO: 000000025677
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006945
       ESTADO: RJ
         ITEM: 05113
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(169)
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
      .ClienteConsumidorFinal(True)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{0}, objFloatUtils.fStrToFloat('0')));
end;


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000008;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025678" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05108" AND DET_CODCLI = "00002468";
    DOCUMENTO: 000000025678
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00002468
       ESTADO: SP
         ITEM: 05108
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(795)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000009;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025679" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02530" AND DET_CODCLI = "00005139";
    DOCUMENTO: 000000025679
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005139
       ESTADO: BA
         ITEM: 02530
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(135.38)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000010;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025679" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04770" AND DET_CODCLI = "00005139";
    DOCUMENTO: 000000025679
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005139
       ESTADO: BA
         ITEM: 04770
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(27.7)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000011;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025679" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05708" AND DET_CODCLI = "00005139";
    DOCUMENTO: 000000025679
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005139
       ESTADO: BA
         ITEM: 05708
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(83.1)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000012;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025679" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06690" AND DET_CODCLI = "00005139";
    DOCUMENTO: 000000025679
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00005139
       ESTADO: BA
         ITEM: 06690
 ITEM SERVIÇO: NÃO
         CFOP: 6108
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CTA
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(156.92)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000013;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025680" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "02530" AND DET_CODCLI = "00006947";
    DOCUMENTO: 000000025680
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006947
       ESTADO: AL
         ITEM: 02530
 ITEM SERVIÇO: NÃO
         CFOP: 6949
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: OU}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('OU')
      .ValorTotalDoItem(135.38)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000014;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025680" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "04770" AND DET_CODCLI = "00006947";
    DOCUMENTO: 000000025680
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006947
       ESTADO: AL
         ITEM: 04770
 ITEM SERVIÇO: NÃO
         CFOP: 6949
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: OU}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('OU')
      .ValorTotalDoItem(27.7)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000015;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025680" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05708" AND DET_CODCLI = "00006947";
    DOCUMENTO: 000000025680
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006947
       ESTADO: AL
         ITEM: 05708
 ITEM SERVIÇO: NÃO
         CFOP: 6949
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: OU}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('OU')
      .ValorTotalDoItem(83.1)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000016;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025680" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "06690" AND DET_CODCLI = "00006947";
    DOCUMENTO: 000000025680
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006947
       ESTADO: AL
         ITEM: 06690
 ITEM SERVIÇO: NÃO
         CFOP: 6949
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: OU}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(False)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('OU')
      .ValorTotalDoItem(156.92)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(7)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000017;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025681" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "08090" AND DET_CODCLI = "00002963";
    DOCUMENTO: 000000025681
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00002963
       ESTADO: AM
         ITEM: 08090
 ITEM SERVIÇO: NÃO
         CFOP: 6110
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(996)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(69.72)
      .AliquotaDeIcmsDoItem(7)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{996}, objFloatUtils.fStrToFloat('996')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{69,72}, objFloatUtils.fStrToFloat('69,72')));
end;


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000018;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025681" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "10118" AND DET_CODCLI = "00002963";
    DOCUMENTO: 000000025681
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00002963
       ESTADO: AM
         ITEM: 10118
 ITEM SERVIÇO: NÃO
         CFOP: 6110
CODIGO FISCAL: 040
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CNC
 DATA ENTRADA: 18/11/2019
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
      .ValorTotalDoItem(498)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(34.86)
      .AliquotaDeIcmsDoItem(7)
      .ClienteOrgaoPublico(False)
      .ClienteZonaFranca(True)
      .ClienteConsumidorFinal(False)
      .AplicarDescontoPisCofinsOrgaoPublico(False)
      .CalcularDescontoIcmsOrgaoPublico(False);

  ReturnValue := TCalculoImpostosIcmsOrgaoPublico.New.CalcularValorIcmsOrgaoPublico(AParametros);

  CheckTrue( 
           CompararValores(ReturnValue.BaseDeIcmsDeOrgaoPublicoDoItem{498}, objFloatUtils.fStrToFloat('498')) And
           CompararValores(ReturnValue.ValorDoIcmsDeOrgaoPublicoDoItem{34,86}, objFloatUtils.fStrToFloat('34,86')));
end;


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000019;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002282" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "02530" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002282
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 02530
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(88)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000020;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002282" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "04770" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002282
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 04770
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(18)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000021;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002282" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "05708" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002282
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 05708
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(54)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000022;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000002282" AND DET_ESPDOC = "AJ" AND DET_CODEMP = "002" AND DET_CODITE = "06690" AND DET_CODCLI = "00001796";
    DOCUMENTO: 000000002282
      ESPECIE: AJ
      EMPRESA: 002
      CLIENTE: 00001796
       ESTADO: SP
         ITEM: 06690
 ITEM SERVIÇO: NÃO
         CFOP: 1999
CODIGO FISCAL: 
       IDEPRO: NOR
TIPO DA ABREV: _SAI_NCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: }

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(True)
      .OpcaoDeDocumento('')
      .ValorTotalDoItem(102)
      .AliquotaDoPis(1.65)
      .AliquotaDoCofins(7.6)
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


Procedure TestTECHGELCOMERCI.REGRA_ICMSORGAOPUBLICO_TECHGELCOMERCI_000023;
{SELECT * FROM MOVDET WHERE DET_NUMDOC = "000000025682" AND DET_ESPDOC = "NF" AND DET_CODEMP = "002" AND DET_CODITE = "05097" AND DET_CODCLI = "00006005";
    DOCUMENTO: 000000025682
      ESPECIE: NF
      EMPRESA: 002
      CLIENTE: 00006005
       ESTADO: SP
         ITEM: 05097
 ITEM SERVIÇO: NÃO
         CFOP: 5102
CODIGO FISCAL: 000
       IDEPRO: NOR
TIPO DA ABREV: _SAI_CCO
 DATA ENTRADA: 18/11/2019
   AUX_OPCDOC: EI}

Var
  ReturnValue: IResultadoCalculoIcmsOrgaoPublico;
  AParametros: IParametrosCalculoIcmsOrgaoPublico;
Begin

  AParametros :=
    TParametrosCalculoIcmsOrgaoPublico.New()
      .DentroDoEstado(True)
      .SubstituicaoTributariaDoItem(False)
      .OpcaoDeDocumento('EI')
      .ValorTotalDoItem(465)
      .AliquotaDoPis(0)
      .AliquotaDoCofins(0)
      .CodigoDaSituacaoTributaria('000')
      .IsencaoDeIcmsVendasZonaFrancaProdutosNacionais(False)
      .PercentualDaBaseDeCalculoDoItem(100)
      .ValorFreteDespesasAcessoriasItem(0)
      .DescontoEspecialDoItem(0)
      .AliquotaDeIcmsDoItem(18)
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




initialization
  RegisterTest(TestTECHGELCOMERCI.Suite);
end.

