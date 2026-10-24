unit untIquineConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TIquineConsulta = class(TTintadeMaquina) 
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    
    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TIquineConsulta }

constructor TIquineConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'IQU';
  strCampoAutoincrem := 'IQU_CADIQU.AUTOINCREM';

  pAdicionarCampo('IQU_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('IQU_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('IQU_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('IQU_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('IQU_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('IQU_CODUNI', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('IQU_CODEMB', 'Embalagem', 'LIKE');
  pAdicionarCampo('IQU_MD5KEY', 'MD5KEY', '=', False, True);
  pAdicionarCampo('ITE_CODITE', 'Codigo do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');

  For intCont := 1 To 10 Do
  Begin
    pAdicionarCampo('IQU_FORM' + fStrZero(intCont, 2), 'IQU_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('IQU_QTDC' + fStrZero(intCont, 2), 'IQU_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TIquineConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + ' FROM IQU_CADIQU ';
  Result := Result + '   INNER JOIN IQU_CADBAS ';
  Result := Result + '     ON IQU_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND IQU_CODUNI = BAS_UNIDAD ';
  Result := Result + '       AND IQU_PRODUT = BAS_PRODUT ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

function TIquineConsulta.fGetNomeTabela: String;
begin
  Result := 'IQU_CADIQU';
end;

function TIquineConsulta.fGetNomeTinta: String;
begin
  Result := 'Iquine';
end;

function TIquineConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TIquineConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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
    If blnTodos  Or (fGetdisponivel(intCont) And fGetVisivel(intCont)) Then
    Begin
      strSql := strSql + ' ' + fGetNomeCampoColuna(intCont) + ', ';
      stlNomCol.Add(fGetCaptionColuna(intCont));
    End;
  End;

  strSql := Copy(strSql, 1, LastDelimiter(',', strSql) - 1) + ' ';

  strSql := strSql + ' FROM IQU_CADIQU ';
  strSql := strSql + '   INNER JOIN IQU_CADBAS ';
  strSql := strSql + '     ON IQU_CODBAS = BAS_BASE__ ';
  strSql := strSql + '       AND IQU_CODUNI = BAS_UNIDAD ';
  strSql := strSql + '       AND IQU_PRODUT = BAS_PRODUT ';
  strSql := strSql + '   INNER JOIN CADITE ';
  strSql := strSql + '     ON BAS_CODITE = ITE_CODITE ';

  arrSelect[0] := strSql;

  strSql := '';

  strSql := strSql + ' WHERE TRUE ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
End;

procedure TIquineConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('IQU_DESCRI', 0);
  fSetPos('IQU_UNIDAD', 1);
  fSetPos('IQU_CODIGO', 2);
  fSetPos('BAS_CODITE', 3);
  fSetPos('ITE_DESITE', 4);

  fSetVisivel('IQU_DESCRI', True);
  fSetVisivel('IQU_UNIDAD', True);
  fSetVisivel('IQU_CODIGO', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);

  pAdicionarIndice('IQU_DESCRI+IQU_UNIDAD', 'Descrição/Unidade');
  pAdicionarIndice('IQU_UNIDAD', 'Unidade');
  pAdicionarIndice('IQU_CODIGO', 'Código');

  pLimparDescricao;
  pAdicionarCampoDescricao('IQU_UNIDAD');
end;

end.

