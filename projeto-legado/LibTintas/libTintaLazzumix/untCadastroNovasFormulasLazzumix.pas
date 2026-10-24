unit untCadastroNovasFormulasLazzumix;

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
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta, untIDataSet;

type
  TCadastroNovasFormulasLazzumix = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    intPrxNfm: Integer;

    function ValidarBase(const strCodBas: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas; const strCodBas: string; const strNomCam: string): Boolean;

    function VerificarNovaFormulaMovimentada: Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);

    procedure pAtivaNfm;
    procedure pAtivaCadSuv;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
    procedure pBotaoAtivarNfm(const tela: ITelaCadLibTintas);

    function fPermiteAlterarNfmVendida(): Boolean;
    function fGetMd5KeyPedidos(const qryCadastro: IDataSet): String;
    function FTemPedidoNfm(): Boolean;
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
//    function GetCampoEmbalagem: string; override;
//    function GetCampoPesoEspecifico: string; override;
    function GetPreencherDbComboBox: Boolean; override;
    function GetDescDbComboBox: String; override;
  end;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasLazzumix, untDbeCodBasKeyPressLazzumix,
  untGravandoExecucaoLazzumixNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica,
  untGravandoExecucaoLazzumixCores, untBtnCarregaFormulasCadastradaOnClickLazzumix,
  untTypesSistema;
{ TCadastroNovasFormulasLazzumix }

procedure TCadastroNovasFormulasLazzumix.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 530;
  tela.GetSelf['Width'].Value  := 800;
  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Left'].Value      := 115;
  tela['DBComboBox']['Top'].Value       := 74;
  tela['DBComboBox']['Width'].Value     := 200;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'NFM_REFERE';
  tela['DBComboBox']['TabOrder'].Value  := 3;

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasLazzumix.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasLazzumix.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasLazzumix.AtivarNovasFormulas(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  if TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) then
  Begin
    TAutcomTintaFactory.Get.fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString)) And
     (strState = 'dsBrowse') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;

    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar');
  End;
end;

procedure TCadastroNovasFormulasLazzumix.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasLazzumix.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin

end;

