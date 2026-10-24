{*************************************************************}
{* Classe que representa um cadastro de Linha MiniFabrica  *}
{**********************************************************AC*}
unit untCadastroLinhaMiniFabrica;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroLinhaMiniFabrica = class(TAbstractCadastro)
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

{ TCadastroLinhaMiniFabrica }


procedure TCadastroLinhaMiniFabrica.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
end;


procedure TCadastroLinhaMiniFabrica.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  inherited;

end;

procedure TCadastroLinhaMiniFabrica.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 129, 20, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 50, 22, 'ttAlfanumerico', 'LIN_CODLIN'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 190, 16, 300, 22, 'ttAlfanumerico', 'LIN_DESCRI'));

end;

procedure TCadastroLinhaMiniFabrica.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['dbeCodigo']['Text'].Value := '';
  tela['dbeDescricao']['Text'].Value    := '';
end;

function TCadastroLinhaMiniFabrica.fGetCampoChave(const index: Integer): string;
var
  arrChaves: Array Of String;
begin
  SetLength(arrChaves,1);
  arrChaves[0] := 'LIN_CODLIN';

  Result := arrChaves[index];
end;

function TCadastroLinhaMiniFabrica.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroLinhaMiniFabrica.FormatarCampo(
  const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  inherited;

end;

function TCadastroLinhaMiniFabrica.fPodeAlterar: Boolean;
begin
  Result := true;
end;

function TCadastroLinhaMiniFabrica.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroLinhaMiniFabrica.fPodeGravar(const tela: ITelaCadLibTintas;const strState: string): Boolean;
begin
  Result := True;
end;

function TCadastroLinhaMiniFabrica.fValidaCampos(const tela: ITelaCadLibTintas;
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


function TCadastroLinhaMiniFabrica.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;


function TCadastroLinhaMiniFabrica.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroLinhaMiniFabrica.GetNomeCampo: string;
begin
  Result := 'LIN_CODLIN';
end;

function TCadastroLinhaMiniFabrica.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroLinhaMiniFabrica.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroLinhaMiniFabrica.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroLinhaMiniFabrica.GetNomeTabela: string;
begin
  Result := 'MIF_CADLIN';
end;


function TCadastroLinhaMiniFabrica.GetTitulo: string;
begin
  Result := 'Cadastro de Linha';
end;

procedure TCadastroLinhaMiniFabrica.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroLinhaMiniFabrica.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroLinhaMiniFabrica.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;

end;

function TCadastroLinhaMiniFabrica.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttLinhas;
end;

function TCadastroLinhaMiniFabrica.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;


end.
