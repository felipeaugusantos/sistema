unit untTMostraDebCtrChq2;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, Vcl.Forms,
     untTypesSistema, Uni, UniClientDataSet, Data.DB, frxClass,
     untQckHTMLCliente, System.DateUtils, WinAPI.Windows, untSQLBind,
     untSQLBind_Query;

Type
  TMonitorAvisoDebito = class
  strict private
    class function GetExeName: String; static;
  public
    const
      ID_INATIVIDADE_MONITOR = 'TESTE_INATIVIDADE_AVISO_DEBITO_%s';
      TEMPO_LIMITE_MONITOR = 30;
      ID_MONITOR = 'MONITOR_AVISO_DEBITO_%s';
      TENTATIVAS_LOCK_MONITOR = 30;
      PARAMETROS = '%s %s';

    class var ProcessoMonitor: TProcessInformation;
    class var DataUltimaExecucaoMonitor: TDateTime;
    class var Operador: String;

    class property ExeName: string read GetExeName;
  end;

Type
  TCheckBoxMostraDebCtrChq2 = Record
    ContaCorrente,
    Produto,
    Cheque,
    Observacao,
    Juros,
    DocAg,
    DtaVen,
    AjuDta,
    EndEre,
    BancoDoBoleto,
    NumPedFF,
    Credito: Boolean;
  End;

Type
  TVariaveisMostraDebCtrChq2 = Record
    RedeLoja,
    CodigoCliente,
    CodigoPortador,
    SQLDtaVen,
    TipoFiltro,
    MensagemRelatorio,
    DataInicial,
    DataFinal: String;

    ArrPortador: TConsultasArray;

    cdsTemporaria2,
    cdsTemporaria3: TUniClientDataset;

    ConsideraRepassados,
    Vencidos,
    ExecutandoPeloRobo,
    GerarDatasetChequesRobo: Boolean;
    Ordem: Integer;
  End;

Type
  TMostraDebCtrChq2 = class
    class var MonitorAvisoDebito: TMonitorAvisoDebito;
  private
    FDescFinanSomenteAteVenc: Boolean;

    FCheckBoxSelecionados: TCheckBoxMostraDebCtrChq2;

    FVariaveisFiltro: TVariaveisMostraDebCtrChq2;

    FVariaveisEmail: TDadosDisparaEmail;
    FVariaveisSMS: TDadosDisparaSMS;

    frmQckHTMLCliente: TfrmQckHTMLCliente;

    FArquivoRelatorioEmail: String;

    FGerouRelEnvioEmail: Boolean;
    FGerouRelEnvioWhats: Boolean;


    //BEGIN SelecionaProdutosContasReceber
    function GetSqlDtaVen: String;
    function RetornaSQLDtaVen: String;
    function GetSqlValOri(ASomaAgr: Boolean = False): String;
    function GetSqlValDup(strTabela: String = ''): String;
    function GetSqlTaxaJuros: String;
    function GetSqlTolerancia: String;
    function GetSqlValorJuros(strValDup: String): String;
    function GetSqlMovNot(strCampo: String): String;
    function GetSQLCamposEndereco: String;
    function GetSQLJoinObservacao: String;
    function GetSQLJoinProduto: String;
    function GetSQLJoinEndereco: String;
    function GetSQLWhereSelecionaProdutos: String;
    function GetSQLCADREC(ADuplicatasSelecionadas : String) : String;

    function GetSQLAgrupadas(ADuplicatasSelecionadas: String): String;
    function GetSQLJoinObservacaoAgr: String;
    function GetSQLJoinProdutoAgr: String;
    function GetSQLJoinEnderecoAgr: String;
    function GetSQLWhereSelecionaProdutosAgr: String;
    //END SelecionaProdutosContasReceber

    //BEGIN GeraRelatorio
    procedure SetParametrosRelatorio(var ADataset: TUniQuery);
    function GetSQLClienteRelatorio: String;
    function GetSQLEmpresaRelatorio: String;
    procedure SetTotaisRelatorio(var ADatasetTotal: TUniClientDataset);
    procedure AtribuiTotaisRelatorioDuplicatasMarcadas(var ADataset: TUniClientDataset);
    procedure AtribuiTotaisRelatorioDuplicatasRobo(var ADataset: TUniClientDataset;
                                                   ARelatorio: TDataset);
    procedure SetVariaveisImagem(out AImagem: String;
                                 out ADirImagem: String);
    procedure ValidaPastaContaCorrente(AAbrirEmVideo: Boolean;
                                       AExecutavel: String);

    function GetLayoutRelatorio(AQckHTMLCliente: TfrmQckHTMLCliente;
                                AImagem: String;
                                out ARelatorioPaisagem: Boolean): TfrxReport;
    procedure ConfiguraCamposRelatorioRedeLojaEJuros(var ARelatorio: TfrxReport);
    procedure ConfiguraCamposRelatorioBancoBoletoFF(var ARelatorio: TfrxReport;
                                                        ARelatorioPaisagem: Boolean);
    procedure ConfiguraCamposRelatorioBancoBoletoFFSemJuros(var ARelatorio: TfrxReport;
                                                                ARelatorioPaisagem: Boolean);
    procedure ExibirCreditosNoRelatorio(Var ARelatorio : TfrxReport);
    procedure DeveGerarDatasetChequesRobo(AGerarDatasetRobo: Boolean);
    procedure CarregaVariaveisEmailSMSWpp(ANomeArquivo: String;
                                          AGerarArquivoWpp: Boolean);
    //END GeraRelatorio

    class function GerarEEnviarListaDeAvisosDeDebito(AModelo: String): Boolean;
    function ValorAReceber: Double;
  public
    constructor Create; overload;

    procedure SetCheckBoxSelecionados(ACheckBoxSelecionados: TCheckBoxMostraDebCtrChq2);

    procedure CarregaOutrasVariaveis(AVariaveisFiltro: TVariaveisMostraDebCtrChq2);

    procedure GerarRelatorio(AAbrirEmVideo: Boolean;
                             ADuplicatasSelecionadas,
                             ANomeFormulario,
                             ACaptionFormulario: String;
                             AGerarArquivoWpp: Boolean = False);

    function SelecionaProdutosContasReceber(ADuplicatasSelecionadas: String = ''): String;

    function RetornaSQLCheques: String;

    class function fRetornaCdsPortadorAut(intTip : Integer; ACodGru, ACodCfg, ACodEmp : String ): TUniClientDataSet;

    class function GetWhareDuplicataTroco: string;


    class function ExistemClientesComValoresEmAberto(ADiasVencidos: Integer;
                                                     var AListaClientes: TStringList): Boolean;

    class function EnviouTodosAvisosDebitosClientes(AModelo: String;
                                                    ACodigoCliente: String = ''): Boolean;

    class function RetornaAutoIncremDuplicatasEmAbertoCliente(ADiasVencidos: Integer;
                                                              ACodigoCliente: String;
                                                              ATipo: Integer;
                                                              AModelo: String): String;

    class function RetornaModeloEmail: String;

    class function TravaInsercaoRegistros(AInserir: Boolean): Boolean;

    property VariaveisEmail: TDadosDisparaEmail read FVariaveisEmail;
    property VariaveisSMS: TDadosDisparaSMS read FVariaveisSMS;
    property ArquivoRelatorioEmail: String read FArquivoRelatorioEmail;

    property GerouRelEnvioEmail : Boolean read FGerouRelEnvioEmail Write FGerouRelEnvioEmail;
    property GerouRelEnvioWhats : Boolean read FGerouRelEnvioWhats Write FGerouRelEnvioWhats;

  end;

implementation
Uses untFuncoesSimples, untCadRec, untConstantes, Math;
{ TMostraDebCtrChq2 }

procedure TMostraDebCtrChq2.AtribuiTotaisRelatorioDuplicatasMarcadas(var ADataset: TUniClientDataset);
begin
  ADataset.FieldByName('DUPVEN').AsFloat         := 0.00;
  ADataset.FieldByName('DUPAVE').AsFloat         := 0.00;
  ADataset.FieldByName('TOTALCORRIGIDO').AsFloat := 0.00;
  ADataset.FieldByName('TOTALDIFERENCA').AsFloat := 0.00;
  ADataset.FieldByName('TOTALJUROS').AsFloat     := 0.00;
  ADataset.FieldByName('TOTALRECEBIDO').AsFloat  := 0.00;
  ADataset.FieldByName('TOTALDUPLICATA').AsFloat := 0.00;
  ADataset.FieldByName('TOTALDUP').AsFloat       := 0.00;

  FVariaveisFiltro.cdsTemporaria2.First;

  While Not FVariaveisFiltro.cdsTemporaria2.Eof Do
  Begin
    ADataset.FieldByName('DUPVEN').AsFloat         := fFormataFloat(ADataset.FieldByName('DUPVEN').AsFloat +
                                                      IfNull(FVariaveisFiltro.cdsTemporaria2.FieldByName('CTR_DUPVEN').Value, 0.00),2);

    ADataset.FieldByName('DUPAVE').AsFloat         := fFormataFloat(ADataset.FieldByName('DUPAVE').AsFloat +
                                                      IfNull(FVariaveisFiltro.cdsTemporaria2.FieldByName('CTR_DUPAVE').Value, 0.00),2);

    ADataset.FieldByName('TOTALCORRIGIDO').AsFloat := fFormataFloat(ADataset.FieldByName('TOTALCORRIGIDO').AsFloat +
                                                      IfNull(FVariaveisFiltro.cdsTemporaria2.FieldByName('CTR_VALCAL').Value, 0.00),2);

    ADataset.FieldByName('TOTALDIFERENCA').AsFloat := fFormataFloat(ADataset.FieldByName('TOTALDIFERENCA').AsFloat +
                                                      IfNull(FVariaveisFiltro.cdsTemporaria2.FieldByName('CTR_DIFERE').Value, 0.00),2);

    ADataset.FieldByName('TOTALJUROS').AsFloat     := fFormataFloat(ADataset.FieldByName('TOTALJUROS').AsFloat +
                                                      IfNull(FVariaveisFiltro.cdsTemporaria2.FieldByName('JUROS').Value, 0.00),2);

    ADataset.FieldByName('TOTALRECEBIDO').AsFloat  := fFormataFloat(ADataset.FieldByName('TOTALRECEBIDO').AsFloat +
                                                      IfNull(FVariaveisFiltro.cdsTemporaria2.FieldByName('CTR_VALREC').Value, 0.00),2);

    ADataset.FieldByName('TOTALDUPLICATA').AsFloat := fFormataFloat(ADataset.FieldByName('TOTALDUPLICATA').AsFloat +
                                                      IfNull(FVariaveisFiltro.cdsTemporaria2.FieldByName('VALORI').Value, 0.00),2);

    ADataset.FieldByName('TOTALDUP').AsFloat       := fFormataFloat(ADataset.FieldByName('TOTALDUP').AsFloat +
                                                      IfNull(FVariaveisFiltro.cdsTemporaria2.FieldByName('VALDUP').Value, 0.00),2);

    FVariaveisFiltro.cdsTemporaria2.Next;
  End;
end;

procedure TMostraDebCtrChq2.AtribuiTotaisRelatorioDuplicatasRobo(
  var ADataset: TUniClientDataset; ARelatorio: TDataset);
begin
  ADataset.FieldByName('DUPVEN').AsFloat         := 0.00;
  ADataset.FieldByName('DUPAVE').AsFloat         := 0.00;
  ADataset.FieldByName('TOTALCORRIGIDO').AsFloat := 0.00;
  ADataset.FieldByName('TOTALDIFERENCA').AsFloat := 0.00;
  ADataset.FieldByName('TOTALJUROS').AsFloat     := 0.00;
  ADataset.FieldByName('TOTALRECEBIDO').AsFloat  := 0.00;
  ADataset.FieldByName('TOTALDUPLICATA').AsFloat := 0.00;
  ADataset.FieldByName('TOTALDUP').AsFloat       := 0.00;

  ARelatorio.First;

  While Not ARelatorio.Eof Do
  Begin
    If IfNull(ARelatorio.FieldByName('DIASATRASO').Value, 0) <> 0 Then
      ADataset.FieldByName('DUPVEN').AsFloat         := fFormataFloat(ADataset.FieldByName('DUPVEN').AsFloat +
                                                        IfNull(ARelatorio.FieldByName('VALORCORRIGIDO').Value, 0.00), 2);

    ADataset.FieldByName('TOTALCORRIGIDO').AsFloat := fFormataFloat(ADataset.FieldByName('TOTALCORRIGIDO').AsFloat +
                                                      IfNull(ARelatorio.FieldByName('VALORCORRIGIDO').Value, 0.00),2);

    ADataset.FieldByName('TOTALDIFERENCA').AsFloat := fFormataFloat(ADataset.FieldByName('TOTALDIFERENCA').AsFloat +
                                                      IfNull(ARelatorio.FieldByName('DIFERENCA').Value, 0.00),2);

    ADataset.FieldByName('TOTALJUROS').AsFloat     := fFormataFloat(ADataset.FieldByName('TOTALJUROS').AsFloat +
                                                      IfNull(ARelatorio.FieldByName('VALORJUROS').Value, 0.00),2);

    ADataset.FieldByName('TOTALRECEBIDO').AsFloat  := fFormataFloat(ADataset.FieldByName('TOTALRECEBIDO').AsFloat +
                                                      IfNull(ARelatorio.FieldByName('VALORRECEBIDO').Value, 0.00),2);

    ADataset.FieldByName('TOTALDUPLICATA').AsFloat := fFormataFloat(ADataset.FieldByName('TOTALDUPLICATA').AsFloat +
                                                      IfNull(ARelatorio.FieldByName('VALORIRELATORIO').Value, 0.00),2);

    ADataset.FieldByName('TOTALDUP').AsFloat       := fFormataFloat(ADataset.FieldByName('TOTALDUP').AsFloat +
                                                      IfNull(ARelatorio.FieldByName('VALORDUPLICATA').Value, 0.00),2);

    ARelatorio.Next;
  End;

  ARelatorio.First;
end;

procedure TMostraDebCtrChq2.CarregaOutrasVariaveis(AVariaveisFiltro: TVariaveisMostraDebCtrChq2);
begin
  FVariaveisFiltro := AVariaveisFiltro;
end;

