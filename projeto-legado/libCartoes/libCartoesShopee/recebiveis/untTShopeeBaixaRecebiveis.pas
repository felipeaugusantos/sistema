unit untTShopeeBaixaRecebiveis;

interface

Uses System.Classes, System.SysUtils, System.Variants, System.StrUtils, Data.DB,
     Vcl.Forms,

     Uni, UniClientDataset, cxProgressBar,

     untTShopeeFuncoes, untShopeeTipos, untTShopeeBaixaCartoes,
     untLibCartoesInterfacesTipos, untTBanMca;


Type
  TShopeeBaixaRecebiveis = class
  private
     FDatasetBaixa,
     FCloneDataset: TUNiClientDataset;

     FNumeroDocumento,
     FHistorico: String;

     FDataDocumentoSintetico: TDateTime;

     FCtpCon: Integer;

     FUtilizaBaixaAnalitica,
     FBaixarTaxasAnaliticoMkt: Boolean;

     arrBaiSinCar: Array Of TArrBaiSinCar;
     arrBaiSinDeb: Array Of TArrBaiSinCar;

     FRegistroCTPDETFrete,
     FRegistroCTPDETAjuste: TArrBaiSinCar;
     FCTPDETSintetico: Array Of TArrBaiSinCar;

     FObjetoConciliacao: TCamposConcil;

     FRegistrosConciliar: TStringList;

     FDataFinalConciliacao: TDateTime;

     function ValidacoesParaBaixa: Boolean;
     function FaltaPortadoresEPlanosDeContasParaBaixa: Boolean;
     function PossuiPortadorSemPermissao(var APortadoresSemPermissao: String): Boolean;
     function TodosOsCentroDeCustosPreenchidos: Boolean;

     function CarregaInformacaoDeBaixa: Boolean;

     function RealizaBaixaVendasSintetica(pgbStatus: TcxProgressBar): Boolean;
     procedure pCarregaArrBaiSinCar;
     procedure pCarregaArrAjustes;
     function fAdicionaCartoesPorEmpresa(strCodEmp: String; strIdenti: String;
                                         var AListaBanMca: TListaBanMCA; dtaDtaRec: TDateTime;
                                         strPorCar: String = ''; strCtaCar: String = ''; strPorBad: String = '';
                                         strCtaBad: String = ''; strPorTax: String = ''; strCtaTax: String = '';
                                         strForTax: String = ''; AstrEventoCredito : String = ''; AstrEventoTaxa : String = '';
                                         strEveDeb: String = ''; strCtaAnt: String = ''; intAutoIncremInicial: Int64 = 0): Integer;
     procedure AdicionarRegistroCTPDetNoArraySintetico(ARegistroCTPDetFrete,
                                                      ARegistroCTPDetAjuste: TArrBaiSinCar;
                                                      APlanoDeContas: String;
                                                      ARegistros: TUniClientDataset);

    function RealizaBaixaVendasAnalitica(pgbStatus: TcxProgressBar): Boolean;

    function ApenasRegistrosDeTransferencias: Boolean;

    procedure pAtualizaDataMovimentobancarioMovCar(AAutoIncrem: String; ADataAlterada: TDateTime);

    procedure MarcaRegistrosConciliadoPelaLista(var ARegistrosConciliar: TStringList;
                                                ACamposConcil: TCamposConcil);

    function RetornaSequenciaisParaBaixaAnalitica(ADataset: TDataset;
                                                  ABaixaManual,
                                                  ABaixaRegistroDebito,
                                                  ATaxasDesmembradas: Boolean;
                                                  AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;

    function RetornaSequenciaisParaBaixaSintetica(ARegistros: Array Of TArrBaiSinCar;
                                                  ADataset: TDataset;
                                                  ABaixaManual,
                                                  ABaixaRegistroDebito,
                                                  ATaxasDesmembradas: Boolean;
                                                  AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;
  public
     constructor Create(ADatasetBaixa: TUniCLientDataset); overload;
     Destructor Destroy; override;

     function ConfirmarBaixa(prgStatus: TcxProgressbar): Boolean;

     class function ConfiguracoesShopeeValidas(ACodigoEmpresa: String): Boolean;

     property DatasetBaixa: TUniCLientDataset read FDatasetBaixa;
     property ObjetoConciliacao: TCamposConcil read FObjetoConciliacao write FObjetoConciliacao;
     property RegistrosConciliar: TStringList read FRegistrosConciliar write FRegistrosConciliar;

     property DataFinalConciliacao: TDateTime read FDataFinalConciliacao write FDataFinalConciliacao;
  End;

implementation

Uses untTLibCartoesMovBan, untTLibCartoesCadPag, untTLibCartoesMovCar;

{ TMercadoLibreBaixaRecebiveis }

procedure TShopeeBaixaRecebiveis.AdicionarRegistroCTPDetNoArraySintetico(
  ARegistroCTPDetFrete, ARegistroCTPDetAjuste: TArrBaiSinCar;
  APlanoDeContas: String; ARegistros: TUniClientDataset);
  Var
    LGravarFrete,
    LGravarAjuste: Boolean;

    LContador,
    LPosicaoFrete,
    LPosicaoAjuste: Integer;

    LChaveComparacao,
    LChaveArrayOriginal: String;
begin
  If Not TBaixaCartoes.ValidaGravacaoCTPDet(LGravarFrete, LGravarAjuste, APlanoDeContas, FRegistroCTPDetFrete, FRegistroCTPDetAjuste) Then
    Exit;

  LChaveArrayOriginal := Concat(ARegistros.FieldByName('MCA_CODEMP').AsString,
                                ARegistros.FieldByName('MCA_DTAREC').AsString,
                                ARegistros.FieldByName('CAR_PORBAI').AsString,
                                ARegistros.FieldByName('CAR_CTABAI').AsString,
                                ARegistros.FieldByName('CAR_PORBAD').AsString,
                                ARegistros.FieldByName('CAR_CTABAD').AsString,
                                ARegistros.FieldByName('CAR_PORTAX').AsString,
                                ARegistros.FieldByName('CAR_CTATAX').AsString,
                                ARegistros.FieldByName('CAR_FORTAX').AsString,
                                ARegistros.FieldByName('CAR_EVECRE').AsString,
                                ARegistros.FieldByName('CAR_EVETAX').AsString,
                                ARegistros.FieldByName('CAR_EVEDEB').AsString,
                                ARegistros.FieldByName('CAR_CTAANT').AsString);


  LPosicaoFrete := -1;
  LPosicaoAjuste := -1;
  For LContador := 0 To Length(FCTPDetSintetico) - 1 Do
  Begin
    LChaveComparacao := Concat(FCTPDetSintetico[LContador].strCodEmp,
                               DateTimeToStr(FCTPDetSintetico[LContador].dtaDtaRec),
                               FCTPDetSintetico[LContador].strPorBai,
                               FCTPDetSintetico[LContador].strCtaBai,
                               FCTPDetSintetico[LContador].strPorBad,
                               FCTPDetSintetico[LContador].strCtaBad,
                               FCTPDetSintetico[LContador].strPorTax,
                               FCTPDetSintetico[LContador].strCtaTax,
                               FCTPDetSintetico[LContador].strForTax,
                               FCTPDetSintetico[LContador].strEventoCredito,
                               FCTPDetSintetico[LContador].strEventoTaxa,
                               FCTPDetSintetico[LContador].strEveDeb,
                               FCTPDetSintetico[LContador].strCtaAnt);

    If LChaveComparacao <> LChaveArrayOriginal Then
      Continue;

    If LGravarFrete Then
      LPosicaoFrete := TShopeeFuncoes.IIF(ARegistroCTPDetFrete.strCtaTax = FCTPDetSintetico[LContador].PlanoDeContasParaCTPDet,
                           LContador,
                           LPosicaoFrete);

    If LGravarAjuste Then
      LPosicaoAjuste := TShopeeFuncoes.IIF(ARegistroCTPDetAjuste.strCtaTax = FCTPDetSintetico[LContador].PlanoDeContasParaCTPDet,
                            LContador,
                            LPosicaoAjuste);
  End;

  If LGravarFrete Then
  Begin
    If LPosicaoFrete = -1 THen
    Begin
      LPosicaoFrete := Length(FCTPDetSintetico);

      SetLength(FCTPDetSintetico, Length(FCTPDetSintetico) + 1);

      FCTPDetSintetico[LPosicaoFrete].strCodEmp := ARegistros.FieldByName('MCA_CODEMP').AsString;
      FCTPDetSintetico[LPosicaoFrete].dtaDtaRec := ARegistros.FieldByName('MCA_DTAREC').Value;
      FCTPDetSintetico[LPosicaoFrete].strPorBai := ARegistros.FieldByName('CAR_PORBAI').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaBai := ARegistros.FieldByName('CAR_CTABAI').AsString;
      FCTPDetSintetico[LPosicaoFrete].strPorBad := ARegistros.FieldByName('CAR_PORBAD').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaBad := ARegistros.FieldByName('CAR_CTABAD').AsString;
      FCTPDetSintetico[LPosicaoFrete].strPorTax := ARegistros.FieldByName('CAR_PORTAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaTax := ARegistros.FieldByName('CAR_CTATAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strForTax := ARegistros.FieldByName('CAR_FORTAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEventoCredito := ARegistros.FieldByName('CAR_EVECRE').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEventoTaxa := ARegistros.FieldByName('CAR_EVETAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEveDeb := ARegistros.FieldByName('CAR_EVEDEB').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaAnt :=ARegistros.FieldByName('CAR_CTAANT').AsString;

      FCTPDetSintetico[LPosicaoFrete].PlanoDeContasParaCTPDet := ARegistroCTPDetFrete.strCtaTax;

      FCTPDetSintetico[LPosicaoFrete].fltValTax := 0.00;
    End;

    FCTPDetSintetico[LPosicaoFrete].fltValTax := FCTPDetSintetico[LPosicaoFrete].fltValTax +
                                                 TShopeeFuncoes.fFormataFloat(ARegistroCTPDetFrete.fltValTax, 2);
  End;

  If LGravarAjuste Then
  Begin
    If ARegistroCTPDetAjuste.strCtaTax = ARegistroCTPDetFrete.strCtaTax Then
      LPosicaoAjuste := LPosicaoFrete;

    If LPosicaoAjuste = -1 THen
    Begin
      LPosicaoAjuste := Length(FCTPDetSintetico);

      SetLength(FCTPDetSintetico, Length(FCTPDetSintetico) + 1);

      FCTPDetSintetico[LPosicaoAjuste].strCodEmp := ARegistros.FieldByName('MCA_CODEMP').AsString;
      FCTPDetSintetico[LPosicaoAjuste].dtaDtaRec := ARegistros.FieldByName('MCA_DTAREC').Value;
      FCTPDetSintetico[LPosicaoAjuste].strPorBai := ARegistros.FieldByName('CAR_PORBAI').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaBai := ARegistros.FieldByName('CAR_CTABAI').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strPorBad := ARegistros.FieldByName('CAR_PORBAD').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaBad := ARegistros.FieldByName('CAR_CTABAD').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strPorTax := ARegistros.FieldByName('CAR_PORTAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaTax := ARegistros.FieldByName('CAR_CTATAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strForTax := ARegistros.FieldByName('CAR_FORTAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEventoCredito := ARegistros.FieldByName('CAR_EVECRE').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEventoTaxa := ARegistros.FieldByName('CAR_EVETAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEveDeb := ARegistros.FieldByName('CAR_EVEDEB').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaAnt :=ARegistros.FieldByName('CAR_CTAANT').AsString;

      FCTPDetSintetico[LPosicaoAjuste].PlanoDeContasParaCTPDet := ARegistroCTPDetAjuste.strCtaTax;
    End;

    FCTPDetSintetico[LPosicaoAjuste].fltValTax := FCTPDetSintetico[LPosicaoAjuste].fltValTax +
                                                  TShopeeFuncoes.fFormataFloat(ARegistroCTPDetAjuste.fltValTax, 2);
  End;
end;

function TShopeeBaixaRecebiveis.ApenasRegistrosDeTransferencias: Boolean;
  Var
    LSequenciais: TSequenciaisBaixaCartao;
begin
  Result := False;

  FDatasetBaixa.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''S'' ';

  If FDatasetBaixa.IsEmpty Then
    Exit;

  If FObjetoConciliacao.CfgPortadorTransferencia.IsEmpty Then
    Exit;

  If TShopeeFuncoes.fMensagem('ATENÇÃO', 'O período selecionado possui apenas registros de saques para serem lançados.' + #13 +
                                         'Deseja continuar com os lançamentos?', ['&Sim', '&Não'], 2) = 1 Then
  Begin
    LSequenciais := TSequenciaisBaixaCartao.Create;

    Try
      Inc64(LSequenciais.intSeqLan, FDatasetBaixa.RecordCount * 2);
      LSequenciais.intContadorAutIncMovBan := Copy(VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', VS_FuncoesExternas.fIRetEmpresaLogada, LSequenciais.intSeqLan), 4, 14).ToInt64;
      LSequenciais.intSeqLan := VS_FuncoesExternas.fISeqContaBanco(LSequenciais.intSeqLan).ToInt64;

      VS_FuncoesExternas.fIStartTransaction;
      TBaixaCartoes.GravaMovBanDeTransferencias(FDatasetBaixa,
                                                FObjetoConciliacao.NomeConciliacao,
                                                LSequenciais);

      MarcaRegistrosConciliadoPelaLista(FRegistrosConciliar,
                                        FObjetoConciliacao);

      VS_FuncoesExternas.fICommit;

      Result := True;

      TShopeeFuncoes.fMensagem('AVISO', 'Lançamentos de saques realizados com sucesso.', ['&Ok']);
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.fIRollBack;
        VS_FuncoesExternas.pIMensagensErro('Ocorreu um erro ao gravar as saques.' + #13 +
                                           'Erro gerado: ' + E.Message, '[TShopeeBaixaRecebiveis.ApenasRegistrosDeTransferencias]');
      End;
    End;

    FreeAndNil(LSequenciais);
  End;

  FDatasetBaixa.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
end;

function TShopeeBaixaRecebiveis.CarregaInformacaoDeBaixa: Boolean;
begin
  Result := True;

  Try
    FDatasetBaixa.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE=' + QuotedStr('N');
    FDatasetBaixa.Filtered := True;

    FCloneDataset := TShopeeFuncoes.CriarClientDataSet(FDatasetBaixa);

    FDatasetBaixa.Filter   := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    FDatasetBaixa.Filtered := True;

    FNumeroDocumento := EmptyStr;
    FHistorico := 'SHP ' + FormatDateTime('dd/mm/yyyy', DataFinalConciliacao);
  Except
    On E: Exception Do
    Begin
      Result := False;
      VS_FuncoesExternas.pIMensagensErro('Ocorreu um erro ao validar os dados dos cartões. ' + #13 +
                     'Erro gerado: ' + E.Message, '[TShopeeBaixaRecebiveis.CarregaInformacaoDeBaixa]');
    End;
  End;
end;

class function TShopeeBaixaRecebiveis.ConfiguracoesShopeeValidas(
  ACodigoEmpresa: String): Boolean;
begin
  Result := String(VS_FuncoesExternas.fICfgSis('SHOPOR', varString, ACodigoEmpresa) +
                   VS_FuncoesExternas.fICfgSis('SHOCTA', varString, ACodigoEmpresa) +
                   VS_FuncoesExternas.fICfgSis('SHOFOR', varString, ACodigoEmpresa)).Length >= 20;

  If Result Then
  Begin
    If VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean, ACodigoEmpresa) Then
      Result := Not String(VS_FuncoesExternas.fICfgSis('SHOEVE', varString, ACodigoEmpresa)).IsEmpty;
  End;

  If Not Result Then
    Exit;

  If String(VS_FuncoesExternas.fICfgSis('SHOCAR', varString, ACodigoEmpresa)).IsEmpty Then
    Exit(False);

  If String(VS_FuncoesExternas.fICfgSis('SHOTRF', varString, ACodigoEmpresa) +
            VS_FuncoesExternas.fICfgSis('SHOCTF', varString, ACodigoEmpresa)).Length < 12 Then
    Exit(False);

  If VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean, ACodigoEmpresa) Then
    Exit(Not String(VS_FuncoesExternas.fICfgSis('SHOETF', varString, ACodigoEmpresa)).IsEmpty);
end;

function TShopeeBaixaRecebiveis.ConfirmarBaixa(
  prgStatus: TcxProgressbar): Boolean;
  Var
    LApenasTransferencias: Boolean;
begin
  Result := ValidacoesParaBaixa;

  If Not Result Then
    Exit;

  TLibCartoesMovBan.CarregaDatasetPortadores;

  FDatasetBaixa.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
  FDatasetBaixa.Filtered := True;

  LApenasTransferencias := Not FDatasetBaixa.Locate('MCA_MARDES;REGISTROTRANSFERENCIA',
                                                    VarArrayOf(['M', 'N']), []);

  prgStatus.Visible := Not LApenasTransferencias;

  If Not LApenasTransferencias Then
  Begin
    If Not CarregaInformacaoDeBaixa Then
      Exit(False);
  End;

  FDatasetBaixa.Filter   := 'MCA_MARDES = ' + QuotedStr('M');

  if FDataDocumentoSintetico > 0 then
  Begin
    if VS_FuncoesExternas.fIFechamentoFinanceiroJaRealizado(VS_FuncoesExternas.fIRetEmpresaLogada, FDataDocumentoSintetico, 'TShopeeBaixaRecebiveis') then
      Exit(False);
  End;

  FDatasetBaixa.First;
  Application.ProcessMessages;

  Try
    If LApenasTransferencias Then
      Exit(ApenasRegistrosDeTransferencias)
    Else If Not FUtilizaBaixaAnalitica Then
      Result := RealizaBaixaVendasSintetica(prgStatus)
    Else
      Result := RealizaBaixaVendasAnalitica(prgStatus);

    If Result Then
    Begin
      MarcaRegistrosConciliadoPelaLista(FRegistrosConciliar,
                                        FObjetoConciliacao);

      VS_FuncoesExternas.fICommit;
    End;

    If Result Then
      TShopeeFuncoes.fMensagem('AVISO', 'Baixa de Recebíveis realizada com sucesso!', ['&Ok'])
    Else
    Begin
      VS_FuncoesExternas.fIRollBack;
      TShopeeFuncoes.fMensagem('AVISO', 'A Baixa de Recebíveis não foi realizada!', ['&Ok']);
    End;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollBack;
      Result := False;

      VS_FuncoesExternas.pIMensagensErro(E.Message, TShopeeFuncoes.IIF(FUtilizaBaixaAnalitica,
                                                                             '[TShopeeBaixaRecebiveis.RealizaBaixaVendasAnalitica]',
                                                                             '[TShopeeBaixaRecebiveis.RealizaBaixaVendasSintetica]'));
    End;
  End;
end;

constructor TShopeeBaixaRecebiveis.Create(
  ADatasetBaixa: TUniCLientDataset);
begin
  FDatasetBaixa := ADatasetBaixa;

  FUtilizaBaixaAnalitica := VS_FuncoesExternas.fICfgSis('CTC_AS') = 'A';
  FBaixarTaxasAnaliticoMkt := VS_FuncoesExternas.fICfgSis('SHOANA', varBoolean);

  FDataDocumentoSintetico := 0;
end;

destructor TShopeeBaixaRecebiveis.Destroy;
begin
  TLibCartoesMovBan.DestroiDatasetPortadores;

  inherited;
end;

function TShopeeBaixaRecebiveis.fAdicionaCartoesPorEmpresa(strCodEmp,
  strIdenti: String; var AListaBanMca: TListaBanMCA; dtaDtaRec: TDateTime;
  strPorCar, strCtaCar, strPorBad, strCtaBad, strPorTax, strCtaTax, strForTax,
  AstrEventoCredito, AstrEventoTaxa, strEveDeb, strCtaAnt: String;
  intAutoIncremInicial: Int64): Integer;
  Var
    LBanMcaDS: TBanMcaDS;
begin
  AListaBanMca := TListaBanMCA.Create;

  FCloneDataset.Filter := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_CODEMP = ' + QuotedStr(strCodEmp) +
                          ' AND MCA_VALREC > 0 ' +
                          ' AND MCA_DTAREC = ' + QuotedStr(FormatDateTime('dd-mm-yyyy', dtaDtaRec)) +
                          ' AND MCA_AJUSTE = ' + QuotedStr('N') +
                          ' AND CAR_PORBAI = ' + QuotedStr(strPorCar) +
                          ' AND CAR_CTABAI = ' + QuotedStr(strCtaCar) +
                          ' AND CAR_PORBAD = ' + QuotedStr(strPorBad) +
                          ' AND CAR_CTABAD = ' + QuotedStr(strCtaBad) +
                          ' AND CAR_PORTAX = ' + QuotedStr(strPorTax) +
                          ' AND CAR_CTATAX = ' + QuotedStr(strCtaTax) +
                          ' AND CAR_FORTAX = ' + QuotedStr(strForTax) +
                          ' AND CAR_EVECRE = ' + QuotedStr(AstrEventoCredito) +
                          ' AND CAR_EVETAX = ' + QuotedStr(AstrEventoTaxa) +
                          ' AND CAR_EVEDEB = ' + QuotedStr(strEveDeb) +
                          ' AND CAR_CTAANT = ' + QuotedStr(strCtaAnt);
  FCloneDataset.Filtered := True;

  FCloneDataset.First;
  While Not FCloneDataset.Eof Do
  Begin
    Application.ProcessMessages;

    LBanMcaDS := TBanMcaDS.Create;
    LBanMcaDS.strNumDup := FCloneDataset.FieldByName('NRODUP').AsString;
    LBanMcaDS.strParcel := FCloneDataset.FieldByName('PARDUP').AsString;
    LBanMcaDS.strCodEmp := FCloneDataset.FieldByName('MCA_CODEMP').AsString;
    LBanMcaDS.strCodCli := FCloneDataset.FieldByName('MCA_CODCLI').AsString;
    LBanMcaDS.strCodCar := FCloneDataset.FieldByName('MCA_CODCAR').AsString;
    LBanMcaDS.strHist01 := FCloneDataset.FieldByName('MCA_HIST01').AsString;
    LBanMcaDS.strHist02 := FCloneDataset.FieldByName('MCA_HIST02').AsString;
    LBanMcaDS.strNumCCD := FCloneDataset.FieldByName('MCA_NUMCCD').AsString;
    LBanMcaDS.strNumNsu := FCloneDataset.FieldByName('MCA_NUMNSU').AsString;
    LBanMcaDS.fltValSta := FCloneDataset.FieldByName('MCA_VALSTA').AsFloat;
    LBanMcaDS.fltValTax := FCloneDataset.FieldByName('MCA_VALTAX').AsFloat;
    LBanMcaDS.fltValRec := FCloneDataset.FieldByName('MCA_VALREC').AsFloat;
    LBanMcaDS.fltFreMkt := FCloneDataset.FieldByName('FRETE_MARKETPLACE').AsFloat;
    LBanMcaDS.fltValAju := FCloneDataset.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
    LBanMcaDS.fltCupMkt := FCloneDataset.FieldByName('CUPOM_MARKETPLACE').AsFloat;
    LBanMcaDS.strIdenti := strIdenti;
    LBanMcaDS.strAutInc := TShopeeFuncoes.IIF(intAutoIncremInicial > 0,
                               TShopeeFuncoes.fFormataAutInc(intAutoIncremInicial,
                                                               VS_FuncoesExternas.fIRetEmpresaLogada),
                               intAutoIncremInicial);
    AListaBanMca.Add(LBanMcaDS);

    If intAutoIncremInicial > 0 Then
      Inc64(intAutoIncremInicial);

    FCloneDataset.Next;
  End;

  Result := FCloneDataset.RecordCount;
end;

function TShopeeBaixaRecebiveis.FaltaPortadoresEPlanosDeContasParaBaixa: Boolean;
begin
  Result := FDatasetBaixa.Locate('CAR_PORBAI', '', []);
  If Not Result Then
    Result := FDatasetBaixa.Locate('CAR_CTABAI', '', []);
  If Not Result Then
    Result := FDatasetBaixa.Locate('CAR_PORTAX;MCA_AJUSTE', VarArrayOf(['', 'N']), []);
  If Not Result Then
    Result := FDatasetBaixa.Locate('CAR_CTATAX;MCA_AJUSTE', VarArrayOf(['', 'N']), []);
  If Not Result Then
    Result := FDatasetBaixa.Locate('CAR_FORTAX', '', []);
  If Not Result Then
    Result := FDatasetBaixa.Locate('CAR_CTAANT;MCA_ANT_SN', VarArrayOf(['', 'S']), []);

  If FBaixarTaxasAnaliticoMkt Then
  Begin
    If Not Result Then
      Result := FDatasetBaixa.Locate('CAR_CTAFRE;CAR_MKTPLA', VarArrayOf(['', 'S']), []);
    If Not Result Then
      Result := FDatasetBaixa.Locate('CAR_CTACUP;CAR_MKTPLA', VarArrayOf(['', 'S']), []);
  End;

  If Result Then
    FDatasetBaixa.First;
end;

procedure TShopeeBaixaRecebiveis.MarcaRegistrosConciliadoPelaLista(
  var ARegistrosConciliar: TStringList; ACamposConcil: TCamposConcil);
  Var
    LSQL,
    LWhere,
    LRegistro: String;

    LContador,
    LContadorRegistros: Integer;

    LCamposChave,
    LValoresChave: TStringList;
begin
  If Not Assigned(ARegistrosConciliar) Then
    Exit;

  If ARegistrosConciliar.Count = 0 Then
    Exit;

  LCamposChave := TStringList.Create;
  LCamposChave.Delimiter := ',';
  LCamposChave.StrictDelimiter := True;
  LCamposChave.DelimitedText := ACamposConcil.strChavePrimariaAjuste;

  LValoresChave := TStringList.Create;
  LValoresChave.Delimiter := '|';
  LValoresChave.StrictDelimiter := True;

  Try
    LSQL := 'UPDATE SHO_SHAJUS SET SHO_CONCIL=1 WHERE ';
    LWhere := '';

    LContadorRegistros := 0;
    For LRegistro In ARegistrosConciliar Do
    Begin
      LValoresChave.DelimitedText := LRegistro;

      LWhere := LWhere + '(';
      For LContador := 0 To LCamposChave.Count - 1 Do
      Begin
        LWhere := LWhere + LCamposChave[LContador] + '=' + LValoresChave[LContador];

        If LContador < LCamposChave.Count - 1 Then
          LWhere := LWhere + ' AND ';
      End;
      LWhere := LWhere + ') OR ';

      Inc(LContadorRegistros);

      If LContadorRegistros >= 80 Then
      Begin
        TShopeeFuncoes.ExecutaSQL(LSQL + LeftStr(LWhere, LWhere.Length - 4));

        LWhere := '';
        LContadorRegistros := 0;
      End;
    End;

    If Not LWhere.IsEmpty Then
      TShopeeFuncoes.ExecutaSQL(LSQL + LeftStr(LWhere, LWhere.Length - 4));

    ARegistrosConciliar.Clear;
  Finally
    FreeAndNil(LValoresChave);
    FreeAndNil(LCamposChave);
  End;
end;

procedure TShopeeBaixaRecebiveis.pAtualizaDataMovimentobancarioMovCar(
  AAutoIncrem: String; ADataAlterada: TDateTime);
  Var
    qryAltCrt : TUniQuery;
begin
  qryAltCrt := VS_FuncoesExternas.fICriaQuery;

  Try
     qryAltCrt.Close;
     qryAltCrt.SQL.Clear;
     qryAltCrt.SQL.Add(' UPDATE MOVCAR ');
     qryAltCrt.SQL.Add('    SET MCA_DTABAN = :DTABAN ');
     qryAltCrt.SQL.Add('  WHERE AUTOINCREM = :AUTOIN ');
     qryAltCrt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
     qryAltCrt.ParamByName('AUTOIN').AsString   := AAutoIncrem;
     qryAltCrt.ExecSQL;

     FreeAndNil(qryAltCrt);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmBaixaCartoes.pAtualizaDataMovimentobancarioMovCar] ' +E.Message);
    End;
  End;
end;

procedure TShopeeBaixaRecebiveis.pCarregaArrAjustes;
  Var
    strCodEmp: String;
    dtaDtaRec: TDateTime;
    fltValDoc: Double;
    blnVerifi: Boolean;
    strPorBai,
    strCtaBai,
    strTaxaFo,
    strFilAnt,
    strTipAju,
    strEventoCancelamentoAjuste: String;
begin
  Application.ProcessMessages;

  strFilant := FDatasetBaixa.Filter;

  FDatasetBaixa.Filter := 'MCA_AJUSTE=''S'' AND REGISTROTRANSFERENCIA=''N'' AND NEGOCIACAO <> ''S'' ';

  FDatasetBaixa.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_FORTAX;MCA_VALREC;MCA_EVECAN';
  FDatasetBaixa.Filtered := True;
  SetLength(arrBaiSinDeb, 0);

  If FDatasetBaixa.RecordCOunt > 0 Then
  Begin
    FDatasetBaixa.First;
    strCodEmp                   := FDatasetBaixa.FieldByName('MCA_CODEMP').AsString;
    dtaDtaRec                   := FDatasetBaixa.FieldByName('MCA_DTAREC').Value;
    strPorBai                   := FDatasetBaixa.FieldByName('CAR_PORBAI').AsString;
    strCtaBai                   := FDatasetBaixa.FieldByName('CAR_CTABAI').AsString;
    strTaxaFo                   := FDatasetBaixa.FieldByName('CAR_FORTAX').AsString;
    strEventoCancelamentoAjuste := FDatasetBaixa.FieldByName('MCA_EVECAN').AsString;
    fltValDoc                   := 0;
    strTipAju                   := TShopeeFuncoes.IIF(FDatasetBaixa.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

    While Not FDatasetBaixa.Eof Do
    Begin
      blnVerifi := (FDatasetBaixa.FieldByName('MCA_CODEMP').AsString <> strCodEmp) Or
                   (FDatasetBaixa.FieldByName('MCA_DTAREC').Value <> dtaDtaRec)    Or
                   (FDatasetBaixa.FieldByName('CAR_PORBAI').AsString <> strPorBai) Or
                   (FDatasetBaixa.FieldByName('CAR_CTABAI').AsString <> strCtaBai) Or
                   (FDatasetBaixa.FieldByName('CAR_FORTAX').AsString <> strTaxaFo) Or
                   (FDatasetBaixa.FieldByName('MCA_EVECAN').AsString <> strEventoCancelamentoAjuste) Or
                   (TShopeeFuncoes.IIF(FDatasetBaixa.FieldByName('MCA_VALREC').Value < 0, 'D', 'C') <> strTipAju);

      If blnVerifi Then
      Begin
        SetLength(arrBaiSinDeb, Length(arrBaiSinDeb) + 1);

        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValDoc := fltValDoc;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValTax := 0;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCodEmp := strCodEmp;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].dtaDtaRec := dtaDtaRec;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strPorBai := strPorBai;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCtaBai := strCtaBai;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strForTax := strTaxaFo;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strNumDoc := FNumeroDocumento;

        If Not TShopeeFuncoes.fEmptyStr(FDatasetBaixa.FieldByName('HISTORICO_BAIXA').AsString) Then
        Begin
          If (Pos(FDatasetBaixa.FieldByName('HISTORICO_BAIXA').AsString, FHistorico) <= 0) Then
            FHistorico := FDatasetBaixa.FieldByName('HISTORICO_BAIXA').AsString + ' ' + FHistorico;
        End;

        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strHisDoc := FHistorico + ' - Canc./Ajuste Cartões';
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].intPagCon := FCtpCon;
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := TShopeeFuncoes.IIF(fltValDoc < 0, 'D', 'C');
        arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strEventoCancelamentoAjuste := strEventoCancelamentoAjuste;

        strCodEmp                   := FDatasetBaixa.FieldByName('MCA_CODEMP').AsString;
        dtaDtaRec                   := FDatasetBaixa.FieldByName('MCA_DTAREC').Value;
        fltValDoc                   := FDatasetBaixa.FieldByName('MCA_VALREC').AsFloat;
        strPorBai                   := FDatasetBaixa.FieldByName('CAR_PORBAI').AsString;
        strCtaBai                   := FDatasetBaixa.FieldByName('CAR_CTABAI').AsString;
        strTaxaFo                   := FDatasetBaixa.FieldByName('CAR_FORTAX').AsString;
        strEventoCancelamentoAjuste := FDatasetBaixa.FieldByName('MCA_EVECAN').AsString;
        strTipAju                   := TShopeeFuncoes.IIF(FDatasetBaixa.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');
      End
      Else
        fltValDoc := fltValDoc + FDatasetBaixa.FieldByName('MCA_VALREC').AsFloat;

      FDatasetBaixa.Next;
    End;

    SetLength(arrBaiSinDeb, Length(arrBaiSinDeb) + 1);

    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValDoc := fltValDoc;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValTax := 0;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCodEmp := strCodEmp;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].dtaDtaRec := dtaDtaRec;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strPorBai := strPorBai;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCtaBai := strCtaBai;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strForTax := strTaxaFo;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strNumDoc := FNumeroDocumento;

    If Not TShopeeFuncoes.fEmptyStr(FDatasetBaixa.FieldByName('HISTORICO_BAIXA').AsString) Then
    Begin
      If (Pos(FDatasetBaixa.FieldByName('HISTORICO_BAIXA').AsString, FHistorico) <= 0) Then
        FHistorico := FDatasetBaixa.FieldByName('HISTORICO_BAIXA').AsString + ' ' + FHistorico;
    End;

    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strHisDoc := TShopeeFuncoes.IIF(TShopeeFuncoes.fEmptyStr(FHistorico),'', FHistorico + ' - ')+ 'Canc./Ajuste Cartões - Emp. ' + strCodEmp;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].intPagCon := FCtpCon;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := strTipAju;
    arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strEventoCancelamentoAjuste := strEventoCancelamentoAjuste;
  End;

  FDatasetBaixa.Filter := strFilAnt;
end;

procedure TShopeeBaixaRecebiveis.pCarregaArrBaiSinCar;
  Var
    strCodEmp: String;
    dtaDtaRec: TDateTime;

    fltValDoc,
    fltValTax,
    fltValAnt,
    LFreteMarketPlace,
    LAjusteMarketPlace,
    LCupomMarketPlace,
    LSubtrairFrete: Double;

    blnVerifi: Boolean;

    strPorBai,
    strCtaBai,
    strPorDeb,
    strCtaDeb,
    strTaxaPo,
    strTaxaCt,
    strTaxaFo,
    SEventoCredito,
    SEventoTaxa,
    strEvento,
    strCtaAnt,
    strFilAnt,

    LPlanoDeContasFrete,
    LPlanoDeCOntasAjuste,
    LPlanoDeContasCupom: String;

    intQtdCar: Integer;
begin

  Application.ProcessMessages;
  SetLength(arrBaiSinCar, 0);
  SetLength(FCTPDETSintetico, 0);

  FDatasetBaixa.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_PORTAX;CAR_CTATAX;CAR_FORTAX;'+
                               'CAR_PORBAD;CAR_CTABAD;CAR_EVEDEB;CAR_CTAANT;CAR_EVECRE;CAR_EVETAX';
  strFilAnt := FDatasetBaixa.Filter;
  FDatasetBaixa.Filter := 'MCA_MARDES=' + QuotedStr('M') + 'AND MCA_AJUSTE=' + QuotedStr('N') + ' AND NEGOCIACAO=''N'' ';
  FDatasetBaixa.Filtered := True;

  If FDatasetBaixa.IsEmpty Then
    Exit;

  FDatasetBaixa.First;
  strCodEmp := FDatasetBaixa.FieldByName('MCA_CODEMP').AsString;
  dtaDtaRec := FDatasetBaixa.FieldByName('MCA_DTAREC').Value;
  strPorBai      := FDatasetBaixa.FieldByName('CAR_PORBAI').AsString;
  strCtaBai      := FDatasetBaixa.FieldByName('CAR_CTABAI').AsString;
  strPorDeb      := FDatasetBaixa.FieldByName('CAR_PORBAD').AsString;
  strCtaDeb      := FDatasetBaixa.FieldByName('CAR_CTABAD').AsString;
  strTaxaPo      := FDatasetBaixa.FieldByName('CAR_PORTAX').AsString;
  strTaxaCt      := FDatasetBaixa.FieldByName('CAR_CTATAX').AsString;
  strTaxaFo      := FDatasetBaixa.FieldByName('CAR_FORTAX').AsString;
  SEventoCredito := FDatasetBaixa.FieldByName('CAR_EVECRE').AsString;
  SEventoTaxa    := FDatasetBaixa.FieldByName('CAR_EVETAX').AsString;
  strEvento      := FDatasetBaixa.FieldByName('CAR_EVEDEB').AsString;
  strCtaAnt      := FDatasetBaixa.FieldByName('CAR_CTAANT').AsString;
  fltValDoc      := 0;
  fltValTax      := 0;
  fltValAnt      := 0;
  intQtdCar      := 0;
  LFreteMarketPlace := 0;
  LAjusteMarketPlace := 0;
  LCupomMarketPlace := 0;
  LSubtrairFrete := 0;

  LPlanoDeContasFrete := FDatasetBaixa.FieldByName('CAR_CTAFRE').AsString;
  LPlanoDeContasAjuste := FDatasetBaixa.FieldByName('CAR_CTAAJU').AsString;
  LPlanoDeContasCupom := FDatasetBaixa.FieldByName('CAR_CTACUP').AsString;

  While Not FDatasetBaixa.Eof Do
  Begin
    TBaixaCartoes.GeraRegistroCTPDetDeTaxaParaMarketPlace(FRegistroCTPDetFrete,
                                                          FRegistroCTPDetAjuste,
                                                          FDatasetBaixa);

    blnVerifi := (FDatasetBaixa.FieldByName('MCA_CODEMP').AsString <> strCodEmp) Or
                 (FDatasetBaixa.FieldByName('MCA_DTAREC').Value <> dtaDtaRec)    Or
                 (FDatasetBaixa.FieldByName('CAR_PORBAI').AsString <> strPorBai) Or
                 (FDatasetBaixa.FieldByName('CAR_CTABAI').AsString <> strCtaBai) Or
                 (FDatasetBaixa.FieldByName('CAR_PORBAD').AsString <> strPorDeb) Or
                 (FDatasetBaixa.FieldByName('CAR_CTABAD').AsString <> strCtaDeb) Or
                 (FDatasetBaixa.FieldByName('CAR_PORTAX').AsString <> strTaxaPo) Or
                 (FDatasetBaixa.FieldByName('CAR_CTATAX').AsString <> strTaxaCt) Or
                 (FDatasetBaixa.FieldByName('CAR_FORTAX').AsString <> strTaxaFo) Or
                 (FDatasetBaixa.FieldByName('CAR_EVECRE').AsString <> SEventoCredito) Or
                 (FDatasetBaixa.FieldByName('CAR_EVETAX').AsString <> SEventoTaxa) Or
                 (FDatasetBaixa.FieldByName('CAR_EVEDEB').AsString <> strEvento) Or
                 (FDatasetBaixa.FieldByName('CAR_CTAANT').AsString <> strCtaAnt);

    If blnVerifi Then
    Begin
      SetLength(arrBaiSinCar, Length(arrBaiSinCar) + 1);

      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValDoc        := fltValDoc + Abs(LCupomMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValTax        := fltValTax;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCodEmp        := strCodEmp;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].dtaDtaRec        := dtaDtaRec;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBai        := strPorBai;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBai        := strCtaBai;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoCredito := SEventoCredito;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBad        := strPorDeb;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBad        := strCtaDeb;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorTax        := strTaxaPo;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strForTax        := strTaxaFo;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaTax        := strTaxaCt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoTaxa    := SEventoTaxa;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEveDeb        := strEvento;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaAnt        := strCtaAnt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValAnt        := fltValAnt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].intQtdCar        := intQtdCar;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].FreteMarketPlace := Abs(LFreteMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].AjusteMarketPlace := Abs(LAjusteMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].CupomMarketPlace := Abs(LCupomMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].SubtrairFrete := Abs(LSubtrairFrete);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasFreteMkt := LPlanoDeContasFrete;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasAjusteMkt := LPlanoDeContasAjuste;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasCupomMkt := LPlanoDeContasCupom;

      strCodEmp      := FDatasetBaixa.FieldByName('MCA_CODEMP').AsString;
      dtaDtaRec      := FDatasetBaixa.FieldByName('MCA_DTAREC').Value;
      fltValDoc      := FDatasetBaixa.FieldByName('MCA_VALSTA').AsFloat;
      fltValTax      := FDatasetBaixa.FieldByName('MCA_VALTAX').AsFloat;
      strPorBai      := FDatasetBaixa.FieldByName('CAR_PORBAI').AsString;
      strCtaBai      := FDatasetBaixa.FieldByName('CAR_CTABAI').AsString;
      strPorDeb      := FDatasetBaixa.FieldByName('CAR_PORBAD').AsString;
      strCtaDeb      := FDatasetBaixa.FieldByName('CAR_CTABAD').AsString;
      strTaxaPo      := FDatasetBaixa.FieldByName('CAR_PORTAX').AsString;
      strTaxaCt      := FDatasetBaixa.FieldByName('CAR_CTATAX').AsString;
      strTaxaFo      := FDatasetBaixa.FieldByName('CAR_FORTAX').AsString;
      SEventoCredito := FDatasetBaixa.FieldByName('CAR_EVECRE').AsString;
      SEventoTaxa    := FDatasetBaixa.FieldByName('CAR_EVETAX').AsString;
      strEvento      := FDatasetBaixa.FieldByName('CAR_EVEDEB').AsString;
      strCtaAnt      := FDatasetBaixa.FieldByName('CAR_CTAANT').AsString;
      fltValAnt      := FDatasetBaixa.FieldByName('MCA_ANTTAX').AsFloat;
      LFreteMarketPlace := FDatasetBaixa.FieldByName('FRETE_MARKETPLACE').AsFloat;
      LAjusteMarketPlace := FDatasetBaixa.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
      LCupomMarketPlace := FDatasetBaixa.FieldByName('CUPOM_MARKETPLACE').AsFloat;
      LPlanoDeContasFrete := FDatasetBaixa.FieldByName('CAR_CTAFRE').AsString;
      LPlanoDeContasAjuste := FDatasetBaixa.FieldByName('CAR_CTAAJU').AsString;
      LPlanoDeContasCupom := FDatasetBaixa.FieldByName('CAR_CTACUP').AsString;
      LSubtrairFrete := FDatasetBaixa.FieldByName('SUBTRAIR_FRETE').AsFloat;
      intQtdCar      := 1;
    End
    Else
    Begin
      fltValDoc := fltValDoc + FDatasetBaixa.FieldByName('MCA_VALSTA').AsFloat;
      fltValTax := fltValTax + FDatasetBaixa.FieldByName('MCA_VALTAX').AsFloat;
      fltValAnt := fltValAnt + FDatasetBaixa.FieldByName('MCA_ANTTAX').AsFloat;
      LFreteMarketPlace := LFreteMarketPlace + FDatasetBaixa.FieldByName('FRETE_MARKETPLACE').AsFloat;
      LAjusteMarketPlace := LAjusteMarketPlace + FDatasetBaixa.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
      LCupomMarketPlace := LCupomMarketPlace + FDatasetBaixa.FieldByName('CUPOM_MARKETPLACE').AsFloat;
      LSubtrairFrete := LSubtrairFrete + FDatasetBaixa.FieldByName('SUBTRAIR_FRETE').AsFloat;

      Inc(intQtdCar);
    End;

    AdicionarRegistroCTPDetNoArraySintetico(FRegistroCTPDetFrete,
                                            FRegistroCTPDetAjuste,
                                            strTaxaCt,
                                            FDatasetBaixa);

    FDatasetBaixa.Next;
  End;

  SetLength(arrBaiSinCar, Length(arrBaiSinCar) + 1);

  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValDoc        := fltValDoc + Abs(LCupomMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValTax        := fltValTax;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCodEmp        := strCodEmp;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].dtaDtaRec        := dtaDtaRec;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBai        := strPorBai;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBai        := strCtaBai;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBad        := strPorDeb;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBad        := strCtaDeb;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorTax        := strTaxaPo;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strForTax        := strTaxaFo;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaTax        := strTaxaCt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoCredito := SEventoCredito;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoTaxa    := SEventoTaxa;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEveDeb        := strEvento;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaAnt        := strCtaAnt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValAnt        := fltValAnt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].intQtdCar        := intQtdCar;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].FreteMarketPlace := Abs(LFreteMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].AjusteMarketPlace := Abs(LAjusteMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].CupomMarketPlace := Abs(LCupomMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasFreteMkt := LPlanoDeContasFrete;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasAjusteMkt := LPlanoDeContasAjuste;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasCupomMkt := LPlanoDeContasCupom;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].SubtrairFrete := Abs(LSubtrairFrete);

  FDatasetBaixa.Filter := strFilAnt;
