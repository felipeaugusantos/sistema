unit untDtaEmissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, Mask, MaskEditFocus, Menus, Buttons, ExtCtrls, StrUtils,
  AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDtaEmi = class(TfrmPai)
    Label1: TLabel;
    mskDtaEmi: TMaskEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCndPag: String;
    blnConfirma: Boolean;
  end;

var
  frmDtaEmi: TfrmDtaEmi;

implementation

uses untIFuncoes, untFuncoesSimples, untFuncoes, untCfgRel;

{$R *.dfm}

procedure TfrmDtaEmi.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmDtaEmi.FormCreate(Sender: TObject);
begin
  inherited;
   blnConfirma := False;
end;

function TfrmDtaEmi.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaEmi) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaEmi.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmDtaEmi.FormShow(Sender: TObject);
begin
  inherited;
  mskDtaEmi.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
end;

end.

