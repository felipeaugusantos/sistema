unit untEscolhePisCofinsFrete;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCitel,
  cxClasses, cxGridLevel, cxGrid, cxCurrencyEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmEscolhePisCofinsFrete = class(TfrmPaiEdit)
    btnConfirma: TBitBtnLocked;
    cxGridCitel1Level1: TcxGridLevel;
    cxgConsulta: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    cxgConsultaCLAFIS: TcxGridDBColumn;
    cxgConsultaColumn2: TcxGridDBColumn;
    cxgConsultaColumn3: TcxGridDBColumn;
    cxgConsultaColumn4: TcxGridDBColumn;
    cxgConsultaColumn5: TcxGridDBColumn;
    chkCopTodas: TCheckBox;
    procedure cxgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEscolhePisCofinsFrete: TfrmEscolhePisCofinsFrete;

implementation

{$R *.dfm}

procedure TfrmEscolhePisCofinsFrete.cxgConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: btnConfirma.Click;
  End;
end;

end.
