{***************************************************************}
{* Classe que representa um cadastro de base Montana *}
{************************************************************AC*}
unit untCadastroBasesMontana;

interface

uses
  untBtnRestaurarPrecoEvento, untDbeCodUniKeyPress, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroBasesMontana = class(TAbstractCadastro)
  private
    strCodite : String;
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

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    function GetPreencherDbComboBox: Boolean; override;
    function GetDescDbComboBox: String; override;

    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure CancelarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

//    function fValidarProduto(strProduto : string) : Boolean;
//    function fValidarAcabamento(strAcabamento : String ) : Boolean;

  end;

implementation

uses
  untDbePesquisaItemKeyPress, untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao, untDbeCodUniKeyPressMontana,
  untDbeProdutoKeyPressMontana, untDbeAcabamentoKeyPressMontana;

{ TCadastroBasesMontana }


procedure TCadastroBasesMontana.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;

end;

procedure TCadastroBasesMontana.CancelarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodite := '';
end;

procedure TCadastroBasesMontana.CarregarDescricoes(
  const tela: ITelaCadLibTintas);
begin
  tela['edtDesUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   UNI_DESUNI               ' +
      ' FROM                       ' +
      '   CADUNI                   ' +
      ' WHERE UNI_CODUNI = :CODUNI ' +
      '   AND UNI_SIGUNI IN ("QT","GL", "BL") ', 'UNI_DESUNI', [tela['dbeCodUni']['Text'].Value]);

  tela['edtSigUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   UNI_SIGUNI               ' +
      ' FROM                       ' +
      '   CADUNI                   ' +
      ' WHERE UNI_CODUNI = :CODUNI ' +
      '   AND UNI_SIGUNI IN ("QT","GL", "BL") ', 'UNI_SIGUNI', [
        tela['dbeCodUni']['Text'].Value
      ]);

  tela['edtDesItemBase']['Text'].Value := TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItemBase']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroBasesMontana.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto', 'Produto:', 195,  20, 30, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodUni',  'Unidade:', 26, 42, 42, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblAcabamento', 'Acabamento:', 16, 64, 52, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 16, 86, 52, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItemBase', 'Item:', 46, 108, 22, 14, 'taRightJustify'));
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


  // CÓDIGO
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 97, 22, 'ttAlfanumerico', 'BAS_CODBAS')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0')));


  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProduto', 230, 16, 250, 22, 'ttAlfanumerico', 'BAS_PRODUT')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1'))
    .AdicionarEvento(TDbeProdutoKeyPressMontana.Create('OnKeyPress', Self)));
  // UNIDADE

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 72, 38, 49, 22, 'ttAlfanumerico', 'BAS_UNIDAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '2'))
    .AdicionarEvento(TDbeCodUniKeyPressMontana.Create('OnKeyPress', Self)));

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

  // ACABAMENTO
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeAcabamento', 72, 60, 410, 22, 'ttAlfanumerico', 'BAS_ACABAM')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '3'))
    .AdicionarEvento(TDbeAcabamentoKeyPressMontana.Create('OnKeyPress', Self)));

  //DESCRIÇÃO
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 72, 82, 409, 22, 'ttAlfanumerico', 'BAS_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4')));

  //ITEM
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeItemBase', 72, 104, 49, 22, 'ttNumerico', 'BAS_CODITE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '5'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItemBase', 'dbePrecoCusto', 'dbeMargem', 'dbePrecoVenda','TCadastroBasesMontana')));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesItemBase', 121, 104, 360, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
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

procedure TCadastroBasesMontana.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '' ;
  tela['edtDesUni']['text'].Value := '';
end;

function TCadastroBasesMontana.fGetCampoChave(
  const index: Integer): string;
const
  arrCampos: array[0..3] of string = ('BAS_CODBAS', 'BAS_UNIDAD', 'BAS_PRODUT', 'BAS_ACABAM');
begin
  Result := arrCampos[index];
end;

function TCadastroBasesMontana.fGetCountCamposChave: Integer;
begin
  Result := 4;
end;

