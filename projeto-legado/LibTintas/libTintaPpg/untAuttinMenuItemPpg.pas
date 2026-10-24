{******************************************************************************************}
{* Classes responsavels pelos menus que serão exibidos no auttin para o usuário poder ter *}
{* acesso as funcionalidades da tinta                                                     *}
{***************************************************************************************PH*}
unit untAuttinMenuItemPpg;

interface

uses
  untGenericAuttinMenuItem, Dialogs, untAutcomTintaFactory,
  untIAuttinWrapper, untGravandoExecucaoPpgCores;

type
  TAuttinMenuItemPpg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
  end;

  TConfiguracoesPpg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroBasesPpg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TConsultaPpg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoTintaPpg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TGeracaoNovasFormulas = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;

  TCadastroNovasFormulasPpg = class(TGenericAuttinMenuItem)
  public
    constructor Create(); reintroduce;
    procedure Executar(const auttinWrapper: IAuttinWrapper); override;
  end;


implementation

uses
  untConfiguradorPpg, untLibTintaFactory, untGravandoExecucaoPpgNovasFormulas, untCadastroBasesPpg,
  untGravandoExecucaoPpgBases,  untCadastroNovasFormulasPpg,
  untGravandoExecucaoPpgMontadora,untGravandoExecucaoPpgDiluente,
  untGravandoExecucaoPpgBasesDiluente;

{ TAuttinMenuItemPpg }

constructor TAuttinMenuItemPpg.Create();
begin
  inherited Create(TLibTintaFactory.GetLibTinta.GetNomeTinta, 'mnu' + TLibTintaFactory.GetLibTinta.GetNomeTinta);
  Self.Adicionar(TConfiguracoesPpg.Create());
  Self.Adicionar(TCadastroBasesPpg.Create());
  Self.Adicionar(TCadastroNovasFormulasPpg.Create());
  Self.Adicionar(TGeracaoTintaPpg.Create());
  Self.Adicionar(TConsultaPpg.Create());
  Self.Adicionar(TGeracaoNovasFormulas.Create());
end;

{ TConfiguracoesPpg }

constructor TConfiguracoesPpg.Create();
begin
  inherited Create('Configurações', 'frmConfiguracoesPpg');
end;

procedure TConfiguracoesPpg.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Configurar(TConfiguradorPpg.Create(auttinWrapper));
end;

{ TCadastroBasesPpg }

constructor TCadastroBasesPpg.Create();
begin
  inherited Create('Cadastro de Bases', 'frmCadPPGBase');
end;

procedure TCadastroBasesPpg.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroBasesPpg.TCadastroBasesPpg.Create());
end;

{ TConsultaPpg }

constructor TConsultaPpg.Create();
begin
  inherited Create('Consultar Arquivo', 'frmConsultaPpg');
end;

procedure TConsultaPpg.Executar(const auttinWrapper: IAuttinWrapper);
begin
  TAutcomTintaFactory.Get.fConsultaDinamicaGeral(nil, TLibTintaFactory.GetLibTinta.GetITintadeMaquina);
end;

{ TGeracaoTintaPpg }

constructor TGeracaoTintaPpg.Create();
begin
  inherited Create('Gerar Cadastro de Tintas', 'frmCadPPGGeraArquivo');
end;

procedure TGeracaoTintaPpg.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Ppg', [
    TGravandoExecucaoPpgBases.Create,
    TGravandoExecucaoPpgMontadora.Create,
    TGravandoExecucaoPpgDiluente.Create,
    TGravandoExecucaoPpgBasesDiluente.Create,
    TGravandoExecucaoPpgCores.Create
  ]);
end;

{ TGeracaoNovasFormulas }

constructor TGeracaoNovasFormulas.Create;
begin
  inherited Create('Gerar Cadastro de Novas Fórmulas', 'frmCadPPGGeraNfm')
end;

procedure TGeracaoNovasFormulas.Executar(const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.ProcessarArquivos('Ppg', [
    TGravandoExecucaoPpgNovasFormulas.Create
  ]);
end;

{ TCadastroNovasFormulas }

constructor TCadastroNovasFormulasPpg.Create;
begin
  inherited Create('Cadastro de Novas Fórmulas', 'frmCadPPGNovasFormulas');
end;

procedure TCadastroNovasFormulasPpg.Executar(
  const auttinWrapper: IAuttinWrapper);
begin
  auttinWrapper.Cadastrar(untCadastroNovasFormulasPpg.TCadastroNovasFormulasPpg.Create);
end;

end.
