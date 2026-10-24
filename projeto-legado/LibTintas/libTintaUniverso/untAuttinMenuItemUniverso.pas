{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemUniverso;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoUniversoCores,
  untGravandoExecucaoUniversoColorantes;

type
  TAuttinMenuItemUniverso = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesUniverso = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesUniverso = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesUniverso = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaUniverso = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaUniverso = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasUniverso = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorUniverso, untLibTintaFactory, untGravandoExecucaoUniversoNovasFormulas,
  untCadastroBasesUniverso, untCadastroColorantesUniverso, untGravandoExecucaoUniversoBases,
  untCadastroNovasFormulasUniverso;

{ TAuttinMenuItemUniverso }

constructor TAuttinMenuItemUniverso.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesUniverso.Create());
  Self.Adicionar(TCadastroBasesUniverso.Create());
  Self.Adicionar(TCadastroColorantesUniverso.Create());
  Self.Adicionar(TCadastroNovasFormulasUniverso.Create());
  Self.Adicionar(TGeracaoTintaUniverso.Create());
  Self.Adicionar(TConsultaUniverso.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesUniverso }

constructor TConfiguracoesUniverso.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesUniverso');
end;

procedure TConfiguracoesUniverso.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorUniverso.Create(auttinWrapper));
end;

{ TCadastroBasesUniverso }

constructor TCadastroBasesUniverso.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadUniBase');
end;

procedure TCadastroBasesUniverso.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesUniverso.TCadastroBasesUniverso.Create());
end;

{ TConsultaUniverso }

constructor TConsultaUniverso.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaUniverso');
end;

procedure TConsultaUniverso.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaUniverso }

constructor TGeracaoTintaUniverso.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadUniGerarArquivos');
end;

procedure TGeracaoTintaUniverso.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Universo Imobiliaria', [
    TGravandoExecucaoUniversoColorantes.Create,
    TGravandoExecucaoUniversoBases.Create,
    TGravandoExecucaoUniversoCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadUniGeraNfm1')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Universo Imobiliaria', [
    TGravandoExecucaoUniversoNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesUniverso }

constructor TCadastroColorantesUniverso.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadUniColorantes');
end;

procedure TCadastroColorantesUniverso.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesUniverso.TCadastroColorantesUniverso.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasUniverso.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadUniNovasFormulas');
end;

procedure TCadastroNovasFormulasUniverso.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasUniverso.TCadastroNovasFormulasUniverso.Create);
end;

end.
