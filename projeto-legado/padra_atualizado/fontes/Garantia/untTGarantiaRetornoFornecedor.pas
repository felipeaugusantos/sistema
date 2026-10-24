unit untTGarantiaRetornoFornecedor;

interface
uses
  Classes,
  untZClient,
  UniClientDataSet,
  untLiberacao,
  untFuncFat;



Type
  TOperacaoRetorno = (orRetorno, orBaixa);
{$Region 'TItemRetornado - Record'}
  TItemRetornado = Record
    fltQTDREF,
    fltQTDREQ,
    fltQTDREF_1,
    fltQTDRET_1,
    fltQTDRET: Double;

    fltVALITE,
    fltVALUNT: Currency;

    strAUTINC,
    strCODCLI,
    strCODFAB,
    strCODFOR,
    strCODITE,
    strCODVEN,
    strDESITE,
    strINCGAE,
    strINCGAG,
    strITEFRA,
    strMOTIVO,
    strNUMENT,
    strNUMENV,
    strNUMPED,
    strREFERE,
    strUNIDAD,
    strOBSF_1,
    strOBSF_2,
    strOBSF_3,
    strOBSF_4,
    strOBSF_5: String;

    blnSELECIONADO: Boolean;

    constructor Create(strAutInc: String);
    procedure pInicializar;
  end;
{$EndRegion 'TItemRetornado - Record'}

  TRetornoFornecedor = class(TComponent)
  private
    FblnUtilizarLiberacaoPropria: Boolean;
    FcdsProdutosRetornados: TUniClientDataSet;

    FcurTotal: Currency;
    FfltValDup: Double;

    FblnRefent: Boolean;

    FstrNumDocEnt,
    FstrEspDocEnt,
    FstrCNVEMB,
    FstrCtaCre,
    FstrPorGRF,
    FstrSenLib: String;

    fatVenda : TFatVenda;

    constructor Create(AOwner: TComponent); reintroduce;overload;

    procedure pAcumularTotal(pfltTotIte: Currency);
    procedure pAdicionarItem(pItemRetornado: TItemRetornado);
    procedure pBaixarPedidos(pblnRefugo : Boolean);
    procedure pCarregarConfiguracoes;
    function fDigitarCreditoFornecedor(Out pcurValDup: Double): Boolean;
    function fGravaCreditoFornecedor(strNumGars, strNumDocs: String): Boolean;
    function fGerarCredito(Out pstrNumEnt, pstrNumEnv: String): Boolean;
    procedure pGetNumDocsGarAndDocsEnvAndCre(pobjLiberacao: TLiberacao; pfltValDup: Double; Out pstrNumEnt, pstrNumEnv: String);
    procedure pMontarCdsProdutosRetornados;
    function fObterLiberacaoCredito(Out pstrNumEnt, pstrNumEnv: String): Boolean;
    function fPreparado: Boolean;


  public
    strCodFor,
    strCodOpe,
    strMotivo: String;
    strNomFrmOrigem: String;
    constructor Create(AOwner: TComponent; pOperacaoRetorno: TOperacaoRetorno); reintroduce;overload;
    destructor Destroy;override;

    function fBaixarEnvio(blnControlarTransacao: Boolean = True): Boolean;
    procedure pCarregarItemRetornado(pcdsProdutosRetornados: TUniClientDataSet; Out pItemRetornado: TItemRetornado);
    class function fCriarClientDataSetProdutosRetornados(AOwner: TComponent; blnCpoSelecionado: Boolean): TUniClientDataSet;
    function fIncluirItem(pItemRetornado: TItemRetornado): Boolean;
    function fObterProdutosRetornadosPorMovGad(pArrAutIncrem: Array of String): TUniClientDataSet;overload;

  end;

implementation
uses
  untFuncoesSimples, StrUtils, SysUtils, untFatDigPrecoCusto,  untGarant, untCadPag, untPcmGer, Data.DB, Variants;

{ TRetornoFornecedor }

constructor TRetornoFornecedor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;


