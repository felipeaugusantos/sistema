unit untCadastroNovasFormulasAdvance;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteAdvance, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes;

type
  TCadastroNovasFormulasAdvance = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas; const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strCodBas: string): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    function ValidarProduto(strCodBase, strProduto, strCodUni: String; const tela: ITelaCadLibTintas): Boolean;

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivaNfm;
    procedure pAtivaCadADV;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;

    function ValidarEmbalagem(const strCodEmb, strUnidad: String): Boolean;

    function fRetDescUnidadesBase: String;
    procedure pExisteUnidadeMenorCadastrada(const tela: ITelaCadLibTintas);
    function fAjustarQuantidade(strUnidade: String): Boolean;
    procedure pAjustaQuantidade(strUnidade: String; const tela: ITelaCadLibTintas);
    function fRetFatorDivisaoUnidade(strUnidade: String): Integer;
    function fRetDescUnidade(strCodUni: String): String;

    function fRetMenorUnidade(strProdut, strCodBas, strUnidad: String): String;
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
  end;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasAdvance, untDbeCodColKeyPressAdvance,
  untDbeCodProKeyPressNovasFormulasAdvance,
  untGravandoExecucaoAdvanceNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica, untIDataSet,
  untDbeCodUniKeyPress, untDbeDesProKeyPressNovasFormulasAdvance;
{ TCadastroNovasFormulasAdvance }

procedure TCadastroNovasFormulasAdvance.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 465;
  tela['btnAtivarNfm']['Visible'].Value    := True;

  tela['dbeProdut']['Enabled'].Value       := False;
  tela['dbeCodUni']['Enabled'].Value       := false;
  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;

  blnAtualizaUnidade := False;
  strUnidadeMenor := '';
end;

procedure TCadastroNovasFormulasAdvance.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if not fPodeAlterar then
    exit;
end;

procedure TCadastroNovasFormulasAdvance.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeCodUni']['Enabled'].Value := False;
   tela['dbeDataCadastro']['Enabled'].Value    := False;

  If tela['dbeCodUni']['Enabled'].Value = 'LT' Then
    GetQueryCadastro.FieldByName('NFM_GERUNI').AsInteger := 1
  Else
    GetQueryCadastro.FieldByName('NFM_GERUNI').AsInteger := 2;
end;

procedure TCadastroNovasFormulasAdvance.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;
  End;
end;

procedure TCadastroNovasFormulasAdvance.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODEMB').AsString)) Then
  Begin
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.SQL := ' SELECT              ' +
                  '   EMB_CODEMB,       ' +
                  '   EMB_QTDEMB,       ' +
                  '   EMB_UNIDAD,       ' +
                  '   AUTOINCREM        ' +
                  '  FROM ADVCOR_CADEMB ' +
                  ' WHERE EMB_CODEMB = :CODEMB ';

    qryGen.ParamByName('CODEMB').AsString := GetQueryCadastro.FieldByName('NFM_CODEMB').AsString;
    qryGen.Open;

    tela['edtQtdEmb']['Text'].Value := qryGen.FieldByName('EMB_QTDEMB').AsString;
  End;
end;

