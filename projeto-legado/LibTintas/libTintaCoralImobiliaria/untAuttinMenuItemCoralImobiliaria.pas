{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemCoralImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoCoralImobiliariaCores,
  untGravandoExecucaoCoralImobiliariaColorantes;

type
  TAuttinMenuItemCoralImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesCoralImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesCoralImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesCoralImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaCoralImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaCoralImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasCoralImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensCoralImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorCoralImobiliaria, untLibTintaFactory, untGravandoExecucaoCoralImobiliariaNovasFormulas, untCadastroBasesCoralImobiliaria, 
  untCadastroColorantesCoralImobiliaria, untGravandoExecucaoCoralImobiliariaBases, 
  untCadastroNovasFormulasCoralImobiliaria, untCadastroEmbalagensCoralImobiliaria,
  untGravandoExecucaoCoralImobiliariaEmbalagens;

{ TAuttinMenuItemCoralImobiliaria }

constructor TAuttinMenuItemCoralImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesCoralImobiliaria.Create());
  Self.Adicionar(TCadastroBasesCoralImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesCoralImobiliaria.Create());
  Self.Adicionar(TCadastroEmbalagensCoralImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasCoralImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaCoralImobiliaria.Create());
  Self.Adicionar(TConsultaCoralImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesCoralImobiliaria }

constructor TConfiguracoesCoralImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesCoralImobiliaria');
end;

procedure TConfiguracoesCoralImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorCoralImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesCoralImobiliaria }

constructor TCadastroBasesCoralImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadCIMBase');
end;

procedure TCadastroBasesCoralImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesCoralImobiliaria.TCadastroBasesCoralImobiliaria.Create());
end;

{ TConsultaCoralImobiliaria }

constructor TConsultaCoralImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaCoralImobiliaria');
end;

procedure TConsultaCoralImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaCoralImobiliaria }

constructor TGeracaoTintaCoralImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadCIMGeraArquivo');
end;

procedure TGeracaoTintaCoralImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Coral Imobiliária', [
    TGravandoExecucaoCoralImobiliariaColorantes.Create,
    TGravandoExecucaoCoralImobiliariaEmbalagens.Create,
    TGravandoExecucaoCoralImobiliariaBases.Create,
    TGravandoExecucaoCoralImobiliariaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadCIMGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Coral Imobiliária', [
    TGravandoExecucaoCoralImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesCoralImobiliaria }

constructor TCadastroColorantesCoralImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadCIMColorantes');
end;

procedure TCadastroColorantesCoralImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesCoralImobiliaria.TCadastroColorantesCoralImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasCoralImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadCIMNovasFormulas');  
end;

procedure TCadastroNovasFormulasCoralImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasCoralImobiliaria.TCadastroNovasFormulasCoralImobiliaria.Create);
end;

{ TCadastroEmbalagensCoralImobiliaria }

constructor TCadastroEmbalagensCoralImobiliaria.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadCIMEmbalagens');
end;

procedure TCadastroEmbalagensCoralImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensCoralImobiliaria.TCadastroEmbalagensCoralImobiliaria.Create);
end;

end.
