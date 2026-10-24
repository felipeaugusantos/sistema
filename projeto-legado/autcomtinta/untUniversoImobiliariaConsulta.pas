unit untUniversoImobiliariaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TUniversoImobiliariaConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: boolean): String; override;

    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TUniversoImobiliariaConsulta }

constructor TUniversoImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'UNI';
  strCampoAutoincrem := 'UNI_CADUNI.AUTOINCREM';

  pAdicionarCampo('UNI_GRUPO_', 'Grupo', 'LIKE');
  pAdicionarCampo('UNI_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('UNI_CODTIN', 'Código', 'LIKE');
  pAdicionarCampo('UNI_DESCOR', 'Descrição', 'LIKE');
  pAdicionarCampo('UNI_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('UNI_CODUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');  

  for intCont := 1 to 10 do
  begin
    pAdicionarCampo('UNI_CODC' + fStrZero(intCont, 2),  'UNI_CODC' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('UNI_QTDC' + fStrZero(intCont, 2),  'UNI_QTDC' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;


function TUniversoImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'UNI_CADUNI';
end;

function TUniversoImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Universo';
end;

function TUniversoImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TUniversoImobiliariaConsulta.fGetCamposSelect(blnTodos: boolean): String;
  Var
    intCont: Integer;
begin
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


function TUniversoImobiliariaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM UNI_CADUNI ';
  Result := Result + '   INNER JOIN UNI_CADBAS ';
  Result := Result + '     ON UNI_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND UNI_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND UNI_CODUNI = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

Procedure TUniversoImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

procedure TUniversoImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('UNI_GRUPO_', 0);
  fSetPos('UNI_PRODUT', 1);
  fSetPos('UNI_CODTIN', 2);
  fSetPos('UNI_DESCOR', 3);
  fSetPos('UNI_CODBAS', 4);
  fSetPos('UNI_CODUNI', 5);

  fSetVisivel('UNI_GRUPO_', True);
  fSetVisivel('UNI_PRODUT', True);
  fSetVisivel('UNI_CODTIN', True);
  fSetVisivel('UNI_DESCOR', True);
  fSetVisivel('UNI_CODBAS', True);
  fSetVisivel('UNI_CODUNI', True);

  pAdicionarIndice('UNI_CODTIN+UNI_PRODUT+UNI_DESCOR', 'Código/Produto/Descrição');

  pLimparDescricao;
  pAdicionarCampoDescricao('UNI_GRUPO_');
  pAdicionarCampoDescricao('UNI_PRODUT');
  pAdicionarCampoDescricao('UNI_CODTIN');
  pAdicionarCampoDescricao('UNI_DESCOR');
  pAdicionarCampoDescricao('UNI_CODBAS');
  pAdicionarCampoDescricao('UNI_CODUNI');
end;

end.
