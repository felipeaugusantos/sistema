unit Faturamento.Impostos.Regras.DadosFiscais.Aliquota;

interface

uses Faturamento.Impostos.Interfaces.DadosFiscais.Aliquota,
  Faturamento.Impostos.Tipos.DadosFiscais.Aliquota,
  Shared.Functions.Configuracoes, Shared.Functions.Constantes,
  Shared.Functions.Funcoes.Faturamento,
  System.SysUtils, System.StrUtils;

type
  TRegraImpostosDadosFiscaisAliquota = class(TInterfacedObject, IRegraImpostosDadosFiscaisAliquota)
  private
    FAliquotaIcm : Double;
    FSimplesNacional : Boolean;
    Function AliquotaDentroDoEstadoCfop(AParametros: IParametrosDadosFiscaisAliquota) : Double;

    Function ValidarClienteForaDoEstadoCFOPPertencenteAosEstadosDoSulSudeste(AParametros: IParametrosDadosFiscaisAliquota) : Boolean;
    Function ValidarEmpresaDentroDoEstadoCfopRioGrandoDoSulAlagoasPara(AParametros: IParametrosDadosFiscaisAliquota) : Boolean;
    Function ValidarEmpresaForaDoEstadoAlagoas(AParametros: IParametrosDadosFiscaisAliquota) : Boolean;
    Function ValidarAtividadeConstrutoraSemInscricaoEstadualForaDoEstadoCfop(AParametros: IParametrosDadosFiscaisAliquota) : Boolean;
    Function ValidarDocumentoDeVendaParaSimplesNacional(AParametros: IParametrosDadosFiscaisAliquota) : Boolean;

    Function RetornarEstadoDoAlagoas : String;
    Function RetornarEstadosSulESudeste : String;
    Function RetornarEstadosRioGrandeDoSulAlagoasPara: String;

    Function ZerarIcmParaDocumentoDeVendaSimplesNacionalComGravacaoLivroFiscal(AParametros: IParametrosDadosFiscaisAliquota) : Double;
    Function ZerarIcmParaGravacaoCupomFiscal(AParametros: IParametrosDadosFiscaisAliquota) : Boolean;
    Function ZerarIcmParaGravacaoNotaFiscal(AParametros: IParametrosDadosFiscaisAliquota) : Boolean;


  public
    function DadosFiscaisAliquotaDoItem(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota;

    class function New(): IRegraImpostosDadosFiscaisAliquota;
  end;

  function DadosFiscaisAliquotaDoItem(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota; stdcall;

implementation


function DadosFiscaisAliquotaDoItem(AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota; stdcall;
begin
  Result := TRegraImpostosDadosFiscaisAliquota.New.DadosFiscaisAliquotaDoItem(AParametros);
end;

{ TRegraImpostosDadosFiscaisClassificacaoItem }


function TRegraImpostosDadosFiscaisAliquota.AliquotaDentroDoEstadoCfop(
  AParametros: IParametrosDadosFiscaisAliquota): Double;
begin
  Result := 7;

  If Not AParametros.DentroDoEstadoCFOP Then
    Exit;

  Result := 18;

end;

function TRegraImpostosDadosFiscaisAliquota.ValidarEmpresaDentroDoEstadoCfopRioGrandoDoSulAlagoasPara(
  AParametros: IParametrosDadosFiscaisAliquota): Boolean;
begin
  Result := false;

  If Not AParametros.DentroDoEstadoCFOP Then
    Exit;

  If Not TFunctionFuncoesFaturamento.LocalizarEstado(AParametros.EmpresaEstado, RetornarEstadosRioGrandeDoSulAlagoasPara) Then
    Exit;

  Result := true;
end;

function TRegraImpostosDadosFiscaisAliquota.ValidarEmpresaForaDoEstadoAlagoas(
  AParametros: IParametrosDadosFiscaisAliquota): Boolean;
begin

  Result := False;

  If AParametros.DentroDoEstadoCFOP Then
    Exit;

  If Not TFunctionFuncoesFaturamento.LocalizarEstado(AParametros.EmpresaEstado, RetornarEstadoDoAlagoas) Then
    Exit;

  Result := True;
end;

function TRegraImpostosDadosFiscaisAliquota.ZerarIcmParaDocumentoDeVendaSimplesNacionalComGravacaoLivroFiscal(
  AParametros: IParametrosDadosFiscaisAliquota): Double;
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

function TRegraImpostosDadosFiscaisAliquota.ZerarIcmParaGravacaoCupomFiscal(
  AParametros: IParametrosDadosFiscaisAliquota): Boolean;
begin
  Result := False;

  If Not TFunctionFuncoesFaturamento.LocalizarOpcaoDeDocumento(AParametros.EspecieDocumento,CUPOM_FISCAL) Then
    Exit;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_CUPOM_NFE_SAT, varBoolean) Then
    Exit;

  Result := True;
end;

function TRegraImpostosDadosFiscaisAliquota.ZerarIcmParaGravacaoNotaFiscal(
  AParametros: IParametrosDadosFiscaisAliquota): Boolean;
begin
  Result := False;

  If TFunctionFuncoesFaturamento.LocalizarOpcaoDeDocumento(AParametros.EspecieDocumento,CUPOM_FISCAL) Then
    Exit;

  If Not objConfiguracoes.fGetValorConfiguracao(CFG_ZERAR_BASE_E_ALIQUOTA_ICMS_GRAVACAO_LIVRO_FISCAL_NOTA_FISCAL, varBoolean) Then
    Exit;

  Result := true;
end;

function TRegraImpostosDadosFiscaisAliquota.DadosFiscaisAliquotaDoItem(
  AParametros: IParametrosDadosFiscaisAliquota): IResultadoDadosFiscaisAliquota;
begin
  FAliquotaIcm     := AliquotaDentroDoEstadoCfop(AParametros);
  FSimplesNacional := (objConfiguracoes.fGetValorConfiguracao(CFG_EMPRESA_SIMPLES_NACIONAL) = 'S');


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
    FAliquotaIcm := objConfiguracoes.fGetValorConfiguracao(CFG_PERCENTUAL_ICMS_SIMPLES_NACIONAL, varDouble) ;

  FAliquotaIcm := ZerarIcmParaDocumentoDeVendaSimplesNacionalComGravacaoLivroFiscal(AParametros);


  Result :=
    TResultadodadosFiscaisAliquota.New
     .AliquotaIcm(FAliquotaIcm);
end;

class function TRegraImpostosDadosFiscaisAliquota.New: IRegraImpostosDadosFiscaisAliquota;
begin
  Result := Self.Create;
end;


 function TRegraImpostosDadosFiscaisAliquota.RetornarEstadoDoAlagoas: String;
begin
  Result := ALAGOAS;
end;

function TRegraImpostosDadosFiscaisAliquota.RetornarEstadosRioGrandeDoSulAlagoasPara: String;
begin
  Result := '';
  Result := Result + RIO_GRANDE_DO_SUL + '_';
  Result := Result + PARA + '_';
  Result := Result + ALAGOAS + '_';

end;

function TRegraImpostosDadosFiscaisAliquota.RetornarEstadosSulESudeste: String;
begin
  Result := '';
  Result := Result + RIO_GRANDE_DO_SUL + '_';
  Result := Result + SANTA_CATARINA + '_';
  Result := Result + PARANA + '_';
  Result := Result + SAO_PAULO + '_';
  Result := Result + MINAS_GERAIS + '_';
  Result := Result + RIO_DE_JANEIRO + '_';
end;

function TRegraImpostosDadosFiscaisAliquota.ValidarAtividadeConstrutoraSemInscricaoEstadualForaDoEstadoCfop(
  AParametros: IParametrosDadosFiscaisAliquota): Boolean;
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

function TRegraImpostosDadosFiscaisAliquota.ValidarClienteForaDoEstadoCFOPPertencenteAosEstadosDoSulSudeste(
  AParametros: IParametrosDadosFiscaisAliquota): Boolean;
begin
  Result := False;

  If AParametros.DentroDoEstadoCFOP then
    Exit;

  If ( Pos(AParametros.ClienteEstado, RetornarEstadosSulESudeste) > 0 ) Then
    Result := true;
end;

function TRegraImpostosDadosFiscaisAliquota.ValidarDocumentoDeVendaParaSimplesNacional(
  AParametros: IParametrosDadosFiscaisAliquota): Boolean;
begin
  Result := False;

  If Not (FSimplesNacional) Then
    Exit;

  If Not (AParametros.DocumentoDeVenda) Then
    Exit;

  Result := True;
end;

exports DadosFiscaisAliquotaDoItem;

end.
