{************************************}
{* CLASSE DE ADIANTAMENTO REFERENTE *}
{* AO MONITOR DE PAGAMENTOS DO PIX  *}
{************************************}
unit untAdiantamentoCliente;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  UniClientDataSet, untModulo,
{$ENDIF}
  System.SysUtils, untTypesSistema, untTiposPix, untTPixDao, Uni, Data.DB;

type
  TAdiantamento = class
    private
      class var FInfAdiantamento: TDadosAdiantamento;

      class var FNomeForm: String;

      class var FRegistroPix: TDadosRetornoPixConsulta;

      class function SelecionarDocumentos(AOrigem: String): Boolean;

      class function SelecionarPedido(ADocumentos: TArrDocAdiantamento): Boolean;

      class function CarregarDadosPedido(APedidos: TUniQuery;
                                         var ADocumentos: TArrDocAdiantamento;
                                         AOrigem: String): Boolean;

      class function SelecionarVariosPedidosParaAdiantamento(APedidos: TUniQuery;
                                                             var ADocumentos: TArrDocAdiantamento): Boolean;

      class function NumeroPedidoSelecionarVarios(APedido: TUniQuery): String;

      class procedure AtribuiDadosDocumento(APedido: TUniQuery;
                                            var ADocumento: TDocAdiantamento);

      class function GetTotaisAdiantamento(ANumeroDocumento,
                                           AEspecieDocumento,
                                           ACodigoEmpresa: String): TTotaisAdiantamento;

      class procedure AtualizarValorLancamentoDocumentos;

      class function GetSQLPedidos(AEmpPix, ATxIdPix: string; blnFiltrarTodasAsLojas: Boolean = False): String;

      class function RealizarAdiantamento: Boolean;

      class function PedeFormasPagamento: Boolean;

      class function ConfirmarAdiantamento: Boolean;

      class function GravarMovimentoBancario: Boolean;

      class function GravarAdiantamento: Boolean;

      class function LiberacaoPREPTE: Boolean;
    protected
      class procedure DestravarPedidos(AObjetoAdiantamento: TAdiantamento);
    public
      constructor Create(ANomeFormulario, AOperadorLancamento, APortadorTransitorio: String);

      class function RealizarAdiantamentoClientePix(ANomeFormulario: String;
                                                    var ADadosDoPix: TDadosRetornoPixConsulta;
                                                    ARcxCon: Integer): Integer;
  end;

implementation
Uses untFuncoesSimples, untAdiantamentoCLienteGenerico, untTBanCtrRepository,
     untMovBan, untTFuncoesPixMonitor, untTFuncoesAuxiliaresPix;
{ TAdiantamento }

class procedure TAdiantamento.AtribuiDadosDocumento(APedido: TUniQuery;
  var ADocumento: TDocAdiantamento);
