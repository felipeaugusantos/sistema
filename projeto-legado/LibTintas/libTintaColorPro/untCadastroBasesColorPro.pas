{******************************************************}
{* Classe que representa um cadastro de base ColorPro *}
{***************************************************AC*}
unit untCadastroBasesColorPro;

interface

uses
  untBtnRestaurarPrecoEvento, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroBasesColorPro = class(TAbstractCadastro)
  private
    FIteOri: String;
    strCodIteAnt : String;
    blnZerarFatorExclusao: Boolean;
    strItemExclusao: String;
    procedure pLimparCnvMLItemDesamarraBase(const tela: ITelaCadLibTintas);
    function fItemNaoTeveMovimentacaoML(strCodIte: String): Boolean;
    function fVerificaBasesNovasFormulas: Boolean;
    procedure pCarregaLinha(const tela: ITelaCadLibTintas);
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

    function GetNomeCampoUnidade: string; override;

    procedure GravarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure CancelarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    function GetPreencherComboBox: Boolean; override;
    function GetDescComboBox: String; override;

    function GetTipoFormula(): Boolean; Override;
    procedure PreencherTipoFormula(const tela: ITelaCadLibTintas; Items: TStrings); Override;
  end;

implementation

uses
  untDbePesquisaItemKeyPress, untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao, untGenericLibTintaControleVisualDBCheckBox,
  untDbeComboLinhaChangeColorPro;

{ TCadastroBasesColorPro }


procedure TCadastroBasesColorPro.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 536;

  tela['ComboBox']['Visible'].Value  := True;
  tela['ComboBox']['Enabled'].Value  := False;
  tela['ComboBox']['Left'].Value     := 72;
  tela['ComboBox']['Top'].Value      := 16;
  tela['ComboBox']['Width'].Value    := 200;
  tela['ComboBox']['Height'].Value   := 22;
  tela['ComboBox']['TabOrder'].Value := 0;

  tela.Controle['ComboBox'].AdicionarEvento(TDbeComboLinhaChangeColorPro.Create(Self, 'ComboBox', 'dbeLinha'));
end;

procedure TCadastroBasesColorPro.AlterarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  blnAlterou := True;
  tela['ComboBox']['Enabled'].Value := False;
  tela['dbeLinha']['Enabled'].Value := False;
  tela['dbeBase']['Enabled'].Value  := False;
end;

procedure TCadastroBasesColorPro.CancelarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
end;

procedure TCadastroBasesColorPro.CancelarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  pCarregaLinha(tela);
  tela['ComboBox']['Enabled'].Value := False;
  blnAlterou := False;
end;

procedure TCadastroBasesColorPro.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDesItemBase']['Text'].Value := TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItemBase']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroBasesColorPro.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblLinha', 'Linha:', 32, 21, 36, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblBase', 'Base:', 350, 21, 36, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 32, 43, 36, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPesEsp', 'Peso Esp.:', 32, 65, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem', 'Embalagem:', 205, 65, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoVenda', 'Preço de Venda:', 382, 65, 36, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItemBase', 'Item:', 32, 88, 36, 14, 'taRightJustify'));



  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeLinha', 275, 16, 49, 22, 'ttAlfanumerico', 'BAS_LINHA_')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', 'False')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 390, 16, 120, 22, 'ttAlfanumerico', 'BAS_CODBAS')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 72, 38, 438, 22, 'ttAlfanumerico', 'BAS_DESBAS')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '2')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePesEsp', 72, 60, 97, 22, 'ttAlfanumerico', 'BAS_PESESP')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('ReadOnly', 'True'))
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '3')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoVenda', 420, 60, 90, 22, 'ttAlfanumerico', 'BAS_PREVEN')
   .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeItemBase', 72, 82, 49, 22, 'ttNumerico', 'BAS_CODITE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CompZeros', 'True'))
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItemBase', '', '', '')));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesItemBase', 121, 82, 389, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False))
  );

end;

procedure TCadastroBasesColorPro.ExcluirAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  FIteOri := tela['dbeItemBase']['Text'].Value;
  inherited;
  blnAlterou := False;
end;

