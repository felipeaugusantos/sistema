unit untSuvinilConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TSuvinilConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;


implementation

uses
  untFuncoesSimples,  untTintaMaquina;

{ TSuvinilConsulta }

constructor TSuvinilConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'SUV';
  strCampoAutoincrem := 'S.AUTOINCREM';

  pAdicionarCampo('S.SUV_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('S.SUV_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('S.SUV_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('S.SUV_CODFML', 'Fórmula', 'LIKE');
  pAdicionarCampo('S.SUV_CODBAS', 'Código da Base', 'LIKE');
  pAdicionarCampo('S.SUV_NOMCOR', 'Cor', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');

  pAdicionarCampo('S.SUV_CODUNI', 'SUV_CODUNI', 'LIKE', False, False);
  pAdicionarCampo('S.SUV_MD5KEY', 'SUV_MD5KEY', 'LIKE', False, False);

  For intCont := 1 To 15 Do
  Begin
    pAdicionarCampo('SUV_FORM' + fStrZero(intCont, 2), 'SUV_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('SUV_QTDB' + fStrZero(intCont, 2), 'SUV_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TSuvinilConsulta.Destroy;
begin
  inherited;
end;

function TSuvinilConsulta.fGetNomeTabela: String;
begin
  Result := 'SUV_CADSUV';
end;

function TSuvinilConsulta.fGetNomeTinta: String;
begin
  Result := 'Suvinil';
end;

function TSuvinilConsulta.fGetSelect(blnTodos: Boolean): String;
  Var
    intCont: Integer;
begin
  Inherited fGetSelect(blnTodos);
  Result := '';
  Result := Result + ' SELECT ' + fGetCampoAutoIncrem + ', ';

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont) And fGetVisivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + ', ';
  End;

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + fGetSelectFrom;
  Result := Result + ' WHERE TRUE ';

  If fGetConfTinta('SUV').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.SUV_QTDB01 > 0.0 ';

   If Not fGetConfTinta('SUV').fGetBoolean('ANTIGO') Then
     Result := Result + '  AND S.SUV_REFERE NOT LIKE "%ANTIGO%" ';
end;

Procedure TSuvinilConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  If fGetConfTinta('SUV').fGetBoolean('USAFOR') Then
    strSql := strSql + '     AND S.SUV_QTDB01 > 0.0 ';

   If Not fGetConfTinta('SUV').fGetBoolean('ANTIGO') Then
     strSql := strSql + '  AND S.SUV_REFERE NOT LIKE "%ANTIGO%" ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
end;

function TSuvinilConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM SUV_CADSUV S ';
  Result := Result + '   INNER JOIN SUV_CADBAS B ';
  Result := Result + '     ON S.SUV_CODBAS = B.SUV_CODBAS ';
  Result := Result + '       AND S.SUV_CODFML = B.SUV_CODFML ';
  Result := Result + '       AND S.SUV_CODUNI = B.SUV_CODUNI ';
  Result := Result + '   INNER JOIN CADITE I ';

  If fEmptyStr(strCodIte) Then
    Result := Result + '     ON B.SUV_CODITE = I.ITE_CODITE '
  Else
    Result := Result + '     ON ' + AnsiQuotedStr(strCodIte, '"') + ' = I.ITE_CODITE '

end;


procedure TSuvinilConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('S.SUV_REFERE', 0);
  fSetPos('S.SUV_UNIDAD', 1);
  fSetPos('ITE_DESITE', 2);
  fSetPos('ITE_REFERE', 3);

  fSetVisivel('S.SUV_REFERE', True);
  fSetVisivel('S.SUV_UNIDAD', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('ITE_REFERE', True);

  pAdicionarIndice('S.SUV_DESCRI+S.SUV_REFERE+S.SUV_NOMCOR', 'Descrição/Referência/Cor');
  pAdicionarIndice('S.SUV_REFERE', 'Referência');
  pAdicionarIndice('ITE_DESITE', 'Descrição do Item');

  pLimparDescricao;
  pAdicionarCampoDescricao('S.SUV_REFERE');
  pAdicionarCampoDescricao('S.SUV_UNIDAD');
  pAdicionarCampoDescricao('ITE_DESITE');
  pAdicionarCampoDescricao('ITE_REFERE');

end;

end.
