unit untMapeamentoItemClasseLocFis;

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
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmMapeamentoItemClasseLocFis = class(TfrmPaiConfirma)
    pnlItem: TPanel;
    cxgMapaLevel: TcxGridLevel;
    cxgMapaTableView: TcxGridDBTableViewCitel;
    cxgMapa: TcxGridCitel;
    Label7: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label10: TLabel;
    edtRefere: TEditFocus;
    Bevel1: TBevel;
    Label11: TLabel;
    edtClaLoc: TEditFocus;
    edtCxCama: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    edtQtCama: TEditFocus;
    Label3: TLabel;
    edtQtdTot: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    cxgMapaTableViewColumn1: TcxGridDBColumn;
    cxgMapaTableViewColumn2: TcxGridDBColumn;
    cxgMapaTableViewColumn3: TcxGridDBColumn;
    cxgMapaTableViewColumn4: TcxGridDBColumn;
    procedure edtClaLocKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgMapaTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private    cdsMapa : TZClient;

    procedure pEnableClasse(blnEnabled : Boolean);
    function fAbreDados : Boolean;
    function fGravaDados(cxProgress: TcxProgressBar): Boolean;
    procedure pReseta;
    procedure pCarregaDadosEdicao;
    procedure pDeletaMapeamento;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untGravando;

procedure TfrmMapeamentoItemClasseLocFis.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If fValidaCampos(edtClaLoc, True) And
     fValidaCampos(edtCxCama, True) And
     fValidaCampos(edtQtCama, True) Then
  Begin
    If cdsMapa.Locate('CIT_SIGLA_', edtClaLoc.Text, []) Then
      cdsMapa.Edit
    Else
      cdsMapa.Append;

    cdsMapa.FieldByName('CIT_CODEMP').AsString  := VS_strCodEmp;
    cdsMapa.FieldByName('CIT_CODITE').AsString  := edtCodIte.Text;
    cdsMapa.FieldByName('CIT_SIGLA_').AsString  := edtClaLoc.Text;
    cdsMapa.FieldByName('CIT_CXCAMA').AsInteger := StrToInt(edtCxCama.Text);
    cdsMapa.FieldByName('CIT_QTCAMA').AsInteger := StrToInt(edtQtCama.Text);
    cdsMapa.FieldByName('CIT_QTDTOT').AsInteger := StrToInt(edtQtdTot.Text);

    cdsMapa.Post;

    edtClaLoc.Clear;
    edtCxCama.Clear;
    edtQtCama.Clear;
    edtQtdTot.Clear;

    pSetFocus(edtClaLoc);

  End;

end;

procedure TfrmMapeamentoItemClasseLocFis.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  edtClaLoc.Clear;
  edtCxCama.Clear;
  edtQtCama.Clear;
  edtQtdTot.Clear;

  pSetFocus(edtClaLoc);
end;

procedure TfrmMapeamentoItemClasseLocFis.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;

  if not fVerificaCampos Then
    Exit;

  If (not cdsMapa.Active) or (fEmptyStr(edtCodIte.Text)) Then
  Begin
    fMensagem('', 'Carregue um Item para Salvar o Mapeamento!', ['&OK']);
    Exit;
  End;

  if (cdsMapa.RecordCount <= 0) Then
  Begin
    fMensagem('', 'Informe as classes de local antes de salvar!', ['&OK']);
    Exit;
  End;


  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaDados;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando)
  End;

end;

procedure TfrmMapeamentoItemClasseLocFis.cxgMapaTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pCarregaDadosEdicao;
    Key := 0;
  End
  Else
  If (Key = VK_DELETE) Then
  Begin
    pDeletaMapeamento;
    Key := 0;
  End;
end;

function TfrmMapeamentoItemClasseLocFis.fGravaDados(cxProgress : TcxProgressBar) : Boolean;
Begin
  Result := True;
  Try
    cdsMapa.DisableControls;
    cdsMapa.First;

    cxProgress.pSetMax(cdsMapa.RecordCount);

    Try
      While Not cdsMapa.Eof Do
      Begin
        cxProgress.pStep;

        If fEmptyStr(cdsMapa.FieldByName('AUTOINCREM').AsString) Then
        Begin
          cdsMapa.Edit;
          cdsMapa.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLAITE', VS_strCodEmp);
          cdsMapa.Post;
        End;
        cdsMapa.Next;
      End;

      Result := cdsMapa.fSalva;
    Except
      On E : Exception Do
      Begin
        Result := False;
        pMensagensErro(e.Message, 'TfrmMapeamentoItemClasseLocFis.fGravaDados');
      End;
    End;

  Finally
    cdsMapa.First;
    cdsMapa.EnableControls;

    If Result Then
      pReseta;
  End;

End;