constructor TRetornoFornecedor.Create(AOwner: TComponent; pOperacaoRetorno: TOperacaoRetorno);
begin
  Create(AOwner);
  FblnUtilizarLiberacaoPropria := True;
  strMotivo := Emptystr;
  FcurTotal := 0;
  FfltValDup := 0;
  FstrNumDocEnt := EmptyStr;
  FstrEspDocEnt := EmptyStr;
  pCarregarConfiguracoes;
  pMontarCdsProdutosRetornados;
  fatVenda := TFatVenda.CreateInstance('');
  fatVenda.strOpcDocTrue := 'NR';
end;

destructor TRetornoFornecedor.Destroy;
begin
  if Assigned(fatVenda) then
    FreeAndNil(FatVenda);
  inherited;
end;

procedure TRetornoFornecedor.pAcumularTotal(pfltTotIte: Currency);
begin
  FcurTotal := FcurTotal + pfltTotIte;
end;

procedure TRetornoFornecedor.pAdicionarItem(pItemRetornado: TItemRetornado);
begin
  Try
    FcdsProdutosRetornados.Append;

    FcdsProdutosRetornados.FieldByName('AUTINC').AsString := pItemRetornado.strAUTINC;
    FcdsProdutosRetornados.FieldByName('CODCLI').AsString := pItemRetornado.strCODCLI;
    FcdsProdutosRetornados.FieldByName('CODFAB').AsString := pItemRetornado.strCODFAB;
    FcdsProdutosRetornados.FieldByName('CODFOR').AsString := pItemRetornado.strCODFOR;
    FcdsProdutosRetornados.FieldByName('CODITE').AsString := pItemRetornado.strCODITE;
    FcdsProdutosRetornados.FieldByName('CODVEN').AsString := pItemRetornado.strCODVEN;
    FcdsProdutosRetornados.FieldByName('DESITE').AsString := pItemRetornado.strDESITE;
    FcdsProdutosRetornados.FieldByName('INCGAE').AsString := pItemRetornado.strINCGAE;

    FcdsProdutosRetornados.FieldByName('QTDREQ').AsFloat := pItemRetornado.fltQTDREQ;
    FcdsProdutosRetornados.FieldByName('QTDREF').AsFloat := pItemRetornado.fltQTDREF;
    FcdsProdutosRetornados.FieldByName('QTDRET').AsFloat := pItemRetornado.fltQTDRET;
    FcdsProdutosRetornados.FieldByName('QTDREF_1').AsFloat := pItemRetornado.fltQTDREF_1;
    FcdsProdutosRetornados.FieldByName('QTDRET_1').AsFloat := pItemRetornado.fltQTDRET_1;


    FcdsProdutosRetornados.FieldByName('VALUNT').AsFloat := pItemRetornado.fltVALUNT;
    FcdsProdutosRetornados.FieldByName('VALITE').AsFloat := pItemRetornado.fltVALITE;

    FcdsProdutosRetornados.FieldByName('INCGAG').AsString := pItemRetornado.strINCGAG;
    FcdsProdutosRetornados.FieldByName('ITEFRA').AsString := pItemRetornado.strITEFRA;
    FcdsProdutosRetornados.FieldByName('MOTIVO').AsString := pItemRetornado.strMOTIVO;
    FcdsProdutosRetornados.FieldByName('NUMENT').AsString := pItemRetornado.strNUMENT;
    FcdsProdutosRetornados.FieldByName('NUMENV').AsString := pItemRetornado.strNUMENV;
    FcdsProdutosRetornados.FieldByName('NUMPED').AsString := pItemRetornado.strNUMPED;
    FcdsProdutosRetornados.FieldByName('REFERE').AsString := pItemRetornado.strREFERE;
    FcdsProdutosRetornados.FieldByName('UNIDAD').AsString := pItemRetornado.strUNIDAD;

    FcdsProdutosRetornados.FieldByName('OBSF_1').AsString := pItemRetornado.strOBSF_1;
    FcdsProdutosRetornados.FieldByName('OBSF_2').AsString := pItemRetornado.strOBSF_2;
    FcdsProdutosRetornados.FieldByName('OBSF_3').AsString := pItemRetornado.strOBSF_3;
    FcdsProdutosRetornados.FieldByName('OBSF_4').AsString := pItemRetornado.strOBSF_4;
    FcdsProdutosRetornados.FieldByName('OBSF_5').AsString := pItemRetornado.strOBSF_5;

    If Assigned(FcdsProdutosRetornados.FindField('SELECIONADO')) then
    begin
      FcdsProdutosRetornados.FieldByName('SELECIONADO').AsString
        := ifthen(pItemRetornado.blnSELECIONADO, '1', '0');
    end;

    FcdsProdutosRetornados.post;
  Except
    On E: Exception do
    begin
     if FcdsProdutosRetornados.State in [dsInsert, dsEdit] then
       FcdsProdutosRetornados.Cancel;
     raise e;
    end;
  End;
