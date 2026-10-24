unit untCadastroNovasFormulasRennerImobiliaria;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasRennerImobiliaria = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strCodBas, strCodUni: string; const tela: ITelaCadLibTintas): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;
    function fPedidoAberto(strPedido: String; blnResult: Boolean): Boolean;

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadREI;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;

    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Integer;
    function fRetDescUnidade(strCodUni: String): String;

    function fRetMenorUnidade(strCodBas, strUnidad: String): String;

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
    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AtivarNovasFormulas(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

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
    function fCalculaOncaParaMl(strTipOnc: String; strOnca: String): Double; Override;
    procedure pAjustarCamposMl(tela: ITelaCadLibTintas); Override;
    procedure pAjustarCamposOnca(tela: ITelaCadLibTintas); Override;
  end;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untDbeCodColKeyPressRennerImobiliaria,
  untDbeCodProKeyPressNovasFormulasRennerImobiliaria,
  untGravandoExecucaoRennerImobiliariaNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untDbeCodUniKeyPress, untTypesSistema;
{ TCadastroNovasFormulasRennerImobiliaria }

procedure TCadastroNovasFormulasRennerImobiliaria.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 505;
  tela['btnAtivarNfm']['Visible'].Value := True;
  tela.GetSelf['Width'].Value := 980;

  tela['dbeCodUni']['Enabled'].Value := false;
  tela['dbeCodNfm']['Enabled'].Value := False;

  blnAtualizaUnidade := False;
  strUnidadeMenor := '';
end;

procedure TCadastroNovasFormulasRennerImobiliaria.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  //
end;

procedure TCadastroNovasFormulasRennerImobiliaria.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeCodUni']['Enabled'].Value := False;
  pLimparQuantidades(GetQueryCadastro);

  If GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML' Then
    pAjustarCamposMl(tela)
  Else
    pAjustarCamposOnca(tela);
end;

procedure TCadastroNovasFormulasRennerImobiliaria.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;
  End;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  //
end;

procedure TCadastroNovasFormulasRennerImobiliaria.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 42, 35, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDtaCad', 'Data cadastro:', 210, 35, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Cód. Base:', 79, 59, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDesBas', 'Descrição:', 245, 59, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 463, 35, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acrésc. mão de obra:', 92, 124, 25, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição cor:', 58, 103, 57, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblReferencia', 'Referência:', 58, 81, 57, 14, 'taRightJustify'));

  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 130, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 10, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdY' + TStrUtils.fStrZero(intCont, 2),
      'Y:', 130, (22 * intCont) + 3, 10, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidadeX' + TStrUtils.fStrZero(intCont, 2),
      '/48:', 210, (22 * intCont) + 3, 10, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidadeY' + TStrUtils.fStrZero(intCont, 2),
      '/96:', 290, (22 * intCont) + 3, 10, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Ml:', 375, (22 * intCont) + 3, 57, 14, 'taRightJustify'));


    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 70,
      22 * intCont, 50, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressRennerImobiliaria.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdI' + TStrUtils.fStrZero(intCont , 2), 145,
      22 * intCont, 50, 22, 'ttAlfanumerico', 'NFM_QTDI' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));


    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 225,
      22 * intCont, 50, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdY' + TStrUtils.fStrZero(intCont , 2), 305,
      22 * intCont, 50, 22, 'ttAlfanumerico', 'NFM_QTDY' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 435,
      22 * intCont, 50, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 495, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdY' + TStrUtils.fStrZero(intCont, 2),
      'Y:', 610, (22 * (intCont - 10)) + 3, 10, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidadeX' + TStrUtils.fStrZero(intCont, 2),
      '/48:', 690, (22 * (intCont - 10)) + 3, 10, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidadeY' + TStrUtils.fStrZero(intCont, 2),
      '/96:', 770, (22 * (intCont - 10)) + 3, 10, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Ml:', 855, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 555,
      22 * (intCont - 10), 50, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressRennerImobiliaria.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdI' + TStrUtils.fStrZero(intCont , 2), 625,
      22 * (intCOnt - 10), 50, 22, 'ttAlfanumerico', 'NFM_QTDI' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 705,
      22 * (intCOnt - 10), 50, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));


    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdY' + TStrUtils.fStrZero(intCont , 2), 785,
      22 * (intCont - 10), 50, 22, 'ttAlfanumerico', 'NFM_QTDY' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );


    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 920,
      22 * (intCont - 10), 50, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
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

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 118, 29, 85, 22, 'ttAlfanumerico', 'NFM_CODPRO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDtaCad', 284, 29, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 118, 52, 85, 22, 'ttAlfanumerico', 'NFM_CODBAS')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasRennerImobiliaria.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDesBas', 284, 52, 284, 22, 'ttAlfanumerico', 'NFM_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));



  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 523, 29, 45, 22, 'ttAlfanumerico', 'NFM_UNIDAD')
    .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeReferencia', 118, 75, 450, 22, 'ttAlfanumerico', 'NFM_REFERE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 118, 98, 450, 22, 'ttAlfanumerico', 'NFM_DESCOR')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 118, 121, 85, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 284, 124, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 12)));


  AdicionarControle((groupColorantes)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));
