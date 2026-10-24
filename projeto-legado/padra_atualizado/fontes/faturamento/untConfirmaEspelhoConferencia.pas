unit untConfirmaEspelhoConferencia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass, Vcl.Graphics, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls, cxGridCustomView,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxFilter, cxData, untZClient,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCustomData, cxProgressBar,
  untHelperCitel;

type
  TfrmConfirmaEspelhoConferencia = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    pnlContagem: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    rdbCodBar: TRadioButton;
    rdbCodFab: TRadioButton;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensREFERE: TcxGridDBColumn;
    cxgItensSIGUNI: TcxGridDBColumn;
    cxgItensQTDEXP: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxsConferido: TcxStyle;
    btnExcluir: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    cxgItensViewQTDITE: TcxGridDBColumn;
    btnExpAut: TBitBtnLocked;
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cxgItensViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure rdbCodBarClick(Sender: TObject);
    procedure btnQuantidadeClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cxgItensViewStylesGetContentStyle(Sender: TcxCustomGridTableView;
      ARecord: TcxCustomGridRecord; AItem: TcxCustomGridTableItem;
      var AStyle: TcxStyle);
    procedure FormDestroy(Sender: TObject);
    procedure btnExpAutClick(Sender: TObject);
  private
    cdsItensConferencia : TZClient;
    qryCadIte : TUniQuery;
    function fGetSQL : String;
    function fRegistraItem: Boolean;
    function fVerificaQuantidades: Boolean;
    procedure pBuscaRegistro(DataSet: TDataSet; Var Accept: Boolean);
    function fExpedicaoAutomatica(cxProgress: TcxProgressBar): Boolean;
  public
    Class Function fConfereEspelho(strAutInc : String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses
  untFuncoesSimples, untPesqAux, untEspelhoOutrasSaidasFornecedor, untGravando;

{$R *.dfm}

procedure TfrmConfirmaEspelhoConferencia.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Deseja limpar toda conferência?', ['&Sim', '&Não'], 2 ) = 2 Then
    Exit;

  If TEspelhoDetalhe.fZerarContagem(cdsItensConferencia.FieldByName('SEQGER').AsString) Then
  Begin
    cdsItensConferencia.Close;
    cdsItensConferencia.fAbreClient(True, 'TfrmConfirmaEspelhoConferencia.btnExcluirClick');
    cdsItensConferencia.OnFilterRecord := pBuscaRegistro;
    pSetFocus(edtCodIte);
  End;
end;

procedure TfrmConfirmaEspelhoConferencia.btnGravarClick(Sender: TObject);
begin
//  inherited;
  if not fVerificaQuantidades Then
  Begin
    fMensagem('','Não é possível continuar com quantidades divergentes!', ['&OK']);
    pSetFocus(edtCodIte);
    Exit;
  End;

  ModalResult := mrOK;

end;

procedure TfrmConfirmaEspelhoConferencia.btnQuantidadeClick(Sender: TObject);
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  edtQtdIte.Enabled := True;
  pSetFocus(edtQtdIte);
end;

procedure TfrmConfirmaEspelhoConferencia.cxgItensViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE:  btnExcluir.Click;
  End;

end;

procedure TfrmConfirmaEspelhoConferencia.cxgItensViewStylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;
  If ARecord.Values[cxgItensQTDEXP.Index] = ARecord.Values[cxgItensViewQTDITE.Index] Then
    AStyle := cxsConferido;
end;

class function TfrmConfirmaEspelhoConferencia.fConfereEspelho(strAutInc: String): Boolean;
  var
    frmConfirmaEspelhoConferencia: TfrmConfirmaEspelhoConferencia;
begin
  pCriarFormularios(TfrmConfirmaEspelhoConferencia, frmConfirmaEspelhoConferencia);
  Try
    With frmConfirmaEspelhoConferencia Do
    Begin
      cdsItensConferencia.qryQuery.ParamByName('AUTINC').AsString := strAutInc;
      cdsItensConferencia.fAbreClient(True,'TfrmConfirmaEspelhoConferencia.fConfereEspelho', False, True);
      cdsItensConferencia.OnFilterRecord := pBuscaRegistro;
      Result := (frmConfirmaEspelhoConferencia.ShowModal = mrOK);
    End;

  Finally
    FreeAndNil(frmConfirmaEspelhoConferencia);
  End;

end;

function TfrmConfirmaEspelhoConferencia.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT DET_CODITE AS CODITE, ';
  Result := Result + '        ITE_DESITE AS DESITE, ';
  Result := Result + '        ITE_REFERE AS REFERE, ';
  Result := Result + '        UNI_SIGUNI AS SIGUNI, ';
  Result := Result + '        DET_QTDITE AS QTDITE, ';
  Result := Result + '        DET_QTDEXP AS QTDEXP, ';
  Result := Result + '        DET_SEQGER AS SEQGER, ';
  Result := Result + '        D.AUTOINCREM          ';
  Result := Result + ' FROM ESPDET D ';
  Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ';
  Result := Result + '   INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  Result := Result + ' WHERE DET_SEQGER = :AUTINC ';
end;

procedure TfrmConfirmaEspelhoConferencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
//    If Not objConEnt.fFinalizaEntrada Then
//      Action := caNone;
  End

  Else If Not fPergunta('Deseja abandonar a Conferência?') Then
         Action := caNone;
end;

procedure TfrmConfirmaEspelhoConferencia.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadIte := fCriaQuery;
  cdsItensConferencia := TZClient.Create(Self, fGetSQL );
  cxgItensView.DataController.DataSource := cdsItensConferencia.dtsSource;
end;

procedure TfrmConfirmaEspelhoConferencia.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryCadIte);
  inherited;
