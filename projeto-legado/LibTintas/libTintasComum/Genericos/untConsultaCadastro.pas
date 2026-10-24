{****************************************************************************}
{* Classe abstrata contendo os metodos em comum de uma consulta (IConsulta) *}
{*************************************************************************PH*}
unit untConsultaCadastro;

interface

uses
  untIConsulta, Classes, SysUtils;

Type
  TConsultaCadastro = class abstract(TInterfacedObject, IConsulta) 
  private
    stlCampos: TStringList;
    stlDesCampos: TStringList;
    stlOperadors: TStringList;

    stlIndCampos: TStringList;
    stlIndDesCampos: TStringList;
  protected
    procedure pAdicionar(strNomeCampo, strDesCampo, strOperador: String);
    procedure pAdicionarIndice(strCampos, strDesCampo: String);
  public
    function fGetCaptionColuna(strNomeCampo: String): String; overload;
    function fGetCaptionColuna(intPos: Integer): String; overload;
    function fGetCaptionColunaVisivel(intPos: Integer): String;
    function fGetDisponivel(intPos: Integer): Boolean; overload;
    function fGetDisponivel(strNomeCampo: String): Boolean; overload;
    function fGetNomeCampoColuna(intPos: Integer): String; overload;
    function fGetNomeCampoColuna(strCaptionColuna: String): String; overload;
    function fGetNomeCampoColunaVisivel(intPos: Integer): String;
    function fGetOperador(strNomeCampo: String): String; overload;
    function fGetOperador(intIndex: Integer): String; overload;
    function fGetPos(strNomeCampo: String): Integer;
    function fGetQtdColunas: Integer;
    function fGetQtdColunasVisiveis: Integer;
    function fGetSelect(blnTodos: Boolean): String; virtual; abstract;
    function fGetVisivel(intPos: Integer): Boolean;
    procedure fSetPos(strNomeCampo: String; intPos: Integer);
    procedure fSetVisivel(intPos: Integer; blnValor: Boolean); overload;
    procedure fSetVisivel(strNomeCampo: String; blnValor: Boolean); overload;
    procedure pRestaurarPadrao;
    procedure pSalvarConfs;
    function fGetCamposIndice(intIndex: Integer): String;
    function fGetDesCamposIndice(intIndex: Integer): String;
    function fGetQtdIndices: Integer;
    function fGetTodosCamposIndices: String;
    function fGetTodosDesCamposIndices: String;
    procedure pSetCamposIndice(intIndex: Integer; strCampos: String);
    procedure pSetDesCamposIndice(intIndex: Integer; strDesCampos: String);
    procedure pSetQtdIndices(intQtdIndices: Integer);

    constructor Create; virtual;
    destructor Destroy; override;

  End;

implementation



{ TConsultaCadastro }

constructor TConsultaCadastro.Create;
begin
  stlCampos := TStringList.Create;
  stlDesCampos := TStringList.Create;
  stlOperadors := TStringList.Create;

  stlIndCampos := TStringList.Create;
  stlIndDesCampos := TStringList.Create;
end;

destructor TConsultaCadastro.Destroy;
begin
  FreeAndNil(stlCampos);
  FreeAndNil(stlDesCampos);
  FreeAndNil(stlIndCampos);
  FreeAndNil(stlIndDesCampos);
  FreeAndNil(stlOperadors);
  inherited;
end;

function TConsultaCadastro.fGetCamposIndice(intIndex: Integer): String;
begin
  Result := stlIndCampos[intIndex];
end;

function TConsultaCadastro.fGetCaptionColuna(strNomeCampo: String): String;
begin
  Result := stlDesCampos[stlCampos.IndexOf(strNomeCampo)];
end;

function TConsultaCadastro.fGetCaptionColuna(intPos: Integer): String;
begin
  Result := stlDesCampos[intPos];
end;

function TConsultaCadastro.fGetCaptionColunaVisivel(
  intPos: Integer): String;
begin
  Result := fGetCaptionColuna(intPos);
end;

function TConsultaCadastro.fGetDesCamposIndice(intIndex: Integer): String;
begin
  Result := stlIndDesCampos[intIndex];
end;

function TConsultaCadastro.fGetDisponivel(intPos: Integer): Boolean;
begin
  Result := (intPos >= 0) And (intPos < stlCampos.Count);
end;

function TConsultaCadastro.fGetNomeCampoColuna(intPos: Integer): String;
begin
  Result := stlCampos[intPos];
end;

function TConsultaCadastro.fGetDisponivel(strNomeCampo: String): Boolean;
begin
  Result := (stlCampos.IndexOf(strNomeCampo) >= 0);
end;

function TConsultaCadastro.fGetNomeCampoColuna(
  strCaptionColuna: String): String;
begin
  Result := stlCampos[stlDesCampos.IndexOf(strCaptionColuna)];
end;

function TConsultaCadastro.fGetNomeCampoColunaVisivel(
  intPos: Integer): String;
begin
  Result := fGetNomeCampoColuna(intPos);
end;

function TConsultaCadastro.fGetOperador(strNomeCampo: String): String;
begin
  Result := stlOperadors[stlCampos.IndexOf(strNomeCampo)];
end;

function TConsultaCadastro.fGetOperador(intIndex: Integer): String;
begin
  Result := stlOperadors[intIndex];
end;

function TConsultaCadastro.fGetPos(strNomeCampo: String): Integer;
begin
  Result := stlCampos.IndexOf(strNomeCampo);
end;

function TConsultaCadastro.fGetQtdColunas: Integer;
begin
  Result := stlCampos.Count;
end;

function TConsultaCadastro.fGetQtdColunasVisiveis: Integer;
begin
  Result := fGetQtdColunas;
end;

function TConsultaCadastro.fGetQtdIndices: Integer;
begin
  Result := stlIndCampos.Count;
end;

function TConsultaCadastro.fGetTodosCamposIndices: String;
begin
  Result := stlIndCampos.Text;
end;

function TConsultaCadastro.fGetTodosDesCamposIndices: String;
begin
  Result := stlIndDesCampos.Text;
end;

function TConsultaCadastro.fGetVisivel(intPos: Integer): Boolean;
begin
  Result := fGetDisponivel(intPos);
end;

procedure TConsultaCadastro.fSetPos(strNomeCampo: String; intPos: Integer);
begin
//
end;

procedure TConsultaCadastro.fSetVisivel(strNomeCampo: String;
  blnValor: Boolean);
begin
//
end;

procedure TConsultaCadastro.fSetVisivel(intPos: Integer;
  blnValor: Boolean);
begin
//
end;

procedure TConsultaCadastro.pAdicionar(strNomeCampo, strDesCampo, strOperador: String);
begin
  stlCampos.Add(strNomeCampo);
  stlDesCampos.Add(strDesCampo);
  stlOperadors.Add(strOperador);
end;

procedure TConsultaCadastro.pRestaurarPadrao;
begin
//
end;

procedure TConsultaCadastro.pSalvarConfs;
begin
//
end;

procedure TConsultaCadastro.pSetCamposIndice(intIndex: Integer;
  strCampos: String);
begin
//
end;

procedure TConsultaCadastro.pSetDesCamposIndice(intIndex: Integer;
  strDesCampos: String);
begin
//
end;

procedure TConsultaCadastro.pSetQtdIndices(intQtdIndices: Integer);
begin
//  
end;

procedure TConsultaCadastro.pAdicionarIndice(strCampos,
  strDesCampo: String);
begin
  stlIndCampos.Add(strCampos);
  stlIndDesCampos.Add(strDesCampo);
end;

end.
