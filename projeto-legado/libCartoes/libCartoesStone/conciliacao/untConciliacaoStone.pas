unit untConciliacaoStone;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untTStoneFuncoes, untStoneConciliacaoCartoes,
     untLibCartoesInterfacesTipos;

type TConcilStone = class(TConciliacaoCartoes)
  private
    FTolerancia: Double;
    FCondicaoTransferencias: String;

    FListaRegistrosConciliar: TStringList;

    function RegistroPossuiAMesmaAutorizacao(ANumNSU,
                                             AParcela,
                                             AEmpresa,
                                             ADataCupom: String): Boolean;

    function RetornaTipoCartao: String;

    procedure ValidaAjustesDeCancelamento;

    procedure CorrigePortadorAjustesLink;

    procedure GeraRegistrosDeAjustesDeTransferencia;
    function TransferenciasConciliadas(AEstabelecimento: String;
                                       ADataPagamento: TDateTime): Integer;

    function fProcessaStonePag(pgbStatus: TcxProgressBar): Boolean;

    function fConciliaStone(pgbStatus: TcxProgressBar): Boolean;
  public
    constructor Create; overload;
    destructor Destroy; override;

    function fConciliaCartoes: Boolean; override;

    property ListaRegistrosConciliar: TStringList read FListaRegistrosConciliar;

  protected

  end;

Const
  INICAM = 'STO_';
  NOMTAB = 'STO_STPGTO';

implementation
Uses untStoneDigPeriodo;

procedure TConcilStone.CorrigePortadorAjustesLink;
Var
  LConfigs: TUniQuery;

  LFiltroAnterior: String;
begin
  LConfigs := Nil;
  Try
    LConfigs := VS_FuncoesExternas.fICriaQuery;

    LFiltroAnterior := cdsBaiCar.Filter;
    cdsBaiCar.Filter := 'MCA_AJUSTE=''S'' AND MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    cdsBaiCar.Filtered := True;

    If cdsBaiCar.IsEmpty Then
      Exit;

    LConfigs.SQL.Text := 'SELECT C.SIS_VALCFG AS PORTADOR, ' +
                         '       C.SIS_CODEMP AS EMPRESA, ' +
                         '       B.SIS_VALCFG AS ESTABELECIMENTO ' +
                         'FROM CFGSIS C ' +
                         'LEFT JOIN CFGSIS B ON B.SIS_CODEMP=C.SIS_CODEMP ' +
                         '                  AND B.SIS_CODCFG="CFG_STOLNK" ' +
                         'WHERE C.SIS_CODCFG="CFG_STOPLK" ' +
                         '  AND C.SIS_VALCFG IS NOT NULL ' +
                         '  AND C.SIS_VALCFG <> "" ' +
                         '  AND IFNULL(TRIM(B.SIS_VALCFG), "") <> "" ';

    LConfigs.Open;

    If LConfigs.IsEmpty Then
      Exit;

    While Not cdsBaiCar.Eof Do
    Begin
      If LConfigs.Locate('ESTABELECIMENTO', cdsBaiCar.FieldByName('MCA_ESTABE').AsString, []) Then
      Begin
        cdsBaiCar.Edit;
        cdsBaiCar.FieldByName('CAR_PORBAI').AsString := LConfigs.FieldByName('PORTADOR').AsString;
        cdsBaiCar.Post;
      End;

      cdsBaiCar.Next;
    End;
  Finally
    cdsBaiCar.Filter := LFiltroAnterior;
    cdsBaiCar.Filtered := Not LFiltroAnterior.IsEmpty;

    TStoneFuncoes.FreeAndNilDatasets(LConfigs);
  End;
end;

constructor TConcilStone.Create;
begin
  FListaRegistrosConciliar := Nil;
  inherited;
end;

destructor TConcilStone.Destroy;
begin
  If Assigned(FListaRegistrosConciliar) Then
    FreeAndNil(FListaRegistrosConciliar);
  inherited;
end;

function TConcilStone.fConciliaCartoes: Boolean;
begin
  Result := TStoneFuncoes.ExecutaAguarde(fConciliaStone, 'Aguarde... Iniciando a conciliação.');
end;

