unit untCadastroNovasFormulasKilling;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteKilling, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasKilling = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strCodBas: string ): Boolean;
//    function CarregarBase(const tela: ITelaCadLibTintas; strForm:String):String;

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;
    function fPedidoAberto(strPedido: String; blnResult: Boolean): Boolean;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    function ValidarCodigoBase(strCodBase : String) : Boolean;

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadKILD;
    procedure pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
    procedure pAtualizaNfm;

    function fRetDescUnidadesBase: String;
    function fRetornaMenorUnidade(strCodBas, strForm:String):String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Double;
    function fRetDescUnidade(strCodUni: String): String;
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

    property blnAtualizaUni: Boolean read blnAtualizaUnidade write blnAtualizaUnidade;
    property strUnidade: String read strUnidadeMenor write strUnidadeMenor;

    function GetPreencherDBRadioGroup(): Boolean; Override;
    procedure pAjustarRadioGroup(const tela: ITelaCadLibTintas; stlItems: TStrings); Override;
  end;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasKilling, untDbeCodColKeyPressKilling,
  untDbeCodProKeyPressNovasFormulasKilling,
  untGravandoExecucaoKillingNovasFormulas,  untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untDbeCodUniKeyPress, untTypesSistema;
{ TCadastroNovasFormulasKilling }

procedure TCadastroNovasFormulasKilling.pBotaoAtivarNfm(
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

procedure TCadastroNovasFormulasKilling.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 505;
  tela.GetSelf['Width'].Value := 815;
  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['dbeCodUni']['Enabled'].Value  := false;
  tela['dbeCodNfm']['Enabled'].Value  := False;

  pBotaoAtivarNfm(tela);

  blnAtualizaUnidade := False;
  strUnidadeMenor := '';
end;

procedure TCadastroNovasFormulasKilling.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
Begin
  pBotaoAtivarNfm(tela);
End;

procedure TCadastroNovasFormulasKilling.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasKilling.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeCodUni']['Enabled'].Value      := false;
  tela['dbeDataCadastro']['Enabled'].Value:= False;
  tela['dbeCodNfm']['Enabled'].Value      := False;
  tela.SelectNext;
  pLimparQuantidades(GetQueryCadastro);

  If strState = 'dsEdit' Then
  Begin
   If (Pos('SHOT', GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString) > 0) Then
    GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString :=
      TAutcomTintaFactory.Get.IIF(TAutcomTintaFactory.Get.fGetConfTinta('KIL').fGet('TIPDOS') = '0', 'MANUAL (SHOT 48)', 'AUTO (SHOT 192)');
  End;
end;

procedure TCadastroNovasFormulasKilling.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin

  If Not GetQueryCadastro.IsEmpty Then
    Tela['Label5']['Caption'].Value := 'Informar a Quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString);

  pBotaoAtivarNfm(tela);
end;


procedure TCadastroNovasFormulasKilling.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODCOR').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm(tela);
      pAtualizaNfm;
    End;
  End;
end;

{function TCadastroNovasFormulasKilling.CarregarBase(const tela: ITelaCadLibTintas; strForm: String): String;
var
  qryGen: IDataSet;
begin
  Result := '';
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODBAS     ' +
                '   FROM KILD_CADBAS    ' +
                '  WHERE BAS_CODFML = :FORM   ';

  qryGen.ParamByName('FORM').AsString := strForm;
  qryGen.Open;

  tela['dbeBase']['Text'].Value := qryGen.FieldByName('BAS_CODBAS').AsString;

  Result := tela['dbeBase']['Text'].Value;
end;  }

procedure TCadastroNovasFormulasKilling.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  //
end;

procedure TCadastroNovasFormulasKilling.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 35, 31, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 205, 31, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblNomeCor', 'Nome da Cor:', 35, 53, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao',  'Descrição:', 35, 75, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblReferencia', 'Referência:', 35, 97, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 35, 119, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblBase', 'Base:', 325, 31, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUniEmb', 'Embalagem:', 450, 119, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acréscimo mão de obra:', 279, 119, 25, 14, 'taRightJustify'));


  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 130, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Colorante %.2d:', [intCont]), 13, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 135, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Shot:', 285, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 73,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressKilling.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 193,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 345,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Colorante %.2d:', [intCont]), 415, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 535, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Shot:', 685, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 475,
      22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressKilling.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 595,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 745,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDB' + TStrUtils.fStrZero(intCont, 2))
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

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 79, 28, 80, 22, 'ttAlfanumerico', 'NFM_CODCOR')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 245, 28, 60, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 365, 28, 100, 22, 'ttAlfanumerico', 'NFM_CODBAS')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasKilling.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 481, 28, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeNomeCor', 79, 50, 445, 22, 'ttAlfanumerico', 'NFM_NOMCOR'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 79, 72, 445, 22, 'ttAlfanumerico', 'NFM_DESCRI'));

    AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeReferencia', 79, 94, 445, 22, 'ttAlfanumerico', 'NFM_REFERE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodFml', 79, 116, 100, 22, 'ttAlfanumerico', 'NFM_CODFML')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasKilling.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 489, 116, 35, 22, 'ttAlfanumerico', 'NFM_CODUNI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 306, 116, 100, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle((groupColorantes)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));
