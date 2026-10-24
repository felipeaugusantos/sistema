unit untTabQtd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, ComboBoxFocus;

type
  TfrmTabQtd = class(TfrmPai)
    edtQtde: TEditFocus;
    pnlQuantidade: TPanel;
    lblQuantidade: TLabel;
    pnlAmbiente: TPanel;
    lblAmbiente: TLabel;
    cbbAmbiente: TComboBoxFocus;
    procedure FormShow(Sender: TObject);
    procedure edtQtdeKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure cbbAmbienteKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    dblQtde: Double;
  end;

//var
//  frmTabQtd: TfrmTabQtd;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmTabQtd }

procedure TfrmTabQtd.cbbAmbienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if (not fEmptyStr(cbbAmbiente.Text)) and (cbbAmbiente.Items.IndexOf(cbbAmbiente.Text) < 0) then
    begin
      cbbAmbiente.Items.Add(cbbAmbiente.Text);
    end;
    ModalResult := mrOk;
  end
  else if Key = #27 then
    ModalResult := mrCancel;
end;

procedure TfrmTabQtd.edtQtdeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if pnlAmbiente.Visible then
    begin
      pSetFocus(cbbAmbiente);
    end
    else
    begin
      ModalResult := mrOk;
    end;
  end
  else if Key = #27 then
    ModalResult := mrCancel;
end;

procedure TfrmTabQtd.FormCreate(Sender: TObject);
begin
  inherited;
  dblQtde := 0;
end;

procedure TfrmTabQtd.FormShow(Sender: TObject);
begin
  inherited;
  edtQtde.Text := FormatFloat(',0.000', dblQtde);
  pSetFocus(edtQtde);
  edtQtde.SelectAll;
end;

end.
