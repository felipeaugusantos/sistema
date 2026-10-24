unit untConfNotaConcreto;

interface

uses
  Classes,
  Uni,
  DB,
  UniClientDataSet,
  DBCtrls,
  strUtils,
  SysUtils,
  Forms,
  Math,
  Variants,
  untFuncFat,
  untTypesSistema;

type
  TConfirmacaoNotaConcreto = class(TComponent)
    private
      FCodCli: String;
      FNumNot: String;
      FDtaIni: TDateTime;
      FDtaFim: TDateTime;

      FNum_PdSel: String;
      FEsp_PdSel: String;
      FEmp_PdSel: String;

      FQtdDoc: String;
      FTotGer: String;

      FQtdDocSel: String;
      FTotGerSel: String;

      FItensDocs: Integer;

      fatVenda : TFatVenda;

      procedure pCalculaTotais;
      function fGetSemNotas: Boolean;
      function fMarcaDocumentoInterna(blnMarcar: Boolean): Boolean;
      procedure pMarcarDocumentosPedido;
    public
      procedure pDeletaTemporariaConfirmacao;
      procedure pCriaTemporariaConfirmacao;
      procedure pAtualizaTemporariaConfirmacao;
      procedure pDeletaNotasDesmarcados;
      procedure pExibirProdutosDocumento;
      procedure pSetaVariaveisConfirmacao;

      function fMarcaDocumento(blnMarcar: Boolean): Boolean;

      {Funções utilizadas na J_A_Massa_E_Concreto}
      function fCarregaItensConfirmacao_OrigemEmPedidoDeConcreto(strNumDoc_PD, strEspDoc_PD, strEmpDoc_PD, strItemConcreto : String) : Boolean;
      function fFinalizarCarregamento : Boolean;
      function fDocumentoAConfirmarTeveOrigemEmPedidoDeConcreto(strNumDoc, strEspDoc, strEmpDoc : String; Out strNumDoc_PD, strEspDoc_PD, strEmpDoc_PD, strItemConcreto : String) : Boolean;

      function fCarregaItensConfirmacao: Boolean;
      function fMostraProdutosConfirmacao: Boolean;

      procedure pCarregaProfissionaisDoPedidoDeVenda;

      constructor Create(AOwner: TComponent); override;
      constructor CreateInstance(AOwner: TComponent; objVenda: TFatVenda);

      destructor Destroy; override;

    published
      property strCodigoCliente: String Read FCodCli Write FCodCli;
      property strNumeroNota: String Read FNumNot Write FNumNot;
      property dtaDataInicial: TDateTime Read FDtaIni Write FDtaIni;
      property dtaDataFinal: TDateTime Read FDtaFim Write FDtaFim;

      property strQuantidadeDocumentos: String Read FQtdDoc;
      property strTotalGeral: String Read FTotGer;

      property intQtdItensDocs: Integer Read FItensDocs;

      property strQuantidadeDocumentosSelecionados: String Read FQtdDocSel;
      property strTotalGeralSelecionados: String Read FTotGerSel;

      property blnSemNotasParaConfirmar: Boolean Read fGetSemNotas;
  end;


implementation

uses  untFatMostraProdConfirmacao, untMadeireira ,untConstantes,
      untFuncoes, untFuncFatTypes, untFuncoesSimples, untGravando;

constructor TConfirmacaoNotaConcreto.Create(AOwner: TComponent);
begin
//  inherited;
  CreateInstance(AOwner, nil);
end;

constructor TConfirmacaoNotaConcreto.CreateInstance(AOwner: TComponent; objVenda: TFatVenda);
begin
  inherited Create(AOwner);
  fatVenda   := objVenda;
  FDtaIni    := 0;
  FDtaFim    := 0;
  FNum_PdSel := '';
  FEsp_PdSel := '';
  FEmp_PdSel := '';
end;

destructor TConfirmacaoNotaConcreto.Destroy;
begin
  inherited Destroy;
end;

function TConfirmacaoNotaConcreto.fCarregaItensConfirmacao: Boolean;
  Var
    strSQL: String;
    strItemAnt: String;

    qryGenIte: TUniQuery;
    qryGenDet: TUniQuery;

    recMadeira: TDadosMadeira;
    fltCusIte: Double;

    recForTin: TForTin;
    blnPegEndEnt: Boolean;
    blnDecidiuEndereco : Boolean;

    strNumDoc_PD, strEspDoc_PD, strEmpDoc_PD, strItemConcreto : String;

