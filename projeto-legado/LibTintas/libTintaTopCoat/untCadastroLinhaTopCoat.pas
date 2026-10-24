{*************************************************************}
{* Classe que representa um cadastro de Linha TopCoat  *}
{**********************************************************AC*}
unit untCadastroLinhaTopCoat;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroLinhaTopCoat = class(TAbstractCadastro)
  private
  protected
    procedure ConstruirControles; override;
  public
    function GetTitulo: string; override;
    function GetCamposDesabilitadosEdit: TCadLibTintasStringArray; override;
    function GetNomeCampo: string; override;
    function GetNomeTabela: string; override;
    function fGetCampoChave(const index: Integer): string; override;
    function fGetCountCamposChave: Integer; override;
    function fValidaCampos(const tela: ITelaCadLibTintas;
      strNomeCampo: string; strValorCampo: string;
      var strRetorno: string): Boolean; override;
    procedure AjustarTela(const tela: ITelaCadLibTintas); override;
    function GetTipoTinta: TTipoTinta; override;
    function GetTipoCadastro: TTipoCadastro; override;

    function fPodeExcluir: Boolean; override;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); override;
    function GetConsulta: IConsulta; override;
    function GetNomeCampoRelacionamento: string; override;
    procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;
    procedure pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string); override;

    function GetNomeCampoUnidade: string; override;
    function GetNomeCampoItem: string; override;


    function fPodeAlterar: Boolean; override;
    function fPodeGravar(const tela: ITelaCadLibTintas;const strState: string): Boolean; override;

    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;


  end;

implementation

uses
  untDbePesquisaItemKeyPress, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao ;

{ TCadastroLinhaTopCoat }


procedure TCadastroLinhaTopCoat.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
end;


procedure TCadastroLinhaTopCoat.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  inherited;

end;

procedure TCadastroLinhaTopCoat.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 129, 20, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 50, 22, 'ttAlfanumerico', 'LIN_CODLIN'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 190, 16, 300, 22, 'ttAlfanumerico', 'LIN_DESCRI'));

end;

procedure TCadastroLinhaTopCoat.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['dbeCodigo']['Text'].Value := '';
  tela['dbeDescricao']['Text'].Value    := '';
end;

function TCadastroLinhaTopCoat.fGetCampoChave(const index: Integer): string;
var
  arrChaves: Array Of String;
begin
  SetLength(arrChaves,1);
  arrChaves[0] := 'LIN_CODLIN';

  Result := arrChaves[index];
end;

function TCadastroLinhaTopCoat.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroLinhaTopCoat.FormatarCampo(
  const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  inherited;

end;

function TCadastroLinhaTopCoat.fPodeAlterar: Boolean;
begin
  Result := true;
end;

function TCadastroLinhaTopCoat.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroLinhaTopCoat.fPodeGravar(const tela: ITelaCadLibTintas;const strState: string): Boolean;
begin
  Result := True;
end;

function TCadastroLinhaTopCoat.fValidaCampos(const tela: ITelaCadLibTintas;
  strNomeCampo: string; strValorCampo: string; var strRetorno: string): Boolean;
begin
  Result := True;

  If (strNomeCampo = 'LIN_CODLIN') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O código deve ser preenchido!';
  End
  Else If (strNomeCampo = 'LIN_DESCRI') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
  End
end;


function TCadastroLinhaTopCoat.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;


function TCadastroLinhaTopCoat.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroLinhaTopCoat.GetNomeCampo: string;
begin
  Result := 'LIN_CODLIN';
end;

function TCadastroLinhaTopCoat.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroLinhaTopCoat.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroLinhaTopCoat.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroLinhaTopCoat.GetNomeTabela: string;
begin
  Result := 'COA_CADLIN';
end;


function TCadastroLinhaTopCoat.GetTitulo: string;
begin
  Result := 'Cadastro de Linha';
end;

procedure TCadastroLinhaTopCoat.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroLinhaTopCoat.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroLinhaTopCoat.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;

end;

function TCadastroLinhaTopCoat.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttLinhas;
end;

function TCadastroLinhaTopCoat.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;


end.
