unit untConsultaSituacaoCadastral;

interface

const
  MSG_PAINEL_FECHADO_CONSULTA_CADASTRAL : String = 'Atenção: o PainelNFe da loja (%s) não está aberto. Por favor verifique.' + sLineBreak +
                                                   'É necessário estar aberto para consulta cadastral da situação do cliente [CFG_CSDENE]';

function fUsaConsultaDenegadaPeloPainelNfe : Boolean;
function fDeveGravarConsultaDenegadaPendente(const strCodCli : String) : Boolean;
procedure pGravarConsultaDenegadaPendente(const strCodCli : String);
function fValidouConsultaSituacaoCadastral(const strCodCli : String) : Boolean;
function fClienteComProblemaNaConsultaDeSituacaoCadastral(const strCodCli, strEspDoc : String) : Boolean;
procedure pGravarLentidaoConsultaSituacaoCadastral(const strCodCli : String);
function fTemTravaParaConsulta(const strEspDoc, strTextoTrava : String) : Boolean;
function fEmitenteComRestricaoFiscal(const strCodEmp, strEspDoc : String) : Boolean;

implementation

uses untFuncoesSimples, untLibNfe, Uni, System.SysUtils, System.StrUtils, Data.DB;

function fUsaConsultaDenegadaPeloPainelNfe : Boolean;
begin
  Result := False;
  If (fCfgSis('NFEUSA', varString) <> 'S') Then
    Exit;
  If (fCfgSis('PNLNFE', varString) <> 'S') Then
    Exit;
  If (fCfgSisL('CSDENE', varString) <> 'S') Then
    Exit;
  If (Not fTabelaExiste('NFE_LOCAL', True)) Then
    Exit;
  If (Not fCampoExiste('NFE_LOCAL', 'NFE_CONCAD', True)) Then
    Exit;
  If (fCampoTabela('COUNT(0)', 'NFE_LOCAL', ['NFE_CONCAD', 'NFE_CODEMP'], ['S', VS_strCodEmp], False) = 0) Then
    Exit;
  Result := True;
end;

function fDeveGravarConsultaDenegadaPendente(const strCodCli : String) : Boolean;
  Var
    strInscricao : String;
begin
  Result := False;
  If (Not fUsaConsultaDenegadaPeloPainelNfe) Then
    Exit;
  strInscricao := fCampoTabela('CLI_I_E_S_', 'CADCLI', ['CLI_CODCLI', 'CLI_CGCCPF'], [strCodCli, '1'], False);
  If fEmptyStr(strInscricao) Then
    Exit;
  If SameText(strInscricao, 'Isento') Then
    Exit;
  If SameText(strInscricao, 'Isenta') Then
    Exit;
  Result := True;
end;

procedure pGravarConsultaDenegadaPendente(const strCodCli : String);
  Var
    qryInsert : TUniQuery;
begin
  qryInsert := fCriaQuery;
  Try
    qryInsert.SQL.Add('INSERT INTO BLODEN (AUTOINCREM, DEN_CODCLI, DEN_C_G_C_, DEN_INSCRI, DEN_ESTADO, DEN_CODEMP, DEN_DTAINC, DEN_HRAINC) ');
    qryInsert.SQL.Add(' (SELECT :AUTINC, CLI_CODCLI, CLI_C_G_C_, CLI_I_E_S_, CID_ESTADO, :CODEMP, CURRENT_DATE, CURRENT_TIME ');
    qryInsert.SQL.Add('    FROM CADCLI ');
    qryInsert.SQL.Add('    JOIN CADCID ON CID_CODCID = CLI_CODCID ');
    qryInsert.SQL.Add('   WHERE CLI_CODCLI = :CODCLI) ');
    qryInsert.ParamByName('CODCLI').AsString := strCodCli;
    qryInsert.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('BLODEN', VS_strCodEmp);
    qryInsert.ExecSQL;
  Finally
    FreeAndNil(qryInsert);
  End;
end;

function fValidouConsultaSituacaoCadastral(const strCodCli : String) : Boolean;
begin
  Result := True;

  If (Not fDeveGravarConsultaDenegadaPendente(strCodCli)) Then
    Exit;

  If (Not fPainelEstaAberto) Then
  Begin
    Result := False;
    Exit;
  End;

  If (fCampoTabela('DEN_CODCLI', 'BLODEN', ['DEN_CODCLI', 'DEN_CODEMP'], [strCodCli, VS_strCodEmp], True) = strCodCli) Then
    Exit;

  pGravarConsultaDenegadaPendente(strCodCli);
End;

function fClienteComProblemaNaConsultaDeSituacaoCadastral(const strCodCli, strEspDoc : String) : Boolean;
  Var
    qryBloDen : TUniQuery;
