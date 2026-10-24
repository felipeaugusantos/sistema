unit untSEPDOR_CONDOR;

interface

uses
  System.SysUtils, System.Classes, untFuncoesSimples, Uni, UniClientDataSet,
  untTypesSistema, untDocPDOR, Shared.Functions.Monitores;

type

  TLogAbstract = Class Abstract
  Private
    FDtaIni : TDateTime;
    FOpeCon : String;
    FDocume : TRecDocumento;
    FItens_ : TUniQuery;
    procedure pCarregaItensPedido; Virtual;
  Public

    constructor Create;
    destructor Destroy; Override;

    procedure pIniciou;

    procedure pGravar; Virtual;

    procedure pSetNumDoc(ANumDoc : String);
    procedure pSetEspDoc(AEspDoc : String);
    procedure pSetEmpDoc(AEmpDoc : String);
    procedure pSetOpeCon(AOpeCon : String);

  End;

  TSepDor = Class(TLogAbstract)
  Private
    procedure pCarregaItensPedido; Override;
  Public
    procedure pGravar; Override;
  End;

  TConDor = Class(TLogAbstract)
  Private
    FCdsExp : TUniClientDataSet;
    procedure pCarregaItensPedido; Override;
    procedure pGravarClientItens;
  Public
    procedure pSetClientItens(AItens : TUniClientDataSet);
    procedure pGravar; Override;
  End;

implementation

{ TSepDor }

procedure TSepDor.pCarregaItensPedido;
begin
  FItens_.Close;
  FItens_.SQL.Clear;
  FItens_.SQL.Add('SELECT                    ');
  FItens_.SQL.Add('  F.AUTOINCREM AS FDOINC, ');
  FItens_.SQL.Add(TLeDocumentoPDOR.fSQLQtdIte(FDocume) + ' AS QTDITE ');
  FItens_.SQL.Add('FROM            ');
  FItens_.SQL.Add('  FATDOR F      ');
  FItens_.SQL.Add('  INNER JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM ');

  If fUsaRotinaWMS Then
  Begin
    FItens_.SQL.Add('  INNER JOIN LOTDOR L ON L.LDO_SEQFDO = F.AUTOINCREM ');
    FItens_.SQL.Add('  INNER JOIN DEL_LOTDOR LD ON LD.LDO_SEQFDO = F.AUTOINCREM ');
  End;

  FItens_.SQL.Add('WHERE                        ');
  FItens_.SQL.Add('  F.FDO_NUMDOC = :NUMDOC AND ');
  FItens_.SQL.Add('  F.FDO_ESPDOC = :ESPDOC AND ');
  FItens_.SQL.Add('  F.FDO_CODEMP = :CODEMP     ');

  FItens_.ParamByName('NUMDOC').AsString := FDocume.strNumDoc;
  FItens_.ParamByName('ESPDOC').AsString := FDocume.strEspDoc;
  FItens_.ParamByName('CODEMP').AsString := FDocume.strCodEmp;

  FItens_.Open;
end;

procedure TSepDor.pGravar;
Var
  qryExcSQL: TUniQuery;
  LstrSQLUpd: String;
  LstrSQLIns: String;
  LSLUpdate: TStringList;
  LstrAdd: String;
  LAutInc: String;
  LDtaHraServidor: TDateTime;