procedure TCadastroNovasFormulasLazzumix.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 35, 33, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCad', 'Data Cadastro:', 240, 33, 73, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', -37, 57, 148, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblReferencia', 'Referência:', -37, 83, 150, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMontadora', 'Montadora:', 280, 83, 100, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAno', 'Ano:', 60, 105, 50, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUniversal', 'Cód.Universal:', 250, 105, 50, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblVolCon', 'Volume Concentrado:', 60, 125, 50, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblVolDil', 'Volume Diluido:', 250, 125, 50, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob', 'Acrésc. Mão de Obra:', 60, 149, 50, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 115, 26, 100, 22, 'ttAlfanumerico', 'NFM_CODNFM')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDtaCad', 320, 26, 100, 22, 'ttAlfanumerico', 'NFM_DTACAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 115, 50, 420, 22, 'ttAlfanumerico', 'NFM_DESCRI')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '2'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMontad', 385, 74, 150, 22, 'ttAlfanumerico', 'NFM_MONTAD')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAno', 115, 98, 100, 22, 'ttAlfanumerico', 'NFM_A_N_O_')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeUniversal', 307, 98, 100, 22, 'ttAlfanumerico', 'NFM_UNIVER')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '6')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeVolCon', 115, 121, 100, 22, 'ttAlfanumerico', 'NFM_VOLCON')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '7'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeVolDil', 307, 121, 100, 22, 'ttAlfanumerico', 'NFM_VOLDIL')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '8'))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 495, 125, 70, 17, 'Ativa', 'NFM_ATIVAD', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9'))
  );


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 115, 144, 100, 22, 'ttAlfanumerico', 'NFM_ACRMOB')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '10'))
  );

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnCarregarBases: TSpeedButton                        ' +
    '   Left = 35                                                  ' +
    '   Top = 166                                                  ' +
    '   Width = 600                                                ' +
    '   Height = 23                                                ' +
    '   Hint = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''         ' +
    '   Caption = ''Carregar formulação do catálogo do fornecedor para auxiliar no cadastramento de fórmulas semelhantes''      ' +
    '   ParentShowHInt = False                                      ' +
    '   ShowHint = True                                             ' +
    '   Visible = True                                              ' +
    ' End                                                           ')
    .AdicionarEvento(TBtnCarregaBasesCadastrada.Create(Self)));


  groupBases := TGenericLibTintaControleVisualWinControl.Create('TGroupBox', 'gpbBases', 1, 113, 521, 249)
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Align', 'alBottom'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Caption', '     Bases      '));

  for intCont := 1 to 10 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 8, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Conc.:', 170, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Dil.:', 270, (22 * intCont) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont , 2), 68,
      22 * intCont, 95, 22, 'ttAlfanumerico', 'NFM_CODB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressLazzumix.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdB' + TStrUtils.fStrZero(intCont , 2), 228,
      22 * intCont, 45, 22, 'ttAlfanumerico', 'NFM_QTDB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdD' + TStrUtils.fStrZero(intCont , 2), 328,
      22 * intCont, 45, 22, 'ttAlfanumerico', 'NFM_QTDD' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  for intCont := 11 to 20 do
  begin
    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblForm' + TStrUtils.fStrZero(intCont, 2),
      Format('Código %.2d:', [intCont]), 400, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdConc' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Conc.:', 562, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblQtdDil' + TStrUtils.fStrZero(intCont, 2),
      'Qtd. Dil.:', 655, (22 * (intCont - 10)) + 3, 57, 14, 'taRightJustify'));

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeForm' + TStrUtils.fStrZero(intCont, 2), 460,
      22 * (intCont - 10), 95, 22, 'ttAlfanumerico', 'NFM_CODB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', 7))
      .AdicionarEvento(TDbeCodBasKeyPressLazzumix.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdB' + TStrUtils.fStrZero(intCont , 2), 620,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_QTDB' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );

    groupBases.AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeQtdD' + TStrUtils.fStrZero(intCont , 2), 720,
      22 * (intCont - 10), 45, 22, 'ttAlfanumerico', 'NFM_QTDD' + TStrUtils.fStrZero(intCont, 2))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    );
  end;

  groupBases.AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object Label5: TLabel                                  ' +
    '   Left = 80                                            ' +
    '   Top = 0                                              ' +
    '   Width = 406                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taRightJustify                           ' +
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


  AdicionarControle(groupBases);
end;

procedure TCadastroNovasFormulasLazzumix.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM LAZ_CADMIX WHERE MIX_CODIGO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasLazzumix.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasLazzumix.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
    DeletaNovaFormula(strCodNfmDel);
end;

function TCadastroNovasFormulasLazzumix.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasLazzumix.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasLazzumix.fGetMd5KeyPedidos(
  const qryCadastro: IDataSet): String;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '   SELECT * FROM LAZ_CADMIX        ';
  qryGen.SQL := qryGen.SQL + '  WHERE MIX_CODIGO = :CODIGO      ';
  qryGen.ParamByName('CODIGO').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.Open;

  Result := qryGen.FieldByName('MIX_CODIGO').AsString;
end;

