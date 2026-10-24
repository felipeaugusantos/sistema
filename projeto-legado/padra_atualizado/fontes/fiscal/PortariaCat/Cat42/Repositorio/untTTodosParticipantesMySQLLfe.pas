unit untTTodosParticipantesMySQLLfe;

interface

uses System.Generics.Collections,
     untTRepositorioBasico,
     untTParticipante,
     Classes;

type
  TTodosParticipantesMySQL = class
  private
    FRepositorio: TRepositorioBasico;
  public
    function fRetTodosParticipantes(stlParticipantes: TStringList; strCnpjEmpresaSelecionada: string; blnFiltraPorCodigo: Boolean = False): TObjectList<TParticipante>;

    constructor create;
    destructor Destroy; override;
  end;

implementation

{ TTodosParticipantesMySQL }

constructor TTodosParticipantesMySQL.create;
begin
  FRepositorio := TRepositorioBasico.Create;
end;

destructor TTodosParticipantesMySQL.Destroy;
begin
  FRepositorio.Free;
  inherited;
end;

function TTodosParticipantesMySQL.fRetTodosParticipantes(stlParticipantes: TStringList; strCnpjEmpresaSelecionada: string; blnFiltraPorCodigo: Boolean = False): TObjectList<TParticipante>;
begin
  Result := FRepositorio.fRetTodosParticipantes(stlParticipantes, strCnpjEmpresaSelecionada, blnFiltraPorCodigo);
end;

end.
