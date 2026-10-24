unit untRelCtrReimpressaoDocsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids,
  DB, Uni, AppEvnts, UniClientDataSet, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, StrUtils, BitBtnLockedIncrem, 
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxCore, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmRelCtrReimpressaoDocsList = class(TfrmPai)
    pnlFundo: TPanel;
    lblSelecione: TLabel;
    lblBusca: TLabel;
    cxgDocumentos: TcxGrid;
    cxgDocumentosDados: TcxGridDBTableView;
    cxgDuplicatasCTR_NUMDUP: TcxGridDBColumn;
    cxgDuplicatasCTR_ESPDOC: TcxGridDBColumn;
    cxgDuplicatasCTR_CODEMP: TcxGridDBColumn;
    cxgDuplicatasCTR_PARCEL: TcxGridDBColumn;
    cxgDuplicatasCLI_NOMCLI: TcxGridDBColumn;
    cxgDuplicatasCTR_DTACAD: TcxGridDBColumn;
    cxgDuplicatasCTR_VALREC: TcxGridDBColumn;
    cxgDuplicatasCTR_MARDES: TcxGridDBColumn;
    cxgDocumentosNivel: TcxGridLevel;
    cxgDuplicatasCTR_SEQCON: TcxGridDBColumn;
    cxgDuplicatasCTR_EMPBAI: TcxGridDBColumn;
    cxstylrpstry1: TcxStyleRepository;
    cxsSelecionado: TcxStyle;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure cxgDocumentosDadosCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cxgDocumentosDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxgDocumentosDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgDocumentosDadosStylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    cdsImpRecCG : TUniClientDataSet;

    FSomaCreditos: Boolean;

    FListaBaixas: TStringList;

    function fImprimeReciboLayoutPersonalizado: Boolean;
    procedure pAtualizaGrid;
    procedure pMarcaDocumento(blnMarcar: Boolean);
    procedure pSelecionaDocumento(blnSelTodos: Boolean = False);
    procedure pImprimeRecibo(AImpressaoDireta: Boolean = False);
    function ModoVideo:Boolean;
    function fRetornaTotalCliente(strCodCli: String;
    cdsGen: TUniClientDataSet): Real;
    procedure pCriarClientCreditoGerado(sltSeqCon,sltCodEmp : TStringList; LRescai: String; var AValorCreditoGerado: Double);
    procedure pCarregaCheques(strTipo, strSeqcon, strCodEmp: String; cdsChq: TUniClientDataSet);
    function fVerificaJaIncluido(strCodEmp, strSeqCon, strNumAge,
      strNumChq: String; cdsChq: TUniClientDataSet): Boolean;
    function pVerificaRegistrosEspDiferentesSelecionados: Boolean;

    function RetornaValorBaixadoBoleto: Double;
    function fLoadReportReimpressao(strATipImp : String) : Boolean;
    { Private declarations }
  public
    { Public declarations }
    strNomeFila: String;
    strTipImp  : String;
    cdsGenCtr  : TUniClientDataSet;
    cdsImpRec  : TUniClientDataSet;
    qryGenCtr  : TUniQuery;
    dtsGenCtr  : TDataSource;
    blnVisLC   : Boolean;

    function fImprimirDocumento(blnImprimeDireto: Boolean = False): Boolean;
  end;

implementation

uses untFuncoesSimples, untQckReciboCtaReceber, untCfgRel, untFastPrintEditor,
     untReciboCtr, untReciboCtrMeiaFolha,untRcxRecbBaixDocs, untPesqAux, untFuncoes, untReciboCtrReimpressao;

{$R *.dfm}

procedure TfrmRelCtrReimpressaoDocsList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Assigned(cdsGenCtr) Then
    FreeAndNil(cdsGenCtr);
end;

procedure TfrmRelCtrReimpressaoDocsList.FormShow(Sender: TObject);
begin
  inherited;
  cdsGenCtr := fCriaClientDatset(qryGenCtr);
  dtsGenCtr := fCriaDataSource(cdsGenCtr);
  cxgDocumentosDados.DataController.DataSource := dtsGenCtr;
  pAtualizaGrid;
  cdsGenCtr.First;
end;

procedure TfrmRelCtrReimpressaoDocsList.pAtualizaGrid;
begin
  With cdsGenCtr Do
  Begin
    If Not IsEmpty Then
      (FieldByName('CTR_VALREC') As TFloatField).DisplayFormat := '#,##0.00'
    Else
      fMensagem('ATENÇÃO!', 'Não há Documentos para serem impressos!', ['&O k']);
  End;
end;

procedure TfrmRelCtrReimpressaoDocsList.pCriarClientCreditoGerado(sltSeqCon,sltCodEmp : TStringList;
  LRescai: String; var AValorCreditoGerado: Double);
  Var
    strSQL   : String;
    qryPesq: TUniQuery;
    strNomCli : String;
