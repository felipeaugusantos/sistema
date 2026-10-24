unit untStarmixConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;
  
Type
  TStarmixConsulta = class(TTintadeMaquina) 
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: boolean): String; Override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    
    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation
  
uses
  untFuncoesSimples;

{ TStarmixConsulta }

constructor TStarmixConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'STA';
  strCampoAutoincrem := 'STA_CADSTA.AUTOINCREM';

  pAdicionarCampo('STA_NOMCOR', 'Descrição', 'LIKE');
  pAdicionarCampo('STA_CODLIN', 'Linha', 'LIKE');
  pAdicionarCampo('STA_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('STA_UNIVER', 'Cod. Universal', 'LIKE');
  pAdicionarCampo('STA_ANOCOR', 'Ano', 'LIKE');
  pAdicionarCampo('STA_CODMON', 'Código da montadora', 'LIKE', False, False);
  pAdicionarCampo('STA_UNIDAD', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('STA_PESCOR', 'Peso da cor', 'LIKE', False, False);
  pAdicionarCampo('STA_PESFOR', 'Peso do fornecedor', 'LIKE', False, False);
  pAdicionarCampo('STA_DESLIN', 'Descrição da linha', 'LIKE', False, False);
  pAdicionarCampo('STA_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  for intCont := 1 to 15 do
  begin
    pAdicionarCampo('STA_CODB' + fStrZero(intCont, 2),  'STA_CODB' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('STA_QTDB' + fStrZero(intCont, 2),  'STA_QTDB' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TStarmixConsulta.fGetCamposSelect(blnTodos: boolean): String;
  var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetDisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;
  Result := Result + ' AUTOINCREM, ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM ';
  Result := Result + '   STA_CADSTA ';
end;

function TStarmixConsulta.fGetNomeTabela: String;
begin
  Result := 'STA_CADSTA';
end;

function TStarmixConsulta.fGetNomeTinta: String;
begin
  Result := 'Starmix';
end;

function TStarmixConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TStarmixConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  strSql := strSql + ' FROM ';
  strSql := strSql + '   STA_CADSTA ';

  arrSelect[0] := strSql;

  strSql := '';

  strSql := strSql + ' WHERE ';
  strSql := strSql + '   AUTOINCREM > 0 ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
End;

procedure TStarmixConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('STA_NOMCOR', 0);
  fSetPos('STA_CODLIN', 1);
  fSetPos('STA_MONTAD', 2);
  fSetPos('STA_UNIVER', 3);
//  fSetPos('STA_ANOCOR', 4);

  fSetVisivel('STA_NOMCOR', True);
  fSetVisivel('STA_CODLIN', True);
  fSetVisivel('STA_MONTAD', True);
  fSetVisivel('STA_UNIVER', True);
//  fSetVisivel('STA_ANOCOR', True);

  pAdicionarIndice('STA_NOMCOR', 'Descrição');
  pAdicionarIndice('STA_CODLIN', 'Linha');
  pAdicionarIndice('STA_MONTAD', 'Montadora');
  pAdicionarIndice('STA_UNIVER', 'Cod. Universal');
//  pAdicionarIndice('STA_ANOCOR', 'Ano');

  pLimparDescricao;
  pAdicionarCampoDescricao('STA_NOMCOR');
  pAdicionarCampoDescricao('STA_CODLIN');
  pAdicionarCampoDescricao('STA_MONTAD');
  pAdicionarCampoDescricao('STA_UNIVER');
end;


end.
