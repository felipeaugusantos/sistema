unit untWandaProConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes,
  StrUtils;

Type
  TWandaProConsulta = class(TTintadeMaquina)
  private

  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: boolean): String; Override;
    function fGetWhere: String; Override;
    function fGetGroup: String; Override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;

    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples,untTintaMaquina;

{ TWandaProConsulta }

constructor TWandaProConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro          := 'WCP';
  strCampoAutoincrem := 'WANPRO_CADWAN.AUTOINCREM';

  if strLinhaWandaPro = '' then
    strLinhaWandaPro := fGetConfTinta(strIdePro).fGet('LINWAN');

  pAdicionarCampo('WAN_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('WAN_NOMLIN', 'Descrição da Linha', 'LIKE');
  pAdicionarCampo('WAN_CODAKZ', 'Codigo', 'LIKE');
  pAdicionarCampo('WAN_DESCRI', 'Descricao', 'LIKE');
  pAdicionarCampo('WAN_ALTERN', 'Variação', 'LIKE');
  pAdicionarCampo('WAN_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('WAN_CAMADA', 'Camada', 'LIKE');
  pAdicionarCampo('WAN_ANOINI', 'Ano Inicial', 'LIKE');
  pAdicionarCampo('WAN_ANOFIN', 'Ano Final', 'LIKE');
  //Sempre quando não for uma campo normal ex : WAN_ANOFIN, criar um apelido seguindo o padrao ex : AS WAN_CODUNI
  pAdicionarCampo('CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS WANPRO_CODUNI', 'Cód. Universal', 'LIKE');
  pAdicionarCampo('WAN_CODSEQ', 'Sequência', 'LIKE', False, False);
  pAdicionarCampo('WAN_MD5KEY', 'WAN_MD5KEY', 'LIKE', False, True);
  pAdicionarCampo('WAN_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  pAdicionarCampo('WAN_VERCOR', 'Versão', 'LIKE');

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('WAN_LINC' + fStrZero(intCont, 2),  'WAN_LINC' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('WAN_CODC' + fStrZero(intCont, 2),  'WAN_CODC' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('WAN_QCON' + fStrZero(intCont, 2),  'WAN_QCON' + fStrZero(intCont, 2),
          '=', False, False);

    pAdicionarCampo('WAN_QD21' + fStrZero(intCont, 2),  'WAN_QD21' + fStrZero(intCont, 2),
          '=', False, False);

    pAdicionarCampo('WAN_QD41' + fStrZero(intCont, 2),  'WAN_QD41' + fStrZero(intCont, 2),
          '=', False, False);

    pAdicionarCampo('WAN_PORC' + fStrZero(intCont, 2),  'WAN_PORC' + fStrZero(intCont, 2),
          '=', False, False);          
  end;

  pAbrirTabelaConfs();
end;

function TWandaProConsulta.fGetNomeTabela: String;
begin
  Result := 'WANPRO_CADWAN';
end;

function TWandaProConsulta.fGetNomeTinta: String;
begin
  Result := 'Color Pro';
end;

function TWandaProConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere + fGetGroup;
end;

function TWandaProConsulta.fGetCamposSelect(blnTodos: boolean): String;
  Var
    intCont: Integer;
Begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A ;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;

  Result := Result + 'AUTOINCREM, ';

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM ';
  Result := Result + '   WANPRO_CADWAN ';

  Result := Result + '   LEFT JOIN WANPRO_CODUNI ON WANPRO_CODAKZ = WAN_CODAKZ AND ';
  Result := Result + '                              WANPRO_ALTERN = WAN_ALTERN AND ';
  Result := Result + '                              WANPRO_VERCOR = WAN_VERCOR     ';
End;

function TWandaProConsulta.fGetWhere: String;
Begin
  Result := Result + ' WHERE ';
  Result := Result + '  WAN_LINHA_ = ' + QuotedStr(AnsiReplaceStr(Trim(LeftStr(strLinhaWandaPro, 3)),'0','')) + ' ';
End;

function TWandaProConsulta.fGetGroup: String;
begin
  Result := Result + ' GROUP BY ';
  Result := Result + '   WAN_CODAKZ, WAN_ALTERN, WAN_CAMADA, WAN_VERCOR ';

End;

Procedure TWandaProConsulta.pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString);
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
    If blnTodos  Or (fGetdisponivel(intCont)) Then
    Begin
      strSql := strSql + ' ' + fGetNomeCampoColuna(intCont) + ', ';
      stlNomCol.Add(fGetCaptionColuna(intCont));
    End;
  End;

  strSql := Copy(strSql, 1, LastDelimiter(',', strSql) - 1) + ' ';

  strSql := strSql + ' FROM ';
  strSql := strSql + '   WANPRO_CADWAN ';

  strSql := strSql + '   LEFT JOIN WANPRO_CODUNI ON WANPRO_CODAKZ = WAN_CODAKZ AND ';
  strSql := strSql + '                              WANPRO_ALTERN = WAN_ALTERN AND ';
  strSql := strSql + '                              WANPRO_VERCOR = WAN_VERCOR     ';

  arrSelect[0] := strSql;

  strSql := '';

  strSql := strSql + ' WHERE ';

  strSql := strSql + '  WAN_LINHA_ = ' + QuotedStr(AnsiReplaceStr(Trim(LeftStr(strLinhaWandaPro, 3)),'0','')) + ' ';

  arrSelect[1] := strSql;

  strSql := strSql  + '     GROUP BY ';
  strSql := strSql  + '         WAN_CODAKZ, WAN_ALTERN, WAN_CAMADA, WAN_VERCOR ';

  arrSelect[2] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
End;

procedure TWandaProConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('WAN_LINHA_', 0);
  fSetPos('WAN_NOMLIN', 1);
  fSetPos('WAN_CODAKZ', 2);
  fSetPos('WAN_DESCRI', 3);
  fSetPos('WAN_ALTERN', 4);
  fSetPos('WAN_MONTAD', 5);
  fSetPos('WAN_CAMADA', 6);
  fSetPos('WAN_ANOINI', 7);
  fSetPos('WAN_ANOFIN', 8);
  fSetPos('CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS WANPRO_CODUNI', 8);

  fSetVisivel('WAN_LINHA_', True);
  fSetVisivel('WAN_NOMLIN', True);
  fSetVisivel('WAN_CODAKZ', True);
  fSetVisivel('WAN_DESCRI', True);
  fSetVisivel('WAN_ALTERN', True);
  fSetVisivel('WAN_MONTAD', True);
  fSetVisivel('WAN_CAMADA', True);
  fSetVisivel('WAN_ANOINI', True);
  fSetVisivel('WAN_ANOFIN', True);
  fSetVisivel('CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS WANPRO_CODUNI', True);

  pAdicionarIndice('WAN_DESCRI', 'Descricao');
  pAdicionarIndice('WAN_CODAKZ', 'Codigo');
  pAdicionarIndice('CODUNI', 'Cód. Universal');

  pLimparDescricao;
  pAdicionarCampoDescricao('WAN_DESCRI');
  pAdicionarCampoDescricao('WAN_CODAKZ');
  pAdicionarCampoDescricao('CAST(GROUP_CONCAT(DISTINCT WANPRO_CODUNI SEPARATOR ", ") AS CHAR(80)) AS WANPRO_CODUNI');
end;

end.
