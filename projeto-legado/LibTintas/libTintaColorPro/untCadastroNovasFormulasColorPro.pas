unit untCadastroNovasFormulasColorPro;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils, Classes,
  untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untGenericLibTintaControleVisualDBMemoFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untIDataSet, DBEditFocus, ExtCtrls;

type
  TCadastroNovasFormulasColorPro = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnEdit: Boolean;
    intPrxNfm: Integer;
    qryBases    : IDataSet;

    function ValidarBase(const strCodBas: string; const strLinha_: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas; const strCodBas: string; const strNomCam: string): Boolean;
    procedure pCalcularTotalVolume(const tela: ITelaCadLibTintas);
    procedure ConstruirQryBasesValume;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(const qryCadastro: IDataSet): String;
    function FTemPedidoNfm(): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadWcp;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;

    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);

    function fRetCodLinha(strNomLin: String): String;

    function fValidarBasePreenchida(const tela: ITelaCadLibTintas): Boolean;
    function fValidarQntConcDiluida(const tela: ITelaCadLibTintas) : Boolean;
    function fInformarDiluente(const tela: ITelaCadLibTintas) : Boolean;
    function fPreencherQntDiluente21(const tela: ITelaCadLibTintas) : Boolean;
    function fPreencherQntDiluente41(const tela: ITelaCadLibTintas) : Boolean;
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
    procedure CancelarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    function GetPreencherDbComboBox: Boolean; override;
    function GetDescDbComboBox: String; override;
    procedure pDesabilitaDiluidos(strNomLin, strState: String; const tela: ITelaCadLibTintas);

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean; override;
    procedure AjustarCampos(Tela: ITelaCadLibTintas); Override;
  end;

  TBtnAjustarVolumeOnClick = class(TAbstractLibTintaControleVisualEvento)
  private
    qryBases: IDataSet;
    function fRetornaVolumeLinha2a1(strLinha: String): Double;
    function fRetornaVolumeLinha4a1(strLinha: String): Double;
    procedure pCalcularTotalVolume(const cadastro: TAbstractCadastro);
    procedure AjustarVolume(const tela: ITelaCadLibTintas);
    procedure ConstruirQryBasesValume;
  published
    procedure OnClick(Sender: TObject);
  end;

var
  fltTotalConcentrado : Double;
  fltTotalDiluido1    : Double;
  fltTotalDiluido2    : Double;

implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl, untDbeCodBasKeyPressColorPro,
  untGravandoExecucaoColorProNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untGravandoExecucaoColorProCores, untDbeCodDilKeyPressColorPro,
  untDbeDBComboLinhaChangeColorPro, untBtnCarregaFormulasCadastradaOnClickColorPro,
  untTypesSistema;
{ TCadastroNovasFormulasColorPro }

procedure TCadastroNovasFormulasColorPro.AjustarCampos(Tela: ITelaCadLibTintas);
Var
  intContador: Integer;