end;

procedure TCadastroNovasFormulasRennerImobiliaria.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM REI_CADREI WHERE REI_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
      DeletaNovaFormula(strCodNfmDel);
  end;
end;

function TCadastroNovasFormulasRennerImobiliaria.fAjustarQuantidade(
  strUnidade: String): Boolean;
begin
  Result := False;
  blnAtualizaUnidade := False;
  If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Existe uma nova unidade cadastrada para a base selecionada,' + #13#10 +
                                                  'essa unidade é inferior a atual cadastrada na nova fórmula.' + #13#10 +
                                                  'Deseja atualizar para a unidade nova ?' + #13#10 +
                                                  'Unidade Atual : ' + GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString + #13#10 +
                                                  'Unidade Nova  : ' + strUnidade, ['&Sim','&Não']) = 1 Then
  Begin
    Result := True;
    blnAtualizaUnidade := True;
  End;
end;

function TCadastroNovasFormulasRennerImobiliaria.fCalculaOncaParaMl(strTipOnc,
  strOnca: String): Double;
Var
  intInteiro: Integer;
  fltFracao: Double;
  strCalculo: String;
  strCalculo1: String;
begin
  Result := 0;

  If TStrUtils.fEmptyStr(strOnca) Then
    Exit;

  If strTipOnc = 'I_A' Then  // Inteiro Americana
  Begin
    intInteiro := StrToInt(strOnca); //Numero Inteiro da Onça


    strCalculo := FloatToStrF(intInteiro * 28.4130742283722, ffNumber, 12, 2);
    strCalculo := AnsiReplaceStr(strCalculo, '.', '');

    Result := StrToFloat(strCalculo);
  End
  Else If strTipOnc = 'I_I' Then //Inteiro Inglesa
  Begin

    intInteiro := StrToInt(strOnca);

    strCalculo := FloatToStrF(intInteiro * 29.5735295641119, ffNumber, 12, 2);
    strCalculo := AnsiReplaceStr(strCalculo, '.', '');

    Result := StrToFloat(strCalculo);
  End
  Else If strTipOnc = 'A48' Then //Americana  /48
  Begin
    fltFracao := StrToFloat(strOnca);
    strCalculo1 := FloatToStrF(fltFracao * 28.4130742283722 / 48, ffNumber, 12, 2);
    strCalculo1 := AnsiReplaceStr(strCalculo1, '.', '');

    Result := StrToFloat(strCalculo1);
  End
  Else If strTipOnc = 'I48' Then //Inglesa /48
  Begin
    fltFracao := StrToFloat(strOnca);
    strCalculo1 := FloatToStrF(fltFracao * 29.5735295641119 / 48, ffNumber, 12, 2);
    strCalculo1 := AnsiReplaceStr(strCalculo1, '.', '');

    Result := StrToFloat(strCalculo1);
  End
  Else If strTipOnc = 'A96' Then //Americana  /96
  Begin
    fltFracao := StrToFloat(strOnca);
    strCalculo1 := FloatToStrF(fltFracao * 28.4130742283722 / 96, ffNumber, 12, 2);
    strCalculo1 := AnsiReplaceStr(strCalculo1, '.', '');

    Result := StrToFloat(strCalculo1);
  End
  Else If strTipOnc = 'I96' Then //Inglesa /96
  Begin
    fltFracao := StrToFloat(strOnca);
    strCalculo1 := FloatToStrF(fltFracao * 29.5735295641119 / 96, ffNumber, 12, 2);
    strCalculo1 := AnsiReplaceStr(strCalculo1, '.', '');

    Result := StrToFloat(strCalculo1);
  End;
end;

function TCadastroNovasFormulasRennerImobiliaria.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODPRO';
end;