begin

  qryPesq := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + '   SELECT                                   ';

  strSQL := strSQL + '   CTR_OPEBAI,                              ';
  strSQL := strSQL + '   CTR_PORBAI,                              ';
  strSQL := strSQL + '   CTR_HISBAI,                              ';

  strSQL := strSQL + '   CTR_CODCLI,                              ';
  strSQL := strSQL + '   CTR_NUMDUP,                              ';
  strSQL := strSQL + '   CTR_PARCEL,                              ';
  strSQL := strSQL + '   CTR_ESPDOC,                              ';
  strSQL := strSQL + '   CTR_CODEMP,                              ';
  strSQL := strSQL + '   CTR_DTACAD,                              ';
  strSQL := strSQL + '   CTR_DTAVEN,                              ';
  strSQL := strSQL + '   CTR_SEQBAI,                              ';
  strSQL := strSQL + '   CTR_SEQCON,                              ';
  strSQL := strSQL + '   CTR_NOSNUM,                              ';
  strSQL := strSQL + '   CTR_VALORI AS CTR_VALDUP,                ';
  strSQL := strSQL + '   CTR_JURSUJ,                              ';
  strSQL := strSQL + '   CTR_DESCOB,                              ';
  strSQL := strSQL + '   CTR_DESSUJ,                              ';
  strSQL := strSQL + '   CTR_VALORI,                              ';
  strSQL := strSQL + '   CTR_VALJUR,                              ';
  strSQL := strSQL + '   CTR_VALCOB,                              ';
  strSQL := strSQL + '   CTR_VALDES,                              ';
  strSQL := strSQL + '   CTR_VALREC,                              ';
  strSQL := strSQL + '   CTR_CODCTA,                              ';
  strSQL := strSQL + '   CLI_CODCLI,                              ';
  strSQL := strSQL + '   CLI_NOMCLI,                              ';
  strSQL := strSQL + '   CLI_FANSOB,                              ';
  strSQL := strSQL + '   CLI_ENDERE,                              ';
  strSQL := strSQL + '   CLI_ENDNUM,                              ';
  strSQL := strSQL + '   CLI_ENDCOM,                              ';
  strSQL := strSQL + '   CLI_BAIRRO,                              ';
  strSQL := strSQL + '   CLI_C_E_P_,                              ';
  strSQL := strSQL + '   CLI_CODCID,                              ';
  strSQL := strSQL + '   CLI_C_G_C_,                              ';
  strSQL := strSQL + '   CLI_FONE01,                              ';
  strSQL := strSQL + '   CTR_VALANT,                              ';
  strSQL := strSQL + '   CTR_HIST01,                              ';
  strSQL := strSQL + '   CTR_HIST02,                              ';
  strSQL := strSQL + '   CTR_COBANT,                              ';
  strSQL := strSQL + '   CTR_GRVORI                               ';
  strSQL := strSQL + ' FROM                                       ';

  If LRescai = '1' Then
  Begin
    strSQL := strSQL + '   CADREC                                   ';
    strSQL := strSQL + '   INNER JOIN CADCLI                        ';
    strSQL := strSQL + '     ON CLI_CODCLI = CTR_CODCLI             ';
    strSQL := strSQL + '   LEFT JOIN CADRCXX                        ';
    strSQL := strSQL + '     ON CTR_NUMDUP = RCX_NUMDOC             ';
    strSQL := strSQL + '     AND CTR_CODCLI = RCX_CODCLI            ';
    strSQL := strSQL + '     AND CTR_CODEMP = RCX_CODEMP            ';
    strSQL := strSQL + '     AND CTR_PARCEL = RCX_PARCEL            ';
    strSQL := strSQL + '     AND CTR_ESPDOC = RCX_ESPDOC            ';
    strSQL := strSQL + ' WHERE RCX_SEQCON = ' + Trim(sltSeqCon.Text) ;
    strSQL := strSQL + '   AND RCX_CODEMP = ' + QuotedStr(Trim(sltCodEmp.Text));
    strSQL := strSQL + '   AND RCX_ESPDOC = "CC"  AND CTR_OPEBAI IS NULL';
  End
  Else
  Begin
    strSQL := strSQL + '   LOGCTR                                   ';
    strSQL := strSQL + '   INNER JOIN CADCLI                        ';
    strSQL := strSQL + '     ON CLI_CODCLI = CTR_CODCLI             ';
    strSQL := strSQL + ' WHERE CTR_SEQCON = ' + Trim(sltSeqCon.Text) ;
    strSQL := strSQL + '   AND CTR_CODEMP = ' + QuotedStr(Trim(sltCodEmp.Text));
    strSQL := strSQL + '   AND CTR_ESPDOC = "CC"  AND CTR_DESCRI LIKE "INCLUSÃO%"';
  End;

  Try
    qryPesq.Close;
    qryPesq.SQL.Clear;
    qryPesq.SQL.Add(strSQL);
    qryPesq.Open;

    With qryPesq Do
    Begin

      First;
      While Not Eof Do
      Begin
        cdsImpRecCG.Insert;
        cdsImpRecCG.FieldByName('HIST01').AsString   := FieldByName('CTR_HIST01').AsString;
        cdsImpRecCG.FieldByName('HIST02').AsString   := FieldByName('CTR_HIST02').AsString;
        cdsImpRecCG.FieldByName('CODCLI').AsString   := FieldByName('CTR_CODCLI').AsString;
        cdsImpRecCG.FieldByName('DESCRI').AsString   := FieldByName('CTR_CODCLI').AsString + '-' + FieldByName('CLI_NOMCLI').AsString;
        cdsImpRecCG.FieldByName('NUMDOC').AsString   := FieldByName('CTR_NUMDUP').AsString;
        cdsImpRecCG.FieldByName('PARCEL').AsString   := FieldByName('CTR_PARCEL').AsString;
        cdsImpRecCG.FieldByName('ESPDOC').AsString   := FieldByName('CTR_ESPDOC').AsString;
        cdsImpRecCG.FieldByName('CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
        cdsImpRecCG.FieldByName('DTACAD').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
        cdsImpRecCG.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
        cdsImpRecCG.FieldByName('DTAREC').AsDateTime := VS_Date;
        cdsImpRecCG.FieldByName('HORREC').AsDateTime := fTime();
        cdsImpRecCG.FieldByName('CODVEN').AsString   := fBuscaVendedorDup(FieldByName('CTR_NUMDUP').AsString,
                                                                        FieldByName('CTR_PARCEL').AsString,
                                                                        FieldByName('CTR_ESPDOC').AsString,
                                                                        FieldByName('CTR_CODCLI').AsString,
                                                                        FieldByName('CTR_CODEMP').AsString);
        cdsImpRecCG.FieldByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
        cdsImpRecCG.FieldByName('SEQCON').AsInteger := FieldByName('CTR_SEQCON').AsInteger;

        if fEmptyStr(FieldByName('CTR_NOSNUM').AsString) then
          cdsImpRecCG.FieldByName('NOSNUM').AsString  := fTrazNosNumDupZero(FieldByName('CTR_NUMDUP').AsString,
                                                                          FieldByName('CTR_PARCEL').AsString,
                                                                          FieldByName('CTR_ESPDOC').AsString,
                                                                          FieldByName('CTR_CODCLI').AsString,
                                                                          FieldByName('CTR_CODEMP').AsString)
        else
          cdsImpRecCG.FieldByName('NOSNUM').AsString  := FieldByName('CTR_NOSNUM').AsString;

        cdsImpRecCG.FieldByName('VALDOC').AsFloat   := FieldByName('CTR_VALDUP').AsFloat -
                                                     FieldByName('CTR_JURSUJ').AsFloat -
                                                     FieldByName('CTR_DESCOB').AsFloat +
                                                     FieldByName('CTR_DESSUJ').AsFloat;

        cdsImpRecCG.FieldByName('VALORI').AsFloat  := FieldByName('CTR_VALORI').AsFloat;
        cdsImpRecCG.FieldByName('COBANT').AsFloat  := FieldByName('CTR_COBANT').AsFloat;
        cdsImpRecCG.FieldByName('VALOR2').AsFloat  := FieldByName('CTR_GRVORI').AsFloat;

        If (FieldByName('CTR_VALJUR').AsFloat - FieldByName('CTR_VALDES').AsFloat = 0) Then
          cdsImpRecCG.FieldByName('VALJUR').AsFloat  := 0
        else
          cdsImpRecCG.FieldByName('VALJUR').AsFloat  := FieldByName('CTR_VALJUR').AsFloat;


        cdsImpRecCG.FieldByName('VALCOB').AsFloat  := FieldByName('CTR_VALCOB').AsFloat;
        cdsImpRecCG.FieldByName('VALDES').AsFloat  := FieldByName('CTR_VALDES').AsFloat;
        cdsImpRecCG.FieldByName('DESCOB').AsFloat  := FieldByName('CTR_DESCOB').AsFloat;
        cdsImpRecCG.FieldByName('VALREC').AsFloat  := FieldByName('CTR_VALREC').AsFloat;

        strNomCli := fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
        cdsImpRecCG.FieldByName('NOMCLI').AsString := strNomCli;
        cdsImpRecCG.FieldByName('FANSOB').AsString := FieldByName('CLI_FANSOB').AsString;
        cdsImpRecCG.FieldByName('ENDERE').AsString := FieldByName('CLI_ENDERE').AsString;
        cdsImpRecCG.FieldByName('ENDNUM').AsString := FieldByName('CLI_ENDNUM').AsString;
        cdsImpRecCG.FieldByName('ENDCMP').AsString := FieldByName('CLI_ENDCOM').AsString;
        cdsImpRecCG.FieldByName('BAIRRO').AsString := FieldByName('CLI_BAIRRO').AsString;
        cdsImpRecCG.FieldByName('C_E_P_').AsString := FieldByName('CLI_C_E_P_').AsString;
        cdsImpRecCG.FieldByName('CIDADE').AsString := fRetNomCidade(FieldByName('CLI_CODCID').AsString);
        cdsImpRecCG.FieldByName('ESTADO').AsString := fRetUFCliente(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('C_G_C_').AsString := FieldByName('CLI_C_G_C_').AsString;
        cdsImpRecCG.FieldByName('FONE01').AsString := FieldByName('CLI_FONE01').AsString;
        cdsImpRecCG.FieldByName('VALREC').AsFloat := FieldByName('CTR_VALREC').AsFloat;
        cdsImpRecCG.FieldByName('CTR_ABERTO').AsFloat := fRetornaReceberAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CTR_TOTBLT').AsFloat := fRetornaReceberTotalBoletosEmAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CTR_TOTCRD').AsFloat := fRetornaReceberTotalCrediarioEmAberto(FieldByName('CTR_CODCLI').AsString);
        cdsImpRecCG.FieldByName('CTR_TOTCHD').AsFloat := fRetornaReceberTotalChequesDevolvidosEmAberto(FieldByName('CTR_CODCLI').AsString);

        If (Pos('CONSUMIDOR', strNomCli) > 0) Or
           (Pos('BALCAO', strNomCli) > 0)     Or
           (Pos('BALCÃO', strNomCli) > 0)     Then
        Begin
          cdsImpRecCG.FieldByName('NOMCLI').AsString := fRetCliConsumidor(FieldByName('CTR_CODCLI').AsString,
                                                                        FieldByName('CTR_NUMDUP').AsString,
                                                                        FieldByName('CTR_ESPDOC').AsString,
                                                                        FieldByName('CTR_CODEMP').AsString);
          cdsImpRecCG.FieldByName('DESCRI').AsString := FieldByName('CTR_CODCLI').AsString + '-' + cdsImpRecCG.FieldByName('NOMCLI').AsString;
        End;
        cdsImpRecCG.FieldByName('NOMCON').AsString := cdsImpRecCG.FieldByName('NOMCLI').AsString;

        cdsImpRecCG.FieldByName('CODCTA').AsString   := FieldByName('CTR_CODCTA').AsString;
        cdsImpRecCG.FieldByName('DESCTA').AsString   := fRetNomeConta( FieldByName('CTR_CODCTA').AsString );

        cdsImpRecCG.Post;

        AValorCreditoGerado := AValorCreditoGerado + fFormataFloat(Abs(FieldByName('CTR_VALORI').AsFloat), 2);

        Next;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pCriarClientCreditoGerado]');
    End;
  End;

