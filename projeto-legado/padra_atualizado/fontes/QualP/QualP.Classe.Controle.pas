unit QualP.Classe.Controle;

interface

uses
  QualP.Classe.Requisicao, QualP.Classe.Resposta, QualP.Classe.Servico, Uni,
  UniClientDataSet, untFuncFat, Data.DB, untConstantes, System.Classes,
  Vcl.Controls, Vcl.Forms, System.Generics.Collections;

type
  TValoresCidade = class
    Pedagio     : Double;
    Combustivel : Double;
  end;

  TControleQualP = class
  private
    class
      var FTabela     : TStrings;
    class
      var FTipoCarga  : TDictionary<String,String>;

  private
    FFrmConsultaQualP      : TForm;
    FControl               : TWinControl;
    FCdsQualP              : TUniClientDataSet;
    FQueryVeiculo          : TUniQuery;
    FQueryCombustivel      : TUniQuery;
    FQueryEmpresa          : TUniQuery;
    FFatVenda              : TFatVenda;
    FCodRot                : String;
    FCepPartida            : String;
    FRequisicao            : TRequisicaoQualP;
    FResposta              : TRespostaQualP;
    FServico               : TServicoQualP;
    FCustoPedagio          : Double;

    FPlacaVeiculo          : String;

    FValorAcrescimoVeiculo : Double;
    FValorTabelaFrete      : Double;
    FBaseFrete             : Double;

    FValorTotalFrete       : Double;

    FOcorreuErro           : Boolean;
    FPeso                  : Double;
    FOptimizedRoute        : Boolean;
    FCustosPorCidade       : TDictionary<String,TValoresCidade>;

    procedure pCarregarPlacaVeiculoRota;

    procedure pAdicionarCamposDataSet;

    procedure pCarregarInformacoesEmpresa;
    procedure pCarregarInformacoesCombustiveis;
    procedure pCarregarInformacoesVeiculo;
    procedure pCarregarInformacoesCustoPedagios;
    procedure pCarregarInformacoesCustoCombustiveis;

    function fGetTipoVeiculo: String;
    function fGetQuantidadeEixos: String;
    function fGetPrecoCombustivel: String;
    function fGetAutonomiaKmL: String;

    procedure pClearRequisicao;

    procedure pAdicionaValoresPorEixo(const ATabela: String; AEixo: String);

    procedure SetValorTabelaFrete(const Value: Double);

    function GetCustoCombustivel: Double;
    function GetCustoPedagio: Double;
    function GetValorTotalFrete: Double;
    function GetQuantidadeEixos: Integer;

    function fTrocarVirgulaPorPonto(const Value: String): String;

  public
    blnUsaFatVendas : Boolean;
    strLocations    : TStrings;
    constructor Create;
    destructor Destroy; override;
    //Essas 4 procedures quando for usar em outras telas que não utilizam a
    //FatVendas devem ser chamadas na ordem que se encontram declaradas
    procedure pPrepararCalculo;  // 1o
    procedure pConsultarApiQualP;  //2o
    procedure pCarregarInformacoesDataSetQualP; //3o
    procedure pCalcular;   //4o

    procedure SetPlacaVeiculo(const Value: String);
    function fSetFatVenda(const Value: TFatVenda): TControleQualP;
    function fSetCodRot(const Value: String): TControleQualP;
    function fSetCepPartida(const Value: String): TControleQualP;
    function fSetPainelQualP(const AControl: TWinControl): TControleQualP;
    function fExecutar: TControleQualP;
    procedure pClear;
    procedure pAddLocations(strLocation : String);

    class function fListaTabelaFrete: TStrings;
    class function fListaTipoCarga: TDictionary<String,String>;
    class procedure pDestroiListas;

    property Requisicao            : TRequisicaoQualP                   read FRequisicao;
    property Resposta              : TRespostaQualP                     read FResposta;
    property PlacaVeiculo          : String                             read FPlacaVeiculo          write SetPlacaVeiculo;
    property QuantidadeEixos       : Integer                            read GetQuantidadeEixos;
    property ValorBaseFrete        : Double                                                         write SetValorTabelaFrete;
    property CustoPedagio          : Double                             read GetCustoPedagio;
    property CustoCombustivel      : Double                             read GetCustoCombustivel;
    property ValorAcrescimoVeiculo : Double                             read FValorAcrescimoVeiculo;
    property ValorTotalFrete       : Double                             read GetValorTotalFrete;
    property OcorreuErro           : Boolean                            read FOcorreuErro;
    property Peso                  : Double                             read FPeso                 write FPeso;
    property OptimizedRoute        : Boolean                            read FOptimizedRoute       write FOptimizedRoute;
    property CustosPorCidade       : TDictionary<String,TValoresCidade> read FCustosPorCidade;
  end;