procedure TCadastroBasesColorPro.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesItemBase']['Text'].Value := '';

  If tela.GetBlnExcluiu Then
  Begin
    tela['dbeLinha']['Text'].Value := '';
    tela['ComboBox']['ItemIndex'].Value := -1;

    If blnZerarFatorExclusao Then
    Begin
      pLimparFatorTintometrico(strItemExclusao);
      blnZerarFatorExclusao := False;
      strItemExclusao       := '';

      If Not (TStrUtils.fEmptyStr(FIteOri)) Then
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'WANPRO');

    End;
  End;
end;

function TCadastroBasesColorPro.fGetCampoChave(
  const index: Integer): string;
var
  arrChaves: Array Of String;
begin
  SetLength(arrChaves,2);

  arrChaves[0] := 'BAS_LINHA_';
  arrChaves[1] := 'BAS_CODBAS';

  Result := arrChaves[index];
end;

function TCadastroBasesColorPro.fGetCountCamposChave: Integer;
begin
  Result := 2;
end;

function TCadastroBasesColorPro.fItemNaoTeveMovimentacaoML(
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

procedure TCadastroBasesColorPro.FormatarCampo(const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(strNomeCampo, ['BAS_PREVEN', 'BAS_PESESP']) then
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

function TCadastroBasesColorPro.fPodeAlterar: Boolean;
begin
  Result := True;
  strCodIteAnt := GetQueryCadastro.FieldByName('BAS_CODITE').AsString;
end;

function TCadastroBasesColorPro.fPodeExcluir: Boolean;
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

function TCadastroBasesColorPro.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
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

  if Not TAutcomTintaFactory.Get.fValidarBaseItemAmarracao
    ('WANPRO', GetQueryCadastro.FieldByName('BAS_CODBAS').AsString, GetQueryCadastro.FieldByName('BAS_DESBAS').AsString,
    GetQueryCadastro.FieldByName('BAS_CODITE').AsString, StrCodIteAnt, GetQueryCadastro.FieldByName('BAS_PESESP').AsFloat,
    GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat) Then
  Begin
    Result := false;
  End;


end;

function TCadastroBasesColorPro.fValidaCampos(const tela: ITelaCadLibTintas;
  strNomeCampo: string; strValorCampo: string; var strRetorno: string): Boolean;
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
        Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo, 'WANPRO_CADBAS', 'BAS_CODBAS', 'BAS_QTDEMB')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
      Begin
        MensagemInfoDtaBalanco;
        Result := False;
        FormataEmbalagem(GetQueryCadastro, strValorCampo, 'WANPRO_CADBAS', 'BAS_EMBALA');
      End
      Else
        FormataEmbalagem(GetQueryCadastro, strValorCampo, 'WANPRO_CADBAS', 'BAS_EMBALA');
    End;
  End

  Else If (strNomeCampo = 'BAS_PESESP') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);

    If Not Result Then
      strRetorno := 'O peso específico deve ser preenchido!';

    If Result Then
    Begin
      If (strToFloatDef(strValorCampo, 0) <= 0) Then
      Begin
        Result := False;
        strRetorno := 'O peso específico deve ser maior que zero!';
      End
      Else If Not (VerificaDataBalanco(GetQueryCadastro, 'BAS'))  And (blnAlterou) And (
        Not fVerificaBasPesAntigo(GetQueryCadastro, strValorCampo,'WANPRO_CADBAS', 'BAS_CODBAS', '', 'BAS_PESESP')) And (Not fVerificaFatorTintometrico(GetQueryCadastro)) Then
      Begin
         MensagemInfoDtaBalanco;
         Result := False;
      End;
    End;
  End

  Else If (strNomeCampo = 'BAS_LINHA_') Then
  Begin
    If (TStrUtils.fEmptyStr(strValorCampo)) Then
    Begin
      Result := False;
      strRetorno := 'A Linha deve ser preenchida !';
    End;
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

    End;
  End;
end;

function TCadastroBasesColorPro.fVerificaBasesNovasFormulas: Boolean;
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
    '   WANPRO_CADNFM               ' +
    ' ' + strWhere + '           ' ,
    'QTD', [GetQueryCadastro.FieldByName('BAS_CODBAS').AsString]
  ) > 0;
end;

{function TCadastroBasesColorPro.GetCampoEmbalagem: string;
begin
  Result := 'BAS_EMBALA';
end;}

{function TCadastroBasesColorPro.GetCampoPesoEspecifico: string;
begin
  Result := 'BAS_PESESP';
end;}

