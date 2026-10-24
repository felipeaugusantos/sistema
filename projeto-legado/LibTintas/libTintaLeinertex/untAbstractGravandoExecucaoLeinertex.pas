{********************************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Leinertex *}
{*****************************************************************************************AC*}
unit untAbstractGravandoExecucaoLeinertex;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB, Math, untIConfTinta,
  Classes, untIDataSet, ActiveX, untStatusGravando, Windows;

type
  TAbstractGravandoExecucaoLeinertex = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
    function fGetNomeArquivo: String;

  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;

implementation

uses
  untAutcomTintaFactory, untStrUtils, untADOFactory;
{ TGravandoExecucaoLeinertexCores }


constructor TAbstractGravandoExecucaoLeinertex.Create;
begin
  inherited Create;
  conf := TAutcomTintaFactory.Get.fGetConfTinta('LEI');
end;

destructor TAbstractGravandoExecucaoLeinertex.Destroy;
begin
  inherited;
end;


function TAbstractGravandoExecucaoLeinertex.fGetNomeArquivo: String;
begin
  Result := Conf.fGet('PATLEI');
end;



function TAbstractGravandoExecucaoLeinertex.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
