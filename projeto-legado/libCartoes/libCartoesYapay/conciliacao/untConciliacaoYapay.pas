unit untConciliacaoYapay;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math, System.Generics.Collections, System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar,

     untYapayConciliacaoCartoes, untLibCartoesInterfacesTipos, untTYapayFuncoes;

type
  TAjusteSaque = class
    private

    public
      dtaDataSaque  : TDateTime;
      fltValorAjuste: Double;
      intConciliado : Integer;
  end;

type
  TConcilYapay = class(TConciliacaoCartoes)
  private
    FSaques,
    FSaqueAnterior,
    FUltimoSaque  : TUniClientDataset;

    FAjustesSaques: TObjectList<TAjusteSaque>;

    FListaDePedidos,
    FCodigoConciliacao,
    FDiasDeAjusteDoSaque: String;

    FUtilizaPortadorTF: Boolean;

    function fBuscaCartaoYapay: Boolean;
    function fBuscaCartaoBaixadoYapay: Boolean;

    procedure FiltraSaquesYapay;
    function CriaDatasetConciliacao: Boolean;
    procedure CorrigeDataDePagamentoParaADataDoSaque(var ARegistros: TUniClientDataset);
    procedure GeraAjustesDeDiferencaDoTotalContraSaque;
    procedure GravaAjustesDeSaque;
    procedure FiltraAjustesYapay;

    function pFiltraCartoesYapay(pgbStatus: TcxProgressBar): Boolean;
    procedure pFiltraCartoesBaixadosYapay;

    procedure VerificaSituacaoDoCadastro(var AInconsistencia: TItensRelatorioCartoes;
                                         AEmpresaConfiguracao: String);
    function ValidaConfiguracoesAjustes(ACodigoEmpresa: String): Boolean;

    function RetornaParametroDataInicial: String;
    function RetornaParametroDataFinal: String;
    function RetornaListaDePedidos: String;

    function fProcessaYapayPag(pgbStatus: TcxProgressBar): Boolean;

    function fConciliaYapay(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;

  protected

  end;

Const
  INICAM = 'YAP_';
  NOMTAB = 'YAP_YAPGTO';

implementation

uses untTLibCartoesMovCar;

function TConcilYapay.fConciliaCartoes: Boolean;
begin
  Result := TYapayFuncoes.ExecutaAguarde(fConciliaYapay, 'Aguarde... Iniciando a conciliação.');
end;

function TConcilYapay.fConciliaYapay(pgbStatus: TcxProgressBar): Boolean;
Begin
  Result       := False;
  FPossuiInconsistencia := False;

  TForm(pgbStatus.Owner).Visible := False;
  pgbStatus.Visible := False;

  FDiasDeAjusteDoSaque := VS_FuncoesExternas.fICfgSis('YAPDIAS', varString);
  If TYapayFuncoes.fEmptyStr(FDiasDeAjusteDoSaque) Then
    FDiasDeAjusteDoSaque := '0';

  Try
    Try
      objConcil.TabelaConciliacao := NOMTAB;
      objConcil.CampoEstabelecimento := INICAM + 'CODEST';
      objConcil.NomeConciliacao := 'YAPAY';
      objConcil.CfgEstabelecimentos := 'CFG_YAPESTB';
      objConcil.CampoValorBruto := INICAM + 'VALPAG';
      objConcil.CampoValorLiquido := INICAM + 'VALPAG';
      objConcil.CampoCodigoAutorizacao := INICAM + 'CODPED';
      objConcil.CampoNumeroNSU := INICAM + 'CODPED';
      objConcil.CampoDataTransacaoVenda := INICAM + 'DTAPAG';
      objConcil.CampoNumeroParcela := INICAM + 'NUMPAR';
      objConcil.CampoTotalParcelas := INICAM + 'NUMPAR';
      objConcil.CampoNumeroCartao := INICAM + 'EXTRAT';
      objConcil.CampoDataRecebimento := INICAM + 'DTAPAG';
      objConcil.CampoTipoRegistro := INICAM + 'TIPREG';
      objConcil.CodigoConciliacao := INICAM + 'CODCON';
      objConcil.CfgPortadorAjustes := 'YAPPORB';
      objConcil.CfgPlanoDeContasAjustes := 'YAPCTAB';
      objConcil.CfgFornecedorAjustes := 'YAPFORB';
      objConcil.strEventoCancelamentoAjuste := 'YAPEVEB';
      objConcil.CfgPortadorTransferencia := 'YAPTRF';
      objConcil.CfgPlanoDeContasTransferencia := 'YAPCTF';
      objConcil.CfgCentroDeCustosTransferencia := 'YAPETF';

      objConcil.strChavePrimaria := 'YAP_CODEST,YAP_EXTRAT,YAP_CODTRA,YAP_CODPED,YAP_NUMPAR,YAP_DTAPAG,YAP_TIPREG';

      FUtilizaPortadorTF := VS_FuncoesExternas.fICfgSis('YAPTRF') <> '';

      {**************************************}
      {* PEGANDO O PERÍODO PARA CONCILIAÇÃO *}
      {***********************************AJ*}
      If Not fDigPeriodo('Digite o período da solicitação de saque a ser conciliado') Then
        Exit;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'YAPAY',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TyapayFuncoes.RetornaDataHoraServidor,
                                                            TYapayFuncoes.RetornaHoraServidor);

      TForm(pgbStatus.Owner).Visible := True;

      TYapayFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros para conciliação.', False);

      If Not CriaDatasetConciliacao Then
        Exit;

      fProcessaYapayPag(pgbStatus);
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConciliaYapay]');

        Exit(False);
      End;
    End;

    cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    FPossuiInconsistencia := False;

    TYapayFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
    GravarRegistrosRelatorio(pgbStatus);

    TForm(pgbStatus.Owner).Visible := False;

    if FPossuiInconsistencia then
      TYapayFuncoes.fMensagem('', 'Foram encontradas inconsistências na importação dos arquivos!', ['&OK']);


    if FListaRegistrosRelatorio.Count > 0 then
      Result := GeraRelatorioConciliacao('YAPAY', pgbStatus);

    if Assigned(cdsAjustes) then
    begin
      cdsAjustes.Filter := 'YAP_CONCIL=0';
      cdsAjustes.Filtered := True;
    end;

    blnReabre := not Result;
    if Result then
    begin
      cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
      cdsBaiCar.Filtered := True;

      Result := not cdsBaiCar.IsEmpty;
      if not Result then
        TYapayFuncoes.fMensagem('ATENÇÃO', 'Nenhum pagamento foi conciliado no período selecionado!', ['&OK'])
      else
        TYapayFuncoes.fMensagem('AVISO', 'Conciliação da YAPAY realizada com sucesso.', ['&OK']);
    end;
  Finally
    TYapayFuncoes.FreeAndNilDatasets(cdsConCar);
    TYapayFuncoes.FreeAndNilDatasets(FSaques);
    TYapayFuncoes.FreeAndNilDatasets(FSaqueAnterior);
    TYapayFuncoes.FreeAndNilDatasets(FUltimoSaque);

    If Assigned(FAjustesSaques) Then
      FreeAndNil(FAjustesSaques);
  End;
