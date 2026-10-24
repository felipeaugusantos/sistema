{*******************************}
{* EFETUA A GRAVAÇÃO DO LOGCTR *}
{* A PARTIR DE UMA DUPLICATA   *}
{****************************AJ*}
unit untLogCtr;

interface

uses System.SysUtils, Uni, DB, StrUtils, Variants, untFuncoesSimples;

Var
  FCamposCadRec_Log,
  FCamposLogCtr,
  FParametrosLogCtr: String;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTR_DTALOG', 'CTR_HORLOG', 'CTR_OPELOG', 'CTR_DESCRI',
                                            'CTR_NOMFRM', 'CTR_NOMEXE', 'CTR_VEREXE', 'CTR_DTAEXE', 'CTR_HOREXE'];

procedure GeraListaDeCamposLOGCTR({$IFNDEF LINUX}AConnection : TUniConnection = Nil{$ENDIF});

procedure GravaLogCtr(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '';
                      ASeqConLog: Integer = 0;
                      AResCaiLog: Integer = 0;
                      AHisCom: String = '';
                      ARecPixLog: String = '';
                      {$IFNDEF LINUX}AConnection : TUniConnection = Nil;{$ENDIF}
                      AAutoIncLogCtr: String = ''); overload;

procedure GravaLogCtr(ANumDup,
                      AEspDoc,
                      ACodCli,
                      ACodEmp,
                      AParcel: String;
                      ASeqBai: Integer;
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '';
                      AHisCom: String = ''); overload;

procedure GravaLogCtr(ANumDup,
                      AEspDoc,
                      ACodCli,
                      ACodEmp,
                      AParcel: String;
                      ASeqBai: Integer;
                      ADescricao,
                      ANomeFormulario: String;
                      AVlDespCob: Double;
                      AOperadorLog: String = '';
                      AHisCom: String = ''); overload;

procedure GravaLogCtr(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      ARecEspeciesCC: array of TEspeciesGerCC;
                      AOperadorLog: String = '';
                      ASeqConLog: Integer = 0;
                      AResCaiLog: Integer = 0;
                      AHisCom: String = '';
                      ARecPixLog: String = 'N';
                      AConnection : TUniConnection = Nil;
                      AAutoIncLogCtr: String = ''); overload;

function RetornaOperadorDoLog(AOperadorLog: String): String;
function RetornaBancoEnvio(ABancoEnvio: String): Variant;

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms, untUtilRepository, untVersaoProg,
{$ENDIF}
  System.DateUtils;

function RetornaBancoEnvio(ABancoEnvio: String): Variant;
Begin
  Result := Null;

  If Not ABancoEnvio.IsEmpty Then
    Result := ABancoEnvio;
End;

function RetornaOperadorDoLog(AOperadorLog: String): String;
Begin
  Result := strLoginUsuarioLogado;

  If Not AOperadorLog.IsEmpty Then
    Result := AOperadorLog;
End;

