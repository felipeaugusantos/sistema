unit untCadastroNovasFormulasRennerIndustrial;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas,
  untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteRennerIndustrial,
  untAutcomTintaFactory, untIDataSet,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes;

type
  TCadastroNovasFormulasRennerIndustrial = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas;
      const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strCodBas: string): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    function ValidarProduto(strCodBase, strProduto, strCodUni: String;
      const tela: ITelaCadLibTintas): Boolean;

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadREN;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;

    function ValidarEmbalagem(const strCodEmb, strUnidad: String): Boolean;

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;
    function fPedidoAberto(strPedido: String; blnResult: Boolean): Boolean;

    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String;
      const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Integer;
    function fRetDescUnidade(strCodUni: String): String;

    function fRetMenorUnidade(strProdut, strCodBas, strUnidad: String): String;
  protected
    procedure ConstruirControles; override;
  public
    function GetTitulo: string; override;
    function GetConsulta: IConsulta; override;
    function GetCamposDesabilitadosEdit: TCadLibTintasStringArray; override;
    function GetNomeCampo: string; override;
    function GetNomeTabela: string; override;
    function GetNomeCampoRelacionamento: string; override;
    procedure pSetaEnableReadOnly(const tela: ITelaCadLibTintas;
      const strState: string); override;
    function fGetCampoChave(const index: Integer): string; override;
    function fGetCountCamposChave: Integer; override;
    function fValidaCampos(const tela: ITelaCadLibTintas; strNomeCampo: string;
      strValorCampo: string; var strRetorno: string): Boolean; override;
    function fVerificaNovFormulas(strCodNfm: String): Boolean; Override;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); override;
    procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;
    procedure AjustarTela(const tela: ITelaCadLibTintas); override;
    procedure IncluirAntes(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure GravarDepois(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure AlterarAntes(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure AlterarDepois(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure ExcluirAntes(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure AtivarNovasFormulas(const tela: ITelaCadLibTintas;
      const strState: string); override;
    procedure PesquisarDepois(const tela: ITelaCadLibTintas;
      const strState: string); override;

    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    property blnAtualizaUni: Boolean read blnAtualizaUnidade
      write blnAtualizaUnidade;
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
  untConsultaCadastroNovasFormulasRennerIndustrial,
  untDbeCodColKeyPressRennerIndustrial,
  untDbeCodProKeyPressNovasFormulasRennerIndustrial,
  untDbeCodEmbKeyPressNovasFormulasRennerIndustrial, untTypesSistema,
  untGravandoExecucaoRennerIndustrialNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untDbeCodUniKeyPress, untDbeDesProKeyPressNovasFormulasRennerIndustrial;
{ TCadastroNovasFormulasRennerIndustrial }

procedure TCadastroNovasFormulasRennerIndustrial.AjustarTela
  (const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 500;
  tela['btnAtivarNfm']['Visible'].Value := True;
  tela.GetSelf['Width'].Value := 980;

  tela['dbeCodUni']['Enabled'].Value := false;
  tela['dbeCodNfm']['Enabled'].Value := False;

  blnAtualizaUnidade := False;
  strUnidadeMenor := '';
end;

procedure TCadastroNovasFormulasRennerIndustrial.AlterarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasRennerIndustrial.AlterarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeCodUni']['Enabled'].Value := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  pLimparQuantidades(GetQueryCadastro);

  If GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML' Then
    pAjustarCamposMl(tela)
  Else
    pAjustarCamposOnca(tela);
end;

procedure TCadastroNovasFormulasRennerIndustrial.AtivarNovasFormulas
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODIGO')
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

procedure TCadastroNovasFormulasRennerIndustrial.CarregarDescricoes
  (const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODEMB')
    .AsString)) Then
  Begin
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT              ' + '   EMB_CODEMB,       ' +
      '   EMB_QTDEMB,       ' + '   EMB_UNIDAD,       ' +
      '   AUTOINCREM        ' + '  FROM REN_CADEMB ' +
      ' WHERE EMB_CODEMB = :CODEMB ';

    qryGen.ParamByName('CODEMB').AsString := GetQueryCadastro.FieldByName
      ('NFM_CODEMB').AsString;
    qryGen.Open;

    tela['edtQtdEmb']['Text'].Value := qryGen.FieldByName('EMB_QTDEMB')
      .AsString;
  End;
end;

procedure TCadastroNovasFormulasRennerIndustrial.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm',
    'Código:', 8, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create
    ('lblDataCadastro', 'Data Cadastro:', 180, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo',
    'Base:', 45, 55, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto',
    'Produto:', 157, 55, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade',
    'Unidade:', 370, 55, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbala',
    'Embalagem:', 24, 77, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdEmb',
    'Quantidade:', 175, 77, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUniEmb',
    'Unidade:', 320, 77, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao',
    'Descrição:', 24, 99, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra',
    'Acréscimo mão de obra:', 95, 123, 25, 14, 'taRightJustify'));

  groupColorantes := TGenericLibTintaControleVisualWinControl.Create
    ('TGroupBox', 'gpbColorantes', 1, 130, 521, 249).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Caption', '     Colorantes      '));

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
      .AdicionarEvento(TDbeCodColKeyPressRennerIndustrial.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
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
      .AdicionarEvento(TDbeCodColKeyPressRennerIndustrial.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
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

  groupColorantes.AdicionarControle(TLibTintaControleVisualImplementacao.Create
    (' object Label5: TLabel                                  ' +
    '   Left = 80                                            ' +
    '   Top = 0                                              ' +
    '   Width = 460                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taLeftJustify                           ' +
    '   AutoSize = False                                     ' +
    '   Caption = ''A quantidade dos colorantes deve ser informada sempre no volume padrão LITRO'' '
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

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeCodNfm', 84, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODIGO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeDataCadastro', 254, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase',
    84, 52, 85, 22, 'ttAlfanumerico', 'NFM_CODBAS')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasRennerIndustrial.Create
    ('OnKeyPress', Self)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeCodUni', 430, 52, 45, 22, 'ttAlfanumerico', 'NFM_UNIDAD')
    .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeProdut', 219, 52, 161, 22, 'ttAlfanumerico', 'NFM_DESPRO')
    .AdicionarEvento(TDbeDesProKeyPressNovasFormulasRennerIndustrial.Create
    ('OnKeyPress', Self)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeEmbala', 84, 75, 85, 22, 'ttAlfanumerico', 'NFM_CODEMB')
    .AdicionarEvento(TDbeCodEmbKeyPressNovasFormulasRennerIndustrial.Create
    ('OnKeyPress', Self)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtQtdEmb',
    237, 75, 88, 22, 'ttAlfanumerico').AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('CharCase', 'ecUpperCase')).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('NormalColor', 16768952)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('TabStop', False)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtUniEmb',
    380, 75, 45, 22, 'ttAlfanumerico').AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('CharCase', 'ecUpperCase')).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('NormalColor', 16768952)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('TabStop', False)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeDescri', 84, 98, 389, 22, 'ttAlfanumerico', 'NFM_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra',
    123, 121, 100, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad',
    230, 123, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Enabled', False)));

  AdicionarControle((groupColorantes).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

end;

procedure TCadastroNovasFormulasRennerIndustrial.DeletaNovaFormula
  (strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM REN_CADREN WHERE REN_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerIndustrial.ExcluirAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
end;

procedure TCadastroNovasFormulasRennerIndustrial.ExcluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
    begin
      DeletaNovaFormula(strCodNfmDel);
      tela['edtQtdEmb']['Text'].Value := '';
    end;
  end;
end;

function TCadastroNovasFormulasRennerIndustrial.fGetCampoChave
  (const index: Integer): string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasRennerIndustrial.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasRennerIndustrial.FormatarCampo
  (const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray;
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

function TCadastroNovasFormulasRennerIndustrial.fPedidoAberto(strPedido: String;
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

function TCadastroNovasFormulasRennerIndustrial.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasRennerIndustrial.fPodeAlterar: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    If Not fPermiteAlterarNfmVendida Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO',
        'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la.',
        ['&OK']);
      Result := False;
    End
    Else
    Begin
      If Not FTemPedidoNfm() Then
        Result := False;
    End;
  end;
end;

function TCadastroNovasFormulasRennerIndustrial.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO',
      'Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',
      ['&OK']);
    Result := False;
  end;

end;

function TCadastroNovasFormulasRennerIndustrial.fValidaCampos
  (const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
Var
  strCampoQtd: String;
  strValorCampoQtd: String;
  qryGen: IDataSet;

  procedure CarregarDescricao;
  begin
    if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_DESPRO').AsString)
      and (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_UNIDAD')
      .AsString)) and
      (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODBAS')
      .AsString)) then
    begin
      GetQueryCadastro.FieldByName('NFM_DESPRO').AsString :=
        VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
        (' SELECT                     ' + '   BAS_DESCRI               ' +
        ' FROM                       ' + '   REN_CADBAS               ' +
        ' WHERE BAS_BASE__ = :CODBAS ' + '   AND BAS_UNIDAD = :CODUNI ' +
        '   AND BAS_DESCRI = :DESCRI  ', 'BAS_DESCRI',
        [GetQueryCadastro.FieldByName('NFM_CODBAS').AsString,
        GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString,
        GetQueryCadastro.FieldByName('NFM_DESPRO').AsString]), '');
    end;

    If (Not TStrUtils.fEmptyStr(tela['dbeEmbala']['Text'].Value)) Then
    Begin
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT              ' + '   EMB_CODEMB,       ' +
        '   EMB_QTDEMB,       ' + '   EMB_UNIDAD,       ' +
        '   AUTOINCREM        ' + '  FROM REN_CADEMB ' +
        ' WHERE EMB_CODEMB = :CODEMB ';

      qryGen.ParamByName('CODEMB').AsString := tela['dbeEmbala']['Text'].Value;
      qryGen.Open;

      tela['edtQtdEmb']['Text'].Value :=
        qryGen.FieldByName('EMB_QTDEMB').AsString;
      // tela['edtUniEmb']['Text'].Value := qryGen.FieldByName('EMB_UNIDAD').AsString;
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
    else if not ValidarBase(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'Base não encontrada!';
    end
    else
      CarregarDescricao;
  End

  Else If strNomeCampo = 'NFM_DESPRO' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Produto"!';
    end
    else if not ValidarProduto(GetQueryCadastro.FieldByName('NFM_CODBAS')
      .AsString, strValorCampo, GetQueryCadastro.FieldByName('NFM_UNIDAD')
      .AsString, tela) Then
    begin
      Result := False;
      strRetorno := 'Produto não cadastrado para a base selecionada!';
    end;
  End

  Else If strNomeCampo = 'NFM_CODEMB' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Embalagem"!';
    end
    else if not ValidarEmbalagem(strValorCampo,
      GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString) then
    begin
      Result := False;
      strRetorno := 'Embalagem não encontrada!';
    end
    else
      CarregarDescricao;
  End

  Else If strNomeCampo = 'NFM_DESCRI' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    end
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
      else if not ValidarColoranteJaCadastrado(tela, strValorCampo, strNomeCampo)
      then
      begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO',
          'Esse Colorante já está cadastrado para essa nova fórmula!', ['&Ok']);
        strRetorno := '';
      end;
    end
    else if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela.pSetarFocus;
      Result := True;
    end
    else
    begin
      strCampoQtd := 'dbeQtdC' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;
      if strToFloatDef(strValorCampoQtd, -1) > 0 then
      begin
        Result := False;
        strRetorno :=
          'A quantidade do colorante foi informada. Por favor, informe seu código.';
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
    if not TStrUtils.fEmptyStr
      (GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC',
      'NFM_FORM', [rfReplaceAll])).AsString) then
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
    else if ((TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName
      (StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll]))
      .AsString)) and
      ((not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName
      (StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll]))
      .AsString)) And (strToFloatDef(GetQueryCadastro.FieldByName
      (StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll]))
      .AsString, 0) > 0))) then
    begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    end
  End
  Else if not(fValidarPreenchimentoCol(tela)) then
  Begin
    Result := False;
    strRetorno :=
      'Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  End;
