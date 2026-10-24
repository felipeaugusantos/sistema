{****************************************}
{* Nova forma de Conciliação de Cartões *}
{* EQUALS                               *}
{*************************************AJ*}
unit untConciliacaoEquals;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math, System.Generics.Collections, System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar, DIALOGS,

     untEqualsConciliacaoCartoes, untLibCartoesInterfacesTipos, untTEqualsFuncoes,
     untEqualsTipos;

type TConcilEquals = class(TConciliacaoCartoes)
  private
    qryEstEqu: TUniQuery;

    procedure pCarregaEstab;
    procedure DestroiComponentes;

    function RetornaTipoDoCartao: String;

    function RetornaSQLConciliacaoEquals: String;
    function RegistroPossuiAMesmaAutorizacao(AAutorizacao,
                                             AParcela,
                                             AEmpresa,
                                             ADataCupom: String): Boolean;

    function fProcessaEquPag(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaEquals(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;

  protected

  end;

implementation

Const
  INICAM = 'EQU_';
  NOMTAB = 'EQU_EQPGTO';


procedure TConcilEquals.DestroiComponentes;
begin
  TEqualsFuncoes.FreeAndNilDatasets(cdsConCar);
  TEqualsFuncoes.FreeAndNilDatasets(cdsAjustes);
  TEqualsFuncoes.FreeAndNilDatasets(qryEstEqu);
end;

function TConcilEquals.fConciliaCartoes: Boolean;
begin
  Result := TEqualsFuncoes.ExecutaAguarde(fConciliaEquals, 'Aguarde... Iniciando a conciliação.');
end;

function TConcilEquals.fConciliaEquals(pgbStatus: TcxProgressBar): Boolean;
Begin
  Result := False;
  TForm(pgbStatus.Owner).Visible := False;

  Try
    Try
      FPossuiInconsistencia := False;

      //Para conciliação por Ponto de Venda
      objConcil.TabelaConciliacao      := 'EQU_EQPGTO';
      objConcil.CampoEstabelecimento   := 'EQU_CODEST';
      objConcil.NomeConciliacao        := 'EQUALS';
      objConcil.CfgEstabelecimentos    := 'CFG_EQUEST';
      objConcil.CampoCodigoAutorizacao := 'EQU_CODAUT';
      objConcil.CampoNumeroNSU         := 'EQU_NUMNSU';
      objConcil.CampoValorBruto        := 'EQU_VALBRU';
      objConcil.CampoValorLiquido      := 'EQU_VALLIQ';

      objConcil.strChavePrimaria := 'EQU_CODEST, EQU_CODAUT, EQU_NUMNSU, EQU_CODPAR, EQU_DTAPAG, EQU_DTAVEN';

      {**************************************}
      {* PEGANDO O PERÍODO PARA CONCILIAÇÃO *}
      {***********************************AJ*}
      If Not fDigPeriodo Then
        Exit;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'EQUALS',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TEqualsFuncoes.RetornaDataHoraServidor,
                                                            TEqualsFuncoes.RetornaHoraServidor);

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := False;

      TEqualsFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (' + objConcil.NomeConciliacao + ').', False);
      If Not fProcessaEquPag(pgbStatus) Then
        Exit;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.pConciliaEquals]');
        Exit;
      End;
    End;

    if Assigned(cdsBaiCar) then
    begin
      cdsBaiCar.Filtered := False;
      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;
    end;

    FPossuiInconsistencia := False;

    TEqualsFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
    GravarRegistrosRelatorio(pgbStatus);

    if FPossuiInconsistencia then
      TEqualsFuncoes.fMensagem('', 'Foram encontradas inconsistências na conciliação dos arquivos!', ['&OK']);

    If (Assigned(cdsConCar)) And (cdsConCar.Active) And (Not cdsConCar.IsEmpty) Then
    Begin
       GeraRelatorioConciliacao('EQUALS', pgbStatus);

       Result := Assigned(cdsBaiCar) and (not cdsBaiCar.IsEmpty);
       if not Result then
         TEqualsFuncoes.fMensagem('ATENÇÃO', 'Nenhum pagamento foi conciliado no período selecionado!', ['&OK'])
       else
         TEqualsFuncoes.fMensagem('AVISO', 'Conciliação da Equals realizada com sucesso.', ['&OK']);

      blnReabre := (Not Result);

    End;
  Finally
    DestroiComponentes;
  End;
