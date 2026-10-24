unit untZynamixConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TZynamixConsulta = class(TTintadeMaquina)
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;    
  End;

implementation


uses
  untFuncoesSimples;

{ TZynamixConsulta }

constructor TZynamixConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'ZYN';
  strCampoAutoincrem := 'ZYN_CADZYN.AUTOINCREM';

  pAdicionarCampo('ZYN_DESCOR', 'Descrição Cor', 'LIKE');
  pAdicionarCampo('ZYN_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('ZYN_VEICUL', 'Veículo', 'LIKE');
  pAdicionarCampo('ZYN_A_N_O_', 'Ano', 'LIKE');
  pAdicionarCampo('ZYN_TIPO__', 'Tipo', 'LIKE');
  pAdicionarCampo('ZYN_CODCOR', 'Cód. Cor', 'LIKE');

  for intCont := 1 to 10 do
  begin
    pAdicionarCampo('ZYN_CODB' + fStrZero(intCont, 2),  'ZYN_CODB' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('ZYN_QTDC' + fStrZero(intCont, 2),  'ZYN_QTDC' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TZynamixConsulta.fGetNomeTabela: String;
begin
  Result := 'ZYN_CADZYN';
end;

function TZynamixConsulta.fGetNomeTinta: String;
begin
  Result := 'Zynamix';
end;

function TZynamixConsulta.fGetSelect(blnTodos: Boolean): String;
  Var
    intCont: Integer;
begin
  Inherited fGetSelect(blnTodos);
  Result := '';
  Result := Result + ' SELECT ' + fGetCampoAutoIncrem + ', ';

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont) And fGetVisivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + ', ';
  End;

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM ';
  Result := Result + '   ZYN_CADZYN ';
  Result := Result + ' WHERE  ';
  Result := Result + '   TRUE ';
end;

Procedure TZynamixConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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
  strSql := strSql + '   ZYN_CADZYN ';

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

procedure TZynamixConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('ZYN_DESCOR', 0);
  fSetPos('ZYN_LINHA_', 1);
  fSetPos('ZYN_VEICUL', 2);
  fSetPos('ZYN_A_N_O_', 3);
  fSetPos('ZYN_TIPO__', 4);
  fSetPos('ZYN_CODCOR', 5);

  fSetVisivel('ZYN_DESCOR', True);
  fSetVisivel('ZYN_LINHA_', True);
  fSetVisivel('ZYN_VEICUL', True);
  fSetVisivel('ZYN_A_N_O_', True);
  fSetVisivel('ZYN_TIPO__', True);
  fSetVisivel('ZYN_CODCOR', True);

  pAdicionarIndice('ZYN_DESCOR', 'Descrição Cor');
  pAdicionarIndice('ZYN_DESCOR+ZYN_TIPO__', 'Descrição Cor/Tipo');
  pAdicionarIndice('ZYN_LINHA_+ZYN_CODCOR', 'Linha/Cód. Cor');
  pAdicionarIndice('ZYN_LINHA_+ZYN_DESCOR', 'Linha/Descrição Cor');
  pAdicionarIndice('ZYN_CODCOR', 'Cód. Cor');
  pAdicionarIndice('ZYN_VEICUL+ZYN_A_N_O_+ZYN_TIPO__', 'Veículo/Ano/Tipo');

  pLimparDescricao;
  pAdicionarCampoDescricao('ZYN_DESCOR');
  pAdicionarCampoDescricao('ZYN_LINHA_');
  pAdicionarCampoDescricao('ZYN_VEICUL');
  pAdicionarCampoDescricao('ZYN_A_N_O_');
  pAdicionarCampoDescricao('ZYN_TIPO__');
  pAdicionarCampoDescricao('ZYN_CODCOR');
end;


end.
