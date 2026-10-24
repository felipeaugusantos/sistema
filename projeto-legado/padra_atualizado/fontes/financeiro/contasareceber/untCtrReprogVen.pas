unit untCtrReprogVen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  EditFocus, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, UniClientDataSet, untTypesSistema,
  cxProgressBar, untConsultas, UniDataSetProvider, untTLock, Uni, untCtrReprogVenBusca;

type
  TfrmCtrReprogVen = class(TfrmPai)
    pnlTopo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    Label13: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblPortador: TLabel;
    edtCodPor: TEditFocus;
    edtDesPor: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    btnConsultar: TBitBtnLocked;
    cxDados: TcxGrid;
    cxDadosView: TcxGridDBTableView;
    colNUMDUP: TcxGridDBColumn;
    colPARCEL: TcxGridDBColumn;
    colCODEMP: TcxGridDBColumn;
    colVALDUP: TcxGridDBColumn;
    colMARDES: TcxGridDBColumn;
    cxDadosLevel1: TcxGridLevel;
    colCODCLI: TcxGridDBColumn;
    colDTAVEN: TcxGridDBColumn;
    btnMarTodas: TBitBtnLocked;
    btnDesTodas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnHistDocumentos: TBitBtnLocked;
    dtsDados: TDataSource;
    colESPDOC: TcxGridDBColumn;
    colDTACAD: TcxGridDBColumn;
    colVALCAL: TcxGridDBColumn;
    shpMultSel: TShape;
    rgPeriodo: TRadioGroup;
    btnIniciaBusca: TBitBtnLocked;
    btnLocalizaProx: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarTodasClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure cxDadosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxDadosViewDblClick(Sender: TObject);
    procedure cxDadosViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDesTodasClick(Sender: TObject);
    procedure btnHistDocumentosClick(Sender: TObject);
    procedure btnIniciaBuscaClick(Sender: TObject);
    procedure btnLocalizaProxClick(Sender: TObject);
  private
    { Private declarations }
    frmCtrReprogVenBusca : TfrmCtrReprogVenBusca;
    cdsDados: TUniClientDataset;
    pvdDados: TUniDataSetProvider;
    qryDados: TUniQuery;

    arrEmpresa : TConsultasArray;
    arrClientes: TConsultasArray;
    arrPortador: TConsultasArray;

    objLock : TLock;

    strClientes: String;
    strPortador: String;
    strEmpresa: String;

    blnDescFinanSomenteAteVenc: Boolean;

    dtaDtaVen: TDateTime;

    strValorFiltro : String;
    strCampoFiltro : String;

    procedure pCriaTemporaria;
    procedure pLimparTela;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pDestravarParcela(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
    procedure pAtualizaVencimento;
    procedure pSelecionaDuplicata;

    function fSelecionouDuplicata : Boolean;
    function fDuplicataTravada(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String; blnMosMen: Boolean = True): Boolean;
    function fFiltraMultiEmpresas(strCodPor: String = ''): Boolean;
    function fVerificaDataVenc: Boolean;
    function fField(strName: String): TField;
    procedure pConcluiBusca;
    procedure pLocalizaProximaDup;
    procedure pFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fMarcarTodos(pgbStatus: TcxProgressBar): Boolean;
    function fDesmarcarTodos(pgbStatus: TcxProgressBar): Boolean;

    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pCalculaValorCorrigido;
  end;

implementation

{$R *.dfm}

uses untGravando, untAltDtaVenc, untFuncoesSimples, untFuncoesConsulta, untTCadRec, untLogCtr,
  untRelCtrLogAcompDuplicNovo, StrUtils;

procedure TfrmCtrReprogVen.btnConfirmaClick(Sender: TObject);
  Var
    frmAltDtaVenc : TfrmAltDtaVenc;
begin
  inherited;

  If Not fSelecionouDuplicata Then
  Begin
    pMensagemOk('Nenhuma duplicata selecionada. Verifique!');
    pSetFocus(mskDtaIni);
    Exit;
  End;

  If Not fVerificaAcessoSistema('CTRALTVENDUP', strLoginUsuarioLogado) Then
  Begin
    fMensagem('','Usuário não possui direitos de acesso para realizar esta operação!', ['&OK']);
    pLimparTela;
    Exit;
  End;

  dtaDtaVen := 0;

  Try
    pCriarFormularios(TfrmAltDtaVenc, frmAltDtaVenc);
    frmAltDtaVenc.mskDtaVen.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
    frmAltDtaVenc.ShowModal;

    If frmAltDtaVenc.blnConfirma = True Then
      dtaDtaVen := frmAltDtaVenc.dtaDtaVen;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmAgrupDuplicatas.dbgDuplicatasKeyDown]');
  End;

  pFreeAndNil(frmAltDtaVenc);

  If fVerificaDataVenc Then
  Begin
    TfrmGravando.fExecutarModal(pAtualizaVencimento,'Atualizando Duplicatas... Aguarde...','');
  End;

