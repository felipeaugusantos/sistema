unit untOrdProdMonitoramento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  ComboEditFocus, untFuncoesSimples, ComboBoxFocus, untOrdPro, Data.DB,
  StrUtils, untTypesSistema, untConsultas, Uni, UniClientDataSet;

type
  TfrmOrdProdMonitoramento = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    pnlCodBar: TPanel;
    pnlBaixa: TPanel;
    pnlInfoPrdAca: TPanel;
    Label1: TLabel;
    edtCodBar: TEditFocus;
    Label2: TLabel;
    edtSenOpe: TEditFocus;
    Label5: TLabel;
    edtNomOpe: TEditFocus;
    Label6: TLabel;
    Label8: TLabel;
    cbxFase: TComboBoxFocus;
    cbxSituacao: TComboBoxFocus;
    edtDesIte: TEditFocus;
    btnManMon: TBitBtnLocked;
    edtCodIte: TEditFocus;
    edtReferencia: TEditFocus;
    Label7: TLabel;
    edtSigUni: TEditFocus;
    lblUnidade: TLabel;
    edtCodFabrica: TEditFocus;
    lblCodFab: TLabel;
    btnIncluirSubprod: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnManMonClick(Sender: TObject);
    procedure edtCodBarKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnIncluirSubprodClick(Sender: TObject);
  private
    { Private declarations }
    strCodOpe: String;
    objOrdPro: TOrdPro;
    strAutIncFase: String;
    strAutIncOrdPro: String;
    cdsSubProd: TUniClientDataSet;

    procedure pCarreDadosOP;
    procedure pLimpaTela(blnCodBar: Boolean = False);
    procedure pCarregaFases;

    Function fCodFaseSelecionada: String;
    function fCarregaItensTmp(strCodIte, strDesIte: String; blnApenasValida : boolean = False; blnApenasCarregaOrdPro: Boolean = False): Boolean;
    procedure pCriaCdsSubProdutos;
    procedure pAtualizaCdsSubProdutos;
    procedure pCompletaCdsSubProdPelaEstrutura;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  untOrdProOperacoes, untOrdProItensEstrut;

Function TfrmOrdProdMonitoramento.fCodFaseSelecionada: String;
Begin
  strAutIncFase := '';
  Result := LeftStr(cbxFase.Text, 3);
  If Not fEmptyStr(Result) Then
    strAutIncFase := fCampoTabela('AUTOINCREM', 'FASGER', ['FAS_CODIGO'], [Result]);

  cdsSubProd.Filter := 'SEQFAS = ' + QuotedStr(strAutIncFase);
  cdsSubProd.Filtered := True;
End;

procedure TfrmOrdProdMonitoramento.btnConfirmaClick(Sender: TObject);
var
  blnResult: Boolean;
  strResult,
  strCodFas: String;
begin
  inherited;
  blnResult := False;
  strCodFas := fCodFaseSelecionada;

  If fVerificaCampos Then
  Begin
    If (cbxFase.ItemIndex = -1) Then
    Begin
      pMensagemOk('Selecione a Fase da Ordem de Produção!');
      Exit;
    End;

    If (cbxSituacao.ItemIndex = -1) Then
    Begin
      pMensagemOk('Selecione a Situação da Ordem de Produção!');
      Exit;
    End;

    Case cbxSituacao.ItemIndex Of
      0: Begin
           blnResult := objOrdPro.objMonitor.fIniciaOperacao(strAutIncOrdPro, strCodOpe, strCodFas);
           strResult := 'Fase inicializada com sucesso!';
         End;
      1: Begin
           blnResult := objOrdPro.objMonitor.fFinalizaOperacao(strAutIncOrdPro, strCodOpe, strCodFas);
           strResult := 'Operação finalizada com sucesso!';
         End;
    End;

    blnResult := blnResult And objOrdPro.fGravaDetOrdProFases(strAutIncOrdPro, strAutIncFase, cdsSubProd);
    If blnResult Then
    Begin
      pMensagemOk(strResult);
      pLimpaTela(True);
      pSetFocus(edtCodBar);
    End;
  End;
