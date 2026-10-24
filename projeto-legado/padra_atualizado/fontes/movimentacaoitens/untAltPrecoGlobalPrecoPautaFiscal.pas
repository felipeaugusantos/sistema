unit untAltPrecoGlobalPrecoPautaFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxCurrencyEdit, cxCalendar, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid;

type
  TfrmAltPrecoGlobalPrecoPautaFiscal = class(TfrmPaiEdit)
    dtsPrecoPautaFiscal: TDataSource;
    cxGridPautaFiscal: TcxGrid;
    cxGridPautaFiscalDBTableView: TcxGridDBTableView;
    cxGridPautaFiscalDBTableViewPPF_CODITE: TcxGridDBColumn;
    cxGridPautaFiscalDBTableViewPPF_ESTADO: TcxGridDBColumn;
    cxGridPautaFiscalDBTableViewPPF_VLRPPF: TcxGridDBColumn;
    cxGridPautaFiscalDBTableViewPPF_DTAINI: TcxGridDBColumn;
    cxGridPautaFiscalDBTableViewPPF_DTAFIN: TcxGridDBColumn;
    cxGridPautaFiscalLevel1: TcxGridLevel;
    btnConfirma: TBitBtnLocked;
    function fVigenciaPautaFiscalInvalida(DataSet: TDataSet): Boolean;
    function fVerificaPautaFiscal: Boolean;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAltPrecoGlobalPrecoPautaFiscal: TfrmAltPrecoGlobalPrecoPautaFiscal;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmAltPrecoGlobalPrecoPautaFiscal.fVigenciaPautaFiscalInvalida(DataSet: TDataSet): Boolean;
begin
  Result := False;

  If (DataSet.State = dsInsert) Then
    Exit;

  If ((DataSet.FieldByName('PPF_DTAINI').AsDateTime = 0) And (DataSet.FieldByName('PPF_DTAFIN').AsDateTime = 0)) Then
    Exit;

  If (DataSet.FieldByName('PPF_DTAINI').AsDateTime = 0) Then
    Exit;

  If (DataSet.FieldByName('PPF_DTAFIN').AsDateTime = 0) Then
    Exit;

  If (DataSet.FieldByName('PPF_DTAINI').AsDateTime > DataSet.FieldByName('PPF_DTAFIN').AsDateTime) Then
    Exit(True);
end;

procedure TfrmAltPrecoGlobalPrecoPautaFiscal.btnSairClick(Sender: TObject);
begin
  If dtsPrecoPautaFiscal.DataSet.State = dsEdit Then
    dtsPrecoPautaFiscal.DataSet.Cancel;

  inherited;
end;

procedure TfrmAltPrecoGlobalPrecoPautaFiscal.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10: btnConfirma.Click;
    VK_ESCAPE : btnSair.Click;
  End;
end;

function TfrmAltPrecoGlobalPrecoPautaFiscal.fVerificaPautaFiscal: Boolean;
begin
  Result := False;

  Try
    dtsPrecoPautaFiscal.DataSet.DisableControls;
    dtsPrecoPautaFiscal.DataSet.First;
    While not dtsPrecoPautaFiscal.DataSet.Eof Do
    Begin
      If not (dtsPrecoPautaFiscal.DataSet.FieldByName('PPF_VLRPPF').AsFloat >= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Verifique o Preço da Pauta Fiscal da UF "'+dtsPrecoPautaFiscal.DataSet.FieldByName('PPF_ESTADO').AsString+'" !', ['&Ok']);
        Result := True;
        Break;
      End;

      If fVigenciaPautaFiscalInvalida(dtsPrecoPautaFiscal.DataSet) Then
      Begin
        fMensagem('ATENÇÃO!', 'Verifique as Datas de Vigência da UF "'+dtsPrecoPautaFiscal.DataSet.FieldByName('PPF_ESTADO').AsString+'" !', ['&Ok']);
        Result := True;
        Break;
      End;

      dtsPrecoPautaFiscal.DataSet.Next;
    End;

  Finally
    dtsPrecoPautaFiscal.DataSet.EnableControls;
  End;
end;

procedure TfrmAltPrecoGlobalPrecoPautaFiscal.btnConfirmaClick(Sender: TObject);
begin
  If dtsPrecoPautaFiscal.DataSet.State = dsEdit Then
    dtsPrecoPautaFiscal.DataSet.Post;

  If fVerificaPautaFiscal Then
    Exit;

  ModalResult := mrOk;

  inherited;
end;

end.
