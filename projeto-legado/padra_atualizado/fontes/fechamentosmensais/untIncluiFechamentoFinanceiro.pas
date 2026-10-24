unit untIncluiFechamentoFinanceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass, untConsultas,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, untTypesSistema,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, untFechamentoFinanceiro;

type
  TfrmIncluiFechamentoFinanceiro = class(TfrmPaiConfirma)
    Label62: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskUltFec: TMaskEditFocus;
    mskNovFec: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    AUltimaData: TDate;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    ACodEmpresa: String;
    arrEmpresa : TConsultasArray;
    objFechamento: TFechamentoFinanceiro;
  end;

var
  frmIncluiFechamentoFinanceiro: TfrmIncluiFechamentoFinanceiro;

implementation

Uses
  DateUtils,
  StrUtils,
  untFuncoesSimples;

{$R *.dfm}

procedure TfrmIncluiFechamentoFinanceiro.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


procedure TfrmIncluiFechamentoFinanceiro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOK) Then
  Begin

    If Not fVerificaCampos Then
    Begin

      Action := caNone;
      Exit;

    End

    Else If (edtNomEmp.Text <> '+1') and
             fPergunta('Confirma o fechamendo financeiro do dia ' + mskNovFec.Text + ' para a empresa ' +
                       edtCodEmp.Text + '-' + edtNomEmp.Text + '?') Then
    Begin

      If objFechamento.IncluiFechamento(edtCodEmp.Text, StrToDateDef(mskNovFec.Text, 0)) Then
        pMensagemOk('Fechamanto incluido com sucesso!')
      Else
        Action := caNone;

    End

    Else If (edtNomEmp.Text = '+1') and
            fPergunta('Confirma o fechamendo financeiro do dia ' + mskNovFec.Text + ' para a empresas selecionadas? ') Then
    Begin

      If objFechamento.IncluiFechamento(arrEmpresa, StrToDateDef(mskNovFec.Text, 0)) Then
        pMensagemOk('Fechamanto incluido com sucesso!')
      Else
        Action := caNone;
    End

    Else
      Action := caNone;

  End;
end;

procedure TfrmIncluiFechamentoFinanceiro.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := ACodEmpresa;

  If Not ACodEmpresa.IsEmpty Then
    fValidaCampos(edtCodEmp, True);

  if edtCodEmp.CanFocus then
    pSetFocus(edtCodEmp);
end;

function TfrmIncluiFechamentoFinanceiro.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a empresa para o fechamento financeiro!');
      End Else
      Begin
        If edtCodEmp.Text <> '000' Then
          edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin

          Result := False;
          pMensagemOk('Empresa não encontrada!');

        End
        Else if (edtNomEmp.Text <> '+1') then
        Begin

          objFechamento.GetUltimoFechamento(edtCodEmp.Text, AUltimaData);

          If AUltimaData > 0 Then
          Begin
            mskUltFec.Text := FormatDateTime('DD/MM/YYYY', AUltimaData);
          End Else
          Begin
            AUltimaData      := 0;
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
        pMensagemOk('Informe a data do fechamento financeiro!');
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
