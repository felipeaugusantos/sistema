{*************************************************************}
{* Classe que representa um cadastro de base NEX  *}
{**********************************************************AC*}
unit untCadastroBasesNexa;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,untGenericLibTintaControleVisualDBCheckBox,
  untIDataSet, SysUtils, untStrUtils, StrUtils, Vcl.Forms,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroBasesNexa = class(TAbstractCadastro)
  private
    strCodite : String;
    FIteOri: String;
    strCodIteAnt : String;
    blnZerarFatorExclusao: Boolean;
    strItemExclusao: String;
    procedure pLimparCnvMLItemDesamarraBase(const tela: ITelaCadLibTintas);
    function fItemNaoTeveMovimentacaoML(strCodIte: String): Boolean;
    function fVerificaBasesNovasFormulas: Boolean;
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
    procedure FormatarCampo(const strNomeCampo: string;var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;
    procedure AjustarTela(const tela: ITelaCadLibTintas); override;
    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean; override;

    procedure AtivarNovasFormulas(const tela: ITelaCadLibTintas; const strState: string); override;

    function GetNomeCampoItem: string; override;
    function GetCampoEmbalagem: string; //override;
    function GetCampoPesoEspecifico: string; //override;
    function GetNomeCampoUnidade: string; override;

    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure IncluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    function GetPreencherDbComboBox: Boolean; Override;
    function GetDescDbComboBox: String; Override;

  end;

implementation

uses
  untDbePesquisaItemKeyPress, untConsultaCadastroBaseNexa, untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao, untDbeLinhaKeyPressNexa,
  untCadNexaBasesEmp;

{ TCadastroBasesNexa }


procedure TCadastroBasesNexa.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 600;
  tela['btnAtivarNfm']['Visible'].Value := True;
  tela['btnAtivarNfm']['Width'].Value   := 85;
  tela['btnAtivarNfm']['Caption'].Value := 'Bases Empresas';

  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Left'].Value      := 72;
  tela['DBComboBox']['Top'].Value       := 60;
  tela['DBComboBox']['Width'].Value     := 97;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'BAS_QTDEMB';
  tela['DBComboBox']['TabOrder'].Value  := 5;
end;

procedure TCadastroBasesNexa.CancelarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodIte := '';
  blnAlterou := False;
end;

procedure TCadastroBasesNexa.CarregarDescricoes(const tela: ITelaCadLibTintas);
begin
  tela['edtDesItemBase']['Text'].Value := TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItemBase']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroBasesNexa.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 18, 44, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem', 'Embalagem:', 18, 67, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPesEsp', 'Peso Esp.:', 175, 67, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblTipo', 'Tipo:', 18, 89, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItemBase', 'Item:', 46, 111, 22, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoCusto', 'Custo:', 37, 133, 31, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoVenda', 'Venda:', 344, 133,35, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMargem', 'Margem:', 183, 133, 41, 14, 'taRightJustify'));

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


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 72, 16, 97, 22, 'ttAlfanumerico', 'BAS_CODBAS'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 72, 38, 410, 22, 'ttAlfanumerico', 'BAS_DESBAS'));


//  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeOrdem', 430, 38, 50, 22, 'ttAlfanumerico', 'BAS_ORDEM_'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePesEsp', 230, 60, 97, 22, 'ttAlfanumerico', 'BAS_PESESP'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeTipo', 72, 82, 97, 22, 'ttAlfanumerico', 'BAS_TIPO__')
  .AdicionarEvento(TDbeCodLinKeyPress.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkBasePo', 340, 65, 80, 17, 'Base em Pó?', 'BAS_BASEPO', 'S', 'N')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '9')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeItemBase', 72, 104, 49, 22, 'ttNumerico', 'BAS_CODITE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CompZeros', 'false'))
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItemBase', 'dbePrecoCusto', 'dbeMargem', 'dbePrecoVenda')));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesItemBase', 121, 104, 360, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False))
  );


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoCusto', 72, 126, 97, 22, 'ttAlfanumerico', 'BAS_PRECUS'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMargem', 228, 126, 97, 22, 'ttAlfanumerico', 'BAS_MARGEM'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoVenda', 384, 126, 97, 22, 'ttAlfanumerico', 'BAS_PREVEN'));
end;

