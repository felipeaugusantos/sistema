unit untTLogMpx;

interface

uses System.SysUtils, Uni, DB, StrUtils, Variants, untTiposPix;

Var
  FCamposMovPix,
  FCamposLogMpx,
  FParametrosLogMpx: String;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'MPX_DTALOG', 'MPX_HORLOG', 'MPX_OPELOG', 'MPX_DESCRI',
                                            'MPX_NOMFRM', 'MPX_NOMEXE', 'MPX_VEREXE', 'MPX_DTAEXE', 'MPX_HOREXE'];

Type
  TLogMpx = class
  private
    class procedure GeraListaDeCamposLOGMPX;
    class function RetornaOperadorDoLog(AOperadorLog: String): String;

  public
    class procedure GravaLogMpx(AAutoIncrem,
                                ADescricao,
                                ANomeFormulario: String;
                                AOperadorLog: String = '');

    class procedure GravaLogMpxTxId(ATxId,
                                    ACodigoEmpresa,
                                    ADescricao,
                                    ANomeFormulario: String;
                                    AOperadorLog: String = '');

    class procedure GravaLogMpxObjeto(ADadosPix: TDadosRetornoPixConsulta;
                                      ADescricao,
                                      ANomeFormulario: String;
                                      AOperadorLog: String = '';
                                      ARescai: Integer = 0);
  end;

implementation

uses untFuncoesSimples, Forms, System.DateUtils,
     untVersaoProg;

class function TLogMpx.RetornaOperadorDoLog(AOperadorLog: String): String;
Begin
  Result := strLoginUsuarioLogado;

  If Not AOperadorLog.IsEmpty Then
    Result := AOperadorLog;
End;

