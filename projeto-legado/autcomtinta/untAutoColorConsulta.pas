unit untAutoColorConsulta;

interface

uses
  untTintadeMaquina, SysUtils, Classes;

Type
  TAutoColorConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;


implementation

uses
  untFuncoesSimples;

{ TAutoColorConsulta }

constructor TAutoColorConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'AUT';
  strCampoAutoincrem := 'AUT_CADAUT.AUTOINCREM';

  pAdicionarCampo('AUT_DESCRI', 'Descricao', 'LIKE');
  pAdicionarCampo('AUT_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('AUT_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('AUT_REFERE', 'Referencia', 'LIKE');
  pAdicionarCampo('AUT_MIXSCH', 'Sistema', 'LIKE');
  pAdicionarCampo('AUT_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('AUT_ANOINI', 'Ano Inicial', 'LIKE');
  pAdicionarCampo('AUT_ANOFIN', 'Ano Final', 'LIKE');
  pAdicionarCampo('AUT_CODSEQ', 'Sequência', 'LIKE', False, False);
  pAdicionarCampo('AUT_VARIAN', 'Variante', 'LIKE', False, False);

  for intCont := 1 to 10 do
  begin
    pAdicionarCampo('AUT_CODB' + fStrZero(intCont, 2),  'AUT_CODB' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('AUT_QTDC' + fStrZero(intCont, 2),  'AUT_QTDC' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TAutoColorConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TAutoColorConsulta.fGetNomeTabela: String;
begin
  Result := 'AUT_CADAUT';
end;

function TAutoColorConsulta.fGetNomeTinta: String;
begin
  Result := 'Autocolor';
end;

function TAutoColorConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos);
end;

function TAutoColorConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + 'FROM ';
  Result := Result + '  AUT_CADAUT ';
end;

Procedure TAutoColorConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

procedure TAutoColorConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('AUT_DESCRI', 0);
  fSetPos('AUT_CODIGO', 1);
  fSetPos('AUT_MONTAD', 2);
  fSetPos('AUT_REFERE', 3);
  fSetPos('AUT_MIXSCH', 4);
  fSetPos('AUT_LINHA_', 5);
  fSetPos('AUT_ANOINI', 6);
  fSetPos('AUT_ANOFIN', 7);

  fSetVisivel('AUT_DESCRI', True);
  fSetVisivel('AUT_CODIGO', True);
  fSetVisivel('AUT_MONTAD', True);
  fSetVisivel('AUT_REFERE', True);
  fSetVisivel('AUT_MIXSCH', True);
  fSetVisivel('AUT_LINHA_', True);
  fSetVisivel('AUT_ANOINI', True);
  fSetVisivel('AUT_ANOFIN', True);

  pAdicionarIndice('AUT_DESCRI+AUT_MONTAD', 'Descricao/Montadora');
  pAdicionarIndice('AUT_REFERE', 'Referencia');
  pAdicionarIndice('AUT_MIXSCH', 'Sistema');
  pAdicionarIndice('AUT_CODIGO', 'Código');
  pAdicionarIndice('AUT_MONTAD', 'Montadora');

  pLimparDescricao;
  pAdicionarCampoDescricao('AUT_DESCRI');
  pAdicionarCampoDescricao('AUT_CODIGO');
  pAdicionarCampoDescricao('AUT_MONTAD');
  pAdicionarCampoDescricao('AUT_REFERE');
  pAdicionarCampoDescricao('AUT_MIXSCH');
  pAdicionarCampoDescricao('AUT_LINHA_');
  pAdicionarCampoDescricao('AUT_ANOINI');
  pAdicionarCampoDescricao('AUT_ANOFIN');
end;



end.
