unit untCadastroColorantesAnjoImobiliaria2;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteAnjoImobiliaria2, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta;

type
  TCadastroColorantesAnjoImobiliaria2 = class(TAbstractCadastro)
  private
    strCodite : String;
    FIteOri: String;
    blnZerarFatorExclusao: Boolean;
    strItemExclusao: String;

    procedure pLimparCnvMLItemDesamarraColorante(const tela: ITelaCadLibTintas);
    function fItemNaoTeveMovimentacaoML(strCodIte: String): Boolean;
    function fVerificaColorantesNovasFormulas: Boolean;
    procedure pLimparFatorTintometrico(strCodIte: String);
    function GetNewDbEditFocus(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
    const TipoTexto: string; const strDataField: string): ILibTintaControleVisual;
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
    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;


    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;


    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
  end;

implementation

uses
  untIDataSet;

{ TCadastroColorantesAnjoImobiliaria2 }

procedure TCadastroColorantesAnjoImobiliaria2.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
end;

procedure TCadastroColorantesAnjoImobiliaria2.AlterarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  blnAlterou := True;
end;

procedure TCadastroColorantesAnjoImobiliaria2.CancelarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodite := '';
  blnAlterou := False;
end;

procedure TCadastroColorantesAnjoImobiliaria2.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDescricaoItem']['Text'].Value := TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItem']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroColorantesAnjoImobiliaria2.ConstruirControles;
begin
  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnRestPreco: TSpeedButton                                 ' +
    '   Left = 498                                                      ' +
    '   Top = 35                                                        ' +
    '   Width = 23                                                      ' +
    '   Height = 22                                                     ' +
    '   Hint = ''Restaura dados do produto''                            ' +
    '   Glyph.Data = {                                                  ' +
    ' 	36030000424D3603000000000000360000002800000010000000100000000100 ' +
    ' 	18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF ' +
    ' 	FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00 ' +
    ' 	FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF ' +
    ' 	00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603 ' +
    ' 	015603015603FF00FF0000820000820000820000820000820000820000820000 ' +
    ' 	820000820000820000820156032DC6511DB236015603FF00FF000082011EF305 ' +
    ' 	27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D ' +
    ' 	30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA ' +
    ' 	FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200 ' +
    ' 	0082000082000082000082000082000082000082000082000082FF00FFFF00FF ' +
    ' 	FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00 ' +
    ' 	FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF ' +
    ' 	00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF ' +
    ' 	01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00 ' +
    ' 	FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF ' +
    ' 	00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603 ' +
    ' 	0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7 ' +
    ' 	50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702 ' +
    ' 	5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF ' +
    ' 	FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00 ' +
    ' 	FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08 ' +
    ' 	8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF ' +
    ' 	FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00 ' +
    ' 	FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF ' +
    ' 	00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}            ' +
    '   ParentShowHint = False                                          ' +
    '   ShowHint = True                                                 ' +
    '   Visible = False                                                 ' +
    '   OnClick = btnRestPrecoClick                                     ' +
    ' end                                                               ')
    .AdicionarEvento(TBtnRestaurarPrecoEvento.Create(Self, 'dbeItem', 'dbeCusto', 'dbeMargem', 'dbeVenda'))
  );

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 52, 17, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 205, 17, 15, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItem', 'Item:', 66, 39, 22, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCusto', 'Custo:', 11, 61, 77, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMargem', 'Margem:', 215, 61, 41, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblVenda', 'Venda:', 344, 61, 81, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem', 'Embalagem:', 344, 83, 81, 14, 'taRightJustify'));

  AdicionarControle(GetNewDbEditFocus('dbeCodigo', 91, 13, 70, 22, 'ttAlfanumerico', 'COL_CODCOL'));
  AdicionarControle(GetNewDbEditFocus('dbeDescricao', 225, 13, 273, 22, 'ttAlfanumerico', 'COL_DESCRI'));

  AdicionarControle(GetNewDbEditFocus('dbeItem', 91, 35, 70, 22, 'ttNumerico', 'COL_CODITE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CompZeros', True))
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItem', 'dbeCusto', 'dbeMargem', 'dbeVenda', 'TCadastroColorantesAnjoImobiliaria2')
  ));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDescricaoItem', 161, 35, 337, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', clInfoBk))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('RequeridoColor', clRed))
  );
  AdicionarControle(GetNewDbEditFocus('dbeCusto', 91, 57, 70, 22, 'ttNumerico', 'COL_PRECUS'));
  AdicionarControle(GetNewDbEditFocus('dbeMargem', 260, 57, 70, 22, 'ttNumerico', 'COL_MARGEM'));
  AdicionarControle(GetNewDbEditFocus('dbeVenda', 429, 57, 70, 22, 'ttNumerico', 'COL_PREVEN'));
  AdicionarControle(GetNewDbEditFocus('dbeEmbalagem', 429, 79, 70, 22, 'ttNumerico', 'COL_EMBALA'));


