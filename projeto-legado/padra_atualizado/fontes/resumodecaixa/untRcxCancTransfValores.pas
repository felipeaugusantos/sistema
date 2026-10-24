{**********************************************************}
{* TELA CRIADA PARA EFETUAR LANÇAMENTOS DE CONTRA-PARTIDA *}
{* PARA TRANSFERÊNCIAS DE CAIXA FEITAS EQUIVOCADAMENTE    *}
{**27/12/2013**REQUISITO 11726 REZENDE******************JU*}

unit untRcxCancTransfValores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  Uni, UniClientDataSet, UniDataSetProvider, StrUtils, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass,
  frxExportCSVTestabilidade, System.Generics.Collections, untMovCar, untLiberacao,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untRcxTResumoDeCaixa;

type
  TfrmRcxCancTransfValores = class(TfrmPai)
    pnlTransferencias: TPanel;
    pnlDetalhes: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    dbgTransferenciasDBTableView1: TcxGridDBTableView;
    dbgTransferenciasLevel1: TcxGridLevel;
    dbgTransferencias: TcxGrid;
    edtDesComp: TEditFocus;
    edtValDin: TEditFocus;
    edtValCar: TEditFocus;
    edtValOpg: TEditFocus;
    edtValChp: TEditFocus;
    edtValChq: TEditFocus;
    Label1: TLabel;
    lblDinheiro: TLabel;
    lblCartao: TLabel;
    lblChequePre: TLabel;
    lblChequeAVista: TLabel;
    lblOrdemPagamento: TLabel;
    dbgTransferenciasDBTableView1RCX_DTACAD: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_HORCAD: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_SEQCON: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_OPERAD: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_DESCRI: TcxGridDBColumn;
    dbgTransferenciasDBTableView1RCX_VALDOC: TcxGridDBColumn;
    btnMarcar: TBitBtnLocked;
    btnDesmarcar: TBitBtnLocked;
    dbgTransferenciasDBTableView1RCX_MARDES: TcxGridDBColumn;
    lblFundoDeCaixa: TLabel;
    edtFundoDeCaixa: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure dbgTransferenciasDBTableView1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure dbgTransferenciasDBTableView1DblClick(Sender: TObject);
    procedure dbgTransferenciasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure btnDesmarcarClick(Sender: TObject);
  private
    { Private declarations }
    cdsTransf: TUniClientDataSet;
    dtsTransf: TDataSource;
    strChaLck: String;
    objLiberacao: TLiberacao;

    procedure pAfterScroll(DataSet: TDataSet);
    procedure pCriaTemporaria;
    procedure pCancelaTransf;
    procedure pSelecionaRegistro(blnMarDes: Boolean);
    function fValidaChequeCartao(intSeqCon: Integer; strCodEmp: String): Boolean;
    function fVerificaSaldoMaximoCaixa(): Boolean;
    function fMovCarSeqCon(intSeqCon: Integer; strCodEmp: String; ADataCaixa: TDateTime): String;

    function RetornaSQLCondicaoPix: String;

    procedure CancelarTransferencia;

    function RetornaCartoesPelaListaSeqCons(ASeqconCartoes: String;
                                            ADatasetTransferencia: TDataset): TUniClientDataset;

    function PermitidoRealizarOCancelamentoDaTf: Boolean;

    function RetornaAutoIncremsLogChq(ADatasetTransferencia: TDataset): TStringList;
  public
    { Public declarations }
    strCodOpe: String;
    dtaDtaRcx: TDateTime;

    strCodigoCaixa  : String;
    objResumoDeCaixa: TResumoDeCaixa;
  end;

implementation

uses untFuncoes, untFuncoesSimples, untCadRcxx, untMovBan, untCadChq,  untFuncoesRel, untFuncoesRel2,
  untTCadChqRepository, untTBanTrf, untPafGerais, untLogMca,
  untGravando, untLogCba, untLogChq;

{$R *.dfm}

procedure TfrmRcxCancTransfValores.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If Not btnConfirmaDados.Enabled Then
    Exit;

  cdsTransf.DisableControls;
  cdsTransf.Filtered := False;
  cdsTransf.Filter   := 'RCX_MARDES = ' + QuotedStr('M');
  cdsTransf.Filtered := True;

  Try
    If cdsTransf.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Selecione um registro para fazer o cancelamento!', ['&Ok']);

      Exit;
    End;

    If fMensagem('ATENÇÃO', 'Deseja cancelar a transferência - Seq. ' + cdsTransf.FieldByName('RCX_SEQCON').AsString +
                            ' no valor de R$ ' + FormatFloat('#,##0.00',cdsTransf.FieldByName('RCX_VALDOC').AsFloat) + ' ?',
                            ['&Sim', '&Não']) = 2 Then
      Exit;
    
    TfrmGravando.fExecutarModal(CancelarTransferencia, 'Aguarde... Cancelando transferência.', '');
  Finally
    cdsTransf.Filtered := False;
    cdsTransf.EnableControls;
    cdsTransf.IndexFieldNames := 'RCX_DTACAD;RCX_HORCAD';
    cdsTransf.First;
  End;
end;

procedure TfrmRcxCancTransfValores.btnDesmarcarClick(Sender: TObject);
begin
  inherited;
  pSelecionaRegistro(False);
end;

procedure TfrmRcxCancTransfValores.btnMarcarClick(Sender: TObject);
begin
  inherited;
  pSelecionaRegistro(True);
end;

procedure TfrmRcxCancTransfValores.CancelarTransferencia;
begin
  Try
    If PermitidoRealizarOCancelamentoDaTf Then
    Begin
      btnConfirmaDados.Enabled := False;
      pCancelaTransf;
      btnConfirmaDados.Enabled := True;

      Exit;
    End;

    Self.Close;

  Except
    On E: exception Do
      pMensagensErro(E.Message, '[TfrmRcxCancTransfValores.btnConfirmaDadosClick]');
  End;

  fLock_Unlock(strChaLck, False);
end;

