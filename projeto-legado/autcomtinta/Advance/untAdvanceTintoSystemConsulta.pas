unit untAdvanceTintoSystemConsulta;

interface

uses
  untTintadeMaquina, SysUtils;

Type
  TAdvanceTintoSystemConsulta = class(TTintadeMaquina)
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
  End;

implementation
uses  untFuncoesSimples;
{ TAdvanceIndustrialNovaConsulta }

constructor TAdvanceTintoSystemConsulta.Create;
var
  intCont: Integer;
begin
  inherited Create;
  strIdePro := 'ADT';
  strCampoAutoincrem := 'ADT_CADADT.AUTOINCREM';

  pAdicionarCampo('ADT_IDFORM', 'Fórmula', 'LIKE');
  pAdicionarCampo('ADT_CODCOR', 'Código Cor', 'LIKE');
  pAdicionarCampo('ADT_CODTEC', 'Código Técnico', 'LIKE');
  pAdicionarCampo('ADT_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('ADT_CODBAS', 'Código Base', 'LIKE');
  pAdicionarCampo('BAS_DESCRI', 'Descrição Base', 'LIKE', False, False);
  pAdicionarCampo('EMB_DESCRI', 'Embalagem', 'LIKE', False, False);
  pAdicionarCampo('UNI_CODUNI', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('ADT_CODEMB', 'Código Embalagem', '=', False, False);
  pAdicionarCampo('ADT_MD5KEY', 'MD5KEY', '=', False, True);

  pAdicionarCampo('ADT_IDFORM', 'Fórmula', 'LIKE');
  pAdicionarCampo('ADT_CODCOR', 'Código da Cor', 'LIKE');
  pAdicionarCampo('ADT_CODTEC', 'Código Técnico', 'LIKE');
  pAdicionarCampo('ADT_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('ADT_CODBAS', 'Código da Base', 'LIKE');
  pAdicionarCampo('ADT_CODEMB', 'Código da Embalagem', 'LIKE', False, False);
  pAdicionarCampo('ADT_CODCAT', 'Código do Catalisador', 'LIKE');
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('EMB_DESCRI', 'Embalagem', 'LIKE', False, False);
  pAdicionarCampo('UNI_CODUNI', 'Código da Unidade', 'LIKE', False, False);
  pAdicionarCampo('UNI_DESUNI', 'Descrição da Unidade', 'LIKE', False, False);
  pAdicionarCampo('UNI_SIGUNI', 'Sigla da Unidade', 'LIKE', False, False);

  pAdicionarCampo('ADT_QTDFIN', 'Volume Final', '=', False, False);
  pAdicionarCampo('ADT_QTDBAS', 'Volume da Base', '=', False, False);
  pAdicionarCampo('ADT_QTDCAT', 'Volume do Catalisador', '=', False, False);
  pAdicionarCampo('ADT_QTD_ML', 'Volume dos Colorantes', '=', False, False);

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('ADT_CODC' + fStrZero(intCont, 2), 'ADT_CODC' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('ADT_QTDC' + fStrZero(intCont, 2), 'ADT_QTDC' + fStrZero(intCont, 2), '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TAdvanceTintoSystemConsulta.fGetCamposSelect(blnTodos: Boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT '  + #$D#$A;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;
  Result := Result + fGetCampoAutoIncrem + ', ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';
  Result := Result +
    ' FROM                            ' +
    '   ADT_CADADT                    ' +
    '   INNER JOIN ADT_CADBAS         ' +
    '     ON ADT_CODBAS = BAS_CODBAS  ' +
    '     AND ADT_PRODUT = BAS_PRODUT ' +
    '     AND ADT_CODEMB = BAS_CODEMB ' +
    '   INNER JOIN ADT_CADEMB         ' +
    '     ON BAS_CODEMB = EMB_CODEMB  ' +
    '   INNER JOIN CADUNI             ' +
    '     ON EMB_CODUNI = UNI_CODUNI  ' +
    '   INNER JOIN CADITE             ' +
    '     ON BAS_CODITE = ITE_CODITE  ';
end;

function TAdvanceTintoSystemConsulta.fGetNomeTabela: String;
begin
  Result := 'ADT_CADADT';
end;

function TAdvanceTintoSystemConsulta.fGetNomeTinta: String;
begin
  Result := 'Advance TintoSystem';
end;

function TAdvanceTintoSystemConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

procedure TAdvanceTintoSystemConsulta.pRestaurarPadrao;
begin
  inherited pRestaurarPadrao;
  pLimparDescricao;
  fSetPos('ADT_IDFORM', 1);
  fSetPos('ADT_CODCOR', 2);
  fSetPos('ADT_CODTEC', 3);
  fSetPos('ADT_PRODUT', 4);
  fSetPos('ADT_CODBAS', 5);
  fSetPos('ADT_CODCAT', 6);

  fSetVisivel('ADT_IDFORM', True);
  fSetVisivel('ADT_CODCOR', True);
  fSetVisivel('ADT_CODTEC', True);
  fSetVisivel('ADT_PRODUT', True);
  fSetVisivel('ADT_CODBAS', True);
  fSetVisivel('ADT_CODCAT', True);

  pAdicionarIndice('ADT_PRODUT+ADT_CODCOR+ADT_CODTEC', 'Produto/Código Cor/Código Técnico');
  pAdicionarIndice('ADT_CODBAS+ADT_CODCAT', 'Código Base/Código do Catalisador');

  pAdicionarCampoDescricao('ADT_CODCOR');
  pAdicionarCampoDescricao('ADT_PRODUT');
  pAdicionarCampoDescricao('ADT_CODTEC');
  pAdicionarCampoDescricao('EMB_DESCRI');
end;

end.
