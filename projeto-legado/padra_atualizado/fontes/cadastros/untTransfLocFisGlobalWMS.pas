unit untTransfLocFisGlobalWMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, untZClient,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls, Uni,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, strUtils, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxGrid, EditFocus, cxProgressBar, UniClientDataSet, frxDBSet,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmTransfLocFisGlobalWMS = class(TfrmPaiConfirma)
    Panel1: TPanel;
    lblLocFis: TLabel;
    edtLocFis: TEditFocus;
    cxgDados: TcxGridCitel;
    cxgDadosTableView: TcxGridDBTableViewCitel;
    cxgDadosLevel: TcxGridLevel;
    pnlRodape: TPanel;
    lblCodBar: TLabel;
    lblQtde: TLabel;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    ColumnCODITE: TcxGridDBColumn;
    ColumnDESITE: TcxGridDBColumn;
    ColumnDESMAR: TcxGridDBColumn;
    ColumnSIGUNI: TcxGridDBColumn;
    ColumnDTAVAL: TcxGridDBColumn;
    ColumnSALATU: TcxGridDBColumn;
    ColumnLOCNOV: TcxGridDBColumn;
    ColumnSALNOV: TcxGridDBColumn;
    btnQuantidade: TBitBtnLocked;
    btnExpAut: TBitBtnLocked;
    btnNovLocFis: TBitBtnLocked;
    ColumnNUMLOT: TcxGridDBColumn;
    btnLimpaConf: TBitBtnLocked;
    frxReport: TfrxReport;
    frxDBDataset: TfrxDBDataset;
    procedure edtLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure cxgDadosTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExpAutClick(Sender: TObject);
    procedure btnNovLocFisClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLimpaConfClick(Sender: TObject);
  private
    cdsDados : TZClient;
    intDecUni: Integer;
    intMenu  : Integer;
    strLocNov: String;
    function fGetSQL(blnLote: Boolean = False): String;
    function fExpedeTodos(cxProgress: TcxProgressBar): Boolean;
    function fAplicaLocNov(cxProgress: TCxProgressBar): Boolean;
    function fLoteJaIndicadoGrid(strNumLot: string): Boolean;

    function fGetNumLote(strCodIte, strLocFis: String): String;
  public
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untTypesSistema, untConsultas, untFuncoesSimples, untPesqAux, untGravando,
  untTransferenciaArmazens, untCadLote, untTransfLocFisGlobalWMSReservados;

procedure TfrmTransfLocFisGlobalWMS.btnNovLocFisClick(Sender: TObject);
  Var
    qryConsu    : TUniQuery;
    objCadLot   : TCadLot;
    arrSel      : TConsultasArray;
    Key         : Char;
    strItem     : String;
    strLote     : String;
    fltSalLot   : Double;
    fltSalLotML : Double;
