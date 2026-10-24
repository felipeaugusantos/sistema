unit untRelSimplesNacionalResumoEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxCurrencyEdit;

type
  TfrmRelSimplesNacionalResumoEmpresa = class(TfrmPai)
    cxgDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxDadois: TcxGridCitel;
    dtsDados: TDataSource;
    cxgDadosEMPRESA: TcxGridDBColumn;
    cxgDadosCNPJ: TcxGridDBColumn;
    cxgDadosValor: TcxGridDBColumn;
    procedure cxgDadosTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
  private
    { Private declarations }
  public
     class procedure pCallResumo(DataSet: TDataSet; meses: string);

    { Public declarations }
  end;

var
  frmRelSimplesNacionalResumoEmpresa: TfrmRelSimplesNacionalResumoEmpresa;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmRelSimplesNacionalResumoEmpresa }

procedure TfrmRelSimplesNacionalResumoEmpresa.cxgDadosTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  If fEmptyStr(AText) Then
    AText := '0';
  AText := FormatFloat('#,##0.00', StrToFloat(AText));
end;

class procedure TfrmRelSimplesNacionalResumoEmpresa.pCallResumo(
  DataSet: TDataSet; meses: string);
  var frmRelSimplesResumo:TfrmRelSimplesNacionalResumoEmpresa;
begin
  pCriarFormularios(TfrmRelSimplesNacionalResumoEmpresa, frmRelSimplesResumo);
  Try
    frmRelSimplesResumo.dtsDados.DataSet := DataSet;
    frmRelSimplesResumo.cxgDadosValor.Caption := 'Vr. Faturamento dos ['+meses+'] meses anteriores';
    frmRelSimplesResumo.ShowModal;
  Finally
    FreeAndNil(frmRelSimplesResumo) ;
  End;
end;

end.
