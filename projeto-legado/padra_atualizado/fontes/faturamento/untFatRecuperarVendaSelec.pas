unit untFatRecuperarVendaSelec;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, untRecuperaPedido, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  UniClientDataSet;

type
  TfrmRecuperarVendaSelec = class(TfrmPaiConfirma)
    btnDescarta: TBitBtnLocked;
    cxgVendasLevel: TcxGridLevel;
    cxgVendasView: TcxGridDBTableViewCitel;
    cxgVendas: TcxGridCitel;
    cxgVendasViewColumn1: TcxGridDBColumn;
    cxgVendasViewColumn2: TcxGridDBColumn;
    cxgVendasViewColumn3: TcxGridDBColumn;
    cxgVendasViewNUMPED: TcxGridDBColumn;
    cxgVendasViewVALPED: TcxGridDBColumn;
    cxgVendasViewColumn5: TcxGridDBColumn;
    cxgVendasViewColumn6: TcxGridDBColumn;
    cxgVendasViewColumn7: TcxGridDBColumn;
    cdsVendas: TUniClientDataSet;
    cdsVendasCODOPE: TStringField;
    cdsVendasNOMOPE: TStringField;
    cdsVendasCODEMP: TStringField;
    cdsVendasNUMDOC: TStringField;
    cdsVendasCODCLI: TStringField;
    cdsVendasNOMCLI: TStringField;
    cdsVendasHORVEN: TDateTimeField;
    cdsVendasNOMTAB: TStringField;
    cdsVendasVALDOC: TFloatField;
    dtsVendas: TDataSource;
    procedure btnDescartaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmRecuperarVendaSelec.btnDescartaClick(Sender: TObject);
begin
  inherited;

  If cdsVendas.IsEmpty Then
    Exit;

  If fPergunta
    ('Confirma o descarte da cópia de segurança da venda selecionada?') Then
  Begin
    fDropTable(cdsVendasNOMTAB.AsString);
    fDropTable(cdsVendasNOMTAB.AsString.Replace('GER', 'DET'));
    cdsVendas.Delete;
    If cdsVendas.IsEmpty Then
      btnConfirma.Enabled := False;
  End;

End;

procedure TfrmRecuperarVendaSelec.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If ModalResult = mrok Then
    If cdsVendas.IsEmpty Then
      Action := caNone;
end;

procedure TfrmRecuperarVendaSelec.FormCreate(Sender: TObject);
begin
  inherited;
  cdsVendas.CreateDataSet;
end;

end.