implementation

uses
  untFuncoesSimples, System.SysUtils, System.Rtti, untGravando,
  QualP.Form.Consulta, untTypesSistema;

{ TControleQualP }

constructor TControleQualP.Create;
begin
  fControl               := nil;
  FRequisicao            := nil;
  FResposta              := nil;
  FServico               := nil;
  FFrmConsultaQualP      := nil;

  FCdsQualP              := TUniClientDataSet.Create(nil);
  FQueryVeiculo          := fCriaQuery(nil);
  FQueryCombustivel      := fCriaQuery(nil);
  FQueryEmpresa          := fCriaQuery(nil);
  FCustosPorCidade       := TDictionary<String,TValoresCidade>.Create;

  FValorTabelaFrete      := 0;
  FValorAcrescimoVeiculo := 0;
  FBaseFrete             := 0;
  FValorTotalFrete       := 0;
  FCepPartida            := EmptyStr;

  FOptimizedRoute        := False;

  blnUsaFatVendas        := True;
  pAdicionarCamposDataSet;
end;

destructor TControleQualP.Destroy;
begin
  if Assigned(FRequisicao) then
    FreeAndNil(FRequisicao);

  if Assigned(FResposta) then
    FreeAndNil(FResposta);

  if Assigned(FServico) then
    FreeAndNil(FServico);

  if Assigned(FCdsQualP) then
    FreeAndNil(FCdsQualP);

  if Assigned(FQueryVeiculo) then
    FreeAndNil(FQueryVeiculo);

  if Assigned(FQueryCombustivel) then
    FreeAndNil(FQueryCombustivel);

  if Assigned(FQueryEmpresa) then
    FreeAndNil(FQueryEmpresa);

  if Assigned(FFrmConsultaQualP) then
    pFreeAndNil(FFrmConsultaQualP);

  if Assigned(FCustosPorCidade) then
    FreeAndNil(FCustosPorCidade);

  pDestroiListas;

  inherited;
end;

procedure TControleQualP.pAddLocations(strLocation: String);
begin
  if Assigned(FRequisicao) then
    FRequisicao.Locations.Add(strLocation);
end;

procedure TControleQualP.pAdicionarCamposDataSet;
begin
  FCdsQualP.FieldDefs.Add('TIPO_CARGA', ftString, 30);
  FCdsQualP.FieldDefs.Add('TABELA', ftString, 30);
  FCdsQualP.FieldDefs.Add('VALOR', ftFloat, 0);

  FCdsQualP.CreateDataSet;

  TFloatField(FCdsQualP.FieldByName('VALOR')).DisplayFormat := ',0.00';
end;

procedure TControleQualP.pCalcular;
var
  LTipoAcrescimoFrete : String;
  LTotalVenda         : Double;
  LValorReducao       : Double;
  LLinha              : Integer;
