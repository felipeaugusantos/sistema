unit untDacarConsulta;

interface
uses
  untTintadeMaquina, SysUtils;

Type
  TDacarConsulta = class(TTintadeMaquina)
  protected
    function fGetSelectFrom: String; Override;
  public
    constructor Create; override;
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    function fGetWhere: String;Override;
    destructor Destroy; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
  End;
implementation

uses untFuncoesSimples;

{ TDacarConsulta }

constructor TDacarConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited;

  strIdePro := 'DAC';
  strCampoAutoincrem := 'D.AUTOINCREM';

  pAdicionarCampo('D.DAC_DESCRI', 'Descricao', 'LIKE');
  pAdicionarCampo('D.DAC_REFERE', 'Referencia', 'LIKE');
  pAdicionarCampo('D.DAC_COLECA', 'Coleção', 'LIKE');
  pAdicionarCampo('D.DAC_CODCOR', 'Cód. Cor', 'LIKE');
  pAdicionarCampo('D.DAC_CODUNI', 'Unidade', 'LIKE');
  pAdicionarCampo('D.DAC_CODITE', 'Cód. Item', 'LIKE', False, False);
  pAdicionarCampo('D.DAC_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('D.DAC_CODFML', 'Fórmula', 'LIKE');
  pAdicionarCampo('D.DAC_EMBALA', 'Embalagem', 'LIKE');
  pAdicionarCampo('D.DAC_PROCOD', 'Pro. Cod.', 'LIKE');
  pAdicionarCampo('I.ITE_DESITE', 'Descrição Item', 'LIKE');
  pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('I.ITE_REFERE', 'Referência do Item', 'LIKE');

  For intCont := 1 To 15 Do
  Begin
    pAdicionarCampo('DAC_FORM' + fStrZero(intCont, 2), 'DAC_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('DAC_QTDB' + fStrZero(intCont, 2), 'DAC_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();

end;

destructor TDacarConsulta.Destroy;
begin

  inherited;
end;

function TDacarConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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

function TDacarConsulta.fGetNomeTabela: String;
begin
  Result := 'DAC_CADDAC';
end;

function TDacarConsulta.fGetNomeTinta: String;
begin
  Result := 'Dacar';
end;

function TDacarConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TDacarConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + 'FROM  ';
  Result := Result + '	DAC_CADDAC D ';
  Result := Result + '	INNER JOIN DAC_UNIDAC U ';
  Result := Result + '	ON D.DAC_CODUNI = U.DAC_UNIAUT ';
  Result := Result + '	INNER JOIN DAC_CADBAS B ';
  Result := Result + '	ON D.DAC_CODFML = B.BAS_CODFML ';
  Result := Result + '	AND B.BAS_UNIDAD = D.DAC_CODUNI ';
  Result := Result + '	AND B.BAS_BASE__ = D.DAC_CODBAS ';
  Result := Result + '  INNER JOIN CADITE I ';
  Result := Result + '  ON B.BAS_CODITE = I.ITE_CODITE ';
end;

function TDacarConsulta.fGetWhere: String;
begin
  Result := Result + ' WHERE TRUE ';

  If (fArqIniTinta(0, 'USA_FORMUL', 'DAC', 'S') = 'S') Then
    Result := Result + '     AND D.DAC_QTDB01 > 0.0 ';
end;

procedure TDacarConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('D.DAC_DESCRI', 0);
  fSetPos('D.DAC_REFERE', 1);
  fSetPos('D.DAC_COLECA', 2);
  fSetPos('D.DAC_CODCOR', 3);
  fSetPos('D.DAC_CODUNI', 4);
  fSetPos('I.ITE_CODITE', 5);
  fSetPos('I.ITE_DESITE', 6);

  fSetVisivel('D.DAC_DESCRI', True);
  fSetVisivel('D.DAC_REFERE', True);
  fSetVisivel('D.DAC_COLECA', True);
  fSetVisivel('D.DAC_CODCOR', True);
  fSetVisivel('D.DAC_CODUNI', True);
  fSetVisivel('I.ITE_CODITE', True);
  fSetVisivel('I.ITE_DESITE', True);

  pAdicionarIndice('D.DAC_DESCRI+D.DAC_REFERE', 'Descricao/Referencia');
  pAdicionarIndice('D.DAC_COLECA+D.DAC_CODCOR', 'Coleção/Cód. Cor');
  pAdicionarIndice('D.DAC_REFERE', 'Referencia');
  pAdicionarIndice('I.ITE_DESITE', 'Descrição Item');

  pLimparDescricao;
  pAdicionarCampoDescricao('D.DAC_DESCRI');
  pAdicionarCampoDescricao('D.DAC_REFERE');
  pAdicionarCampoDescricao('D.DAC_CODUNI');

end;

end.
