unit untConfiguracoesSUFIPC;

interface
uses Uni, System.SysUtils;
type
  TRecCfgPisCofinsSuframa = Record
    PIS_CST: String;
    PIS_BASE: Double;
    PIS_ALIQUOTA: Double;
    COFINS_CST: String;
    COFINS_BASE: Double;
    COFINS_ALIQUOTA: Double;
    CODEMP: String;
    blnGravar: Boolean;
    blnTemConfiguracao: Boolean;
    function pGetValue(strCodEmp: String): TRecCfgPisCofinsSuframa;
  End;

implementation

uses untConstantes, untFuncoesSimples;


{ TRecCfgPisCofinsSuframa }

function TRecCfgPisCofinsSuframa.pGetValue(
  strCodEmp: String): TRecCfgPisCofinsSuframa;
var qryCfg: TUniQuery;
begin
  Result.blnTemConfiguracao := False;
  qryCfg := fCriaQuery;
  Try
    If strCodEmp = '' Then
      strCodEmp := VS_StrCodEmp;
    qryCfg.SQL.Add('SELECT * FROM CFGSIS_SUFIPC WHERE IPC_CODEMP = "'+strCodEmp+'"');
    qryCfg.Open;
    Self.CODEMP := strCodEmp;

    If qryCfg.IsEmpty then
      Exit;

    Self.PIS_CST := qryCfg.FieldByName('IPC_PISCST').AsString;
    Self.PIS_BASE := qryCfg.FieldByName('IPC_PISBAS').AsFloat;
    Self.PIS_ALIQUOTA := qryCfg.FieldByName('IPC_PISAQL').AsFloat;
    Self.COFINS_CST := qryCfg.FieldByName('IPC_COFCST').AsString;
    Self.COFINS_BASE := qryCfg.FieldByName('IPC_COFBAS').AsFloat;
    Self.COFINS_ALIQUOTA := qryCfg.FieldByName('IPC_COFALQ').AsFloat;
    Self.blnTemConfiguracao := True;

  Finally
    FreeAndNil(qryCfg);
  End;

end;

end.
