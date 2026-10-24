{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoTopCoat;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoTopCoat = class(TInterfacedObject, IGravandoExecucaoNome)
  protected
    conf: IConfTinta;
  public
    constructor Create();
    destructor Destroy; override;
    function fGetNomeGravacao: string; virtual; abstract;
    procedure Executar(const gravando: IGravando); virtual; abstract;
    function fHabilitaOpcao(): Boolean; Virtual;
  end;
implementation

uses
  untStrUtils;

{ TGravandoExecucaoTopCoatCores }

constructor TAbstractGravandoExecucaoTopCoat.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('COA');
end;

destructor TAbstractGravandoExecucaoTopCoat.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoTopCoat.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
