{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemColorPro;

interface

uses
  untGenericAuttinMenuItem, Vcl.Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoColorProCores;

type
  TAuttinMenuItemColorPro = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesColorPro = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesColorPro = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaColorPro = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaColorPro = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasColorPro = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorColorPro, untLibTintaFactory, untGravandoExecucaoColorProNovasFormulas, untCadastroBasesColorPro,
  untGravandoExecucaoColorProBases, untCadastroNovasFormulasColorPro, untGravandoExecucaoColorProImportaNovasFormulas;

{ TAuttinMenuItemColorPro }

constructor TAuttinMenuItemColorPro.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesColorPro.Create());
  Self.Adicionar(TCadastroBasesColorPro.Create());
  Self.Adicionar(TCadastroNovasFormulasColorPro.Create());
  Self.Adicionar(TGeracaoTintaColorPro.Create());
  Self.Adicionar(TConsultaColorPro.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesColorPro }

constructor TConfiguracoesColorPro.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesWandaPro');
end;

procedure TConfiguracoesColorPro.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorColorPro.Create(auttinWrapper));
end;

{ TCadastroBasesColorPro }

constructor TCadastroBasesColorPro.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadWanProBases');
end;

procedure TCadastroBasesColorPro.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesColorPro.TCadastroBasesColorPro.Create());
end;

{ TConsultaColorPro }

constructor TConsultaColorPro.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaWandaPro');
end;

procedure TConsultaColorPro.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaColorPro }

constructor TGeracaoTintaColorPro.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadWanProGeraArquivo');
end;

procedure TGeracaoTintaColorPro.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Color Pro', [
    TGravandoExecucaoColorProBases.Create,
    TGravandoExecucaoColorProCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadWanProGeraArqNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Color Pro', [
    TGravandoExecucaoColorProImportaNovasFormulas.Create,
    TGravandoExecucaoColorProNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasColorPro.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadWCPNovasFormulas');
end;

procedure TCadastroNovasFormulasColorPro.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasColorPro.TCadastroNovasFormulasColorPro.Create);
end;

end.
