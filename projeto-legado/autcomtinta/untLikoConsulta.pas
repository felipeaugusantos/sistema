unit untLikoConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TLikoConsulta = class(TTintadeMaquina) 
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

{ TLikoConsulta }

constructor TLikoConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'LIK';
  strCampoAutoincrem := 'LIK_CADLIK.AUTOINCREM';

  pAdicionarCampo('LIK_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('LIK_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('LIK_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('LIK_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('LIK_CODUNI', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('LIK_CODEMB', 'Embalagem', 'LIKE');
  pAdicionarCampo('LIK_MD5KEY', 'MD5KEY', '=', False, True);

  For intCont := 1 To 10 Do
  Begin
    pAdicionarCampo('LIK_FORM' + fStrZero(intCont, 2), 'LIK_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('LIK_QTDC' + fStrZero(intCont, 2), 'LIK_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TLikoConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + ' FROM LIK_CADLIK ';
  Result := Result + '   INNER JOIN LIK_CADBAS ';
  Result := Result + '     ON LIK_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND LIK_CODUNI = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

function TLikoConsulta.fGetNomeTabela: String;
begin
  Result := 'LIK_CADLIK';
end;

function TLikoConsulta.fGetNomeTinta: String;
begin
  Result := 'Liko';
end;

function TLikoConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TLikoConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  strSql := strSql + ' FROM LIK_CADLIK ';
  strSql := strSql + '   INNER JOIN LIK_CADBAS ';
  strSql := strSql + '     ON LIK_CODBAS = BAS_BASE__ ';
  strSql := strSql + '       AND LIK_CODUNI = BAS_UNIDAD ';
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

procedure TLikoConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('LIK_DESCRI', 0);
  fSetPos('LIK_UNIDAD', 1);
  fSetPos('LIK_CODIGO', 2);
  fSetPos('BAS_CODITE', 3);
  fSetPos('ITE_DESITE', 4);

  fSetVisivel('LIK_DESCRI', True);
  fSetVisivel('LIK_UNIDAD', True);
  fSetVisivel('LIK_CODIGO', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);

  pAdicionarIndice('LIK_DESCRI+LIK_UNIDAD', 'Descrição/Unidade');
  pAdicionarIndice('LIK_UNIDAD', 'Unidade');
  pAdicionarIndice('LIK_CODIGO', 'Código');

  pLimparDescricao;
  pAdicionarCampoDescricao('LIK_UNIDAD');
end;

end.

