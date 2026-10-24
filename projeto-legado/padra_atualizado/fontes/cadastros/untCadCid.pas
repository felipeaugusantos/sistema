unit untCadCid;

interface

uses
  Uni, Forms, StdCtrls, untCorreiosMain;

function fTemEndereco(strId_uf, strId_cidade, strNomCid: String): Boolean;

function fCadCepDadosCidade(strCodCor: String; var strNomCid, strEstado,
  strNumCep: String): Boolean;

function fCadCepDadosCep(strNumCep: String;
                         var strCodCid,
                         strEndere,
                         strBairro,
                         strNomCid,
                         strEstado: string;
                         out ACodCor: String;
                         strId_uf: String = '';
                         strId_cidade: String = '';
                         blnConsultarNaApiDosCorreios: Boolean = True): Boolean;

function fConsultarCep(Form: TForm; strCep: String; edtCep: TCustomEdit; strId_uf: String = '';
  strId_cidade: String = ''; strNomCid: String = ''): String;

procedure pAtualizaCodigoCorreios(strCodCid, strCep: String);
procedure pAtualizaCodigoIbge(strCodCid, strCodIbge: String);
function fRetCodCidade(strNomCid, strCodEst : String; out ACodCor: String): String; overload;
function fRetCodCidade(strNomCid, strCodEst : String; out ACodCor, ACodIbge: String): String; overload;
function fRetNomeCidadeCorreios(intIdCidade : Integer):String;
function fRetCidadesCadastradasComCodCorreios(intIdCidade : Integer; strCodCid : String):String;
function fRetCodIbgeCidade(strNomCid, strEstado, ACodCor: String): String;
function RetornaCodigosDeCidadesComOMesmoCodCor(ACodigoCidade, ASiglaUF, ACodigoCorreio: String): String;

implementation

uses SysUtils, untConsultas, untFuncoesSimples, Data.DB, untTypesSistema;

function fTemEndereco(strId_uf, strId_cidade, strNomCid: String): Boolean;
  Var
    strSQL : String;
    qryEndereco: TUniQuery;
Begin
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   endereco.nome ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   endereco ';

  If Not fEmptyStr(strNomCid) Then
    strSQL := strSQL + 'JOIN cidade USING (id_cidade) ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE ';

  If Not fEmptyStr(strId_uf) Then
    strSQL := strSQL + '  AND endereco.id_uf = ' + QuotedStr(strId_uf) + ' ';

  If Not fEmptyStr(strId_cidade) Then
    strSQL := strSQL + '  AND endereco.id_cidade = ' + QuotedStr(strId_cidade) + ' ';

  If Not fEmptyStr(strNomCid) Then
    strSQL := strSQL + '  AND cidade.nome = ' + QuotedStr(strNomCid) + ' ';

  strSQL := strSQL + '  LIMIT 1 ';
  
  qryEndereco := fCriaQuery;

  With qryEndereco Do
  Begin
    SQL.Text := strSQL;
    Open;
    Result := Not IsEmpty;
  End;

  FreeAndNil(qryEndereco);
end;

