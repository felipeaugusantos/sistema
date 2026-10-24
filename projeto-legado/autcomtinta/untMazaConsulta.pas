unit untMazaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TMazaConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blntodos: Boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TMazaConsulta }

constructor TMazaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'MAZ';
  strCampoAutoincrem := 'MAZ_CADMAZ.AUTOINCREM';

  pAdicionarCampo('MAZ_COLNUM', 'Código', 'LIKE');
  pAdicionarCampo('MAZ_COLNAM', 'Descrição', 'LIKE');
  pAdicionarCampo('MAZ_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('MAZ_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('MAZ_CODUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');

  for intCont := 1 to 10 do
  begin
    pAdicionarCampo('MAZ_CODC' + fStrZero(intCont, 2),  'MAZ_CODC' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('MAZ_QTDC' + fStrZero(intCont, 2),  'MAZ_QTDC' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TMazaConsulta.fGetCamposSelect(blntodos: Boolean): String;
  Var
    intCont: Integer;
begin
  Inherited fGetSelect(blnTodos);
  Result := '';
  Result := Result + ' SELECT ';

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + ', ';
  End;

  Result := Result + ' AUTOINCREM ,';

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + fGetSelectFrom;
end;

function TMazaConsulta.fGetNomeTabela: String;
begin
  Result := 'MAZ_CADMAZ';
end;

function TMazaConsulta.fGetNomeTinta: String;
begin
  Result := 'Maza';
end;

function TMazaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos);
end;

function TMazaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM MAZ_CADMAZ ';
  Result := Result + '   INNER JOIN MAZ_CADBAS ';
  Result := Result + '     ON BAS_CODBAS = MAZ_CODBAS ';
  Result := Result + '       AND MAZ_PRODUT = BAS_PRODUT ';
  Result := Result + '       AND MAZ_CODUNI = BAS_CODUNI ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

Procedure TMazaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

procedure TMazaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('MAZ_COLNUM', 0);
  fSetPos('MAZ_COLNAM', 1);
  fSetPos('MAZ_CODBAS', 2);
  fSetPos('MAZ_PRODUT', 3);
  fSetPos('MAZ_CODUNI', 4);

  fSetVisivel('MAZ_COLNUM', True);
  fSetVisivel('MAZ_COLNAM', True);
  fSetVisivel('MAZ_CODBAS', True);
  fSetVisivel('MAZ_PRODUT', True);
  fSetVisivel('MAZ_CODUNI', True);

  pAdicionarIndice('MAZ_COLNAM+MAZ_PRODUT+MAZ_CODUNI', 'Descrição/Produto/Unidade');
  pAdicionarIndice('MAZ_COLNUM+MAZ_CODBAS+MAZ_CODUNI', 'Código/Base/Unidade');
  pAdicionarIndice('MAZ_CODBAS+MAZ_PRODUT+MAZ_COLNAM', 'Base/Produto/Descrição');

  pLimparDescricao;
  pAdicionarCampoDescricao('MAZ_COLNUM');
  pAdicionarCampoDescricao('MAZ_COLNAM');
  pAdicionarCampoDescricao('MAZ_CODBAS');
  pAdicionarCampoDescricao('MAZ_PRODUT');
  pAdicionarCampoDescricao('MAZ_CODUNI');
end;


end.