end;

procedure TfrmRelCtrReimpressaoDocsList.pImprimeRecibo(AImpressaoDireta: Boolean = False);
  Var
    strRecRcx   : String;
    strNomCli   : String;
    arrCodCli   : Array Of TRcxDadosCliente;
    intContador : Integer;
    intContador2: Integer;
    blnAchou    : Boolean;
    recValRec   : TRcxValoresReceb;
    qryConCli   : TUniQuery;
    cdsChqVis: TUniClientDataSet;
    cdsChqPre: TUniClientDataSet;
    dblDinRec,
    dblCarRec,
    dblChqPre,
    dblChqVis,
    dblOrdRec,
    dblCreRec,
    LValorBoleto: Double;

    LModoVideo: Boolean;
Begin
  Try
    strRecRcx := fCfgSis('RECRCX');
    cdsChqVis := fCriaCdsCheques(Self);
    cdsChqPre := fCriaCdsCheques(Self);
    cdsImpRec := fCriaClientDatasetReciboCTR;

    If Not cdsImpRec.Active Then
      cdsImpRec.Open;

    cdsImpRec.EmptyDataSet;
    cdsImpRec.Filter   := '';
    cdsImpRec.Filtered := FALSE;

    FListaBaixas := TStringList.Create;

    With cdsGenCtr Do
    Begin

      intContador := -1;
      SetLength(arrCodCli, 0);

      dblDinRec := 0;
      dblCarRec := 0;
      dblChqPre := 0;
      dblChqVis := 0;
      dblOrdRec := 0;
      dblCreRec := 0;

      First;

      While Not Eof Do
      Begin
        If (Not MatchStr(cdsGenCtr.FieldByName('CTR_SEQCON').AsString, ['', '0'])) And //validação para registros muito antigos ou convertidos fora do padrão
           (Not MatchStr(cdsGenCtr.FieldByName('CTR_DTABAI').AsString, ['', '0'])) Then
        Begin
          If FListaBaixas.IndexOf(Concat(cdsGenCtr.FieldByName('CTR_SEQCON').AsString, '-',
                                         cdsGenCtr.FieldByName('CTR_EMPBAI').AsString, '-',
                                         FormatDateTime('yyyy/mm/dd', cdsGenCtr.FieldByName('CTR_DTABAI').AsDateTime))) = -1 Then
            FListaBaixas.Add(Concat(cdsGenCtr.FieldByName('CTR_SEQCON').AsString, '-',
                                    cdsGenCtr.FieldByName('CTR_EMPBAI').AsString, '-',
                                    FormatDateTime('yyyy/mm/dd', cdsGenCtr.FieldByName('CTR_DTABAI').AsDateTime)));
        End;

        Next;
      End;

      LValorBoleto := RetornaValorBaixadoBoleto;

      FreeAndNil(FListaBaixas);

      First;

      While Not Eof Do
      Begin
        cdsImpRec.Insert;
        cdsImpRec.FieldByName('CODCLI').AsString   := FieldByName('CTR_CODCLI').AsString;
        cdsImpRec.FieldByName('NOMCLI').AsString   := fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
        cdsImpRec.FieldByName('DESCRI').AsString   := FieldByName('CTR_CODCLI').AsString + '-' + cdsImpRec.FieldByName('NOMCLI').AsString;
        cdsImpRec.FieldByName('NUMDOC').AsString   := FieldByName('CTR_NUMDUP').AsString;
        cdsImpRec.FieldByName('PARCEL').AsString   := FieldByName('CTR_PARCEL').AsString;
        cdsImpRec.FieldByName('ESPDOC').AsString   := FieldByName('CTR_ESPDOC').AsString;
        cdsImpRec.FieldByName('CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
        cdsImpRec.FieldByName('DTACAD').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
        cdsImpRec.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
        cdsImpRec.FieldByName('DTAREC').AsDateTime := FieldByName('DTAREC').AsDateTime;
        cdsImpRec.FieldByName('CODVEN').AsString   := fBuscaVendedorDup(FieldByName('CTR_NUMDUP').AsString,
                                                                        FieldByName('CTR_PARCEL').AsString,
                                                                        FieldByName('CTR_ESPDOC').AsString,
                                                                        FieldByName('CTR_CODCLI').AsString,
                                                                        FieldByName('CTR_CODEMP').AsString);
        cdsImpRec.FieldByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
        cdsImpRec.FieldByName('SEQCON').AsInteger := FieldByName('CTR_SEQCON').AsInteger;
        cdsImpRec.FieldByName('NOSNUM').AsString  := FieldByName('CTR_NOSNUM').AsString;
        cdsImpRec.FieldByName('VALDOC').AsFloat   := FieldByName('CTR_VALDUP').AsFloat -
                                                     FieldByName('CTR_JURSUJ').AsFloat +
                                                     FieldByName('CTR_DESSUJ').AsFloat;

        cdsImpRec.FieldByName('VALORI').AsFloat  := FieldByName('VALORI').AsFloat;
        cdsImpRec.FieldByName('VALJUR').AsFloat  := FieldByName('VALJUR').AsFloat;
        cdsImpRec.FieldByName('VALCOB').AsFloat  := FieldByName('VALCOB').AsFloat;
        cdsImpRec.FieldByName('VALDES').AsFloat  := FieldByName('VALDES').AsFloat;
        cdsImpRec.FieldByName('VALREC').AsFloat  := FieldByName('VALREC').AsFloat;
        cdsImpRec.FieldByName('DESCOB').AsFloat  := FieldByName('DESCOB').AsFloat;
        cdsImpRec.FieldByName('COBANT').AsFloat  := FieldByName('COBANT').AsFloat;
        cdsImpRec.FieldByName('VALOR2').AsFloat  := FieldByName('VALOR2').AsFloat;

        cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString := untReciboCtr.DuplicataCreditoReferenteATroco(cdsImpRec);
        If cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString.Equals('S') Then
          cdsImpRec.FieldByName('VALOR_TROCO').AsFloat := Abs(cdsImpRec.FieldByName('VALREC').AsFloat);

        If (Length(arrCodCli) = 0) Or (arrCodCli[intContador].strCodCli <> FieldByName('CTR_CODCLI').AsString) Then
        Begin

          blnAchou := False;
          For intContador2 := 0 To Length(arrCodCli) -1 Do
          Begin

            If (arrCodCli[intContador2].strCodCli = FieldByName('CTR_CODCLI').AsString) Then
            Begin
              blnAchou := True;
              Break;
            End;

          End;

          If (Not blnAchou) Then
          Begin
            Inc(intContador);
            SetLength(arrCodCli, intContador + 1);
            intContador2 := intContador;
          End;

          strNomCli := fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
          arrCodCli[intContador2].strCodCli := FieldByName('CTR_CODCLI').AsString;
          cdsImpRec.FieldByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
          arrCodCli[intContador2].strNomCli := FieldByName('CTR_CODCLI').AsString + ' - ' + fRetNomCliente(FieldByName('CTR_CODCLI').AsString);
          cdsImpRec.FieldByName('NOMCLI').AsString := strNomCli;

          qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
          pPesquisaCadCli(qryConCli, qryConCli, FieldByName('CTR_CODCLI').AsString);

          arrCodCli[intContador2].strEndCli := qryConCli.FieldByName('CLI_ENDERE').AsString+', ' +
                                               qryConCli.FieldByName('CLI_ENDNUM').AsString+' - '+
                                               qryConCli.FieldByName('CLI_BAIRRO').AsString;
          cdsImpRec.FieldByName('ENDERE').AsString := qryConCli.FieldByName('CLI_ENDERE').AsString;
          cdsImpRec.FieldByName('ENDNUM').AsString := qryConCli.FieldByName('CLI_ENDNUM').AsString;
          cdsImpRec.FieldByName('ENDCMP').AsString := qryConCli.FieldByName('CLI_ENDCOM').AsString;
          cdsImpRec.FieldByName('BAIRRO').AsString := qryConCli.FieldByName('CLI_BAIRRO').AsString;
          arrCodCli[intContador2].strCepCli := qryConCli.FieldByName('CLI_C_E_P_').AsString;
          cdsImpRec.FieldByName('C_E_P_').AsString := qryConCli.FieldByName('CLI_C_E_P_').AsString;
          arrCodCli[intContador2].strCidCli := fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString)+'-'+
                                               fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString, 2);
          cdsImpRec.FieldByName('CIDADE').AsString := fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString);
          cdsImpRec.FieldByName('ESTADO').AsString := fRetUFCliente(FieldByName('CTR_CODCLI').AsString);
          cdsImpRec.FieldByName('C_G_C_').AsString := qryConCli.FieldByName('CLI_C_G_C_').AsString;
          cdsImpRec.FieldByName('FONE01').AsString := qryConCli.FieldByName('CLI_FONE01').AsString;
          cdsImpRec.FieldByName('FANSOB').AsString := qryConCli.FieldByName('CLI_FANSOB').AsString;

          If (blnAchou) Then
          Begin
            arrCodCli[intContador2].fltValRec := arrCodCli[intContador2].fltValRec +
                                                 IIF(cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString.Equals('N'),
                                                     FieldByName('CTR_VALREC').AsFloat,
                                                     0);
            cdsImpRec.FieldByName('VALREC').AsFloat := arrCodCli[intContador2].fltValRec + FieldByName('CTR_VALREC').AsFloat;
          End
          Else
          Begin
            arrCodCli[intContador2].fltValRec := IIF(cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString.Equals('N'),
                                                     FieldByName('CTR_VALREC').AsFloat,
                                                     0);
            cdsImpRec.FieldByName('VALREC').AsFloat := FieldByName('CTR_VALREC').AsFloat;
          End;
        End
        Else
        Begin
          arrCodCli[intContador].fltValRec := arrCodCli[intContador].fltValRec +
                                              IIF(cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString.Equals('N'),
                                                  FieldByName('CTR_VALREC').AsFloat,
                                                  0);
          cdsImpRec.FieldByName('VALREC').AsFloat := FieldByName('CTR_VALREC').AsFloat;
        End;

        If (Pos('CONSUMIDOR', strNomCli) > 0) Or
           (Pos('BALCAO', strNomCli) > 0)     Or
           (Pos('BALCÃO', strNomCli) > 0)     Then
        Begin
          cdsImpRec.FieldByName('NOMCLI').AsString := fRetCliConsumidor(FieldByName('CTR_CODCLI').AsString,
                                                                        FieldByName('CTR_NUMDUP').AsString,
                                                                        FieldByName('CTR_ESPDOC').AsString,
                                                                        FieldByName('CTR_CODEMP').AsString);
          cdsImpRec.FieldByName('DESCRI').AsString := FieldByName('CTR_CODCLI').AsString + '-' + cdsImpRec.FieldByName('NOMCLI').AsString;
        End;

        cdsImpRec.FieldByName('OPEBAI').AsString   := FieldByName('OPEBAI').AsString;
        cdsImpRec.FieldByName('DTABAI').AsDateTime := FieldByName('CTR_DTABAI').AsDateTime;

        cdsImpRec.FieldByName('CTR_DINHEI').AsFloat  := FieldByName('CTR_DINHEI').AsFloat;
        cdsImpRec.FieldByName('CTR_CARTAO').AsFloat  := FieldByName('CTR_CARTAO').AsFloat;
        cdsImpRec.FieldByName('CTR_CHQPRE').AsFloat  := FieldByName('CTR_CHQPRE').AsFloat;
        cdsImpRec.FieldByName('CTR_CHQAVI').AsFloat  := FieldByName('CTR_CHQAVI').AsFloat;
        cdsImpRec.FieldByName('CTR_ORDPAG').AsFloat  := FieldByName('CTR_ORDPAG').AsFloat;
        cdsImpRec.FieldByName('CTR_CREDITO').AsFloat := IIF(FieldByName('CTR_CREDITO').AsFloat < 0,
                                                            FieldByName('CTR_CREDITO').AsFloat, 0);

        cdsImpRec.FieldByName('DINHEIRO_SEM_BOLETO').AsFloat := fFormataFloat(dblDinRec - LValorBoleto, 2);
        cdsImpRec.FieldByName('VALOR_BOLETO').AsFloat := fFormataFloat(LValorBoleto, 2);

        cdsImpRec.FieldByName('CODCTA').AsString   := FieldByName('CODCTA').AsString;
        cdsImpRec.FieldByName('DESCTA').AsString   := fRetNomeConta( FieldByName('CODCTA').AsString );


        cdsImpRec.FieldByName('HIST01').AsString   := FieldByName('CTR_HIST01').AsString;
        cdsImpRec.FieldByName('HIST02').AsString   := FieldByName('CTR_HIST02').AsString;

        If FieldByName('RCX_CAIXA').AsString <> '' Then
          cdsImpRec.FieldByName('RCX_CAIXA').AsString   := 'CAIXA: ' + FieldByName('RCX_CAIXA').AsString;

        cdsImpRec.FieldByName('PORBAI').AsString   := FieldByName('CTR_PORBAI').AsString;

        cdsImpRec.FieldByName('EMPBAI').AsString   := FieldByName('CTR_EMPBAI').AsString;
        cdsImpRec.FieldByName('RESCAI').AsString   := FieldByName('RESCAI').AsString;

        cdsImpRec.FieldByName('RECPIX').AsString   := FieldByName('RECPIX').AsString;

        cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString := untReciboCtr.DuplicataCreditoReferenteATroco(cdsImpRec);
        If cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString.Equals('S') Then
          cdsImpRec.FieldByName('VALOR_TROCO').AsFloat := Abs(cdsImpRec.FieldByName('VALREC').AsFloat);

        cdsImpRec.Post;

        if cdsImpRec.FieldByName('DUPLICATA_TROCO').AsString.Equals('N') Then
        begin
          dblDinRec := dblDinRec + FieldByName('CTR_DINHEI').AsFloat;
          dblCarRec := dblCarRec + FieldByName('CTR_CARTAO').AsFloat;
          dblChqPre := dblChqPre + FieldByName('CTR_CHQPRE').AsFloat;
          dblChqVis := dblChqVis + FieldByName('CTR_CHQAVI').AsFloat;
          dblOrdRec := dblOrdRec + FieldByName('CTR_ORDPAG').AsFloat;
          dblCreRec := dblCreRec + IIF(FieldByName('CTR_CREDITO').AsFloat < 0,
                                       FieldByName('CTR_CREDITO').AsFloat, 0);
        end;

        // Adiciona todos os cheques na cds;
        pCarregaCheques( 'V', FieldByName('CTR_SEQCON').AsString, FieldByName('CTR_EMPBAI').AsString, cdsChqVis);
        pCarregaCheques( 'P', FieldByName('CTR_SEQCON').AsString, FieldByName('CTR_EMPBAI').AsString, cdsChqPre);

        Next;
      End;
    End;

    With cdsImpRec Do
    Begin

      If Not IsEmpty Then
      Begin
        LModoVideo := ModoVideo;

        If Not LModoVideo Then
        Begin
          If fEmptyStr(strTipImp) Or fEmptyStr(strNomeFila)  Then
          Begin
            pCarregaConfImpr(qryCfgRel, 'frmRelCtrReimpressaoDocsList');
            fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
          End;
        End;

        If Not fImprimeReciboLayoutPersonalizado Then
        Begin

          If (FieldByName('ESPDOC').AsString = 'PG') Then
          Begin
            Edit;
            FieldByName('DESCRI').AsString := fRetNomFornecedor(FieldByName('CODCLI').AsString) + ' - ' + FieldByName('HIST01').AsString;
            Post;
          End;

          recValRec.strDinRec := FloatToStrF(dblDinRec, ffFixed, 12, 2);
          recValRec.strCarRec := FloatToStrF(dblCarRec, ffFixed, 12, 2);
          recValRec.strChqPre := FloatToStrF(dblChqPre, ffFixed, 12, 2);
          recValRec.strChqVis := FloatToStrF(dblChqVis, ffFixed, 12, 2);
          recValRec.strOrdRec := FloatToStrF(dblOrdRec, ffFixed, 12, 2);
          recValRec.strCreRec := FloatToStrF(dblCreRec, ffFixed, 12, 2);

          //blnCalculaTotais := True;
          blnCalculaTotais := IIF(FieldByName('RESCAI').AsString = '0', true, false);

          if not AImpressaoDireta then
            pImpRecBaiDoc(cdsImpRec,
                          strRecRcx,
                          FieldByName('SEQCON').AsInteger,
                          FieldByName('OPEBAI').AsString,
                          arrCodCli,
                          recValRec,
                          cdsChqPre,
                          cdsChqVis,
                          'frmRcxResumoCaixa',
                          strNomeFila,
                          strTipImp,
                          ((Pos(FieldByName('ESPDOC').AsString, 'CC_LC_LD_PG_TF_') > 0)
                            And (fCfgSis('RECRCX') = 'B')),
                          FieldByName('ESPDOC').AsString,
                          FieldByName('CODCTA').AsString,
                          '',
                          //False,
                          (FieldByName('RESCAI').AsInteger = 1),
                          FieldByName('PORBAI').AsString,
                          FieldByName('HIST02').AsString,
                          LModoVideo)
          else
          begin
            pCriarFormularios(TfrmQckReciboCtaReceber, frmQckReciboCtaReceber);
            try
              Try

                If Not LModoVideo Then
                begin
                  pCarregaConfImpr(qryCfgRel, 'frmRelCtrReimpressaoDocsList');
                  fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
                end;

                frmQckReciboCtaReceber.blnCalculaTotais := True;
                frmQckReciboCtaReceber.pImprimeRecibo(LModoVideo,
                                                      TCfgRel.VS_blnDlgPri,
                                                      'frmRelCtrReimpressaoDocsList',
                                                      strTipImp,
                                                      strNomeFila,
                                                      cdsImpRec.FieldByName('SEQCON').AsString,
                                                      cdsImpRec,
                                                      1,
                                                      False,
                                                      dblChqPre,
                                                      dblChqVis,
                                                      dblCarRec,
                                                      dblDinRec,
                                                      dblOrdRec,
                                                      dblCreRec);
              Except
                On E: Exception Do
                  pMensagensErro(E.Message, '[frmRelCtrReimpressaoDocsList.dbgDocumentosDblClick]');
              End;
            finally
              pFreeAndNil(frmQckReciboCtaReceber);
            end;
          End;


        End;
      End;
    End;

    cdsImpRec.EmptyDataSet;

  Except
    On E: Exception Do
    Begin
      fMensagem('',E.Message,['&OK']);
    End;
  End;

