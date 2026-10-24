{*********************************************************}
{* CLASSE COMISSÃO DE ENTREGADORES                       *}
{*                                                       *}
{* DATA......: 06/07/2009                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI                  *}
{*                                                       *}
{******************************************************AF*}
unit untComEntregadores;

interface

uses Classes, frxClass, Uni, DB,  UniClientDataSet, UniDataSetProvider, DBClient, untTypesSistema,
untLiberacao;

type
  TComEnt = class
  private
    FProEnt: String;
    FCodEnt: String;
    FPlaVei: String;
    FDocume: String;
    FEspDoc: String;
    FEmpDoc: String;
    FCodCid: String;
    FCodCli: String;
    FNomCli: String;
    FQtdNot: Integer;
    FTipEnt: TTipEnt;
    FInsDoc: TInsDoc;
    FChaAce: String;
    FPesBru: Double;
    FPesLiq: Double;
    FVolume: Double;
    objLiberacao: TLiberacao;

    procedure setCodEnt(const Value: String);
    procedure setPlaVei(const Value: String);
    procedure setDocume(const Value: String);
    procedure setEmpDoc(const Value: String);
    procedure setEspDoc(const Value: String);
    procedure setProEnt(const Value: String);
    procedure setCodCid(const Value: String);
    procedure setTipEnt(const Value: TTipEnt);
    procedure setInsDoc(const Value: TInsDoc);

    procedure pReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
      UpdateKind: TUpdateKind; var Action: TReconcileAction);

    Procedure pSqlNotas(qryGen: TUniQuery; strTabela: String);
    Function  fSQLVerificaEndereco: String;
    procedure pValidaDocumentoDuplicado;
    Function  fSqlPesos(strCampo:String): String;
    Function  fRetornaCodCidCliente(strCodCli, strNumDoc, strEspDoc, strCodEmp: String): String;
  public
    strEspPer: String;

    qryComEng: TUniQuery;
    qryComEnd: TUniQuery;
    cdsComEnd: TUniClientDataSet;
    cpvComEnd: TUniDataSetProvider;

    procedure pAfterOpen(Dataset: TDataset);
    procedure pAfterClose(Dataset: TDataset);
    procedure pAfterOpenItens(Dataset: TDataset);
    function  fInsereRegistro: Boolean;
    procedure pSalvaComEnd;
    procedure pImprimeRegistro(strImpEnd, strImpAss : String; intTipRel: Integer);
    function  fSetaDadosDocumentoChaveAcesso: Boolean;

    function fEntregaBaixada(strCodEntrega: String): Boolean;
    function getTipEnt: TTipEnt;
    function getInsDoc: TInsDoc;

    procedure setChaAce(const Value: String);
    function  getChaAce: String;
    procedure pAlteraSituacaoMotorista(strSituacao: String);

    function fGravaComEnd(strSeqEng,
                          strNumDoc,
                          strEspeci,
                          strEmpres,
                          strClient,
                          strCodCid: String;
                          intNotas: Integer): Boolean;

    procedure pCarregaPesos(strNumDoc, strEspDoc, strCodEmp: String;
                        Var fltPesBru, fltPesLiq, fltVolume: Double);

    property strProEnt: String  Read FProEnt Write setProEnt;
    property strCodEnt: String  Read FCodEnt Write setCodEnt;
    property strPlaVei: String  Read FPlaVei Write setPlaVei;
    property strDocume: String  Read FDocume Write setDocume;
    property strEspDoc: String  Read FEspDoc Write setEspDoc;
    property strEmpDoc: String  Read FEmpDoc Write setEmpDoc;
    property strCodCid: String  Read FCodCid Write setCodCid;
    property strChaAce: String  Read FChaAce Write setChaAce;
    property strCodCli: String  Read FCodCli;
    property strNomCli: String  Read FNomCli;
    property intQtdNot: Integer Read FQtdNot;
    property fltPesBru: Double  Read FPesBru;
    property fltPesLiq: Double  Read FPesLiq;
    property fltVolume: Double  Read FVolume;

    constructor Create;
    destructor Destroy; Override;
  end;


implementation

uses SysUtils, Variants, untFuncoesSimples, untConstantes, untQckCadComEntregadores,
  StrUtils,  UntMsgInterna, untCfgRel;

{ TComEnt }