End;

procedure TConcilYapay.FiltraAjustesYapay;
Var
  LSQL,
  LEmpresaConfiguracao: String;

  LCancelamento  : TUniQuery;

  LInconsistencia: TItensRelatorioCartoes;

  LAjusteCredito: Boolean;
begin
  LCancelamento := Nil;
  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT A.*, YAP_DESCRI AS TIPAJU, IF(YAP_VALPAG>0, YAP_VALPAG, 0) AS AJUCRE, ';
    LSQL := LSQL + '  "S" AS MARCADO, CAST("0000-00-00" AS DATE) AS YAP_DTASAQ, "" AS VAZIO, "" AS EMPRESA ';
    LSQL := LSQL + ' FROM ' + objConcil.TabelaConciliacao + ' A ';
    LSQL := LSQL + ' WHERE YAP_DTAPAG BETWEEN :DTAIN AND :DTAFIM ';
    LSQL := LSQL + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
    LSQL := LSQL + ' AND (YAP_TIPREG = "AJUSTE") AND (YAP_VALPAG <> 0)  ';

    LCancelamento := VS_FuncoesExternas.fICriaQuery;
    LCancelamento.SQL.Text := LSQL;

    LCancelamento.ParamByName('DTAIN').AsString  := RetornaParametroDataInicial;
    LCancelamento.ParamByName('DTAFIM').AsString := RetornaParametroDataFinal;

    LCancelamento.Open;

    cdsAjustes := TYapayFuncoes.CriarClientDataSet(LCancelamento);
    cdsAjustes.Open;

    CorrigeDataDePagamentoParaADataDoSaque(cdsAjustes);

    cdsAjustes.First;
    While Not cdsAjustes.Eof Do
    Begin
      LEmpresaConfiguracao :=  VS_FuncoesExternas.fIRetEmpresaLogada;

      LInconsistencia := TItensRelatorioCartoes.Create;

      Try
        LInconsistencia.CodigoEmpresa := LEmpresaConfiguracao;
        LAjusteCredito := cdsAjustes.FieldByName('AJUCRE').Value <> 0;

        If LAjusteCredito Then
        Begin
          LInconsistencia.ValorBruto :=  cdsAjustes.FieldByName('AJUCRE').Value;
          LInconsistencia.ValorLiquido := cdsAjustes.FieldByName('AJUCRE').Value;
        End
        Else
        Begin
          LInconsistencia.ValorBruto := cdsAjustes.FieldByName(objConcil.CampoValorLiquido).Value;
          LInconsistencia.ValorLiquido := cdsAjustes.FieldByName(objConcil.CampoValorLiquido).Value;
        End;

        LInconsistencia.Descricao := 'Cancelamentos/Ajustes';
        LInconsistencia.NomeCliente := TYapayFuncoes.IIF(cdsAjustes.FindField('TIPAJU') <> Nil, cdsAjustes.FieldByName('TIPAJU').AsString, '');
        LInconsistencia.Parcela := TYapayFuncoes.fStrZero('0', 12);
        LInconsistencia.CodigoAutorizacao := TYapayFuncoes.IIF(cdsAjustes.FieldByName(objConcil.CampoNumeroNSU).Value <> '0',
                                   cdsAjustes.FieldByName(objConcil.CampoNumeroNSU).Value,
                                   '00000000000000');
        LInconsistencia.NumeroNSU := cdsAjustes.FieldByName(objConcil.CampoNumeroNSU).Value;
        LInconsistencia.CodigoEstabelecimento := VS_FuncoesExternas.fIRetEmpresaLogada;//VS_strCodEmp;
        LInconsistencia.NumeroCartao := cdsAjustes.FieldByName(objConcil.CampoNumeroCartao).AsString;

        LInconsistencia.TipoDoRegistro := 'AJUSTES';
        LInconsistencia.TipoCartao := 'CANCELAMENTOS/AJUSTES';
        LInconsistencia.DescricaoAjuste := cdsAjustes.FieldByName('TIPAJU').AsString;

        LInconsistencia.DataPagamento  := cdsAjustes.FieldByName('YAP_DTAPAG').Value;

        LInconsistencia.Parcela  := TYapayFuncoes.fStrZero(cdsAjustes.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);

        LInconsistencia.CodigoAutorizacao := TYapayFuncoes.fStrZero(Trim(cdsAjustes.FieldByName(objConcil.CampoCodigoAutorizacao).Value), 6);

        LInconsistencia.DataVencimento  := cdsAjustes.FieldByName(TYapayFuncoes.IIF(Not FUtilizaPortadorTF, 'YAP_DTASAQ', 'YAP_DTAPAG')).Value;
        LInconsistencia.Descricao := LEmpresaConfiguracao + '-' + TYapayFuncoes.RetornaNomeEmpresa(LEmpresaConfiguracao);
        LInconsistencia.DataVenda := cdsAjustes.FieldByName(INICAM + 'DTAPAG').Value;

        LInconsistencia.Conciliado  := cdsAjustes.FieldByName(LeftStr(objConcil.CampoCodigoAutorizacao, 4) + 'CONCIL').AsInteger;
        LInconsistencia.NomeArquivo := cdsAjustes.FieldByName('YAP_NOMARQ').AsString;

        LInconsistencia.RegistroIncompleto := 'N';

        If FBaixarAjustes Then
        Begin
          LInconsistencia.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

          GravarRegistroDeAjusteParaConciliacao(LInconsistencia);
        End;
      Except
        FreeAndNil(LInconsistencia);
        Raise;
      End;

      FListaRegistrosRelatorio.Add(LInconsistencia);

      cdsAjustes.Next;
    End;

  Finally
    TYapayFuncoes.FreeAndNilDatasets(LCancelamento);
  End;
