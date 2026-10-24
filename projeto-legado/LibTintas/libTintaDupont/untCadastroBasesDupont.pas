{******************************************************}
{* Classe que representa um cadastro de base Dupont   *}
{***************************************************AC*}
unit untCadastroBasesDupont;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroBasesDupont = class(TAbstractCadastro)
  private
    FIteOri: String;
    strCodIteAnt : String;
    strCodite : String;
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
    procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;
    procedure AjustarTela(const tela: ITelaCadLibTintas); override;
    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean; override;

    function GetNomeCampoItem: string; override;
//    function GetCampoEmbalagem: string; override;
//    function GetCampoPesoEspecifico: string; override;
    function GetNomeCampoUnidade: string; override;

    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    function fGetArrayTipos: TCadLibTintasStringArray; override;
    function fGetArrayLinhas: TCadLibTintasStringArray; override;

    function fValidaTipo(strTipo: String): Boolean;
    function fValidaLinha(strLinha: String): Boolean;



    function GetPreencherDbComboBox: Boolean; override;
    function GetDescDbComboBox: String; Override;

  end;


implementation

uses
  untDbePesquisaItemKeyPress, untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao, untGenericLibTintaControleVisualDBCheckBox,
  untDbeTipoKeyPressDupont, untDbeLinhaKeyPressDupont ;

{ TCadastroBasesDupont }


procedure TCadastroBasesDupont.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 536;

  tela['DBComboBox']['Visible'].Value   := True;
  tela['DBComboBox']['Left'].Value      := 72;
  tela['DBComboBox']['Top'].Value       := 38;
  tela['DBComboBox']['Width'].Value     := 97;
  tela['DBComboBox']['Height'].Value    := 22;
  tela['DBComboBox']['DataField'].Value := 'BAS_QTDEMB';
  tela['DBComboBox']['TabOrder'].Value  := 2;
end;

procedure TCadastroBasesDupont.AlterarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  blnAlterou := True;
end;

procedure TCadastroBasesDupont.CancelarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodIte := '';
  blnAlterou := False;
end;

