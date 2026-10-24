unit untQckCtpBordero;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, DB, Uni, StrUtils, RLParser, untFuncoesGenerica,
  Datasnap.DBClient, frxClass, frxDBSet, UniClientDataSet, frxExportPDF;

type
  TfrmQckCtpBordero = class(TForm)
    dtsGenPag: TDataSource;
    dtsChqsEmi: TDataSource;
    frxReport: TfrxReport;
    frxDBDatasetGenPag: TfrxDBDataset;
    frxDBDatasetChqsEmi: TfrxDBDataset;
    cdsChqsEmi: TUniClientDataSet;
    cdsChqsEmiEMI_NUMCHQ: TStringField;
    cdsChqsEmiEMI_NUMAGE: TStringField;
    cdsChqsEmiEMI_CONCOR: TStringField;
    frxDBDatasetChqsTerceiros: TfrxDBDataset;
    dtsChqsTerceiros: TDataSource;
    cdsChqsEmiCTB_CODPOR: TStringField;
    cdsChqsEmiEMI_CODBCO: TStringField;
    cdsChqsEmiCHQ_VALCHQ: TFloatField;
    cdsChqsEmiPOR_NOMPOR: TStringField;
    frxDBDatasetMOVBAN: TfrxDBDataset;
    dtsMOVBAN: TDataSource;
    frxDBDatasetCTPDET: TfrxDBDataset;
    dtsCTPDET: TDataSource;
    frxDBDatasetCADPAG: TfrxDBDataset;
    dtsCADPAG: TDataSource;
    cdsChqsEmiCHQ_TIPCHQ: TStringField;
    cdsChqsEmiCHQ_DTAEMI: TStringField;
    cdsChqsEmiCHQ_BOMPAR: TStringField;
    cdsChqsEmiCHQ_NOMEMI: TStringField;
    cdsChqsEmiCHQ_DTAVEN: TStringField;
    frxPDFExportBordero: TfrxPDFExport;
    procedure FormCreate(Sender: TObject);
    function frxReportUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    qryGenPag: TUniQuery;
    FPais: TPais;
    FImpHis : Boolean;
    FReimpr : Boolean;
    Procedure pLoadReport(strTipImp: String);
    Function fSqlBordero(stlSeqCon: TStringList): String;
    function fRetornaDataBaixa(strSeqCon, strCodEmp: String): String;
    function fRetornaHoraBaixa(strSeqCon, strCodEmp: String): String;
    function fRetornaOperadorBaixa(strSeqCon, strCodEmp: String): String;
    function RetornaCaminhoPDF: String;
    function RetornaNomePDF: String;

  public
    { Public declarations }
    strNumChq: String;
    strCodBco: String;
    strNumAge: String;
    strConCor: String;
    strCodPor: String;
    strNomPor: String;
    fltValChq: Double;
    strDtaIni: String;
    strDtaFin: String;
    strDtaBom: String;
    strDtaEmi: String;

    FCaminhoArquivoPdf: String;

    procedure pImprimeBordero(stlSeqCon  : TStringList;
                              strSaida   : String  = 'V';
                              blnImpHis  : Boolean = False;
                              blnReimpr  : Boolean = False;
                              blnDetalhe : Boolean = False;
                              blnTemSeqConDif: Boolean = False;
                              blnDupBaixada : Boolean = False); Overload;

    procedure pImprimeBordero(stlSeqCon  : TStringList;
                              strSaida   : String;
                              blnImpHis  : Boolean;
                              blnReimpr  : Boolean;
                              blnDetalhe : Boolean;
                              blnTemSeqConDif: Boolean;
                              blnDupBaixada : Boolean ;
                              out AArquivPdf: String); Overload;

    {Funções repassadas ao FastReport}
    function fFormataCpfCgcLOCAL(pCPFCGC : String): String;
    function fReplaceStrLOCAL(strTexto, strOLD, strNew : String) : String;
    function fVerificaComponenteRelExiste(strComponente,
                                          strInformacao : String) : Boolean;

    procedure pOcultarDetalhes(blnOcular : Boolean);

  end;


implementation

uses untFuncoesSimples, untConstantes, untCfgRel;

{$R *.dfm}

function TfrmQckCtpBordero.fFormataCpfCgcLOCAL(pCPFCGC : String): String;
begin
  Result := fFormataCpfCgc(pCPFCGC, fSetaPais);
end;

procedure TfrmQckCtpBordero.FormCreate(Sender: TObject);
begin
  qryGenPag := fCriaQuery(Self);
  FPais     := fSetaPais;

  cdsChqsEmi.CreateDataSet;
  cdsChqsEmi.EmptyDataSet;

  frxReport.AddFunction('function fFormataCpfCgcLOCAL(pCPFCGC : String): String');
  frxReport.AddFunction('function fReplaceStrLOCAL(strTexto, strOLD, strNew : String) : String');
  frxReport.AddFunction('function fVerificaComponenteRelExiste(strComponente, strInformacao : String):Boolean');

end;

procedure TfrmQckCtpBordero.pImprimeBordero(stlSeqCon  : TStringList;
                                            strSaida   : String  = 'V';
                                            blnImpHis  : Boolean = False;
                                            blnReimpr  : Boolean = False;
                                            blnDetalhe : Boolean = False;
                                            blnTemSeqConDif: Boolean = False;
                                            blnDupBaixada : Boolean = False);
Var
  strNomeFila, strSQL : String;
  strTipImp           : String;
  qryMOVBAN           : TUniQuery;
  qryCTPDET           : TUniQuery;
  qryCADPAG           : TUniQuery;
  qryCfgRel           : TUniQuery;
  qryChq_Emi_Baixa    : TUniQuery;
  qryChq_Terceiros    : TUniQuery;
  qryDinheiro         : TUniQuery;
  qryDepBancario      : TUniQuery;
  stlAUTOINCREM       : TStringList;
  fltVlrDepBancario   : Double;
  fltVlrDinheiro      : Double;
  fltVlrChqEmi        : Double;
  fltVlrChqRep        : Double;
  fltVlrTotalFormasPgto : Double;
  SfltValorTotal      : Double;
  LNomeArquivo: String;
