unit untEstornoNotaFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  EditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient, Uni,
  UniClientDataSet, untConfDocs;

type
  TfrmEstornoNotaFiscal = class(TfrmPai)
    pnlConsulta: TPanel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    Label4: TLabel;
    Label14: TLabel;
    edtNumDoc: TEditFocus;
    edtSerie: TEditFocus;
    edtChaveAcesso: TEditFocus;
    Label15: TLabel;
    btnCarregar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    Label1: TLabel;
    btnConfirmar: TBitBtnLocked;
    cxGridItens: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    dtsItens: TDataSource;
    cdsItens: TUniClientDataSet;
    cdsItensCODITE: TStringField;
    cdsItensDESITE: TStringField;
    cdsItensQTDITE: TFloatField;
    cdsItensVALITE: TFloatField;
    cdsItensREFERE: TStringField;
    cdsItensTOTITE: TFloatField;
    cdsItensDESESP: TFloatField;
    cxGridItensCODITE: TcxGridDBColumn;
    cxGridItensREFERE: TcxGridDBColumn;
    cxGridItensDESITE: TcxGridDBColumn;
    cxGridItensQTDITE: TcxGridDBColumn;
    cxGridItensUNITAR: TcxGridDBColumn;
    cxGridItensTOTITE: TcxGridDBColumn;
    cxGridItensDESESP: TcxGridDBColumn;
    cdsItensCODUNI: TStringField;
    cdsItensVLRCON: TFloatField;
    cxGridItensVLRCON: TcxGridDBColumn;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtNumDocKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumDocExit(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtsItensDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    objConfDoc: TConfirmacaoDocumentos;
    qryCadCli: TUniQuery;
    FNumDoc : String;
    FEspDoc : String;
    FCodEmp : String;
    FSerie_ : String;
    FCodCli : String;
    FChvAce : String;
    FEntFut : Boolean;
    procedure pCarregaDocumento;
    function fConfirmaEstorno(const strChvAce, strAutInc: String) : Boolean;
    procedure pLimpaDados;
    function fRetornaChaveAcesso(const strNumDoc, strEspDoc, strCodemp, strCodCli, strSerie_: String): String;
    function fDigOcorrencia : Boolean;
    function fPermiteEstornarNotaFiscal(const strClaFis : String): Boolean;
    function fBaixarEstorno : Boolean;
    function fBaixarEntregaFutura : Boolean;
    function fCarregouItensDocumentoOriginal(var qryItens : TUniQuery; const strTabela : String) : Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untPesqAux, untDigOcorrencia, untTypesSistema,
  System.StrUtils;

{$R *.dfm}

function TfrmEstornoNotaFiscal.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodCli) Then
    Begin
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!' , ['&Ok']);
        edtNomCli.Clear;
        Result := False;
      End
      Else
      Begin
        pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCli.Text);
        edtNomCli.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString;

        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do cliente inválido!' , ['&Ok']);
          Result := False;
        End
      End;
    End;

    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O documento deve ser preenchido!' , ['&Ok']);
        Result := False;
      End;
    End;

    If (Sender = edtSerie) Then
    Begin
      If fEmptyStr(edtSerie.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A série deve ser preenchida!' , ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

procedure TfrmEstornoNotaFiscal.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext((ActiveControl), True, True);
  End;
end;

procedure TfrmEstornoNotaFiscal.edtNumDocKeyPress(Sender: TObject;
  var Key: Char);
var
  qryGen : TUniQuery;
  arrSel : TConsultasArray;
begin
  inherited;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!' , ['&Ok']);
    Key := #0;
    Exit;
  End;

  qryGen := fCriaQuery(Self);

  Try
    If fPesqLivroFiscal(Self, qryGen, Key, arrSel, True, conNotaEstorno, 'C', edtCodCli.Text, '', '', True, 0, 0, True, VS_strCodEmp) Then
    Begin
      edtNumDoc.Text      := qryGen.FieldByName('FIS_NUMDOC').AsString;
      edtSerie.Text       := qryGen.FieldByName('FIS_SERIE_').AsString;
      edtChaveAcesso.Text := qryGen.FieldByName('FIS_ACESSO').AsString;

      SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmEstornoNotaFiscal.fRetornaChaveAcesso(const strNumDoc, strEspDoc, strCodemp, strCodCli, strSerie_: String): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Self);
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT FIS_ACESSO, FIS_ESTNFE, FIS_CLFSC1 ');
    qryAux.SQL.Add('  FROM CADFIS ');
    qryAux.SQL.Add('INNER JOIN LOGNFE ON NFE_NUMDOC = FIS_NUMDOC ');
    qryAux.SQL.Add('                 AND NFE_ESPDOC = FIS_ESPDOC ');
    qryAux.SQL.Add('                 AND NFE_CODEMP = FIS_CODEMP ');
    qryAux.SQL.Add('                 AND NFE_CODCLI = FIS_FORCLI ');
    qryAux.SQL.Add('                 AND IFNULL(NFE_SERIE_, "") = IFNULL(FIS_SERIE_, "") ');
    qryAux.SQL.Add('WHERE FIS_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND FIS_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND FIS_CODEMP = :CODEMP ');
    qryAux.SQL.Add('  AND FIS_FORCLI = :CODCLI ');
    qryAux.SQL.Add('  AND FIS_SERIE_ = :SERIE_ ');
    qryAux.SQL.Add('  AND IFNULL(FIS_ACESSO, "") <> ""   ');
    qryAux.SQL.Add('  AND IFNULL(NFE_STATUS, "") =  "AT" ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie_;

    qryAux.Open;

    If qryAux.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe um documento válido!', ['&Ok']);
      Exit;
    End;

    If (Not fPermiteEstornarNotaFiscal(qryAux.FieldByName('FIS_CLFSC1').AsString)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe um documento válido!', ['&Ok']);
      Exit;
    End;

    If (qryAux.FieldByName('FIS_ESTNFE').AsString = 'S') Then
    Begin
      fMensagem('ATENÇÃO!', 'Essa nota fiscal já foi estornada!', ['&Ok']);
      Exit;
    End;

    Result := qryAux.FieldByName('FIS_ACESSO').AsString;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmEstornoNotaFiscal.edtNumDocExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodCli.Text) Then
    Exit;

  If fEmptyStr(edtNumDoc.Text) Then
    Exit;

  If fEmptyStr(edtSerie.Text) Then
    Exit;

  edtChaveAcesso.Text := fRetornaChaveAcesso(edtNumDoc.Text, 'NF', VS_strCodEmp, edtCodCli.Text, edtSerie.Text);
end;

procedure TfrmEstornoNotaFiscal.btnCancelarClick(Sender: TObject);
begin
  inherited;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtNumDoc.Clear;
  edtSerie.Clear;
  edtChaveAcesso.Clear;
  pLimpaDados;
end;

procedure TfrmEstornoNotaFiscal.btnCarregarClick(Sender: TObject);
begin
  inherited;

  If (Not fVerificaCampos) Then
    Exit;

  If fEmptyStr(edtChaveAcesso.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe um documento válido!', ['&Ok']);
    Exit;
  End;

  pCarregaDocumento;
end;

procedure TfrmEstornoNotaFiscal.pCarregaDocumento;
var
  strMsg   : String;
  intContador: Integer;
begin
  pLimpaDados;

  If fEmptyStr(edtCodCli.Text) Then
    Exit;

  If fEmptyStr(edtNumDoc.Text) Then
    Exit;

  If fEmptyStr(edtSerie.Text) Then
    Exit;

  If fEmptyStr(edtChaveAcesso.Text) Then
    Exit;

  FNumDoc := edtNumDoc.Text;
  FEspDoc := 'NF';
  FCodEmp := VS_strCodEmp;
  FSerie_ := edtSerie.Text;
  FCodCli := edtCodCli.Text;
  FChvAce := edtChaveAcesso.Text;
  FEntFut := (RightStr(fCampoTabela('FIS_CLFSC1', 'CADFIS', ['FIS_ACESSO'], [FChvAce], True), 3) = '922');

  objConfDoc := TConfirmacaoDocumentos.Create(Nil);

  objConfDoc.objFatVenda.strOpcDoc     := 'VN';
  objConfDoc.objFatVenda.strOpcDocTrue := 'VN';
  objConfDoc.objFatVenda.blnEstornoNotaFiscal := True;
  objConfDoc.objFatVenda.blnEstornoNotaFiscalEntregaFutura := FEntFut;
  objConfDoc.objFatVenda.fBaixarEstorno := fBaixarEstorno;

  objConfDoc.strNumDoc := FNumDoc;
  objConfDoc.strEmpDoc := FCodEmp;
  objConfDoc.strCodCli := FCodCli;
  objConfDoc.blnFiltrarEmp := True;
  objConfDoc.blnEstornoNotaFiscal := True;
  objConfDoc.blnEstornoNotaFiscalEntregaFutura := FEntFut;
  objConfDoc.pSetaClienteDocs(FCodCli);

  objConfDoc.pCriaTemporariaConfirmacao;

  If objConfDoc.blnSemDocumentosParaConfirmar Then
  Begin
    fMensagem('ATENÇÃO!', 'Verifique o documento selecionado!', ['&Ok']);
    pLimpaDados;
    Exit;
  End;

  objConfDoc.objFatVenda.pCarregaDadosClienteBaixa(FCodCli);

  If not objConfDoc.fMarcaDocumento(True, strMsg) Then
  Begin
    pLimpaDados;
    Exit;
  End;

  If not objConfDoc.fCarregaItensConfirmacaoDocumentos Then
  Begin
    fMensagem('ATENÇÃO!', 'Verifique o documento selecionado!', ['&Ok']);
    pLimpaDados;
    Exit;
  End;

  objConfDoc.objFatVenda.strCodOpe := strLoginUsuarioLogado;
  objConfDoc.objFatVenda.strCodVen := strLoginUsuarioLogado;
  objConfDoc.objFatVenda.strCodDig := strLoginUsuarioLogado;
  objConfDoc.objFatVenda.strNomVen := fRetNomVendRep(strLoginUsuarioLogado);
  objConfDoc.objFatVenda.strNomDig := fRetNomVendRep(strLoginUsuarioLogado);

  objConfDoc.objFatVenda.strEspDoc := 'NF';
  objConfDoc.objFatVenda.blnEst_Dv := True;
  objConfDoc.objFatVenda.strChaveNFeRefDevolucao := edtChaveAcesso.Text;

  Try
    cdsItens.DisableControls;
    for intContador := 0 to Length(objConfDoc.objFatVenda.arrMatItens) - 1 do
    begin
      cdsItens.Append;
      cdsItens.FieldByName('CODITE').AsString := objConfDoc.objFatVenda.arrMatItens[intContador].strCodIte;
      cdsItens.FieldByName('REFERE').AsString := objConfDoc.objFatVenda.arrMatItens[intContador].strRefere;
      cdsItens.FieldByName('DESITE').AsString := objConfDoc.objFatVenda.arrMatItens[intContador].strDesIte;
      cdsItens.FieldByName('UNIDAD').AsString := objConfDoc.objFatVenda.arrMatItens[intContador].strUnidad;
      cdsItens.FieldByName('QTDITE').AsFloat  := objConfDoc.objFatVenda.arrMatItens[intContador].fltQtdIte;
      cdsItens.FieldByName('UNITAR').AsFloat  := objConfDoc.objFatVenda.arrMatItens[intContador].fltUniTar;
      cdsItens.FieldByName('DESESP').AsFloat  := objConfDoc.objFatVenda.arrMatItens[intContador].fltDesEsp;
      cdsItens.FieldByName('TOTITE').AsFloat  := objConfDoc.objFatVenda.arrMatItens[intContador].fltTotIte;
      cdsItens.FieldByName('VLRCON').AsFloat  := objConfDoc.objFatVenda.arrMatItens[intContador].fltTotIte +
                                                 objConfDoc.objFatVenda.arrMatItens[intContador].fltValIpi +
                                                 objConfDoc.objFatVenda.arrMatItens[intContador].fltValRet +
                                                 objConfDoc.objFatVenda.arrMatItens[intContador].VisualizarFcpIcmsST.fltValor +
                                                 objConfDoc.objFatVenda.arrMatItens[intContador].fltValCBS +
                                                 objConfDoc.objFatVenda.arrMatItens[intContador].fltValIBS +
                                                 objConfDoc.objFatVenda.arrMatItens[intContador].fltVal_IS;
      cdsItens.Post;

    end;
  Finally
    cdsItens.First;
    cdsItens.EnableControls;
  End;
end;

function TfrmEstornoNotaFiscal.fConfirmaEstorno(const strChvAce, strAutInc: String) : Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  Try
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE CADFIS SET FIS_ESTNFE = "S" WHERE FIS_ACESSO = :ACESSO ');
      qryAux.ParamByName('ACESSO').AsString := strChvAce;
      qryAux.ExecSQL;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE AUXMOV SET AUX_DOCDEV = :DOCDEV, ');
      qryAux.SQL.Add('                  AUX_ESPDEV = :ESPDEV, ');
      qryAux.SQL.Add('                  AUX_EMPDEV = :EMPDEV  ');
      qryAux.SQL.Add('WHERE AUX_SEQGER = :AUTINC ');
      qryAux.ParamByName('DOCDEV').AsString := FNumDoc;
      qryAux.ParamByName('ESPDEV').AsString := 'NF';
      qryAux.ParamByName('EMPDEV').AsString := FCodEmp;
      qryAux.ParamByName('AUTINC').AsString := strAutInc;
      qryAux.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmEstornoNotaFiscal.fConfirmaEstorno]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmEstornoNotaFiscal.fDigOcorrencia : Boolean;
  Var
    frmDigOcorrencia : TfrmDigOcorrencia;
begin
  Result := False;

  pCriarFormularios(TfrmDigOcorrencia, frmDigOcorrencia);

  try

    frmDigOcorrencia.strCodOco := objConfDoc.objFatVenda.strMotDev;
    frmDigOcorrencia.strOpcDoc := objConfDoc.objFatVenda.strOpcDoc;
    frmDigOcorrencia.blnInformarHisCom := True;

    frmDigOcorrencia.ShowModal;

    If (frmDigOcorrencia.ModalResult = mrOk) Then
    Begin
      objConfDoc.objFatVenda.strMotDev := frmDigOcorrencia.strCodOco;
      objConfDoc.objFatVenda.strHisCom := frmDigOcorrencia.strHisCom;
      objConfDoc.objFatVenda.strEstornoNotaFiscalMotivo := frmDigOcorrencia.strHisCom;
      Result := True;
    End;

  finally
    pFreeAndNil(frmDigOcorrencia);
  end;
end;

procedure TfrmEstornoNotaFiscal.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If (Not fVerificaCampos) Then
    Exit;

  If not Assigned(objConfDoc) Then
    Exit;

  If not fDigOcorrencia Then
    Exit;

  If fEmptyStr(objConfDoc.objFatVenda.strEstornoNotaFiscalMotivo) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o histórico complementar do estorno!', ['&Ok']);
    Exit;
  End;

  If objConfDoc.fConfirmarDocumentos Then
  Begin
    fMensagem('ATENÇÃO!', 'Estorno da Nota Fiscal [' + objConfDoc.strNumDoc + '] realizado com sucesso!', ['&Ok']);
    btnCancelar.Click;
  End;

end;

procedure TfrmEstornoNotaFiscal.pLimpaDados;
begin
  FNumDoc := '';
  FEspDoc := '';
  FCodEmp := '';
  FSerie_ := '';
  FCodCli := '';
  FChvAce := '';
  FEntFut := False;

  cdsItens.EmptyDataSet;

  If Assigned(objConfDoc) Then
  Begin
    objConfDoc.objFatVenda.fBaixarEstorno := Nil;
    FreeAndNil(objConfDoc);
  End;
end;

procedure TfrmEstornoNotaFiscal.dtsItensDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  edtCodCli.Enabled    := cdsItens.IsEmpty;
  edtNumDoc.Enabled    := cdsItens.IsEmpty;
  edtSerie.Enabled     := cdsItens.IsEmpty;
  btnCarregar.Enabled  := cdsItens.IsEmpty;
  btnConfirmar.Enabled := not cdsItens.IsEmpty;
end;

procedure TfrmEstornoNotaFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pLimpaDados;
end;

procedure TfrmEstornoNotaFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadCli := fCriaQuery;
  cdsItens.CreateDataSet;
  FEntFut := False;
end;

procedure TfrmEstornoNotaFiscal.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryCadCli);
  FreeAndNil(cdsItens);