begin
  If GetQueryCadastro.FieldByName('NFM_LINHA_').AsString = '72' Then
  Begin
    For intContador := 1 To 20 Do
      Tela['lblQtdDil' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := 'Qtd. Dil.(9:2):';

    Tela['lblQtdDil']['Caption'].Value := 'Quantid. (9:2):';
  End
  Else
  Begin
    For intContador := 1 To 20 Do
      Tela['lblQtdDil' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := 'Qtd. Dil.(2:1):';

    Tela['lblQtdDil']['Caption'].Value := 'Quantid. (2:1):';
  End;
end;

procedure TCadastroNovasFormulasColorPro.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 730;
  tela.GetSelf['Width'].Value  := 690;
  tela['btnAtivarNfm']['Visible'].Value := True;
  tela['dbeLinha']['Enabled'].Value     := False;
  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Enabled'].Value   := False;
  tela['DBComboBox']['Left'].Value      := 80;
  tela['DBComboBox']['Top'].Value       := 47;
  tela['DBComboBox']['Width'].Value     := 200;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'NFM_NOMLIN';
  tela['DBComboBox']['TabOrder'].Value  := 4;
  tela.Controle['DBComboBox'].AdicionarEvento(TDbeDBComboLinhaChangeColorPro.Create(Self, 'dbeLinha'));
  blnEdit := False;
  pBotaoAtivarNfm(tela);
  ConstruirQryBasesValume;
end;

procedure TCadastroNovasFormulasColorPro.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasColorPro.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela['dbeLinha']['Enabled'].Value  := False;
  pCalcularTotalVolume(tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
  blnEdit := True;

  pDesabilitaDiluidos(GetQueryCadastro.FieldByName('NFM_NOMLIN').AsString, strState, tela);
  AjustarCampos(Tela);

  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasColorPro.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;

    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar');
  End;
end;

procedure TCadastroNovasFormulasColorPro.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pDesabilitaDiluidos(GetQueryCadastro.FieldByName('NFM_NOMLIN').AsString, strState, tela);
  pCalcularTotalVolume(tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
  AjustarCampos(Tela);
end;

procedure TCadastroNovasFormulasColorPro.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroNovasFormulasColorPro.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  groupCatalise: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 3, 7, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCad', 'Data Cadastro:', 208, 7, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 3, 29, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', 3, 53, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAlternativa', 'Alternativa:', 321, 53, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMontadora', 'Montadora:', 3, 75, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCamada', 'Camada:', 322, 75, 73, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob', 'Acrésc. Mão de Obra:', 540, 75, 50, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDiluente', 'Diluente:', 10, 595, 60, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil', 'Quantid. (2:1):', 303, 595, 70, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDi4', 'Quantid. (4:1):', 462, 595, 70, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 80, 3, 100, 22, 'ttAlfanumerico', 'NFM_CODNFM')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDtaCad', 285, 3, 100, 22, 'ttAlfanumerico', 'NFM_DTACAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 428, 6, 70, 17, 'Ativa', 'NFM_ATIVO_', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '2'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 80, 25, 390, 22, 'ttAlfanumerico', 'NFM_DESCRI')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '3'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeLinha', 283, 47, 49, 22, 'ttAlfanumerico', 'NFM_LINHA_')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', 'False')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAltern', 400, 47, 70, 22, 'ttAlfanumerico', 'NFM_ALTERN')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMontad', 80, 70, 252, 22, 'ttAlfanumerico', 'NFM_MONTAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '6'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCamada', 400, 70, 70, 22, 'ttNumerico', 'WAN_CAMADA')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '7'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 591, 70, 70, 22, 'ttAlfanumerico', 'NFM_ACRMOB')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '8'))
  );

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnCarregarBases: TSpeedButton                        ' +
    '   Left = 35                                                  ' +
    '   Top = 92                                                   ' +
    '   Width = 600                                                ' +
    '   Height = 20                                                ' +
    '   Hint = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''         ' +
    '   Caption = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''      ' +
    '   ParentShowHInt = False                                      ' +
    '   ShowHint = True                                             ' +
    '   Visible = True                                              ' +
    ' End                                                           ')
    .AdicionarEvento(TBtnCarregaBasesCadastrada.Create(Self)));

  groupCatalise := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbCatali', 480, 05, 190, 70)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', ' Catalise '));

  groupCatalise.AdicionarControle(TGenericLibTintaControleVisualDBMemoFocus.Create('dbeCatali', 05, 15, 180, 50, 'NFM_CATALI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

  AdicionarControle(groupCatalise);

  groupBases := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbBases', 1, 111, 740, 471)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alNone'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Bases      '))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '10'));

  for intCont := 1 to 20 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 12, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Conc.:', 158, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Dil.(2:1):', 315, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdD41' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Dil.(4:1):', 474, (22 * intCont) + 3, 57, 14, 'taRightJustify'));


    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 73,
      22 * intCont, 80, 22, 'ttAlfanumerico', 'NFM_CODB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressColorPro.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2), 'dbeLinha'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 216,
      22 * intCont, 80, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdD' + TStrUtils.fStrZero(intCont , 2), 376,
      22 * intCont, 80, 22, 'ttAlfanumerico', 'NFM_QTDD' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQt41' + TStrUtils.fStrZero(intCont , 2), 538,
      22 * intCont, 80, 22, 'ttAlfanumerico', 'NFM_QD41' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')));
  end;
{
  for intCont := 11 to 20 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 400, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Conc.:', 552, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Dil.:', 660, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 460,
      22 * (intCont - 10), 80, 22, 'ttAlfanumerico', 'NFM_CODB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressColorPro.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 610,
      22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdD' + TStrUtils.fStrZero(intCont , 2), 720,
      22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_QTDD' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;
 }
  AdicionarControle(groupBases);

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodDil', 74, 588, 80, 22, 'ttAlfanumerico', 'NFM_CODDIL')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '11'))
  .AdicionarEvento(TDbeCodDilKeyPressColorPro.Create(Self, 'dbeCodDil'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdDil', 377, 588, 80, 22, 'ttAlfanumerico', 'NFM_QTDDIL')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '12')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdDi4', 539, 588, 80, 22, 'ttAlfanumerico', 'NFM_QTDDI4')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '13')));


  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
      ' object lblVolumeTotal: TLabel                               ' +
      '   Left         = 200                                        ' +
      '   Top          = 615                                        ' +
      '   Width        = 450                                        ' +
      '   Height       = 16                                         ' +
