unit untCadastroNovasFormulasSherwinWilliams2;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteSherwinWilliams2, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasSherwinWilliams2 = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strCodBas: string): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadSHW;
    procedure pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
    procedure pAtualizaNfm;

//    function ValidarProduto(strCodBas, strUnidad, strProduto : String; const tela: ITelaCadLibTintas): Boolean;

    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Integer;
    function fRetDescUnidade(strCodUni: String): String;

//    function fRetMenorUnidade(strProduto, strCodBas, strUnidad: String): String;
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
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure CancelarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

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

    procedure pLimparQuantidades(GetQueryCadastro: IDataSet); Override;
  end;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasSherwinWilliams2, untDbeCodColKeyPressSherwinWilliams2,
  untDbeCodProKeyPressNovasFormulasSherwinWilliams2,
  untGravandoExecucaoSherwinWilliams2NovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica, untTypesSistema,
  untDbeCodUniKeyPress, untDbeCodBasKeyPressNovasFormulasSherwinWilliams2,
  untDbeProdutoKeyPressSherwinWilliams2;
{ TCadastroNovasFormulasSherwinWilliams2 }

procedure TCadastroNovasFormulasSherwinWilliams2.AjustarTela(const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 520;
  tela.GetSelf['Width'].Value := 810;

  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['dbeDataCadastro']['Enabled'].Value := false;
  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeProduto']['Enabled'].Value      := false;
  tela['dbeCodNfm']['Enabled'].Value       := false;

  pBotaoAtivarNfm(tela);

  blnAtualizaUnidade := false;
  strUnidadeMenor    := '';
end;

procedure TCadastroNovasFormulasSherwinWilliams2.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
end;

procedure TCadastroNovasFormulasSherwinWilliams2.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);

  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeCodNfm']['Enabled'].Value       := false;
  tela['dbeDataCadastro']['Enabled'].Value := false;
  tela['dbeProduto']['Enabled'].Value      := false;
  tela['dbeBase']['Enabled'].Value         := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDescri']['Enabled'].Value       := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeObserv']['Enabled'].Value       := MatchStr(strState, ['dsEdit', 'dsInsert']);
  pLimparQuantidades(GetQueryCadastro);
End;

procedure TCadastroNovasFormulasSherwinWilliams2.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm(tela);
      pAtualizaNfm;
    End;
  End;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasSherwinWilliams2.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
end;

procedure TCadastroNovasFormulasSherwinWilliams2.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código Form.:', 41, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 206, 31, 73, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Base:', 78, 54, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 399, 54, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto', 'Produto:', 188, 54, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 57, 77, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblObservacao', 'Observação:', 57, 100, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acrésc. Mão de obra:', 89, 123, 25, 14, 'taRightJustify'));

  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 150, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 25, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 155, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Ml:', 295, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 85,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressSherwinWilliams2.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 215,
      22 * intCont, 55, 22, 'ttNumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 355,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 430, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 550, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Ml:', 680, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 490,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressSherwinWilliams2.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 610,
      22 * (intCont - 10), 45, 22, 'ttNumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 740,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  groupColorantes.AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object Label5: TLabel                                  ' +
    '   Left = 80                                            ' +
    '   Top = 0                                              ' +
    '   Width = 470                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taLeftJustify                           ' +
    '   AutoSize = false                                     ' +
    '   Caption = ''A quantidade dos colorantes deve ser informada sempre no volume padrão QUARTO'' ' +
    '   Color = clTeal                                       ' +
    '   Font.Charset = ANSI_CHARSET                          ' +
    '   Font.Color = clRed                                   ' +
    '   Font.Height = 14                                     ' +
    '   Font.Name = ''Arial''                                ' +
    '   Font.Pitch = fpVariable                              ' +
    '   Font.Style = [fsBold]                                ' +
    '   ParentColor = false                                  ' +
    '   ParentFont = false                                   ' +
    ' end                                                    '
  ));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 117, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODIGO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 283, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 117, 51, 80, 22, 'ttAlfanumerico', 'NFM_BASE__')
    .AdicionarEvento(TDbeCodBasKeyPressNovasFormulasSherwinWilliams2.Create('OnKeyPress', Self))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 0))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProduto', 251, 51, 160, 22, 'ttAlfanumerico', 'NFM_PRODUT')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 1))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 461, 51, 45, 22, 'ttAlfanumerico', 'NFM_CODUNI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 2))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 117, 74, 389, 22, 'ttAlfanumerico', 'NFM_DESCRI')
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 3))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeObserv', 117, 97, 389, 22, 'ttAlfanumerico', 'NFM_OBSERV')
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 4))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 117, 120, 100, 22, 'ttNumerico', 'NFM_ACRMOB')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 5)));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 233, 122, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 6))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));

  AdicionarControle((groupColorantes)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false)));

