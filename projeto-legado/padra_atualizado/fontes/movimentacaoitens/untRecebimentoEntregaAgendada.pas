unit untRecebimentoEntregaAgendada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Uni,
  MaskEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, StrUtils, untZClient, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, System.ImageList, Vcl.ImgList,
  cxImageComboBox, cxDataControllerConditionalFormattingRulesManagerDialog,
  cxImageList;

type
  {$SCOPEDENUMS ON}
  TFiltroAgendamento = (ftCodigo, ftChave);
  {$SCOPEDENUMS OFF}
  TfrmRecebimentoEntregaAgendada = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    lbl4: TLabel;
    lbl1: TLabel;
    Label1: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    edtPlaca_: TMaskEditFocus;
    edtCodigo: TEditFocus;
    pnlAcesso: TPanel;
    Label4: TLabel;
    edtAcesso: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    Label30: TLabel;
    Label7: TLabel;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtEspDoc: TEditFocus;
    cxgDocumentos: TcxGridCitel;
    cxgDocumentosTableView: TcxGridDBTableViewCitel;
    cxgDocumentosTableViewADC_NUMDOC: TcxGridDBColumn;
    cxgDocumentosTableViewADC_ESPDOC: TcxGridDBColumn;
    cxgDocumentosTableViewADC_SERIE_: TcxGridDBColumn;
    cxgDocumentosTableViewADC_CODFOR: TcxGridDBColumn;
    cxgDocumentosTableViewFOR_NOMFOR: TcxGridDBColumn;
    cxgDocumentosLevel: TcxGridLevel;
    cxImageList1: TcxImageList;
    cxgDocumentosTableViewDOCCHK: TcxGridDBColumn;
    Label2: TLabel;
    edtNomMot: TEditFocus;
    Label3: TLabel;
    edtIdenti: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgDocumentosTableViewADC_NUMDOCGetDataText(
      Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtIdentiKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    cdsAgeDoc : TZClient;
    strTrava  : String;

    Function fGetSQLDocumentos(aFiltro: TFiltroAgendamento): String;
    function fCarregaDocumentos(aFiltro: TFiltroAgendamento; aValue: String):Boolean;
    procedure pLimpaDocumento;
    procedure pLimpaAgendamento;
    procedure pEnabled(blnEnabled: Boolean);
    procedure EnabledPnlAcesso(blnEnabled: Boolean);
    function fGetFornecDocs: String;
  public
  Published
    Function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas, untPlanoDeRecebimento;

procedure TfrmRecebimentoEntregaAgendada.btnConfirmaClick(Sender: TObject);
  Var
    qryUpdate : TUniQuery;
    strIdeDig : String;
    frmPlanoDeRecebimento:TfrmPlanoDeRecebimento;
    blnResult: Boolean;
begin
  //inherited;
  If not fVerificaCampos Then
    Exit;

  strIdeDig := cdsAgeDoc.FieldByName('ARC_IDEDIG').AsString;
  If fEmptyStr(strIdeDig) Then
    strIdeDig := fAtualizaProCod('DIGELE', 'ARC_IDEDIG', 'AGEREC');
  fStartTransaction;
  Try
    cdsAgeDoc.DisableControls;
    qryUpdate := fCriaQuery;
    Try
      With qryUpdate, SQL Do
      Begin
        Close;
        Clear;
        Add(' UPDATE AGEREC SET ARC_PLACA_ = :PLACA_, ');
        Add('                   ARC_NOMMOT = :NOMMOT, ');
        Add('                   ARC_DTAREC = :DTAREC, ');
        Add('                   ARC_HRAREC = :HRAREC, ');
        Add('                   ARC_OPEREC = :OPEREC, ');
        Add('                   ARC_STATUS = :STATUS, ');
        Add('                   ARC_IDENTI = :IDENTI, ');
        Add('                   ARC_IDEDIG = :IDEDIG, ');
        Add('                   ARC_FORREC = :FORREC  ');
        Add(' WHERE AUTOINCREM = :AUTINC              ');

        ParamByName('AUTINC').AsString   := cdsAgeDoc.FieldByName('ARCINC').AsString;
        ParamByName('PLACA_').AsString   := edtPlaca_.Text;
        ParamByName('NOMMOT').AsString   := edtNomMot.Text;
        ParamByName('DTAREC').AsDateTime := fNow;
        ParamByName('HRAREC').AsDateTime := fNow;
        ParamByName('OPEREC').AsString   := strLoginUsuarioLogado;
        ParamByName('STATUS').AsString   := 'EC';
        ParamByName('IDEDIG').AsString   := strIdeDig;
        ParamByName('IDENTI').AsString   := edtIdenti.Text;
        ParamByName('FORREC').AsString   := fGetFornecDocs;

        ExecSQL;

        Close;
        Clear;
        Add(' UPDATE GERELE SET GER_IDEDIG = :IDEDIG ');
        Add(' WHERE GER_DOCENT = :DOCENT             ');
        Add('   AND GER_ESPENT = :ESPENT             ');
        Add('   AND GER_CODFOR = :CODFOR             ');
        Add('   AND B07_SERIE  = :SERIE_             ');
        Add('   AND GER_CODEMP = :CODEMP             ');
        ParamByName('IDEDIG').AsString := strIdeDig;

        cdsAgeDoc.First;
        While Not cdsAgeDoc.Eof Do
        Begin
          ParamByName('DOCENT').AsString := cdsAgeDoc.FieldByName('ADC_NUMDOC').AsString;
          ParamByName('ESPENT').AsString := cdsAgeDoc.FieldByName('ADC_ESPDOC').AsString;
          ParamByName('CODFOR').AsString := cdsAgeDoc.FieldByName('ADC_CODFOR').AsString;
          ParamByName('SERIE_').AsString := cdsAgeDoc.FieldByName('ADC_SERIE_').AsString;
          ParamByName('CODEMP').AsString := cdsAgeDoc.FieldByName('ADC_CODEMP').AsString;
          ExecSQL;

          cdsAgeDoc.Next;
        End;

        If fCfgSis('PLAAUT') = 'S' Then
        Begin
          pCriarFormularios(TfrmPlanoDeRecebimento, frmPlanoDeRecebimento);
          Try
            frmPlanoDeRecebimento.blnConfirmacaoAutomatica := True;
            frmPlanoDeRecebimento.edtIdeDig.Text :=  ParamByName('IDEDIG').AsString;
            frmPlanoDeRecebimento.tipValItem := tvIteAti;
            frmPlanoDeRecebimento.fValidacampoExterno(frmPlanoDeRecebimento.edtIdeDig, False);
            frmPlanoDeRecebimento.btnConfirmaClick(frmPlanoDeRecebimento.btnConfirma);
            blnResult := fEmptyStr(frmPlanoDeRecebimento.strFalha);
            If Not blnResult  Then
            begin
              fRollback;
              pMensagemOk(frmPlanoDeRecebimento.strFalha);
            end;
          Finally
            FreeAndNil(frmPlanoDeRecebimento)
          End;
        End
        Else
          blnResult := True;
        pSetFocus(edtCodigo);
        If blnResult Then
        Begin
          fCommit;
          pLimpaDocumento;
          pLimpaAgendamento;

          fMensagem('', 'Recebimento Realizado com Sucesso' + #13 + 'Número Sequencial de Conferência: ' + ParamByName('IDEDIG').AsString, ['&OK'] );
        End;
      End;
    Finally
      FreeAndNil(qryUpdate);
      cdsAgeDoc.EnableControls;
    End;
  Except
    on E: exception do
      pMensagensErro(E.Message, 'TfrmRecebimentoEntregaAgendada.btnConfirmaClick');
  End;
end;

procedure TfrmRecebimentoEntregaAgendada.cxgDocumentosTableViewADC_NUMDOCGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;
  If cxgDocumentosTableView.DataController.GetValue(ARecordIndex, cxgDocumentosTableViewDOCCHK.Index) = '0' Then
    AText := '************';
end;

procedure TfrmRecebimentoEntregaAgendada.edtCodForKeyPress(Sender: TObject; var Key: Char);
  Var
    arrConsulta : TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, nil, key, arrConsulta) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRecebimentoEntregaAgendada.edtCodigoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqAgendamentoEntregaWMS(Self, edtCodigo, Nil, Key, arrSel, True, QuotedStr('AG') ) Then
  Begin
    fValidaCampos(edtCodigo, True);
  End;
end;

procedure TfrmRecebimentoEntregaAgendada.edtIdentiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, Nil, edtIdenti, Nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmRecebimentoEntregaAgendada.EnabledPnlAcesso(blnEnabled: Boolean);
begin
  edtNumDoc.Enabled := blnEnabled;
  edtEspDoc.Enabled := blnEnabled;
  edtSerie.Enabled := blnEnabled;
  edtCodFor.Enabled := blnEnabled;
end;

function TfrmRecebimentoEntregaAgendada.fGetFornecDocs: String;
begin
  Result := '';
  cdsAgeDoc.First;
  While Not cdsAgeDoc.Eof Do
  Begin
    If Pos(cdsAgeDoc.FieldByName('FOR_CODFOR').AsString, Result) <= 0 Then
      Result := Result + cdsAgeDoc.FieldByName('FOR_CODFOR').AsString + '-' + cdsAgeDoc.FieldByName('FOR_NOMFOR').AsString + ' | ';
    cdsAgeDoc.Next;
  End;
end;

function TfrmRecebimentoEntregaAgendada.fGetSQLDocumentos(aFiltro: TFiltroAgendamento): String;
begin
  Result := '';
  Result := Result + ' SELECT A.*,                                        ';
  Result := Result + '        ARC_CODIGO,                                 ';
  Result := Result + '        ARC_CODTRA,                                 ';
  Result := Result + '        ARC_PLACA_,                                 ';
  Result := Result + '        ARC_STATUS,                                 ';
  Result := Result + '        ARC_DTAENT,                                 ';
  Result := Result + '        ARC_NOMMOT,                                 ';
  Result := Result + '        ARC_IDENTI,                                 ';
  Result := Result + '        FOR_NOMFOR,                                 ';
  Result := Result + '        ARC_IDEDIG,                                 ';
  Result := Result + '        FOR_CODFOR,                                 ';
  Result := Result + '        0 AS DOCCHK,                                ';
  Result := Result + '        C.AUTOINCREM AS ARCINC                      ';
  Result := Result + ' FROM AGEDOC A                                      ';
  Result := Result + ' INNER JOIN CADFOR B ON B.FOR_CODFOR = A.ADC_CODFOR ';
  Result := Result + ' INNER JOIN AGEREC C ON C.AUTOINCREM = ADC_SEQGER   ';
  Result := Result + ' WHERE ARC_CODEMP = :CODEMP                         ';

  if aFiltro = TFiltroAgendamento.ftCodigo then
    Result := Result + '   AND ARC_CODIGO = :CODIGO                       ';

  if aFiltro = TFiltroAgendamento.ftChave then
    Result := Result + '   AND ARC_CODIGO = (SELECT ARC_CODIGO FROM AGEDOC INNER JOIN AGEREC ON AGEREC.AUTOINCREM = AGEDOC.ADC_SEQGER WHERE IFNULL(AGEDOC.ADC_ACESSO,"") = :CHAVE LIMIT 1) ';
end;

procedure TfrmRecebimentoEntregaAgendada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If cdsAgeDoc.Active And (cdsAgeDoc.RecordCount > 0) Then
  Begin
    If (fMensagem('', 'Deseja Cancelar o Recebimento Carregado?', ['&Sim', '&Não'], 2) = 1) Then
    Begin
      pLimpaDocumento;
      pLimpaAgendamento;
      pSetFocus(edtCodigo);
    End;
    Action := caNone;
  End;

end;

procedure TfrmRecebimentoEntregaAgendada.FormCreate(Sender: TObject);
begin
  inherited;
  cdsAgeDoc := TZClient.Create(Self);
  cdsAgeDoc.pCriaSoma('DOCCHK', 'QTDCON', 'SUM(DOCCHK)');
  cxgDocumentosTableView.DataController.DataSource := cdsAgeDoc.dtsSource;
end;

procedure TfrmRecebimentoEntregaAgendada.FormShow(Sender: TObject);
begin
  inherited;
  EnabledPnlAcesso(False);
end;

function TfrmRecebimentoEntregaAgendada.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  intQtdDig: Integer;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodigo) And blnBuscaPorChave Then
    Begin
      if fEmptyStr(edtCodigo.Text) Then
      Begin
        Result := fMensagem('', 'Digite um Número de Agendamento para iniciar a conferência!', ['&OK']) = -1;
      End
      Else
      Begin
        Result := fCarregaDocumentos(TFiltroAgendamento.ftCodigo,edtCodigo.Text);
        If Result Then
        Begin
          blnMudarFoco := False;
          If fEmptyStr( ReplaceStr(edtPlaca_.Text, '-', '') ) Then
            pSetFocus(edtPlaca_)
          Else
            pSetFocus(edtNomMot);
        End;
      End;
    End

    Else
    If (Sender = edtPlaca_) Then
    Begin
      intQtdDig := Length(ReplaceStr(ReplaceStr(edtPlaca_.Text,'-', ''), ' ', ''));

      If intQtdDig = 0 Then
      Begin
        Result := fMensagem('', 'Digite a placa do Veiculo!', ['&Ok']) = -1;
      End
      Else If intQtdDig <> 7 Then
      Begin
        pMensagemOk('A placa deve conter 7 dígitos!');
        Result := False;
      End
    End

    Else
    If (Sender = edtNomMot) Then
    Begin
      If fEmptyStr(edtNomMot.Text) Then
        Result := fMensagem('', 'Digite o Nome do Motorista!', ['&Ok']) = -1;
    End

    Else
    If (Sender = edtAcesso) And blnBuscaPorChave Then
    Begin
      If (not fEmptyStr(edtAcesso.Text)) and (Length(edtAcesso.Text)=44) Then
      Begin
        if (edtNomTra.Text = '') then
          fCarregaDocumentos(TFiltroAgendamento.ftChave, edtAcesso.Text);
        If (edtNomTra.Text = '') then
          Exit;

        If cdsAgeDoc.Locate('ADC_ACESSO', edtAcesso.Text, []) Then
        Begin
          cdsAgeDoc.Edit;
          cdsAgeDoc.FieldByName('DOCCHK').AsString := '1';
          cdsAgeDoc.Post;
          pLimpaDocumento;

          blnMudarFoco := False;
          pSetFocus(edtAcesso);

        End
        Else
          Result := fMensagem('', 'Documento não agendado!', ['&Ok']) = -1;

      End;
    End

    Else
    If (Sender = edtNumDoc) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
        Result := fMensagem('', 'Digite o número do Documento', ['&OK'])=-1;
    End

    Else
    If (Sender = edtEspDoc) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtEspDoc.Text) Then
        Result := fMensagem('', 'Digite a espécie do Documento', ['&OK'])=-1;
    End

    Else
    If (Sender = edtSerie) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtSerie.Text) Then
        Result := fMensagem('', 'Digite a série do Documento', ['&OK'])=-1;
    End

    Else
    If (Sender = edtCodFor) And blnBuscaPorChave Then
    Begin
      If not fEmptyStr(edtCodFor.Text) Then
      Begin
        edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);
        If fEmptyStr(edtNomFor.Text) Then
        Begin
          Result := fMensagem('', 'O Código de Fornecedor Digitado Não Existe!', ['&OK']) = -1;
        End
        Else
        Begin
          If cdsAgeDoc.Locate('ADC_NUMDOC;ADC_ESPDOC;ADC_SERIE_;ADC_CODFOR', VarArrayOf([edtNumDoc.Text,
                                                                                         edtEspDoc.Text,
                                                                                         edtSerie.Text,
                                                                                         edtCodFor.Text]), []) Then
          Begin
            cdsAgeDoc.Edit;
            cdsAgeDoc.FieldByName('DOCCHK').AsString := '1';
            cdsAgeDoc.Post;
            pLimpaDocumento;
            blnMudarFoco := False;
            pSetFocus(edtNumDoc);
          End
          Else
            Result := fMensagem('', 'Documento não agendado!', ['&Ok']) = -1;
        End;
      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);
