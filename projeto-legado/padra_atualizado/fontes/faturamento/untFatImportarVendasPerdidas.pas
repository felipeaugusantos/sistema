unit untFatImportarVendasPerdidas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Uni, UniClientDataSet;

type
  TfrmFatImportarVendasPerdidas = class(TfrmPai)
    grdItens: TcxGridCitel;
    grdItensTableView: TcxGridDBTableViewCitel;
    grdItensTableViewCODITE: TcxGridDBColumn;
    grdItensTableViewDESITE: TcxGridDBColumn;
    grdItensTableViewQTDITE: TcxGridDBColumn;
    grdItensTableViewNUMDOC: TcxGridDBColumn;
    grdItensTableViewUNITAR: TcxGridDBColumn;
    grdItensTableViewTOTITE: TcxGridDBColumn;
    grdItensTableViewESPDOC: TcxGridDBColumn;
    grdItensTableViewSelecionado: TcxGridDBColumn;
    grdItensLevel: TcxGridLevel;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    dtsDados: TDataSource;
    grdItensTableViewCODEMP: TcxGridDBColumn;
    grdItensTableViewDTACAD: TcxGridDBColumn;
    grdItensTableViewCODVEN: TcxGridDBColumn;
    grdItensTableViewNUMCMP: TcxGridDBColumn;
    grdItensTableViewCODIGO: TcxGridDBColumn;
    grdItensTableViewCODFAB: TcxGridDBColumn;
    grdItensTableViewNITCMP: TcxGridDBColumn;
    grdItensTableViewDTACMP: TcxGridDBColumn;
    procedure grdItensTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnDesmarcarTodosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdItensTableViewDblClick(Sender: TObject);
    procedure grdItensTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure pSelecionaRegistro(blnMarcar: Boolean);
    procedure pDesmarcarTodos;
    procedure pMarcarTodos;
    function fTemRegistrosSelecionados: boolean;
  public
    { Public declarations }
    cdsDados: TUniClientDataSet;
    procedure pCarregaDados(strCodCli: String);
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatImportarVendasPerdidas.pCarregaDados(strCodCli: String);
Var
  qryDados: TUniQuery;
