unit untDigDtaNovo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus;

type
  TfrmDigDtaNovo = class(TfrmPai)
    mskDtaInf: TMaskEditFocus;
    lblDtaInf: TLabel;
    btnConfirmaDados: TBitBtnLocked;
    procedure FormActivate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDigDtaNovo: TfrmDigDtaNovo;

implementation

uses untfuncoesSimples;

{$R *.dfm}

{ TfrmDigDtaNovo }

procedure TfrmDigDtaNovo.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigDtaNovo.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaInf);
end;

function TfrmDigDtaNovo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If fEmptyStr(fTiraCaracEspeciais(mskDtaInf.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data deve ser preenchida!', ['&Ok']);
    Result := False;
  End
  Else If StrToDateDef(mskDtaInf.Text, 0) <= 0 Then
    Result := False;


  If (Not Result) Then
    pSetFocus(Sender);

end;

end.
