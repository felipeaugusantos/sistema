unit untTContasAReceberLinkPagamento;

interface

uses
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types,
  {$ELSE }
  untFuncoesSimples, REST.Client, untFuncoes,
  {$ENDIF LINUX}
  untTypesSistema, System.Generics.Collections, untClassesComumLinkPagamentoCitel, Variants ;

Type

  TContasAReceberLinkPagamento = class
  private
    class Var
      FCamposCadRec,
      FCamposLogCtr,
      FParametrosLogCtr: String;
    Const
      FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTR_DTALOG', 'CTR_HORLOG', 'CTR_OPELOG', 'CTR_DESCRI',
                                                'CTR_NOMFRM', 'CTR_NOMEXE', 'CTR_VEREXE', 'CTR_DTAEXE', 'CTR_HOREXE'];

    class procedure GravaLogCtr(AAutoIncrem,
                                ADescricao,
                                ANomeFormulario: String);

    class procedure GeraListaDeCamposLOGCTR;
    class function fTrataPlanoContas(const AstrPlanoContas: Variant): Variant ;
    class function fTrataPortador(const AstrPortador: Variant): Variant ;

  public
    class function fRealizaGravacaoMovimentacaoBancaria(var ADuplicatas: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
                                                        var AobjApiTransacao : TConsultaLinkPagamentoResposta;
                                                        const ABaixaAnalitica: Boolean;
                                                        var AstrMovBanBaixaSintetica: String;
                                                        var AdictSeqLan: TDictionary<String, String>;
                                                        const AdtaDtaRec: TDateTime): Boolean;
    class function fRetornaUltimoSeqBaiCADREC(ANumDup,
                                              AParcel,
                                              ACodEmp,
                                              AEspDoc,
                                              ACodCli: String): Integer;

    class function fBaixaTotalReceber(ADuplicata: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
                                     AobjApiTransacao : TConsultaLinkPagamentoResposta;
                                     const AstrMovBanBaixaSintetica: String;
                                     const AintSeqCon: Integer;
                                     const AdictSeqLan: TDictionary<String, String>;
                                     const AdtaDtaRec: TDateTime): Boolean;

  end;

implementation

uses untClassesFinanceiro, System.SysUtils, untMovBan, System.StrUtils ;

{ TContasAReceberLinkPagamento }

class function TContasAReceberLinkPagamento.fBaixaTotalReceber(
  ADuplicata: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}; AobjApiTransacao: TConsultaLinkPagamentoResposta;
   const AstrMovBanBaixaSintetica: String;
   const AintSeqCon: Integer;
   const AdictSeqLan: TDictionary<String, String>;
   const AdtaDtaRec: TDateTime): Boolean;
Var
  LAtualizar: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LHisBai, LSQL: String;
