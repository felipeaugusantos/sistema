unit unTDupontConsulta;

interface

uses
  untTintadeMaquina, SysUtils;

Type
  TDupontConsulta = class(TTintadeMaquina)
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: boolean): String; override;
    function fGetWhere(): string; override;

    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
  End;

implementation

uses
  untFuncoesSimples;

{ TDupontConsulta }

constructor TDupontConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'DUP';
  strCampoAutoincrem := 'AUTOINCREM';

  pAdicionarCampo('DUP_CODDUP', 'Código', 'LIKE');
  pAdicionarCampo('DUP_CODOEM', 'Código Oem', 'LIKE');
  pAdicionarCampo('DUP_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('DUP_QUALID', 'Qualidade', 'LIKE');
  pAdicionarCampo('DUP_ALTERN', 'Alternativa', 'LIKE');
  pAdicionarCampo('DUP_REGIAO', 'Região', 'LIKE');
  pAdicionarCampo('DUP_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('DUP_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('DUP_ANOCOR', 'Ano', 'LIKE');
  pAdicionarCampo('DUP_LITRAG', 'Volume', 'LIKE');
  pAdicionarCampo('DUP_CODSEQ', 'DUP_CODSEQ', 'LIKE', False, False);
  pAdicionarCampo('DUP_MD5KEY', 'DUP_MD5KEY', 'LIKE', False, False);
  pAdicionarCampo('DUP_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('DUP_BASE' + fStrZero(intCont, 2), 'DUP_BASE' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('DUP_QTDC' + fStrZero(intCont, 2), 'DUP_QTDC' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('DUP_QTDD' + fStrZero(intCont, 2), 'DUP_QTDD' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('DUP_TIPB' + fStrZero(intCont, 2), 'DUP_TIPB' + fStrZero(intCont, 2), '=', False, False);
  End;

  pAbrirTabelaConfs();

end;


function TDupontConsulta.fGetNomeTabela: String;
begin
  Result := 'DUP_CADDUP';
end;

function TDupontConsulta.fGetNomeTinta: String;
begin
  Result := 'Dupont';
end;

function TDupontConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TDupontConsulta.fGetCamposSelect(blnTodos: boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or(fGetDisponivel(intCont)) Then
        Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;

  Result := Result + ' AUTOINCREM, ';

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + ' FROM DUP_CADDUP ';

end;

function TDupontConsulta.fGetWhere(): String;
begin
  Result := ' WHERE TRUE AND UPPER(IFNULL(DUP_ATIVO_, ''S'')) = ''S'' ';
End;

procedure TDupontConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('DUP_CODDUP', 0);
  fSetPos('DUP_ALTERN', 1);
  fSetPos('DUP_REGIAO', 2);
  fSetPos('DUP_DESCRI', 3);
  fSetPos('DUP_CODOEM', 4);
  fSetPos('DUP_MONTAD', 5);
  fSetPos('DUP_ANOCOR', 6);
  fSetPos('DUP_LINHA_', 7);
  fSetPos('DUP_QUALID', 8);

  fSetVisivel('DUP_CODDUP', True);
  fSetVisivel('DUP_ALTERN', True);
  fSetVisivel('DUP_REGIAO', True);
  fSetVisivel('DUP_DESCRI', True);
  fSetVisivel('DUP_CODOEM', True);
  fSetVisivel('DUP_MONTAD', True);
  fSetVisivel('DUP_ANOCOR', True);
  fSetVisivel('DUP_LINHA_', True);
  fSetVisivel('DUP_QUALID', True);                                                       

  pAdicionarIndice('DUP_DESCRI+DUP_QUALID+DUP_REGIAO', 'Descrição/Qualidade/Região');
  pAdicionarIndice('DUP_MONTAD', 'Montadora');
  pAdicionarIndice('DUP_CODDUP', 'Código');
  pAdicionarIndice('DUP_CODOEM', 'Código Oem');

  pLimparDescricao;  
  pAdicionarCampoDescricao('DUP_DESCRI');
  pAdicionarCampoDescricao('DUP_MONTAD');
  pAdicionarCampoDescricao('DUP_QUALID');
  pAdicionarCampoDescricao('DUP_CODDUP');

end;

end.
