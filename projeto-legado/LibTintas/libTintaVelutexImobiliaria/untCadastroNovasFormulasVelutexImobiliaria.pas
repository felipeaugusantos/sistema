unit untCadastroNovasFormulasVelutexImobiliaria;

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
  TCadastroNovasFormulasVelutexImobiliaria = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function ValidarColorante(const strCodCol: string): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas;
    const strCodCol: string; const strNomCam: string): Boolean;
    function ValidarBase(const strDesBas: string): Boolean;
    function ValidarProduto(const strProdut, strDesBas, strUnidad: string;
      const tela: ITelaCadLibTintas): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    procedure pAtivaNfm;
    procedure pAtivaCadVel;

    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;
    function fPedidoAberto(strPedido: String; blnResult: Boolean): Boolean;

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

    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);

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
  untDbeCodColKeyPressVelutexImobiliaria,
  untDbeCodProKeyPressNovasFormulasVelutexImobiliaria, untTypesSistema,
  untGravandoExecucaoVelutexImobiliariaNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untDbeCodBasKeyPressNovasFormulasVelutexImobiliaria;
{ TCadastroNovasFormulasVelutexImobiliaria }

procedure TCadastroNovasFormulasVelutexImobiliaria.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Width'].Value := 800;
  tela.GetSelf['Height'].Value := 525;
  tela['btnAtivarNfm']['Visible'].Value := True;
  tela['dbeUnidad']['Enabled'].Value := False;
  blnAtualizaUnidade := False;
  strUnidadeMenor := '';

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasVelutexImobiliaria.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pExisteUnidadeMenorCadastrada(tela);
  tela['dbeUnidad']['Enabled'].Value := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  pLimparQuantidades(GetQueryCadastro);

end;

