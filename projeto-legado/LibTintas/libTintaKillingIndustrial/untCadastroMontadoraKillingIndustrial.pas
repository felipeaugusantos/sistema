{*************************************************************}
{* Classe que representa um cadastro de Montadora KillingIndustrial  *}
{**********************************************************AC*}
unit untCadastroMontadoraKillingIndustrial;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroMontadoraKillingIndustrial = class(TAbstractCadastro)
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
    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean; override;

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

{ TCadastroMontadoraKillingIndustrial }


procedure TCadastroMontadoraKillingIndustrial.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
end;


procedure TCadastroMontadoraKillingIndustrial.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  inherited;

end;

procedure TCadastroMontadoraKillingIndustrial.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 129, 20, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 50, 22, 'ttAlfanumerico', 'MON_CODMON'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 190, 16, 300, 22, 'ttAlfanumerico', 'MON_DESCRI'));

end;

procedure TCadastroMontadoraKillingIndustrial.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['dbeCodigo']['Text'].Value := '';
  tela['dbeDescricao']['Text'].Value    := '';
end;

function TCadastroMontadoraKillingIndustrial.fGetCampoChave(const index: Integer): string;
var
  arrChaves: Array Of String;
begin
  SetLength(arrChaves,1);
  arrChaves[0] := 'MON_CODMON';

  Result := arrChaves[index];
end;

function TCadastroMontadoraKillingIndustrial.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroMontadoraKillingIndustrial.FormatarCampo(
  const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  inherited;

end;

function TCadastroMontadoraKillingIndustrial.fPodeAlterar: Boolean;
begin
  Result := true;
end;

function TCadastroMontadoraKillingIndustrial.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroMontadoraKillingIndustrial.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := True;
end;

function TCadastroMontadoraKillingIndustrial.fValidaCampos(const tela: ITelaCadLibTintas;
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


function TCadastroMontadoraKillingIndustrial.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;


function TCadastroMontadoraKillingIndustrial.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroMontadoraKillingIndustrial.GetNomeCampo: string;
begin
  Result := 'MON_CODMON';
end;

function TCadastroMontadoraKillingIndustrial.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroMontadoraKillingIndustrial.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroMontadoraKillingIndustrial.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroMontadoraKillingIndustrial.GetNomeTabela: string;
begin
  Result := 'KIN_CADMON';
end;


function TCadastroMontadoraKillingIndustrial.GetTitulo: string;
begin
  Result := 'Cadastro de Montadora';
end;

procedure TCadastroMontadoraKillingIndustrial.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroMontadoraKillingIndustrial.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['dbeDescricao']['Text'].Value    := '';
end;

procedure TCadastroMontadoraKillingIndustrial.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;

end;

function TCadastroMontadoraKillingIndustrial.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttMontadoras;
end;

function TCadastroMontadoraKillingIndustrial.GetTipoTinta: TTipoTinta;
begin
  Result := ttIndustrial;
end;


end.
