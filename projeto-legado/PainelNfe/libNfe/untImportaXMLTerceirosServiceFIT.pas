unit untImportaXMLTerceirosServiceFIT;

interface

uses untInterfaces, NfeApiWSBean, untUtil, SysUtils, untConfigNFE;

Type
  TImportaXMLTerceirosServiceFIT = class(TInterfacedObject, IImportaXMLTerceirosArquivosService)
    private
       fitWrapper: TWSNFeFitWrapper;
       objConfigSovos: TConfiguracoesNFE;
       FSeparador,
       FModeEnvSoap: String;
       procedure pCriaFitWrapper;
    public
      constructor Create; overload;
      constructor Create(objConfigSovos: TConfiguracoesNFE; strModeEnvSoap: String; strSepardor: String=''); overload;
      destructor Destroy; override;
      function fRetornaListaChavesAcessoTerceirosPeriodo(const strCodEmp: String; const dtaDtaIni, dtaDtaFim: TDateTime): string;
      function fRetXMLNfe(const strChaveAcesso: string): string;
      function fRetornaListaChavesAcessoCTeTerceirosPeriodo(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime): string;
      function fRetXMLCTe(const strChaveAcesso: string): string;
  end;

implementation

uses
  untHttpTypes;

{ TImportaXMLTerceirosServiceFIT }

constructor TImportaXMLTerceirosServiceFIT.Create;
begin
  inherited;
end;

constructor TImportaXMLTerceirosServiceFIT.Create(objConfigSovos: TConfiguracoesNFE; strModeEnvSoap: String; strSepardor: String='');
begin
  inherited Create;

  Self.objConfigSovos := objConfigSovos;
  Self.FModeEnvSoap   := strModeEnvSoap;
  Self.FSeparador     := strSepardor;
end;

destructor TImportaXMLTerceirosServiceFIT.Destroy;
begin
  If Assigned(Self.fitWrapper) Then
    FreeAndNil(Self.fitWrapper);

  inherited;
end;

procedure TImportaXMLTerceirosServiceFIT.pCriaFitWrapper;
begin
  If (Not Assigned(Self.fitWrapper)) Then
  Begin
    Self.fitWrapper := TWSNFeFitWrapper.Create;
    Self.fitWrapper.modeEnvSoap  := fGetModeEnvSoap(FModeEnvSoap);
    Self.fitWrapper.strSeparador := FSeparador;
    If Assigned(objConfigSovos) Then
    Begin
      untUtil.objConfig.strFitUrlWebService := objConfigSovos.strFitUrlWebService;
      untUtil.objConfig.strFitLicenca := objConfigSovos.strFitLicenca;
      untUtil.objConfig.strFitUsuario := objConfigSovos.strFitUsuario;
      untUtil.objConfig.strFitSenha := objConfigSovos.strFitSenha;
    End;
  End;
end;

function TImportaXMLTerceirosServiceFIT.fRetornaListaChavesAcessoTerceirosPeriodo(const strCodEmp: string; const dtaDtaIni, dtaDtaFim: TDateTime): string;
begin
  Result := '';

  pCriaFitWrapper;

  Result := fitWrapper.fRetornaListaChavesAcessoTerceirosPeriodo(strCodEmp, dtaDtaIni, dtaDtaFim);
end;

function TImportaXMLTerceirosServiceFIT.fRetXMLNfe(const strChaveAcesso: string): string;
begin
  Result := '';

  pCriaFitWrapper;

  Result := fitWrapper.fRetXMLNfe(strChaveAcesso);
end;

function TImportaXMLTerceirosServiceFIT.fRetornaListaChavesAcessoCTeTerceirosPeriodo(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime): string;
begin
  Result := '';

  pCriaFitWrapper;

  Result := fitWrapper.fRetornaListaChavesAcessoCTeTerceirosPeriodo(strCodEmp, strCodNsu, dtaDtaIni, dtaDtaFim);
end;

function TImportaXMLTerceirosServiceFIT.fRetXMLCTe(const strChaveAcesso: string): string;
begin
  Result := '';

  pCriaFitWrapper;

  Result := fitWrapper.fRetXMLCTe(strChaveAcesso);
end;

end.
