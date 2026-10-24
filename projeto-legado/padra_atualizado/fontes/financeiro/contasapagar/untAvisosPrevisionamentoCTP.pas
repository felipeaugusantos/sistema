unit untAvisosPrevisionamentoCTP;

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
  TfrmAvisosPrevisionamentoCTP = class(TfrmPaiOrdena)
    dbgAvisosPrevisionamento: TcxGrid;
    dbgAvisosPrevisionamentoDados: TcxGridDBTableView;
    dbgAvisosPrevisionamentoLevel1: TcxGridLevel;
    btnLidas: TBitBtnLocked;
    dbgAvisosPrevisionamentoDadosNUMDUP: TcxGridDBColumn;
    dbgAvisosPrevisionamentoDadosPRE_CODFOR: TcxGridDBColumn;
    dbgAvisosPrevisionamentoDadosFOR_NOMFOR: TcxGridDBColumn;
    dbgAvisosPrevisionamentoDadosPRE_DTAMSG: TcxGridDBColumn;
    dbgAvisosPrevisionamentoDadosPRE_MOTIVO: TcxGridDBColumn;
    dbgAvisosPrevisionamentoDadosOPEENV: TcxGridDBColumn;
    dbgAvisosPrevisionamentoDadosPRE_ASSUNT: TcxGridDBColumn;
    dbgAvisosPrevisionamentoDadosPRE_MARDES: TcxGridDBColumn;
    btnExibirDados: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure dbgAvisosPrevisionamentoDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgAvisosPrevisionamentoDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnLidasClick(Sender: TObject);
    procedure btnMudaOrdemClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAbrirDuplicataClick(Sender: TObject);
    procedure btnExibirDadosClick(Sender: TObject);
  private
    procedure pMarcarDesmarcarRegistro;
    { Private declarations }
  public
    cdsAvisosPrevisionamento: TUniClientDataSet;
    { Public declarations }
  end;

implementation

  Uses untFatGor, untFuncoesSimples, untMemo;

{$R *.dfm}

procedure TfrmAvisosPrevisionamentoCTP.btnAbrirDuplicataClick(
  Sender: TObject);
begin
  inherited;
  //
end;

procedure TfrmAvisosPrevisionamentoCTP.btnExibirDadosClick(
  Sender: TObject);
  Var
    frmMemo: TfrmMemo;
begin
  inherited;
  If cdsAvisosPrevisionamento.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmMemo, frmMemo);
  frmMemo.cxMemo.Lines.Add('Duplicata : ' + cdsAvisosPrevisionamento.FieldByName('PRE_NUMDUP').AsString + cdsAvisosPrevisionamento.FieldByName('PRE_PARCEL').AsString);
  frmMemo.cxMemo.Lines.Add('Empresa   : ' + cdsAvisosPrevisionamento.FieldByName('PRE_CODEMP').AsString);
  frmMemo.cxMemo.Lines.Add('Série     : ' + cdsAvisosPrevisionamento.FieldByName('PRE_SERIE_').AsString);
  frmMemo.cxMemo.Lines.Add('Fornecedor: ' + cdsAvisosPrevisionamento.FieldByName('PRE_CODFOR').AsString + '-' +
                                            cdsAvisosPrevisionamento.FieldByName('FOR_NOMFOR').AsString);
  frmMemo.cxMemo.Lines.Add('Data      : ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', cdsAvisosPrevisionamento.FieldByName('PRE_DTAMSG').AsDateTime));
  frmMemo.cxMemo.Lines.Add('Assunto   : ' + cdsAvisosPrevisionamento.FieldByName('PRE_ASSUNT').AsString);
  frmMemo.cxMemo.Lines.Add('Motivo    : ' + cdsAvisosPrevisionamento.FieldByName('PRE_MOTIVO').AsString);
  frmMemo.cxMemo.Lines.Add('Operador  : ' + cdsAvisosPrevisionamento.FieldByName('PRE_OPEENV').AsString + '-' +
                                            cdsAvisosPrevisionamento.FieldByName('OPE_NOMOPE').AsString);
  frmMemo.cxMemo.Lines.Add('');
  frmMemo.cxMemo.Lines.Add('Aperte ESC para fechar a tela.');
  frmMemo.ShowModal;

  FreeAndNil(frmMemo);