end;

procedure TRetornoFornecedor.pBaixarPedidos(pblnRefugo: Boolean);
  Var
    loleItensPedidos : OleVariant;
    lblnResult       : Boolean;

    lcdsTmpItens     : TUniClientDataSet;
    lcdsPedidos      : TUniClientDataSet;

Begin
  Try
    lcdsPedidos  := TUniClientDataSet.Create(Self);
    lcdsTmpItens := TUniClientDataSet.Create(Self);

    With lcdsTmpItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'AUTOINCREM';
      DataType := ftString;
      Size := 20;
    End;

    With lcdsTmpItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENT_CODITE';
      DataType := ftString;
      Size := fTamCodIte;
    End;

    With lcdsTmpItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENT_PERIPI';
      DataType := ftFloat;
    End;

    With lcdsTmpItens.FieldDefs.AddFieldDef Do
    Begin
      Name := 'ENT_PERSUB';
      DataType := ftFloat;
    End;

    lcdsTmpItens.CreateDataSet;

    FcdsProdutosRetornados.Filtered := False;

    If pblnRefugo Then
      FcdsProdutosRetornados.Filter   := '(QTDREF_1 > 0)'
    Else
      FcdsProdutosRetornados.Filter   := '(QTDRET_1 > 0)';

    FcdsProdutosRetornados.Filtered := True;
    FcdsProdutosRetornados.First;

    While Not FcdsProdutosRetornados.Eof Do
    Begin
      lcdsTmpItens.Insert;
      lcdsTmpItens.FieldByName('ENT_CODITE').AsString := FcdsProdutosRetornados.FieldByName('CODITE').AsString;
      lcdsTmpItens.FieldByName('ENT_PERSUB').AsFloat  := 0;
      lcdsTmpItens.FieldByName('ENT_PERIPI').AsFloat  := 0;

      If not pblnRefugo Then
      begin
        lcdsTmpItens.FieldByName('AUTOINCREM').AsString
          := fCampoTabela('AUTOINCREM','MOVDET', ['DET_NUMDOC', 'DET_ESPDOC', 'DET_CODEMP', 'DET_CODFOR'], [FstrNumDocEnt, FstrEspDocEnt, VS_strCodEmp, strCodFor])
      end
      Else
        lcdsTmpItens.FieldByName('AUTOINCREM').AsString := '';

      lcdsTmpItens.Post;

      FcdsProdutosRetornados.Next;
    End;

    loleItensPedidos := fDefinePedidosABaixarGarantia(lblnResult,
                                                      lcdsTmpItens,
                                                      FstrCNVEMB,
                                                      IIF(pblnRefugo, True, False),
                                                      IIF(pblnRefugo, False, True));

    If loleItensPedidos <> Null Then
    Begin
      lcdsPedidos.Data := loleItensPedidos;
      lcdsPedidos.IndexFieldNames := 'NUMPED;CODEMP;CODITE';
      lcdsPedidos.Filtered := False;
      lcdsPedidos.First;
    End;

    fBaixaPedidos(loleItensPedidos, lcdsPedidos, False);

  Finally
    FreeAndNil(lcdsTmpItens);
    FreeAndNil(lcdsPedidos);
  End;
end;

procedure TRetornoFornecedor.pCarregarConfiguracoes;
begin
  FstrCNVEMB := fCfgSis('CNVEMB');
  FblnRefent := fCfgSis('REFENT', varBoolean);
  FstrSenLib := fCfgSis('SENBAI');
  FstrCtaCre := fConverteCentroCusto(fCfgSisL('CTAGAR'));
  FstrPorGRF := fCfgSis('PORGRF', varString);
end;

