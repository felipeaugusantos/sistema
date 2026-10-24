unit untAnjoConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TAnjoConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: boolean): String; override;

    destructor Destroy; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TAnjoConsulta }

constructor TAnjoConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'ANJ';
  strCampoAutoincrem := 'ANJ_CADANJ.AUTOINCREM';

  pAdicionarCampo('ANJ_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('ANJ_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('ANJ_CODIG2', 'Código 2', 'LIKE');
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('ANJ_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('ANJ_MD5KEY', 'MD5KEY', 'LIKE', False, True);
  pAdicionarCampo('ANJ_SUBKEY', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('ANJ_PROKEY', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('ANJ_BASE__', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');  

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('ANJ_FORM' + fStrZero(intCont, 2), 'ANJ_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('ANJ_QTDB' + fStrZero(intCont, 2), 'ANJ_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

destructor TAnjoConsulta.Destroy;
begin
  inherited;
end;

function TAnjoConsulta.fGetNomeTabela: String;
begin
  Result := 'ANJ_CADANJ';
end;

function TAnjoConsulta.fGetNomeTinta: String;
begin
  Result := 'Anjo';
end;

function TAnjoConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TAnjoConsulta.fGetCamposSelect(blnTodos: boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A ;

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

Procedure TAnjoConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TAnjoConsulta.fGetSelectFrom: String;
begin
  Result := '';

  Result := Result + ' FROM ANJ_CADANJ ';
  Result := Result + ' 	INNER JOIN ANJ_CADBAS B ON ANJ_PROKEY = BAS_PROKEY ';
  Result := Result + ' 		AND ANJ_SUBKEY = BAS_SUBKEY ';
  Result := Result + ' 		AND ANJ_BASE__ = BAS_BASE__ ';
  Result := Result + ' 		AND ANJ_UNIDAD = BAS_UNIDAD  ';
  Result := Result + ' 	INNER JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
end;


procedure TAnjoConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('ANJ_DESCRI', 0);
  fSetPos('ANJ_CODIGO', 1);
  fSetPos('ANJ_CODIG2', 2);
  fSetPos('BAS_DESCRI', 3);
  fSetPos('ANJ_UNIDAD', 4);

  fSetVisivel('ANJ_DESCRI', True);
  fSetVisivel('ANJ_CODIGO', True);
  fSetVisivel('ANJ_CODIG2', True);
  fSetVisivel('BAS_DESCRI', True);
  fSetVisivel('ANJ_UNIDAD', True);

  pAdicionarIndice('ANJ_DESCRI', 'Descrição');
  pAdicionarIndice('ANJ_CODIGO', 'Código');
  pAdicionarIndice('ANJ_CODIG2', 'Código 2');

  pLimparDescricao;
  pAdicionarCampoDescricao('ANJ_DESCRI');
  pAdicionarCampoDescricao('ANJ_CODIGO');
  pAdicionarCampoDescricao('ANJ_CODIG2');
  pAdicionarCampoDescricao('BAS_DESCRI');
  pAdicionarCampoDescricao('ANJ_UNIDAD');
end;

end.