function TConcilStone.fConciliaStone(pgbStatus: TcxProgressBar): Boolean;
Begin

  Result       := False;
  FPossuiInconsistencia := False;

  TForm(pgbStatus.Owner).Visible := False;
  Try
    Try
      objConcil.TabelaConciliacao := 'STO_STPGTO';
      objConcil.CampoEstabelecimento := 'STO_CODEST';
      objConcil.NomeConciliacao := 'STONE';
      objConcil.CfgEstabelecimentos := 'CFG_STOEST';
      objConcil.CampoValorBruto := 'STO_VALDEB';
      objConcil.CampoValorLiquido := 'STO_VALCAN';
      objConcil.CampoCodigoAutorizacao := 'STO_NUMCAN';
      objConcil.CampoNumeroNSU := 'STO_NUMNSU';
      objConcil.CampoDataTransacaoVenda := 'STO_DTAAUT';
      objConcil.CampoNumeroParcela := 'STO_NUMPAR';
      objConcil.CampoTotalParcelas := 'STO_NUMPAR';
      objConcil.CampoNumeroCartao := 'STO_NUMCAN';
      objConcil.CampoDataRecebimento := 'STO_DTAPAG';
      objConcil.CampoTipoRegistro := 'STO_NUMCAN';
      objConcil.CfgPlanoDeContasAjustes := 'STOCTA';
      objConcil.CfgFornecedorAjustes := 'STOFOR';
      objConcil.strEventoCancelamentoAjuste := 'STOEVE';
      objConcil.CfgPortadorAjustes := 'STOPOR';

      objConcil.strChavePrimaria := 'STO_CODEST,STO_NUMNSU,STO_DTAVEN,STO_NUMPAR,STO_DTAPAG,STO_NUMCAN';

      If Not fDigPeriodo Then
        Exit;

      FListaRegistrosConciliar := TStringList.Create;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'STONE API',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TStoneFuncoes.RetornaDataHoraServidor,
                                                            TStoneFuncoes.RetornaHoraServidor);

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := True;
      TStoneFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (STONE).', False);
      If Not fProcessaStonePag(pgbStatus) Then
        Exit;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      FPossuiInconsistencia := False;

      TStoneFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(pgbStatus);

      TForm(pgbStatus.Owner).Visible := False;

      If FPossuiInconsistencia Then
        TStoneFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

      If FListaRegistrosRelatorio.Count > 0 Then
        Result := GeraRelatorioConciliacao('Stone', pgbStatus);

      If Assigned(cdsAjustes) Then
      Begin
        cdsAjustes.Filter   := 'STO_CONCIL=0';
        cdsAjustes.Filtered := True;
      End;

      blnReabre := Not Result;
      If Result Then
      Begin
        cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        cdsBaiCar.Filtered := True;

        Result := Not cdsBaiCar.IsEmpty;
        If Not Result Then
          TStoneFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
        Else
          TStoneFuncoes.fMensagem('AVISO','Conciliação da Stone realizada com sucesso.',['&OK']);
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConciliaStone]');
      End;
    End;
  Finally
    TStoneFuncoes.FreeAndNilDatasets(cdsConCar);
    TStoneFuncoes.FreeAndNilDatasets(cdsAjustes);
  End;
End;

function TConcilStone.fProcessaStonePag(pgbStatus: TcxProgressBar): Boolean;
Var
  LRegistroRelatorio: TItensRelatorioCartoes;

  intRecNo      : Integer;

  LValorBruto,
  LValorLiquido,
  LTolerancia,
  LDiferenca: Double;

  blnBusca      : Boolean;

  LParcela,
  LTipoCartao,
  LChaveConciliacao,
  strSQL: String;

  qryConCar: TUniQuery;
