unit untSalcomixSQLServer;

interface

uses SysUtils, ADODB, untFuncoesSimples, StrUtils, Uni, Forms, Classes,
    Data.DB;

Type
  TVariacoesSalcomixSQLServer = class(TObject)
    strIdCor: String;
    strVariacao: String;
  end;

Type
  TSalcomixSQLServer = class(TObject)
  private
    qryCadSal: TUniQuery;
    intAutInc: Integer;
    conexao: TADOConnection;
    dicLinha: TDicionario;
    dicMontadora: TDicionario;
    lstVariacoes: TList;
    dicVariacoes: TDicionario;
    procedure pGerarUmaCor(adoCores: TADOQuery);
    function fLinhaDaCor(strIdLinha: String): String;
    function fMontadoraDaCor(strIdMontadora: String): String;
    function fAnoDaCor(strAnoInicio, strAnoTermino: String): String;
    function fDescricaoCor(strDescricao, strMaisC: String): String;
    procedure ConstruirVariacoes;
    function GetVariacao(const strIDCor: string): string;
  public
    constructor Create(qryCadSal: TUniQuery; intAutInc: Integer);
    procedure pGerarCores;
    function fGetAutInc: Integer;
    destructor Destroy; override;
  end;

Type
  TBasesSalcomixSQLServer = class(TObject)
    constructor Create(qryCadBas: TUniQuery);
    procedure pGerarBases;
  private
    conexao: TADOConnection;
    qryCadBas: TUniQuery;
    stlLinhasBases: TStringList;
    procedure pGerarUmaBase(adoBases: TADOQuery);
    function fEhBaseSalcomix(strLinha: String; adoBases: TADOQuery): Boolean;
  end;

function fCriaConexaoSQLServer: TADOConnection;
function fLinhaDaCorSQLServer(conexao: TADOConnection; strIdLinha: String): String;
function fMontadoraDaCorSQLServer(conexao: TADOConnection; strIdMontadora: String): String;
function fEncontraVariacoes(conexao: TADOConnection; strIdCor: String): TADOQuery;
procedure pEncontraRegistro(qryReg: TADOQuery; strCampo, strValor: String);

