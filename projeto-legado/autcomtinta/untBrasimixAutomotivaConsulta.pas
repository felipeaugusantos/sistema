unit untBrasimixAutomotivaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TBrasimixAutomotivaConsulta = class(TTintadeMaquina)
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

{ TMazaConsulta }

constructor TBrasimixAutomotivaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'BZA';
  strCampoAutoincrem := 'BZA_CADBZA.AUTOINCREM';

  pAdicionarCampo('BZA_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('BZA_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('BZA_CODUNI', 'Cód. Universal', 'LIKE');
  pAdicionarCampo('BZA_A_N_O_', 'Ano', 'LIKE');
  pAdicionarCampo('BZA_ARQTXT', 'Tipo', 'LIKE');
  pAdicionarCampo('BZA_CODSEQ', 'Cod. Seq', 'LIKE', False, False);
  pAdicionarCampo('BZA_MD5KEY', 'MD5KEY', '=', False, True);
  pAdicionarCampo('BZA_ACRMOB', 'Acréscimo Mão de Obra', 'LIKE', False, False);

  for intCont := 1 to 15 do
  begin
    pAdicionarCampo('BZA_CODB' + fStrZero(intCont, 2),  'BZA_CODB' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('BZA_QTDB' + fStrZero(intCont, 2),  'BZA_QTDB' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;


function TBrasimixAutomotivaConsulta.fGetNomeTabela: String;
begin
  Result := 'BZA_CADBZA';
end;

function TBrasimixAutomotivaConsulta.fGetNomeTinta: String;
begin
  Result := 'Brasimix Automotiva';
end;

function TBrasimixAutomotivaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TBrasimixAutomotivaConsulta.fGetCamposSelect(blnTodos: boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A;

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

function TBrasimixAutomotivaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM ';
  Result := Result + ' 	BZA_CADBZA ';
end;

Procedure TBrasimixAutomotivaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

procedure TBrasimixAutomotivaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('BZA_DESCRI', 0);
  fSetPos('BZA_MONTAD', 1);
  fSetPos('BZA_CODUNI', 2);
  fSetPos('BZA_A_N_O_', 3);
  fSetPos('BZA_ARQTXT', 4);

  fSetVisivel('BZA_DESCRI', True);
  fSetVisivel('BZA_MONTAD', True);
  fSetVisivel('BZA_CODUNI', True);
  fSetVisivel('BZA_A_N_O_', True);
  fSetVisivel('BZA_ARQTXT', True);

  pAdicionarIndice('BZA_DESCRI', 'Descrição');
  pAdicionarIndice('BZA_MONTAD', 'Montadora');
  pAdicionarIndice('BZA_A_N_O_', 'Ano');

  pLimparDescricao;
  pAdicionarCampoDescricao('BZA_DESCRI');
  pAdicionarCampoDescricao('BZA_MONTAD');
  pAdicionarCampoDescricao('BZA_CODUNI');
  pAdicionarCampoDescricao('BZA_A_N_O_');
  pAdicionarCampoDescricao('BZA_ARQTXT');
end;

end.
