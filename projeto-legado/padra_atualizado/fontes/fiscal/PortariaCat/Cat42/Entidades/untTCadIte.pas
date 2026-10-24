unit untTCadIte;

interface

uses untTCadUni;

type
  TItem = class
    private
      FCodigo: string;
      FDescricao: string;
      FNcm: string;
      FUnidade: TUnidade;
      FCodigoCest: string;
    public
      constructor Create;
      destructor Destroy; override;

      property strCodigo: string read FCodigo write FCodigo;
      property strDescricao: string read FDescricao write FDescricao;
      property strNcm: string read FNcm write FNcm;
      property unidade: TUnidade read FUnidade write FUnidade;
      property strCodigoCest: string read FCodigoCest write FCodigoCest;
  end;

implementation

{ TItem }

constructor TItem.Create;
begin
  inherited;

  FUnidade := TUnidade.Create;
end;

destructor TItem.Destroy;
begin
  FUnidade.Free;

  inherited;
end;

end.