procedure TCadastroBasesNexa.ExcluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  FIteOri := tela['dbeItemBase']['Text'].Value;
  inherited;
  blnAlterou := False;
end;

procedure TCadastroBasesNexa.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesItemBase']['Text'].Value := '';

  If tela.GetBlnExcluiu Then
  Begin
    If blnZerarFatorExclusao Then
    Begin
      pLimparFatorTintometrico(strItemExclusao);
      blnZerarFatorExclusao := False;
      strItemExclusao       := '';

      If Not (TStrUtils.fEmptyStr(FIteOri)) Then
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'NEX');

    End;
  End;
end;

function TCadastroBasesNexa.fGetCampoChave(
  const index: Integer): string;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroBasesNexa.fGetCountCamposChave: Integer;
begin
  Result := 1;
end;

function TCadastroBasesNexa.fItemNaoTeveMovimentacaoML(
  strCodIte: String): Boolean;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DET_CODITE '+
                '  FROM MOVDET  '+
                ' WHERE DET_CODITE = :CODITE '+
                '   AND DET_ESPDOC = "ML" ' +
                ' ORDER BY DET_CODITE LIMIT 1';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

procedure TCadastroBasesNexa.FormatarCampo(const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(strNomeCampo, ['BAS_PRECUS', 'BAS_PREVEN', 'BAS_MARGEM', 'BAS_PESESP']) then
  begin
    If  MatchStr(strNomeCampo, ['BAS_PESESP']) Then
    begin
      SetLength(arrPropriedades, 2);

      arrPropriedades[0] := 'DisplayFormat';
      arrPropriedades[1] := 'EditFormat';

      SetLength(arrValores, 2);

      arrValores[0] := '0.0000';
      arrValores[1] := '0.0000';
    end
    Else
    Begin
      SetLength(arrPropriedades, 2);

      arrPropriedades[0] := 'DisplayFormat';
      arrPropriedades[1] := 'EditFormat';

      SetLength(arrValores, 2);

      arrValores[0] := '0.00';
      arrValores[1] := '0.00';
    End;
  end;
end;

function TCadastroBasesNexa.fPodeAlterar: Boolean;
begin
  Result       := True;
  strCodIteAnt := GetQueryCadastro.FieldByName('BAS_CODITE').AsString;
end;

function TCadastroBasesNexa.fPodeExcluir: Boolean;
begin
  Result := True;

  blnZerarFatorExclusao := False;
  strItemExclusao       := '';

  If fVerificaBasesNovasFormulas Then
  Begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para essa Base, '+
                                                'por isso não será possível excluí-la.',['&OK']);
    Result := False;
    Exit;
  End;

  //Se nao tiver movimentacao ML estao zera o fator tintometrico
  If (Not TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('BAS_CODITE').AsString)) Then
  Begin
    blnZerarFatorExclusao := fItemNaoTeveMovimentacaoML(GetQueryCadastro.FieldByName('BAS_CODITE').AsString);
    strItemExclusao       := GetQueryCadastro.FieldByName('BAS_CODITE').AsString;
  End;
end;

function TCadastroBasesNexa.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := True;

   if Not TAutcomTintaFactory.Get.fValidarBaseItemAmarracao
    ('NEX', GetQueryCadastro.FieldByName('BAS_CODBAS').AsString, GetQueryCadastro.FieldByName('BAS_DESBAS').AsString,
    GetQueryCadastro.FieldByName('BAS_CODITE').AsString, StrCodIteAnt, GetQueryCadastro.FieldByName('BAS_PESESP').AsFloat,
    GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat) Then
  Begin
    Result := false;
  End;

end;