End;

function TConcilEquals.fProcessaEquPag(pgbStatus: TcxProgressBar): Boolean;
Var
  LValorBruto,
  LValorLiquido : Double;
  fltDifere : Double;
  qryConCar : TUniQuery;
  intRecNo  : Integer;
  blnBusca  : Boolean;
  LTipoCartao  : String;
  LRegistroRelatorio: TItensRelatorioCartoes;
  strCodEmp : String;
  LTolerancia   : Double;
  LChaveConciliacao : String;
  LParcela      : String;
begin
  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');
  Application.ProcessMessages;

  qryConCar := Nil;
  Try
    Try
      qryConCar := VS_FuncoesExternas.fICriaQuery;
      qryConCar.SQL.Text := 'SHOW TABLES LIKE "EQU_EQPGTO"';
      qryConCar.Open;
      If qryConCar.IsEmpty Then
      Begin
        TEqualsFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados para a conciliação da Equals!',['&OK']);
        Exit(False);
      End;

      qryConCar.Close;
      qryConCar.SQL.Text := RetornaSQLConciliacaoEquals;

      qryConCar.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
      qryConCar.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', dtaDtaFim);

      qryConCar.Open;

      If qryConCar.RecordCount = 0 Then
      Begin
        TEqualsFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados nesse período de recebimento!',['&OK']);
        blnReabre := True;
        Exit(False);
      End;

      cdsConCar := TEqualsFuncoes.CriarClientDataSet(qryConCar);
      cdsConCar.Open;
    Finally
      TEqualsFuncoes.FreeAndNilDatasets(qryConCar);
    End;

    pCalculaPeriodoFiltro('EQU_DTAVEN');

    FFiltrarAutorizacaoNSU := True;

    TEqualsFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
    pFiltraCartoes;

    pFiltraCartoesBaixados;

    pCarregaEstab;

    pgbStatus.Visible := True;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TEqualsFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';
      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

      LTipoCartao := RetornaTipoDoCartao;

      LValorBruto  := cdsConCar.FieldByName('EQU_VALBRU').Value;
      LValorLiquido := cdsConCar.FieldByName('EQU_VALLIQ').Value;

      LParcela := TEqualsFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('EQU_CODPAR').AsString = '0', '1', cdsConCar.FieldByName('EQU_CODPAR').AsString)));

      If ((MatchStr(cdsConCar.FieldByName('EQU_TIPREG').AsString, ['01', '02', '03', 'D1', 'D2', 'D3'])) Or
           (MatchStr(cdsConCar.FieldByName('EQU_TIPREG').AsString, ['31', '42']) And (cdsConCar.FieldByName('EQU_MOTAJU').AsString.IsEmpty))) And
           (cdsConCar.FieldByName('EQU_VALBRU').Value <> 0)And
           (Concat(cdsConCar.FieldByName('EQU_CODAUT').AsString, cdsConCar.FieldByName('EQU_NUMNSU').AsString) <> '00') Then
      Begin
        strCodEmp := cdsConCar.FieldByName('CODEMP').AsString;
        If TEqualsFuncoes.fEmptyStr(strCodEmp) Then
        Begin
          If (qryEstEqu.RecordCOunt > 0) And (qryEstEqu.Locate('ESTAB', cdsConCar.FieldByName('EQU_CODEST').AsString, [])) Then
            strCodEmp := qryEstEqu.FieldByName('CODEMP').AsString;
        End;

        blnBusca  := fBuscaCartao(TEqualsFuncoes.fStrZero(RightStr(Trim(cdsConCar.FieldByName('EQU_CODAUT').Value), 6), 6),
                                   TEqualsFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('EQU_NUMNSU').Value, 14)), 14),
                                   strCodEmp,
                                   TEqualsFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('EQU_CODPAR').AsString = '0', '1', cdsConCar.FieldByName('EQU_CODPAR').AsString))),
                                   cdsConCar.FieldByName('EQU_DTAVEN').Value,
                                   0,
                                   True);

        If blnBusca Then
        Begin
          fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
          If (fltDifere <= LTolerancia) And (fltDifere >= -LTolerancia) Then
          Begin
            LChaveConciliacao := 'EQU_' + cdsConCar.FieldByName('EQU_CODAUT').Value + '_' + TEqualsFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('EQU_CODPAR').AsString = '0', '1', cdsConCar.FieldByName('EQU_CODPAR').AsString))) + '_' +
                          cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                          FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('EQU_DTAVEN').Value);


            MarcarCartaoEncontradoArquivo(LValorLiquido,
                                    False,
                                    LRegistroRelatorio,
                                    LChaveConciliacao,
                                    cdsConCar);
          End
          Else
          Begin
            intRecNo := cdsBaiCar.RecNo;
            cdsBaiCar.Next;
            While  RegistroPossuiAMesmaAutorizacao(RightStr(cdsConCar.FieldByName('EQU_CODAUT').Value, 6),
                                              LParcela,
                                              strCodEmp,
                                              cdsConCar.FieldByName('EQU_DTAVEN').AsString) Do
            Begin

              fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
              If (fltDifere <= LTolerancia) And (fltDifere >= -LTolerancia) Then
              Begin
                LChaveConciliacao := 'EQU_' + cdsConCar.FieldByName('EQU_CODAUT').Value + '_' +TEqualsFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('EQU_CODPAR').AsString = '0', '1', cdsConCar.FieldByName('EQU_CODPAR').AsString))) + '_' +
                          cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                          FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('EQU_DTAVEN').Value);


                MarcarCartaoEncontradoArquivo(LValorLiquido,
                                    False,
                                    LRegistroRelatorio,
                                    LChaveConciliacao,
                                    cdsConCar);

                Break;
              End;

              cdsBaiCar.Next;

              If cdsBaiCar.Eof Then
                Break;
            End;

            If Not ((fltDifere <= LTolerancia) And (fltDifere >= -LTolerancia)) Then
            Begin
              cdsBaiCar.RecNo := intRecNo;
              FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';

            End;
          End;
        End
        Else If TEqualsFuncoes.fEmptyStr(FTextoInconsistencia) Then
        Begin
          blnAutomatica := cdsConCar.FieldByName('EQU_CONCIL').Value = '1';

          FTextoInconsistencia := 'Cartão já foi baixado';

          cdsBaixad.First;
          blnBusca := fBuscaCartaoBaixado(TEqualsFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('EQU_CODAUT').Value, 6)), 6),
                                   TEqualsFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('EQU_NUMNSU').Value, 14)), 14),
                                   strCodEmp,
                                   TEqualsFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('EQU_CODPAR').AsString = '0', '1', cdsConCar.FieldByName('EQU_CODPAR').AsString))),
                                   cdsConCar.FieldByName('EQU_DTAVEN').Value);
          If Not blnBusca Then
            FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
        End;
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

      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('EQU_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('EQU_CODEST').Value;

      LRegistroRelatorio.CodigoEmpresa := strCodEmp;
      LRegistroRelatorio.NumeroNSU :=TEqualsFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('EQU_NUMNSU').Value, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := TEqualsFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('EQU_CODAUT').Value, 6)), 6);
      LRegistroRelatorio.ResumoVenda := RightStr(cdsConCar.FieldByName('EQU_NUMTID').AsString, 12);
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName('EQU_NUMCAR').Value;
      LRegistroRelatorio.Parcela := TEqualsFuncoes.IIF(cdsConCar.FieldByName('EQU_CODPAR').AsInteger = 0, '01', TEqualsFuncoes.fStrZero(cdsConCar.FieldByName('EQU_CODPAR').AsString, 2));
      LRegistroRelatorio.TotalParcelas := TEqualsFuncoes.IIF(cdsConCar.FieldByName('EQU_CODPAR').AsInteger = 0, '01', TEqualsFuncoes.fStrZero(cdsConCar.FieldByName('EQU_TOTPAR').AsString, 2));
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('EQU_DTAPAG').Value;
      LRegistroRelatorio.DataVenda :=cdsConCar.FieldByName('EQU_DTAVEN').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('EQU_DTAPAG').Value;
      LRegistroRelatorio.ValorBruto := LValorBruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;
      LRegistroRelatorio.TipoCartao := LTipoCartao;

      if LRegistroRelatorio.TipoCartao = 'CANCELAMENTOS/AJUSTES' then
      begin
        LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
        LRegistroRelatorio.DescricaoAjuste := cdsConCar.FieldByName('EQU_MOTAJU').AsString;
      end;


      LRegistroRelatorio.DescricaoBandeira :=fRetNomBandeira(cdsConCar.FieldByName(INICAM + 'NUMCAR').Value);
      If TEqualsFuncoes.fEmptyStr(LRegistroRelatorio.DescricaoBandeira) Then
         LRegistroRelatorio.DescricaoBandeira := 'OUTROS';

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsConCar.Next;
    End;
  Except
    Raise;
  End;

  Result := True;