end;

procedure TConcilYapay.FiltraSaquesYapay;
var
  LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  try
    if FUtilizaPortadorTF then
    begin
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT * FROM YAP_YAPGTO WHERE FALSE';
      LConsulta.Open;

      FSaques := TYapayFuncoes.CriarClientDataSet(LConsulta);
      FSaques.Open;

      FSaqueAnterior :=TYapayFuncoes.CriarClientDataSet(LConsulta);
      FSaqueAnterior.Open;

      FUltimoSaque := TYapayFuncoes.CriarClientDataSet(LConsulta);
      FUltimoSaque.Open;

      Exit;
    end;

    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text :=
      'SELECT YAP_DTAPAG, SUM(YAP_VALPAG) AS YAP_VALPAG ' +
      'FROM YAP_YAPGTO ' +
      'WHERE YAP_DTAPAG BETWEEN ' +
      QuotedStr(FormatDateTime('yyyy/mm/dd', dtaDtaIni)) + ' AND ' +
      QuotedStr(FormatDateTime('yyyy/mm/dd', dtaDtaFim)) + ' AND ' +
      'YAP_TIPREG = "SAQUE" ' +
      'GROUP BY YAP_DTAPAG ' +
      'ORDER BY YAP_DTAPAG';
    LConsulta.Open;

    FSaques := TYapayFuncoes.CriarClientDataSet(LConsulta);
    FSaques.Open;

    LConsulta.Close;
    LConsulta.SQL.Text :=
      'SELECT * FROM YAP_YAPGTO ' +
      'WHERE YAP_DTAPAG < ' + QuotedStr(FormatDateTime('yyyy/mm/dd', dtaDtaIni)) +
      ' AND YAP_TIPREG = "SAQUE" ' +
      'ORDER BY YAP_DTAPAG DESC LIMIT 1';
    LConsulta.Open;
    FSaqueAnterior := TYapayFuncoes.CriarClientDataSet(LConsulta);
    FSaqueAnterior.Open;

    LConsulta.Close;
    LConsulta.SQL.Text :=
      'SELECT * FROM YAP_YAPGTO ' +
      'WHERE YAP_DTAPAG <= ' + QuotedStr(FormatDateTime('yyyy/mm/dd', dtaDtaFim)) +
      ' AND YAP_TIPREG = "SAQUE" ' +
      'ORDER BY YAP_DTAPAG DESC LIMIT 1';
    LConsulta.Open;
    FUltimoSaque := TYapayFuncoes.CriarClientDataSet(LConsulta);
    FUltimoSaque.Open;

    FreeAndNil(LConsulta);
  Finally
    TYapayFuncoes.FreeAndNilDatasets(LConsulta);
  end;
