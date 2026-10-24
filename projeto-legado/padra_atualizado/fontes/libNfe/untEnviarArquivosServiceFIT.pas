unit untEnviarArquivosServiceFIT;

interface

uses untInterfaces, NfeApiWSBean, untUtil, SysUtils, untConfigNFE;

Type
  TEnviarArquivosServiceFIT = class(TInterfacedObject, IEnviarArquivosService)
    private
       fitWrapper: TWSNFeFitWrapper;
       objConfigSovos: TConfiguracoesNFE;
       function fEnviar(strArqXML: String; strModeEnvSoap: String='0'): TRetornoNFE;
    public
      constructor Create; overload;
      constructor Create(objConfigSovos: TConfiguracoesNFE); overload;
      destructor Destroy; override;
      function fEnviarXMLSat(strArqXML: String): TRetornoNFE;
      function fEnviarXMLSatWithModeSoap(strArqXML, strModeEnvSoap: String): TRetornoNFE;
  end;

implementation

uses
  untHttpTypes;

{ TEnviarArquivosServiceFIT }

function TEnviarArquivosServiceFIT.fEnviarXMLSat(strArqXML: String): TRetornoNFE;
begin
  Result := fEnviar(strArqXML);
end;

function TEnviarArquivosServiceFIT.fEnviarXMLSatWithModeSoap(strArqXML: String; strModeEnvSoap: String): TRetornoNFE;
begin
  Result := fEnviar(strArqXML, strModeEnvSoap);
end;

constructor TEnviarArquivosServiceFIT.Create;
begin
  inherited;
end;

constructor TEnviarArquivosServiceFIT.Create(objConfigSovos: TConfiguracoesNFE);
begin
  inherited Create;

  Self.objConfigSovos := objConfigSovos;
end;

destructor TEnviarArquivosServiceFIT.Destroy;
begin
  If Assigned(Self.fitWrapper) Then
    FreeAndNil(Self.fitWrapper);

  inherited;
end;

function TEnviarArquivosServiceFIT.fEnviar(strArqXML: String; strModeEnvSoap: String='0'): TRetornoNFE;
Var
  retornoFit: TWSNfeFitRetorno;
  strMensagem,
  strStatus: String;
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

  Try
    retornoFit := fitWrapper.fEnviaTextoIntegracaoSAT_XML(strArqXML);

    strMensagem := fGetValorLinha(retornoFit.Texto, '|', 3);
    strStatus   := fGetValorLinha(retornoFit.Texto, '|', 2);
    If strStatus = '1' Then
      Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, '', '', Now)
    Else If strStatus = '3' Then
      Result := TRetornoNFE.fCriaRetornoSucesso(strMensagem, '', '', Now)
    Else
      Result := TRetornoNFE.fCriaRetornoErro(strMensagem);
  Except
    On E: Exception Do
    Begin
      Result := TRetornoNFE.fCriaRetornoErro(E.Message);
    End;
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

end.