procedure TfrmMapeamentoItemClasseLocFis.edtClaLocKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClaLoc : TConsultasArray;
begin
  inherited;
  If fPesqClasseLocFis(Self, edtClaLoc, Nil, Key, arrClaLoc) Then
  Begin
    If (fValidaCampos(edtClaLoc, True)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmMapeamentoItemClasseLocFis.edtCodIteKeyPress(Sender: TObject; var Key: Char);
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

function TfrmMapeamentoItemClasseLocFis.fAbreDados: Boolean;
begin
  If cdsMapa.Active Then
    cdsMapa.EmptyDataSet;

  cdsMapa.qryQuery.Close;
  cdsMapa.qryQuery.ParamByName('CODITE').AsString := edtCodIte.Text;
  cdsMapa.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  Result := cdsMapa.fAbreClient(True, 'TfrmMapeamentoItemClasseLocFis.fAbreDados');

  cxgMapaTableView.DataController.DataSource := cdsMapa.dtsSource;
end;

procedure TfrmMapeamentoItemClasseLocFis.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (cdsMapa.Active) And (not cdsMapa.IsEmpty) Then
  Begin
    Action := caNone;
    If fMensagem('', 'Deseja Cancelar?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      cdsMapa.EmptyDataSet;
      pReseta;
    End;
  End;

end;

procedure TfrmMapeamentoItemClasseLocFis.FormCreate(Sender: TObject);
begin
  inherited;
  pSetaCodIte(edtCodIte);
  cdsMapa := TZClient.Create(Self, 'SELECT * FROM CLAITE WHERE CIT_CODITE = :CODITE AND CIT_CODEMP = :CODEMP ');
end;

function TfrmMapeamentoItemClasseLocFis.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin
    If (Sender = edtCodIte) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodIte.Text) Then
      Begin
        Result := fMensagem('', 'Informe o Código do Item Para Realizar o Mapeamento!', ['&OK']) = -1;
      End
      Else
      Begin
        edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
        edtRefere.Text := fRetReferenciaProd(edtCodIte.Text);

        If fEmptyStr(edtDesIte.Text) Then
          Result := fMensagem('', 'Produto não Encontrado!', ['&OK']) = -1
        Else If fAbreDados Then
        Begin
          pEnableClasse(True);
          edtCodIte.Enabled := False;
        End;

      End;

    End

    Else If (Sender = edtClaLoc) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtClaLoc.Text) And (cdsMapa.RecordCount > 0) Then
      Begin
        pSetFocus(cxgMapa);
        blnMudarFoco := False;
      End
      Else
      Begin
        If fEmptyStr( fCampoTabela('AUTOINCREM', 'CLASSE', ['CLA_SIGLA_', 'CLA_CODEMP'], [edtClaLoc.Text, VS_strCodEmp]) ) Then
        Begin
          Result := fMensagem('', 'Classe de Localização Física não Encontrada', ['&OK']) = -1;
        End;
      End;

    End

    Else If ((Sender = edtCxCama) Or (Sender = edtQtCama)) And blnBuscaPorChave Then
    Begin
      If (StrToIntDef(TEditFocus(Sender).Text, -1) < 1) Then
      Begin
        Result := fMensagem('', 'A Quantidade deve ser maior ou igual a 1', ['&OK']) = -1;
      End;

      If Result And (StrToIntDef(edtCxCama.Text, -1) > 0) And (StrToIntDef(edtQtCama.Text, -1) > 0) Then
        edtQtdTot.Text := IntToStr(StrToIntDef(edtCxCama.Text, -1) * StrToIntDef(edtQtCama.Text, -1));

    End;


  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmMapeamentoItemClasseLocFis.pEnableClasse(blnEnabled: Boolean);
begin
  edtClaLoc.Enabled := blnEnabled;
  edtQtCama.Enabled := blnEnabled;
  edtCxCama.Enabled := blnEnabled;
  btnAdicionar.Enabled := blnEnabled;
  btnCancelaItem.Enabled := blnEnabled;
end;

procedure TfrmMapeamentoItemClasseLocFis.pReseta;
Begin
  if cdsMapa.Active Then
    cdsMapa.EmptyDataSet;

  edtCodIte.Clear;
  edtDesIte.Clear;
  edtRefere.Clear;

  edtClaLoc.Clear;
  edtCxCama.Clear;
  edtQtCama.Clear;
  edtQtdTot.Clear;

  edtCodIte.Enabled := True;
  pEnableClasse(False);
  pSetFocus(edtCodIte);

End;

procedure TfrmMapeamentoItemClasseLocFis.pCarregaDadosEdicao;
Begin
  edtClaLoc.Text := cdsMapa.FieldByName('CIT_SIGLA_').AsString;
  edtCxCama.Text := cdsMapa.FieldByName('CIT_CXCAMA').AsString;
  edtQtCama.Text := cdsMapa.FieldByName('CIT_QTCAMA').AsString;
  edtQtdTot.Text := cdsMapa.FieldByName('CIT_QTDTOT').AsString;
  pSetFocus(edtClaLoc);
End;

procedure TfrmMapeamentoItemClasseLocFis.pDeletaMapeamento;
Begin
  If fPergunta('Deseja Excluir esse Mapeamento?') Then
  Begin
    cdsMapa.Delete;
    pSetFocus(edtClaLoc);
  End;

End;

end.
