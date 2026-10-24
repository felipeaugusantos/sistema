{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemNexa;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoNexaCores;

type
  TAuttinMenuItemNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasNexa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorNexa, untLibTintaFactory, untGravandoExecucaoNexaNovasFormulas, untCadastroBasesNexa,
  untGravandoExecucaoNexaBases,  untCadastroNovasFormulasNexa,
  untGravandoExecucaoNexaMontadora,untGravandoExecucaoNexaDiluente,
  untGravandoExecucaoNexaBasesDiluente;

{ TAuttinMenuItemNexa }

constructor TAuttinMenuItemNexa.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesNexa.Create());
  Self.Adicionar(TCadastroBasesNexa.Create());
  Self.Adicionar(TCadastroNovasFormulasNexa.Create());
  Self.Adicionar(TGeracaoTintaNexa.Create());
  Self.Adicionar(TConsultaNexa.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesNexa }

constructor TConfiguracoesNexa.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesNexa');
end;

procedure TConfiguracoesNexa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorNexa.Create(auttinWrapper));
end;

{ TCadastroBasesNexa }

constructor TCadastroBasesNexa.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadNexaBase');
end;

procedure TCadastroBasesNexa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesNexa.TCadastroBasesNexa.Create());
end;

{ TConsultaNexa }

constructor TConsultaNexa.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaNexa');
end;

procedure TConsultaNexa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaNexa }

constructor TGeracaoTintaNexa.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadNexaGeraArquivo');
end;

procedure TGeracaoTintaNexa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('NEXA', [
    TGravandoExecucaoNexaBases.Create,
    TGravandoExecucaoNexaMontadora.Create,
    TGravandoExecucaoNexaDiluente.Create,
    TGravandoExecucaoNexaBasesDiluente.Create,
    TGravandoExecucaoNexaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadNexaGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('NEXA', [
    TGravandoExecucaoNexaNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasNexa.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadNexaNovasFormulas');
end;

procedure TCadastroNovasFormulasNexa.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasNexa.TCadastroNovasFormulasNexa.Create);
end;

end.
