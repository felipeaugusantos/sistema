unit untCadastroEmbalagensCoralImobiliaria;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroEmbalagensCoralImobiliaria,
  untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untDbeCodUniKeyPress, untVariantUtils;

type
  TCadastroEmbalagensCoralImobiliaria = class(TAbstractCadastro)
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

{ TCadastroEmbalagensCoralImobiliaria }

procedure TCadastroEmbalagensCoralImobiliaria.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value := 525;
end;

procedure TCadastroEmbalagensCoralImobiliaria.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroEmbalagensCoralImobiliaria.ConstruirControles;

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
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade', 'Quantidade em ML:', 61, 41, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 201, 41, 36, 14, 'taRightJustify'));

  AdicionarControle(GetNewDbEditFocus('dbeCodigo', 100, 13, 70, 22, 'ttAlfanumerico', 'EMB_CODEMB'));
  AdicionarControle(GetNewDbEditFocus('dbeQuantidade', 100, 35, 70, 22, 'ttNumerico', 'EMB_QTDEMB'));
  AdicionarControle(GetNewDbEditFocus('dbeCodUni', 244, 35, 70, 22, 'ttAlfanumerico', 'EMB_UNIDAD')
  .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self)));
end;

function TCadastroEmbalagensCoralImobiliaria.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensCoralImobiliaria.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroEmbalagensCoralImobiliaria.FormatarCampo(
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

function TCadastroEmbalagensCoralImobiliaria.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensCoralImobiliaria.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensCoralImobiliaria.fUnidadeCadastrada(
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

function TCadastroEmbalagensCoralImobiliaria.fValidaCampos(
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
    Else If (Pos(strValorCampo, 'LT_GL_LA_') <= 0) Then
    Begin
      strRetorno := 'Essa não é uma unidade válida (LT GL LA)';
      Result := False;
    End;
  End;
end;

function TCadastroEmbalagensCoralImobiliaria.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroEmbalagensCoralImobiliaria.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroEmbalagensCoralImobiliaria.Create;
end;

function TCadastroEmbalagensCoralImobiliaria.GetNomeCampo: string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensCoralImobiliaria.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroEmbalagensCoralImobiliaria.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroEmbalagensCoralImobiliaria.GetNomeCampoUnidade: string;
begin
  Result := 'EMB_UNIDAD';
end;

function TCadastroEmbalagensCoralImobiliaria.GetNomeTabela: string;
begin
  Result := 'CORIMO_CADEMB';
end;

function TCadastroEmbalagensCoralImobiliaria.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttEmbalagens;
end;

function TCadastroEmbalagensCoralImobiliaria.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroEmbalagensCoralImobiliaria.GetTitulo: string;
begin
  Result := 'Cadastro de Embalagens'
end;

procedure TCadastroEmbalagensCoralImobiliaria.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

end.
