unit untHydronorthConsulta;

interface

uses
  untTintadeMaquina,  Classes, SysUtils;

Type
  THydronorthConsulta = class(TTintadeMaquina)
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

constructor THydronorthConsulta.Create;
var
  intCont: Integer;
begin
  inherited;
  strIdePro := 'HYD';
  strCampoAutoincrem := 'H.AUTOINCREM';

  pAdicionarCampo('HYD_COLECA', 'Coleção', 'LIKE');
  pAdicionarCampo('HYD_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('HYD_C_O_R_', 'Cor', 'LIKE');
  pAdicionarCampo('HYD_CORLON', 'Cor Nome Longo', 'LIKE');
  pAdicionarCampo('HYD_BASE__', 'Base', 'LIKE');
  pAdicionarCampo('HYD_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  pAdicionarCampo('HYD_MD5KEY', 'Chave MD5', '=', False, True);
  pAdicionarCampo('HYD_CODEMB', 'Código Embalagem', '=', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('UNI_SIGUNI', 'Unidade', 'LIKE');

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('HYD_FORM' + fStrZero(intCont, 2), 'HYD_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('HYD_QTDC' + fStrZero(intCont, 2), 'HYD_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  end;

  pAbrirTabelaConfs();

end;

destructor THydronorthConsulta.Destroy;
begin

  inherited;
end;

function THydronorthConsulta.fGetNomeTabela: String;
begin
  Result := 'HYD_CADHYD';
end;

function THydronorthConsulta.fGetNomeTinta: String;
begin
  Result := 'Hydronorth Imobiliária';
end;

function THydronorthConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Result := Inherited fGetSelect(blnTodos);
end;

function THydronorthConsulta.fGetSelectFrom: String;
begin
  Result :=
    '   HYD_CADHYD H                      ' +
    '   INNER JOIN HYD_CADBAS B           ' +
    '     ON H.HYD_PRODUT = B.BAS_PRODUT  ' +
    '     AND H.HYD_BASE__ = B.BAS_BASE__ ' +
    '     AND H.HYD_CODEMB = B.BAS_CODEMB ' +
    '   INNER JOIN CADITE I               ' +
    '     ON B.BAS_CODITE = I.ITE_CODITE  ' +
    '   INNER JOIN HYD_CADEMB E           ' +
    '     ON B.BAS_CODEMB = E.EMB_CODEMB  ' +
    '   INNER JOIN CADUNI U               ' +
    '     ON E.EMB_CODUNI = U.UNI_CODUNI  ';
end;

procedure THydronorthConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;
  
  fSetPos('HYD_COLECA', 0);
  fSetPos('HYD_PRODUT', 1);
  fSetPos('HYD_C_O_R_', 2);
  fSetPos('HYD_CORLON', 3);
  fSetPos('HYD_BASE__', 4);
  fSetPos('HYD_CODNFM', 5);
  fSetPos('HYD_MD5KEY', 6);
  fSetPos('ITE_CODITE', 7);
  fSetPos('ITE_DESITE', 8);
  fSetPos('ITE_REFERE', 9);
  fSetPos('UNI_SIGUNI', 10);
  fSetPos('HYD_CODEMB', 11);

  fSetVisivel('HYD_COLECA', True);
  fSetVisivel('HYD_PRODUT', True);
  fSetVisivel('HYD_C_O_R_', True);
  fSetVisivel('HYD_CORLON', True);
  fSetVisivel('HYD_BASE__', True);
  fSetVisivel('HYD_CODNFM', True);
  fSetVisivel('HYD_MD5KEY', False);
  fSetVisivel('ITE_CODITE', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('ITE_REFERE', True);
  fSetVisivel('UNI_SIGUNI', True);
  fSetVisivel('HYD_CODEMB', True);

  pAdicionarIndice('HYD_COLECA+HYD_PRODUT+HYD_CORLON', 'Coleção/Produto/Cor Nome Longo');

  pLimparDescricao;
  pAdicionarCampoDescricao('HYD_COLECA');
  pAdicionarCampoDescricao('HYD_PRODUT');
  pAdicionarCampoDescricao('HYD_C_O_R_');
  pAdicionarCampoDescricao('HYD_CORLON');
  pAdicionarCampoDescricao('HYD_BASE__');
  pAdicionarCampoDescricao('HYD_CODNFM');
  pAdicionarCampoDescricao('HYD_MD5KEY');
  pAdicionarCampoDescricao('ITE_CODITE');
  pAdicionarCampoDescricao('ITE_DESITE');
  pAdicionarCampoDescricao('ITE_REFERE');
  pAdicionarCampoDescricao('UNI_SIGUNI');
  pAdicionarCampoDescricao('HYD_CODEMB');

end;

end.
