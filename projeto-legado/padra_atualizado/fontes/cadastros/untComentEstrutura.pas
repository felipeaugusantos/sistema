unit untComentEstrutura;

interface

uses

  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;


type
  TfrmComentEstrutura = class(TfrmPai)
    pnlDados: TPanel;
    Label1: TLabel;
    edtComentario: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    pnlIndustrial: TPanel;
    Label7: TLabel;
    Label17: TLabel;
    edtCodFas: TEditFocus;
    edtDesFas: TEditFocus;
    edtSeq: TEditFocus;
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtComentarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFasKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnIndustrial : boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmComentEstrutura: TfrmComentEstrutura;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmComentEstrutura.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
  
end;

procedure TfrmComentEstrutura.edtCodFasKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fPesqFases(Self, edtCodFas, edtDesFas, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodFas, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmComentEstrutura.edtComentarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEmptyStr(edtComentario.Text) Then
  Begin
    btnConfirmar.Enabled := False;
  End
  Else
    btnConfirmar.Enabled := True;

end;

procedure TfrmComentEstrutura.FormCreate(Sender: TObject);
begin
  inherited;
  blnIndustrial := False;
end;

procedure TfrmComentEstrutura.FormShow(Sender: TObject);
begin
  inherited;
  if not blnIndustrial then
  begin
    pnlIndustrial.Visible := False;
    frmComentEstrutura.Height := frmComentEstrutura.Height - pnlIndustrial.Height;
  end;
end;

function TfrmComentEstrutura.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtCodFas) Then
    Begin

      If (Not fEmptyStr(edtCodFas.Text)) Then
      Begin
        edtDesFas.Text := fRetDescricaoFase(edtCodFas.Text);

        If (fEmptyStr(edtDesFas.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Fase não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesFas.Clear;
        
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.