procedure TMostraDebCtrChq2.CarregaVariaveisEmailSMSWpp(ANomeArquivo: String;
  AGerarArquivoWpp: Boolean);
  Var
    LDuplicatasArr: TArrDupTabelaEmail;

    LRelatorio: TUniQuery;

    LContador: Integer;

    LDuplicatas: String;

    recArquivos: TArray<TRecArquivosGatilhos>;
begin
  if Not FVariaveisFiltro.ExecutandoPeloRobo then
    Exit;

  If Not AGerarArquivoWpp Then
  Begin
    FVariaveisEmail.strCodCli   := LeftStr(frmQckHTMLCliente.qryCliente.FieldByName('NOME').AsString, 8);
    FVariaveisEmail.strEmailCli := fRetornaEmailsCliente(FVariaveisEmail.strCodCli).Replace(';', EmptyStr);

    if not fEmptyStr(ANomeArquivo) then
    begin
      SetLength(recArquivos, Length(recArquivos)+1);
      recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('CONTA CORRENTE', ANomeArquivo, EmptyStr);
    end;
    FVariaveisEmail.RecArquivos := recArquivos;

    LRelatorio := frmQckHTMLCliente.qryRelatorio;

    LDuplicatas := EmptyStr;

    LContador := 0;
    LRelatorio.First;
    While Not LRelatorio.Eof Do
    Begin
      If Not LRelatorio.FieldByname('TABROBO').AsString.Equals('CADREC') Then
      Begin
        LRelatorio.Next;
        Continue;
      End;

      If LDuplicatas.Contains(LRelatorio.FieldByname('GRUPO').AsString) Then
      Begin
        LRelatorio.Next;
        Continue;
      End;

      LDuplicatas := LDuplicatas + LRelatorio.FieldByname('GRUPO').AsString + '_';

      SetLength(LDuplicatasArr, LContador + 1);

      LDuplicatasArr[LContador].strNumDoc := LeftStr(LRelatorio.FieldByname('NUMDUP').AsString, 12);
      LDuplicatasArr[LContador].strParcel := LRelatorio.FieldByname('NUMDUP').AsString.Substring(12, 1);
      LDuplicatasArr[LContador].strEspDoc := LRelatorio.FieldByname('ESPECIE').AsString;
      LDuplicatasArr[LContador].strCodEmp := LRelatorio.FieldByname('EMPRESA').AsString;
      LDuplicatasArr[LContador].dtaDtaCad := LRelatorio.FieldByname('DATACADASTRO').AsDateTime;
      LDuplicatasArr[LContador].dtaDtaVen := LRelatorio.FieldByname('DATAVENCIMENTO').AsDateTime;
      LDuplicatasArr[LContador].fltVlrDup := fFormataFloat(LRelatorio.FieldByname('VALOR').AsFloat, 2);
      LDuplicatasArr[LContador].strCodCli := FVariaveisEmail.strCodCli;
      LDuplicatasArr[LContador].ValorJuros := fFormataFloat(LRelatorio.FieldByname('VALORJUROS').AsFloat, 2);
      LDuplicatasArr[LContador].ValorCorrigido := fFormataFloat(LRelatorio.FieldByname('VALORCORRIGIDO').AsFloat, 2);

      Inc(LContador);
      LRelatorio.Next;
    End;

    FVariaveisEmail.arrDupTabela := LDuplicatasArr;
  End
  Else
  Begin
    if not fEmptyStr(ANomeArquivo) then
    begin
      SetLength(recArquivos, Length(recArquivos)+1);
      recArquivos[High(recArquivos)] := TRecArquivosGatilhos.Create('CONTA CORRENTE', ANomeArquivo, EmptyStr);
    end;

    FVariaveisSMS.strCodCli := LeftStr(frmQckHTMLCliente.qryCliente.FieldByName('NOME').AsString, 8);
    FVariaveisSMS.strCelula := fCampoTabela('CLI_CELULA', 'CADCLI', ['CLI_CODCLI'], [FVariaveisSMS.strCodCli]);
    FVariaveisSMS.RecArquivos := recArquivos;
  End;
end;

constructor TMostraDebCtrChq2.Create;
begin
  FCheckBoxSelecionados.ContaCorrente := True;
  FCheckBoxSelecionados.Produto := False;
  FCheckBoxSelecionados.Cheque := False;
  FCheckBoxSelecionados.Observacao := False;
  FCheckBoxSelecionados.Juros := False;
  FCheckBoxSelecionados.DocAg := False;
  FCheckBoxSelecionados.DtaVen := False;
  FCheckBoxSelecionados.AjuDta := False;
  FCheckBoxSelecionados.EndEre := False;
  FCheckBoxSelecionados.BancoDoBoleto := False;
  FCheckBoxSelecionados.NumPedFF := False;
  FCheckBoxSelecionados.Credito := False;

  FVariaveisFiltro.GerarDatasetChequesRobo := False;
  FVariaveisFiltro.ExecutandoPeloRobo := False;
  FVariaveisFiltro.Ordem := -1;

  FDescFinanSomenteAteVenc := fCfgSis('UTDEFN') = '2';
end;

procedure TMostraDebCtrChq2.DeveGerarDatasetChequesRobo(
  AGerarDatasetRobo: Boolean);
    Var
      LConsulta: TUniQuery;
begin
  If Not AGerarDatasetRobo Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := RetornaSQLCheques;

    If Not FVariaveisFiltro.RedeLoja.IsEmpty Then
      LConsulta.ParamByName('REDE').AsString := FVariaveisFiltro.RedeLoja
    Else
      LConsulta.ParamByName('CODCLI').AsString := FVariaveisFiltro.CodigoCliente;

    If LConsulta.Params.FindParam('CODPOR') <> nil Then
      LConsulta.ParamByName('CODPOR').AsString :=  FVariaveisFiltro.CodigoPortador;

    If (FVariaveisFiltro.Vencidos) And (Assigned(LConsulta.Params.FindParam('DTAINI'))) Then
      LConsulta.ParamByName('DTAINI').AsDateTime := VS_Date
    Else If Not fEmptyStr(fTiraCaracEspeciais(FVariaveisFiltro.DataInicial)) Then
    Begin
      LConsulta.ParamByName('DTAINI').AsDateTime := StrToDate(FVariaveisFiltro.DataInicial);
      LConsulta.ParamByName('DTAFIN').AsDateTime := StrToDate(FVariaveisFiltro.DataFinal);
    End;

    LConsulta.Open;

    FVariaveisFiltro.cdsTemporaria3 := fCriaClientDatSet(LConsulta);
    FVariaveisFiltro.cdsTemporaria3.Open;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

class function TMostraDebCtrChq2.EnviouTodosAvisosDebitosClientes(
  AModelo: String; ACodigoCliente: String = ''): Boolean;
  Var
    LConsulta: TUniQuery;

    LAnoMes: String;
begin
  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT IFNULL(COUNT(AUTOINCREM), 0) AS TOTAL, ' +
                          '       IFNULL(SUM(IF(AVI_ENVIAR="N", 1, 0)), 0) AS ENVIADOS ' +
                          'FROM ENVAVI_DEB ' +
                          'WHERE AVI_DTAMOD BETWEEN :DTAIN AND :DTAFIN';

    If Not ACodigoCliente.IsEmpty Then
      LConsulta.SQL.Add(' AND AVI_CODCLI="' + ACodigoCliente + '"');

    LAnoMes := FormatDateTime('yyyy/mm', fRetDataServidor);

    LConsulta.ParamByName('DTAIN').AsString := LAnoMes + '/01';
    LConsulta.ParamByName('DTAFIN').AsString := LAnoMes + '/15';
    If AModelo = '002' Then
    Begin
      LConsulta.ParamByName('DTAIN').AsString := LAnoMes + '/16';
      LConsulta.ParamByName('DTAFIN').AsString := LAnoMes + '/' + DaysInAMonth(StrToInt(LeftStr(LAnoMes, 4)),
                                                                               StrToInt(RightStr(LAnoMes, 2))).ToString;
    End;

    LConsulta.Open;

    If LConsulta.FieldByName('TOTAL').AsInteger > 0 Then
      Exit(LConsulta.FieldByName('TOTAL').AsInteger = LConsulta.FieldByName('ENVIADOS').AsInteger);

    Result := ACodigoCliente.IsEmpty;
    If Result Then
      Result := Not GerarEEnviarListaDeAvisosDeDebito(AModelo);
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TMostraDebCtrChq2.ExibirCreditosNoRelatorio(
  var ARelatorio: TfrxReport);
begin
  If Assigned(TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCredito')))Then
    TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCredito')).Visible := FCheckBoxSelecionados.Credito;

  If Assigned(TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredito')))Then
    TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredito')).Visible := FCheckBoxSelecionados.Credito;

  If Assigned(TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoDisp')))Then
    TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoDisp')).Visible := FCheckBoxSelecionados.Credito;

  If Assigned(TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredDisp')))Then
    TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredDisp')).Visible := FCheckBoxSelecionados.Credito;

  If Assigned(TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoCh')))Then
    TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoCh')).Visible := FCheckBoxSelecionados.Credito;

  If Assigned(TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCreditoCh')))Then
    TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCreditoCh')).Visible := FCheckBoxSelecionados.Credito;

  If Assigned(TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoDispCh')))Then
    TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoDispCh')).Visible := FCheckBoxSelecionados.Credito;

  If Assigned(TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredDispCh')))Then
    TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredDispCh')).Visible := FCheckBoxSelecionados.Credito;
end;

class function TMostraDebCtrChq2.ExistemClientesComValoresEmAberto(
  ADiasVencidos: Integer; var AListaClientes: TStringList): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  AListaClientes := TStringList.Create;

  Try
    LConsulta.SQL.Text := 'SELECT R.CTR_CODCLI, C.CLI_CELULA, C.CLI_NOMCLI, ' +
                          RetornaSQLEmailCliente + ' ' +
                          'FROM CADREC R ' +
                          'JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI ' +
                          'WHERE R.CTR_DTAVEN BETWEEN DATE_ADD(CURRENT_DATE, INTERVAL -' + (ADiasVencidos + 1).ToString + ' DAY) ' +
                          '                       AND DATE_ADD(CURRENT_DATE, INTERVAL -1 DAY) ' +
                          '  AND R.CTR_DTAREC IS NULL ' +
                          '  AND R.CTR_VALDUP > 0 ' +
                          'GROUP BY R.CTR_CODCLI';
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      If fClienteConsumidor(LConsulta.FieldByName('CLI_NOMCLI').AsString) Then
      Begin
        LConsulta.Next;
        Continue;
      End;

      If LConsulta.FieldByName('CTR_EMACLI').AsString
                  .Trim().Replace(';', EmptyStr).Length > 5 Then
        AListaClientes.Add(LConsulta.FieldByName('CTR_CODCLI').AsString)
      Else If Not LConsulta.FieldByName('CLI_CELULA').AsString
                           .Trim().IsEmpty Then
        AListaClientes.Add(LConsulta.FieldByName('CTR_CODCLI').AsString);

      LConsulta.Next;
    End;

    Result := AListaClientes.Count > 0;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TMostraDebCtrChq2.GetLayoutRelatorio(AQckHTMLCliente: TfrmQckHTMLCliente;
  AImagem: String; out ARelatorioPaisagem: Boolean): TfrxReport;
Begin
  Result := AQckHTMLCliente.frxRetrato;

  ARelatorioPaisagem := FCheckBoxSelecionados.BancoDoBoleto;
  If Not ARelatorioPaisagem Then
    ARelatorioPaisagem := FCheckBoxSelecionados.NumPedFF;

  if ARelatorioPaisagem Then
    Result := AQckHTMLCliente.frxPaisagem;

  If AImagem = 'S' Then
  Begin
    If Assigned(Result.FindObject('Imagem')) Then
      TfrxPictureView(Result.FindObject('Imagem')).Picture.LoadFromFile(fCfgSis('PATLOG'));
  End;

  TfrxGroupHeader(Result.FindObject('ghDuplicatas')).Child := Nil;
End;

procedure TMostraDebCtrChq2.ConfiguraCamposRelatorioRedeLojaEJuros(var ARelatorio: TfrxReport);
Begin
  If fEmptyStr(FVariaveisFiltro.RedeLoja) Then
  Begin
    TfrxMemoView(ARelatorio.FindObject('Memo57')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Memo56')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('mmDadosCliente')).Top := 200;
    TfrxMemoView(ARelatorio.FindObject('mmNomeCliente')).Top := 220;
    TfrxMemoView(ARelatorio.FindObject('dbNomeCliente')).Top := 220;
  End;

  ARelatorio.Variables['bChkJuros'] := 0;
  If Not FCheckBoxSelecionados.Juros Then
  Begin
    ARelatorio.Variables['bChkJuros'] := 1;
    TfrxMemoView(ARelatorio.FindObject('mmVlrJuros')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('mmVlrCorrigido')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('dbVlrJuros')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('dbVlrCorrigido')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('mmTotalJuros')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('mmTotalCor')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('TotalJuros')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Memo51')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('TotalCorrigidos')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('TotalDiferenca')).Visible := False;

    TfrxShapeView(ARelatorio.FindObject('sDuplicata')).Width := 680;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 680;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 680;
    TfrxMemoView(ARelatorio.FindObject('mmNosNum')).Left := 610;
    TfrxMemoView(ARelatorio.FindObject('dbNosNum')).Left := 620;

    TfrxLineView(ARelatorio.FindObject('Line12')).Width := 363.10;
    TfrxLineView(ARelatorio.FindObject('Line13')).Width := 363.10;
    TfrxLineView(ARelatorio.FindObject('Line14')).Width := 363.10;
    TfrxLineView(ARelatorio.FindObject('Line12')).Left := 195.30;
    TfrxLineView(ARelatorio.FindObject('Line13')).Left := 195.30;
    TfrxLineView(ARelatorio.FindObject('Line14')).Left := 195.30;
    TfrxLineView(ARelatorio.FindObject('Line16')).Left := 195.18;
    TfrxLineView(ARelatorio.FindObject('Line17')).Left := 315.92;
    TfrxLineView(ARelatorio.FindObject('Line18')).Left := 438.44;
    TfrxLineView(ARelatorio.FindObject('Line19')).Left := 557.84;
    TfrxMemoView(ARelatorio.FindObject('mmDupVencidas')).Left := 198.52;
    TfrxMemoView(ARelatorio.FindObject('mmTotalVencidas')).Left := 198.52;
    TfrxMemoView(ARelatorio.FindObject('TotalVencidas')).Left := 198.52;
    TfrxMemoView(ARelatorio.FindObject('mmDupVencer')).Left := 320.94;
    TfrxMemoView(ARelatorio.FindObject('mmTotalVencer')).Left := 323.38;
    TfrxMemoView(ARelatorio.FindObject('TotalVencer')).Left := 323.38;
    TfrxMemoView(ARelatorio.FindObject('mmTotalDup')).Left := 443.78;
    TfrxMemoView(ARelatorio.FindObject('TotalDuplicatas')).Left := 444.34;
    TfrxMemoView(ARelatorio.FindObject('TotalRecebido')).Left := 444.34;

    TfrxShapeView(ARelatorio.FindObject('Shape6')).Height := 140.28;
    TfrxMemoView(ARelatorio.FindObject('RResumoCheques')).Top := 100.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoCheques')).Top := 100.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCredito')).Top := 120.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredito')).Top := 120.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoDisp')).Top := 140.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredDisp')).Top := 140.15;

    TfrxShapeView(ARelatorio.FindObject('Shape5')).Height := 120.28;
    TfrxMemoView(ARelatorio.FindObject('SysMemo3')).Top := 80.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoCheque')).Top := 80.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoCh')).Top := 100.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCreditoCh')).Top := 100.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoLimiteCreditoDispCh')).Top := 120.15;
    TfrxMemoView(ARelatorio.FindObject('mmResumoVlrLimiteCredDispCh')).Top := 120.15;

    TfrxMemoView(ARelatorio.FindObject('Memo49')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Memo50')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Line11')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Line15')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Line21')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Line46')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Line20')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('mmResumoJuros')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('mmResumoCorrigido')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('ResumoTotalJuros')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('ResumoTotalDiferenca')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('ResumoTotalCorrigido')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('RResumoJuros')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('RResumoDiferenca')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('RResumoCorrigido')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('ResumoJuros')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Memo54')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('ResumoCorrigido')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('ResumoDiferenca')).Visible := False;
  End;

  ARelatorio.Script.Variables['CODPOR'] := 'TODOS';

  If Not fEmptyStr(FVariaveisFiltro.CodigoPortador) Then
  Begin
    ARelatorio.Script.Variables['CODPOR'] := FVariaveisFiltro.CodigoPortador;
    If FVariaveisFiltro.CodigoPortador.Length <= 6 Then
      ARelatorio.Script.Variables['CODPOR'] := LeftStr(FVariaveisFiltro.CodigoPortador, FVariaveisFiltro.CodigoPortador.Length - 1) + '-' +
                                               fRetNomPortador(LeftStr(FVariaveisFiltro.CodigoPortador, 5));
  End;