begin
  Result := False;
  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

  qryConCar := Nil;
  Try
    Try
      qryConCar := VS_FuncoesExternas.fICriaQuery;

      Application.ProcessMessages;

      strSQL := '';
      strSQL := strSQL + ' SELECT A.*, COALESCE(SIS_CODEMP, "") AS CODEMP,   ';
      strSQL := strSQL + '   EMP_NOMEMP, COALESCE(B.STO_TIPCAR, "") AS       ';
      strSQL := strSQL + '   STO_TIPCAR, COALESCE(B.STO_NUMCAR, "") AS       ';
      strSQL := strSQL + '   STO_NUMCAR, COALESCE(B.STO_TOTPAR, "") AS       ';
      strSQL := strSQL + '   STO_TOTPAR, COALESCE(B.STO_CODAUT, "") AS       ';
      strSQL := strSQL + '   STO_CODAUT, "N" AS CONCILIADO                   ';
      strSQL := strSQL + ' FROM STO_STPGTO A                                 ';
      strSQL := strSQL + ' LEFT JOIN STO_STCRED B ON                         ';
      strSQL := strSQL + '   B.STO_CODEST=A.STO_CODEST AND                   ';
      strSQL := strSQL + '   B.STO_NUMNSU=A.STO_NUMNSU AND                   ';
      strSQL := strSQL + '   B.STO_DTAAUT=A.STO_DTAAUT AND                   ';
      strSQL := strSQL + '   B.STO_NUMPAR=A.STO_NUMPAR                       ';
      strSQL := strSQL + ' LEFT JOIN CFGSIS ON SIS_VALCFG=A.STO_CODEST       ';
      strSQL := strSQL + '     AND SIS_CODCFG IN ("CFG_STOEST", "CFG_STOLNK")';
      strSQL := strSQL + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP         ';
      strSQL := strSQL + ' WHERE A.STO_DTAPAG BETWEEN :DTAIN AND :DTAFIM     ';
      strSQL := strSQL + '   AND ((A.STO_NUMCAN = "") OR (A.STO_NUMCAN NOT IN ("", "TRANSFERENCIA") AND A.STO_VALLIQ <> 0) ) ';
      strSQL := strSQL + StringReplace(fRetPesqPonVen(0), objConcil.CampoEstabelecimento,
                                       'A.' +  objConcil.CampoEstabelecimento, [rfReplaceAll]);
      strSQL := strSQL + ' ORDER BY A.STO_DTAPAG                             ';

      qryConCar.SQL.Text := 'SHOW TABLES LIKE "STO_STPGTO"';
      qryConCar.Open;
      If qryConCar.IsEmpty Then
      Begin
        TStoneFuncoes.fMensagem('','Não existem arquivos importados para a conciliação da STONE nesse período!',['&OK']);
        blnReabre := True;
        Exit;
      End;

      qryConCar.Close;
      qryConCar.SQL.Text := strSQL;
      qryConCar.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
      qryConCar.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', dtaDtaFim);
      qryConCar.Open;

      cdsConCar := TStoneFuncoes.CriarClientDataSet(qryConCar);
      cdsConCar.Open;
    Finally
      TStoneFuncoes.FreeAndNilDatasets(qryConCar);
    End;

    strCondicao :=  'STO_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ';

    FCondicaoTransferencias := strCondicao + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);

    pCalculaPeriodoFiltro('STO_DTAAUT');

    TStoneFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
    pFiltraCartoes;

    pFiltraCartoesBaixados;

    strCondicao := strCondicao + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
    strCondicao := strCondicao + ' AND A.STO_NUMCAN NOT IN ("", "TRANSFERENCIA") ';
    FiltrarCancelamentosPeriodo(strCondicao,
                                '"CANCELAMENTO/AJUSTE"',
                                '');

    If (cdsConCar.IsEmpty) And
       ((Not Assigned(cdsAjustes)) Or (cdsAjustes.IsEmpty)) Then
    Begin
      TStoneFuncoes.fMensagem('','Não existem arquivos importados nesse período de recebimento!',['&OK']);
      Result := False;
      blnReabre := True;
      Exit;
    End;

    CorrigePortadorAjustesLink;

    pgbStatus.Visible := True;
    TStoneFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (STONE).', False);
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TStoneFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

      LTipoCartao := RetornaTipoCartao;

      LParcela := TStoneFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('STO_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('STO_NUMPAR').AsString)));

      LValorBruto  := cdsConCar.FieldByName('STO_VALBRU').Value;
      LValorLiquido := cdsConCar.FieldByName('STO_VALLIQ').Value;

      blnBusca := fBuscaCartao(cdsConCar.FieldByName('STO_CODAUT').AsString,
                               TStoneFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('STO_NUMNSU').Value, 14)), 14),
                               cdsConCar.FieldByName('CODEMP').AsString,
                               LParcela,
                               cdsConCar.FieldByName('STO_DTAAUT').Value);

      If blnBusca Then
      Begin
        LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
        If  (LDiferenca <= LTolerancia) And (LDiferenca >= -LTolerancia) Then
        Begin
          LChaveConciliacao := 'STO_' +
                      cdsConCar.FieldByName('STO_NUMNSU').Value + '_' + LParcela+ '_' +
                      cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                      FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('STO_DTAAUT').Value);

          MarcarCartaoEncontradoArquivo(LValorLiquido,
                                        cdsConCar.FieldByName('STO_VALANT').Value > 0,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar);
        End
        Else
        Begin
          //Verificando outras liberações com a mesma data
          intRecNo := cdsBaiCar.RecNo;
          cdsBaiCar.Next;


          While RegistroPossuiAMesmaAutorizacao( cdsConCar.FieldByName('STO_NUMNSU').Value,
                                                LParcela,
                                                cdsConCar.FieldByName('CODEMP').AsString,
                                                cdsConCar.FieldByName('STO_DTAAUT').AsString) Do
          Begin
            LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;


            dtaDtaPag := cdsConCar.FieldByName('STO_DTAPAG').Value;

            If (LDiferenca <= LTolerancia) And (LDiferenca >= -LTolerancia) Then
            Begin
              LChaveConciliacao := 'STO_' +
                    cdsConCar.FieldByName('STO_NUMNSU').Value + '_' + LParcela + '_' +
                    cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                    FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('STO_DTAAUT').Value);

              MarcarCartaoEncontradoArquivo(LValorLiquido,
                                    cdsConCar.FieldByName('STO_VALANT').Value > 0,
                                    LRegistroRelatorio,
                                    LChaveConciliacao,
                                    cdsConCar);

              Break;
            End;

            cdsBaiCar.Next;

            If cdsBaiCar.Eof Then
            Break;
          End;
          FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
          If Not fBetween(LDiferenca , -FTolerancia, FTolerancia) Then
          Begin
            cdsBaiCar.RecNo := intRecNo;
            FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
          End;
        End;
      End
      Else
      Begin
        //verifica se está cadastrado ou já foi baixado no período
        blnAutomatica := cdsConCar.FieldByName('STO_CONCIL').Value = '1';

        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixado(cdsConCar.FieldByName('STO_CODAUT').Value,
                                        TStoneFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('STO_NUMNSU').Value, 14)), 14),
                                        cdsConCar.FieldByName('CODEMP').AsString,
                                        LParcela,
                                        cdsConCar.FieldByName('STO_DTAAUT').Value);

        FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';

        If blnBusca Then
        Begin
          FTextoInconsistencia := 'Cartão já foi baixado';

          cdsConCar.Edit;
          cdsConCar.FieldByName('CONCILIADO').AsString := 'S';
          cdsConCar.Post;
        End;
      End;

      if TStoneFuncoes.fEmptyStr(FTextoInconsistencia) Then
      Begin
        If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
          FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
      End;

      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        LRegistroRelatorio.SomarNoTotal := 'N';

        If Not LRegistroRelatorio.Descricao.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
        Begin
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
          LRegistroRelatorio.SomarNoTotal := 'S';
        End;
      End;

      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName(INICAM + 'CODEST').Value;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName(INICAM + 'NUMNSU').Value;
      LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName(INICAM + 'CODAUT').Value;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName(INICAM + 'INIKEY').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName(INICAM + 'NUMCAR').Value;
      LRegistroRelatorio.Parcela := TStoneFuncoes.IIF(cdsConCar.FieldByName('STO_NUMPAR').AsInteger = 0, '01', TStoneFuncoes.fStrZero(cdsConCar.FieldByName('STO_NUMPAR').AsString, 2));
      LRegistroRelatorio.TotalParcelas := TStoneFuncoes.IIF(cdsConCar.FieldByName('STO_TOTPAR').asstring = '', '', TStoneFuncoes.fStrZero(cdsConCar.FieldByName('STO_TOTPAR').AsString, 2));
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName(INICAM + 'DTAPAG').Value;
      LRegistroRelatorio.DataVenda :=cdsConCar.FieldByName(INICAM + 'DTAAUT').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName(INICAM + 'DTAPAG').Value;
      LRegistroRelatorio.ValorBruto := LValorBruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;
      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(cdsConCar.FieldByName(INICAM + 'NUMCAR').Value);
      LRegistroRelatorio.TipoCartao := LTipoCartao;

      If TStoneFuncoes.fEmptyStr(LRegistroRelatorio.DescricaoBandeira) Then
           LRegistroRelatorio.DescricaoBandeira := 'OUTROS';

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsConCar.Next;
    end;

    ValidaAjustesDeCancelamento;

    GeraRegistrosDeAjustesDeTransferencia;
  Finally
    TStoneFuncoes.FreeAndNilDatasets(cdsBaixad);
  End;

  Result := True;
