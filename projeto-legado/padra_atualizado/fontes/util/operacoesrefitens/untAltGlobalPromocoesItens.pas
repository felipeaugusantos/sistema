unit untAltGlobalPromocoesItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls,
  UniClientDataSet, untAltGlobalPromocoesIntf, StrUtils, cxProgressBar,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmAltGlobalPromocoesItens = class(TfrmPaiSimples)
    pnlBotoesEnt: TPanel;
    btnConfirma: TBitBtnLocked;
    btnVoltar: TBitBtnLocked;
    cxGridItensPromocaoLevel: TcxGridLevel;
    cxGridItensPromocaoTable: TcxGridDBTableViewCitel;
    cxGridItensPromocao: TcxGridCitel;
    dsItensPromocao: TDataSource;
    cxGridItensPromocaoPRO_DESPRO: TcxGridDBColumn;
    cxGridItensPromocaoIPR_PRECUS_ATU: TcxGridDBColumn;
    cxGridItensPromocaoIPR_PRECUS_NOV: TcxGridDBColumn;
    cxGridItensPromocaoIPR_PREVEN_ATU: TcxGridDBColumn;
    cxGridItensPromocaoIPR_PREVEN_NOV: TcxGridDBColumn;
    cxGridItensPromocaoIPR_PERDES_ATU: TcxGridDBColumn;
    cxGridItensPromocaoIPR_PERDES_NOV: TcxGridDBColumn;
    cxGridItensPromocaoIPR_COMVAR_ATU: TcxGridDBColumn;
    cxGridItensPromocaoIPR_COMVAR_NOV: TcxGridDBColumn;
    cxGridItensPromocaoIPR_COMATA_ATU: TcxGridDBColumn;
    cxGridItensPromocaoIPR_COMATA_NOV: TcxGridDBColumn;
    cxGridItensPromocaoIPR_COMDIS_ATU: TcxGridDBColumn;
    cxGridItensPromocaoIPR_COMDIS_NOV: TcxGridDBColumn;
    cxGridItensPromocaoITE_CODITE: TcxGridDBColumn;
    cxGridItensPromocaoITE_DESITE: TcxGridDBColumn;
    cxGridItensPromocaoITE_REFERE: TcxGridDBColumn;
    cxGridItensPromocaoUNI_SIGUNI: TcxGridDBColumn;
    cxGridItensPromocaoIPR_TABPRE: TcxGridDBColumn;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cxGridItensPromocaoTableKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pBeforePost(DataSet: TDataSet);

    function fAtualizaPromocoes(pgbStatus: TcxProgressBar): Boolean;

    procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer = 0);
    procedure pStepStatusGravacao(pgbStatus: TcxProgressBar);
  public
    { Public declarations }
    taTipAlt: TTipoAlteracao;
    cdsItePro: TUniClientDataSet;
    procedure pExibeCamposGrid;
  end;

var
  frmAltGlobalPromocoesItens: TfrmAltGlobalPromocoesItens;

implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando, untAltGlobalPromocoesDao, untTypesSistema;

{ TfrmAltGlobalPromocoesItens }

procedure TfrmAltGlobalPromocoesItens.btnConfirmaClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  inherited;

  If (fMensagem('ATENÇÃO', 'Deseja confirmar as alterações dos itens das promoções?', ['&Sim', '&Não'], 1) = 1) Then
  Begin
    Try
      fStartTransaction;
      pCriarFormularios(TfrmGravando, frmAguarde);
      frmAguarde.fExecutarAcao := fAtualizaPromocoes;
      frmAguarde.ShowModal;

      If frmAguarde.blnConfirma Then
      Begin
        fCommit;
        fMensagem('','Itens das promoções atualizado com sucesso!',['&OK']);
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '');
      End;
    End;

    pFreeAndNil(frmAguarde);
  End;
end;

procedure TfrmAltGlobalPromocoesItens.btnVoltarClick(Sender: TObject);
begin
  inherited;

  Close;
end;

procedure TfrmAltGlobalPromocoesItens.cxGridItensPromocaoTableKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: If (Not cdsItePro.IsEmpty) And (cdsItePro.State = dsEdit) Then
                 cdsItePro.Cancel
               Else
                 Close;
    VK_F10: btnConfirma.Click;
  End;
end;