begin
  ADocumento.strAutInc := APedido.FieldByName('AUTOINCREM').AsString;
  ADocumento.strSeqDmp := APedido.FieldByName('FGO_SEQDMP').AsString;
  ADocumento.strNumDoc := APedido.FieldByName('FGO_NUMDOC').AsString;
  ADocumento.strEspDoc := APedido.FieldByName('FGO_ESPDOC').AsString;
  ADocumento.strCodEmp := APedido.FieldByName('FGO_CODEMP').AsString;
  ADocumento.strCodCli := APedido.FieldByName('FGO_CODCLI').AsString;
  ADocumento.strCodVen := APedido.FieldByName('FGO_CODVEN').AsString;
  ADocumento.dtaDtaEnt := APedido.FieldByName('FGO_DTAENT').AsDateTime;
  ADocumento.horHorEnt := APedido.FieldByName('FGO_HORENT').AsDateTime;

  ADocumento.fltVlrCon := APedido.FieldByName('FGO_VLRCON').AsFloat -
                          APedido.FieldByName('FGO_TOTBRI').AsFloat -
                          APedido.FieldByName('FGO_BOLADT').AsFloat;

  ADocumento.fltBolAdt := APedido.FieldByName('FGO_BOLADT').AsFloat;

  ADocumento.fltTotIpi := APedido.FieldByName('FGO_TOTIPI').AsFloat;
  ADocumento.fltTotRet := APedido.FieldByName('FGO_TOTRET').AsFloat;
  ADocumento.fltDesAce := APedido.FieldByName('FGO_DESACE').AsFloat;
  ADocumento.fltTotFre := APedido.FieldByName('FGO_TOTFRE').AsFloat;

  ADocumento.fltValAdt := GetTotaisAdiantamento(ADocumento.strNumDoc,
                                                ADocumento.strEspDoc,
                                                ADocumento.strCodEmp).fltValLan;

  ADocumento.fltValLan := ADocumento.fltVlrCon - ADocumento.fltValAdt;

  ADocumento.blnEnt_CD := APedido.FieldByName('FGO_ENT_CD').AsString = 'S';

  ADocumento.strCodCnd := APedido.FieldByName('FGO_CODCND').AsString;
  ADocumento.strCodFpg := APedido.FieldByName('FGO_CODFPG').AsString;
  ADocumento.strFpgOri := APedido.FieldByName('FGO_FPGORI').AsString;
  ADocumento.strConPag := APedido.FieldByName('FGO_CONPAG').AsString;
  ADocumento.blnLibCom := APedido.FieldByName('FGO_LIBCOM').AsInteger = 1;
  ADocumento.blnLibera := APedido.FieldByName('FGO_LIBERA').AsInteger > 0;
  ADocumento.strCodCar := APedido.FieldByName('FGO_CODCAR').AsString;
  ADocumento.intQtdPaC := APedido.FieldByName('FGO_QTDPAC').AsInteger;

  If fClienteConsumidor(APedido.FieldByName('CLI_NOMCLI').AsString) Then
  Begin
    ADocumento.strNomCli := APedido.FieldByName('FGO_NOMCON').AsString;
    ADocumento.strEndere := APedido.FieldByName('FGO_ENDCON').AsString;
    ADocumento.strBairro := APedido.FieldByName('FGO_BAICON').AsString;
    ADocumento.strEndCom := '';
    ADocumento.strEndNum := '';
    ADocumento.strC_E_P_ := APedido.FieldByName('FGO_CEPCON').AsString;
    ADocumento.strCodCid := APedido.FieldByName('FGO_CIDCON').AsString;
    ADocumento.strFone01 := APedido.FieldByName('FGO_TELCON').AsString;
    ADocumento.strCgcCpf := APedido.FieldByName('FGO_CGCCPF').AsString;
    ADocumento.strC_G_C_ := APedido.FieldByName('FGO_CGCCON').AsString;
    ADocumento.strEmail_ := APedido.FieldByName('FGO_EMLCON').AsString;
    ADocumento.strNum_Rg := APedido.FieldByName('FGO_R_GCON').AsString;
    ADocumento.strNumIes := APedido.FieldByName('FGO_IESCON').AsString;
    ADocumento.strCodAti := APedido.FieldByName('FGO_CODATI').AsString;
    ADocumento.dtaNascon := APedido.FieldByName('FGO_NASCON').AsDateTime;
  End
  Else
  Begin
    ADocumento.strNomCli := APedido.FieldByName('CLI_NOMCLI').AsString;
    ADocumento.strEndere := APedido.FieldByName('CLI_ENDERE').AsString;
    ADocumento.strBairro := APedido.FieldByName('CLI_BAIRRO').AsString;
    ADocumento.strEndCom := APedido.FieldByName('CLI_ENDCOM').AsString;
    ADocumento.strEndNum := APedido.FieldByName('CLI_ENDNUM').AsString;
    ADocumento.strC_E_P_ := APedido.FieldByName('CLI_C_E_P_').AsString;
    ADocumento.strCodCid := APedido.FieldByName('CLI_CODCID').AsString;
    ADocumento.strFone01 := APedido.FieldByName('CLI_FONE01').AsString;
    ADocumento.strCgcCpf := APedido.FieldByName('CLI_CGCCPF').AsString;
    ADocumento.strC_G_C_ := APedido.FieldByName('CLI_C_G_C_').AsString;
    ADocumento.strEmail_ := APedido.FieldByName('CLI_EMAIL_').AsString;
    ADocumento.strNum_Rg := APedido.FieldByName('CLI_NUMR_G').AsString;
    ADocumento.strNumIes := APedido.FieldByName('CLI_I_E_S_').AsString;
    ADocumento.strCodAti := '';
    ADocumento.dtaNascon := 0;
  End;

  ADocumento.strNomCid := fRetNomCidade(ADocumento.strCodCid);
  ADocumento.strEstado := fRetNomCidade(ADocumento.strCodCid, 1);
end;

class function TAdiantamento.CarregarDadosPedido(APedidos: TUniQuery;
  var ADocumentos: TArrDocAdiantamento; AOrigem: String): Boolean;
begin
  Result := False;

  If APedidos.IsEmpty Then
    Exit;

  If (AOrigem = 'CTR') And
     (Not fClienteConsumidor(APedidos.FieldByName('CLI_NOMCLI').AsString)) Then
  Begin
    Try
      APedidos.Filtered := False;
      APedidos.Filter   := 'FGO_CODCLI = ' + APedidos.FieldByName('FGO_CODCLI').AsString.QuotedString + ' AND ' +
                             'FGO_VLRCON > VLRADT ';

      APedidos.Filtered := True;

      Result := SelecionarVariosPedidosParaAdiantamento(APedidos,
                                                        ADocumentos);
      If Not Result Then
        Exit;
    Finally
      APedidos.Filtered := False;
      APedidos.Filter   := '';
    End;
  End
  Else
    Result := SelecionarVariosPedidosParaAdiantamento(APedidos,
                                                      ADocumentos);
end;

class function TAdiantamento.ConfirmarAdiantamento: Boolean;
begin
  Try
    Result := GravarMovimentoBancario;

    If Result Then
      Result := GravarAdiantamento;

    If Result Then
      Result := LiberacaoPREPTE;

    If Not Result Then
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      TFuncoesPixMonitor.GravarLogErr_Pix('[TAdiantamento.ConfirmarAdiantamento] - ' + E.message, e.StackTrace);
      Exit;
    End;
  End;
end;

