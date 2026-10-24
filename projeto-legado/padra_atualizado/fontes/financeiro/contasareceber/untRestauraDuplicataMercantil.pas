unit untRestauraDuplicataMercantil;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, untTypesSistema,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, untTRestauraDuplicataMercantil,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxContainer, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxGridLevel, cxGridCustomTableView, cxGridTableView,untTCadRec,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, MemoFocus, EditFocus,
  MemDS, DBAccess, Uni;

type
  TfrmRestauraDuplicataMercantil = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    Label5: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    edtCodClienteResumo: TEditFocus;
    edtNomClienteResumo: TEditFocus;
    edtNomPortadorResumo: TEditFocus;
    edtCodPortadorResumo: TEditFocus;
    edtNosNumResumo: TEditFocus;
    gpbDadEnv: TGroupBox;
    Label8: TLabel;
    Label11: TLabel;
    edtDtaImpressao: TEditFocus;
    edtBcoImpressao: TEditFocus;
    edtHistoricoResumo: TMemoFocus;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label9: TLabel;
    edtTotalDup: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasDBTableView1: TcxGridDBTableView;
    colNumDup: TcxGridDBColumn;
    colEspDoc: TcxGridDBColumn;
    colCodEmp: TcxGridDBColumn;
    colDtaVen: TcxGridDBColumn;
    colValDup: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    pnlBotoesBaixa: TPanel;
    FlwpnlBotoesBaixa: TFlowPanel;
    BtnMarcarTodas2: TBitBtnLocked;
    btnDesmarca: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairRestaura: TBitBtnLocked;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    edtCodEmp: TEditFocus;
    edtDesEmpresa: TEditFocus;
    Label4: TLabel;
    rgrTipoData: TRadioGroup;
    dtsCtaRec: TDataSource;
    edtEspDoc: TEditFocus;
    colParcel: TcxGridDBColumn;
    procedure btnSairRestauraClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure BtnMarcarTodas2Click(Sender: TObject);
    procedure btnDesmarcaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mskDtaIniPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edtCodCliExit(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasDBTableView1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtEspDocKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    objRestauraDuplicata: TRestauraDuplicataMercantil;

    arrClientes,
    arrEmpresas: TConsultasArray;
    qryEmpresa : TUniQuery;

    procedure AtualizaDados(DataSet: TDataSet);
    procedure LimpaDados;
    procedure SelecionaDuplicata;
    procedure CarregaEmpresa;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  end;


implementation

uses untFuncoes, untFuncoesSimples, untPesqAux, untConsultas,
  untFuncoesConsulta, untConstantes, untGravando, untTCadRecRepository;

{$R *.dfm}

procedure TfrmRestauraDuplicataMercantil.AtualizaDados(DataSet: TDataSet);
begin
  With objRestauraDuplicata Do
  Begin

    If qryRec.RecordCount > 0 Then
    Begin
      edtCodClienteResumo.Text := qryRec.Current<TCadRec>.objCodCli.strCodCli;
      edtNomClienteResumo.Text := qryRec.Current<TCadRec>.objCodCli.strNomCli;

      edtCodPortadorResumo.Text := fValN(qryRec.Current<TCadRec>.CTR_CODPOR);
      edtNomPortadorResumo.Text := fRetNomPortador(fValN(qryRec.Current<TCadRec>.CTR_CODPOR));

      edtNosNumResumo.Text    := fValN(qryRec.Current<TCadRec>.CTR_NOSNUM);
      edtHistoricoResumo.Text    := fValN(qryRec.Current<TCadRec>.CTR_HIST01);

      If qryRec.Current<TCadRec>.CTR_DTABOL.HasValue Then
        edtDtaImpressao.Text := FormatDateTime('dd/mm/yyyy', qryRec.Current<TCadRec>.CTR_DTABOL)
      Else edtDtaImpressao.Text := '';

      If qryRec.Current<TCadRec>.CTR_BCOBOL.HasValue Then
        edtBcoImpressao.Text := qryRec.Current<TCadRec>.CTR_BCOBOL + ' - ' + fRetNomeBco(qryRec.Current<TCadRec>.CTR_BCOBOL)
      Else edtBcoImpressao.Text := '';

      If pnlTotais.Visible Then
      Begin
        edtTotalDup.Text         := FloatToStrF(ATotalDuplicata, ffNumber,12,2);
        edtTotalSelecionado.Text := FloatToStrF(ATotalMarcado, ffNumber,12,2);
      End;
    End
    Else
    Begin
      edtCodClienteResumo.Clear;
      edtNomClienteResumo.Clear;
      edtCodPortadorResumo.Clear;
      edtNomPortadorResumo.Clear;
      edtNosNumResumo.Clear;
      edtHistoricoResumo.Clear;
      edtDtaImpressao.Clear;
      edtBcoImpressao.Clear;

      edtTotalDup.Text         := FloatToStrF(0, ffNumber,12,2);
      edtTotalSelecionado.Text := FloatToStrF(0, ffNumber,12,2);
    End;

  End;
end;

procedure TfrmRestauraDuplicataMercantil.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  Try
    If (Not Assigned(objRestauraDuplicata.CadRec)) Or (objRestauraDuplicata.CadRec.Count <= 0) Then
    Begin
      pMensagemOk('Não há duplicatas a serem restauradas!');
      pSetFocus(edtCodCli);
      LimpaDados;
      Exit;
    End;

    {**********************************}
    {* NÃO HÁ DUPLICATAS SELECIONADAS *}
    {**********************************}
    If objRestauraDuplicata.CtrMar.Count <= 0 Then
    Begin
      pMensagemOk('Não há duplicatas selecionadas! Selecionar ao menos um registro para efetuar a restauração!');
      pSetFocus(dbgDuplicatas);
      Exit;
    End;

    {***************}
    {* CONFIRMAÇÃO *}
    {***************}
    If (fMensagem('', 'Confirma a restauração da(s) duplicata(s)?', ['', '']) = 1) Then
    Begin
     If TfrmGravando.fExecutarModal(objRestauraDuplicata.RestauraDuplicatas,'Aguarde... Restaurando Duplicatas','') Then
     Begin
       LimpaDados;
     End;
    End
    Else
      pSetFocus(dbgDuplicatas);

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
end;

procedure TfrmRestauraDuplicataMercantil.btnConsultarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then TfrmGravando.fExecutarModal(objRestauraDuplicata.CarregaDados, 'Aguarde... Carregando Títulos.', '');
    AtualizaDados(dtsCtaRec.DataSet);

  If objRestauraDuplicata.CadRec.Count <= 0 Then
  Begin
    pMensagemOK('Não há dados para serem restaurados!');
    pSetFocus(edtCodCli);
  End
  Else
    pSetFocus(dbgDuplicatas);
end;

procedure TfrmRestauraDuplicataMercantil.btnDesmarcaClick(Sender: TObject);
begin
  If (Not objRestauraDuplicata.qryRec.Active) Or (objRestauraDuplicata.qryRec.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;

  if (StrToCurrDef(StringReplace(Trim(edtTotalSelecionado.Text),'.','',[rfReplaceAll,rfIgnoreCase]), 0) <= 0) then
  begin
    pMensagemOk('Não existe duplicata marcada para ser desmarcada!');
    Exit;
  end;

  Try
    TfrmGravando.fExecutarModal(objRestauraDuplicata.DesmarcarTodos, 'Aguarde... Desmarcando duplicatas.', '');
    AtualizaDados(dtsCtaRec.DataSet);
  Except
    On E: ExceptionAutCom Do pMensagemOk(E.Message);
    On E: Exception Do pMensagensErro(E.Message, '');
  End;

  dbgDuplicatasDBTableView1.DataController.Refresh;
end;

procedure TfrmRestauraDuplicataMercantil.BtnMarcarTodas2Click(Sender: TObject);
begin
  If (Not objRestauraDuplicata.qryRec.Active) Or (objRestauraDuplicata.qryRec.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;

  Try
    TfrmGravando.fExecutarModal(objRestauraDuplicata.MarcarTodos, 'Aguarde... Marcando duplicatas.', '');
    AtualizaDados(dtsCtaRec.DataSet);
  Except
    On E: ExceptionAutCom Do pMensagemOk(E.Message);
    On E: Exception Do pMensagensErro(E.Message, '');
  End;

  dbgDuplicatasDBTableView1.DataController.Refresh;
end;

procedure TfrmRestauraDuplicataMercantil.btnSairRestauraClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRestauraDuplicataMercantil.CarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryEmpresa, qryEmpresa, edtCodEmp.Text);
  End
  Else
    edtDesEmpresa.Clear;
end;

procedure TfrmRestauraDuplicataMercantil.dbgDuplicatasDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  SelecionaDuplicata;
end;

procedure TfrmRestauraDuplicataMercantil.dbgDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not Assigned(objRestauraDuplicata) Then Exit;

  If (Not Assigned(objRestauraDuplicata.CtrMar)) Or (objRestauraDuplicata.CtrMar.Count <= 0) Then
    Exit;

  If objRestauraDuplicata.CtrMar.Contains(objRestauraDuplicata.CadRec[AViewInfo.GridRecord.RecordIndex]) Then
  Begin
    If (AViewInfo.Selected) Then ACanvas.Font.Color := clLime
    Else ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmRestauraDuplicataMercantil.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmRestauraDuplicataMercantil.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRestauraDuplicataMercantil.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmpresa, arrEmpresas, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmRestauraDuplicataMercantil.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmpresa, Nil, Key, arrEmpresas, True, True) Then
  Begin
    fValidaCampos(edtCodEmp,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRestauraDuplicataMercantil.edtEspDocKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If(CharInSet(Key,['0'..'9'])) Then
    key := #0;
end;

procedure TfrmRestauraDuplicataMercantil.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LimpaDados;
  inherited;
end;

procedure TfrmRestauraDuplicataMercantil.FormCreate(Sender: TObject);
begin
  inherited;
  objRestauraDuplicata := TRestauraDuplicataMercantil.Create(Self);
  dtsCtaRec.DataSet    := objRestauraDuplicata.qryRec;
  objRestauraDuplicata.qryRec.AfterScroll := AtualizaDados;

  mskDtaIni.Date := VS_Date;
  mskDtaFin.Date := VS_Date;
end;

procedure TfrmRestauraDuplicataMercantil.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Return: If ActiveControl.ClassName = 'TcxGridSite' Then
                 SelecionaDuplicata;
    VK_Escape: Begin
                 LimpaDados;
               End;
    VK_F7    : BtnMarcarTodas2.Click;
    VK_F8    : btnDesmarca.Click;
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;
  End;
end;

procedure TfrmRestauraDuplicataMercantil.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
  edtCodEmp.Text     := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
  qryEmpresa         := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
end;

procedure TfrmRestauraDuplicataMercantil.LimpaDados;
begin
  edtCodClienteResumo.Clear;
  edtNomClienteResumo.Clear;
  edtCodPortadorResumo.Clear;
  edtNomPortadorResumo.Clear;
  edtNosNumResumo.Clear;
  edtHistoricoResumo.Clear;

  edtTotalDup.Clear;
  edtTotalSelecionado.Clear;

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtEspDoc.Clear;

  objRestauraDuplicata.LimparDados;
  pSetFocus(edtCodCli);

  edtDtaImpressao.Clear;
  edtBcoImpressao.Clear;
end;

function TfrmRestauraDuplicataMercantil.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Try
    Result := True;
    {* CLIENTE *}
    If Sender = edtCodCli Then
    Begin
      objRestauraDuplicata.ACodigoCliente := edtCodCli.Text;
      pDesmarcaLista(edtCodCli, arrClientes);
    End

    {* BANCO *}
    Else If Sender = edtEspDoc Then
    Begin
      objRestauraDuplicata.AEspecie := edtEspDoc.Text;
//      pDesmarcaLista(edtEspDoc, arrBancos);
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If Not fEmptyStr(edtCodEmp.Text) Then
      Begin
         objRestauraDuplicata.AEmpresaAcesso := '';
         objRestauraDuplicata.ACodigoEmpresa := edtCodEmp.Text;
         pDesmarcaLista(edtCodEmp, arrEmpresas);

        If edtCodEmp.Text <> '000' Then
           CarregaEmpresa;

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtDesEmpresa.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        objRestauraDuplicata.ACodigoEmpresa := '';
        objRestauraDuplicata.AEmpresaAcesso := strEmpAcessoUsuarioLogado;
      End;

    End

    {* DATA INICIAL *}
    Else If Sender = mskDtaIni Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If blnBuscaPorChave Then
          mskDtaFin.Clear;

        mskDtaFin.Enabled := False;
        objRestauraDuplicata.ADataInicio := 0;
      End
      Else
      Begin
        mskDtaFin.Enabled := True;
        objRestauraDuplicata.ADataInicio := mskDtaIni.Date;
      End;
    End

    {* DATA FINAL *}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          pMensagemOk('A Data Final deve ser preenchida!');
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          pMensagemOk('A Data Final deve ser maior ou igual a Data Inicial!');
          Result := False;
        End
        Else objRestauraDuplicata.ADataFinal := mskDtaFin.Date;
      End;
    End;

    If rgrTipoData.ItemIndex = 0 Then
    begin
      objRestauraDuplicata.ADataEscolhida := tdImpressao;
    end
    else
    If rgrTipoData.ItemIndex = 1 Then
    begin
      objRestauraDuplicata.ADataEscolhida := tdCadastro;
    end
    Else
      objRestauraDuplicata.ADataEscolhida := tdVencimento;

  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmRestauraDuplicataMercantil.mskDtaIniPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If Error Then
    pMensagemOk('Data Inválida');
end;

procedure TfrmRestauraDuplicataMercantil.SelecionaDuplicata;
begin
  If (Not objRestauraDuplicata.qryRec.Active) Or (objRestauraDuplicata.qryRec.IsEmpty) Then
    Exit;

  Try
    If objRestauraDuplicata.CtrMar.Contains(objRestauraDuplicata.qryRec.Current<TCadRec>) Then
      objRestauraDuplicata.DeleteSelecion
    Else objRestauraDuplicata.InsertSelecion;

    AtualizaDados(dtsCtaRec.DataSet);
  Except
    On E: ExceptionAutCom Do pMensagemOk(E.Message);
    On E: Exception Do pMensagensErro(E.Message, '');
  End;

  dbgDuplicatasDBTableView1.DataController.Refresh;
end;

end.
