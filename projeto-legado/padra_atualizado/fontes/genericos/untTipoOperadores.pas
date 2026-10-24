unit untTipoOperadores;

interface

uses
  Classes, System.Generics.Collections, DB, System.SysUtils, ComboBoxFocus;

type
  TItemCombo = class
  private
    FDescricao: String;
    FCodigo: String;

    procedure SetCodigo(const Value: String);
    procedure SetDescricao(const Value: String);
  public
    property Codigo    : String read FCodigo    write SetCodigo;
    property Descricao : String read FDescricao write SetDescricao;
  end;

  TListaTipoOperadores = class
  private
    FLista : TDictionary<String, String>;
    procedure pCarregarDados;

  public
    constructor Create;
    destructor Destroy; override;

    class procedure pCarregaListaDataSet(const ADataSet: TDataSet;
      const ACampoCodigo, ACampoDescricao: String);

    class procedure pCarregaCombo(const AComboBox: TComboBoxFocus);

    class function New(): TListaTipoOperadores;

    property Lista: TDictionary<String, String> read FLista;
  end;

implementation

uses
  untFuncoesSimples;

{ TListaTipoOperadores }

constructor TListaTipoOperadores.Create;
begin
  FLista := TDictionary<String, String>.Create;
  pCarregarDados;
end;

destructor TListaTipoOperadores.Destroy;
begin
  FreeAndNil(FLista);

  inherited;
end;

class procedure TListaTipoOperadores.pCarregaCombo(
  const AComboBox: TComboBoxFocus);
var
  strChave               : String;
  objItemCombo           : TItemCombo;
  lstListaTipoOperadores : TListaTipoOperadores;
begin
  lstListaTipoOperadores := TListaTipoOperadores.New();
  Try
    If Not Assigned(AComboBox) Then
      Exit;

    AComboBox.Clear;

    For strChave In lstListaTipoOperadores.Lista.Keys Do
    Begin
      objItemCombo := TItemCombo.Create;
      objItemCombo.Codigo    := strChave;
      objItemCombo.Descricao := lstListaTipoOperadores.Lista.Items[strChave];

      AComboBox.Items.AddObject(objItemCombo.Descricao, objItemCombo);
    End;
  Finally
    FreeAndNil(lstListaTipoOperadores);
  End;
end;

class procedure TListaTipoOperadores.pCarregaListaDataSet(
  const ADataSet: TDataSet; const ACampoCodigo,
  ACampoDescricao: String);
var
  strChave               : String;
  lstListaTipoOperadores : TListaTipoOperadores;
begin
  lstListaTipoOperadores := TListaTipoOperadores.New();
  Try
    If Not ADataSet.Active Then
      Exit;

    For strChave In lstListaTipoOperadores.Lista.Keys Do
    Begin
      ADataSet.Insert;
      ADataSet.FieldByName(ACampoCodigo).AsString    := strChave;
      ADataSet.FieldByName(ACampoDescricao).AsString := lstListaTipoOperadores.Lista.Items[strChave];
      ADataSet.Post;
    End;
  Finally
    FreeAndNil(lstListaTipoOperadores);
  End;
end;

class function TListaTipoOperadores.New: TListaTipoOperadores;
begin
  Result := Self.Create;
end;

procedure TListaTipoOperadores.pCarregarDados;
begin
  FLista.Add('A','ADMINISTRATIVO');
  FLista.Add('C','COMPRAS');
  FLista.Add('I','VENDEDOR INTERNO');
  FLista.Add('E','REPRES. EXTERNO LOJA');
  FLista.Add('D','REPRES. EXTERNO DISTRIBUIDOR');
  FLista.Add('S','SUB-GERENTE');
  FLista.Add('G','GERENTE');
  FLista.Add('O','OPERACIONAL');
  FLista.Add('T','ASSISTÊNCIA TÉCNICA');

  If fCfgSis('AUTCEN', VarBoolean) Then
    FLista.Add('M','MECÂNICO');
end;

{ TItemCombo }

procedure TItemCombo.SetCodigo(const Value: String);
begin
  FCodigo := Value;
end;

procedure TItemCombo.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

end.
