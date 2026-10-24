unit untFechamentoFiscal;

interface

Uses
  Uni, DB, Classes,
  CxProgressBar,
  untZClient;

Type
  TTipoTravaFiscal = (trfFechamento, trfMovimentacao);

  TFechamentoFiscal = Class
  Private
    FTravou: Boolean;
    FblnContabilidade: Boolean;

    function fSQLUtimoFechamentoEmpresas: String;

    function fSQLUtimos24: String;

    Procedure pSetaAfterScroll;

    Procedure pIncluiFechamento(strCodEmp: String; dtaDtaRef: TDate);
    Procedure pExcluiFechamento(strCodEmp: String; dtaDtaRef: TDate);

    function fCarregaUltimoFechamentoTodasEmpresasAux(prgProgresso: TCxProgressBar): Boolean;
    function fCarregaUltimos24Aux(prgProgresso: TCxProgressBar): Boolean;

  Public

    cdsUltFecTodas: TZClient;
    cdsUltimos24: TZClient;

    strUltEmpFechada: String;

    constructor Create(Owner: TComponent); Reintroduce;

    Destructor  Destroy; Override;

    function fCarregaUltimoFechamentoTodasEmpresas: Boolean;

    function fCarregaUltimos24: Boolean;

    Procedure pGetUltimoFechamento(strCodEmp: String; Var dtaDtaRef: TDate);

    Function fIncluiFechamento(strCodEmp: String; dtaDtaRef: TDate): Boolean;
    Function fExcluiFechamento(strCodEmp: String; dtaDtaRef: TDate): Boolean;

    Procedure pAfterScrollEmpresa(dataSet: TdataSet);

    Class Function fDataFechamento(strCodEmp: String = ''): TDateTime;

    Class Function fDataFiscalPermitida(dtaDtaEnt: TDate; strNomeData: String = 'de entrada'; blnMsgAviso: Boolean = True; strCodEmp: String = ''): Boolean;

    Function fVeSeTravaFechamentoFiscal(traTipoFechamento: TTipoTravaFiscal; dtaDtaEnt: TDateTime; strCodEmp: String = ''): Boolean;

    Procedure pDestravaFechamentoFiscal(traTipoFechamento: TTipoTravaFiscal; strCodEmp: String = '');

    Class Function fTipoFechamentoToString(traTipoFechamento: TTipoTravaFiscal): String;
    property Contabilidade: Boolean read FblnContabilidade write FblnContabilidade ;
  End;


implementation

Uses
  SysUtils,
  StrUtils,
  DateUtils,
  Forms,
  untFuncoesSimples,
  untGravando,
  Contabilidade.OutrosFechamentos.Funcoes;

Const
  STR_MOVIMENTACAO_FISCAL = 'MOVIMENTACAO_FISCAL_';

constructor TFechamentoFiscal.Create(Owner: TComponent);
Begin
  Inherited Create;
  FblnContabilidade := False;
  FTravou := False;

  strUltEmpFechada := '';

  cdsUltFecTodas := Nil;
  cdsUltimos24 := Nil;
End;

Destructor TFechamentoFiscal.Destroy;
Begin
  If Assigned(cdsUltFecTodas) Then
    FreeAndNil(cdsUltFecTodas);

  If Assigned(cdsUltimos24) Then
    FreeAndNil(cdsUltimos24);

  inherited Destroy;
End;

function TFechamentoFiscal.fSQLUtimoFechamentoEmpresas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   F.*, ';
  strSQL := strSQL + '   EMP_NOMEMP AS NOMEMP ';
  strSQL := strSQL + '  FROM                  ';
  strSQL := strSQL + '    FECFIS F            ';

  strSQL := strSQL + '  INNER JOIN CADEMP ON EMP_CODEMP = FEC_CODEMP ';

  strSQL := strSQL + '  INNER JOIN (                                 ';
  strSQL := strSQL + '    SELECT FEC_CODEMP, MAX(FEC_DTAREF) AS FEC_DTAREF  ';
  strSQL := strSQL + '    FROM FECFIS                                       ';
  strSQL := strSQL + '    GROUP BY FEC_CODEMP ) AS M ON M.FEC_CODEMP = F.FEC_CODEMP AND M.FEC_DTAREF = F.FEC_DTAREF ';

  Result := strSQL;
