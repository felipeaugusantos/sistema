{*******************************************}
{* AO FAZER ALTERACOES NESTA UNIT, TESTAR  *}
{* IMPRESSSAO DE RECIBO CTA. RECEBER, REIM-*}
{* PRESSAO RECIBO E RECIBO RESUMO DE CAIXA *}
{****************************************JC*}
unit untQckReciboCtaReceber;

interface

uses
  SysUtils, Classes, frxClass, frxDBSet, frxDMPExport, Uni,
  strUtils, DB, UniClientDataSet, frxDMPClass, Datasnap.DBClient, Forms, untCfgRel,
  frxExportPDF;

type
  TfrmQckReciboCtaReceber = class(TForm)
    frxReciboCtr_M: TfrxReport;
    frxReciboCtr_J: TfrxReport;
    frxMatricial: TfrxDotMatrixExport;
    frxDataset: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    frxReciboRcx_M: TfrxReport;
    frxReciboRcx_J: TfrxReport;
    frxChePre: TfrxDBDataset;
    cdsCadChq: TUniClientDataSet;
    cdsCadChqCHQ_CONCOR: TStringField;
    cdsCadChqCHQ_NUMCHQ: TStringField;
    cdsCadChqCHQ_NOMEMI: TStringField;
    cdsCadChqCHQ_C_G_C_: TStringField;
    cdsCadChqCHQ_DTAVEN: TDateField;
    cdsCadChqCHQ_VALCHQ: TFloatField;
    cdsCadChqCHQ_NUMAGE: TStringField;
    frxPDFExport: TfrxPDFExport;
    procedure DataModuleCreate(Sender: TObject);
    function frxReciboCtr_MUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }

    frxRecibo   : TfrxReport;

    FListaBaixas: TStringList;

    function fFormataFonePaisInterna(strTelefo: String): String;
    function RetornaValorBaixadoBoleto: Double;

  public
    { Public declarations }
    blnCalculaTotais: Boolean;
    procedure pImprimeRecibo(blnVideo,
                             blnDialogo: Boolean;
                             strNomFrm,
                             strTipImp,
                             strNomFil,
                             strSeqCon: String;
                             DataSet: TDataSet;
                             intQtdVias: Integer = 1;
                             blnResCai: Boolean = False;
                             fltChqPre: Double = 0;
                             fltChqVis: Double = 0;
                             fltCartao: Double = 0;
                             fltDinhei: Double = 0;
                             fltOrdPag: Double = 0;
                             fltCredito:Double = 0;
//                             fltTroco:  Double = 0;
                             strOperad: String = '';
                             strEspDoc: String = '';
                             qryChqPre: TDataSet = Nil;
                             qryChqVis: TDataSet = Nil;
                             strNomeCli: String = '';
                             strCodPor: String = '';
                             strHist02: String = '');
  end;

var
  frmQckReciboCtaReceber: TfrmQckReciboCtaReceber;

implementation

uses untFuncoesGenerica, untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckReciboCtaReceber.DataModuleCreate(Sender: TObject);
  var
    intContador:integer;