implementation
uses  untIConfTinta, untFuncTinta;
procedure TSalcomixSQLServer.ConstruirVariacoes;
begin
  dicVariacoes['A9'] := 'mais sujo, mais claro';
  dicVariacoes['29'] := 'mais grosso, mais claro';
  dicVariacoes['B3'] := 'mais limpo, mais sujo';
  dicVariacoes['B7'] := 'mais limpo, mais verde';
  dicVariacoes['6A'] := 'mais amarelo, mais sujo';
  dicVariacoes['73'] := 'mais verde, mais fino';
  dicVariacoes['2B'] := 'mais grosso, mais limpo';
  dicVariacoes['A3'] := 'mais sujo, mais fino';
  dicVariacoes['22'] := 'mais grosso, mais grosso';
  dicVariacoes['62'] := 'mais amarelo, mais grosso';
  dicVariacoes['28'] := 'mais grosso, mais vermelho';
  dicVariacoes['45'] := 'mais escuro, mais azul';
  dicVariacoes['34'] := 'mais fino, mais escuro';
  dicVariacoes['80'] := 'mais vermelho';
  dicVariacoes['B6'] := 'mais limpo, mais amarelo';
  dicVariacoes['79'] := 'mais verde, mais claro';
  dicVariacoes['67'] := 'mais amarelo, mais verde';
  dicVariacoes['74'] := 'mais verde, mais escuro';
  dicVariacoes['83'] := 'mais vermelho, mais fino';
  dicVariacoes['30'] := 'mais fino';
  dicVariacoes['55'] := 'mais azul, mais azul';
  dicVariacoes['97'] := 'mais claro, mais verde';
  dicVariacoes['52'] := 'mais azul, mais grosso';
  dicVariacoes['72'] := 'mais verde, mais grosso';
  dicVariacoes['A8'] := 'mais sujo, mais vermelho';
  dicVariacoes['40'] := 'mais escuro';
  dicVariacoes['36'] := 'mais fino, mais amarelo';
  dicVariacoes['84'] := 'mais vermelho, mais escuro';
  dicVariacoes['85'] := 'mais vermelho, mais azul';
  dicVariacoes['68'] := 'mais amarelo, mais vermelho';
  dicVariacoes['88'] := 'mais vermelho, mais vermelho';
  dicVariacoes['B0'] := 'mais limpo';
  dicVariacoes['98'] := 'mais claro, mais vermelho';
  dicVariacoes['86'] := 'mais vermelho, mais amarelo';
  dicVariacoes['94'] := '94';
  dicVariacoes['B2'] := 'mais limpo, mais grosso';
  dicVariacoes['4A'] := 'mais escuro, mais sujo';
  dicVariacoes['3B'] := 'mais fino, mais limpo';
  dicVariacoes['27'] := 'mais grosso, mais verde';
  dicVariacoes['7A'] := 'mais verde, mais sujo';
  dicVariacoes['48'] := 'mais escuro, mais vermelho';
  dicVariacoes['39'] := 'mais fino, mais claro';
  dicVariacoes['44'] := 'mais escuro, mais escuro';
  dicVariacoes['57'] := 'mais azul, mais verde';
  dicVariacoes['99'] := 'mais claro, mais claro';
  dicVariacoes['75'] := 'mais verde, mais azul';
  dicVariacoes['54'] := 'mais azul, mais escuro';
  dicVariacoes['20'] := 'mais grosso';
  dicVariacoes['9B'] := 'mais claro, mais limpo';
  dicVariacoes['7B'] := 'mais verde, mais limpo';
  dicVariacoes['47'] := 'mais escuro, mais verde';
  dicVariacoes['66'] := 'mais amarelo, mais amarelo';
  dicVariacoes['8B'] := 'mais vermelho, mais limpo';
  dicVariacoes['2A'] := 'mais grosso, mais sujo';
  dicVariacoes['70'] := 'mais verde';
  dicVariacoes['A2'] := 'mais sujo. mais grosso';
  dicVariacoes['33'] := 'mais fino, mais fino';
  dicVariacoes['65'] := 'mais amarelo, mais azul';
  dicVariacoes['35'] := 'mais fino, mais azul';
  dicVariacoes['42'] := 'mais escuro, mais grosso';
  dicVariacoes['87'] := 'mais vermelho, mais verde';
  dicVariacoes['43'] := 'mais escuro, mais fino';
  dicVariacoes['A6'] := 'mais sujo, mais amarelo';
  dicVariacoes['26'] := 'mais grosso, mais amarelo';
  dicVariacoes['25'] := 'mais grosso, mais azul';
  dicVariacoes['96'] := 'mais claro, mais amarelo';
  dicVariacoes['B8'] := 'mais limpo, mais vermelho';
  dicVariacoes['A5'] := 'mais sujo, mais azul';
  dicVariacoes['38'] := 'mais fino, mais vermelho';
  dicVariacoes['9A'] := 'mais claro, mais sujo';
  dicVariacoes['58'] := 'mais azul, mais vermelho';
  dicVariacoes['95'] := 'mais claro, mais azul';
  dicVariacoes['82'] := 'mais vermelho , mais grosso';
  dicVariacoes['3A'] := 'mais fino, mais sujo';
  dicVariacoes['69'] := 'mais amarelo, mais claro';
  dicVariacoes['63'] := 'mais amarelo, mais fino';
  dicVariacoes['8A'] := 'mais vermelho, mais sujo';
  dicVariacoes['BB'] := 'BB';
  dicVariacoes['B4'] := 'mais limpo, mais escuro';
  dicVariacoes['A4'] := 'mais sujo, mais escuro';
  dicVariacoes['89'] := 'mais vermelho, mais claro';
  dicVariacoes['A0'] := 'mais sujo';
  dicVariacoes['59'] := 'mais azul, mais claro';
  dicVariacoes['92'] := 'mais claro, mais grosso';
  dicVariacoes['A7'] := 'mais sujo, mais verde';
  dicVariacoes['64'] := 'mais amarelo, mais escuro';
  dicVariacoes['B9'] := 'mais limpo, mais claro';
  dicVariacoes['46'] := 'mais escuro, mais amarelo';
  dicVariacoes['78'] := 'mais verde, mais vermelho';
  dicVariacoes['76'] := 'mais verde, mais amarelo';
  dicVariacoes['4B'] := 'mais escuro, mais limpo';
  dicVariacoes['90'] := 'mais claro';
  dicVariacoes['B5'] := 'mais limpo, mais azul';
  dicVariacoes['6B'] := 'mais amarelo, mais limpo';
  dicVariacoes['50'] := 'mais azul';
  dicVariacoes['5B'] := 'mais azul, mais limpo';
  dicVariacoes['37'] := 'mais fino, mais verde';
  dicVariacoes['24'] := 'mais grosso, mais escuro';
  dicVariacoes['5A'] := 'mais azul, mais sujo';
  dicVariacoes['60'] := 'mais amarelo';
  dicVariacoes['77'] := 'mais verde, mais verde';
  dicVariacoes['53'] := 'mais azul, mais fino';
  dicVariacoes['93'] := 'mais claro, mais fino';
