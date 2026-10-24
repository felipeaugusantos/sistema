unit untMazaAutomotivaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TMazaAutomotivaConsulta = class(TTintadeMaquina)
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

{ TMazaAutomotivaConsulta }

constructor TMazaAutomotivaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'MZA';
  strCampoAutoincrem := 'MZA_CADMZA.AUTOINCREM';

  pAdicionarCampo('MZA_CODIGO', 'Código da Cor', 'LIKE');
  pAdicionarCampo('MZA_VARIAC', 'Variação', 'LIKE');
  pAdicionarCampo('MZA_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  pAdicionarCampo('MZA_ANOCOR', 'Ano Cor', 'LIKE');
  pAdicionarCampo('MZA_OBSERV', 'Observação', 'LIKE');
  pAdicionarCampo('MZA_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('MZA_CODMON', 'Cód. Montadora', 'LIKE', False, False);
  pAdicionarCampo('MZA_CODNFM', 'Cód. Nfm', 'LIKE', False, False);
  pAdicionarCampo('MZA_DTAFOR', 'Data Formulação', 'LIKE', False, False);
  pAdicionarCampo('MZA_UNIVER', 'Cód. Universal', 'LIKE', False, False);
  pAdicionarCampo('MZA_PESCOR', 'Peso da cor', 'LIKE', False, False);
  pAdicionarCampo('MZA_PESFOR', 'Peso Formulação', 'LIKE', False, False);
  pAdicionarCampo('MZA_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  for intCont := 1 to 15 do
  begin
    pAdicionarCampo('MZA_FORM' + fStrZero(intCont, 2),  'MZA_FORM' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('MZA_QTDC' + fStrZero(intCont, 2),  'MZA_QTDC' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TMazaAutomotivaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TMazaAutomotivaConsulta.fGetNomeTabela: String;
begin
  Result := 'MZA_CADMZA';
end;

function TMazaAutomotivaConsulta.fGetNomeTinta: String;
begin
  Result := 'Maza Automotiva';
end;

function TMazaAutomotivaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TMazaAutomotivaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM MZA_CADMZA ';
  Result := Result + '   LEFT JOIN MZA_CADMON ';
  Result := Result + '     ON MZA_CODMON = MON_CODMON ';
end;

Procedure TMazaAutomotivaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

procedure TMazaAutomotivaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('MZA_CODIGO', 0);
  fSetPos('MZA_VARIAC', 1);
  fSetPos('MZA_DESCRI', 2);
  fSetPos('MON_DESCRI', 3);
  fSetPos('MZA_ANOCOR', 4);
  fSetPos('MZA_OBSERV', 5);
  fSetPos('MZA_LINHA_', 6);
  fSetPos('MZA_CODMON', 7);
  fSetPos('MZA_CODNFM', 8);

  fSetVisivel('MZA_CODIGO', True);
  fSetVisivel('MZA_VARIAC', True);
  fSetVisivel('MZA_DESCRI', True);
  fSetVisivel('MON_DESCRI', True);
  fSetVisivel('MZA_ANOCOR', True);
  fSetVisivel('MZA_OBSERV', True);
  fSetVisivel('MZA_LINHA_', True);
  fSetVisivel('MZA_CODMON', True);
  fSetVisivel('MZA_CODNFM', True);

  pAdicionarIndice('MZA_DESCRI', 'Descrição');
  pAdicionarIndice('MZA_CODIGO+MZA_VARIAC', 'Código da Cor/Variação');
  pAdicionarIndice('MON_DESCRI', 'Montadora');
  pAdicionarIndice('MZA_ANOCOR', 'Ano Cor');
  pAdicionarIndice('MZA_CODIGO', 'Código da Cor');

  pLimparDescricao;
  pAdicionarCampoDescricao('MZA_CODIGO');
  pAdicionarCampoDescricao('MZA_VARIAC');
  pAdicionarCampoDescricao('MZA_DESCRI');
  pAdicionarCampoDescricao('MON_DESCRI');
  pAdicionarCampoDescricao('MZA_ANOCOR');
  pAdicionarCampoDescricao('MZA_OBSERV');
  pAdicionarCampoDescricao('MZA_LINHA_');
  pAdicionarCampoDescricao('MZA_CODMON');
  pAdicionarCampoDescricao('MZA_CODNFM');

end;

end.
