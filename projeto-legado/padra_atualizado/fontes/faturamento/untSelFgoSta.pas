unit untSelFgoSta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni, untFuncoesSimples;

type
  TfrmSelFgoSta = class(TfrmPaiConfirma)
    grdDadosTv: TcxGridDBTableViewCitel;
    grdDadosLv: TcxGridLevel;
    grdDados: TcxGridCitel;
    dtsDados: TDataSource;
    grdDadosTvSELECI: TcxGridDBColumn;
    grdDadosTvDESCRI: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fQryFgoSta: TUniQuery;
  public
    { Public declarations }
    procedure pMarcarSelecionados(strValCfg: string);
    function fRetSelecionados: String;
  end;

implementation

uses
  System.StrUtils;

{$R *.dfm}

procedure TfrmSelFgoSta.FormCreate(Sender: TObject);
begin
  inherited;
  fQryFgoSta := fCriaQuery;
  dtsDados.DataSet := fQryFgoSta;
  fQryFgoSta.CachedUpdates := True;
  fQryFgoSta.Options.SetFieldsReadOnly := False;

  fQryFgoSta.SQL.Text := 'SELECT 0 AS SELECI, FGOSTA.* FROM FGOSTA';
  fQryFgoSta.Open;
end;

procedure TfrmSelFgoSta.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fQryFgoSta);
  inherited;

end;

function TfrmSelFgoSta.fRetSelecionados: String;
begin
  Result := '';
  fQryFgoSta.DisableControls;
  try
    fQryFgoSta.First;
    while not fQryFgoSta.Eof do
    begin
      if fQryFgoSta.FieldByName('SELECI').AsInteger = 1 then
        Result := Result + fQryFgoSta.FieldByName('STA_CODIGO').AsString + '_';

      fQryFgoSta.Next;
    end;
  finally
    fQryFgoSta.EnableControls;
  end;
end;

procedure TfrmSelFgoSta.pMarcarSelecionados(strValCfg: string);
var
  arrSta: TArray<String>;
  strSta: String;
begin
  arrSta := strValCfg.Split(['_']);

  fQryFgoSta.DisableControls;
  try
    for strSta in arrSta do
    begin
      if fQryFgoSta.Locate('STA_CODIGO', strSta, []) then
      begin
        fQryFgoSta.Edit;
        fQryFgoSta.FieldByName('SELECI').AsInteger := 1;
        fQryFgoSta.Post;
      end;
    end;
  finally
    fQryFgoSta.First;
    fQryFgoSta.EnableControls;
  end;
end;

end.
