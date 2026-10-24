unit untSelCamposExportaEstoqueEmExcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCheckBox;

type
  TfrmSelCamposExportaEstoqueEmExcesso = class(TfrmPaiConfirma)
    cxvDados: TcxGridDBTableViewCitel;
    cxlDados: TcxGridLevel;
    cxDados: TcxGridCitel;
    dtsDados: TDataSource;
    cxvDadosColumn1: TcxGridDBColumn;
    cxvDadosColumn2: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    blnConfirma: Boolean;
    { Public declarations }
  end;

var
  frmSelCamposExportaEstoqueEmExcesso: TfrmSelCamposExportaEstoqueEmExcesso;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmSelCamposExportaEstoqueEmExcesso.btnConfirmaClick(
  Sender: TObject);
var blnMarcado: Boolean;
begin
  dtsDados.DataSet.First;
  blnMarcado := False;
  while not dtsDados.DataSet.Eof Do
  Begin
    blnMarcado := dtsDados.DataSet.FieldByName('ANA_EXPORT').AsInteger = 1;
    If blnMarcado then
      dtsDados.DataSet.Last
    Else
    dtsDados.DataSet.Next;
  End;
  If Not blnMarcado Then
  Begin
    pMEnsagemOk('Pelo menos uma coluna deve ser selecionada!');
    Exit;
  End;
  blnConfirma := True;
  Close;
end;

procedure TfrmSelCamposExportaEstoqueEmExcesso.FormActivate(Sender: TObject);
begin
  inherited;
   dtsDados.DataSet.First;
end;

procedure TfrmSelCamposExportaEstoqueEmExcesso.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

end.
