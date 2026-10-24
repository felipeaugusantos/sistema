unit Separacao.Classes.Parcial;

interface

uses
  System.SysUtils, System.UITypes, Data.DB, Uni;

function GravaSeparacaoParcialPedido(AItens: TDataSet; const ANumDoc, AEspDoc, ACodEmp: String; out ASeqSep: Integer): Boolean;
function LimpaSeparacaoParcialPedido(const ANumDoc, AEspDoc, ACodEmp: String; const ASeqSep: Integer): Boolean;
function SelecionaSeparacaoParcial(const ANumDoc, AEspDoc, ACodEmp: String; out ASeqSep: Integer; ALimpaSep: Boolean = False): Boolean;
function GetQuantSeparacaoJaImpressa(const ANumDoc, AEspDoc, ACodEmp: String): Integer;
function GetSequencialSeparacaoParcial(const ANumDoc, AEspDoc, ACodEmp: String): Integer;

implementation

uses
  untFuncoesSimples, untSelSeparacaoParcial;

function GravaSeparacaoParcialPedido(AItens: TDataSet; const ANumDoc, AEspDoc,
  ACodEmp: String; out ASeqSep: Integer): Boolean;
Var
  LQrySep: TUniQuery;
  LQtdIte: Double;
  LConsiderarJaSeparado: Boolean;