begin
  LAtualizar := fCriaQuery;
  try
    Try
      LHisBai := 'BAIXA DE DUPLICATA RECEBIDA POR LINK PGT';

      LSQL := '';
      LSQL := LSQL + 'UPDATE ';
      LSQL := LSQL + '  CADREC ';
      LSQL := LSQL + 'SET ';
      LSQL := LSQL + '  CTR_VALANT = CTR_VALORI, ';
      LSQL := LSQL + '  CTR_VALORI = :VALORI, ';
      LSQL := LSQL + '  CTR_VALDUP = 0, ';
      LSQL := LSQL + '  CTR_JURANT = CTR_JURSUJ, ';
      LSQL := LSQL + '  CTR_DESANT = CTR_DESSUJ, ';
      LSQL := LSQL + '  CTR_COBANT = CTR_DESCOB, ';
      LSQL := LSQL + '  CTR_JURSUJ = 0, ';
      LSQL := LSQL + '  CTR_DESSUJ = 0, ';
      LSQL := LSQL + '  CTR_DESCOB = 0, ';
      LSQL := LSQL + '  CTR_DTAREC = :DTAREC, ';
      LSQL := LSQL + '  CTR_VALREC = :VALREC, ';
      LSQL := LSQL + '  CTR_VALDES = :VALDES, ';
      LSQL := LSQL + '  CTR_VALJUR = :VALJUR, ';
      LSQL := LSQL + '  CTR_VALCOB = :VALCOB, ';
      LSQL := LSQL + '  CTR_PORBAI = :PORBAI, ';
      LSQL := LSQL + '  CTR_HISBAI = :HISBAI, ';
      LSQL := LSQL + '  CTR_DOCBAI = :DOCBAI, ';
      LSQL := LSQL + '  CTR_CTABAI = :CTABAI, ';
      LSQL := LSQL + '  CTR_OPEBAI = :OPEBAI, ';
      LSQL := LSQL + '  CTR_DTABAI = ' + fCurrentDate + ', ';
      LSQL := LSQL + '  CTR_EMPBAI = :EMPBAI, ';
      LSQL := LSQL + '  CTR_CHQPRE = 0.00,    ';
      LSQL := LSQL + '  CTR_CHQAVI = 0.00,    ';
      LSQL := LSQL + '  CTR_DINHEI = 0.00,    ';
      LSQL := LSQL + '  CTR_CARTAO = 0.00,    ';
      LSQL := LSQL + '  CTR_CARTAO = :CARTAO, ';
      LSQL := LSQL + '  CTR_VALFIN = 0.00,    ';
      LSQL := LSQL + '  CTR_RESCAI = 0,       ';
      LSQL := LSQL + '  CTR_RECDIN = "N",     ';
      LSQL := LSQL + '  CTR_RECCHE = "N",     ';
      LSQL := LSQL + '  CTR_RECPRE = "N",     ';
      LSQL := LSQL + '  CTR_RECCAR = "S",     ';
      LSQL := LSQL + '  CTR_RECORD = "N",     ';
      LSQL := LSQL + '  CTR_RECFIN = "N",     ';
      LSQL := LSQL + '  CTR_BAIMAN = "N",     ';

      If fCfgSis('HISBAI') = 'S' Then
      Begin
        LSQL := LSQL + '  CTR_HIST01 = CONCAT(IFNULL(CTR_HIST01, ""), ';
        LSQL := LSQL + '                      IF(IFNULL(CTR_HIST01, "") = "", "", "\n"), ';
        LSQL := LSQL + '                      :HISBAI), ';
      End;

      LSQL := LSQL + '  CTR_SEQMOD = NULL,    ';
      LSQL := LSQL + '  CTR_SEQCON = :SEQCON, ';
      LSQL := LSQL + '  CTR_RECAUT = "N",     ';

      LSQL := LSQL + '  CTR_DTABAN = :DTAREC, ';
      LSQL := LSQL + '  CTR_RECPIX = "N",     ';

      //Limpando campos do Pix
      LSQL := LSQL + '  CTR_PIXTIP=NULL,      ';
      LSQL := LSQL + '  CTR_PIXREC=NULL,      ';
      LSQL := LSQL + '  CTR_PIXJUR=NULL,      ';
      LSQL := LSQL + '  CTR_PIXDES=NULL,      ';
      LSQL := LSQL + '  CTR_PIXCOB=NULL,      ';
      LSQL := LSQL + '  CTR_PIXCOR=NULL       ';

      LSQL := LSQL + 'WHERE ';
      LSQL := LSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      LSQL := LSQL + '  CTR_PARCEL = :PARCEL AND ';
      LSQL := LSQL + '  CTR_ESPDOC = :ESPDOC AND ';
      LSQL := LSQL + '  CTR_CODEMP = :CODEMP AND ';
      LSQL := LSQL + '  CTR_CODCLI = :CODCLI AND ';
      LSQL := LSQL + '  CTR_SEQBAI = 0 ';

      LAtualizar.SQL.Text := LSQL;

      LAtualizar.ParamByName('VALREC').AsFloat := ADuplicata.FieldByName('CTR_VALDUP').AsFloat ;
      LAtualizar.ParamByName('VALORI').AsFloat := ADuplicata.FieldByName('CTR_VALDUP').AsFloat ;

      LAtualizar.ParamByName('DTAREC').AsDateTime := AdtaDtaRec;
      LAtualizar.ParamByName('VALDES').AsFloat := 0.00;
      LAtualizar.ParamByName('VALJUR').AsFloat := 0.00;
      LAtualizar.ParamByName('VALCOB').AsFloat := 0.00;
      LAtualizar.ParamByName('PORBAI').Value := fTrataPortador(ADuplicata.FieldByName('CTR_CODPOR').Value);
      LAtualizar.ParamByName('HISBAI').AsString := LHisBai;

      LAtualizar.ParamByName('DOCBAI').AsString := AstrMovBanBaixaSintetica;
      If LAtualizar.ParamByName('DOCBAI').AsString.IsEmpty Then
        if AdictSeqLan.ContainsKey(ADuplicata.FieldByName('AUTOINCREM').AsString) then
          LAtualizar.ParamByName('DOCBAI').AsString := AdictSeqLan.Items[ADuplicata.FieldByName('AUTOINCREM').AsString];

      LAtualizar.ParamByName('CTABAI').Value := fTrataPlanoContas(ADuplicata.FieldByName('CTR_CODCTA').Value);
      LAtualizar.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
      LAtualizar.ParamByName('EMPBAI').AsString := ADuplicata.FieldByName('CTR_CODEMP').AsString;
      LAtualizar.ParamByName('CARTAO').AsFloat := ADuplicata.FieldByName('CTR_VALDUP').AsFloat ;

      LAtualizar.ParamByName('SEQCON').AsInteger := AintSeqCon ;

      {*****************************************}
      {* DADOS REFERENTES AO FILTRO            *}
      {**************************************MV*}
      LAtualizar.ParamByName('NUMDUP').AsString := ADuplicata.FieldByName('CTR_NUMDUP').AsString;
      LAtualizar.ParamByName('PARCEL').AsString := ADuplicata.FieldByName('CTR_PARCEL').AsString;
      LAtualizar.ParamByName('ESPDOC').AsString := ADuplicata.FieldByName('CTR_ESPDOC').AsString;
      LAtualizar.ParamByName('CODEMP').AsString := ADuplicata.FieldByName('CTR_CODEMP').AsString;
      LAtualizar.ParamByName('CODCLI').AsString := ADuplicata.FieldByName('CTR_CODCLI').AsString;
      LAtualizar.ExecSQL;

      GravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                  'BAIXA TOTAL',
                  'TContasAReceberLinkPagamento.fBaixaTotalReceber');

      Result := True;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  finally
    {$IFNDEF LINUX} FreeAndNil(LAtualizar); {$ENDIF LINUX}
  end;
