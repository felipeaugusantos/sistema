unit untConsertoEquipImpr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmConsertoEquipImpr = class(TfrmPai)
    pnlFundo: TPanel;
    rdgOpcoes: TRadioGroup;
    btnConfirma: TBitBtnLocked;
    grbAnexoEmail: TGroupBox;
    chkPDF: TCheckBox;
    chkExcel: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure rdgOpcoesClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    procedure pExibeAnexoEmail(blnVisible: Boolean);
  public
    { Public declarations }
    blnPDF,
    blnExcel,
    blnImpr,
    blnEmail,
    blnWhatsapp,
    blnConfirma: Boolean;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsertoEquipImpr.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  case (rdgOpcoes.ItemIndex) of
    0:
      begin
        blnImpr := True;
        blnPDF  := True;
      end;
    1:
      begin
        blnImpr  := True;
        blnPDF   := True;
        blnEmail := True;
      end;
    2:
      begin
        blnExcel := True;
      end;
    3:
      begin
        blnExcel := True;
        blnEmail := True;
      end;
    4:
      begin
        if (not chkPDF.Checked) and (not chkExcel.Checked) then
        begin
          fMensagem('', 'Selecione pelo menos uma opção de anexo!' , ['&Ok']);
          Exit;
        end;

        blnEmail := True;
        blnPDF   := chkPDF.Checked;
        blnExcel := chkExcel.Checked;
      end;
    5:
      begin
        if (not chkPDF.Checked) and (not chkExcel.Checked) then
        begin
          fMensagem('', 'Selecione pelo menos uma opção de anexo!' , ['&Ok']);
          Exit;
        end;

        blnWhatsapp := True;
        blnPDF   := chkPDF.Checked;
        blnExcel := chkExcel.Checked;
      end;
  end;

  blnConfirma := True;
  Close;
end;

procedure TfrmConsertoEquipImpr.FormCreate(Sender: TObject);
begin
  inherited;

  blnPDF      := False;
  blnExcel    := False;
  blnImpr     := False;
  blnEmail    := False;
  blnConfirma := False;

  pExibeAnexoEmail(False);
end;

procedure TfrmConsertoEquipImpr.pExibeAnexoEmail(blnVisible: Boolean);
begin
  grbAnexoEmail.Caption := IIF(rdgOpcoes.ItemIndex = 4, 'Anexos do e-mail', 'Anexos do Whatsapp');

  if (blnVisible = grbAnexoEmail.Visible) then
    Exit;

  grbAnexoEmail.Visible := blnVisible;

  if blnVisible then
    Self.Height := Self.Height + 54
  else
    Self.Height := Self.Height - 54;
end;

procedure TfrmConsertoEquipImpr.rdgOpcoesClick(Sender: TObject);
begin
  inherited;

  if (rdgOpcoes.ItemIndex in [4, 5]) then
    pExibeAnexoEmail(True)
  else
    pExibeAnexoEmail(False);
end;

end.
