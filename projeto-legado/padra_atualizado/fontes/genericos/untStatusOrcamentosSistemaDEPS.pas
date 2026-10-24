unit untStatusOrcamentosSistemaDEPS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdena, Data.DB, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, Datasnap.DBClient, UniClientDataSet,
  Datasnap.Provider, UniDataSetProvider, MemDS, DBAccess, Uni, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls,
  EditFocus, Vcl.Mask, MaskEditFocus, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmStatusOrcamentosSistemasDEPS = class(TfrmPaiOrdena)
    dbgStatusDEPS: TcxGrid;
    dbgStatusDEPSDados: TcxGridDBTableView;
    dbgStatusDEPSLevel1: TcxGridLevel;
    btnLidas: TBitBtnLocked;
    dbgStatusDEPSDadosFGO_NUMDOC: TcxGridDBColumn;
    dbgStatusDEPSDadosFGO_CODEMP: TcxGridDBColumn;
    dbgStatusDEPSDadosFGO_CODCLI: TcxGridDBColumn;
    dbgStatusDEPSDadosCLI_NOMCLI: TcxGridDBColumn;
    dbgStatusDEPSDadosDEP_STATUS: TcxGridDBColumn;
    dbgStatusDEPSDadosDEP_DTASIT: TcxGridDBColumn;
    dbgStatusDEPSDadosDEP_MOTIVO: TcxGridDBColumn;
    dbgStatusDEPSDadosDEP_USUDEP: TcxGridDBColumn;
    dbgStatusDEPSDadosDEP_INFCOM: TcxGridDBColumn;
    dbgStatusDEPSDadosDEP_CODSTS: TcxGridDBColumn;
    dbgStatusDEPSDadosDEP_DESSTS: TcxGridDBColumn;
    dbgStatusDEPSDadosDEP_MARDES: TcxGridDBColumn;
    btnAbrirOrcamento: TBitBtnLocked;
    btnExibirStatus: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure dbgStatusDEPSDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgStatusDEPSDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnLidasClick(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAbrirOrcamentoClick(Sender: TObject);
    procedure btnExibirStatusClick(Sender: TObject);
  private
    procedure pMarcarDesmarcarRegistro;
    { Private declarations }
  public
    cdsStatusDEPS: TUniClientDataSet;
    { Public declarations }
  end;

implementation

  Uses untFatGor, untFuncoesSimples, untMemo;

{$R *.dfm}

procedure TfrmStatusOrcamentosSistemasDEPS.btnAbrirOrcamentoClick(
  Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmStatusOrcamentosSistemasDEPS.btnExibirStatusClick(
  Sender: TObject);
  Var
    frmMemo: TfrmMemo;
begin
  inherited;
  If cdsStatusDEPS.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmMemo, frmMemo);
  frmMemo.cxMemo.Lines.Add('Orçamento     : ' + cdsStatusDEPS.FieldByName('FGO_NUMDOC').AsString);
  frmMemo.cxMemo.Lines.Add('Cliente       : ' + cdsStatusDEPS.FieldByName('FGO_CODCLI').AsString + '-' +
                                                cdsStatusDEPS.FieldByName('CLI_NOMCLI').AsString);
  frmMemo.cxMemo.Lines.Add('Status        : ' + cdsStatusDEPS.FieldByName('DEP_STATUS').AsString);
  frmMemo.cxMemo.Lines.Add('Data Status   : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', cdsStatusDEPS.FieldByName('DEP_DTASIT').AsDateTime));
  frmMemo.cxMemo.Lines.Add('Motivo        : ' + cdsStatusDEPS.FieldByName('DEP_MOTIVO').AsString);
  frmMemo.cxMemo.Lines.Add('Usuário DEPS  : ' + cdsStatusDEPS.FieldByName('DEP_USUDEP').AsString);
  frmMemo.cxMemo.Lines.Add('Inf. Comp.    : ' + cdsStatusDEPS.FieldByName('DEP_INFCOM').AsString);
  frmMemo.cxMemo.Lines.Add('Código DEPS   : ' + cdsStatusDEPS.FieldByName('DEP_CODSTS').AsString);
  frmMemo.cxMemo.Lines.Add('Descrição DEPS: ' + cdsStatusDEPS.FieldByName('DEP_DESSTS').AsString);
  frmMemo.cxMemo.Lines.Add('');
  frmMemo.cxMemo.Lines.Add('Aperte ESC para fechar a tela.');
  frmMemo.ShowModal;

  FreeAndNil(frmMemo);