End;

procedure TMostraDebCtrChq2.ConfiguraCamposRelatorioBancoBoletoFF(var ARelatorio: TfrxReport;
  ARelatorioPaisagem: Boolean);
  Var
    LTipo: Integer;
Begin
  If Not ARelatorioPaisagem Then
    Exit;

  LTipo := 1;
  If FCheckBoxSelecionados.BancoDoBoleto Then
  Begin
    LTipo := 0;
    If Not FCheckBoxSelecionados.NumPedFF Then
      LTipo := 2;
  End
  Else
  Begin
    If FCheckBoxSelecionados.NumPedFF Then
      LTipo := 3;
  End;

  if LTipo = 1 Then
  Begin
    //BCO  Boleto
    TfrxLineView(ARelatorio.FindObject('Line51')).Left := 718;
    TfrxLineView(ARelatorio.FindObject('Line52')).Left := 718;

    TfrxMemoView(ARelatorio.FindObject('Memo62')).Left := 720;
    TfrxMemoView(ARelatorio.FindObject('Memo64')).Left := 720;
    //Num. Ped. FF
    TfrxLineView(ARelatorio.FindObject('Line53')).Left := 810;
    TfrxLineView(ARelatorio.FindObject('Line54')).Left := 810;

    TfrxMemoView(ARelatorio.FindObject('Memo65')).Left := 825;
    TfrxMemoView(ARelatorio.FindObject('Memo66')).Left := 825;
  End;

  if LTipo = 2 Then
  Begin
    //BCO  Boleto
    TfrxLineView(ARelatorio.FindObject('Line51')).Left := 857;
    TfrxLineView(ARelatorio.FindObject('Line52')).Left := 857;

    TfrxMemoView(ARelatorio.FindObject('Memo62')).Left := 860;
    TfrxMemoView(ARelatorio.FindObject('Memo64')).Left := 860;

    TfrxShapeView(ARelatorio.FindObject('sDuplicata')).Width := 950;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 950;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 950;

    //Num. Ped. FF
    TfrxLineView(ARelatorio.FindObject('Line53')).Visible := False;
    TfrxLineView(ARelatorio.FindObject('Line54')).Visible := False;

    TfrxMemoView(ARelatorio.FindObject('Memo65')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Memo66')).Visible := False;
  end;

  if LTipo = 3  Then
  Begin
    //BCO  Boleto
    TfrxLineView(ARelatorio.FindObject('Line51')).Visible := False;
    TfrxLineView(ARelatorio.FindObject('Line52')).Visible := False;

    TfrxMemoView(ARelatorio.FindObject('Memo62')).Visible := False;
    TfrxMemoView(ARelatorio.FindObject('Memo64')).Visible := False;

    TfrxShapeView(ARelatorio.FindObject('sDuplicata')).Width := 950;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 950;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 950;

    //Num. Ped. FF
    TfrxLineView(ARelatorio.FindObject('Line53')).Left := 857;
    TfrxLineView(ARelatorio.FindObject('Line54')).Left := 857;

    TfrxMemoView(ARelatorio.FindObject('Memo65')).Left := 860;
    TfrxMemoView(ARelatorio.FindObject('Memo66')).Left := 860;
  end;
End;

procedure TMostraDebCtrChq2.ConfiguraCamposRelatorioBancoBoletoFFSemJuros(var ARelatorio: TfrxReport;
  ARelatorioPaisagem: Boolean);
  Var
    LTipo: Integer;
Begin
  If FCheckBoxSelecionados.Juros Then
    Exit;

  If Not ARelatorioPaisagem Then
    Exit;

  LTipo := 1;
  If FCheckBoxSelecionados.BancoDoBoleto Then
  Begin
    If Not FCheckBoxSelecionados.NumPedFF Then
      LTipo := 2;
  End
  Else
  Begin
    If FCheckBoxSelecionados.NumPedFF Then
      LTipo := 3;
  End;

  if LTipo = 1 Then
  Begin
    //BCO  Boleto
    TfrxLineView(ARelatorio.FindObject('Line51')).Left := 718;
    TfrxLineView(ARelatorio.FindObject('Line52')).Left := 718;

    TfrxMemoView(ARelatorio.FindObject('Memo62')).Left := 720;
    TfrxMemoView(ARelatorio.FindObject('Memo64')).Left := 720;
    //Num. Ped. FF
    TfrxLineView(ARelatorio.FindObject('Line53')).Left := 810;
    TfrxLineView(ARelatorio.FindObject('Line54')).Left := 810;

    TfrxMemoView(ARelatorio.FindObject('Memo65')).Left := 825;
    TfrxMemoView(ARelatorio.FindObject('Memo66')).Left := 825;

    TfrxMemoView(ARelatorio.FindObject('mmNosNum')).Left := 630;
    TfrxMemoView(ARelatorio.FindObject('dbNosNum')).Left := 630;

    TfrxShapeView(ARelatorio.FindObject('sDuplicata')).Width := 920;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 920;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 920;
  end;

  if LTipo = 2 Then
  Begin
    //BCO  Boleto
    TfrxLineView(ARelatorio.FindObject('Line51')).Left := 718;
    TfrxLineView(ARelatorio.FindObject('Line52')).Left := 718;

    TfrxMemoView(ARelatorio.FindObject('Memo62')).Left := 720;
    TfrxMemoView(ARelatorio.FindObject('Memo64')).Left := 720;
    //Num. Ped. FF
    TfrxLineView(ARelatorio.FindObject('Line53')).Left := 810;
    TfrxLineView(ARelatorio.FindObject('Line54')).Left := 810;

    TfrxMemoView(ARelatorio.FindObject('Memo65')).Left := 825;
    TfrxMemoView(ARelatorio.FindObject('Memo66')).Left := 825;

    TfrxMemoView(ARelatorio.FindObject('mmNosNum')).Left := 630;
    TfrxMemoView(ARelatorio.FindObject('dbNosNum')).Left := 630;

    TfrxShapeView(ARelatorio.FindObject('sDuplicata')).Width := 820;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 820;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 820;
  end;

  if LTipo = 3 Then
  Begin
    //BCO  Boleto
    TfrxLineView(ARelatorio.FindObject('Line51')).Left := 718;
    TfrxLineView(ARelatorio.FindObject('Line52')).Left := 718;

    TfrxMemoView(ARelatorio.FindObject('Memo62')).Left := 720;
    TfrxMemoView(ARelatorio.FindObject('Memo64')).Left := 720;
    //Num. Ped. FF
    TfrxLineView(ARelatorio.FindObject('Line53')).Left := 718;
    TfrxLineView(ARelatorio.FindObject('Line54')).Left := 718;

    TfrxMemoView(ARelatorio.FindObject('Memo65')).Left := 720;
    TfrxMemoView(ARelatorio.FindObject('Memo66')).Left := 720;

    TfrxMemoView(ARelatorio.FindObject('mmNosNum')).Left := 630;
    TfrxMemoView(ARelatorio.FindObject('dbNosNum')).Left := 630;

    TfrxShapeView(ARelatorio.FindObject('sDuplicata')).Width := 820;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 820;
    TfrxShapeView(ARelatorio.FindObject('sItensDuplicata')).Width := 820;
  end;
End;

class function TMostraDebCtrChq2.GerarEEnviarListaDeAvisosDeDebito(
  AModelo: String): Boolean;
  Var
    LListaClientes: TStringList;

    LDia,
    LMes,
    LAno,
    LCliente: String;

    LInserir: TUniQuery;
begin
  if Not TravaInsercaoRegistros(True) Then
    Exit(True);

  LInserir := fCriaQuery;

  Result := ExistemClientesComValoresEmAberto(fCfgSis('DIADEB', varInteger),
                                              LListaClientes);

  Try
    If Not Result Then
      Exit;

    LInserir.SQL.Text := 'SELECT * FROM ENVAVI_DEB WHERE FALSE';
    LInserir.Open;

    LAno := FormatDateTime('yyyy', fRetDataServidor);
    LMes := FormatDateTime('mm', fRetDataServidor);
    LDia := '01';
    If AModelo = '002' Then
      LDia := '16';

    Try
      fStartTransaction;
      For LCliente In LListaClientes Do
      Begin
        LInserir.Append;
        LInserir.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ENVAVI_DEB', VS_strCodEmp);
        LInserir.FieldByName('AVI_DTAMOD').AsDateTime := EncodeDate(StrToInt(LAno),
                                                                    StrToInt(LMes),
                                                                    StrToInt(LDia));
        LInserir.FieldByName('AVI_DTAGRV').AsDateTime := fRetDtaHraServidor;
        LInserir.FieldByName('AVI_OPEGRV').AsString := strLoginUsuarioLogado;
        LInserir.FieldByName('AVI_CODCLI').AsString := LCliente;
        LInserir.Post;
      End;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollback;

        Result := True;

        pMensagensErro('Ocorreu um erro ao gerar a lista de Avos de Débito.' + #13 +
                       'Erro gerado: ' + E.Message,
                       '[TMostraDebCtrChq2.GerarEEnviarListaDeAvisosDeDebito]');
      End;
    End;
  Finally
    FreeAndNil(LListaClientes);

    TravaInsercaoRegistros(False);

    LInserir.Close;
    FreeAndNil(LInserir);
  End;
end;

procedure TMostraDebCtrChq2.GerarRelatorio(AAbrirEmVideo: Boolean;
  ADuplicatasSelecionadas, ANomeFormulario, ACaptionFormulario: String;
  AGerarArquivoWpp: Boolean = False);
  Var
    LSQL,
    LSQLCliente,
    LSQLEmpresa,

    LCheque,
    LImagem,
    LExecutavel,
    LDirImagem,
    LNomeArquivo: String;

    LRelatorio: TfrxReport;

    LRelatorioPaisagem: Boolean;
begin
  LExecutavel := ExtractFilePath(Application.ExeName);

  If (ADuplicatasSelecionadas) = '""' Then
  Begin
     // verifica se é whats
     If AGerarArquivoWpp Then
        FGerouRelEnvioEmail := False
     Else
        FGerouRelEnvioEmail := False;

     exit;
  End;


  LSQL := SelecionaProdutosContasReceber(ADuplicatasSelecionadas);

  Try
    If AGerarArquivoWpp Then
       fGerouRelEnvioWhats := True
    Else
       FGerouRelEnvioEmail := True;

    pCriarFormularios(TfrmQckHTMLCliente, frmQckHTMLCliente);

    frmQckHTMLCliente.qryRelatorio.Close;
    frmQckHTMLCliente.qryRelatorio.SQL.Clear;
    frmQckHTMLCliente.qryRelatorio.SQL.Add(LSQL);

    SetParametrosRelatorio(frmQckHTMLCliente.qryRelatorio);

    frmQckHTMLCliente.qryRelatorio.Open;

    LSQLCliente := GetSQLClienteRelatorio;

    frmQckHTMLCliente.qryCliente.Close;
    frmQckHTMLCliente.qryCliente.SQL.Clear;
    frmQckHTMLCliente.qryCliente.SQL.Add(LSQLCliente);
    frmQckHTMLCliente.qryCliente.ParamByName('CODCLI').AsString := FVariaveisFiltro.CodigoCliente;
    frmQckHTMLCliente.qryCliente.Open;

    LSQLEmpresa := GetSQLEmpresaRelatorio;

    frmQckHTMLCliente.qryEmpresa.Close;
    frmQckHTMLCliente.qryEmpresa.SQL.Clear;
    frmQckHTMLCliente.qryEmpresa.SQL.Add(LSQLEmpresa);
    frmQckHTMLCliente.qryEmpresa.ParamByName('CODEMP').AsString := VS_strCodEmp;
    frmQckHTMLCliente.qryEmpresa.Open;

    {*******************************************}
    {* TOTAIS RELATORIO                        *}
    {****************************************AC*}
    frmQckHTMLCliente.cdsTotal.Close;
    frmQckHTMLCliente.cdsTotal.CreateDataset;
    frmQckHTMLCliente.cdsTotal.EmptyDataSet;

    SetTotaisRelatorio(frmQckHTMLCliente.cdsTotal);

    {*******************************************}
    {* SE O CHECKBOX REFERENTE AO CHEQUE NÃO   *}
    {* NÃO ESTIVER CHECADO, ENTÃO EU ZERO A    *}
    {* VARIÁVEL REFENTE AO SQL DO CHEQUE       *}
    {****************************************AC*}
    LCheque := 'N';
    If (FCheckBoxSelecionados.Cheque) Then
    Begin
      DeveGerarDatasetChequesRobo(FVariaveisFiltro.GerarDatasetChequesRobo);

      frmQckHTMLCliente.cdsCheque.Data := FVariaveisFiltro.cdsTemporaria3.Data;
      LCheque := IIF(frmQckHTMLCliente.cdsCheque.IsEmpty, 'N', 'S');
    End;

    SetVariaveisImagem(LImagem, LDirImagem);

    frmQckHTMLCliente.qryInformacoes.Close;
    frmQckHTMLCliente.qryInformacoes.CreateDataSet;
    frmQckHTMLCliente.qryInformacoes.Append;
    frmQckHTMLCliente.qryInformacoesADICIONAIS.AsString := FVariaveisFiltro.MensagemRelatorio;
    frmQckHTMLCliente.qryInformacoesCHEQUE.AsString     := LCheque;
    frmQckHTMLCliente.qryInformacoesIMAGEM.AsString     := LImagem;
    frmQckHTMLCliente.qryInformacoesDIRETORIO.AsString  := LDirImagem;
    frmQckHTMLCliente.qryInformacoes.Post;

    ValidaPastaContaCorrente(AAbrirEmVideo,
                             LExecutavel);

    LNomeArquivo := 'Arquivo' + FVariaveisFiltro.CodigoCliente + '.pdf';
    If AGerarArquivoWpp Then
      LNomeArquivo := 'Arquivo' + FVariaveisFiltro.CodigoCliente + '_WPP.pdf';

    LRelatorio := GetLayoutRelatorio(frmQckHTMLCliente,
                                     LImagem,
                                     LRelatorioPaisagem);

    ConfiguraCamposRelatorioRedeLojaEJuros(LRelatorio);

    FCheckBoxSelecionados.DtaVen := False;

    ConfiguraCamposRelatorioBancoBoletoFF(LRelatorio,
                                          LRelatorioPaisagem);

    ConfiguraCamposRelatorioBancoBoletoFFSemJuros(LRelatorio,
                                                  LRelatorioPaisagem);

    ExibirCreditosNoRelatorio(LRelatorio);

    LRelatorio.ShowProgress := Not FVariaveisFiltro.ExecutandoPeloRobo;
    LRelatorio.PrepareReport(True);

    If AAbrirEmVideo Then
      pPreviewReport(ANomeFormulario, ACaptionFormulario, LRelatorio)
    Else
    Begin
      frmQckHTMLCliente.frxExportaPDF.FileName    := LNomeArquivo;
      frmQckHTMLCliente.frxExportaPDF.DefaultPath := LExecutavel + 'ContaCorrente';
      frmQckHTMLCliente.frxExportaPDF.ShowDialog  := False;

      LRelatorio.Export(frmQckHTMLCliente.frxExportaPDF);
    End;

    LNomeArquivo := LExecutavel + 'ContaCorrente\' + LNomeArquivo;

    FArquivoRelatorioEmail := LNomeArquivo;

    CarregaVariaveisEmailSMSWpp(LNomeArquivo, AGerarArquivoWpp);

    frmQckHTMLCliente.qryRelatorio.Close;
    frmQckHTMLCliente.qryCliente.Close;
    frmQckHTMLCliente.qryEmpresa.Close;
    frmQckHTMLCliente.cdsTotal.Close;
    frmQckHTMLCliente.qryInformacoes.Close;

  Except
    On E: Exception Do
    Begin
      If Not FVariaveisFiltro.ExecutandoPeloRobo Then
        pMensagensErro(E.Message, '[TMostraDebCtrChq2.GeraRelatorio]')
      Else
      Begin
        pGravarErro(True, E.Message, fRetornaStack);

        Raise;
      End;
    End;
  End;

  If Assigned(LRelatorio) Then
    FreeAndNil(LRelatorio);

  FreeAndNil(frmQckHTMLCliente);
end;

procedure TMostraDebCtrChq2.SetCheckBoxSelecionados(ACheckBoxSelecionados: TCheckBoxMostraDebCtrChq2);
begin
  FCheckBoxSelecionados := ACheckBoxSelecionados;
end;

procedure TMostraDebCtrChq2.SetParametrosRelatorio(var ADataset: TUniQuery);
begin
  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    ADataset.ParamByName('REDES').AsString := IIF(FCheckBoxSelecionados.ContaCorrente, FVariaveisFiltro.RedeLoja, '')
  Else
    ADataset.ParamByName('CODCLI').AsString := IIF(FCheckBoxSelecionados.ContaCorrente, FVariaveisFiltro.CodigoCliente, '');

  If ADataset.Params.FindParam('CODPOR') <> nil Then
    ADataset.ParamByName('CODPOR').AsString := FVariaveisFiltro.CodigoPortador;
end;

function TMostraDebCtrChq2.ValorAReceber: Double;
var
  LConsulta: TUniQuery;
  LSubConsulta: String;
begin
  Result := 0.00;
  LConsulta := fCriaQuery;
  try
    try
      LSubConsulta := fRetSQLResFinanceiro(ttCadRec,
                                           tcTitAbertos,
                                           FVariaveisFiltro.RedeLoja,
                                           not FVariaveisFiltro.RedeLoja.IsEmpty,
                                           FCheckBoxSelecionados.AjuDta,
                                           fClienteProfissional(FVariaveisFiltro.CodigoCliente));

      LConsulta.SQL.Text := 'SELECT SUM(CTR_VALDUP) AS VALDUP FROM ( ' + LSubConsulta + ' ) AS TAB';

      If not FVariaveisFiltro.RedeLoja.Trim.IsEmpty then
        LConsulta.ParamByName('REDE').AsString := FVariaveisFiltro.RedeLoja
      else
        LConsulta.ParamByName('CODCLI').AsString := FVariaveisFiltro.CodigoCliente;

      LConsulta.Open;
      Result := LConsulta.FieldByName('VALDUP').AsFloat;
    except
      On E: Exception do
        raise Exception.Create('Problemas ao buscar o valor a receber do cliente. ' + E.Message);
    end;
  finally
    FreeAndNil(LConsulta);
  end;
end;

procedure TMostraDebCtrChq2.SetTotaisRelatorio(var ADatasetTotal: TUniClientDataset);
  Var
    LQtdEPemAberto,
    LQtdPedNaoFat: Integer;
begin
  ADatasetTotal.Append;

  ADatasetTotal.FieldByName('DUPVEN').AsFloat           := 0.0;
  ADatasetTotal.FieldByName('DUPAVE').AsFloat           := 0.0;
  ADatasetTotal.FieldByName('TOTALCORRIGIDO').AsFloat   := 0.0;
  ADatasetTotal.FieldByName('TOTALDIFERENCA').AsFloat   := 0.0;
  ADatasetTotal.FieldByName('TOTALJUROS').AsFloat       := 0.0;
  ADatasetTotal.FieldByName('TOTALRECEBIDO').AsFloat    := 0.0;
  ADatasetTotal.FieldByName('TOTALDUPLICATA').AsFloat   := 0.0;
  ADatasetTotal.FieldByName('TOTALDUP').AsFloat         := 0.0;
  ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat := 0.00;
  ADatasetTotal.FieldByName('CREDCLI').AsFloat          := 0.00;

  If Not FVariaveisFiltro.cdsTemporaria2.IsEmpty Then
    AtribuiTotaisRelatorioDuplicatasMarcadas(ADatasetTotal)
  Else If FVariaveisFiltro.ExecutandoPeloRobo Then
    AtribuiTotaisRelatorioDuplicatasRobo(ADatasetTotal, frmQckHTMLCliente.qryRelatorio);

  ADatasetTotal.FieldByName('CREDCLI').AsFloat := RoundTo(fLimiteCreditoCliente(FVariaveisFiltro.CodigoCliente,
                                                                                    Not FVariaveisFiltro.RedeLoja.IsEmpty,
                                                                                    FVariaveisFiltro.RedeLoja),
                                                          -2);

  ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat := RoundTo(ADatasetTotal.FieldByName('CREDCLI').AsFloat -
                                                                   ValorAReceber, -2);

  {*****************************************}
  {* CHEQUE ENTRA NA CONTA CORRENTE?       *}
  {*****************************************}
  If fCfgSis('CHQCCO') = 'S' Then
    ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat := RoundTo(ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat -
                                                                     fRetChqAberto('SUM',
                                                                                   FVariaveisFiltro.CodigoCliente,
                                                                                   FVariaveisFiltro.RedeLoja,
                                                                                   not fEmptyStr(FVariaveisFiltro.RedeLoja),
                                                                                   FCheckBoxSelecionados.AjuDta),
                                                                     -2);

  {*****************************************}
  {* RETIRA CHEQUES DEVOLVIDOS E TIT CH    *}
  {*****************************************}
  ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat := RoundTo(ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat -
                                                                   fRetChqDevolvidos('SUM',
                                                                                     FVariaveisFiltro.CodigoCliente,
                                                                                     FVariaveisFiltro.RedeLoja,
                                                                                     not fEmptyStr(FVariaveisFiltro.RedeLoja),
                                                                                     FCheckBoxSelecionados.AjuDta),
                                                                   -2);

  {****************************}
  {* RETIRA PEDIDOS EM ABERTO *}
  {****************************}
  If fCfgSis('PDVLIM', VarBoolean) Then
    ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat := RoundTo(ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat -
                                                                     fTotalPedidosEmAberto(FVariaveisFiltro.CodigoCliente,
                                                                                           IfThen(not fEmptyStr(FVariaveisFiltro.RedeLoja), FVariaveisFiltro.RedeLoja, ''),
                                                                                           LQtdPedNaoFat,
                                                                                           True,
                                                                                           IfThen(fCfgSis('CSDCOU', VarBoolean),
                                                                                                  '',
                                                                                                  '"001","007","012","013"')),
                                                                     -2);

  {********************************}
  {* RETIRA EMPRESTIMOS EM ABERTO *}
  {********************************}
  If fCfgSis('LMCEMP', VarBoolean) Then
    ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat := RoundTo(ADatasetTotal.FieldByName('TOTALCREDITODISP').AsFloat -
                                                                     fTotalEmprestimosEmAberto(FVariaveisFiltro.CodigoCliente,
                                                                                               LQtdEPemAberto),
                                                                     -2);

  ADatasetTotal.Post;
end;

procedure TMostraDebCtrChq2.SetVariaveisImagem(out AImagem, ADirImagem: String);
begin
  {*********************************************************}
  {* SE NÃO EXISTIR O ARQUIVO ELE NÃO CARREGA NO RELATÓRIO *}
  {******************************************************AC*}
  AImagem    := 'N';
  ADirImagem := EmptyStr;

  If fEmptyStr(fCfgSis('PATLOG')) Then
    Exit;

  If Not FileExists(fCfgSis('PATLOG')) Then
    Exit;

  AImagem    := 'S';
  ADirImagem := fCfgSis('PATLOG');
end;

procedure TMostraDebCtrChq2.ValidaPastaContaCorrente(AAbrirEmVideo: Boolean;
  AExecutavel: String);
begin
  {*******************************************}
  {* SE NÃO EXISTIR O DIRETÓRIO ELE CRIA     *}
  {****************************************AC*}
  If AAbrirEmVideo Then
    Exit;

  If Not DirectoryExists(AExecutavel + 'ContaCorrente') Then
    CreateDir(AExecutavel + 'ContaCorrente');
end;

class function TMostraDebCtrChq2.RetornaAutoIncremDuplicatasEmAbertoCliente(
  ADiasVencidos: Integer; ACodigoCliente: String; ATipo : Integer; AModelo : String): String;
  Var
    LConsulta: TUniQuery;
    cdsPortAut : TUniClientDataSet;
    LPorRec : String;
begin
  LConsulta := fCriaQuery;

  cdsPortAut := fRetornaCdsPortadorAut(ATipo, '025', AModelo, VS_strCodEmp);
  cdsPortAut.Open;

  Try
    LConsulta.SQL.Text := 'SELECT R.AUTOINCREM, R.CTR_CODPOR ' +
                          'FROM CADREC R ' +
                          'WHERE R.CTR_DTAVEN BETWEEN DATE_ADD(CURRENT_DATE, INTERVAL -' + (ADiasVencidos + 1).ToString + ' DAY) ' +
                          '                       AND DATE_ADD(CURRENT_DATE, INTERVAL -1 DAY) ' +
                          '  AND R.CTR_CODCLI = "' + ACodigoCliente + '" ' +
                          '  AND R.CTR_DTAREC IS NULL ' +
                          '  AND R.CTR_VALDUP > 0 ';
    LConsulta.Open;

    Result := '"",';

    While Not LConsulta.Eof Do
    Begin

      // Verifica se tem portadores autorizados
      if Not cdsPortAut.IsEmpty then
      Begin

          LPorRec := LConsulta.FieldByName('CTR_CODPOR').AsString;

          If cdsPortAut.Locate('AEN_CODPOR', LPorRec, []) Then
             Result := Result + '"' + LConsulta.FieldByName('AUTOINCREM').AsString + '",';

      End
      Else
        Result := Result + '"' + LConsulta.FieldByName('AUTOINCREM').AsString + '",';

      LConsulta.Next;
    End;

    Result := LeftStr(Result, Result.Length - 1);
  Finally
    LConsulta.Close;

    If Assigned(cdsPortAut) Then
       FreeAndNil(cdsPortAut);

    FreeAndNil(LConsulta);
  End;
end;

class function TMostraDebCtrChq2.RetornaModeloEmail: String;
begin
  Result := '001';
  If StrToInt(FormatDateTime('dd', fNow)) > 15 Then
    Result := '002';
end;

function TMostraDebCtrChq2.RetornaSQLCheques: String;
begin
  Result := EmptyStr;
  Result := Result + 'SELECT ';
  Result := Result + '  CHQ_NUMCHQ, ';
  Result := Result + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ';
  Result := Result + '  CHQ_CODEMP, ';
  Result := Result + '  CHQ_CODBCO, ';
  Result := Result + '  CHQ_NOMEMI, ';
  Result := Result + '  CAST(IF(CHQ_DTADP2 IS NULL, CHQ_DTADEP, CHQ_DTADP2) AS DATE) AS CHQ_DTADEP, ';
  Result := Result + '  CAST(IF(CHQ_DTADV2 IS NULL, CHQ_DTADEV, CHQ_DTADV2) AS DATE) AS CHQ_DTADEV, ';
  Result := Result + '  CHQ_DTAVEN, ';
  Result := Result + '  CHQ_VALCHQ, ';
  Result := Result + '  CHQ_NUMAGE, ';
  Result := Result + '  CHQ_NOMEMI, ';
  Result := Result + '  CHQ_TELCHE, ';
  Result := Result + '  CHQ_TELNUM, ';
  Result := Result + '  IF((CHQ_CTADEP = "REPASSE"), "Sim", "Não") AS CHQ_REPASS ';
  Result := Result + 'FROM ';
  Result := Result + '  CADCHQ ';
  Result := Result + 'INNER JOIN CADCLI ';
  Result := Result + '  ON CLI_CODCLI = CHQ_CODCLI ';
  Result := Result + 'WHERE (';
  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    Result := Result + '  CLI_CODRED = :REDE'
  Else
  Begin
    Result := Result + '  CLI_CODCLI = :CODCLI ';
    If fCfgSis('TRFTCR', varString) = '2' Then
    Begin
      Result := Result + '    OR CLI_CODRED = ';
      Result := Result + '    (SELECT ';
      Result := Result + '       CLI_CODRED ';
      Result := Result + '     FROM ';
      Result := Result + '       CADCLI ';
      Result := Result + '     WHERE CLI_CODCLI = :CODCLI) ';
    End;
  End;
  Result := Result + ' ) AND CHQ_INCCTR = "N" ';

  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMPCCC') = '1' Then
    Result := Result + '  AND CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

  If FVariaveisFiltro.TipoFiltro = 'A' Then
  Begin
    Result := Result + ' AND (((CHQ_DTADEP IS NULL) OR ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADEV IS NOT NULL)) ';

    if FVariaveisFiltro.ConsideraRepassados then
      Result := Result + ' OR (CHQ_CTADEP = "REPASSE" AND CHQ_DTAVEN >= CURDATE()) ';

    Result := Result + ') AND (COALESCE(CHQ_DEVDEF, 0) = 0))';

    If FVariaveisFiltro.Vencidos Then
      Result := Result + ' AND CHQ_DTAVEN <= :DTAINI '
    Else If Not fEmptyStr(fTiraCaracEspeciais(FVariaveisFiltro.DataInicial)) Then
      Result := Result + ' AND CHQ_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
  End
  Else
  Begin
    If FVariaveisFiltro.TipoFiltro = 'B' Then
    Begin
      Result := Result + ' AND (((NOT ((CHQ_DTADEP IS NULL) OR ((CHQ_DTADP2 IS NULL) AND (CHQ_DTADEV IS NOT NULL)))) ';

      if FVariaveisFiltro.ConsideraRepassados then
        Result := Result + ' AND (CHQ_CTADEP <> "REPASSE" OR (CHQ_CTADEP = "REPASSE" AND CHQ_DTAVEN < CURDATE())) ';

      Result := Result + ' ) OR (COALESCE(CHQ_DEVDEF, 0) = 1)) ';

      If Not fEmptyStr(fTiraCaracEspeciais(FVariaveisFiltro.DataInicial)) Then
        Result := Result + ' AND CHQ_DTADEP BETWEEN :DTAINI AND :DTAFIN ';
    End
    Else
    Begin
      If FVariaveisFiltro.Vencidos Then
        Result := Result + ' AND CHQ_DTAVEN <= :DTAINI '
      Else If Not fEmptyStr(fTiraCaracEspeciais(FVariaveisFiltro.DataInicial)) Then
        Result := Result + ' AND CHQ_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
    End;
  End;

  Result := Result + ' ORDER BY ';
  Result := Result + '   CHQ_CODEMP, CHQ_NUMCHQ ';
end;

function TMostraDebCtrChq2.RetornaSQLDtaVen: String;
begin
  Result := StringReplace(GetSqlDtaVen, 'TABELA.', 'CADREC.', [rfReplaceAll]);
  If FCheckBoxSelecionados.AjuDta Then
    Result := 'IF(CADREC.CTR_DTAREC IS NULL, ' + Result + ', ' +
                 'IF(CADREC.CTR_DTAREC <= FRETPROXDIAUTIL(CADREC.CTR_DTAVEN), FRETPROXDIAUTIL(CADREC.CTR_DTAVEN), ' +
                 Result + ')) ';
end;

function TMostraDebCtrChq2.GetSQLCADREC(ADuplicatasSelecionadas : String): String;
begin
  Result := '';
  Result := Result + ' (SELECT ' + #13;
  Result := Result + '    	CONCAT(CTR_NUMDUP, CTR_PARCEL, CTR_CODEMP, "-", CTR_ESPDOC, "-", IFNULL(CTR_SEQCON,""), "-", IFNULL(CTR_EMPBAI,"")) AS GRUPO, ' + #13;
  Result := Result + '    	CONCAT(CTR_NUMDUP, CTR_PARCEL, CTR_CODEMP, "-", CTR_SEQBAI) AS DUPLICATA,  ' + #13;
  Result := Result + '    	CONCAT(CTR_NUMDUP, CTR_PARCEL) AS NUMDUP,' + #13;
  Result := Result + '    	SUBSTR(CONCAT(POR_CODPOR, "-", POR_NOMPOR), 1, 25 ) AS PORTADOR, ' + #13;
  Result := Result + '    	CONCAT(CTR_NUMDUP, CTR_PARCEL, "-", CTR_SEQBAI) AS LEGENDA,' + #13;
  Result := Result + '    	CTR_ESPDOC AS ESPECIE, ' + #13;
  Result := Result + '    	CTR_CODEMP AS EMPRESA, ' + #13;
  Result := Result + '    	CTR_BCOBOL, ' + #13;
  Result := Result + '    	CTR_CODCLI, ' + #13;
  Result := Result + '    	"CADREC" AS TABROBO, ' + #13;
  Result := Result + '    (SELECT DET_NUM_PD ' + #13;
  Result := Result + '    	FROM MOVDET ' + #13;
  Result := Result + '    	WHERE DET_NUMDOC = CTR_NUMDUP ' + #13;
  Result := Result + '    	  AND DET_ESPDOC = CTR_ESPDOC ' + #13;
  Result := Result + '      	AND DET_CODEMP = CTR_CODEMP ' + #13;
  Result := Result + '      	AND DET_CODCLI = CTR_CODCLI ' + #13;
  Result := Result + '      	AND DET_ESP_PD = "PD" ' + #13;
  Result := Result + '    	GROUP BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODCLI) AS FGO_NUMDOC, ' + #13;
  Result := Result + '    CTR_NOSNUM, ' + #13;
  Result := Result + '    CTR_CODVEN AS VENDEDOR, ' + #13;
  Result := Result + '    CAST(IFNULL(CTR_HIST01, "") AS CHAR(900)) AS CTR_HIST01, ' + #13;
  Result := Result + '    CTR_HIST01 AS CTR_HIST99, ' + #13;
  Result := Result + '    IFNULL(CTR_HIST02, "") AS CTR_HIST02, ' + #13;
  Result := Result + '    CTR_CODREP AS REPRESENTANTE, ' + #13;
  Result := Result + '    CTR_DTACAD AS DATACADASTRO, ' + #13;
  Result := Result + '    CADREC.CTR_DTAVEN  AS DATAVENCIMENTO, ' + #13;
  Result := Result + '    CADREC.CTR_DTAVEN  AS DATAVENCIMENTOORDEM, ' + #13;
  Result := Result + '    CTR_VALORI AS VALORIAGR, ' + #13;
  Result := Result + '    CTR_VALORI AS VALORIRELATORIO, ' + #13;
  Result := Result + '    SUM(IFNULL( ' + #13;
  Result := Result + '      IF( ' + #13;
  Result := Result + '        CTR_SEQBAI = 0, ' + #13;
  Result := Result + '        IF( ' + #13;
  Result := Result + '          CTR_VALREC <> 0, ' + #13;
  Result := Result + '          CTR_VALREC + IFNULL(CTR_VALDES, 0) - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0), ' + #13;
  Result := Result + '          CTR_VALDUP ' + #13;
  Result := Result + '        ), ' + #13;
  Result := Result + '        CTR_VALORI ' + #13;
  Result := Result + '      ), ' + #13;
  Result := Result + '      0 ' + #13;
  Result := Result + '    ) + IF( ' + #13;
  Result := Result + '      CTR_DTAREC IS NULL, ' + #13;
  Result := Result + '      IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0), ' + #13;
  Result := Result + '      0 ' + #13;
  Result := Result + '    )) AS VALOR, ' + #13;
  Result := Result + '    SUM(' + GetSqlValOri + IIF(FCheckBoxSelecionados.Juros, '', ' - IF(CTR_DTAREC IS NULL, IFNULL(CTR_JURSUJ, 0.00), 0.00) ') + ') AS VALORORIGINAL,  ' + #13;
  Result := Result + '    SUM(' + GetSqlValDup + IIF(FCheckBoxSelecionados.Juros, '', ' - IF(CTR_DTAREC IS NULL, IFNULL(CTR_JURSUJ, 0.00), 0.00) ') + ') AS VALORDUPLICATA, ' + #13;
  Result := Result + '    SUM(' + GetSqlValorJuros(GetSqlValDup) + ') AS VALORJUROS, ' + #13;
  Result := Result + '    SUM(IF((CTR_DTAREC IS NULL AND CTR_DTAVEN >= CURRENT_DATE) OR (CTR_VALDUP < 0),  ' + #13;
  Result := Result +      GetSqlValDup + ',  ' + #13;
  Result := Result + '      ( '+ GetSqlValDup + ' + ('+ GetSqlValorJuros(GetSqlValDup) +')) ' + #13;
  Result := Result + '    )) AS VALORCORRIGIDO, ' + #13;
  Result := Result + '    CTR_DTAREC AS DATARECEBIMENTO, ' + #13;
  Result := Result + '    SUM(COALESCE(CTR_VALREC, 0)) AS VALORRECEBIDO, ' + #13;
  Result := Result + '    SUM(IF(CTR_VALREC > 0, CTR_VALREC - (IF(CTR_DTAREC IS NULL, CTR_VALDUP, CTR_VALREC - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0))), 0)) AS DIFERENCA, ' + #13;
  Result := Result + '    IF((' + FVariaveisFiltro.SQLDtaVen + ' >= IF(CTR_DTAREC IS NULL, CURRENT_DATE, CTR_DTAREC)) OR (CTR_VALORI < 0) , 0, ' + #13;
  Result := Result + '    IF(CTR_DTAREC <= FRETPROXDIAUTIL(CTR_DTAVEN), 0, DATEDIFF(IF(CTR_DTAREC IS NULL, ' + #13;
  Result := Result + '                 CURRENT_DATE, ' + #13;
  Result := Result + '                 CTR_DTAREC), ' + FVariaveisFiltro.SQLDtaVen + '))) AS DIASATRASO, ' + #13;
  Result := Result + '    CONCAT(CTR_NUMDUP, "-0", "-", CTR_SEQCON) AS ORDEM, ' + #13;
  Result := Result + '    CTR_ESPDOC AS ORDEM2, ' + #13;
  Result := Result + '    CTR_CODEMP AS EMPRESAAGRUP, ' + #13;
  Result := Result + '    IF(CTR_DTAREC IS NULL, "A", 0) AS STATUS1, ' + #13;
  Result := Result + '    IF(CTR_DTAREC IS NOT NULL, "B", 0) AS STATUS2, ' + #13;
  Result := Result + IIF(FVariaveisFiltro.TipoFiltro = 'T', '"2"', '"1"') + ' AS STATUS3, ' + #13;
  Result := Result + '    CADREC.CTR_NUMDUP, ' + #13;
  Result := Result + '    CADREC.CTR_PARCEL, ' + #13;
  Result := Result + '    CADREC.CTR_ESPDOC, ' + #13;
  Result := Result + '    CADREC.CTR_CODEMP, ' + #13;
  Result := Result + '    CADREC.CTR_SEQCON, ' + #13;
  Result := Result + '    CADREC.CTR_DTABAI, ' + #13;
  Result := Result + '    CADREC.CTR_SEQBAI, ' + #13;
  Result := Result + '    CADREC.CTR_EMPBAI, ' + #13;
  Result := Result + '    CADREC.AUTOINCREM, ' + #13;
  Result := Result + '    CADREC.CTR_CODPOR, ' + #13;
  Result := Result + '    CADREC.CTR_DTAVEN,  ' + #13;
  Result := Result + '    CADREC.CTR_DTAREC   ' + #13;
  Result := Result + ' FROM ' + #13;
  Result := Result + '  CADREC ' + #13;

  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    Result := Result + ' LEFT JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ' + #13;

  Result := Result + ' LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ' + #13;
  Result := Result + ' WHERE ' + GetWhareDuplicataTroco ;
  Result := Result + '   CADREC.AUTOINCREM IN (' + ADuplicatasSelecionadas + ') AND ' + #13;

  Result := Result + GetSQLWhereSelecionaProdutos + #13;
  Result := Result + ' GROUP BY GRUPO ) CADREC';
end;

function TMostraDebCtrChq2.GetSQLCamposEndereco: String;
begin
  Result := ' "" AS ENDERECO_ENTREGA, ';
  If FCheckBoxSelecionados.EndEre Then
  Begin
    Result := ' CONCAT(ENT.ETC_ENDENT, " - ", CONCAT(IFNULL(ENT.ETC_BAIENT, ""), " - ", IFNULL(CID.CID_NOMCID, ""), " - ",  ';
    Result := Result + ' CONCAT(IFNULL(CID.CID_ESTADO, ""), " - ", IFNULL(ENT.ETC_CEPENT, "")))) AS ENDERECO_ENTREGA,  ';
  End;
end;

function TMostraDebCtrChq2.GetSQLClienteRelatorio: String;
begin
  //CLIENTE
  Result := EmptyStr;
  Result := Result + 'SELECT ';
  Result := Result + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS NOME,     ';

  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    Result := Result + '  CONCAT(CLI_CODRED, "-", RED_DESRED) AS REDE,     '
  Else
    Result := Result + '  CLI_CODRED AS REDE,   ';

  Result := Result + '  CLI_FANSOB AS FANTASIA, ';
  Result := Result + '  CONCAT(CLI_ENDERE,", ",IFNULL(CLI_ENDNUM,""),"  ",IFNULL(CLI_ENDCOM,"")) AS ENDERECO, ';
  Result := Result + '  CONCAT(CLI_BAIRRO," - ",CONCAT(CID.CID_NOMCID," - ",CID.CID_ESTADO)," - ",SUBSTRING(CLI_C_E_P_,1,2),"." , ';
  Result := Result + '                                                                            SUBSTRING(CLI_C_E_P_,3,3),"-" , ';
  Result := Result + '                                                                            SUBSTRING(CLI_C_E_P_,6,3)) AS BAIRRO, ';
  Result := Result + '  CLI_EMAIL_ AS EMAIL, ';
  Result := Result + '  CLI_FONE01 AS TELEFONE1, ';
  Result := Result + '  CLI_FONE02 AS TELEFONE2, ';
  Result := Result + '  CLI_CGCCPF,              ';

  Result := Result + '  IF (CLI_CGCCPF = 1, CONCAT(SUBSTRING(CLI_C_G_C_,1,2),".", ';
  Result := Result + '                             SUBSTRING(CLI_C_G_C_,3,3),".", ';
  Result := Result + '                             SUBSTRING(CLI_C_G_C_,6,3),"/", ';
  Result := Result + '                             SUBSTRING(CLI_C_G_C_,9,4),"-", ';
  Result := Result + '                             SUBSTRING(CLI_C_G_C_,13,2)),   ';
  Result := Result + '                      CONCAT(SUBSTRING(CLI_C_G_C_,1,3),".", ';
  Result := Result + '                             SUBSTRING(CLI_C_G_C_,4,3),".", ';
  Result := Result + '                             SUBSTRING(CLI_C_G_C_,7,3),"/", ';
  Result := Result + '                             SUBSTRING(CLI_C_G_C_,10,2))) AS CLI_C_G_C_ , ';
  Result := Result + '  CLI_F_A_X_,            ';
  Result := Result + '  CLI_I_E_S_,            ';
  Result := Result + '  CLI_CONTAT AS CONTATO ';
  Result := Result + 'FROM         ';
  Result := Result + '  CADCLI CLI ';
  Result := Result + '  JOIN CADCID CID ON CID.CID_CODCID = CLI.CLI_CODCID ';

  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    Result := Result + '  JOIN CADRED ON RED_CODRED = CLI.CLI_CODRED  ';

  Result := Result + 'WHERE ';
  Result := Result + '  CLI_CODCLI = :CODCLI ';
end;

function TMostraDebCtrChq2.GetSqlDtaVen: String;
begin
  Result := ' TABELA.CTR_DTAVEN ';

  If FCheckBoxSelecionados.AjuDta Then
    Result :=  ' IF(fRetProxDiaUtil(TABELA.CTR_DTAVEN) >= CURRENT_DATE, ' +
               '    fRetProxDiaUtil(TABELA.CTR_DTAVEN),                 ' +
               '    TABELA.CTR_DTAVEN)                                  ';
end;

function TMostraDebCtrChq2.GetSQLEmpresaRelatorio: String;
begin
  //EMPRESA
  Result := EmptyStr;
  Result := Result + 'SELECT ';
  Result := Result + '  CONCAT(EMP_CODEMP,"-",EMP_NOMEMP) AS EMPRESA, ';
  Result := Result + '  CONCAT(EMP_ENDERE,", ",IFNULL(EMP_ENDNUM,""),"  ",IFNULL(EMP_ENDCMP,"")) AS ENDERECO, ';
  Result := Result + '  EMP_FONE01 AS TELEFONE1, ';
  Result := Result + '  EMP_FONE02 AS TELEFONE2, ';
  Result := Result + '  CONCAT(EMP_BAIRRO," - ",CONCAT(CID.CID_NOMCID," - ",IFNULL(CID.CID_ESTADO,""))) AS BAIRRO, ';
  Result := Result + '  CONCAT(CID.CID_CODCID ,"-", IFNULL(CID.CID_NOMCID,"")) AS CIDADE, ';
  Result := Result + '  EMP_C_E_P_ AS CEP, ';
  Result := Result + '  EMP_F_A_X_, ';
  Result := Result + '  EMP_CONTAT, ';
  Result := Result + '  EMP_EMAIL_, ';
  Result := Result + ' ' + fCurrentDate + ' AS DATA ';
  Result := Result + 'FROM ';
  Result := Result + '  CADEMP EMP ';
  Result := Result + '  JOIN CADCID CID ON CID.CID_CODCID = EMP.EMP_CODCID ';
  Result := Result + 'WHERE ';
  Result := Result + '  EMP_CODEMP = :CODEMP ';
end;

function TMostraDebCtrChq2.GetSQLJoinEndereco: String;
begin
  Result := EmptyStr;

  If FCheckBoxSelecionados.EndEre Then
  Begin
    //Se caso for true, preciso usar o campo AUTOINCREM da MOVGER
    If Not FCheckBoxSelecionados.Observacao Then
    Begin
      Result := Result + '  LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = CTR_NUMDUP AND ' + #13;
      Result := Result + '                      MOVGER.GER_ESPDOC = CTR_ESPDOC AND ' + #13;
      Result := Result + '                      MOVGER.GER_CODEMP = CTR_CODEMP AND ' + #13;
      Result := Result + '                      MOVGER.GER_CODCLI = CTR_CODCLI     ' + #13;
    End;

    Result := Result + ' LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ' + #13;
    Result := Result + ' LEFT JOIN ENTCLI ENT ON ENT.AUTOINCREM = AUXMOV.AUX_ENTGER ' + #13;
    Result := Result + ' LEFT JOIN CADCID CID ON CID.CID_CODCID = ENT.ETC_CIDENT ' + #13;
  End;
end;

function TMostraDebCtrChq2.GetSQLJoinObservacao: String;
begin
  Result := EmptyStr;

  If FCheckBoxSelecionados.Observacao Then
  Begin
    Result := Result + '  LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = CTR_NUMDUP AND ' + #13;
    Result := Result + '                      MOVGER.GER_ESPDOC = CTR_ESPDOC AND ' + #13;
    Result := Result + '                      MOVGER.GER_CODEMP = CTR_CODEMP AND ' + #13;
    Result := Result + '                      MOVGER.GER_CODCLI = CTR_CODCLI     ' + #13;
    Result := Result + '  LEFT JOIN NOTGER ON NOTGER.GER_NUMDOC = CTR_NUMDUP AND ' + #13;
    Result := Result + '                      NOTGER.GER_ESPDOC = CTR_ESPDOC AND ' + #13;
    Result := Result + '                      NOTGER.GER_CODEMP = CTR_CODEMP AND ' + #13;
    Result := Result + '                      NOTGER.GER_CODCLI = CTR_CODCLI     ' + #13;
  End;
end;

function TMostraDebCtrChq2.GetSQLJoinProduto: String;
begin
  Result := EmptyStr;

  If FCheckBoxSelecionados.Produto Then
  Begin
    Result := Result + '  LEFT JOIN MOVDET ON MOVDET.DET_NUMDOC = CTR_NUMDUP ' + #13;
    Result := Result + '                  AND MOVDET.DET_ESPDOC = CTR_ESPDOC ' + #13;
    Result := Result + '                  AND MOVDET.DET_CODEMP = CTR_CODEMP ' + #13;
    Result := Result + '                  AND MOVDET.DET_CODCLI = CTR_CODCLI ' + #13;
    Result := Result + '                  AND MOVDET.DET_PROEMB <> "S"       ' + #13;
    Result := Result + '                  AND MOVDET.DET_TIP_FC = "C"        ' + #13;
    Result := Result + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ' + #13;
    Result := Result + '  LEFT JOIN NOTDET ON NOTDET.DET_NUMDOC = CTR_NUMDUP ' + #13;
    Result := Result + '                  AND NOTDET.DET_ESPDOC = CTR_ESPDOC ' + #13;
    Result := Result + '                  AND NOTDET.DET_CODEMP = CTR_CODEMP ' + #13;
    Result := Result + '                  AND NOTDET.DET_PROEMB <> "S"       ' + #13;
    Result := Result + '                  AND NOTDET.DET_TIP_FC = "C"        ' + #13;
    Result := Result + '  LEFT JOIN CADUNI ON UNI_CODUNI =            ' + #13;
    Result := Result + '    IF(NOTDET.DET_UNIDAD IS NULL, MOVDET.DET_UNIDAD, NOTDET.DET_UNIDAD) ' + #13;
  End;
end;

function TMostraDebCtrChq2.GetSqlMovNot(strCampo: String): String;
begin
  Result := 'IF(NOTDET.' + strCampo +
            ' IS NULL, MOVDET.' + strCampo +
            ', NOTDET.' + strCampo + ') ';
end;

function TMostraDebCtrChq2.GetSqlValDup(strTabela: String = ''): String;
begin
  If FDescFinanSomenteAteVenc Then
    Result := ' IF((' + FVariaveisFiltro.SQLDtaVen + ' < CURDATE()), ' + #13 +
              ' (TABELA.CTR_VALDUP + IF(IFNULL(CTR_VALREC, 0) = 0, IFNULL(TABELA.CTR_VALJUR, 0), 0) + IFNULL(TABELA.CTR_JURSUJ, 0) + IFNULL(TABELA.CTR_DESCOB, 0) - 0), ' + #13 +
              ' (TABELA.CTR_VALDUP + IF(IFNULL(CTR_VALREC, 0) = 0, IFNULL(TABELA.CTR_VALJUR, 0), 0) + IFNULL(TABELA.CTR_JURSUJ, 0) + IFNULL(TABELA.CTR_DESCOB, 0) - IFNULL(TABELA.CTR_DESSUJ, 0))) ' + #13
  else
    Result := '  (TABELA.CTR_VALDUP + IF(IFNULL(CTR_VALREC, 0) = 0, IFNULL(TABELA.CTR_VALJUR, 0), 0) + IFNULL(TABELA.CTR_JURSUJ, 0) + IFNULL(TABELA.CTR_DESCOB, 0) - IFNULL(TABELA.CTR_DESSUJ, 0)) ' + #13;

  Result := StringReplace(Result, 'TABELA.', IIF(fEmptyStr(strTabela), '', strTabela + '.'), [rfReplaceAll]);
end;

function TMostraDebCtrChq2.GetSqlValOri(ASomaAgr: Boolean = False): String;
begin
  Result := ' IFNULL(IF(CTR_SEQBAI = 0,IF(CTR_VALREC <> 0, CTR_VALREC + IFNULL(CTR_VALDES, 0) - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0), CTR_VALDUP), CTR_VALORI), 0) + ' +
            '         IF(CTR_DTAREC IS NULL, IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0), 0) ';

  If ASomaAgr Then
    Result := ' IFNULL(IF(AGR.CTR_SEQBAI = 0, AGR.CTR_VALDUP, AGR.CTR_VALORI), 0) + ' +
              '        IFNULL(AGR.CTR_JURSUJ, 0) + IFNULL(AGR.CTR_DESCOB, 0) - IFNULL(AGR.CTR_DESSUJ, 0) ';
end;

function TMostraDebCtrChq2.GetSqlTaxaJuros: String;
begin
  Result := '( ( ( ( ' + AnsiReplaceStr(FloatToStr(fCfgSis('JURATR', varDouble)),',','.') + ' / 30 ) * DATEDIFF(CURRENT_DATE, ' + FVariaveisFiltro.SQLDtaVen + ') ) )' +
                 ' + ' + AnsiReplaceStr(FloatToStr(fCfgSis('MULATR', varDouble)),',','.') + ' )' + #13 ;
end;

function TMostraDebCtrChq2.GetSqlTolerancia: String;
begin
  Result := 'IF(DATEDIFF(CURRENT_DATE, ' + FVariaveisFiltro.SQLDtaVen + ') > ' + fCfgSis('TOLATR') + ', TRUE, FALSE)' + #13;
end;

function TMostraDebCtrChq2.GetSqlValorJuros(strValDup: String): String;
begin
  Result := 'IF((' + strValDup + ' > 0.00) AND ' + GetSqlTolerancia + ' AND (' + FVariaveisFiltro.SQLDtaVen + ' < CURRENT_DATE), ' +
            '   (' + strValDup + ' * ( ' + GetSqlTaxaJuros + ' / 100 ) ), ' +
                    ' IF(IFNULL(CTR_VALREC, 0) = 0, IFNULL(TABELA.CTR_VALJUR, 0), 0.00))' + #13;
end;

function TMostraDebCtrChq2.GetSQLWhereSelecionaProdutos: String;
begin
  Result := EmptyStr;

  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    Result := Result + ' CLI_CODRED = :REDES  ' + #13
  Else
    Result := Result + '   CTR_CODCLI = :CODCLI ' + #13;

  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMPCCC') = '1' Then
    Result := Result + '  AND CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ' + #13;

  If Not fEmptyStr(FVariaveisFiltro.CodigoPortador) Then
    Result := Result + '  AND CTR_CODPOR IN (' + fRetArrToSQLIn(FVariaveisFiltro.ArrPortador, LeftStr(FVariaveisFiltro.CodigoPortador, 5)) + ') ' + #13;

  If FVariaveisFiltro.TipoFiltro = 'A' Then
    Result := Result + ' AND CTR_DTAREC IS NULL '  + #13
  Else If FVariaveisFiltro.TipoFiltro = 'B' Then
    Result := Result + ' AND CTR_DTAREC IS NOT NULL ' + #13;
end;

function TMostraDebCtrChq2.GetSQLJoinObservacaoAgr: String;
Begin
  Result := EmptyStr;

  If (FCheckBoxSelecionados.Observacao) Then
  Begin
    Result := Result + ' INNER JOIN MOVGER ON GER_NUMDOC = AGR.CTR_NUMDUP AND ' + #13;
    Result := Result + '                      GER_ESPDOC = AGR.CTR_ESPDOC AND ' + #13;
    Result := Result + '                      GER_CODEMP = AGR.CTR_CODEMP AND ' + #13;
    Result := Result + '                      GER_CODCLI = AGR.CTR_CODCLI     ' + #13;
  End;
End;

function TMostraDebCtrChq2.GetSQLJoinProdutoAgr: String;
Begin
  Result := EmptyStr;

  If (FCheckBoxSelecionados.Produto) Then
  Begin
    Result := Result + '  INNER JOIN MOVDET ON DET_NUMDOC = AGR.CTR_NUMDUP ' + #13;
    Result := Result + '                   AND DET_ESPDOC = AGR.CTR_ESPDOC ' + #13;
    Result := Result + '                   AND DET_CODEMP = AGR.CTR_CODEMP ' + #13;
    Result := Result + '                   AND DET_CODCLI = AGR.CTR_CODCLI ' + #13;
    Result := Result + '                   AND DET_PROEMB <> "S"           ' + #13;
    Result := Result + '                   AND DET_TIP_FC = "C"            ' + #13;
    Result := Result + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ' + #13;
    Result := Result + '  LEFT  JOIN CADUNI ON UNI_CODUNI = DET_UNIDAD         ' + #13;
  End;
End;

function TMostraDebCtrChq2.GetSQLJoinEnderecoAgr: String;
Begin
  Result := EmptyStr;

  If (FCheckBoxSelecionados.EndEre) Then
  Begin
    //Se caso for true, preciso usar o campo AUTOINCREM da MOVGER
    If Not (FCheckBoxSelecionados.Observacao) Then
    Begin
      Result := Result + ' INNER JOIN MOVGER ON GER_NUMDOC = AGR.CTR_NUMDUP AND ' + #13;
      Result := Result + '                      GER_ESPDOC = AGR.CTR_ESPDOC AND ' + #13;
      Result := Result + '                      GER_CODEMP = AGR.CTR_CODEMP AND ' + #13;
      Result := Result + '                      GER_CODCLI = AGR.CTR_CODCLI     ' + #13;
    End;

    Result := Result + ' LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ' + #13;
    Result := Result + ' LEFT JOIN ENTCLI ENT ON ENT.AUTOINCREM = AUXMOV.AUX_ENTGER ' + #13;
    Result := Result + ' LEFT JOIN CADCID CID ON CID.CID_CODCID = ENT.ETC_CIDENT ' + #13;
  End;
End;

function TMostraDebCtrChq2.GetSQLWhereSelecionaProdutosAgr: String;
Begin
  Result := EmptyStr;

  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    Result := Result + '  CLI.CLI_CODRED = :REDES AND  ' + #13
  Else
    Result := Result + '  REC.CTR_CODCLI = :CODCLI AND  ' + #13;

  Result := Result + '  REC.CTR_SEQBAI = 0 AND  ';

  //Somente das empresas que o operador tem direito de acesso.
  If fCfgSis('EMPCCC') = '1' Then
    Result := Result + '  REC.CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') AND ' + #13;

  If Not fEmptyStr(FVariaveisFiltro.CodigoPortador) Then
    Result := Result + ' REC.CTR_CODPOR IN (' + fRetArrToSQLIn(FVariaveisFiltro.ArrPortador, LeftStr(FVariaveisFiltro.CodigoPortador, 5)) + ') AND ' + #13;

  Result := Result + '  REC.CTR_ESPDOC = "AG"         ' + #13;

  If FVariaveisFiltro.TipoFiltro = 'A' Then
    Result := Result + '  AND REC.CTR_DTAREC IS NULL     ' + #13
  Else If FVariaveisFiltro.TipoFiltro = 'B' Then
    Result := Result + '  AND REC.CTR_DTAREC IS NOT NULL ' + #13;