end;

procedure TfrmOrdProdMonitoramento.btnIncluirSubprodClick(Sender: TObject);
begin
  inherited;
  If Not btnIncluirSubprod.Enabled Then
    Exit;

  fCodFaseSelecionada;

  If fEmptyStr(strAutIncFase) Then
  Begin
    pMensagemOk('Selecione uma fase!');
    Exit;
  End;

  fCarregaItensTmp(edtCodIte.Text, edtDesIte.Text);
end;

function TfrmOrdProdMonitoramento.fCarregaItensTmp(strCodIte, strDesIte: String; blnApenasValida : boolean = False; blnApenasCarregaOrdPro: Boolean = False) : Boolean;
var
  strCodPro: String;
begin
  Try
    edtCodIte.Enabled := False;

    strCodPro := edtCodBar.Text;

    objOrdPro.pCriaTemporaria(True, strCodPro, strAutIncFase);

    pCriarFormularios(tfrmOrdProItensEstrut, frmOrdProItensEstrut);
    frmOrdProItensEstrut.objOrdPro            := objOrdPro;
    frmOrdProItensEstrut.edtProdutos.Text     := strCodIte;
    frmOrdProItensEstrut.edtDesProduto.Text   := strDesIte;
    frmOrdProItensEstrut.edtCodFab.Text       := fRetCodFabrica(strCodIte);
    frmOrdProItensEstrut.edtReferencia.Text   := fRetReferenciaProd(strCodIte);
    frmOrdProItensEstrut.edtUnidade.Text      := fRetUnidadeItem(strCodIte);
    frmOrdProItensEstrut.fltQtdApr            := objOrdPro.fltQtdAprox;
    frmOrdProItensEstrut.strCodPro            := strCodPro;
    frmOrdProItensEstrut.blnApenasValida      := blnApenasValida;
    frmOrdProItensEstrut.blnStateDataSetInsertEdit := False;
    frmOrdProItensEstrut.pnlTituloFase.Visible := True;
    frmOrdProItensEstrut.pnlTituloFase.Caption := 'Fase: ' + cbxFase.Text;
    frmOrdProItensEstrut.Caption := 'Incluindo sub produtos na fase ' + cbxFase.Text;
    frmOrdProItensEstrut.cdsSubProdJaVinculados := cdsSubProd;
    frmOrdProItensEstrut.strAutIncFase := strAutIncFase;

    If Not blnApenasCarregaOrdPro Then
    Begin
      frmOrdProItensEstrut.pChecaQuantProdutoDisponivel;
      if frmOrdProItensEstrut.PossuiSaldo Then
        frmOrdProItensEstrut.ShowModal;

    End;

    Result := frmOrdProItensEstrut.blnConfirma Or blnApenasCarregaOrdPro;
    If Result Then
      pCompletaCdsSubProdPelaEstrutura;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmOrdProdMonitoramento.fCarregaItensTmp]');
    End;
  End;

  pFreeAndNil(frmOrdProItensEstrut);

end;

procedure TfrmOrdProdMonitoramento.btnManMonClick(Sender: TObject);
begin
  inherited;

  If Not btnManMon.Enabled Then
    Exit;

  If fEmptyStr(objOrdPro.objMonitor.strIncOPI) Then
    Exit;

  pCriarFormularios(TfrmOrdProOperacoes, frmOrdProOperacoes);
  Try
    frmOrdProOperacoes.objOrdPro := objOrdPro;
    frmOrdProOperacoes.cdsSubProdutos := cdsSubProd;

    If objOrdPro.objMonitor.fCarregaOperacoes Then
      frmOrdProOperacoes.cxgOperacoesView.DataController.DataSource := objOrdPro.objMonitor.cdsOperacoes.dtsSource;

    frmOrdProOperacoes.ShowModal;
  Finally
    FreeAndNil(frmOrdProOperacoes);
  End;
end;

