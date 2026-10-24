unit untMazaImobiliariaConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes, Dialogs;

Type
  TMazaImobiliariaConsulta = class(TTintadeMaquina)
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

{ TMazaImobiliariaConsulta }

constructor TMazaImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'MZI';
  strCampoAutoincrem := 'MZI_CADMZI.AUTOINCREM';
  pAdicionarCampo('MZI_COLNAM', 'Descrição', 'LIKE');
  pAdicionarCampo('MZI_COLNUM', 'Referência', 'LIKE');
  pAdicionarCampo('MZI_CODUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('MZI_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('MZI_CODBAS', 'Código Base', 'LIKE');
  pAdicionarCampo('BAS_CODITE', 'Código Item', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('MZI_CODMZI', 'Código', 'LIKE');
  pAdicionarCampo('MZI_CODEMP', 'Empresa', 'LIKE');

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('MZI_CODC' + fStrZero(intCont, 2), 'MZI_CODC' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('MZI_QTDC' + fStrZero(intCont, 2), 'MZI_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TMazaImobiliariaConsulta.Destroy;
begin
  inherited;
end;

function TMazaImobiliariaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + fGetSelectFrom;
end;

function TMazaImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'MZI_CADMZI';
end;

function TMazaImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Maza Imobiliária';
end;

function TMazaImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TMazaImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TMazaImobiliariaConsulta.fGetSelectFrom: String;
begin
  Result := '';

  Result := Result + ' FROM MZI_CADMZI  ';
  Result := Result + '   INNER JOIN MZI_CADBAS  ';
  Result := Result + '     ON MZI_CODBAS    = BAS_CODBAS ';
  Result := Result + '       AND MZI_CODUNI = BAS_CODUNI ';
  Result := Result + '       AND MZI_PRODUT = BAS_PRODUT ';
  Result := Result + '   INNER JOIN CADITE  ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;


procedure TMazaImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('MZI_COLNAM', 0);
  fSetPos('MZI_COLNUM', 1);
  fSetPos('MZI_CODUNI', 2);
  fSetPos('MZI_PRODUT', 3);
  fSetPos('MZI_CODBAS', 4);
  fSetPos('BAS_CODITE', 5);
  fSetPos('ITE_DESITE', 6);
  fSetPos('MZI_CODMZI', 7);
  fSetPos('MZI_CODEMP', 8);



  fSetVisivel('MZI_COLNAM', True);
  fSetVisivel('MZI_COLNUM', True);
  fSetVisivel('MZI_CODUNI', True);
  fSetVisivel('MZI_PRODUT', True);
  fSetVisivel('MZI_CODBAS', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('MZI_CODMZI', True);
  fSetVisivel('MZI_CODEMP', True);

  pAdicionarIndice('MZI_COLNAM+MZI_COLNUM', 'Descrição/Referência');
  pAdicionarIndice('MZI_CODBAS+MZI_PRODUT', 'Código Base/Produto');

  pLimparDescricao;
  pAdicionarCampoDescricao('MZI_COLNAM');
  pAdicionarCampoDescricao('MZI_COLNUM');
  pAdicionarCampoDescricao('MZI_CODUNI');
  pAdicionarCampoDescricao('MZI_PRODUT');
  pAdicionarCampoDescricao('MZI_CODBAS');
  pAdicionarCampoDescricao('BAS_CODITE');
  pAdicionarCampoDescricao('ITE_DESITE');
  pAdicionarCampoDescricao('MZI_CODMZI');
  pAdicionarCampoDescricao('MZI_CODEMP');

end;


end.
