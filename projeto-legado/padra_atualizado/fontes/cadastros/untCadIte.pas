unit untCadIte;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms, ComCtrls, cxProgressBar,
{$ENDIF}
  Uni, DateUtils, untFuncoesgenerica, untIExecutaSQLReplicacaoTinta;

  procedure pGeraItensParaLoja(strNumLoj: String; pgbProgresso: TcxProgressBar);

  function fAtualizaEstoqueCadIte(strCodIte,
                                  strEntSai: String;
                                  fltQtdIte,
                                  fltPreUve: Double;
                                  strNumLot: String = '';
                                  blnAtualizaUltimaVenda: Boolean = True;
                                  blnRetFalseSeNaoConseguirGerarNotificaoItensAbaixoMin: Boolean = False;
                                  objReplTinta: IExecutaSQLReplicacaoTinta = Nil;
                                  AstrOpcaoDocumento: String = '';
                                  blnTravarSeSaldoFicarNegativo: Boolean = False;
                                  strEmpIte: String = '';
                                  AUsarBatchSaldos: Boolean = False): Boolean;

  function fAtualizaEstoqueML(strCodIte    : String;
                              fltQtdBai    : Double;
                              strNumLot    : String;
                              objReplTinta : IExecutaSQLReplicacaoTinta = nil): Boolean;

  procedure pAtualizaSaldo(strCodIte: String; fltSalBal: Double; dtaDtaBal: TDateTime; fltSalMl: Double = 0; blnSalMl: Boolean = FALSE);

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  SysUtils, untCadLote, Data.DB, untControlaNotSaldoMin;

{*****************************************}
{* GERA OS REGISTROS NO ITEGER PARA A    *}
{* NOVA LOJA                             *}
{**************************************MV*}
procedure pGeraItensParaLoja(strNumLoj: String; pgbProgresso: TcxProgressBar);
  Var
    strSQL: String;
    intContador: Integer;
    qryGenIte : TUniQuery;
    qryGerIte : TUniQuery;
begin
  qryGenIte := fCriaQuery;
  qryGerIte := fCriaQuery;

  Try
    {*****************************************}
    {* SELECIONA TODOS OS ITENS DA LOJA      *}
    {* MATRIZ                                *}
    {**************************************MV*}
    fStartTransaction;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      pgbProgresso.Properties.Max := RecordCount;
      Application.ProcessMessages;

      {*****************************************}
      {* ABRE A TABLEA 'ITEGER' VAZIA, PARA    *}
      {* SER MAIS RÁPIDO                       *}
      {**************************************MV*}
      qryGerIte.Close;
      qryGerIte.SQL.Clear;
      qryGerIte.SQL.Add('SELECT * FROM ITEGER WHERE FALSE');
      qryGerIte.Open;

      While Not Eof Do
      Begin

        qryGerIte.Insert;

        For intContador := 0 To qryGerIte.FieldCount -1 Do
        Begin
          qryGerIte.Fields[intContador].Value := Fields[intContador].Value;
        End;

        qryGerIte.FieldByName('ITE_LOCFIS').AsString   := '';
        qryGerIte.FieldByName('ITE_COMVAR').AsInteger  := 0;
        qryGerIte.FieldByName('ITE_COMATA').AsInteger  := 0;
        qryGerIte.FieldByName('ITE_COMDIS').AsInteger  := 0;
        qryGerIte.FieldByName('ITE_SALBAL').AsFloat    := 0.0;
        qryGerIte.FieldByName('ITE_ML_BAL').AsFloat    := 0.0;
        qryGerIte.FieldByName('ITE_SALDOS').AsFloat    := 0.0;
        qryGerIte.FieldByName('ITE_SAL_ML').AsFloat    := 0.0;

        qryGerIte.FieldByName('ITE_CODEMP').AsString  := strNumLoj;
        qryGerIte.FieldByName('ITE_CODITE').AsString  := FieldByName('ITE_CODITE').AsString;
        qryGerIte.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEGER', VS_strCodEmp);

        qryGerIte.Post;
        Next;
        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;

      End;
      Close;
      qryGerIte.Close;

      fCommit;

    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pGeraItensParaLoja]');
    End;
  End;

  FreeAndNil(qryGenIte);
  FreeAndNil(qryGerIte);
end;