end;

class function TContasAReceberLinkPagamento.fRealizaGravacaoMovimentacaoBancaria(
  var ADuplicatas: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  var AobjApiTransacao: TConsultaLinkPagamentoResposta;
  const ABaixaAnalitica: Boolean;
  var AstrMovBanBaixaSintetica: String;
  var AdictSeqLan: TDictionary<String, String>;
  const AdtaDtaRec: TDateTime): Boolean;
Var
  LSeqLan,
  LTipoLancamento: String;

  LSeqBai: Integer;

  LListaBanCtr: TObjectList<TBanCtr>;
  LobjBanCtr: TBanCtr ;

  LDataLancamento: TDateTime;
begin
  AstrMovBanBaixaSintetica := '' ;
  LListaBanCtr := TObjectList<TBanCtr>.Create;
  try
    Try

      LDataLancamento := AdtaDtaRec ;

      {*******************}
      {* BAIXA SINTÉTICA *}
      {*******************}
      If Not ABaixaAnalitica Then
      Begin
        ADuplicatas.First;
        While Not ADuplicatas.Eof Do
        Begin

          LobjBanCtr := TBanCtr.Create ;
          LobjBanCtr.strNumDup := ADuplicatas.FieldByName('CTR_NUMDUP').AsString;
          LobjBanCtr.strParcel := ADuplicatas.FieldByName('CTR_PARCEL').AsString;
          LobjBanCtr.strEspDoc := ADuplicatas.FieldByName('CTR_ESPDOC').AsString;
          LobjBanCtr.strCodEmp := ADuplicatas.FieldByName('CTR_CODEMP').AsString;
          LobjBanCtr.strCodCli := ADuplicatas.FieldByName('CTR_CODCLI').AsString;
          LobjBanCtr.intSeqBai := ADuplicatas.FieldByName('CTR_SEQBAI').AsInteger;
          LobjBanCtr.strHist01 := ADuplicatas.FieldByName('CTR_HIST01').AsString;
          LobjBanCtr.strHist02 := ADuplicatas.FieldByName('CTR_HIST02').AsString;
          LobjBanCtr.fltValRec := ADuplicatas.FieldByName('CTR_VALDUP').AsFloat;
          LobjBanCtr.fltValJur := 0.00;
          LobjBanCtr.fltValDes := 0.00;
          LobjBanCtr.fltValPri := ADuplicatas.FieldByName('CTR_VALDUP').AsFloat;
          LListaBanCtr.Add(LobjBanCtr);

          ADuplicatas.Next;
        End;

        ADuplicatas.First;

        LSeqLan := fGravaMovBan(VarToStr(fTrataPlanoContas(ADuplicatas.FieldByName('CTR_CODCTA').Value)),
                                VarToStr(fTrataPortador(ADuplicatas.FieldByName('CTR_CODPOR').Value)),
                                strLoginUsuarioLogado,
                                LDataLancamento,
                                fRetHoraServidor,
                                '',
                                'C',
                                ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                                StrToFloat(aobjApiTransacao.Amount) / 100,
                                'BAIXA DE DUPLICATA RECEBIDA POR LINK PGT',
                                '',
                                '',
                                '',
                                '',
                                0,
                                '',
                                '',
                                '',
                                '',
                                '',
                                LListaBanCtr
                                );

        AstrMovBanBaixaSintetica := LSeqLan ;
        ADuplicatas.First ;
        Exit(True);
      End;

      {*******************}
      {* BAIXA ANALITICA *}
      {*******************}
      //ADadosPix.MovbanBaixa := '';

      LSeqBai := 0;
      If ADuplicatas.FieldByName('CTR_PIXTIP').AsString = 'P' Then
        LSeqBai := fRetornaUltimoSeqBaiCADREC(ADuplicatas.FieldByName('CTR_NUMDUP').AsString,
                                              ADuplicatas.FieldByName('CTR_PARCEL').AsString,
                                              ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                                              ADuplicatas.FieldByName('CTR_ESPDOC').AsString,
                                              ADuplicatas.FieldByName('CTR_CODCLI').AsString) + 1;

      LobjBanCtr := TBanCtr.Create ;
      LobjBanCtr.strNumDup := ADuplicatas.FieldByName('CTR_NUMDUP').AsString;
      LobjBanCtr.strParcel := ADuplicatas.FieldByName('CTR_PARCEL').AsString;
      LobjBanCtr.strEspDoc := ADuplicatas.FieldByName('CTR_ESPDOC').AsString;
      LobjBanCtr.strCodEmp := ADuplicatas.FieldByName('CTR_CODEMP').AsString;
      LobjBanCtr.strCodCli := ADuplicatas.FieldByName('CTR_CODCLI').AsString;
      LobjBanCtr.intSeqBai := ADuplicatas.FieldByName('CTR_SEQBAI').AsInteger;
      LobjBanCtr.strHist01 := ADuplicatas.FieldByName('CTR_HIST01').AsString;
      LobjBanCtr.strHist02 := ADuplicatas.FieldByName('CTR_HIST02').AsString;
      LobjBanCtr.fltValRec := ADuplicatas.FieldByName('CTR_VALDUP').AsFloat;
      LobjBanCtr.fltValJur := 0.00;
      LobjBanCtr.fltValDes := 0.00;
      LobjBanCtr.fltValPri := ADuplicatas.FieldByName('CTR_VALDUP').AsFloat;
      LListaBanCtr.Add(LobjBanCtr);

      LTipoLancamento := 'C';

      LSeqLan := fGravaMovBan(VarToStr(fTrataPlanoContas(ADuplicatas.FieldByName('CTR_CODCTA').Value)),
                              VarToStr(fTrataPortador(ADuplicatas.FieldByName('CTR_CODPOR').Value)),
                              strLoginUsuarioLogado,
                              LDataLancamento,
                              fRetHoraServidor,
                              ADuplicatas.FieldByName('CTR_NUMDUP').AsString + ADuplicatas.FieldByName('CTR_PARCEL').AsString,
                              LTipoLancamento,
                              ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                              ADuplicatas.FieldByName('CTR_VALDUP').AsFloat,
                              'BAIXA DE DUPLICATA RECEBIDA POR LINK PGT',
                              '',
                              ADuplicatas.FieldByName('CTR_CODCLI').AsString,
                              '',
                              ADuplicatas.FieldByName('CTR_NUMDUP').AsString,
                              LSeqBai,
                              ADuplicatas.FieldByName('CTR_PARCEL').AsString,
                              ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                              '',
                              ADuplicatas.FieldByName('CTR_CODEVE').AsString,
                              '',
                              LListaBanCtr
                              );

      AdictSeqLan.AddOrSetValue(ADuplicatas.FieldByName('AUTOINCREM').AsString, LSeqLan);

      Result := Not (LSeqLan='');

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao gravar a movimentação bancária do Link PGT.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  finally
    FreeAndNil(LListaBanCtr) ;
  end;
