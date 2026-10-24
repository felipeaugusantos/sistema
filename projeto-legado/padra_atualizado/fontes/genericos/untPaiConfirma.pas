unit untPaiConfirma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, Menus, StdCtrls,  Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPaiConfirma = class(TfrmPaiEdit)
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
  frmPaiConfirma: TfrmPaiConfirma;

implementation

uses untPai;

{$R *.dfm}

procedure TfrmPaiConfirma.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := 1;
end;

procedure TfrmPaiConfirma.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmPaiConfirma.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If blnVerificaCampos And (Not fVerificaCampos) Then
      Action := canone;

  End;
end;

procedure TfrmPaiConfirma.FormCreate(Sender: TObject);
begin
  inherited;

  blnVerificaCampos := True;

end;

procedure TfrmPaiConfirma.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

end.