end;

procedure TfrmCtrReprogVen.btnConsultarClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(mskDtaIni,false) Then
    Exit;

  If Not fValidaCampos(mskDtaFin,false) Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Carregando Títulos','');

  If Not cdsDados.isEmpty Then
    pSetFocus(cxDados);

end;

procedure TfrmCtrReprogVen.btnDesTodasClick(Sender: TObject);
begin
  inherited;
  If Not fSelecionouDuplicata Then
  Begin
    fMensagem('','É necessário selecionar ao menos um registro para desmarcar!',['&O K']);
    pSetFocus(cxDados);
    Exit;
  End;

  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodos;
  frmGravando.lblGravando.Caption := 'Aguarde...Desmarcando Duplicatas';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmCtrReprogVen.btnHistDocumentosClick(Sender: TObject);
Var
    frmRelCtrLogAcompDuplicNovo: TfrmRelCtrLogAcompDuplicNovo;
begin
  inherited;
  Try
    pCriarFormularios(TfrmRelCtrLogAcompDuplicNovo, frmRelCtrLogAcompDuplicNovo);
    frmRelCtrLogAcompDuplicNovo.blnVeioCtrReprogVen := True;
    frmRelCtrLogAcompDuplicNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmRelCtrLogAcompDuplicNovo.btnHistDocumentos]');
  End;

  pFreeAndNil(frmRelCtrLogAcompDuplicNovo);
end;

procedure TfrmCtrReprogVen.btnIniciaBuscaClick(Sender: TObject);
begin
  inherited;

  If cdsDados.IsEmpty Then
  Begin
    fMensagem('', 'É necessário filtrar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCtrReprogVenBusca, frmCtrReprogVenBusca);
    frmCtrReprogVenBusca.ShowModal;

    TfrmGravando.fExecutarModal(pConcluiBusca,'Aguarde... Localizando Duplicata.','');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmAgrupDuplicatasCtp.btnIniciaBusca]');
    End;
  End;

  pSetFocus(cxDados);
  pFreeAndNil(frmCtrReprogVenBusca);
end;