procedure TfrmRcxCancTransfValores.dbgTransferenciasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes : String;
begin
  inherited;

  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgTransferenciasDBTableView1RCX_MARDES.Index]);
  If (cdsTransf.IsEmpty) Or fEmptyStr(strMarDes) Then
    Exit;

  If (strMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;
  End;
  
end;

procedure TfrmRcxCancTransfValores.dbgTransferenciasDBTableView1DblClick(
  Sender: TObject);
  Var
    blnMarDes: Boolean;
begin
  inherited;
  blnMarDes := cdsTransf.FieldByName('RCX_MARDES').AsString <> 'M';

  pSelecionaRegistro(blnMarDes);

end;

procedure TfrmRcxCancTransfValores.dbgTransferenciasDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    blnMarDes: Boolean;
begin
  inherited;

  If Key = VK_RETURN Then
  Begin
    blnMarDes := cdsTransf.FieldByName('RCX_MARDES').AsString <> 'M';
    pSelecionaRegistro(blnMarDes);
  End;

end;

procedure TfrmRcxCancTransfValores.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(dbgTransferencias);

end;

procedure TfrmRcxCancTransfValores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);

  inherited;

  FreeAndNil(cdsTransf);
  FreeAndNil(dtsTransf);

  fLock_Unlock(strChaLck, False);

end;

procedure TfrmRcxCancTransfValores.FormCreate(Sender: TObject);
begin
  inherited;

  cdsTransf := TUniClientDataSet.Create(Self);
  dtsTransf := TDataSource.Create(Self);
  cdsTransf.AfterScroll := pAfterScroll;

  dtsTransf.DataSet := cdsTransf;
  dbgTransferenciasDBTableView1.DataController.DataSource := dtsTransf;
  objLiberacao := TLiberacao.Create;

  strCodigoCaixa := '';
end;

procedure TfrmRcxCancTransfValores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_ESCAPE Then
    btnSair.Click
  Else If Key = VK_F8 Then
    btnMarcar.Click
  Else If Key = VK_F9 Then
    btnDesmarcar.Click
  Else If Key = VK_F10 Then
    btnConfirmaDados.Click;

end;

procedure TfrmRcxCancTransfValores.FormShow(Sender: TObject);
begin
  inherited;
  pCriaTemporaria;

  lblFundoDeCaixa.Visible := (objResumoDeCaixa.strTipoFechamento = 'C') And
                             (Not fCfgSis('FECZER', varBoolean));
  edtFundoDeCaixa.Visible := lblFundoDeCaixa.Visible;
end;

function TfrmRcxCancTransfValores.fValidaChequeCartao(intSeqCon: Integer; strCodEmp: String): Boolean;
begin

  Result := True;

  If Assigned(prcExecutaRelatorio) Then
  begin
    Result := not fncExecutaRelatorio(178, 7421, [],
                        ['SEQCON','CODEMP'],
                        [IntToStr(intSeqCon), strCodEmp],
                        nil,
                        nil,
                        True,
                        False);
  End;

  If not Result Then
  Begin
    fMensagem('','Existem registros vinculados a esta transferência que já foram depositados e/ou sofreram baixas. ' + #13#10 +
                 'Realize o cancelamento do depósito e/ou o estorno das baixas. '+ #13#10 +
                 'Não será possível prosseguir com o cancelamento da transferência!', ['&Ok'] );
    fLock_Unlock(strChaLck, False);
  End;

end;

function TfrmRcxCancTransfValores.fVerificaSaldoMaximoCaixa(): Boolean;
var
  fltDinRec: Double;
begin
  fltDinRec := cdsTransf.FieldByName('RCX_DINREC').AsFloat;
  fltDinRec := Abs(fltDinRec);
  Result := objResumoDeCaixa.fVerificaSaldoMaximo(fltDinRec, strCodOpe, strCodigoCaixa);
end;

procedure TfrmRcxCancTransfValores.pAfterScroll(DataSet: TDataSet);
begin

  edtDesComp.Text := DataSet.FieldByName('RCX_DESCRI').AsString;
  edtValDin.Text  := FormatFloat('#,##0.00', DataSet.FieldByName('RCX_DINREC').AsFloat);
  edtValCar.Text  := FormatFloat('#,##0.00', DataSet.FieldByName('RCX_CARREC').AsFloat);
  edtValChq.Text  := FormatFloat('#,##0.00', DataSet.FieldByName('RCX_CHQAVI').AsFloat);
  edtValChp.Text  := FormatFloat('#,##0.00', DataSet.FieldByName('RCX_CHQPRE').AsFloat);
  edtValOpg.Text  := FormatFloat('#,##0.00', DataSet.FieldByName('RCX_ORDREC').AsFloat);

  lblOrdemPagamento.Caption := 'Ordem de pagamento:';
  If DataSet.FieldByName('RCX_RECPIX').AsString.Equals('S') Then
  Begin
    If fFormataFloat(DataSet.FieldByName('RCX_ORDREC').AsFloat, 2) <> 0 Then
      lblOrdemPagamento.Caption := 'Pix avulso:';
  End;

  edtFundoDeCaixa.Text  := FormatFloat('#,##0.00', DataSet.FieldByName('RCX_FUNCAX').AsFloat);
end;

procedure TfrmRcxCancTransfValores.pCancelaTransf;
  Var
    qryUpdate : TUniQuery;
    qryMovBan : TUniQuery;
    qryCadRcx : TUniQuery;
    strSQL    : String;
    strAutinc : String;
    strSeqBan : String;
    intSeqCon : Integer;

    LConsultaCartoes: TUniClientDataSet;

    objBanTfrOrig: TBanTrfDs;
    LBanTrfOriginal: TUniQuery;
    lstBanTrf : TListaBanTrf;

    LSeqconCartoes,
    LAutoIncrem: String;
