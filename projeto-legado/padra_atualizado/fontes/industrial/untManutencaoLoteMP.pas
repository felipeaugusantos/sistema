unit untManutencaoLoteMP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, untZClient,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls, Uni,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxProgressBar, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, untGravando, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmManutencaoLoteMP = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    Label3: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label1: TLabel;
    edtLotAtu: TEditFocus;
    edtLotNovo: TEditFocus;
    Label2: TLabel;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    cxgCadIteLevel1: TcxGridLevel;
    cxgCadIteTableView: TcxGridDBTableViewCitel;
    cxgCadIte: TcxGridCitel;
    cxgCadIteTableViewColumn1: TcxGridDBColumn;
    cxgCadIteTableViewColumn2: TcxGridDBColumn;
    cxgCadIteTableViewColumn3: TcxGridDBColumn;
    cxgCadIteTableViewColumn4: TcxGridDBColumn;
    Label4: TLabel;
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure cxgCadIteTableViewDblClick(Sender: TObject);
    procedure cxgCadIteTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    cdsDados : TZClient;

    procedure pLimpaEdits;
    procedure pCarregaEdicao;

    function fGetSQL : String;
    function fGrava(cxProgress: TcxProgressBar): Boolean;
  public
    { Public declarations }
  published
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmManutencaoLoteMP }

procedure TfrmManutencaoLoteMP.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    If cdsDados.Locate('ITE_CODITE', edtCodIte.Text, []) Then
      cdsDados.Edit
    Else
      cdsDados.Insert;

    cdsDados.FieldByName('ITE_CODITE').AsString := edtCodIte.Text;
    cdsDados.FieldByName('ITE_DESITE').AsString := edtDesIte.Text;
    cdsDados.FieldByName('ITE_LOT_MP').AsString := edtLotAtu.Text;
    cdsDados.FieldByName('NEW_LOT_MP').AsString := edtLotNovo.Text;
    cdsDados.Post;

    pLimpaEdits;

  End;
end;

procedure TfrmManutencaoLoteMP.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits;
end;

procedure TfrmManutencaoLoteMP.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  If fMensagem('','Deseja atualizar todos os lotes?', ['&Sim', '&Não']) = 2 Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGrava;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

  pLimpaEdits;
  fMensagem('', 'Lotes atualizados com sucesso!', ['&Ok']);

end;

function TfrmManutencaoLoteMP.fGrava(cxProgress : TcxProgressBar):Boolean;
  Var
    qryUpdate : TUniQuery;
Begin
  Try
    Result := True;
    qryUpdate := fCriaQuery;
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add( ' UPDATE CADITE SET ITE_LOT_MP = :LOT_MP ');
      Add( ' WHERE ITE_CODITE = :CODITE             ');
    End;

    cxProgress.Properties.Max := cdsDados.RecordCount;
    cdsDados.First;
    cdsDados.DisableControls;
    While Not cdsDados.Eof Do
    Begin
      qryUpdate.ParamByName('CODITE').AsString := cdsDados.FieldByName('ITE_CODITE').AsString;
      qryUpdate.ParamByName('LOT_MP').AsString := cdsDados.FieldByName('NEW_LOT_MP').AsString;
      qryUpdate.ExecSQL;

      cdsDados.Next;
    End;

  Finally
    cdsDados.EmptyDataSet;
    cdsDados.EnableControls;
    FreeAndNil(qryUpdate);
  End;

End;

procedure TfrmManutencaoLoteMP.cxgCadIteTableViewDblClick(Sender: TObject);
begin
  inherited;
  pCarregaEdicao;
end;

procedure TfrmManutencaoLoteMP.cxgCadIteTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_Return Then
    pCarregaEdicao
  Else
  If Key = VK_Delete Then
  Begin
    If Not cdsDados.IsEmpty Then
    Begin
      If (fMensagem('','Deseja excluir alteração?', ['&Sim', '&Não'], 2) = 1) Then
        cdsDados.Delete;
    End;
  End;
end;

procedure TfrmManutencaoLoteMP.pCarregaEdicao;
Begin
  edtCodIte.Text  := cdsDados.FieldByName('ITE_CODITE').AsString;
  edtDesIte.Text  := cdsDados.FieldByName('ITE_DESITE').AsString;
  edtLotAtu.Text  := cdsDados.FieldByName('ITE_LOT_MP').AsString;
  edtLotNovo.Text := cdsDados.FieldByName('NEW_LOT_MP').AsString;
  pSetFocus(edtLotNovo);
  edtLotNovo.SelectAll;
End;

procedure TfrmManutencaoLoteMP.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;
  If fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, Nil, Key, arrSel, True, nil, 'Cosulta de matéria prima', '1',
               '', 0,False,False, 0,cdrCodIte,'',FAlse, '', '',true,False, true, '', True ) Then
  Begin
    If fValidaCampos(edtCodIte, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmManutencaoLoteMP.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT ITE_CODITE,               ';
  Result := Result + '        ITE_DESITE,               ';
  Result := Result + '        ITE_LOT_MP,               ';
  Result := Result + '        ITE_LOT_MP AS NEW_LOT_MP  ';
  Result := Result + ' FROM CADITE                      ';
  Result := Result + ' WHERE FALSE                      ';
end;

procedure TfrmManutencaoLoteMP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If cdsDados.RecordCount > 0 Then
  Begin
    if fMensagem('', 'Deseja sair sem atualizar os lotes digitados?', ['&Sim', '&Não'],2)=2 Then
      Action := caNone;
  End;
end;

procedure TfrmManutencaoLoteMP.FormCreate(Sender: TObject);
begin
  inherited;
  cdsDados := TZClient.Create(Self, fGetSQL);
  cdsDados.fAbreClient(True, 'TfrmManutencaoLoteMP.FormCreate');
  cxgCadIteTableView.DataController.DataSource := cdsDados.dtsSource;
  pSetaCodIte(edtCodIte);

end;

function TfrmManutencaoLoteMP.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtCodIte) Then
    Begin
      edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
      If fEmptyStr(edtDesIte.Text) Then
      Begin
        Result := False;
        fMensagem('','Matéria prima não cadastrada!', ['&Ok']);
      End
      Else
      Begin
        Result := fEhMateriaPrima(edtCodIte.Text);
        If Not Result Then
          fMensagem('','O produto selecionado não é uma matéria prima!', ['&Ok'])
        Else
        Begin
          edtLotAtu.Text := fCampoTabela('ITE_LOT_MP', 'CADITE', ['ITE_CODITE'], [edtCodIte.Text]);
          if blnBuscaPorChave And cdsDados.Locate('ITE_CODITE', edtCodIte.Text, []) Then
          Begin
            blnMudarFoco := False;
            pCarregaEdicao;
          End;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmManutencaoLoteMP.pLimpaEdits;
begin
  edtCodIte.Clear;
  edtDesIte.Clear;
  edtLotAtu.Clear;
  edtLotNovo.Clear;
  pSetFocus(edtCodIte);

end;

end.
