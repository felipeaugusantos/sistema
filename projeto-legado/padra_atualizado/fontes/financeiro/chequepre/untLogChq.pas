unit untLogChq;

interface

Uses untFuncoesSimples, Forms,  untVersaoProg, System.SysUtils, System.DateUtils,
     System.Variants, Uni;

  procedure GravaLogChq(AAutoIncrem: String;
                        ADescricao,
                        ANomeFormulario: String;
                        AAutoIncremLog: String = ''); overload;

  procedure GravaLogChq(ACodigoBanco,
                        ANumeroAgencia,
                        AContaCorrente,
                        ANumeroCheque,
                        ADescricao,
                        ANomeFormulario: String;
                        AAutoIncremLog: String = ''); overload;

implementation

procedure GravaLogChq(AAutoIncrem: String;
                      ADescricao,
                      ANomeFormulario: String;
                      AAutoIncremLog: String = ''); overload;
  var
    LCadChq,
    LLogChq: TUniQuery;

    LContador: Integer;

    LDataExecutavel: TDateTime;
Begin
  Try
    Try
      LCadChq := fCriarQuery('SELECT * FROM CADCHQ WHERE AUTOINCREM = "' + AAutoincrem + '"');
      LCadChq.Open;

      If LCadChq.IsEmpty Then
        Exit;

      FileAge(Application.ExeName, LDataExecutavel);

      LLogChq := fCriarQuery('SELECT * FROM LOGCHQ WHERE FALSE');
      LLogChq.Open;

      LLogChq.Append;
      For LContador := 0 To LCadChq.FieldCount -1 Do
      Begin
        If LLogChq.FindField(LCadChq.Fields[LContador].FieldName) <> Nil Then
          LLogChq.FieldByName(LCadChq.Fields[LContador].FieldName).Value :=
            LCadChq.Fields[LContador].Value;
      End;

      If AAutoIncremLog.IsEmpty Then
        AAutoIncremLog := fRetAutoIncrem('LOGCHQ', VS_strCodEmp);

      LLogChq.FieldByName('AUTOINCREM').AsString   := AAutoIncremLog;
      LLogChq.FieldByName('CHQ_NOMFRM').AsString   := ANomeFormulario;
      LLogChq.FieldByName('CHQ_HISLOG').AsString   := ADescricao;
      LLogChq.FieldByName('CHQ_DTALOG').AsDateTime := VS_Date;
      LLogChq.FieldByName('CHQ_HORLOG').AsDateTime := fRetHoraServidor;
      LLogChq.FieldByName('CHQ_OPELOG').AsString   := strLoginUsuarioLogado;
      LLogChq.FieldByName('CHQ_NOMTAB').AsString   := 'CADCHQ';
      LLogChq.FieldByName('CHQ_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LLogChq.FieldByName('CHQ_DTAEXE').Value      := LDataExecutavel;
      LLogChq.FieldByName('CHQ_HOREXE').Value      := EncodeTime(HourOf(LDataExecutavel),
                                                                 MinuteOf(LDataExecutavel),
                                                                 SecondOf(LDataExecutavel),
                                                                 MilliSecondOf(LDataExecutavel));

      LLogChq.FieldByName('CHQ_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      LLogChq.Post;
    Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
    End;
  Finally
    If Assigned(LLogChq) Then
      FreeAndNil(LLogChq);

    If Assigned(LCadChq) Then
      FreeAndNil(LCadChq);
  End;
End;

procedure GravaLogChq(ACodigoBanco,
                      ANumeroAgencia,
                      AContaCorrente,
                      ANumeroCheque,
                      ADescricao,
                      ANomeFormulario: String;
                      AAutoIncremLog: String = ''); overload;
  var
    LCadChq,
    LLogChq: TUniQuery;

    LContador: Integer;

    LDataExecutavel: TDateTime;
Begin
  LCadChq := fCriaQuery;

  Try
    Try
      LCadChq.SQL.Text := 'SELECT * ' +
                          'FROM CADCHQ ' +
                          'WHERE CHQ_CODBCO=:CODBCO ' +
                          '  AND CHQ_NUMAGE=:NUMAGE ' +
                          '  AND CHQ_CONCOR=:CONCOR ' +
                          '  AND CHQ_NUMCHQ=:NUMCHQ ';

      LCadChq.paramByName('CODBCO').AsString := ACodigoBanco;
      LCadChq.paramByName('NUMAGE').AsString := ANumeroAgencia;
      LCadChq.paramByName('CONCOR').AsString := AContaCorrente;
      LCadChq.paramByName('NUMCHQ').AsString := ANumeroCheque;
      LCadChq.Open;

      If LCadChq.IsEmpty Then
        Exit;

      FileAge(Application.ExeName, LDataExecutavel);

      LLogChq := fCriarQuery('SELECT * FROM LOGCHQ WHERE FALSE');
      LLogChq.Open;

      LLogChq.Append;
      For LContador := 0 To LCadChq.FieldCount -1 Do
      Begin
        If LLogChq.FindField(LCadChq.Fields[LContador].FieldName) <> Nil Then
          LLogChq.FieldByName(LCadChq.Fields[LContador].FieldName).Value :=
            LCadChq.Fields[LContador].Value;
      End;

      If AAutoIncremLog.IsEmpty Then
        AAutoIncremLog := fRetAutoIncrem('LOGCHQ', VS_strCodEmp);

      LLogChq.FieldByName('AUTOINCREM').AsString   := AAutoIncremLog;
      LLogChq.FieldByName('CHQ_NOMFRM').AsString   := ANomeFormulario;
      LLogChq.FieldByName('CHQ_HISLOG').AsString   := ADescricao;
      LLogChq.FieldByName('CHQ_DTALOG').AsDateTime := VS_Date;
      LLogChq.FieldByName('CHQ_HORLOG').AsDateTime := fRetHoraServidor;
      LLogChq.FieldByName('CHQ_OPELOG').AsString   := strLoginUsuarioLogado;
      LLogChq.FieldByName('CHQ_NOMTAB').AsString   := 'CADCHQ';
      LLogChq.FieldByName('CHQ_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LLogChq.FieldByName('CHQ_DTAEXE').Value      := LDataExecutavel;
      LLogChq.FieldByName('CHQ_HOREXE').Value      := EncodeTime(HourOf(LDataExecutavel),
                                                                 MinuteOf(LDataExecutavel),
                                                                 SecondOf(LDataExecutavel),
                                                                 MilliSecondOf(LDataExecutavel));

      LLogChq.FieldByName('CHQ_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      LLogChq.Post;
    Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
    End;
  Finally
    If Assigned(LLogChq) Then
      FreeAndNil(LLogChq);

    LCadChq.Close;
    FreeAndNil(LCadChq);
  End;
End;

end.