begin

  {Verifica se o documento a ser confirmado teve origem
   em um pedido de venda de concreto!}
  If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
  Begin

    fatVenda.qryTemporariaConfirmacao.First;
    While Not fatVenda.qryTemporariaConfirmacao.Eof Do
    Begin

      strNumDoc_PD    := '';
      strEspDoc_PD    := '';
      strEmpDoc_PD    := '';
      strItemConcreto := '';

      If (fDocumentoAConfirmarTeveOrigemEmPedidoDeConcreto(fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString,
                                                           fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString,
                                                           VS_strCodEmp,
                                                           strNumDoc_PD,
                                                           strEspDoc_PD,
                                                           strEmpDoc_PD,
                                                           strItemConcreto)) Then
      Begin
        If Not fCarregaItensConfirmacao_OrigemEmPedidoDeConcreto(strNumDoc_PD, strEspDoc_PD, strEmpDoc_PD, strItemConcreto) Then
          Exit(False);
      End;

      fatVenda.qryTemporariaConfirmacao.Next;

      If fatVenda.qryTemporariaConfirmacao.Eof Then
        If Not fFinalizarCarregamento Then
          Exit(False);

      Application.ProcessMessages;

    End;

    Exit(True);

  End;

  qryGenIte := fCriaQuery(Self);
  qryGenDet := fCriaQuery(Self);

  strItemAnt  := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_IDEPRO, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  ITE_CODGRU, ';
  strSQL := strSQL + '  DET_DESCRI, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_UNIDAD, ';
  strSQL := strSQL + '  DET_CODMAR, ';
  strSQL := strSQL + '  DET_FORITE, ';
  strSQL := strSQL + '  DET_REFERE, ';
  strSQL := strSQL + '  DET_VAL_RT, ';
  strSQL := strSQL + '  DET_UNIORI, ';
  strSQL := strSQL + '  DET_UNIVIS, ';
  strSQL := strSQL + '  DET_TAXJUR, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_DESCON, ';
  strSQL := strSQL + '  DET_QTDITE, ';

  If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
  Begin
    strSQL := strSQL + '  DET_COMPEC, ';
    strSQL := strSQL + '  DET_LARPEC, ';
    strSQL := strSQL + '  DET_ESPPEC, ';

    strSQL := strSQL + '  DET_APAREL, ';
    strSQL := strSQL + '  DET_PERAPA, ';
    strSQL := strSQL + '  DET_BENEFI, ';
    strSQL := strSQL + '  DET_PERBEN, ';
  End;

  strSQL := strSQL + '  DET_TOTITE, ';
  strSQL := strSQL + '  DET_TOTCUS, ';
  strSQL := strSQL + '  DET_TOTCU2, ';
  strSQL := strSQL + '  DET_INCPIS, ';
  strSQL := strSQL + '  DET_QTDEMB, ';
  strSQL := strSQL + '  DET_PREEMB, ';
  strSQL := strSQL + '  DET_TOTPES, ';
  strSQL := strSQL + '  DET_PROMOC, ';
  strSQL := strSQL + '  DET_CLAFIS, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_QTDEMB, ';
  strSQL := strSQL + '  DET_PREEMB, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_SEQTIN, ';
  strSQL := strSQL + '  DET_TABPRE, ';
  strSQL := strSQL + '  D.AUTOINCREM, ';
  strSQL := strSQL + '  DET_ESTADO, ';
  strSQL := strSQL + '  DET_QTDPON, ';
  strSQL := strSQL + '  DET_ITETIN, ';
  strSQL := strSQL + '  DET_TOTFRE, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  DET_CODVEN, ';
  strSQL := strSQL + '  DET_CODACA, ';
  strSQL := strSQL + '  DET_EMPACA, ';
  strSQL := strSQL + '  DET_SEQCCR, ';

  strSQL := strSQL + ' (DET_ICMSAI / (DET_TOTITE - DET_DESESP) * 100) AS DET_ICMSAI, ';
  strSQL := strSQL + ' (DET_IMPFED / (DET_TOTITE - DET_DESESP) * 100) AS DET_IMPFED, ';
  strSQL := strSQL + ' (DET_DESOPE / (DET_TOTITE - DET_DESESP) * 100) AS DET_DESOPE, ';
  strSQL := strSQL + ' (DET_TOTMED / DET_QTDITE) AS DET_PREMED, ';
  strSQL := strSQL + ' (DET_IMPULT / DET_QTDITE) AS DET_IMPULT, ';
  strSQL := strSQL + ' (DET_TOTULT / DET_QTDITE) AS DET_PREULT  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET D ';
  strSQL := strSQL + 'JOIN CADITE ON ITE_CODITE = DET_CODITE ';

  If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
    strSQL := strSQL + ' LEFT JOIN MOVMAD M ON M.DET_SEQGER = D.AUTOINCREM  ';

  strSQL := strSQL + ' LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM  ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_PROEMB <> "S" AND ';
  strSQL := strSQL + '  DET_DTAENT = :DTAENT AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  DET_CODITE ';

  {*****************************************}
  {* DOCUMENTO DETALHADO                   *}
  {**************************************MV*}
  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  I.ITE_DESITE, ';
  strSQL := strSQL + '  I.ITE_DESSIM, ';
  strSQL := strSQL + '  I.ITE_DESFAB, ';
  strSQL := strSQL + '  I.ITE_COMLUB, ';
  strSQL := strSQL + '  I.ITE_CLAIPI, ';
  strSQL := strSQL + '  I.ITE_EXCIPI, ';
  strSQL := strSQL + '  I.ITE_CODFAB, ';
  strSQL := strSQL + '  I.ITE_CODBAR, ';
  strSQL := strSQL + '  G.ITE_OUTVAL, ';
  strSQL := strSQL + '  G.ITE_IMPFED, ';
  strSQL := strSQL + '  G.ITE_ICMSAI, ';
  strSQL := strSQL + '  G.ITE_PRECUS, ';
  strSQL := strSQL + '  G.ITE_DESOPE, ';
  strSQL := strSQL + '  G.ITE_PREULT, ';
  strSQL := strSQL + '  G.ITE_IMPULT, ';
  strSQL := strSQL + '  G.ITE_QTDUCO, ';

  strSQL := strSQL + '  G.ITE_PREVE1, ';
  strSQL := strSQL + '  G.ITE_PREVE2, ';
  strSQL := strSQL + '  G.ITE_PREVE3, ';
  strSQL := strSQL + '  G.ITE_PREVE4, ';
  strSQL := strSQL + '  G.ITE_PREVE5, ';
  strSQL := strSQL + '  G.ITE_PREVE6, ';
  strSQL := strSQL + '  G.ITE_PREVE7, ';

  strSQL := strSQL + '  G.ITE_COMTB1, ';
  strSQL := strSQL + '  G.ITE_COMTB2, ';
  strSQL := strSQL + '  G.ITE_COMTB3, ';
  strSQL := strSQL + '  G.ITE_COMTB4, ';
  strSQL := strSQL + '  G.ITE_COMTB5, ';
  strSQL := strSQL + '  G.ITE_COMTB6, ';
  strSQL := strSQL + '  G.ITE_COMTB7, ';

  strSQL := strSQL + '  G.ITE_IPISAI, ';
  strSQL := strSQL + '  G.ITE_DESMAX, ';
  strSQL := strSQL + '  G.ITE_DESMGE, ';
  strSQL := strSQL + '  G.ITE_DESMSU, ';
  strSQL := strSQL + '  G.ITE_SALDOS, ';
  strSQL := strSQL + '  G.ITE_PREMED, ';
  strSQL := strSQL + '  G.ITE_COMVAR, ';
  strSQL := strSQL + '  G.ITE_COMATA, ';
  strSQL := strSQL + '  G.ITE_COMDIS, ';
  strSQL := strSQL + '  G.ITE_MARMIN, ';
  strSQL := strSQL + '  G.ITE_MARMSG, ';
  strSQL := strSQL + '  G.ITE_MARMGE, ';

  strSQL := strSQL + '  G.ITE_DESMVM, ';
  strSQL := strSQL + '  G.ITE_DESMSM, ';
  strSQL := strSQL + '  G.ITE_DESMGM, ';

  strSQL := strSQL + '  G.ITE_MARMMV, ';
  strSQL := strSQL + '  G.ITE_MARMMS, ';
  strSQL := strSQL + '  G.ITE_MARMMG, ';

  strSQL := strSQL + '  G.ITE_IPIENT, ';
  strSQL := strSQL + '  G.ITE_FREENT, ';
  strSQL := strSQL + '  G.ITE_LOCFIS, ';
  strSQL := strSQL + '  A.ABF_CODABF, ';
  strSQL := strSQL + '  I.ITE_PESLIQ, ';
  strSQL := strSQL + '  I.ITE_OBRCPF, ';
  strSQL := strSQL + '  G.ITE_PRECOM, ';

  If fCfgSis('IMPDIG') = '1' Then
    strSQL := strSQL + '  I.ITE_IMPDIR  '
  Else
    strSQL := strSQL + '  G.ITE_IMPDIR  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE I, ';
  strSQL := strSQL + '  ITEGER G, ';
  strSQL := strSQL + '  ABFICM A ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

  If fCfgSis('TIPABF') = '1' Then
    strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
  Else
    strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

  strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

  {*****************************************}
  {* PREPARA A QUERY PARA RETORNAR DADOS   *}
  {* DO ITEM E DA ABREVIAÇÃO FISCAL        *}
  {**************************************MV*}
  With qryGenIte Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
  End;

  Try
    With fatVenda.qryTemporariaConfirmacao Do
    Begin

      First;

      blnPegEndEnt := True;

      While (Not Eof) Do
      Begin
        If fEmptyStr(fatVenda.strFasObr) Then
          fatVenda.strFasObr := FieldByName('TMP_FASOBR').AsString;

        If (blnPegEndEnt) Then
        Begin
          fatVenda.pCarregaEnderecoEntrega(fatVenda,
                                           FieldByName('TMP_NOMTAB').AsString,
                                           FieldByName('TMP_AUTINC').AsString,
                                           True);

          blnPegEndEnt := fEmptyStr(fatVenda.strEndEnt);

          If Not blnPegEndEnt Then
            fatVenda.blnEndEntConfDoc := True;
        End;

        {*****************************************}
        {* CARREGA DOCUMENTO DETALHADO           *}
        {**************************************MV*}
        qryGenDet.Close;
        qryGenDet.ParamByName('DTAENT').AsDate   := FieldByName('TMP_DTAENT').AsDateTime;
        qryGenDet.ParamByName('NUMDOC').AsString := FieldByName('TMP_NUMDOC').AsString;
        qryGenDet.ParamByName('ESPDOC').AsString := FieldByName('TMP_ESPDOC').AsString;
        qryGenDet.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryGenDet.Open;

        While (Not qryGenDet.Eof) Do
        Begin
          If (StrToInt(LeftStr(qryGenDet.FieldByName('DET_CLAFIS').AsString, 1)) < 5) Then
          Begin
            Raise Exception.Create('Classificação fiscal menor que 5000. Favor verificar.');
          End;

          If (strItemAnt <> qryGenDet.FieldByName('DET_CODITE').AsString) Then
          Begin

            {*****************************************}
            {* CARREGA ITEM                          *}
            {**************************************MV*}
            qryGenIte.Close;
            qryGenIte.ParamByName('CODITE').AsString := qryGenDet.FieldByName('DET_CODITE').AsString;
            qryGenIte.ParamByName('CODEMP').AsString := qryGenDet.FieldByName('DET_CODEMP').AsString;
            qryGenIte.ParamByName('ESTADO').AsString := qryGenDet.FieldByName('DET_ESTADO').AsString;
            qryGenIte.Open;

            fatVenda.pCarregaValoresCusto(qryGenDet.FieldByName('DET_CODITE').AsString,
                                          qryGenDet.FieldByName('DET_CODEMP').AsString,
                                          qryGenDet.FieldByName('DET_TABPRE').AsString);

            strItemAnt  := qryGenDet.FieldByName('DET_CODITE').AsString;
          End;

          If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
          Begin
            recMadeira.fltComPec := qryGenDet.FieldByName('DET_COMPEC').AsFloat;
            recMadeira.fltLarPec := qryGenDet.FieldByName('DET_LARPEC').AsFloat;
            recMadeira.fltEspPec := qryGenDet.FieldByName('DET_ESPPEC').AsFloat;

            recMadeira.fltQtdPec := fCalculaQuantidadePecas(qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                            recMadeira.fltComPec,
                                                            recMadeira.fltLarPec,
                                                            recMadeira.fltEspPec,
                                                            fRetSiglaUnidade(qryGenDet.FieldByName('DET_UNIDAD').AsString));

            recMadeira.strAparel := qryGenDet.FieldByName('DET_APAREL').AsString;
            recMadeira.fltPerApa := qryGenDet.FieldByName('DET_PERAPA').AsFloat;
            recMadeira.strBenefi := qryGenDet.FieldByName('DET_BENEFI').AsString;
            recMadeira.fltPerBen := qryGenDet.FieldByName('DET_PERBEN').AsFloat;
          End;

          fltCusIte := qryGenDet.FieldByName('DET_TOTCUS').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat;

          fatVenda.pAdicionaRegistroTemporaria( cdsVenda,
                                                Nil,
                                                qryGenDet.FieldByName('DET_IDEPRO').AsString,
                                                qryGenDet.FieldByName('ITE_CODGRU').AsString,
                                                qryGenDet.FieldByName('DET_CODITE').AsString,
                                                qryGenDet.FieldByName('DET_DESCRI').AsString,
                                                qryGenDet.FieldByName('DET_DESCRI').AsString,
                                                qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                                qryGenDet.FieldByName('DET_UNIDAD').AsString,
                                                qryGenDet.FieldByName('DET_UNIDAD').AsString,
                                                qryGenDet.FieldByName('DET_CODMAR').AsString,
                                                qryGenDet.FieldByName('DET_FORITE').AsString,
                                                qryGenDet.FieldByName('DET_REFERE').AsString,
                                                qryGenDet.FieldByName('DET_UNIORI').AsFloat,
                                                qryGenDet.FieldByName('DET_UNIVIS').AsFloat,
                                                qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                                qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                                qryGenDet.FieldByName('DET_DESCON').AsFloat,
                                                qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                qryGenDet.FieldByName('DET_TOTITE').AsFloat,
                                                'S',
                                                qryGenDet.FieldByName('DET_TOTCUS').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                qryGenDet.FieldByName('DET_TOTCUS').AsFloat,
                                                qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                                qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                                qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE7').AsFloat,

                                                fCalculaPrecoVenda(2, fltCusIte + fatVenda.fRetOutVal(qryGenIte.FieldByName('ITE_OUTVAL').AsFloat),
                                                                      qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                                                      0,
                                                                      IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_ICMSAI').AsFloat, fatVenda.fRetIcmSai(qryGenIte.FieldByName('ITE_ICMSAI').AsFloat)),
                                                                      IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_IMPFED').AsFloat, fatVenda.fRetImpFed(qryGenIte.FieldByName('ITE_IMPFED').AsFloat)),
                                                                      IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_DESOPE').AsFloat, fatVenda.fRetDesOpe(qryGenIte.FieldByName('ITE_DESOPE').AsFloat)),
                                                                      qryGenIte.FieldByName('ITE_COMTB' +
                                                                        IIF(fEmptyStr(qryGenDet.FieldByName('DET_TABPRE').AsString), '1',
                                                                          qryGenDet.FieldByName('DET_TABPRE').AsString)).AsFloat, fatVenda.VS_strMARMKP),

                                                qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                                qryGenDet.FieldByName('DET_INCPIS').AsString,
                                                qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                                qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                                qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                                '',
                                                '',
                                                '',
                                                0.0,
                                                0.0,
                                                '',
                                                IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_PREULT').AsFloat, qryGenIte.FieldByName('ITE_PREULT').AsFloat) * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_IMPULT').AsFloat, qryGenIte.FieldByName('ITE_IMPULT').AsFloat),
                                                IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_PREULT').AsFloat, qryGenIte.FieldByName('ITE_PREULT').AsFloat),
                                                IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_PREMED').AsFloat, qryGenIte.FieldByName('ITE_PREMED').AsFloat),
                                                qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                                '',
                                                qryGenDet.FieldByName('DET_ITETIN').AsString,  //CODIGO DA TINTA
                                                '',
                                                '',
                                                0,
                                                '',
                                                qryGenDet.FieldByName('DET_QTDEMB').AsFloat,
                                                qryGenDet.FieldByName('DET_PREEMB').AsFloat,
                                                0.0,
                                                0.0,
                                                0.0,
                                                'N',
                                                '',
                                                0,
                                                0,
                                                qryGenIte.FieldByName('ABF_CODABF').AsString,
                                                qryGenDet.FieldByName('DET_TOTPES').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                                qryGenDet.FieldByName('DET_PROMOC').AsString,
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                                IIF(fEmptyStr(qryGenDet.FieldByName('DET_SEQTIN').AsString), '', '2'),
                                                0.0,
                                                qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                                -1,
                                                0.0,
                                                '',
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                                FatVenda.strDesMar,
                                                fatVenda.strStatus,
                                                0.0,
                                                0.0,
                                                qryGenDet.FieldByName('AUTOINCREM').AsString,
                                                '',
                                                '',
                                                0.0,
                                                '',
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                                qryGenDet.FieldByName('DET_UNITAR').AsFloat,
                                                qryGenDet.FieldByName('DET_QTDPON').AsFloat,
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                                '',
                                                '',
                                                fRetSiglaUnidade(qryGenDet.FieldByName('DET_UNIDAD').AsString),
                                                0.0,
                                                fatVenda.fOrdemItem(cdsVenda,'Adiciona',nil),
                                                '',
                                                qryGenDet.FieldByName('DET_CODACA').AsString,
                                                qryGenDet.FieldByName('DET_EMPACA').AsString,
                                                False,
                                                '',
                                                '',
                                                '',
                                                fatVenda.fRetOutVal(qryGenIte.FieldByName('ITE_OUTVAL').AsFloat),
                                                qryGenIte.FieldByName('ITE_COMTB' +
                                                  IIF(fEmptyStr(qryGenDet.FieldByName('DET_TABPRE').AsString), '1',
                                                                qryGenDet.FieldByName('DET_TABPRE').AsString) ).AsFloat,
                                                IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_DESOPE').AsFloat, fatVenda.fRetDesOpe(qryGenIte.FieldByName('ITE_DESOPE').AsFloat)),
                                                IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_ICMSAI').AsFloat, fatVenda.fRetIcmSai(qryGenIte.FieldByName('ITE_ICMSAI').AsFloat)),
                                                IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_IMPFED').AsFloat, fatVenda.fRetImpFed(qryGenIte.FieldByName('ITE_IMPFED').AsFloat)),
                                                qryGenIte.FieldByName('ITE_DESMGE').AsFloat,
                                                qryGenDet.FieldByName('DET_NUMDOC').AsString,
                                                qryGenDet.FieldByName('DET_ESPDOC').AsString,
                                                qryGenDet.FieldByName('DET_CODEMP').AsString,
                                                qryGenDet.FieldByName('DET_TABPRE').AsString,
                                                qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                                qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                                '',
                                                0.0,
                                                '',
                                                0.0,
                                                '',
                                                '',
                                                'N',
                                                '',
                                                0,
                                                qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                0,
                                                0,
                                                qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                                qryGenIte.FieldByName('ITE_LOCFIS').AsString,

                                                qryGenDet.FieldByName('DET_TOTCU2').AsFloat / qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                qryGenDet.FieldByName('DET_TOTCU2').AsFloat,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                recForTin,
                                                '',
                                                '',
                                                qryGenDet.FieldByName('DET_NUMLOT').AsString,
                                                '',
                                                qryGenDet.FieldByName('DET_CODVEN').AsString,
                                                False,
                                                'N',
                                                'NOR',
                                                0,
                                                '',
                                                qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                                '',
                                                0,
                                                0,
                                                0,
                                                '',
                                                1,
                                                True,
                                                '',
                                                '',
                                                '',
                                                0,
                                                fltCusIte,
                                                qryGenIte.FieldByName('ITE_DESSIM').AsString,
                                                '',
                                                recMadeira,
                                                IfThen(qryGenDet.FieldByName('DET_IDEPRO').AsString <> 'NOR', qryGenDet.FieldByName('DET_IMPULT').AsFloat, qryGenIte.FieldByName('ITE_IMPULT').AsFloat) * qryGenDet.FieldByName('DET_QTDITE').AsFloat,
                                                qryGenDet.FieldByName('DET_VAL_RT').AsFloat,
                                                qryGenDet.FieldByName('DET_TAXJUR').AsFloat,
                                                '',
                                                0,
                                                '',
                                                '',
                                                0,
                                                0,
                                                '',
                                                '',
                                                0,
                                                '',
                                                'N',
                                                0,
                                                0,
                                                0,
                                                False,
                                                False,
                                                'N',
                                                '',
                                                qryGenDet.FieldByName('DET_SEQCCR').AsInteger,
                                                0,
                                                '',
                                                'N',
                                                0,
                                                '',
                                                '',
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                                qryGenIte.FieldByName('ITE_DESMSU').AsFloat,
                                                '',
                                                '',
                                                '',
                                                'S',
                                                'N',
                                                '',
                                                '',
                                                '',
                                                '',
                                                False,
                                                -1,
                                                -1,
                                                'N',
                                                '',
                                                'N',
                                                0,
                                                0,
                                                0,
                                                '',
                                                0,
                                                0,
                                                0,
                                                '',
                                                0,
                                                0,
                                                0,
                                                '',
                                                '',
                                                0,
                                                0,
                                                0,
                                                False,
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                '',
                                                '',
                                                0,
                                                0,
                                                '',
                                                '',
                                                'N',
                                                'N',
                                                '',
                                                0,
                                                0,
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_DESMVM').AsFloat,
                                                qryGenIte.FieldByName('ITE_DESMSM').AsFloat,
                                                qryGenIte.FieldByName('ITE_DESMGM').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

          qryGenDet.Next;

          Application.ProcessMessages;

        End;

        Next;

        Application.ProcessMessages;
      End;

      Result := True;
    End;

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;

  End;

  {*****************************************}
  {* SE OCORREU UM ERRO DURANTE O PROCES-  *}
  {* SAMENTO, SAI                          *}
  {**************************************MV*}
  If (Not Result) Then
    Exit;

  {*****************************************}
  {* PREENCHE A MATRIZ COM OS ITENS        *}
  {**************************************MV*}
  Try
    fatVenda.pPreencheMatrizFechamento;

    If (fatVenda.blnEndEntConfDoc) Then
    Begin
      blnDecidiuEndereco := False;
      Repeat
        If (Not fatVenda.fAlteraEnderecoEntrega(False, True, True, True, True)) Then
        Begin
          If fMensagem('', 'Nenhum Endereço de Entrega foi Informado, Continuar?', ['&Sim', '&Não']) = 1 Then
          Begin
            fatVenda.blnEndEntConfDoc := False;
            fatVenda.pLimparEnderecoEntrega;
            fatVenda.pEnderecoToFatVenda;
            blnDecidiuEndereco := True;

            If fatVenda.fAtendeRegraFiscalEndEntrega Then
              fatVenda.pPreencheMatrizFechamento;
          End;
        End
        Else blnDecidiuEndereco := True;
      Until (blnDecidiuEndereco = True);
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('', E.Message, ['&O K']);
      Result := False;
      Exit;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
      Exit;
    End;
  End;

  {*****************************************}
  {* CALCULA TOTAL GERAL                   *}
  {**************************************MV*}
  fatVenda.pCalculaTotGer;

  FreeAndNil(qryGenIte);
  FreeAndNil(qryGenDet);