end;

procedure TCadastroNovasFormulasSherwinWilliams2.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM SHW_CADSHW WHERE SHW_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pBotaoAtivarNfm(
  const tela: ITelaCadLibTintas);
begin
  tela['btnAtivarNfm']['Enabled'].Value := false;
  If Not GetQueryCadastro.IsEmpty Then
  Begin
    tela['btnAtivarNfm']['Enabled'].Value := VerificarNovaFormulaMovimentada;
    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(tela['btnAtivarNfm']['Enabled'].Value,
                            TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar'),'Ativar');
  End;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
      DeletaNovaFormula(strCodNfmDel);

  end;
end;

function TCadastroNovasFormulasSherwinWilliams2.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasSherwinWilliams2.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.FormatarCampo(
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
    arrValores[0] := '0.000';
    arrValores[1] := '0.000';
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

function TCadastroNovasFormulasSherwinWilliams2.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasSherwinWilliams2.fPodeAlterar: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
    If Not fPermiteAlterarNfmVendida Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel alterá-la.',['&OK']);
      Result := false;
    End
    Else
    Begin
      If Not FTemPedidoNfm() Then
        Result := False;
    End;
  end;
end;

function TCadastroNovasFormulasSherwinWilliams2.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := false;
  end;
end;

{function TCadastroNovasFormulasSherwinWilliams2.fProdutoExiste(strProduto: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen     := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DISTINCT 1 FIRST'+
                '  FROM SHW_CADBAS'+
                ' WHERE BAS_PRODUT =:PRODUT';
  qryGen.ParamByName('PRODUT').AsString := strProduto;
  qryGen.Open;

  Result := not(qryGen.IsEmpty);
end;
 }
function TCadastroNovasFormulasSherwinWilliams2.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;

  procedure CarregarDescricao;
  begin

  end;
begin
  Result := True;

  if strNomeCampo = 'NFM_BASE__' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := false;
      strRetorno := 'É necessário preencher o campo "Código Base"!';
    end
    else if not ValidarBase(strValorCampo) then
    begin
      Result := false;
      strRetorno := 'Base não encontrada!';
    end
    else
      CarregarDescricao;
  end

  else if strNomeCampo = 'NFM_PRODUT' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := false;
      strRetorno := 'É necessário preencher o campo "Produto"!';
    end
   { else
    If Not fProdutoExiste(strValorCampo) Then
    Begin
      Result := false;
      strRetorno := 'A Produto informada não é válida!';
    End
    else if not ValidarProduto(GetQueryCadastro.FieldByName('NFM_BASE__').AsString,
                               GetQueryCadastro.FieldByName('NFM_CODUNI').AsString,
                               strValorCampo,
                               tela) then
    begin
      Result := false;
      strRetorno := 'Produto não encontrada!';
    end
    else
      CarregarDescricao;
      }
  end

  else if strNomeCampo = 'NFM_DESCRI' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := false;
      strRetorno := 'É necessário preencher o campo "Descrição"!';
    end
  end

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

  else if LeftStr(strNomeCampo, 8) = 'NFM_FORM' then
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) then
    begin
      Result := false;
      strRetorno := 'É necessário digitar pelo menos 1 colorante!';
    end
    else if not TStrUtils.fEmptyStr(strValorCampo) then
    begin
      if not ValidarColorante(strValorCampo) then
      begin
        Result := false;
        strRetorno := 'Colorante não encontrado!';
      end
      else if not ValidarColoranteJaCadastrado(tela, strValorCampo, strNomeCampo) then
      begin
        Result := false;
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
        Result := false;
        strRetorno := 'A quantidade do colorante foi informada. Por favor, informe seu código.';
      end;
    end;
  end
  Else If strNomeCampo = 'NFM_TIPQTD' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário digitar o tipo da quantidade para continuar!';
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
      Else If strToFloatDef(strValorCampo, 0) <= 0 Then
      Begin
        Result := False;
        strRetorno := 'A Quantidade deve ser maior que Zero!';
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA') Then
      Begin
        GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
          fCalculaOncaParaMl('ONÇA', strValorCampo);
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Then
      Begin
        GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDC', [rfReplaceAll])).AsFloat :=
          fCalculaOncaParaMl('ML', strValorCampo);
      End;
    End;
  End
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDC' then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll])).AsString) then
    begin
      if TStrUtils.fEmptyStr(strValorCampo) then
      begin
        Result := false;
        strRetorno := 'É necessário digitar a quantidade do colorante!';
      end
      else if strToFloatDef(strValorCampo, 0) <= 0 then
      begin
        Result := false;
        strRetorno := 'A quantidade do colorante deve ser maior que Zero!';
      end;
    end
    else if (( TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll])).AsString) )
      and   ((not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll])).AsString)) And
             (strToFloatDef(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll])).AsString,0) > 0)) ) then
    begin
        Result := false;
        strRetorno := 'É necessário informar o colorante!';
    end
  end
  else if not(fValidarPreenchimentoCol(tela)) then
  begin
    Result     := false;
    strRetorno :='Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  end;
