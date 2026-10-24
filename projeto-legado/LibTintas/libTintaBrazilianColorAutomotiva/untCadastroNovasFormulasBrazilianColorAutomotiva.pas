unit untCadastroNovasFormulasBrazilianColorAutomotiva;

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
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untIDataSet;

type
  TCadastroNovasFormulasBrazilianColorAutomotiva = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    intPrxNfm: Integer;
    qryBases    : IDataSet;

    procedure pCalcularTotalVolume(const tela: ITelaCadLibTintas);
    procedure ConstruirQryBasesValume;

    function ValidarBase(const strCodBas: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas; const strCodBas: string; const strNomCam: string): Boolean;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    function fRetornarlLinhasBrazilianColor : String;

    function fGetDescricaoMontadora(const strCodMontadora : String ) : String;

    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(const qryCadastro: IDataSet): String;
    function FTemPedidoNfm(): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadBzc;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);
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
//    function GetCampoEmbalagem: string; override;
//    function GetCampoPesoEspecifico: string; override;
    function GetPreencherDbComboBox: Boolean; override;
    function GetDescDbComboBox: String; override;
  end;

  TBtnAjustarVolumeOnClick = class(TAbstractLibTintaControleVisualEvento)
  private
    qryBases: IDataSet;

    procedure pCalcularTotalVolume(const cadastro: TAbstractCadastro);
    procedure AjustarVolume(const tela: ITelaCadLibTintas);
    procedure ConstruirQryBasesValume;
  published
    procedure OnClick(Sender: TObject);
  end;

