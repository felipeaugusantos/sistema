unit untExcluiFechamentoFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, untFechamentoFiscal;

type
  TfrmExcluiFechamentoFiscal = class(TfrmPaiConfirma)
    Label62: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label1: TLabel;
    mskUltFec: TMaskEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    dtaDtaUlt: TDate;

    objFecahemto: TFechamentoFiscal;

  public
    { Public declarations }
    strCodEmp: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmExcluiFechamentoFiscal: TfrmExcluiFechamentoFiscal;

implementation

{$R *.dfm}

Uses
  DateUtils,
  StrUtils,
  untTypesSistema,
  untConsultas,
  untFuncoesSimples,
  Contabilidade.OutrosFechamentos.Funcoes;

procedure TfrmExcluiFechamentoFiscal.btnConfirmaClick(Sender: TObject);
begin
 // inherited;

end;

procedure TfrmExcluiFechamentoFiscal.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmpresa : TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin

    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmExcluiFechamentoFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOK) Then
  Begin

    If Not fVerificaCampos Then
    Begin

      Action := caNone;
      Exit;

    End

    Else If TOutrosFechamentos.fPodeDeletarFechamento(edtCodEmp.Text, StrToDateDef( mskUltFec.Text, 0)) and fPergunta('Confirma o remoção do fechamento fiscal do dia ' + mskUltFec.Text + ' para a empresa ' +
                       edtCodEmp.Text + '-' + edtNomEmp.Text + '?') Then
    Begin

      If objFecahemto.fExcluiFechamento(edtCodEmp.Text, StrToDateDef( mskUltFec.Text, 0)) Then
        pMensagemOk('Fechamento removido com sucesso!')
      Else
        Action := caNone;

    End

    Else
      Action := caNone;

  End;

end;

procedure TfrmExcluiFechamentoFiscal.FormCreate(Sender: TObject);
begin
  inherited;

  objFecahemto := TFechamentoFiscal.Create(Self);
end;

procedure TfrmExcluiFechamentoFiscal.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := strCodEmp;

  If Not strCodEmp.IsEmpty Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

    objFecahemto.pGetUltimoFechamento(edtCodEmp.Text, dtaDtaUlt);

    If dtaDtaUlt > 0 Then
      mskUltFec.Text := FormatDateTime('DD/MM/YYYY', dtaDtaUlt);

  End;

end;

function TfrmExcluiFechamentoFiscal.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a empresa para o fechamento de estoque!');
      End Else
      Begin

        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin

          Result := False;
          pMensagemOk('Empresa não encontrada!');

        End Else
        Begin

          objFecahemto.pGetUltimoFechamento(edtCodEmp.Text, dtaDtaUlt);

          If dtaDtaUlt > 0 Then
          Begin
            mskUltFec.Text := FormatDateTime('DD/MM/YYYY', dtaDtaUlt);
          End Else
          Begin
            dtaDtaUlt      := 0;
            mskUltFec.Clear;

            Result := False;
            pMensagemOk('Não há fechamentos fiscais para a empresa ' + edtCodEmp.Text + '!');
          End;

        End;

      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
