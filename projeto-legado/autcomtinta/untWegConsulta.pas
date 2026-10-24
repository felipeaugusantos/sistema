unit untWegConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TWegConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TWegConsulta }

constructor TWegConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'WEG';
  strCampoAutoincrem := 'WEG_CADWEG.AUTOINCREM';

  pAdicionarCampo('WEG_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('WEG_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('WEG_CODIG2', 'Código 2', 'LIKE');
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('WEG_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('WEG_NOMCOR', 'Nome da Cor', 'LIKE');
  pAdicionarCampo('WEG_SUBKEY', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('WEG_PROKEY', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('WEG_BASE__', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('WEG_FORM' + fStrZero(intCont, 2), 'WEG_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('WEG_QTDB' + fStrZero(intCont, 2), 'WEG_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TWegConsulta.Destroy;
begin
  inherited;
end;

function TWegConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + fGetSelectFrom;

end;

function TWegConsulta.fGetNomeTabela: String;
begin
  Result := 'WEG_CADWEG';
end;

function TWegConsulta.fGetNomeTinta: String;
begin
  Result := 'Weg';
end;

function TWegConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TWegConsulta.pGetSelectCxGrid(blnTodos: Boolean;
   Var arrSelect, arrNomCol: TArrString);
  Var
    intCont: Integer;
    strSql: String;
    stlNomCol: TStringList;
begin
  Inherited pGetSelectCxGrid(blnTodos, arrSelect, arrNomCol);

  stlNomCol := TStringList.Create;
  SetLength(arrSelect, 2);

  strSql := '';
  strSql := strSql + ' SELECT ' + fGetCampoAutoIncrem + ', ';

  stlNomCol.Add('AUTOINCREM');

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos Or (fGetdisponivel(intCont) And fGetVisivel(intCont)) Then
    Begin
      strSql := strSql + ' ' + fGetNomeCampoColuna(intCont) + ', ';
      stlNomCol.Add(fGetCaptionColuna(intCont));
    End;
  End;

  strSql := Copy(strSql, 1, LastDelimiter(',', strSql) - 1) + ' ';

  strSql := strSql + fGetSelectFrom;

  arrSelect[0] := strSql;

  strSql := '';
  strSql := strSql + ' WHERE TRUE ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
end;

function TWegConsulta.fGetSelectFrom: String;
begin
  Result := '';

  Result := Result + ' FROM WEG_CADWEG ';
  Result := Result + ' 	INNER JOIN WEG_CADBAS B ON WEG_PROKEY = BAS_PROKEY ';
  Result := Result + ' 		AND WEG_SUBKEY = BAS_SUBKEY ';
  Result := Result + ' 		AND WEG_BASE__ = BAS_BASE__ ';
  Result := Result + ' 		AND WEG_UNIDAD = BAS_UNIDAD  ';
  Result := Result + ' 	INNER JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
end;


procedure TWegConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('WEG_DESCRI', 0);
  fSetPos('WEG_CODIGO', 1);
  fSetPos('WEG_CODIG2', 2);
  fSetPos('BAS_DESCRI', 3);
  fSetPos('WEG_UNIDAD', 4);
  fSetPos('WEG_NOMCOR', 5);

  fSetVisivel('WEG_DESCRI', True);
  fSetVisivel('WEG_CODIGO', True);
  fSetVisivel('WEG_CODIG2', True);
  fSetVisivel('BAS_DESCRI', True);
  fSetVisivel('WEG_UNIDAD', True);
  fSetVisivel('WEG_NOMCOR', True);

  pAdicionarIndice('WEG_DESCRI', 'Descrição');
  pAdicionarIndice('WEG_CODIGO', 'Código');
  pAdicionarIndice('WEG_CODIG2', 'Código 2');
  pAdicionarIndice('WEG_NOMCOR', 'Nome da Cor');

  pLimparDescricao;

  pAdicionarCampoDescricao('WEG_DESCRI');
  pAdicionarCampoDescricao('WEG_CODIGO');
  pAdicionarCampoDescricao('WEG_CODIG2');
  pAdicionarCampoDescricao('BAS_DESCRI');
  pAdicionarCampoDescricao('WEG_UNIDAD');
  pAdicionarCampoDescricao('WEG_NOMCOR');
end;

end.