begin
  inherited;
  If (Not cdsDados.Active) or (cdsDados.RecordCount <= 0) Then
  Begin
    fMensagem('', 'Não Existe Registro para Informar Nova Localização!', ['&Ok']);
    Exit;
  End;

  intMenu := fGetMenu('Opção', ['Registro Atual', 'Todos Sem Localização', 'Todos', 'Cancelar' ], 1);

  If intMenu = 4 Then
    Exit;

  Try
    objCadLot := TCadLot.Create(Self);
    Key       := '/';
    strLocNov := '';
    qryConsu  := fCriaQuery(Self);

    If fPesqLocFisica(Self, Nil, Nil, qryConsu, Key, arrSel, True) Then
      strLocNov := qryConsu.FieldByName('LOC_CODLOC').AsString
    Else
      Exit;

    If (fProdutoLocalizacaoFisicaPicking(strLocNov) <> '') And
       (fProdutoLocalizacaoFisicaPicking(strLocNov) <> IfThen(intMenu = 1, cdsDados.FieldByName('CODITE').AsString, '')) Then
    Begin
      strItem := fProdutoLocalizacaoFisicaPicking(strLocNov);
      pMensagemOk('Localização Física Picking reservada para o produto ' + strItem + '-' + fRetNomProduto(strItem) + '!');
      Exit;
    End

    Else
    If objCadLot.fTemLoteComLocFisica(strLocNov, strItem, strLote, fltSalLot, fltSalLotML,
                                      IfThen(intMenu = 1, cdsDados.FieldByName('CODITE').AsString, ''),
                                      IfThen(intMenu = 1, cdsDados.FieldByName('NUMLOT').AsString, '')) Then
    Begin
      If ((fProdutoLocalizacaoFisicaPicking(strLocNov) <> '') And (IfThen(intMenu = 1, cdsDados.FieldByName('CODITE').AsString, '') <> strItem)) Then
      Begin
        If (objCadLot.fRetLotePrincipalTintaMaquina(strItem, VS_strCodEmp) <> strLote) Then
        Begin
          pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                      ' (' + objCadLot.strTitLab + ' ' + strLote + ') já está cadastrado com essa localização física!');
          Exit;
        End;
      End;
    End

    Else
    If fLoteJaIndicadoGrid(strLocNov) Then
    Begin
      pMensagemOK('A localização física ' + strLocNov + ' já esta indicado nesta tranferência!');
      Exit;
    End;


    If intMenu = 1 Then
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('LOCNOV').AsString := strLocNov;
      cdsDados.Post;
    End
    Else
    Begin
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fAplicaLocNov;
      frmGravando.ShowModal;
    End;

  Finally
    FreeAndNil(qryConsu);
    FreeAndNil(objCadLot);
    If Assigned(frmGravando) Then
      FreeAndNil(frmGravando);
  End;

end;

function TfrmTransfLocFisGlobalWMS.fAplicaLocNov(cxProgress : TCxProgressBar) : Boolean;
Begin
  Result := True;
  cxProgress.Properties.Max := cdsDados.RecordCount;

  Try
    cdsDados.DisableControls;
    cdsDados.Filter := 'SALNOV > 0';
    cdsDados.Filtered := True;
    cdsDados.First;
    While not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      If intMenu = 3 Then
        cdsDados.FieldByName('LOCNOV').AsString := strLocNov
      Else
      If intMenu = 2 Then
        If fEmptyStr(cdsDados.FieldByName('LOCNOV').AsString) Then
          cdsDados.FieldByName('LOCNOV').AsString := strLocNov;

      cdsDados.Post;

      cdsDados.Next;
      cxProgress.Position := cxProgress.Position + 1;

      Application.ProcessMessages;
    End;
  Finally
    cdsDados.Filter   := '';
    cdsDados.Filtered := False;
    cdsDados.First;
    cdsDados.EnableControls;
  End;

End;

procedure TfrmTransfLocFisGlobalWMS.btnConfirmaClick(Sender: TObject);
  Var
    blnResult : Boolean;
    strSeqLof : String;
    qryUpdate : TUniQuery;
    qryTraLof : TUniQuery;