end;

function TConfirmacaoNotaConcreto.fCarregaItensConfirmacao_OrigemEmPedidoDeConcreto(strNumDoc_PD, strEspDoc_PD, strEmpDoc_PD, strItemConcreto : String) : Boolean;
Var
  strSQL     : String;
  strItemAnt : String;

  qryGenIte : TUniQuery;
  qryGenDet : TUniQuery;

  recMadeira : TDadosMadeira;
  fltCusIte  : Double;

  recForTin    : TForTin;
  blnPegEndEnt : Boolean;

begin

  Result := False;

  If strNumDoc_PD.IsEmpty Then
    Exit;

  If strEspDoc_PD.IsEmpty Then
    Exit;

  If strEmpDoc_PD.IsEmpty Then
    Exit;

  If strItemConcreto.IsEmpty Then
    Exit;

  qryGenIte := fCriaQuery(Self);
  qryGenDet := fCriaQuery(Self);

  Try

    strItemAnt  := '';

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  FDO_NUMDOC, ';
    strSQL := strSQL + '  FDO_ESPDOC, ';
    strSQL := strSQL + '  FDO_CODEMP, ';
    strSQL := strSQL + '  FDO_IDEPRO, ';
    strSQL := strSQL + '  FDO_CODITE, ';
    strSQL := strSQL + '  ITE_CODGRU, ';
    strSQL := strSQL + '  FDO_DESCRI, ';
    strSQL := strSQL + '  FDO_UNIDAD, ';
    strSQL := strSQL + '  FDO_UNIDAD, ';
    strSQL := strSQL + '  FDO_CODMAR, ';
    strSQL := strSQL + '  FDO_FORITE, ';
    strSQL := strSQL + '  FDO_REFERE, ';
    strSQL := strSQL + '  FDO_VAL_RT, ';
    strSQL := strSQL + '  FDO_UNIORI, ';
    strSQL := strSQL + '  FDO_UNIVIS, ';
    strSQL := strSQL + '  FDO_TAXJUR, ';
    strSQL := strSQL + '  FDO_UNITAR, ';
    strSQL := strSQL + '  FDO_UNITAR, ';
    strSQL := strSQL + '  FDO_DESCON, ';
    strSQL := strSQL + '  FDO_QTDITE, ';
    strSQL := strSQL + '  FDO_TOTITE, ';
    strSQL := strSQL + '  FDO_TOTCUS, ';
    strSQL := strSQL + '  FDO_TOTCU2, ';
    strSQL := strSQL + '  FDO_INCPIS, ';
    strSQL := strSQL + '  FDO_QTDEMB, ';
    strSQL := strSQL + '  FDO_PREEMB, ';
    strSQL := strSQL + '  FDO_TOTPES, ';
    strSQL := strSQL + '  FDO_PROMOC, ';
    strSQL := strSQL + '  FDO_CLAFIS, ';
    strSQL := strSQL + '  FDO_CODEMP, ';
    strSQL := strSQL + '  FDO_QTDEMB, ';
    strSQL := strSQL + '  FDO_PREEMB, ';
    strSQL := strSQL + '  FDO_ESPDOC, ';
    strSQL := strSQL + '  FDO_SEQTIN, ';
    strSQL := strSQL + '  FDO_TABPRE, ';
    strSQL := strSQL + '  D.AUTOINCREM, ';
    strSQL := strSQL + '  FDO_ESTADO, ';
    // strSQL := strSQL + '  DET_QTDPON, ';
    strSQL := strSQL + '  FDO_ITETIN, ';
    strSQL := strSQL + '  FDO_TOTFRE, ';
    strSQL := strSQL + '  FDO_NUMLOT, ';
    strSQL := strSQL + '  FDO_CODVEN, ';
    strSQL := strSQL + '  FDO_CODACA, ';
    strSQL := strSQL + '  FDO_EMPACA, ';
    // strSQL := strSQL + '  DET_SEQCCR, ';

    strSQL := strSQL + ' (FDO_ICMSAI / (FDO_TOTITE - FDO_DESESP) * 100) AS FDO_ICMSAI, ';
    strSQL := strSQL + ' (FDO_IMPFED / (FDO_TOTITE - FDO_DESESP) * 100) AS FDO_IMPFED, ';
    strSQL := strSQL + ' (FDO_DESOPE / (FDO_TOTITE - FDO_DESESP) * 100) AS FDO_DESOPE, ';
    strSQL := strSQL + ' (FDO_TOTMED / FDO_QTDITE) AS FDO_PREMED,                      ';
    // strSQL := strSQL + ' (DET_IMPULT / DET_QTDITE) AS DET_IMPULT, ';
    // strSQL := strSQL + ' (DET_TOTULT / DET_QTDITE) AS DET_PREULT  ';

    strSQL := strSQL + ' FGO_CCRPLA, ';
    strSQL := strSQL + ' FGO_CCRMOT, ';
    strSQL := strSQL + ' FGO_CCRBET, ';
    strSQL := strSQL + ' FGO_CCRLAC, ';
    strSQL := strSQL + ' FGO_CCR_CB, ';
    strSQL := strSQL + ' FGO_CCRFCK, ';
    strSQL := strSQL + ' FGO_CCRABA, ';
    strSQL := strSQL + ' FGO_CCRTIP, ';
    strSQL := strSQL + ' FGO_CCRBRI, ';
    strSQL := strSQL + ' FGO_CCR_ML, ';
    strSQL := strSQL + ' FGO_CCRQTD, ';
    strSQL := strSQL + ' FGO_CCRVLR, ';
    strSQL := strSQL + ' FGO_CCRTOT, ';
    strSQL := strSQL + ' FGO_CCROBR, ';
    strSQL := strSQL + ' FGO_CCRART, ';
    strSQL := strSQL + ' FGO_CODCNO, ';
    strSQL := strSQL + ' FGO_INSIMO, ';
    strSQL := strSQL + ' FGO_CODCIB, ';
    strSQL := strSQL + ' FDO_VLRCON  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATDOR D ';
    strSQL := strSQL + '  JOIN CADITE ON ITE_CODITE = FDO_CODITE            ';
    strSQL := strSQL + '  LEFT JOIN EXTDOR T ON T.FDO_SEQFDO = D.AUTOINCREM ';
    strSQL := strSQL + '  JOIN FATGOR G ON (G.AUTOINCREM = D.FDO_SEQGER)    ';
    strSQL := strSQL + '  JOIN EXTGOR E ON (E.FGO_SEQFGO = G.AUTOINCREM)    ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FDO_PROEMB <> "S" AND ';
    // strSQL := strSQL + '  FDO_DTAENT = :DTAENT AND ';
    strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FDO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FDO_CODITE = :CODITE     ';

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  FDO_CODITE ';

    {*****************************************}
    {* DOCUMENTO DETALHADO                   *}
    {**************************************MV*}
    With qryGenDet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  I.ITE_DESITE, ';
    strSQL := strSQL + '  I.ITE_DESSIM, ';
    strSQL := strSQL + '  I.ITE_DESFAB, ';
    strSQL := strSQL + '  I.ITE_COMLUB, ';
    strSQL := strSQL + '  I.ITE_CLAIPI, ';
    strSQL := strSQL + '  I.ITE_EXCIPI, ';
    strSQL := strSQL + '  I.ITE_CODFAB, ';
    strSQL := strSQL + '  I.ITE_CODBAR, ';
    strSQL := strSQL + '  G.ITE_OUTVAL, ';
    strSQL := strSQL + '  G.ITE_IMPFED, ';
    strSQL := strSQL + '  G.ITE_ICMSAI, ';
    strSQL := strSQL + '  G.ITE_PRECUS, ';
    strSQL := strSQL + '  G.ITE_DESOPE, ';
    strSQL := strSQL + '  G.ITE_PREULT, ';
    strSQL := strSQL + '  G.ITE_IMPULT, ';
    strSQL := strSQL + '  G.ITE_QTDUCO, ';

    strSQL := strSQL + '  G.ITE_PREVE1, ';
    strSQL := strSQL + '  G.ITE_PREVE2, ';
    strSQL := strSQL + '  G.ITE_PREVE3, ';
    strSQL := strSQL + '  G.ITE_PREVE4, ';
    strSQL := strSQL + '  G.ITE_PREVE5, ';
    strSQL := strSQL + '  G.ITE_PREVE6, ';
    strSQL := strSQL + '  G.ITE_PREVE7, ';

    strSQL := strSQL + '  G.ITE_COMTB1, ';
    strSQL := strSQL + '  G.ITE_COMTB2, ';
    strSQL := strSQL + '  G.ITE_COMTB3, ';
    strSQL := strSQL + '  G.ITE_COMTB4, ';
    strSQL := strSQL + '  G.ITE_COMTB5, ';
    strSQL := strSQL + '  G.ITE_COMTB6, ';
    strSQL := strSQL + '  G.ITE_COMTB7, ';

    strSQL := strSQL + '  G.ITE_IPISAI, ';
    strSQL := strSQL + '  G.ITE_DESMAX, ';
    strSQL := strSQL + '  G.ITE_DESMGE, ';
    strSQL := strSQL + '  G.ITE_DESMSU, ';
    strSQL := strSQL + '  G.ITE_SALDOS, ';
    strSQL := strSQL + '  G.ITE_PREMED, ';
    strSQL := strSQL + '  G.ITE_COMVAR, ';
    strSQL := strSQL + '  G.ITE_COMATA, ';
    strSQL := strSQL + '  G.ITE_COMDIS, ';
    strSQL := strSQL + '  G.ITE_MARMIN, ';
    strSQL := strSQL + '  G.ITE_MARMSG, ';
    strSQL := strSQL + '  G.ITE_MARMGE, ';

    strSQL := strSQL + '  G.ITE_DESMVM, ';
    strSQL := strSQL + '  G.ITE_DESMSM, ';
    strSQL := strSQL + '  G.ITE_DESMGM, ';

    strSQL := strSQL + '  G.ITE_MARMMV, ';
    strSQL := strSQL + '  G.ITE_MARMMS, ';
    strSQL := strSQL + '  G.ITE_MARMMG, ';

    strSQL := strSQL + '  G.ITE_IPIENT, ';
    strSQL := strSQL + '  G.ITE_FREENT, ';
    strSQL := strSQL + '  G.ITE_LOCFIS, ';
    strSQL := strSQL + '  A.ABF_CODABF, ';
    strSQL := strSQL + '  I.ITE_PESLIQ, ';
    strSQL := strSQL + '  I.ITE_OBRCPF, ';
    strSQL := strSQL + '  G.ITE_PRECOM, ';

    If fCfgSis('IMPDIG') = '1' Then
      strSQL := strSQL + '  I.ITE_IMPDIR  '
    Else
      strSQL := strSQL + '  G.ITE_IMPDIR  ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I, ';
    strSQL := strSQL + '  ITEGER G, ';
    strSQL := strSQL + '  ABFICM A ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  I.ITE_CODITE = G.ITE_CODITE AND ';

    If fCfgSis('TIPABF') = '1' Then
      strSQL := strSQL + '  I.ITE_CODABF = A.ABF_CODABF AND '
    Else
      strSQL := strSQL + '  G.ITE_CODABF = A.ABF_CODABF AND ';

    strSQL := strSQL + '  I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  G.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  A.ABF_ESTADO = :ESTADO ';

    {*****************************************}
    {* PREPARA A QUERY PARA RETORNAR DADOS   *}
    {* DO ITEM E DA ABREVIAÇÃO FISCAL        *}
    {**************************************MV*}
    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
    End;

    Try

      With fatVenda.qryTemporariaConfirmacao Do
      Begin

        blnPegEndEnt := True;

        If fEmptyStr(fatVenda.strFasObr) Then
          fatVenda.strFasObr := FieldByName('TMP_FASOBR').AsString;

        If (blnPegEndEnt) Then
        Begin
          fatVenda.pCarregaEnderecoEntrega(fatVenda,
                                           FieldByName('TMP_NOMTAB').AsString,
                                           FieldByName('TMP_AUTINC').AsString,
                                           True);

          blnPegEndEnt := fEmptyStr(fatVenda.strEndEnt);

          If Not blnPegEndEnt Then
            fatVenda.blnEndEntConfDoc := True;
        End;

        {*****************************************}
        {* CARREGA DOCUMENTO DETALHADO           *}
        {**************************************MV*}
        qryGenDet.Close;
        //qryGenDet.ParamByName('DTAENT').AsDate   := FieldByName('TMP_DTAENT').AsDateTime;
        qryGenDet.ParamByName('NUMDOC').AsString := strNumDoc_PD;
        qryGenDet.ParamByName('ESPDOC').AsString := strEspDoc_PD;
        qryGenDet.ParamByName('CODEMP').AsString := strEmpDoc_PD;
        qryGenDet.ParamByName('CODITE').AsString := strItemConcreto;
        qryGenDet.Open;

        {Carrega dados do concreto}
        fatVenda.strPlaVei := qryGenDet.FieldByName('FGO_CCRPLA').AsString;
        fatVenda.strCodMot := qryGenDet.FieldByName('FGO_CCRMOT').AsString;
        fatVenda.strBetone := qryGenDet.FieldByName('FGO_CCRBET').AsString;
        fatVenda.strLacre_ := qryGenDet.FieldByName('FGO_CCRLAC').AsString;
        fatVenda.strConBom := qryGenDet.FieldByName('FGO_CCR_CB').AsString;
        fatVenda.strFckDia := qryGenDet.FieldByName('FGO_CCRFCK').AsString;
        fatVenda.strAbatim := qryGenDet.FieldByName('FGO_CCRABA').AsString;
        fatVenda.strTipMps := qryGenDet.FieldByName('FGO_CCRTIP').AsString;
        fatVenda.strBrita_ := qryGenDet.FieldByName('FGO_CCRBRI').AsString;
        fatVenda.strTipBom := qryGenDet.FieldByName('FGO_CCR_ML').AsString;
        fatVenda.fltQtdBom := qryGenDet.FieldByName('FGO_CCRQTD').AsFloat;
        fatVenda.fltPrcBom := qryGenDet.FieldByName('FGO_CCRVLR').AsFloat;
        fatVenda.fltTotBom := qryGenDet.FieldByName('FGO_CCRTOT').AsFloat;
        fatVenda.strCodObr := qryGenDet.FieldByName('FGO_CCROBR').AsString;
        fatVenda.strCodArt := qryGenDet.FieldByName('FGO_CCRART').AsString;
        fatVenda.strCodCno := qryGenDet.FieldByName('FGO_CODCNO').AsString;
        fatVenda.strInsImo := qryGenDet.FieldByName('FGO_INSIMO').AsString;
        fatVenda.strCodCib := qryGenDet.FieldByName('FGO_CODCIB').AsString;

        fatVenda.strVolCCR := FormatFloat('###,###,##0.00', qryGenDet.FieldByName('FDO_QTDITE').AsFloat);
        fatVenda.strIteCCR := qryGenDet.FieldByName('FDO_DESCRI').AsString + ' - R$ ' + FormatFloat('###,###,##0.00', qryGenDet.FieldByName('FDO_VLRCON').AsFloat);

        qryGenDet.First;

        While (Not qryGenDet.Eof) Do
        Begin
          If (StrToInt(LeftStr(qryGenDet.FieldByName('FDO_CLAFIS').AsString, 1)) < 5) Then
          Begin
            Raise Exception.Create('Classificação fiscal menor que 5000. Favor verificar.');
          End;

          If (strItemAnt <> qryGenDet.FieldByName('FDO_CODITE').AsString) Then
          Begin

            {*****************************************}
            {* CARREGA ITEM                          *}
            {**************************************MV*}
            qryGenIte.Close;
            qryGenIte.ParamByName('CODITE').AsString := qryGenDet.FieldByName('FDO_CODITE').AsString;
            qryGenIte.ParamByName('CODEMP').AsString := qryGenDet.FieldByName('FDO_CODEMP').AsString;
            qryGenIte.ParamByName('ESTADO').AsString := qryGenDet.FieldByName('FDO_ESTADO').AsString;
            qryGenIte.Open;

            strItemAnt  := qryGenDet.FieldByName('FDO_CODITE').AsString;
          End;

          fltCusIte := qryGenDet.FieldByName('FDO_TOTCUS').AsFloat / qryGenDet.FieldByName('FDO_QTDITE').AsFloat;

          fatVenda.pAdicionaRegistroTemporaria( cdsVenda,
                                                Nil,
                                                qryGenDet.FieldByName('FDO_IDEPRO').AsString,
                                                qryGenDet.FieldByName('ITE_CODGRU').AsString,
                                                qryGenDet.FieldByName('FDO_CODITE').AsString,
                                                qryGenDet.FieldByName('FDO_DESCRI').AsString,
                                                qryGenDet.FieldByName('FDO_DESCRI').AsString,
                                                qryGenIte.FieldByName('ITE_DESFAB').AsString,
                                                qryGenDet.FieldByName('FDO_UNIDAD').AsString,
                                                qryGenDet.FieldByName('FDO_UNIDAD').AsString,
                                                qryGenDet.FieldByName('FDO_CODMAR').AsString,
                                                qryGenDet.FieldByName('FDO_FORITE').AsString,
                                                qryGenDet.FieldByName('FDO_REFERE').AsString,
                                                qryGenDet.FieldByName('FDO_UNIORI').AsFloat,
                                                qryGenDet.FieldByName('FDO_UNIVIS').AsFloat,
                                                qryGenDet.FieldByName('FDO_UNITAR').AsFloat,
                                                qryGenDet.FieldByName('FDO_UNITAR').AsFloat,
                                                qryGenDet.FieldByName('FDO_DESCON').AsFloat,
                                                qryGenDet.FieldByName('FDO_QTDITE').AsFloat,
                                                qryGenDet.FieldByName('FDO_TOTITE').AsFloat,
                                                'S',
                                                qryGenDet.FieldByName('FDO_TOTCUS').AsFloat / qryGenDet.FieldByName('FDO_QTDITE').AsFloat,
                                                qryGenDet.FieldByName('FDO_TOTCUS').AsFloat,
                                                qryGenIte.FieldByName('ITE_COMLUB').AsString,
                                                qryGenIte.FieldByName('ITE_IPISAI').AsFloat,
                                                qryGenIte.FieldByName('ITE_DESMAX').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE1').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE2').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE3').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE4').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE5').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE6').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREVE7').AsFloat,

                                                fCalculaPrecoVenda(2, fltCusIte + fatVenda.fRetOutVal(qryGenIte.FieldByName('ITE_OUTVAL').AsFloat),
                                                                      qryGenDet.FieldByName('FDO_UNITAR').AsFloat,
                                                                      0,
                                                                      fatVenda.fRetIcmSai(qryGenIte.FieldByName('ITE_ICMSAI').AsFloat),
                                                                      fatVenda.fRetImpFed(qryGenIte.FieldByName('ITE_IMPFED').AsFloat),
                                                                      fatVenda.fRetDesOpe(qryGenIte.FieldByName('ITE_DESOPE').AsFloat),
                                                                      qryGenIte.FieldByName('ITE_COMTB' +
                                                                        IIF(fEmptyStr(qryGenDet.FieldByName('FDO_TABPRE').AsString), '1',
                                                                          qryGenDet.FieldByName('FDO_TABPRE').AsString)).AsFloat, fatVenda.VS_strMARMKP),

                                                qryGenIte.FieldByName('ITE_SALDOS').AsFloat,
                                                qryGenDet.FieldByName('FDO_INCPIS').AsString,
                                                qryGenIte.FieldByName('ITE_COMVAR').AsFloat,
                                                qryGenIte.FieldByName('ITE_COMATA').AsFloat,
                                                qryGenIte.FieldByName('ITE_COMDIS').AsFloat,
                                                '',
                                                '',
                                                '',
                                                0.0,
                                                0.0,
                                                '',
                                                qryGenIte.FieldByName('ITE_PREULT').AsFloat * qryGenDet.FieldByName('FDO_QTDITE').AsFloat,
                                                qryGenIte.FieldByName('ITE_IMPULT').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREULT').AsFloat,
                                                qryGenIte.FieldByName('ITE_PREMED').AsFloat,
                                                qryGenIte.FieldByName('ITE_CLAIPI').AsString,
                                                '',
                                                '', //qryGenDet.FieldByName('DET_ITETIN').AsString,  //CODIGO DA TINTA
                                                '',
                                                '',
                                                0,
                                                '',
                                                qryGenDet.FieldByName('FDO_QTDEMB').AsFloat,
                                                qryGenDet.FieldByName('FDO_PREEMB').AsFloat,
                                                0.0,
                                                0.0,
                                                0.0,
                                                'N',
                                                '',
                                                0,
                                                0,
                                                qryGenIte.FieldByName('ABF_CODABF').AsString,
                                                qryGenDet.FieldByName('FDO_TOTPES').AsFloat / qryGenDet.FieldByName('FDO_QTDITE').AsFloat,
                                                qryGenIte.FieldByName('ITE_PESLIQ').AsFloat,
                                                qryGenDet.FieldByName('FDO_PROMOC').AsString,
                                                0.0,
                                                0.0,
                                                0.0,
                                                0.0,
                                                IIF(fEmptyStr(qryGenDet.FieldByName('FDO_SEQTIN').AsString), '', '2'),
                                                0.0,
                                                qryGenIte.FieldByName('ITE_CODFAB').AsString,
                                                -1,
                                                0.0,
                                                '',
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_MARMIN').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMSG').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMGE').AsFloat,
                                                FatVenda.strDesMar,
                                                fatVenda.strStatus,
                                                0.0,
                                                0.0,
                                                '', //qryGenDet.FieldByName('AUTOINCREM').AsString,
                                                '',
                                                '',
                                                0.0,
                                                '',
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_PRECOM').AsFloat,
                                                qryGenDet.FieldByName('FDO_UNITAR').AsFloat,
                                                0.0, //qryGenDet.FieldByName('DET_QTDPON').AsFloat,
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_OBRCPF').AsString,
                                                '',
                                                '',
                                                fRetSiglaUnidade(qryGenDet.FieldByName('FDO_UNIDAD').AsString),
                                                0.0,
                                                fatVenda.fOrdemItem(cdsVenda,'Adiciona',nil),
                                                '',
                                                qryGenDet.FieldByName('FDO_CODACA').AsString,
                                                qryGenDet.FieldByName('FDO_EMPACA').AsString,
                                                False,
                                                '',
                                                '',
                                                '',
                                                fatVenda.fRetOutVal(qryGenIte.FieldByName('ITE_OUTVAL').AsFloat),
                                                qryGenIte.FieldByName('ITE_COMTB' +
                                                  IIF(fEmptyStr(qryGenDet.FieldByName('FDO_TABPRE').AsString), '1',
                                                                qryGenDet.FieldByName('FDO_TABPRE').AsString) ).AsFloat,
                                                fatVenda.fRetDesOpe(qryGenIte.FieldByName('ITE_DESOPE').AsFloat),
                                                fatVenda.fRetIcmSai(qryGenIte.FieldByName('ITE_ICMSAI').AsFloat),
                                                fatVenda.fRetImpFed(qryGenIte.FieldByName('ITE_IMPFED').AsFloat),
                                                qryGenIte.FieldByName('ITE_DESMGE').AsFloat,
                                                qryGenDet.FieldByName('FDO_NUMDOC').AsString,
                                                qryGenDet.FieldByName('FDO_ESPDOC').AsString,
                                                qryGenDet.FieldByName('FDO_CODEMP').AsString,
                                                qryGenDet.FieldByName('FDO_TABPRE').AsString,
                                                qryGenIte.FieldByName('ITE_IPIENT').AsFloat,
                                                qryGenIte.FieldByName('ITE_FREENT').AsFloat,
                                                '',
                                                0.0,
                                                '',
                                                0.0,
                                                '',
                                                '',
                                                'N',
                                                '',
                                                0,
                                                qryGenDet.FieldByName('FDO_QTDITE').AsFloat,
                                                0,
                                                0,
                                                qryGenIte.FieldByName('ITE_IMPDIR').AsString,
                                                qryGenIte.FieldByName('ITE_LOCFIS').AsString,

                                                qryGenDet.FieldByName('FDO_TOTCU2').AsFloat / qryGenDet.FieldByName('FDO_QTDITE').AsFloat,
                                                qryGenDet.FieldByName('FDO_TOTCU2').AsFloat,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                recForTin,
                                                '',
                                                '',
                                                qryGenDet.FieldByName('FDO_NUMLOT').AsString,
                                                '',
                                                qryGenDet.FieldByName('FDO_CODVEN').AsString,
                                                False,
                                                'N',
                                                'NOR',
                                                0,
                                                '',
                                                qryGenIte.FieldByName('ITE_CODBAR').AsString,
                                                '',
                                                0,
                                                0,
                                                0,
                                                '',
                                                1,
                                                True,
                                                '',
                                                '',
                                                '',
                                                0,
                                                fltCusIte,
                                                qryGenIte.FieldByName('ITE_DESSIM').AsString,
                                                '',
                                                recMadeira,
                                                qryGenIte.FieldByName('ITE_IMPULT').AsFloat * qryGenDet.FieldByName('FDO_QTDITE').AsFloat,
                                                qryGenDet.FieldByName('FDO_VAL_RT').AsFloat,
                                                qryGenDet.FieldByName('FDO_TAXJUR').AsFloat,
                                                '',
                                                0,
                                                '',
                                                '',
                                                0,
                                                0,
                                                '',
                                                '',
                                                0,
                                                '',
                                                'N',
                                                0,
                                                0,
                                                0,
                                                False,
                                                False,
                                                'N',
                                                '',
                                                0,//qryGenDet.FieldByName('DET_SEQCCR').AsInteger,
                                                0,
                                                '',
                                                'N',
                                                0,
                                                '',
                                                '',
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_EXCIPI').AsString,
                                                qryGenIte.FieldByName('ITE_DESMSU').AsFloat,
                                                '',
                                                '',
                                                '',
                                                'S',
                                                'N',
                                                '',
                                                '',
                                                '',
                                                '',
                                                False,
                                                -1,
                                                -1,
                                                'N',
                                                '',
                                                'N',
                                                0,
                                                0,
                                                0,
                                                '',
                                                0,
                                                0,
                                                0,
                                                '',
                                                0,
                                                0,
                                                0,
                                                '',
                                                '',
                                                0,
                                                0,
                                                0,
                                                False,
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                '',
                                                '',
                                                0,
                                                0,
                                                '',
                                                '',
                                                'N',
                                                'N',
                                                '',
                                                0,
                                                0,
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                '',
                                                qryGenIte.FieldByName('ITE_DESMVM').AsFloat,
                                                qryGenIte.FieldByName('ITE_DESMSM').AsFloat,
                                                qryGenIte.FieldByName('ITE_DESMGM').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMMV').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMMS').AsFloat,
                                                qryGenIte.FieldByName('ITE_MARMMG').AsFloat);

          qryGenDet.Next;

          Application.ProcessMessages;

        End;

        Result := True;

      End;

    Except

      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '');
      End;

    End;

  Finally
    FreeAndNil(qryGenIte);
    FreeAndNil(qryGenDet);
  End;

