unit ContasBancarias.Model.ContaBancaria;

interface

uses System.SysUtils, ContasBancarias.Model.CredenciaisAutenticacao;

type
  TDadosRequisicao = record
    DataInicial: TDate;
    DataFinal: TDate;
  end;

type
  TContaBancaria = class
  private
    FCodigoBanco: Integer;
    FBanco: string;
    FAgencia: string;
    FNumeroConta: string;
    FDVConta: string;
    FTipoConta: string;
    FSaldo: Currency;
    FUltimaImportacao: TDateTime;
    FPortador: string;
    FCredenciaisAutenticacao: TCredenciaisAutenticacao;
    FErroConsulta: string;
    FQuantidadeDeMovimentacoes: Integer;

  public
    DadosRequisicao: TDadosRequisicao;
    property CodigoBanco: Integer read FCodigoBanco write FCodigoBanco;
    property Banco: string read FBanco write FBanco;
    property Agencia: string read FAgencia write FAgencia;
    property NumeroConta: string read FNumeroConta write FNumeroConta;
    property DVConta: string read FDVConta write FDVConta;
    property TipoConta: string read FTipoConta write FTipoConta;
    property Saldo: Currency read FSaldo write FSaldo;
    property UltimaImportacao: TDateTime read FUltimaImportacao write FUltimaImportacao;
    property Portador: string read FPortador write FPortador;
    property CredenciaisAutenticacao: TCredenciaisAutenticacao read FCredenciaisAutenticacao write FCredenciaisAutenticacao;
    property ErroConsulta: string read FErroConsulta write FErroConsulta;
    property QuantidadeDeMovimentacoes: Integer read FQuantidadeDeMovimentacoes write FQuantidadeDeMovimentacoes;

    procedure Inicializar(ACodigoBanco: Integer;
                          ABanco, AAgencia, ANumeroConta, ADVConta, ATipoConta: string;
                          ASaldo: Currency;
                          AUltimaImportacao: TDateTime;
                          APortador: string;
                          ACredenciaisAutenticacao: TCredenciaisAutenticacao);

    procedure LimparCredenciaisAutenticacao;
  end;

implementation

{ TContaBancaria }

procedure TContaBancaria.LimparCredenciaisAutenticacao;
begin
  if Assigned(FCredenciaisAutenticacao) then
    FreeAndNil(FCredenciaisAutenticacao);
end;

procedure TContaBancaria.Inicializar(ACodigoBanco: Integer;
                                     ABanco, AAgencia, ANumeroConta, ADVConta, ATipoConta: string;
                                     ASaldo: Currency;
                                     AUltimaImportacao: TDateTime;
                                     APortador: string;
                                     ACredenciaisAutenticacao: TCredenciaisAutenticacao);
begin
  FCodigoBanco := ACodigoBanco;
  FBanco := ABanco;
  FAgencia := AAgencia;
  FNumeroConta := ANumeroConta;
  FDVConta := ADVConta;
  FTipoConta := ATipoConta;
  FSaldo := ASaldo;
  FUltimaImportacao := AUltimaImportacao;
  FPortador := APortador;
  FCredenciaisAutenticacao := ACredenciaisAutenticacao;
end;

end.
