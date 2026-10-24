{*****************************************************************************************}
{* Class que converte um methodo em um evento, com isso é possivel associar um objeto da *}
{* ILibTintaControleVisualEvento com um evento, podendo implementar o metodo Evento, ou  *}
{* criando um metoho com o mesmo nome e assinatura do evento que será associado,         *}
{* exemplo:                                                                              *}
{*                                                                                       *}
{*   published                                                                           *}
{*     procedure OnClick(Sender: TObject);                                               *}
{*                                                                                       *}
{* lembrando que os eventos tem que ser published                                        *}
{**************************************************************************************PH*}
unit untAbstractLibTintaControleVisualEvento;

interface

uses
  untILibTintaControleVisual, untAbstractCadastro, untIDataSet, SysUtils;

type
  {$M+}
  TAbstractLibTintaControleVisualEvento = class abstract(TInterfacedObject, ILibTintaControleVisualEvento)
  protected
    strNomeEvento: string;
    controleVisual: ILibTintaControleVisual;
    tela: ITelaCadLibTintas;
    cadastro: TAbstractCadastro;
    function GetControle(const strNomeControle: string): ILibTintaControleVisual;
    function GetFieldByControle(const strNomeControle: string): IDataSetField;
  public
    constructor Create(const strNomeEvento: string; const cadastro: TAbstractCadastro); reintroduce;
    function GetNome: string;
    function GetMethodAddress: Pointer;

    function GetLibTintaControleVisual: ILibTintaControleVisual;
    function GetTelaCadLibTintas: ITelaCadLibTintas;
    procedure SetLibTintaControleVisual(const value: ILibTintaControleVisual);
    procedure SetTelaCadLibTintas(const value: ITelaCadLibTintas);
  end;

implementation

{ TAbstractLibTintaControleVisualEvento }

constructor TAbstractLibTintaControleVisualEvento.Create(const strNomeEvento: string; const cadastro: TAbstractCadastro);
begin
  inherited Create();
  Self.strNomeEvento := strNomeEvento;
  Self.cadastro := cadastro;
end;

function TAbstractLibTintaControleVisualEvento.GetControle(
  const strNomeControle: string): ILibTintaControleVisual;
begin
  Result := nil;
  if Assigned(tela) then
  begin
    Result := tela.GetLibTintaControleVisualNome(strNomeControle);
  end;  
end;

function TAbstractLibTintaControleVisualEvento.GetFieldByControle(
  const strNomeControle: string): IDataSetField;
begin
  if not Assigned(tela[strNomeControle]) then
    raise Exception.CreateFmt('Não foi possível encontrar o controle [%s] na tela!', [strNomeControle]);

  if not Assigned(tela[strNomeControle]['DataField']) then
    raise Exception.CreateFmt('O controle [%s] não possui a propriedade [%s]', [strNomeControle, 'DataField']);

  Result := cadastro.GetQueryCadastro.FieldByName(tela[strNomeControle]['DataField'].Value);

end;

function TAbstractLibTintaControleVisualEvento.GetLibTintaControleVisual: ILibTintaControleVisual;
begin
  Result := controleVisual;
end;

function TAbstractLibTintaControleVisualEvento.GetMethodAddress: Pointer;
begin
  Result := Self.MethodAddress(strNomeEvento);
end;

function TAbstractLibTintaControleVisualEvento.GetNome: string;
begin
  Result := strNomeEvento;
end;

function TAbstractLibTintaControleVisualEvento.GetTelaCadLibTintas: ITelaCadLibTintas;
begin
  Result := tela;
end;

procedure TAbstractLibTintaControleVisualEvento.SetLibTintaControleVisual(
  const value: ILibTintaControleVisual);
begin
  controleVisual := value;
end;

procedure TAbstractLibTintaControleVisualEvento.SetTelaCadLibTintas(
  const value: ITelaCadLibTintas);
begin
  tela := value;
end;

end.
