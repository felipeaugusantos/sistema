unit untTParticipantesPresentesLfe;

interface

uses Classes;

type
  TParticipantesPresentes = class
  private
    FListaParticipantes: TStringList;
  public
    constructor create;
    destructor Destroy; override;

    property listaParticipantes: TStringList read FListaParticipantes write FListaParticipantes;
  end;

implementation

{ TParticipantesPresentes }

constructor TParticipantesPresentes.create;
begin
  FListaParticipantes := TStringList.Create;
  FListaParticipantes.Clear;
end;

destructor TParticipantesPresentes.Destroy;
begin
  FListaParticipantes.Free;
  inherited;
end;

end.
