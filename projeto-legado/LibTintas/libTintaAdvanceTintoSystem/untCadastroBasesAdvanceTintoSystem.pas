{ ************************************************************** }
{ * Classe que representa um cadastro de base AdvanceTintoSystem * }
{ ***********************************************************AC* }
unit untCadastroBasesAdvanceTintoSystem;

interface

uses
  untBtnRestaurarPrecoEvento, untDbeCodUniKeyPress,
  untDbeCodEmbKeyPressBasesAdvanceTintoSystem, untAbstractCadastro,
  untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroBasesAdvanceTintoSystem = class(TAbstractCadastro)
  private
    strCodite : String;
    function fVerificaBasesNovasFormulas: Boolean;
    function fVerificaEmbalagemCadastrada(strCodEmb: String): Boolean;
    function fTemColorante(strCodigo: String): Boolean;
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
    function fValidaCampos(const tela: ITelaCadLibTintas; strNomeCampo: string;
      strValorCampo: string; var strRetorno: string): Boolean; override;

    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); override;
    procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;

    procedure AjustarTela(const tela: ITelaCadLibTintas); override;
    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;

    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string) : Boolean; override;

    function GetNomeCampoItem: string; override;
    function GetNomeCampoUnidade: string; override;

    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;

    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas;const strState: string); override;
    procedure CancelarAntes(const tela: ITelaCadLibTintas;const strState: string); override;

  end;

implementation

uses
  untDbePesquisaItemKeyPress, untConsultaCadastroBaseAdvanceTintoSystem,
  untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao;

{ TCadastroBasesAdvanceTintoSystem }

procedure TCadastroBasesAdvanceTintoSystem.AjustarTela
  (const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value := 525;
  tela.GetSelf['Height'].Value := 248;
end;

procedure TCadastroBasesAdvanceTintoSystem.CancelarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodite := '';

end;

procedure TCadastroBasesAdvanceTintoSystem.CarregarDescricoes
  (const tela: ITelaCadLibTintas);
begin
  tela['edtDesUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
      ' SELECT                     ' +
      '   EMB_DESCRI               ' +
      ' FROM                       ' +
      '   ADT_CADEMB               ' +
      ' WHERE EMB_CODEMB = :CODEMB ',
      'EMB_DESCRI', [tela['dbeEmbala']['Text'].Value]);

  tela['edtSigUni']['Text'].Value :=
    TAutcomTintaFactory.Get.GetValorCampo(
     ' SELECT                     ' +
     '    EMB_CODUNI              ' +
     ' FROM                       ' +
     '   ADT_CADEMB                   ' +
    ' WHERE EMB_CODEMB = :CODEMB ',
      'EMB_CODUNI', [tela['dbeEmbala']['Text'].Value]);

  tela['edtDesItemBase']['Text'].Value :=
    TAutcomTintaFactory.Get.fGetDescricaoProdutoTinta(tela['dbeItemBase']['Text'].Value, GetTipoCadastro);
end;

procedure TCadastroBasesAdvanceTintoSystem.ConstruirControles;
begin
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo',    'Código:', 55, 20, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao','Descrição:', 55, 42, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto','Produto:', 55, 64, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem','Embalagem:', 55, 86, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblItemBase','Item:', 55, 108, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoCusto','Custo:', 55, 130, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPrecoVenda','Venda:', 367, 130, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblMargem','Margem:', 206, 130, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblPesEsp','Peso Especifico:', 206, 152, 20, 14, 'taRightJustify'));
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblConteudo','Conteúdo:', 367, 152, 20, 14, 'taRightJustify'));

  AdicionarControle(TLibTintaControleVisualImplementacao.Create
    (' object btnRestPreco: TSpeedButton                                   ' +
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
    .AdicionarEvento(TBtnRestaurarPrecoEvento.Create(Self, 'dbeItemBase',
    'dbePrecoCusto', 'dbeMargem', 'dbePrecoVenda')));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeCodigo', 80, 16, 97, 22, 'ttAlfanumerico', 'BAS_CODBAS'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeDescri', 80, 38, 410, 22, 'ttAlfanumerico', 'BAS_DESCRI'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeProdut', 80, 60, 410, 22, 'ttAlfanumerico', 'BAS_PRODUT'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeEmbala', 80, 82, 50, 22, 'ttAlfanumerico', 'BAS_CODEMB')
    .AdicionarEvento(TDbeCodEmbKeyPressBasesAdvanceTintoSystem.Create
    ('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesUni',
    130, 82, 312, 22, 'ttAlfanumerico').AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('CharCase', 'ecUpperCase')).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('NormalColor', 16768952)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('TabStop', false)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Requerido', false)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtSigUni',
    442, 82, 48, 22, 'ttAlfanumerico').AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('CharCase', 'ecUpperCase')).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('NormalColor', 16768952)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('TabStop', false)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('Requerido', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create
    ('dbeItemBase', 80, 104, 50, 22, 'ttNumerico', 'BAS_CODITE')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('CharCase', 'ecUpperCase')).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('CompZeros', 'True'))
    .AdicionarEvento(TDbePesquisaItemKeyPress.Create(Self, 'dbeItemBase',
    'dbePrecoCusto', 'dbeMargem', 'dbePrecoVenda',
    'TCadastroBasesAdvanceTintoSystem')));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create
    ('edtDesItemBase', 130, 104, 360, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Enabled', false)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase')
    ).AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Color', 16768952)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('FocusColor', 16768952)).AdicionarPropriedade
    (TGenericLibTintaControleVisualPropriedade.Create('TabStop', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create
    ('Requerido', false)));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoCusto', 80, 126, 97, 22, 'ttAlfanumerico', 'BAS_PRECUS'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeMargem', 236, 126, 97, 22, 'ttAlfanumerico', 'BAS_MARGEM'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePrecoVenda', 393, 126, 97, 22, 'ttAlfanumerico', 'BAS_PREVEN'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbePesEsp', 236, 148, 97, 22, 'ttAlfanumerico', 'BAS_PESESP'));
  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeConteudo', 393, 148, 97, 22, 'ttAlfanumerico', 'BAS_CONTEU'));

