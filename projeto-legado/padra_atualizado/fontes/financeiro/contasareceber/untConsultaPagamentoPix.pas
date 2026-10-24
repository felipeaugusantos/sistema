unit untConsultaPagamentoPix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, untTFuncoesPixAutcom, System.StrUtils;

type
  TfrmConsultaPagamentoPix = class(TfrmPai)
    pnlFundo: TPanel;
    lblCelular: TLabel;
    lblIdentificacaoPix: TLabel;
    grpStatus: TGroupBox;
    btnConsultar: TBitBtnLocked;
    lblPixCitel: TLabel;
    lblPixCitelResult: TLabel;
    lblStatus: TLabel;
    lblStatusResult: TLabel;
    lblDtaHora: TLabel;
    lblDtaHorResult: TLabel;
    lblGerRotina: TLabel;
    lblGerRotinaResult: TLabel;
    lblMeiPagamento: TLabel;
    lblMeiPagamentoResult: TLabel;
    edtIdentificacaoPix: TEditFocus;
    procedure btnConsultarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FTxIdPix,
    FTSeqPix,
    FTJsoEnv,
    FTCriado,
    FNumeroDocumento,
    FEspecieDocumento,
    FEmpresaDocumento,
    FStatusPixAutcom: String;

    procedure ConsultarPagamento;
  public
    property TxIdPix: String read FTxIdPix write FTxIdPix;
    property TSeqPix: String read FTSeqPix write FTSeqPix;
    property TJsoEnv: String read FTJsoEnv write FTJsoEnv;
    property TCriado: String read FTCriado write FTCriado;

    property NumeroDocumento:  String read FNumeroDocumento  write FNumeroDocumento;
    property EspecieDocumento: String read FEspecieDocumento write FEspecieDocumento;
    property EmpresaDocumento: String read FEmpresaDocumento write FEmpresaDocumento;
    property StatusPixAutcom:  String read FStatusPixAutcom  write FStatusPixAutcom;
  end;

implementation

uses untFuncoesSimples, untTiposPix, untTFuncoesAuxiliaresPix, untGravando;
{$R *.dfm}

procedure TfrmConsultaPagamentoPix.btnConsultarClick(Sender: TObject);
begin
  TfrmGravando.fExecutarModal(ConsultarPagamento, 'Aguarde... Consultando API do Banco.', '');
end;

procedure TfrmConsultaPagamentoPix.ConsultarPagamento;
Var
  LResposta: String;
  LDadosPix: TDadosRetornoPixConsulta;
  LChavePedido : String;
begin
  LDadosPix := Nil;
  Try
    If fEmptyStr(FTxIdPix) Then
      Exit;

    Try
      LResposta := TFuncoesPixAutcom.ConsultarCobrancaPorTxId(FTxIdPix, FTSeqPix, FTJsoEnv, True);

      If LResposta <> 'ErroConsultaPix' Then
      Begin
        LDadosPix := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(LResposta, FTJsoEnv);

        If Not fEmptyStr(LDadosPix.TextoQrCode) Then
        Begin
          lblPixCitelResult.Caption := 'SIM';     //PIX CITEL OK
          lblPixCitelResult.Font.Color := clGreen;

          lblStatusResult.Caption := LDadosPix.Status;
          lblDtaHorResult.Caption := FormatDateTime('dd/mm/yyyy hh:nn:ss', LDadosPix.DataCriacao);
          lblGerRotinaResult.Caption := FTCriado;
          lblMeiPagamentoResult.Caption := IIF(MatchStr(LDadosPix.Status, STATUS_PIX_PAGO), 'Pix QRCODE', '');
          lblStatusResult.Visible := True;
          lblDtaHorResult.Visible := True;
          lblGerRotinaResult.Visible := True;
          lblMeiPagamentoResult.Visible := IIF(MatchStr(LDadosPix.Status, STATUS_PIX_PAGO), True, False);
          lblStatus.Visible := True;
          lblDtaHora.Visible := True;
          lblGerRotina.Visible := True;
          lblMeiPagamento.Visible := IIF(MatchStr(LDadosPix.Status, STATUS_PIX_PAGO), True, False);

          If (StatusPixAutcom <> LDadosPix.Status) Then
          Begin
            LChavePedido := 'FATGOR' + FNumeroDocumento +
                                       FEspecieDocumento +
                                       FEmpresaDocumento;

            If Not fLock_Unlock(LChavePedido, True, False) Then
            Begin
              fMensagem('AVISO', 'O status do Pix já foi atualizado no banco, mas o sistema ainda não '+
                                  'refletiu essa alteração porque o pedido está sendo utilizado em outra estação por: ' +
                                   fGetHostLock(LChavePedido)  + '!', ['&Ok']);
            End
            Else
              fLock_Unlock(LChavePedido, False, False);

          End;
        End
      End
      Else
      Begin
        lblPixCitelResult.Caption := 'NÃO';     //PIX CITEL NÃO
        lblPixCitelResult.Font.Color := clRed;

        lblStatusResult.Caption := '';
        lblDtaHorResult.Caption := '';
        lblGerRotinaResult.Caption := '';
        lblMeiPagamentoResult.Caption := '';
        lblStatusResult.Visible := False;
        lblDtaHorResult.Visible := False;
        lblGerRotinaResult.Visible := False;
        lblMeiPagamentoResult.Visible := False;
        lblStatus.Visible := False;
        lblDtaHora.Visible := False;
        lblGerRotina.Visible := False;
        lblMeiPagamento.Visible := False;
      End;
    Except
      On E: Exception Do
        fMensagem('ATENÇÃO', E.Message, ['&Ok']);
    End;
  Finally
    grpStatus.Visible := True;

    If Assigned(LDadosPix) Then
      FreeAndNil(LDadosPix);
  End;
end;

procedure TfrmConsultaPagamentoPix.FormCreate(Sender: TObject);
begin
  inherited;
  FTxIdPix := '';
  FTJsoEnv := '';
  FTSeqPix := '';
  FTCriado := '';
end;

procedure TfrmConsultaPagamentoPix.FormShow(Sender: TObject);
begin
  inherited;
  If Not fEmptyStr(FTxIdPix) Then
    edtIdentificacaoPix.Text :=  FTxIdPix;
end;

end.
