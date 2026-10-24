unit untCadastroNovasFormulasMazaIndustrial;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas,
  untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils, Classes,
  untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untIDataSet;

type
  TCadastroNovasFormulasMazaIndustrial = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    intPrxNfm: Integer;

    function ValidarBase(const strCodBas: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas;
      const strCodBas: string; const strNomCam: string): Boolean;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    function fCalculaPesCor(fltPesoFormula: Double): Double;
    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(const qryCadastro: IDataSet): String;
    function FTemPedidoNfm(): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadMzd;

    procedure pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
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
    procedure pSetaEnableReadOnly(const tela: ITelaCadLibTintas;
      const strState: string); override;
    function fGetCampoChave(const index: Integer): string; override;
    function fGetCountCamposChave: Integer; override;
    function fValidaCampos(const tela: ITelaCadLibTintas; strNomeCampo: string;
      strValorCampo: string; var strRetorno: string): Boolean; override;
    function fVerificaNovFormulas(strCodNfm: String): Boolean; Override;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); override;
    procedure FormatarCampo(const strNomeCampo: string; var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;
    procedure AjustarTela(const tela: ITelaCadLibTintas); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState: String); override;

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

    function fGetDescricaoMontadoraMZD(const strCodMontadora: String): String;
    function fGetDescricaoLinhaMZD(const strCodLinha: String): String;
  end;

implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasMazaIndustrial,
  untDbeCodBasKeyPressMazaIndustrial,
  untGravandoExecucaoMazaIndustrialNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untGravandoExecucaoMazaIndustrialCores,
  untDbeCodMontadoraKeyPressMazaIndustrial,
  untDbeLinhaKeyPressMazaIndustrial, untVariantUtils, untFloatUtils,
  untBtnCarregaFormulasCadastradaOnClickMazaIndustrial, untTypesSistema;
{ TCadastroNovasFormulasMazaIndustrial }