End;

procedure TfrmRelCtrReimpressaoDocsList.pMarcaDocumento(blnMarcar: Boolean);
begin
  Try
    With cdsGenCtr Do
    Begin
      Edit;
      FieldByName('CTR_MARDES').AsString := IfThen(blnMarcar, 'M', 'D');
      Post;
    End;
  Finally

  End;
end;

procedure TfrmRelCtrReimpressaoDocsList.pSelecionaDocumento(blnSelTodos: Boolean);
begin
  If (Not cdsGenCtr.Active) Or (cdsGenCtr.IsEmpty) Then
    Exit;

  If Not blnSelTodos Then
    cdsGenCtr.AfterScroll := nil;

  If cdsGenCtr.FieldByName('CTR_MARDES').AsString <> 'M' Then
    pMarcaDocumento(True)
  Else
    pMarcaDocumento(False);

  If Not blnSelTodos Then
    pAtualizaGrid;
end;

function TfrmRelCtrReimpressaoDocsList.fImprimirDocumento(blnImprimeDireto: Boolean = False): Boolean;
  Var
    strIndex : String;
    strFilter: String;
    strSeqCon: String;
    blnFilter: Boolean;

    function fDupRelacionadas(strSeqcon, strCodEmp: String; ADataBaixa: TDateTime): Boolean;
      Var
        qryGen: TUniQuery;
        strSQL: String;
    Begin

      Try
        qryGen := fCriaQuery(Self);

        strSQL := 'SELECT CTR_NUMDUP FROM CADREC  WHERE CTR_SEQCON = :SEQCON AND CTR_EMPBAI = :CODEMP AND CTR_DTABAI = :DTABAI UNION ALL ' +
                  'SELECT ADT_NUMDOC FROM ADTCLI  WHERE ADT_SEQCON = :SEQCON AND ADT_EMPLAN = :CODEMP AND ADT_DTALAN = :DTABAI';

        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(strSQL);
        qryGen.ParamByName('SEQCON').AsString := strSeqcon;
        qryGen.ParamByName('CODEMP').AsString := strCodEmp;
        qryGen.ParamByName('DTABAI').AsDateTime := ADataBaixa;
        qryGen.Open;

        Result := qryGen.RecordCount > 1;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message,'[fImprimirDocumento.fDupRelacionadas]');
        End;
      End;
      FreeAndNil(qryGen);

    End;