end;

procedure TfrmConfirmaEspelhoConferencia.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If edtCodIte.Focused Then
                 fRegistraItem;
    VK_F6: btnQuantidade.Click;
    VK_F7: btnExpAut.Click;
    VK_F10: Begin
              Key := 0;
              btnGravar.Click;
            End;
  End;

end;

procedure TfrmConfirmaEspelhoConferencia.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodIte);
end;

function TfrmConfirmaEspelhoConferencia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodIte) Then
    Begin
      Result := True;
      blnMudarFoco := False;
    End

    Else If (Sender = edtQtdIte) Then
    Begin
      If edtQtdIte.Focused Then
      Begin
        edtQtdIte.Enabled := False;
        pSetFocus(edtCodIte);
        blnMudarFoco := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmConfirmaEspelhoConferencia.rdbCodBarClick(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodIte);
  edtCodIte.MaxLength := IIF(rdbCodBar.CheCked, 15, 25);
end;

function TfrmConfirmaEspelhoConferencia.fRegistraItem : Boolean;
  Var
    fltQtdCnf : Double;
    fltEmbala : Double;
    fltQtdAux : Double;
    objEspDet : TEspelhoDetalhe;
    oleDados  : OleVariant;
Begin
  Result := FALSE;

  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  If Not fValidaCampos(edtQtdIte) Then
    Exit;

  Try

    With qryCadIte, SQL Do
    Begin
      pPesquisaCadIteSemSemelhante(nil, qryCadIte, edtCodIte.Text, rdbCodBar.Checked, rdbCodFab.Checked);

      Result := not qryCadIte.IsEmpty;

      If Result Then
      Begin
        fltEmbala := qryCadIte.FieldByName('BAR_EMBALA').AsFloat;
        If fltEmbala <= 0 then
          fltEmbala := 1;

        fltQtdCnf := fltEmbala * fStrToFloat(edtQtdIte.Text);

        cdsItensConferencia.First;
        oleDados := cdsItensConferencia.Data;

        While (fltQtdCnf > 0) And ((cdsItensConferencia.Bof and cdsItensConferencia.FindFirst) or (cdsItensConferencia.FindNext) ) Do
        Begin

          If (cdsItensConferencia.FieldByName('QTDEXP').AsFloat) < cdsItensConferencia.FieldByName('QTDITE').AsFloat Then
          Begin
            cdsItensConferencia.Edit;

            If cdsItensConferencia.FieldByName('QTDITE').AsFloat > cdsItensConferencia.FieldByName('QTDEXP').AsFloat + fltQtdCnf Then
            Begin
              cdsItensConferencia.FieldByName('QTDEXP').AsFloat := cdsItensConferencia.FieldByName('QTDEXP').AsFloat + fltQtdCnf;
              fltQtdCnf := 0;
            End
            Else
            Begin
              fltQtdAux := cdsItensConferencia.FieldByName('QTDITE').AsFloat - cdsItensConferencia.FieldByName('QTDEXP').AsFloat;

              if fltQtdAux > fltQtdCnf then
                fltQtdAux := fltQtdCnf;

              cdsItensConferencia.FieldByName('QTDEXP').AsFloat := cdsItensConferencia.FieldByName('QTDEXP').AsFloat + fltQtdAux;

              fltQtdCnf := fltQtdCnf - fltQtdAux;
            End;

            cdsItensConferencia.Post;

            objEspDet := TEspelhoDetalhe.Create;
            If objEspDet.fCarregaRegistro(cdsItensConferencia.FieldByName('AUTOINCREM').AsString) Then
            Begin
              objEspDet.fltQtdExp := cdsItensConferencia.FieldByName('QTDEXP').AsFloat;
              objEspDet.fSalva;
            End;
            FreeAndNil(objEspDet);

          End;

        End;

        cxgItensView.Site.Repaint;

        If (fltQtdCnf > 0) Then
        Begin
          cdsItensConferencia.Data := oleDados;
          fMensagem('', 'Quantidade não Permitida!', ['&OK']);
          Result := False;
          Exit;
        End;

      End
      Else
        pMensagemSonora('Código de Barras não Localizado no Espelho!');

    End;
  Finally
    edtCodIte.Clear;
    edtQtdIte.Text := '1,00';
    pSetFocus(edtCodIte);
  End;

  rdbCodBar.Checked := True;