begin
  pCarregaItensPedido;

  If FItens_.IsEmpty Then
    Exit;

  qryExcSQL := fCriaQuery();
  LSLUpdate := TStringList.Create;
  Try
    LDtaHraServidor := fRetDtaHraServidor;
    LSLUpdate.Clear;

    LstrSQLIns := '';
    LstrSQLIns := LstrSQLIns + 'INSERT INTO SEPDOR_AUTCOM (AUTOINCREM, SEP_SEQFDO, SEP_QTDCON, SEP_OPECON, SEP_CONFIN, SEP_DTAINI, SEP_DTAFIN)';
    LstrSQLIns := LstrSQLIns + ' VALUES (:AUTINC, :SEQFDO, :QTDCON, :OPECON, :CONFIN, :DTAINI, :DTAFIN)';

    LstrSQLUpd := 'UPDATE SEPDOR_AUTCOM SET SEP_OPECON = :OPECON, SEP_DTAFIN = :DTAFIN WHERE AUTOINCREM = :AUTINC;';

    FItens_.First;
    While Not FItens_.Eof Do
    Begin
      LAutInc := fCampoTabela('AUTOINCREM', 'SEPDOR_AUTCOM', ['SEP_SEQFDO'], [FItens_.FieldByName('FDOINC').AsString]);

      If fEmptyStr(LAutInc) Then
      Begin
        LstrAdd := LstrSQLIns;

        LstrAdd := StringReplace(LstrAdd, ':AUTINC', QuotedStr(fRetAutoIncrem('SEPDOR_AUTCOM', VS_strCodEmp)),          [rfReplaceAll]);
        LstrAdd := StringReplace(LstrAdd, ':SEQFDO', QuotedStr(FItens_.FieldByName('FDOINC').AsString),                 [rfReplaceAll]);
        LstrAdd := StringReplace(LstrAdd, ':QTDCON', fDoubleToSQL(FItens_.FieldByName('QTDITE').AsFloat),               [rfReplaceAll]);
        LstrAdd := StringReplace(LstrAdd, ':OPECON', QuotedStr(FOpeCon),                                                [rfReplaceAll]);
        LstrAdd := StringReplace(LstrAdd, ':CONFIN', QuotedStr('N'),                                                    [rfReplaceAll]);
        LstrAdd := StringReplace(LstrAdd, ':DTAINI', QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', FDtaIni)),         [rfReplaceAll]);
        LstrAdd := StringReplace(LstrAdd, ':DTAFIN', QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', LDtaHraServidor)), [rfReplaceAll]);

        qryExcSQL.Close();
        qryExcSQL.SQL.Text := LstrAdd;
        qryExcSQL.ExecSQL();
      End
      Else
      Begin
        LstrAdd := LstrSQLUpd;

        LstrAdd := StringReplace(LstrAdd, ':AUTINC', QuotedStr(LAutInc),                                                [rfReplaceAll]);
        LstrAdd := StringReplace(LstrAdd, ':OPECON', QuotedStr(FOpeCon),                                                [rfReplaceAll]);
        LstrAdd := StringReplace(LstrAdd, ':DTAFIN', QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', LDtaHraServidor)), [rfReplaceAll]);

        LSLUpdate.Add(LstrAdd);
      End;

      FItens_.Next;
    End;

    If LSLUpdate.Count > 0 Then
    Begin
      qryExcSQL.Close();
      qryExcSQL.SQL.Text := LSLUpdate.Text;
      qryExcSQL.ExecSQL();
    End;
  Finally
    FreeAndNil(qryExcSQL);
    FreeAndNil(LSLUpdate);
  End;
end;

{ TLog }

constructor TLogAbstract.Create;
begin
  FillChar(FDocume, SizeOf(FDocume), #0);
  FDocume.blnDocSep := True;

  FItens_ := fCriaQuery;
end;

destructor TLogAbstract.Destroy;
begin
  inherited;
  FreeAndNil(FItens_);
end;

procedure TLogAbstract.pCarregaItensPedido;
begin
  //
end;

procedure TLogAbstract.pGravar;
begin
  //
end;

procedure TLogAbstract.pIniciou;
begin
  FDtaIni := fRetDtaHraServidor;
  FOpeCon := strLoginUsuarioLogado;
end;

procedure TLogAbstract.pSetEmpDoc(AEmpDoc: String);
begin
  FDocume.strCodEmp := AEmpDoc;
end;

procedure TLogAbstract.pSetEspDoc(AEspDoc: String);
begin
  FDocume.strEspDoc := AEspDoc;
end;

procedure TLogAbstract.pSetNumDoc(ANumDoc: String);
begin
  FDocume.strNumDoc := ANumDoc;
end;

procedure TLogAbstract.pSetOpeCon(AOpeCon: String);
begin
  FOpeCon := AOpeCon;
end;

{ TConDor }

procedure TConDor.pCarregaItensPedido;
begin
  FItens_.Close;
  FItens_.SQL.Clear;
  FItens_.SQL.Add('SELECT                    ');
  FItens_.SQL.Add('  F.AUTOINCREM AS FDOINC, ');
  FItens_.SQL.Add('  E.FDO_QTDEXP AS QTDITE  ');
  FItens_.SQL.Add('FROM            ');
  FItens_.SQL.Add('  FATDOR F      ');
  FItens_.SQL.Add('  INNER JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM ');

  FItens_.SQL.Add('WHERE                        ');
  FItens_.SQL.Add('  F.FDO_NUMDOC = :NUMDOC AND ');
  FItens_.SQL.Add('  F.FDO_ESPDOC = :ESPDOC AND ');
  FItens_.SQL.Add('  F.FDO_CODEMP = :CODEMP     ');

  FItens_.ParamByName('NUMDOC').AsString := FDocume.strNumDoc;
  FItens_.ParamByName('ESPDOC').AsString := FDocume.strEspDoc;
  FItens_.ParamByName('CODEMP').AsString := FDocume.strCodEmp;

  FItens_.Open;
end;

procedure TConDor.pGravar;
Var
  qryExcSQL: TUniQuery;
  LSLInsert: TStringList;
  LstrSQL: String;
  LstrAdd: String;
  LAutInc: String;
  LDtaHraServidor: TDateTime;
begin

  If Assigned(FCdsExp) Then
  Begin
    pGravarClientItens;
    Exit;
  End;

  pCarregaItensPedido;

  If FItens_.IsEmpty Then
    Exit;

  qryExcSQL := fCriaQuery();
  LSLInsert := TStringList.Create;
  Try
    LDtaHraServidor := fRetDtaHraServidor;
    LSLInsert.Clear;
    LstrSQL := '';
    LstrSQL := LstrSQL + 'INSERT INTO CONDOR_AUTCOM (AUTOINCREM, CON_SEQFDO, CON_QTDCON, CON_OPECON, CON_DTAINI, CON_DTAFIN)';
    LstrSQL := LstrSQL + ' VALUES (:AUTINC, :SEQFDO, :QTDCON, :OPECON, :DTAINI, :DTAFIN)';

    FItens_.Last;
    LAutInc := fRetAutoIncrem('CONDOR_AUTCOM', VS_strCodEmp, FItens_.RecordCount);
    FItens_.First;
    While Not FItens_.Eof Do
    Begin
      LstrAdd := LstrSQL;

      LstrAdd := StringReplace(LstrAdd, ':AUTINC', QuotedStr(LAutInc),                                        [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':SEQFDO', QuotedStr(FItens_.FieldByName('FDOINC').AsString),         [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':QTDCON', fDoubleToSQL(FItens_.FieldByName('QTDITE').AsFloat),       [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':OPECON', QuotedStr(IfEmptyStr(FOpeCon, strLoginUsuarioLogado)),     [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':DTAINI', QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', FDtaIni)), [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':DTAFIN', QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', LDtaHraServidor)), [rfReplaceAll]);

      LSLInsert.Add(LstrAdd);
      LAutInc := fNextAutoIncrem(LAutInc);

      FItens_.Next;
    End;

    qryExcSQL.Close();
    qryExcSQL.SQL.Text := fOtimizaInsertReplaceMultiValue(LSLInsert.Text, []);
    qryExcSQL.ExecSQL();
  Finally
    FreeAndNil(qryExcSQL);
    FreeAndNil(LSLInsert);
  End;
end;

procedure TConDor.pGravarClientItens;
Var
  qryExcSQL: TUniQuery;
  LSLInsert: TStringList;
  LstrSQL: String;
  LstrAdd: String;
  LAutInc: String;
  LDtaHraServidor: TDateTime;
begin
  If FCdsExp.IsEmpty Then
    Exit;

  qryExcSQL := fCriaQuery();
  LSLInsert := TStringList.Create;
  Try
    LDtaHraServidor := fRetDtaHraServidor;
    LSLInsert.Clear;
    LstrSQL := '';
    LstrSQL := LstrSQL + 'INSERT INTO CONDOR_AUTCOM (AUTOINCREM, CON_SEQFDO, CON_QTDCON, CON_OPECON, CON_DTAINI, CON_DTAFIN)';
    LstrSQL := LstrSQL + ' VALUES (:AUTINC, :SEQFDO, :QTDCON, :OPECON, :DTAINI, :DTAFIN)';

    FCdsExp.Last;
    LAutInc := fRetAutoIncrem('CONDOR_AUTCOM', VS_strCodEmp, FCdsExp.RecordCount);
    FCdsExp.First;
    While Not FCdsExp.Eof Do
    Begin
      LstrAdd := LstrSQL;

      LstrAdd := StringReplace(LstrAdd, ':AUTINC', QuotedStr(LAutInc),                                        [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':SEQFDO', QuotedStr(FCdsExp.FieldByName('FDOINC').AsString),         [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':QTDCON', fDoubleToSQL(FCdsExp.FieldByName('QTDEXP').AsFloat),       [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':OPECON', QuotedStr(IfEmptyStr(FOpeCon, strLoginUsuarioLogado)),     [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':DTAINI', QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', FDtaIni)), [rfReplaceAll]);
      LstrAdd := StringReplace(LstrAdd, ':DTAFIN', QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', LDtaHraServidor)), [rfReplaceAll]);

      LSLInsert.Add(LstrAdd);
      LAutInc := fNextAutoIncrem(LAutInc);

      FCdsExp.Next;
    End;

    qryExcSQL.Close();
    qryExcSQL.SQL.Text := fOtimizaInsertReplaceMultiValue(LSLInsert.Text, []);
    qryExcSQL.ExecSQL();
  Finally
    FreeAndNil(qryExcSQL);
    FreeAndNil(LSLInsert);
  End;
end;

procedure TConDor.pSetClientItens(AItens: TUniClientDataSet);
begin
  FCdsExp := AItens;
end;

end.
