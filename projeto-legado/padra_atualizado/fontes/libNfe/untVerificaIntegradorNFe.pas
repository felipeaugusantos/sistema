unit untVerificaIntegradorNFe;

interface

uses SysUtils, untInterfaces, untUtil, Types, NfeApiWSBean;

Type
  TVerificaIntradorNFe = class
    private
      fitWrapper: TWSNFeFitWrapper;
      FstrCnpj: String;
      FblnOffLine: Boolean;
      FstrModeEnvSoap: String;
      FstrVersao55: String;
      FstrVersao65: String;
    public
      constructor Create(strCnpj: String; blnOffLine: Boolean; strModeEnvSoap: String);
      destructor Destroy; override;
      function fVersao(strModelo: String): String;
      function fModeEnvSoapIsOpenSSL: Boolean;
  End;

Var
  VS_objVerificaIntegrador: TVerificaIntradorNFe;

implementation

uses
  untHttpTypes;

{ TVerificaIntradorNFe }

{
SERVICO "FIT_NFE_DADOS_AMBIENTE_EMPRESA"
  PARAM..: CNPJ | MODELO
  RETORNO: CNPJ | RAZÃO SOCIAL | NOME FANTASIA | CÓD. MODELO | AMBIENTE | TIPO EMISSÃO | VERSÃO | LICENÇA | ID PARCEIRO | ID EMPRESA |
}

constructor TVerificaIntradorNFe.Create(strCnpj: String; blnOffLine: Boolean; strModeEnvSoap: String);
begin
  Self.FstrCnpj        := strCnpj;
  Self.FblnOffLine     := blnOffLine;
  Self.FstrModeEnvSoap := strModeEnvSoap;
  Self.FstrVersao55    := '';
  Self.FstrVersao65    := '';
end;

function TVerificaIntradorNFe.fVersao(strModelo: String): String;
  Var
    retornoFit: TWSNfeFitRetorno;
    intStatusOk: TIntegerDynArray;
begin
  Result := '';
  If strModelo = '55' Then
    Result := Self.FstrVersao55
  Else
    Result := Self.FstrVersao65;

  If fEmptyStr(Result) Then
  Begin
    If (Not Assigned(Self.fitWrapper)) Then
    Begin
      Self.fitWrapper := TWSNFeFitWrapper.Create;
      Self.fitWrapper.modeEnvSoap := fGetModeEnvSoap(FstrModeEnvSoap);
      Self.fitWrapper.blnOffLine  := FblnOffLine;
    End;

    SetLength(intStatusOk, 1);
    intStatusOk[0] := StrToInt(strModelo);

    retornoFit := Self.fitWrapper.fEnviaTextoIntegracao(FstrCnpj + '|' + strModelo, '',
      'FIT_NFE_DADOS_AMBIENTE_EMPRESA', 4, intStatusOk);

    If retornoFit.RetornoOk Then
    Begin
      Result := fGetValorLinha(retornoFit.Texto, '|', 7);

      If strModelo = '55' Then
        Self.FstrVersao55 := Result
      Else
        Self.FstrVersao65 := Result;
    End;
  End;

  If Assigned(retornoFit) Then
    FreeAndNil(retornoFit);
end;

destructor TVerificaIntradorNFe.Destroy;
begin
  If (Not fModeEnvSoapIsOpenSSL) Then
    If Assigned(Self.fitWrapper) Then
      FreeAndNil(Self.fitWrapper);

  inherited;
end;

function TVerificaIntradorNFe.fModeEnvSoapIsOpenSSL: Boolean;
begin
  {$IF RTLVersion >= 28}
    Result := (fGetModeEnvSoap(FstrModeEnvSoap) In [modeOpAp]);
  {$ELSE}
    Result := (fGetModeEnvSoap(FstrModeEnvSoap) In [modeOpen, modeOpAp]);
  {$IFEND}
end;

initialization
  VS_objVerificaIntegrador := Nil;

finalization
  If Assigned(VS_objVerificaIntegrador) Then
    FreeAndNil(VS_objVerificaIntegrador);

end.
