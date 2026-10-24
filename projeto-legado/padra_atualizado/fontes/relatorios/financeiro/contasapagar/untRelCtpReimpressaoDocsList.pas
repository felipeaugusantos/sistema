unit untRelCtpReimpressaoDocsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, StdCtrls, AppEvnts, Menus,
  Buttons, ExtCtrls, DB, Uni, UniClientDataSet, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, untIFuncoes, UniDataSetProvider,
  untReciboCtpMeiaFolha, untRcxRecbBaixDocs;

type
  TfrmRelCtpReimpressaoDocsList = class(TfrmPai)
    pnlFundo: TPanel;
    lblSelecione: TLabel;
    dbgDocumentos: TDBGridCitel;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnBusca: TBitBtnLocked;
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnBuscaClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
  private
    { Private declarations }
    function fImprimeReciboLayout(qryRelatorio: TUniClientDataSet; blnVideo : Boolean = False): Boolean;
    function fDocumentoJaImpresso(qryRelatorio: TUniClientDataSet): Boolean;
    procedure pSelecionaDuplicata(blnMarca : Boolean);
    procedure pBuscaDocumentos;
    procedure pMarcaDocumentos(blnMarca : Boolean);
    procedure pGravaHistImpressao(qryRelatorio: TUniClientDataSet);
  public
    { Public declarations }
    strNomeFila: String;
    strTipImp  : String;
    intQtdReg : Integer;
    qryGenCtp : TUniQuery;
    dspGenCtp : TUniDataSetProvider;
    cdsGenCtp : TUniClientDataSet;
    cdsHistImp : TUniClientDataSet;
    dtsGenCtp : TDataSource;
    function fImprimirDocumento(blnImprimeDireto: Boolean = False): Boolean;
  end;


implementation

uses untRelCtpReimpressaoBusca,untQckReimpCtaPagar, untIFastPrint, untFuncoesSimples,
     untCfgRel, untFuncoesRelatorios, untReciboCtp, untFuncoes, untTypesSistema,
     untFastPrintEditor;

{$R *.dfm}

{ TfrmRelCtpReimpressaoDocsList }

procedure TfrmRelCtpReimpressaoDocsList.btnBuscaClick(Sender: TObject);
begin
  inherited;
  pBuscaDocumentos;
end;

procedure TfrmRelCtpReimpressaoDocsList.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  fImprimirDocumento;
end;

procedure TfrmRelCtpReimpressaoDocsList.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  pMarcaDocumentos(False);
end;

procedure TfrmRelCtpReimpressaoDocsList.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  pMarcaDocumentos(True);
end;

procedure TfrmRelCtpReimpressaoDocsList.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata(IIF(cdsGenCtp.FieldByName('CTP_MARDES').AsString='M',False,True));
end;