function TCadastroBasesNexa.fValidaCampos(const tela: ITelaCadLibTintas;
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
  Else If (strNomeCampo = 'BAS_DESBAS') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
  End
  Else If (strNomeCampo = 'BAS_QTDEMB') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);

    If Not Result Then
      strRetorno := 'A embalagem deve ser preenchida!';

    If Result Then
    Begin
      If Not (VerificaDataBalanco(GetQueryCadastro, 'BAS'))  And (blnAlterou) And (
        Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo, 'NEX_CADBAS', 'BAS_CODBAS', 'BAS_QTDEMB')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
      Begin
        MensagemInfoDtaBalanco;
        Result := False;
        FormataEmbalagem(GetQueryCadastro, strValorCampo, 'NEX_CADBAS', 'BAS_EMBALA');
      End
      Else
        FormataEmbalagem(GetQueryCadastro, strValorCampo, 'NEX_CADBAS', 'BAS_EMBALA');
    End;
  End
  Else If (strNomeCampo = 'BAS_PESESP') Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser preenchido!', ['Peso Especifico']);
    End
    Else If strToFloatDef(strValorCampo, 0) <= 0 Then
    Begin
      Result := False;
      strRetorno := Format('O campo %s deve ser maior que Zero!', ['Peso Especifico']);
    End
    Else If Not (VerificaDataBalanco(GetQueryCadastro, 'BAS'))  And (blnAlterou) And (
      Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo,'NEX_CADBAS', 'BAS_CODBAS', '', 'BAS_PESESP')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
    Begin
       MensagemInfoDtaBalanco;
       Result := False;
    End;
  End
  Else If (strNomeCampo = 'BAS_TIPO__') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := Format('O campo %s deve ser preenchido!', ['Tipo']);
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
      GetQueryCadastro.FieldByName('BAS_PRECUS').AsFloat := 0.00;
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
  End
end;

function TCadastroBasesNexa.fVerificaBasesNovasFormulas: Boolean;
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
    '   NEX_CADNFM               ' +
    ' ' + strWhere + '           ' ,
    'QTD', [GetQueryCadastro.FieldByName('BAS_CODBAS').AsString]
  ) > 0;
end;

function TCadastroBasesNexa.GetCampoEmbalagem: string;
begin
  Result := 'BAS_EMBALA';
end;

function TCadastroBasesNexa.GetCampoPesoEspecifico: string;
begin
  Result := 'BAS_PESESP';
end;

function TCadastroBasesNexa.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroBasesNexa.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroBaseNexa.Create;
end;

function TCadastroBasesNexa.GetDescDbComboBox: String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := qryGen.SQL + '  SELECT              ';
    qryGen.SQL := qryGen.SQL + '    *                 ';
    qryGen.SQL := qryGen.SQL + '  FROM                ';
    qryGen.SQL := qryGen.SQL + '    TABTIN            ';
    qryGen.SQL := qryGen.SQL + '  WHERE TIN_TABELA = "NEX_CADBAS"     ';
    qryGen.SQL := qryGen.SQL + '    AND TIN_CAMPO_ = "BAS_EMBALA"     ';
    qryGen.SQL := qryGen.SQL + '  ORDER BY TIN_VALCOM                 ';
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

function TCadastroBasesNexa.GetNomeCampo: string;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroBasesNexa.GetNomeCampoItem: string;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroBasesNexa.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroBasesNexa.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroBasesNexa.GetNomeTabela: string;
begin
  Result := 'NEX_CADBAS';
end;

function TCadastroBasesNexa.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

function TCadastroBasesNexa.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttBases;
end;

function TCadastroBasesNexa.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroBasesNexa.GetTitulo: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TCadastroBasesNexa.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
var
  qryGen: IDataSet;
  fltEmbalagem: Double;
