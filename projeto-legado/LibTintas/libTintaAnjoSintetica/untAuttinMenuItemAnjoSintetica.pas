{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAnjoSintetica;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAnjoSinteticaCores,
  untGravandoExecucaoAnjoSinteticaColorantes;

type
  TAuttinMenuItemAnjoSintetica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAnjoSintetica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAnjoSintetica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAnjoSintetica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAnjoSintetica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAnjoSintetica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAnjoSintetica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensAnjoSintetica = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAnjoSintetica, untLibTintaFactory, untGravandoExecucaoAnjoSinteticaNovasFormulas, untCadastroBasesAnjoSintetica, 
  untCadastroColorantesAnjoSintetica, untGravandoExecucaoAnjoSinteticaBases, 
  untCadastroNovasFormulasAnjoSintetica, untCadastroEmbalagensAnjoSintetica;

{ TAuttinMenuItemAnjoSintetica }

constructor TAuttinMenuItemAnjoSintetica.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAnjoSintetica.Create());
  Self.Adicionar(TCadastroBasesAnjoSintetica.Create());
  Self.Adicionar(TCadastroColorantesAnjoSintetica.Create());
  Self.Adicionar(TCadastroEmbalagensAnjoSintetica.Create());
  Self.Adicionar(TCadastroNovasFormulasAnjoSintetica.Create());
  Self.Adicionar(TGeracaoTintaAnjoSintetica.Create());
  Self.Adicionar(TConsultaAnjoSintetica.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAnjoSintetica }

constructor TConfiguracoesAnjoSintetica.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAnjoSintetica');
end;

procedure TConfiguracoesAnjoSintetica.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAnjoSintetica.Create(auttinWrapper));
end;

{ TCadastroBasesAnjoSintetica }

constructor TCadastroBasesAnjoSintetica.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadAJABase');
end;

procedure TCadastroBasesAnjoSintetica.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAnjoSintetica.TCadastroBasesAnjoSintetica.Create());
end;

{ TConsultaAnjoSintetica }

constructor TConsultaAnjoSintetica.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAnjoSintetica');
end;

procedure TConsultaAnjoSintetica.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAnjoSintetica }

constructor TGeracaoTintaAnjoSintetica.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadAJAGeraArquivo');
end;

procedure TGeracaoTintaAnjoSintetica.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('AnjoSintetica', [
    TGravandoExecucaoAnjoSinteticaColorantes.Create,
    TGravandoExecucaoAnjoSinteticaBases.Create,
    TGravandoExecucaoAnjoSinteticaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadAJAGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('AnjoSintetica Imobiliária', [
    TGravandoExecucaoAnjoSinteticaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAnjoSintetica }

constructor TCadastroColorantesAnjoSintetica.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadAJAColorantes');
end;

procedure TCadastroColorantesAnjoSintetica.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAnjoSintetica.TCadastroColorantesAnjoSintetica.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAnjoSintetica.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadAJANovasFormulas');  
end;

procedure TCadastroNovasFormulasAnjoSintetica.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAnjoSintetica.TCadastroNovasFormulasAnjoSintetica.Create);
end;

{ TCadastroEmbalagensAnjoSintetica }

constructor TCadastroEmbalagensAnjoSintetica.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadAJAEmbalagens');
end;

procedure TCadastroEmbalagensAnjoSintetica.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensAnjoSintetica.TCadastroEmbalagensAnjoSintetica.Create);
end;

end.