begin
  if (not FCdsQualP.Active) or
     (not FQueryVeiculo.Active) or
     (not FQueryCombustivel.Active) or
     (not FQueryEmpresa.Active) or
     (FOcorreuErro) then
    Exit;

  LTipoAcrescimoFrete := Copy(FQueryVeiculo.FieldByName('VEI_TIPAFR').AsString,1,1).ToUpper;

  FBaseFrete := CustoCombustivel
              + CustoPedagio
              + FValorTabelaFrete;

  FBaseFrete := fFormataFloat(FBaseFrete, 2);

  FValorTotalFrete := FBaseFrete;
  LValorReducao := 0;

  If (blnUsaFatVendas) Then
  Begin
    LTotalVenda := 0;

    For LLinha := 0 To Pred(Length(FFatVenda.arrMatItens)) Do
    Begin
      If FFatVenda.arrMatItens[LLinha].strEntRet = 'R' Then
        Continue;

      LTotalVenda := LTotalVenda + FFatVenda.arrMatItens[LLinha].fltTotIte;
    End;

    LValorReducao := LTotalVenda
                   * (fCfgSis('QLPFT'+FFatVenda.strTabPre, varDouble)/100);
  End;

  if LTipoAcrescimoFrete = 'V' then
    FValorAcrescimoVeiculo := FQueryVeiculo.FieldByName('VEI_ACRFRE').AsFloat
  else
  if LTipoAcrescimoFrete = 'P' then
    FValorAcrescimoVeiculo := FBaseFrete
                            * (FQueryVeiculo.FieldByName('VEI_ACRFRE').AsFloat/100);

  FValorTotalFrete := FValorTotalFrete
                    + FValorAcrescimoVeiculo
                    - LValorReducao;

  FValorTotalFrete := fFormataFloat(FValorTotalFrete, 2);

  if FValorTotalFrete < 0 then
    FValorTotalFrete := 0;
end;

procedure TControleQualP.pCarregarInformacoesCombustiveis;
var
  LSql : String;
begin
  try
    LSql := 'SELECT * FROM CADCMB '
          + ' ORDER BY '
          + '       CMB_DTACOT DESC '
          + ' LIMIT 1 ';

    FQueryCombustivel.Close;
    FQueryCombustivel.SQL.Text := LSql;
    FQueryCombustivel.Open;

    if FQueryCombustivel.IsEmpty then
      raise ExceptionAutCom.Create('Não existe nenhuma cotação de combustíveis!');
  except
    raise;
  end;
end;

procedure TControleQualP.pCarregarInformacoesCustoCombustiveis;
var
  LCidade : String;
begin
  for LCidade in FCustosPorCidade.Keys do
  begin
    FCustosPorCidade.Items[LCidade].Pedagio     := fFormataFloat(FCustosPorCidade.Items[LCidade].Pedagio, 2);
    FCustosPorCidade.Items[LCidade].Combustivel := fFormataFloat(FCustosPorCidade.Items[LCidade].Pedagio/
                                                                 CustoPedagio * CustoCombustivel, 2);
  end;
end;

procedure TControleQualP.pCarregarInformacoesCustoPedagios;
var
  LPedagio : TPedagios;
  LValor   : Double;
begin
  FCustoPedagio := 0;
  FCustosPorCidade.Clear;

  if not Assigned(FResposta) then
    Exit;

  for LPedagio in FResposta.Pedagios do
  begin
    LValor := LPedagio.Tarifa._2
            + LPedagio.Tarifa._3
            + LPedagio.Tarifa._4
            + LPedagio.Tarifa._5
            + LPedagio.Tarifa._6
            + LPedagio.Tarifa._7
            + LPedagio.Tarifa._8
            + LPedagio.Tarifa._9
            + LPedagio.Tarifa._10
            + LPedagio.Tarifa._11
            + LPedagio.Tarifa._12
            + LPedagio.Tarifa._13
            + LPedagio.Tarifa._14
            + LPedagio.Tarifa._15;

    if FCustosPorCidade.ContainsKey(LPedagio.Municipio) then
      FCustosPorCidade.Items[LPedagio.Municipio].Pedagio := FCustosPorCidade.Items[LPedagio.Municipio].Pedagio
                                                          + LValor
    else
    begin
      FCustosPorCidade.Add(LPedagio.Municipio, TValoresCidade.Create);
      FCustosPorCidade.Items[LPedagio.Municipio].Pedagio := LValor;
    end;

    FCustoPedagio := FCustoPedagio
                   + LValor;
  end;

  FCustoPedagio := fFormataFloat(FCustoPedagio, 2);
end;

procedure TControleQualP.pCarregarInformacoesDataSetQualP;
begin
  if not Assigned(FResposta) then
    Exit;

  try
    FCdsQualP.EmptyDataSet;
    FCdsQualP.Filtered := False;

    pAdicionaValoresPorEixo('A', fGetQuantidadeEixos);
    pAdicionaValoresPorEixo('B', fGetQuantidadeEixos);
    pAdicionaValoresPorEixo('C', fGetQuantidadeEixos);
    pAdicionaValoresPorEixo('D', fGetQuantidadeEixos);

    FCdsQualP.First;
  except
    on E: Exception do
    begin
      raise ExceptionAutcom.Create(E.Message);
    end
  end;
