unit ContasBancarias.View.InformaPeriodo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untLibContaBancariaPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit,DateUtils,
  Vcl.ComCtrls, dxCore, cxDateUtils, cxButtons, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxLabel;

type
  TfrmInformaPeriodo = class(TfrmPai)
    pnlFundo: TPanel;
    pnlCardPeriodo: TPanel;
    lblPeriodo: TcxLabel;
    pnlDataInicial: TPanel;
    mskDataInicial: TcxDateEdit;
    pnlDataFinal: TPanel;
    mskDataFinal: TcxDateEdit;
    pnlConfirmar: TPanel;
    btnConfirmar: TcxButton;
    lblA: TcxLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    procedure ArredondarBordas(AControl: TWinControl; ARadiusX, ARadiusY: Integer);
    procedure AjustarLayout;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untTLibContasBancariasFuncoes;

{$R *.dfm}

{ TfrmInformaPeriodo }

procedure TfrmInformaPeriodo.AjustarLayout;
begin
  ArredondarBordas(pnlCardPeriodo,15,15);
  ArredondarBordas(pnlDataInicial,10,10);
  ArredondarBordas(pnlDataFinal,10,10);
  ArredondarBordas(pnlConfirmar,10,10);
end;

procedure TfrmInformaPeriodo.ArredondarBordas(AControl: TWinControl; ARadiusX,
  ARadiusY: Integer);
var
  Rgn: HRGN;
begin
  if Assigned(AControl) then
  begin
    Rgn := CreateRoundRectRgn(
      0,
      0,
      AControl.Width,
      AControl.Height,
      ARadiusX,
      ARadiusY
    );
    SetWindowRgn(AControl.Handle, Rgn, True);
  end;
end;

procedure TfrmInformaPeriodo.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  ModalResult := 1;
end;

procedure TfrmInformaPeriodo.FormShow(Sender: TObject);
begin
  inherited;
  AjustarLayout;
  mskDataInicial.Date := incDay(VS_FuncoesExternas.fIGetVS_Date,-1);
  mskDataFinal.Date :=  VS_FuncoesExternas.fIGetVS_Date;
end;

function TfrmInformaPeriodo.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskDataInicial) Then
  Begin
    If (TLibContaBancariaFuncoes.fEmptyStr(TLibContaBancariaFuncoes.fTiraCaracEspeciais(mskDataInicial.Text))) Then
    Begin
      TLibContaBancariaFuncoes.fMensagem('ATENÇÃO!', 'A Data inicial deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (StrToDateDef(mskDataInicial.Text, 0) = 0) Then
    Begin
      TLibContaBancariaFuncoes.fMensagem('ATENÇÃO!', 'Informe uma data inicial válida!', ['&O k']);
      Result := False;
    End;

  End
  Else If (Sender = mskDataFinal)  Then
  Begin
    If TLibContaBancariaFuncoes.fEmptyStr(TLibContaBancariaFuncoes.fTiraCaracEspeciais(mskDataFinal.Text)) Then
    Begin
      TLibContaBancariaFuncoes.fMensagem('ATENÇÃO!', 'A Data final deve ser preenchida!', ['&O k']);
      Result := False;
    End
    Else If (StrToDateDef(mskDataFinal.Text, 0) = 0) Then
    Begin
      TLibContaBancariaFuncoes.fMensagem('ATENÇÃO!', 'Informe uma data final válida!', ['&O k']);
      Result := False;
    End
    Else If (Not TLibContaBancariaFuncoes.fEmptyStr(TLibContaBancariaFuncoes.fTiraCaracEspeciais(mskDataFinal.Text))) And
            (    TLibContaBancariaFuncoes.fEmptyStr(TLibContaBancariaFuncoes.fTiraCaracEspeciais(mskDataInicial.Text))) Then
    Begin
      TLibContaBancariaFuncoes.fMensagem('ATENÇÃO!', 'Informe a data inicial!', ['&O k']);
      Result := False;
    End
    Else If (Not TLibContaBancariaFuncoes.fEmptyStr(TLibContaBancariaFuncoes.fTiraCaracEspeciais(mskDataFinal.Text))) And
            (Not TLibContaBancariaFuncoes.fEmptyStr(TLibContaBancariaFuncoes.fTiraCaracEspeciais(mskDataInicial.Text))) Then
    Begin
      If (Not TLibContaBancariaFuncoes.fValidaPeriodo(mskDataInicial.Text, mskDataFinal.Text)) Then
      Begin
        TLibContaBancariaFuncoes.fMensagem('ATENÇÃO!', 'A data final deve ser maior ou igual a data inicial!', ['&O k']);
        Result := False;
      End
      Else If (DaysBetween(strToDateDef(mskDataInicial.Text, 0), strToDateDef(mskDataFinal.Text, 0)) > 30) Then
      Begin
        TLibContaBancariaFuncoes.fMensagem('ATENÇÃO!', 'O período máximo permitido para importação é de 30 dias!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  If (Not Result) Then
    TLibContaBancariaFuncoes.pSetFocus(Sender);
end;

end.
