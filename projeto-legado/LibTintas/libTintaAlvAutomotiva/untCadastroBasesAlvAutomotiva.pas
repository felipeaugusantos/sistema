{**************************************************************}
{* Classe que representa um cadastro de base AlvAutomotiva *}
{***********************************************************AC*}
unit untCadastroBasesAlvAutomotiva;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroBasesAlvAutomotiva = class(TAbstractCadastro)
  private
    strCodIte : String;
    FIteOri: String;
    blnZerarFatorExclusao: Boolean;
    strItemExclusao: String;
    strCodIteAnt : String;
    function fVerificaBasesNovasFormulas: Boolean;
    procedure pLimparCnvMLItemDesamarraBases(const tela: ITelaCadLibTintas);
    function fItemNaoTeveMovimentacaoML(strCodIte: String): Boolean;
    procedure pLimparFatorTintometrico(strCodIte:String);
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
    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean ; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    function GetPreencherDbComboBox: Boolean; Override;
    function GetDescDbComboBox: String; Override;
  end;

implementation

uses
  untDbePesquisaItemKeyPress, untConsultaCadastroBaseAlvAutomotiva, untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao;

{ TCadastroBasesAlvAutomotiva }


procedure TCadastroBasesAlvAutomotiva.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
  Tela.GetSelf['Height'].Value := 240;

  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Left'].Value      := 72;
  tela['DBComboBox']['Top'].Value       := 38;
  tela['DBComboBox']['Width'].Value     := 150;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'BAS_QTDEMB';
  tela['DBComboBox']['TabOrder'].Value  := 2;
end;

procedure TCadastroBasesAlvAutomotiva.AlterarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  blnAlterou := True;
end;

procedure TCadastroBasesAlvAutomotiva.CancelarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodIte := '';
  blnAlterou := False;
end;

procedure TCadastroBasesAlvAutomotiva.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDesItemBase']['Text'].Value := TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItemBase']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroBasesAlvAutomotiva.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Base:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 16, 64, 52, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodUni', 'Embalagem:', 26, 42, 42, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPesEsp', 'Peso Especifico:', 345, 42, 35, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItemBase', 'Item:', 46, 86, 22, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblTipoBase', 'Tipo Base:', 37, 108, 31, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoCusto', 'Custo:', 37, 130, 31, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoVenda', 'Venda:', 344, 130, 35, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMargem', 'Margem:', 183, 130, 41, 14, 'taRightJustify'));

  AdicionarControle(TLibTintaControleVisualImplementacao.Create(
    ' object btnRestPreco: TSpeedButton                                    ' +
    '   Left = 483                                                         ' +
    '   Top = 83                                                           ' +
    '   Width = 23                                                         ' +
    '   Height = 20                                                        ' +
    '   Hint = ''Restaura dados do produto''                               ' +
    '   Glyph.Data = {                                                     ' +
    '     36030000424D3603000000000000360000002800000010000000100000000100 ' +
    '     18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF ' +
    '     FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00 ' +
    '     FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF ' +
    '     00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603 ' +
    '     015603015603FF00FF0000820000820000820000820000820000820000820000 ' +
    '     820000820000820000820156032DC6511DB236015603FF00FF000082011EF305 ' +
    '     27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D ' +
    '     30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA ' +
    '     FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200 ' +
    '     0082000082000082000082000082000082000082000082000082FF00FFFF00FF ' +
    '     FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00 ' +
    '     FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF ' +
    '     00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF ' +
    '     01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00 ' +
    '     FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF ' +
    '     00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603 ' +
    '     0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7 ' +
    '     50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702 ' +
    '     5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF ' +
    '     FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00 ' +
    '     FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08 ' +
    '     8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF ' +
    '     FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00 ' +
    '     FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF ' +
    '     00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}            ' +
    '   ParentShowHint = False                                             ' +
    '   ShowHint = True                                                    ' +
    '   Visible = False                                                    ' +
    ' end                                                                  ')
    .AdicionarEvento(TBtnRestaurarPrecoEvento.Create(Self, 'dbeItemBase', 'dbePrecoCusto', 'dbeMargem', 'dbePrecoVenda')));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 97, 22, 'ttAlfanumerico', 'BAS_CODBAS')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0')));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePesEsp', 384, 38, 97, 22, 'ttAlfanumerico', 'BAS_PESESP'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 72, 60, 409, 22, 'ttAlfanumerico', 'BAS_DESCRI'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeItemBase', 72, 82, 49, 22, 'ttNumerico', 'BAS_CODITE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CompZeros', 'True'))
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItemBase', 'dbePrecoCusto', 'dbeMargem', 'dbePrecoVenda','TCadastroBasesAlvAutomotiva')));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesItemBase', 121, 82, 360, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeTipoBase', 72, 104, 97, 22, 'ttAlfanumerico', 'BAS_TIPO__'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoCusto', 72, 126, 97, 22, 'ttAlfanumerico', 'BAS_PRECUS'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMargem', 228, 126, 97, 22, 'ttAlfanumerico', 'BAS_MARGEM'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoVenda', 384, 126, 97, 22, 'ttAlfanumerico', 'BAS_PREVEN'));