procedure TfrmRelCtpReimpressaoDocsList.dbgDocumentosDrawColumnCell(
  Sender: TObject; const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  With cdsGenCtp Do
  Begin
    If (Not Active) Then
      Exit;

    If cdsGenCtp.FieldByName('CTP_MARDES').AsString = 'M' Then
      dbgDocumentos.Canvas.Font.Color := clBlue;
  End;
  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmRelCtpReimpressaoDocsList.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Key = VK_Return Then
  Begin
    dbgDocumentosDblClick(Sender);
  End
  Else If Key = VK_F3 Then
  Begin
    btnBusca.Click;
  End
  Else If Key = VK_F7 Then
  Begin
    btnMarcarTodas.Click;
  End
  Else If Key = VK_F8 Then
  Begin
    btnDesmarcarTodas.Click;
  End
  Else If Key = VK_F10 Then
  Begin
    btnConfirma.Click;
  End
  Else If Key = VK_Escape Then
  Begin
    btnSair.Click;
  End;
end;

function TfrmRelCtpReimpressaoDocsList.fImprimirDocumento(blnImprimeDireto: Boolean): Boolean;
  Var
    frmQckReimpCtaPagar: TfrmQckReimpCtaPagar;
    blnVideo     : Boolean;
    cdsGenCtpLst : TUniClientDataSet;
    intRecNo     : Integer;
    recValRec    : TRcxValoresReceb;
    cdsChqVis    : TUniClientDataSet;
    cdsChqPre    : TUniClientDataSet;
    arrCodCli    : Array Of TRcxDadosCliente;

  function fDocsSelecionados: Integer;
  var
    cdsAux : TUniClientDataSet;
  begin
    cdsAux      := TUniClientDataSet.Create(Self);
    cdsAux.Data := cdsGenCtp.Data;

    cdsAux.Filtered := False;
    cdsAux.Filter   := 'CTP_MARDES = ''M''';
    cdsAux.Filtered := True;

    Result := cdsAux.RecordCount;

    FreeAndNil(cdsAux);
  end;
begin
  Result    := True;
  blnVideo  := False;

  If blnImprimeDireto Then
  Begin
    dtsGenCtp := fCriaDataSource(cdsGenCtp);
    cdsGenCtp.Open;
    dbgDocumentos.DataSource := dtsGenCtp;
    cdsGenCtp.SetProvider(nil);
  End;

  If (Not blnImprimeDireto) And (fDocsSelecionados = 0) Then
  Begin
    fMensagem('','Selecione um ou mais documentos para reimpressão!',['&O K']);
    Exit;
  End;

  cdsGenCtpLst := TUniClientDataSet.Create(Self);
  cdsGenCtpLst.Data := cdsGenCtp.Data;

  {********************************************************}
  {* ESSE DATASET SERÁ USADO PARA CONTROLAR OS DOCUMENTOS *}
  {* JÁ IMPRESSOS POIS O USUÁRIO PODE TER SELECIONADO     *}
  {* VÁRIAS DUPLICATAS QUE TENHAM SIDO BAIXADAS JUNTAS    *}
  {* PELO MESMO SEQCON E NESSE CASO ESSAS DUPS SAEM       *}
  {* NO MESMO RECIBO                                      *}
  {****************************************************JS**}
  cdsHistImp  := fCriaClientDatasetReciboCTP;
  cdsHistImp.Open;

  If blnImprimeDireto Or (fMensagem('','Deseja Reimprimir os documentos selecionados?', ['&Sim', '&Não'], 2) = 1) Then
  Begin
    If blnImprimeDireto Or (fDocsSelecionados = 1) Then
      blnVideo := fMensagem('','Opção:',['&Vídeo','&Impressora'])= 1;

    If Not blnVideo Then
    Begin
      pCarregaConfImpr(qryCfgRel, 'frmRelCtpReimpressaoDocsList');
      fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
    End;

    intRecNo := cdsGenCtp.RecNo;
    cdsGenCtp.DisableControls;
    cdsGenCtp.First;

    pCriarFormularios(TfrmQckReimpCtaPagar, frmQckReimpCtaPagar);

    If Not blnImprimeDireto Then
      frmQckReimpCtaPagar.frxReciboM.AddFunction('procedure pDecrementaQtdReg');

    While Not cdsGenCtp.Eof Do
    Begin
      If blnImprimeDireto Or
         ((cdsGenCtp.FieldByName('CTP_MARDES').AsString = 'M') And
         (Not fDocumentoJaImpresso(cdsGenCtp)))                Then
      Begin
        With cdsGenCtpLst Do
        Begin
          Try
            Filter   := 'CTP_CODFOR = ' + QuotedStr(cdsGenCtp.FieldByName('CTP_CODFOR').AsString) + ' AND ' +
                        'SEQCON = ' + QuotedStr(cdsGenCtp.FieldByName('SEQCON').AsString) + ' AND ' +
                        'EMPBAI = ' + QuotedStr(cdsGenCtp.FieldByName('EMPBAI').AsString);

            Filtered := True;

            If (Not fImprimeReciboLayout(cdsGenCtpLst,blnVideo)) Then
            Begin
              Try

                If (cdsGenCtpLst.FieldByName('CTP_RESCAI').AsString = '1') Then
                Begin

                  recValRec.strDinRec := FormatFloat('#,##0.00', cdsGenCtpLst.FieldByName('VALREC').AsFloat);
                  recValRec.strCarRec := '0,00';
                  recValRec.strChqPre := '0,00';
                  recValRec.strChqVis := '0,00';
                  recValRec.strOrdRec := '0,00';
                  recValRec.strCreRec := '0,00';

                  cdsChqVis    := fCriaCdsCheques(Self);
                  cdsChqPre    := fCriaCdsCheques(Self);

                  pImpRecBaiDoc(cdsGenCtpLst,
                                'L',
                                cdsGenCtpLst.FieldByName('CTP_RCXCON').AsInteger,
                                strLoginUsuarioLogado,
                                arrCodCli,
                                recValRec,
                                cdsChqPre,
                                cdsChqVis,
                                'frmRelCtpReimpressaoDocsList',
                                strNomeFila,
                                strTipImp,
                                fCfgSis('RECRCX') = 'B',
                                'PG',
                                cdsGenCtpLst.FieldByName('CTP_CODCTA').asString,
                                '',
                                True,
                                '',
                                '',
                                blnVideo);
                End
                Else
                Begin

                  If Not blnImprimeDireto Then
                  Begin
                    frmQckReimpCtaPagar.intQtdReg := intQtdReg;
                    frmQckReimpCtaPagar.strTipImp := strTipImp;
                  End;

                  frmQckReimpCtaPagar.pImprimeRecibo(blnVideo,
                                                     TCfgRel.VS_blnDlgPri,
                                                     'frmRelCtpReimpressaoDocsList',
                                                     strTipImp,
                                                     strNomeFila,
                                                     cdsGenCtpLst.FieldByName('SEQCON').AsString,
                                                     cdsGenCtpLst);
                End;
              Except
                On E: Exception Do
                  pMensagensErro(E.Message, '[frmRelCtpReimpressaoDocsList.dbgDocumentosDblClick]');
              End;

            End;

          Finally
            Filtered := False;
          End;

        End;
      End;
      cdsGenCtp.Next;
    End;
    pDestroiModulo(frmQckReimpCtaPagar);
    cdsGenCtp.RecNo := intRecNo;
    cdsGenCtp.EnableControls;
  End;

  FreeAndNil(cdsGenCtpLst);
  FreeAndNil(cdsHistImp);
end;

procedure TfrmRelCtpReimpressaoDocsList.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsGenCtp);
end;

procedure TfrmRelCtpReimpressaoDocsList.FormShow(Sender: TObject);
begin
  inherited;

  dtsGenCtp := fCriaDataSource(cdsGenCtp);
  cdsGenCtp.Open;
  dbgDocumentos.DataSource := dtsGenCtp;
  cdsGenCtp.SetProvider(nil);

  TFloatField(cdsGenCtp.FieldByName('CTP_VALPAG')).DisplayFormat := '#,##0.00';

  pSetFocus(dbgDocumentos);
end;

function TfrmRelCtpReimpressaoDocsList.fDocumentoJaImpresso(
  qryRelatorio: TUniClientDataSet): Boolean;
