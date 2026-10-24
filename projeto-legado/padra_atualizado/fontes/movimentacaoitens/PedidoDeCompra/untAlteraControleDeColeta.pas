unit untAlteraControleDeColeta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, Data.DB, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxDBEdit, EditFocus,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ComCtrls, dxCore, cxDateUtils,
  untControleDeColeta,
  cxCurrencyEdit;

type
  TfrmAlteraControleDeColeta = class(TfrmPaiConfirma)
    pnlProduto: TPanel;
    pnlComum: TPanel;
    dtsConsulta: TDataSource;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    dbePreFat: TcxDBDateEdit;
    Label122: TLabel;
    dbeCodLoc: TDBEditFocus;
    Label3: TLabel;
    DBEditFocus2: TDBEditFocus;
    Label4: TLabel;
    DBEditFocus3: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    Label5: TLabel;
    DBEditFocus5: TDBEditFocus;
    DBEditFocus6: TDBEditFocus;
    dbeDesLoc: TDBEditFocus;
    pnlColeta: TPanel;
    Panel1: TPanel;
    lblQuantidade: TLabel;
    dbeQtdIte: TDBEditFocus;
    Panel3: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    Panel4: TPanel;
    cxdDtaCol: TcxDateEdit;
    btnIncluir: TBitBtnLocked;
    edtQtdCol: TEditFocus;
    Panel5: TPanel;
    btnExcluir: TBitBtnLocked;
    cxgColeta: TcxGrid;
    cxvColeta: TcxGridDBTableView;
    cxvColetaDTABAI: TcxGridDBColumn;
    cxvColetaQTDBAI: TcxGridDBColumn;
    cxgColetaLevel1: TcxGridLevel;
    Label1: TLabel;
    edtQtdPen: TEditFocus;
    procedure dbeCodLocKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
  private
    { Private declarations }
    intDeqTpc: Integer;
    procedure pAtualizaQtdPen;

    procedure pLimpaChaves;
    procedure pSetaStatus;
    procedure pCancela(var Action: TCloseAction);

  public
    { Public declarations }
    objColeta: TControleDeColeta;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean;override;
  end;

var
  frmAlteraControleDeColeta: TfrmAlteraControleDeColeta;

implementation

{$R *.dfm}

Uses
   untFuncoesSimples,
   untTypesSistema,
   Math,
   untConsultas;

procedure TfrmAlteraControleDeColeta.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If objColeta.fExcluiBaixa Then
    pAtualizaQtdPen;
end;

procedure TfrmAlteraControleDeColeta.btnIncluirClick(Sender: TObject);
begin
  inherited;

  If fValidaCampos(cxdDtaCol, True) Then
  If fValidaCampos(edtQtdCol, True) Then
  Begin

    If objColeta.fIncluiColeta(cxdDtaCol.Date, fStrToFloat(edtQtdCol.Text)) Then
    Begin
      cxdDtaCol.Clear;
      edtQtdCol.Clear;
      pSetFocus(cxdDtaCol);
      pAtualizaQtdPen;
    End;

  End;
end;

procedure TfrmAlteraControleDeColeta.dbeCodLocKeyPress(Sender: TObject;
  var Key: Char);
 Var
   arrCodLoc : TConsultasArray;
begin
  inherited;

  If fPesqLocalMercadoria(Self, dbeCodLoc, dbeDesLoc, Nil, Key, arrCodLoc) Then
  Begin
    If fValidaCampos(dbeCodLoc, False) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteraControleDeColeta.pLimpaChaves;
Begin
  If dtsConsulta.DataSet.State In dsEditModes Then
  Begin
    If fEmptyStr(dbeCodLoc.Text) Then
      dtsConsulta.DataSet.FieldByName('CON_CODLOC').Clear;

    If fEmptyDate(dbePreFat.Text) Then
      dtsConsulta.DataSet.FieldByName('CON_PREFAT').Clear;
  End;
End;

procedure TfrmAlteraControleDeColeta.pSetaStatus;
Begin
  If (dtsConsulta.DataSet.State In dsEditModes) And
     (dtsConsulta.DataSet.FieldByName('CON_BAIXAD').AsString <> 'S') Then
  Begin
    If (objColeta.cdsBaixaColeta.fRetSoma('TOTCOL') = 0) Then
      dtsConsulta.DataSet.FieldByName('STATUS').AsString := 'Aberta'
    Else
      dtsConsulta.DataSet.FieldByName('STATUS').AsString := 'Baixa Parcial';
  End;
End;

procedure TfrmAlteraControleDeColeta.pCancela(var Action: TCloseAction);
Begin
  If Not fPergunta('Deseja abandonar a tarefa?') Then
  Begin
    Action := caNone;
  End Else
  Begin
    If pnlColeta.Visible Then
      objColeta.cdsBaixaColeta.CancelUpdates;
  End;
End;

procedure TfrmAlteraControleDeColeta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  pLimpaChaves;

  If ModalResult = mrOk Then
  Begin

    If Not fVerificaCampos Then
    Begin
      Action := caNone;
      Exit;
    End;

    If (dtsConsulta.DataSet.FieldByName('MARCAD').AsString = 'S') And
       (Not fPergunta('Confirma a alteração de todos os registros marcados?')) Then
    Begin
      Action := caNone;
      Exit;
    End;

    If pnlColeta.Visible Then
    Begin
      If (Not objColeta.cdsBaixaColeta.fSalva) Then
      Begin
        Action := caNone;
        Exit;
      End;

      pSetaStatus;
    End;

  End Else
  Begin

    pCancela(Action);

  End;