end;

function TConcilYapay.fBuscaCartaoYapay: Boolean;
Var
  LParcela: String;
begin
  LParcela := TYapayFuncoes.fGetLetraAlfa(cdsConCar.FieldByName('YAP_NUMPAR').AsInteger);
  Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                             VarArrayOf([cdsConCar.FieldByName('YAP_CODPED').AsString,
                                         LParcela, 'D']), []);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                               VarArrayOf([cdsConCar.FieldByName('YAP_CODTRA').AsString,
                                           LParcela, 'D']), []);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_CODPED').AsString, 14),
                                           LParcela, 'D']), []);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_CODTRA').AsString, 14),
                                           LParcela, 'D']), []);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([RightStr(cdsConCar.FieldByName('YAP_CODPED').AsString,14),
                                           LParcela, 'D']), []);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([RightStr(cdsConCar.FieldByName('YAP_CODTRA').AsString,14),
                                           LParcela, 'D']), []);

  If Not Result Then
  Begin
     If (cdsConCar.FieldByName('YAP_NUMPAR').AsInteger > 26) Then
     Begin
         LParcela := TYapayFuncoes.fStrZero( cdsConCar.FieldByName('YAP_NUMPAR').AsString, 3);

         Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                                    VarArrayOf([cdsConCar.FieldByName('YAP_CODPED').AsString,
                                                LParcela, 'D']), []);

         If Not Result Then
           Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                                      VarArrayOf([cdsConCar.FieldByName('YAP_CODTRA').AsString,
                                                  LParcela, 'D']), []);

         If Not Result Then
           Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                      VarArrayOf([TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_CODPED').AsString, 14),
                                                  LParcela, 'D']), []);

         If Not Result Then
           Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                      VarArrayOf([TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_CODTRA').AsString, 14),
                                                  LParcela, 'D']), []);

         If Not Result Then
           Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                      VarArrayOf([RightStr(cdsConCar.FieldByName('YAP_CODPED').AsString,14),
                                                  LParcela, 'D']), []);

         If Not Result Then
           Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                      VarArrayOf([RightStr(cdsConCar.FieldByName('YAP_CODTRA').AsString,14),
                                                  LParcela, 'D']), []);
     End;
  End;
end;

procedure TConcilYapay.CorrigeDataDePagamentoParaADataDoSaque(var ARegistros: TUniCLientDataset);
Var
  LUltimaData: TDateTime;

  LIndice: String;
begin
  If FUtilizaPortadorTF Then
    Exit;

  LUltimaData := 0;

  LIndice := cdsConcar.IndexFieldNames;

  ARegistros.IndexFieldNames := 'YAP_DTAPAG';
  ARegistros.First;

  FSaques.Filtered := True;
  While Not ARegistros.Eof Do
  Begin
    If LUltimaData = 0 Then
    Begin
      LUltimaData := ARegistros.FieldByName('YAP_DTAPAG').AsDateTime;

      FSaques.Filter := 'YAP_DTAPAG>=' + FormatDateTime('yyyy/mm/dd', LUltimaData).QuotedString;
    End;

    ARegistros.Edit;
    ARegistros.FieldByName('YAP_DTASAQ').AsDateTime := TYapayFuncoes.fAcertaDataParaDiaUtil(FSaques.FieldByName('YAP_DTAPAG').AsDateTime +
                                                                              FDiasDeAjusteDoSaque.ToInteger);
    ARegistros.Post;

    ARegistros.Next;
  End;

  ARegistros.IndexFieldNames := LIndice;
  FSaques.Filtered := False;
end;

function TConcilYapay.CriaDatasetConciliacao: Boolean;
Var
  LSQL: String;
  LConCar: TUniQuery;
begin
  FiltraSaquesYapay;

  LConCar := Nil;
  Try
    LConCar := VS_FuncoesExternas.fICriaQuery;
    LConCar.SQL.Text := 'SHOW TABLES LIKE "' + NOMTAB + '"';
    LConCar.Open;

    Result := Not LConCar.IsEmpty;
    blnReabre := False;

    If Result Then
    Begin
      FCodigoConciliacao := fRetPesqPonVen(0);

      LSQL := '';
      LSQL := LSQL + ' SELECT *, COALESCE(SIS_CODEMP, "") AS CODEMP,   ';
      LSQL := LSQL + ' CAST("0000-00-00" AS DATE) AS YAP_DTASAQ,       ';
      LSQL := LSQL + ' EMP_NOMEMP FROM ' + NOMTAB + '                  ';
      LSQL := LSQL + ' LEFT JOIN CFGSIS ON SIS_VALCFG=YAP_CODEST       ';
      LSQL := LSQL + '                 AND SIS_CODCFG="CFG_YAPESTB"    ';
      LSQL := LSQL + '                 AND SIS_CODEMP="' + VS_FuncoesExternas.fIRetEmpresaLogada + '" ';
      LSQL := LSQL + ' LEFT JOIN CADEMP ON EMP_CODEMP=SIS_CODEMP       ';
      LSQL := LSQL + ' WHERE TRUE     ';

      If TYapayFuncoes.fEmptyStr(FCodigoConciliacao) Then
        LSQL := LSQL + ' AND YAP_DTAPAG BETWEEN :DTAIN AND :DTAFIM     '
      Else
        LSQL := LSQL + FCodigoConciliacao;

      LSQL := LSQL + ' AND YAP_TIPREG NOT IN ("AJUSTE")                ';
      LSQL := LSQL + ' ORDER BY YAP_DTAPAG                             ';

      LConCar.Close;
      LConCar.SQL.Text := LSQL;

      If TYapayFuncoes.fEmptyStr(FCodigoConciliacao) Then
      Begin
        LConCar.ParamByName('DTAIN').AsString  := RetornaParametroDataInicial;
        LConCar.ParamByName('DTAFIM').AsString := RetornaParametroDataFinal;
      End;

      LConCar.Open;

      Result := Not LConCar.IsEmpty;
      blnReabre := Not Result;

      If Result Then
      Begin
        cdsConCar := TYapayFuncoes.CriarClientDataSet(LConCar);
        cdsConCar.Open;
        FListaDePedidos := RetornaListaDePedidos;
        FUtilizaPortadorTF := (FUtilizaPortadorTF Or Not TYapayFuncoes.fEmptyStr(FCodigoConciliacao));
      End;
    End;
  Finally
    TYapayFuncoes.FreeAndNilDatasets(LConCar);
  End;

  If Not Result Then
    TYapayFuncoes.fMensagem('ATENÇÃO','Não existem registros de saque nesse período para a conciliação da YAPAY!',['&OK']);
