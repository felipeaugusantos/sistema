unit untCadastroNovasFormulasDupont;

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
  TCadastroNovasFormulasDupont = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    qryBases    : IDataSet;
    intPrxNfm   : Integer;

    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(const qryCadastro: IDataSet): String;
    function FTemPedidoNfm(): Boolean;

    function ValidarBase(const strCodBas: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas; const strCodBas: string; const strNomCam: string): Boolean;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    procedure pAtivaNfm;
    procedure pAtivaCadDup;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);
    procedure pCalcularTotalVolume(const tela: ITelaCadLibTintas);
    procedure ConstruirQryBasesValume;

    function fInformouQuantidadeDiluida(const tela: ITelaCadLibTintas) : Boolean;
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
  untGenericLibTintaControleVisualWinControl, untDbeCodBasKeyPressDupont,
  untGravandoExecucaoDupontNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untGravandoExecucaoDupontCores, untDbeCodDilKeyPressDupont,
  untDbeCodCatKeyPressDupont, untBtnCarregaFormulasCadastradaOnClickDupont,
  untTypesSistema;
{ TCadastroNovasFormulasDupont }

procedure TCadastroNovasFormulasDupont.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 620;
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

procedure TCadastroNovasFormulasDupont.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasDupont.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDtaCad']['Enabled'].Value := False;
  pCalcularTotalVolume(tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);

  If TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('TRACHA') = 'N' Then
    Tela['chkChaCor']['Enabled'].Value := False
  Else
    Tela['chkChaCor']['Enabled'].Value := True;

  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasDupont.AtivarNovasFormulas(
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

procedure TCadastroNovasFormulasDupont.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(tela);
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);
end;

procedure TCadastroNovasFormulasDupont.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroNovasFormulasDupont.ConstruirQryBasesValume;
var
  strSql: string;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    ' FROM                     ' +
    '   DUP_CADBAS             ';

  If TAutcomTintaFactory.Get.GetEmpBasDup Then
    strSql := strSql + ' WHERE BAS_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := strSql;
  qryBases.Open;
end;

procedure TCadastroNovasFormulasDupont.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  groupCatalise: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 28, 30, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCad', 'Data Cadastro:', 233, 30, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', -47, 54, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', -47, 80, 150, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQualidade', 'Qualidade:', 171, 80, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAlternativa', 'Alternativa:', 351, 80, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMontadora', 'Montadora:', 03, 103, 100, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob', 'Acrésc. Mão de Obra:', 107, 129, 50, 14, 'taRightJustify'));

{
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDiluente', 'Diluente:', 01, 425, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCatalisador', 'Catalisador:', 01, 450, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil', 'Quantidade:', 175, 425, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdCat', 'Quantidade:', 175, 450, 100, 14, 'taRightJustify'));
}

//  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblVolumeTotal', '', 555, 420, 100, 14, 'taRightJustify')); //Calcula o volume total da formula

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
      ' object lblVolumeTotal: TLabel                               ' +
      '   Left         = 410                                        ' +
      '   Top          = 433                                        ' +
      '   Width        = 370                                        ' +
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
      ' object lblCadastrar: TLabel                                 ' +
      '   Left         = 479                                        ' +
      '   Top          = 455                                        ' +
      '   Width        = 300                                        ' +
      '   Height       = 14                                         ' +
//      '   Align        = alRight                                    ' +
      '   Alignment    = taRightJustify                             ' +
      '   AutoSize     = False                                      ' +
      '   Caption      = ''Cadastrar a fórmula no volume de 900ml'' ' +
      '   Color        = clTeal                                     ' +
      '   Font.Charset = ANSI_CHARSET                               ' +
      '   Font.Color   = clRed                                      ' +
      '   Font.Height  = 16                                         ' +
      '   Font.Name    = ''Arial''                                  ' +
      '   Font.Pitch   = fpVariable                                 ' +
      '   Font.Style   = [fsBold]                                   ' +
      '   ParentColor  = False                                      ' +
      '   ParentFont   = False                                      ' +
      ' end                                                         ' ));

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

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkChaCor', 280, 125, 250, 17, 'Utilizar chapinha para acerto de cor', 'NFM_PROCHA', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '8'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 483, 125, 70, 17, 'Ativa', 'NFM_ATIVO_', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9'))
  );

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnCarregarBases: TSpeedButton                        ' +
    '   Left = 35                                                  ' +
    '   Top = 160                                                  ' +
    '   Width = 600                                                ' +
    '   Height = 23                                                ' +
    '   Hint = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''         ' +
    '   Caption = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''      ' +
    '   ParentShowHInt = False                                      ' +
    '   ShowHint = True                                             ' +
    '   Visible = True                                              ' +
    ' End                                                           ')
    .AdicionarEvento(TBtnCarregaBasesCadastrada.Create(Self)));

  groupCatalise := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbCatali', 550, 26, 230, 130)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', ' Catalise '));