end;

constructor TSalcomixSQLServer.Create(qryCadSal: TUniQuery; intAutInc: Integer);
begin
  Self.qryCadSal := qryCadSal;
  Self.intAutInc := intAutInc;
  Self.conexao := fCriaConexaoSQLServer;

  dicLinha     := TDicionario.Create;
  dicMontadora := TDicionario.Create;

  lstVariacoes := TList.Create;

  dicVariacoes := TDicionario.Create;
  ConstruirVariacoes;
end;

procedure TSalcomixSQLServer.pGerarCores;
var
  sprCores: TADOStoredProc;
  qryCores: TADOQuery;
begin
  sprCores := nil;
  qryCores := nil;
  Try
    Try
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
    Except
      on E: Exception do
      begin
        raise Exception.CreateFmt('%s: %s (%s)', [E.ClassName, E.Message, qryCores.FieldByName('ID_COR').AsString]);
      end;
    End;
  Finally
    if Assigned(sprCores) then FreeAndNil(sprCores);
    if Assigned(qryCores) then FreeAndNil(qryCores);
  End;
end;

procedure TSalcomixSQLServer.pGerarUmaCor(adoCores: TADOQuery);
  Var
    strLinha: String;
    strMontadora: String;
    strMd5: String;
begin
  strLinha := fLinhaDaCor(adoCores.FieldByName('ID_LINHA_PINTURA').AsString);
  strMontadora := fMontadoraDaCor(adoCores.FieldByName('ID_MONTADORA').AsString);

  If AnsiStartsText('S', strLinha) Or (Pos(strLinha, '525_729_') > 0) Then
  Begin
    qryCadSal.Insert;
    qryCadSal.FieldByName('SAL_CODSEQ').AsString   := adoCores.FieldByName('ID_COR').AsString;
    qryCadSal.FieldByName('SAL_LINHA_').AsString   := strLinha;
    qryCadSal.FieldByName('SAL_MONTAD').AsString   := strMontadora;
    qryCadSal.FieldByName('SAL_DESCRI').AsString   := fDescricaoCor(adoCores.FieldByName('DS_COR').AsString,
                                                                    adoCores.FieldByName('FG_MAIS_C').AsString);
    qryCadSal.FieldByName('SAL_CODPRO').AsString   := adoCores.FieldByName('DS_COD_COR_BASF').AsString;
    qryCadSal.FieldByName('SAL_ANOCOR').AsString   := fAnoDaCor(adoCores.FieldByName('NR_ANO_INICIO').AsString,
                                                                adoCores.FieldByName('NR_ANO_TERMINO').AsString);
    qryCadSal.FieldByName('SAL_VARIAC').AsString   := '';
    qryCadSal.FieldByName('SAL_CODEMP').AsString   := VS_strCodEmp;
    qryCadSal.FieldByName('AUTOINCREM').AsString   := fFormataAutInc(intAutInc, VS_strCodEmp);
    qryCadSal.FieldByName('SAL_PASSO_').AsString   := adoCores.FieldByName('NR_SOLUTION_ACTUAL_STEP').AsString;
    qryCadSal.FieldByName('SAL_RES325').AsInteger  := IIF(StrToBoolDef(adoCores.FieldByName('FG_VARIACOES').AsString, False), 1, 0);
    qryCadSal.FieldByName('SAL_VARIAC').AsString   := GetVariacao(adoCores.FieldByName('ID_COR').AsString);
    qryCadSal.FieldByName('SAL_ATIVO_').AsString   := 'S';
    qryCadSal.FieldByName('SAL_DTACAD').AsDateTime := adoCores.FieldByName('DT_CADASTRO').AsDateTime;

    strMd5 := '';
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODSEQ').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_CODPRO').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_LINHA_').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_DESCRI').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_MONTAD').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_ANOCOR').AsString;
    strMd5 := strMd5 + qryCadSal.FieldByName('SAL_VARIAC').AsString;
    qryCadSal.FieldByName('SAL_MD5KEY').AsString := GetMD5(strMd5);

    qryCadSal.Post;
  End;
