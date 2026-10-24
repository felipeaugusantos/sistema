unit untGlasuritSQLServer;

interface

uses SysUtils, ADODB, untFuncoesSimples, StrUtils, Uni, Forms, Classes,
     Data.DB;

Type
  TVariacoesGlasuritSQLServer = class(TObject)
    strIdCor: String;
    strVariacao: String;
  end;

Type
  TGlasuritSQLServer = class(TObject)
    constructor Create(qryCadGla: TUniQuery; intAutInc: Integer);
    procedure pGerarCores;
    function fGetAutInc: Integer;
    destructor Destroy; override;
  private
    qryCadGla: TUniQuery;
    intAutInc: Integer;
    conexao: TADOConnection;
    dicLinha: TDicionario;
    dicMontadora: TDicionario;
    lstVariacoes: TList;
    procedure pGerarUmaCor(adoCores: TADOQuery);
    function fLinhaDaCor(strIdLinha: String): String;
    function fMontadoraDaCor(strIdMontadora: String): String;
    function fAnoDaCor(strAnoInicio, strAnoTermino: String): String;
    function fDescricaoCor(strDescricao, strMaisC: String): String;
    procedure pSalvarVariacoes(strIdCor: String);
    procedure pAtualizarVariacoes;
  end;

Type
  TBasesGlasuritSQLServer = class(TObject)
    constructor Create(qryCadBas: TUniQuery);
    procedure pGerarBases;
  private
    conexao: TADOConnection;
    qryCadBas: TUniQuery;
    stlLinhasBases: TStringList;
    procedure pGerarUmaBase(adoBases: TADOQuery);
    function fEhBaseGlasurit(strLinha: String; adoBases: TADOQuery): Boolean;
  end;

function fCriaConexaoSQLServer: TADOConnection;
function fLinhaDaCorSQLServer(conexao: TADOConnection; strIdLinha: String): String;
function fMontadoraDaCorSQLServer(conexao: TADOConnection; strIdMontadora: String): String;
function fEncontraVariacoes(conexao: TADOConnection; strIdCor: String): TADOQuery;
procedure pEncontraRegistro(qryReg: TADOQuery; strCampo, strValor: String);

implementation

uses untIConfTinta, untFuncTinta;

constructor TGlasuritSQLServer.Create(qryCadGla: TUniQuery; intAutInc: Integer);
begin
  Self.qryCadGla := qryCadGla;
  Self.intAutInc := intAutInc;
  Self.conexao := fCriaConexaoSQLServer;

  dicLinha     := TDicionario.Create;
  dicMontadora := TDicionario.Create;

  lstVariacoes := TList.Create;
end;

procedure TGlasuritSQLServer.pGerarCores;
  Var
    sprCores: TADOStoredProc;
    qryCores: TADOQuery;
begin
  sprCores := TADOStoredProc.Create(conexao);
  sprCores.Connection := conexao;
  sprCores.ProcedureName := 'PRC_INT_COR';
  sprCores.Prepared := True;
  sprCores.Parameters.Refresh;
  sprCores.Parameters.ParamByName('@FG_ATIVO').Value := 1;
  sprCores.Open;

  qryCores := TADOQuery.Create(conexao);
  qryCores.Recordset := sprCores.Recordset;

  While (Not qryCores.Eof) Do
  Begin
    pGerarUmaCor(qryCores);
    qryCores.Next;
    Inc(intAutInc);
    Application.ProcessMessages;
  End;

  pAtualizarVariacoes;

  FreeAndNil(qryCores);
  FreeAndNil(sprCores);
end;

procedure TGlasuritSQLServer.pGerarUmaCor(adoCores: TADOQuery);
  Var
    strLinha: String;
    strMontadora: String;
    qryInsert: TUniQuery;