//    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9'));

  groupCatalise.AdicionarControle(TGenericLibTintaControleVisualDBMemoFocus.Create('dbeCatali', 03, 13, 223, 115, 'NFM_CATALI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99)));

  AdicionarControle(groupCatalise);

  groupBases := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbBases', 1, 183, 790, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alNone'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Bases      '))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '10'));

  for intCont := 1 to 10 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 8, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Conc.:', 153, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Dil.:', 260, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 68,
      22 * intCont, 80, 22, 'ttAlfanumerico', 'NFM_CODB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressDupont.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 211,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdD' + TStrUtils.fStrZero(intCont , 2), 318,
      22 * intCont, 55, 22, 'ttAlfanumerico', 'NFM_QTDD' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    If intCont <= 18 Then
    Begin
      groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
        Format('Código %.2d:', [intCont]), 400, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

      groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
        'Qtd. Conc.:', 552, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

      groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil' + TStrUtils.fStrZero(intCont, 2),
        'Qtd. Dil.:', 660, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

      groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 460,
        22 * (intCont - 10), 80, 22, 'ttAlfanumerico', 'NFM_CODB' + TStrUtils.fStrZero(intCont, 2))
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
        .AdicionarEvento(TDbeCodBasKeyPressDupont.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
      );

      groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdC' + TStrUtils.fStrZero(intCont , 2), 610,
        22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_QTDC' + TStrUtils.fStrZero(intCont, 2))
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      );

      groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdD' + TStrUtils.fStrZero(intCont , 2), 720,
        22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_QTDD' + TStrUtils.fStrZero(intCont, 2))
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      );
    End
    Else
    Begin
      If intCont = 19 Then
      Begin
        groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDiluente', 'Diluente:', 400, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

        groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil', 'Quantidade:', 552, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

        groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodDil', 460, 22 * (intCont - 10), 80, 22, 'ttAlfanumerico', 'NFM_CODDIL')
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
        .AdicionarEvento(TDbeCodDilKeyPressDupont.Create(Self, 'dbeCodDil')));

        groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdDil', 610, 22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_QTDDIL')
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
        );
      End;

      If intCont = 20 Then
      Begin
        groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCatalisador', 'Catalisador:', 400, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

        groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdCat', 'Quantidade:', 552, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

        groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodCat', 460, 22 * (intCont - 10), 80, 22, 'ttAlfanumerico', 'NFM_CODCAT')
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
        .AdicionarEvento(TDbeCodCatKeyPressDupont.Create(Self, 'dbeCodCat')));

        groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdCat', 610, 22 * (intCont - 10), 55, 22, 'ttAlfanumerico', 'NFM_QTDCAT')
        .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
        );
      End;
    End;
  end;

  AdicionarControle(groupBases);