begin

  Try
     If strSaida <> 'V' Then
     Begin
       qryCfgRel := fCriaQuery;
       pCarregaConfImpr(qryCfgRel, 'frmBaixaCtaPagar');
       fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
       pLoadReport(strTipImp);
       frxReport.PrintOptions.ShowDialog := fEmptyStr(strNomeFila);
       if Not fEmptyStr(strNomeFila) then
         frxReport.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');
     End
     Else
      pLoadReport('J');

    FImpHis := blnImpHis;
    FReimpr := blnReimpr;

    fltVlrDepBancario := 0;
    fltVlrChqEmi      := 0;
    fltVlrDinheiro    := 0;
    fltVlrChqRep      := 0;

    With qryGenPag Do
    Begin

      SQL.Text := fSqlBordero(stlSeqCon);
      Open;

      SfltValorTotal := 0;
      qryGenPag.First;
      while not qryGenPag.Eof do
      begin
        SfltValorTotal := SfltValorTotal + qryGenPag.FieldByName('CTP_VALPAG').AsFloat;
        qryGenPag.Next;
      end;

      If Assigned(frxReport.FindObject('Memo21')) Then
         TfrxMemoView(frxReport.FindObject('Memo21')).Memo.Text  := FormatFloat('#,##0.00', SfltValorTotal);

      {Impressão dos cheques emitidos}
      if strCodBco <> '' then
      begin

        cdsChqsEmi.EmptyDataSet;

        cdsChqsEmi.Append;
        cdsChqsEmiCTB_CODPOR.AsString := strCodPor;
        cdsChqsEmiPOR_NOMPOR.AsString := strNomPor;
        cdsChqsEmiEMI_CODBCO.AsString := strCodBco;
        cdsChqsEmiEMI_CONCOR.AsString := strConCor;
        cdsChqsEmiEMI_NUMAGE.AsString := strNumAge;
        cdsChqsEmiEMI_NUMCHQ.AsString := strNumChq;
        cdsChqsEmiCHQ_VALCHQ.AsFloat  := fltValChq;

        If fEmptyStr(strDtaBom) Then
          cdsChqsEmiCHQ_DTAVEN.AsString := strDtaEmi
        Else
          cdsChqsEmiCHQ_DTAVEN.AsString := strDtaBom;

        cdsChqsEmi.Post;

      end
      else
      begin

        stlAUTOINCREM := TStringList.Create;
        stlAUTOINCREM.Clear;

        qryGenPag.First;
        while not qryGenPag.Eof do
        begin
          stlAUTOINCREM.Add(QuotedStr(qryGenPag.FieldByName('AUTOINCREM').AsString));
          qryGenPag.Next;
        end;

        if (stlAUTOINCREM.Count > 0) then
        begin

          qryChq_Emi_Baixa := fCriaQuery(Self);

          strSQL := '';
          strSQL := strSQL + 'SELECT MOVBAN.CTB_CODPOR, CHQEMI.EMI_CODBCO, CHQEMI.EMI_CONCOR,     ';
          strSQL := strSQL + '       CHQEMI.EMI_NUMAGE, CHQEMI.EMI_NUMCHQ, BANCHQ.CHQ_VALCHQ,     ';
          strSQL := strSQL + '       CADPOR.POR_NOMPOR, CHQEMI.EMI_DTAEMI, EMI_BOMPAR, EMI_CODEMP ';
          strSQL := strSQL + 'FROM CADPAG                                                       ';
          strSQL := strSQL + 'INNER JOIN MOVBAN ON (MOVBAN.CTB_PAGCON = CADPAG.CTP_SEQCON)      ';
          strSQL := strSQL + 'INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = MOVBAN.CTB_CODPOR)      ';
          strSQL := strSQL + 'INNER JOIN BANCHQ ON (BANCHQ.CTB_SEQLAN = MOVBAN.CTB_SEQLAN)      ';
          strSQL := strSQL + 'INNER JOIN CHQEMI ON (CHQEMI.EMI_CODBCO = BANCHQ.CHQ_CODBCO AND   ';
          strSQL := strSQL + '                      CHQEMI.EMI_NUMAGE = BANCHQ.CHQ_NUMAGE AND   ';
          strSQL := strSQL + '                      CHQEMI.EMI_CONCOR = BANCHQ.CHQ_CONCOR AND   ';
          strSQL := strSQL + '                      CHQEMI.EMI_NUMCHQ = BANCHQ.CHQ_NUMCHQ)      ';
          strSQL := strSQL + 'WHERE CADPAG.AUTOINCREM IN (' + stlAUTOINCREM.CommaText + ') AND  ';
          strSQL := strSQL + '      MOVBAN.CTB_CODEMP = ' + QuotedStr(VS_strCodEmp);
          strSQL := strSQL + 'GROUP BY MOVBAN.CTB_CODPOR, CHQEMI.EMI_CODBCO, CHQEMI.EMI_CONCOR, ';
          strSQL := strSQL + '         CHQEMI.EMI_NUMAGE, CHQEMI.EMI_NUMCHQ, BANCHQ.CHQ_VALCHQ, ';
          strSQL := strSQL + '         CHQEMI.EMI_DTAEMI, EMI_BOMPAR, EMI_CODEMP                ';

          With qryChq_Emi_Baixa Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            Open;

            cdsChqsEmi.EmptyDataSet;
            if not IsEmpty then
            begin

              First;

              while not Eof do
              begin

                cdsChqsEmi.Append;
                cdsChqsEmiCHQ_TIPCHQ.AsString  := 'CHEQUE EMPRESA';
                cdsChqsEmiCHQ_DTAEMI.AsString  := FieldByName('EMI_DTAEMI').AsString;
                cdsChqsEmiCHQ_BOMPAR.AsString  := FieldByName('EMI_BOMPAR').AsString;
                cdsChqsEmiCTB_CODPOR.AsString  := FieldByName('CTB_CODPOR').AsString;
                cdsChqsEmiPOR_NOMPOR.AsString  := FieldByName('POR_NOMPOR').AsString;
                cdsChqsEmiEMI_CODBCO.AsString  := FieldByName('EMI_CODBCO').AsString;
                cdsChqsEmiEMI_CONCOR.AsString  := FieldByName('EMI_CONCOR').AsString;
                cdsChqsEmiEMI_NUMAGE.AsString  := FieldByName('EMI_NUMAGE').AsString;
                cdsChqsEmiEMI_NUMCHQ.AsString  := FieldByName('EMI_NUMCHQ').AsString;
                cdsChqsEmiCHQ_VALCHQ.AsFloat   := FieldByName('CHQ_VALCHQ').AsFloat;
                cdsChqsEmiCHQ_NOMEMI.AsString  := fRetNomeEmpresa(FieldByName('EMI_CODEMP').AsString);

                If FieldByName('EMI_BOMPAR').IsNull Then
                  cdsChqsEmiCHQ_DTAVEN.AsString := FieldByName('EMI_DTAEMI').AsString
                Else
                  cdsChqsEmiCHQ_DTAVEN.AsString := FieldByName('EMI_BOMPAR').AsString;

                cdsChqsEmi.Post;

                fltVlrChqEmi := fltVlrChqEmi + cdsChqsEmi.FieldByName('CHQ_VALCHQ').AsFloat;

                Next;
              end;
            end;
          End;
        end;
      end;

      {Se não tiver registros de cheques emitidos, imprime somente o cabeçalho!}
      cdsChqsEmi.First;
      if cdsChqsEmi.IsEmpty then
      begin
        If Assigned(frxReport.FindObject('CCheques')) Then
          frxReport.FindObject('CCheques').Visible := False;
      End
      else
      begin
        If blnDetalhe Then
        Begin
          If Assigned(frxReport.FindObject('CCabecalhoCheques')) Then
            frxReport.FindObject('CCabecalhoCheques').Visible := False;

          If Assigned(frxReport.FindObject('CDDebitoConta')) Then
            frxReport.FindObject('CDDebitoConta').Visible     := False;
        End;

        If blnDetalhe then
        begin
          If Assigned(frxReport.FindObject('CCheques')) Then
          frxReport.FindObject('CCheques').Visible := True;
        end
        else
        if not blnDupBaixada then
        Begin
          If Assigned(frxReport.FindObject('CCheques')) Then
            frxReport.FindObject('CCheques').Visible := False;
        End;
      end;

      If Not IsEmpty Then
      Begin

        Try
          qryGenPag.First;
          dtsGenPag.DataSet := qryGenPag;

          {Cheques de Terceiros}

          {Select "Forçado" para o Fast Report não emitir erros}
          qryChq_Terceiros := fCriaQuery(Nil);
          strSQL           := 'SELECT * FROM CADCHQ WHERE FALSE';

          With qryChq_Terceiros Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            Open;
          end;

          dtsChqsTerceiros.DataSet := qryChq_Terceiros;


          qryMOVBAN := fCriaQuery(Nil);
          strSQL    := 'SELECT * FROM MOVBAN WHERE FALSE';

          With qryMOVBAN Do
          begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            Open;
          end;

          dtsMOVBAN.DataSet := qryMOVBAN;



          qryCTPDET := fCriaQuery(Nil);
          strSQL    := 'SELECT * FROM CTPDET WHERE FALSE';

          With qryCTPDET Do
          begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            Open;
          end;

          dtsCTPDET.DataSet := qryCTPDET;

          qryCADPAG := fCriaQuery(Nil);
          strSQL    := 'SELECT * FROM CADPAG WHERE FALSE';

          With qryCADPAG Do
          begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            Open;
          end;

          dtsCADPAG.DataSet := qryCADPAG;

          If Assigned(frxReport.FindObject('CChequesTerceiros')) Then
            frxReport.FindObject('CChequesTerceiros').Visible := False;

          If Assigned(frxReport.FindObject('CDinheiro')) Then
            frxReport.FindObject('CDinheiro').Visible         := False;

          If Assigned(frxReport.FindObject('CDepBancario')) Then
            frxReport.FindObject('CDepBancario').Visible      := False;

          strSQL := ' ';
          strSQL := strSQL + '  SELECT CADPAG.*  ';
          strSQL := strSQL + '    FROM CADPAG ';
          strSQL := strSQL + '  WHERE CTP_SEQCON = ' + qryGenPag.FieldByName('CTP_SEQCON').AsString;
          strSQL := strSQL + '    AND CTP_EMPBAI = "' + qryGenPag.FieldByName('CTP_EMPBAI').AsString + '"';
          strSQL := strSQL + '    AND CTP_DTABAI = "' + FormatDateTime('yyyy-mm-dd', qryGenPag.FieldByName('CTP_DTABAI').AsDateTime) + '"';
          strSQL := strSQL + '  GROUP BY CTP_SEQCON ';

          qryCADPAG.Close;
          qryCADPAG.MasterSource := dtsGenPag;
          qryCADPAG.SQL.Clear;
          qryCADPAG.SQL.Add(strSQL);
          qryCADPAG.Open;

          if (blnDetalhe) then
          begin
            If Assigned(frxReport.FindObject('MemoPlaCta')) Then
              frxReport.FindObject('MemoPlaCta').Visible := True;

            If Assigned(frxReport.FindObject('MemoCTP_CODBAI')) Then
              frxReport.FindObject('MemoCTP_CODBAI').Visible := True;

            If Assigned(frxReport.FindObject('MemoPlaDesc')) Then
              frxReport.FindObject('MemoPlaDesc').Visible := True;

            If Assigned(frxReport.FindObject('MemoCTA_DESCTA')) Then
              frxReport.FindObject('MemoCTA_DESCTA').Visible := True;

            pOcultarDetalhes(False);

            stlAUTOINCREM := TStringList.Create;
            stlAUTOINCREM.Clear;

            qryGenPag.First;
            while not qryGenPag.Eof do
            begin
              stlAUTOINCREM.Add(QuotedStr(qryGenPag.FieldByName('AUTOINCREM').AsString));
              qryGenPag.Next;
            end;

            if (stlAUTOINCREM.Count > 0) then
            begin

              try

                qryChq_Terceiros.Close;
                qryChq_Terceiros.SQL.Clear;
                qryChq_Terceiros.SQL.Add('SELECT ''CHEQUE TERCEIRO'' AS CHQ_TIPCHQ,                         ');
                qryChq_Terceiros.SQL.Add('       MOVBAN.CTB_CODPOR, CADCHQ.CHQ_CODBCO, CADCHQ.CHQ_CONCOR,   ');
                qryChq_Terceiros.SQL.Add('       CADCHQ.CHQ_NUMAGE, CADCHQ.CHQ_NUMCHQ, CADCHQ.CHQ_VALCHQ,   ');
                qryChq_Terceiros.SQL.Add('       CADPOR.POR_NOMPOR, CADCHQ.CHQ_NOMEMI, CADCHQ.CHQ_DTAVEN,   ');
                qryChq_Terceiros.SQL.Add('       CADCHQ.CHQ_DTAREP                                          ');
                qryChq_Terceiros.SQL.Add('FROM CADPAG                                                       ');
                qryChq_Terceiros.SQL.Add('INNER JOIN MOVBAN ON (MOVBAN.CTB_PAGCON = CADPAG.CTP_SEQCON)      ');
                qryChq_Terceiros.SQL.Add('INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = MOVBAN.CTB_CODPOR)      ');
                qryChq_Terceiros.SQL.Add('INNER JOIN BANCHQ ON (BANCHQ.CTB_SEQLAN = MOVBAN.CTB_SEQLAN)      ');
                qryChq_Terceiros.SQL.Add('INNER JOIN CADCHQ ON (CADCHQ.CHQ_CODBCO = BANCHQ.CHQ_CODBCO AND   ');
                qryChq_Terceiros.SQL.Add('                      CADCHQ.CHQ_NUMAGE = BANCHQ.CHQ_NUMAGE AND   ');
                qryChq_Terceiros.SQL.Add('                      CADCHQ.CHQ_CONCOR = BANCHQ.CHQ_CONCOR AND   ');
                qryChq_Terceiros.SQL.Add('                      CADCHQ.CHQ_NUMCHQ = BANCHQ.CHQ_NUMCHQ)      ');
                qryChq_Terceiros.SQL.Add('WHERE CADPAG.AUTOINCREM IN (' + stlAUTOINCREM.CommaText + ') AND  ');
                qryChq_Terceiros.SQL.Add('      MOVBAN.CTB_CODEMP = ' + QuotedStr(VS_strCodEmp));
                qryChq_Terceiros.SQL.Add('GROUP BY MOVBAN.CTB_CODPOR, CADCHQ.CHQ_CODBCO, CADCHQ.CHQ_CONCOR, ');
                qryChq_Terceiros.SQL.Add('         CADCHQ.CHQ_NUMAGE, CADCHQ.CHQ_NUMCHQ, CADCHQ.CHQ_VALCHQ  ');
                qryChq_Terceiros.SQL.Add('ORDER BY CADCHQ.CHQ_DTAVEN  ');

                qryChq_Terceiros.Open;

                if not qryChq_Terceiros.IsEmpty then
                begin

                  qryChq_Terceiros.First;
                  while not qryChq_Terceiros.Eof do
                  begin
                     fltVlrChqRep := fltVlrChqRep + qryChq_Terceiros.FieldByName('CHQ_VALCHQ').AsFloat;
                     qryChq_Terceiros.Next;
                  end;

                  qryChq_Terceiros.First;


                  If Assigned(frxReport.FindObject('CChequesTerceiros')) Then
                    frxReport.FindObject('CChequesTerceiros').Visible := True;
                end;

              finally

              end;

              {Dinheiro}
              strSQL := '';
              strSQL := strSQL + 'SELECT SUM(CADPAG.CTP_DINHEI) AS TOTAL, CADPAG.CTP_PORBAI, CADPOR.POR_NOMPOR ';
              strSQL := strSQL + 'FROM CADPAG ';
              strSQL := strSQL + 'INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = CADPAG.CTP_PORBAI) ';
              strSQL := strSQL + 'WHERE CADPAG.AUTOINCREM IN (' + stlAUTOINCREM.CommaText + ') AND CADPAG.CTP_EMPBAI = ' + QuotedStr(VS_strCodEmp);

              qryDinheiro := fCriaQuery(Self);

              try

                qryDinheiro.Close;
                qryDinheiro.SQL.Clear;
                qryDinheiro.SQL.Add(strSQL);
                qryDinheiro.Open;

                if (not qryDinheiro.IsEmpty) and (qryDinheiro.FieldByName('TOTAL').AsFloat > 0) then
                begin
                  If Assigned(frxReport.FindObject('CDinheiro')) Then
                    frxReport.FindObject('CDinheiro').Visible := True;
                  fltVlrDinheiro := qryDinheiro.FieldByName('TOTAL').AsFloat;

                  If Assigned(frxReport.FindObject('memVlrDinheiro')) Then
                    TfrxMemoView(frxReport.FindObject('memVlrDinheiro')).Memo.Text  := FormatFloat('#,##0.00', qryDinheiro.FieldByName('TOTAL').AsFloat);

                  If Assigned(frxReport.FindObject('memPortDinheiro')) Then
                    TfrxMemoView(frxReport.FindObject('memPortDinheiro')).Memo.Text := qryDinheiro.FieldByName('POR_NOMPOR').AsString;
                end
                else
                begin
                  If Assigned(frxReport.FindObject('CDinheiro')) Then
                    frxReport.FindObject('CDinheiro').Visible := False;
                end;

              finally
                FreeAndNil(qryDinheiro);
              end;

              {Depósito Bancário}
              strSQL := '';
              strSQL := strSQL + '  SELECT TABTEMP.*, ';
              strSQL := strSQL + '         (SELECT CADPOR.POR_NOMPOR ';
              strSQL := strSQL + '          FROM MOVBAN ';
              strSQL := strSQL + '          INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = MOVBAN.CTB_CODPOR) ';
              strSQL := strSQL + '          WHERE MOVBAN.CTB_PAGCON = TABTEMP.CTP_SEQCON AND          ';
              strSQL := strSQL + '                MOVBAN.CTB_VALLAN = TABTEMP.CTP_ORDPAG              ';
              strSQL := strSQL + '          ORDER BY MOVBAN.AUTOINCREM DESC LIMIT 1) AS POR_NOMPOR           ';
              strSQL := strSQL + '  FROM (SELECT SUM(CADPAG.CTP_ORDPAG) AS CTP_ORDPAG,           ';
              strSQL := strSQL + '               CADPAG.CTP_SEQCON                               ';
              strSQL := strSQL + '        FROM CADPAG                                            ';
              strSQL := strSQL + '        WHERE CADPAG.AUTOINCREM IN (' + stlAUTOINCREM.CommaText + ') AND ';
              strSQL := strSQL + '              CADPAG.CTP_EMPBAI = ' + QuotedStr(VS_strCodEmp);
              strSQL := strSQL + '       ) TABTEMP ';

              qryDepBancario := fCriaQuery(Self);

              try

                qryDepBancario.Close;
                qryDepBancario.SQL.Clear;
                qryDepBancario.SQL.Add(strSQL);
                qryDepBancario.Open;

                if (not qryDepBancario.IsEmpty) and (qryDepBancario.FieldByName('CTP_ORDPAG').AsFloat > 0) then
                begin
                  If Assigned(frxReport.FindObject('CDepBancario')) Then
                    frxReport.FindObject('CDepBancario').Visible      := True;
                  fltVlrDepBancario := qryDepBancario.FieldByName('CTP_ORDPAG').AsFloat;

                  If Assigned(frxReport.FindObject('memVlrDepBancario')) Then
                    TfrxMemoView(frxReport.FindObject('memVlrDepBancario')).Memo.Text  := FormatFloat('#,##0.00', qryDepBancario.FieldByName('CTP_ORDPAG').AsFloat);

                  If Assigned(frxReport.FindObject('memPortDepBancario')) Then
                    TfrxMemoView(frxReport.FindObject('memPortDepBancario')).Memo.Text := qryDepBancario.FieldByName('POR_NOMPOR').AsString;
                end;

              finally
                FreeAndNil(qryDepBancario);
              end;
            end;
              strSQL := ' ';
              strSQL := strSQL + '  SELECT D.CTP_CODEMP AS CODEMP,D.CTP_CODCTA AS CODCTA,(D.CTP_FATCAL*100) AS PORCENT, ';
              strSQL := strSQL + '  CADCTA.CTA_DESCTA AS DESCC,(P.CTP_VALORI/100*D.CTP_FATCAL*100) AS VALOR FROM CTPDET D';
              strSQL := strSQL + '  LEFT JOIN CADPAG P ON P.CTP_NUMDUP = D.CTP_NUMDUP  ';
              strSQL := strSQL + '  AND P.CTP_PARCEL = D.CTP_PARCEL ';
              strSQL := strSQL + '  AND P.CTP_CODFOR = D.CTP_CODFOR';
              strSQL := strSQL + '  AND P.CTP_SERIE_ = D.CTP_SERIE_ ';
              strSQL := strSQL + '  AND P.CTP_CODEMP = D.CTP_EMPORI ';
              strSQL := strSQL + '  LEFT JOIN CADCTA ON CTA_CODCTA = D.CTP_CODCTA  ';
              strSQL := strSQL + '  WHERE D.CTP_NUMDUP =:CTP_NUMDUP';
              strSQL := strSQL + '  AND D.CTP_PARCEL =:PARDUP' ;
              strSQL := strSQL + '  AND D.CTP_CODFOR =:CTP_CODFOR' ;
              strSQL := strSQL + '  AND D.CTP_EMPORI =:CTP_CODEMP' ;

              qryCTPDET.Close;
              qryCTPDET.MasterSource := dtsGenPag;
              qryCTPDET.SQL.Clear;
              qryCTPDET.SQL.Add(strSQL);
              qryCTPDET.Open;

              strSQL := ' ';
              strSQL := strSQL + '  SELECT MOVBAN.CTB_CODPOR,CADPOR.POR_NOMPOR,  ';
              strSQL := strSQL + '  CADPAG.CTP_CTABAI,CADCTA.CTA_DESCTA,CTB_CODPOR  ';
              strSQL := strSQL + '  FROM MOVBAN ';
              strSQL := strSQL + '  LEFT JOIN CADPAG ON CTP_SEQCON = CTB_PAGCON ';
              strSQL := strSQL + '  LEFT JOIN CADPOR ON POR_CODPOR = CTB_CODPOR ';
              strSQL := strSQL + '  LEFT JOIN CADCTA ON CTA_CODCTA = CTP_CTABAI ';
              strSQL := strSQL + '  WHERE CTB_PAGCON =:CTP_SEQCON';
              strSQL := strSQL + '  AND CTB_CODEMP =:CTP_EMPBAI';
              strSQL := strSQL + '  GROUP BY MOVBAN.CTB_CODPOR';


              qryMOVBAN.Close;
              qryMOVBAN.MasterSource := dtsGenPag;
              qryMOVBAN.SQL.Clear;
              qryMOVBAN.SQL.Add(strSQL);
              qryMOVBAN.Open;
          end
          else
            pOcultarDetalhes(True);

          {Oculta todas as bandas de detalhe (Usuário não quer visualizar os detalhes)}
          if not(blnDetalhe) and (fCfgSis('CTP_AS') = 'S') then
          begin
            If Assigned(frxReport.FindObject('CCheques')) And Assigned(frxReport.FindObject('CCabecalhoCheques')) Then
            Begin
              If frxReport.FindObject('CCheques').Visible Then
                frxReport.FindObject('CCabecalhoCheques').Visible := False
              else
                frxReport.FindObject('CCabecalhoCheques').Visible := True;
            End;

            If Assigned(frxReport.FindObject('CDDebitoConta'))Then
              frxReport.FindObject('CDDebitoConta').Visible:= True;

            If Assigned(frxReport.FindObject('CDepBancario'))Then
              frxReport.FindObject('CDepBancario').Visible:= False;

            If Assigned(frxReport.FindObject('CChequesTerceiros'))Then
              frxReport.FindObject('CChequesTerceiros').Visible := False;

            If Assigned(frxReport.FindObject('CDinheiro'))Then
              frxReport.FindObject('CDinheiro').Visible := False;
          end;

          if blnTemSeqConDif then
          begin
            if fltVlrDepBancario = 0 Then
              If Assigned(frxReport.FindObject('CDepBancario'))Then
                frxReport.FindObject('CDepBancario').Visible := False;

            If Assigned(frxReport.FindObject('CDDebitoConta'))Then
              frxReport.FindObject('CDDebitoConta').Visible  := True;
          end;

          if blnDetalhe then
          begin
            if (fltVlrDepBancario <> 0) Or
               (fltVlrChqEmi <> 0) Or
               (fltVlrDinheiro <> 0) Or
               (fltVlrChqRep <> 0) then
            begin
              If Assigned(frxReport.FindObject('CCabecalhoCheques'))Then
                frxReport.FindObject('CCabecalhoCheques').Visible := False;

              If Assigned(frxReport.FindObject('CDDebitoConta'))Then
                frxReport.FindObject('CDDebitoConta').Visible     := False;
            end;
          end;

          {Histórico}
          If Assigned(frxReport.FindObject('CHistorico'))Then
          Begin
            if FImpHis then
              frxReport.FindObject('CHistorico').Visible := True
            else
              frxReport.FindObject('CHistorico').Visible := False;
          End;

          fltVlrTotalFormasPgto := SfltValorTotal; //(fltVlrDepBancario + fltVlrChqEmi + fltVlrDinheiro + fltVlrChqRep);

          frxReport.Variables['fltVlrDepBancario']     := Quotedstr(FormatFloat('#,##0.00',fltVlrDepBancario));
          frxReport.Variables['fltVlrChqEmi']          := Quotedstr(FormatFloat('#,##0.00',fltVlrChqEmi));
          frxReport.Variables['fltVlrDinheiro']        := Quotedstr(FormatFloat('#,##0.00',fltVlrDinheiro));
          frxReport.Variables['fltVlrChqRep']          := Quotedstr(FormatFloat('#,##0.00',fltVlrChqRep));
          frxReport.Variables['fltVlrTotalFormasPgto'] := Quotedstr(FormatFloat('#,##0.00',fltVlrTotalFormasPgto));
          frxReport.Variables['blnDetalhamento']       := blnDetalhe;

          frxReport.PrepareReport;

          If strSaida = 'V' Then
          Begin
            If fInTransaction Then
            Begin
              Try
                LNomeArquivo := RetornaNomePDF;
                frxPDFExportBordero.FileName    := LNomeArquivo;
                frxPDFExportBordero.DefaultPath := RetornaCaminhoPDF;
                frxPDFExportBordero.ShowDialog  := False;
                frxReport.Export(frxPDFExportBordero);

                FCaminhoArquivoPdf := RetornaCaminhoPDF + LNomeArquivo;
              Except
                Raise
              End;
            End
            Else
              pPreviewReport('frmBaixaCtaPagar', 'Borderô para Pagamentos de Contas em Pasta PJ', frxReport)
          End
          Else
            pPrintReport('frmBaixaCtaPagar', 'Borderô para Pagamentos de Contas em Pasta PJ', strNomeFila, frxReport);

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+'.pImprimeBordero]');
          End;
        End;
      End
      Else
        Raise Exception.Create('Nenhuma informação para imprimir');
    End;

  Finally
    if Assigned(qryChq_Emi_Baixa) then
      FreeAndNil(qryChq_Emi_Baixa);
  End;

