unit untCadastroNovasFormulasResicolor;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteResicolor, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasResicolor = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function fVerificaBase(strCodBas: String; strProKey: String): Boolean;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;
    function fPedidoAberto(strPedido: String; blnResult: Boolean): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadRSI;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Integer;
    function fRetDescUnidade(strCodUni: String): String;

    function fRetMenorUnidade(strCodBas, strProKey, strSubKey:String): String;
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
    function fBaseCadastrada(strCodBas:String = ''; strProKey:String = ''; strSubKey:String = ''):Boolean;
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
  untConsultaCadastroNovasFormulasResicolor, untDbeCodColKeyPressResicolor,
  untDbeCodProKeyPressNovasFormulasResicolor,
  untDbeCodEmbKeyPressNovasFormulasResicolor,
  untGravandoExecucaoResicolorNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untDbeCodUniKeyPress, untDbeDesProKeyPressNovasFormulasResicolor,
  untTypesSistema;
{ TCadastroNovasFormulasResicolor }

procedure TCadastroNovasFormulasResicolor.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 480;
  tela.GetSelf['Width'].Value := 800;
  tela['btnAtivarNfm']['Visible'].Value    := True;

  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;

  blnAtualizaUnidade := False;
  strUnidadeMenor := '';
end;

procedure TCadastroNovasFormulasResicolor.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
//
end;

procedure TCadastroNovasFormulasResicolor.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeCodUni']['Enabled'].Value := False;
   tela['dbeDataCadastro']['Enabled'].Value    := False;
  pLimparQuantidades(GetQueryCadastro);
end;

