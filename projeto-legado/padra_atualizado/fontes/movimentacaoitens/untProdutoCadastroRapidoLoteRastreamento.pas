unit untProdutoCadastroRapidoLoteRastreamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, untZClient,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxProgressBar,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, EditFocus, untHelperCitel,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxLabel, MemDS,
  DBAccess, Uni;

type
  TfrmProdutoCadastroRapidoLoteRastreamento = class(TfrmPaiConfirma)
    cxgLotRasLevel: TcxGridLevel;
    cxgLotRasTableView: TcxGridDBTableViewCitel;
    cxgLotRas: TcxGridCitel;
    cxgLotRasTableViewNUMLOT: TcxGridDBColumn;
    pnlLegenda: TPanel;
    lblLegendaDelete: TLabel;
    pnlLoteRastreamento: TPanel;
    Label11: TLabel;
    edtLoteRastreamento: TEditFocus;
    pnlDadosItem: TPanel;
    Label7: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    lbl2: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgLotRasTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
  private
    cdsLotRas : TZClient;

    procedure pEnableLote(blnEnabled : Boolean);
    function fAbreDados : Boolean;
    function fGravaDados(cxProgress: TcxProgressBar): Boolean;
    procedure pReseta;
    procedure pDeletaLote;
    procedure pLimpaLote;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untGravando;


procedure TfrmProdutoCadastroRapidoLoteRastreamento.pLimpaLote;
begin
  edtLoteRastreamento.Clear;
end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;

  If (not cdsLotRas.Active) or (cdsLotRas.isEmpty) or fEmptyStr(edtCodIte.Text) or fEmptyStr(edtCodFor.Text) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaDados;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando)
  End;

end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.btnSairClick(Sender: TObject);
begin
  if not fEmptyStr(edtCodIte.Text) then
  begin
    ModalResult := mrNone;
    pReseta;
  end
  else
    inherited;

end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.cxgLotRasTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    pDeletaLote;
    Key := 0;
  End;
end;

function TfrmProdutoCadastroRapidoLoteRastreamento.fGravaDados(cxProgress : TcxProgressBar) : Boolean;
Begin
  Result := True;
  Try
    cdsLotRas.DisableControls;
    cdsLotRas.First;

    cxProgress.pSetMax(cdsLotRas.RecordCount);

    Try
      While Not cdsLotRas.Eof Do
      Begin
        cxProgress.pStep;

        If fEmptyStr(cdsLotRas.FieldByName('AUTOINCREM').AsString) Then
        Begin
          cdsLotRas.Edit;
          cdsLotRas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LOTRAS', VS_strCodEmp);
          cdsLotRas.Post;
        End;
        cdsLotRas.Next;
      End;

      Result := cdsLotRas.fSalva;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(e.Message, 'TfrmCadastroProdutoLoteRastreamento.fGravaDados');
      End;
    End;

  Finally
    cdsLotRas.First;
    cdsLotRas.EnableControls;

    If Result Then
      pReseta;
  End;

End;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCodFor : TConsultasArray;
begin
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor, False) Then
    If fValidaCampos(edtCodFor, True) then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.edtCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCadIte : TConsultasArray;
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrCadIte) Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmProdutoCadastroRapidoLoteRastreamento.fAbreDados: Boolean;
begin
  If cdsLotRas.Active Then
    cdsLotRas.EmptyDataSet;

  cdsLotRas.qryQuery.Close;
  cdsLotRas.qryQuery.ParamByName('CODITE').AsString := edtCodIte.Text;
  cdsLotRas.qryQuery.ParamByName('CODFOR').AsString := edtCodFor.Text;
  Result := cdsLotRas.fAbreClient(True, 'TfrmCadastroProdutoLoteRastreamento.fAbreDados');

  cxgLotRasTableView.DataController.DataSource := cdsLotRas.dtsSource;