Begin
  Result := false;

  If fMensagem('','Deseja Reimprimir este(s) documento(s)?',['&Sim','&Não'],2) = 1 Then
  Begin

    With cdsGenCtr Do
    Begin
      blnFilter := false;
      Try
        DisableControls;
        strFilter := Filter;
        blnFilter := Filtered;

        Filter   := 'CTR_MARDES = ' + QuotedStr('M');
        Filtered := True;

        If IsEmpty Then
        Begin
          Filtered := False;
          EnableControls;
          fMensagem('','Nenhum documento foi selecionado!', ['&Ok']);
          Exit;
        End;

        FSomaCreditos := True;

        First;

        if not blnImprimeDireto then
        begin
          While Not Eof Do
          Begin
            If (Not fEmptyStr(FieldByName('CTR_SEQCON').AsString)) And
              (fDupRelacionadas(FieldByName('CTR_SEQCON').AsString,FieldByName('CTR_EMPBAI').AsString,FieldByName('CTR_DTABAI').AsDateTime)) And
              (FieldByName('CTR_SEQCON').AsString <> '0')           Then
            Begin
              If fMensagem('','A duplicata ' + FieldByName('CTR_NUMDUP').AsString + '-' + FieldByName('CTR_PARCEL').AsString + ' possui duplicatas relacionadas.' + #13 + #10 +
                              'Deseja imprimir todas?', ['&Sim', '&Não']) = 1 Then
              Begin
                fMensagem('', 'A(s) duplicata(s) com sequencial de baixa diferente de ' + FieldByName('CTR_SEQCON').AsString +
                              ' será(ão) desmarcada(s) e a reimpressão deverá ser feita separadamente!', ['&Ok']);

                strSeqCon := 'CTR_EMPBAI = ' + FieldByName('CTR_EMPBAI').AsString + ' AND CTR_SEQCON = ' + FieldByName('CTR_SEQCON').AsString;
                Filtered  := False;
                Filter    := strSeqCon;
                Break;
              End
              Else
                FSomaCreditos := False;
            End;

            Next;
          End;
        end;

        If Not Filtered Then
        Begin
          Filtered  := True;

          First;
          While Not Eof Do
          Begin
            pMarcaDocumento(True);
            Next;
          End;
          First;
        End;

        strIndex  := IndexFieldNames;
        IndexFieldNames := 'CODCLI';

        If Not fImprimeReciboLayoutPersonalizado Then
          pImprimeRecibo(blnImprimeDireto);

      Finally
        IndexFieldNames := strIndex;
        Filter   := strFilter;
        Filtered := blnFilter;
        First;
        While Not Eof Do
        Begin
          pMarcaDocumento(False);
          Next;
        End;
        First;
        EnableControls;
      End;

    End;

  End;

End;

