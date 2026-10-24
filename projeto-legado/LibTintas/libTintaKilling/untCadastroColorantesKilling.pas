unit untCadastroColorantesKilling;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade, Graphics,
  Variants,
  SysUtils, untStrUtils, StrUtils,
  untDbePesquisaItemKeyPress, untConsultaCadastroColoranteKilling, untAutcomTintaFactory,
  untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao,
  untTipoCadastro, untTipoTinta;

type
  TCadastroColorantesKilling = class(TAbstractCadastro)
  private
    FIteOri: String;

    strCodIte : String;
    strCodIteAnt: String;
    blnZerarFatorExclusao : Boolean;
    strItemExclusao: String;

    procedure pLimparCnvMLItemDesamarraColorante(const tela: ITelaCadLibTintas);
    function fItemNaoTeveMovimentacaoML(strCodIte: String): Boolean;
    function fVerificaColorantesNovasFormulas: Boolean;
    procedure pLimparFatorTintometrico(strCodIte: String);

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
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string ): Boolean; override;

    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
  end;

implementation

uses
  untIDataSet;

{ TCadastroColorantesKilling }

procedure TCadastroColorantesKilling.AjustarTela(
  const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
end;

procedure TCadastroColorantesKilling.AlterarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  blnAlterou := True;
end;

procedure TCadastroColorantesKilling.CancelarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodite := '';
  blnAlterou := False;
end;

procedure TCadastroColorantesKilling.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDescricaoItem']['Text'].Value := TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItem']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroColorantesKilling.ConstruirControles;

  function GetNewDbEditFocus(const strNome: string; const intLeft, intTop, intWidth, intHeight: Integer;
    const TipoTexto: string; const strDataField: string): ILibTintaControleVisual;
  begin
    Result := TGenericLibTintaControleVisualDBEditFocus.Create(strNome, intLeft, intTop, intWidth, intHeight, TipoTexto, strDataField)
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Tag', 99))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', clWindow))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', clInfoBk))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('RequeridoColor', clRed))
      .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TipoTexto', TipoTexto))
  end;

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
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 52, 39, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItem', 'Item:', 66, 61, 22, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMargem', 'Margem:', 215, 83, 41, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblVenda', 'Pr. Venda:', 344, 83, 81, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCusto', 'Pr. Custo:', 11, 83, 77, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem', 'Embalagem', 344, 105, 81, 14, 'taRightJustify'));


  AdicionarControle(GetNewDbEditFocus('dbeCodigo', 91, 13, 70, 22, 'ttAlfanumerico', 'COL_CODCOL'));
  AdicionarControle(GetNewDbEditFocus('dbeDescricao', 91, 35, 337, 22, 'ttAlfanumerico', 'COL_DESCRI'));
  AdicionarControle(GetNewDbEditFocus('dbeItem', 91, 57, 70, 22, 'ttNumerico', 'COL_CODITE')
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItem', 'dbeCusto', 'dbeMargem', 'dbeVenda', 'TCadastroColorantesKilling')
  ));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDescricaoItem', 161, 57, 337, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', clInfoBk))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('RequeridoColor', clRed))
  );
  AdicionarControle(GetNewDbEditFocus('dbeCusto', 91, 79, 70, 22, 'ttNumerico', 'COL_PRECUS'));
  AdicionarControle(GetNewDbEditFocus('dbeMargem', 260, 79, 70, 22, 'ttNumerico', 'COL_MARGEM'));
  AdicionarControle(GetNewDbEditFocus('dbeVenda', 429, 79, 70, 22, 'ttNumerico', 'COL_PREVEN'));
  AdicionarControle(GetNewDbEditFocus('dbeEmbala', 429, 101, 70, 22, 'ttNumerico', 'COL_EMBALA'));
end;

procedure TCadastroColorantesKilling.ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['edtDescricaoItem']['text'].Value := '';
  blnAlterou := False;

  If tela.GetBlnExcluiu Then
  Begin
    If blnZerarFatorExclusao Then
    Begin
      pLimparFatorTintometrico(strItemExclusao);
      blnZerarFatorExclusao := False;
      strItemExclusao       := '';

      If Not (TStrUtils.fEmptyStr(FIteOri)) Then
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'KIL');
    End;
  End;


end;

function TCadastroColorantesKilling.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroColorantesKilling.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroColorantesKilling.fItemNaoTeveMovimentacaoML(
  strCodIte: String): Boolean;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DET_CODITE '+
                '  FROM MOVDET     '+
                ' WHERE DET_CODITE = :CODITE '+
                '   AND DET_ESPDOC = "ML"    '+
                ' ORDER BY DET_CODITE LIMIT 1';

  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

procedure TCadastroColorantesKilling.FormatarCampo(
  const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
begin
  If MatchStr(strNomeCampo, ['COL_PRECUS', 'COL_PREVEN', 'COL_MARGEM']) Then
  Begin
    SetLength(arrPropriedades, 2);

    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';

    SetLength(arrValores, 2);

    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End
  Else If MatchStr(strNomeCampo, ['COL_EMBALA']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.000';
    arrValores[1] := '0.000';
  End;
end;

function TCadastroColorantesKilling.fPodeAlterar: Boolean;
begin
  strCodIteAnt := GetQueryCadastro.FieldByName('COL_CODITE').AsString;
  Result := True;
end;

function TCadastroColorantesKilling.fPodeExcluir: Boolean;
begin
  Result := True;
  If fVerificaColorantesNovasFormulas Then
  Begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para esse Colorante, por isso não será possível excluí-lo.',['&OK']);
    Result := False;
  End;

  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('COL_CODITE').AsString)) Then
  Begin
    blnZerarFatorExclusao := fItemNaoTeveMovimentacaoML(GetQueryCadastro.FieldByName('COL_CODITE').AsString);
    strItemExclusao       := GetQueryCadastro.FieldByName('COL_CODITE').AsString;
  End;