End;

class function TMostraDebCtrChq2.GetWhareDuplicataTroco: string;
begin
  Result := '(SELECT                                                             '+
            '  AUTOINCREM                                                        '+
            'FROM                                                                '+
            '  LOGCTR                                                            '+
            'WHERE LOGCTR.CTR_NUMDUP = CADREC.CTR_NUMDUP                         '+
            '  AND LOGCTR.CTR_PARCEL = CADREC.CTR_PARCEL                         '+
            '  AND LOGCTR.CTR_ESPDOC = CADREC.CTR_ESPDOC                         '+
            '  AND LOGCTR.CTR_CODEMP = CADREC.CTR_CODEMP                         '+
            '  AND LOGCTR.CTR_CODCLI = CADREC.CTR_CODCLI                         '+
            '  AND LOGCTR.CTR_SEQBAI = 0                                         '+
            '  AND LOGCTR.CTR_DTAREC IS NOT NULL                                 '+
            '  AND LOGCTR.CTR_VALREC < 0                                         '+
            '  AND LOGCTR.CTR_ESPDOC = "CC"                                      '+
            '  AND LOGCTR.CTR_DESCRI IN ("INCLUSÃO", "INCLUSÃO LD")) IS NULL AND ';
end;

class function TMostraDebCtrChq2.TravaInsercaoRegistros(AInserir: Boolean): Boolean;
begin
  Result := fLock_Unlock('INSERT_AVISO_DEBITO',
                         AInserir,
                         False,
                         False,
                         '',
                         False,
                         IIF(Not AInserir, 'INSERT_AVISO_DEBITO', ''));

  If Not AInserir Then
    Exit;

  If Not Result Then
  Begin
    if fGetTempoDuracaoLock('INSERT_AVISO_DEBITO') > StrToTime('00:20:00') Then
    Begin
      fLock_Unlock('INSERT_AVISO_DEBITO',
                   False,
                   False,
                   False,
                   '',
                   False,
                   'INSERT_AVISO_DEBITO');

      Result := fLock_Unlock('INSERT_AVISO_DEBITO',
                             True,
                             False,
                             False,
                             '',
                             False);
    End
    Else
      Exit;
  End;