procedure TRetornoFornecedor.pCarregarItemRetornado(pcdsProdutosRetornados: TUniClientDataSet; out pItemRetornado: TItemRetornado);
begin
  pItemRetornado.Create(pcdsProdutosRetornados.FieldByName('AUTINC').AsString);
  pItemRetornado.strINCGAE := pcdsProdutosRetornados.FieldByName('INCGAE').AsString;
  pItemRetornado.strINCGAG := pcdsProdutosRetornados.FieldByName('INCGAG').AsString;
  pItemRetornado.strNUMENT := pcdsProdutosRetornados.FieldByName('NUMENT').AsString;
  pItemRetornado.strCODITE := pcdsProdutosRetornados.FieldByName('CODITE').AsString;
  pItemRetornado.strDESITE := pcdsProdutosRetornados.FieldByName('DESITE').AsString;
  pItemRetornado.strREFERE := pcdsProdutosRetornados.FieldByName('REFERE').AsString;
  pItemRetornado.strUNIDAD := pcdsProdutosRetornados.FieldByName('UNIDAD').AsString;
  pItemRetornado.strITEFRA := pcdsProdutosRetornados.FieldByName('ITEFRA').AsString;
  pItemRetornado.fltQTDREQ := pcdsProdutosRetornados.FieldByName('QTDREQ').AsFloat;
  pItemRetornado.fltQTDRET := pcdsProdutosRetornados.FieldByName('QTDRET').AsFloat;
  pItemRetornado.fltQTDREF := pcdsProdutosRetornados.FieldByName('QTDREF').AsFloat;
  pItemRetornado.strCODVEN := pcdsProdutosRetornados.FieldByName('CODVEN').AsString;
  pItemRetornado.strCODCLI := pcdsProdutosRetornados.FieldByName('CODCLI').AsString;
  pItemRetornado.strCODFOR := pcdsProdutosRetornados.FieldByName('CODFOR').AsString;
  pItemRetornado.strOBSF_1 := pcdsProdutosRetornados.FieldByName('OBSF_1').AsString;
  pItemRetornado.strOBSF_2 := pcdsProdutosRetornados.FieldByName('OBSF_2').AsString;
  pItemRetornado.strOBSF_3 := pcdsProdutosRetornados.FieldByName('OBSF_3').AsString;
  pItemRetornado.strOBSF_4 := pcdsProdutosRetornados.FieldByName('OBSF_4').AsString;
  pItemRetornado.strOBSF_5 := pcdsProdutosRetornados.FieldByName('OBSF_5').AsString;

  If fEmptyStr(Self.strMotivo) then
    pItemRetornado.strMOTIVO := pcdsProdutosRetornados.FieldByName('MOTBAI').AsString
  Else
    pItemRetornado.strMOTIVO := Self.strMotivo;

  pItemRetornado.strNUMENV := pcdsProdutosRetornados.FieldByName('NUMENV').AsString;
  pItemRetornado.fltVALITE := pcdsProdutosRetornados.FieldByName('VALITE').AsFloat;
  pItemRetornado.fltVALUNT := pcdsProdutosRetornados.FieldByName('VALUNT').AsFloat;

  If Assigned(pcdsProdutosRetornados.FindField('NUMPED')) Then
    pItemRetornado.strNUMPED := pcdsProdutosRetornados.FieldByName('NUMPED').AsString;

  If Assigned(pcdsProdutosRetornados.FindField('SELECIONADO')) Then
  begin
    if pcdsProdutosRetornados.FieldByName('SELECIONADO').AsString = '1' Then
      pItemRetornado.blnSELECIONADO := True;
  end;

end;

procedure TRetornoFornecedor.pMontarCdsProdutosRetornados;
Var
  lcdsTmp: TUniClientDataSet;
  i: Integer;
begin
  if Assigned(FcdsProdutosRetornados) then
   FreeAndNil(FcdsProdutosRetornados);

  Try
    lcdsTmp := fCriarClientDataSetProdutosRetornados(Self, False);
    if Not Assigned(lcdsTmp) Then
      Exit;

    FcdsProdutosRetornados := TUniClientDataSet.Create(Self);
    FcdsProdutosRetornados.Data := lcdsTmp.Data;
    for i := 0 to FcdsProdutosRetornados.Fields.Count -1 do
    begin
     if FcdsProdutosRetornados.Fields[i].ReadOnly then
       FcdsProdutosRetornados.Fields[i].ReadOnly := False;
    end;
  Finally
    if Assigned(lcdsTmp) Then
      FreeAndNil(lcdsTmp);
  End;
