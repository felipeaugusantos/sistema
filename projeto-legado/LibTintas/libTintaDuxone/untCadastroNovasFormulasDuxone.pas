unit untCadastroNovasFormulasDuxone;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils, Classes,
  untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untGenericLibTintaControleVisualDBMemoFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untIDataSet;

type
  TCadastroNovasFormulasDuxone = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    qryBases    : IDataSet;
    intPrxNfm: Integer;

    function ValidarBase(const strCodBas: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas; const strCodBas: string; const strNomCam: string): Boolean;
    function fPermiteAlterarNfmVendida(): Boolean;
    procedure pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
    function FTemPedidoNfm(): Boolean;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    procedure pAtivaNfm;
    procedure pAtivaCadDUX;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);
    procedure pCalcularTotalVolume(const tela: ITelaCadLibTintas);
    procedure ConstruirQryBasesValume;

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

    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function fPodeIncluir(const tela: ITelaCadLibTintas; const strState: String): Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    function GetPreencherDbComboBox: Boolean; override;
    function GetDescDbComboBox: String; override;

    function fRetProxCodigo : String;
    procedure pAtualizarProxCodigo(intProxCod : Integer);

    function GetTipoFormula(): Boolean; Override;
    procedure PreencherTipoFormula(const tela: ITelaCadLibTintas; Items: TStrings); Override;
  end;

  TBtnAjustarVolumeOnClick = class(TAbstractLibTintaControleVisualEvento)
  private
    qryBases: IDataSet;

    procedure pCalcularTotalVolume(const cadastro: TAbstractCadastro);
    procedure AjustarVolume(const tela: ITelaCadLibTintas);
    procedure ConstruirQryBasesValume;
  published
    procedure OnClick(Sender: TObject);
  end;

var
  fltTotalConcentrado : Double;
  fltTotalDiluido     : Double;

implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl, untDbeCodBasKeyPressDuxone,
  untGravandoExecucaoDuxoneNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untGravandoExecucaoDuxoneCores, untDbeCodDilKeyPressDuxone,
  untDbeCodCatKeyPressDuxone, untBtnCarregaFormulasCadastradaOnClickDuxoneGlobal,
  untTypesSistema;
{ TCadastroNovasFormulasDuxone }

procedure TCadastroNovasFormulasDuxone.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 580;
  tela.GetSelf['Width'].Value  := 800;
  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Left'].Value      := 105;
  tela['DBComboBox']['Top'].Value       := 74;
  tela['DBComboBox']['Width'].Value     := 100;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'NFM_LINHA_';
  tela['DBComboBox']['TabOrder'].Value  := 3;

  pBotaoAtivarNfm(tela);

  ConstruirQryBasesValume;
end;

procedure TCadastroNovasFormulasDuxone.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasDuxone.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela.SelectFirst;
  tela['btnAjustarVolume']['Enabled'].Value := True;

  If TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('TRACHA') = 'N' Then
    Tela['chkChaCor']['Enabled'].Value := False
  Else
    Tela['chkChaCor']['Enabled'].Value := True;

  pCalcularTotalVolume(tela);
end;

procedure TCadastroNovasFormulasDuxone.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;

    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar');
  End;
end;

procedure TCadastroNovasFormulasDuxone.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(tela);
  tela['btnAjustarVolume']['Enabled'].Value := False;
end;

procedure TCadastroNovasFormulasDuxone.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroNovasFormulasDuxone.ConstruirQryBasesValume;
var
  strSql: string;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    ' FROM                     ' +
    '   DUX_CADBAS             ';

  If TAutcomTintaFactory.Get.GetEmpBasDup Then
    strSql := strSql + ' WHERE BAS_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := strSql;
  qryBases.Open;
end;

procedure TCadastroNovasFormulasDuxone.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  intCont   : Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 28, 30, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCad', 'Data Cadastro:', 233, 30, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', -47, 54, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', -47, 80, 150, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQualidade', 'Qualidade:', 171, 80, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAlternativa', 'Alternativa:', 351, 80, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMontadora', 'Montadora:', 03, 103, 100, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob', 'Acrésc. Mão de Obra:', 107, 129, 50, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblTipFor', 'Tipo da Fórmula:', 300, 129, 20, 14, 'taRightJustify'));

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
      ' object lblVolumeTotal: TLabel                               ' +
      '   Left         = 410                                        ' +
      '   Top          = 418                                        ' +
      '   Width        = 380                                        ' +
      '   Height       = 16                                         ' +
