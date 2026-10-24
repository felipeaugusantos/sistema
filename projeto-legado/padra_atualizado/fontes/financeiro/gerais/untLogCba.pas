{********************************}
{* EFETUA A GRAVAÇÃO DO LOGCBA  *}
{* A PARTIR DE UM LANÇAMENTO    *}
{* DA MOVBAN(LOG DE CONCILIAÇÃO)*}
{*****************************KP*}
unit untLogCba;

interface

uses System.SysUtils, Forms, System.DateUtils, untVersaoProg,
     Uni, Data.DB, System.StrUtils;

Var
  FCamposMovBan,
  FCamposLogCba,
  FParametrosLogCba: String;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTB_DTALOG', 'CTB_HORLOG', 'CTB_OPELOG', 'CTB_DESCRI',
                                            'CTB_NOMFRM', 'CTB_NOMEXE', 'CTB_VEREXE', 'CTB_DTAEXE', 'CTB_HOREXE',
                                            'CTB_ARQIMP'];


  procedure GeraListaDeCamposLOGCBA({$IFNDEF LINUX}AConnection : TUniConnection = Nil{$ENDIF});

  procedure GravaLogCba(AAutoIncrem,
                        ADescricao,
                        ANomeFormulario: String;
                        ANomeArquivo: String = '';
                        {$IFNDEF LINUX}AConnection : TUniConnection = Nil;{$ENDIF}
                        AOperadorLog: String = '';
                        AAutoIncremLogCba: String = '');

  procedure pGravaLogCba(ASequenciaLancamento, ADescricao, ANomeFormulario : string); overload;

implementation

uses untFuncoesSimples, System.Generics.Collections;

procedure pGravaLogCba(ASequenciaLancamento, ADescricao, ANomeFormulario : string); overload;
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
Begin
  LConsulta  := nil;
  LGravarLog := nil;

  {***************************************************}
  {* GUARD: nao grava LOGCBA com SEQLAN vazio        *}
  {* REQ 432962 - Previne log inconsistente por      *}
  {*             perda de conexao durante gravacao   *}
  {*************************************************VF}
  If Trim(ASequenciaLancamento) = '' Then
    Exit;

  GeraListaDeCamposLOGCBA;

  LConsulta  := fCriaQuery;
  LGravarLog := fCriaQuery;
  try
    Try

      LConsulta.SQL.Text := 'SELECT ' + FCamposMovBan + ' FROM MOVBAN WHERE CTB_SEQLAN="' + ASequenciaLancamento + '"';
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin

        LGravarLog.SQL.Text := 'INSERT INTO LOGCBA (' + FCamposLogCba + ') ' +
                               ' VALUES (' + FParametrosLogCba + ') ';

        For LCampo In LConsulta.Fields Do
        Begin
          If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
            Continue;

          LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
        End;

       LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCBA', VS_strCodEmp);

       LGravarLog.ParamByName('CTB_DTALOG').AsDateTime := VS_Date;
       LGravarLog.ParamByName('CTB_HORLOG').AsTime     := fRetHoraServidor;

       LGravarLog.ParamByName('CTB_OPELOG').AsString   := strLoginUsuarioLogado;

        LGravarLog.ParamByName('CTB_DESCRI').AsString   := ADescricao;
        LGravarLog.ParamByName('CTB_NOMFRM').AsString   := ANomeFormulario;

        FileAge(Application.ExeName, LDataExecutavel);

        LGravarLog.ParamByName('CTB_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
       {$IFNDEF LINUX}
        LGravarLog.ParamByName('CTB_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
       {$ENDIF}
        LGravarLog.ParamByName('CTB_DTAEXE').AsDateTime := LDataExecutavel;
        LGravarLog.ParamByName('CTB_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
                                                           MinuteOf(LDataExecutavel),
                                                           SecondOf(LDataExecutavel),
                                                           MilliSecondOf(LDataExecutavel));

        LGravarLog.ExecSQL;
      End;

    Except
      On E: Exception Do
        Raise;
    End;
  finally
    FreeAndNil(LConsulta);
    FreeAndNil(LGravarLog);
  end;
end;

procedure GeraListaDeCamposLOGCBA({$IFNDEF LINUX}AConnection : TUniConnection = Nil{$ENDIF});
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  LConsulta := nil;
  If Not FCamposLogCba.IsEmpty Then
    Exit;

  LConsulta := fCriaQuery(Nil{$IFNDEF LINUX}, AConnection{$ENDIF});
  try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM LOGCBA WHERE FALSE');
    LConsulta.Open;

    FCamposLogCba := '';
    FParametrosLogCba := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposLogCba := FCamposLogCba + LCampo.FieldName + ',';
      FParametrosLogCba := FParametrosLogCba + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogCba := LeftStr(FCamposLogCba, FCamposLogCba.Length - 1);
    FParametrosLogCba := LeftStr(FParametrosLogCba, FParametrosLogCba.Length - 1);

    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM MOVBAN WHERE FALSE');
    LConsulta.Open;

    FCamposMovBan := EmptyStr;

    For LCampo In LConsulta.Fields Do
      FCamposMovBan := FCamposMovBan + LCampo.FieldName + ',';

    FCamposMovBan := LeftStr(FCamposMovBan, FCamposMovBan.Length - 1);
  finally
    if Assigned(LConsulta) then
      FreeAndNil(LConsulta);
  end;
End;

procedure GravaLogCba(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      ANomeArquivo: String = '';
                      {$IFNDEF LINUX}AConnection : TUniConnection = Nil;{$ENDIF}
                      AOperadorLog: String = '';
                      AAutoIncremLogCba: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
Begin
  GeraListaDeCamposLOGCBA({$IFNDEF LINUX}AConnection{$ENDIF});

  LConsulta  := fCriaQuery(Nil{$IFNDEF LINUX},AConnection{$ENDIF});
  LGravarLog := fCriaQuery(Nil{$IFNDEF LINUX},AConnection{$ENDIF});

  If AOperadorLog.IsEmpty Then
    AOperadorLog := strLoginUsuarioLogado;

  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposMovBan + ' FROM MOVBAN WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGCBA (' + FCamposLogCba + ') ' +
                             ' VALUES (' + FParametrosLogCba + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := AAutoIncremLogCba;
      If AAutoIncremLogCba.IsEmpty Then
        LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCBA', VS_strCodEmp);

      LGravarLog.ParamByName('CTB_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('CTB_HORLOG').AsTime     := fRetHoraServidor;

      LGravarLog.ParamByName('CTB_OPELOG').AsString   := AOperadorLog;

      LGravarLog.ParamByName('CTB_DESCRI').AsString   := ADescricao;
      LGravarLog.ParamByName('CTB_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('CTB_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      {$IFNDEF LINUX}
      LGravarLog.ParamByName('CTB_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      {$ENDIF}
      LGravarLog.ParamByName('CTB_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('CTB_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
                                                         MinuteOf(LDataExecutavel),
                                                         SecondOf(LDataExecutavel),
                                                         MilliSecondOf(LDataExecutavel));

      LGravarLog.ParamByName('CTB_ARQIMP').AsString := ANomeArquivo;

      LGravarLog.ExecSQL;
    End;

    FreeAndNil(LConsulta);
    FreeAndNil(LGravarLog);
  Except
    On E: Exception Do
      Raise;
  End;
End;

end.
