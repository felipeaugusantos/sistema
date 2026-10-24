unit untAlessiImobiliariaConsulta;

interface

uses
  SysUtils, Classes,untTintadeMaquina;

Type
  TAlessiImobiliariaConsulta = class(TTintadeMaquina)
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

{ TSolBrazImobiliariaConsulta }

constructor TAlessiImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'ALE';
  strCampoAutoincrem := 'ALE_CADALE.AUTOINCREM';

  pAdicionarCampo('ALE_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('ALE_BASE__', 'Base', 'LIKE');
  pAdicionarCampo('EMB_CODUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('ALE_EMBALA', 'Embalagem', 'LIKE');
  pAdicionarCampo('ALE_NOMCOR', 'Nome Cor', 'LIKE');
  pAdicionarCampo('ALE_NOMLON', 'Nome Longo', 'LIKE');
  pAdicionarCampo('BAS_CODITE', 'Cód Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Item', 'LIKE');
  pAdicionarCampo('ALE_CODNFM', 'Codigo novas formulas', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Codigo do Item', 'LIKE', False, False);
  pAdicionarCampo('ALE_MD5KEY', 'Md5', '=', False, True);

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('ALE_CODC' + fStrZero(intCont, 2), 'ALE_CODC' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('ALE_QTOZ' + fStrZero(intCont, 2), 'ALE_QTOZ' + fStrZero(intCont, 2),
      '=', False, False);

    pAdicionarCampo('ALE_QSHO' + fStrZero(intCont, 2), 'ALE_QSHO' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

destructor TAlessiImobiliariaConsulta.Destroy;
begin
  inherited;
end;

function TAlessiImobiliariaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TAlessiImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'ALE_CADALE';
end;

function TAlessiImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Alessi Imobiliária';
end;

function TAlessiImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TAlessiImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TAlessiImobiliariaConsulta.fGetSelectFrom: String;
begin
  Result :=
    ' FROM                            ' +
    '   ALE_CADALE                    ' +
    '   INNER JOIN ALE_CADBAS         ' +
    '     ON ALE_PRODUT = BAS_PRODUT  ' +
    '     AND ALE_BASE__ = BAS_BASE__ ' +
    '     AND ALE_EMBALA = BAS_EMBALA ' +
    '   INNER JOIN CADITE             ' +
    '     ON BAS_CODITE = ITE_CODITE  ' +
    '   INNER JOIN ALE_CADEMB         ' +
    '     ON BAS_EMBALA = EMB_NOME__  ' +
    '   INNER JOIN CADUNI             ' +
    '     ON EMB_CODUNI = UNI_CODUNI  ';
end;

procedure TAlessiImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('ALE_PRODUT', 0);
  fSetPos('ALE_BASE__', 1);
  fSetPos('EMB_CODUNI', 2);
  fSetPos('ALE_NOMCOR', 3);
  fSetPos('ALE_NOMLON', 4);
  fSetPos('BAS_CODITE', 5);
  fSetPos('ITE_DESITE', 6);

  fSetVisivel('ALE_PRODUT', True);
  fSetVisivel('ALE_BASE__', True);
  fSetVisivel('EMB_CODUNI', True);
  fSetVisivel('ALE_NOMCOR', True);
  fSetVisivel('ALE_NOMLON', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);

  pAdicionarIndice('ALE_PRODUT+ALE_BASE__+EMB_CODUNI', 'Produto/Base/Unidade');
  pAdicionarIndice('ALE_PRODUT+ALE_NOMCOR+ALE_BASE__', 'Produto/Nome Cor/Base');

  pLimparDescricao;
  pAdicionarCampoDescricao('ALE_PRODUT');
  pAdicionarCampoDescricao('ALE_BASE__');
  pAdicionarCampoDescricao('EMB_CODUNI');
  pAdicionarCampoDescricao('ALE_NOMCOR');
  pAdicionarCampoDescricao('ALE_NOMLON');
  pAdicionarCampoDescricao('BAS_CODITE');
  pAdicionarCampoDescricao('ITE_DESITE');
end;

end.