function fCadCepDadosCidade(strCodCor: String; var strNomCid, strEstado,
  strNumCep: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  cidade.id_uf, ');
    SQL.Add('  cidade.nome, ');
    SQL.Add('  LEFT(cidade.cep, 5) as cep ');
    SQL.Add('FROM ');
    SQL.Add('  cidade ');
    SQL.Add('WHERE ');
    SQL.Add('  cidade.id_cidade = :CODCOR ');

    ParamByName('CODCOR').AsInteger := StrToIntDef(strCodCor, 0);
    Open;

    Result := (Not IsEmpty);
    strNomCid := AnsiUpperCase(FieldByName('nome').AsString);
    strEstado := FieldByName('id_uf').AsString;
    strNumCep := FieldByName('cep').AsString;

    Close;
  End;
end;

function fCadCepDadosCep(strNumCep: string;
                         var strCodCid,
                         strEndere,
                         strBairro,
                         strNomCid,
                         strEstado: string;
                         out ACodCor: string;
                         strId_uf: string = '';
                         strId_cidade: string = '';
                         blnConsultarNaApiDosCorreios: Boolean = True): Boolean;
var
  qryAux: TUniQuery;
  strIbge, strIbgeCadCid, strAuxMsg: string;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('SELECT e.nome as endereco                        ');
    qryAux.SQL.Add('     , b.nome as bairro                          ');
    qryAux.SQL.Add('     , c.nome as cidade                          ');
    qryAux.SQL.Add('     , c.id_uf as uf                             ');
    qryAux.SQL.Add('     , c.ibge                                    ');
    qryAux.SQL.Add('     , CADCID.CID_CODCID                         ');
    qryAux.SQL.Add('     , CADCID.CID_CODCOR                         ');
    qryAux.SQL.Add('     , CADCID.CID_COIBGE                         ');
    qryAux.SQL.Add('FROM endereco  e                                 ');
    qryAux.SQL.Add('  LEFT JOIN bairro    b ON b.id_bairro  = e.id_bairro ');
    qryAux.SQL.Add('  JOIN cidade    c ON c.id_cidade  = e.id_cidade ');
    qryAux.SQL.Add('  LEFT JOIN CADCID ON CID_CODCOR   = c.id_cidade ');
    qryAux.SQL.Add('WHERE e.cep =  :NUMCEP                           ');

    If Not fEmptyStr(strId_uf) Then
      qryAux.SQL.Add(' AND e.id_uf = ' + QuotedStr(strId_uf));

    If Not fEmptyStr(strId_cidade) Then
      qryAux.SQL.Add(' AND e.id_cidade = ' + QuotedStr(strId_cidade));

    qryAux.ParamByName('NUMCEP').AsString := strNumCep;

    qryAux.Open;

    Result := (Not qryAux.IsEmpty);

    If Not Result Then
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT "" AS endereco     ');
      qryAux.SQL.Add('     , "" AS bairro       ');
      qryAux.SQL.Add('     , nome AS cidade     ');
      qryAux.SQL.Add('     , cidade.id_uf as uf ');
      qryAux.SQL.Add('     , cidade.ibge        ');
      qryAux.SQL.Add('     , CID_CODCID         ');
      qryAux.SQL.Add('     , CID_CODCOR         ');
      qryAux.SQL.Add('     , CID_COIBGE         ');
      qryAux.SQL.Add('FROM cidade               ');
      qryAux.SQL.Add('LEFT JOIN CADCID ON CID_CODCOR = cidade.id_cidade ');
      qryAux.SQL.Add('WHERE cep = :NUMCEP                      ');

      qryAux.ParamByName('NUMCEP').AsString := strNumCep;

      qryAux.Open;

      Result := (Not qryAux.IsEmpty);
    End;

    If Result Then
    Begin
      strEndere := AnsiUpperCase(qryAux.FieldByName('endereco').AsString);
      strBairro := AnsiUpperCase(qryAux.FieldByName('bairro').AsString);
      strNomCid := AnsiUpperCase(qryAux.FieldByName('cidade').AsString);
      strEstado := AnsiUpperCase(qryAux.FieldByName('uf').AsString);
      strCodCid := AnsiUpperCase(qryAux.FieldByName('CID_CODCID').AsString);
      ACodCor   := qryAux.FieldByName('CID_CODCOR').AsString;
      strIbge   := qryAux.FieldByName('ibge').AsString;
      strIbgeCadcid := qryAux.FieldByName('CID_COIBGE').AsString;
    End;

    qryAux.Close;

    If (Not Result) And (blnConsultarNaApiDosCorreios) Then
    Begin
      If fCfgSis('USIGEP') <> 'A' Then
        Exit;

      If fConsultaCep(strNumCep, strNomCid, strEndere, strBairro, strEstado) Then
      Begin
        strCodCid := fRetCodCidade(strNomCid, strEstado, ACodCor, strIbgeCadCid);
        Result := (not fEmptyStr(strEndere)) And (not fEmptyStr(strCodCid)) and (not fEmptyStr(strNomCid));
        If Result Then
          strIbge := fRetCodIbgeCidade(strNomCid, strEstado, ACodCor);
      End;
    End;

    If Result Then
    Begin
      If fEmptyStr(strIbge) Then
        Exit;

      strAuxMsg := 'A Cidade [' + strCodCid +'] ' + strNomCid + ' possui o código IBGE "' + strIbgeCadCid + '" em seu cadastro. ';
      strAuxMsg := strAuxMsg + #13 + 'No entanto, a consulta de CEP retornou o código IBGE "' + strIbge + '".';
      strAuxMsg := strAuxMsg + #13 + 'Deseja Atualizar ?';

      If fEmptyStr(strIbgeCadCid) Or ((strIbge <> strIbgeCadCid) And (fMensagem('ATENÇÃO', strAuxMsg, ['&Sim', '&Não']) = 1)) then
        pAtualizaCodigoIbge(strCodCid, strIbge);
    End;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function fConsultarCep(Form: TForm; strCep: String; edtCep: TCustomEdit; strId_uf: String = '';
  strId_cidade: String = ''; strNomCid: String = ''): String;
  Var
    qryEndereco: TUniQuery;
    arrSel     : TConsultasArray;
    chrKey     : Char;

begin
  Result := '';

  If (Not fEmptyStr(strId_uf)) And (Not fTemEndereco(strId_uf, '', '')) Then
  Begin
    strId_uf := '';
    strId_cidade := '';
  End;

  If (Not fEmptyStr(strId_cidade)) And (Not fTemEndereco(strId_uf, strId_cidade, '')) Then
    strId_cidade := '';

  If (Not fEmptyStr(strId_cidade)) Then
  Begin
    strNomCid := '';
  End;

  If (Not fEmptyStr(strNomCid)) And (Not fTemEndereco('', '', strNomCid))  Then
  Begin
    strNomCid := '';
  End;

  qryEndereco := fCriaQuery(nil);

  chrKey := '/';

  If fPesqCEP(Form, edtCep, qryEndereco, chrKey, arrSel, strId_uf, strId_cidade, strNomCid) Then
  Begin
    Result := qryEndereco.FieldByName('cep').AsString;
  End

  Else Result := strCep;

end;

procedure pAtualizaCodigoCorreios(strCodCid, strCep: String);
  Var
    strSQL : String;
    strCodCor : String;
    qryEndereco: TUniQuery;
Begin
  strCodCor := fCampoTabela('id_cidade', 'endereco', ['cep'], [strCep]);
  If fEmptyStr(strCodCor) or (strCodCor = '0') Then
    strCodCor := fCampoTabela('id_cidade', 'cidade', ['cep'], [strCep]);

  If Not (fEmptyStr(strCodCor) or (strCodCor = '0')) Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' UPDATE CADCID ';
    strSQL := strSQL + ' SET CID_CODCOR = :CODCOR ';
    strSQL := strSQL + ' WHERE CID_CODCID = :CODCID ';

    qryEndereco := fCriaQuery;
    With qryEndereco Do
    Begin
      SQL.Text := strSQL;

      ParamByName('CODCID').AsString := strCodCid;
      ParamByName('CODCOR').AsString    := strCodCor;

      ExecSQL;
    End;
    FreeAndNil(qryEndereco);
  End;
end;

procedure pAtualizaCodigoIbge(strCodCid, strCodIbge: String);
  Var qryIbge: TUniQuery;
begin
  qryIbge := fCriaQuery;
  Try
    qryIbge.SQL.Add('UPDATE CADCID SET CID_COIBGE = :CODIBGE');
    qryIbge.SQL.Add('WHERE CID_CODCID = :CODCID');

    qryIbge.ParamByName('CODIBGE').AsString := strCodIbge;
    qryIbge.ParamByName('CODCID').AsString := strCodCid;

    qryIbge.ExecSQL;
  Finally
    FreeAndNil(qryIbge);
  End;
end;

function fRetCodCidade(strNomCid, strCodEst : String; out ACodCor, ACodIbge: String): String;
  Var
    strSQL   : String;
    qryGenCid: TUniQuery;

begin
  Try
    qryGenCid := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CID_NOMCID = :NOMCID ';
    strSQL := strSQL + '  AND CID_ESTADO = :ESTADO ';

    With qryGenCid Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMCID').AsString := strNomCid;
      ParamByName('ESTADO').AsString := strCodEst;
      Open;

      Result := FieldByName('CID_CODCID').AsString;

      ACodCor := FieldByName('CID_CODCOR').AsString;
      ACodIbge := FieldByName('CID_COIBGE').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenCid);
  End;
