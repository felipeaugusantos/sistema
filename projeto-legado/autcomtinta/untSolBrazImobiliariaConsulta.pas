unit untSolBrazImobiliariaConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TSolBrazImobiliariaConsulta = class(TTintadeMaquina)
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
{ TSolBrazImobiliariaConsulta }

constructor TSolBrazImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'COL';
  strCampoAutoincrem := 'S.AUTOINCREM';

  pAdicionarCampo('SOL_CODBAS', 'Cód. Base', 'LIKE');
  pAdicionarCampo('SOL_DESBAS', 'Descrição Base', 'LIKE');
  pAdicionarCampo('SOL_CODCOR', 'Cor', 'LIKE');
  pAdicionarCampo('SOL_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('BAS_CODITE', 'Cód. Item', 'LIKE');
  pAdicionarCampo('SOL_MARCA_', 'Marca', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');

  For intCont := 1 To 6 Do
  Begin
    pAdicionarCampo('SOL_FORM' + fStrZero(intCont, 2), 'SOL_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('SOL_QTDB' + fStrZero(intCont, 2), 'SOL_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TSolBrazImobiliariaConsulta.Destroy;
begin
  inherited;
end;

function TSolBrazImobiliariaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TSolBrazImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'SOL_CADSOL';
end;

function TSolBrazImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Colorbraz Imobiliaria';
end;

function TSolBrazImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos);

end;

Procedure TSolBrazImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TSolBrazImobiliariaConsulta.fGetSelectFrom: String;
begin
  Result := '';

  Result := Result + ' FROM  ';
  Result := Result + ' 	SOL_CADSOL S ';
  Result := Result + ' 	INNER JOIN SOL_CADBAS B ON S.SOL_CODBAS = B.BAS_CODBAS ';
  Result := Result + ' 	AND S.SOL_DESBAS = B.BAS_DESCRI AND S.SOL_UNIDAD = B.BAS_CODUNI';
  Result := Result + ' 	INNER JOIN CADITE I ON B.BAS_CODITE = I.ITE_CODITE ';

end;


procedure TSolBrazImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('SOL_CODBAS', 0);
  fSetPos('SOL_DESBAS', 1);
  fSetPos('SOL_CODCOR', 2);
  fSetPos('SOL_UNIDAD', 3);
  fSetPos('BAS_CODITE', 4);
  fSetPos('ITE_DESITE', 5);

  fSetVisivel('SOL_CODBAS', True);
  fSetVisivel('SOL_DESBAS', True);
  fSetVisivel('SOL_CODCOR', True);
  fSetVisivel('SOL_UNIDAD', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);

  pAdicionarIndice('SOL_CODBAS+SOL_DESBAS+SOL_CODCOR', 'Cód. Base/Descrição Base/Cor');

  pLimparDescricao;
  pAdicionarCampoDescricao('SOL_CODBAS');
  pAdicionarCampoDescricao('SOL_DESBAS');
  pAdicionarCampoDescricao('SOL_CODCOR');
  pAdicionarCampoDescricao('SOL_UNIDAD');
  pAdicionarCampoDescricao('BAS_CODITE');
  pAdicionarCampoDescricao('ITE_DESITE');
end;


end.