begin
  With cdsHistImp Do
  Begin
    Filtered := False;
    Filter   := 'CTP_CODFOR = ' + QuotedStr(qryRelatorio.FieldByName('CTP_CODFOR').AsString) + ' AND ' +
                'NRODUP = '     + QuotedStr(qryRelatorio.FieldByName('CTP_NUMDUP').AsString) + ' AND ' +
                'PARDUP = '     + QuotedStr(qryRelatorio.FieldByName('CTP_PARCEL').AsString) + ' AND ' +
                'CTP_CODEMP = ' + QuotedStr(qryRelatorio.FieldByName('CTP_CODEMP').AsString) + ' AND ' +
                'CTP_SERIE_ = ' + QuotedStr(qryRelatorio.FieldByName('CTP_SERIE_').AsString);
    Filtered := True;

    Result := RecordCount > 0;

    Filtered := False;
    Filter := '';
  End;
end;

function TfrmRelCtpReimpressaoDocsList.fImprimeReciboLayout(qryRelatorio : TUniClientDataSet; blnVideo : Boolean = False): Boolean;
var
  dblDinheiro, dblChequeVista, dblChequeRepasse, dblDeposito: Double;
  qryChq_Emi_Baixa, qryChq_Rep_Baixa: TUniQuery;

  function fRetDataEmissaoCheque(strNumChq, strCodBco, strNumAge, strConCor : String) : String;
  var
    qryChqEmi : TUniQuery;
    strSQL    : String;
  begin

    Result := '';

    if (strNumChq <> '') and
       (strCodBco <> '') and
       (strNumAge <> '') and
       (strConCor <> '') then
    begin

      strSQL := 'SELECT EMI_BOMPAR, EMI_DTAEMI FROM CHQEMI WHERE ';
      strSQL := strSQL + 'EMI_NUMCHQ = ' + QuotedStr(strNumChq) + ' AND ';
      strSQL := strSQL + 'EMI_CODBCO = ' + QuotedStr(strCodBco) + ' AND ';
      strSQL := strSQL + 'EMI_NUMAGE = ' + QuotedStr(strNumAge) + ' AND ';
      strSQL := strSQL + 'EMI_CONCOR = ' + QuotedStr(strConCor);

      qryChqEmi := fCriaQuery(Self);

      try

        qryChqEmi.Close;
        qryChqEmi.SQL.Clear;
        qryChqEmi.SQL.Add(strSQL);
        qryChqEmi.Open;

        if not qryChqEmi.IsEmpty then
        begin
          if not qryChqEmi.FieldByName('EMI_BOMPAR').isNull then
            Result := qryChqEmi.FieldByName('EMI_BOMPAR').asString+'|'+qryChqEmi.FieldByName('EMI_DTAEMI').AsString
          else
            Result := qryChqEmi.FieldByName('EMI_DTAEMI').AsString

        end;

      finally
        FreeAndNil(qryChqEmi);
      end;

    end;

  end;

  function fRetListPortadores(blnAddInfoCheques : Boolean) : String;
    Var
      qryMovBan, qryBanChq : TUniQuery;
      strDadosChq : String;
      intPosPipe: integer;
      strDatas: string;

      LDataMovBan: TDateTime;
  Begin
    qryMovBan := fCriaQuery;

    With qryMovBan Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CTB_CODPOR, POR_NOMPOR, CTB_VALLAN, CTB_SEQLAN, CTB_DTALAN ');
      SQL.Add('   FROM MOVBAN ');
      SQL.Add('  INNER JOIN CADPOR ON POR_CODPOR = CTB_CODPOR ');
      SQL.Add('  WHERE CTB_PAGCON = :PAGCON ');
      SQL.Add('    AND CTB_CODEMP = :CODEMP ');
      SQL.Add('    AND CTB_DTALAN >= :DTALAN ');
      ParamByName('PAGCON').AsString := qryRelatorio.FieldByName('SEQCON').AsString;
      ParamByName('CODEMP').AsString := qryRelatorio.FieldByName('EMPBAI').AsString;
      ParamByName('DTALAN').AsDateTime := qryRelatorio.FieldByName('DTAPAG').AsDateTime;
      Open;

      Result := '';

      First;
      LDataMovBan := 0;
      While Not Eof Do
      Begin
        If LDataMovBan = 0 Then
          LDataMovBan := FieldByName('CTB_DTALAN').AsDateTime
        Else
        Begin
          If LDataMovBan <> FieldByName('CTB_DTALAN').AsDateTime Then
          Begin
            Next;

            Continue;
          End;
        End;

        Result := Result + FieldByName('CTB_CODPOR').AsString + '-' + fPadR(FieldByName('POR_NOMPOR').AsString,69) +
                fPadL(FloatToStrF(FieldByName('CTB_VALLAN').AsFloat, ffFixed, 12, 2), 10) + #13#10;

        {Identifica dados do cheque!}
        if (blnAddInfoCheques) then
        begin

          strDadosChq := '';

          if (FieldByName('CTB_SEQLAN').AsString <> '') then
          begin

            try

              qryBanChq := fCriaQuery;

              qryBanChq.Close;
              qryBanChq.SQL.Clear;
              qryBanChq.SQL.Add('SELECT * FROM BANCHQ WHERE CTB_SEQLAN = ' + QuotedStr(FieldByName('CTB_SEQLAN').AsString));
              qryBanChq.Open;

              if not qryBanChq.IsEmpty then
              begin
                strDatas   := fRetDataEmissaoCheque(qryBanChq.FieldByName('CHQ_NUMCHQ').AsString,
                                                    qryBanChq.FieldByName('CHQ_CODBCO').AsString,
                                                    qryBanChq.FieldByName('CHQ_NUMAGE').AsString,
                                                    qryBanChq.FieldByName('CHQ_CONCOR').AsString);
                intPosPipe := Pos('|', strDatas);

                strDadosChq := 'Chq: '      + qryBanChq.FieldByName('CHQ_NUMCHQ').AsString + ' ' +
                               'Bco: '      + qryBanChq.FieldByName('CHQ_CODBCO').AsString +
                               ' AG: '      + qryBanChq.FieldByName('CHQ_NUMAGE').AsString +
                               ' CC: '      + qryBanChq.FieldByName('CHQ_CONCOR').AsString +
                               IIF( intPosPipe > 0, ' Vcto: ' + Copy( strDatas, 1, intPosPipe-1 )+' '+
                                                    ' Emit: ' + Copy( strDatas, intPosPipe+1, intPosPipe ),
                                                    ' Emit: ' + strDatas);

              end;

              if (strDadosChq <> '') then
                Result := Result + fPadR(strDadosChq, 85) + #13#10;

            finally
              FreeAndNil(qryBanChq);
            end;

          end;

        end;

        Next;

      End;

      Close;
    End;

    FreeAndNil(qryMovBan);
  End;

  function fRetListFormasPagto(out dinheiro, chequeVista, chequeRepasse, deposito: Double) : String;
  begin

    Result := '';

    If (fFormataFloat(qryRelatorio.FieldByName('CTP_DINHEI').AsFloat, 2) <> 0.00) Then
    begin
      dinheiro := dinheiro + qryRelatorio.FieldByName('CTP_DINHEI').AsFloat;
      Result := Result + fPadL('DINHEIRO', 23) + ' - ' + fPadL(FormatFloat('#,##0.00', dinheiro), 14) + #13#10;
    end;

    If (fFormataFloat(qryRelatorio.FieldByName('CTP_CHQAVI').AsFloat, 2) <> 0.00) Then
    begin
      chequeVista := chequeVista + qryRelatorio.FieldByName('CTP_CHQAVI').AsFloat;
      Result := Result + fPadL('CHEQUE EMITIDO', 23) + ' - ' + fPadL(FormatFloat('#,##0.00', chequeVista), 14) + #13#10;
    end;

    If (fFormataFloat(qryRelatorio.FieldByName('CTP_ORDPAG').AsFloat, 2) <> 0.00) Then
    begin
      deposito := deposito + qryRelatorio.FieldByName('CTP_ORDPAG').AsFloat;
      Result := Result + fPadL('DEPÓSITO BANCÁRIO', 23) + ' - ' + fPadL(FormatFloat('#,##0.00', deposito), 14) + #13#10;
    end;

    If (fFormataFloat(qryRelatorio.FieldByName('CTP_REPCHQ').AsFloat, 2) <> 0.00) Then
    begin
      chequeRepasse := chequeRepasse + qryRelatorio.FieldByName('CTP_REPCHQ').AsFloat;
      Result := Result + fPadL('CHEQUE DE TERCEIROS', 23) + ' - ' + fPadL(FormatFloat('#,##0.00', chequeRepasse), 14) + #13#10;
    end;

  end;

  function fRetChequesEmi: TStringList;
  begin
    result := tstringlist.create;
    if not qryChq_Emi_Baixa.isEmpty then
    begin
      result.Add(qryChq_Emi_Baixa.fieldbyname('CTB_CODPOR').asstring);
      result.Add(qryChq_Emi_Baixa.fieldbyname('POR_NOMPOR').asstring);
      result.Add(qryChq_Emi_Baixa.fieldbyname('EMI_CODBCO').asstring);
      result.Add(qryChq_Emi_Baixa.fieldbyname('EMI_CONCOR').asstring);
      result.Add(qryChq_Emi_Baixa.fieldbyname('EMI_NUMAGE').asstring);
      result.Add(qryChq_Emi_Baixa.fieldbyname('EMI_NUMCHQ').asstring);
      result.Add(qryChq_Emi_Baixa.fieldbyname('CHQ_VALCHQ').asstring);
    end
    else
    begin
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('0');
    end;
  end;

  function fRetChequesRep: TStringList;
  begin
    result := tstringlist.create;
    if not qryChq_Rep_Baixa.isEmpty then
    begin
      result.Add(qryChq_Rep_Baixa.fieldbyname('CTB_CODPOR').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('POR_NOMPOR').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_CODBCO').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_CONCOR').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_NUMAGE').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_NUMCHQ').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_VALCHQ').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_NOMEMI').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_DTAVEN').asstring);
      result.Add(qryChq_Rep_Baixa.fieldbyname('CHQ_DTAREP').asstring);
    end
    else
    begin
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('');
      result.Add('0');
      result.Add('');
      result.Add('');
      result.Add('');
    end;
  end;
  Var
    cdsAux     : TUniClientDataSet;
    editorFast : IFastPrintFileEditor;
    objEditor  : TObject;
    reciboCtp  : IFastPrintFile;
    reciboCtpMeiaFolha : IFastPrintFile;
    strSQL     : string;
    tslChqEmi  : TStringList;
    tslChqRep  : TStringList;
    intQtdVias : Integer;
    intContVia : Integer;
