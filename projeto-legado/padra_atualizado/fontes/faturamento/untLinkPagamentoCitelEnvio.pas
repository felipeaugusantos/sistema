unit untLinkPagamentoCitelEnvio;

interface

uses
  REST.Types, Rest.Json, sysUtils, System.JSON, strUtils, Classes,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  REST.Client, untPaiSimples, Forms,
{$ENDIF}
  Generics.Collections, Data.DB, MemDS, DBAccess, Uni,
  untClassesComumLinkPagamentoCitel, untInterfaceLinkPagamentoCitel;

type
  TLinkPagamentoCitelEnvio = class
    private
      FNumDoc : String;
      FEspDoc : String;
      FCodCli : String;
      FCodOpe : String;
      FCodEmp : String;
      FSeqFgo : String;
      FJSONRequest : String;
      FJSONResponse : String;
     {$IFNDEF LINUX}
      FFormMsg : TfrmPaiSimples;
     {$ENDIF}
      procedure pMostraErrorGettingServerCertificate;
      procedure pClickBotao(Sender: TObject);
      procedure pClickLabel(Sender: TObject);
    public
      function fGerarLinkPagamento(strOperacao : String; intQtdParcelas : Integer;
        tpParcLoja : String; fltValPed : Double; var AstrRetornoMsgErro: string;
        const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
        const AdtaExpiracao: TDateTime) : TGerarLinkPagamentoResposta ;

      function fCriarNovaTransacao(strCodEmp, strUrlPgt, strNumNit, strNumNsu,
        strCodOpe : String; dtaDtaCad : TDate; hraHraCad : TTime; fltValTra : Double;
        strSeqFgo : String; intQtdParcelas : Integer; strTipLan, strAutoIncs: String;
        strMercId : String; dtaExpiracao: TDateTime) : Boolean;

      function fCriarCancelamento(const AstrNsu, AstrNit: String; var AstrJSONRet : String; var AstrJSONReq : String): TJSONObject ;
      function fEfetuarCancelamento(const AstrNitCanc, AstrNumeroCartao, AstrVencCartao: String; var AstrJSONRet : String; var AstrJSONReq : String): TJSONObject ;

      property strNumDoc : String read FNumDoc write FNumDoc;
      property strEspDoc : String read FEspDoc write FEspDoc;
      property strCodCli : String read FCodCli write FCodCli;
      property strCodOpe : String read FCodOpe write FCodOpe;
      property strCodEmp : String read FCodEmp write FCodEmp;
      property strSeqFgo : String read FSeqFgo write FSeqFgo;
      property strJSONRequest : String read FJSONRequest write FJSONRequest;
      property strJSONResponse : String read FJSONResponse write FJSONResponse;
  end;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untFuncoesSimples, BitBtnLockedIncrem, Vcl.Controls, Vcl.StdCtrls, Vcl.Graphics,
{$ENDIF}
  untLinkPagamentoCitelModel, untFactoryLinkPagamentoCitel;

const
  msgErrorGettingServerCertificate = 'REST request failed: Error getting Server Certificate';
  msgInconsistenciaGeracao = 'Houve uma inconsistência na geração do Link de Pagamento.';
  msgSuporteCitel = 'Entre em contato com o Suporte Citel!';

{ TLinkPagamentoCitelEnvio }

function TLinkPagamentoCitelEnvio.fGerarLinkPagamento(strOperacao : String; intQtdParcelas : Integer;
  tpParcLoja : String; fltValPed : Double; var AstrRetornoMsgErro: string;
  const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel; const AdtaExpiracao: TDateTime): TGerarLinkPagamentoResposta;
var
  LObjLink: ILinkPagamentoCitel ;