end;

function TShopeeBaixaRecebiveis.PossuiPortadorSemPermissao(
  var APortadoresSemPermissao: String): Boolean;
  Var
    LConsulta: TUniQuery;

    LPortadores: String;
begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;
  LPortadores := EmptyStr;

  Try
    FDatasetBaixa.First;
    While Not FDatasetBaixa.Eof Do
    Begin
      If Pos(FDatasetBaixa.FieldByName('CAR_PORBAI').AsString, LPortadores) <= 0 Then
        LPortadores := LPortadores + '"' + FDatasetBaixa.FieldByName('CAR_PORBAI').AsString + '",';
      If (Not TShopeeFuncoes.fEmptyStr(FDatasetBaixa.FieldByName('CAR_PORTAX').AsString)) And (Pos(FDatasetBaixa.FieldByName('CAR_PORTAX').AsString, LPortadores) <= 0) Then
        LPortadores := LPortadores + '"' + FDatasetBaixa.FieldByName('CAR_PORTAX').AsString + '",';
      If (Not TShopeeFuncoes.fEmptyStr(FDatasetBaixa.FieldByName('CAR_PORBAD').AsString)) And (Pos(FDatasetBaixa.FieldByName('CAR_PORBAD').AsString, LPortadores) <= 0) Then
        LPortadores := LPortadores + '"' + FDatasetBaixa.FieldByName('CAR_PORBAD').AsString + '",';

      FDatasetBaixa.Next;
    End;
    FDatasetBaixa.First;

    LConsulta.SQL.Text := 'SELECT POR_CODPOR ' +
                          'FROM CADPOR  ' +
                          'WHERE POR_CODPOR IN (' + TShopeeFuncoes.IIF(TShopeeFuncoes.fEmptyStr(LPortadores), '""',
                                                                             LeftStr(LPortadores, Length(LPortadores) - 1)) + ') ' +
                          '  AND (POR_PERBAI="N" OR POR_PERBAI IS NULL) ' +
                          'ORDER BY POR_CODPOR';
    LConsulta.Open;

    APortadoresSemPermissao := EmptyStr;

    Result := Not LConsulta.IsEmpty;
    If Result Then
    Begin
      While Not LConsulta.Eof Do
      Begin
        APortadoresSemPermissao := APortadoresSemPermissao + LConsulta.FieldByName('POR_CODPOR').AsString + ', ';

        LConsulta.Next;
      End;
      APortadoresSemPermissao := LeftStr(APortadoresSemPermissao, Length(APortadoresSemPermissao) - 2);
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TShopeeBaixaRecebiveis.RealizaBaixaVendasAnalitica(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    strNumDup    : String;
    strHistor    : String;
    blnConfirma  : Boolean;
    objSequencias: TSequenciaisBaixaCartao;

    LDatasetAuxiliar: TUniCLientDataset;

    LValorTotalTaxa,
    LValorCredito,
    LValorTotalCtp: Double;

    LSeqLanCredito,
    LSeqLanTaxa,
    LSeqLanDebito,
    LSeqLanAntecipacao,
    LSeqLanFrete,
    LSeqLanAjuste,
    LSeqLanCupom: String;

    LListaBanMca: TListaBanMCA;

    LBanMcaDS: TBanMcaDS;
begin
  Application.ProcessMessages;
  LDatasetAuxiliar := TShopeeFuncoes.CriarClientDataSet(FDatasetBaixa);

  Try
    Try
      LDatasetAuxiliar.DisableControls;
      LDatasetAuxiliar.Filtered := False;
      LDatasetAuxiliar.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');
      LDatasetAuxiliar.Filtered := True;
    
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := LDatasetAuxiliar.RecordCount;
      blnConfirma := True;
      Application.ProcessMessages;

      LSeqLanFrete := EmptyStr;
      LSeqLanAjuste := EmptyStr;
      LSeqLanCupom := EmptyStr;

      VS_FuncoesExternas.fIStartTransaction;
      FCtpCon := VS_FuncoesExternas.fIRetCtpCon;
      VS_FuncoesExternas.fICommit;

      pCarregaArrAjustes;

      objSequencias := RetornaSequenciaisParaBaixaAnalitica(LDatasetAuxiliar,
                                                            False,
                                                            True,
                                                            FBaixarTaxasAnaliticoMkt,
                                                            Length(arrBaiSinDeb));
      objSequencias.SequencialControleBaixaPagar := FCtpCon;
      objSequencias.NumeroDocumentoBaixa := FNumeroDocumento;

      strHistor := FHistorico;

      VS_FuncoesExternas.fIStartTransaction;

      {************************************}
      {* GRAVA OS LANÇAMENTOS DOS AJUSTES *}
      {*********************************AJ*}
      If (Length(arrBaiSinDeb) > 0) Then
      Begin
        TBaixaCartoes.GravaMovBanAjustes(arrBaiSinDeb, objSequencias.intSeqLan, objSequencias.intContadorAutIncMovBan);
        TBaixaCartoes.GravaCadPagAjustes(arrBaiSinDeb, objSequencias.intSequencialCadPag, objSequencias.intContadorAutIncCadPag);

        Inc64(objSequencias.intSeqLan, Length(arrBaiSinDeb));
        Inc64(objSequencias.intSequencialCadPag, Length(arrBaiSinDeb));
        Inc64(objSequencias.intContadorAutIncMovBan, Length(arrBaiSinDeb));
        Inc64(objSequencias.intContadorAutIncCadPag, Length(arrBaiSinDeb));
      End;

      While Not LDatasetAuxiliar.Eof Do
      Begin
        TShopeeFuncoes.pStepStatusGravacao(pgbStatus);

        LSeqLanCredito := EmptyStr;
        LSeqLanTaxa := EmptyStr;
        LSeqLanDebito := EmptyStr;
        LSeqLanAntecipacao := EmptyStr;
        LSeqLanFrete := EmptyStr;
        LSeqLanAjuste := EmptyStr;
        LSeqLanCupom := EmptyStr;

        If LDatasetAuxiliar.FieldByName('MCA_MARDES').AsString = 'M' Then
        Begin
          TBaixaCartoes.GeraRegistroCTPDetDeTaxaParaMarketPlace(FRegistroCTPDetFrete,
                                                                FRegistroCTPDetAjuste,
                                                                LDatasetAuxiliar);

          If Not TShopeeFuncoes.fEmptyStr(LDatasetAuxiliar.FieldByName('HISTORICO_BAIXA').AsString) Then
          Begin
            If (Pos(LDatasetAuxiliar.FieldByName('HISTORICO_BAIXA').AsString,strHistor) <= 0) Then
              strHistor := LDatasetAuxiliar.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHistor;

            If (Pos(LDatasetAuxiliar.FieldByName('HISTORICO_BAIXA').AsString, FHistorico) <= 0) Then
              FHistorico := LDatasetAuxiliar.FieldByName('HISTORICO_BAIXA').AsString + ' ' + FHistorico;
          End;

          If TShopeeFuncoes.fEmptyStr(strHistor) Then
            FHistorico := 'Rec. ' + LDatasetAuxiliar.FieldByName('CAR_DESCAR').AsString;

          blnConfirma := LDatasetAuxiliar.FieldByName('MCA_VALREC').AsFloat >= 0;

          If LDatasetAuxiliar.FieldByName('MCA_VALREC').AsFloat > 0 Then
          Begin
            LBanMcaDS := TBanMcaDS.Create;
            LBanMcaDS.strNumDup := LDatasetAuxiliar.FieldByName('NRODUP').AsString;
            LBanMcaDS.strParcel := LDatasetAuxiliar.FieldByName('PARDUP').AsString;
            LBanMcaDS.strCodEmp := LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString;
            LBanMcaDS.strCodCli := LDatasetAuxiliar.FieldByName('MCA_CODCLI').AsString;
            LBanMcaDS.strCodCar := LDatasetAuxiliar.FieldByName('MCA_CODCAR').AsString;
            LBanMcaDS.strHist01 := LDatasetAuxiliar.FieldByName('MCA_HIST01').AsString;
            LBanMcaDS.strHist02 := LDatasetAuxiliar.FieldByName('MCA_HIST02').AsString;
            LBanMcaDS.strNumCCD := LDatasetAuxiliar.FieldByName('MCA_NUMCCD').AsString;
            LBanMcaDS.strNumNsu := LDatasetAuxiliar.FieldByName('MCA_NUMNSU').AsString;
            LBanMcaDS.fltValSta := LDatasetAuxiliar.FieldByName('MCA_VALSTA').AsFloat;
            LBanMcaDS.fltValTax := LDatasetAuxiliar.FieldByName('MCA_VALTAX').AsFloat;
            LBanMcaDS.fltValRec := LDatasetAuxiliar.FieldByName('MCA_VALREC').AsFloat;
            LBanMcaDS.fltFreMkt := LDatasetAuxiliar.FieldByName('FRETE_MARKETPLACE').AsFloat;
            LBanMcaDS.fltValAju := LDatasetAuxiliar.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
            LBanMcaDS.fltCupMkt := LDatasetAuxiliar.FieldByName('CUPOM_MARKETPLACE').AsFloat;
            LBanMcaDS.strIdenti := 'VALSTA';
            LBanMcaDS.strAutInc := TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

            Inc64(objSequencias.intContadorAutIncBanMca);

            LListaBanMca := TListaBanMCA.Create;
            LListaBanMca.Add(LBanMcaDS);

            LValorCredito := LDatasetAuxiliar.FieldByName('MCA_VALSTA').AsFloat;
            If Not FBaixarTaxasAnaliticoMkt Then
                LValorCredito := LValorCredito +
                                 Abs(LDatasetAuxiliar.FieldByName('CUPOM_MARKETPLACE').AsFloat);

            {*****************************************}
            {* GRAVA MOVBAN DO CARTÃO                *}
            {**************************************MV*}
            LSeqLanCredito  := TLibCartoesMovBan.GravaMovBan(LDatasetAuxiliar.FieldByName('CAR_CTABAI').AsString,  // Centro de Custo
                                                           LDatasetAuxiliar.FieldByName('CAR_PORBAI').AsString,  // Portador
                                                           VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                           LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                           TShopeeFuncoes.fTime(),                              // Hora do Lançamento
                                                           FNumeroDocumento,                           // Documento
                                                           'C',                                  // Credito / Debito
                                                           VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                           LValorCredito,                        // Valor Documento
                                                           FHistorico + ' - Ref.Emp. ' + LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,// Historico 1
                                                           '',                                   // Historico 2
                                                           LDatasetAuxiliar.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                                           '',                                   // Fornecedor
                                                           '',                                   // Numero da Duplicata
                                                           0,                                    // Sequencial Duplicata
                                                           '',                                   // Parcela da Duplicata
                                                           LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                                           '',                                   // Série
                                                           LDatasetAuxiliar.FieldByName('CAR_EVECRE').AsString, // Código do Evento
                                                           '',                                   // Documento da Baixa
                                                           0,
                                                           FCtpCon,
                                                           '',
                                                           '',
                                                           objSequencias.intSeqLan.ToString,
                                                           TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                           '',
                                                           '',
                                                           1,
                                                           True,
                                                           LListaBanMca);

            Inc64(objSequencias.intSeqLan);
            Inc64(objSequencias.intContadorAutIncMovBan);

            blnConfirma := (Not TShopeeFuncoes.fEmptyStr(LSeqLanCredito));

            If blnConfirma Then
              pAtualizaDataMovimentobancarioMovCar(LDatasetAuxiliar.FieldByName('AUTOINC').AsString, LDatasetAuxiliar.FieldByName('MCA_DTAREC').AsDateTime);

            If blnConfirma And
               (Not TShopeeFuncoes.fEmptyStr(LDatasetAuxiliar.FieldByName('CAR_PORBAD').AsString)) Then
            Begin
              LBanMcaDS.strIdenti := 'VALSTA';
              LBanMcaDS.strAutInc := TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

              Inc64(objSequencias.intContadorAutIncBanMca);

              LListaBanMca := TListaBanMCA.Create;
              LListaBanMca.Add(LBanMcaDS);

              {*****************************************}
              {* GRAVA MOVBAN DO CARTÃO (DEBITO)       *}
              {**************************************MV*}
              LSeqLanDebito := TLibCartoesMovBan.GravaMovBan(LDatasetAuxiliar.FieldByName('CAR_CTABAD').AsString,  // Centro de Custo
                                                           LDatasetAuxiliar.FieldByName('CAR_PORBAD').AsString,  // Portador
                                                           VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                           LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                           TShopeeFuncoes.fTime(),                              // Hora do Lançamento
                                                           FNumeroDocumento,                            // Documento
                                                           'D',                                  // Credito / Debito
                                                           VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                           LDatasetAuxiliar.FieldByName('MCA_VALSTA').AsFloat +
                                                               Abs(LDatasetAuxiliar.FieldByName('CUPOM_MARKETPLACE').AsFloat),    // Valor Documento
                                                           FHistorico + ' - Ref.Emp. ' + LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,// Historico 1
                                                           '',                                   // Historico 2
                                                           LDatasetAuxiliar.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                                           '',                                   // Fornecedor
                                                           '',                                   // Numero da Duplicata
                                                           0,                                    // Sequencial Duplicata
                                                           '',                                   // Parcela da Duplicata
                                                           LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                                           '',                                   // Série
                                                           LDatasetAuxiliar.FieldByName('CAR_EVEDEB').AsString,  // Codigo do Evento
                                                           '',                                   // Documento da Baixa
                                                           0,
                                                           FCtpCon,
                                                           '',
                                                           '',
                                                           objSequencias.intSeqLan.ToString,
                                                           TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                           '',
                                                           '',
                                                           1,
                                                           True,
                                                           LListaBanMca);

              Inc64(objSequencias.intSeqLan);
              Inc64(objSequencias.intContadorAutIncMovBan);

              blnConfirma := (Not TShopeeFuncoes.fEmptyStr(LSeqLanDebito));
            End;

            {************************************}
            {* SÓ GRAVA TAXA SE VALREC < VALSTA *}
            {*********************************JU*}

            If (LDatasetAuxiliar.FieldByName('MCA_VALTAX').Value <> 0) And (blnConfirma) Then
            Begin
              LBanMcaDS.strIdenti := 'VALTAX';
              LBanMcaDS.strAutInc := TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

              Inc64(objSequencias.intContadorAutIncBanMca);

              LListaBanMca := TListaBanMCA.Create;
              LListaBanMca.Add(LBanMcaDS);

              LValorTotalTaxa := TShopeeFuncoes.fFormataFloat(LDatasetAuxiliar.FieldByName('MCA_VALTAX').AsFloat -
                                                                LDatasetAuxiliar.FieldByName('MCA_ANTTAX').AsFloat, 2);

              If Not FBaixarTaxasAnaliticoMkt Then
                  LValorTotalTaxa := TShopeeFuncoes.fFormataFloat(LValorTotalTaxa +
                                                                        Abs(LDatasetAuxiliar.FieldByName('FRETE_MARKETPLACE').AsFloat) +
                                                                        Abs(LDatasetAuxiliar.FieldByName('AJUSTE_MARKETPLACE').AsFloat), 2);

              {*****************************************}
              {* GRAVA MOVBAN DA TAXA                  *}
              {**************************************MV*}
              LSeqLanTaxa := TLibCartoesMovBan.GravaMovBan(LDatasetAuxiliar.FieldByName('CAR_CTATAX').AsString,  // Centro de Custo
                                                            LDatasetAuxiliar.FieldByName('CAR_PORTAX').AsString,  // Portador
                                                            VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                            LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                            TShopeeFuncoes.fTime(),                              // Hora do Lançamento
                                                            FNumeroDocumento,                            // Documento
                                                            'D',                                  // Credito / Debito
                                                            VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                            LValorTotalTaxa,                      // Valor Documento
                                                            TShopeeFuncoes.IIF(TShopeeFuncoes.fEmptyStr(strHistor), 'Pag. de Taxas Ref. Aos Cartões',
                                                                FHistorico + ' - Ref.Emp. ' + LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString),// Historico 1
                                                            '',                                   // Historico 2
                                                            LDatasetAuxiliar.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                                            LDatasetAuxiliar.FieldByName('CAR_FORTAX').AsString,  // Fornecedor
                                                            '',                                   // Numero da Duplicata
                                                            0,                                    // Sequencial Duplicata
                                                            '',                                   // Parcela da Duplicata
                                                            LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                                            '',                                   // Série
                                                            LDatasetAuxiliar.FieldByName('CAR_EVETAX').AsString,  // Código do Evento
                                                            '',
                                                            0,
                                                            FCtpCon,
                                                            '',
                                                            '',
                                                            objSequencias.intSeqLan.ToString,
                                                            TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                            '',
                                                            '',
                                                            1,
                                                            True,
                                                            LListaBanMca);

              Inc64(objSequencias.intSeqLan);
              Inc64(objSequencias.intContadorAutIncMovBan);

              blnConfirma := (Not TShopeeFuncoes.fEmptyStr(LSeqlanTaxa));

              {************************}
              {* GRAVA CADPAG DA TAXA *}
              {*********************AF*}
              If (blnConfirma) Then
              Begin
                strNumDup := 'G' + TShopeeFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

                LValorTotalCtp := LValorTotalTaxa;
                If FBaixarTaxasAnaliticoMkt Then
                    LValorTotalCtp := TShopeeFuncoes.fFormataFloat(LValorTotalCtp +
                                                                         Abs(LDatasetAuxiliar.FieldByName('FRETE_MARKETPLACE').AsFloat) +
                                                                         Abs(LDatasetAuxiliar.FieldByName('AJUSTE_MARKETPLACE').AsFloat) -
                                                                         Abs(LDatasetAuxiliar.FieldByName('SUBTRAIR_FRETE').AsFloat), 2);

                blnConfirma := TLibCartoesCadPag.GravaCadPag('frmBaixaCartoes',
                                                             'INCLUSAO DA TAXA - CARTOES BX_ANA',
                                                             LDatasetAuxiliar.FieldByName('CAR_FORTAX').AsString,
                                                             strNumDup,
                                                             'A',
                                                             LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,
                                                             LDatasetAuxiliar.FieldByName('CAR_CTATAX').AsString,
                                                             'CRT',
                                                             0,
                                                             LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,
                                                             LDatasetAuxiliar.FieldByName('MCA_DTAREC').AsDateTime,
                                                             0,
                                                             LValorTotalCtp,
                                                             'N',
                                                             'N',
                                                             'N',
                                                             TShopeeFuncoes.IIF(TShopeeFuncoes.fEmptyStr(strHistor), 'Pag. de Taxas Ref. Aos Cartões',
                                                                       FHistorico + ' - Ref.Emp. ' + LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString),
                                                             '',
                                                             'Pag. de Taxas Ref. Aos Cartões',
                                                             LDatasetAuxiliar.FieldByName('CAR_PORTAX').AsString,
                                                             LDatasetAuxiliar.FieldByName('CAR_CTATAX').AsString,
                                                             LSeqLanTaxa,
                                                             VS_FuncoesExternas.fIRetOperadorLogado,
                                                             LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,
                                                             LValorTotalCtp,
                                                             0,
                                                             0,
                                                             VS_FuncoesExternas.fIRetEmpresaLogada,
                                                             LDatasetAuxiliar.FieldByName('CAR_EVETAX').AsString,
                                                             '',
                                                             LDatasetAuxiliar.FieldByName('CAR_PORTAX').AsString,
                                                             '',
                                                             0.0,
                                                             0.0,
                                                             FCtpCon,
                                                             False,
                                                             0,
                                                             '',
                                                             0,
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             LValorTotalCtp,
                                                             0,
                                                             0,
                                                             0,
                                                             '',
                                                             0,
                                                             0,
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '0',
                                                             '',
                                                             '',
                                                             TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada));

                Inc64(objSequencias.intContadorAutIncCadPag);
                Inc64(objSequencias.intContadorAutIncLogCtp);
                Inc64(objSequencias.intSequencialCadPag);

                If blnConfirma Then
                  TBaixaCartoes.GravaCTPDetDeTaxaParaMarketPlaceAnalitico(strNumDup,
                                                                          LDatasetAuxiliar.FieldByName('CAR_FORTAX').AsString,
                                                                          LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,
                                                                          'CRT',
                                                                          LDatasetAuxiliar.FieldByName('CAR_CTATAX').AsString,
                                                                          LDatasetAuxiliar.FieldByName('CAR_EVETAX').AsString,
                                                                          LValorTotalTaxa,
                                                                          FRegistroCTPDetFrete,
                                                                          FRegistroCTPDetAjuste);

              End;
            End;

            {******************************}
            {* GRAVA TAXAS DE ANTECIPAÇÃO *}
            {***************************AJ*}
            If (LDatasetAuxiliar.FieldByName('MCA_ANTTAX').Value <> 0) And (blnConfirma) Then
            Begin
              LBanMcaDS.strIdenti := 'ANTTAX';
              LBanMcaDS.strAutInc := TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_FuncoesExternas.fIRetEmpresaLogada);

              Inc64(objSequencias.intContadorAutIncBanMca);

              LListaBanMca := TListaBanMCA.Create;
              LListaBanMca.Add(LBanMcaDS);

              {*****************************************}
              {* GRAVA MOVBAN DA TAXA DE ANTECIPAÇÃO   *}
              {**************************************AJ*}
              LSeqLanAntecipacao := TLibCartoesMovBan.GravaMovBan(LDatasetAuxiliar.FieldByName('CAR_CTAANT').AsString,  // Centro de Custo
                                                            LDatasetAuxiliar.FieldByName('CAR_PORTAX').AsString,  // Portador
                                                            VS_FuncoesExternas.fIRetOperadorLogado,                // Operador
                                                            LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                                            TShopeeFuncoes.fTime(),                              // Hora do Lançamento
                                                            FNumeroDocumento,                            // Documento
                                                            'D',                                  // Credito / Debito
                                                            VS_FuncoesExternas.fIRetEmpresaLogada,                         // Empresa
                                                            LDatasetAuxiliar.FieldByName('MCA_ANTTAX').AsFloat,    // Valor Documento
                                                            TShopeeFuncoes.IIF(TShopeeFuncoes.fEmptyStr(strHistor), 'Pag. de Tx Antecip. Ref. Aos Cartões',
                                                                'Tx Antecip. ' + FHistorico + ' - Ref.Emp. ' + LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString),// Historico 1
                                                            '',                                   // Historico 2
                                                            LDatasetAuxiliar.FieldByName('MCA_CODCLI').AsString,   // Cliente
                                                            LDatasetAuxiliar.FieldByName('CAR_FORTAX').AsString,  // Fornecedor
                                                            '',                                   // Numero da Duplicata
                                                            0,                                    // Sequencial Duplicata
                                                            '',                                   // Parcela da Duplicata
                                                            LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                                            '',                                   // Série
                                                            '',                                   // Código do Evento
                                                            '',
                                                            0,
                                                            FCtpCon,
                                                            '',
                                                            '',
                                                            objSequencias.intSeqLan.ToString,
                                                            TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                            '',
                                                            '',
                                                            1,
                                                            True,
                                                            LListaBanMca);

              Inc64(objSequencias.intSeqLan);
              Inc64(objSequencias.intContadorAutIncMovBan);

              blnConfirma := (Not TShopeeFuncoes.fEmptyStr(LSeqLanAntecipacao));

              {***************************************}
              {* GRAVA CADPAG DA TAXA DE ANTECIPAÇÃO *}
              {************************************AJ*}
              If (blnConfirma) Then
              Begin
                strNumDup := 'G' + TShopeeFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

                blnConfirma := TLibCartoesCadPag.GravaCadPag('frmBaixaCartoes',
                                                             'INCLUSAO DA TAXA - CARTOES BX_ANA',
                                                             LDatasetAuxiliar.FieldByName('CAR_FORTAX').AsString,
                                                             strNumDup,
                                                             'A',
                                                             LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,
                                                             LDatasetAuxiliar.FieldByName('CAR_CTAANT').AsString,
                                                             'CRT',
                                                             0,
                                                             LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,
                                                             LDatasetAuxiliar.FieldByName('MCA_DTAREC').AsDateTime,
                                                             0,
                                                             LDatasetAuxiliar.FieldByName('MCA_ANTTAX').AsFloat,
                                                             'N',
                                                             'N',
                                                             'N',
                                                             TShopeeFuncoes.IIF(TShopeeFuncoes.fEmptyStr(strHistor), 'Pag. de Tx Atecip. Ref. Aos Cartões',
                                                                       FHistorico + ' - Ref.Emp. ' + LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString),
                                                             '',
                                                             'Pag. de Tx Antecip. Ref. Aos Cartões',
                                                             LDatasetAuxiliar.FieldByName('CAR_PORTAX').AsString,
                                                             LDatasetAuxiliar.FieldByName('CAR_CTAANT').AsString,
                                                             LSeqLanAntecipacao,
                                                             VS_FuncoesExternas.fIRetOperadorLogado,
                                                             LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,
                                                             LDatasetAuxiliar.FieldByName('MCA_ANTTAX').AsFloat,
                                                             0,
                                                             0,
                                                             VS_FuncoesExternas.fIRetEmpresaLogada,
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             0.0,
                                                             0.0,
                                                             FCtpCon,
                                                             False,
                                                             0,
                                                             '',
                                                             0,
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             LDatasetAuxiliar.FieldByName('MCA_ANTTAX').AsFloat,
                                                             0,
                                                             0,
                                                             0,
                                                             '',
                                                             0,
                                                             0,
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '',
                                                             '0',
                                                             '',
                                                             '',
                                                             TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada));

                Inc64(objSequencias.intContadorAutIncCadPag);
                Inc64(objSequencias.intContadorAutIncLogCtp);
                Inc64(objSequencias.intSequencialCadPag);
              End;
            End;

            If FBaixarTaxasAnaliticoMkt Then
            Begin
              If blnConfirma Then
                TBaixaCartoes.GravarMovBanAnalitoFreteTaxasMarketPlace(LDatasetAuxiliar,
                                                                       objSequencias,
                                                                       LSeqLanFrete,
                                                                       LSeqLanAjuste,
                                                                       LSeqLanCupom);
            End;
          End;

          If blnConfirma Then
          Begin

            {*****************************************}
            {* BAIXA UM REGISTRO                     *}
            {**************************************MV*}
            blnConfirma := TLibCartoesMovCar.BaixaCartao('untTShopeeBaixaRecebiveis',
                                                         'BAIXA DE RECEBÍVEIS MARKET PLACE (SHOPEE)',
                                                         LDatasetAuxiliar.FieldByName('AUTOINC').AsString,
                                                         LDatasetAuxiliar.FieldByName('NRODUP').AsString,
                                                         LDatasetAuxiliar.FieldByName('PARDUP').AsString,
                                                         LDatasetAuxiliar.FieldByName('MCA_CODCLI').AsString,
                                                         LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,
                                                         LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value,
                                                         LDatasetAuxiliar.FieldByName('MCA_VALREC').AsFloat,
                                                         VS_FuncoesExternas.fIRetOperadorLogado,
                                                         FHistorico,
                                                         LDatasetAuxiliar.FieldByName('CAR_PORBAI').AsString,
                                                         LDatasetAuxiliar.FieldByName('CAR_CTABAI').AsString,
                                                         LSeqLanCredito,
                                                         LDatasetAuxiliar.FieldByName('CAR_PORTAX').AsString,
                                                         LDatasetAuxiliar.FieldByName('CAR_CTATAX').AsString,
                                                         LSeqLanTaxa,
                                                         LDatasetAuxiliar.FieldByName('CAR_FORTAX').AsString,
                                                         LDatasetAuxiliar.FieldByName('CAR_CTABAD').AsString,
                                                         LDatasetAuxiliar.FieldByName('CAR_PORBAD').AsString,
                                                         LSeqLanDebito,
                                                         LDatasetAuxiliar.FieldByName('MCA_CHACON').AsString,
                                                         LDatasetAuxiliar.FieldByName('CAR_EVEDEB').AsString,
                                                         TShopeeFuncoes.IIF(LDatasetAuxiliar.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                              '', LDatasetAuxiliar.FieldByName('CAR_CTAANT').AsString),
                                                         TShopeeFuncoes.IIF(LDatasetAuxiliar.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                              '', LSeqLanAntecipacao),
                                                         TShopeeFuncoes.IIF(LDatasetAuxiliar.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                                              0, LDatasetAuxiliar.FieldByName('MCA_ANTTAX').AsFloat),
                                                         TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                         LDatasetAuxiliar.FieldByName('CAR_EVECRE').AsString,
                                                         LDatasetAuxiliar.FieldByName('CAR_EVETAX').AsString,
                                                         LDatasetAuxiliar.FieldByName('FRETE_MARKETPLACE').AsFloat,
                                                         LDatasetAuxiliar.FieldByName('AJUSTE_MARKETPLACE').AsFloat,
                                                         LDatasetAuxiliar.FieldByName('MCA_VALTAX').AsFloat,
                                                         LDatasetAuxiliar.FieldByName('CUPOM_MARKETPLACE').AsFloat,
                                                         LDatasetAuxiliar.FieldByName('ALTERAR_BRUTO').AsString.Equals('S'),
                                                         LDatasetAuxiliar.FieldByName('MCA_VALSTA').AsFloat,
                                                         LSeqLanFrete,
                                                         LSeqLanAjuste,
                                                         LSeqLanCupom);

            Inc64(objSequencias.intContadorAutIncLogMca);
          End;

        End;

        If Not blnConfirma Then
          Break;

        LDatasetAuxiliar.Next;
      End;

      If blnConfirma Then
      Begin
        TBaixaCartoes.GravaMovBanDeTransferencias(FDatasetBaixa,
                                                  FObjetoConciliacao.NomeConciliacao,
                                                  objSequencias);

        TBaixaCartoes.MarcarComoConciliado(FObjetoConciliacao,
                                           FDatasetBaixa);
      End;

      Result := blnConfirma;

      If Not Result Then
        Raise Exception.Create('Não foi possível baixar o(s) cartão(ões)!');
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.fIRollBack;
        Result := false;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fGravaCartoes]');
      End;
    End;
  Finally
    FreeAndNil(LDatasetAuxiliar);

    If Assigned(LListaBanMca) Then
      FreeAndNil(LListaBanMca);

    If Assigned(objSequencias) Then
      FreeAndNil(objSequencias);
  End;