procedure TCadastroNovasFormulasResicolor.AtivarNovasFormulas(
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

procedure TCadastroNovasFormulasResicolor.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
 //
end;

procedure TCadastroNovasFormulasResicolor.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código Form.:', 41, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 213, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblBase', 'Base:', 78, 55, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProdKey', 'Prod. Key:', 243, 55, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblSubKey', 'Sub. Key:', 343, 55, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 443, 55, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 57, 78, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acrésc. Mão de obra:', 88, 100, 25, 14, 'taRightJustify'));


  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 130, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Colorante %.2d:', [intCont]), 13, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 140, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Ml:', 285, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 73,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_COL0' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressResicolor.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 203,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 345,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTD0' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 405, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 525, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade Ml:', 660, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 465,
      22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_COL0' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressResicolor.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' + TStrUtils.fStrZero(intCont , 2), 585,
      22 * (intCont - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 720,
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
    '   Alignment = taLeftJustify                            ' +
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

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 117, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODPRO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 287, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 117, 52, 85, 22, 'ttAlfanumerico', 'NFM_BASE__')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasResicolor.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProdKey', 263, 52, 30, 22, 'ttAlfanumerico', 'NFM_PROKEY')
    .AdicionarEvento(TDbeDesProKeyPressNovasFormulasResicolor.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeSubKey', 363, 52, 30, 22, 'ttAlfanumerico', 'NFM_SUBKEY')
    .AdicionarEvento(TDbeDesProKeyPressNovasFormulasResicolor.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 463, 52, 45, 22, 'ttAlfanumerico', 'NFM_UNIDAD')
    .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 117, 75, 391, 22, 'ttAlfanumerico', 'NFM_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 117, 98, 100, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 236, 100, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle((groupColorantes)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

end;

procedure TCadastroNovasFormulasResicolor.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM RSI_CADRSI WHERE RSI_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasResicolor.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
end;

procedure TCadastroNovasFormulasResicolor.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
    begin
      DeletaNovaFormula(strCodNfmDel);
    end;
  end;
end;

function TCadastroNovasFormulasResicolor.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODPRO';
end;

function TCadastroNovasFormulasResicolor.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasResicolor.FormatarCampo(
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

function TCadastroNovasFormulasResicolor.fPedidoAberto(strPedido: String;
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

function TCadastroNovasFormulasResicolor.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasResicolor.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasResicolor.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;

end;

function TCadastroNovasFormulasResicolor.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
    intY: Integer;

  procedure CarregarDescricao;
  begin
   //
  end;
begin
  Result := True;

  If strNomeCampo = 'NFM_BASE__' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A base deve ser preenchida!';
    End
    Else If Not fVerificaBase(strValorCampo, '') Then
    Begin
      Result := False;
      strRetorno := 'Essa base não esta cadastrada!';
    End;
  End

  Else If strNomeCampo = 'NFM_PROKEY' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A Prod. Key deve ser preenchida!';
    End
    Else If Not fVerificaBase(GetQueryCadastro.FieldByName('NFM_BASE__').AsString,
                                strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A Prod. Key da base informada esta incorreta!';
    End;
  End

  Else If strNomeCampo = 'NFM_SUBKEY' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A Sub. Key deve ser preenchida!';
    End
    Else If Not fBaseCadastrada(GetQueryCadastro.FieldByName('NFM_BASE__').AsString,
                                GetQueryCadastro.FieldByName('NFM_PROKEY').AsString,
                                strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A Sub. Key da base informada esta incorreta';
    End
    Else
    Begin
      GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := fRetMenorUnidade(GetQueryCadastro.FieldByName('NFM_BASE__').AsString,
        GetQueryCadastro.FieldByName('NFM_PROKEY').AsString, strValorCampo);

      Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
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

  Else If LeftStr(strNomeCampo, 8) = 'NFM_COL0' Then
  Begin
    If TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) Then
    Begin
      Result := False;
      strRetorno := 'É necessário digitar pelo menos 1 colorante!';
    End
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If Not ValidarColorante(strValorCampo) then
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
        strRetorno := 'A quantidade do colorante foi informada. Por favor, informe seu código.';
      End;
    End;
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
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTD0', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('A', strValorCampo);
        End
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_QTD0', [rfReplaceAll])).AsFloat :=
            fCalculaOncaParaMl('I', strValorCampo);
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
        Else
        Begin
          GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_QTD0', [rfReplaceAll])).AsFloat :=
            TAutcomTintaFactory.Get.fStrToFloat(strValorCampo);
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
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTD0' Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTD0', 'NFM_COL0', [rfReplaceAll])).AsString) Then
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade do colorante!';
      End
      Else If strToFloatDef(strValorCampo, 0) <= 0 Then
      Begin
        Result := False;
        strRetorno := 'A quantidade do colorante deve ser maior que Zero!';
      End;
    End
    Else If (( TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTD0', 'NFM_COL0', [rfReplaceAll])).AsString) )
      And   ((Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_COL0', 'NFM_QTD0', [rfReplaceAll])).AsString)) And
             (strToFloatDef(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_COL0', 'NFM_QTD0', [rfReplaceAll])).AsString,0) > 0)) ) Then
    Begin
        Result := False;
        strRetorno := 'É necessário informar o colorante!';
    End
  End
  Else If Not(fValidarPreenchimentoCol(tela)) Then
  Begin
    Result     := False;
    strRetorno :='Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  End;
end;

function TCadastroNovasFormulasResicolor.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
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

function TCadastroNovasFormulasResicolor.fVerificaBase(strCodBas,
  strProKey: String): Boolean;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT  *  FROM RSI_CADBAS        ';
    qryGen.SQL := qryGen.SQL + '    INNER JOIN CADITE ON BAS_CODITE = ITE_CODITE      ';
    qryGen.SQL := qryGen.SQL + '  WHERE BAS_BASE__ = :BASE    ';

    If Not TStrUtils.fEmptyStr(strProKey) Then
      qryGen.SQL := qryGen.SQL + '  AND BAS_PROKEY = :PROKEY    ';

    qryGen.ParamByName('BASE').AsString := strCodBas;

    If Not TStrUtils.fEmptyStr(strProKey) Then
      qryGen.ParamByName('PROKEY').AsString := strProKey;

    qryGen.Open;

    Result := (Not qryGen.IsEmpty);
  Except
    Raise;
  End;


end;

function TCadastroNovasFormulasResicolor.fVerificaNovFormulas(
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

function TCadastroNovasFormulasResicolor.fRetDescUnidadesBase: String;
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
                '   RSI_CADBAS                ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_BASE__ = :BASE       ' +
                '  AND BAS_PROKEY = :PROKEY      ' +
                '  AND BAS_SUBKEY = :SUBKEY      ' ;


  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

  qryGen.ParamByName('BASE').AsString := GetQueryCadastro.FieldByName('NFM_BASE__').AsString;
  qryGen.ParamByName('PROKEY').AsString := GetQueryCadastro.FieldByName('NFM_PROKEY').AsString;
  qryGen.ParamByName('SUBKEY').AsString := GetQueryCadastro.FieldByName('NFM_SUBKEY').AsString;

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

procedure TCadastroNovasFormulasResicolor.pExisteUnidadeMenorCadastrada(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_UNIDAD                   ' +
                ' FROM                           ' +
                '   RSI_CADBAS                ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_BASE__ = :BASE       ' +
                '   AND BAS_PROKEY = :PROKEY     ' +
                '   AND BAS_SUBKEY = :SUBKEY     ' ;

  qryGen.ParamByName('BASE').AsString := GetQueryCadastro.FieldByName('NFM_BASE__').AsString;
  qryGen.ParamByName('PROKEY').AsString := GetQueryCadastro.FieldByName('NFM_PROKEY').AsString;
  qryGen.ParamByName('SUBKEY').AsString := GetQueryCadastro.FieldByName('NFM_SUBKEY').AsString;
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

procedure TCadastroNovasFormulasResicolor.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM RSI_CADRSI        ';
  qryGen.SQL := qryGen.SQL + '  WHERE RSI_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('RSI_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

function TCadastroNovasFormulasResicolor.fAjustarQuantidade(
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

function TCadastroNovasFormulasResicolor.fBaseCadastrada(strCodBas, strProKey,
  strSubKey: String): Boolean;
var
  qryGen: IDataSet;
  strDesLt,
  strDesGl,
  strDesLa,
  strLitro,
  strGalao,
  strLata: String;
begin
  strLitro := '';
  strGalao := '';
  strLata  := '';
  strDesLt := '';
  strDesGl := '';
  strDesLa := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT BAS_DESCRI, BAS_UNIDAD FROM RSI_CADBAS     ' +
                '       INNER JOIN CADITE ON BAS_CODITE = ITE_CODITE        ' +
                '     WHERE BAS_BASE__ = :BASE                        ' ;

  If Not TStrUtils.fEmptyStr(strProKey) Then
    qryGen.SQL := qryGen.SQL + '  AND BAS_PROKEY = :PROKEY            ';

  If Not TStrUtils.fEmptyStr(strSubKey) Then
    qryGen.SQL := qryGen.SQL + '  AND BAS_SUBKEY = :SUBKEY            ';

  qryGen.ParamByName('BASE').AsString := strCodBas;

  If Not TStrUtils.fEmptyStr(strProKey) Then
    qryGen.ParamByName('PROKEY').AsString := strProKey;

  If Not TStrUtils.fEmptyStr(strSubKey) Then
    qryGen.ParamByName('SUBKEY').AsString := strSubKey;

  qryGen.Open;
  Result := (Not qryGen.IsEmpty);


  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('BAS_UNIDAD').AsString = 'LT' Then
    Begin
      strLitro := qryGen.FieldByName('BAS_UNIDAD').AsString;
      strDesLt := qryGen.FieldByName('BAS_DESCRI').AsString;
    End
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'GL' Then
    Begin
      strGalao := qryGen.FieldByName('BAS_UNIDAD').AsString;
      strDesGl := qryGen.FieldByName('BAS_DESCRI').AsString;
    End
    Else If qryGen.FieldByName('BAS_UNIDAD').AsString = 'LA' Then
    Begin
      strLata := qryGen.FieldByName('BAS_UNIDAD').AsString;
      strDesLa := qryGen.FieldByName('BAS_DESCRI').AsString;
    End;

    qryGen.Next;
  End;

  If Not (TStrUtils.fEmptyStr(strLitro)) And Not (TStrUtils.fEmptyStr(strDesLt)) Then
  Begin
    GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strLitro;
    If (Result) And (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_DESCRI').AsString)) Then
      GetQueryCadastro.FieldByName('NFM_DESCRI').AsString := strDesLt;
  End
  Else If Not (TStrUtils.fEmptyStr(strGalao)) And Not (TStrUtils.fEmptyStr(strDesGl)) Then
  Begin
    GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strGalao;
    If (Result) And (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_DESCRI').AsString)) Then
      GetQueryCadastro.FieldByName('NFM_DESCRI').AsString := strDesGl;
  End
  Else If Not (TStrUtils.fEmptyStr(strLata)) And Not (TStrUtils.fEmptyStr(strDesLa)) Then
  Begin
    GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strLata;
    If (Result) And (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_DESCRI').AsString)) Then
      GetQueryCadastro.FieldByName('NFM_DESCRI').AsString := strDesLa;
  End;

end;

procedure TCadastroNovasFormulasResicolor.pAjustaQuantidade(strUnidade: String;
  const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTD0' + TStrUtils.fStrZero(intCont, 2)).AsFloat := StrToFloat(FormatFloat('#0.00',StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasResicolor.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 120;
  tela['DBRadioGroup']['Width'].Value := 793;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 12;
  tela['DBRadioGroup']['Columns'].Value := 3;
  stlItems.Add('ONÇA AMERICANA');
  stlItems.Add('ONÇA INGLESA');
  stlItems.Add('ML');
end;

function TCadastroNovasFormulasResicolor.fRetFatorDivisaoUnidade(
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


function TCadastroNovasFormulasResicolor.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litro';
  If strCodUni = 'LT' Then
    Result := 'Litro'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

function TCadastroNovasFormulasResicolor.fRetMenorUnidade(strCodBas, strProKey, strSubKey:String): String;
var
  qryGen: IDataSet;
  strLitro,
  strGalao,
  strLata: String;
begin
  Result := '';

  strLitro := '';
  strGalao := '';
  strLata  := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT *              ' +
                '   FROM RSI_CADBAS           '    +
                '   INNER JOIN CADITE ON BAS_CODITE = ITE_CODITE      ' +
                '  WHERE BAS_BASE__ = :BASE      ' +
                '    AND BAS_PROKEY = :PROKEY    ' +
                '    AND BAS_SUBKEY = :SUBKEY    ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('BASE').AsString := strCodBas;
  qryGen.ParamByName('PROKEY').AsString := strProKey;
  qryGen.ParamByName('SUBKEY').AsString := strSubKey;
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

function TCadastroNovasFormulasResicolor.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'RSI';
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

function TCadastroNovasFormulasResicolor.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasResicolor.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasResicolor.Create;
end;

function TCadastroNovasFormulasResicolor.GetNomeCampo: string;
begin
  Result := 'NFM_CODPRO';
end;

function TCadastroNovasFormulasResicolor.GetNomeCampoItem: string;
begin
  Result := 'NFM_COL0';
end;

function TCadastroNovasFormulasResicolor.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasResicolor.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasResicolor.GetNomeTabela: string;
begin
  Result := 'RSI_CADNFM';
end;

function TCadastroNovasFormulasResicolor.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasResicolor.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasResicolor.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasResicolor.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasResicolor.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('RSI').fGetInteger('NFMRSI');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODPRO').AsString :=  'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasResicolor.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmRSI        : String;
  blnGerarUnidades : Boolean;
begin

  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoResicolorNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODPRO').AsString,
     blnGerarUnidades, blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome)
     .Executar(TGravandoVazio.Create);

    

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmRSI := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('RSI').pSet('NFMRSI',strNfmRSI);
    End;
  end;
end;

procedure TCadastroNovasFormulasResicolor.IncluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  //
end;

procedure TCadastroNovasFormulasResicolor.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := 'LT';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := Date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'ML';

  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeDataCadastro']['Enabled'].Value := false;
  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela.SelectNext;
end;

procedure TCadastroNovasFormulasResicolor.pAtivaCadRSI;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE RSI_CADRSI ' +
                '   SET RSI_ATIVAD = :ATIVAD ' +
                ' WHERE RSI_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasResicolor.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE RSI_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODPRO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODPRO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasResicolor.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadRSI;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasResicolor.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;


procedure TCadastroNovasFormulasResicolor.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
end;

procedure TCadastroNovasFormulasResicolor.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeCodNfm']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Checked'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeCodNfm']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeBase']['Enabled'].Value   := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['dbeDescri']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['chkAtivad']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
  tela['gpbColorantes']['Enabled'].Value := MatchStr(strState, ['dsEdit', 'dsInsert']);
end;

function TCadastroNovasFormulasResicolor.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   RSI_CADCOL            ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasResicolor.ValidarColoranteJaCadastrado(
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


function TCadastroNovasFormulasResicolor.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN RSI_CADRSI ON %1:s_ITETIN = RSI_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "RSI" '+
                                                 '   AND RSI_CODIGO = :CODNFM', [GetQueryCadastro.FieldByName('NFM_CODPRO').AsString]);
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