begin
//  inherited;
  If (Not cdsDados.Active) or (cdsDados.RecordCount <= 0) Then
  Begin
    fMensagem('', 'Não existe registro para confirmar!', ['&Ok']);
    Exit;
  End;


  blnResult := True;
  qryUpdate := fCriaQuery(Self);
  qryTraLof := fCriaQuery(Self);

  With qryUpdate, SQL Do
  Begin
    Close;
    Clear;
    Add(' UPDATE CADLOT SET LOT_LOCFIS = :LOCFIS ');
    Add(' WHERE AUTOINCREM = :AUTINC             ');
  End;

  With qryTraLof, SQL Do
  Begin
    Close;
    Clear;
    Add(' INSERT INTO TRALOF( ');
    Add('   AUTOINCREM,       ');
    Add('   LOF_CODOPE,       ');
    Add('   LOF_DTACAD,       ');
    Add('   LOF_HRACAD,       ');
    Add('   LOF_CODITE,       ');
    Add('   LOF_LOCATU,       ');
    Add('   LOF_DTAVAL,       ');
    Add('   LOF_SALDOS,       ');
    Add('   LOF_LOCNOV,       ');
    Add('   LOF_QTDTRA,       ');
    Add('   LOF_NUMLOT,       ');
    Add('   LOF_CODEMP,       ');
    Add('   LOF_SEQLOF)       ');
    Add(' VALUES(             ');
    Add('   :AUTINC,          ');
    Add('   :CODOPE,          ');
    Add('   :DTACAD,          ');
    Add('   :HRACAD,          ');
    Add('   :CODITE,          ');
    Add('   :LOCATU,          ');
    Add('   :DTAVAL,          ');
    Add('   :SALDOS,          ');
    Add('   :LOCNOV,          ');
    Add('   :QTDTRA,          ');
    Add('   :NUMLOT,          ');
    Add('   :CODEMP,          ');
    Add('   :SEQLOF)          ');
  End;

  Try
    cdsDados.DisableControls;

    cdsDados.Filtered := False;
    cdsDados.Filter := '(SALNOV > 0) AND (SALNOV <> SALATU) ';
    cdsDados.Filtered := True;
    cdsDados.First;
    If not cdsDados.IsEmpty Then
    Begin
      blnResult := False;
      pMensagemOK('Existe(m) produto(s) com movimentação parcial, a movimentação deve ser referênte ao total do estoque!');
    End;

    cdsDados.Filtered := False;
    cdsDados.Filter := 'SALNOV > 0';
    cdsDados.Filtered := True;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If fEmptyStr(cdsDados.FieldByName('LOCNOV').AsString) Then
      Begin
        blnResult := False;
        pMensagemOK('É obrigatório preencher a nova localização dos itens que tem quantidade a transferir maior que zero!' + #13 +
                    'Observe os produtos com a coluna "Nova Localização" destacada em vermelho!');
        Break;
      End;
      cdsDados.Next;
    End;

    If Not blnResult Then
      Exit;

    If fMensagem('', 'Este procedimento irá transferir a localização física atual do lote para a nova localização física.' + #13 +
                     'Confirma esta operação ?' , ['&Sim', '&Não'],1 ) = 2 Then
    Begin
      blnResult := False;
      Exit;
    End;

    Try
      strSeqLof := fAtualizaProCod('TRALOF', 'LOF_SEQLOF');

      fStartTransaction;

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        qryTraLof.ParamByName('AUTINC').AsString   := fRetAutoIncrem('TRALOF', VS_strCodEmp);
        qryTraLof.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
        qryTraLof.ParamByName('DTACAD').AsDateTime := VS_Date;
        qryTraLof.ParamByName('HRACAD').AsDateTIme := fNow;
        qryTraLof.ParamByName('CODITE').AsString   := cdsDados.FieldByName('CODITE').AsString;
        qryTraLof.ParamByName('LOCATU').AsString   := cdsDados.FieldByName('LOCATU').AsString;
        qryTraLof.ParamByName('DTAVAL').AsDateTime := cdsDados.FieldByName('DTAVAL').AsDateTime;
        qryTraLof.ParamByName('SALDOS').AsFloat    := cdsDados.FieldByName('SALATU').AsFloat;
        qryTraLof.ParamByName('LOCNOV').AsString   := cdsDados.FieldByName('LOCNOV').AsString;
        qryTraLof.ParamByName('QTDTRA').AsFloat    := cdsDados.FieldByName('SALNOV').AsFloat;
        qryTraLof.ParamByName('NUMLOT').AsString   := cdsDados.FieldByName('NUMLOT').AsString;
        qryTraLof.ParamByName('CODEMP').AsString   := VS_strCodEmp;
        qryTraLof.ParamByName('SEQLOF').AsString   := strSeqLof;
        qryTraLof.ExecSQL;

        qryUpdate.ParamByName('LOCFIS').AsString := cdsDados.FieldByName('LOCNOV').AsString;
        qryUpdate.ParamByName('AUTINC').AsString := cdsDados.FieldByName('AUTINC').AsString;
        qryUpdate.ExecSQL;

        ReprocessarItem(cdsDados.FieldByName('CODITE').AsString, '');

        cdsDados.Next;
      End;

      fCommit;

      //Impressão do documento
      frxDBDataset.DataSource := cdsDados.dtsSource;
      frxReport.Script.Variables['NOMEMP'] := fRetNomeEmpresa;
      pPreviewReport(Self.Name, Self.Caption, frxReport);

      TfrmTransfLocFisGlobalWMSReservados.pExibeDocumentosReservados(strSeqLof);

    Except
      On E : Exception Do
      Begin
        pMensagensErro(E.Message, '');
        fRollBack;
      End;
    End;



  Finally
    FreeAndNil(qryUpdate);
    FreeAndNil(qryTraLof);

    cdsDados.Filter := '';
    cdsDados.Filtered := False;
    cdsDados.First;
    cdsDados.EnableControls;

    If blnResult then
    Begin
      cdsDados.Close;
      edtLocFis.Clear;
      pSetFocus(edtLocFis);
    End;

  End;

