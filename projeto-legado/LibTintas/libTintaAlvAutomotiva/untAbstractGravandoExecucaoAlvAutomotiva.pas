{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta AlvAutomotiva *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoAlvAutomotiva;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, ActiveX, untStatusGravando, Windows;

type
  TAbstractGravandoExecucaoAlvAutomotiva = class(TInterfacedObject, IGravandoExecucaoNome)
  private
  protected
    conf: IConfTinta;
    stlArquivos: TStringList;

    function fValidarPath(): Boolean;


    class function LimpaTexto(const strTexto: string): string;
    //Abstract
    function GetSqlDestino(): string; virtual; abstract;
    function fGetPath(): String; virtual; abstract;
    function IsRegistroExistente(const qryDestino: IDataSet; ArquivoText: TStringList): Boolean; virtual; abstract;
    procedure GravarRegistro(const qryDestino: IDataSet; ArquivoText: TStringList); virtual; abstract;
    //Virtuais
    function GetDataSetDestino(): IDataSet; virtual;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils, untADOFactory,
   untIDefinicaoTxt, untGenericDefinicaoTxt,
  untDefinicaoTxtCharacterSet, untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo,
  untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoAlvAutomotivaCores }

constructor TAbstractGravandoExecucaoAlvAutomotiva.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('ALA');
end;

destructor TAbstractGravandoExecucaoAlvAutomotiva.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoAlvAutomotiva.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TAbstractGravandoExecucaoAlvAutomotiva.fValidarPath(): Boolean;
begin
  Result := True;

  If Not FileExists(fGetPath) Then
  Begin
    Result := False;
    Exit;
  End;
end;

function TAbstractGravandoExecucaoAlvAutomotiva.GetDataSetDestino: IDataSet;
begin
  Result := TAutcomTintaFactory.Get.fGetDataSet;
  Result.SQL := GetSqlDestino;
  Result.Open;
end;

class function TAbstractGravandoExecucaoAlvAutomotiva.LimpaTexto(
  const strTexto: string): string;
begin
  Result := AnsiUpperCase(Trim(TAutcomTintaFactory.Get.fRemoveAcento(strTexto)));
end;


end.
