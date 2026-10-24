unit untCadastroNovasFormulasTopCoat;

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
  untTipoCadastro, untTipoTinta, untIDataSet,
  untDbeCodMontadoraKeyPressTopCoat;

type
  TCadastroNovasFormulasTopCoat = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    intPrxNfm: Integer;
    qryBases    : IDataSet;


    procedure pCalcularTotalVolume(const tela: ITelaCadLibTintas);
    procedure ConstruirQryBasesValume;

    function fGetLinha(strLinha: String): Boolean;
    function fGetMontadora(strMontadora: String): Boolean;
    function fGetCliente(strValorCampo: String): String;

    function ValidarBase(const strCodBas: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas; const strCodBas: string; const strNomCam: string): Boolean;
    procedure pValorCampoAtivarDesativar(const Tela: ITelaCadLibTintas);
    function fVerificaDesAtiFormula(strCodCol: String; strState: String): Boolean;
    function fVerificaBaseJaCadastrada(const tela: ITelaCadLibTintas; strNomCam: String; intCont: Integer): Boolean;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    procedure pAtivaNfm;
    procedure pAtivaCadCOA;
    procedure pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
    procedure pAtualizaNfm;
    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);
    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(const qryCadastro: IDataSet): String;
    function FTemPedidoNfm(): Boolean;
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
    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState : String); override;

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
  fltTotalConcentrado : Double;
  fltTotalDiluido: Double;

implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasTopCoat, untDbeCodBasKeyPressTopCoat,
  untGravandoExecucaoTopCoatNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica, untTypesSistema,
  untDbeLinhaKeyPressTopCoat, untVariantUtils, untFloatUtils,
  untBtnCarregaFormulasCadastradaOnClickTopCoat,
  untDbeClienteKeyPressTopCoat;
{ TCadastroNovasFormulasTopCoat }

procedure TCadastroNovasFormulasTopCoat.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 550;
  tela.GetSelf['Width'].Value  := 780;
  tela['btnAtivarNfm']['Visible'].Value := True;
  pBotaoAtivarNfm(tela);
  ConstruirQryBasesValume;
end;

procedure TCadastroNovasFormulasTopCoat.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasTopCoat.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDataCadastro']['Enabled'].Value    := False;
  tela['dbeCodNfm']['Enabled'].Value := False;
  tela['dbeClient']['Enabled'].Value    := False;
  pCalcularTotalVolume(Tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
end;

procedure TCadastroNovasFormulasTopCoat.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString) then
  Begin
    TAutcomTintaFactory.Get.fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fVerificaDesAtiFormula(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString, strState) Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm(tela);
      pAtualizaNfm;
    End;

    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar');
  End;
end;

