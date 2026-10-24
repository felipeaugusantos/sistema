program Yapay.Api.Demo;

uses
  ShareMem,
  Vcl.Forms,
  Yapay.Api.Envio.Cobranca.V3 in '..\api\Yapay.Api.Envio.Cobranca.V3.pas',
  Yapay.Api.Consulta.Cobranca.V3 in '..\api\Yapay.Api.Consulta.Cobranca.V3.pas',
  Yapay.Api.Inativar.Cobranca.V3 in '..\api\Yapay.Api.Inativar.Cobranca.V3.pas',
  Yapay.Api.Ambiente in '..\api\Yapay.Api.Ambiente.pas',
  Yapay.Api.Conexao in '..\api\Yapay.Api.Conexao.pas',
  Yapay.Api.Cobranca.Base in '..\api\Yapay.Api.Cobranca.Base.pas',
  Yapay.Api.Tabela.Tabela3.FormasDePagamento in '..\api\Yapay.Api.Tabela.Tabela3.FormasDePagamento.pas',
  Yapay.Api.Tabela.Tabela4.StatusDaTransacao in '..\api\Yapay.Api.Tabela.Tabela4.StatusDaTransacao.pas',
  Yapay.Api.TypeResponse in '..\api\Yapay.Api.TypeResponse.pas',
  Yapay.Api.Core in '..\api\Yapay.Api.Core.pas',
  Yapay.Api.Authorization in '..\api\Yapay.Api.Authorization.pas',
  Yapay.Api.Token in '..\api\Yapay.Api.Token.pas',
  Yapay.Api.MessageResponse in '..\api\Yapay.Api.MessageResponse.pas',
  Yapay.Api.ErrorResponse in '..\api\Yapay.Api.ErrorResponse.pas',
  Yapay.Api.Helpers in '..\api\Yapay.Api.Helpers.pas',
  Yapay.Api.Base in '..\api\Yapay.Api.Base.pas',
  Yapay.Api.Demo.FrmPrincipal in 'src\Yapay.Api.Demo.FrmPrincipal.pas' {FrmPrincipal},
  Yapay.Api.Resources in '..\api\Yapay.Api.Resources.pas',
  Yapay.Api.Listagem.Transacoes in '..\api\Yapay.Api.Listagem.Transacoes.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Demo API Yapay';
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  FrmPrincipal.Caption := Application.Title;
  Application.Run;
end.