end;

function TfrmRecebimentoEntregaAgendada.fCarregaDocumentos(aFiltro: TFiltroAgendamento; aValue : String):Boolean;
Begin
  Result := True;
  cdsAgeDoc.qryQuery.Close;
  cdsAgeDoc.qryQuery.SQL.Clear;

  cdsAgeDoc.qryQuery.SQL.Text := fGetSQLDocumentos(aFiltro);
  cdsAgeDoc.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  if aFiltro = TFiltroAgendamento.ftCodigo then
  begin
    if not Assigned(cdsAgeDoc.qryQuery.Params.FindParam('CODIGO')) then
      cdsAgeDoc.qryQuery.Params.CreateParam(ftString,'CODIGO',ptInput);

    cdsAgeDoc.qryQuery.ParamByName('CODIGO').AsString := aValue;
  end;

  if aFiltro = TFiltroAgendamento.ftChave then
  begin
    if not Assigned(cdsAgeDoc.qryQuery.Params.FindParam('CHAVE')) then
      cdsAgeDoc.qryQuery.Params.CreateParam(ftString,'CHAVE',ptInput);

    cdsAgeDoc.qryQuery.ParamByName('CHAVE').AsString := aValue;
  end;

  cdsAgeDoc.fAbreClient(True,'TfrmRecebimentoEntregaAgendada.pCarregaDocumentos');

  strTrava := 'frmRecebimentoEntregaAgendada_' + VS_strCodEmp + '_' + cdsAgeDoc.FieldByName('ARC_CODIGO').AsString;
  If not fLock_Unlock(strTrava, True, False) Then
  Begin
    fMensagem('', 'Este cadastro está sendo utilizado em Outra Estação por ' +
                   fGetHostLock(strTrava)  + '!', ['&Ok']);
    edtCodigo.Clear;
    cdsAgeDoc.Close;
    Result := False;
    Exit;
  End;

  try

    If (cdsAgeDoc.RecordCount > 0) Then
    Begin
      If cdsAgeDoc.FieldByName('ARC_STATUS').AsString <> 'AG' Then
      Begin
        fMensagem('', 'Já foi efetuada a entrada do caminhão do agendamento escolhido!', ['&OK']);
        Result := False;
        Exit;
      End;

      If cdsAgeDoc.FieldByName('ARC_DTAENT').AsDateTime <> VS_date Then
      Begin
        fMensagem('', 'O Agendamento escolhido não está programado para a data de hoje!', ['&OK']);
        Result := False;
        Exit;
      End;
      edtCodigo.Enabled := False;
      edtCodigo.Text := cdsAgeDoc.FieldByName('ARC_CODIGO').AsString;
      edtCodTra.Text := cdsAgeDoc.FieldByName('ARC_CODTRA').AsString;
      edtNomTra.Text := cdsAgeDoc.FieldByName('FOR_NOMFOR').AsString;
      edtPlaca_.Text := cdsAgeDoc.FieldByName('ARC_PLACA_').AsString;
      edtNomMot.Text := cdsAgeDoc.FieldByName('ARC_NOMMOT').AsString;
      edtIdenti.Text := cdsAgeDoc.FieldByName('ARC_IDENTI').AsString;

      pEnabled(True);
    End
    Else
    Begin
      Result := fMensagem('', 'Agendamento não encontrado!', ['&Ok']) = -1;
      edtCodigo.Clear;
    End;
  finally
    if not Result then
      pLimpaAgendamento;
  end;

End;

procedure TfrmRecebimentoEntregaAgendada.pLimpaDocumento;
Begin
  edtAcesso.Clear;
  edtNumDoc.Clear;
  edtSerie.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  btnConfirma.Enabled := cdsAgeDoc.RecordCount = cdsAgeDoc.fRetSoma('QTDCON');
End;

procedure TfrmRecebimentoEntregaAgendada.pLimpaAgendamento;
Begin
  fLock_Unlock(strTrava, False);

  edtPlaca_.Clear;
  edtNomTra.Clear;
  edtCodTra.Clear;
  edtCodigo.Clear;
  edtNomMot.Clear;
  edtIdenti.Clear;
  cdsAgeDoc.Close;

  pSetFocus(edtCodigo);
  pEnabled(False);
End;


procedure TfrmRecebimentoEntregaAgendada.pEnabled(blnEnabled : Boolean);
Begin
  edtCodigo.Enabled := Not blnEnabled;
  edtPlaca_.Enabled := blnEnabled;
  EnabledPnlAcesso(blnEnabled);
  edtNomMot.Enabled := blnEnabled;
  edtIdenti.Enabled := blnEnabled;
End;


end.