end;

procedure TConcilStone.GeraRegistrosDeAjustesDeTransferencia;
Var
  LConsulta: TUniQuery;

  LRegistroRelatorio: TItensRelatorioCartoes;

  LSql,
  LPortadorBaixa: String;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LSql := 'SELECT STO_CODEST, STO_DTAPAG, SIS_CODEMP, ' +
            ' SUM(IF(STO_NUMCAN="TRANSFERENCIA", STO_VALLIQ, 0)) - ' +
            ' SUM(IF(STO_NUMCAN="", STO_VALLIQ, 0)) - ' +
            ' SUM(IF(STO_NUMCAN<>"TRANSFERENCIA", -STO_VALCAN, 0)) AS DIFERENCA ' +
            'FROM STO_STPGTO ' +
            'LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_STOEST", "CFG_STOLNK") AND' +
            '                    SIS_VALCFG=STO_CODEST ' +
            'WHERE ' + FCondicaoTransferencias + ' ' +
            'GROUP BY STO_CODEST, STO_DTAPAG, SIS_CODEMP ' +
            'ORDER BY STO_CODEST, STO_DTAPAG, SIS_CODEMP ';

    LSql := StringReplace(LSql, 'A.','', [rfReplaceAll]);
    LConsulta.SQL.Text := LSql;
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      If Not fBetween(TSToneFuncoes.fFormataFloat(LConsulta.FieldByName('DIFERENCA').AsFloat, 2), -0.05, 0.05) Then
      Begin
        LRegistroRelatorio := TItensRelatorioCartoes.Create;

        FTextoInconsistencia := 'Cancelamentos/Ajustes';

        LRegistroRelatorio.ValorBruto := LConsulta.FieldByName('DIFERENCA').AsFloat;
        LRegistroRelatorio.ValorLiquido :=  LConsulta.FieldByName('DIFERENCA').AsFloat;

        LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
        LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
        LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

        LRegistroRelatorio.DescricaoAjuste := 'AJUSTE DE CRÉDITO';
        If TStoneFuncoes.fFormataFloat(LConsulta.FieldByName('DIFERENCA').AsFloat, 2) < 0 Then
          LRegistroRelatorio.DescricaoAjuste := 'AJUSTE DE DÉBITO';

        LRegistroRelatorio.CodigoEmpresa := LConsulta.FieldByName('SIS_CODEMP').AsString;
        LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName('STO_CODEST').AsString;

        LRegistroRelatorio.NumeroNSU := '00000000000000';

        LRegistroRelatorio.Parcela := '01';
        LRegistroRelatorio.TotalParcelas := '01';
        LRegistroRelatorio.CodigoAutorizacao := '00000000000000';

        LRegistroRelatorio.DataVenda := LConsulta.FieldByName('STO_DTAPAG').AsDateTime;
        LRegistroRelatorio.DataPagamento := LConsulta.FieldByName('STO_DTAPAG').AsDateTime;
        LRegistroRelatorio.DataVencimento := LConsulta.FieldByName('STO_DTAPAG').AsDateTime;

         LPortadorBaixa := EmptyStr;
         If VS_FuncoesExternas.fICfgSis('STOLNK', varString, LConsulta.FieldByName('SIS_CODEMP').AsString) = LRegistroRelatorio.CodigoEstabelecimento Then
           LPortadorBaixa := VS_FuncoesExternas.fICfgSis('STOPLK', varString, LConsulta.FieldByName('SIS_CODEMP').AsString);

         If LPortadorBaixa.IsEmpty Then
           LPortadorBaixa := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorAjustes, LConsulta.FieldByName('SIS_CODEMP').AsString);

         LRegistroRelatorio.PortadorTransferencia := LPortadorBaixa;
         LRegistroRelatorio.PlanoContasTransferenciaDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasAjustes, LConsulta.FieldByName('SIS_CODEMP').AsString);
         LRegistroRelatorio.CentroCustosTransferencia:= fRetornaDadosDeBaixaDosAjustes(objConcil.CfgFornecedorAjustes, LConsulta.FieldByName('SIS_CODEMP').AsString);

         LRegistroRelatorio.Conciliado := TransferenciasConciliadas(LConsulta.FieldByName('STO_CODEST').AsString,
                                                               LConsulta.FieldByName('STO_DTAPAG').AsDateTime);

        If LRegistroRelatorio.TipoCartao.Equals('CANCELAMENTOS/AJUSTES') Then
            GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);
      End;

      LConsulta.Next;
    End;
  Finally
    TStoneFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilStone.RegistroPossuiAMesmaAutorizacao(ANumNSU, AParcela,
  AEmpresa, ADataCupom: String): Boolean;
