unit untDigCadComEntregadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, QColorLabel, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigCadComEntregadores = class(TfrmPai)
    pnlCentral: TPanel;
    lblFinPed: TLabel;
    edtImpCom: TEditFocus;
    ColorLabel2: TColorLabel;
    lbl1: TLabel;
    edtImpEnd: TEditFocus;
    ColorLabel1: TColorLabel;
    Label1: TLabel;
    edtImpAss: TEditFocus;
    ColorLabel3: TColorLabel;
    btnConfirma: TBitBtnLocked;
    rdgTipImp: TRadioGroup;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strImpEnd: String;
    strImpAss: String;
  end;

var
  frmDigCadComEntregadores: TfrmDigCadComEntregadores;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmDigCadComEntregadores }

procedure TfrmDigCadComEntregadores.btnConfirmaClick(Sender: TObject);
begin
  fValidaCampos(edtImpCom, True);
  fValidaCampos(edtImpEnd, True);
  fValidaCampos(edtImpAss, True);
  inherited;
end;

procedure TfrmDigCadComEntregadores.FormCreate(Sender: TObject);
begin
  inherited;
  rdgTipImp.Visible := fCfgSis('MODICE') = '1';
  If Not rdgTipImp.Visible Then
    Self.Height := Self.Height - rdgTipImp.Height;
end;

function TfrmDigCadComEntregadores.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtImpCom) Then
    Begin
      If fEmptyStr(edtImpCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Imprimir Comprovante de Entrega deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtImpCom.Text,'SN') <= 0) Then
      Begin
        Result := False;
      End;

      If (edtImpCom.Text = 'N') Then
      Begin
        edtImpEnd.Enabled := False;
        edtImpEnd.Text    := '';
      End
      Else
      Begin
        edtImpEnd.Enabled := True;

        If (fEmptyStr(edtImpEnd.Text)) Then
          edtImpEnd.Text := 'N';
      End;
    End

    Else If (Sender = edtImpEnd) And (edtImpEnd.Enabled) Then
    Begin
      strImpEnd := edtImpEnd.Text;
      If edtImpEnd.Enabled And fEmptyStr(edtImpEnd.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Imprimir Endereço de Entrega deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtImpEnd.Text,'SN') <= 0) Then
      Begin
        Result := False;
      End;
    End

    Else If (Sender = edtImpAss) Then
    Begin
      If (fEmptyStr(edtImpAss.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','o Campo Imprimir Assinatura deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Pos(edtImpAss.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!','o Campo Imprimir Assinatura deve ser S ou N!', ['&O k']);
        Result := False;
      End
      Else
        strImpAss := edtImpAss.Text;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
