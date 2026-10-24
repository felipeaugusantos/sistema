unit untPpgConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes, untIConfTinta;

Type
  TPpgConsulta = class(TTintadeMaquina)
  private
    conf: IConfTinta;
  protected
    function fGetSelectFrom: String; override;
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: boolean): String; override;
    function fGetWhere: string; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
  End;

implementation


uses
  untFuncoesSimples,untTintaMaquina;

{ TPpgConsulta }

constructor TPpgConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'PPG';
  strCampoAutoincrem := 'PPG_CADPPG.AUTOINCREM';
  conf := fGetConfTinta('PPG');  

  pAdicionarCampo('PPG_DESCOR', 'Descrição', 'LIKE');
  pAdicionarCampo('PPG_TIPO__', 'Tipo', 'LIKE');
  pAdicionarCampo('BAS_TIPO__', 'Produto', 'LIKE');
  pAdicionarCampo('MON_DESCRI', 'Montadora', 'LIKE');
  pAdicionarCampo('PPG_VEICUL', 'Modelos', 'LIKE');
  pAdicionarCampo('SUBSTR(PPG_A_N_O_, 1, 4)', 'Ano Inicial', 'LIKE');
  pAdicionarCampo('SUBSTR(PPG_A_N_O_, 6, 4)', 'Ano Final', 'LIKE');
  pAdicionarCampo('PPG_CODCOR', 'Código', 'LIKE');
  pAdicionarCampo('PPG_CODATC', 'Código PPG', 'LIKE');
  pAdicionarCampo('PPG_MONTAD', 'Cód. Montadora', 'LIKE', False, False);
  pAdicionarCampo('PPG_A_N_O_', 'Ano', 'LIKE', False, False);
  pAdicionarCampo('PPG_MD5KEY', 'PPG_MD5KEY', '=', False, True);
  pAdicionarCampo('PPG_VARIAN', 'Variante Cor', 'LIKE');
  pAdicionarCampo('PPG_REFERE', 'Referência', 'LIKE');
  pAdicionarCampo('PPG_SISTEM', 'Sistema', 'LIKE');
  pAdicionarCampo('PPG_PAISES', 'País', 'LIKE');
  pAdicionarCampo('PPG_ORIGEM', 'Origem', 'LIKE');
  pAdicionarCampo('PPG_UTILIZ', 'Utilização', 'LIKE');
  pAdicionarCampo('PPG_EFEFIN', 'Efeito Final', 'LIKE');
  pAdicionarCampo('PPG_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('PPG_CODB' + fStrZero(intCont, 2),  'PPG_CODB' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('PPG_QTDB' + fStrZero(intCont, 2),  'PPG_QTDB' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;


function TPpgConsulta.fGetNomeTabela: String;
begin
  Result := 'PPG_CADPPG';
end;

function TPpgConsulta.fGetNomeTinta: String;
begin
  Result := 'Ppg';
end;

function TPpgConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TPpgConsulta.fGetCamposSelect(blnTodos: boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ' + #$D#$A ;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;
  Result := Result +   fGetCampoAutoIncrem + ', ';

  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';

  Result := Result + fGetSelectFrom;
end;

function TPpgConsulta.fGetWhere: string;
begin
  Result := Result + ' WHERE IFNULL(PPG_ATIVO_, "S") = "S" ';
end;



function TPpgConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM PPG_CADPPG  ';
  Result := Result + '   LEFT JOIN PPG_CADMON  ';
  Result := Result + '     ON PPG_MONTAD = MON_CODMON ';
  Result := Result + '   INNER JOIN PPG_CADBAS  ';
  Result := Result + '     ON PPG_CODB01 = BAS_CODBAS ';
  Result := Result + '    AND IFNULL(PPG_ATIVO_, "S") = "S" ';
end;


procedure TPpgConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('PPG_DESCOR', 0);
  fSetPos('MON_DESCRI', 1);
  fSetPos('PPG_SISTEM', 2);
  fSetPos('PPG_PAISES', 2);
  fSetPos('PPG_VARIAN', 4);
  fSetPos('SUBSTR(PPG_A_N_O_, 1, 4)', 5);
  fSetPos('SUBSTR(PPG_A_N_O_, 6, 4)', 6);
  fSetPos('PPG_CODATC, 9), 4)', 7);

  fSetPos('PPG_TIPO__', 8);
  fSetPos('BAS_TIPO__', 9);
  fSetPos('PPG_VEICUL', 10);
  fSetPos('PPG_CODCOR, 9), 4)', 11);
  fSetPos('PPG_REFERE', 12);
  fSetPos('PPG_ORIGEM', 13);
  fSetPos('PPG_UTILIZ', 14);
  fSetPos('PPG_EFEFIN', 15);

  fSetVisivel('PPG_DESCOR', True);
  fSetVisivel('MON_DESCRI', True);
  fSetVisivel('PPG_SISTEM', True);
  fSetVisivel('PPG_PAISES', True);
  fSetVisivel('PPG_VARIAN', True);
  fSetVisivel('SUBSTR(PPG_A_N_O_, 1, 4)', True);
  fSetVisivel('SUBSTR(PPG_A_N_O_, 6, 4)', True);
  fSetVisivel('PPG_CODATC', True);
  fSetVisivel('PPG_TIPO__', True);

  fSetVisivel('BAS_TIPO__', False);
  fSetVisivel('PPG_VEICUL', False);
  fSetVisivel('PPG_CODCOR', False);
  fSetVisivel('PPG_REFERE', False);
  fSetVisivel('PPG_ORIGEM', False);
  fSetVisivel('PPG_UTILIZ', False);
  fSetVisivel('PPG_EFEFIN', False);

  pAdicionarIndice('PPG_DESCOR+MON_DESCRI+SUBSTR(PPG_A_N_O_, 1, 4)', 'Descrição/Montadora/Ano Inicial');
  pAdicionarIndice('PPG_CODATC', 'Código PPG');
  pAdicionarIndice('PPG_DESCOR+PPG_VARIAN', 'Descrição/Variante Cor');

  pLimparDescricao;
  pAdicionarCampoDescricao('PPG_DESCOR');
  pAdicionarCampoDescricao('MON_DESCRI');
  pAdicionarCampoDescricao('PPG_SISTEM');
  pAdicionarCampoDescricao('PPG_VARIAN');
  pAdicionarCampoDescricao('SUBSTR(PPG_A_N_O_, 1, 4)');
  pAdicionarCampoDescricao('SUBSTR(PPG_A_N_O_, 6, 4)');
  pAdicionarCampoDescricao('PPG_CODATC');
end;

end.

