{***************************************}
{* Classe para Conciliação dos Cartões *}
{* de Crédito                          *}
{************************************AJ*}
unit untMobbuyConciliacaoCartoes;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, Vcl.Controls, System.Math,
     System.Generics.Collections,

     Uni, UniClientDataSet, cxProgressBar, frxClass, frxDBSet,MemDS,

     untLibCartoesInterfacesTipos, untTLockLibCartoes, untTMobbuyFuncoes;

Type
  TRelatorioConciliacao = class
  public
    AutoIncremRelatorio,
    ChaveRelatorio,
    CodigoOperador,
    Operadora,
    TipoRelatorio,
    FiltrosRelatorio: String;

    DataRelatorio,
    HoraRelatorio: TDateTime;

    constructor Create(ACodigoOperador,
                       AOperadora,
                       ATipoRelatorio,
                       AFiltrosRelatorio: String;
                       ADataRelatorio,
                       AHoraRelatorio: TDateTime);
  End;

  TItensRelatorioCartoes = class
  private
  public
    NomeArquivo,
    Descricao,
    CodigoEstabelecimento,
    CodigoEmpresa,
    NumeroNSU,
    CodigoAutorizacao,
    Parcela,
    TotalParcelas: String;

    DataPagamento,
    DataVenda,
    DataVencimento: TDateTime;

    ValorBruto,
    ValorLiquido,
    ValorTaxas,
    ValorFrete,
    ValorAjustes,
    ValorCupom,
    PercentualTaxa: Double;

    ResumoVenda,
    NumeroCartao,
    CodigoBandeira,
    DescricaoBandeira,
    TipoCartao,
    TipoDoRegistro,
    SomarNoTotal,
    RegistroIncompleto,
    PortadorDebito,
    PortadorCredito,

    RegistroNegociacao,
    NumeroNegociacao,
    PlanoContasTaxaNegociacao,

    DescricaoAjuste,

    ChavePrimaria,

    AutoIncremMovCar: String;

    Conciliado: Integer;

    constructor Create;
  End;

  TListaRegistrosRelatorio = TObjectList<TItensRelatorioCartoes>;

type TConciliacaoCartoes = class
  cdsConCar,                             //DATASET DOS ARQUIVOS IMPORTADOS
  cdsAjustes:  TUniClientDataSet;        //DATASET AJUSTES/CANCELAMENTOS

  FBandeiraCartao: String;
  objConcil  : TCamposConcil;

  blnAutomatica: Boolean;

  FTextoInconsistencia: String;

  FConciliacaoComPixAtivado: Boolean;
  LConciliacaoComBoletoAtivado: Boolean;

  FLiberacaoTransferencia: Boolean;

  FFiltrarAutorizacaoNSU: Boolean;

  FRelatorioConciliacao: TRelatorioConciliacao;

  FListaRegistrosRelatorio: TListaRegistrosRelatorio;

  FBaixarAjustes,
  FObrigatorioCentroDeCustos: Boolean;

  FConfiguracaoTaxaAdministrativa: String;

  FFiltrosRelatorio: TFiltrosRelatorioBaixaCartoes;

  procedure pFiltraCartoes;
  procedure pFiltraCartoesBaixados(AApenasNaoValidados: Boolean = False);

  procedure MarcarCartaoEncontradoAPI(AValorRecebido: Double;
                                      ARegistroAntecipado: Boolean;
                                      var ARegistroRelatorio: TItensRelatorioCartoes;
                                      AChaveConciliacao: String;
                                      ADataPagamento: TDateTime;
                                      ADatasetRegistro: TDataset;
                                      ATaxaDeAntecipacao: Double = 0);

  procedure pAcertaDadosDeBaixaOtimizadaPorEmpresa;

  Function fCartaoBloqueado(qryMovCar: TDataSet): Boolean;

  function fBuscaCartao(strNumCCD,
                        strNumNSU,
                        strCodEmp,
                        strParcel: String;
                        dtaDtaCup: TDateTime;
                        intConcil: Integer = 0;
                        blnPesquisaBaixado: Boolean = False;
                        AValorBruto: Double = 0.00): Boolean;

  function fBuscaCartaoBaixado(strNumCCD,
                               strNumNSU,
                               strCodEmp,
                               strParcel: String;
                               dtaDtaCup: TDateTime;
                               blnValidaValorBruto: Boolean = False;
                               AValorBruto: Double = 0.00): Boolean;

  function fDigPeriodo(strDescricaoLabel: String = ''): Boolean;

  function fRetNomBandeira(strNumCar: String;
                           ATipoCartao: String = ''): String;

  function GeraRelatorioConciliacao(ANomCon: String; pgbStatus: TcxProgressBar): Boolean;

  function fRetPesqPonVen(intTipo: Integer = 0): String;

  function RetornaCodigosEstabelecimentosLocateIn(ARetornarIn: Boolean = True): String;

  procedure GravarRegistroDeAjusteParaConciliacao(ARegistroRelatorio: TItensRelatorioCartoes;
                                                  AGravaCampoValorBruto: Boolean = False;
                                                  ADatasetNegociacao: TDataset = Nil);

  function fRetornaChaveConciliacao(cdsDataset: TDataset): String;

  function PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto: Double;
                                                             ARegistro: TDataSet;
                                                             APercentual: Boolean = True): Boolean;
  function RetornaTaxaParaValidacao:Double;
  function RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa:String;
  function RetornaTextoInconsistenciaAtualizado(ATextoInconsistencia: String): String;

  function fRetornaDadosDeBaixaDosAjustes(strConfiguracao,
                                          strEmpresaConfiguracao: String): String;

  function RetornaValorTolerancia(ACodEmp: String;ADefault: Double = 0): Double ;

  function fExisteEstabelecimentosDuplicados(var AConfiguracao: String): Boolean;

  function ConfiguracoesAjustesEstaoIncompletas(ACodigoEmpresa: String): String;

  function GravarRegistrosRelatorio(prgStatus: TcxProgressBar): Boolean;

  procedure RemoverRelatorioConciliacao(AUnitRemocao: String);

  function RetornaFiltrosDigitados: String;

  private
    FCartoesConciliar: String;
    FExibirCartoesPendente: Boolean;
    FLancarAjustesACredito: Boolean;
    FTemAjusteACredito: Boolean;

    procedure DeletarValoresLiquidosZerados(ADataset: TUniClientDataset; AFieldName: string);
  protected
    dtaDtaIni,
    dtaDtaFim,
    dtaDtaPag  : TDate;
    lstDtaCad  : TStringList;
    arrPonVen,
    arrEmpresa: TConsultasArray;
    strRcxTcc,
    strResumo,
    strDtaIni,
    strDtaFim,
    strCondicao: String;

    FAjustesJaConciliados  : Boolean;

    property CartoesConciliar: String read FCartoesConciliar write FCartoesConciliar;

  public
    cdsBaiCar,                    //DATASET PARA MARCAÇÃO DE REGISTROS CONCILIADOS
    cdsBaixad: TUniCLientDataSet; //DATASET PARA BUSCAR SE FOI BAIXADO

    FPossuiInconsistencia: Boolean;
    blnReabre   : Boolean;
    strNomCon   : String;

    FobjLockEstabelecimento: TLock;

    constructor Create;
    destructor Destroy; override;

    function fConciliaCartoes: Boolean; virtual;

    property DataInicialConciliacao: TDate Read  dtaDtaIni;
    property DataFinalConciliacao  : TDate Read  dtaDtaFim;
    property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente;

    property FiltrosRelatorio: TFiltrosRelatorioBaixaCartoes Read FFiltrosRelatorio;
end;

implementation

uses  untLibCartoesFiltroInconsistencias, untMobbuyDigPeriodo,
     untLibCartoesGravando, untTLibCartoesMovCar, untLibCartoesConstantes;

function TConciliacaoCartoes.ConfiguracoesAjustesEstaoIncompletas(
  ACodigoEmpresa: String): String;
begin
  Result := 'S';

  If ACodigoEmpresa.Trim.IsEmpty Then
    Exit;

  If TMobbuyFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TMobbuyFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TMobbuyFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If Not FObrigatorioCentroDeCustos Then
    Exit('N');

  If TMobbuyFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString, ACodigoEmpresa)) Then
    Exit;

  Result := 'N';
end;