end;

procedure TCadastroBasesAlvAutomotiva.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesItemBase']['text'].Value := '';
  blnAlterou := False;

  If tela.GetBlnExcluiu Then
  Begin
    If blnZerarFatorExclusao Then
    Begin
      pLimparFatorTintometrico(strItemExclusao);
      blnZerarFatorExclusao := False;
      strItemExclusao := '';

      If Not (TStrUtils.fEmptyStr(FIteOri)) Then
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'ALA');
    End;
  End;
end;

function TCadastroBasesAlvAutomotiva.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroBasesAlvAutomotiva.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroBasesAlvAutomotiva.fItemNaoTeveMovimentacaoML(
  strCodIte: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT                ' +
                '     DET_CODITE          ' +
                '   FROM                  ' +
                '     MOVDET              ' +
                '   WHERE                 ' +
                '     DET_CODITE = :CODITE  AND   ' +
                '     DET_ESPDOC = "ML"           ' +
                '   ORDER BY              ' +
                '     DET_CODITE LIMIT 1  ';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

procedure TCadastroBasesAlvAutomotiva.FormatarCampo(const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray);
begin
  If MatchStr(strNomeCampo, ['BAS_PRECUS', 'BAS_PREVEN', 'BAS_MARGEM']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  End
  Else If MatchStr(strNomeCampo, ['BAS_PESESP']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.000';
    arrValores[1] := '0.000';
  End;
end;

function TCadastroBasesAlvAutomotiva.fPodeAlterar: Boolean;
begin
  Result := True;
  strCodIteAnt := GetQueryCadastro.FieldByName('BAS_CODITE').AsString;
end;

function TCadastroBasesAlvAutomotiva.fPodeExcluir: Boolean;
begin
  Result := True;
  If fVerificaBasesNovasFormulas Then
  Begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para essa Base, por isso não será possível excluí-la.',['&OK']);
    Result := False;
  End;

  //Se nao tiver movimentacao ML estao zera o fator tintometrico
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('BAS_CODITE').AsString)) Then
  Begin
    blnZerarFatorExclusao := fItemNaoTeveMovimentacaoML(GetQueryCadastro.FieldByName('BAS_CODITE').AsString);
    strItemExclusao       := GetQueryCadastro.FieldByName('BAS_CODITE').AsString;
  End;


end;

function TCadastroBasesAlvAutomotiva.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := True;

  If TAutcomTintaFactory.Get.fExisteValorNoCampo(strToFloatDef(tela['dbeItemBase']['Text'].Value, 0), 'BAS_CODITE', GetNomeTabela, 'AUTOINCREM <> ' + QuotedStr(GetQueryCadastro.FieldByName('AUTOINCREM').AsString)) Then
  Begin
    Result := TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
  End;

  If strState = 'dsEdit' Then
  Begin
    If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('BAS_CODITE').AsString) And fVerificaBasesNovasFormulas Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para essa Base, por isso não será possível desamarrá-la.',['&OK']);
      Result := False;
    End;
  End;

  If Not TAutcomTintaFactory.Get.fValidarBaseItemAmarracao
    ('ALA', GetQueryCadastro.FieldByName('BAS_CODBAS').AsString, GetQueryCadastro.FieldByName('BAS_DESCRI').AsString,
    GetQueryCadastro.FieldByName('BAS_CODITE').AsString, StrCodIteAnt, GetQueryCadastro.FieldByName('BAS_PESESP').AsFloat,
    GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat) Then
  Begin
    Result := false;
  End;