end;

function TCadastroNovasFormulasSherwinWilliams2.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
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

function TCadastroNovasFormulasSherwinWilliams2.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
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

function TCadastroNovasFormulasSherwinWilliams2.fRetDescUnidadesBase: String;
var
  qryGen: IDataSet;
  strMens: String;
begin
  Result := '';

  strMens := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_CODUNI                   ' +
                ' FROM                           ' +
                '   SHW_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_PRODUT = "'+GetQueryCadastro.FieldByName('NFM_PRODUT').AsString+'"'+
                '   AND BAS_CODBAS = "'+GetQueryCadastro.FieldByName('NFM_BASE__').AsString+'"';

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_CODUNI <> :CODUNI ';

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('BAS_CODUNI').AsString = 'QT' Then
      Result := Result + 'Quarto';

    If qryGen.FieldByName('BAS_CODUNI').AsString = 'GL' Then
      Result := Result + 'Galao';

    If qryGen.FieldByName('BAS_CODUNI').AsString = 'LA' Then
      Result := Result + 'Lata';

    qryGen.Next;
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

procedure TCadastroNovasFormulasSherwinWilliams2.pExisteUnidadeMenorCadastrada(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_CODUNI                   ' +
                ' FROM                           ' +
                '   SHW_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_PRODUT = :PRODUT ' +
                '   AND BAS_CODBAS = :CODBAS ';

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_BASE__').AsString;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((qryGen.FieldByName('BAS_CODUNI').AsString = 'QT') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'QT')) Then
    Begin
      strUnidadeMenor := 'QT';
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_CODUNI').AsString = 'GL') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'GL') And
        (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'QT')) Then
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

procedure TCadastroNovasFormulasSherwinWilliams2.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM SHW_CADSHW        ';
  qryGen.SQL := qryGen.SQL + '  WHERE SHW_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('SHW_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pLimparQuantidades(
  GetQueryCadastro: IDataSet);
Var
  intContador: Integer;
begin
  For intContador := 1 To 20 Do
  Begin
    If GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intContador, 2)).AsFloat = 0 Then
      GetQueryCadastro.FieldByName('NFM_QTDX' + TStrUtils.fStrZero(intContador, 2)).AsString := '';
  End;
end;

function TCadastroNovasFormulasSherwinWilliams2.fAjustarQuantidade(
  strUnidade: String): Boolean;
begin
  Result := false;
  blnAtualizaUnidade := false;
  If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Existe uma nova unidade cadastrada para a base selecionada,' + #13#10 +
                                                  'essa unidade é inferior a atual cadastrada na nova fórmula.' + #13#10 +
                                                  'Deseja atualizar para a unidade nova ?' + #13#10 +
                                                  'Unidade Atual : ' + GetQueryCadastro.FieldByName('NFM_CODUNI').AsString + #13#10 +
                                                  'Unidade Nova  : ' + strUnidade, ['&Sim','&Não']) = 1 Then
  Begin
    Result := True;
    blnAtualizaUnidade := True;
  End;
end;

function TCadastroNovasFormulasSherwinWilliams2.fCalculaOncaParaMl(strTipOnc,
  strOnca: String): Double;
begin
  If strTipOnc = 'ONÇA' Then
    Result := StrToFloat(strOnca) * 0.924 //Quantidade Onça para Ml
  Else
    Result := StrToFloat(strOnca); // Quantidade Ml
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pAjustaQuantidade(strUnidade: String;
  const tela: ITelaCadLibTintas);
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
  GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 142;
  tela['DBRadioGroup']['Width'].Value := 800;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['Columns'].Value := 2;
  tela['DBRadioGroup']['TabOrder'].Value := 12;
  stlItems.Add('ONÇA');
  stlItems.Add('ML');
end;

function TCadastroNovasFormulasSherwinWilliams2.fRetFatorDivisaoUnidade(
  strUnidade: String): Integer;
begin
  Result := 1;
  If strUnidade = 'QT' Then
  Begin
    If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'LA' Then
      Result := 20
    Else If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'GL' Then
      Result := 4
  End
  Else If strUnidade = 'GL' Then
  Begin
    If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'LA' Then
      Result := 5;
  End;
end;


function TCadastroNovasFormulasSherwinWilliams2.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'SHW';
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

