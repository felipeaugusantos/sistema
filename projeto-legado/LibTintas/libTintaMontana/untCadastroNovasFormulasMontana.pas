unit untCadastroNovasFormulasMontana;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasMontana = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strCodBas, strCodUni, strAcabam: string; const tela: ITelaCadLibTintas): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    function fRetCodBase(strDescri ,strProduto, strUnidade, strAcabamento : String ) : String;
    function fRetDesBase(strCodigo, Unidade, Produto, strAcabamento : String) : String;

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;
    function fPedidoAberto(strPedido: String; blnResult: Boolean): Boolean;

    function fRetDesAcabamento(strAcabamento : String) : String;
    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadMON;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;

    function fRetDescUnidadesBase(const tela: ITelaCadLibTintas): String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Integer;
    function fRetDescUnidade(strCodUni: String): String;

    function fRetMenorUnidade(const tela: ITelaCadLibTintas; strCodBas, strUnidad: String): String;
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
    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
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
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

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
  untDbeCodColKeyPressMontana,
  untDbeCodProKeyPressNovasFormulasMontana,
  untGravandoExecucaoMontanaNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untDbeCodUniKeyPress, untDbeAcabamentoKeyPressMontana,
  untDbeAcbNovasformulasKeyPressMontana, untTypesSistema;
{ TCadastroNovasFormulasMontana }


procedure TCadastroNovasFormulasMontana.pBotaoAtivarNfm(
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


procedure TCadastroNovasFormulasMontana.CancelarDepois(const tela: ITelaCadLibTintas; const strState: string);
Begin
  pBotaoAtivarNfm(tela);
  Tela['edtBase']['Text'].Value := fRetDesBase(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString
                                             , GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString
                                             , GetQueryCadastro.FieldByName('NFM_PRODUT').AsString
                                             , GetQueryCadastro.FieldByName('NFM_ACABAM').AsString);
End;

procedure TCadastroNovasFormulasMontana.PesquisarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  Tela['edtBase']['Text'].Value       := '';
end;

procedure TCadastroNovasFormulasMontana.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
  Begin
    Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);

    Tela['edtBase']['Text'].Value := fRetDesBase(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString
                                               , GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString
                                               , GetQueryCadastro.FieldByName('NFM_PRODUT').AsString
                                               , GetQueryCadastro.FieldByName('NFM_ACABAM').AsString);


  End;

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasMontana.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 530;
  tela.GetSelf['Width'].Value := 835;

  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['dbeCodNfm']['Enabled'].Value  := False;
  tela['dbeDtaCad']['Enabled'].Value  := False;

  Tela['dbeProduto']['Enabled'].Value    := False;
  Tela['edtBase']['Enabled'].Value       := False;
  Tela['dbeUnidade']['Enabled'].Value    := False;

  pBotaoAtivarNfm(tela);

  blnAtualizaUnidade := False;
  strUnidadeMenor := '';
end;

procedure TCadastroNovasFormulasMontana.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  //
end;

procedure TCadastroNovasFormulasMontana.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeDtaCad']['Enabled'].Value     := False;
  Tela['dbeProduto']['Enabled'].Value    := False;
  Tela['edtBase']['Enabled'].Value       := False;
  Tela['dbeUnidade']['Enabled'].Value    := False;
  pLimparQuantidades(GetQueryCadastro);

  tela.SelectNext;
end;

procedure TCadastroNovasFormulasMontana.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;

      Tela['edtBase']['Text'].Value := '';
    End;
  End;
end;

procedure TCadastroNovasFormulasMontana.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
{  tela['edtBase']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   BAS_DESCRI               ' +
      ' FROM                       ' +
      '   MON_CADBAS               ' +
      ' WHERE BAS_CODBAS = :CODBAS ', 'BAS_DESCRI', [ GetQueryCadastro.FieldByName('NFM_CODBAS').AsString ]);
}


end;

procedure TCadastroNovasFormulasMontana.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
//  Código
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 8, 35, 73, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 84, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODNFM')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

// Data
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDtaCad', 'Data cadastro:', 212, 35, 73, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDtaCad', 289, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

// Descrição da Cor
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDesCor', 'Descrição Cor:', 24, 59, 57, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDesCor', 84, 52, 450, 22, 'ttAlfanumerico', 'NFM_DESCOR')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', true)));

