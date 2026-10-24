unit untCancelaLocEqu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxGrid, EditFocus, Datasnap.DBClient, UniClientDataSet,
  cadastro.Model.ContratoLocacaoEquipamentos, DBAccess, Uni,
  cadastro.Controller.ContratoLocacaoEquipamentos, cxButtonEdit, Faturamento.Classes.CancelamentoLocEqu,
  System.ImageList, Vcl.ImgList, untTLock, untFuncoesLocEqu, untTypesLocEqu, untTypesSistema;

type
  TcxPainterAccess = class(TcxGridTableDataCellPainter);
  TcxViewInfoAcess = class(TcxGridTableDataCellViewInfo);

  TfrmCancelaLocEqu = class(TfrmPai)
    pnlCabecalho: TPanel;
    lblNumCon: TLabel;
    edtNumCon: TEditFocus;
    pnlDadosContrato: TPanel;
    lblCodCli: TLabel;
    lblCodVen: TLabel;
    lblEntCli: TLabel;
    edtLocalizacao: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodCli: TEditFocus;
    edtCodVen: TEditFocus;
    pnlTituloDocumentosEmitidos: TPanel;
    pnlDocumentosEmitidos: TPanel;
    cxGridDocumentosEmitidos: TcxGridCitel;
    cxGridDocumentosEmitidosView: TcxGridDBTableViewCitel;
    cxGridDocumentosEmitidosLeve1: TcxGridLevel;
    pnlDuracaoContrato: TPanel;
    lblInicio: TLabel;
    edtDtaIni: TDBEditFocus;
    edtHorIni: TDBEditFocus;
    lblTermino: TLabel;
    edtDtaFin: TDBEditFocus;
    edtHorFin: TDBEditFocus;
    Label1: TLabel;
    cdsEqlFat: TUniClientDataSet;
    dtsEqlFat: TUniDataSource;
    cdsEqlFatEQF_SEQCON: TStringField;
    cdsEqlFatEQF_NUMDOC: TStringField;
    cdsEqlFatEQF_ESPDOC: TStringField;
    cdsEqlFatEQF_SERDOC: TStringField;
    cdsEqlFatEQF_VALFAT: TFloatField;
    cxGridDocumentosEmitidosViewEQF_NUMDOC: TcxGridDBColumn;
    cxGridDocumentosEmitidosViewEQF_ESPDOC: TcxGridDBColumn;
    cxGridDocumentosEmitidosViewEQF_EMPDOC: TcxGridDBColumn;
    cxGridDocumentosEmitidosViewEQF_DTAFAT: TcxGridDBColumn;
    cxGridDocumentosEmitidosViewEQF_VALFAT: TcxGridDBColumn;
    cxGridDocumentosEmitidosViewEQF_HRAFAT: TcxGridDBColumn;
    cdsEqlFatEQF_EMPDOC: TStringField;
    cdsEqlFatEQF_DTAFAT: TDateTimeField;
    cxGridDocumentosEmitidosViewBTNCANCELAR: TcxGridDBColumn;
    cxGridDocumentosEmitidosViewEQF_STATUS: TcxGridDBColumn;
    cdsEqlFatEQF_STATUS: TStringField;
    cdsEqlFatEQF_HRAFAT: TDateTimeField;
    imgButton: TImageList;
    cdsEqlFatEQF_STRSTA: TStringField;
    cxGridDocumentosEmitidosViewEQF_STRSTA: TcxGridDBColumn;
    lblNumPed: TLabel;
    edtNumPed: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtNumConKeyPress(Sender: TObject; var Key: Char);
    procedure cxGridDocumentosEmitidosViewColumn1PropertiesButtonClick(
      Sender: TObject; AButtonIndex: Integer);
    procedure cxGridDocumentosEmitidosViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    ObjContratoFiltro: TContratoLocacaoEquipamentos;
    ObjCancela: TCancelarContratoLocacao;
    FintLocDec: Integer;
    FstrLocDec: String;
    FobjLock: TLock;

    function fCarregarContrato(const strAutInc, strNroCon: String; strNumPed: String = '';
      blnExibirMsg: Boolean = True): Boolean;
    function fCarregarFaturamentos: Boolean;

    procedure pLimparCampos;
    procedure pFormatarCampos;
    procedure pCancelarNS;
    procedure pCancelarRL;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untCancelamentoDocumentos;

{$R *.dfm}

{ TfrmCancelaLocEqu }