begin
  qryMovBan := fCriaQuery(Nil);
  qryUpdate := fCriaQuery(Nil);
  qryCadRcx := fCriaQuery(Nil);

  Try
    cdsTransf.First;

    While Not cdsTransf.Eof Do
    Begin
      If cdsTransf.FieldByName('RCX_MARDES').AsString = 'M' Then
      Begin
        If (fUtilizaImpressaoDeSangriaNoPDV) Then
        Begin
          If (fSangriaFoiImpressaNoPDV(cdsTransf.FieldByName('RCX_SEQCON').AsInteger,
                                       cdsTransf.FieldByName('RCX_CODEMP').AsString,
                                       fNumeroSerieImpressora(cdsTransf.FieldByName('RCX_CODEMP').AsString))) Then
          Begin
            fMensagem('', 'A sangria já foi impressa no PDV não é possível cancelar!', ['&Ok']);
            Exit;
          End;
        End;

        If Not fVerificaSaldoMaximoCaixa() Then
          Exit;

        {*************************************************}
        {* DEVE SER CHAMADO ANTES DA TRANSACAO PRINCIPAL *}
        {*********************************************JC**}
        intSeqCon := StrToInt(fRetRcxCon);

        fStartTransaction;

        If (fUtilizaImpressaoDeSangriaNoPDV) Then
        Begin
          pDeletarSangriaNaoImpressaNoPDV(cdsTransf.FieldByName('RCX_SEQCON').AsInteger,
                                          cdsTransf.FieldByName('RCX_CODEMP').AsString,
                                          fNumeroSerieImpressora(cdsTransf.FieldByName('RCX_CODEMP').AsString));
        End;

        Try
          strSQL := '';
          strSQL := strSQL + ' SELECT                     ';
          strSQL := strSQL + '   CTB_SEQLAN,              ';
          strSQL := strSQL + '   CTB_CODCTA,              ';
          strSQL := strSQL + '   CTB_CODPOR,              ';
          strSQL := strSQL + '   CTB_CODOPE,              ';
          strSQL := strSQL + '   CTB_DTALAN,              ';
          strSQL := strSQL + '   CTB_HORLAN,              ';
          strSQL := strSQL + '   CTB_NUMDOC,              ';
          strSQL := strSQL + '   CTB_CREDEB,              ';
          strSQL := strSQL + '   CTB_VALLAN,              ';
          strSQL := strSQL + '   CTB_HIST01,              ';
          strSQL := strSQL + '   CTB_HIST02,              ';
          strSQL := strSQL + '   CTB_CODEMP,              ';
          strSQL := strSQL + '   CTB_CODCLI,              ';
          strSQL := strSQL + '   CTB_CODFOR,              ';
          strSQL := strSQL + '   CTB_SEQBAI,              ';
          strSQL := strSQL + '   CTB_PARCEL,              ';
          strSQL := strSQL + '   CTB_EMPDUP,              ';
          strSQL := strSQL + '   CTB_NUMDUP,              ';
          strSQL := strSQL + '   CTB_SERIE_,              ';
          strSQL := strSQL + '   CTB_CODEVE,              ';
          strSQL := strSQL + '   CTB_DTACON,              ';
          strSQL := strSQL + '   CTB_HORCON,              ';
          strSQL := strSQL + '   CTB_OPECON,              ';
          strSQL := strSQL + '   CTB_SEQCTP,              ';
          strSQL := strSQL + '   CTB_DOCBAI,              ';
          strSQL := strSQL + '   CTB_SEQTRF,              ';
          strSQL := strSQL + '   CTB_CODVEL,              ';
          strSQL := strSQL + '   CTB_PAGCON,              ';
          strSQL := strSQL + '   CTB_TRFLIB               ';
          strSQL := strSQL + ' FROM                       ';
          strSQL := strSQL + '   MOVBAN                   ';
          strSQL := strSQL + ' WHERE                      ';
          strSQL := strSQL + '   CTB_CODEMP = :CODEMP     ';
          strSQL := strSQL + '   AND CTB_SEQTRF = :SEQCON ';
          strSQL := strSQL + '   AND CTB_DTALAN >= :DTALAN ';

          qryMovBan.Close;
          qryMovBan.SQL.Clear;
          qryMovBan.SQL.Add(strSQL);
          qryMovBan.ParamByName('SEQCON').AsInteger := cdsTransf.FieldByName('RCX_SEQCON').AsInteger;
          qryMovBan.ParamByName('CODEMP').AsString  := cdsTransf.FieldByName('RCX_CODEMP').AsString;
          qryMovBan.ParamByName('DTALAN').AsDateTime  := cdsTransf.FieldByName('RCX_DTACAD').AsDateTime;
          qryMovBan.Open;

          If qryMovBan.IsEmpty Then
            Raise exception.Create('Não foi encontrado um registro correspondente a esta transferência no Movimento bancário!!! - Validando MOVBAN');

          lstBanTrf := TListaBanTrf.Create;

          Try
            qryMovBan.First;
            While Not qryMovBan.Eof Do
            Begin
              If qryMovBan.FieldByName('CTB_TRFLIB').AsString = 'N' Then
              Begin
                qryMovBan.Edit;
                qryMovBan.FieldByName('CTB_TRFLIB').AsString := 'S';
                qryMovBan.Post;
              End;

              lstBanTrf.Clear;

              LBanTrfOriginal := fCriarQuery('SELECT * FROM BANTRF WHERE CTB_SEQLAN="' + qryMovBan.FieldByName('CTB_SEQLAN').AsString + '"');
              LBanTrfOriginal.Open;

              While Not LBanTrfOriginal.Eof Do
              Begin
                objBanTfrOrig := TBanTrfDS.Create;
                objBanTfrOrig.strCodOpe := LBanTrfOriginal.FieldByName('RCX_CODOPE').AsString;
                objBanTfrOrig.strCodEmp := LBanTrfOriginal.FieldByName('RCX_CODEMP').AsString;
                objBanTfrOrig.strDescri := LBanTrfOriginal.FieldByName('RCX_DESCRI').AsString;
                objBanTfrOrig.fltValDoc := LBanTrfOriginal.FieldByName('RCX_VALDOC').AsFloat;
                objBanTfrOrig.fltDinRec := LBanTrfOriginal.FieldByName('RCX_DINREC').AsFloat;
                objBanTfrOrig.fltChqAvi := LBanTrfOriginal.FieldByName('RCX_CHQAVI').AsFloat;
                objBanTfrOrig.fltChqPre := LBanTrfOriginal.FieldByName('RCX_CHQPRE').AsFloat;
                objBanTfrOrig.fltCarRec := LBanTrfOriginal.FieldByName('RCX_CARREC').AsFloat;
                objBanTfrOrig.fltOrdRec := LBanTrfOriginal.FieldByName('RCX_ORDREC').AsFloat;
                objBanTfrOrig.fltValFin := LBanTrfOriginal.FieldByName('RCX_VALFIN').AsFloat;

                lstBanTrf.Add(objBanTfrOrig);

                LBanTrfOriginal.Next;
              End;

              LBanTrfOriginal.Close;
              FreeAndNil(LBanTrfOriginal);

              strSeqBan := fGravaMovBan(qryMovBan.FieldByName('CTB_CODCTA').AsString,
                                        qryMovBan.FieldByName('CTB_CODPOR').AsString,
                                        qryMovBan.FieldByName('CTB_CODOPE').AsString,
                                        qryMovBan.FieldByName('CTB_DTALAN').AsDateTime,
                                        qryMovBan.FieldByName('CTB_HORLAN').AsDateTime,
                                        qryMovBan.FieldByName('CTB_NUMDOC').AsString,
                                        IIF(qryMovBan.FieldByName('CTB_CREDEB').AsString = 'C', 'D', 'C'),
                                        qryMovBan.FieldByName('CTB_CODEMP').AsString,
                                        qryMovBan.FieldByName('CTB_VALLAN').AsFloat,
                                        qryMovBan.FieldByName('CTB_HIST01').AsString,
                                        qryMovBan.FieldByName('CTB_HIST02').AsString,
                                        qryMovBan.FieldByName('CTB_CODCLI').AsString,
                                        qryMovBan.FieldByName('CTB_CODFOR').AsString,
                                        qryMovBan.FieldByName('CTB_NUMDUP').AsString,
                                        qryMovBan.FieldByName('CTB_SEQBAI').AsInteger,
                                        qryMovBan.FieldByName('CTB_PARCEL').AsString,
                                        qryMovBan.FieldByName('CTB_EMPDUP').AsString,
                                        qryMovBan.FieldByName('CTB_SERIE_').AsString,
                                        qryMovBan.FieldByName('CTB_CODEVE').AsString,
                                        qryMovBan.FieldByName('CTB_DOCBAI').AsString,
                                        Nil,
                                        intSeqCon,
                                        qryMovBan.FieldByName('CTB_PAGCON').AsInteger,
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        '',
                                        1,
                                        True,
                                        lstBanTrf);

              untLogCba.GravaLogCba(fCampoTabela('AUTOINCREM', 'MOVBAN', ['CTB_SEQLAN'], [strSeqBan]),
                                    'INCLUSÃO - TRANSFERÊNCIA CANCELAMENTO',
                                    Self.Name,
                                    '',
                                    Nil,
                                    VS_strCodigoOperadorLogadoCaixa);

              qryMovBan.Next;
            End;
          Finally
            FreeAndNil(lstBanTrf);
          End;

          If fEmptyStr(strSeqBan) Then
            Raise exception.Create('Ocorreu um erro na gravação do MOVBAN!!! - Inserindo registro de contra-partida');

          strSQL := '';
          strSQL := strSQL + 'SELECT                     ';
          strSQL := strSQL + '   RCX_CODCLI,             ';
          strSQL := strSQL + '   RCX_CODOPE,             ';
          strSQL := strSQL + '   RCX_NUMDOC,             ';
          strSQL := strSQL + '   RCX_ESPDOC,             ';
          strSQL := strSQL + '   RCX_CODEMP,             ';
          strSQL := strSQL + '   RCX_DTACAD,             ';
          strSQL := strSQL + '   RCX_HORCAD,             ';
          strSQL := strSQL + '   RCX_NUMDUP,             ';
          strSQL := strSQL + '   RCX_PARCEL,             ';
          strSQL := strSQL + '   RCX_DESCRI,             ';
          strSQL := strSQL + '   RCX_IDEFEC,             ';
          strSQL := strSQL + '   RCX_VALDOC,             ';
          strSQL := strSQL + '   RCX_VALDES,             ';
          strSQL := strSQL + '   RCX_VALJUR,             ';
          strSQL := strSQL + '   RCX_DINREC,             ';
          strSQL := strSQL + '   RCX_CHQAVI,             ';
          strSQL := strSQL + '   RCX_CHQPRE,             ';
          strSQL := strSQL + '   RCX_CARREC,             ';
          strSQL := strSQL + '   RCX_VALCRE,             ';
          strSQL := strSQL + '   RCX_OUTROS,             ';
          strSQL := strSQL + '   RCX_VENPRZ,             ';
          strSQL := strSQL + '   RCX_JURDES,             ';
          strSQL := strSQL + '   RCX_CODFPG,             ';
          strSQL := strSQL + '   RCX_NUMROM,             ';
          strSQL := strSQL + '   RCX_SEQCON,             ';
          strSQL := strSQL + '   RCX_ORDREC,             ';
          strSQL := strSQL + '   RCX_SEQBAI,             ';
          strSQL := strSQL + '   RCX_SQFCRX,             ';
          strSQL := strSQL + '   RCX_MOTDES,             ';
          strSQL := strSQL + '   RCX_EMPDUP,             ';
          strSQL := strSQL + '   RCX_IDECAI,             ';
          strSQL := strSQL + '   RCX_VALFIN,             ';
          strSQL := strSQL + '   RCX_TOTGUA,             ';
          strSQL := strSQL + '   RCX_TOTPES,             ';
          strSQL := strSQL + '   RCX_TOTDOL,             ';
          strSQL := strSQL + '   RCX_TOTEUR,             ';
          strSQL := strSQL + '   RCX_TOTREA,             ';
          strSQL := strSQL + '   RCX_TFCANC,             ';
          strSQL := strSQL + '   RCX_RECPIX,             ';
          strSQL := strSQL + '   RCX_CODCAX              ';
          strSQL := strSQL + 'FROM CADRCXX               ';
          strSQL := strSQL + 'WHERE RCX_CODEMP = :CODEMP ';
          strSQL := strSQL + '  AND RCX_SEQCON = :SEQCON ';
          strSQL := strSQL + '  AND RCX_DTACAD = :DTACAD ';

          qryCadRcx.Close;
          qryCadRcx.SQL.Text := strSQL;

          If Not strCodigoCaixa.IsEmpty Then
          Begin
            qryCadRcx.SQL.Add('  AND RCX_CODCAX = :CODCAX ');

            qryCadRcx.ParamByName('CODCAX').AsString := strCodigoCaixa;
          End;

          qryCadRcx.ParamByName('SEQCON').AsInteger := cdsTransf.FieldByName('RCX_SEQCON').AsInteger;
          qryCadRcx.ParamByName('CODEMP').AsString  := cdsTransf.FieldByName('RCX_CODEMP').AsString;
          qryCadRcx.ParamByName('DTACAD').AsDateTime := cdsTransf.FieldByName('RCX_DTACAD').AsDateTime;
          qryCadRcx.Open;

          qryCadRcx.First;
          While Not qryCadRcx.Eof Do
          Begin
            If Not fGravaCadRcx(strAutinc,
                                qryCadRcx.FieldByName('RCX_CODCLI').AsString,
                                qryCadRcx.FieldByName('RCX_CODOPE').AsString,
                                qryCadRcx.FieldByName('RCX_NUMDOC').AsString,
                                qryCadRcx.FieldByName('RCX_ESPDOC').AsString,
                                qryCadRcx.FieldByName('RCX_CODEMP').AsString,
                                qryCadRcx.FieldByName('RCX_DTACAD').AsDateTime,
                                qryCadRcx.FieldByName('RCX_HORCAD').AsDateTime,
                                qryCadRcx.FieldByName('RCX_NUMDUP').AsString,
                                qryCadRcx.FieldByName('RCX_PARCEL').AsString,
                                'REF. CANC. TRANSF. CAIXA No. ' + qryCadRcx.FieldByName('RCX_SEQCON').AsString + ' EMP ' + qryCadRcx.FieldByName('RCX_CODEMP').AsString,
                                qryCadRcx.FieldByName('RCX_JURDES').AsString,
                                qryCadRcx.FieldByName('RCX_IDEFEC').AsString,
                                qryCadRcx.FieldByName('RCX_CODFPG').AsString,
                                qryCadRcx.FieldByName('RCX_VALDOC').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_VALDES').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_VALJUR').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_DINREC').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_CHQAVI').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_CHQPRE').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_CARREC').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_ORDREC').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_VALCRE').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_VALFIN').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_OUTROS').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_VENPRZ').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_NUMROM').AsString,
                                intSeqCon,
                                qryCadRcx.FieldByName('RCX_SEQBAI').AsInteger,
                                qryCadRcx.FieldByName('RCX_SQFCRX').AsInteger,
                                qryCadRcx.FieldByName('RCX_EMPDUP').AsString,
                                qryCadRcx.FieldByName('RCX_MOTDES').AsString,
                                qryCadRcx.FieldByName('RCX_IDECAI').AsInteger,
                                qryCadRcx.FieldByName('RCX_TOTGUA').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_TOTDOL').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_TOTEUR').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_TOTPES').AsFloat * -1,
                                qryCadRcx.FieldByName('RCX_TOTREA').AsFloat * -1,
                                'S',
                                '',
                                strCodigoCaixa,
                                '',
                                0.00,
                                False,
                                0.00,
                                '',
                                0,
                                qryCadRcx.FieldByName('RCX_RECPIX').AsString,
                                qryCadRcx.FieldByName('RCX_SEQCON').AsInteger) Then
              Raise exception.Create('Ocorreu um erro na gravação do CADRCXX!!! - Inserindo registro de contra-partida');

              qryCadRcx.Next;
          End;

          Try
            strSQL := '';
            strSQL := strSQL + ' UPDATE                     ';
            strSQL := strSQL + '   CADRCXX                  ';
            strSQL := strSQL + ' SET                        ';
            strSQL := strSQL + '   RCX_TFCANC = "S"         ';
            strSQL := strSQL + ' WHERE                      ';
            strSQL := strSQL + '   RCX_SEQCON = :SEQCON     ';
            strSQL := strSQL + '   AND RCX_CODEMP = :CODEMP ';
            strSQL := strSQL + '   AND RCX_DTACAD = :DTACAD ';

            qryUpdate.Close;
            qryUpdate.SQL.Text := strSQL;

            If Not strCodigoCaixa.IsEmpty Then
            Begin
              qryUpdate.SQL.Add('  AND RCX_CODCAX = :CODCAX ');

              qryUpdate.ParamByName('CODCAX').AsString := strCodigoCaixa;
            End;

            qryUpdate.ParamByName('SEQCON').AsInteger := cdsTransf.FieldByName('RCX_SEQCON').AsInteger;
            qryUpdate.ParamByName('CODEMP').AsString  := cdsTransf.FieldByName('RCX_CODEMP').AsString;
            qryUpdate.ParamByName('DTACAD').AsDateTime := cdsTransf.FieldByName('RCX_DTACAD').AsDateTime;
            qryUpdate.ExecSQL;
          Except
            Raise exception.Create('Ocorreu um erro na gravação do CADRCXX!!! - Editando registro original');
          End;

          {******************************************************}
          {* UPDATE PARA ZERAR A DATA DE TRANSFERENCIA -- CAMPO *}
          {* CHQ_DTATRA DA TABELA CADCHQ REHABILITANDO O CHEQUE *}
          {* RQ 28188 ****************************************BB*}
          {SE FOI PAGO EM CHEQUE A VISTA OU A PRAZO}
          If (cdsTransf.FieldByName('RCX_CHQAVI').AsCurrency <> 0) Or
          (cdsTransf.FieldByName('RCX_CHQPRE').AsCurrency <> 0) Then
          Begin
            Try
              strSQL := '';
              strSQL := strSQL + ' UPDATE                     ';
              strSQL := strSQL + '   CADCHQ                   ';
              strSQL := strSQL + ' SET                        ';
              strSQL := strSQL + '   CHQ_DTATRA = NULL,       ';
              strSQL := strSQL + '   CHQ_SEQTRF = NULL,       ';
              strSQL := strSQL + '   CHQ_PORCHQ = NULL,       ';
              strSQL := strSQL + '   CHQ_CTACHQ = NULL,       ';
              strSQL := strSQL + '   CHQ_TRFLIB="S"           ';
              strSQL := strSQL + ' WHERE                      ';
              strSQL := strSQL + '   AUTOINCREM=:AUTINC ';

              For LAutoIncrem In RetornaAutoIncremsLogChq(cdsTransf) Do
              Begin
                qryUpdate.Close;
                qryUpdate.SQL.Text := strSQL;
                qryUpdate.ParamByName('AUTINC').AsString := LAutoIncrem;
                qryUpdate.ExecSQL;

                untLogChq.GravaLogChq(LAutoIncrem,
                                      'CANC. TRANSF. CHQ. (TfrmRcxCancTransfValores.pLogChq)',
                                      Self.Name);
              End;
            Except
              Raise exception.Create('Ocorreu um erro na gravação do CADCHQ!!! - Editando registro original');
            End;
          End;
          {SE FOI PAGO EM CARTÃO}
          IF (cdsTransf.FieldByName('RCX_CARREC').AsCurrency <> 0) Then
          Begin

            LSeqconCartoes := fMovCarSeqCon(cdsTransf.FieldByName('RCX_SEQCON').AsInteger,
                                            cdsTransf.FieldByName('RCX_CODEMP').AsString,
                                            cdsTransf.FieldByName('RCX_DTACAD').AsDateTime);

            If Not MatchStr(LSeqconCartoes, [EmptyStr, '0']) Then
              LConsultaCartoes := RetornaCartoesPelaListaSeqCons(LSeqconCartoes,
                                                                 cdsTransf);

            Try
              strSQL := '';
              strSQL := strSQL + ' UPDATE                     ';
              strSQL := strSQL + '   MOVCAR                   ';
              strSQL := strSQL + ' SET                        ';
              strSQL := strSQL + '   MCA_DTATRA = NULL,       ';
              strSQL := strSQL + '   MCA_SEQTRF = NULL,       ';
              strSQL := strSQL + '   MCA_PORCAR = NULL,       ';
              strSQL := strSQL + '   MCA_CTACAR = NULL,       ';
              strSQL := strSQL + '   MCA_TRFLIB="S"           ';
              strSQL := strSQL + ' WHERE                      ';
              strSQL := strSQL + '   MCA_SEQTRF = :SEQCON     ';
              strSQL := strSQL + '   AND MCA_EMPRCX = :CODEMP ';
              strSQL := strSQL + '   AND MCA_DTATRA >= :DTACAI ';

              qryUpdate.SQL.Text := strSQL;

              If Not strCodigoCaixa.IsEmpty Then
              Begin
                qryUpdate.SQL.Add('   AND MCA_CODCAX >= :CODCAX ');
                qryUpdate.ParamByName('CODCAX').AsString := strCodigoCaixa;
              End;

              qryUpdate.ParamByName('SEQCON').AsInteger := cdsTransf.FieldByName('RCX_SEQCON').AsInteger;
              qryUpdate.ParamByName('CODEMP').AsString  := cdsTransf.FieldByName('RCX_CODEMP').AsString;
              qryUpdate.ParamByName('DTACAI').AsDateTime:= cdsTransf.FieldByName('RCX_DTACAD').AsDateTime;
              qryUpdate.ExecSQL;
            Except
              Raise exception.Create('Ocorreu um erro na gravação do MOVCAR!!! - Editando registro original');
            End;

            If Not MatchStr(LSeqconCartoes, [EmptyStr, '0']) Then
            Begin
              While Not LConsultaCartoes.Eof Do
              Begin
                untLogMca.GravaLogMca(LConsultaCartoes.FieldByName('AUTOINCREM').AsString,
                                      'TRANSF. VALORES (CANCELAMENTO)',
                                      Self.Name);

                LConsultaCartoes.Next;
              End;

              LConsultaCartoes.Close;
              FreeAndNil(LConsultaCartoes);
            End;

          End;

          fCommit;

          fMensagem('', 'Cancelamento efetuado com sucesso!', ['&Ok']);
        Except
          fRollBack;
          Raise;
        End;
      End;

      cdsTransf.Next;
    End;

  Finally
    FreeAndNil(qryCadRcx);
    FreeAndNil(qryMovBan);
    FreeAndNil(qryUpdate);
  End;

  pCriaTemporaria;

