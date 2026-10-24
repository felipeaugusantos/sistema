unit untIConfiguracao;

interface

Type
  IConfiguracao = interface
    ['{525AFB50-E8B9-4C9D-B09C-520365905646}']
    function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
  End;

implementation

end.
