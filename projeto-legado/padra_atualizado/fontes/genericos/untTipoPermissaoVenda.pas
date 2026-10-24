unit untTipoPermissaoVenda;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, VirtualTable;

type
  TTipoPermissaoVenda = (tpvTodos,
                         tpvPessoasFisicas,
                         tpvPessoasJuridicas,
                         tpvNaoConsumidorFinalRevenda);

  TTipoPermissaoVendaHelper = record helper for TTipoPermissaoVenda
  private
    type
      TRegistro = record
        enuTipo: TTipoPermissaoVenda;
        strValue: string;
        strDescricao: string
      end;

    const
      arrREGISTROS: array[0..3] of TRegistro =
        (
           (enuTipo: TTipoPermissaoVenda.tpvTodos;
            strValue: 'T';
            strDescricao: 'TODOS OS CLIENTES'),

           (enuTipo: TTipoPermissaoVenda.tpvPessoasFisicas;
            strValue: 'F';
            strDescricao: 'SOMENTE PESSOA FÍSICA'),

           (enuTipo: TTipoPermissaoVenda.tpvPessoasJuridicas;
            strValue: 'J';
            strDescricao: 'SOMENTE PESSOA JURÍDICA'),

           (enuTipo: TTipoPermissaoVenda.tpvNaoConsumidorFinalRevenda;
            strValue: 'R';
            strDescricao: 'CLIENTE NÃO CONSUMIDOR FINAL (REVENDA)')
        );
  strict private
    type
      TDados = class
      private
        FDataset: TVirtualTable;
      strict private
        type
          ETipoPermissaoDados = class(Exception);
        const
          strMENSAGEM_ERRO = 'Apenas instância da classe %s permitida!';
        class var FInstancia: TDados;
        constructor CreatePrivate;
        procedure PopulaDadosDataset;
      public
        constructor Create; reintroduce;
        destructor Destroy; override;
        class function GetInstancia: TDados;
      end;

    class function GetDataset: TDataSet; static;
    function GetRegistro: TRegistro;
  private
    type
      Dados = TDados;
  public
    property Registro: TRegistro read GetRegistro;
    class property Dataset: TDataSet read GetDataset;
    class function Get(Value: string): TTipoPermissaoVenda; static;
  end;

implementation

constructor TTipoPermissaoVendaHelper.TDados.Create;
begin
  raise ETipoPermissaoDados.Create(Format(strMENSAGEM_ERRO, [Self.ClassName]));
end;

constructor TTipoPermissaoVendaHelper.TDados.CreatePrivate;
begin
  inherited Create;
  FDataset := TVirtualTable.Create(nil);
  PopulaDadosDataset;
end;

destructor TTipoPermissaoVendaHelper.TDados.Destroy;
begin
  if FDataset.Active then
    FDataset.Close;
  FDataset.Free;
  inherited;
end;

class function TTipoPermissaoVendaHelper.TDados.GetInstancia: TDados;
begin
  if not Assigned(FInstancia) then
    FInstancia := TDados.CreatePrivate;
  Result := FInstancia;
end;

procedure TTipoPermissaoVendaHelper.TDados.PopulaDadosDataset;
var
  Registro: TRegistro;
begin
  FDataset.FieldDefs.Add('ID', TFieldType.ftInteger);
  FDataset.FieldDefs.Add('VALUE', TFieldType.ftString, 1);
  FDataset.FieldDefs.Add('DESCRICAO', TFieldType.ftString, 100);
  FDataset.open;

  for Registro in TTipoPermissaoVenda.arrREGISTROS do
  begin
    FDataset.Append;
    FDataset.FieldByName('ID').AsInteger := Ord(Registro.enuTipo);
    FDataset.FieldByName('VALUE').AsString := Registro.strValue;
    FDataset.FieldByName('DESCRICAO').AsString := Registro.strDescricao;
    FDataset.Post;
  end;
end;

class function TTipoPermissaoVendaHelper.GetDataset: TDataSet;
begin
  result := TTipoPermissaoVenda.Dados.GetInstancia.FDataset;
end;

function TTipoPermissaoVendaHelper.GetRegistro: TRegistro;
begin
  result := arrREGISTROS[Ord(Self)];
end;

class function TTipoPermissaoVendaHelper.Get(Value: string): TTipoPermissaoVenda;
begin
  if TTipoPermissaoVenda.Dataset.Locate('VALUE', Value, [loCaseInsensitive]) then
    result := TTipoPermissaoVenda(TTipoPermissaoVenda.Dataset.FieldByName('ID').AsInteger)
  else
    result := TTipoPermissaoVenda(-1);
end;

Initialization
  TTipoPermissaoVenda.Dados.GetInstancia;

finalization
  TTipoPermissaoVenda.Dados.GetInstancia.Free;

end.
