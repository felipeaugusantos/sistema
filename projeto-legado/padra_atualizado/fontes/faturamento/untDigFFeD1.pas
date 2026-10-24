unit untDigFFeD1;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  EditFocus, Menus, Uni, AppEvnts, Mask, MaskEditFocus, QColorLabel,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigFFeD1 = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    pnlDados: TPanel;
    Label1: TLabel;
    edtNumFF: TEditFocus;
    edtEspFF: TEditFocus;
    Label2: TLabel;
    edtNumD1: TEditFocus;
    edtEspD1: TEditFocus;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    mskDtaD1: TMaskEditFocus;
    clblbl1: TColorLabel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strOpcDoc: String;
    strAutInc: String;
  end;

var
  frmDigFFeD1: TfrmDigFFeD1;

implementation

uses untFuncoesSimples;

{$R *.dfm}

function TfrmDigFFeD1.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result    := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumFF) Or (Sender = edtNumD1) Then
    Begin

      If fEmptyStr(TEditFocus(Sender).Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Número do Documento!', ['&Ok']);
        Result := FALSE;
      End;

    End

    Else If (Sender = mskDtaD1) Then
    Begin
      If StrToDateDef(mskDtaD1.Text, 0) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe a data de emissão do D1 corretamente!', ['&Ok']);
        Result := FALSE;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmDigFFeD1.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    Close;
    ModalResult := mrOk;    
  End;
end;

procedure TfrmDigFFeD1.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumFF);
  edtCodEmp.Text := VS_strCodEmp;
  edtDesEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

  If strToDateDef(mskDtaD1.Text, 0) <= 0 Then
    mskDtaD1.Text  := DateToStr(VS_Date);
end;

end.