constructor TConciliacaoCartoes.Create;
begin
  blnReabre  := False;

  FListaRegistrosRelatorio := TListaRegistrosRelatorio.Create;

  FAjustesJaConciliados := True;
  blnAutomatica  := False;

  FLancarAjustesACredito := TMobbuyFuncoes.RetornaValorCfg('CFG_AJUCRE').Equals('S');
  FTemAjusteACredito := False;

  FConciliacaoComPixAtivado := False;
  LConciliacaoComBoletoAtivado := False;

  FCartoesConciliar := '';

  FLiberacaoTransferencia := TMobbuyFuncoes.RetornaValorCfg('CFG_USAAUT').Equals('S');

  FFiltrarAutorizacaoNSU := False;

  objConcil.CodigoEmpresaFixaParaBaixa := '';

  FBaixarAjustes := VS_FuncoesExternas.fICfgSis('BAIDEB', varBoolean);
  FObrigatorioCentroDeCustos := VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean);

  FConfiguracaoTaxaAdministrativa := TMobbuyFuncoes.RetornaValorCfg('CFG_VLDTAX');
end;

procedure TConciliacaoCartoes.DeletarValoresLiquidosZerados(
  ADataset: TUniClientDataset; AFieldName: string);
begin
  ADataset.First;
  try
    while not ADataset.Eof do
    begin
      if TMobbuyFuncoes.fStrToFloat(ADataset.FieldByName(AFieldName).AsString) = 0 then
        ADataset.Delete
      else
        ADataset.Next;
    end;
  finally
    ADataset.First;
  end;
end;

destructor TConciliacaoCartoes.Destroy;
begin
  TMobbuyFuncoes.FreeAndNilDatasets(cdsAjustes);
  TMobbuyFuncoes.FreeAndNilDatasets(cdsBaiCar);
  TMobbuyFuncoes.FreeAndNilDatasets(cdsBaixad);

  If Assigned(lstDtaCad) Then
    FreeAndNil(lstDtaCad);

  If Assigned(FRelatorioConciliacao) Then
    FreeAndNil(FRelatorioConciliacao);

  If Assigned(FListaRegistrosRelatorio) Then
    FreeAndNil(FListaRegistrosRelatorio);

  inherited;
end;

function TConciliacaoCartoes.fDigPeriodo(strDescricaoLabel: String = ''): Boolean;
var
  frmMobbuyDigPeriodo: TfrmMobbuyDigPeriodo;
  LConfiguracoesValidadasEstabelecimento: String;

  LContadorItem: Integer;
Begin
  LConfiguracoesValidadasEstabelecimento := objConcil.CfgEstabelecimentos;

  If fExisteEstabelecimentosDuplicados(LConfiguracoesValidadasEstabelecimento) Then
  Begin
    LConfiguracoesValidadasEstabelecimento :=
      LConfiguracoesValidadasEstabelecimento
        .Replace(' ', '')
        .Replace('(', '')
        .Replace(')', '')
        .Replace(',', '/');

    TMobbuyFuncoes.fMensagem('AVISO',
                             'Existe o mesmo código de estabelecimento da ' +
                             objConcil.NomeConciliacao + ' configurado para uma ' +
                             ' ou mais empresas.' + #13 +
                             'Verifique a(s) configuração(ões) '+
                             LConfiguracoesValidadasEstabelecimento + '.' + #13 +
                             'Para empresas que não possuem código de ' +
                             'estabelecimento, deixe a configuração em branco.' + #13 +
                             'A operação foi cancelada.', ['&Ok'], 0, False, 1, 220);
    blnReabre := False;
    Result    := False;
    Exit;
  End;

  frmMobbuyDigPeriodo := Nil;

  Result := False;
  While Not Result Do
  Begin
    Try
      TMobbuyFuncoes.pCriarFormularios(TfrmMobbuyDigPeriodo, frmMobbuyDigPeriodo);
      frmMobbuyDigPeriodo.Caption   := 'Conciliação de Cartões';
      frmMobbuyDigPeriodo.objConcil := objConcil;
      If Not strDescricaoLabel.IsEmpty Then
        frmMobbuyDigPeriodo.lblPeriodoConciliacao.Caption := strDescricaoLabel;

      frmMobbuyDigPeriodo.ShowModal;
      If Not frmMobbuyDigPeriodo.blnConfirma Then
      Begin
        frmMobbuyDigPeriodo.objLockEstabelecimento.pDestravarTodos;
        Exit;
      End;

      //Data e array para filtrar os registros de arquivos de conciliação
      dtaDtaIni := StrtoDate(frmMobbuyDigPeriodo.mskDtaIniConcil.Text);
      dtaDtaFim := StrtoDate(frmMobbuyDigPeriodo.mskDtaFinConcil.Text);
      strDtaIni := frmMobbuyDigPeriodo.mskDtaIniConcil.Text;
      strDtaFim := frmMobbuyDigPeriodo.mskDtaFinConcil.Text;

      SetLength(arrEmpresa, Length(frmMobbuyDigPeriodo.arrEmpresa));
      For LContadorItem := 0 To High(frmMobbuyDigPeriodo.arrEmpresa) Do
        arrEmpresa[LContadorItem].strCodigo := frmMobbuyDigPeriodo.arrEmpresa[LContadorItem].strCodigo;

      SetLength(arrPonVen, Length(frmMobbuyDigPeriodo.arrPonVen));
      For LContadorItem := 0 To High(frmMobbuyDigPeriodo.arrPonVen) Do
        arrPonVen[LContadorItem].strCodigo := frmMobbuyDigPeriodo.arrPonVen[LContadorItem].strCodigo;

      FobjLockEstabelecimento := frmMobbuyDigPeriodo.objLockEstabelecimento;
    Finally
      If Assigned(frmMobbuyDigPeriodo) Then
        FreeAndNil(frmMobbuyDigPeriodo);

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;

    If dtaDtaFim - dtaDtaIni > 365 Then
      TMobbuyFuncoes.fMensagem('ATENÇÃO', 'O filtro para conciliação não pode ser maior que 365 dias (1 ano)!', ['&OK'])
    Else
      Result := True;
  End;
End;

function TConciliacaoCartoes.fRetPesqPonVen(intTipo: Integer = 0): String;
  Var
    intCont: Integer;

    LEstabelecimentos: String;
begin
  //intTipo= 0 Conciliacao - =1 Cancelamento
  Result := '';

  If (High(arrEmpresa) < 0) And (High(arrPonVen) < 0) Then
    Exit;

  Result := Result + ' AND (';

  If intTipo = 0 Then
  Begin
    If (High(arrEmpresa) >= 0) Then
    Begin
      Result := Result + ' EMP_CODEMP IN (';
      For intCont := 0 To High(arrEmpresa) Do
        Result := Result + '"' + arrEmpresa[intCont].strCodigo + '",';
      Result := Copy(Result, 1, Length(Result) - 1) + ') ';
    End;
  End
  Else
  Begin
    If (High(arrEmpresa) >= 0) Then
    Begin
      LEstabelecimentos := RetornaCodigosEstabelecimentosLocateIn;

      Result := Result + ' ' + objConcil.CampoEstabelecimento + ' IN (' + LEstabelecimentos + ') ';
    End;
  End;

  If (High(arrPonVen) >= 0) Then
  Begin
    Result := ' AND ( (' + objConcil.CampoEstabelecimento + ' IN (';
    For intCont := 0 To High(arrPonVen) Do
      Result := Result + '"' + arrPonVen[intCont].strCodigo + '",';
    Result := Copy(Result, 1, Length(Result) - 1) + ') ) ';
  End;

  Result := Result + ') ';
end;

procedure TConciliacaoCartoes.GravarRegistroDeAjusteParaConciliacao(
  ARegistroRelatorio: TItensRelatorioCartoes;
  AGravaCampoValorBruto: Boolean = False; ADatasetNegociacao: TDataset = Nil);