procedure TfrmOrdProdMonitoramento.edtCodBarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    qryTab: TUniQuery;
begin
  chrKey := '/';

  If fEntraCons(Key) Then
  Begin
    Key := #0;
    qryTab := fCriaQuery;
    Try
      If fPesqOrdemProd(conSimples, Self, nil, nil, qryTab, chrKey, arrSel, '', True, 'Consulta Ordens de Produção', 1) Then
      Begin
        edtCodBar.Text := qryTab.FieldByName('PRO_CODPRO').AsString;
        fValidaCampos(edtCodBar);
      End;
    Finally
      FreeAndNil(qryTab);
    End;
  End;
end;

procedure TfrmOrdProdMonitoramento.FormCreate(Sender: TObject);
begin
  inherited;
  objOrdPro := TOrdPro.Create(Self, False);
  pCriaCdsSubProdutos;
end;

procedure TfrmOrdProdMonitoramento.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objOrdPro);
  FreeAndNil(cdsSubProd);
end;

procedure TfrmOrdProdMonitoramento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F3: btnManMon.Click;
    VK_F4: btnIncluirSubprod.Click;
  End;

end;

procedure TfrmOrdProdMonitoramento.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodBar);
end;

procedure TfrmOrdProdMonitoramento.pCarreDadosOP;
Begin
  With objOrdPro Do
  Begin
    pLimpaTela;

    edtCodIte.Text := strCodIte;
    edtDesIte.Text := strDesIte;
    edtReferencia.Text := fRetReferenciaProd(strCodIte);
    edtSigUni.Text := fRetUnidadeItem(strCodIte);
    edtCodFabrica.Text := fRetCodFabrica(strCodIte);

    pnlBaixa.Enabled  := True;
    btnManMon.Enabled := True;
    btnIncluirSubprod.Enabled := True;

    pCarregaFases;
  End;
End;

procedure TfrmOrdProdMonitoramento.pCompletaCdsSubProdPelaEstrutura;
begin
  cdsSubProd.Filter := '';
  cdsSubProd.Filtered := False;
  cdsSubProd.EmptyDataSet;
  objOrdPro.cdsIteEst.First;
  While Not objOrdPro.cdsIteEst.Eof Do
  Begin
    pAtualizaCdsSubProdutos;
    objOrdPro.cdsIteEst.Next;
  End;
end;

procedure TfrmOrdProdMonitoramento.pCarregaFases;
Begin
  With objOrdPro.objMonitor.qryFases Do
  Begin
    cbxFase.Clear;

    First;
    while Not Eof do
    Begin
      cbxFase.Items.Add(FieldByName('FAS_CODIGO').AsString + ' -  ' + FieldByName('FAS_DESFAS').AsString);
      Next;
    End;

    cbxFase.ItemIndex := -1;
  End;
End;

procedure TfrmOrdProdMonitoramento.pLimpaTela(blnCodBar: Boolean = False);
Begin
  If blnCodBar Then
  Begin
    edtCodBar.Clear;
    btnManMon.Enabled := False;
    btnIncluirSubprod.Enabled := False;
    cdsSubProd.EmptyDataSet;
  End;

  edtDesIte.Clear;
  edtCodIte.Clear;
  edtDesite.Clear;
  edtCodFabrica.Clear;
  edtSigUni.Clear;
  edtReferencia.Clear;

  edtSenOpe.Clear;
  edtNomOpe.Clear;
  cbxFase.Clear;
  cbxSituacao.ItemIndex := -1;

  pnlBaixa.Enabled := False;

  strAutIncFase := '';

End;