end;

function TCadastroNovasFormulasRennerIndustrial.fValidarPreenchimentoCol
  (const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
  blnCampoVazio: Boolean;
begin
  Result := True;
  blnCampoVazio := False;

  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)
      ]['Text'].Value) and not(blnCampoVazio) then
      blnCampoVazio := True
    else if not TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont,
      2)]['Text'].Value) and (blnCampoVazio) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasRennerIndustrial.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                                  ';
  qryGen.SQL := qryGen.SQL + '    * FROM  ' + GetNomeTabela + '         ';
  qryGen.SQL := qryGen.SQL + '  WHERE ' + GetNomeCampo  + ' = :NFM      ';
  qryGen.ParamByName('NFM').AsString  :=  strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasRennerIndustrial.fRetDescUnidadesBase: String;
var
  qryGen: IDataSet;
  strMens: String;
begin
  Result := '';

  strMens := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
    '   BAS_UNIDAD                   ' + ' FROM                           ' +
    '   REN_CADBAS                ' + '  INNER JOIN CADITE             ' +
    '     ON ITE_CODITE = BAS_CODITE ' + ' WHERE BAS_DESCRI = :PRODUT     ' +
    '   AND BAS_BASE__ = :CODBAS     ';

  If (Not blnAtualizaUnidade) And
    (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName
    ('NFM_DESPRO').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName
    ('NFM_CODBAS').AsString;

  If (Not blnAtualizaUnidade) And
    (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('BAS_UNIDAD').AsString = 'LT' Then
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

procedure TCadastroNovasFormulasRennerIndustrial.pExisteUnidadeMenorCadastrada
  (const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
    '   BAS_UNIDAD                   ' + ' FROM                           ' +
    '   REN_CADBAS                ' + '  INNER JOIN CADITE             ' +
    '     ON ITE_CODITE = BAS_CODITE ' + ' WHERE BAS_DESCRI = :PRODUT     ' +
    '   AND BAS_BASE__ = :CODBAS     ';

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName
    ('NFM_DESPRO').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName
    ('NFM_CODBAS').AsString;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((qryGen.FieldByName('BAS_UNIDAD').AsString = 'LT') And
      (GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString <> 'LT')) Then
    Begin
      strUnidadeMenor := 'LT';
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL') And
      (GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString <> 'GL') And
      (GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString <> 'LT')) Then
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

procedure TCadastroNovasFormulasRennerIndustrial.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM REN_CADREN        ';
  qryGen.SQL := qryGen.SQL + '  WHERE REN_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('REN_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

function TCadastroNovasFormulasRennerIndustrial.fAjustarQuantidade
  (strUnidade: String): Boolean;
begin
  Result := False;
  blnAtualizaUnidade := False;
  If TAutcomTintaFactory.Get.fMensagem('QUESTÃO',
    'Existe uma nova unidade cadastrada para a base selecionada,' + #13#10 +
    'essa unidade é inferior a atual cadastrada na nova fórmula.' + #13#10 +
    'Deseja atualizar para a unidade nova ?' + #13#10 + 'Unidade Atual : ' +
    GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString + #13#10 +
    'Unidade Nova  : ' + strUnidade, ['&Sim', '&Não']) = 1 Then
  Begin
    Result := True;
    blnAtualizaUnidade := True;
  End;
end;

function TCadastroNovasFormulasRennerIndustrial.fCalculaOncaParaMl(strTipOnc,
  strOnca: String): Double;
Var
  intInteiro: Integer;
  fltFracao: Double;
  strCalculo: String;
  strCalculo1: String;
begin
  Result := 0;
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

procedure TCadastroNovasFormulasRennerIndustrial.pAjustaQuantidade
  (strUnidade: String; const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' +
    fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)
      ]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
        .AsFloat := StrToFloat(FormatFloat('#0.00',
        StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)
        ]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasRennerIndustrial.pAjustarCamposMl(
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

procedure TCadastroNovasFormulasRennerIndustrial.pAjustarCamposOnca(
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

procedure TCadastroNovasFormulasRennerIndustrial.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 143;
  tela['DBRadioGroup']['Width'].Value := 973;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 14;
  tela['DBRadioGroup']['Columns'].Value := 2;
  stlItems.Add('ONÇA INGLESA');
  stlItems.Add('ML');
end;

function TCadastroNovasFormulasRennerIndustrial.fRetFatorDivisaoUnidade
  (strUnidade: String): Integer;
begin
  Result := 1;
  If strUnidade = 'LT' Then
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

function TCadastroNovasFormulasRennerIndustrial.fRetDescUnidade
  (strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'LT' Then
    Result := 'Litros'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

function TCadastroNovasFormulasRennerIndustrial.fRetMenorUnidade(strProdut,
  strCodBas, strUnidad: String): String;
var
  qryGen: IDataSet;
  strLitro, strGalao, strLata: String;
begin
  Result := strUnidad;

  strLitro := '';
  strGalao := '';
  strLata := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_UNIDAD              ' +
    '   FROM REN_CADBAS           ' + '  INNER JOIN CADITE             ' +
    '     ON ITE_CODITE = BAS_CODITE ' + '  WHERE BAS_DESCRI = :PRODUT    ' +
    '    AND BAS_BASE__ = :CODBAS    ' + '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('PRODUT').AsString := strProdut;
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

function TCadastroNovasFormulasRennerIndustrial.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'REN';
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

function TCadastroNovasFormulasRennerIndustrial.GetCamposDesabilitadosEdit
  : TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasRennerIndustrial.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasRennerIndustrial.Create;
end;

function TCadastroNovasFormulasRennerIndustrial.GetNomeCampo: string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasRennerIndustrial.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasRennerIndustrial.
  GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasRennerIndustrial.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasRennerIndustrial.GetNomeTabela: string;
begin
  Result := 'REN_CADNFM';
end;

function TCadastroNovasFormulasRennerIndustrial.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasRennerIndustrial.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasRennerIndustrial.GetTipoTinta: TTipoTinta;
begin
  Result := ttIndustrial;
end;

function TCadastroNovasFormulasRennerIndustrial.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasRennerIndustrial.GravarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    IntPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('REN').fGetInteger('NFMREN');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(IntPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODIGO').AsString :=  'ESP '  + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasRennerIndustrial.GravarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmREN: String;
  blnGerarUnidades: Boolean;
begin

  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO',  'Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoRennerIndustrialNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString, blnGerarUnidades,
      blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);

    If Not tela.GetBlnAlterou Then
    Begin
      strNfmREN := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('REN').pSet('NFMREN', strNfmREN);
    End;
  end;
end;

procedure TCadastroNovasFormulasRennerIndustrial.IncluirAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['edtQtdEmb']['Text'].Value := '';
end;

procedure TCadastroNovasFormulasRennerIndustrial.IncluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := 'LT';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate := Date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'ML';

  tela['dbeCodUni']['Enabled'].Value := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value := False;
  tela.SelectNext;
  pAjustarCamposMl(tela);
end;

procedure TCadastroNovasFormulasRennerIndustrial.pAtivaCadREN;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE REN_CADREN ' + '   SET REN_ATIVAD = :ATIVAD ' +
    ' WHERE REN_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF
    (GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName
    ('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerIndustrial.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE REN_CADNFM           ' +
    '    SET NFM_ATIVAD = :ATIVAD ' + '  WHERE NFM_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF
    (GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName
    ('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerIndustrial.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadREN;

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

procedure TCadastroNovasFormulasRennerIndustrial.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasRennerIndustrial.PesquisarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' +
      fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
end;

procedure TCadastroNovasFormulasRennerIndustrial.pSetaEnableReadOnly
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeCodNfm']['Enabled'].Value :=
    MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Checked'].Value :=
    MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeCodNfm']['Enabled'].Value :=
    MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeBase']['Enabled'].Value :=
    MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDescri']['Enabled'].Value :=
    MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Enabled'].Value :=
    MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['gpbColorantes']['Enabled'].Value :=
    MatchStr(strState, ['dsEdit', 'dsInsert']);
end;

function TCadastroNovasFormulasRennerIndustrial.ValidarBase(const strCodBas
  : string): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo
      (' SELECT                     ' + '   COUNT(0) AS QTD          ' +
      ' FROM                       ' + '   REN_CADBAS            ' +
      '   INNER JOIN CADITE              ' +
      '     ON BAS_CODITE = ITE_CODITE   ' + ' WHERE BAS_BASE__ = :CODBAS ',
      'QTD', [strCodBas]) > 0;
  end;
end;

function TCadastroNovasFormulasRennerIndustrial.ValidarColorante(const strCodCol
  : string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(' SELECT                     '
    + '   COUNT(0) AS QTD          ' + ' FROM                       ' +
    '   REN_CADCOL            ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ', 'QTD', [strCodCol]) > 0;
end;

function TCadastroNovasFormulasRennerIndustrial.ValidarColoranteJaCadastrado
  (const tela: ITelaCadLibTintas; const strCodCol, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 20 Do
  Begin
    If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont, 2)) And
      (Not TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)
      ]['Text'].Value)) Then
    Begin
      If tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)
        ]['Text'].Value = strCodCol Then
        Result := False;
    End;
  End;
end;

function TCadastroNovasFormulasRennerIndustrial.ValidarEmbalagem
  (const strCodEmb, strUnidad: String): Boolean;
begin
  Result := False;
  if (not TStrUtils.fEmptyStr(strCodEmb)) then
  Begin
    Result := TAutcomTintaFactory.Get.GetValorCampo
      (' SELECT                       ' + '   COUNT(0) AS QTD            ' +
      ' FROM                         ' + '   REN_CADEMB              ' +
      '   WHERE EMB_CODEMB = :CODEMB ' + '     AND EMB_UNIDAD = :UNIDAD ',
      'QTD', [strCodEmb, strUnidad]) > 0;
  End;
end;

function TCadastroNovasFormulasRennerIndustrial.ValidarProduto(strCodBase,
  strProduto, strCodUni: String; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := False;
  if (not TStrUtils.fEmptyStr(strCodBase)) And
    (not TStrUtils.fEmptyStr(strProduto)) And
    (not TStrUtils.fEmptyStr(strCodUni)) then
  Begin
    Result := TAutcomTintaFactory.Get.GetValorCampo
      (' SELECT                       ' + '   COUNT(0) AS QTD            ' +
      ' FROM                         ' + '   REN_CADBAS              ' +
      '  INNER JOIN CADITE             ' + '     ON ITE_CODITE = BAS_CODITE ' +
      '   WHERE BAS_BASE__ = :CODBAS ' + '     AND BAS_DESCRI = :PRODUT ' +
      '     AND BAS_UNIDAD = :UNIDAD ', 'QTD', [strCodBase, strProduto,
      strCodUni]) > 0;

    If Not Result Then
    Begin
      GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString :=
        fRetMenorUnidade(strProduto, strCodBase, strCodUni);
      tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' +
        fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
    End;
  End;
end;

function TCadastroNovasFormulasRennerIndustrial.
  VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD ' +
        '  FROM %0:s ' + ' INNER JOIN REN_CADREN ON %1:s_ITETIN = REN_MD5KEY ' +
        ' WHERE %1:s_IDEPRO = "REN" ' + '   AND REN_CODIGO = :CODNFM',
        [GetQueryCadastro.FieldByName('NFM_CODIGO').AsString]);
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
