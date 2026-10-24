unit untCfgDescricaoLocalRetira;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, UniClientDataSet, cxTextEdit;

type
  TfrmCfgDescricaoLocRet = class(TfrmPaiConfirma)
    dtsDados: TDataSource;
    grdDadosTBV: TcxGridDBTableViewCitel;
    grdDadosLevel: TcxGridLevel;
    grdDados: TcxGridCitel;
    grdDadosTBVLOCRET: TcxGridDBColumn;
    grdDadosTBVDESCRI: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    cdsLocRet: TUniClientDataSet;

    procedure pCriaDatasetLocRet;
    procedure pCarregaDatasetLocRet;
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmCfgDescricaoLocRet.btnConfirmaClick(Sender: TObject);
var
  strSQL: String;
  qryAtuDes: TUniQuery;
begin
  inherited;

  qryAtuDes := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + 'UPDATE CADDLR ';    
    strSQL := strSQL + 'SET DLR_DESCRI = :DESCRI ';
    strSQL := strSQL + 'WHERE DLR_LOCRET = :LOCRET ';

    qryAtuDes.SQL.Text := strSQL;

    cdsLocRet.First;

    while not cdsLocRet.Eof do
    begin
      qryAtuDes.Close;
      qryAtuDes.ParamByName('DESCRI').AsString := cdsLocRet.FieldByName('DESCRI').AsString;
      qryAtuDes.ParamByName('LOCRET').AsString := cdsLocRet.FieldByName('CODLRE').AsString;
      qryAtuDes.ExecSQL;;
      
      cdsLocRet.Next;
    end;
  finally
    FreeAndNil(qryAtuDes);
  end;

  fMensagem('', 'Dados gravados com sucesso!', ['&Ok']);
end;

procedure TfrmCfgDescricaoLocRet.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDatasetLocRet;
end;

procedure TfrmCfgDescricaoLocRet.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDatasetLocRet;
end;

procedure TfrmCfgDescricaoLocRet.pCarregaDatasetLocRet;
var
  strSQL: String;
  qryLocRet: TUniQuery;
begin
  qryLocRet := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + 'SELECT DLR_LOCRET, ';
    strSQL := strSQL + '  CASE DLR_LOCRET ';
    strSQL := strSQL + '    WHEN "1" THEN "RETIRA CAIXA" ';
    strSQL := strSQL + '    WHEN "2" THEN "RETIRA EXPEDIÇÃO" ';
    strSQL := strSQL + '    WHEN "3" THEN "RETIRA BALCÃO" ';
    strSQL := strSQL + '    WHEN "4" THEN "RETIRA BALCÃO 2" END LOCRET, ';
    strSQL := strSQL + '  DLR_DESCRI ';
    strSQL := strSQL + 'FROM CADDLR ';

    qryLocRet.SQL.Text := strSQL;
    qryLocRet.Open;

    while not qryLocRet.Eof do
    begin
      cdsLocRet.Append;
      cdsLocRet.FieldByName('CODLRE').AsString := qryLocRet.FieldByName('DLR_LOCRET').AsString;
      cdsLocRet.FieldByName('LOCRET').AsString := qryLocRet.FieldByName('LOCRET').AsString;
      cdsLocRet.FieldByName('DESCRI').AsString := qryLocRet.FieldByName('DLR_DESCRI').AsString;
      cdsLocRet.Post;

      qryLocRet.Next;
    end;
  finally
    FreeAndNil(qryLocRet);
  end;
end;

procedure TfrmCfgDescricaoLocRet.pCriaDatasetLocRet;
begin
  cdsLocRet := TUniClientDataSet.Create(Self);

  cdsLocRet.FieldDefs.Add('CODLRE', ftString, 1);
  cdsLocRet.FieldDefs.Add('LOCRET', ftString, 20);
  cdsLocRet.FieldDefs.Add('DESCRI', ftString, 10);
  cdsLocRet.CreateDataSet;

  dtsDados.DataSet := cdsLocRet;
end;

end.