begin
  If ARegistroRelatorio.Conciliado = 1 Then
    Exit;

  If Not FBaixarAjustes Then
    Exit;

  cdsBaiCar.Last;
  cdsBaiCar.Append;
  cdsBaiCar.FieldByName('AUTOINC').AsString     := VS_FuncoesExternas.fIRetEmpresaLogada +
                                                   TMobbuyFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 10) +
                                                   TMobbuyFuncoes.fRetSomenteNumeros(ARegistroRelatorio.Parcela) +
                                                   VS_FuncoesExternas.fIRetEmpresaLogada;

  cdsBaiCar.FieldByName('NRODUP').AsString      := TMobbuyFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 06);
  cdsBaiCar.FieldByName('PARDUP').AsString      := TMobbuyFuncoes.fGetLetraAlfa(StrtoInt(ARegistroRelatorio.Parcela));
  cdsBaiCar.FieldByName('MCA_NUMDUP').AsString  := cdsBaiCar.FieldByName('NRODUP').AsString +
                                                   cdsBaiCar.FieldByName('PARDUP').AsString;
  cdsBaiCar.FieldByName('EMPLOC').AsString      := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_CODEMP').AsString  := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_EMPRCX').AsString  := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime := ARegistroRelatorio.DataPagamento;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat   := 0.00;

  cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat   := ARegistroRelatorio.ValorLiquido;
  If AGravaCampoValorBruto Then
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat   := ARegistroRelatorio.ValorBruto;

  cdsBaiCar.FieldByName('MCA_VALORI').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat   := 0.000000;
  cdsBaiCar.FieldByName('MCA_CODCLI').AsString  := '00000000';
  cdsBaiCar.FieldByName('CLI_NOMCLI').AsString  := ARegistroRelatorio.DescricaoAjuste;
  cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime := ARegistroRelatorio.DataVenda;
  cdsBaiCar.FieldByName('MCA_NUMCCD').AsString  := ARegistroRelatorio.CodigoAutorizacao;
  cdsBaiCar.FieldByName('MCA_RESCAI').AsInteger := 0;
  cdsBaiCar.FieldByName('MCA_CODCAR').Clear;
  cdsBaiCar.FieldByName('CAR_DESCAR').Clear;

  cdsBaiCar.FieldByName('MCA_NUMNSU').AsString  := TMobbuyFuncoes.fStrZero(ARegistroRelatorio.NumeroNSU, 14);

  cdsBaiCar.FieldByName('MCA_DTACUP').AsDateTime := ARegistroRelatorio.DataVenda;
  cdsBaiCar.FieldByName('MCA_MARDES').AsString  := 'M';
  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ARegistroRelatorio.DataPagamento;
  cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_AJUTOT').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_AJUSEL').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_ZERATX').AsString  := 'S';
  cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_SELQTD').AsInteger := 0;
  cdsBaiCar.FieldByName('MCA_AJUSTE').AsString  := 'S';
  cdsBaiCar.FieldByName('MCA_ESTABE').AsString  := ARegistroRelatorio.CodigoEstabelecimento;

  cdsBaiCar.FieldByName('CAR_PORBAI').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorAjustes, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('CAR_PORTAX').Clear;
  cdsBaiCar.FieldByName('CAR_PORBAD').Clear;
  cdsBaiCar.FieldByName('CAR_FORTAX').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgFornecedorAjustes, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('FOR_NOMFOR').AsString  := TMobbuyFuncoes.IIF(cdsBaiCar.FieldByName('CAR_FORTAX').AsString.IsEmpty, '', TMobbuyFuncoes.RetornaNomeFornecedor(cdsBaiCar.FieldByName('CAR_FORTAX').AsString));
  cdsBaiCar.FieldByName('CAR_CTABAI').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasAjustes, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('CAR_CTATAX').Clear;
  cdsBaiCar.FieldByName('CAR_CTABAD').Clear;
  cdsBaiCar.FieldByName('CAR_EVEDEB').Clear;
  cdsBaiCar.FieldByName('MCA_EVECAN').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.strEventoCancelamentoAjuste, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('SIT_CAD').AsString     := 'COMPLETO';
  If ARegistroRelatorio.RegistroIncompleto.Equals('S') Then
    cdsBaiCar.FieldByName('SIT_CAD').AsString     := 'INCOMPLETO';

  cdsBaiCar.FieldByName('HISTORICO_BAIXA').Clear;

  cdsBaiCar.FieldByName('NEGOCIACAO').AsString  := 'N';
  If ARegistroRelatorio.RegistroNegociacao.Equals('S') Then
  Begin
    cdsBaiCar.FieldByName('NEGOCIACAO').AsString  := 'S';
    cdsBaiCar.FieldByName('NUMEROOPERACAO').AsString := ARegistroRelatorio.NumeroNegociacao;
  End;

  cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'N';

  If Not TMobbuyFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
  Begin
    If ARegistroRelatorio.RegistroNegociacao.Equals('S') Then
    Begin
      If Assigned(ADatasetNegociacao) Then
      Begin
        cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(ADatasetNegociacao);
        cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat := TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                                                cdsBaiCar.FieldByName('MCA_VALORI').AsFloat, 2);
        cdsBaiCar.FieldByName('PLANODECONTASTXNEGOCIACAO').AsString := ARegistroRelatorio.PlanoContasTaxaNegociacao;
      End;
    End
    Else
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(cdsAjustes);
  End;

  cdsBaiCar.Post;

  FAjustesJaConciliados := False;
end;

function TConciliacaoCartoes.GravarRegistrosRelatorio(prgStatus: TcxProgressBar): Boolean;
  Var
    LInserir: TUniQuery;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Result := False;

  If FListaRegistrosRelatorio.Count = 0 Then
    Exit(True);

  prgStatus.Properties.Max := FListaRegistrosRelatorio.Count;
  prgStatus.Position := 0;

  LInserir := Nil;
  Try
    LInserir := VS_FuncoesExternas.fICriaQuery;
    VS_FuncoesExternas.fIStartTransaction;
    Try
      LInserir.SQL.Text := 'SELECT * FROM REL_CONITE WHERE FALSE';
      LInserir.Open;

      For LRegistroRelatorio In FListaRegistrosRelatorio Do
      Begin
        LInserir.Append;

        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_RELINC', FRelatorioConciliacao.AutoIncremRelatorio);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_NOMARQ', LRegistroRelatorio.NomeArquivo);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEST', LRegistroRelatorio.CodigoEstabelecimento);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEMP', LRegistroRelatorio.CodigoEmpresa);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESCRI', LRegistroRelatorio.Descricao);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNSU', LRegistroRelatorio.NumeroNSU);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODAUT', LRegistroRelatorio.CodigoAutorizacao);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_PARCEL', LRegistroRelatorio.Parcela);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_TOTPAR', LRegistroRelatorio.TotalParcelas);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAPAG', LRegistroRelatorio.DataPagamento);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTA_CV', LRegistroRelatorio.DataVenda);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAVEN', LRegistroRelatorio.DataVencimento);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_RESVEN', LRegistroRelatorio.ResumoVenda);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODBAN', LRegistroRelatorio.CodigoBandeira);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESBAN', LRegistroRelatorio.DescricaoBandeira);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_SEQMCA', LRegistroRelatorio.AutoIncremMovCar);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMCAR', LRegistroRelatorio.NumeroCartao);

        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALBRU', LRegistroRelatorio.ValorBruto);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALLIQ', LRegistroRelatorio.ValorLiquido);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALTAX', LRegistroRelatorio.ValorTaxas);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALFRE', LRegistroRelatorio.ValorFrete);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALAJU', LRegistroRelatorio.ValorAjustes);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_PERTAX', LRegistroRelatorio.PercentualTaxa);

        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPCAR', LRegistroRelatorio.TipoCartao);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREG', LRegistroRelatorio.TipoDoRegistro);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_SOMTOT', LRegistroRelatorio.SomarNoTotal);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_INCOMP', LRegistroRelatorio.RegistroIncompleto);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORDEB', LRegistroRelatorio.PortadorDebito);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORCRE', LRegistroRelatorio.PortadorCredito);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_REGNEG', LRegistroRelatorio.RegistroNegociacao);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNEG', LRegistroRelatorio.NumeroNegociacao);
        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESAJU', LRegistroRelatorio.DescricaoAjuste);

        TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_CONCIL', LRegistroRelatorio.Conciliado);

        LInserir.Post;

        If Not FPossuiInconsistencia Then
          FPossuiInconsistencia := MatchStr(LRegistroRelatorio.TipoDoRegistro, ['INCONSISTENCIA', 'AJUSTE','AJUSTES']);

        TMobbuyFuncoes.pStepStatusGravacao(prgStatus);
      End;

      VS_FuncoesExternas.fICommit;

      Result := True;
    Except
      VS_FuncoesExternas.fIRollback;

      Raise;
    End;
  Finally
    TMobbuyFuncoes.FreeAndNilDatasets(LInserir);
  End;
end;

procedure TConciliacaoCartoes.MarcarCartaoEncontradoAPI(AValorRecebido: Double;
  ARegistroAntecipado: Boolean; var ARegistroRelatorio: TItensRelatorioCartoes;
  AChaveConciliacao: String; ADataPagamento: TDateTime; ADatasetRegistro: TDataset;
  ATaxaDeAntecipacao: Double);
  Var
    LValorTaxa,
    LValorAjuste: Double;

    LParcelaDivergenteSemTaxa: Boolean;