end;

procedure TfrmTransfLocFisGlobalWMS.btnExpAutClick(Sender: TObject);
begin
  inherited;
  If (Not cdsDados.Active) or (cdsDados.RecordCount <= 0) Then
  Begin
    fMensagem('', 'Não existe registro para conferir!', ['&Ok']);
    Exit;
  End;


  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fExpedeTodos;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

end;

procedure TfrmTransfLocFisGlobalWMS.btnLimpaConfClick(Sender: TObject);
begin
  inherited;
  cdsDados.Edit;
  cdsDados.FieldByName('SALNOV').AsFloat := 0.00;
  cdsDados.Post;
end;

function TfrmTransfLocFisGlobalWMS.fExpedeTodos(cxProgress : TcxProgressBar):Boolean;
Begin
  Result:= True;

  cxProgress.Properties.Max := cdsDados.RecordCount;

  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      cdsDados.Edit;
      cdsDados.FieldByName('SALNOV').AsFloat := cdsDados.FieldByName('SALATU').AsFloat;
      cdsDados.Post;

      cdsDados.Next;

      cxProgress.Position := cxProgress.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    cdsDados.First;
    cdsDados.EnableControls;
  End;

End;

procedure TfrmTransfLocFisGlobalWMS.btnQuantidadeClick(Sender: TObject);
begin
  inherited;
  edtQtdIte.Enabled := True;
  pSetFocus(edtQtdIte);
end;

procedure TfrmTransfLocFisGlobalWMS.cxgDadosTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Sender.DataController.GetValue(AViewInfo.GridRecord.RecordIndex, ColumnSALNOV.Index) > 0 Then
  Begin
    If (AViewInfo.Item.Index = ColumnLOCNOV.Index) And
       fEmptyStr(Sender.DataController.GetValue(AViewInfo.GridRecord.RecordIndex, ColumnLOCNOV.Index)) Then
      ACanvas.Brush.Color := $008784FB
    Else
    If Sender.DataController.GetValue(AViewInfo.GridRecord.RecordIndex, ColumnSALNOV.Index) =
       Sender.DataController.GetValue(AViewInfo.GridRecord.RecordIndex, ColumnSALATU.Index) Then
      ACanvas.Brush.Color := $00B7F9A4
    Else
      ACanvas.Brush.Color := $0080FFFF;
    ACanvas.Font.Color := clBlack;
  End;

end;

