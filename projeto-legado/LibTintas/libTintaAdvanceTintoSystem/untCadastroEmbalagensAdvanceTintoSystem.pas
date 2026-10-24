unit untCadastroEmbalagensAdvanceTintoSystem;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroEmbalagensAdvanceTintoSystem,
  untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untDbeCodUniKeyPress, untVariantUtils;

type
  TCadastroEmbalagensAdvanceTintoSystem = class(TAbstractCadastro)
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

{ TCadastroEmbalagensAdvanceTintoSystem }

procedure TCadastroEmbalagensAdvanceTintoSystem.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value := 525;
end;

procedure TCadastroEmbalagensAdvanceTintoSystem.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDesUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   UNI_DESUNI               ' +
      ' FROM                       ' +
      '   CADUNI                   ' +
      ' WHERE UNI_CODUNI = :CODUNI ' +
      '   AND UNI_SIGUNI IN ("QT","LT","GL","LA") ', 'UNI_DESUNI', [tela['dbeCodUni']['Text'].Value]);

  tela['edtSigUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   UNI_SIGUNI               ' +
      ' FROM                       ' +
      '   CADUNI                   ' +
      ' WHERE UNI_CODUNI = :CODUNI ' +
      '   AND UNI_SIGUNI IN ("QT","LT","GL","LA") ', 'UNI_SIGUNI', [
        tela['dbeCodUni']['Text'].Value
      ]);
end;

procedure TCadastroEmbalagensAdvanceTintoSystem.ConstruirControles;

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
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 50, 19, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 175, 19, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 50, 41, 20, 14, 'taRightJustify'));

  AdicionarControle(GetNewDbEditFocus('dbeCodigo', 75, 15, 60, 22, 'ttAlfanumerico', 'EMB_CODEMB'));
  AdicionarControle(GetNewDbEditFocus('dbeDescricao', 200, 15, 275, 22, 'ttAlfanumerico', 'EMB_DESCRI'));
  AdicionarControle(GetNewDbEditFocus('dbeCodUni', 75, 37, 60, 22, 'ttAlfanumerico', 'EMB_CODUNI')
  .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesUni', 135, 37, 300, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtSigUni', 435, 37, 40, 20, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));
end;

function TCadastroEmbalagensAdvanceTintoSystem.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensAdvanceTintoSystem.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroEmbalagensAdvanceTintoSystem.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(strNomeCampo, ['EMB_TAMEMB']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end;
end;

function TCadastroEmbalagensAdvanceTintoSystem.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensAdvanceTintoSystem.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensAdvanceTintoSystem.fUnidadeCadastrada(
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

function TCadastroEmbalagensAdvanceTintoSystem.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
begin
  Result := True;
  If (strNomeCampo = 'EMB_CODEMB') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O código deve ser preenchido!';
  End
  Else If (strNomeCampo = 'EMB_DESCRI') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := Format('A %s deve ser preenchida!', ['Descrição']);
  End
  Else if (strNomeCampo = 'EMB_CODUNI') then
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
      strRetorno := 'Essa não é uma unidade válida (QT LT GL LA)';
      Result := False;
    End
    Else
      CarregarDescricoes(tela);
  End;
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroEmbalagensAdvanceTintoSystem.Create;
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetNomeCampo: string;
begin
  Result := 'EMB_CODEMB';
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetNomeCampoUnidade: string;
begin
  Result := 'EMB_CODUNI';
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetNomeTabela: string;
begin
  Result := 'ADT_CADEMB';
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttEmbalagens;
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroEmbalagensAdvanceTintoSystem.GetTitulo: string;
begin
  Result := 'Cadastro de Embalagens'
end;

procedure TCadastroEmbalagensAdvanceTintoSystem.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

end.
