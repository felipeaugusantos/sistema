unit untPortadorFornecedor;

interface

Uses
  Classes;

Type
  TPortadorFornecedor = Class
  Private
    FCodFor: String;
    FPermiteAlterarPortador : boolean;
    FCodPor: String;
    FNomPor: String;
    FUtilizaTrava: boolean;
    procedure setCodFor(const Value: String);
    procedure setUtilizaTrava(const Value: boolean);
  Public
    property strCodFor: String read FCodFor write setCodFor;
    property strCodPor: String read FCodPor write FCodPor;
    property strNomPor: String read FNomPor write FNomPor;
    property blnUtilizaTrava : boolean read FUtilizaTrava write setUtilizaTrava;

    function fTravaPortador : boolean;

    constructor Create(blnUtilizaTrava : boolean = false);
  End;


implementation

Uses
  untFuncoesSimples;


{ TPortadorFornecedor }

constructor TPortadorFornecedor.Create(blnUtilizaTrava : boolean = false);
begin
  FCodFor := '';
  FCodPor := '';
  Self.blnUtilizaTrava := blnUtilizaTrava;
end;

function TPortadorFornecedor.fTravaPortador: boolean;
begin
  if FPermiteAlterarPortador then
    exit(false)
  else
    Result := not fEmptyStr(FCodPor);
end;

procedure TPortadorFornecedor.setCodFor(const Value: String);
begin
  FCodFor := Value;

  FCodPor := '';
  FNomPor := '';

  FCodPor := fCampoTabela('FOR_CODPOR', 'CADFOR', ['FOR_CODFOR'], [FCodFor]);
  if not fEmptyStr(FCodPor) then
    FNomPor := fRetNomPortador(FCodPor);
end;

procedure TPortadorFornecedor.setUtilizaTrava(const Value: boolean);
begin
  FUtilizaTrava := Value;
  FPermiteAlterarPortador := (not FUtilizaTrava) or fCfgSis('ALTPOR', varBoolean);
end;

end.
