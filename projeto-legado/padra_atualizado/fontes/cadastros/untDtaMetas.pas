unit untDtaMetas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, MaskEditFocus, Menus, Buttons, ExtCtrls;

type
  TfrmDtaMetas = class(TfrmPai)
    mskMesAno: TMaskEditFocus;
    Label1: TLabel;
    btnConfirmaDados: TBitBtn;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirma: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmDtaMetas: TfrmDtaMetas;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

function TfrmDtaMetas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskMesAno) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskMesAno.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informar o mês / ano!', ['&O k']);
        Result := False;
      End
      Else
      Try
        strToDate('01/' + mskMesAno.Text);
      Except
      Begin
        fMensagem('ATENÇÃO!', 'Mês / Ano inválido!', ['&O k']);
        Result := False;
      End;
      End;
    End;
  End;

  If Not Result Then
    Sender.SetFocus;
end;

procedure TfrmDtaMetas.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmDtaMetas.FormCreate(Sender: TObject);
begin
  inherited;

  blnConfirma    := False;
  mskMesAno.Text := FormatDateTime('mm/yyyy',VS_Date);
end;

end.

