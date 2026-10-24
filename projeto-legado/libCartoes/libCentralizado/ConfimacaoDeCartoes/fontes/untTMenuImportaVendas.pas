unit untTMenuImportaVendas;

interface



Uses Vcl.Forms, System.SysUtils, Vcl.Menus,

     cxProgressBar,

     untTExtratoConfirmaCartoes, untTImportaVendasConfirmacaoRedeCard,
     untTConfirmaCartoesRedeCard, untTLibCartoesFuncoes,
     ImportaVendasCartao.Interfaces;

Type
  TPeriodoImportacao = Record
    DataInicial: TDateTime;
    DataFinal: TDateTime;
    ImportouVendas: Boolean;
  End;

Type
  TMenuImportaVendas = Class
  Private
    FImportacao: IImportacaoVendasCartao;
    FPeriodoImportacao: TPeriodoImportacao;
    FConciliadora: String;
    function  GerarExtratoVendasImportadas(pgbProgresso: TcxProgressBar): Boolean;
  Public
    constructor Create;
    procedure ImportarVendasCartao;
    procedure ImportarVendasRedeCardOnline;
    property Conciliadora: String read FConciliadora write FConciliadora;
    property PeriodoImportacao : TPeriodoImportacao Read FPeriodoImportacao Write FPeriodoImportacao;
  End;


implementation

{ TMenuImportaVendas }

uses
  ImportaVendasCartaoFactory.Classes, untLibCartoesConstantes, untLibCartoesInterfacesTipos;

constructor TMenuImportaVendas.Create;
begin
  If Assigned(TLibCartoesFuncoes.FDadosImportacaoConfirmacao) Then
    TLibCartoesFuncoes.FDadosImportacaoConfirmacao := Nil;

  TLibCartoesFuncoes.FDadosImportacaoConfirmacao := TDadosImportacaoConfirmacao.Create;
end;

function TMenuImportaVendas.GerarExtratoVendasImportadas(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := FImportacao.GerarExtratoVendasImportadas(pgbProgresso);
end;

procedure TMenuImportaVendas.ImportarVendasCartao;
var
  LExtratoConfirmaCartoes: TExtratoConfirmaCartoes;
begin
  if FConciliadora.IsEmpty then
    raise Exception.Create('Conciliadora não informada. Operação cancelada!');

  FImportacao := TImportacaoVendasCartaoFactory.New.Conciliadora(FConciliadora);
  LExtratoConfirmaCartoes := TExtratoConfirmaCartoes.Create;
  try
    try
      FImportacao.ImportarVendasCartao;
      FPeriodoImportacao.ImportouVendas := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.ImportouVendas;

      if not FPeriodoImportacao.ImportouVendas then
      begin
        TLibCartoesFuncoes.fMensagem('ATENÇÃO',
                                     'Não foram importadas cobranças para o período selecionado.',
                                     ['&Ok']);

        Exit;
      end;

      TLibCartoesFuncoes.ExecutaAguarde(GerarExtratoVendasImportadas, 'Aguarde... Processando vendas importadas.');

      FPeriodoImportacao.DataInicial := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataInicial;
      FPeriodoImportacao.DataFinal   := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataFinal;

      LExtratoConfirmaCartoes.DadosVendas := FImportacao.ExtratoVendas;
      TLibCartoesFuncoes.ExecutaAguarde(LExtratoConfirmaCartoes.GravaExtratoCartoes, 'Aguarde... Gravando vendas processadas.');

    except
      On E: Exception do
        raise Exception.Create('Problemas ao gerar extrato. ' + E.Message);
    end;
  finally
    FreeAndNil(LExtratoConfirmaCartoes);
  end;
end;

procedure TMenuImportaVendas.ImportarVendasRedeCardOnline;
  Var
    LVendasRedeCard: TVendasRedeCard;
    LExtratoConfirmaCartoes: TExtratoConfirmaCartoes;
    LImportaVendasConfirmacaoRedeCard: TImportaVendasConfirmacaoRedeCard;
Begin
  untLibCartoesConstantes.MenuImportacaoCartoes.Find('Importação RedeCard Online').Click;
  FPeriodoImportacao.ImportouVendas := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.ImportouVendas;

  If TLibCartoesFuncoes.FDadosImportacaoConfirmacao.ImportouVendas Then
  Begin
    Try
      LVendasRedeCard := TVendasRedeCard.Create;
      LVendasRedeCard.DataInicial := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataInicial;
      LVendasRedeCard.DataFinal   := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataFinal;
      TLibCartoesFuncoes.ExecutaAguarde(LVendasRedeCard.ImportaExtratoVendas,'Aguarde... Processando vendas importadas.');

      FPeriodoImportacao.DataInicial := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataInicial;
      FPeriodoImportacao.DataFinal := TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataFinal;

      Try
        LExtratoConfirmaCartoes := TExtratoConfirmaCartoes.Create;
        LExtratoConfirmaCartoes.DadosVendas := LVendasRedeCard.ExtratoVendas;
        TLibCartoesFuncoes.ExecutaAguarde(LExtratoConfirmaCartoes.GravaExtratoCartoes,'Aguarde... Gravando vendas processadas.')
      Finally
        FreeAndNil(LExtratoConfirmaCartoes);
      End;

    Finally
      FreeAndNil(LVendasRedeCard);
    End;
  End;

  // importa as vendas dos pagamentos do periodo
  If TLibCartoesFuncoes.FDadosImportacaoConfirmacao.ImportouPagamentos Then
  Begin
    Try
      LImportaVendasConfirmacaoRedeCard := TImportaVendasConfirmacaoRedeCard.Create(TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataInicial,
                                                                                    TLibCartoesFuncoes.FDadosImportacaoConfirmacao.DataFinal);
      LImportaVendasConfirmacaoRedeCard.ImportacaoDasVendasFaltantes;

      If (LImportaVendasConfirmacaoRedeCard.ExtratoVendas.Count > 0) Then
      Begin
        Try
          LExtratoConfirmaCartoes := TExtratoConfirmaCartoes.Create;
          LExtratoConfirmaCartoes.DadosVendas := LImportaVendasConfirmacaoRedeCard.ExtratoVendas;
          TLibCartoesFuncoes.ExecutaAguarde(LExtratoConfirmaCartoes.GravaExtratoCartoes,'Aguarde... Gravando Vendas Importadas.')
        Finally
          FreeAndNil(LExtratoConfirmaCartoes);
        End;
      End;

    Finally
      FreeAndNil(LImportaVendasConfirmacaoRedeCard);
    End;
  End;
End;

end.