end;

function TConfirmacaoNotaConcreto.fDocumentoAConfirmarTeveOrigemEmPedidoDeConcreto(strNumDoc, strEspDoc, strEmpDoc : String; Out strNumDoc_PD, strEspDoc_PD, strEmpDoc_PD, strItemConcreto : String) : Boolean;
var
  qryCCR : TUniQuery;
const
  SQL_PEDIDO = 'SELECT           ' +
               '  G.FGO_NUMDOC,  ' +
               '  G.FGO_ESPDOC,  ' +
               '  G.FGO_CODEMP,  ' +
               '  D.FDO_CODITE   ' +
               'FROM             ' +
               '  FATGOR G       ' +
               '  INNER JOIN FATDOR D ON (D.FDO_SEQGER = G.AUTOINCREM) ' +
               'WHERE          ' +
               '  G.FGO_NUMFAT  = :NUMFAT AND ' +
               '  G.FGO_TIPFAT  = :TIPFAT AND ' +
               '  G.FGO_EMPFAT  = :EMPFAT AND ' +
               '  D.FDO_CODITE <> :ITEMAN AND ' +
               '  D.FDO_CODITE <> :ITELAN AND ' +
               '  D.FDO_CODITE <> :ITETAX     ';

begin

  Result := False;

  If strNumDoc.IsEmpty Then
    Exit;

  If strEspDoc.IsEmpty Then
    Exit;

  If strEmpDoc.IsEmpty Then
    Exit;

  qryCCR := fCriaQuery(Self);

  Try

    qryCCR.Close;
    qryCCR.SQL.Add(SQL_PEDIDO);
    qryCCR.ParamByName('NUMFAT').AsString := strNumDoc;
    qryCCR.ParamByName('TIPFAT').AsString := strEspDoc;
    qryCCR.ParamByName('EMPFAT').AsString := strEmpDoc;

    qryCCR.ParamByName('ITEMAN').AsString := fCfgSis('ITEMAN', varString);
    qryCCR.ParamByName('ITELAN').AsString := fCfgSis('ITELAN', varString);
    qryCCR.ParamByName('ITETAX').AsString := fCfgSis('ITETAX', varString);
    qryCCR.Open;

    {Terá apenas 1 estrutura de concreto}
    If (Not qryCCR.IsEmpty) And (qryCCR.RecordCount = 1) Then
      Result := fItemConcreto(qryCCR.FieldByName('FDO_CODITE').AsString);

    If (Result) Then
    Begin

      strNumDoc_PD := qryCCR.FieldByName('FGO_NUMDOC').AsString;
      strEspDoc_PD := qryCCR.FieldByName('FGO_ESPDOC').AsString;
      strEmpDoc_PD := qryCCR.FieldByName('FGO_CODEMP').AsString;

      strItemConcreto := qryCCR.FieldByName('FDO_CODITE').AsString;

    End;

  Finally
    FreeAndNil(qryCCR);
  End;