End;

function TFechamentoFiscal.fCarregaUltimoFechamentoTodasEmpresas: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fCarregaUltimoFechamentoTodasEmpresasAux, frmGravando, 'Carregando último fechamento de cada empresa, aguarde...');
End;

function TFechamentoFiscal.fCarregaUltimoFechamentoTodasEmpresasAux(prgProgresso: TCxProgressBar): Boolean;
Begin
  If Not Assigned(cdsUltFecTodas) Then
    cdsUltFecTodas := TZClient.Create(Nil, fSQLUtimoFechamentoEmpresas);

  cdsUltFecTodas.AfterScroll := Nil;

  Result := cdsUltFecTodas.fLeDados('TFechamentoFiscal.fCarregaUltimoFechamentoTodasEmpresas');

  If Result Then
  Begin
    cdsUltFecTodas.pAlinhaCampoCentro('FEC_CODEMP');
    cdsUltFecTodas.pAlinhaCampoCentro('FEC_DTAREF');
  End;
End;

function TFechamentoFiscal.fSQLUtimos24: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   F.*,  ';
  strSQL := strSQL + '   OPE_NOMOPE AS NOMOPE, CAST("N" AS CHAR(1)) AS FECCNT ';
  strSQL := strSQL + ' FROM         ';
  strSQL := strSQL + '   FECFIS F   ';

  strSQL := strSQL + '  INNER JOIN CADOPE ON OPE_CODOPE = FEC_CODOPE ';

  strSQL := strSQL + ' WHERE        ';
  strSQL := strSQL + '   FEC_CODEMP = :CODEMP ';
  strSQL := strSQL + ' ORDER BY  ';
  strSQL := strSQL + '   FEC_DTAREF DESC LIMIT 24 ';

  Result := strSQL;
End;

function TFechamentoFiscal.fCarregaUltimos24: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fCarregaUltimos24Aux, frmGravando, 'Carregando últimos 24 fechamentos de cada empresa, aguarde...');
End;

function TFechamentoFiscal.fCarregaUltimos24Aux(prgProgresso: TCxProgressBar): Boolean;
  Var
    qryCadEmp,
    qryCadFec: TUniQuery;
    intContador: Integer;
Begin
  qryCadFec := fCriaQuery;
  qryCadFec.SQL.Text := fSQLUtimos24;

  If Not Assigned(cdsUltimos24) Then
    cdsUltimos24 := TZClient.Create(Nil, fSQLUtimos24);

  Result := cdsUltimos24.fLeDados('TFechamentoFiscal.fCarregaUltimos24');

  qryCadEmp := fCriaQuery;
  qryCadEmp.SQL.Text := 'SELECT EMP_CODEMP FROM CADEMP';
  qryCadEmp.Open;

  prgProgresso.Properties.Max := qryCadEmp.RecordCount;

  While Not qryCadEmp.Eof Do
  Begin
    qryCadFec.Close;
    qryCadFec.ParamByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
    qryCadFec.Open;

    While Not qryCadFec.Eof Do
    Begin
      cdsUltimos24.Append;

      For intContador := 0 To qryCadFec.FieldCount - 1 Do
        cdsUltimos24.Fields[intContador].Value := qryCadFec.Fields[intContador].Value;

      cdsUltimos24.FieldByName('FECCNT').AsString := IfThen(TOutrosFechamentos.fTemFecMes(cdsUltimos24.FieldByName('FEC_CODEMP').AsString, cdsUltimos24.FieldByName('FEC_DTAREF').AsDateTime), 'S', 'N') ;
      cdsUltimos24.Post;

      qryCadFec.Next;
    End;

    prgProgresso.Position := prgProgresso.Position + 1;
    Application.ProcessMessages;

    qryCadEmp.Next;
  End;

  FreeAndNil(qryCadFec);

  If Result Then
  Begin
    cdsUltimos24.pAlinhaCampoCentro('FEC_CODEMP');
    cdsUltimos24.pAlinhaCampoCentro('FEC_DTAREF');
    cdsUltimos24.pAlinhaCampoCentro('FEC_CODOPE');
    cdsUltimos24.pAlinhaCampoCentro('FEC_DTAFEC');
    cdsUltimos24.pAlinhaCampoCentro('FEC_HORFEC');
  End;

  pSetaAfterScroll;