begin
  If fCartaoBloqueado(cdsBaiCar) Then
  Begin
    ARegistroRelatorio.Descricao := 'Cartões recebidos pelo Caixa e não transferidos';
    ARegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
    ARegistroRelatorio.CodigoAutorizacao := cdsBaiCar.FieldByName('MCA_NUMNSU').AsString;
    ARegistroRelatorio.DataVenda := cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime;
    ARegistroRelatorio.DataVencimento := cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime;
    ARegistroRelatorio.ValorBruto := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    ARegistroRelatorio.ValorLiquido := cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat;
    ARegistroRelatorio.ValorTaxas := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
    ARegistroRelatorio.PercentualTaxa := TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                                        cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat * 100, 6);
    ARegistroRelatorio.AutoIncremMovCar := cdsBaiCar.FieldByName('AUTOINC').AsString;

    Exit;
  End;

  LValorAjuste := TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) - TMobbuyFuncoes.fFormataFloat(AValorRecebido, 2);
  LValorTaxa := TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat, 2);

  LParcelaDivergenteSemTaxa := LValorAjuste < 0;
  If LParcelaDivergenteSemTaxa Then
    LParcelaDivergenteSemTaxa := LValorTaxa = 0;

  cdsBaiCar.Edit;

  If Not TMobbuyFuncoes.fEmptyStr(AChaveConciliacao) Then
  Begin
    cdsBaiCar.FieldByName('MCA_ESTABE').AsString := ADatasetRegistro.FieldByName('MOB_NUM_PV').AsString;
    cdsBaiCar.FieldByName('MCA_CHACON').AsString := AChaveConciliacao;
  End;

  cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'M';
  If LParcelaDivergenteSemTaxa Then
  Begin
    If Not FBaixarAjustes Then
      cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'D';
  End;

  If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
  Begin
    ARegistroRelatorio.Descricao := EmptyStr;
    ARegistroRelatorio.TipoDoRegistro := 'PAGAMENTO';

    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := TMobbuyFuncoes.IIF(LParcelaDivergenteSemTaxa,
                                                                          TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat,2),
                                                                          TMobbuyFuncoes.fFormataFloat(AValorRecebido, 2));

    cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ADataPagamento;

    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

    If (Not LParcelaDivergenteSemTaxa) Then
      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat  := TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                                           TMobbuyFuncoes.fFormataFloat(AValorRecebido, 2), 2);

    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                       cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;
    If ARegistroAntecipado Then
    Begin
      cdsBaiCar.FieldByName('MCA_ANT_SN').AsString := 'S';
      cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat  := AValorRecebido;
      cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat  := TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                      AValorRecebido - LValorTaxa, 2);
      If cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat <= 0 Then
        cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := 0;

      If ATaxaDeAntecipacao > 0 Then
        cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := ATaxaDeAntecipacao;

      cdsBaiCar.FieldByName('MCA_TAXANT').AsFloat  := TMobbuyFuncoes.fFormataFloat(LValorTaxa, 2);
    End;

    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TMobbuyFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

    If Not TMobbuyFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(ADatasetRegistro);
  End;

  ARegistroRelatorio.AutoIncremMovCar := cdsBaiCar.FieldByName('AUTOINC').AsString;

  cdsBaiCar.Post;

  If LParcelaDivergenteSemTaxa Then
  Begin
    ARegistroRelatorio.Descricao := 'Parcela com divergência de valor';
    ARegistroRelatorio.TipoCartao := 'AJUSTE DE PARCELA';
    ARegistroRelatorio.TipoDoRegistro := 'AJUSTES';
  End;
end;

function TConciliacaoCartoes.fRetNomBandeira(strNumCar: String;
  ATipoCartao: String = ''): String;
begin

  If Not TMobbuyFuncoes.fEmptyStr(FBandeiraCartao) Then
    Exit(FBandeiraCartao);

  //Visa
  If (LeftStr(strNumCar, 1) = '4') And
     (Length(strNumCar) In [13, 16, 19]) Then
    Result := 'VISA'
  Else
  //Master
  If ((Pos(LeftStr(strNumCar, 2), '51_52_53_54_55_') > 0) Or
      (Pos(LeftStr(strNumCar, 4), '2221_2720_2307_') > 0) And
      (Length(strNumCar) = 16)) Or
     (Pos(LeftStr(strNumCar, 4), '6036_') > 0) Then
  Begin
    Result := 'MASTERCARD';

    If ATipoCartao = 'DÉBITO' Then
      Result := 'MAESTRO';
  End
  Else
  //Banricompras
  If (LeftStr(strNumCar, 6) = '639664') Then
    Result := 'BANRICOMPAS'
  Else
  //VerdeCard
  If (LeftStr(strNumCar, 6) = '627894') Then
    Result := 'VERDECARD'
  Else
  //BanriCard
  If (LeftStr(strNumCar, 6) = '608718') Then
    Result := 'BANRICARD'
  else
  //Maestro
  If ((Pos(LeftStr(strNumCar, 2), '50_56_57_58_') > 0) Or (LeftStr(strNumCar, 1) = '6')) And
     (Length(strNumCar) = 16) Then
    Result := 'MAESTRO'
  Else
  //American Express
  If (Pos(LeftStr(strNumCar, 2), '34_37_') > 0) Then
    Result := 'AMERICAN EXPRESS'
  Else
  //Diners
  If (Pos(LeftStr(strNumCar, 3), '300_301_302_303_304_305_309_') > 0) Or
     (Pos(LeftStr(strNumCar, 2), '36_38_39') > 0) And
     (Length(strNumCar) In [14, 16, 17, 18, 19]) Then
    Result := 'DINERS'
  Else
  //Elo
  If (Pos(LeftStr(strNumCar, 4), '4011_4576_5067_') > 0) Or
     (Pos(LeftStr(strNumCar, 6), '636368_438935_504175_451416_636297_506699_') > 0) Then
    Result := 'ELO'
  Else
  //Hipercard
  If (Pos(LeftStr(strNumCar, 4), '3841_6062_') > 0) Then
    Result := 'HIPERCARD'
  Else
  //Aura
  If (LeftStr(strNumCar, 2) = '50') Then
    Result := 'AURA'
  Else
  //BANESCARD
  If (Pos('585988',strNumCar) > 0) Then
    Result := 'BANESCARD'

  //Não conhecido
  Else
  Begin
    Result := 'OUTROS';

    If Pos('PIX', strNumCar) > 0 Then
      Result := 'PIX'
    Else If Pos('BOLETO', strNumCar) > 0 Then
      Result := 'BOLETO';

  End;
end;

function TConciliacaoCartoes.fRetornaChaveConciliacao(cdsDataset: TDataset): String;
  Var
    stlCampos: TStringList;
    strCampo : String;
begin
  Result := '';

  If TMobbuyFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
    Exit;

  If Not Assigned(cdsDataset) Then
    Exit;

  If cdsDataset.IsEmpty Then
    Exit;

  stlCampos := Nil;
  Try
    stlCampos := TStringList.Create;
    stlCampos.Delimiter     := ',';
    stlCampos.DelimitedText := objConcil.strChavePrimaria;

    For strCampo in stlCampos Do
    Begin
      If cdsDataset.FieldByName(strCampo).DataType in [ftString, ftBlob, ftMemo] Then
        Result := Result + cdsDataset.FieldByName(strCampo).AsString.QuotedString + '|'
      Else if cdsDataset.FieldByName(strCampo).DataType in [ftDate] Then
        Result := Result + FormatDateTime('yyyy/mm/dd', cdsDataset.FieldByName(strCampo).AsDateTime).QuotedString + '|'
      Else if cdsDataset.FieldByName(strCampo).DataType in [ftDateTime] Then
        Result := Result + FormatDateTime('yyyy/mm/dd hh:mm:ss', cdsDataset.FieldByName(strCampo).AsDateTime).QuotedString + '|'
      Else if cdsDataset.FieldByName(strCampo).DataType in [ftFloat] Then
        Result := Result + StringReplace(StringReplace(cdsDataset.FieldByName(strCampo).AsString, '.', EmptyStr, [rfReplaceAll]), ',', '.', [rfReplaceAll]) + '|'
      Else
        Result := Result + cdsDataset.FieldByName(strCampo).AsString + '|';
    End;

    Result := LeftStr(Result, Result.Length - 1);
  Finally
    If Assigned(stlCampos) Then
      FreeAndNil(stlCampos);
  End;
end;

function TConciliacaoCartoes.fRetornaDadosDeBaixaDosAjustes(strConfiguracao, strEmpresaConfiguracao: String): String;
begin
  Result := '';

  If Not TMobbuyFuncoes.fEmptyStr(strEmpresaConfiguracao) Then
    Result := VS_FuncoesExternas.fICfgSis(strConfiguracao, varString, strEmpresaConfiguracao);
end;