function TCadastroNovasFormulasRennerImobiliaria.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.FormatarCampo(
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
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  end
  Else If strNomeCampo = 'NFM_ACRMOB' Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End;
end;

function TCadastroNovasFormulasRennerImobiliaria.fPedidoAberto(
  strPedido: String; blnResult: Boolean): Boolean;
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

function TCadastroNovasFormulasRennerImobiliaria.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasRennerImobiliaria.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasRennerImobiliaria.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;

end;

function TCadastroNovasFormulasRennerImobiliaria.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If (Pos(strCodUni, 'LT_QT_') > 0) Then
    Result := 'Litros'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

function TCadastroNovasFormulasRennerImobiliaria.fRetDescUnidadesBase: String;
var
  qryGen: IDataSet;
  strMens: String;
begin
  Result := '';

  strMens := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_UNIDAD                   ' +
                ' FROM                           ' +
                '   REI_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_CODBAS = :CODBAS     ';

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_UNIDAD').AsString, 'LT_QT_') > 0 Then
      Result := Result + 'Litro';

    If qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL' Then
      Result := Result + 'Galao';

    If qryGen.FieldByName('BAS_UNIDAD').AsString = 'LA' Then
      Result := Result + 'Lata';

    qryGen.Next;
  End;

  If Pos('Litro', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Litro '
    Else If qryGen.RecordCount = 2 Then
      strMens := strMens + 'Litro e '
    Else If qryGen.RecordCount > 2 Then
      strMens := strMens + 'Litro, ';
  End;

  If Pos('Galao', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Galão '
    Else If (qryGen.RecordCount = 2) And (Pos('Litro', Result) <= 0) Then
      strMens := strMens + 'Galão e '
    Else If qryGen.RecordCount = 2 Then
      strMens := strMens + 'Galão '
    Else If qryGen.RecordCount > 2 Then
      strMens := strMens + 'Galão e ';
  End;

  If Pos('Lata', Result) > 0 Then
  Begin
    strMens := strMens + 'Lata ';
  End;

  Result := strMens;
end;

function TCadastroNovasFormulasRennerImobiliaria.fRetFatorDivisaoUnidade(
  strUnidade: String): Integer;
begin
  Result := 1;
  If Pos(strUnidade, 'LT_QT_') > 0 Then
  Begin
    If GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString = 'LA' Then
      Result := 20
    Else If GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString = 'GL' Then
      Result := 4
  End
  Else If strUnidade = 'GL' Then
  Begin
    If GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString = 'LA' Then
      Result := 5;
  End;
end;

function TCadastroNovasFormulasRennerImobiliaria.fRetMenorUnidade(
  strCodBas, strUnidad: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata: String;
begin
  Result := strUnidad;

  strLitro := '';
  strGalao := '';
  strLata  := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_UNIDAD              ' +
                '   FROM REI_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_CODBAS = :CODBAS    ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_UNIDAD').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'LA' Then
      strLata := qryGen.FieldByName('BAS_UNIDAD').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

function TCadastroNovasFormulasRennerImobiliaria.FTemPedidoNfm: Boolean;
var
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
      qryGen.ParamByName('IDEPRO').AsString := 'REI';
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

function TCadastroNovasFormulasRennerImobiliaria.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
    qryGen: IDataSet;

  procedure CarregarDescricao;
  begin
    If (Not TStrUtils.fEmptyStr(tela['dbeBase']['Text'].Value)) Then
    Begin
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT BAS_DESCRI ' +
                    '   FROM REI_CADBAS ' +
                    '  WHERE BAS_CODBAS = :CODBAS ' +
                    '    AND BAS_UNIDAD = :UNIDAD ';

      qryGen.ParamByName('CODBAS').AsString := tela['dbeBase']['Text'].Value;
      qryGen.ParamByName('UNIDAD').AsString := tela['dbeCodUni']['Text'].Value;
      qryGen.Open;

      tela['dbeDesBas']['Text'].Value := qryGen.FieldByName('BAS_DESCRI').AsString;
    End;
  end;
begin
  Result := True;

  If strNomeCampo = 'NFM_CODBAS' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Código Base"!';
    end
    else if not ValidarBase(strValorCampo, GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString, tela) then
    begin
      Result := False;
      strRetorno := 'Base não encontrada!';
    end
    else
      CarregarDescricao;
  End

  Else If strNomeCampo = 'NFM_ACRMOB' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
      GetQueryCadastro.FieldByName('NFM_ACRMOB').AsFloat := 0.00
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If TAutcomTintaFactory.Get.fStrToFloat(strValorCampo) < 0 Then
      Begin
        Result := False;
        strRetorno := 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero!';
      End;
    End;
  End
  Else If strNomeCampo = 'NFM_REFERE' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A referência deve ser preenchida!';
    end
  End
  Else If strNomeCampo = 'NFM_DESCOR' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    end
  End
  Else if LeftStr(strNomeCampo, 8) = 'NFM_FORM' then
  Begin
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
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDI' Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDI','NFM_FORM', [rfReplaceAll])).AsString) And
    (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString <> 'ML') Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade para continuar!';
      End
      Else If fGetValorInteiro(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'A Quantidade informada está incorreta!' + #13 + 'São aceitos apenas números inteiros.';
      End
      Else If GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA AMERICANA' Then
      Begin
        GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDI', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('I_A', strValorCampo);
      End
      Else
      Begin
        GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDI', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('I_I', strValorCampo);
      End;
    End
    Else If ((TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDI', 'NFM_FORM', [rfReplaceAll])).AsString)) And
      Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDI', [rfReplaceAll])).AsString)) Then
    Begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    End;
  End
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
        If (fGetValorPulsosMl(strValorCampo)) Then
        Begin
          Result := False;
          strRetorno := 'O formato da quantidade /48 está incorreto!' + #13
            + 'Formato Desejado: 99 ou 99,99';
          GetQueryCadastro.FieldByName(strNomeCampo).AsString := '0';
        End
        Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA AMERICANA') And (strToFloatDef(strValorCampo, 0) > 0) Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('A48', strValorCampo) + fCalculaOncaParaMl('I_A', GetQueryCadastro.FieldByName(StringReplace(
              strNomeCampo, 'NFM_QTDX', 'NFM_QTDI', [rfReplaceAll])).AsString);
        End
        Else If (strToFloatDef(strValorCampo, 0) > 0) Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('I48', strValorCampo) + fCalculaOncaParaMl('I_I', GetQueryCadastro.FieldByName(StringReplace(
              strNomeCampo, 'NFM_QTDX', 'NFM_QTDI', [rfReplaceAll])).AsString);
        End;
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'PULSO') Or
        (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Then
      Begin
        If fGetValorPulsosMl(strValorCampo) Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada em ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'PULSO',
            'Pulso', 'ML') + ' está incorreta!' + #13 + 'Formato Desejado: 99 ou 99,99';
        End
        Else If strToFloatDef(strValorCampo, 0) <= 0 Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada deve ser maior que Zero!';
        End
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_QTDC', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo);
        End;
      End;
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDY' Then     // PARTE FRACIONADA /96
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDY','NFM_FORM', [rfReplaceAll])).AsString) And
     (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString <> 'ML') Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade para continuar!';
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA AMERICANA') Or
        (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA INGLESA') Then
      Begin
        If (fGetValorPulsosMl(strValorCampo)) Then
        Begin
          Result := False;
          strRetorno := 'O formato da quantidade /96 está incorreto!' + #13
            + 'Formato Desejado: 99 ou 99,99';
          GetQueryCadastro.FieldByName(strNomeCampo).AsString := '0';
        End
        Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA AMERICANA') And (strToFloatDef(strValorCampo, 0) > 0) Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDY', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('A96', strValorCampo) + fCalculaOncaParaMl('A48', GetQueryCadastro.FieldByName(StringReplace(
              strNomeCampo, 'NFM_QTDY', 'NFM_QTDX', [rfReplaceAll])).AsString) + fCalculaOncaParaMl('I_A', GetQueryCadastro.FieldByName(StringReplace(
                strNomeCampo, 'NFM_QTDY', 'NFM_QTDI', [rfReplaceAll])).AsString);
        End
        Else If strToFloatDef(strValorCampo, 0) > 0 Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDY', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
             fCalculaOncaParaMl('I96', strValorCampo) + fCalculaOncaParaMl('I48', GetQueryCadastro.FieldByName(StringReplace(
              strNomeCampo, 'NFM_QTDY', 'NFM_QTDX', [rfReplaceAll])).AsString) + fCalculaOncaParaMl('I_I', GetQueryCadastro.FieldByName(StringReplace(
                strNomeCampo, 'NFM_QTDY', 'NFM_QTDI', [rfReplaceAll])).AsString);
        End;
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'PULSO') Or
        (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Then
      Begin
        If fGetValorPulsosMl(strValorCampo) Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada em ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'PULSO',
            'Pulso', 'ML') + ' está incorreta!' + #13 + 'Formato Desejado: 99 ou 99,99';
        End
        Else If strToFloatDef(strValorCampo, 0) <= 0 Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada deve ser maior que Zero!';
        End
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDY','NFM_QTDC', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo);
        End;
      End;
    End;
  End
  Else if LeftStr(strNomeCampo, 8) = 'NFM_QTDC' then
  Begin
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
    else if (( TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll])).AsString) )
      and   ((not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll])).AsString)) And
             (strToFloatDef(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll])).AsString,0) > 0)) ) then
    begin
        Result := False;
        strRetorno := 'É necessário informar o colorante!';
    end
  End
  Else if not(fValidarPreenchimentoCol(tela)) then
  Begin
    Result     := False;
    strRetorno :='Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  End;
