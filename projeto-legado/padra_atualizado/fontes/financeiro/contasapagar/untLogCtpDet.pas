unit untLogCtpDet;

interface

uses System.SysUtils, System.StrUtils, Data.DB, Uni, UniClientDataSet;

Var
  FCamposCtpDet,
  FCamposLogCtpDet,
  FParametrosLogCtpDet: String;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTP_DTALOG', 'CTP_HORLOG', 'CTP_OPELOG', 'CTP_DESCRI',
                                            'CTP_NOMFRM', 'CTB_AUTCTP', 'CTP_DEBCRE'];

  procedure GeraListaDeCamposLogCtpDet({$IFNDEF LINUX}AConnection : TUniConnection = Nil{$ENDIF});

  procedure GravaLogCtpDet(AAutoIncrem,
                           ADescricao,
                           ANomeFormulario: String;
                           {$IFNDEF LINUX}AConnection : TUniConnection = Nil;{$ENDIF}
                           AOperadorLog: String = '';
                           AAutoIncremLogCtpDet: String = '');

implementation

uses untFuncoesSimples;

procedure GeraListaDeCamposLogCtpDet({$IFNDEF LINUX}AConnection : TUniConnection = Nil{$ENDIF});
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogCtpDet.IsEmpty Then
    Exit;

  LConsulta := fCriaQuery(Nil{$IFNDEF LINUX}, AConnection{$ENDIF});
  Try
    LConsulta.SQL.Text := 'SELECT * FROM LOGCTPDET WHERE FALSE';
    LConsulta.Open;

    FCamposLogCtpDet := '';
    FParametrosLogCtpDet := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposLogCtpDet := FCamposLogCtpDet + LCampo.FieldName + ',';
      FParametrosLogCtpDet := FParametrosLogCtpDet + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogCtpDet := LeftStr(FCamposLogCtpDet, FCamposLogCtpDet.Length - 1);
    FParametrosLogCtpDet := LeftStr(FParametrosLogCtpDet, FParametrosLogCtpDet.Length - 1);

    LConsulta.Close;
    LConsulta.SQL.Text := 'SELECT * FROM CTPDET WHERE FALSE';
    LConsulta.Open;

    FCamposCtpDet := EmptyStr;

    For LCampo In LConsulta.Fields Do
      FCamposCtpDet := FCamposCtpDet + LCampo.FieldName + ',';

    FCamposCtpDet := LeftStr(FCamposCtpDet, FCamposCtpDet.Length - 1);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
End;

procedure GravaLogCtpDet(AAutoIncrem,
                           ADescricao,
                           ANomeFormulario: String;
                           {$IFNDEF LINUX}AConnection : TUniConnection = Nil;{$ENDIF}
                           AOperadorLog: String = '';
                           AAutoIncremLogCtpDet: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;
Begin
  GeraListaDeCamposLogCtpDet({$IFNDEF LINUX}AConnection{$ENDIF});

  LConsulta  := fCriaQuery(Nil{$IFNDEF LINUX},AConnection{$ENDIF});
  LGravarLog := fCriaQuery(Nil{$IFNDEF LINUX},AConnection{$ENDIF});

  Try
    If AOperadorLog.IsEmpty Then
      AOperadorLog := strLoginUsuarioLogado;

    Try

      LConsulta.SQL.Text := 'SELECT ' + FCamposCtpDet + ' FROM CTPDET WHERE AUTOINCREM="' + AAutoIncrem + '"';
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin

        LGravarLog.SQL.Text := 'INSERT INTO LOGCTPDET (' + FCamposLogCtpDet + ') ' +
                               ' VALUES (' + FParametrosLogCtpDet + ') ';

        For LCampo In LConsulta.Fields Do
        Begin
          If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
            Continue;

          LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
        End;

        LGravarLog.ParamByName('AUTOINCREM').AsString   := AAutoIncremLogCtpDet;
        If AAutoIncremLogCtpDet.IsEmpty Then
          LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCTPDET', VS_strCodEmp);

        LGravarLog.ParamByName('CTP_DTALOG').AsDateTime := VS_Date;
        LGravarLog.ParamByName('CTP_HORLOG').AsTime     := fRetHoraServidor;

        LGravarLog.ParamByName('CTP_OPELOG').AsString   := AOperadorLog;

        LGravarLog.ParamByName('CTP_DESCRI').AsString   := ADescricao;
        LGravarLog.ParamByName('CTP_NOMFRM').AsString   := ANomeFormulario;

        LGravarLog.ParamByName('CTP_AUTCTP').AsString := AAutoIncrem;

        LGravarLog.ExecSQL;
      End;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);

    LGravarLog.Close;
    FreeAndNil(LGravarLog);
  End;
End;

end.
