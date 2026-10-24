unit untAtualizacaoMargemParaFranquiasConfirma;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untTConfiguracao, untFuncoesSimples;

type
  TfrmAtualizacaoMargemParaFranquiasConfirma = class(TfrmPaiConfirma)
    dtsDados: TDataSource;
    cxgDados: TcxGridCitel;
    cxvDados: TcxGridDBTableViewCitel;
    cxvPRODUTO: TcxGridDBColumn;
    cxvITE_CODEMP: TcxGridDBColumn;
    cxvITE_REGTRI: TcxGridDBColumn;
    cxvITE_MARBR1: TcxGridDBColumn;
    cxvITE_PREVE1: TcxGridDBColumn;
    cxvITE_MARBR2: TcxGridDBColumn;
    cxvITE_PREVE2: TcxGridDBColumn;
    cxvITE_MARBR3: TcxGridDBColumn;
    cxvITE_PREVE3: TcxGridDBColumn;
    cxvITE_MARBR4: TcxGridDBColumn;
    cxvITE_PREVE4: TcxGridDBColumn;
    cxvITE_MARBR5: TcxGridDBColumn;
    cxvITE_PREVE5: TcxGridDBColumn;
    cxvITE_MARBR6: TcxGridDBColumn;
    cxvITE_PREVE6: TcxGridDBColumn;
    cxvITE_MARBR7: TcxGridDBColumn;
    cxvITE_PREVE7: TcxGridDBColumn;
    cxldados: TcxGridLevel;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    blnConfirma: Boolean;
    { Public declarations }
  end;

var
  frmAtualizacaoMargemParaFranquiasConfirma: TfrmAtualizacaoMargemParaFranquiasConfirma;

implementation

{$R *.dfm}

procedure TfrmAtualizacaoMargemParaFranquiasConfirma.btnConfirmaClick(
  Sender: TObject);
begin
  blnConfirma := fPergunta('Deseja Alterar as Margens?');
  inherited;

end;

procedure TfrmAtualizacaoMargemParaFranquiasConfirma.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  cxvITE_REGTRI.width := 116;
  cxvITE_CODEMP.width := 80;

end;

end.