end;

function TConcilYapay.fBuscaCartaoBaixadoYapay: Boolean;
Var
  LParcela: String;
begin
  LParcela := TYapayFuncoes.fGetLetraAlfa(cdsConCar.FieldByName('YAP_NUMPAR').AsInteger);
  Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                             VarArrayOf([cdsConCar.FieldByName('YAP_CODPED').AsString,
                                         LParcela]), []);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                               VarArrayOf([cdsConCar.FieldByName('YAP_CODTRA').AsString,
                                           LParcela]), []);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                               VarArrayOf([TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_CODPED').AsString, 14),
                                           LParcela]), []);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                               VarArrayOf([TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_CODTRA').AsString, 14),
                                           LParcela]), []);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                               VarArrayOf([RightStr(cdsConCar.FieldByName('YAP_CODPED').AsString,14),
                                           LParcela]), []);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                               VarArrayOf([RightStr(cdsConCar.FieldByName('YAP_CODTRA').AsString,14),
                                           LParcela]), []);

  If Not Result Then
  Begin
     If (cdsConCar.FieldByName('YAP_NUMPAR').AsInteger > 26) Then
     Begin
          LParcela := TYapayFuncoes.fStrZero( cdsConCar.FieldByName('YAP_NUMPAR').AsString, 3);

          Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                                     VarArrayOf([cdsConCar.FieldByName('YAP_CODPED').AsString,
                                                 LParcela]), []);

          If Not Result Then
            Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                                       VarArrayOf([cdsConCar.FieldByName('YAP_CODTRA').AsString,
                                                   LParcela]), []);

          If Not Result Then
            Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                                       VarArrayOf([TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_CODPED').AsString, 14),
                                                   LParcela]), []);

          If Not Result Then
            Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                                       VarArrayOf([TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_CODTRA').AsString, 14),
                                                   LParcela]), []);

          If Not Result Then
            Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                                       VarArrayOf([RightStr(cdsConCar.FieldByName('YAP_CODPED').AsString,14),
                                                   LParcela]), []);

          If Not Result Then
            Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                                       VarArrayOf([RightStr(cdsConCar.FieldByName('YAP_CODTRA').AsString,14),
                                                   LParcela]), []);
     End;
  End;
end;

function TConcilYapay.fProcessaYapayPag(pgbStatus: TcxProgressBar): Boolean;
Var
  LParcela,
  LTipoRegistro,
  LFiltroTransferencias,
  LChaveConciliacao : String;

  LValorLiquido : Double;

  LBuscaCartao: Boolean;

  LRegistroRelatorio: TItensRelatorioCartoes;