class procedure TLogMpx.GeraListaDeCamposLOGMPX;
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposLogMpx.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriarQuery('SELECT * FROM LOGMPX WHERE FALSE');
    LConsulta.Open;

    FCamposLogMpx := '';
    FParametrosLogMpx := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposLogMpx := FCamposLogMpx + LCampo.FieldName + ',';
      FParametrosLogMpx := FParametrosLogMpx + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogMpx := LeftStr(FCamposLogMpx, FCamposLogMpx.Length - 1);
    FParametrosLogMpx := LeftStr(FParametrosLogMpx, FParametrosLogMpx.Length - 1);

    LConsulta.Close;
    LConsulta := fCriarQuery('SELECT * FROM MOVPIX WHERE FALSE');
    LConsulta.Open;

    FCamposMovPix := '';

    For LCampo In LConsulta.Fields Do
      FCamposMovPix := FCamposMovPix + LCampo.FieldName + ',';

    FCamposMovPix := LeftStr(FCamposMovPix, FCamposMovPix.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

class procedure TLogMpx.GravaLogMpx(AAutoIncrem,
                                    ADescricao,
                                    ANomeFormulario: String;
                                    AOperadorLog: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
Begin
  GeraListaDeCamposLOGMPX;

  LConsulta := fCriaQuery;
  LGravarLog := fCriaQuery;
  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposMovPix + ' FROM MOVPIX WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      LGravarLog.SQL.Text := 'INSERT INTO LOGMPX (' + FCamposLogMpx + ') ' +
                             ' VALUES (' + FParametrosLogMpx + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGMPX', VS_strCodEmp);
      LGravarLog.ParamByName('MPX_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('MPX_HORLOG').AsTime     := fRetHoraServidor;

      LGravarLog.ParamByName('MPX_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

      LGravarLog.ParamByName('MPX_DESCRI').AsString   := ADescricao;
      LGravarLog.ParamByName('MPX_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('MPX_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LGravarLog.ParamByName('MPX_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      LGravarLog.ParamByName('MPX_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('MPX_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
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

class procedure TLogMpx.GravaLogMpxObjeto(ADadosPix: TDadosRetornoPixConsulta;
  ADescricao, ANomeFormulario: String; AOperadorLog: String = '';
  ARescai: Integer = 0);
  Var
    LGravarLog: TUniQuery;

    LDataExecutavel : TDateTime;
Begin
  GeraListaDeCamposLOGMPX;

  LGravarLog := fCriaQuery;
  Try

    LGravarLog.SQL.Text := 'INSERT INTO LOGMPX (' + FCamposLogMpx + ') ' +
                           ' VALUES (' + FParametrosLogMpx + ') ';

    LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGMPX', VS_strCodEmp);
    LGravarLog.ParamByName('MPX_DTACAD').AsDateTime := ADadosPix.DataCriacao;
    LGravarLog.ParamByName('MPX_HORCAD').AsDateTime := ADadosPix.DataCriacao;
    LGravarLog.ParamByName('MPX_DTAHOR').AsDateTime := LGravarLog.ParamByName('MPX_DTACAD').AsDateTime +
                                                       LGravarLog.ParamByName('MPX_HORCAD').AsDateTime;
    LGravarLog.ParamByName('MPX_EXPIRA').AsString := ADadosPix.Expiracao;
    LGravarLog.ParamByName('MPX_CODEMP').AsString := VS_strCodEmp;
    LGravarLog.ParamByName('MPX_EMPFIS').AsString := fRetEmpresaFisica;
    LGravarLog.ParamByName('MPX_STATUS').AsString := ADadosPix.Status;
    LGravarLog.ParamByName('MPX_TX_ID_').AsString := ADadosPix.TxId;
    LGravarLog.ParamByName('MPX_LOCALI').AsString := ADadosPix.LinkQrCode;
    LGravarLog.ParamByName('MPX_QRCODE').AsString := ADadosPix.TextoQrCode;
    LGravarLog.ParamByName('MPX_REVISA').AsString := ADadosPix.Revisao;
    LGravarLog.ParamByName('MPX_VALPIX').AsFloat := fFormataFloat(ADadosPix.Valor, 2);
    LGravarLog.ParamByName('MPX_CHAPIX').AsString := ADadosPix.ChavePix;
    LGravarLog.ParamByName('MPX_SEQPIX').AsString := ADadosPix.AutoIncremChavePix;
    LGravarLog.ParamByName('MPX_JSOREC').AsString := ADadosPix.JsonRetorno;
    LGravarLog.ParamByName('MPX_JSOENV').AsString := ADadosPix.JsonRequisicao;
    LGravarLog.ParamByName('MPX_CODOPE').AsString := strLoginUsuarioLogado;

    If Not ADadosPix.SolicitacaoPagador.IsEmpty Then
      LGravarLog.ParamByName('MPX_SOLPAG').AsString := ADadosPix.SolicitacaoPagador;

    If Not ADadosPix.NomeDevedor.IsEmpty Then
    Begin
      LGravarLog.ParamByName('MPX_NOMDEV').AsString := ADadosPix.NomeDevedor;
      LGravarLog.ParamByName('MPX_DOCDEV').AsString := ADadosPix.CPFCNPJDevedor;
    End;

    If Not ADadosPix.InformacoesAdicionais.IsEmpty Then
      LGravarLog.ParamByName('MPX_INFADC').AsString := ADadosPix.InformacoesAdicionais;

    LGravarLog.ParamByName('MPX_RESCAI').AsInteger := ARescai;

    LGravarLog.ParamByName('MPX_SEQCON').AsInteger := ADadosPix.SeqConRecebimento;
    LGravarLog.ParamByName('MPX_DTAREC').AsDateTime := ADadosPix.DataPagamento;
    LGravarLog.ParamByName('MPX_HORREC').AsDateTime := ADadosPix.DataPagamento;
    LGravarLog.ParamByName('MPX_DTABAI').AsDateTime := fRetDataServidor;
    LGravarLog.ParamByName('MPX_VALREC').AsFloat := ADadosPix.ValorPago;
    LGravarLog.ParamByName('MPX_PORBAI').AsString := ADadosPix.CodigoPortador;
    LGravarLog.ParamByName('MPX_CTABAI').AsString := ADadosPix.PlanoDeContas;

    LGravarLog.ParamByName('MPX_END_ID').AsString := ADadosPix.EndToEndId;
    LGravarLog.ParamByName('MPX_INFPAG').AsString := ADadosPix.InformacaoPagador;
    LGravarLog.ParamByName('MPX_NOMPAG').AsString := ADadosPix.NomePagador;
    LGravarLog.ParamByName('MPX_DOCPAG').AsString := ADadosPix.CPFCNPJPagador;
    LGravarLog.ParamByName('MPX_ARRPAG').AsString := ADadosPix.JsonChavePix;
    LGravarLog.ParamByName('MPX_F11ORI').AsString := ADadosPix.RecebidoPeloF11;
    LGravarLog.ParamByName('MPX_CRIADO').AsString := ADadosPix.CriadoPelo;

    LGravarLog.ParamByName('MPX_OPEBAI').AsString := strLoginUsuarioLogado;
    If Not AOperadorLog.IsEmpty Then
      LGravarLog.ParamByName('MPX_OPEBAI').AsString := AOperadorLog;

    {If Assigned(ADadosPix.DadosDevolucao) Then
    Begin
      LGravarLog.ParamByName('MPX_DEV_ID').AsString := ADadosPix.DadosDevolucao.Id;
      LGravarLog.ParamByName('MPX_RTR_ID').AsString :=ADadosPix.DadosDevolucao.rtrId;
      LGravarLog.ParamByName('MPX_STATUS').AsString := ADadosPix.DadosDevolucao.Status;
      LGravarLog.ParamByName('MPX_MOTDEV').AsString := ADadosPix.DadosDevolucao.Motivo;
      LGravarLog.ParamByName('MPX_JSODEV').AsString := ADadosPix.DadosDevolucao.JsonRetorno;
      LGravarLog.ParamByName('MPX_VALDEV').AsFloat := ADadosPix.DadosDevolucao.Valor;
      LGravarLog.ParamByName('MPX_DTADEV').AsDate := ADadosPix.DadosDevolucao.DataDevolucao;
      LGravarLog.ParamByName('MPX_HORDEV').AsTime := ADadosPix.DadosDevolucao.DataDevolucao;
    End;}

    LGravarLog.ParamByName('MPX_DTALOG').AsDateTime := VS_Date;
    LGravarLog.ParamByName('MPX_HORLOG').AsTime     := fRetHoraServidor;

    LGravarLog.ParamByName('MPX_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

    LGravarLog.ParamByName('MPX_DESCRI').AsString   := ADescricao;
    LGravarLog.ParamByName('MPX_NOMFRM').AsString   := ANomeFormulario;

    FileAge(Application.ExeName, LDataExecutavel);

    LGravarLog.ParamByName('MPX_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
    LGravarLog.ParamByName('MPX_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
    LGravarLog.ParamByName('MPX_DTAEXE').AsDateTime := LDataExecutavel;
    LGravarLog.ParamByName('MPX_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
                                                       MinuteOf(LDataExecutavel),
                                                       SecondOf(LDataExecutavel),
                                                       MilliSecondOf(LDataExecutavel));

    LGravarLog.ExecSQL;

    FreeAndNil(LGravarLog);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

class procedure TLogMpx.GravaLogMpxTxId(ATxId,
                                        ACodigoEmpresa,
                                        ADescricao,
                                        ANomeFormulario: String;
                                        AOperadorLog: String = '');
  Var
    LConsulta,
    LGravarLog: TUniQuery;

    LCampo: TField;

    LDataExecutavel : TDateTime;
Begin
  GeraListaDeCamposLOGMPX;

  LConsulta := fCriaQuery;
  LGravarLog := fCriaQuery;
  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposMovPix + ' FROM MOVPIX WHERE ' +
                          '   MPX_TX_ID_="' + ATxId + '" AND ' +
                          '   MPX_CODEMP="' + ACodigoEmpresa + '"';
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      LGravarLog.SQL.Text := 'INSERT INTO LOGMPX (' + FCamposLogMpx + ') ' +
                             ' VALUES (' + FParametrosLogMpx + ') ';

      For LCampo In LConsulta.Fields Do
      Begin
        If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
          Continue;

        LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
      End;

      LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGMPX', VS_strCodEmp);
      LGravarLog.ParamByName('MPX_DTALOG').AsDateTime := VS_Date;
      LGravarLog.ParamByName('MPX_HORLOG').AsTime     := fRetHoraServidor;

      LGravarLog.ParamByName('MPX_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

      LGravarLog.ParamByName('MPX_DESCRI').AsString   := ADescricao;
      LGravarLog.ParamByName('MPX_NOMFRM').AsString   := ANomeFormulario;

      FileAge(Application.ExeName, LDataExecutavel);

      LGravarLog.ParamByName('MPX_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
      LGravarLog.ParamByName('MPX_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
      LGravarLog.ParamByName('MPX_DTAEXE').AsDateTime := LDataExecutavel;
      LGravarLog.ParamByName('MPX_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
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
