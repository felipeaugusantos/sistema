unit untLibCartoesAutcomExports;

interface

Uses System.Classes, System.SysUtils, Vcl.Menus, Vcl.Forms,
     System.Generics.Collections,

     dxCore, cxEdit, cxRadioGroup, cxEditRepositoryItems, cxCurrencyEdit,
     Uni, UniClientDataset,

     untLibCartoesCfgRepositorio, untILibCartoesFactory, untILibCartoesWrapper,
     untTMenuLibCartoes, untLibCartoesTiposCompartilhados, untTLibCartoesFuncoes;

procedure dxInitialize; StdCall;
procedure dxFinalize; StdCall;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;

procedure AdicionarConfiguracoesCartoes; StdCall;
procedure AdicionarConfiguracoesAntecipacaoRedeCard; StdCall;

procedure CarregaPropriedadesConfiguracoesCartoes(ACodigoConfiguracao: String;
                                                  var AProperties: Pointer;
                                                  var AIndiceCfg: Integer;
                                                  ACfgRepositorio: Pointer); StdCall;

procedure CarregaPropriedadesConfiguracoesAntecipacaoRedeCard(ACodigoConfiguracao: String;
                                                              var AProperties: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              ACfgRepositorio: Pointer); StdCall;

function RetornaItensMenuImportacaoCartoes: TCustomMenuItemCartoes; StdCall;
function RetornaItensMenuConciliacaoCartoes: TCustomMenuItemCartoes; StdCall;
function RetornaItensMenuAntecipacaoCartoes: TCustomMenuItemCartoes; StdCall;
function RetornaItensMenuImportacaoRecebiveisMkt: TCustomMenuItemCartoes; StdCall;
function RetornaItensMenuBaixaRecebiveisMkt: TCustomMenuItemCartoes; StdCall;

function RetornaItensMenuExclusaoCartoes: TCustomMenuItemCartoes; StdCall;
function RetornaItensMenuExportacaoCartoes: TCustomMenuItemCartoes; StdCall;

function RetornaCfgRepositorioCartoes: TList<TLibCartoesCfgProperties>; StdCall;

procedure ValidaConfiguracoesCartoes(var ADatasetCfg: TUniCLientDataSet;
                                     AAdicionarConfigDuranteValidacao: Boolean;
                                     var AResultado: Boolean;
                                     AFiltroEmpresa: Boolean = True); StdCall;

function CarregarCadEstabelecimentosCartoes(ACodigoConfiguracao, AValorCfg: String): String; StdCall;
function CarregarCadEstabelecimentosCartoesEstilo(ACodigoConfiguracao, AValorCfg: String; ALayoutClassico: Boolean): String; StdCall;

procedure OnClickConfirmacaoCartoes; StdCall;

Var
  FdxInitialize: Boolean;

implementation
Uses untLibCartoesCadEstabelecimentos;

procedure InicializaObjetoLibCartoes(AObjetoLibCartoes: ILibCartoes); StdCall;
Begin
  If TLibCartoesFactory.Get = Nil Then
    TLibCartoesFactory.Registrar(AObjetoLibCartoes);

  untTLibCartoesFuncoes.VS_FuncoesExternas := TLibCartoesFactory.Get;
End;

procedure AdicionarConfiguracoesCartoes; StdCall;
Begin
  TLibCartoesCfgRepositorio.AdicionarConfiguracoesCartoes;
End;

procedure AdicionarConfiguracoesAntecipacaoRedeCard; StdCall;
Begin
  TLibCartoesCfgRepositorio.AdicionarConfiguracoesAntecipacaoRedeCard;
End;

procedure CarregaPropriedadesConfiguracoesCartoes(ACodigoConfiguracao: String;
                                                  var AProperties: Pointer;
                                                  var AIndiceCfg: Integer;
                                                  ACfgRepositorio: Pointer); StdCall;
Begin
  TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesCartoes(ACodigoConfiguracao,
                                                                    AProperties,
                                                                    AIndiceCfg,
                                                                    ACfgRepositorio);
End;

procedure CarregaPropriedadesConfiguracoesAntecipacaoRedeCard(ACodigoConfiguracao: String;
                                                              var AProperties: Pointer;
                                                              var AIndiceCfg: Integer;
                                                              ACfgRepositorio: Pointer); StdCall;
Begin
  TLibCartoesCfgRepositorio.CarregaPropriedadesConfiguracoesAntecipacaoRedeCard(ACodigoConfiguracao,
                                                                                AProperties,
                                                                                AIndiceCfg,
                                                                                ACfgRepositorio);
End;

function RetornaItensMenuImportacaoCartoes: TCustomMenuItemCartoes; StdCall;
  Var
    LMenu: TMenuLibCartoes;
Begin
  LMenu := TMenuLibCartoes.Create;
  Try
    Result := LMenu.RetornaMenusImportacao;
  Finally
    FreeAndNil(LMenu);
  End;
End;

function RetornaItensMenuConciliacaoCartoes: TCustomMenuItemCartoes; StdCall;
  Var
    LMenu: TMenuLibCartoes;
Begin
  LMenu := TMenuLibCartoes.Create;
  Try
    Result := LMenu.RetornaMenusConciliacao;
  Finally
    FreeAndNil(LMenu);
  End;