end;

function TConfirmacaoNotaConcreto.fFinalizarCarregamento: Boolean;
var
  blnDecidiuEndereco : Boolean;
begin

  Result := True;

  Try

    fatVenda.pPreencheMatrizFechamento;

    If (fatVenda.blnEndEntConfDoc) Then
    Begin
      blnDecidiuEndereco := False;
      Repeat
        If (Not fatVenda.fAlteraEnderecoEntrega(False, True, True, True, True)) Then
        Begin
          If fMensagem('', 'Nenhum Endereço de Entrega foi Informado, Continuar?', ['&Sim', '&Não']) = 1 Then
          Begin
            fatVenda.blnEndEntConfDoc := False;
            fatVenda.pLimparEnderecoEntrega;
            fatVenda.pEnderecoToFatVenda;
            blnDecidiuEndereco := True;

            If fatVenda.fAtendeRegraFiscalEndEntrega Then
              fatVenda.pPreencheMatrizFechamento;
          End;
        End
        Else blnDecidiuEndereco := True;
      Until (blnDecidiuEndereco = True);
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      fMensagem('', E.Message, ['&O K']);
      Result := False;
      Exit;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
      Exit;
    End;
  End;

  fatVenda.pCalculaTotGer;

end;

function TConfirmacaoNotaConcreto.fMostraProdutosConfirmacao: Boolean;
  Var
    cdsItens : TUniClientDataSet;
    dtsGenDet: TDataSource;
    frmFatMostraProdConfirmacao : TfrmFatMostraProdConfirmacao;