function TCadastroNovasFormulasSherwinWilliams2.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Quarto';
  If strCodUni = 'QT' Then
    Result := 'Quarto'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

{function TCadastroNovasFormulasSherwinWilliams2.fRetMenorUnidade(strProduto, strCodBas, strUnidad: String): String;
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
  qryGen.SQL := ' SELECT BAS_CODUNI              ' +
                '   FROM SHW_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_PRODUT = :PRODUT    ' +
                '    AND BAS_CODBAS = :CODBAS    ' +
                '  ORDER BY BAS_CODUNI           ';
  qryGen.ParamByName('PRODUT').AsString := strProduto;
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_CODUNI').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'LA' Then
      strLata := qryGen.FieldByName('BAS_CODUNI').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strLata)) Then
    Result := strLata;
end;
        }
function TCadastroNovasFormulasSherwinWilliams2.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasSherwinWilliams2.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasSherwinWilliams2.Create;
end;


function TCadastroNovasFormulasSherwinWilliams2.GetNomeCampo: string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasSherwinWilliams2.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasSherwinWilliams2.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasSherwinWilliams2.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasSherwinWilliams2.GetNomeTabela: string;
begin
  Result := 'SHW_CADNFM';
end;


function TCadastroNovasFormulasSherwinWilliams2.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasSherwinWilliams2.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasSherwinWilliams2.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasSherwinWilliams2.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasSherwinWilliams2.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('SHW').fGetInteger('PROCOD');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODIGO').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmSHW        : String;
  blnGerarUnidades : Boolean;
begin

  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoSherwinWilliams2NovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString,
     blnGerarUnidades, blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);


    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmSHW := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('SHW').pSet('PROCOD',strNfmSHW);
    End;
  end;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := 'QT';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := Date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'ML';

  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeCodNfm']['Enabled'].Value       := false;
  tela['dbeProduto']['Enabled'].Value      := false;


  tela['dbeDataCadastro']['Enabled'].Value := false;
 // tela.SelectNext;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pAtivaCadSHW;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE SHW_CADSHW ' +
                '   SET SHW_ATIVAD = :ATIVAD ' +
                ' WHERE SHW_CODIGO = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE SHW_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
begin
  Try
    pAtivaNfm;
    pAtivaCadSHW;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.PesquisarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
end;

procedure TCadastroNovasFormulasSherwinWilliams2.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString);

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasSherwinWilliams2.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeCodNfm']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Checked'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeCodNfm']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDescri']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeObserv']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);

  tela['dbeBase']['Enabled'].Value   := MatchStr(strState, ['dsEdit', 'dsInsert']);
//  tela['DBComboBox']['Enabled'].Value := MatchStr(strState, ['dsInsert']);

  tela['gpbColorantes']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
end;

function TCadastroNovasFormulasSherwinWilliams2.ValidarBase( const strCodBas: string): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   COUNT(0) AS QTD          ' +
      ' FROM                       ' +
      '   SHW_CADBAS               ' +
      '  INNER JOIN CADITE             ' +
      '     ON ITE_CODITE = BAS_CODITE ' +
      ' WHERE BAS_CODBAS = :CODBAS ',
      'QTD', [strCodBas]
    ) > 0;
  end;
end;

function TCadastroNovasFormulasSherwinWilliams2.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   SHW_CADCOL               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasSherwinWilliams2.ValidarColoranteJaCadastrado(
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
        Result := false;
    End;
  End;
end;

{function TCadastroNovasFormulasSherwinWilliams2.ValidarProduto(strCodBas, strUnidad,
  strProduto : String; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) and
     (not TStrUtils.fEmptyStr(strUnidad)) and
     (not TStrUtils.fEmptyStr(strProduto)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   COUNT(0) AS QTD          ' +
      ' FROM                       ' +
      '   SHW_CADBAS               ' +
      '  INNER JOIN CADITE             ' +
      '     ON ITE_CODITE = BAS_CODITE ' +
      ' WHERE BAS_DESCRI = :CODBAS ' +
      '   AND BAS_CODUNI = :CODUNI ' +
      '   AND BAS_PRODUT = :PRODUT ',
      'QTD', [strCodBas, strUnidad, strProduto]
    ) > 0;

    If Not Result Then
    Begin
      GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := fRetMenorUnidade(strProduto, strCodBas, strUnidad);
      Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString);
    End;
  end;
end;
 }
function TCadastroNovasFormulasSherwinWilliams2.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN SHW_CADSHW ON %1:s_ITETIN = SHW_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "SHW" '+
                                                 '   AND SHW_CODIGO  = :CODNFM', [GetQueryCadastro.FieldByName('NFM_CODIGO').AsString]);
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