end;

function TCadastroBasesAlvAutomotiva.fValidaCampos(const tela: ITelaCadLibTintas;
  strNomeCampo: string; strValorCampo: string; var strRetorno: string): Boolean;
Var
  strVlrCusto    : String;
  strValorMargem : String;
  strValorVenda  : String;
begin
  Result := True;
  CarregarDescricoes(tela);
  If (strNomeCampo = 'BAS_CODBAS') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A base deve ser preenchida!';
  End
  Else If (StrNomeCampo = 'BAS_QTDEMB') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);

    If Not Result Then
      strRetorno := 'A embalagem deve ser preenchida!';

    If Result Then
    Begin
      If Not (VerificaDataBalanco(GetQueryCadastro, 'BAS'))  And (blnAlterou) And (
        Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo, 'ALA_CADBAS', 'BAS_CODBAS', 'BAS_QTDEMB')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
      Begin
        MensagemInfoDtaBalanco;
        Result := False;
        FormataEmbalagem(GetQueryCadastro, strValorCampo, 'ALA_CADBAS', 'BAS_EMBALA');
      End
      Else
        FormataEmbalagem(GetQueryCadastro, strValorCampo, 'ALA_CADBAS', 'BAS_EMBALA');
    End;
  End
  Else If (strNomeCampo = 'BAS_DESCRI') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
  End
  Else If (strNomeCampo = 'BAS_PESESP') Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('O %s deve ser preenchido!', ['Peso Especifico']);
    End
    Else If StrToFloatDef(strValorCampo, 0) <= 0 Then
    Begin
      Result := False;
      strRetorno := Format('O %s deve ser maior que Zero!', ['Peso Especifico']);
    End
    Else If Not (VerificaDataBalanco(GetQueryCadastro, 'BAS'))  And (blnAlterou) And (
      Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo,'ALA_CADBAS', 'BAS_CODBAS', '', 'BAS_PESESP')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
    Begin
      MensagemInfoDtaBalanco;
      Result := False;
    End;
  End
  Else If (strNomeCampo = 'BAS_PRECUS') Then
  Begin
    GetQueryCadastro.FieldByName('BAS_MARGEM').AsFloat :=
        TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
          strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
          strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
          strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
          0, 0, 0, 0);

    If (strToFloatDef(strValorCampo, 0) <= 0) Then
      GetQueryCadastro.FieldByName('BAS_PRECUS').AsFloat := 0.0;
  End
  Else If (strNomeCampo = 'BAS_MARGEM') Then
  Begin
    GetQueryCadastro.FieldByName('BAS_PREVEN').AsFloat :=
        TAutcomTintaFactory.Get.fCalculaPrecoVenda(1,
          strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
          strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
          strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
          0, 0, 0, 0);


  End
  Else If (strNomeCampo = 'BAS_PREVEN') Then
  Begin
    GetQueryCadastro.FieldByName('BAS_MARGEM').AsFloat :=
        TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
          strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
          strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
          strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
          0, 0, 0, 0);
  End
  Else If (strNomeCampo = 'BAS_CODITE') Then
  Begin
    If (StrCodIteAnt <> '') And (tela['dbeItemBase']['Text'].Value = '')Then
    Begin
      If fVerificaBasesNovasFormulas Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para essa Base, '+
                                                    'por isso não será possível desamarrá-la.',['&OK']);
        Result := False;
      End;
    end
    Else
    If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If TStrUtils.fEmptyStr(tela['edtDesItemBase']['Text'].Value) Then
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

          GetQueryCadastro.FieldByName('BAS_PRECUS').AsString := strVlrCusto;


          GetQueryCadastro.FieldByName('BAS_PREVEN').AsFloat :=
            TAutcomTintaFactory.Get.fCalculaPrecoVenda(1,
                                                       strToFloatDef(strVlrCusto,0),
                                                       strToFloatDef(strValorVenda, 0),
                                                       strToFloatDef(strValorMargem, 0),
                                                       0, 0, 0, 0);

          GetQueryCadastro.FieldByName('BAS_MARGEM').AsFloat :=
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
end;

