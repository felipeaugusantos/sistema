unit untSkyMixAutomotivaConsulta;

interface
uses
  untTintadeMaquina, SysUtils;

Type
  TSkyMixConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    destructor Destroy; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
  End;
implementation

uses untFuncoesSimples;

{ TSkyMixConsulta }

constructor TSkyMixConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited;
  strIdePro := 'SKY';
  strCampoAutoincrem := 'SKY_CADSKY.AUTOINCREM';

  pAdicionarCampo('SKY_CODPRO', 'Cód. Prod', 'LIKE');
  pAdicionarCampo('SKY_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('SKY_ANOFAB', 'Ano Fabricação', 'LIKE');
  pAdicionarCampo('SKY_CODUNI', 'Código Universal', 'LIKE');
  pAdicionarCampo('SKY_ANUANC', 'Variante', 'LIKE');
  pAdicionarCampo('SKY_CORPAI', 'Cor Pai', 'LIKE');
  pAdicionarCampo('SKY_NACIMP', 'Nacionalidade', 'LIKE');
  pAdicionarCampo('SKY_CONDIL', 'Concentrado', 'LIKE');
  pAdicionarCampo('MON_DESMON', 'Montadora', 'LIKE');
  pAdicionarCampo('GRU_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('SKY_CODGRU', 'Grupo', 'LIKE');
  pAdicionarCampo('SGR_ASPECT', 'Sub Grupo', 'LIKE');
  pAdicionarCampo('SKY_CODMON', 'Cód. Montadora', 'LIKE');
  pAdicionarCampo('SKY_VERSAO', 'Versão', 'LIKE');
  pAdicionarCampo('SKY_CODSGR', 'Cód. SGR', 'LIKE');
  pAdicionarCampo('SKY_VARIAN', 'Variante Cores', 'LIKE');
  pAdicionarCampo('SKY_OBS001', 'Observação', 'LIKE');

  pAdicionarCampo('SKY_MD5KEY', 'MD5KEY', '=', False, True);
  pAdicionarCampo('SKY_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('SKY_FORM' + fStrZero(intCont, 2), 'SKY_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('SKY_QTDB' + fStrZero(intCont, 2), 'SKY_QTDB' + fStrZero(intCont, 2),
      '=', False, False);

    pAdicionarCampo('SKY_QTDC' + fStrZero(intCont, 2), 'SKY_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

destructor TSkyMixConsulta.Destroy;
begin

  inherited;
end;

function TSkyMixConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  Result := Result + fGetCampoAutoIncrem + ', ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';
  Result := Result + fGetSelectFrom;
end;

function TSkyMixConsulta.fGetNomeTabela: String;
begin
  Result := 'SKY_CADSKY';
end;

function TSkyMixConsulta.fGetNomeTinta: String;
begin
  Result := 'SkyMix';
end;

function TSkyMixConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TSkyMixConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + 'FROM ';
  Result := Result + ' 	SKY_CADSKY ';
  Result := Result + ' 	LEFT JOIN SKY_CADMON ON SKY_CODMON = MON_CODMON ';
  Result := Result + ' 	LEFT JOIN SKY_CADGRU ON SKY_CODGRU = GRU_CODGRU ';
  Result := Result + ' 	LEFT JOIN SKY_CADSGR ON SKY_CODSGR = SGR_CODSGR ';
end;

procedure TSkyMixConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('SKY_CODPRO', 00);
  fSetPos('SKY_DESCRI', 01);
  fSetPos('SKY_ANOFAB', 02);
  fSetPos('SKY_CODUNI', 03);
  fSetPos('SKY_ANUANC', 04);
  fSetPos('SKY_CORPAI', 05);
  fSetPos('SKY_NACIMP', 06);
  fSetPos('SKY_CONDIL', 07);
  fSetPos('MON_DESMON', 08);
  fSetPos('GRU_LINHA_', 09);
  fSetPos('SGR_ASPECT', 10);
  fSetPos('SKY_VARIAN', 11);
  fSetPos('SKY_OBS001', 12);

  fSetVisivel('SKY_CODPRO', True);
  fSetVisivel('SKY_DESCRI', True);
  fSetVisivel('SKY_ANOFAB', True);
  fSetVisivel('SKY_CODUNI', True);
  fSetVisivel('SKY_ANUANC', True);
  fSetVisivel('SKY_CORPAI', True);
  fSetVisivel('SKY_NACIMP', True);
  fSetVisivel('SKY_CONDIL', True);
  fSetVisivel('MON_DESMON', True);
  fSetVisivel('GRU_LINHA_', True);
  fSetVisivel('SGR_ASPECT', True);
  fSetVisivel('SKY_VARIAN', True);
  fSetVisivel('SKY_OBS001', True);

  pAdicionarIndice('SKY_DESCRI', 'Descrição');
  pAdicionarIndice('SKY_CODPRO', 'Cód. Prod');
  pAdicionarIndice('SKY_ANOFAB', 'Ano Fabricação');
  pAdicionarIndice('MON_DESMON', 'Montadora');

  pLimparDescricao;
  pAdicionarCampoDescricao('SKY_CODPRO');
  pAdicionarCampoDescricao('SKY_DESCRI');
  pAdicionarCampoDescricao('MON_DESMON');
  pAdicionarCampoDescricao('SKY_CODUNI');
  pAdicionarCampoDescricao('SKY_ANUANC');
end;

end.
