unit untCadastroEmbalagensResicolor;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroEmbalagensResicolor,
  untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untGenericLibTintaControleVisualDBCheckBox,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untDbeCodUniKeyPress, untVariantUtils;

type
  TCadastroEmbalagensResicolor = class(TAbstractCadastro)
  private
    function fUnidadeCadastrada(strCodUni: String): Boolean;
  protected
    procedure ConstruirControles; override;
  public
    function GetTitulo: string; override;
    function GetConsulta: IConsulta; override;
    function GetCamposDesabilitadosEdit: TCadLibTintasStringArray; override;
    function GetNomeCampo: string; override;
    function GetNomeTabela: string; override;
    function GetNomeCampoRelacionamento: string; override;
    procedure pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string); override;
    function fGetCampoChave(const index: Integer): string; override;
    function fGetCountCamposChave: Integer; override;
    function fValidaCampos(const tela: ITelaCadLibTintas;
      strNomeCampo: string; strValorCampo: string;
      var strRetorno: string): Boolean; override;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); override;
    procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;
    procedure AjustarTela(const tela: ITelaCadLibTintas); override;

    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function GetNomeCampoUnidade: string; override;
    function GetNomeCampoItem: string; override;
  end;

implementation

uses
  untIDataSet;

{ TCadastroEmbalagensResicolor }

procedure TCadastroEmbalagensResicolor.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value := 525;
end;

procedure TCadastroEmbalagensResicolor.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroEmbalagensResicolor.ConstruirControles;

  function GetNewDbEditFocus(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
    const TipoTexto: string; const strDataField: string): ILibTintaControleVisual;
  begin
    Result := TGenericLibTintaControleVisualDBEditFocus.Create(strNome, intLeft, intTop, intWidth, intHeight, TipoTexto, strDataField)
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', clWindow))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', clInfoBk))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('RequeridoColor', clRed))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TipoTexto', TipoTexto))
  end;

begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 61, 19, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade', 'Quantidade:', 61, 41, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 201, 41, 36, 14, 'taRightJustify'));

  AdicionarControle(GetNewDbEditFocus('dbeCodigo', 100, 13, 70, 22, 'ttAlfanumerico', 'EMB_CODEMB'));
  AdicionarControle(GetNewDbEditFocus('dbeQuantidade', 100, 35, 70, 22, 'ttNumerico', 'EMB_QTDEMB'));
  AdicionarControle(GetNewDbEditFocus('dbeCodUni', 244, 35, 70, 22, 'ttAlfanumerico', 'EMB_UNIDAD')
  .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self)));
  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkEmbalagem', 320, 35, 130, 22, 'Utiliza esta Embalagem?', 'EMB_USAEMB', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));
end;

function TCadastroEmbalagensResicolor.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensResicolor.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroEmbalagensResicolor.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(strNomeCampo, ['EMB_QTDEMB']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end;
end;

function TCadastroEmbalagensResicolor.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensResicolor.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensResicolor.fUnidadeCadastrada(
  strCodUni: String): Boolean;
var
  strDesUni: String;
begin
  strDesUni := TVariantUtils.IfNull(TAutcomTintaFactory.Get.GetValorCampo(
                      ' SELECT                     ' +
                      '   UNI_DESUNI               ' +
                      ' FROM                       ' +
                      '   CADUNI                   ' +
                      ' WHERE UNI_CODUNI = :CODUNI ', 'UNI_DESUNI', strCodUni), '');

  Result := Not TStrUtils.fEmptyStr(strDesUni);
end;

function TCadastroEmbalagensResicolor.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
begin
  Result := True;

  If (strNomeCampo = 'EMB_CODEMB') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O código deve ser preenchido!';
  End
  Else if (strNomeCampo = 'EMB_QTDEMB') then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A Quantidade de ser preenchida !';
    End
    Else If strToFloatDef(strValorCampo, 0) <= 0 Then
    Begin
      Result := False;
      strRetorno := 'A Quantidade da embalagem deve ser maior que Zero!';
    End
  End
  Else if (strNomeCampo = 'EMB_UNIDAD') then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A Unidade de ser preenchida!';
    End
    Else If Not fUnidadeCadastrada(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'Essa unidade não está cadastrada!';
    End
    Else If (Pos(strValorCampo, 'LT_GL_LA_QT_') <= 0) Then
    Begin
      strRetorno := 'Essa não é uma unidade válida (QT LT GL LA)';
      Result := False;
    End;
  End;
end;

function TCadastroEmbalagensResicolor.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroEmbalagensResicolor.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroEmbalagensResicolor.Create;
end;

function TCadastroEmbalagensResicolor.GetNomeCampo: string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensResicolor.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroEmbalagensResicolor.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroEmbalagensResicolor.GetNomeCampoUnidade: string;
begin
  Result := 'EMB_UNIDAD';
end;

function TCadastroEmbalagensResicolor.GetNomeTabela: string;
begin
  Result := 'RSI_CADEMB';
end;

function TCadastroEmbalagensResicolor.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttEmbalagens;
end;

function TCadastroEmbalagensResicolor.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroEmbalagensResicolor.GetTitulo: string;
begin
  Result := 'Cadastro de Embalagens'
end;

procedure TCadastroEmbalagensResicolor.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

end.