end;

procedure TControleQualP.pCarregarInformacoesEmpresa;
var
  LSql : String;
begin
  try
    LSql := 'SELECT * FROM CADEMP '
          + ' WHERE EMP_CODEMP = :CODEMP ';

    FQueryEmpresa.Close;
    FQueryEmpresa.SQL.Text := LSql;
    FQueryEmpresa.ParamByName('CODEMP').AsString := VS_strCodEmp;
    FQueryEmpresa.Open;

    if FQueryEmpresa.IsEmpty then
      raise ExceptionAutCom.Create('Empresa não encontrada!');
  except
    raise;
  end;
end;

procedure TControleQualP.pCarregarInformacoesVeiculo;
var
  LSql : String;
begin
  try
    LSql := 'SELECT * FROM CADVEI '
          + ' WHERE VEI_PLAVEI = :PLAVEI ';

    FQueryVeiculo.Close;
    FQueryVeiculo.SQL.Text := LSql;
    FQueryVeiculo.ParamByName('PLAVEI').AsString := FPlacaVeiculo.Replace('-', EmptyStr);
    FQueryVeiculo.Open;

    if blnUsaFatVendas then
      Peso := FFatVenda.fltPesLiq;

    if FQueryVeiculo.IsEmpty then
      raise ExceptionAutCom.Create('Veículo não encontrado!')
    else
    begin
      if FQueryVeiculo.FieldByName('VEI_PINQLP').AsString <> 'S' then
        raise ExceptionAutCom.Create('Veículo não configurado para utilizar a API QUALP!')
      else
      if FQueryVeiculo.FieldByName('VEI_CAPCAR').AsInteger < Peso then
        raise ExceptionAutCom.Create('Veículo com capacidade menor que o peso líquido faturado!');
    end;
  except
    raise;
  end;
end;

procedure TControleQualP.pCarregarPlacaVeiculoRota;
var
  LQuery : TUniQuery;
  LSql   : String;
begin
  try
    LSql := 'SELECT '
          + '       R.REV_PLAVEI '
          + '  FROM ENTREG E '
          + ' INNER JOIN ROTREV R ON R.REV_CODIGO = E.ENT_ROTVEI '
          + ' WHERE E.ENT_CODIGO = :CODIGO '
          + ' LIMIT 1 ';

    LQuery := fCriaQuery(nil);
    LQuery.Close;
    LQuery.SQL.Text := LSql;
    LQuery.ParamByName('CODIGO').AsString := FCodRot;
    LQuery.Open;

    if not LQuery.IsEmpty then
    begin
      LQuery.First;
      FPlacaVeiculo := LQuery.FieldByName('REV_PLAVEI').AsString;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure TControleQualP.pClear;
begin
  pClearRequisicao;

  FPlacaVeiculo          := EmptyStr;
  FValorAcrescimoVeiculo := 0;
  FValorTabelaFrete      := 0;
  FBaseFrete             := 0;
  FValorTotalFrete       := 0;
  FOcorreuErro           := False;
  FCustoPedagio          := 0;

  FCustosPorCidade.Clear;
end;

procedure TControleQualP.pConsultarApiQualP;
var
  intConta : Integer;
  strCepPartida: String;
