unit untCadPromocoesItensAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Uni;

type
  TfrmCadPromocoesItensAdd = class(TfrmPaiConfirma)
    grdDadosTv: TcxGridDBTableViewCitel;
    grdDadosLv: TcxGridLevel;
    grdDados: TcxGridCitel;
    dtsDados: TDataSource;
    grdDadosTvCODITE: TcxGridDBColumn;
    grdDadosTvDESITE: TcxGridDBColumn;
    grdDadosTvPRECUS: TcxGridDBColumn;
    grdDadosTvPREVEN: TcxGridDBColumn;
    grdDadosTvCOMVAR: TcxGridDBColumn;
    grdDadosTvCOMATA: TcxGridDBColumn;
    grdDadosTvCOMDIS: TcxGridDBColumn;
    grdDadosTvPRZMED: TcxGridDBColumn;
    grdDadosTvQTDMIN: TcxGridDBColumn;
    grdDadosTvQTDLIM: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FqryDados: TUniQuery;
  public
    { Public declarations }
    procedure pSetDados(qryItens: TUniQuery);
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure TfrmCadPromocoesItensAdd.FormShow(Sender: TObject);
var
  intDecUni: Integer;
begin
  inherited;
  intDecUni := fCfgSis('DECUNI', varInteger);

  TFloatField(FqryDados.FieldByName('X_QTDMIN')).DisplayFormat := '#,##0.00';
  TFloatField(FqryDados.FieldByName('X_QTDLIM')).DisplayFormat := '#,##0.00';
  TFloatField(FqryDados.FieldByName('X_PRECUS')).DisplayFormat := '#,##0.00';
  TFloatField(FqryDados.FieldByName('X_PREVEN')).DisplayFormat := fMskDigitos(intDecUni);
  TFloatField(FqryDados.FieldByName('X_COMVAR')).DisplayFormat := '#,##0.00';
  TFloatField(FqryDados.FieldByName('X_COMATA')).DisplayFormat := '#,##0.00';
  TFloatField(FqryDados.FieldByName('X_COMDIS')).DisplayFormat := '#,##0.00';

end;

procedure TfrmCadPromocoesItensAdd.pSetDados(qryItens: TUniQuery);
begin
  FqryDados := qryItens;
  dtsDados.DataSet := FqryDados;
end;

end.
