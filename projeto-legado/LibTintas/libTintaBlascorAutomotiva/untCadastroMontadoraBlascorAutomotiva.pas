{*************************************************************}
{* Classe que representa um cadastro de Montadora BlascorAutomotiva  *}
{**********************************************************AC*}
unit untCadastroMontadoraBlascorAutomotiva;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroMontadoraBlascorAutomotiva = class(TAbstractCadastro)
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

{ TCadastroMontadoraBlascorAutomotiva }


procedure TCadastroMontadoraBlascorAutomotiva.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
end;


procedure TCadastroMontadoraBlascorAutomotiva.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  inherited;

end;

procedure TCadastroMontadoraBlascorAutomotiva.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 129, 20, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 50, 22, 'ttAlfanumerico', 'MON_CODMON'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 190, 16, 300, 22, 'ttAlfanumerico', 'MON_DESCRI'));

end;

procedure TCadastroMontadoraBlascorAutomotiva.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['dbeCodigo']['Text'].Value := '';
  tela['dbeDescricao']['Text'].Value    := '';
end;

function TCadastroMontadoraBlascorAutomotiva.fGetCampoChave(const index: Integer): string;
var
  arrChaves: Array Of String;
begin
  SetLength(arrChaves,1);
  arrChaves[0] := 'MON_CODMON';

  Result := arrChaves[index];
end;

function TCadastroMontadoraBlascorAutomotiva.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroMontadoraBlascorAutomotiva.FormatarCampo(
  const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  inherited;

end;

function TCadastroMontadoraBlascorAutomotiva.fPodeAlterar: Boolean;
begin
  Result := true;
end;

function TCadastroMontadoraBlascorAutomotiva.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroMontadoraBlascorAutomotiva.fPodeGravar(const tela: ITelaCadLibTintas;const strState: string): Boolean;
begin
  Result := True;
end;

function TCadastroMontadoraBlascorAutomotiva.fValidaCampos(const tela: ITelaCadLibTintas;
  strNomeCampo: string; strValorCampo: string; var strRetorno: string): Boolean;
begin
  Result := True;

  If (strNomeCampo = 'MON_CODMON') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O código deve ser preenchido!';
  End
  Else If (strNomeCampo = 'MON_DESCRI') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
  End
end;


function TCadastroMontadoraBlascorAutomotiva.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;


function TCadastroMontadoraBlascorAutomotiva.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroMontadoraBlascorAutomotiva.GetNomeCampo: string;
begin
  Result := 'MON_CODMON';
end;

function TCadastroMontadoraBlascorAutomotiva.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroMontadoraBlascorAutomotiva.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroMontadoraBlascorAutomotiva.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroMontadoraBlascorAutomotiva.GetNomeTabela: string;
begin
  Result := 'BLA_CADMON';
end;


function TCadastroMontadoraBlascorAutomotiva.GetTitulo: string;
begin
  Result := 'Cadastro de Montadora';
end;

procedure TCadastroMontadoraBlascorAutomotiva.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroMontadoraBlascorAutomotiva.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroMontadoraBlascorAutomotiva.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;

end;

function TCadastroMontadoraBlascorAutomotiva.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttMontadoras;
end;

function TCadastroMontadoraBlascorAutomotiva.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;


end.
