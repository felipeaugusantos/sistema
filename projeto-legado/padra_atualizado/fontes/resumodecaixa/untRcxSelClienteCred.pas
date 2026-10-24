{***************************}
{* qryConCli -> CADCLI     *}
{************************JB*}

unit untRcxSelClienteCred;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  MemDS, DBAccess, Datasnap.Provider, UniDataSetProvider, Datasnap.DBClient,
  UniClientDataSet, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, untFuncoesGenerica;

type
  TfrmRcxSelClienteCred = class(TfrmPaiSimples)
    pnlDados: TPanel;
    btnConfirma: TBitBtnLocked;
    gridSelClientesCredito: TcxGrid;
    gridSelClientesCreditoDBTableView1: TcxGridDBTableView;
    gridSelClientesCreditoCLI_C_G_C_: TcxGridDBColumn;
    gridSelClientesCreditoCLI_NOMCLI: TcxGridDBColumn;
    gridSelClientesCreditoLevel1: TcxGridLevel;
    dtsCadCli: TDataSource;
    cdsCadCli: TUniClientDataSet;
    dspqryCli: TUniDataSetProvider;
    qryCredCli: TUniQuery;
    gridSelClientesCreditoCLI_CODCLI: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure gridSelClientesCreditoDBTableView1KeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    blnClose : Boolean;
  protected
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodOpe: String;
    strStatus: String;
  end;


implementation

uses untfuncoesSimples, untPesqAux, untPai, untConsultas, untTypesSistema,
  untRelCtrReimpressaoDocs;

{$R *.dfm}

procedure TfrmRcxSelClienteCred.gridSelClientesCreditoDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: Begin
                 blnClose := True;
                 btnConfirma.Click;
               End;
  End;

end;

procedure TfrmRcxSelClienteCred.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  blnClose := True;
  Close;
end;

procedure TfrmRcxSelClienteCred.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If Not blnClose Then
  Begin
     fMensagem('ATENÇÃO!', 'É necessário que informe um cliente para o crédito!', ['&Ok']);
     Action := CaNone;
  End;
end;

procedure TfrmRcxSelClienteCred.FormCreate(Sender: TObject);
begin
  inherited;
  blnClose := False;
end;

end.

