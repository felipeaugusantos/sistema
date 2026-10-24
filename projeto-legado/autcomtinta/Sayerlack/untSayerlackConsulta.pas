unit untSayerlackConsulta;

interface

uses
  untTintadeMaquina,  Classes, SysUtils;

Type
  TSayerlackConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
  End;

implementation
uses untFuncoesSimples;
{ TSayerlackConsulta }

constructor TSayerlackConsulta.Create;
var
  intCont: Integer;
begin
  inherited;
  strIdePro := 'SAY';
  strCampoAutoincrem := 'SAY_CADSAY.AUTOINCREM';

  pAdicionarCampo('SAY_BASE__', 'Base', 'LIKE');
  pAdicionarCampo('SAY_CODBAS', 'Código Base', 'LIKE');
  pAdicionarCampo('SAY_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('SAY_CODIGO', 'Código Fórmula', 'LIKE');
  pAdicionarCampo('SAY_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('SAY_COMENT', 'Comentário', 'LIKE');
  pAdicionarCampo('EMB_DESEMB', 'Embalagem', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('UNI_SIGUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('SAY_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  pAdicionarCampo('SAY_MD5KEY', 'Chave MD5', '=', False, True);
  pAdicionarCampo('SAY_DESEMB', 'Embalagem', 'LIKE');

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('SAY_FORM' + fStrZero(intCont, 2), 'SAY_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('SAY_QTDC' + fStrZero(intCont, 2), 'VEL_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

destructor TSayerlackConsulta.Destroy;
begin

  inherited;
end;

function TSayerlackConsulta.fGetNomeTabela: String;
begin
  Result := 'SAY_CADSAY';
end;

function TSayerlackConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Result := Inherited fGetSelect(blnTodos);
end;

function TSayerlackConsulta.fGetSelectFrom: String;
begin
  Result :=
    '   SAY_CADSAY                      ' +
    '   INNER JOIN SAY_CADBAS           ' +
    '     ON SAY_BASE__ = BAS_BASE__    ' +
    '     AND SAY_CODBAS = BAS_CODBAS   ' +
    '     AND SAY_PRODUT = BAS_PRODUT   ' +
    '     AND SAY_DESEMB = BAS_DESEMB   ' +
    '   INNER JOIN CADITE               ' +
    '     ON BAS_CODITE = ITE_CODITE    ' +
    '   INNER JOIN SAY_CADEMB           ' +
    '     ON SAY_DESEMB = EMB_DESEMB    ' +
    '   INNER JOIN CADUNI               ' +
    '     ON EMB_CODUNI = UNI_CODUNI    ';
end;

procedure TSayerlackConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('SAY_BASE__', 0);
  fSetPos('SAY_CODBAS', 1);
  fSetPos('SAY_PRODUT', 2);
  fSetPos('SAY_CODIGO', 3);
  fSetPos('SAY_DESCRI', 4);
  fSetPos('ITE_DESITE', 5);
  fSetPos('ITE_REFERE', 6);
  fSetPos('EMB_DESEMB', 7);
  fSetPos('UNI_SIGUNI', 8);
  fSetPos('SAY_CODNFM', 9);
  fSetPos('SAY_DESEMB', 10);
  fSetPos('SAY_COMENT', 11);

  fSetVisivel('SAY_BASE__', True);
  fSetVisivel('SAY_CODBAS', True);
  fSetVisivel('SAY_PRODUT', True);
  fSetVisivel('SAY_CODIGO', True);
  fSetVisivel('SAY_DESCRI', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('ITE_REFERE', True);
  fSetVisivel('EMB_DESEMB', True);
  fSetVisivel('UNI_SIGUNI', True);
  fSetVisivel('SAY_CODNFM', False);
  fSetVisivel('SAY_DESEMB', False);
  fSetVisivel('SAY_COMENT', True);

  pAdicionarIndice('SAY_CODIGO+SAY_DESCRI', 'Código Fórmula/Descrição');
  pAdicionarIndice('SAY_BASE__+SAY_CODBAS+SAY_PRODUT', 'Base/Código Base/Produto');
  pAdicionarIndice('SAY_PRODUT', 'Produto');

  pLimparDescricao;
  pAdicionarCampoDescricao('SAY_BASE__');
  pAdicionarCampoDescricao('SAY_CODBAS');
  pAdicionarCampoDescricao('SAY_PRODUT');
  pAdicionarCampoDescricao('SAY_CODIGO');
  pAdicionarCampoDescricao('SAY_DESCRI');
  pAdicionarCampoDescricao('ITE_DESITE');
  pAdicionarCampoDescricao('ITE_REFERE');
  pAdicionarCampoDescricao('EMB_DESEMB');
  pAdicionarCampoDescricao('UNI_SIGUNI');
  pAdicionarCampoDescricao('SAY_CODNFM');
  pAdicionarCampoDescricao('SAY_DESEMB');
  pAdicionarCampoDescricao('SAY_COMENT');  
end;

end.