end;

procedure TConcilEquals.pCarregaEstab;
  Var
    strSQL: String;
begin
  qryEstEqu := VS_FuncoesExternas.fICriaQuery;

  strSQL := 'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "AMEX" AS ADQUIRINTE        ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_AMEEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ' +
            'UNION                                                                         ' +

            'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "CIELO" AS ADQUIRINTE       ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_CIEEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ' +
            'UNION                                                                         ' +

            'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "CONCIL" AS ADQUIRINTE      ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_CONEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ' +
            'UNION                                                                         ' +

            'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "CHART-CIELO" AS ADQUIRINTE ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_CHAEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ' +
            'UNION                                                                         ' +

            'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "GETNET" AS ADQUIRINTE      ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_GETEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ' +
            'UNION                                                                         ' +

            'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "ELAVON" AS ADQUIRINTE      ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_ELAEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ' +
            'UNION                                                                         ' +

            'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "REDECARD" AS ADQUIRINTE    ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_REDEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ' +
            'UNION                                                                         ' +

            'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "SIPAG" AS ADQUIRINTE       ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_SIPEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ' +
            'UNION                                                                         ' +

            'SELECT SIS_VALCFG AS ESTAB, SIS_CODEMP AS CODEMP, "STONE" AS ADQUIRINTE       ' +
            'FROM CFGSIS                                                                   ' +
            'WHERE SIS_CODCFG="CFG_STOEST" AND SIS_VALCFG <> "" AND SIS_VALCFG IS NOT NULL ';

  qryEstEqu.SQL.Text := strSQL;
  qryEstEqu.Open;
