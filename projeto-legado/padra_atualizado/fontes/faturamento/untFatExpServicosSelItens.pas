unit untFatExpServicosSelItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, Uni,
  UniClientDataSet, UniDataSetProvider, DB, AppEvnts, untFuncFat, Math, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmFatExpServicosSelItens = class(TfrmPai)
    dbgItens: TDBGridCitel;
    btnGravar: TBitBtnLocked;
    dtsItens: TDataSource;
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    intRecNo: Integer;
    blnPermiteFracionario: Boolean;
    procedure pAfterScroll(Dataset: TDataset);
    procedure pAfterInsert(Dataset: TDataset);
    procedure pBeforePost(Dataset: TDataset);
  public
    { Public declarations }
    cdsItens: TUniClientDataSet;
  end;

var
  frmFatExpServicosSelItens: TfrmFatExpServicosSelItens;

implementation

uses  untfuncoesSimples, untCadPro, untFuncoes;

{$R *.dfm}

procedure TfrmFatExpServicosSelItens.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If cdsItens.FieldByName('QTDITE').AsFloat > 0 Then
  Begin
    dbgItens.Canvas.Font.Color := clBlue;
  End;

  If (intRecNo = cdsItens.RecNo) Then
  Begin
    dbgItens.Canvas.Font.Color  := clWhite;
    dbgItens.Canvas.Brush.Color := clNavy;
  End;

  dbgItens.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmFatExpServicosSelItens.pAfterScroll(Dataset: TDataset);
begin
  blnPermiteFracionario := fItemFracionado(DataSet.FieldByName('ITE_CODUNI').AsString);
  intRecNo := Dataset.RecNo;
  dbgItens.Refresh;
end;

procedure TfrmFatExpServicosSelItens.dbgItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Escape : btnSair.Click;
    VK_F10    : btnGravar.Click;
    VK_Return : Begin
                  If cdsItens.State = dsEdit Then
                    cdsItens.Post
                  Else
                  Begin
                    cdsItens.Edit;
                    dbgItens.SelectedField := cdsItens.FieldByName('QTDITE');
                  End;
                End;
  End;

end;

procedure TfrmFatExpServicosSelItens.dbgItensKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If CharInSet(Key, ['-', '+', '.']) Then
    Key := #0;

  If CharInSet(Key, [',']) And Not blnPermiteFracionario Then
    Key := #0;
end;

procedure TfrmFatExpServicosSelItens.pAfterInsert(Dataset: TDataset);
begin
  DataSet.Cancel;
end;

procedure TfrmFatExpServicosSelItens.pBeforePost(Dataset: TDataset);
begin
  If fStrToFloat(DataSet.FieldByName('QTDITE').AsString) <= 0 Then
  Begin
    DataSet.FieldByName('QTDITE').AsFloat := 0.0;
  End
  Else If DataSet.FieldByName('QTDITE').AsFloat > DataSet.FieldByName('QTDMAX').AsFloat Then
  Begin
    pMensagemOk('A quantidade devolvida não pode ser maior que ' + DataSet.FieldByName('QTDMAX').AsString + '!');
    DataSet.FieldByName('QTDITE').AsFloat := DataSet.FieldByName('QTDMAX').AsFloat;
  End;
end;

procedure TfrmFatExpServicosSelItens.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgItens);
  If Not cdsItens.IsEmpty Then
  Begin
    cdsItens.First;
    cdsItens.Edit;
    intRecNo := cdsItens.RecNo;
    dbgItens.SelectedField := cdsItens.FieldByName('QTDITE');
  End;
end;

procedure TfrmFatExpServicosSelItens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  dtsItens.DataSet      := nil;
  cdsItens.BeforePost   := nil;
  cdsItens.BeforeInsert := nil;
  cdsItens.AfterScroll  := nil;
end;

procedure TfrmFatExpServicosSelItens.FormShow(Sender: TObject);
begin
  inherited;
  dtsItens.DataSet      := cdsItens;
  cdsItens.BeforePost   := pBeforePost;
  cdsItens.AfterInsert  := pAfterInsert;
  cdsItens.AfterScroll  := pAfterScroll;
  TFloatField(cdsItens.FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
end;

procedure TfrmFatExpServicosSelItens.btnGravarClick(Sender: TObject);
begin
  inherited;
  Close;
  ModalResult := mrOk;
end;

end.