procedure TCadastroBasesDupont.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDesItemBase']['Text'].Value := TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItemBase']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroBasesDupont.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 175, 20, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem', 'Embalagem:', 18, 45, 52, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPesEsp', 'Peso Específico:', 325, 45, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblTipo', 'Tipo:', 18, 64, 52, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', 325, 64, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItemBase', 'Item:', 46, 86, 22, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoCusto', 'Custo:', 37, 108, 31, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoVenda', 'Venda:', 344, 108, 35, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMargem', 'Margem:', 183, 108, 41, 14, 'taRightJustify'));

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


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 72, 16, 97, 22, 'ttAlfanumerico', 'BAS_CODBAS')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0')));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 230, 16, 251, 22, 'ttAlfanumerico', 'BAS_DESBAS')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1')));

  AdicionarControle(TGenericLibTintaControleVisualDBCheckBox.Create('chkPesGra', 185, 41, 150, 22, 'Peso em Gramas', 'BAS_PESGRA', 'S', 'N')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '3')));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePesEsp', 384, 38, 97, 22, 'ttAlfanumerico', 'BAS_PESESP')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeTipo', 72, 60, 97, 22, 'ttAlfanumerico', 'BAS_TIPO__')
    .AdicionarEvento(TDbeTipoKeyPressDupont.Create(Self, 'dbeTipo')));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeLinha', 384, 60, 97, 22, 'ttAlfanumerico', 'BAS_LINHA_')
    .AdicionarEvento(TDbeLinhaKeyPressDupont.Create(Self, 'dbeLinha')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeItemBase', 72, 83, 49, 22, 'ttNumerico', 'BAS_CODITE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CompZeros', 'True'))
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItemBase', 'dbePrecoCusto', 'dbeMargem', 'dbePrecoVenda')));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesItemBase', 121, 83, 360, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoCusto', 72, 105, 97, 22, 'ttAlfanumerico', 'BAS_PRECUS'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMargem', 228, 105, 97, 22, 'ttAlfanumerico', 'BAS_MARGEM'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoVenda', 384, 105, 97, 22, 'ttAlfanumerico', 'BAS_PREVEN'));
end;

procedure TCadastroBasesDupont.ExcluirAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  FIteOri := tela['dbeItemBase']['Text'].Value;
  inherited;
  blnAlterou := False;
end;

procedure TCadastroBasesDupont.ExcluirDepois(const tela: ITelaCadLibTintas;
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
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'DUP');

    End;
  End;
end;

function TCadastroBasesDupont.fGetArrayLinhas: TCadLibTintasStringArray;
begin
  Result := VarArrayOf(['CHROMA', 'CORMAX', 'DUXONE', 'IMRON', 'NASON']);
end;

function TCadastroBasesDupont.fGetArrayTipos: TCadLibTintasStringArray;
begin
  Result := VarArrayOf(['BINDER', 'CATALISADOR', 'DILUENTE', 'KIT', 'MASSA', 'OUTROS', 'PRIMER', 'TINTING', 'VERNIZ', 'MIXING BASE POL']);
end;

function TCadastroBasesDupont.fGetCampoChave(
  const index: Integer): string;
var
  arrChaves: Array Of String;
begin
{  If TAutcomTintaFactory.Get.GetEmpBasDup Then
  Begin
    SetLength(arrChaves,2);
    arrChaves[0] := 'BAS_CODBAS';
    arrChaves[1] := 'BAS_CODEMP'
  End
  Else
  Begin
    SetLength(arrChaves,1);
    arrChaves[0] := 'BAS_CODBAS';
  End;}

  SetLength(arrChaves,1);
  arrChaves[0] := 'BAS_CODBAS';

  Result := arrChaves[index];
end;

function TCadastroBasesDupont.fGetCountCamposChave: Integer;
begin
{  If TAutcomTintaFactory.Get.GetEmpBasDup Then
    Result := 2
  Else
    Result := 1;}

  Result := 1;
end;

function TCadastroBasesDupont.fItemNaoTeveMovimentacaoML(
  strCodIte: String): Boolean;
var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT DET_CODITE FROM MOVDET  WHERE DET_CODITE = :CODITE AND DET_ESPDOC = "ML" ' +
                ' ORDER BY DET_CODITE LIMIT 1';
  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.Open;

  Result := qryGen.IsEmpty;
end;

procedure TCadastroBasesDupont.FormatarCampo(const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(strNomeCampo, ['BAS_PRECUS', 'BAS_PREVEN', 'BAS_MARGEM', 'BAS_PESESP']) then
  begin
    If MatchStr(strNomeCampo, ['BAS_PESESP']) Then
    Begin
      SetLength(arrPropriedades, 2);
      arrPropriedades[0] := 'DisplayFormat';
      arrPropriedades[1] := 'EditFormat';
      SetLength(arrValores, 2);
      arrValores[0] := '0.0000';
      arrValores[1] := '0.0000';
    End
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

function TCadastroBasesDupont.fPodeAlterar : Boolean;
begin
  Result       := True;
  strCodIteAnt := GetQueryCadastro.FieldByName('BAS_CODITE').AsString;
end;

function TCadastroBasesDupont.fPodeExcluir: Boolean;
begin
  Result := True;

  blnZerarFatorExclusao := False;
  strItemExclusao       := '';

  If fVerificaBasesNovasFormulas Then
  Begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para essa Base, por isso não será possível excluí-la.',['&OK']);
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

function TCadastroBasesDupont.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := True;

  If strState = 'dsEdit' Then
  Begin
    If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('BAS_CODITE').AsString) And fVerificaBasesNovasFormulas Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para essa Base, por isso não será possível desamarrá-la.',['&OK']);
      Result := False;
    End;
  End;

  if Not TAutcomTintaFactory.Get.fValidarBaseItemAmarracao('DUP', GetQueryCadastro.FieldByName('BAS_CODBAS').AsString,
    GetQueryCadastro.FieldByName('BAS_DESBAS').AsString, GetQueryCadastro.FieldByName('BAS_CODITE').AsString, StrCodIteAnt,
    GetQueryCadastro.FieldByName('BAS_PESESP').AsFloat, GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat) Then
  Begin
    Result := false;
  End;
end;

function TCadastroBasesDupont.fValidaCampos(const tela: ITelaCadLibTintas;
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
        Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo, 'DUP_CADBAS', 'BAS_CODBAS', 'BAS_QTDEMB')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
      Begin
        MensagemInfoDtaBalanco;
        Result := False;
        FormataEmbalagem(GetQueryCadastro, strValorCampo, 'DUP_CADBAS', 'BAS_EMBALA');
      End
      Else
        FormataEmbalagem(GetQueryCadastro, strValorCampo, 'DUP_CADBAS', 'BAS_EMBALA');
    End;
  End
  Else If (strNomeCampo = 'BAS_PESESP') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O peso específico deve ser preenchido!';

    If Result Then
    Begin
      If (strToFloatDef(strValorCampo, 0) <= 0) Then
      Begin
        Result := False;
        strRetorno := 'O peso específico deve ser maior que zero!';
      End
      Else If Not (VerificaDataBalanco(GetQueryCadastro, 'BAS'))  And (blnAlterou) And (
        Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo,'DUP_CADBAS', 'BAS_CODBAS', '', 'BAS_PESESP')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
      Begin
         MensagemInfoDtaBalanco;
         Result := False;
      End;
    End;
  End

  Else If (strNomeCampo = 'BAS_TIPO__') Then
  Begin
    If (Not TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      If Not fValidaTipo(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'O Tipo da base não existe!';
      End;
    End
    Else If (TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      Result := False;
      strRetorno := 'O Tipo da base deve ser preenchido!';
    End;
  End

  Else If (strNomeCampo = 'BAS_LINHA_') Then
  Begin
    If (Not TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      If Not fValidaLinha(strValorCampo) Then
      Begin
        Result := False;
        strRetorno := 'A Linha da base não existe!';
      End;
    End
    Else If (TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      Result := False;
      strRetorno := 'A Linha da base deve ser preenchida!';
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

function TCadastroBasesDupont.fValidaLinha(strLinha: String): Boolean;
begin
  Result := False;
  If MatchStr(strLinha, ['CHROMA', 'CORMAX', 'DUXONE', 'IMRON', 'NASON']) Then
  Result := True;
  strCodIteAnt := GetQueryCadastro.FieldByName('BAS_CODITE').AsString;

end;

function TCadastroBasesDupont.fValidaTipo(strTipo: String): Boolean;
begin
  Result := False;
  If MatchStr(strTipo, ['BINDER', 'CATALISADOR', 'DILUENTE', 'KIT', 'MASSA', 'OUTROS', 'PRIMER', 'TINTING', 'VERNIZ', 'MIXING BASE POL']) Then
    Result := True;
end;

function TCadastroBasesDupont.fVerificaBasesNovasFormulas: Boolean;
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
    '   DUP_CADNFM               ' +
    ' ' + strWhere + '           ' ,
    'QTD', [GetQueryCadastro.FieldByName('BAS_CODBAS').AsString]
  ) > 0;
end;

{function TCadastroBasesDupont.GetCampoEmbalagem: string;
begin
  Result := 'BAS_EMBALA';
end;}

{function TCadastroBasesDupont.GetCampoPesoEspecifico: string;
begin
  Result := 'BAS_PESESP';
end;}

function TCadastroBasesDupont.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroBasesDupont.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroBasesDupont.GetDescDbComboBox: String;
Var
  qryGen: IDataSet;
begin
  Try
    qryGen := TAutcomTintaFactory.Get.fGetDataSet;
    qryGen.Close;
    qryGen.SQL := '';
    qryGen.SQL := qryGen.SQL + '  SELECT          ';
    qryGen.SQL := qryGen.SQL + '    *             ';
    qryGen.SQL := qryGen.SQL + '  FROM            ';
    qryGen.SQL := qryGen.SQL + '    TABTIN        ';
    qryGen.SQL := qryGen.SQL + '  WHERE TIN_TABELA = "DUP_CADBAS"           ';
    qryGen.SQL := qryGen.SQL + '    AND TIN_CAMPO_ = "BAS_EMBALA"           ';
    qryGen.SQL := qryGen.SQL + '  ORDER BY TIN_VALCOM                       ';
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

function TCadastroBasesDupont.GetNomeCampo: string;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroBasesDupont.GetNomeCampoItem: string;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroBasesDupont.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroBasesDupont.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroBasesDupont.GetNomeTabela: string;
begin
  Result := 'DUP_CADBAS';
end;

function TCadastroBasesDupont.GetPreencherDbComboBox: Boolean;
begin
  Result := True;
end;

function TCadastroBasesDupont.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttBases;
end;

function TCadastroBasesDupont.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroBasesDupont.GetTitulo: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TCadastroBasesDupont.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
var
  qryGen: IDataSet;
  fltEmbala: Double;
begin
  If tela.GetBlnGravou Then
  Begin
    //Atualiza o fator tintometrico do produto amarrado
    If (Not TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value)) Then
    Begin
      If Tela['chkPesGra']['Checked'].Value Then
        fltEmbala := GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat
      Else
        fltEmbala := TAutcomTintaFactory.Get.fStrToFloat(Tela['dbePesEsp']['Text'].Value) * GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat;

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'UPDATE CADITE                                     ' +
                    ' INNER JOIN DUP_CADBAS ON ITE_CODITE = BAS_CODITE ' +
                    ' SET ITE_CNV_ML = ' + AnsiReplaceStr(FloatToStr(fltEmbala), ',', '.')  + '  ' +
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
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'DUP');
      End;

    End;
  End;
end;

procedure TCadastroBasesDupont.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodIte := '';
  blnAlterou := False;

  tela['edtDesItemBase']['text'].Value := '';
  tela['chkPesGra']['Checked'].Value := False;
end;

procedure TCadastroBasesDupont.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodIte := '';
  tela['edtDesItemBase']['text'].Value := '';
  blnAlterou := False;
end;

procedure TCadastroBasesDupont.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
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

procedure TCadastroBasesDupont.pLimparCnvMLItemDesamarraBase(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  //Seleciona o item amarrado a base antes da alteracao
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT BAS_CODITE FROM DUP_CADBAS WHERE BAS_CODBAS = :CODBAS';
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

procedure TCadastroBasesDupont.pLimparFatorTintometrico(strCodIte: String);
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

procedure TCadastroBasesDupont.pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
begin
//  tela['dbePesEsp']['Visible'].Value := (strState = 'dsInsert');
//  tela['lblPesEsp']['Visible'].Value := (strState = 'dsInsert');
end;

end.
