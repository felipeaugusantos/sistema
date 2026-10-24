unit untDigDataPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmDigDataPagamento = class(TfrmPaiConfirma)
    pnlTopo: TPanel;
    pnlFundo: TPanel;
    rgpTipoData: TRadioGroup;
    dtmData: TcxDateEdit;
    procedure FormShow(Sender: TObject);
    procedure rgpTipoDataClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmDigDataPagamento: TfrmDigDataPagamento;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmDigDataPagamento }

procedure TfrmDigDataPagamento.FormShow(Sender: TObject);
begin
  inherited;
  dtmData.Date := Date;
end;

function TfrmDigDataPagamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dtmData) Then
  Begin
    If dtmData.Enabled Then
    Begin
      If Not fEmptyStr(dtmData.Text) Then
        dtmData.Date := StrToDate(dtmData.Text);

      If fEmptyStr(dtmData.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A data de pagamento deve ser preenchida!', ['&Ok']);
        Result := False;
      End

      Else If dtmData.Date < Date Then
      Begin
        fMensagem('ATENÇÃO', 'A data de pagamento não pode ser anterior à data atual!', ['&Ok']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigDataPagamento.rgpTipoDataClick(Sender: TObject);
begin
  inherited;
  dtmData.Enabled := rgpTipoData.ItemIndex = 1;
end;

end.