end;

procedure TCadastroNovasFormulasKilling.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' DELETE FROM KILD_CADKIL '+
                '  WHERE KIL_CODCOR = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasKilling.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODCOR').AsString;
end;

procedure TCadastroNovasFormulasKilling.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
    Begin
      DeletaNovaFormula(strCodNfmDel);
    End;
  end;
end;

function TCadastroNovasFormulasKilling.fAjustarQuantidade(
  strUnidade: String): Boolean;
begin
  Result := False;
  blnAtualizaUnidade := False;
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

function TCadastroNovasFormulasKilling.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODCOR';
end;

function TCadastroNovasFormulasKilling.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasKilling.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if LeftStr(strNomeCampo, Length('NFM_QTDB')) = 'NFM_QTDB' then
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

function TCadastroNovasFormulasKilling.fPedidoAberto(strPedido: String;
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

function TCadastroNovasFormulasKilling.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasKilling.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasKilling.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;

end;


function TCadastroNovasFormulasKilling.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litro';

  If strCodUni = 'AMO' Then
    Result := 'Amostra'
  Else If strCodUni = 'LT9' Then
    Result := 'Litro'
  Else If (strCodUni = 'GM') Or (strCodUni = 'GP') Then
    Result := 'Galão'
  Else If strCodUni = 'L18.' Then
    Result := 'Lata'
  Else If (strCodUni = 'L18') Or (strCodUni = 'P18') Or (strCodUni = 'M18') Or (strCodUni = 'H18') Or (strCodUni = 'K18') Then
    Result := 'Lata';
end;

function TCadastroNovasFormulasKilling.fRetDescUnidadesBase: String;
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
                '   KILD_CADBAS                  ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_CODBAS = :CODBAS     ' +
                '   AND BAS_CODFML = :FORM       ' +
                ' ORDER BY BAS_EMBALA            ';

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_CODUNI <> :CODUNI ';

  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('FORM').AsString := GetQueryCadastro.FieldByName('NFM_CODFML').AsString;

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('BAS_CODUNI').AsString = 'AMO' Then
      Result := Result + 'Amostra';

    If qryGen.FieldByName('BAS_CODUNI').AsString = 'LT9' Then
      Result := Result + 'Litro';

    If (qryGen.FieldByName('BAS_CODUNI').AsString = 'GM') Or (qryGen.FieldByName('BAS_CODUNI').AsString = 'GP') Then
      Result := Result + 'Galao';

    If qryGen.FieldByName('BAS_CODUNI').AsString = 'L18.' Then
      Result := Result + 'Lata';

    If (qryGen.FieldByName('BAS_CODUNI').AsString = 'M18') Or (qryGen.FieldByName('BAS_CODUNI').AsString = 'P18')
      Or (qryGen.FieldByName('BAS_CODUNI').AsString = 'L18') Or (qryGen.FieldByName('BAS_CODUNI').AsString = 'H18')
      Or (qryGen.FieldByName('BAS_CODUNI').AsString = 'K18') Then
      Result := Result + 'Lata';

    qryGen.Next;
  End;

  If Pos('Amostra', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Amostra '
    Else If qryGen.RecordCount = 2 Then
      strMens := strMens + 'Amostra e '
    Else If qryGen.RecordCount > 2 Then
      strMens := strMens + 'Amostra, ';
  End;

  If Pos('Litro', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Litro '
    Else If (qryGen.RecordCount = 2) And (Pos('Amostra', Result) <= 0) Then
      strMens := strMens + 'Litro e '
    Else If qryGen.RecordCount = 2 Then
      strMens := strMens + 'Litro '
    Else If qryGen.RecordCount > 2 Then
      strMens := strMens + 'Litro, ';
  End;

  If Pos('Galao', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Galão '
    Else If (qryGen.RecordCount = 2) And (Pos('Litro', Result) <= 0) Then
      strMens := strMens + 'Galão e '
    Else If (qryGen.RecordCount = 2) And (Pos('Amostra', Result) <= 0) Then
      strMens := strMens + 'Galão e '
    Else If qryGen.RecordCount = 2 Then
      strMens := strMens + 'Galão '
    Else If (qryGen.RecordCount = 3) And (Pos('Lata', Result) <= 0) Then
      strMens := strMens + 'Galão '
    Else If qryGen.RecordCount >= 3 Then
      strMens := strMens + 'Galão e ';
  End;

  If Pos('Lata', Result) > 0 Then
  Begin
    strMens := strMens + 'Lata ';
  End;

  Result := strMens;
end;

function TCadastroNovasFormulasKilling.fRetFatorDivisaoUnidade(
  strUnidade: String): Double;
begin
  Result := 1;


  If strUnidade = 'AMO' Then
  Begin
    If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'LT9' Then
      Result := 810 / 202
    Else If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'GM' Then
      Result := 3240 / 202
    Else If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'GP' Then
      Result := 2950 / 202
    Else If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'K18' Then
      Result := 14750 / 202
    Else
      Result := 16200 / 202
  End
  Else If strUnidade = 'LT9' Then
  Begin
    If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'GM' Then
      Result := 3240 / 810
    Else If GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'GP' Then
      Result := 2950 / 810
    Else If (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'L18.') Then
      Result := 14000 / 810
    Else If (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'K18') Then
      Result := 14750 / 810
    Else
      Result := 16200 / 810;
  End
  Else If strUnidade = 'GM' Then
  Begin
    If (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'L18.') Then
      Result := 14000 / 3240
    Else If (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'GP') Then
      Result := 2950 / 3240
    Else If (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'K18') Then
      Result := 14750 / 3240
    Else
      Result := 16200 / 3240;
  End
  Else If strUnidade = 'GP' Then
  Begin
    If (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'L18.') Then
      Result := 14000 / 2950
    Else If (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'GM') Then
      Result := 3240 / 2950
    Else If (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString = 'K18') Then
      Result := 14750 / 2950
    Else
      Result := 16200 / 2950;
  End;
end;


function TCadastroNovasFormulasKilling.fRetornaMenorUnidade(strCodBas,
  strForm: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata,
  strAmostra: String;
begin
  Result := '';
  strLitro := '';
  strGalao := '';
  strLata  := '';
  strAmostra := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;

  qryGen.SQL := ' SELECT BAS_CODUNI              ' +
                '   FROM KILD_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_CODBAS = :CODBAS    ' +
                '    AND BAS_CODFML = :FORM    ' +
                '  ORDER BY BAS_EMBALA           ';

  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('FORM').AsString   := strForm;
  qryGen.Open;

  qryGen.First;

  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('BAS_CODUNI').AsString = 'AMO' Then
      strAmostra := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If qryGen.FieldByName('BAS_CODUNI').AsString = 'LT9' Then
      strLitro := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If (qryGen.FieldByName('BAS_CODUNI').AsString = 'GM') Or (qryGen.FieldByName('BAS_CODUNI').AsString = 'GP') Then
      strGalao := qryGen.FieldByName('BAS_CODUNI').AsString
    Else If Pos(qryGen.FieldByName('BAS_CODUNI').AsString, 'M18_P18_L18_L18._H18_K18_') > 0 Then
      strLata := qryGen.FieldByName('BAS_CODUNI').AsString;

    qryGen.Next;
  End;

  If Not TStrUtils.fEmptyStr(strAmostra) Then
    Result := strAmostra
  Else If Not TStrUtils.fEmptyStr(strLitro) Then
    Result := strLitro
  Else If Not TStrUtils.fEmptyStr(strGalao) Then
    Result := strGalao
  Else If Not TStrUtils.fEmptyStr(strLata) Then
    Result := strLata;
end;

function TCadastroNovasFormulasKilling.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'KIL';
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

function TCadastroNovasFormulasKilling.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
    intY: Integer;

  procedure CarregarDescricao;
  Var
    qryGen: IDataSet;
  Begin
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT BAS_CODBAS         ' +
                  '      , BAS_CODUNI         ' +
                  '   FROM KILD_CADBAS        ' +
                  '   INNER JOIN CADITE ON    ' +
                  '     ITE_CODITE = BAS_CODITE ' +
                    '  WHERE BAS_CODBAS = :CODBAS ' +
                    ' AND BAS_CODFML    = :FORM   ' +
                    ' ORDER BY BAS_EMBALA         ';


    qryGen.ParamByName('CODBAS').AsString := tela['dbeBase']['Text'].Value;
    qryGen.ParamByName('FORM').AsString   := tela['dbeCodFml']['Text'].Value;
    qryGen.Open;

    GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := qryGen.FieldByName('BAS_CODUNI').AsString;

    Tela['Label5']['Caption'].Value := 'Informar a Quantidade sempre em ' + fRetDescUnidade(qryGen.FieldByName('BAS_CODUNI').AsString);
  End;
Begin
  Result := True;

  If strNomeCampo = 'NFM_CODBAS' then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A base deve ser preenchida!';
    End
    Else If Not ValidarBase(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'Base não encontrada!';
    End
    Else
    Begin
      //CarregarDescricao;
      fRetornaMenorUnidade(tela['dbeBase']['Text'].Value, tela['dbeCodFml']['Text'].Value);
    End;
  End
  Else If strNomeCampo = 'NFM_CODFML' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'O código da fórmula deve ser preenchido!';
    End
    Else If Not (ValidarCodigoBase(strValorCampo)) Then
    Begin
      Result := False;
      strRetorno := 'O código da fórmula não foi encontrado!';
    End
    Else
    Begin
  //    CarregarBase(tela, tela['dbeCodFml']['Text'].Value);
      GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := fRetornaMenorUnidade(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString, strValorCampo);
    End;
  End
  Else If strNomeCampo = 'NFM_REFERE' Then
  begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A referência deve ser preenchida!';
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
  Else If strNomeCampo = 'NFM_DESCRI' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_FORM' Then
  Begin
    If TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) Then
    Begin
      Result := False;
      strRetorno := 'É necessário digitar pelo menos 1 colorante!';
    End
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If Not ValidarColorante(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'Colorante não encontrado!';
      End
      Else If Not ValidarColoranteJaCadastrado(tela, strValorCampo, strNomeCampo) Then
      Begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse Colorante já está cadastrado para essa nova fórmula!', ['&Ok']);
        strRetorno := '';
      End;
    End
    Else If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      tela.pSetarFocus;
      Result := true;
    End
    Else
    Begin
      strCampoQtd := 'dbeQtdC' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;
      If strToFloatDef(strValorCampoQtd, -1) > 0 Then
      Begin
        Result := False;
        strRetorno := 'A Quantidade do colorante foi informada. Por favor, informe seu código.';
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
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ONÇA INGLESA') Then
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
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDB', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('I', strValorCampo) / TAutcomTintaFactory.Get.IIF((TAutcomTintaFactory.Get.fGetConfTinta('KIL').fGet('TIPDOS') = '0'), 0.616125, 0.154);
        End
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Or (Pos('SHOT', GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString) > 0) Then
      Begin
        If fGetValorPulsosMl(strValorCampo) Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada em ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML',
            'ML', 'Shot') + ' está incorreta!' + #13 + 'São aceitos apenas números inteiros ou decimais.';
        End
        Else If strToFloatDef(strValorCampo, 0) <= 0 Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada deve ser maior que Zero!';
        End
        Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'ML') Then
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDB', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo) / TAutcomTintaFactory.Get.IIF((TAutcomTintaFactory.Get.fGetConfTinta('KIL').fGet('TIPDOS') = '0'), 0.616125, 0.154);
        End
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTDB', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo);
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
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDB' Then
  Begin
    If not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDB', 'NFM_FORM', [rfReplaceAll])).AsString) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a Quantidade do colorante!';
      End
      Else If strToFloatDef(strValorCampo, 0) <= 0 Then
      Begin
        Result := False;
        strRetorno := 'A Quantidade do colorante deve ser maior que Zero!';
      End;
    End
    Else If (( TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDB', 'NFM_FORM', [rfReplaceAll])).AsString) )
      And   ((Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDB', [rfReplaceAll])).AsString)) And
             (strToFloatDef(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDB', [rfReplaceAll])).AsString,0) > 0)) ) Then
    Begin
        Result := False;
        strRetorno := 'É necessário informar o colorante!';
    End;
  End
  Else If Not(fValidarPreenchimentoCol(tela)) Then
  Begin
    Result     := False;
    strRetorno :='Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  End;
End;

function TCadastroNovasFormulasKilling.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
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

function TCadastroNovasFormulasKilling.fVerificaNovFormulas(
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

function TCadastroNovasFormulasKilling.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasKilling.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasKilling.Create;
end;

function TCadastroNovasFormulasKilling.GetNomeCampo: string;
begin
  Result := 'NFM_CODCOR';
end;

function TCadastroNovasFormulasKilling.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasKilling.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasKilling.GetNomeCampoUnidade: string;
begin
  Result := 'NFM_CODUNI';
end;

function TCadastroNovasFormulasKilling.GetNomeTabela: string;
begin
  Result := 'KILD_CADNFM';
end;

function TCadastroNovasFormulasKilling.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasKilling.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasKilling.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasKilling.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasKilling.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    IntPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('KIL').fGetInteger('KILNFM');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODCOR').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODCOR').AsString));


    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasKilling.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmKil        : String;
  blnGerarUnidades : Boolean;
begin

  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase + '?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoKillingNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODCOR').AsString,
     blnGerarUnidades, blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);


    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmKil := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('KIL').pSet('KILNFM',strNfmKil);
    End;
  end;
end;

procedure TCadastroNovasFormulasKilling.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := 'LT9';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := TAutcomTintaFactory.Get.IIF(
    TAutcomTintaFactory.Get.fGetConfTinta('KIL').fGet('TIPDOS') = '0', 'MANUAL (SHOT 48)', 'AUTO (SHOT 192)');

  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeCodNfm']['Enabled'].Value       := False;

  tela.SelectNext;
end;

procedure TCadastroNovasFormulasKilling.pAjustaQuantidade(strUnidade: String;
  const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  Tela['Label5']['Caption'].Value := 'Informar a Quantidade sempre em ' + fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
        StrToFloat(FormatFloat('#0.00',StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;
  GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasKilling.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 138;
  tela['DBRadioGroup']['Width'].Value := 808;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 13;
  tela['DBRadioGroup']['Columns'].Value := 3;

  If TAutcomTintaFactory.Get.fGetConfTinta('KIL').fGet('TIPDOS') = '0' Then
    stlItems.Add('MANUAL (SHOT 48)')
  Else
    stlItems.Add('AUTO (SHOT 192)');

  stlItems.Add('ONÇA INGLESA');
  stlItems.Add('ML');
end;

procedure TCadastroNovasFormulasKilling.pAtivaCadKILD;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE KILD_CADKIL ' +
                '   SET KIL_ATIVAD = :ATIVAD ' +
                ' WHERE KIL_CODCOR = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODCOR').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasKilling.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE KILD_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODCOR = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODCOR').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasKilling.pAtivarDesativarNfm(const tela: ITelaCadLibTintas);
begin
  Try
    pAtivaNfm;
    pAtivaCadKILD;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasKilling.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasKilling.pExisteUnidadeMenorCadastrada(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                          '+
                '   BAS_CODUNI                    '+
                ' FROM                            '+
                '   KILD_CADBAS                   '+
                '  INNER JOIN CADITE              '+
                '     ON ITE_CODITE = BAS_CODITE  '+
                ' WHERE BAS_CODBAS = :CODBAS      '+
                '   AND BAS_CODFML = :FORM        '+
                '   ORDER BY BAS_EMBALA           ';

  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('FORM').AsString := GetQueryCadastro.FieldByName('NFM_CODFML').AsString;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((qryGen.FieldByName('BAS_CODUNI').AsString = 'AMO') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'AMO')) Then
    Begin
      strUnidadeMenor := 'AMO';
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_CODUNI').AsString = 'LT9') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'LT9')
      And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'AMO')) Then
    Begin
      strUnidadeMenor := 'LT9';
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_CODUNI').AsString = 'GP') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'GP') And
       (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'LT9') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'AMO')) Then
    Begin
      strUnidadeMenor := 'GP';
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_CODUNI').AsString = 'GM') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'GM') And
        (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'GP') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'LT9') And
        (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'AMO')) Then
    Begin
      strUnidadeMenor := 'GM';
      Break;
    End;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    If fAjustarQuantidade(strUnidadeMenor) Then
      pAjustaQuantidade(strUnidadeMenor, tela);
end;

procedure TCadastroNovasFormulasKilling.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM KILD_CADKIL       ';
  qryGen.SQL := qryGen.SQL + '  WHERE KIL_CODCOR = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODCOR').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('KIL_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasKilling.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['chkAtivad']['Checked'].Value     := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeBase']['Enabled'].Value       := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeReferencia']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Enabled'].Value     := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['gpbColorantes']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeCodUni']['Enabled'].Value     := false;

