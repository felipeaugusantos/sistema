unit untFatAltLoteItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxButtonEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient,
  UniClientDataSet, Faturamento.Classes.TAlterarPedido, untLiberacao, cxProgressBar,
  untTypesSistema, untTFatReprocessarSaldoItem;

type
  TfrmFatAltLoteItem = class(TfrmPai)
    pnlBusca: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    pnlDados: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    lbl8: TLabel;
    edtCodCndAtu: TEditFocus;
    mskCndPagAtu: TMaskEditFocus;
    edtDesCndAtu: TEditFocus;
    lbl5: TLabel;
    edtDtaEnt: TEditFocus;
    lbl6: TLabel;
    edtValDocAtu: TEditFocus;
    lbl7: TLabel;
    edtForPagAtu: TEditFocus;
    edtDesFpgAtu: TEditFocus;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    cdsProdutosDESCRI: TStringField;
    cdsProdutosUNIDAD: TStringField;
    cdsProdutosQTDITE: TFloatField;
    cdsProdutosUNITAR: TFloatField;
    cdsProdutosTOTITE: TFloatField;
    cdsProdutosAUTINC: TStringField;
    dtsProdutos: TDataSource;
    cdsProdutosNUMLOT: TStringField;
    cdsProdutosNEWLOT: TStringField;
    pnlGrid: TPanel;
    cxGrid: TcxGrid;
    cxGridItens: TcxGridDBTableView;
    cxGridItensCodIte: TcxGridDBColumn;
    cxGridItensDescri: TcxGridDBColumn;
    cxGridItensUnidad: TcxGridDBColumn;
    cxGridItensQtdIte: TcxGridDBColumn;
    cxGridItensUnitar: TcxGridDBColumn;
    cxGridItensTotIte: TcxGridDBColumn;
    cxGridItensLote: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlTitulo: TPanel;
    cxGridItensNewLot: TcxGridDBColumn;
    cdsProdutosEMPITE: TStringField;
    cxGridItensEmpIte: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxGridItensNovoLotePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cxGridItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cxGridItensNewLotPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure cxGridEnter(Sender: TObject);
    procedure cxGridExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  const
    sqlInsertLog = ' INSERT INTO LOGLOT (AUTOINCREM, LOG_NUMDOC, LOG_ESPDOC,  '+
                   '   LOG_CODCLI, LOG_CODEMP, LOG_DTAALT, LOG_HRAALT,        '+
                   '   LOG_OPEALT, LOG_AUTINC, LOG_INFANT, LOG_INFNOV) VALUES '+
                   '(:AUTOIN, :NUMDOC, :ESPDOC, :CODCLI, :CODEMP, :DTAALT,    '+
                   ' :HRAALT, :OPEALT, :AUTINC, :INFANT, :INFNOV )           ;';
    sqlUpdateLot = 'UPDATE FATDOR SET FDO_NUMLOT = :NEWLOT WHERE AUTOINCREM = :AUTINC;';
  private
    objLiberacao: TLiberacao;
    objAltPed: TAlterarPedido;
    cdsBkpItens: TUniClientDataset;
    blnLockUnLock: Boolean;

    procedure pUnLock;
    procedure pClearForm;
    procedure pSetDataScreen;
    procedure pAfterPost(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);
    procedure pTrocaLote(const strValue: String);
    procedure pGridValidaLote(const strValue: String);
    procedure pAlteraLote(strAutInc, strNewLot: String);
    procedure pGeraLogAlteracao(strNumDoc, strEspDoc, strCodEmp, strCodCli, strNumLot, strNewLot, strAutInc: String);

    function fCodEmp: String;
    function fLoadPedido: Boolean;
    function fFoiAlteradoAlgumProduto: Boolean;
    function fConfirma(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fLoadItensPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fPesquisaLote(Sender: TObject; Var Key: Char; arrNumLot: TStringArray = Nil): Boolean;
    function fValidaEstoque(const strCodIte, strAutInc, strCodEmp, strNumLot, strNewLot: String; const fltQtdIte: Double): Boolean;
    function fPedido_Ent_CD(var strEmpresa_CD: String): Boolean;
  protected
    procedure pEscapePressed; Override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  public
    { Public declarations }
    blnConEqu: Boolean;
    strNumDoc,
    strEspDoc,
    strCodEmp: String;
  end;

implementation

{$R *.dfm}

uses
  Uni,
  untFuncoes,
  untFuncFat,
  untCadLote,
  untGravando,
  System.Math,
  untPanelCxCadLote,
  untFuncoesSimples,
  untPnlDadosCadLote, untAdiantamentoClienteGenerico, untFuncFatImp,
  untFuncFatTypes;

{ TfrmFatAltLoteItem }

procedure TfrmFatAltLoteItem.btnConfirmaClick(Sender: TObject);
var
  frmAguarde: TfrmGravando;
  objFatImp : TFatVendaImp;
  documento : TDadosImpressaoVenda;
  strEmp_CD : String;

begin
  inherited;
  If (Not btnConfirma.Enabled) Or (Not fFoiAlteradoAlgumProduto()) Then
    Exit;

  If ((fMensagem('','Confirma alteração do ' + objAltPed.objVenda.objCadLot.strDescri +
                  ' ?', ['','']) = 2)) Then
    Exit;

  Try
    documento.strCodCli := edtCodCli.Text;
    documento.strNumDoc := edtNumDoc.Text;
    documento.strEspDoc := edtEspDoc.Text;
    documento.strEmpDoc := edtCodEmp.Text;

    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fConfirma;
    frmAguarde.ShowModal;

    If (Not fCfgSis('UTIWMS', VarBoolean)) Then
    Begin
      If (fMensagem('','Imprimir a separação do pedido ?', ['','']) = 1) Then
      Begin

        objFatImp := TFatVendaImp.Create;

        Try
          documento.strCodLsePorSetor := '';
          documento.blnExpedi := True;
          documento.blnEnt_CD := (Pos(documento.strEspDoc, 'OR_PD_') > 0) And
                                      fPedido_Ent_CD(strEmp_CD);

          objFatImp.Add(documento);
          objFatImp.fImprimeSeparacao(objFatImp[0],
                                      '',
                                      '',
                                      False,
                                      -1,
                                      TFatVendaImp.fItensDocumento(documento.strNumDoc,
                                                                   documento.strEspDoc,
                                                                   documento.strEmpDoc,
                                                                   documento.strCodCli));
        Finally
          FreeAndNil(objFatImp);
        End;

      End;
    End;
  Finally
    pFreeAndNil(frmAguarde);

  End;

  if blnConEqu then
    Close;
end;

procedure TfrmFatAltLoteItem.cxGridEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '[CTRL+ENTER - Pesquisa de ' + objAltPed.objVenda.objCadLot.strDescri + ']';
end;

procedure TfrmFatAltLoteItem.cxGridExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmFatAltLoteItem.cxGridItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_ESCAPE: pEscapePressed();
  End;
end;

procedure TfrmFatAltLoteItem.cxGridItensNewLotPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  strValue: String;
begin
  inherited;
  strValue := varToStr(DisplayValue);
  pGridValidaLote(strValue)
end;

procedure TfrmFatAltLoteItem.cxGridItensNovoLotePropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  If AButtonIndex = 0 Then
    pGridValidaLote('/');
end;

function TfrmFatAltLoteItem.fPedido_Ent_CD(var strEmpresa_CD : String) : Boolean;
  var
    qryAux : TUniQuery;
begin

  Result        := False;
  strEmpresa_CD := '';

  If fEmptyStr(edtNumDoc.Text) Or
     fEmptyStr(edtEspDoc.Text) Or
     fEmptyStr(edtCodEmp.Text) Then
    Exit;

  qryAux := fCriaQuery();

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT                     ');
    qryAux.SQL.Add('  FGO_ENT_CD,              ');
    qryAux.SQL.Add('  FGO_EMP_CD               ');
    qryAux.SQL.Add('FROM                       ');
    qryAux.SQL.Add('  FATGOR                   ');
    qryAux.SQL.Add('  INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ');
    qryAux.SQL.Add('WHERE                      ');
    qryAux.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  FGO_CODEMP = :CODEMP     ');

    qryAux.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
    qryAux.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
    qryAux.ParamByName('CODEMP').AsString := edtCodEmp.Text;

    qryAux.Open;

    If Not qryAux.IsEmpty Then
      If (qryAux.FieldByName('FGO_ENT_CD').AsString = 'S') Then
      Begin
        strEmpresa_CD := qryAux.FieldByName('FGO_EMP_CD').AsString;
        Result := True;
      End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TfrmFatAltLoteItem.fCodEmp: String;

var
  strEmp_CD : String;

begin

  If cdsProdutos.IsEmpty Then
    Result := edtCodEmp.Text
  Else
  Begin

    If (fPedido_Ent_CD(strEmp_CD)) Then
      Result := strEmp_CD
    Else
    If (Not fEmptyStr(objAltPed.objVenda.strEmp_TE)) Then
      Result := objAltPed.objVenda.strEmp_TE
    Else
    If (objAltPed.objVenda.blnEmpFat) And (Not fEmptyStr(cdsProdutosEMPITE.AsString)) Then
      Result := cdsProdutosEMPITE.AsString
    Else
      Result := edtCodEmp.Text;

  End;

end;

function TfrmFatAltLoteItem.fConfirma(pgbStatus: TcxProgressBar = Nil): Boolean;
var
  blnGravou: Boolean;
  LEmpresa: String;
  LEmpresas: TArray<String>;
  objReprocessarSaldoItens: IReprocessarSaldoItem;
begin
  Result := True;

  objReprocessarSaldoItens := TReprocessarSaldoItem.New();
  blnGravou := False;
  cdsProdutos.DisableControls;
  Try
    //Validação do saldo novamente
    cdsProdutos.First;
    While (Not cdsProdutos.Eof) Do
    Begin
      If (fEmptyStr(cdsProdutosNEWLOT.AsString)) Then
      Begin
        cdsProdutos.Next();
        Continue;
      End;

      If ((Not fValidaEstoque(cdsProdutosCODITE.AsString,
                              cdsProdutosAUTINC.AsString,
                              fCodEmp(),
                              cdsProdutosNUMLOT.AsString,
                              cdsProdutosNEWLOT.AsString,
                              cdsProdutosQTDITE.AsFloat))) Then
        Exit;

      cdsProdutos.Next();
    End;

    Try
      fStartTransaction();

      cdsProdutos.First;
      While (Not cdsProdutos.Eof) Do
      Begin
        If (fEmptyStr(cdsProdutosNEWLOT.AsString)) Then
        Begin
          cdsProdutos.Next();
          Continue;
        End;

        pAlteraLote(cdsProdutosAUTINC.AsString, cdsProdutosNEWLOT.AsString);

        pGeraLogAlteracao(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text,
                          edtCodCli.Text, cdsProdutosNUMLOT.AsString,
                          cdsProdutosNEWLOT.AsString, cdsProdutosAUTINC.AsString);

        {***************************************}
        {* MARCA ITEM PARA REPROCESSO DE SALDO *}
        {***************************************}
        LEmpresas := fGetEmpresasReprocessarItemPedido(cdsProdutosAUTINC.AsString);

        For LEmpresa In LEmpresas Do
            objReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.
                                                Codigo(cdsProdutosCODITE.AsString).
                                                Empresa(LEmpresa));

        cdsProdutos.Next();
      End;
      objReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos;

      fCommit();
      blnGravou := True;
    Except
      on E: Exception do
      Begin
        fRollBack();
        pMensagensErro(E.Message, '[Erro ao Gravar Alteração]');
      End;
    End;
  Finally
    cdsProdutos.EnableControls;

    If blnGravou Then
      pClearForm();
  End;