constructor TAdiantamento.Create(ANomeFormulario, AOperadorLancamento, APortadorTransitorio: String);
begin
  FillChar(FInfAdiantamento, SizeOf(FInfAdiantamento), #0);

  FNomeForm := ANomeFormulario;

  FInfAdiantamento.strOpeLan := AOperadorLancamento;
  FInfAdiantamento.strPorTra := APortadorTransitorio;
  FInfAdiantamento.strEmpLan := VS_strCodEmp;
end;

class procedure TAdiantamento.DestravarPedidos(
  AObjetoAdiantamento: TAdiantamento);
  Var
    LContador: Integer;
begin
  For LContador := 0 To Length(AObjetoAdiantamento.FInfAdiantamento.documentos) - 1 Do
    fLock_Unlock('FATGOR' + AObjetoAdiantamento.FInfAdiantamento.documentos[LContador].strNumDoc +
                            AObjetoAdiantamento.FInfAdiantamento.documentos[LContador].strEspDoc +
                            AObjetoAdiantamento.FInfAdiantamento.documentos[LContador].strCodEmp, False, False);
end;

class function TAdiantamento.GravarAdiantamento: Boolean;
  Var
    LClonePix: TDadosRetornoPixConsulta;
begin
  TFuncoesPix.CloneObjetoConsultaPix(FRegistroPix,
                                     LClonePix);

  TPixDao.CorrigeParaDataZulu(LClonePix);

  FInfAdiantamento.dtaDtaLan := TDate(LClonePix.DataPagamento);
  FInfAdiantamento.horHorLan := TTime(LClonePix.DataPagamento);
  FInfAdiantamento.strEmpLan := FRegistroPix.CodigoEmpresa;

  Result := TAdiantamentoGenerico.fGravaAdiantamentoCliente(FInfAdiantamento);
end;

class function TAdiantamento.GravarMovimentoBancario: Boolean;
  Var
    strSeqLanCre : String;
    fltValLan    : Double;
    lstBanCtr    : TBanCtrRepository;
    dtaDtaLan: TDate;
    horHorLan: TTime;
    strHist01: string;
    strHist02: string;
    strDocume: string;
    LClonePix: TDadosRetornoPixConsulta;

    arrModDoc: TArrTotaisAdiantamento;

  procedure popLstBanCtr;
  var
    LContador: Integer;
  begin
    fltValLan := 0;

    lstBanCtr.pClear;
    For LContador := 0 To Length(FInfAdiantamento.documentos) - 1 Do
    Begin
      fltValLan := fltValLan +
                   arrModDoc[LContador].fltValLan;

      lstBanCtr.fAdd(FInfAdiantamento.documentos[LContador].strNumDoc,
                     'A',
                     FInfAdiantamento.documentos[LContador].strEspdoc,
                     FInfAdiantamento.documentos[LContador].strCodEmp,
                     FInfAdiantamento.documentos[LContador].strCodCli,
                     FInfAdiantamento.strDescri,
                     '',
                     FInfAdiantamento.intSeqCon,
                     FInfAdiantamento.documentos[LContador].fltValLan);
    End;
  end;
begin
  TFuncoesPix.CloneObjetoConsultaPix(FRegistroPix,
                                     LClonePix);

  TPixDao.CorrigeParaDataZulu(LClonePix);

  FInfAdiantamento.dtaDtaLan := TDate(LClonePix.DataPagamento);
  FInfAdiantamento.horHorLan := TTime(LClonePix.DataPagamento);

  fltValLan := FInfAdiantamento.fltValLan;

  arrModDoc := TAdiantamentoGenerico.fCalcularValorModalidadesDocumentos(FInfAdiantamento);

  lstBanCtr := TBanCtrRepository.Create;

  dtaDtaLan := FInfAdiantamento.dtaDtaLan;
  If fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [FInfAdiantamento.strCodPor]) = 'S' Then
    dtaDtaLan := fAcertaDataParaDiaUtil(FInfAdiantamento.dtaDtaLan);

  horHorLan := FInfAdiantamento.horHorLan;

  strDocume := FInfAdiantamento.documentos[0].strNumDoc + '-' +
               FInfAdiantamento.documentos[0].strEspDoc + '-' +
               FInfAdiantamento.documentos[0].strCodEmp;

  strHist01 := 'Recebimento PIX ' + strDocume;
  strHist02 := FInfAdiantamento.documentos[0].strCodCli + '-' + fRetNomCliente(FInfAdiantamento.documentos[0].strCodCli);

  //Portador Transitorio (registrar credito e debito)
  if not fEmptyStr(FInfAdiantamento.strPorTra) then
  begin
    popLstBanCtr;

    fGravaMovBan(FInfAdiantamento.strCodCta,           // Centro de Custo
                 FInfAdiantamento.strPorTra,           // Portador
                 FInfAdiantamento.strOpeLan,           // Operador
                 dtaDtaLan,                            // Data do Lançamento
                 horHorLan,                            // Hora do Lançamento
                 FInfAdiantamento.documentos[0].strNumDoc, // Documento
                 'C',                                  // Credito / Debito
                 FRegistroPix.CodigoEmpresa,           // Empresa
                 fltValLan,                            // Valor Documento
                 strHist01,                            // Historico 1
                 strHist02,                            // Historico 2
                 FInfAdiantamento.documentos[0].strCodCli, // Cliente
                 '',                                   // Fornecedor
                 '',                                   // Numero da Duplicata
                 FInfAdiantamento.intSeqCon,           // Sequencial Duplicata
                 '',                                   // Parcela da Duplicata
                 '',                                   // Empresa da Duplicata
                 '',                                   // Série
                 '',                                   // Código do Evento
                 '',                                   // Documento da Baixa
                 lstBanCtr.fGetList);                  // Log Bancário

    strHist01 := 'Transf PIX para portador ' + FInfAdiantamento.strCodPor;
    strHist02 := strDocume + ' ' + FInfAdiantamento.documentos[0].strCodCli + '-' + fRetNomCliente(FInfAdiantamento.documentos[0].strCodCli);

    popLstBanCtr;

    fGravaMovBan(FInfAdiantamento.strCodCta,           // Centro de Custo
                 FInfAdiantamento.strPorTra,           // Portador
                 FInfAdiantamento.strOpeLan,           // Operador
                 dtaDtaLan,                            // Data do Lançamento
                 horHorLan,                            // Hora do Lançamento
                 FInfAdiantamento.documentos[0].strNumDoc, // Documento
                 'D',                                  // Credito / Debito
                 FRegistroPix.CodigoEmpresa,           // Empresa
                 fltValLan,                            // Valor Documento
                 strHist01,                            // Historico 1
                 strHist02,                            // Historico 2
                 FInfAdiantamento.documentos[0].strCodCli, // Cliente
                 '',                                   // Fornecedor
                 '',                                   // Numero da Duplicata
                 FInfAdiantamento.intSeqCon,           // Sequencial Duplicata
                 '',                                   // Parcela da Duplicata
                 '',                                   // Empresa da Duplicata
                 '',                                   // Série
                 '',                                   // Código do Evento
                 '',                                   // Documento da Baixa
                 lstBanCtr.fGetList);                  // Log Bancário

    strHist01 := 'Transf PIX do portador ' + FInfAdiantamento.strPorTra;
    strHist02 := strDocume + ' ' + FInfAdiantamento.documentos[0].strCodCli + '-' + fRetNomCliente(FInfAdiantamento.documentos[0].strCodCli);
  end;

  popLstBanCtr;

  strSeqLanCre := fGravaMovBan(FInfAdiantamento.strCodCta,           // Centro de Custo
                               FInfAdiantamento.strCodPor,           // Portador
                               FInfAdiantamento.strOpeLan,           // Operador
                               dtaDtaLan,                            // Data do Lançamento
                               horHorLan,                            // Hora do Lançamento
                               FInfAdiantamento.documentos[0].strNumDoc, // Documento
                               'C',                                  // Credito / Debito
                               FRegistroPix.CodigoEmpresa,           // Empresa
                               fltValLan,                            // Valor Documento
                               strHist01,                            // Historico 1
                               strHist02,                            // Historico 2
                               FInfAdiantamento.documentos[0].strCodCli, // Cliente
                               '',                                   // Fornecedor
                               '',                                   // Numero da Duplicata
                               FInfAdiantamento.intSeqCon,           // Sequencial Duplicata
                               '',                                   // Parcela da Duplicata
                               '',                                   // Empresa da Duplicata
                               '',                                   // Série
                               '',                                   // Código do Evento
                               '',                                   // Documento da Baixa
                               lstBanCtr.fGetList);                  // Log Bancário

  Result := Not strSeqLanCre.IsEmpty;

  FreeAndNil(lstBanCtr);

  FRegistroPix.MovbanBaixa := strSeqLanCre;