end;

class function TContasAReceberLinkPagamento.fRetornaUltimoSeqBaiCADREC(ANumDup,
  AParcel, ACodEmp, AEspDoc, ACodCli: String): Integer;
Var
  LConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LConsulta := fCriaQuery ;
  Try

    LConsulta.SQL.Text := 'SELECT ' +
                          '  MAX(CTR_SEQBAI) AS QTD ' +
                          'FROM ' +
                          '  CADREC ' +
                          'WHERE ' +
                          '  CTR_NUMDUP = :NUMDUP AND ' +
                          '  CTR_PARCEL = :PARCEL AND ' +
                          '  CTR_CODEMP = :CODEMP AND ' +
                          '  CTR_ESPDOC = :ESPDOC AND ' +
                          '  CTR_CODCLI = :CODCLI ';

    LConsulta.ParamByName('NUMDUP').AsString := ANumDup;
    LConsulta.ParamByName('PARCEL').AsString := AParcel;
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
    LConsulta.ParamByName('ESPDOC').AsString := AEspDoc;
    LConsulta.ParamByName('CODCLI').AsString := ACodCli;
    LConsulta.Open;

    Result := LConsulta.FieldByName('QTD').AsInteger;
    LConsulta.Close;

  Finally
    // FreeAndNil(LConsulta);
  End;

