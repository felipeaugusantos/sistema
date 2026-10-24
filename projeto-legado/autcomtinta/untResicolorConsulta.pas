unit untResicolorConsulta;

interface

uses
  untTintadeMaquina, SysUtils;

Type
  TResicolorConsulta = class(TTintadeMaquina)
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
{ TResicolorConsulta }

constructor TResicolorConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'RSI';
  strCampoAutoincrem := 'S.AUTOINCREM';

  pAdicionarCampo('RSI_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('RSI_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('RSI_CODIG2', 'Código 2', 'LIKE');
  pAdicionarCampo('RSI_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('RSI_BASE__', 'Base', 'LIKE');
  pAdicionarCampo('RSI_PROKEY', 'Prod. Key', 'LIKE');
  pAdicionarCampo('RSI_SUBKEY', 'Sub. Key', 'LIKE');
  pAdicionarCampo('BAS_BASE__', 'Base ', 'LIKE', False, False);
  pAdicionarCampo('BAS_PROKEY', 'Prod. Key ', 'LIKE', False, False);
  pAdicionarCampo('BAS_SUBKEY', 'Sub. Key ', 'LIKE', False, False);
  pAdicionarCampo('BAS_UNIDAD', 'Unidade ', 'LIKE', False, False);
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE', False, False);
  pAdicionarCampo('RSI_CODITE', 'Código do Item ', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');

  For intCont := 1 to 20 Do
  Begin
    pAdicionarCampo('RSI_FORM' + fStrZero(intCont, 2), 'RSI_FORM' + fStrZero(intCont, 2), 'LIKE', False, False);
    pAdicionarCampo('RSI_QTDB' + fStrZero(intCont, 2), 'RSI_QTDB' + fStrZero(intCont, 2), '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TResicolorConsulta.fGetCamposSelect(blnTodos: boolean): String;
  var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;

  Result := Result + ' S.AUTOINCREM, ';

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM RSI_CADRSI S ';
  Result := Result + '   INNER JOIN RSI_CADBAS B ';
  Result := Result + '     ON RSI_PROKEY = BAS_PROKEY ';
  Result := Result + '       AND RSI_SUBKEY = BAS_SUBKEY ';
  Result := Result + '       AND RSI_BASE__ = BAS_BASE__ ';
  Result := Result + '       AND RSI_UNIDAD = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE I ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

function TResicolorConsulta.fGetNomeTabela: String;
begin
  Result := 'RSI_CADRSI';
end;

function TResicolorConsulta.fGetNomeTinta: String;
begin
  Result := 'Resicolor';
end;

function TResicolorConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

procedure TResicolorConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('RSI_DESCRI', 0);
  fSetPos('RSI_CODIGO', 1);
  fSetPos('RSI_CODIG2', 2);
  fSetPos('RSI_UNIDAD', 3);

  fSetVisivel('RSI_DESCRI', True);
  fSetVisivel('RSI_CODIGO', True);
  fSetVisivel('RSI_CODIG2', True);
  fSetVisivel('RSI_UNIDAD', True);

  pAdicionarIndice('RSI_DESCRI', 'Descrição');
  pAdicionarIndice('RSI_CODIGO', 'Código');
  pAdicionarIndice('RSI_CODIG2', 'Código 2');

  pLimparDescricao;
  pAdicionarCampoDescricao('RSI_CODIGO');
  pAdicionarCampoDescricao('BAS_DESCRI');
  pAdicionarCampoDescricao('RSI_UNIDAD');

end;

end.
