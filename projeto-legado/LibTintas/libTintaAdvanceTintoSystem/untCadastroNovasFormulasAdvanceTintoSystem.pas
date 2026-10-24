unit untCadastroNovasFormulasAdvanceTintoSystem;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas,
  untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  untDbeCodEmbKeyPressNovasFormulasAdvanceTintoSystem,
  untDbeDesProKeyPressNovasFormulasAdvanceTintoSystem, SysUtils, untStrUtils,
  StrUtils,
  untDbePesquisaItemKeyPress, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasAdvanceTintoSystem = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;
    function fPesoEspecifico(strCodBas: String; strPrefixTab: String): Double;
    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas;
      const strCodCol: string; const strNomCam: string): Boolean;
    function fValidarBase(strBase__: String = ''; strProdut: String = '';
      strEmba__: String = ''; tela: ITelaCadLibTintas = Nil): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    function fValidaCatalisador(strCts: String): Boolean;
    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;
    function fPedidoAberto(strPedido: String; blnResult: Boolean): Boolean;

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    procedure pAtivaNfm;
    procedure pAtivaCadHyd;

    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetDescUnidade(strCodUni: String): String;
    procedure CalculaQuantidades;

    function fRetMenorUnidade(strProdut, strCodBas: String; tela: ITelaCadLibTintas): String;
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
    function fValidaCampos(const tela: ITelaCadLibTintas; strNomeCampo: string; strValorCampo: string; var strRetorno: string): Boolean; override;
    function fVerificaNovFormulas(strCodNfm: String): Boolean; Override;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); override;
    procedure FormatarCampo(const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray); override;
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
    procedure CancelarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);

    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    property blnAtualizaUni: Boolean read blnAtualizaUnidade  write blnAtualizaUnidade;
    property strUnidade: String read strUnidadeMenor write strUnidadeMenor;

    function GetPreencherDBRadioGroup(): Boolean; Override;
    procedure pAjustarRadioGroup(const tela: ITelaCadLibTintas; stlItems: TStrings); Override;
  end;

implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untDbeCodColKeyPressAdvanceTintoSystem,
  untDbeCodProKeyPressNovasFormulasAdvanceTintoSystem,
  untGravandoExecucaoAdvanceTintoSystemNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica, untTypesSistema;
{ TCadastroNovasFormulasAdvanceTintoSystem }

