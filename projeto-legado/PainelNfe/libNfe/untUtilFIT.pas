unit untUtilFIT;

interface

uses
{$IFDEF LINUX}
{$ELSE}
  Forms, Windows,
{$ENDIF}
  SysUtils, untInterfaces, NfeApiWSBean, Classes, Types, untConfigNFE;

Type
  INFEFit = Interface
    function fNotaAindaAutorizadaNaFit(strNumDoc, strSerie, strCodEmp: String): Boolean;
  End;

Type
  TVerificarStatusServicoService = class(TInterfacedObject, IVerificarStatusServicoService)
    private
       fitWrapper: TWSNFeFitWrapper;
       objConfigSovos: TConfiguracoesNFE;
    public
      constructor Create; overload;
      constructor Create(objConfigSovos: TConfiguracoesNFE); overload;
      destructor Destroy; override;
      function fVerificarStatusServicoPelaUF(const strUF: string; var strRetornoConsulta: string; strModeEnvSoap: String='0'): TRetornoStatusNFE;
  end;

Type
  TAmbienteEmpresa = class(TInterfacedObject, IAmbienteEmpresaService)
    private
      FCNPJ,
      FModelo,
      FModeEnvSoap: String;
      objConfigSovos: TConfiguracoesNFE;
      fitWrapper: TWSNFeFitWrapper;
      procedure pCriaFitWrapper;
    public
      constructor Create(AobjConfigSovos: TConfiguracoesNFE; AstrCNPJ: String; AstrModeEnvSoap: String='0'; AstrModelo: String = '55'); overload;
      destructor Destroy; override;
      function fCodigoEmpresaNaFit: string;
  end;

function fVerificarStatusServicoFIT(fonteDados: IFonteDados; fitWrapper: TWSNFeFitWrapper; strCnpjEmitente, strIESEmitente: string; var strRetornoConsulta: string; strUF: string=''): TRetornoStatusNFE; overload;
function fVerificarStatusServicoFIT(fitWrapper: TWSNFeFitWrapper; strUF: string; var strRetornoConsulta: string): TRetornoStatusNFE; overload;
function fEnviaCancelamentoFIT(strNumDoc, strSerie, strCodEmp, strChaveAcesso, strMotivo: String;
  nfe: INFEFIt; fitWrapper: TWSNFeFitWrapper; strComando: String=''; strSufixo: String='NFE_FIT'): Boolean;
