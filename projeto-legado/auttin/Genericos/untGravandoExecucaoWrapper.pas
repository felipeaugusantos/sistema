{*******************************************************************************************}
{* Classe responsável pelo encapsulamento de um objeto IGravandoExecucaoNome retornado     *}
{* pelas dlls da tinta e com isso a comunicação entre a dll da tinta de a tela de gravação *}
{****************************************************************************************PH*}
unit untGravandoExecucaoWrapper;

interface

uses
  untAbstractGravandoExecucao, untIGravandoExecucaoNome, untIGravando;

type
  TGravandoExecucaoWrapper = class(TAbstractGravandoExecucao)
  private
    gravandoExecucao: IGravandoExecucaoNome;
  public
    constructor Create(const gravandoExecucao: IGravandoExecucaoNome);
    procedure Executar(const gravando: IGravando); override;
    function fGetNomeGravacao(): string; override;
    function fHabilitaOpcao(): Boolean; Override;
  end;

implementation

{ TGravandoExecucaoWrapper }

constructor TGravandoExecucaoWrapper.Create(const gravandoExecucao: IGravandoExecucaoNome);
begin
  inherited Create();
  Self.gravandoExecucao := gravandoExecucao;
end;

procedure TGravandoExecucaoWrapper.Executar(const gravando: IGravando);
begin
  gravandoExecucao.Executar(gravando);
end;

function TGravandoExecucaoWrapper.fGetNomeGravacao: string;
begin
  Result := gravandoExecucao.fGetNomeGravacao;
end;

function TGravandoExecucaoWrapper.fHabilitaOpcao: Boolean;
begin
  Result := gravandoExecucao.fHabilitaOpcao;
end;

end.