begin
  If tela.GetBlnGravou Then
  Begin
    //Atualiza o fator tintometrico do produto amarrado
    If (Not TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value)) Then
    Begin
      If GetQueryCadastro.FieldByName('BAS_BASEPO').AsString = 'S' Then
        fltEmbalagem := GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat
      Else
        fltEmbalagem := TAutcomTintaFactory.Get.fStrToFloat(Tela['dbePesEsp']['Text'].Value) * GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat;

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := ' UPDATE CADITE '+
                    ' INNER JOIN NEX_CADBAS ON ITE_CODITE = BAS_CODITE '+
                    '   SET ITE_CNV_ML = ' + AnsiReplaceStr(FloatToStr(fltEmbalagem), ',', '.') + ' ' +
                    ' WHERE ITE_CODITE = :CODITE ';
      qryGen.ParamByName('CODITE').AsString := tela['dbeItemBase']['Text'].Value;
      qryGen.ExecSQL;

      TAutcomTintaFactory.Get.pReplicarFatorTintometrico(qryGen.SQL, tela['dbeItemBase']['Text'].Value );
    End;

    //executa update para limpar o cnvml do produto anterior amarrado
    If (Not TStrUtils.fEmptyStr(FIteOri)) Then
    Begin
      pLimparFatorTintometrico(FIteOri);

      if (FIteOri <> tela['dbeItemBase']['Text'].Value) Then
      begin
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'NEX');
      End;

    End;
  End;
end;

procedure TCadastroBasesNexa.IncluirAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  blnAlterou := False;
end;

procedure TCadastroBasesNexa.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['edtDesItemBase']['text'].Value := '';
  strCodite := '';

end;

procedure TCadastroBasesNexa.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['edtDesItemBase']['text'].Value := '';
  strCodite := '';
  blnAlterou := False;
end;

procedure TCadastroBasesNexa.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
//  tela['dbePesEsp']['Enabled'].Value := false;
end;

procedure TCadastroBasesNexa.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
//  tela['dbePesEsp']['Enabled'].Value := false;;
  blnAlterou := True;
end;

procedure TCadastroBasesNexa.AtivarNovasFormulas(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;

  frmCadNexaBasesEmp := nil;

  Try
    Try
      Application.CreateForm(TfrmCadNexaBasesEmp, frmCadNexaBasesEmp);
      frmCadNexaBasesEmp.strCodBas := GetQueryCadastro.FieldByName('BAS_CODBAS').AsString;
      frmCadNexaBasesEmp.strDesBas := GetQueryCadastro.FieldByName('BAS_DESBAS').AsString;
      frmCadNexaBasesEmp.strBasEpo := GetQueryCadastro.FieldByName('BAS_BASEPO').AsString;

      frmCadNexaBasesEmp.fltPesEsp := GetQueryCadastro.FieldByName('BAS_PESESP').AsFloat;
      frmCadNexaBasesEmp.fltEmbala := GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat;

      frmCadNexaBasesEmp.ShowModal;
    Except
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Erro ao abrir cadastro de bases por empresas.',['&OK']);
      FreeAndNil(frmCadNexaBasesEmp);
    End;

  finally
    If Assigned(frmCadNexaBasesEmp) Then
      FreeAndNil(frmCadNexaBasesEmp);
  end;
end;

procedure TCadastroBasesNexa.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
begin
  FIteOri := '';

  If TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value) Then
    GetQueryCadastro.FieldByName('BAS_CODITE').Value := Null;

  If strState = 'dsEdit' Then
  Begin
    pLimparCnvMLItemDesamarraBase(tela);
    blnAlterou := True;
  End;
end;

procedure TCadastroBasesNexa.pLimparCnvMLItemDesamarraBase(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  //Seleciona o item amarrado a base antes da alteracao
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT BAS_CODITE '+
                '  FROM NEX_CADBAS '+
                ' WHERE BAS_CODBAS = :CODBAS';
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

procedure TCadastroBasesNexa.pLimparFatorTintometrico(
  strCodIte: String);
var
  qryAtu: IDataSet;
begin
  qryAtu := TAutcomTintaFactory.Get.fGetDataSet;
  qryAtu.SQL := 'UPDATE CADITE ' +
                '   SET ITE_CNV_ML = 0.0 ' +
                ' WHERE ITE_CODITE = :CODITE ';
  qryAtu.ParamByName('CODITE').AsString := strCodIte;
  qryAtu.ExecSQL;
end;

procedure TCadastroBasesNexa.pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
begin
end;

end.
