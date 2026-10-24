unit untCalamarConsulta;

interface

uses
  untTintadeMaquina, Classes, SysUtils;

Type
  TCalamarConsulta = class(TTintadeMaquina)
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
{ TVelutexConsulta }

constructor TCalamarConsulta.Create;
var
  intCont: Integer;
begin
  inherited;
  strIdePro := 'CAL';
  strCampoAutoincrem := 'C.AUTOINCREM';

  pAdicionarCampo('CAL_CODBAS', 'Código da Base', 'LIKE');
  pAdicionarCampo('CAL_CODEMB', 'Código da Embalagem', 'LIKE');
  pAdicionarCampo('CAL_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  pAdicionarCampo('CAL_KEY1__', 'Key 1', 'LIKE');
  pAdicionarCampo('CAL_KEY2__', 'Key 2', 'LIKE');
  pAdicionarCampo('CAL_KEY3__', 'Key 3', 'LIKE');
  pAdicionarCampo('CAL_MD5KEY', 'Chave MD5', '=', False, True);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('UNI_SIGUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('CAL_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('CAL_COLECA', 'Coleção', 'LIKE');

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('CAL_CODC' + fStrZero(intCont, 2), 'CAL_CODC' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('CAL_QTDC' + fStrZero(intCont, 2), 'CAL_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  end;

  pAbrirTabelaConfs();

end;

destructor TCalamarConsulta.Destroy;
begin

  inherited;
end;

function TCalamarConsulta.fGetNomeTabela: String;
begin
  Result := 'CAL_CADCAL';
end;

function TCalamarConsulta.fGetNomeTinta: String;
begin
  Result := 'Calamar';
end;

function TCalamarConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Result := Inherited fGetSelect(blnTodos);
end;

function TCalamarConsulta.fGetSelectFrom: String;
begin
  Result :=
    '   CAL_CADCAL C                      ' +
    '   INNER JOIN CAL_CADBAS B           ' +
    '      ON C.CAL_CODBAS = B.BAS_CODBAS ' +
    '     AND C.CAL_CODEMB = B.BAS_CODEMB ' +
    '   INNER JOIN CADITE I               ' +
    '     ON B.BAS_CODITE = I.ITE_CODITE  ' +
    '   INNER JOIN CAL_CADEMB E           ' +
    '     ON B.BAS_CODEMB = E.EMB_CODEMB  ' +
    '   INNER JOIN CADUNI U               ' +
    '     ON E.EMB_CODUNI = U.UNI_CODUNI  ';
end;

procedure TCalamarConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('CAL_CODBAS', 0);
  fSetPos('CAL_KEY1__', 1);
  fSetPos('CAL_KEY2__', 2);
  fSetPos('CAL_KEY3__', 3);
  fSetPos('CAL_CODNFM', 4);
  fSetPos('CAL_MD5KEY', 5);
  fSetPos('ITE_CODITE', 6);
  fSetPos('ITE_DESITE', 7);
  fSetPos('ITE_REFERE', 8);
  fSetPos('UNI_SIGUNI', 9);
  fSetPos('CAL_CODEMB', 10);

  fSetVisivel('CAL_CODBAS', True);
  fSetVisivel('CAL_KEY1__', True);
  fSetVisivel('CAL_KEY2__', True);
  fSetVisivel('CAL_KEY3__', True);
  fSetVisivel('CAL_CODNFM', True);
  fSetVisivel('CAL_MD5KEY', False);
  fSetVisivel('ITE_CODITE', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('ITE_REFERE', True);
  fSetVisivel('UNI_SIGUNI', True);
  fSetVisivel('CAL_CODEMB', True);

  pAdicionarIndice('CAL_KEY1__+CAL_KEY2__+CAL_KEY3__', 'Key 1/Key 2/Key 3');

  pLimparDescricao;
  pAdicionarCampoDescricao('CAL_CODBAS');
  pAdicionarCampoDescricao('CAL_KEY1__');
  pAdicionarCampoDescricao('CAL_KEY2__');
  pAdicionarCampoDescricao('CAL_KEY3__');
  pAdicionarCampoDescricao('UNI_SIGUNI');
end;

end.

