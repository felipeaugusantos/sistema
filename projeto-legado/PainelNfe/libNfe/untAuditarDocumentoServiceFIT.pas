unit untAuditarDocumentoServiceFIT;

interface

uses untInterfaces, NfeApiWSBean, untUtil, SysUtils, untConfigNFE, untConstantesNFe;

Type
  TAuditarDocumentoServiceFIT = class(TInterfacedObject, IAuditarDocumentoServiceFIT)
    private
       fitWrapper: TWSNFeFitWrapper;
       objConfigSovos: TConfiguracoesNFE;
       FModeEnvSoap: String;
       procedure pCriaFitWrapper;
    public
      constructor Create; overload;
      constructor Create(objConfigSovos: TConfiguracoesNFE; strModeEnvSoap: String); overload;
      destructor Destroy; override;
      function fRetornaListaCanceladasPorDataCancelamento(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime; const tdfTipDFe: TTipDfe): string;
      function fConsultaSituacaoInutilizacaoTraduzido(const strCnpj_, strSerie_, strNumDoc: String): TRetornoNFE;
      function fConsultaStatusDFeTraduzido(const strChaAce: String): TRetornoNFE;
  end;

implementation

{ TAuditarDocumentoServiceFIT }

constructor TAuditarDocumentoServiceFIT.Create;
begin
  inherited;
end;

constructor TAuditarDocumentoServiceFIT.Create(objConfigSovos: TConfiguracoesNFE; strModeEnvSoap: String);
begin
  inherited Create;

  Self.objConfigSovos := objConfigSovos;
  Self.FModeEnvSoap   := strModeEnvSoap;
end;

destructor TAuditarDocumentoServiceFIT.Destroy;
begin
  If Assigned(Self.fitWrapper) Then
    FreeAndNil(Self.fitWrapper);

  inherited;
end;

function TAuditarDocumentoServiceFIT.fConsultaSituacaoInutilizacaoTraduzido(const strCnpj_, strSerie_, strNumDoc: String): TRetornoNFE;
begin
  pCriaFitWrapper;

  Result := fitWrapper.fConsultaSituacaoInutilizacaoTraduzido(strCnpj_, strSerie_, strNumDoc);
end;

function TAuditarDocumentoServiceFIT.fConsultaStatusDFeTraduzido(const strChaAce: String): TRetornoNFE;
begin
  pCriaFitWrapper;

  Result := fitWrapper.fConsultaStatusDFeTraduzido(strChaAce);
end;

function TAuditarDocumentoServiceFIT.fRetornaListaCanceladasPorDataCancelamento(const strCodEmp, strCodNsu: string; const dtaDtaIni, dtaDtaFim: TDateTime; const tdfTipDFe: TTipDfe): string;
begin
  Result := '';

  pCriaFitWrapper;

  Result := fitWrapper.fRetornaListaCanceladasPorDataCancelamento(strCodEmp, strCodNsu, dtaDtaIni, dtaDtaFim, tdfTipDFe);
end;

procedure TAuditarDocumentoServiceFIT.pCriaFitWrapper;
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