procedure TfrmCancelaLocEqu.cxGridDocumentosEmitidosViewColumn1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
Begin

  If Not fVerificaAcessoSistema('frmCancelamentoDocumentos') Then
  Begin
    fMensagem('ATENÇÃO', 'Operador não possui acesso liberado para a tela de Cancelamento de Documentos!', ['&Ok']);
    Exit;
  End;

  If cdsEqlFat.FieldByName('EQF_STRSTA').AsString = 'C' Then
  Begin
    fMensagem('ATENÇÃO', 'O documento já está cancelado.', ['&Ok']);
    Exit;
  End;

  If cdsEqlFat.FieldByName('EQF_ESPDOC').AsString = 'NS'  Then
    pCancelarNS;

  If cdsEqlFat.FieldByName('EQF_ESPDOC').AsString = 'RL'  Then
    pCancelarRL;
End;

procedure TfrmCancelaLocEqu.cxGridDocumentosEmitidosViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
const
  corStatusCancelado: TColor = clYellow;
  corStatusAtivo: TColor = clGreen;
var
  cRect,
  Rect: TRect;
  intAux: Integer;
  corFundo: TColor;
begin
  inherited;

  If (TcxGridDBColumn(AViewInfo.Item).DataBinding.FieldName <> 'EQF_STATUS') Then
    Exit;

  corFundo := clWindow;
  Rect := AViewInfo.Bounds;
  cRect := AViewInfo.Bounds;
  intAux := 20;

  cRect.Left := Rect.Left + 5 ;
  cRect.Right :=   Rect.Left + intAux;
  cRect.Top := Rect.Top + 5;
  cRect.Bottom := Rect.Top + intAux;

  ACanvas.Font.Color  := clBlack;
  If (VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,  cxGridDocumentosEmitidosViewEQF_STRSTA.Index]) = 'C') then
  Begin
    ACanvas.Brush.Color := corStatusCancelado;
    ACanvas.Pen.Color := corStatusCancelado;
  End
  Else
  Begin
    ACanvas.Brush.Color := corStatusAtivo;
    ACanvas.Pen.Color := corStatusAtivo;
  End;

  ACanvas.Ellipse(cRect);
  ACanvas.Brush.Color := corFundo;
  ACanvas.TextOut(cRect.Left + 20, Rect.Top + 5 , AViewInfo.Text);

  ADone := True;
end;

