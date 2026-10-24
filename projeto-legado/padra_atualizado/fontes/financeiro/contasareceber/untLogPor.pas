unit untLogPor;

interface

uses System.SysUtils, Uni, DB, StrUtils, Variants;

  Var
    FCamposCadPor,
    FCamposLogPor,
    FParametrosLogPor: String;
  Const
    FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'POR_DTALOG', 'POR_HORLOG', 'POR_OPELOG', 'POR_DESCRI',
                                              'POR_NOMFRM', 'POR_NOMEXE', 'POR_VEREXE', 'POR_DTAEXE', 'POR_HOREXE'];

  procedure GeraListaDeCamposLOGPOR;

  procedure GravaLogPor(AAutoIncrem,
                        ADescricao,
                        ANomeFormulario: String;
                        AOperadorLog: String = '');

  function RetornaOperadorDoLog(AOperadorLog: String): String;

implementation

uses untFuncoesSimples, untUtilRepository, Forms, System.DateUtils,
     untVersaoProg;

function RetornaOperadorDoLog(AOperadorLog: String): String;
Begin
  Result := strLoginUsuarioLogado;

  If Not AOperadorLog.IsEmpty Then
    Result := AOperadorLog;
End;

procedure GeraListaDeCamposLOGPOR;
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogPor.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery(Nil);
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM LOGPOR WHERE FALSE');
    LConsulta.Open;

    FCamposLogPor := '';
    FParametrosLogPor := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposLogPor := FCamposLogPor + LCampo.FieldName + ',';
      FParametrosLogPor := FParametrosLogPor + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogPor := LeftStr(FCamposLogPor, FCamposLogPor.Length - 1);
    FParametrosLogPor := LeftStr(FParametrosLogPor, FParametrosLogPor.Length - 1);

    LConsulta := fCriaQuery(Nil);
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM CADPOR WHERE FALSE');
    LConsulta.Open;

    FCamposCadPor := '';

    For LCampo In LConsulta.Fields Do
      FCamposCadPor := FCamposCadPor + LCampo.FieldName + ',';

    FCamposCadPor := LeftStr(FCamposCadPor, FCamposCadPor.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

procedure GravaLogPor(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
Begin
  GeraListaDeCamposLOGPOR;

  LConsulta  := fCriaQuery(Nil);
  LGravarLog := fCriaQuery(Nil);
  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadPor + ' FROM CADPOR WHERE AUTOINCREM = ' + QuotedStr(AAutoIncrem) ;
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGPOR (' + FCamposLogPor + ') ' +
                             ' VALUES (' + FParametrosLogPor + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;

        If Pos(LCampo.FieldName,FCamposLogPor) <= 0 Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGPOR', LConsulta.FieldByName('POR_CODEMP').AsString);
      LGravarLog.ParamByName('POR_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('POR_HORLOG').AsTime     := fRetHoraServidor;

      LGravarLog.ParamByName('POR_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

      LGravarLog.ParamByName('POR_DESCRI').AsString   := ADescricao;
      LGravarLog.ParamByName('POR_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('POR_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LGravarLog.ParamByName('POR_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      LGravarLog.ParamByName('POR_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('POR_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
                                                         MinuteOf(LDataExecutavel),
                                                         SecondOf(LDataExecutavel),
                                                         MilliSecondOf(LDataExecutavel));

      LGravarLog.ExecSQL;
    End;

    FreeAndNil(LConsulta);
    FreeAndNil(LGravarLog);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

end.