end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (cdsLotRas.Active) And (not cdsLotRas.IsEmpty) Then
  Begin
    Action := caNone;
    If fMensagem('', 'Deseja Cancelar?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      cdsLotRas.EmptyDataSet;
      pReseta;
    End;
  End;

end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.FormCreate(Sender: TObject);
begin
  inherited;

  pSetaCodIte(edtCodIte);

  cdsLotRas := TZClient.Create(Self);
  cdsLotRas.qryQuery.SQL.Add('SELECT                                               ');
  cdsLotRas.qryQuery.SQL.Add('  *                                                  ');
  cdsLotRas.qryQuery.SQL.Add('FROM                                                 ');
  cdsLotRas.qryQuery.SQL.Add('  LOTRAS                                             ');
  cdsLotRas.qryQuery.SQL.Add('  LEFT JOIN MOVRAS ON MOV_SEQLOT = LOTRAS.AUTOINCREM ');
  cdsLotRas.qryQuery.SQL.Add('WHERE                                                ');
  cdsLotRas.qryQuery.SQL.Add('      LOT_CODITE = :CODITE                           ');
  cdsLotRas.qryQuery.SQL.Add('  AND LOT_CODFOR = :CODFOR                           ');
  cdsLotRas.qryQuery.SQL.Add('  AND MOVRAS.AUTOINCREM IS NULL                      ');
end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F10 : btnConfirma.Click;
  end;
end;

function TfrmProdutoCadastroRapidoLoteRastreamento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodIte) Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        Result := fMensagem('', 'Informe o Código do Item!', ['&OK']) = -1;
      End
      Else if blnBuscaPorChave then
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

      If Result and fEmptyStr(edtDesIte.Text) Then
        Result := fMensagem('', 'Produto não Encontrado!', ['&OK']) = -1 ;
    End

    else If (Sender = edtCodFor) Then
    begin
      edtNomFor.Clear;
      if fEmptyStr(edtCodFor.Text) then
        Result := fMensagem('', 'Informe o Código do Fornecedor!', ['&OK']) = -1
      else
      begin
        if blnBuscaPorChave then
          edtNomFor.text := fRetNomFornecedor(edtCodFor.Text);

        if edtNomFor.Text = '' then
          Result := fMensagem('', 'Fornecedor não encontrado!', ['&OK']) = -1
        else if blnBuscaPorChave and fValidaCampos(edtCodIte, False) then
        begin
          If fAbreDados Then
            pEnableLote(True);
        end;
      end;
    end

    Else If (Sender = edtLoteRastreamento)  Then
    Begin

      If fEmptyStr(edtLoteRastreamento.Text) Then
      Begin
        Result := fMensagem('', 'Informe o Lote de Rastreamento!', ['&OK']) = -1;
        blnMudarFoco := False;
      End
      Else
      Begin

        if fCampoTabela('COUNT(0)', 'LOTRAS', ['LOT_CODITE', 'LOT_CODFOR', 'LOT_NUMLOT'], [edtCodIte.Text, edtCodFor.Text, edtLoteRastreamento.Text]) > 0 then
          Result := fMensagem('', 'Lote já cadastrado!', ['&OK']) = -1
        else
        begin

          cdsLotRas.Append;
          cdsLotRas.FieldByName('LOT_CODITE').AsString  := edtCodIte.Text;
          cdsLotRas.FieldByName('LOT_CODFOR').AsString  := edtCodFor.Text;
          cdsLotRas.FieldByName('LOT_NUMLOT').AsString  := edtLoteRastreamento.Text;
          cdsLotRas.Post;

          pLimpaLote;
          blnMudarFoco := False;
          pSetFocus(edtLoteRastreamento);
        end;

      End;

    End;
  end;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.pEnableLote(blnEnabled: Boolean);
begin
  pnlDadosItem.Enabled := not blnEnabled;
  pnlLoteRastreamento.Enabled := blnEnabled;
  btnConfirma.Enabled := blnEnabled;

  blnMudarFoco := False;

  if blnEnabled then
    pSetFocus(edtLoteRastreamento)
  else
    pSetFocus(edtCodIte);

end;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.pReseta;
Begin
  if cdsLotRas.Active Then
    cdsLotRas.EmptyDataSet;

  edtCodIte.Clear;
  edtDesIte.Clear;

  edtCodFor.Clear;
  edtNomFor.Clear;

  pLimpaLote;

  pEnableLote(False);


End;

procedure TfrmProdutoCadastroRapidoLoteRastreamento.pDeletaLote;
Begin
  if (not cdsLotRas.Active) or (cdsLotRas.IsEmpty) then
    exit;

  If fPergunta('Deseja Excluir este Lote de Rastreamento?') Then
    cdsLotRas.Delete;

End;

end.