procedure TCadastroNovasFormulasMazaIndustrial.AjustarTela
  (const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 540;
  tela.GetSelf['Width'].Value := 700;
  tela['btnAtivarNfm']['Visible'].Value := True;
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasMazaIndustrial.AlterarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasMazaIndustrial.AlterarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbePesoCor']['Enabled'].Value := false;
  tela['dbePesoFor']['Enabled'].Value := false;
  tela['dbeDataCadastro']['Enabled'].Value := false;

end;

procedure TCadastroNovasFormulasMazaIndustrial.AtivarNovasFormulas
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString)
  then
  Begin
    TAutcomTintaFactory.Get.fMensagem('AVISO',
      'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODIGO')
    .AsString)) And (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' +
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD')
      .AsString = 'S', 'Desativar', 'Ativar') + ' essa nova fórmula ?',
      ['&Sim', '&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm(tela);
      pAtualizaNfm;
    End;

    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF
      (GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'Desativar',
      'Ativar');
  End;
end;

procedure TCadastroNovasFormulasMazaIndustrial.CancelarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasMazaIndustrial.CarregarDescricoes
  (const tela: ITelaCadLibTintas);
begin
  tela['edtDesMontadora']['Text'].Value := fGetDescricaoMontadoraMZD
    (tela['dbeMontadora']['Text'].Value);
  tela['edtDesLinha']['Text'].Value :=
    fGetDescricaoLinhaMZD(tela['dbeItemLinha']['Text'].Value);
end;

procedure TCadastroNovasFormulasMazaIndustrial.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 35, 23, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblVariacao', 'Variação:', 175, 23, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodUniver', 'Cód.Universal:', 325, 23, 65, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 465, 23, 65, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', -37, 47, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblObservacao', 'Observação:', -37, 71, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMontadora', 'Montadora:', -37, 95, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', -37, 115, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPesoCor', 'Peso da Cor:', -37, 135, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPesoFor', 'Peso da Fórmula:', 230, 135, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAnoCor', 'Ano:', 380, 135, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob', 'Acrésc. Mão de Obra:', 60, 157, 50, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 115, 16, 80, 22, 'ttAlfanumerico', 'NFM_CODIGO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeVariacao', 250, 16, 60, 22, 'ttAlfanumerico', 'NFM_VARIAC')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUniver', 390, 16, 60, 22, 'ttAlfanumerico', 'NFM_UNIVER')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '2')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 530, 16, 60, 22, 'ttAlfanumerico', 'NFM_DTACAD'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 115, 40, 475, 22, 'ttAlfanumerico', 'NFM_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '3')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeObservacao', 115, 64, 475, 22, 'ttAlfanumerico', 'NFM_OBSERV')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMontadora', 115, 87, 49, 22, 'ttAlfanumerico', 'NFM_CODMON')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CompZeros', 'True'))
    .AdicionarEvento(TDbeCodMontadoraKeyPress.Create('OnKeyPress', self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesMontadora', 165, 87, 425, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')
    ).AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeItemLinha', 115, 110, 49, 22, 'ttAlfanumerico', 'NFM_LINHA_')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '6'))
    .AdicionarEvento(TDbeCodLinKeyPress.Create('OnKeyPress', self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesLinha', 165, 110, 425, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePesoCor', 115, 133, 100, 22, 'ttAlfanumerico', 'NFM_PESCOR')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePesoFor', 310, 133, 100, 22, 'ttAlfanumerico', 'NFM_PESFOR')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')
    ).AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAnoCor', 463, 133, 127, 22, 'ttAlfanumerico', 'NFM_ANOCOR')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 115, 155, 100, 22, 'ttAlfanumerico', 'NFM_ACRMOB')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '10')));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 310, 156, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '11')));

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnCarregarBases: TSpeedButton                        ' +
    '   Left = 15                                                  ' +
    '   Top = 178                                                  ' +
    '   Width = 600                                                ' +
    '   Height = 23                                                ' +
    '   Hint = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''         ' +
    '   Caption = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''      ' +
    '   ParentShowHInt = False                                      ' +
    '   ShowHint = True                                             ' +
    '   Visible = True                                              ' +
    ' End                                                           ')
    .AdicionarEvento(TBtnCarregaBasesCadastrada.Create(Self)));


  If TAutcomTintaFactory.Get.fGetConfTinta('MZD').fGet('EXQDIG') = 'S' Then
    AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkQtdDig', 390, 156, 150, 17, 'Baixar Quantidade Digitada', 'NFM_BAIQDI', 'S', 'N')
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '12')));

  groupBases := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbBases', 1, 200, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Bases      '));

  for intCont := 1 to 10 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2), Format('Código %.2d:',
      [intCont]), 8, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtd' + TStrUtils.fStrZero(intCont, 2), 'Quantidade Grama:', 192,
      (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 68, 22 * intCont, 80, 22,
      'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressMazaIndustrial.Create(self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2))));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtd' + TStrUtils.fStrZero(intCont, 2), 250, 22 * intCont, 80, 22,
      'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')));
  end;

  for intCont := 11 to 20 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2), Format('Código %.2d:',
      [intCont]), 350, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtd' + TStrUtils.fStrZero(intCont, 2), 'Quantidade Grama:', 540,
      (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));


    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 415, 22 * (intCont - 10), 80, 22,
      'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressMazaIndustrial.Create(self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2))));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtd' + TStrUtils.fStrZero(intCont, 2), 600, 22 * (intCont - 10), 80, 22,
      'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')));
  end;

  groupBases.AdicionarControle(TLibTintaControleVisualImplementacao.Create
    (' object Label5: TLabel                                  ' +
    '   Left = 80                                            ' +
    '   Top = 0                                              ' +
    '   Width = 435                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taRightJustify                           ' +
    '   AutoSize = False                                     ' +
    '   Caption = ''Informar a quantidade para o cadastro da fórmula em Litro (900ML)'' '
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

  AdicionarControle(groupBases);
end;

procedure TCadastroNovasFormulasMazaIndustrial.DeletaNovaFormula
  (strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM MZD_CADMZD WHERE MZD_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasMazaIndustrial.ExcluirAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
end;

procedure TCadastroNovasFormulasMazaIndustrial.ExcluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);

  tela['edtDesMontadora']['Text'].Value := '';
  tela['edtDesLinha']['Text'].Value := '';

end;

function TCadastroNovasFormulasMazaIndustrial.fCalculaPesCor(fltPesoFormula: Double): Double;
Var
  qryBases: IDataSet;
  intContador: Integer;
  fltValor: Double;
  fltValorTotal: Double;
begin
  Try
    fltValorTotal := 0;

    qryBases := TAutcomTintaFactory.Get.fGetDataSet;

    For intContador := 1 To 20 Do
    Begin

      If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_FORM' +
        TStrUtils.fStrZero(intContador, 2)).AsString) Then
        Break;

      qryBases.Close;
      qryBases.SQL := '';
      qryBases.SQL := qryBases.SQL + '  SELECT              ';
      qryBases.SQL := qryBases.SQL + '    BAS_PESESP        ';
      qryBases.SQL := qryBases.SQL + '  FROM                ';
      qryBases.SQL := qryBases.SQL + '    MZD_CADBAS        ';
      qryBases.SQL := qryBases.SQL + '  WHERE BAS_CODBAS = :BASE    ';
      qryBases.ParamByName('BASE').AsString := GetQueryCadastro.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intContador, 2)).AsString;
      qryBases.Open;

      fltValor := (GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat / fltPesoFormula) *
        qryBases.FieldByName('BAS_PESESP').AsFloat;
      fltValorTotal := fltValorTotal + fltValor;
    End;

    Result := fltValorTotal;

  Except
    Raise;
  End;