end;

procedure TCadastroBasesAdvanceTintoSystem.ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '';
  tela['edtDesUni']['text'].Value := '';
end;

function TCadastroBasesAdvanceTintoSystem.fGetCampoChave(const index: Integer): string;
const
  arrCampos: array [0 .. 2] of string = ('BAS_CODBAS', 'BAS_PRODUT', 'BAS_CODEMB');
begin
  Result := arrCampos[index];
end;

function TCadastroBasesAdvanceTintoSystem.fGetCountCamposChave: Integer;
begin
  Result := 3;
end;

procedure TCadastroBasesAdvanceTintoSystem.FormatarCampo(const strNomeCampo : string; var arrPropriedades: TCadLibTintasStringArray;
  var arrValores: TCadLibTintasVariantArray);
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
  Else If MatchStr(strNomeCampo, ['BAS_CONTEU']) Then
  Begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.0000';
    arrValores[1] := '0.0000';
  End;
end;

function TCadastroBasesAdvanceTintoSystem.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroBasesAdvanceTintoSystem.fPodeExcluir: Boolean;
begin
  Result := True;
  If fVerificaBasesNovasFormulas Then
  Begin
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Já existe Nova Fórmula cadastrada para essa Base + Unidade + Descrição, por isso não será possível excluí-la.',['&OK']);
    Result := false;
  End;
end;

