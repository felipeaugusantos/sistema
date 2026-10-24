unit untCadastroEmbalagensDacar;

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
  untTipoCadastro, untTipoTinta, untDbeCodUniKeyPress, untVariantUtils,
  untDbeUniDacEmbalagemKeyPressDacar;

type
  TCadastroEmbalagensDacar = class(TAbstractCadastro)
  private
    function fUnidadeCadastrada(strCodUni: String): Boolean;
    function fUnidadeDacarCadastrada(strCodUni: String): Boolean;
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

    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
  end;

implementation

uses
  untIDataSet;

{ TCadastroEmbalagensDacar }

procedure TCadastroEmbalagensDacar.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value := 525;
end;

procedure TCadastroEmbalagensDacar.CarregarDescricoes(
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

procedure TCadastroEmbalagensDacar.ConstruirControles;

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
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUniDac', 'Unidade Dacar:', 61, 19, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade Autcom:', 61, 41, 36, 14, 'taRightJustify'));

  AdicionarControle(GetNewDbEditFocus('dbeUniDac', 100, 13, 51, 22, 'ttAlfanumerico', 'DAC_UNIDAC')
   .AdicionarEvento(TDbeUniDacEmbalagemKeyPressDacar.Create(Self)));

  AdicionarControle(GetNewDbEditFocus('dbeCodUni', 100, 35, 70, 22, 'ttAlfanumerico', 'DAC_UNIAUT')
   .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesUni', 170, 35, 252, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtSigUni', 422, 35, 49, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));
end;

function TCadastroEmbalagensDacar.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'DAC_UNIDAC';
end;

function TCadastroEmbalagensDacar.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroEmbalagensDacar.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  //
end;

function TCadastroEmbalagensDacar.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensDacar.fPodeExcluir: Boolean;
begin
  Result := True;
end;

function TCadastroEmbalagensDacar.fUnidadeCadastrada(
  strCodUni: String): Boolean;
var
  strDesUni: String;
begin
  strDesUni := TVariantUtils.IfNull(
                 TAutcomTintaFactory.Get.GetValorCampo(
                      ' SELECT                     ' +
                      '   UNI_DESUNI               ' +
                      ' FROM                       ' +
                      '   CADUNI                   ' +
                      ' WHERE UNI_CODUNI = :CODUNI ', 'UNI_DESUNI', strCodUni), '');

  Result := Not TStrUtils.fEmptyStr(strDesUni);
end;

function TCadastroEmbalagensDacar.fUnidadeDacarCadastrada(
  strCodUni: String): Boolean;
begin
  Result := Not TStrUtils.fEmptyStr(
    TVariantUtils.IfNull(
      TAutcomTintaFactory.Get.GetValorCampo(
                      ' SELECT                     ' +
                      '   DISTINCT BAS_UNIDAD      ' +
                      ' FROM                       ' +
                      '   DAC_CADBAS               ' +
                      ' WHERE BAS_UNIDAD = :CODUNI ', 'BAS_UNIDAD', strCodUni), ''));
end;

function TCadastroEmbalagensDacar.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
begin
  Result := True;
  CarregarDescricoes(tela);

  If (strNomeCampo = 'DAC_UNIDAC') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A Unidade Dacar deve ser preenchida!';

    If Result Then
    Begin
      If Not fUnidadeDacarCadastrada(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'Essa Unidade Dacar não está cadastrada!';
      End;
    End;
  End
  Else if (strNomeCampo = 'DAC_UNIAUT') then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A Unidade Autcom deve ser preenchida!';
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

function TCadastroEmbalagensDacar.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroEmbalagensDacar.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroEmbalagensDacar.GetNomeCampo: string;
begin
  Result := 'DAC_UNIDAC';
end;

function TCadastroEmbalagensDacar.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroEmbalagensDacar.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroEmbalagensDacar.GetNomeCampoUnidade: string;
begin
  Result := 'DAC_UNIAUT';
end;

function TCadastroEmbalagensDacar.GetNomeTabela: string;
begin
  Result := 'DAC_UNIDAC';
end;

function TCadastroEmbalagensDacar.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttEmbalagens;
end;

function TCadastroEmbalagensDacar.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroEmbalagensDacar.GetTitulo: string;
begin
  Result := 'Cadastro de Embalagens'
end;

procedure TCadastroEmbalagensDacar.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroEmbalagensDacar.IncluirAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesUni']['Text'].Value := '';
  tela['edtSigUni']['Text'].Value := '';
end;

procedure TCadastroEmbalagensDacar.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesUni']['Text'].Value := '';
  tela['edtSigUni']['Text'].Value := '';
  CarregarDescricoes(tela);
end;

end.
