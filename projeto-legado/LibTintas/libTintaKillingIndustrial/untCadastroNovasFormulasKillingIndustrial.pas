unit untCadastroNovasFormulasKillingIndustrial;

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
  TCadastroNovasFormulasKillingIndustrial = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    intPrxNfm: Integer;

    function ValidarBase(const strCodBas: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas;
      const strCodBas: string; const strNomCam: string): Boolean;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(const qryCadastro: IDataSet): String;
    function FTemPedidoNfm(): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadKIN;

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

    function GetPreencherDbComboBox: Boolean; override;
    function GetDescDbComboBox: String; override;

    function fGetDescricaoMontadoraKIN(const strCodMontadora: String): String;
    function fGetDescricaoLinhaKIN(const strCodLinha: String): String;
    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: String): Boolean; Override;
  end;

implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasKillingIndustrial,
  untDbeCodBasKeyPressKillingIndustrial,
  untGravandoExecucaoKillingIndustrialNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untGravandoExecucaoKillingIndustrialCores,
  untDbeCodMontadoraKeyPressKillingIndustrial,
  untDbeLinhaKeyPressKillingIndustrial, untVariantUtils, untFloatUtils, untTypesSistema;
{ TCadastroNovasFormulasKillingIndustrial }

procedure TCadastroNovasFormulasKillingIndustrial.AjustarTela
  (const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 480;
  tela.GetSelf['Width'].Value := 635;
  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Left'].Value      := 115;
  tela['DBComboBox']['Top'].Value       := 60;
  tela['DBComboBox']['Width'].Value     := 200;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'NFM_ORIGEM';
  tela['DBComboBox']['TabOrder'].Value  := 4;

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasKillingIndustrial.AlterarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasKillingIndustrial.AlterarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDataCadastro']['Enabled'].Value := false;

end;

procedure TCadastroNovasFormulasKillingIndustrial.AtivarNovasFormulas
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
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_')
      .AsString = 'S', 'Desativar', 'Ativar') + ' essa nova fórmula ?',
      ['&Sim', '&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm(tela);
      pAtualizaNfm;
    End;

    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF
      (GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S', 'Desativar',
      'Ativar');
  End;
end;

procedure TCadastroNovasFormulasKillingIndustrial.CancelarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasKillingIndustrial.CarregarDescricoes
  (const tela: ITelaCadLibTintas);
begin
  tela['edtDesMontadora']['Text'].Value := fGetDescricaoMontadoraKIN
    (tela['dbeMontadora']['Text'].Value);
  tela['edtDesLinha']['Text'].Value :=
    fGetDescricaoLinhaKIN(tela['dbeItemLinha']['Text'].Value);
end;

procedure TCadastroNovasFormulasKillingIndustrial.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 35, 20, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 220, 20, 65, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblNomCor', 'Nome Cor:', 400, 20, 35, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', -37, 42, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblOrigem', 'Origem:', -37, 65, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProdut', 'Produto:' ,335, 65, 50, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMontadora', 'Montadora:', -37, 86, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', -37, 108, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob', 'Acrésc. Mão de Obra:', 60, 130, 50, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAnoCor', 'Ano Cor:', 300, 130, 50, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 115, 16, 80, 22, 'ttAlfanumerico', 'NFM_CODIGO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 290, 16, 80, 22, 'ttAlfanumerico', 'NFM_DTACAD'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeNomeCor', 440, 16, 150, 22, 'ttAlfanumerico', 'NFM_NOMCOR')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '3')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 115, 38, 475, 22, 'ttAlfanumerico', 'NFM_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4')));


 { AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeOrigem', 115, 60, 200, 22, 'ttAlfanumerico', 'NFM_ORIGEM')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4')));}

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProdut', 390, 60, 200, 22, 'ttAlfanumerico', 'NFM_PRODUT')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMontadora', 115, 82, 49, 22, 'ttAlfanumerico', 'NFM_CODMON')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '6'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CompZeros', 'True'))
    .AdicionarEvento(TDbeCodMontadoraKeyPress.Create('OnKeyPress', self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesMontadora', 165, 82, 425, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')
    ).AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeItemLinha', 115, 104, 49, 22, 'ttAlfanumerico', 'NFM_LINHA_')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '7'))
    .AdicionarEvento(TDbeCodLinKeyPress.Create('OnKeyPress', self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesLinha', 165, 104, 425, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', false)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 115, 126, 150, 22, 'ttAlfanumerico', 'NFM_ACRMOB')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAnoCor', 355, 126, 150, 22, 'ttNumerico', 'NFM_ANOCOR')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '10')));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 540, 130, 70, 17, 'Ativa', 'NFM_ATIVO_', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '11')));

  groupBases := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbBases', 1, 200, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Bases      '));

  for intCont := 1 to 10 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 8, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtd' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 170, (22 * intCont) + 3, 57, 14, 'taRightJustify'));


    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 68,
      22 * intCont, 95, 22, 'ttAlfanumerico', 'NFM_BASE' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressKillingIndustrial.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtd' + TStrUtils.fStrZero(intCont , 2), 228,
      22 * intCont, 80, 22, 'ttAlfanumerico', 'NFM_QTDB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

  end;

  for intCont := 11 to 20 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 315, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtd' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 477, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));


    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 375,
      22 * (intCont - 10), 95, 22, 'ttAlfanumerico', 'NFM_BASE' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressKillingIndustrial.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtd' + TStrUtils.fStrZero(intCont , 2), 535,
      22 * (intCont - 10), 80, 22, 'ttAlfanumerico', 'NFM_QTDB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

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