{
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodDil', 105, 420, 100, 22, 'ttAlfanumerico', 'NFM_CODDIL')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '11'))
  .AdicionarEvento(TDbeCodDilKeyPressDupont.Create(Self, 'dbeCodDil'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdDil', 277, 420, 50, 22, 'ttAlfanumerico', 'NFM_QTDDIL')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '12')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodCat', 105, 445, 100, 22, 'ttAlfanumerico', 'NFM_CODCAT')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '13'))
  .AdicionarEvento(TDbeCodCatKeyPressDupont.Create(Self, 'dbeCodCat'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdCat', 277, 445, 50, 22, 'ttAlfanumerico', 'NFM_QTDCAT')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '14')));
}

  AdicionarControle(
    TLibTintaControleVisualImplementacao.Create(
      ' object btnAjustarVolume: TBitBtn                                        ' +
      '   Left    = 515                                                         ' +
      '   Top     = 475                                                         ' +
      '   Width   = 119                                                         ' +
      '   Height  = 20                                                          ' +
      '   Hint    = ''Clique aqui para ajustar o Volume para 900 ml''           ' +
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

procedure TCadastroNovasFormulasDupont.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM DUP_CADDUP WHERE DUP_CODNFM = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasDupont.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasDupont.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
end;

function TCadastroNovasFormulasDupont.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasDupont.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasDupont.fGetMd5KeyPedidos(
  const qryCadastro: IDataSet): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM DUP_CADDUP        ';
  qryGen.SQL := qryGen.SQL + '  WHERE DUP_CODDUP = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('DUP_MD5KEY').AsString;
end;

function TCadastroNovasFormulasDupont.fInformouQuantidadeDiluida(const tela: ITelaCadLibTintas): Boolean;
var
  intCont: Integer;
begin
  Result := False;

  For intCont := 1 to 18 Do
  Begin
    If strToFloatDef(tela['dbeQtdD' + TStrUtils.fStrZero(intCont,2)]['Text'].Value,0) > 0 Then
      Result := True;
  End;
end;

procedure TCadastroNovasFormulasDupont.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(LeftStr(strNomeCampo, Length('NFM_QTDC')), ['NFM_QTDC', 'NFM_QTDD']) then //MatchStr(strNomeCampo, ['NFM_QTDCAT','NFM_QTDDIL']))
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

function TCadastroNovasFormulasDupont.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasDupont.fPodeAlterar: Boolean;
begin
  Result := True;
  If VerificarNovaFormulaMovimentada Then
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

function TCadastroNovasFormulasDupont.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasDupont.fPodeIncluir(
  const tela: ITelaCadLibTintas; const strState: String): Boolean;
begin
  Result := true;
end;

function TCadastroNovasFormulasDupont.FTemPedidoNfm: Boolean;
Var
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
    qryGen.ParamByName('IDEPRO').AsString := 'DUP';
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      Result := True;
      Exit;
    End;

    Result := Not qryGen.IsEmpty;

    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Esta alteração impedirá que ele seja faturado e obrigará a substituição da tinta no pedido antes de faturá-lo');
    TAutcomTintaFactory.Get.pAddDados(arrMensagem, 'Seguem pedidos em aberto com esta formulação:');
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

function TCadastroNovasFormulasDupont.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;

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
  Else If strNomeCampo = 'NFM_PROCHA' Then
  Begin
    If strValorCampo = 'S' Then
    Begin
      If TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('PROCHA')) Then
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
      Else
      Begin
        strCampoQtd := 'dbeQtdD' + RightStr(strNomeCampo, 2);
        strValorCampoQtd := tela[strCampoQtd]['Text'].Value;
        if strToFloatDef(strValorCampoQtd, -1) > 0 then
        begin
          Result := False;
          strRetorno := 'A quantidade da Base foi informada. Por favor, informe seu código.';
        end
      End;
    end;
  end
  else if (LeftStr(strNomeCampo, 8) = 'NFM_QTDC') And (strNomeCampo <> 'NFM_QTDCAT') then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDC', 'NFM_CODB', [rfReplaceAll])).AsString) then
    begin
      strCampoQtd := 'dbeQtdD' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      if TStrUtils.fEmptyStr(strValorCampo) then
      begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade da Base!';
      end
      else if (strToFloatDef(strValorCampo, 0) <= 0) then
      begin
        if (strToFloatDef(strValorCampo, 0) < 0) then
        begin
          Result := False;
          strRetorno := 'A quantidade da Base deve ser maior ou igual a Zero!';
        end;
      end;
    end;
  end
  else if (LeftStr(strNomeCampo, 8) = 'NFM_QTDD') And (strNomeCampo <> 'NFM_QTDDIL') then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDD', 'NFM_CODB', [rfReplaceAll])).AsString) then
    begin
      strCampoQtd := 'dbeQtdC' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;
      if TStrUtils.fEmptyStr(strValorCampo) then
      begin
        Result := False;
        strRetorno := 'É necessário digitar a quantidade da Base!';
      end
      else if (strToFloatDef(strValorCampo, 0) <= 0) and
              (strToFloatDef(strValorCampoQtd, -1) <= 0) then
      begin
        Result := False;
        strRetorno := 'A quantidade da Base deve ser maior que Zero!';
      end
      else if (strToFloatDef(strValorCampo, 0) <= 0) then
      begin
        if (strToFloatDef(strValorCampo, 0) < 0) then
        begin
          Result := False;
          strRetorno := 'A quantidade da Base deve ser maior ou igual a Zero!';
        end;
      end;
    end;
  end

  Else if strNomeCampo = 'NFM_CODDIL' Then
  Begin
    If (Not TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      If (Not ValidarBase(strValorCampo)) Then
      Begin
        Result := False;
        strRetorno := 'Diluente não encontrado!';
      End;
    End;
  End

  Else if strNomeCampo = 'NFM_CODCAT' Then
  Begin
    If (Not TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      If (Not ValidarBase(strValorCampo)) Then
      Begin
        Result := False;
        strRetorno := 'Catalisador não encontrado!';
      End;
    End;
  End

  Else If strNomeCampo = 'NFM_QTDDIL' Then
  Begin
    If (Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value)) Then
    Begin

      If (strToFloatDef(strValorCampo, 0) <= 0) Then
      Begin
        Result := False;
        strRetorno := 'A quantidade do diluente deve ser maior que Zero!';
      End;

    End;
  End

  Else If strNomeCampo = 'NFM_QTDCAT' Then
  Begin
    If (Not TStrUtils.fEmptyStr(tela['dbeCodCat']['Text'].Value)) Then
    Begin

      If (strToFloatDef(strValorCampo, 0) <= 0) Then
      Begin
        Result := False;
        strRetorno := 'A quantidade do catalisador deve ser maior que Zero!';
      End;

    End;

    If Result Then
      tela.pSetarFocus;
  End

  else if strNomeCampo = 'NFM_ACRMOB' then
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
  else if fInformouQuantidadeDiluida(tela) and TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value) then
  begin
    Result     := False;
    strRetorno := 'Ao informar uma quantidade diluída, é necessário que o diluente seja preenchido!';
  end
  else if (not (fInformouQuantidadeDiluida(tela))) and (not (TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value))) then
  begin
    Result     := False;
    strRetorno := 'A Quantidade diluída deve ser preenchida ao informar o diluente!';
  end
  else if ((tela['dbeQtdDil']['Text'].Value <> '0,000') and (not (TStrUtils.fEmptyStr(tela['dbeQtdDil']['Text'].Value)))) and (TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value)) then
  begin
    Result     := False;
    strRetorno := 'Preencha o diluente para a quantidade Informada!';
  end
  else if ((not (TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value)))) and ((tela['dbeQtdDil']['Text'].Value = '0,000') or (TStrUtils.fEmptyStr(tela['dbeQtdDil']['Text'].Value))) then
  begin
    Result     := False;
    strRetorno := 'Informe a quantidade do diluente!';
  end;