begin
  strLinha := fLinhaDaCor(adoCores.FieldByName('ID_LINHA_PINTURA').AsString);
  strMontadora := fMontadoraDaCor(adoCores.FieldByName('ID_MONTADORA').AsString);

  If (Pos(strLinha, '22_55_90') > 0) Then
  Begin

    qryInsert := fCriaQuery(Nil);
    qryInsert.SQL.Add('INSERT DELAYED INTO GLA_CADGLA (');
    qryInsert.SQL.Add('  GLA_CODSEQ, ');
    qryInsert.SQL.Add('  GLA_LINHA_, ');
    qryInsert.SQL.Add('  GLA_MONTAD, ');
    qryInsert.SQL.Add('  GLA_DESCRI, ');

    qryInsert.SQL.Add('  GLA_CODPRO, ');
    qryInsert.SQL.Add('  GLA_ANOCOR, ');

    qryInsert.SQL.Add('  GLA_VARIAC, ');
    qryInsert.SQL.Add('  GLA_CODEMP, ');
    qryInsert.SQL.Add('  AUTOINCREM, ');
    qryInsert.SQL.Add('  GLA_PASSO_, ');
    qryInsert.SQL.Add('  GLA_RES325) ');

    qryInsert.SQL.Add('VALUES (');
    qryInsert.SQL.Add('  :GLA_CODSEQ, ');
    qryInsert.SQL.Add('  :GLA_LINHA_, ');
    qryInsert.SQL.Add('  :GLA_MONTAD, ');
    qryInsert.SQL.Add('  :GLA_DESCRI, ');

    qryInsert.SQL.Add('  :GLA_CODPRO, ');
    qryInsert.SQL.Add('  :GLA_ANOCOR, ');

    qryInsert.SQL.Add('  :GLA_VARIAC, ');
    qryInsert.SQL.Add('  :GLA_CODEMP, ');
    qryInsert.SQL.Add('  :AUTOINCREM, ');
    qryInsert.SQL.Add('  :GLA_PASSO_, ');
    qryInsert.SQL.Add('  :GLA_RES325) ');

    qryInsert.ParamByName('GLA_CODSEQ').AsString  := adoCores.FieldByName('ID_COR').AsString;
    qryInsert.ParamByName('GLA_LINHA_').AsString  := strLinha;
    qryInsert.ParamByName('GLA_MONTAD').AsString  := strMontadora;
    qryInsert.ParamByName('GLA_DESCRI').AsString  := fDescricaoCor(adoCores.FieldByName('DS_COR').AsString,
                                                                   adoCores.FieldByName('FG_MAIS_C').AsString);
    qryInsert.ParamByName('GLA_CODPRO').AsString  := adoCores.FieldByName('DS_COD_COR_BASF').AsString;
    qryInsert.ParamByName('GLA_ANOCOR').AsString  := fAnoDaCor(adoCores.FieldByName('NR_ANO_INICIO').AsString,
                                                               adoCores.FieldByName('NR_ANO_TERMINO').AsString);
    qryInsert.ParamByName('GLA_VARIAC').AsString  := '';
    qryInsert.ParamByName('GLA_CODEMP').AsString  := VS_strCodEmp;
    qryInsert.ParamByName('AUTOINCREM').AsString  := fFormataAutInc(intAutInc, VS_strCodEmp);
    qryInsert.ParamByName('GLA_PASSO_').AsString  := adoCores.FieldByName('NR_SOLUTION_ACTUAL_STEP').AsString;
    qryInsert.ParamByName('GLA_RES325').AsInteger := IIF(StrToBoolDef(adoCores.FieldByName('FG_VARIACOES').AsString, False), 1, 0);
    qryInsert.ExecSQL;
    FreeAndNil(qryInsert);

    pSalvarVariacoes(adoCores.FieldByName('ID_COR').AsString);
  End;
end;

procedure TGlasuritSQLServer.pAtualizarVariacoes;
  Var
    intContador: Integer;
    variacao: TVariacoesGlasuritSQLServer;
    qryUpd: TUniQuery;
begin
  qryUpd := fCriaQuery(Nil);
  qryUpd.SQL.Add('UPDATE GLA_CADGLA SET GLA_VARIAC = :VARIAC WHERE GLA_CODSEQ = :CODSEQ');
  
  For intContador := 0 To lstVariacoes.Count -1 Do
  Begin
    variacao := TVariacoesGlasuritSQLServer(lstVariacoes[intContador]);

    qryUpd.Close;
    qryUpd.ParamByName('VARIAC').AsString := variacao.strVariacao;
    qryUpd.ParamByName('CODSEQ').AsString := variacao.strIdCor;
    qryUpd.ExecSQL;

    Application.ProcessMessages;
  End;
end;

procedure TGlasuritSQLServer.pSalvarVariacoes(strIdCor: String);
  Var
    qryVariac: TADOQuery;
    variacao: TVariacoesGlasuritSQLServer;
begin
  qryVariac := fEncontraVariacoes(conexao, strIdCor);
  While (Not qryVariac.Eof) Do
  Begin
    variacao := TVariacoesGlasuritSQLServer.Create;
    variacao.strIdCor := qryVariac.FieldByName('ID_COR_VARIACAO').AsString;
//    variacao.strVariacao := qryVariac.FieldByName('DS_VARIACAO').AsString;
    variacao.strVariacao := qryVariac.FieldByName('DS_CODIGO_VARIACAO').AsString;

    lstVariacoes.Add(variacao);

    qryVariac.Next;
  End;

  FreeAndNil(qryVariac);
end;

