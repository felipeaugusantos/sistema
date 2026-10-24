{**************************************************************}
{* Classe que representa um cadastro de base CoralImobiliaria *}
{***********************************************************AC*}
unit untCadastroBasesCoralImobiliaria;

interface

uses
  untBtnRestaurarPrecoEvento, untDbeCodUniKeyPress, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroBasesCoralImobiliaria = class(TAbstractCadastro)
  private
    strCodIte : String;
    strCodIteAlt: String;
    function fVerificaBasesNovasFormulas: Boolean;
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
    procedure AlterarDepois(const tela: ITelaCadLibTintas; const strState: string); override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure pPreencherValorVenda(const tela: ITelaCadLibTintas; Var strVlrCusto, strValorMargem, strValorVenda : String);

//    function fPreencherValorVenda(const tela: ITelaCadLibTintas) : Boolean;

  end;

implementation

uses
  untDbePesquisaItemKeyPress, untConsultaCadastroBaseCoralImobiliaria, untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao;

{ TCadastroBasesCoralImobiliaria }


procedure TCadastroBasesCoralImobiliaria.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
end;

procedure TCadastroBasesCoralImobiliaria.AlterarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;	
  strCodIteAlt := tela['dbeItemBase']['Text'].Value;
end;

procedure TCadastroBasesCoralImobiliaria.CancelarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodIte := '';
end;

procedure TCadastroBasesCoralImobiliaria.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDesUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   UNI_DESUNI               ' +
      ' FROM                       ' +
      '   CADUNI                   ' +
      ' WHERE UNI_CODUNI = :CODUNI ' +
      '   AND UNI_SIGUNI IN ("QT","LT","GL","LA") ', 'UNI_DESUNI', [tela['dbeCodUni']['Text'].Value]);

  tela['edtSigUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   UNI_SIGUNI               ' +
      ' FROM                       ' +
      '   CADUNI                   ' +
      ' WHERE UNI_CODUNI = :CODUNI ' +
      '   AND UNI_SIGUNI IN ("QT","LT","GL","LA") ', 'UNI_SIGUNI', [
        tela['dbeCodUni']['Text'].Value
      ]);

  tela['edtDesItemBase']['Text'].Value := TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItemBase']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroBasesCoralImobiliaria.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 16, 62, 52, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItemBase', 'Item:', 46, 86, 22, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodUni', 'Unidade:', 26, 42, 42, 14, 'taRightJustify'));
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

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 97, 22, 'ttAlfanumerico', 'BAS_BASE__'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 72, 38, 49, 22, 'ttAlfanumerico', 'BAS_UNIDAD')
    .AdicionarEvento(TDbeCodUniKeyPress.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesUni', 121, 38, 312, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtSigUni', 432, 38, 49, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 72, 60, 409, 22, 'ttAlfanumerico', 'BAS_DESCRI'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeItemBase', 72, 82, 49, 22, 'ttNumerico', 'BAS_CODITE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('MaxLength', TAutcomTintaFactory.Get.fTamCodIte))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CompZeros', 'False'))
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItemBase', 'dbePrecoCusto', 'dbeMargem', 'dbePrecoVenda','TCadastroBasesCoralImobiliaria')));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesItemBase', 121, 82, 360, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False))
  );

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoCusto', 72, 104, 97, 22, 'ttAlfanumerico', 'BAS_PRECUS'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMargem', 228, 104, 97, 22, 'ttAlfanumerico', 'BAS_MARGEM'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoVenda', 384, 104, 97, 22, 'ttAlfanumerico', 'BAS_PREVEN'));
end;

procedure TCadastroBasesCoralImobiliaria.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '' ;
  tela['edtDesUni']['text'].Value := '';
end;

function TCadastroBasesCoralImobiliaria.fGetCampoChave(
  const index: Integer): string;
const
  arrCampos: array[0..2] of string = ('BAS_BASE__', 'BAS_UNIDAD', 'BAS_DESCRI');
begin
  Result := arrCampos[index];
end;

function TCadastroBasesCoralImobiliaria.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

procedure TCadastroBasesCoralImobiliaria.FormatarCampo(const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(strNomeCampo, ['BAS_PRECUS', 'BAS_PREVEN', 'BAS_MARGEM']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end;  
end;

function TCadastroBasesCoralImobiliaria.fPodeAlterar: Boolean;
begin
  Result := True;

end;

function TCadastroBasesCoralImobiliaria.fPodeExcluir: Boolean;
begin
  Result := True;
  If fVerificaBasesNovasFormulas Then
  Begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para essa Base + Unidade + Descrição, por isso não será possível excluí-la.',['&OK']);
    Result := False;
  End;
end;

function TCadastroBasesCoralImobiliaria.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
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
end;

{function TCadastroBasesCoralImobiliaria.fPreencherValorVenda(const tela: ITelaCadLibTintas): Boolean;
begin
  Result := ((TStrUtils.fEmptyStr(tela['dbePrecoCusto']['Text'].Value))
            Or (strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0) =  0)
            Or (TStrUtils.fEmptyStr(tela['dbePrecoVenda']['Text'].Value))
            Or (strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0) =  0)
            Or (TStrUtils.fEmptyStr(tela['dbeMargem']['Text'].Value))
            Or (strToFloatDef(tela['dbeMargem']['Text'].Value, 0) =  0));
end;
 }
