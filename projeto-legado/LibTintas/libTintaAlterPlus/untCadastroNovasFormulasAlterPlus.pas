unit untCadastroNovasFormulasAlterPlus;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteAlterPlus, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasAlterPlus = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;
    function fPedidoAberto(strPedido: String; blnResult: Boolean): Boolean;
    function fVerificaColoranteVazio(strNomCam: String; intCont: Integer; strColorante: String): Boolean;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function fValidarCadBas(strBase: String = ''; strProduto: String = ''; strUnidade: String = ''): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
    function fCampoPreenchidoCol(strCodCol: String; blnCampoVazio: Boolean): Boolean;
    function fCampoNaoPreenchidoCol(strCodCol: String; blnCampoVazio: Boolean): Boolean;
    function fInformouColorante(strColorante, strQuantidade1, strQuantidade2: String): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadALP;
    procedure pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
    procedure pAtualizaNfm;


    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fExisteUnidadeLitro(strUniBas, strUniNfm: String): Boolean;
    function fExisteUnidadeGalao(strUniBas, strUniNfm :String): Boolean;
    function fExisteUnidadeLata(strUniBas, strUniNfm: String): Boolean;
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Double;
    function fRetEmbalagemUnidade(strUnidade: String): Double;
    function fRetDescUnidade(strCodUni: String): String;
    function fRetDescricaoBase : String;

    function fRetMenorUnidade(strProdut, strCodBas, strUnidad: String): String;
    function fRetMenorVolume(strProduto, strBase, strUnidade: String): Double;
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
    function fVerificaNovFormulas(strCodNfm: String): Boolean; Override;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); override;
    procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;
    procedure AjustarTela(const tela: ITelaCadLibTintas); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AtivarNovasFormulas(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure CancelarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    function fProdutoExiste(strProduto : String) : Boolean;


    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    property blnAtualizaUni: Boolean read blnAtualizaUnidade write blnAtualizaUnidade;
    property strUnidade: String read strUnidadeMenor write strUnidadeMenor;
    function GetPreencherDBRadioGroup(): Boolean; Override;
    procedure pAjustarRadioGroup(const tela: ITelaCadLibTintas; stlItems: TStrings); Override;

    function fVerificaUnidade(blnAtualizar: Boolean; strUnidadeMenor: String): Boolean;
    function fRetornaUnidades(strUnidade: String): String;
    function fRetornaMsgUnidades(strUnidades: String; intCount: Integer): String;
    function fRetornaMsgGalao(strUnidades: String; intCount: Integer): String;
    function fRetornaMsgLata(strUnidades: String; intCount: Integer): String;
    function fRetornaMsgBalde(strUnidades: String; intCount: Integer): String;
    function fRetornaUnidadeMenor(strLitro, strGalao, strLata, strBalde: String): String;
    function fVerificaDesAtiFormula(strCodCol: String; strState: String): Boolean;
    function fVerificaColoranteVazioQtdPulso(strCodCol, strQuantidade: String): Boolean;
  end;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasAlterPlus, untDbeCodColKeyPressAlterPlus,
  untNovasFormulasEmbalagens, untDbeCodProKeyPressNovasFormulasAlterPlus,
  untGravandoExecucaoAlterPlusNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untDbeCodUniKeyPressAlterPlus, untDbeCodBasKeyPressNovasFormulasAlterPlus,
  untDbeProdutoKeyPressAlterPlus, untTypesSistema;
{ TCadastroNovasFormulasAlterPlus }

procedure TCadastroNovasFormulasAlterPlus.AjustarTela(const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 520;
  tela.GetSelf['Width'].Value := 780;

  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela['dbeVolume']['Enabled'].Value       := False;

  pBotaoAtivarNfm(tela);

  blnAtualizaUnidade := False;
  strUnidadeMenor    := '';
end;

procedure TCadastroNovasFormulasAlterPlus.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
//  if not fPodeAlterar then
//    exit;
end;

procedure TCadastroNovasFormulasAlterPlus.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);

  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela['dbeCodUni']['Enabled'].Value       := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela['dbeBase']['Enabled'].Value         := False;
  tela['dbeVolume']['Enabled'].Value       := False;
  pLimparQuantidades(GetQueryCadastro);

  tela.SelectNext;
End;

procedure TCadastroNovasFormulasAlterPlus.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If fVerificaDesAtiFormula(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString, strState) Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm(tela);
      pAtualizaNfm;
    End;
  End;
end;

procedure TCadastroNovasFormulasAlterPlus.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasAlterPlus.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDescricaoBase']['Text'].Value := fRetDescricaoBase;
end;

procedure TCadastroNovasFormulasAlterPlus.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código Form.:', 8, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 173, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Base:', 24, 53, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblVolume', 'Volume:', 404, 53, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto', 'Produto:', 24, 75, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 279, 75, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblReferencia', 'Referência:', 24, 97, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 24, 119, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTIntaControleVisualLabel.Create('lblAcrMob','Acrésc. Mão de Obra:', 90, 141, 25, 14, 'taRightJustify'));


  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 150, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2), Format('Código %.2d:',
      [intCont]), 8, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2), 'Quantidade:', 127,
      (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2), 'Quantidade Pulso:', 270,
      (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' +TStrUtils.fStrZero(intCont, 2), 68,
      22 * intCont, 45, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressAlterPlus.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2))));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' +TStrUtils.fStrZero(intCont, 2), 188,
      22 * intCont, 45, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' +TStrUtils.fStrZero(intCont, 2), 330,
      22 * intCont, 45, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')));
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2), Format('Código %.2d:',
      [intCont]), 400, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2), 'Quantidade:', 520,
      (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2), 'Quantidade Pulso:', 660,
      (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' +TStrUtils.fStrZero(intCont, 2), 460,
      22 * (intCont - 10), 45, 22,'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressAlterPlus.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2))));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' +TStrUtils.fStrZero(intCont, 2), 580,
      22 * (intCont - 10), 45, 22,'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' +TStrUtils.fStrZero(intCont, 2), 720,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase','ecUpperCase')));

  end;

  groupColorantes.AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object Label5: TLabel                                  ' +
    '   Left = 80                                            ' +
    '   Top = 0                                              ' +
    '   Width = 460                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taLeftJustify                           ' +
    '   AutoSize = False                                     ' +
    '   Caption = ''A quantidade dos colorantes deve ser informada sempre no volume padrão LITRO'' ' +
    '   Color = clTeal                                       ' +
    '   Font.Charset = ANSI_CHARSET                          ' +
    '   Font.Color = clRed                                   ' +
    '   Font.Height = 14                                     ' +
    '   Font.Name = ''Arial''                                ' +
    '   Font.Pitch = fpVariable                              ' +
    '   Font.Style = [fsBold]                                ' +
    '   ParentColor = False                                  ' +
    '   ParentFont = False                                   ' +
    ' end                                                    '
  ));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 84, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODNFM')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 250, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 84, 50, 80, 22, 'ttAlfanumerico', 'NFM_CODBAS')
    .AdicionarEvento(TDbeCodBasKeyPressNovasFormulasAlterPlus.Create('OnKeyPress', Self))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 1))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDescricaoBase', 164, 50, 250, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', clInfoBk))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('RequeridoColor', clRed))
  );


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeVolume', 464, 50, 75, 22, 'ttAlfanumerico', 'NFM_VOLUME')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProduto', 84, 72, 175, 22, 'ttAlfanumerico', 'NFM_PRODUT')
      .AdicionarEvento(TDbeCodBasKeyPressNovasFormulasAlterPlus.Create('OnKeyPress', Self))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 2))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 339, 72, 45, 22, 'ttAlfanumerico', 'NFM_CODUNI')
    .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeRefere', 84, 94, 455, 22, 'ttAlfanumerico', 'NFM_REFERE')
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 4))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 84, 116, 455, 22, 'ttAlfanumerico', 'NFM_DESCRI')
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 5))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 120, 138, 100, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 240, 141, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 6))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle((groupColorantes)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

end;

procedure TCadastroNovasFormulasAlterPlus.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM ALP_CADALP WHERE ALP_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAlterPlus.pBotaoAtivarNfm(
  const tela: ITelaCadLibTintas);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  If Not GetQueryCadastro.IsEmpty Then
  Begin
    tela['btnAtivarNfm']['Enabled'].Value := VerificarNovaFormulaMovimentada;
    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(tela['btnAtivarNfm']['Enabled'].Value,
                            TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar'),'Ativar');
  End;
end;

procedure TCadastroNovasFormulasAlterPlus.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasAlterPlus.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
      DeletaNovaFormula(strCodNfmDel);

    tela['edtDescricaoBase']['text'].Value := '';
  end;
end;

function TCadastroNovasFormulasAlterPlus.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasAlterPlus.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasAlterPlus.fInformouColorante(strColorante,
  strQuantidade1, strQuantidade2: String): Boolean;
begin
  Result := True;

  If TStrUtils.fEmptyStr(strColorante) Then
  Begin
    If Not TStrUtils.fEmptyStr(strQuantidade1) Then
    Begin
      If strToFloatDef(strQuantidade2, 0) > 0 Then
        Result := False;
    End;
  End;
end;

procedure TCadastroNovasFormulasAlterPlus.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if LeftStr(strNomeCampo, Length('NFM_QTDC')) = 'NFM_QTDC' then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end
  Else If MatchStr(strNomeCampo, ['NFM_VOLUME']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.000';
    arrValores[1] := '0.000';
  End
  Else If MatchStr(strNomeCampo, ['NFM_ACRMOB']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  End;
end;

function TCadastroNovasFormulasAlterPlus.fPedidoAberto(strPedido: String;
  blnResult: Boolean): Boolean;
begin
  Result := False;

  If blnResult Then
  Begin
    If Not TStrUtils.fEmptyStr(strPedido) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasAlterPlus.fPodeAlterar: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    If Not fPermiteAlterarNfmVendida Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel alterá-la.',['&OK']);
      Result := False;
    End
    Else
    Begin
      If Not FTemPedidoNfm() Then
        Result := False;
    End;
  end;
end;

function TCadastroNovasFormulasAlterPlus.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;

end;

function TCadastroNovasFormulasAlterPlus.fProdutoExiste(strProduto: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen     := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DISTINCT 1 FIRST'+
                '  FROM ALP_CADBAS'+
                ' WHERE BAS_PRODUT =:PRODUT ';
  qryGen.ParamByName('PRODUT').AsString := strProduto;
  qryGen.Open;

  Result := not(qryGen.IsEmpty);
end;

function TCadastroNovasFormulasAlterPlus.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
    intY: Integer;
begin
  Result := True;

  if strNomeCampo = 'NFM_CODBAS' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Código Base"!';
    end
    Else If Not fValidarCadBas(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A base não foi encontrada!';
    End;
  end

  Else If strNomeCampo = 'NFM_ACRMOB' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Tela['dbeAcrMob']['Text'].Value := 0;
    End
    Else If (StrToFloatDef(strValorCampo, 0) < 0) Then
    Begin
      Result := False;
      strRetorno := 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero!';
    End;
  End

  else if strNomeCampo = 'NFM_PRODUT' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Produto"!';
    end
    Else If Not fValidarCadBas(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString,
                               strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'Este produto não está amarrado para a base informada!';
    End
    else
    Begin
      GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := fRetMenorUnidade(GetQueryCadastro.FieldByName('NFM_PRODUT').AsString,
                                                                              GetQueryCadastro.FieldByName('NFM_CODBAS').AsString,
                                                                              'GL');

      GetQueryCadastro.FieldByName('NFM_VOLUME').AsFloat := fRetMenorVolume(GetQueryCadastro.FieldByName('NFM_PRODUT').AsString,
                                                                            GetQueryCadastro.FieldByName('NFM_CODBAS').AsString,
                                                                            GetQueryCadastro.FieldByName('NFM_CODUNI').AsString);

      Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString);
    End;
  end

  Else If strNomeCampo = 'NFM_CODUNI' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Unidade"!';
    End
    Else If Not fValidarCadBas(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString,
                               GetQueryCadastro.FieldByName('NFM_PRODUT').AsString,
                               strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É unidade não está amarrada para a base informada!';
    End;
  End

  else if strNomeCampo = 'NFM_DESCRI' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Descrição"!';
    end
  end

  else if strNomeCampo = 'NFM_REFERE' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Referência"!';
    end
  end

  else if LeftStr(strNomeCampo, 8) = 'NFM_FORM' then
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) then
    begin
      Result := False;
      strRetorno := 'É necessário digitar pelo menos 1 colorante!';
    end
    else if not TStrUtils.fEmptyStr(strValorCampo) then
    begin
      if not ValidarColorante(strValorCampo) then
      begin
        Result := False;
        strRetorno := 'Colorante não encontrado!';
      end
      else if not ValidarColoranteJaCadastrado(tela, strValorCampo, strNomeCampo) then
      begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse Colorante já está cadastrado para essa nova fórmula!', ['&Ok']);
        strRetorno := '';
      end;
    end
    else if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela.pSetarFocus;
      Result := true;
    end
    else
    begin
      strCampoQtd := 'dbeQtdC' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;
      if strToFloatDef(strValorCampoQtd, -1) > 0 then
      begin
        Result := False;
        strRetorno := 'A quantidade do colorante foi informada. Por favor, informe seu código.';
      end;
    end;
  end
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDX' Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_FORM', [rfReplaceAll])).AsString) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade para continuar!';
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA AMERICANA') Or
        (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA INGLESA') Then
      Begin
        intY := Pos('Y', AnsiUpperCase(strValorCampo));

        If Not Pos('y_Y_', strValorCampo) > 0 Then
        Begin
          Result := False;
          strRetorno := 'É necessario digitar a quantidade em onça para continuar';
        End
        Else If (intY = 0) Or (Length(strValorCampo) = intY) Or (fGetLetrasIndisponivel(strValorCampo)) Then
        Begin
          Result := False;
          strRetorno := 'O formato da quantidade em onça está incorreto!' + #13
            + 'Formato Desejado: 99Y99 ou 99Y99,9';
        End
        Else If GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA AMERICANA' Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('A', strValorCampo) / 0.154;
        End
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('I', strValorCampo) / 0.154;
        End;
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'PULSO') Or
        (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Then
      Begin
        If fGetValorPulsosMl(strValorCampo) Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada em ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'PULSO',
            'Pulso', 'ML') + ' está incorreta!' + #13 + 'São aceitos apenas números inteiros ou decimais.';
        End
        Else If strToFloatDef(strValorCampo, 0) <= 0 Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada deve ser maior que Zero!';
        End
        Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'PULSO') Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_QTDC', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo);
        End
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_QTDC', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo) / 0.154;
        End;
      End;
    End
    Else If fVerificaColoranteVazioQtdPulso(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_FORM', [rfReplaceAll])).AsString,
                                            GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDX', [rfReplaceAll])).AsString) Then
    Begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    End;
  End
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDC' then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll])).AsString) then
    begin
      if TStrUtils.fEmptyStr(strValorCampo) then
      begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade do colorante!';
      end
      else if strToFloatDef(strValorCampo, 0) <= 0 then
      begin
        Result := False;
        strRetorno := 'A quantidade do colorante deve ser maior que Zero!';
      end;
    end
    Else If Not fInformouColorante(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll])).AsString,
                               GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll])).AsString,
                               GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll])).AsString) Then
    Begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    End
  end
  else if not(fValidarPreenchimentoCol(tela)) then
  begin
    Result     := False;
    strRetorno :='Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  end;