procedure TfrmRelCtrReimpressaoDocsList.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not cdsGenCtr.Active Then
    Exit;

  If Not (fCfgSis('VIAREC',varInteger) > 0) Then
  Begin
     pMensagemOk('É necessário configurar o número de vias para impressão!');
     Exit;
  End;

  If blnVisLC Then
  Begin
     If pVerificaRegistrosEspDiferentesSelecionados Then
     Begin
        fMensagem('ATENÇÃO!', 'Existem registros selecionados que possuem layouts diferentes para impressão!', ['&O k']);
        Exit;
     End;
  End;

  fImprimirDocumento;

  strTipImp := '';
  strNomeFila := '';
end;

procedure TfrmRelCtrReimpressaoDocsList.cxgDocumentosDadosCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
//  fImprimirDocumento;
  pSelecionaDocumento;
end;

procedure TfrmRelCtrReimpressaoDocsList.cxgDocumentosDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes: String;
begin
  inherited;
  If (AViewInfo.Item.SortOrder <> soNone) And
     (Not AViewInfo.Selected) Then
    ACanvas.Brush.Color := clInfoBk;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgDuplicatasCTR_MARDES.Index]);
  If (cdsGenCtr.IsEmpty) Or fEmptyStr(strMarDes) Or (strMarDes = 'D') Then
    Exit;

  If (strMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmRelCtrReimpressaoDocsList.cxgDocumentosDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
  Begin
    pSelecionaDocumento;
  End
  {
  Else If Key = VK_F3 Then
  Begin
    Try
      pCriarFormularios(TfrmRelCtrReimpressaoBusca,frmRelCtrReimpressaoBusca);
      frmRelCtrReimpressaoBusca.qryGenCtr := qryGenCtr;
      frmRelCtrReimpressaoBusca.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmRelCtrReimpressaoDocsList.dbgDocumentosKeyDown]');
      End;
    End;

    pFreeAndNil(frmRelCtrReimpressaoBusca);

  End
  }
  Else If Key = VK_F10 Then
  Begin
    btnConfirma.Click;
  End
  Else If Key = VK_Escape Then
  Begin
    btnSair.Click;
  End;
end;

procedure TfrmRelCtrReimpressaoDocsList.cxgDocumentosDadosStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; out AStyle: TcxStyle);
  Var
    ARowInfo: TcxRowInfo;
begin
  inherited;
  If ARecord.IsData And (ARecord.Index > -1) Then
    With cxgDocumentosDados.DataController Do
    Begin
      ARowInfo := GetRowInfo(ARecord.Index);
      If VarToStr(Values[ARowInfo.RecordIndex,
                         cxgDocumentosDados.GetColumnByFieldName('CTR_MARDES').Index]) = 'M' Then
      Begin
        AStyle := cxsSelecionado;
      End;
    End;
end;


function TfrmRelCtrReimpressaoDocsList.fRetornaTotalCliente( strCodCli: String; cdsGen : TUniClientDataSet ): Real;
 Var cdsTot : TUniClientDataSet;
 Var fltTotCli : Real;
Begin

   cdsTot := TUniClientDataSet.Create(Self);
   cdsTot.DATA := cdsGen.Data;

   fltTotCli := 0;

   cdsTot.Filtered := False;
   cdsTot.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
   cdsTot.Filtered := True;


   cdsTot.First;
   while Not cdsTot.Eof do
   begin
     if (strCodCli = cdsTot.FieldByName('CTR_CODCLI').AsString) then
        fltTotCli := fltTotCli + cdsTot.FieldByName('CTR_VALREC').AsFloat;
     cdsTot.Next;
   end;

   result := fltTotCli;

   FreeAndNil(cdsTot);

End;

function TfrmRelCtrReimpressaoDocsList.fImprimeReciboLayoutPersonalizado: Boolean;
  Var
    reciboCtrMf : TReciboCtrMeiaFolha;
    cdsRelCtr   : TUniClientDataSet;
    editorFast  : TFastPrintFileEditor;
    reciboCtr   : TReciboCtr;
    reciboCtrReimpressao : TReciboCtrReimpressao;
    intCampos   : Integer;
    strNomCli   : String;
    qryConCli   : TUniQuery;

    fltValDin,
    fltValCqV,
    fltValCqP,
    fltValCar,
    fltValOrd,
    fltValCredito: Double;

    strHisBai,
    strPorbai,
    strOpeBai : String;

    sltSeqCon,
    sltCodEmp : TStringList;

    LValorTotal,
    LValorCreditoGerado,
    LValorBoleto: Double;
