unit untClienteResumo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrameClienteResumo, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxInplaceContainer,
  cxVGrid, cxDBVGrid, Uni;

type
  TfrmClienteResumo = class(TfrmPaiEdit)
    fraClienteResumo: TfraClienteResumo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    qryResumo: TUniQuery;
    { Private declarations }
  public
    function fCarregaResumo(ACodCli, ACodAbf: String): Boolean;
    { Public declarations }
  end;

var
  frmClienteResumo: TfrmClienteResumo;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmClienteResumo.fCarregaResumo(ACodCli, ACodAbf: String): Boolean;
begin
  qryResumo := fCriaQuery;

  fraClienteResumo.DataSource.DataSet := qryResumo;

  qryResumo.SQL.Text := fSQLResumoDeBeneficiosDoCliente;
  qryResumo.ParamByName('CODCLI').AsString := ACodCli;
  qryResumo.ParamByName('CODABF').AsString := ACodAbf;
  qryResumo.Open;

  Result := (qryResumo.recordCount > 0);

  If Result Then
    fraClienteResumo.pHabilitarDesabilitarInformacoesResumoBeneficios;
end;

procedure TfrmClienteResumo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If Assigned(qryResumo) Then
  Begin
    FreeAndNil(qryResumo);
  End;
end;

procedure TfrmClienteResumo.FormCreate(Sender: TObject);
begin
  inherited;
  qryResumo := nil;
end;

end.