end;

function TCadastroNovasFormulasRennerImobiliaria.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
var
  intCont       : Integer;
  blnCampoVazio : Boolean;
begin
  Result        := true;
  blnCampoVazio := false;

  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and not (blnCampoVazio) then
      blnCampoVazio := true
    else
    if not TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and (blnCampoVazio) then
    begin
      Result := false;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasRennerImobiliaria.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                              ';
  qryGen.SQL := qryGen.SQL + '    * FROM ' + GetNomeTabela + '      ';
  qryGen.SQL := qryGen.SQL + '  WHERE  ' + GetNomeCampo + ' = :NFM  ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasRennerImobiliaria.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasRennerImobiliaria.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasRennerImobiliaria.GetNomeCampo: string;
begin
  Result := 'NFM_CODPRO';
end;

function TCadastroNovasFormulasRennerImobiliaria.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasRennerImobiliaria.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasRennerImobiliaria.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasRennerImobiliaria.GetNomeTabela: string;
begin
  Result := 'REI_CADNFM';
end;

function TCadastroNovasFormulasRennerImobiliaria.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasRennerImobiliaria.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasRennerImobiliaria.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasRennerImobiliaria.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasRennerImobiliaria.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('REI').fGetInteger('PROCOD');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODPRO').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmREI        : String;
  blnGerarUnidades : Boolean;
