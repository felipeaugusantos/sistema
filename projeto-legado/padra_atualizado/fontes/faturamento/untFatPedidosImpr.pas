unit untFatPedidosImpr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxSpinEdit,
  cxCheckBox, cxTextEdit, cxGridBandedTableView, cxGridDBBandedTableView,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, StrUtils;

type
  TfrmFatPedidosImpr = class(TfrmPaiEdit)
    btnConfirmar: TBitBtnLocked;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    dtsDocumentos: TDataSource;
    cxGridBandedTableView1: TcxGridBandedTableView;
    cxGridBandedTableView1Column1: TcxGridBandedColumn;
    cxGridBandedTableView1Column2: TcxGridBandedColumn;
    cxGridBandedTableView1Column3: TcxGridBandedColumn;
    cxGridBandedTableView1Column4: TcxGridBandedColumn;
    cxGridBandedTableView1Column5: TcxGridBandedColumn;
    cxGridBandedTableView1Column6: TcxGridBandedColumn;
    cxGridBandedTableView1Column7: TcxGridBandedColumn;
    cxGridBandedTableView1Column8: TcxGridBandedColumn;
    cxGridBandedTableView1Column9: TcxGridBandedColumn;
    cxGridDBBandedTableView1: TcxGridDBBandedTableView;
    cxGridBand: TcxGridDBBandedTableView;
    cxGridBandColumn1: TcxGridDBBandedColumn;
    cxGridBandColumn2: TcxGridDBBandedColumn;
    cxGridBandColumn3: TcxGridDBBandedColumn;
    cxGridBandColumn4: TcxGridDBBandedColumn;
    cxGridBandColumn5: TcxGridDBBandedColumn;
    cxGridBandColumn6: TcxGridDBBandedColumn;
    cxGridBandColumn7: TcxGridDBBandedColumn;
    cxGridBandColumn8: TcxGridDBBandedColumn;
    cxGridBandColumn9: TcxGridDBBandedColumn;
    cxGridBandIMPTRM: TcxGridDBBandedColumn;
    cxGridBandColumn10: TcxGridDBBandedColumn;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cxGridBandColumn9PropertiesChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure pSetaImpressao(strCampo : String; strCfg: String);
    { Private declarations }
  public
    { Public declarations }
    blnSepara: Boolean;
    blnImprime: Boolean;
    blnMostraPreco: Boolean;
    blnConEqu: Boolean;
  end;

var
  frmFatPedidosImpr: TfrmFatPedidosImpr;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatPedidosImpr.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If dtsDocumentos.DataSet.State = dsEdit Then
    dtsDocumentos.DataSet.Post;
end;

procedure TfrmFatPedidosImpr.cxGridBandColumn9PropertiesChange(Sender: TObject);
begin
  inherited;

  If dtsDocumentos.DataSet.State = dsEdit Then
    dtsDocumentos.DataSet.Post;
end;

procedure TfrmFatPedidosImpr.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnConfirmar);
end;

procedure TfrmFatPedidosImpr.FormCreate(Sender: TObject);
begin
  inherited;
  blnMostraPreco := True;
  blnConEqu := False;
end;

procedure TfrmFatPedidosImpr.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirmar.Click;
  End;

end;

procedure TfrmFatPedidosImpr.FormShow(Sender: TObject);
Var LstrPrgPor  : String;
begin
  inherited;

  cxGridBand.Bands[1].Visible := blnImprime;
  cxGridBand.Bands[2].Visible := blnSepara;

  LstrPrgPor := fCfgSis('PRGPOR');
  cxGridBandIMPTRM.Visible := ((LstrPrgPor = '1') or (LstrPrgPor = '3'));

  if blnConEqu then
  begin
    cxGridBand.GetColumnByFieldName('IMPPRE').Visible := blnMostraPreco;
    cxGridBand.GetColumnByFieldName('IMPTOT').Visible := blnMostraPreco;
  end;

  If (fCfgSis('RDIMDO') <> 'S') Then
  begin
    pSetaImpressao('IMPRIM', 'RDIMDO');
  End;

  If (fCfgSis('RDIMSE') <> 'S') Then
  begin
    pSetaImpressao('IMPSEP', 'RDIMSE');
  End;

  If Not blnImprime Then
    Self.Width := Self.Width - cxGridBand.Bands[1].Width;

  If Not blnSepara Then
    Self.Width := Self.Width - cxGridBand.Bands[2].Width;

  If (Not blnImprime) And (Not blnSepara) Then
  Begin
    btnConfirmar.Caption := '[ F10 ] Continuar';
    btnSair.Visible := False;
  End;

end;

procedure TfrmFatPedidosImpr.pSetaImpressao(strCampo : String; strCfg: String);
begin
  dtsDocumentos.DataSet.First;
  dtsDocumentos.DataSet.DisableControls;

  while not dtsDocumentos.DataSet.Eof Do
  Begin

    dtsDocumentos.DataSet.Edit;

    Case AnsiIndexStr(UpperCase(fCfgSis(strCfg)), ['M', 'D']) of
      0: dtsDocumentos.DataSet.FieldByname(strCampo).AsBoolean := True;
      1: dtsDocumentos.DataSet.FieldByname(strCampo).AsBoolean := False;
    End;

    dtsDocumentos.DataSet.Post;

    dtsDocumentos.DataSet.Next;
  End;

  dtsDocumentos.DataSet.First;
  dtsDocumentos.DataSet.EnableControls;
end;

end.