end;

procedure TfrmQckCtpBordero.pImprimeBordero(stlSeqCon: TStringList;
  strSaida: String; blnImpHis, blnReimpr, blnDetalhe, blnTemSeqConDif,
  blnDupBaixada: Boolean; out AArquivPdf: String);
begin
  FCaminhoArquivoPdf := '';

  pImprimeBordero(stlSeqCon,
                   strSaida,
                   blnImpHis,
                   blnReimpr,
                   blnDetalhe,
                   blnTemSeqConDif,
                   blnDupBaixada);

  AArquivPdf := FCaminhoArquivoPdf;
end;

procedure TfrmQckCtpBordero.pLoadReport(strTipImp: String);
Var
  FLayImp : TUniQuery;
  mmsLoad : TStream;
begin
  Try
   FLayImp := fCriaQuery(Nil);
    Try
      With FLayImp, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * FROM ');
        Add('  LAYIMP');
        Add('WHERE');
        Add('  LAY_TIPLAY = :TIPLAY AND ');
        Add('  LAY_CODEMP = :CODEMP AND ');
        Add('  LAY_CODLAY = :CODLAY     ');

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODLAY').AsString := 'BORCTP';
        ParamByName('TIPLAY').AsString := IIF(strTipImp = 'J','L','M');

        Add('ORDER BY');
        Add('  LAY_DTAALT DESC,');
        Add('  LAY_HORALT DESC ');
        Add('LIMIT 1');
        Open;

        If Not IsEmpty Then
        Begin
          mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);
          frxReport.LoadFromStream(mmsLoad);
          FreeAndNil(mmsLoad);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fLoadReport]');
      End;
    End;
  Finally
   pFreeAndNil(FLayImp);
  End;