procedure TfrmCtrReprogVen.btnLocalizaProxClick(Sender: TObject);
begin
  inherited;

  If cdsDados.IsEmpty Then
  Begin
    fMensagem('AVISO', 'É necessário filtrar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    TfrmGravando.fExecutarModal(pLocalizaProximaDup,'Aguarde... Localizando Título.','');
    pSetFocus(cxDados);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmCtrReprogVen.btnMarTodasClick(Sender: TObject);
begin
  inherited;

  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodos;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando duplicatas';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmCtrReprogVen.cxDadosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If (cdsDados.IsEmpty) Then Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, colMARDES.Index]) = 'M' Then
  Begin

    If AViewInfo.Selected Then ACanvas.Font.Color := clLime
    Else ACanvas.Font.Color := clBlue;

  End;
end;

procedure TfrmCtrReprogVen.cxDadosViewDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
  cxDadosView.NavigatorButtons.Next.Click;
end;

procedure TfrmCtrReprogVen.cxDadosViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of

    VK_Escape: pLimparTela;
    VK_Return: Begin
                 pSelecionaDuplicata;
                 cxDadosView.NavigatorButtons.Next.Click;
               End;

  End;
end;

procedure TfrmCtrReprogVen.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmCtrReprogVen.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtrReprogVen.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEmp.ReadOnly Then
    pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmCtrReprogVen.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtrReprogVen.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPor, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmCtrReprogVen.edtCodPorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text,
                   IIF(edtCodEmp.Text = '000', True, False)) Then
  Begin
    If fValidaCampos(edtCodPor,False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCtrReprogVen.fDesmarcarTodos(pgbStatus: TcxProgressBar): Boolean;
var
  prcScroll: TprcScroll;
begin
  Result := true;
  If (cdsDados.IsEmpty) Then
  Begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  End;

  pgbStatus.Properties.Max := cdsDados.RecordCount;

  Try
    pDisableControls(cdsDados, prcScroll);
    cdsDados.AggregatesActive := False;
    If cdsDados.IsEmpty Then
      Exit;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      pMarcaDuplicata(False);
      pStep(pgbStatus);
      cdsDados.Next;
    End;
  Finally
    cdsDados.First;
    pEnableControls(cdsDados, prcScroll);
  End;

  cxDadosView.NavigatorButtons.First.Click;
  cdsDados.AggregatesActive := True;
end;

function TfrmCtrReprogVen.fDuplicataTravada(strNumDup, strEspDoc, strCodEmp, strCodCli,
  strParcel: String; blnMosMen: Boolean): Boolean;
  Var
    strChaLck: String;
begin
  Result := False;

  strChaLck := 'CADREC' +
               strNumDup +
               strEspDoc +
               strCodEmp +
               strCodCli +
               strParcel;

  If Not objLock.fLock_Unlock(strChaLck, True, False) Then
  Begin
    If blnMosMen Then
      pMensagemOk('Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck));

    Result := True;
    Exit;
  End;
end;

function TfrmCtrReprogVen.fField(strName: String): TField;
begin
  Result := cdsDados.FieldByName(strName);
end;

function TfrmCtrReprogVen.fFiltraMultiEmpresas(strCodPor: String = ''): Boolean;
  Var
    intCont: Integer;
    strSQL,
    strCodEmp: String;
    qryTmp: TUniQuery;
begin
  Result := False;
  qryTmp := fCriaQuery(Nil);

  Try

    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      Result := True;
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + ' SELECT POR_EMPACE ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADPOR ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   POR_CODPOR = :CODIGO ';

    qryTmp.SQL.Add(strSQL);
    qryTmp.ParamByName('CODIGO').AsString := strCodPor;
    qryTmp.Open;

    For intCont := Low(arrEmpresa) To High(arrEmpresa) Do
    Begin
      strCodEmp := strCodEmp + arrEmpresa[intCont].strCodigo;

      Result := Pos(strCodEmp, qryTmp.FieldByName('POR_EMPACE').AsString) > 0;
      If Result Then Exit Else strCodEmp := '';

    End;

    qryTmp.Close;

  Finally
    FreeAndNil(qryTmp);
  End;
end;

function TfrmCtrReprogVen.fMarcarTodos(pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll: TprcScroll;
begin
  Result := True;
  If (cdsDados.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;
    pgbStatus.Properties.Max := cdsDados.RecordCount;

  If cdsDados.IsEmpty Then
    Exit;
  Try
    pDisableControls(cdsDados, prcScroll);

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If Not fDuplicataTravada(cdsDados.FieldByName('NRODUP').AsString,
                               cdsDados.FieldByName('ESPDOC').AsString,
                               cdsDados.FieldByName('CODEMP').AsString,
                               cdsDados.FieldByName('CODCLI').AsString,
                               cdsDados.FieldByName('PARDUP').AsString,
                               False) Then
      Begin
        pMarcaDuplicata(True);
      End;
      pStep(pgbStatus);
      cdsDados.Next;
    End;
  Finally
    cdsDados.First;
    pEnableControls(cdsDados, prcScroll);
  end;

  cxDadosView.NavigatorButtons.First.Click;
  cdsDados.AggregatesActive := True;
End;

procedure TfrmCtrReprogVen.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaIni);
end;

procedure TfrmCtrReprogVen.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmCtrReprogVen.FormCreate(Sender: TObject);
begin
  inherited;
  qryDados := fCriaQuery(Self);

  pvdDados := TUniDataSetProvider.Create(Self);
  pvdDados.DataSet := qryDados;

  cdsDados := TUniClientDataset.Create(Self);
  cdsDados.OnFilterRecord := pFilterRecord;

  dtsDados.DataSet := cdsDados;

  mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  objLock := TLock.Create;

  blnDescFinanSomenteAteVenc := (fCfgSis('UTDEFN') = '2');
end;

procedure TfrmCtrReprogVen.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
     VK_F5 : btnIniciaBusca.Click;
     VK_F6 : btnLocalizaProx.Click;
     VK_F10: btnConfirma.Click;
     VK_F8 : btnDesTodas.Click;
     VK_F7 : btnMarTodas.Click;
  End;

end;

function TfrmCtrReprogVen.fSelecionouDuplicata: Boolean;
  Var
    intRecNo: Integer;
begin
  inherited;

  Result := False;

  If (cdsDados.IsEmpty) Then
    Exit;

  intRecNo := cdsDados.RecNo;
  cdsDados.DisableControls;

  cdsDados.Filtered := False;
  cdsDados.Filter := 'MARDES = ''M''';
  cdsDados.Filtered := True;

  If Not cdsDados.Eof Then
    Result := True;

  cdsDados.Filtered := False;

  cdsDados.RecNo := intRecNo;
  cdsDados.EnableControls;
  cdsDados.IndexFieldNames := 'DTAVEN;NRODUP';

end;

function TfrmCtrReprogVen.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        pMensagemOk('O campo Data Inicial deve ser preenchido!');
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            pMensagemOk('O campo Data Final deve ser preenchido!');
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              pMensagemOk('A data inicial deve ser menor que a data final!');
              Result := False;
            End;
          End;
        End
      End;

    End

    Else If Sender = edtCodCli Then
    Begin
      If (Not fEmptyStr(edtCodCli.Text)) Then
      Begin
        If Not SameText(edtCodCli.Text, '00000000') Then
        Begin
          edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

          If fEmptyStr(edtNomCli.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else
      Begin
        edtNomCli.Clear;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin
      If Not fEmptyStr(edtCodEmp.Text) And (edtCodEmp.Text <> '000') Then
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
          Result := False;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          pMensagemOk('Usuário sem permissão de acesso a essa Empresa!');
          Result := False;
        End;
      End;
    End

    Else If Sender = edtCodPor Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin
        edtDesPor.Text := fRetNomPortador(edtCodPor.Text);

        If fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Portador não cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fFiltraMultiEmpresas(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão para visualizar lançamentos para este portador!', ['&O k']);
            Result := False;
          End;
        End;
      End
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCtrReprogVen.fVerificaDataVenc: Boolean;
begin
  Result := True;

  If (dtaDtaVen <> 0) Then
  Begin
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsDados.FieldByName('MARDES').AsString = 'M' Then
      Begin
        If (dtaDtaVen < cdsDados.FieldByName('DTACAD').AsDateTime) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data de vencimento precisa ser maior ou igual a data de cadastro!', ['&O k']);
          Result := False;
          Exit;
        End;
      End;

      cdsDados.Next;
    End;
  End
  Else
    Result := False;
end;

procedure TfrmCtrReprogVen.pAtualizaVencimento;
  Var
    intRecNo: Integer;
    qryGen  : TUniQuery;
begin
  Try
    qryGen := fCriaQuery(Nil);

    intRecNo := cdsDados.RecNo;
    cdsDados.DisableControls;

    cdsDados.First;

    fStartTransaction;
    While Not cdsDados.Eof Do
    Begin

      If cdsDados.FieldByName('MARDES').AsString = 'M' Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add('UPDATE CADREC SET ' +
                       '  CTR_DTAVEN = :DTAVEN ' +
                       'WHERE ' +
                       '  CTR_CODCLI = :CODCLI AND CTR_NUMDUP = :NRODUP AND CTR_SEQBAI = :SEQBAI AND ' +
                       '  CTR_PARCEL = :PARDUP AND CTR_CODEMP = :CODEMP ');
        qryGen.ParamByName('DTAVEN').AsDate   := dtaDtaVen;
        qryGen.ParamByName('CODCLI').AsString := cdsDados.FieldByName('CODCLI').AsString;
        qryGen.ParamByName('NRODUP').AsString := cdsDados.FieldByName('NRODUP').AsString;
        qryGen.ParamByName('SEQBAI').AsInteger:= cdsDados.FieldByName('SEQBAI').AsInteger;
        qryGen.ParamByName('PARDUP').AsString := cdsDados.FieldByName('PARDUP').AsString;
        qryGen.ParamByName('CODEMP').AsString := cdsDados.FieldByName('CODEMP').AsString;
        qryGen.ExecSQL;
      End;

      cdsDados.Next;
    End;

    fCommit;

    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      If cdsDados.FieldByName('MARDES').AsString = 'M' Then
      Begin
        untLogCtr.GravaLogCtr(cdsDados.FieldByName('AUTOINCREM').AsString, 'ALTERACAO DE VENCIMENTO', Self.Name);
      end;
      cdsDados.Next;
    end;

    cdsDados.RecNo := intRecNo;
    cdsDados.EnableControls;

    pMensagemOk('Dados alterados com sucesso!');
    pLimparTela;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message,'TfrmCtrReprogVen.pAtualizaVencimento');
    End;
  End;

  FreeAndNil(qryGen);
end;

procedure TfrmCtrReprogVen.pCalculaValorCorrigido;
  Var
    fltJuros, fltValDespon: Double;
begin
  Application.ProcessMessages;
  fltValDespon := 0;

  cdsDados.DisableControls;
  Try
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      fltJuros := fCalculaJurosCadCtr(cdsDados.FieldByName('DTAVEN').AsDateTime,
                                      cdsDados.FieldByName('VALSUJ').AsFloat,
                                      cdsDados.FieldByName('TAXJUR').AsFloat,
                                      cdsDados.FieldByName('PERMUL').AsFloat);

      cdsDados.Edit;

      if (blnDescFinanSomenteAteVenc) then
      begin
        If (cdsDados.FieldByName('DTAVEN').asDateTime >= VS_Date)  then
          cdsDados.FieldByName('VALCAL').AsFloat := cdsDados.FieldByName('VALSUJ').AsFloat + fltJuros
        else
          cdsDados.FieldByName('VALCAL').AsFloat := cdsDados.FieldByName('VALSUJ').AsFloat + fltJuros;
      end
      else
      If (cdsDados.FieldByName('DTAVEN').AsDateTime >= VS_Date)  then
        cdsDados.FieldByName('VALCAL').AsFloat := cdsDados.FieldByName('VALSUJ').AsFloat + fltJuros
      else
        cdsDados.FieldByName('VALCAL').AsFloat := cdsDados.FieldByName('VALSUJ').AsFloat + fltJuros;

      If cdsDados.FieldByName('ESPDOC').AsString <> 'CC' Then
      Begin
        cdsDados.FieldByName('VALJUR').AsFloat := fltJuros;

        If (fCfgSis('DESPON', varBoolean)) And
           (VS_Date <= (cdsDados.FieldByName('DTAVEN').asDateTime - fField('QTDDAV').AsInteger)) Then
        Begin
          fltValDespon  := fFormataFloat(cdsDados.FieldByName('VALCAL').AsFloat * ( fField('PERDPO').AsFloat / 100.00 ),2);
        End;

        cdsDados.FieldByName('VALCAL').AsFloat := IIF (fltValDespon > 0 , cdsDados.FieldByName('VALCAL').AsFloat - fltValDespon, cdsDados.FieldByName('VALCAL').AsFloat)

      End
      Else
        cdsDados.FieldByName('VALCAL').AsFloat := cdsDados.FieldByName('VALCAL').AsFloat - fltJuros;

      cdsDados.Post;
      cdsDados.Next;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
  cdsDados.First;
  cdsDados.EnableControls;

end;

procedure TfrmCtrReprogVen.pCriaTemporaria;
  Var
    strSQL: String;
begin
  Try

    cdsDados.Close;
    cdsDados.SetProvider(pvdDados);

    strSQL := 'SELECT ' +
              '  R.AUTOINCREM,         ' +
              '  CTR_NUMDUP AS NRODUP, ' +
              '  CTR_PARCEL AS PARDUP, ' +
              '  CTR_CODEMP AS CODEMP, ' +
              '  CONCAT(R.CTR_CODCLI, "-", C.CLI_NOMCLI) AS NOMCLI, ' +
              '  CTR_CODCLI AS CODCLI, ' +
              '  CTR_CODPOR AS CODPOR, ' +
              '  CTR_DTAVEN AS DTAVEN, ' +
              '  CTR_VALDUP AS VALDUP, ' +
              '  CTR_ESPDOC AS ESPDOC, ' +
              '  CTR_CODCTA AS CODCTA, ' +
              '  CTR_SEQBAI AS SEQBAI, ' +
              '  CTR_DTACAD AS DTACAD, ' +
              '  0.00       AS VALCAL, ' +
              '  CTR_VALJUR AS VALJUR, ' +
              '  CTR_QTDDAV AS QTDDAV, ' +
              '  CTR_PERDPO AS PERDPO, ';
              If Not blnDescFinanSomenteAteVenc Then
              Begin
                strSQL := strSQL + '  (R.CTR_VALDUP - IFNULL(R.CTR_DESSUJ, 0) + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0)) AS VALSUJ, ';
              End
              Else
              Begin
                strSQL := strSQL + '  (R.CTR_VALDUP - IF( R.CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(R.CTR_DESSUJ, 0), 0 ) + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0)) AS VALSUJ, ';
              End;

    strSQL := strSQL + '  ' + AnsiReplaceStr(FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 4), ',', '.') + ' AS TAXJUR, ';
    strSQL := strSQL + '  ' + AnsiReplaceStr(FloatToStrF(fCfgSis('MULATR', varDouble), ffFixed, 12, 4), ',', '.') + ' AS PERMUL, ';
    strSQL := strSQL + '  "D" AS MARDES         ' +
                       'FROM                    ' +
                       '  CADREC R              ' +
                       '  JOIN CADCLI C ON CTR_CODCLI = CLI_CODCLI ' +
                       'WHERE ' +
                       '  CTR_DTABAI IS NULL AND ' +
                       '  CTR_ESPDOC NOT IN ( "PD" ) AND ';

    case rgPeriodo.ItemIndex of
      0 : strSQL := strSQL + ' CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
      1 : strSQL := strSQL + ' CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN  ';
    end;

    strSQL := strSQL + fSQLIn(edtCodCli,  arrClientes, 'CTR_CODCLI', 'CODCLI') +
                       fSQLIn(edtCodEmp,  arrEmpresa,  'CTR_CODEMP', 'CODEMP');

    If Not fEmptyStr(edtCodPor.Text) Then
      strSQL := strSQL + fSQLIn(edtCodPor,  arrPortador, 'CTR_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND (IFNULL(CTR_CODPOR, "") = "" ';
      strSQL := strSQL + ' OR LOCATE(CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(strSQL);

    qryDados.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
    qryDados.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);

    pSetaParam(edtCodCli.Text, arrClientes, strClientes, 'CODCLI', qryDados);
    pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryDados);
    pSetaParam(edtCodEmp.Text, arrEmpresa,  strEmpresa,  'CODEMP', qryDados);

    qryDados.Open;

    If qryDados.IsEmpty Then
    Begin
      pMensagemOk('Não foi encontrado dados!');

      pLimparTela;

      Exit;
    End;

    objLock.pDestravarTodos;

    pSetaClient(qryDados);

    cdsDados.Open;

    pCalculaValorCorrigido;

    TFloatField(cdsDados.FieldByName('VALDUP')).DisplayFormat := '#,##0.00';
    TFloatField(cdsDados.FieldByName('VALCAL')).DisplayFormat := '#,##0.00';

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'TfrmCtrReprogVen.pCriaTemporaria');
  End;

end;

procedure TfrmCtrReprogVen.pDestravarParcela(strNumDup, strEspDoc, strCodEmp, strCodCli,
  strParcel: String);
  Var
    strChaLck : String;
begin
  strChaLck := 'CADREC' +
               strNumDup +
               strEspDoc +
               strCodEmp +
               strCodCli +
               strParcel;

  objLock.fLock_Unlock(strChaLck, False);
end;

procedure TfrmCtrReprogVen.pLimparTela;
begin
  cdsDados.Close;
  pSetFocus(mskDtaIni);

  edtCodCli.Clear;
  edtNomCli.Clear;
  SetLength(arrClientes,0);

  edtCodPor.Clear;
  edtDesPor.Clear;
  SetLength(arrPortador,0);

  edtCodEmp.Clear;
  edtDesEmp.Clear;
  SetLength(arrEmpresa,0);

end;

procedure TfrmCtrReprogVen.pMarcaDuplicata(blnMarcar: Boolean);
begin
  If Not blnMarcar Then
  Begin
    pDestravarParcela(cdsDados.FieldByName('NRODUP').AsString,
                      cdsDados.FieldByName('ESPDOC').AsString,
                      cdsDados.FieldByName('CODEMP').AsString,
                      cdsDados.FieldByName('CODCLI').AsString,
                      cdsDados.FieldByName('PARDUP').AsString);
  End;

  cdsDados.Edit;
  cdsDados.FieldByName('MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsDados.Post;
end;

procedure TfrmCtrReprogVen.pSelecionaDuplicata;
begin
  If cdsDados.IsEmpty Then
    Exit;

  If cdsDados.FieldByName('MARDES').AsString <> 'M' Then
  Begin
    If fDuplicataTravada(cdsDados.FieldByName('NRODUP').AsString,
                         cdsDados.FieldByName('ESPDOC').AsString,
                         cdsDados.FieldByName('CODEMP').AsString,
                         cdsDados.FieldByName('CODCLI').AsString,
                         cdsDados.FieldByName('PARDUP').AsString) Then
    Begin
      Exit;
    End;

    pMarcaDuplicata(True);
  End
  Else
  Begin
    pMarcaDuplicata(False);
  End;
end;

procedure TfrmCtrReprogVen.pStep(pgbStatus: TcxProgressBar);
begin
  if Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

procedure TfrmCtrReprogVen.pConcluiBusca;
begin
  If (Not fEmptyStr(frmCtrReprogVenBusca.strValorFiltro)) Then
  Begin
    cdsDados.Filter := '';
    strValorFiltro := frmCtrReprogVenBusca.strValorFiltro;
    strCampoFiltro := frmCtrReprogVenBusca.strCampoFiltro;

    If Not cdsDados.FindFirst Then
      fMensagem('ATENÇÃO!', 'Não foram encontrados registros!', ['&O k']);
  End;

end;

procedure TfrmCtrReprogVen.pFilterRecord(DataSet: TDataSet; var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
  Begin
    If Pos('VALDUP', strCampoFiltro) > 0 Then
         Accept := FloatToStrF(fStrToFloat(strValorFiltro),ffFixed,15,2) = FloatToStrF(DataSet.FieldByName(strCampoFiltro).AsFloat,ffFixed,15,2)
    Else
      Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
  End;

end;

procedure TfrmCtrReprogVen.pLocalizaProximaDup;
begin
  If Not cdsDados.FindNext Then
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&O k']);
end;

end.