begin
  Result := False;
  If (Not fUsaConsultaDenegadaPeloPainelNfe) Then
    Exit;
  qryBloDen := fCriaQuery;
  Try
    qryBloDen.SQL.Add('SELECT DEN_DTACON, DEN_HRACON, DEN_OBSERV, DEN_DESSIT ');
    qryBloDen.SQL.Add('  FROM BLODEN ');
    qryBloDen.SQL.Add(' WHERE DEN_CODCLI = :CODCLI ');
    qryBloDen.SQL.Add('   AND DEN_CODEMP = :CODEMP ');
    qryBloDen.ParamByName('CODCLI').AsString := strCodCli;
    qryBloDen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryBloDen.Open;
    If qryBloDen.IsEmpty Then
      Exit;
    If (qryBloDen.FieldByName('DEN_DTACON').IsNull) Then
    Begin
      fMensagem('ATENÇÃO!', 'A consulta de situação cadastral do cliente ainda não foi realizada.' + sLineBreak +
                            'Caso o PainelNFe da loja ' + VS_strCodEmp + ' não estiver aberto, abra-o e tente fazer o fechamento novamente. [CFG_CSDENE]', ['&OK']);
      Result := True;
      pGravarLentidaoConsultaSituacaoCadastral(strCodCli);
    End;
    If fTemTravaParaConsulta(strEspDoc, qryBloDen.FieldByName('DEN_DESSIT').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Cliente com situação irregular: ' + sLineBreak +
                            AnsiReplaceStr(qryBloDen.FieldByName('DEN_OBSERV').AsString, '- A SEFAZ não fornece a informação ', ''), ['&OK']);
      Result := True;
      Exit;
    End;
  Finally
    FreeAndNil(qryBloDen);
  End;
end;

procedure pGravarLentidaoConsultaSituacaoCadastral(const strCodCli : String);
  Var
    qryLentidao : TUniQuery;
begin
  qryLentidao := fCriaQuery;
  Try
    qryLentidao.SQL.Add('INSERT INTO BLDELN (ELN_CODCLI, ELN_DTATRV, ELN_HRATRV, ELN_CODEMP) VALUES ');
    qryLentidao.SQL.Add(' (:CODCLI, CURRENT_DATE, CURRENT_TIME, :CODEMP) ');
    qryLentidao.ParamByName('CODCLI').AsString := strCodCli;
    qryLentidao.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryLentidao.ExecSQL;
  Finally
    FreeAndNil(qryLentidao);
  End;
end;

function fTemTravaParaConsulta(const strEspDoc, strTextoTrava : String) : Boolean;
  Var
    qryTrava : TUniQuery;
begin
  qryTrava := fCriaQuery;
  Try
    qryTrava.SQL.Add('SELECT IRR_ESPDOC ');
    qryTrava.SQL.Add('  FROM CNSIRR ');
    qryTrava.SQL.Add(' WHERE IRR_ESPDOC = :ESPDOC ');
    qryTrava.SQL.Add('   AND IRR_TXTBLO = :TXTBLO ');
    qryTrava.ParamByName('ESPDOC').AsString := strEspDoc;
    qryTrava.ParamByName('TXTBLO').AsString := strTextoTrava;
    qryTrava.Open;
    Result := (Not qryTrava.IsEmpty);
  Finally
    FreeAndNil(qryTrava);
  End;
end;

function fEmitenteComRestricaoFiscal(const strCodEmp, strEspDoc : String) : Boolean;
  Var
    qryCnsCad : TUniQuery;
begin
  Result := False;
  If (fCfgSis('NFEUSA', varString) <> 'S') Then
    Exit;
  If (fCfgSis('PNLNFE', varString) <> 'S') Then
    Exit;
  If (fCfgSis('VERNFE', varString) <> '4.00') Then
    Exit;
  If fEmptyStr(strEspDoc) Then
    Exit;
  If (Pos(strEspDoc, 'NF_EL_NS_IF_IV_') = 0) Then
    Exit;
  qryCnsCad := fCriaQuery;
  Try
    qryCnsCad.Close;
    qryCnsCad.SQL.Text := 'SELECT CAD_DESSIT FROM CNSCAD WHERE CAD_DTACON = CURRENT_DATE AND CAD_CODEMP = :CODEMP';
    qryCnsCad.ParamByName('CODEMP').AsString := strCodEmp;
    qryCnsCad.Open;
    If qryCnsCad.IsEmpty Then
      Exit;
    If fEmptyStr(qryCnsCad.FieldByName('CAD_DESSIT').AsString) Then
      Exit;
    Result := (fTemTravaParaConsulta(strEspDoc, qryCnsCad.FieldByName('CAD_DESSIT').AsString));
  Finally
    FreeAndNil(qryCnsCad);
  End;
end;

end.