procedure TCadastroNovasFormulasKillingIndustrial.DeletaNovaFormula
  (strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM KIN_CADKIN WHERE KIN_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasKillingIndustrial.ExcluirAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
end;

procedure TCadastroNovasFormulasKillingIndustrial.ExcluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);

  tela['edtDesMontadora']['Text'].Value := '';
  tela['edtDesLinha']['Text'].Value := '';

end;

function TCadastroNovasFormulasKillingIndustrial.fGetCampoChave
  (const index: Integer): string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasKillingIndustrial.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasKillingIndustrial.fGetDescricaoLinhaKIN
  (const strCodLinha: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT LIN_DESCRI ' + '  FROM KIN_CADLIN  ' +
                ' WHERE LIN_CODIGO = :CODIGO';
  qryGen.ParamByName('CODIGO').AsString := strCodLinha;
  qryGen.Open;

  Result := qryGen.FieldByName('LIN_DESCRI').AsString;

end;

function TCadastroNovasFormulasKillingIndustrial.fGetDescricaoMontadoraKIN
  (const strCodMontadora: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT MON_DESCRI ' + '  FROM KIN_CADMON  ' +
                ' WHERE MON_CODMON = :CODIGO';
  qryGen.ParamByName('CODIGO').AsString := strCodMontadora;
  qryGen.Open;

  Result := qryGen.FieldByName('MON_DESCRI').AsString;

end;

function TCadastroNovasFormulasKillingIndustrial.fGetMd5KeyPedidos(
  const qryCadastro: IDataSet): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM KIN_CADKIN        ';
  qryGen.SQL := qryGen.SQL + '  WHERE KIN_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('KIN_MD5KEY').AsString;
end;

procedure TCadastroNovasFormulasKillingIndustrial.FormatarCampo(const strNomeCampo
  : string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  If MatchStr(LeftStr(strNomeCampo, Length('NFM_QTDB')), ['NFM_QTDB']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End
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

function TCadastroNovasFormulasKillingIndustrial.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasKillingIndustrial.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasKillingIndustrial.fPodeExcluir: Boolean;
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

function TCadastroNovasFormulasKillingIndustrial.fPodeGravar(
  const tela: ITelaCadLibTintas; const strState: String): Boolean;
Var
  intContador: Integer;
  fltTotQuantidade: Double;
begin
  Result := True;
  fltTotQuantidade := 0;

  For intContador := 1 To 20 Do
  Begin
    If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
      Break;

    fltTotQuantidade := fltTotQuantidade + GetQueryCadastro.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
  End;

  If (fltTotQuantidade < 100) Or (fltTotQuantidade > 100) Then
    Result := False;

  If Not Result Then
  Begin
    If fltTotQuantidade < 100 Then
      TAutcomTintaFactory.Get.fMensagem('', 'O percentual da quantidade está abaixo de 100%! [' + FloatToStr(fltTotQuantidade) + '%] ', ['&Ok'])
    Else If fltTotQuantidade > 100 Then
      TAutcomTintaFactory.Get.fMensagem('', 'O percentual da quantidade está maior que 100%! [' + FloatToStr(fltTotQuantidade) + '%] ', ['&Ok']);
  End;
end;

function TCadastroNovasFormulasKillingIndustrial.FTemPedidoNfm: Boolean;
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
    qryGen.ParamByName('IDEPRO').AsString := 'KIN';
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

function TCadastroNovasFormulasKillingIndustrial.fValidaCampos
  (const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
Var
  strCampoQtd: String;
  strValorCampoQtd: String;
  strCampoNum: String;

begin
  Result := True;

  If LeftStr(strNomeCampo, 8) = 'NFM_BASE' Then
  Begin
    If TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) Then
    Begin
      Result := false;
      strRetorno := 'É necessário digitar pelo menos 1 Base!';
    End
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If Not ValidarBase(strValorCampo) Then
      Begin
        Result := false;
        strRetorno := 'Base não encontrada!';
      End
      Else If Not ValidarBaseJaCadastrado(tela, strValorCampo, strNomeCampo) Then
      Begin
        Result := false;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO',
          'Esse Base já está cadastrada para essa nova fórmula!', ['&Ok']);
        strRetorno := '';
      End;
    End
    Else If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      tela.pSetarFocus;
      Result := True;
    End
  End
  Else If strNomeCampo = 'NFM_DESCRI' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := false;
      strRetorno := 'A descrição deve ser preenchida!';
    End
  End
  Else If strNomeCampo = 'NFM_PRODUT' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'O produto deve ser preenchido!';
    End;
  End
  Else If strNomeCampo = 'NFM_NOMCOR' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'O nome da cor deve ser preenchido!';
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDB' Then
  Begin
    If Not TStrUtils.fEmptyStr
      (GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDB',
      'NFM_BASE', [rfReplaceAll])).AsString) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := false;
        strRetorno := 'É necessário digitar a quantidade da Base!';
      End
      Else If strToFloatDef(strValorCampo, 0) <= 0 Then
      begin
        Result := false;
        strRetorno := 'A quantidade da base deve ser maior que Zero!';
      End;
    End
    Else
    Begin
      strCampoQtd := 'dbeQtd' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      strCampoNum := Copy(strNomeCampo, (Length(strNomeCampo) - 1),
        Length(strNomeCampo));

      If (strToFloatDef(strValorCampoQtd, -1) > 0) And
        (TStrUtils.fEmptyStr(tela['dbeForm' + strCampoNum]['Text'].Value)) Then
      Begin
        Result := false;
        strRetorno :=
          'A quantidade da Base foi informada. Por favor, informe seu código.';
      End
    End
  End
  Else if strNomeCampo = 'NFM_ACRMOB' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      tela['dbeAcrMob']['Text'].Value := 0;
    End
    Else If (strToFloatDef(tela['dbeAcrMob']['Text'].Value, 0) < 0) Then
    Begin
      Result := false;
      strRetorno :=
        'O Acréscimo de Mão de Obra deve ser maior ou igual a zero!';
    End;
  End
  Else If strNomeCampo = 'NFM_LINHA_' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := false;
      strRetorno := 'O campo linha deve ser preenchido!';
    End
    Else
    Begin
      If TStrUtils.fEmptyStr(fGetDescricaoLinhaKIN(tela['dbeItemLinha']['Text'].Value)) Then
      Begin
        Result := false;
        strRetorno := 'A Linha informada não é válida!';
      End;
    End;
  End
  Else If strNomeCampo = 'NFM_CODMON' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := false;
      strRetorno := 'A montadora deve ser preenchida!';
    End
    Else
    Begin
      If TStrUtils.fEmptyStr(fGetDescricaoMontadoraKIN(tela['dbeMontadora'] ['Text'].Value)) Then
      Begin
        Result := false;
        strRetorno := 'A Montadora informada não é válida!';
      End;
    End;
  End
  Else If (Not fValidarPreenchimentoCol(tela)) Then
  Begin
    Result := false;
    strRetorno :=
      'Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  End;
end;

function TCadastroNovasFormulasKillingIndustrial.fValidarPreenchimentoCol
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

function TCadastroNovasFormulasKillingIndustrial.fVerificaNovFormulas
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

function TCadastroNovasFormulasKillingIndustrial.GetCamposDesabilitadosEdit
  : TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasKillingIndustrial.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasKillingIndustrial.Create;
end;

function TCadastroNovasFormulasKillingIndustrial.GetDescDbComboBox: String;
Var
  qryGen: IDataSet;
begin
  Result := '';

  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '  SELECT DISTINCT              ';
    qryGen.SQL := qryGen.SQL + '    ORI_DESCRI    ';
    qryGen.SQL := qryGen.SQL + '  FROM            ';
    qryGen.SQL := qryGen.SQL + '    KIN_CADORI    ';
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin

      If TStrUtils.fEmptyStr(Result) Then
        Result := qryGen.FieldByName('ORI_DESCRI').AsString
      Else
        Result := Result + ',' + qryGen.FieldByName('ORI_DESCRI').AsString;

      qryGen.Next;
    End;

  Except
    Raise;
  End;

end;

function TCadastroNovasFormulasKillingIndustrial.GetNomeCampo: string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasKillingIndustrial.GetNomeCampoItem: string;
begin
  Result := 'NFM_BASE';
end;

function TCadastroNovasFormulasKillingIndustrial.
  GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasKillingIndustrial.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasKillingIndustrial.GetNomeTabela: string;
begin
  Result := 'KIN_CADNFM';
end;

function TCadastroNovasFormulasKillingIndustrial.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasKillingIndustrial.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasKillingIndustrial.GetTipoTinta: TTipoTinta;
begin
  Result := ttIndustrial;
end;

function TCadastroNovasFormulasKillingIndustrial.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasKillingIndustrial.GravarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('KIN')
      .fGetInteger('KINNFM');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODIGO').AsString := 'ESP ' +
        TAutcomTintaFactory.Get.GetCodEmp + strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODIGO')
      .AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString := 'S';
  End
  Else
  Begin
    If Not(tela['chkAtivad']['Checked'].Value) Then
      GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString := 'N'
    else If (tela['chkAtivad']['Checked'].Value = True) Then
      GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString := 'S';
  End;

end;

procedure TCadastroNovasFormulasKillingIndustrial.GravarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmKIN: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoKillingIndustrialNovasFormulas.Create
      (GetQueryCadastro.FieldByName('NFM_CODIGO').AsString)
      as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);

    If Not tela.GetBlnAlterou Then
    Begin
      strNfmKIN := TStrUtils.fStrZero
        (IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('KIN').pSet('KINNFM', strNfmKIN);
    End;

  end;
end;

procedure TCadastroNovasFormulasKillingIndustrial.IncluirAntes
  (const tela: ITelaCadLibTintas; const strState: String);
begin
  inherited;

end;

procedure TCadastroNovasFormulasKillingIndustrial.IncluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnAtivarNfm']['Enabled'].Value := false;
  tela['dbeCodNfm']['Enabled'].Value := false;
  tela['chkAtivad']['Checked'].Value := True;
  tela['dbeDataCadastro']['Enabled'].Value := false;

  tela['edtDesMontadora']['Text'].Value := '';
  tela['edtDesLinha']['Text'].Value := '';


  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate := date;
  GetQueryCadastro.FieldByName('NFM_SISTEM').AsString := 'KILLING';

  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasKillingIndustrial.pAtivaCadKIN;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE KIN_CADKIN ' + '   SET KIN_ATIVO_ = :ATIVAD ' +
                ' WHERE KIN_CODIGO = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasKillingIndustrial.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE KIN_CADNFM           ' +
                '    SET NFM_ATIVO_ = :ATIVAD ' +
                '  WHERE NFM_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasKillingIndustrial.pAtivarDesativarNfm
  (const tela: ITelaCadLibTintas);
begin
  Try
    pAtivaNfm;
    pAtivaCadKIN;

    tela['edtDesMontadora']['Text'].Value := '';
    tela['edtDesLinha']['Text'].Value := '';
    tela['btnAtivarNfm']['Enabled'].Value := false;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!',
      'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName
      ('NFM_ATIVO_').AsString = 'S', 'Desativada', 'Ativada') +
      ' com sucesso !', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!',
        'Erro na hora de ' + TAutcomTintaFactory.Get.IIF
        (GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S', 'Desativar',
        'Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasKillingIndustrial.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasKillingIndustrial.pBotaoAtivarNfm
  (const tela: ITelaCadLibTintas);
begin
  tela['btnAtivarNfm']['Enabled'].Value := false;
  If Not GetQueryCadastro.IsEmpty Then
  Begin
    tela['btnAtivarNfm']['Enabled'].Value := VerificarNovaFormulaMovimentada;
    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF
      (tela['btnAtivarNfm']['Enabled'].Value,
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S', 'Desativar', 'Ativar'), 'Ativar');
  End;
end;

procedure TCadastroNovasFormulasKillingIndustrial.PesquisarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasKillingIndustrial.pSetaEnableReadOnly
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  //
end;

function TCadastroNovasFormulasKillingIndustrial.ValidarBase(const strCodBas
  : string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(' SELECT                     '
    + '   COUNT(0) AS QTD          ' + ' FROM                       ' +
    '   KIN_CADBAS               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
    ' WHERE BAS_CODBAS = :CODBAS ', 'QTD', [strCodBas]) > 0;
end;

function TCadastroNovasFormulasKillingIndustrial.ValidarBaseJaCadastrado
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

function TCadastroNovasFormulasKillingIndustrial.
  VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD ' +
        '  FROM %0:s ' + ' INNER JOIN KIN_CADKIN ON %1:s_ITETIN = KIN_MD5KEY ' +
        ' WHERE %1:s_IDEPRO = "KIN" ' + '   AND KIN_CODIGO = :CODNFM',
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
