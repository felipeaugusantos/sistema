unit untOrdProIndDesenvQtds;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxCurrencyEdit, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGrid, untOrdProIndustrial, untFuncoesSimples,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmOrdProIndDesenvQtds = class(TfrmPaiEdit)
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensViewColumn1: TcxGridDBColumn;
    cxgItensViewColumn2: TcxGridDBColumn;
    cxgItensViewColumn3: TcxGridDBColumn;
    cxgItensQTDPRO: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    btnConfirma: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    objOrdPro: TOrdProIndustrial;
  end;

var
  frmOrdProIndDesenvQtds: TfrmOrdProIndDesenvQtds;

implementation

{$R *.dfm}

procedure TfrmOrdProIndDesenvQtds.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not objOrdPro.fVerificaQuantidadeDigitada Then
    Begin
      Action := caNone;
      pMensagemOk('Informe a quantidade a ser produzida!');
    End;

  End;

end;

end.
