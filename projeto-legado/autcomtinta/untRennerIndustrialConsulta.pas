unit untRennerIndustrialConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TRennerIndustrialConsulta = class(TTintadeMaquina) 
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    function fGetWhere: String; override;
    
    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TRennerIndustrialConsulta }

constructor TRennerIndustrialConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'REN';
  strCampoAutoincrem := 'REN_CADREN.AUTOINCREM';

  pAdicionarCampo('REN_DESCRI', 'Descrição da Tinta', 'LIKE');
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('REN_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('REN_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('REN_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('REN_CODUNI', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('REN_CODEMB', 'Embalagem', 'LIKE');
  pAdicionarCampo('REN_IDENTI', 'Identificador', 'LIKE');
  pAdicionarCampo('BAS_COMPOB', 'Componente B', 'LIKE');
  pAdicionarCampo('BAS_CODITE', 'Cód. Item', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Cód. Item', 'LIKE', False, False);
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('REN_MD5KEY', 'MD5KEY', '=', False, True);

  For intCont := 1 To 10 Do
  Begin
    pAdicionarCampo('REN_FORM' + fStrZero(intCont, 2), 'REN_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('REN_QTDC' + fStrZero(intCont, 2), 'REN_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TRennerIndustrialConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + ' FROM REN_CADREN ';
  Result := Result + '   INNER JOIN REN_CADBAS ';
  Result := Result + '     ON REN_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND REN_CODUNI = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';

end;

function TRennerIndustrialConsulta.fGetNomeTabela: String;
begin
  Result := 'REN_CADREN';
end;

function TRennerIndustrialConsulta.fGetNomeTinta: String;
begin
  Result := 'Renner Industrial';
end;

function TRennerIndustrialConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TRennerIndustrialConsulta.fGetWhere: String;
begin
  Result := ' WHERE IFNULL(REN_ATIVAD, "S") = "S" ';
end;

Procedure TRennerIndustrialConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  strSql := strSql + ' FROM REN_CADREN ';
  strSql := strSql + '   INNER JOIN REN_CADBAS ';
  strSql := strSql + '     ON REN_CODBAS = BAS_BASE__ ';
  strSql := strSql + '       AND REN_CODUNI = BAS_UNIDAD ';
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

procedure TRennerIndustrialConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('BAS_DESCRI', 0);
  fSetPos('REN_UNIDAD', 1);
  fSetPos('REN_CODIGO', 2);
  fSetPos('BAS_CODITE', 3);
  fSetPos('ITE_DESITE', 4);

  fSetVisivel('BAS_DESCRI', True);
  fSetVisivel('REN_UNIDAD', True);
  fSetVisivel('REN_CODIGO', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);

  pAdicionarIndice('BAS_DESCRI+REN_UNIDAD', 'Descrição da Base/Unidade');
  pAdicionarIndice('REN_UNIDAD', 'Unidade');
  pAdicionarIndice('REN_CODIGO', 'Código');
  pAdicionarIndice('BAS_CODITE', 'Cód. Item');
  pAdicionarIndice('ITE_DESITE', 'Descrição do Item');

  pLimparDescricao;
  pAdicionarCampoDescricao('REN_UNIDAD');
end;

end.