end;

class function TAdiantamento.LiberacaoPREPTE: Boolean;
  Var
    LDocumento: TDocAdiantamento;

    LConsulta: TUniQuery;

  Const
    SQL_UPDATE: String = ' UPDATE PREPTE SET          ' +
                         '   PRE_LIBERA = "S"         ' +
                         ' WHERE                      ' +
                         '   PRE_DOCABS = :DOCABS AND ' +
                         '   PRE_ESPABS = :ESPABS AND ' +
                         '   PRE_EMPABS = :EMPABS     ';
begin
  Result := True;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SHOW TABLES LIKE "PREPTE"';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    If fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_LIBETE', VS_strCodEmp]) <> '1' Then
      Exit;

    LConsulta.Close;
    LConsulta.SQL.Text := SQL_UPDATE;

    For LDocumento In FInfAdiantamento.documentos Do
    Begin
      If Not fExisteRegistroPREPTEDocumento(LDocumento.strNumDoc,
                                            LDocumento.strEspDoc,
                                            LDocumento.strCodEmp) Then
        Continue;

      LConsulta.Close;
      LConsulta.ParamByName('DOCABS').AsString := LDocumento.strNumDoc;
      LConsulta.ParamByName('ESPABS').AsString := LDocumento.strEspDoc;
      LConsulta.ParamByName('EMPABS').AsString := LDocumento.strCodEmp;
      LConsulta.ExecSQL;
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

class function TAdiantamento.SelecionarVariosPedidosParaAdiantamento(APedidos: TUniQuery;
                                                                     var ADocumentos: TArrDocAdiantamento): Boolean;
  Var
    LPedidos: TStringArray;

    LSelecionados: String;
