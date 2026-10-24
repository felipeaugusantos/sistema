unit untRelFatMetasVendedorFreteTypes;

interface

uses
  untTypesSistema;

Type
  TEmpresaOrigem    = (eoFaturamento, eoOrigem);
  TTipoVendedor     = (tvInterno, tvExterno, tvTodos);
  TOpcaoRelatorio   = (orAnalitico, orSintetico);
  TDestinoRelatorio = (drVideo, drImpressora);

Type
  TConsultaMultiSelecao = Class(TObject)
  private
    FarrSelecao: TConsultasArray;
    FstrSelecao: String;
    FedtCodigo : TObject;
    FedtDescri : TObject;
  protected
    function GetarrSelecao: TConsultasArray;
    function GetedtCodigo: TObject;
    function GetedtDescri: TObject;
    function GetstrSelecao: String;
    procedure SetarrSelecao(const Value: TConsultasArray);
    procedure SetedtCodigo(const Value: TObject);
    procedure SetedtDescri(const Value: TObject);
    procedure SetstrSelecao(const Value: String);
  public
    Constructor Create;
    Destructor Destroy; Override;

    property arrSelecao: TConsultasArray Read GetarrSelecao Write SetarrSelecao;
    property strSelecao: String          Read GetstrSelecao Write SetstrSelecao;
    property edtCodigo : TObject         Read GetedtCodigo  Write SetedtCodigo;
    property edtDescri : TObject         Read GetedtDescri  Write SetedtDescri;
  End;

implementation

{ TConsultaMultiSelecao }

constructor TConsultaMultiSelecao.Create;
begin
  inherited Create;
end;

destructor TConsultaMultiSelecao.Destroy;
begin
  inherited Destroy;
end;

function TConsultaMultiSelecao.GetarrSelecao: TConsultasArray;
begin
  Result := FarrSelecao;
end;

function TConsultaMultiSelecao.GetedtCodigo: TObject;
begin
  Result := FedtCodigo;
end;

function TConsultaMultiSelecao.GetedtDescri: TObject;
begin
  Result := FedtDescri;
end;

function TConsultaMultiSelecao.GetstrSelecao: String;
begin
  Result := FstrSelecao;
end;

procedure TConsultaMultiSelecao.SetarrSelecao(const Value: TConsultasArray);
begin
  FarrSelecao := Value;
end;

procedure TConsultaMultiSelecao.SetedtCodigo(const Value: TObject);
begin
  FedtCodigo := Value;
end;

procedure TConsultaMultiSelecao.SetedtDescri(const Value: TObject);
begin
  FedtDescri := Value;
end;

procedure TConsultaMultiSelecao.SetstrSelecao(const Value: String);
begin
  FstrSelecao := Value;
end;

end.