//      '   Align        = alRight                                    ' +
      '   Alignment    = taRightJustify                             ' +
      '   AutoSize     = False                                      ' +
      '   Caption      = ''''                                       ' +
      '   Color        = clTeal                                     ' +
      '   Font.Charset = ANSI_CHARSET                               ' +
      '   Font.Color   = clBlack                                    ' +
      '   Font.Height  = 16                                         ' +
      '   Font.Name    = ''Arial''                                  ' +
      '   Font.Pitch   = fpVariable                                 ' +
      '   Font.Style   = [fsBold]                                   ' +
      '   ParentColor  = False                                      ' +
      '   ParentFont   = False                                      ' +
      ' end                                                         ' ));

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
      ' object lblCadastrar: TLabel                                 ' +
      '   Left         = 370                                        ' +
      '   Top          = 637                                        ' +
      '   Width        = 300                                        ' +
      '   Height       = 14                                         ' +
//      '   Align        = alRight                                    ' +
      '   Alignment    = taRightJustify                             ' +
      '   AutoSize     = False                                      ' +
      '   Caption      = ''Cadastrar a fórmula no volume original'' ' +
      '   Color        = clTeal                                     ' +
      '   Font.Charset = ANSI_CHARSET                               ' +
      '   Font.Color   = clRed                                      ' +
      '   Font.Height  = 16                                         ' +
      '   Font.Name    = ''Arial''                                  ' +
      '   Font.Pitch   = fpVariable                                 ' +
      '   Font.Style   = [fsBold]                                   ' +
      '   ParentColor  = False                                      ' +
      '   ParentFont   = False                                      ' +
      ' end                                                         ' ));

  AdicionarControle(
    TLibTintaControleVisualImplementacao.Create(
      ' object btnAjustarVolume: TBitBtn                                        ' +
      '   Left    = 300                                                         ' +
      '   Top     = 634                                                         ' +
      '   Width   = 119                                                         ' +
      '   Height  = 20                                                          ' +
      '   Hint    = ''Clique aqui para ajustar o Volume original da linha''     ' +
      '   Caption = ''&Ajustar Volume''                                         ' +
      '   Enabled = False                                                       ' +
      '   Glyph.Data = {                                                        ' +
      '     76010000424D7601000000000000760000002800000020000000100000000100    ' +
      '     04000000000000010000120B0000120B00001000000000000000000000000000    ' +
      '     800000800000008080008000000080008000808000007F7F7F00BFBFBF000000    ' +
      '     FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000    ' +
      '     73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998    ' +
      '     0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808    ' +
      '     0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808    ' +
      '     0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808    ' +
      '     0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008    ' +
      '     0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008    ' +
      '     0333337F777777737F333308888888880333337F333333337F33330888888888    ' +
      '     03333373FFFFFFFF733333700000000073333337777777773333}               ' +
      '   NumGlyphs      = 2                                                    ' +
      '   ParentShowHint = False                                                ' +
      '   ShowHint       = True                                                 ' +
      '   TabOrder       = 7                                                    ' +
      ' end                                                                     ' )

  .AdicionarEvento(TBtnAjustarVolumeOnClick.Create('OnClick', Self)));
end;

procedure TCadastroNovasFormulasColorPro.ConstruirQryBasesValume;
var
  strSql: string;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    '   , BAS_LINHA_           ' +
    ' FROM                     ' +
    '   WANPRO_CADBAS             ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := strSql;
  qryBases.Open;
end;

procedure TCadastroNovasFormulasColorPro.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM WANPRO_CADWAN WHERE WAN_CODAKZ = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasColorPro.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasColorPro.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
end;

function TCadastroNovasFormulasColorPro.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasColorPro.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasColorPro.fGetMd5KeyPedidos(
  const qryCadastro: IDataSet): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM WANPRO_CADWAN     ';
  qryGen.SQL := qryGen.SQL + '  WHERE WAN_CODAKZ = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('WAN_MD5KEY').AsString;
end;

function TCadastroNovasFormulasColorPro.fInformarDiluente(
  const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdD' + TStrUtils.fStrZero(intCont,2)]['Text'].Value,0) <> 0) Or
       (strToFloatDef(tela['dbeQt41' + TStrUtils.fStrZero(intCont,2)]['Text'].Value,0) <> 0) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

procedure TCadastroNovasFormulasColorPro.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(LeftStr(strNomeCampo, Length('NFM_QTDC')), ['NFM_QTDC', 'NFM_QTDD', 'NFM_QD41']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.000';
    arrValores[1] := '0.000';
  end
  else if MatchStr(strNomeCampo, ['NFM_ACRMOB']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end;;
end;

function TCadastroNovasFormulasColorPro.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasColorPro.fPodeAlterar: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    if Not fPermiteAlterarNfmVendida Then
    begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel alterá-la.',['&OK']);
      Result := False;
    end
    else
    begin
      if not FTemPedidoNfm() then
        Result := False;
    end;
  end;
end;

function TCadastroNovasFormulasColorPro.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasColorPro.fPodeGravar(
  const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := True;

  if fValidarQntConcDiluida(tela) then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Existe base preenchida sem quantidade informada!', ['&Ok']);
    Result := False;
  end

  else if fValidarBasePreenchida(tela) then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Alguma quantidade "concentrada" ou "diluída" foi preenchida sem que a "base" fosse informada!', ['&Ok']);
    Result := False;
  end

  else if (Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value)) and (Not fInformarDiluente(tela)) then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Ao informar o "diluente", é necessário que alguma quantidade diluída seja preenchida!', ['&Ok']);
    Result := False;
  end

  else if (TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value)) and (fInformarDiluente(tela)) then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Ao informar uma quantidade diluída, é necessário que o diluente seja preenchido!', ['&Ok']);
//    pSetFocus(dbeCodDil);
    Result := False;
  end

  else if (fPreencherQntDiluente21(tela)) and (strToFloatDef(tela['dbeQtdDil']['Text'].Value, 0) <= 0) then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'A Quantidade (2:1) deve ser maior que Zero!', ['&Ok']);
//    pSetFocus(dbeQtdDil);
    Result := False;
  end

  else if (fPreencherQntDiluente41(tela))
    and (strToFloatDef(tela['dbeQtdDi4']['Text'].Value, 0) <= 0) And (tela['dbeQtdDi4']['Enabled'].value = true) then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'A Quantidade (4:1) deve ser maior que Zero!', ['&Ok']);
//    pSetFocus(dbeQtdDi4);
    Result := False;
  end

  else if (Not fPreencherQntDiluente21(tela)) and (strToFloatDef(tela['dbeQtdDil']['Text'].Value, 0) > 0) then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'A Quantidade diluída deve ser preenchida ao informar a "Quantidade (2:1)"!', ['&Ok']);
    Result := False;
  end

  else if (Not fPreencherQntDiluente41(tela)) and (strToFloatDef(tela['dbeQtdDi4']['Text'].Value, 0) > 0) then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'A Quantidade diluída deve ser preenchida ao informar a "Quantidade (4:1)" !', ['&Ok']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasColorPro.fPreencherQntDiluente21(
  const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdD' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) <> 0) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TCadastroNovasFormulasColorPro.fPreencherQntDiluente41(
  const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
begin
  Result := false;

  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQt41' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) <> 0) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TCadastroNovasFormulasColorPro.fRetCodLinha(strNomLin: String): String;
begin
  strNomLin := Trim(AnsiLowerCase(strNomLin));

  Result := '';
  If strNomLin = AnsiLowerCase('Autobase Plus 100:50') Then
    Result := '1'

  Else If strNomLin = AnsiLowerCase('Wandabase HS') Then
    Result := '4'

  Else If strNomLin = AnsiLowerCase('Wandalac') Then
    Result := '6'

  Else If strNomLin = AnsiLowerCase('Wanda PU HS') Then
    Result := '8'

  Else If strNomLin = AnsiLowerCase('Wandacar') Then
    Result := '9'

  Else If strNomLin = AnsiLowerCase('Single Stage Converter') Then
    Result := '11'

  Else If strNomLin = AnsiLowerCase('Autocoat BT100') Then
    Result := '13'

  Else If strNomLin = AnsiLowerCase('Autobase Plus 100:80') Then
    Result := '14'

  Else If strNomLin = AnsiLowerCase('Wanda PU MS') Then
    Result := '58'

  Else If strNomLin = AnsiLowerCase('Autocoat BT120') Then
    Result := '16'

  Else If strNomLin = AnsiLowerCase('Autocoat BT90') Then
    Result := '59'

  Else If strNomLin = AnsiLowerCase('Autocoat BT110') Then
    Result := '15'

  Else If strNomLin = AnsiLowerCase('Autocoat BT130') Then
    Result := '17'

  Else If strNomLin = AnsiLowerCase('Autowave MM') Then
    Result := '27'

  Else If strNomLin = AnsiLowerCase('Autowave MM 2.0') Then
    Result := '67'

  Else If strNomLin = AnsiLowerCase('Tech Fleet PU') Then
    Result := '72'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Epoxy') Then
    Result := '74'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Sintetico') Then
    Result := '75'

  Else If strNomLin = AnsiLowerCase('Tech Fleet Laca') Then
    Result := '76'

  Else If strNomLin = AnsiLowerCase('Autobase Plus Baseline 100:80') Then
    Result := '12'

  Else If strNomLin = AnsiLowerCase('Autobase Plus Baseline 100:50') Then
    Result := '19'

end;

function TCadastroNovasFormulasColorPro.FTemPedidoNfm: Boolean;
var
  qryGen: IDataSet;
  arrMensagem: TStringArray;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
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

    qryGen.ParamByName('ITETIN').AsString := fGetMd5KeyPedidos(GetQueryCadastro);
    qryGen.ParamByName('ESPDOC').AsString := 'PD';
    qryGen.ParamByName('JAFATU').AsString := '0';
    qryGen.ParamByName('IDEPRO').AsString := 'WCP';
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      Result := True;
      Exit;
    End;

    Result := Not qryGen.IsEmpty;

    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Esta alteração impedirá que ele seja faturado e obrigará a substituição da tinta no pedido antes de faturá-lo.');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Segue pedidos em aberto com esta formulação:');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'DT.EMISSAO | PEDIDO              | CLIENTE                                | IDEPRO | DESCRIÇÃO                                                     | QUANTIDADE ');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');

    qryGen.First;

    While Not qryGen.Eof Do
    Begin
      TAutcomTintaFactory.Get.pAddDados(arrMensagem,
                                                   TAutcomTintaFactory.Get.fPadL(DateToStr(qryGen.FieldByName('EMISSAO').AsDate), 10) + ' | ' +
                                                   TAutcomTintaFactory.Get.fPadL(qryGen.FieldByName('PEDIDO').AsString, 19) + ' | ' +
                                                   TAutcomTintaFactory.Get.fPadR(qryGen.FieldByName('CLIENTE').AsString, 38) + ' |' +
                                                   TAutcomTintaFactory.Get.fPadC(qryGen.FieldByName('IDEPRO').AsString, 6) + '  | ' +
                                                   TAutcomTintaFactory.Get.fPadR(qryGen.FieldByName('DESCRICAO').AsString, 61) + ' | ' +
                                                   TAutcomTintaFactory.Get.fPadL(FormatFloat('0.0000', qryGen.FieldByName('QUANTIDADE').AsFloat), 10));
      qryGen.Next;
    End;

    TAutcomTintaFactory.Get.pAddDados(arrMensagem, '----------------------------------------------------------------------------------------------------------------------------------------------------------------');

    If (Result) Then
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
end;

function TCadastroNovasFormulasColorPro.fValidaCampos(const tela: ITelaCadLibTintas;
 strNomeCampo, strValorCampo: string; var strRetorno: string): Boolean;
begin
  Result := True;
  pCalcularTotalVolume(tela);

  If strNomeCampo = 'NFM_DESCRI' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    End
  End

  Else If strNomeCampo = 'NFM_LINHA_' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A linha deve ser preenchida!';
    End;
  End

  Else If strNomeCampo = 'NFM_NOMLIN' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A linha deve ser preenchida!';
    End
  End

  Else If LeftStr(strNomeCampo, 8) = 'NFM_CODB' Then
  Begin
    If TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) Then
    Begin
      Result := False;
      strRetorno := 'É necessário digitar pelo menos 1 Base!';
    End
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If Not ValidarBase(strValorCampo, tela['dbeLinha']['Text'].Value) Then
      Begin
        Result := False;
        strRetorno := 'Base não encontrada!';
      End
      Else If Not ValidarBaseJaCadastrado(tela, strValorCampo, strNomeCampo) Then
      Begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse Base já está cadastrada para essa nova fórmula!', ['&Ok']);
        strRetorno := '';
      End;
    End
    Else If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      tela.pSetarFocus;
      Result := true;
    End
  End

  Else if Pos('NFM_QTDC', strNomeCampo) > 0 Then
  Begin
    If (strToFloatDef(strValorCampo, 0) < 0) Then
    Begin
      Result     := False;
      strRetorno := 'A quantidade concentrada deve ser maior igual a Zero!';
    End;
  end

  Else if Pos('NFM_QTDD', strNomeCampo) > 0 Then
  Begin
    If (strToFloatDef(strValorCampo, 0) < 0) Then
    Begin
      Result     := False;
      strRetorno := 'A quantidade diluída 2:1 deve ser maior igual a Zero!';
    End;
  end

  Else if Pos('NFM_QD41', strNomeCampo) > 0 Then
  Begin
    If (strToFloatDef(strValorCampo, 0) < 0) Then
    Begin
      Result     := False;
      strRetorno := 'A quantidade diluída 4:1 deve ser maior igual a Zero!';
    End;
  end

  Else if strNomeCampo = 'NFM_CODDIL' Then
  Begin
    If (Not TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      If (Not ValidarBase(strValorCampo, tela['dbeLinha']['Text'].Value)) Then
      Begin
        Result     := False;
        strRetorno := 'Diluente não encontrado!';
      End;
    End;
  End

  Else If strNomeCampo = 'NFM_QTDDIL' Then
  Begin
    If (Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value)) Then
    Begin
      If (strToFloatDef(strValorCampo, 0) <= 0) Then
      Begin
        Result     := False;
        strRetorno := 'A quantidade do diluente 2:1 deve ser maior que Zero!';
      End;

    End;
  End

  Else If pos('NFM_QTDDI4',strNomeCampo) > 0 Then
  Begin
    If (Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value))
      and (tela['dbeQtdDi4']['Enabled'].Value = true)  Then
    Begin
      If (strToFloatDef(strValorCampo, 0) <= 0) Then
      Begin
        Result     := False;
        strRetorno := 'A quantidade do diluente 4:1 deve ser maior que Zero!';
      End;

    End;

    If Result Then
      tela.pSetarFocus;
  End

  Else If strNomeCampo = 'NFM_ACRMOB' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      tela['dbeAcrMob']['Text'].Value := '0,0000';
    End
    Else If (strToFloatDef(tela['dbeAcrMob']['Text'].Value, 0) < 0) Then
    Begin
      Result     := False;
      strRetorno := 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero!';
    End;
  End

end;

function TCadastroNovasFormulasColorPro.fValidarBasePreenchida(const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 To 20 Do
  Begin
    if TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) Then
    Begin
      If (strToFloatDef(tela['dbeQtdC'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value,0) <> 0) Or
         (strToFloatDef(tela['dbeQtdD'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value,0) <> 0) Or
         (strToFloatDef(tela['dbeQt41'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value,0) <> 0) Then
      Begin
        Result := True;
        Break;
      End;
    End;
  End;
end;

function TCadastroNovasFormulasColorPro.fValidarQntConcDiluida(
  const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
begin
  Result  := False;

  For intCont := 1 To 20 Do
  Begin
    If (Not TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value)) And
       (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) = 0) And
       (strToFloatDef(tela['dbeQtdD' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) = 0) And
       (strToFloatDef(tela['dbeQt41' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) = 0) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;


function TCadastroNovasFormulasColorPro.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL +  '  SELECT                                   ';
  qryGen.SQL := qryGen.SQL +  '    * FROM ' + GetNomeTabela + '           ';
  qryGen.SQL := qryGen.SQL +  '  WHERE  ' + GetNomeCampo  + ' = :NFM      ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasColorPro.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasColorPro.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasColorPro.GetDescDbComboBox: String;
begin
  Result := 'AUTOBASE PLUS 100:50,WANDABASE HS,WANDALAC,WANDA PU HS,WANDACAR,SINGLE STAGE CONVERTER,AUTOCOAT BT100,AUTOBASE PLUS 100:80,AUTOCOAT BT120,';
  Result := Result + 'WANDA PU MS,AUTOCOAT BT90,AUTOCOAT BT110,AUTOCOAT BT130,AUTOWAVE MM,AUTOWAVE MM 2.0,TECH FLEET PU,';
  Result := Result + 'TECH FLEET EPOXY,TECH FLEET SINTETICO,TECH FLEET LACA,';
  Result := Result + 'AUTOBASE PLUS BASELINE 100:50, AUTOBASE PLUS BASELINE 100:80';
end;

function TCadastroNovasFormulasColorPro.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasColorPro.GetNomeCampoItem: string;
begin
  Result := 'NFM_CODB';
end;

function TCadastroNovasFormulasColorPro.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasColorPro.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasColorPro.GetNomeTabela: string;
begin
  Result := 'WANPRO_CADNFM';
end;

function TCadastroNovasFormulasColorPro.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasColorPro.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroNovasFormulasColorPro.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasColorPro.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('WCP').fGetInteger('NFMPRO');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasColorPro.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmWcp: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoColorProNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmWcp := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('WCP').pSet('NFMPRO',strNfmWcp);
    End;

    tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
  end;
end;

procedure TCadastroNovasFormulasColorPro.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value    := False;
  tela['chkAtivad']['Checked'].Value    := True;
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate := Date;
  tela['dbeDtaCad']['Enabled'].Value    := False;
  tela['DBComboBox']['Enabled'].Value   := True;
  tela['dbeLinha']['Enabled'].Value     := False;

  pDesabilitaDiluidos(GetQueryCadastro.FieldByName('NFM_NOMLIN').AsString, strState, tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);

  tela.SelectFirst;
  tela.SelectNext;
end;

procedure TCadastroNovasFormulasColorPro.pAtivaCadWcp;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE WANPRO_CADWAN ' +
                '   SET WAN_ATIVO_ = :ATIVAD ' +
                ' WHERE WAN_CODAKZ = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasColorPro.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE WANPRO_CADNFM           ' +
                '    SET NFM_ATIVO_ = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasColorPro.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadWcp;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasColorPro.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasColorPro.pBotaoAtivarNfm(
  const tela: ITelaCadLibTintas);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  If Not GetQueryCadastro.IsEmpty Then
  Begin
    tela['btnAtivarNfm']['Enabled'].Value := VerificarNovaFormulaMovimentada;
    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(tela['btnAtivarNfm']['Enabled'].Value,
                            TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar'),'Ativar');
  End;
end;

procedure TCadastroNovasFormulasColorPro.pCalcularTotalVolume(
  const tela: ITelaCadLibTintas);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil1: String;
  strQtdDil2: String;
begin
  fltTotalConcentrado   := 0;
  fltTotalDiluido1      := 0;
  fltTotalDiluido2      := 0;

  For intCont := 1 To 20 Do
  Begin
    strQtdCon   := tela['dbeQtdC' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;
    strQtdDil1  := tela['dbeQtdD' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;
    strQtdDil2  := tela['dbeQt41' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;

    If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value,
      tela['dbeLinha']['Text'].Value]), []) Then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido1    := fltTotalDiluido1 + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil1) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido2    := fltTotalDiluido2 + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil2) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End;

  If Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value) Then
  Begin
    strQtdDil1 := tela['dbeQtdDil']['Text'].Value;
    strQtdDil2 := tela['dbeQtdDi4']['Text'].Value;

    If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([tela['dbeCodDil']['Text'].Value,
      tela['dbeLinha']['Text'].Value]), []) Then
    Begin
      fltTotalDiluido1 := fltTotalDiluido1 +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil1) /
          TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));

      fltTotalDiluido2 := fltTotalDiluido2 +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil2) /
          TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End;

  If tela['dbeLinha']['Text'].Value <> '72' Then
    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (2:1), %.2f ml (4:1)', [fltTotalConcentrado, fltTotalDiluido1, fltTotalDiluido2])
  Else
    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (9:2)', [fltTotalConcentrado, fltTotalDiluido1]);
end;

procedure TCadastroNovasFormulasColorPro.pDesabilitaDiluidos(strNomLin, strState: String; const tela: ITelaCadLibTintas);
var
  intContador : Integer;
begin
  If MatchStr(strState, ['dsEdit','dsInsert']) Then
  Begin
    strNomLin := Trim(AnsiLowerCase(strNomLin));

    If (Not blnEdit) Then
    Begin
      For intContador := 1 To 20 Do
        tela['dbeForm' + TStrUtils.fStrZero(intContador, 2)]['text'].Value := '';
    End;


    If (Not blnEdit) Then
    Begin
      For intContador := 1 To 20 Do
      Begin
        GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 0.000;
        GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 0.000;
        GetQueryCadastro.FieldByName('NFM_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat := 0.000;
        GetQueryCadastro.FieldByName('NFM_QTDDIL').AsFloat := 0.000;
        GetQueryCadastro.FieldByName('NFM_QTDDI4').AsFloat := 0.000;

      End;
    End;

    If MatchStr(fRetCodLinha(strNomLin), ['8','13']) Then
    {Concentrado   Diluído 2/1    Diluído 4/1}
    Begin
      For intContador := 1 To 20 Do
      Begin
        tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := true;
        tela['dbeQtdD' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := true;
        tela['dbeQt41' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := true;
        tela['dbeCodDil']['Enabled'].Value                                    := true;
        tela['dbeQtdDil']['Enabled'].Value                                    := true;
        tela['dbeQtdDi4']['Enabled'].Value                                    := true;
        Tela['lblQtdDil' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := 'Qtd. Dil.(2:1):';
        Tela['lblQtdDil']['Caption'].Value := 'Quantid. (2:1):';
      End;
    End

    Else If MatchStr(fRetCodLinha(strNomLin), ['1','4', '12', '14', '16', '19', '72']) Then
    {Concentrado   Diluído 2/1     Não tem  }
    Begin
      For intContador := 1 To 20 Do
      Begin
        tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := true;
        tela['dbeQtdD' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := true;
        tela['dbeQt41' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := false;
        tela['dbeCodDil']['Enabled'].Value                                    := true;
        tela['dbeQtdDil']['Enabled'].Value                                    := true;
        tela['dbeQtdDi4']['Enabled'].Value                                    := false;

        If Not (GetQueryCadastro.FieldByName('NFM_LINHA_').AsString = '72') Then
        Begin
          Tela['lblQtdDil' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := 'Qtd. Dil.(2:1):';
          Tela['lblQtdDil']['Caption'].Value := 'Quantid. (2:1):';
        End;
      End;
    End

    Else If MatchStr(fRetCodLinha(strNomLin), ['58','59']) Then
    { Concentrado     Não tem      Diluído 4/1}
    Begin
      For intContador := 1 To 20 Do
      Begin
        tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := true;
        tela['dbeQtdD' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := False;
        tela['dbeQt41' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := true;
        tela['dbeCodDil']['Enabled'].Value                                    := true;
        tela['dbeQtdDil']['Enabled'].Value                                    := False;
        tela['dbeQtdDi4']['Enabled'].Value                                    := true;
        Tela['lblQtdDil' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := 'Qtd. Dil.(2:1):';
        Tela['lblQtdDil']['Caption'].Value := 'Quantid. (2:1):';
      End;
    End

    Else If MatchStr(fRetCodLinha(strNomLin), ['6','9','11','15','17', '27', '67', '74', '75', '76']) Then
    { Concentrado     Não tem       Não tem  }
    Begin
      For intContador := 1 To 20 Do
      Begin
        tela['dbeQtdC' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := true;
        tela['dbeQtdD' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := false;
        tela['dbeQt41' + TStrUtils.fStrZero(intContador, 2)]['Enabled'].Value := false;
        tela['dbeCodDil']['Enabled'].Value                                    := false;
        tela['dbeQtdDil']['Enabled'].Value                                    := false;
        tela['dbeQtdDi4']['Enabled'].Value                                    := false;
        Tela['lblQtdDil' + TStrUtils.fStrZero(intContador, 2)]['Caption'].Value := 'Qtd. Dil.(2:1):';
        Tela['lblQtdDil']['Caption'].Value := 'Quantid. (2:1):';
      End;
    End;



    If blnEdit Then
      blnEdit := False;
  End;
end;

procedure TCadastroNovasFormulasColorPro.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(tela);
end;

function TCadastroNovasFormulasColorPro.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

procedure TCadastroNovasFormulasColorPro.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (strState = 'dsEdit') Or (strState = 'dsInsert') Then
    Tela['btnCarregarBases']['Visible'].Value := True
  Else
    Tela['btnCarregarBases']['Visible'].Value := False;
end;

function TCadastroNovasFormulasColorPro.ValidarBase(
  const strCodBas: string; const strLinha_: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   WANPRO_CADBAS            ' +
    ' WHERE BAS_CODBAS = :CODBAS ' +
    '   AND BAS_LINHA_ = :LINHA_ ',
    'QTD', [strCodBas, strLinha_]
  ) > 0;
end;

function TCadastroNovasFormulasColorPro.ValidarBaseJaCadastrado(
  const tela: ITelaCadLibTintas; const strCodBas, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 20 Do
  Begin
    If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont,2)) And
       (Not TStrUtils.fEmptyStr( tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value )) Then
    Begin
      If tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value = strCodBas Then
        Result := False;
    End;
  End;
end;

function TCadastroNovasFormulasColorPro.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s '+
                                                 ' INNER JOIN WANPRO_CADWAN ON %1:s_ITETIN = WAN_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "WCP" '+
                                                 '   AND WAN_CODAKZ = :CODNFM',
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

{ TBtnAjustarVolumeOnClick }

procedure TBtnAjustarVolumeOnClick.AjustarVolume(const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  pCalcularTotalVolume(cadastro);

  For intCont := 1 To 20 Do
  Begin
    If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString,
      Cadastro.GetQueryCadastro.FieldByName('NFM_LINHA_').AsString]), []) Then
    Begin
      If fltTotalConcentrado > 0 Then
        Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
          Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat * 900 / fltTotalConcentrado;

      If fltTotalDiluido1 > 0 Then
        Cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
          Cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
            fRetornaVolumeLinha2a1(Cadastro.GetQueryCadastro.FieldByName('NFM_NOMLIN').AsString) / fltTotalDiluido1;

      If fltTotalDiluido2 > 0 Then
        Cadastro.GetQueryCadastro.FieldByName('NFM_QD41' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
          Cadastro.GetQueryCadastro.FieldByName('NFM_QD41' + TStrUtils.fStrZero(intCont, 2)).AsFloat *
            fRetornaVolumeLinha4a1(Cadastro.GetQueryCadastro.FieldByName('NFM_NOMLIN').AsString) / fltTotalDiluido2;

    End;
  End;

  If fltTotalDiluido1 > 0 Then
    Cadastro.GetQueryCadastro.FieldByName('NFM_QTDDIL').AsFloat :=
      Cadastro.GetQueryCadastro.FieldByName('NFM_QTDDIL').AsFloat * fRetornaVolumeLinha2a1(Cadastro.GetQueryCadastro.FieldByName('NFM_NOMLIN').AsString) / fltTotalDiluido1;

  If fltTotalDiluido2 > 0 Then
    Cadastro.GetQueryCadastro.FieldByName('NFM_QTDDI4').AsFloat :=
      Cadastro.GetQueryCadastro.FieldByName('NFM_QTDDI4').AsFloat * fRetornaVolumeLinha4a1(Cadastro.GetQueryCadastro.FieldByName('NFM_NOMLIN').AsString) / fltTotalDiluido2;

  pCalcularTotalVolume(cadastro);
end;

procedure TBtnAjustarVolumeOnClick.ConstruirQryBasesValume;
var
  strSql: string;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT            ';
  strSQL := strSQL + '    BAS_CODBAS,               ';
  strSQL := strSQL + '    BAS_PESESP,               ';
  strSQL := strSQL + '    BAS_LINHA_                ';
  strSQL := strSQL + '  FROM              ';
  strSQL := strSQL + '    WANPRO_CADBAS             ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.Close;
  qryBases.SQL := strSQL;
  qryBases.Open;
end;

function TBtnAjustarVolumeOnClick.fRetornaVolumeLinha2a1(strLinha: String): Double;
begin
  Result := 900;

  If strLinha = 'WANDA PU MS' Then
    Result := 750
  Else If strLinha = 'AUTOCOAT BT90' Then
    Result := 750
  Else If strLinha = 'AUTOCOAT BT100' Then
    Result := 618
  Else If strLinha = 'WANDA PU HS' Then
    Result := 640
  Else If strLinha = 'TECH FLEET PU' Then
    Result := 750;
end;

function TBtnAjustarVolumeOnClick.fRetornaVolumeLinha4a1(
  strLinha: String): Double;
begin
  Result := 900;

  If strLinha = 'WANDA PU MS' Then
    Result := 750
  Else If strLinha = 'AUTOCOAT BT90' Then
    Result := 750
  Else If strLinha = 'AUTOCOAT BT100' Then
    Result := 750
  Else If strLinha = 'WANDA PU HS' Then
    Result := 750;
end;

procedure TBtnAjustarVolumeOnClick.OnClick(Sender: TObject);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil1: String;
  strQtdDil2: String;
begin
  fltTotalConcentrado   := 0;
  fltTotalDiluido1      := 0;
  fltTotalDiluido2      := 0;

  ConstruirQryBasesValume;
  AjustarVolume(Tela);

  For intCont := 1 To 20 Do
  Begin
    strQtdCon   := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsString;
    strQtdDil1  := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsString;
    strQtdDil2  := Cadastro.GetQueryCadastro.FieldByName('NFM_QD41' + TStrUtils.fStrZero(intCont, 2)).AsString;

    If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString,
      Cadastro.GetQueryCadastro.FieldByName('NFM_LINHA_').AsString]), []) Then
    begin
      fltTotalConcentrado  := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon)  / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido1     := fltTotalDiluido1    + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil1) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido2     := fltTotalDiluido2    + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil2) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  End;

  If Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value) Then
  Begin
    strQtdDil1 := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDDIL').AsString;
    strQtdDil2 := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDDI4').AsString;

    If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([tela['dbeCodDil']['Text'].Value,
      Cadastro.GetQueryCadastro.FieldByName('NFM_LINHA_').AsString]), []) Then
    Begin
      fltTotalDiluido1 := fltTotalDiluido1 +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil1) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));

      fltTotalDiluido2 := fltTotalDiluido2 +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil2) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End;
end;

procedure TBtnAjustarVolumeOnClick.pCalcularTotalVolume(
  const cadastro: TAbstractCadastro);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil1: String;
  strQtdDil2: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido1    := 0;
  fltTotalDiluido2    := 0;

  For intCont := 1 To 20 Do
  Begin
    strQtdCon := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsString;
    strQtdDil1 := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intCont, 2)).AsString;
    strQtdDil2 := Cadastro.GetQueryCadastro.FieldByName('NFM_QD41' + TStrUtils.fStrZero(intCont, 2)).AsString;

    If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString,
      Cadastro.GetQueryCadastro.FieldByName('NFM_LINHA_').AsString]), []) Then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido1    := fltTotalDiluido1 + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil1) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido2    := fltTotalDiluido2 + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil2) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End;

  If Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value) Then
  Begin
    strQtdDil1 := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDDIL').AsString;
    strQtdDil2 := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDDI4').AsString;

    If qryBases.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([tela['dbeCodDil']['Text'].Value,
      Cadastro.GetQueryCadastro.FieldByName('NFM_LINHA_').AsString]), []) Then
    Begin
      fltTotalDiluido1 := fltTotalDiluido1 +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil1) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido2 := fltTotalDiluido2 +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil2) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End;

  If Cadastro.GetQueryCadastro.FieldByName('NFM_LINHA_').AsString <> '72' Then
    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (2:1), %.2f ml (4:1)', [fltTotalConcentrado, fltTotalDiluido1, fltTotalDiluido2])
  Else
    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (9:2)', [fltTotalConcentrado, fltTotalDiluido1]);
end;

end.
