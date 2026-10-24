unit untIncluiFechamentoEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.Mask, MaskEditFocus, EditFocus, untFechamentoEstoque;

type
  TfrmIncluiFechamentoEstoque = class(TfrmPaiConfirma)
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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

    dtaDtaUlt,
    dtaDtaNov: TDateTime;

    intAnoFec,
    intMesFec,
    intUltimoAno,
    intUltimoMes: Integer;

  public
    { Public declarations }

    strCodEmp: String;

    objFechamento: TFechamentoEstoque;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmIncluiFechamentoEstoque: TfrmIncluiFechamentoEstoque;

implementation

{$R *.dfm}

Uses
  DateUtils,
  StrUtils,
  untTypesSistema,
  untConsultas,
  untFuncoesSimples;

procedure TfrmIncluiFechamentoEstoque.edtCodEmpKeyPress(Sender: TObject;
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

procedure TfrmIncluiFechamentoEstoque.FormClose(Sender: TObject;
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

    Else If fPergunta('Confirma o fechamendo de estoque do mês ' + mskNovFec.Text + ' para a empresa ' +
                       edtCodEmp.Text + '-' + edtNomEmp.Text + '?') Then
    Begin

      If objFechamento.fIncluiFechamento(edtCodEmp.Text, intAnoFec, intMesFec) Then
        pMensagemOk('Fechamanto incluido com sucesso!')
      Else
        Action := caNone;

    End

    Else
      Action := caNone;

  End;

end;

procedure TfrmIncluiFechamentoEstoque.FormCreate(Sender: TObject);
begin
  inherited;

  objFechamento := TFechamentoEstoque.Create(Self);
end;

procedure TfrmIncluiFechamentoEstoque.FormShow(Sender: TObject);
begin
  inherited;

  edtCodEmp.Text := strCodEmp;

  If Not strCodEmp.IsEmpty Then
    fValidaCampos(edtCodEmp, True);
end;

function TfrmIncluiFechamentoEstoque.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
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

          objFechamento.pGetUltimoFechamento(edtCodEmp.Text, intUltimoAno, intUltimoMes);

          If intUltimoAno > 0 Then
          Begin
            dtaDtaUlt      := EncodeDate(intUltimoAno, intUltimoMes, 1);
            mskUltFec.Text := FormatDateTime('MM/YYYY', dtaDtaUlt);

            dtaDtaNov      := IncMonth(dtaDtaUlt, 1);

            mskNovFec.Text := FormatDateTime('MM/YYYY', dtaDtaNov);

            mskNovFec.ReadOnly    := True;
            mskNovFec.TabStop     := False;
            mskNovFec.Color       := mskUltFec.Color;
            mskNovFec.NormalColor := mskUltFec.NormalColor;
          End Else
          Begin
            dtaDtaUlt      := 0;
            mskUltFec.Clear;

            mskNovFec.ReadOnly    := False;
            mskNovFec.TabStop     := True;
            mskNovFec.Color       := clWhite;
            mskNovFec.NormalColor := clWhite;
          End;

        End;

      End;

    End

    Else If (Sender = mskNovFec) Then
    Begin

      If fEmptyDate(mskNovFec.Text) Then
      Begin
        Result := False;
        pMensagemOk('Informe a data do fechamento de estoque!');
      End

      Else If StrToDateDef('01/' + mskNovFec.Text,0) <= 0 Then
      Begin
        mskNovFec.Clear;
        Result := False;
        pMensagemOk('Mês/Ano inválido!');
      End

      Else If (Not fEmptyDate(mskUltFec.Text)) And (StrToDateDef('01/' + mskNovFec.Text,0) <= StrToDateDef('01/' + mskUltFec.Text,0)) Then
      Begin
        Result := False;
        pMensagemOk('O novo fechamento deve ser no mês seguinte do fechamento anterior!');
      End

      Else If (FormatDateTime('YYYYMM', StrToDate('01/' + mskNovFec.Text)) >= FormatDateTime('YYYYMM', VS_Date)) Then
      Begin
        Result := False;
        pMensagemOk('O mês do fechamento deve ser menor que o mês atual!');
      End

      Else
      Begin
        mskNovFec.Text := FormatDateTime('MM/YYYY', StrToDate( '01/' + mskNovFec.Text));

        intAnoFec := StrToIntDef(RightStr(mskNovFec.Text, 4), 0);
        intMesFec := StrToIntDef(LeftStr(mskNovFec.Text, 2), 0);

        If (intAnoFec = 0) Or (intMesFec = 0) Then
        Begin
          Result := False;
          pMensagemOk('Mês/Ano inválido!');
        End;

      End;

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
