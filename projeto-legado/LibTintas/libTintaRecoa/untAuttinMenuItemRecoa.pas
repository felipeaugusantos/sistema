{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************AC*}
unit untAuttinMenuItemRecoa;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoRecoaCores,
  untGravandoExecucaoRecoaColorantes;

type
  TAuttinMenuItemRecoa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesRecoa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesRecoa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroColorantesRecoa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaRecoa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaRecoa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasRecoa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroEmbalagensRecoa = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

implementation

uses
  untConfiguradorRecoa, untLibTintaFactory, untGravandoExecucaoRecoaNovasFormulas, untCadastroBasesRecoa, 
  untCadastroColorantesRecoa, untGravandoExecucaoRecoaBases, 
  untCadastroNovasFormulasRecoa, untCadastroEmbalagensRecoa;

{ TAuttinMenuItemRecoa }

constructor TAuttinMenuItemRecoa.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesRecoa.Create());
  Self.Adicionar(TCadastroBasesRecoa.Create());
  Self.Adicionar(TCadastroColorantesRecoa.Create());
  Self.Adicionar(TCadastroEmbalagensRecoa.Create());
  Self.Adicionar(TCadastroNovasFormulasRecoa.Create());
  Self.Adicionar(TGeracaoTintaRecoa.Create());
  Self.Adicionar(TConsultaRecoa.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesRecoa }

constructor TConfiguracoesRecoa.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesRecoa');
end;

procedure TConfiguracoesRecoa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorRecoa.Create(auttinWrapper));
end;

{ TCadastroBasesRecoa }

constructor TCadastroBasesRecoa.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadRECBase');
end;

procedure TCadastroBasesRecoa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesRecoa.TCadastroBasesRecoa.Create());
end;

{ TConsultaRecoa }

constructor TConsultaRecoa.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaRecoa');
end;

procedure TConsultaRecoa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaRecoa }

constructor TGeracaoTintaRecoa.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadRECGeraArquivo');
end;

procedure TGeracaoTintaRecoa.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Recoa', [
    TGravandoExecucaoRecoaColorantes.Create,
    TGravandoExecucaoRecoaBases.Create,
    TGravandoExecucaoRecoaCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadRECGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Recoa Imobiliária', [
    TGravandoExecucaoRecoaNovasFormulas.Create
  ]);
end;

{ TCadastroColorantesRecoa }

constructor TCadastroColorantesRecoa.Create;
begin
  inherited Create('Cadastro de Colorantes', 'frmCadRECColorantes');
end;

procedure TCadastroColorantesRecoa.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroColorantesRecoa.TCadastroColorantesRecoa.Create());
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasRecoa.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadRECNovasFormulas');  
end;

procedure TCadastroNovasFormulasRecoa.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasRecoa.TCadastroNovasFormulasRecoa.Create);
end;

{ TCadastroEmbalagensRecoa }

constructor TCadastroEmbalagensRecoa.Create;
begin
  inherited Create('Cadastro de Embalagens', 'frmCadRECEmbalagens');
end;

procedure TCadastroEmbalagensRecoa.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroEmbalagensRecoa.TCadastroEmbalagensRecoa.Create);
end;

end.