end;

function TfrmRcxCancTransfValores.RetornaAutoIncremsLogChq(ADatasetTransferencia: TDataset): TStringList;
  Var
    LConsulta: TUniQuery;
begin
  Result := TStringList.Create;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM CADCHQ ' +
                          'WHERE CHQ_DTACAD>=:DTACAD ' +
                          '  AND CHQ_SEQTRF=:SEQTRF ' +
                          '  AND CHQ_EMPRCX=:EMPRCX ';

    LConsulta.ParamByName('DTACAD').AsDateTime := ADatasetTransferencia.FieldByName('RCX_DTACAD').AsDateTime;
    LConsulta.ParamByName('SEQTRF').AsInteger := ADatasetTransferencia.FieldByName('RCX_SEQCON').AsInteger;
    LConsulta.ParamByName('EMPRCX').AsString := ADatasetTransferencia.FieldByName('RCX_CODEMP').AsString;

    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      Result.Add(LConsulta.FieldByName('AUTOINCREM').AsString);

      LConsulta.Next;
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmRcxCancTransfValores.pCriaTemporaria;
  Var
    strSQL   : String;
    qryTransf: TUniQuery;
    dspTransf: TUniDataSetProvider;

    cdsUltimoFechamento: TDataset;
begin

  cdsTransf.Close;
  qryTransf := fCriaQuery(Nil);
  dspTransf := TUniDataSetProvider.Create(Self);
  dspTransf.DataSet := qryTransf;
  cdsTransf.SetProvider(dspTransf);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT                              ';
    strSQL := strSQL + '  RCX_DTACAD,                       ';
    strSQL := strSQL + '  RCX_HORCAD,                       ';
    strSQL := strSQL + '  RCX_SEQCON,                       ';
    strSQL := strSQL + '  RCX_CODEMP,                       ';
    strSQL := strSQL + '  RCX_CODCAX,                       ';
    strSQL := strSQL + '  CONCAT(RTF_CODOPE,                ';
    strSQL := strSQL + '         " - ",                     ';
    strSQL := strSQL + '         OPE_NOMOPE) AS RCX_OPERAD, ';
    strSQL := strSQL + '  RCX_DESCRI,                       ';
    strSQL := strSQL + '  RCX_RECPIX,                       ';
    strSQL := strSQL + '  SUM(RCX_DINREC) AS RCX_DINREC,    ';
    strSQL := strSQL + '  SUM(RCX_CARREC) AS RCX_CARREC,    ';
    strSQL := strSQL + '  SUM(RCX_CHQAVI) AS RCX_CHQAVI,    ';
    strSQL := strSQL + '  SUM(RCX_CHQPRE) AS RCX_CHQPRE,    ';
    strSQL := strSQL + '  SUM(RCX_ORDREC) AS RCX_ORDREC,    ';
    strSQL := strSQL + '  SUM(RCX_VALDOC) AS RCX_VALDOC,    ';
    strSQL := strSQL + '  SUM(RCX_FUNCAX) AS RCX_FUNCAX,    ';
    strSQL := strSQL + '  " " AS RCX_MARDES                 ';
    strSQL := strSQL + 'FROM                                ';
    strSQL := strSQL + '  CADRCXX                           ';
    strSQL := strSQL + 'JOIN CADRTF                         ';
    strSQL := strSQL + '   ON RTF_RCXCON = RCX_SEQCON       ';
    strSQL := strSQL + '  AND RTF_CODEMP = :CODEMP          ';
    strSQL := strSQL + 'JOIN CADOPE                         ';
    strSQL := strSQL + '  ON OPE_CODOPE = RTF_CODOPE        ';
    strSQL := strSQL + 'WHERE RCX_CODEMP = :CODEMP          ';
    strSQL := strSQL + '  AND RCX_ESPDOC = "TF"             ';
    strSQL := strSQL + '  AND RCX_SEQCON IN                 ';
    strSQL := strSQL + '  (SELECT                           ';
    strSQL := strSQL + '     RCX_SEQCON                     ';
    strSQL := strSQL + '   FROM                             ';
    strSQL := strSQL + '     CADRCXX                        ';
    If objResumoDeCaixa.strTipoFechamento <> 'C' Then
      strSQL := strSQL + '   WHERE RCX_DTACAD > :DTAFEC     '
    Else
      strSQL := strSQL + '   WHERE RCX_DTACAD >= :DTAFEC    ';
    strSQL := strSQL + '     AND RCX_CODOPE = :CODOPE       ';
    strSQL := strSQL + '     AND RCX_CODEMP = :CODEMP       ';
    strSQL := strSQL + '     AND RCX_ESPDOC = "TF"          ';

    If objResumoDeCaixa.strTipoFechamento = 'C' Then
    Begin
      strSQL := strSQL + '  AND RCX_CODCAX = ' + strCodigoCaixa.QuotedString;

      cdsUltimoFechamento := objResumoDeCaixa.fRetornaDadosUltimoFechamento(strCodigocaixa, VS_strCodEmp);
      strSQL := strSQL + '  AND RCX_DTAGRV > ' + FormatDateTime('yyyy-mm-dd hh:mm:ss', cdsUltimoFechamento
                                                                .FieldByName('RCX_DTAGRV').AsDateTime).QuotedString;
      strSQL := strSQL + '  AND RCX_LANFEC = "N" ';

      FreeAndNil(cdsUltimoFechamento);
    End;

    strSQL := strSQL + '     AND RCX_TFCANC = "N"           ';
    strSQL := strSQL + RetornaSQLCondicaoPix            + ')';
    strSQL := strSQL + 'GROUP BY RCX_SEQCON                 ';
    strSQL := strSQL + 'ORDER BY RCX_DTACAD,                ';
    strSQL := strSQL + '  RCX_HORCAD                        ';

    With qryTransf Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAFEC').AsDateTime := dtaDtaRcx;
      ParamByName('CODOPE').AsString   := strCodOpe;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      Open;
    End;

    pSetaClient(qryTransf);

    cdsTransf.Open;
    cdsTransf.First;
    (cdsTransf.FieldByName('RCX_VALDOC') As TFloatField).DisplayFormat := ',0.00';

    qryTransf.Close;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmRcxCancTransfValores.pCriaTemporaria]');
    End;
  End;

  cdsTransf.SetProvider(Nil);
  FreeAndNil(dspTransf);
  FreeAndNil(qryTransf);

