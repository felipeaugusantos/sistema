unit untEntConferenciaCompexPM260;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Grids, DBGridCitel, DBGrids, Uni, DB, untEntConferenciaFuncoes,
  UniClientDataSet, UniDataSetProvider,  BitBtnLockedIncrem, MemDS, DBAccess, Provider,
  frxClass, frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TfrmEntConferenciaCompexPM260 = class(TfrmPaiEdit)
    pnlDigitador: TPanel;
    lblDigita: TLabel;
    edtSenDig: TEditFocus;
    edtNomDig: TEditFocus;
    pnlItens: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtCodIte: TEditFocus;
    edtQtdIte: TEditFocus;
    lblTipoDoc: TLabel;
    edtNumPed: TEditFocus;
    edtLisPed: TEditFocus;
    dbgConsulta: TDBGridCitel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    pnlPedido: TPanel;
    btnExcluir: TBitBtnLocked;
    btnQuantidade: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    procedure btnQuantidadeClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtNumPedEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure cdsConsultaAfterClose(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    objConEnt: TConfereEntrada;
    stlAutoinc: TStringList;

    Function fRegistraItemConf: Boolean;
    Function fAbreConsulta: Boolean;
    Function fCancela: Boolean;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses  untFuncoesSimples,
  untEntConfPedidosMotorola;

{$R *.dfm}

function TfrmEntConferenciaCompexPM260.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtSenDig) And (pnlDigitador.Enabled) Then
    Begin
      If fEmptyStr(edtSenDig.Text) Then
      Begin
        fMensagemAuto('ATENÇÃO!', 'O digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        objConEnt.strCodDig      := fRetCodVendedor(edtSenDig.Text);
        edtNomDig.Text := fRetNomeOperador(objConEnt.strCodDig);

        If fEmptyStr(objConEnt.strCodDig) Then
        Begin
          fMensagemAuto('ATENÇÃO!', 'Esse digitador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fOperadorAtivo(objConEnt.strCodDig) Then
        Begin
          fMensagemAuto('ATENÇÃO!', 'Esse digitador está inativo!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtNumPed) Then
    Begin

      If Not objConEnt.fValidaPedido(edtNumPed.Text, edtLisPed) Then
        Result := FALSE;

      If Result And fValidaCampos(edtSenDig, True) And fAbreConsulta Then
      Begin
        pnlDigitador.Enabled := False;
        pnlDigitador.Visible := False;
        Caption := 'Conferência - Operador: ' + objConEnt.strCodDig + '-' + edtNomDig.Text;

        pnlItens.Enabled      := TRUE;
        btnExcluir.Enabled    := True;
        btnQuantidade.Enabled := True;
        btnConfirma.Enabled   := True;
        edtNumPed.Enabled     := False;

        blnMudarFoco := False;

        pSetFocus(edtCodIte);
        Exit;
      End;

    End

    Else If (Sender = edtCodIte) Then
    Begin
      Result := True;
      blnMudarFoco := False;
    End

    Else If (Sender = edtQtdIte) Then
    Begin

      If Not objConEnt.fValidaQuantidade(edtQtdIte) Then
        Result := False
      Else
      Begin
        pSetFocus(edtCodIte);
        blnMudarFoco := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmEntConferenciaCompexPM260.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  objConEnt.pConfirma;
end;

procedure TfrmEntConferenciaCompexPM260.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If (Not btnExcluir.Enabled) Then
    Exit;

  objConEnt.pExcluiItem;

  pSetFocus(edtCodIte);

end;

procedure TfrmEntConferenciaCompexPM260.btnQuantidadeClick(Sender: TObject);
begin
  inherited;

  If (Not btnQuantidade.Enabled) Then
    Exit;

  edtQtdIte.Enabled := True;
  pSetFocus(edtQtdIte);

end;

Function TfrmEntConferenciaCompexPM260.fCancela: Boolean;
Begin
  Result := True;

  If (edtNumPed.Focused) Or cdsConsulta.IsEmpty Then
    Close

  Else If fMensagem('', 'Deseja abandonar a tarefa?', ['&Sim', '&Não']) = 1 Then
  Begin
    edtNumPed.Enabled := True;
    pSetFocus(edtNumPed);
    edtNumPed.Clear;
    objConEnt.stlPedidos.Clear;
    objConEnt.stlEmpresas.Clear;
    edtLisPed.Clear;
  End

  Else Result := False;

End;

procedure TfrmEntConferenciaCompexPM260.btnSairClick(Sender: TObject);
begin
  inherited;

  fCancela;
end;

procedure TfrmEntConferenciaCompexPM260.cdsConsultaAfterClose(DataSet: TDataSet);
begin
  inherited;

  pnlItens.Enabled := FALSE;

  objConEnt.pLiberaLista;

  edtLisPed.Clear;
  objConEnt.stlPedidos.Clear;
  objConEnt.stlEmpresas.Clear;
  objConEnt.strCodFor := '';
  
end;

procedure TfrmEntConferenciaCompexPM260.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If DataSet.Active Then
    objConEnt.intRecNo := DataSet.RecNo;
  
end;

procedure TfrmEntConferenciaCompexPM260.edtNumPedEnter(Sender: TObject);
begin
  inherited;

  cdsConsulta.Close;
  edtNumPed.Clear;
  
end;

procedure TfrmEntConferenciaCompexPM260.edtNumPedKeyPress(Sender: TObject;
  var Key: Char);
  Var
    stlRegSel: TStringList;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Key := #0;

    stlRegSel := TStringList.Create;
    pCriarFormularios(TfrmEntConfPedidosMotorola, frmEntConfPedidosMotorola);
    Try
      frmEntConfPedidosMotorola.objConEnt := objConEnt;
      frmEntConfPedidosMotorola.stlRegSel := stlRegSel;

      If frmEntConfPedidosMotorola.ShowModal = mrOK Then
      Begin

        stlAutoinc.Text  := frmEntConfPedidosMotorola.stlListSelecao.Text;
        objConEnt.pRetListaPedidos(objConEnt.stlPedidos, objConEnt.stlEmpresas, stlAutoinc, frmEntConfPedidosMotorola.cdsConsulta);
        edtNumPed.Clear;

        edtLisPed.Visible := True;
        edtLisPed.Text := objConEnt.stlPedidos.CommaText;

        fValidaCampos(edtNumPed);

      End;
    Finally
      FreeAndNil(stlRegSel);
      FreeAndNil(frmEntConfPedidosMotorola);
    End;

  End;

end;

Function TfrmEntConferenciaCompexPM260.fAbreConsulta: Boolean;
Begin
  With qryConsulta Do
  Begin
    Close;
    SQL.Text := objConEnt.fSqlConferencia(True);
    cdsConsulta.Close;

    Open;
    pSetaClient(qryConsulta);

    cdsConsulta.Open;
    pSetaClient(cdsConsulta);

    Result := objConEnt.fRetTotalItens;
  End;

End;

procedure TfrmEntConferenciaCompexPM260.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(stlAutoinc);
end;

procedure TfrmEntConferenciaCompexPM260.FormCreate(Sender: TObject);
begin
  inherited;

  WindowState := wsMaximized;

  objConEnt := TConfereEntrada.Create(cdsConsulta, Nil, edtNumPed,
                                      dbgConsulta,
                                      cdsConsultaAfterScroll,
                                      True);

  edtQtdIte.EditFormat := fMskDigitos(objConEnt.intDeqTpc);

  edtNumPed.MaxLength := fTamDocCadRec();
  edtNumPed.TamCampo  := edtNumPed.MaxLength;
end;

procedure TfrmEntConferenciaCompexPM260.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(objConEnt);
end;

procedure TfrmEntConferenciaCompexPM260.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If edtCodIte.Focused Then
                 fRegistraItemConf
               Else
                 inherited;
    VK_F6: btnQuantidade.Click;
    VK_F10: Begin
              Key := 0;
              btnConfirma.Click;
            End;

    VK_F8: btnExcluir.Click;

    VK_ESCAPE:  If Not fCancela Then
                    Key := 0;

    Else inherited;
  End;

end;

procedure TfrmEntConferenciaCompexPM260.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtSenDig);

  edtQtdIte.Text := '1,00';

  stlAutoinc := TStringList.Create;
end;

Function TfrmEntConferenciaCompexPM260.fRegistraItemConf: Boolean;
  Var
    blnCodBarNaoEcontrado: Boolean;
Begin
  Result := False;

  If fEmptyStr(edtCodIte.Text) Then
    Exit;

  If Not fValidaCampos(edtQtdIte) Then
    Exit;

  Result := objConEnt.fRegistraItem(True, False, edtCodIte,
                                    edtQtdIte, Nil, False, blnCodBarNaoEcontrado);

End;

end.