end;

procedure TfrmQckCtpBordero.pOcultarDetalhes(blnOcular: Boolean);
begin
  If Assigned(frxReport.FindObject('memValorCabCheques'))Then
    frxReport.FindObject('memValorCabCheques').Visible  := not blnOcular;

  If Assigned(frxReport.FindObject('shpValorCabCheque'))Then
    frxReport.FindObject('shpValorCabCheque').Visible   := not blnOcular;

  If Assigned(frxReport.FindObject('memPortCabCheques'))Then
    frxReport.FindObject('memPortCabCheques').Visible   := not blnOcular;

  If Assigned(frxReport.FindObject('shpPortCabCheque'))Then
    frxReport.FindObject('shpPortCabCheque').Visible    := not blnOcular;

  If Assigned(frxReport.FindObject('memValorCabDebConta'))Then
    frxReport.FindObject('memValorCabDebConta').Visible := not blnOcular;

  If Assigned(frxReport.FindObject('shpValorCabDebConta'))Then
    frxReport.FindObject('shpValorCabDebConta').Visible := not blnOcular;

  If Assigned(frxReport.FindObject('memPortCabDebConta'))Then
    frxReport.FindObject('memPortCabDebConta').Visible  := not blnOcular;

  If Assigned(frxReport.FindObject('shpPortCabDebConta'))Then
    frxReport.FindObject('shpPortCabDebConta').Visible  := not blnOcular;

  If Assigned(frxReport.FindObject('shpValorChEmi'))Then
    frxReport.FindObject('shpValorChEmi').Visible       := not blnOcular;

  If Assigned(frxReport.FindObject('memValorChEmi'))Then
    frxReport.FindObject('memValorChEmi').Visible       := not blnOcular;

  If Assigned(frxReport.FindObject('memValorChEmi_'))Then
    frxReport.FindObject('memValorChEmi_').Visible      := not blnOcular;

  If Assigned(frxReport.FindObject('shpPortChEmi'))Then
    frxReport.FindObject('shpPortChEmi').Visible        := not blnOcular;

  If Assigned(frxReport.FindObject('memPortChEmi'))Then
    frxReport.FindObject('memPortChEmi').Visible        := not blnOcular;

  If Assigned(frxReport.FindObject('memPortChEmi_'))Then
    frxReport.FindObject('memPortChEmi_').Visible       := not blnOcular;