procedure TConciliacaoCartoes.pAcertaDadosDeBaixaOtimizadaPorEmpresa;
  Var
    qryConsulta: TUniQuery;

    strCodigoCartao,
    strIndiceAnterior: String;

    blnIncompleto,
    blnCentoDeCustoObrigatorio,
    LEmpresaLocalizada: Boolean;
begin
  If cdsBaiCar.IsEmpty Then
    Exit;

  blnCentoDeCustoObrigatorio := VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean);

  strCodigoCartao := '';
  qryConsulta := Nil;
  Try
    qryConsulta := VS_FuncoesExternas.fICriaQuery;

    qryConsulta.SQL.Text := 'SELECT * FROM CONPOR WHERE CON_CODCAR=:CODCAR ORDER BY CON_CODEMP';

    strIndiceAnterior := cdsBaiCar.IndexFieldNames;
    cdsBaiCar.IndexFieldNames := 'MCA_CODCAR';

    cdsBaiCar.First;
    While Not cdsBaiCar.Eof Do
    Begin
      Application.ProcessMessages;

      If Not cdsBaicar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
      Begin
        cdsBaicar.Next;
        Continue;
      End;

      If cdsBaicar.FieldByName('MCA_CODCAR').AsString <> strCodigoCartao Then
      Begin
        strCodigoCartao := cdsBaicar.FieldByName('MCA_CODCAR').AsString;

        qryConsulta.Close;
        qryConsulta.ParamByName('CODCAR').AsString := strCodigoCartao;
        qryConsulta.Open;
      End;

      If (Not qryConsulta.IsEmpty) Then
      Begin
        If objConcil.TabelaConciliacao.Equals('MOB_APPGTO') and (objConcil.CodigoEmpresaFixaParaBaixa <> '') Then
          LEmpresaLocalizada := qryConsulta.Locate('CON_CODEMP', objConcil.CodigoEmpresaFixaParaBaixa,[])
        Else
          LEmpresaLocalizada := qryConsulta.Locate('CON_CODEMP', cdsBaicar.FieldByName('MCA_CODEMP').AsString,[]);

        If (LEmpresaLocalizada) Then
        Begin
          cdsBaiCar.Edit;

          If Not (Assigned(cdsBaiCar.FindField('PORTADOR_GRAVAME')) And
                  Not cdsBaiCar.FieldByName('PORTADOR_GRAVAME').AsString.IsEmpty) Then
          Begin
            cdsBaiCar.FieldByName('CAR_PORBAI').AsString := qryConsulta.FieldByName('CON_PORCRE').AsString;
            cdsBaiCar.FieldByName('CAR_PORTAX').AsString := qryConsulta.FieldByName('CON_PORTAX').AsString;
          End;

          cdsBaiCar.FieldByName('CAR_PORBAD').AsString := qryConsulta.FieldByName('CON_PORDEB').AsString;
          cdsBaiCar.FieldByName('CAR_CTABAI').AsString := qryConsulta.FieldByName('CON_CTACRE').AsString;
          cdsBaiCar.FieldByName('CAR_CTATAX').AsString := qryConsulta.FieldByName('CON_CTATAX').AsString;
          cdsBaiCar.FieldByName('CAR_CTABAD').AsString := qryConsulta.FieldByName('CON_CTADEB').AsString;
          cdsBaiCar.FieldByName('CAR_CTAANT').AsString := qryConsulta.FieldByName('CON_CTAANT').AsString;
          cdsBaiCar.FieldByName('CAR_EVECRE').AsString := qryConsulta.FieldByName('CON_EVECRE').AsString;
          cdsBaiCar.FieldByName('CAR_EVETAX').AsString := qryConsulta.FieldByName('CON_EVETAX').AsString;
          cdsBaiCar.FieldByName('CAR_EVEDEB').AsString := qryConsulta.FieldByName('CON_EVEDEB').AsString;
          cdsBaiCar.FieldByName('CAR_FORTAX').AsString := qryConsulta.FieldByName('CON_FORTAX').AsString;
          cdsBaiCar.FieldByName('CAR_CTACUP').AsString := qryConsulta.FieldByName('CON_CTACUP').AsString;
          cdsBaiCar.FieldByName('FOR_NOMFOR').AsString := TMobbuyFuncoes.RetornaNomeFornecedor(qryConsulta.FieldByName('CON_FORTAX').AsString);

          cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString := TMobbuyFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVECRE').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString    := TMobbuyFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVETAX').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString  := TMobbuyFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVEDEB').AsString);

          cdsBaiCAr.FieldByName('SIT_CAD').AsString := 'COMPLETO';
          blnIncompleto := (cdsBaiCAr.FieldByName('CAR_PORBAI').AsString.IsEmpty) OR
                           (cdsBaiCAr.FieldByName('CAR_CTABAI').AsString.IsEmpty) OR
                           (cdsBaiCAr.FieldByName('CAR_PORTAX').AsString.IsEmpty) OR
                           (cdsBaiCAr.FieldByName('CAR_CTATAX').AsString.IsEmpty) OR
                           (cdsBaiCAr.FieldByName('CAR_FORTAX').AsString.IsEmpty);

          If (blnCentoDeCustoObrigatorio) And (Not blnIncompleto)  then
            blnIncompleto :=  (cdsBaiCAr.FieldByName('CAR_EVECRE').AsString.IsEmpty) OR
                              (cdsBaiCAr.FieldByName('CAR_EVETAX').AsString.IsEmpty) OR
                              ((Not cdsBaiCAr.FieldByName('CAR_PORBAD').AsString.IsEmpty) AND
                               (cdsBaiCAr.FieldByName('CAR_EVEDEB').AsString.IsEmpty));

          If blnIncompleto Then
            cdsBaiCAr.FieldByName('SIT_CAD').AsString := 'INCOMPLETO';

          cdsBaicar.Post;
        End;
      End;

      cdsBaiCar.Next;
    End;
  Finally
    cdsBaiCar.IndexFieldNames := strIndiceAnterior;

    TMobbuyFuncoes.FreeAndNilDatasets(qryConsulta);
  End;
end;
 
function TConciliacaoCartoes.fBuscaCartao(strNumCCD, strNumNSU, strCodEmp,
  strParcel: String; dtaDtaCup: TDateTime; intConcil: Integer = 0;
  blnPesquisaBaixado: Boolean = False; AValorBruto: Double = 0.00): Boolean;
  Var
    LChaveCompletaSemEmpresa: Boolean;
    LTolerancia : Double;

    LValorBruto: Double;