end;

function TConcilEquals.RegistroPossuiAMesmaAutorizacao(AAutorizacao, AParcela,
  AEmpresa, ADataCupom: String): Boolean;
begin
  Result := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString = AAutorizacao;

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

function TConcilEquals.RetornaSQLConciliacaoEquals: String;
  Var
    LSQLRegistros50,
    LSQLRegistrosCSV,
    LSQLEstabelecimento: String;
begin
  Result := '';

  LSQLEstabelecimento := 'IF(COALESCE(SIS_CODEMP, "") = "",                          ' +
                         '   (SELECT EMP_CODEMP FROM CADEMP WHERE                    ' +
                         '    EMP_C_G_C_=EQU_CODEST LIMIT 1), SIS_CODEMP) AS CODEMP, ' +
                         'IF(COALESCE(EMP_NOMEMP, "") = "",                          ' +
                         '   (SELECT EMP_NOMEMP FROM CADEMP WHERE                    ' +
                         '    EMP_C_G_C_=EQU_CODEST LIMIT 1), EMP_NOMEMP) AS NOMEMP, ' +
                         'IF(COALESCE(SIS_CODEMP, "") = "", "S", "N") AS CNPJ        ';

  LSQLRegistros50 := ' ((EQU_TIPREG = "50" AND                                 ' +
                     '  (EQU_CODEST, EQU_CODAUT, EQU_NUMNSU, EQU_DTAVEN,       ' +
                     '   EQU_CODPAR) NOT IN                                    ' +
                     '   (SELECT B.EQU_CODEST, B.EQU_CODAUT, B.EQU_NUMNSU,     ' +
                     '            B.EQU_DTAVEN, B.EQU_CODPAR                   ' +
                     '    FROM EQU_EQPGTO B                                    ' +
                     '    WHERE B.EQU_DTAPAG = EQU_DTAPAG AND                  ' +
                     '    B.EQU_TIPREG <> "50"))                               ' +
                     ' OR (EQU_TIPREG NOT IN ("50", "00") AND                  ' +
                     ' (EQU_CODEST, EQU_CODAUT, EQU_NUMNSU, EQU_DTAVEN,        ' +
                     '   EQU_CODPAR) NOT IN                                    ' +
                     ' (SELECT EQU_CODEST, EQU_CODAUT, EQU_NUMNSU, EQU_DTAVEN, ' +
                     '         EQU_CODPAR                                      ' +
                     ' FROM EQU_EQPGTO                                         ' +
                     ' WHERE EQU_DTAPAG <= :DTAIN AND EQU_TIPREG="50")))       ';

  LSQLRegistrosCSV := ' OR (EQU_TIPREG IN ("01", "02", "03", "D1", "D2", "D3", "E1", ' +
                      '                    "E2", "E3", "H1", "H2", "H3", "G1", "11", ' +
                      '                    "12", "13", "21", "22", "23", "31", "32", ' +
                      '                    "41", "42", "43", "51", "52")) ';

  Result := Result + ' SELECT *, ' + LSQLEstabelecimento;
  Result := Result + ' FROM EQU_EQPGTO                                   ';
  Result := Result + ' LEFT JOIN CFGSIS ON SIS_VALCFG=EQU_CODEST         ';
  Result := Result + '                 AND SIS_CODCFG="CFG_EQUEST"       ';
  Result := Result + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP         ';
  Result := Result + ' WHERE EQU_DTAPAG BETWEEN :DTAIN AND :DTAFIM AND   ';
  Result := Result + '       EQU_VALLIQ <> 0 AND (' + LSQLRegistros50;
  Result := Result + LSQLRegistrosCSV + ') ';
  Result := Result + fRetPesqPonVen(0);
  Result := Result + ' ORDER BY EQU_DTAPAG                               ';