begin
  LQrySep := fCriaQuery;
  Try
    Try
      LConsiderarJaSeparado := fCfgSis('SPCIMP', varBoolean);

      ASeqSep := 0;
      If LConsiderarJaSeparado Then
        ASeqSep := GetSequencialSeparacaoParcial(ANumDoc, AEspDoc, ACodEmp) +1;

      fStartTransaction;

      AItens.First;
      While Not AItens.Eof Do
      Begin
        If LConsiderarJaSeparado Then
          LQtdIte := AItens.FieldByName('QTDSEP').AsFloat
        Else
          LQtdIte := AItens.FieldByName('QTDSEP').AsFloat - AItens.FieldByName('QTDANT').AsFloat;

        LQrySep.Close;
        LQrySep.SQL.Clear;
        LQrySep.SQL.Add('UPDATE EXTDOR');
        LQrySep.SQL.Add('SET FDO_QTDSEP = IFNULL(FDO_QTDSEP, 0) + :QTDSEP');

        if LConsiderarJaSeparado and (LQtdIte > 0) then
          LQrySep.SQL.Add(', FDO_OPBXSE = NULL, FDO_DTBXSE = NULL, FDO_HRBXSE = NULL ');

        LQrySep.SQL.Add('WHERE FDO_SEQFDO = :SEQFDO');

        LQrySep.ParamByName('QTDSEP').AsFloat  := LQtdIte;
        LQrySep.ParamByName('SEQFDO').AsString := AItens.FieldByName('AUTINC').AsString;
        LQrySep.ExecSQL;

        If LConsiderarJaSeparado And (LQtdIte > 0) Then
        Begin
          LQrySep.Close;
          LQrySep.SQL.Clear;
          LQrySep.SQL.Add('INSERT INTO SEPPAR(');
          LQrySep.SQL.Add('  AUTOINCREM, SEP_SEQSEP, SEP_NUMDOC, SEP_ESPDOC, SEP_CODEMP,');
          LQrySep.SQL.Add('  SEP_SEQFDO, SEP_QTDSEP, SEP_DTASEP, SEP_HRASEP, SEP_OPESEP)');
          LQrySep.SQL.Add('VALUES(');
          LQrySep.SQL.Add('  :AUTINC, :SEQSEP, :NUMDOC, :ESPDOC, :CODEMP,');
          LQrySep.SQL.Add('  :SEQFDO, :QTDSEP, :DTASEP, :HRASEP, :OPESEP)');

          LQrySep.ParamByName('AUTINC').AsString   := fRetAutoIncrem('SEPPAR', ACodEmp);
          LQrySep.ParamByName('SEQSEP').AsInteger  := ASeqSep;
          LQrySep.ParamByName('NUMDOC').AsString   := ANumDoc;
          LQrySep.ParamByName('ESPDOC').AsString   := AEspDoc;
          LQrySep.ParamByName('CODEMP').AsString   := ACodEmp;
          LQrySep.ParamByName('SEQFDO').AsString   := AItens.FieldByName('AUTINC').AsString;
          LQrySep.ParamByName('QTDSEP').AsFloat    := LQtdIte;
          LQrySep.ParamByName('DTASEP').AsDateTime := VS_Date;
          LQrySep.ParamByName('HRASEP').AsDateTime := fTime();
          LQrySep.ParamByName('OPESEP').AsString   := strLoginUsuarioLogado;
          LQrySep.ExecSQL;
        End;

        AItens.Next;
      End;

      if LConsiderarJaSeparado then
      begin
        LQrySep.Close;
        LQrySep.SQL.Clear;
        LQrySep.SQL.Add('UPDATE FATGOR, EXTGOR ');
        LQrySep.SQL.Add('SET FGO_OPBXSE = NULL, FGO_DTBXSE = NULL, FGO_HRBXSE = NULL ');
        LQrySep.SQL.Add('WHERE FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
        LQrySep.SQL.Add('  AND FGO_NUMDOC = :NUMDOC ');
        LQrySep.SQL.Add('  AND FGO_ESPDOC = :ESPDOC ');
        LQrySep.SQL.Add('  AND FGO_CODEMP = :CODEMP ');

        LQrySep.ParamByName('NUMDOC').AsString := ANumDoc;
        LQrySep.ParamByName('ESPDOC').AsString := AEspDoc;
        LQrySep.ParamByName('CODEMP').AsString := ACodEmp;
        LQrySep.ExecSQL;
      end;

      fCommit;

      Result := True;
    Except On E: Exception Do
      Begin
        fRollback;
        Result := False;
        pMensagensErro(E.Message, '[GravaSeparacaoParcialPedido]');
      End;
    End;
  Finally
    FreeAndNil(LQrySep);
  End;
end;

function LimpaSeparacaoParcialPedido(const ANumDoc, AEspDoc, ACodEmp: String;
  const ASeqSep: Integer): Boolean;
Var
  LQrySep: TUniQuery;
  LQryUpd: TUniQuery;
begin
  LQrySep := fCriaQuery;
  LQryUpd := fCriaQuery;
  Try
    Try
      LQrySep.SQL.Add('SELECT * FROM SEPPAR');
      LQrySep.SQL.Add('WHERE SEP_NUMDOC = :NUMDOC');
      LQrySep.SQL.Add('  AND SEP_ESPDOC = :ESPDOC');
      LQrySep.SQL.Add('  AND SEP_CODEMP = :CODEMP');
      LQrySep.SQL.Add('  AND SEP_SEQSEP = :SEQSEP');

      LQrySep.ParamByName('NUMDOC').AsString  := ANumDoc;
      LQrySep.ParamByName('ESPDOC').AsString  := AEspDoc;
      LQrySep.ParamByName('CODEMP').AsString  := ACodEmp;
      LQrySep.ParamByName('SEQSEP').AsInteger := ASeqSep;
      LQrySep.Open;

      fStartTransaction;

      LQrySep.First;
      While Not LQrySep.Eof Do
      Begin
        LQryUpd.Close;
        LQryUpd.SQL.Clear;
        LQryUpd.SQL.Add('UPDATE EXTDOR');
        LQryUpd.SQL.Add('SET FDO_QTDSEP = IFNULL(FDO_QTDSEP,0) - :QTDSEP');
        LQryUpd.SQL.Add('WHERE FDO_SEQFDO = :SEQFDO');

        LQryUpd.ParamByName('QTDSEP').AsFloat  := LQrySep.FieldByName('SEP_QTDSEP').AsFloat;
        LQryUpd.ParamByName('SEQFDO').AsString := LQrySep.FieldByName('SEP_SEQFDO').AsString;
        LQryUpd.ExecSQL;

        fVerificaIntegridade('', 'SEPPAR', LQrySep);

        LQrySep.Delete;
      End;

      fCommit;

      Result := True;

    Except
      On E: Exception Do
      Begin
        fRollback;
        Result := False;
        pMensagensErro(E.Message, '[LimpaSeparacaoParcialPedido]');
      End;
    End;
  Finally
    FreeAndNil(LQrySep);
    FreeAndNil(LQryUpd);
  End;
end;

function SelecionaSeparacaoParcial(const ANumDoc, AEspDoc, ACodEmp: String;
  out ASeqSep: Integer; ALimpaSep: Boolean = False): Boolean;
Var
  frmSelSeparacaoParcial: TfrmSelSeparacaoParcial;
begin
  pCriarFormularios(TfrmSelSeparacaoParcial, frmSelSeparacaoParcial);
  Try
    ASeqSep := 0;

    frmSelSeparacaoParcial.strNumDoc := ANumDoc;
    frmSelSeparacaoParcial.strEspDoc := AEspDoc;
    frmSelSeparacaoParcial.strCodEmp := ACodEmp;
    frmSelSeparacaoParcial.blnLimpaSep := ALimpaSep;
    frmSelSeparacaoParcial.ShowModal;

    Result := (frmSelSeparacaoParcial.ModalResult = mrOk);

    If Result Then
      ASeqSep := frmSelSeparacaoParcial.intSeqSep;
  Finally
    pFreeAndNil(frmSelSeparacaoParcial);
  End;
end;

function GetQuantSeparacaoJaImpressa(const ANumDoc, AEspDoc, ACodEmp: String): Integer;
begin
  Result := fCampoTabela('COUNT(DISTINCT SEP_SEQSEP)', 'SEPPAR',
                        ['SEP_NUMDOC', 'SEP_ESPDOC', 'SEP_CODEMP'],
                        [ANumDoc, AEspDoc, ACodEmp]);
end;

function GetSequencialSeparacaoParcial(const ANumDoc, AEspDoc, ACodEmp: String): Integer;
begin
  Result := fCampoTabela('IFNULL(MAX(SEP_SEQSEP), 0)', 'SEPPAR',
                        ['SEP_NUMDOC', 'SEP_ESPDOC', 'SEP_CODEMP'],
                        [ANumDoc, AEspDoc, ACodEmp]);
end;

end.