end;

function TMostraDebCtrChq2.GetSQLAgrupadas(ADuplicatasSelecionadas: String): String;
Begin
  Result := EmptyStr;

  If Not FCheckBoxSelecionados.DocAg Then
    Exit;

  FVariaveisFiltro.SQLDtaVen := StringReplace(GetSqlDtaVen, 'TABELA.', 'AGR.', [rfReplaceAll]);

  Result := Result + 'SELECT                                                      ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Observacao, 'GER_MEN001', 'NULL') + ' AS OBS001,     ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Observacao, 'GER_MEN002', 'NULL') + ' AS OBS002,     ' + #13;
  Result := Result + '  CONCAT(AGR.CTR_NUMDUP, AGR.CTR_PARCEL, "-", AGR.CTR_ESPDOC, "-", REC.CTR_SEQBAI) AS GRUPO, ' + #13;
  Result := Result + '  CONCAT(AGR.CTR_NUMDUP, AGR.CTR_PARCEL, "-", REC.CTR_SEQBAI) AS DUPLICATA, ' + #13;
  Result := Result + '  CONCAT(AGR.CTR_NUMDUP, AGR.CTR_PARCEL) AS NUMDUP, ' + #13;
  Result := Result + '  CONCAT(AGR.CTR_NUMAGR, "-AG-", REC.CTR_SEQBAI) AS LEGENDA,  ' + #13;
  Result := Result + '  SUBSTR(CONCAT(POR_CODPOR, "-", POR_NOMPOR), 1, 25 ) AS PORTADOR, ' + #13;
  Result := Result + '  AGR.CTR_ESPDOC AS ESPECIE,                                ' + #13;
  Result := Result + '  AGR.CTR_CODEMP AS EMPRESA,                                ' + #13;
  Result := Result + '  REC.CTR_NOSNUM,                                           ' + #13;
  Result := Result + '  REC.CTR_BCOBOL,                                           ' + #13;
  Result := Result + '  REC.CTR_CODCLI,                                           ' + #13;
  Result := Result + '  "DUPAGR" AS TABROBO,                                       ' + #13;

  Result := Result + ' (SELECT                               ';
  Result := Result + '    DET_NUM_PD                         ';
  Result := Result + '  FROM                                 ';
  Result := Result + '    MOVDET                             ';
  Result := Result + '  WHERE                                ';
  Result := Result + '    DET_NUMDOC = AGR.CTR_NUMDUP AND    ';
  Result := Result + '    DET_ESPDOC = AGR.CTR_ESPDOC AND    ';
  Result := Result + '    DET_CODEMP = AGR.CTR_CODEMP AND    ';
  Result := Result + '    DET_CODCLI = AGR.CTR_CODCLI AND    ';
  Result := Result + '    DET_ESP_PD = "PD"                  ';
  Result := Result + '  GROUP BY                             ';
  Result := Result + '    DET_NUMDOC,                        ';
  Result := Result + '    DET_ESPDOC,                        ';
  Result := Result + '    DET_CODEMP,                        ';
  Result := Result + '    DET_CODCLI) AS FGO_NUMDOC,         ';

  Result := Result + '  AGR.CTR_CODVEN AS VENDEDOR,                               ' + #13;
  Result := Result + '  CAST(IFNULL(AGR.CTR_HIST01, "") AS CHAR(900)) AS CTR_HIST01, ' + #13;
  Result := Result + '  AGR.CTR_HIST01 AS CTR_HIST99,                             ' + #13;
  Result := Result + '  IFNULL(AGR.CTR_HIST02, ""),                               ' + #13;
  Result := Result + '  AGR.CTR_CODREP AS REPRESENTANTE,                          ' + #13;
  Result := Result + '  AGR.CTR_DTACAD AS DATACADASTRO,                           ' + #13;
  Result := Result + '  AGR.CTR_DTAVEN AS DATAVENCIMENTO,                         ' + #13;
  Result := Result + '  REC.CTR_DTAVEN AS DATAVENCIMENTOORDEM,                    ' + #13;
  Result := Result + '  AGR.CTR_VALORI AS VALORIAGR,                              ' + #13;
  Result := Result + GetSqlValOri(True) + ' AS VALORIRELATORIO,                  ' + #13;
  Result := Result + '  IFNULL(IF(REC.CTR_SEQBAI = 0, IF(REC.CTR_VALREC <> 0, REC.CTR_VALREC + IFNULL(REC.CTR_VALDES,0) - IFNULL(REC.CTR_VALJUR,0) - IFNULL(REC.CTR_VALCOB,0), AGR.CTR_VALDUP), AGR.CTR_VALORI), 0) + ' + #13;
  Result := Result + '  IF(REC.CTR_DTAREC IS NULL, IFNULL(REC.CTR_JURSUJ, 0) + IFNULL(REC.CTR_DESCOB, 0) - IFNULL(REC.CTR_DESSUJ, 0), 0) AS VALOR, ' + #13;
  Result := Result + GetSqlValOri(True) + ' AS VALORORIGINAL, ' + #13;
  Result := Result + GetSqlValOri(True) + ' AS VALORDUPLICATA,                     ' + #13;
  Result := Result + ' (IFNULL(AGR.CTR_VALJUR, 0) - IFNULL(AGR.CTR_VALDES, 0))  AS VALORJUROS, ';
  Result := Result + GetSqlValOri(True) + ' + IFNULL(AGR.CTR_VALJUR, 0) - IFNULL(AGR.CTR_VALDES, 0) AS VALORCORRIGIDO, ';
  Result := Result + '  REC.CTR_DTAREC AS DATARECEBIMENTO,                        ' + #13;
  Result := Result + '  0.00 AS VALORRECEBIDO,                          ' + #13;
  Result := Result + '  0.00 AS DIFERENCA,                                        ' + #13;
  Result := Result + '  0 AS DIASATRASO, ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'DET_CODITE', 'NULL') + ' AS CODITEM,       ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'DET_DESCRI', 'NULL') + ' AS DESCRICAOITEM, ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'UNI_DESUNI', 'NULL') + ' AS UNIDADE,       ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'MOVTRI.DET_VFCPST', '0.00') + ' AS VFCPST, ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_VALIPI, DET_VALIPI)', '0.00') + ' AS VALIPI,      ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESACE, DET_DESACE)', '0.00') + ' AS DESACE,      ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_VALRET, DET_VALRET)', '0.00') + ' AS VALRET,      ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE)', '0.00') + ' AS QTDEITEM,      ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNITAR, DET_UNITAR)', '0.00') + ' AS UNITARIOITEM,  ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_UNIORI, DET_UNIORI)', '0.00') + ' AS UNIORIITEM,    ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTITE, DET_TOTITE)', '0.00') + ' AS TOTALITEM,     ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -(DET_TOTITE - DET_DESESP), (DET_TOTITE - DET_DESESP))', '0.00') + ' AS TOTALDOITEM,     ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESESP, DET_DESESP)', '0.00') + ' AS TOTALDESESP,   ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_DESCON, DET_DESCON)', '0.00') + ' AS DESCONTOITEM,  ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(DET_CLAFIS,1) < 5, -DET_TOTFRE, DET_TOTFRE)', '0.00') + ' AS TOTALFRETE,    ' + #13;

  Result := Result + GetSQLCamposEndereco;

  Result := Result + 'CONCAT(AGR.CTR_NUMAGR,"-", AGR.CTR_SEQCON, "-1") AS ORDEM, ';
  Result := Result + '  "AH" AS ORDEM2,                                           ' + #13;
  Result := Result + ' REC.CTR_CODEMP AS EMPRESAAGRUP, ' + #13;
  Result := Result + '  IF(CTR_DTAREC IS NULL, "A", 0) AS STATUS1,                ' + #13;
  Result := Result + '  IF(CTR_DTAREC IS NOT NULL, "B", 0) AS STATUS2,            ' + #13;
  Result := Result + IIF(FVariaveisFiltro.TipoFiltro = 'T', '"2"', '"1"') + ' AS STATUS3,           ' + #13;
  Result := Result + 'CONCAT(' + IIF(FCheckBoxSelecionados.DtaVen, 'REC.CTR_DTAVEN,', '');
  Result := Result + 'CONCAT(REC.CTR_NUMDUP, REC.CTR_PARCEL, "-", REC.CTR_SEQBAI), "AH", REC.CTR_ESPDOC, ';
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'DET_CODITE', '""') + ') AS CHAVE ';
  Result := Result + 'FROM         ' + #13;
  Result := Result + '  CADREC REC ' + #13;
  Result := Result + '  JOIN DUPAGR AGR ON AGR.CTR_NUMAGR = REC.CTR_NUMDUP AND ' + #13;
  Result := Result + '                     AGR.CTR_CODCLI = REC.CTR_CODCLI AND ' + #13;
  Result := Result + '                     AGR.CTR_EMPAGR = REC.CTR_CODEMP     ' + #13;

  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    Result := Result + '  LEFT JOIN CADCLI CLI ON REC.CTR_CODCLI = CLI.CLI_CODCLI ' + #13;

  Result := Result + '  LEFT JOIN CADPOR ON AGR.CTR_CODPOR = POR_CODPOR        ' + #13;

  Result := Result + GetSQLJoinObservacaoAgr;

  Result := Result + GetSQLJoinProdutoAgr;

  Result := Result + GetSQLJoinEnderecoAgr;


  Result := Result + 'WHERE                           ' + #13;

  Result := Result + '   REC.AUTOINCREM IN (' + ADuplicatasSelecionadas + ') AND ' + #13;

  Result := Result + GetSQLWhereSelecionaProdutosAgr;

  If (FCheckBoxSelecionados.Produto) Then
  Begin
    Result := Result + 'GROUP BY AGR.CTR_NUMAGR, AGR.CTR_NUMDUP, AGR.CTR_PARCEL, AGR.CTR_CODEMP, AGR.CTR_CODCLI, MOVDET.AUTOINCREM ' + #13;

    Result := Result + '  UNION ALL ' + AnsiReplaceStr(
                                        AnsiReplaceStr(Result, 'MOVGER', 'NOTGER'),
                                                               'MOVDET', 'NOTDET');
  End
  Else
    Result := Result + ' GROUP BY AGR.CTR_NUMDUP,AGR.CTR_PARCEL,AGR.CTR_ESPDOC,AGR.CTR_CODEMP,AGR.CTR_CODCLI,AGR.CTR_SEQBAI';


  Result := AnsiReplaceStr(Result, 'TABELA', 'AGR');
