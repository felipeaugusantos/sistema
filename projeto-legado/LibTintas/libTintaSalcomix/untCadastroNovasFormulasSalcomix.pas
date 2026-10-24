unit untCadastroNovasFormulasSalcomix;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants, untAbstractLibTintaControleVisualEvento,
  SysUtils, untStrUtils, StrUtils, Classes,
  untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untDbeLinhaSalcomixKeyPress,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta;

type
  TCadastroNovasFormulasSalcomix = class(TAbstractCadastro)
  private
    strCodNfmDel: String;
    intPrxNfm: Integer;

    function ValidarBase(const strCodBas: string): Boolean;
    function ValidarBaseJaCadastrado(const tela: ITelaCadLibTintas; const strCodBas: string; const strNomCam: string): Boolean;
    function VerificarNovaFormulaMovimentada: Boolean;
    function fLinhasPermetida(strLinha:String; const tela: ITelaCadLibTintas): Boolean;
    procedure DeletaNovaFormula(strCodNfm: String);


    procedure pAtivaNfm;
    procedure pAtivaCadSAL;
    procedure pAtivarDesativarNfm;
    procedure pAtualizaNfm;
    function fValidarPreenchimentoCol(const tela: ITelaCadLibTintas): Boolean;
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
//    function GetCampoEmbalagem: string; override;
//    function GetCampoPesoEspecifico: string; override;
  end;


implementation

uses
  untGenericLibTintaControleVisualDBCheckBox, untGenericLibTintaControleVisual,
  untGenericLibTintaControleVisualWinControl,
  untConsultaCadastroNovasFormulasSalcomix, untDbeCodBasKeyPressSalcomix,
  untGravandoExecucaoSalcomixNovasFormulas, untGravandoVazio,
  untIGravandoExecucaoNome, untFuncoesGenerica, untIDataSet,
  untGravandoExecucaoSalcomixCores,
  untDbeCodMontadoraKeyPressSalcomix;
{ TCadastroNovasFormulasSalcomix }

procedure TCadastroNovasFormulasSalcomix.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  tela.GetSelf['Height'].Value := 430;
  tela.GetSelf['Width'].Value  := 800;
  tela['btnAtivarNfm']['Visible'].Value := True;

  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Left'].Value      := 445;
  tela['DBComboBox']['Top'].Value       := 30;
  tela['DBComboBox']['Width'].Value     := 100;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'NFM_LINHA_';
  tela['DBComboBox']['TabOrder'].Value  := 2;

  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasSalcomix.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin

end;

