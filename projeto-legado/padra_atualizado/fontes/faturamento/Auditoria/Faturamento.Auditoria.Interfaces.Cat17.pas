unit Faturamento.Auditoria.Interfaces.Cat17;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'};
{$ELSE}
  UniClientDataSet;
{$ENDIF}

type
  IAuditoriaCat17 = interface
    ['{920674F6-C1B9-4C9C-A559-77ECAD91EC07}']

    function GetC17Mod: Integer;
    function SetC17Mod(AValue: Integer): IAuditoriaCat17;

    function GetCodSit: String;
    function SetCodSit(AValue: String): IAuditoriaCat17;

    function GetAlqRet: Double;
    function SetAlqRet(AValue: Double): IAuditoriaCat17;

    function GetValIva: Double;
    function SetValIva(AValue: Double): IAuditoriaCat17;

    function GetMCAT17: String;
    function SetMCAT17(AValue: String): IAuditoriaCat17;

    function GetResTot: Double;
    function SetResTot(AValue: Double): IAuditoriaCat17;

    function GetDocumentoUltimaCompra: String;
    function SetDocumentoUltimaCompra(AValue: String): IAuditoriaCat17;

    function GetFornecedorUltimaCompra: String;
    function SetFornecedorUltimaCompra(AValue: String): IAuditoriaCat17;

    function GetTeveReducao: Boolean;
    function SetTeveReducao(AValue: Boolean): IAuditoriaCat17;

    function GetCodIte: String;
    function SetCodIte(AValue: String): IAuditoriaCat17;

    procedure Adicionar;
    procedure Limpar;
    function GetCdsAuditoriaCat17: TUniClientDataSet;
  end;

implementation

end.
