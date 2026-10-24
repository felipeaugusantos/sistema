unit untCustosFreteQualP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Data.DB, Datasnap.DBClient,
  UniClientDataSet, Vcl.Grids, Vcl.DBGrids, DBGridCitel, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmCustosFreteQualP = class(TfrmPai)
    dbgRotas: TDBGridCitel;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    pnlTotalizador: TPanel;
    cdsConsultaCIDADE: TStringField;
    cdsConsultaVALOR_COMBUSTIVEL: TFloatField;
    cdsConsultaVALOR_PEDAGIO: TFloatField;
    cdsConsultaTOTAL: TFloatField;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblPedagio: TLabel;
    lblCombustivel: TLabel;
    lblTotal: TLabel;
    lblAcrescFrete: TLabel;
    lblValorAcresc: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure pCarregaTotais(const fltPedagio, fltCombustivel, fltAcrescFrete: Double);
  end;

implementation

{$R *.dfm}

procedure TfrmCustosFreteQualP.FormCreate(Sender: TObject);
begin
  inherited;
  If Not cdsConsulta.Active Then
    cdsConsulta.CreateDataSet;
end;

procedure TfrmCustosFreteQualP.pCarregaTotais(const fltPedagio, fltCombustivel,
  fltAcrescFrete: Double);
begin
  lblPedagio.Caption     := FormatFloat(',0.00', fltPedagio);
  lblCombustivel.Caption := FormatFloat(',0.00', fltCombustivel);
  lblValorAcresc.Caption := FormatFloat(',0.00', fltAcrescFrete);
  lblTotal.Caption       := FormatFloat(',0.00', fltPedagio + fltCombustivel + fltAcrescFrete);
end;

end.
