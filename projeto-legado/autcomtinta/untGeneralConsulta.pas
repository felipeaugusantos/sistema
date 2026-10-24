unit untGeneralConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TGeneralConsulta = class(TTintadeMaquina)
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

{ TGeneralConsulta }

constructor TGeneralConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'GEN';
  strCampoAutoincrem := 'GEN_CADGEN.AUTOINCREM';

  pAdicionarCampo('GEN_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('GEN_VARIAC', 'Variação', 'LIKE');
  pAdicionarCampo('GEN_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  pAdicionarCampo('GEN_ANOINI', 'Ano Inicial', 'LIKE');
  pAdicionarCampo('GEN_ANOFIN', 'Ano Final', 'LIKE');
  pAdicionarCampo('GEN_NACION', 'Nascional', 'LIKE');
  pAdicionarCampo('GEN_CODCOR', 'Código Cor', 'LIKE');
  pAdicionarCampo('GEN_VERSAO', 'Versão', 'LIKE');
  pAdicionarCampo('GEN_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('GEN_OBSERV', 'Observação', 'LIKE');
  pAdicionarCampo('GEN_CODMON', 'Cód. Montadora', 'LIKE', False, False);
  pAdicionarCampo('GEN_CODNFM', 'Cód. Nfm', 'LIKE', False, False);


  for intCont := 1 to 15 do
  begin
    pAdicionarCampo('GEN_FORM' + fStrZero(intCont, 2),  'GEN_FORM' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('GEN_QTDC' + fStrZero(intCont, 2),  'GEN_QTDC' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TGeneralConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TGeneralConsulta.fGetNomeTabela: String;
begin
  Result := 'GEN_CADGEN';
end;

function TGeneralConsulta.fGetNomeTinta: String;
begin
  Result := 'General';
end;

function TGeneralConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TGeneralConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM GEN_CADGEN ';
  Result := Result + '   LEFT JOIN GEN_CADMON ';
  Result := Result + '     ON GEN_CODMON = MON_CODMON ';
end;

Procedure TGeneralConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

procedure TGeneralConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('GEN_CODIGO', 0);
  fSetPos('GEN_VARIAC', 1);
  fSetPos('GEN_DESCRI', 2);
  fSetPos('MON_DESCRI', 3);
  fSetPos('GEN_ANOINI', 4);
  fSetPos('GEN_ANOFIN', 5);
  fSetPos('GEN_NACION', 6);
  fSetPos('GEN_CODCOR', 7);
  fSetPos('GEN_VERSAO', 8);
  fSetPos('GEN_PRODUT', 9);
  fSetPos('GEN_OBSERV', 10);

  fSetVisivel('GEN_CODIGO', True);
  fSetVisivel('GEN_VARIAC', True);
  fSetVisivel('GEN_DESCRI', True);
  fSetVisivel('MON_DESCRI', True);
  fSetVisivel('GEN_ANOINI', True);
  fSetVisivel('GEN_ANOFIN', True);
  fSetVisivel('GEN_NACION', True);
  fSetVisivel('GEN_CODCOR', True);
  fSetVisivel('GEN_VERSAO', True);
  fSetVisivel('GEN_PRODUT', True);
  fSetVisivel('GEN_OBSERV', True);

  pAdicionarIndice('GEN_DESCRI', 'Descrição');
  pAdicionarIndice('GEN_CODIGO+GEN_VARIAC', 'Código/Variação');
  pAdicionarIndice('MON_DESCRI', 'Montadora');
  pAdicionarIndice('GEN_ANOINI+GEN_ANOFIN', 'Ano Inicial/Ano Final');
  pAdicionarIndice('GEN_CODCOR', 'Código Cor');
  pAdicionarIndice('GEN_PRODUT+GEN_DESCRI', 'Produto/Descrição');

  pLimparDescricao;
  pAdicionarCampoDescricao('GEN_CODIGO');
  pAdicionarCampoDescricao('GEN_VARIAC');
  pAdicionarCampoDescricao('GEN_DESCRI');
  pAdicionarCampoDescricao('MON_DESCRI');
  pAdicionarCampoDescricao('GEN_ANOINI');
  pAdicionarCampoDescricao('GEN_ANOFIN');
  pAdicionarCampoDescricao('GEN_NACION');
  pAdicionarCampoDescricao('GEN_CODCOR');
  pAdicionarCampoDescricao('GEN_VERSAO');
  pAdicionarCampoDescricao('GEN_PRODUT');
  pAdicionarCampoDescricao('GEN_OBSERV');

end;

end.
