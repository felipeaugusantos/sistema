unit untFatObsNotaEspecial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, MemoFocus, ComCtrls,
  AppEvnts, EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatObsNotaEspecial = class(TfrmPai)
    btnConfirmaDados: TBitBtnLocked;
    memObserv: TMemoFocus;
    pnlInfIcmsImo: TPanel;
    chkInfIcmsImo: TCheckBox;
    pnlIcmsImobil: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtBasIcms: TEditFocus;
    edtValIcms: TEditFocus;
    edtAlqIcms: TEditFocus;
    lblCaracteresDisponiveis: TLabel;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure memObservKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkInfIcmsImoClick(Sender: TObject);
    procedure edtBasIcmsChange(Sender: TObject);
    procedure memObservKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;    
  public
    { Public declarations }
  end;

var
  frmFatObsNotaEspecial: TfrmFatObsNotaEspecial;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmFatObsNotaEspecial.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    Close;
    ModalResult := mrOk;
  End;  
end;

procedure TfrmFatObsNotaEspecial.btnSairClick(Sender: TObject);
begin
  memObserv.Lines.Clear;
  inherited;
end;

procedure TfrmFatObsNotaEspecial.chkInfIcmsImoClick(Sender: TObject);
begin
  inherited;
  edtBasIcms.Enabled := chkInfIcmsImo.Checked;
  edtValIcms.Enabled := chkInfIcmsImo.Checked;
  edtAlqIcms.Enabled := chkInfIcmsImo.Checked;
end;

procedure TfrmFatObsNotaEspecial.edtBasIcmsChange(Sender: TObject);
begin
  inherited;
  edtValIcms.Text := FormatFloat('##,#0.00', fStrToFloat(edtBasIcms.Text) *
                                             fStrToFloat(edtAlqIcms.Text) / 100);
end;

procedure TfrmFatObsNotaEspecial.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(chkInfIcmsImo);
end;

function TfrmFatObsNotaEspecial.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtAlqIcms) Then
    Begin
      If (fStrToFloat(edtAlqIcms.Text) < 0) Then
      Begin
        fMensagem('','Informe um valor maior ou igual à zero!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtBasIcms) Then
    Begin
      If (fStrToFloat(edtBasIcms.Text) < 0) Then
      Begin
        fMensagem('','Informe um valor maior ou igual à zero!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatObsNotaEspecial.memObservKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

procedure TfrmFatObsNotaEspecial.memObservKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If lblCaracteresDisponiveis.Visible Then
  Begin
    lblCaracteresDisponiveis.Caption := 'Disponíveis ' + IntToStr(memObserv.MaxLength - memObserv.GetTextLen) + ' caracteres de ' + IntToStr(memObserv.MaxLength);
    Repaint;
  End;

end;

end.
