unit untTefCitelCancelamentoTransacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untInterfaceTefCitel, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxLabel;

type
  TfrmTefCitelCancelamentoTransacao = class(TfrmPai, IObserverTEFCitel)
    pnOperacao: TPanel;
    pnMensTef: TPanel;
    pnDadosInfo: TPanel;
    lbMensTef: TcxLabel;
    tmrAtualizaMsg: TTimer;
    lblTipoTransacao: TcxLabel;
    lblDataTransacao: TcxLabel;
    lblValorTransacao: TcxLabel;
    lblBandeira: TcxLabel;
    tmrMostrarDados: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrAtualizaMsgTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrMostrarDadosTimer(Sender: TObject);
  private
    { Private declarations }
    FPermiteSair : Boolean;
    FNumeroControleOuNsu: string;
    FValorTransacao: Double;
    FDataTransacao: TDateTime;
    FCodigoCarteiraDigital: string;
    FCodigoTipoOperacaoCartao: string;
    FCodigoBandeira: string;
    FSucesso: Boolean;
    function fExecutarCancelamentoInterno: Boolean;
    procedure pAtualizaDadosTransacao;
    function fRetornaDescricaoTipoOperacaoCartao: string;
    function fAjustaCodigoOperacaoClisitef(const ACodigo: string): string;
  protected
    procedure AtualizaTefCitel(ARetorno: IRetornoTEFCitel);
  public
    { Public declarations }
    class function fExecutar(const ANumeroControleOuNsu: string;
      const AValorTransacao: Double; const ADataTransacao: TDateTime;
      const ACodigoCarteiraDigital, ACodigoTipoOperacaoCartao,
      ACodigoBandeira: string): Boolean;
    property NumeroControleOuNsu: String read FNumeroControleOuNsu write FNumeroControleOuNsu;
    property ValorTransacao: Double read FValorTransacao write FValorTransacao;
    property DataTransacao: TDateTime read FDataTransacao write FDataTransacao;
    property CodigoCarteiraDigital: string read FCodigoCarteiraDigital write FCodigoCarteiraDigital;
    property CodigoTipoOperacaoCartao: string read FCodigoTipoOperacaoCartao write FCodigoTipoOperacaoCartao;
    property CodigoBandeira: string read FCodigoBandeira write FCodigoBandeira;
    property Sucesso: Boolean read FSucesso;
  end;

implementation

uses
  untTefCitelInfoMsg, untTefCitelUtil, untFuncoesSimples, untFuncoesGenerica;

const
  INFO_VALOR_TRANSACAO = 'Valor Transação: %s';
  INFO_DATA_TRANSACAO = 'Data Transação: %s';
  INFO_TIPO_TRANSACAO = 'Tipo Transação: %s';
  INFO_BANDEIRA = 'Bandeira: %s';

{$R *.dfm}

{ TfrmTefCitelCancelamentoTransacao }

procedure TfrmTefCitelCancelamentoTransacao.AtualizaTefCitel(
  ARetorno: IRetornoTEFCitel);
var
  LFrmTefCitelInfoMsg : TFrmTefCitelInfoMsg;
  LstrNovoNumDoc: String ;