end;

function fRetCodCidade(strNomCid, strCodEst : String; out ACodCor: String): String;
var strAuxCodIbge: String;
begin
  Result := fRetCodCidade(strNomCid, strCodEst, ACodCor, strAuxCodIbge);
end;

function fRetNomeCidadeCorreios(intIdCidade : Integer):String;
  Var
    strSQL   : String;
    qryGenCid: TUniQuery;
begin
  Try

    qryGenCid := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT nome FROM cidade ';
    strSQL := strSQL + 'WHERE id_cidade = :id   ';

    With qryGenCid Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('id').AsInteger := intIdCidade;
      Open;

      Result := AnsiUpperCase(FieldByName('nome').AsString);

      Close;
    End;

  Finally
    FreeAndNil(qryGenCid);
  End;
end;

//Retorna o Nome das Cidades(CADCID) que contem o mesmo codigo do correios.
function fRetCidadesCadastradasComCodCorreios(intIdCidade : Integer; strCodCid : String):String;
  Var
    strSQL   : String;
    qryGenCid: TUniQuery;
begin
  Try

    qryGenCid := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT CID_CODCID, CID_NOMCID FROM CADCID ';
    strSQL := strSQL + ' WHERE CID_CODCID <> :CODCID   ';
    strSQL := strSQL + '   AND CID_CODCOR =  :CODCOR   ';

    With qryGenCid Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCOR').AsInteger := intIdCidade;
      ParamByName('CODCID').AsString  := strCodCid;
      Open;

      Result := '';
      While Not Eof Do
      Begin
        Result := Result + FieldByName('CID_CODCID').AsString + ' - ' +
                           FieldByName('CID_NOMCID').AsString;
        Next;

        If Not Eof Then
          Result := Result + #13;

      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenCid);
  End;
