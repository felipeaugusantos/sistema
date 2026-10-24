unit untCadastroEmbalagensLukscolor2;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress,
  untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untDbeCodUniKeyPress, untVariantUtils;

type
  TCadastroEmbalagensLukscolor2 = class(TAbstractCadastro)
  private
    function fUnidadeCadastrada(strCodUni: String): Boolean;
  protected
    procedure ConstruirControles; override;
  public
    function GetTitulo: string; override;
    function GetConsulta: IConsulta; override;
    function GetCamposDesabilitadosEdit: TCadLibTintasStringArray; override;
    function GetNomeCampo : String; Override;
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

    procedure IncluirAntes(const  tela : ITelaCadLibTintas; Const strState : string); override;
    procedure IncluirDepois(const tela : ITelaCAdLibTintas; Const strState : String); Override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
  end;

implementation

uses
  untIDataSet, untGenericLibTintaControleVisualDBCheckBox;

{ TCadastroEmbalagensLukscolor2 }

procedure TCadastroEmbalagensLukscolor2.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value := 525;
end;

procedure TCadastroEmbalagensLukscolor2.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDesUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   UNI_DESUNI               ' +
      ' FROM                       ' +
      '   CADUNI               ' +
      ' WHERE UNI_CODUNI = :CODUNI ' +
      '   AND UNI_SIGUNI IN ("QT","LT","GL","LA") ', 'UNI_DESUNI', [
        tela['dbeCodUni']['Text'].Value]);

  tela['edtSigUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   UNI_SIGUNI               ' +
      ' FROM                       ' +
      '   CADUNI               ' +
      ' WHERE UNI_CODUNI = :CODUNI ' +
      '   AND UNI_SIGUNI IN ("QT","LT","GL","LA") ', 'UNI_SIGUNI', [
        tela['dbeCodUni']['Text'].Value]);
end;

procedure TCadastroEmbalagensLukscolor2.ConstruirControles;

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
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem', 'Embalagem:', 61, 19, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade', 'Quantidade:', 200, 19, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 61, 41, 36, 14, 'taRightJustify'));

  AdicionarControle(GetNewDbEditFocus('dbeEmbalagem', 100, 13, 60, 22, 'ttAlfanumerico', 'EMB_CODEMB'));
  AdicionarControle(GetNewDbEditFocus('dbeQuantidade', 240, 13, 60, 22, 'ttNumerico', 'EMB_QTDEMB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkUsaEmb', 350, 15, 150, 17, 'Utilizar Embalagem?', 'EMB_USAEMB', 'S', 'N'));


  AdicionarControle(GetNewDbEditFocus('dbeCodUni', 100, 35, 60, 22, 'ttAlfanumerico', 'EMB_UNIDAD')
  .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesUni', 160, 35, 252, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtSigUni', 412, 35, 49, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));


end;

function TCadastroEmbalagensLukscolor2.fGetCampoChave(const index: Integer): string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensLukscolor2.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroEmbalagensLukscolor2.FormatarCampo(
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

function TCadastroEmbalagensLukscolor2.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensLukscolor2.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensLukscolor2.fUnidadeCadastrada(
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

function TCadastroEmbalagensLukscolor2.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroEmbalagensLukscolor2.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
begin
  Result := True;
  CarregarDescricoes(tela);

  if (strNomeCampo = 'EMB_QTDEMB') then
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
    Else If (Pos(strValorCampo, 'QT_LT_GL_LA_') <= 0) Then
    Begin
      strRetorno := 'Essa não é uma unidade válida (LT GL LA QT)';
      Result := False;
    End;
  End;
end;

function TCadastroEmbalagensLukscolor2.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;


function TCadastroEmbalagensLukscolor2.GetNomeCampo: String;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensLukscolor2.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroEmbalagensLukscolor2.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroEmbalagensLukscolor2.GetNomeCampoUnidade: string;
begin
  Result := 'EMB_UNIDAD';
end;

function TCadastroEmbalagensLukscolor2.GetNomeTabela: string;
begin
  Result := 'LKC_CADEMB';
end;

function TCadastroEmbalagensLukscolor2.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttEmbalagens;
end;

function TCadastroEmbalagensLukscolor2.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroEmbalagensLukscolor2.GetTitulo: string;
begin
  Result := 'Cadastro de Embalagens'
end;

procedure TCadastroEmbalagensLukscolor2.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroEmbalagensLukscolor2.IncluirAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesUni']['Text'].Value  := '';
  tela['edtSigUni']['Text'].Value  := '';

end;

procedure TCadastroEmbalagensLukscolor2.IncluirDepois(
  const tela: ITelaCAdLibTintas; const strState: String);
begin
  inherited;
  tela['chkUsaEmb']['Checked'].Value    := True;
end;

procedure TCadastroEmbalagensLukscolor2.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesUni']['Text'].Value := '';
  tela['edtSigUni']['Text'].Value := '';
  CarregarDescricoes(tela);
end;

end.