end;


function TRetornoFornecedor.fBaixarEnvio(blnControlarTransacao: Boolean = True): Boolean;
Var
  lstrNumEnt,
  lstrNumEnv: String;
  objMovGag: TMovGag;
begin
  Result := False;

  If (fEmptyStr(FstrCtaCre)) Then
  Begin
    fMensagem('ATENÇÃO!','O Plano de Contas para geração de crédito para o fornecedor não está configurada!' + #13#10 +
                         '"CFG_CTAGAR" - ABA "GARANTIA".', ['&O k']);
    Exit;
  End;

  If (fEmptyStr(FstrPorGRF)) Then
  Begin
    fMensagem('ATENÇÃO!',
              'O Portador para geração de crédito para operação de "Retorno do Fornecedor" não está configurado!' + #13#10 +
                '"CFG_PORGRF" - ABA "GARANTIA".', ['&O k']);
    Exit;
  End;

  objMovGag := TMovGag.Create(Self);
  Try
    Try
      if blnControlarTransacao then
        fStartTransaction();
      Result := True;
      if fGerarCredito(lstrNumEnt, lstrNumEnv) then
        If Not fGravaCreditoFornecedor(lstrNumEnt, lstrNumEnv) then
          raise exception.Create('Ocorreu uma falha ao tentar inserir crédito do fornecedor!');


      objMovGag.objMovGad.pAtualizaProdutoRetornados(FcdsProdutosRetornados, '', True, True);

      pBaixarPedidos(False);

      objMovGag.objMovGad.pAtualizaProdutoRetornados(FcdsProdutosRetornados, '', True);

      if blnControlarTransacao then
        fCommit();
    Except
      On E: Exception do
      begin
        Result := False;

        if (blnControlarTransacao) then
          fRollBack;

        pMensagensErro(E.Message+ sLineBreak+ 'A baixa não foi processada!', '[TRetornoFornecedor.fBaixarEnvio]');
        Exit;
      end;
    End;
  Finally
    objMovGag.Free;
  End;
end;

class function TRetornoFornecedor.fCriarClientDataSetProdutosRetornados(AOwner: TComponent; blnCpoSelecionado: Boolean): TUniClientDataSet;
Var
  strSql: String;
