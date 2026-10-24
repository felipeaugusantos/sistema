unit untMercadoLivrePgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.DateUtils, System.Generics.Collections,
     Data.DB,

     BitBtnLockedIncrem, cxProgressBar, Uni, UniClientDataset,

     untTMercadoLivreFuncoes, untMercadoLivreTipos,
     untIMercadoLivreIntegracaoLibCartoes;

Type
  TMercadoLivrePgto = class(TInterfacedObject, ICartoesMercadoLivre)
  Private
    FTamandoCampoMER_CODAUT,
    FPosicaoAtualData,
    FPosicaoNoArquivo,
    FColunasArquivo: Integer;

    FDataRegistroArquivo,
    FTextoLinhaAnterior: String;

    function fRetVal(strVal: Variant; blnData: Boolean = False; blnCompleta: Boolean = True; AGMT: Integer = -3): Variant;

    function RegistroJaImportado(ARegistro: TRegistroPgto): Boolean;
    procedure AtualizaPosicaoDoDiaNoArquivo(ARegistro: TRegistroPgto);

    function RetornaPeriodoPagamento : String;
    function RetornaLinhaFormatada(ALinha:String):String;

    function RetornaValorShippingID(ACampos: TStringList): Variant;

    function fGetDados(strValor: String;
                       blnFlt: Boolean = False;
                       intCasas: Integer = 0;
                       AValidaE15: Boolean = False): Variant;

    procedure ValidaSeOsDadosEstaoCorretos(ACampos: TStringList);

    procedure CarregaIndiceChaveDaVenda;
    procedure CarregaNumeroETotalDeParcelas(Var ARegistroPgto: TRegistroPgto;
                                            AListaCampos: TStringList);

    function RegistroDeVendaMarcadoComoFretePeloML(ARegistroMLPgto: TRegistroPgto): Boolean;

    function RetornaGMTRegistro(ADataRegistro: String): Integer;

    function PossuiTodosOsCamposParaCalculo: Boolean;

    function DeveAjustarOValorDeFinanciamento(AListaCampos: TStringList;
                                              var AValorAjustar: Double): Boolean;
    function DeveAjustarOValorDeFreteDeRegistrosPenalizadosPorCubagem(AListaCampos: TStringList;
                                                                      var AValorAjustar: Double): Boolean;
    function DeveAjustarOValorLiquidoDePaymentsNegativos(AListaCampos: TStringList;
                                                         var AValorAjustar: Double): Boolean;
    function DeveAjustarOValorLiquidoDeRegistrosPenalizadosPorCubagemNegativo(AListaCampos: TStringList;
                                                                              var AValorAjustar: Double): Boolean;
    function DeveAjustarOValorLiquidoDeRegistrosPenalizadosPorCubagemCancelamento(AListaCampos: TStringList;
                                                                                  var AValorAjustar: Double): Boolean;

    function RegistroDePagamentoReferenteATransferenciaDeEntradaDeDinheiro(AShippingID: String;
                                                                           AListaCampos: TStringList): Boolean;

    function TrataMensagemErro(AErro: String;
                               ARegistro: Integer): String;

    procedure SomaRegistroNaDataCorrespondente(ARegistroMLPgto: TRegistroPgto;
                                               ANomeDoArquivo: String);

    function AvaliacaoDeArquivosReimportados: Boolean;
    function SolicitaDireitoDeAcessoParaImportacaoInconsistente: Boolean;

    function AvaliacaoDeArquivosReimportadosEmOutrasEmpresas: Boolean;
    function SolicitaDireitoDeAcessoParaImportacaoMesmoArquivoEmpresasDiferentes(AArquivoJaImporado,
                                                                                 AEmpresa: String): Boolean;

    function RetornaValorCampoPorIndice(AIndiceCampo: Integer;
                                        AListaCampos: TStringList;
                                        AValorDefault: String = ''): String;

    function RetornaChaveDaVendaParaAgrupamento(AListaCampos: TStringList): String;
  Public
    constructor Create;
    destructor Destroy; override;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(var prgStatus: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaMLPgto;
  End;

Var
  strDtaArq,
  strNomArq,
  strDtaPag,
  strCodEmp: String;
  arrIndCam: TArrIndicePgto;
  FChaveRegistro: TStringList;

  Separador: Char;

  dtaMaiorData: TDateTime;

  FIndiceVenda,
  FPosicaoLinha: Integer;
  FTemRegistroParaConciliacao: Boolean;

  FCancelouImportacao: Boolean;

  FRegMLPgto: TArrRegistroMLPgto;

  FDatasEmpresasImportacao: TObjectList<TEmpresasDatasImportacao>;

  FRegistrosImportados: TUniCLientDataset;

Const
  NOMTAB = 'MER_MLPGTO';
  INICAM = 'MER_';

implementation

uses untMercadoLivre;

{ TMercadoLivrePgto }

{**********************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE CRÉDITO *}
{* MER_MLPGTO                                 *}
{*******************************************AJ*}
class function TMercadoLivrePgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaMLPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 33);

    Result[0].strDescri  := 'MER_TIPREG'; Result[0].strTipCmp  := 'VARCHAR(60)'  ;
    Result[1].strDescri  := 'MER_DTAPAG'; Result[1].strTipCmp  := 'DATETIME'     ;
    Result[2].strDescri  := 'MER_STATUS'; Result[2].strTipCmp  := 'VARCHAR(30)'  ;
    Result[3].strDescri  := 'MER_DTATRA'; Result[3].strTipCmp  := 'DATETIME'     ;
    Result[4].strDescri  := 'MER_CODAUT'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := 'MER_TIPPAG'; Result[5].strTipCmp  := 'VARCHAR(25)'  ;
    Result[6].strDescri  := 'MER_VALPRO'; Result[6].strTipCmp  := 'DECIMAL(15,2)';
    Result[7].strDescri  := 'MER_VALENV'; Result[7].strTipCmp  := 'DECIMAL(15,2)';
    Result[8].strDescri  := 'MER_VALLIQ'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'MER_VALMPG'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'MER_VALPLA'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'MER_VALDEV'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'MER_APELID'; Result[12].strTipCmp := 'VARCHAR(25)'  ;
    Result[13].strDescri := 'MER_NUMOPE'; Result[13].strTipCmp := 'VARCHAR(20)'  ;
    Result[14].strDescri := 'MER_NUMVEN'; Result[14].strTipCmp := 'VARCHAR(20)'  ;
    Result[15].strDescri := 'MER_LINPRO'; Result[15].strTipCmp := 'VARCHAR(2000)';
    Result[16].strDescri := 'MER_NOMARQ'; Result[16].strTipCmp := 'VARCHAR(255)' ;
    Result[17].strDescri := 'MER_DTAARQ'; Result[17].strTipCmp := 'DATE'         ;
    Result[18].strDescri := 'MER_CONCIL'; Result[18].strTipCmp := 'INT DEFAULT 0';
    Result[19].strDescri := 'MER_CODEST'; Result[19].strTipCmp := 'VARCHAR(30)  ';
    Result[20].strDescri := 'MER_NUMPAR'; Result[20].strTipCmp := 'VARCHAR(2) DEFAULT "01"';
    Result[21].strDescri := 'MER_TOTPAR'; Result[21].strTipCmp := 'VARCHAR(2) DEFAULT "01"';
    Result[22].strDescri := 'MER_NUMCAR'; Result[22].strTipCmp := 'VARCHAR(19)'  ;
    Result[23].strDescri := 'MER_SHP_ID'; Result[23].strTipCmp := 'VARCHAR(30)'  ;
    Result[24].strDescri := 'MER_VALCUP'; Result[24].strTipCmp := 'DECIMAL(15,2)';
    Result[25].strDescri := 'MER_CODEMP'; Result[25].strTipCmp := 'CHAR(3)';
    Result[26].strDescri := 'MER_ORD_ID'; Result[26].strTipCmp := 'VARCHAR(30)';
    Result[27].strDescri := 'MER_SALDO_'; Result[27].strTipCmp := 'DECIMAL(15,2)';
    Result[28].strDescri := 'MER_DTASTR'; Result[28].strTipCmp := 'VARCHAR(35)'  ;
    Result[29].strDescri := 'MER_CUPEFE'; Result[29].strTipCmp := 'DECIMAL(15,2)';
    Result[30].strDescri := 'MER_POSDIA'; Result[30].strTipCmp := 'INT DEFAULT 0';
    Result[31].strDescri := 'MER_POS_ID'; Result[31].strTipCmp := 'VARCHAR(25)';
    Result[32].strDescri := 'MER_NUMNSU'; Result[32].strTipCmp := 'VARCHAR(40)';
  End;
End;

class function TMercadoLivrePgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaMLPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(MER_CODAUT,MER_CODEST,MER_DTAPAG,MER_NUMPAR,MER_STATUS,MER_TIPPAG,MER_TIPREG)) ENGINE INNODB ' ;
end;

procedure TMercadoLivrePgto.AtualizaPosicaoDoDiaNoArquivo(
  ARegistro: TRegistroPgto);
  Var
    LUpdate: TUniQuery;
