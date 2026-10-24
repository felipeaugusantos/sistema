unit untAlteraDataDocumento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus;

type
  TfrmAlteraDataDocumento = class(TfrmPaiConfirma)
    Label1: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtNumDoc: TEditFocus;
    edtEspDoc: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    lblDatEnt: TLabel;
    mskDtaEntFut: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  untFuncoesSimples;

procedure TfrmAlteraDataDocumento.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaEntFut);
end;

end.