End;

Procedure TFechamentoFiscal.pAfterScrollEmpresa(dataSet: TdataSet);
Begin
  If Assigned(cdsUltimos24) And cdsUltimos24.Active Then
  Begin
    If dataSet.IsEmpty Then
      cdsUltimos24.Filter   := 'FEC_CODEMP = ' + QuotedStr('')
    Else
      cdsUltimos24.Filter   := 'FEC_CODEMP = ' + QuotedStr(dataSet.FieldByName('FEC_CODEMP').AsString);

    cdsUltimos24.Filtered := True;
  End;
End;

Procedure TFechamentoFiscal.pSetaAfterScroll;
Begin
  if FblnContabilidade then
    Exit ;

  cdsUltFecTodas.AfterScroll := pAfterScrollEmpresa;

  If Not cdsUltFecTodas.IsEmpty Then
    pAfterScrollEmpresa(cdsUltFecTodas);
End;

Procedure TFechamentoFiscal.pGetUltimoFechamento(strCodEmp: String; Var dtaDtaRef: TDate);
  Var
    qryCadFec: TUniQuery;
begin
  dtaDtaRef := 0;

  qryCadFec := fCriaQuery;
  qryCadFec.SQL.Text := 'SELECT MAX(FEC_DTAREF) AS DTAREF FROM FECFIS WHERE FEC_CODEMP = :CODEMP';
  qryCadFec.ParamByName('CODEMP').AsString := strCodEmp;
  qryCadFec.Open;

  If Not qryCadFec.IsEmpty Then
    dtaDtaRef := qryCadFec.FieldByName('DTAREF').AsDateTime;

  FreeAndNil(qryCadFec);
End;

Procedure TFechamentoFiscal.pIncluiFechamento(strCodEmp: String; dtaDtaRef: TDate);
  Var
    qryCadFec: TUniQuery;
    strSQL: String;
Begin
  qryCadFec := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO FECFIS ';
  strSQL := strSQL + ' (AUTOINCREM, FEC_CODEMP, FEC_CODOPE, FEC_DTAFEC, FEC_HORFEC, FEC_DTAREF) VALUES ';
  strSQL := strSQL + ' (:AUTINC, :CODEMP, :CODOPE, :DTAFEC, :HORFEC, :DTAREF)';

  qryCadFec.SQL.Text := strSQL;

  qryCadFec.ParamByName('AUTINC').AsString    := fRetAutoIncrem('FECFIS', VS_strCodEmp);
  qryCadFec.ParamByName('CODOPE').AsString    := strLoginUsuarioLogado;
  qryCadFec.ParamByName('HORFEC').AsTime      := fTime();
  qryCadFec.ParamByName('DTAFEC').AsDateTime  := VS_Date;

  qryCadFec.ParamByName('CODEMP').AsString  := strCodEmp;
  qryCadFec.ParamByName('DTAREF').AsDate    := dtaDtaRef;

  qryCadFec.ExecSQL;

  FreeAndNil(qryCadFec);
End;

Class Function TFechamentoFiscal.fTipoFechamentoToString(traTipoFechamento: TTipoTravaFiscal): String;
Begin
  Case traTipoFechamento Of
    trfFechamento: Result := 'FECHAMENTO';
    else           Result := 'MOVIMENTACAO';
  End;
End;

