{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemEucatexImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoEucatexImobiliariaCores,
  untGravandoExecucaoEucatexImobiliariaColorantes;

type
  TAuttinMenuItemEucatexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesEucatexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesEucatexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesEucatexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaEucatexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaEucatexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasEucatexImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorEucatexImobiliaria, untLibTintaFactory, untGravandoExecucaoEucatexImobiliariaNovasFormulas,
  untCadastroBasesEucatexImobiliaria, untCadastroColorantesEucatexImobiliaria, untGravandoExecucaoEucatexImobiliariaBases,
  untCadastroNovasFormulasEucatexImobiliaria;

{ TAuttinMenuItemEucatexImobiliaria }

constructor TAuttinMenuItemEucatexImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesEucatexImobiliaria.Create());
  Self.Adicionar(TCadastroBasesEucatexImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesEucatexImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasEucatexImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaEucatexImobiliaria.Create());
  Self.Adicionar(TConsultaEucatexImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesEucatexImobiliaria }

constructor TConfiguracoesEucatexImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesEucatexImobiliaria');
end;

procedure TConfiguracoesEucatexImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorEucatexImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesEucatexImobiliaria }

constructor TCadastroBasesEucatexImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadEucBase');
end;

procedure TCadastroBasesEucatexImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesEucatexImobiliaria.TCadastroBasesEucatexImobiliaria.Create());
end;

{ TConsultaEucatexImobiliaria }

constructor TConsultaEucatexImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaEucatexImobiliaria');
end;

procedure TConsultaEucatexImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaEucatexImobiliaria }

constructor TGeracaoTintaEucatexImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadEucGerarArquivos');
end;

procedure TGeracaoTintaEucatexImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Eucatex Imobiliaria', [
    TGravandoExecucaoEucatexImobiliariaColorantes.Create,
    TGravandoExecucaoEucatexImobiliariaBases.Create,
    TGravandoExecucaoEucatexImobiliariaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadEucGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Eucatex Imobiliaria', [
    TGravandoExecucaoEucatexImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesEucatexImobiliaria }

constructor TCadastroColorantesEucatexImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadEucColorantes');
end;

procedure TCadastroColorantesEucatexImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesEucatexImobiliaria.TCadastroColorantesEucatexImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasEucatexImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadEucNovasFormulas');
end;

procedure TCadastroNovasFormulasEucatexImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasEucatexImobiliaria.TCadastroNovasFormulasEucatexImobiliaria.Create);
end;

end.
