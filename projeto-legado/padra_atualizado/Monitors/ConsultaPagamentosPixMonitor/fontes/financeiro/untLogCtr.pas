{*******************************}
{* EFETUA A GRAVAÇÃO DO LOGCTR *}
{* A PARTIR DE UMA DUPLICATA   *}
{****************************AJ*}
unit untLogCtr;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
{$ENDIF }
  System.SysUtils, Uni, DB, StrUtils, Variants;

Var
  FCamposCadRec,
  FCamposLogCtr,
  FParametrosLogCtr: String;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTR_DTALOG', 'CTR_HORLOG', 'CTR_OPELOG', 'CTR_DESCRI',
                                            'CTR_NOMFRM', 'CTR_NOMEXE', 'CTR_VEREXE', 'CTR_DTAEXE', 'CTR_HOREXE'];

procedure GeraListaDeCamposLOGCTR;

procedure GravaLogCtr(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AOperadorLog: String = '';
                      ASeqConLog: Integer = 0;
                      AResCaiLog: Integer = 0;
                      AHisCom: String = '';
                      ARecPixLog: String = 'N'); overload;

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

function RetornaOperadorDoLog(AOperadorLog: String): String;
function RetornaBancoEnvio(ABancoEnvio: String): Variant;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  Forms, untVersaoProg,
{$ENDIF}
  untFuncoesSimples, untUtilRepository, System.DateUtils;

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

procedure GeraListaDeCamposLOGCTR;
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogCtr.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriarQuery('SELECT * FROM LOGCTR WHERE FALSE');
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

    LConsulta.Close;
    LConsulta := fCriarQuery('SELECT * FROM CADREC WHERE FALSE');
    LConsulta.Open;

    FCamposCadRec := '';

    For LCampo In LConsulta.Fields Do
      FCamposCadRec := FCamposCadRec + LCampo.FieldName + ',';

    FCamposCadRec := LeftStr(FCamposCadRec, FCamposCadRec.Length - 1);
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
                      ARecPixLog: String = 'N');
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

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadRec + ' FROM CADREC WHERE AUTOINCREM="' + AAutoIncrem + '"';
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

      If LConsulta.FieldByName('CTR_ESPDOC').AsString = 'CC' Then
      Begin
        If ASeqConLog > 0 Then
          LGravarLog.ParamByName('CTR_SEQCON').AsInteger := ASeqConLog;

        If AResCaiLog > 0 Then
          LGravarLog.ParamByName('CTR_RESCAI').AsInteger := AResCaiLog;

        LGravarLog.ParamByName('CTR_RECPIX').AsString := ARecPixLog;
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

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadRec + ' FROM CADREC WHERE ' +
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
