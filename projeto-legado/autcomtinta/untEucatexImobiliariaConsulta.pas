unit untEucatexImobiliariaConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TEucatexImobiliariaConsulta = class(TTintadeMaquina)
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
  untFuncoesSimples;

{ TEucatexImobiliariaConsulta }

constructor TEucatexImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'EUC';
  strCampoAutoincrem := 'EUC_CADEUC.AUTOINCREM';

  pAdicionarCampo('EUC_CODCOR', 'Cód. da Cor', 'LIKE');
  pAdicionarCampo('EUC_DESCOR', 'Cor', 'LIKE');
  pAdicionarCampo('EUC_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('EUC_DESBAS', 'Base', 'LIKE');
  pAdicionarCampo('EUC_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('BAS_CODITE', 'Cód Item', 'LIKE');
  pAdicionarCampo('EUC_CODNFM', 'Codigo novas formulas', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('EUC_OBSCOR', 'Observação Cor', 'LIKE');

  For intCont := 1 To 6 Do
  Begin
    pAdicionarCampo('EUC_FORM' + fStrZero(intCont, 2), 'EUC_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('EUC_QTDB' + fStrZero(intCont, 2), 'EUC_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TEucatexImobiliariaConsulta.Destroy;
begin
  inherited;
end;

function TEucatexImobiliariaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TEucatexImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'EUC_CADEUC';
end;

function TEucatexImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Eucatex Imobiliaria';
end;

function TEucatexImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TEucatexImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TEucatexImobiliariaConsulta.fGetSelectFrom: String;
begin
  Result := '';

  Result := Result + '  FROM   ';
  Result := Result + '  	EUC_CADEUC  ';
  Result := Result + '  	INNER JOIN EUC_CADBAS ON EUC_PRODUT = BAS_PRODUT  ';
  Result := Result + '  		AND EUC_DESBAS =  BAS_DESCRI AND EUC_UNIDAD = BAS_CODUNI ';
  Result := Result + '  	INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE  ';

end;

procedure TEucatexImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('EUC_CODCOR', 0);
  fSetPos('EUC_DESCOR', 1);
  fSetPos('EUC_PRODUT', 2);
  fSetPos('EUC_DESBAS', 3);
  fSetPos('EUC_UNIDAD', 4);
  fSetPos('BAS_CODITE', 5);
  fSetPos('ITE_DESITE', 6);
  fSetPos('EUC_OBSCOR', 7);

  fSetVisivel('EUC_CODCOR', True);
  fSetVisivel('EUC_DESCOR', True);
  fSetVisivel('EUC_PRODUT', True);
  fSetVisivel('EUC_DESBAS', True);
  fSetVisivel('EUC_UNIDAD', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('EUC_OBSCOR', True);

  pAdicionarIndice('EUC_CODCOR+EUC_DESCOR+EUC_PRODUT', 'Cód. da Cor/Cor/Produto');
  pAdicionarIndice('EUC_DESCOR+EUC_PRODUT+EUC_DESBAS+EUC_OBSCOR', 'Cor/Produto/Base/Observação Cor');

  pLimparDescricao;
  pAdicionarCampoDescricao('EUC_CODCOR');
  pAdicionarCampoDescricao('EUC_DESCOR');
  pAdicionarCampoDescricao('EUC_PRODUT');
  pAdicionarCampoDescricao('EUC_DESBAS');
  pAdicionarCampoDescricao('EUC_UNIDAD');
  pAdicionarCampoDescricao('BAS_CODITE');
  pAdicionarCampoDescricao('ITE_DESITE');
  pAdicionarCampoDescricao('EUC_OBSCOR');
end;

end.