var
  fltTotalConcentrado: Double;
  fltTotalDiluido: Double;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasBrazilianColorAutomotiva, untDbeCodBasKeyPressBrazilianColorAutomotiva,
  untGravandoExecucaoBrazilianColorAutomotivaNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untGravandoExecucaoBrazilianColorAutomotivaCores,
  untDbeCodMontadoraKeyPressBrazilianColorAutomotiva,
  untBtnCarregaFormulasCadastradaOnClickBrazilianColorAutomotiva, untTypesSistema;
{ TCadastroNovasFormulasBrazilianColorAutomotiva }

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 557;
  tela.GetSelf['Width'].Value  := 800;
  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Left'].Value      := 115;
  tela['DBComboBox']['Top'].Value       := 74;
  tela['DBComboBox']['Width'].Value     := 200;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'NFM_LINHA_';
  tela['DBComboBox']['TabOrder'].Value  := 3;

  pBotaoAtivarNfm(tela);
  ConstruirQryBasesValume;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela.SelectFirst;
  pCalcularTotalVolume(Tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) then
  Begin
    TAutcomTintaFactory.Get.fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;

    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar');
  End;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(Tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDesMontadora']['Text'].Value := fGetDescricaoMontadora(tela['dbeMontadora']['Text'].Value);
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 35, 33, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCad', 'Data Cadastro:', 240, 33, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', -37, 57, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', -37, 83, 150, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblTipo', 'Tipo:', 280, 83, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAno', 'Ano:', 60, 105, 50, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMontadora', 'Montadora:', 60, 125, 50, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob', 'Acrésc. Mão de Obra:', 60, 150, 50, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 115, 26, 100, 22, 'ttAlfanumerico', 'NFM_CODNFM')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDtaCad', 320, 26, 100, 22, 'ttAlfanumerico', 'NFM_DTACAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 115, 50, 420, 22, 'ttAlfanumerico', 'NFM_DESCRI')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '2'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeTipo', 385, 74, 150, 22, 'ttAlfanumerico', 'NFM_TIPO__')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAno', 115, 98, 100, 22, 'ttAlfanumerico', 'NFM_A_N_O_')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5'))
  );


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMontadora', 115, 122, 49, 22, 'ttAlfanumerico', 'NFM_CODMON')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '7'))
    .AdicionarEvento(TDbeCodMontadoraKeyPress.Create('OnKeyPress', self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesMontadora', 165, 122, 370, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 115, 146, 100, 22, 'ttAlfanumerico', 'NFM_ACRMOB')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '8'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 495, 146, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9'))
  );

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnCarregarBases: TSpeedButton                        ' +
    '   Left = 15                                                  ' +
    '   Top = 168                                                  ' +
    '   Width = 600                                                ' +
    '   Height = 23                                                ' +
    '   Hint = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''         ' +
    '   Caption = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''      ' +
    '   ParentShowHInt = False                                      ' +
    '   ShowHint = True                                             ' +
    '   Visible = True                                              ' +
    ' End                                                           ')
    .AdicionarEvento(TBtnCarregaBasesCadastrada.Create(Self)));


  groupBases := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbBases', 1, 190, 790, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'AlNone'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Bases      '));

  for intCont := 1 to 10 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 8, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Conc.:', 170, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Dil.:', 270, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 68,
      22 * intCont, 95, 22, 'ttAlfanumerico', 'NFM_BASE' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressBrazilianColorAutomotiva.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdB' + TStrUtils.fStrZero(intCont , 2), 228,
      22 * intCont, 45, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdD' + TStrUtils.fStrZero(intCont , 2), 328,
      22 * intCont, 45, 22, 'ttAlfanumerico', 'NFM_QTDD' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 400, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Conc.:', 562, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Dil.:', 655, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 460,
      22 * (intCont - 10), 95, 22, 'ttAlfanumerico', 'NFM_BASE' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressBrazilianColorAutomotiva.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdB' + TStrUtils.fStrZero(intCont , 2), 620,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdD' + TStrUtils.fStrZero(intCont , 2), 720,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_QTDD' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  groupBases.AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object Label5: TLabel                                  ' +
    '   Left = 80                                            ' +
    '   Top = 0                                              ' +
    '   Width = 406                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taRightJustify                           ' +
    '   AutoSize = False                                     ' +
    '   Caption = ''Informar a quantidade em Gramas, para o cadastro da fórmula em Litro'' ' +
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


  AdicionarControle(groupBases);

  AdicionarControle(
    TLibTintaControleVisualImplementacao.Create(
      ' object btnAjustarVolume: TBitBtn                                        ' +
      '   Left    = 325                                                         ' +
      '   Top     = 460                                                         ' +
      '   Width   = 119                                                         ' +
      '   Height  = 20                                                          ' +
      '   Hint    = ''Clique aqui para ajustar o Volume para 900 ml''           ' +
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

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
      ' object lblVolumeTotal: TLabel                               ' +
      '   Left         = 100                                        ' +
      '   Top          = 440                                        ' +
      '   Width        = 370                                        ' +
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
      '   Left         = 20                                        ' +
      '   Top          = 462                                        ' +
      '   Width        = 300                                        ' +
      '   Height       = 14                                         ' +
//      '   Align        = alRight                                    ' +
      '   Alignment    = taRightJustify                             ' +
      '   AutoSize     = False                                      ' +
      '   Caption      = ''Cadastrar a fórmula no volume de 900ml'' ' +
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
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.ConstruirQryBasesValume;
Var
  strSql: String;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    ' FROM                     ' +
    '   BZC_CADBAS             ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := strSql;
  qryBases.Open;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM BZC_CADBZC WHERE BZC_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
  begin
    DeletaNovaFormula(strCodNfmDel);
    tela['edtDesMontadora']['Text'].Value := '';
  End;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fGetDescricaoMontadora(
  const strCodMontadora: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT MON_DESCRI '+
                '  FROM BZC_CADMON  '+
                ' WHERE MON_CODMON = :CODIGO' ;
  qryGen.ParamByName('CODIGO').AsString := strCodMontadora;
  qryGen.Open;

  Result := qryGen.FieldByName('MON_DESCRI').AsString;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fGetMd5KeyPedidos(
  const qryCadastro: IDataSet): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM BZC_CADBZC        ';
  qryGen.SQL := qryGen.SQL + '  WHERE BZC_CODNFM = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('BZC_MD5KEY').AsString;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(LeftStr(strNomeCampo, Length('NFM_QTDC')), ['NFM_QTDC', 'NFM_QTDD']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0';
    arrValores[1] := '0.0';
  end
  else if MatchStr(strNomeCampo, ['NFM_ACRMOB']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  end;;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasBrazilianColorAutomotiva.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fRetornarlLinhasBrazilianColor: String;
Var
  qryGen: IDataSet;
begin
  Result := 'PERSONALIZADA';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DISTINCT BZC_LINHA_ '+
                '  FROM BZC_CADBZC';
  qryGen.Open;

  qryGen.First;

  While not qryGen.Eof Do
  Begin
      Result := Result +','+ qryGen.FieldByName('BZC_LINHA_').AsString;

    qryGen.Next;
  End;

end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.FTemPedidoNfm: Boolean;
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
    qryGen.ParamByName('IDEPRO').AsString := 'BZC';
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

function TCadastroNovasFormulasBrazilianColorAutomotiva.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
begin
  Result := True;
  pCalcularTotalVolume(Tela);

  if LeftStr(strNomeCampo, 8) = 'NFM_BASE' then
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) then
    begin
      Result := False;
      strRetorno := 'É necessário digitar pelo menos 1 Base!';
    end
    else if not TStrUtils.fEmptyStr(strValorCampo) then
    begin
      if not ValidarBase(strValorCampo) then
      begin
        Result := False;
        strRetorno := 'Base não encontrada!';
      end
      else if not ValidarBaseJaCadastrado(tela, strValorCampo, strNomeCampo) then
      begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse Base já está cadastrada para essa nova fórmula!', ['&Ok']);
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
      strCampoQtd := 'dbeQtdB' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;
      if strToFloatDef(strValorCampoQtd, -1) > 0 then
      begin
        Result := False;
        strRetorno := 'A quantidade da Base foi informada. Por favor, informe seu código.';
      end
      Else
      Begin
        strCampoQtd := 'dbeQtdD' + RightStr(strNomeCampo, 2);
        strValorCampoQtd := tela[strCampoQtd]['Text'].Value;
        if strToFloatDef(strValorCampoQtd, -1) > 0 then
        begin
          Result := False;
          strRetorno := 'A quantidade da Base foi informada. Por favor, informe seu código.';
        end
      End;
    end;
  end
  else if strNomeCampo = 'NFM_DESCRI' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    end
  end
  else if strNomeCampo = 'NFM_CODUNI' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A Linha deve ser preenchida!';
    end
  end
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDC' then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_BASE', [rfReplaceAll])).AsString) then
    begin
      strCampoQtd := 'dbeQtdD' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

