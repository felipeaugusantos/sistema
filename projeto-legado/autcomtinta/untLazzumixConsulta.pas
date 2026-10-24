unit untLazzumixConsulta;

interface

uses
  untTintadeMaquina, SysUtils;

Type
  TLazzumixConsulta = class(TTintadeMaquina)
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
  End;

implementation

uses
  untFuncoesSimples;
{ TLazzumixConsulta }

constructor TLazzumixConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'LAZ';
  strCampoAutoincrem := 'AUTOINCREM';

  pAdicionarCampo('MIX_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('MIX_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('MIX_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('MIX_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('MIX_A_N_O_', 'Ano', 'LIKE');
  pAdicionarCampo('MIX_UNIVER', 'Código Universal', 'LIKE');
  pAdicionarCampo('MIX_VOLCON', 'Volume Concentrado', 'LIKE');
  pAdicionarCampo('MIX_VOLDIL', 'Volume Diluido', 'LIKE');
  pAdicionarCampo('MIX_VOLMID', 'Volume Minímo Diluído','LIKE', False, False);
  pAdicionarCampo('MIX_VOLMIC', 'Volume Minímo Concentrado','LIKE', False, False);


  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('MIX_BASE' + fStrZero(intCont, 2), 'MIX_BASE' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('MIX_QTDC' + fStrZero(intCont, 2), 'MIX_QTDC' + fStrZero(intCont, 2), '=', False, False);
    pAdicionarCampo('MIX_QTDD' + fStrZero(intCont, 2), 'MIX_QTDD' + fStrZero(intCont, 2), '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

function TLazzumixConsulta.fGetNomeTabela: String;
Begin
  Result := 'LAZ_CADMIX';
end;

function TLazzumixConsulta.fGetNomeTinta: String;
Begin
  Result := 'Lazzumix';
end;

function TLazzumixConsulta.fGetSelect(blnTodos: Boolean): String;
Begin
  Result := inherited fGetSelect(blnTodos);
end;

procedure TLazzumixConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('MIX_DESCRI', 0);
  fSetPos('MIX_CODIGO', 1);
  fSetPos('MIX_REFERE', 2);
  fSetPos('MIX_MONTAD', 3);
  fSetPos('MIX_A_N_O_', 4);
  fSetPos('MIX_UNIVER', 5);

  fSetVisivel('MIX_DESCRI', True);
  fSetVisivel('MIX_CODIGO', True);
  fSetVisivel('MIX_REFERE', True);
  fSetVisivel('MIX_MONTAD', True);
  fSetVisivel('MIX_A_N_O_', True);
  fSetVisivel('MIX_UNIVER', True);

  pAdicionarIndice('MIX_DESCRI', 'Descrição');
  pAdicionarIndice('MIX_CODIGO', 'Código');
  pAdicionarIndice('MIX_UNIVER', 'Código Universal');
  pAdicionarIndice('MIX_REFERE', 'Referência');

  pLimparDescricao;
  pAdicionarCampoDescricao('MIX_DESCRI');
  pAdicionarCampoDescricao('MIX_REFERE');
  pAdicionarCampoDescricao('MIX_CODIGO');
end;

end.