end;


function TCadastroNovasFormulasMazaIndustrial.fGetCampoChave
  (const index: Integer): string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasMazaIndustrial.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasMazaIndustrial.fGetDescricaoLinhaMZD
  (const strCodLinha: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT LIN_DESCRI ' + '  FROM MZD_CADLIN  ' +
                ' WHERE LIN_CODIGO = :CODIGO';
  qryGen.ParamByName('CODIGO').AsString := strCodLinha;
  qryGen.Open;

  Result := qryGen.FieldByName('LIN_DESCRI').AsString;

end;

function TCadastroNovasFormulasMazaIndustrial.fGetDescricaoMontadoraMZD
  (const strCodMontadora: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT MON_DESCRI ' + '  FROM MZD_CADMON  ' +
                ' WHERE MON_CODMON = :CODIGO';
  qryGen.ParamByName('CODIGO').AsString := strCodMontadora;
  qryGen.Open;

  Result := qryGen.FieldByName('MON_DESCRI').AsString;

end;

function TCadastroNovasFormulasMazaIndustrial.fGetMd5KeyPedidos(
  const qryCadastro: IDataSet): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM MZD_CADMZD        ';
  qryGen.SQL := qryGen.SQL + '  WHERE MZD_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('MZD_MD5KEY').AsString;
end;

procedure TCadastroNovasFormulasMazaIndustrial.FormatarCampo(const strNomeCampo
  : string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(LeftStr(strNomeCampo, Length('NFM_QTDC')), ['NFM_QTDC']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end
  Else If MatchStr(LeftStr(strNomeCampo, Length('NFM_QTML')), ['NFM_QTML']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End
  else if MatchStr(strNomeCampo, ['NFM_ACRMOB']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end
  else if MatchStr(strNomeCampo, ['NFM_PESCOR']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  end
  else if MatchStr(strNomeCampo, ['NFM_PESFOR']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  end
end;

function TCadastroNovasFormulasMazaIndustrial.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasMazaIndustrial.fPodeAlterar: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    If Not fPermiteAlterarNfmVendida Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO',
        'Já existe movimentação para essa fórmula, por isso não é possivel alterá-la.',
        ['&OK']);
      Result := false;
    End
    Else
    Begin
      If Not FTemPedidoNfm() Then
        Result := False;
    End;
  end;
end;

function TCadastroNovasFormulasMazaIndustrial.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO',
      'Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',
      ['&OK']);
    Result := false;
  end;
end;

function TCadastroNovasFormulasMazaIndustrial.FTemPedidoNfm: Boolean;
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
    qryGen.ParamByName('IDEPRO').AsString := 'MZD';
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

function TCadastroNovasFormulasMazaIndustrial.fValidaCampos
  (const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
Var
  strCampoQtd: String;
  strValorCampoQtd: String;
  strCampoNum: String;

begin
  Result := True;

  if LeftStr(strNomeCampo, 8) = 'NFM_FORM' then
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) then
    begin
      Result := false;
      strRetorno := 'É necessário digitar pelo menos 1 Base!';
    end
    else if not TStrUtils.fEmptyStr(strValorCampo) then
    begin
      if not ValidarBase(strValorCampo) then
      begin
        Result := false;
        strRetorno := 'Base não encontrada!';
      end
      else if not ValidarBaseJaCadastrado(tela, strValorCampo, strNomeCampo)
      then
      begin
        Result := false;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO',
          'Esse Base já está cadastrada para essa nova fórmula!', ['&Ok']);
        strRetorno := '';
      end;
    end
    else if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela.pSetarFocus;
      Result := True;
    end
  end
  else if strNomeCampo = 'NFM_DESCRI' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := false;
      strRetorno := 'A descrição deve ser preenchida!';
    end
  end
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDC' then
  begin
    if not TStrUtils.fEmptyStr
      (GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC',
      'NFM_FORM', [rfReplaceAll])).AsString) then
    begin
      if TStrUtils.fEmptyStr(strValorCampo) then
      begin
        Result := false;
        strRetorno := 'É necessário digitar a quantidade da Base!';
      end
      else if strToFloatDef(strValorCampo, 0) <= 0 then
      begin
        Result := false;
        strRetorno := 'A quantidade da base deve ser maior que Zero!';
      end;
    end
    else
    Begin
      strCampoQtd := 'dbeQtd' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      strCampoNum := Copy(strNomeCampo, (Length(strNomeCampo) - 1),
        Length(strNomeCampo));

      if (strToFloatDef(strValorCampoQtd, -1) > 0) and
        (TStrUtils.fEmptyStr(tela['dbeForm' + strCampoNum]['Text'].Value)) then
      begin
        Result := false;
        strRetorno :=
          'A quantidade da Base foi informada. Por favor, informe seu código.';
      end
    End
  end
  else if strNomeCampo = 'NFM_ACRMOB' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbeAcrMob']['Text'].Value := 0;
    end
    Else If (strToFloatDef(tela['dbeAcrMob']['Text'].Value, 0) < 0) Then
    Begin
      Result := false;
      strRetorno :=
        'O Acréscimo de Mão de Obra deve ser maior ou igual a zero!';
    End;
  end

  else if strNomeCampo = 'NFM_PESCOR' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbePesoCor']['Text'].Value := 0;
    end
    Else If (strToFloatDef(tela['dbePesoCor']['Text'].Value, 0) <= 0) Then
    Begin
      Result := false;
      strRetorno := 'O peso da cor deve ser preenchido!';
    End;
  end

  else if strNomeCampo = 'NFM_PESFOR' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbePesoFor']['Text'].Value := 0;
    end
    Else If (strToFloatDef(tela['dbePesoFor']['Text'].Value, 0) <= 0) Then
    Begin
      Result := false;
      strRetorno := 'O peso da fórmula deve ser preenchido!';
    End;
  end

  else if strNomeCampo = 'NFM_LINHA_' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := false;
      strRetorno := 'O campo linha deve ser preenchido!';
    end
    Else
    Begin
      if TStrUtils.fEmptyStr(fGetDescricaoLinhaMZD(tela['dbeItemLinha']['Text']
        .Value)) Then
      begin
        Result := false;
        strRetorno := 'A Linha informada não é válida!';
      end;
    End;
  end

  else if strNomeCampo = 'NFM_CODMON' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := false;
      strRetorno := 'A montadora deve ser preenchida!';
    end
    Else
    Begin
      if TStrUtils.fEmptyStr(fGetDescricaoMontadoraMZD(tela['dbeMontadora']
        ['Text'].Value)) Then
      begin
        Result := false;
        strRetorno := 'A Montadora informada não é válida!';
      end;
    End;
  end

  else if (not fValidarPreenchimentoCol(tela)) then
  begin
    Result := false;
    strRetorno :=
      'Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  end;
end;

function TCadastroNovasFormulasMazaIndustrial.fValidarPreenchimentoCol
  (const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
  blnCampoVazio: Boolean;
begin
  Result := True;
  blnCampoVazio := false;

  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont, 2)
      ]['Text'].Value) and not(blnCampoVazio) then
      blnCampoVazio := True
    else if not TStrUtils.fEmptyStr(tela['dbeForm' + TStrUtils.fStrZero(intCont,
      2)]['Text'].Value) and (blnCampoVazio) then
    begin
      Result := false;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasMazaIndustrial.fVerificaNovFormulas
  (strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                                    ';
  qryGen.SQL := qryGen.SQL + '    * FROM    ' + GetNomeTabela + '       ';
  qryGen.SQL := qryGen.SQL + '  WHERE     ' + GetNomeCampo + '  = :NFM    ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasMazaIndustrial.GetCamposDesabilitadosEdit
  : TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasMazaIndustrial.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasMazaIndustrial.Create;
end;

function TCadastroNovasFormulasMazaIndustrial.GetNomeCampo: string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasMazaIndustrial.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasMazaIndustrial.
  GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasMazaIndustrial.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasMazaIndustrial.GetNomeTabela: string;
begin
  Result := 'MZD_CADNFM';
end;

function TCadastroNovasFormulasMazaIndustrial.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasMazaIndustrial.GetTipoTinta: TTipoTinta;
begin
  Result := ttIndustrial;
end;

function TCadastroNovasFormulasMazaIndustrial.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasMazaIndustrial.GravarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
Var
  intCont: Integer;
  fltPesFor: Double;
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('MZD')
      .fGetInteger('MZDNFM');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODIGO').AsString := 'ESP ' +
        TAutcomTintaFactory.Get.GetCodEmp + strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODIGO')
      .AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';

    If TAutcomTintaFactory.Get.fGetConfTinta('MZD').fGet('EXQDIG') = 'S' Then
    Begin
      If Not(tela['chkQtdDig']['Checked'].Value) Then
        GetQueryCadastro.FieldByName('NFM_BAIQDI').AsString := 'N'
      else If (tela['chkQtdDig']['Checked'].Value = True) Then
        GetQueryCadastro.FieldByName('NFM_BAIQDI').AsString := 'S';
    End;
  End
  Else
  Begin
    If Not(tela['chkAtivad']['Checked'].Value) Then
      GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'N'
    else If (tela['chkAtivad']['Checked'].Value = True) Then
      GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;

  fltPesFor := 0;

  for intCont := 1 To 20 Do
  begin
    fltPesFor := fltPesFor + strToFloatDef
      (tela['dbeQtd' + TStrUtils.fStrZero(intCont, 2) + '']['Text'].Value, 0);
  end;

  if (fltPesFor > 0) Then
  begin

    tela['dbePesoFor']['Text'].Value := TFloatUtils.fFormataFloat(fltPesFor, 4);
    tela['dbePesoCor']['Text'].Value := TFloatUtils.fFormataFloat(fCalculaPesCor(fltPesFor), 6);
  end
  else
  begin
    tela['dbePesoFor']['Text'].Value := '0.0000';
    tela['dbePesoCor']['Text'].Value := '0.0000';
  end;

  For intCont := 1 To 20 Do
  Begin

    If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_FORM' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
      Break;

    If GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat <= 0  Then
      Break;

    {GetQueryCadastro.FieldByName('NFM_QTML' + TStrUtils.fStrZero(intCont, 2)).AsFloat := fCalculaQtdMl(TFloatUtils.fFormataFloat(fltPesFor, 4),
                                                                                                       TFloatUtils.fFormataFloat(fCalculaPesCor(fltPesFor), 6),
                                                                                                       GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat);}
  End;




end;

procedure TCadastroNovasFormulasMazaIndustrial.GravarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmMZD: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoMazaIndustrialNovasFormulas.Create
      (GetQueryCadastro.FieldByName('NFM_CODIGO').AsString)
      as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);

    If Not tela.GetBlnAlterou Then
    Begin
      strNfmMZD := TStrUtils.fStrZero
        (IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('MZD').pSet('MZDNFM', strNfmMZD);
    End;

  end;
end;

procedure TCadastroNovasFormulasMazaIndustrial.IncluirAntes
  (const tela: ITelaCadLibTintas; const strState: String);
begin
  inherited;

end;

procedure TCadastroNovasFormulasMazaIndustrial.IncluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnAtivarNfm']['Enabled'].Value := false;
  tela['dbeCodNfm']['Enabled'].Value := false;
  tela['chkAtivad']['Checked'].Value := True;

  If TAutcomTintaFactory.Get.fGetConfTinta('MZD').fGet('EXQDIG') = 'S' Then
    tela['chkQtdDig']['Checked'].Value := True;

  tela['dbeDataCadastro']['Enabled'].Value := false;

  tela['edtDesMontadora']['Text'].Value := '';
  tela['edtDesLinha']['Text'].Value := '';

  tela['dbePesoCor']['Enabled'].Value := false;
  tela['dbePesoFor']['Enabled'].Value := false;

  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate := date;

  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasMazaIndustrial.pAtivaCadMzd;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE MZD_CADMZD ' + '   SET MZD_ATIVAD = :ATIVAD ' +
                ' WHERE MZD_CODIGO = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasMazaIndustrial.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE MZD_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasMazaIndustrial.pAtivarDesativarNfm
  (const tela: ITelaCadLibTintas);
begin
  Try
    pAtivaNfm;
    pAtivaCadMzd;

    tela['edtDesMontadora']['Text'].Value := '';
    tela['edtDesLinha']['Text'].Value := '';
    tela['btnAtivarNfm']['Enabled'].Value := false;

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

procedure TCadastroNovasFormulasMazaIndustrial.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasMazaIndustrial.pBotaoAtivarNfm
  (const tela: ITelaCadLibTintas);
begin
  tela['btnAtivarNfm']['Enabled'].Value := false;
  If Not GetQueryCadastro.IsEmpty Then
  Begin
    tela['btnAtivarNfm']['Enabled'].Value := VerificarNovaFormulaMovimentada;
    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF
      (tela['btnAtivarNfm']['Enabled'].Value,
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'Desativar', 'Ativar'), 'Ativar');
  End;
end;

procedure TCadastroNovasFormulasMazaIndustrial.PesquisarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbePesoCor']['Enabled'].Value := false;
  tela['dbePesoFor']['Enabled'].Value := false;

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasMazaIndustrial.pSetaEnableReadOnly
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  If (strState = 'dsEdit') Or (strState = 'dsInsert') Then
    Tela['btnCarregarBases']['Visible'].Value := True
  Else
    Tela['btnCarregarBases']['Visible'].Value := False;
end;

function TCadastroNovasFormulasMazaIndustrial.ValidarBase(const strCodBas
  : string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(' SELECT                     '
    + '   COUNT(0) AS QTD          ' + ' FROM                       ' +
    '   MZD_CADBAS               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
    ' WHERE BAS_CODBAS = :CODBAS ', 'QTD', [strCodBas]) > 0;
end;

function TCadastroNovasFormulasMazaIndustrial.ValidarBaseJaCadastrado
  (const tela: ITelaCadLibTintas; const strCodBas, strNomCam: string): Boolean;
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
        ]['Text'].Value = strCodBas Then
        Result := false;
    End;
  End;
end;

function TCadastroNovasFormulasMazaIndustrial.
  VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD ' +
        '  FROM %0:s ' + ' INNER JOIN MZD_CADMZD ON %1:s_ITETIN = MZD_MD5KEY ' +
        ' WHERE %1:s_IDEPRO = "MZD" ' + '   AND MZD_CODNFM = :CODNFM',
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