end;

class function TContasAReceberLinkPagamento.fTrataPlanoContas(const AstrPlanoContas: Variant): Variant ;
var
  LstrValor: String ;
begin
  if VarIsNull(AstrPlanoContas) then
  begin
    LstrValor := '' ;
    if fConfiguracaoExiste('CTALNK', VS_strCodEmp) then
      LstrValor := fCfgSis('CTALNK') ;

    if trim(LstrValor) = '' then
      Result := Null
    else
      Result := LstrValor ;
  end
  else
    Result := AstrPlanoContas ;
end;

class function TContasAReceberLinkPagamento.fTrataPortador(const AstrPortador: Variant): Variant ;
var
  LstrValor: String ;
begin
  if VarIsNull(AstrPortador) then
  begin
    LstrValor := '' ;
    if fConfiguracaoExiste('PORLNK', VS_strCodEmp) then
      LstrValor := fCfgSis('PORLNK') ;

    if trim(LstrValor) = '' then
      Result := Null
    else
      Result := LstrValor ;
  end
  else
    Result := AstrPortador ;
end;

class procedure TContasAReceberLinkPagamento.GeraListaDeCamposLOGCTR;
Var
  LConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LCampo: IField;
  LintCnt: Integer ;
Begin

  If Not FCamposLogCtr.IsEmpty Then
    Exit;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Clear ;
    LConsulta.SQL.Add('SELECT * FROM LOGCTR WHERE FALSE') ;
    LConsulta.Open;

    FCamposLogCtr := '';
    FParametrosLogCtr := '';

    for LintCnt := 0 to LConsulta.FieldCount-1 do
    Begin
      LCampo := LConsulta.Fields(LintCnt) ;
      FCamposLogCtr := FCamposLogCtr + LCampo.FieldName + ',';
      FParametrosLogCtr := FParametrosLogCtr + ':' + LCampo.FieldName + ',';
    End;

    FCamposLogCtr := LeftStr(FCamposLogCtr, FCamposLogCtr.Length - 1);
    FParametrosLogCtr := LeftStr(FParametrosLogCtr, FParametrosLogCtr.Length - 1);

    LConsulta.Close;
    LConsulta.SQL.Clear ;
    LConsulta.SQL.Add('SELECT * FROM CADREC WHERE FALSE') ;
    LConsulta.Open;

    FCamposCadRec := '';

    //For LCampo In LConsulta.Fields Do
    for LintCnt := 0 to LConsulta.FieldCount-1 do
    begin
      LCampo := LConsulta.Fields(LintCnt) ;
      FCamposCadRec := FCamposCadRec + LCampo.FieldName + ',';
    end;

    FCamposCadRec := LeftStr(FCamposCadRec, FCamposCadRec.Length - 1);

  Finally
    {$IFNDEF LINUX} FreeAndNil(LConsulta); {$ENDIF LINUX}
  End;
