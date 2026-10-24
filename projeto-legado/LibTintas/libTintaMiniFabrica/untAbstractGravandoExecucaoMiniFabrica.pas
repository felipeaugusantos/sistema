{***********************************************************************************}
{* Classe abstrata que implementa o básico / comum para a geração da tinta Lazzumix *}
{********************************************************************************PH*}
unit untAbstractGravandoExecucaoMiniFabrica;

interface

uses
  untIGravandoExecucaoNome, untIGravando, ADODB, SysUtils, DB,
  Math, untTipoCadastro, Classes, StrUtils, untAutcomTintaFactory,
  UniClientDataSet, untFloatUtils, untIConfTinta, untIDataSet;

type
  TAbstractGravandoExecucaoMiniFabrica = class(TInterfacedObject, IGravandoExecucaoNome)
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

{ TGravandoExecucaoMiniFabricaCores }

constructor TAbstractGravandoExecucaoMiniFabrica.Create;
begin
  inherited Create;

  conf := TAutcomTintaFactory.Get.fGetConfTinta('MIF');
end;

destructor TAbstractGravandoExecucaoMiniFabrica.Destroy;
begin
  inherited;
end;

function TAbstractGravandoExecucaoMiniFabrica.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.