procedure TCadastroNovasFormulasTopCoat.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(Tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
end;

procedure TCadastroNovasFormulasTopCoat.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
end;

procedure TCadastroNovasFormulasTopCoat.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm',   'Código:',              35,  23,  73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:',       220,  23,  65, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao',    'Descrição:',           -37,  47, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAno',          'Ano:',                 -37,  69, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMontadora',    'Montadora:',           180,  69, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblReferencia',   'Referência:',          -37, 91, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCliente',      'Código/Nome Cliente:', 260, 91,  73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha',        'Linha:',               561, 91,  73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob',       'Acrésc. Mão de Obra:', 60, 113,  50, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 115, 20, 80, 22, 'ttAlfanumerico', 'NFM_CODIGO')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 290, 20, 120, 22, 'ttAlfanumerico', 'NFM_DTACAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 115, 42, 505, 22, 'ttAlfanumerico', 'NFM_DESCRI')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '3')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAno', 115, 64, 100, 22, 'ttAlfanumerico', 'NFM_ANOCOR')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMontadora', 330, 64, 290, 22, 'ttAlfanumerico', 'NFM_MONTAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5'))
  .AdicionarEvento(TDbeCodMontadoraKeyPress.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeReferencia', 115, 86, 100, 22, 'ttAlfanumerico', 'NFM_REFERE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '6')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodCli', 340, 86, 60, 22, 'ttAlfanumerico','NFM_CODCLI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '7'))
    .AdicionarEvento(TDbeClienteKeyPressTopCoat.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeClient', 401, 86, 175, 22, 'ttAlfanumerico','NFM_CLIENT')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '8'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', 'False')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeLinha', 640, 86, 130, 22, 'ttAlfanumerico','NFM_LINHA_')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9'))
    .AdicionarEvento(TDbeCodLinKeyPress.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 115, 108, 100, 22, 'ttAlfanumerico', 'NFM_ACRMOB')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '10')));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 310, 108, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '11')));

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnCarregarBases: TSpeedButton                        ' +
    '   Left = 35                                                  ' +
    '   Top = 133                                                  ' +
    '   Width = 600                                                ' +
    '   Height = 23                                                ' +
    '   Hint = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''         ' +
    '   Caption = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''      ' +
    '   ParentShowHInt = False                                      ' +
    '   ShowHint = True                                             ' +
    '   Visible = True                                              ' +
    ' End                                                           ')
    .AdicionarEvento(TBtnCarregaBasesCadastrada.Create(Self)));


  groupBases := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbBases', 1, 180, 780, 249)
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
      .AdicionarEvento(TDbeCodBasKeyPressTopCoat.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
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
      .AdicionarEvento(TDbeCodBasKeyPressTopCoat.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
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
      '   Left    = 310                                                         ' +
      '   Top     = 455                                                         ' +
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
      '   Top          = 435                                        ' +
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
      '   Left         = 0                                          ' +
      '   Top          = 457                                        ' +
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
End;


procedure TCadastroNovasFormulasTopCoat.ConstruirQryBasesValume;
Var
  strSql: String;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    ' FROM                     ' +
    '   COA_CADBAS             ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := strSql;
  qryBases.Open;
end;

procedure TCadastroNovasFormulasTopCoat.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM COA_CADCOA WHERE COA_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasTopCoat.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
end;

procedure TCadastroNovasFormulasTopCoat.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
end;

function TCadastroNovasFormulasTopCoat.fGetCampoChave(const index: Integer): string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasTopCoat.fGetCliente(strValorCampo: String): String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT CLI_NOMCLI FROM CADCLI WHERE CLI_CODCLI = :CODCLI  ';
    qryGen.ParamByName('CODCLI').AsString := strValorCampo;
    qryGen.Open;

    Result := qryGen.FieldByName('CLI_NOMCLI').AsString;
  Except
    Raise;
  End;
end;

function TCadastroNovasFormulasTopCoat.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;


function TCadastroNovasFormulasTopCoat.fGetLinha(strLinha: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT        ';
  qryGen.SQL := qryGen.SQL + '    LIN_DESCRI        ';
  qryGen.SQL := qryGen.SQL + '  FROM          ';
  qryGen.SQL := qryGen.SQL + '    COA_CADLIN        ';
  qryGen.SQL := qryGen.SQL + '  WHERE         ';
  qryGen.SQL := qryGen.SQL + '    LIN_DESCRI = :DESCRI    ';
  qryGen.ParamByName('DESCRI').AsString := strLinha;
  qryGen.Open;

  Result := Not qryGen.IsEmpty;
end;

function TCadastroNovasFormulasTopCoat.fGetMd5KeyPedidos(
  const qryCadastro: IDataSet): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM COA_CADCOA        ';
  qryGen.SQL := qryGen.SQL + '  WHERE COA_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('COA_MD5KEY').AsString;
end;

function TCadastroNovasFormulasTopCoat.fGetMontadora(
  strMontadora: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT        ';
  qryGen.SQL := qryGen.SQL + '    MON_DESCRI        ';
  qryGen.SQL := qryGen.SQL + '  FROM          ';
  qryGen.SQL := qryGen.SQL + '    COA_CADMON        ';
  qryGen.SQL := qryGen.SQL + '  WHERE         ';
  qryGen.SQL := qryGen.SQL + '    MON_DESCRI = :DESCRI    ';
  qryGen.ParamByName('DESCRI').AsString := strMontadora;
  qryGen.Open;

  Result := Not qryGen.IsEmpty;
end;

procedure TCadastroNovasFormulasTopCoat.FormatarCampo(const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(LeftStr(strNomeCampo, Length('NFM_QTDC')), ['NFM_QTDC', 'NFM_QTDD']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.000';
    arrValores[1] := '0.000';
  end
  Else If MatchStr(strNomeCampo, ['NFM_ACRMOB']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End;
end;

function TCadastroNovasFormulasTopCoat.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasTopCoat.fPodeAlterar: Boolean;
begin
  Result := True;
  If VerificarNovaFormulaMovimentada Then
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

function TCadastroNovasFormulasTopCoat.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasTopCoat.FTemPedidoNfm: Boolean;
Var
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
    qryGen.ParamByName('IDEPRO').AsString := 'COA';
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      Result := True;
      Exit;
    End;

    Result := Not qryGen.IsEmpty;

    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Esta alteração impedirá que ele seja faturado e obrigará a substituição da tinta no pedido antes de faturá-lo');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Seguem pedidos em aberto com esta formulação:');
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

function TCadastroNovasFormulasTopCoat.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
    strCampoNum : String;

begin
  Result := True;
  pCalcularTotalVolume(Tela);

  If LeftStr(strNomeCampo, 8) = 'NFM_BASE' Then
  Begin
    If TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) Then
    Begin
      Result := False;
      strRetorno := 'É necessário digitar pelo menos 1 Base!';
    End
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If Not ValidarBase(strValorCampo) Then
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
  Else If strNomeCampo = 'NFM_CODCLI' Then
  Begin
    If Not TStrUtils.fEmptyStr(strValorCampo) Then
      GetQueryCadastro.FieldByName('NFM_CLIENT').AsString := fGetCliente(strValorCampo);
  End
  Else If strNomeCampo = 'NFM_CODMON' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A montadora deve ser preenchida!';
    End
    Else If Not fGetMontadora(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('A montadora %s não está cadastrada!', [strValorCampo]);
    End;
  End
  Else If strNomeCampo = 'NFM_LINHA_' Then

  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A linha deve ser preenchida!';
    End
    Else If Not fGetLinha(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('A linha %s não está cadastrada!', [strValorCampo]);
    End;
  End
  Else If strNomeCampo = 'NFM_DESCRI' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    End
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDC' Then
  Begin
    If Not (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_BASE', [rfReplaceAll])).AsString)) And
     (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_QTDD', [rfReplaceAll])).AsString)) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade concentrada da Base!';
      End
      Else If strToFloatDef(strValorCampo, 0) < 0 Then
      Begin
        Result := False;
        strRetorno := 'A quantidade da base deve ser maior ou igual a Zero!';
      End;
    End
    Else
    Begin
      strCampoQtd := 'dbeQtdB' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      strCampoNum := Copy(strNomeCampo, (Length(strNomeCampo) - 1), Length(strNomeCampo));

      If (strToFloatDef(strValorCampoQtd, -1) > 0) and (TStrUtils.fEmptyStr(tela['dbeForm' + strCampoNum]['Text'].Value)) Then
      Begin
        Result := False;
        strRetorno := 'A quantidade da Base foi informada. Por favor, informe seu código.';
      End;
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDD' Then
  Begin
    If Not (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDD', 'NFM_BASE', [rfReplaceAll])).AsString)) And
      (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDD', 'NFM_QTDC', [rfReplaceAll])).AsString)) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade diluida da Base!';
      End
      Else If strToFloatDef(strValorCampo, 0) <= 0 Then
      Begin
        Result := False;
        strRetorno := 'A quantidade da base deve ser maior que Zero!';
      End;
    End
    Else
    Begin
      strCampoQtd := 'dbeQtdD' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      strCampoNum := Copy(strNomeCampo, (Length(strNomeCampo) - 1), Length(strNomeCampo));

      If (strToFloatDef(strValorCampoQtd, -1) > 0) and (TStrUtils.fEmptyStr(tela['dbeForm' + strCampoNum]['Text'].Value)) Then
      Begin
        Result := False;
        strRetorno := 'A quantidade da Base foi informada. Por favor, informe seu código.';
      End;
    End;
  End
  Else If strNomeCampo = 'NFM_ACRMOB' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      tela['dbeAcrMob']['Text'].Value := 0;
    End
    Else If (strToFloatDef(tela['dbeAcrMob']['Text'].Value, 0) < 0) Then
    Begin
      Result := False;
      strRetorno := 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero!';
    End;
  End
  Else If (Not fValidarPreenchimentoCol(tela)) Then
  Begin
    Result     := False;
    strRetorno :='Não é permitido o preenchimento aleatório das bases, para concluir preencha os campos conforme a sequência numérica!';
  End;
end;

function TCadastroNovasFormulasTopCoat.fValidarPreenchimentoCol(
  const tela: ITelaCadLibTintas): Boolean;
var
  intCont       : Integer;
  blnCampoVazio : Boolean;
begin
  Result        := true;
  blnCampoVazio := false;

  for intCont := 1 to 20 do
  begin
    If TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) Then
    Begin
      If not (blnCampoVazio) Then
        blnCampoVazio := true
    End
    Else If Not TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) Then
    begin
      If blnCampoVazio Then
      Begin
        Result := false;
        Break;
      End;
    end;
  end;
end;

function TCadastroNovasFormulasTopCoat.fVerificaBaseJaCadastrada(
  const tela: ITelaCadLibTintas; strNomCam: String; intCont: Integer): Boolean;
begin
  Result := False;

  If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont,2)) Then
  Begin
    If Not TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value) Then
      Result := True;
  End;
end;

function TCadastroNovasFormulasTopCoat.fVerificaDesAtiFormula(strCodCol,
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

function TCadastroNovasFormulasTopCoat.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataset;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                                    ';
  qryGen.SQL := qryGen.SQL + '    * FROM  ' + GetNomeTabela + '           ';
  qryGen.SQL := qryGen.SQL + '  WHERE ' + GetNomeCampo  + ' = :NFM        ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasTopCoat.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasTopCoat.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasTopCoat.Create;
end;


function TCadastroNovasFormulasTopCoat.GetNomeCampo: string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasTopCoat.GetNomeCampoItem: string;
begin
  Result := 'NFM_BASE';
end;

function TCadastroNovasFormulasTopCoat.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasTopCoat.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasTopCoat.GetNomeTabela: string;
begin
  Result := 'COA_CADNFM';
end;

function TCadastroNovasFormulasTopCoat.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasTopCoat.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroNovasFormulasTopCoat.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasTopCoat.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin

  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('COA').fGetInteger('COANFM');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODIGO').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End
  Else
  Begin
    pValorCampoAtivarDesativar(Tela);
  End;
end;

procedure TCadastroNovasFormulasTopCoat.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmCOA: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoTopCoatNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmCOA := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('COA').pSet('COANFM',strNfmCOA);
    End;

    tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
  end;
end;

procedure TCadastroNovasFormulasTopCoat.IncluirAntes(
  const tela: ITelaCadLibTintas; const strState: String);
begin

end;

procedure TCadastroNovasFormulasTopCoat.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value    := False;
  tela['dbeClient']['Enabled'].Value    := False;
  tela['chkAtivad']['Checked'].Value    := True;
  tela['dbeDataCadastro']['Enabled'].Value    := False;
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);

  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate := date;

  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasTopCoat.pAtivaCadCOA;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE COA_CADCOA ' +
                '   SET COA_ATIVAD = :ATIVAD ' +
                ' WHERE COA_CODIGO = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasTopCoat.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE COA_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasTopCoat.pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
begin
  Try
    pAtivaNfm;
    pAtivaCadCOA;

    tela['btnAtivarNfm']['Enabled'].Value := False;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasTopCoat.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasTopCoat.pBotaoAtivarNfm(
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

procedure TCadastroNovasFormulasTopCoat.pCalcularTotalVolume(
  const tela: ITelaCadLibTintas);
Var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido := 0;

  For intCont := 1 To 20 Do
  Begin
    strQtdCon := tela['dbeQtdB' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;
    strQtdDil := tela['dbeQtdD' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;

    If qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido := fltTotalDiluido + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  end;

  tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
end;

procedure TCadastroNovasFormulasTopCoat.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(Tela);
end;


procedure TCadastroNovasFormulasTopCoat.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  Tela['btnCarregarBases']['Visible'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
end;

procedure TCadastroNovasFormulasTopCoat.pValorCampoAtivarDesativar(
  const Tela: ITelaCadLibTintas);
begin
  If Not (tela['chkAtivad']['Checked'].Value) Then
    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'N'
  Else If (tela['chkAtivad']['Checked'].Value = True) Then
    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
end;

function TCadastroNovasFormulasTopCoat.ValidarBase(
  const strCodBas: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   COA_CADBAS               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
    ' WHERE BAS_CODBAS = :CODBAS ',
    'QTD', [strCodBas]
  ) > 0;
end;

function TCadastroNovasFormulasTopCoat.ValidarBaseJaCadastrado(
  const tela: ITelaCadLibTintas; const strCodBas, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 20 Do
  Begin
    If fVerificaBaseJaCadastrada(tela, strNomCam, intCont) Then
    Begin
      If tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value = strCodBas Then
        Result := False;
    End;
  End;
end;


function TCadastroNovasFormulasTopCoat.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN COA_CADCOA ON %1:s_ITETIN = COA_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "COA" '+
                                                 '   AND COA_CODIGO = :CODNFM',
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
Var
  strSql: String;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    ' FROM                     ' +
    '   COA_CADBAS             ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := strSql;
  qryBases.Open;
end;

procedure TBtnAjustarVolumeOnClick.OnClick(Sender: TObject);
Var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido := 0;

  ConstruirQryBasesValume;

  AjustarVolume(tela);

  For intCont := 1 To 20 Do
  begin
    strQtdCon := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsString;
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsString;

    If qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) Then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido     := fltTotalDiluido + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  end;
end;

procedure TBtnAjustarVolumeOnClick.pCalcularTotalVolume(
  const cadastro: TAbstractCadastro);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido := 0;

  For intCont := 1 To 20 Do
  Begin
    strQtdCon := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsString;
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsString;

    If qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) then
    Begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido     := fltTotalDiluido + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  end;

  tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
end;

end.

