unit untIOrdenacao;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataset,
{$ENDIF}
  Data.DB;

Type
  IOrdenacao = Interface
  ['{A65C61D2-662A-4053-939F-A1BB97F14AAA}']
    function fRetTextOrdenacao: String;
    function fInclui(strCodCam, strDesCam, strDireca: String): Boolean;

    procedure pExclui;

    procedure pUp;
    procedure pDown;

    procedure pOrdena(cdsDados: TUniClientDataset);

    function GetFintCodEti: Integer;
    procedure SetFintCodEti(Value: Integer);

    function fGetSource: TDataSource;
    procedure pSetSource(DataSource: TDataSource);

    property intCodEti: Integer Read GetFintCodEti Write SetFintCodEti;
    property dtsSource: TDataSource    Read fGetSource Write pSetSource;
  End;

implementation

end.