function TCadastroBasesAlvAutomotiva.fVerificaBasesNovasFormulas: Boolean;
var
  strWhere: String;
  intContador: Integer;
begin
  strWhere := ' WHERE ';

  For intContador := 1 To 20 Do
  Begin
    strWhere := strWhere + ' (NFM_CODB' + TStrUtils.fStrZero(intContador, 2) + ' = :CODBAS) ';
    If intContador < 20 Then
      strWhere := strWhere + ' OR ';
  End;

  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   ALA_CADNFM               ' +
    ' ' + strWhere + '           ' ,
    'QTD', [GetQueryCadastro.FieldByName('BAS_CODBAS').AsString]
  ) > 0;
end;

function TCadastroBasesAlvAutomotiva.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroBasesAlvAutomotiva.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroBaseAlvAutomotiva.Create;
end;

function TCadastroBasesAlvAutomotiva.GetDescDbComboBox: String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT                ';
    qryGen.SQL := qryGen.SQL + '    *                   ';
    qryGen.SQL := qryGen.SQL + '  FROM                  ';
    qryGen.SQL := qryGen.SQL + '    TABTIN              ';
    qryGen.SQL := qryGen.SQL + '  WHERE TIN_TABELA = "ALA_CADBAS"         ';
    qryGen.SQL := qryGen.SQL + '    AND TIN_CAMPO_ = "BAS_EMBALA"         ';
    qryGen.SQL := qryGen.SQL + '  ORDER BY TIN_VALCOM                     ';
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin

      If qryGen.RecNo > 1 Then
        Result := Result + ',';

      Result := Result + qryGen.FieldByName('TIN_OPCCOM').AsString;
	  qryGen.Next;
    End;
  Except
    Raise;
  End;
end;

function TCadastroBasesAlvAutomotiva.GetNomeCampo: string;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroBasesAlvAutomotiva.GetNomeCampoItem: string;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroBasesAlvAutomotiva.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroBasesAlvAutomotiva.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroBasesAlvAutomotiva.GetNomeTabela: string;
begin
  Result := 'ALA_CADBAS';
end;

function TCadastroBasesAlvAutomotiva.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

function TCadastroBasesAlvAutomotiva.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttBases;
end;

function TCadastroBasesAlvAutomotiva.GetTipoTinta: TTipoTinta;
begin
  Result := ttIndustrial;
end;

function TCadastroBasesAlvAutomotiva.GetTitulo: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TCadastroBasesAlvAutomotiva.GravarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  FIteOri := '';

  If TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value) Then
    GetQueryCadastro.FieldByName('BAS_CODITE').Value := Null;

  If strState = 'dsEdit' Then
  Begin
    pLimparCnvMLItemDesamarraBases(tela);
    blnAlterou := True;
  End;
end;

procedure TCadastroBasesAlvAutomotiva.GravarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
Var
  qryGen: IDataSet;
  fltEmbalagem: Double;