end;

function TConcilEquals.RetornaTipoDoCartao: String;
begin
   If (MatchStr(cdsConCar.FieldByName('EQU_TIPREG').AsString, ['02', '03', 'D2'])) Or
    ((cdsConCar.FieldByName('EQU_TIPREG').AsString = '42') And cdsConCar.FieldByName('EQU_MOTAJU').AsString.IsEmpty) Then
        result := 'ANTECIPAÇÃO'
    Else If (MatchStr(cdsConCar.FieldByName('EQU_TIPREG').AsString, ['01', 'D1', 'D3']) Or
              ((cdsConCar.FieldByName('EQU_TIPREG').AsString = '31') And cdsConCar.FieldByName('EQU_MOTAJU').AsString.IsEmpty)) And
              (Concat(cdsConCar.FieldByName('EQU_CODAUT').AsString, cdsConCar.FieldByName('EQU_NUMNSU').AsString) <> '00') Then
    Begin
        If (((TEqualsFuncoes.fEmptyStr(cdsConCar.FieldByName('EQU_TOTPAR').AsString)) Or (cdsConCar.FieldByName('EQU_TOTPAR').AsInteger <= 1)) And
           (cdsConCar.FieldByName('EQU_DTAPAG').Value - cdsConCar.FieldByName('EQU_DTAVEN').Value < 5)) Then
          result := 'DÉBITO'
        Else
          result := TEqualsFuncoes.IIF(cdsConCar.FieldByName('EQU_TOTPAR').AsInteger > 1,
                         'CRÉDITO PARCELADO',
                         'CRÉDITO ROTATIVO');
    End
    Else
    Begin
        result   := 'CANCELAMENTOS/AJUSTES';
        FTextoInconsistencia := 'Cancelamentos/Ajustes';
    End;
end;

end.