begin
  Result := False;

  LValorBruto := 0.00;
  If blnPesquisaBaixado Then
  Begin
    LValorBruto := cdsConCar.FieldByName(objConcil.CampoValorBruto).AsFloat;
    If AValorBruto <> 0.00 Then
      LValorBruto := AValorBruto;
  End;

  If intConcil <> 0 Then
  Begin
    If blnPesquisaBaixado Then
    Begin
      If fBuscaCartaoBaixado(strNumCCD, strNumNsu, strCodEmp, strParcel, dtaDtaCup, True) Then
      Begin
        FTextoInconsistencia := 'Cartão já foi baixado';

        Exit;
      End;
    End;
  End;

  LChaveCompletaSemEmpresa := False;
  LTolerancia := RetornaValorTolerancia(strCodEmp,0.2999999);

  If Not strCodEmp.IsEmpty Then
    Result := TMobbuyFuncoes.IIF((Not TMobbuyFuncoes.fEmptyStr(strNumCCD) And Not TMobbuyFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                  False);

  If Not Result Then
  Begin
    Result := TMobbuyFuncoes.IIF((Not TMobbuyFuncoes.fEmptyStr(strNumCCD) And Not TMobbuyFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, 'D']),[]),
                  False);

    LChaveCompletaSemEmpresa := Result;
  End;

  If (Not TMobbuyFuncoes.fEmptyStr(strCodEmp)) And (Not LChaveCompletaSemEmpresa) Then
  Begin
    If Not Result Then
      Result := TMobbuyFuncoes.IIF(Not TMobbuyFuncoes.fEmptyStr(strNumCCD),
                    cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                    False);

    {********************************************
    {* ALGUMAS OPERADORAS UTILIZAM O MESMO NSU  *
    {* MUITAS VEZES. ENTÃO, ANTES DE PESQUISAR  *
    {* PELO NSU, VERIFICA SE A AUTORIZAÇÃO ESTÁ *
    {* BAIXADA.                                 *
    {*****************************************}
    If (blnPesquisaBaixado) And (intConcil = 0) And
       ((Not Result) Or ((Result) And (Not TMobbuyFuncoes.fBetween(cdsBaicar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -LTolerancia, LTolerancia)))) Then
    Begin
      Result := (Not TMobbuyFuncoes.fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result    := False;
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If Not Result Then
      Result := TMobbuyFuncoes.IIF(Not TMobbuyFuncoes.fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                    False);
  End;

  If (Not Result) Or (LChaveCompletaSemEmpresa) Then
  Begin

    If Not Result Then
      Result := TMobbuyFuncoes.IIF(Not TMobbuyFuncoes.fEmptyStr(strNumCCD),
                    cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, 'D']),[]),
                    False);

    {********************************************
    {* ALGUMAS OPERADORAS UTILIZAM O MESMO NSU  *
    {* MUITAS VEZES. ENTÃO, ANTES DE PESQUISAR  *
    {* PELO NSU, VERIFICA SE A AUTORIZAÇÃO ESTÁ *
    {* BAIXADA.                                 *
    {*****************************************}
    If (blnPesquisaBaixado) And (intConcil = 0) And
       ((Not Result) Or ((Result) And (Not TMobbuyFuncoes.fBetween(cdsBaicar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -LTolerancia, LTolerancia)))) Then
    Begin
      Result := (Not TMobbuyFuncoes.fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result := False;
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If Not Result Then
      Result := TMobbuyFuncoes.IIF(Not TMobbuyFuncoes.fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, 'D']),[]),
                    False);
  End;
end;

function TConciliacaoCartoes.fBuscaCartaoBaixado(strNumCCD, strNumNSU,
  strCodEmp, strParcel: String; dtaDtaCup: TDateTime;
  blnValidaValorBruto: Boolean = False; AValorBruto: Double = 0.00): Boolean;
  Var
    LTolerancia : Double;

    LValorBruto: Double;
begin
  Result := False;

  LValorBruto := 0.00;
  If blnValidaValorBruto Then
  Begin
    If Assigned(cdsConCar) Then
      LValorBruto := cdsConCar.FieldByName(objConcil.CampoValorBruto).AsFloat;

    If AValorBruto <> 0.00 Then
      LValorBruto := AValorBruto;
  End;

  LTolerancia := RetornaValorTolerancia(strCodEmp,0.02999999);

  If (Not TMobbuyFuncoes.fEmptyStr(strCodEmp)) Then
  Begin
    Result := TMobbuyFuncoes.IIF((Not TMobbuyFuncoes.fEmptyStr(strNumCCD) And Not TMobbuyFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp]),[]),
                  False);

    if not Result then
      Result := TMobbuyFuncoes.IIF(Not TMobbuyFuncoes.fEmptyStr(strNumCCD),
                    cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
    If Not Result Then
      Result := TMobbuyFuncoes.IIF(Not TMobbuyFuncoes.fEmptyStr(strNumNSU),
                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
  End;

  If Not Result Then
  Begin
    Result := TMobbuyFuncoes.IIF((Not TMobbuyFuncoes.fEmptyStr(strNumCCD) And Not TMobbuyFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup]),[]),
                  False);

  End;

  If Not Result Then
  Begin
    Result := TMobbuyFuncoes.IIF(Not TMobbuyFuncoes.fEmptyStr(strNumCCD),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  strParcel, dtaDtaCup]),[]),
                  False);
    If Not Result Then
      Result := TMobbuyFuncoes.IIF(Not TMobbuyFuncoes.fEmptyStr(strNumNSU),
                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup]),[]),
                    False);
  End;

  If blnValidaValorBruto Then
  Begin
    If Result Then
    Begin
      Result := TMobbuyFuncoes.fBetween(LValorBruto - cdsBaixad.FieldByName('MCA_VALSTA').AsFloat,
                                        -LTolerancia, LTolerancia);

      If Not Result Then
      Begin
        If Not strCodEmp.IsEmpty Then
          Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX',
                                     VarArrayOf([UpperCase(strNumCCD),
                                                 UpperCase(strNumNSU),
                                                 strParcel,
                                                 dtaDtaCup,
                                                 strCodEmp]),[]);

        If Not Result Then
          Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP',
                                     VarArrayOf([UpperCase(strNumCCD),
                                                 UpperCase(strNumNSU),
                                                 strParcel,
                                                 dtaDtaCup]),[]);

        If Result Then
          Result := TMobbuyFuncoes.fBetween(LValorBruto - cdsBaixad.FieldByName('MCA_VALSTA').AsFloat,
                                            -LTolerancia, LTolerancia);
      End;
    End;
  End;

  blnAutomatica := (Result) And
                   (Not TMobbuyFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));

  If Result Then
  Begin
    cdsBaixad.Edit;
    cdsBaixad.FieldByName('VALIDADO').AsString := 'S';
    cdsBaixad.Post;
  End;
end;

Function TConciliacaoCartoes.fCartaoBloqueado(qryMovCar: TDataSet): Boolean;
Begin
  Result := TLibCartoesMovCar.CartaoBloqueado(qryMovCar, strRcxTcc);
End;

function TConciliacaoCartoes.fConciliaCartoes: Boolean;
begin
  Result := False;
end;

procedure TConciliacaoCartoes.pFiltraCartoes;
  Var
    strSQL   : String;
    strDtaCad: String;
    intCont  : Integer;

    qryBaiCar: TUniQuery;
begin
  strSQL := TLibCartoesMovcar.fGetSQLCartoes(objConcil);

  strDtaCad := '';

  For intCont := 0 To lstDtaCad.Count - 1 Do
    strDtaCad := strDtaCad + '"' + lstDtaCad[intCont] + '",';

  If strDtaCad.IsEmpty Then
    strSQL := strSQL + '  AND FALSE '
  Else
    strSQL := strSQL + '  AND MCA_DTACUP IN (' + Copy(strDtaCad, 1, Length(strDtaCad) - 1) + ') ';

  If Not TMobbuyFuncoes.fRetSomenteNumeros(FCartoesConciliar).IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + TMobbuyFuncoes.fRetStrToSQLIn(FCartoesConciliar) + ')';

  strSQL := strSQL + ' ORDER BY MCA_DTAVEN, MCA_NUMDUP, MCA_CODEMP, MCA_NUMCCD, MCA_NUMNSU, MCA_PARCEL) AS TMP ';

  strSQL := 'SELECT CAR.*, ' +
            '       RIGHT(CAR.MCA_NUMNSU, 6)              AS NSU_FINAL, ' +
            '       RIGHT(CAR.MCA_NUMCCD, 6)              AS AUT_FINAL, ' +
            '       TRIM(LEADING "0" FROM CAR.MCA_NUMCCD) AS AUT_SEM_ZERO, ' +
            '       TRIM(LEADING "0" FROM CAR.MCA_NUMNSU) AS NSU_SEM_ZERO ' +
            '  FROM (' + strSQL + ') AS CAR';

  qryBaiCar := Nil;
  Try
    qryBaiCar := VS_FuncoesExternas.fICriaQuery;
    qryBaiCar.SQL.Text := strSQL;
    qryBaiCar.Options.SetFieldsReadOnly := False;
    qryBaiCar.Open;

    TMobbuyFuncoes.FreeAndNilDatasets(cdsBaiCar);

    cdsBaiCar := TMobbuyFuncoes.CriarClientDataSet(qryBaiCar);

    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
  Finally
    TMobbuyFuncoes.FreeAndNilDatasets(qryBaiCar);
  End;
end;

procedure TConciliacaoCartoes.pFiltraCartoesBaixados(AApenasNaoValidados: Boolean = False);
  Var
    strSQL,
    strDtaCad: String;
    qryBaixad: TUniQuery;
    intCont  : Integer;