end;

procedure TfrmEstornoNotaFiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10   : btnConfirmar.Click;
    VK_ESCAPE: Begin
                 If fMensagem('', 'Deseja realmente sair?', ['&Sim', '&Não']) = 1 Then
                   btnSair.Click;
               End;
  End;
end;

procedure TfrmEstornoNotaFiscal.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCli);
end;

function TfrmEstornoNotaFiscal.fPermiteEstornarNotaFiscal(const strClaFis: String): Boolean;
begin
  Result := True;
  If (Not fEmptyStr(strClaFis)) Then
  Begin
    If (StrToInt(LeftStr(strClaFis, 1)) < 5) Then
      Exit;
    If (RightStr(strClaFis, 3) = '922') Then
      Exit;
  End;
  Result := False;
end;

function TfrmEstornoNotaFiscal.fBaixarEntregaFutura: Boolean;
  Var
    qryItens : TUniQuery;
    blnCarregouItens : Boolean;
    strTabela : String;
begin
  qryItens := fCriaQuery(Self);
  Try
    Result := True;
    strTabela := 'MOVDET';
    blnCarregouItens := fCarregouItensDocumentoOriginal(qryItens, strTabela);
    If (Not blnCarregouItens) Then
    Begin
      strTabela := 'NOTDET';
      blnCarregouItens := fCarregouItensDocumentoOriginal(qryItens, strTabela);
    End;
    If (Not blnCarregouItens) Then
    Begin
      Result := False;
      objConfDoc.objFatVenda.strMsgCancelamento := 'Itens do documento da entrega futura não foram encontrados para baixa!';
      Exit;
    End;
    qryItens.First;
    While Not qryItens.Eof Do
    Begin
      If (Not objConfDoc.objFatVenda.fBaixaItem(strTabela, qryItens.FieldByName('AUTOINCREM').AsString, qryItens.FieldByName('DET_QTDITE').AsFloat)) Then
      Begin
        Result := False;
        objConfDoc.objFatVenda.strMsgCancelamento := Format('Falha na baixa do item de entrega futura: %s!', [qryItens.FieldByName('AUTOINCREM').AsString]);
        Exit;
      End;
      ReprocessarItem(qryItens.FieldByName('DET_CODITE').AsString, FCodEmp, True, True);
      qryItens.Next;
    End;
  Finally
    FreeAndNil(qryItens);
  End;
