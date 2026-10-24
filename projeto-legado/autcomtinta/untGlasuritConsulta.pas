unit untGlasuritConsulta;

interface


uses
  untTintadeMaquina, SysUtils,
  Classes, untIConfTinta;

Type
  TGlasuritConsulta = class(TTintadeMaquina)
  private
    conf: IConfTinta;
    function fModoFormulacaoIndireto: Boolean;
  protected
    function fGetSelectFrom: String; override;
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
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  untFuncoesGenerica,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untTintaMaquina;

{ TGlasuritConsulta }

constructor TGlasuritConsulta.Create;
  Var
    intCont: Integer;
begin
  inherited Create;
  strIdePro := 'GLA';
  strCampoAutoincrem := 'GLA_CADGLA.AUTOINCREM';
  conf := fGetConfTinta('GLA');

  pAdicionarCampo('GLA_DESCRI', 'Descrição', 'LIKE');
  pAdicionarCampo('GLA_CODPRO', 'Código', 'LIKE');
  pAdicionarCampo('GLA_MONTAD', 'Montadora', 'LIKE');
  pAdicionarCampo('GLA_VARIAC', 'Variação', 'LIKE');
  pAdicionarCampo('GLA_LINHA_', 'Linha', 'LIKE');
  pAdicionarCampo('GLA_ANOCOR', 'Ano', 'LIKE');
  pAdicionarCampo('GLA_PASSO_', 'Passo', '=');

  If Not fModoFormulacaoIndireto Then
  Begin
    pAdicionarCampo('GLA_CODSEQ', 'Cód. Seq.', 'LIKE');
  End
  Else
  Begin
    pAdicionarCampo('GLA_CODSEQ', 'Cód. Seq.', 'LIKE', False, False);
  End;

  pAdicionarCampo('GLA_ACRMOB', 'Acréscimo mão de obra', 'LIKE', False, False);

  for intCont := 1 to 20 do
  begin
    pAdicionarCampo('GLA_FORM' + fStrZero(intCont, 2),  'GLA_FORM' + fStrZero(intCont, 2),
          'LIKE', False, False);

    pAdicionarCampo('GLA_QTDB' + fStrZero(intCont, 2),  'GLA_QTDB' + fStrZero(intCont, 2),
          '=', False, False);

    pAdicionarCampo('GLA_QTDD' + fStrZero(intCont, 2),  'GLA_QTDD' + fStrZero(intCont, 2),
          '=', False, False);
  end;

  pAbrirTabelaConfs();
end;


function TGlasuritConsulta.fGetNomeTabela: String;
begin
  Result := 'GLA_CADGLA';
end;

function TGlasuritConsulta.fGetNomeTinta: String;
begin
  Result := 'Glasurit';
end;

function TGlasuritConsulta.fGetSelect(blnTodos: Boolean): String;
begin
  Inherited fGetSelect(blnTodos);
  Result := fGetCamposSelect(blnTodos) + fGetWhere;
end;

function TGlasuritConsulta.fGetCamposSelect(blnTodos: Boolean): String;
  Var
    intCont: Integer;
begin
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

function TGlasuritConsulta.fGetSelectFrom: String;
begin
  Result := '';
  Result := Result + ' FROM GLA_CADGLA ';
end;

Procedure TGlasuritConsulta.pGetSelectCxGrid(blnTodos: Boolean;
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

  strSql := strSql + fGetSelectFrom;

  arrSelect[0] := strSql;

  strSql := '';

  strSql := strSql + ' WHERE ';
  strSql := strSql + '   TRUE ';

  arrSelect[1] := strSql;

  SetLength(arrNomCol, stlNomCol.Count);
  For intCont := 0 To stlNomCol.Count - 1 Do
    arrNomCol[intCont] := stlNomCol[intCont];

  FreeAndNil(stlNomCol);
End;

procedure TGlasuritConsulta.pRestaurarPadrao;
begin
  Inherited pRestaurarPadrao;

  fSetPos('GLA_DESCRI', 0);
  fSetPos('GLA_CODPRO', 1);
  fSetPos('GLA_MONTAD', 2);
  fSetPos('GLA_VARIAC', 3);
  fSetPos('GLA_LINHA_', 4);
  fSetPos('GLA_ANOCOR', 5);

//  If Not fModoFormulacaoIndireto Then
//  Begin
    fSetPos('GLA_CODSEQ', 6);
//  End;


  fSetVisivel('GLA_DESCRI', True);
  fSetVisivel('GLA_CODPRO', True);
  fSetVisivel('GLA_MONTAD', True);
  fSetVisivel('GLA_VARIAC', True);
  fSetVisivel('GLA_LINHA_', True);
  fSetVisivel('GLA_ANOCOR', True);

  If Not fModoFormulacaoIndireto Then
  Begin
    fSetVisivel('GLA_CODSEQ', True);
  End
  Else
  Begin
    fSetVisivel('GLA_CODSEQ', False);
  End;


  pAdicionarIndice('GLA_DESCRI+GLA_MONTAD', 'Descrição/Montadora');
  pAdicionarIndice('GLA_CODPRO', 'Código');
  pAdicionarIndice('GLA_MONTAD', 'Montadora');
  pAdicionarIndice('GLA_LINHA_', 'Linha');

  If Not fModoFormulacaoIndireto Then
  Begin
    pAdicionarIndice('GLA_CODSEQ', 'Cód. Seq.');
  End;


  pLimparDescricao;
  pAdicionarCampoDescricao('GLA_DESCRI');
  pAdicionarCampoDescricao('GLA_CODPRO');
  pAdicionarCampoDescricao('GLA_MONTAD');
  pAdicionarCampoDescricao('GLA_VARIAC');
  pAdicionarCampoDescricao('GLA_LINHA_');
  pAdicionarCampoDescricao('GLA_ANOCOR');

  If Not fModoFormulacaoIndireto Then
  Begin
    pAdicionarCampoDescricao('GLA_CODSEQ');
  End;

end;

function TGlasuritConsulta.fModoFormulacaoIndireto: Boolean;
begin
  Result := conf.fGet('CALFOR') = '1';
end;

end.