// Descrição
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 24, 83, 57, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 84, 76, 450, 22, 'ttAlfanumerico', 'NFM_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', true)));

// Acabamento
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcabamento', 'Acabamento:', 45, 107, 36, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcabamento', 84, 100, 240, 22, 'ttAlfanumerico', 'NFM_ACABAM')
    .AdicionarEvento(TDbeAcbNovasFormulasKeyPressMontana.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', true)));

// Produto
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto', 'Produto:', 319, 107, 57, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProduto', 380, 100, 155, 22, 'ttAlfanumerico', 'NFM_PRODUT')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

// Base

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblBase', 'Base:', 25, 131, 57, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtBase', 84, 124, 150, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));


// Unidade

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 230, 131, 57, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeUnidade', 290, 124, 60, 22, 'ttAlfanumerico', 'NFM_UNIDAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

// Embalagem

//  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem', 'Embalagem:', 373, 131, 57, 14, 'taRightJustify'));

//  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeEmbalagem', 435, 124, 100, 22, 'ttAlfanumerico', 'NFM_QTDEMB')
//    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
//    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', true)));

// Acréscimo mão de obra

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acrésc. Mão de obra:', 436, 128, 25, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 462, 124, 73, 22, 'ttNumerico', 'NFM_ACRMOB'));

// Atividades

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 85, 148, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

// Colorantes

  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 300, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Codigo %.2d:', [intCont]), 13, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 140, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Grama:', 305, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 73,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressMontana.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 203,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 365,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 425, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 545, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Grama:', 705, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 485,
      22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressMontana.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 605,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 765,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
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

  AdicionarControle((groupColorantes).AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));
end;

procedure TCadastroNovasFormulasMontana.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM MON_CADMON WHERE MON_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasMontana.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasMontana.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
    Begin
      DeletaNovaFormula(strCodNfmDel);

    tela['edtBase']['text'].Value       := '' ;
//    tela['edtAcabamento']['text'].Value := '';
  End;
end;
end;

