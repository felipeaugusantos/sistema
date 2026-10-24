unit untLibCartoesDigValor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.ExtCtrls,
  System.Math, Vcl.ComCtrls,

  EditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  ComboBoxFocus,

  untLibCartoesPaiSimples, untTLibCartoesFuncoes;

type
  TfrmDigValor = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    lblUnitario: TLabel;
    edtValor: TEditFocus;
    cmbTipVal: TComboBoxFocus;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FRedimessionaTelaExterna: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnPermiteZero,
    blnPermiteMenorZero,
    blnConciliacao: Boolean;
    property blnRedimessionaTelaExterna: Boolean read FRedimessionaTelaExterna write FRedimessionaTelaExterna;
    class function fDigitaValor(var fltValor: Double;
                                    strTitulo: String;
                                    strFormato: String = '#,##0.00';
                                    blnPermiteZero: Boolean = False;
                                    blnPermiteMenorZero: Boolean = False): Boolean;
  end;

implementation

{$R *.dfm}

function TfrmDigValor.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtValor) Then
    Begin

      If (Not blnPermiteZero) And (TLibCartoesFuncoes.fStrToFloat(TEdit(Sender).Text) = 0) Then
      Begin
        TLibCartoesFuncoes.fMensagem('','Informe um valor diferente de zero!', ['&Ok']);
        Result := False;
      End
      Else If (blnPermiteZero) And (Not blnPermiteMenorZero) And (TLibCartoesFuncoes.fStrToFloat(TEdit(Sender).Text) < 0) Then
      Begin
        TLibCartoesFuncoes.fMensagem('','Informe um valor maior ou igual a zero!', ['&Ok']);
        Result := False;
      End
      Else If (Not blnPermiteZero) And (Not blnPermiteMenorZero) And (TLibCartoesFuncoes.fStrToFloat(TEdit(Sender).Text) <= 0) Then
      Begin
        TLibCartoesFuncoes.fMensagem('','Informe um valor maior que zero!', ['&Ok']);
        Result := False;
      End;
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
end;

procedure TfrmDigValor.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;

  cmbTipVal.Visible := blnConciliacao;
end;

procedure TfrmDigValor.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  ModalResult := mrOk;
end;

class function TfrmDigValor.fDigitaValor(var fltValor: Double;
                                        strTitulo: String;
                                        strFormato: String = '#,##0.00';
                                        blnPermiteZero: Boolean = False;
                                        blnPermiteMenorZero: Boolean = False): Boolean;
  Var
    frmDigValor : TfrmDigValor;
begin
  TLibCartoesFuncoes.pCriarFormularios(TfrmDigValor, frmDigValor);
  Try
    Try
      frmDigValor.blnPermiteZero      := blnPermiteZero;
      frmDigValor.blnPermiteMenorZero := blnPermiteMenorZero;
      frmDigValor.edtValor.Text       := FormatFloat(strFormato, fltValor);
      frmDigValor.edtValor.EditFormat := strFormato;
      frmDigValor.Caption             := strTitulo;
      frmDigValor.ShowModal;

      Result   := (frmDigValor.ModalResult = mrOk);
      fltValor := TLibCartoesFuncoes.fStrToFloat(frmDigValor.edtValor.Text);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[]');
      End;
    End;
  Finally
    FreeAndNil(frmDigValor);
  End;
end;

end.
