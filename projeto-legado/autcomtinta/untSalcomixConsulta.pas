unit untSalcomixConsulta;

interface

uses
  untTintadeMaquina, SysUtils;

Type
  TSalcomixConsulta = class(TTintadeMaquina)
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetWhere: string; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
  End;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  untFuncoesGenerica;
{$ELSE}
  untFuncoesSimples;
{$ENDIF}

{ TSalcomixConsulta }

constructor TSalcomixConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'SAL';
  strCampoAutoincrem := 'AUTOINCREM';

  pAdicionarCampo('SAL_CODSEQ', 'Cód. Seq.', 'LIKE');
  pAdicionarCampo('SAL_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('SAL_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('SAL_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('SAL_CODPRO', 'Código', 'LIKE');
  pAdicionarCampo('SAL_ANOCOR', 'Ano', 'LIKE');
  pAdicionarCampo('SAL_VARIAC', 'Variação', 'LIKE');
  pAdicionarCampo('SAL_PASSO_', 'Passo', 'LIKE');
  pAdicionarCampo('SAL_DTACAD', 'Data Cadastro', 'DATE');
  pAdicionarCampo('SAL_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);
  pAdicionarCampo('SAL_MD5KEY', 'Chave Md5', 'LIKE', False, True);

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('SAL_FORM' + fStrZero(intCont, 2), 'SAL_FORM' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('SAL_QTDB' + fStrZero(intCont, 2), 'SAL_QTDB' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('SAL_QTDD' + fStrZero(intCont, 2), 'SAL_QTDD' + fStrZero(intCont, 2), '=', False, False);    
  End;

  pAbrirTabelaConfs();
end;

function TSalcomixConsulta.fGetNomeTabela: String;
begin
  Result := 'SAL_CADSAL';
end;

function TSalcomixConsulta.fGetNomeTinta: String;
begin
  Result := 'Salcomix';
end;

function TSalcomixConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Result := inherited fGetSelect(blnTodos);
end;

function TSalcomixConsulta.fGetWhere: string;
begin
  Result := ' WHERE TRUE AND UPPER(IFNULL(SAL_ATIVO_, "S")) = "S" ';
end;

procedure TSalcomixConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('SAL_DESCRI', 0);
  fSetPos('SAL_CODPRO', 1);
  fSetPos('SAL_MONTAD', 2);
  fSetPos('SAL_VARIAC', 3);
  fSetPos('SAL_LINHA_', 4);
  fSetPos('SAL_ANOCOR', 5);
  fSetPos('SAL_CODSEQ', 6);

  fSetVisivel('SAL_DESCRI', True);
  fSetVisivel('SAL_CODPRO', True);
  fSetVisivel('SAL_MONTAD', True);
  fSetVisivel('SAL_VARIAC', True);
  fSetVisivel('SAL_LINHA_', True);
  fSetVisivel('SAL_ANOCOR', True);
  fSetVisivel('SAL_CODSEQ', True);

  pAdicionarIndice('SAL_DESCRI+SAL_MONTAD', 'Descrição/Montadora');
  pAdicionarIndice('SAL_CODPRO',            'Código');
  pAdicionarIndice('SAL_MONTAD',            'Montadora');
  pAdicionarIndice('SAL_LINHA_',            'Linha');
  pAdicionarIndice('SAL_CODSEQ',            'Cód. Seq.');

  pLimparDescricao;
  pAdicionarCampoDescricao('SAL_DESCRI');
  pAdicionarCampoDescricao('SAL_CODPRO');
  pAdicionarCampoDescricao('SAL_VARIAC');

end;

end.