function fAtualizaEstoqueCadIte(strCodIte,
                                strEntSai: String;
                                fltQtdIte,
                                fltPreUve: Double;
                                strNumLot: String = '';
                                blnAtualizaUltimaVenda: Boolean = True;
                                blnRetFalseSeNaoConseguirGerarNotificaoItensAbaixoMin: Boolean = False;
                                objReplTinta: IExecutaSQLReplicacaoTinta = Nil;
                                AstrOpcaoDocumento: String = '';
                                blnTravarSeSaldoFicarNegativo: Boolean = False;
                                strEmpIte: String = '';
                                AUsarBatchSaldos: Boolean = False): Boolean;
  Var
    strSQL   : String;

    LstrMsgExc: String;
    LstrCodEmp: String;
    LdtaDhuPes: TDateTime;
    LHoraAuxil: TDateTime;

    fltSalFis: Double;
    qryGenIte: TUniQuery;
    objCadLot: TCadLot;
    objNotSalMin: TControlaNotificacaoSaldoMin;
    blnGerouNotificaoItensAbaixoMin: Boolean;

    function fMontaSQLAtualizaIteGer(const ASQLForExc: Boolean=False): String;
    begin
      Result :=          'UPDATE ITEGER ';
      Result := Result + '   SET ITE_DHUPES = :DHUPES';

      If strEntSai = 'E' Then
        Result := Result + ' ,ITE_SALDOS = ITE_SALDOS + :QTDITE'
      Else
      Begin
        Result := Result + ' ,ITE_NOTESM = IF((((ITE_SALDOS - :QTDITE) < ITE_ESTMIN) AND ITE_SALDOS >= ITE_ESTMIN), "S", ITE_NOTESM)';
        Result := Result + ' ,ITE_SALDOS = ITE_SALDOS - :QTDITE';

        If blnAtualizaUltimaVenda Then
        Begin
          Result := Result + ' ,ITE_PREUVE = :PREUVE';
          Result := Result + ' ,ITE_QTDUVE = :QTDITE';
          Result := Result + ' ,ITE_DTAUVE = ' + fCurrentDate;
        End;
      End;

      Result := Result + ' WHERE ITE_CODITE = :CODITE' +
                         '   AND ITE_CODEMP = :CODEMP';

      If ASQLForExc Then
      Begin
        Result := StringReplace(Result, ':QTDITE', fDoubleToSQL(fltQtdIte), [rfReplaceAll]);
        Result := StringReplace(Result, ':PREUVE', fDoubleToSQL(fltPreUve), [rfReplaceAll]);
        Result := StringReplace(Result, ':CODITE', QuotedStr(strCodIte)   , [rfReplaceAll]);
        Result := StringReplace(Result, ':CODEMP', QuotedStr(LstrCodEmp)  , [rfReplaceAll]);
        Result := StringReplace(Result, ':DHUPES', QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', LdtaDhuPes)), [rfReplaceAll]);
      End;
    end;

begin
  Result := True;
  qryGenIte := Nil;
  Try
    If ((fEmptyStr(strCodIte))) Or
        ((fEmptyStr(strEntSai)) Or (fltQtdIte = 0.0)) Then
    Begin
      Exit;
    End;

    If (Pos(AstrOpcaoDocumento, 'OF_OU_') > 0) And
       (SameText(fCfgSis('PROMAT', varString), strCodIte)) Then
    Begin
      Exit;
    End;

    LHoraAuxil := fNow();
    LdtaDhuPes := EncodeDateTime(YearOf(VS_Date),
                                 MonthOf(VS_Date),
                                 DayOf(VS_Date),
                                 HourOf(LHoraAuxil),
                                 MinuteOf(LHoraAuxil),
                                 SecondOf(LHoraAuxil), 0);
    LstrCodEmp := IfEmptyStr(strEmpIte, VS_strCodEmp);
    Try
      strSQL := fMontaSQLAtualizaIteGer(True);

      {Com o lote de saldos armado o UPDATE e acumulado (Nil fora do
       balanco). fUsouBatchSaldosBalancoSQL roda antes de AUsarBatchSaldos, entao
       blnTravarSeSaldoFicarNegativo le o saldo anterior ao ajuste durante o
       balanco - decisao: manter, a garantia e do B9. Ver specs.md secao 7.}
      If Not (fUsouBatchSaldosBalancoSQL(strSQL) Or
              (AUsarBatchSaldos And fUsouBatchReprocessarSaldo([strSQL], True))) Then
      Begin
        strSQL := fMontaSQLAtualizaIteGer;

        qryGenIte := fCriaQuery(Nil);
        qryGenIte.Close;
        qryGenIte.SQL.Text := strSQL;

        qryGenIte.ParamByName('QTDITE').AsFloat    := fltQtdIte;
        If Assigned(qryGenIte.FindParam('PREUVE')) Then
          qryGenIte.ParamByName('PREUVE').AsFloat  := fltPreUve;
        qryGenIte.ParamByName('CODITE').AsString   := strCodIte;
        qryGenIte.ParamByName('CODEMP').AsString   := LstrCodEmp;
        qryGenIte.ParamByName('DHUPES').AsDateTime := LdtaDhuPes;

        qryGenIte.ExecSQL;
        qryGenIte.Close;
      End;

      If blnTravarSeSaldoFicarNegativo Then
      Begin
        //REMOVER QUANDO IMPLEMENTAR
        If AUsarBatchSaldos Then
          Raise Exception.Create('AUsarBatchSaldos é incompatível com blnTravarSeSaldoFicarNegativo');

        If fSaldoItegerNegativo(strCodIte, LstrCodEmp, strEntSai, fltSalFis, LstrMsgExc) Then
        Begin
          Result := False;

          If fInTransaction Then
            fRollback;

          {$IFDEF LINUX}
          Raise Exception.Create(LstrMsgExc);
          {$ELSE}
          pMensagemOk(LstrMsgExc);
          Exit;
          {$ENDIF}
        End;
      End;

      If VS_blnNotificaSaldoAbaixMinimo Then
      Begin
        //REMOVER QUANDO IMPLEMENTAR
        If AUsarBatchSaldos Then
          Raise Exception.Create('AUsarBatchSaldos é incompatível com VS_blnNotificaSaldoAbaixMinimo');

        objNotSalMin := TControlaNotificacaoSaldoMin.Create;
        Try
          objNotSalMin.strCodite := strCodIte;
          objNotSalMin.blnRetFalseSeNaoConseguirEnviarNotificaoItensAbaixoMin := blnRetFalseSeNaoConseguirGerarNotificaoItensAbaixoMin;

          If objNotSalMin.blnGeraNotificacao Then
          Begin
            blnGerouNotificaoItensAbaixoMin := objNotSalMin.fGerarNotificacoes;

            If (blnRetFalseSeNaoConseguirGerarNotificaoItensAbaixoMin) And (Not blnGerouNotificaoItensAbaixoMin) Then
            Begin
              Raise Exception.Create('Ocorreu uma falha na geração de itens com estoque abaixo do mínimo!');
            End;
          End;
        Finally
          FreeAndNil(objNotSalMin);
        End;
      End;

      objCadLot := TCadLot.Create(Nil);
      Try
        If fEmptyStr(strNumLot) Then
          strNumLot := objCadLot.fRetArmazemPrincipalVenda(strCodIte);

        If Not fEmptyStr(strNumLot) Then
        Begin
          Result := objCadLot.fAtualizaEstoqueLote(strCodIte, strEntSai, strNumLot, fltQtdIte);
        End;

      Finally
        FreeAndNil(objCadLot);
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fAtualizaEstoque]');
      End;
    End;
  Finally
    If Assigned(qryGenIte) Then
      FreeAndNil(qryGenIte);
  End;
