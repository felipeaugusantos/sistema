unit untMostraLegendasItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass, Uni,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxColorComboBox,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid,
  untLegendasItem, cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmMostraLegendasItem = class(TfrmPaiEdit)
    cxgLegendas: TcxGrid;
    cxgLegendasView: TcxGridDBBandedTableView;
    cxgLegendasViewColumn1: TcxGridDBBandedColumn;
    cxgLegendasViewColumn2: TcxGridDBBandedColumn;
    cxgLegendasLevel1: TcxGridLevel;
    lblLegendaCor: TLabel;
    procedure cxgLegendasViewColumn2StylesGetContentStyle(
      Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
      AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
    procedure FormShow(Sender: TObject);
    procedure cxgLegendasViewDblClick(Sender: TObject);
    procedure cxgLegendasViewColumn1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    cdsLegendas: TLegendasItem;

    Class Procedure pMostraLegendas(objLegendas: TLegendasItem);
  end;

var
  frmMostraLegendasItem: TfrmMostraLegendasItem;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmMostraLegendasItem.cxgLegendasViewColumn1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.Item.Index = cxgLegendasViewColumn1.Index Then
  Begin
    ACanvas.Brush.Color := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgLegendasViewColumn1.Index]),0);
    ACanvas.Font.Color  := StrToIntDef(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgLegendasViewColumn1.Index]),0);
  End;
end;

procedure TfrmMostraLegendasItem.cxgLegendasViewColumn2StylesGetContentStyle(
  Sender: TcxCustomGridTableView; ARecord: TcxCustomGridRecord;
  AItem: TcxCustomGridTableItem; var AStyle: TcxStyle);
begin
  inherited;

  AStyle := cdsLegendas.fRetStyle(ARecord.Values[0]);

end;

procedure TfrmMostraLegendasItem.cxgLegendasViewDblClick(Sender: TObject);
  Var
    ColorDialog : TColorDialog;
    qryUpdate   : TUniQuery;
begin
  inherited;
  If Not fVerificaAcessoSistema('ALTLEG', strLoginUsuarioLogado) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse usuário não tem direitos para executar essa operação!', ['&Ok']);
    Exit;
  End;

  If fVerificaAcessoSistema('frmConsultaCxGridNova') Then
  Begin
    Try
      ColorDialog := TColorDialog.Create(Nil);
      qryUpdate   := fCriaQuery;

      If ColorDialog.Execute Then
      Begin
        If cxgLegendasView.DataController.DataSource.DataSet.FieldByName('TABELA').AsString = 'SITPRO' Then
        Begin
          qryUpdate.SQL.Text := ' UPDATE SITPRO SET SIT_CORSIT = :CORSIT WHERE SIT_CODIGO = :CODIGO ';
          with cxgLegendasView.DataController.DataSource.DataSet Do
            qryUpdate.ParamByName('CODIGO').AsString  := FieldByName('SIT_CODIGO').AsString;
          qryUpdate.ParamByName('CORSIT').AsInteger := ColorDialog.Color;
          qryUpdate.ExecSQL;
        End
        Else
        Begin
          qryUpdate.SQL.Text := ' UPDATE SITITE SET SIT_CODCOR = :CODCOR WHERE SIT_SITUAC = :SITUAC';
          with cxgLegendasView.DataController.DataSource.DataSet Do
            qryUpdate.ParamByName('SITUAC').AsString  := FieldByName('SIT_DESCRI').AsString;
          qryUpdate.ParamByName('CODCOR').AsInteger := ColorDialog.Color;
          qryUpdate.ExecSQL;
        End;

      End;

      cdsLegendas.fAbreClient(True, '');

    Finally
      FreeAndNil(ColorDialog);
      FreeAndNil(qryUpdate);
    End;

  End;
end;

procedure TfrmMostraLegendasItem.FormShow(Sender: TObject);
begin
  inherited;
  lblLegendaCor.Visible := fVerificaAcessoSistema('frmConsultaCxGridNova');
  cxgLegendasView.DataController.DataSource := cdsLegendas.dtsSource;

  If Not fCfgSis('SITPRO', varBoolean) Then
    cxgLegendas.Width := cxgLegendasView.Bands[0].Width;

end;

Class Procedure TfrmMostraLegendasItem.pMostraLegendas(objLegendas: TLegendasItem);
Begin
  pCriarFormularios(TfrmMostraLegendasItem, frmMostraLegendasItem);
  frmMostraLegendasItem.cdsLegendas := objLegendas;
  frmMostraLegendasItem.ShowModal;

  FreeAndNil(frmMostraLegendasItem);
End;


end.
