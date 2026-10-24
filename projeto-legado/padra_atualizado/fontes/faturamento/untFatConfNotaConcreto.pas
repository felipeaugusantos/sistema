
unit untFatConfNotaConcreto;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus,
  Grids, DBGridCitel, DBGrids, Menus, ComCtrls, Buttons, ExtCtrls, DB, {Qt,} untFuncFat,
  StrUtils, Uni, AppEvnts, Math, BitBtnLockedIncrem, untConfNotaConcreto,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatConfNotaConcreto = class(TfrmPaiSimples)
    pnlAux2: TPanel;
    dbgDocumentos: TDBGridCitel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    btnItensDoc: TBitBtnLocked;
    btnSairConf: TBitBtnLocked;
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    edtQtdDoc: TEditFocus;
    edtTotGer: TEditFocus;
    edtQtdDocSel: TEditFocus;
    edtTotGerSel: TEditFocus;
    edtNomCli: TEditFocus;
    lblDtaIni: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblDtaFin: TLabel;
    lblCliFat: TLabel;
    edtCliFat: TEditFocus;
    edtNomCliFat: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure btnSairConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgDocumentosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbgDocumentosDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnItensDocClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCliFatKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    qryConCli: TUniQuery;

    blnFecharForm: Boolean;
    qryCliFat: TUniQuery;

    intAdicionando: Integer;

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pCarregaCliente;

    procedure pCarregaItensDocumento;
    procedure pMarcaDocumento(blnMarcar: Boolean);
    procedure pAtualizaTotais;

    procedure pDeletaDocDesmarcados;
    procedure pCarregaNovoCliente;
    procedure pSetaVariaveisConfirmacao;

    procedure pCarregaGrid;
    procedure pCarregaProfissionaisDoPedidoDeVenda;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    fatVenda: TFatVenda;
    objConfNotaConcreto: TConfirmacaoNotaConcreto;
  end;

var
  frmFatConfNotaConcreto: TfrmFatConfNotaConcreto;

implementation

uses untfuncoesSimples, untPesqAux, untConsultas, untPai, System.UITypes, untTypesSistema,
  untConstantes;

{$R *.dfm}

