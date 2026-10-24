unit untCadastroNovasFormulasSuvinil;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas,
  untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteSuvinil,
  untAutcomTintaFactory, untIDataSet,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes;

type
  TCadastroNovasFormulasSuvinil = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intCodNfm: Integer;

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strCodPro, strUnidad, strCodBas: string; const tela: ITelaCadLibTintas): Boolean;
    function ValidarCodFml(const strCodPro: string): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadSuv;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;

    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Integer;
    function fRetDescUnidade(strCodUni: String): String;
    function fRetMenorUnidade(strCodFml, strCodBas, strUnidad: String): String;
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
  end;

  TChkEmbDifOnClick = class(TAbstractLibTintaControleVisualEvento)
  published
    procedure OnClick(Sender: TObject);
  end;

  TBtnEmbalagensOnClick = class(TAbstractLibTintaControleVisualEvento)
  published
    procedure OnClick(Sender: TObject);
  end;

implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasSuvinil, untDbeCodColKeyPressSuvinil,
  untNovasFormulasEmbalagens, untDbeCodProKeyPressNovasFormulasSuvinil,
  untGravandoExecucaoSuvinilNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica, untTypesSistema,
  untDbeCodBasKeyPressNovasFormulasSuvinil;
{ TCadastroNovasFormulasSuvinil }

