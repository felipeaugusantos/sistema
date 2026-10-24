{**********************************************************************************}
{* TAbstractCadastro: Classe abstrata contendo os metodos em comum de um cadastro *}
{******************************************************************************PH**}
unit untAbstractCadastro;

interface

uses
  untLibTintaFactory, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, Classes, untIDataSet;

type
  TAbstractCadastro = class abstract(TInterfacedObject, ICadLibTintas)
  private
    lstControles: IInterfaceList;
    qryCadastro: IDataSet;
    function GetControles: IInterfaceList;
  protected
    function AdicionarControle(const libTintaControleVisual: ILibTintaControleVisual): Integer;
    procedure ConstruirControles; virtual;
  public
    constructor Create();
    function GetIdePro: string; virtual;
    function GetTitulo: string; virtual; abstract;
    function GetConsulta: IConsulta; virtual; abstract;
    function GetCamposDesabilitadosEdit: TCadLibTintasStringArray; virtual; abstract;
    function GetClassName: string;
    function GetNomeCampo: string; virtual; abstract;
    function GetNomeTabela: string; virtual; abstract;
    function GetLibTintaControleVisual(const index: Integer): ILibTintaControleVisual; overload;
    function GetLibTintaControleVisual(const strNome: string): ILibTintaControleVisual; overload;
    function GetLibTintaControleVisualCont: Integer;
    function GetNomeCampoRelacionamento: string; virtual; abstract;
    procedure pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string); virtual; abstract;
    procedure SetQueryCadastro(const dataSet: IDataSet);
    function GetQueryCadastro: IDataSet;
    function fGetCampoChave(const index: Integer): string; virtual; abstract;
    function fGetCountCamposChave: Integer; virtual; abstract;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); virtual; abstract;
    function fValidaCampos(const tela: ITelaCadLibTintas;
      strNomeCampo: string; strValorCampo: string;
      var strRetorno: string): Boolean; virtual; abstract;
    procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); virtual; abstract;
    procedure AjustarTela(const tela: ITelaCadLibTintas); virtual;
    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure AlterarAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure CancelarDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); virtual;
    procedure PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string); virtual;

  end;

implementation

{ TAbstractCadastroSuvinil }

function TAbstractCadastro.AdicionarControle(
  const libTintaControleVisual: ILibTintaControleVisual): Integer;
begin
  Result := GetControles.Add(libTintaControleVisual);
end;

procedure TAbstractCadastro.AjustarTela(const tela: ITelaCadLibTintas);
begin

end;

procedure TAbstractCadastro.AlterarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.AlterarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.CancelarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.CancelarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.ConstruirControles;
begin
end;

constructor TAbstractCadastro.Create;
begin
  inherited Create;
  ConstruirControles;
end;

procedure TAbstractCadastro.ExcluirAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

function TAbstractCadastro.GetClassName: string;
begin
  Result := Self.ClassName;
end;

function TAbstractCadastro.GetControles: IInterfaceList;
begin
  if not Assigned(lstControles) then
  begin
    lstControles := TInterfaceList.Create;
  end;

  Result := lstControles;
end;

function TAbstractCadastro.GetIdePro: string;
begin
  Result := TLibTintaFactory.GetLibTinta.GetIdePro;
end;

function TAbstractCadastro.GetLibTintaControleVisual(
  const index: Integer): ILibTintaControleVisual;
begin
  Result := GetControles[index] as ILibTintaControleVisual;
end;

function TAbstractCadastro.GetLibTintaControleVisual(
  const strNome: string): ILibTintaControleVisual;
var
  intCont: Integer;
begin
  Result := nil;

  for intCont := 0 to GetControles.Count - 1 do
  begin
    if (GetControles[intCont] as ILibTintaControleVisual).Nome = strNome then
    begin
      Result := GetControles[intCont] as ILibTintaControleVisual;
      Exit;
    end;
  end;

end;

function TAbstractCadastro.GetLibTintaControleVisualCont: Integer;
begin
  Result := GetControles.Count;
end;

function TAbstractCadastro.GetQueryCadastro: IDataSet;
begin
  Result := qryCadastro;
end;

procedure TAbstractCadastro.GravarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.GravarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.IncluirAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.PesquisarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin

end;

procedure TAbstractCadastro.SetQueryCadastro(
  const dataSet: IDataSet);
begin
  Self.qryCadastro := dataSet;
end;

end.