begin
  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

  Application.ProcessMessages;

  strCondicao :=  INICAM + 'DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ';


  pFiltraCartoesYapay(pgbStatus);

  CorrigeDataDePagamentoParaADataDoSaque(cdsConCar);

  If FUtilizaPortadorTF Then
  Begin
    If TYapayFuncoes.fEmptyStr(FCodigoConciliacao) Then
    Begin
      LFiltroTransferencias := INICAM + 'DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ' +
                             fRetPesqPonVen(1) + ' AND ' +
                             ' (YAP_TIPREG = "SAQUE") AND (YAP_VALPAG <> 0)';
    End
    Else
    Begin
       LFiltroTransferencias := ' TRUE ' + FCodigoConciliacao +
                                ' AND (YAP_TIPREG = "SAQUE") AND (YAP_VALPAG <> 0)';
    End;

    AdicionaRegistrosDeTransferencias(LFiltroTransferencias,
                                       VS_FuncoesExternas.fIRetEmpresaLogada);
  End;

  FiltraAjustesYapay;

  Try
    pFiltraCartoesBaixadosYapay;

    GeraAjustesDeDiferencaDoTotalContraSaque;
    GravaAjustesDeSaque;

    pgbStatus.Visible := True;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TYapayFuncoes.pStepStatusGravacao(pgbStatus);

      FTextoInconsistencia := '';

      If cdsConCar.FieldByName(INICAM + 'TIPREG').AsString = 'SAQUE' Then
      Begin
        cdsConCar.Next;
        Continue;
      End;

      LValorLiquido := cdsConCar.FieldByName(INICAM + 'VALPAG').Value;

      If ( cdsConCar.FieldByName('YAP_NUMPAR').AsInteger > 26) Then
      Begin
        LParcela := TYapayFuncoes.fStrZero( cdsConCar.FieldByName('YAP_NUMPAR').AsString, 3);
      End
      Else
        LParcela := TYapayFuncoes.fGetLetraAlfa(cdsConCar.FieldByName('YAP_NUMPAR').AsInteger);

      LTipoRegistro := TYapayFuncoes.IIF(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsInteger > 1,
                     'CRÉDITO PARCELADO',
                     'CRÉDITO ROTATIVO');

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LBuscaCartao := fBuscaCartaoYapay;

      If LBuscaCartao Then
      Begin
        FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
        If cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat >= LValorLiquido Then
        Begin
          FTextoInconsistencia := '';

          LChaveConciliacao := 'YAP_' +
                       cdsConCar.FieldByName('YAP_CODTRA').AsString + '_' +
                       cdsConCar.FieldByName('YAP_NUMPAR').AsString + '_' +
                       cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                       FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName(INICAM + 'DTAPAG').AsDateTime);


          MarcarCartaoEncontradoArquivo(LValorLiquido,
                                        False,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar);
        End;
      End
      Else
      Begin
        blnAutomatica := cdsConCar.FieldByName(INICAM + 'CONCIL').Value = '1';

        cdsBaixad.First;
        LBuscaCartao := fBuscaCartaoBaixadoYapay;

        FTextoInconsistencia := 'Cartão já foi baixado';
        If Not LBuscaCartao Then
          FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
      End;

      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('YAP_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('YAP_CODEST').AsString;
      LRegistroRelatorio.CodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;
      LRegistroRelatorio.NumeroNSU :=TYapayFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('YAP_CODPED').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName(INICAM + 'CODPED').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName(INICAM + 'CODTRA').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName(INICAM + 'EXTRAT').Value;

      If LRegistroRelatorio.TipoCartao.IsEmpty Then
        LRegistroRelatorio.TipoCartao := LTipoRegistro;

      LRegistroRelatorio.Parcela := TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TYapayFuncoes.fStrZero(cdsConCar.FieldByName('YAP_NUMPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName(INICAM + 'DTAPAG').Value;
      LRegistroRelatorio.DataVenda :=cdsConCar.FieldByName(INICAM + 'DTAPAG').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('YAP_DTAPAG').AsDateTime;

       LRegistroRelatorio.ValorBruto := LValorLiquido;
       LRegistroRelatorio.ValorLiquido := LValorLiquido;

       LRegistroRelatorio.DescricaoBandeira := cdsConCar.FieldByName(INICAM + 'DESPAG').AsString;
       If TYapayFuncoes.fEmptyStr(LRegistroRelatorio.DescricaoBandeira) Then
         LRegistroRelatorio.DescricaoBandeira := 'OUTROS';

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsConCar.Next;
    End;
  Finally
    TYapayFuncoes.FreeAndNilDatasets(cdsBaixad);
  End;

  Result := True;
end;

procedure TConcilYapay.GeraAjustesDeDiferencaDoTotalContraSaque;
Var
  LSQL,
  LDataAnterior: String;

  LTotalDivergente: Boolean;

  LSaqueAnterior,
  LSomaRegistros: TUniQuery;

  LAjusteSaque: TAjusteSaque;

  LTotalSaques: Double;
begin
  FAjustesSaques := TObjectList<TAjusteSaque>.Create;

  If FUtilizaPortadorTF Then
    Exit;

  If FSaques.IsEmpty Then
    Exit;

  LDataAnterior := '';

  LSaqueAnterior := Nil;
  LSomaRegistros := Nil;
  Try
    FSaques.First;
    While Not FSaques.Eof Do
    Begin
      TYapayFuncoes.FreeAndNilDatasets(LSaqueAnterior);
      TYapayFuncoes.FreeAndNilDatasets(LSomaRegistros);

      LSaqueAnterior := VS_FuncoesExternas.fICriaQuery;
      LSaqueAnterior.SQL.Text := 'SELECT * FROM YAP_YAPGTO WHERE ' +
                                 ' YAP_DTAPAG < ' + FormatDateTime('yyyy-mm-dd', FSaques.FieldByName('YAP_DTAPAG').AsDateTime).QuotedString +
                                 ' AND YAP_TIPREG="SAQUE" AND YAP_VALPAG < 0 ' +
                                 ' ORDER BY YAP_DTAPAG DESC LIMIT 1';
      LSaqueAnterior.Open;

      LSQL := 'SELECT SUM(YAP_VALPAG) AS TOTAL FROM YAP_YAPGTO ' +
              ' WHERE YAP_DTAPAG ';

      If LSaqueAnterior.IsEmpty Then
        LSQL := LSQL + ' <= "' + FormatDateTime('yyyy-mm-dd', FSaques.FieldByName('YAP_DTAPAG').AsDateTime) + '" '
      Else
      Begin
        LSQL := LSQL + ' BETWEEN "' + FormatDateTime('yyyy-mm-dd', IncDay(LSaqueAnterior.FieldByName('YAP_DTAPAG').AsDateTime, 1)) + '" ';
        LSQL := LSQL + '     AND "' + FormatDateTime('yyyy-mm-dd', FSaques.FieldByName('YAP_DTAPAG').AsDateTime) + '" ';
      End;

      LSQL := LSQL + ' AND YAP_TIPREG <> "SAQUE" ';

      LSomaRegistros := VS_FuncoesExternas.fICriaQuery;
      LSomaRegistros.SQL.Text := LSQL;
      LSomaRegistros.Open;

      LTotalSaques  := FSaques.FieldByName('YAP_VALPAG').AsFloat;
      LDataAnterior := FormatdateTime('dd/mm/yyyy', FSaques.FieldByName('YAP_DTAPAG').AsDateTime);

      LTotalDivergente := Not fBetWeen(LSomaRegistros.FieldByName('TOTAL').AsFloat + LTotalSaques,
                                       -1.00, 1.00);
      If LTotalDivergente Then
      Begin
        LAjusteSaque := TAjusteSaque.Create;

        LAjusteSaque.dtaDataSaque   := FSaques.FieldByName('YAP_DTAPAG').AsDateTime;
        LAjusteSaque.fltValorAjuste := TYapayFuncoes.fFormataFloat((LSomaRegistros.FieldByName('TOTAL').AsFloat +
                                                      LTotalSaques) * (-1), 2);
        LAjusteSaque.intConciliado   := 0;

        FAjustesSaques.Add(LAjusteSaque);
      End;

      FSaques.Next;
    End;
  Finally
    TYapayFuncoes.FreeAndNilDatasets(LSaqueAnterior);
    TYapayFuncoes.FreeAndNilDatasets(LSomaRegistros);
  End;
end;

procedure TConcilYapay.GravaAjustesDeSaque;
Var
  LInconsistencia: TItensRelatorioCartoes;

  LEmpresaConfiguracao: String;

  LAjusteSaque: TAjusteSaque;
begin
  If FAjustesSaques.Count <= 0 Then
    Exit;

  For LAjusteSaque in FAjustesSaques Do
  Begin
    LEmpresaConfiguracao := VS_FuncoesExternas.fIRetEmpresaLogada;

    LInconsistencia := TItensRelatorioCartoes.Create;

    LInconsistencia.Descricao := 'Cancelamentos/Ajustes';
    LInconsistencia.nomecliente := 'Ajuste de  saldo do saque';
    LInconsistencia.Parcela := TYapayFuncoes.fStrZero('0', 12);
    LInconsistencia.CodigoAutorizacao := '00000000000000';
    LInconsistencia.NumeroNSU := '00000000000000';
    LInconsistencia.CodigoEstabelecimento := '0';
    LInconsistencia.NumeroCartao := '00000000000000';
    LInconsistencia.TipoCartao := 'CANCELAMENTOS/AJUSTES';
    LInconsistencia.DataVenda :=TYapayFuncoes.fAcertaDataParaDiaUtil(LAjusteSaque.dtaDataSaque +
                                                                     FDiasDeAjusteDoSaque.ToInteger);

    LInconsistencia.Parcela := '01';

    LInconsistencia.NumeroNegociacao := FormatDateTime('yymmdd', LAjusteSaque.dtaDataSaque);

    LInconsistencia.ValorBruto := LAjusteSaque.fltValorAjuste;
    LInconsistencia.ValorLiquido :=  LAjusteSaque.fltValorAjuste;

    LInconsistencia.DataPagamento := TYapayFuncoes.fAcertaDataParaDiaUtil(LAjusteSaque.dtaDataSaque +
                                                                          FDiasDeAjusteDoSaque.ToInteger);

    LInconsistencia.Descricao := LEmpresaConfiguracao + TYapayFuncoes.IIF(TYapayFuncoes.fEmptyStr(LEmpresaConfiguracao), '', '-' + TYapayFuncoes.RetornaNomeEmpresa(LEmpresaConfiguracao));
    LInconsistencia.PortadorCredito := VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, LEmpresaConfiguracao);
    LInconsistencia.PlanoContasTransferenciaCredito := VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, LEmpresaConfiguracao);
    LInconsistencia.PlanoContasTaxaNegociacao := VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, LEmpresaConfiguracao);

    LInconsistencia.DescricaoAjuste  := VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString, LEmpresaConfiguracao);

    LInconsistencia.Conciliado := LAjusteSaque.intConciliado;

    VerificaSituacaoDoCadastro(LInconsistencia, LEmpresaConfiguracao);

    If FBaixarAjustes Then
    Begin
      LInconsistencia.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(VS_FuncoesExternas.fIRetEmpresaLogada);

      GravarRegistroDeAjusteParaConciliacao(LInconsistencia);
    End;

    FListaRegistrosRelatorio.Add(LInconsistencia);
  End;
