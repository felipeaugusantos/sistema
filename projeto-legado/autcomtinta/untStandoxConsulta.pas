unit unTStandoxConsulta;

interface

uses
  untTintadeMaquina, SysUtils;

Type
  TStandoxConsulta = class(TTintadeMaquina)
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    function fGetWhere: string; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
  End;

implementation

uses
  untFuncoesSimples;

{ TStandoxConsulta }

constructor TStandoxConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'DOX';
  strCampoAutoincrem := 'AUTOINCREM';

  pAdicionarCampo('DOX_CODDOX', 'Código', 'LIKE');
  pAdicionarCampo('DOX_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('DOX_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('DOX_ANOINI', 'Ano Inicial', 'LIKE');
  pAdicionarCampo('DOX_ANOFIN', 'Ano Final', 'LIKE');
  pAdicionarCampo('DOX_PAINEL', 'Painel', 'LIKE');
  pAdicionarCampo('DOX_QUALID', 'Qualidade', 'LIKE');
  pAdicionarCampo('DOX_CATEGO', 'Categoria', 'LIKE');
  pAdicionarCampo('DOX_VARIAN', 'Variante', 'LIKE');
  pAdicionarCampo('DOX_PAIS__', 'Pais', 'LIKE');    
  pAdicionarCampo('DOX_CODSEQ', 'DOX_CODSEQ', 'LIKE', False, False);
  pAdicionarCampo('DOX_MD5KEY', 'DOX_MD5KEY', 'LIKE', False, True);
  pAdicionarCampo('DOX_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('DOX_BASE' + fStrZero(intCont, 2), 'DOX_BASE' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('DOX_QTDC' + fStrZero(intCont, 2), 'DOX_QTDC' + fStrZero(intCont, 2), '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

function TStandoxConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + ' FROM DOX_CADDOX ';

end;

function TStandoxConsulta.fGetNomeTabela: String;
begin
  Result := 'DOX_CADDOX';
end;

function TStandoxConsulta.fGetNomeTinta: String;
begin
  Result := 'Standox';
end;

function TStandoxConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TStandoxConsulta.fGetWhere: string;
begin
  Result := ' WHERE UPPER(IFNULL(DOX_ATIVO_, ''S'')) = ''S'' ';
end;

procedure TStandoxConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('DOX_CODDOX', 0);
  fSetPos('DOX_MONTAD', 1);
  fSetPos('DOX_DESCRI', 2);
  fSetPos('DOX_ANOINI', 3);
  fSetPos('DOX_ANOFIN', 4);
  fSetPos('DOX_PAINEL', 5);
  fSetPos('DOX_QUALID', 6);
  fSetPos('DOX_CATEGO', 7);
  fSetPos('DOX_VARIAN', 8);
  fSetPos('DOX_PAIS__', 9);

  fSetVisivel('DOX_CODDOX', True);
  fSetVisivel('DOX_MONTAD', True);
  fSetVisivel('DOX_DESCRI', True);
  fSetVisivel('DOX_ANOINI', True);
  fSetVisivel('DOX_ANOFIN', True);
  fSetVisivel('DOX_PAINEL', True);
  fSetVisivel('DOX_QUALID', True);
  fSetVisivel('DOX_CATEGO', True);
  fSetVisivel('DOX_VARIAN', True);
  fSetVisivel('DOX_PAIS__', True);

  pAdicionarIndice('DOX_DESCRI+DOX_QUALID+DOX_MONTAD', 'Descrição/Qualidade/Montadora');
  pAdicionarIndice('DOX_MONTAD', 'Montadora');
  pAdicionarIndice('DOX_CODDOX', 'Código');
  pAdicionarIndice('DOX_PAINEL', 'Painel');

  pLimparDescricao;
  pAdicionarCampoDescricao('DOX_DESCRI');
  pAdicionarCampoDescricao('DOX_MONTAD');
  pAdicionarCampoDescricao('DOX_QUALID');
  pAdicionarCampoDescricao('DOX_CODDOX');

end;

end.