end;

class procedure TContasAReceberLinkPagamento.GravaLogCtr(AAutoIncrem,
  ADescricao, ANomeFormulario: String);
Var
  LConsulta,
  LGravarLog: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};

  LCampo: IField;

  LintCnt: Integer ;
Begin
  GeraListaDeCamposLOGCTR;

  LConsulta := fCriaQuery;
  LGravarLog := fCriaQuery;
  try

    Try

      LConsulta.SQL.Text := 'SELECT ' + FCamposCadRec + ' FROM CADREC WHERE AUTOINCREM="' + AAutoIncrem + '"';
      LConsulta.Open;

      If Not LConsulta.IsEmpty Then
      Begin

        LGravarLog.SQL.Text := 'INSERT INTO LOGCTR (' + FCamposLogCtr + ') ' +
                               ' VALUES (' + FParametrosLogCtr + ') ';

        //For LCampo In LConsulta.Fields Do
        for LintCnt := 0 to LConsulta.FieldCount-1 do
        Begin
          LCampo := LConsulta.Fields(LintCnt) ;

          If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
            Continue;

          LGravarLog.ParamByName(LCampo.FieldName).Value := LCampo.Value;
        End;

        LGravarLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGCTR', LConsulta.FieldByName('CTR_CODEMP').AsString);
        LGravarLog.ParamByName('CTR_DTALOG').AsDateTime := VS_Date;
        LGravarLog.ParamByName('CTR_HORLOG').AsTime     := fRetHoraServidor;

        //LGravarLog.ParamByName('CTR_OPELOG').AsString   := RetornaOperadorDoLog(AOperadorLog);

        LGravarLog.ParamByName('CTR_DESCRI').AsString   := ADescricao;
        LGravarLog.ParamByName('CTR_NOMFRM').AsString   := ANomeFormulario;

        //FileAge(Application.ExeName, LDataExecutavel);

        LGravarLog.ParamByName('CTR_NOMEXE').AsString   := ExtractFileName(Application.ExeName);
        //LGravarLog.ParamByName('CTR_VEREXE').AsString   := TVersaoExecutavel.GetVersaoProduto;
        //LGravarLog.ParamByName('CTR_DTAEXE').AsDateTime := LDataExecutavel;
        //LGravarLog.ParamByName('CTR_HOREXE').AsTime     := EncodeTime(HourOf(LDataExecutavel),
        //                                                   MinuteOf(LDataExecutavel),
        //                                                   SecondOf(LDataExecutavel),
        //                                                   MilliSecondOf(LDataExecutavel));

        //LGravarLog.ParamByName('CTR_BCOENV').Value := RetornaBancoEnvio(LConsulta.FieldByName('CTR_BCOENV').AsString);
        //LGravarLog.ParamByName('CTR_HISCOM').AsString   := AHisCom;

        LGravarLog.ExecSQL;
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;

  finally
    {$IFNDEF LINUX} FreeAndNil(LConsulta); {$ENDIF LINUX}
    {$IFNDEF LINUX} FreeAndNil(LGravarLog);{$ENDIF LINUX}
  end;
end;

end.