begin
  LSelecionados := '';

  APedidos.First;

  While Not APedidos.Eof Do
  Begin
    LSelecionados := LSelecionados + '"' +
                     NumeroPedidoSelecionarVarios(APedidos) + '", ';

    untFuncoesSimples.pAddDados(LPedidos, NumeroPedidoSelecionarVarios(APedidos));
    APedidos.Next;
  End;

  If fEmptyStr(LSelecionados) Then
    Exit(False);

  SetLength(ADocumentos, 0);

  APedidos.First;

  While Not APedidos.Eof Do
  Begin
    If Pos(NumeroPedidoSelecionarVarios(APedidos), LSelecionados) > 0 Then
    Begin
      SetLength(ADocumentos, Length(ADocumentos) + 1);
      AtribuiDadosDocumento(APedidos, ADocumentos[Length(ADocumentos)-1]);
    End;
    APedidos.Next;
  End;

  APedidos.First;

  Result := True;
end;

class function TAdiantamento.GetSQLPedidos(AEmpPix, ATxIdPix: string; blnFiltrarTodasAsLojas: Boolean): String;
  Const
    SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO = ' IFNULL( ' +
      ' ( SELECT '+
      '     SUM( IF(ADT_TIPLAN = "D", ADT_VALLAN * -1, ADT_VALLAN) ) '+
      '   FROM                            '+
      '     ADTCLI                        '+
      '   WHERE ADT_CODCLI = FGO_CODCLI   '+
      '     AND ADT_NUMDOC = FGO_NUMDOC   '+
      '     AND ADT_ESPDOC = FGO_ESPDOC   '+
      '     AND ADT_CODEMP = FGO_CODEMP ), 0) ';
begin
  Result := '';
  Result := Result +  'SELECT SQL_NO_CACHE ';
  Result := Result +  '  FGO_DTAENT, ';
  Result := Result +  '  FGO_HORENT, ';
  Result := Result +  '  FGO_NUMDOC, ';
  Result := Result +  '  FGO_ESPDOC, ';
  Result := Result +  '  FGO_CODEMP, ';
  Result := Result +  '  FGO_CODCLI, ';
  Result := Result +  '  FGO_CODVEN, ';
  Result := Result +  '  FGO_VLRCON, ';
  Result := Result +  '  IFNULL(FGO_TOTBRI, 0) AS FGO_TOTBRI, ';
  Result := Result +  '  FGO_BOLADT, ';
  Result := Result +  '  FGO_TOTIPI, ';
  Result := Result +  '  FGO_TOTRET, ';
  Result := Result +  '  FGO_DESACE, ';
  Result := Result +  '  FGO_TOTFRE, ';
  Result := Result +  '  FGO_ENT_CD, ';
  Result := Result +  '  IF(FGO_ENT_CD = "S", FGO_EMP_CD, FGO_CODEMP) AS EMPDES, ';
  Result := Result +  '  FGO_CODCND, ';
  Result := Result +  '  FGO_CODFPG AS FGO_FPGORI, ';
  Result := Result +  '  IF(FGO_CODFPG = "016", "009", FGO_CODFPG) AS FGO_CODFPG, ';
  Result := Result +  '  FPG_DESCRI, ';
  Result := Result +  '  FGO_CONPAG, ';
  Result := Result +  '  FGO_LIBCOM, ';
  Result := Result +  '  FGO_LIBERA, ';
  Result := Result +  '  FGO_CODCAR, ';
  Result := Result +  '  FGO_QTDPAC, ';

  //Dados do cliente (cadastro)
  Result := Result +  '  CLI_CODCLI, ';
  Result := Result +  '  CLI_NOMCLI, ';
  Result := Result +  '  CLI_CGCCPF, ';
  Result := Result +  '  CLI_C_G_C_, ';
  Result := Result +  '  CLI_C_E_P_, ';
  Result := Result +  '  CLI_CODCID, ';
  Result := Result +  '  CLI_ENDERE, ';
  Result := Result +  '  CLI_ENDNUM, ';
  Result := Result +  '  CLI_BAIRRO, ';
  Result := Result +  '  CLI_ENDCOM, ';
  Result := Result +  '  CLI_FONE01, ';
  Result := Result +  '  CLI_EMAIL_, ';
  Result := Result +  '  CLI_NUMR_G, ';
  Result := Result +  '  CLI_I_E_S_, ';

  //Dados cliente consumidor
  Result := Result +  '  FGO_NOMCON, ';
  Result := Result +  '  FGO_CGCCPF, ';
  Result := Result +  '  FGO_CGCCON, ';
  Result := Result +  '  FGO_CEPCON, ';
  Result := Result +  '  FGO_CIDCON, ';
  Result := Result +  '  FGO_ENDCON, ';
  Result := Result +  '  FGO_BAICON, ';
  Result := Result +  '  FGO_TELCON, ';
  Result := Result +  '  FGO_EMLCON, ';
  Result := Result +  '  FGO_R_GCON, ';
  Result := Result +  '  FGO_IESCON, ';
  Result := Result +  '  FGO_NASCON, ';
  Result := Result +  '  FGO_CODATI, ';
  //Nome do cliente
  Result := Result + fSQLIFClienteConsumidor('CLI_NOMCLI',
                                             'CONCAT(FGO_CODCLI, " - ", FGO_NOMCON)',
                                             'CONCAT(FGO_CODCLI, " - ", CLI_NOMCLI)') +
                                             ' AS NOMCLI, ';
  //Dados do vendedor
  Result := Result +  '  CONCAT(OPE_CODOPE, " - ", OPE_NOMOPE) AS NOMVEN, ';

  //Valor do adiantamento ja realizado
  Result := Result +  SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' AS VLRADT,';

  //Situação do adiantamento (Pendente, Parcialmente, Realizado)
  Result := Result +  '   CASE ';
  Result := Result +  '     WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' = 0 THEN "Pendente" ';
  Result := Result +  '     WHEN ' + SQL_VALOR_JA_RECEBIDO_ADIANTAMENTO + ' < (FGO_VLRCON - IFNULL(FGO_TOTBRI, 0) - FGO_BOLADT) THEN "Parcialmente" ';
  Result := Result +  '     ELSE "Realizado" ';
  Result := Result +  '   END AS SITADT, ';

  Result := Result +  '  EXTGOR.FGO_SEQDMP, ';//Sequencial de desmembramento de pedido
  Result := Result +  '  FATGOR.AUTOINCREM  ';

  Result := Result +  'FROM  ';
  Result := Result +  '  FATGOR ';
  Result := Result +  '  LEFT JOIN CADCLI ON CADCLI.CLI_CODCLI = FATGOR.FGO_CODCLI ';
  Result := Result +  '  LEFT JOIN CADOPE ON CADOPE.OPE_CODOPE = FATGOR.FGO_CODVEN ';
  Result := Result +  '  LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  Result := Result +  '  LEFT JOIN CADATI ON CADATI.ATI_CODATI = EXTGOR.FGO_CODATI ';
  Result := Result +  '  LEFT JOIN CADFPG ON CADFPG.FPG_CODIGO = IF(FATGOR.FGO_CODFPG = "016", "009", FATGOR.FGO_CODFPG) ';
  Result := Result +  'WHERE ';

  Result := Result +  '  EXTGOR.FGO_EMPPIX = "' + AEmpPix + '" AND ';
  Result := Result +  '  EXTGOR.FGO_TX_PIX = "' + ATxIdPix + '"    ';

  Result := Result +  'GROUP BY FATGOR.AUTOINCREM ';

  Result := Result +  'ORDER BY  ';
  Result := Result +  '  FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP ';