begin
  sltSeqCon := TStringList.Create;
  sltCodEmp := TStringList.Create;

  fltValDin     := 0 ;
  fltValCqV     := 0 ;
  fltValCqP     := 0 ;
  fltValCar     := 0 ;
  fltValOrd     := 0 ;
  fltValCredito := 0 ;

  strHisBai := '';
  strPorbai := '';
  strOpeBai := '';

  cdsRelCtr   := fCriaClientDatasetReciboCTR;
  cdsImpRecCG   := fCriaClientDatasetReciboCTR;

  Result := False;

  LValorTotal := 0.00;
  LValorCreditoGerado := 0.00;

  FListaBaixas := TStringList.Create;

  cdsGenCtr.First;
  While Not cdsGenCtr.Eof Do
  Begin
    fltValDin     := fltValDin + cdsGenCtr.FieldByName('CTR_DINHEI').AsFloat ;
    fltValCqV     := fltValCqV + cdsGenCtr.FieldByName('CTR_CHQAVI').AsFloat ;
    fltValCqP     := fltValCqP + cdsGenCtr.FieldByName('CTR_CHQPRE').AsFloat ;
    fltValCar     := fltValCar + cdsGenCtr.FieldByName('CTR_CARTAO').AsFloat ;
    fltValOrd     := fltValOrd + cdsGenCtr.FieldByName('CTR_ORDPAG').AsFloat ;

    If (Not MatchStr(cdsGenCtr.FieldByName('CTR_SEQCON').AsString, ['', '0'])) And //validação para registros muito antigos ou convertidos fora do padrão
       (Not MatchStr(cdsGenCtr.FieldByName('CTR_DTABAI').AsString, ['', '0'])) Then
    Begin
      If FListaBaixas.IndexOf(Concat(cdsGenCtr.FieldByName('CTR_SEQCON').AsString, '-',
                                     cdsGenCtr.FieldByName('CTR_EMPBAI').AsString, '-',
                                     FormatDateTime('yyyy/mm/dd', cdsGenCtr.FieldByName('CTR_DTABAI').AsDateTime))) = -1 Then
        FListaBaixas.Add(Concat(cdsGenCtr.FieldByName('CTR_SEQCON').AsString, '-',
                                cdsGenCtr.FieldByName('CTR_EMPBAI').AsString, '-',
                                FormatDateTime('yyyy/mm/dd', cdsGenCtr.FieldByName('CTR_DTABAI').AsDateTime)));
    End;

   If fEmptyStr(strPorbai) Then
    Begin
      strHisBai := cdsGenCtr.FieldByName('DESCRI').AsString ;
      strPorbai := cdsGenCtr.FieldByName('CTR_PORBAI').AsString + ' - ' + fRetNomPortador(cdsGenCtr.FieldByName('CTR_PORBAI').AsString);
      strOpeBai := cdsGenCtr.FieldByName('OPEBAI').AsString + ' - ' + fRetNomeOperador(cdsGenCtr.FieldByName('OPEBAI').AsString);
    End;

    If (cdsGenCtr.FieldByName('CTR_VALREC').AsFloat < 0) And
        Not fEmptyStr(cdsGenCtr.FieldByName('OPEBAI').AsString) Then
      fltValCredito := fltValCredito + cdsGenCtr.FieldByName('CTR_VALREC').AsFloat;

    If (Pos( cdsGenCtr.FieldByName('CTR_SEQCON').AsString,sltSeqCon.Text) <= 0 ) Then
    Begin
      sltCodEmp.Add(cdsGenCtr.FieldByName('CTR_EMPBAI').AsString);
      sltSeqCon.Add(cdsGenCtr.FieldByName('CTR_SEQCON').AsString);
    End;

    LValorTotal := LValorTotal + fFormataFloat(cdsGenCtr.FieldByName('CTR_VALREC').AsFloat, 2);

    cdsGenCtr.Next;
  End;

  LValorBoleto  := RetornaValorBaixadoBoleto;

  FreeAndNil(FListaBaixas);

  With cdsGenCtr Do
  Begin
    First;
    While Not Eof Do
    Begin
      cdsRelCtr.Append;

      For intCampos := 0 To cdsRelCtr.Fields.Count -1 Do
      Begin
        If FindField(cdsRelCtr.Fields[intCampos].FieldName) <> nil Then
          cdsRelCtr.Fields[intCampos].Value :=
            FindField(cdsRelCtr.Fields[intCampos].FieldName).Value;
      End;
      cdsRelCtr.FieldByName('SEQCON').AsInteger := FieldByName('CTR_SEQCON').AsInteger;

      qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
      pPesquisaCadCli(qryConCli, qryConCli, FieldByName('CTR_CODCLI').AsString);
      strNomCli := qryConCli.FieldByName('CLI_NOMCLI').AsString;
      cdsRelCtr.FieldByName('NOMCLI').AsString := strNomCli;
      cdsRelCtr.FieldByName('FANSOB').AsString := qryConCli.FieldByName('CLI_FANSOB').AsString;
      cdsRelCtr.FieldByName('ENDERE').AsString := qryConCli.FieldByName('CLI_ENDERE').AsString;
      cdsRelCtr.FieldByName('ENDNUM').AsString := qryConCli.FieldByName('CLI_ENDNUM').AsString;
      cdsRelCtr.FieldByName('ENDCMP').AsString := qryConCli.FieldByName('CLI_ENDCOM').AsString;
      cdsRelCtr.FieldByName('BAIRRO').AsString := qryConCli.FieldByName('CLI_BAIRRO').AsString;
      cdsRelCtr.FieldByName('C_E_P_').AsString := qryConCli.FieldByName('CLI_C_E_P_').AsString;
      cdsRelCtr.FieldByName('CIDADE').AsString := fRetNomCidade(qryConCli.FieldByName('CLI_CODCID').AsString);
      cdsRelCtr.FieldByName('ESTADO').AsString := fRetUFCliente(FieldByName('CTR_CODCLI').AsString);
      cdsRelCtr.FieldByName('C_G_C_').AsString := qryConCli.FieldByName('CLI_C_G_C_').AsString;
      cdsRelCtr.FieldByName('FONE01').AsString := qryConCli.FieldByName('CLI_FONE01').AsString;
      cdsRelCtr.FieldByName('NOMCON').AsString := fRetCliConsumidor(cdsGenCtr.FieldByName('CTR_CODCLI').AsString, cdsGenCtr.FieldByName('CTR_NUMDUP').AsString,
                                                                    cdsGenCtr.FieldByName('CTR_ESPDOC').AsString, cdsGenCtr.FieldByName('CTR_CODEMP').AsString);
      cdsRelCtr.FieldByName('TOTCLI').AsFloat  := fRetornaTotalCliente( FieldByName('CTR_CODCLI').AsString, cdsGenCtr );

      cdsRelCtr.FieldByName('DESCHISBAI').AsString :=  strHisBai;
      cdsRelCtr.FieldByName('DESCPORBAI').AsString :=  strPorBai;
      cdsRelCtr.FieldByName('DESCOPEBAI').AsString :=  strOpeBai;

      cdsRelCtr.FieldByName('CTR_DINHEI').AsFloat  := fltValDin;
      cdsRelCtr.FieldByName('CTR_CHQAVI').AsFloat  := fltValCqV;
      cdsRelCtr.FieldByName('CTR_CHQPRE').AsFloat  := fltValCqP;
      cdsRelCtr.FieldByName('CTR_CARTAO').AsFloat  := fltValCar;
      cdsRelCtr.FieldByName('CTR_ORDPAG').AsFloat  := fltValOrd;
      cdsRelCtr.FieldByName('CTR_CREDITO').AsFloat := fltValCredito;
       cdsRelCtr.FieldByName('CTR_ABERTO').AsFloat := fRetornaReceberAberto(FieldByName('CTR_CODCLI').AsString);

      cdsRelCtr.FieldByName('CTR_SALDO').AsFloat  := fRetornaSaldoAbertoCliente( cdsGenCtr.FieldByName('CTR_CODCLI').AsString );
      cdsRelCtr.FieldByName('CTR_ABERTO').AsFloat := fRetornaReceberAberto(cdsGenCtr.FieldByName('CTR_CODCLI').AsString);

      cdsRelCtr.FieldByName('CTR_TOTBLT').AsFloat := fRetornaReceberTotalBoletosEmAberto(cdsGenCtr.FieldByName('CTR_CODCLI').AsString);
      cdsRelCtr.FieldByName('CTR_TOTCRD').AsFloat := fRetornaReceberTotalCrediarioEmAberto(cdsGenCtr.FieldByName('CTR_CODCLI').AsString);
      cdsRelCtr.FieldByName('CTR_TOTCHD').AsFloat := fRetornaReceberTotalChequesDevolvidosEmAberto(cdsGenCtr.FieldByName('CTR_CODCLI').AsString);

      cdsRelCtr.FieldByName('DINHEIRO_SEM_BOLETO').AsFloat := fFormataFloat(fltValDin - LValorBoleto, 2);
      cdsRelCtr.FieldByName('VALOR_BOLETO').AsFloat := fFormataFloat(LValorBoleto, 2);
      cdsRelCtr.FieldByName('DTABAI').AsDateTime    := cdsGenCtr.FieldByName('CTR_DTABAI').AsDateTime;
      cdsRelCtr.FieldByName('SEQBAI').AsInteger     := cdsGenCtr.FieldByName('CTR_SEQBAI').AsInteger;
      cdsRelCtr.FieldByName('EMPBAI').AsString      :=  FieldByName('CTR_EMPBAI').AsString;
      cdsRelCtr.FieldByName('PORBAI').AsString      :=  FieldByName('CTR_PORBAI').AsString;

      cdsRelCtr.FieldByName('DUPLICATA_TROCO').AsString := untReciboCtr.DuplicataCreditoReferenteATroco(cdsRelCtr);
      If cdsRelCtr.FieldByName('DUPLICATA_TROCO').AsString.Equals('S') Then
        cdsRelCtr.FieldByName('VALOR_TROCO').AsFloat := Abs(cdsRelCtr.FieldByName('VALREC').AsFloat);

      cdsRelCtr.Post;

      Next;
    End;

    First;
  End;

  editorFast := TFastPrintFileEditor.Create(Self);


  If fCfgSis('RECCTR') = 'N' Then
  begin

    If FSomaCreditos Then
    Begin
      If Not cdsRelCtr.IsEmpty And (sltSeqCon.Count = 1) Then
        pCriarClientCreditoGerado(sltSeqCon,
                                  sltCodEmp,
                                  cdsGenCtr.FieldByName('RESCAI').AsString,
                                  LValorCreditoGerado);
    End;

    LValorTotal := LValorTotal + LValorCreditoGerado;

    If fEmptyStr(strTipImp) Or fEmptyStr(strNomeFila)  Then
    Begin
      pCarregaConfImpr(qryCfgRel, 'frmRelCtrReimpressaoDocsList');
      fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);
    End;

    If fLoadReportReimpressao(strTipImp) Then
    Begin

      reciboCtrReimpressao  := TReciboCtrReimpressao.CreateInstance(cdsRelCtr,
                                                                    LValorCreditoGerado,
                                                                    LValorTotal,
                                                                    cdsImpRecCG,
                                                                    True);

      editorFast.pSetFastPrintFile(reciboCtrReimpressao);

      If Not reciboCtrReimpressao.IsEmpty Then
      Begin


        If editorFast.fLoadReport Then
        Begin
          reciboCtrReimpressao.pSetFastType(strTipImp);

          If fMensagem('','Opção:',['&Vídeo','&Impressora']) = 1 Then
             editorFast.pPreview
          Else
          Begin

            reciboCtrReimpressao.NomImp := strNomeFila;

            editorFast.pSetFastPrintFile(reciboCtrReimpressao);
            editorFast.pPrint;
          end;

          Result := True;
        End;

      end;

    End
    Else
    Begin

      reciboCtr  := TReciboCtr.CreateInstance(cdsRelCtr,
                                              LValorCreditoGerado,
                                              LValorTotal,
                                              cdsImpRecCG,
                                              True);

      editorFast.pSetFastPrintFile(reciboCtr);

      If Not reciboCtr.IsEmpty Then
      Begin


        If editorFast.fLoadReport Then
        Begin
          reciboCtr.pSetFastType(strTipImp);

          If fMensagem('','Opção:',['&Vídeo','&Impressora']) = 1 Then
             editorFast.pPreview
          Else
          Begin

            reciboCtr.NomImp := strNomeFila;

            editorFast.pSetFastPrintFile(reciboCtr);
            editorFast.pPrint;
          end;

          Result := True;
        End;

      end;

    End;

  End
  else
  begin

    reciboCtrMf  := TReciboCtrMeiaFolha.CreateInstance(cdsRelCtr);
    editorFast.pSetFastPrintFile(reciboCtrMf);

    If Not reciboCtrMf.IsEmpty Then
    Begin

      If editorFast.fLoadReport Then
      Begin
        If fMensagem('','Opção:',['&Vídeo','&Impressora']) = 1 Then
          editorFast.pPreview
        Else
        Begin
          pCarregaConfImpr(qryCfgRel, 'frmRelCtrReimpressaoDocsList');
          fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

          reciboCtrMf.NomImp := strNomeFila;

          editorFast.pSetFastPrintFile(reciboCtrMf);
          editorFast.pPrint;
        end;

        Result := True;
      End;

    end

  End;

  FreeAndNil(cdsRelCtr);
  FreeAndNil(cdsImpRecCG);
  FreeAndNil(editorFast);
  FreeAndNil(sltCodEmp);
  FreeAndNil(sltSeqCon);