begin
  strSql :=          ' SELECT ';
  strSql := strSql + '     D.AUTOINCREM AS "AUTINC", ';
  strSql := strSql + '     E.AUTOINCREM AS "INCGAE", ';
  strSql := strSql + '     G.GAG_NUMENT AS "NUMENT", ';
  strSql := strSql + '     D.GAD_CODITE AS "CODITE", ';
  strSql := strSql + '     I.ITE_DESITE AS "DESITE", ';
  strSql := strSql + '     I.ITE_REFERE AS "REFERE", ';
  strSql := strSql + '     U.UNI_DESUNI AS "UNIDAD", ';
  strSql := strSql + '     U.UNI_ITEFRA AS "ITEFRA", ';
  strSql := strSql + '     E.GAE_QTDENV AS "QTDREQ", ';
  strSql := strSql + '     E.GAE_QTDRET AS "QTDRET", ';
  strSql := strSql + '     E.GAE_QTDREF AS "QTDREF", ';
  strSql := strSql + '     E.GAE_QTDRET AS "QTDRET_1", ';
  strSql := strSql + '     E.GAE_QTDREF AS "QTDREF_1", ';
  strSql := strSql + '     D.GAD_OBSF_1 AS "OBSF_1", ';
  strSql := strSql + '     D.GAD_OBSF_2 AS "OBSF_2", ';
  strSql := strSql + '     D.GAD_OBSF_3 AS "OBSF_3", ';
  strSql := strSql + '     D.GAD_OBSF_4 AS "OBSF_4", ';
  strSql := strSql + '     D.GAD_OBSF_5 AS "OBSF_5", ';
  strSql := strSql + '     G.GAG_CODVEN AS "CODVEN", ';
  strSql := strSql + '     G.GAG_CODCLI AS "CODCLI", ';
  strSql := strSql + '     D.GAD_CODFOR AS "CODFOR", ';
  strSql := strSql + '     D.GAD_MOTBAI AS "MOTIVO", ';
  strSql := strSql + '     D.GAD_VALITE AS "VALITE", ';
  strSql := strSql + '     CONCAT(GAE_NUMENV, "-", GAE_ESPENV) AS "NUMENV", ';
  strSql := strSql + '     M.DET_VLRCON AS VALUNT, ';
  strSql := strSql + '     I.ITE_CODFAB AS "CODFAB", ';
  strSql := strSql + '     G.AUTOINCREM AS "INCGAG" ';

  if blnCpoSelecionado then
    strSql := strSql + ', CAST("0" AS CHAR(1))  AS "SELECIONADO" ';

  strSql := strSql + ', CONCAT(PCG_NUMPED,"-",PCG_ESPDOC) AS NUMPED ';

  strSql := strSql + ' FROM  MOVGAG G ';
  strSql := strSql + ' INNER JOIN MOVGAD D    ON FALSE';
  strSql := strSql + ' INNER JOIN CADITE I    ON FALSE ';
  strSql := strSql + ' INNER JOIN CADUNI U    ON FALSE ';
  strSql := strSql + ' INNER JOIN MOVGAE E    ON FALSE ';
  strSql := strSql + ' INNER JOIN MOVDET M    ON FALSE ';
  strSql := strSql + ' INNER JOIN PCMGER P    ON FALSE ';
  strSql := strSql + ' WHERE FALSE; ';

  Result := TZClient.Create(AOwner, strSQL);
  Try
    Result.Open;
  Except
    On E: Exception Do
    begin
      if Assigned(Result) then
        FreeAndNil(Result);
      pMensagensErro(E.Message, '[TRetornoFornecedor.fCriarClientDataSetProdutosRetornados]');
    end;
  End;
end;

function TRetornoFornecedor.fDigitarCreditoFornecedor(out pcurValDup: Double): Boolean;
Var
  frmFatDigPrecoCusto : TfrmFatDigPrecoCusto;
begin
  pcurValDup := 0;
  Try
    pCriarFormularios(TfrmFatDigPrecoCusto, frmFatDigPrecoCusto);
    frmFatDigPrecoCusto.tvTipoValor        := tvCreditoFornecedor;
    frmFatDigPrecoCusto.edtPreCus.Text     := FormatFloat('#,#0.00', FcurTotal);;
    frmFatDigPrecoCusto.strValor           := FormatFloat('#,#0.00', FcurTotal);;
    frmFatDigPrecoCusto.blnGarantia        := True;
    frmFatDigPrecoCusto.tvTipoValor := tvCreditoFornecedor;
    frmFatDigPrecoCusto.blnRetornoFornecedor := True;

    frmFatDigPrecoCusto.ShowModal;
    pcurValDup := fStrToFloat(frmFatDigPrecoCusto.edtPreCus.Text);
    Result := pcurValDup > 0;
  Finally
    pFreeAndNil(frmFatDigPrecoCusto);
  End;
end;

function TRetornoFornecedor.fGerarCredito(out pstrNumEnt, pstrNumEnv: String): Boolean;
begin
  pstrNumEnt := EmptyStr;
  pstrNumEnv := EmptyStr;
  Result := False;

  If Not fMensagem('ATENÇÃO!', 'Confirma Lançamento de Crédito?', ['&Sim', '&Não']) = 1 Then
    Exit;

  if fDigitarCreditoFornecedor(FfltValDup) then
  begin
    If FblnUtilizarLiberacaoPropria Then
      Result := fObterLiberacaoCredito(pstrNumEnt, pstrNumEnv)
    else
      Result := True;
  end
  else
    raise Exception.Create('O valor do crédito deve ser maior que zero!');


end;

function TRetornoFornecedor.fGravaCreditoFornecedor(strNumGars, strNumDocs: String): Boolean;
Var
  strNumDup: String;