begin

  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoRennerImobiliariaNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString,
     blnGerarUnidades, blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);


    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmREI := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('REI').pSet('PROCOD',strNfmREI);
    End;
  end;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.IncluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  //
end;

procedure TCadastroNovasFormulasRennerImobiliaria.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := 'QT';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := fNow;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'ML';
  tela['dbeCodUni']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value := False;
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela['dbeDesBas']['Enabled'].Value := False;
  tela.SelectNext;
  pAjustarCamposMl(tela);
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pAjustaQuantidade(
  strUnidade: String; const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat := StrToFloat(FormatFloat('#0.00',StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pAjustarCamposMl(
  tela: ITelaCadLibTintas);
Var
  intContador: Integer;
begin
  For intContador := 1 To 10 Do
  Begin
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := 'Quantidade:';
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 170;
    tela['dbeForm' + TStrUtils.fStrZero(intContador, 2)]['Width'].Value := 55;
    tela['lblQtdMl' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 295;
    tela['dbeQtdX' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 230;
    tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 370;
    tela['dbeQtdX' + TStrUtils.fStrZero(intContador, 2)]['Width'].Value := 55;
    tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Width'].Value := 55;
    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := False;
    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := False;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := False;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := False;
    tela['lblQuantidadeY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := False;
    tela['lblQtdY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := False;
  End;

  For intContador := 11 To 20 Do
  Begin
    tela['lblForm' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 445;
    tela['dbeForm' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 500;
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := 'Quantidade:';
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 600;
    tela['lblQtdMl' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 730;
    tela['dbeQtdX' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 665;
    tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 805;
    tela['dbeQtdX' + TStrUtils.fStrZero(intContador, 2)]['Width'].Value := 55;
    tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Width'].Value := 55;
    tela['dbeForm' + TStrUtils.fStrZero(intContador, 2)]['Width'].Value := 55;
    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := False;
    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := False;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := False;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := False;
    tela['lblQuantidadeY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := False;
    tela['lblQtdY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := False;
  End;

  tela.GetSelf['Width'].Value := 870;
  tela['DBRadioGroup']['Width'].Value := 863;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pAjustarCamposOnca(
  tela: ITelaCadLibTintas);
Var
  intContador: Integer;
begin
  For intContador := 1 To 10 Do
  Begin
    tela['lblQtdY' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 130;
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := '/48:';
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 200;
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Alignment'].Value := 'taRightJustify';
    tela['lblQuantidadeY' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 285;
    tela['lblQtdMl' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 360;


    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 145;
    tela['dbeQtdX' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 225;
    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 305;
    tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 435;


    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := True;
    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := True;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := True;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := True;
    tela['lblQuantidadeY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := True;
    tela['lblQtdY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := True;
  End;

  For intContador := 11 To 20 Do
  Begin
    tela['lblForm' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 495;
    tela['lblQtdY' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 615;
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := '/48:';
    tela['lblQuantidadeX' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 685;
    tela['lblQuantidadeY' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 765;
    tela['lblQtdMl' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 845;

    tela['dbeForm' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 555;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 625;
    tela['dbeQtdX' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 705;
    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 785;
    tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Left'].Value := 920;

    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := True;
    tela['dbeQtdY' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := True;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := True;
    tela['dbeQtdI' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := True;
    tela['lblQuantidadeY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := True;
    tela['lblQtdY' + TStrUtils.fStrZero(intContador, 2)]['Visible'].Value := True;
  End;

  tela.GetSelf['Width'].Value := 985;
  tela['DBRadioGroup']['Width'].Value := 978;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 146;
  tela['DBRadioGroup']['Width'].Value := 973;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 12;
  tela['DBRadioGroup']['Columns'].Value := 2;
  stlItems.Add('ONÇA INGLESA');
  stlItems.Add('ML');
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pAtivaCadREI;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE REI_CADREI ' +
                '   SET REI_ATIVAD = :ATIVAD ' +
                ' WHERE REI_CODPRO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE REI_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODPRO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadREI;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;


procedure TCadastroNovasFormulasRennerImobiliaria.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pExisteUnidadeMenorCadastrada(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_UNIDAD                   ' +
                ' FROM                           ' +
                '   REI_CADBAS                ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_CODBAS = :CODBAS     ';

  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((Pos(qryGen.FieldByName('BAS_UNIDAD').AsString,'LT_QT_') > 0) And (Pos(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString, 'LT_QT_') <= 0)) Then
    Begin
      strUnidadeMenor := TAutcomTintaFactory.Get.IIF(qryGen.FieldByName('BAS_UNIDAD').AsString = 'LT', 'LT', 'QT');
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL') And (GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString <> 'GL') And
            (Pos(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString, 'LT_QT_') <= 0)) Then
    Begin
      strUnidadeMenor := 'GL';
      Break;
    End;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    If fAjustarQuantidade(strUnidadeMenor) Then
      pAjustaQuantidade(strUnidadeMenor, tela);
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM REI_CADREI        ';
  qryGen.SQL := qryGen.SQL + '  WHERE REI_CODPRO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('REI_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasRennerImobiliaria.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeCodNfm']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Checked'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeCodNfm']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeBase']['Enabled'].Value   := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDescri']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['gpbColorantes']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
end;

function TCadastroNovasFormulasRennerImobiliaria.ValidarBase(
  const strCodBas, strCodUni: string; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   COUNT(0) AS QTD          ' +
      ' FROM                       ' +
      '   REI_CADBAS               ' +
      '   INNER JOIN CADITE            ' +
      '     ON BAS_CODITE = ITE_CODITE ' +
      ' WHERE BAS_CODBAS = :CODBAS ' +
      '   AND BAS_UNIDAD = :CODUNI ',
      'QTD', [strCodBas, strCodUni]
    ) > 0;

    If Not Result Then
    Begin
      GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := fRetMenorUnidade(strCodBas, strCodUni);
      Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
    End;
  end;
end;

function TCadastroNovasFormulasRennerImobiliaria.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   REI_CADCOL            ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasRennerImobiliaria.ValidarColoranteJaCadastrado(
  const tela: ITelaCadLibTintas; const strCodCol, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 20 Do
  Begin
    If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont,2)) And
       (Not TStrUtils.fEmptyStr( tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value )) Then
    Begin
      If tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value = strCodCol Then
        Result := False;
    End;
  End;
end;

function TCadastroNovasFormulasRennerImobiliaria.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN REI_CADREI ON %1:s_ITETIN = REI_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "REI" '+
                                                 '   AND REI_CODNFM = :CODNFM', [GetQueryCadastro.FieldByName('NFM_CODPRO').AsString]);
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
