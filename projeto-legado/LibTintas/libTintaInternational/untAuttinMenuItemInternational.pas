{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemInternational;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoInternationalCores,
  untGravandoExecucaoInternationalColorantes;

type
  TAuttinMenuItemInternational = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesInternational = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesInternational = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesInternational = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaInternational = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaInternational = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasInternational = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensInternational = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorInternational, untLibTintaFactory, untGravandoExecucaoInternationalNovasFormulas, untCadastroBasesInternational, 
  untCadastroColorantesInternational, untGravandoExecucaoInternationalBases, 
  untCadastroNovasFormulasInternational, untCadastroEmbalagensInternational;

{ TAuttinMenuItemInternational }

constructor TAuttinMenuItemInternational.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesInternational.Create());
  Self.Adicionar(TCadastroBasesInternational.Create());
  Self.Adicionar(TCadastroColorantesInternational.Create());
  Self.Adicionar(TCadastroEmbalagensInternational.Create());
  Self.Adicionar(TCadastroNovasFormulasInternational.Create());
  Self.Adicionar(TGeracaoTintaInternational.Create());
  Self.Adicionar(TConsultaInternational.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesInternational }

constructor TConfiguracoesInternational.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesInternational');
end;

procedure TConfiguracoesInternational.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorInternational.Create(auttinWrapper));
end;

{ TCadastroBasesInternational }

constructor TCadastroBasesInternational.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadINTBase');
end;

procedure TCadastroBasesInternational.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesInternational.TCadastroBasesInternational.Create());
end;

{ TConsultaInternational }

constructor TConsultaInternational.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaInternational');
end;

procedure TConsultaInternational.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaInternational }

constructor TGeracaoTintaInternational.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadINTGeraArquivo');
end;

procedure TGeracaoTintaInternational.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('International', [
    TGravandoExecucaoInternationalColorantes.Create,
    TGravandoExecucaoInternationalBases.Create,
    TGravandoExecucaoInternationalCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadINTGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('International', [
    TGravandoExecucaoInternationalNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesInternational }

constructor TCadastroColorantesInternational.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadINTColorantes');
end;

procedure TCadastroColorantesInternational.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesInternational.TCadastroColorantesInternational.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasInternational.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadINTNovasFormulas');
end;

procedure TCadastroNovasFormulasInternational.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasInternational.TCadastroNovasFormulasInternational.Create);
end;

{ TCadastroEmbalagensInternational }

constructor TCadastroEmbalagensInternational.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadINTEmbalagens');
end;

procedure TCadastroEmbalagensInternational.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensInternational.TCadastroEmbalagensInternational.Create);
end;

end.
