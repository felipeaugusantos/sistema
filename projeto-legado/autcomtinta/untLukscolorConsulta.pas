unit untLukscolorConsulta;

interface

uses
  untTintadeMaquina, SysUtils;

Type
  TLukscolorConsulta = class(TTintadeMaquina) 
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
  End;

implementation

uses
  untFuncoesSimples;

{ TLukscolorConsulta }

constructor TLukscolorConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'LKS';
  strCampoAutoincrem := 'S.AUTOINCREM';

  pAdicionarCampo('S.LKD_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('S.LKD_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('S.LKD_CODIG2', 'Código 2', 'LIKE');
  pAdicionarCampo('S.LKD_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('S.LKD_PROKEY', 'Prod. Key', 'LIKE');
  pAdicionarCampo('S.LKD_SUBKEY', 'Sub. Key', 'LIKE');
  pAdicionarCampo('S.LKD_BASE__', 'Base', 'LIKE');
  pAdicionarCampo('B.BAS_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('I.ITE_CODITE', 'Código do Item', 'LIKE');
  pAdicionarCampo('I.ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('I.ITE_REFERE', 'Referência do Item', 'LIKE');
  
  pAdicionarCampo('B.BAS_BASE__', 'Base', 'LIKE', False, False);
  pAdicionarCampo('B.BAS_PROKEY', 'Base Prod. Key', 'LIKE', False, False);
  pAdicionarCampo('B.BAS_SUBKEY', 'Base Sub. Key', 'LIKE', False, False);
  pAdicionarCampo('B.BAS_UNIDAD', 'Undiade', 'LIKE', False, False);
  pAdicionarCampo('B.BAS_CODITE', 'Código do Item', 'LIKE', False, False);
  pAdicionarCampo('S.LKD_CODITE', 'Referência do Item', 'LIKE', False, False);

  For intCont := 1 To 20 Do
  Begin
    pAdicionarCampo('LKD_FORM' + fStrZero(intCont, 2), 'LKD_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('LKD_QTDB' + fStrZero(intCont, 2), 'LKD_QTDB' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();  
end;

function TLukscolorConsulta.fGetCamposSelect(blnTodos: Boolean): String;
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
  result := result + ' FROM  ';
  result := result + ' 	LKD_CADLKD S  ';
  result := result + ' 	INNER JOIN LKD_CADBAS B ON LKD_PROKEY = BAS_PROKEY ';
  result := result + ' 		AND LKD_SUBKEY = BAS_SUBKEY ';
  result := result + ' 		AND LKD_BASE__ = BAS_BASE__ ';
  result := result + ' 		AND LKD_UNIDAD = BAS_UNIDAD  ';
  result := result + ' 	INNER JOIN CADITE I ON BAS_CODITE = ITE_CODITE ';

end;

function TLukscolorConsulta.fGetNomeTabela: String;
begin
  Result := 'LKD_CADLKD'
end;

function TLukscolorConsulta.fGetNomeTinta: String;
begin
  Result := 'Lukscolor'
end;

function TLukscolorConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

procedure TLukscolorConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('S.LKD_DESCRI', 0);
  fSetPos('S.LKD_CODIGO', 1);
  fSetPos('S.LKD_CODIG2', 2);
  fSetPos('B.BAS_DESCRI', 3);
  fSetPos('S.LKD_UNIDAD', 4);

  fSetVisivel('S.LKD_DESCRI', True);
  fSetVisivel('S.LKD_CODIGO', True);
  fSetVisivel('S.LKD_CODIG2', True);
  fSetVisivel('B.BAS_DESCRI', True);
  fSetVisivel('S.LKD_UNIDAD', True);

  pAdicionarIndice('S.LKD_DESCRI', 'Descrição');
  pAdicionarIndice('S.S.LKD_CODIGO', 'Código');
  pAdicionarIndice('S.S.LKD_CODIGO', 'Código 2');

  pLimparDescricao;
  pAdicionarCampoDescricao('S.LKD_CODIGO');
  pAdicionarCampoDescricao('B.BAS_DESCRI');
  pAdicionarCampoDescricao('S.LKD_CODIG2');
  pAdicionarCampoDescricao('S.LKD_UNIDAD');
end;

end.