begin
  if ARetorno.StatusTEF.strStatus = '' then
    Exit;

  FPermiteSair := False;

  case StrToInt(ARetorno.StatusTEF.strStatus) of
    INFO_20_CANCELAMENTO:
    begin
      if fVerificaMsgTefCitel(ARetorno.StatusTEF.strMensagem) then
      begin
        pCriarFormularios(TFrmTefCitelInfoMsg, LFrmTefCitelInfoMsg);
        try
          LFrmTefCitelInfoMsg.strStatus           := ARetorno.StatusTEF.strStatus;
          LFrmTefCitelInfoMsg.lbStatusTef.Caption := ARetorno.StatusTEF.strMensagem;
          LFrmTefCitelInfoMsg.ShowModal;
        finally
          pFreeAndNil(LFrmTefCitelInfoMsg);
        end
      end
      else
      begin
        lbMensTef.Style.Font.Color := clRed;
        lbMensTef.Caption    := ARetorno.StatusTEF.strMensagem;
        lbMensTef.Refresh;
      end;
    end;
    INFO_21_CANCELAMENTO: exit;
    INFO_23_CANCELAMENTO: exit;
    INFO_30_CANCELAMENTO: exit;
    INFO_34_CANCELAMENTO: exit;
    INFO_131_CANCELAMENTO: exit;
    INFO_999_CANCELAMENTO:
    begin
      LstrNovoNumDoc := fRetNumDocTransacaoTef;
      pGravaTransacaoErro(LstrNovoNumDoc, FValorTransacao) ;
      fMensagem('ATENÇÃO!', ARetorno.StatusTEF.strMensagem, ['&Ok']);
    end;
    else
    if StrToInt(ARetorno.StatusTEF.strStatus) < 0 then
    begin
      FPermiteSair := False;
      if fVerificaMsgTefCitel(ARetorno.StatusTEF.strMensagem) then
        fMensagem('ATENÇÃO!', ARetorno.StatusTEF.strMensagem, ['&Ok']);
    end
    else
    begin
      FPermiteSair := False;
      if StrToInt(ARetorno.StatusTEF.strStatus) > 0 then
        fMensagem('ATENÇÃO!', ARetorno.StatusTEF.strMensagem, ['&Ok']);
    end;
  end;
end;

function TfrmTefCitelCancelamentoTransacao.fAjustaCodigoOperacaoClisitef(
  const ACodigo: string): string;
begin
  Result := ACodigo;
  if fCfgSis('TEFCIT', varString) = OPCAO_CLISITEF then
  begin
    if ACodigo = '3' then
      Result := '2'
    else if ACodigo = '2' then
      Result := '1'
    else if ACodigo = '122' then
      Result := '123';
  end;
end;

class function TfrmTefCitelCancelamentoTransacao.fExecutar(
  const ANumeroControleOuNsu: string; const AValorTransacao: Double;
  const ADataTransacao: TDateTime; const ACodigoCarteiraDigital,
  ACodigoTipoOperacaoCartao, ACodigoBandeira: string): Boolean;
var
  LfrmTefCitelCancelamentoTransacao: TfrmTefCitelCancelamentoTransacao;
begin
  Result := False;

  if not Assigned(objTefCitel) then
  begin
    pGravarErro(True,
      'objTefCitel não inicializado ao tentar cancelar transação TEF (NSU: ' +
      ANumeroControleOuNsu + ')',
      '[TfrmTefCitelCancelamentoTransacao.fExecutar]');
    Exit;
  end;

  pCriarFormularios(TfrmTefCitelCancelamentoTransacao,
    LfrmTefCitelCancelamentoTransacao);
  Try
    objTefCitel.AdicionaObserver(LfrmTefCitelCancelamentoTransacao);
    LfrmTefCitelCancelamentoTransacao.NumeroControleOuNsu := ANumeroControleOuNsu;
    LfrmTefCitelCancelamentoTransacao.ValorTransacao := AValorTransacao;
    LfrmTefCitelCancelamentoTransacao.DataTransacao := ADataTransacao;
    LfrmTefCitelCancelamentoTransacao.CodigoCarteiraDigital := ACodigoCarteiraDigital;
    LfrmTefCitelCancelamentoTransacao.CodigoTipoOperacaoCartao := ACodigoTipoOperacaoCartao;
    LfrmTefCitelCancelamentoTransacao.CodigoBandeira := ACodigoBandeira;
    LfrmTefCitelCancelamentoTransacao.ShowModal;
    Result := LfrmTefCitelCancelamentoTransacao.Sucesso;
  Finally
    objTefCitel.RemoveObserver(LfrmTefCitelCancelamentoTransacao);
    pFreeAndNil(LfrmTefCitelCancelamentoTransacao);
  End;
end;

procedure TfrmTefCitelCancelamentoTransacao.FormCreate(Sender: TObject);
begin
  inherited;
  FSucesso := False;
end;

procedure TfrmTefCitelCancelamentoTransacao.FormShow(Sender: TObject);
begin
  inherited;
  pAtualizaDadosTransacao;
  tmrMostrarDados.Enabled := True;
