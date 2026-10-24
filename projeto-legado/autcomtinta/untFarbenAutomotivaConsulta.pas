unit untFarbenAutomotivaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TFarbenAutomotivaConsulta = class(TTintadeMaquina)
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

{ TFarbenAutomotivaConsulta }

constructor TFarbenAutomotivaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'FAR';
  strCampoAutoincrem := 'F.AUTOINCREM';

  pAdicionarCampo('F.FAR_CODNFM', 'Código', 'LIKE');
  pAdicionarCampo('F.FAR_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('M.FAR_DESMON', 'Montadora', 'LIKE');
  pAdicionarCampo('F.FAR_O_E_M_', 'Oem', 'LIKE');
  pAdicionarCampo('F.FAR_A_N_O_', 'Ano', 'LIKE');
  pAdicionarCampo('F.FAR_SETOR_', 'Setor', 'LIKE');
  pAdicionarCampo('F.FAR_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('F.FAR_CODEMP', 'Cod. Emp', 'LIKE');
  pAdicionarCampo('F.FAR_MONTAD', 'Cod. Montadora', 'LIKE', False, False);
  pAdicionarCampo('F.FAR_CODSEQ', 'Cod. Seq', 'LIKE', False, False);
  pAdicionarCampo('F.FAR_MD5KEY', 'MD5KEY', '=', False, True);
  pAdicionarCampo('F.FAR_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  pAdicionarCampo('F.FAR_TIPPRG', 'Programa', 'LIKE');
  pAdicionarCampo('F.FAR_OBSERV', 'Observação', 'LIKE');

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('FAR_CODB' + fStrZero(intCont, 2),  'FAR_CODB' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('FAR_QTDD' + fStrZero(intCont, 2),  'FAR_QTDD' + fStrZero(intCont, 2),
          '=', False, False);

    pAdicionarCampo('FAR_QTDC' + fStrZero(intCont, 2),  'FAR_QTDC' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;


function TFarbenAutomotivaConsulta.fGetNomeTabela: String;
begin
  Result := 'FAR_CADFAR';
end;

function TFarbenAutomotivaConsulta.fGetNomeTinta: String;
begin
  Result := 'Farben Automotiva';
end;

function TFarbenAutomotivaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TFarbenAutomotivaConsulta.fGetCamposSelect(blnTodos: boolean): String;
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


function TFarbenAutomotivaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM ';
  Result := Result + ' 	FAR_CADFAR F ';
  Result := Result + ' 	LEFT JOIN FAR_CADMON M ';
  Result := Result + ' 	ON (F.FAR_MONTAD = M.FAR_CODMON) ';
end;

Procedure TFarbenAutomotivaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

procedure TFarbenAutomotivaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('F.FAR_CODNFM', 0);
  fSetPos('F.FAR_DESCRI', 1);
  fSetPos('M.FAR_DESMON', 2);
  fSetPos('F.FAR_O_E_M_', 3);
  fSetPos('F.FAR_A_N_O_', 4);
  fSetPos('F.FAR_SETOR_', 5);
  fSetPos('F.FAR_LINHA_', 6);
  fSetPos('F.FAR_CODEMP', 7);

  fSetVisivel('F.FAR_CODNFM', True);
  fSetVisivel('F.FAR_DESCRI', True);
  fSetVisivel('M.FAR_DESMON', True);
  fSetVisivel('F.FAR_O_E_M_', True);
  fSetVisivel('F.FAR_A_N_O_', True);
  fSetVisivel('F.FAR_SETOR_', True);
  fSetVisivel('F.FAR_LINHA_', True);
  fSetVisivel('F.FAR_CODEMP', True);

  pAdicionarIndice('F.FAR_DESCRI', 'Descrição');
  pAdicionarIndice('F.FAR_CODNFM', 'Código');
  pAdicionarIndice('M.FAR_DESMON', 'Montadora');
  pAdicionarIndice('F.FAR_A_N_O_', 'Ano');

  pLimparDescricao;
  pAdicionarCampoDescricao('F.FAR_CODNFM');
  pAdicionarCampoDescricao('F.FAR_DESCRI');
  pAdicionarCampoDescricao('M.FAR_DESMON');  
  pAdicionarCampoDescricao('F.FAR_O_E_M_');
  pAdicionarCampoDescricao('F.FAR_A_N_O_');
  pAdicionarCampoDescricao('F.FAR_SETOR_');
  pAdicionarCampoDescricao('F.FAR_LINHA_');
  pAdicionarCampoDescricao('F.FAR_CODEMP');
end;

end.