function TGlasuritSQLServer.fGetAutInc: Integer;
begin
  Result := intAutInc;
end;

function TGlasuritSQLServer.fLinhaDaCor(strIdLinha: String): String;
begin
  Result := IfNull(dicLinha[strIdLinha], '');
  If fEmptyStr(Result) Then
  Begin
    Result := fLinhaDaCorSQLServer(conexao, strIdLinha);
    dicLinha[strIdLinha] := Result;
  End;
end;

function TGlasuritSQLServer.fMontadoraDaCor(strIdMontadora: String): String;
begin
  Result := IfNull(dicLinha[strIdMontadora], '');
  If fEmptyStr(Result) Then
  Begin
    Result := fMontadoraDaCorSQLServer(conexao, strIdMontadora);
    dicLinha[strIdMontadora] := Result;
  End;
end;

function TGlasuritSQLServer.fDescricaoCor(strDescricao, strMaisC: String): String;
begin
  Result := strDescricao;
  If StrToBoolDef(strMaisC, False) Then
    Result := Result + ' +C';
end;

function TGlasuritSQLServer.fAnoDaCor(strAnoInicio, strAnoTermino: String): String;
begin
  If StrToIntDef(strAnoInicio, 0) <= 0 Then
    Result := ''
  Else
    Result := strAnoInicio + '/' + strAnoTermino;
end;

destructor TGlasuritSQLServer.Destroy;
  Var
    variacao: TVariacoesGlasuritSQLServer;
    intContador: Integer;
begin
  FreeAndNil(conexao);

  For intContador := 0 To lstVariacoes.Count -1 Do
  Begin
    variacao := TVariacoesGlasuritSQLServer(lstVariacoes[intContador]);
    FreeAndNil(variacao);
  End;

  lstVariacoes.Clear;
  FreeAndNil(lstVariacoes);
  inherited;
end;

{ TBasesGlasuritSQLServer }

constructor TBasesGlasuritSQLServer.Create(qryCadBas: TUniQuery);
begin
  Self.qryCadBas := qryCadBas;
  Self.conexao := fCriaConexaoSQLServer;

  stlLinhasBases := TStringList.Create;
  stlLinhasBases.Add('22');
  stlLinhasBases.Add('55');
  stlLinhasBases.Add('90');
end;

procedure TBasesGlasuritSQLServer.pGerarBases;
  Var
    sprBases: TADOStoredProc;
    qryBases: TADOQuery;
begin
  sprBases := TADOStoredProc.Create(conexao);
  sprBases.Connection := conexao;
  sprBases.ProcedureName := 'PRC_INT_PRODUTO';
  sprBases.Open;

  qryBases := TADOQuery.Create(conexao);
  qryBases.Recordset := sprBases.Recordset;

  While (Not qryBases.Eof) Do
  Begin
    pGerarUmaBase(qryBases);
    qryBases.Next;
    Application.ProcessMessages;
  End;

  FreeAndNil(qryBases);
  FreeAndNil(sprBases);
end;

procedure TBasesGlasuritSQLServer.pGerarUmaBase(adoBases: TADOQuery);
  Var
    strLinha: String;
    qryCadBas: TUniQuery;
begin
  strLinha := fLinhaDaCorSQLServer(conexao, adoBases.FieldByName('ID_LINHA_PINTURA').AsString);
  If fEhBaseGlasurit(LeftStr(strLinha,2), adoBases) Then
  Begin
    qryCadBas := fCriaQuery(Nil);
    qryCadBas.SQL.Add('SELECT * FROM GLA_CADBAS WHERE BAS_CODBAS = :CODBAS AND BAS_LINHA_ = :LINHA_');
    qryCadBas.ParamByName('CODBAS').AsString := adoBases.FieldByName('DS_CODIGO_ITEM').AsString;
    qryCadBas.ParamByName('LINHA_').AsString := LeftStr(strLinha,2);    
    qryCadBas.Open;

    If qryCadBas.IsEmpty Then
    Begin
      qryCadBas.Append;
      qryCadBas.FieldByName('BAS_CODBAS').AsString := adoBases.FieldByName('DS_CODIGO_ITEM').AsString;
      qryCadBas.FieldByName('BAS_LINHA_').AsString := LeftStr(strLinha,2);      
      qryCadBas.FieldByName('BAS_DESBAS').AsString := adoBases.FieldByName('DS_ITEM_COMERCIAL').AsString;
      qryCadBas.FieldByName('BAS_PESBAS').AsFloat  := adoBases.FieldByName('VL_PESO_ESPECIFICO').AsFloat;
      qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := adoBases.FieldByName('VL_VOLUME').AsFloat*1000;
      qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('GLA_CADBAS', VS_strCodEmp);
      qryCadBas.Post;
    End;

    FreeAndNil(qryCadBas);
  End;