function TCadastroBasesAdvanceTintoSystem.fPodeGravar
 (const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := True;

  If TAutcomTintaFactory.Get.fExisteValorNoCampo(strToFloatDef(tela['dbeItemBase']['Text'].Value, 0), 'BAS_CODITE',
    GetNomeTabela, 'AUTOINCREM <> ' + QuotedStr(GetQueryCadastro.FieldByName('AUTOINCREM').AsString)) Then
  Begin
    Result :=
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Esse item já está relacionado a outra base!'#10#13'Deseja continuar ?', ['Sim', 'Não']) = 1;
  End;

  If strState = 'dsEdit' Then
  Begin
    If TStrUtils.fEmptyStr(GetQueryCadastro.FieldByName('BAS_CODITE').AsString) And fVerificaBasesNovasFormulas Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO', 'Já existe Nova Fórmula cadastrada para essa Base, por isso não será possível desamarrá-la.', ['&OK']);
      Result := false;
    End;
  End;
end;

function TCadastroBasesAdvanceTintoSystem.fTemColorante(
  strCodigo: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.Close;
  qryGen.SQL := ' SELECT * FROM ADT_CADCOL WHERE COL_CODCOL = :CODCOL   ';
  qryGen.ParamByName('CODCOL').AsString := strCodigo;
  qryGen.Open;

  Result := Not qryGen.IsEmpty;
end;

function TCadastroBasesAdvanceTintoSystem.fValidaCampos(const tela: ITelaCadLibTintas;
 strNomeCampo: string; strValorCampo: string;
 var strRetorno: string): Boolean;
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

    If fTemColorante(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('Ja existe um registro para o código [%s] no Cadastro de Colorantes', [strValorCampo]);
    End;
  End
  Else If (strNomeCampo = 'BAS_CODEMB') Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := false;
      strRetorno := 'A embalagem deve ser preenchida!';
    End
    Else If Not fVerificaEmbalagemCadastrada(strValorCampo) Then
    Begin
      Result := False;
      strRetorno := Format('A embalagem %s não está cadastrada!', [strValorCampo]);
    End;
  End
  Else If (strNomeCampo = 'BAS_PRODUT') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O produto deve ser preenchido!';
  End
  Else If (strNomeCampo = 'BAS_PRECUS') Then
  Begin
    GetQueryCadastro.FieldByName('BAS_MARGEM').AsFloat :=
      TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
      strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
      strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
      strToFloatDef(tela['dbeMargem']['Text'].Value, 0), 0, 0, 0, 0);

    If (strToFloatDef(strValorCampo, 0) <= 0) Then
      GetQueryCadastro.FieldByName('BAS_PRECUS').AsFloat := 0.0;
  End
  Else If (strNomeCampo = 'BAS_MARGEM') Then
  Begin
    GetQueryCadastro.FieldByName('BAS_PREVEN').AsFloat :=
      TAutcomTintaFactory.Get.fCalculaPrecoVenda(1,
      strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
      strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
      strToFloatDef(tela['dbeMargem']['Text'].Value, 0), 0, 0, 0, 0);
  End
  Else If (strNomeCampo = 'BAS_PREVEN') Then
  Begin
    GetQueryCadastro.FieldByName('BAS_MARGEM').AsFloat :=
      TAutcomTintaFactory.Get.fCalculaPrecoVenda(2,
      strToFloatDef(tela['dbePrecoCusto']['Text'].Value, 0),
      strToFloatDef(tela['dbePrecoVenda']['Text'].Value, 0),
      strToFloatDef(tela['dbeMargem']['Text'].Value, 0), 0, 0, 0, 0);
  End
  Else If (strNomeCampo = 'BAS_CODITE') Then
  Begin
    If Not TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      If TStrUtils.fEmptyStr(tela['edtDesItemBase']['Text'].Value) Then
      Begin
        Result := false;
        strRetorno := Format('O produto %s não está cadastrado',
          [strValorCampo]);
      End
      Else If Not fValidaUnidadeItem(strValorCampo, tela['edtSigUni']['Text'].Value) Then
      Begin
        Result := False;
        strRetorno := Format('A unidade do produto %s não é válida para esta base', [strValorCampo]);
      End
      Else
      Begin
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
  End
  Else If (strNomeCampo = 'BAS_CONTEU') Then
  Begin
    If TStrUtils.fEmptyStr(strValorCampo) Then
    Begin
      Result := false;
      strRetorno := 'O campo Conteúdo deve ser preenchido!';
    End
    Else If (strToFloatDef(strValorCampo, 0) <= 0) Then
    Begin
      Result := false;
      strRetorno := 'O Campo Conteúdo deve ser maior que zero!';
    End;
  End;
end;

function TCadastroBasesAdvanceTintoSystem.fVerificaBasesNovasFormulas: Boolean;
begin
  Result :=
    TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   ADT_CADNFM               ' +
    ' WHERE NFM_CODBAS = :CODBAS ' +
    '   AND NFM_PRODUT = :CODPRO ' +
    '   AND NFM_CODEMB = :CODEMB ', 'QTD',
    [GetQueryCadastro.FieldByName('BAS_CODBAS').AsString,
    GetQueryCadastro.FieldByName('BAS_PRODUT').AsString,
    GetQueryCadastro.FieldByName('BAS_CODEMB').AsString]) > 0;
end;

function TCadastroBasesAdvanceTintoSystem.fVerificaEmbalagemCadastrada(
  strCodEmb: String): Boolean;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := ' SELECT          ' +
                '   *             ' +
                ' FROM            ' +
                '   ADT_CADEMB    ' +
                ' WHERE           ' +
                '   EMB_CODEMB = :EMBALAGEM ';

  qryGen.ParamByName('EMBALAGEM').AsString := strCodEmb;
  qryGen.Open;

  Result := (Not qryGen.IsEmpty);

end;

function TCadastroBasesAdvanceTintoSystem.GetCamposDesabilitadosEdit
  : TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroBasesAdvanceTintoSystem.GetConsulta: IConsulta;
begin
  Result := TConsultaCadastroBaseAdvanceTintoSystem.Create;
end;

function TCadastroBasesAdvanceTintoSystem.GetNomeCampo: string;
begin
  Result := 'BAS_CODBAS';
end;

function TCadastroBasesAdvanceTintoSystem.GetNomeCampoItem: string;
begin
  Result := 'BAS_CODITE';
end;

function TCadastroBasesAdvanceTintoSystem.GetNomeCampoRelacionamento: string;
begin
  Result := 'Código do Item';
end;

function TCadastroBasesAdvanceTintoSystem.GetNomeCampoUnidade: string;
begin
  Result := 'BAS_CODEMB';
end;

function TCadastroBasesAdvanceTintoSystem.GetNomeTabela: string;
begin
  Result := 'ADT_CADBAS';
end;

function TCadastroBasesAdvanceTintoSystem.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttBases;
end;

function TCadastroBasesAdvanceTintoSystem.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroBasesAdvanceTintoSystem.GetTitulo: string;
begin
  Result := 'Cadastro de Bases';
end;

procedure TCadastroBasesAdvanceTintoSystem.GravarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  If TStrUtils.fEmptyStr(tela['dbeItemBase']['Text'].Value) Then
    GetQueryCadastro.FieldByName('BAS_CODITE').Value := Null;

  If (strState = 'dsInsert') Or (strState = 'dsEdit') Then
  Begin
    If TAutcomTintaFactory.Get.fMensagem('', 'Informe o tipo de cadastro: ', ['&Base', '&Catalisador']) = 1 Then
      GetQueryCadastro.FieldByName('BAS_DESCRI').AsString := GetQueryCadastro.FieldByName('BAS_DESCRI').AsString
    Else
      GetQueryCadastro.FieldByName('BAS_DESCRI').AsString := GetQueryCadastro.FieldByName('BAS_DESCRI').AsString + ' PARTE B';
  End;
end;

procedure TCadastroBasesAdvanceTintoSystem.IncluirDepois
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodite := '';
  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '';
  tela['edtDesUni']['text'].Value := '';
end;

procedure TCadastroBasesAdvanceTintoSystem.PesquisarAntes
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
  strCodite := '';
  tela['edtDesItemBase']['text'].Value := '';
  tela['edtSigUni']['text'].Value := '';
  tela['edtDesUni']['text'].Value := '';
end;

procedure TCadastroBasesAdvanceTintoSystem.pSetaEnableReadOnly
  (const tela: ITelaCadLibTintas; const strState: string);
begin
  tela['btnRestPreco']['Visible'].Value := (strState = 'dsEdit');
  tela['lblPesEsp']['Visible'].Value    := (strState = 'dsInsert');
  tela['dbePesEsp']['Visible'].Value    := (strState = 'dsInsert');
  tela['lblConteudo']['Visible'].Value := (strState = 'dsInsert');
  tela['dbeConteudo']['Visible'].Value := (strState = 'dsInsert');
end;

end.
