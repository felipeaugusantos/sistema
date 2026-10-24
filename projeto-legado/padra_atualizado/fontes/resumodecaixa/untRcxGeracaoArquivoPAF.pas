unit untRcxGeracaoArquivoPAF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, System.DateUtils, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, System.ImageList,
  Vcl.ImgList, cxImageList;

type
  TfrmRcxGeracaoArquivoPAF = class(TForm)
    pnlPrincipal: TPanel;
    pnlMensagem: TPanel;
    lblMensagem: TLabel;
    pblTitulo: TPanel;
    lblTitulo: TLabel;
    pnlBotoes: TPanel;
    btnRegistrosPAF: TcxButton;
    btnVendasCNPJ: TcxButton;
    btnControleDAV: TcxButton;
    btnSair: TBitBtnLocked;
    lblMensagemCertificado: TLabel;
    imgBotoes: TcxImageList;
    grpLegenda: TGroupBox;
    shpArquivosGerados: TShape;
    lblArquivosGerados: TLabel;
    lblArquivosGeradosCor: TLabel;
    shpArquivosNaoGerados: TShape;
    lblArquivosNaoGerados: TLabel;
    lblArquivosNaoGeradosCor: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnRegistrosPAFClick(Sender: TObject);
    procedure btnVendasCNPJClick(Sender: TObject);
    procedure btnControleDAVClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    FDataCertificado,
    FDataCaixa: TDateTime;

    FListaArquivosNaoGerados: TStringList;

    function CarregaDadosCertificado(AMensagem: Boolean = False): Boolean;
    procedure AjustaCorBotoes;
    procedure RevalidaArquivosGerados;

    procedure CarregaTextoMensagem;
    function RetornaDescricaoArquivosPAFNaoGerados: String;
    { Private declarations }
  public
    property ListaArquivosNaoGerados: TStringList read FListaArquivosNaoGerados write FListaArquivosNaoGerados;
    property DataCaixa: TDAteTime read FDataCaixa write FDataCaixa;
    { Public declarations }
  end;

var
  frmRcxGeracaoArquivoPAF: TfrmRcxGeracaoArquivoPAF;

implementation
Uses untFuncoesSImples, untUtilMenuPAFNFCeMensagem, untFuncoesRel,
     untRcxTResumoDeCaixa;
{$R *.dfm}

procedure TfrmRcxGeracaoArquivoPAF.AjustaCorBotoes;
begin
  btnRegistrosPAF.Colors.DefaultText := clBlue;
  btnVendasCNPJ.Colors.DefaultText := clBlue;
  btnControleDAV.Colors.DefaultText := clBlue;
  btnRegistrosPAF.OptionsImage.ImageIndex := 2;
  btnVendasCNPJ.OptionsImage.ImageIndex := 2;
  btnControleDAV.OptionsImage.ImageIndex := 2;

  If FListaArquivosNaoGerados.IndexOf('I') > -1 Then
  Begin
    btnRegistrosPAF.Colors.DefaultText := clRed;
    btnRegistrosPAF.OptionsImage.ImageIndex := 1;
  End;

  If FListaArquivosNaoGerados.IndexOf('II') > -1 Then
  Begin
    btnVendasCNPJ.Colors.DefaultText := clRed;
    btnVendasCNPJ.OptionsImage.ImageIndex := 1;
  End;

  If FListaArquivosNaoGerados.IndexOf('IV') > -1 Then
  Begin
    btnControleDAV.Colors.DefaultText := clRed;
    btnControleDAV.OptionsImage.ImageIndex := 1;
  End;
end;

procedure TfrmRcxGeracaoArquivoPAF.btnControleDAVClick(Sender: TObject);
begin
  If Not CarregaDadosCertificado(True) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(425, 11160, [],
                        ['DTAINI', 'DTAFIN'],
                        [FormatDateTime('dd/mm/yyyy', FDataCaixa), FormatDateTime('dd/mm/yyyy', FDataCaixa)],
                        nil,
                        nil,
                        False);

  RevalidaArquivosGerados;
end;

procedure TfrmRcxGeracaoArquivoPAF.btnRegistrosPAFClick(Sender: TObject);
begin
  If Not CarregaDadosCertificado(True) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(302, 16945, [9686,9687,9688,9689,9690,9691,9692,9693,9694,9695],
                        ['DTAINI', 'DTAFIN'],
                        [FormatDateTime('dd/mm/yyyy', FDataCaixa), FormatDateTime('dd/mm/yyyy', FDataCaixa)],
                        nil,
                        nil,
                        False);
  
  RevalidaArquivosGerados;
end;

procedure TfrmRcxGeracaoArquivoPAF.btnSairClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmRcxGeracaoArquivoPAF.btnVendasCNPJClick(Sender: TObject);
begin
  If Not CarregaDadosCertificado(True) Then
    Exit;

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(355, 16946, [9686,9695,9697,9698,9699,9700],
                        ['DTAINI', 'DTAFIN'],
                        [FormatDateTime('dd/mm/yyyy', FDataCaixa), FormatDateTime('dd/mm/yyyy', FDataCaixa)],
                        nil,
                        nil,
                        False);

  RevalidaArquivosGerados;
end;

function TfrmRcxGeracaoArquivoPAF.CarregaDadosCertificado(AMensagem: Boolean = False): Boolean;
  Var
    LMensagem: String;

    LUtilMenuPAFNFCeMensagem: TfrmUtilMenuPAFNFCeMensagem;
