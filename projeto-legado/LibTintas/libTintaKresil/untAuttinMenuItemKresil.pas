{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemKresil;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoKresilCores,
  untGravandoExecucaoKresilColorantes;

type
  TAuttinMenuItemKresil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesKresil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesKresil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesKresil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaKresil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaKresil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasKresil = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorKresil, untLibTintaFactory, untGravandoExecucaoKresilNovasFormulas, untCadastroBasesKresil, 
  untCadastroColorantesKresil, untGravandoExecucaoKresilBases,
  untCadastroNovasFormulasKresil;

{ TAuttinMenuItemKresil }

constructor TAuttinMenuItemKresil.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesKresil.Create());
  Self.Adicionar(TCadastroBasesKresil.Create());
  Self.Adicionar(TCadastroColorantesKresil.Create());
  Self.Adicionar(TCadastroNovasFormulasKresil.Create());
  Self.Adicionar(TGeracaoTintaKresil.Create());
  Self.Adicionar(TConsultaKresil.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesKresil }

constructor TConfiguracoesKresil.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesKresil');
end;

procedure TConfiguracoesKresil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorKresil.Create(auttinWrapper));
end;

{ TCadastroBasesKresil }

constructor TCadastroBasesKresil.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadKREBase');
end;

procedure TCadastroBasesKresil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesKresil.TCadastroBasesKresil.Create());
end;

{ TConsultaKresil }

constructor TConsultaKresil.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaKresil');
end;

procedure TConsultaKresil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaKresil }

constructor TGeracaoTintaKresil.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadKREGeraArquivo');
end;

procedure TGeracaoTintaKresil.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Kresil', [
    TGravandoExecucaoKresilColorantes.Create,
    TGravandoExecucaoKresilBases.Create,
    TGravandoExecucaoKresilCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadKREGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Kresil', [
    TGravandoExecucaoKresilNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesKresil }

constructor TCadastroColorantesKresil.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadKREColorantes');
end;

procedure TCadastroColorantesKresil.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesKresil.TCadastroColorantesKresil.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasKresil.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadKRENovasFormulas');
end;

procedure TCadastroNovasFormulasKresil.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasKresil.TCadastroNovasFormulasKresil.Create);
end;


end.
