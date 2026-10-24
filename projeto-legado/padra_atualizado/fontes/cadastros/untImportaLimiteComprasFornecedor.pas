unit untImportaLimiteComprasFornecedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.DBCtrls, DBMemoFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCurrencyEdit,
  untLimiteComprasFornecedor, cxCheckBox;

type
  TfrmImportaLimiteComprasFornecedor = class(TfrmPaiConfirma)
    cxvLinhas: TcxGridDBTableView;
    cxgLinhasLevel1: TcxGridLevel;
    cxgLinhas: TcxGrid;
    cxvLinhasCODFOR: TcxGridDBColumn;
    cxvLinhasNOMFOR: TcxGridDBColumn;
    cxvLinhasNROANO: TcxGridDBColumn;
    cxvLinhasNROMES: TcxGridDBColumn;
    cxvLinhasVALPED: TcxGridDBColumn;
    cxvLinhasMSGERR: TcxGridDBColumn;
    cxvLinhasVALANT: TcxGridDBColumn;
    cxvLinhasCOMERR: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    objLimite: TLimiteComprasFornecedor;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmImportaLimiteComprasFornecedor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If fPergunta('Confirma a importação dos dados?') Then
    Begin
      If objLimite.fSalvaCSV Then
      Begin

        pMensagemOk('Dados importados com sucesso!');

      End Else
      Begin
        Action := caNone;
        Exit;
      End;

    End Else
    Begin
      Action := caNone;
      Exit;
    End;

  End Else
  Begin

    If Not fPergunta('Deseja abandonar a tarefa?') Then
    Begin
      Action := caNone;
      Exit;
    End;

  End;


end;

procedure TfrmImportaLimiteComprasFornecedor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

procedure TfrmImportaLimiteComprasFornecedor.FormShow(Sender: TObject);
begin
  inherited;

  cxvLinhas.DataController.DataSource := objLimite.cdsDadosImportacao.dtsSource;
end;

end.
