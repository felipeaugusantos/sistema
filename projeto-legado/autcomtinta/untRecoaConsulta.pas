unit untRecoaConsulta;

interface

uses
  untTintadeMaquina, SysUtils,
  Classes;

Type
  TRecoaConsulta = class(TTintadeMaquina) 
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetCamposSelect(blnTodos: Boolean): String; override;
    constructor Create; override;
    procedure pRestaurarPadrao; override;
    function fGetNomeTabela: String; override;
    function fGetNomeTinta: String; override;
    
    Procedure pGetSelectCxGrid(blnTodos: Boolean; Var arrSelect, arrNomCol: TArrString); override;
  End;

implementation

uses
  untFuncoesSimples;

{ TRecoaConsulta }

constructor TRecoaConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'REC';
  strCampoAutoincrem := 'REC_CADREC.AUTOINCREM';

  pAdicionarCampo('REC_DESCRI', 'Descrição da Tinta', 'LIKE', False, False);
  pAdicionarCampo('BAS_DESCRI', 'Descrição da Base', 'LIKE');
  pAdicionarCampo('REC_CODIGO', 'Código', 'LIKE');
  pAdicionarCampo('REC_UNIDAD', 'Unidade', 'LIKE');
  pAdicionarCampo('REC_CODBAS', 'Base', 'LIKE');
  pAdicionarCampo('REC_CODUNI', 'Unidade', 'LIKE', False, False);
  pAdicionarCampo('REC_CODEMB', 'Embalagem', 'LIKE');
  pAdicionarCampo('BAS_PRODUT', 'Produto', 'LIKE');
  pAdicionarCampo('BAS_CODITE', 'Cód. Item', 'LIKE');
  pAdicionarCampo('ITE_CODITE', 'Cód. Item', 'LIKE', False, False);
  pAdicionarCampo('ITE_DESITE', 'Descrição do Item', 'LIKE');
  pAdicionarCampo('REC_MD5KEY', 'MD5KEY', '=', False, True);

  For intCont := 1 To 10 Do
  Begin
    pAdicionarCampo('REC_FORM' + fStrZero(intCont, 2), 'REC_FORM' + fStrZero(intCont, 2),
      'LIKE', False, False);

    pAdicionarCampo('REC_QTDC' + fStrZero(intCont, 2), 'REC_QTDC' + fStrZero(intCont, 2),
      '=', False, False);
  End;

  pAbrirTabelaConfs();
end;

function TRecoaConsulta.fGetCamposSelect(blnTodos: Boolean): String;
  Var
    intCont: Integer;
begin
  Result := '';
  Result := Result + ' SELECT '  + #$D#$A;

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos
      Or (fGetdisponivel(intCont)) Then
      Result := Result + ' ' + fGetNomeCampoColuna(intCont) + #$D#$A + ', ';
  End;
  Result := Result + fGetCampoAutoIncrem + ', ';
  Result := Copy(Result, 1, LastDelimiter(',', Result) - 1) + ' ';
  Result := Result + ' FROM REC_CADREC ';
  Result := Result + '   INNER JOIN REC_CADBAS ';
  Result := Result + '     ON REC_CODBAS = BAS_BASE__ ';
  Result := Result + '       AND REC_CODUNI = BAS_UNIDAD ';
  Result := Result + '   INNER JOIN CADITE ';
  Result := Result + '     ON BAS_CODITE = ITE_CODITE ';
end;

function TRecoaConsulta.fGetNomeTabela: String;
begin
  Result := 'REC_CADREC';
end;

function TRecoaConsulta.fGetNomeTinta: String;
begin
  Result := 'Recoa';
end;

function TRecoaConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result :=  fGetCamposSelect(blnTodos) + fGetWhere;
end;

Procedure TRecoaConsulta.pGetSelectCxGrid(blnTodos: Boolean;
   Var arrSelect, arrNomCol: TArrString);
  Var
    intCont: Integer;
    strSql: String;
    stlNomCol: TStringList;
begin
  Inherited pGetSelectCxGrid(blnTodos, arrSelect, arrNomCol);

  stlNomCol := TStringList.Create;
  SetLength(arrSelect, 2);

  strSql := '';
  strSql := strSql + ' SELECT ' + fGetCampoAutoIncrem + ', ';

  stlNomCol.Add('AUTOINCREM');

  For intCont := 0 To fGetQtdColunas - 1 Do
  Begin
    If blnTodos  Or (fGetdisponivel(intCont) And fGetVisivel(intCont)) Then
    Begin
      strSql := strSql + ' ' + fGetNomeCampoColuna(intCont) + ', ';
      stlNomCol.Add(fGetCaptionColuna(intCont));
    End;
  End;

  strSql := Copy(strSql, 1, LastDelimiter(',', strSql) - 1) + ' ';

  strSql := strSql + ' FROM REC_CADREC ';
  strSql := strSql + '   INNER JOIN REC_CADBAS ';
  strSql := strSql + '     ON REC_CODBAS = BAS_BASE__ ';
  strSql := strSql + '       AND REC_CODUNI = BAS_UNIDAD ';
  strSql := strSql + '   INNER JOIN CADITE ';
  strSql := strSql + '     ON BAS_CODITE = ITE_CODITE ';

  arrSelect[0] := strSql;

  strSql := '';

  strSql := strSql + ' WHERE TRUE ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
End;

procedure TRecoaConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('BAS_DESCRI', 0);
  fSetPos('REC_UNIDAD', 1);
  fSetPos('REC_CODIGO', 2);
  fSetPos('BAS_CODITE', 3);
  fSetPos('ITE_DESITE', 4);

  fSetVisivel('BAS_DESCRI', True);
  fSetVisivel('REC_UNIDAD', True);
  fSetVisivel('REC_CODIGO', True);
  fSetVisivel('BAS_CODITE', True);
  fSetVisivel('ITE_DESITE', True);

  pAdicionarIndice('BAS_DESCRI+REC_UNIDAD', 'Descrição da Base/Unidade');
  pAdicionarIndice('REC_UNIDAD', 'Unidade');
  pAdicionarIndice('REC_CODIGO', 'Código');
  pAdicionarIndice('BAS_CODITE', 'Cód. Item');
  pAdicionarIndice('ITE_DESITE', 'Descrição do Item');  

  pLimparDescricao;
  pAdicionarCampoDescricao('REC_UNIDAD');
end;

end.

