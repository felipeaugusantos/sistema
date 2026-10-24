unit untExcluiFechamentoFinanceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.Mask, MaskEditFocus,
  Vcl.StdCtrls, EditFocus, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, BitBtnLockedIncrem, untFechamentoFinanceiro;

type
  TfrmExcluiFechamentoFinanceiro = class(TfrmPaiConfirma)
    Label62: TLabel;
    Label1: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    mskUltFec: TMaskEditFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    AUltimaData: TDate;
    objFechamento: TFechamentoFinanceiro;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    ACodEmpresa: String;
  end;

var
  frmExcluiFechamentoFinanceiro: TfrmExcluiFechamentoFinanceiro;

implementation

uses
  DateUtils,
  StrUtils,
  untTypesSistema,
  untConsultas,
  untFuncoesSimples,
  Contabilidade.OutrosFechamentos.Funcoes;

{$R *.dfm}

procedure TfrmExcluiFechamentoFinanceiro.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
Var  arrEmpresa : TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmExcluiFechamentoFinanceiro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOK) Then
  Begin

    If Not fVerificaCampos Then
    Begin

      Action := caNone;
      Exit;

    End

    Else If TOutrosFechamentos.fPodeDeletarFechamento(edtCodEmp.Text, StrToDateDef( mskUltFec.Text, 0)) and  fPergunta('Confirma o remoção do fechamento financeiro do dia ' + mskUltFec.Text + ' para a empresa ' +
                       edtCodEmp.Text + '-' + edtNomEmp.Text + '?') Then
    Begin

      If objFechamento.ExcluiFechamento(edtCodEmp.Text, StrToDateDef( mskUltFec.Text, 0)) Then
        pMensagemOk('Fechamento removido com sucesso!')
      Else
        Action := caNone;

    End

    Else
      Action := caNone;

  End;
end;

procedure TfrmExcluiFechamentoFinanceiro.FormCreate(Sender: TObject);
begin
  inherited;
  objFechamento := TFechamentoFinanceiro.Create(Self, 'TfrmExcluiFechamentoFinanceiro');
end;

procedure TfrmExcluiFechamentoFinanceiro.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmp.Text := ACodEmpresa;

  If Not ACodEmpresa.IsEmpty Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

    objFechamento.GetUltimoFechamento(edtCodEmp.Text, AUltimaData);

    If AUltimaData > 0 Then
      mskUltFec.Text := FormatDateTime('DD/MM/YYYY', AUltimaData);
  End;

  if edtCodEmp.CanFocus then
    pSetFocus(edtCodEmp);
end;

function TfrmExcluiFechamentoFinanceiro.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a empresa para o fechamento!');
      End Else
      Begin

        edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

        If fEmptyStr(edtNomEmp.Text) Then
        Begin

          Result := False;
          pMensagemOk('Empresa não encontrada!');

        End Else
        Begin

          objFechamento.GetUltimoFechamento(edtCodEmp.Text, AUltimaData);

          If AUltimaData > 0 Then
          Begin
            mskUltFec.Text := FormatDateTime('DD/MM/YYYY', AUltimaData);
          End Else
          Begin
            AUltimaData      := 0;
            mskUltFec.Clear;

            Result := False;
            pMensagemOk('Não há fechamentos financeiro para a empresa ' + edtCodEmp.Text + '!');
          End;

        End;

      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
