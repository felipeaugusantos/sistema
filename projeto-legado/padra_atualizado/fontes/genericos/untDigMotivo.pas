unit untDigMotivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmDigMotivo = class(TfrmPai)
    lblMotivo: TLabel;
    edtMotivo: TEdit;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function fDigMotivo(ACaption: String = ''; MotivoPreDefinido: String = ''): String;
  end;

var
  frmDigMotivo: TfrmDigMotivo;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

class function TfrmDigMotivo.fDigMotivo(ACaption: String = ''; MotivoPreDefinido: String = ''): String;
begin
  Result := '';
  pCriarFormularios(TfrmDigMotivo, frmDigMotivo);
  Try
    If ACaption = '' then
      frmDigMotivo.lblMotivo.Caption := 'Motivo da baixar parcial da ordem de produção'
    Else
      frmDigMotivo.lblMotivo.Caption := ACaption;

    frmDigMotivo.edtMotivo.Text := MotivoPreDefinido;

    frmDigMotivo.Showmodal;
    Result := frmDigMotivo.edtMotivo.Text;
  Finally
    FreeAndNil(frmDigMotivo);
  End;
end;

procedure TfrmDigMotivo.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