Begin

  intQtdVias := 1;
  If (fCfgSis('RECCTP') = 'S') And (fCfgSis('RECCPV', varInteger) > 1) Then
  Begin
    cdsAux  := fCriaClientDatasetReciboCTP_MF;
    intQtdVias := fCfgSis('RECCPV', varInteger);

    If (intQtdvias <= 0) Then
      intQtdVias := 1;
  End
  Else
    cdsAux  := fCriaClientDatasetReciboCTP;

  qryChq_Emi_Baixa := fCriaQuery;
  qryChq_Rep_Baixa := fCriaQuery;

  For intContVia := 1 To intQtdVias Do //MF: 294776 - 30/08/23
  Begin
    {Variáveis utilizadas para totalização geral,
     quando mais de um título selecionado para impressão!}
    dblDinheiro      := 0;
    dblDeposito      := 0;
    dblChequeVista   := 0;
    dblChequeRepasse := 0;

    qryRelatorio.First;
    While Not qryRelatorio.Eof Do
    Begin

      cdsAux.Append;
      cdsAux.FieldByName('CTP_NUMDUP').AsString   := qryRelatorio.FieldByName('NUMDUP').AsString;
      cdsAux.FieldByName('NRODUP').AsString       := qryRelatorio.FieldByName('CTP_NUMDUP').AsString;
      cdsAux.FieldByName('CTP_CODEMP').AsString   := qryRelatorio.FieldByName('CTP_CODEMP').AsString;
      cdsAux.FieldByName('CTP_USACHQ').AsString   := qryRelatorio.FieldByName('CTP_USACHQ').AsString;
      cdsAux.FieldByName('CTP_CODEVE').AsString   := qryRelatorio.FieldByName('CTP_CODEVE').AsString;
      cdsAux.FieldByName('CTP_NOMEVE').AsString   := qryRelatorio.FieldByName('CTP_CODEVE').AsString + ' - ' + fRetNomEvento(qryRelatorio.FieldByName('CTP_CODEVE').AsString);
      cdsAux.FieldByName('CTP_NOMCTA').AsString   := qryRelatorio.FieldByName('CTP_CODCTA').AsString + ' - ' + fRetDescCentroCusto(qryRelatorio.FieldByName('CTP_CODCTA').AsString);
      cdsAux.FieldByName('CTP_CTABAI').AsString   := qryRelatorio.FieldByName('CTP_CTABAI').AsString + ' - ' + fRetDescCentroCusto(qryRelatorio.FieldByName('CTP_CTABAI').AsString);
      cdsAux.FieldByName('CTP_PORBAI').AsString   := qryRelatorio.FieldByName('CTP_PORBAI').AsString;
      cdsAux.FieldByName('CTP_SERIE_').AsString   := qryRelatorio.FieldByName('CTP_SERIE_').AsString;
      cdsAux.FieldByName('CTP_VALJUR').AsFloat    := qryRelatorio.FieldByName('CTP_VALJUR').AsFloat;
      cdsAux.FieldByName('CTP_VALDES').AsFloat    := qryRelatorio.FieldByName('CTP_VALDES').AsFloat;
      cdsAux.FieldByName('CTP_VALDUP').AsFloat    := qryRelatorio.FieldByName('CTP_VALDUP').AsFloat;
      cdsAux.FieldByName('CTP_VALPAG').AsFloat    := qryRelatorio.FieldByName('CTP_VALPAG').AsFloat;
      cdsAux.FieldByName('CTP_VALORI').AsFloat    := qryRelatorio.FieldByName('CTP_VALORI').AsFloat;
      cdsAux.FieldByName('CTP_TIPDOC').AsFloat    := qryRelatorio.FieldByName('CTP_TIPDOC').AsFloat;
      cdsAux.FieldByName('CTP_DESSUJ').AsFloat    := qryRelatorio.FieldByName('CTP_DESSUJ').AsFloat;
      cdsAux.FieldByName('CTP_JURSUJ').AsFloat    := qryRelatorio.FieldByName('CTP_JURSUJ').AsFloat;
      cdsAux.FieldByName('CTP_VENDOR').AsFloat    := qryRelatorio.FieldByName('CTP_VENDOR').AsFloat;
      cdsAux.FieldByName('TOTDUP').AsFloat        := qryRelatorio.FieldByName('TOTDUP').AsFloat;
      cdsAux.FieldByName('CTP_CODFOR').AsString   := qryRelatorio.FieldByName('CTP_CODFOR').AsString;
      cdsAux.FieldByName('FOR_NOMFOR').AsString   := qryRelatorio.FieldByName('FOR_NOMFOR').AsString;
      cdsAux.FieldByName('CTP_NOMFOR').AsString   := qryRelatorio.FieldByName('CTP_NOMFOR').AsString;
      cdsAux.FieldByName('EVE_DESEVE').AsString   := qryRelatorio.FieldByName('EVE_DESEVE').AsString;
      cdsAux.FieldByName('CTP_CODCTA').AsString   := qryRelatorio.FieldByName('CTP_CODCTA').AsString;
      cdsAux.FieldByName('CTP_DTAVEN').AsDateTime := qryRelatorio.FieldByName('CTP_DTAVEN').AsDateTime;
      cdsAux.FieldByName('CTP_DTAPAG').AsDateTime := qryRelatorio.FieldByName('DTAPAG').AsDateTime;
      cdsAux.FieldByName('CTP_DTACAD').AsDateTime := qryRelatorio.FieldByName('CTP_DTACAD').AsDateTime;
      cdsAux.FieldByName('CTA_DESCTA').AsString   := qryRelatorio.FieldByName('CTA_DESCTA').AsString;
      cdsAux.FieldByName('CTP_HIST01').AsString   := qryRelatorio.FieldByName('CTP_HIST01').AsString;
      cdsAux.FieldByName('CTP_DESCRI').AsString   := qryRelatorio.FieldByName('CTP_HIST01').AsString;
      cdsAux.FieldByName('CTP_HIST02').AsString   := qryRelatorio.FieldByName('CTP_HIST02').AsString;
      cdsAux.FieldByName('FOR_FONE01').AsString   := qryRelatorio.FieldByName('FOR_FONE01').AsString;
      cdsAux.FieldByName('FOR_F_A_X_').AsString   := qryRelatorio.FieldByName('FOR_F_A_X_').AsString;
      cdsAux.FieldByName('FOR_C_G_C_').AsString   := qryRelatorio.FieldByName('FOR_C_G_C_').AsString;
      cdsAux.FieldByName('CTP_CODVEL').AsString   := qryRelatorio.FieldByName('CTP_CODVEL').AsString;
      cdsAux.FieldByName('CTP_PREVIS').AsString   := qryRelatorio.FieldByName('CTP_PREVIS').AsString;
      cdsAux.FieldByName('CTP_VEIOBO').AsString   := qryRelatorio.FieldByName('CTP_VEIOBO').AsString;
      cdsAux.FieldByName('CTP_MARDES').AsString   := '';
      cdsAux.FieldByName('CTP_TIPBAI').AsString   := '';
      cdsAux.FieldByName('CTP_TIPDES').AsString   := '';
      cdsAux.FieldByName('EMP_NOMEMP').AsString   := qryRelatorio.FieldByName('EMP_NOMEMP').AsString;
      cdsAux.FieldByName('POR_NOMPOR').AsString   := qryRelatorio.FieldByName('POR_NOMPOR').AsString;

      cdsAux.FieldByName('POR_LISTAR').Text       := fRetListPortadores(False);

      cdsAux.FieldByName('RCX_CAIXA').AsString   := qryRelatorio.FieldByName('RCX_CODCAX').AsString;

      {Este campo apresenta as informações do cheque Banco-Agência-Conta-Data de Emissão}
      cdsAux.FieldByName('POR_LISTAR2').Text      := fRetListPortadores(True);

      cdsAux.FieldByName('CTP_HISBAI').AsString   := qryRelatorio.FieldByName('CTP_HISBAI').AsString;
      cdsAux.FieldByName('CTP_FORMAS').Text       := fRetListFormasPagto(dblDinheiro, dblChequeVista, dblChequeRepasse, dblDeposito);

      cdsAux.FieldByName('CTP_CHQAVI').AsFloat    := qryRelatorio.FieldByName('CTP_CHQAVI').AsFloat;
      cdsAux.FieldByName('CTP_DINHEI').AsFloat    := qryRelatorio.FieldByName('CTP_DINHEI').AsFloat;
      cdsAux.FieldByName('CTP_ORDPAG').AsFloat    := qryRelatorio.FieldByName('CTP_ORDPAG').AsFloat;
      cdsAux.FieldByName('CTP_REPCHQ').AsFloat    := qryRelatorio.FieldByName('CTP_REPCHQ').AsFloat;

      strSQL := '';
      strSQL := strSQL + 'SELECT MOVBAN.CTB_CODPOR, CHQEMI.EMI_CODBCO, CHQEMI.EMI_CONCOR,   ';
      strSQL := strSQL + '       CHQEMI.EMI_NUMAGE, CHQEMI.EMI_NUMCHQ, BANCHQ.CHQ_VALCHQ,   ';
      strSQL := strSQL + '       CADPOR.POR_NOMPOR                                          ';
      strSQL := strSQL + 'FROM CADPAG                                                       ';
      strSQL := strSQL + 'INNER JOIN MOVBAN ON (MOVBAN.CTB_PAGCON = CADPAG.CTP_SEQCON)      ';
      strSQL := strSQL + 'INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = MOVBAN.CTB_CODPOR)      ';
      strSQL := strSQL + 'INNER JOIN BANCHQ ON (BANCHQ.CTB_SEQLAN = MOVBAN.CTB_SEQLAN)      ';
      strSQL := strSQL + 'INNER JOIN CHQEMI ON (CHQEMI.EMI_CODBCO = BANCHQ.CHQ_CODBCO AND   ';
      strSQL := strSQL + '                      CHQEMI.EMI_NUMAGE = BANCHQ.CHQ_NUMAGE AND   ';
      strSQL := strSQL + '                      CHQEMI.EMI_CONCOR = BANCHQ.CHQ_CONCOR AND   ';
      strSQL := strSQL + '                      CHQEMI.EMI_NUMCHQ = BANCHQ.CHQ_NUMCHQ)      ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  MOVBAN.CTB_CODEMP = ' + QuotedStr(VS_strCodEmp)+' AND ';
      strSQL := strSQL + '  CADPAG.CTP_NUMDUP = '+QuotedStr(qryRelatorio.FieldByName('CTP_NUMDUP').AsString)    +' AND ';
      strSQL := strSQL + '  CADPAG.CTP_PARCEL = '+QuotedStr(qryRelatorio.FieldByName('CTP_PARCEL').AsString)    +' AND ';
      strSQL := strSQL + '  CADPAG.CTP_CODEMP = '+QuotedStr(VS_strCodEmp)+' AND ';
      strSQL := strSQL + '  CADPAG.CTP_CODFOR = '+QuotedStr(qryRelatorio.FieldByName('CTP_CODFOR').AsString)+' AND ';
      if fEmptyStr(qryRelatorio.FieldByName('CTP_SERIE_').AsString) then
        strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
      Else
        strSQL := strSQL + '  CTP_SERIE_ = '+QuotedStr(qryRelatorio.FieldByName('CTP_SERIE_').AsString)+' ';
      strSQL := strSQL + 'GROUP BY MOVBAN.CTB_CODPOR, CHQEMI.EMI_CODBCO, CHQEMI.EMI_CONCOR, ';
      strSQL := strSQL + '         CHQEMI.EMI_NUMAGE, CHQEMI.EMI_NUMCHQ, BANCHQ.CHQ_VALCHQ  ';


      qryChq_Emi_Baixa.Close;
      qryChq_Emi_Baixa.sql.clear;
      qryChq_Emi_Baixa.sql.Add(strSQL);
      qryChq_Emi_Baixa.open;

      tslChqEmi := fRetChequesEmi;

      cdsAux.FieldByName('CTB_CODPOR').AsString := tslChqEmi.Strings[0];
      cdsAux.FieldByName('EMI_NOMPOR').AsString := tslChqEmi.Strings[1];
      cdsAux.FieldByName('EMI_CODBCO').AsString := tslChqEmi.Strings[2];
      cdsAux.FieldByName('EMI_CONCOR').AsString := tslChqEmi.Strings[3];
      cdsAux.FieldByName('EMI_NUMAGE').AsString := tslChqEmi.Strings[4];
      cdsAux.FieldByName('EMI_NUMCHQ').AsString := tslChqEmi.Strings[5];
      cdsAux.FieldByName('EMI_VALCHQ').AsFloat  := fStrToFloat(tslChqEmi.Strings[6]);

      qryChq_Rep_Baixa.Close;
      qryChq_Rep_Baixa.sql.clear;
      qryChq_Rep_Baixa.sql.Add(strSQL);
      qryChq_Rep_Baixa.open;

      strSQL := 'SELECT MOVBAN.CTB_CODPOR, CADCHQ.CHQ_CODBCO, CADCHQ.CHQ_CONCOR,   ';
      strSQL := strSQL + '       CADCHQ.CHQ_NUMAGE, CADCHQ.CHQ_NUMCHQ, CADCHQ.CHQ_VALCHQ,   ';
      strSQL := strSQL + '       CADPOR.POR_NOMPOR, CADCHQ.CHQ_NOMEMI, CADCHQ.CHQ_DTAVEN,   ';
      strSQL := strSQL + '       CADCHQ.CHQ_DTAREP                                          ';
      strSQL := strSQL + 'FROM CADPAG                                                       ';
      strSQL := strSQL + 'INNER JOIN MOVBAN ON (MOVBAN.CTB_PAGCON = CADPAG.CTP_SEQCON)      ';
      strSQL := strSQL + 'INNER JOIN CADPOR ON (CADPOR.POR_CODPOR = MOVBAN.CTB_CODPOR)      ';
      strSQL := strSQL + 'INNER JOIN BANCHQ ON (BANCHQ.CTB_SEQLAN = MOVBAN.CTB_SEQLAN)      ';
      strSQL := strSQL + 'INNER JOIN CADCHQ ON (CADCHQ.CHQ_CODBCO = BANCHQ.CHQ_CODBCO AND   ';
      strSQL := strSQL + '                      CADCHQ.CHQ_NUMAGE = BANCHQ.CHQ_NUMAGE AND   ';
      strSQL := strSQL + '                      CADCHQ.CHQ_CONCOR = BANCHQ.CHQ_CONCOR AND   ';
      strSQL := strSQL + '                      CADCHQ.CHQ_NUMCHQ = BANCHQ.CHQ_NUMCHQ)      ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '      MOVBAN.CTB_CODEMP = ' + QuotedStr(VS_strCodEmp)+' AND ';
      strSQL := strSQL + '  CADPAG.CTP_NUMDUP = '+QuotedStr(qryRelatorio.FieldByName('CTP_NUMDUP').AsString)    +' AND ';
      strSQL := strSQL + '  CADPAG.CTP_PARCEL = '+QuotedStr(qryRelatorio.FieldByName('CTP_PARCEL').AsString)    +' AND ';
      strSQL := strSQL + '  CADPAG.CTP_CODEMP = '+QuotedStr(VS_strCodEmp)+' AND ';
      strSQL := strSQL + '  CADPAG.CTP_CODFOR = '+QuotedStr(qryRelatorio.FieldByName('CTP_CODFOR').AsString)+' AND ';
      if fEmptyStr(qryRelatorio.FieldByName('CTP_SERIE_').AsString) then
        strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
      Else
        strSQL := strSQL + '  CTP_SERIE_ = '+QuotedStr(qryRelatorio.FieldByName('CTP_SERIE_').AsString)+' ';
      strSQL := strSQL + 'GROUP BY MOVBAN.CTB_CODPOR, CADCHQ.CHQ_CODBCO, CADCHQ.CHQ_CONCOR, ';
      strSQL := strSQL + '         CADCHQ.CHQ_NUMAGE, CADCHQ.CHQ_NUMCHQ, CADCHQ.CHQ_VALCHQ  ';


      qryChq_Rep_Baixa.Close;
      qryChq_Rep_Baixa.sql.clear;
      qryChq_Rep_Baixa.sql.Add(strSQL);
      qryChq_Rep_Baixa.open;

      tslChqRep := fRetChequesRep;

      cdsAux.FieldByName('CTB_CODPOR').AsString   := tslChqRep.Strings[0];
      cdsAux.FieldByName('CHQ_NOMPOR').AsString   := tslChqRep.Strings[1];
      cdsAux.FieldByName('CHQ_CODBCO').AsString   := tslChqRep.Strings[2];
      cdsAux.FieldByName('CHQ_CONCOR').AsString   := tslChqRep.Strings[3];
      cdsAux.FieldByName('CHQ_NUMAGE').AsString   := tslChqRep.Strings[4];
      cdsAux.FieldByName('CHQ_NUMCHQ').AsString   := tslChqRep.Strings[5];
      cdsAux.FieldByName('CHQ_VALCHQ').AsFloat    := fStrToFloat(tslChqRep.Strings[6]);
      cdsAux.FieldByName('CHQ_NOMEMI').AsString   := tslChqRep.Strings[7];
      if tslChqRep.Strings[8] <> '' then
        cdsAux.FieldByName('CHQ_DTAVEN').AsDateTime := strtodatedef(tslChqRep.Strings[8],0);
      if tslChqRep.Strings[9] <> '' then
        cdsAux.FieldByName('CHQ_DTAREP').AsDateTime := strtodatedef(tslChqRep.Strings[9],0);

      If (fCfgSis('RECCTP') = 'S') And (fCfgSis('RECCPV', varInteger) > 1) Then
      Begin
        cdsAux.FieldByName('CTP_VIAIMP').AsInteger := intContVia;
        cdsAux.FieldByName('CTP_QTVIAS').AsInteger := intQtdVias;
      End;

      cdsAux.Post;

      pGravaHistImpressao(qryRelatorio);

      qryRelatorio.Next;

    End;
  End;
  {Devido à falhas em impressões "seguidas" causadas por "lixo" em memória,
   implementamos o método fGetObjFastPrintFileEditor, para forçar a destruição de
   seus antecedentes, implementados em interface.}
  objEditor := TFastPrintFileEditor.Create(nil);
  Result    := False;

  try

    if Supports(objEditor, IFastPrintFileEditor, editorFast) then
    begin

      If (fCfgSis('RECCTP') = 'S') And (fCfgSis('RECCPV', varInteger) > 1) Then
      Begin
        reciboCtpMeiaFolha  := TReciboCtpMeiaFolha.CreateInstance(cdsAux);
        editorFast.pSetFastPrintFile(reciboCtpMeiaFolha);
      End
      Else
      Begin
        reciboCtp  := TReciboCtp.CreateInstance(cdsAux);
        editorFast.pSetFastPrintFile(reciboCtp);
      End;

      If strNomeFila <> '' Then
        editorFast.pSelectFil(Self.Name, strNomeFila, fRetNomeRede);

      If editorFast.fLoadReport Then
      Begin

        Result := True;

        If Not cdsAux.IsEmpty Then
        Begin
          If blnVideo Then
            editorFast.pPreview
          Else
            editorFast.pPrint;
        End;
      End;

    end;

  finally

    if Assigned(cdsAux) then
      FreeAndNil(cdsAux);

    FreeAndNil(objEditor);

  end;