begin
  Result := nil;
  FJSONResponse := '';
  FJSONRequest := '';

  LObjLink := fCriarLinkPagamentoCitel ;
  try
    try
      Result := LObjLink.fGerarLinkPagamento(strOperacao,
                                             intQtdParcelas,
                                             tpParcLoja,
                                             fltValPed,
                                             AstrRetornoMsgErro,
                                             ArecInfoDoc,
                                             AdtaExpiracao) ;

      if not Assigned(Result) then
        raise Exception.Create('Erro ao gerar link de pagamento.');

    except
      on ELpgCredI: ExceptionLinkPgCredencialInvalida do
        AstrRetornoMsgErro := msgInconsistenciaGeracao
          + #13#10 + 'A credencial (id/senha) do link de pagamento configurada no Autcom é inválida!';

      on ELpgCredNA: ExceptionLinkPgCredencialNaoAutorizada do
        AstrRetornoMsgErro := 'A credencial (id/senha) configurada no Autcom não tem permissão para gerar link de pagamento!'
          + #13#10 + 'Entre em contato com o Suporte ' + LObjLink.NomeFornecedorServico + '!'
          + #13#10 + 'Recurso API: ' + LObjLink.RequestResource;

      on ELpgUrl: ExceptionLinkPgUrlInvalida do
        AstrRetornoMsgErro := msgInconsistenciaGeracao
          + #13#10 + 'A URL do link de pagamento configurada no Autcom é inválida ou está inoperante.';

      on ELpg: ExceptionLinkPg do
        AstrRetornoMsgErro := msgInconsistenciaGeracao
           + #13#10 + ELpg.Message
           + #13#10 + msgSuporteCitel;

      on E: Exception do
        AstrRetornoMsgErro := msgInconsistenciaGeracao
          + #13#10 + msgSuporteCitel;
    end;
  finally
    FJSONResponse := LObjLink.JSONResponse;
    FJSONRequest := LObjLink.JSONRequest;

    if FJSONResponse = msgErrorGettingServerCertificate then
      pMostraErrorGettingServerCertificate;
  end;
end;

function TLinkPagamentoCitelEnvio.fCriarCancelamento(const AstrNsu,
  AstrNit: String; var AstrJSONRet : String; var AstrJSONReq : String): TJSONObject;
var
  LObjLink: ILinkPagamentoCitel ;
begin
  LObjLink := fCriarLinkPagamentoCitel ;

  result := LObjLink.fCriarCancelamento(AstrNsu,
                                        AstrNit,
                                        AstrJSONRet,
                                        AstrJSONReq) ;

  FJSONResponse := LObjLink.JSONResponse ;
  FJSONRequest := LObjLink.JSONRequest ;

  if FJSONResponse = msgErrorGettingServerCertificate then
    pMostraErrorGettingServerCertificate;

end;

function TLinkPagamentoCitelEnvio.fCriarNovaTransacao(strCodEmp, strUrlPgt, strNumNit,
                                               strNumNsu, strCodOpe : String;
                                               dtaDtaCad : TDate; hraHraCad : TTime;
                                               fltValTra : Double; strSeqFgo : String;
                                               intQtdParcelas : Integer;
                                               strTipLan, strAutoIncs: String;
                                               strMercId : String;
                                               dtaExpiracao: TDateTime) : Boolean;
begin
  Result := TLinkPagamentoCitelModel.fNovaTransacao(strCodEmp, strUrlPgt, strNumNit,
                                             strNumNsu, strCodOpe, dtaDtaCad,
                                             hraHraCad,
                                             strMercId,
                                             fltValTra, strSeqFgo, FJSONRequest,
                                             FJSONResponse, intQtdParcelas, strTipLan,
                                             strAutoIncs, dtaExpiracao);
end;

function TLinkPagamentoCitelEnvio.fEfetuarCancelamento(const AstrNitCanc, AstrNumeroCartao, AstrVencCartao: String;
                                                var AstrJSONRet : String; var AstrJSONReq : String): TJSONObject;
var
  LObjLink: ILinkPagamentoCitel ;