//      '   Align        = alRight                                    ' +
      '   Alignment    = taRightJustify                             ' +
      '   AutoSize     = False                                      ' +
      '   Caption      = ''''                                       ' +
      '   Color        = clTeal                                     ' +
      '   Font.Charset = ANSI_CHARSET                               ' +
      '   Font.Color   = clBlack                                    ' +
      '   Font.Height  = 16                                         ' +
      '   Font.Name    = ''Arial''                                  ' +
      '   Font.Pitch   = fpVariable                                 ' +
      '   Font.Style   = [fsBold]                                   ' +
      '   ParentColor  = False                                      ' +
      '   ParentFont   = False                                      ' +
      ' end                                                         ' ));


  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
      ' object lblCadastrar: TLabel                                  ' +
      '   Left         = 479                                         ' +
      '   Top          = 435                                         ' +
      '   Width        = 300                                         ' +
      '   Height       = 14                                          ' +
      '   Alignment    = taRightJustify                              ' +
      '   AutoSize     = False                                       ' +
      '   Caption      = ''Cadastrar a fórmula no volume de 1000ml'' ' +
      '   Color        = clTeal                                      ' +
      '   Font.Charset = ANSI_CHARSET                                ' +
      '   Font.Color   = clRed                                       ' +
      '   Font.Height  = 16                                          ' +
      '   Font.Name    = ''Arial''                                   ' +
      '   Font.Pitch   = fpVariable                                  ' +
      '   Font.Style   = [fsBold]                                    ' +
      '   ParentColor  = False                                       ' +
      '   ParentFont   = False                                       ' +
      ' end                                                          ' ));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 105, 26, 100, 22, 'ttAlfanumerico', 'NFM_CODNFM')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDtaCad', 310, 26, 100, 22, 'ttAlfanumerico', 'NFM_DTACAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 105, 50, 420, 22, 'ttAlfanumerico', 'NFM_DESCRI')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '2'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQualid', 275, 74, 110, 22, 'ttAlfanumerico', 'NFM_QUALID')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAltern', 455, 74, 70, 22, 'ttAlfanumerico', 'NFM_ALTERN')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMontad', 105, 98, 240, 22, 'ttAlfanumerico', 'NFM_MONTAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '6'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 162, 122, 70, 22, 'ttAlfanumerico', 'NFM_ACRMOB')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '7'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkChaCor', 483, 125, 250, 17, 'Utilizar chapinha para acerto de cor', 'NFM_PROCHA', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 680, 125, 70, 17, 'Ativa', 'NFM_ATIVO_', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '10'))
  );


  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnCarregarBases: TSpeedButton                        ' +
    '   Left = 35                                                  ' +
    '   Top = 144                                                  ' +
    '   Width = 600                                                ' +
    '   Height = 23                                                ' +
    '   Hint = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''         ' +
    '   Caption = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''      ' +
    '   ParentShowHInt = False                                      ' +
    '   ShowHint = True                                             ' +
    '   Visible = True                                              ' +
    ' End                                                           ')
    .AdicionarEvento(TBtnCarregaBasesCadastrada.Create(Self)));

  groupBases := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbBases', 1, 170, 790, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alNone'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Bases      '))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '11'));

  for intCont := 1 to 10 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 8, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 153, (22 * intCont) + 3, 57, 14, 'taRightJustify'));


    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 68,
      22 * intCont, 80, 22, 'ttAlfanumerico', 'NFM_CODB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressDuxone.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 211,
      22 * intCont, 80, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

  end;

  for intCont := 11 to 20 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 400, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Quantidade:', 552, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));


    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 460,
      22 * (intCont - 10), 80, 22, 'ttAlfanumerico', 'NFM_CODB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressDuxone.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 610,
      22 * (intCont - 10), 80, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

  end;

  AdicionarControle(groupBases);

  AdicionarControle(
    TLibTintaControleVisualImplementacao.Create(
      ' object btnAjustarVolume: TBitBtn                                        ' +
      '   Left    = 515                                                         ' +
      '   Top     = 455                                                         ' +
      '   Width   = 119                                                         ' +
      '   Height  = 20                                                          ' +
      '   Hint    = ''Clique aqui para ajustar o Volume para 1000 ml''           ' +
      '   Caption = ''&Ajustar Volume''                                         ' +
      '   Enabled = False                                                       ' +
      '   Glyph.Data = {                                                        ' +
      '     76010000424D7601000000000000760000002800000020000000100000000100    ' +
      '     04000000000000010000120B0000120B00001000000000000000000000000000    ' +
      '     800000800000008080008000000080008000808000007F7F7F00BFBFBF000000    ' +
      '     FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000    ' +
      '     73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998    ' +
      '     0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808    ' +
      '     0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808    ' +
      '     0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808    ' +
      '     0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008    ' +
      '     0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008    ' +
      '     0333337F777777737F333308888888880333337F333333337F33330888888888    ' +
      '     03333373FFFFFFFF733333700000000073333337777777773333}               ' +
      '   NumGlyphs      = 2                                                    ' +
      '   ParentShowHint = False                                                ' +
      '   ShowHint       = True                                                 ' +
      '   TabOrder       = 7                                                    ' +
      ' end                                                                     ' )

  .AdicionarEvento(TBtnAjustarVolumeOnClick.Create('OnClick', Self)));
end;

procedure TCadastroNovasFormulasDuxone.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM DUX_CADDUX WHERE DUX_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasDuxone.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasDuxone.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
  tela['btnAjustarVolume']['Enabled'].Value := False;
end;

function TCadastroNovasFormulasDuxone.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasDuxone.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;


procedure TCadastroNovasFormulasDuxone.pGetMd5KeyPedidos(const qryCadastro: IDataSet; stlMd5Key: TStringList);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM DUX_CADDUX        ';
  qryGen.SQL := qryGen.SQL + '  WHERE DUX_CODDUX = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    stlMd5Key.Add(qryGen.FieldByName('DUX_MD5KEY').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroNovasFormulasDuxone.FormatarCampo(
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
    arrValores[0] := '0.000';
    arrValores[1] := '0.000';
  end
  else if MatchStr(strNomeCampo, ['NFM_ACRMOB']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  end;;
end;

function TCadastroNovasFormulasDuxone.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasDuxone.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasDuxone.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasDuxone.fPodeIncluir(
  const tela: ITelaCadLibTintas; const strState: String): Boolean;
begin
  Result := true;
end;

function TCadastroNovasFormulasDuxone.fRetProxCodigo: String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT CFG_VALCFG AS CODIGO ' +
                '   FROM CFGTIN ' +
                '  WHERE CFG_IDEPRO = "DUX" ' +
                '    AND CFG_CODCFG = "NFMDUX" ' +
                '    AND CFG_CODEMP = :CODEMP ';

  qryGen.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryGen.Open;

  Result := qryGen.FieldByName('CODIGO').AsString;
end;

function TCadastroNovasFormulasDuxone.FTemPedidoNfm: Boolean;
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
      qryGen.ParamByName('IDEPRO').AsString := 'DUX';
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

function TCadastroNovasFormulasDuxone.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
    strCampoBase    : String;

begin
  Result := True;
  pCalcularTotalVolume(tela);

  if strNomeCampo = 'NFM_DESCRI' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    end
  end
  else if strNomeCampo = 'NFM_LINHA_' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A linha deve ser preenchida!';
    end
  end
  Else If strNomeCampo = 'NFM_TIPFOR' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'O tipo da fórmula deve ser preenchido!';
    End;
  End
  Else If strNomeCampo = 'NFM_PROCHA' Then
  Begin
    If strValorCampo = 'S' Then
    Begin
      If TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('PROCHA')) Then
      Begin
        tela['chkChaCor']['Checked'].Value := False;
        GetQueryCadastro.FieldByName('NFM_PROCHA').AsString := 'N';
        Result := False;
        strRetorno := 'É necessário configurar um produto chapinha.' +  #13#10 + 'Verificar as configurações da tinta.';
      End;
    End;
  End
  else if LeftStr(strNomeCampo, 8) = 'NFM_CODB' then
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm01']['Text'].Value) then
    begin
      Result := False;
      strRetorno := 'É necessário digitar pelo menos 1 Base!';
    end
    else if not TStrUtils.fEmptyStr(strValorCampo) then
    begin
      if not ValidarBase(strValorCampo) then
      begin
        Result := False;
        strRetorno := 'Base não encontrada!';
      end
      else if not ValidarBaseJaCadastrado(tela, strValorCampo, strNomeCampo) then
      begin
        Result := False;
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse Base já está cadastrada para essa nova fórmula!', ['&Ok']);
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
        strRetorno := 'A quantidade da Base foi informada. Por favor, informe seu código.';
      end
    end;
  end
  else if (LeftStr(strNomeCampo, 8) = 'NFM_QTDC') then
  begin
    strCampoBase := 'dbeForm' + RightStr(strNomeCampo, 2);

    strCampoQtd := 'dbeQtdC' + RightStr(strNomeCampo, 2);
    strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_CODB', [rfReplaceAll])).AsString) then
    begin

      if TStrUtils.fEmptyStr(strValorCampo) then
      begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade da Base!';
      end
      else if (strToFloatDef(strValorCampo, 0) <= 0) then
      begin
        if (strToFloatDef(strValorCampo, 0) <= 0) then
        begin
          Result := False;
          strRetorno := 'A quantidade da Base deve ser maior que Zero!';
        end;
      end;
    end
    else
    if (strToFloatDef(strValorCampoQtd, -1) > 0) And TStrUtils.fEmptyStr(tela[strCampoBase]['Text'].Value) Then
     begin
       Result := False;
       strRetorno := 'A quantidade foi informada sem que a base fosse preenchida!';
     end
  end
  else
  if strNomeCampo = 'NFM_ACRMOB' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbeAcrMob']['Text'].Value := '0,0000';
    end
    Else If (strToFloatDef(tela['dbeAcrMob']['Text'].Value, 0) < 0) Then
    Begin
      Result := False;
      strRetorno := 'O Acréscimo de Mão de Obra deve ser maior ou igual a zero!';
    End;
  end
  else if (not fValidarPreenchimentoCol(tela)) then
  begin
    Result     := False;
    strRetorno := 'Não é permitido o preenchimento aleatório das Bases, para concluir preencha os campos conforme a sequência numérica!';
  end
end;

function TCadastroNovasFormulasDuxone.fValidarPreenchimentoCol(
  const tela: ITelaCadLibTintas): Boolean;
var
  intCont       : Integer;
  blnCampoVazio : Boolean;
begin
  Result        := true;
  blnCampoVazio := false;

  for intCont := 1 to 20 do
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value)
     and not (blnCampoVazio) then
      blnCampoVazio := true
    else
    if not TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value)
      and (blnCampoVazio) then
    begin
      Result := false;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasDuxone.fVerificaNovFormulas(
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

function TCadastroNovasFormulasDuxone.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasDuxone.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasDuxone.GetDescDbComboBox: String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DISTINCT(BAS_LINHA_) FROM DUX_CADBAS ORDER BY BAS_LINHA_';
  qryGen.Open;

  Result := 'DUXONE, 2ST';

  If Not qryGen.IsEmpty Then
  Begin
    Result := '';
    While Not qryGen.Eof Do
    Begin
      Result := Result + qryGen.FieldByName('BAS_LINHA_').AsString + ',';

      qryGen.Next;
    End;
    Result := Copy(Result,1,Length(Result) - 1);
  End;
end;

function TCadastroNovasFormulasDuxone.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasDuxone.GetNomeCampoItem: string;
begin
  Result := 'NFM_CODB';
end;

function TCadastroNovasFormulasDuxone.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasDuxone.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasDuxone.GetNomeTabela: string;
begin
  Result := 'DUX_CADNFM';
end;

function TCadastroNovasFormulasDuxone.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasDuxone.GetTipoFormula: Boolean;
begin
  Result := True;
end;

function TCadastroNovasFormulasDuxone.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroNovasFormulasDuxone.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasDuxone.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    IntPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGetInteger('NFMDUX');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString);

    GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasDuxone.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmDux: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoDuxoneNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmDux := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('DUX').pSet('NFMDUX',strNfmDux);
    End;

    tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
  end;
end;

procedure TCadastroNovasFormulasDuxone.IncluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
end;

procedure TCadastroNovasFormulasDuxone.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value := False;
  tela['chkAtivad']['Checked'].Value := True;

  If TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('PROCHA')) Then
  Begin
    Tela['chkChaCor']['Checked'].Value := False;
    GetQueryCadastro.FieldByName('NFM_PROCHA').AsString := 'N';
  End
  Else
  Begin
    Tela['chkChaCor']['Checked'].Value := True;
    GetQueryCadastro.FieldByName('NFM_PROCHA').AsString := 'S';
  End;

  If TAutcomTintaFactory.Get.fGetConfTinta('DUX').fGet('TRACHA') = 'N' Then
    Tela['chkChaCor']['Enabled'].Value := False
  Else
    Tela['chkChaCor']['Enabled'].Value := True;

  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate  := Date;
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
  GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString := 'Concentrado/Diluído';

  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasDuxone.pAtivaCadDUX;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE DUX_CADDUX ' +
                '   SET DUX_ATIVO_ = :ATIVAD ' +
                ' WHERE DUX_CODNFM = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasDuxone.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE DUX_CADNFM           ' +
                '    SET NFM_ATIVO_ = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasDuxone.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadDUX;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' +
      TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' +
        TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasDuxone.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasDuxone.pAtualizarProxCodigo(intProxCod: Integer);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE CFGTIN '+
                '    SET CFG_VALCFG = :VALCFG  '+
                '  WHERE CFG_IDEPRO = "DUX"    '+
                '    AND CFG_CODCFG = "NFMDUX" '+
                '    AND CFG_CODEMP = :CODEMP  ';

  qryGen.ParamByName('VALCFG').AsString := TStrUtils.fStrZero(IntToStr(IntProxCod + 1), 5);
  qryGen.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasDuxone.pBotaoAtivarNfm(
  const tela: ITelaCadLibTintas);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  If Not GetQueryCadastro.IsEmpty Then
  Begin
    tela['btnAtivarNfm']['Enabled'].Value := VerificarNovaFormulaMovimentada;
    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(tela['btnAtivarNfm']['Enabled'].Value,
                            TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar'),'Ativar');
  End;
end;


procedure TCadastroNovasFormulasDuxone.pCalcularTotalVolume(
  const tela: ITelaCadLibTintas);
var
  intContador: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  If Self.GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString = 'Concentrado' Then
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdCon :=  tela['dbeQtdC' + TStrUtils.fstrZero(intContador, 2)]['Text'].Value;

      If qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intContador, 2)]['Text'].Value, []) Then
        fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));

    End;

    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado)', [fltTotalConcentrado]);
  End
  Else If Self.GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString = 'Diluído' Then
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdDil := tela['dbeQtdC' + TStrUtils.fstrZero(intContador, 2)]['Text'].Value;

      If qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intContador, 2)]['Text'].Value, []) Then
        fltTotalDiluido := fltTotalDiluido + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;

    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Diluído)', [fltTotalDiluido]);
  End
  Else
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdCon := tela['dbeQtdC' + TStrUtils.fstrZero(intContador, 2)]['Text'].Value;
      strQtdDil := tela['dbeQtdC' + TStrUtils.fstrZero(intContador, 2)]['Text'].Value;

      If qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intContador, 2)]['Text'].Value, []) Then
      Begin
        fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
        fltTotalDiluido     := fltTotalDiluido     + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      End;
    End;

    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
  End;
end;

procedure TCadastroNovasFormulasDuxone.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(tela);
  tela['btnAjustarVolume']['Enabled'].Value := False;
end;

procedure TCadastroNovasFormulasDuxone.PreencherTipoFormula(
  const tela: ITelaCadLibTintas; Items: TStrings);
begin
  tela['DBTipoFormula']['Visible'].Value := True;
  tela['DBTipoFormula']['Top'].Value := 122;
  tela['DBTipoFormula']['Left'].Value := 325;
  tela['DBTipoFormula']['Width'].Value := 150;
  tela['DBTipoFormula']['Height'].Value := 22;
  tela['DBTipoFormula']['DataField'].Value := 'NFM_TIPFOR';
  tela['DBTipoFormula']['TabOrder'].Value := 9;

  Items.Add('Concentrado');
  Items.Add('Diluído');
  Items.Add('Concentrado/Diluído');
end;

function TCadastroNovasFormulasDuxone.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

procedure TCadastroNovasFormulasDuxone.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (strState = 'dsEdit') Or (strState = 'dsInsert') Then
    Tela['btnCarregarBases']['Visible'].Value := True
  Else
    Tela['btnCarregarBases']['Visible'].Value := False;
end;

function TCadastroNovasFormulasDuxone.ValidarBase(
  const strCodBas: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   DUX_CADBAS               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
    ' WHERE BAS_CODBAS = :CODBAS ',
    'QTD', [strCodBas]
  ) > 0;
end;

function TCadastroNovasFormulasDuxone.ValidarBaseJaCadastrado(
  const tela: ITelaCadLibTintas; const strCodBas, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 20 Do
  Begin
    If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont,2)) And
       (Not TStrUtils.fEmptyStr( tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value )) Then
    Begin
      If tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value = strCodBas Then
        Result := False;
    End;
  End;
end;

function TCadastroNovasFormulasDuxone.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result :=
        fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD '+
                                         '  FROM %0:s '+
                                         ' INNER JOIN DUX_CADDUX ON %1:s_ITETIN = DUX_MD5KEY '+
                                         ' WHERE %1:s_IDEPRO = "DUX" '+
                                         '   AND DUX_CODNFM = :CODNFM',
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

{ TBtnAjustarVolumeOnClick }

procedure TBtnAjustarVolumeOnClick.AjustarVolume(const tela: ITelaCadLibTintas);
var
  intContador: Integer;
begin
  pCalcularTotalVolume(Cadastro);

  For intContador := 1 To 20 Do
  Begin
    If qryBases.Locate('BAS_CODBAS', Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, []) Then
    Begin
      If (fltTotalConcentrado > 0) Or (fltTotalDiluido > 0) Then
      Begin
        If Cadastro.GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString = 'Concentrado' Then
          Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * 1000 / fltTotalConcentrado
        Else If Cadastro.GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString = 'Diluído' Then
          Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * 1000 / fltTotalDiluido
        Else
          Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat * 1000 / fltTotalConcentrado;
      End;
    End;
  End;

  pCalcularTotalVolume(Cadastro);
end;

procedure TBtnAjustarVolumeOnClick.ConstruirQryBasesValume;
Var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT                  ';
  strSQL := strSQL + '    BAS_CODBAS,           ';
  strSQL := strSQL + '    BAS_PESESP            ';
  strSQL := strSQL + '  FROM                    ';
  strSQL := strSQL + '    DUX_CADBAS            ';

  If TAutcomTintaFactory.Get.GetEmpBasDux Then
    strSQL := strSQL + '  WHERE BAS_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '"    ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.Close;
  qryBases.SQL := strSQL;
  qryBases.Open;
end;

procedure TBtnAjustarVolumeOnClick.OnClick(Sender: TObject);
var
  intContador: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  ConstruirQryBasesValume;

  AjustarVolume(Tela);

  If Cadastro.GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString = 'Concentrado' Then
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdCon := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsString;

      If qryBases.Locate('BAS_CODBAS', Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, []) Then
        fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End
  Else If Cadastro.GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString = 'Diluído' Then
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdDil := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsString;

      If qryBases.Locate('BAS_CODBAS', Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, []) Then
        fltTotalDiluido := fltTotalDiluido + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil)) / (TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;
  End
  Else
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdCon := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsString;
      strQtdDil := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsString;

      If qryBases.Locate('BAS_CODBAS', Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, []) Then
      Begin
        fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
        fltTotalDiluido := fltTotalDiluido + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil)) / (TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      End;
    End;
  End;
end;

procedure TBtnAjustarVolumeOnClick.pCalcularTotalVolume(
  const cadastro: TAbstractCadastro);
var
  intContador: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  If Cadastro.GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString = 'Concentrado' Then
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdCon :=  Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsString;

      If qryBases.Locate('BAS_CODBAS', Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, []) Then
        fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));

    End;

    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado)', [fltTotalConcentrado]);
  End
  Else If Cadastro.GetQueryCadastro.FieldByName('NFM_TIPFOR').AsString = 'Diluído' Then
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdDil := Cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsString;

      If qryBases.Locate('BAS_CODBAS', cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, []) Then
        fltTotalDiluido := fltTotalDiluido + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    End;

    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Diluído)', [fltTotalDiluido]);
  End
  Else
  Begin
    For intContador := 1 To 20 Do
    Begin
      strQtdCon := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intContador, 2)).AsString;
      strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intContador, 2)).AsString;

      If qryBases.Locate('BAS_CODBAS', Cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString, []) Then
      Begin
        fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
        fltTotalDiluido     := fltTotalDiluido     + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      End;
    End;

    tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
  End;
end;

end.
