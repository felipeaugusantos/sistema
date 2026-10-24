unit untDigDadosCanhoto;

interface

uses
  Classes, Controls,
  StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, MaskEditFocus, Menus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmDigDadosCanhoto = class(TfrmPaiSimples)
    Label2: TLabel;
    Label1: TLabel;
    edtNomCht: TEditFocus;
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    mskDtaCht: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnConfirma: Boolean;
    dtaDtaCht: TDate;
    dtaDtaEmi: TDate;
    strNomCht: String;
  end;

Var
  frmDigDadosCanhoto: TfrmDigDadosCanhoto;

implementation

uses
  SysUtils,
  Forms,
  untFuncoesSimples
;

{$R *.dfm}

{ TfrmDigDadosCanhoto }

function TfrmDigDadosCanhoto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaCht) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCht.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do canhoto deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaCht.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data do canhoto informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else If (dtaDtaEmi > 0) And (StrToDateDef(mskDtaCht.Text, 0) < dtaDtaEmi) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do canhoto deve ser maior ou igual à data de emissão do documento fiscal! Data emissão: ' + DateToStr(dtaDtaEmi), ['&O k']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigDadosCanhoto.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmDigDadosCanhoto.FormShow(Sender: TObject);
begin
  inherited;
  dtaDtaCht := 0;
  strNomCht := EmptyStr;
end;

procedure TfrmDigDadosCanhoto.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigDadosCanhoto.btnConfirmaDadosClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    dtaDtaCht := StrToDate(mskDtaCht.Text);
    strNomCht := edtNomCht.Text;
    ModalResult := mrOk;
  End;
end;

end.