procedure TCadastroNovasFormulasLazzumix.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(LeftStr(strNomeCampo, Length('NFM_QTDB')), ['NFM_QTDB', 'NFM_QTDD']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0';
    arrValores[1] := '0.0';
  end
  else if MatchStr(strNomeCampo, ['NFM_VOLCON', 'NFM_VOLDIL', 'NFM_ACRMOB']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  end;;
end;

function TCadastroNovasFormulasLazzumix.fPermiteAlterarNfmVendida: Boolean;
begin
  Result := TAutcomTintaFactory.Get.fCfgSis('ALTNFM') = 'S';
end;

function TCadastroNovasFormulasLazzumix.fPodeAlterar: Boolean;
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

function TCadastroNovasFormulasLazzumix.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasLazzumix.FTemPedidoNfm: Boolean;
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
    qryGen.ParamByName('IDEPRO').AsString := 'LAZ';
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

function TCadastroNovasFormulasLazzumix.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
  Var
    strCampoQtd: String;
    strValorCampoQtd: String;
begin
  Result := True;

  if LeftStr(strNomeCampo, 8) = 'NFM_CODB' then
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
      strCampoQtd := 'dbeQtdB' + RightStr(strNomeCampo, 2);
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
  else if strNomeCampo = 'NFM_DESCRI' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    end
  end
  else if strNomeCampo = 'NFM_REFERE' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A referência deve ser preenchida!';
    end
  end
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDB' then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDB', 'NFM_CODB', [rfReplaceAll])).AsString) then
    begin
      strCampoQtd := 'dbeQtdD' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      if TStrUtils.fEmptyStr(strValorCampo) And
       (Not((GetQueryCadastro.FieldByName('NFM_VOLCON').AsInteger > 0)And(GetQueryCadastro.FieldByName('NFM_VOLDIL').AsInteger > 0))) then
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
        end
        else if (strToFloatDef(strValorCampo, 0) = 0)And
         (Not((strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) > 0)And(strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) > 0)))then
        begin
          if strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) > 0 Then
          Begin
            Result := False;
            strRetorno := 'A quantidade da Base deve ser maior que Zero já que o volume concentrado está preenchido!';
          End;
        end;
      end
      else If (strToFloatDef(strValorCampo, 0) > 0) And (strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) <= 0) then
      begin
        Result := False;
        strRetorno := 'A quantidade concentrado não pode ser preenchida ja que o volume concentrado é 0 !';
      End;
    end;
  end
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDD' then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDD', 'NFM_CODB', [rfReplaceAll])).AsString) then
    begin
      strCampoQtd := 'dbeQtdB' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      if TStrUtils.fEmptyStr(strValorCampo) And
       (Not((GetQueryCadastro.FieldByName('NFM_VOLCON').AsInteger > 0)And(GetQueryCadastro.FieldByName('NFM_VOLDIL').AsInteger > 0)))then
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
        end
        else if (strToFloatDef(strValorCampo, 0) = 0) And
         (Not((strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) > 0)And(strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) > 0)))then
        begin
          If strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) > 0 Then
          Begin
            Result := False;
            strRetorno := 'A quantidade da Base deve ser maior que Zero já que o volume diluido está preenchido!';
          End;
        end;
      end
      else If (strToFloatDef(strValorCampo, 0) > 0) And (strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) <= 0) then
      begin
        Result := False;
        strRetorno := 'A quantidade diluido não pode ser preenchida ja que o volume diluido é 0 !';
      End;
    end;
  end
  else if strNomeCampo = 'NFM_VOLCON' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbeVolCon']['Text'].Value := 0;
    end
    Else If (strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) < 0) Then
    Begin
      Result := False;
      strRetorno := 'O Volume concentrado deve ser maior ou igual a zero!';
    End;
  end
  else if strNomeCampo = 'NFM_VOLDIL' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbeVolDil']['Text'].Value := 0;
    end
    Else if (Not TStrUtils.fEmptyStr(tela['dbeVolCon']['Text'].Value)) then
    begin
      If (strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) < 0) Then
      Begin
        Result := False;
        strRetorno := 'O Volume Diluido deve ser maior ou igual a zero!';
      End
      Else If (strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) <= 0) And (strToFloatDef(tela['dbeVolDil']['Text'].Value, 0) <= 0) Then
      Begin
        If (strToFloatDef(tela['dbeVolCon']['Text'].Value, 0) < 0) Then
        Begin
          Result := False;
          strRetorno := 'O Volume Concentrado deve ser maior ou igual a zero!';
        End
        Else
        Begin
          Result := False;
          strRetorno := 'Os Volumes: Concentrado e ou Diluído devem ser preenchidos !';
        End;
      End;
    end;
  end
  else if strNomeCampo = 'NFM_ACRMOB' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      tela['dbeAcrMob']['Text'].Value := 0;
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
    strRetorno :='Não é permitido o preenchimento aleatório dos colorantes, para concluir preencha os campos conforme a sequência numérica!';
  end;