procedure GeraListaDeCamposLOGCTR({$IFNDEF LINUX}AConnection : TUniConnection = Nil{$ENDIF});
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogCtr.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery(Nil{$IFNDEF LINUX}, AConnection{$ENDIF});
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM LOGCTR WHERE FALSE');
    LConsulta.Open;

    FCamposLogCtr := '';
    FParametrosLogCtr := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposLogCtr := FCamposLogCtr + LCampo.FieldName + ',';
      FParametrosLogCtr := FParametrosLogCtr + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogCtr := LeftStr(FCamposLogCtr, FCamposLogCtr.Length - 1);
    FParametrosLogCtr := LeftStr(FParametrosLogCtr, FParametrosLogCtr.Length - 1);

    LConsulta := fCriaQuery(Nil{$IFNDEF LINUX}, AConnection{$ENDIF});
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM CADREC WHERE FALSE');
    LConsulta.Open;

    FCamposCadRec_Log := '';

    For LCampo In LConsulta.Fields Do
      FCamposCadRec_Log := FCamposCadRec_Log + LCampo.FieldName + ',';

    FCamposCadRec_Log := LeftStr(FCamposCadRec_Log, FCamposCadRec_Log.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

procedure GravaLogCtr(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '';
                      ASeqConLog: Integer = 0;
                      AResCaiLog: Integer = 0;
                      AHisCom: String = '';
                      ARecPixLog: String = '';
                      {$IFNDEF LINUX}AConnection : TUniConnection = Nil;{$ENDIF}
                      AAutoIncLogCtr: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
    LSql : String;
Begin
  GeraListaDeCamposLOGCTR({$IFNDEF LINUX}AConnection{$ENDIF});

  LConsulta  := fCriaQuery(Nil{$IFNDEF LINUX},AConnection{$ENDIF});
  LGravarLog := fCriaQuery(Nil{$IFNDEF LINUX},AConnection{$ENDIF});
  Try

    Try
      LSql := 'SELECT ' + FCamposCadRec_Log + ' FROM CADREC WHERE AUTOINCREM="' + AAutoIncrem + '"';
      LConsulta.SQL.Add( LSql );
      LConsulta.Open;
    Except
      On E: Exception Do
         Raise Exception.Create(E.Message + ' - ' + LSql);
    End;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGCTR (' + FCamposLogCtr + ') ' +
                             ' VALUES (' + FParametrosLogCtr + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      If fEmptyStr(AAutoIncLogCtr) Then
       {$IFDEF LINUX}
        AAutoIncLogCtr := fRetAutoIncrem('LOGCTR', LConsulta.FieldByName('CTR_CODEMP').AsString, -1, False);
       {$ELSE}
        AAutoIncLogCtr := fRetAutoIncrem('LOGCTR', LConsulta.FieldByName('CTR_CODEMP').AsString);
       {$ENDIF}

      LGravarLog.ParamByName('AUTOINCREM').AsString   := AAutoIncLogCtr;
      LGravarLog.ParamByName('CTR_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('CTR_HORLOG').AsTime     := fRetHoraServidor({$IFNDEF LINUX}AConnection{$ENDIF});

      LGravarLog.ParamByName('CTR_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

      LGravarLog.ParamByName('CTR_DESCRI').AsString   := ADescricao + ' LD';
      LGravarLog.ParamByName('CTR_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('CTR_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      {$IFNDEF LINUX}
      LGravarLog.ParamByName('CTR_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto(AConnection);
      {$ENDIF}
      LGravarLog.ParamByName('CTR_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('CTR_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
                                                         MinuteOf(LDataExecutavel),
                                                         SecondOf(LDataExecutavel),
                                                         MilliSecondOf(LDataExecutavel));

      LGravarLog.ParamByName('CTR_BCOENV').Value := RetornaBancoEnvio(LConsulta.FieldByName('CTR_BCOENV').AsString);
      LGravarLog.ParamByName('CTR_HISCOM').AsString   := AHisCom;

      If Assigned(LGravarLog.FindParam('CTR_SBANCC')) Then
        LGravarLog.ParamByName('CTR_SBANCC').Value := Null;

      If LConsulta.FieldByName('CTR_ESPDOC').AsString = 'CC' Then
      Begin
        If ASeqConLog > 0 Then
          LGravarLog.ParamByName('CTR_SEQCON').AsInteger := ASeqConLog;

        If AResCaiLog > 0 Then
          LGravarLog.ParamByName('CTR_RESCAI').AsInteger := AResCaiLog;

        If Not fEmptyStr(ARecPixLog) Then
          LGravarLog.ParamByName('CTR_RECPIX').AsString := ARecPixLog
        Else If fEmptyStr(LGravarLog.ParamByName('CTR_RECPIX').AsString) Then
          LGravarLog.ParamByName('CTR_RECPIX').AsString := 'N';
      End;

      LGravarLog.ExecSQL;
    End;

    FreeAndNil(LConsulta);
    FreeAndNil(LGravarLog);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure GravaLogCtr(ANumDup,
                      AEspDoc,
                      ACodCli,
                      ACodEmp,
                      AParcel: String;
                      ASeqBai: Integer;
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '';
                      AHisCom: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
Begin
  GeraListaDeCamposLOGCTR;

  LConsulta := fCriaQuery;
  LGravarLog := fCriaQuery;
  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadRec_Log + ' FROM CADREC WHERE ' +
                          '   CTR_NUMDUP="' + ANumDup + '" AND ' +
                          '   CTR_PARCEL="' + AParcel + '" AND ' +
                          '   CTR_ESPDOC="' + AEspDoc + '" AND ' +
                          '   CTR_CODEMP="' + ACodEmp + '" AND ' +
                          '   CTR_CODCLI="' + ACodCli + '" AND ' +
                          '   CTR_SEQBAI='  + ASeqBai.ToString;
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      LGravarLog.SQL.Text := 'INSERT INTO LOGCTR (' + FCamposLogCtr + ') ' +
                             ' VALUES (' + FParametrosLogCtr + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCTR', LConsulta.FieldByName('CTR_CODEMP').AsString);
      LGravarLog.ParamByName('CTR_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('CTR_HORLOG').AsTime     := fRetHoraServidor;

      LGravarLog.ParamByName('CTR_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

      LGravarLog.ParamByName('CTR_DESCRI').AsString   := ADescricao + ' LD';
      LGravarLog.ParamByName('CTR_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('CTR_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      {$IFNDEF LINUX}
      LGravarLog.ParamByName('CTR_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      {$ENDIF}
      LGravarLog.ParamByName('CTR_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('CTR_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
                                                         MinuteOf(LDataExecutavel),
                                                         SecondOf(LDataExecutavel),
                                                         MilliSecondOf(LDataExecutavel));

      LGravarLog.ParamByName('CTR_BCOENV').Value := RetornaBancoEnvio(LConsulta.FieldByName('CTR_BCOENV').AsString);
      LGravarLog.ParamByName('CTR_HISCOM').AsString   := AHisCom;

      If Assigned(LGravarLog.FindParam('CTR_SBANCC')) Then
        LGravarLog.ParamByName('CTR_SBANCC').Value := Null;

      LGravarLog.ExecSQL;
    End;

    FreeAndNil(LConsulta);
    FreeAndNil(LGravarLog);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

End;

procedure GravaLogCtr(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      ARecEspeciesCC: array of TEspeciesGerCC;
                      AOperadorLog: String = '';
                      ASeqConLog: Integer = 0;
                      AResCaiLog: Integer = 0;
                      AHisCom: String = '';
                      ARecPixLog: String = 'N';
                      AConnection : TUniConnection = Nil;
                      AAutoIncLogCtr: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
    intCont : integer;
Begin
  GeraListaDeCamposLOGCTR(AConnection);

  LConsulta  := fCriaQuery(Nil,AConnection);
  LGravarLog := fCriaQuery(Nil,AConnection);
  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadRec_Log + ' FROM CADREC WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGCTR (' + FCamposLogCtr + ') ' +
                             ' VALUES (' + FParametrosLogCtr + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := IIF(fEmptyStr(AAutoIncLogCtr),fRetAutoIncrem('LOGCTR', LConsulta.FieldByName('CTR_CODEMP').AsString),AAutoIncLogCtr);
      LGravarLog.ParamByName('CTR_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('CTR_HORLOG').AsTime     := fRetHoraServidor(AConnection);

      LGravarLog.ParamByName('CTR_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

      LGravarLog.ParamByName('CTR_DESCRI').AsString   := ADescricao;
      LGravarLog.ParamByName('CTR_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('CTR_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LGravarLog.ParamByName('CTR_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto(AConnection);
      LGravarLog.ParamByName('CTR_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('CTR_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
                                                         MinuteOf(LDataExecutavel),
                                                         SecondOf(LDataExecutavel),
                                                         MilliSecondOf(LDataExecutavel));

      LGravarLog.ParamByName('CTR_BCOENV').Value := RetornaBancoEnvio(LConsulta.FieldByName('CTR_BCOENV').AsString);
      LGravarLog.ParamByName('CTR_HISCOM').AsString   := AHisCom;

      If Assigned(LGravarLog.FindParam('CTR_SBANCC')) Then
        LGravarLog.ParamByName('CTR_SBANCC').Value := Null;

      If LConsulta.FieldByName('CTR_ESPDOC').AsString = 'CC' Then
      Begin
        If ASeqConLog > 0 Then
          LGravarLog.ParamByName('CTR_SEQCON').AsInteger := ASeqConLog;

        If AResCaiLog > 0 Then
          LGravarLog.ParamByName('CTR_RESCAI').AsInteger := AResCaiLog;

        LGravarLog.ParamByName('CTR_RECPIX').AsString := ARecPixLog;

        If (Length(ARecEspeciesCC) > 0) Then
        Begin
           For intCont := 0 To Length(ARecEspeciesCC) -1 Do
           Begin
               If ARecEspeciesCC[intCont].StrEspecie = 'CTR_DINHEI' Then
                  LGravarLog.ParamByName('CTR_DINHEI').Value := ARecEspeciesCC[intCont].fltCreditoCalc
               Else
               If ARecEspeciesCC[intCont].StrEspecie = 'CTR_CARTAO' Then
                  LGravarLog.ParamByName('CTR_CARTAO').Value := ARecEspeciesCC[intCont].fltCreditoCalc
               Else
               If ARecEspeciesCC[intCont].StrEspecie = 'CTR_CHQPRE' Then
                  LGravarLog.ParamByName('CTR_CHQPRE').Value := ARecEspeciesCC[intCont].fltCreditoCalc
               Else
               If ARecEspeciesCC[intCont].StrEspecie = 'CTR_CHQAVI' Then
                  LGravarLog.ParamByName('CTR_CHQAVI').Value := ARecEspeciesCC[intCont].fltCreditoCalc
               Else
               If ARecEspeciesCC[intCont].StrEspecie = 'CTR_ORDPAG' Then
                  LGravarLog.ParamByName('CTR_ORDPAG').Value := ARecEspeciesCC[intCont].fltCreditoCalc;
           End;
        End;

      End;

      LGravarLog.ExecSQL;
    End;

    FreeAndNil(LConsulta);
    FreeAndNil(LGravarLog);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

procedure GravaLogCtr(ANumDup,
                      AEspDoc,
                      ACodCli,
                      ACodEmp,
                      AParcel: String;
                      ASeqBai: Integer;
                      ADescricao,
                      ANomeFormulario: String;
                      AVlDespCob: Double;
                      AOperadorLog: String = '';
                      AHisCom: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
Begin
  GeraListaDeCamposLOGCTR;

  LConsulta := fCriaQuery;
  LGravarLog := fCriaQuery;
  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadRec_Log + ' FROM CADREC WHERE ' +
                          '   CTR_NUMDUP="' + ANumDup + '" AND ' +
                          '   CTR_PARCEL="' + AParcel + '" AND ' +
                          '   CTR_ESPDOC="' + AEspDoc + '" AND ' +
                          '   CTR_CODEMP="' + ACodEmp + '" AND ' +
                          '   CTR_CODCLI="' + ACodCli + '" AND ' +
                          '   CTR_SEQBAI='  + ASeqBai.ToString;
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      LGravarLog.SQL.Text := 'INSERT INTO LOGCTR (' + FCamposLogCtr + ') ' +
                             ' VALUES (' + FParametrosLogCtr + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCTR', LConsulta.FieldByName('CTR_CODEMP').AsString);
      LGravarLog.ParamByName('CTR_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('CTR_HORLOG').AsTime     := fRetHoraServidor;

      LGravarLog.ParamByName('CTR_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

      LGravarLog.ParamByName('CTR_DESCRI').AsString   := ADescricao + ' LD';
      LGravarLog.ParamByName('CTR_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('CTR_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      {$IFNDEF LINUX}
      LGravarLog.ParamByName('CTR_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      {$ENDIF}
      LGravarLog.ParamByName('CTR_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('CTR_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
                                                         MinuteOf(LDataExecutavel),
                                                         SecondOf(LDataExecutavel),
                                                         MilliSecondOf(LDataExecutavel));

      LGravarLog.ParamByName('CTR_BCOENV').Value := RetornaBancoEnvio(LConsulta.FieldByName('CTR_BCOENV').AsString);
      LGravarLog.ParamByName('CTR_HISCOM').AsString   := AHisCom;
      LGravarLog.ParamByName('CTR_DESCOB').AsFloat    := AVlDespCob;

      If Assigned(LGravarLog.FindParam('CTR_SBANCC')) Then
        LGravarLog.ParamByName('CTR_SBANCC').Value := Null;

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
