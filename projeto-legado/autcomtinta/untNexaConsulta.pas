unit untNexaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes, untIConfTinta;

Type
  TNexaConsulta = class(TTintadeMaquina)
  private
    conf: IConfTinta;
  protected
    function fGetSelectFrom: String; override;
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    function fGetGroup: String; Override;
  End;

implementation


uses
  untFuncoesSimples,untTintaMaquina;

{ TNexaConsulta }

constructor TNexaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'NEX';
  strCampoAutoincrem := 'NEX_CADNEX.AUTOINCREM';
  conf := fGetConfTinta('NEX');

  pAdicionarCampo('NEX_DESCOR', 'Descrição', 'LIKE');
  pAdicionarCampo('NEX_TIPO__', 'Tipo', 'LIKE');
  pAdicionarCampo('BAS_TIPO__', 'Produto', 'LIKE');
  pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  pAdicionarCampo('NEX_VEICUL', 'Modelos', 'LIKE');
  pAdicionarCampo('SUBSTR(NEX_A_N_O_, 1, 4)', 'Ano Inicial', 'LIKE');
  pAdicionarCampo('SUBSTR(NEX_A_N_O_, 6, 4)', 'Ano Final', 'LIKE');
  pAdicionarCampo('NEX_CODCOR', 'Código', 'LIKE');
  pAdicionarCampo('NEX_CODATC', 'Código Nexa', 'LIKE');
  pAdicionarCampo('NEX_MONTAD', 'Cód. Montadora', 'LIKE', False, False);
  pAdicionarCampo('NEX_A_N_O_', 'Ano', 'LIKE', False, False);
  pAdicionarCampo('NEX_MD5KEY', 'NEX_MD5KEY', '=', False, True);
  pAdicionarCampo('NEX_VARIAN', 'Variante Cor', 'LIKE');
  pAdicionarCampo('NEX_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('NEX_SISTEM', 'Sistema', 'LIKE');
  pAdicionarCampo('NEX_PAISES', 'País', 'LIKE');
  pAdicionarCampo('NEX_ORIGEM', 'Origem', 'LIKE');
  pAdicionarCampo('NEX_UTILIZ', 'Utilização', 'LIKE');
  pAdicionarCampo('NEX_EFEFIN', 'Efeito Final', 'LIKE');
  pAdicionarCampo('NEX_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('NEX_CODB' + fStrZero(intCont, 2),  'NEX_CODB' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('NEX_QTDB' + fStrZero(intCont, 2),  'NEX_QTDB' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;

function TNexaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;
  Result := Result + fGetCampoAutoIncrem + ', ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';
  Result := Result + fGetSelectFrom;
end;

function TNexaConsulta.fGetGroup: String;
begin
  Result := Result + ' GROUP BY ';
  Result := Result + '   NEX_CODCOR, NEX_DESCOR, NEX_VEICUL, ';
  Result := Result + '   NEX_TIPO__, NEX_A_N_O_, NEX_CODCOR, ';
  Result := Result + '   NEX_CODATC, NEX_VARIAN, NEX_MARCA_, ';
  Result := Result + '   NEX_UTILIZ, NEX_SISTEM, NEX_ORIGEM, ';
  Result := Result + '   NEX_MONTAD                          ';
end;

function TNexaConsulta.fGetNomeTabela: String;
begin
  Result := 'NEX_CADNEX';
end;

function TNexaConsulta.fGetNomeTinta: String;
begin
  Result := 'Nexa Autocolor';
end;

function TNexaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere + fGetGroup;
end;

function TNexaConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM NEX_CADNEX  ';
  Result := Result + '   LEFT JOIN NEX_CADMON  ';
  Result := Result + '     ON NEX_MONTAD = MON_CODMON ';
  Result := Result + '   INNER JOIN NEX_CADBAS  ';
  Result := Result + '     ON NEX_CODB01 = BAS_CODBAS ';
  Result := Result + '    AND IFNULL(NEX_ATIVO_, "S") = "S" ';
end;

procedure TNexaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('NEX_DESCOR', 0);
  fSetPos('MON_DESCRI', 1);
  fSetPos('NEX_SISTEM', 2);
  fSetPos('NEX_PAISES', 2);
  fSetPos('NEX_VARIAN', 4);
  fSetPos('SUBSTR(NEX_A_N_O_, 1, 4)', 5);
  fSetPos('SUBSTR(NEX_A_N_O_, 6, 4)', 6);
  fSetPos('NEX_CODATC, 9), 4)', 7);

  fSetPos('NEX_TIPO__', 8);
  fSetPos('BAS_TIPO__', 9);
  fSetPos('NEX_VEICUL', 10);
  fSetPos('NEX_CODCOR, 9), 4)', 11);
  fSetPos('NEX_REFERE', 12);
  fSetPos('NEX_ORIGEM', 13);
  fSetPos('NEX_UTILIZ', 14);
  fSetPos('NEX_EFEFIN', 15);

  fSetVisivel('NEX_DESCOR', True);
  fSetVisivel('MON_DESCRI', True);
  fSetVisivel('NEX_SISTEM', True);
  fSetVisivel('NEX_PAISES', True);
  fSetVisivel('NEX_VARIAN', True);
  fSetVisivel('SUBSTR(NEX_A_N_O_, 1, 4)', True);
  fSetVisivel('SUBSTR(NEX_A_N_O_, 6, 4) ', True);
  fSetVisivel('NEX_CODATC', True);
  fSetVisivel('NEX_TIPO__', True);

  fSetVisivel('BAS_TIPO__', False);
  fSetVisivel('NEX_VEICUL', False);
  fSetVisivel('NEX_CODCOR', False);
  fSetVisivel('NEX_REFERE', False);
  fSetVisivel('NEX_ORIGEM', False);
  fSetVisivel('NEX_UTILIZ', False);
  fSetVisivel('NEX_EFEFIN', False);

  pAdicionarIndice('NEX_DESCOR+MON_DESCRI+SUBSTR(NEX_A_N_O_, 1, 4)', 'Descrição/Montadora/Ano Inicial');
  pAdicionarIndice('NEX_CODATC', 'Código Nexa');
  pAdicionarIndice('NEX_DESCOR+NEX_VARIAN', 'Descrição/Variante Cor');

  pLimparDescricao;
  pAdicionarCampoDescricao('NEX_DESCOR');
  pAdicionarCampoDescricao('MON_DESCRI');
  pAdicionarCampoDescricao('NEX_SISTEM');
  pAdicionarCampoDescricao('NEX_VARIAN');
  pAdicionarCampoDescricao('SUBSTR(NEX_A_N_O_, 1, 4)');
  pAdicionarCampoDescricao('SUBSTR(NEX_A_N_O_, 6, 4)');
  pAdicionarCampoDescricao('NEX_CODATC');
end;

end.