begin

  qryDados := fCriaQuery(Self);

  Try
    qryDados.SQL.Clear;
    qryDados.SQL.Add('SELECT ');
    qryDados.SQL.Add(' "N" AS SELECIONADO, ');
    qryDados.SQL.Add(' MOVVPD.AUTOINCREM, ');
    qryDados.SQL.Add(' VPG_CODIGO, ');
    qryDados.SQL.Add(' VPG_CODEMP, ');
    qryDados.SQL.Add(' VPG_NUMDOC, ');
    qryDados.SQL.Add(' VPG_ESPDOC, ');
    qryDados.SQL.Add(' VPG_DTACAD, ');
    qryDados.SQL.Add(' VPG_CODVEN, ');
    qryDados.SQL.Add(' VPD_CODITE, ');
    qryDados.SQL.Add(' VPD_DESITE, ');
    qryDados.SQL.Add(' VPD_UNITAR, ');
    qryDados.SQL.Add(' VPD_QTDITE, ');
    qryDados.SQL.Add(' VPD_TOTITE, ');
    qryDados.SQL.Add(' VPD_NUMCMP, ');
    qryDados.SQL.Add(' VPD_NITCMP, ');
    qryDados.SQL.Add(' VPD_DTACMP, ');
    qryDados.SQL.Add(' ITE_CODFAB  ');
    qryDados.SQL.Add('FROM MOVVPG  ');
    qryDados.SQL.Add('INNER JOIN MOVVPD ON MOVVPD.VPD_CODIGO = MOVVPG.VPG_CODIGO AND ');
    qryDados.SQL.Add('                     MOVVPD.VPD_CODEMP = MOVVPG.VPG_CODEMP ');
    qryDados.SQL.Add('INNER JOIN CADITE ON MOVVPD.VPD_CODITE = CADITE.ITE_CODITE ');
    qryDados.SQL.Add('WHERE VPG_CODCLI = :CODCLI ');
    qryDados.SQL.Add('AND VPD_IMPORT <> "S" ');
    qryDados.SQL.Add('ORDER BY VPG_DTACAD');
    qryDados.ParamByName('CODCLI').AsString := strCodCli;
    qryDados.Open;

    cdsDados := fCriaClientDatSet(qryDados);

    TFloatField(cdsDados.FieldByName('VPD_QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    TFloatField(cdsDados.FieldByName('VPD_UNITAR')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    TFloatField(cdsDados.FieldByName('VPD_TOTITE')).DisplayFormat := fMskDigitos(2);
    TIntegerField(cdsDados.FieldByName('VPD_NITCMP')).EditMask    := '000000;0;_';
    TIntegerField(cdsDados.FieldByName('VPD_NITCMP')).DisplayFormat := '000000;0;_';

    dtsDados.DataSet := cdsDados;

  Finally
    FreeAndNil(qryDados);
  End;

end;

procedure TfrmFatImportarVendasPerdidas.pMarcarTodos;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      pSelecionaRegistro(True);
      cdsDados.Next;
    End;

  Finally
    cdsDados.First;
    cdsDados.EnableControls;
  End;
end;

procedure TfrmFatImportarVendasPerdidas.pDesmarcarTodos;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.First;
    While Not cdsDados.Eof Do
    Begin
      pSelecionaRegistro(False);
      cdsDados.Next;
    End;

  Finally
    cdsDados.First;
    cdsDados.EnableControls;
  End;
end;

procedure TfrmFatImportarVendasPerdidas.pSelecionaRegistro(blnMarcar: Boolean);
begin
  cdsDados.Edit;
  cdsDados.FieldByName('SELECIONADO').AsString := IIF(blnMarcar, 'S', 'N');
  cdsDados.Edit;
end;

function TfrmFatImportarVendasPerdidas.fTemRegistrosSelecionados: boolean;
begin
  Try
    cdsDados.DisableControls;
    cdsDados.Filtered := False;
    cdsDados.Filter := 'SELECIONADO = ' + quotedStr('S');
    cdsDados.Filtered := True;

    Result := not cdsDados.isEmpty;
  Finally
    cdsDados.Filtered := False;
    cdsDados.EnableControls;
  End;
end;

procedure TfrmFatImportarVendasPerdidas.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If not fTemRegistrosSelecionados Then
  Begin
    fMensagem('', 'Nenhum item foi selecionado!', ['&Ok']);
    Exit;
  End;

  If fMensagem('', 'Confirma a importação dos itens selecionados?', ['&Sim', '&Não'], 1) = 2 Then
    Exit;

  ModalResult := mrOk;
end;

procedure TfrmFatImportarVendasPerdidas.btnDesmarcarTodosClick(Sender: TObject);
begin
  inherited;
  pDesmarcarTodos;
end;

procedure TfrmFatImportarVendasPerdidas.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  pMarcarTodos;
end;

procedure TfrmFatImportarVendasPerdidas.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(cdsDados);
end;

procedure TfrmFatImportarVendasPerdidas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
        VK_F5: If btnMarcarTodos.Enabled And btnMarcarTodos.Visible Then btnMarcarTodos.Click;
        VK_F6: If btnDesmarcarTodos.Enabled And btnDesmarcarTodos.Visible Then btnDesmarcarTodos.Click;
       VK_F10: If btnConfirma.Enabled And btnConfirma.Visible Then btnConfirma.Click;
    VK_ESCAPE: pEscapePressed;
  End;
end;

procedure TfrmFatImportarVendasPerdidas.FormShow(Sender: TObject);
begin
  inherited;
  cdsDados.First;
  grdItensTableViewDTACMP.Visible := fCfgSis('SDTRPC', varBoolean);
  pSetFocus(grdItens);
end;

procedure TfrmFatImportarVendasPerdidas.grdItensTableViewDblClick(
  Sender: TObject);
var
  blnSelecionado: Boolean;
begin
  inherited;
  blnSelecionado := (cdsDados.FieldByName('SELECIONADO').AsString = 'S');
  pSelecionaRegistro(not blnSelecionado);
end;

procedure TfrmFatImportarVendasPerdidas.grdItensTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
var
  blnSelecionado: Boolean;
begin
  inherited;
  If Key = VK_RETURN Then
  Begin
    blnSelecionado := (cdsDados.FieldByName('SELECIONADO').AsString = 'S');
    pSelecionaRegistro(not blnSelecionado);
  End;
end;

procedure TfrmFatImportarVendasPerdidas.grdItensTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdItensTableViewSELECIONADO.Index]) = 'S' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;
end;

end.