begin
  inherited;
  try
    pClearRequisicao;

    strCepPartida := IIF(Not fEmptyStr(FCepPartida), FCepPartida, FQueryEmpresa.FieldByName('EMP_C_E_P_').AsString);

    FRequisicao.Locations.Insert(0, strCepPartida.Replace('-', EmptyStr));

    if blnUsaFatVendas then
    begin
      FRequisicao.Locations.Add(FFatVenda.strCepEnt);
    end
    else
    begin
      for intConta := 0 to strLocations.Count - 1 do
      begin
        pAddLocations(strLocations[intConta]);
      end;
    end;

    FRequisicao.Config.Route.CalculateReturn     := True;
    FRequisicao.Config.Route.OptimizedRoute      := OptimizedRoute;
    FRequisicao.Config.Route
      .OptimizedRouteDestination                 := 'best';
    FRequisicao.Config.Route.AlternativeRoutes   := '0';

    FRequisicao.Config.Vehicle.&Type             := fGetTipoVeiculo;
    FRequisicao.Config.Vehicle.Axis              := fGetQuantidadeEixos;

    FRequisicao.Config.Tolls.RetroactiveDate     := '';

    FRequisicao.Config.FreightTable.Category     := 'all';
    FRequisicao.Config.FreightTable.FreightLoad  := 'all';
    FRequisicao.Config.FreightTable.Axis         := fGetQuantidadeEixos;

    FRequisicao.Config.FuelConsumption.FuelPrice := fGetPrecoCombustivel;
    FRequisicao.Config.FuelConsumption.KmFuel    := fGetAutonomiaKmL;

    FRequisicao.Config.PrivatePlaces
      .MaxDistanceFromLocationToRoute            := '1000';
    FRequisicao.Config.PrivatePlaces.Categories  := True;
    FRequisicao.Config.PrivatePlaces.Areas       := True;
    FRequisicao.Config.PrivatePlaces.Contacts    := True;
    FRequisicao.Config.PrivatePlaces.Products    := True;
    FRequisicao.Config.PrivatePlaces.Services    := True;

    FRequisicao.Show.Tolls                       := True;
    FRequisicao.Show.FreightTable                := False;
    FRequisicao.Show.Maneuvers                   := 'false';
    FRequisicao.Show.TruckScales                 := False;
    FRequisicao.Show.StaticImage                 := False;
    FRequisicao.Show.LinkToQualp                 := True;
    FRequisicao.Show.PrivatePlaces               := False;
    FRequisicao.Show.Polyline                    := False;
    FRequisicao.Show.SimplifiedPolyline          := False;
    FRequisicao.Show.Ufs                         := False;
    FRequisicao.Show.FuelConsumption             := True;
    FRequisicao.Show.LinkToQualpReport           := False;

    FRequisicao.Format                           := 'json';
    FRequisicao.ExceptionKey                     := '';

    FResposta := FServico.fInformacoesQualp(FRequisicao);

    pCarregarInformacoesCustoPedagios;
    pCarregarInformacoesCustoCombustiveis;
  except
    raise;
  end;
end;

class procedure TControleQualP.pDestroiListas;
begin
  if Assigned(FTipoCarga) then
    FreeAndNil(FTipoCarga);

  if Assigned(FTabela) then
    FreeAndNil(FTabela);
end;

procedure TControleQualP.pPrepararCalculo;
begin
  try
    pCarregarInformacoesEmpresa;
    pCarregarInformacoesCombustiveis;
    pCarregarInformacoesVeiculo;

    if (FQueryVeiculo.FieldByName('VEI_PINQLP').AsString <> 'S') then
      raise ExceptionAutCom.Create('Veículo não habilitado para utilizar a integração com a QUALP!');


    TfrmGravando.fExecutarModal(pConsultarApiQualP, 'Aguarde, consultando informações na QUALP...','');

    pCarregarInformacoesDataSetQualP;
  except
    on E: ExceptionAutCom do
    begin
      FOcorreuErro := True;
      pMensagemOk(E.Message);
    end;

    on E: Exception do
    begin
      FOcorreuErro := True;
      pMensagensErro(E.Message,'[TControleQualP.pPrepararCalculo]');
    end;
  end;
end;

procedure TControleQualP.SetPlacaVeiculo(const Value: String);
begin
  FPlacaVeiculo := Value;
end;

procedure TControleQualP.SetValorTabelaFrete(const Value: Double);
begin
  FValorTabelaFrete := Value;
end;

procedure TControleQualP.pClearRequisicao;
begin
  try
    if Assigned(FRequisicao) then
      FreeAndNil(FRequisicao);

    if Assigned(FResposta) then
      FreeAndNil(FResposta);

    if Assigned(FServico) then
      FreeAndNil(FServico);

    FRequisicao          := TRequisicaoQualP.Create;
    FServico             := TServicoQualP.Create;
  except
    raise;
  end;
end;