procedure TfrmFatConfNotaConcreto.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatConfNotaConcreto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  function fCarregarDocumentos: Boolean;
  begin
    Result := fValidaPanel(pnlCabecalho);

    If Result Then
    Begin
      pCarregaGrid;

      If  objConfNotaConcreto.blnSemNotasParaConfirmar Then
      Begin
        fMensagem('ATENÇÃO!', 'Não há documentos para confirmar!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        blnMudarFoco := False;
        pSetFocus(dbgDocumentos);
      End;
    End;
  end;

begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin

      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
          objConfNotaConcreto.strCodigoCliente := edtCodCli.Text;
      End;

    End

    Else If (Sender = edtCliFat) Then
    Begin
      If (fEmptyStr(edtCliFat.Text)) Then
      Begin
        edtCliFat.Text := edtCodCli.Text;
        pCarregaNovoCliente;
      End
      Else
      Begin
        pCarregaNovoCliente;
        If (qryCliFat.IsEmpty) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

      If Result And blnBuscaPorChave And Not mskDtaFin.Visible Then
        Result := fCarregarDocumentos;
    End

    {***********************}
    {* VALIDA DATA INICIAL *}
    {********************JB*}
    Else If (Sender = mskDtaIni) And mskDtaIni.Visible Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
        objConfNotaConcreto.dtaDataInicial := strToDateDef(mskDtaIni.Text, 0);      
    End

    {*********************}
    {* VALIDA DATA FINAL *}
    {******************JB*}
    Else If (Sender = mskDtaFin) And mskDtaFin.Visible Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Not (fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data Final deve ser maior ou igual a Data Inicial!', ['&O k']);
        Result := False;
      End
      Else
        objConfNotaConcreto.dtaDataFinal := strToDateDef(mskDtaFin.Text, 0);

      If Result And blnBuscaPorChave Then
        Result := fCarregarDocumentos;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmFatConfNotaConcreto.pAtualizaTemporaria;
begin
  objConfNotaConcreto.pAtualizaTemporariaConfirmacao;
end;

procedure TfrmFatConfNotaConcreto.pCriaTemporaria;
begin
  objConfNotaConcreto.pCriaTemporariaConfirmacao;
  pAtualizaTotais;
end;

procedure TfrmFatConfNotaConcreto.pDeletaTemporaria;
begin
  objConfNotaConcreto.pDeletaTemporariaConfirmacao;
end;

procedure TfrmFatConfNotaConcreto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Not blnConfirma Then
  Begin
    fatVenda.objLock.pDestravarTodos;
  End;
  
end;

procedure TfrmFatConfNotaConcreto.FormCreate(Sender: TObject);
begin
  inherited;

  intAdicionando          := -1;

  blnConfirma             := False;
  blnFecharForm           := False;
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);

end;

procedure TfrmFatConfNotaConcreto.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  edtNomCli.Text := qryConCli.FieldbyName('CLI_NOMCLI').AsString;
end;

procedure TfrmFatConfNotaConcreto.dbgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    If fMensagem('', 'Abandona?', ['&Sim', '&Não']) = 1 Then
    Begin
      pDeletaTemporaria;
      Close;
    End;
  End
  Else If (Key = VK_Return) Then
  Begin
    If fatVenda.qryTemporariaConfirmacao.Active Then
      pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
  End
  Else If (Key = VK_F5) Then
  Begin
    btnItensDoc.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmFatConfNotaConcreto.pMarcaDocumento(blnMarcar: Boolean);
begin
  objConfNotaConcreto.fMarcaDocumento(blnMarcar);
  pAtualizaTotais;
end;

procedure TfrmFatConfNotaConcreto.pSetaVariaveisConfirmacao;
begin
  objConfNotaConcreto.pSetaVariaveisConfirmacao;
end;

procedure TfrmFatConfNotaConcreto.dbgDocumentosDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If FieldByName('TMP_MARDES').AsString = 'M' Then
    Begin
      dbgDocumentos.Canvas.Font.Color := clBlue;
    End;

    If dbgDocumentos.Canvas.Brush.Color = clHighLight Then
    Begin
      dbgDocumentos.Canvas.Brush.Color := clLtGray;
    End;

  End;

  dbgDocumentos.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmFatConfNotaConcreto.dbgDocumentosDblClick(Sender: TObject);
begin
  inherited;
  pMarcaDocumento(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString <> 'M');
end;

procedure TfrmFatConfNotaConcreto.FormShow(Sender: TObject);
begin
  inherited;
  
  dbgDocumentos.DataSource := fatVenda.dtsTemporariaConfirmacao;
  edtCodCli.Text           := fatVenda.strCodCli;
  pCarregaCliente;

  qryCliFat := fCriaQuery(Self);
  qryCliFat.SQL.Add('SELECT * FROM CADCLI WHERE CLI_CODCLI = :CODCLI');

  pSetFocus(mskDtaIni);
  edtCliFat.Text := edtCodCli.Text;

  If (fCfgSis('TRCLCC') <> 'S') Then
  Begin
    lblCliFat.Visible    := False;
    edtCliFat.Visible    := False;
    edtNomCliFat.Visible := False;
  End
  Else
  Begin
    pSetFocus(edtCliFat);
  End;

  If (MatchStr(fCfgSis('TPNFCR'), [SECOL, J_A_MASSA_CONCRETO])) Then
  Begin
    lblDtaIni.Visible   := False;
    lblDtaFin.Visible   := False;
    mskDtaIni.Visible   := False;
    mskDtaFin.Visible   := False;
    pnlCabecalho.Height := pnlCabecalho.Height - mskDtaIni.Height;
  End
  Else
  Begin
    fFindColumnByName(dbgDocumentos, 'TMP_NUM_PD').Visible := False;
    fFindColumnByName(dbgDocumentos, 'TMP_ESP_PD').Visible := False;
    fFindColumnByName(dbgDocumentos, 'TMP_EMP_PD').Visible := False;
  End;
  
end;

procedure TfrmFatConfNotaConcreto.pAtualizaTotais;
begin
  edtQtdDoc.Text := objConfNotaConcreto.strQuantidadeDocumentos;
  edtTotGer.Text := objConfNotaConcreto.strTotalGeral;

  edtQtdDocSel.Text := objConfNotaConcreto.strQuantidadeDocumentosSelecionados;
  edtTotGerSel.Text := objConfNotaConcreto.strTotalGeralSelecionados;
end;

procedure TfrmFatConfNotaConcreto.pCarregaItensDocumento;
begin
  objConfNotaConcreto.pExibirProdutosDocumento;
end;

procedure TfrmFatConfNotaConcreto.btnItensDocClick(Sender: TObject);
begin
  inherited;

  pCarregaItensDocumento;
  pSetFocus(dbgDocumentos);

end;

procedure TfrmFatConfNotaConcreto.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not fValidaCampos(edtCliFat, False)) Then
    Exit;

  If StrToInt(edtQtdDocSel.Text) <= 0 Then
  Begin
    fMensagem('', 'É necessário escolher pelo menos um documento!', ['&O k']);
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If (fStrToFloat(edtTotGerSel.Text) < 0.0) Then
  Begin
    fMensagem('', 'Não é possivel confirmar um valor negativo!', ['&O k']);
    pSetFocus(dbgDocumentos);
    Exit;
  End;

  If fMensagem('', 'Confirma documentos?', ['&Sim', '&Não']) = 1 Then
  Begin

    pDeletaDocDesmarcados;
    pAtualizaTemporaria;  
    pSetaVariaveisConfirmacao;
    pCarregaProfissionaisDoPedidoDeVenda;
    blnConfirma := True;
    Close;

  End;