end;

function TSalcomixSQLServer.fGetAutInc: Integer;
begin
  Result := intAutInc;
end;

function TSalcomixSQLServer.fLinhaDaCor(strIdLinha: String): String;
begin
  Result := IfNull(dicLinha[strIdLinha], '');
  If fEmptyStr(Result) Then
  Begin
    Result := fLinhaDaCorSQLServer(conexao, strIdLinha);
    dicLinha[strIdLinha] := Result;
  End;
end;

function TSalcomixSQLServer.fMontadoraDaCor(strIdMontadora: String): String;
begin
  Result := IfNull(dicLinha[strIdMontadora], '');
  If fEmptyStr(Result) Then
  Begin
    Result := fMontadoraDaCorSQLServer(conexao, strIdMontadora);
    dicLinha[strIdMontadora] := Result;
  End;
end;

function TSalcomixSQLServer.GetVariacao(const strIDCor: string): string;
var
  qryVariac: TADOQuery;
  strCodigo: string;
  stlVariacoes: TStringList;
begin
  qryVariac := nil;
  Result := '';
  strCodigo := '';
  stlVariacoes := nil;
  Try
    Try
      stlVariacoes := TStringList.Create;
      qryVariac := fEncontraVariacoes(conexao, strIdCor);
      while not qryVariac.Eof do
      begin
        Try
          if fEmptyStr(qryVariac.FieldByName('CODIGO_VARIACAO').AsString) then
            Continue;

          strCodigo := strCodigo + qryVariac.FieldByName('CODIGO_VARIACAO').AsString;
          stlVariacoes.Add(dicVariacoes[qryVariac.FieldByName('CODIGO_VARIACAO').AsString]);
        Finally
          qryVariac.Next;
        End;
      end;

      if not fEmptyStr(Trim(strCodigo)) then
        Result := Trim(strCodigo) + ' - ' + StringReplace(StringReplace(stlVariacoes.CommaText, ',', ', ', [rfReplaceAll]), '"', '', [rfReplaceAll])
      else
        Result := '';
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryVariac) then FreeAndNil(qryVariac);
    if Assigned(stlVariacoes) then FreeAndNil(stlVariacoes);
  End;
end;

function TSalcomixSQLServer.fDescricaoCor(strDescricao, strMaisC: String): String;
begin
  Result := strDescricao;
  If StrToBoolDef(strMaisC, False) Then
    Result := Result + ' +C';
end;

