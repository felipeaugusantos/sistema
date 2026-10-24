unit untBaixaDigCheque;

interface

uses
  Classes, Controls,
  StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls, untFechamentoFinanceiro,
  EditFocus, Mask, MaskEditFocus, Menus, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TfrmBaixaDigCheque = class(TfrmPaiSimples)
    Label2: TLabel;
    Label1: TLabel;
    edtCtaDep: TEditFocus;
    pnlConfirma: TPanel;
    pnlFundo: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    mskDtaDep: TcxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
    objFechamento: TFechamentoFinanceiro;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnRepasse: Boolean;
    blnConfirma: Boolean;
    dtaDtaDep: TDateTime;
    dtaDtaCad: TDateTime;
    dtaDtaDev: TDateTime;
    strCtaDep: String;
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

{ TfrmBaixaDigCheque }

function TfrmBaixaDigCheque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strOperacao: String;
begin
  Result := True;
  If blnRepasse Then
    strOperacao := 'repasse'
  else
    strOperacao := 'depósito';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = mskDtaDep) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaDep.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do ' + strOperacao + ' deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaDep.Text, 0) <= 0) Then
      Begin
        fMensagem('ATENÇÃO', 'A Data do ' + strOperacao + ' informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else If (dtaDtaDev > 0) And (StrToDateDef(mskDtaDep.Text, 0) < dtaDtaDev) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do redepósito deve ser maior ou igual à data de devolução! Data Devolução: ' + DateToStr(dtaDtaDev), ['&O k']);
        Result := False;
      End
      Else If StrToDateDef(mskDtaDep.Text, 0) < dtaDtaCad Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do ' + strOperacao + ' deve ser maior ou igual à data de cadastro!', ['&O k']);
        Result := False;
      End
      else if not fEmptyStr(fCfgSis('DIADEP')) and fCfgSis('DIADEP', varInteger) > 0 then
      begin
        if StrToDateDef(mskDtaDep.Text, 0) > VS_Date + fCfgSis('DIADEP', varInteger)  then
        begin
          fMensagem('ATENÇÃO!', 'A data ultrapassou o limite de dias para depósito futuro. É permitido depósito com '+
          'data máxima de '+DateToStr(VS_Date +  fCfgSis('DIADEP', varInteger))+'.', ['&O k']);
          Result := False;
        end;
      end;

      //FECHAMENTO FINANCEIRO
      if Result then
        if objFechamento.FechamentoFinanceiroJaRealizado(VS_StrCodEmp, StrToDate(mskDtaDep.Text)) then
          Result := False;
    End

    Else If (Sender = edtCtaDep) Then
    Begin

      If fEmptyStr(edtCtaDep.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Conta do depósito deve ser preenchida!', ['&O k']);
        Result := False;
      End

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaDigCheque.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmBaixaDigCheque.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmBaixaDigCheque.btnConfirmaDadosClick(Sender: TObject);
begin
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    dtaDtaDep := StrToDate(mskDtaDep.Text);
    strCtaDep := edtCtaDep.Text;
    Close;
  End;
end;

end.