begin
  strNumDup := fRetSequencialCadPag;

  Result := fGravaCadPag(strNomFrmOrigem,
                         'INCLUSAO CRÉDITO FORNECEDOR (GARANTIA)',
                         strCodFor,
                         strNumDup,
                         'A',
                         VS_strCodEmp,
                         FstrCtaCre,
                         '1',
                         0,
                         VS_Date,
                         fNow(),
                         -FfltValDup,
                         -FfltValDup,
                         'N',
                         'N',
                         'N',
                         'REF. A CRÉDITO DO FORNECEDOR NA BAIXA DE ITENS DA GARANTIA Nº(S) ' + strNumGars + ' DOS DOC.(S) ' + strNumDocs,
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         0,
                         0,
                         '',
                         '',
                         'N',
                         FstrPorGRF,
                         '',
                         0.0,
                         0.0,
                         0,
                         False,
                         0,
                         '',
                         0,
                         'N',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         '',
                         'N',
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
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
                         '',
                         '',
                         'N');

end;

procedure TRetornoFornecedor.pGetNumDocsGarAndDocsEnvAndCre(pobjLiberacao: TLiberacao; pfltValDup: Double; Out pstrNumEnt, pstrNumEnv: String);
Var
  lstNumEnt,
  lstNumEnv: TStringList;
begin
  pstrNumEnv := '';
  pstrNumEnt := '';

  lstNumEnt := TStringList.Create;
  lstNumEnv := TStringList.Create;

  Try
    lstNumEnt.Clear;
    lstNumEnv.Clear;

    FcdsProdutosRetornados.First;

    pobjLiberacao.objMsgLibera.pAddTexto('Geração de crédito para Fornecedor (Garantia)');
    pobjLiberacao.objMsgLibera.pAddQuebra;

    pobjLiberacao.objMsgLibera.pAddTextoCaption('Total do crédito', FormatFloat('#,##0.00', FfltValDup));
    pobjLiberacao.objMsgLibera.pAddQuebra;

    While Not FcdsProdutosRetornados.Eof Do
    Begin
      if lstNumEnt.IndexOf(FcdsProdutosRetornados.FieldByName('NUMENT').AsString) = -1 then
        lstNumEnt.Add(FcdsProdutosRetornados.FieldByName('NUMENT').AsString);

      if lstNumEnv.IndexOf(FcdsProdutosRetornados.FieldByName('NUMENV').AsString) = -1 then
        lstNumEnv.Add(FcdsProdutosRetornados.FieldByName('NUMENV').AsString);

      pobjLiberacao.objMsgLibera.pAddTexto(FcdsProdutosRetornados.FieldByName('CODITE').AsString
        + '-' + FcdsProdutosRetornados.FieldByName('DESITE').AsString);

      pobjLiberacao.objMsgLibera.pAddTextoCaption('Crédito sobre o item R$',
                                                   FormatFloat('#,##0.00',
                                                   (FcdsProdutosRetornados.FieldByName('VALUNT').AsCurrency
                                                      * FcdsProdutosRetornados.FieldByName('QTDRET_1').AsCurrency)));

      pobjLiberacao.objMsgLibera.pAddSeparador(62);

      FcdsProdutosRetornados.Next;
    End;
  Finally
    if lstNumEnt.Count > 0 then
      pstrNumEnt := Trim(lstNumEnt.CommaText);

    if lstNumEnv.Count > 0 then
      pstrNumEnv := Trim(lstNumEnv.CommaText);

    lstNumEnt.Free;
    lstNumEnv.Free;
    FcdsProdutosRetornados.First;
  End;
end;

function TRetornoFornecedor.fIncluirItem(pItemRetornado: TItemRetornado): Boolean;
Var
  curTotItem: Currency;
begin
  if fPreparado then
    Result := True
  else
    Exit(False);

  if Not pItemRetornado.blnSelecionado then
    Exit(False);

  if FcdsProdutosRetornados.Locate('AUTINC', pItemRetornado.strAutInc,[]) then
    Exit;

  curTotItem := (pItemRetornado.fltQTDREF_1 + pItemRetornado.fltQTDRET_1) * pItemRetornado.fltVALUNT;
  Try
    pAdicionarItem(pItemRetornado);
    pAcumularTotal(curTotItem);
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message,'[TRetornoFornecedor.fIncluirItem]');
    end;
  end;
end;