procedure TCadastroNovasFormulasVelutexImobiliaria.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' +
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;
  End;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroNovasFormulasVelutexImobiliaria.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intContador: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 13, 41, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 313, 41, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCorCod', 'Color Code:', 13, 70, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 328, 70, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodBase', 'Código Base:', 30, 95, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblNfmNota', 'Nota:', 328, 95, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblNfmCole', 'Coleção:', 30, 122, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodNom', 'Cód.Nome:', 328, 122, 57, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto', 'Produto:', 50, 147, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMaodeObra', 'Acréscimo mão de obra:', 328, 148, 57, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 89, 38, 174, 22, 'ttAlfanumerico', 'NFM_CODNFM'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 390, 38, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCorCod', 89, 65, 174, 22, 'ttAlfanumerico', 'NFM_CORCOD'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 478, 41, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeUnidad', 390, 65, 174, 22, 'ttAlfanumerico', 'NFM_CODUNI')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasVelutexImobiliaria.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodBase', 89, 92, 174, 22, 'ttAlfanumerico', 'NFM_CODBAS')
    .AdicionarEvento(TDbeCodBasKeyPressNovasFormulasVelutexImobiliaria.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeNfmNota', 390, 92, 174, 22, 'ttAlfanumerico', 'NFM_NOTA__'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeNfmCole', 89, 119, 174, 22, 'ttAlfanumerico', 'NFM_COLECA'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNom', 390, 119, 174, 22, 'ttAlfanumerico', 'NFM_CODNOM'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProduto', 89, 146, 174, 22, 'ttAlfanumerico', 'NFM_PRODUT')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasVelutexImobiliaria.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMaodeObra', 390, 146, 174, 22, 'ttNumerico', 'NFM_ACRMOB'));

   groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 113, 521, 249)
     .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
     .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption','     Colorantes      '));

   groupColorantes.AdicionarControle(TLibTintaControleVisualImplementacao.Create(
     ' Object lblQtdML: TLabel                                                                 ' +
     ' Left         = 80                                                                       ' +
     ' Top          = 0                                                                        ' +
     ' Width        = 460                                                                      ' +
     ' Height       = 14                                                                       ' +
     ' Algnment     = taRightJustify                                                           ' +
     ' AutoSize     = False                                                                    ' +
     ' Caption      = ''A quantidade dos colorantes deve ser informada sempre no volume padrão LITRO''     ' +
     ' Color        = clTeal                                                                   ' +
     ' Font.Charset = ANSI_CHARSET                                                             ' +
     ' Font.Color   = clRed                                                                    ' +
     ' Font.Height  = 14                                                                       ' +
     ' Font.Name    = ''Arial''                                                                ' +
     ' Font.Pitch   = fpVariable                                                               ' +
     ' Font.Style   = [fsBold]                                                                 ' +
     ' ParentColor  = False                                                                    ' +
     ' ParentFont   = False                                                                    ' +
     ' End                                                                                     '
   ));

  For intContador := 1 To 10 Do
  Begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodC' + TStrUtils.fStrZero(intContador, 2), Format('Código %.2d:',
      [intContador]), 8, (22 * intContador) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdC' + TStrUtils.fStrZero(intContador, 2), 'Quantidade:', 120,
      (22 * intContador) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intContador, 2), 'Quantidade Pulso:', 280,
      (22 * intContador) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodC' +TStrUtils.fStrZero(intContador, 2), 68,
      22 * intContador, 45, 22, 'ttAlfanumerico', 'NFM_CODC' + TStrUtils.fStrZero(intContador, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressVelutexImobiliaria.Create(Self, 'dbeCodC' + TStrUtils.fStrZero(intContador, 2))));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' +TStrUtils.fStrZero(intContador, 2), 183,
      22 * intContador, 60, 22, 'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intContador, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' +TStrUtils.fStrZero(intContador, 2), 340,
      22 * intContador, 60, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intContador, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')));
  End;

  For intContador := 11 To 20 Do
  Begin

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodC' + TStrUtils.fStrZero(intContador, 2), Format('Código %.2d:',
      [intContador]), 405, (22 * (intContador - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdC' + TStrUtils.fStrZero(intContador, 2), 'Quantidade:', 515,
      (22 * (intContador - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intContador, 2), 'Quantidade Pulso:', 670,
      (22 * (intContador - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodC' +TStrUtils.fStrZero(intContador, 2), 465,
      22 * (intContador - 10), 45, 22,'ttAlfanumerico', 'NFM_CODC' + TStrUtils.fStrZero(intContador, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressVelutexImobiliaria.Create(Self, 'dbeCodC' + TStrUtils.fStrZero(intContador, 2))));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdX' +TStrUtils.fStrZero(intContador, 2), 575,
      22 * (intContador - 10), 60, 22,'ttAlfanumerico', 'NFM_QTDX' + TStrUtils.fStrZero(intContador, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' +TStrUtils.fStrZero(intContador, 2), 730,
      22 * (intContador - 10), 60, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intContador, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase','ecUpperCase')));
  End;

  AdicionarControle(groupColorantes);
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM VEL_CADVEL WHERE VEL_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
end;

function TCadastroNovasFormulasVelutexImobiliaria.fAjustarQuantidade(
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

function TCadastroNovasFormulasVelutexImobiliaria.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasVelutexImobiliaria.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.FormatarCampo(
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

function TCadastroNovasFormulasVelutexImobiliaria.fPedidoAberto(
  strPedido: String; blnResult: Boolean): Boolean;
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

function TCadastroNovasFormulasVelutexImobiliaria.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasVelutexImobiliaria.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasVelutexImobiliaria.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasVelutexImobiliaria.fRetDescUnidade(
  strCodUni: String): String;
begin
  Result := 'Litros';
  If strCodUni = 'LT' Then
    Result := 'Litros'
  Else If strCodUni = 'QT' Then
    Result := 'Quarto'
  Else If strCodUni = 'GL' Then
    Result := 'Galão'
  Else If strCodUni = 'LA' Then
    Result := 'Lata';
end;

function TCadastroNovasFormulasVelutexImobiliaria.fRetDescUnidadesBase: String;
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
                '   VEL_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_CODBAS = :DESBAS     ' +
                '   AND BAS_PRODUT = :PRODUT     ';

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.SQL := qryGen.SQL + ' AND BAS_CODUNI <> :CODUNI ';

  qryGen.ParamByName('DESBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;
  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;

  If (Not blnAtualizaUnidade) And (Not TStrUtils.fEmptyStr(strUnidadeMenor)) Then
    qryGen.ParamByName('CODUNI').AsString := strUnidadeMenor;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If qryGen.FieldByName('BAS_CODUNI').AsString = 'LT' Then
      Result := Result + 'Litro';

    If qryGen.FieldByName('BAS_CODUNI').AsString = 'QT' Then
      Result := Result + 'Quarto';

    If qryGen.FieldByName('BAS_CODUNI').AsString = 'GL' Then
      Result := Result + 'Galao';

    If qryGen.FieldByName('BAS_CODUNI').AsString = 'LA' Then
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

function TCadastroNovasFormulasVelutexImobiliaria.fRetFatorDivisaoUnidade(
  strUnidade: String): Integer;
begin
  Result := 1;
  If Pos(strUnidade, 'LT_QT_') > 0 Then
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

function TCadastroNovasFormulasVelutexImobiliaria.fRetMenorUnidade(strProdut,
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
  qryGen.SQL := ' SELECT BAS_CODUNI              ' +
                '   FROM VEL_CADBAS              ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                '  WHERE BAS_CODBAS = :DESBAS    ' +
                '    AND BAS_PRODUT = :PRODUT    ' +
                '  ORDER BY BAS_CODUNI           ';
  qryGen.ParamByName('DESBAS').AsString := strCodBas;
  qryGen.ParamByName('PRODUT').AsString := strProdut;
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

function TCadastroNovasFormulasVelutexImobiliaria.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'VEL';
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

function TCadastroNovasFormulasVelutexImobiliaria.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
  strCampoQtd,
  strValorCampoQtd: String;
  intY: Integer;

  procedure CarregarDescricao;
  begin
  { if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_DESCOR').AsString)
      and (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_PRODUT').AsString))
      and (not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString)) then
    begin
      GetQueryCadastro.FieldByName('NFM_DESCOR').AsString :=
      VarToStrDef(TAutcomTintaFactory.Get.GetValorCampo(
        ' SELECT                     ' +
        '   BAS_CODBAS               ' +
        ' FROM                       ' +
        '   EUVEL_CADBAS               ' +
        ' WHERE BAS_LINHA_ = :LINHA_ ' +
        '   AND BAS_BASE__ = :CODUNI ',
        'BAS_CODBAS', [GetQueryCadastro.FieldByName('NFM_LINHA_').AsString,
                       GetQueryCadastro.FieldByName('NFM_BASE__').AsString]), '');
    end;  }
  end;
begin
  Result := True;

  If strNomeCampo = 'NFM_CORCOD' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Code Color"!';
    End;
  End
  Else If strNomeCampo = 'NFM_CODBAS' Then
  Begin
    If TstrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Código Base"!';
    End
    Else If Not ValidarBase(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'O "Código Base" não foi encontrado!';
    End;
  End
  Else If strNomeCampo = 'NFM_PRODUT' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Produto"!';
    End
    Else If Not ValidarProduto(strValorCampo, GetQueryCadastro.FieldByName('NFM_CODBAS').AsString,
                                              GetQueryCadastro.FieldByName('NFM_CODUNI').AsString,
                                              tela) Then
    Begin
      Result := False;
      strRetorno := 'O "Produto" não foi encontrado!';
    End
    Else
      CarregarDescricao;
  End
  Else If strNomeCampo = 'NFM_CODUNI' Then
  Begin
    If  TstrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Unidade"!';
    End;
  End
  Else If strNomeCampo = 'NFM_CODNOM' Then
  Begin
    If TstrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'É necessário preencher o campo "Cód. Nome"!';
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
  Else If LeftStr(strNomeCampo,8) = 'NFM_CODC' Then
  Begin
    If TStrUtils.fEmptyStr(tela['dbeCodC01']['Text'].Value) Then
    Begin
      Result := False;
      strRetorno := 'É necessário ao menos preencher "1" colorante!';
    End
    Else If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If Not ValidarColorante(strValorCampo) Then
      Begin
        Result := False;
        strRetorno :=  'O "Colorante" não foi encontrado!';
      End
      Else If Not ValidarColoranteJaCadastrado(tela, strValorCampo, strNomeCampo) Then
      Begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('AVISO', 'Este "Colorante" ja está cadastrado para essa nova forumula', ['&Ok']);
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
      If StrToFloatDef(strValorCampoQtd, -1) > 0 Then
      Begin
        Result := False;
        strRetorno := 'A "Quantidade" de colorante foi informada. Por favor, informe seu código!';
      End;
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDX' Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX','NFM_CODC', [rfReplaceAll])).AsString) Then
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
            'Pulso', 'ML') + ' está incorreta!' + #13 + 'São aceitos apenas números inteiros ou decimais.';
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
    Else If ((TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDX', 'NFM_CODC', [rfReplaceAll])).AsString)) And
      Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_CODC', 'NFM_QTDX', [rfReplaceAll])).AsString)) Then
    Begin
      Result := False;
      strRetorno := 'É necessário informar o colorante!';
    End;
  End
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDC' Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_CODC', [rfReplaceAll])).AsString) Then
    Begin
      If TstrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'É necessário preencher a "quantidade" do colorante!';
      End
      Else If StrToFloatDef(strValorCampo, 0) <= 0 Then
      Begin
        Result := False;
        strRetorno := 'A "Quantidade" de colorante deve ser maior que Zero!';
      End;

    End;
  End
  Else If Not fValidarPreenchimentoCol(tela) Then
  Begin
    Result := False;
    strRetorno := 'Não é permetido o preenchimento aleatório dos colorantes, para finalizar preencha os campos conforme a "sequência numérica"!'
  End;

end;

function TCadastroNovasFormulasVelutexImobiliaria.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
var
  intCont       : Integer;
  blnCampoVazio : Boolean;
begin
  Result        := true;
  blnCampoVazio := false;

  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(tela['dbeCodC'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and not (blnCampoVazio) then
      blnCampoVazio := true
    else
    if not TStrUtils.fEmptyStr(tela['dbeCodC'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and (blnCampoVazio) then
    begin
      Result := false;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasVelutexImobiliaria.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                ';
  qryGen.SQL := qryGen.SQL + '    * FROM  ' + GetNomeTabela  + '        ';
  qryGen.SQL := qryGen.SQL + '  WHERE ' + GetNomeCampo  + ' = :NFM      ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetNomeCampoItem: string;
begin
  Result := 'NFM_CODC';
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetNomeTabela: string;
begin
  Result := 'VEL_CADNFM';
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetPreencherDBRadioGroup: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroNovasFormulasVelutexImobiliaria.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('VEL').fGetInteger('VELNFM');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmVel: String;
  blnGerarUnidades: Boolean;
begin
  if tela.GetBlnGravou then
  begin
    blnGerarUnidades := (TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Deseja gerar ' + fRetDescUnidadesBase + ' ?', ['Sim', 'Não']) = 1);
    (TGravandoExecucaoVelutexImobiliariaNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString,
     blnGerarUnidades, blnAtualizaUnidade, strUnidadeMenor) as IGravandoExecucaoNome).Executar(TGravandoVazio.Create);


    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmVel := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('VEL').pSet('VELNFM',strNfmVel);
    End;
  end;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := 'LT';
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := Date;
  GetQueryCadastro.FieldByName('NFM_TIPQTD').AsString := 'PULSO';

  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela['chkAtivad']['Checked'].Value       := True;
  tela['dbeUnidad']['Enabled'].Value       := False;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pAjustaQuantidade(strUnidade: String;
  const tela: ITelaCadLibTintas);
var
  intCont: Integer;
begin
  Tela['lblQtdML']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(strUnidade);
  For intCont := 1 To 20 Do
  Begin
    If (strToFloatDef(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value, 0) > 0) Then
    Begin
      GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intCont, 2)).AsFloat :=
        StrToFloat(FormatFloat('#0.00',StrToFloat(tela['dbeQtdC' + TStrUtils.fStrZero(intCont, 2)]['Text'].Value) / fRetFatorDivisaoUnidade(strUnidade)));
    End;
  End;
  GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := strUnidade;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pAjustarRadioGroup(
  const tela: ITelaCadLibTintas; stlItems: TStrings);
begin
  tela['DBRadioGroup']['Visible'].Value := True;
  tela['DBRadioGroup']['Left'].Value := 1;
  tela['DBRadioGroup']['Top'].Value := 168;
  tela['DBRadioGroup']['Width'].Value := 793;
  tela['DBRadioGroup']['Height'].Value := 35;
  tela['DBRadioGroup']['DataField'].Value := 'NFM_TIPQTD';
  tela['DBRadioGroup']['TabOrder'].Value := 14;
  tela['DBRadioGroup']['Columns'].Value := 4;
  stlItems.Add('ONÇA AMERICANA');
  stlItems.Add('ONÇA INGLESA');
  stlItems.Add('PULSO');
  stlItems.Add('ML');
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pAtivaCadVel;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE VEL_CADVEL ' +
                '   SET VEL_ATIVAD = :ATIVAD ' +
                ' WHERE VEL_CODNFM = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE VEL_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadVel;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' +
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' +
        TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pBotaoAtivarNfm(
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

procedure TCadastroNovasFormulasVelutexImobiliaria.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If Not GetQueryCadastro.IsEmpty Then
    Tela['lblQtdML']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString);

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pExisteUnidadeMenorCadastrada(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  strUnidadeMenor := '';

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT                         ' +
                '   BAS_CODUNI                   ' +
                ' FROM                           ' +
                '   VEL_CADBAS                   ' +
                '  INNER JOIN CADITE             ' +
                '     ON ITE_CODITE = BAS_CODITE ' +
                ' WHERE BAS_PRODUT = :PRODUT     ' +
                '   AND BAS_CODBAS = :CODBAS     ';

  qryGen.ParamByName('PRODUT').AsString := GetQueryCadastro.FieldByName('NFM_PRODUT').AsString;
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('NFM_CODBAS').AsString;

  qryGen.Open;

  qryGen.First;
  While Not qryGen.Eof Do
  Begin

    If ((Pos(qryGen.FieldByName('BAS_CODUNI').AsString, 'LT_QT_') > 0) And (Pos(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString, 'LT_QT_') <= 0)) Then
    Begin
      strUnidadeMenor := qryGen.FieldByName('BAS_CODUNI').AsString;
      Break;
    End
    Else If ((qryGen.FieldByName('BAS_CODUNI').AsString = 'GL') And (GetQueryCadastro.FieldByName('NFM_CODUNI').AsString <> 'GL') And
        (Pos(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString, 'LT_QT_') <= 0)) Then
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

procedure TCadastroNovasFormulasVelutexImobiliaria.pGetMd5KeyPedidos(
  const qryCadastro: IDataSet; stlMd5Key: TStringList);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM VEL_CADVEL        ';
  qryGen.SQL := qryGen.SQL + '  WHERE VEL_CORCOD = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CORCOD').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('VEL_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasVelutexImobiliaria.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

function TCadastroNovasFormulasVelutexImobiliaria.ValidarBase(
  const strDesBas: string): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strDesBas)) then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                         ' +
      '   COUNT(0) AS QTD              ' +
      ' FROM                           ' +
      '   VEL_CADBAS                   ' +
      '  INNER JOIN CADITE             ' +
      '     ON ITE_CODITE = BAS_CODITE ' +
      ' WHERE BAS_CODBAS = :CODBAS ',
      'QTD', [strDesBas]
    ) > 0;
  end;
end;

function TCadastroNovasFormulasVelutexImobiliaria.ValidarProduto(const strProdut,
  strDesBas, strUnidad: string; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := True;
  if (not TStrUtils.fEmptyStr(strDesBas)) And
     (not TStrUtils.fEmptyStr(strUnidad))  then
  begin
    Result := TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                         ' +
      '   COUNT(0) AS QTD              ' +
      ' FROM                           ' +
      '   VEL_CADBAS                   ' +
      '  INNER JOIN CADITE             ' +
      '     ON ITE_CODITE = BAS_CODITE ' +
      ' WHERE BAS_PRODUT = :PRODUT     ' +
      '   AND BAS_CODBAS = :DESBAS     ' +
      '   AND BAS_CODUNI = :CODUNI     ',
      'QTD', [strProdut, strDesBas, strUnidad]
    ) > 0;

    If Not Result Then
    Begin
      GetQueryCadastro.FieldByName('NFM_CODUNI').AsString := fRetMenorUnidade(strProdut, strDesBas, strUnidad);
      Tela['lblQtdML']['Caption'].Value := 'Informar a quantidade sempre em ' + fRetDescUnidade(GetQueryCadastro.FieldByName('NFM_CODUNI').AsString);
    End;
  end;
end;

function TCadastroNovasFormulasVelutexImobiliaria.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   VEL_CADCOL               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasVelutexImobiliaria.ValidarColoranteJaCadastrado(
  const tela: ITelaCadLibTintas; const strCodCol, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 20 Do
  Begin
    If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont,2)) And
       (Not TStrUtils.fEmptyStr( tela['dbeCodC' + TStrUtils.fStrZero(intCont,2)]['Text'].Value )) Then
    Begin
      If tela['dbeCodC' + TStrUtils.fStrZero(intCont,2)]['Text'].Value = strCodCol Then
        Result := False;
    End;
  End;
end;

function TCadastroNovasFormulasVelutexImobiliaria.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD     ' +
                                                 '  FROM %0:s                ' +
                                                 ' INNER JOIN VEL_CADVEL ON %1:s_ITETIN = VEL_MD5KEY ' +
                                                 ' WHERE %1:s_IDEPRO = "VEL" ' +
                                                 '   AND VEL_CODNFM = :CODNFM',
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

end.