end;

procedure TfrmRelCtpReimpressaoDocsList.pSelecionaDuplicata(blnMarca : Boolean);

  procedure pMarcaImpressao(blnMarca : Boolean);
  begin
    With cdsGenCtp{iMP} Do
    Begin
      Filtered := False;
      Filter   := 'CTP_CODFOR = ' + QuotedStr(cdsGenCtp.FieldByName('CTP_CODFOR').AsString) + ' AND ' +
                  'SEQCON = ' + QuotedStr(cdsGenCtp.FieldByName('SEQCON').AsString) + ' AND ' +
                  'EMPBAI = ' + QuotedStr(cdsGenCtp.FieldByName('EMPBAI').AsString);
      Filtered := True;

      First;
      While Not Eof Do
      Begin

        Edit;

        If blnMarca Then
        Begin
          If FieldByName('CTP_NUMDUP').AsString = cdsGenCtp.FieldByName('CTP_NUMDUP').AsString Then
            FieldByName('CTP_IMPRES').AsString := 'I'
          Else
            FieldByName('CTP_IMPRES').AsString := '';
        End
        Else
          FieldByName('CTP_IMPRES').AsString := '';

        Post;

        Next;
      End;

      Filtered := False;
      Filter := '';
    End;
  end;
begin
  cdsGenCtp.Edit;
  cdsGenCtp.FieldByName('CTP_MARDES').AsString := IIF(blnMarca,'M','D');
  cdsGenCtp.Post;

  //pMarcaImpressao(blnMarca);