procedure TCadastroNovasFormulasSalcomix.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbeDtaCad']['Enabled'].Value := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasSalcomix.AtivarNovasFormulas(
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
    If TAutcomTintaFactory.Get.fMensagem('QUESTÃO', 'Deseja realmente ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' essa nova fórmula ?', ['&Sim','&Não']) = 1 Then
    Begin
      pAtivarDesativarNfm;
      pAtualizaNfm;
    End;

    tela['btnAtivarNfm']['Caption'].Value := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar');
  End;
end;

procedure TCadastroNovasFormulasSalcomix.CancelarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasSalcomix.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  //
end;

procedure TCadastroNovasFormulasSalcomix.ConstruirControles;
var
  groupBases: ILibTintaControleVisual;
  intCont: Integer;
begin

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigoForm', 'Código:', 70, 33, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDataCad', 'Data Cadastro:', 260, 33, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', 425, 33, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 70, 57, 15, 14, 'taRightJustify'));
    AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcrMob', 'Acrésc. Mão de Obra:', 70, 79, 50, 14, 'taRightJustify'));



  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodNfm', 90, 30, 100, 22, 'ttAlfanumerico', 'NFM_CODNFM')
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDtaCad', 280, 30, 100, 22, 'ttAlfanumerico', 'NFM_DTACAD')
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeLinha', 445, 30, 100, 22, 'ttAlfanumerico', 'NFM_LINHA_')
    .AdicionarEvento(TDbeLinhaSalcomixKeyPress.Create('OnKeyPress', Self))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 1))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescri', 90, 52, 455, 22, 'ttAlfanumerico', 'NFM_DESCRI')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 2))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcrMob', 125, 74, 100, 22, 'ttNumerico', 'NFM_ACRMOB')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 3))
  );


  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkAtivad', 245, 77, 70, 17, 'Ativa', 'NFM_ATIVO_', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', 4))
  );




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
      .AdicionarEvento(TDbeCodBasKeyPressSalcomix.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
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
      .AdicionarEvento(TDbeCodBasKeyPressSalcomix.Create(Self, 'dbeForm' + TStrUtils.fStrZero(intCont, 2)))
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
    '   Width = 381                                          ' +
    '   Height = 14                                          ' +
    '   Alignment = taRightJustify                           ' +
    '   AutoSize = False                                     ' +
    '   Caption = ''Informar a quantidade sempre em relação a 900ml'' ' +
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

procedure TCadastroNovasFormulasSalcomix.DeletaNovaFormula(strCodNfm: String);
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'DELETE FROM SAL_CADSAL WHERE SAL_CODPRO = :CODNFM';
  qryGen.ParamByName('CODNFM').AsString := strCodNfm;
  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSalcomix.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  strCodNfmDel := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;
end;

procedure TCadastroNovasFormulasSalcomix.ExcluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  If tela.GetBlnExcluiu Then
  begin
    DeletaNovaFormula(strCodNfmDel);
  End;
end;

function TCadastroNovasFormulasSalcomix.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasSalcomix.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroNovasFormulasSalcomix.fLinhasPermetida(
  strLinha: String; const tela: ITelaCadLibTintas): Boolean;
begin
  Result := (strLinha = 'Salcomix') Or (strLinha = 'S326') Or
            (strLinha = 'S850')     Or (strLinha = 'S648') Or
            (strLinha = 'S327')     Or (strLinha = 'S603') Or
            (strLinha = 'S325')     Or (strLinha = '525')  Or
            (strLinha = '729')      Or (strLinha = 'SALCOMIX');

  If Not Result Then
    Tela['dbeLinha']['Text'].Value := '';
end;

procedure TCadastroNovasFormulasSalcomix.FormatarCampo(
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

function TCadastroNovasFormulasSalcomix.fPodeAlterar: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel alterá-la.',['&OK']);
    Result := False;
  end;
end;

function TCadastroNovasFormulasSalcomix.fPodeExcluir: Boolean;
begin
  Result := True;
  if VerificarNovaFormulaMovimentada then
  begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe movimentação para essa fórmula, por isso não é possivel excluí-la.',['&OK']);
    Result := False;
  end;
end;


function TCadastroNovasFormulasSalcomix.fValidaCampos(
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
  Else If strNomeCampo = 'NFM_LINHA_' Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := 'A linha deve ser preenchida!';
    End
    Else If Not fLinhasPermetida(strValorCampo, tela) Then
    Begin
      Result := False;
      strRetorno := 'Está linha não pode ser utilizada!' + #13#10 +
                    'Pressione a tecla de atalho para verificar as linhas disponiveis';
    End;
  End
  else if strNomeCampo = 'NFM_DESCRI' then
  begin
    if TStrUtils.fEmptyStr(strValorCampo) then
    begin
      Result := False;
      strRetorno := 'A descrição deve ser preenchida!';
    end
  end
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDB' then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDB', 'NFM_CODB', [rfReplaceAll])).AsString) then
    begin
      strCampoQtd := 'dbeQtdD' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      if (strToFloatDef(strValorCampo, 0) <= 0) then
      begin
        if (strToFloatDef(strValorCampo, 0) < 0) then
        begin
          Result := False;
          strRetorno := 'A quantidade da Base deve ser maior ou igual a Zero!';
        end
      end
    end;
  end
  else if LeftStr(strNomeCampo, 8) = 'NFM_QTDD' then
  begin
    if not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName(StringReplace(strNomeCampo, 'NFM_QTDD', 'NFM_CODB', [rfReplaceAll])).AsString) then
    begin
      strCampoQtd := 'dbeQtdB' + RightStr(strNomeCampo, 2);
      strValorCampoQtd := tela[strCampoQtd]['Text'].Value;

      if (strToFloatDef(strValorCampo, 0) <= 0) and
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
      end

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