End;

function TMostraDebCtrChq2.SelecionaProdutosContasReceber(ADuplicatasSelecionadas: String = ''): String;
  Var
    LSQLAgrupadas: String;
begin
  FVariaveisFiltro.SQLDtaVen := RetornaSQLDtaVen;

  Result := '';
  Result := Result + '  SELECT                                                ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Observacao, 'IF(MOVGER.GER_MEN001 IS NULL, NOTGER.GER_MEN001, MOVGER.GER_MEN001)', 'NULL') + ' AS OBS001, ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Observacao, 'IF(MOVGER.GER_MEN002 IS NULL, NOTGER.GER_MEN002, MOVGER.GER_MEN002)', 'NULL') + ' AS OBS002, ' + #13;
  Result := Result + '    CADREC.GRUPO, ' + #13;
  Result := Result + '    CADREC.DUPLICATA,    ' + #13;
  Result := Result + '    CADREC.NUMDUP,    ' + #13;
  Result := Result + '    CADREC.LEGENDA,      ' + #13;
  Result := Result + '    CADREC.PORTADOR, ' + #13;
  Result := Result + '    CADREC.ESPECIE, ' + #13;
  Result := Result + '    CADREC.EMPRESA, ' + #13;
  Result := Result + '    CADREC.CTR_BCOBOL, ' + #13;
  Result := Result + '    CADREC.CTR_CODCLI, ' + #13;
  Result := Result + '    CADREC.TABROBO, ' + #13;
  Result := Result + '    CADREC.FGO_NUMDOC, ' + #13;

  Result := Result + '    CADREC.CTR_NOSNUM, ' + #13;
  Result := Result + '    CADREC.VENDEDOR, ' + #13;
  Result := Result + '    CADREC.CTR_HIST01, ' + #13;
  Result := Result + '    CADREC.CTR_HIST99, ' + #13;
  Result := Result + '    CADREC.CTR_HIST02, ' + #13;
  Result := Result + '    CADREC.REPRESENTANTE, ' + #13;
  Result := Result + '    CADREC.DATACADASTRO, ' + #13;
  Result := Result + '    CADREC.DATAVENCIMENTO, ' + #13;
  Result := Result + '    CADREC.DATAVENCIMENTOORDEM, ' + #13;
  Result := Result + '    CADREC.VALORIAGR, ' + #13;
  Result := Result + '    CADREC.VALORIRELATORIO, ' + #13;
  Result := Result + '    CADREC.VALOR, ' + #13;
  Result := Result + '    CADREC.VALORORIGINAL, ';
  Result := Result + '    CADREC.VALORDUPLICATA, ' + #13;
  Result := Result + '    CADREC.VALORJUROS, ' + #13;
  Result := Result + '    CADREC.VALORCORRIGIDO, ' + #13;
  Result := Result + '    CADREC.DATARECEBIMENTO, ' + #13;
  Result := Result + '    CADREC.VALORRECEBIDO, ' + #13;
  Result := Result + '    CADREC.DIFERENCA, ' + #13;
  Result := Result + '    CADREC.DIASATRASO, ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, GetSqlMovNot('DET_CODITE'), 'NULL') + ' AS CODITEM,       ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, GetSqlMovNot('DET_DESCRI'), 'NULL') + ' AS DESCRICAOITEM, ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'UNI_DESUNI', 'NULL') + ' AS UNIDADE,       ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'MOVTRI.DET_VFCPST', '0.00') + ' AS VFCPST, ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_VALIPI') + ', ' + GetSqlMovNot('DET_VALIPI') + ')', '0.00') + ' AS VALIPI,        ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_DESACE') + ', ' + GetSqlMovNot('DET_DESACE') + ')', '0.00') + ' AS DESACE,        ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_VALRET') + ', ' + GetSqlMovNot('DET_VALRET') + ')', '0.00') + ' AS VALRET,        ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_QTDITE') + ', ' + GetSqlMovNot('DET_QTDITE') + ')', '0.00') + ' AS QTDEITEM,      ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_UNITAR') + ', ' + GetSqlMovNot('DET_UNITAR') + ')', '0.00') + ' AS UNITARIOITEM,  ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_UNIORI') + ', ' + GetSqlMovNot('DET_UNIORI') + ')', '0.00') + ' AS UNIORIITEM,    ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_TOTITE') + ', ' + GetSqlMovNot('DET_TOTITE') + ')', '0.00') + ' AS TOTALITEM,     ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -(' + GetSqlMovNot('DET_TOTITE') + ' - ' + GetSqlMovNot('DET_DESESP') +'), (' + GetSqlMovNot('DET_TOTITE') + ' - '+ GetSqlMovNot('DET_DESESP') +'))', '0.00') + ' AS TOTALDOITEM,     ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_DESESP') + ', ' + GetSqlMovNot('DET_DESESP') + ')', '0.00') + ' AS TOTALDESESP,   ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_DESCON') + ', ' + GetSqlMovNot('DET_DESCON') + ')', '0.00') + ' AS DESCONTOITEM,  ' + #13;
  Result := Result + IIF(FCheckBoxSelecionados.Produto, 'IF(LEFT(' + GetSqlMovNot('DET_CLAFIS') + ',1) < 5, -' + GetSqlMovNot('DET_TOTFRE') + ', ' + GetSqlMovNot('DET_TOTFRE') + ')', '0.00') + ' AS TOTALFRETE,    ' + #13;

  Result := Result + GetSQLCamposEndereco;

  Result := Result + ' CADREC.ORDEM,   ';
  Result := Result + ' CADREC.ORDEM2, ' + #13;
  Result := Result + ' CADREC.EMPRESAAGRUP, ' + #13;
  Result := Result + ' CADREC.STATUS1, ' + #13;
  Result := Result + ' CADREC.STATUS2, ' + #13;
  Result := Result + ' CADREC.STATUS3, ' + #13;
  Result := Result + ' CONCAT(' + IIF(FCheckBoxSelecionados.DtaVen, FVariaveisFiltro.SQLDtaVen + ',', '');
  Result := Result + ' CONCAT(CTR_NUMDUP, CTR_PARCEL, "-", CTR_SEQBAI), CTR_CODEMP, CTR_ESPDOC, ';
  Result := Result + IIF(FCheckBoxSelecionados.Produto, GetSqlMovNot('DET_CODITE'), '""') + ') AS CHAVE ';

  Result := Result + 'FROM     ' + #13;
  Result := Result + GetSQLCADREC(ADuplicatasSelecionadas) + #13;
  If Not fEmptyStr(FVariaveisFiltro.RedeLoja) Then
    Result := Result + '  LEFT JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ' + #13;

  Result := Result + '  LEFT JOIN CADPOR ON CTR_CODPOR = POR_CODPOR ' + #13;

  Result := Result + GetSQLJoinObservacao;

  Result := Result + GetSQLJoinProduto;

  Result := Result + GetSQLJoinEndereco;

  Result := Result + ' WHERE ' + GetWhareDuplicataTroco ;
  Result := Result + '   CADREC.AUTOINCREM IN (' + ADuplicatasSelecionadas + ') AND ' + #13;

  Result := Result + GetSQLWhereSelecionaProdutos;

  Result := Result + ' GROUP BY GRUPO' + IIF(FCheckBoxSelecionados.Produto, ' ,' + GetSqlMovNot('AUTOINCREM'),'');

  Result := AnsiReplaceStr(Result, 'TABELA', 'CADREC');

  LSQLAgrupadas := GetSQLAgrupadas(ADuplicatasSelecionadas);

  If Not LSQLAgrupadas.IsEmpty Then
    Result := Result + ' UNION ALL ' + LSQLAgrupadas;

  Result := Result + '  ORDER BY                   ';

  If Not (FVariaveisFiltro.Ordem In [0, 1, 2]) Then
  Begin
    If (FCheckBoxSelecionados.DtaVen) Then
      Result := Result + '    GRUPO ,DATAVENCIMENTOORDEM, CHAVE, ORDEM, ORDEM2 ' + #13
    Else
      Result := Result + '     GRUPO ,CHAVE, ORDEM, ORDEM2 ' + #13;
  End
  Else
  Begin
    Case (FVariaveisFiltro.Ordem) Of
      0: Result := Result + '    GRUPO, DATAVENCIMENTOORDEM, CHAVE, ORDEM, ORDEM2 ' + #13; //No. Documento
      1: Result := Result + '    DATAVENCIMENTOORDEM, GRUPO, CHAVE, ORDEM, ORDEM2 ' + #13; //Data Vencimento
      2: Result := Result + '    DATACADASTRO, GRUPO, CHAVE, ORDEM, ORDEM2 ' + #13; //Data Cadastro7
    End;
  End;
