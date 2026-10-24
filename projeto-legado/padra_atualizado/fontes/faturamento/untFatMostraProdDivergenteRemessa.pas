unit untFatMostraProdDivergenteRemessa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Datasnap.DBClient, UniClientDataSet;

type
  TfrmFatMostraProdDivergenteRemessa = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    btnFechar: TBitBtnLocked;
    DBGridCitel1: TDBGridCitel;
    dtsItensRemessa: TDataSource;
    cdsItensRemessa: TUniClientDataSet;
    cdsItensRemessaITE_CODITE: TStringField;
    cdsItensRemessaITE_DESITE: TStringField;
    cdsItensRemessaITE_QTDPED: TFloatField;
    cdsItensRemessaITE_QTDREM: TFloatField;
    cdsItensRemessaITE_MOTIVO: TStringField;
    procedure btnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pAbreClient;
    procedure pIncluirItem(strCodIte, strDesIte, strMotivo: string; fltQtdPed, fltQtdRem: Double);
    function fRetQtdItensFaturamento(cdsVenda: TUniClientDataSet; fltQtdPen: Double; strCodIte: String): Double;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatMostraProdDivergenteRemessa.btnFecharClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatMostraProdDivergenteRemessa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cdsItensRemessa.Close;
  inherited;
end;

procedure TfrmFatMostraProdDivergenteRemessa.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
    btnFechar.Click;
end;

function TfrmFatMostraProdDivergenteRemessa.fRetQtdItensFaturamento(
  cdsVenda: TUniClientDataSet; fltQtdPen: Double; strCodIte: String): Double;
var
  intRecNo: Integer;
begin
  Result := fFormataFloat(fltQtdPen, fCfgSis('DECQTD', varInteger));

  if not Assigned(cdsVenda) then
    Exit;

  if not cdsVenda.Active then
    Exit;

  if cdsVenda.RecordCount <= 0  then
    Exit;

  intRecNo := cdsVenda.RecNo;

  cdsVenda.Filtered := False;
  cdsVenda.Filter := ' ITE_CODITE = '+QuotedStr(strCodIte)+' ';
  cdsVenda.Filtered := True;

  if cdsVenda.RecordCount <= 0  then
    Exit;

  Result := 0;

  while not cdsVenda.Eof do
  begin
    Result := Result + cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
    cdsVenda.Next;
  end;

  cdsVenda.Filtered := False;
  cdsVenda.RecNo := intRecNo;

  Result := fFormataFloat(Result, fCfgSis('DECQTD', varInteger));
end;

procedure TfrmFatMostraProdDivergenteRemessa.pAbreClient;
begin
  cdsItensRemessa.CreateDataSet;
  cdsItensRemessa.EmptyDataSet;
  cdsItensRemessa.Open;
end;

procedure TfrmFatMostraProdDivergenteRemessa.pIncluirItem(strCodIte, strDesIte,
  strMotivo: string; fltQtdPed, fltQtdRem: Double);
begin
  try
    cdsItensRemessa.Insert;
    cdsItensRemessa.FieldByName('ITE_CODITE').AsString := strCodIte;
    cdsItensRemessa.FieldByName('ITE_DESITE').AsString := strDesIte;
    cdsItensRemessa.FieldByName('ITE_MOTIVO').AsString := strMotivo;
    cdsItensRemessa.FieldByName('ITE_QTDPED').AsFloat  := fltQtdPed;
    cdsItensRemessa.FieldByName('ITE_QTDREM').AsFloat  := fltQtdRem;
    cdsItensRemessa.Post;
  Except

    On E: Exception Do
    Begin
			pMensagensErro(E.Message,'[TfrmFatMostraProdDivergenteRemessa.pIncluirItem]');
    End;

  End;
end;

end.