begin
  If tela.GetBlnGravou Then
  Begin
    //Atualiza o fator tintometrico do produto amarrado
    If Not (TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value)) Then
    Begin
      fltEmbalagem := TAutcomTintaFactory.Get.fStrToFloat(Tela['dbePesEsp']['Text'].Value) * GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat;

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' UPDATE CADITE       ';
      qryGen.SQL := qryGen.SQL +  ' INNER JOIN ALA_CADBAS ON  ';
      qryGen.SQL := qryGen.SQL +  '   BAS_CODITE = ITE_CODITE ';
      qryGen.SQL := qryGen.SQL +  ' SET ITE_CNV_ML =  ' + AnsiReplaceStr(FloatToStr(fltEmbalagem), ',', '.') + ' ';
      qryGen.SQL := qryGen.SQL +  ' WHERE                     ';
      qryGen.SQL := qryGen.SQL +  '   ITE_CODITE = :CODITE    ';
      qryGen.ParamByName('CODITE').AsString := tela['dbeItemBase']['Text'].Value;
      qryGen.ExecSQL;

      TAutcomTintaFactory.Get.pReplicarFatorTintometrico(qryGen.SQL, tela['dbeItemBase']['Text'].Value);
    End;

    //executa update para limpar o cnvml do produto anterior amarrado
    If Not TStrUtils.fEmptyStr(FIteOri) Then
    Begin
      pLimparFatorTintometrico(FIteOri);

      If (FIteOri <> tela['dbeItemBase']['Text'].Value) Then
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'ALA');
    End;
  End;
end;

procedure TCadastroBasesAlvAutomotiva.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['edtDesItemBase']['text'].Value := '';
  GetQueryCadastro.FieldByName('BAS_PESESP').AsFloat  := 1.00;
  strCodIte := '';
  blnAlterou := False;
end;

procedure TCadastroBasesAlvAutomotiva.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['edtDesItemBase']['text'].Value := '';
  strCodIte := '';
  blnAlterou := False;
end;

procedure TCadastroBasesAlvAutomotiva.pLimparCnvMLItemDesamarraBases(
  const tela: ITelaCadLibTintas);
Var
  qryGen: IDataSet;
begin
  //Seleciona o item amarrado ao colorante antes da alteracao
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '   SELECT            ' +
                '     BAS_CODITE      ' +
                '   FROM              ' +
                '     ALA_CADBAS      ' +
                '   WHERE             ' +
                '     BAS_CODBAS = :CODBAS   ';
  qryGen.ParamByName('CODBAS').AsString := GetQueryCadastro.FieldByName('BAS_CODBAS').AsString;
  qryGen.Open;

  //Verifica o item original;
  If (Not TStrUtils.fEmptyStr(qryGen.FieldByName('BAS_CODITE').AsString)) And
    (qryGen.FieldByName('BAS_CODITE').AsString <> tela['dbeItemBase']['Text'].Value) Then
  Begin
    If fItemNaoTeveMovimentacaoML(qryGen.FieldByName('BAS_CODITE').AsString) Then
      FIteOri := qryGen.FieldByName('BAS_CODITE').AsString;
  End;
end;

procedure TCadastroBasesAlvAutomotiva.pLimparFatorTintometrico(strCodIte: String);
Var
  qryUpdate: IDataSet;
begin
  qryUpdate := TAutcomTintaFactory.Get.fGetDataSet;
  qryUpdate.SQL := '    UPDATE                          ';
  qryUpdate.SQL := qryUpdate.SQL + '      CADITE        ';
  qryUpdate.SQL := qryUpdate.SQL + '  SET               ';
  qryUpdate.SQL := qryUpdate.SQL + '      ITE_CNV_ML = 0.0  ';
  qryUpdate.SQL := qryUpdate.SQL + '  WHERE             ';
  qryUpdate.SQL := qryUpdate.SQL + '      ITE_CODITE = :CODITE  ';
  qryUpdate.ParamByName('CODITE').AsString := strCodIte;
  qryUpdate.ExecSQL;
end;

procedure TCadastroBasesAlvAutomotiva.pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnRestPreco']['Visible'].Value := (strState = 'dsEdit');
end;

end.
