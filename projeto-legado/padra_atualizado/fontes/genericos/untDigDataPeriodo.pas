unit untDigDataPeriodo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  AppEvnts, ComCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, untTypesSistema;

type
  TfrmDigDataPeriodo = class(TfrmPai)
    pnlMensagem: TPanel;
    lblDtaIni: TLabel;
    Panel2: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    dtaDtaIni: TcxDateEdit;
    dtaDtaFin: TcxDateEdit;
    lblDtaFin: TLabel;
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

uses untfuncoesSimples;

{$R *.dfm}

{ TfrmDigDataPeriodo }

procedure TfrmDigDataPeriodo.FormCreate(Sender: TObject);
begin
  inherited;
  btnSair.Align := alRight;
  btnConfirmaDados.Align := alLeft;
end;

procedure TfrmDigDataPeriodo.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dtaDtaIni);
end;

function TfrmDigDataPeriodo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = dtaDtaIni) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(dtaDtaIni.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (StrToDateDef(dtaDtaIni.Text, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe uma data inicial válida!', ['&O k']);
      Result := False;
    End;

  End
  Else If (Sender = dtaDtaFin)  Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(dtaDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (StrToDateDef(dtaDtaFin.Text, 0) = 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe uma data final válida!', ['&O k']);
      Result := False;
    End
    Else If (Not fEmptyStr(fTiraCaracEspeciais(dtaDtaFin.Text))) And
            (    fEmptyStr(fTiraCaracEspeciais(dtaDtaIni.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe a data inicial!', ['&O k']);
      Result := False;
    End
    Else If (Not fEmptyStr(fTiraCaracEspeciais(dtaDtaFin.Text))) And
            (Not fEmptyStr(fTiraCaracEspeciais(dtaDtaIni.Text))) Then
    Begin
      If (Not fValidaPeriodo(dtaDtaIni.Text, dtaDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmDigDataPeriodo.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

end.