function TCadastroBasesColorPro.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroBasesColorPro.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroBasesColorPro.GetDescComboBox: String;
begin
  Result := 'AUTOBASE PLUS 100:50,WANDABASE HS,WANDALAC,WANDA PU HS,WANDACAR,SINGLE STAGE CONVERTER,AUTOCOAT BT100,AUTOBASE PLUS 100:80,WANDA PU MS,';
  Result := Result + 'AUTOCOAT BT120,AUTOCOAT BT90,AUTOCOAT BT110,AUTOCOAT BT130,AUTOWAVE MM,AUTOWAVE MM 2.0,TECH FLEET PU,';
  Result := Result + 'TECH FLEET EPOXY,TECH FLEET SINTETICO,TECH FLEET LACA,';
  Result := Result + 'AUTOBASE PLUS BASELINE 100:80,AUTOBASE PLUS BASELINE 100:50';
end;

function TCadastroBasesColorPro.GetNomeCampo: string;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroBasesColorPro.GetNomeCampoItem: string;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroBasesColorPro.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroBasesColorPro.GetNomeCampoUnidade: string;
begin
  Result := '';
end;

function TCadastroBasesColorPro.GetNomeTabela: string;
begin
  Result := 'WANPRO_CADBAS';
end;

function TCadastroBasesColorPro.GetPreencherComboBox: Boolean;
begin
  Result := True
end;

function TCadastroBasesColorPro.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttBases;
end;

function TCadastroBasesColorPro.GetTipoFormula: Boolean;
begin
  Result := True;
end;

function TCadastroBasesColorPro.GetTipoTinta: TTipoTinta;
begin
  Result := ttAutomotiva;
end;

function TCadastroBasesColorPro.GetTitulo: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TCadastroBasesColorPro.GravarDepois(const tela: ITelaCadLibTintas; const strState: string);
var
  qryGen: IDataSet;
  fltEmbalagem: Double;
begin
  If tela.GetBlnGravou Then
  Begin
    //Atualiza o fator tintometrico do produto amarrado
    If (Not TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value)) Then
    Begin
      fltEmbalagem := TAutcomTintaFactory.Get.fStrToFloat(Tela['dbePesEsp']['Text'].Value) * GetQueryCadastro.FieldByName('BAS_EMBALA').AsFloat;

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      qryGen.SQL := 'UPDATE CADITE                                        ' +
                    ' INNER JOIN WANPRO_CADBAS ON ITE_CODITE = BAS_CODITE ' +
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
        TAutcomTintaFactory.Get.pEnviarLogRep(FIteOri, 'WANPRO');
      End;
    End;

    tela['ComboBox']['Enabled'].Value := False;
  End;
end;

procedure TCadastroBasesColorPro.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  blnAlterou := False;
  tela['edtDesItemBase']['text'].Value := '';
  tela['ComboBox']['Enabled'].Value    := True;
  tela['ComboBox']['ItemIndex'].Value  := 0;
  tela['dbeLinha']['text'].Value       := '1';
  tela['dbeLinha']['Enabled'].Value    := False;
end;

procedure TCadastroBasesColorPro.pCarregaLinha(const tela: ITelaCadLibTintas);
var
  strCodLin: String;