function TCadastroNovasFormulasMontana.fAjustarQuantidade(
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

function TCadastroNovasFormulasMontana.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasMontana.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasMontana.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
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
  else
  if MatchStr(strNomeCampo, ['NFM_QTDEMB']) then
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

function TCadastroNovasFormulasMontana.fPedidoAberto(strPedido: String;
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

function TCadastroNovasFormulasMontana.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasMontana.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasMontana.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;

end;

function TCadastroNovasFormulasMontana.fRetCodBase(strDescri, strProduto, strUnidade, strAcabamento: String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_CODBAS '+
                '   FROM MON_CADBAS '+
                '  WHERE BAS_PRODUT = :PRODUT' +
                '    AND BAS_UNIDAD = :UNIDAD '+
                '    AND BAS_ACABAM = :ACABAM '+
                '    AND BAS_DESCRI = :DESCRI ';
  qryGen.ParamByName('PRODUT').AsString := strProduto;
  qryGen.ParamByName('UNIDAD').AsString := strUnidade;
  qryGen.ParamByName('ACABAM').AsString := strAcabamento;
  qryGen.ParamByName('DESCRI').AsString := strDescri;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_CODBAS').AsString;
end;

function TCadastroNovasFormulasMontana.fRetDesAcabamento(strAcabamento : String): String;
Var
  qryGen: IDataSet;
begin
   qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_ACABAM'+
                '   FROM MON_CADBAS '+
                '  WHERE BAS_ACABAM = :ACABAMENTO';
  qryGen.ParamByName('ACABAMENTO').AsString :=  strAcabamento;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_ACABAM').AsString;
end;

function TCadastroNovasFormulasMontana.fRetDesBase(strCodigo, Unidade, Produto, strAcabamento : String): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_DESCRI'+
                '   FROM MON_CADBAS '+
                '  WHERE BAS_CODBAS = :CODIGO '+
                '    AND BAS_PRODUT = :PRODUT '+
                '    AND BAS_ACABAM = :ACABAM '+
                '    AND BAS_UNIDAD = :UNIDAD ';
  qryGen.ParamByName('CODIGO').AsString :=  strCodigo;
  qryGen.ParamByName('PRODUT').AsString :=  Produto;
  qryGen.ParamByName('ACABAM').AsString :=  strAcabamento;
  qryGen.ParamByName('UNIDAD').AsString :=  Unidade;

  qryGen.Open;

  Result := qryGen.FieldByName('BAS_DESCRI').AsString;
end;

function TCadastroNovasFormulasMontana.fRetDescUnidade(strCodUni: String): String;
begin
  Result := 'Quarto';
  If (Pos(strCodUni, 'LT_QT_') > 0) Then
    Result := 'Quarto'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'BL' Then
    Result := 'Balde';
end;

function TCadastroNovasFormulasMontana.fRetDescUnidadesBase(const tela: ITelaCadLibTintas): String;
var
  qryGen  : IDataSet;
  strMens : String;
begin
  Result := '';
  strMens:= '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_UNIDAD '+
                '  FROM  MON_CADBAS '+
                ' INNER JOIN CADITE     ON ITE_CODITE = BAS_CODITE '+
                '  WHERE BAS_PRODUT = :PRODUT '+
                '    AND BAS_CODBAS = :CODBAS '+
                '    AND BAS_ACABAM = :DESCRI ';


  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
  Begin
    qryGen.SQL := qryGen.SQL + ' AND BAS_UNIDAD <> :CODUNI ';
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;
  End;

  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;
  qryGen.ParamByName('DESCRI').AsString := tela['dbeAcabamento']['Text'].Value;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_UNIDAD').AsString, 'LT_QT_') > 0 Then
      Result := Result + 'Quarto';

    If qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL' Then
      Result := Result + 'Galao';

    If qryGen.FieldByName('BAS_UNIDAD').AsString = 'BL' Then
      Result := Result + 'Balde';

    qryGen.Next;
  End;

  If Pos('Quarto', Result) > 0 Then
  Begin
    If qryGen.RecordCount = 1 Then
      strMens := strMens + 'Quarto'
    Else If qryGen.RecordCount = 2 Then
      strMens := strMens + 'Quarto e '
    Else If qryGen.RecordCount > 2 Then
      strMens := strMens + 'Quarto, ';
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

  If Pos('Balde', Result) > 0 Then
  Begin
    strMens := strMens + 'Balde';
  End;

  Result := strMens;
end;

function TCadastroNovasFormulasMontana.fRetFatorDivisaoUnidade(strUnidade: String): Integer;
begin
  Result := 1;
  If Pos(strUnidade, 'LT_QT_') > 0 Then
  Begin
    If GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString = 'BL' Then
      Result := 20
    Else If GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString = 'GL' Then
      Result := 4
  End
  Else If strUnidade = 'GL' Then
  Begin
    If GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString = 'BL' Then
      Result := 5;
  End;
end;

function TCadastroNovasFormulasMontana.fRetMenorUnidade(const tela: ITelaCadLibTintas; strCodBas, strUnidad: String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strBalde : String;
begin
  Result := strUnidad;

  strLitro := '';
  strGalao := '';
  strBalde := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT BAS_UNIDAD ' +
                '   FROM MON_CADBAS ' +
                '  INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE  ' +
                '  WHERE BAS_CODBAS = :CODBAS '+
                '    AND BAS_PRODUT = :PRODUT '+
                '    AND BAS_ACABAM = :DESCRI '+
                '  ORDER BY BAS_UNIDAD';
  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := tela['dbeProduto']['Text'].Value;
  qryGen.ParamByName('DESCRI').AsString := tela['dbeAcabamento']['Text'].Value;
  qryGen.Open;

  qryGen.First;

  While Not qryGen.Eof Do
  Begin
    If Pos(qryGen.FieldByName('BAS_UNIDAD').AsString, 'LT_QT_') > 0 Then
      strLitro := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL' Then
      strGalao := qryGen.FieldByName('BAS_UNIDAD').AsString
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'BL' Then
      strBalde := qryGen.FieldByName('BAS_UNIDAD').AsString;

    qryGen.Next;
  End;

  If (Not TStrUtils.fEmptyStr(strLitro)) Then
    Result := strLitro
  Else If (Not TStrUtils.fEmptyStr(strGalao)) Then
    Result := strGalao
  Else If (Not TStrUtils.fEmptyStr(strBalde)) Then
    Result := strBalde;
end;

function TCadastroNovasFormulasMontana.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'MON';
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

function TCadastroNovasFormulasMontana.fValidaCampos(const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;var strRetorno: string): Boolean;
  Var
    strCampoQtd      : String;
    strValorCampoQtd : String;
    strCodBas        : String;
begin
  Result := True;

  If strNomeCampo = 'NFM_CODBAS' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Código Base"!';
    end
  End

  Else If strNomeCampo = 'NFM_ACABAM' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'O Código do  acabamento deve ser preenchido!';
    end
    else
    begin
      Result := (fRetDesAcabamento(strValorCampo) <> '');

      If Not Result Then
        strRetorno := 'O Acabamento informado não é válido!';

      strCodBas := fRetCodBase(tela['edtBase']['Text'].Value
                             , tela['dbeProduto']['Text'].Value
                             , tela['dbeUnidade']['text'].value
                             , strValorCampo);

      if not ValidarBase(strCodBas
                       , tela['dbeUnidade']['text'].value
                       , strValorCampo
                       , tela) then
      begin
        Result := False;
        strRetorno := 'Base não encontrada!';
      end;

    end;
  End


  Else If strNomeCampo = 'NFM_DESCOR' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição da cor deve ser preenchida!';
    end
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
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_FORM', [rfReplaceAll])).AsString) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade para continuar!';
      End
      Else If (GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'GRAMA') Then
      Begin
        If fGetValorPulsosMl(strValorCampo) Then
        Begin
          Result := False;
          strRetorno := 'A quantidade informada em ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString = 'GRAMA',
            'Grama', 'ML') + ' está incorreta!' + #13 + 'São aceitos apenas números inteiros ou decimais!';
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
    End
    Else If ((TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_FORM', [rfReplaceAll])).AsString)) And
      Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDX', [rfReplaceAll])).AsString)) Then
    Begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    End;
  End
  Else if LeftStr(strNomeCampo, 8) = 'NFM_QTDC' then
  Begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll])).AsString) then
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
    else if (( TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll])).AsString) )
      and   ((not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll])).AsString)) And
             (strToFloatDef(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_FORM', 'NFM_QTDC', [rfReplaceAll])).AsString,0) > 0)) ) then
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

function TCadastroNovasFormulasMontana.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
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

function TCadastroNovasFormulasMontana.fVerificaNovFormulas(
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
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasMontana.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasMontana.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasMontana.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasMontana.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasMontana.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasMontana.GetNomeCampoUnidade: string;
begin
  Result := 'NFM_UNIDAD';
end;

function TCadastroNovasFormulasMontana.GetNomeTabela: string;
begin
  Result := 'MON_CADNFM';
end;

function TCadastroNovasFormulasMontana.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasMontana.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasMontana.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasMontana.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasMontana.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('MON').fGetInteger('PROCOD');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';

    GetQueryCadastro.FieldByName('NFM_CODBAS').AsString := fRetCodBase(tela['edtBase']['text'].Value
                                                                     , Tela['dbeProduto']['text'].Value
                                                                     , Tela['dbeUnidade']['Text'].Value
                                                                     , Tela['dbeAcabamento']['Text'].Value);
  End;
end;

procedure TCadastroNovasFormulasMontana.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmMON        : String;
  blnGerarUnidades : Boolean;
begin

  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase(tela) + ' ?', ['Sim', 'Não']) = 1);

    (TGravandoExecucaoMontanaNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString,
                                                  blnGerarUnidades,
                                                  blnAtualizaUnidade,
                                                  strUnidadeMenor) as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);


    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmMON := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('MON').pSet('PROCOD',strNfmMON);
    End;
  end;