begin
  Result := cdsBaiCar.FieldByName('MCA_NUMNSU').AsString = ANumNSU;

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('PARDUP').AsString = AParcela;

  If Not Result Then
    Exit;

  If Not cdsConCar.FieldByName('CODEMP').AsString.IsEmpty Then
  Begin
    Result := cdsBaiCar.FieldByName('MCA_EMPRCX').AsString = AEmpresa;

    If Not Result Then
      Exit;
  End;

  Result := cdsBaiCar.FieldByName('MCA_DTACUP').AsString = ADataCupom;

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'D';
end;

function TConcilStone.RetornaTipoCartao: String;
begin
  If cdsConCar.FieldByName('STO_VALANT').Value > 0 Then
    Exit('ANTECIPAÇÃO');

  If cdsConCar.FieldByName('STO_TIPCAR').AsString.Equals('D') Then
    Exit('DÉBITO');

  Result := 'CRÉDITO ROTATIVO';
  If Not cdsConcar.FieldByName('STO_TOTPAR').AsString.IsEmpty Then
  Begin
    If cdsConCar.FieldByName('STO_TOTPAR').AsInteger > 1 Then
      Result := 'CRÉDITO PARCELADO';
  End;
end;

function TConcilStone.TransferenciasConciliadas(AEstabelecimento: String;
  ADataPagamento: TDateTime): Integer;