end;

{*****************************************}
{* ATUALIZA O SALDO NO ITEGER            *}
{**************************************MV*}
procedure pAtualizaSaldo(strCodIte: String; fltSalBal: Double; dtaDtaBal: TDateTime; fltSalMl: Double = 0; blnSalMl: Boolean = FALSE);
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
begin
  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'SET ';

    If blnSalMl Then
    Begin
      strSQL := strSQL + '  ITE_SAL_ML = :SAL_ML, ';
      strSQL := strSQL + '  ITE_ML_BAL = :SAL_ML, ';
    End;

    strSQL := strSQL + '  ITE_SALBAL = :SALBAL, ';
    strSQL := strSQL + '  ITE_SALDOS = :SALBAL, ';
    strSQL := strSQL + '  ITE_DTABAL = :DTABAL ';


    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin

      CLose;
      SQL.Clear;
      SQL.Add(strSQL);

      {*****************************************}
      {* DADOS QUE SERÃO ATUALIZADOS           *}
      {**************************************MV*}
      ParamByName('SALBAL').AsFloat    := fltSalBal;
      ParamByName('DTABAL').AsDateTime := dtaDtaBal;

      If blnSalMl Then
        ParamByName('SAL_ML').AsFloat    := fltSalMl;

      {*****************************************}
      {* DADOS DO FILTRO                       *}
      {**************************************MV*}
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
end;


function fAtualizaEstoqueML(strCodIte    : String;
                            fltQtdBai    : Double;
                            strNumLot    : String;
                            objReplTinta : IExecutaSQLReplicacaoTinta = nil): Boolean;
  Var
    strSQL   : String;
    objCadLot: TCadLot;
    qryGenIte: TUniQuery;
begin
  Try
    fltQtdBai := fFormataFloat(fltQtdBai, 4);

    qryGenIte := fCriaQuery;

    Try
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  ITEGER ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  ITE_SAL_ML = IFNULL(ITE_SAL_ML, 0) - :QTDBAI ';

      If fltQtdBai > 0 Then
      Begin
        strSQL := strSQL + '  ,ITE_QTDUVE = :QTDBAI, ';
        strSQL := strSQL + '   ITE_DTAUVE = ' + fCurrentDate + ' ';
      End;

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
      strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

      With qryGenIte Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('QTDBAI').AsFloat  := fltQtdBai;

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ExecSQL;
        Close;
      End;

      If fUsaRotinaWMS Or fCfgSis('TMQLOT', varBoolean) Or fCfgSis('LOTBAS', varBoolean) Then
      Begin
        objCadLot := TCadLot.Create(nil);

        Try
          If fEmptyStr(strNumLot) Then
          Begin
            strNumLot := objCadLot.fRetLotePrincipalTintaMaquina(strCodIte, VS_strCodEmp);
          End;

          If Not fEmptyStr(strNumLot) Then
          Begin
            objCadLot.fAtualizaEstoqueMLLote(strCodIte, IIF(fltQtdBai > 0, 'S', 'E'), strNumLot, Abs(fltQtdBai));
          End;
        Finally
          FreeAndNil(objCadLot);
        End;
      End;
      Result := True;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fAtualizaEstoqueML]');
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
end;

end.
