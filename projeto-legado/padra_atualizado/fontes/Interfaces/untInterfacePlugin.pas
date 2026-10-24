unit untInterfacePlugin;

interface

uses
  System.Classes;

type
  IQuery = interface
    procedure Open;
    procedure Close;
    procedure First;
    procedure Last;
    procedure Next;
    procedure Prior;
    procedure ExecSQL;
    function Eof: Boolean;
    function Bof: Boolean;
    function FieldValue(fieldName: String): Variant;
    function GetSQL: TStrings;
    property SQL: TStrings read GetSQL;
  end;

  IHost = interface
    procedure pAddMenu(strCaminho: Array of String; strDirAcesso, strProcName: String);
    procedure pAddButton(arrIcone: Array of Integer; strDirAcesso, strProcName: String);
    function fGetUsuario(): String;
    function fGetEmpresa(): String;
    function fGetQuery(): IQuery;
  end;

  TProcExecPlugin = procedure(const host: IHost);

const
  TAMANHO_ICONE = 60;

implementation

end.