end;

function TCadastroNovasFormulasAlterPlus.fValidarCadBas(strBase, strProduto, strUnidade: String): Boolean;
Var
  qryAux: IDataSet;
begin
  Try
    qryAux := TAutcomTintaFactory.Get.fGetDataSet;
    qryAux.Close;
    qryAux.SQL := '';
    qryAux.SQL := qryAux.SQL + '  SELECT            ';
    qryAux.SQL := qryAux.SQL + '    *               ';
    qryAux.SQL := qryAux.SQL + '  FROM              ';
    qryAux.SQL := qryAux.SQL + '    ALP_CADBAS      ';
    qryAux.SQL := qryAux.SQL + '  WHERE             ';
    qryAux.SQL := qryAux.SQL + '    BAS_CODBAS = :CODBAS      ';

    If Not TStrUtils.fEmptyStr(strProduto) Then
      qryAux.SQL := qryAux.SQL + '  AND BAS_PRODUT = :PRODUT      ';

    If Not TStrUtils.fEmptyStr(strUnidade) Then
      qryAux.SQL := qryAux.SQL + '  AND BAS_CODUNI = :UNIDAD      ';

    qryAux.ParamByName('CODBAS').AsString := strBase;

    If Not TStrUtils.fEmptyStr(strProduto) Then
      qryAux.ParamByName('PRODUT').AsString := strProduto;

    If Not TStrUtils.fEmptyStr(strUnidade) Then
      qryAux.ParamByName('UNIDAD').AsString := strUnidade;

    qryAux.Open;

    Result := (Not qryAux.IsEmpty);
  Except
    Raise;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
