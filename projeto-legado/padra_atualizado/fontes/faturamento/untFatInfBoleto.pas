unit untFatInfBoleto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus,
  EditFocus, untLiberacao;

type
  TfrmFatInfBoleto = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    FlwpnlConfirma: TFlowPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    pnlBoleto: TPanel;
    Label7: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    edtBolAdt: TEditFocus;
    edtValRes: TEditFocus;
    edtDtaVen: TMaskEditFocus;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
  private
    { Private declarations }
    objLiberacao : TLiberacao;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    FConfirma: Boolean;
    FValorTotal: Double;
    FValorBoletoOriginal: Double;
    { Public declarations }
  end;

var
  frmFatInfBoleto: TfrmFatInfBoleto;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmFatInfBoleto }

procedure TfrmFatInfBoleto.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmFatInfBoleto.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  if ((StrToDateDef(edtDtaVen.Text,0)) <> (VS_Date + fCfgSis('DIABAD', VarInteger))) then
  begin
    objLiberacao.clear;
    objLiberacao.objMsgLibera.pAddTexto('A data do vencimento do boleto foi alterada!');
    objLiberacao.objMsgLibera.pAddTexto('Data Original: ' + DateToStr(VS_Date + fCfgSis('DIABAD', VarInteger)));
    objLiberacao.objMsgLibera.pAddTexto('Data Atual:    ' + edtDtaVen.Text);

    objLiberacao.strDirAce := 'CTRBOLADI';
    objLiberacao.strMsgSen := 'Alteração da data de vencimento';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    if not objLiberacao.fLibera then
    begin
      edtDtaVen.Text := DateToStr(VS_Date + fCfgSis('DIABAD', VarInteger));
      Exit;
    end;
  end;

  FConfirma := True;
  Close;
end;

procedure TfrmFatInfBoleto.FormCreate(Sender: TObject);
begin
  inherited;
  FConfirma := False;
  FValorTotal := 0;
  FValorBoletoOriginal := 0;
  objLiberacao := TLiberacao.Create;
end;

procedure TfrmFatInfBoleto.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
end;

procedure TfrmFatInfBoleto.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtBolAdt);
end;

function TfrmFatInfBoleto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtBolAdt) Then
    Begin
      If fStrToFloat(edtBolAdt.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor do boleto de adiantamento deve ser maior que zero!', ['&Ok']);
        edtBolAdt.Text := FloatToStrF(FValorBoletoOriginal, ffFixed, 12, 2);
        Result := False;
      End;

      If Result Then
      Begin
        edtValRes.Text := FloatToStrF(FValorTotal - fStrToFloat(edtBolAdt.Text), ffFixed, 12, 2);

        If fStrToFloat(edtValRes.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O valor do boleto de adiantamento deve ser menor ou igual ao valor do documento!', ['&Ok']);
          edtValRes.Text := FloatToStrF(FValorTotal - FValorBoletoOriginal, ffFixed, 12, 2);
          edtBolAdt.Text := FloatToStrF(FValorBoletoOriginal, ffFixed, 12, 2);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtDtaVen) Then
    Begin
      If StrToDateDef(edtDtaVen.Text,0) < VS_Date Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de vencimento não pode ser retroativa!', ['&Ok']);
        edtDtaVen.Text := DateToStr(VS_Date + fCfgSis('DIABAD', VarInteger));
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