end;

function TfrmTefCitelCancelamentoTransacao.fRetornaDescricaoTipoOperacaoCartao: string;
var
  LCodigoTipoOperacaoCartao: Integer;
begin
  LCodigoTipoOperacaoCartao := StrToIntDef(FCodigoTipoOperacaoCartao, 0);
  Result := EmptyStr;
  case LCodigoTipoOperacaoCartao of
    3  : Result := 'Crédito';
    2  : Result := 'Débito';
    122: Result := 'Pix/Carteira Digital';
  end;
end;

procedure TfrmTefCitelCancelamentoTransacao.pAtualizaDadosTransacao;
begin
  lblTipoTransacao.Caption := Format(INFO_TIPO_TRANSACAO, [fRetornaDescricaoTipoOperacaoCartao]);
  lblDataTransacao.Caption := Format(INFO_DATA_TRANSACAO, [DateToStr(FDataTransacao)]);
  lblValorTransacao.Caption := Format(INFO_VALOR_TRANSACAO, [FormatCurr('#,##0.00', FValorTransacao)]);
  lblBandeira.Caption := Format(INFO_BANDEIRA, [fRetornaBandeiraPorCodigoSugestao(FCodigoBandeira)]);
end;

function TfrmTefCitelCancelamentoTransacao.fExecutarCancelamentoInterno: Boolean;
var
  LRetornoTEFCitel: IRetornoTEFCitel;
  LCarDig: String;
  LCodigoTipoOperacaoCartao: string;
begin
  Result := False;  //CARTEIRA_DIGITAL_ESTORNO
  LCodigoTipoOperacaoCartao := fAjustaCodigoOperacaoClisitef(FCodigoTipoOperacaoCartao);
  if (StrToIntDef(LCodigoTipoOperacaoCartao, 0) = CARTEIRA_DIGITAL) or
    (StrToIntDef(LCodigoTipoOperacaoCartao, 0) = CARTEIRA_DIGITAL_ESTORNO) then
  begin
    if fCfgSis('PIXSCP', varString) = 'S' then
      LCarDig := '{CarteirasDigitaisHabilitadas=001}'
    else
      LCarDig := '{CarteirasDigitaisHabilitadas='+FCodigoCarteiraDigital+'}';
  end
  else // outras formas de estorno
  begin
    LCarDig := '' ;
  end ;
  LRetornoTEFCitel :=  fCancelamentoNormal(strLoginUsuarioLogado,
                                          FDataTransacao,
                                          fNow,
                                          FNumeroControleOuNsu,
                                          FValorTransacao,
                                          LCodigoTipoOperacaoCartao,
                                          '',
                                          LCarDig);
  if Assigned(LRetornoTEFCitel) then
  begin
    Result := True;
    fMensagem('ATENÇÃO!', 'Transação cancelada com sucesso!', ['&OK']);
  end;
end;

procedure TfrmTefCitelCancelamentoTransacao.tmrAtualizaMsgTimer(
  Sender: TObject);
begin
  inherited;
  Application.ProcessMessages;
end;

procedure TfrmTefCitelCancelamentoTransacao.tmrMostrarDadosTimer(
  Sender: TObject);
begin
  inherited;
  tmrMostrarDados.Enabled := False;
  tmrAtualizaMsg.Enabled := True;
  try
    try
      FSucesso := fExecutarCancelamentoInterno;
    except
      On E: Exception Do
      Begin
        FSucesso := False;
        pGravarErro(True, E.Message, '[tmrMostrarDadosTimer]');
        fMensagem('ATENÇÃO!',
          'Falha ao processar o cancelamento da transação TEF.' + #13#10 + #13#10 +
          'Anote o Nº Controle/NSU: ' + FNumeroControleOuNsu + #13#10 +
          'Conclua o cancelamento em:' + #13#10 +
          'Útil > ADM - Administração TEF > botão Cancelamento.',
          ['&Ok'], 1);
      End;
    end;
  finally
    tmrAtualizaMsg.Enabled := False;
    Self.Close;
  end;
end;

end.
