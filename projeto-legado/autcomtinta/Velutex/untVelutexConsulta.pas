unit untVelutexConsulta;

interface

uses
  untTintadeMaquina,  Classes, SysUtils;

Type
  TVelutexConsulta = class(TTintadeMaquina)
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

constructor TVelutexConsulta.Create;
var
  intCont: Integer;
begin
  inherited;
  strIdePro := 'VEL';
  strCampoAutoincrem := 'VEL_CADVEL.AUTOINCREM';

  pAdicionarCampo('VEL_CORCOD', 'Color Code', 'LIKE');
  pAdicionarCampo('VEL_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('VEL_COLECA', 'Coleção', 'LIKE');
  pAdicionarCampo('VEL_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('VEL_CODNOM', 'Cód.Nome', 'LIKE');
  pAdicionarCampo('VEL_CODUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('VEL_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  pAdicionarCampo('VEL_MD5KEY', 'Chave MD5', '=', False, True);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('UNI_SIGUNI', 'Unidade', 'LIKE');

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('VEL_CODC' + fStrZero(intCont, 2), 'VEL_CODC' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('VEL_QTDC' + fStrZero(intCont, 2), 'VEL_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  end;

  pAbrirTabelaConfs();

end;

destructor TVelutexConsulta.Destroy;
begin

  inherited;
end;

function TVelutexConsulta.fGetNomeTabela: String;
begin
  Result := 'VEL_CADVEL';
end;

function TVelutexConsulta.fGetNomeTinta: String;
begin
  Result := 'Velutex Imobiliária';
end;

function TVelutexConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Result := Inherited fGetSelect(blnTodos);
end;

function TVelutexConsulta.fGetSelectFrom: String;
begin
  Result :=
    '   VEL_CADVEL  ' +
    '   INNER JOIN VEL_CADBAS  ON VEL_CODBAS = BAS_CODBAS ' +
    '                         AND VEL_PRODUT = BAS_PRODUT ' +
    '                         AND VEL_CODUNI = BAS_CODUNI ' +
    '   INNER JOIN CADITE      ON BAS_CODITE = ITE_CODITE ' +
    '   INNER JOIN CADUNI      ON BAS_CODUNI = UNI_CODUNI ';
end;

procedure TVelutexConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('VEL_CORCOD', 0);
  fSetPos('VEL_CODBAS', 1);
  fSetPos('VEL_COLECA', 2);
  fSetPos('VEL_PRODUT', 3);
  fSetPos('VEL_CODUNI', 4);
  fSetPos('VEL_CODNFM', 5);
  fSetPos('ITE_DESITE', 6);
  fSetPos('ITE_REFERE', 7);
  fSetPos('UNI_SIGUNI', 8);
  fSetPos('VEL_CODNOM', 9);

  fSetVisivel('VEL_CORCOD', True);
  fSetVisivel('VEL_CODBAS', True);
  fSetVisivel('VEL_COLECA', True);
  fSetVisivel('VEL_PRODUT', True);
  fSetVisivel('VEL_CODUNI', True);
  fSetVisivel('VEL_CODNFM', False);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('ITE_REFERE', True);
  fSetVisivel('UNI_SIGUNI', True);
//  fSetVisivel('VEL_CODUNI', True);

  pAdicionarIndice('VEL_CORCOD+VEL_PRODUT+VEL_CODUNI', 'Color Code/Produto/Unidade');
  pAdicionarIndice('ITE_DESITE', 'Descrição do Item');

  pLimparDescricao;
  pAdicionarCampoDescricao('VEL_CORCOD');
  pAdicionarCampoDescricao('VEL_CODBAS');
  pAdicionarCampoDescricao('VEL_COLECA');
  pAdicionarCampoDescricao('VEL_PRODUT');
  pAdicionarCampoDescricao('VEL_CODUNI');
  pAdicionarCampoDescricao('VEL_CODNFM');
  pAdicionarCampoDescricao('ITE_DESITE');
  pAdicionarCampoDescricao('ITE_REFERE');
  pAdicionarCampoDescricao('UNI_SIGUNI');
//  pAdicionarCampoDescricao('UNI_CODUNI');
end;

end.