function fConsultaCadastro(fitWrapper: TWSNFeFitWrapper; strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
function fNFCeOffLineAssinador(strPathNFCe, strArqNFCe, strFitOffLineLicenca, strFitOffLineCertJKS, strFitOffLineCertSenha,
                               strFitOffLineIdToken, strFitOffLineNroToken, strFitAmbiente, strTimeZone: String; var strTexto: String;
                               var strXmlOffLine: String; var strChaveAcessoOffLine: String): Boolean;

implementation

uses untUtil, untConstantesNFe, untDicSis;

function fVerificarStatusServicoFIT(fonteDados: IFonteDados; fitWrapper: TWSNFeFitWrapper; strCnpjEmitente, strIESEmitente: String; var strRetornoConsulta: string; strUF: string=''): TRetornoStatusNFE;
  Var
    retornoFit: TWSNfeFitRetorno;
    intCodigoRetorno: Integer;
    strEstado: String;
    strTipoEmissao: String;

  function fParseTipoEmissao(const resultFunc: TRetornoStatusNFE): string;
  begin
    Case resultFunc Of
      rsDPEC                     : Result := 'rsDPEC';
      rsErroGeral                : Result := 'rsErroGeral';
      rsOperacional              : Result := 'rsOperacional';
      rsParalisadoMomentaneamente: Result := 'rsParalisadoMomentaneamente';
      rsParalisadoSemPrevisao    : Result := 'rsParalisadoSemPrevisao';
    End;
  end;

begin
  Result := rsOperacional;

  retornoFit := Nil;
  pLogImp('fVerificarStatusServicoFIT > [CHAMADA POR: '+ParamStr(0)+']');
  Try
    Try
      If (strUF<>'') Then
        strEstado := strUF
      Else
        strEstado := fonteDados.fRetornaEstadoEmpresa(strCnpjEmitente);

      {**************************************************************************************************}
      {* Retorno chamado FIT #38305 - Erro ao Consultar Status Servico MG.                              *}
      {* A SEFAZ de Minas Gerais vem passando por repetidos eventos de instabilidade nos últimos meses, *}
      {* causando efeitos colaterais em nosso produto e que não enfrentamos com outras SEFAZ.           *}
      {* Dessa forma desativamos o serviço via WebService para Consultar Status Sefaz de Minas Gerais.  *}
      {***********************************************************************************************BZ*}
      If (strEstado = 'MG') Then
        Exit;

      retornoFit := fitWrapper.fEnviaTextoIntegracao(strEstado, '', 'FIT_NFE_CONSULTA_STATUS_SERVICO');
      intCodigoRetorno := StrToIntDef(fGetValorLinha(retornoFit.Texto, '|', 5), -1);
      strTipoEmissao := fGetValorLinha(retornoFit.Texto, '|', 8);
      strRetornoConsulta := retornoFit.Texto;

      If (strTipoEmissao = '4') Then
      Begin
        Result := rsDPEC;
      End
      Else
      Begin
        Case intCodigoRetorno Of
           -1: Result := rsErroGeral;
          107: Result := rsOperacional;
          108: Result := rsParalisadoMomentaneamente;
          109: Result := rsParalisadoSemPrevisao;
          Else Result := rsErroGeral;
        End;
      End;

      If Assigned(retornoFit) Then
        FreeAndNil(retornoFit);
    Except
      On E: Exception Do
      Begin
        pLogImp('fVerificarStatusServicoFIT < Exception('+E.Message+')');
      End;
    End
  Finally
    If Assigned(retornoFit) Then
      FreeAndNil(retornoFit);

    pLogImp('fVerificarStatusServicoFIT < Result = ('+fParseTipoEmissao(Result)+') retornoFit = ' + strRetornoConsulta);
  End;
end;

function fVerificarStatusServicoFIT(fitWrapper: TWSNFeFitWrapper; strUF: string; var strRetornoConsulta: String): TRetornoStatusNFE; overload;
begin
  Result := fVerificarStatusServicoFIT(Nil, fitWrapper, '', '', strRetornoConsulta, strUF);
end;

function fEnviaCancelamentoFit(strNumDoc, strSerie, strCodEmp, strChaveAcesso, strMotivo: String;
  nfe: INFEFIt; fitWrapper: TWSNFeFitWrapper; strComando: String=''; strSufixo: String='NFE_FIT'): Boolean;
  Var
    retornoFit: TWSNfeFitRetorno;
    strTexto: String;
    stlArquivo: TStringList;
begin

  If nfe.fNotaAindaAutorizadaNaFit(strNumDoc, strSerie, strCodEmp) Then
  Begin
    strTexto := 'NFE-CANC|' +
                 strCodEmp+fStrZero(strNumDoc,9)+strSerie + '|' +
                 strChaveAcesso + '|' +
                 strMotivo + '|' +
                 '|';

    retornoFit := fitWrapper.fEnviaTextoIntegracao(strTexto, strSufixo, strComando, 8);

    stlArquivo := TStringList.Create;
    Try
      stlArquivo.Add(strTexto);
      Try
        stlArquivo.SaveToFile(fPnlDir('ULTIMO_CANCELAMENTO.TXT'));
      Except

      End;
    Finally
      FreeAndNil(stlArquivo);
    End;

    Result := retornoFit.RetornoOk;

    If Not Result Then
    Begin
      pGrvArqTxt('CANC_' + strNumDoc + '_' + strSerie + '_' + strCodEmp, retornoFit.Texto);

      If fEmptyStr(fGetValorLinha(retornoFit.Texto, '|', 11)) Then
        strTexto := 'Erro: ' + fGetValorLinha(retornoFit.Texto, '|', 10)
      Else
        strTexto := 'Erro: ' + fGetValorLinha(retornoFit.Texto, '|', 11);

      Raise ErrosValidacaoNFE.fCriaErroSimples(strTexto);
    End;
  End
  Else
  Begin
    Result := True;
    pGrvArqTxt('CANC_' + strNumDoc + '_' + strSerie + '_' + strCodEmp, 'Nota já estava cancelada na fit.');
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function fConsultaCadastro(fitWrapper: TWSNFeFitWrapper; strUf, strCnpj, strIe: String): TRetornoConsultaCadastro;
  Var
    retornoFit: TWSNfeFitRetorno;
    strDados, strErro: String;
    intStatusOk: TIntegerDynArray;

  function fParseResultado(strRetorno: String):TRetornoConsultaCadastro;
  begin
    Result := TRetornoConsultaCadastro.Create();
    Result.strRazaoSocial  := fGetValorLinha(strRetorno, '|', 1);
    Result.strNomeFantasia := fGetValorLinha(strRetorno, '|', 2);
    Result.strIE           := fGetValorLinha(strRetorno, '|', 3);
    Result.strEndereco     := fGetValorLinha(strRetorno, '|', 4);
    Result.strNumero       := fGetValorLinha(strRetorno, '|', 5);
    Result.strComplemento  := fGetValorLinha(strRetorno, '|', 6);
    Result.strBairro       := fGetValorLinha(strRetorno, '|', 7);
    Result.strCEP          := fGetValorLinha(strRetorno, '|', 8);
    Result.strCodCidade    := fGetValorLinha(strRetorno, '|', 9);
    Result.strDescSituacao := fGetValorLinha(strRetorno, '|', 11);
    Result.strDescSituacao2 := fGetValorLinha(strRetorno, '|', 12);
    Result.strDescSituacao3 := fGetValorLinha(strRetorno, '|', 13);
    Result.blnHabilitado   := fGetValorLinha(strRetorno, '|', 14) = '1';
    Result.strCpfCnpj      := fPadL(fGetValorLinha(strRetorno, '|', 19), 14, '0');
    Result.strCnae         := fGetValorLinha(strRetorno, '|', 21);
  end;

begin

//  SetLength(intStatusOk, 2);
//  intStatusOk[0] := 111;
//  intStatusOk[1] := 112;

  SetLength(intStatusOk, 1);
  intStatusOk[0] := 111;

  strDados := 'NFE-CONS-CAD|' + strUf + '|' + strCnpj + '|' + strIe;
  retornoFit := fitWrapper.fEnviaTextoIntegracao(strDados, '', 'FIT_NFE_CONSULTA_CADASTRO', 17, intStatusOk);
  if retornoFit.RetornoOk then
    Result := fParseResultado(retornoFit.Texto)
  else
  begin
    If Pos('|', retornoFit.Texto) > 0 Then
      If fGetValorLinha(retornoFit.Texto, '|', 1) = 'NFE-ERRO' Then
        strErro := fGetValorLinha(retornoFit.Texto, '|', 2)
      Else
        strErro := fGetValorLinha(retornoFit.Texto, '|', 18)
    Else
      strErro := retornoFit.Texto;

    if fEmptyStr(strErro) then
      if fEmptyStr(retornoFit.Texto) then
        raise ErroConsultaCadastro.Create('Nenhuma informação recebida')
      else
        Result := fParseResultado(retornoFit.Texto)
    else
      raise ErroConsultaCadastro.Create(strErro);
  end;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

function fNFCeOffLineAssinador(strPathNFCe, strArqNFCe, strFitOffLineLicenca, strFitOffLineCertJKS, strFitOffLineCertSenha,
                               strFitOffLineIdToken, strFitOffLineNroToken, strFitAmbiente, strTimeZone: String;
                               var strTexto: String; var strXmlOffLine: String; var strChaveAcessoOffLine: String): Boolean;
var
 strFitAssinador: String;
 strArqNFCeAssinado: String;
 strArqNFCeRetorno: String;
 strComando: String;
 stlResult: TStringList;
 stlXmlOffLine: TStringList;

Begin
  Try
    strArqNFCe         := strPathNFCe + PATH_SEPARATOR + strArqNFCe;
    strFitAssinador    := strPathNFCe + PATH_SEPARATOR + 'assinador.jar';
    strArqNFCeAssinado := strPathNFCe + PATH_SEPARATOR + strFitOffLineLicenca+'.XML';
    strArqNFCeRetorno  := strArqNFCeAssinado + '_RETORNO.TXT';

    strComando := strPathNFCe + PATH_SEPARATOR + 'Java'+ PATH_SEPARATOR + 'jre32' + PATH_SEPARATOR + 'bin' + PATH_SEPARATOR + 'java.exe -jar ' + strPathNFCe + PATH_SEPARATOR + 'assinador.jar ASSINAR ' +
                                                                 strArqNFCe             + ' ' +
                                                                 strArqNFCeAssinado     + ' ' +
                                                                 strFitOffLineCertJKS   + ' ' +
                                                                 strFitOffLineCertSenha + ' ' +
                                                                 strFitOffLineLicenca   + ' ' +
                                                                 strFitOffLineIdToken   + ' ' +
                                                                 strFitOffLineNroToken  + ' ' +
                                                                 strFitAmbiente         + ' ' +
                                                                 strTimeZone;

    If FileExists(strFitAssinador) And FileExists(strArqNFCe) Then
    Begin
      Try
       {$IFDEF LINUX}
        raise Exception.Create('ShellExecuteAndWait não possui implementação linux');
       {$ELSE}
        ShellExecuteAndWait('', 'cmd.exe', PWideChar('/C ' + strComando + ' > ULTIMA_NFCE_OFFLINE.LOG'), PWideChar(strPathNFCe), SW_HIDE, True);
       {$ENDIF}
        Sleep(500);
        Result := FileExists(strArqNFCeRetorno);

        If Result Then
        Begin
          Try
            stlResult := TStringList.Create;
            stlResult.LoadFromFile(strArqNFCeRetorno);
            Result    := (fGetValorLinha(stlResult.Text , '|', 8) <> '4');
            strTexto  := stlResult.Text;

            If Result Then
            Begin
              Try
                strChaveAcessoOffLine := fGetValorLinha(stlResult.Text , '|', 7);

                stlXmlOffLine := TStringList.Create;
                stlXmlOffLine.LoadFromFile(strArqNFCeAssinado);
                strXmlOffLine := stlXmlOffLine.Text;
              Finally
                FreeAndNil(stlXmlOffLine);
              End;
            End;
          Finally
            FreeAndNil(stlResult);
            Sleep(500);
           {$IFDEF LINUX}
            raise Exception.Create('ShellExecuteAndWait não possui implementação linux');
           {$ELSE}
            ShellExecuteAndWait('', 'cmd.exe', PChar('/C del *.txt'), PChar(strPathNFCe), SW_HIDE, True);
            ShellExecuteAndWait('', 'cmd.exe', PChar('/C del *.xml'), PChar(strPathNFCe), SW_HIDE, True);
           {$ENDIF}
          End;
        End
        Else
        Begin
          stlResult := TStringList.Create;
          Try
            stlResult.Text := strComando;
            stlResult.SaveToFile('ASSINADOR_ERRO.TXT');
          Finally
            FreeAndNil(stlResult);
          End;
        End;
      Except
        Result := False;
      End;
    End
    Else
      Result := False;
  Except
    Result := False;
  End;
End;

{ TVerificarStatusServicoService }

constructor TVerificarStatusServicoService.Create;
begin
  inherited;
end;

constructor TVerificarStatusServicoService.Create(
  objConfigSovos: TConfiguracoesNFE);
begin
  inherited Create;

  Self.objConfigSovos := objConfigSovos;
end;

destructor TVerificarStatusServicoService.Destroy;
begin
  If Assigned(Self.fitWrapper) Then
    FreeAndNil(Self.fitWrapper);

  inherited;
end;

function TVerificarStatusServicoService.fVerificarStatusServicoPelaUF(const strUF: string; var strRetornoConsulta: string; strModeEnvSoap: String='0'): TRetornoStatusNFE;
begin
  If (Not Assigned(Self.fitWrapper)) Then
  Begin
    Self.fitWrapper := TWSNFeFitWrapper.Create;
    Self.fitWrapper.modeEnvSoap := fGetModeEnvSoap(strModeEnvSoap);
    If Assigned(objConfigSovos) Then
    Begin
      untUtil.objConfig.strFitUrlWebService := objConfigSovos.strFitUrlWebService;
      untUtil.objConfig.strFitLicenca := objConfigSovos.strFitLicenca;
      untUtil.objConfig.strFitUsuario := objConfigSovos.strFitUsuario;
      untUtil.objConfig.strFitSenha := objConfigSovos.strFitSenha;
    End;
  End;

  Result := fVerificarStatusServicoFIT(Self.fitWrapper, strUF, strRetornoConsulta);
end;

{ TAmbienteEmpresa }

{
SERVICO "FIT_NFE_DADOS_AMBIENTE_EMPRESA"
  PARAM..: CNPJ | MODELO
  RETORNO: CNPJ | RAZÃO SOCIAL | NOME FANTASIA | CÓD. MODELO | AMBIENTE | TIPO EMISSÃO | VERSÃO | LICENÇA | ID PARCEIRO | ID EMPRESA |
}

constructor TAmbienteEmpresa.Create(AobjConfigSovos: TConfiguracoesNFE; AstrCNPJ: String; AstrModeEnvSoap: String='0'; AstrModelo: String = '55');
begin
  inherited Create;

  Self.objConfigSovos := AobjConfigSovos;
  Self.FCNPJ          := AstrCNPJ;
  Self.FModeEnvSoap   := AstrModeEnvSoap;
  Self.FModelo        := AstrModelo;
end;

destructor TAmbienteEmpresa.Destroy;
begin
  If Assigned(Self.fitWrapper) Then
    FreeAndNil(Self.fitWrapper);

  inherited;
end;

function TAmbienteEmpresa.fCodigoEmpresaNaFit: string;
  Var
    retornoFit: TWSNfeFitRetorno;
    intStatusOk: TIntegerDynArray;
begin
  pCriaFitWrapper;

  SetLength(intStatusOk, 1);
  intStatusOk[0] := StrToInt(FModelo);

  retornoFit := Self.fitWrapper.fEnviaTextoIntegracao(FCNPJ + '|' + FModelo, '',
    'FIT_NFE_DADOS_AMBIENTE_EMPRESA', 4, intStatusOk);

  If retornoFit.RetornoOk Then
    Result := fGetValorLinha(retornoFit.Texto, '|', 10);

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

procedure TAmbienteEmpresa.pCriaFitWrapper;
begin
  If (Not Assigned(Self.fitWrapper)) Then
  Begin
    Self.fitWrapper := TWSNFeFitWrapper.Create;
    Self.fitWrapper.modeEnvSoap := fGetModeEnvSoap(FModeEnvSoap);
    If Assigned(objConfigSovos) Then
    Begin
      untUtil.objConfig.strFitUrlWebService := objConfigSovos.strFitUrlWebService;
      untUtil.objConfig.strFitLicenca := objConfigSovos.strFitLicenca;
      untUtil.objConfig.strFitUsuario := objConfigSovos.strFitUsuario;
      untUtil.objConfig.strFitSenha := objConfigSovos.strFitSenha;
    End;
  End;
end;

end.