end;

procedure TCadastroColorantesAnjoImobiliaria2.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  FIteOri := tela['dbeItem']['Text'].Value;
  inherited;
  blnAlterou := False;
end;

procedure TCadastroColorantesAnjoImobiliaria2.ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['edtDescricaoItem']['Text'].Value := '';

  If tela.GetBlnExcluiu Then
  Begin
    If blnZerarFatorExclusao Then
    Begin
      pLimparFatorTintometrico(strItemExclusao);
      blnZerarFatorExclusao := False;
      strItemExclusao       := '';

      If Not (TStrUtils.fEmptyStr(FIteOri)) Then
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'AN2');
    End;
  End;
end;

function TCadastroColorantesAnjoImobiliaria2.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroColorantesAnjoImobiliaria2.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroColorantesAnjoImobiliaria2.fItemNaoTeveMovimentacaoML(
  strCodIte: String): Boolean;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DET_CODITE FROM MOVDET  WHERE DET_CODITE = :CODITE AND DET_ESPDOC = "ML" ' +
                'ORDER BY DET_CODITE LIMIT 1';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

procedure TCadastroColorantesAnjoImobiliaria2.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(strNomeCampo, ['COL_PRECUS', 'COL_PREVEN', 'COL_MARGEM']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end
  Else If MatchStr(strNomeCampo, ['COL_EMBALA']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End;
end;

function TCadastroColorantesAnjoImobiliaria2.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroColorantesAnjoImobiliaria2.fPodeExcluir: Boolean;
begin
  Result := True;

  blnZerarFatorExclusao := False;
  strItemExclusao       := '';

  If fVerificaColorantesNovasFormulas Then
  Begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para esse Colorante, por isso não será possível excluí-lo.',['&OK']);
    Result := False;
    Exit;
  End;

  //Se nao tiver movimentacao ML estao zera o fator tintometrico
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('COL_CODITE').AsString)) Then
  Begin
    blnZerarFatorExclusao := fItemNaoTeveMovimentacaoML(GetQueryCadastro.FieldByName('COL_CODITE').AsString);
    strItemExclusao       := GetQueryCadastro.FieldByName('COL_CODITE').AsString;
  End;
end;

function TCadastroColorantesAnjoImobiliaria2.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := True;

  If TAutcomTintaFactory.Get.fExisteValorNoCampo(strToFloatDef(tela['dbeItem']['Text'].Value, 0), 'COL_CODITE', GetNomeTabela, 'AUTOINCREM <> ' + QuotedStr(GetQueryCadastro.FieldByName('AUTOINCREM').AsString)) Then
  Begin
    Result := TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
  End;

  If strState = 'dsEdit' Then
  Begin
    If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('COL_CODITE').AsString) Then
    Begin
      If fVerificaColorantesNovasFormulas Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para esse Colorante, por isso não será possível desamarrá-lo.',['&OK']);
        Result := False;
      End;
    End;
  End;
end;

function TCadastroColorantesAnjoImobiliaria2.fValidaCampos(
  const tela: ITelaCadLibTintas; strNomeCampo, strValorCampo: string;
  var strRetorno: string): Boolean;
Var
  strVlrCusto    : String;
  strValorMargem : String;
  strValorVenda  : String;


