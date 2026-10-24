unit Contabilidade.View.TfrmPaiConfirmaContabilidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Contabilidade.View.TfrmPaiEditContabilidade, Menus, StdCtrls,  Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmPaiConfirmaContabilidade = class(TfrmPaiEditContabilidade)
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

implementation

uses Contabilidade.View.TfrmPaiContabilidade;

{$R *.dfm}

procedure TfrmPaiConfirmaContabilidade.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := 1;
end;

procedure TfrmPaiConfirmaContabilidade.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmPaiConfirmaContabilidade.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If blnVerificaCampos And (Not fVerificaCampos) Then
      Action := canone;

  End;
end;

procedure TfrmPaiConfirmaContabilidade.FormCreate(Sender: TObject);
begin
  inherited;

  blnVerificaCampos := True;

end;

procedure TfrmPaiConfirmaContabilidade.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

end.
