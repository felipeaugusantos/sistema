unit untLibCartoesDigData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.AppEvnts,
  Vcl.ComCtrls, Data.DB, Datasnap.DBClient,

  MaskEditFocus,BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, UniClientDataSet,

  untLibCartoesPai, untTLibCartoesFuncoes;

type
  TfrmLibCartoesDigData = class(TfrmPai)
    pnlMensagem: TPanel;
    lblData: TLabel;
    Panel2: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    dtmData: TcxDateEdit;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

{ TfrmDigData }

procedure TfrmLibCartoesDigData.FormCreate(Sender: TObject);
begin
  inherited;
  btnSair.Align := alRight;
  btnConfirmaDados.Align := alLeft;
end;

procedure TfrmLibCartoesDigData.FormShow(Sender: TObject);
begin
  inherited;

  If (lblData.Width + 20) > pnlMensagem.Width Then
    Self.Width := lblData.Width + 20;

  TLibCartoesFuncoes.pSetFocus(dtmData);
end;

function TfrmLibCartoesDigData.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dtmData) Then
  Begin
    If (dtmData.Text <> '') Then
      dtmData.Date := Strtodate(dtmData.Text);
    If (FormatDateTime('dd/mm/yyyy', dtmData.Date) = '00/00/0000') Or (dtmData.Date = 0) Then
    Begin
      TLibCartoesFuncoes.fMensagem('ATENÇÃO!', 'A data deve ser preenchida!', ['&Ok']);
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmLibCartoesDigData.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Self.Close;
    Self.ModalResult := mrOk;
  End;
end;

end.

