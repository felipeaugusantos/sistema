unit untCadIte;

interface

uses
  Uni, ComCtrls, cxProgressBar, DateUtils, untIExecutaSQLReplicacaoTinta;

  procedure pGeraItensParaLoja(strNumLoj: String; pgbProgresso: TcxProgressBar);

  function fAtualizaEstoqueCadIte(strCodIte,
                                  strEntSai: String;
                                  fltQtdIte, fltPreUve:
                                  Double; strNumLot:
                                  String = '';
                                  blnAtualizaUltimaVenda: boolean = True;
                                  blnRetFalseSeNaoConseguirGerarNotificaoItensAbaixoMin: Boolean = False;
                                  objReplTinta: IExecutaSQLReplicacaoTinta = nil): Boolean;

  function fAtualizaEstoqueML(strCodIte    : String;
                              fltQtdBai    : Double;
                              strNumLot    : String;
                              objReplTinta : IExecutaSQLReplicacaoTinta = nil): Boolean;

  procedure pAtualizaSaldo(strCodIte: String; fltSalBal: Double; dtaDtaBal: TDateTime; fltSalMl: Double = 0; blnSalMl: Boolean = FALSE);

implementation

uses SysUtils, Forms, untFuncoesSimples, untCadLote, Data.DB, untControlaNotSaldoMin;

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
                                fltQtdIte, fltPreUve: Double;
                                strNumLot: String = '';
                                blnAtualizaUltimaVenda: boolean = True;
                                blnRetFalseSeNaoConseguirGerarNotificaoItensAbaixoMin: Boolean = False;
                                objReplTinta: IExecutaSQLReplicacaoTinta = nil): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
    objCadLot: TCadLot;
    objNotSalMin: TControlaNotificacaoSaldoMin;
begin
  Try
    Result := True;
    qryGenIte := fCriaQuery;

    If ((fEmptyStr(strCodIte))) Or
        ((fEmptyStr(strEntSai)) Or (fltQtdIte = 0.0))     Then
    Begin
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'SET ITE_DHUPES = :DHUPES, ';

    If strEntSai = 'E' Then
      strSQL := strSQL + '  ITE_SALDOS = ITE_SALDOS + :QTDITE '
    Else
    Begin
      strSQL := strSQL + '  ITE_NOTESM = IF((((ITE_SALDOS - :QTDITE) < ITE_ESTMIN) AND ITE_SALDOS >= ITE_ESTMIN), "S", ITE_NOTESM), ';
      strSQL := strSQL + '  ITE_SALDOS = ITE_SALDOS - :QTDITE ';
      If blnAtualizaUltimaVenda Then
      begin
        strSQL := strSQL + '  ,ITE_PREUVE = :PREUVE ';
        strSQL := strSQL + '  ,ITE_QTDUVE = :QTDITE ';
        strSQL := strSQL + '  ,ITE_DTAUVE = ' + fCurrentDate + ' ';
      end;
    End;

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    Try

      With qryGenIte Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        {*****************************************}
        {* DADOS QUE SERAO ATULIZADOS            *}
        {**************************************MV*}
        ParamByName('QTDITE').AsFloat := fltQtdIte;
        If (strEntSai = 'S')  And  (blnAtualizaUltimaVenda) Then
        Begin
          ParamByName('PREUVE').AsFloat := fltPreUve;
        End;

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := VS_strCodEmp;

        ParamByName('DHUPES').AsDateTime := EncodeDateTime( YearOf(VS_Date),
                                                            MonthOf(VS_Date),
                                                            DayOf(VS_Date),
                                                            HourOf(fNow()),
                                                            MinuteOf(fNow()),
                                                            SecondOf(fNow()),
                                                            0);

        if (Assigned(objReplTinta)) then
        begin
          If (strEntSai = 'S')  And  (blnAtualizaUltimaVenda) Then
            objReplTinta.pExecutaSQL(strSQL, ['QTDITE', 'PREUVE', 'CODITE', 'CODEMP', 'DHUPES'], [fltQtdIte, fltPreUve, strCodIte, VS_strCodEmp, ParamByName('DHUPES').AsDateTime])
          else
            objReplTinta.pExecutaSQL(strSQL, ['QTDITE', 'CODITE', 'CODEMP', 'DHUPES'], [fltQtdIte, strCodIte, VS_strCodEmp, ParamByName('DHUPES').AsDateTime]);
        end
        else
          ExecSQL;

        If VS_blnNotificaSaldoAbaixMinimo Then
        Begin
          objNotSalMin := TControlaNotificacaoSaldoMin.Create;
          Try
             objNotSalMin.strCodite := strCodIte;

             If objNotSalMin.blnGeraNotificacao Then
              objNotSalMin.fGerarNotificacoes;
          Finally
            FreeAndNil(objNotSalMin);
          End;
        End;

        Close;
      End;

      objCadLot := TCadLot.Create(nil);

      If fEmptyStr(strNumLot) Then
      Begin
        strNumLot := objCadLot.fRetArmazemPrincipalVenda(strCodIte);
      End;

      If Not fEmptyStr(strNumLot) Then
      Begin
        objCadLot.pSetaReplicadorTinta(objReplTinta);
        Result := objCadLot.fAtualizaEstoqueLote(strCodIte, strEntSai, strNumLot, fltQtdIte);
      End;

      FreeAndNil(objCadLot);

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fAtualizaEstoque]');
      End;
    End;

  Finally
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

        if (Assigned(objReplTinta)) then
          objReplTinta.pExecutaSQL(strSQL, ['QTDBAI', 'CODITE', 'CODEMP'], [fltQtdBai, strCodIte, VS_strCodEmp])
        else
          ExecSQL;

        Close;
      End;

      If fUsaRotinaWMS Or fCfgSis('TMQLOT', varBoolean) Then
      Begin
        objCadLot := TCadLot.Create(nil);

        If fEmptyStr(strNumLot) Then
        Begin
          strNumLot := objCadLot.fRetLotePrincipalTintaMaquina(strCodIte, VS_strCodEmp);
        End;

        If Not fEmptyStr(strNumLot) Then
        Begin

          Result := objCadLot.fAtualizaEstoqueMLLote(strCodIte,
                                                     IIF(fltQtdBai > 0, 'S', 'E'),
                                                     strNumLot,
                                                     Abs(fltQtdBai),
                                                     objReplTinta);

        End;

        FreeAndNil(objCadLot);
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