end;

function TfrmQckCtpBordero.fReplaceStrLOCAL(strTexto, strOLD, strNew: String): String;
begin
  Result := ReplaceStr(strTexto, strOLD, strNew);
end;

function TfrmQckCtpBordero.frxReportUserFunction(const MethodName: string; var Params: Variant): Variant;
begin

  If MethodName = 'FFORMATACPFCGCLOCAL' Then
    Result := fFormataCpfCgcLOCAL(Params[0]);

  If MethodName = 'FREPLACESTRLOCAL' Then
    Result := fReplaceStrLOCAL(Params[0], Params[1], Params[2]);

  If MethodName = 'FVERIFICACOMPONENTERELEXISTE' Then
    Result := fVerificaComponenteRelExiste(Params[0],Params[1]);

end;

function TfrmQckCtpBordero.fSqlBordero(stlSeqCon: TStringList): String;
  Var
    strSQL: String;
    intIndice: Integer;
Begin

  For intIndice := 0 To stlSeqCon.Count - 1 Do
  Begin

    strSQL := '';
    strSQL := strSQL + ' SELECT ';

    strSQL := strSQL + '   CADPAG.AUTOINCREM, ';
    strSQL := strSQL + '   CTP_CODFOR, ';
    strSQL := strSQL + '   CTP_NUMDUP AS NRODUP,     ';
    strSQL := strSQL + '   CTP_PARCEL AS PARDUP,     ';
    strSQL := strSQL + '   CTP_CODEMP, ';
    strSQL := strSQL + '   CTP_SEQBAI, ';
    strSQL := strSQL + '   CTP_SERIE_, ';

    strSQL := strSQL + '   CTP_EMPBAI, ';
    strSQL := strSQL + '   CTP_SEQCON, ';
    strSQL := strSQL + '   CTP_VALPAG, ';
    strSQL := strSQL + '   CTP_TIPDOC, ';
    strSQL := strSQL + '   CTP_DTAPAG, ';
    strSQL := strSQL + '   CTP_DTAVEN, ';
    strSQL := strSQL + '   FOR_C_G_C_, ';
    strSQL := strSQL + '   FOR_NOMFOR, ';
    strSQL := strSQL + '   EMP_NOMEMP, ';
    strSQL := strSQL + '   POR_NOMPOR, ';
    strSQL := strSQL + '   CTP_NUMDUP, ';
    strSQL := strSQL + '   CTP_PORBAI, ';
    strSQL := strSQL + '   CTP_HIST01, ';
    strSQL := strSQL + '   CTP_HIST02, ';
    strSQL := strSQL + '   CTP_HISBAI, ';
    strSQL := strSQL + '   CTP_DTABAI, ';
    strSQL := strSQL + '   CTP_CTABAI, ';
    strSQL := strSQL + '   CTA_DESCTA, ';
    strSQL := strSQL + '   CONCAT("Autorizamos ao ", POR_NOMPOR, " efetuar os pagamentos discriminados abaixo, através de:") AS CTP_MENSAG,  ';

    strSQL := strSQL + '"'+fRetornaDataBaixa(     QuotedStr(Copy(stlSeqCon[intIndice], 7, Length(stlSeqCon[intIndice]) - 6)), Copy(stlSeqCon[intIndice], 4, 3) )+'"'+' AS CTP_HORLOG, ';
    strSQL := strSQL + '"'+fRetornaHoraBaixa(     QuotedStr(Copy(stlSeqCon[intIndice], 7, Length(stlSeqCon[intIndice]) - 6)), Copy(stlSeqCon[intIndice], 4, 3) )+'"'+' AS CTP_DTALOG, ';
    strSQL := strSQL + '"'+fRetornaOperadorBaixa( QuotedStr(Copy(stlSeqCon[intIndice], 7, Length(stlSeqCon[intIndice]) - 6)), Copy(stlSeqCon[intIndice], 4, 3) )+'"'+' AS OPE_NOMOPE ';

    strSQL := strSQL + ' FROM CADPAG ';
    strSQL := strSQL + '   LEFT JOIN CADPOR ON CTP_PORBAI = POR_CODPOR ';
    strSQL := strSQL + '   LEFT JOIN CADFOR ON CTP_CODFOR = FOR_CODFOR ';
    strSQL := strSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = CTP_CTABAI ';

    If fCfgSis('BOREMP', varString) = 'S' Then
      strSQL := strSQL + '   LEFT JOIN CADEMP ON CTP_EMPBAI = EMP_CODEMP '
    else
      strSQL := strSQL + '   LEFT JOIN CADEMP ON CTP_CODEMP = EMP_CODEMP ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTP_EMPBAI = ' + QuotedStr(LeftStr(stlSeqCon[intIndice], 3)) + ' AND ';

    If Not fEmptyStr(strDtaIni) Then
      strSQL := strSQL + '  CTP_DTAPAG BETWEEN ' + QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(strDtaIni))) +' AND '+
                                                   QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(strDtaFin))) +' AND ';

    If FReimpr Then
      If (Copy(stlSeqCon[intIndice], 4, 3) <> 'XXX') Then
        strSQL := strSQL + ' CTP_CODEMP = ' + QuotedStr(Copy(stlSeqCon[intIndice], 4, 3)) + ' AND ';

    strSQL := strSQL + ' CTP_SEQCON = ' + QuotedStr(Copy(stlSeqCon[intIndice], 7, Length(stlSeqCon[intIndice]) - 6));

    If intIndice = 0 Then
      Result := strSQL
    Else
      Result := Result + ' UNION ALL ' + strSQL;
  End;

  Result := Result + ' ORDER BY CTP_EMPBAI, CTP_SEQCON, CTP_DTAVEN ';
