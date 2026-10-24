{***************************}
{* qryConCli -> CADCLI     *}
{***************************}

unit untOpcoesImpDupMercantil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmOpcoesImpDupMercantil = class(TfrmPaiSimples)
    pnlDados: TPanel;
    btnConfirma: TBitBtnLocked;
    rdgOpcoes: TRadioGroup;
    chkEditaEmail: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure rdgOpcoesClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    intOpcao: Integer;
    blnEdtEmail: Boolean;
  end;


implementation

uses untfuncoesSimples, untPesqAux, untpai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmOpcoesImpDupMercantil.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  blnEdtEmail := False;
  intOpcao := 0;
end;

function TfrmOpcoesImpDupMercantil.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmOpcoesImpDupMercantil.rdgOpcoesClick(Sender: TObject);
begin
  inherited;
  chkEditaEmail.Enabled := rdgOpcoes.ItemIndex in [3, 4];

  If Not chkEditaEmail.Enabled Then
    chkEditaEmail.Checked := False;
end;

procedure TfrmOpcoesImpDupMercantil.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  intOpcao := rdgOpcoes.ItemIndex;
  blnEdtEmail := chkEditaEmail.Checked;
  Close;
end;

procedure TfrmOpcoesImpDupMercantil.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.

