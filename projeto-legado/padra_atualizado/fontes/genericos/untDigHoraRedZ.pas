unit untDigHoraRedZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, MaskEditFocus, StrUtils, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmDigHoraRedZ = class(TfrmPai)
    pnlGeral: TPanel;
    lblTexto: TLabel;
    mskHorEcf: TMaskEditFocus;
    chkHorEcf: TCheckBox;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkHorEcfClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDigHoraRedZ: TfrmDigHoraRedZ;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmDigQuantidade }

procedure TfrmDigHoraRedZ.chkHorEcfClick(Sender: TObject);
begin
  inherited;

  If chkHorEcf.Checked Then
  Begin
    Self.Height := 209;
    mskHorEcf.Enabled := True;
    mskHorEcf.Text := FormatDateTime('hh:mm', fTime());
  End
  Else
  Begin
    Self.Height := 112;
    mskHorEcf.Clear;
    mskHorEcf.Enabled := False;
  End;

end;

procedure TfrmDigHoraRedZ.FormShow(Sender: TObject);
begin
  inherited;
//  Self.Height := 112;
  mskHorEcf.Enabled := False;
end;

function TfrmDigHoraRedZ.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  If (Sender = mskHorEcf) And (mskHorEcf.Enabled) Then
  Begin
    If Not fEmptyStr(AnsiReplaceStr(mskHorEcf.Text, ':', '')) Then
    Begin
      Try
        StrToTime(mskHorEcf.Text);
      Except
        fMensagem('ATENÇÃO!', 'Digite uma hora válida!', ['&Ok']);
      End;
    End;
  End;
  Result := true;

end;

procedure TfrmDigHoraRedZ.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    Exit;
  End;

  ModalResult := mrOk;
end;

end.
