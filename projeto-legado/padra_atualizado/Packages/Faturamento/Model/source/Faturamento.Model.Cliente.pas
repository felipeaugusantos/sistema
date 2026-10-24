unit Faturamento.Model.Cliente;

interface

uses Faturamento.Impostos.Interfaces.Model, Faturamento.Impostos.Tipos.Model,
  Shared.Functions.Core, Shared.Functions.DataSet, Shared.Functions.Funcoes.Faturamento;

type
  TFaturamentoImpostosModelCliente = class(TInterfacedObject, IFaturamentoImpostosModelCliente)
  private
    function RetornarCampoCLI_SIBICM(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_IVASIM(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_ICMREI(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_ORPUDF(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_CEDESP(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_CEDSIM(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCLI_CEDNAC(const AGerandoCasosTestes: boolean): string;
    function RetornarCampoCli_RECALI(const AGerandoCasosTestes: boolean): string;

    function RetornarInformacoesClienteConsumidor(const AParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor) : Boolean;

  public

    function Consultar(const ACodigoDoCliente: String;
      const ASequencialEnderecoEntrega : String; const AGerandoCasosTestes: boolean; const AClienteConsumidorFinal: boolean;
      const AParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor = Nil; const ACodigoDaFazenda: String = ''): IResultadoFaturamentoImpostosModelClienteFornecedor;

    class function New(): IFaturamentoImpostosModelCliente;
  end;

implementation

{ TFaturamentoImpostosModelCliente }

function TFaturamentoImpostosModelCliente.Consultar( const ACodigoDoCliente: String;
 const ASequencialEnderecoEntrega : String; const AGerandoCasosTestes: boolean; const AClienteConsumidorFinal: boolean;
 const AParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor = Nil; const ACodigoDaFazenda: String = ''): IResultadoFaturamentoImpostosModelClienteFornecedor;
var
  LSituacaoDoIpi          : String;
  LZonaFranca             : Boolean;
  LOrgaoPublico           : Boolean;
  LClienteExterior        : Boolean;
  LZonaFrancaDesEsp       : Boolean;
  LClienteEstado          : String;
  FClienteEstadoEntrega   : String;
  LClienteAtividade       : String;
  LClienteRegraFiscal     : String;
  LSomarIpiBaseIcms       : Boolean;
  LClienteInscricao       : String;
  LMicroEmpreendedor      : Boolean;

  LValorIVAEspecialClienteMT : Double;
  LValorIVASimClienteMT      : Double;
  LValorIVANacClienteMT      : Double;

  LCalcularDescontoIcmsOrgaoPublico: Boolean;
  LSujeitoPassivoSTRegimeEspecial  : Boolean;
  LReducaoDeBaseDeIcmsTributados   : Double;
  LUtilizarDiferimetoST            : Boolean;
  LTipoDeDescontoRateioDescEspecial: String;

  LClienteZonaFrancaComDescontoEspecial: Boolean;
  LAplicarDescontoPisCofinsOrgaoPublico: Boolean;
  LBeneficioREIDI: Boolean;
  LDeduzirIcmsDoBeneficioREIDI: Boolean;

  LRetornoCampoTabela: IMyCampoTabela;
  LRetornoCampoTabelaEnderecoDeEntrega: IMyCampoTabela;

  LValorAliquotaIRF : Double;
  LValorAliquotaPIS : Double;
  LValorAliquotaCOF : Double;
  LValorAliquotaCSL : Double;

  LRetencaoDeIRPF : String;
  LRetencaoDePisCofins : String;

  LClienteC_G_C_ : String;
  LClienteFisJur : String;

  LClienteProdutorRural: String;
  LClienteNaoContribuinteDeIcms: String;

  LClienteOrgaoPublicoDifal: Boolean;

  LValorIVAEspecialClienteMTCedem: Double;
  LValorIVASimClienteMTCedem: Double;
  LValorIVANacClienteMTCedem: Double;
  LCodigoDaEmpresaTransferencia : String;
  LAtoDeclaratorioDF: Boolean;
  LClienteReducaoCargaLiquida: Boolean;
  LSuframa: String;
  LClienteIbgeEntrega: String;
  LOrgaoPublicoForaDoEstado: Boolean;
begin

  LRetornoCampoTabela :=
    objCore.fCampoTabela(['CLI_SITIPI', 'CLI_ZONFRA', 'CLI_CODATI', 'CLI_REGFIS',
                          'CLI_ORGPUB', 'CID_ESTADO AS CLI_ESTADO', 'CLI_CONSUM', RetornarCampoCLI_SIBICM(AGerandoCasosTestes),
                          'CLI_I_E_S_', 'CLI_MICEMP', 'CLI_IVAESP', RetornarCampoCLI_IVASIM(AGerandoCasosTestes),
                          'CLI_CALICM', 'CLI_STREES', 'CLI_REDICM', 'CLI_DIF_ST', RetornarCampoCLI_ICMREI(AGerandoCasosTestes),
                          'CLI_ORPURD', 'CLI_IVANAC', 'CLI_DESPIS', 'CLI_BENREI',
                          'CLI_ALQIRF','CLI_ALQPIS','CLI_ALQCOF','CLI_ALQCSL', 'CLI_ORGFDE',
                          'CLI_RETIRF', 'CLI_RETPCO', 'CLI_C_G_C_', 'CLI_CGCCPF', 'CLI_PRORUR',
                          'CLI_IESUNI', 'CLI_ATODDF', 'CLI_DESZON', 'CLI_SUFRAM', RetornarCampoCLI_ORPUDF(AGerandoCasosTestes),
                          RetornarCampoCLI_CEDESP(AGerandoCasosTestes),
                          RetornarCampoCLI_CEDSIM(AGerandoCasosTestes),
                          RetornarCampoCLI_CEDNAC(AGerandoCasosTestes),
                          RetornarCampoCli_RECALI(AGerandoCasosTestes)],

      'CADCLI LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID', ['CLI_CODCLI'], [ACodigoDoCliente], False);

  If objCore.fEmptyStr(ACodigoDaFazenda) Then
    LRetornoCampoTabelaEnderecoDeEntrega :=
      objCore.fCampoTabela(['CID_ESTADO AS ENT_ESTADO','CID_COIBGE AS ENT_COIBGE'],
        'ENTCLI INNER JOIN CADCID ON CID_CODCID = ETC_CIDENT ', ['ENTCLI.AUTOINCREM'], [ASequencialEnderecoEntrega], False)
  Else
    LRetornoCampoTabelaEnderecoDeEntrega :=
      objCore.fCampoTabela(['CID_ESTADO AS ENT_ESTADO','CID_COIBGE AS ENT_COIBGE'],
        'CADFAZ INNER JOIN CADCID ON CID_CODCID = FAZ_CODCID ', ['FAZ_CODCLI','FAZ_CODFAZ'], [ACodigoDoCliente, ACodigoDaFazenda], False);

  LSituacaoDoIpi      := LRetornoCampoTabela.FieldByName('CLI_SITIPI');
  LZonaFranca         := LRetornoCampoTabela.FieldByName('CLI_ZONFRA');
  LZonaFrancaDesEsp   := LRetornoCampoTabela.FieldByName('CLI_DESZON');
  LOrgaoPublico       := LRetornoCampoTabela.FieldByName('CLI_ORGPUB');
  LSuframa            := LRetornoCampoTabela.FieldByName('CLI_SUFRAM');

  LClienteRegraFiscal := LRetornoCampoTabela.FieldByName('CLI_REGFIS');
  LMicroEmpreendedor  := LRetornoCampoTabela.FieldByName('CLI_MICEMP').AsString = 'S';

  LClienteC_G_C_ := LRetornoCampoTabela.FieldByName('CLI_C_G_C_');

  LValorAliquotaIRF   := LRetornoCampoTabela.FieldByName('CLI_ALQIRF').AsFloat;
  LValorAliquotaPIS   := LRetornoCampoTabela.FieldByName('CLI_ALQPIS').AsFloat;
  LValorAliquotaCOF   := LRetornoCampoTabela.FieldByName('CLI_ALQCOF').AsFloat;
  LValorAliquotaCSL   := LRetornoCampoTabela.FieldByName('CLI_ALQCSL').AsFloat;

  LRetencaoDeIRPF     := LRetornoCampoTabela.FieldByName('CLI_RETIRF').AsString;
  LRetencaoDePisCofins:= LRetornoCampoTabela.FieldByName('CLI_RETPCO').AsString;

  LValorIVAEspecialClienteMT        := LRetornoCampoTabela.FieldByName('CLI_IVAESP');
  LValorIVASimClienteMT             := LRetornoCampoTabela.FieldByName('CLI_IVASIM');
  LValorIVANacClienteMT             := LRetornoCampoTabela.FieldByName('CLI_IVANAC');

  LValorIVAEspecialClienteMTCedem   := LRetornoCampoTabela.FieldByName('CLI_CEDESP');
  LValorIVASimClienteMTCedem        := LRetornoCampoTabela.FieldByName('CLI_CEDSIM');
  LValorIVANacClienteMTCedem        := LRetornoCampoTabela.FieldByName('CLI_CEDNAC');


  FClienteEstadoEntrega := LRetornoCampoTabelaEnderecoDeEntrega.FieldByName('ENT_ESTADO');
  LClienteIbgeEntrega   := LRetornoCampoTabelaEnderecoDeEntrega.FieldByName('ENT_COIBGE');

  LSomarIpiBaseIcms     := LRetornoCampoTabela.FieldByName('CLI_SIBICM').AsString  = 'S';

  LSujeitoPassivoSTRegimeEspecial := LRetornoCampoTabela.FieldByName('CLI_STREES').AsString = 'S';
  LReducaoDeBaseDeIcmsTributados  := LRetornoCampoTabela.FieldByName('CLI_REDICM');
  LUtilizarDiferimetoST           := LRetornoCampoTabela.FieldByName('CLI_DIF_ST').AsString = 'S';

  LTipoDeDescontoRateioDescEspecial := LRetornoCampoTabela.FieldByName('CLI_ORPURD');

  LAplicarDescontoPisCofinsOrgaoPublico := LRetornoCampoTabela.FieldByName('CLI_DESPIS').AsString = 'S';
  LBeneficioREIDI := LRetornoCampoTabela.FieldByName('CLI_BENREI').AsString = 'S';
  LDeduzirIcmsDoBeneficioREIDI := LRetornoCampoTabela.FieldByName('CLI_ICMREI').AsString = 'S';

  LClienteInscricao                 := LRetornoCampoTabela.FieldByName('CLI_I_E_S_');
  LClienteEstado                    := LRetornoCampoTabela.FieldByName('CLI_ESTADO');
  LClienteAtividade                 := LRetornoCampoTabela.FieldByName('CLI_CODATI');
  LCalcularDescontoIcmsOrgaoPublico := LRetornoCampoTabela.FieldByName('CLI_CALICM');

  LClienteFisJur :=
    TFunctionFuncoesFaturamento
      .RetornarClienteFisicoOuJuridico(LRetornoCampoTabela.FieldByName('CLI_CGCCPF').AsInteger);

  LClienteProdutorRural := LRetornoCampoTabela.FieldByName('CLI_PRORUR').AsString;
  LClienteNaoContribuinteDeIcms := LRetornoCampoTabela.FieldByName('CLI_IESUNI').AsString;
  LClienteOrgaoPublicoDifal := LRetornoCampoTabela.FieldByName('CLI_ORPUDF').AsString = 'S';

  If RetornarInformacoesClienteConsumidor(AParametrosClienteConsumidor) Then
  Begin
    LClienteInscricao                 := AParametrosClienteConsumidor.ClienteInscricaoEstadual;
    LClienteEstado                    := AParametrosClienteConsumidor.ClienteEstado;
    LClienteAtividade                 := AParametrosClienteConsumidor.ClienteAtividade;
    LCalcularDescontoIcmsOrgaoPublico := AParametrosClienteConsumidor.CalcularDescontoIcmsOrgaoPublico;
    LClienteFisJur                    := AParametrosClienteConsumidor.ClienteFisicoOuJuridico;
    LCodigoDaEmpresaTransferencia     := AParametrosClienteConsumidor.CodigoDaEmpresaTransferencia;
  End;

  LClienteZonaFrancaComDescontoEspecial := (LZonaFranca And LZonaFrancaDesEsp);

  If LClienteZonaFrancaComDescontoEspecial Then
    LZonaFranca := False;

  LClienteExterior := LClienteEstado = 'EX';
  LAtoDeclaratorioDF := LRetornoCampoTabela.FieldByName('CLI_ATODDF').AsString = 'S';
  LClienteReducaoCargaLiquida := LRetornoCampoTabela.FieldByName('CLI_RECALI').AsString = 'S';
  LOrgaoPublicoForaDoEstado := LRetornoCampoTabela.FieldByName('CLI_ORGFDE').AsString = 'S';

  If not objCore.fEmptyStr(ACodigoDaFazenda) Then
    LClienteEstado := FClienteEstadoEntrega;

  Result :=
    TResultadoFaturamentoImpostosModelClienteFornecedor.New
      .Codigo(ACodigoDoCliente)
      .SituacaoDoIpi(LSituacaoDoIpi)
      .ZonaFranca(LZonaFranca)
      .OrgaoPublico(LOrgaoPublico)
      .OrgaoPublicoForaDoEstado(LOrgaoPublicoForaDoEstado)
      .ClienteExterior(LClienteExterior)
      .ClienteEstado(LClienteEstado)
      .ClienteEstadoEntrega(FClienteEstadoEntrega)
      .ClienteAtividade(LClienteAtividade)
      .ClienteRegraFiscal(LClienteRegraFiscal)
      .SomarIpiBaseIcms(LSomarIpiBaseIcms)
      .ClienteInscricaoEstadual(LClienteInscricao)
      .ClienteMicroEmpreendedor(LMicroEmpreendedor)
      .ValorIVAEspecialClienteMT(LValorIVAEspecialClienteMT)
      .ValorIVASimClienteMT(LValorIVASimClienteMT)
      .CalcularDescontoIcmsOrgaoPublico(LCalcularDescontoIcmsOrgaoPublico)
      .SujeitoPassivoSTRegimeEspecial(LSujeitoPassivoSTRegimeEspecial)
      .ReducaoDeBaseDeIcmsTributados(LReducaoDeBaseDeIcmsTributados)
      .UtilizarDiferimetoST(LUtilizarDiferimetoST)
      .TipoDeDescontoRateioDescEspecial(LTipoDeDescontoRateioDescEspecial)
      .ValorIVANacClienteMT(LValorIVANacClienteMT)
      .AplicarDescontoPisCofinsOrgaoPublico(LAplicarDescontoPisCofinsOrgaoPublico)
      .BeneficioREIDI(LBeneficioREIDI)
      .DeduzirIcmsDoBeneficioREIDI(LDeduzirIcmsDoBeneficioREIDI)
      .ValorAliquotaIRF(LValorAliquotaIRF)
      .ValorAliquotaPIS(LValorAliquotaPIS)
      .ValorAliquotaCOF(LValorAliquotaCOF)
      .ValorAliquotaCSL(LValorAliquotaCSL)
      .RetencaoDeIRPF(LRetencaoDeIRPF)
      .RetencaoDePisCofins(LRetencaoDePisCofins)
      .ClienteC_G_C_(LClienteC_G_C_)
      .ClienteFisJur(LClienteFisJur)
      .ConsumidorFinal(AClienteConsumidorFinal)
      .ClienteProdutorRural(LClienteProdutorRural)
      .ClienteNaoContribuinteDeIcms(LClienteNaoContribuinteDeIcms)
      .ClienteOrgaoPublicoDifal(LClienteOrgaoPublicoDifal)
      .ValorIVAEspecialClienteMTCedem(LValorIVAEspecialClienteMTCedem)
      .ValorIVASimClienteMTCedem(LValorIVASimClienteMTCedem)
      .ValorIVANacClienteMTCedem(LValorIVANacClienteMTCedem)
      .CodigoDaEmpresaTransferencia(LCodigoDaEmpresaTransferencia)
      .AtoDeclaratorioDF(LAtoDeclaratorioDF)
      .ClienteZonaFrancaComDescontoEspecial(LClienteZonaFrancaComDescontoEspecial)
      .ClienteReducaoCargaLiquida(LClienteReducaoCargaLiquida)
      .Suframa(LSuframa)
      .ClienteIbgeEntrega(LClienteIbgeEntrega);

end;


class function TFaturamentoImpostosModelCliente.New: IFaturamentoImpostosModelCliente;
begin
  Result := Self.Create;
end;

function TFaturamentoImpostosModelCliente.RetornarCampoCLI_CEDESP(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_CEDESP';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not objCore.fCampoExiste('CADCLI','CLI_CEDESP') then
    result := '0.00 AS CLI_CEDESP';
end;

function TFaturamentoImpostosModelCliente.RetornarCampoCLI_CEDNAC(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_CEDNAC';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not objCore.fCampoExiste('CADCLI','CLI_CEDNAC') then
    result := '0.00 AS CLI_CEDNAC';
end;

function TFaturamentoImpostosModelCliente.RetornarCampoCLI_CEDSIM(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_CEDSIM';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not objCore.fCampoExiste('CADCLI','CLI_CEDSIM') then
    result := '0.00 AS CLI_CEDSIM';
end;

function TFaturamentoImpostosModelCliente.RetornarCampoCLI_ICMREI(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_ICMREI';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not objCore.fCampoExiste('CADCLI','CLI_ICMREI') then
    result := '"N" AS CLI_ICMREI';
end;

function TFaturamentoImpostosModelCliente.RetornarCampoCLI_IVASIM(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_IVASIM';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not objCore.fCampoExiste('CADCLI','CLI_IVASIM') then
    result := '0 AS CLI_IVASIM';
end;

function TFaturamentoImpostosModelCliente.RetornarCampoCLI_ORPUDF(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_ORPUDF';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not objCore.fCampoExiste('CADCLI','CLI_ORPUDF') then
    result := '"N" AS CLI_ORPUDF';
end;

function TFaturamentoImpostosModelCliente.RetornarCampoCli_RECALI(
  const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_RECALI';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not objCore.fCampoExiste('CADCLI','CLI_RECALI') then
    result := '"N" AS CLI_RECALI';
end;

function TFaturamentoImpostosModelCliente.RetornarCampoCLI_SIBICM(const AGerandoCasosTestes: boolean): string;
begin
  result := 'CLI_SIBICM';

 {$IFNDEF LINUX}
  if (not AGerandoCasosTestes) then Exit;
 {$ENDIF}

  if not objCore.fCampoExiste('CADCLI','CLI_SIBICM') then
    result := '"S" AS CLI_SIBICM';
end;

function TFaturamentoImpostosModelCliente.RetornarInformacoesClienteConsumidor(
  const AParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor): Boolean;
begin
  Result := False;

  If (AParametrosClienteConsumidor = nil) Then
    Exit;

  Result := true;
end;

end.