procedure TCadastroBasesCoralImobiliaria.pPreencherValorVenda(const tela: ITelaCadLibTintas;
var strVlrCusto,   strValorMargem, strValorVenda: String);
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT ITE_PRECUS '+
                '      , ITE_PREVE1 '+
                '      , ITE_MARBR1 '+
                '   FROM ITEGER '+
                '  WHERE ITE_CODITE =:CODITE '+
                '    AND ITE_CODEMP =:CODEMP ';

  qryGen.ParamByName('CODITE').AsString := tela['dbeItemBase']['Text'].Value;
  qryGen.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;

  qryGen.Open;

  strVlrCusto    := qryGen.FieldByName('ITE_PRECUS').AsString;
  strValorVenda  := qryGen.FieldByName('ITE_PREVE1').AsString;
  strValorMargem := qryGen.FieldByName('ITE_MARBR1').AsString;
end;

function TCadastroBasesCoralImobiliaria.fValidaCampos(const tela: ITelaCadLibTintas;
  strNomeCampo: string; strValorCampo: string; var strRetorno: string): Boolean;
Var
  strVlrCusto    : String;
  strValorMargem : String;
  strValorVenda  : String;
begin
  Result := True;
  CarregarDescricoes(tela);
   If (strNomeCampo = 'BAS_BASE__') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A base deve ser preenchida!';
  End
  Else If (strNomeCampo = 'BAS_UNIDAD') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A unidade deve ser preenchida!';

    if Result then
    begin
      Result := not TStrUtils.fEmptyStr(tela['edtDesUni']['Text'].Value);
      strRetorno := 'A unidade selecionada não é válida!';
    end;
  End
  Else If (strNomeCampo = 'BAS_DESCRI') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
  End
  Else If (strNomeCampo = 'BAS_PRECUS') Then
  Begin

    If Not (strCodIteAlt = strCodIte) Then
    Begin
      GetQueryCadastro.FieldByName('BAS_MARGEM').AsFloat :=
          TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
            strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
            strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
            strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
            0, 0, 0, 0);



      If (strToFloatDef(strValorCampo, 0) <= 0) Then
        GetQueryCadastro.FieldByName('BAS_PRECUS').AsFloat := 0.0;
    End;
  End
  Else If (strNomeCampo = 'BAS_MARGEM') Then
  Begin
    If Not (strCodIteAlt = strCodIte) Then
    Begin
      GetQueryCadastro.FieldByName('BAS_PREVEN').AsFloat :=
          TAutcomTintaFactory.Get.fCalculaPrecoVenda(1,
            strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
            strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
            strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
            0, 0, 0, 0);
    End;


  End
  Else If (strNomeCampo = 'BAS_PREVEN') Then
  Begin
    If Not (strCodIteAlt = strCodIte) Then
    Begin
      GetQueryCadastro.FieldByName('BAS_MARGEM').AsFloat :=
          TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
            strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
            strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
            strToFloatDef(tela['dbeMargem']['Text'].Value, 0),
            0, 0, 0, 0);
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
      Else If Not fValidaUnidadeItem(strValorCampo, GetQueryCadastro.FieldByName('BAS_UNIDAD').AsString) Then
      Begin
        Result := False;
        strRetorno := Format('A unidade do produto %s não é válida para esta base', [strValorCampo]);
      End
      Else
      begin
        If (strCodIte <> strValorCampo) Then
        Begin

          pPreencherValorVenda(tela, strVlrCusto, strValorMargem, strValorVenda);

          If Not (strCodIteAlt = strValorCampo) Then
          Begin
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
          End;
        End;

        strCodIte := strValorCampo;
      End;
    End;
  End;
end;

function TCadastroBasesCoralImobiliaria.fVerificaBasesNovasFormulas: Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   CORIMO_CADNFM            ' +
    ' WHERE NFM_CODBAS = :CODBAS ' +
    '   AND NFM_DESPRO = :CODPRO ' +
    '   AND NFM_UNIDAD = :UNIDAD ',
    'QTD', [GetQueryCadastro.FieldByName('BAS_BASE__').AsString,
            GetQueryCadastro.FieldByName('BAS_DESCRI').AsString,
            GetQueryCadastro.FieldByName('BAS_UNIDAD').AsString]
  ) > 0;
end;

function TCadastroBasesCoralImobiliaria.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroBasesCoralImobiliaria.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroBaseCoralImobiliaria.Create;
end;

function TCadastroBasesCoralImobiliaria.GetNomeCampo: string;
begin
  Result := 'BAS_BASE__';
end;

function TCadastroBasesCoralImobiliaria.GetNomeCampoItem: string;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroBasesCoralImobiliaria.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroBasesCoralImobiliaria.GetNomeCampoUnidade: string;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroBasesCoralImobiliaria.GetNomeTabela: string;
begin
  Result := 'CORIMO_CADBAS';
end;

function TCadastroBasesCoralImobiliaria.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttBases;
end;

function TCadastroBasesCoralImobiliaria.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroBasesCoralImobiliaria.GetTitulo: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TCadastroBasesCoralImobiliaria.GravarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodIte := '';

  If TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value) Then
    GetQueryCadastro.FieldByName('BAS_CODITE').Value := Null;
end;

procedure TCadastroBasesCoralImobiliaria.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '' ;
  tela['edtDesUni']['text'].Value := '';
end;

procedure TCadastroBasesCoralImobiliaria.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodIte := '';

  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '' ;
  tela['edtDesUni']['text'].Value := '';
end;

procedure TCadastroBasesCoralImobiliaria.pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnRestPreco']['Visible'].Value := (strState = 'dsEdit');
end;

end.