end;

function TfrmFatAltLoteItem.fFoiAlteradoAlgumProduto: Boolean;
begin
  cdsBkpItens.Filter := 'NEWLOT <> ' + Quotedstr('');
  cdsBkpItens.Filtered := True;

  Result := (cdsBkpItens.RecordCount > 0);

  If (Not Result) Then
    fMensagem('', 'Não há alterações a serem gravadas!', ['&OK']);

  cdsBkpItens.Filtered := False;
end;

function TfrmFatAltLoteItem.fLoadItensPedido(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  Result := True;
  cdsProdutos.AfterPost := Nil;
  cdsProdutos.BeforePost := Nil;

  If cdsBkpItens.Active Then
    cdsBkpItens.Close();

  pInfoStatusGravacao(pgbStatus, 'Aguarde... Carregando itens com ' +
                                 objAltPed.objVenda.objCadLot.strTitLab +
                                 ' informado...');
  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := cdsVenda.RecordCount;
  cdsProdutos.DisableControls();

  cdsVenda.First;

  While (Not cdsVenda.Eof) Do
  Begin
    pStepStatusGravacao(pgbStatus);

    if blnConEqu and (fEhItemServico(cdsVenda.FieldByName('ITE_CODITE').AsString)
      or (not fEmptyStr(cdsVenda.FieldByName('ITE_NUMLOT').AsString))) then
    begin
      cdsVenda.Next();
      Continue;
    end;

    If (cdsVenda.FieldByName('ITE_JAFATU').AsBoolean) Then
    Begin
      cdsVenda.Next();
      Continue;
    End;

    cdsProdutos.Append();
    cdsProdutosAUTINC.AsString := cdsVenda.FieldByName('ITE_SEQDET').AsString;
    cdsProdutosCODITE.AsString := cdsVenda.FieldByName('ITE_CODITE').AsString;
    cdsProdutosDESCRI.AsString := cdsVenda.FieldByName('ITE_DESITE').AsString;
    cdsProdutosUNIDAD.AsString := cdsVenda.FieldByName('ITE_UNIDAD').AsString;
    cdsProdutosNUMLOT.AsString := cdsVenda.FieldByName('ITE_NUMLOT').AsString;
    cdsProdutosEMPITE.AsString := cdsVenda.FieldByName('ITE_EMPITE').AsString;
    cdsProdutosUNITAR.AsFloat  := cdsVenda.FieldByName('ITE_UNITAR').AsFloat;
    cdsProdutosQTDITE.AsFloat  := cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
    cdsProdutosTOTITE.AsFloat  := cdsVenda.FieldByName('ITE_TOTITE').AsFloat;
    cdsProdutos.Post();

    cdsVenda.Next();
  End;

  pCloneDataSet(cdsBkpItens, cdsProdutos);

  cdsProdutos.First;
  cdsProdutos.AfterPost := pAfterPost;
  cdsProdutos.BeforePost := pBeforePost;
  cdsProdutos.EnableControls();

  If cdsProdutos.IsEmpty Then
  Begin
    fMensagem('','Nenhum produto encontrado que permite alterar o ' +
                 objAltPed.objVenda.objCadLot.strTitLab + '!',['&O K']);
    pClearForm();
  End
  Else
  Begin
    pSetFocus(cxGrid);
    btnConfirma.Enabled := True;
  End;
end;

function TfrmFatAltLoteItem.fLoadPedido: Boolean;
begin
  If Not fLock_Unlock( 'FATGOR' + edtNumDoc.Text +
                                  edtEspDoc.Text +
                                  edtCodEmp.Text, True, False ) Then
  Begin
    fMensagem('', 'Esse Documento está sendo utilizado em Outra Estação por ' +
                  fGetHostLock('FATGOR' + edtNumDoc.Text + edtEspDoc.Text + edtCodEmp.Text)  + '!', ['&Ok']);
    Result := False;
    Exit;
  End;

  blnLockUnLock := True;

  objAltPed.strNumPed := edtNumDoc.Text;
  objAltPed.strEmpPed := edtCodEmp.Text;

  Result := objAltPed.fCarregarPedido();

  If Result Then
    pSetDataScreen();
end;

procedure TfrmFatAltLoteItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  pUnLock();
  inherited;
end;

procedure TfrmFatAltLoteItem.FormCreate(Sender: TObject);
var
  objCadLot: TCadLot;
begin
  inherited;
  pSetaCodIte(cdsProdutosCODITE);

  objLiberacao := TLiberacao.Create;
  cdsBkpItens := TUniClientDataSet.Create(Self);
  objCadLot := TCadLot.Create(Self);
  blnLockUnLock := False;
  blnConEqu := False;
  strNumDoc := '';
  strEspDoc := '';
  strCodEmp := '';

  Try
    Self.Caption := Format(Self.Caption, [objCadLot.strTitLab]);
    cxGridItensLote.Caption := objCadLot.strTitLab;
    cxGridItensNewLot.Caption := 'Novo ' + objCadLot.strTitLab;
  Finally
    FreeAndNil(objCadLot);
  End;
end;

procedure TfrmFatAltLoteItem.FormDestroy(Sender: TObject);
begin
  If Assigned(objLiberacao) Then
    FreeAndNil(objLiberacao);
  If Assigned(objAltPed) Then
    FreeAndNil(objAltPed);
  FreeAndNil(cdsBkpItens);
  inherited;
end;

procedure TfrmFatAltLoteItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirma.Click();
  End;
end;

procedure TfrmFatAltLoteItem.FormShow(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo  := fTamNumPedCom();
  edtNumDoc.MaxLength := edtNumDoc.TamCampo;

  cdsProdutos.CreateDataSet();
  pClearForm();

  if blnConEqu then
  begin
    edtNumDoc.Text := strNumDoc;
    edtEspDoc.Text := strEspDoc;
    edtCodEmp.Text := strCodEmp;
    fLoadPedido;
  end;
end;

function TfrmFatAltLoteItem.fPesquisaLote(Sender: TObject; var Key: Char;
  arrNumLot: TStringArray): Boolean;
var
  objfrmPnl: TPanelCxCadLote;
begin
  Try
    objfrmPnl := TPanelCxCadLote.Create(TfrmPnlDadosCadLote);
    objfrmPnl.strCodIte := cdsProdutosCODITE.AsString;

    Result := objAltPed.objVenda.objCadLot.fedtNumLotKeyPress(cdsProdutosCODITE.AsString,
                                                              Sender,
                                                              Key,
                                                              TEditFocus(Sender),
                                                              Self,
                                                              False,
                                                              False,
                                                              objfrmPnl,
                                                              arrNumLot,
                                                              fCodEmp(),
                                                              True);
  Finally
    FreeAndNil(objfrmPnl);
  End;
end;

function TfrmFatAltLoteItem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    blnJaFatu,
    blnJaBaix,
    blnImpresso,
    blnSepImpresso: Boolean;
    strCodRom: String;
    strCodVen: String;

    Function fDocEmRomaneio: Boolean;
    Begin
      strCodRom := '';
      If (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        strCodRom := fDocumentoEmRomaneio(edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text);
      End;
      Result := Not fEmptyStr(strCodRom);
    End;
begin
  Result := True;
  blnJaFatu := False;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtNumDoc) Then
    Begin
      If fEmptyStr(edtNumDoc.Text) Then
      Begin
        fMensagem('','Informe o número do documento !',['&O K']);
        Result := False;
      End;
    End
    Else If (Sender = edtCodEmp) Then
    Begin
      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        fMensagem('','Informe o código da empresa !',['&O K']);
        Result := False;
      End
      Else
      Begin
        edtDesEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
        If fEmptyStr(edtDesEmp.Text) Then
        Begin
          fMensagem('','Empresa digitada não foi encontrada, verifique !',['&O K']);
          Result := False;
        End
        Else
        Begin
          Try
            If (Not fDocumentoFatExiste(objAltPed.qryFatGor, edtNumDoc.Text, edtEspDoc.Text, edtCodEmp.Text, blnJaFatu, blnJaBaix, blnImpresso, strCodVen, blnSepImpresso)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse documento não está cadastrado!', ['&O k']);
              Result := False;
            End
            Else If (blnJaFatu) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse documento já foi faturado!', ['&O k']);
              Result := False;
            End
            Else If (Not fEmptyStr(edtNumDoc.Text)) And (Not fVerificaAcessoSistema('VERPED')) And (strCodVen <> strLoginUsuarioLogado) And (Not fEmptyStr(strCodVen)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Acesso ao documento não permitido!', ['&O k']);
              Result := False;
            End
            Else If fDocEmRomaneio() And (Not fCfgSis('USPRRO', varBoolean)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse pedido está associado ao(s) Romaneio(s): ' + strCodRom + '.' + #13#10 +
                                    'Remova esse pedido do(s) romaneio(s) para poder alterá-lo!', ['&Ok']);
              Result := False;
              objAltPed.qryFatGor.Close;
            End
            Else If (Not fCfgSis('ALTPDI', varBoolean)) And (blnImpresso) And
                    (Not fEmptyStr(edtNumDoc.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse pedido já foi impresso portanto não é possível alterá-lo!', ['&Ok']);

              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('Esse pedido já foi impresso portanto não é possível alterá-lo!');

              objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'  , objAltPed.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                     objAltPed.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                     objAltPed.qryFatGor.FieldByName('FGO_CODEMP').AsString                 , 7);

              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                     fRetNomCliente(objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 7);


              objLiberacao.strDirAce := 'ALTPDI';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.blnSempreVariavelUsuario := True;

              If objLiberacao.fLibera Then
                Result := True
              Else
                Result := False;
            End
            Else If (blnSepImpresso) And (Not fEmptyStr(edtNumDoc.Text)) Then
            Begin
              If fImpressaoParcialConsiderandoJaImpresso Then
              Begin
                fMensagem('ATENÇÃO!', 'Não é possível alterar esse pedido, pois a separação já foi impressa!', ['&Ok']);
                Result := False;
              End
              Else If (fCfgSis('ALTPDS') = 'N') Then
              Begin
                fMensagem('ATENÇÃO!', 'Não é possível alterar esse pedido, pois a separação já foi impressa!', ['&Ok']);

                objLiberacao.Clear;
                objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse pedido, pois a separação já foi impressa!');

                objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'  , objAltPed.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                       objAltPed.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                       objAltPed.qryFatGor.FieldByName('FGO_CODEMP').AsString                 , 7);

                objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                       fRetNomCliente(objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 7);


                objLiberacao.strDirAce := 'ALTPDS';
                objLiberacao.strCodOpe := strLoginUsuarioLogado;
                objLiberacao.blnSempreVariavelUsuario := True;

                Result := objLiberacao.fLibera;
              End
              Else If (fCfgSis('ALTPDS') = 'C') And
                      (objAltPed.qryFatGor.FieldByName('FGO_ENT_CD').AsString = 'S') And
                      (objAltPed.qryFatGor.FieldByName('FGO_ESPDOC').AsString = 'PD') And
                      (objAltPed.qryFatGor.FieldByName('FGO_EMP_CD').AsString <> VS_strCodEmp) Then
              Begin
                fMensagem('ATENÇÃO!', 'Não é possível alterar, pois este pedido é entrega '
                                    + 'pelo CD e a separação já foi impressa. '
                                    + 'Somente será possível realizar alteração após limpar separação. '
                                    + 'Entre em contato com o responsável pelo CD.', ['&Ok']);
                Result := False;
              End;
            End
            Else If (Not fEmptyStr(edtNumDoc.Text)) And
                    (VS_strUsaTmq = 'S')  And
                    (Not fCfgSis('ALTPDT', varBoolean)) And
                    (fTemProdutoTintometrico(objAltPed.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                             objAltPed.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                             objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                             objAltPed.qryFatGor.FieldByName('FGO_CODEMP').AsString)) And
                    (fTemOrdemProducaoTintaImpresso(objAltPed.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                                    objAltPed.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                                    objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString,
                                                    objAltPed.qryFatGor.FieldByName('FGO_CODEMP').AsString)) Then
            Begin
              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('Não é possível alterar esse pedido, pois a ordem de produção de produtos tintométricos já foi impressa!');

              objLiberacao.objMsgLibera.pAddTextoCaption('Pedido'  , objAltPed.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                                     objAltPed.qryFatGor.FieldByName('FGO_ESPDOC').AsString + '-' +
                                                                     objAltPed.qryFatGor.FieldByName('FGO_CODEMP').AsString                 , 7);

              objLiberacao.objMsgLibera.pAddTextoCaption('Cliente' , objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString + '-' +
                                                                     fRetNomCliente(objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString) , 7);


              objLiberacao.strDirAce := 'ALTPDT';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;
              objLiberacao.blnSempreVariavelUsuario := True;

              If objLiberacao.fLibera Then
                Result := True
              Else
                Result := False;
            End;

            If Result And
               SameText(edtEspDoc.Text, 'PD')                                   And
               ( Not fEmptyStr( edtNumDoc.Text ) )                              And
               (TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaEnviados(
                                  objAltPed.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                  objAltPed.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                  objAltPed.qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                  objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é permitido alterar um pedido com boleto(s) '+
                'de adiantamento já enviado(s) para o banco!', ['&Ok']);
              Result := False;
            End;

            If Result And
               SameText(edtEspDoc.Text, 'PD')                                   And
               ( Not fEmptyStr( edtNumDoc.Text ) )                              And
               ( TAdiantamentoGenerico.fRetornaValorBoletosAdiantamentoJaImpressos(
                                  objAltPed.qryFatGor.FieldByName('FGO_NUMDOC').AsString,
                                  objAltPed.qryFatGor.FieldByName('FGO_ESPDOC').AsString,
                                  objAltPed.qryFatGor.FieldByName('FGO_CODEMP').AsString,
                                  objAltPed.qryFatGor.FieldByName('FGO_CODCLI').AsString) > 0 ) Then
            Begin
              objLiberacao.Clear;

              objLiberacao.objMsgLibera.pAddTexto('Permitir alterar pedido com boleto de adiantamento já impresso');
              objLiberacao.objMsgLibera.pAddQuebra;
              objLiberacao.objMsgLibera.pAddTexto('O pedido de venda ' + objAltPed.qryFatGor.FieldByName('FGO_NUMDOC').AsString + '-' +
                                                  'PD' + '-' + objAltPed.qryFatGor.FieldByName('FGO_CODEMP').AsString);
              objLiberacao.objMsgLibera.pAddTexto('possui boleto de adiantamento já impresso.');


              objLiberacao.strSenFvu := 'V';

              objLiberacao.strDirAce := 'ALTPEDBOLADT';
              objLiberacao.strMsgSen := 'Permitir alterar pedido com boleto de adiantamento já impresso';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;

              If (Not objLiberacao.fLibera) Then
              Begin
                Result := False;
              End;
            End;

            If Result Then
            Begin
              blnMudarFoco := False;
              Result := fLoadPedido();
            End;
          Except
            On E: Exception Do
            Begin
              Result := False;
              pMensagensErro(E.Message, '');
            End;
          End;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmFatAltLoteItem.fValidaEstoque(const strCodIte, strAutInc, strCodEmp,
  strNumLot, strNewLot: String; const fltQtdIte: Double): Boolean;

  function fRetQtdUtilizada: Double;
  begin
    Result := 0.00;

    Try
      cdsBkpItens.Filter := 'CODITE = ' + QuotedStr(strCodIte);
      cdsBkpItens.Filtered := True;
      cdsBkpItens.First;

      While (Not cdsBkpItens.Eof) Do
      Begin
        If (fEmptyStr(cdsBkpItens.FieldByName('NEWLOT').AsString)) Then
        Begin
          If (cdsBkpItens.FieldByName('NUMLOT').AsString = strNewLot) And
            (cdsBkpItens.FieldByName('AUTINC').AsString <> strAutInc) Then
            Result := Result + cdsBkpItens.FieldByName('QTDITE').AsFloat;
        End
        Else
        Begin
          If (cdsBkpItens.FieldByName('NEWLOT').AsString = strNewLot) And
            (cdsBkpItens.FieldByName('AUTINC').AsString <> strAutInc) Then
            Result := Result + cdsBkpItens.FieldByName('QTDITE').AsFloat;
        End;

        cdsBkpItens.Next;
      End;
    Finally
      cdsBkpItens.Filtered := False;
    End;
  end;

  function fLotePossuiSaldoSuficiente: Boolean;
  var
    intDecQtd: Integer;
    fltSaldoDisponivel: Double;
  begin
    fltSaldoDisponivel  := fRetornaSaldoDisponivel(strCodIte, False, True, strNewLot, True, strCodEmp, edtNumDoc.Text);
    fltSaldoDisponivel := (fltSaldoDisponivel - fRetQtdUtilizada());

    intDecQtd := fCfgSis('DECQTD');
    Result := (fFormataFloat(fltSaldoDisponivel, intDecQtd) >= fFormataFloat(fltQtdIte, intDecQtd));
  end;
begin
  Result := True;

  If (Not objAltPed.objVenda.objCadLot.fExisteLote(strCodIte,
                                                   strCodEmp,
                                                   strNewLot)) Then
  Begin
    fMensagem('ATENÇÃO!', objAltPed.objVenda.objCadLot.strTitLab + ' não encontrado!', ['&Ok']);
    Exit(False);
  End
  Else If (strNumLot = strNewLot) Then
  Begin
    fMensagem('ATENÇÃO!', 'Deve ser selecionado um ' +
                          objAltPed.objVenda.objCadLot.strTitLab +
                          ' diferente do já definido!', ['&Ok']);
    Exit(False);
  End
  Else If (Not fLotePossuiSaldoSuficiente()) Then
  Begin
    fMensagem('ATENÇÃO!', 'O ' + objAltPed.objVenda.objCadLot.strTitLab + ' ' + strNewLot +
              ' não possui saldo para atender a quantidade do produto(' + strCodIte + ')!', ['&Ok']);
    Exit(False);
  End;
end;

procedure TfrmFatAltLoteItem.pAfterPost(DataSet: TDataSet);
begin
  If (cdsBkpItens.Active) Then
    cdsBkpItens.Close;

  pCloneDataSet(cdsBkpItens, cdsProdutos);
end;

procedure TfrmFatAltLoteItem.pAlteraLote(strAutInc, strNewLot: String);
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlUpdateLot);
    LQry.ParamByName('NEWLOT').AsString := strNewLot;
    LQry.ParamByName('AUTINC').AsString := strAutInc;
    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure TfrmFatAltLoteItem.pBeforePost(DataSet: TDataSet);
begin
  If (fEmptyStr(cdsProdutosNEWLOT.AsString)) Then
    Exit;

  If (Not fValidaEstoque(cdsProdutosCODITE.AsString,
                         cdsProdutosAUTINC.AsString,
                         fCodEmp(),
                         cdsProdutosNUMLOT.AsString,
                         cdsProdutosNEWLOT.AsString,
                         cdsProdutosQTDITE.AsFloat)) Then
  Begin
    DataSet.Cancel;
    Abort;
  End;
end;

procedure TfrmFatAltLoteItem.pClearForm;
var
  LIdx: Integer;
begin
  pUnLock();

  If Assigned(objAltPed) Then
    FreeAndNil(objAltPed);

  objAltPed := TAlterarPedido.Create(Self);

  pnlGrid.Enabled := False;
  pnlBusca.Enabled := True;

  For LIdx := 0 To Self.ComponentCount - 1 Do
  Begin
    If Self.Components[LIdx] Is TEditFocus Then
      (Self.Components[LIdx] As TEditFocus).Clear;

    If Self.Components[LIdx] Is TMaskEditFocus Then
      (Self.Components[LIdx] As TMaskEditFocus).Clear;
  End;

  cdsProdutos.EmptyDataSet();

  edtEspDoc.Text := 'PD';
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa();
  btnConfirma.Enabled := False;

  pSetFocus(edtNumDoc);
end;

procedure TfrmFatAltLoteItem.pSetDataScreen;
var
  frmAguarde: TfrmGravando;
begin
  edtCodCli.Text := objAltPed.objVenda.strCodCli;
  edtDesCli.Text := objAltPed.objVenda.strCliNom;
  edtCodCndAtu.Text := objAltPed.objVenda.strCodCnd;
  mskCndPagAtu.Text := objAltPed.objVenda.strConPag;
  edtDesCndAtu.Text := objAltPed.objVenda.strDesCnd;
  edtForPagAtu.Text := objAltPed.objVenda.strCodFpg;
  edtDesFpgAtu.Text := objAltPed.objVenda.strDesFpg;
  edtValDocAtu.Text := FormatFloat('##,#0.00', objAltPed.objVenda.fltTotOri);
  edtDtaEnt.Text := FormatDateTime('DD/MM/YYYY', objAltPed.qryFatGor.FieldByName('FGO_DTAENT').AsDateTime);

  pnlGrid.Enabled := True;
  pnlBusca.Enabled := False;

  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fLoadItensPedido;
    frmAguarde.ShowModal;
  Finally
    pFreeAndNil(frmAguarde);
  End;
end;

procedure TfrmFatAltLoteItem.pTrocaLote(const strValue: String);
begin
  If cdsProdutos.State = dsBrowse Then
    cdsProdutos.Edit;
  cdsProdutosNEWLOT.AsString := strValue;
  cdsProdutos.Post;
end;

procedure TfrmFatAltLoteItem.pUnLock;
begin
  If blnLockUnLock Then
  Begin
    fLock_Unlock( 'FATGOR' + edtNumDoc.Text +
                             edtEspDoc.Text +
                             edtCodEmp.Text, False, False );
    blnLockUnLock := False;
  End;
end;

procedure TfrmFatAltLoteItem.pEscapePressed;
begin
  If (ActiveControl <> edtNumDoc) and (not blnConEqu) Then
    pClearForm()
  Else
    inherited;
end;

procedure TfrmFatAltLoteItem.pGeraLogAlteracao(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strNumLot, strNewLot, strAutInc: String);
var
  LQry: TUniQuery;
begin
  Try
    LQry := fCriaQuery();

    LQry.SQL.Add(sqlInsertLog);

    LQry.ParamByName('AUTOIN').AsString := fRetAutoIncrem('LOGLOT', VS_strCodEmp);
    LQry.ParamByName('NUMDOC').AsString := strNumDoc;
    LQry.ParamByName('ESPDOC').AsString := strEspDoc;
    LQry.ParamByName('CODCLI').AsString := strCodCli;
    LQry.ParamByName('CODEMP').AsString := strCodEmp;
    LQry.ParamByName('DTAALT').AsDate   := VS_Date;
    LQry.ParamByName('HRAALT').AsTime   := fTime();
    LQry.ParamByName('OPEALT').AsString := strLoginUsuarioLogado;
    LQry.ParamByName('AUTINC').AsString := strAutInc;
    LQry.ParamByName('INFANT').AsString := strNumLot;
    LQry.ParamByName('INFNOV').AsString := strNewLot;

    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
end;

procedure TfrmFatAltLoteItem.pGridValidaLote(const strValue: String);
var
  Key: Char;
  edtNewLote: TEditFocus;
begin
  If (fEmptyStr(strValue)) Then
    Exit;

  If Pos(strValue, '/') > 0 Then
  Begin
    Key := '/';

    edtNewLote := TEditFocus.Create(nil);

    If fPesquisaLote(edtNewLote, Key) Then
      pTrocaLote(edtNewLote.Text);

    FreeAndNil(edtNewLote);
  End
  Else
    pTrocaLote(strValue);
end;

end.

