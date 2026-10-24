unit untFuturaConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TFuturaConsulta = class(TTintadeMaquina)
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

{ TFuturaConsulta }

constructor TFuturaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'FUT';
  strCampoAutoincrem := 'FUT_CADFUT.AUTOINCREM';

  pAdicionarCampo('FUT_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('FUT_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('FUT_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('FUT_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('FUT_SPRODU', 'Sub Produto', 'LIKE');
  pAdicionarCampo('FUT_CODBAS', 'Código Base', 'LIKE');
  pAdicionarCampo('BAS_CODITE', 'Código Item', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');  

  For intCont := 1 To 15 Do
  Begin
    pAdicionarCampo('FUT_FORM' + fStrZero(intCont, 2), 'FUT_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('FUT_QTDB' + fStrZero(intCont, 2), 'FUT_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TFuturaConsulta.Destroy;
begin
  inherited;
end;

function TFuturaConsulta.fGetCamposSelect(blnTodos: boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ';

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + ', ';
  End;
  Result := Result + fGetCampoAutoIncrem + ', ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + fGetSelectFrom;
//Result := Result + ' WHERE TRUE ';

end;

function TFuturaConsulta.fGetNomeTabela: String;
begin
  Result := 'FUT_CADFUT';
end;

function TFuturaConsulta.fGetNomeTinta: String;
begin
  Result := 'Futura';
end;

function TFuturaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos);
end;

Procedure TFuturaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TFuturaConsulta.fGetSelectFrom: String;
begin
  Result := '';

  Result := Result + ' FROM FUT_CADFUT  ';
  Result := Result + '   INNER JOIN FUT_CADBAS  ';
  Result := Result + '     ON FUT_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND FUT_UNIDAD = BAS_CODUNI ';
  Result := Result + '       AND FUT_PRODUT = BAS_PRODUT ';
  Result := Result + '   INNER JOIN CADITE  ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;


procedure TFuturaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('FUT_DESCRI', 0);
  fSetPos('FUT_REFERE', 1);
  fSetPos('FUT_UNIDAD', 2);
  fSetPos('FUT_PRODUT', 3);
  fSetPos('FUT_SPRODU', 4);
  fSetPos('FUT_CODBAS', 5);
  fSetPos('BAS_CODITE', 6);
  fSetPos('ITE_DESITE', 7);

  fSetVisivel('FUT_DESCRI', True);
  fSetVisivel('FUT_REFERE', True);
  fSetVisivel('FUT_UNIDAD', True);
  fSetVisivel('FUT_PRODUT', True);
  fSetVisivel('FUT_SPRODU', True);
  fSetVisivel('FUT_CODBAS', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);

  pAdicionarIndice('FUT_DESCRI+FUT_REFERE+FUT_SPRODU', 'Descrição/Referência/Sub Produto');
  pAdicionarIndice('FUT_CODBAS+FUT_PRODUT+FUT_SPRODU', 'Código Base/Produto/Sub Produto');

  pLimparDescricao;
  pAdicionarCampoDescricao('FUT_DESCRI');
  pAdicionarCampoDescricao('FUT_REFERE');
  pAdicionarCampoDescricao('FUT_UNIDAD');
  pAdicionarCampoDescricao('FUT_PRODUT');
  pAdicionarCampoDescricao('FUT_SPRODU');
  pAdicionarCampoDescricao('FUT_CODBAS');
  pAdicionarCampoDescricao('BAS_CODITE');
  pAdicionarCampoDescricao('ITE_DESITE');
end;


end.
