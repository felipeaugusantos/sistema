unit untCopiaParametrosEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.CheckLst, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, untParametrosEmpresa;

type
  TfrmCopiaParametrosEmpresa = class(TfrmPaiConfirma)
    Panel1: TPanel;
    Panel2: TPanel;
    lblEmpresas: TLabel;
    Label2: TLabel;
    cxvColunas: TcxGridDBTableView;
    cxgColunasLevel1: TcxGridLevel;
    cxgColunas: TcxGrid;
    cxvColunasNOMGRU: TcxGridDBColumn;
    cxvColunasNOMCOL: TcxGridDBColumn;
    cxvColunasCOPIAR: TcxGridDBColumn;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    objParametros: TParametrosEmpresa;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmCopiaParametrosEmpresa.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  objParametros.pColunasCopiaMarcaTodas(False);
end;

procedure TfrmCopiaParametrosEmpresa.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  objParametros.pColunasCopiaMarcaTodas(True);
end;

procedure TfrmCopiaParametrosEmpresa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If Not objParametros.fCopiaValores Then
    Begin
      Action := caNone;
      Exit;
    End;

  End;
end;

procedure TfrmCopiaParametrosEmpresa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F6: btnMarcaTodos.Click;
    VK_F7: btnDesmarcaTodos.Click;
  End;
end;

end.