end;

class function TAdiantamento.GetTotaisAdiantamento(ANumeroDocumento,
  AEspecieDocumento, ACodigoEmpresa: String): TTotaisAdiantamento;
  Var
    LCosnulta: TUniQuery;
begin
  FillChar(Result, SizeOf(Result), #0);

  If fEmptyStr(ANumeroDocumento) Then
    Exit;

  LCosnulta := fCriaQuery;

  LCosnulta.SQL.Text := 'SELECT SQL_NO_CACHE ' +
                        '  SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, -ADT_VALLAN)) AS VALLAN, ' +
                        '  SUM(IF(ADT_TIPLAN = "C", ADT_VALDIN, -ADT_VALDIN)) AS VALDIN, ' +
                        '  SUM(IF(ADT_TIPLAN = "C", ADT_VALCHV, -ADT_VALCHV)) AS VALCHV, ' +
                        '  SUM(IF(ADT_TIPLAN = "C", ADT_VALCHP, -ADT_VALCHP)) AS VALCHP, ' +
                        '  SUM(IF(ADT_TIPLAN = "C", ADT_VALCAR, -ADT_VALCAR)) AS VALCAR, ' +
                        '  SUM(IF(ADT_TIPLAN = "C", ADT_VALORD, -ADT_VALORD)) AS VALORD, ' +
                        '  SUM(IF(ADT_TIPLAN = "C", ADT_VALFIN, -ADT_VALFIN)) AS VALFIN, ' +
                        '  SUM(IF(ADT_TIPLAN = "C", ADT_VALCRE, -ADT_VALCRE)) AS VALCRE, ' +
                        '  COUNT(*) AS TOTLAN ' +
                        'FROM ' +
                        '  ADTCLI ' +
                        'WHERE ' +
                        '  ADT_NUMDOC = :NUMDOC AND ' +
                        '  ADT_ESPDOC = :ESPDOC AND ' +
                        '  ADT_CODEMP = :CODEMP     ';

  LCosnulta.ParamByName('NUMDOC').AsString := ANumeroDocumento;
  LCosnulta.ParamByName('ESPDOC').AsString := AEspecieDocumento;
  LCosnulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;

  LCosnulta.Open;

  Result.fltValLan := LCosnulta.FieldByName('VALLAN').AsFloat;
  Result.fltValDin := LCosnulta.FieldByName('VALDIN').AsFloat;
  Result.fltValChV := LCosnulta.FieldByName('VALCHV').AsFloat;
  Result.fltValChP := LCosnulta.FieldByName('VALCHP').AsFloat;
  Result.fltValCar := LCosnulta.FieldByName('VALCAR').AsFloat;
  Result.fltValOrd := LCosnulta.FieldByName('VALORD').AsFloat;
  Result.fltValFin := LCosnulta.FieldByName('VALFIN').AsFloat;
  Result.fltValCre := LCosnulta.FieldByName('VALCRE').AsFloat;
  Result.blnExiAdt := LCosnulta.FieldByName('TOTLAN').AsInteger > 0;

  FreeAndNil(LCosnulta);
end;

class function TAdiantamento.NumeroPedidoSelecionarVarios(APedido: TUniQuery): String;
begin
  Result := APedido.FieldByName('FGO_NUMDOC').AsString + '-' +
            APedido.FieldByName('FGO_ESPDOC').AsString + '-' +
            APedido.FieldByName('FGO_CODEMP').AsString;

  If APedido.FieldByName('FGO_ENT_CD').AsString <> 'S' Then
    Result := Result + ' (Faturamento na própria loja)'
  Else
    Result := Result + ' (Faturamento na loja ' +
      APedido.FieldByName('EMPDES').AsString+ ')';
end;

class function TAdiantamento.PedeFormasPagamento: Boolean;
  Var
    LValorLancamento: Double;
begin
  FInfAdiantamento.fltCreGer := 0;

  LValorLancamento := FInfAdiantamento.fltValLan;

  AtualizarValorLancamentoDocumentos;

  try
    FInfAdiantamento.strCodPor := FRegistroPix.CodigoPortador;
    FInfAdiantamento.strCodCta := FRegistroPix.PlanoDeContas;
    FInfAdiantamento.dtaDtaLan := FRegistroPix.DataPagamento;
    FInfAdiantamento.strDocume := FInfAdiantamento.documentos[0].strNumDoc + '-' +
                                  FInfAdiantamento.documentos[0].strEspDoc + '-' +
                                  FInfAdiantamento.documentos[0].strCodEmp;

    FInfAdiantamento.strDescri := 'ADIANTAMENTO DE PEDIDO REALIZADO VIA PIX';

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  FInfAdiantamento.fltValChP := 0.00;
  FInfAdiantamento.fltValChV := 0.00;
  FInfAdiantamento.fltValDin := 0.00;
  FInfAdiantamento.fltValCar := 0.00;
  FInfAdiantamento.fltValOrd := LValorLancamento;
  FInfAdiantamento.fltValCre := 0.00;

  Result := True;
end;

class function TAdiantamento.RealizarAdiantamento: Boolean;
begin
  FInfAdiantamento.RecebidoPorPix := True;

  Result := PedeFormasPagamento;
  If Result Then
    Result := ConfirmarAdiantamento;
end;

class function TAdiantamento.RealizarAdiantamentoClientePix(
  ANomeFormulario: String; var ADadosDoPix: TDadosRetornoPixConsulta;
  ARcxCon: Integer): Integer;
  Var
    LAdiantamento: TAdiantamento;

    LSelecionouDocumento: Boolean;

    LDadosPedido: TUniClientDataSet;
    LOperadorLancamento: string;
    LPortadorTransitorio: string;
begin
  Result := 0;

  // O Exit(0) do Try roda o Finally sem LAdiantamento ter sido atribuída, e o compilador
  // não zera local de tipo classe: Assigned leria lixo de pilha e FreeAndNil chamaria o
  // destrutor sobre ele. Acontece quando o PIX não tem pedido correspondente.
  LAdiantamento := Nil;

  LSelecionouDocumento := False;

  LPortadorTransitorio := TPixDao.RetornaPortadorTransitorioLancamentoPix(ADadosDoPix.TxId,
                                                                          ADadosDoPix.CodigoEmpresa);

  LOperadorLancamento := TPixDao.RetornaOperadorLancamentoPix(ADadosDoPix.TxId,
                                                              ADadosDoPix.CodigoEmpresa);

  LDadosPedido := TPixDao.RetornaDadosPedidoPix(ADadosDoPix.TxId,
                                                ADadosDoPix.CodigoEmpresa);

  Try
    If LDadosPedido.IsEmpty Then
      Exit(0);

    LAdiantamento := TAdiantamento.Create(ANomeFormulario, LOperadorLancamento, LPortadorTransitorio);

    LDadosPedido.First;

    LAdiantamento.FRegistroPix := ADadosDoPix;

    LSelecionouDocumento := LAdiantamento.SelecionarDocumentos('CTR');

    LAdiantamento.FInfAdiantamento.fltValDin := 0.00;
    LAdiantamento.FInfAdiantamento.fltValChV := 0.00;
    LAdiantamento.FInfAdiantamento.fltValChP := 0.00;
    LAdiantamento.FInfAdiantamento.fltValCar := 0.00;
    LAdiantamento.FInfAdiantamento.fltValFin := 0.00;
    LAdiantamento.FInfAdiantamento.fltValCre := 0.00;
    LAdiantamento.FInfAdiantamento.fltValOrd := ADadosDoPix.ValorPago;
    
    If Not LSelecionouDocumento Then
      Exit(0);

    FInfAdiantamento.intSeqCon := ARcxCon;

    If LAdiantamento.RealizarAdiantamento Then
    Begin
      Result := LAdiantamento.FInfAdiantamento.intSeqCon;

      ADadosDoPix.MovBanBaixa := LAdiantamento.FRegistroPix.MovbanBaixa;
      ADadosDoPix.NumeroDoPedido := LDadosPedido.FieldByName('FGO_NUMDOC').AsString + '-' +
                                    LDadosPedido.FieldByName('FGO_ESPDOC').AsString + '-' +
                                    LDadosPedido.FieldByName('FGO_CODEMP').AsString;

      LDadosPedido.Next;

      While Not LDadosPedido.Eof Do
      Begin
        ADadosDoPix.NumeroDoPedido := ADadosDoPix.NumeroDoPedido +
                                      ', ' + LDadosPedido.FieldByName('FGO_NUMDOC').AsString + '-' +
                                             LDadosPedido.FieldByName('FGO_ESPDOC').AsString + '-' +
                                             LDadosPedido.FieldByName('FGO_CODEMP').AsString;

        LDadosPedido.Next;
      End;

      ADadosDoPix.CodigoDoCliente := LDadosPedido.FieldByName('FGO_CODCLI').AsString;
    End
    Else
      LDadosPedido.Next;
  Finally
    FreeAndNil(LDadosPedido);

    If Assigned(LAdiantamento) Then
    Begin
      If LSelecionouDocumento Then
        DestravarPedidos(LAdiantamento);

      FreeAndNil(LAdiantamento);
    End;
  End;
end;

class function TAdiantamento.SelecionarDocumentos(AOrigem: String): Boolean;
  Var
    LPedidos: TUniQuery;
    documento: TDocAdiantamento;
begin
  FInfAdiantamento.strOrigem := AOrigem;
  
  LPedidos := fCriaQuery;

  LPedidos.SQL.Text := GetSQLPedidos(FRegistroPix.CodigoEmpresa, FRegistroPix.TxId, False);

  LPedidos.Open;

  Result := CarregarDadosPedido(LPedidos, FInfAdiantamento.documentos, AOrigem);
  If Result Then
    Result := SelecionarPedido(FInfAdiantamento.documentos);

  FreeAndNil(LPedidos);

  If (Result) Then
  Begin
    FInfAdiantamento.fltValLan := 0;
    For documento In FInfAdiantamento.documentos Do
      FInfAdiantamento.fltValLan := FInfAdiantamento.fltValLan + documento.fltVlrCon - documento.fltValAdt;

    FInfAdiantamento.strTipLan := 'C';
    FInfAdiantamento.strDescri := FInfAdiantamento.documentos[0].strCodCli + ' - ' +
                                  FInfAdiantamento.documentos[0].strNomCli;

    Result := FInfAdiantamento.fltValLan > 0;

    AtualizarValorLancamentoDocumentos;
  End;
end;

class function TAdiantamento.SelecionarPedido(ADocumentos: TArrDocAdiantamento): Boolean;
  Var
    LDocumento: String;

    LObjetoDocumento: TDocAdiantamento;
begin
  Result := False;

  For LObjetoDocumento In ADocumentos Do
  Begin
    LDocumento := LObjetoDocumento.strNumDoc + '-' + LObjetoDocumento.strEspDoc;

    If LObjetoDocumento.fltValAdt > 0 Then
    Begin
      If LObjetoDocumento.fltValAdt >= LObjetoDocumento.fltVlrCon Then
        Exit;
    End;

    If Not fLock_Unlock( 'FATGOR' + LObjetoDocumento.strNumDoc +
                                    LObjetoDocumento.strEspDoc +
                                    LObjetoDocumento.strCodEmp, True, False) Then
      Exit;
  End;

  Result := True;
end;

class procedure TAdiantamento.AtualizarValorLancamentoDocumentos;
  Var
    LContador: Integer;

    LFator,
    LTotalLan,
    LTotalDif: Double;
begin
  If Length(FInfAdiantamento.documentos) = 1 Then
  Begin
    FInfAdiantamento.documentos[0].fltValLan := FRegistroPix.ValorPago;
    Exit;
  End;

  LTotalLan := 0;
  For LContador := 0 To Length(FInfAdiantamento.documentos) -1 Do
  Begin
    FInfAdiantamento.documentos[LContador].fltValLan := FInfAdiantamento.documentos[LContador].fltVlrCon -
                                                        FInfAdiantamento.documentos[LContador].fltValAdt;
    LTotalLan := LTotalLan + FInfAdiantamento.documentos[LContador].fltValLan;
  End;

  For LContador := 0 To Length(FInfAdiantamento.documentos) -1 Do
  Begin
    LFator  := FInfAdiantamento.documentos[LContador].fltValLan / LTotalLan;
    FInfAdiantamento.documentos[LContador].fltValLan := fFormataFloat(FRegistroPix.ValorPago * LFator, 2);
  End;

  LTotalLan := 0;
  For LContador := 0 To Length(FInfAdiantamento.documentos) -1 Do
    LTotalLan := LTotalLan + FInfAdiantamento.documentos[LContador].fltValLan;

  LTotalDif := fFormataFloat(FRegistroPix.ValorPago - LTotalLan, 2);

  If LTotalDif <> 0.00 Then
    FInfAdiantamento.documentos[0].fltValLan := FInfAdiantamento.documentos[0].fltValLan + LTotalDif;
end;

end.
