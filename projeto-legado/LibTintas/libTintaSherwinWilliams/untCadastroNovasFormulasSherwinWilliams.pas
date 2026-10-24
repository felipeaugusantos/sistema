unit untCadastroNovasFormulasSherwinWilliams;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBMemoFocus,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasSherwinWilliams = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strCodBas: String): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    function ValidarBaseProKey(const strCodBas: String; strProKey: String): Boolean;
    function ValidarBaseSubKey(const strCodBas: String; strProKey: String;
      strSubKey: String; strCodUni: String; const tela: ITelaCadLibTintas): Boolean;

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadSHE;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;

    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Integer;
    function fRetDescUnidade(strCodUni: String): String;

    function fRetMenorUnidade(strProKey, strSubKey, strCodBas, strUnidad: String): String;
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
  end;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untDbeCodColKeyPressSherwinWilliams,
  untDbeCodProKeyPressNovasFormulasSherwinWilliams,
  untDbeCodEmbKeyPressNovasFormulasSherwinWilliams,
  untGravandoExecucaoSherwinWilliamsNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica, untTypesSistema,
  untDbeCodUniKeyPress, untDbeProKeyKeyPressNovasFormulasSherwinWilliams,
  untDbeSubKeyKeyPressNovasFormulasSherwinWilliams;
{ TCadastroNovasFormulasSherwinWilliams }

procedure TCadastroNovasFormulasSherwinWilliams.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 540;
  tela.GetSelf['Width'].Value := 820;
  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['dbeCodUni']['Enabled'].Value       := False;
  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;

  blnAtualizaUnidade := False;
  strUnidadeMenor := '';
end;

procedure TCadastroNovasFormulasSherwinWilliams.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasSherwinWilliams.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  pLimparQuantidades(GetQueryCadastro);
  tela['dbeCodUni']['Enabled'].Value       := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;
end;

