unit untAceCtaData;

interface

uses
  Windows, Classes, untPai, StdCtrls, MaskEditFocus, Menus, ExtCtrls,
  AppEvnts, BitBtnLockedIncrem, Buttons, Mask, Controls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, frxClass,
  frxExportCSVTestabilidade, QColorLabel, EditFocus;

type
  TfrmAceCtaData = class(TfrmPai)
    pnlFundo: TPanel;
    Label3: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    mskDtaPag: TcxDateEdit;
    edtAlteraDtaPag: TEditFocus;
    ColorLabel1: TColorLabel;
    lblAplicar: TLabel;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure mskDtaPagKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnAlteraPag: Boolean;
  end;


implementation

uses
   SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}


procedure TfrmAceCtaData.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    inherited;
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmAceCtaData.FormShow(Sender: TObject);
begin
  inherited;
  If blnAlteraPag Then
    Self.Caption := 'Alterar Data de Pagamento'
  Else
    Self.ClientHeight  := Self.ClientHeight - edtAlteraDtaPag.Height - 13;

  pSetFocus(mskDtaPag);
end;

function TfrmAceCtaData.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    if (Sender = mskDtaPag) then
    begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaPag.Text)) Then
      Begin
        fMensagem('','A data deve ser preenchida!',['&OK']);
        Result := False;
      End
      Else
      Begin
        If StrToDate(mskDtaPag.Text) < VS_Date Then
        Begin
          fMensagem('','A data deve ser maior ou igual a data atual!',['&OK']);
          Result := False;
        End;
      End;
    end

    Else If (Sender = edtAlteraDtaPag) Then
    Begin
      If (Pos(edtAlteraDtaPag.Text, 'SA') <= 0) Then
      begin
        fMensagem('ATENÇÃO! ','O campo deve ser preenchido com S ou A!',['&OK']);
        Result := False;
      end;
    End;
  end;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmAceCtaData.mskDtaPagKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) Then
  begin
    If not blnAlteraPag Then
      SelectNext(ActiveControl, True, True);
  end;
end;

end.

