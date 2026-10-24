unit untCadastroNovasFormulasRennerPerformance;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento, SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, Classes, untIDataSet;

type
  TCadastroNovasFormulasRennerPerformance = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    blnAtualizaUnidade: Boolean;
    strUnidadeMenor: String;
    intPrxNfm: Integer;

    function ValidarColorante(const strCodCol: string): Boolean;
    function fValidaBase(const strCodBas: String): Boolean;
    function ValidarColoranteJaCadastrado(const tela: ITelaCadLibTintas;
    const strCodCol: string; const strNomCam: string): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);
    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(const qryCadastro: IDataSet): String;
    function FTemPedidoNfm(): Boolean;

    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;

    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    procedure pAtivaNfm;
    procedure pAtivaCadInt;

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
  end;

implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untDbeCodColKeyPressRennerPerformance,
  untDbeCodProKeyPressNovasFormulasRennerPerformance,
  untGravandoExecucaoRennerPerformanceNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica, untTypesSistema;
{ TCadastroNovasFormulasRennerPerformance }

procedure TCadastroNovasFormulasRennerPerformance.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 480;
  tela.GetSelf['Width'].Value := 600;
  tela['btnAtivarNfm']['Visible'].Value := True;
  blnAtualizaUnidade := False;
  strUnidadeMenor := '';

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasRennerPerformance.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasRennerPerformance.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasRennerPerformance.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString)) And
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

procedure TCadastroNovasFormulasRennerPerformance.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasRennerPerformance.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
end;

procedure TCadastroNovasFormulasRennerPerformance.ConstruirControles;
var
  groupColorantes: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 45, 31, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCadastro', 'Data Cadastro:', 260, 31, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCor', 'Nome Cor:', 45, 53, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPadraoCor', 'Padrão Cor:', 45, 75, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTIntaControleVisualLabel.Create('lblAcrMob','Acrésc. Mão de Obra:', 90, 97, 25, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblBase', 'Base:', 45, 130, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdBas', 'Quantidade Base (g):', 250, 130, 25, 14, 'taRightJustify'));


  groupColorantes := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbColorantes', 1, 130, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Colorantes      '));

  for intCont := 1 to 10 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Componente %.2d:', [intCont]), 23, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade (g):', 160, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 83,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressRennerPerformance.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 220,
      22 * intCont, 60, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Componente %.2d:', [intCont]), 320, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdMl' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade (g):', 460, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 380,
      22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_FORM' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarEvento(TDbeCodColKeyPressRennerPerformance.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupColorantes.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 520,
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
    '   Caption = ''Informar a quantidade em Gramas, para o cadastro da fórmula em Litro'' ' +
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

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 65, 28, 100, 22, 'ttAlfanumerico', 'NFM_CODIGO')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDataCadastro', 280, 28, 85, 22, 'ttAlfanumerico', 'NFM_DTACAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCor', 65, 50, 400, 22, 'ttAlfanumerico', 'NFM_NOMCOR'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePadraoCor', 65, 72, 400, 22, 'ttAlfanumerico', 'NFM_PADRAO'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 120, 94, 100, 22, 'ttNumerico', 'NFM_ACRMOB'));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 300, 94, 100, 22, 'Ativa', 'NFM_ATIVAD', 'S', 'N'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 65, 127, 100, 22, 'ttAlfanumerico', 'NFM_CODBAS')
    .AdicionarEvento(TDbeCodProKeyPressNovasFormulasRennerPerformance.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdGBas', 280, 127, 65, 22, 'ttAlfanumerico', 'NFM_QTDBAS'));

  AdicionarControle((groupColorantes));
end;

procedure TCadastroNovasFormulasRennerPerformance.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM REP_CADREP WHERE REP_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerPerformance.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
end;

procedure TCadastroNovasFormulasRennerPerformance.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
end;

function TCadastroNovasFormulasRennerPerformance.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasRennerPerformance.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasRennerPerformance.fGetMd5KeyPedidos(
  const qryCadastro: IDataSet): String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM REP_CADREP        ';
  qryGen.SQL := qryGen.SQL + '  WHERE REP_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('REP_MD5KEY').AsString;
end;

procedure TCadastroNovasFormulasRennerPerformance.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  If LeftStr(strNomeCampo, Length('NFM_QTDC')) = 'NFM_QTDC' Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End
  Else If LeftStr(strNomeCampo, Length('NFM_QTDBAS')) = 'NFM_QTDBAS' Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End;
end;

function TCadastroNovasFormulasRennerPerformance.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasRennerPerformance.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasRennerPerformance.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;


function TCadastroNovasFormulasRennerPerformance.FTemPedidoNfm: Boolean;
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
    qryGen.ParamByName('IDEPRO').AsString := 'REP';
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

function TCadastroNovasFormulasRennerPerformance.fValidaBase(
  const strCodBas: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                  ';
  qryGen.SQL := qryGen.SQL + '    *                     ';
  qryGen.SQL := qryGen.SQL + '  FROM                    ';
  qryGen.SQL := qryGen.SQL + '    REP_CADBAS            ';
  qryGen.SQL := qryGen.SQL + '  INNER JOIN CADITE I ON        ';
  qryGen.SQL := qryGen.SQL + '    BAS_CODITE = I.ITE_CODITE        ';
  qryGen.SQL := qryGen.SQL + '  WHERE BAS_CODBAS = :CODBAS      ';

  qryGen.ParamByName('CODBAS').AsString := strCodBas;
  qryGen.Open;

  Result := (Not qryGen.IsEmpty);
end;

function TCadastroNovasFormulasRennerPerformance.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
  strCampoQtd,
  strValorCampoQtd: String;

begin
  Result := True;
  CarregarDescricoes(tela);
  If strNomeCampo = 'NFM_CODBAS' Then
  Begin
    If TstrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A base deve ser preenchida!';
    End
    Else If Not (fValidaBase(strValorCampo)) Then
    Begin
      Result := False;
      strRetorno := 'A base não esta cadastrada';
    End;
  End
  Else If strNOmeCampo = 'NFM_NOMCOR' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'O nome da cor deve ser preenchido!';
    End;
  End
  Else If strNomeCampo = 'NFM_PADRAO' Then
  Begin
    If TstrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'O padrão da cor deve ser preenchido!';
    End;
  End
  Else If strNomeCampo = 'NFM_CODBAS' Then
  Begin
    If TstrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A base deve ser preenchida!';
    End;
  End
  Else If Not (TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODBAS').AsString)) And (strNomeCampo = 'NFM_QTDBAS') Then
  Begin
    Begin
      If TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'A quantidade da base deve ser preenchida!';
      End
      Else If StrToFloatDef(strValorCampo, 0) <= 0 Then
      Begin
        Result := False;
        strRetorno := 'A quantidade da base deve ser maior que Zero!';
      End;
    End;
  End
  Else If LeftStr(strNomeCampo,8) = 'NFM_FORM' Then
  Begin
    If TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) Then
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
        TAutcomTintaFactory.Get.fMensagem('AVISO', 'Este colorante já está cadastrado para essa nova fórmula!', ['&Ok']);
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
  Else If LeftStr(strNomeCampo, 8) = 'NFM_QTDC' Then
  Begin
    If Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_FORM', [rfReplaceAll])).AsString) Then
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
    strRetorno := 'Não é permitido o preenchimento aleatório dos colorantes, para finalizar preencha os campos conforme a sequência numérica!'
  End;

end;

function TCadastroNovasFormulasRennerPerformance.fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
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

function TCadastroNovasFormulasRennerPerformance.fVerificaNovFormulas(
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

function TCadastroNovasFormulasRennerPerformance.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasRennerPerformance.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasRennerPerformance.GetNomeCampo: string;
begin
  Result := 'NFM_CODIGO';
end;

function TCadastroNovasFormulasRennerPerformance.GetNomeCampoItem: string;
begin
  Result := 'NFM_CODC';
end;

function TCadastroNovasFormulasRennerPerformance.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasRennerPerformance.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasRennerPerformance.GetNomeTabela: string;
begin
  Result := 'REP_CADNFM';
end;

function TCadastroNovasFormulasRennerPerformance.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasRennerPerformance.GetTipoTinta: TTipoTinta;
begin
  Result := ttIndustrial;
end;

function TCadastroNovasFormulasRennerPerformance.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasRennerPerformance.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('REP').fGetInteger('REPNFM');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODIGO').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasRennerPerformance.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmREP: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoRennerPerformanceNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODIGO').AsString) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);


    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmREP := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('REP').pSet('REPNFM',strNfmREP);
    End;
  end;
