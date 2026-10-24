unit untPnlDadosServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, UniClientDataSet,
  Vcl.DBCtrls, DBMemoFocus, DB;

type
  TfrmPnlDadosServico = class(TForm)
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    dbmAplica: TDBMemoFocus;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    dtsConsulta : TDataSource;
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
    constructor Create(AOwner: TComponent); reintroduce; virtual;
  end;

  TfrmPnlDadosServicoClass = Class Of TfrmPnlDadosServico;

var
  frmPnlDadosServico: TfrmPnlDadosServico;

implementation

{$R *.dfm}

constructor TfrmPnlDadosServico.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TfrmPnlDadosServico.FormCreate(Sender: TObject);
begin
  dtsConsulta := TDataSource.Create(Self);
end;

procedure TfrmPnlDadosServico.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtsConsulta);
end;

procedure TfrmPnlDadosServico.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure TfrmPnlDadosServico.FormShow(Sender: TObject);
begin
  dtsConsulta.DataSet := cdsConsulta;
  dbmAplica.DataSource := dtsConsulta;
  dbmAplica.DataField := 'SER_APLICA';
end;

end.