Function TFechamentoFiscal.fVeSeTravaFechamentoFiscal(traTipoFechamento: TTipoTravaFiscal; dtaDtaEnt: TDateTime; strCodEmp: String = ''): Boolean;
Begin
  FTravou := False;
  Result  := True;
                                                                                   // SE É ANTERIOR A ATUAL
  If (fCfgSis('UTIFEC', varBoolean)) and ( (traTipoFechamento = trfFechamento) Or (dtaDtaEnt = 0) Or (dtaDtaEnt < VS_Date) ) Then
  Begin

    If strCodEmp.IsEmpty Then
      strCodEmp := VS_strCodEmp;

    Result := fLock_Unlock(STR_MOVIMENTACAO_FISCAL + strCodEmp,
                           True,
                           False,
                           False, {blnHourGlass: Boolean = FALSE;}
                           '',    {strCon_Id: String = '';}
                           True,  {blnMostraMsgTravamento: Boolean = True;}
                           fTipoFechamentoToString(traTipoFechamento));

    If Result Then
    Begin
      FTravou := True;

      If (traTipoFechamento = trfMovimentacao) And (dtaDtaEnt <> 0) And (Not fDataFiscalPermitida(dtaDtaEnt)) Then
      Begin
        Result := False;
        pDestravaFechamentoFiscal(traTipoFechamento, strCodEmp);
      End;


    End Else
      pMensagemOk('O fechamento fiscal dessa empresa ou uma movimentação fiscal já está sendo feito em outra estação: ' + fGetHostLock(STR_MOVIMENTACAO_FISCAL + strCodEmp));

  End;
End;

Procedure TFechamentoFiscal.pDestravaFechamentoFiscal(traTipoFechamento: TTipoTravaFiscal; strCodEmp: String = '');
Begin
  If FTravou Then
  Begin

    If strCodEmp.IsEmpty Then
      strCodEmp := VS_strCodEmp;

    If fLock_Unlock(STR_MOVIMENTACAO_FISCAL + strCodEmp,
                 False,
                 False,
                 False, {blnHourGlass: Boolean = FALSE;}
                 '',    {strCon_Id: String = '';}
                 True,  {blnMostraMsgTravamento: Boolean = True;}
                 fTipoFechamentoToString(traTipoFechamento)) Then
     FTravou := False;

  End;
End;

Function TFechamentoFiscal.fIncluiFechamento(strCodEmp: String; dtaDtaRef: TDate): Boolean;
  Var
    dtaUltFecha: TDate;
Begin
  Try
    Result := False;

    If fVeSeTravaFechamentoFiscal(trfFechamento, 0, strCodEmp) Then
    Begin

      Try
        if not FblnContabilidade then
        begin
          pGetUltimoFechamento(strCodEmp, dtaUltFecha);

          If dtaUltFecha >= dtaDtaRef Then
          begin
            pMensagemOk('O fechamento sugerido deve ser maior que o último fechamento realizado (' + FormatDateTime('DD/MM/YYYY', dtaUltFecha) + ')!');
            Exit;
          End;
        end ;

        fStartTransaction;

        pIncluiFechamento(strCodEmp, dtaDtaRef);

        fCommit;

        Result := True;

        strUltEmpFechada := strCodEmp;

      Except

        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TFechamentoFiscal.fIncluiFechamento');
        End;

      End;

    End;

  Finally
    pDestravaFechamentoFiscal(trfFechamento, strCodEmp);
  End;
End;

Procedure TFechamentoFiscal.pExcluiFechamento(strCodEmp: String; dtaDtaRef: TDate);
  Var
    qryCadFec: TUniQuery;
    strSQL: String;
