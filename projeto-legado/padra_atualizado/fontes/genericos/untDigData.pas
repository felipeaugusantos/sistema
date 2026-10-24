unit untDigData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  AppEvnts, ComCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, untTypesSistema;

type
  TfrmDigData = class(TfrmPai)
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
    blnLibQMDPEI: boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    public dtaDataMin: TDate;
    public dtaDataMax: TDate;
    fValidaDataEntIme: TfuncValidaDataEntIme;
  end;


implementation

uses untfuncoesSimples;

{$R *.dfm}

{ TfrmDigData }

procedure TfrmDigData.FormCreate(Sender: TObject);
begin
  inherited;
  dtaDataMin := 0;
  dtaDataMax := 0;
  btnSair.Align := alRight;
  btnConfirmaDados.Align := alLeft;
  //dtmData.OnKeyDown := pOnKeyDownEdits;

  blnLibQMDPEI := False;
end;

procedure TfrmDigData.FormShow(Sender: TObject);
begin
  inherited;
  If dtaDataMin > 0 Then
    dtmData.Properties.MinDate := dtaDataMin;

  If dtaDataMax > 0 Then
    dtmData.Properties.MaxDate := dtaDataMax;

  If (dtaDataMin > 0) Or (dtaDataMax > 0) Then
    dtmData.Properties.ShowOnlyValidDates := True;

  If (lblData.Width + 20) > pnlMensagem.Width Then
    Self.Width := lblData.Width + 20;

  pSetFocus(dtmData);
end;

function TfrmDigData.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dtmData) Then
  Begin
    If (dtmData.Text <> '') Then
      dtmData.Date := Strtodate(dtmData.Text);
    If (FormatDateTime('dd/mm/yyyy', dtmData.Date) = '00/00/0000') Or (dtmData.Date = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If (dtaDataMin > 0) Or (dtaDataMax > 0) Then
    Begin
      If (dtaDataMin > 0) And (dtmData.Date < dtaDataMin) Then
      Begin
        if Assigned(fValidaDataEntIme) then
        begin
          Result := blnLibQMDPEI or fValidaDataEntIme(dtmData.Date);
          blnLibQMDPEI := Result;
        end
        else
        begin
          fMensagem('ATENÇÃO!', 'A data não pode ser menor que ' + formatDateTime('DD/MM/YYYY', dtaDataMin) + '.', ['&O k']);
          Result := False;
        end;
      End;

      If (dtaDataMax > 0) And (dtmData.Date > dtaDataMax) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data não pode ser maior que ' + formatDateTime('DD/MM/YYYY', dtaDataMax) + '.', ['&O k']);
        Result := False;
      End;

    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmDigData.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

end.

