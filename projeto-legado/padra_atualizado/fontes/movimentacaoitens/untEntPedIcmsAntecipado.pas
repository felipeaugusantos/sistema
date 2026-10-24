unit untEntPedIcmsAntecipado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons,
  BitBtnLockedIncrem, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckBox, ComCtrls,
  untEntIcmsAntecipado, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmEntPedIcmsAntecipado = class(TfrmPaiConfirma)
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensCODITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensREFERE: TcxGridDBColumn;
    cxgItensUNIDAD: TcxGridDBColumn;
    cxgItensCODCST: TcxGridDBColumn;
    cxgItensANTPRO: TcxGridDBColumn;
    cxgItensANTFRE: TcxGridDBColumn;
    prbProgresso: TProgressBar;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cdsItens: TIcmsAntecipado;
    blnConfirma: Boolean;
  end;

var
  frmEntPedIcmsAntecipado: TfrmEntPedIcmsAntecipado;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmEntPedIcmsAntecipado.btnConfirmaClick(Sender: TObject);
begin
//  inherited;

  If cdsItens.fCalculaIcmsAntecipado(prbProgresso) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmEntPedIcmsAntecipado.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;

end;

procedure TfrmEntPedIcmsAntecipado.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: begin
      btnConfirma.Click;
      Key := 0;
    end;

  End;
  
end;

procedure TfrmEntPedIcmsAntecipado.FormShow(Sender: TObject);
begin
  inherited;

  cxgItensView.DataController.DataSource := cdsItens.dtsSource;
  cxgItensANTFRE.Properties.ReadOnly     := Not fCfgSis('DESFRE', varBoolean);

end;

end.
