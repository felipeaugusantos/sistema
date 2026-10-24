unit untRcxInfCarPos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmRcxInfCarPos = class(TfrmPai)
    pnlFundo: TPanel;
    Label10: TLabel;
    edtCodPos: TEditFocus;
    edtDesPos: TEditFocus;
    Label3: TLabel;
    edtCodCar: TEditFocus;
    edtDesCar: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodPosKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirmou : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmRcxInfCarPos: TfrmRcxInfCarPos;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples;

procedure TfrmRcxInfCarPos.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  blnConfirmou := True;
  Close;
end;

procedure TfrmRcxInfCarPos.edtCodCarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCartao : TConsultasArray;
begin
  inherited;
  If fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, True, True) Then
  Begin
    If (fValidaCampos(edtCodCar, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxInfCarPos.edtCodPosKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPos : TConsultasArray;
begin
  inherited;
  If fPesqPos(Self, edtCodPos, edtDesPos, Nil, Key, arrPos) Then
  Begin
    If (fValidaCampos(edtCodPos, True)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxInfCarPos.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodPos);
end;

procedure TfrmRcxInfCarPos.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirmou := False;
end;

function TfrmRcxInfCarPos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodPos) Then
  Begin
    If (fEmptyStr(edtCodPos.Text)) Then
    Begin
      fMensagem('', 'O POS deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      edtDesPos.Text := fCampoTabela('POS_DESPOS', 'CADPOS', ['POS_CODPOS'], [edtCodPos.Text]);
      If (fEmptyStr(edtDesPos.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'POS informado não foi encontrado!', ['&OK']);
        Result := False;
      End;
    End;
  End
  Else If (Sender = edtCodCar) Then
  Begin
    If (fEmptyStr(edtCodCar.Text)) Then
    Begin
      fMensagem('', 'O código do cartão deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      edtDesCar.Text := fRetNomeCartao(edtCodCar.Text);
      If (fEmptyStr(edtDesCar.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Cartão informado não foi encontrado!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