begin
  strDtaCad := '';
  For intCont := 0 To lstDtaCad.Count - 1 Do
    strDtaCad := strDtaCad + '"' + lstDtaCad[intCont] + '",';

  strSQL := 'SELECT ';

  If Not objConcil.TabelaConciliacao.Equals('MOB_APPGTO') Then
    strSQL := strSQL + '  IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMCCD, UPPER(MCA_NUMCCD)) AS MCA_NUMCCD, '
  Else
    strSQL := strSQL + '  LPAD(UPPER(MCA_NUMCCD), 6, "0") AS MCA_NUMCCD, ';

  strSQL := strSQL + ' MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, MCA_NUMDUP, MCA_DTACUP, MCA_NUMPOK,             ';
  strSQL := strSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON, MCA_VALSTA, ';
  strSQL := strSQL + ' RIGHT(MOVCAR.MCA_NUMNSU, 6) AS NSU_FINAL, RIGHT(MOVCAR.MCA_NUMCCD, 6) AS AUT_FINAL, ';
  strSQL := strSQL + ' TRIM(LEADING "0" FROM UPPER(MOVCAR.MCA_NUMCCD)) AS AUT_SEM_ZERO, ';
  strSQL := strSQL + ' TRIM(LEADING "0" FROM MOVCAR.MCA_NUMNSU) AS NSU_SEM_ZERO, ';
  strSQL := strSQL + '  CAST(" " AS CHAR(50)) AS MARKETPLACE,                      ';
  strSQL := strSQL + ' LPAD(RIGHT(MCA_NUMNSU,12),14,"0") AS NSU_B2W,               ';
  strSQL := strSQL + ' "N" AS VALIDADO                                             ';
  strSQL := strSQL + ' FROM MOVCAR                                                 ';
  If strDtaCad.IsEmpty Then
    strSQL := strSQL + ' WHERE FALSE '
  Else
    strSQL := strSQL + ' WHERE MCA_DTACUP IN(' + Copy(strDtaCad, 1, Length(strDtaCad) -1) + ') ';

  If Not TMobbuyFuncoes.fRetSomenteNumeros(FCartoesConciliar).IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + TMobbuyFuncoes.fRetStrToSQLIn(FCartoesConciliar) + ')';

  strSQL := strSQL + ' AND MCA_DTAREC IS NOT NULL                                  ';
  strSQL := strSQL + ' ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP                  ';

  qryBaixad := Nil;
  Try
    qryBaixad := VS_FuncoesExternas.fICriaQuery;
    qryBaixad.SQL.Add(strSQL);
    qryBaixad.Open;

    TMobbuyFuncoes.FreeAndNilDatasets(cdsBaixad);
    cdsBaixad := TMobbuyFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    If AApenasNaoValidados Then
    Begin
      cdsBaixad.Filter := 'VALIDADO=''N'' ';
      cdsBaixad.Filtered := True;
    End;

    cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;EMPLOC;MCA_DTACUP;PARDUP';
  Finally
    TMobbuyFuncoes.FreeAndNilDatasets(qryBaixad);
  End;
end;

function TConciliacaoCartoes.GeraRelatorioConciliacao(ANomCon: String; pgbStatus: TcxProgressBar): Boolean;
  Var
    LValorBrutoDiferente,
    LRegistroNaoEncontrado,
    LCaixaNaoTransferidos,
    LCartoesBaixados,
    LValorTaxaDiferente,
    LExibeListaArquivos,
    LExibeListaSemRegistros,
    LExibeTotaisBandeira,
    LExibeTotaisPontoDeVenda,
    bEsconderValoresLiquidosZerados: Boolean;
    LOrdenacao: Integer;

    frmLibCartoesFiltroInconsistencias: TfrmLibCartoesFiltroInconsistencias;

    LNaoExibir: String;
begin
  pgbStatus.Visible := False;
  TForm(pgbStatus.Owner).Visible := True;
  TMobbuyFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Atualizando dados de conciliação.', False);
  pAcertaDadosDeBaixaOtimizadaPorEmpresa;
  TForm(pgbStatus.Owner).Visible := False;

  TMobbuyFuncoes.pCriarFormularios(TfrmLibCartoesFiltroInconsistencias, frmLibCartoesFiltroInconsistencias);
  Try
    frmLibCartoesFiltroInconsistencias.Ordenacao := 1;
    frmLibCartoesFiltroInconsistencias.blnConRed := True;
    frmLibCartoesFiltroInconsistencias.chkTaxDif.Visible := True;

    frmLibCartoesFiltroInconsistencias.chkCarPen.Visible := True;
    frmLibCartoesFiltroInconsistencias.BlnExCarPen    := False;
    frmLibCartoesFiltroInconsistencias.chkValZer.Visible := True;
    frmLibCartoesFiltroInconsistencias.chkValZer.Checked := True;

    frmLibCartoesFiltroInconsistencias.ShowModal;
    LValorBrutoDiferente := frmLibCartoesFiltroInconsistencias.ValorBrutoDiferente;
    LRegistroNaoEncontrado := frmLibCartoesFiltroInconsistencias.RegistroNaoEncontrado;
    LCaixaNaoTransferidos := frmLibCartoesFiltroInconsistencias.CaixaNaoTransferidos;
    LCartoesBaixados := frmLibCartoesFiltroInconsistencias.CartoesBaixados;
    LExibeListaArquivos := frmLibCartoesFiltroInconsistencias.ExibeListaArquivos;
    LExibeListaSemRegistros := frmLibCartoesFiltroInconsistencias.ExibeListaSemRegistros;
    LOrdenacao := frmLibCartoesFiltroInconsistencias.Ordenacao;
    LExibeTotaisBandeira := frmLibCartoesFiltroInconsistencias.ExibeTotaisBandeira;
    LExibeTotaisPontoDeVenda := frmLibCartoesFiltroInconsistencias.ExibeTotaisPontoDeVenda;
    LValorTaxaDiferente := frmLibCartoesFiltroInconsistencias.ValorTaxaDiferente;
    FExibirCartoesPendente := frmLibCartoesFiltroInconsistencias.ExibirCartoesPendente;
    bEsconderValoresLiquidosZerados := frmLibCartoesFiltroInconsistencias.EsconderCartoesVlrLiqZerado;

    Result := frmLibCartoesFiltroInconsistencias.ModalResult = mrOK;
  FInally
    FreeAndNil(frmLibCartoesFiltroInconsistencias);
    VS_FuncoesExternas.pITrimAppMemorySize;
  End;

  If Not Result Then
    Exit;

  if bEsconderValoresLiquidosZerados then
    DeletarValoresLiquidosZerados(cdsBaiCar, 'MCA_VALTOT');

  LNaoExibir := 'NEGOCIAÇÃO DE RECEBÍVEIS_Cancelamentos/Ajustes_TRANSFERÊNCIAS_Devoluções_';

  If Not LValorBrutoDiferente Then
    LNaoExibir := LNaoExibir +
                  'Valor do cartão diferente do registrado no sistema ou Autorização duplicada_';

  If Not LRegistroNaoEncontrado Then
    LNaoExibir := LNaoExibir +
                  'Registro do arquivo não encontrado nos lançamentos do sistema_';

  If Not LCaixaNaoTransferidos Then
    LNaoExibir := LNaoExibir +
                  'Cartões recebidos pelo Caixa e não transferidos_';

  If Not LCartoesBaixados Then
    LNaoExibir := LNaoExibir +
                  'Cartão já foi baixado manualmente_Cartão já foi baixado através de conciliação automática_';

  If Not LValorTaxaDiferente Then
    LNaoExibir := LNaoExibir +
                  RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa + '_';

  FFiltrosRelatorio.AutoIncrem := FRelatorioConciliacao.AutoIncremRelatorio;
  FFiltrosRelatorio.FiltrosDescri := LNaoExibir;
  FFiltrosRelatorio.ExibeGrupoBandeira := LExibeTotaisBandeira;
  FFiltrosRelatorio.ExibeGrupoPontoDeVenda := LExibeTotaisPontoDeVenda;
  FFiltrosRelatorio.ExibeArquivos := LExibeListaArquivos;
  FFiltrosRelatorio.ExibeFaltantes := LExibeListaSemRegistros;
  FFiltrosRelatorio.Ordenacao := LOrdenacao;

  VS_FuncoesExternas.prcIExecutaRelatorio(545,
                                            37468,
                                            [],
                                            ['AUTINC',
                                            'DESCRI',
                                            'EXBRESBAN',
                                            'EXBTOTPVE',
                                            'ORDENACAO'],
                                            [ FFiltrosRelatorio.AutoIncrem,
                                             FFiltrosRelatorio.FiltrosDescri,
                                             TMobbuyFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoPontoDeVenda, 'Sim', 'Não'),
                                             TMobbuyFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoPontoDeVenda, 'Sim', 'Não'),
                                             TMobbuyFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 0, 'Data da Venda',
                                                                TMobbuyFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 1,
                                                                                     'Data de Vencimento', 'Número RV'))
                                            ],
                                            nil,
                                            nil,
                                            True);

end;

function TConciliacaoCartoes.fExisteEstabelecimentosDuplicados(
  var AConfiguracao: String): Boolean;
  Var
    strSQL  : String;
    qryTotal: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT COUNT(SIS_VALCFG) AS TOTAL, ';
  strSQL := strSQL + '   SIS_VALCFG                      ';
  strSQL := strSQL + 'FROM CFGSIS                        ';
  strSQL := strSQL + 'WHERE SIS_CODCFG IN ([CODCFG]) AND ';
  strSQL := strSQL + '  SIS_VALCFG IS NOT NULL AND       ';
  strSQL := strSQL + '  SIS_VALCFG <> ""                 ';
  strSQL := strSQL + 'GROUP BY SIS_VALCFG                ';
  strSQL := strSQL + '   HAVING COUNT(SIS_VALCFG) > 1    ';

  AConfiguracao := '("' + AConfiguracao + '")';

  strSQL := strSQL.Replace('([CODCFG])', AConfiguracao);

  qryTotal := Nil;
  Try
    qryTotal := VS_FuncoesExternas.fICriaQuery;
    qryTotal.SQL.Text := strSQL;

    qryTotal.Open;

    Result := Not qryTotal.IsEmpty;
  Finally
    TMobbuyFuncoes.FreeAndNilDatasets(qryTotal);
  End;