end;

function TCadastroColorantesKilling.fPodeGravar(
  const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := true;
  If Not (TStrUtils.fEmptyStr(tela['dbeItem']['Text'].Value))Then
  Begin
    If TAutcomTintaFactory.Get.fExisteValorNoCampo(strToFloatDef(tela['dbeItem']['Text'].Value, 0),
      'COL_CODITE', GetNomeTabela, 'AUTOINCREM <> ' + QuotedStr(GetQueryCadastro.FieldByName('AUTOINCREM').AsString)) Then
    Begin
      Result := TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
    End;
  End;
end;

function TCadastroColorantesKilling.fValidaCampos(
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
      Result := False;
      strRetorno := Format('O campo %s deve ser preenchido!', ['Embalagem']);
    End
    Else If StrToFloatDef(strValorCampo, 0) <= 0 Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser maior que Zero!', ['Embalagem']);
    End
    Else If (Not VerificaDataBalanco(GetQueryCadastro, 'COL')) And (blnAlterou) And (
      Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo, 'KILD_CADCOL', 'COL_CODCOL', 'COL_EMBALA')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
    Begin
      MensagemInfoDtaBalanco;
      Result := False;
    End;
  End
  Else If (strNomeCampo = 'COL_DESCRI') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
  End
  else
  if (strNomeCampo = 'COL_PRECUS') Then
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
    If (StrCodIteAnt <> '') And (tela['dbeItem']['Text'].Value = '')Then
    Begin
      If fVerificaColorantesNovasFormulas Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para esse colorante, '+
                                                    'por isso não será possível desamarrá-lo.',['&OK']);
        Result := False;
      End;
    end
    else
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
  end
end;

function TCadastroColorantesKilling.fVerificaColorantesNovasFormulas: Boolean;
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
    '   KILD_CADNFM               ' +
    ' ' + strWhere + '           ' ,
    'QTD', [GetQueryCadastro.FieldByName('COL_CODCOL').AsString]
  ) > 0;
end;

function TCadastroColorantesKilling.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroColorantesKilling.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroColoranteKilling.Create;  
end;

function TCadastroColorantesKilling.GetNomeCampo: string;
begin
  Result := 'COL_CODCOL';
end;

function TCadastroColorantesKilling.GetNomeCampoItem: string;
begin
  Result := 'COL_CODITE';
end;

function TCadastroColorantesKilling.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroColorantesKilling.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroColorantesKilling.GetNomeTabela: string;
begin
  Result := 'KILD_CADCOL';
end;

function TCadastroColorantesKilling.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttColorantes;
end;

function TCadastroColorantesKilling.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroColorantesKilling.GetTitulo: string;
begin
  Result := 'Cadastro de Colorantes'
end;

procedure TCadastroColorantesKilling.GravarAntes(
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

procedure TCadastroColorantesKilling.GravarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
var
  qryGen: IDataSet;
  fltEmbalagem: Double;
begin
  If tela.GetBlnGravou Then
  Begin
    //Atualiza o fator tintometrico do produto amarrado
    If (Not TStrUtils.fEmptyStr(tela['dbeItem']['Text'].Value)) Then
    Begin
      fltEmbalagem := TAutcomTintaFactory.Get.fStrToFloat(Tela['dbeEmbala']['Text'].Value);

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'UPDATE CADITE ' +
                    '   SET ITE_CNV_ML = ' + AnsiReplaceStr(FloatToStr(fltEmbalagem), ',', '.') + ' ' +
                    ' WHERE ITE_CODITE = :CODITE ';
      qryGen.ParamByName('CODITE').AsString := tela['dbeItem']['Text'].Value;
      qryGen.ExecSQL;

      TAutcomTintaFactory.Get.pReplicarFatorTintometrico(qryGen.SQL, tela['dbeItem']['Text'].Value );
    End;

    //executa update para limpar o cnvml do produto anterior amarrado
    If (Not TStrUtils.fEmptyStr(FIteOri)) Then
    Begin
      pLimparFatorTintometrico(FIteOri);

      If (FIteOri <> tela['dbeItem']['Text'].Value) Then
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'KIL');
    End;
  End;
end;

procedure TCadastroColorantesKilling.IncluirDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  tela['edtDescricaoItem']['text'].Value := '';
  strCodIte := '';
  blnAlterou := False;
end;

procedure TCadastroColorantesKilling.PesquisarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  tela['edtDescricaoItem']['text'].Value := '';
  strCodIte := '';
  blnAlterou := False;
end;

procedure TCadastroColorantesKilling.pLimparCnvMLItemDesamarraColorante(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  //Seleciona o item amarrado ao colorante antes da alteracao
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT COL_CODITE '+
                '  FROM KILD_CADCOL '+
                ' WHERE COL_CODCOL = :CODCOL';
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

procedure TCadastroColorantesKilling.pLimparFatorTintometrico(
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

procedure TCadastroColorantesKilling.pSetaEnableReadOnly(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnRestPreco']['Visible'].Value := (strState = 'dsEdit');
end;

end.
