unit untAltDtaVenc;

interface

uses
  Windows, Classes, Controls, untPai, StdCtrls, MaskEditFocus, Menus, ExtCtrls,
  AppEvnts, BitBtnLockedIncrem, Mask, Buttons;

type
  TfrmAltDtaVenc = class(TfrmPai)
    pnlDados: TPanel;
    Label1: TLabel;
    mskDtaVen: TMaskEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    dtaDtaVen: TDate;
    blnConfirma: Boolean;
    { Public declarations }
  end;


implementation

uses SysUtils, Forms, untfuncoesSimples;

{$R *.dfm}

procedure TfrmAltDtaVenc.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  dtaDtaVen   := StrToDate(mskDtaVen.Text);
  blnConfirma := True;
  Self.Close;
end;

procedure TfrmAltDtaVenc.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

function TfrmAltDtaVenc.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaVen) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaVen.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de vencimento deve ser preenchida!', ['&O k']);
        Result := False;
      End
    End;

    If Not Result Then
      pSetFocus(Sender);
      
  End;
end;

end.