end;

procedure TConcilYapay.pFiltraCartoesBaixadosYapay;
Var
  LSQL: String;

  LBaixad: TUniQuery;
begin
  LSQL := '';
  LSQL := LSQL + ' SELECT MCA_NUMCCD, MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU,      ';
  LSQL := LSQL + ' MCA_NUMDUP, MCA_DTACUP, MCA_NUMPOK,                         ';
  LSQL := LSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON, MCA_VALSTA, ';
  LSQL := LSQL+ '  CAST(" " AS CHAR(50)) AS MARKETPLACE                        ';
  LSQL := LSQL + ' FROM MOVCAR                                                 ';
  LSQL := LSQL + ' WHERE (MCA_NUMNSU IN (' + FListaDePedidos + ') OR MCA_NUMCCD IN (' + FListaDePedidos + ')) ';
  LSQL := LSQL + ' AND MCA_DTAREC IS NOT NULL                                  ';
  LSQL := LSQL + ' ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP                  ';

  LBaixad := Nil;
  Try
    LBaixad := VS_FuncoesExternas.fICriaQuery;
    LBaixad.SQL.Text := LSQL;
    LBaixad.Open;

    TYapayFuncoes.FreeAndNilDatasets(cdsBaixad);
    cdsBaixad := TYapayFuncoes.CriarClientDataSet(LBaixad);
  Finally
    TYapayFuncoes.FreeAndNilDatasets(LBaixad);
  End;

  cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
  cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;EMPLOC;MCA_DTACUP;PARDUP';
