unit untOPIndMonitoramento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask, Vcl.DBCtrls, DBEditFocus,
  ComboEditFocus, untFuncoesSimples, ComboBoxFocus, untOrdProIndustrial, Data.DB,
  StrUtils;

type
  TfrmOPIndMonitoramento = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    pnlCodBar: TPanel;
    pnlBaixa: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtCodBar: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtSenOpe: TEditFocus;
    Label5: TLabel;
    edtNomOpe: TEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cbxFase: TComboBoxFocus;
    cbxEquipamento: TComboBoxFocus;
    cbxSituacao: TComboBoxFocus;
    edtDesIte: TEditFocus;
    edtNumOpe: TEditFocus;
    edtDesEti: TEditFocus;
    edtVolume: TEditFocus;
    edtNumLot: TEditFocus;
    btnManMon: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbxFaseChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnManMonClick(Sender: TObject);
  private
    { Private declarations }
    strCodOpe: String;
    objOrdPro: TOrdProIndustrial;

    procedure pCarreDadosOP;
    procedure pLimpaTela(blnCodBar: Boolean = False);
    procedure pCarregaFases;
    procedure pCarregaEquipamentos;

    Function fCodFaseSelecionada: String;
    Function fCodEquipamentoSelecionado: String;

  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses
  untOrdProIndustrialOperacoes;

Function TfrmOPIndMonitoramento.fCodFaseSelecionada: String;
Begin
  Result := LeftStr(cbxFase.Text, 3);
End;

Function TfrmOPIndMonitoramento.fCodEquipamentoSelecionado: String;
Begin
  If cbxEquipamento.Items.Count > 0  Then
    Result := LeftStr(cbxEquipamento.Text, 5)
  Else
    Result := '';
End;

procedure TfrmOPIndMonitoramento.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    If (cbxFase.ItemIndex = -1) Then
    Begin
      pMensagemOk('Selecione a Fase da Ordem de Produção!');
      Exit;
    End;

    If cbxEquipamento.Enabled And (cbxEquipamento.ItemIndex = -1) Then
    Begin
      pMensagemOk('Selecione o Equipamento da Ordem de Produção!');
      Exit;
    End;

    If (cbxSituacao.ItemIndex = -1) Then
    Begin
      pMensagemOk('Selecione a Situação da Ordem de Produção!');
      Exit;
    End;

    With objOrdPro.objMonitor Do
    Case cbxSituacao.ItemIndex Of
      0: If fIniciaOperacao(strIncOPI,
                            strCodOpe,
                            fCodFaseSelecionada,
                            fCodEquipamentoSelecionado) Then
          Begin
            pMensagemOk('Fase inicializada com sucesso!');
            pLimpaTela(True);
            pSetFocus(edtCodBar);
          End;

      1: If fFinalizaOperacao(strIncOPI,
                              strCodOpe,
                              fCodFaseSelecionada,
                              fCodEquipamentoSelecionado) Then
         Begin
           pMensagemOk('Operação finalizada com sucesso!');
           pLimpaTela(True);
           pSetFocus(edtCodBar);
         End;

    End;
  End;
end;

procedure TfrmOPIndMonitoramento.btnManMonClick(Sender: TObject);
begin
  inherited;

  If Not btnManMon.Enabled Then
    Exit;

  If fEmptyStr(objOrdPro.objMonitor.strIncOPI) Then
    Exit;

  pCriarFormularios(TfrmOrdProIndustrialOperacoes, frmOrdProIndustrialOperacoes);

  frmOrdProIndustrialOperacoes.objOrdPro := objOrdPro;

  If objOrdPro.objMonitor.fCarregaOperacoes Then
    frmOrdProIndustrialOperacoes.cxgOperacoesView.DataController.DataSource := objOrdPro.objMonitor.cdsOperacoes.dtsSource;

  frmOrdProIndustrialOperacoes.ShowModal;

  FreeAndNil(frmOrdProIndustrialOperacoes);
end;

procedure TfrmOPIndMonitoramento.cbxFaseChange(Sender: TObject);
begin
  inherited;

  pCarregaEquipamentos;
end;

procedure TfrmOPIndMonitoramento.FormCreate(Sender: TObject);
begin
  inherited;

  objOrdPro :=  TOrdProIndustrial.Create(Self);
end;

procedure TfrmOPIndMonitoramento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F3: btnManMon.Click;
  End;

end;

procedure TfrmOPIndMonitoramento.FormShow(Sender: TObject);
begin
  inherited;

  pSetFocus(edtCodBar);
end;

procedure TfrmOPIndMonitoramento.pCarreDadosOP;
Begin
  With objOrdPro Do
  Begin
    pLimpaTela;

    edtDesIte.Text := cdsCabIpr.FieldByName('DESITE').AsString;
    edtNumOpe.Text := cdsCabIpr.FieldByName('NUMOPE').AsString;
    edtDesEti.Text := cdsCabIpr.FieldByName('DESETI').AsString;
    edtNumLot.Text := cdsCabIpr.FieldByName('NUMLOT').AsString;

    edtVolume.Text := FormatFloat('#,##0.000', fRetSoma('VOLUME'));

    pnlBaixa.Enabled  := True;
    btnManMon.Enabled := True;

    pCarregaFases;
  End;
End;

procedure TfrmOPIndMonitoramento.pCarregaFases;
Begin
  With objOrdPro.objMonitor.qryFases Do
  Begin
    cbxFase.Clear;

    First;
    while Not Eof do
    Begin
      cbxFase.Items.Add(FieldByName('FAS_CODFAS').AsString + ' -  ' + FieldByName('FAS_DESFAS').AsString);
      Next;
    End;

    cbxFase.ItemIndex := -1;
  End;
End;

procedure TfrmOPIndMonitoramento.pCarregaEquipamentos;
Begin
  With objOrdPro.objMonitor Do
  Begin
    cbxEquipamento.Clear;

    If (cbxFase.ItemIndex <> -1) And fCarregaEquipamentos(fCodFaseSelecionada) Then
    Begin
      qryEquipamentos.First;
      while Not qryEquipamentos.Eof do
      Begin
        cbxEquipamento.Items.Add(qryEquipamentos.FieldByName('EQP_CODEQP').AsString + ' - ' +
                                 qryEquipamentos.FieldByName('EQP_DESCRI').AsString);
        qryEquipamentos.Next;
      End;
    End;

    cbxEquipamento.ItemIndex := -1;
    cbxEquipamento.Enabled := cbxEquipamento.Items.Count > 0;
  End;
End;

procedure TfrmOPIndMonitoramento.pLimpaTela(blnCodBar: Boolean = False);
Begin
  If blnCodBar Then
  Begin
    edtCodBar.Clear;
    btnManMon.Enabled := False;
  End;

  edtDesIte.Clear;
  edtNumOpe.Clear;
  edtDesEti.Clear;
  edtNumLot.Clear;
  edtVolume.Clear;

  edtSenOpe.Clear;
  edtNomOpe.Clear;
  cbxFase.Clear;
  cbxEquipamento.Clear;
  cbxSituacao.ItemIndex := -1;

  pnlBaixa.Enabled := False;
End;

function TfrmOPIndMonitoramento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result    := True;

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

        If objOrdPro.fCarregaOPMonitoramento(edtCodBar.Text) Then
        Begin

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

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
