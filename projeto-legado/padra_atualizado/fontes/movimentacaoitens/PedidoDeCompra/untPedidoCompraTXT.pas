unit untPedidoCompraTXT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, DirectoryEditFocus,
  strUtils, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmPedidoCompraTXT = class(TfrmPai)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    btnConfirmar: TBitBtnLocked;
    fraPatTxt: TfraDirectoryEditFocus;
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strPathArq : String;
    intOpcao   : Integer;

    blnConfirma: Boolean;
  end;

var
  frmPedidoCompraTXT: TfrmPedidoCompraTXT;

implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmPedidoCompraTXT.btnConfirmarClick(Sender: TObject);
Begin
  inherited;
  If fEmptyStr(fraPatTxt.edtDirectory.text)Then
  Begin
    fMensagem('ATENÇÃO!','Path não pode ser nulo.',['&O K']);
    ModalResult := mrNone;
    pSetFocus(fraPatTxt);
  End
  Else if (not DirectoryExists(fraPatTxt.edtDirectory.text)) Then
  Begin
    fMensagem('ATENÇÃO!','Path inválido.',['&O K']);
    ModalResult := mrNone;
    pSetFocus(fraPatTxt);
  End
  else
  Begin
    strPathArq := fraPatTxt.edtDirectory.text;
    If (Not AnsiEndsText('\', fraPatTxt.edtDirectory.text)) Then
    Begin
      fraPatTxt.edtDirectory.text := fraPatTxt.edtDirectory.text + '\';
    End;
    strPathArq := fraPatTxt.edtDirectory.text;
    Self.ModalResult := MrOK;
    blnConfirma := True;
  End;
End;

procedure TfrmPedidoCompraTXT.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  if (CanClose) and (ModalResult <> mrOk) then
    Self.strPathArq := '';
end;

procedure TfrmPedidoCompraTXT.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma := False;
end;

procedure TfrmPedidoCompraTXT.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Shift = []) and (Key = VK_ESCAPE) Then
    Self.Close;
end;

procedure TfrmPedidoCompraTXT.FormShow(Sender: TObject);
begin
  inherited;

  Case intOpcao Of
    2: fraPatTxt.edtDirectory.text := fCfgSis('PATPDS'); //LeftStr(fArqIniTinta(0,'SUVINIL','PATGPD',''), Length(fArqIniTinta(0,'SUVINIL','PATGPD','')) - 1);
    3: fraPatTxt.edtDirectory.text := fCfgSis('PATPDC'); //LeftStr(fArqIniTinta(0,'Coral Imobiliaria','PATGPD',''), Length(fArqIniTinta(0,'Coral Imobiliaria','PATGPD','')) - 1);
    8: fraPatTxt.edtDirectory.text := fCfgSis('PATCRO');
    else if not fEmptyStr(strPathArq) then
      fraPatTxt.edtDirectory.text := strPathArq;
  End;

  pSetFocus(fraPatTxt);
  
end;


end.

