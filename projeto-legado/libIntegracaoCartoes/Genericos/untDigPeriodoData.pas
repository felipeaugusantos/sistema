unit untDigPeriodoData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, untFuncoesSimples, untFuncoes;

type
  TfrmDigPeriodoData = class(TfrmPai)
    pnlFundo: TPanel;
    mskDtaFin: TcxDateEdit;
    mskDtaIni: TcxDateEdit;
    Label3: TLabel;
    lblContinuarUtil: TPanel;
    Label20: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Label20Click(Sender: TObject);
  private
    { Private declarations }
    FConfirma: Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }

    property Confirma: Boolean  read FConfirma;
  end;

implementation

{$R *.dfm}

{ TfrmDigPeriodoData }

procedure TfrmDigPeriodoData.FormShow(Sender: TObject);
begin
  inherited;
  FConfirma:= False;
  mskDtaIni.Date := Date;
  mskDtaFin.Date := Date;
end;

function TfrmDigPeriodoData.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result:= True;

  If (Sender = mskDtaIni) Then
  Begin

    If (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If StrToDate(mskDtaIni.Text) < Date Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data inicial deve ser maior ou igual a hoje!', ['&O k']);
      Result := False;
    End;

  End
  Else If (Sender = mskDtaFin)  Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If StrToDate(mskDtaFin.Text) < Date Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data final deve ser maior ou igual a hoje!', ['&O k']);
      Result := False;
    End
    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
            (    fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'Caso informe um período digite primeiramente a data inicial!', ['&O k']);
      Result := False;
    End
    Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And
            (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      If (Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
        Result := False;
      End;
    End;

  End;
end;

procedure TfrmDigPeriodoData.Label20Click(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;


  FConfirma := True;
  btnSair.Click;
end;

end.
