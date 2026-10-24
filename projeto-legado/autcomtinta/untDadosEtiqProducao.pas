unit untDadosEtiqProducao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDadosEtiqProducao = class(TfrmPaiConfirma)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtNomBas: TEditFocus;
    edtCodigo: TEditFocus;
    edtLote: TEditFocus;
    edtFabric: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtCompon: TEditFocus;
    edtRedutor: TEditFocus;
    edtConLiq: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirma: Boolean;
  end;

var
  frmDadosEtiqProducao: TfrmDadosEtiqProducao;

implementation

{$R *.dfm}

{ TfrmDadosEtiqProducao }

procedure TfrmDadosEtiqProducao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
end;

procedure TfrmDadosEtiqProducao.btnSairClick(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmDadosEtiqProducao.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

end.