function TSalcomixSQLServer.fAnoDaCor(strAnoInicio, strAnoTermino: String): String;
begin
  If StrToIntDef(strAnoInicio, 0) <= 0 Then
    Result := ''
  Else
    Result := strAnoInicio + '/' + strAnoTermino;
end;

destructor TSalcomixSQLServer.Destroy;
  Var
    variacao: TVariacoesSalcomixSQLServer;
    intContador: Integer;
begin
  FreeAndNil(conexao);

  For intContador := 0 To lstVariacoes.Count -1 Do
  Begin
    variacao := TVariacoesSalcomixSQLServer(lstVariacoes[intContador]);
    FreeAndNil(variacao);
  End;

  lstVariacoes.Clear;
  FreeAndNil(lstVariacoes);
  if Assigned(dicVariacoes) then FreeAndNil(dicVariacoes);
  inherited;
end;

{ TBasesSalcomixSQLServer }

constructor TBasesSalcomixSQLServer.Create(qryCadBas: TUniQuery);
begin
  Self.qryCadBas := qryCadBas;
  Self.conexao := fCriaConexaoSQLServer;

  stlLinhasBases := TStringList.Create;
  stlLinhasBases.Add('Colorantes');
  stlLinhasBases.Add('S326');
  stlLinhasBases.Add('Salcomix');
  stlLinhasBases.Add('S850');
  stlLinhasBases.Add('S648');
  stlLinhasBases.Add('S327');
  stlLinhasBases.Add('S603');
  stlLinhasBases.Add('S325');
  stlLinhasBases.Add('525');
  stlLinhasBases.Add('729');  
end;

procedure TBasesSalcomixSQLServer.pGerarBases;
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

procedure TBasesSalcomixSQLServer.pGerarUmaBase(adoBases: TADOQuery);
  Var
    strLinha: String;
    qryCadBas: TUniQuery;
begin
  strLinha := fLinhaDaCorSQLServer(conexao, adoBases.FieldByName('ID_LINHA_PINTURA').AsString);
  If fEhBaseSalcomix(strLinha, adoBases) Then
  Begin
    qryCadBas := fCriaQuery(Nil);
    qryCadBas.SQL.Add('SELECT * FROM SAL_CADBAS WHERE BAS_CODBAS = :CODBAS AND BAS_LINHA_ = :LINHA_');
    qryCadBas.ParamByName('CODBAS').AsString := adoBases.FieldByName('DS_CODIGO_ITEM').AsString;
    qryCadBas.ParamByName('LINHA_').AsString := strLinha;    
    qryCadBas.Open;

    If qryCadBas.IsEmpty Then
    Begin
      qryCadBas.Append;
      qryCadBas.FieldByName('BAS_CODBAS').AsString := adoBases.FieldByName('DS_CODIGO_ITEM').AsString;
      qryCadBas.FieldByName('BAS_LINHA_').AsString := strLinha;      
      qryCadBas.FieldByName('BAS_DESBAS').AsString := adoBases.FieldByName('DS_ITEM_COMERCIAL').AsString;
      qryCadBas.FieldByName('BAS_PESBAS').AsFloat  := adoBases.FieldByName('VL_PESO_ESPECIFICO').AsFloat;
      qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := adoBases.FieldByName('VL_VOLUME').AsFloat*1000;
      qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;
      qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('SAL_CADBAS', VS_strCodEmp);
      qryCadBas.Post;
    End;

    FreeAndNil(qryCadBas);
  End;
end;

function TBasesSalcomixSQLServer.fEhBaseSalcomix(strLinha: String;
  adoBases: TADOQuery): Boolean;
begin
  Result := (stlLinhasBases.IndexOf(strLinha) >= 0)                                      And
            (fStrToFloat(adoBases.FieldByName('VL_PESO_ESPECIFICO').AsString) > 0);
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
  conf        := fGetConfTinta('SAL');
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
  sprVariac.ProcedureName := 'PRC_INT_RETORNA_FORMULA';
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