begin
  If VS_RegistrosJaImportados.FindField('MER_POSDIA') = Nil Then
    Exit;

  If ARegistro.PosicaoArquivoData.ToString.Equals(VS_RegistrosJaImportados.FieldByName('MER_POSDIA').AsString) Then
    Exit;

  LUpdate := Nil;
  Try
    LUpdate := VS_FuncoesExternas.fICriaQuery;
    LUpdate.SQL.Text := 'UPDATE MER_MLPGTO ' +
                        'SET MER_POSDIA=:POSDIA, ' +
                        '    MER_SALDO_=:SALDO_  ' +
                        'WHERE MER_CODAUT=:CODAUT ' +
                        '  AND MER_CODEST=:CODEST ' +
                        '  AND MER_DTAPAG=:DTAPAG ' +
                        '  AND MER_NUMPAR=:NUMPAR ' +
                        '  AND MER_STATUS=:STATUS ' +
                        '  AND MER_TIPPAG=:TIPPAG ' +
                        '  AND MER_TIPREG=:TIPREG ';

    LUpdate.ParamByName('POSDIA').AsInteger := ARegistro.PosicaoArquivoData;
    LUpdate.ParamByName('SALDO_').AsFloat := ARegistro.BalanceAmount;

    LUpdate.ParamByName('CODAUT').AsString := VS_RegistrosJaImportados.FieldByName('MER_CODAUT').AsString;
    LUpdate.ParamByName('CODEST').AsString := VS_RegistrosJaImportados.FieldByName('MER_CODEST').AsString;
    LUpdate.ParamByName('DTAPAG').Value := VS_RegistrosJaImportados.FieldByName('MER_DTAPAG').Value;
    LUpdate.ParamByName('NUMPAR').AsString := VS_RegistrosJaImportados.FieldByName('MER_NUMPAR').AsString;
    LUpdate.ParamByName('STATUS').AsString := VS_RegistrosJaImportados.FieldByName('MER_STATUS').AsString;
    LUpdate.ParamByName('TIPPAG').AsString := VS_RegistrosJaImportados.FieldByName('MER_TIPPAG').AsString;
    LUpdate.ParamByName('TIPREG').AsString := VS_RegistrosJaImportados.FieldByName('MER_TIPREG').AsString;

    LUpdate.ExecSQL;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LUpdate);
  End;
end;

function TMercadoLivrePgto.AvaliacaoDeArquivosReimportados: Boolean;
  Var
    LDataImportada: TEmpresasDatasImportacao;

    LConsulta: TUniQuery;

    LJaPermitiu,
    LSolicitarDireitoAcesso: Boolean;