end;

function TCadastroNovasFormulasDupont.fValidarPreenchimentoCol(
  const tela: ITelaCadLibTintas): Boolean;
var
  intCont       : Integer;
  blnCampoVazio : Boolean;
begin
  Result        := true;
  blnCampoVazio := false;

  for intCont := 1 to 18 do
  begin
    if TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and not (blnCampoVazio) then
      blnCampoVazio := true
    else if not TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and (blnCampoVazio) then
    begin
      Result := false;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasDupont.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT                                  ';
  qryGen.SQL := qryGen.SQL + '    * FROM '  + GetNomeTabela +   '       ';
  qryGen.SQL := qryGen.SQL + '  WHERE ' + GetNomeCampo +  ' = :NFM      ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

function TCadastroNovasFormulasDupont.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasDupont.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroNovasFormulasDupont.GetDescDbComboBox: String;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DISTINCT(BAS_LINHA_) FROM DUP_CADBAS ORDER BY BAS_LINHA_';
  qryGen.Open;

  Result := 'CHROMA, CORMAX, DUXONE, IMRON, NASON';

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

function TCadastroNovasFormulasDupont.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasDupont.GetNomeCampoItem: string;
begin
  Result := 'NFM_CODB';
end;

function TCadastroNovasFormulasDupont.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasDupont.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasDupont.GetNomeTabela: string;
begin
  Result := 'DUP_CADNFM';
end;

function TCadastroNovasFormulasDupont.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasDupont.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroNovasFormulasDupont.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasDupont.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGetInteger('NFMDUP');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));


    GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasDupont.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmDup: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoDupontNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmDup := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('DUP').pSet('NFMDUP',strNfmDup);
    End;

    tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);

  end;
end;

procedure TCadastroNovasFormulasDupont.IncluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
end;

