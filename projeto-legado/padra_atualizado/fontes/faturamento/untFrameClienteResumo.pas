unit untFrameClienteResumo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxInplaceContainer,
  cxVGrid, cxDBVGrid, Uni, Data.DB;

type
  TfraClienteResumo = class(TFrame)
    cxDBVerticalGrid: TcxDBVerticalGrid;
    DataSource: TDataSource;
    cxDBVerticalGridTipodeAbrevFiscaldeICMS: TcxDBEditorRow;
    cxDBVerticalGridIndstria: TcxDBEditorRow;
    cxDBVerticalGridZonaFranca: TcxDBEditorRow;
    cxDBVerticalGridrgoPblico: TcxDBEditorRow;
    cxDBVerticalGridIsenodeIPI: TcxDBEditorRow;
    cxDBVerticalGridBenefcioREIDI: TcxDBEditorRow;
    cxDBVerticalGridUtilizardiferimentodeICMS: TcxDBEditorRow;
    cxDBVerticalGridSujeitopassivoporSTatribuidaporregimeespecial: TcxDBEditorRow;
    cxDBVerticalGridSuframa: TcxDBEditorRow;
    cxDBVerticalGridValidadeSuframa: TcxDBEditorRow;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pHabilitarDesabilitarInformacoesResumoBeneficios;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfraClienteResumo }

procedure TfraClienteResumo.pHabilitarDesabilitarInformacoesResumoBeneficios;
begin
  If (Not Assigned(DataSource)) Or
     (Not Assigned(DataSource.DataSet)) Or
     (DataSource.DataSet.RecordCount = 0) Then
    Exit;

  cxDBVerticalGridIndstria.Visible :=
    (Not fEmptyStr(cxDBVerticalGridIndstria.Properties.Values[0]));

  cxDBVerticalGridZonaFranca.Visible :=
    (Not fEmptyStr(cxDBVerticalGridZonaFranca.Properties.Values[0]));
  cxDBVerticalGridSuframa.Visible         := cxDBVerticalGridZonaFranca.Visible;
  cxDBVerticalGridValidadeSuframa.Visible := cxDBVerticalGridZonaFranca.Visible;

  cxDBVerticalGridrgoPblico.Visible :=
    (Not fEmptyStr(cxDBVerticalGridrgoPblico.Properties.Values[0]));

  cxDBVerticalGridIsenodeIPI.Visible :=
    (Not fEmptyStr(cxDBVerticalGridIsenodeIPI.Properties.Values[0]));

  cxDBVerticalGridBenefcioREIDI.Visible :=
    (Not fEmptyStr(cxDBVerticalGridBenefcioREIDI.Properties.Values[0]));

  cxDBVerticalGridUtilizardiferimentodeICMS.Visible :=
    (Not fEmptyStr(cxDBVerticalGridUtilizardiferimentodeICMS.Properties.Values[0]));

  cxDBVerticalGridSujeitopassivoporSTatribuidaporregimeespecial.Visible :=
    (Not fEmptyStr(cxDBVerticalGridSujeitopassivoporSTatribuidaporregimeespecial.Properties.Values[0]));
end;

end.