end;

procedure TfrmAvisosPrevisionamentoCTP.btnLidasClick(Sender: TObject);
begin
  inherited;
  If (cdsAvisosPrevisionamento.IsEmpty) Or
     (Not cdsAvisosPrevisionamento.Locate('PRE_MARDES', 'M', [])) Then
  Begin
    fMensagem('ATENÇÃO', 'Nenhum registro foi selecionado para marcar como lido.', ['&OK']);
    pSetFocus(dbgAvisosPrevisionamento);
    Exit;
  End;

  cdsAvisosPrevisionamento.DisableControls;
  cdsAvisosPrevisionamento.Filter   := 'PRE_MARDES=''M'' ';
  cdsAvisosPrevisionamento.Filtered := True;

  fStartTransaction;
  cdsAvisosPrevisionamento.First;
  While Not cdsAvisosPrevisionamento.Eof Do
  Begin
    fExecutaSQL('UPDATE MSGPRE SET PRE_MSGLID="S" ' +
                'WHERE PRE_CODMSG=' + cdsAvisosPrevisionamento.FieldByName('PRE_CODMSG').AsString);

    cdsAvisosPrevisionamento.Delete;
  End;
  fCommit;
  cdsAvisosPrevisionamento.Filtered := False;
  cdsAvisosPrevisionamento.EnableControls;

  fMensagem('ATENÇÃO', 'Avisos marcados como lido com sucesso.', ['&OK']);
  pSetFocus(dbgAvisosPrevisionamento);
end;

procedure TfrmAvisosPrevisionamentoCTP.btnMudaOrdemClick(Sender: TObject);
begin
  Exit;
  inherited;

end;

procedure TfrmAvisosPrevisionamentoCTP.btnPesquisarClick(Sender: TObject);
begin
  Exit;
  inherited;

end;

procedure TfrmAvisosPrevisionamentoCTP.dbgAvisosPrevisionamentoDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    blnMarcado: Boolean;
begin
  inherited;
  blnMarcado := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgAvisosPrevisionamentoDadosPRE_MARDES.Index]) = 'M';

  If (blnMarcado) Then
  Begin
    ACanvas.Font.Color := clBlue;
    If (AViewInfo.Selected) Then
      ACanvas.Font.Color := clLime;
  End;
end;

procedure TfrmAvisosPrevisionamentoCTP.dbgAvisosPrevisionamentoDadosKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And (Not cdsAvisosPrevisionamento.IsEmpty) Then
    pMarcarDesmarcarRegistro;
end;

procedure TfrmAvisosPrevisionamentoCTP.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(cdsAvisosPrevisionamento);
end;

procedure TfrmAvisosPrevisionamentoCTP.FormCreate(Sender: TObject);
begin
  inherited;
  cdsAvisosPrevisionamento := TUniCLientDataSet.Create(Nil);
end;

procedure TfrmAvisosPrevisionamentoCTP.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnLidas.Click
  Else If Key = VK_F6 Then
    btnExibirDados.Click;
end;

procedure TfrmAvisosPrevisionamentoCTP.FormShow(Sender: TObject);
begin
  inherited;

  btnMudaOrdem.Visible := False;
  btnPesquisar.Visible := False;

  cdsAvisosPrevisionamento.First;

  dbgAvisosPrevisionamentoDados.DataController.DataSource := fCriaDataSource(cdsAvisosPrevisionamento);

  pSetFocus(dbgAvisosPrevisionamento);
end;

procedure TfrmAvisosPrevisionamentoCTP.pMarcarDesmarcarRegistro;
begin
  cdsAvisosPrevisionamento.Edit;
  cdsAvisosPrevisionamento.FieldByName('PRE_MARDES').AsString := IIF(cdsAvisosPrevisionamento.FieldByName('PRE_MARDES').AsString = 'M',
                                                                     'D', 'M');
  cdsAvisosPrevisionamento.Post;
end;

end.