begin
  If TMercadoLivreFuncoes.RetornaValorCfg('CFG_MRDESA').Equals('S') Then
    Exit(True);

  Try
    Result := VS_FuncoesExternas.fIVersaoDoAutcomPossuiDireitoDeAcessoParaImportacao;
    If Not Result Then
      Exit(True);
  Except
    Exit(True);
  End;

  //Valida se nesse momento possui mais de um arquivo para o mesmo período
  LJaPermitiu := False;
  For LDataImportada In FDatasEmpresasImportacao Do
  Begin
    If Length(LDataImportada.NomeArquivos.Split([','])) <= 1 Then
      Continue;

    If LJaPermitiu Then
      Continue;

    Result := TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'Na pasta existe mais de um arquivo com o mesmo período de pagamento a ser importado.' + #13 +
                                                        'Quando é importado arquivos dessa forma, alguns relatórios do sistema não poderão ' +
                                                        'ser confrontados com valores do portal do Mercado Livre/Pago.' + #13 +
                                                        'Deseja importar mesmo assim?', ['&Sim', '&Não'], 2) = 1;
    If Not Result Then
      Exit;

    LJaPermitiu := True;
  End;

  LSolicitarDireitoAcesso := LJaPermitiu;

  //Agora valida se o período possui registros importados e também possui a mesma quantidade de registros
  LJaPermitiu := False;
  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT LEFT(MER_DTAPAG, 10) AS DATA_IMPORTACAO, ' +
                          '       IFNULL(MER_CODEMP, "") AS EMPRESA, ' +
                          '       COUNT(*) AS QTDE_REGISTROS, ' +
                          '       SUM(IFNULL(MER_CONCIL, 0)) AS QTDE_CONCILIADOS ' +
                          'FROM MER_MLPGTO ' +
                          'WHERE MER_DTAPAG ' + RetornaPeriodoPagamento +
                          '  AND MER_TIPREG NOT IN ("total", "initial_available_balance") ' +
                          'GROUP BY LEFT(MER_DTAPAG, 10), IFNULL(MER_CODEMP, "") ' +
                          'ORDER BY LEFT(MER_DTAPAG, 10), IFNULL(MER_CODEMP, "") ';
    LConsulta.Open;

    FRegistrosImportados := TMercadoLivreFuncoes.CriarClientDataSet(LConsulta);

    If Not LConsulta.IsEmpty Then
    Begin
      LConsulta.First;

      For LDataImportada In FDatasEmpresasImportacao Do
      Begin
        LConsulta.Filter := 'DATA_IMPORTACAO=''' + FormatDateTime('yyyy-mm-dd', LDataImportada.DataImportacao) + ''' AND ' +
                            'EMPRESA=''' + LDataImportada.Empresa + ''' ';
        LConsulta.Filtered := True;

        If LConsulta.IsEmpty Then
          Continue;

        If LConsulta.FieldByName('QTDE_REGISTROS').AsInteger = LDataImportada.QuantidadeRegistros Then
          Continue;

        If LJaPermitiu Then
          Continue;

        Result := TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'Já existem registros importados para o dia ' + FormatDateTime('dd/mm/yyyy', LDataImportada.DataImportacao) +
                                                            TMercadoLivreFuncoes.IIF(LDataImportada.Empresa.IsEmpty, '', ' na empresa ' + LDataImportada.Empresa) + '.' + #13 +
                                                            'Quando é importado arquivos dessa forma, alguns relatórios do sistema não poderão ' +
                                                            'ser confrontados com valores do portal do Mercado Livre/Pago.' + #13 +
                                                            'Deseja importar mesmo assim?', ['&Sim', '&Não'], 2) = 1;
        If Not Result Then
          Exit;

        LJaPermitiu := True;
      End;

      If Not LSolicitarDireitoAcesso Then
        LSolicitarDireitoAcesso := LJaPermitiu;
    End;

    If LSolicitarDireitoAcesso Then
    Begin
      Result := SolicitaDireitoDeAcessoParaImportacaoInconsistente;

      If Not Result Then
        VS_FuncoesExternas.pILimparArrayDiretoAcesso;
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TMercadoLivrePgto.AvaliacaoDeArquivosReimportadosEmOutrasEmpresas: Boolean;
  Var
    LDataImportada: TEmpresasDatasImportacao;

    LJaPermitiu: Boolean;
begin
  If TMercadoLivreFuncoes.RetornaValorCfg('CFG_MRDESA').Equals('S') Then
    Exit(True);

  Try
    Result := VS_FuncoesExternas.fIVersaoDoAutcomPossuiDireitoDeAcessoParaImportacao;
    If Not Result Then
      Exit(True);
  Except
    Exit(True);
  End;

  LJaPermitiu := False;

  Try
    If Not Assigned(FRegistrosImportados) Then
      Exit(True);

    If FRegistrosImportados.IsEmpty Then
      Exit(True);

    For LDataImportada In FDatasEmpresasImportacao Do
    Begin
      FRegistrosImportados.Filter := 'DATA_IMPORTACAO=''' + FormatDateTime('yyyy-mm-dd', LDataImportada.DataImportacao) + ''' AND ' +
                                     'EMPRESA<>''' + LDataImportada.Empresa + ''' ';
      FRegistrosImportados.Filtered := True;

      If FRegistrosImportados.IsEmpty Then
        Continue;

      FRegistrosImportados.First;
      While Not FRegistrosImportados.Eof Do
      Begin
        If FRegistrosImportados.FieldByName('QTDE_REGISTROS').AsInteger <> LDataImportada.QuantidadeRegistros Then
        Begin
          FRegistrosImportados.Next;
          Continue;
        End;

        If FRegistrosImportados.FieldByName('QTDE_CONCILIADOS').AsInteger = 0 Then
        Begin
          FRegistrosImportados.Next;
          Continue;
        End;

        If LJaPermitiu Then
        Begin
          FRegistrosImportados.Next;
          Continue;
        End;

        Result := TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'O arquivo ' + LDataImportada.NomeArquivos.Split([','])[0] + ' parece já ter sido importado e conciliado ' +
                                                            TMercadoLivreFuncoes.IIF(FRegistrosImportados.FieldByName('EMPRESA').AsString.IsEmpty, '', ' na empresa ' + FRegistrosImportados.FieldByName('EMPRESA').AsString) + '.' + #13 +
                                                            'Caso sejam registros que já estiverem conciliados em outra empresa, "NÃO" serão reimportados. Dessa forma, ' +
                                                            'a conciliação poderá não apresentar os valores corretos.' + #13 +
                                                            'Deseja importar o arquivo mesmo assim?', ['&Sim', '&Não'], 2) = 1;
        If Not Result Then
          Exit;

        If Not SolicitaDireitoDeAcessoParaImportacaoMesmoArquivoEmpresasDiferentes(LDataImportada.NomeArquivos.Split([','])[0],
                                                                                   FRegistrosImportados.FieldByName('EMPRESA').AsString) Then
        Begin
          VS_FuncoesExternas.pILimparArrayDiretoAcesso;
          Exit(False);
        End;

        LJaPermitiu := True;

        FRegistrosImportados.Next;
      End;
    End;
  Finally
    FRegistrosImportados.Close;
    FreeAndNil(FRegistrosImportados);
  End;
end;

procedure TMercadoLivrePgto.CarregaIndiceChaveDaVenda;
begin
  If FIndiceVenda > 0 Then
    Exit;

  FIndiceVenda := 14;
  If TMercadoLivreFuncoes.CampoExiste('MOVCAR', 'MCA_ORDEID') Then
    FIndiceVenda := 16;
end;

procedure TMercadoLivrePgto.CarregaNumeroETotalDeParcelas(
  var ARegistroPgto: TRegistroPgto; AListaCampos: TStringList);
  Var
    LNumeroParcela,
    LTotalParcelas: Integer;
begin
  ARegistroPgto.NumeroParcela := '01';
  ARegistroPgto.TotalParcelas := '01';

  If arrIndCam[22].intIndice = -1 Then
    Exit;

  If (Not ARegistroPgto.strCodEst.Equals('0')) And (Not ARegistroPgto.NumeroNSU.IsEmpty) Then
  Begin
    If TryStrToInt(AListaCampos[arrIndCam[22].intIndice], LTotalParcelas) Then
      ARegistroPgto.TotalParcelas := TMercadoLivreFuncoes.fStrZero(RightStr(LTotalParcelas.ToString, 2), 2);
  End;

  If Not AListaCampos[arrIndCam[22].intIndice].Contains('/') Then
    Exit;

  If Length(AListaCampos[arrIndCam[22].intIndice].Split(['/'])) <> 2 Then
    Exit;

  If Not TryStrToInt(AListaCampos[arrIndCam[22].intIndice].Split(['/'])[0], LNumeroParcela) Then
    Exit;

  If Not TryStrToInt(AListaCampos[arrIndCam[22].intIndice].Split(['/'])[1], LTotalParcelas) Then
    Exit;

  ARegistroPgto.NumeroParcela := TMercadoLivreFuncoes.fStrZero(LNumeroParcela.ToString, 2);
  ARegistroPgto.TotalParcelas := TMercadoLivreFuncoes.fStrZero(LTotalParcelas.ToString, 2);
end;

constructor TMercadoLivrePgto.Create;
begin
  FDatasEmpresasImportacao := TObjectList<TEmpresasDatasImportacao>.Create;

  FTamandoCampoMER_CODAUT := TMercadoLivreFuncoes.RetornaTamandoDeCampoString('MER_MLPGTO', 'MER_CODAUT', 20);
  FPosicaoAtualData := 0;
  FPosicaoNoArquivo := 0;
  FColunasArquivo := 0;
end;

destructor TMercadoLivrePgto.Destroy;
begin
  If Assigned(FDatasEmpresasImportacao) Then
    FreeAndNil(FDatasEmpresasImportacao);
  inherited;
end;

function TMercadoLivrePgto.DeveAjustarOValorDeFinanciamento(
  AListaCampos: TStringList; var AValorAjustar: Double): Boolean;
  Const
    VALIDAR: Array Of String = ['payment', 'mediation_cancel', 'refund'];

  Var
    LValorLiquidoArquivo,
    LValorLiquidoCalculado,
    LCustoDescontoOferecido: Double;
begin
  {*********************************************}
  {* ESSE TRATAMENTO FOI ADICIONADO POIS,      *}
  {* O MERCADO LIVRE SEMPRE ENVIOU O CAMPO     *}
  {* FINANCING_FEE_AMOUNT SOMANDO NO BRUTO E,  *}
  {* DO NADA, ALGUNS NÃO ESTÁ SOMANDO E OUTROS *}
  {* SOMANDO APENAS UMA PARTE.                 *}
  {* OBS: APARENTE ERRO NA PLATAFORMA DO ML,   *}
  {*      JÁ QUE A SOMA NA LINHA NÃO BATE COM  *}
  {*      O LÍQUIDO DO PRÓPRIO ARQUIVO.        *}
  {******************************************AJ*}

  Result := False;

  AValorAjustar := 0;

  If Not MatchStr(fGetDados(AListaCampos[arrIndCam[0].intIndice]), VALIDAR) Then
    Exit;

  If Not PossuiTodosOsCamposParaCalculo Then
    Exit;

  If TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[7].intIndice], True, 0), 2) = 0 Then
    Exit;

  LValorLiquidoArquivo := TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[6].intIndice], True, 0), 2);
  If LValorLiquidoArquivo = 0 Then
    LValorLiquidoArquivo := Abs(TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[9].intIndice], True, 0), 2)) * (-1);

  If LValorLiquidoArquivo < 0 Then
    Exit;

  LCustoDescontoOferecido := 0;
  If arrIndCam[24].intIndice > -1 Then
    LCustoDescontoOferecido := fGetDados(AListaCampos[arrIndCam[24].intIndice], True, 0);

  LValorLiquidoCalculado := (fGetDados(AListaCampos[arrIndCam[4].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[5].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[7].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[8].intIndice], True, 0) +
                             LCustoDescontoOferecido);

  If FormatFloat(',0.00', LValorLiquidoCalculado).Equals(FormatFloat(',0.00', LValorLiquidoArquivo)) Then
    Exit;

  AValorAjustar := TMercadoLivreFuncoes.fFormataFloat(LValorLiquidoCalculado - LValorLiquidoArquivo, 2);

  Result := Not FormatFloat(',0.00', AValorAjustar).Equals('0,00');
end;

function TMercadoLivrePgto.DeveAjustarOValorDeFreteDeRegistrosPenalizadosPorCubagem(
  AListaCampos: TStringList; var AValorAjustar: Double): Boolean;
  Const
    VALIDAR: Array Of String = ['fee_for_divergence_in_package_dimensions'];

  Var
    LValorLiquidoArquivo,
    LValorLiquidoCalculado,
    LCustoDescontoOferecido: Double;
begin
  Result := False;

  AValorAjustar := 0;

  If Not MatchStr(fGetDados(AListaCampos[arrIndCam[0].intIndice]), VALIDAR) Then
    Exit;

  If Not PossuiTodosOsCamposParaCalculo Then
    Exit;

  If arrIndCam[9].intIndice = -1 Then
    Exit;

  LCustoDescontoOferecido := 0;
  If arrIndCam[24].intIndice > -1 Then
    LCustoDescontoOferecido := fGetDados(AListaCampos[arrIndCam[24].intIndice], True, 0);

  LValorLiquidoCalculado := (fGetDados(AListaCampos[arrIndCam[4].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[5].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[7].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[8].intIndice], True, 0) +
                             LCustoDescontoOferecido);

  If TMercadoLivreFuncoes.fFormataFloat(LValorLiquidoCalculado, 2) <= 0 Then
    Exit;

  LValorLiquidoArquivo := TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[6].intIndice], True, 0), 2);
  If LValorLiquidoArquivo = 0 Then
    LValorLiquidoArquivo := Abs(TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[9].intIndice], True, 0), 2)) * (-1);

  If LValorLiquidoArquivo < 0 Then
    Exit;

  If FormatFloat(',0.00', LValorLiquidoCalculado).Equals(FormatFloat(',0.00', LValorLiquidoArquivo)) Then
    Exit;

  AValorAjustar := TMercadoLivreFuncoes.fFormataFloat(LValorLiquidoCalculado - LValorLiquidoArquivo, 2);

  Result := Not FormatFloat(',0.00', AValorAjustar).Equals('0,00');
end;

function TMercadoLivrePgto.DeveAjustarOValorLiquidoDePaymentsNegativos(
  AListaCampos: TStringList; var AValorAjustar: Double): Boolean;
  Const
    VALIDAR: Array Of String = ['payment'];

  Var
    LValorLiquidoArquivo,
    LValorLiquidoCalculado,
    LCustoDescontoOferecido: Double;
begin
  Result := False;

  AValorAjustar := 0;

  If Not MatchStr(fGetDados(AListaCampos[arrIndCam[0].intIndice]), VALIDAR) Then
    Exit;

  If Not PossuiTodosOsCamposParaCalculo Then
    Exit;

  If fGetDados(AListaCampos[arrIndCam[4].intIndice], True, 0) >= 0 Then
    Exit;

  If arrIndCam[9].intIndice = -1 Then
    Exit;

  LValorLiquidoArquivo := TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[9].intIndice], True, 0), 2);

  LCustoDescontoOferecido := 0;
  If arrIndCam[24].intIndice > -1 Then
    LCustoDescontoOferecido := fGetDados(AListaCampos[arrIndCam[24].intIndice], True, 0);

  LValorLiquidoCalculado := (fGetDados(AListaCampos[arrIndCam[4].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[5].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[7].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[8].intIndice], True, 0) +
                             LCustoDescontoOferecido);

  If TMercadoLivreFuncoes.fFormataFloat(LValorLiquidoCalculado, 2) >= 0 Then
    Exit;

  Result := Not FormatFloat(',0.00', Abs(LValorLiquidoCalculado)).Equals(FormatFloat(',0.00', Abs(LValorLiquidoArquivo)));
  If Not Result Then
    Exit;

  AValorAjustar := TMercadoLivreFuncoes.fFormataFloat(Abs(LValorLiquidoArquivo) - Abs(LValorLiquidoCalculado), 2);
end;

function TMercadoLivrePgto.DeveAjustarOValorLiquidoDeRegistrosPenalizadosPorCubagemCancelamento(
  AListaCampos: TStringList; var AValorAjustar: Double): Boolean;
Const
    VALIDAR: Array Of String = ['fee_for_divergence_in_package_dimensions_cancel'];

  Var
    LValorLiquidoNegativoArquivo,
    LValorLiquidoPositivoArquivo,
    LValorLiquidoCalculado,
    LCustoDescontoOferecido: Double;
begin
  Result := False;

  AValorAjustar := 0;

  If Not MatchStr(fGetDados(AListaCampos[arrIndCam[0].intIndice]), VALIDAR) Then
    Exit;

  If Not PossuiTodosOsCamposParaCalculo Then
    Exit;

  If arrIndCam[9].intIndice = -1 Then
    Exit;

  If arrIndCam[6].intIndice = -1 Then
    Exit;

  LCustoDescontoOferecido := 0;
  If arrIndCam[24].intIndice > -1 Then
    LCustoDescontoOferecido := fGetDados(AListaCampos[arrIndCam[24].intIndice], True, 0);

  LValorLiquidoNegativoArquivo := TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[9].intIndice], True, 0), 2);
  LValorLiquidoPositivoArquivo := TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[6].intIndice], True, 0), 2);

  If LValorLiquidoNegativoArquivo <> 0 Then
    Exit;

  LValorLiquidoCalculado := (fGetDados(AListaCampos[arrIndCam[4].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[5].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[7].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[8].intIndice], True, 0) +
                             LCustoDescontoOferecido);

  If FormatFloat(',0.00', LValorLiquidoCalculado).Equals(FormatFloat(',0.00', LValorLiquidoPositivoArquivo)) Then
    Exit;

  AValorAjustar := TMercadoLivreFuncoes.fFormataFloat(LValorLiquidoPositivoArquivo, 2);

  Result := Not FormatFloat(',0.00', AValorAjustar).Equals('0,00');
end;

function TMercadoLivrePgto.DeveAjustarOValorLiquidoDeRegistrosPenalizadosPorCubagemNegativo(
  AListaCampos: TStringList; var AValorAjustar: Double): Boolean;
  Const
    VALIDAR: Array Of String = ['fee_for_divergence_in_package_dimensions'];

  Var
    LValorLiquidoNegativoArquivo,
    LValorLiquidoPositivoArquivo,
    LValorLiquidoCalculado,
    LCustoDescontoOferecido: Double;
begin
  Result := False;

  AValorAjustar := 0;

  If Not MatchStr(fGetDados(AListaCampos[arrIndCam[0].intIndice]), VALIDAR) Then
    Exit;

  If Not PossuiTodosOsCamposParaCalculo Then
    Exit;

  If arrIndCam[9].intIndice = -1 Then
    Exit;

  LCustoDescontoOferecido := 0;
  If arrIndCam[24].intIndice > -1 Then
    LCustoDescontoOferecido := fGetDados(AListaCampos[arrIndCam[24].intIndice], True, 0);

  LValorLiquidoNegativoArquivo := TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[9].intIndice], True, 0), 2);
  LValorLiquidoPositivoArquivo := TMercadoLivreFuncoes.fFormataFloat(fGetDados(AListaCampos[arrIndCam[6].intIndice], True, 0), 2);

  If LValorLiquidoPositivoArquivo <> 0 Then
    Exit;

  LValorLiquidoCalculado := (fGetDados(AListaCampos[arrIndCam[4].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[5].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[7].intIndice], True, 0) +
                             fGetDados(AListaCampos[arrIndCam[8].intIndice], True, 0) +
                             LCustoDescontoOferecido);

  If FormatFloat(',0.00', LValorLiquidoCalculado).Equals(FormatFloat(',0.00', LValorLiquidoNegativoArquivo)) Then
    Exit;

  AValorAjustar := TMercadoLivreFuncoes.fFormataFloat(LValorLiquidoNegativoArquivo * (-1), 2);

  Result := Not FormatFloat(',0.00', AValorAjustar).Equals('0,00');
end;

function TMercadoLivrePgto.fGetDados(strValor: String; blnFlt: Boolean = False;
  intCasas: Integer = 0; AValidaE15: Boolean = False): Variant;
  Var
    rst     : Variant;
    i       : Integer;
    strZeros: String;
Begin
  rst := ' ';
  If strValor <> '' Then
    rst := strValor;

  If blnFlt Then
  Begin
    strZeros := '';
    For i := 1 to intCasas do
      strZeros := strZeros + '0';

    rst := StringReplace(rst, '.', ',', []);
    rst := TMercadoLivreFuncoes.fStrToFloat(rst) /
           StrtoFloat('1' + strZeros);
  End;

  If Not blnFlt Then
  Begin
    If rst = '2E+15' Then
      Raise Exception.Create('Não é possível importar o arquivo ' + strNomArq + '.' + #13 +
                             'O arquivo foi aberto e salvo em um programa de terceiros, como Excel ou Calc. ' +
                             'A importação deve ser realizada a partir do csv "puro" baixado do portal, sem qualquer alteração.' + #13 +
                             'A operação foi cancelada.');

    If AValidaE15 Then
    Begin
      If Pos('E+15', rst) > 0  Then
        Raise Exception.Create('Não é possível importar o arquivo ' + strNomArq + '.' + #13 +
                               'O arquivo foi aberto e salvo em um programa de terceiros, como Excel ou Calc. ' +
                               'A importação deve ser realizada a partir do csv "puro" baixado do portal, sem qualquer alteração.' + #13 +
                               'A operação foi cancelada.');
    End;
  End;

  Result := rst;
End;

procedure TMercadoLivrePgto.pAdicionaLinha(strString: String);
Var
  lstCampos       : TStringList;
  intRegistro     : Integer;
  blnAchouRegistro: Boolean;

  LDataPagamento,
  LChaveVenda,
  LShippingID,
  LTextoAjusteCredito: String;

  blnTotais: Boolean;

  LCustoDescontoOferecido,
  LValorAjustar: Double;

  procedure pAdicionaIndice(strNomCol, strNomCam: String);
  Begin
    SetLength(arrIndCam, Length(arrIndCam) + 1);
    arrIndCam[Length(arrIndCam) - 1].strNomCam := strNomCam;
    arrIndCam[Length(arrIndCam) - 1].intIndice := lstCampos.IndexOf(strNomCol);
  End;

begin
  If TMercadoLivreFuncoes.fEmptyStr(strString) Then
    Exit;

  lstCampos := Nil;
  Try
    lstCampos := TStringList.Create;
    lstCampos.Delimiter     := Separador;
    lstCampos.DelimitedText := RetornaLinhaFormatada(strString);

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If Not Assigned(FChaveRegistro) Then
      FChaveRegistro := TStringList.Create;

    If Not Assigned(VS_DatasPagamento) Then
      VS_DatasPagamento := TStringList.Create;

    Try
      If (Pos('NET_CREDIT_AMOUNT', strString) > 0) Then
      Begin
        strString := TMercadoLivreFuncoes.fConverteParaAcento(strString);
        lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);
        SetLength(arrIndCam, 0);
        pAdicionaIndice('DESCRIPTION', INICAM + 'TIPREG');  //0
        pAdicionaIndice('EXTERNAL_REFERENCE', INICAM + 'CODAUT'); //1
        pAdicionaIndice('DATE', INICAM + 'DTATRA'); //2
        If arrIndCam[2].intIndice = -1 Then
        Begin
          SetLength(arrIndCam, Length(arrIndCam) - 1);
          pAdicionaIndice('RELEASE_DATE', INICAM + 'DTATRA'); //2
        End;
        pAdicionaIndice('DATE', INICAM + 'DTAPAG'); //3
        If arrIndCam[3].intIndice = -1 Then
        Begin
          SetLength(arrIndCam, Length(arrIndCam) - 1);
          pAdicionaIndice('RELEASE_DATE', INICAM + 'DTAPAG'); //3
        End;
        pAdicionaIndice('GROSS_AMOUNT', INICAM + 'VALPRO'); //4
        pAdicionaIndice('SHIPPING_FEE_AMOUNT', INICAM + 'VALENV'); //5
        pAdicionaIndice('NET_CREDIT_AMOUNT', INICAM + 'VALLIQ'); //6
        pAdicionaIndice('FINANCING_FEE_AMOUNT', INICAM + 'VALMPG'); //7
        pAdicionaIndice('MP_FEE_AMOUNT', INICAM + 'VALPLA'); //8
        pAdicionaIndice('NET_DEBIT_AMOUNT', INICAM + 'VALDEV'); //9
        pAdicionaIndice('PAYMENT_METHOD', INICAM + 'TIPPAG'); //10
        pAdicionaIndice('SOURCE_ID', INICAM + 'NUMOPE'); //11
        pAdicionaIndice('SOURCE_ID', INICAM + 'NUMVEN'); //12
        pAdicionaIndice('RECORD_TYPE', INICAM + 'STATUS'); //13
        pAdicionaIndice('SHIPPING_ID', INICAM + 'SHP_ID'); //14
        pAdicionaIndice('COUPON_AMOUNT', INICAM + 'VALCUP'); //15
        pAdicionaIndice('ORDER_ID', INICAM + 'ORD_ID'); //16
        pAdicionaIndice('SHIPMENT_MODE', EmptyStr); //17
        pAdicionaIndice('TRANSACTION_APPROVAL_DATE', EmptyStr); //18
        pAdicionaIndice('BUSINESS_UNIT', EmptyStr); //19
        pAdicionaIndice('SUB_UNIT', EmptyStr); //20
        pAdicionaIndice('SALE_DETAIL', EmptyStr); //21
        pAdicionaIndice('INSTALLMENTS', EmptyStr); //22
        pAdicionaIndice('BALANCE_AMOUNT', 'MER_SALDO_'); //23
        pAdicionaIndice('EFFECTIVE_COUPON_AMOUNT', 'MER_CUPEFE'); //24
        pAdicionaIndice('POS_ID', 'MER_POS_ID'); //25
        pAdicionaIndice('SOURCE_ID', 'MER_NUMNSU'); //26
        pAdicionaIndice('STORE_ID', 'MER_CODEST'); //27
        pAdicionaIndice('CARD_INITIAL_NUMBER', 'MER_NUMCAR'); //28
        pAdicionaIndice('LAST_FOUR_DIGITS', 'MER_NUMCAR'); //29
        pAdicionaIndice('AUTHORIZATION_CODE', 'MER_CODAUT'); //30

        CarregaIndiceChaveDaVenda;

        FPosicaoAtualData := 0;
        FPosicaoNoArquivo := 0;
        FDataRegistroArquivo := '';
        FPosicaoLinha := 1;

        FColunasArquivo := Length(strString.Split([Separador]));
        FTextoLinhaAnterior := EmptyStr;
      End
      Else
      Begin
        Inc(FPosicaoLinha);
        Inc(FPosicaoNoArquivo);

        {Req 465684 - Mais uma vez o Mercado Livre gerando arquivos fora do padrão,
                      uma parte em uma linha e outra parte em outra.
                      Esse processo aqui é para tentar "juntar" as linhas. }
        If FColunasArquivo > lstCampos.Count Then
        Begin
          If FTextoLinhaAnterior.IsEmpty Then
          Begin
            FTextoLinhaAnterior := strString;
            Exit;
          End
          Else
          Begin
            FTextoLinhaAnterior := FTextoLinhaAnterior + strString;
            lstCampos.DelimitedText := RetornaLinhaFormatada(FTextoLinhaAnterior);
          End;

          If FColunasArquivo <> lstCampos.Count Then
          Begin
            If lstCampos.Count > FColunasArquivo Then
              FTextoLinhaAnterior := EmptyStr;

            Exit;
          End;
        End;

        FTextoLinhaAnterior := EmptyStr;

        blnTotais := ((fGetDados(lstCampos[arrIndCam[13].intIndice]) = 'subtotal') Or
                      (Trim(fGetDados(lstCampos[arrIndCam[0].intIndice])) = '')) And
                      (fGetDados(lstCampos[arrIndCam[0].intIndice]) <> 'withdrawal') And
                      (fGetDados(lstCampos[arrIndCam[13].intIndice]) <> 'initial_available_balance') And
                      (fGetDados(lstCampos[arrIndCam[13].intIndice]) <> 'total');



        If (lstCampos.Count = 0) Or
           (blnTotais) Then
          Exit;

        ValidaSeOsDadosEstaoCorretos(lstCampos);

        LShippingID := RetornaValorShippingID(lstCampos);

        LChaveVenda := RetornaChaveDaVendaParaAgrupamento(lstCampos);

        intRegistro := FChaveRegistro.IndexOf(LChaveVenda);

        blnAchouRegistro := intRegistro > -1;
        If Not blnAchouRegistro Then
        Begin
          SetLength(FRegMLPgto, Length(FRegMLPgto) + 1);
          intRegistro := Length(FRegMLPgto) - 1;
          FChaveRegistro.Add(LChaveVenda);
        End;

        FRegMLPgto[intRegistro].strTipReg := fGetDados(lstCampos[arrIndCam[0].intIndice]);
        If (Trim(fGetDados(lstCampos[arrIndCam[0].intIndice])) = '') Then
          FRegMLPgto[intRegistro].strTipReg := fGetDados(lstCampos[arrIndCam[13].intIndice]);

        FRegMLPgto[intRegistro].strStatus := fGetDados(lstCampos[arrIndCam[13].intIndice]);
        FRegMLPgto[intRegistro].strCodAut := TMercadoLivreFuncoes.IIF(Trim(fGetDados(lstCampos[arrIndCam[1].intIndice])) <> '',
                                                                      fGetDados(lstCampos[arrIndCam[1].intIndice]),
                                                                      '0000000000');

        FRegMLPgto[intRegistro].strDtaTra := fGetDados(lstCampos[arrIndCam[2].intIndice]);
        If arrIndCam[18].intIndice > -1 Then
        Begin
          If Trim(fGetDados(lstCampos[arrIndCam[18].intIndice])) <> '' Then
            FRegMLPgto[intRegistro].strDtaTra := fGetDados(lstCampos[arrIndCam[18].intIndice]);
        End;

        FRegMLPgto[intRegistro].strDtaPag := fGetDados(lstCampos[arrIndCam[3].intIndice]);
        FRegMLPgto[intRegistro].GMTRegistro := RetornaGMTRegistro(fGetDados(lstCampos[arrIndCam[3].intIndice]));
        FRegMLPgto[intRegistro].DataCompletaString := fGetDados(lstCampos[arrIndCam[3].intIndice]);

        FRegMLPgto[intRegistro].fltValPro := (fGetDados(lstCampos[arrIndCam[4].intIndice], True, 0)) +
                                             TMercadoLivreFuncoes.IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValPro, 0);
        FRegMLPgto[intRegistro].fltValEnv := (fGetDados(lstCampos[arrIndCam[5].intIndice], True, 0)) +
                                             TMercadoLivreFuncoes.IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValEnv, 0);

        If arrIndCam[7].intIndice > -1 Then
          FRegMLPgto[intRegistro].fltValMPG := (fGetDados(lstCampos[arrIndCam[7].intIndice], True, 0)) +
                                               TMercadoLivreFuncoes.IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValMPG, 0)
        Else
          FRegMLPgto[intRegistro].fltValMPG := 0;

        If arrIndCam[8].intIndice > -1 Then
          FRegMLPgto[intRegistro].fltValPla := (fGetDados(lstCampos[arrIndCam[8].intIndice], True, 0)) +
                                               TMercadoLivreFuncoes.IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValPla, 0)
        Else
          FRegMLPgto[intRegistro].fltValPla := 0;


        FRegMLPgto[intRegistro].CupomDesconto := (fGetDados(lstCampos[arrIndCam[15].intIndice], True, 0)) +
                                                 TMercadoLivreFuncoes.IIF(blnAchouRegistro, FRegMLPgto[intRegistro].CupomDesconto, 0);

        LCustoDescontoOferecido := 0;
        If Not blnAchouRegistro Then
          FRegMLPgto[intRegistro].CustoDescontoOferecido := 0;
        If arrIndCam[24].intIndice > -1 Then
          LCustoDescontoOferecido := fGetDados(lstCampos[arrIndCam[24].intIndice], True, 0);

        FRegMLPgto[intRegistro].CustoDescontoOferecido := LCustoDescontoOferecido +
                                                          FRegMLPgto[intRegistro].CustoDescontoOferecido;

        FRegMLPgto[intRegistro].fltValLiq := TMercadoLivreFuncoes.IIF(blnAchouRegistro, FRegMLPgto[intRegistro].fltValLiq, 0) +
                                                                     ((fGetDados(lstCampos[arrIndCam[4].intIndice], True, 0) +
                                                                      fGetDados(lstCampos[arrIndCam[5].intIndice], True, 0) +
                                                                      fGetDados(lstCampos[arrIndCam[7].intIndice], True, 0) +
                                                                      fGetDados(lstCampos[arrIndCam[8].intIndice], True, 0) +
                                                                      LCustoDescontoOferecido));

        FRegMLPgto[intRegistro].strTipPag := fGetDados(lstCampos[arrIndCam[10].intIndice]);
        If FRegMLPgto[intRegistro].strTipPag.Trim = '' Then
          FRegMLPgto[intRegistro].strTipPag := FRegMLPgto[intRegistro].strCodAut;

         FRegMLPgto[intRegistro].strNumOpe := '';
         If arrIndCam[11].intIndice > -1 Then
          FRegMLPgto[intRegistro].strNumOpe := fGetDados(lstCampos[arrIndCam[11].intIndice]);

        FRegMLPgto[intRegistro].strNumVen := '';
        If arrIndCam[12].intIndice > -1 Then
          FRegMLPgto[intRegistro].strNumVen := fGetDados(lstCampos[arrIndCam[12].intIndice]);

        FRegMLPgto[intRegistro].strShp_ID := LShippingID;

        FRegMLPgto[intRegistro].OrderId := fGetDados(lstCampos[arrIndCam[16].intIndice]);

        FRegMLPgto[intRegistro].strCodEst := RetornaValorCampoPorIndice(27, lstCampos, '0');
        FRegMLPgto[intRegistro].LCodEmp   := strCodEmp;
        FRegMLPgto[intRegistro].PosId := RetornaValorCampoPorIndice(25, lstCampos);

        //A venda do marketplace também vem com STORE_ID: o que separa a maquininha é o POS_ID, o mesmo
        //critério de TConcilaRecebiveisMercadoLivre.RetornaSQLConciliacaoMaquininhas. Sem ele, a venda do
        //marketplace ganhava NSU (e o INSTALLMENTS do comprador como total de parcelas) e sumia da conciliação
        If FRegMLPgto[intRegistro].strTipReg.ToUpperInvariant.Equals('PAYMENT') And
           (Not FRegMLPgto[intRegistro].strCodEst.Equals('0')) And
           (Not FRegMLPgto[intRegistro].PosId.IsEmpty) Then
          FRegMLPgto[intRegistro].NumeroNSU := RetornaValorCampoPorIndice(26, lstCampos);

        If FRegMLPgto[intRegistro].strCodAut.ToUpperInvariant.Equals('VENDAPRESENCIAL') Then
          FRegMLPgto[intRegistro].strCodAut := RetornaValorCampoPorIndice(30, lstCampos, FRegMLPgto[intRegistro].strCodAut);

        FRegMLPgto[intRegistro].NumeroCartao := RetornaValorCampoPorIndice(28, lstCampos, '00000000000000');
        If Not FRegMLPgto[intRegistro].NumeroCartao.Equals('00000000000000') Then
          FRegMLPgto[intRegistro].NumeroCartao := FRegMLPgto[intRegistro].NumeroCartao + '****' +
                                                  RetornaValorCampoPorIndice(29, lstCampos);

        FRegMLPgto[intRegistro].strNomArq := strNomArq;
        FRegMLPgto[intRegistro].strDtaArq := strDtaArq;

        CarregaNumeroETotalDeParcelas(FRegMLPgto[intRegistro], lstCampos);

        //Registros de Total não possuem data de transação. Descobrindo a qual data esse total pertence
        If FRegMLPgto[intRegistro].strTipReg = 'total' Then
        Begin
          FRegMLPgto[intRegistro].strDtaTra := FormatDateTime('yyyy-mm-dd HH:MM:SS', dtaMaiorData);
          FRegMLPgto[intRegistro].strDtaPag := FormatDateTime('yyyy-mm-dd HH:MM:SS', dtaMaiorData);
        End
        Else If (FRegMLPgto[intRegistro].strDtaTra.Trim <> '') And
                (VarToDateTime(fRetVal(FRegMLPgto[intRegistro].strDtaTra, True, True)) > dtaMaiorData) Then
          dtaMaiorData := VarToDateTime(fRetVal(FRegMLPgto[intRegistro].strDtaTra, True, True));

        If (FRegMLPgto[intRegistro].LCodEmp <> '') And
           (VS_ListaEstabelecimentos.IndexOf(FRegMLPgto[intRegistro].LCodEmp) < 0) Then
          VS_ListaEstabelecimentos.Add(FRegMLPgto[intRegistro].LCodEmp);

        If Not TMercadoLivreFuncoes.fEmptyStr(FRegMLPgto[intRegistro].strDtaPag) Then
        Begin
          LDataPagamento := LeftStr(FRegMLPgto[intRegistro].strDtaPag,10);
          LDataPagamento := Copy(LDataPagamento, 9, 2) +'/'+ Copy(LDataPagamento, 6, 2) + '/' + Copy(LDataPagamento, 1, 4) ;

          If (VS_DatasPagamento.IndexOf(LDataPagamento) < 0) Then
            VS_DatasPagamento.Add(LDataPagamento);
        End;

        FRegMLPgto[intRegistro].ShipmentMode := fGetDados(lstCampos[arrIndCam[17].intIndice]);

        If arrIndCam[23].intIndice = -1 Then
          FRegMLPgto[intRegistro].BalanceAmount := 0
        Else
          FRegMLPgto[intRegistro].BalanceAmount := TMercadoLivreFuncoes.IIF(Not blnAchouRegistro,
                                                                            fGetDados(lstCampos[arrIndCam[23].intIndice], True),
                                                                            FRegMLPgto[intRegistro].BalanceAmount + (fGetDados(lstCampos[arrIndCam[4].intIndice], True, 0) +
                                                                                                                     fGetDados(lstCampos[arrIndCam[5].intIndice], True, 0) +
                                                                                                                     fGetDados(lstCampos[arrIndCam[7].intIndice], True, 0) +
                                                                                                                     fGetDados(lstCampos[arrIndCam[8].intIndice], True, 0) +
                                                                                                                     LCustoDescontoOferecido));

        If fGetDados(lstCampos[arrIndCam[13].intIndice]) = 'initial_available_balance' Then
        Begin
          FRegMLPgto[intRegistro].strCodAut := 'initial_available_balance';
          FRegMLPgto[intRegistro].strTipReg := 'initial_available_balance';

          FRegMLPgto[intRegistro].strDtaTra := FRegMLPgto[intRegistro].strDtaPag;
        End;

        //TODAS ESSAS CONDIÇÕES SÃO POR CONTA DE INCONSISTÊNCIAS DO PRÓPRIO ARQUIVO DE RETORNO DO MERCADO PAGO
        If DeveAjustarOValorDeFinanciamento(lstCampos, LValorAjustar) Then
        Begin
          FRegMLPgto[intRegistro].fltValMPG := FRegMLPgto[intRegistro].fltValMPG -
                                               LValorAjustar;

          FRegMLPgto[intRegistro].fltValLiq := FRegMLPgto[intRegistro].fltValLiq -
                                               LValorAjustar;
        End
        Else If DeveAjustarOValorDeFreteDeRegistrosPenalizadosPorCubagem(lstCampos, LValorAjustar) Then
        Begin
          FRegMLPgto[intRegistro].fltValEnv := FRegMLPgto[intRegistro].fltValEnv -
                                               LValorAjustar;

          FRegMLPgto[intRegistro].fltValLiq := FRegMLPgto[intRegistro].fltValLiq -
                                               LValorAjustar;
        End
        Else If DeveAjustarOValorLiquidoDePaymentsNegativos(lstCampos, LValorAjustar) Then
          FRegMLPgto[intRegistro].fltValLiq := FRegMLPgto[intRegistro].fltValLiq -
                                               LValorAjustar
        Else If DeveAjustarOValorLiquidoDeRegistrosPenalizadosPorCubagemNegativo(lstCampos, LValorAjustar) Then
        Begin
          FRegMLPgto[intRegistro].fltValLiq := LValorAjustar;

          FRegMLPgto[intRegistro].fltValPro := LValorAjustar;

          FRegMLPgto[intRegistro].fltValEnv := 0;
          FRegMLPgto[intRegistro].fltValMPG := 0;
          FRegMLPgto[intRegistro].fltValPla := 0;
          FRegMLPgto[intRegistro].fltValDev := 0;
          FRegMLPgto[intRegistro].CupomDesconto := 0;
          FRegMLPgto[intRegistro].CustoDescontoOferecido := 0;
        End
        Else If DeveAjustarOValorLiquidoDeRegistrosPenalizadosPorCubagemCancelamento(lstCampos, LValorAjustar) Then
        Begin
          FRegMLPgto[intRegistro].fltValLiq := LValorAjustar;

          FRegMLPgto[intRegistro].fltValPro := LValorAjustar;

          FRegMLPgto[intRegistro].fltValEnv := 0;
          FRegMLPgto[intRegistro].fltValMPG := 0;
          FRegMLPgto[intRegistro].fltValPla := 0;
          FRegMLPgto[intRegistro].fltValDev := 0;
          FRegMLPgto[intRegistro].CupomDesconto := 0;
          FRegMLPgto[intRegistro].CustoDescontoOferecido := 0;
        End;

        If Not blnAchouRegistro Then
        Begin
          LDataPagamento := LeftStr(VarToStr(fRetVal(FRegMLPgto[intRegistro].strDtaPag, True, True, FRegMLPgto[intRegistro].GMTRegistro)), 10);
          Inc(FPosicaoAtualData);
          If Not FDataRegistroArquivo.Equals(LDataPagamento + '|' + strNomArq) Then
          Begin
            FPosicaoAtualData := 1;
            If FRegMLPgto[intRegistro].strTipReg.Equals('initial_available_balance') Then
              FPosicaoAtualData := 0;

            FDataRegistroArquivo := LDataPagamento + '|' + strNomArq;
          End;
          FRegMLPgto[intRegistro].PosicaoArquivoData := FPosicaoAtualData;
        End;

        If Trim(FRegMLPgto[intRegistro].strTipReg + fGetDados(lstCampos[arrIndCam[14].intIndice]) +
                FRegMLPgto[intRegistro].ShipmentMode + FRegMLPgto[intRegistro].OrderId) = 'payment' Then
        Begin
          If fRetVal(FRegMLPgto[intRegistro].fltValLiq) > 0 Then
          Begin
            Try
              LTextoAjusteCredito := VarToStr(fGetDados(lstCampos[arrIndCam[19].intIndice])) + VarToStr(fGetDados(lstCampos[arrIndCam[20].intIndice]));

              If Not LTextoAjusteCredito.Equals('MercadoPagoCheckouts') Then
              Begin
                If FormatFloat('0.00', FRegMLPgto[intRegistro].fltValPro).Equals(FormatFloat('0.00', FRegMLPgto[intRegistro].fltValLiq)) Then
                  FRegMLPgto[intRegistro].strTipReg := 'ajuste_credito';

                If RegistroDePagamentoReferenteATransferenciaDeEntradaDeDinheiro(LShippingID, lstCampos) Then
                 Begin
                   FRegMLPgto[intRegistro].strCodAut := fGetDados(lstCampos[arrIndCam[11].intIndice]);
                   FRegMLPgto[intRegistro].strShp_ID := fGetDados(lstCampos[arrIndCam[11].intIndice]);
                   FRegMLPgto[intRegistro].OrderId := fGetDados(lstCampos[arrIndCam[11].intIndice]);
                   FRegMLPgto[intRegistro].strTipReg := 'payment';

                   If Not blnAchouRegistro Then
                     FChaveRegistro[intRegistro] := fGetDados(lstCampos[arrIndCam[0].intIndice]) + '_' +
                                                    FRegMLPgto[intRegistro].OrderId + '_' +
                                                    Copy(fGetDados(lstCampos[arrIndCam[3].intIndice]),1,10) + '_' +
                                                    strNomArq;
                 End;

              End;
            Except
              FRegMLPgto[intRegistro].strTipReg := 'ajuste_credito';
            End;
          End;
        End;

        If Not blnAchouRegistro Then
          SomaRegistroNaDataCorrespondente(FRegMLPgto[intRegistro], strNomArq);
      End;
    Except
      On E: Exception Do
      Begin
        If Pos('Não é possível importar o arquivo', E.Message) <= 0 Then
          Raise Exception.Create('Ocorreu um erro ao importar o arquivo ' + strNomArq + '.' + #13 +
                                 'Erro gerado: ' + TrataMensagemErro(E.Message, FPosicaoLinha))
        Else
          Raise;
      End;
    End;
  Finally
    If Assigned(lstCampos) Then
      FreeAndNil(lstCampos);
  End;
end;

function TMercadoLivrePgto.fRetVal(strVal: Variant; blnData: Boolean = False; blnCompleta: Boolean = True; AGMT: Integer = -3): Variant;
  Var
    LDataAuxiliar: String;

    LDataFormatada: TDateTime;
Begin
  Result := Null;

  If Not TMercadoLivreFuncoes.fEmptyStr(strVal) Then
  Begin
    Result := strVal;
    If (blnData) Then
    Begin
      If blnCompleta Then
      Begin
        If AGMT <> -3 Then
        Begin
          LDataAuxiliar := Copy(strVal, 9, 2) + '/' + Copy(strVal, 6, 2) + '/' + Copy(strVal, 1, 4) + ' ' + Copy(strVal, 12, 8);
          LDataFormatada := IncHour(IncHour(StrToDateTime(LDataAuxiliar), -3), AGMT * (-1));

          strVal := FormatDateTime('yyyy/mm/dd hh:mm:ss', LDataFormatada);
        End;
      End;

      Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 6, 2) + '/' + Copy(strVal, 9, 2) + ' ' + Copy(strVal, 12, 8);
      If Not blnCompleta Then
        Result := LeftStr(Result, 10);
    End;
  End;
End;

procedure TMercadoLivrePgto.pGravarRegistros(var prgStatus: TcxProgressBar);
  Var
    LRegistroPgto: TRegistroPgto;

    LGravacao: TUniQuery;
begin
  If Assigned(FChaveRegistro) Then
    FreeAndNil(FChaveRegistro);

  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TMercadoLivreFuncoes.RetornaSQLReplace('MER_MLPGTO', ['MER_CONCIL']);

    TMercadoLivreFuncoes.CarregaRegistrosJaImportados('MER_MLPGTO',
                                                     ['MER_CONCIL', 'MER_DTAPAG'],
                                                     ['= 1',RetornaPeriodoPagamento]);

    FCancelouImportacao := Not AvaliacaoDeArquivosReimportados;
    If FCancelouImportacao Then
      Exit;

    FCancelouImportacao := Not AvaliacaoDeArquivosReimportadosEmOutrasEmpresas;
    If FCancelouImportacao Then
      Exit;

    prgStatus.Position := 0;

    If Length(FRegMLPgto) = 0 Then
      Exit;

    prgStatus.Properties.Max := Length(FRegMLPgto)-1;
    For LRegistroPgto In FRegMLPgto Do
    Begin
      If (Not LRegistroPgto.strTipReg.IsEmpty) Then
      Begin
        LGravacao.Close;

        If RegistroJaImportado(LRegistroPgto) Then
        Begin
          prgStatus.Position := prgStatus.Position + 1;

          Continue;
        End;

        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[0].strNomCam, fRetVal(LRegistroPgto.strTipReg));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_STATUS', fRetVal(LRegistroPgto.strStatus));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[1].strNomCam, fRetVal(LRegistroPgto.strCodAut));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[2].strNomCam, fRetVal(LRegistroPgto.strDtaTra, True, True, LRegistroPgto.GMTRegistro));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[3].strNomCam, fRetVal(LRegistroPgto.strDtaPag, True, True, LRegistroPgto.GMTRegistro));

        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[4].strNomCam, TMercadoLivreFuncoes.IIF(fRetVal(LRegistroPgto.fltValPro) = 0,
                                                                                                             fRetVal(LRegistroPgto.fltValLiq),
                                                                                                             fRetVal(LRegistroPgto.fltValPro)));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[5].strNomCam, fRetVal(LRegistroPgto.fltValEnv));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[6].strNomCam, fRetVal(LRegistroPgto.fltValLiq));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[7].strNomCam, fRetVal(LRegistroPgto.fltValMPG));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[8].strNomCam, fRetVal(LRegistroPgto.fltValPla));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[9].strNomCam, fRetVal(LRegistroPgto.fltValDev));

        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[10].strNomCam, fRetVal(LRegistroPgto.strTipPag));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[11].strNomCam, fRetVal(LRegistroPgto.strNumOpe));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[12].strNomCam, fRetVal(LRegistroPgto.strNumVen));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[14].strNomCam, fRetVal(LRegistroPgto.strShp_ID));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[15].strNomCam, fRetVal(LRegistroPgto.CupomDesconto));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[16].strNomCam, fRetVal(LRegistroPgto.OrderId));

        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_CODEST', fRetVal(LRegistroPgto.strCodEst));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_CODEMP', fRetVal(LRegistroPgto.LCodEmp));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_NOMARQ', fRetVal(LRegistroPgto.strNomArq));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_DTAARQ', fRetVal(LRegistroPgto.strDtaArq, True, False));

        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_NUMPAR', LRegistroPgto.NumeroParcela);
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_TOTPAR', LRegistroPgto.TotalParcelas);
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_NUMCAR', LRegistroPgto.NumeroCartao);
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_SALDO_', fRetVal(LRegistroPgto.BalanceAmount));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_DTASTR', LRegistroPgto.DataCompletaString);

        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_CUPEFE', fRetVal(LRegistroPgto.CustoDescontoOferecido));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_POSDIA', fRetVal(LRegistroPgto.PosicaoArquivoData));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_POS_ID', fRetVal(LRegistroPgto.PosId));
        TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, 'MER_NUMNSU', fRetVal(LRegistroPgto.NumeroNSU));

        If RegistroDeVendaMarcadoComoFretePeloML(LRegistroPgto) Then
          TMercadoLivreFuncoes.CarregaParametroDataset(LGravacao, arrIndCam[0].strNomCam, 'payment');

        LGravacao.ExecSQL;

       If Not AnsiUpperCase(LRegistroPgto.strTipReg).Contains('TOTAL') Then
         untMercadoLivrePgto.FTemRegistroParaConciliacao := True;
      End;

      TMercadoLivreFuncoes.pStepStatusGravacao(prgStatus);
    End;

    TMercadoLivreFuncoes.GravarEstabelecimentos;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LGravacao);

    TMercadoLivreFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

    If Assigned(VS_DatasPagamento) Then
      FreeAndNil(VS_DatasPagamento);
  End;
end;

function TMercadoLivrePgto.PossuiTodosOsCamposParaCalculo: Boolean;
begin
  Result := True;

  If arrIndCam[4].intIndice = -1 Then
    Exit(False);

  If arrIndCam[5].intIndice = -1 Then
    Exit(False);

  If arrIndCam[6].intIndice = -1 Then
    Exit(False);

  If arrIndCam[7].intIndice = -1 Then
    Exit(False);

  If arrIndCam[8].intIndice = -1 Then
    Exit(False);
end;

function TMercadoLivrePgto.RegistroDePagamentoReferenteATransferenciaDeEntradaDeDinheiro(AShippingID: String;
  AListaCampos: TStringList): Boolean;
begin
  If Not Trim(fGetDados(AListaCampos[arrIndCam[1].intIndice])).IsEmpty Then
    Exit(False);

  If Not Trim(fGetDados(AListaCampos[arrIndCam[0].intIndice])).Equals('payment') Then
    Exit(False);

  If Not AShippingID.Trim.IsEmpty Then
    Exit(False);

  If Not Trim(fGetDados(AListaCampos[arrIndCam[16].intIndice])).IsEmpty Then
    Exit(False);

  If Trim(fGetDados(AListaCampos[arrIndCam[11].intIndice])).IsEmpty Then
    Exit(False);

  Result := True;
end;

function TMercadoLivrePgto.RegistroDeVendaMarcadoComoFretePeloML(ARegistroMLPgto: TRegistroPgto): Boolean;
begin
  If fRetVal(ARegistroMLPgto.strTipReg) <> 'shipping' Then
    Exit(False);

  If fRetVal(ARegistroMLPgto.fltValLiq) <= 0 Then
    Exit(False);

  If fRetVal(ARegistroMLPgto.strCodAut) = fRetVal(ARegistroMLPgto.strShp_ID) Then
    Exit(False);

  Result := Not LowerCase(fRetVal(ARegistroMLPgto.strCodAut)).Contains('cashback_');
end;

function TMercadoLivrePgto.RegistroJaImportado(ARegistro: TRegistroPgto): Boolean;
  Var
    LTipReg,
    LStatus,
    LCodAut: String;

    LDtaTra,
    LDtaPag : TDateTime;
    LDtaAux: String;
begin
  LTipReg := fRetVal(ARegistro.strTipReg);
  LStatus := fRetVal(ARegistro.strStatus);
  If FTamandoCampoMER_CODAUT > 0 Then
    LCodAut := LeftStr(fRetVal(ARegistro.strCodAut), FTamandoCampoMER_CODAUT)
  Else
    LCodAut := fRetVal(ARegistro.strCodAut);

  LDtaAux := fRetVal(ARegistro.strDtaTra, True);
  LDtaAux := Copy(LeftStr(LDtaAux,10), 9, 2) + '/'+
             Copy(LeftStr(LDtaAux,10), 6, 2) + '/' +
             Copy(LeftStr(LDtaAux,10), 1, 4) + RightStr(LDtaAux,9);
  LDtaTra := StrToDateTime(LDtaAux);
  If ARegistro.GMTRegistro <> -3 Then
    LDtaTra := IncHour(IncHour(LDtaTra, -3), ARegistro.GMTRegistro * (-1));

  LDtaAux := fRetVal(ARegistro.strDtaPag, True);
  LDtaAux := Copy(LeftStr(LDtaAux,10), 9, 2) + '/'+
             Copy(LeftStr(LDtaAux,10), 6, 2) + '/' +
             Copy(LeftStr(LDtaAux,10), 1, 4) + RightStr(LDtaAux,9);
  LDtaPag := StrToDateTime(LDtaAux);
  If ARegistro.GMTRegistro <> -3 Then
    LDtaPag := IncHour(IncHour(LDtaPag, -3), ARegistro.GMTRegistro * (-1));


  Result := VS_RegistrosJaImportados.Locate('MER_TIPREG;MER_STATUS;MER_CODAUT;MER_DTATRA;MER_DTAPAG',
                                          VarArrayOf([LTipReg,
                                                      LStatus,
                                                      LCodAut,
                                                      LDtaTra,
                                                      LDtaPag]),[]);

  Try
    If Result Then
      Exit;

    If FTamandoCampoMER_CODAUT = 20 Then
      Exit;

    //Adicionada essa validação para não "duplicar" os registros já importados e conciliados com o campo menor
    If LCodAut.Length > 20 Then
      Result := VS_RegistrosJaImportados.Locate('MER_TIPREG;MER_STATUS;MER_CODAUT;MER_DTATRA;MER_DTAPAG',
                                          VarArrayOf([LTipReg,
                                                      LStatus,
                                                      LeftStr(LCodAut, 20),
                                                      LDtaTra,
                                                      LDtaPag]),[]);
  Finally
    If Result Then
      AtualizaPosicaoDoDiaNoArquivo(ARegistro);
  End;
end;

function TMercadoLivrePgto.RetornaChaveDaVendaParaAgrupamento(
  AListaCampos: TStringList): String;
begin
  Result := fGetDados(AListaCampos[arrIndCam[0].intIndice]) + '_' +
                       TMercadoLivreFuncoes.IIF(Trim(fGetDados(AListaCampos[arrIndCam[FIndiceVenda].intIndice])) <> '',
                                                fGetDados(AListaCampos[arrIndCam[FIndiceVenda].intIndice]),
                                                fGetDados(AListaCampos[arrIndCam[1].intIndice])) + '_' +
                                                    Copy(fGetDados(AListaCampos[arrIndCam[3].intIndice]),1,10) + '_' +
                                                    strNomArq;

  If Not RetornaValorCampoPorIndice(0, AListaCampos).Equals('payment') Then
    Exit;

  If Not RetornaValorCampoPorIndice(FIndiceVenda, AListaCampos).Trim.IsEmpty Then
    Exit;

  If Not RetornaValorCampoPorIndice(1, AListaCampos).ToUpperInvariant.Equals('VENDAPRESENCIAL') Then
    Exit;

  If arrIndCam[30].intIndice < 0 Then
    Exit;

  Result := RetornaValorCampoPorIndice(0, AListaCampos) + '_' +
            RetornaValorCampoPorIndice(30, AListaCampos) + '_' +
            Copy(fGetDados(AListaCampos[arrIndCam[3].intIndice]),1,10) + '_' +
            strNomArq;
end;

function TMercadoLivrePgto.RetornaGMTRegistro(ADataRegistro: String): Integer;
  Var
    LGMTString: String;

    LGMTRegistro: Integer;
begin
  Result := -3;

  LGMTString := RightStr(ADataRegistro, 6);
  If TryStrToInt(LeftStr(LGMTString, 3), LGMTRegistro) Then
    Result := LGMTRegistro;
end;

function TMercadoLivrePgto.RetornaLinhaFormatada(ALinha: String): String;
begin
  Result :=  StringReplace(ALinha, ' ', EmptyStr, [rfReplaceAll]);     // remove espaços
  Result :=  StringReplace(Result, '"', EmptyStr, [rfReplaceAll]);     // remove aspas duplas
  Result :=  StringReplace(Result, Chr(39), EmptyStr, [rfReplaceAll]); // remove aspas simples
end;

function TMercadoLivrePgto.RetornaPeriodoPagamento: String;
  Var
    LDataInicial: String;
    LDataFinal: String;
begin
  VS_DatasPagamento.Sort;
  LDataInicial := VS_DatasPagamento[0];
  LDataFinal := VS_DatasPagamento[VS_DatasPagamento.Count - 1];

  Result := 'BETWEEN ' +
             FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(LDataInicial + ' 00:00:00')).QuotedString + ' AND '+
             FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(LDataFinal + ' 23:59:59')).QuotedString;

end;

function TMercadoLivrePgto.RetornaValorCampoPorIndice(
  AIndiceCampo: Integer; AListaCampos: TStringList;
  AValorDefault: String = ''): String;
begin
  Result := AValorDefault;

  If AIndiceCampo < 0 Then
    Exit;

  If arrIndCam[AIndiceCampo].intIndice > -1 Then
  Begin
    Result := fGetDados(AListaCampos[arrIndCam[AIndiceCampo].intIndice]);

    If Result.Trim.isEmpty Then
      Result := AValorDefault;
  End;
end;

function TMercadoLivrePgto.RetornaValorShippingID(ACampos: TStringList): Variant;
begin
  Try
    If VarToStr(fGetDados(ACampos[arrIndCam[14].intIndice])).Trim.IsEmpty Then
    Begin
      If VarToStr(fGetDados(ACampos[arrIndCam[16].intIndice])).Trim.IsEmpty Then
      Begin
        If fGetDados(ACampos[arrIndCam[19].intIndice]) = 'MercadoPago' Then
        Begin
          If fGetDados(ACampos[arrIndCam[20].intIndice]) = 'Checkouts' Then
            Exit(fGetDados(ACampos[arrIndCam[11].intIndice]));
        End;
      End;
    End;
  Except

  End;

  Result := VarToStr(fGetDados(ACampos[arrIndCam[14].intIndice])).Trim;
  If VarToStr(Result).IsEmpty Then
    Result := VarToStr(fGetDados(ACampos[arrIndCam[1].intIndice])).Trim;
end;

function TMercadoLivrePgto.SolicitaDireitoDeAcessoParaImportacaoInconsistente: Boolean;
  Var
    LTexto: String;
begin
  LTexto := '***Permitir importar mais de um arquivo para mesma data de pagamento na Conciliação/Baixa de Recebíveis do Mercado Livre***' + #13 + #13;

  LTexto := LTexto + 'Quando é realizada a importação dessa maneira, relatório e totais referente a um período especifico pode ';
  LTexto := LTexto + 'não ser o mesmo que está ' + #13 + 'no portal do Mercado Livre/Pago.' + #13;
  LTexto := LTexto + 'Isso ocorre pois arquivos de logins diferentes do portal não terão o mesmo saldo inicial, final, entre outros lançamentos.' + #13 + #13;
  LTexto := LTexto + '*RECOMENDAÇÃO*' + #13;
  LTexto := LTexto + 'Para realizar uma conciliação mais assertiva com o portal com vários logins, o recomendado é: ' + #13;
  LTexto := LTexto + '-Utilizar a CFG_MEREMP igual a Sim; ' + #13;
  LTexto := LTexto + '-Importar o arquivo de cada login para uma empresa separada; ' + #13;
  LTexto := LTexto + '-Para conciliar, coloque o período exato do arquivo e a empresa em que determinado login foi importado.';

  Result := VS_FuncoesExternas.fIPedirLiberacao('PERIMPARQMAISMKT',
                                                'Permitir importar mais de um arquivo para mesma data de pagamento na Conciliação/Baixa de Recebíveis do Mercado Livre',
                                                LTexto);
end;

function TMercadoLivrePgto.SolicitaDireitoDeAcessoParaImportacaoMesmoArquivoEmpresasDiferentes(
  AArquivoJaImporado, AEmpresa: String): Boolean;
  Var
    LTexto: String;
begin
  LTexto := '***Permitir importar mais de um arquivo para mesma data de pagamento na Conciliação/Baixa de Recebíveis do Mercado Livre***' + #13 + #13;

  LTexto := LTexto + 'O sistema identificou que um arquivo com a mesma quantidade de registros ao arquivo ' + #13;
  LTexto := LTexto + AArquivoJaImporado + ' já foi importado e conciliado' + TMercadoLivreFuncoes.IIF(AEmpresa.IsEmpty, '.', ' na empresa ' + AEmpresa + '.') + #13;
  LTexto := LTexto + 'Caso o arquivo atual possua as mesmas vendas/registros ao anterior, a reimportação ' + #13;
  LTexto := LTexto + 'não será feita de forma completa na empresa atual, fazendo com que a conciliação ' + #13;
  LTexto := LTexto + 'não gere valores consistentes.' + #13 + #13;
  LTexto := LTexto + 'Confirmar a importação do arquivo ' + AArquivoJaImporado + '?';

  Result := VS_FuncoesExternas.fIPedirLiberacao('PERIMPARQMAISMKT',
                                                'Permitir importar mais de um arquivo para mesma data de pagamento na Conciliação/Baixa de Recebíveis do Mercado Livre',
                                                LTexto);
end;

procedure TMercadoLivrePgto.SomaRegistroNaDataCorrespondente(
  ARegistroMLPgto: TRegistroPgto; ANomeDoArquivo: String);
  Var
    LDataArquivo: TEmpresasDatasImportacao;

    LContador,
    LIndice: Integer;

    LInserir: Boolean;

    LDataAtualizada: String;
begin
  If MatchStr(ARegistroMLPgto.strTipReg.ToLowerInvariant, ['total', 'initial_available_balance']) Then
    Exit;

  LContador := FDatasEmpresasImportacao.Count;
  LIndice := LContador;

  LDataAtualizada := fRetVal(ARegistroMLPgto.strDtaPag, True, True, ARegistroMLPgto.GMTRegistro);

  If LContador = 0 Then
  Begin
    LDataArquivo := TEmpresasDatasImportacao.Create;
    LDataArquivo.DataImportacao := StrToDate(Copy(LDataAtualizada, 9,2) + '/' +
                                             Copy(LDataAtualizada, 6,2) + '/' +
                                             Copy(LDataAtualizada, 1,4));
    LDataArquivo.QuantidadeRegistros := 1;
    LDataArquivo.Empresa := strCodEmp;
    LDataArquivo.NomeArquivos := ANomeDoArquivo + ',';

    FDatasEmpresasImportacao.Add(LDataArquivo);

    Exit;
  End;


  LInserir := Not FormatDateTime('yyyy-mm-dd', FDatasEmpresasImportacao[LContador - 1].DataImportacao)
                  .Equals(LeftStr(ARegistroMLPgto.strDtaPag, 10));

  If LInserir Then
  Begin
    For LContador := 0 To FDatasEmpresasImportacao.Count - 1 Do
    Begin
      LInserir := Not FormatDateTime('yyyy-mm-dd', FDatasEmpresasImportacao[LContador].DataImportacao)
                      .Equals(LeftStr(ARegistroMLPgto.strDtaPag, 10));

      If Not LInserir Then
      Begin
        LIndice := LContador + 1;
        Break;
      End;
    End;
  End;

  If Not LInserir Then
  Begin
    FDatasEmpresasImportacao[LIndice - 1].QuantidadeRegistros := FDatasEmpresasImportacao[LIndice - 1].QuantidadeRegistros + 1;

    If Not FDatasEmpresasImportacao[LIndice - 1].NomeArquivos.Contains(ANomeDoArquivo) Then
      FDatasEmpresasImportacao[LIndice - 1].NomeArquivos := FDatasEmpresasImportacao[LIndice - 1].NomeArquivos +
                                                            ANomeDoArquivo + ',';

    Exit;
  End;

  LDataArquivo := TEmpresasDatasImportacao.Create;
  LDataArquivo.DataImportacao := StrToDate(Copy(LDataAtualizada, 9,2) + '/' +
                                           Copy(LDataAtualizada, 6,2) + '/' +
                                           Copy(LDataAtualizada, 1,4));
  LDataArquivo.QuantidadeRegistros := 1;
  LDataArquivo.Empresa := strCodEmp;
  LDataArquivo.NomeArquivos := ANomeDoArquivo + ',';

  FDatasEmpresasImportacao.Add(LDataArquivo);
end;

function TMercadoLivrePgto.TrataMensagemErro(AErro: String;
  ARegistro: Integer): String;
begin
  Result := AErro;

  If AErro.Contains('Could not convert variant of type') Then
  Begin
    If AErro.Contains('into type') Then
      Exit('Problema ao converter as colunas da linha ' + (ARegistro).ToString + ' do arquivo.' + #13 +
           'A linha pode estar fora do padrão e/ou o arquivo foi alterado antes da importação.');
  End;
end;

procedure TMercadoLivrePgto.ValidaSeOsDadosEstaoCorretos(ACampos: TStringList);
begin
  fGetDados(ACampos[arrIndCam[1].intIndice],
                    False,
                    0,
                    True);

  fGetDados(ACampos[arrIndCam[11].intIndice],
                    False,
                    0,
                    True);

  fGetDados(ACampos[arrIndCam[12].intIndice],
                    False,
                    0,
                    True);

  fGetDados(ACampos[arrIndCam[13].intIndice],
                    False,
                    0,
                    True);

  fGetDados(ACampos[arrIndCam[14].intIndice],
                    False,
                    0,
                    True);
end;

end.