procedure TCadastroNovasFormulasSherwinWilliams.AtivarNovasFormulas(
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

procedure TCadastroNovasFormulasSherwinWilliams.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroNovasFormulasSherwinWilliams.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código Form.:', 49, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 219, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código Base:', 86, 55, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 441, 55, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProdKey', 'Prod. Key:', 211, 55, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblSubKey', 'Sub. Key:', 328, 55, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 65, 78, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblObservacao', 'Observação:', 65, 102, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acrésc. Mão de obra:', 92, 164, 25, 14, 'taRightJustify'));

  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 130, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 13, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 140, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Onça:', 295, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 73,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_COL0' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressSherwinWilliams.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 203,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 355,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTD0' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 415, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 535, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Onça:', 690, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 475,
      22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_COL0' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressSherwinWilliams.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 595,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 750,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTD0' + TStrUtils.fStrZero(intCont, 2))
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

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 125, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODPRO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 301, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 125, 52, 85, 22, 'ttAlfanumerico', 'NFM_BASE__')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasSherwinWilliams.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 501, 52, 45, 22, 'ttAlfanumerico', 'NFM_UNIDAD')
    .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProkey', 271, 52, 50, 22, 'ttAlfanumerico', 'NFM_PROKEY')
    .AdicionarEvento(TDbeProKeyKeyPressNovasFormulasSherwinWilliams.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeSubkey', 390, 52, 50, 22, 'ttAlfanumerico', 'NFM_SUBKEY')
    .AdicionarEvento(TDbeSubKeyKeyPressNovasFormulasSherwinWilliams.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 125, 75, 420, 22, 'ttAlfanumerico', 'NFM_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBMemoFocus.Create('dbeObservacao', 125, 98, 420, 60, 'NFM_COMMEN')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 125, 160, 100, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 281, 164, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle((groupColorantes)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

end;

procedure TCadastroNovasFormulasSherwinWilliams.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM SHE_CADSHE WHERE SHE_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSherwinWilliams.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
end;

procedure TCadastroNovasFormulasSherwinWilliams.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
      DeletaNovaFormula(strCodNfmDel);
  end;
end;

function TCadastroNovasFormulasSherwinWilliams.fAjustarQuantidade(
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

function TCadastroNovasFormulasSherwinWilliams.fGetCampoChave(
  const index: Integer): string;
const
  arrCampos: array[0..4] of string = ('NFM_CODPRO', 'NFM_BASE__', 'NFM_PROKEY', 'NFM_SUBKEY', 'NFM_UNIDAD');
begin
  Result := arrCampos[index];
end;

function TCadastroNovasFormulasSherwinWilliams.fGetCountCamposChave: Integer;
begin
  Result := 5;
end;

procedure TCadastroNovasFormulasSherwinWilliams.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if LeftStr(strNomeCampo, Length('NFM_QTD0')) = 'NFM_QTD0' then
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

function TCadastroNovasFormulasSherwinWilliams.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasSherwinWilliams.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasSherwinWilliams.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;

end;

function TCadastroNovasFormulasSherwinWilliams.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'LT' Then
    Result := 'Litros'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

function TCadastroNovasFormulasSherwinWilliams.fRetDescUnidadesBase: String;
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
                '   SHE_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_PROKEY = :PROKEY     ' +
                '   AND BAS_SUBKEY = :SUBKEY     ' +
                '   AND BAS_BASE__ = :CODBAS     ';

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

  qryGen.ParamByName('PROKEY').AsString := GetQueryCadastro.FieldByName('NFM_PROKEY').AsString;
  qryGen.ParamByName('SUBKEY').AsString := GetQueryCadastro.FieldByName('NFM_SUBKEY').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_BASE__').AsString;

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
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

function TCadastroNovasFormulasSherwinWilliams.fRetFatorDivisaoUnidade(
  strUnidade: String): Integer;
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

function TCadastroNovasFormulasSherwinWilliams.fRetMenorUnidade(strProKey, strSubKey,
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
                '   FROM SHE_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PROKEY = :PROKEY    ' +
                '    AND BAS_SUBKEY = :SUBKEY    ' +
                '    AND BAS_BASE__ = :CODBAS    ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('PROKEY').AsString := strProKey;
  qryGen.ParamByName('SUBKEY').AsString := strSubKey;
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

function TCadastroNovasFormulasSherwinWilliams.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'SHE';
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

    If (Result) And (Not TStrUtils.fEmptyStr(strPedido)) Then
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

function TCadastroNovasFormulasSherwinWilliams.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;

  procedure CarregarDescricao;
  begin
    if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_DESCRI').AsString)
      and (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString)) then
    begin
      GetQueryCadastro.FieldByName('NFM_DESCRI').AsString :=
      VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo(
        ' SELECT                     ' +
        '   BAS_DESCRI               ' +
        ' FROM                       ' +
        '   SHE_CADBAS               ' +
        ' WHERE BAS_BASE__ = :CODBAS ' +
        '   AND BAS_PROKEY = :PROKEY ' +
        '   AND BAS_SUBKEY = :SUBKEY ' +
        '   AND BAS_UNIDAD = :CODUNI ',
        'BAS_DESCRI', [GetQueryCadastro.FieldByName('NFM_BASE__').AsString,
                       GetQueryCadastro.FieldByName('NFM_PROKEY').AsString,
                       GetQueryCadastro.FieldByName('NFM_SUBKEY').AsString,
                       GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString]), '');
    end;
  end;
begin
  Result := True;

  If strNomeCampo = 'NFM_BASE__' Then
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

  Else If strNomeCampo = 'NFM_PROKEY' Then
  Begin
    If (TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      strRetorno := 'É necessário preencher o campo "Prod. Key"!';
      Result := False;
    End
    Else If (Not ValidarBaseProKey(tela['dbeBase']['Text'].Value, strValorCampo)) Then
    Begin
      strRetorno := 'Esse "Prod. Key" não está cadastrado para essa base !';
      Result := False;
    End;
  End

  Else If strNomeCampo = 'NFM_SUBKEY' Then
  Begin
    If (TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      strRetorno := 'É necessário preencher o campo "Sub. Key"!';
      Result := False;
    End
    Else If (Not ValidarBaseSubKey(tela['dbeBase']['Text'].Value,
                                   tela['dbeProkey']['Text'].Value,
                                   strValorCampo,
                                   tela['dbeCodUni']['Text'].Value,
                                   tela)) Then
    Begin
      strRetorno := 'Esse "Sub. Key" não está cadastrado para essa base !';
      Result := False;
    End;
  End

  Else If strNomeCampo = 'NFM_DESCRI' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    end
  End

  Else if LeftStr(strNomeCampo, 8) = 'NFM_COL0' then
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
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDX' Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_COL0', [rfReplaceAll])).AsString) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade para continuar!';
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA') Or
        (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Then
      Begin
        If fGetValorPulsosMl(strValorCampo) Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada em ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA',
            'Onça', 'ML') + ' está incorreta!' + #13 + 'São aceitos apenas números inteiros ou decimais.';
        End
        Else If strToFloatDef(strValorCampo, 0) <= 0 Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada deve ser maior que Zero!';
        End
        Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA') Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_QTD0', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo);
        End
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_QTD0', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo) / 0.924;
        End;
      End;
    End
    Else If ((TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_COL0', [rfReplaceAll])).AsString)) And
      Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_COL0', 'NFM_QTDX', [rfReplaceAll])).AsString)) Then
    Begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    End;
  End
  Else if LeftStr(strNomeCampo, 8) = 'NFM_QTD0' then
  Begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTD0', 'NFM_COL0', [rfReplaceAll])).AsString) then
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
    else if (( TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTD0', 'NFM_COL0', [rfReplaceAll])).AsString) )
      and   ((not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_COL0', 'NFM_QTD0', [rfReplaceAll])).AsString)) And
             (strToFloatDef(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_COL0', 'NFM_QTD0', [rfReplaceAll])).AsString,0) > 0)) ) then
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

function TCadastroNovasFormulasSherwinWilliams.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
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

function TCadastroNovasFormulasSherwinWilliams.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                                        ';
  qryGen.SQL := qryGen.SQL + '    * FROM    ' + GetNomeTabela +   '           ';
  qryGen.SQL := qryGen.SQL + '  WHERE       ' + GetNomeCampo  +   ' = :NFM    ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasSherwinWilliams.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasSherwinWilliams.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasSherwinWilliams.GetNomeCampo: string;
begin
  Result := 'NFM_CODPRO';
end;

function TCadastroNovasFormulasSherwinWilliams.GetNomeCampoItem: string;
begin
  Result := 'NFM_COL0';
end;

function TCadastroNovasFormulasSherwinWilliams.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasSherwinWilliams.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasSherwinWilliams.GetNomeTabela: string;
begin
  Result := 'SHE_CADNFM';
end;

function TCadastroNovasFormulasSherwinWilliams.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasSherwinWilliams.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasSherwinWilliams.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasSherwinWilliams.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasSherwinWilliams.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('SHE').fGetInteger('NFMSHE');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODPRO').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString));

    GetQueryCadastro.FieldByName('NFM_EMBALA').AsFloat  := 1.0;

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasSherwinWilliams.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmSHE        : String;
  blnGerarUnidades : Boolean;
begin
  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoSherwinWilliamsNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString,
     blnGerarUnidades, blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);


    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmSHE := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('SHE').pSet('NFMSHE',strNfmSHE);
    End;
  end;
end;

procedure TCadastroNovasFormulasSherwinWilliams.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := 'LT';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := Date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'ONÇA';

  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeDataCadastro']['Enabled'].Value := false;
  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela.SelectNext;
end;

procedure TCadastroNovasFormulasSherwinWilliams.pAjustaQuantidade(
  strUnidade: String; const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intCont, 2)).AsFloat := StrToFloat(FormatFloat('#0.0000',StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasSherwinWilliams.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 182;
  tela['DBRadioGroup']['Width'].Value := 813;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 13;
  tela['DBRadioGroup']['Columns'].Value := 2;
  stlItems.Add('ONÇA');
  stlItems.Add('ML');
end;

procedure TCadastroNovasFormulasSherwinWilliams.pAtivaCadSHE;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE SHE_CADSHE ' +
                '   SET SHE_ATIVAD = :ATIVAD ' +
                ' WHERE SHE_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSherwinWilliams.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE SHE_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODPRO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSherwinWilliams.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadSHE;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasSherwinWilliams.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;


procedure TCadastroNovasFormulasSherwinWilliams.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
end;

procedure TCadastroNovasFormulasSherwinWilliams.pExisteUnidadeMenorCadastrada(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_UNIDAD                   ' +
                ' FROM                           ' +
                '   SHE_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_PROKEY = :PROKEY     ' +
                '   AND BAS_SUBKEY = :SUBKEY     ' +
                '   AND BAS_BASE__ = :CODBAS     ';

  qryGen.ParamByName('PROKEY').AsString := GetQueryCadastro.FieldByName('NFM_PROKEY').AsString;
  qryGen.ParamByName('SUBKEY').AsString := GetQueryCadastro.FieldByName('NFM_SUBKEY').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_BASE__').AsString;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((qryGen.FieldByName('BAS_UNIDAD').AsString = 'LT') And (GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString <> 'LT')) Then
    Begin
      strUnidadeMenor := 'LT';
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL') And (GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString <> 'GL') And
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

procedure TCadastroNovasFormulasSherwinWilliams.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM SHE_CADSHE        ';
  qryGen.SQL := qryGen.SQL + '  WHERE SHE_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('SHE_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasSherwinWilliams.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeCodNfm']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Checked'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeBase']['Enabled'].Value   := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDescri']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['gpbColorantes']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
end;

function TCadastroNovasFormulasSherwinWilliams.ValidarBase(const strCodBas: String): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                         ' +
      '   COUNT(0) AS QTD              ' +
      ' FROM                           ' +
      '   SHE_CADBAS                   ' +
      '   INNER JOIN CADITE            ' +
      '     ON BAS_CODITE = ITE_CODITE ' +
      ' WHERE BAS_BASE__ = :CODBAS     ' ,
      'QTD', [strCodBas]
    ) > 0;
  end;
end;

function TCadastroNovasFormulasSherwinWilliams.ValidarBaseProKey(
  const strCodBas: String; strProKey: String): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                         ' +
      '   COUNT(0) AS QTD              ' +
      ' FROM                           ' +
      '   SHE_CADBAS                   ' +
      '   INNER JOIN CADITE            ' +
      '     ON BAS_CODITE = ITE_CODITE ' +
      ' WHERE BAS_BASE__ = :CODBAS     ' +
      '   AND BAS_PROKEY = :PROKEY     ' ,
      'QTD', [strCodBas, strProKey]
    ) > 0;
  end;
end;

function TCadastroNovasFormulasSherwinWilliams.ValidarBaseSubKey(
  const strCodBas: String; strProKey: String; strSubKey: String;
  strCodUni: String; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) and
     (not TStrUtils.fEmptyStr(strProKey)) and
     (not TStrUtils.fEmptyStr(strSubKey)) and
     (not TStrUtils.fEmptyStr(strCodUni)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                         ' +
      '   COUNT(0) AS QTD              ' +
      ' FROM                           ' +
      '   SHE_CADBAS                   ' +
      '   INNER JOIN CADITE            ' +
      '     ON BAS_CODITE = ITE_CODITE ' +
      ' WHERE BAS_BASE__ = :CODBAS     ' +
      '   AND BAS_PROKEY = :PROKEY     ' +
      '   AND BAS_SUBKEY = :SUBKEY     ' +
      '   AND BAS_UNIDAD = :CODUNI     ',
      'QTD', [strCodBas, strProKey, strSubKey, strCodUni]
    ) > 0;

    If Not Result Then
    Begin
      GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := fRetMenorUnidade(strProKey, strSubKey, strCodBas, strCodUni);
      Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
    End;
  end;
end;

function TCadastroNovasFormulasSherwinWilliams.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   SHE_CADCOL               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasSherwinWilliams.ValidarColoranteJaCadastrado(
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

function TCadastroNovasFormulasSherwinWilliams.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN SHE_CADSHE ON %1:s_ITETIN = SHE_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "SHE" '+
                                                 '   AND SHE_CODIGO = :CODNFM', [GetQueryCadastro.FieldByName('NFM_CODPRO').AsString]);
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