begin
  Result := True;

  If (strNomeCampo = 'COL_CODCOL') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O código deve ser preenchido!';
  End
  Else If (strNomeCampo = 'COL_EMBALA') Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      strRetorno := 'O campo embalagem deve ser preenchido!';
      Result     := false;
    End
    Else If StrToFloat(strValorCampo) <= 0 Then
    Begin
      strRetorno := 'Informe um valor válido para o campo embalagem!';
      Result     := false;
    End
    Else If (Not VerificaDataBalanco(GetQueryCadastro, 'COL')) And (blnAlterou) And (
      Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo, 'AN2_CADCOL', 'COL_CODCOL', 'COL_EMBALA')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
    Begin
      MensagemInfoDtaBalanco;
      Result := False;
    End;
  End
  else if (not TStrUtils.fEmptyStr(tela['dbeItem']['Text'].Value)) then
  begin
    If (strNomeCampo = 'COL_PRECUS') Then
    Begin
      If (TStrUtils.fEmptyStr(strValorCampo)) Then
      Begin
        GetQueryCadastro.FieldByName('COL_PRECUS').AsFloat := 0.00;
      End;

      GetQueryCadastro.FieldByName('COL_MARGEM').AsFloat :=
        TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
          strToFloatDef(tela['dbeCusto']['Text'].Value, 0),
          strToFloatDef(tela['dbeVenda']['Text'].Value, 0),
          strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
          0, 0, 0, 0);

    End
    Else If (strNomeCampo = 'COL_MARGEM') Then
    Begin
      If (TStrUtils.fEmptyStr(strValorCampo)) Then
      Begin
        GetQueryCadastro.FieldByName('COL_MARGEM').AsFloat := 0.00;
      End
      Else If (strToFloatDef(strValorCampo, 0) <= 0) Then
      Begin
        GetQueryCadastro.FieldByName('COL_PREVEN').AsFloat := 0.00;
      End;

      GetQueryCadastro.FieldByName('COL_PREVEN').AsFloat :=
        TAutcomTintaFactory.Get.fCalculaPrecoVenda(1,
          strToFloatDef(tela['dbeCusto']['Text'].Value, 0),
          strToFloatDef(tela['dbeVenda']['Text'].Value, 0),
          strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
          0, 0, 0, 0);
    End
    Else If (strNomeCampo = 'COL_PREVEN') Then
    Begin
      If (TStrUtils.fEmptyStr(strValorCampo)) Then
      Begin
        GetQueryCadastro.FieldByName('COL_PREVEN').AsFloat := 0.00;
      End;

      GetQueryCadastro.FieldByName('COL_MARGEM').AsFloat :=
        TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
          strToFloatDef(tela['dbeCusto']['Text'].Value, 0),
          strToFloatDef(tela['dbeVenda']['Text'].Value, 0),
          strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
          0, 0, 0, 0);
    End
    Else If (strNomeCampo = 'COL_CODITE') Then
    Begin
      If Not TStrUtils.fEmptyStr(strValorCampo) Then
      Begin
        If TStrUtils.fEmptyStr(tela['edtDescricaoItem']['Text'].Value) Then
        Begin
          Result := False;
          strRetorno := Format('O produto %s não está cadastrado', [strValorCampo]);
        End
        Else
        begin
          If (strCodIte <> strValorCampo) Then
          begin
            TAutcomTintaFactory.Get.pPreencherValorVenda(strValorCampo
                               , TAutcomTintaFactory.Get.GetCodEmp
                               , strVlrCusto
                               , strValorMargem
                               , strValorVenda);

            GetQueryCadastro.FieldByName('COL_PRECUS').AsString := strVlrCusto;


            GetQueryCadastro.FieldByName('COL_PREVEN').AsFloat :=
              TAutcomTintaFactory.Get.fCalculaPrecoVenda(1,
                                                         strToFloatDef(strVlrCusto,0),
                                                         strToFloatDef(strValorVenda, 0),
                                                         strToFloatDef(strValorMargem, 0),
                                                         0, 0, 0, 0);

            GetQueryCadastro.FieldByName('COL_MARGEM').AsFloat :=
              TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
                                                         strToFloatDef(strVlrCusto, 0),
                                                         strToFloatDef(strValorVenda, 0),
                                                         strToFloatDef(strValorMargem, 0),
                                                         0, 0, 0, 0);
          end;

          strCodIte := strValorCampo;

        end;

      End;
    End;
  End;
end;

function TCadastroColorantesAnjoImobiliaria2.fVerificaColorantesNovasFormulas: Boolean;
var
  strWhere: String;
  intContador: Integer;
begin
  strWhere := ' WHERE ';

  For intContador := 1 To 20 Do
  Begin
    strWhere := strWhere + ' (NFM_FORM' + TStrUtils.fStrZero(intContador, 2) + ' = :CODCOL) ';
    If intContador < 20 Then
      strWhere := strWhere + ' OR ';
  End;

  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   AN2_CADNFM               ' +
    ' ' + strWhere + '           ' ,
    'QTD', [GetQueryCadastro.FieldByName('COL_CODCOL').AsString]
  ) > 0;
end;

function TCadastroColorantesAnjoImobiliaria2.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroColorantesAnjoImobiliaria2.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroColoranteAnjoImobiliaria2.Create;  
end;

function TCadastroColorantesAnjoImobiliaria2.GetNewDbEditFocus(const strNome: string;
  const intLeft, intTop, intWidth, intHeight: Integer; const TipoTexto,
  strDataField: string): ILibTintaControleVisual;
begin
  Result := TGenericLibTintaControleVisualDBEditFocus.Create(strNome, intLeft, intTop, intWidth, intHeight, TipoTexto, strDataField)
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', clWindow))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', clInfoBk))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('RequeridoColor', clRed))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TipoTexto', TipoTexto))
end;

