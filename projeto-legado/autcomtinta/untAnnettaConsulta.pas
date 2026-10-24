unit untAnnettaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TAnnettaConsulta = class(TTintadeMaquina) 
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

{ TAnnettaConsulta }

constructor TAnnettaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'ANN';
  strCampoAutoincrem := 'ANN_CADANN.AUTOINCREM';

  pAdicionarCampo('ANN_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('ANN_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('ANN_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('ANN_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('ANN_CODUNI', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('ANN_CODEMB', 'Embalagem', 'LIKE');
  pAdicionarCampo('ANN_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('ANN_MD5KEY', 'MD5KEY', '=', False, True);
  pAdicionarCampo('BAS_CODITE', 'Cód. Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');

  For intCont := 1 To 10 Do
  Begin
    pAdicionarCampo('ANN_FORM' + fStrZero(intCont, 2), 'ANN_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('ANN_QTDC' + fStrZero(intCont, 2), 'ANN_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TAnnettaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + ' FROM ANN_CADANN ';
  Result := Result + '   INNER JOIN ANN_CADBAS ';
  Result := Result + '     ON ANN_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND ANN_CODUNI = BAS_UNIDAD ';
  Result := Result + '       AND ANN_PRODUT = BAS_DESCRI ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

function TAnnettaConsulta.fGetNomeTabela: String;
begin
  Result := 'ANN_CADANN';
end;

function TAnnettaConsulta.fGetNomeTinta: String;
begin
  Result := 'Annetta';
end;

function TAnnettaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TAnnettaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  strSql := strSql + ' FROM ANN_CADANN ';
  strSql := strSql + '   INNER JOIN ANN_CADBAS ';
  strSql := strSql + '     ON ANN_CODBAS = BAS_BASE__ ';
  strSql := strSql + '       AND ANN_CODUNI = BAS_UNIDAD ';
  strSql := strSql + '       AND ANN_PRODUT = BAS_DESCRI ';
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

procedure TAnnettaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('ANN_DESCRI', 0);
  fSetPos('ANN_UNIDAD', 1);
  fSetPos('ANN_CODIGO', 2);
  fSetPos('BAS_CODITE', 3);
  fSetPos('ITE_DESITE', 4);
  fSetPos('ANN_PRODUT', 5);

  fSetVisivel('ANN_DESCRI', True);
  fSetVisivel('ANN_UNIDAD', True);
  fSetVisivel('ANN_CODIGO', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('ANN_PRODUT', True);

  pAdicionarIndice('ANN_DESCRI+ANN_UNIDAD', 'Descrição/Unidade');
  pAdicionarIndice('ANN_UNIDAD', 'Unidade');
  pAdicionarIndice('ANN_CODIGO', 'Código');
  pAdicionarIndice('ANN_PRODUT', 'Produto');

  pLimparDescricao;
  pAdicionarCampoDescricao('ANN_UNIDAD');
end;

end.

