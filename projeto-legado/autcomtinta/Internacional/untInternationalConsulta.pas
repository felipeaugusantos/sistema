unit untInternationalConsulta;

interface

uses
  untTintadeMaquina,  Classes, SysUtils;

Type
  TInternationalConsulta = class(TTintadeMaquina)
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

constructor TInternationalConsulta.Create;
var
  intCont: Integer;
begin
  inherited;
  strIdePro := 'INT';
  strCampoAutoincrem := 'T.AUTOINCREM';

  pAdicionarCampo('INT_DESCOR', 'Cor', 'LIKE');
  pAdicionarCampo('INT_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('INT_CODNFM', 'Código Novas Fórmulas', 'LIKE');
  pAdicionarCampo('INT_MD5KEY', 'Chave MD5', '=', False, True);
  pAdicionarCampo('INT_CODEMB', 'Embalagem', '=', False, False);
  pAdicionarCampo('ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('ITE_REFERE', 'Referência do Item', 'LIKE');
  pAdicionarCampo('UNI_SIGUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('INT_LINHA_', 'Linha', 'LIKE');

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('INT_FORM' + fStrZero(intCont, 2), 'INT_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('INT_QTDC' + fStrZero(intCont, 2), 'INT_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  end;

  pAbrirTabelaConfs();

end;

destructor TInternationalConsulta.Destroy;
begin

  inherited;
end;

function TInternationalConsulta.fGetNomeTabela: String;
begin
  Result := 'INT_CADINT';
end;

function TInternationalConsulta.fGetNomeTinta: String;
begin
  Result := 'International';
end;

function TInternationalConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Result := Inherited fGetSelect(blnTodos);
end;

function TInternationalConsulta.fGetSelectFrom: String;
begin
  Result :=
    '   INT_CADINT T                      ' +
    '   INNER JOIN INT_CADBAS B           ' +
    '     ON T.INT_CODBAS = B.BAS_CODBAS  ' +
    '     AND T.INT_CODEMB = B.BAS_CODEMB ' +
    '   INNER JOIN CADITE I               ' +
    '     ON B.BAS_CODITE = I.ITE_CODITE  ' +
    '   INNER JOIN INT_CADEMB E           ' +
    '     ON B.BAS_CODEMB = E.EMB_CODEMB  ' +
    '   INNER JOIN CADUNI U               ' +
    '     ON E.EMB_CODUNI = U.UNI_CODUNI  ';
end;

procedure TInternationalConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('INT_DESCOR', 0);
  fSetPos('INT_CODBAS', 1);
  fSetPos('INT_CODNFM', 2);
  fSetPos('INT_MD5KEY', 3);
  fSetPos('ITE_CODITE', 4);
  fSetPos('ITE_DESITE', 5);
  fSetPos('ITE_REFERE', 6);
  fSetPos('UNI_SIGUNI', 7);
  fSetPos('INT_CODEMB', 8);
  fSetPos('INT_LINHA_', 9);

  fSetVisivel('INT_DESCOR', True);
  fSetVisivel('INT_CODBAS', True);
  fSetVisivel('INT_CODNFM', True);
  fSetVisivel('INT_MD5KEY', False);
  fSetVisivel('ITE_CODITE', True);
  fSetVisivel('ITE_DESITE', True);
  fSetVisivel('ITE_REFERE', True);
  fSetVisivel('UNI_SIGUNI', True);
  fSetVisivel('INT_CODEMB', True);
  fSetVisivel('INT_LINHA_', True);

  pAdicionarIndice('INT_DESCOR+INT_CODBAS+INT_CODEMB', 'Cor/Base/Embalagem');
  pAdicionarIndice('INT_DESCOR+INT_LINHA_', 'Cor/Linha');

  pLimparDescricao;
  pAdicionarCampoDescricao('INT_DESCOR');
  pAdicionarCampoDescricao('INT_CODBAS');
  pAdicionarCampoDescricao('INT_CODNFM');
  pAdicionarCampoDescricao('INT_MD5KEY');
  pAdicionarCampoDescricao('ITE_CODITE');
  pAdicionarCampoDescricao('ITE_DESITE');
  pAdicionarCampoDescricao('ITE_REFERE');
  pAdicionarCampoDescricao('UNI_SIGUNI');
  pAdicionarCampoDescricao('INT_CODEMB');
  pAdicionarCampoDescricao('INT_LINHA_');

end;

end.