function TRetornoFornecedor.fObterLiberacaoCredito(Out pstrNumEnt, pstrNumEnv: String): Boolean;
Var
  objLiberacao: TLiberacao;
begin
  objLiberacao:= TLiberacao.Create;
  Try
    objLiberacao.Clear;

    pGetNumDocsGarAndDocsEnvAndCre(objLiberacao, FfltValDup, pstrNumEnt, pstrNumEnv );

    objLiberacao.strDirAce := 'SENBAI';
    objLiberacao.strSenLib := FstrSenLib;
    objLiberacao.strMsgSen := 'Liberação de crédito Fornecedor(Garantia)';
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;
    Result := fatVenda.fFatMensagemLiberacao(objLiberacao);
  Finally
   objLiberacao.Free;
  End;
end;

function TRetornoFornecedor.fObterProdutosRetornadosPorMovGad(pArrAutIncrem: Array of String): TUniClientDataSet;
Var
  llstIncGad: TStrings;
  i: Integer;

  lstrSql,
  lstrAutInc: String;

begin
  Result := Nil;

  if Length(pArrAutIncrem) = 0 then
    Exit;

  llstIncGad := TStringList.Create;
  Try
    llstIncGad.Clear;

    for i := 0 to Length(pArrAutIncrem) -1 do
    begin
      lstrAutInc := QuotedStr(pArrAutIncrem[i]);
      if llstIncGad.indexof(lstrAutInc) = -1 then
        llstIncGad.Add(lstrAutInc);
    end;

    if llstIncGad.Count = 0 then
      Exit;

    lstrSql := TMovGad.fSqlProdutosRetornadosFornecedor(True, [TFiltroSqlProdutoRetornado.fprMultiplosIncGad]);
    lstrSql := Format(lstrSql, [llstIncGad.CommaText]);

    Try
      Result := TZClient.Create(Nil, lstrSql);
      TZClient(Result).qryQuery.ParamByName('CODFOR').AsString := strCodFor;
      TZClient(Result).qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
      Result.Open;
      Result.First;
    Except
      On E: Exception do
      begin
        if Assigned(Result) then
          FreeAndNil(Result);
        pMensagensErro(e.message,'TRetornoFornecedor.fObterProdutosRetornadosPorMovGad');
        exit;
      end;
    end;

  Finally
    llstIncGad.Free;
  End;
end;

function TRetornoFornecedor.fPreparado: Boolean;
begin
  Result := Assigned(FcdsProdutosRetornados);
  if Not Result then
    pMensagensErro('Não é possível continuar com execução do processo de retorno do fornecedor.','[TRetornoFornecedor.fCriarClientDataSetProdutosRetornados]');
end;

{ TItemRetornado }

constructor TItemRetornado.Create(strAutInc: String);
begin
  Self.pInicializar;
  Self.strAUTINC := strAutInc;
end;

procedure TItemRetornado.pInicializar;
begin
  Self.fltQTDREF := 0;
  Self.fltQTDREQ := 0;
  Self.fltQTDREF_1 := 0;
  Self.fltQTDRET_1 := 0;
  Self.fltQTDRET := 0;

  Self.fltVALUNT := 0;
  Self.fltVALITE := 0;

  Self.strAUTINC := EmptyStr;
  Self.strCODCLI := EmptyStr;
  Self.strCODFAB := EmptyStr;
  Self.strCODFOR := EmptyStr;
  Self.strCODITE := EmptyStr;
  Self.strCODVEN := EmptyStr;
  Self.strDESITE := EmptyStr;
  Self.strINCGAE := EmptyStr;
  Self.strINCGAG := EmptyStr;
  Self.strITEFRA := EmptyStr;
  Self.strMOTIVO := EmptyStr;
  Self.strNUMENT := EmptyStr;
  Self.strNUMENV := EmptyStr;
  Self.strNUMPED := EmptyStr;
  Self.strREFERE := EmptyStr;
  Self.strUNIDAD := EmptyStr;

  Self.strOBSF_1 := EmptyStr;
  Self.strOBSF_2 := EmptyStr;
  Self.strOBSF_3 := EmptyStr;
  Self.strOBSF_4 := EmptyStr;
  Self.strOBSF_5 := EmptyStr;
  Self.blnSELECIONADO := False;
end;

end.