begin
  {****************************************************}
  {*  DESABILITA OS BOTÕES SAVE, LOAD e EDIT DO FAST  *}
  {*11/05/2015**************************************RB*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      {$IFDEF TESTABILIDADE_AUTCOM}
        // O botão salvar será utilizado nos testes automatizados
        TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons := [pbPrint, pbZoom, pbSave, pbFind, pbOutline, pbPageSetup, pbNavigator, pbExport]
      {$ELSE}
        TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
        TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
      {$ENDIF}
    End;
  End;

  frxReciboCtr_M.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
  frxReciboCtr_J.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
  frxReciboRcx_M.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
  frxReciboRcx_J.AddFunction('function fFormataFonePaisInterna(strTelefo: String): String');
end;

function TfrmQckReciboCtaReceber.fFormataFonePaisInterna(
  strTelefo: String): String;
begin
  Result := fFormataFone(strTelefo);
end;

function TfrmQckReciboCtaReceber.frxReciboCtr_MUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If SameText(MethodName, 'fFormataFonePaisInterna') Then
    Result := fFormataFonePaisInterna(Params[0]);
end;

function TfrmQckReciboCtaReceber.RetornaValorBaixadoBoleto: Double;
  Var
    LSQL,
    LValor: String;

    LDados: TStringList;

    LConsulta: TUniQuery;
begin
  Result := 0;

  If FListaBaixas.Count = 0 Then
    Exit;

  LSQL := ' WHERE (';

  Try
    LDados := TStringList.Create;
    LDados.Delimiter := '-';
    LDados.StrictDelimiter := True;

    For LValor In FListaBaixas Do
    Begin
      LDados.DelimitedText := LValor;

      LSQl := LSQL + '(L.CTR_SEQCON=' + LDados[0] + ' AND ' +
                     ' L.CTR_EMPBAI="' + LDados[1] + '" AND ' +
                     ' L.CTR_DTABAI="' + LDados[2] + '") OR ';
    End;

    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT IFNULL(SUM(C.CTR_DINHEI), 0) AS VALOR ' +
                          'FROM LOGCTR L ' +
                          'JOIN CADREC C ON C.CTR_NUMDUP=L.CTR_NUMDUP AND ' +
                          '                 C.CTR_PARCEL=L.CTR_PARCEL AND ' +
                          '                 C.CTR_ESPDOC=L.CTR_ESPDOC AND ' +
                          '                 C.CTR_CODEMP=L.CTR_CODEMP AND ' +
                          '                 C.CTR_CODCLI=L.CTR_CODCLI AND ' +
                          '                 C.CTR_SEQBAI=L.CTR_SEQBAI ' +
                          LeftStr(LSQL, LSQL.Length - 3) + ') AND ' +
                          ' L.CTR_DESCRI IN ("BAIXA TOTAL", "BAIXA TOTAL (AUTBAN)","BAIXA TOTAL LD", "BAIXA TOTAL (AUTBAN) LD") AND ' +
                          ' L.CTR_NOMFRM="frmPrincipal" ';
    LConsulta.Open;

    Result := fFormataFloat(LConsulta.FieldByName('VALOR').AsFloat, 2);
  Finally
    FreeAndNil(LDados);
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmQckReciboCtaReceber.pImprimeRecibo(blnVideo,
                                                 blnDialogo: Boolean;
                                                 strNomFrm,
                                                 strTipImp,
                                                 strNomFil,
                                                 strSeqCon: String;
                                                 DataSet: TDataSet;
                                                 intQtdVias: Integer = 1;
                                                 blnResCai: Boolean = False;
                                                 fltChqPre: Double = 0;
                                                 fltChqVis: Double = 0;
                                                 fltCartao: Double = 0;
                                                 fltDinhei: Double = 0;
                                                 fltOrdPag: Double = 0;
                                                 fltCredito:Double = 0;
//                                                 fltTroco:  Double = 0;
                                                 strOperad: String = '';
                                                 strEspDoc: String = '';
                                                 qryChqPre: TDataSet = Nil;
                                                 qryChqVis: TDataSet = Nil;
                                                 strNomeCli: String = '';
                                                 strCodPor: String = '';
                                                 strHist02: String = '');
  Var
    intContador: Integer;
    LValorBoleto,
    fltValDin : Double;
    blnExisteCamposDataset : boolean;
Begin
  If strTipImp = 'M' Then
  Begin
    If Not blnResCai Then
      frxRecibo := frxReciboCtr_M
    Else
      frxRecibo := frxReciboRcx_M;

    frxRecibo.reportOptions.Compressed := True;
  End
  Else
  Begin

    If Not blnResCai Then
      frxRecibo := frxReciboCtr_J
    Else
      frxRecibo := frxReciboRcx_J;

    frxRecibo.DotMatrixReport := False;
    frxRecibo.reportOptions.Compressed := False;
  End;

  If blnResCai Then
  Begin

    cdsCadChq.CreateDataSet;
    cdsCadChq.Open;

    pAdicionaCheques(qryChqPre, cdsCadChq);
    pAdicionaCheques(qryChqVis, cdsCadChq);

    frxRecibo.FindObject('fooChePre').Visible := (Not cdsCadChq.IsEmpty);

  End
  Else
  Begin

    If Not fCfgSis('HISREC', varBoolean ) Then
    Begin
      frxRecibo.FindObject('rllHist01').Visible := False;
      frxRecibo.FindObject('Memo12').Visible    := False;
    End
    Else
    Begin
      frxRecibo.FindObject('rllHist01').Visible := True;
      frxRecibo.FindObject('Memo12').Visible    := True;
    End;

  End;

  blnExisteCamposDataset := False;

  if (DataSet.FindField('VALOR_BOLETO') <> nil) And (DataSet.FindField('DINHEIRO_SEM_BOLETO') <> nil) then
     blnExisteCamposDataset := True;

  LValorBoleto := 0;
  fltValDin := 0;

  If Not blnExisteCamposDataset Then
  Begin

    // calcula valor do boleto
    If Not blnRescai Then
    Begin

      FListaBaixas := TStringList.Create;

      DataSet.First;
      While Not DataSet.Eof Do
      Begin

        fltValDin := fltValDin + DataSet.FieldByName('CTR_DINHEI').AsFloat ;

        If (Not MatchStr(DataSet.FieldByName('SEQCON').AsString, ['', '0'])) And //validação para registros muito antigos ou convertidos fora do padrão
           (Not MatchStr(DataSet.FieldByName('CTR_DTABAI').AsString, ['', '0'])) Then
        Begin
          If FListaBaixas.IndexOf(Concat(DataSet.FieldByName('SEQCON').AsString, '-',
                                         DataSet.FieldByName('CTR_EMPBAI').AsString, '-',
                                         FormatDateTime('yyyy/mm/dd', DataSet.FieldByName('CTR_DTABAI').AsDateTime))) = -1 Then
            FListaBaixas.Add(Concat(DataSet.FieldByName('SEQCON').AsString, '-',
                                    DataSet.FieldByName('CTR_EMPBAI').AsString, '-',
                                    FormatDateTime('yyyy/mm/dd', DataSet.FieldByName('CTR_DTABAI').AsDateTime)));
        End;
        DataSet.next;

      End;

      LValorBoleto  := RetornaValorBaixadoBoleto;

      FreeAndNil(FListaBaixas);

    End;

  End;

  DataSet.First;
  frxDataset.DataSet := DataSet;
  frxDataSet.FieldsCount;

  If blnCalculaTotais Then
  Begin
    TfrxMemoView(frxRecibo.FindObject('TOTDINHEIRO')).Text  := 'DINHEIRO: '   + FloatToStrF(fltDinhei, ffNumber, 12, 2);
    TfrxMemoView(frxRecibo.FindObject('TOTCHEQUE')).Text    :=                  FloatToStrF(fltChqVis, ffNumber, 12, 2);
    TfrxMemoView(frxRecibo.FindObject('TOTCHEQUEPRE')).Text := 'CHEQUE PRE: ' + FloatToStrF(fltChqPre, ffNumber, 12, 2);
    TfrxMemoView(frxRecibo.FindObject('TOTCARTAO')).Text    := 'CARTAO: '     + FloatToStrF(fltCartao, ffNumber, 12, 2);
    TfrxMemoView(frxRecibo.FindObject('TOTORDEMPGTO')).Text :=                  FloatToStrF(fltOrdPag, ffNumber, 12, 2);
    If DataSet.FieldByName('RECPIX').AsString = 'S' Then
      TfrxMemoView(frxRecibo.FindObject('rlbOrdemPagamento')).Text := 'PIX:';

    TfrxMemoView(frxRecibo.FindObject('TOTCRED')).Text      := 'CREDITO UTILIZADO: ' + FloatToStrF(fltCredito, ffNumber, 12, 2);
  End;

  If frxRecibo.FindObject('rllTotalDocSeqBaixa') <> Nil Then
    TfrxMemoView(frxRecibo.FindObject('rllTotalDocSeqBaixa')).Text := '[SUM(<frxDataset."VALDOC">,rlbMaster)+SUM(<frxDataset."VALOR_TROCO">,rlbMaster)]';

  If frxRecibo.FindObject('rllTotalRecSeqBaixa') <> Nil Then
    TfrxMemoView(frxRecibo.FindObject('rllTotalRecSeqBaixa')).Text := '[SUM(<frxDataset."VALREC">,rlbMaster)+SUM(<frxDataset."VALOR_TROCO">,rlbMaster)]';

  If fCfgSis('SIGPAI', varString) = 'PAR' Then
  Begin
    TfrxMemoView(frxRecibo.FindObject('rllSeqBaixa')).Text := IfThen(fEmptyStr(strSeqCon), '', 'SEQ.BAJA: ' + IIF(blnResCai, strSeqCon, ''));
    frxRecibo.Script.Variables['RELACAO']     := 'LISTA DE LOS DOCUMENTOS DESCARGADOS';
    frxRecibo.Script.Variables['RECEBIDO']    := 'RECEBIDO';
    frxRecibo.Script.Variables['DESCRICAO']   := 'CLIENTE/DESCRIPCION';
    frxRecibo.Script.Variables['EMP']         := 'NEG';
    frxRecibo.Script.Variables['VENC']        := 'MADUREZ';
    frxRecibo.Script.Variables['JUROS']       := 'INTERES';
    frxRecibo.Script.Variables['PLANO']       := 'PL.CUENTAS:';
    frxRecibo.Script.Variables['ORDEM']       := 'GIRO POSTAL:';
    frxRecibo.Script.Variables['CHQPRE']      := 'CHQ. ADEL:';
    frxRecibo.Script.Variables['CARTAO']      := 'TARJETA:';
    frxRecibo.Script.Variables['DINHEIRO']    := 'DINERO:';
    frxRecibo.Script.Variables['CNPJ']        := 'RUC';
    frxRecibo.Script.Variables['COMPENSACAO'] := 'ESTO SOLO ES VALIDO EN LA RECEPCION DE COMPENSACION CHEQUE';
    frxRecibo.Script.Variables['NOSSONUMER']  := 'NUESTRO NUMER.';
    frxRecibo.Script.Variables['TOTALGERAL']  := 'GENERAL DE LO CLIENTE TOTAL:';
    frxRecibo.Script.Variables['CREDITO']     := 'CREDITO UTILIZADO:';
  End
  Else
  Begin
    TfrxMemoView(frxRecibo.FindObject('rllSeqBaixa')).Text := IfThen(fEmptyStr(strSeqCon), '', 'SEQ.BAIXA: ' + IIF(blnResCai, strSeqCon, ''));
    frxRecibo.Script.Variables['RELACAO']     := IfThen(strTipImp = 'M', 'RELACAO DE DOCUMENTOS BAIXADOS', 'RELAÇÃO DE DOCUMENTOS BAIXADOS');
    frxRecibo.Script.Variables['RECEBIDO']    := IfThen(Not blnResCai, 'EMITIDO EM ', 'RECEBIDO EM ');
    frxRecibo.Script.Variables['DESCRICAO']   := IIF(strEspDoc = 'PG', IfThen(strTipImp = 'M', 'FORNECEDOR/DESCRICAO', 'FORNECEDOR/DESCRIÇÃO'), IfThen(strTipImp = 'M', 'CLIENTE/DESCRICAO', 'CLIENTE/DESCRIÇÃO'));
    frxRecibo.Script.Variables['EMP']         := 'EMP';
    frxRecibo.Script.Variables['VENC']        := 'DT.VCTO.';
    frxRecibo.Script.Variables['JUROS']       := 'VL. JUROS';
    frxRecibo.Script.Variables['PLANO']       := 'PL.CONTAS:';

    frxRecibo.Script.Variables['ORDEM']       := 'ORDEM PGTO.:';
    If Dataset.FieldByName('RECPIX').AsString = 'S' Then
      frxRecibo.Script.Variables['ORDEM']       := 'PIX:';

    frxRecibo.Script.Variables['CHQPRE']      := IfThen(strTipImp = 'M', 'CHQ. PRE:', 'CHQ. PRÉ:');
    frxRecibo.Script.Variables['CARTAO']      := IfThen(strTipImp = 'M', 'CARTAO:', 'CARTÃO:');
    frxRecibo.Script.Variables['DINHEIRO']    := 'DINHEIRO:';
    frxRecibo.Script.Variables['CNPJ']        := 'CNPJ/CPF';
    frxRecibo.Script.Variables['COMPENSACAO'] := IfThen(strTipImp = 'M', 'ESTE RECIBO SOMENTE SERA VALIDO NA COMPENSACAO DO CHEQUE', 'ESTE RECIBO SOMENTE SERÁ VÁLIDO NA COMPENSAÇÃO DO CHEQUE');
    frxRecibo.Script.Variables['NOSSONUMER']  := IfThen(strTipImp = 'M', 'NOSSO NUMER.', 'NOSSO NÚMER.');
    frxRecibo.Script.Variables['TOTALGERAL']  := 'TOTAL GERAL DO CLIENTE:';
    frxRecibo.Script.Variables['CREDITO']     := IfThen(strTipImp = 'M','CREDITO UTILIZADO:','CRÉDITO UTILIZADO:');
    frxRecibo.Script.Variables['DTAREC']      := 'DT.REC.';
    frxRecibo.Script.Variables['DTEMISSAO']   := VS_Date ;
    frxRecibo.Script.Variables['CAIXA']       := DataSet.FieldByName('RCX_CAIXA').AsString;
  End;

  If blnResCai Then
  Begin
    frxRecibo.Script.Variables['fltChqPre'] := fltChqPre;
    frxRecibo.Script.Variables['fltChqVis'] := fltChqVis;
    frxRecibo.Script.Variables['fltCartao'] := fltCartao;
    frxRecibo.Script.Variables['fltDinhei'] := fltDinhei;
    frxRecibo.Script.Variables['fltOrdPag'] := fltOrdPag;
    frxRecibo.Script.Variables['fltCredito']:= fltCredito;
    frxRecibo.Script.Variables['NOMECLI']:= strNomeCli;

    If strEspDoc = 'PG' Then
    Begin
      frxRecibo.Script.Variables['strOperad'] := 'Recebi';
      frxRecibo.Script.Variables['OPERADOR1'] := 'Operador: ' + strOperad;
      frxRecibo.Script.Variables['NOMECLI']   := '';
    End
    Else
    Begin
      frxRecibo.Script.Variables['strOperad'] := strOperad;
      frxRecibo.Script.Variables['OPERADOR1'] := ' ';
      frxRecibo.Script.Variables['NOMECLI']   := '';
    End;
  End
  Else
  Begin
    If (DataSet.FieldByName('RECPIX').AsString = 'S') And
       (frxRecibo.FindObject('rlbOrdemPagamento') <> Nil) Then
      TfrxMemoView(frxRecibo.FindObject('rlbOrdemPagamento')).Text := 'PIX:';
  End;

  if (not blnResCai) then
  begin
    frxRecibo.Script.Variables['CODEMP'] := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
    frxRecibo.Script.Variables['CODPOR'] := strCodPor + ' - ' + fRetNomPortador(strCodPor);
    frxRecibo.Script.Variables['CODOPE'] := strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado);
    frxRecibo.Script.Variables['HISTOR'] := strHist02;

    If frxRecibo.FindObject('TOTDINHEIRO') <> Nil Then
    Begin
       If blnExisteCamposDataset Then
       Begin
          If fFormataFloat(Dataset.FieldByname('VALOR_BOLETO').AsFloat, 2) > 0 Then
             TfrxMemoView(frxRecibo.FindObject('TOTDINHEIRO')).Text  := 'DINHEIRO: [SUM(<frxDataset."DINHEIRO_SEM_BOLETO">,rlbMaster)]';
       End
       Else
       Begin
          If fFormataFloat(LValorBoleto, 2) > 0 Then
             TfrxMemoView(frxRecibo.FindObject('TOTDINHEIRO')).Text  := 'DINHEIRO: ' + FormatFloat('#0.00', fFormataFloat(fltValDin - LValorBoleto, 2));
       End;
    End;

    If frxRecibo.FindObject('TOTBOLETO') <> Nil Then
    Begin
      If Not blnExisteCamposDataset Then
      Begin
         If fFormataFloat(LValorBoleto, 2) > 0 Then
            TfrxMemoView(frxRecibo.FindObject('TOTBOLETO')).Text  := 'BOLETO: ' + FormatFloat('#0.00', fFormataFloat(LValorBoleto, 2) )
         Else
            TfrxMemoView(frxRecibo.FindObject('TOTBOLETO')).Text  := 'BOLETO: ' + FormatFloat('#0.00', fFormataFloat(0, 2) );
      End;
    End;

    if (fCfgSis('INFREC',varBoolean)) then
    begin
      TfrxGroupFooter(frxRecibo.FindObject('GroupFooter1')).Child := TfrxChild(frxRecibo.FindObject('Child1'));
      TfrxGroupFooter(frxRecibo.FindObject('GroupFooter1')).PrintChildIfInvisible := True;
    end
    else
    begin
      TfrxGroupFooter(frxRecibo.FindObject('GroupFooter1')).Child := TfrxChild(frxRecibo.FindObject('Child2'));
      TfrxGroupFooter(frxRecibo.FindObject('GroupFooter1')).PrintChildIfInvisible := True;
    end;
  end;

  If VerImpressoraONLINE(strNomFil) <> 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Impressora "' + strNomFil + '" está OFFLINE! Selecione outra!', ['&OK']);
    blnDialogo := True;
  End
  Else
    blnDialogo := False;

  frxRecibo.PrintOptions.Printer := AnsiReplaceText(strNomFil, '\\' + fRetNomeRede + '\', '');
  frxRecibo.PrintOptions.ShowDialog := blnDialogo;
  frxRecibo.Script.Variables['NOMEMP'] := fRetNomeEmpresa;

  frxRecibo.PrepareReport;

  // VERIFICA SE FOI ESCOLHIDO MATRICIAL, CASO SIM VERIFICA SE A IMPRESSORA É MATRICIAL CONTINUA A ROTINA,
  // CASO NÃO SEJA ABRE EM MODO DE VIDEO PARA QUE POSSA SER EXPORTADO PDF;
  If(strTipImp = 'M') And (blnVideo=false)Then
  Begin
    If Not TCfgRel.IsPrinterMatrix(strNomFil) Then
      blnVideo := True;
  End;

  For intContador := 1 To intQtdVias Do
  Begin
    If (blnVideo) Or fEmptyStr(strNomFil) Then
    Begin
      frxRecibo.PrintOptions.ShowDialog := fEmptyStr(strNomFil);
      pPreviewReport(strNomFrm, 'Recibo de baixa de contas a receber', frxRecibo);
    End
    Else
      pPrintReport(strNomFrm, 'Recibo de baixa de contas a receber', strNomFil, frxRecibo);
  End;

  If blnResCai Then
  Begin
    cdsCadChq.Close;
  End;
End;

End.
