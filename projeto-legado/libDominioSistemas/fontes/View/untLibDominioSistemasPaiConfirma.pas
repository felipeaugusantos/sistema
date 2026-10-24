unit untLibDominioSistemasPaiConfirma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untLibDominioSistemasPaiEdit, Menus, StdCtrls,  Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPaiDominioSistemasConfirma = class(TfrmPaiDominioSistemasEdit)
    btnConfirma: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnVerificaCampos: Boolean;
  end;

var
  frmPaiDominioSistemasConfirma: TfrmPaiDominioSistemasConfirma;

implementation

uses untLibDominioSistemasPai;

{$R *.dfm}

procedure TfrmPaiDominioSistemasConfirma.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := 1;
end;

procedure TfrmPaiDominioSistemasConfirma.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmPaiDominioSistemasConfirma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If blnVerificaCampos And (Not fVerificaCampos) Then
      Action := canone;

  End;
end;

procedure TfrmPaiDominioSistemasConfirma.FormCreate(Sender: TObject);
begin
  inherited;

  blnVerificaCampos := True;

end;

procedure TfrmPaiDominioSistemasConfirma.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

end.