procedure TCadastroNovasFormulasAdvanceTintoSystem.AjustarTela(const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 550;
  tela.GetSelf['Width'].Value := 835;
  tela['btnAtivarNfm']['Visible'].Value := True;
  blnAtualizaUnidade := False;
  strUnidadeMenor := '';

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.AlterarAntes(const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.AlterarDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeDataCadastro']['Enabled'].Value := False;
  pLimparQuantidades(GetQueryCadastro);
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.AtivarNovasFormulas(const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM')
    .AsString)) And (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' +
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD')
      .AsString = 'S', 'Desativar', 'Ativar') + ' essa nova fórmula ?',
      ['&Sim', '&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;
  End;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.CalculaQuantidades;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT BAS_CONTEU FROM ADT_CADBAS WHERE ' +
                  '   BAS_CODBAS = :BASE AND                ' +
                  '   BAS_PRODUT = :PRODUTO AND             ' +
                  '   BAS_CODEMB = :EMBALAGEM               ';

    qryGen.ParamByName('BASE').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
    qryGen.ParamByName('PRODUTO').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;
    qryGen.ParamByName('EMBALAGEM').AsString := GetQueryCadastro.FieldByName('NFM_CODEMB').AsString;
    qryGen.Open;

    GetQueryCadastro.FieldByName('NFM_QTDBAS').AsFloat := qryGen.FieldByName('BAS_CONTEU').AsFloat;
  Except
    Raise;
  End;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.CancelarDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.CarregarDescricoes(const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 60, 31, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 240, 31, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblBase', 'Base:', 60, 53, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto', 'Produto:', 60, 75, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodCor', 'Código da Cor:', 60, 97, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbala', 'Embalagem:', 60, 119, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acréscimo mão de obra:', 100, 141, 25, 14, 'taRightJustify'));

  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 130, 521, 275)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Componente %.2d:', [intCont]), 23, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 145, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade (g):', 290, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 83,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_CODC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressAdvanceTintoSystem.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 208,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 350,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Componente %.2d:', [intCont]), 435, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 560, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade (g):', 705, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 495,
      22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_CODC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressAdvanceTintoSystem.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 620,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 765,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  groupColorantes.AdicionarControle(TLibTintaControleVisualImplementacao.Create
    (' object Label5: TLabel                                  ' +
    '   Left = 80                                            ' +
    '   Top = 0                                              ' +
    '   Width = 400                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taLeftJustify                           ' +
    '   AutoSize = False                                     ' +
    '   Caption = ''Informar a quantidade em Gramas, para o cadastro da fórmula em Litro'' '
    + '   Color = clTeal                                       ' +
    '   Font.Charset = ANSI_CHARSET                          ' +
    '   Font.Color = clRed                                   ' +
    '   Font.Height = 14                                     ' +
    '   Font.Name = ''Arial''                                ' +
    '   Font.Pitch = fpVariable                              ' +
    '   Font.Style = [fsBold]                                ' +
    '   ParentColor = False                                  ' +
    '   ParentFont = False                                   ' +
    ' end                                                    '));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 85, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODNFM')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 265, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 85, 50, 85, 22, 'ttAlfanumerico', 'NFM_CODBAS')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasAdvanceTintoSystem.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesBas', 170, 50, 350, 22, 'ttAlfanumerico').AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProduto', 85, 72, 435, 22, 'ttAlfanumerico', 'NFM_PRODUT')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasAdvanceTintoSystem.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodCor', 85, 94, 435, 22, 'ttAlfanumerico', 'NFM_CODCOR'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeEmbala', 85, 116, 85, 22, 'ttAlfanumerico', 'NFM_CODEMB')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasAdvanceTintoSystem.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesEmb', 170, 116, 350, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 125, 138, 100, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 360, 31, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCatalisador', 'Catalisador:', 23, (22 * 11) + 3, 57, 14, 'taRightJustify'));

  groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdCatalisador', 'Quantidade:', 145, (22 * 11) + 3, 57, 14, 'taRightJustify'));

  groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdCatalisadorG', 'Quantidade(g):', 290, (22 * 11) + 3, 57, 14, 'taRightJustify'));

  groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCta', 83, (22 * 11), 55, 22, 'ttAlfanumerico', 'NFM_CODCAT')
    .AdicionarEvento(TDbeDesProKeyPressNovasFormulasAdvanceTintoSystem.Create('OnKeyPress', Self)));

 groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdGCta', 208, (22 * 11), 60, 22, 'ttAlfanumerico', 'NFM_QTDCX1')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')));

  groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdCta', 350, (22 * 11), 60, 22, 'ttAlfanumerico', 'NFM_QTDCAT')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')));

  AdicionarControle((groupColorantes));
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM ADT_CADADT WHERE ADT_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fAjustarQuantidade(strUnidade: String): Boolean;
begin
  Result := False;
  blnAtualizaUnidade := False;
  If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Existe uma nova unidade cadastrada para a base selecionada,' + #13#10 +
    'essa unidade é inferior a atual cadastrada na nova fórmula.' + #13#10 +  'Deseja atualizar para a unidade nova ?' + #13#10 + 'Unidade Atual : ' +
    GetQueryCadastro.FieldByName('NFM_CODEMB').AsString + #13#10 + 'Unidade Nova  : ' + strUnidade, ['&Sim', '&Não']) = 1 Then
  Begin
    Result := True;
    blnAtualizaUnidade := True;
  End;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fGetCampoChave
  (const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.FormatarCampo(const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if (LeftStr(strNomeCampo, Length('NFM_QTDC')) = 'NFM_QTDC') And (strNomeCampo <> 'NFM_QTDCX1') then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  end
  Else If LeftStr(strNomeCampo, Length('NFM_QTDCAT')) = 'NFM_QTDCAT' Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  End
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

function TCadastroNovasFormulasAdvanceTintoSystem.fPesoEspecifico(
  strCodBas: String; strPrefixTab: String): Double;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT  DISTINCT              ';
    qryGen.SQL := qryGen.SQL + ' ' + strPrefixTab + '_PESESP    ';
    qryGen.SQL := qryGen.SQL + '  FROM                          ';
    qryGen.SQL := qryGen.SQL + '    ADT_CAD' + strPrefixTab + ' ';
    qryGen.SQL := qryGen.SQL + '  WHERE                         ';
    qryGen.SQL := qryGen.SQL + '   ' + strPrefixTab + '_COD' + strPrefixTab + ' = :CODIGO        ';
    qryGen.ParamByName('CODIGO').AsString := strCodBas;
    qryGen.Open;

    Result := qryGen.FieldByName(strPrefixTab + '_PESESP').AsFloat;
  Except
    Raise;
  End;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fPedidoAberto(
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

function TCadastroNovasFormulasAdvanceTintoSystem.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fPodeAlterar: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    If Not fPermiteAlterarNfmVendida Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la.', ['&OK']);
      Result := False;
    End
    Else
    Begin
      If Not FTemPedidoNfm() Then
        Result := False;
    End;
  end;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.', ['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fRetDescUnidade(strCodUni: String): String;
begin
  Result := 'Quarto';
  If Pos(strCodUni, '102_002_') > 0 Then
    Result := 'Quarto'
  Else If Pos(strCodUni, '101_003_') > 0 Then
    Result := 'Galão'
  Else If Pos(strCodUni, '103_104_') > 0 Then
    Result := 'Lata';
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fRetDescUnidadesBase: String;
var
  qryGen: IDataSet;
  strMens: String;
begin
  Result := '';

  strMens := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   EMB_CODUNI                   ' + ' FROM                           ' +
                '   ADT_CADBAS                   ' + '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' + '  INNER JOIN ADT_CADEMB         ' +
                '     ON EMB_CODEMB = BAS_CODEMB ' + ' WHERE BAS_CODBAS = :BASE__     ' +
                '   AND BAS_PRODUT = :PRODUT     ';

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND EMB_CODUNI <> :CODUNI ';

  qryGen.ParamByName('BASE__').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('EMB_CODUNI').AsString = 'LT' Then
      Result := Result + 'Litro';

    If qryGen.FieldByName('EMB_CODUNI').AsString = 'QT' Then
      Result := Result + 'Quarto';

    If qryGen.FieldByName('EMB_CODUNI').AsString = 'GL' Then
      Result := Result + 'Galao';

    If qryGen.FieldByName('EMB_CODUNI').AsString = 'LA' Then
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

  If Pos('Quarto', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Quarto '
    Else If qryGen.RecordCount = 2 Then
      strMens := strMens + 'Quarto e '
    Else If qryGen.RecordCount > 2 Then
      strMens := strMens + 'Quarto, ';
  End;

  If Pos('Galao', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Galão '
    Else If (qryGen.RecordCount = 2) And (Pos('Quarto', Result) <= 0) Then
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

function TCadastroNovasFormulasAdvanceTintoSystem.fRetMenorUnidade(strProdut, strCodBas: String; tela: ITelaCadLibTintas): String;
var
  qryGen: IDataSet;
  strLitro, strGalao, strLata, strDesLt, strDesGl, strDesLa: String;
begin
  Result := '';

  strLitro := '';
  strGalao := '';
  strLata := '';
  strDesLt := '';
  strDesGl := '';
  strDesLa := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT *                       ' +
    '   FROM ADT_CADBAS              ' + '  INNER JOIN CADITE             ' +
    '     ON ITE_CODITE = BAS_CODITE ' + '  INNER JOIN ADT_CADEMB         ' +
    '     ON EMB_CODEMB = BAS_CODEMB ' + '  WHERE BAS_CODBAS = :DESBAS    ' +
    '    AND BAS_PRODUT = :PRODUT    ';
  qryGen.ParamByName('DESBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('EMB_CODUNI').AsString, 'LT_QT_') > 0 Then
    Begin
      strLitro := qryGen.FieldByName('BAS_CODEMB').AsString;
      strDesLt := qryGen.FieldByName('EMB_DESCRI').AsString;
    End
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'GL' Then
    Begin
      strGalao := qryGen.FieldByName('BAS_CODEMB').AsString;
      strDesGl := qryGen.FieldByName('EMB_DESCRI').AsString;
    End
    Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'LA' Then
    Begin
      strLata := qryGen.FieldByName('BAS_CODEMB').AsString;
      strDesLa := qryGen.FieldByName('EMB_DESCRI').AsString;
    End;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
  Begin
    Result := strLitro;
    tela['edtDesEmb']['Text'].Value := strDesLt;
  End
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
  Begin
    Result := strGalao;
    tela['edtDesEmb']['Text'].Value := strDesGl;
  End
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
  Begin
    Result := strLata;
    tela['edtDesEmb']['Text'].Value := strDesLa;
  End;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.FTemPedidoNfm: Boolean;
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

    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Esta alteração impedirá que ele seja faturado e obrigará a substituição da tinta no pedido antes de faturá-lo.');
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
      qryGen.ParamByName('IDEPRO').AsString := 'ADT';
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

function TCadastroNovasFormulasAdvanceTintoSystem.fValidaCampos(const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
Var
  strCampoQtd, strValorCampoQtd: String;
begin
  Result := True;

  If strNomeCampo = 'NFM_CODBAS' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('A %s deve ser preenchida', ['Base']);
    End
    Else If Not fValidarBase(strValorCampo, '', '', tela) Then
    Begin
      Result := False;
      strRetorno := Format('A base %s não está cadastrada!', [strValorCampo]);
    End;
  End
  Else If strNomeCampo = 'NFM_PRODUT' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('O %s deve ser preenchido!', ['Produto']);
    End
    Else If Not fValidarBase(GetQueryCadastro.FieldByName('NFM_CODBAS')
      .AsString, strValorCampo, '', tela) Then
    Begin
      Result := False;
      strRetorno := Format('O produto %s não está associado nesta base!',
        [strValorCampo]);
    End;
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
  Else If strNomeCampo = 'NFM_CODEMB' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('A %s deve ser preenchida!', ['Embalagem']);
    End
    Else If Not fValidarBase(GetQueryCadastro.FieldByName('NFM_CODBAS')
      .AsString, GetQueryCadastro.FieldByName('NFM_PRODUT').AsString,
      strValorCampo, tela) Then
    Begin
      Result := False;
      strRetorno := Format('A embalagem %s não está associada nesta base!',
        [strValorCampo]);
    End
    Else
    Begin
      GetQueryCadastro.FieldByName('NFM_CODEMB').AsString := fRetMenorUnidade(GetQueryCadastro.FieldByName('NFM_PRODUT').AsString,
                                                                              GetQueryCadastro.FieldByName('NFM_CODBAS').AsString, tela);
      tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_CODEMB').AsString);
    End;
  End
  Else If strNomeCampo = 'NFM_CODCOR' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('O %s deve ser preenchido!', ['Código da Cor']);
    End;
  End
  Else If strNomeCampo = 'NFM_CODCAT' Then
  Begin
    If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If Not fValidaCatalisador(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := Format('O %s informado não é valido!', ['Catalisador']);
      End;
    End;
  End
  Else If Not (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODCAT').AsString)) And (strNomeCampo = 'NFM_QTDCX1') Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessario preencher a quantidade para continuar!';
    End
    Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'GRAMAS') Or
      (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Then
    Begin
      If fGetValorPulsosMl(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'A quantidade informada em ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'GRAMAS',
            'Gramas', 'ML') + ' está incorreta!' + #13 + 'São aceitos apenas números inteiros ou decimais.';
      End
      Else If GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'GRAMAS' Then
      Begin
        GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDCX1', 'NFM_QTDCAT', [rfReplaceAll])).AsFloat :=
          TAutcomTintaFactory.Get.fStrToFloat(strValorCampo);
      End
      Else
      Begin
        GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDCX1', 'NFM_QTDCAT', [rfReplaceAll])).AsFloat :=
          TAutcomTintaFactory.Get.fStrToFloat(strValorCampo) * fPesoEspecifico(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDCX1', 'NFM_CODCAT', [rfReplaceAll])).AsString, 'BAS');
      End;
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_CODC' Then
  Begin
    If TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) Then
    Begin
      Result := False;
      strRetorno := 'É necessário ao menos preencher "1" colorante!';
    End
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If Not ValidarColorante(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'O "Colorante" não foi encontrado!';
      End
      Else If Not ValidarColoranteJaCadastrado(tela, strValorCampo,
        strNomeCampo) Then
      Begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('AVISO', 'Este "Colorante" ja está cadastrado para essa nova fórmula', ['&Ok']);
        strRetorno := '';
      End;
    End
    Else If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      tela.pSetarFocus;
      Result := True;
    End
    Else
    Begin
      strCampoQtd := 'dbeQtdC' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;
      If StrToFloatDef(strValorCampoQtd, -1) > 0 Then
      Begin
        Result := False;
        strRetorno := 'A "Quantidade" de colorante foi informada. Por favor, informe seu código!';
      End;
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDX' Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_CODC', [rfReplaceAll])).AsString) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade para continuar!';
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'GRAMAS') Or
        (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Then
      Begin
        If fGetValorPulsosMl(strValorCampo) Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada em ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'GRAMAS',
            'Gramas', 'ML') + ' está incorreta!' + #13 + 'São aceitos apenas números inteiros ou decimais.';
        End
        Else If strToFloatDef(strValorCampo, 0) <= 0 Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada deve ser maior que Zero!';
        End
        Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'GRAMAS') Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo)
        End
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo) * fPesoEspecifico(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_CODC', [rfReplaceAll])).AsString, 'COL');
        End;
      End;
    End
    Else If ((TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_CODC', [rfReplaceAll])).AsString)) And
      Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_CODC', 'NFM_QTDX', [rfReplaceAll])).AsString)) Then
    Begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    End;
  End
  Else If (LeftStr(strNomeCampo, 8) = 'NFM_QTDC') And (strNomeCampo <> 'NFM_QTDCX1') Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_CODC', [rfReplaceAll])).AsString) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário preencher a "quantidade" do colorante!';
      End
      Else If StrToFloatDef(strValorCampo, 0) <= 0 Then
      Begin
        Result := False;
        strRetorno := 'A "Quantidade" de colorante deve ser maior que Zero!';
      End;

    End;
  End
  Else If Not fValidarPreenchimentoCol(tela) Then
  Begin
    Result := False;
    strRetorno := 'Não é permetido o preenchimento aleatório dos colorantes, para finalizar preencha os campos conforme a "sequência numérica"!'
  End;

  CalculaQuantidades;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fValidaCatalisador(strCts: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT    COUNT(0) AS QTD     ' + '   FROM ADT_CADBAS     '
              + '   WHERE BAS_CODBAS = :BASE      ' + '   AND BAS_DESCRI      ' +
                '   LIKE "%PARTE B%"            ';

  qryGen.ParamByName('BASE').AsString := strCts;
  qryGen.Open;

  Result := qryGen.FieldByName('QTD').AsInteger > 0;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fValidarBase(strBase__,  strProdut, strEmba__: String; tela: ITelaCadLibTintas): Boolean;
Var
  qryGen: IDataSet;
  strDesLt,
  strDesGl,
  strDesLa,
  strDesBas,
  strDesBa2,
  strDesBa3: String;
begin
  strDesLt := '';
  strDesGl := '';
  strDesLa := '';
  strDesBas := '';
  strDesBa2 := '';
  strDesBa3 := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT *                    ' +
    '     FROM ADT_CADBAS           ' + '   INNER JOIN CADITE ON        ' +
    '     ITE_CODITE = BAS_CODITE   ' + '   INNER JOIN ADT_CADEMB ON    ' +
    '     EMB_CODEMB = BAS_CODEMB   ' + '   WHERE                       ' +
    '     BAS_CODBAS = :BASE__      ';

  If Not TStrUtils.fEmptyStr(strProdut) Then
    qryGen.SQL := qryGen.SQL + '    AND BAS_PRODUT = :PRODUT    ';

  If Not TStrUtils.fEmptyStr(strEmba__) Then
    qryGen.SQL := qryGen.SQL + '    AND BAS_CODEMB = :EMBALA    ';

  qryGen.ParamByName('BASE__').AsString := strBase__;

  If Not TStrUtils.fEmptyStr(strProdut) Then
    qryGen.ParamByName('PRODUT').AsString := strProdut;

  If Not TStrUtils.fEmptyStr(strEmba__) Then
    qryGen.ParamByName('EMBALA').AsString := strEmba__;

  qryGen.Open;

  Result := (Not qryGen.IsEmpty);

  If Result Then
  Begin
    While Not qryGen.Eof Do
    Begin
      If Pos(qryGen.FieldByName('EMB_CODUNI').AsString, 'LT_QT_') > 0 Then
      Begin
        strDesLt := qryGen.FieldByName('EMB_DESCRI').AsString;
        strDesBas := qryGen.FieldByName('BAS_DESCRI').AsString;
      End
      Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'GL' Then
      Begin
        strDesGl := qryGen.FieldByName('EMB_DESCRI').AsString;
        strDesBa2 := qryGen.FieldByName('BAS_DESCRI').AsString;
      End
      Else If qryGen.FieldByName('EMB_CODUNI').AsString = 'LA' Then
      Begin
        strDesLa := qryGen.FieldByName('EMB_DESCRI').AsString;
        strDesBa3 := qryGen.FieldByName('BAS_DESCRI').AsString;
      End;

      qryGen.Next;
    End;

    If Not TStrUtils.fEmptyStr(strDesLt) Then
    Begin
      tela['edtDesEmb']['Text'].Value := strDesLt;
      tela['edtDesBas']['Text'].Value := strDesBas;
    End
    Else If Not TStrUtils.fEmptyStr(strDesGl) Then
    Begin
      tela['edtDesEmb']['Text'].Value := strDesGl;
      tela['edtDesBas']['Text'].Value := strDesBa2;
    End
    Else If Not TStrUtils.fEmptyStr(strDesLa) Then
    Begin
      tela['edtDesEmb']['Text'].Value := strDesLa;
      tela['edtDesBas']['Text'].Value := strDesBa3;
    End;
  End;

end;

function TCadastroNovasFormulasAdvanceTintoSystem.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
  blnCampoVazio: Boolean;
begin
  Result := True;
  blnCampoVazio := False;

  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and not(blnCampoVazio) then
      blnCampoVazio := True
    else if not TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and (blnCampoVazio) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.fVerificaNovFormulas(strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                                ';
  qryGen.SQL := qryGen.SQL + '    * FROM  ' + GetNomeTabela + '       ';
  qryGen.SQL := qryGen.SQL + '  WHERE ' + GetNomeCampo  + ' = :NFM    ';
  qryGen.ParamByName('NFM').AsString  :=  strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetNomeCampoItem: string;
begin
  Result := 'NFM_CODC';
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetNomeTabela: string;
begin
  Result := 'ADT_CADNFM';
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('ADT').fGetInteger('ADTNFM');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      GetQueryCadastro.FieldByName('NFM_IDFORM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_CODTEC').AsString := 'PERSONALIZADA';

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmHyd: String;
  blnGerarUnidades: Boolean;
begin
  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoAdvanceTintoSystemNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString, blnGerarUnidades,
      blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);

    If Not tela.GetBlnAlterou Then
    Begin
      strNfmHyd := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('ADT').pSet('ADTNFM', strNfmHyd);
    End;
  end;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate := Date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'GRAMAS';

  tela['dbeCodNfm']['Enabled'].Value := False;
  tela['chkAtivad']['Checked'].Value := True;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin

  GetQueryCadastro.FieldByName('NFM_CODEMB').AsString := strUnidade;
  For intCont := 1 To 20 Do
  Begin
    If (StrToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)
      ]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
        .AsFloat := StrToFloat(FormatFloat('#0.00',
        StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)
        ]['Text'].Value)));
    End;
  End;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pAjustarRadioGroup(const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Caption'].Value := 'Quantidade dos Colorantes e Catalisador informada em :';
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 160;
  tela['DBRadioGroup']['Width'].Value := 828;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 12;
  tela['DBRadioGroup']['Columns'].Value := 2;
  stlItems.Add('GRAMAS');
  stlItems.Add('ML');
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pAtivaCadHyd;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE ADT_CADADT ' + '   SET ADT_ATIVAD = :ATIVAD ' +
    ' WHERE ADT_CODNFM = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF
    (GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName
    ('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE ADT_CADNFM           ' +
    '    SET NFM_ATIVAD = :ATIVAD ' + '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF
    (GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName
    ('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadHyd;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!',
      'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName
      ('NFM_ATIVAD').AsString = 'S', 'Desativada', 'Ativada') +
      ' com sucesso !', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!',
        'Erro na hora de ' + TAutcomTintaFactory.Get.IIF
        (GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'Desativar',
        'Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pBotaoAtivarNfm(const tela: ITelaCadLibTintas);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  If Not GetQueryCadastro.IsEmpty Then
  Begin
    tela['btnAtivarNfm']['Enabled'].Value := VerificarNovaFormulaMovimentada;
    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(tela['btnAtivarNfm']['Enabled'].Value,
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'Desativar', 'Ativar'), 'Ativar');
  End;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' + '   *                   ' +
                ' FROM                           ' + '   ADT_CADBAS                   ' +
                '  INNER JOIN CADITE             ' + '     ON ITE_CODITE = BAS_CODITE ' +
                '  INNER JOIN ADT_CADEMB         ' + '     ON EMB_CODEMB = BAS_CODEMB ' +
                ' WHERE BAS_PRODUT = :PRODUT     ' + '   AND BAS_CODBAS = :CODBAS     ';

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((Pos(qryGen.FieldByName('EMB_CODEMB').AsString, '102_002_') > 0) And (Pos(GetQueryCadastro.FieldByName('NFM_CODEMB').AsString, '102_002_')  <= 0)) Then
    Begin
      strUnidadeMenor := qryGen.FieldByName('EMB_CODEMB').AsString;
      Break;
    End
    Else If ((Pos(qryGen.FieldByName('EMB_CODEMB').AsString, '101_003_') > 0)  And (Pos(GetQueryCadastro.FieldByName('NFM_CODEMB').AsString, '101_003_')
      > 0) And (Pos(GetQueryCadastro.FieldByName('NFM_CODEMB').AsString, '103_104_102_002_') <= 0)) Then
    Begin
      strUnidadeMenor := qryGen.FieldByName('EMB_CODEMB').AsString;
      Break;
    End;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    If fAjustarQuantidade(strUnidadeMenor) Then
      pAjustaQuantidade(strUnidadeMenor, tela);
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM ADT_CADADT        ';
  qryGen.SQL := qryGen.SQL + '  WHERE ADT_IDFORM = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_IDFORM').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('ADT_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasAdvanceTintoSystem.pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
begin
  //
end;

function TCadastroNovasFormulasAdvanceTintoSystem.ValidarColorante(const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(' SELECT                     '
                                                + '   COUNT(0) AS QTD          ' +
                                                  ' FROM                       ' +
                                                  '   ADT_CADCOL               ' +
                                                  ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
                                                  ' WHERE COL_CODCOL = :CODCOL ', 'QTD', [strCodCol]) > 0;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 20 Do
  Begin
    If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont, 2)) And
      (Not TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value)) Then
    Begin
      If tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value = strCodCol Then
        Result := False;
    End;
  End;
end;

function TCadastroNovasFormulasAdvanceTintoSystem.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD     ' +
                                                 '  FROM %0:s                ' +
                                                 ' INNER JOIN ADT_CADADT ON %1:s_ITETIN = ADT_MD5KEY ' +
                                                 ' WHERE %1:s_IDEPRO = "ADT" ' +
                                                 'AND ADT_CODNFM = :CODNFM',
        [GetQueryCadastro.FieldByName('NFM_CODNFM').AsString]);
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

