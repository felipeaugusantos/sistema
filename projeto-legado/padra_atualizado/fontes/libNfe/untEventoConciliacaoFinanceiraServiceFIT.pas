unit untEventoConciliacaoFinanceiraServiceFIT;

interface

uses untInterfaces, NfeApiWSBean, untUtil, SysUtils, untConfigNFE;

Type
  TEventoConciliacaoFinanceiraServiceFIT = class(TInterfacedObject, IEventoConciliacaoFinanceiraService)
    private
       fitWrapper: TWSNFeFitWrapper;
       objConfigSovos: TConfiguracoesNFE;
       FModeEnvSoap: String;
       procedure pCriaFitWrapper;
    public
      constructor Create; overload;
      constructor Create(objConfigSovos: TConfiguracoesNFE; strModeEnvSoap: String); overload;
      destructor Destroy; override;
      function fEnviaTextoIntegracaoEventoDFe(strDadosIntegracao: String): string;
  end;

implementation

uses
  untHttpTypes;

{ TEventoConciliacaoFinanceiraServiceFIT }

constructor TEventoConciliacaoFinanceiraServiceFIT.Create;
begin
  inherited;
end;

constructor TEventoConciliacaoFinanceiraServiceFIT.Create(objConfigSovos: TConfiguracoesNFE; strModeEnvSoap: String);
begin
  inherited Create;

  Self.objConfigSovos := objConfigSovos;
  Self.FModeEnvSoap   := strModeEnvSoap;
end;

destructor TEventoConciliacaoFinanceiraServiceFIT.Destroy;
begin
  If Assigned(Self.fitWrapper) Then
    FreeAndNil(Self.fitWrapper);

  inherited;
end;

procedure TEventoConciliacaoFinanceiraServiceFIT.pCriaFitWrapper;
begin
  If (Not Assigned(Self.fitWrapper)) Then
  Begin
    Self.fitWrapper := TWSNFeFitWrapper.Create;
    Self.fitWrapper.modeEnvSoap  := fGetModeEnvSoap(FModeEnvSoap);

    If Assigned(objConfigSovos) Then
    Begin
      untUtil.objConfig.strFitUrlWebService := objConfigSovos.strFitUrlWebService;
      untUtil.objConfig.strFitLicenca := objConfigSovos.strFitLicenca;
      untUtil.objConfig.strFitUsuario := objConfigSovos.strFitUsuario;
      untUtil.objConfig.strFitSenha := objConfigSovos.strFitSenha;
    End;
  End;
end;

function TEventoConciliacaoFinanceiraServiceFIT.fEnviaTextoIntegracaoEventoDFe(strDadosIntegracao: String): string;
begin
  Result := '';

  pCriaFitWrapper;

  Result := fitWrapper.fEnviaTextoIntegracaoEventoDFe(strDadosIntegracao);
end;

end.