begin
  cdsItens  := TUniClientDataSet.Create(Self);
  dtsGenDet := fCriaDataSource(cdsItens);

  {*****************************************}
  {* MOSTRA ITENS DA CONFIRMAÇÃO           *}
  {**************************************MV*}
  pCloneDataSet(cdsItens, cdsVenda);

  With cdsItens Do
  Begin
    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';
  End;

  Try
    pCriarFormularios(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);
    frmFatMostraProdConfirmacao.dbgItens.DataSource := dtsGenDet;
    frmFatMostraProdConfirmacao.edtTotSer.Text      := FormatFloat('#,##0.00', 0.00);
    frmFatMostraProdConfirmacao.edtTotGer.Text      := FormatFloat('#,##0.00', fatVenda.fltTotPro);
    frmFatMostraProdConfirmacao.edtDesEsp.Text      := FormatFloat('#,##0.00', 0.00);
    frmFatMostraProdConfirmacao.edtTotLiq.Text      := FormatFloat('#,##0.00', fatVenda.fltTotPro);
    frmFatMostraProdConfirmacao.pExibirNovosImpostos(fatVenda.fltTotCBS, fatVenda.fltTotIBS, fatVenda.fltTotIS);
    frmFatMostraProdConfirmacao.btnConfirma.Visible := True;
    frmFatMostraProdConfirmacao.Caption             := 'Itens da Confirmação de Nota de Concreto';
    frmFatMostraProdConfirmacao.showModal;

    Result := frmFatMostraProdConfirmacao.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmFatMostraProdConfirmacao);
  FreeAndNil(cdsItens);
end;

procedure TConfirmacaoNotaConcreto.pDeletaTemporariaConfirmacao;
begin

  If (Not fTabelaExiste(fatVenda.strTabelaConfMi)) Then
    Exit;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('DELETE FROM ' + fatVenda.strTabelaConfMi);
    ExecSQL;
    Close;
  End;

end;

procedure TConfirmacaoNotaConcreto.pAtualizaTemporariaConfirmacao;
  Var
    strSQL: String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + fatVenda.strTabelaConfMi;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    (FieldByName('TMP_VLRCON') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('TMP_DUPREC') As TFloatField).DisplayFormat := '#,##0.00';
  End;

end;

procedure TConfirmacaoNotaConcreto.pCriaTemporariaConfirmacao;
  Var
    strSQL   : String;
    intQtdIte: Integer;
    qryGenGer: TUniQuery;