end;

function TfrmRcxCancTransfValores.PermitidoRealizarOCancelamentoDaTf: Boolean;
  Var
    LRegistroAtualizado,
    LUltimoFechamento: TDataSet;
begin
  LRegistroAtualizado := objResumoDeCaixa.RetornaRegistrosAtualizadosCadRcxx(
                                       cdsTransf.FieldByName('RCX_SEQCON').AsString,
                                       cdsTransf.FieldByName('RCX_CODEMP').AsString,
                                       cdsTransf.FieldByName('RCX_CODCAX').AsString,
                                       cdsTransf.FieldByName('RCX_DTACAD').AsDateTime);

  LUltimoFechamento := objResumoDeCaixa.fRetornaDadosUltimoFechamento(strCodigoCaixa, VS_strCodEmp);

  Try
    If LRegistroAtualizado.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Transferência não encontrada na base de dados.' + #13 +
                           'Acesse a rotina novamente para atualizar os dados da tela.', ['&Ok']);

      Exit(False);
    End;

    If LRegistroAtualizado.FieldByName('RCX_TFCANC').AsString.Equals('S') Then
    Begin
      fMensagem('ATENÇÃO', 'Essa transferência já foi cancelada em outra estação.' + #13 +
                           'Acesse a rotina novamente para atualizar os dados da tela.', ['&Ok']);

      Exit(False);
    End;

    Result := LUltimoFechamento.FieldByName('RCX_DTACAD').AsDateTime <
              LRegistroAtualizado.FieldByName('RCX_DTACAD').AsDateTime;

    If objResumoDeCaixa.strTipoFechamento.Equals('C') Then
      Result := Not LRegistroAtualizado.FieldByName('RCX_LANFEC').AsString.Equals('S');

    If Not Result Then
      fMensagem('ATENÇÃO', 'Não é permitido realizar o cancelamento da transferência pois o caixa já foi fechado.' + #13 +
                           'Acesse a rotina novamente para atualizar os dados da tela.', ['&Ok']);
  Finally
    LRegistroAtualizado.Close;
    LUltimoFechamento.Close;

    FreeAndNil(LRegistroAtualizado);
    FreeAndNil(LUltimoFechamento);
  End;