end;

{*****************************************}
{* APAGA DOCUMENTOS QUE NAO ESTÃO SELE-  *}
{* CIONADOS                              *}
{**************************************MV*}
procedure TfrmFatConfNotaConcreto.pDeletaDocDesmarcados;
begin
  objConfNotaConcreto.pDeletaNotasDesmarcados;
end;

procedure TfrmFatConfNotaConcreto.FormActivate(Sender: TObject);
begin
  inherited;

  {*****************************************}
  {* CASO NÃO TENHA NENHUM DOCUMENTO, SAI  *}
  {**************************************MV*}
  If blnFecharForm Then
  Begin
    fMensagem('', 'Não há documentos para esse cliente!', ['&O k']);
    Self.Close;
  End;

end;

procedure TfrmFatConfNotaConcreto.pCarregaNovoCliente;
begin

  qryCliFat.Close;
  qryCliFat.ParamByName('CODCLI').AsString := edtCliFat.Text;
  qryCliFat.Open;
  edtNomCliFat.Text := qryCliFat.FieldByName('CLI_NOMCLI').AsString;

end;

procedure TfrmFatConfNotaConcreto.pCarregaProfissionaisDoPedidoDeVenda;
begin
  objConfNotaConcreto.pCarregaProfissionaisDoPedidoDeVenda;
end;

procedure TfrmFatConfNotaConcreto.edtCliFatKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCliFat, edtNomCliFat, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCliFat, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConfNotaConcreto.pCarregaGrid;
begin
  If InterlockedIncrement(intAdicionando) = 0 Then
  Begin

    Try

      pCriaTemporaria;
      pAtualizaTemporaria;

      InterlockedDecrement(intAdicionando);

    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intAdicionando);
        pMensagensErro(E.Message, '[frmFatConfNotaConcreto.chkCupEsp]');
      End;
    End;

  End
  Else
    InterlockedDecrement(intAdicionando)

end;

end.