end;

function TCadastroNovasFormulasKilling.ValidarBase(const strCodBas: string): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                       ' +
      '   COUNT(0) AS QTD            ' +
      ' FROM                         ' +
      '   KILD_CADBAS                 ' +
      '  INNER JOIN CADITE             ' +
      '     ON ITE_CODITE = BAS_CODITE ' +
      ' WHERE BAS_CODBAS = :BASE     ',
      'QTD', [strCodBas]) > 0;
  end;
end;

function TCadastroNovasFormulasKilling.ValidarCodigoBase(strCodBase: String): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBase)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      'SELECT COUNT(0) AS QTD      '+
      '  FROM KILD_CADBAS           '+
      '  INNER JOIN CADITE             ' +
      '     ON ITE_CODITE = BAS_CODITE ' +
      ' WHERE BAS_CODFML = :CODBAS ',
      'QTD', [strCodBase]
    ) > 0;
  end;

end;

function TCadastroNovasFormulasKilling.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   KILD_CADCOL               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasKilling.ValidarColoranteJaCadastrado(
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

function TCadastroNovasFormulasKilling.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN KILD_CADKIL ON %1:s_ITETIN = KIL_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "KIL" '+
                                                 '   AND KIL_CODCOR = :CODNFM', [GetQueryCadastro.FieldByName('NFM_CODCOR').AsString]);
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

