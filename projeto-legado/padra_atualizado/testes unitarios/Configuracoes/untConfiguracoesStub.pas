unit untConfiguracoesStub;

interface

uses untIConfiguracao, Contnrs, SysUtils;

Type
  TValorConfig = class
    public
      strCodigo: String;
      varValor: Variant;
  End;

  TConfiguracaoStub = class(TInterfacedObject, IConfiguracao)
    private
      lstConfigs: TObjectList;
    public
      constructor Create;
      destructor Destroy; override;

      function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
      function fAddConfig(strCodigo: String; varValor: Variant): TConfiguracaoStub;
  End;

implementation

{ TConfiguracaoStub }

constructor TConfiguracaoStub.Create;
begin
  lstConfigs := TObjectList.Create;
  fAddConfig('FRMCUS', '1');
  fAddConfig('DECUNI', 2);
  fAddConfig('MARMKP', '2');
  fAddConfig('PRECUV', '1');
  fAddConfig('ALPISP', 1.65);
  fAddConfig('ALCOFP', 7.60);
  fAddConfig('ICMPRM', True);
  fAddConfig('DEDPIS', True);
  fAddConfig('FREMED', True);
  fAddConfig('ANTICM', True);
end;

destructor TConfiguracaoStub.Destroy;
begin
  FreeAndNil(lstConfigs);
  inherited;
end;

function TConfiguracaoStub.fAddConfig(strCodigo: String;
  varValor: Variant): TConfiguracaoStub;
  Var
    objCfg: TValorConfig;
    objPointer: Pointer;
begin
  Result := Self;

  For objPointer In lstConfigs Do
  Begin
    objCfg := TValorConfig(objPointer);
    If objCfg.strCodigo = strCodigo Then
    Begin
      objCfg.varValor := varValor;
      Exit;
    End;
  End;

  objCfg := TValorConfig.Create;
  objCfg.strCodigo := strCodigo;
  objCfg.varValor := varValor;
  lstConfigs.Add(objCfg);
end;

function TConfiguracaoStub.fCfgSis(strCamCfg: String; varTipVar: TVarType;
  strCodEmp: String): Variant;
  Var
    objCfg: TValorConfig;
    objPointer: Pointer;
begin
  For objPointer In lstConfigs Do
  Begin
    objCfg := TValorConfig(objPointer);
    If objCfg.strCodigo = strCamCfg Then
    Begin
      Result := objCfg.varValor;
      Exit;
    End;
  End;

  Raise Exception.Create('Configuração não cadastrada: ' + strCamCfg);
end;

end.