Begin
  qryCadFec := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO DELFIS ';
  strSQL := strSQL + '  (AUTOINCREM, FEC_CODEMP, FEC_CODOPE, FEC_DTAFEC, FEC_HORFEC, FEC_DTAREF, FEC_OPEDEL, FEC_HORDEL, FEC_DTADEL) ';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '   :AUTINC, FEC_CODEMP, FEC_CODOPE, FEC_DTAFEC, FEC_HORFEC, FEC_DTAREF, :OPEDEL, :HORDEL, :DTADEL ';
  strSQL := strSQL + ' FROM FECFIS ';
  strSQL := strSQL + ' WHERE FEC_CODEMP = :CODEMP AND FEC_DTAREF = :DTAREF';

  qryCadFec.SQL.Text := strSQL;

  qryCadFec.ParamByName('CODEMP').AsString  := strCodEmp;
  qryCadFec.ParamByName('DTAREF').AsDate    := dtaDtaRef;

  qryCadFec.ParamByName('AUTINC').AsString  := fRetAutoIncrem('DELFIS', VS_strCodEmp);
  qryCadFec.ParamByName('OPEDEL').AsString  := strLoginUsuarioLogado;
  qryCadFec.ParamByName('HORDEL').AsTime    := fTime();
  qryCadFec.ParamByName('DTADEL').AsDate    := VS_Date;

  qryCadFec.ExecSQL;

  qryCadFec.Close;

  strSQL := '';
  strSQL := strSQL + ' DELETE FROM FECFIS ';
  strSQL := strSQL + ' WHERE FEC_CODEMP = :CODEMP AND FEC_DTAREF = :DTAREF';

  qryCadFec.SQL.Text := strSQL;

  qryCadFec.ParamByName('CODEMP').AsString  := strCodEmp;
  qryCadFec.ParamByName('DTAREF').AsDate    := dtaDtaRef;

  qryCadFec.ExecSQL;

  FreeAndNil(qryCadFec);
End;

Function TFechamentoFiscal.fExcluiFechamento(strCodEmp: String; dtaDtaRef: TDate): Boolean;
  Var
    dtaUltFecha: TDate;
Begin
  Try
    Result := False;

    If fVeSeTravaFechamentoFiscal(trfFechamento, 0, strCodEmp) Then
    Begin

      Try
        if not FblnContabilidade then
        begin
          pGetUltimoFechamento(strCodEmp, dtaUltFecha);

          If dtaUltFecha <> dtaDtaRef Then
          Begin
            pMensagemOk('O fechamento sugerido não é o último fechamento da empresa!');
            Exit;
          End;
        end ;

        fStartTransaction;

        pExcluiFechamento(strCodEmp, dtaDtaRef);

        fCommit;

        Result := True;

        strUltEmpFechada := strCodEmp;

      Except

        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, 'TFechamentoFiscal.fExcluiFechamento');
        End;

      End;

    End;

  Finally
    pDestravaFechamentoFiscal(trfFechamento, strCodEmp);
  End;

End;

Class Function TFechamentoFiscal.fDataFiscalPermitida(dtaDtaEnt: TDate; strNomeData: String = 'de entrada'; blnMsgAviso: Boolean = True; strCodEmp: String = ''): Boolean;
  Var
    dtaDtaRef: TDate;
Begin
  Try

    if not fCfgSis('UTIFEC', varBoolean) then
      Exit(True);

    dtaDtaRef := fDataFechamento(strCodEmp);

    Result := dtaDtaEnt > dtaDtaRef;

    If (Not Result) And blnMsgAviso Then
       pMensagemOk('A data ' + strNomeData + ' deve ser maior que a do último fechamento de fiscal (' + FormatDateTime('DD/MM/YYYY', dtaDtaRef) + ')!');

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TFechamentoFiscal.fDataFiscalPermitida]');
    End;
  End;
End;

Class Function TFechamentoFiscal.fDataFechamento(strCodEmp: String = ''): TDateTime;
  Var
    qryCadFec: TUniQuery;
Begin
  Try
    If strCodEmp.IsEmpty Then
      strCodEmp := VS_strCodEmp;

    qryCadFec := fCriaQuery;
    qryCadFec.SQL.Text := 'SELECT MAX(FEC_DTAREF) AS DTAREF FROM FECFIS WHERE FEC_CODEMP = :CODEMP';
    qryCadFec.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadFec.Open;

    If qryCadFec.IsEmpty Or qryCadFec.FieldByName('DTAREF').IsNull Then
    Begin
      Result := 0
    End Else
    Begin

      Result := qryCadFec.FieldByName('DTAREF').AsDateTime

    End;

    FreeAndNil(qryCadFec);

  Except
    On E: Exception Do
    Begin
      Result := VS_Date;
      pMensagensErro(E.Message, '[TFechamentoFiscal.fDataFechamento]');
    End;
  End;
End;


end.