end;

Function TfrmRelCtrReimpressaoDocsList.fVerificaJaIncluido( strCodEmp, strSeqCon, strNumAge, strNumChq : String; cdsChq: TUniClientDataSet ) : Boolean;
 Var blnResult : Boolean;
Begin

   cdsChq.Filtered := False;
   cdsChq.Filter   := '     CHQ_SEQCON = ' + QuotedStr(strSeqCon) +
                      ' AND CHQ_CODEMP = ' + QuotedStr(strCodEmp) +
                      ' AND CHQ_NUMAGE = ' + QuotedStr(strNumAge) +
                      ' AND CHQ_NUMCHQ = ' + QuotedStr(strNumChq) ;

   cdsChq.Filtered := True;

   blnResult := (Not cdsChq.IsEmpty);

   Result := blnResult;

   cdsChq.Filtered := False;

End;

function TfrmRelCtrReimpressaoDocsList.ModoVideo: Boolean;
  Var
    LLayout : String;
begin
  Result := False;

  LLayout := fCfgSis('RECRCX');
  If LLayout.Equals('B') Then
    Result := (fMensagem('','Opção:',['&Vídeo','&Impressora'])= 1);
end;

Procedure TfrmRelCtrReimpressaoDocsList.pCarregaCheques( strTipo, strSeqcon, strCodEmp : String; cdsChq: TUniClientDataSet );
  Var
     qryChq: TUniQuery;
     strSQL: String;
Begin

    Try
      qryChq := fCriaQuery();

      strSQL :=          ' SELECT CHQ_NUMAGE, CHQ_CONCOR, CHQ_NUMCHQ, CHQ_NOMEMI, CHQ_C_G_C_, CHQ_DTAVEN, CHQ_VALCHQ, CHQ_SEQCON, CHQ_CODEMP ';
      strSQL := strSQL + '   FROM CADCHQ ';
      strSQL := strSQL + '  WHERE CHQ_SEQCON = :SEQCON AND CHQ_CODEMP = :CODEMP ';

      strSQL := strSQL + IIF( strTipo = 'V', ' AND CHQ_DTACAD = CHQ_DTAVEN ', ' AND CHQ_DTACAD <> CHQ_DTAVEN ' );

      qryChq.Close;
      qryChq.SQL.Clear;
      qryChq.SQL.Add(strSQL);
      qryChq.ParamByName('SEQCON').AsString := strSeqcon;
      qryChq.ParamByName('CODEMP').AsString := strCodEmp;
      qryChq.Open;

      If Not qryChq.IsEmpty Then
      Begin
        qryChq.First;
        While Not qryChq.Eof Do
        Begin

          // Verifica se ja existe os cheques desta seqcon na cds
          If Not fVerificaJaIncluido(qryChq.FieldByName('CHQ_CODEMP').AsString,
                                     qryChq.FieldByName('CHQ_SEQCON').AsString,
                                     qryChq.FieldByName('CHQ_NUMAGE').AsString,
                                     qryChq.FieldByName('CHQ_NUMCHQ').AsString, cdsChq ) Then
          Begin

            cdsChq.Insert;
            cdsChq.FieldByName('CHQ_NUMAGE').AsString   := qryChq.FieldByName('CHQ_NUMAGE').AsString;
            cdsChq.FieldByName('CHQ_CONCOR').AsString   := qryChq.FieldByName('CHQ_CONCOR').AsString;
            cdsChq.FieldByName('CHQ_NUMCHQ').AsString   := qryChq.FieldByName('CHQ_NUMCHQ').AsString;
            cdsChq.FieldByName('CHQ_NOMEMI').AsString   := qryChq.FieldByName('CHQ_NOMEMI').AsString;
            cdsChq.FieldByName('CHQ_C_G_C_').AsString   := qryChq.FieldByName('CHQ_C_G_C_').AsString;
            cdsChq.FieldByName('CHQ_DTAVEN').AsDateTime := qryChq.FieldByName('CHQ_DTAVEN').AsDateTime;
            cdsChq.FieldByName('CHQ_VALCHQ').AsFloat    := qryChq.FieldByName('CHQ_VALCHQ').AsFloat;

            cdsChq.FieldByName('CHQ_SEQCON').AsString    := qryChq.FieldByName('CHQ_SEQCON').AsString;
            cdsChq.FieldByName('CHQ_CODEMP').AsString    := qryChq.FieldByName('CHQ_CODEMP').AsString;
            cdsChq.Post;

          End;

          qryChq.Next;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        FreeAndNil(qryChq);
        pMensagensErro(E.Message,'[TfrmRelCtrReimpressaoDocsList.pCarregaCheques]');
      End;
    End;
    FreeAndNil(qryChq);

End;

Function TfrmRelCtrReimpressaoDocsList.pVerificaRegistrosEspDiferentesSelecionados(): Boolean;
  Var
    cdsVer: TUniClientDataSet;
    blnTemLD,
    blnTemOutras : Boolean;
begin
  blnTemLD     := False;
  blnTemOutras := False;

  Try
    cdsVer := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsVer, cdsGenCtr);

    cdsVer.Filtered := False;
    cdsVer.Filter   := 'CTR_MARDES = ' + QuotedStr('M') + ' AND ESPDOC = ' + QuotedStr('LC');
    cdsVer.Filtered := True;

    If Not cdsVer.IsEmpty Then
       blnTemLD := True;

    cdsVer.Filtered := False;
    cdsVer.Filter   := 'CTR_MARDES = ' + QuotedStr('M') + ' AND ESPDOC <> ' + QuotedStr('LC');
    cdsVer.Filtered := True;

    If Not cdsVer.IsEmpty Then
       blnTemOutras := True;

    Result := (blnTemLD And blnTemOutras);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'Erro ao verificar registros selecionados !','[pVerificaRegistrosEspDiferentesSelecionados]');
    End;
  End;

End;

function TfrmRelCtrReimpressaoDocsList.RetornaValorBaixadoBoleto: Double;
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

Function TfrmRelCtrReimpressaoDocsList.fLoadReportReimpressao(strATipImp : String) : Boolean;
Var
  FLayImp : TUniQuery;
begin
  Result := False;

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
        ParamByName('CODLAY').AsString := 'RECCRI';
        ParamByName('TIPLAY').AsString := IIF(strATipImp = 'J','L','M');

        Add('ORDER BY');
        Add('  LAY_DTAALT DESC,');
        Add('  LAY_HORALT DESC ');
        Add('LIMIT 1');
        Open;

        If Not IsEmpty Then
          Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fLoadReportReimpressao]');
      End;
    End;
  Finally
   pFreeAndNil(FLayImp);
  End;
end;

end.