end;

procedure TfrmRelCtpReimpressaoDocsList.pBuscaDocumentos;
  var
    frmRelCtpReimpressaoBusca: TfrmRelCtpReimpressaoBusca;
begin
  Try
    pCriarFormularios(TfrmRelCtpReimpressaoBusca, frmRelCtpReimpressaoBusca);
    frmRelCtpReimpressaoBusca.cdsGenCtp := cdsGenCtp;
    frmRelCtpReimpressaoBusca.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmRelCtpReimpressaoDocsList.dbgDocumentosKeyDown]');
    End;
  End;

  pFreeAndNil(frmRelCtpReimpressaoBusca);
end;

procedure TfrmRelCtpReimpressaoDocsList.pGravaHistImpressao(
  qryRelatorio: TUniClientDataSet);
begin
  cdsHistImp.Append;
  cdsHistImp.FieldByName('NRODUP').AsString     := qryRelatorio.FieldByName('CTP_NUMDUP').AsString;
  cdsHistImp.FieldByName('CTP_CODFOR').AsString := qryRelatorio.FieldByName('CTP_CODFOR').AsString;
  cdsHistImp.FieldByName('CTP_CODEMP').AsString := qryRelatorio.FieldByName('CTP_CODEMP').AsString;
  cdsHistImp.FieldByName('PARDUP').AsString     := qryRelatorio.FieldByName('CTP_PARCEL').AsString;
  cdsHistImp.FieldByName('CTP_SERIE_').AsString := qryRelatorio.FieldByName('CTP_SERIE_').AsString;
  cdsHistImp.Post;
end;

procedure TfrmRelCtpReimpressaoDocsList.pMarcaDocumentos(blnMarca : Boolean);
var
  intRecNo : Integer;
begin
  With cdsGenCtp Do
  Begin
    DisableControls;
    intRecNo := RecNo;
    First;
    While Not Eof Do
    Begin

      pSelecionaDuplicata(blnMarca);

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;
End;

end.