end;

procedure TfrmRcxCancTransfValores.pSelecionaRegistro(blnMarDes: Boolean);
  Var
    intRecNo : Integer;

begin
  If cdsTransf.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhum registro disponível para ser selecionado.', ['&Ok']);
    Exit;
  End;

  If (blnMarDes) and
     (Not fVerificaAcessoSistema('CANTFV', strCodOpe)) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('PERMITIR CANCELAMENTO DE TRANSFERÊNCIA DE VALORES');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('O operador '+ strCodOpe + ' não tem direito de acesso para cancelar essa Transferência!');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTexto('Transferência - Seq. ' + cdsTransf.FieldByName('RCX_SEQCON').AsString +
                                        ' no valor de R$ ' + FormatFloat('#,##0.00',cdsTransf.FieldByName('RCX_VALDOC').AsFloat));
    objLiberacao.strDirAce := 'CANTFV';
    objLiberacao.strMsgSen := 'Permitir cancelamento de transferência de valores';
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    If (Not objLiberacao.fLibera) Then
      Exit;
  End;

  strChaLck := 'CADRCXX' +
               cdsTransf.FieldByName('RCX_SEQCON').AsString +
               cdsTransf.FieldByName('RCX_CODEMP').AsString;

  If blnMarDes And (Not cdsTransf.IsEmpty) Then
  Begin

    If (fUtilizaImpressaoDeSangriaNoPDV) Then
    Begin
      If (fSangriaFoiImpressaNoPDV(cdsTransf.FieldByName('RCX_SEQCON').AsInteger,
                                   cdsTransf.FieldByName('RCX_CODEMP').AsString,
                                   fNumeroSerieImpressora(cdsTransf.FieldByName('RCX_CODEMP').AsString))) Then
      Begin
        fMensagem('', 'A sangria já foi impressa no PDV não é possível cancelar!', ['&Ok']);
        Exit;
      End;
    End;

    If Not fLock_Unlock(strChaLck, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
      Exit;
    End;

    intRecNo := cdsTransf.RecNo;

    cdsTransf.DisableControls;

    cdsTransf.Filtered := False;
    cdsTransf.Filter   := 'RCX_MARDES = ' + QuotedStr('M');
    cdsTransf.Filtered := True;

    If Not cdsTransf.IsEmpty Then
    Begin
      fMensagem('', 'Selecione apenas um registro por vez para fazer o cancelamento!', ['&Ok']);
      cdsTransf.Filtered := False;
      cdsTransf.EnableControls;
      cdsTransf.IndexFieldNames := 'RCX_DTACAD;RCX_HORCAD';
      cdsTransf.RecNo := intRecNo;
      fLock_Unlock(strChaLck, False);
      Exit;
    End
    Else
    Begin
      cdsTransf.Filtered := False;
      cdsTransf.RecNo := intRecNo;
    End;

    If (Not cdsTransf.IsEmpty) And fValidaChequeCartao(cdsTransf.FieldByName('RCX_SEQCON').AsInteger, cdsTransf.FieldByName('RCX_CODEMP').AsString) Then
    Begin
      cdsTransf.Edit;
      cdsTransf.FieldByName('RCX_MARDES').AsString := 'M';
      cdsTransf.Post;
    End;

    cdsTransf.EnableControls;
  End
  Else
  Begin
    If Not cdsTransf.IsEmpty Then
    Begin
      cdsTransf.Edit;
      cdsTransf.FieldByName('RCX_MARDES').AsString := 'D';
      cdsTransf.Post;
    End;

    fLock_Unlock(strChaLck, False);
  End;

end;

function TfrmRcxCancTransfValores.RetornaCartoesPelaListaSeqCons(
  ASeqconCartoes: String; ADatasetTransferencia: TDataset): TUniClientDataset;
  Var
    LConsulta: TUniQuery;
begin
  Result := TUniClientDataSet.Create(Nil);

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_DTACAD>=:DTACAI ' +
                          '  AND MCA_SEQCON IN (' + ASeqconCartoes + ') ' +
                          '  AND MCA_EMPRCX=:CODEMP ' +
                          '  AND MCA_SEQTRF=:SEQTRF ';

    If Not strCodigoCaixa.IsEmpty Then
    Begin
      LConsulta.SQL.Add('  AND MCA_CODCAX=:CODCAX ');
      LConsulta.ParamByName('CODCAX').AsString := strCodigoCaixa;
    End;

    LConsulta.ParamByName('CODEMP').AsString := ADatasetTransferencia.FieldByName('RCX_CODEMP').AsString;
    LConsulta.ParamByName('DTACAI').AsDateTime := ADatasetTransferencia.FieldByName('RCX_DTACAD').AsDateTime;
    LConsulta.ParamByName('SEQTRF').AsInteger := ADatasetTransferencia.FieldByName('RCX_SEQCON').AsInteger;
    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      Result := fCriaClientDatSet(LConsulta);
      Result.Open;

      Result.First;
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TfrmRcxCancTransfValores.RetornaSQLCondicaoPix: String;
begin
  If fCfgSis('CXMVTP', varString) = '2' Then
  Begin
    If fCfgSis('TRAPXA', varBoolean) Then
      Exit('  AND RCX_RECPIX = "N" ');
  End;

  Result := ' AND ((RCX_RECPIX = "N") OR ' +
            '      (RCX_RECPIX="S" AND   ' +
            '       (SELECT IFNULL(COUNT(AUTOINCREM), 0) ' +
            '        FROM MOVPIX ' +
            '        WHERE MPX_SEQCON=RCX_SEQCON ' +
            '          AND MPX_CODEMP=RCX_CODEMP ' +
            '          AND MPX_DTAREC=RCX_DTACAD ' +
            '        )=0)) ';
end;

function TfrmRcxCancTransfValores.fMovCarSeqCon(intSeqCon: Integer; strCodEmp: String; ADataCaixa: TDateTime): String;
  Var
    qryMovCar : TUniQuery;
    strSQL : String;
begin
  qryMovCar := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT MCA_SEQCON          ';
    strSQL := strSQL + ' FROM                       ';
    strSQL := strSQL + '   MOVCAR                   ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   MCA_SEQTRF = :SEQCON     ';
    strSQL := strSQL + '   AND MCA_EMPRCX = :CODEMP ';
    strSQL := strSQL + '   AND MCA_DTACAD >= :DTACAI ';

    If Not strCodigoCaixa.IsEmpty Then
      strSQL := strSQL + '   AND MCA_CODCAX = :CODCAX ';

    strSQL := strSQL + ' GROUP BY MCA_SEQCON ';

    qryMovCar.SQL.Text := strSQL;
    qryMovCar.ParamByName('SEQCON').AsInteger   := intSeqCon;
    qryMovCar.ParamByName('CODEMP').AsString    := strCodEmp;
    qryMovCar.ParamByName('DTACAI').AsDateTime  := ADataCaixa;

    If Not strCodigoCaixa.IsEmpty Then
      qryMovCar.ParamByName('CODCAX').AsString := strCodigoCaixa;

    qryMovCar.Open;

    Result := EmptyStr;
    If qryMovCar.isEmpty Then
      Exit;

    While Not qryMovCar.Eof Do
    Begin
      Result := Result + qryMovCar.FieldByName('MCA_SEQCON').AsString + ',';

      qryMovCar.Next;
    End;

    Result := LeftStr(Result, Result.Length - 1);
  Finally
    FreeAndNil(qryMovCar);
  End;
end;

end.