{      if TStrUtils.fEmptyStr(strValorCampo) And
       (Not((GetQueryCadastro.FieldByName('NFM_VOLCON').AsInteger > 0)And(GetQueryCadastro.FieldByName('NFM_VOLDIL').AsInteger > 0))) then
      begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade da Base!';
      end
 }
      // else
      if (strToFloatDef(strValorCampo, 0) <= 0) then
      begin
        if (strToFloatDef(strValorCampo, 0) < 0) then
        begin
          Result := False;
          strRetorno := 'A quantidade da Base deve ser maior ou igual a Zero!';
        end
        {else if (strToFloatDef(strValorCampo, 0) = 0)And
         (Not((strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) > 0)And(strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) > 0)))then
        begin
          if strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) > 0 Then
          Begin
            Result := False;
            strRetorno := 'A quantidade da Base deve ser maior que Zero já que o volume concentrado está preenchido!';
          End;
        end;
        }
      end
      {else If (strToFloatDef(strValorCampo, 0) > 0) And (strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) <= 0) then
      begin
        Result := False;
        strRetorno := 'A quantidade concentrado não pode ser preenchida ja que o volume concentrado é 0 !';
      End;}
    end;
  end
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDD' then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDD', 'NFM_BASE', [rfReplaceAll])).AsString) then
    begin
      strCampoQtd := 'dbeQtdB' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      {if TStrUtils.fEmptyStr(strValorCampo) And
       (Not((GetQueryCadastro.FieldByName('NFM_VOLCON').AsInteger > 0)And(GetQueryCadastro.FieldByName('NFM_VOLDIL').AsInteger > 0)))then
      begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade da Base!';
      end}

      //else
      if (strToFloatDef(strValorCampo, 0) <= 0) and
              (strToFloatDef(strValorCampoQtd, -1) <= 0) then
      begin
        Result := False;
        strRetorno := 'A quantidade da Base deve ser maior que Zero!';
      end
      else if (strToFloatDef(strValorCampo, 0) <= 0) then
      begin
        if (strToFloatDef(strValorCampo, 0) < 0) then
        begin
          Result := False;
          strRetorno := 'A quantidade da Base deve ser maior ou igual a Zero!';
        end
        {else if (strToFloatDef(strValorCampo, 0) = 0) And
         (Not((strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) > 0)And(strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) > 0)))then
        begin
          If strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) > 0 Then
          Begin
            Result := False;
            strRetorno := 'A quantidade da Base deve ser maior que Zero já que o volume diluido está preenchido!';
          End;
        end;}
      end
      {else If (strToFloatDef(strValorCampo, 0) > 0) And (strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) <= 0) then
      begin
        Result := False;
        strRetorno := 'A quantidade diluido não pode ser preenchida ja que o volume diluido é 0 !';
      End;
      }
    end;
  end
{  else if strNomeCampo = 'NFM_VOLCON' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbeVolCon']['Text'].Value := 0;
    end
    Else If (strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) < 0) Then
    Begin
      Result := False;
      strRetorno := 'O Volume concentrado deve ser maior ou igual a zero!';
    End;
  end

  else if strNomeCampo = 'NFM_VOLDIL' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbeVolDil']['Text'].Value := 0;
    end
    Else if (Not TStrUtils.fEmptyStr(tela['dbeVolCon']['Text'].Value)) then
    begin
      If (strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) < 0) Then
      Begin
        Result := False;
        strRetorno := 'O Volume Diluido deve ser maior ou igual a zero!';
      End
      Else If (strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) <= 0) And (strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) <= 0) Then
      Begin
        If (strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) < 0) Then
        Begin
          Result := False;
          strRetorno := 'O Volume Concentrado deve ser maior ou igual a zero!';
        End
        Else
        Begin
          Result := False;
          strRetorno := 'Os Volumes: Concentrado e ou Diluído devem ser preenchidos !';
        End;
      End;
    end;
  end
  }
  else if strNomeCampo = 'NFM_ACRMOB' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbeAcrMob']['Text'].Value := 0;
    end
    Else If (strToFloatDef(tela['dbeAcrMob']['Text'].Value, 0) < 0) Then
    Begin
      Result := False;
      strRetorno := 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero!';
    End;
  end
  else if (not fValidarPreenchimentoCol(tela)) then
  begin
    Result     := False;
    strRetorno :='Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  end;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fValidarPreenchimentoCol(
  const tela: ITelaCadLibTintas): Boolean;
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
    else if not TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and (blnCampoVazio) then
    begin
      Result := false;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT            ';
  qryGen.SQL := qryGen.SQL + '    * FROM  ' + GetNomeTabela + '         ';
  qryGen.SQL := qryGen.SQL + '  WHERE ' + GetNomeCampo  + ' = :NFM      ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

