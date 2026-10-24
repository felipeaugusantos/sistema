unit untVisualizarCubagemPaletizacaoDosProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Uni, Datasnap.DBClient,
  UniClientDataSet;

type
  TfrmVisualizarCubagemPaletizacaoDosProdutos = class(TfrmPai)
    cxgCubagemEPaletizacao: TcxGrid;
    cxgVisualizarCubagemEPaletizacaoView: TcxGridDBTableView;
    cxgVisualizarCubagemEPaletizacao: TcxGridLevel;
    cdsCUBPAL: TUniClientDataSet;
    dscCUBPAL: TDataSource;
    cdsCUBPALCODITE: TStringField;
    cdsCUBPALDESITE: TStringField;
    cdsCUBPALSIGUNI: TStringField;
    cdsCUBPALQTDITE: TFloatField;
    cdsCUBPALPESBRU: TFloatField;
    cdsCUBPALCUB_M3: TFloatField;
    cdsCUBPALQTDCXA: TFloatField;
    cxgVisualizarCubagemEPaletizacaoViewCODITE: TcxGridDBColumn;
    cxgVisualizarCubagemEPaletizacaoViewDESITE: TcxGridDBColumn;
    cxgVisualizarCubagemEPaletizacaoViewSIGUNI: TcxGridDBColumn;
    cxgVisualizarCubagemEPaletizacaoViewQTDITE: TcxGridDBColumn;
    cxgVisualizarCubagemEPaletizacaoViewPESBRU: TcxGridDBColumn;
    cxgVisualizarCubagemEPaletizacaoViewCUB_M3: TcxGridDBColumn;
    cxgVisualizarCubagemEPaletizacaoViewQTDCXA: TcxGridDBColumn;
    lblLegendaQtdCaixa: TLabel;
    procedure FormShow(Sender: TObject);
  private
    FcdsVenda: TUniClientDataSet;
    function fRetQuantidadeCaixa(strCodigoItem: String; fltQuantidadeItem: Double): Double;
  public
    property cdsVenda : TUniClientDataSet read FcdsVenda;
    procedure pSetDados(AcdsVenda : TUniClientDataSet);
    procedure pProcessarDados;
  end;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica;

{$R *.dfm}

{ TfrmVisualizarCubagemPaletizacaoDosProdutos }

procedure TfrmVisualizarCubagemPaletizacaoDosProdutos.FormShow(Sender: TObject);
begin
  inherited;

  cxgVisualizarCubagemEPaletizacaoView.DataController.Summary.FooterSummaryItems[0].Format := fMskDigitos(fCfgSis('DECCUB', varInteger));
  cdsCUBPALCUB_M3.DisplayFormat := fMskDigitos(fCfgSis('DECCUB', varInteger));

  pProcessarDados;
end;

function TfrmVisualizarCubagemPaletizacaoDosProdutos.fRetQuantidadeCaixa(strCodigoItem: String; fltQuantidadeItem: Double): Double;
  Var
    fltQuantidadeCaixa: Double;
begin
  fltQuantidadeCaixa := fRetMltVenItem(strCodigoItem);

  If fltQuantidadeCaixa <= 0 Then
    fltQuantidadeCaixa := 1;

  fltQuantidadeCaixa := fltQuantidadeItem / fltQuantidadeCaixa;

  Result := fltQuantidadeCaixa;
end;

procedure TfrmVisualizarCubagemPaletizacaoDosProdutos.pProcessarDados;
begin

  If Not Assigned(Self.cdsVenda) Then
    Exit;

  If Not (Self.cdsVenda.RecordCount > 0) Then
    Exit;

  cdsCUBPAL.CreateDataSet;
  cdsCUBPAL.EmptyDataSet;

  Self.cdsVenda.DisableControls;

  Try

    Self.cdsVenda.First;
    While Not Self.cdsVenda.Eof Do
    Begin

      cdsCUBPAL.Append;
      cdsCUBPALCODITE.AsString := Self.cdsVenda.FieldByName('ITE_CODITE').AsString;
      cdsCUBPALDESITE.AsString := Self.cdsVenda.FieldByName('ITE_DESITE').AsString;
      cdsCUBPALSIGUNI.AsString := Self.cdsVenda.FieldByName('ITE_SIGUNI').AsString;
      cdsCUBPALQTDITE.AsFloat  := Self.cdsVenda.FieldByName('ITE_QTDITE').AsFloat;
      cdsCUBPALPESBRU.AsFloat  := Self.cdsVenda.FieldByName('ITE_QTDITE').AsFloat *
                                  Self.cdsVenda.FieldByName('ITE_PESOIT').AsFloat;
      cdsCUBPALCUB_M3.AsFloat  := fRetCubagemItem(cdsCUBPALCODITE.AsString, cdsCUBPALQTDITE.AsFloat);
      cdsCUBPALQTDCXA.AsFloat  := fRetQuantidadeCaixa(cdsCUBPALCODITE.AsString, cdsCUBPALQTDITE.AsFloat);
      cdsCUBPAL.Post;

      Self.cdsVenda.Next;

    End;

  Finally
    Self.cdsVenda.EnableControls;
  End;

end;

procedure TfrmVisualizarCubagemPaletizacaoDosProdutos.pSetDados(AcdsVenda: TUniClientDataSet);
begin
  FcdsVenda := AcdsVenda;
end;

end.
