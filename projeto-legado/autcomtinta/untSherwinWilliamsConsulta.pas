unit untSherwinWilliamsConsulta;

interface

uses
  untTintadeMaquina, SysUtils;

Type
  TSherwinWilliamsConsulta = class(TTintadeMaquina)
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
  End;

implementation

uses
  untFuncoesSimples;
{ TSherwinWilliamsConsulta }

constructor TSherwinWilliamsConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'SHE';
  strCampoAutoincrem := 'S.AUTOINCREM';

  pAdicionarCampo('SHE_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('SHE_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('SHE_CODIG2', 'Código 2', 'LIKE');
  pAdicionarCampo('SHE_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('SHE_BASE__', 'Base', 'LIKE');
  pAdicionarCampo('SHE_PROKEY', 'Prod. Key', 'LIKE');
  pAdicionarCampo('SHE_SUBKEY', 'Sub. Key', 'LIKE');
  pAdicionarCampo('BAS_BASE__', 'Base ', 'LIKE', False, False);
  pAdicionarCampo('BAS_PROKEY', 'Prod. Key ', 'LIKE', False, False);
  pAdicionarCampo('BAS_SUBKEY', 'Sub. Key ', 'LIKE', False, False);
  pAdicionarCampo('BAS_UNIDAD', 'Unidade ', 'LIKE', False, False);
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE', False, False);
  pAdicionarCampo('SHE_CODITE', 'Código do Item ', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('SHE_COMMEN', 'Observação', 'LIKE');

  For intCont := 1 to 20 Do
  Begin
    pAdicionarCampo('SHE_FORM' + fStrZero(intCont, 2), 'SHE_FORM' + fStrZero(intCont, 2), 'LIKE', False, False);
    pAdicionarCampo('SHE_QTDB' + fStrZero(intCont, 2), 'SHE_QTDB' + fStrZero(intCont, 2), '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TSherwinWilliamsConsulta.fGetCamposSelect(blnTodos: boolean): String;
var intCont: integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or(fGetDisponivel(intCont)) Then
       Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;

  Result := Result + ' S.AUTOINCREM, ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM SHE_CADSHE S ';
  Result := Result + '   INNER JOIN SHE_CADBAS B ';
  Result := Result + '     ON SHE_PROKEY = BAS_PROKEY ';
  Result := Result + '       AND SHE_SUBKEY = BAS_SUBKEY ';
  Result := Result + '       AND SHE_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND SHE_UNIDAD = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE I ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

function TSherwinWilliamsConsulta.fGetNomeTabela: String;
begin
  Result := 'SHE_CADSHE';
end;

function TSherwinWilliamsConsulta.fGetNomeTinta: String;
begin
  Result := 'Sherwin Williams';
end;

function TSherwinWilliamsConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos);
end;

procedure TSherwinWilliamsConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('SHE_DESCRI', 0);
  fSetPos('SHE_CODIGO', 1);
  fSetPos('SHE_CODIG2', 2);
  fSetPos('SHE_UNIDAD', 3);

  fSetVisivel('SHE_DESCRI', True);
  fSetVisivel('SHE_CODIGO', True);
  fSetVisivel('SHE_CODIG2', True);
  fSetVisivel('SHE_UNIDAD', True);

  pAdicionarIndice('SHE_DESCRI', 'Descrição');
  pAdicionarIndice('SHE_CODIGO', 'Código');
  pAdicionarIndice('SHE_CODIG2', 'Código 2');

  pLimparDescricao;
  pAdicionarCampoDescricao('SHE_CODIGO');
  pAdicionarCampoDescricao('BAS_DESCRI');
  pAdicionarCampoDescricao('SHE_UNIDAD');

end;

end.
