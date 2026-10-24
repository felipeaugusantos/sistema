{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Sayerlack *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoSayerlack;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untIConfTinta, untIDataSet, Classes, untStatusGravando, Windows,
  ActiveX;


type
  TAbstractGravandoExecucaoSayerlack = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    GetSayer: TADOConnection;
    procedure GetArquivosProcessar(stlArquivos: TStringList);
    function fValidaPath : Boolean;
    function fGetDataSayerlack(strPath:String): TADOConnection;
    function GetPath : String;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils;

{ TGravandoExecucaoSayerlackCores }


constructor TAbstractGravandoExecucaoSayerlack.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('SAY');

end;

destructor TAbstractGravandoExecucaoSayerlack.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoSayerlack.fGetDataSayerlack(strPath:String): TADOConnection;
begin
  If Not Assigned(GetSayer) Then
  Begin
    GetSayer := TADOConnection.Create(Nil);
    GetSayer.LoginPrompt := False;
    GetSayer.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source='
                                 + strPath +
                                 ';Extended Properties="Excel 8.0;HDR=No;IMEX=1"'
  End;

  Result := GetSayer;
end;

function TAbstractGravandoExecucaoSayerlack.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoSayerlack.fValidaPath : Boolean;
begin
  Result := True;

  If (Not FileExists(GetPath)) Then
    Result := False;
end;

procedure TAbstractGravandoExecucaoSayerlack.GetArquivosProcessar(
  stlArquivos: TStringList);
begin
  stlArquivos.Text := conf.fGet('SAYPAT');
end;

function TAbstractGravandoExecucaoSayerlack.GetPath: String;
begin
  Result := conf.fGet('SAYPAT');
end;


end.