function TfrmAltGlobalPromocoesItens.fAtualizaPromocoes(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    prcScroll: TprcScroll;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Atualizando itens da promoção...', cdsItePro.RecordCount);

  pDisableControls(cdsItePro, prcScroll);

  With cdsItePro Do
  Begin
    First;

    While Not Eof Do
    Begin
      TAltGlobalPromocoesDao.fUpdatePromocoes(cdsItePro);

      pStepStatusGravacao(pgbStatus);
      Application.ProcessMessages;

      Next;
    End;
  End;

  pEnableControls(cdsItePro, prcScroll);
  Result := True;
end;

procedure TfrmAltGlobalPromocoesItens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Assigned(cdsItePro) Then
    FreeAndNil(cdsItePro);
end;

procedure TfrmAltGlobalPromocoesItens.FormShow(Sender: TObject);
begin
  inherited;

  cdsItePro.AfterScroll := pAfterOpen;
  cdsItePro.BeforePost  := pBeforePost;
  cdsItePro.Next;
  cdsItePro.First;

  pSetaClient(cdsItePro);

  cxGridItensPromocaoTable.ViewData.Expand(True);
end;

procedure TfrmAltGlobalPromocoesItens.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('IPR_PRECUS_ATU') <> nil Then
      TFloatField(FieldByName('IPR_PRECUS_ATU')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_PRECUS_NOV') <> nil Then
      TFloatField(FieldByName('IPR_PRECUS_NOV')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_PREVEN_ATU') <> nil Then
      TFloatField(FieldByName('IPR_PREVEN_ATU')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_PREVEN_NOV') <> nil Then
      TFloatField(FieldByName('IPR_PREVEN_NOV')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_PERDES_ATU') <> nil Then
      TFloatField(FieldByName('IPR_PERDES_ATU')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_PERDES_NOV') <> nil Then
      TFloatField(FieldByName('IPR_PERDES_NOV')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_COMVAR_ATU') <> nil Then
      TFloatField(FieldByName('IPR_COMVAR_ATU')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_COMVAR_NOV') <> nil Then
      TFloatField(FieldByName('IPR_COMVAR_NOV')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_COMATA_ATU') <> nil Then
      TFloatField(FieldByName('IPR_COMATA_ATU')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_COMATA_NOV') <> nil Then
      TFloatField(FieldByName('IPR_COMATA_NOV')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_COMDIS_ATU') <> nil Then
      TFloatField(FieldByName('IPR_COMDIS_ATU')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');

    If FindField('IPR_COMDIS_NOV') <> nil Then
      TFloatField(FieldByName('IPR_COMDIS_NOV')).DisplayFormat := '#,##0.' + IfThen(taTipAlt = taValor, '00', '000000');
  End;
end;

procedure TfrmAltGlobalPromocoesItens.pBeforePost(DataSet: TDataSet);
  Var
    blnValida: Boolean;
begin
  blnValida := True;

  With DataSet Do
  Begin
    If (FieldByName('IPR_PRECUS_NOV').AsFloat <= 0)          And
       SameText(FieldByName('IPR_PRECUS_ALT').AsString, 'S') Then
    Begin
      fMensagem('','O Campo Preço Custo deve ser maior que zero!',['&OK']);
      blnValida := False;
    End
    Else If (FieldByName('IPR_PREVEN_NOV').AsFloat <= 0)          And
            SameText(FieldByName('IPR_PREVEN_ALT').AsString, 'S') Then
    Begin
      fMensagem('','O Campo Preço Venda deve ser maior que zero!',['&OK']);
      blnValida := False;
    End
    Else If (FieldByName('IPR_PERDES_NOV').AsFloat <= 0)          And
            SameText(FieldByName('IPR_PERDES_ALT').AsString, 'S') Then
    Begin
      fMensagem('','O Campo % Desconto deve ser maior que zero!',['&OK']);
      blnValida := False;
    End
    Else If (FieldByName('IPR_COMVAR_NOV').AsFloat <= 0)          And
            SameText(FieldByName('IPR_COMVAR_ALT').AsString, 'S') Then
    Begin
      fMensagem('','O Campo % Comissão Vend. Interno deve ser maior que zero!',['&OK']);
      blnValida := False;
    End
    Else If (FieldByName('IPR_COMATA_NOV').AsFloat <= 0)          And
            SameText(FieldByName('IPR_COMATA_ALT').AsString, 'S') Then
    Begin
      fMensagem('','O Campo % Comissão Vend. Externo Loja deve ser maior que zero!',['&OK']);
      blnValida := False;
    End
    Else If (FieldByName('IPR_COMDIS_NOV').AsFloat <= 0)          And
            SameText(FieldByName('IPR_COMDIS_ALT').AsString, 'S') Then
    Begin
      fMensagem('','O Campo % Comissão Vend. Externo Distribuição deve ser maior que zero!',['&OK']);
      blnValida := False;
    End;
  End;

  If Not blnValida Then
  Begin
    DataSet.Cancel;
    Abort;
  End;
end;

procedure TfrmAltGlobalPromocoesItens.pExibeCamposGrid;
begin
  dsItensPromocao.DataSet := cdsItePro;

  With cdsItePro Do
  Begin
    If Not IsEmpty Then
    Begin
      cxGridItensPromocaoIPR_PRECUS_ATU.Visible := SameText(FieldByName('IPR_PRECUS_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_PRECUS_NOV.Visible := SameText(FieldByName('IPR_PRECUS_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_PREVEN_ATU.Visible := SameText(FieldByName('IPR_PREVEN_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_PREVEN_NOV.Visible := SameText(FieldByName('IPR_PREVEN_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_PERDES_ATU.Visible := SameText(FieldByName('IPR_PERDES_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_PERDES_NOV.Visible := SameText(FieldByName('IPR_PERDES_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_COMVAR_ATU.Visible := SameText(FieldByName('IPR_COMVAR_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_COMVAR_NOV.Visible := SameText(FieldByName('IPR_COMVAR_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_COMATA_ATU.Visible := SameText(FieldByName('IPR_COMATA_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_COMATA_NOV.Visible := SameText(FieldByName('IPR_COMATA_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_COMDIS_ATU.Visible := SameText(FieldByName('IPR_COMDIS_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_COMDIS_NOV.Visible := SameText(FieldByName('IPR_COMDIS_ALT').AsString, 'S');
      cxGridItensPromocaoIPR_TABPRE.Visible     := FieldByName('IPR_TABPRE').AsString <> 'NNNNNNN';
    End;
  End;
end;

procedure TfrmAltGlobalPromocoesItens.pInfoStatusGravacao(
  pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;
    If intMax > 0 Then
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := 0;
    End;
    Application.ProcessMessages;
  End;
end;

procedure TfrmAltGlobalPromocoesItens.pStepStatusGravacao(
  pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

end.