end;

function TCadastroNovasFormulasLazzumix.fValidarPreenchimentoCol(
  const tela: ITelaCadLibTintas): Boolean;
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
    else if not TStrUtils.fEmptyStr(tela['dbeForm'+ TStrUtils.fStrZero(intCont, 2)]['Text'].Value) and (blnCampoVazio) then
    begin
      Result := false;
      Break;
    end;
  end;
end;

function TCadastroNovasFormulasLazzumix.fVerificaNovFormulas(
  strCodNfm: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT             ';
  qryGen.SQL := qryGen.SQL + '    * FROM ' + GetNomeTabela + '         ';
  qryGen.SQL := qryGen.SQL + '  WHERE    ' + GetNomeCampo  + ' = :NFM  ';
  qryGen.ParamByName('NFM').AsString := strCodNfm;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

{function TCadastroNovasFormulasLazzumix.GetCampoEmbalagem: string;
begin
  Result := '';
end;}

{function TCadastroNovasFormulasLazzumix.GetCampoPesoEspecifico: string;
begin
  Result := '';
end;}

function TCadastroNovasFormulasLazzumix.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasLazzumix.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasLazzumix.Create;
end;

function TCadastroNovasFormulasLazzumix.GetDescDbComboBox: String;
begin
  Result := 'LAZZULAC,LAZZURIL,LAZZUCRIL,LAZZUDUR,LEGACY,FLEET COLOR,POLIURETANO,ULTRABASE,LAZZUDUR PU MS,SHERTRUCKMIX,PERSONALIZADA';
end;

function TCadastroNovasFormulasLazzumix.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasLazzumix.GetNomeCampoItem: string;
begin
  Result := 'NFM_CODB';
end;

function TCadastroNovasFormulasLazzumix.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasLazzumix.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasLazzumix.GetNomeTabela: string;
begin
  Result := 'LAZ_CADNFM';
end;

function TCadastroNovasFormulasLazzumix.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasLazzumix.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroNovasFormulasLazzumix.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasLazzumix.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('LAZ').fGetInteger('PRONFM');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasLazzumix.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmSuv: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoLazzumixNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmSuv := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('LAZ').pSet('PRONFM',strNfmSuv);
    End;
  end;
end;

procedure TCadastroNovasFormulasLazzumix.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnAtivarNfm']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value := False;
  tela['chkAtivad']['Checked'].Value := True;
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate  := Date;
  GetQueryCadastro.FieldByName('NFM_VOLCON').AsFloat := 0.0000;
  GetQueryCadastro.FieldByName('NFM_VOLDIL').AsFloat := 0.0000;
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasLazzumix.pAtivaCadSuv;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE LAZ_CADMIX ' +
                '   SET MIX_ATIVAD = :ATIVAD ' +
                ' WHERE MIX_CODIGO = :CODNFM';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasLazzumix.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE LAZ_CADNFM           ' +
                '    SET NFM_ATIVAD = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';
  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasLazzumix.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadSuv;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVAD').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasLazzumix.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasLazzumix.pBotaoAtivarNfm(
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

procedure TCadastroNovasFormulasLazzumix.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

function TCadastroNovasFormulasLazzumix.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

procedure TCadastroNovasFormulasLazzumix.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If (strState = 'dsEdit') Or (strState = 'dsInsert') Then
    Tela['btnCarregarBases']['Visible'].Value := True
  Else
    Tela['btnCarregarBases']['Visible'].Value := False;
end;

function TCadastroNovasFormulasLazzumix.ValidarBase(
  const strCodBas: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   LAZ_CADBAS               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
    ' WHERE BAS_CODBAS = :CODBAS ',
    'QTD', [strCodBas]
  ) > 0;
end;

function TCadastroNovasFormulasLazzumix.ValidarBaseJaCadastrado(
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

function TCadastroNovasFormulasLazzumix.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s INNER JOIN LAZ_CADMIX ON %1:s_ITETIN = MIX_CODIGO WHERE %1:s_IDEPRO = "LAZ" AND MIX_CODIGO = :CODNFM',
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