begin
  FJSONResponse := '';
  FJSONRequest := '';

  LObjLink := fCriarLinkPagamentoCitel ;
  try

    result := LObjLink.fEfetuarCancelamento(AstrNitCanc,
                                            AstrNumeroCartao,
                                            AstrVencCartao,
                                            AstrJSONRet,
                                            AstrJSONReq) ;

  finally
    FJSONResponse := LObjLink.JSONResponse ;
    FJSONRequest := LObjLink.JSONRequest ;
    AstrJSONRet := FJSONResponse ;
    AstrJSONReq := FJSONRequest ;

    if FJSONResponse = msgErrorGettingServerCertificate then
     pMostraErrorGettingServerCertificate;
  end;
end;

procedure TLinkPagamentoCitelEnvio.pClickBotao(Sender: TObject);
begin
{$IFNDEF LINUX}
  FFormMsg.Close;
{$ENDIF}
end;

procedure TLinkPagamentoCitelEnvio.pClickLabel(Sender: TObject);
begin
{$IFNDEF LINUX}
  pBrowserNavigate(PChar(TLabel(Sender).Caption));
{$ENDIF}
end;

procedure TLinkPagamentoCitelEnvio.pMostraErrorGettingServerCertificate;
  const
    urlEasyFix = 'https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi';
    msgInfo = 'Ocorreu um problema no envio do link de pagamento. '+
              'Uma possível solução para o problema pode '+
              'ser encontrada na seção de downloads, no endereço mencionado abaixo. '+
              'Após download e instalação, reiniciar o AUTCOM!';
{$IFNDEF LINUX}
  var
    btnOk : TBitBtnLocked;
    lblMsgInfo, lblMsgLink : TLabel;
{$ENDIF}
begin
{$IFNDEF LINUX}
  pCriarFormularios(TfrmPaiSimples, FFormMsg);
  try
    FFormMsg.pgcDados.Visible := False;
    FFormMsg.Width := 800;
    FFormMsg.Height := 160;
    FFormMsg.Position := TPosition.poDesktopCenter;
    FFormMsg.Caption := 'Aviso';

    lblMsgInfo                  := TLabel.Create(FFormMsg);
    lblMsgInfo.Parent           := FFormMsg;
    lblMsgInfo.AlignWithMargins := True;
    lblMsgInfo.AutoSize         := True;
    lblMsgInfo.Font.Size        := 12;
    lblMsgInfo.Align            := TAlign.alTop;
    lblMsgInfo.Alignment        := TAlignment.taCenter;
    lblMsgInfo.WordWrap         := True;
    lblMsgInfo.Caption          := msgInfo;

    lblMsgLink                  := TLabel.Create(FFormMsg);
    lblMsgLink.Parent           := FFormMsg;
    lblMsgLink.AlignWithMargins := True;
    lblMsgLink.AutoSize         := True;
    lblMsgLink.Font.Size        := 10;
    lblMsgLink.Align            := TAlign.alBottom;
    lblMsgLink.Alignment        := TAlignment.taCenter;
    lblMsgLink.WordWrap         := True;
    lblMsgLink.Caption          := urlEasyFix;
    lblMsgLink.OnClick          := pClickLabel;
    lblMsgLink.Font.Color       := clBlue;
    lblMsgLink.Font.Style       := [fsUnderline];
    lblMsgLink.Cursor           := crHandPoint;

    btnOk                       := TBitBtnLocked.Create(FFormMsg);
    btnOk.Parent                := FFormMsg;
    btnOk.Align                 := TAlign.alBottom;
    btnOk.AlignWithMargins      := True;
    btnOk.Margins.Top           := 15;
    btnOk.Margins.Right         := 250;
    btnOk.Margins.Left          := 250;
    btnOk.Caption               := 'OK';
    btnOk.Cursor                := crHandPoint;
    btnOk.OnClick               := pClickBotao;

    FFormMsg.ShowModal;
  finally
    pFreeAndNil(FFormMsg);
  end;
{$ELSE}
  WriteLog(msgInfo);
{$ENDIF}
end;

end.