End;

function RetornaItensMenuAntecipacaoCartoes: TCustomMenuItemCartoes; StdCall;
  Var
    LMenu: TMenuLibCartoes;
Begin
  LMenu := TMenuLibCartoes.Create;
  Try
    Result := LMenu.RetornaMenusAntecipacao;
  Finally
    FreeAndNil(LMenu);
  End;
End;

function RetornaItensMenuImportacaoRecebiveisMkt: TCustomMenuItemCartoes; StdCall;
  Var
    LMenu: TMenuLibCartoes;
Begin
  LMenu := TMenuLibCartoes.Create;
  Try
    Result := LMenu.RetornaMenusImportacaoRecebiveisMkt;
  Finally
    FreeAndNil(LMenu);
  End;
End;

function RetornaItensMenuBaixaRecebiveisMkt: TCustomMenuItemCartoes; StdCall;
  Var
    LMenu: TMenuLibCartoes;
Begin
  LMenu := TMenuLibCartoes.Create;
  Try
    Result := LMenu.RetornaMenusBaixaRecebiveisMkt;
  Finally
    FreeAndNil(LMenu);
  End;
End;

function RetornaItensMenuExclusaoCartoes: TCustomMenuItemCartoes; StdCall;
  Var
    LMenu: TMenuLibCartoes;
Begin
  LMenu := TMenuLibCartoes.Create;
  Try
    Result := LMenu.RetornaMenusExclusaoArquivosImportados;
  Finally
    FreeAndNil(LMenu);
  End;
End;

function RetornaItensMenuExportacaoCartoes: TCustomMenuItemCartoes; StdCall;
  Var
    LMenu: TMenuLibCartoes;
Begin
  LMenu := TMenuLibCartoes.Create;
  Try
    Result := LMenu.RetornaMenusExportacaoArquivos;
  Finally
    FreeAndNil(LMenu);
  End;
End;

procedure dxInitialize; StdCall;
Begin
  If FdxInitialize Then
    Exit;

  dxCore.dxInitialize;
  FdxInitialize := True;
End;

procedure dxFinalize; StdCall;
Begin
  If Not FdxInitialize Then
    Exit;

  Try
    dxCore.dxFinalize;
    FdxInitialize := False;
  Except

  End;
End;

function RetornaCfgRepositorioCartoes: TList<TLibCartoesCfgProperties>; StdCall;
Begin
  Result := TLibCartoesCfgRepositorio.RetornaPropertiesLibCartoesCriacaoAutcom;
End;

procedure ValidaConfiguracoesCartoes(var ADatasetCfg: TUniCLientDataSet;
  AAdicionarConfigDuranteValidacao: Boolean; var AResultado: Boolean;
  AFiltroEmpresa: Boolean = True); StdCall;
Begin
  AResultado := TLibCartoesCfgRepositorio.ValidaConfiguracoesCartoes(ADatasetCfg,
                                                                     AAdicionarConfigDuranteValidacao,
                                                                     AFiltroEmpresa);
End;

function CarregarCadEstabelecimentosCartoes(ACodigoConfiguracao, AValorCfg: String): String; StdCall;
  Var
    LCadEstabelecimentos: TfrmCfgCadEstabelecimentosOperadorasCartoes;
Begin
  TLibCartoesFuncoes.pCriarFormularios(TfrmCfgCadEstabelecimentosOperadorasCartoes, LCadEstabelecimentos);

  Try
    LCadEstabelecimentos.Configuracao := ACodigoConfiguracao;
    LCadEstabelecimentos.EstabelicimentosCfg := AValorCfg;
    LCadEstabelecimentos.ShowModal;

    Result := LCadEstabelecimentos.EstabelecimentosCadastrados;
  Finally
    FreeAndNil(LCadEstabelecimentos);
  End;
End;

function CarregarCadEstabelecimentosCartoesEstilo(ACodigoConfiguracao, AValorCfg: String; ALayoutClassico: Boolean): String; StdCall;
  Var
    LCadEstabelecimentos: TfrmCfgCadEstabelecimentosOperadorasCartoes;
Begin
  If Not ALayoutClassico Then
    TLibCartoesFuncoes.CarregaEstiloNovoCfgs;

  TLibCartoesFuncoes.pCriarFormularios(TfrmCfgCadEstabelecimentosOperadorasCartoes, LCadEstabelecimentos);

  Try
    LCadEstabelecimentos.Configuracao := ACodigoConfiguracao;
    LCadEstabelecimentos.EstabelicimentosCfg := AValorCfg;
    LCadEstabelecimentos.ShowModal;

    Result := LCadEstabelecimentos.EstabelecimentosCadastrados;
  Finally
    FreeAndNil(LCadEstabelecimentos);
  End;
End;

procedure OnClickConfirmacaoCartoes; StdCall;
Begin
  TMenuLibCartoes.OnClickConfirmacaoCartoes;
End;

Initialization
  FdxInitialize := False;

Finalization
  If FdxInitialize Then
    dxFinalize;
  untTLibCartoesFuncoes.VS_FuncoesExternas := Nil;

end.
