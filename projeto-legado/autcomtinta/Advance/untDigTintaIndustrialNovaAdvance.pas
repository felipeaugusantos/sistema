unit untDigTintaIndustrialNovaAdvance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untDigTintaIndustrialNova, AppEvnts, Menus, StdCtrls, ExtCtrls, EditFocus, Buttons, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmDigTintaIndustrialNovaAdvance = class(TfrmDigTintaIndustrialNova)
    procedure btnFormulacaoClick(Sender: TObject);
    procedure chkUsaCatalisadorClick(Sender: TObject);
    procedure rgEmbalagensClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure AtualizarTela; override;
  public
    { Public declarations }
    strIdePro: String;
  end;

var
  frmDigTintaIndustrialNovaAdvance: TfrmDigTintaIndustrialNovaAdvance;

implementation

uses
  untFormulacaoIndustrialAdvanceTintoSystem;

{$R *.dfm}

procedure TfrmDigTintaIndustrialNovaAdvance.AtualizarTela;
begin
  inherited AtualizarTela;
end;

procedure TfrmDigTintaIndustrialNovaAdvance.btnFormulacaoClick(Sender: TObject);
var
  frmFormulacao: TfrmFormulacaoIndustrialAdvanceTintoSystem;
begin
  frmFormulacao := nil;
  Try
    Try
      frmFormulacao := TfrmFormulacaoIndustrialAdvanceTintoSystem.Create(Self, formula);
      frmFormulacao.Caption := Copy(Self.Caption, Pos('-', Self.Caption) + 2, Length(Self.Caption));
      frmFormulacao.strIdePro := strIdePro;
      frmFormulacao.ShowModal;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(frmFormulacao) then FreeAndNil(frmFormulacao);
  End;
end;

procedure TfrmDigTintaIndustrialNovaAdvance.chkUsaCatalisadorClick(Sender: TObject);
begin
  inherited;
  formula.CalcularPrecos;
  AtualizarTela;
end;

procedure TfrmDigTintaIndustrialNovaAdvance.FormShow(Sender: TObject);
begin
  inherited;
  rgEmbalagens.Buttons[rgEmbalagens.Items.IndexOf(PERSONALIZADA)].Enabled := False;
end;

procedure TfrmDigTintaIndustrialNovaAdvance.rgEmbalagensClick(Sender: TObject);
begin
  inherited;
  chkUsaCatalisador.Enabled := (PERSONALIZADA = rgEmbalagens.Items[rgEmbalagens.ItemIndex]);
  if not chkUsaCatalisador.Enabled then
    chkUsaCatalisador.Checked := True;
end;


end.
