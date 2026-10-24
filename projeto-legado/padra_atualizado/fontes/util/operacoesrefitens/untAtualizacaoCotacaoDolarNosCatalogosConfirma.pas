unit untAtualizacaoCotacaoDolarNosCatalogosConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, untTAtualizacaoCotacaoDolarNosCatalogos,
  Vcl.ComCtrls, cxCurrencyEdit, cxCalc;

type
  TfrmAtualizacaoCotacaoDolarNosCatalogosConfirma = class(TfrmPaiConfirma)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    dtsItens: TDataSource;
    cxgItensViewMARBR1: TcxGridDBColumn;
    cxgItensViewMARBR1_NOV: TcxGridDBColumn;
    cxgItensViewPREVE1: TcxGridDBColumn;
    cxgItensViewPREVE1_NOV: TcxGridDBColumn;
    cxgItensViewMARBR2: TcxGridDBColumn;
    cxgItensViewMARBR2_NOV: TcxGridDBColumn;
    cxgItensViewPREVE2: TcxGridDBColumn;
    cxgItensViewPREVE2_NOV: TcxGridDBColumn;
    cxgItensViewMARBR3: TcxGridDBColumn;
    cxgItensViewMARBR3_NOV: TcxGridDBColumn;
    cxgItensViewPREVE3: TcxGridDBColumn;
    cxgItensViewPREVE3_NOV: TcxGridDBColumn;
    cxgItensViewMARBR4: TcxGridDBColumn;
    cxgItensViewMARBR4_NOV: TcxGridDBColumn;
    cxgItensViewPREVE4: TcxGridDBColumn;
    cxgItensViewPREVE4_NOV: TcxGridDBColumn;
    cxgItensViewMARBR5: TcxGridDBColumn;
    cxgItensViewMARBR5_NOV: TcxGridDBColumn;
    cxgItensViewPREVE5: TcxGridDBColumn;
    cxgItensViewPREVE5_NOV: TcxGridDBColumn;
    cxgItensViewMARBR6: TcxGridDBColumn;
    cxgItensViewMARBR6_NOV: TcxGridDBColumn;
    cxgItensViewPREVE6: TcxGridDBColumn;
    cxgItensViewPREVE6_NOV: TcxGridDBColumn;
    cxgItensViewMARBR7: TcxGridDBColumn;
    cxgItensViewMARBR7_NOV: TcxGridDBColumn;
    cxgItensViewPREVE7: TcxGridDBColumn;
    cxgItensViewPREVE7_NOV: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    pnlProgress: TPanel;
    lblInf: TLabel;
    prgProgress: TProgressBar;
    cxgItensViewDESITE: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    FTipoCalculo: TCalculo;
    procedure pSetTipoCalculo(const Value: TCalculo);
    { Private declarations }
  public
    ObjAtualizacao : TAtualizacaoCotacaoDolarNosCatalogos;
    property TipoCalculo: TCalculo read FTipoCalculo write pSetTipoCalculo;

    { Public declarations }
  end;

var
  frmAtualizacaoCotacaoDolarNosCatalogosConfirma: TfrmAtualizacaoCotacaoDolarNosCatalogosConfirma;

implementation

uses
  untConstantes, untFuncoesSimples;


{$R *.dfm}

procedure TfrmAtualizacaoCotacaoDolarNosCatalogosConfirma.btnConfirmaClick(
  Sender: TObject);
begin
  inherited;
  Try
    ObjAtualizacao.pGravar;
  Finally
    pnlProgress.Visible := False;
  End;
end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogosConfirma.FormCreate(
  Sender: TObject);
begin
  inherited;
  TipoCalculo := tcPrecoVenda;
end;

procedure TfrmAtualizacaoCotacaoDolarNosCatalogosConfirma.pSettipoCalculo(
  const Value: TCalculo);
begin
  FTipoCalculo := Value;

  cxgItensViewMARBR1_NOV.Visible := (FTipoCalculo = tcPrecoMargem) And (VS_strTabPrc[1] = 'S');
  cxgItensViewPREVE1_NOV.Visible := (FTipoCalculo = tcPrecoVenda)  And (VS_strTabPrc[1] = 'S');
  cxgItensViewMARBR2_NOV.Visible := (FTipoCalculo = tcPrecoMargem) And (VS_strTabPrc[2] = 'S');
  cxgItensViewPREVE2_NOV.Visible := (FTipoCalculo = tcPrecoVenda)  And (VS_strTabPrc[2] = 'S');
  cxgItensViewMARBR3_NOV.Visible := (FTipoCalculo = tcPrecoMargem) And (VS_strTabPrc[3] = 'S');
  cxgItensViewPREVE3_NOV.Visible := (FTipoCalculo = tcPrecoVenda)  And (VS_strTabPrc[3] = 'S');
  cxgItensViewMARBR4_NOV.Visible := (FTipoCalculo = tcPrecoMargem) And (VS_strTabPrc[4] = 'S');
  cxgItensViewPREVE4_NOV.Visible := (FTipoCalculo = tcPrecoVenda)  And (VS_strTabPrc[4] = 'S');
  cxgItensViewMARBR5_NOV.Visible := (FTipoCalculo = tcPrecoMargem) And (VS_strTabPrc[5] = 'S');
  cxgItensViewPREVE5_NOV.Visible := (FTipoCalculo = tcPrecoVenda)  And (VS_strTabPrc[5] = 'S');
  cxgItensViewMARBR6_NOV.Visible := (FTipoCalculo = tcPrecoMargem) And (VS_strTabPrc[6] = 'S');
  cxgItensViewPREVE6_NOV.Visible := (FTipoCalculo = tcPrecoVenda)  And (VS_strTabPrc[6] = 'S');
  cxgItensViewMARBR7_NOV.Visible := (FTipoCalculo = tcPrecoMargem) And (VS_strTabPrc[7] = 'S');
  cxgItensViewPREVE7_NOV.Visible := (FTipoCalculo = tcPrecoVenda)  And (VS_strTabPrc[7] = 'S');
end;

end.