begin
  FDataCertificado := untFuncoesSimples.RetornaDataValidadeCertificadoCADCER(VS_strCodEmp);

  LMensagem := EmptyStr;

  Result := True;

  Try
    lblMensagemCertificado.Font.Color := clBlue;
    If FDataCertificado = 0 Then
    Begin
      lblMensagemCertificado.Caption := 'O certificado não está cadastrado para a empresa ' + VS_strCodEmp + '.';
      lblMensagemCertificado.Font.Color := clRed;

      Result := False;

      If AMensagem Then
        LMensagem := 'O certificado não está cadastrado para a empresa ' + VS_strCodEmp + '.' + #13#10 +
                     'Para utilizar a rotina, providencie o certificado.' + #13#10 +
                     'Operação cancelada!';
    End
    Else If FDataCertificado <= VS_Date Then
    Begin
      lblMensagemCertificado.Caption := 'O certificado para a empresa ' + VS_strCodEmp +
                                        ' está vencido. A expiração ocorreu ' +
                                        IIF(FDataCertificado = VS_Date, 'hoje.', 'em ' + FormatDateTime('dd/mm/yyyy', FDataCertificado) + '.');
      lblMensagemCertificado.Font.Color := clRed;

      Result := False;

      If AMensagem Then
        LMensagem := 'O certificado para a empresa ' + VS_strCodEmp + ' está vencido.' + #13#10 +
                     'A expiração ocorreu ' +
                     IIF(FDataCertificado = VS_Date, 'hoje.', 'em ' + FormatDateTime('dd/mm/yyyy', FDataCertificado) + '.') + #13#10 +
                     'Para utilizar a rotina, providencie a renovação do certificado.'+ #13#10 +
                     'Operação cancelada!';
    End
    Else If DaysBetween(FDataCertificado, VS_Date) > 15 Then
      lblMensagemCertificado.Caption := 'O certificado para a empresa ' + VS_strCodEmp +
                                        ' é valido. A expiração ocorrerá em ' + FormatDateTime('dd/mm/yyyy', FDataCertificado) + '.'
    Else If DaysBetween(FDataCertificado, VS_Date) > 0 Then
    Begin
      lblMensagemCertificado.Caption := 'O certificado para a empresa ' + VS_strCodEmp +
                                        ' vencerá em ' + DaysBetween(FDataCertificado, VS_Date).ToString +
                                        ' dias. A expiração ocorrerá em ' + FormatDateTime('dd/mm/yyyy', FDataCertificado) + '.';
      lblMensagemCertificado.Font.Color := clGreen;

      If AMensagem Then
        LMensagem := 'O certificado para a empresa ' + VS_strCodEmp +
                     ' vencerá em ' + DaysBetween(FDataCertificado, VS_Date).ToString + ' dias.' + #13#10 +
                     'A expiração ocorrá em ' + FormatDateTime('dd/mm/yyyy', FDataCertificado) + '.' + #13#10 +
                     'Providencie a renovação antes do vencimento, para poder continuar utilizando a rotina.';
    End;
  Finally
    If Not LMensagem.IsEmpty Then
    Begin
      pCriarFormularios(TfrmUtilMenuPAFNFCeMensagem, LUtilMenuPAFNFCeMensagem);
      LUtilMenuPAFNFCeMensagem.strMensagem := LMensagem;
      LUtilMenuPAFNFCeMensagem.ShowModal;

      FreeAndNil(LUtilMenuPAFNFCeMensagem);
    End;
  End;
end;

procedure TfrmRcxGeracaoArquivoPAF.CarregaTextoMensagem;
begin
  If FListaArquivosNaoGerados.Count = 0 Then
    Exit;

  lblMensagem.Caption := 'O fechamento do caixa não pode ser efetuado, pois ' + RetornaDescricaoArquivosPAFNaoGerados + #13 + #13 +
                         'Esse(s) arquivo(s) pode(m) ser gerado(s) através das seguintes opções: ' + #13 +
                         '    -Acessando os botões abaixo ou ' + #13 +
                         '    -Menu Fiscal do Autcom.';
end;

procedure TfrmRcxGeracaoArquivoPAF.FormShow(Sender: TObject);
begin
  CarregaTextoMensagem;
  CarregaDadosCertificado;
  AjustaCorBotoes;
end;

function TfrmRcxGeracaoArquivoPAF.RetornaDescricaoArquivosPAFNaoGerados: String;
  Var
    LArquivo: String;
begin
  Result := 'o(s) arquivo(s) PAF:';

  For LArquivo In FListaArquivosNaoGerados Do
  Begin
    Result := Result + #13 + '    -';
    If LArquivo.Equals('I') Then
      Result := Result + 'Registros do PAF-NFC-e;'
    Else If LArquivo.Equals('II') Then
      Result := Result + 'Vendas Identificadas pelo CPF/CNPJ;'
    Else If LArquivo.Equals('IV') Then
      Result := Result + 'Controle dos DAV;';
  End;

  Result := Result + #13 + 'não fora(m) gerado(s) para o dia ' + FormatDateTime('dd/mm/yyyy', FDataCaixa) + '.';
end;

procedure TfrmRcxGeracaoArquivoPAF.RevalidaArquivosGerados;
begin
  TResumoDeCaixa.ValidaArquivosPAFJaGerados(FListaArquivosNaoGerados, FDataCaixa);
  AjustaCorBotoes;
  CarregaTextoMensagem;

  If FListaArquivosNaoGerados.Count = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Todos os arquivos PAF foram gerados para o dia ' + FormatDateTime('dd/mm/yyyy', FDataCaixa) + ' com sucesso.' + #13 +
                         'Acesse novamente o fechamento do caixa.', ['&Ok']);

    Self.Close;
  End;
end;

end.
