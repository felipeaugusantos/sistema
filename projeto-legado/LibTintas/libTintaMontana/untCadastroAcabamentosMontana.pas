{***************************************************************}
{* Classe que representa um cadastro de base Montana *}
{************************************************************AC*}
unit untCadastroAcabamentosMontana;

interface

uses
  untBtnRestaurarPrecoEvento, untDbeCodUniKeyPress, untAbstractCadastro, untICadLibTintas, untIConsulta,
  untILibTintaControleVisual, untGenericLibTintaControleVisualPropriedade,
  untAbstractLibTintaControleVisualEvento, Variants,
  untIDataSet, SysUtils, untStrUtils, StrUtils,
  Classes, untTipoCadastro, untTipoTinta;

type
  TCadastroAcabamentosMontana = class(TAbstractCadastro)
  private
    function fVerificaBasesNovasFormulas: Boolean;

  protected
    procedure ConstruirControles; override;
  public
    function GetTitulo: string; override;
    function GetConsulta: IConsulta; override;
    function GetCamposDesabilitadosEdit: TCadLibTintasStringArray; override;
    function GetNomeCampo: string; override;
    function GetNomeTabela: string; override;
    procedure pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string); override;
    function fGetCampoChave(const index: Integer): string; override;
    function fGetCountCamposChave: Integer; override;
    function fValidaCampos(const tela: ITelaCadLibTintas;strNomeCampo: string; strValorCampo: string;var strRetorno: string): Boolean; override;
    procedure CarregarDescricoes(const tela: ITelaCadLibTintas); override;procedure FormatarCampo(const strNomeCampo: string;
      var arrPropriedades: TCadLibTintasStringArray;
      var arrValores: TCadLibTintasVariantArray); override;
    procedure AjustarTela(const tela: ITelaCadLibTintas); override;
    function GetTipoCadastro: TTipoCadastro; override;
    function GetTipoTinta: TTipoTinta; override;
    function GetNomeCampoRelacionamento: string; override;
    function fPodeAlterar: Boolean; override;
    function fPodeExcluir: Boolean; override;

    function fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean; override;


    function fRetCodSequencial : String;
    function fRetDesricaoBase(const tela: ITelaCadLibTintas) :String;

    function GetNomeCampoUnidade: string; override;

    function GetPreencherDbComboBox: Boolean; override;
    function GetDescDbComboBox: String; override;

    procedure IncluirDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure ExcluirDepois(const tela: ITelaCadLibTintas; const strState: string);override;
    procedure PesquisarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure PesquisarDepois(const tela: ITelaCadLibTintas; const strState: string); override;
    procedure GravarAntes(const tela: ITelaCadLibTintas; const strState: string); override;
    function GetNomeCampoItem: string; override;
    function fValidarProduto(strProduto : string) : Boolean;

  end;

implementation

uses
  untDbePesquisaItemKeyPress, untAutcomTintaFactory, untGenericLibTintaControleVisualLabel,
  untGenericLibTintaControleVisualDBEditFocus,
  untGenericLibTintaControleVisualEditFocus,
  untLibTintaControleVisualImplementacao, untDbeCodUniKeyPressMontana,
  untDbeBaseKeyPressMontana, untDbeProdutoKeyPressMontana;

{ TCadastroAcabamentosMontana }


procedure TCadastroAcabamentosMontana.AjustarTela(const tela: ITelaCadLibTintas);
begin
  inherited;
  tela.GetSelf['Width'].Value  := 525;
  tela['dbeCodigo']['Enabled'].Value := False;

end;

procedure TCadastroAcabamentosMontana.CarregarDescricoes(
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
end;

procedure TCadastroAcabamentosMontana.ConstruirControles;
begin
  // Código
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblCodigo', 'Código:', 32, 20, 36, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodigo', 72, 16, 97, 22, 'ttAlfanumerico', 'ACB_CODACB')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False)));

  // Descrição

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblDescricao', 'Descrição:', 16, 42, 52, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeDescricao', 72, 38, 409, 22, 'ttAlfanumerico', 'ACB_DESCRI')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '0')));

  // Produto
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblProduto',  'Produto:', 44,  64, 22, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeProduto', 72, 60, 409, 22, 'ttAlfanumerico', 'ACB_PRODUT')
  .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '1'))
  .AdicionarEvento(TDbeProdutoKeyPressMontana.Create('OnKeyPress', Self)));

  // Unidade

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblUnidade', 'Unidade:', 46, 86, 22, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeCodUni', 72, 82, 49, 22, 'ttAlfanumerico', 'ACB_UNIDAD')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '2'))
    .AdicionarEvento(TDbeCodUniKeyPressMontana.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesUni', 121, 82, 312, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtSigUni', 432, 82, 49, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  // Bases

  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblBases', 'Base:', 46, 108, 22, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeBase', 72, 104, 49, 22, 'ttAlfanumerico', 'ACB_CODBAS')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '3'))
    .AdicionarEvento(TDbeBaseKeyPressMontana.Create('OnKeyPress', Self)));

  AdicionarControle(TGenericLibTintaControleVisualEditFocus.Create('edtDesBase', 121, 104, 361, 22, 'ttAlfanumerico')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Enabled', false))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('CharCase', 'ecUpperCase'))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Color', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('NormalColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('FocusColor', 16768952))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabStop', False))
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('Requerido', False)));

  // Quantidade Embalagem
  AdicionarControle(TGenericLibTintaControleVisualLabel.Create('lblEmbalagem', 'Embalagem:', 28, 130, 41, 14, 'taRightJustify'));

  AdicionarControle(TGenericLibTintaControleVisualDBEditFocus.Create('dbeEmbalagem', 72, 126, 97, 22, 'ttAlfanumerico', 'ACB_QTDEMB')
    .AdicionarPropriedade(TGenericLibTintaControleVisualPropriedade.Create('TabOrder', '4')));
