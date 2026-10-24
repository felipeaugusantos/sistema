{*******************************}
{* EFETUA A GRAVAÇÃO DO LOGCTP *}
{* A PARTIR DE UMA DUPLICATA   *}
{****************************AF*}
unit untLogCtp;

interface

uses System.SysUtils, untTCadPag, untObjectManager, Forms, untVersaoProg, Uni,
     Data.DB, System.StrUtils;

Var
  FCamposCadPag,
  FCamposLogCtp,
  FParametrosLogCtp: String;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTP_DTALOG', 'CTP_HORLOG', 'CTP_OPELOG', 'CTP_DESCRI',
                                            'CTP_NOMFRM', 'CTP_NOMEXE', 'CTP_VEREXE', 'CTP_DTAEXE', 'CTP_HOREXE','CTP_NOMTAB'];
  FArrayCamposCalculados: Array of String = ['CTP_NUMENT', 'CTP_ESPENT', 'CTP_EMPENT', 'CTP_SERENT',
                                            'CTP_FORENT'];
                                            

  procedure GeraListaDeCamposLOGCTP;

  procedure GravaLogCtp(AAutoIncrem,
                       ADescricao,
                       ANomeFormulario: String;
                       AAutoIncremLogCtp: String = '');

  procedure pGravaLogCtp(ADup: TCadPag;
                         strDescri,
                         strNomFrm: String;
                         strAutInc: String = '');

implementation

uses untFuncoesSimples, untUtilRepository, System.DateUtils;

procedure pGravaLogCtp(ADup: TCadPag;
                       strDescri,
                       strNomFrm: String;
                       strAutInc: String = '');
  Var
    objLog: TLogCtp;
    blnCriouObj: Boolean;
    SDataExecutavel : TDateTime;
Begin
  blnCriouObj := False;

  FileAge(Application.ExeName, SDataExecutavel);

  frwk   := fCriaObjManager(blnCriouObj);
  objLog := TLogCtp.Create;
  TUtil.pClone(ADup, objLog);

  If fEmptyStr(strAutInc) Then
    objLog.strAutInc := fRetAutoIncrem('LOGCTP', objLog.strCodEmp)
  Else
    objLog.strAutInc := strAutInc;

  objLog.dtaDtaLog        := VS_Date;
  objLog.dtaHorLog        := fRetHoraServidor;
  objLog.strOpeLog        := strLoginUsuarioLogado;
  objLog.strNomTab        := TUtil.fRetTableName(ADup);
  objLog.strDescri        := strDescri;
  objLog.strNomFrm        := strNomFrm;
  objLog.objCodFor        := ADup.objCodFor;
  objLog.NomeExecutavel   := ExtractFileName(Application.ExeName);
  objLog.DataExecutavel   := SDataExecutavel;
  objLog.HoraExecutavel   := EncodeTime(HourOf(SDataExecutavel),
                                        MinuteOf(SDataExecutavel),
                                        SecondOf(SDataExecutavel),
                                        MilliSecondOf(SDataExecutavel));
  objLog.VersaoExecutavel := TVersaoExecutavel.GetVersaoProduto;

  frwk.objDBManager.Save(objLog);
  If blnCriouObj Then FreeAndNil(frwk);
End;

procedure GeraListaDeCamposLOGCTP;
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogCtp.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM LOGCTP WHERE FALSE');
    LConsulta.Open;

    FCamposLogCtp := '';
    FParametrosLogCtp := '';

    For LCampo In LConsulta.Fields Do
    Begin
        If MatchStr(LCampo.FieldName, FArrayCamposCalculados) Then
          Continue;
      FCamposLogCtp := FCamposLogCtp + LCampo.FieldName + ',';
      FParametrosLogCtp := FParametrosLogCtp + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogCtp := LeftStr(FCamposLogCtp, FCamposLogCtp.Length - 1);
    FParametrosLogCtp := LeftStr(FParametrosLogCtp, FParametrosLogCtp.Length - 1);

    LConsulta := fCriaQuery;
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM CADPAG WHERE FALSE');
    LConsulta.Open;

    FCamposCadPag := EmptyStr;

    For LCampo In LConsulta.Fields Do
    begin
      If MatchStr(LCampo.FieldName, FArrayCamposCalculados) Then
        Continue;
      FCamposCadPag := FCamposCadPag + LCampo.FieldName + ',';
    End;

    FCamposCadPag := LeftStr(FCamposCadPag, FCamposCadPag.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

procedure GravaLogCtp(AAutoIncrem,
                      ADescricao,
                      ANomeFormulario: String;
                      AAutoIncremLogCtp: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
Begin
  GeraListaDeCamposLOGCTP;

  LConsulta  := fCriaQuery;
  LGravarLog := fCriaQuery;
  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadPag + ' FROM CADPAG WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGCTP (' + FCamposLogCtp + ') ' +
                             ' VALUES (' + FParametrosLogCtp + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;
        If MatchStr(LCampo.FieldName, FArrayCamposCalculados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString := AAutoIncremLogCtp;

      If AAutoIncremLogCtp.IsEmpty Then
        LGravarLog.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGCTP', LConsulta.FieldByName('CTP_CODEMP').AsString);

      LGravarLog.ParamByName('CTP_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('CTP_HORLOG').AsTime     := fRetHoraServidor;

      LGravarLog.ParamByName('CTP_OPELOG').AsString   := strLoginUsuarioLogado;

      LGravarLog.ParamByName('CTP_NOMTAB').AsString   := 'CADPAG';
      LGravarLog.ParamByName('CTP_DESCRI').AsString   := ADescricao;
      LGravarLog.ParamByName('CTP_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('CTP_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LGravarLog.ParamByName('CTP_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      LGravarLog.ParamByName('CTP_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('CTP_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
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