end;

procedure TCadastroNovasFormulasMontana.IncluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  //
end;

procedure TCadastroNovasFormulasMontana.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate := fNow;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'GRAMA';
  Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em Quarto';

  tela['dbeCodNfm']['Enabled'].Value     := False;
  tela['dbeDtaCad']['Enabled'].Value     := False;

  Tela['dbeProduto']['Enabled'].Value    := False;
  Tela['dbeUnidade']['Enabled'].Value    := False;

  Tela['edtBase']['Text'].Value       := '';

  tela.SelectNext;
end;

procedure TCadastroNovasFormulasMontana.pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
var
  intCont: Integer;
  qryGen : IDataSet;
begin
  Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat := StrToFloat(FormatFloat('#0.00',StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT * '+
                '  FROM MON_CADBAS '+
                ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE '+
                ' WHERE BAS_PRODUT = :PRODUT '+
                '   AND BAS_UNIDAD = :UNIDAD '+
                '   AND BAS_CODBAS = :CODBAS '+
                '   AND BAS_DESCRI = :DESCRI ';

  qryGen.ParamByName('PRODUT').AsString := Tela['dbeProduto']['Text'].Value;
  qryGen.ParamByName('UNIDAD').AsString := strUnidade;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('DESCRI').AsString := Tela['dbeAcabamento']['Text'].Value;;
  qryGen.Open;

  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := qryGen.FieldByName('BAS_UNIDAD').AsString;
  GetQueryCadastro.FieldByName('NFM_ACABAM').AsString := qryGen.FieldByName('BAS_ACABAM').AsString;
  GetQueryCadastro.FieldByName('NFM_CODBAS').AsString := qryGen.FieldByName('BAS_CODBAS').AsString;
end;

procedure TCadastroNovasFormulasMontana.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 170;
  tela['DBRadioGroup']['Width'].Value := 828;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 13;
  tela['DBRadioGroup']['Columns'].Value := 1;
  stlItems.Add('GRAMA');
end;

procedure TCadastroNovasFormulasMontana.pAtivaCadMon;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE MON_CADMON ' +
                '   SET MON_ATIVAD = :ATIVAD ' +
                ' WHERE MON_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasMontana.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE MON_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasMontana.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadMON;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasMontana.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasMontana.pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
var
  strSQL : String;
  qryGen : IDataSet;
begin
  strUnidadeMenor := '';

  strSQL := ' SELECT  '+
            '    BAS_UNIDAD ' +
            ' FROM MON_CADBAS ' +
            ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
            ' WHERE BAS_PRODUT = :PRODUT '+
            '   AND BAS_CODBAS = :CODBAS '+
            '   AND BAS_DESCRI = :DESCRI ';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := strSQL;
  qryGen.ParamByName('PRODUT').AsString := Tela['dbeProduto']['Text'].Value;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('DESCRI').AsString := Tela['dbeAcabamento']['Text'].Value;
  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((Pos(qryGen.FieldByName('BAS_UNIDAD').AsString,'LT_QT_') > 0) And (Pos(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString, 'LT_QT_') <= 0)) Then
    Begin
      strUnidadeMenor := TAutcomTintaFactory.Get.IIF(qryGen.FieldByName('BAS_UNIDAD').AsString = 'LT', 'LT', 'QT');
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL') And (GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString <> 'GL') And
            (Pos(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString, 'LT_QT_') <= 0)) Then
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

procedure TCadastroNovasFormulasMontana.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM MON_CADMON        ';
  qryGen.SQL := qryGen.SQL + '  WHERE MON_CODNFM = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('MON_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasMontana.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeCodNfm']['Enabled'].Value :=     MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Checked'].Value :=     MatchStr(strState, ['dsEdit', 'dsInsert']);

  tela['dbeCodNfm']['Enabled'].Value :=     MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDesCor']['Enabled'].Value :=     MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDescri']['Enabled'].Value :=     MatchStr(strState, ['dsEdit', 'dsInsert']);

  tela['chkAtivad']['Enabled'].Value     := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['gpbColorantes']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
