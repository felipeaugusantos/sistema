unit untCadastroEmbalagensWeg;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroEmbalagensWeg,
  untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualDBCheckBox,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untDbeCodUniKeyPress, untVariantUtils;

type
  TCadastroEmbalagensWeg = class(TAbstractCadastro)
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

{ TCadastroEmbalagensWeg }

procedure TCadastroEmbalagensWeg.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value := 525;
  tela.GetSelf['Height'].Value := 135;
end;

procedure TCadastroEmbalagensWeg.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroEmbalagensWeg.ConstruirControles;

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
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 60, 19, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade', 'Quantidade:', 260, 19, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 60, 41, 15, 14, 'taRightJustify'));

  AdicionarControle(GetNewDbEditFocus('dbeCodigo', 80, 13, 120, 22, 'ttAlfanumerico', 'EMB_CODEMB'));
  AdicionarControle(GetNewDbEditFocus('dbeQuantidade', 280, 13, 120, 22, 'ttNumerico', 'EMB_QTDEMB'));
  AdicionarControle(GetNewDbEditFocus('dbeCodUni', 80, 35, 120, 22, 'ttAlfanumerico', 'EMB_UNIDAD')
  .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self)));
  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkUsaEmb', 240, 35, 180, 22, 'Utiliza está embalagem?', 'EMB_USAEMB', 'S', 'N'));
end;

function TCadastroEmbalagensWeg.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensWeg.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroEmbalagensWeg.FormatarCampo(
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

function TCadastroEmbalagensWeg.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensWeg.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensWeg.fUnidadeCadastrada(
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

function TCadastroEmbalagensWeg.fValidaCampos(
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
    Else If (Pos(strValorCampo, 'LT_QT_GL_LA_') <= 0) Then
    Begin
      strRetorno := 'Essa não é uma unidade válida (QT LT GL LA)';
      Result := False;
    End;
  End;
end;

function TCadastroEmbalagensWeg.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroEmbalagensWeg.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroEmbalagensWeg.Create;
end;

function TCadastroEmbalagensWeg.GetNomeCampo: string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensWeg.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroEmbalagensWeg.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroEmbalagensWeg.GetNomeCampoUnidade: string;
begin
  Result := 'EMB_UNIDAD';
end;

function TCadastroEmbalagensWeg.GetNomeTabela: string;
begin
  Result := 'WEG_CADEMB';
end;

function TCadastroEmbalagensWeg.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttEmbalagens;
end;

function TCadastroEmbalagensWeg.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroEmbalagensWeg.GetTitulo: string;
begin
  Result := 'Cadastro de Embalagens'
end;

procedure TCadastroEmbalagensWeg.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

end.
