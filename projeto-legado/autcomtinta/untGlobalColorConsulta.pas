unit untGlobalColorConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TGlobalColorConsulta = class(TTintadeMaquina) 
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

{ TGlobalColorConsulta }

constructor TGlobalColorConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'GLO';
  strCampoAutoincrem := 'GLO_CADGLO.AUTOINCREM';

  pAdicionarCampo('GLO_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('GLO_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('GLO_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('GLO_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('GLO_CODUNI', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('GLO_CODEMB', 'Embalagem', 'LIKE');
  pAdicionarCampo('GLO_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('CONCAT(CONVERT((FORMAT((EMB_QTDEMB / 1000),3)),CHAR), CONCAT(" ",GLO_UNIDAD))' , 'Desc.Embalagem', 'LIKE');

  pAdicionarCampo('ITE_CODITE', 'Código do Item','LIKE');
  pAdicionarCampo('ITE_DESITE', 'Desrição do Item','LIKE');
  pAdicionarCampo('GLO_MD5KEY', 'MD5KEY', '=', False, True);

  For intCont := 1 To 10 Do
  Begin
    pAdicionarCampo('GLO_FORM' + fStrZero(intCont, 2), 'GLO_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('GLO_QTDC' + fStrZero(intCont, 2), 'GLO_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TGlobalColorConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + ' FROM GLO_CADGLO ';
  Result := Result + '   INNER JOIN GLO_CADBAS ';
  Result := Result + '     ON GLO_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND GLO_CODUNI = BAS_UNIDAD ';
  Result := Result + '       AND GLO_PRODUT = BAS_DESCRI ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
  Result := Result + '  LEFT JOIN GLO_CADEMB ';
  Result := Result + '    ON GLO_CODEMB = EMB_CODEMB ';
end;

function TGlobalColorConsulta.fGetNomeTabela: String;
begin
  Result := 'GLO_CADGLO';
end;

function TGlobalColorConsulta.fGetNomeTinta: String;
begin
  Result := 'Global Color';
end;

function TGlobalColorConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TGlobalColorConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  strSql := strSql + ' FROM GLO_CADGLO ';
  strSql := strSql + '   INNER JOIN GLO_CADBAS ';
  strSql := strSql + '     ON GLO_CODBAS = BAS_BASE__ ';
  strSql := strSql + '       AND GLO_CODUNI = BAS_UNIDAD ';
  strSql := strSql + '       AND GLO_PRODUT = BAS_DESCRI ';
  strSql := strSql + '   INNER JOIN CADITE ';
  strSql := strSql + '     ON BAS_CODITE = ITE_CODITE ';
  strSql := strSql + '  LEFT JOIN GLO_CADEMB ';
  strSql := strSql + '    ON GLO_CODEMB = EMB_CODEMB ';

  arrSelect[0] := strSql;

  strSql := '';

  strSql := strSql + ' WHERE TRUE ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
End;

procedure TGlobalColorConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('GLO_DESCRI', 0);
  fSetPos('GLO_UNIDAD', 1);
  fSetPos('GLO_CODIGO', 2);
  fSetPos('BAS_CODITE', 3);
  fSetPos('GLO_PRODUT', 4);
  fSetPos('ITE_DESITE', 5);
  fSetPos('CONCAT(CONVERT((FORMAT((EMB_QTDEMB / 1000),3)),CHAR), CONCAT(" ",GLO_UNIDAD))', 6);

  fSetVisivel('GLO_DESCRI', True);
  fSetVisivel('GLO_UNIDAD', True);
  fSetVisivel('GLO_CODIGO', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('GLO_PRODUT', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('CONCAT(CONVERT((FORMAT((EMB_QTDEMB / 1000),3)),CHAR), CONCAT(" ",GLO_UNIDAD))', True);

  pAdicionarIndice('GLO_DESCRI+GLO_UNIDAD', 'Descrição/Unidade');
  pAdicionarIndice('GLO_UNIDAD', 'Unidade');
  pAdicionarIndice('GLO_CODIGO', 'Código');
  pAdicionarIndice('GLO_PRODUT', 'Produto');
  pAdicionarIndice('ITE_DESITE', 'Descrição do Item');
  pAdicionarIndice('CONCAT(CONVERT((FORMAT((EMB_QTDEMB / 1000),3)),CHAR), CONCAT(" ",GLO_UNIDAD))', 'Desc.Embalagem');

  pLimparDescricao;
  pAdicionarCampoDescricao('GLO_UNIDAD');
end;

end.

