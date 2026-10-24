{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemAlessiImobiliaria;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoAlessiImobiliariaCores,
  untGravandoExecucaoAlessiImobiliariaColorantes;

type
  TAuttinMenuItemAlessiImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesAlessiImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesAlessiImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesAlessiImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensAlessiImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaAlessiImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaAlessiImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasAlessiImobiliaria = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorAlessiImobiliaria, untLibTintaFactory, untGravandoExecucaoAlessiImobiliariaNovasFormulas, untCadastroBasesAlessiImobiliaria, 
  untCadastroColorantesAlessiImobiliaria, untGravandoExecucaoAlessiImobiliariaBases, 
  untCadastroNovasFormulasAlessiImobiliaria, untCadastroEmbalagensAlessiImobiliaria,
  untGravandoExecucaoAlessiImobiliariaEmbalagens;

{ TAuttinMenuItemAlessiImobiliaria }

constructor TAuttinMenuItemAlessiImobiliaria.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesAlessiImobiliaria.Create());
  Self.Adicionar(TCadastroBasesAlessiImobiliaria.Create());
  Self.Adicionar(TCadastroColorantesAlessiImobiliaria.Create());
  Self.Adicionar(TCadastroEmbalagensAlessiImobiliaria.Create());
  Self.Adicionar(TCadastroNovasFormulasAlessiImobiliaria.Create());
  Self.Adicionar(TGeracaoTintaAlessiImobiliaria.Create());
  Self.Adicionar(TConsultaAlessiImobiliaria.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesAlessiImobiliaria }

constructor TConfiguracoesAlessiImobiliaria.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesAlessiImobiliaria');
end;

procedure TConfiguracoesAlessiImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorAlessiImobiliaria.Create(auttinWrapper));
end;

{ TCadastroBasesAlessiImobiliaria }

constructor TCadastroBasesAlessiImobiliaria.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadAleBase');
end;

procedure TCadastroBasesAlessiImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesAlessiImobiliaria.TCadastroBasesAlessiImobiliaria.Create());
end;

{ TConsultaAlessiImobiliaria }

constructor TConsultaAlessiImobiliaria.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaAlessiImobiliaria');
end;

procedure TConsultaAlessiImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaAlessiImobiliaria }

constructor TGeracaoTintaAlessiImobiliaria.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadAleGeraArquivo');
end;

procedure TGeracaoTintaAlessiImobiliaria.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Alessi Imobiliaria', [
    TGravandoExecucaoAlessiImobiliariaColorantes.Create,
    TGravandoExecucaoAlessiImobiliariaBases.Create,
    TGravandoExecucaoAlessiImobiliariaEmbalagens.Create,
    TGravandoExecucaoAlessiImobiliariaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadAleGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Alessi Imobiliaria', [
    TGravandoExecucaoAlessiImobiliariaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesAlessiImobiliaria }

constructor TCadastroColorantesAlessiImobiliaria.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadAleColorantes');
end;

procedure TCadastroColorantesAlessiImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesAlessiImobiliaria.TCadastroColorantesAlessiImobiliaria.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasAlessiImobiliaria.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadAleNovasFormulas');
end;

procedure TCadastroNovasFormulasAlessiImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasAlessiImobiliaria.TCadastroNovasFormulasAlessiImobiliaria.Create);
end;

{ TCadastroEmbalagensAlessiImobiliaria }

constructor TCadastroEmbalagensAlessiImobiliaria.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadAleEmbalagens');
end;

procedure TCadastroEmbalagensAlessiImobiliaria.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensAlessiImobiliaria.TCadastroEmbalagensAlessiImobiliaria.Create);
end;

end.