End;

function TfrmQckCtpBordero.fVerificaComponenteRelExiste(strComponente,
                                                        strInformacao: String) : Boolean;
begin
  Result := False;
  If Assigned(frxReport.FindObject(strComponente)) Then
  Begin
    TfrxMemoView(frxReport.FindObject(strComponente)).Memo.Text := strInformacao;
    Result := True;
  End;
end;

function TfrmQckCtpBordero.fRetornaOperadorBaixa(strSeqCon, strCodEmp : String) : String;
 var
     strSQLRet  : String;
     qryRetorno : TUniQuery;
Begin

  Result := '';
  Try

    qryRetorno := fCriaQuery(Self);
    strSQLRet  := '';

    strSQLRet := 'SELECT CTP_HORLOG, CTP_DTALOG, CTP_OPEBAI, OPE_NOMOPE ';
    strSQLRet := strSQLRet + ' FROM LOGCTP ';
    strSQLRet := strSQLRet + ' LEFT JOIN CADOPE ';
    strSQLRet := strSQLRet + '   ON CADOPE.OPE_CODOPE = LOGCTP.CTP_OPEBAI ';
    strSQLRet := strSQLRet + ' WHERE CTP_SEQCON = ' + strSeqCon ;
    strSQLRet := strSQLRet + '   AND CTP_OPEBAI IS NOT NULL ';

    If FReimpr Then
       strSQLRet := strSQLRet + ' AND CTP_CODEMP = ' + QuotedStr(strCodEmp) ;

    strSQLRet := strSQLRet + '   ORDER BY CTP_DTALOG, CTP_HORLOG DESC ';
    strSQLRet := strSQLRet + '   LIMIT 1 ';

    qryRetorno.Close;
    qryRetorno.SQL.Clear;
    qryRetorno.SQL.Add(strSQLRet);
    qryRetorno.Open;

    if not qryRetorno.IsEmpty then
    begin
       Result := qryRetorno.FieldByName('OPE_NOMOPE').AsString;
    end;

  Finally
    FreeAndNil(qryRetorno);
  End;

