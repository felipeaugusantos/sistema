unit untRennerImobiliariaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TRennerImobiliariaConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TRennerImobiliariaConsulta }

constructor TRennerImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'REI';
  strCampoAutoincrem := 'REI_CADREI.AUTOINCREM';

  pAdicionarCampo('REI_CODPRO', 'Código do Produto', 'LIKE');
  pAdicionarCampo('REI_DESCOR', 'Descrição da Cor', 'LIKE');
  pAdicionarCampo('REI_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('REI_CODBAS', 'Código da Base', 'LIKE');
  pAdicionarCampo('REI_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('REI_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('REI_DTACAD', 'Data de Cadastro', 'DATE');
  pAdicionarCampo('REI_STAT__', 'Stat', 'LIKE');
  pAdicionarCampo('REI_STAT2_', 'Stat 2', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');

  for intCont := 1 to 10 do
  begin
    pAdicionarCampo('REI_FORM' + fStrZero(intCont, 2),  'REI_FORM' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('REI_QTDC' + fStrZero(intCont, 2),  'REI_QTDC' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TRennerImobiliariaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TRennerImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'REI_CADREI';
end;

function TRennerImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Renner Imobiliária';
end;

function TRennerImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TRennerImobiliariaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + 'FROM REI_CADREI ';
  Result := Result + ' INNER JOIN REI_CADBAS ON BAS_CODBAS = REI_CODBAS ';
  Result := Result + ' AND REI_UNIDAD = BAS_UNIDAD ';
  Result := Result + ' INNER JOIN CADITE ON BAS_CODITE = ITE_CODITE ';
end;

Procedure TRennerImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

procedure TRennerImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('REI_CODPRO', 0);
  fSetPos('REI_DESCOR', 1);
  fSetPos('REI_REFERE', 2);
  fSetPos('REI_CODBAS', 3);
  fSetPos('REI_DESCRI', 4);
  fSetPos('REI_UNIDAD', 5);
  fSetPos('REI_DTACAD', 6);
  fSetPos('REI_STAT__', 7);
  fSetPos('REI_STAT2_', 8);

  fSetVisivel('REI_CODPRO', True);
  fSetVisivel('REI_DESCOR', True);
  fSetVisivel('REI_REFERE', True);
  fSetVisivel('REI_CODBAS', True);
  fSetVisivel('REI_DESCRI', True);
  fSetVisivel('REI_UNIDAD', True);
  fSetVisivel('REI_DTACAD', True);
  fSetVisivel('REI_STAT__', True);
  fSetVisivel('REI_STAT2_', True);

  pAdicionarIndice('REI_CODPRO+REI_DESCOR+REI_REFERE', 'Código do Produto/Descrição da Cor/Referência');
  pAdicionarIndice('REI_CODBAS+REI_DESCRI', 'Código da Base/Descrição da Base');

  pLimparDescricao;
  pAdicionarCampoDescricao('REI_CODPRO');
  pAdicionarCampoDescricao('REI_DESCOR');
  pAdicionarCampoDescricao('REI_REFERE');
  pAdicionarCampoDescricao('REI_CODBAS');
  pAdicionarCampoDescricao('REI_DESCRI');
  pAdicionarCampoDescricao('REI_UNIDAD');
  pAdicionarCampoDescricao('REI_DTACAD');
  pAdicionarCampoDescricao('REI_STAT__');
  pAdicionarCampoDescricao('REI_STAT2_');

end;


end.
