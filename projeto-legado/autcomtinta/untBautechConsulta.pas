unit untBautechConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TBautechConsulta = class(TTintadeMaquina)
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

{ TBautechConsulta }

constructor TBautechConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'BAU';
  strCampoAutoincrem := 'S.AUTOINCREM';

  pAdicionarCampo('S.BAU_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('S.BAU_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('S.BAU_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('S.BAU_CODFML', 'Fórmula', 'LIKE');
  pAdicionarCampo('S.BAU_CODBAS', 'Código da Base', 'LIKE');
  pAdicionarCampo('S.BAU_NOMCOR', 'Cor', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');

  pAdicionarCampo('S.BAU_CODUNI', 'BAU_CODUNI', 'LIKE', False, False);
  pAdicionarCampo('S.BAU_MD5KEY', 'BAU_MD5KEY', 'LIKE', False, False);

  For intCont := 1 To 15 Do
  Begin
    pAdicionarCampo('BAU_FORM' + fStrZero(intCont, 2), 'BAU_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('BAU_QTDB' + fStrZero(intCont, 2), 'BAU_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TBautechConsulta.Destroy;
begin
  inherited;
end;

function TBautechConsulta.fGetNomeTabela: String;
begin
  Result := 'BAU_CADBAU';
end;

function TBautechConsulta.fGetNomeTinta: String;
begin
  Result := 'Bautech';
end;

function TBautechConsulta.fGetSelect(blnTodos: Boolean): String;
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

  If fGetConfTinta('BAU').fGetBoolean('USAFOR') Then
    Result := Result + '     AND S.BAU_QTDB01 > 0.0 ';

   If Not fGetConfTinta('BAU').fGetBoolean('ANTIGO') Then
     Result := Result + '  AND S.BAU_REFERE NOT LIKE "%ANTIGO%" ';
end;

Procedure TBautechConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  If fGetConfTinta('BAU').fGetBoolean('USAFOR') Then
    strSql := strSql + '     AND S.BAU_QTDB01 > 0.0 ';

   If Not fGetConfTinta('BAU').fGetBoolean('ANTIGO') Then
     strSql := strSql + '  AND S.BAU_REFERE NOT LIKE "%ANTIGO%" ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
end;

function TBautechConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM BAU_CADBAU S ';
  Result := Result + '   INNER JOIN BAU_CADBAS B ';
  Result := Result + '     ON S.BAU_CODBAS = B.BAU_CODBAS ';
  Result := Result + '       AND S.BAU_CODFML = B.BAU_CODFML ';
  Result := Result + '       AND S.BAU_CODUNI = B.BAU_CODUNI ';
  Result := Result + '   INNER JOIN CADITE I ';

  If fEmptyStr(strCodIte) Then
    Result := Result + '     ON B.BAU_CODITE = I.ITE_CODITE '
  Else
    Result := Result + '     ON ' + AnsiQuotedStr(strCodIte, '"') + ' = I.ITE_CODITE '

end;


procedure TBautechConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('S.BAU_REFERE', 0);
  fSetPos('S.BAU_UNIDAD', 1);
  fSetPos('ITE_DESITE', 2);
  fSetPos('ITE_REFERE', 3);

  fSetVisivel('S.BAU_REFERE', True);
  fSetVisivel('S.BAU_UNIDAD', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('ITE_REFERE', True);

  pAdicionarIndice('S.BAU_DESCRI+S.BAU_REFERE+S.BAU_NOMCOR', 'Descrição/Referência/Cor');
  pAdicionarIndice('S.BAU_REFERE', 'Referência');
  pAdicionarIndice('ITE_DESITE', 'Descrição do Item');

  pLimparDescricao;
  pAdicionarCampoDescricao('S.BAU_REFERE');
  pAdicionarCampoDescricao('S.BAU_UNIDAD');
  pAdicionarCampoDescricao('ITE_DESITE');
  pAdicionarCampoDescricao('ITE_REFERE');

end;

end.