End;

function TfrmQckCtpBordero.fRetornaDataBaixa(strSeqCon, strCodEmp : String) : String;
 var
     strSQLRet  : String;
     qryRetorno : TUniQuery;
Begin

  Result := '';
  Try
    qryRetorno := fCriaQuery(Self);
    strSQLRet  := '';

    strSQLRet := 'SELECT CTP_HORLOG, CTP_DTALOG, CTP_OPEBAI, OPE_NOMOPE ';
    strSQLRet := strSQLRet + ' FROM LOGCTP ';
    strSQLRet := strSQLRet + ' LEFT JOIN CADOPE ';
    strSQLRet := strSQLRet + '   ON CADOPE.OPE_CODOPE = LOGCTP.CTP_OPEBAI ';
    strSQLRet := strSQLRet + ' WHERE CTP_SEQCON = ' + strSeqCon ;
    strSQLRet := strSQLRet + '   AND CTP_OPEBAI IS NOT NULL ';

    If FReimpr Then
       strSQLRet := strSQLRet + ' AND CTP_CODEMP = ' + QuotedStr(strCodEmp) ;

    strSQLRet := strSQLRet + ' ORDER BY CTP_DTALOG, CTP_HORLOG DESC ';
    strSQLRet := strSQLRet + ' LIMIT 1 ';

    qryRetorno.Close;
    qryRetorno.SQL.Clear;
    qryRetorno.SQL.Add(strSQLRet);
    qryRetorno.Open;

    if not qryRetorno.IsEmpty then
    begin
       Result := qryRetorno.FieldByName('CTP_DTALOG').AsString;
    end;

  Finally
    FreeAndNil(qryRetorno);
  End;

