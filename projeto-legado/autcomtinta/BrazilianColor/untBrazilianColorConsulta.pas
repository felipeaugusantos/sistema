unit untBrazilianColorConsulta;

interface

uses
  untTintadeMaquina, Classes, SysUtils;

Type
  TBrazilianColorConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
  End;

implementation
uses untFuncoesSimples;
{ TBrazilianColorConsulta }

constructor TBrazilianColorConsulta.Create;
var
  intCont: Integer;
begin
  inherited;
  strIdePro := 'BZC';
  strCampoAutoincrem := 'BZC_CADBZC.AUTOINCREM';

  pAdicionarCampo('BZC_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('BZC_CODUNI', 'Código Universal', 'LIKE');
  pAdicionarCampo('BZC_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('BZC_A_N_O_', 'Ano', 'LIKE');
  pAdicionarCampo('BZC_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  pAdicionarCampo('BZC_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  pAdicionarCampo('BZC_TIPO__', 'Tipo', 'LIKE');
  pAdicionarCampo('BZC_MD5KEY', 'MD5KEY', 'LIKE', False, True);
  pAdicionarCampo('BZC_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('BZC_BASE' + fStrZero(intCont, 2), 'BZC_BASE' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('BZC_QTDC' + fStrZero(intCont, 2), 'BZC_QTDC' + fStrZero(intCont, 2),
      '=', False, False);

    pAdicionarCampo('BZC_QTDD' + fStrZero(intCont, 2), 'BZC_QTDD' + fStrZero(intCont, 2),
      '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

destructor TBrazilianColorConsulta.Destroy;
begin

  inherited;
end;

function TBrazilianColorConsulta.fGetNomeTabela: String;
begin
  Result := 'BZC_CADBZC';
end;

function TBrazilianColorConsulta.fGetNomeTinta: String;
begin
  Result := 'BrazilianColor Automotiva';
end;

function TBrazilianColorConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Result := inherited fGetSelect(blnTodos);
end;

function TBrazilianColorConsulta.fGetSelectFrom: String;
begin
  Result :=
    '   BZC_CADBZC                     ' +
    '   LEFT JOIN BZC_CADMON           ' +
    '     ON BZC_CODMON = MON_CODMON   ';
end;

procedure TBrazilianColorConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('BZC_CODIGO', 0);
  fSetPos('BZC_CODUNI', 1);
  fSetPos('BZC_DESCRI', 2);
  fSetPos('BZC_A_N_O_', 3);
  fSetPos('MON_DESCRI', 4);
  fSetPos('BZC_CODNFM', 5);
  fSetPos('BZC_TIPO__', 6);
  fSetPos('BZC_LINHA_', 7);

  fSetVisivel('BZC_CODIGO', True);
  fSetVisivel('BZC_CODUNI', True);
  fSetVisivel('BZC_DESCRI', True);
  fSetVisivel('BZC_A_N_O_', True);
  fSetVisivel('MON_DESCRI', True);
  fSetVisivel('BZC_CODNFM', False);
  fSetVisivel('BZC_TIPO__', True);
  fSetVisivel('BZC_LINHA_', True);

  pAdicionarIndice('BZC_DESCRI', 'Descrição');
  pAdicionarIndice('BZC_CODIGO', 'Código');
  pAdicionarIndice('BZC_A_N_O_+BZC_DESCRI', 'Ano/Descrição');
  pAdicionarIndice('BZC_LINHA_', 'Linha');

  pLimparDescricao;
  pAdicionarCampoDescricao('BZC_CODIGO');
  pAdicionarCampoDescricao('BZC_CODUNI');
  pAdicionarCampoDescricao('BZC_DESCRI');
  pAdicionarCampoDescricao('BZC_A_N_O_');
  pAdicionarCampoDescricao('MON_DESCRI');
  pAdicionarCampoDescricao('BZC_CODNFM');
  pAdicionarCampoDescricao('BZC_TIPO__');
  pAdicionarCampoDescricao('BZC_LINHA_');
end;

end.
