unit untCoralImobiliariaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TCoralImobiliariaConsulta = class(TTintadeMaquina)
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

{ TCoralImobiliariaConsulta }

constructor TCoralImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'CIM';
  strCampoAutoincrem := 'CORIMO_CADCOR.AUTOINCREM';

  pAdicionarCampo('COR_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('COR_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('COR_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('COR_COLID2', 'Color ID2', 'LIKE');
  pAdicionarCampo('COR_DESPRO', 'Produto', 'LIKE');
  pAdicionarCampo('COR_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('COR_UNIVER', 'Código Universal', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('COR_CODITE', 'Código do Item', 'LIKE', False, False);
  pAdicionarCampo('COR_CODUNI', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('COR_CODEMB', 'Embalagem', 'LIKE');
  pAdicionarCampo('COR_COLID1', 'Color ID', 'LIKE');
  pAdicionarCampo('COR_MD5KEY', 'MD5KEY', '=', False, False);

  For intCont := 1 To 10 Do
  Begin
    pAdicionarCampo('COR_FORM' + fStrZero(intCont, 2), 'COR_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('COR_QTDC' + fStrZero(intCont, 2), 'COR_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TCoralImobiliariaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
var IntCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ';

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or(fGetDisponivel(intCont)) Then
        Result := Result + ' ' + fGetNomeCampoColuna(intCont) + ', ';
  End;

  Result := Result + fGetCampoAutoIncrem + ', ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM CORIMO_CADCOR ';
  Result := Result + '   INNER JOIN CORIMO_CADBAS ';
  Result := Result + '     ON COR_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND COR_DESPRO = BAS_DESCRI ';
  Result := Result + '       AND COR_CODUNI = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

function TCoralImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'CORIMO_CADCOR';
end;

function TCoralImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Coral Imobiliária';
end;

function TCoralImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos);
end;

Procedure TCoralImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  strSql := strSql + ' FROM CORIMO_CADCOR ';
  strSql := strSql + '   INNER JOIN CORIMO_CADBAS ';
  strSql := strSql + '     ON COR_CODBAS = BAS_BASE__ ';
  strSql := strSql + '       AND COR_DESPRO = BAS_DESCRI ';
  strSql := strSql + '       AND COR_CODUNI = BAS_UNIDAD ';
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

procedure TCoralImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('COR_DESCRI', 0);
  fSetPos('COR_UNIDAD', 1);
  fSetPos('COR_CODIGO', 2);
  fSetPos('COR_COLID2', 3);
  fSetPos('COR_UNIVER', 4);
  fSetPos('BAS_CODITE', 5);
  fSetPos('ITE_DESITE', 6);

  fSetVisivel('COR_DESCRI', True);
  fSetVisivel('COR_UNIDAD', True);
  fSetVisivel('COR_CODIGO', True);
  fSetVisivel('COR_COLID2', True);
  fSetVisivel('COR_UNIVER', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);

  pAdicionarIndice('COR_DESCRI+COR_UNIDAD', 'Descrição/Unidade');
  pAdicionarIndice('COR_UNIDAD', 'Unidade');
  pAdicionarIndice('COR_CODIGO+COR_COLID2', 'Código/Color ID2');
  pAdicionarIndice('COR_UNIVER', 'Código Universal');

  pLimparDescricao;
  pAdicionarCampoDescricao('COR_UNIVER');
  pAdicionarCampoDescricao('COR_UNIDAD');
end;

end.