begin
  qryGenGer := fCriaQuery(Self);

  pDeletaTemporariaConfirmacao;

  {******************************************}
  {* PEGA TODOS AS NOTAS NÃO BAIXADAS       *}
  {***************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  GER_NOTESP,';
  strSQL := strSQL + '  GER_NUMDOC, ';
  strSQL := strSQL + '  GER_ESPDOC, ';
  strSQL := strSQL + '  GER_DTAENT, ';
  strSQL := strSQL + '  GER_JAFATU, ';
  strSQL := strSQL + '  GER_CODVEN, ';
  strSQL := strSQL + '  GER_CODCLI, ';
  strSQL := strSQL + '  GER_DESESP, ';
  strSQL := strSQL + '  GER_VLRCON, ';

  strSQL := strSQL + '  GER_CODS01, ';
  strSQL := strSQL + '  GER_CODS02, ';
  strSQL := strSQL + '  GER_CODS03, ';
  strSQL := strSQL + '  GER_CODS04, ';
  strSQL := strSQL + '  GER_CODS05, ';
  strSQL := strSQL + '  GER_CODS06, ';
  strSQL := strSQL + '  GER_CODS07, ';
  strSQL := strSQL + '  GER_CODS08, ';
  strSQL := strSQL + '  GER_CODS09, ';
  strSQL := strSQL + '  GER_CODS10, ';
  strSQL := strSQL + '  GER_CODS11, ';
  strSQL := strSQL + '  GER_CODS12, ';
  strSQL := strSQL + '  GER_CODS13, ';
  strSQL := strSQL + '  GER_CODS14, ';
  strSQL := strSQL + '  GER_CODS15, ';
  strSQL := strSQL + '  GER_CODS16, ';
  strSQL := strSQL + '  GER_CODS17, ';
  strSQL := strSQL + '  GER_CODS18, ';
  strSQL := strSQL + '  GER_CODS19, ';
  strSQL := strSQL + '  GER_CODS20, ';
  strSQL := strSQL + '  GER_CODS21, ';
  strSQL := strSQL + '  GER_CODS22, ';
  strSQL := strSQL + '  GER_CODS23, ';
  strSQL := strSQL + '  GER_CODS24, ';
  strSQL := strSQL + '  GER_CODS25, ';
  strSQL := strSQL + '  GER_CODS26, ';
  strSQL := strSQL + '  GER_CODS27, ';
  strSQL := strSQL + '  GER_CODS28, ';
  strSQL := strSQL + '  GER_CODS29, ';
  strSQL := strSQL + '  GER_CODS30, ';

  strSQL := strSQL + '  GER_DESS01, ';
  strSQL := strSQL + '  GER_DESS02, ';
  strSQL := strSQL + '  GER_DESS03, ';
  strSQL := strSQL + '  GER_DESS04, ';
  strSQL := strSQL + '  GER_DESS05, ';
  strSQL := strSQL + '  GER_DESS06, ';
  strSQL := strSQL + '  GER_DESS07, ';
  strSQL := strSQL + '  GER_DESS08, ';
  strSQL := strSQL + '  GER_DESS09, ';
  strSQL := strSQL + '  GER_DESS10, ';
  strSQL := strSQL + '  GER_DESS11, ';
  strSQL := strSQL + '  GER_DESS12, ';
  strSQL := strSQL + '  GER_DESS13, ';
  strSQL := strSQL + '  GER_DESS14, ';
  strSQL := strSQL + '  GER_DESS15, ';
  strSQL := strSQL + '  GER_DESS16, ';
  strSQL := strSQL + '  GER_DESS17, ';
  strSQL := strSQL + '  GER_DESS18, ';
  strSQL := strSQL + '  GER_DESS19, ';
  strSQL := strSQL + '  GER_DESS20, ';
  strSQL := strSQL + '  GER_DESS21, ';
  strSQL := strSQL + '  GER_DESS22, ';
  strSQL := strSQL + '  GER_DESS23, ';
  strSQL := strSQL + '  GER_DESS24, ';
  strSQL := strSQL + '  GER_DESS25, ';
  strSQL := strSQL + '  GER_DESS26, ';
  strSQL := strSQL + '  GER_DESS27, ';
  strSQL := strSQL + '  GER_DESS28, ';
  strSQL := strSQL + '  GER_DESS29, ';
  strSQL := strSQL + '  GER_DESS30, ';

  strSQL := strSQL + '  GER_QTDS01, ';
  strSQL := strSQL + '  GER_QTDS02, ';
  strSQL := strSQL + '  GER_QTDS03, ';
  strSQL := strSQL + '  GER_QTDS04, ';
  strSQL := strSQL + '  GER_QTDS05, ';
  strSQL := strSQL + '  GER_QTDS06, ';
  strSQL := strSQL + '  GER_QTDS07, ';
  strSQL := strSQL + '  GER_QTDS08, ';
  strSQL := strSQL + '  GER_QTDS09, ';
  strSQL := strSQL + '  GER_QTDS10, ';
  strSQL := strSQL + '  GER_QTDS11, ';
  strSQL := strSQL + '  GER_QTDS12, ';
  strSQL := strSQL + '  GER_QTDS13, ';
  strSQL := strSQL + '  GER_QTDS14, ';
  strSQL := strSQL + '  GER_QTDS15, ';
  strSQL := strSQL + '  GER_QTDS16, ';
  strSQL := strSQL + '  GER_QTDS17, ';
  strSQL := strSQL + '  GER_QTDS18, ';
  strSQL := strSQL + '  GER_QTDS19, ';
  strSQL := strSQL + '  GER_QTDS20, ';
  strSQL := strSQL + '  GER_QTDS21, ';
  strSQL := strSQL + '  GER_QTDS22, ';
  strSQL := strSQL + '  GER_QTDS23, ';
  strSQL := strSQL + '  GER_QTDS24, ';
  strSQL := strSQL + '  GER_QTDS25, ';
  strSQL := strSQL + '  GER_QTDS26, ';
  strSQL := strSQL + '  GER_QTDS27, ';
  strSQL := strSQL + '  GER_QTDS28, ';
  strSQL := strSQL + '  GER_QTDS29, ';
  strSQL := strSQL + '  GER_QTDS30, ';

  strSQL := strSQL + '  GER_UNIS01, ';
  strSQL := strSQL + '  GER_UNIS02, ';
  strSQL := strSQL + '  GER_UNIS03, ';
  strSQL := strSQL + '  GER_UNIS04, ';
  strSQL := strSQL + '  GER_UNIS05, ';
  strSQL := strSQL + '  GER_UNIS06, ';
  strSQL := strSQL + '  GER_UNIS07, ';
  strSQL := strSQL + '  GER_UNIS08, ';
  strSQL := strSQL + '  GER_UNIS09, ';
  strSQL := strSQL + '  GER_UNIS10, ';
  strSQL := strSQL + '  GER_UNIS11, ';
  strSQL := strSQL + '  GER_UNIS12, ';
  strSQL := strSQL + '  GER_UNIS13, ';
  strSQL := strSQL + '  GER_UNIS14, ';
  strSQL := strSQL + '  GER_UNIS15, ';
  strSQL := strSQL + '  GER_UNIS16, ';
  strSQL := strSQL + '  GER_UNIS17, ';
  strSQL := strSQL + '  GER_UNIS18, ';
  strSQL := strSQL + '  GER_UNIS19, ';
  strSQL := strSQL + '  GER_UNIS20, ';
  strSQL := strSQL + '  GER_UNIS21, ';
  strSQL := strSQL + '  GER_UNIS22, ';
  strSQL := strSQL + '  GER_UNIS23, ';
  strSQL := strSQL + '  GER_UNIS24, ';
  strSQL := strSQL + '  GER_UNIS25, ';
  strSQL := strSQL + '  GER_UNIS26, ';
  strSQL := strSQL + '  GER_UNIS27, ';
  strSQL := strSQL + '  GER_UNIS28, ';
  strSQL := strSQL + '  GER_UNIS29, ';
  strSQL := strSQL + '  GER_UNIS30, ';

  strSQL := strSQL + '  GER_VALS01, ';
  strSQL := strSQL + '  GER_VALS02, ';
  strSQL := strSQL + '  GER_VALS03, ';
  strSQL := strSQL + '  GER_VALS04, ';
  strSQL := strSQL + '  GER_VALS05, ';
  strSQL := strSQL + '  GER_VALS06, ';
  strSQL := strSQL + '  GER_VALS07, ';
  strSQL := strSQL + '  GER_VALS08, ';
  strSQL := strSQL + '  GER_VALS09, ';
  strSQL := strSQL + '  GER_VALS10, ';
  strSQL := strSQL + '  GER_VALS11, ';
  strSQL := strSQL + '  GER_VALS12, ';
  strSQL := strSQL + '  GER_VALS13, ';
  strSQL := strSQL + '  GER_VALS14, ';
  strSQL := strSQL + '  GER_VALS15, ';
  strSQL := strSQL + '  GER_VALS16, ';
  strSQL := strSQL + '  GER_VALS17, ';
  strSQL := strSQL + '  GER_VALS18, ';
  strSQL := strSQL + '  GER_VALS19, ';
  strSQL := strSQL + '  GER_VALS20, ';
  strSQL := strSQL + '  GER_VALS21, ';
  strSQL := strSQL + '  GER_VALS22, ';
  strSQL := strSQL + '  GER_VALS23, ';
  strSQL := strSQL + '  GER_VALS24, ';
  strSQL := strSQL + '  GER_VALS25, ';
  strSQL := strSQL + '  GER_VALS26, ';
  strSQL := strSQL + '  GER_VALS27, ';
  strSQL := strSQL + '  GER_VALS28, ';
  strSQL := strSQL + '  GER_VALS29, ';
  strSQL := strSQL + '  GER_VALS30, ';

  strSQL := strSQL + '  GER_MEN001, ';
  strSQL := strSQL + '  GER_MEN002, ';
  strSQL := strSQL + '  GER_TIPFRE, ';
  strSQL := strSQL + '  "MOVGER" AS GER_TABELA, ';
  strSQL := strSQL + '  G.AUTOINCREM AS GER_AUTINC, ';
  strSQL := strSQL + '  GER_CLAFIS, ';
  strSQL := strSQL + '  GER_CODCND, ';
  strSQL := strSQL + '  GER_CONPAG, ';
  strSQL := strSQL + '  GER_CODFPG, ';
  strSQL := strSQL + '  GER_CODEMP, ';

  strSQL := strSQL + '  AUX_FASOBR AS GER_FASOBR, ';

  strSQL := strSQL + '  (SELECT  ';
  strSQL := strSQL + '     GROUP_CONCAT(DISTINCT DET_NUM_PD, DET_ESP_PD, DET_EMP_PD) ';
  strSQL := strSQL + '   FROM       ';
  strSQL := strSQL + '     MOVDET D ';
  strSQL := strSQL + '   WHERE      ';
  strSQL := strSQL + '     D.DET_SEQGER = G.AUTOINCREM) AS GER_PEDVEN, ';

  strSQL := strSQL + '  IFNULL(AUX_VALCRE, 0) AS GER_VALCRE ';
  strSQL := strSQL + 'FROM ';

  strSQL := strSQL + '  MOVGER G ';

  strSQL := strSQL + '  LEFT JOIN AUXMOV ON G.AUTOINCREM = AUX_SEQGER ';
  strSQL := strSQL + '  LEFT JOIN SERMOV ON G.AUTOINCREM = GER_SEQGER ';  

  strSQL := strSQL + 'WHERE ';

  If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND '
  Else
  Begin
    strSQL := strSQL + '  GER_CODCLI = :CLIFIL AND ';
    strSQL := strSQL + '  AUX_CLIORI = :CODCLI AND ';
  End;

  strSQL := strSQL + '  GER_JAFATU = 0       AND  ';

  If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
    strSQL := strSQL + '  AUX_OPCDOC IN ("VN","EI","11") AND ' //Venda Normal (Prestcon) ou Expedicao (SECOL) ou F11 Caixa (J.A MASSA E CONCRETO)
  Else
    strSQL := strSQL + '  AUX_OPCDOC IN ("VN","EI") AND '; //Venda Normal (Prestcon) ou Expedicao (SECOL)

  strSQL := strSQL + '  GER_ESPDOC = "NF"    AND ';
  strSQL := strSQL + '  GER_NOTESP <> "S"    AND ';
  strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  RIGHT(GER_CLAFIS, 3) = "949" ';

  If Not fEmptyStr(strNumeroNota) Then
    strSQL := strSQL + '  AND GER_NUMDOC = :NUMDOC ';

  If dtaDataFinal > 0 Then
    strSQL := strSQL + '  AND GER_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSQL := strSQL + 'ORDER BY ';

  If (MatchStr(fCfgSis('TPNFCR'), [SECOL, J_A_MASSA_CONCRETO])) Then
    strSQL := strSQL + '  GER_PEDVEN '
  Else
    strSQL := strSQL + '  GER_NUMDOC, GER_ESPDOC ';

  With qryGenGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(strNumeroNota) Then
      ParamByName('NUMDOC').AsString := strNumeroNota;

    If (fCfgSis('TPNFCR') = J_A_MASSA_CONCRETO) Then
      ParamByName('CODCLI').AsString := strCodigoCliente
    Else
    Begin
      ParamByName('CLIFIL').AsString := fRetornaClienteFilial(VS_strCodEmp);
      ParamByName('CODCLI').AsString := strCodigoCliente;
    End;

    If dtaDataFinal > 0 Then
    Begin
      ParamByName('DTAINI').AsDateTime := dtaDataInicial;
      ParamByName('DTAFIN').AsDateTime := dtaDataFinal;
    End;

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;
  End;

  pAtualizaTemporariaConfirmacao;

  With qryGenGer Do
  Begin

    {*****************************************}
    {* PROCESSA MOVGER                       *}
    {**************************************MV*}
    While Not Eof Do
    Begin
      intQtdIte := fCampoTabela('COUNT(*)', 'MOVDET', ['DET_SEQGER'], [FieldByName('GER_AUTINC').AsString]);

      {*****************************************}
      {* INSERE REGISTRO NA TEMPORARIA         *}
      {**************************************MV*}
      fatVenda.qryTemporariaConfirmacao.Append;

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VALCRE').AsFloat    := FieldByName('GER_VALCRE').AsFloat;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOTESP').AsString   := IIF(FieldByName('GER_NOTESP').AsString = 'S', 'S', 'N');
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DTAENT').AsDateTime := FieldByName('GER_DTAENT').AsDateTime;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString   := FieldByName('GER_NUMDOC').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString   := FieldByName('GER_ESPDOC').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODEMP').AsString   := VS_strCodEmp;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODVEN').AsString   := FieldByName('GER_CODVEN').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString   := FieldByName('GER_CODCLI').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_VLRCON').AsFloat    := FieldByName('GER_VLRCON').AsFloat;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DESESP').AsFloat    := FieldByName('GER_DESESP').AsFloat;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ITEDOC').AsInteger  := intQtdIte;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DUPREC').AsFloat    := 0.00;

      If FieldByName('GER_JAFATU').DataType = ftInteger Then
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DOCQUI').AsString   := IIF(FieldByName('GER_JAFATU').AsInteger = 1, 'S', 'N')
      else
        fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_DOCQUI').AsString   := IIF(FieldByName('GER_JAFATU').AsBoolean = True, 'S', 'N');

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_FASOBR').AsString   := FieldByName('GER_FASOBR').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_MARDES').AsString   := 'D';
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TIPFRE').AsString   := FieldByName('GER_TIPFRE').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCND').AsString   := FieldByName('GER_CODCND').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').AsString   := FieldByName('GER_CONPAG').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODFPG').AsString   := FieldByName('GER_CODFPG').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NOMTAB').AsString   := FieldByName('GER_TABELA').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_AUTINC').AsString   := FieldByName('GER_AUTINC').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CLAFIS').AsString   := FieldByName('GER_CLAFIS').AsString;
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_TEMCCR').AsString   := 'S';

      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUM_PD').AsString   := MidStr(FieldByName('GER_PEDVEN').AsString, 1, 12);
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESP_PD').AsString   := MidStr(FieldByName('GER_PEDVEN').AsString, 13, 2);
      fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_EMP_PD').AsString   := MidStr(FieldByName('GER_PEDVEN').AsString, 15, 3);
      fatVenda.qryTemporariaConfirmacao.Post;

      Next;

    End;
    fatVenda.qryTemporariaConfirmacao.First;

  End;

  qryGenGer.Close;

  FreeAndNil(qryGenGer);

  pCalculaTotais;

