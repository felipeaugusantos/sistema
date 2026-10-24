unit untAdvanceIndustrialConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TAdvanceIndustrialConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; Override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TAdvanceCorobIndustrialConsulta }

constructor TAdvanceIndustrialConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'ADN';
  strCampoAutoincrem := 'ADV_CADADV.AUTOINCREM';

  pAdicionarCampo('ADV_CARTA_', 'Carta', 'LIKE');
  pAdicionarCampo('ADV_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('ADV_FORMUL', 'Fórmula', 'LIKE');
  pAdicionarCampo('ADV_BASE01', 'Base 1', 'LIKE', False);
  pAdicionarCampo('ADV_BASE02', 'Base 2', 'LIKE', False, False);
  pAdicionarCampo('ADV_BASE03', 'Base 3', 'LIKE', False, False);
  pAdicionarCampo('ADV_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('BAS_DESCRI', 'Base', 'LIKE');
  pAdicionarCampo('ADV_CODNFM', 'Código Nova Fórmula', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');  
  pAdicionarCampo('ADV_MD5KEY', 'ADV_MD5KEY', 'LIKE', false, True);

  For intCont := 1 To 15 Do
  Begin
    pAdicionarCampo('ADV_CODC' + fStrZero(intCont, 2), 'ADV_CODC' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('ADV_QTDC' + fStrZero(intCont, 2), 'ADV_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TAdvanceIndustrialConsulta.Destroy;
begin
  inherited;
end;

function TAdvanceIndustrialConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + fGetSelectFrom;
end;

function TAdvanceIndustrialConsulta.fGetNomeTabela: String;
begin
  Result := 'ADV_CADADV';
end;

function TAdvanceIndustrialConsulta.fGetNomeTinta: String;
begin
  Result := 'Advance';
end;

function TAdvanceIndustrialConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TAdvanceIndustrialConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TAdvanceIndustrialConsulta.fGetSelectFrom: String;
begin
  Result :=
    ' FROM                              ' +
    '   ADV_CADADV                      ' +
    '   INNER JOIN ADV_CADBAS           ' +
    '     ON ADV_BASE01 = BAS_CODBAS    ' +
    '     AND ADV_UNIDAD = BAS_UNIDAD   ' +
    '   INNER JOIN CADITE               ' +
    '     ON BAS_CODITE = ITE_CODITE    ';
end;


procedure TAdvanceIndustrialConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('ADV_CARTA_', 0);
  fSetPos('ADV_PRODUT', 1);
  fSetPos('ADV_FORMUL', 2);
  fSetPos('BAS_DESCRI', 3);
  fSetPos('ADV_UNIDAD', 4);

  fSetVisivel('ADV_CARTA_', True);
  fSetVisivel('ADV_PRODUT', True);
  fSetVisivel('ADV_FORMUL', True);
  fSetVisivel('BAS_DESCRI', True);
  fSetVisivel('ADV_UNIDAD', True);

  pAdicionarIndice('ADV_CARTA_', 'Carta');
  pAdicionarIndice('ADV_PRODUT', 'Produto');
  pAdicionarIndice('ADV_FORMUL', 'Fórmula');

  pLimparDescricao;
  pAdicionarCampoDescricao('ADV_CARTA_');
  pAdicionarCampoDescricao('ADV_PRODUT');
  pAdicionarCampoDescricao('ADV_FORMUL');
  pAdicionarCampoDescricao('BAS_DESCRI');
  pAdicionarCampoDescricao('ADV_UNIDAD');
end;

end.