procedure TComEnt.pReconcileError(DataSet: TCustomClientDataSet; E: EReconcileError;
  UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  Action := raAbort;

  Raise ExceptionAutCom.Create(E.Message);
end;

constructor TComEnt.Create;
Var
  strTipEnt: String;
begin
  qryComEng := fCriaQuery(Nil);
  qryComEnd := fCriaQuery(Nil);

  cpvComEnd         := TUniDataSetProvider.Create(Nil);
  cpvComEnd.DataSet := qryComEnd;
  cdsComEnd         := TUniClientDataSet.Create(Nil);

  qryComEng.AfterOpen   := pAfterOpen;
  qryComEng.AfterInsert := pAfterOpen;
  qryComEng.AfterClose  := pAfterClose;

  cdsComEnd.OnReconcileError := pReconcileError;
  cdsComEnd.AfterOpen        := pAfterOpenItens;

  strTipEnt := fCfgSis('TIPENT', VarString);

  If (strTipEnt = 'C') Then
    setTipEnt(tenCodigo)
  Else If (strTipEnt = 'S') Then
    setTipEnt(tenSenha)
  Else
    setTipEnt(tenBarras);

  If (fCfgSis('TPDCEN', VarString) = '2') Then
    setInsDoc(idoBarras)
  Else
    setInsDoc(idoDocumento);

  setChaAce('');


  objLiberacao := TLiberacao.Create;

end;

procedure TComEnt.pAfterOpen(Dataset: TDataset);
  Var
//    intIndex: Integer;
    strCid   : String;
    fltPesBru,
    fltPesLiq,
    fltLiquid: Double;
Begin
  If Not qryComEng.Active Then
    Exit;

  TStringField(qryComEng.FieldByName('ENG_PLAVEI')).EditMask := 'aaa-9a99;0;_';
  With qryComEnd, SQL Do
  Begin
    DisableControls;

    Close;
    Clear;
    Add('SELECT                 ');
    Add('  *,                   ');
    Add('  "' + fReplicatorStr(' ',69) + '" AS CLI_CODCLI, ');
    Add('  "' + fReplicatorStr(' ',69) + '" AS CID_CODCID, ');
    Add('  0.00 AS GER_PESBRU,  ');
    Add('  0.00 AS GER_PESLIQ,  ');
    Add('  0.00 AS GER_VOLUME,  ');
    Add('  (SELECT REQ_TIP_FC FROM MOVRQG      ');
    Add('   WHERE REQ_NUMREQ = END_NUMDOC      ');
    Add('     AND REQ_CODEMP = END_CODEMP      ');
    Add('     AND REQ_FORCLI = END_CODCLI      ');
    Add('     AND END_ESPDOC = "RQ") AS TIP_FC ');
    Add('FROM COMEND                ');
    Add('WHERE END_SEQENG = :SEQGER ');
    ParamByName('SEQGER').AsString := qryComEng.FieldByName('AUTOINCREM').AsString;
    Open;

    pSetaClient(qryComEnd);
    EnableControls;

    cdsComEnd.DisableControls;
    cdsComEnd.Close;
    cpvComEnd.UpdateMode := upWhereKeyOnly;
    cdsComEnd.SetProvider(cpvComEnd);
    cdsComEnd.Open;

    pSetaClient(cdsComEnd);
//    For intIndex := 0 To cdsComEnd.FieldDefs.Count - 1 Do
//      cdsComEnd.FieldDefs[intIndex].Required := False;
  End;

  cdsComEnd.First;

  While Not cdsComEnd.Eof Do
  Begin
    cdsComEnd.Edit;

    If (cdsComEnd.FieldByName('END_ESPDOC').AsString = 'PC') or
      ((cdsComEnd.FieldByName('END_ESPDOC').AsString = 'RQ') and (cdsComEnd.FieldByName('TIP_FC').AsString = 'F')) Then
    Begin
      cdsComEnd.FieldByName('CLI_CODCLI').AsString := cdsComEnd.FieldByName('END_CODCLI').AsString + '-' + fRetNomFornecedor(cdsComEnd.FieldByName('END_CODCLI').AsString);
      strCid := fRetCidFornecedor(cdsComEnd.FieldByName('END_CODCLI').AsString);
    End
    Else If cdsComEnd.FieldByName('END_ESPDOC').AsString = 'OS' Then
    Begin
      cdsComEnd.FieldByName('CLI_CODCLI').AsString := TMsgInterna.fRetOperadorEnvio(RightStr(cdsComEnd.FieldByName('END_NUMDOC').AsString, 6));
      If fEmptyStr(cdsComEnd.FieldByName('END_CODCID').AsString) Then
        strCid := fRetCidEmpresa(cdsComEnd.FieldByName('END_CODEMP').AsString)
      Else
        strCid :=  cdsComEnd.FieldByName('END_CODCID').AsString;
    End
    Else
    Begin
      cdsComEnd.FieldByName('CLI_CODCLI').AsString := cdsComEnd.FieldByName('END_CODCLI').AsString + '-' + fRetNomCliente(cdsComEnd.FieldByName('END_CODCLI').AsString);
      strCid := fRetornaCodCidCliente(cdsComEnd.FieldByName('END_CODCLI').AsString,
                                      cdsComEnd.FieldByName('END_NUMDOC').AsString,
                                      cdsComEnd.FieldByName('END_ESPDOC').AsString,
                                      cdsComEnd.FieldByName('END_EMPDOC').AsString);
    End;

    cdsComEnd.FieldByName('CID_CODCID').AsString := strCid + '-' + fRetNomCidade(strCid);

    pCarregaPesos(cdsComEnd.FieldByName('END_NUMDOC').AsString,
                  cdsComEnd.FieldByName('END_ESPDOC').AsString,
                  cdsComEnd.FieldByName('END_EMPDOC').AsString,
                  fltPesBru, fltPesLiq, fltLiquid);

    cdsComEnd.FieldByName('GER_PESBRU').AsFloat := fltPesBru;
    cdsComEnd.FieldByName('GER_PESLIQ').AsFloat := fltPesLiq;
    cdsComEnd.FieldByName('GER_VOLUME').AsFloat := fltLiquid;

    cdsComEnd.Post;
    cdsComEnd.Next;
  End;

  cdsComEnd.EnableControls;
End;

procedure TComEnt.pAfterOpenItens(Dataset: TDataset);
begin
  With DataSet Do
  Begin
    TFloatField(FieldByName('GER_PESBRU')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('GER_PESLIQ')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('GER_VOLUME')).DisplayFormat := '#,##0.00';
  End;
end;

procedure TComEnt.pCarregaPesos(strNumDoc, strEspDoc, strCodEmp: String;
                            Var fltPesBru, fltPesLiq, fltVolume: Double);
  Var
    qryAux: TUniQuery;
begin
  If (Pos(strEspDoc,'PC_GA_OS_PR_') > 0) Then
  Begin
    fltPesBru := 0.00;
    fltPesLiq := 0.00;
    fltVolume := 0.00;
  End
  Else
  Begin
    Try
      qryAux := fCriaQuery(nil);

      With qryAux Do
      Begin
        pSqlNotas(qryAux, 'MOVGER');
        SQL.Add('  UNION ALL ');
        pSqlNotas(qryAux, 'NOTGER');
        SQL.Add('  LIMIT 1 ');

        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;

        Open;

        If Not IsEmpty Then
        Begin
          fltPesBru := FieldByName('GER_PESBRU').AsFloat;
          fltPesLiq := FieldByName('GER_PESLIQ').AsFloat;
          fltVolume := FieldByName('GER_VOLUME').AsFloat;
        End;
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

procedure TComEnt.pAfterClose(Dataset: TDataset);
Begin
  qryComEnd.Close;
  cdsComEnd.Close;
End;

procedure TComEnt.setCodEnt(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FCodEnt := Value
  Else
  Begin
    If (FTipEnt = tenSenha) Then
      Raise ExceptionAutCom.Create('O campo Senha do entregador deve ter um valor!')
    Else If (FTipEnt = tenBarras) Then
      Raise ExceptionAutCom.Create('O campo Código de Barras do entregador deve ter um valor!')
    Else
      Raise ExceptionAutCom.Create('O campo Código do entregador deve ter um valor!');
  End;

end;

procedure TComEnt.setDocume(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FDocume := Value
  Else
    Raise ExceptionAutCom.Create('O campo Documento deve ter um valor!');

end;

procedure TComEnt.setEmpDoc(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FEmpDoc := Value
  Else
    Raise ExceptionAutCom.Create('O campo Empresa deve ter um valor!');

end;

procedure TComEnt.setChaAce(const Value: String);
begin
  FChaAce := Value;
end;

procedure TComEnt.setCodCid(const Value: String);
begin

  If fEmptyStr(Value) And SameText(FEspDoc,'OS') Then
    Raise ExceptionAutCom.Create('O campo Cidade deve ter um valor!')
  Else
    FCodCid := Value;

end;

procedure TComEnt.setEspDoc(const Value: String);
begin

  If Not fEmptyStr(Value) Then
  Begin

    If Pos(Value, strEspPer) > 0 Then
      FEspDoc := Value
    Else
      Raise ExceptionAutCom.Create('Espécie ' + Value + ' não permitida!');

  End
  Else
    Raise ExceptionAutCom.Create('O campo Espécie deve ter um valor!');
    
end;

procedure TComEnt.setPlaVei(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FPlaVei := Value;
end;

procedure TComEnt.setProEnt(const Value: String);
begin

  If Not fEmptyStr(Value) Then
    FProEnt := Value
  Else
    Raise ExceptionAutCom.Create('O campo Prox.Entrega deve ter um valor!');

end;

procedure TComEnt.setTipEnt(const Value: TTipEnt);
begin
  FTipEnt := Value;
end;

procedure TComEnt.setInsDoc(const Value: TInsDoc);
begin
  FInsDoc := Value;
end;

Procedure TComEnt.pSqlNotas(qryGen: TUniQuery; strTabela: String);
Begin
  With qryGen, SQL Do
  Begin
    Add('SELECT ');
    Add('  END_NUMDOC, ');
    Add('  GER_CODCLI, ');
    Add('  GER_ENTFAT, ');
    Add('  CLI_NOMCLI, ');
    Add('  FIS_QTDNOT, ');
    Add('  GER_PESBRU, ');
    Add('  GER_PESLIQ, ');
    Add('  GER_VOLUME  ');
    Add('FROM ');
    Add(strTabela);
    Add('  JOIN CADCLI ON CLI_CODCLI = GER_CODCLI');
    Add('  LEFT JOIN COMEND ON END_NUMDOC = GER_NUMDOC AND ');
    Add('                      END_ESPDOC = GER_ESPDOC AND ');
    Add('                      END_EMPDOC = GER_CODEMP AND ');
    Add('                      END_CODCLI = GER_CODCLI     ');

    If Not fEmptyStr(qryComEng.FieldByName('AUTOINCREM').AsString) Then
      Add(' AND  END_SEQENG <> ' + QuotedStr(qryComEng.FieldByName('AUTOINCREM').AsString) );

    Add('                                                  ');
    Add('  LEFT JOIN CADFIS ON FIS_NUMDOC = GER_NUMDOC AND ');
    Add('                      FIS_ESPDOC = GER_ESPDOC AND ');
    Add('                      FIS_CODEMP = GER_CODEMP AND ');
    Add('                      FIS_FORCLI = GER_CODCLI AND ');
    Add('                      FIS_TIP_FC = "C" ');;
    Add('WHERE ');
    Add('  GER_NUMDOC = :NUMDOC AND ');
    Add('  GER_ESPDOC = :ESPDOC AND ');
    Add('  GER_CODEMP = :CODEMP AND ');
    Add('  GER_TIP_FC = "C" AND ');
    Add('  GER_CLAFIS > 5000 AND  ');
    Add('  GER_ORIDOC = "V" ');
  End;
End;

function TComEnt.fSqlPesos(strCampo: String): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' IF(END_ESPDOC NOT IN ("PR", "PC", "GA", "OS"), ';
  strSQL := strSQL + '     (SELECT ' + strCampo + ' FROM MOVGER  ';
  strSQL := strSQL + '      WHERE  GER_ESPDOC = END_ESPDOC   ';
  strSQL := strSQL + '      AND    GER_NUMDOC = END_NUMDOC   ';
  strSQL := strSQL + '      AND    GER_CODEMP = END_CODEMP   ';
  strSQL := strSQL + '      AND    GER_CODCLI = END_CODCLI   ';

  strSQL := strSQL + '      UNION ALL ';

  strSQL := strSQL + '      SELECT ' + strCampo + ' FROM NOTGER ';
  strSQL := strSQL + '      WHERE  GER_ESPDOC = END_ESPDOC ';
  strSQL := strSQL + '      AND    GER_NUMDOC = END_NUMDOC ';
  strSQL := strSQL + '      AND    GER_CODEMP = END_CODEMP ';
  strSQL := strSQL + '      AND    GER_CODCLI = END_CODCLI), 0.00) ';

  Result := strSQL;
end;

function TComEnt.fSQLVerificaEndereco: String;
  Var
  strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' (CASE WHEN (END_ESPDOC IN ("PC","GA","OS")) ';
  strSQL := strSQL + '               THEN ENTCLI.ETC_ENDFAT = "S" ';
  strSQL := strSQL + '               ELSE ENTCLI.AUTOINCREM IN (SELECT DISTINCT AUX_ENTGER ';
  strSQL := strSQL + '                                          FROM   MOVGER INNER JOIN AUXMOV ';
  strSQL := strSQL + '                                                                ON AUX_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '                                          WHERE  GER_ESPDOC = END_ESPDOC ';
  strSQL := strSQL + '                                          AND    GER_NUMDOC = END_NUMDOC ';
  strSQL := strSQL + '                                          AND    GER_CODEMP = END_CODEMP ';
  strSQL := strSQL + '                                          AND    GER_CODCLI = END_CODCLI ';
  strSQL := strSQL + ' ';
  strSQL := strSQL + '                                          UNION ALL ';
  strSQL := strSQL + ' ';
  strSQL := strSQL + '                                          SELECT DISTINCT AUX_ENTGER ';
  strSQL := strSQL + '                                          FROM   NOTGER INNER JOIN AUXNOT ';
  strSQL := strSQL + '                                                                ON AUX_SEQGER = NOTGER.AUTOINCREM ';
  strSQL := strSQL + '                                          WHERE  GER_ESPDOC = END_ESPDOC ';
  strSQL := strSQL + '                                          AND    GER_NUMDOC = END_NUMDOC ';
  strSQL := strSQL + '                                          AND    GER_CODEMP = END_CODEMP ';
  strSQL := strSQL + '                                          AND    GER_CODCLI = END_CODCLI) ';
  strSQL := strSQL + '  END) ';

  Result := strSQL;
end;

function TComEnt.getChaAce: String;
begin
  Result := FChaAce;
end;

function TComEnt.getInsDoc: TInsDoc;
begin
  Result := FInsDoc;
end;

function TComEnt.getTipEnt: TTipEnt;
begin
  Result := FTipEnt;
end;

procedure TComEnt.pValidaDocumentoDuplicado;
Begin

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Documento já cadastrado para outro entregador');
  objLiberacao.objMsgLibera.pAddSeparador(67);
  objLiberacao.objMsgLibera.pAddTextoCaption('Entregador ', FCodEnt +' - '+fRetNomeMotorista(FCodEnt));
  objLiberacao.objMsgLibera.pAddTextoCaption('Veículo    ', FPlaVei);
  objLiberacao.objMsgLibera.pAddSeparador(67);

  objLiberacao.strDirAce := 'ENTREP';
  objLiberacao.strSenLib := fCfgSis('ENTREP');
  objLiberacao.blnManterCompatibilidadeSenCfg := not fEmptyStr(objLiberacao.strSenLib);
  objLiberacao.strMsgSen := 'Documento já cadastrado.';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnMosMen := True;

  If (Not objLiberacao.fLibera) Then
    Raise ExceptionAutCom.Create('Esse documento já foi inserido em outra entrega!');

End;

{*****************************************}
{* INSERE REGISTRO NO CLIENT             *}
{**************************************AF*}
function TComEnt.fInsereRegistro: Boolean;
  Var
    qryGen: TUniQuery;
    strCid: String;
begin

  Result := False;

  Try
    qryGen := fCriaQuery;

    If FEspDoc = 'RQ' Then
    Begin
      With qryGen, SQL Do
      Begin
        DisableControls;
        Close;
        Clear;
        Add('SELECT ');
        Add('  END_NUMDOC, ');
        Add('  REQ_FORCLI, ');
        Add('  FOR_NOMFOR, ');
        Add('  REQ_BAIXAD  ');
        Add('FROM MOVRQG   ');
        Add('  JOIN CADFOR ON FOR_CODFOR = REQ_FORCLI ');
        Add('  LEFT JOIN COMEND ON END_NUMDOC = REQ_NUMREQ AND ');
        Add('                      END_ESPDOC = "RQ"       AND ');
        Add('                      END_EMPDOC = REQ_CODEMP AND ');
        Add('                      END_CODCLI = REQ_FORCLI     ');

        Add('WHERE REQ_NUMREQ = :NUMDOC ');
        Add('  AND REQ_CODEMP = :CODEMP ');

        ParamByName('NUMDOC').AsString := FDocume;
        ParamByName('CODEMP').AsString := FEmpDoc;
        Open;
        EnableControls;

        If IsEmpty Then
          Raise ExceptionAutCom.Create('Documento não encontrado!');

        If FieldByName('REQ_BAIXAD').AsString = 'S' Then
          Raise ExceptionAutCom.Create('Requisição de compra já baixada!!');

        If Not fEmptyStr(FieldByName('END_NUMDOC').AsString) Then
          pValidaDocumentoDuplicado;

        FCodCli := FieldByName('REQ_FORCLI').AsString;
        FNomCli := FieldByName('FOR_NOMFOR').AsString;
        FQtdNot := 0;

        Close;
      End;
    End
    Else
    If FEspDoc = 'PC' Then
    Begin

      With qryGen, SQL Do
      Begin
        DisableControls;
        Close;
        Clear;
        Add('SELECT ');
        Add('  END_NUMDOC, ');
        Add('  PCG_CODFOR, ');
        Add('  FOR_NOMFOR  ');
        Add('FROM ');
        Add('  PCMGER ');
        Add('  JOIN CADFOR ON FOR_CODFOR = PCG_CODFOR ');
        Add('  LEFT JOIN COMEND ON END_NUMDOC = PCG_NUMPED AND ');
        Add('                      END_ESPDOC = "PC"       AND ');
        Add('                      END_EMPDOC = PCG_CODEMP AND ');
        Add('                      END_CODCLI = PCG_CODFOR     ');

        If Not fEmptyStr(qryComEng.FieldByName('AUTOINCREM').AsString) Then
          Add(' AND  END_SEQENG <> ' + QuotedStr(qryComEng.FieldByName('AUTOINCREM').AsString) );

        Add('WHERE ');
        //Add('  FOR_CODFOR = PCG_CODFOR AND ');
        Add('  PCG_NUMPED = :NUMDOC AND ');
        Add('  PCG_ESPDOC = "PD"    AND ');
        Add('  PCG_CODEMP = :CODEMP     ');
        ParamByName('NUMDOC').AsString := FDocume;
        ParamByName('CODEMP').AsString := FEmpDoc;
        Open;
        EnableControls;

        If IsEmpty Then
          Raise ExceptionAutCom.Create('Documento não encontrado!');

        If Not fEmptyStr(FieldByName('END_NUMDOC').AsString) Then
          pValidaDocumentoDuplicado;

        FCodCli := FieldByName('PCG_CODFOR').AsString;
        FNomCli := FieldByName('FOR_NOMFOR').AsString;
        FQtdNot := 0;
        FPesBru := 0;
        FPesLiq := 0;
        FVolume := 0;

        Close;
      End;

    End
    Else If FEspDoc = 'GA' Then
    Begin

      With qryGen, SQL Do
      Begin
        DisableControls;
        Close;
        Clear;
        Add('SELECT ');
        Add('  END_NUMDOC, ');
        Add('  GAG_CODCLI, ');
        Add('  CLI_NOMCLI  ');
        Add('FROM ');
        Add('  MOVGAG ');
        Add('  JOIN CADCLI ON CLI_CODCLI = GAG_CODCLI ');
        Add('  LEFT JOIN COMEND ON END_NUMDOC = GAG_NUMENT AND ');
        Add('                      END_ESPDOC = "GA"       AND ');
        Add('                      END_EMPDOC = GAG_CODEMP AND ');
        Add('                      END_CODCLI = GAG_CODCLI     ');

        If Not fEmptyStr(qryComEng.FieldByName('AUTOINCREM').AsString) Then
          Add(' AND  END_SEQENG <> ' + QuotedStr(qryComEng.FieldByName('AUTOINCREM').AsString) );
        
        Add('WHERE ');
        //Add('  CLI_CODCLI = GAG_CODCLI AND ');
        Add('  GAG_NUMENT = :NUMDOC AND ');
        Add('  GAG_CODEMP = :CODEMP     ');
        ParamByName('NUMDOC').AsString := FDocume;
        ParamByName('CODEMP').AsString := FEmpDoc;
        Open;
        EnableControls;

        If IsEmpty Then
          Raise ExceptionAutCom.Create('Documento não encontrado!');

        If Not fEmptyStr(FieldByName('END_NUMDOC').AsString) Then
          pValidaDocumentoDuplicado;

        FCodCli := FieldByName('GAG_CODCLI').AsString;
        FNomCli := FieldByName('CLI_NOMCLI').AsString;
        FQtdNot := 0;
        FPesBru := 0;
        FPesLiq := 0;
        FVolume := 0;

        Close;
      End;

    End
    Else If FEspDoc = 'OS' Then
    Begin

      With qryGen, SQL Do
      Begin
        DisableControls;
        Close;
        Clear;
        Add('SELECT ');
        Add('  END_NUMDOC, ');
        Add('  MSG_OPEENV, ');
        Add('  OPE_NOMOPE  ');
        Add('FROM ');
        Add('  CADMSG ');
        Add('  JOIN CADOPE ON OPE_CODOPE = MSG_OPEENV ');
        Add('  LEFT JOIN COMEND ON RIGHT(END_NUMDOC, 6) = MSG_CODMSG AND ');
        Add('                      END_ESPDOC = "OS"       AND ');
        Add('                      END_EMPDOC = MSG_EMPENV     ');

        If Not fEmptyStr(qryComEng.FieldByName('AUTOINCREM').AsString) Then
          Add(' AND  END_SEQENG <> ' + QuotedStr(qryComEng.FieldByName('AUTOINCREM').AsString) );
        
        Add('WHERE ');
        Add('  MSG_CODMSG = :NUMDOC AND ');
        Add('  MSG_EMPENV = :CODEMP     ');

        If LeftStr(FDocume, 6) = '000000' Then
          ParamByName('NUMDOC').AsString := RightStr(FDocume, 6)
        Else
          ParamByName('NUMDOC').AsString := FDocume;

        ParamByName('CODEMP').AsString := FEmpDoc;
        Open;
        EnableControls;

        If IsEmpty Then
          Raise ExceptionAutCom.Create('Documento não encontrado!');

        If Not fEmptyStr(FieldByName('END_NUMDOC').AsString) Then
          pValidaDocumentoDuplicado;

        FCodCli := FieldByName('MSG_OPEENV').AsString;
        FNomCli := FieldByName('OPE_NOMOPE').AsString;
        FQtdNot := 0;
        FPesBru := 0;
        FPesLiq := 0;
        FVolume := 0;

        Close;
      End;

    End

    Else If FEspDoc = 'PR' Then
    Begin

      With qryGen, SQL Do
      Begin
        DisableControls;
        Close;
        Clear;
        Add('SELECT ');
        Add('  END_NUMDOC, ');
        Add('  FGO_CODCLI, ');
        Add('  CLI_NOMCLI  ');
        Add('FROM ');
        Add('  FATGOR ');
        Add('  JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ');
        Add('  LEFT JOIN COMEND ON END_NUMDOC = FGO_NUMDOC AND ');
        Add('                      END_ESPDOC = "PR"       AND ');
        Add('                      END_EMPDOC = FGO_CODEMP AND ');
        Add('                      END_CODCLI = FGO_CODCLI     ');

        If Not fEmptyStr(qryComEng.FieldByName('AUTOINCREM').AsString) Then
          Add(' AND  END_SEQENG <> ' + QuotedStr(qryComEng.FieldByName('AUTOINCREM').AsString) );

        Add('WHERE ');
        //Add('  CLI_CODCLI = FGO_CODCLI AND ');
        Add('  FGO_NUMDOC = :NUMDOC AND ');
        Add('  FGO_CODEMP = :CODEMP AND ');
        Add('  FGO_ESPDOC = "PR"');
        ParamByName('NUMDOC').AsString := FDocume;
        ParamByName('CODEMP').AsString := FEmpDoc;
        Open;
        EnableControls;

        If IsEmpty Then
          Raise ExceptionAutCom.Create('Documento não encontrado!');

        If Not fEmptyStr(FieldByName('END_NUMDOC').AsString) Then
          pValidaDocumentoDuplicado;

        FCodCli := FieldByName('FGO_CODCLI').AsString;
        FNomCli := FieldByName('CLI_NOMCLI').AsString;
        FQtdNot := 0;
        FPesBru := 0;
        FPesLiq := 0;
        FVolume := 0;

        Close;
      End;

    End

    Else
    Begin
      With qryGen, SQL Do
      Begin
        DisableControls;
        Close;
        Clear;

        pSqlNotas(qryGen,'MOVGER');

        Add('  UNION ALL ');

        pSqlNotas(qryGen,'NOTGER');

        Add('  LIMIT 1 ');

        ParamByName('NUMDOC').AsString := FDocume;
        ParamByName('ESPDOC').AsString := FEspDoc;
        ParamByName('CODEMP').AsString := FEmpDoc;

        Open;
        EnableControls;

        If IsEmpty Then
          Raise ExceptionAutCom.Create('O documento ' + FDocume + '-' + FEspDoc + '-' + FEmpDoc +  ' não foi encontrado nos registros de venda.' + #13#10 +
                                       'Verifique com o responsável pelo faturamento.');

        If FieldByName('GER_ENTFAT').AsString <> 'S' Then
          Raise ExceptionAutCom.Create('Esse documento não foi criado com a opção de Entrega!');

        If Not fEmptyStr(FieldByName('END_NUMDOC').AsString) Then
          pValidaDocumentoDuplicado;

        FCodCli := FieldByName('GER_CODCLI').AsString;
        FNomCli := FieldByName('CLI_NOMCLI').AsString;
        FQtdNot := FieldByName('FIS_QTDNOT').AsInteger;
        FPesBru := FieldByName('GER_PESBRU').AsFloat;
        FPesLiq := FieldByName('GER_PESLIQ').AsFloat;
        FVolume := FieldByName('GER_VOLUME').AsFloat;

        Close;
      End;
    End;

    With cdsComEnd Do
    Begin
      DisableControls;
      If Locate('END_NUMDOC;END_ESPDOC;END_EMPDOC', VarArrayOf([FDocume,FEspDoc,FEmpDoc]),[]) Then
      Begin
        EnableControls;
        Raise ExceptionAutCom.Create('Documento já inserido!');
      End;

      Append;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMEND',VS_strCodEmp);
      FieldByName('END_SEQENG').AsString := '123456';
      FieldByName('END_CODEMP').AsString := VS_strCodEmp;
      FieldByName('END_NUMDOC').AsString := FDocume;
      FieldByName('END_ESPDOC').AsString := FEspDoc;
      FieldByName('END_EMPDOC').AsString := FEmpDoc;
      FieldByName('END_CODCLI').Value    := IIF(FEspDoc = 'OS', Null, FCodCli);
      FieldByName('END_QTDNOT').AsInteger := FQtdNot;
      FieldByName('CLI_CODCLI').AsString := FCodCli + '-' + FNomCli;

      If Not fEmptyStr(FCodCid) Then
      Begin
        strCid := FCodCid;
        FieldByName('END_CODCID').AsString := FCodCid;
      End

      Else If SameText(FEspDoc, 'PC') Then
        strCid := fRetCidFornecedor(FCodCli)

      Else
        strCid := fRetornaCodCidCliente(FCodCli, FDocume, FEspDoc, FEmpDoc);

      FieldByName('CID_CODCID').AsString := strCid + '-' + fRetNomCidade(strCid);
      FieldByName('GER_PESBRU').AsFloat  := FPesBru;
      FieldByName('GER_PESLIQ').AsFloat  := FPesLiq;
      FieldByName('GER_VOLUME').AsFloat  := FVolume;

      Post;
      EnableControls;
      Result := True;
    End;
  Except
    On E: ExceptionAutCom Do
      fMensagem('',E.Message,['&OK']);

    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  FreeAndNil(qryGen);
end;

{*******************************************}
{* SALVA REGISTROS DO CLIENT PARA A TABELA *}
{****************************************AF*}
procedure TComEnt.pSalvaComEnd;
begin
  cdsComEnd.DisableControls;
  cdsComEnd.First;
  While Not cdsComEnd.Eof Do
  Begin
    cdsComEnd.Edit;
    cdsComEnd.FieldByName('END_SEQENG').AsString := qryComEng.FieldByName('AUTOINCREM').AsString;
    cdsComEnd.Post;

    cdsComEnd.Next;
  End;

  cdsComEnd.ApplyUpdates(0);
  cdsComEnd.EnableControls;
end;

procedure TComEnt.pAlteraSituacaoMotorista(strSituacao: String);
var
  qryMotorista: TUniQuery;
begin
  if fEmptyStr(strCodEnt) then
    Exit;

  qryMotorista := fCriaQuery;

  try
    if strSituacao = 'D' then
    begin
      qryMotorista.Close;
      qryMotorista.SQL.Clear;
      qryMotorista.SQL.Add('SELECT MOT.MOT_CODMOT');
      qryMotorista.SQL.Add('FROM CADMOT MOT');
      qryMotorista.SQL.Add('INNER JOIN COMENG ENG');
      qryMotorista.SQL.Add('ON(MOT.MOT_CODMOT = ENG.ENG_CODENT)');
      qryMotorista.SQL.Add('INNER JOIN COMEND EN');
      qryMotorista.SQL.Add('ON(EN.END_SEQENG = ENG.AUTOINCREM)');
      qryMotorista.SQL.Add('WHERE MOT.MOT_CODMOT = :CODMOT');
      qryMotorista.SQL.Add('AND EN.END_DTABAI IS NULL');
      qryMotorista.SQL.Add('AND EN.END_HRABAI IS NULL');
      qryMotorista.ParamByName('CODMOT').AsString := strCodEnt;
      qryMotorista.Open;

      if not qryMotorista.IsEmpty then
        Exit;
    end;

    qryMotorista.Close;
    qryMotorista.SQL.Clear;
    qryMotorista.SQL.Add('UPDATE CADMOT');
    qryMotorista.SQL.Add('SET MOT_SITUAC = :SITUAC ');
    qryMotorista.SQL.Add('WHERE MOT_CODMOT = :CODMOT');
    qryMotorista.ParamByName('SITUAC').AsString := strSituacao;
    qryMotorista.ParamByName('CODMOT').AsString := strCodEnt;
    qryMotorista.ExecSQL;
  finally
    FreeAndNil(qryMotorista);
  end;
end;

function TComEnt.fSetaDadosDocumentoChaveAcesso: Boolean;
Var
  strSQL: String;
  qryFis: TUniQuery;
begin

  Result := False;

  Try

    qryFis := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  FIS_NUMDOC, ';
    strSQL := strSQL + '  FIS_ESPDOC, ';
    strSQL := strSQL + '  FIS_CODEMP  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  CADFIS      ';
    strSQL := strSQL + 'WHERE         ';
    strSQL := strSQL + '  FIS_ACESSO = :ACESSO ';

    With qryFis Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('ACESSO').AsString := getChaAce;
      Open;

      If (Not IsEmpty) Then
      Begin
        setDocume(FieldByName('FIS_NUMDOC').AsString);
        setEspDoc(FieldByName('FIS_ESPDOC').AsString);
        setEmpDoc(FieldByName('FIS_CODEMP').AsString);
        Result := True;
      End;
    End;

  Finally
    FreeAndNil(qryFis);
  End;
end;

function TComEnt.fGravaComEnd(strSeqEng,
                              strNumDoc,
                              strEspeci,
                              strEmpres,
                              strClient,
                              strCodCid: String;
                              intNotas: Integer): Boolean;
begin

  Try

    With qryComEnd Do
    Begin
      DisableControls;
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM COMEND WHERE FALSE');
      Open;

      Insert;
      FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('COMEND',VS_strCodEmp);
      FieldByName('END_SEQENG').AsString := strSeqEng;
      FieldByName('END_CODEMP').AsString := VS_strCodEmp;
      FieldByName('END_NUMDOC').AsString := strNumDoc;
      FieldByName('END_ESPDOC').AsString := strEspeci;
      FieldByName('END_EMPDOC').AsString := strEmpres;
      FieldByName('END_CODCLI').Value    := IIF(strEspeci = 'OS', Null, strClient);
      FieldByName('END_QTDNOT').AsInteger:= intNotas;

      If Not fEmptyStr(strCodCid) Then
        FieldByName('END_CODCID').AsString := strCodCid;

      Post;
      EnableControls;
    End;

    Result := False;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

end;

procedure TComEnt.pImprimeRegistro(strImpEnd, strImpAss : String; intTipRel: Integer);
  Var
    frmQckCadComEntregadores: TfrmQckCadComEntregadores;
    frxRelatorio: TfrxReport;
    strNomeFila: String;
    strTipImp  : String;
    strSalto   : String;
    intContador: Integer;
    qryCfgRel  : TUniQuery;
    qryRelatorio: TUniQuery;
    cdsRelatorio: TUniClientDataSet;
  Const
    COLUNAS_80 = '1';
    COLUNAS_40 = '2';
begin
  strSalto := '';

  Try
    pCriarFormularios(TfrmQckCadComEntregadores, frmQckCadComEntregadores);

    qryRelatorio := fCriaQuery(nil);

    With qryRelatorio Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  GER_VLRCON AS VLRTOT, ');
      SQL.Add(' GER_CONPAG  AS CONPAG, ');
      SQL.Add(' GER_MEN001  AS MEN001, ');
      SQL.Add(' GER_MEN002  AS MEN002, ');
      If fCfgSis('USAFPG',varBoolean) Then
        SQL.Add(' CND_DESCRI AS FORPAG, ')
      Else
        SQL.Add('  "" AS FORPAG, ');
      SQL.Add('  ENG_PROENT, ');
      SQL.Add('  ENG_DTACAD, ');
      SQL.Add('  CONCAT(LEFT(ENG_PLAVEI,3),"-",RIGHT(ENG_PLAVEI,4)) AS ENG_PLAVEI, ');
      SQL.Add('  END_QTDNOT, ');
      SQL.Add('  END_ESPDOC AS ESPDOC, ');
      SQL.Add('  END_NUMDOC AS NUMDOC, ');
      SQL.Add('  CONCAT(ENG_CODENT,"-",MOT_NOMMOT) AS ENG_CODENT, ');
      SQL.Add('  CONCAT(END_NUMDOC,"-",END_ESPDOC,"-",END_EMPDOC) AS END_NUMDOC, ');
      SQL.Add('  IF(END_ESPDOC = "OS", LPAD(" ", 40, " "), ');//Realizado na impressao
      SQL.Add('  IF(END_ESPDOC = "PC", CONCAT(END_CODCLI,"-",FOR_NOMFOR), ');
      SQL.Add('                        CONCAT(END_CODCLI,"-",CLI_NOMCLI))) AS CLI_CODCLI, ');
      SQL.Add('  CONCAT(IF(ETC_ENDENT IS NULL, IFNULL(CONCAT(CLI_ENDERE, ", ", CLI_ENDNUM), CLI_ENDERE), ETC_ENDENT), " - ", ');
      SQL.Add('         IF(ETC_BAIENT IS NULL, CLI_BAIRRO, ETC_BAIENT)) AS CLI_ENDERE, ');
      SQL.Add('  CONCAT(IF(ETC_CIDENT IS NULL, CC.CID_NOMCID, CE.CID_NOMCID), "/", ');
      SQL.Add('         IF(ETC_CIDENT IS NULL, CC.CID_ESTADO, CE.CID_ESTADO)) AS CLI_CIDADE, ');
      SQL.Add(  fSqlPesos('GER_PESBRU') + ' AS PESBRU, ');
      SQL.Add(  fSqlPesos('GER_PESLIQ') + ' AS PESLIQ, ');
      SQL.Add(  fSqlPesos('GER_VOLUME') + ' AS VOLUME  ');
      SQL.Add('FROM ');
      SQL.Add('  COMENG ');
      SQL.Add('  JOIN COMEND      ON END_SEQENG = COMENG.AUTOINCREM ');
      SQL.Add('  JOIN CADMOT      ON MOT_CODMOT = ENG_CODENT ');
      SQL.Add('  LEFT JOIN CADCLI ON CLI_CODCLI = END_CODCLI ');
      SQL.Add('  LEFT JOIN ENTCLI ON ETC_CODCLI = END_CODCLI AND (' + fSQLVerificaEndereco + ')');
      SQL.Add('  LEFT JOIN CADFOR ON FOR_CODFOR = END_CODCLI ');
      SQL.Add('  LEFT JOIN CADCID CC ON CC.CID_CODCID = CLI_CODCID ');
      SQL.Add('  LEFT JOIN CADCID CE ON CE.CID_CODCID = ETC_CIDENT ');
      SQL.Add('  LEFT JOIN MOVGER ON GER_NUMDOC = END_NUMDOC AND END_ESPDOC NOT IN ("PD", "OR") ');
      SQL.Add('  AND  END_ESPDOC = GER_ESPDOC AND END_CODCLI = GER_CODCLI AND  END_EMPDOC = GER_CODEMP ');

      If fCfgSis('USAFPG',varBoolean) Then
        SQL.Add('  LEFT JOIN CADCND ON CND_CODIGO = GER_CODCND ');

      SQL.Add('WHERE ');
      SQL.Add('  COMENG.AUTOINCREM = :AUTINC ');
      ParamByName('AUTINC').AsString := qryComEng.FieldByName('AUTOINCREM').AsString;
      Open;

      cdsRelatorio := fCriaClientDatset(qryRelatorio);

      cdsRelatorio.First;

      While Not cdsRelatorio.Eof Do
      Begin
        If cdsRelatorio.FieldByName('ESPDOC').AsString = 'OS' Then
        Begin
          cdsRelatorio.Edit;
          cdsRelatorio.FieldByName('CLI_CODCLI').AsString :=
            TMsgInterna.fRetOperadorEnvio(RightStr(cdsRelatorio.FieldByName('NUMDOC').AsString, 6));
          cdsRelatorio.Post;
        End;
        cdsRelatorio.Next;
      End;

      cdsRelatorio.First;

      frmQckCadComEntregadores.frxRelatorio.DataSet := cdsRelatorio;

      qryCfgRel := fCriaQuery;
      pCarregaConfImpr(qryCfgRel, 'frmCadComEntregadores');

      if fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False) then
      begin
        strNomeFila := AnsiReplaceStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString, '\\' + fRetNomeRede + '\', '');
        FreeAndNil(qryCfgRel);

        If strTipImp = 'M' Then
        Begin
          If fCfgSis('MODICE') = COLUNAS_80 Then
          Begin
            frxRelatorio := frmQckCadComEntregadores.frxQckEntrega80M;
          End
          Else
          Begin
            frxRelatorio := frmQckCadComEntregadores.frxQckEntrega40M;
          End;
        End
        Else
        Begin
          if fCfgSis('MODICE') = COLUNAS_80 then
          begin
            If intTipRel = 0 Then
              frxRelatorio := frmQckCadComEntregadores.frxQckEntrega80J
            Else
              frxRelatorio := frmQckCadComEntregadores.frxQckEntrega80JRetrato;

            frxRelatorio.DotMatrixReport := False;
            If (strImpEnd <> 'S') Then
            Begin
              TfrxMemoView(frxRelatorio.FindObject('rllFaixa')).Height := TfrxMemoView(frxRelatorio.FindObject('rllFaixa')).Height -
                                                                          TfrxMemoView(frxRelatorio.FindObject('rllEndEnt')).Height;
            End;
            If (strImpAss = 'S') Then
            Begin
              TfrxLineView(frxRelatorio.FindObject('linImpAss')).Top     := 33;
            End;
          end
          else
          begin
            frxRelatorio := frmQckCadComEntregadores.frxQckEntrega40J;
          end;
        End;

        if fCfgSis('MODICE') = COLUNAS_40 then
        begin
          {*******************************************}
          {* CONTROLA O SALTO                        *}
          {****************************************AC*}
          If fCfgSis('QTDSAL', varInteger) > 0 Then
          Begin
            For intContador := 1 To fCfgSis('QTDSAL', varInteger) Do
            Begin
              strSalto := strSalto + '       ' + #13#10;
            End;
          End;

          TfrxMemoView(frxRelatorio.FindObject('Child1')).Visible := strImpEnd = 'S';
          frxRelatorio.Script.Variables['SALTO'] := strSalto;
        end;

        If (strImpEnd <> 'S') Then
        Begin
          TfrxMemoView(frxRelatorio.FindObject('rlbHeader')).Height  := TfrxMemoView(frxRelatorio.FindObject('rlbHeader')).Height -
                                                                        TfrxMemoView(frxRelatorio.FindObject('rllEndEnt')).Height;
          TfrxMemoView(frxRelatorio.FindObject('rllEndEnt')).Visible := False;
          TfrxMemoView(frxRelatorio.FindObject('rlbEndEnt')).Visible := False;

          if fCfgSis('MODICE') = COLUNAS_40 then
          begin
            TfrxMemoView(frxRelatorio.FindObject('rllLinha')).Top := TfrxMemoView(frxRelatorio.FindObject('rllLinha')).Top -
                                                                     TfrxMemoView(frxRelatorio.FindObject('rllEndEnt')).Height;
            TfrxMemoView(frxRelatorio.FindObject('rllTitAss')).Top := TfrxMemoView(frxRelatorio.FindObject('rllTitAss')).Top -
                                                                      TfrxMemoView(frxRelatorio.FindObject('rlbEndEnt')).Height;
            TfrxLineView(frxRelatorio.FindObject('linImpAss')).Top := TfrxLineView(frxRelatorio.FindObject('linImpAss')).Top -
                                                                      TfrxMemoView(frxRelatorio.FindObject('rlbEndEnt')).Height;
          end;
        End;

        TfrxMemoView(frxRelatorio.FindObject('rllTitAss')).Visible := strImpAss = 'S';
        TfrxLineView(frxRelatorio.FindObject('linImpAss')).Visible := strImpAss = 'S';
        If (strImpAss <> 'S') and (fCfgSis('MODICE') = COLUNAS_40) Then
        begin
          TfrxMemoView(frxRelatorio.FindObject('rllTitAss')).Top := 1+TfrxMemoView(frxRelatorio.FindObject('rlbEndEnt')).Top;
          TfrxLineView(frxRelatorio.FindObject('linImpAss')).Top := 1+TfrxMemoView(frxRelatorio.FindObject('rlbEndEnt')).Top;
        end;

        If (strImpAss = 'S') and (fCfgSis('MODICE') = COLUNAS_80) Then
        Begin
          If intTipRel = 0 Then // paisagem
            TfrxLineView(frxRelatorio.FindObject('linTotGer')).Visible := Not TfrxLineView(frxRelatorio.FindObject('linImpAss')).Visible;
        End;

        If (fCfgSis('MODICE') = COLUNAS_80) And (strImpAss = 'N') And (strImpEnd = 'N') Then
          TfrxMasterData(frxRelatorio.FindObject('rlbMaster')).Height := TfrxMemoView(frxRelatorio.FindObject('rllNumDoc')).Height;

        frxRelatorio.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

        If (Not fEmptyStr(strNomeFila)) Then
        Begin
          frxRelatorio.PrintOptions.ShowDialog := False;
          frxRelatorio.PrintOptions.Printer    := strNomeFila;
        End;

        pPreviewReport('frmCadComEntregadores', 'Controle de Entregadores', frxRelatorio);
      end;
    End;

    FreeAndNil(cdsRelatorio);
    FreeAndNil(qryRelatorio);

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
  FreeAndNil(frmQckCadComEntregadores);

end;

destructor TComEnt.Destroy;
begin
  If cdsComEnd.Active Then
    cdsComEnd.Close;

  FreeAndNil(cdsComEnd);
  FreeAndNil(cpvComEnd);
  FreeAndNil(qryComEnd);
  FreeAndNil(qryComEng);

  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

end;

function TComEnt.fEntregaBaixada(strCodEntrega: String): Boolean;
  Var
    qryBusca: TUniQuery;
begin
  qryBusca := fCriaQuery(Nil);

  With qryBusca Do
  Begin
    sql.Add(' SELECT ENG_DTABAI FROM COMENG WHERE ENG_PROENT = :PROENT ');
    ParamByName('PROENT').AsString := strCodEntrega;
    Open;

    If IsEmpty Then
      Result := False
    Else If Fields[0].IsNull Then
      Result := False
    Else
      Result := True;

  End;

  FreeAndNil(qryBusca);
end;

function TComEnt.fRetornaCodCidCliente(strCodCli, strNumDoc, strEspDoc, strCodEmp: String): String;
Var
  strSQL   : String;
  strCodCid: String;
  qryGen   : TUniQuery;
begin
  Try

    qryGen    := fCriaQuery;
    strCodCid := '';

    If (fClienteConsumidor(fRetNomCliente(strCodCli))) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE    ';
      strSQL := strSQL + '  GER_CIDCON AS CODCID ';
      strSQL := strSQL + 'FROM                   ';
      strSQL := strSQL + '  MOVGER               ';
      strSQL := strSQL + 'WHERE                  ';
      strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  GER_CODEMP = :CODEMP     ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        strCodCid := FieldByName('CODCID').AsString;
      End;
    End;

    If (fEmptyStr(strCodCid)) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  ETC_CIDENT ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  ENTCLI ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  ETC_CODCLI = :CODCLI ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODCLI').AsString := strCodCli;
        Open;
      End;

      If (Not qryGen.IsEmpty) Then
        Result := qryGen.FieldByName('ETC_CIDENT').AsString
      Else
        Result := fRetCidCliente(strCodCli);
    End
    Else
      Result := strCodCid;      

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[fRetornaCodCidCliente]');
  End;

  freeAndNil(qryGen);
end;

end.