procedure TCadastroNovasFormulasDupont.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value := False;

  If TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('PROCHA')) Then
  Begin
    Tela['chkChaCor']['Checked'].Value := False;
    GetQueryCadastro.FieldByName('NFM_PROCHA').AsString := 'N';
  End
  Else
  Begin
    Tela['chkChaCor']['Checked'].Value := True;
    GetQueryCadastro.FieldByName('NFM_PROCHA').AsString := 'S';
  End;

  If TAutcomTintaFactory.Get.fGetConfTinta('DUP').fGet('TRACHA') = 'N' Then
    Tela['chkChaCor']['Enabled'].Value := False
  Else
    Tela['chkChaCor']['Enabled'].Value := True;

  tela['chkAtivad']['Checked'].Value := True;
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate  := Date;
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela['btnAjustarVolume']['Enabled'].Value := Not MatchStr(strState, ['dsBrowse', 'dsInactive']);

  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasDupont.pAtivaCadDup;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE DUP_CADDUP ' +
                '   SET DUP_ATIVO_ = :ATIVAD ' +
                ' WHERE DUP_CODNFM = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasDupont.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE DUP_CADNFM           ' +
                '    SET NFM_ATIVO_ = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasDupont.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadDup;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasDupont.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;


procedure TCadastroNovasFormulasDupont.pBotaoAtivarNfm(
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

procedure TCadastroNovasFormulasDupont.pCalcularTotalVolume(const tela: ITelaCadLibTintas);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;
  for intCont := 1 to 18 do
  begin
    strQtdCon := tela['dbeQtdC' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;
    strQtdDil := tela['dbeQtdD' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;

    if qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) then
    begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido     := fltTotalDiluido     + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  end;

  //Diluente
  If Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value) Then
  Begin
    strQtdDil := tela['dbeQtdDil']['Text'].Value;

    if qryBases.Locate('BAS_CODBAS', tela['dbeCodDil']['Text'].Value, []) then
    begin
      fltTotalDiluido := fltTotalDiluido +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) /
          TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  End;

  //Catalisador
  If Not TStrUtils.fEmptyStr(tela['dbeCodCat']['Text'].Value) Then
  Begin
    strQtdDil := tela['dbeQtdCat']['Text'].Value;

    if qryBases.Locate('BAS_CODBAS', tela['dbeCodCat']['Text'].Value, []) then
    begin
      fltTotalDiluido := fltTotalDiluido +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) /
          TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  End;

  tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
end;

procedure TCadastroNovasFormulasDupont.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
  pCalcularTotalVolume(tela);
end;

function TCadastroNovasFormulasDupont.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

procedure TCadastroNovasFormulasDupont.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (strState = 'dsEdit') Or (strState = 'dsInsert') Then
    Tela['btnCarregarBases']['Visible'].Value := True
  Else
    Tela['btnCarregarBases']['Visible'].Value := False;
end;

function TCadastroNovasFormulasDupont.ValidarBase(
  const strCodBas: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   DUP_CADBAS               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
    ' WHERE BAS_CODBAS = :CODBAS ',
    'QTD', [strCodBas]
  ) > 0;
end;

function TCadastroNovasFormulasDupont.ValidarBaseJaCadastrado(
  const tela: ITelaCadLibTintas; const strCodBas, strNomCam: string): Boolean;
var
  intCont: Integer;
begin
  Result := True;
  For intCont := 1 To 18 Do
  Begin
    If (RightStr(strNomCam, 2) <> TStrUtils.fStrZero(intCont,2)) And
       (Not TStrUtils.fEmptyStr( tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value )) Then
    Begin
      If tela['dbeForm' + TStrUtils.fStrZero(intCont,2)]['Text'].Value = strCodBas Then
        Result := False;
    End;
  End;
end;

function TCadastroNovasFormulasDupont.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s INNER JOIN DUP_CADDUP ON %1:s_ITETIN = DUP_MD5KEY WHERE %1:s_IDEPRO = "DUP" AND DUP_CODNFM = :CODNFM',
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
  intCont: Integer;
begin
  pCalcularTotalVolume(cadastro);

  for intCont := 1 to 18 do
  begin
    if qryBases.Locate('BAS_CODBAS', cadastro.GetQueryCadastro.FieldByName('NFM_CODB' + TStrUtils.fstrZero(intCont,2)).AsString, []) then
    begin
      if fltTotalConcentrado > 0 then
        cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsFloat := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsFloat * 900 / fltTotalConcentrado;

      if fltTotalDiluido > 0 then
        cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsFloat := cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsFloat * 900 / fltTotalDiluido;
    end;
  end;

  if fltTotalDiluido > 0 then
    cadastro.GetQueryCadastro.FieldByName('NFM_QTDDIL').AsFloat :=
      cadastro.GetQueryCadastro.FieldByName('NFM_QTDDIL').AsFloat * 900 / fltTotalDiluido;

  if fltTotalDiluido > 0 then
    cadastro.GetQueryCadastro.FieldByName('NFM_QTDCAT').AsFloat :=
      cadastro.GetQueryCadastro.FieldByName('NFM_QTDCAT').AsFloat * 900 / fltTotalDiluido;

  pCalcularTotalVolume(cadastro);