procedure TfrmTransfLocFisGlobalWMS.edtLocFisKeyPress(Sender: TObject;var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqLocFisica(Self, edtLocFis, Nil, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtLocFis, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmTransfLocFisGlobalWMS.fGetNumLote(strCodIte, strLocFis: String): String;
  Var
    arrNumLot: Array Of String;
    qryTmp   : TUniQuery;
    intIndex : Integer;
begin
  Result := '';
  SetLength(arrNumLot, 0);

  qryTmp := fCriaQuery;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSQL(True));

    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByNAme('LOCFIS').AsString := strLocFis;
    ParamByNAme('CODITE').AsString := strCodIte;

    Open;

    If Not IsEmpty Then
    Begin
      First;

      SetLength(arrNumLot, RecordCount);
      intIndex := 0;

      While Not Eof Do
      Begin
        arrNumLot[intIndex] := FieldByName('NUMLOT').AsString;
        Inc(intIndex);

        Next;
      End;
    End;
  End;

  FreeAndNil(qryTmp);

  If Length(arrNumLot) = 0 Then
  Begin
    Result := '';
    Exit;
  End;

  If Length(arrNumLot) = 1 Then
  Begin
    Result := arrNumLot[0];
    Exit;
  End
  Else
    intIndex := fGetMenu('Escolha um lote', arrNumLot, 1);

  Result := arrNumLot[intIndex-1];
end;

function TfrmTransfLocFisGlobalWMS.fGetSQL(blnLote: Boolean = False): String;
begin
  Result := '';

  If blnLote Then
    Result := Result + ' SELECT L.LOT_NUMLOT AS NUMLOT                      '
  Else
  Begin
    Result := Result + ' SELECT L.AUTOINCREM   AS AUTINC,                   ';
    Result := Result + '        L.LOT_CODITE   AS CODITE,                   ';
    Result := Result + '        L.LOT_NUMLOT   AS NUMLOT,                   ';
    Result := Result + '        I.ITE_DESITE   AS DESITE,                   ';
    Result := Result + '        M.MAR_DESMAR   AS DESMAR,                   ';
    Result := Result + '        U.UNI_SIGUNI   AS SIGUNI,                   ';
    Result := Result + '        L.LOT_DTAVAL   AS DTAVAL,                   ';
    Result := Result + '        L.LOT_LOCFIS   AS LOCATU,                   ';
    Result := Result + '        L.LOT_SALDOS   AS SALATU,                   ';
    Result := Result + '        REPEAT(" ",20) AS LOCNOV,                   ';
    Result := Result + '        0.000          AS SALNOV                    ';
  End;

  Result := Result + ' FROM CADLOT L                                        ';
  Result := Result + '   INNER JOIN CADLOC C ON C.LOC_CODLOC = L.LOT_LOCFIS ';
  Result := Result + '                      AND L.LOT_CODEMP = C.LOC_CODEMP ';
  Result := Result + '   INNER JOIN CADITE I ON I.ITE_CODITE = L.LOT_CODITE ';
  Result := Result + '   LEFT  JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';
  Result := Result + '   LEFT  JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  Result := Result + ' WHERE L.LOT_CODEMP = :CODEMP                         ';
  Result := Result + '   AND L.LOT_LOCFIS = :LOCFIS                         ';
  Result := Result + '   AND L.LOT_SALDOS > 0                               ';

  If blnLote Then
    Result := Result + ' AND L.LOT_CODITE = :CODITE                           '
  Else
    Result := Result + ' ORDER BY DESITE                                    ';
end;

procedure TfrmTransfLocFisGlobalWMS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If cdsDados.Active And (cdsDados.RecordCount > 0) Then
  Begin
    If fMensagem('','Deseja cancelar a operação?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      cdsDados.Close;
      Action := caNone;
      pSetFocus(edtLocFis);
    End
    Else
    Begin
      Action := caNone;
      pSetFocus(edtQtdIte);
    End;
  End;
end;

procedure TfrmTransfLocFisGlobalWMS.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self, fGetSQL );
  cxgDadosTableView.DataController.DataSource := cdsDados.dtsSource;

  intDecUni := fCfgSis('DECUNI', varInteger);
end;

procedure TfrmTransfLocFisGlobalWMS.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsDados);
  inherited;
end;

procedure TfrmTransfLocFisGlobalWMS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F6 : btnQuantidade.Click;
    VK_F7 : btnExpAut.Click;
    VK_F8 : btnNovLocFis.Click;
    VK_F9 : btnLimpaConf.Click;
  End;
end;

