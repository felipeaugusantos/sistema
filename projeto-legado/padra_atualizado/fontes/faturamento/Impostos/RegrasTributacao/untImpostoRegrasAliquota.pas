unit untImpostoRegrasAliquota;

interface

uses Faturamento.Impostos.Interfaces.DadosFiscais.Aliquota,
  untTypesGenericosImpostos, Shared.Functions.Funcoes.Faturamento,
  Shared.Functions.Configuracoes;

type
  TImpostoRegrasAliquota = class(TInterfacedObject, IRegraImpostosDadosFiscaisAliquota, IImpostoRegrasAliquota) // TRegraImpostosDadosFiscaisAliquota
  private
    FConfiguracoes: IConfiguracoes;
    FAliquotaIcm : Double;
    FSimplesNacional : Boolean;
    Function AliquotaDentroDoEstadoCfop(AParametros: TParametrosDadosFiscaisAliquota) : Double;

    Function ValidarClienteForaDoEstadoCFOPPertencenteAosEstadosDoSulSudeste(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
    Function ValidarEmpresaDentroDoEstadoCfopRioGrandoDoSulAlagoasPara(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
    function ValidarEmpresaForaDoEstadoAlagoas(AParametros: TParametrosDadosFiscaisAliquota): Boolean;
    function ValidarAtividadeConstrutoraSemInscricaoEstadualForaDoEstadoCfop(AParametros: TParametrosDadosFiscaisAliquota): Boolean;
    Function ValidarDocumentoDeVendaParaSimplesNacional(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;

    Function RetornarEstadoDoAlagoas : String;
    Function RetornarEstadosSulESudeste : String;
    Function RetornarEstadosRioGrandeDoSulAlagoasPara: String;

    Function ZerarIcmParaDocumentoDeVendaSimplesNacionalComGravacaoLivroFiscal(AParametros: TParametrosDadosFiscaisAliquota) : Double;
    Function ZerarIcmParaGravacaoCupomFiscal(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
    Function ZerarIcmParaGravacaoNotaFiscal(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
    function DadosFiscaisAliquotaDoItem(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota; overload;
  public
    function DadosFiscaisAliquotaDoItem(AParametros: TParametrosDadosFiscaisAliquota): TResultadoDadosFiscaisAliquota; overload;
    class function New(AConfiguracoes: IConfiguracoes): IImpostoRegrasAliquota;
    constructor Create(AConfiguracoes: IConfiguracoes);
  end;

implementation

uses Shared.Functions.Constantes, SysUtils;

{ TImpostoRegrasAliquota }

function TImpostoRegrasAliquota.AliquotaDentroDoEstadoCfop(
  AParametros: TParametrosDadosFiscaisAliquota): Double;
begin
  Result := 7;

  If Not AParametros.DentroDoEstadoCFOP Then
    Exit;

  Result := 18;
end;

Function TImpostoRegrasAliquota.ValidarEmpresaDentroDoEstadoCfopRioGrandoDoSulAlagoasPara(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
begin
  Result := false;

  If Not AParametros.DentroDoEstadoCFOP Then
    Exit;

  If Not TFunctionFuncoesFaturamento.LocalizarEstado(AParametros.EmpresaEstado, RetornarEstadosRioGrandeDoSulAlagoasPara) Then
    Exit;

  Result := true;
end;

function TImpostoRegrasAliquota.ValidarEmpresaForaDoEstadoAlagoas(
  AParametros: TParametrosDadosFiscaisAliquota): Boolean;
begin

  Result := False;

  If AParametros.DentroDoEstadoCFOP Then
    Exit;

  If Not TFunctionFuncoesFaturamento.LocalizarEstado(AParametros.EmpresaEstado, RetornarEstadoDoAlagoas) Then
    Exit;

  Result := True;
end;

Function TImpostoRegrasAliquota.ZerarIcmParaDocumentoDeVendaSimplesNacionalComGravacaoLivroFiscal(AParametros: TParametrosDadosFiscaisAliquota) : Double;
begin
  Result := FAliquotaIcm;

  If Not(FSimplesNacional) Then
    Exit;

  If Not(AParametros.DocumentoDeVenda)Then
    Exit;

  Result := 0;

  If ZerarIcmParaGravacaoNotaFiscal(AParametros) Then
    Exit;

  If ZerarIcmParaGravacaoCupomFiscal(AParametros) Then
    Exit;

  Result := FAliquotaIcm;
end;

Function TImpostoRegrasAliquota.ZerarIcmParaGravacaoCupomFiscal(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
begin
  Result := False;

  If Not TFunctionFuncoesFaturamento.LocalizarOpcaoDeDocumento(AParametros.EspecieDocumento,CUPOM_FISCAL) Then
    Exit;

  If Not FConfiguracoes.fGetValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, varBoolean) Then
    Exit;

  Result := True;
end;

Function TImpostoRegrasAliquota.ZerarIcmParaGravacaoNotaFiscal(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
begin
  Result := False;

  If TFunctionFuncoesFaturamento.LocalizarOpcaoDeDocumento(AParametros.EspecieDocumento,CUPOM_FISCAL) Then
    Exit;

  If Not FConfiguracoes.fGetValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, varBoolean) Then
    Exit;

  Result := true;
end;

function TImpostoRegrasAliquota.DadosFiscaisAliquotaDoItem(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota;
begin
  raise Exception.Create('DadosFiscaisAliquotaDoItem Chamada de Forma Incorreta!');
end;

constructor TImpostoRegrasAliquota.Create(AConfiguracoes: IConfiguracoes);
begin
  FConfiguracoes := AConfiguracoes;
end;

function TImpostoRegrasAliquota.DadosFiscaisAliquotaDoItem(AParametros: TParametrosDadosFiscaisAliquota): TResultadoDadosFiscaisAliquota;
begin
  FAliquotaIcm     := AliquotaDentroDoEstadoCfop(AParametros);
  FSimplesNacional := (FConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL) = 'S');

  If ValidarClienteForaDoEstadoCFOPPertencenteAosEstadosDoSulSudeste(AParametros) Then
    FAliquotaIcm := 12;

  If ValidarEmpresaDentroDoEstadoCfopRioGrandoDoSulAlagoasPara(AParametros) Then
    FAliquotaIcm  := 17;

  If ValidarEmpresaForaDoEstadoAlagoas(AParametros) Then
    FAliquotaIcm := 12;

  If ValidarAtividadeConstrutoraSemInscricaoEstadualForaDoEstadoCfop(AParametros) Then
  begin
    FAliquotaIcm := 18;

    If TFunctionFuncoesFaturamento.LocalizarEstado(AParametros.EmpresaEstado, RetornarEstadosRioGrandeDoSulAlagoasPara) Then
      FAliquotaIcm := 17;
  end;

  If ValidarDocumentoDeVendaParaSimplesNacional(AParametros) Then
    FAliquotaIcm := FConfiguracoes.fGetValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, varDouble) ;

  FAliquotaIcm := ZerarIcmParaDocumentoDeVendaSimplesNacionalComGravacaoLivroFiscal(AParametros);

  FillChar(Result, SizeOf(Result), #0);
  Result.AliquotaIcm := FAliquotaIcm;
end;

class function TImpostoRegrasAliquota.New(AConfiguracoes: IConfiguracoes): IImpostoRegrasAliquota;
begin
  Result := Self.Create(AConfiguracoes);
end;

function TImpostoRegrasAliquota.RetornarEstadoDoAlagoas: String;
begin
  Result := ALAGOAS;
end;

function TImpostoRegrasAliquota.RetornarEstadosRioGrandeDoSulAlagoasPara: String;
begin
  Result := '';
  Result := Result + RIO_GRANDE_DO_SUL + '_';
  Result := Result + PARA + '_';
  Result := Result + ALAGOAS + '_';
end;

function TImpostoRegrasAliquota.RetornarEstadosSulESudeste: String;
begin
  Result := '';
  Result := Result + RIO_GRANDE_DO_SUL + '_';
  Result := Result + SANTA_CATARINA + '_';
  Result := Result + PARANA + '_';
  Result := Result + SAO_PAULO + '_';
  Result := Result + MINAS_GERAIS + '_';
  Result := Result + RIO_DE_JANEIRO + '_';
end;

function TImpostoRegrasAliquota.ValidarAtividadeConstrutoraSemInscricaoEstadualForaDoEstadoCfop(AParametros: TParametrosDadosFiscaisAliquota): Boolean;
begin
  Result := False;

  If AParametros.DentroDoEstadoCFOP Then
    Exit;

  Result := true;

  If AParametros.AtividadeConstrutora Then
    Exit;

  Result := False;

  If Not (AParametros.InscricaoEstadual = EmptyStr) Then
    Exit;

  If AParametros.MicroEmpreendedor Then
    Exit;

  Result := true;
end;

Function TImpostoRegrasAliquota.ValidarClienteForaDoEstadoCFOPPertencenteAosEstadosDoSulSudeste(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
begin
  Result := False;

  If AParametros.DentroDoEstadoCFOP then
    Exit;

  If ( Pos(AParametros.ClienteEstado, RetornarEstadosSulESudeste) > 0 ) Then
    Result := true;
end;

Function TImpostoRegrasAliquota.ValidarDocumentoDeVendaParaSimplesNacional(AParametros: TParametrosDadosFiscaisAliquota) : Boolean;
begin
  Result := False;

  If Not (FSimplesNacional) Then
    Exit;

  If Not (AParametros.DocumentoDeVenda) Then
    Exit;

  Result := True;
end;

end.