end;

function TConcilYapay.pFiltraCartoesYapay(pgbStatus: TcxProgressBar): Boolean;
Var
  LSQL: String;

  qryBaiCar: TUniQuery;
begin
  LSQL := TLibCartoesMovcar.fGetSQLCartoes(objConcil);

  LSQL := LSQL + ' AND (MCA_NUMNSU IN (' + FListaDePedidos + ') OR MCA_NUMCCD IN (' + FListaDePedidos + ')) ';
  LSQL := LSQL + ' ORDER BY MCA_DTAVEN, MCA_NUMDUP, MCA_CODEMP, MCA_NUMCCD, MCA_NUMNSU, MCA_PARCEL) AS TMP ';

  qryBaiCar := Nil;
  Try
    qryBaiCar := VS_FuncoesExternas.fICriaQuery;
    qryBaiCar.SQL.Text := LSQL;
    qryBaiCar.Options.SetFieldsReadOnly := False;
    qryBaiCar.Open;

    TYapayFuncoes.FreeAndNilDatasets(cdsBaiCar);
    cdsBaiCar := TYapayFuncoes.CriarClientDataSet(qryBaiCar);
    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
  Finally
    TYapayFuncoes.FreeAndNilDatasets(qryBaiCar);
  End;

  result := true;
end;

function TConcilYapay.RetornaListaDePedidos: String;
begin
  cdsConCar.First;
  While Not cdsConCar.Eof Do
  Begin
    Result := Result + '"' + cdsConCar.FieldByName('YAP_CODPED').AsString + '",';
    Result := Result + '"' + cdsConCar.FieldByName('YAP_CODTRA').AsString + '",';
    cdsConCar.Next;
  End;
  cdsConCar.First;
  Result := LeftStr(Result, Result.Length - 1)
end;

function TConcilYapay.RetornaParametroDataFinal: String;
begin
  Result := FormatDateTime('yyyy/MM/dd', dtaDtaFim);
  If Not FUltimoSaque.IsEmpty Then
    Result  := FormatDateTime('yyyy/MM/dd', FUltimoSaque.FieldByName('YAP_DTAPAG').AsDateTime);
end;

function TConcilYapay.RetornaParametroDataInicial: String;
begin
  Result  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
  If Not FSaqueAnterior.IsEmpty Then
    Result := FormatDateTime('yyyy/MM/dd', IncDay(FSaqueAnterior.FieldByName('YAP_DTAPAG').AsDateTime, 1));
end;

procedure TConcilYapay.VerificaSituacaoDoCadastro(
  var AInconsistencia: TItensRelatorioCartoes; AEmpresaConfiguracao: String);
begin
  If (VS_FuncoesExternas.fICfgSis('BAIDEB') <> 'S') Then
    Exit;

  AInconsistencia.SituacaoCadastro :=  'COMPLETO';
  If TYapayFuncoes.fEmptyStr(AEmpresaConfiguracao) Then
    AInconsistencia.SituacaoCadastro :=  'INCOMPLETO';

  If Not ValidaConfiguracoesAjustes(AEmpresaConfiguracao) Then
   AInconsistencia.SituacaoCadastro := 'INCOMPLETO';
end;

function TConcilYapay.ValidaConfiguracoesAjustes(ACodigoEmpresa: String): Boolean;
Begin
  Result := True;

  If TYapayFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, ACodigoEmpresa)) Then
    Exit(False);

  If TYapayFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodigoEmpresa)) Then
    Exit(False);

  If TYapayFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, ACodigoEmpresa)) Then
    Exit(False);

  If VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean) Then
  Begin
    If TYapayFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString, ACodigoEmpresa)) Then
      Exit;
  End;
End;

end.