function TCadastroColorantesAnjoImobiliaria2.GetNomeCampo: string;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroColorantesAnjoImobiliaria2.GetNomeCampoItem: string;
begin
  Result := 'COL_CODITE';
end;

function TCadastroColorantesAnjoImobiliaria2.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroColorantesAnjoImobiliaria2.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroColorantesAnjoImobiliaria2.GetNomeTabela: string;
begin
  Result := 'AN2_CADCOL';
end;

function TCadastroColorantesAnjoImobiliaria2.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttColorantes;
end;

function TCadastroColorantesAnjoImobiliaria2.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroColorantesAnjoImobiliaria2.GetTitulo: string;
begin
  Result := 'Cadastro de Colorantes'
end;

procedure TCadastroColorantesAnjoImobiliaria2.GravarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  FIteOri := '';

  If TStrUtils.fEmptyStr(tela['dbeItem']['Text'].Value) Then
    GetQueryCadastro.FieldByName('COL_CODITE').Value := Null;

  If strState = 'dsEdit' Then
  Begin
    pLimparCnvMLItemDesamarraColorante(tela);
    blnAlterou := True;
  End;
end;

procedure TCadastroColorantesAnjoImobiliaria2.GravarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
var
  qryGen: IDataSet;
  fltCnvMl: Double;
begin
  If tela.GetBlnGravou Then
  Begin
    //Atualiza o fator tintometrico do produto amarrado
    If (Not TStrUtils.fEmptyStr(tela['dbeItem']['Text'].Value)) Then
    Begin


      fltCnvMl := TAutcomTintaFactory.Get.fStrToFloat(Tela['dbeEmbalagem']['Text'].Value);



      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' UPDATE CADITE                  ' +
                    '   INNER JOIN AN2_CADCOL        ' +
                    '     ON ITE_CODITE = COL_CODITE ' +
                    ' SET ITE_CNV_ML = ' + AnsiReplaceStr(FloatToStr(fltCnvMl), ',', '.') + ' ' +
                    ' WHERE ITE_CODITE = :CODITE      ';
      qryGen.ParamByName('CODITE').AsString := tela['dbeItem']['Text'].Value;
      qryGen.ExecSQL;

      TAutcomTintaFactory.Get.pReplicarFatorTintometrico(qryGen.SQL, tela['dbeItem']['Text'].Value );
    End;

    //executa update para limpar o cnvml do produto anterior amarrado
    If (Not TStrUtils.fEmptyStr(FIteOri)) Then
    Begin
      pLimparFatorTintometrico(FIteOri);

      if (FIteOri <> tela['dbeItem']['Text'].Value) Then
      begin
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'AN2');
      End;


    End;
  End;
end;

procedure TCadastroColorantesAnjoImobiliaria2.IncluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodite := '';
  tela['edtDescricaoItem']['Text'].Value := '';
  blnAlterou := False;
end;

procedure TCadastroColorantesAnjoImobiliaria2.PesquisarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodite := '';
  tela['edtDescricaoItem']['Text'].Value := '';
  blnAlterou := False;
end;

procedure TCadastroColorantesAnjoImobiliaria2.pLimparCnvMLItemDesamarraColorante(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  //Seleciona o item amarrado ao colorante antes da alteracao
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT COL_CODITE FROM AN2_CADCOL WHERE COL_CODCOL = :CODCOL';
  qryGen.ParamByName('CODCOL').AsString := GetQueryCadastro.FieldByName('COL_CODCOL').AsString;
  qryGen.Open;

  //Verifica o item original;
  If (Not TStrUtils.fEmptyStr(qryGen.FieldByName('COL_CODITE').AsString)) And
     (qryGen.FieldByName('COL_CODITE').AsString <> tela['dbeItem']['Text'].Value) Then
  Begin
    If fItemNaoTeveMovimentacaoML(qryGen.FieldByName('COL_CODITE').AsString) Then
      FIteOri := qryGen.FieldByName('COL_CODITE').AsString;
  End;
end;

procedure TCadastroColorantesAnjoImobiliaria2.pLimparFatorTintometrico(
  strCodIte: String);
var
  qryAtu: IDataSet;
begin
  qryAtu := TAutcomTintaFactory.Get.fGetDataSet;
  qryAtu.SQL := 'UPDATE CADITE               ' +
                '   SET ITE_CNV_ML = 0.0     ' +
                ' WHERE ITE_CODITE = :CODITE ';
  qryAtu.ParamByName('CODITE').AsString := strCodIte;
  qryAtu.ExecSQL;
end;

procedure TCadastroColorantesAnjoImobiliaria2.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnRestPreco']['Visible'].Value := (strState = 'dsEdit');
end;

end.