procedure TCadastroNovasFormulasAdvance.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 8, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 180, 31, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Base:', 45, 55, 36, 14, 'taRightJustify'));
    AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto', 'Produto:', 157, 55, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 370, 55, 57, 14, 'taRightJustify'));



  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbala', 'Embalagem:', 24, 77, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdEmb', 'Quantidade:', 175, 77, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUniEmb', 'Unidade:', 320, 77, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 24, 99, 57, 14, 'taRightJustify'));


  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 130, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Colorante %.2d:', [intCont]), 45, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 170, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 105,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressAdvance.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 230,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Colorante %.2d:', [intCont]), 305, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQuantidade' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 417, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 365,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressAdvance.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 485,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  groupColorantes.AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object Label5: TLabel                                  ' +
    '   Left = 80                                            ' +
    '   Top = 0                                              ' +
    '   Width = 400                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taLeftJustify                           ' +
    '   AutoSize = False                                     ' +
    '   Caption = ''Informar a quantidade em ML, para o cadastro da fórmula em Litro'' ' +
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

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 84, 28, 85, 22, 'ttAlfanumerico', 'NFM_CODIGO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 254, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 84, 52, 85, 22, 'ttAlfanumerico', 'NFM_CODBAS')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasAdvance.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 430, 52, 45, 22, 'ttAlfanumerico', 'NFM_UNIDAD')
    .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProdut', 219, 52, 161, 22, 'ttAlfanumerico', 'NFM_DESPRO')
    .AdicionarEvento(TDbeDesProKeyPressNovasFormulasAdvance.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeEmbala', 84, 75, 85, 22, 'ttAlfanumerico', 'NFM_CODEMB')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtQtdEmb', 237, 75, 88, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtUniEmb', 380, 75, 45, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 84, 98, 389, 22, 'ttAlfanumerico', 'NFM_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 85, 124, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle((groupColorantes)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

end;

procedure TCadastroNovasFormulasAdvance.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM ADVCOR_CADADV WHERE ADVCOR_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAdvance.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
end;

procedure TCadastroNovasFormulasAdvance.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if fPodeExcluir then
  begin
    If tela.GetBlnExcluiu Then
    begin
      DeletaNovaFormula(strCodNfmDel);
      tela['edtQtdEmb']['Text'].Value := '';
    end;
  end;
end;

function TCadastroNovasFormulasAdvance.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasAdvance.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasAdvance.FormatarCampo(
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
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end;  
end;

function TCadastroNovasFormulasAdvance.fPodeAlterar: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel alterá-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasAdvance.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;

end;

function TCadastroNovasFormulasAdvance.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
    qryGen: IDataSet;

  procedure CarregarDescricao;
  begin
    if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_DESPRO').AsString)
      and (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString))
      and (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString)) then
    begin
      GetQueryCadastro.FieldByName('NFM_DESPRO').AsString :=
      VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo(
        ' SELECT                     ' +
        '   BAS_DESCRI               ' +
        ' FROM                       ' +
        '   ADVCOR_CADBAS               ' +
        ' WHERE BAS_BASE__ = :CODBAS ' +
        '   AND BAS_UNIDAD = :CODUNI ' +
        '   AND BAS_DESCRI = :DESCRI  ',
        'BAS_DESCRI', [GetQueryCadastro.FieldByName('NFM_CODBAS').AsString,
                       GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString,
                       GetQueryCadastro.FieldByName('NFM_DESPRO').AsString]), '');
    end;

    If (Not TStrUtils.fEmptyStr(tela['dbeEmbala']['Text'].Value)) Then
    Begin
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' SELECT              ' +
                    '   EMB_CODEMB,       ' +
                    '   EMB_QTDEMB,       ' +
                    '   EMB_UNIDAD,       ' +
                    '   AUTOINCREM        ' +
                    '  FROM ADVCOR_CADEMB ' +
                    ' WHERE EMB_CODEMB = :CODEMB ';

      qryGen.ParamByName('CODEMB').AsString := tela['dbeEmbala']['Text'].Value;
      qryGen.Open;

      tela['edtQtdEmb']['Text'].Value := qryGen.FieldByName('EMB_QTDEMB').AsString;
//      tela['edtUniEmb']['Text'].Value := qryGen.FieldByName('EMB_UNIDAD').AsString;
    End;
  end;
