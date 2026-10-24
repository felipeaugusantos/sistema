unit untTMenuImportaVendas;

interface



Uses untRedeCardAPI,Forms,System.SysUtils,untTConfirmaCartoesRedeCard, untFuncoesSimples,
     untTExtratoConfirmaCartoes,untTImportaVendasConfirmacaoRedeCard, Vcl.Menus, untFuncoes,
     ImportaVendasCartao.Interfaces, ImportaVendasCartaoFactory.Interfaces, cxProgressBar;

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
    procedure VerificarTabelas;
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
  ImportaVendasCartaoFactory.Classes;

constructor TMenuImportaVendas.Create;
begin
  AguardeExecutarModalA(VerificarTabelas,'Aguarde, Verificando tabelas...', '');
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
      FPeriodoImportacao.ImportouVendas := FImportacao.Importou;

      if not FPeriodoImportacao.ImportouVendas then
      begin
        fMensagem('ATENÇÃO',
                  'Não foram importadas cobranças para o período selecionado.',
                  ['&Ok']);

        Exit;
      end;

      ExecutaAguarde(GerarExtratoVendasImportadas,
                     'Aguarde... Processando vendas importadas.');

      FPeriodoImportacao.DataInicial := FImportacao.DataInicial;
      FPeriodoImportacao.DataFinal   := FImportacao.DataFinal;

      LExtratoConfirmaCartoes.DadosVendas := FImportacao.ExtratoVendas;
      ExecutaAguarde(LExtratoConfirmaCartoes.GravaExtratoCartoes,
                     'Aguarde... Gravando vendas processadas.');

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
    LRedeCardAPI: TRedeCardAPI;
    LVendasRedeCard: TVendasRedeCard;
    LExtratoConfirmaCartoes: TExtratoConfirmaCartoes;
    LImportaVendasConfirmacaoRedeCard: TImportaVendasConfirmacaoRedeCard;
Begin
  Try
    LRedeCardAPI := TRedeCardAPI.Create(Nil);
    LRedeCardAPI.Aplicacao := Application.Handle;
    LRedeCardAPI.ConfirmaCartoes := True;
    LRedeCardAPI.pSelecionaFonte;
    FPeriodoImportacao.ImportouVendas := LRedeCardAPI.ImportouVendas;

    If LRedeCardAPI.ImportouVendas Then
    Begin
      Try
        LVendasRedeCard := TVendasRedeCard.Create;
        LVendasRedeCard.DataInicial := LRedeCardAPI.DataInicial;
        LVendasRedeCard.DataFinal   := LRedeCardAPI.DataFinal;
        ExecutaAguarde(LVendasRedeCard.ImportaExtratoVendas,'Aguarde... Processando vendas importadas.');

        FPeriodoImportacao.DataInicial := LRedeCardAPI.DataInicial;
        FPeriodoImportacao.DataFinal := LRedeCardAPI.DataFinal;

        Try
          LExtratoConfirmaCartoes := TExtratoConfirmaCartoes.Create;
          LExtratoConfirmaCartoes.DadosVendas := LVendasRedeCard.ExtratoVendas;
          ExecutaAguarde(LExtratoConfirmaCartoes.GravaExtratoCartoes,'Aguarde... Gravando vendas processadas.')
        Finally
          FreeAndNil(LExtratoConfirmaCartoes);
        End;

      Finally
        FreeAndNil(LVendasRedeCard);
      End;
    End;

    // importa as vendas dos pagamentos do periodo
    If LRedeCardAPI.ImportouPagamentos Then
    Begin
      Try
        LImportaVendasConfirmacaoRedeCard := TImportaVendasConfirmacaoRedeCard.Create(LRedeCardAPI.DataInicial,LRedeCardAPI.DataFinal);
        LImportaVendasConfirmacaoRedeCard.ImportacaoDasVendasFaltantes;

        If (LImportaVendasConfirmacaoRedeCard.ExtratoVendas.Count > 0) Then
        Begin
          Try
            LExtratoConfirmaCartoes := TExtratoConfirmaCartoes.Create;
            LExtratoConfirmaCartoes.DadosVendas := LImportaVendasConfirmacaoRedeCard.ExtratoVendas;
            ExecutaAguarde(LExtratoConfirmaCartoes.GravaExtratoCartoes,'Aguarde... Gravando Vendas Importadas.')
          Finally
            FreeAndNil(LExtratoConfirmaCartoes);
          End;
        End;

      Finally
        FreeAndNil(LImportaVendasConfirmacaoRedeCard);
      End;
    End;


  Finally
    FreeAndNil(LRedeCardAPI);
  End;
End;

procedure TMenuImportaVendas.VerificarTabelas;
begin
  pVerificaTabelas;
end;

end.
