unit untPpgConsultaPaintManager;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TPpgConsultaPaintManager = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String;
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TPpgConsultaPaintManager }

constructor TPpgConsultaPaintManager.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'PPG';
  strCampoAutoincrem := 'PPG_CADPPGPM.AUTOINCREM';

  pAdicionarCampo('PPG_DESCOR', 'Descrição', 'LIKE');
  pAdicionarCampo('PPG_TIPO__', 'Tipo', 'LIKE');
  pAdicionarCampo('BAS_TIPO__', 'Produto', 'LIKE');
  pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  pAdicionarCampo('PPG_VEICUL', 'Modelos', 'LIKE');
  pAdicionarCampo('LEFT(LEFT(CONCAT(PPG_A_N_O_, " "), 9), 4)', 'Ano Inicial', 'LIKE');
  pAdicionarCampo('RIGHT(LEFT(CONCAT(PPG_A_N_O_, ""), 9), 4)', 'Ano Final', 'LIKE');
  pAdicionarCampo('PPG_CODCOR', 'Código', 'LIKE');
  pAdicionarCampo('PPG_CODATC', 'Código PPG', 'LIKE');
  pAdicionarCampo('PPG_MONTAD', 'Cód. Montadora', 'LIKE', False, False);
  pAdicionarCampo('PPG_A_N_O_', 'Ano', 'LIKE', False, False);
  pAdicionarCampo('PPG_VOLUME', 'Volume', 'LIKE', False, False);

  for intCont := 1 to 10 do
  begin
    pAdicionarCampo('PPG_CODB' + fStrZero(intCont, 2),  'PPG_CODB' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('PPG_QTDB' + fStrZero(intCont, 2),  'PPG_QTDB' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TPpgConsultaPaintManager.fGetNomeTabela: String;
begin
  Result := 'PPG_CADPPGPM';
end;

function TPpgConsultaPaintManager.fGetNomeTinta: String;
begin
  Result := 'Ppg';
end;

function TPpgConsultaPaintManager.fGetSelect(blnTodos: Boolean): String;
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
end;

function TPpgConsultaPaintManager.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM PPG_CADPPGPM  ';
  Result := Result + '   LEFT JOIN PPG_CADMON  ';
  Result := Result + '     ON PPG_MONTAD = MON_CODMON ';
  Result := Result + '   INNER JOIN PPG_CADBAS  ';
  Result := Result + '     ON PPG_CODB01 = BAS_CODBAS ';
end;

Procedure TPpgConsultaPaintManager.pGetSelectCxGrid(blnTodos: Boolean;
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

  strSql := strSql + fGetSelectFrom;
  
  arrSelect[0] := strSql;

  strSql := '';

  strSql := strSql + ' WHERE ';
  strSql := strSql + '   TRUE ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
End;

procedure TPpgConsultaPaintManager.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('PPG_DESCOR', 0);
  fSetPos('PPG_TIPO__', 1);
  fSetPos('BAS_TIPO__', 2);
  fSetPos('MON_DESCRI', 3);
  fSetPos('PPG_VEICUL', 4);
  fSetPos('LEFT(LEFT(CONCAT(PPG_A_N_O_, " "), 9), 4)', 5);
  fSetPos('RIGHT(LEFT(CONCAT(PPG_A_N_O_, ""), 9), 4)', 6);
  fSetPos('PPG_CODCOR, 9), 4)', 7);
  fSetPos('PPG_CODATC, 9), 4)', 8);

  fSetVisivel('PPG_DESCOR', True);
  fSetVisivel('PPG_TIPO__', True);
  fSetVisivel('BAS_TIPO__', True);
  fSetVisivel('MON_DESCRI', True);
  fSetVisivel('PPG_VEICUL', True);
  fSetVisivel('LEFT(LEFT(CONCAT(PPG_A_N_O_, " "), 9), 4)', True);
  fSetVisivel('RIGHT(LEFT(CONCAT(PPG_A_N_O_, ""), 9), 4)', True);
  fSetVisivel('PPG_CODCOR', True);
  fSetVisivel('PPG_CODATC', True);

  pAdicionarIndice('PPG_DESCOR+PPG_TIPO__', 'Descrição/Tipo');
  pAdicionarIndice('MON_DESCRI+PPG_CODCOR', 'Montadora/Código');
  pAdicionarIndice('MON_DESCRI+PPG_DESCOR', 'Montadora/Descrição');
  pAdicionarIndice('PPG_CODCOR', 'Código');
  pAdicionarIndice('PPG_CODATC', 'Código PPG');
  pAdicionarIndice('MON_DESCRI+PPG_VEICUL+LEFT(LEFT(CONCAT(PPG_A_N_O_, " "), 9), 4)', 'Montadora/Modelos/Ano Inicial');

  pLimparDescricao;
  pAdicionarCampoDescricao('PPG_DESCOR');
  pAdicionarCampoDescricao('PPG_TIPO__');
  pAdicionarCampoDescricao('BAS_TIPO__');
  pAdicionarCampoDescricao('MON_DESCRI');
  pAdicionarCampoDescricao('PPG_VEICUL');
  pAdicionarCampoDescricao('LEFT(LEFT(CONCAT(PPG_A_N_O_, " "), 9), 4)');
  pAdicionarCampoDescricao('RIGHT(LEFT(CONCAT(PPG_A_N_O_, ""), 9), 4)');
  pAdicionarCampoDescricao('PPG_CODCOR');
  pAdicionarCampoDescricao('PPG_CODATC');
end;

end.