end;

function TfrmEstornoNotaFiscal.fBaixarEstorno : Boolean;
begin
  Result := False;
  If Not fConfirmaEstorno(FChvAce, objConfDoc.objFatVenda.strAutInc) Then
    Exit;
  If (FEntFut) Then
  Begin
    If (Not fBaixarEntregaFutura) Then
      Exit;
  End;
  Result := True;
end;

function TfrmEstornoNotaFiscal.fCarregouItensDocumentoOriginal(var qryItens : TUniQuery; const strTabela : String) : Boolean;
begin
  qryItens.Close;
  qryItens.SQL.Clear;
  qryItens.SQL.Add(' SELECT AUTOINCREM, DET_QTDITE, DET_CODITE ');
  qryItens.SQL.Add('   FROM ' + strTabela);
  qryItens.SQL.Add('  WHERE DET_NUMDOC = :NUMDOC ');
  qryItens.SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
  qryItens.SQL.Add('    AND DET_CODEMP = :CODEMP ');
  qryItens.SQL.Add('    AND DET_CODCLI = :CODCLI ');
  qryItens.SQL.Add('    AND DET_TIP_FC = :TIP_FC ');
  qryItens.SQL.Add('    AND DET_SERIE_ = :SERIE_ ');
  qryItens.SQL.Add('    AND DET_ORIDOC = :ORIDOC ');
  qryItens.ParamByName('NUMDOC').AsString := FNumDoc;
  qryItens.ParamByName('ESPDOC').AsString := FEspDoc;
  qryItens.ParamByName('CODEMP').AsString := FCodEmp;
  qryItens.ParamByName('CODCLI').AsString := FCodCli;
  qryItens.ParamByName('TIP_FC').AsString := 'C';
  qryItens.ParamByName('SERIE_').AsString := FSerie_;
  qryItens.ParamByName('ORIDOC').AsString := 'V';
  qryItens.Open;
  Result := (Not qryItens.IsEmpty);
end;

end.