End;


function TfrmConfirmaEspelhoConferencia.fVerificaQuantidades : Boolean;
Begin
  Try
    Result := True;
    cdsItensConferencia.DisableControls;
    cdsItensConferencia.First;
    While not cdsItensConferencia.Eof Do
    Begin
      if cdsItensConferencia.FieldByName('QTDITE').AsFloat <> cdsItensConferencia.FieldByName('QTDEXP').AsFloat Then
      Begin
        Result := False;
        Break;
      End;

      cdsItensConferencia.Next;
    End;

  Finally
    cdsItensConferencia.First;
    cdsItensConferencia.EnableControls;
  End;
End;

procedure TfrmConfirmaEspelhoConferencia.pBuscaRegistro(DataSet: TDataSet;  var Accept: Boolean);
begin
  Accept := SameStr(DataSet.FieldByName('CODITE').AsString, qryCadIte.FieldByName('ITE_CODITE').AsString);
end;

procedure TfrmConfirmaEspelhoConferencia.btnExpAutClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('EXPAUT', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fExpedicaoAutomatica;
  frmGravando.ShowModal;
  FreeAndNil(frmGravando);

  ModalResult := mrOK;
end;

function TfrmConfirmaEspelhoConferencia.fExpedicaoAutomatica(cxProgress : TcxProgressBar) : Boolean;
Begin
  Result := True;
  Try
    cxProgress.pSetMax(cdsItensConferencia.RecordCount);
    cdsItensConferencia.DisableControls;
    cdsItensConferencia.First;
    While Not cdsItensConferencia.Eof Do
    Begin
      cdsItensConferencia.Edit;
      cdsItensConferencia.FieldByName('QTDEXP').AsFloat := cdsItensConferencia.FieldByName('QTDITE').AsFloat;
      cdsItensConferencia.Post;

      cdsItensConferencia.Next;

      cxProgress.pStep;
      Application.ProcessMessages;
    End;

  Finally
    cdsItensConferencia.First;
    cdsItensConferencia.EnableControls;
  End;

End;


end.