end;

procedure TCadastroAcabamentosMontana.ExcluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  tela['edtSigUni']['text'].Value  := '' ;
  tela['edtDesUni']['text'].Value  := '';
  tela['edtDesBase']['text'].Value := '';
end;

function TCadastroAcabamentosMontana.fGetCampoChave(const index: Integer): string;
const
  arrCampos: array[0..3] of string = ('ACB_DESCRI', 'ACB_CODBAS', 'ACB_UNIDAD', 'ACB_PRODUT');
begin
  Result := arrCampos[index];
end;

function TCadastroAcabamentosMontana.fGetCountCamposChave: Integer;
begin
  Result := 4;
end;

procedure TCadastroAcabamentosMontana.FormatarCampo(const strNomeCampo: string;
  var arrPropriedades: TCadLibTintasStringArray; var arrValores: TCadLibTintasVariantArray);
begin
  if MatchStr(strNomeCampo, ['ACB_QTDEMB']) then
  begin
    SetLength(arrPropriedades, 2);
    arrPropriedades[0] := 'DisplayFormat';
    arrPropriedades[1] := 'EditFormat';
    SetLength(arrValores, 2);
    arrValores[0] := '0.00';
    arrValores[1] := '0.00';
  end;
end;

function TCadastroAcabamentosMontana.fPodeAlterar: Boolean;
begin
  Result := True;
end;

function TCadastroAcabamentosMontana.fPodeExcluir: Boolean;
begin
  Result := True;

  If fVerificaBasesNovasFormulas Then
  Begin
 	  TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','Já existe Nova Fórmula cadastrada para esse acabamento, por isso não será possível excluí-lo.',['&OK']);
    Result := False;
  End;
end;

function TCadastroAcabamentosMontana.fPodeGravar(const tela: ITelaCadLibTintas; const strState: string): Boolean;
begin
  Result := True;
end;

function TCadastroAcabamentosMontana.fRetCodSequencial: String;
Var
  qryGen : IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '  SELECT LPAD(CAST(MAX(CAST(ACB_CODACB AS SIGNED)+ 1) AS CHAR),5,"0") AS CODIGO'+
                '    FROM  MON_CADACB ';
  qryGen.Open;

  Result := qryGen.FieldByName('CODIGO').AsString;
end;

function TCadastroAcabamentosMontana.fRetDesricaoBase(const tela: ITelaCadLibTintas): String;
Var
  qryGen : IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := '  SELECT BAS_DESCRI  '+
                '    FROM MON_CADBAS  '+
                '   WHERE BAS_CODBAS = :CODBAS'+
                '     AND BAS_UNIDAD = :UNIDAD'+
                '     AND BAS_PRODUT = :PRODUT';
  qryGen.ParamByName('CODBAS').AsString := tela['dbeBase']['text'].Value;
  qryGen.ParamByName('UNIDAD').AsString := tela['dbeCodUni']['text'].Value;
  qryGen.ParamByName('PRODUT').AsString := tela['dbeProduto']['text'].Value;
  qryGen.Open;

  Result := qryGen.FieldByName('BAS_DESCRI').AsString;
end;

function TCadastroAcabamentosMontana.fValidaCampos(const tela: ITelaCadLibTintas;
  strNomeCampo: string; strValorCampo: string; var strRetorno: string): Boolean;