begin
  strCodLin := tela['dbeLinha']['Text'].Value;

  If TStrUtils.fEmptyStr(strCodLin) Then
  Begin
    tela['ComboBox']['ItemIndex'].Value := - 1;
    Exit;
  End;

  If strCodLin = '1' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autobase Plus 100:50')
    tela['ComboBox']['ItemIndex'].Value  := 0

  Else If strCodLin = '4' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Wandabase HS')
    tela['ComboBox']['ItemIndex'].Value  := 1

  Else If strCodLin = '6' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Wandalac')
    tela['ComboBox']['ItemIndex'].Value  := 2

  Else If strCodLin = '8' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Wanda PU HS')
    tela['ComboBox']['ItemIndex'].Value  := 3

  Else If strCodLin = '9' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Wandacar')
    tela['ComboBox']['ItemIndex'].Value  := 4

  Else If strCodLin = '11' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Single Stage Converter')
    tela['ComboBox']['ItemIndex'].Value  := 5

  Else If strCodLin = '13' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autocoat BT100')
    tela['ComboBox']['ItemIndex'].Value  := 6

  Else If strCodLin = '14' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autobase Plus 100:80')
    tela['ComboBox']['ItemIndex'].Value  := 7

  Else If strCodLin = '58' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Wanda PU MS')
    tela['ComboBox']['ItemIndex'].Value  := 8

  Else If strCodLin = '16' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autocoat BT120')
    tela['ComboBox']['ItemIndex'].Value  := 9

  Else If strCodLin = '59' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autocoat BT90')
    tela['ComboBox']['ItemIndex'].Value  := 10

  Else If strCodLin = '15' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autocoat BT110')
    tela['ComboBox']['ItemIndex'].Value  := 11

  Else If strCodLin = '17' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autocoat BT130')
    tela['ComboBox']['ItemIndex'].Value  := 12

  Else If strCodLin = '27' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autowave MM')
    tela['ComboBox']['ItemIndex'].Value  := 13

  Else If strCodLin = '67' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Autowave MM 2.0')
    tela['ComboBox']['ItemIndex'].Value  := 14

  Else If strCodLin = '72' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Tech Fleet PU');
    tela['ComboBox']['ItemIndex'].Value  := 15

  Else If strCodLin = '74' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Tech Fleet Epoxy');
    tela['ComboBox']['ItemIndex'].Value  := 16

  Else If strCodLin = '75' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Tech Fleet Sintetico');
    tela['ComboBox']['ItemIndex'].Value  := 17

  Else If strCodLin = '76' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Tech Fleet Laca');
    tela['ComboBox']['ItemIndex'].Value  := 18

  Else If strCodLin = '12' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Tech Fleet Laca');
    tela['ComboBox']['ItemIndex'].Value  := 19

  Else If strCodLin = '19' Then
//    tela['ComboBox']['Text'].Value := AnsiLowerCase('Tech Fleet Laca');
    tela['ComboBox']['ItemIndex'].Value  := 20;

end;

procedure TCadastroBasesColorPro.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['edtDesItemBase']['text'].Value := '';
  blnAlterou := False;
end;

procedure TCadastroBasesColorPro.PesquisarDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  pCarregaLinha(tela);
end;

procedure TCadastroBasesColorPro.GravarAntes(const tela: ITelaCadLibTintas; const strState: string);
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

procedure TCadastroBasesColorPro.pLimparCnvMLItemDesamarraBase(
  const tela: ITelaCadLibTintas);
var
  qryGen: IDataSet;
begin
  //Seleciona o item amarrado a base antes da alteracao
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT BAS_CODITE FROM WANPRO_CADBAS WHERE BAS_CODBAS = :CODBAS';
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

procedure TCadastroBasesColorPro.pLimparFatorTintometrico(strCodIte: String);
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

procedure TCadastroBasesColorPro.PreencherTipoFormula(
  const tela: ITelaCadLibTintas; Items: TStrings);
Var
  qryGen: IDataSet;
begin
  tela['DBTipoFormula']['Visible'].Value := True;
  tela['DBTipoFormula']['Top'].Value := 60;
  tela['DBTipoFormula']['Left'].Value := 242;
  tela['DBTipoFormula']['Width'].Value := 90;
  tela['DBTipoFormula']['Height'].Value := 22;
  tela['DBTipoFormula']['DataField'].Value := 'BAS_QTDEMB';
  tela['DBTipoFormula']['TabOrder'].Value := 5;

  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := '';
  qryGen.SQL := qryGen.SQL + '  SELECT          ';
  qryGen.SQL := qryGen.SQL + '    *             ';
  qryGen.SQL := qryGen.SQL + '  FROM            ';
  qryGen.SQL := qryGen.SQL + '    TABTIN        ';
  qryGen.SQL := qryGen.SQL + '  WHERE TIN_TABELA = "WANPRO_CADBAS"        ';
  qryGen.SQL := qryGen.SQL + '    AND TIN_CAMPO_ = "BAS_EMBALA"           ';
  qryGen.SQL := qryGen.SQL + '  ORDER BY TIN_VALCOM                       ';
  qryGen.Open;

  While Not qryGen.Eof Do
  Begin
    Items.Add(qryGen.FieldByName('TIN_OPCCOM').AsString);
    qryGen.Next;
  End;
end;

procedure TCadastroBasesColorPro.pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['dbePesEsp']['ReadOnly'].Value := (strState = 'dsEdit');
end;

end.