End;


function TfrmQckCtpBordero.fRetornaHoraBaixa(strSeqCon, strCodEmp : String) : String;
 var
     strSQLRet  : String;
     qryRetorno : TUniQuery;
Begin

  Result := '';
  Try
    qryRetorno := fCriaQuery(Self);
    strSQLRet  := '';

    strSQLRet := 'SELECT CTP_HORLOG, CTP_DTALOG, CTP_OPEBAI, OPE_NOMOPE ';
    strSQLRet := strSQLRet + ' FROM LOGCTP ';
    strSQLRet := strSQLRet + ' LEFT JOIN CADOPE ';
    strSQLRet := strSQLRet + '   ON CADOPE.OPE_CODOPE = LOGCTP.CTP_OPEBAI ';
    strSQLRet := strSQLRet + ' WHERE CTP_SEQCON = ' + strSeqCon ;
    strSQLRet := strSQLRet + '   AND CTP_OPEBAI IS NOT NULL ';

    If FReimpr Then
       strSQLRet := strSQLRet + ' AND CTP_CODEMP = ' + QuotedStr(strCodEmp) ;

    strSQLRet := strSQLRet + ' ORDER BY CTP_DTALOG, CTP_HORLOG DESC ';
    strSQLRet := strSQLRet + ' LIMIT 1 ';

    qryRetorno.Close;
    qryRetorno.SQL.Clear;
    qryRetorno.SQL.Add(strSQLRet);
    qryRetorno.Open;

    if not qryRetorno.IsEmpty then
    begin
       Result := qryRetorno.FieldByName('CTP_HORLOG').AsString;
    end;
  Finally
    FreeAndNil(qryRetorno);
  End;

End;

function TfrmQckCtpBordero.RetornaCaminhoPDF: string;
var
  LCaminhoExe: string;
  LCaminhoBordero: string;
begin
  LCaminhoExe := ExtractFilePath(ParamStr(0));

  LCaminhoBordero := IncludeTrailingPathDelimiter(LCaminhoExe) + 'BORDERO';

  if not DirectoryExists(LCaminhoBordero) then
  begin
    if not CreateDir(LCaminhoBordero) then
      raise Exception.Create('Erro ao criar a pasta BORDERO em: ' + LCaminhoBordero);
  end;

  Result := IncludeTrailingPathDelimiter(LCaminhoBordero);
end;

function TfrmQckCtpBordero.RetornaNomePDF: String;
  Var
    LNomeArquivo: string;
    LDataHora: TDateTime;
Begin
  LDataHora := Trunc(VS_DATE) + Frac(fTime);;

  LNomeArquivo := Format('%s_%s_%s.pdf', [
    strLoginUsuarioLogado,
    VS_strCodEmp,
    FormatDateTime('yyyymmdd_hhnnss', LDataHora)
  ]);

  Result := LNomeArquivo;
End;

end.




