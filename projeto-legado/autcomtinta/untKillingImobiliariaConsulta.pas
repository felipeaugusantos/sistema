unit untKillingImobiliariaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes, untIConfTinta, untTintaMaquina;

Type
  TKillingImobiliariaConsulta = class(TTintadeMaquina)
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

{ TKillingImobiliariaConsulta }

constructor TKillingImobiliariaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'KIL';
  strCampoAutoincrem := 'KILD_CADKIL.AUTOINCREM';

  pAdicionarCampo('KIL_CODCOR', 'Código', 'LIKE');
  pAdicionarCampo('KIL_NOMCOR', 'Nome da Cor', 'LIKE');
  pAdicionarCampo('KIL_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('KIL_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('KIL_CODBAS', 'Código Base', 'LIKE');
  pAdicionarCampo('KIL_CODUNI', 'Embalagem', 'LIKE');
  pAdicionarCampo('KIL_CODFML', 'Fórmula', 'LIKE');
  pAdicionarCampo('KIL_CODNFM', 'Fórmula', 'LIKE', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');  

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('KIL_FORM' + fStrZero(intCont, 2),  'KIL_FORM' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('KIL_QTDB' + fStrZero(intCont, 2),  'KIL_QTDB' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;


function TKillingImobiliariaConsulta.fGetNomeTabela: String;
begin
  Result := 'KILD_CADKIL';
end;

function TKillingImobiliariaConsulta.fGetNomeTinta: String;
begin
  Result := 'Killing';
end;

function TKillingImobiliariaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TKillingImobiliariaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A ;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + ', ';
  End;

  Result := Result + fGetCampoAutoIncrem + ', ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + fGetSelectFrom;
end;

function TKillingImobiliariaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM KILD_CADKIL ';
  Result := Result + '   INNER JOIN KILD_CADBAS ';
  Result := Result + '     ON KIL_CODFML = BAS_CODFML ';
  Result := Result + '       AND KIL_CODBAS = BAS_CODBAS ';
  Result := Result + '       AND KIL_CODUNI = BAS_CODUNI ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

Procedure TKillingImobiliariaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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
      strSql := strSql + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
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

procedure TKillingImobiliariaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('KIL_CODCOR', 0);
  fSetPos('KIL_DESCRI', 1);
  fSetPos('KIL_REFERE', 2);
  fSetPos('KIL_CODBAS', 3);
  fSetPos('KIL_CODUNI', 4);
  fSetPos('KIL_CODFML', 5);
  fSetPos('KIL_NOMCOR', 6);


  fSetVisivel('KIL_CODCOR', True);
  fSetVisivel('KIL_DESCRI', True);
  fSetVisivel('KIL_REFERE', True);
  fSetVisivel('KIL_CODBAS', True);
  fSetVisivel('KIL_CODUNI', True);
  fSetVisivel('KIL_CODFML', True);
  fSetVisivel('KIL_NOMCOR', True);

  pAdicionarIndice('KIL_CODCOR+KIL_DESCRI+KIL_REFERE', 'Código/Descrição/Referência');

  pLimparDescricao;
  pAdicionarCampoDescricao('KIL_CODCOR');
  pAdicionarCampoDescricao('KIL_DESCRI');
  pAdicionarCampoDescricao('KIL_REFERE');
  pAdicionarCampoDescricao('KIL_CODBAS');
  pAdicionarCampoDescricao('KIL_CODUNI');
  pAdicionarCampoDescricao('KIL_CODFML');
  pAdicionarCampoDescricao('KIL_NOMCOR');

end;

end.