end;

{ TMonitorAvisoDebito }

class function TMonitorAvisoDebito.GetExeName: String;
begin
  Result := 'EnviaEmailBoletoMonitor.exe';
end;

class function TMostraDebCtrChq2.fRetornaCdsPortadorAut(intTip : Integer; ACodGru, ACodCfg, ACodEmp : String ): TUniClientDataSet;
Var
    LQryPor  : TUniQuery;
    strSqlEmail,
    strSqlSMS,
    strSqlWhatsapp : String;
Begin

  Try

    // EMAIL
    strSqlEmail := '';
    strSqlEmail := strSqlEmail + ' SELECT PORAEN.AEN_CODPOR FROM EMASAI ';
    strSqlEmail := strSqlEmail + '  INNER JOIN PORAEN  ON EMASAI.EMA_CODGRU = PORAEN.AEN_CODGRU ';
    strSqlEmail := strSqlEmail + '                    AND EMASAI.EMA_CODIGO = PORAEN.AEN_CODCFG ';
    strSqlEmail := strSqlEmail + '                    AND EMASAI.EMA_CODEMP = PORAEN.AEN_CODEMP ';
    strSqlEmail := strSqlEmail + '  WHERE PORAEN.AEN_CODGRU = :CODGRU ';
    strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODCFG = :CODCFG ';
    strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODEMP = :CODEMP ';
    strSqlEmail := strSqlEmail + '    AND PORAEN.AEN_CODTIP = 0       ';
    strSqlEmail := strSqlEmail + '    AND EMASAI.EMA_STATUS = ''A''   ';

    // SMS
    strSqlSMS := '';
    strSqlSMS := strSqlSMS + ' SELECT PORAEN.AEN_CODPOR FROM SMSSAI ';
    strSqlSMS := strSqlSMS + '  INNER JOIN PORAEN  ON SMSSAI.SMS_CODGRU = PORAEN.AEN_CODGRU ';
    strSqlSMS := strSqlSMS + '                    AND SMSSAI.SMS_CODIGO = PORAEN.AEN_CODCFG ';
    strSqlSMS := strSqlSMS + '                    AND SMSSAI.SMS_CODEMP = PORAEN.AEN_CODEMP ';
    strSqlSMS := strSqlSMS + ' WHERE PORAEN.AEN_CODGRU    = :CODGRU ';
    strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODCFG = :CODCFG ';
    strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODEMP = :CODEMP ';
    strSqlSMS := strSqlSMS + '    AND   PORAEN.AEN_CODTIP = 1       ';
    strSqlSMS := strSqlSMS + '    AND   SMSSAI.SMS_STATUS = ''A''   ';

    // Whatsapp
    strSqlWhatsapp := '';
    strSqlWhatsapp := strSqlWhatsapp + ' SELECT PORAEN.AEN_CODPOR FROM WPPSAI ';
    strSqlWhatsapp := strSqlWhatsapp + '  INNER JOIN PORAEN  ON WPPSAI.WPP_CODGRU = PORAEN.AEN_CODGRU ';
    strSqlWhatsapp := strSqlWhatsapp + '                    AND WPPSAI.WPP_CODIGO = PORAEN.AEN_CODCFG ';
    strSqlWhatsapp := strSqlWhatsapp + '                    AND WPPSAI.WPP_CODEMP = PORAEN.AEN_CODEMP ';
    strSqlWhatsapp := strSqlWhatsapp + ' WHERE PORAEN.AEN_CODGRU    = :CODGRU ';
    strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODCFG = :CODCFG ';
    strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODEMP = :CODEMP ';
    strSqlWhatsapp := strSqlWhatsapp + '    AND   PORAEN.AEN_CODTIP = 2       ';
    strSqlWhatsapp := strSqlWhatsapp + '    AND   WPPSAI.WPP_STATUS = ''A''   ';

    LQryPor   := fCriaQuery;

    If intTip = 0 Then //email
       LQryPor.SQL.Text := strSqlEmail
    Else If intTip = 1 Then //sms
       LQryPor.SQL.Text := strSqlSMS
    Else If intTip = 2 Then //whatsapp
       LQryPor.SQL.Text := strSqlWhatsapp;

    LQryPor.Parambyname('CODGRU').value := ACodGru;
    LQryPor.Parambyname('CODCFG').value := ACodCfg;
    LQryPor.Parambyname('CODEMP').value := ACodEmp;
    LQryPor.Open;

    Result := fCriaClientDatSet(LQryPor);

  Finally
    FreeAndNil(LQryPor);
  End;

End;

end.