end;

procedure TBtnAjustarVolumeOnClick.ConstruirQryBasesValume;
var
  strSql: string;
begin
  strSql :=
    ' SELECT                   ' +
    '   BAS_CODBAS             ' +
    '   , BAS_PESESP           ' +
    ' FROM                     ' +
    '   DUP_CADBAS             ';

  If TAutcomTintaFactory.Get.GetEmpBasDup Then
    strSql := strSql + ' WHERE BAS_CODEMP = "' + TAutcomTintaFactory.Get.GetCodEmp + '" ';

  qryBases := TAutcomTintaFactory.Get.fGetDataSet;
  qryBases.SQL := strSql;
  qryBases.Open;
end;

procedure TBtnAjustarVolumeOnClick.OnClick(Sender: TObject);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  ConstruirQryBasesValume;

  AjustarVolume(tela);

  for intCont := 1 to 18 do
  begin
    strQtdCon := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsString;
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsString;

    if qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) then
    begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido     := fltTotalDiluido     + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  end;

  //Diluente
  If Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value) Then
  Begin
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDDIL').AsString;

    if qryBases.Locate('BAS_CODBAS', tela['dbeCodDil']['Text'].Value, []) then
    begin
      fltTotalDiluido := fltTotalDiluido +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) /
          TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  End;

  //Catalisador
  If Not TStrUtils.fEmptyStr(tela['dbeCodCat']['Text'].Value) Then
  Begin
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDCAT').AsString;

    if qryBases.Locate('BAS_CODBAS', tela['dbeCodCat']['Text'].Value, []) then
    begin
      fltTotalDiluido := fltTotalDiluido +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) /
          TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  End;
end;

procedure TBtnAjustarVolumeOnClick.pCalcularTotalVolume(
  const cadastro: TAbstractCadastro);
var
  intCont: Integer;
  strQtdCon: String;
  strQtdDil: String;
begin
  fltTotalConcentrado := 0;
  fltTotalDiluido     := 0;

  for intCont := 1 to 18 do
  begin
    strQtdCon := cadastro.GetQueryCadastro.FieldByName('NFM_QTDC' + TStrUtils.fstrZero(intCont,2)).AsString;   //tela['dbeQtdC' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDD' + TStrUtils.fstrZero(intCont,2)).AsString;   // tela['dbeQtdD' + TStrUtils.fstrZero(intCont,2)]['Text'].Value;

    if qryBases.Locate('BAS_CODBAS', tela['dbeForm' + TStrUtils.fstrZero(intCont,2)]['Text'].Value, []) then
    begin
      fltTotalConcentrado := fltTotalConcentrado + (TAutcomTintaFactory.Get.fStrToFloat(strQtdCon) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
      fltTotalDiluido     := fltTotalDiluido     + (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) / TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  end;

  //Diluente
  If Not TStrUtils.fEmptyStr(tela['dbeCodDil']['Text'].Value) Then
  Begin
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDDIL').AsString;

    if qryBases.Locate('BAS_CODBAS', tela['dbeCodDil']['Text'].Value, []) then
    begin
      fltTotalDiluido := fltTotalDiluido +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) /
          TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  End;

  //Catalisador
  If Not TStrUtils.fEmptyStr(tela['dbeCodCat']['Text'].Value) Then
  Begin
    strQtdDil := cadastro.GetQueryCadastro.FieldByName('NFM_QTDCAT').AsString;

    if qryBases.Locate('BAS_CODBAS', tela['dbeCodCat']['Text'].Value, []) then
    begin
      fltTotalDiluido := fltTotalDiluido +
        (TAutcomTintaFactory.Get.fStrToFloat(strQtdDil) /
          TAutcomTintaFactory.Get.fStrToFloat(qryBases.FieldByName('BAS_PESESP').AsString));
    end;
  End;

  tela['lblVolumeTotal']['Caption'].Value := Format('Volume total: %.2f ml (Concentrado), %.2f ml (Diluído)', [fltTotalConcentrado, fltTotalDiluido]);
end;

end.