function TControleQualP.fExecutar: TControleQualP;
begin
  Result           := Self;
  FValorTotalFrete := 0;
  FOcorreuErro     := False;

  try
    if (not fCfgSis('QLPUSA', varBoolean)) then
      raise ExceptionAutCom.Create('É necessário habilitar a configuração [CFG_QLPUSA]!');

    if (not Assigned(FFatVenda)) then
      raise ExceptionAutCom.Create('É necessário o envio das informações da venda!');

    if (Assigned(FFatVenda)) and
       (not fEmptyStr(FCodRot)) and
       (fCfgSis('REGCID' ,varBoolean)) then
      pCarregarPlacaVeiculoRota;

    if not Assigned(FFrmConsultaQualP) then
      pCriarFormularios(TfrmConsultaQualP, FFrmConsultaQualP);

    TFrmConsultaQualP(FFrmConsultaQualP)
      .fSetControleQualP(Self)
      .fSetFatVenda(FFatVenda)
      .fAbrirConsultaQualP(FCdsQualP, pPrepararCalculo, pCalcular, FControl);

    if not Assigned(FControl) then
    begin
      if (not TFrmConsultaQualP(FFrmConsultaQualP).blnItemSelecionado) then
        FValorTotalFrete := 0;
    end;
  except
    on E: ExceptionAutCom do
    begin
      FOcorreuErro := True;
      pMensagemOk(E.Message);
    end;

    on E: Exception do
    begin
      FOcorreuErro := True;
      pMensagensErro(E.Message,'[TControleQualP.fExecutar]');
    end;
  end;
end;

procedure TControleQualP.pAdicionaValoresPorEixo(const ATabela: String;
  AEixo: String);
var
  LTabela       : TTipoTabelaFrete;
  LEixo         : TItemTabelaFrete;
  LRttiContext  : TRttiContext;
  LRttiProperty : TRttiProperty;