end;

procedure TCadastroNovasFormulasRennerPerformance.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate   := Date;

  tela['dbeCodNfm']['Enabled'].Value       := False;
  tela['chkAtivad']['Checked'].Value       := True;
  tela['dbeDataCadastro']['Enabled'].Value := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasRennerPerformance.pAtivaCadInt;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE REP_CADREP ' +
                '   SET REP_ATIVAD = :ATIVAD ' +
                ' WHERE REP_CODIGO = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerPerformance.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE REP_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODIGO = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODIGO').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasRennerPerformance.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadInt;

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

procedure TCadastroNovasFormulasRennerPerformance.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasRennerPerformance.pBotaoAtivarNfm(
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

procedure TCadastroNovasFormulasRennerPerformance.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasRennerPerformance.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
end;

function TCadastroNovasFormulasRennerPerformance.ValidarColorante(
  const strCodCol: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   REP_CADCOL               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = COL_CODITE ' +
    ' WHERE COL_CODCOL = :CODCOL ',
    'QTD', [strCodCol]
  ) > 0;
end;

function TCadastroNovasFormulasRennerPerformance.ValidarColoranteJaCadastrado(
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

function TCadastroNovasFormulasRennerPerformance.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD     ' +
                                                 '  FROM %0:s                ' +
                                                 ' INNER JOIN REP_CADREP ON %1:s_ITETIN = REP_MD5KEY ' +
                                                 ' WHERE %1:s_IDEPRO = "REP" ' +
                                                 '   AND REP_CODIGO = :CODNFM',
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
