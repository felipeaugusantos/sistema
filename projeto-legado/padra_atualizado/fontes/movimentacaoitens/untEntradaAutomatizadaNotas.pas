unit untEntradaAutomatizadaNotas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxCurrencyEdit, untEntradaAutomatizada,
  cxDataControllerConditionalFormattingRulesManagerDialog;


type
  TfrmEntradaAutomatizadaNotas = class(TfrmPaiConfirma)
    cxgNotasLevel1: TcxGridLevel;
    cxvNotas: TcxGridDBTableViewCitel;
    cxgNotas: TcxGridCitel;
    cxvNotasB08_NNF: TcxGridDBColumn;
    cxvNotasB07_SERIE: TcxGridDBColumn;
    cxvNotasB09_DEMI: TcxGridDBColumn;
    cxvNotasTOTNOT: TcxGridDBColumn;
    cxvNotasGER_CODFOR: TcxGridDBColumn;
    cxvNotasFOR_NOMFOR: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    objEntrada: TEntradaAutomatizada;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmEntradaAutomatizadaNotas.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If objEntrada.fCarregaNota Then
    objEntrada.cdsNotas.Refresh;
end;

procedure TfrmEntradaAutomatizadaNotas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
    Action := caNone;

end;

procedure TfrmEntradaAutomatizadaNotas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmEntradaAutomatizadaNotas.FormShow(Sender: TObject);
begin
  inherited;

  TcxCurrencyEditProperties(cxvNotasTOTNOT.Properties).DisplayFormat := fMskDigitos(2);

end;

end.