procedure TfrmCancelaLocEqu.edtNumConKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, Nil, Nil, Key, arrSel) Then
  Begin
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCancelaLocEqu.edtNumPedKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;

  If fPesqContratoLocEquip(Self, edtNumCon, nil, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtNumPed, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmCancelaLocEqu.fCarregarContrato(const strAutInc, strNroCon: String; strNumPed: String = '';
  blnExibirMsg: Boolean = True): Boolean;
begin
  pLimparCampos;

  ObjContratoFiltro.pLimpar;
  ObjContratoFiltro.fCarregarContrato(strAutInc, strNroCon, True, strNumPed);

  If fEmptyStr(ObjContratoFiltro.NroContrato) Then
  Begin
    If blnExibirMsg Then
      fMensagem('ATENÇÃO', 'Contrato não encontrado!', ['&Ok']);
    Result := False;
    Exit;
  End;

  If ObjContratoFiltro.Status = 'O' Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato não está ativo! Favor realizar a ativação do contrato antes da inspeção.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If ObjContratoFiltro.Status = 'E' Then
  Begin
    fMensagem('ATENÇÃO', 'Contrato Encerrado.', ['&Ok']);
    Result := False;
    Exit;
  End;

  If (Not fValidaTravasContrato(ObjContratoFiltro.AutInc)) Then
  Begin
    Exit(False);
  End;

  edtCodCli.Text := ObjContratoFiltro.CodCliente;
  edtNomCli.Text := ObjContratoFiltro.NomCliente;
  edtCodVen.Text := ObjContratoFiltro.Vendedor.Codigo;
  edtNomVen.Text := ObjContratoFiltro.Vendedor.Nome;
  edtLocalizacao.Text := ObjContratoFiltro.Localizacao;
  If ObjContratoFiltro.TipoDuracaoContrato = 'M' Then
  Begin
    edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', ObjContratoFiltro.DataMesIni);
    edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', ObjContratoFiltro.DataMesFin);
  End
  Else
  Begin
    edtDtaIni.Text := FormatDateTime('dd/mm/yyyy', ObjContratoFiltro.DataInicial);
    edtDtaFin.Text := FormatDateTime('dd/mm/yyyy', ObjContratoFiltro.DataFinal);
  End;

  edtHorIni.Text := FormatDateTime('hh:mm', ObjContratoFiltro.HoraInicial);
  edtHorFin.Text := FormatDateTime('hh:mm', ObjContratoFiltro.HoraFinal);
  edtNumPed.Text := Copy(ObjContratoFiltro.NumDocPedAdiantamento, 0, 12);
  edtNumCon.Text := Copy(ObjContratoFiltro.NroContrato, 0, 12);

  If Not(fEmptyStr(ObjContratoFiltro.AutInc)) Then
    FobjLock.fLock_Unlock(cst_TRAVA_CANCEL_LOCEQU + ObjContratoFiltro.AutInc, True, False);

  Result := fCarregarFaturamentos;
end;

function TfrmCancelaLocEqu.fCarregarFaturamentos: Boolean;
var
  intCnt: integer;
begin
  If cdsEqlFat.Active Then
    cdsEqlFat.EmptyDataSet;

  If Not ObjCancela.fCarregarFaturasCancelar(ObjContratoFiltro) Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe faturamentos emitidos para o contrato informado!', ['&Ok']);
    Result := False;
    Exit;
  End;

  Application.ProcessMessages;
  cdsEqlFat.DisableControls;
  Try
    Try
      For intCnt := 0 to ObjCancela.ListaFaturas.Count -1 Do
      Begin
        cdsEqlFat.Insert;
        cdsEqlFat.FieldByName('EQF_STATUS').AsString := 'Documento ativo';
        cdsEqlFat.FieldByName('EQF_STRSTA').AsString := 'A';
        cdsEqlFat.FieldByName('EQF_SEQCON').AsString := ObjCancela.Contrato.AutInc;
        cdsEqlFat.FieldByName('EQF_ESPDOC').AsString := ObjCancela.ListaFaturas[intCnt].EspDoc;
        cdsEqlFat.FieldByName('EQF_NUMDOC').AsString := ObjCancela.ListaFaturas[intCnt].NumDoc;
        cdsEqlFat.FieldByName('EQF_EMPDOC').AsString := ObjCancela.ListaFaturas[intCnt].EmpDoc;
        cdsEqlFat.FieldByName('EQF_SERDOC').AsString := ObjCancela.ListaFaturas[intCnt].SerDoc;
        cdsEqlFat.FieldByName('EQF_DTAFAT').AsDateTime := ObjCancela.ListaFaturas[intCnt].DataFaturamento;
        cdsEqlFat.FieldByName('EQF_HRAFAT').AsDateTime := ObjCancela.ListaFaturas[intCnt].HoraFaturamento;
        cdsEqlFat.FieldByName('EQF_VALFAT').AsFloat  := ObjCancela.ListaFaturas[intCnt].ValorTotal;
        cdsEqlFat.Post;
      End;

      Result := ObjCancela.ListaFaturas.Count > 0;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[TfrmCancelaLocEqu.fCarregarFaturamentos]');
      End;
    End;
  Finally
    cdsEqlFat.EnableControls;
  End;
end;

procedure TfrmCancelaLocEqu.pCancelarNS;
var
  frmCancelamentoDocumentos: TfrmCancelamentoDocumentos;
begin
  inherited;

  If Not fVerificaAcessoSistema('CANCNS') Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para cancelar documentos da espécie NS.', ['&Ok']);
    Exit;
  End;

  ObjCancela.FaturaCanc.pCarredaDadosAdiantamento;

  pCriarFormularios(TfrmCancelamentoDocumentos, frmCancelamentoDocumentos);
  Try
    frmCancelamentoDocumentos.edtCliFor.Text := ObjCancela.Contrato.CodCliente;
    frmCancelamentoDocumentos.edtDesCri.Text := ObjCancela.Contrato.NomCliente;
    frmCancelamentoDocumentos.edtSerie.Text  := cdsEqlFat.FieldByName('EQF_SERDOC').AsString;
    frmCancelamentoDocumentos.pCancelarDocumentoLocacaoEquipamento('NS', ObjCancela.FaturaCanc.strNumDocAdt, ObjCancela.FaturaCanc.strEmpDocAdt, cdsEqlFat.FieldByName('EQF_NUMDOC').AsString);
    If frmCancelamentoDocumentos.FblnCancelamentoComSucesso Then
    Begin
      cdsEqlFat.Edit;
      cdsEqlFat.FieldByName('EQF_STATUS').AsString := 'Cancelamento efetuado com sucesso';
      cdsEqlFat.FieldByName('EQF_STRSTA').AsString := 'C';
      cdsEqlFat.Post;
    End;
  Finally
    pFreeAndNil(frmCancelamentoDocumentos);
  End;
end;

procedure TfrmCancelaLocEqu.pCancelarRL;
var
  frmCancelamentoDocumentos: TfrmCancelamentoDocumentos;
begin
  inherited;

  If Not fVerificaAcessoSistema('CANCRL') Then
  Begin
    fMensagem('ATENÇÃO', 'Usuário sem permissão para cancelar documentos da espécie RL.', ['&Ok']);
    Exit;
  End;

  ObjCancela.FaturaCanc.pCarredaDadosAdiantamento ;

  pCriarFormularios(TfrmCancelamentoDocumentos, frmCancelamentoDocumentos);
  Try
    frmCancelamentoDocumentos.edtCliFor.Text := ObjCancela.Contrato.CodCliente;
    frmCancelamentoDocumentos.edtDesCri.Text := ObjCancela.Contrato.NomCliente;
    frmCancelamentoDocumentos.pCancelarDocumentoLocacaoEquipamento('RL', ObjCancela.FaturaCanc.strNumDocAdt, ObjCancela.FaturaCanc.strEmpDocAdt, cdsEqlFat.FieldByName('EQF_NUMDOC').AsString);
    If frmCancelamentoDocumentos.FblnCancelamentoComSucesso Then
    Begin
      cdsEqlFat.Edit;
      cdsEqlFat.FieldByName('EQF_STATUS').AsString := 'Cancelamento efetuado com sucesso';
      cdsEqlFat.FieldByName('EQF_STRSTA').AsString := 'C';
      cdsEqlFat.Post;
    End;
  Finally
    pFreeAndNil(frmCancelamentoDocumentos);
  End;
end;

procedure TfrmCancelaLocEqu.pFormatarCampos;
begin
  TTimeField(cdsEqlFat.FieldByName('EQF_DTAFAT')).DisplayFormat := 'dd/mm/yyyy';
  TTimeField(cdsEqlFat.FieldByName('EQF_HRAFAT')).DisplayFormat := 'hh:mm';
  TFloatField(cdsEqlFat.FieldByName('EQF_VALFAT')).DisplayFormat := FstrLocDec;
end;

procedure TfrmCancelaLocEqu.FormCreate(Sender: TObject);
begin
  inherited;

  ObjContratoFiltro := TContratoLocacaoEquipamentos.Create;
  ObjCancela := TCancelarContratoLocacao.Create;

  cdsEqlFat.CreateDataSet;

  If fCfgSis('PDRCTR', VarBoolean) Then
  Begin
    edtNumPed.Visible := True;
  End
  Else
  Begin
    edtNumPed.Visible := False;
    lblNumPed.Visible := False;
    edtNumCon.Left := edtNomCli.Left;
    lblNumCon.Left := lblCodCli.Left;
  End;

  FintLocDec := fCfgSis('LOCDEC', VarInteger);
  FstrLocDec := '#,##0.' + fStrZero('0', FintLocDec);
  FobjLock := TLock.Create;

  pFormatarCampos;

  Self.WindowState := wsMaximized;
end;

procedure TfrmCancelaLocEqu.FormDestroy(Sender: TObject);
begin
  inherited;

  FobjLock.fLock_Unlock(cst_TRAVA_CANCEL_LOCEQU + ObjContratoFiltro.AutInc, False, False);
  FreeAndNil(FobjLock);
  If Assigned(ObjContratoFiltro) Then
    FreeAndNil(ObjContratoFiltro);
  If Assigned(ObjCancela) Then
    FreeAndNil(ObjCancela);
end;

procedure TfrmCancelaLocEqu.FormShow(Sender: TObject);
begin
  inherited;

  If fCfgSis('PDRCTR', VarBoolean) Then
    pSetFocus(edtNumPed)
  Else
    pSetFocus(edtNumCon);
end;

function TfrmCancelaLocEqu.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then Begin
    If (Sender = edtNumCon) Then
    Begin
      If fEmptyStr(edtNumCon.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'Informe o número do contrato.', ['&Ok']);
        Result := False;
      End
      Else
        Result := fCarregarContrato('', edtNumCon.Text);
    End

    Else If (Sender = edtNumPed)  Then
    Begin
      If Not fEmptyStr(edtNumPed.Text) Then
      Begin
        fCarregarContrato('', '', edtNumPed.Text, False);
        If (fEmptyStr(edtNumCon.Text)) And (Not fEmptyStr(edtNumPed.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Pedido informado não é da rotina de Locação de Equipamentos.', ['&O k']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCancelaLocEqu.pLimparCampos;
begin
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodVen.Clear;
  edtNomVen.Clear;
  edtDtaIni.Clear;
  edtHorIni.Clear;
  edtDtaFin.Clear;
  edtHorFin.Clear;
  edtLocalizacao.Clear;
end;

end.
