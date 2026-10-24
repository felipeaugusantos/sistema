unit untQckFatDemonstracaoCamp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiQck, RLPreviewForm, RLParser, RLReport, Uni, DB;

type
  TfrmQckFatDemonstracaoCamp = class(TfrmPaiQck)
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDBText7: TRLDBText;
    RLDBText8: TRLDBText;
    RLDBText9: TRLDBText;
    RLLabel7: TRLLabel;
    RLLabel8: TRLLabel;
    RLLabel9: TRLLabel;
    RLDBResult1: TRLDBResult;
    RLDBResult2: TRLDBResult;
    RLDBResult3: TRLDBResult;
    RLDBResult4: TRLDBResult;
    RLLabel10: TRLLabel;
    rlbResumoTotal: TRLBand;
    RLLabel11: TRLLabel;
    RLDBResult7: TRLDBResult;
    RLDBResult8: TRLDBResult;
    RLDBResult9: TRLDBResult;
    RLDBResult10: TRLDBResult;
    rllRede: TRLLabel;
    rllCliente: TRLLabel;
    rllCampanha: TRLLabel;
    rllStatus: TRLLabel;
    RLLabel12: TRLLabel;
    RLDBResult5: TRLDBResult;
    RLDBResult6: TRLDBResult;
    rllQtdSalParc: TRLLabel;
    rllVlrSalParc: TRLLabel;
    RLDBResult11: TRLDBResult;
    RLDBResult12: TRLDBResult;
    rllQtdSalTotal: TRLLabel;
    rllVlrSalTotal: TRLLabel;
    rllEmpresa: TRLLabel;
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure rlbDetalheGrupoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbResumoGrupoBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
    procedure rlbResumoTotalBeforePrint(Sender: TObject;
      var PrintIt: Boolean);
  private
    { Private declarations }
    fltQtdCamParc : Double;
    fltVlrCamParc : Double;
    fltQtdFatParc : Double;
    fltVlrFatParc : Double;
    fltQtdCamTotal: Double;
    fltVlrCamTotal: Double;
    fltQtdFatTotal: Double;
    fltVlrFatTotal: Double;
  public
    { Public declarations }
    procedure pSetaDataSource(DataSource: TDataSource);
  end;

implementation

{$R *.dfm}

procedure TfrmQckFatDemonstracaoCamp.pSetaDataSource(DataSource: TDataSource);
  var
    intCnt : Integer;
begin
  qckPagina.DataSource := DataSource;
  for intCnt := 0 to Pred(Self.ComponentCount) do
  begin
    if (Self.Components[intCnt] Is TRLDBText) then
      TRLDBText(Self.Components[intCnt]).DataSource := DataSource
    else if (Self.Components[intCnt] Is TRLDBResult) then
      TRLDBResult(Self.Components[intCnt]).DataSource := DataSource;
  end;
end;

procedure TfrmQckFatDemonstracaoCamp.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  inherited;

    fltQtdCamParc := 0;
    fltVlrCamParc := 0;
    fltQtdFatParc := 0;
    fltVlrFatParc := 0;
    fltQtdCamTotal:= 0;
    fltVlrCamTotal:= 0;
    fltQtdFatTotal:= 0;
    fltVlrFatTotal:= 0;
end;

{*********************************************}
{* ACUMULA VALORES PARA SOMA PARCIAL E TOTAL *}
{******************************************RL*}
procedure TfrmQckFatDemonstracaoCamp.rlbDetalheGrupoBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  with qckPagina.DataSource.DataSet do
  begin
    fltQtdCamParc := fltQtdCamParc + FieldByName('QTDCAM').AsFloat;
    fltVlrCamParc := fltVlrCamParc + FieldByName('VLRCAM').AsFloat;
    fltQtdFatParc := fltQtdFatParc + FieldByName('QTDFAT').AsFloat;
    fltVlrFatParc := fltVlrFatParc + FieldByName('VLRFAT').AsFloat;

    fltQtdCamTotal := fltQtdCamTotal + FieldByName('QTDCAM').AsFloat;
    fltVlrCamTotal := fltVlrCamTotal + FieldByName('VLRCAM').AsFloat;
    fltQtdFatTotal := fltQtdFatTotal + FieldByName('QTDFAT').AsFloat;
    fltVlrFatTotal := fltVlrFatTotal + FieldByName('VLRFAT').AsFloat;
  end;
end;

{*******************************************}
{* ESCREVE SOMA PARCIAL                    *}
{****************************************RL*}
procedure TfrmQckFatDemonstracaoCamp.rlbResumoGrupoBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;

  rllQtdSalParc.Caption := FloatToStrF(fltQtdCamParc - fltQtdFatParc, ffFixed, 14, 3);
  rllVlrSalParc.Caption := FloatToStrF(fltVlrCamParc - fltVlrFatParc, ffFixed, 12, 2);

  fltQtdCamParc := 0;
  fltVlrCamParc := 0;
  fltQtdFatParc := 0;
  fltVlrFatParc := 0;

end;

{*******************************************}
{* ESCREVE SOMA TOTAL                      *}
{****************************************RL*}
procedure TfrmQckFatDemonstracaoCamp.rlbResumoTotalBeforePrint(
  Sender: TObject; var PrintIt: Boolean);
begin
  inherited;
  rllQtdSalTotal.Caption := FloatToStrF(fltQtdCamTotal - fltQtdFatTotal, ffFixed, 14, 3);
  rllVlrSalTotal.Caption := FloatToStrF(fltVlrCamTotal - fltVlrFatTotal, ffFixed, 12, 2);
end;

end.