procedure TCadastroBasesMontana.FormatarCampo(const strNomeCampo: string;
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

function TCadastroBasesMontana.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroBasesMontana.fPodeExcluir: Boolean;
begin
  Result := True;
  If fVerificaBasesNovasFormulas Then
  Begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para essa Base + Unidade + Produto, por isso não será possível excluí-la.',['&OK']);
    Result := False;
  End;
end;

function TCadastroBasesMontana.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
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

function TCadastroBasesMontana.fValidaCampos(const tela: ITelaCadLibTintas;
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

  Else If (strNomeCampo = 'BAS_ACABAM') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O Acabamento deve ser preenchido!';
  End

  Else If (strNomeCampo = 'BAS_PRODUT') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O Produto deve ser preenchido!';
  End
  Else If (strNomeCampo = 'BAS_DESCRI') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
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
      Else If Not fValidaUnidadeItem(strValorCampo, GetQueryCadastro.FieldByName('BAS_UNIDAD').AsString) Then
      Begin
        Result := False;
        strRetorno := Format('A unidade do produto %s não é válida para esta base', [strValorCampo]);
      End
      Else
      begin
        If (strCodIte <> strValorCampo) Then
        Begin
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
        End;

        strCodIte := strValorCampo;
      End;
    End;
  End;
end;

{function TCadastroBasesMontana.fValidarAcabamento(strAcabamento: String): Boolean;
Var
  qryAux : IDataSet;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := ' SELECT 1 FIRST    '+
                '   FROM MON_CADBAS '+
                '  WHERE BAS_ACABAM =:ACABAMENTO '+
                '  GROUP BY 1 ';
  qryAux.ParamByName('ACABAMENTO').AsString := strAcabamento;
  qryAux.Open;

  Result := not(qryAux.IsEmpty);

end;
 }
{function TCadastroBasesMontana.fValidarProduto(strProduto: string): Boolean;
Var
  qryAux : IDataSet;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := ' SELECT 1 FIRST    '+
                '   FROM MON_CADBAS '+
                '  WHERE BAS_PRODUT =:PRODUT '+
                '  GROUP BY 1 ';
  qryAux.ParamByName('PRODUT').AsString := strProduto;
  qryAux.Open;

  Result := not(qryAux.IsEmpty);
end;
 }
function TCadastroBasesMontana.fVerificaBasesNovasFormulas: Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   MON_CADNFM               ' +
    ' WHERE NFM_CODBAS = :CODBAS ' +
    '   AND NFM_PRODUT = :PRODUT ' +
    '   AND NFM_UNIDAD = :UNIDAD ',
    'QTD', [GetQueryCadastro.FieldByName('BAS_CODBAS').AsString,
            GetQueryCadastro.FieldByName('BAS_PRODUT').AsString,
            GetQueryCadastro.FieldByName('BAS_UNIDAD').AsString]
  ) > 0;
end;

function TCadastroBasesMontana.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroBasesMontana.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroBasesMontana.GetDescDbComboBox: String;
begin
  Result := '';
end;

function TCadastroBasesMontana.GetNomeCampo: string;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroBasesMontana.GetNomeCampoItem: string;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroBasesMontana.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroBasesMontana.GetNomeCampoUnidade: string;
begin
  Result := 'BAS_UNIDAD';
end;

function TCadastroBasesMontana.GetNomeTabela: string;
begin
  Result := 'MON_CADBAS';
end;

function TCadastroBasesMontana.GetPreencherDbComboBox: Boolean;
begin
  Result := false;
end;

function TCadastroBasesMontana.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttBases;
end;

function TCadastroBasesMontana.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroBasesMontana.GetTitulo: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TCadastroBasesMontana.GravarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  If TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value) Then
    GetQueryCadastro.FieldByName('BAS_CODITE').Value := Null;

end;

procedure TCadastroBasesMontana.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodIte := '';
  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '' ;
  tela['edtDesUni']['text'].Value := '';
end;

procedure TCadastroBasesMontana.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  strCodIte := '';
  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '' ;
  tela['edtDesUni']['text'].Value := '';
end;

procedure TCadastroBasesMontana.pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnRestPreco']['Visible'].Value := (strState = 'dsEdit');
end;

end.