begin
  Result := True;

  CarregarDescricoes(tela);

  If (strNomeCampo = 'ACB_CODACB') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O Código do acabamento deve ser preenchido!';
  End
  Else If (strNomeCampo = 'ACB_UNIDAD') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A Unidade deve ser preenchida!';

    if Result then
    begin
      Result := not TStrUtils.fEmptyStr(tela['edtDesUni']['Text'].Value);
      strRetorno := 'A embalagem selecionada não é válida!';
    end;
  End
  Else If (strNomeCampo = 'ACB_DESCRI') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A descrição deve ser preenchida!';
  End
  Else If (strNomeCampo = 'ACB_CODBAS') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'A base deve ser preenchida!';
  End
  Else If (strNomeCampo = 'ACB_PRODUT') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O produto deve ser preenchida!';

    If Result Then
    Begin
      Result     := fValidarProduto(tela['dbeProduto']['Text'].Value);
      strRetorno := 'O produto selecionado não é válido!';
    End;
  End
  Else If (strNomeCampo = 'ACB_QTDEMB') Then
  Begin
    Result := Not TStrUtils.fEmptyStr(strValorCampo);
    strRetorno := 'O quantidade da embalagem deve ser preenchida!';
  End

end;

function TCadastroAcabamentosMontana.fValidarProduto(strProduto: string): Boolean;
Var
  qryAux : IDataSet;
begin
  qryAux := TAutcomTintaFactory.Get.fGetDataSet;
  qryAux.SQL := 'SELECT 1 FIRST    '+
                '  FROM MON_CADBAS '+
                'WHERE BAS_PRODUT =:PRODUT '+
                'GROUP BY 1 ';
  qryAux.ParamByName('PRODUT').AsString := strProduto;
  qryAux.Open;

  Result := not(qryAux.IsEmpty);
end;

function TCadastroAcabamentosMontana.fVerificaBasesNovasFormulas: Boolean;
begin
  Result := TAutcomTintaFactory.Get.GetValorCampo(
    ' SELECT                     ' +
    '   COUNT(0) AS QTD          ' +
    ' FROM                       ' +
    '   MON_CADNFM               ' +
    ' WHERE NFM_CODACB = :CODACB ',
    'QTD', [GetQueryCadastro.FieldByName('ACB_CODACB').AsString]
  ) > 0;
end;

function TCadastroAcabamentosMontana.GetCamposDesabilitadosEdit: TCadLibTintasStringArray;
begin
  SetLength(Result, 0);
end;

function TCadastroAcabamentosMontana.GetConsulta: IConsulta;
begin
  Result := Nil;
end;

function TCadastroAcabamentosMontana.GetDescDbComboBox: String;
begin
  Result := '';
end;

function TCadastroAcabamentosMontana.GetNomeCampo: string;
begin
  Result := 'ACB_CODACB';
end;

function TCadastroAcabamentosMontana.GetNomeCampoItem: string;
begin
  Result := '';
end;

function TCadastroAcabamentosMontana.GetNomeCampoRelacionamento: string;
begin
  Result := '';
end;

function TCadastroAcabamentosMontana.GetNomeCampoUnidade: string;
begin
  Result := 'ACB_UNIDAD';
end;

function TCadastroAcabamentosMontana.GetNomeTabela: string;
begin
  Result := 'MON_CADACB';
end;

function TCadastroAcabamentosMontana.GetPreencherDbComboBox: Boolean;
begin
  Result := false;
end;

function TCadastroAcabamentosMontana.GetTipoCadastro: TTipoCadastro;
begin
  Result := ttAcabamentos;
end;

function TCadastroAcabamentosMontana.GetTipoTinta: TTipoTinta;
begin
  Result := ttImobiliaria;
end;

function TCadastroAcabamentosMontana.GetTitulo: string;
begin
  Result := 'Cadastro de Acabamentos';
end;

procedure TCadastroAcabamentosMontana.GravarAntes(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
end;

procedure TCadastroAcabamentosMontana.IncluirDepois(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['edtSigUni']['text'].Value  := '' ;
  tela['edtDesUni']['text'].Value  := '';
  tela['edtDesBase']['text'].Value := '';

  tela['dbeCodigo']['Enabled'].Value := False;
  tela['dbeCodigo']['text'].Value    := fRetCodSequencial;
end;

procedure TCadastroAcabamentosMontana.PesquisarAntes(const tela: ITelaCadLibTintas;
  const strState: string);
begin
  inherited;
  tela['edtSigUni']['text'].Value    := '' ;
  tela['edtDesUni']['text'].Value    := '';
  tela['edtDesBase']['text'].Value   := '';
  tela['dbeCodigo']['Enabled'].Value := False;
end;

procedure TCadastroAcabamentosMontana.PesquisarDepois(
  const tela: ITelaCadLibTintas; const strState: string);
begin
  inherited;
    tela['edtDesBase']['text'].Value := fRetDesricaoBase(tela);
end;

procedure TCadastroAcabamentosMontana.pSetaEnableReadOnly(const tela: ITelaCadLibTintas; const strState: string);
begin

end;

end.