function TfrmTransfLocFisGlobalWMS.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    blnBuscaCodBar : Boolean;
    qryBusca       : TUniQuery;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If Sender = edtLocFis then
    Begin
      Result := not fEmptyStr(fRetNomLocFisica(edtLocFis.Text));

      If Result Then
      Begin
        cdsDados.qryQuery.Close;
        cdsDados.qryQuery.ParamByNAme('CODEMP').AsString := VS_strCodEmp;
        cdsDados.qryQuery.ParamByNAme('LOCFIS').AsString := edtLocFis.Text;
        cdsDados.fAbreClient(True, 'TfrmTransfLocFisGlobalWMS.fValidaCampos');

        If not cdsDados.IsEmpty Then
        Begin
          TFloatField(cdsDados.FieldByName('SALATU')).DisplayFormat := fDisplayFormat(intDecUni);
          TFloatField(cdsDados.FieldByName('SALNOV')).DisplayFormat := fDisplayFormat(intDecUni);
          blnMudarFoco := False;
          pSetFocus(edtCodIte);
        End
        Else
        Begin
          pMensagemOK('Nenhum registro encontrado na localização física informada!');
          Result := False;
        End;

        If (Result) And (TCadLot.fBloqueiaTranfSaldoLote('', edtLocFis.Text, '', VS_strCodEmp)) Then
        Begin
          Result := False;
        End
      End
      Else
        pMensagemOK('Localização física não cadastrada!');

    End

    Else
    If Sender = edtQtdIte Then
    Begin
      Result := fStrToFloat(edtQtdIte.Text) > 0;

      If Not Result Then
        pMensagemOK('A quantidade deve ser maior que zero')
      Else
      Begin
        edtQtdIte.Enabled := False;
        blnMudarFoco := False;
        pSetFocus(edtCodIte);
      End;

    End

    Else
    If Sender = edtCodIte Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        blnMudarFoco := False;
        pSetFocus(btnConfirma);
      End Else
      Begin

        If blnBuscaPorChave Then
        Begin
          blnBuscaCodBar := True;
          If (Length(Trim(edtCodIte.Text)) <= fTamCodIte)  Then
          Begin
            edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
            blnBuscaCodBar := False;
          End;

          Try
            qryBusca := fCriaQuery(Self);
            pPesquisaCadSem(qryBusca, qryBusca, edtCodIte.Text, '', blnBuscaCodBar);

            If not qryBusca.IsEmpty Then
            Begin
              If cdsDados.Locate('CODITE;NUMLOT', VarArrayOf([qryBusca.FieldByName('ITE_CODITE').AsString, fGetNumLote(qryBusca.FieldByName('ITE_CODITE').AsString, cdsDados.FieldByName('LOCATU').AsString)]), []) Then
              Begin
                If (cdsDados.FieldByName('SALNOV').AsFloat + fStrToFloat(edtQtdIte.Text)) <=
                    cdsDados.FieldByName('SALATU').AsFloat Then
                Begin
                  cdsDados.Edit;
                  cdsDados.FieldByName('SALNOV').AsFloat := cdsDados.FieldByName('SALNOV').AsFloat + fStrToFloat(edtQtdIte.Text);
                  cdsDados.Post;

                  edtCodite.Clear;

                  edtQtdIte.Enabled := False;
                  edtQtdIte.Text    := '1,00';
                End
                Else
                Begin
                  pMensagemSonora('A quantidade a transferir não pode ser maior que o saldo disponível!');
                  Result := False;
                End;

                blnMudarFoco := False;
                pSetFocus(edtCodite);

              End
              Else
              Begin
                pMensagemSonora(Format('Produto %s não encontrado nos registros disponíveis para transferência!', [qryBusca.FieldByName('ITE_CODITE').AsString]));
                Result := False;
              End;
            End
            Else
            Begin
              pMensagemSonora('Produto não encontrado!');
              Result := False;
            End;

          Finally
            FreeAndNil(qryBusca);
          End;

        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmTransfLocFisGlobalWMS.fLoteJaIndicadoGrid(strNumLot : string): Boolean;
  var
    cdsClone : TUniClientDataSet;
Begin
  cdsClone := TUniClientDataSet.Create(Self);
  Try
    cdsClone.CloneCursor(cdsDados, False, True);

    cdsClone.Filter   := 'LOCNOV = ' + QuotedStr(strNumLot);
    cdsClone.Filtered := True;

    Result := Not cdsClone.IsEmpty;

  Finally
    FreeAndNil(cdsClone);
  End;

End;

end.
