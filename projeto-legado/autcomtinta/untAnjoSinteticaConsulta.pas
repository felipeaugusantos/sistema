unit untAnjoSinteticaConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TAnjoSinteticaConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
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
  untFuncoesSimples ;

{ TAnjoSinteticaConsulta }

constructor TAnjoSinteticaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'AJA';
  strCampoAutoincrem := 'AJA_CADAJA.AUTOINCREM';

  pAdicionarCampo('AJA_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('AJA_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('AJA_CODIG2', 'Código 2', 'LIKE');
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('AJA_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('AJA_MD5KEY', 'MD5KEY', 'LIKE', False, True);
  pAdicionarCampo('AJA_SUBKEY', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('AJA_PROKEY', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('AJA_BASE__', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');  

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('AJA_FORM' + fStrZero(intCont, 2), 'AJA_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('AJA_QTDB' + fStrZero(intCont, 2), 'AJA_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

destructor TAnjoSinteticaConsulta.Destroy;
begin
  inherited;
end;

function TAnjoSinteticaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A;

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

function TAnjoSinteticaConsulta.fGetNomeTabela: String;
begin
  Result := 'AJA_CADAJA';
end;

function TAnjoSinteticaConsulta.fGetNomeTinta: String;
begin
  Result := 'Anjo Sintética';
end;

function TAnjoSinteticaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TAnjoSinteticaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TAnjoSinteticaConsulta.fGetSelectFrom: String;
begin
  Result := '';

  Result := Result + ' FROM AJA_CADAJA ';
  Result := Result + ' 	INNER JOIN AJA_CADBAS B ON AJA_PROKEY = BAS_PROKEY ';
  Result := Result + ' 		AND AJA_SUBKEY = BAS_SUBKEY ';
  Result := Result + ' 		AND AJA_BASE__ = BAS_BASE__ ';
  Result := Result + ' 		AND AJA_UNIDAD = BAS_UNIDAD  ';
  Result := Result + ' 	INNER JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';
end;


procedure TAnjoSinteticaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('AJA_DESCRI', 0);
  fSetPos('AJA_CODIGO', 1);
  fSetPos('AJA_CODIG2', 2);
  fSetPos('BAS_DESCRI', 3);
  fSetPos('AJA_UNIDAD', 4);

  fSetVisivel('AJA_DESCRI', True);
  fSetVisivel('AJA_CODIGO', True);
  fSetVisivel('AJA_CODIG2', True);
  fSetVisivel('BAS_DESCRI', True);
  fSetVisivel('AJA_UNIDAD', True);

  pAdicionarIndice('AJA_DESCRI', 'Descrição');
  pAdicionarIndice('AJA_CODIGO', 'Código');
  pAdicionarIndice('AJA_CODIG2', 'Código 2');

  pLimparDescricao;
  pAdicionarCampoDescricao('AJA_DESCRI');
  pAdicionarCampoDescricao('AJA_CODIGO');
  pAdicionarCampoDescricao('AJA_CODIG2');
  pAdicionarCampoDescricao('BAS_DESCRI');
  pAdicionarCampoDescricao('AJA_UNIDAD');
end;

end.