end;

procedure TConfirmacaoNotaConcreto.pExibirProdutosDocumento;
  Var
    strSQL: String;
    fltTotGer: Double;
    qryGenDet: TUniQuery;
    dtsGenDet: TDataSource;
    frmFatMostraProdConfirmacao : TfrmFatMostraProdConfirmacao;
begin
  qryGenDet := fCriaQuery(Self);
  dtsGenDet := fCriaDataSource(qryGenDet);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DET_CODITE AS ITE_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI AS ITE_DESITE, ';
  strSQL := strSQL + '  DET_UNIDAD AS ITE_UNIDAD, ';
  strSQL := strSQL + '  DET_QTDITE AS ITE_QTDITE, ';
  strSQL := strSQL + '  DET_UNITAR AS ITE_UNITAR, ';
  strSQL := strSQL + '  DET_TOTITE AS ITE_TOTITE, ';
  strSQL := strSQL + '  DET_DESESP AS ITE_DESESP, ';
  strSQL := strSQL + '  DET_CLAFIS AS ITE_CLAFIS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_JAFATU = FALSE   AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP     ';

  With qryGenDet Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
    ParamByName('CODCLI').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCLI').AsString;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    (FieldByName('ITE_QTDITE') As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('ITE_UNITAR') As TFloatField).DisplayFormat := '#,####0.0000';
    (FieldByName('ITE_TOTITE') As TFloatField).DisplayFormat := '#,##0.00';

    fltTotGer := 0;
    
    While Not Eof Do
    Begin
      fltTotGer := fltTotGer + FieldByName('ITE_TOTITE').AsFloat;
      Next;
    End;

    First;

    Try
      pCriarFormularios(TfrmFatMostraProdConfirmacao, frmFatMostraProdConfirmacao);
      frmFatMostraProdConfirmacao.dbgItens.DataSource := dtsGenDet;
      frmFatMostraProdConfirmacao.edtTotSer.Text      := FormatFloat('#,##0.00', 0.00);
      frmFatMostraProdConfirmacao.edtTotGer.Text      := FormatFloat('#,##0.00', fltTotGer);
      frmFatMostraProdConfirmacao.edtDesEsp.Text      := FormatFloat('#,##0.00', 0.00);
      frmFatMostraProdConfirmacao.edtTotLiq.Text      := FormatFloat('#,##0.00', fltTotGer);
      frmFatMostraProdConfirmacao.Caption             := frmFatMostraProdConfirmacao.Caption + fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUMDOC').AsString + ' - ' +
                                                                                               fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESPDOC').AsString;
      frmFatMostraProdConfirmacao.showModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
      End;
    End;

    pFreeAndNil(frmFatMostraProdConfirmacao);

  End;

  FreeAndNil(dtsGenDet);
  FreeAndNil(qryGenDet);
end;

procedure TConfirmacaoNotaConcreto.pDeletaNotasDesmarcados;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try
    qryGenTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ' + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE TMP_MARDES <> "M" ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function TConfirmacaoNotaConcreto.fMarcaDocumento(blnMarcar: Boolean): Boolean;
begin
  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    {********************************************************************************}
    {* SE FOR A SECOL TENTA SELECIONAR TODOS OS DOCUMENTOS DO MESMO PEDIDO DE VENDA *}
    {********************************************************************************}
    If (MatchStr(fCfgSis('TPNFCR'), [SECOL, J_A_MASSA_CONCRETO])) Then
    Begin
      Result := fMarcaDocumentoInterna(blnMarcar);

      pCalculaTotais;

      If Result And Not fEmptyStr(FNum_PdSel) Then
        TfrmGravando.fExecutarModal(pMarcarDocumentosPedido, 'Aguarde, ' +
          IIF(blnMarcar, 'marcando','desmarcando') + ' documentos do Pedido ' +
          Concat(FNum_PdSel, '-', FEsp_PdSel, '-', FEmp_PdSel) + ' ... ', '');
    End
    Else
      Result := fMarcaDocumentoInterna(blnMarcar);
  End;

  pCalculaTotais;

  If strToIntDef(FQtdDocSel, 0) = 0 Then
  Begin
    FNum_PdSel := '';
    FEsp_PdSel := '';
    FEmp_PdSel := '';
  End;
end;

procedure TConfirmacaoNotaConcreto.pMarcarDocumentosPedido;
  Var
    strMarDes: String;
    blnMarcar: Boolean;
    blnResult: Boolean;
begin
  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    blnResult := True;
    blnMarcar := FieldByName('TMP_MARDES').AsString = 'M';

    strMarDes := IIF(blnMarcar, 'D', 'M');

    While Locate('TMP_NUM_PD;TMP_ESP_PD;TMP_EMP_PD;TMP_MARDES;',
                 VarArrayOf([FNum_PdSel, FEsp_PdSel, FEmp_PdSel, strMarDes]), []) Do
    Begin
      blnResult := blnResult And fMarcaDocumentoInterna(blnMarcar);

      Application.ProcessMessages;

      If Not blnResult Then
        Break;
    End;
  End;
end;

procedure TConfirmacaoNotaConcreto.pSetaVariaveisConfirmacao;
begin
  If (fatVenda.fPermiteAlterarCondFormaPagtoConfNFConcreto) Then
    Exit;

  fatVenda.qryTemporariaConfirmacao.First;

  fatVenda.strCodCnd := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODCND').asString;
  fatVenda.strConPag := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CONPAG').asString;

  If Not fEmptyStr(fRetForPagCodCnd(fatVenda.strCodCnd)) Then
    fatVenda.strCodFpg := fRetForPagCodCnd(fatVenda.strCodCnd)
  Else
    fatVenda.strCodFpg := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_CODFPG').asString;
end;

function TConfirmacaoNotaConcreto.fMarcaDocumentoInterna(blnMarcar: Boolean): Boolean;
  Var
    strChaLck : String;
    FNum_PdDoc: String;
    FEsp_PdDoc: String;
    FEmp_PdDoc: String;
begin
  Result := True;

  With fatVenda.qryTemporariaConfirmacao Do
  Begin
    strChaLck := 'CADREC' +
                 FieldByName('TMP_NUMDOC').AsString +
                 FieldByName('TMP_ESPDOC').AsString +
                 FieldByName('TMP_CODEMP').AsString +
                 FieldByName('TMP_CODCLI').AsString;

    FNum_PdDoc := FieldByName('TMP_NUM_PD').AsString;
    FEsp_PdDoc := FieldByName('TMP_ESP_PD').AsString;
    FEmp_PdDoc := FieldByName('TMP_EMP_PD').AsString;

    If blnMarcar Then
    Begin
      If (MatchStr(fCfgSis('TPNFCR'), [SECOL])) Then
      Begin
        If (strToIntDef(FQtdDocSel, 0) > 0) And
           (Not SameText(FNum_PdSel + FEsp_PdSel + FEmp_PdSel,
                         FNum_PdDoc + FEsp_PdDoc + FEmp_PdDoc)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Somente é permitido selecionar documentos do mesmo pedido de venda!' + #13#10 +
                                'Pedido já selecionado: ' + Concat(FNum_PdSel, '-', FEsp_PdSel, '-', FEmp_PdSel) + #13#10 +
                                'Pedido do documento: '   + Concat(FNum_PdDoc, '-', FEsp_PdDoc, '-', FEmp_PdDoc), ['&Ok']);
          Result := False;
          Exit;
        End
        Else If (Not fEmptyStr(FNum_PdDoc)) And
                (fCampoTabela('FGO_JAFATU', 'FATGOR',
                             ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'],
                             [FNum_PdDoc, FEsp_PdDoc, FEmp_PdDoc]) <> '1') Then
        Begin
          fMensagem('ATENÇÃO!', 'O pedido de venda deste documento ainda não foi totalmente baixado!' + #13#10 +
                                'Pedido: ' + Concat(FNum_PdDoc, '-', FEsp_PdDoc, '-', FEmp_PdDoc), ['&Ok']);
          Result := False;
          Exit;
        End;
      End;

      {*****************************************}
      {* VERIFICA SE HÁ ALGUMA DUPLICATA TRAVA-*}
      {* DA NO RESUMO DE CAIXA.                *}
      {**************************************MV*}
      If Not fEmptyStr(fGetHostLock(strChaLck + '%')) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck + '%'), ['&Ok']);
        Result := False;
        Exit;
      End;

      If (Not fatVenda.objLock.fLock_Unlock(strChaLck, True, False)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
        Result := False;
        Exit;
      End;

      Edit;
      FieldByName('TMP_MARDES').AsString := 'M';
      Post;

      If (MatchStr(fCfgSis('TPNFCR'), [SECOL, J_A_MASSA_CONCRETO])) Then
      Begin
        FNum_PdSel := FNum_PdDoc;
        FEsp_PdSel := FEsp_PdDoc;
        FEmp_PdSel := FEmp_PdDoc;
      End;
    End
    Else
    Begin
      fatVenda.objLock.fLock_Unlock(strChaLck, False);

      Edit;
      FieldByName('TMP_MARDES').AsString := 'D';
      Post;
    End;
  End;
end;

procedure TConfirmacaoNotaConcreto.pCalculaTotais;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      FQtdDoc := FieldByName('TOTDOC').AsString;
      FTotGer := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);
      Close;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS TOTDOC, ';
    strSQL := strSQL + '  SUM(TMP_ITEDOC) AS ITEDOC, ';
    strSQL := strSQL + '  SUM(TMP_VLRCON) AS TOTGER  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + fatVenda.strTabelaConfMi + ' ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TMP_MARDES = "M" ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      FQtdDocSel := FieldByName('TOTDOC').AsString;
      FItensDocs := FieldByName('ITEDOC').AsInteger;
      FTotGerSel := FormatFloat('#,##0.00', FieldByName('TOTGER').AsFloat);
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function TConfirmacaoNotaConcreto.fGetSemNotas: Boolean;
begin
  Result := fatVenda.qryTemporariaConfirmacao.IsEmpty;
end;

procedure TConfirmacaoNotaConcreto.pCarregaProfissionaisDoPedidoDeVenda;
  Var
    qryFatGor : TUniQuery;
begin
  If (MatchStr(fCfgSis('TPNFCR'), [SECOL, J_A_MASSA_CONCRETO])) Then
  Begin
    fatVenda.qryTemporariaConfirmacao.First;

    qryFatGor := fCriaQuery(Self);

    With qryFatGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT AUTOINCREM ');
      SQL.Add('  FROM FATGOR ');
      SQL.Add(' WHERE FGO_NUMDOC = :NUMDOC ');
      SQL.Add('   AND FGO_ESPDOC = :ESPDOC ');
      SQL.Add('   AND FGO_CODEMP = :CODEMP ');
      ParamByName('NUMDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_NUM_PD').AsString;
      ParamByName('ESPDOC').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_ESP_PD').AsString;
      ParamByName('CODEMP').AsString := fatVenda.qryTemporariaConfirmacao.FieldByName('TMP_EMP_PD').AsString;
      Open;
      fatVenda.strAutIncDiv := FieldByName('AUTOINCREM').AsString;
      Close;
    End;

    FreeAndNil(qryFatGor);
  End;
end;

end.