var
  intCont       : Integer;
  blnCampoVazio : Boolean;
begin
  Result        := true;
  blnCampoVazio := false;

  for intCont := 1 to 20 do
  begin
    If fCampoNaoPreenchidoCol(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value, blnCampoVazio) Then
      blnCampoVazio := true
    Else If fCampoPreenchidoCol(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value, blnCampoVazio) Then
    begin
      Result := false;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasAlterPlus.fVerificaColoranteVazio(
  strNomCam: String; intCont: Integer; strColorante: String): Boolean;
begin
  Result := False;

  If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont,2)) Then
  Begin
    If (Not TStrUtils.fEmptyStr(strColorante)) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fVerificaColoranteVazioQtdPulso(
  strCodCol, strQuantidade: String): Boolean;
begin
  Result := False;

  If TStrUtils.fEmptyStr(strCodCol) Then
  Begin
    If Not TStrUtils.fEmptyStr(strQuantidade) Then
    Begin
      Result := True;
      Exit;
    End;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fVerificaDesAtiFormula(strCodCol,
  strState: String): Boolean;
begin
  Result := False;

  If Not TStrUtils.fEmptyStr(strCodCol) Then
  Begin
    If strState = 'dsBrowse' Then
    Begin
      Result := True;
    End;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL +  '  SELECT                                 ';
  qryGen.SQL := qryGen.SQL +  '    *  FROM  ' + GetNomeTabela + '       ';
  qryGen.SQL := qryGen.SQL +  '  WHERE  ' + GetNomeCampo  + ' = :NFM    ';
  qryGen.ParamByName('NFM').AsString  :=  strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasAlterPlus.fVerificaUnidade(blnAtualizar: Boolean;
  strUnidadeMenor: String): Boolean;
