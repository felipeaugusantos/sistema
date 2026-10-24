unit untDigValor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  ExtCtrls, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  ComboBoxFocus, Math;

type
  TfrmDigValor = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    lblUnitario: TLabel;
    edtValor: TEditFocus;
    cmbTipVal: TComboBoxFocus;
    lblEmbalagem: TLabel;
    edtEmbalagem: TEditFocus;
    chkReplica: TCheckBox;
    chkReplicaItens: TCheckBox;

    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    FRedimessionaTelaExterna: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnPermiteZero,
    blnPermiteMenorZero,
    blnConciliacao,
    blnEfetivacaoLote,
    blnValidaEscala: Boolean;
    fltQtdEmb,
    fltEscalaMinimo,
    fltEscalaMaximo: Double;

    property blnRedimessionaTelaExterna: Boolean read FRedimessionaTelaExterna write FRedimessionaTelaExterna;
    class function fDigitaValor(var fltValor: Double;
                                    strTitulo: String;
                                    strFormato: String = '#,##0.00';
                                    blnPermiteZero: Boolean = False;
                                    blnPermiteMenorZero: Boolean = False;
                                    AblnValidaEscala: Boolean = False;
                                    AfltEscalaMinimo: Double = -1;
                                    AfltEscalaMaximo: Double = -1): Boolean;
  end;

var
  frmDigValor: TfrmDigValor;

implementation

uses untfuncoessimples;

{$R *.dfm}

function TfrmDigValor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtValor) or ((blnEfetivacaoLote) and (Sender = edtEmbalagem)) Then
    Begin

      If (Not blnPermiteZero) And (fStrToFloat(TEdit(Sender).Text) = 0) Then
      Begin
        fMensagem('','Informe um valor diferente de zero!', ['&Ok']);
        Result := False;
      End
      Else If (blnPermiteZero) And (Not blnPermiteMenorZero) And (fStrToFloat(TEdit(Sender).Text) < 0) Then
      Begin
        fMensagem('','Informe um valor maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else If (Not blnPermiteZero) And (Not blnPermiteMenorZero) And (fStrToFloat(TEdit(Sender).Text) <= 0) Then
      Begin
        fMensagem('','Informe um valor maior que zero!', ['&Ok']);
        Result := False;
      End
      Else If blnValidaEscala And (fltEscalaMinimo >= 0) And  (fltEscalaMaximo > 0) Then
      Begin
        If Not  fValidaEscala(TEdit(Sender).Text, fltEscalaMinimo, fltEscalaMaximo) Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor deve estar entre 0 e 100!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
    If Result and blnEfetivacaoLote Then
    Begin
      If Sender = edtValor Then
        edtEmbalagem.Text := FloatToStr(fStrToFloat(edtValor.Text) * fltQtdEmb)
      Else
        edtValor.Text := FloatToStr(fStrToFloat(edtEmbalagem.Text) / fltQtdEmb);
    End;

    If Result Then
      btnConfirma.Click;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigValor.FormCreate(Sender: TObject);
begin
  inherited;
  blnConciliacao := False;
  FRedimessionaTelaExterna:= False;
  blnValidaEscala := False;
  fltEscalaMinimo := -1;
  fltEscalaMaximo := -1;
end;

procedure TfrmDigValor.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;

  If Not blnRedimessionaTelaExterna Then
  Begin
    Width := IIF(blnConciliacao, 315, 226);
    Height := IIf(blnEfetivacaoLote, 176, 105);
  End;

  cmbTipVal.Visible := blnConciliacao;
  edtEmbalagem.Visible := blnEfetivacaoLote;
  lblEmbalagem.Visible := blnEfetivacaoLote;
  If blnEfetivacaoLote Then
    lblUnitario.Caption :=  'Valor Unitario:';

end;


class function TfrmDigValor.fDigitaValor(var fltValor: Double;
                                        strTitulo: String;
                                        strFormato: String = '#,##0.00';
                                        blnPermiteZero: Boolean = False;
                                        blnPermiteMenorZero: Boolean = False;
                                        AblnValidaEscala: Boolean = False;
                                        AfltEscalaMinimo: Double = -1;
                                        AfltEscalaMaximo: Double = -1): Boolean;
begin
  Try
    pCriarFormularios(TfrmDigValor, frmDigValor);
    frmDigValor.blnPermiteZero      := blnPermiteZero;
    frmDigValor.blnPermiteMenorZero := blnPermiteMenorZero;
    frmDigValor.edtValor.Text       := FormatFloat(strFormato, fltValor);
    frmDigValor.edtValor.EditFormat := strFormato;
    frmDigValor.Caption             := strTitulo;
    frmDigValor.blnValidaEscala     := AblnValidaEscala;
    frmDigValor.fltEscalaMinimo     := AfltEscalaMinimo;
    frmDigValor.fltEscalaMaximo     := AfltEscalaMaximo;

    frmDigValor.ShowModal;

    Result   := (frmDigValor.ModalResult = mrOk);
    fltValor := fStrToFloat(frmDigValor.edtValor.Text);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[]');
    End;
  End;

  pFreeAndNil(frmDigValor);
end;

end.
