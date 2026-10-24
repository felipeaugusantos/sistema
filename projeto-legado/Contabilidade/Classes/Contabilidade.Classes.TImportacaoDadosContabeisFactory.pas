unit Contabilidade.Classes.TImportacaoDadosContabeisFactory;

interface

uses Contabilidade.Classes.TImportacaoDadosContabeis, cxProgressBar, untExcel, Uni, UniClientDataset,
     Contabilidade.Classes.CfgContabil;

type
  TImportacaoDadosContabeisFactory = Class(TInterfacedObject, IImportacaoDadosContabeisFactory)
  private
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IImportacaoDadosContabeisFactory;

    function fImportacao(idcTipImp: TImportacaoDadosContabeis; pgbProgresso: TcxProgressBar;
      AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao:boolean;
      const strRegistro: string = ''; const strBloco: string = ''; const strTipLan: string = '';
      cdsPlanco: TUniClientDataset = nil; AFontesComplementares: TDictFontesComplementares = nil;
      ACfgContabil: ICfgContabil = nil; AblnControlaTransacaoLocal: Boolean = True;
      AMapaCodigosHispad: TDictMapaCodigosHispad = nil
    ): IImportacaoDadosContabeis; overload;

    function fImportacao(idcTipImp: TImportacaoDadosContabeis; pgbProgresso: TcxProgressBar;
      excExcel: TExcel; blnIgnorarErrosImportacao:boolean;
      const strRegistro, strBloco, strTipLan: string; cdsPlanco: TUniClientDataset
    ): IImportacaoDadosContabeis; overload;

  End;

implementation

uses System.SysUtils,
     Contabilidade.Classes.TImportacaoDadosContabeisHispad,
     Contabilidade.Classes.TImportacaoDadosContabeisPlanco,
     Contabilidade.Classes.TImportacaoDadosContabeisPlanre,
     Contabilidade.Classes.TImportacaoDadosContabeisEcfDem,
     Contabilidade.Classes.TImportacaoDadosContabeisLancon,
     Contabilidade.Classes.TImportacaoDadosContabeisPlaini,
     Contabilidade.Classes.TImportacaoDadosContabeisDprini,
     Contabilidade.Classes.TImportacaoDadosContabeisTspCoa,
     Contabilidade.Classes.TImportacaoDadosContabeisParCon,
     Contabilidade.Classes.TImportacaoDadosContabeisCfgSis,
     Contabilidade.Classes.TImportacaoDadosContabeisFonteExcel;

{ TImportacaoDadosContabeisFactory }

constructor TImportacaoDadosContabeisFactory.Create;
begin
end;

destructor TImportacaoDadosContabeisFactory.Destroy;
begin
  inherited;
end;

function TImportacaoDadosContabeisFactory.fImportacao(
  idcTipImp: TImportacaoDadosContabeis; pgbProgresso: TcxProgressBar;
  AFonte: IImportacaoDadosContabeisFonte; blnIgnorarErrosImportacao: boolean;
  const strRegistro, strBloco, strTipLan: string;
  cdsPlanco: TUniClientDataset;
  AFontesComplementares: TDictFontesComplementares;
  ACfgContabil: ICfgContabil;
  AblnControlaTransacaoLocal: Boolean;
  AMapaCodigosHispad: TDictMapaCodigosHispad): IImportacaoDadosContabeis;
var
  LCfgContabil: ICfgContabil;
  LImportacaoBase: TImportacaoDadosContabeisBase;
begin
  if Assigned(ACfgContabil) then
    LCfgContabil := ACfgContabil
  else
    LCfgContabil := TCfgContabilDefault.New;

  Result := nil;
  LImportacaoBase := nil;

  if (idcTipImp = tidcHistoricoPadrao) then
    LImportacaoBase := TImportacaoDadosContabeisHispad.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, LCfgContabil)
  else if (idcTipImp = tidcPlanoContas) then
    LImportacaoBase := TImportacaoDadosContabeisPlanco.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, LCfgContabil)
  else if (idcTipImp = tidcPlanoReferencial) then
    LImportacaoBase := TImportacaoDadosContabeisPlanre.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, strRegistro, strBloco, LCfgContabil)
  else if (idcTipImp = tidcDemonstrativoECF) then
    LImportacaoBase := TImportacaoDadosContabeisEcfDem.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, strRegistro, strBloco, LCfgContabil)
  else if (idcTipImp = tidcLancamentosContabeis) then
    LImportacaoBase := TImportacaoDadosContabeisLancon.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, strTipLan, LCfgContabil)
  else if (idcTipImp = tidcSaldosIniciais) then
    LImportacaoBase := TImportacaoDadosContabeisPlaIni.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, LCfgContabil)
  else if (idcTipImp = tidcTransfSaldosPlanco) then
    LImportacaoBase := TImportacaoDadosContabeisTspCoa.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, LCfgContabil)
  else if (idcTipImp = tidcSaldosIniciaisSubconta) then
    LImportacaoBase := TImportacaoDadosContabeisDprIni.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, cdsPlanco, LCfgContabil)
  else if (idcTipImp = tidcParametrosContabilizacao) then
    LImportacaoBase := TImportacaoDadosContabeisParCon.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, AFontesComplementares, AMapaCodigosHispad, LCfgContabil)
  else if (idcTipImp = tidcConfiguracoes) then
    LImportacaoBase := TImportacaoDadosContabeisCfgSis.Create(pgbProgresso, AFonte, blnIgnorarErrosImportacao, LCfgContabil);

  if Assigned(LImportacaoBase) then
  begin
    LImportacaoBase.pSetControlaTransacaoLocal(AblnControlaTransacaoLocal);
    Result := LImportacaoBase;
  end;
end;

function TImportacaoDadosContabeisFactory.fImportacao(idcTipImp: TImportacaoDadosContabeis;
  pgbProgresso: TcxProgressBar; excExcel: TExcel;
  blnIgnorarErrosImportacao:boolean; const strRegistro, strBloco, strTipLan: string;
  cdsPlanco: TUniClientDataset): IImportacaoDadosContabeis;
begin
  Result := Self.fImportacao(
    idcTipImp,
    pgbProgresso,
    TImportacaoDadosContabeisFonteExcel.New(excExcel),
    blnIgnorarErrosImportacao,
    strRegistro,
    strBloco,
    strTipLan,
    cdsPlanco,
    nil,
    nil,
    True
  );
end;

class function TImportacaoDadosContabeisFactory.New: IImportacaoDadosContabeisFactory;
begin
  Result := Self.Create;
end;


end.