begin
  Result := False;

  If Not blnAtualizar Then
  Begin
    If Not TStrUtils.fEmptyStr(strUnidadeMenor) Then
      Result := True;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fRetDescUnidadesBase: String;
var
  qryGen: IDataSet;
  strMens: String;
begin
  Result := '';

  strMens := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_CODUNI                   ' +
                ' FROM                           ' +
                '   ALP_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_PRODUT = :PRODUT     ' +
                '   AND BAS_CODBAS = :CODBAS     ' ;

  If fVerificaUnidade(blnAtualizaUnidade, strUnidadeMenor) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_CODUNI <> :CODUNI ';

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;

  If fVerificaUnidade(blnAtualizaUnidade, strUnidadeMenor) Then
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    Result := Result + fRetornaUnidades(qryGen.FieldByName('BAS_CODUNI').AsString);
    qryGen.Next;
  End;

  strMens := fRetornaMsgUnidades(Result, qryGen.RecordCount);
  Result := strMens;
end;

function TCadastroNovasFormulasAlterPlus.fRetEmbalagemUnidade(
  strUnidade: String): Double;
begin
  Result := 0;

  If strUnidade = 'LT' Then
    Result :=  800
  Else If strUnidade = 'GL' Then
    Result := 3600
  Else If strUnidade = 'LA' Then
    Result := 16000
  Else If strUnIDADE = 'BD' Then
    Result := 20000;