{function TCadastroNovasFormulasBrazilianColorAutomotiva.GetCampoEmbalagem: string;
begin
  Result := '';
end;}

{function TCadastroNovasFormulasBrazilianColorAutomotiva.GetCampoPesoEspecifico: string;
begin
  Result := '';
end;}

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasBrazilianColorAutomotiva.Create;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetDescDbComboBox: String;
begin
  Result := fRetornarlLinhasBrazilianColor;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetNomeCampoItem: string;
begin
  Result := 'NFM_BASE';
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetNomeTabela: string;
begin
  Result := 'BZC_CADNFM';
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('BZC').fGetInteger('PROCOD');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmBzc: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoBrazilianColorAutomotivaNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmBzc := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('BZC').pSet('PROCOD',strNfmBzc);
    End;

    tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
  end;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value := False;
  tela['chkAtivad']['Checked'].Value := True;
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate  := Date;
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.pAtivaCadBzc;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE BZC_CADBZC ' +
                '   SET BZC_ATIVAD = :ATIVAD ' +
                ' WHERE BZC_CODNFM = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE BZC_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadBzc;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.pBotaoAtivarNfm(
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

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.pCalcularTotalVolume(
  const tela: ITelaCadLibTintas);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;
  For intCont := 1 To 20 Do
  Begin
    strQtdCon := tela['dbeQtdB' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;
    strQtdDil := tela['dbeQtdD' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;

    If qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) Then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido     := fltTotalDiluido     + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End;

  Tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(Tela);
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

procedure TCadastroNovasFormulasBrazilianColorAutomotiva.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (strState = 'dsEdit') Or (strState = 'dsInsert') Then
    Tela['btnCarregarBases']['Visible'].Value := True
  Else
    Tela['btnCarregarBases']['Visible'].Value := False;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.ValidarBase(
  const strCodBas: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   BZC_CADBAS               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
    ' WHERE BAS_CODBAS = :CODBAS ',
    'QTD', [strCodBas]
  ) > 0;
end;

function TCadastroNovasFormulasBrazilianColorAutomotiva.ValidarBaseJaCadastrado(
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

function TCadastroNovasFormulasBrazilianColorAutomotiva.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s '+
                                                 ' INNER JOIN BZC_CADBZC ON %1:s_ITETIN = BZC_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "BZC" '+
                                                 '   AND BZC_CODNFM = :CODIGO',
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
    If qryBases.Locate('BAS_CODBAS', cadastro.GetQueryCadastro.FieldByName('NFM_BASE' + TStrUtils.fstrZero(intCont,2)).AsString, []) Then
    Begin
      If fltTotalConcentrado > 0 Then
        cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsFloat := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsFloat * 900 / fltTotalConcentrado;

      If fltTotalDiluido > 0 Then
        cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsFloat := cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsFloat * 900 / fltTotalDiluido;
    End;
  End;

  pCalcularTotalVolume(cadastro);
end;

procedure TBtnAjustarVolumeOnClick.ConstruirQryBasesValume;
var
  strSql: string;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    ' FROM                     ' +
    '   BZC_CADBAS             ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := strSql;
  qryBases.Open;
end;

procedure TBtnAjustarVolumeOnClick.OnClick(Sender: TObject);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  ConstruirQryBasesValume;

  AjustarVolume(tela);

  For intCont := 1 to 20 do
  Begin
    strQtdCon := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsString;
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsString;

    If qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido     := fltTotalDiluido     + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End;
end;

procedure TBtnAjustarVolumeOnClick.pCalcularTotalVolume(
  const cadastro: TAbstractCadastro);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  for intCont := 1 to 20 do
  begin
    strQtdCon := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsString;
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsString;

    if qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) then
    begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido     := fltTotalDiluido     + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  end;

  tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
end;

end.
