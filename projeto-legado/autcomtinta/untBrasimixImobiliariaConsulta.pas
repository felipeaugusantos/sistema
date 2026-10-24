unit untBrasimixImobiliariaConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TBrasimixImobiliariaConsulta = class(TTintadeMaquina)
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

constructor TBrasimixImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'BZI';
  strCampoAutoincrem := 'BZI_CADBZI.AUTOINCREM';

  pAdicionarCampo('BZI_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('BZI_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('BZI_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('BZI_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('BZI_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('BZI_CODBAS', 'Código da Base', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('BZI_CODUNI', 'Código da Unidade', 'LIKE', False, False);
  pAdicionarCampo('BZI_GRUPRO', 'Grupo do Produto', 'LIKE');

  For intCont := 1 To 10 Do
  Begin
    pAdicionarCampo('BZI_CODC' + fStrZero(intCont, 2), 'BZI_CODC' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('BZI_QTDC' + fStrZero(intCont, 2), 'BZI_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TBrasimixImobiliariaConsulta.Destroy;
begin
  inherited;
end;

function TBrasimixImobiliariaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TBrasimixImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'BZI_CADBZI';
end;

function TBrasimixImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Brasimix Imobiliaria';
end;

function TBrasimixImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TBrasimixImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

function TBrasimixImobiliariaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM BZI_CADBZI ';
  Result := Result + '   INNER JOIN BZI_CADBAS ON BAS_BASE__ = BZI_CODBAS ';
  Result := Result + '                        AND BAS_LINHA_ = BZI_LINHA_ ';
  Result := Result + '                        AND BAS_UNIDAD = BZI_CODUNI ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = BAS_CODITE     ';

end;

procedure TBrasimixImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('BZI_DESCRI', 0);
  fSetPos('BZI_REFERE', 1);
  fSetPos('BZI_CODIGO', 2);
  fSetPos('BZI_UNIDAD', 3);
  fSetPos('BZI_LINHA_', 4);
  fSetPos('BZI_CODBAS', 5);
  fSetPos('ITE_CODITE', 6);
  fSetPos('ITE_DESITE', 7);
  fSetPos('BZI_GRUPRO', 8);

  fSetVisivel('BZI_DESCRI', True);
  fSetVisivel('BZI_REFERE', True);
  fSetVisivel('BZI_CODIGO', True);
  fSetVisivel('BZI_UNIDAD', True);
  fSetVisivel('BZI_LINHA_', True);
  fSetVisivel('BZI_CODBAS', True);
  fSetVisivel('ITE_CODITE', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('BZI_GRUPRO', True);

  pAdicionarIndice('BZI_DESCRI+BZI_REFERE', 'Descrição/Referência');
  pAdicionarIndice('BZI_REFERE', 'Referência');
  pAdicionarIndice('BZI_CODIGO', 'Código');

  pLimparDescricao;
  pAdicionarCampoDescricao('BZI_DESCRI');
  pAdicionarCampoDescricao('BZI_REFERE');
  pAdicionarCampoDescricao('BZI_CODIGO');
  pAdicionarCampoDescricao('BZI_UNIDAD');
  pAdicionarCampoDescricao('BZI_LINHA_');
  pAdicionarCampoDescricao('BZI_CODBAS');
  pAdicionarCampoDescricao('ITE_CODITE');
  pAdicionarCampoDescricao('ITE_DESITE');
end;

end.
