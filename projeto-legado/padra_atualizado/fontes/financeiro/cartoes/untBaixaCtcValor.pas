unit untBaixaCtcValor;

interface

uses
  Classes, Controls, StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons,
  ExtCtrls, Mask, MaskEditFocus, Menus, AppEvnts, BitBtnLockedIncrem,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmBaixaCtcValor = class(TfrmPaiSimples)

    Label1: TLabel;
    edtValPag: TEditFocus;
    Label2: TLabel;
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    mskDtaPag: TcxDateEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fltValPag: Double;
    fltValBru: Double;
    dtaDtaPag: TDateTime;
    blnConfirma: Boolean;
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

{ TfrmBaixaCtcValor }

function TfrmBaixaCtcValor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O VALOR                        *}
    {**************************************MV*}
    If (Sender = edtValPag) Then
    Begin

      If fEmptyStr(edtValPag.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtValPag.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtValPag.Text) > fltValBru Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor pago não pode ser maior que o valor original (' + FormatFloat('#,##0.00', fltValBru) + ')!', ['&O k']);
        Result := False;                
      End;

    End

    {*****************************************}
    {* VALIDA A DATA DE PAGAMENTO            *}
    {**************************************MV*}
    Else If (Sender = mskDtaPag) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If fStrToFloat(edtValPag.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
      Else If (StrToDate(mskDtaPag.Text) < StrToDate('01/01/2000')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do pagamento não pode ser menor que 01/01/2000', ['&O K']);
        Result := False;
      End
      Else If (StrToDate(mskDtaPag.Text) > VS_DATE) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do pagamento deve ser menor ou igual a hoje!', ['&O K']);
        Result := False;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaCtcValor.FormShow(Sender: TObject);
begin
  inherited;
  edtValPag.Text := FloatToStrf(fltValPag, ffFixed, 12, 2);

  If dtaDtaPag > 0 Then
    mskDtaPag.Text := FormatDateTime('dd/MM/yyyy', dtaDtaPag);

  pSetFocus(edtValPag);
end;

procedure TfrmBaixaCtcValor.FormCreate(Sender: TObject);
begin
  inherited;
  fltValPag   := 0.0;
  blnConfirma := False
end;

procedure TfrmBaixaCtcValor.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaCtcValor.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    fltValPag   := fStrToFloat(edtValPag.Text);
    dtaDtaPag   := StrToDate(mskDtaPag.Text);
    blnConfirma := True;
    Close;
  End;
end;

end.