end;

function TBasesGlasuritSQLServer.fEhBaseGlasurit(strLinha: String;
  adoBases: TADOQuery): Boolean;
begin
  Result := (stlLinhasBases.IndexOf(strLinha) >= 0)                                         And
            (fStrToFloat(adoBases.FieldByName('VL_PESO_ESPECIFICO').AsString) > 0) And
            (Not fEmptyStr(adoBases.FieldByName('DS_CODIGO_ITEM').AsString));
end;

function fCriaConexaoSQLServer: TADOConnection;
  Var
    strConect: String;
    strSenha: String;
    strUsuario: String;
    strDatabase: String;
    strHost: String;
    conf: IConfTinta;
begin
  conf        := fGetConfTinta('GLA');
  strSenha    := conf.fGet('SENSQS');
  strUsuario  := conf.fGet('USUSQS');
  strDatabase := conf.fGet('DATSQS');
  strHost     := conf.fGet('HOSSQS');

  strConect := 'Provider=SQLOLEDB.1;Password=SENHA;Persist Security Info=True;User ID=USUARIO;Initial Catalog=DATABASE;Data Source=LOCALHOST';
  strConect := AnsiReplaceStr(strConect, 'SENHA', strSenha);
  strConect := AnsiReplaceStr(strConect, 'USUARIO', strUsuario);
  strConect := AnsiReplaceStr(strConect, 'DATABASE', strDatabase);
  strConect := AnsiReplaceStr(strConect, 'LOCALHOST', strHost);

  Result := TADOConnection.Create(Nil);
  Result.LoginPrompt := False;
  Result.Provider := 'SQLOLEDB.1';
  Result.ConnectionString := strConect;
end;

function fLinhaDaCorSQLServer(conexao: TADOConnection; strIdLinha: String): String;
  Var
    sprLinha: TADOStoredProc;
    qryLinha: TADOQuery;
begin
  sprLinha := TADOStoredProc.Create(conexao);
  sprLinha.Connection := conexao;
  sprLinha.ProcedureName := 'PRC_INT_LINHA_PINTURA';
  sprLinha.Open;

  qryLinha := TADOQuery.Create(conexao);
  qryLinha.Recordset := sprLinha.Recordset;
  pEncontraRegistro(qryLinha, 'ID_LINHA_PINTURA', strIdLinha);
//  Result := qryLinha.FieldByName('DS_LINHA_PINTURA').AsString;
  Result := qryLinha.FieldByName('DS_CODIGO_LINHA_PINTURA').AsString;

  FreeAndNil(qryLinha);
  FreeAndNil(sprLinha);
end;

function fMontadoraDaCorSQLServer(conexao: TADOConnection; strIdMontadora: String): String;
  Var
    sprMontad: TADOStoredProc;
    qryMontad: TADOQuery;
begin
  sprMontad := TADOStoredProc.Create(conexao);
  sprMontad.Connection := conexao;
  sprMontad.ProcedureName := 'PRC_INT_MONTADORA';
  sprMontad.Open;

  qryMontad := TADOQuery.Create(conexao);
  qryMontad.Recordset := sprMontad.Recordset;
  pEncontraRegistro(qryMontad, 'ID_MONTADORA', strIdMontadora);
  Result := qryMontad.FieldByName('DS_MONTADORA').AsString;

  FreeAndNil(qryMontad);
  FreeAndNil(sprMontad);
end;

procedure pEncontraRegistro(qryReg: TADOQuery; strCampo,
  strValor: String);
begin

  qryReg.First;
  While (Not qryReg.Eof) Do
  Begin
    If (qryReg.FieldByName(strCampo).AsString = strValor) Then
    Begin
      Break;
    End;
    qryReg.Next;
  End;

end;

function fEncontraVariacoes(conexao: TADOConnection; strIdCor: String): TADOQuery;
  Var
    sprVariac: TADOStoredProc;
    qryVariac: TADOQuery;
begin
  sprVariac := TADOStoredProc.Create(conexao);
  sprVariac.Connection := conexao;
  sprVariac.ProcedureName := 'PRC_INT_RETORNA_VARIACOES_FORMULA';
  sprVariac.Prepared := True;
  sprVariac.Parameters.Refresh;
  sprVariac.Parameters.ParamByName('@ID_COR').Value := strIdCor;
  sprVariac.Open;

  qryVariac := TADOQuery.Create(conexao);
  qryVariac.Recordset := sprVariac.Recordset;

  Result := qryVariac;

  FreeAndNil(sprVariac);
end;

end.

