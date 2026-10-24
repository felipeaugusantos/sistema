unit untIncluiFechamentoFiscal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, untFechamentoFiscal;

type
  TfrmIncluiFechamentoFiscal = class(TfrmPaiConfirma)
    Label62: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    Label1: TLabel;
    mskUltFec: TMaskEditFocus;
    Label2: TLabel;
    mskNovFec: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }

    dtaDtaUlt: TDate;

  public
    { Public declarations }

    strCodEmp: String;

    objFechamento: TFechamentoFiscal;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmIncluiFechamentoFiscal: TfrmIncluiFechamentoFiscal;

implementation

{$R *.dfm}

Uses
  DateUtils,
  StrUtils,
  untTypesSistema,
  untConsultas,
  untFuncoesSimples;

procedure TfrmIncluiFechamentoFiscal.edtCodEmpKeyPress(Sender: TObject;
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

procedure TfrmIncluiFechamentoFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;

  If (ModalResult = mrOK) Then
  Begin

    If Not fVerificaCampos Then
    Begin

      Action := caNone;
      Exit;

    End

    Else If fPergunta('Confirma o fechamendo fiscal do dia ' + mskNovFec.Text + ' para a empresa ' +
                       edtCodEmp.Text + '-' + edtNomEmp.Text + '?') Then
    Begin

      If objFechamento.fIncluiFechamento(edtCodEmp.Text, StrToDateDef(mskNovFec.Text, 0)) Then
        pMensagemOk('Fechamanto incluido com sucesso!')
      Else
        Action := caNone;

    End

    Else
      Action := caNone;

  End;

end;

procedure TfrmIncluiFechamentoFiscal.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := strCodEmp;

  If Not strCodEmp.IsEmpty Then
    fValidaCampos(edtCodEmp, True);
end;

function TfrmIncluiFechamentoFiscal.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a empresa para o fechamento fiscal!');
      End Else
      Begin

        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin

          Result := False;
          pMensagemOk('Empresa não encontrada!');

        End Else
        Begin

          objFechamento.pGetUltimoFechamento(edtCodEmp.Text, dtaDtaUlt);

          If dtaDtaUlt > 0 Then
          Begin
            mskUltFec.Text := FormatDateTime('DD/MM/YYYY', dtaDtaUlt);
          End Else
          Begin
            dtaDtaUlt      := 0;
            mskUltFec.Clear;
          End;

        End;

      End;

    End

    Else If (Sender = mskNovFec) Then
    Begin

      If fEmptyDate(mskNovFec.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a data do fechamento de Fical!');
      End

      Else If (Not fEmptyDate(mskUltFec.Text)) And (StrToDateDef(mskNovFec.Text,0) <= StrToDateDef(mskUltFec.Text,0)) Then
      Begin
        Result := False;
        pMensagemOk('A data do fechamento deve ser maior que ' + mskUltFec.Text + '!');
      End

      Else If StrToDateDef(mskNovFec.Text,0) >= VS_Date Then
      Begin
        Result := False;
        pMensagemOk('A data do fechamento deve ser menor que a data atual!');
      End

      Else mskNovFec.Text := FormatDateTime('DD/MM/YYYY', StrToDateDef(mskNovFec.Text,0));

    End;

  End;

  If (Not Result) Then
  Begin
    If (Sender = mskNovFec) And mskNovFec.ReadOnly Then
      pSetFocus(edtCodEmp)
    Else
      pSetFocus(Sender);
  End;
end;

end.