Var
  LConsulta: TUniQuery;
begin
  Result := 0;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT *  ' +
                          'FROM STO_STPGTO ' +
                          'WHERE STO_CODEST="' + AEstabelecimento + '" AND ' +
                          '      STO_DTAPAG="' + FormatDateTime('yyyy/mm/dd', ADataPagamento) + '" AND ' +
                          '      STO_NUMCAN="TRANSFERENCIA" AND STO_CONCIL=0';

    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Result := 1;

    While Not LConsulta.Eof Do
    Begin
      FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(LConsulta));

      LConsulta.Next;
    End;
  Finally
    TStoneFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TConcilStone.ValidaAjustesDeCancelamento;
Var
  LRegistroExiste: Boolean;
  LParcelaBusca: String;
  LRegistroRelatorio: TItensRelatorioCartoes;
  i: Integer;
begin
  If Not Assigned(cdsAjustes) Then
    Exit;

  If cdsAjustes.IsEmpty Then
    Exit;

  cdsAjustes.First;
  While Not cdsAjustes.Eof Do
  Begin
    LRegistroExiste := False;

    // Criar busca manual na lista FListaRegistrosRelatorio
    for i := 0 to FListaRegistrosRelatorio.Count - 1 do
    begin
      LRegistroRelatorio := FListaRegistrosRelatorio[i];

      LParcelaBusca := TStoneFuncoes.IIF(cdsConCar.FieldByName('STO_NUMPAR').AsInteger = 0, '01', TStoneFuncoes.fStrZero(cdsConCar.FieldByName('STO_NUMPAR').AsString, 2));
      If (Not cdsConCar.FieldByName('STO_TOTPAR').AsString.IsEmpty) Then
        LParcelaBusca := LParcelaBusca + '/' + TStoneFuncoes.fStrZero(cdsConCar.FieldByName('STO_TOTPAR').AsString, 2);

      if (LRegistroRelatorio.NumeroNSU = cdsConCar.FieldByName('STO_NUMNSU').AsString) and
         (LRegistroRelatorio.NumeroCartao = cdsConCar.FieldByName('STO_NUMCAR').AsString) and
         (LRegistroRelatorio.Parcela = LParcelaBusca) then
      begin
        LRegistroExiste := True;
        Break;
      end;
    end;

    If LRegistroExiste Then
    Begin
      FListaRegistrosRelatorio.Delete(i);

      If cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTAREC;MCA_AJUSTE',
                         VarArrayOf([TStoneFuncoes.fStrZero(cdsAjustes.FieldByName('STO_NUMNSU').AsString, 14),
                                     TStoneFuncoes.fGetLetraAlfa(TStoneFuncoes.IIF(cdsAjustes.FieldByName('STO_NUMPAR').AsInteger = 0, '01', cdsAjustes.FieldByName('STO_NUMPAR').AsString)),
                                     cdsAjustes.FieldByName('STO_DTAPAG').AsDateTime,
                                     'S']), []) Then
        cdsBaiCar.Delete;

      cdsAjustes.Delete;

      Continue;
    End
    Else
      FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsAjustes));

    cdsAjustes.Next;
  End;
end;


end.

