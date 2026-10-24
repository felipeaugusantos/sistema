unit untAltCepImpostacaoSfa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TfrmAltCepImpostacaoSfa = class(TfrmPaiConfirma)
    grdCep: TcxGrid;
    grdCepDBTableView: TcxGridDBTableView;
    grdCepLevel: TcxGridLevel;
    pnlLegenda: TPanel;
    shpLegEditavel: TShape;
    lblLegEditavel: TLabel;
    cdsCep: TUniClientDataSet;
    dtsCep: TDataSource;
    procedure grdCepDBTableViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pConfiguraGradeCliente;
    procedure pConfiguraGradeEntrega;
  end;

implementation

{$R *.dfm}

procedure TfrmAltCepImpostacaoSfa.grdCepDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  if AViewInfo.Item.Options.Editing then
  begin
    ACanvas.Brush.Color := clYellow;
    ACanvas.Font.Color  := clBlack;
  end;
end;

procedure TfrmAltCepImpostacaoSfa.pConfiguraGradeCliente;
begin
  Self.Width := 659;

  cdsCep.FieldDefs.Clear;
  cdsCep.FieldDefs.Add('CODIGO', ftString, 30);
  cdsCep.FieldDefs.Add('NOMCLI', ftString, 60);
  cdsCep.FieldDefs.Add('DOCCLI', ftString, 14);
  cdsCep.FieldDefs.Add('CIDCLI', ftString, 40);
  cdsCep.FieldDefs.Add('CEPCLI', ftString, 8);
  cdsCep.CreateDataSet;

  grdCepDBTableView.BeginUpdate;

  try
    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[0].DataBinding.FieldName := 'CODIGO';
    grdCepDBTableView.Columns[0].Caption := 'Código';
    grdCepDBTableView.Columns[0].Width := 120;
    grdCepDBTableView.Columns[0].Options.Editing := False;

    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[1].DataBinding.FieldName := 'NOMCLI';
    grdCepDBTableView.Columns[1].Caption := 'Nome';
    grdCepDBTableView.Columns[1].Width := 199;
    grdCepDBTableView.Columns[1].Options.Editing := False;

    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[2].DataBinding.FieldName := 'DOCCLI';
    grdCepDBTableView.Columns[2].Caption := 'CPF/CNPJ';
    grdCepDBTableView.Columns[2].Width := 93;
    grdCepDBTableView.Columns[2].Options.Editing := False;

    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[3].DataBinding.FieldName := 'CIDCLI';
    grdCepDBTableView.Columns[3].Caption := 'Código';
    grdCepDBTableView.Columns[3].Width := 135;
    grdCepDBTableView.Columns[3].Options.Editing := False;

    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[4].DataBinding.FieldName := 'CEPCLI';
    grdCepDBTableView.Columns[4].Caption := 'CEP';
    grdCepDBTableView.Columns[4].Width := 69;
    grdCepDBTableView.Columns[4].Options.Editing := True;
  finally
    grdCepDBTableView.EndUpdate;
  end;
end;

procedure TfrmAltCepImpostacaoSfa.pConfiguraGradeEntrega;
begin
  Self.Width := 852;

  cdsCep.FieldDefs.Clear;
  cdsCep.FieldDefs.Add('NUMPED', ftString, 40);
  cdsCep.FieldDefs.Add('DTAPED', ftDate);
  cdsCep.FieldDefs.Add('CODCLI', ftString, 30);
  cdsCep.FieldDefs.Add('ENDENT', ftString, 150);
  cdsCep.FieldDefs.Add('CEPENT', ftString, 9);
  cdsCep.CreateDataSet;

  grdCepDBTableView.BeginUpdate;

  try
    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[0].DataBinding.FieldName := 'NUMPED';
    grdCepDBTableView.Columns[0].Caption := 'Pedido';
    grdCepDBTableView.Columns[0].Width := 135;
    grdCepDBTableView.Columns[0].Options.Editing := False;

    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[1].DataBinding.FieldName := 'DTAPED';
    grdCepDBTableView.Columns[1].Caption := 'Data';
    grdCepDBTableView.Columns[1].Width := 78;
    grdCepDBTableView.Columns[1].Options.Editing := False;

    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[2].DataBinding.FieldName := 'CODCLI';
    grdCepDBTableView.Columns[2].Caption := 'Cliente';
    grdCepDBTableView.Columns[2].Width := 98;
    grdCepDBTableView.Columns[2].Options.Editing := False;

    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[3].DataBinding.FieldName := 'ENDENT';
    grdCepDBTableView.Columns[3].Caption := 'Endereço';
    grdCepDBTableView.Columns[3].Width := 400;
    grdCepDBTableView.Columns[3].Options.Editing := False;

    grdCepDBTableView.CreateColumn;
    grdCepDBTableView.Columns[4].DataBinding.FieldName := 'CEPENT';
    grdCepDBTableView.Columns[4].Caption := 'CEP';
    grdCepDBTableView.Columns[4].Width := 69;
    grdCepDBTableView.Columns[4].Options.Editing := True;
  finally
    grdCepDBTableView.EndUpdate;
  end;
end;

end.
