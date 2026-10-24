unit untProcessadorGravandoExecucaoSayerlackBases;

interface

uses
  untAbstractProcessadorGravandoExecucaoSayerlack, SysUtils, Classes, DB,
  Variants, untIGravando;

type
  TProcessadorGravandoExecucaoSayerlackBases = class(TAbstractProcessadorGravandoExecucaoSayerlack)
  protected
    function GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string; override;
  public
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings); override;
    function GetSqlDestino(): string; override;
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean; override;
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet); override;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
      const qryOrigem, qryDestino: TDataSet); override;
    function fGetNomeGravacao(): string; override;
  private
    function fRetornaProduto(strCode, strDescri: String): String;
  end;

implementation
uses untFuncoesSimples, untSayerLackComuns;
{ TProcessadorGravandoExecucaoSayerlackBases }

function TProcessadorGravandoExecucaoSayerlackBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

function TProcessadorGravandoExecucaoSayerlackBases.fRetornaProduto(strCode,
  strDescri: String): String;
begin
  Result := '';
  //BASE BS METALIZADA NÃO ESPECIFICA O TIPO NA DESCRIÇÃO, ESTÁ NO CÓDIGO
  If Pos('WVTI.7601', strCode) > 0 Then
  Begin
    Result := 'IBS'
  End
  Else If Pos('WVTT.7601', strCode) > 0 Then
  Begin
    Result := 'TBS'
  End
  Else If Pos(' BS ', strDescri) > 0 Then
  Begin
    If Pos('TRANSP', strDescri) > 0 Then
      Result := 'TBS'
    Else If Pos('BRANC', strDescri) > 0 Then
      Result := 'BBS'
    Else If Pos('INTERM', strDescri) > 0 Then
      Result := 'IBS'
  End
  Else If Pos(' BA ', strDescri) > 0 Then
  Begin
    If Pos('TRANSP', strDescri) > 0 Then
      Result := 'TBA'
    Else If Pos('BRANC', strDescri) > 0 Then
      Result := 'BBA'
    Else If Pos('INTERM', strDescri) > 0 Then
      Result := 'IBA'
  End;
end;

function TProcessadorGravandoExecucaoSayerlackBases.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM SAY_CADBAS';
end;

function TProcessadorGravandoExecucaoSayerlackBases.GetSqlOrigem(const strNomeArquivo: string; const stlTabelas: TStrings): string;
begin
  Result :=
    ' SELECT                                ' +
    '   B.F1 AS BASE                        ' +
    '   , B.F5 AS CODEBASE                  ' +
    '   , B.F6 AS EMBALA                    ' +
    ' FROM                                  ' +
    '   [BASEPACK$] AS B                    ' +
    ' WHERE B.F5 <> ''BaseCode''            ' ;
end;

procedure TProcessadorGravandoExecucaoSayerlackBases.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'SAY_CADBAS';
end;

procedure TProcessadorGravandoExecucaoSayerlackBases.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SAY_CADBAS', VS_strCodEmp);
  qryDestino.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
  qryDestino.FieldByName('BAS_BASE__').AsString := qryOrigem.FieldByName('BASE').AsString;
  qryDestino.FieldByName('BAS_CODBAS').AsString := qryOrigem.FieldByName('CODEBASE').AsString;
  qryDestino.FieldByName('BAS_DESEMB').AsString := TSayerLackComuns.fRetornaDesUni(qryOrigem.FieldByName('EMBALA').AsString);
  qryDestino.FieldByName('BAS_PRODUT').AsString := fRetornaProduto(qryOrigem.FieldByName('CODEBASE').AsString, qryOrigem.FieldByName('BASE').AsString);
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoSayerlackBases.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('BAS_BASE__;BAS_CODBAS;BAS_PRODUT;BAS_DESEMB',
    VarArrayOf([qryOrigem.FieldByName('BASE').AsString,
      qryOrigem.FieldByName('CODEBASE').AsString,
      fRetornaProduto(qryOrigem.FieldByName('CODEBASE').AsString, qryOrigem.FieldByName('BASE').AsString),
      qryOrigem.FieldByName('EMBALA').AsString]), []);
end;

procedure TProcessadorGravandoExecucaoSayerlackBases.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possível gravar a base [%s %s %s %s], [%s: %s]',
    [qryOrigem.FieldByName('BASE').AsString, qryOrigem.FieldByName('CODEBASE').AsString,
      fRetornaProduto(qryOrigem.FieldByName('CODEBASE').AsString, qryOrigem.FieldByName('BASE').AsString),
      qryOrigem.FieldByName('EMBALA').AsString, e.ClassName, E.Message]);
end;

end.