procedure TCadastroNovasFormulasSuvinil.AjustarTela
  (const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 487;
  tela.GetSelf['Width'].Value := 780;

  tela['btnAtivarNfm']['Visible'].Value := True;
  tela['dbeUnidad']['Enabled'].Value := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;

  blnAtualizaUnidade := False;
  strUnidadeMenor := '';
end;

procedure TCadastroNovasFormulasSuvinil.AlterarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasSuvinil.AlterarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeUnidad']['Enabled'].Value := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  pLimparQuantidades(GetQueryCadastro);
end;

procedure TCadastroNovasFormulasSuvinil.AtivarNovasFormulas
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString)) And (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S',
      'Desativar', 'Ativar') + ' essa nova fórmula ?', ['&Sim', '&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;
  End;
end;

procedure TCadastroNovasFormulasSuvinil.CarregarDescricoes
  (const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroNovasFormulasSuvinil.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código Form.:', 8, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadatro', 'Data Cadastro:', 181, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código Base:', 45, 55, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblReferencia', 'Referência:', 24, 78, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblBase', 'Base:', 152, 55, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 256, 55, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acréscimo mão de obra:', 100, 100, 25, 14, 'taRightJustify'));

  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 113, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2), Format('Código %.2d:',
      [intCont]), 8, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2), 'Quantidade:', 120,
      (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2), 'Quantidade Pulso:', 270,
      (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' +TStrUtils.fStrZero(intCont, 2), 68,
      22 * intCont, 45, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressSuvinil.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2))));

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
      .AdicionarEvento(TDbeCodColKeyPressSuvinil.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2))));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' +TStrUtils.fStrZero(intCont, 2), 580,
      22 * (intCont - 10), 45, 22,'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' +TStrUtils.fStrZero(intCont, 2), 720,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase','ecUpperCase')));

  end;

  groupColorantes.AdicionarControle(TLibTintaControleVisualImplementacao.Create
    (' object Label5: TLabel                                  ' +
    '   Left = 80                                             ' +
    '   Top = 0                                               ' +
    '   Width = 460                                           ' +
    '   Height = 14                                           ' +
    '   Alignment = taRightJustify                            ' +
    '   AutoSize = False                                      ' +
    '   Caption = ''A quantidade dos colorantes deve ser informada sempre no volume padrão LITRO'' '
    + '   Color = clTeal                                      ' +
    '   Font.Charset = ANSI_CHARSET                           ' +
    '   Font.Color = clRed                                    ' +
    '   Font.Height = 14                                      ' +
    '   Font.Name = ''Arial''                                 ' +
    '   Font.Pitch = fpVariable                               ' +
    '   Font.Style = [fsBold]                                 ' +
    '   ParentColor = False                                   ' +
    '   ParentFont = False                                    ' +
    ' end                                                     '));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 84, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODNFM'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 260, 28, 60, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodPro', 84, 52, 85, 22, 'ttAlfanumerico', 'NFM_CODPRO')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasSuvinil.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase',212, 52, 32, 22, 'ttAlfanumerico', 'NFM_BASE__')
    .AdicionarEvento(TDbeCodBasKeyPressNovasFormulasSuvinil.Create('OnKeyPress',Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeUnidad', 316, 52, 45, 22, 'ttAlfanumerico', 'NFM_UNIDAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 84, 75, 389, 22, 'ttAlfanumerico', 'NFM_DESCRI'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 125, 97, 100, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkEmbDif',  320, 107, 148, 17, 'Embalagens diferenciadas', 'NFM_EMBDIF', 'S', 'N')
    .AdicionarEvento(TChkEmbDifOnClick.Create('OnClick', Self)));

  AdicionarControle(TLibTintaControleVisualImplementacao.Create
    (' object btnEmbalagens: TBitBtn                                       ' +
    '   Left = 474                                                         ' +
    '   Top = 103                                                          ' +
    '   Width = 98                                                         ' +
    '   Height = 25                                                        ' +
    '   Caption = ''Embalagens''                                           ' +
    '   TabOrder = 9                                                       ' +
    '   Glyph.Data = {                                                     ' +
    '     76010000424D7601000000000000760000002800000020000000100000000100 ' +
    '     04000000000000010000130B0000130B00001000000000000000000000000000 ' +
    '     800000800000008080008000000080008000808000007F7F7F00BFBFBF000000 ' +
    '     FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333 ' +
    '     333333333333333333FF33333333333330003FF3FFFFF3333777003000003333 ' +
    '     300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333 ' +
    '     330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000 ' +
    '     333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000 ' +
    '     339977FF777777773377000BFB03333333337773FF733333333F333000333333 ' +
    '     3300333777333333337733333333333333003333333333333377333333333333 ' +
    '     333333333333333333FF33333333333330003333333333333777333333333333 ' +
    '     3000333333333333377733333333333333333333333333333333}            ' +
    '   NumGlyphs = 2                                                      ' +
    ' end                                                                  ')
    .AdicionarEvento(TBtnEmbalagensOnClick.Create('OnClick', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad',
    240, 107, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('TabOrder', '9')));

  AdicionarControle(groupColorantes);
end;

procedure TCadastroNovasFormulasSuvinil.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM SUV_CADSUV WHERE LEFT(SUV_DESCRI, 12) = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSuvinil.ExcluirAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasSuvinil.ExcluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
end;

function TCadastroNovasFormulasSuvinil.fAjustarQuantidade
  (strUnidade: String): Boolean;
begin
  Result := False;
  blnAtualizaUnidade := False;
  If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Existe uma nova unidade cadastrada para a base selecionada,' + #13#10 +
                                       'essa unidade é inferior a atual cadastrada na nova fórmula.' + #13#10 +
                                       'Deseja atualizar para a unidade nova ?' + #13#10 + 'Unidade Atual : ' +
                                       GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString + #13#10 +
                                       'Unidade Nova  : ' + strUnidade, ['&Sim', '&Não']) = 1 Then
  Begin
    Result := True;
    blnAtualizaUnidade := True;
  End;
end;

function TCadastroNovasFormulasSuvinil.fGetCampoChave
  (const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasSuvinil.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasSuvinil.FormatarCampo(const strNomeCampo
  : string; var arrPropriedades: TCadLibTintasStringArray;
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

function TCadastroNovasFormulasSuvinil.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasSuvinil.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasSuvinil.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.', ['&OK']);
    Result := False;
  end;

end;

function TCadastroNovasFormulasSuvinil.fRetDescUnidade
  (strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'LT' Then
    Result := 'Litros'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'BD' Then
    Result := 'Balde'
  Else If Pos(strCodUni, 'LA_1J_2J_3J_4J_5J_6J_') > 0 Then
    Result := 'Lata';
end;

function TCadastroNovasFormulasSuvinil.fRetDescUnidadesBase: String;
var
  qryGen: IDataSet;
  strMens: String;
begin
  Result := '';

  strMens := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
    '   SUV_CODUNI                   ' + ' FROM                           ' +
    '   SUV_CADBAS                   ' + '  INNER JOIN CADITE             ' +
    '     ON ITE_CODITE = SUV_CODITE ' + ' WHERE SUV_CODFML = :CODFML     ' +
    '   AND SUV_CODBAS = :CODBAS     ';

  If (Not blnAtualizaUnidade) And
    (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND SUV_CODUNI <> :CODUNI ';

  qryGen.ParamByName('CODFML').AsString := GetQueryCadastro.FieldByName
    ('NFM_CODPRO').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName
    ('NFM_BASE__').AsString;

  If (Not blnAtualizaUnidade) And
    (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('SUV_CODUNI').AsString = 'LT' Then
      Result := Result + 'Litro';

    If qryGen.FieldByName('SUV_CODUNI').AsString = 'GL' Then
      Result := Result + 'Galao';

    If Pos(qryGen.FieldByName('SUV_CODUNI').AsString, 'LA_1J_2J_3J_4J_5J_6J_') > 0 Then
      Result := Result + 'Lata';

    If qryGen.FieldByName('SUV_CODUNI').AsString = 'BD' Then
      Result := Result + 'Balde';

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
    Else If (qryGen.RecordCount = 3) And (Pos('Litro', Result) > 0) Then
      strMens := strMens + 'Galão e '
    Else If qryGen.RecordCount = 3 Then
      strMens := strMens + 'Galão, '
    Else If qryGen.RecordCount > 3 Then
      strMens := strMens + 'Galão, ';
  End;

  If Pos('Balde', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Balde '
    Else If (qryGen.RecordCount = 2) And (Pos('Litro', Result) <= 0) And (Pos('Galao', Result) <= 0)Then
      strMens := strMens + 'Balde e '
    Else If qryGen.RecordCount = 2 Then
      strMens := strMens + 'Balde '
    Else If (qryGen.RecordCount = 3) And (Pos('Litro', Result) > 0) And (Pos('Galao', Result) <= 0) Then
      strMens := strMens + 'Balde e '
    Else If qryGen.RecordCount > 3 Then
      strMens := strMens + 'Balde e '
    Else If (qryGen.RecordCount = 3) And (Pos('Litro', Result) <= 0) Then
      strMens := strMens + 'Balde e '
    Else If qryGen.RecordCount = 3 Then
      strMens := strMens + 'Balde ';
  End;

  If Pos('Lata', Result) > 0 Then
  Begin
    strMens := strMens + 'Lata ';
  End;

  Result := strMens;
end;

function TCadastroNovasFormulasSuvinil.fRetFatorDivisaoUnidade
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

function TCadastroNovasFormulasSuvinil.fRetMenorUnidade(strCodFml, strCodBas,
  strUnidad: String): String;
var
  qryGen: IDataSet;
  strLitro, strGalao, strLata, strBalde: String;
begin
  Result := strUnidad;

  strLitro := '';
  strGalao := '';
  strLata := '';
  strBalde := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT SUV_CODUNI              ' +
    '   FROM SUV_CADBAS              ' + '  INNER JOIN CADITE             ' +
    '     ON ITE_CODITE = SUV_CODITE ' + '  WHERE SUV_CODFML = :CODFML    ' +
    '    AND SUV_CODBAS = :CODBAS    ' + '  ORDER BY SUV_CODUNI DESC      ';
  qryGen.ParamByName('CODFML').AsString := strCodFml;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('SUV_CODUNI').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('SUV_CODUNI').AsString
    Else If qryGen.FieldByName('SUV_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('SUV_CODUNI').AsString
    Else If Pos(qryGen.FieldByName('SUV_CODUNI').AsString, 'LA_1J_2J_3J_4J_5J_6J_') > 0 Then
      strLata := qryGen.FieldByName('SUV_CODUNI').AsString
    Else If qryGen.FieldByName('SUV_CODUNI').AsString = 'BD' Then
      strBalde := qryGen.FieldByName('SUV_CODUNI').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strBalde)) Then
    Result := strBalde
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;

function TCadastroNovasFormulasSuvinil.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'SUV';
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

function TCadastroNovasFormulasSuvinil.fValidaCampos
  (const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
Var
  strCampoQtd: String;
  strValorCampoQtd: String;
  intY: Integer;

  procedure CarregarDescricao;
  begin
    if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_DESCRI').AsString)
      and (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString)) and
      (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString)) then
    begin
      GetQueryCadastro.FieldByName('NFM_DESCRI').AsString :=VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo
        (' SELECT                     ' + '   SUV_DESCRI               ' +
         ' FROM                       ' + '   SUV_CADBAS               ' +
         ' WHERE SUV_CODFML = :CODFML ' + '   AND SUV_CODUNI = :CODUNI ',
         'SUV_DESCRI', [GetQueryCadastro.FieldByName('NFM_CODPRO').AsString,
         GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString]), '');
    end;
  end;

Begin
  Result := True;

  If strNomeCampo = 'NFM_CODPRO' Then
  begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Código Base"!';
    End
    Else If Not ValidarCodFml(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'Base não encontrada!';
    End
    Else
      CarregarDescricao;
  End
  Else If strNomeCampo = 'NFM_BASE__' Then
  begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Base"!';
    End
    Else If Not ValidarBase(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString,GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString, strValorCampo,
      tela) Then
    Begin
      Result := False;
      strRetorno := 'Base não encontrada!';
    End
    Else
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
  Else If LeftStr(strNomeCampo, 8) = 'NFM_FORM' Then
  begin
    If TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) Then
    Begin
      Result := False;
      strRetorno := 'É necessário digitar pelo menos 1 colorante!';
    End
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    begin
      If Not ValidarColorante(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'Colorante não encontrado!';
      End
      Else If Not ValidarColoranteJaCadastrado(tela, strValorCampo,
        strNomeCampo) Then
      Begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse Colorante já está cadastrado para essa nova fórmula!', ['&Ok']);
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
      If strToFloatDef(strValorCampoQtd, -1) > 0 Then
      Begin
        Result := False;
        strRetorno :=
          'A quantidade do colorante foi informada. Por favor, informe seu código.';
      End;
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
            'Pulso', 'ML') + ' está incorreta!' + #13 + 'São aceitos apenas números inteiros.';
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
    Else If ((TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_FORM', [rfReplaceAll])).AsString)) And
      Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDX', [rfReplaceAll])).AsString)) Then
    Begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDC' Then
  begin
    If Not TStrUtils.fEmptyStr
      (GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC',
      'NFM_FORM', [rfReplaceAll])).AsString) then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade do colorante!';
      End
      Else if strToFloatDef(strValorCampo, 0) <= 0 Then
      Begin
        Result := False;
        strRetorno := 'A quantidade do colorante deve ser maior que Zero!';
      End;
    End;
  End
  Else If Not(fValidarPreenchimentoCol(tela)) Then
  Begin
    Result := False;
    strRetorno :=
      'Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  End;
End;

function TCadastroNovasFormulasSuvinil.fValidarPreenchimentoCol
  (const tela: ITelaCadLibTintas): Boolean;
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

function TCadastroNovasFormulasSuvinil.fVerificaNovFormulas
  (strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT        ' + '    * FROM ' + GetNomeTabela
    + '  ' + '  WHERE   ' + GetNomeCampo + ' = :NFM     ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasSuvinil.GetCamposDesabilitadosEdit
  : TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasSuvinil.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasSuvinil.Create;
end;

function TCadastroNovasFormulasSuvinil.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasSuvinil.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasSuvinil.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasSuvinil.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasSuvinil.GetNomeTabela: string;
begin
  Result := 'SUV_CADNFM';
end;

function TCadastroNovasFormulasSuvinil.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasSuvinil.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasSuvinil.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasSuvinil.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasSuvinil.GravarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intCodNfm := TAutcomTintaFactory.Get.fGetConfTinta('SUV').fGetInteger('NFMSUV');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intCodNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' +
        TAutcomTintaFactory.Get.GetCodEmp + strCodNfm;

      Inc(intCodNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasSuvinil.GravarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmSuv: String;
  blnGerarUnidades: Boolean;
begin
  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoSuvinilNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString, blnGerarUnidades, blnAtualizaUnidade,
      strUnidadeMenor) as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);

    If Not tela.GetBlnAlterou Then
    Begin
      strNfmSuv := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intCodNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('SUV').pSet('NFMSUV', strNfmSuv);
    End;
  end;
end;

procedure TCadastroNovasFormulasSuvinil.IncluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := 'LT';
  GetQueryCadastro.FieldByName('NFM_EMBDIF').AsString := 'N';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate := date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'PULSO';

  tela['dbeCodNfm']['Enabled'].Value := False;
  tela['dbeUnidad']['Enabled'].Value := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela['chkAtivad']['Checked'].Value := True;
  tela['chkEmbDif']['Enabled'].Value := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasSuvinil.pAjustaQuantidade(strUnidade: String;
  const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat := StrToFloat(FormatFloat('#0.00',
        StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasSuvinil.pAjustarRadioGroup
  (const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 129;
  tela['DBRadioGroup']['Width'].Value := 773;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 11;
  tela['DBRadioGroup']['Columns'].Value := 4;
  stlItems.Add('ONÇA AMERICANA');
  stlItems.Add('ONÇA INGLESA');
  stlItems.Add('PULSO');
  stlItems.Add('ML');
end;

procedure TCadastroNovasFormulasSuvinil.pAtivaCadSuv;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE SUV_CADSUV ' +
                '   SET SUV_ATIVAD = :ATIVAD ' +
                ' WHERE LEFT(SUV_DESCRI, 12) = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSuvinil.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE SUV_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'N', 'S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSuvinil.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadSuv;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName
      ('NFM_ATIVAD').AsString = 'S', 'Desativada', 'Ativada') +' com sucesso !', ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF
        (GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S', 'Desativar', 'Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasSuvinil.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasSuvinil.PesquisarDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
end;

procedure TCadastroNovasFormulasSuvinil.pExisteUnidadeMenorCadastrada
  (const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
    '   SUV_CODUNI                   ' + ' FROM                           ' +
    '   SUV_CADBAS                   ' + '  INNER JOIN CADITE             ' +
    '     ON ITE_CODITE = SUV_CODITE ' + ' WHERE SUV_CODFML = :CODFML     ' +
    '   AND SUV_CODBAS = :CODBAS     ';

  qryGen.ParamByName('CODFML').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_BASE__').AsString;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((qryGen.FieldByName('SUV_CODUNI').AsString = 'LT') And
      (GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString <> 'LT')) Then
    Begin
      strUnidadeMenor := 'LT';
      Break;
    End
    Else If ((qryGen.FieldByName('SUV_CODUNI').AsString = 'GL') And
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

procedure TCadastroNovasFormulasSuvinil.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM SUV_CADSUV        ';
  qryGen.SQL := qryGen.SQL + '  WHERE SUV_DESCRI = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('SUV_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasSuvinil.pSetaEnableReadOnly
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnEmbalagens']['Enabled'].Value :=
    MatchStr(strState, ['dsEdit', 'dsInsert'])
end;

function TCadastroNovasFormulasSuvinil.ValidarBase(const strCodPro, strUnidad,
  strCodBas: string; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodPro)) and
    (not TStrUtils.fEmptyStr(strUnidad)) and (not TStrUtils.fEmptyStr(strCodBas))
  then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo
      (' SELECT                     ' + '   COUNT(0) AS QTD          ' +
      ' FROM                       ' + '   SUV_CADBAS               ' +
      '  INNER JOIN CADITE             ' + '     ON ITE_CODITE = SUV_CODITE ' +
      ' WHERE SUV_CODFML = :CODFML ' + '   AND SUV_CODUNI = :CODUNI ' +
      '   AND SUV_CODBAS = :CODBAS ', 'QTD', [strCodPro, strUnidad,
      strCodBas]) > 0;

    If Not Result Then
    Begin
      GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := fRetMenorUnidade(strCodPro, strCodBas, strUnidad);
      tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
    End;
  end;
end;

function TCadastroNovasFormulasSuvinil.ValidarCodFml(const strCodPro
  : string): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodPro)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   COUNT(0) AS QTD          ' +
      ' FROM                       ' +
      '   SUV_CADBAS               ' +
      '  INNER JOIN CADITE             ' +
      '     ON ITE_CODITE = SUV_CODITE ' +
      ' WHERE SUV_CODFML = :CODFML ', 'QTD', [strCodPro]) > 0;
  end;
end;

function TCadastroNovasFormulasSuvinil.ValidarColorante(const strCodCol
  : string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   SUV_CADCOL               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ', 'QTD', [strCodCol]) > 0;
end;

function TCadastroNovasFormulasSuvinil.ValidarColoranteJaCadastrado
  (const tela: ITelaCadLibTintas; const strCodCol, strNomCam: string): Boolean;
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

function TCadastroNovasFormulasSuvinil.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada
        ('SELECT COUNT(0) AS QTD FROM %0:s INNER JOIN SUV_CADSUV ON %1:s_ITETIN = SUV_MD5KEY WHERE %1:s_IDEPRO = "SUV" AND LEFT(SUV_DESCRI,12) = :CODNFM',
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

{ TChkEmbDifOnClick }

procedure TChkEmbDifOnClick.OnClick(Sender: TObject);
begin
  tela['btnEmbalagens']['Enabled'].Value := tela['chkEmbDif']['Checked'].Value;
end;

{ TBtnEmbalagensOnClick }

procedure TBtnEmbalagensOnClick.OnClick(Sender: TObject);
var
  frm: TfrmNovasFormulasEmbalagens;
begin
  frm := nil;
  Try
    Try
      frm := TfrmNovasFormulasEmbalagens.Create(nil,
        cadastro.GetQueryCadastro.FieldByName('NFM_CODNFM').AsString,
        cadastro.GetQueryCadastro.FieldByName('NFM_BASE__').AsString,
        cadastro.GetQueryCadastro.FieldByName('NFM_CODPRO').AsString);
      frm.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frm) then
      FreeAndNil(frm);
  End;
end;

end.

