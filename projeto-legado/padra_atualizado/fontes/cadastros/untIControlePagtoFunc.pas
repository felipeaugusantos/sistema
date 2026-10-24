unit untIControlePagtoFunc;

interface

uses DB, UniClientDataSet;

Type
  ICadFun = interface
  ['{6CC86F22-5682-44C3-BF1C-81BEB574D70C}']
    function fRetornaSalarioBase(strCodFun: String; strCodEmp: String): Double;
    function fGeraRelatorio(strCodEmp,
                            strMesBas,
                            strTipMov,
                            strCodVen: String;
                            fltTotCom: Double = 0;
                            strCodVer: String = ''): Boolean;

    procedure pGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pSetText(Sender: TField; const Text: string);

    function getCdsVerbas: TUniClientDataSet;
    procedure setCdsVerbas(Value: TUniClientDataSet);

    property cdsVerbas: TUniClientDataSet Read getCdsVerbas Write setCdsVerbas;
  End;

implementation

end.