function TCadastroNovasFormulasSalcomix.fValidarPreenchimentoCol(
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

function TCadastroNovasFormulasSalcomix.fVerificaNovFormulas(
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

function TCadastroNovasFormulasSalcomix.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroNovasFormulasSalcomix.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroNovasFormulasSalcomix.Create;
end;

function TCadastroNovasFormulasSalcomix.GetNomeCampo: string;
begin
  Result := 'NFM_CODNFM';
end;

function TCadastroNovasFormulasSalcomix.GetNomeCampoItem: string;
begin
  Result := 'NFM_CODB';
end;

function TCadastroNovasFormulasSalcomix.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasSalcomix.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroNovasFormulasSalcomix.GetNomeTabela: string;
begin
  Result := 'SAL_CADNFM';
end;

function TCadastroNovasFormulasSalcomix.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttNovasFormulas;
end;

function TCadastroNovasFormulasSalcomix.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroNovasFormulasSalcomix.GetTitulo: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

procedure TCadastroNovasFormulasSalcomix.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
Var
  strCodNfm: String;
begin
  If (strState = 'dsInsert') Then
  Begin
    intPrxNfm := TAutcomTintaFactory.Get.fGetConfTinta('SAL').fGetInteger('PROCOD');

    Repeat
      strCodNfm := TStrUtils.fStrZero(IntToStr(intPrxNfm), 5);

      GetQueryCadastro.FieldByName('NFM_CODNFM').AsString := 'ESP ' + TAutcomTintaFactory.Get.GetCodEmp +
        strCodNfm;

      Inc(intPrxNfm);
    Until (fVerificaNovFormulas(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString));

    GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString := 'S';
  End;
end;

procedure TCadastroNovasFormulasSalcomix.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
Var
  strNfmSAL: String;
begin
  if tela.GetBlnGravou then
  begin
    (TGravandoExecucaoSalcomixNovasFormulas.Create(GetQueryCadastro.FieldByName('NFM_CODNFM').AsString) as IGravandoExecucaoNome)
      .Executar(TGravandoVazio.Create);

    If Not Tela.GetBlnAlterou Then
    Begin
      strNfmSAL := TStrUtils.fStrZero(IntToStr(StrToInt(IntToStr(intPrxNfm))), 5);
      TAutcomTintaFactory.Get.fGetConfTinta('SAL').pSet('PROCOD',strNfmSAL);
    End;

  end;
end;

procedure TCadastroNovasFormulasSalcomix.IncluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  GetQueryCadastro.FieldByName('NFM_DTACAD').AsDate  := Date;

  tela['btnAtivarNfm']['Enabled'].Value := False;
  tela['dbeCodNfm']['Enabled'].Value    := False;
  tela['chkAtivad']['Checked'].Value    := True;
  tela['dbeDtaCad']['Enabled'].Value    := False;
  tela.SelectFirst;
end;

procedure TCadastroNovasFormulasSalcomix.pAtivaCadSAL;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'UPDATE SAL_CADSAL ' +
                '   SET SAL_ATIVO_ = :ATIVAD ' +
                ' WHERE SAL_CODNFM = :CODNFM';

  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;

  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSalcomix.pAtivaNfm;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' UPDATE SAL_CADNFM           ' +
                '    SET NFM_ATIVO_ = :ATIVAD ' +
                '  WHERE NFM_CODNFM = :CODNFM ';

  qryGen.ParamByName('ATIVAD').AsString := TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','N','S');
  qryGen.ParamByName('CODNFM').AsString := GetQueryCadastro.FieldByName('NFM_CODNFM').AsString;

  qryGen.ExecSQL;
end;

procedure TCadastroNovasFormulasSalcomix.pAtivarDesativarNfm;
begin
  Try
    pAtivaNfm;
    pAtivaCadSAL;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Nova Fórmula ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativada','Ativada') + ' com sucesso !' , ['&Ok']);
  Except
    On E: Exception Do
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Erro na hora de ' + TAutcomTintaFactory.Get.IIF(GetQueryCadastro.FieldByName('NFM_ATIVO_').AsString = 'S','Desativar','Ativar') + ' a nova fórmula !', ['&Ok']);
    End;
  End;
end;

procedure TCadastroNovasFormulasSalcomix.pAtualizaNfm;
begin
  GetQueryCadastro.SQL := GetQueryCadastro.SQL;
  GetQueryCadastro.Open;
end;

procedure TCadastroNovasFormulasSalcomix.pBotaoAtivarNfm(
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

procedure TCadastroNovasFormulasSalcomix.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  pBotaoAtivarNfm(tela);
end;

procedure TCadastroNovasFormulasSalcomix.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  //
end;

function TCadastroNovasFormulasSalcomix.ValidarBase(
  const strCodBas: string): Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   SAL_CADBAS               ' +
    ' INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE ' +
    ' WHERE BAS_CODBAS = :CODBAS ',
    'QTD', [strCodBas]
  ) > 0;
end;

function TCadastroNovasFormulasSalcomix.ValidarBaseJaCadastrado(
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

function TCadastroNovasFormulasSalcomix.VerificarNovaFormulaMovimentada: Boolean;
begin
  Result := True;
  Try
    Try
      Result := fVerificarNovaFormulaMovimentada('SELECT COUNT(0) AS QTD FROM %0:s '+
                                                 ' INNER JOIN SAL_CADSAL ON %1:s_ITETIN = SAL_MD5KEY '+
                                                 ' WHERE %1:s_IDEPRO = "SAL" '+
                                                 '   AND SAL_CODPRO = :CODIGO',
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