end;

procedure TfrmStatusOrcamentosSistemasDEPS.btnLidasClick(Sender: TObject);
begin
  inherited;
  If (cdsStatusDEPS.IsEmpty) Or
     (Not cdsStatusDEPS.Locate('DEP_MARDES', 'M', [])) Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum status foi selecionado para marcar como lido.', ['&OK']);
    pSetFocus(dbgStatusDEPS);
    Exit;
  End;

  cdsStatusDEPS.DisableControls;
  cdsStatusDEPS.Filter   := 'DEP_MARDES=''M'' ';
  cdsStatusDEPS.Filtered := True;

  fStartTransaction;
  cdsStatusDEPS.First;
  While Not cdsStatusDEPS.Eof Do
  Begin
    fExecutaSQL('UPDATE STSDEP SET DEP_STSLID="S" ' +
                'WHERE DEP_SEQFGO=' + cdsStatusDEPS.FieldByName('DEP_SEQFGO').AsString.QuotedString +
                '  AND DEP_DTASIT=' + FormatDateTime('yyyy-mm-dd hh:mm:ss', cdsStatusDEPS.FieldByName('DEP_DTASIT').AsDateTime).QuotedString
                );

    cdsStatusDEPS.Delete;
  End;
  fCommit;
  cdsStatusDEPS.Filtered := False;
  cdsStatusDEPS.EnableControls;

  fMensagem('ATENÇÃO', 'Status marcados como lido com sucesso.', ['&OK']);
  pSetFocus(dbgStatusDEPS);
end;

procedure TfrmStatusOrcamentosSistemasDEPS.btnMudaOrdemClick(Sender: TObject);
begin
  Exit;
  inherited;

end;

procedure TfrmStatusOrcamentosSistemasDEPS.btnPesquisarClick(Sender: TObject);
begin
  Exit;
  inherited;

end;

procedure TfrmStatusOrcamentosSistemasDEPS.dbgStatusDEPSDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnMarcado: Boolean;
begin
  inherited;
  blnMarcado := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgStatusDEPSDadosDEP_MARDES.Index]) = 'M';

  If (blnMarcado) Then
  Begin
    ACanvas.Font.Color := clBlue;
    If (AViewInfo.Selected) Then
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmStatusOrcamentosSistemasDEPS.dbgStatusDEPSDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (Not cdsStatusDEPS.IsEmpty) Then
    pMarcarDesmarcarRegistro;
end;

procedure TfrmStatusOrcamentosSistemasDEPS.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsStatusDEPS);
end;

procedure TfrmStatusOrcamentosSistemasDEPS.FormCreate(Sender: TObject);
begin
  inherited;
  cdsStatusDEPS := TUniCLientDataSet.Create(Nil);
end;

procedure TfrmStatusOrcamentosSistemasDEPS.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnLidas.Click
  Else If Key = VK_F11 Then
    btnAbrirOrcamento.Click
  Else If Key = VK_F6 Then
    btnExibirStatus.Click;
end;

procedure TfrmStatusOrcamentosSistemasDEPS.FormShow(Sender: TObject);
begin
  inherited;

  btnMudaOrdem.Visible := False;
  btnPesquisar.Visible := False;

  cdsStatusDEPS.First;

  dbgStatusDEPSDados.DataController.DataSource := fCriaDataSource(cdsStatusDEPS);

  pSetFocus(dbgStatusDEPS);
end;

procedure TfrmStatusOrcamentosSistemasDEPS.pMarcarDesmarcarRegistro;
begin
  cdsStatusDEPS.Edit;
  cdsStatusDEPS.FieldByName('DEP_MARDES').AsString := IIF(cdsStatusDEPS.FieldByName('DEP_MARDES').AsString = 'M',
                                                          'D', 'M');
  cdsStatusDEPS.Post;
end;

end.