end;

function TShopeeBaixaRecebiveis.RealizaBaixaVendasSintetica(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    blnConfirma,
    blnCadPag    : Boolean;
    strNumDup    : String;
    intCont      : Integer;

    LDatasetAuxiliar: TUniClientDataSet;

    objSequencias: TSequenciaisBaixaCartao;

    LValorTotalTaxa,
    LValorBruto,
    LValorTotalCtp: Double;

    LListaBanMca: TListaBanMCA;

    LSeqLanCredito,
    LSeqLanTaxa,
    LSeqLanDebito,
    LSeqLanAntecipacao,
    LSeqLanFrete,
    LSeqLanAjuste,
    LSeqLanCupom,

    strPorCar,
    strCtaCar,
    strPorBad,
    strCtaBad,
    strPorTax,
    strCtaTax,
    strForTax,
    strEventoCredito,
    strEventoTaxa,
    strEveDeb,
    strCtaAnt: String;
begin

  Application.ProcessMessages;
  LSeqLanDebito    := '';
  LSeqLanTaxa := '';
  LSeqLanCredito := '';
  LSeqLanAntecipacao := '';
  strNumDup    := '';
  blnConfirma := True;

  LDatasetAuxiliar := TShopeeFuncoes.CriarClientDataSet(FDatasetBaixa);

  LDatasetAuxiliar.DisableControls;
  LDatasetAuxiliar.Filtered := False;
  LDatasetAuxiliar.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');
  LDatasetAuxiliar.Filtered := True;

  LDatasetAuxiliar.First;

  Try
    Application.ProcessMessages;
    pgbStatus.Position := 0;

    VS_FuncoesExternas.fIStartTransaction;
    FCtpCon := VS_FuncoesExternas.fIRetCtpCon;
    VS_FuncoesExternas.fICommit;

    pCarregaArrBaiSinCar;
    pCarregaArrAjustes;

    pgbStatus.Properties.Max := Length(arrBaiSinCar);

    objSequencias := RetornaSequenciaisParaBaixaSintetica(arrBaiSinCar,
                                                          LDatasetAuxiliar,
                                                          False,
                                                          True,
                                                          FBaixarTaxasAnaliticoMkt,
                                                          Length(arrBaiSinDeb));
    objSequencias.SequencialControleBaixaPagar := FCtpCon;
    objSequencias.NumeroDocumentoBaixa := FNumeroDocumento;

    VS_FuncoesExternas.fIStartTransaction;

    {************************************}
    {* GRAVA OS LANÇAMENTOS DOS AJUSTES *}
    {*********************************AJ*}
    If (Length(arrBaiSinDeb) > 0) Then
    Begin
      TBaixaCartoes.GravaMovBanAjustes(arrBaiSinDeb, objSequencias.intSeqLan, objSequencias.intContadorAutIncMovBan);
      TBaixaCartoes.GravaCadPagAjustes(arrBaiSinDeb, objSequencias.intSequencialCadPag, objSequencias.intContadorAutIncCadPag);

      Inc64(objSequencias.intSeqLan, Length(arrBaiSinDeb));
      Inc64(objSequencias.intSequencialCadPag, Length(arrBaiSinDeb));
      Inc64(objSequencias.intContadorAutIncMovBan, Length(arrBaiSinDeb));
      Inc64(objSequencias.intContadorAutIncCadPag, Length(arrBaiSinDeb));
    End;

    For intCont := 0 To Length(arrBaiSinCar) - 1 Do
    Begin
      If Not blnConfirma Then
        Break;

      strPorCar        := arrBaiSinCar[intCont].strPorBai;
      strCtaCar        := arrBaiSinCar[intCont].strCtaBai;
      strPorBad        := arrBaiSinCar[intCont].strPorBad;
      strCtaBad        := arrBaiSinCar[intCont].strCtaBad;
      strPorTax        := arrBaiSinCar[intCont].strPorTax;
      strCtaTax        := arrBaiSinCar[intCont].strCtaTax;
      strForTax        := arrBaiSinCar[intCont].strForTax;
      strEventoCredito := arrBaiSinCar[intCont].strEventoCredito;
      strEventoTaxa    := arrBaiSinCar[intCont].strEventoTaxa;
      strEveDeb        := arrBaiSinCar[intCont].strEveDeb;
      strCtaAnt        := arrBaiSinCar[intCont].strCtaAnt;

      Inc64(objSequencias.intContadorAutIncBanMca,
            fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                       'VALSTA',
                                       LListaBanMca,
                                       arrBaiSinCar[intCont].dtaDtaRec,
                                       strPorCar,
                                       strCtaCar,
                                       strPorBad,
                                       strCtaBad,
                                       strPorTax,
                                       strCtaTax,
                                       strForTax,
                                       strEventoCredito,
                                       strEventoTaxa,
                                       strEveDeb,
                                       strCtaAnt,
                                       objSequencias.intContadorAutIncBanMca));

      LValorBruto := arrBaiSinCar[intCont].fltValDoc;
      If FBaixarTaxasAnaliticoMkt Then
          LValorBruto := TShopeeFuncoes.fFormataFloat(LValorBruto -
                                                            arrBaiSinCar[intCont].CupomMarketPlace, 2);

      {*****************************************}
      {* GRAVA MOVBAN DO CARTÃO                *}
      {**************************************MV*}
      LSeqLanCredito  := TLibCartoesMovBan.GravaMovBan(strCtaCar,                      // Centro de Custo
                                                     strPorCar,                      // Portador
                                                     VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                     arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                     TShopeeFuncoes.fTime(),                        // Hora do Lançamento
                                                     FNumeroDocumento,                      // Documento
                                                     'C',                            // Credito / Debito
                                                     VS_FuncoesExternas.fIRetEmpresaLogada,                   // Empresa
                                                     LValorBruto,                    // Valor Documento
                                                     FHistorico + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                                     '',                             // Historico 2
                                                     '',                             // Cliente
                                                     '',                             // Fornecedor
                                                     '',                             // Numero da Duplicata
                                                     0,                              // Sequencial Duplicata
                                                     '',                             // Parcela da Duplicata
                                                     arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                                     '',                             // Série
                                                     strEventoCredito,               // Código do Evento
                                                     '',                             // Documento da Baixa
                                                     0,
                                                     FCtpCon,
                                                     '',
                                                     '',
                                                     objSequencias.intSeqLan.ToString,
                                                     TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                     '',
                                                     '',
                                                     1,
                                                     True,
                                                     LListaBanMca);

      Inc64(objSequencias.intSeqLan);
      Inc64(objSequencias.intContadorAutIncMovBan);

      blnConfirma := (Not TShopeeFuncoes.fEmptyStr(LSeqLanCredito));
      arrBaiSinCar[intCont].strSeqLanCre := LSeqLanCredito;

      If (Not TShopeeFuncoes.fEmptyStr(LSeqLanCredito)) And (Not TShopeeFuncoes.fEmptyStr(strPorBad)) Then
      Begin
        Inc64(objSequencias.intContadorAutIncBanMca,
              fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                         'VALSTA',
                                         LListaBanMca,
                                         arrBaiSinCar[intCont].dtaDtaRec,
                                         strPorCar,
                                         strCtaCar,
                                         strPorBad,
                                         strCtaBad,
                                         strPorTax,
                                         strCtaTax,
                                         strForTax,
                                         strEventoCredito,
                                         strEventoTaxa,
                                         strEveDeb,
                                         strCtaAnt,
                                         objSequencias.intContadorAutIncBanMca));

        {*****************************************}
        {* GRAVA MOVBAN DO CARTÃO (DEBITO)       *}
        {**************************************MV*}
        LSeqLanDebito   := TLibCartoesMovBan.GravaMovBan(strCtaBad,                      // Centro de Custo
                                                     strPorBad,                      // Portador
                                                     VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                     arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                     TShopeeFuncoes.fTime(),                        // Hora do Lançamento
                                                     FNumeroDocumento,                      // Documento
                                                     'D',                            // Credito / Debito
                                                     VS_FuncoesExternas.fIRetEmpresaLogada,                   // Empresa
                                                     arrBaiSinCar[intCont].fltValDoc,// Valor Documento
                                                     FHistorico + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                                     '',                             // Historico 2
                                                     '',                             // Cliente
                                                     '',                             // Fornecedor
                                                     '',                             // Numero da Duplicata
                                                     0,                              // Sequencial Duplicata
                                                     '',                             // Parcela da Duplicata
                                                     arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                                     '',                             // Série
                                                     strEveDeb,                      // Código do Evento
                                                     '',                             // Documento da Baixa
                                                     0,
                                                     FCtpCon,
                                                     '',
                                                     '',
                                                     objSequencias.intSeqLan.ToString,
                                                     TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                     '',
                                                     '',
                                                     1,
                                                     True,
                                                     LListaBanMca);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not TShopeeFuncoes.fEmptyStr(LSeqLanDebito));
        arrBaiSinCar[intCont].strSeqLanDeb := LSeqLanDebito;
      End;

      {************************************}
      {* SÓ GRAVA TAXA SE VALREC < VALSTA *}
      {*********************************JU*}

      If (arrBaiSinCar[intCont].fltValTax > 0) And (blnConfirma) Then
      Begin
        Inc64(objSequencias.intContadorAutIncBanMca,
              fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                         'VALTAX',
                                         LListaBanMca,
                                         arrBaiSinCar[intCont].dtaDtaRec,
                                         strPorCar,
                                         strCtaCar,
                                         strPorBad,
                                         strCtaBad,
                                         strPorTax,
                                         strCtaTax,
                                         strForTax,
                                         strEventoCredito,
                                         strEventoTaxa,
                                         strEveDeb,
                                         strCtaAnt,
                                         objSequencias.intContadorAutIncBanMca));

        LValorTotalTaxa := TShopeeFuncoes.fFormataFloat(arrBaiSinCar[intCont].fltValTax -
                                                              arrBaiSinCar[intCont].fltValAnt, 2);

        If Not FBaixarTaxasAnaliticoMkt Then
            LValorTotalTaxa := LValorTotalTaxa +
                               TShopeeFuncoes.fFormataFloat(Abs(arrBaiSinCar[intCont].FreteMarketPlace) +
                                                                  Abs(arrBaiSinCar[intCont].AjusteMarketPlace), 2);

        {*****************************************}
        {* GRAVA MOVBAN DA TAXA                  *}
        {**************************************MV*}
        LSeqLanTaxa := TLibCartoesMovBan.GravaMovBan(strCtaTax,                      // Centro de Custo
                                                      strPorTax,                      // Portador
                                                      VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                      arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                      TShopeeFuncoes.fTime(),                        // Hora do Lançamento
                                                      FNumeroDocumento,                      // Documento
                                                      'D',                            // Credito / Debito
                                                      VS_FuncoesExternas.fIRetEmpresaLogada,                   // Empresa
                                                      LValorTotalTaxa,                // Valor Documento
                                                      FHistorico + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                                      '',                             // Historico 2
                                                      '',                             // Cliente
                                                      strForTax,                      // Fornecedor
                                                      '',                             // Numero da Duplicata
                                                      0,                              // Sequencial Duplicata
                                                      '',                             // Parcela da Duplicata
                                                      arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                                      '',                             // Série
                                                      //'',                           // Sequencial de Lançamento
                                                      strEventoTaxa,                  // Código do Evento
                                                      '',                             // Documento da Baixa
                                                      0,
                                                      FCtpCon,
                                                      '',
                                                      '',
                                                      objSequencias.intSeqLan.ToString,
                                                      TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                      '',
                                                      '',
                                                      1,
                                                      True,
                                                      LListaBanMca);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not TShopeeFuncoes.fEmptyStr(LSeqLanTaxa));
        arrBaiSinCar[intCont].strSeqLanTax := LSeqLanTaxa;

        {************************}
        {* GRAVA CADPAG DA TAXA *}
        {*********************AF*}
        If (blnConfirma) Then
        Begin
          strNumDup := 'G' + TShopeeFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

          LValorTotalCtp := LValorTotalTaxa;
          If FBaixarTaxasAnaliticoMkt Then
              LValorTotalCtp := LValorTotalCtp +
                                TShopeeFuncoes.fFormataFloat(Abs(arrBaiSinCar[intCont].FreteMarketPlace) +
                                                                   Abs(arrBaiSinCar[intCont].AjusteMarketPlace) -
                                                                   Abs(arrBaiSinCar[intCont].SubtrairFrete), 2);

          blnCadPag :=  TLibCartoesCadPag.GravaCadPag('untTShopeeBaixaRecebiveis',
                                          'INCLUSAO TAXA - CARTOES BX_SIN',
                                          strForTax,
                                          strNumDup,
                                          'A',
                                          arrBaiSinCar[intCont].strCodEmp,
                                          strCtaTax,
                                          'CRT',
                                          0,
                                          arrBaiSinCar[intCont].dtaDtaRec,
                                          arrBaiSinCar[intCont].dtaDtaRec,
                                          0,
                                          LValorTotalCtp,
                                          'N',
                                          'N',
                                          'N',
                                          FHistorico + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                          '',
                                          FHistorico + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                          strPorTax,
                                          strCtaTax,
                                          LSeqLanTaxa,
                                          VS_FuncoesExternas.fIRetOperadorLogado,
                                          arrBaiSinCar[intCont].dtaDtaRec,
                                          LValorTotalCtp,
                                          0,
                                          0,
                                          VS_FuncoesExternas.fIRetEmpresaLogada,
                                          strEventoTaxa,
                                          '',
                                          strPorTax,
                                          FNumeroDocumento,
                                          0.0,
                                          0.0,
                                          FCtpCon,
                                          False,
                                          0,
                                          '',
                                          0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          LValorTotalCtp,
                                          0,
                                          0,
                                          0,
                                          '',
                                          0,
                                          0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '0',
                                          '',
                                          '',
                                          TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada));

          Inc64(objSequencias.intContadorAutIncCadPag);
          Inc64(objSequencias.intContadorAutIncLogCtp);
          Inc64(objSequencias.intSequencialCadPag);

          blnConfirma := blnCadPag;

          If blnConfirma Then
            TBaixaCartoes.GravaCTPDetDeTaxaParaMarketPlaceSintetico(strNumDup,
                                                                    strForTax,
                                                                    arrBaiSinCar[intCont].strCodEmp,
                                                                    'CRT',
                                                                    arrBaiSinCar[intCont],
                                                                    FCTPDetSintetico);
        End;
      End;

      {*********************************}
      {* GRAVA A TAXA DE ANTECIPAÇÃO   *}
      {******************************AJ*}
      If (arrBaiSinCar[intCont].fltValAnt > 0) And (blnConfirma) Then
      Begin
        Inc64(objSequencias.intContadorAutIncBanMca,
              fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                         'VALSTA',
                                         LListaBanMca,
                                         arrBaiSinCar[intCont].dtaDtaRec,
                                         strPorCar,
                                         strCtaCar,
                                         strPorBad,
                                         strCtaBad,
                                         strPorTax,
                                         strCtaTax,
                                         strForTax,
                                         strEventoCredito,
                                         strEventoTaxa,
                                         strEveDeb,
                                         strCtaAnt,
                                         objSequencias.intContadorAutIncBanMca));

        {***************************************}
        {* GRAVA MOVBAN DA TAXA DE ANTECIPAÇÃO *}
        {************************************AJ*}
        LSeqLanAntecipacao := TLibCartoesMovBan.GravaMovBan(strCtaAnt,                      // Centro de Custo
                                                      strPorTax,                      // Portador
                                                      VS_FuncoesExternas.fIRetOperadorLogado,          // Operador
                                                      arrBaiSinCar[intCont].dtaDtaRec,// Data do Lançamento
                                                      TShopeeFuncoes.fTime(),                        // Hora do Lançamento
                                                      FNumeroDocumento,                      // Documento
                                                      'D',                            // Credito / Debito
                                                      VS_FuncoesExternas.fIRetEmpresaLogada,                   // Empresa
                                                      arrBaiSinCar[intCont].fltValAnt,// Valor Documento
                                                      'Tx Antecip. ' + FHistorico + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                                      '',                             // Historico 2
                                                      '',                             // Cliente
                                                      strForTax,                      // Fornecedor
                                                      '',                             // Numero da Duplicata
                                                      0,                              // Sequencial Duplicata
                                                      '',                             // Parcela da Duplicata
                                                      arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                                      '',                             // Série
                                                      '',                             // Código do Evento
                                                      '',                             // Documento da Baixa
                                                      0,
                                                      FCtpCon,
                                                      '',
                                                      '',
                                                      objSequencias.intSeqLan.ToString,
                                                      TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                      '',
                                                      '',
                                                      1,
                                                      True,
                                                      LListaBanMca);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not TShopeeFuncoes.fEmptyStr(LSeqLanAntecipacao));
        arrBaiSinCar[intCont].strSeqLanAnt := LSeqLanAntecipacao;

        {***************************************}
        {* GRAVA CADPAG DA TAXA DE ANTECIPAÇÃO *}
        {************************************AJ*}
        If (blnConfirma) Then
        Begin
          strNumDup := 'G' + TShopeeFuncoes.fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

          blnCadPag :=  TLibCartoesCadPag.GravaCadPag('untTShopeeBaixaRecebiveis',
                                                      'INCLUSAO TAXA - CARTOES BX_SIN',
                                                      strForTax,
                                                      strNumDup,
                                                      'A',
                                                      arrBaiSinCar[intCont].strCodEmp,
                                                      strCtaAnt,
                                                      'CRT',
                                                      0,
                                                      arrBaiSinCar[intCont].dtaDtaRec,
                                                      arrBaiSinCar[intCont].dtaDtaRec,
                                                      0,
                                                      arrBaiSinCar[intCont].fltValAnt,
                                                      'N',
                                                      'N',
                                                      'N',
                                                      'Tx Antecip. ' + FHistorico + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                                      '',
                                                      'Tx Antecip. ' + FHistorico + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                                      strPorTax,
                                                      strCtaAnt,
                                                      LSeqLanTaxa,
                                                      VS_FuncoesExternas.fIRetOperadorLogado,
                                                      arrBaiSinCar[intCont].dtaDtaRec,
                                                      arrBaiSinCar[intCont].fltValAnt,
                                                      0,
                                                      0,
                                                      VS_FuncoesExternas.fIRetEmpresaLogada,
                                                      '',
                                                      '',
                                                      '',
                                                      FNumeroDocumento,
                                                      0.0,
                                                      0.0,
                                                      FCtpCon,
                                                      False,
                                                      0,
                                                      '',
                                                      0,
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      arrBaiSinCar[intCont].fltValAnt,
                                                      0,
                                                      0,
                                                      0,
                                                      '',
                                                      0,
                                                      0,
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      '',
                                                      '0',
                                                      '',
                                                      '',
                                                      TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_FuncoesExternas.fIRetEmpresaLogada));

          Inc64(objSequencias.intContadorAutIncCadPag);
          Inc64(objSequencias.intContadorAutIncLogCtp);
          Inc64(objSequencias.intSequencialCadPag);

          blnConfirma := blnCadPag;
        End;
      End;

      If FBaixarTaxasAnaliticoMkt Then
      Begin
        TBaixaCartoes.GravarMovBanSinteticoFreteTaxasMarketPlace(LListaBanMca,
                                                                 objSequencias,
                                                                 arrBaiSinCar[intCont],
                                                                 FHistorico,
                                                                 LSeqLanFrete,
                                                                 LSeqLanAjuste,
                                                                 LSeqLanCupom);

        arrBaiSinCar[intCont].SeqLanFreteMkt := LSeqLanFrete;
        arrBaiSinCar[intCont].SeqLanAjusteMkt := LSeqLanAjuste;
        arrBaiSinCar[intCont].SeqLanCupomMkt := LSeqLanCupom;
      End;

      TShopeeFuncoes.pStepStatusGravacao(pgbStatus);
    End;


    LDatasetAuxiliar.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_PORBAD;CAR_CTABAD;'+
                              'CAR_PORTAX;CAR_CTATAX;CAR_FORTAX;CAR_EVEDEB;CAR_EVECRE;CAR_EVETAX';
    intCont := 0;

    LDatasetAuxiliar.First;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max :=  LDatasetAuxiliar.RecordCount;

    While (Not LDatasetAuxiliar.Eof) And (blnConfirma) Do
    Begin
      TShopeeFuncoes.pStepStatusGravacao(pgbStatus);

      //Acha a empresa para gravar os dados corretos
      If (arrBaiSinCar[intCont].strCodEmp        <> LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString) Or
         (arrBaiSinCar[intCont].dtaDtaRec        <> LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value) Or
         (arrBaiSinCar[intCont].strPorBai        <> LDatasetAuxiliar.FieldByName('CAR_PORBAI').AsString) Or
         (arrBaiSinCar[intCont].strCtaBai        <> LDatasetAuxiliar.FieldByName('CAR_CTABAI').AsString) Or
         (arrBaiSinCar[intCont].strPorBad        <> LDatasetAuxiliar.FieldByName('CAR_PORBAD').AsString) Or
         (arrBaiSinCar[intCont].strCtaBad        <> LDatasetAuxiliar.FieldByName('CAR_CTABAD').AsString) Or
         (arrBaiSinCar[intCont].strPorTax        <> LDatasetAuxiliar.FieldByName('CAR_PORTAX').AsString) Or
         (arrBaiSinCar[intCont].strCtaTax        <> LDatasetAuxiliar.FieldByName('CAR_CTATAX').AsString) Or
         (arrBaiSinCar[intCont].strForTax        <> LDatasetAuxiliar.FieldByName('CAR_FORTAX').AsString) Or
         (arrBaiSinCar[intCont].strEventoCredito <> LDatasetAuxiliar.FieldByName('CAR_EVECRE').AsString) Or
         (arrBaiSinCar[intCont].strEventoTaxa    <> LDatasetAuxiliar.FieldByName('CAR_EVETAX').AsString) Or
         (arrBaiSinCar[intCont].strEveDeb        <> LDatasetAuxiliar.FieldByName('CAR_EVEDEB').AsString) Or
         (arrBaiSinCar[intCont].strCtaAnt        <> LDatasetAuxiliar.FieldByName('CAR_CTAANT').AsString) Then
      Begin
        For intCont := 0 to Length(arrBaiSinCar) - 1 Do
        Begin
          If (arrBaiSinCar[intCont].strCodEmp        = LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString) And
             (arrBaiSinCar[intCont].dtaDtaRec        = LDatasetAuxiliar.FieldByName('MCA_DTAREC').Value)    And
             (arrBaiSinCar[intCont].strPorBai        = LDatasetAuxiliar.FieldByName('CAR_PORBAI').AsString) And
             (arrBaiSinCar[intCont].strCtaBai        = LDatasetAuxiliar.FieldByName('CAR_CTABAI').AsString) And
             (arrBaiSinCar[intCont].strPorBad        = LDatasetAuxiliar.FieldByName('CAR_PORBAD').AsString) And
             (arrBaiSinCar[intCont].strCtaBad        = LDatasetAuxiliar.FieldByName('CAR_CTABAD').AsString) And
             (arrBaiSinCar[intCont].strPorTax        = LDatasetAuxiliar.FieldByName('CAR_PORTAX').AsString) And
             (arrBaiSinCar[intCont].strCtaTax        = LDatasetAuxiliar.FieldByName('CAR_CTATAX').AsString) And
             (arrBaiSinCar[intCont].strForTax        = LDatasetAuxiliar.FieldByName('CAR_FORTAX').AsString) And
             (arrBaiSinCar[intCont].strEventoCredito = LDatasetAuxiliar.FieldByName('CAR_EVECRE').AsString) And
             (arrBaiSinCar[intCont].strEventoTaxa    = LDatasetAuxiliar.FieldByName('CAR_EVETAX').AsString) And
             (arrBaiSinCar[intCont].strEveDeb        = LDatasetAuxiliar.FieldByName('CAR_EVEDEB').AsString) And
             (arrBaiSinCar[intCont].strCtaAnt        = LDatasetAuxiliar.FieldByName('CAR_CTAANT').AsString) Then
            Break;
        End;
      End;

      If (LDatasetAuxiliar.FieldByName('MCA_MARDES').AsString = 'M') And (LDatasetAuxiliar.FieldByName('MCA_AJUSTE').AsString = 'N') Then
      Begin
        {*****************************************}
        {* BAIXA UM REGISTRO                     *}
        {**************************************MV*}
        blnConfirma := TLibCartoesMovCar.BaixaCartao('untTShopeeBaixaRecebiveis',
                                                     'BAIXA DE RECEBÍVEIS MARKET PLACE (SHOPEE)',
                                                     LDatasetAuxiliar.FieldByName('AUTOINC').AsString,
                                                     LDatasetAuxiliar.FieldByName('NRODUP').AsString,
                                                     LDatasetAuxiliar.FieldByName('PARDUP').AsString,
                                                     LDatasetAuxiliar.FieldByName('MCA_CODCLI').AsString,
                                                     LDatasetAuxiliar.FieldByName('MCA_CODEMP').AsString,
                                                     arrBaiSinCar[intCont].dtaDtaRec,
                                                     LDatasetAuxiliar.FieldByName('MCA_VALREC').AsFloat,
                                                     VS_FuncoesExternas.fIRetOperadorLogado,
                                                     FHistorico,
                                                     arrBaiSinCar[intCont].strPorBai,
                                                     arrBaiSinCar[intCont].strCtaBai,
                                                     arrBaiSinCar[intCont].strSeqLanCre,
                                                     arrBaiSinCar[intCont].strPorTax,
                                                     arrBaiSinCar[intCont].strCtaTax,
                                                     arrBaiSinCar[intCont].strSeqLanTax,
                                                     arrBaiSinCar[intCont].strForTax,
                                                     arrBaiSinCar[intCont].strCtaBad,
                                                     arrBaiSinCar[intCont].strPorBad,
                                                     arrBaiSinCar[intCont].strSeqLanDeb,
                                                     LDatasetAuxiliar.FieldByName('MCA_CHACON').AsString,
                                                     arrBaiSinCar[intCont].strEveDeb,
                                                     TShopeeFuncoes.IIF(LDatasetAuxiliar.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                          '', arrBaiSinCar[intCont].strCtaAnt),
                                                     TShopeeFuncoes.IIF(LDatasetAuxiliar.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                          '', arrBaiSinCar[intCont].strSeqLanAnt),
                                                     TShopeeFuncoes.IIF(LDatasetAuxiliar.FieldByName('MCA_ANT_SN').AsString = 'N',
                                                          0, LDatasetAuxiliar.FieldByName('MCA_ANTTAX').AsFloat),
                                                     TShopeeFuncoes.fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_FuncoesExternas.fIRetEmpresaLogada),
                                                     arrBaiSinCar[intCont].strEventoCredito,
                                                     arrBaiSinCar[intCont].strEventoTaxa,
                                                     LDatasetAuxiliar.FieldByName('FRETE_MARKETPLACE').AsFloat,
                                                     LDatasetAuxiliar.FieldByName('AJUSTE_MARKETPLACE').AsFloat,
                                                     LDatasetAuxiliar.FieldByName('MCA_VALTAX').AsFloat,
                                                     LDatasetAuxiliar.FieldByName('CUPOM_MARKETPLACE').AsFloat,
                                                     LDatasetAuxiliar.FieldByName('ALTERAR_BRUTO').AsString.Equals('S'),
                                                     LDatasetAuxiliar.FieldByName('MCA_VALSTA').AsFloat,
                                                     arrBaiSinCar[intCont].SeqLanFreteMkt,
                                                     arrBaiSinCar[intCont].SeqLanAjusteMkt,
                                                     arrBaiSinCar[intCont].SeqLanCupomMkt);

        Inc64(objSequencias.intContadorAutIncLogMca);

        If (blnConfirma) Then
           pAtualizaDataMovimentobancarioMovCar(LDatasetAuxiliar.FieldByName('AUTOINC').AsString, arrBaiSinCar[intCont].dtaDtaRec);
      End;

      If Not blnConfirma Then
        Break;

      LDatasetAuxiliar.Next;
    End;

    If blnConfirma Then
      TBaixaCartoes.GravaMovBanDeTransferencias(FDatasetBaixa,
                                                FObjetoConciliacao.NomeConciliacao,
                                                objSequencias);

    If (blnConfirma) Then
      TBaixaCartoes.MarcarComoConciliado(FObjetoConciliacao,
                                         FDatasetBaixa);

    SetLength(arrBaiSinCar, 0);

    If Not blnConfirma Then
      Raise Exception.Create('Não foi possível baixar o(s) cartão(ões)!');

    Result := True;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollBack;
      Result := false;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fGravaCartoesSin]');
      FreeAndNil(LDatasetAuxiliar);

      If Assigned(FCloneDataset) Then
        FreeAndNil(FCloneDataset);

      Exit;
    End;
  End;

  FreeAndNil(LDatasetAuxiliar);

  If Assigned(FCloneDataset) Then
    FreeAndNil(FCloneDataset);

  If Assigned(objSequencias) Then
    FreeAndnIl(objSequencias);
