unit untCfgValorMaxEmissaoNFCeUF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Data.DB, Datasnap.DBClient, UniClientDataSet,
  Datasnap.Provider, UniDataSetProvider, MemDS, DBAccess, Uni, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel;

type
  TfrmValorMaxEmissaoNFCeUF = class(TfrmPai)
    dbgNFCeUF: TDBGridCitel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    qryNFCeUF  : TUniQuery;
    dtsNFCeUF  : TDataSource;

    procedure pAfterOpen(DataSet: TDataSet);


  public
    { Public declarations }
  end;

var
  frmValorMaxEmissaoNFCeUF: TfrmValorMaxEmissaoNFCeUF;

implementation

uses
  untFuncoesSimples,
  untValidadorDaRegraValorEmissaoNFCePorEstado;


{$R *.dfm}

procedure TfrmValorMaxEmissaoNFCeUF.FormCreate(Sender: TObject);
begin
  inherited;
  qryNFCeUF  := fCriaQuery(Self);


  qryNFCeUF.SQL.Text :=
    TValidadorDaRegraValorEmissaoNFCePorEstado.
      fRetornarSQLValoresMaxEmissaoNFCe;

  qryNFCeUF.AfterOpen := pAfterOpen;

  qryNFCeUF.Open;

  dtsNFCeUF := fCriaDataSource(qryNFCeUF);
  dbgNFCeUF.DataSource := dtsNFCeUF;
end;


procedure TfrmValorMaxEmissaoNFCeUF.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(qryNFCeUF) then pFreeAndNil(qryNFCeUF);
  if Assigned(dtsNFCeUF) then pFreeAndNil(dtsNFCeUF);
end;

procedure TfrmValorMaxEmissaoNFCeUF.pAfterOpen(DataSet: TDataSet);
begin
  TFloatField(DataSet.FieldByName('NFC_DESTID')).DisplayFormat := '#,####0.0000';
  TFloatField(DataSet.FieldByName('NFC_DESSEM')).DisplayFormat := '#,####0.0000';
end;

end.
