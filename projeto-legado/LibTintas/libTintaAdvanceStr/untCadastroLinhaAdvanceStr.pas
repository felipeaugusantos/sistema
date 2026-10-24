{*************************************************************}
{* Classe que representa um cadastro de Linha AdvanceStr  *}
{**********************************************************AC*}
unit untCadastroLinhaAdvanceStr;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroLinhaAdvanceStr = class(TAbstractCadastro)
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

{ TCadastroLinhaAdvanceStr }


procedure TCadastroLinhaAdvanceStr.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
end;


procedure TCadastroLinhaAdvanceStr.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  inherited;

end;

procedure TCadastroLinhaAdvanceStr.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 129, 20, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 50, 22, 'ttAlfanumerico', 'LIN_CODLIN'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 190, 16, 300, 22, 'ttAlfanumerico', 'LIN_DESCRI'));

end;

procedure TCadastroLinhaAdvanceStr.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['dbeCodigo']['Text'].Value := '';
  tela['dbeDescricao']['Text'].Value    := '';
end;

function TCadastroLinhaAdvanceStr.fGetCampoChave(const index: Integer): string;
var
  arrChaves: Array Of String;
begin
  SetLength(arrChaves,1);
  arrChaves[0] := 'LIN_CODLIN';

  Result := arrChaves[index];
end;

function TCadastroLinhaAdvanceStr.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroLinhaAdvanceStr.FormatarCampo(
  const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  inherited;

end;

function TCadastroLinhaAdvanceStr.fPodeAlterar: Boolean;
begin
  Result := true;
end;

function TCadastroLinhaAdvanceStr.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroLinhaAdvanceStr.fPodeGravar(const tela: ITelaCadLibTintas;const strState: string): Boolean;
begin
  Result := True;
end;

function TCadastroLinhaAdvanceStr.fValidaCampos(const tela: ITelaCadLibTintas;
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


function TCadastroLinhaAdvanceStr.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;


function TCadastroLinhaAdvanceStr.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroLinhaAdvanceStr.GetNomeCampo: string;
begin
  Result := 'LIN_CODLIN';
end;

function TCadastroLinhaAdvanceStr.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroLinhaAdvanceStr.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroLinhaAdvanceStr.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroLinhaAdvanceStr.GetNomeTabela: string;
begin
  Result := 'ADS_CADLIN';
end;


function TCadastroLinhaAdvanceStr.GetTitulo: string;
begin
  Result := 'Cadastro de Linha';
end;

procedure TCadastroLinhaAdvanceStr.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroLinhaAdvanceStr.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroLinhaAdvanceStr.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;

end;

function TCadastroLinhaAdvanceStr.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttLinhas;
end;

function TCadastroLinhaAdvanceStr.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;


end.