end;

procedure TfrmAlteraControleDeColeta.FormShow(Sender: TObject);
begin
  inherited;
  intDeqTpc := fCfgSis('DEQTPC', varInteger);
  If (Not(TAggregateField(objColeta.FieldByName('SUM_QTDMAR')).Value = 1)) And
     (dtsConsulta.DataSet.FieldByName('MARCAD').AsString = 'S') Then
  Begin
    pnlProduto.Visible := False;
    pnlColeta.Visible := False;
    Self.ClientHeight := pnlComum.Height + pnlBotoes.Height + pnlStatus.Height;
  End Else
  Begin
    cxvColeta.DataController.DataSource := objColeta.cdsBaixaColeta.dtsSource;
    objColeta.fCarregaBaixa(objColeta.FieldByName('AUTOINCREM').AsString);
    TFloatField(objColeta.cdsBaixaColeta.FieldByName('CON_QTDBAI')).DisplayFormat := fMskDigitos(intDeqTpc, true);
    cxvColeta.DataController.Summary.FooterSummaryItems.Items[0].Format := fMskDigitos(intDeqTpc, true);
    cxvColeta.NavigatorButtons.First.Click;

    If objColeta.FieldByName('CON_AUTREQ').IsNull Then
      lblQuantidade.Caption := 'Quantidade Disponível Total:'
    Else
      lblQuantidade.Caption := 'Quantidade Tolal Requisição:';

    pAtualizaQtdPen;
  End;
end;

function TfrmAlteraControleDeColeta.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  blnValidaMultiplo: Boolean;

  fltQtdIte,
  fltResto,
  fltNewQtdCol,
  fltMltVen: Double;

begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If Sender = dbeCodLoc Then
    Begin

      If Not fEmptyStr(dbeCodLoc.Text) Then
      Begin

        dbeDesLoc.Text := fRetLocalMercadoria(dbeCodLoc.Text);

        If fEmptyStr(dbeDesLoc.Text) Then
        Begin
          Result := False;
          pMensagemOk('Local da Mercadoria não encontrado!');
        End;

      End;

    End

    Else If Sender = cxdDtaCol Then
    Begin

      If blnBuscaPorChave Then
      Begin

        If fEmptyDate(cxdDtaCol.Text) Then
        Begin
          Result := False;
          pMensagemOk('Informe a dada da coleta!');
        End;

      End;

    End

    Else If Sender = edtQtdCol Then
    Begin
      If blnBuscaPorChave Then
      Begin
        fltMltVen := dtsConsulta.DataSet.FieldByName('MLTVEN').AsFloat;
        blnValidaMultiplo := False;
        If fltMltVen > 0 Then
        Begin
          fltQtdIte := Trunc(dtsConsulta.DataSet.FieldByName('QTDITE').AsFloat / fltMltVen);
          fltResto := RoundTo(dtsConsulta.DataSet.FieldByName('QTDITE').AsFloat - fltQtdIte * fltMltVen, -intDeqTpc);
          If fltResto = 0 Then
            blnValidaMultiplo := True;
        End;

        If blnValidaMultiplo Then
        Begin
          fltQtdIte := RoundTo(fStrToFloat(edtQtdCol.Text) / fltMltVen, -intDeqTpc);
          fltQtdIte := Trunc(fltQtdIte);

          fltResto := RoundTo(fStrToFloat(edtQtdCol.Text) - fltQtdIte * fltMltVen, -intDeqTpc);

          If fltResto > 0 Then
          Begin
            fltNewQtdCol := (fltQtdIte + 1) * fltMltVen;

            If RoundTo(fltNewQtdCol, -intDeqTpc) >
               RoundTo(dtsConsulta.DataSet.FieldByName('QTDITE').AsFloat - objColeta.cdsBaixaColeta.fRetSoma('TOTCOL'), -intDeqTpc) Then
              fltNewQtdCol := (fltNewQtdCol - fltMltVen);
            edtQtdCol.text := FloatToStr(fltNewQtdCol);
            Result := False;
            pMensagemOk('A quantidade coletada deve ser múltiplo de ' + FormatFloat(fMskDigitos(2), dtsConsulta.DataSet.FieldByName('MLTVEN').AsFloat) + ' !');
          End;
        End;

        If Result Then
        Begin

          If fStrToFloat(edtQtdCol.Text) <= 0 Then
          Begin
            Result := False;
            pMensagemOk('A quantidade coletada deve ser maior que zero!');
          End

          Else If RoundTo(fStrToFloat(edtQtdCol.Text), -intDeqTpc) >
                  RoundTo(dtsConsulta.DataSet.FieldByName('QTDITE').AsFloat - objColeta.cdsBaixaColeta.fRetSoma('TOTCOL'), -intDeqTpc) Then
          Begin
            Result := False;
            pMensagemOk('A quantidade coletada deve ser menor ou igual a ' +
                        FormatFloat(fMskDigitos(intDeqTpc), dtsConsulta.DataSet.FieldByName('QTDITE').AsFloat - objColeta.cdsBaixaColeta.fRetSoma('TOTCOL')) + ' !');
          End
        End;

      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmAlteraControleDeColeta.pAtualizaQtdPen;
Begin
  edtQtdPen.Text := FormatFloat(fMskDigitos(intDeqTpc), dtsConsulta.DataSet.FieldByName('QTDITE').AsFloat - objColeta.cdsBaixaColeta.fRetSoma('TOTCOL'));
End;

end.