begin
  try
    if StrToInt(AEixo) < 2 then
      AEixo := '2'
    else
    if StrToInt(AEixo) > 9 then
      AEixo := '9'
  except
    AEixo := '2';
  end;

  try
    try
      LRttiContext := TRttiContext.Create;
      LTabela      := LRttiContext.GetType(FResposta.TabelaFrete.Dados.ClassInfo)
                        .GetProperty(ATabela)
                          .GetValue(FResposta.TabelaFrete.Dados).AsObject as TTipoTabelaFrete;
      LEixo        := LRttiContext.GetType(LTabela.ClassInfo)
                        .GetProperty('_'+AEixo)
                          .GetValue(LTabela).AsObject as TItemTabelaFrete;

      for LRttiProperty in LRttiContext.GetType(LEixo.ClassInfo).GetProperties do
      begin
        FCdsQualP.Append;
        FCdsQualP.FieldByName('TIPO_CARGA').AsString := fListaTipoCarga.Items[LRttiProperty.Name.ToLower];
        FCdsQualP.FieldByName('TABELA').AsString     := ATabela;
        FCdsQualP.FieldByName('VALOR').AsFloat       := StrToFloat(LRttiProperty.GetValue(LEixo).ToString);
        FCdsQualP.Post;
      end;
    finally
      LRttiContext.Free;
    end;
  except
    on E: Exception do
      raise ExceptionAutCom.Create('Ocorreu um problema ao adicionar os valores por eixo.'
                                   +#13#10+E.Message);
  end;
end;


function TControleQualP.fGetAutonomiaKmL: String;
begin
  Result := FloatToStr(FQueryVeiculo.FieldByName('VEI_AUTKML').AsFloat);
  Result := fTrocarVirgulaPorPonto(Result);
end;

function TControleQualP.fGetQuantidadeEixos: String;
begin
  Result := FloatToStr(FQueryVeiculo.FieldByName('VEI_QTDEIX').AsFloat);
end;

function TControleQualP.fGetTipoVeiculo: String;
var
  LTipoVeiculo : String;
begin
  Result := '';

  LTipoVeiculo := Copy(FQueryVeiculo.FieldByName('VEI_TIPVEI').AsString,1,1);

  if LTipoVeiculo = '1' then
    Result := 'truck'
  else
  if LTipoVeiculo = '2' then
    Result := 'bus'
  else
  if LTipoVeiculo = '3' then
    Result := 'car'
  else
  if LTipoVeiculo = '4' then
    Result := 'motorcycle';
end;

class function TControleQualP.fListaTabelaFrete: TStrings;
begin
  if not Assigned(FTabela) then
  begin
    FTabela := TStringList.Create;
    FTabela.Add('A - Lotação');
    FTabela.Add('B - Agregados');
    FTabela.Add('C - Lotação de Alto Desempenho');
    FTabela.Add('D - Agregados de Alto Desempenho');
  end;

  Result := FTabela;
end;

class function TControleQualP.fListaTipoCarga: TDictionary<String,String>;
begin
  if not Assigned(FTipoCarga) then
  begin
    FTipoCarga := TDictionary<String, String>.Create;
    FTipoCarga.Add('granelsolido','GRANEL SÓLIDO');
    FTipoCarga.Add('granelliquido','GRANEL LÍQUIDO');
    FTipoCarga.Add('frigorificada','FRIGURIFICADA');
    FTipoCarga.Add('conteineirizada','CONTEINEIRIZADA');
    FTipoCarga.Add('geral','GERAL');
    FTipoCarga.Add('neogranel','NEOGRANEL');
    FTipoCarga.Add('perigosagranelsolido','PERIGOSA GRANEL SÓLIDO');
    FTipoCarga.Add('perigosagranelliquido','PERIGOSA GRANEL LÍQUIDO');
    FTipoCarga.Add('perigosafrigorificada','PERIGOSA FRIGURIFICADA');
    FTipoCarga.Add('perigosaconteineirizada','PERIGOSA CONTEINEIRIZADA');
    FTipoCarga.Add('perigosageral','PERIGOSA GERAL');
    FTipoCarga.Add('granelpressurizada','PERIGOSA PRESSURIZADA');
  end;

  Result := FTipoCarga;
end;

function TControleQualP.fGetPrecoCombustivel: String;
var
  LTipoCombustivelVeiculo : String;
begin
  Result := '0';

  LTipoCombustivelVeiculo := Copy(FQueryVeiculo.FieldByName('VEI_TIPCMB').AsString,1,1);

  if LTipoCombustivelVeiculo = '1' then
    Result := FloatToStr(FQueryCombustivel.FieldByName('CMB_VLRGAS').AsFloat)
  else
  if LTipoCombustivelVeiculo = '2' then
    Result := FloatToStr(FQueryCombustivel.FieldByName('CMB_VLRETA').AsFloat)
  else
  if LTipoCombustivelVeiculo = '3' then
    Result := FloatToStr(FQueryCombustivel.FieldByName('CMB_VLRDIE').AsFloat)
  else
  if LTipoCombustivelVeiculo = '4' then
    Result := FloatToStr(FQueryCombustivel.FieldByName('CMB_VLRS10').AsFloat);

  Result := fTrocarVirgulaPorPonto(Result);
end;

function TControleQualP.fSetCepPartida(const Value: String): TControleQualP;
begin
  Result  := Self;
  FCepPartida := Value;
end;

function TControleQualP.fSetCodRot(const Value: String): TControleQualP;
begin
  Result  := Self;
  FCodRot := Value;
end;

function TControleQualP.fSetFatVenda(const Value: TFatVenda): TControleQualP;
begin
  Result    := Self;
  FFatVenda := Value;
end;

function TControleQualP.fSetPainelQualP(
  const AControl: TWinControl): TControleQualP;
begin
  Result := Self;

  FControl := AControl;
end;

function TControleQualP.fTrocarVirgulaPorPonto(const Value: String): String;
begin
  Result := StringReplace(Value,'.',EmptyStr,[rfReplaceAll]);
  Result := StringReplace(Result,',','.',[rfReplaceAll]);
end;

function TControleQualP.GetCustoCombustivel: Double;
begin
  Result := 0;
  if not Assigned(FResposta) then
    Exit;

  Result := fFormataFloat(FResposta.ConsumoCombustivel,3);
end;

function TControleQualP.GetCustoPedagio: Double;
begin
  Result := FCustoPedagio;
end;

function TControleQualP.GetQuantidadeEixos: Integer;
begin
  Result := StrToIntDef(fGetQuantidadeEixos,0);
end;

function TControleQualP.GetValorTotalFrete: Double;
begin
  Result := fFormataFloat(FValorTotalFrete,2);
end;

end.
