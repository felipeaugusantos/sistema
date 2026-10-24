unit untAdvanceCorobIndustrialConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TAdvanceCorobIndustrialConsulta = class(TTintadeMaquina)
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

{ TAdvanceCorobIndustrialConsulta }

constructor TAdvanceCorobIndustrialConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'ADV';
  strCampoAutoincrem := 'ADVCOR_CADADV.AUTOINCREM';

  pAdicionarCampo('ADV_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('ADV_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('ADV_CODIG2', 'Código 2', 'LIKE');
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('ADV_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('ADV_PROKEY', 'Produto', 'LIKE', False, False);
  pAdicionarCampo('ADV_SUBKEY', 'Sub Produto', 'LIKE', False, False);
  pAdicionarCampo('ADV_BASE__', 'Base', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('ADV_MD5KEY', 'MD5KEY', '=', False, True);

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('ADV_FORM' + fStrZero(intCont, 2), 'ADV_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('ADV_QTDB' + fStrZero(intCont, 2), 'ADV_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TAdvanceCorobIndustrialConsulta.Destroy;
begin
  inherited;
end;

function TAdvanceCorobIndustrialConsulta.fGetCamposSelect(blnTodos: boolean): String;
  var
    intCont: integer;
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

function TAdvanceCorobIndustrialConsulta.fGetNomeTabela: String;
begin
  Result := 'ADVCOR_CADADV';
end;

function TAdvanceCorobIndustrialConsulta.fGetNomeTinta: String;
begin
  Result := 'Advance';
end;

function TAdvanceCorobIndustrialConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TAdvanceCorobIndustrialConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TAdvanceCorobIndustrialConsulta.fGetSelectFrom: String;
begin
  Result := '';

  Result := Result + ' FROM ADVCOR_CADADV ';
  Result := Result + ' 	INNER JOIN ADVCOR_CADBAS B ON ADV_PROKEY = BAS_PROKEY ';
  Result := Result + ' 		AND ADV_SUBKEY = BAS_SUBKEY ';
  Result := Result + ' 		AND ADV_BASE__ = BAS_BASE__ ';
  Result := Result + ' 		AND ADV_UNIDAD = BAS_UNIDAD  ';
  Result := Result + ' 	INNER JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
end;

procedure TAdvanceCorobIndustrialConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('ADV_DESCRI', 0);
  fSetPos('ADV_CODIGO', 1);
  fSetPos('ADV_CODIG2', 2);
  fSetPos('BAS_DESCRI', 3);
  fSetPos('ADV_UNIDAD', 4);

  fSetVisivel('ADV_DESCRI', True);
  fSetVisivel('ADV_CODIGO', True);
  fSetVisivel('ADV_CODIG2', True);
  fSetVisivel('BAS_DESCRI', True);
  fSetVisivel('ADV_UNIDAD', True);

  pAdicionarIndice('ADV_DESCRI', 'Descrição');
  pAdicionarIndice('ADV_CODIGO', 'Código');
  pAdicionarIndice('ADV_CODIG2', 'Código 2');

  pLimparDescricao;
  pAdicionarCampoDescricao('ADV_DESCRI');
  pAdicionarCampoDescricao('ADV_CODIGO');
  pAdicionarCampoDescricao('ADV_CODIG2');
  pAdicionarCampoDescricao('BAS_DESCRI');
  pAdicionarCampoDescricao('ADV_UNIDAD');
end;

end.
 