function TfrmOrdProdMonitoramento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;
  blnMudarFoco := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodBar) Then
    Begin

      If fEmptyStr(edtCodBar.Text) Then
      Begin
        pLimpatela;
        pMensagemOk('Informe o Cógido de Barras da Ordem de Produção!');
        Result := False;
      End

      Else If blnBuscaPorChave Then
      Begin
        objOrdPro.fCarregaOrdPro(edtCodBar.Text);
        strAutIncOrdPro := objOrdPro.strAutInc;
        If objOrdPro.fCarregaOPMonitoramento(edtCodBar.Text) Then
        Begin
          objOrdPro.pCriaTemporaria(True, edtCodBar.Text, '');
          pCompletaCdsSubProdPelaEstrutura;
          pCarreDadosOP;

        End Else
        Begin
          pLimpaTela;
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtSenOpe) Then
    Begin
      strCodOpe      := fRetCodVendedor(edtSenOpe.Text);
      edtNomOpe.Text := fRetNomVendRep(strCodOpe);

      If fEmptyStr(edtNomOpe.Text) Then
      Begin
        pMensagemOk('Operador não encontrado!');
        Result := False;
        edtNomOpe.Clear;
      End;

    End
    Else If (Sender = cbxFase) Then
    Begin
      blnMudarFoco := False;
      pSetFocus(cbxSituacao);
    End
    Else If (Sender = cbxSituacao) Then
    Begin
      blnMudarFoco := False;
      pSetFocus(btnIncluirSubprod);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmOrdProdMonitoramento.pCriaCdsSubProdutos;
begin
  cdsSubProd := TUniClientDataSet.Create(Self);
  cdsSubProd.FieldDefs.Add('ITESUB', ftString, fTamCodIte);
  cdsSubProd.FieldDefs.Add('QTDITE', ftFloat);
  cdsSubProd.FieldDefs.Add('METRAG', ftFloat);
  cdsSubProd.FieldDefs.Add('SALDOS', ftFloat);
  cdsSubProd.FieldDefs.Add('QTDTOT', ftFloat);
  cdsSubProd.FieldDefs.Add('NUMLOT', ftString, 30);
  cdsSubProd.FieldDefs.Add('DESITE', ftString, 100);
  cdsSubProd.FieldDefs.Add('SEQFAS', ftString, 20);
  cdsSubProd.FieldDefs.Add('CODFAB', ftString, 50);
  cdsSubProd.FieldDefs.Add('SEQUEN', ftInteger);

  cdsSubProd.CreateDataSet;

  (cdsSubProd.FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos( fCfgSis('DECQTD', varInteger) );
end;

procedure TfrmOrdProdMonitoramento.pAtualizaCdsSubProdutos;
begin
  If cdsSubProd.Locate('ITESUB;SEQFAS', VarArrayOf([objOrdPro.cdsIteEst.FieldByName('ITESUB').AsString,strAutIncFase]), []) THen
    cdsSubProd.Edit
  Else
    cdsSubProd.Insert;

  cdsSubProd.FieldByName('ITESUB').AsString  := objOrdPro.cdsIteEst.FieldByName('ITESUB').AsString;
  cdsSubProd.FieldByName('QTDITE').AsFloat   := objOrdPro.cdsIteEst.FieldByName('QTDITE').AsFloat;
  cdsSubProd.FieldByName('METRAG').AsFloat   := objOrdPro.cdsIteEst.FieldByName('METRAG').AsFloat;
  cdsSubProd.FieldByName('NUMLOT').AsString  := objOrdPro.cdsIteEst.FieldByName('NUMLOT').AsString;
  cdsSubProd.FieldByName('DESITE').AsString  := objOrdPro.cdsIteEst.FieldByName('DESITE').AsString;
  cdsSubProd.FieldByName('QTDTOT').AsFloat   := objOrdPro.cdsIteEst.FieldByName('QTDTOT').AsFloat;
  cdsSubProd.FieldByName('SALDOS').AsFloat   := objOrdPro.cdsIteEst.FieldByName('SALDOS').AsFloat;
  cdsSubProd.FieldByName('CODFAB').AsString  := objOrdPro.cdsIteEst.FieldByName('CODFAB').AsString;
  cdsSubProd.FieldByName('SEQUEN').AsInteger := objOrdPro.cdsIteEst.FieldByName('SEQUEN').AsInteger;
  If fEmptyStr(strAutIncFase) Then
    cdsSubProd.FieldByName('SEQFAS').AsString  := objOrdPro.cdsIteEst.FieldByName('SEQFAS').AsString
  Else
    cdsSubProd.FieldByName('SEQFAS').AsString  := strAutIncFase;
  cdsSubProd.Post;
end;

end.