end;

function TCadastroNovasFormulasMontana.ValidarBase(const strCodBas, strCodUni, strAcabam: string; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   COUNT(0) AS QTD          ' +
      ' FROM                       ' +
      '   MON_CADBAS               ' +
      '   INNER JOIN CADITE            ' +
      '     ON BAS_CODITE = ITE_CODITE ' +
      ' WHERE BAS_CODBAS = :CODBAS '+
      '   AND BAS_UNIDAD = :CODUNI '+
      '   AND BAS_ACABAM = :ACABAM '+
      '   AND BAS_PRODUT = :PRODUT ',
      'QTD', [strCodBas, strCodUni, strAcabam, Tela['dbeProduto']['text'].Value]
    ) > 0;

    If Result Then
    Begin
      GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := fRetMenorUnidade(tela ,strCodBas ,strCodUni);

      Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
    End;
  end;
end;

function TCadastroNovasFormulasMontana.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   MON_CADCOL            ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasMontana.ValidarColoranteJaCadastrado(
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

function TCadastroNovasFormulasMontana.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN MON_CADMON ON %1:s_ITETIN = MON_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "MON" '+
                                                 '   AND MON_CODNFM = :CODNFM', [GetQueryCadastro.FieldByName('NFM_CODNFM').AsString]);
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