begin
  Result := True;

  If strNomeCampo = 'NFM_CODBAS' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Base"!';
    end
    else if not ValidarBase(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'Base não encontrada!';
    end
    else
      CarregarDescricao;
  End

  Else If strNomeCampo = 'NFM_DESPRO' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Produto"!';
    end
    else if not ValidarProduto(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString,
                               strValorCampo,
                               GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString,
                               tela) Then
    begin
      Result := False;
      strRetorno := 'Produto não cadastrado para a base selecionada!';
    end;
  End

  Else If strNomeCampo = 'NFM_CODEMB' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Embalagem"!';
    end
    else if not ValidarEmbalagem(strValorCampo, GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString) then
    begin
      Result := False;
      strRetorno := 'Embalagem não encontrada!';
    end
    else
      CarregarDescricao;
  End

  Else If strNomeCampo = 'NFM_DESCRI' Then
  Begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    end
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

function TCadastroNovasFormulasAdvance.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
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

function TCadastroNovasFormulasAdvance.fRetDescUnidadesBase: String;
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
                '   ADVCOR_CADBAS                ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_DESCRI = :PRODUT     ' +
                '   AND BAS_BASE__ = :CODBAS     ';

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_UNIDAD <> :CODUNI ';

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_DESPRO').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;

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

procedure TCadastroNovasFormulasAdvance.pExisteUnidadeMenorCadastrada(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_UNIDAD                   ' +
                ' FROM                           ' +
                '   ADVCOR_CADBAS                ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_DESCRI = :PRODUT     ' +
                '   AND BAS_BASE__ = :CODBAS     ';

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_DESPRO').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;

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

function TCadastroNovasFormulasAdvance.fAjustarQuantidade(
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

procedure TCadastroNovasFormulasAdvance.pAjustaQuantidade(strUnidade: String;
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
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := strUnidade;
end;

function TCadastroNovasFormulasAdvance.fRetFatorDivisaoUnidade(
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


function TCadastroNovasFormulasAdvance.fRetDescUnidade(
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

function TCadastroNovasFormulasAdvance.fRetMenorUnidade(
  strProdut, strCodBas, strUnidad: String): String;
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
                '   FROM ADVCOR_CADBAS           ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_DESCRI = :PRODUT    ' +
                '    AND BAS_BASE__ = :CODBAS    ' +
                '  ORDER BY BAS_UNIDAD           ';
  qryGen.ParamByName('PRODUT').AsString := strProdut;
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

function TCadastroNovasFormulasAdvance.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasAdvance.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasAdvance.Create;
end;

function TCadastroNovasFormulasAdvance.GetNomeCampo: string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasAdvance.GetNomeCampoItem: string;
begin
  Result := 'NFM_FORM';
end;

function TCadastroNovasFormulasAdvance.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasAdvance.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasAdvance.GetNomeTabela: string;
begin
  Result := 'ADVCOR_CADNFM';
end;

function TCadastroNovasFormulasAdvance.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasAdvance.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasAdvance.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasAdvance.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
begin
  If (strState = 'dsInsert') Then
  Begin
    GetQueryCadastro.FieldByName('NFM_CODIGO').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
      TStrUtils.fStrZero(TAutcomTintaFactory.Get.fGetConfTinta('ADV').fGet('NFMADV'), 5);

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasAdvance.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmADV        : String;
  blnGerarUnidades : Boolean;
begin

  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoAdvanceNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString,
     blnGerarUnidades, blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome)
     .Executar(TGravandoVazio.Create);

    

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmADV := TStrUtils.fStrZero(IntToStr(StrToInt(TAutcomTintaFactory.Get.fGetConfTinta('ADV').fGet('NFMADV')) + 1), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('ADV').pSet('NFMADV',strNfmADV);
    End;
  end;
end;

procedure TCadastroNovasFormulasAdvance.IncluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['edtQtdEmb']['Text'].Value := '';
end;

procedure TCadastroNovasFormulasAdvance.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := 'LT';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := Date;

  If tela['dbeCodUni']['Enabled'].Value = 'LT' Then
    GetQueryCadastro.FieldByName('NFM_GERUNI').AsInteger := 1
  Else
    GetQueryCadastro.FieldByName('NFM_GERUNI').AsInteger := 2;

   tela['dbeCodUni']['Enabled'].Value       := false;
   tela['dbeDataCadastro']['Enabled'].Value := false;
   tela['dbeCodNfm']['Enabled'].Value       := False;
   tela.SelectNext;
end;

procedure TCadastroNovasFormulasAdvance.pAtivaCadADV;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE ADVCOR_CADADV ' +
                '   SET ADVCOR_ATIVAD = :ATIVAD ' +
                ' WHERE ADVCOR_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAdvance.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE ADVCOR_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasAdvance.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadADV;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasAdvance.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;


procedure TCadastroNovasFormulasAdvance.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
end;

procedure TCadastroNovasFormulasAdvance.pSetaEnableReadOnly(
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

function TCadastroNovasFormulasAdvance.ValidarBase( const strCodBas: string): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strCodBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   COUNT(0) AS QTD          ' +
      ' FROM                       ' +
      '   ADVCOR_CADBAS            ' +
      '   INNER JOIN CADITE              ' +
      '     ON BAS_CODITE = ITE_CODITE   ' +
      ' WHERE BAS_BASE__ = :CODBAS ',
      'QTD', [strCodBas]
    ) > 0;
  end;
end;

function TCadastroNovasFormulasAdvance.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   ADVCOR_CADCOL            ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasAdvance.ValidarColoranteJaCadastrado(
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

function TCadastroNovasFormulasAdvance.ValidarEmbalagem(
  const strCodEmb, strUnidad: String): Boolean;
begin
  Result := False;
  if (not TStrUtils.fEmptyStr(strCodEmb)) then
  Begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                       ' +
      '   COUNT(0) AS QTD            ' +
      ' FROM                         ' +
      '   ADVCOR_CADEMB              ' +
      '   WHERE EMB_CODEMB = :CODEMB ' +
      '     AND EMB_UNIDAD = :UNIDAD ',
      'QTD', [strCodEmb, strUnidad]
    ) > 0;
  End;
end;

function TCadastroNovasFormulasAdvance.ValidarProduto(strCodBase,
  strProduto, strCodUni: String; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := False;
  if (not TStrUtils.fEmptyStr(strCodBase)) And
     (not TStrUtils.fEmptyStr(strProduto)) And
     (not TStrUtils.fEmptyStr(strCodUni)) then
  Begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                       ' +
      '   COUNT(0) AS QTD            ' +
      ' FROM                         ' +
      '   ADVCOR_CADBAS              ' +
      '  INNER JOIN CADITE             ' +
      '     ON ITE_CODITE = BAS_CODITE ' +
      '   WHERE BAS_BASE__ = :CODBAS ' +
      '     AND BAS_DESCRI = :PRODUT ' +
      '     AND BAS_UNIDAD = :UNIDAD ',
      'QTD', [strCodBase, strProduto, strCodUni]
    ) > 0;

    If Not Result Then
    Begin
      GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString := fRetMenorUnidade(strProduto, strCodBase, strCodUni);
      Tela['Label5']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_UNIDAD').AsString);
    End;
  End;
end;

function TCadastroNovasFormulasAdvance.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                                 '  FROM %0:s '+
                                                 ' INNER JOIN ADVCOR_CADADV ON %1:s_ITETIN = ADVCOR_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "ADV" '+
                                                 '   AND ADVCOR_CODIGO = :CODNFM', [GetQueryCadastro.FieldByName('NFM_CODIGO').AsString]);
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