end;

function TShopeeBaixaRecebiveis.RetornaSequenciaisParaBaixaAnalitica(
  ADataset: TDataset; ABaixaManual, ABaixaRegistroDebito,
  ATaxasDesmembradas: Boolean;
  AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;
begin
  Result := TSequenciaisBaixaCartao.Create;

  ADataset.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND ' +
                       'MCA_AJUSTE = ' + QuotedStr('N') + ' AND ' +
                       'MCA_VALREC > 0';

  //Crédito
  Result.intSeqLan               := ADataset.RecordCount;
  Result.intSequencialCadPag     := 0;
  Result.intContadorAutIncBanMca := 0;

  //Para baixa manual
  If ABaixaManual Then
  Begin
    If ABaixaRegistroDebito Then
      Inc64(Result.intSeqLan, ADataset.RecordCount);

    ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_VALTAX > 0';
    Inc64(Result.intSeqLan, ADataset.RecordCount);
    Inc64(Result.intSequencialCadPag, ADataset.RecordCount);

    Inc64(Result.intContadorAutIncBanMca, Result.intSeqLan);
  End
  //Para baixa via conciliação automática
  Else
  Begin
    //Débito
    ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND CAR_PORBAD IS NOT NULL AND MCA_VALREC > 0';
    Inc64(Result.intSeqLan, ADataset.RecordCount);

    //Taxa
    ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_VALTAX > 0 AND MCA_VALREC > 0';
    Inc64(Result.intSeqLan, ADataset.RecordCount);
    Inc64(Result.intSequencialCadPag, ADataset.RecordCount);

    If ATaxasDesmembradas Then
    Begin
      //Fretes
      ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND FRETE_MARKETPLACE > 0 AND MCA_VALREC > 0';
      Inc64(Result.intSeqLan, ADataset.RecordCount);

      //Ajustes Mkt
      ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND AJUSTE_MARKETPLACE > 0 AND MCA_VALREC > 0';
      Inc64(Result.intSeqLan, ADataset.RecordCount);

      //Cupons
      ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND CUPOM_MARKETPLACE > 0 AND MCA_VALREC > 0';
      Inc64(Result.intSeqLan, ADataset.RecordCount);
    End;

    //Antecipação
    ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_ANTTAX > 0 AND MCA_VALREC > 0';
    Inc64(Result.intSeqLan, ADataset.RecordCount);
    Inc64(Result.intSequencialCadPag, ADataset.RecordCount);

    Inc64(Result.intContadorAutIncBanMca, Result.intSeqLan);

    //Ajustes
    Inc64(Result.intSeqLan, AQuantidadeAjustes);
    Inc64(Result.intSequencialCadPag, AQuantidadeAjustes);

    //Transferências
    ADataset.Filter  := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA = ''S'' ';
    Inc64(Result.intSeqLan, ADataset.RecordCount * 2);
  End;

  ADataset.Filter := 'MCA_MARDES=' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');

  Result.intContadorAutIncLogMca := ADataset.RecordCount;

  Result.intContadorAutIncBanMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('BANMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncBanMca), 4, 14).ToInt64;
  Result.intContadorAutIncMovBan := Copy(VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncLogMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncLogMca), 4, 14).ToInt64;
  Result.intContadorAutIncCadPag := Copy(VS_FuncoesExternas.fIRetAutoIncrem('CADPAG', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;
  Result.intContadorAutIncLogCTP := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGCTP', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;

  Result.intSeqLan := VS_FuncoesExternas.fISeqContaBanco(Result.intSeqLan).ToInt64;
  If Result.intSequencialCadPag > 0 Then
    Result.intSequencialCadPag := Copy(VS_FuncoesExternas.fIRetSequencialCadPag(Result.intSequencialCadPag), 2).ToInt64;
end;

function TShopeeBaixaRecebiveis.RetornaSequenciaisParaBaixaSintetica(
  ARegistros: array of TArrBaiSinCar; ADataset: TDataset; ABaixaManual,
  ABaixaRegistroDebito, ATaxasDesmembradas: Boolean;
  AQuantidadeAjustes: Integer): TSequenciaisBaixaCartao;
  Var
    LRegistro: TArrBaiSinCar;
begin
  Result := TSequenciaisBaixaCartao.Create;

  //Crédito
  Result.intSeqLan := Length(ARegistros);
  Result.intSequencialCadPag     := 0;
  Result.intContadorAutIncBanMca := 0;

  For LRegistro In ARegistros Do
  Begin
    Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);

    //Debito
    If (Not TShopeeFuncoes.fEmptyStr(LRegistro.strPorBad)) Then
    Begin
      Inc64(Result.intSeqLan);
      Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
    End;

    //Taxa
    If LRegistro.fltValTax > 0 Then
    Begin
      Inc64(Result.intSeqLan);
      Inc64(Result.intSequencialCadPag);
      Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
    End;

    If ATaxasDesmembradas Then
    Begin
      //Fretes
      If LRegistro.FreteMarketPlace > 0 Then
      Begin
        Inc64(Result.intSeqLan);
        Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
      End;

      //Ajustes Mkt
      If LRegistro.AjusteMarketPlace > 0 Then
      Begin
        Inc64(Result.intSeqLan);
        Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
      End;

      //Cupons
      If LRegistro.CupomMarketPlace > 0 Then
      Begin
        Inc64(Result.intSeqLan);
        Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
      End;
    End;

    //Antecipação
    If LRegistro.fltValAnt > 0 Then
    Begin
      Inc64(Result.intSeqLan);
      Inc64(Result.intSequencialCadPag);
      Inc64(Result.intContadorAutIncBanMca, LRegistro.intQtdCar);
    End;
  End;

  //Ajustes
  Inc64(Result.intSeqLan, AQuantidadeAjustes);
  Inc64(Result.intSequencialCadPag, AQuantidadeAjustes);

  //Transferências
  ADataset.Filter := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA = ''S'' ';
  Inc64(Result.intSeqLan, ADataset.RecordCount * 2);

  ADataset.Filter := 'MCA_MARDES = ''M'' AND MCA_AJUSTE = ''N'' ';
  Result.intContadorAutIncLogMca := ADataset.RecordCount;

  Result.intContadorAutIncBanMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('BANMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncBanMca), 4, 14).ToInt64;
  Result.intContadorAutIncMovBan := Copy(VS_FuncoesExternas.fIRetAutoIncrem('MOVBAN', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSeqLan), 4, 14).ToInt64;
  Result.intContadorAutIncLogMca := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGMCA', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intContadorAutIncLogMca), 4, 14).ToInt64;
  Result.intContadorAutIncCadPag := Copy(VS_FuncoesExternas.fIRetAutoIncrem('CADPAG', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;
  Result.intContadorAutIncLogCTP := Copy(VS_FuncoesExternas.fIRetAutoIncrem('LOGCTP', VS_FuncoesExternas.fIRetEmpresaLogada, Result.intSequencialCadPag), 4, 14).ToInt64;

  Result.intSeqLan := VS_FuncoesExternas.fISeqContaBanco(Result.intSeqLan).ToInt64;
  If Result.intSequencialCadPag > 0 Then
    Result.intSequencialCadPag := Copy(VS_FuncoesExternas.fIRetSequencialCadPag(Result.intSequencialCadPag), 2).ToInt64;

  ADataset.Filter   := 'MCA_MARDES = ''M'' AND MCA_AJUSTE = ''N'' ';
end;

function TShopeeBaixaRecebiveis.TodosOsCentroDeCustosPreenchidos: Boolean;
Begin
  Result := True;

  Try
    FDatasetBaixa.First;
    While Not FDatasetBaixa.Eof do
    begin
      If FDatasetBaixa.FieldByName('MCA_AJUSTE').AsString.Equals('S') Then
      Begin
        If FDatasetBaixa.FieldByName('MCA_EVECAN').AsString.IsEmpty Then
          Result := False;
      End
      Else
      Begin
        If FDatasetBaixa.FieldByName('CAR_EVECRE').AsString.IsEmpty Then
          Result := False;

        If FDatasetBaixa.FieldByName('CAR_EVETAX').AsString.IsEmpty Then
          Result := False;

        If Not FDatasetBaixa.FieldByName('CAR_PORBAD').AsString.IsEmpty Then
        Begin
          If FDatasetBaixa.FieldByName('CAR_EVEDEB').AsString.IsEmpty Then
            Result := False;
        End;
      End;

      If Not Result Then
        Exit;

      FDatasetBaixa.Next;
    end;
  Finally
    FDatasetBaixa.First;
  End;
end;

function TShopeeBaixaRecebiveis.ValidacoesParaBaixa: Boolean;
  Var
    LPortadoresSemPermissao: String;
begin
  Result := True;

  If FaltaPortadoresEPlanosDeContasParaBaixa Then
  Begin
    TShopeeFuncoes.fMensagem('ATENÇÃO', 'Para a Baixa de Recebíveis automática, é necessário que todos os cartões selecionados estejam com as configurações de Portadores e Planos de Contas configurados.' + #13 +
                                        'Para cancelamentos/ajustes, as configurações de ajustes e saques devem estar preenchidas.',
                                        ['&OK'], 1, False, 1, 0, False, 0);
    Exit(False);
  End;

  If PossuiPortadorSemPermissao(LPortadoresSemPermissao) Then
  Begin
    TShopeeFuncoes.fMensagem('ATENÇÃO', 'O(s) portador(res) ' + LPortadoresSemPermissao + ' não possui(em) permissão para realizar baixa!',['&OK']);
    Exit(False);
  End;

  If VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean) Then
  Begin
    If Not TodosOsCentroDeCustosPreenchidos Then
    Begin
      TShopeeFuncoes.fMensagem('ATENÇÃO', 'Para a Baixa de Recebíveis automática, é necessário que todos os cartões selecionados '+
                                          'estejam com os Centro de Custos configurados. ' +
                                          'Para cancelamentos/ajustes, as configurações de Centro de Custos estejam parametrizados'+
                                          'na empresa correspondente.',
                                          ['&OK']);
      Exit(False);
    End;
  End;

  If TBaixaCartoes.VerificaSeHaCartoesBaixadosAntesDaBaixa(FDatasetBaixa) Then
  Begin
    TShopeeFuncoes.fMensagem('ATENÇÃO!', 'Existem registros que serão baixados que foram baixados por outro usuário. ' +
                                         'Carregue o período novamente para reprocessar a baixa!', ['&OK']);
    Exit(False);
  End;
end;

end.