end;

function fRetCodIbgeCidade(strNomCid, strEstado, ACodCor: String): String;
var qryCidade: TUniQuery;
begin
  Result := '';
  qryCidade := fCriaQuery;
  Try
    qryCidade.SQL.Add('SELECT ibge FROM cidade WHERE (Upper(nome) = :cidade AND id_uf = :uf)');
    if not fEmptyStr(ACodCor) then
    begin
      qryCidade.SQL.Add(' OR ((id_cidade = :codcor) AND (id_uf = :uf))');
      qryCidade.ParamByName('codcor').AsString := ACodCor;
    end;
    qryCidade.ParamByName('cidade').AsString := fUpper(strNomCid);
    qryCidade.ParamByName('uf').AsString := strEstado;

    qryCidade.Open;

    if qryCidade.RecordCount > 0 then
      Result := qryCidade.FieldByName('ibge').AsString;

    qryCidade.Close;
  Finally
    FreeandNil(qryCidade);
  End;
end;

function RetornaCodigosDeCidadesComOMesmoCodCor(ACodigoCidade, ASiglaUF, ACodigoCorreio: String): String;
  Var
    LConsulta: TUniQuery;

    LSQL,
    LNomeCidade: String;
Begin
  LConsulta := fCriaQuery;

  Try
    LSQL := 'SELECT CID_CODCID FROM CADCID WHERE ';

    If (Not ACodigoCorreio.IsEmpty) And (ACodigoCorreio <> '0') Then
      LSQL := LSQL + ' CID_CODCOR = ' + ACodigoCorreio + ' OR ';

    //Algumas cidades não possuem CODCOR no cadastro
    LNomeCidade := fRetNomCidade(ACodigoCidade);

    LSQL := LSQL + ' (CID_NOMCID="' + fRemoveAcento(LNomeCidade) + '" AND ';
    LSQL := LSQL + '  CID_ESTADO="' + ASiglaUF + '") ';

    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := '';
    While Not LConsulta.Eof Do
    Begin
      Result := Result + LConsulta.FieldByName('CID_CODCID').AsString + '_';

      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
End;

end.
