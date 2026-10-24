unit untExcluiFechamentoEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, untFechamentoEstoque;

type
  TfrmExcluiFechamentoEstoque = class(TfrmPaiConfirma)
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

    dtaDtaUlt: TDateTime;

    intUltimoAno,
    intUltimoMes: Integer;

    objFecahemto: TFechamentoEstoque;

  public
    { Public declarations }
    strCodEmp: String;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmExcluiFechamentoEstoque: TfrmExcluiFechamentoEstoque;

implementation

{$R *.dfm}

Uses
  DateUtils,
  StrUtils,
  untTypesSistema,
  untConsultas,
  untFuncoesSimples,
  Contabilidade.OutrosFechamentos.Funcoes;

procedure TfrmExcluiFechamentoEstoque.btnConfirmaClick(Sender: TObject);
begin
 // inherited;

end;

procedure TfrmExcluiFechamentoEstoque.edtCodEmpKeyPress(Sender: TObject;
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

procedure TfrmExcluiFechamentoEstoque.FormClose(Sender: TObject;
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

    Else If TOutrosFechamentos.fPodeDeletarFechamento(edtCodEmp.Text, intUltimoMes, intUltimoAno) and fPergunta('Confirma o remoção do fechamento de estoque do mês ' + mskUltFec.Text + ' para a empresa ' +
                       edtCodEmp.Text + '-' + edtNomEmp.Text + '?') Then
    Begin

      If objFecahemto.fExcluiFechamento(edtCodEmp.Text, intUltimoAno, intUltimoMes) Then
        pMensagemOk('Fechamento removido com sucesso!')
      Else
        Action := caNone;

    End

    Else
      Action := caNone;

  End;

end;

procedure TfrmExcluiFechamentoEstoque.FormCreate(Sender: TObject);
begin
  inherited;

  objFecahemto := TFechamentoEstoque.Create(Self);
end;

procedure TfrmExcluiFechamentoEstoque.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := strCodEmp;

  If Not strCodEmp.IsEmpty Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);

    objFecahemto.pGetUltimoFechamento(edtCodEmp.Text, intUltimoAno, intUltimoMes);

    If intUltimoAno > 0 Then
    Begin
      dtaDtaUlt      := EncodeDate(intUltimoAno, intUltimoMes, 1);
      mskUltFec.Text := FormatDateTime('MM/YYYY', dtaDtaUlt);
    End;

  End;

end;

function TfrmExcluiFechamentoEstoque.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

          objFecahemto.pGetUltimoFechamento(edtCodEmp.Text, intUltimoAno, intUltimoMes);

          If intUltimoAno > 0 Then
          Begin
            dtaDtaUlt      := EncodeDate(intUltimoAno, intUltimoMes, 1);
            mskUltFec.Text := FormatDateTime('MM/YYYY', dtaDtaUlt);
          End Else
          Begin
            dtaDtaUlt      := 0;
            mskUltFec.Clear;

            Result := False;
            pMensagemOk('Não há fechamentos de estoque para a empresa ' + edtCodEmp.Text + '!');
          End;

        End;

      End;

    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

end.