end;

procedure TCadastroNovasFormulasAlterPlus.pExisteUnidadeMenorCadastrada(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_CODUNI                   ' +
                ' FROM                           ' +
                '   ALP_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_PRODUT = :PRODUT     ' +
                '   AND BAS_CODBAS = :CODBAS     ' ;

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If fExisteUnidadeLitro(qryGen.FieldByName('BAS_CODUNI').AsString, GetQueryCadastro.FieldByName('NFM_CODUNI').AsString) Then
    Begin
      strUnidadeMenor := 'LT';
      Break;
    End
    Else If fExisteUnidadeGalao(qryGen.FieldByName('BAS_CODUNI').AsString, GetQueryCadastro.FieldByName('NFM_CODUNI').AsString) Then
    Begin
      strUnidadeMenor := 'GL';
      Break;
    End
    Else If fExisteUnidadeLata(qryGen.FieldByName('BAS_CODUNI').AsString, GetQueryCadastro.FieldByName('NFM_CODUNI').AsString) Then
    Begin
      strUnidadeMenor := 'LA';
      Break;
    End;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    If fAjustarQuantidade(strUnidadeMenor) Then
      pAjustaQuantidade(strUnidadeMenor, tela);
end;

procedure TCadastroNovasFormulasAlterPlus.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM ALP_CADALP        ';
  qryGen.SQL := qryGen.SQL + '  WHERE ALP_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('ALP_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fAjustarQuantidade(
  strUnidade: String): Boolean;
begin
  Result := False;
  blnAtualizaUnidade := False;
  If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Existe uma nova unidade cadastrada para a base selecionada,' + #13#10 +
                                                  'essa unidade é inferior a atual cadastrada na nova fórmula.' + #13#10 +
                                                  'Deseja atualizar para a unidade nova ?' + #13#10 +
                                                  'Unidade Atual : ' + GetQueryCadastro.FieldByName('NFM_CODUNI').AsString + #13#10 +
                                                  'Unidade Nova  : ' + strUnidade, ['&Sim','&Não']) = 1 Then
  Begin
    Result := True;
    blnAtualizaUnidade := True;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fCampoNaoPreenchidoCol(
  strCodCol: String; blnCampoVazio: Boolean): Boolean;
begin
  Result := False;

  If TStrUtils.fEmptyStr(strCodCol) Then
  Begin
    If Not blnCampoVazio Then
      Result := True;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fCampoPreenchidoCol(strCodCol: String;
  blnCampoVazio: Boolean): Boolean;
begin
  Result := False;

  If Not TStrUtils.fEmptyStr(strCodCol) Then
  Begin
    If blnCampoVazio Then
      Result := True;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fExisteUnidadeGalao(strUniBas,
  strUniNfm: String): Boolean;
begin
  Result := False;

  If strUniBas = 'GL' Then
  Begin
    If strUniNfm <> 'GL' Then
    Begin
      If strUniNfm <> 'LT' Then
      Begin
        Result := True;
      End;
    End;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fExisteUnidadeLata(strUniBas,
  strUniNfm: String): Boolean;
begin
  Result := False;

  If strUniBas = 'LA' Then
  Begin
    If strUniNfm <> 'LA' Then
    Begin
      If (strUniNfm <> 'LT') Or (strUniNfm <> 'GL') Then
      Begin
        Result := True;
      End;
    End;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fExisteUnidadeLitro(strUniBas,
  strUniNfm: String): Boolean;
begin
  Result := False;

  If strUniBas = 'LT' Then
  Begin
    If strUniNfm <> 'LT' Then
    Begin
      Result := True;
    End;
  End;
end;