End;

procedure TConciliacaoCartoes.RemoverRelatorioConciliacao(AUnitRemocao: String);
  Var
    LConsulta: TUniQuery;
begin
  If Not Assigned(FRelatorioConciliacao) Then
    Exit;

  LConsulta := Nil;
  VS_FuncoesExternas.fIStartTransaction;
  Try
    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT * FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio;
      LConsulta.Open;

      TMobbuyFuncoes.GravaTabelaDelecao(AUnitRemocao,
                                            'REL_CONCAR',
                                             LConsulta);

      TMobbuyFuncoes.ExecutaSQL('DELETE FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio);

      VS_FuncoesExternas.fICommit;
    Finally
      TMobbuyFuncoes.FreeAndNilDatasets(LConsulta);
    End;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollBack;

      VS_FuncoesExternas.pIMensagensErro('Ocorreu um erro ao remover o relatório de conciliação' + #13 +
                                         'Erro gerado: ' + E.Message, '[TConciliacaoCartoes.RemoverRelatorioConciliacao]');
    End;
  End;
end;

function TConciliacaoCartoes.RetornaCodigosEstabelecimentosLocateIn(ARetornarIn: Boolean = True): String;
  Var
    LConsulta: TUniQuery;

    LEmpresas: TStringList;
begin
  Result := EmptyStr;

  If Length(arrEmpresa) <= 0 Then
    Exit;

  LConsulta := Nil;
  LEmpresas := Nil;
  Try
    LEmpresas := TMobbuyFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa);
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT DISTINCT SIS_VALCFG ' +
                          'FROM CFGSIS ' +
                          'WHERE SIS_CODCFG IN ("CFG_MOBEST") ' +
                          '  AND COALESCE(SIS_VALCFG, "") <> "" ' +
                          '  AND SIS_CODEMP IN ("' + LEmpresas.CommaText.Replace(',', '","') + '")';
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      Result := Result + LConsulta.FieldByName('SIS_VALCFG').AsString + ',';

      LConsulta.Next;
    End;

    Result := Result.Replace(',,', ',');

    If Not ARetornarIn Then
      Exit(Result.Replace(',', '_'));

    Result := '"' + LeftStr(Result, Result.Length - 1).Replace(',', '","') + '"';
  Finally
    TMobbuyFuncoes.FreeAndNilDatasets(LConsulta);

    If Assigned(LEmpresas) Then
      FreeAndNil(LEmpresas);
  End;
end;

function TConciliacaoCartoes.RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa: String;
begin
  Result := 'Taxa de administração do registro importado difere da taxa cadastrada para a operadora.';

  If FConfiguracaoTaxaAdministrativa.Equals('2') Then
    Result := 'Taxa de administração do registro importado difere da taxa da movimentação do cartão.';
end;

function TConciliacaoCartoes.RetornaFiltrosDigitados: String;
  Var
    LStringList: TStringList;
begin
  Result := 'Data Inicial: ' + strDtaIni + #13 +
            'Data Final: ' + strDtaFim + #13;

  LStringList := Nil;
  Try
    If Length(arrEmpresa) > 0 Then
    Begin
      LStringList := TMobbuyFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa);
      Result := Result + 'Empresas: ' + LStringList.Text;
      FreeAndNil(LStringList);
    End;

    If Length(arrPonVen) > 0 Then
    Begin
      LStringList := TMobbuyFuncoes.ConverterArrayConsultaParaStringList(arrPonVen);
      Result := Result + 'Pontos de Vendas: ' + LStringList.Text;
    End;
  Finally
    If Assigned(LStringList) THen
      FreeAndNil(LStringList);
  End;
end;

function TConciliacaoCartoes.RetornaTaxaParaValidacao: Double;
begin
  Result := cdsBaiCar.FieldByName('CAR_PERDES').AsFloat;

  If FConfiguracaoTaxaAdministrativa.Equals('2') Then
    Result := cdsBaiCar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat;

end;

function TConciliacaoCartoes.RetornaTextoInconsistenciaAtualizado(
  ATextoInconsistencia: String): String;
begin
  Result := ATextoInconsistencia;

  If Result.IsEmpty Then
    Exit;

  If Result.Equals('Cartão já foi baixado') Then
  Begin
    If Not blnAutomatica Then
      Exit(Result + ' manualmente');

    Result := Result + ' através de conciliação automática';
  End;
end;

function TConciliacaoCartoes.RetornaValorTolerancia(ACodEmp: String;ADefault: Double): Double;
begin
  If TMobbuyFuncoes.fEmptyStr(objConcil.CfgVlrTolerancia) Then
    Exit(ADefault);

  If TMobbuyFuncoes.fEmptyStr(ACodEmp) Then
    ACodEmp :=  VS_FuncoesExternas.fIRetEmpresaLogada;

  Result := VS_FuncoesExternas.fICfgSis(objConcil.CfgVlrTolerancia,varCurrency,ACodEmp);
end;

function TConciliacaoCartoes.PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto: Double;
                                                                               ARegistro: TDataSet;
                                                                               APercentual: Boolean = True): Boolean;
  Var
    LDiferenca: Double;
Begin
  LDiferenca := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat - cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat);

  if APercentual then
    LDiferenca := LDiferenca -
                  (TMobbuyFuncoes.fFormataFloat(AValorBruto * (RetornaTaxaParaValidacao / 100), 2))
  else
    LDiferenca := LDiferenca - RetornaTaxaParaValidacao;

  Result := Not TMobbuyFuncoes.fBetween(LDiferenca, -0.039999, 0.0399999);
End;

{ TRelatorioConciliacao}

constructor TRelatorioConciliacao.Create(ACodigoOperador,
  AOperadora, ATipoRelatorio, AFiltrosRelatorio: String; ADataRelatorio,
  AHoraRelatorio: TDateTime);
  Var
    LInserir: TUniQuery;
begin
  LInserir := Nil;
  Try
    LInserir := VS_FuncoesExternas.fICriaQuery;
    LInserir.SQL.Text := 'SELECT * FROM REL_CONCAR WHERE FALSE';
    LInserir.Open;
    LInserir.Append;

    TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_CHAVE_', AOperadora.ToUpperInvariant + '-' +
                                                                     FormatDateTime('yyyymmdd', ADataRelatorio) + '_' +
                                                                     FormatDateTime('hhmmss', AHoraRelatorio) + '-' +
                                                                     ACodigoOperador + '-' + ATipoRelatorio.ToUpperInvariant);
    TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAREL', ADataRelatorio);
    TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_HORREL', AHoraRelatorio);
    TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODOPE', ACodigoOperador);
    TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_OPERAD', AOperadora);
    TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREL', ATipoRelatorio);
    TMobbuyFuncoes.SetaValorCampoDataset(LInserir, 'REL_FILREL', AFiltrosRelatorio  + #13 +
                                                                 'Versão Lib: ' + VERSAO_LIB + #13 +
                                                                 'Data Commit: ' + DATA_LIB);

    LInserir.Post;

    Self.AutoIncremRelatorio := LInserir.FieldByName('AUTOINCREM').Value;
    Self.ChaveRelatorio := LInserir.FieldByName('REL_CHAVE_').Value;
    Self.DataRelatorio := ADataRelatorio;
    Self.HoraRelatorio := AHoraRelatorio;
    Self.CodigoOperador := ACodigoOperador;
    Self.Operadora := AOperadora;
    Self.TipoRelatorio := ATipoRelatorio;
    Self.FiltrosRelatorio := AFiltrosRelatorio;
  Finally
    TMobbuyFuncoes.FreeAndNilDatasets(LInserir);
  End;
end;

{ TItensRelatorioCartoes }

constructor TItensRelatorioCartoes.Create;
begin
  ValorBruto := 0;
  ValorLiquido := 0;
  ValorTaxas := 0;
  ValorFrete := 0;
  ValorAjustes := 0;
  ValorCupom := 0;

  TipoDoRegistro := 'PAGAMENTO';
  SomarNoTotal := 'S';
  RegistroIncompleto := 'N';
  RegistroNegociacao := 'N';
  Conciliado := 0;
end;

end.