procedure TCadastroNovasFormulasAlterPlus.pAjustaQuantidade(strUnidade: String;
  const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat := StrToFloat(FormatFloat('#0.00',StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
      GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intCont, 2)).AsFloat := StrToFloat(FormatFloat('#0.00',StrToFloat(tela['dbeQtdX' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;
  GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasAlterPlus.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 160;
  tela['DBRadioGroup']['Width'].Value := 773;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 8;
  tela['DBRadioGroup']['Columns'].Value := 4;
  stlItems.Add('ONÇA AMERICANA');
  stlItems.Add('ONÇA INGLESA');
  stlItems.Add('PULSO');
  stlItems.Add('ML');
end;

function TCadastroNovasFormulasAlterPlus.fRetFatorDivisaoUnidade(
  strUnidade: String): Double;
begin
  Result := fRetEmbalagemUnidade(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString) / fRetEmbalagemUnidade(strUnidade);
end;

function TCadastroNovasFormulasAlterPlus.fRetDescricaoBase : String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_DESCRI' +
                '   FROM ALP_CADBAS           ' +
                '  WHERE BAS_PRODUT = :PRODUT ' +
                '    AND BAS_CODBAS = :CODBAS ' +
                '    AND BAS_CODUNI = :CODUNI ' ;
  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;
  qryGen.ParamByName('CODUNI').AsString := GetQueryCadastro.FieldByName('NFM_CODUNI').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_DESCRI').AsString;
end;

function TCadastroNovasFormulasAlterPlus.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'LT' Then
    Result := 'Litros'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata'
  Else If strCodUni = 'BD' Then
    Result := 'Balde';
end;

function TCadastroNovasFormulasAlterPlus.fRetMenorUnidade(
  strProdut, strCodBas, strUnidad: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata,
  strBalde: String;
begin
  Result := strUnidad;

  strLitro := '';
  strGalao := '';
  strLata  := '';
  strBalde := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODUNI              ' +
                '   FROM ALP_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PRODUT = :PRODUT    ' +
                '    AND BAS_CODBAS = :CODBAS    ' +
                '  ORDER BY BAS_CODUNI           ';
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_CODUNI').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'LA' Then
      strLata := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'BD' Then
      strBalde := qryGen.FieldByName('BAS_CODUNI').AsString;

    qryGen.Next;
  End;

  Result := fRetornaUnidadeMenor(strLitro, strGalao, strLata, strBalde);
end;

function TCadastroNovasFormulasAlterPlus.fRetMenorVolume(strProduto, strBase, strUnidade: String): Double;
Var
  qryAux: IDataSet;
begin
  Try
    qryAux := TAutcomTintaFactory.Get.fGetDataSet;
    qryAux.Close;
    qryAux.SQL := '';
    qryAux.SQL := qryAux.SQL + '  SELECT              ';
    qryAux.SQL := qryAux.SQL + '    BAS_EMBALA        ';
    qryAux.SQL := qryAux.SQL + '  FROM                ';
    qryAux.SQL := qryAux.SQL + '    ALP_CADBAS        ';
    qryAux.SQL := qryAux.SQL + '  INNER JOIN CADITE ON        ';
    qryAux.SQL := qryAux.SQL + '    BAS_CODITE = ITE_CODITE         ';
    qryAux.SQL := qryAux.SQL + '  WHERE               ';
    qryAux.SQL := qryAux.SQL + '    BAS_CODBAS = :CODBAS AND        ';
    qryAux.SQL := qryAux.SQL + '    BAS_PRODUT = :PRODUT AND        ';
    qryAux.SQL := qryAux.SQL + '    BAS_CODUNI = :UNIDAD            ';

    qryAux.ParamByName('CODBAS').AsString := strBase;
    qryAux.ParamByName('PRODUT').AsString := strProduto;
    qryAux.ParamByName('UNIDAD').AsString := strUnidade;
    qryAux.Open;

    Result := qryAux.FieldByName('BAS_EMBALA').AsFloat;
  Except
    Raise;
  End;
end;

function TCadastroNovasFormulasAlterPlus.fRetornaMsgBalde(strUnidades: String;
  intCount: Integer): String;
begin
  Result := '';

  If Pos('Balde', strUnidades) > 0 Then
  Begin
    Result := Result + 'Balde ';
  End;
end;

function TCadastroNovasFormulasAlterPlus.fRetornaMsgGalao(strUnidades: String;
  intCount: Integer): String;
begin
  Result := '';

  If Pos('Galao', strUnidades) > 0 Then
  Begin
    If intCount = 1 Then
      Result := Result + 'Galão '
    Else If (intCount = 2) Then
    Begin
      If (Pos('Litro', strUnidades) <= 0) Then
        Result := Result + 'Galão e '
      Else
        Result := Result + 'Galão ';
    End
    Else If intCount = 3 Then
      Result := Result + 'Galão e '
    Else If intCount > 3 Then
      Result := Result + 'Galão, ';
  End;
end;

function TCadastroNovasFormulasAlterPlus.fRetornaMsgLata(strUnidades: String;
  intCount: Integer): String;
begin
  Result := '';

  If Pos('Lata', strUnidades) > 0 Then
  Begin
     If intCount > 3 Then
       Result := Result + 'Lata e '
     Else
       Result := Result + 'Lata ';
  End;
end;

function TCadastroNovasFormulasAlterPlus.fRetornaMsgUnidades(
  strUnidades: String; intCount: Integer): String;
begin
  Result := '';

  If Pos('Litro', strUnidades) > 0 Then
  Begin
    If intCount = 1 Then
      Result := Result + 'Litro '
    Else If intCount = 2 Then
      Result := Result + 'Litro e '
    Else If intCount > 2 Then
      Result := Result + 'Litro, ';
  End;

  Result := Result + fRetornaMsgGalao(strUnidades, intCount);
  Result := Result + fRetornaMsgLata(strUnidades, intCount);
  Result := Result + fRetornaMsgBalde(strUnidades, intCount);
end;

function TCadastroNovasFormulasAlterPlus.fRetornaUnidadeMenor(strLitro,
  strGalao, strLata, strBalde: String): String;
begin
  Result := '';

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata
  Else If (Not TStrUtils.fEmptyStr(strBalde)) Then
    Result := strBalde;
end;

function TCadastroNovasFormulasAlterPlus.fRetornaUnidades(
  strUnidade: String): String;
begin
  Result := '';

  If strUnidade = 'LT' Then
    Result := 'Litro'
  Else If strUnidade = 'GL' Then
    Result := 'Galao'
  Else If strUnidade = 'LA' Then
    Result := 'Lata'
  Else If strUnidade = 'BD' Then
    Result := 'Balde';
end;

function TCadastroNovasFormulasAlterPlus.FTemPedidoNfm: Boolean;
Var
  qryGen: IDataSet;
  arrMensagem: TStringArray;
  stlMd5Key: TStringList;
  intContador: Integer;
  strPedido: String;
begin
  Try
    Result := False;
    strPedido := '';
    stlMd5Key := TStringList.Create();
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;

    pGetMd5KeyPedidos(GetQueryCadastro, stlMd5Key);

    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Esta alteração impedirá que ele seja faturado e obrigará a substituição da tinta no pedido antes de faturá-lo');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Seguem pedidos em aberto com esta formulação:');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'DT.EMISSAO | PEDIDO              | CLIENTE                                | IDEPRO | DESCRIÇÃO                                                     | QUANTIDADE ');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');

    For intContador := 0 To stlMd5Key.Count - 1 Do
    Begin
      qryGen.Close;
      qryGen.SQL := '';
      qryGen.SQL := qryGen.SQL + '  SELECT                            ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_DTAENT AS EMISSAO,        ';
      qryGen.SQL := qryGen.SQL + '    CONCAT(T.FDO_NUMDOC, "-", T.FDO_ESPDOC, "-", T.FDO_CODEMP) AS PEDIDO,     ';
      qryGen.SQL := qryGen.SQL + '    CONCAT(T.FDO_CODCLI, "-", IF(FGO_NOMCON = "" OR FGO_NOMCON IS NULL, CLI.CLI_NOMCLI, FGO_NOMCON)) AS CLIENTE,      ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_IDEPRO AS IDEPRO,         ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_DESCRI AS DESCRICAO,      ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_QTDITE AS QUANTIDADE,     ';
      qryGen.SQL := qryGen.SQL + '    F.FDO_JAFATU AS FATURADO        ';
      qryGen.SQL := qryGen.SQL + '  FROM                              ';
      qryGen.SQL := qryGen.SQL + '    TINDOR T                        ';
      qryGen.SQL := qryGen.SQL + '  INNER JOIN TINGOR AS GOR ON       ';
      qryGen.SQL := qryGen.SQL + '    GOR.AUTOINCREM = T.FDO_SEQGER         ';
      qryGen.SQL := qryGen.SQL + '  INNER JOIN CADOPE AS VEN ON       ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_CODVEN = VEN.OPE_CODOPE         ';
      qryGen.SQL := qryGen.SQL + '  INNER JOIN CADOPE AS DIG ON       ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_CODDIG = DIG.OPE_CODOPE         ';
      qryGen.SQL := qryGen.SQL + '  INNER JOIN CADCLI AS CLI ON       ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_CODCLI = CLI.CLI_CODCLI         ';
      qryGen.SQL := qryGen.SQL + '  INNER JOIN FATDOR AS F ON         ';
      qryGen.SQL := qryGen.SQL + '    F.FDO_NUMDOC = T.FDO_NUMDOC AND       ';
      qryGen.SQL := qryGen.SQL + '    F.FDO_ESPDOC = T.FDO_ESPDOC AND       ';
      qryGen.SQL := qryGen.SQL + '    F.FDO_CODEMP = T.FDO_CODEMP AND       ';
      qryGen.SQL := qryGen.SQL + '    F.FDO_CODCLI = T.FDO_CODCLI AND       ';
      qryGen.SQL := qryGen.SQL + '    F.FDO_CODACA = T.FDO_CODACA AND       ';
      qryGen.SQL := qryGen.SQL + '    F.FDO_EMPACA = T.FDO_EMPACA           ';
      qryGen.SQL := qryGen.SQL + '  LEFT JOIN EXTGOR AS EXT ON        ';
      qryGen.SQL := qryGen.SQL + '    EXT.FGO_SEQFGO = F.AUTOINCREM         ';
      qryGen.SQL := qryGen.SQL + '  WHERE                             ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_ITETIN = :ITETIN  AND           ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_ESPDOC = :ESPDOC  AND           ';
      qryGen.SQL := qryGen.SQL + '    F.FDO_JAFATU = :JAFATU  AND           ';
      qryGen.SQL := qryGen.SQL + '    T.FDO_IDEPRO = :IDEPRO                ';

      qryGen.ParamByName('ITETIN').AsString :=  stlMd5Key[intContador];
      qryGen.ParamByName('ESPDOC').AsString := 'PD';
      qryGen.ParamByName('JAFATU').AsString := '0';
      qryGen.ParamByName('IDEPRO').AsString := 'ALP';
      qryGen.Open;

      If qryGen.IsEmpty Then
      Begin
        Result := True;
        Continue;
      End;

      Result := Not qryGen.IsEmpty;
      qryGen.First;

      While Not qryGen.Eof Do
      Begin
        strPedido := qryGen.FieldByName('PEDIDO').AsString;
        TAutcomTintaFactory.Get.pAddDados(arrMensagem,
                                                     TAutcomTintaFactory.Get.fPadL(DateToStr(qryGen.FieldByName('EMISSAO').AsDate), 10) + ' | ' +
                                                     TAutcomTintaFactory.Get.fPadL(qryGen.FieldByName('PEDIDO').AsString, 19) + ' | ' +
                                                     TAutcomTintaFactory.Get.fPadR(qryGen.FieldByName('CLIENTE').AsString, 38) + ' |' +
                                                     TAutcomTintaFactory.Get.fPadC(qryGen.FieldByName('IDEPRO').AsString, 6) + '  | ' +
                                                     TAutcomTintaFactory.Get.fPadR(qryGen.FieldByName('DESCRICAO').AsString, 61) + ' | ' +
                                                     TAutcomTintaFactory.Get.fPadL(FormatFloat('0.0000', qryGen.FieldByName('QUANTIDADE').AsFloat), 10));
        qryGen.Next;
      End;
    End;

    TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');

    If fPedidoAberto(strPedido, Result) Then
    Begin
      If (TAutcomTintaFactory.Get.fMensagemTabela('ATENÇÃO!', 'Existem pedidos de venda em aberto utilizando esta formulação', arrMensagem, 'Deseja Continuar?', ['&Continuar', '&Voltar']) = 2) Then
      Begin
        Result := False;
        Exit;
      End;
    End;
  Except
    On E: Exception Do
      Raise;
  End;

  FreeAndNil(stlMd5Key);
end;

function TCadastroNovasFormulasAlterPlus.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasAlterPlus.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasAlterPlus.Create;
end;


function TCadastroNovasFormulasAlterPlus.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasAlterPlus.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasAlterPlus.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasAlterPlus.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasAlterPlus.GetNomeTabela: string;
begin
  Result := 'ALP_CADNFM';
end;


function TCadastroNovasFormulasAlterPlus.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasAlterPlus.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasAlterPlus.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasAlterPlus.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasAlterPlus.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('ALP').fGetInteger('PROCOD');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasAlterPlus.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmALP        : String;
  blnGerarUnidades : Boolean;
begin

  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoAlterPlusNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString,
     blnGerarUnidades, blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);


    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmALP := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('ALP').pSet('PROCOD',strNfmALP);
    End;
  end;
end;

procedure TCadastroNovasFormulasAlterPlus.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := 'LT';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := Date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'PULSO';

  tela['edtDescricaoBase']['text'].Value   := '';
  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela['dbeVolume']['Enabled'].Value       := False;

  tela['dbeDataCadastro']['Enabled'].Value := False;
 // tela.SelectNext;
end;

procedure TCadastroNovasFormulasAlterPlus.pAtivaCadALP;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE ALP_CADALP ' +
                '   SET ALP_ATIVAD = :ATIVAD ' +
                ' WHERE ALP_CODIGO = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAlterPlus.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE ALP_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAlterPlus.pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
begin
  Try
    pAtivaNfm;
    pAtivaCadALP;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
    tela['edtDescricaoBase']['Text'].Value := '';
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasAlterPlus.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasAlterPlus.PesquisarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  tela['edtDescricaoBase']['text'].Value := '';
end;

procedure TCadastroNovasFormulasAlterPlus.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString);

  pBotaoAtivarNfm(tela);
  tela['dbeCodNfm']['Enabled'].Value := false;

end;

procedure TCadastroNovasFormulasAlterPlus.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeCodNfm']['Enabled'].Value := false;
  tela['chkAtivad']['Checked'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDescri']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);

  tela['dbeBase']['Enabled'].Value    := MatchStr(strState, ['dsInsert']);

  tela['gpbColorantes']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
end;


function TCadastroNovasFormulasAlterPlus.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   ALP_CADCOL               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasAlterPlus.ValidarColoranteJaCadastrado(
  const tela: ITelaCadLibTintas; const strCodCol, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 20 Do
  Begin
    If fVerificaColoranteVazio(strNomCam, intCont, tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value) Then
    Begin
      If tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value = strCodCol Then
        Result := False;
    End;
  End;
end;

function TCadastroNovasFormulasAlterPlus.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN ALP_CADALP ON %1:s_ITETIN = ALP_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "ALP" '+
                                                 '   AND ALP_CODIGO  = :CODNFM', [GetQueryCadastro.FieldByName('NFM_CODNFM').AsString]);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
  End;
end;


end.

