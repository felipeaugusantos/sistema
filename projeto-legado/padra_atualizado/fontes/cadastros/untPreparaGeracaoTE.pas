unit untPreparaGeracaoTE;

interface

Uses
  Classes, UniClientDataSet, DB, SysUtils, Forms, Windows, Controls, untSaldoLojas,
  Uni, cxProgressBar, StrUtils, untTypesSistema, untFuncoesRel, untCadLote,
  untZClient, System.Generics.Collections, untIFatReservaSaldo, untIFatEntregaFutura, untTFatEntregaFutura;

Type
  TDadosPrepTe = record
    strAutInc: String;
    strCodIte: String;
    strCodOpe: String;
    strDocAbs: String;
    dtaDtaCad: TDate;
    strEmpAbs: String;
    strEmpDes: String;
    strEmpDoc: String;
    strEmpOri: String;
    strEspAbs: String;
    strEspDoc: String;
    dtaHorCad: TDateTime;
    strLibera: String;
    strNumDoc: String;
    strNumLot: String;
    fltQtdIte: Double;
  End;

  TTipoDefinicaoDoVendedorNosPedidosGeradosDeTEHelper = record helper for TTipoDefinicaoDoVendedorNosPedidosGeradosDeTE
    function GetValue: String;
    function AgruparPorVendedorSolicitante : Boolean;
  end;

Type

  {$M+}
  TPreparaGeracaoTE = Class(TObject)
  Private
    FOperadores: TStringList;

    strAutIncFdo: String;

    FPedidosVenda: TStringList;

    FAutPreTE: String;

    FAculumarDigitacao: Boolean;

    FLibReg,
    FLibeTE: Boolean;

    FUpdateIte,
    FDeleteIte,
    FItens,
    FqryInfo,
    FPrepTe,
    FDocsAbs,
    FEmpresas,
    FLiberar: TUniQuery;

    FIteLib: TZClient;

    FCliEst,
    FCodTra,
    FTabPre,
    FCndPgo,
    FForPag,
    FConPagMsk,
    FNumDoc,
    FEspDoc,
    FCliFil,
    FAutInc: String;

    FSomLiq,
    FLibera,
    FEmpFat: Boolean;

    FFatLiq,
    FPesBru,
    FPesLiq,
    FTotGer,
    FTotCus,
    FTotMed: Double;

    FobjLote: TCadLot;

    fGravaFatGor: TfGravaFatGor;
    fGravaFatDor: TfGravaFatDor;

    FDicItemLote: TDictionary<String,String>;

    FCodOpe: String;
    FTipoDefinicaoDoVendedorNosPedidosGeradosDeTE : TTipoDefinicaoDoVendedorNosPedidosGeradosDeTE;
    FstrMen001Customizada: String;
    FstrEmpOri : String;
    Procedure pDefinicaoDoVendedor;

    Function fItemJaProcessadoComOutroLote(strCodIte, strNumLot: String): Boolean;

    Function fGetForPag: String;
    Function fSQLItem(strItens: String): String;
    Function fSQLSelecionaEmpresas: String;
    Function fSQLSelecionaDocsAbs: String;
    Function fSQLSelecionaItens(strDocAbs, strEspAbs, strEmpAbs: String; strCodOpe : String = ''): String;
    Function fSQLConsulta: String;

    Function fGeraPedido(strEmpDes, strDocAbs, strEspAbs, strEmpAbs: String): Boolean;
    Function fGeraPedidoPorSolicitante(strEmpDes, strDocAbs, strEspAbs, strEmpAbs: String): Boolean;

    Procedure pSet_INCFDO_REQVEN(strAutIncFdo, strAutIncPREPTE : String);
    Procedure pSet_NumeroEspecieDocumento;
    Procedure pAtualizaStatusGeraOcorrenciaCRM(strDocAbs, strEspAbs, strEmpAbs : String);

    Function fAtualizarDocumentoAbastecimentoMultiLoja(strNumDoc, strEspDoc, strEmpDoc, strDocOri, strEspOri, strEmpOri: String): Boolean;
    Function fCndPagto(strCndPag: String = '01000'): String;
    Function fGravaFatGorTE(Const strDocAbs, strEspAbs, strEmpAbs: String): Boolean;
    Function fRetTabelaPreco(strCodCli, strCodVen: String): String;
    Function fGravaFatDorTE: Boolean;
    Function fCarregaItens: Boolean;
    Function fGeraTodos(pgbProgresso: TcxProgressBar): Boolean;
    Function fAtualizarDadosLiberacaoPedidosTransferencia(pgbProgresso: TcxProgressBar): Boolean;

    Function fPedidoBloqueado: Boolean;
    Function fLiberaItensLoop(pgbProgresso: TcxProgressBar): Boolean;
    Function fExcluiitensLoop(pgbProgresso: TcxProgressBar): Boolean;
    Function fMarcaTodosLoop(pgbProgresso: TcxProgressBar): Boolean;
    Function fSQLSelecionaItensLiberacao: String;
    Function fSQLUpdateIte: String;
    Function FSQLDeleteIte: String;
    Function fSQLPedidosLiberacao: String;
    Function fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt, strForPag: string; strCodCli: string): boolean;

    Procedure pLiberaRegistro(strAutInc: String);
    Procedure pExcluiRegistro(strAutInc: String);
    Procedure pRetornaNumeroDasRequisicoes(strNumDoc, strEspDoc: String);
    procedure pInsereITELIB_RES;
    function fRetornaSaldoFisico(strCodIte, strCodEmp: String; fltCNV_ML: Double): Double;
    function fAutIncEnderecoDeEntrega: String;
    Procedure pValidaRegistroComQtdZerada;

    function fEmpOri: String;
  Public
    AutincPedidoCompra: String;

    blnGerouTEAculumados: Boolean;

    Constructor Create(funcGravaFatGor: TfGravaFatGor;
                       funcGravaFatDor: TfGravaFatDor); Overload;

    Constructor Create;  Overload;

    Destructor Destroy; Override;

    Function fConsulta(strCodIte: String): Boolean;
    Function fSaldoDisponivel(strCodIte, strNumLot, strCodEmp: String): Double;
    Function fSaldoATransferir(strCodIte, strNumLot, strEmpOri, strEmpDes: String): Double;

    Function fSaldoAcumuladoDigitacao(strCodIte, strNumLot, strEmpOri, strEmpDes: String): Double;
    Function fSalvaDigitacao(strCodIte, strDesIte, strNumLot, strEmpOri, strEmpDes: String; fltQtdTra: Double): Boolean;

    Function fSalvaPreparacao(strCodIte, strNumLot, strEmpOri, strEmpDes: String; fltQtdTra: Double;
               blnAbrirTransacao: Boolean = True; stlListaReq: TStringList = Nil; blnApagarPendentes: Boolean = True): Boolean;

    Function fSelecionaItensLiberacao: Boolean;
    Function fLiberaItens: Boolean;
    Function fExcluiItens: Boolean;
    Function fMarcaTodos(blnMarcar: Boolean): Boolean;
    Function fTemRegistrosMarcados: Boolean;

    Function fGeraPedidosVenda: Boolean; overload;
    Function fGeraPedidosVenda(const AstrEmpOri: String): Boolean; Overload;
    Function fSalvaDigitados(blnComTransacao: Boolean): Boolean;

    Function fPossuiDigitados: Boolean;

    Procedure pInformaPreparacao(strCodIte: String; blnCarregarDoGrid: Boolean = False);

    Procedure pMarcaDesmarca;
    procedure pRestauraTransferenciasDefinidas;
    procedure pAtualizaAutoincremPedido;

    procedure pCarregaSaldos;

    class Function fGravarPreparaGeracaoTE_MultiLoja(strNumDoc,
                                                     strEspDoc,
                                                     strEmpDoc,
                                                     strCodIte,
                                                     strEmpOri,
                                                     strEmpDes,
                                                     strNumLot: String;
                                                     fltQtdIte: Double;
                                                     Var strAutInc: String;
                                                     blnLibera: Boolean = True;
                                                     strEmpIte: String = ''): Boolean;

    class function fCarregarDadosPreparacaoTransferencia(const strNumDoc, strEspDoc, strCodEmp: String): TUniQuery;
    class procedure pInserirPreparacaoTransferencia(recDados: TDadosPrepTe);
    class procedure pRegravarDadosPreparacaoTransferencia(qryPrepTe: TUniQuery);
    Class Function fLiberaItensDocumento(strNumDoc, strEspDoc, strEmpDoc: String):Boolean; static;

  Published
    property qryConsulta: TUniQuery Read FqryInfo Write FqryInfo;
    property objCadLot: TCadLot     Read FobjLote Write FobjLote;
    property cdsIteLib: TZClient    Read FIteLib  Write FIteLib;

    property blnAculumarDigitacao: Boolean Read FAculumarDigitacao Write FAculumarDigitacao;

    property strAutPreTE: String    Read FAutPreTE;
    property Men001Customizada: String write FstrMen001Customizada;
  End;

  TEFieldReplInf = (friFatgor, friExtgor);

  IReplInfPDTransf = interface
  ['{516378BE-4095-4557-94ED-912B04FCE383}']
    function NumDoc(const AValue: String): IReplInfPDTransf;
    function EspDoc(const AValue: String): IReplInfPDTransf;
    function CodEmp(const AValue: String): IReplInfPDTransf;
    function Fields(const ATable: TEFieldReplInf; const AValue: TArrString): IReplInfPDTransf;

    procedure pExecute;
  end;

  TReplInfPDTransf = class sealed(TInterfacedObject, IReplInfPDTransf)
  protected
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FFieldsFgo: TArrString;
    FFieldsEgo: TArrString;

    constructor Create;
  public
    function NumDoc(const AValue: String): IReplInfPDTransf;
    function EspDoc(const AValue: String): IReplInfPDTransf;
    function CodEmp(const AValue: String): IReplInfPDTransf;
    function Fields(const ATable: TEFieldReplInf; const AValue: TArrString): IReplInfPDTransf;

    procedure pExecute;

    class function New: IReplInfPDTransf;
  end;
  {$M-}

implementation

Uses
    Variants,
    untConstantes, untFuncoesSimples, untAtualizaOcorrenciasCRM,
    untFuncoesCRM, untPreparaGeracaoTEEdicao, untGravando, untIFuncoes,
    untTypesCRM, untTSituacaoPedidoVenda, untTFatReservaSaldo,
    untTSaldoReservadoPedido, untFuncoesGenerica;

Constructor TPreparaGeracaoTE.Create(funcGravaFatGor: TfGravaFatGor;
                                     funcGravaFatDor: TfGravaFatDor);
Begin
  inherited Create;

  FAculumarDigitacao := False;

  blnGerouTEAculumados := False;

  FPedidosVenda := TStringList.Create;

  FLibeTE     := fCfgSis('LIBETE') = '1';
  FOperadores := TStringList.Create;
  FOperadores.Sorted := True;

  fGravaFatGor := funcGravaFatGor;
  fGravaFatDor := funcGravaFatDor;
  FobjLote     := Nil;
  FqryInfo     := Nil;
  FIteLib      := Nil;
  FUpdateIte   := Nil;
  FDeleteIte   := Nil;

  If Not Assigned(FDicItemLote) Then
    FDicItemLote := TDictionary<String,String>.Create;

  pDefinicaoDoVendedor;

End;

Constructor TPreparaGeracaoTE.Create;
Begin
  inherited Create;
  FstrEmpOri := '';

  FAculumarDigitacao := False;

  blnGerouTEAculumados := False;

  FreeAndNil(FPedidosVenda);

  FLibeTE     := fCfgSis('LIBETE') = '1';
  FOperadores := TStringList.Create;
  FOperadores.Sorted := True;

  FqryInfo := fCriaQuery(Nil);
  FqryInfo.SQL.Text := fSQLConsulta;

  FobjLote := TCadLot.Create(Nil);

  If Not Assigned(FDicItemLote) Then
    FDicItemLote := TDictionary<String,String>.Create;

  FIteLib    := Nil;
  FUpdateIte := Nil;
  FDeleteIte := Nil;

  pDefinicaoDoVendedor;

End;

Destructor TPreparaGeracaoTE.Destroy;
Begin
  If Assigned(FDicItemLote) Then
    FreeAndNil(FDicItemLote);

  If Assigned(FqryInfo) Then
    FreeAndNil(FqryInfo);

  If Assigned(FobjLote) Then
    FreeAndNil(FobjLote);

  If Assigned(FIteLib) Then
    FreeAndNil(FIteLib);

  If Assigned(FUpdateIte) Then
    FreeAndNil(FUpdateIte);

  If Assigned(FDeleteIte) Then
    FreeAndNil(FDeleteIte);

  If Assigned(FPedidosVenda) Then
    FreeAndNil(FPedidosVenda);

  FOperadores.Clear;
  FreeAndNil(FOperadores);

  inherited;
End;

Function TPreparaGeracaoTE.fSQLConsulta: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   CONCAT(ITE_CODFOR, "-", FOR_NOMFOR) AS NOMFOR, ';
  strSQL := strSQL + '   CONCAT(ITE_CODMAR, "-", MAR_DESMAR) AS DESMAR, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE C ';
  strSQL := strSQL + ' LEFT JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';
  strSQL := strSQL + ' LEFT JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR ';
  strSQL := strSQL + ' LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   C.ITE_CODITE = :CODITE ';

  Result := strSQL;
End;

Function TPreparaGeracaoTE.fConsulta(strCodIte: String): Boolean;
Begin
  With FqryInfo Do
  Begin
    Close;
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    Result := Not IsEmpty;
  End;
End;

Function TPreparaGeracaoTE.fSaldoDisponivel(strCodIte, strNumLot, strCodEmp: String): Double;
  Var
    strSQL: String;
    qrySaldo: TUniQuery;
    fltSaldo,
    fltSalRes,
    fltSalMl,
    fltCNV_ML,
    fltSalReg,
    fltSalExt,
    fltEntFut: Double;



Begin
  // FEITO COMO NA CONSULTA DE ITENS DA VENDA


  qrySaldo := fCriaQuery;
  Try
    qrySaldo.SQL.Text := 'SELECT ITE_CNV_ML FROM CADITE WHERE ITE_CODITE = "'+strCodIte+'"';
    qrySaldo.Open;

    fltCNV_ML := IIF(qrySaldo.FieldByName('ITE_CNV_ML').AsFloat <= 0, 1, qrySaldo.FieldByName('ITE_CNV_ML').AsFloat);

    qrySaldo.SQL.Text := 'SELECT ITE_CNV_ML FROM CADITE WHERE ITE_CODITE = "'+strCodIte+'"';
    qrySaldo.Open;

    fltSalRes := TSaldoReservado.New(
                                             TReservaParametros.New()
                                               .EmpresaItem(strCodEmp)
                                               .CodigoItem(strCodIte)
                                               .CodEmpresa(strCodEmp)
                                               .TipoReserva(trsPedidoVenda)
                                               .NumeroLote(strNumLot)
                                               .ConverterML(True)
                                             ).fGetQuantidade();

    fltSalReg := TSaldoReservado.New(
                                             TReservaParametros.New()
                                               .EmpresaItem(strCodEmp)
                                               .CodigoItem(strCodIte)
                                               .CodEmpresa(strCodEmp)
                                               .TipoReserva(trsGarantia)
                                               .NumeroLote(strNumLot)
                                               .ConverterML(True)
                                             ).fGetQuantidade();

    fltSalExt := TSaldoReservado.New(
                                             TReservaParametros.New()
                                               .EmpresaItem(strCodEmp)
                                               .CodigoItem(strCodIte)
                                               .CodEmpresa(strCodEmp)
                                               .TipoReserva(trsExterno)
                                               .NumeroLote(strNumLot)
                                               .ConverterML(True)
                                             ).fGetQuantidade();

    If (fltSalExt < 0) Then
      fltSalExt := 0;

    fltEntFut := 0;
    If fUsaQtdPendenteEntregaFutura Then
      fltEntFut := TEntregaFutura.New(
                                                 TParamEF.New()
                                                 .CodIte(strCodIte)
                                                 .CodEmp(strCodEmp)
                                                 .ConverteML(True)
                                                 .TipoTE(tteTodas)
                                                 ).Total();


    qrySaldo.SQL.Clear;
    If (Not fEmptyStr(strNumLot)) And (Not FobjLote.qryCadLot.IsEmpty) And (FobjLote.qryCadLot.ParamByName('CODEMP').Value = strCodEmp) Then
    Begin
      fltSaldo := FobjLote.qryCadLot.FieldByName('LOT_SALDOS').AsFloat;
      fltSalMl := FobjLote.qryCadLot.FieldByName('LOT_SAL_ML').AsFloat;
    End
    Else If (Not fEmptyStr(strNumLot)) And  (FobjLote.qryCadLot.ParamByName('CODEMP').Value <> strCodEmp) Then
    Begin
      qrySaldo.SQL.Add('SELECT LOT_SALDOS, LOT_SAL_ML ');
      qrySaldo.SQL.Add('    FROM CADLOT');
      qrySaldo.SQL.Add('   WHERE LOT_CODEMP = :CODEMP');
      qrySaldo.SQL.Add('     AND LOT_NUMLOT = :NUMLOT');
      qrySaldo.SQL.Add('     AND LOT_CODITE = :CODITE');
      qrySaldo.ParamByName('CODEMP').AsString := strCodEmp;
      qrySaldo.ParamByName('NUMLOT').AsString := strNumLot;
      qrySaldo.ParamByName('CODITE').AsString := strCodIte;
      qrySaldo.Open;
      fltSaldo := qrySaldo.FieldByName('LOT_SALDOS').AsFloat;
      fltSalMl := qrySaldo.FieldByName('LOT_SAL_ML').AsFloat;
    End
    Else
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '   I.ITE_CNV_ML AS CNV_ML, ';
      strSQL := strSQL + '   G.ITE_SAL_ML AS SAL_ML, ';
      strSQL := strSQL + '  G.ITE_SALDOS AS SALDOS ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   ITEGER G ';
      strSQL := strSQL + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';

      strSQL := strSQL + ' WHERE      ';
      strSQL := strSQL + '   G.ITE_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   G.ITE_CODITE = :CODITE ';

      With qrySaldo Do
      Begin
        SQL.Text := strSQL;
        Close;
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        fltSaldo := FieldByName('SALDOS').AsFloat;
        fltSalMl := qrySaldo.FieldByName('SAL_ML').AsFloat;
        Close;
      End;

    End;

    If (fCfgSis('MOVFUL', varString) = '2') Then
      fltSalExt := 0;

    Result := (((fltSaldo + fltEntFut)* fltCNV_ML) + fltSalMl) - fltSalres - fltSalReg - fltSalExt;
  Finally
    FreeAndNil(qrySaldo);
  End

End;

Function TPreparaGeracaoTE.fSaldoAcumuladoDigitacao(strCodIte, strNumLot, strEmpOri, strEmpDes: String): Double;
Begin
  Result := 0;

  If Not Assigned(FIteLib) Then
    Exit;

  If Not FIteLib.Active Then
    Exit;

  If FIteLib.Locate('CODITE;NUMLOT;EMPORI;EMPDES', VarArrayOf([strCodIte, strNumLot, strEmpOri, strEmpDes]), []) Then
    Result := FIteLib.FieldByName('QTDITE').AsFloat;
End;

Function TPreparaGeracaoTE.fPossuiDigitados: Boolean;
Begin
  Result := False;

  If Not Assigned(FIteLib) Then
    Exit;

  If Not FIteLib.Active Then
    Exit;

  Result := Not FIteLib.IsEmpty;
End;

Function TPreparaGeracaoTE.fSalvaDigitados(blnComTransacao: Boolean): Boolean;
Begin
  Result := True;

  blnGerouTEAculumados := False;

  If Not FAculumarDigitacao Then
   Exit;

  If Not Assigned(FIteLib) Then
    Exit;

  If Not cdsIteLib.Active Then
    Exit;

  FIteLib.First;
  While Not FIteLib.Eof Do
  Begin
    If FIteLib.FieldByName('QTDITE').AsFloat > 0 Then
    Begin
      Result := fSalvaPreparacao(FIteLib.FieldByName('CODITE').AsString,
                                 FIteLib.FieldByName('NUMLOT').AsString,
                                 FIteLib.FieldByName('EMPORI').AsString,
                                 FIteLib.FieldByName('EMPDES').AsString,
                                 FIteLib.FieldByName('QTDITE').AsFloat,
                                 blnComTransacao);

      blnGerouTEAculumados := Result;
    End;

    If Not Result Then
      Break;

    FIteLib.Next;
  End;

End;

Function TPreparaGeracaoTE.fSalvaDigitacao(strCodIte, strDesIte, strNumLot, strEmpOri, strEmpDes: String; fltQtdTra: Double): Boolean;
Begin
  Result := False;

  If Not Assigned(FIteLib) Then
    Exit;

  If FIteLib.Locate('CODITE;NUMLOT;EMPORI;EMPDES', VarArrayOf([strCodIte, strNumLot, strEmpOri, strEmpDes]), []) Then
  Begin

    If fltQtdTra = 0 Then
    Begin

      FIteLib.Delete;

    End Else
    Begin
      FIteLib.Edit;
      FIteLib.FieldByName('QTDITE').AsFloat := fltQtdTra;
      FIteLib.Post;
      pInsereITELIB_RES;
    End;

  End Else
  Begin

    FIteLib.Insert;
    FIteLib.FieldByName('CODITE').AsString := strCodIte;
    FIteLib.FieldByName('DESITE').AsString := strDesIte;
    FIteLib.FieldByName('NUMLOT').AsString := strNumLot;
    FIteLib.FieldByName('EMPORI').AsString := strEmpOri;
    FIteLib.FieldByName('EMPDES').AsString := strEmpDes;
    FIteLib.FieldByName('QTDITE').AsFloat  := fltQtdTra;
    If AutincPedidoCompra <> '' Then
      FIteLib.FieldByName('INCRES').ASString:= AutincPedidoCompra;

    FIteLib.Post;

    If AutincPedidoCompra <> '' Then
     pInsereITELIB_RES;
  End;

  Result := True;
End;

Function TPreparaGeracaoTE.fSaldoATransferir(strCodIte, strNumLot, strEmpOri, strEmpDes: String): Double;
  Var
    qryPrepTe: TUniQuery;
Begin
  qryPrepTe := fCriaQuery;

  With qryPrepTe, SQL Do
  Begin
    Add('SELECT SUM(PRE_QTDITE) AS SOMA FROM PREPTE');
    Add('WHERE');
    Add('  PRE_NUMDOC IS NULL   AND ');
    Add('  PRE_CODITE = :CODITE AND ');
    Add('  IFNULL(PRE_NUMLOT, "") = :NUMLOT AND ');
    Add('  PRE_EMPORI = :EMPORI AND ');
    Add('  PRE_EMPDES = :EMPDES     ');

    Add('  AND IFNULL((SELECT COUNT(*) FROM REQVEN WHERE SEQ_PREPTE = PREPTE.AUTOINCREM), 0) = 0 ');
    Add('  AND IFNULL((SELECT COUNT(*) FROM BAIREQ WHERE BAI_QTDREQ = PREPTE.AUTOINCREM), 0) = 0 ');

    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('NUMLOT').AsString := strNumLot;
    ParamByName('EMPORI').AsString := strEmpOri;
    ParamByName('EMPDES').AsString := strEmpDes;

    Open;

    Result := FieldByName('SOMA').AsFloat;

    Close;
  End;

  FreeAndNil(qryPrepTe);
End;

Function TPreparaGeracaoTE.fSalvaPreparacao(strCodIte, strNumLot, strEmpOri, strEmpDes: String; fltQtdTra: Double;
               blnAbrirTransacao: Boolean = True; stlListaReq: TStringList = Nil; blnApagarPendentes: Boolean = True): Boolean;
  Var
    qryReqVen,
    qryPrepTe: TUniQuery;
    intContador: Integer;
Begin
  Try
    qryReqVen := Nil;

    If blnAbrirTransacao Then
      fStartTransaction;

    If Assigned(stlListaReq) Then
    Begin
      qryReqVen := fCriaQuery;
      qryReqVen.SQL.Text := 'INSERT INTO REQVEN (SEQ_MOVRCD, SEQ_PREPTE) VALUES (:MOVRCD, :PREPTE)';
    End;

    qryPrepTe := fCriaQuery;

    With qryPrepTe, SQL Do
    Begin

      If blnApagarPendentes Then
      Begin
        Clear;
        Add('DELETE FROM PREPTE ');
        Add('WHERE');
        Add('  PRE_NUMDOC IS NULL   AND ');
        Add('  PRE_CODITE = :CODITE AND ');
        Add('  IFNULL(PRE_NUMLOT, "") = :NUMLOT AND ');
        Add('  PRE_EMPORI = :EMPORI AND ');
        Add('  PRE_EMPDES = :EMPDES     ');

        Add('  AND IFNULL((SELECT COUNT(*) FROM REQVEN WHERE SEQ_PREPTE = PREPTE.AUTOINCREM), 0) = 0 ');
        Add('  AND IFNULL((SELECT COUNT(*) FROM BAIREQ WHERE BAI_QTDREQ = PREPTE.AUTOINCREM), 0) = 0 ');

        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('NUMLOT').AsString := strNumLot;
        ParamByName('EMPORI').AsString := strEmpOri;
        ParamByName('EMPDES').AsString := strEmpDes;

        ExecSQL;
      End;

      If fltQtdTra > 0 Then
      Begin
        Clear;
        Add('SELECT * FROM PREPTE WHERE FALSE');
        Open;

        qryPrepTe.Insert;

        FAutPreTE := fRetAutoIncrem('PREPTE', fEmpOri);

        FieldByName('AUTOINCREM').AsString   := FAutPreTE;
        FieldByName('PRE_CODITE').AsString   := strCodIte;

        If Not fEmptyStr(strNumLot) Then
          FieldByName('PRE_NUMLOT').AsString   := strNumLot;

        FieldByName('PRE_EMPORI').AsString   := strEmpOri;
        FieldByName('PRE_EMPDES').AsString   := strEmpDes;
        FieldByName('PRE_QTDITE').AsFloat    := fltQtdTra;
        FieldByName('PRE_CODOPE').AsString   := strLoginUsuarioLogado;
        FieldByName('PRE_DTACAD').AsDateTime := VS_Date;
        FieldByName('PRE_HORCAD').AsDateTime := fTime();

        If FLibeTE Then
          FieldByName('PRE_LIBERA').AsString   := 'S'
        Else
          FieldByName('PRE_LIBERA').AsString   := 'N';

        Post;

        If Assigned(stlListaReq) Then
        For intContador := 0 To stlListaReq.Count - 1 Do
        Begin
          qryReqVen.Close;
          qryReqVen.ParamByName('MOVRCD').AsString := stlListaReq[intContador];
          qryReqVen.ParamByName('PREPTE').AsString := FieldByName('AUTOINCREM').AsString;
          qryReqVen.ExecSQL;
        End;

      End;

    End;

    If blnAbrirTransacao Then
      fCommit;

    Result := True;

    If Assigned(qryReqVen) Then
      FreeAndNil(qryReqVen);

    FreeAndNil(qryPrepTe);

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TPreparaGeracaoTE.fSalvaPreparacao]');
    End;
  End;
End;

function TPreparaGeracaoTE.fAtualizarDadosLiberacaoPedidosTransferencia(
  pgbProgresso: TcxProgressBar): Boolean;
begin
  pgbProgresso.Position       := 0;
  pgbProgresso.Properties.Max := FLiberar.RecordCount;
  Application.ProcessMessages;

  While Not FLiberar.Eof Do
  Begin
    {***********************************}
    {* REPLICA DADOS DE BLOQUEIO PARA  *}
    {* OS PEDIDOS DE TRANSFERÊNCIA QUE *}
    {* FORAM GERADOS A PARTIR DESSE    *}
    {********************************FS*}
    TReplInfPDTransf.New()
      .NumDoc(FLiberar.FieldByName('FGO_NUMDOC').AsString)
      .EspDoc(FLiberar.FieldByName('FGO_ESPDOC').AsString)
      .CodEmp(FLiberar.FieldByName('FGO_CODEMP').AsString)
      .Fields(friFatGor, ['FGO_OPELIB', 'FGO_DIGLIB', 'FGO_DTALIB', 'FGO_HORLIB',
                          'FGO_OBSL01', 'FGO_OBSL02', 'FGO_LIBERA', 'FGO_OPELIC',
                          'FGO_DIGLIC', 'FGO_DTALIC', 'FGO_HORLIC', 'FGO_OBSLC1',
                          'FGO_OBSLC2', 'FGO_LIBCOM'])
      .Fields(friExtGor, ['FGO_ENVLIB'])
      .pExecute();

    FLiberar.Next;

    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  Result := True;
end;

function TPreparaGeracaoTE.fAtualizarDocumentoAbastecimentoMultiLoja(strNumDoc, strEspDoc, strEmpDoc, strDocOri, strEspOri, strEmpOri: String): Boolean;
  Var
    qryTemp: TUniQuery;
    strAutInc: String;
    blnTransacaoAberta: Boolean;
begin
  Result := True;
  blnTransacaoAberta := fInTransaction();

  Try
    qryTemp := fCriaQuery();

    Try
      strAutInc := fCampoTabela('AUTOINCREM', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumDoc, strEspDoc, strEmpDoc]);

      If (Not fEmptyStr(strAutInc)) Then
      Begin
        If (Not blnTransacaoAberta) Then
          fStartTransaction();

        qryTemp.Close();
        qryTemp.SQL.Clear();
        qryTemp.SQL.Text := 'UPDATE EXTGOR SET FGO_NMPDAB = :NUMDOC, FGO_ESPDAB = :ESPDOC, FGO_EMPDAB = :EMPDOC WHERE FGO_SEQFGO = :AUTINC';
        qryTemp.ParamByName('AUTINC').AsString := strAutInc;
        qryTemp.ParamByName('NUMDOC').AsString := strDocOri;
        qryTemp.ParamByName('ESPDOC').AsString := strEspOri;
        qryTemp.ParamByName('EMPDOC').AsString := strEmpOri;
        qryTemp.ExecSQL();

        If (Not blnTransacaoAberta) Then
          fCommit();
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack();
        pMensagensErro(E.Message, '[TPreparaGeracaoTE.fAtualizarDocumentoAbastecimentoMultiLoja]');
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

Procedure TPreparaGeracaoTE.pInformaPreparacao(strCodIte: String; blnCarregarDoGrid: Boolean = False);
  Var
    frmPreparaGeracaoTEEdicao: TfrmPreparaGeracaoTEEdicao;
Begin

  If FAculumarDigitacao Then
  Begin
   If (Not Assigned(FIteLib)) Or (Not FIteLib.Active) Then
     fSelecionaItensLiberacao;
  End;

  If blnCarregarDoGrid Then
  Begin
    If ((Not Assigned(FIteLib)) Or FIteLib.IsEmpty) Then
      Exit;
  End;

  pCriarFormularios(TfrmPreparaGeracaoTEEdicao, frmPreparaGeracaoTEEdicao);

  frmPreparaGeracaoTEEdicao.blnCarregarDados := blnCarregarDoGrid;
  frmPreparaGeracaoTEEdicao.objPreparaGer := Self;
  frmPreparaGeracaoTEEdicao.edtCodIte.Text := strCodIte;
  frmPreparaGeracaoTEEdicao.ShowModal;

  pFreeAndNil(frmPreparaGeracaoTEEdicao);
End;

procedure TPreparaGeracaoTE.pInsereITELIB_RES();
var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('REPLACE INTO ITELIB_RES (RES_CODITE, RES_NUMLOT, RES_EMPORI, RES_EMPDES, RES_QTDITE, RES_INCRES)VALUES');
    qryComand.SQL.Add('                        (:CODITE, :NUMLOT, :EMPORI, :EMPDES, :QTDITE, :INCRES);');


    qryComand.ParamByName('CODITE').AsString := FIteLib.FieldByName('CODITE').AsString;
    qryComand.ParamByName('NUMLOT').AsString := FIteLib.FieldByName('NUMLOT').AsString;
    qryComand.ParamByName('EMPORI').AsString := FIteLib.FieldByName('EMPORI').AsString;
    qryComand.ParamByName('EMPDES').AsString := FIteLib.FieldByName('EMPDES').AsString;
    qryComand.ParamByName('QTDITE').AsFloat  := FIteLib.FieldByName('QTDITE').AsFloat;
    qryComand.ParamByName('INCRES').AsString := FIteLib.FieldByName('INCRES').AsString;

    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;

end;

Function TPreparaGeracaoTE.fSQLSelecionaItens(strDocAbs, strEspAbs, strEmpAbs: String; strCodOpe : String = ''): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '   P.*, ';

  strSQL := strSQL + '  IFNULL((SELECT GROUP_CONCAT(RCD_DOCPDV, "-", RCD_ESPPDV, "-", RCD_EMPPDV) FROM REQVEN  ';
  strSQL := strSQL + '   INNER JOIN MOVRCD M ON M.AUTOINCREM = SEQ_MOVRCD                               ';
  strSQL := strSQL + '   WHERE SEQ_PREPTE = P.AUTOINCREM), CONCAT(PRE_DOCABS, "-", PRE_ESPABS, "-", PRE_EMPABS)';
  strSQL := strSQL + '  ) AS PEDVEN                                     ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   PREPTE P ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PRE_LIBERA = "S"     AND ';
  strSQL := strSQL + '   PRE_NUMDOC IS NULL   AND ';
  strSQL := strSQL + '   PRE_EMPORI = :EMPORI AND ';
  strSQL := strSQL + '   PRE_EMPDES = :EMPDES ';

  If Not fEmptyStr(strDocAbs) Then
    strSQL := strSQL + '   AND PRE_DOCABS = :DOCABS '
  Else
    strSQL := strSQL + '   AND PRE_DOCABS IS NULL ';

  If Not fEmptyStr(strEspAbs) Then
    strSQL := strSQL + '   AND PRE_ESPABS = :ESPABS '
  Else
    strSQL := strSQL + '   AND PRE_ESPABS IS NULL ';

  If Not fEmptyStr(strEmpAbs) Then
    strSQL := strSQL + '   AND PRE_EMPABS = :EMPABS '
  Else
    strSQL := strSQL + '   AND PRE_EMPABS IS NULL ';

  If Not fEmptyStr(strCodOpe) Then
    strSQL := strSQL + '   AND PRE_CODOPE = :CODOPE ';

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   PRE_CODITE ';

  Result := strSQL;
End;

function TPreparaGeracaoTE.fSQLSelecionaDocsAbs: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE   ';
  strSQL := strSQL + '   DISTINCT PRE_DOCABS, PRE_ESPABS, PRE_EMPABS ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   PREPTE ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PRE_NUMDOC IS NULL   AND ';
  strSQL := strSQL + '   PRE_EMPORI = :EMPORI AND ';
  strSQL := strSQL + '   PRE_EMPDES = :EMPDES     ';
  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   PRE_DOCABS, PRE_ESPABS, PRE_EMPABS ';

  Result := strSQL;
end;

Function TPreparaGeracaoTE.fSQLSelecionaEmpresas: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE   ';
  strSQL := strSQL + '   DISTINCT PRE_EMPDES, ';
  strSQL := strSQL + '   EMP_CLIFIL ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   PREPTE ';
  strSQL := strSQL + ' LEFT JOIN CADEMP ON EMP_CODEMP = PRE_EMPDES ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PRE_NUMDOC IS NULL   AND ';
  strSQL := strSQL + '   PRE_EMPORI = :EMPORI     ';
  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   PRE_EMPDES ';

  Result := strSQL;
End;

Function TPreparaGeracaoTE.fCarregaItens: Boolean;
Var
  stlItens: TStringList;
  intIndex: Integer;
  fltPrevenSemFator: Double;
  fltTEPREV,
  fltFat_TE,
  fltICMSai : Double;
  strTEPREV,
  strCodAbf,
  strCodSit,
  strTipAbf : String;

Begin
  FTotGer := 0;
  FTotCus := 0;
  FTotMed := 0;
  FPesBru := 0;
  FPesLiq := 0;

  FPedidosVenda.Clear;

  With FItens Do
  Begin
    stlItens := TStringList.Create;

    FPrepTe.First;
    While Not FPrepTe.Eof Do
    Begin
      stlItens.Add(QuotedStr(FPrepTe.FieldByName('PRE_CODITE').AsString));

      If Not fEmptyStr(FPrepTe.FieldByName('PEDVEN').AsString) Then
        FPedidosVenda.Add(FPrepTe.FieldByName('PEDVEN').AsString);

      FPrepTe.Next;
    End;
    FPrepTe.First;

    FItens.Close;
    SQL.Text := fSQLItem(stlItens.CommaText);

    ParamByName('CODEMP').AsString := fEmpOri;

    Open;

    Result := Not IsEmpty;

    FPrepTe.First;
    While Not FPrepTe.Eof Do
    Begin
      If Not FOperadores.Find(FPrepTe.FieldByName('PRE_CODOPE').AsString, intIndex) Then
        FOperadores.Add(FPrepTe.FieldByName('PRE_CODOPE').AsString);

      If FItens.Locate('CODITE', FPrepTe.FieldByName('PRE_CODITE').AsString, []) Then
      Begin
        If fItemJaProcessadoComOutroLote(FPrepTe.FieldByName('PRE_CODITE').AsString,
                                         FPrepTe.FieldByName('PRE_NUMLOT').AsString) Then
        Begin
          FPrepTe.Next;
          Continue;
        End;

        {Identifica qual preço será utilizado!}
        strTEPREV := fGetTEPREV(FPrepTe.FieldByName('PRE_EMPORI').AsString, FCliFil);

        strCodAbf := fGetCodAbf(FPrepTe.FieldByName('PRE_CODITE').AsString, fEmpOri);

        strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF','ABF_ESTADO'], [strCodAbf, fRetUFEmpresa(fEmpOri)]);

        strTipAbf := fGetTipoAbfCliente(FCliFil);

        If (fCfgSis('IMPCF4') = 'S') And (Not strTipAbf.IsEmpty) Then
          fltICMSai := fCampoTabela('ABF_ALQICM' + strTipAbf, 'ABFICM', ['ABF_CODABF','ABF_ESTADO'], [strCodAbf, fRetUFEmpresa(fEmpOri)])
        Else
          fltICMSai := FItens.FieldByName('ICMSAI').AsFloat;

        If CST_SUBSTITUICAO.Contains(strCodSit) Then
          fltFat_TE := fRetClienteFilialFatorTE_ST(FPrepTe.FieldByName('PRE_EMPORI').AsString, FCliFil)
        Else
          fltFat_TE := fRetClienteFilialFatorTE(FPrepTe.FieldByName('PRE_EMPORI').AsString, FCliFil);

        If (strTEPREV = 'IMP') Then
          fltTEPREV := FItens.FieldByName('IMPULT').AsFloat
        Else If (strTEPREV = 'SIC') Then
          fltTEPREV := FItens.FieldByName('MEDSIC').AsFloat
        Else If (strTEPREV = 'CFI') Then
          fltTEPREV := FItens.FieldByName('PRECUS').AsFloat
        Else If (strTEPREV = 'CSD') Then
        Begin

          fltTEPREV := fCalculaCustoReal(FItens.FieldByName('PRECUS').AsFloat,
                                         fltICMSai,
                                         FItens.FieldByName('IMPFED').AsFloat,
                                         0,
                                         FItens.FieldByName('OUTVAL').AsFloat);
        End
        Else If (strTEPREV = 'VDC') Then
          fltTEPREV := FItens.FieldByName('PRECUS').AsFloat - FItens.FieldByName('VALFRE').AsFloat
        Else
        Begin
          fltTEPREV := FItens.FieldByName('PRE' + strTEPREV).AsFloat;
        End;

        If fltTEPREV <= 0 Then
        Begin
          Raise ExceptionAutCom.Create('Está configurado no cadastro da empresa para utilizar o preço: '+strTEPREV+#13#10+
                                        'O item: '+FPrepTe.FieldByName('PRE_CODITE').AsString+' Está com valor zerado'+#13#10+
                                        'Ajuste essa informação para a correta geração do '+IIF(FEspDoc='PD','Pedido','Orçamento')+' de Transferência.');
        End;
        fltPrevenSemFator := fltTEPREV;
        If (fltFat_TE > 0) Then
          fltTEPREV := (fltTEPREV * fltFat_TE);
        fltTEPREV := fFormataFloat(fltTEPREV, fCfgSis('DECUNI', varInteger));
        If  fltTEPREV <= 0 then
        Begin
          Raise ExceptionAutCom.Create('Está configurado no cadastro da empresa para utilizar o preço: '+strTEPREV+#13#10+
                                       'O item: '+FPrepTe.FieldByName('PRE_CODITE').AsString +' Está com valor ' + fltPrevenSemFator.ToString + ' e fator de transferência ' + fltFat_TE.Tostring + #13#10 +
                                       'Isso faz com que o valor do item fique zero: ' + fltPrevenSemFator.ToString + ' * ' + fltFat_TE.ToString + ' = ' +  fltTEPREV.Tostring + #13#10+
                                       'não será possível fazer a geração do '+IIF(FEspDoc='PD','Pedido','Orçamento')+' de Transferência.');
        End;

        FTotGer := FTotGer + FPrepTe.FieldByName('PRE_QTDITE').AsFloat * fltTEPREV;
        FTotCus := FTotCus + FPrepTe.FieldByName('PRE_QTDITE').AsFloat * FItens.FieldByName('PRECUS').AsFloat;
        FTotMed := FTotMed + FPrepTe.FieldByName('PRE_QTDITE').AsFloat * FItens.FieldByName('PREMED').AsFloat;
        FPesBru := FPesBru + FPrepTe.FieldByName('PRE_QTDITE').AsFloat * FItens.FieldByName('PESOIT').AsFloat;

        If FSomLiq Then
          FPesLiq := FPesLiq + FPrepTe.FieldByName('PRE_QTDITE').AsFloat * FItens.FieldByName('PESLIQ').AsFloat
        Else
          FPesLiq := fFormataFloat(FPesBru * FFatLiq, 3);

      End;

      FPrepTe.Next;
    End;
    FPrepTe.First;

    FreeAndNil(stlItens);
  End;

End;

Function TPreparaGeracaoTE.fGeraPedido(strEmpDes, strDocAbs, strEspAbs, strEmpAbs: String): Boolean;
Begin
  Try
    Result := True;

    FPedidosVenda.Clear;

    FItens := fCriaQuery;

    FPrepTe  := fCriaQuery;
    FPrepTe.SQL.Text := fSQLSelecionaItens(strDocAbs, strEspAbs, strEmpAbs);

    With FPrepTe Do
    Begin

      ParamByName('EMPORI').AsString := fEmpOri;
      ParamByName('EMPDES').AsString := strEmpDes;

      If Not fEmptyStr(strDocAbs) Then
        ParamByName('DOCABS').AsString := strDocAbs;

      If Not fEmptyStr(strEspAbs) Then
        ParamByName('ESPABS').AsString := strEspAbs;

      If Not fEmptyStr(strEmpAbs) Then
        ParamByName('EMPABS').AsString := strEmpAbs;

      Open;

      pValidaRegistroComQtdZerada;

      fStartTransaction;

      If Not IsEmpty Then
      Begin

        FCliFil := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'], [FieldByName('PRE_EMPDES').AsString], False);
        If fEmptyStr(FCliFil) Then
          Raise ExceptionAutCom.Create('O "Cliente Filial" da empresa '+FieldByName('PRE_EMPDES').AsString+
                                       ' não está preenchido corretamente no Cadastro de Empresas!'+#13#10+
                                       'Ajuste essa informação para a correta geração do '+IIF(FEspDoc='PD','Pedido','Orçamento')+' de Transferência.');

        Result := fCarregaItens;

        If Result Then
          pSet_NumeroEspecieDocumento;

        Result := fGravaFatGorTE(strDocAbs, strEspAbs, strEmpAbs);

        If Result Then
        Begin

          While Not Eof Do
          Begin
            If fItemJaProcessadoComOutroLote(FPrepTe.FieldByName('PRE_CODITE').AsString,
                                             FPrepTe.FieldByName('PRE_NUMLOT').AsString) Then
            Begin
              Next;
              Continue;
            End;

            Edit;
            FieldByName('PRE_NUMDOC').AsString := FNumDoc;
            FieldByName('PRE_ESPDOC').AsString := FEspDoc;
            FieldByName('PRE_EMPDOC').AsString := fEmpOri;
            Post;

            Result := fGravaFatDorTE;

            Result := Result And fAtualizarDocumentoAbastecimentoMultiLoja(FNumDoc,
                                                                           FEspDoc,
                                                                           fEmpOri,
                                                                           FieldByName('PRE_DOCABS').AsString,
                                                                           FieldByName('PRE_ESPABS').AsString,
                                                                           FieldByName('PRE_EMPABS').AsString);

            If Not Result Then
              Break;

            pSet_INCFDO_REQVEN(strAutIncFdo, FPrepTe.FieldByName('AUTOINCREM').AsString);
            Next;

          End;
        End;

        If Result Then
        Begin
          pAtualizaStatusGeraOcorrenciaCRM(strDocAbs, strEspAbs, strEmpAbs);
          pRetornaNumeroDasRequisicoes(FNumDoc, FEspDoc);
        End;

      End;

    End;

    FreeAndNil(FPrepTe);
    FreeAndNil(FItens);

    If Result Then
      fCommit
    Else
      fRollBack;

    Result := True;

  Except
    On E: ExceptionAutCom Do
    Begin
      Result := False;
      fRollBack;
      fMensagem('Atenção', E.Message, ['&Ok']);
    End;

    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TPreparaGeracaoTE.fGeraPedido]');
    End;
  End;

End;

function TPreparaGeracaoTE.fGeraPedidoPorSolicitante(strEmpDes, strDocAbs, strEspAbs, strEmpAbs: String): Boolean;
var
  qrySolicitantes : TUniQuery;
const
  SQL_SOLICITANTES = 'SELECT                     '+
                     '  PRE_CODOPE               '+
                     'FROM                       '+
                     '  PREPTE P                 '+
                     'WHERE PRE_LIBERA = "S"     '+
                     '  AND PRE_NUMDOC IS NULL   '+
                     '  AND PRE_EMPORI = :EMPORI '+
                     '  AND PRE_EMPDES = :EMPDES '+
                     '  AND PRE_DOCABS IS NULL   '+
                     '  AND PRE_ESPABS IS NULL   '+
                     '  AND PRE_EMPABS IS NULL   '+
                     'GROUP BY                   '+
                     '  PRE_CODOPE               '+
                     'ORDER BY                   '+
                     '  PRE_CODOPE ';
Begin

  Result := True;

  qrySolicitantes := fCriaQuery;
  FItens          := fCriaQuery;
  FPrepTe         := fCriaQuery;

  Try

    qrySolicitantes.Close;
    qrySolicitantes.SQL.Clear;
    qrySolicitantes.SQL.Add(SQL_SOLICITANTES);
    qrySolicitantes.ParamByName('EMPORI').AsString := fEmpOri;
    qrySolicitantes.ParamByName('EMPDES').AsString := strEmpDes;
    qrySolicitantes.Open;

    qrySolicitantes.First;
    While Not qrySolicitantes.Eof Do
    Begin

      {*** Seta Solicitante ***}
      FCodOpe := qrySolicitantes.FieldByName('PRE_CODOPE').AsString;

      Try

        FPedidosVenda.Clear;

        FPrepTe.SQL.Text := fSQLSelecionaItens(strDocAbs, strEspAbs, strEmpAbs, FCodOpe);

        FPrepTe.ParamByName('EMPORI').AsString := fEmpOri;
        FPrepTe.ParamByName('EMPDES').AsString := strEmpDes;

        If Not fEmptyStr(strDocAbs) Then
          FPrepTe.ParamByName('DOCABS').AsString := strDocAbs;

        If Not fEmptyStr(strEspAbs) Then
          FPrepTe.ParamByName('ESPABS').AsString := strEspAbs;

        If Not fEmptyStr(strEmpAbs) Then
          FPrepTe.ParamByName('EMPABS').AsString := strEmpAbs;

        If Not fEmptyStr(FCodOpe) Then
          FPrepTe.ParamByName('CODOPE').AsString := FCodOpe;

        FPrepTe.Open;

        pValidaRegistroComQtdZerada;

        fStartTransaction;
        If Not FPrepTe.IsEmpty Then
        Begin

          FCliFil := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'], [FPrepTe.FieldByName('PRE_EMPDES').AsString], False);
          If fEmptyStr(FCliFil) Then
            Raise ExceptionAutCom.Create('O "Cliente Filial" da empresa '+FPrepTe.FieldByName('PRE_EMPDES').AsString+
                                         ' não está preenchido corretamente no Cadastro de Empresas!'+#13#10+
                                         'Ajuste essa informação para a correta geração do '+IIF(FEspDoc='PD','Pedido','Orçamento')+' de Transferência.');

          FOperadores.Clear;
          Result := fCarregaItens;

          If Result Then
            pSet_NumeroEspecieDocumento;

          Result := fGravaFatGorTE(strDocAbs, strEspAbs, strEmpAbs);

          If Result Then
          Begin

            While Not FPrepTe.Eof Do
            Begin
              If fItemJaProcessadoComOutroLote(FPrepTe.FieldByName('PRE_CODITE').AsString,
                                               FPrepTe.FieldByName('PRE_NUMLOT').AsString) Then
              Begin
                FPrepTe.Next;
                Continue;
              End;

              FPrepTe.Edit;
              FPrepTe.FieldByName('PRE_NUMDOC').AsString := FNumDoc;
              FPrepTe.FieldByName('PRE_ESPDOC').AsString := FEspDoc;
              FPrepTe.FieldByName('PRE_EMPDOC').AsString := fEmpOri;
              FPrepTe.Post;

              Result := fGravaFatDorTE;

              Result := Result And fAtualizarDocumentoAbastecimentoMultiLoja(FNumDoc,
                                                                             FEspDoc,
                                                                             fEmpOri,
                                                                             FPrepTe.FieldByName('PRE_DOCABS').AsString,
                                                                             FPrepTe.FieldByName('PRE_ESPABS').AsString,
                                                                             FPrepTe.FieldByName('PRE_EMPABS').AsString);

              If Not Result Then
                Break;

              pSet_INCFDO_REQVEN(strAutIncFdo, FPrepTe.FieldByName('AUTOINCREM').AsString);
              FPrepTe.Next;

            End;
          End;

          If Result Then
          Begin
            pAtualizaStatusGeraOcorrenciaCRM(strDocAbs, strEspAbs, strEmpAbs);
            pRetornaNumeroDasRequisicoes(FNumDoc, FEspDoc);
          End;

        End;

        If Result Then
          fCommit
        Else
          fRollBack;

        Result := True;

      Except
        On E: ExceptionAutCom Do
        Begin
          Result := False;
          fRollBack;
          fMensagem('Atenção', E.Message, ['&Ok']);
        End;

        On E: Exception Do
        Begin
          Result := False;
          fRollBack;
          pMensagensErro(E.Message, '[TPreparaGeracaoTE.fGeraPedidoPorSolicitante]');
        End;
      End;

      {...}
      qrySolicitantes.Next;

    End;

  Finally
    FreeAndNil(qrySolicitantes);
    FreeAndNil(FItens);
    FreeAndNil(FPrepTe);
  End;

End;

Function TPreparaGeracaoTE.fCndPagto(strCndPag: String = '01000'): String;
  Var
    qryAux: TUniQuery;
Begin
  qryAux := fCriaQuery;

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT SQL_NO_CACHE CND_CODIGO FROM CADCND');
    SQL.Add('WHERE CND_CNDPAG = "' + strCndPag + '" AND LOCATE('+ QuotedStr(fEmpOri) + ', CND_EMPACE)');
    SQL.Add('ORDER BY CND_CODIGO             ');
    Open;

    If fCfgSis('USACND', varBoolean) Then
      Result := FieldByName('CND_CODIGO').AsString
    Else
      Result := '';
  End;

  FreeAndNil(qryAux);
End;

procedure TPreparaGeracaoTE.pRestauraTransferenciasDefinidas;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT * FROM ITELIB_RES');
    qryConsulta.SQL.Add(' WHERE RES_INCRES = "'+AutincPedidoCompra+'"');
    qryConsulta.Open;

    While Not qryConsulta.Eof Do
    Begin
      FIteLib.Insert;
      FIteLib.FieldByName('CODITE').AsString := qryConsulta.FieldByName('RES_CODITE').AsString;
      FIteLib.FieldByName('DESITE').AsString := fRetNomProduto(qryConsulta.FieldByName('RES_CODITE').AsString);
      FIteLib.FieldByName('NUMLOT').AsString := qryConsulta.FieldByName('RES_NUMLOT').AsString;
      FIteLib.FieldByName('EMPORI').AsString := qryConsulta.FieldByName('RES_EMPORI').AsString;
      FIteLib.FieldByName('EMPDES').AsString := qryConsulta.FieldByName('RES_EMPDES').AsString;
      FIteLib.FieldByName('QTDITE').AsFloat  := qryConsulta.FieldByName('RES_QTDITE').AsFloat;
      FIteLib.FieldByName('INCRES').AsString := AutincPedidoCompra;
      FIteLib.Post;
      qryConsulta.Next;
    End;
  Finally
    FreeAndNil(qryConsulta)
  End;
  {}
end;

Procedure TPreparaGeracaoTE.pRetornaNumeroDasRequisicoes(
  strNumDoc, strEspDoc: String);
var
  qryRequisicao: TUniQuery;
  strRequisicoes: String;
begin
  qryRequisicao := fCriaQuery;

  try
    qryRequisicao.Close;
    qryRequisicao.SQL.Clear;
    qryRequisicao.SQL.Add('SELECT M.RCD_CODIGO');
    qryRequisicao.SQL.Add('FROM MOVRCD M');
    qryRequisicao.SQL.Add('INNER JOIN REQVEN R');
    qryRequisicao.SQL.Add('ON(M.AUTOINCREM = R.SEQ_MOVRCD)');
    qryRequisicao.SQL.Add('INNER JOIN FATDOR F');
    qryRequisicao.SQL.Add('ON(R.SEQ_FATDOR = F.AUTOINCREM)');
    qryRequisicao.SQL.Add('WHERE F.FDO_NUMDOC = :NUMDOC');
    qryRequisicao.SQL.Add('AND FDO_ESPDOC = :ESPDOC');
    qryRequisicao.SQL.Add('AND FDO_CODEMP = :CODEMP');
    qryRequisicao.SQL.Add('ORDER BY M.RCD_CODIGO');
    qryRequisicao.ParamByName('NUMDOC').AsString := strNumDoc;
    qryRequisicao.ParamByName('ESPDOC').AsString := strEspDoc;
    qryRequisicao.ParamByName('CODEMP').AsString := fEmpOri;
    qryRequisicao.Open;

    if qryRequisicao.IsEmpty then
      Exit;

    strRequisicoes := EmptyStr;

    while not qryRequisicao.Eof do
    begin
      if not fEmptyStr(strRequisicoes) then
        strRequisicoes := strRequisicoes + ';';

      strRequisicoes := strRequisicoes + qryRequisicao.FieldByName('RCD_CODIGO').AsString;
      qryRequisicao.Next;
    end;

    strRequisicoes := 'Requisições: ' + strRequisicoes;

    qryRequisicao.Close;
    qryRequisicao.SQL.Clear;
    qryRequisicao.SQL.Add('UPDATE FATGOR');
    qryRequisicao.SQL.Add('SET FGO_MEN001 = CONCAT(:REQUISICAO, " ", FGO_MEN001)');
    qryRequisicao.SQL.Add('WHERE FGO_NUMDOC = :NUMDOC');
    qryRequisicao.SQL.Add('AND FGO_ESPDOC = :ESPDOC');
    qryRequisicao.SQL.Add('AND FGO_CODEMP = :CODEMP');
    qryRequisicao.ParamByName('REQUISICAO').AsString := strRequisicoes;
    qryRequisicao.ParamByName('NUMDOC').AsString := strNumDoc;
    qryRequisicao.ParamByName('ESPDOC').AsString := strEspDoc;
    qryRequisicao.ParamByName('CODEMP').AsString := fEmpOri;
    qryRequisicao.ExecSQL;
  finally
    FreeAndNil(qryRequisicao);
  end;
end;

function TPreparaGeracaoTE.fRetornaSaldoFisico(strCodIte, strCodEmp: String; fltCNV_ML: Double): Double;
Var
  recSaldos,
  recSaldosML                 : TRecSaldos;
  fltSaldos                   : double;
  objSalLoj                   : TSaldoLojas;
Begin
  Try
    objSalLoj := TSaldoLojas.Create(nil);

    fltSaldos := fRetSaldosEmpresa(strCodIte, strCodEmp);

    objSalLoj.pCalculaSaldos(Nil,
                             recSaldos,
                             recSaldosML,
                             fltSaldos,
                             strCodEmp,
                             strCodEmp,
                             strCodIte,
                             fltCNV_ML,
                             fCfgSis('ENTFUT', varBoolean),
                             False,
                             fCfgSis('ORDPRO', varBoolean),
                             fCfgSis('CALSAL', varInteger));

    Result := recSaldos.fltEstFis;
  Finally
    FreeAndNil(objSalLoj);
  End;
end;

Function TPreparaGeracaoTE.fRetTabelaPreco(strCodCli, strCodVen: String): String;
  Var
    strTabPre,
    strTabSuj,
    strTabCli: String;
Begin
  strTabPre := '1';
  strTabCli := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  If fEmptyStr(strTabCli) And fCfgSis('HIETAB', VarBoolean) Then
    strTabCli := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [strCodVen], False);

  If (fCfgSis('UTAPTB') <> '0') Then
    strTabPre := fCfgSis('UTAPTB')
  Else If fCfgSis('SUGTBP', varBoolean) Then
  Begin
    strTabSuj := fCfgSis('TBPSUG');

    If strTabSuj <> '0' Then
    Begin
      strTabPre := strTabSuj;
    End
    Else If Not fEmptyStr(strTabCli) Then
      strTabPre := strTabCli
    Else If (fEmptyStr(strTabCli)) Then
    Begin
      If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
        strTabPre := fCfgSis('TBPRPD', varString);
    End;
  End

  Else If Not fEmptyStr(strTabCli) Then
    strTabPre := strTabCli
  Else If (fEmptyStr(strTabCli)) Then
  Begin
    If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
      strTabPre := fCfgSis('TBPRPD', varString);
  End;

  Result := strTabPre;
End;

Function TPreparaGeracaoTE.fGravaFatGorTE(Const strDocAbs, strEspAbs, strEmpAbs: String): Boolean;
  Var
    strZerTax,
    strTipFre,
    strEntFat,
    strTipPed,
    strMen001,
    strCodVen,
    strMen002: String;
    recServicos: TDadosServicos;
    objOcoCrm : TAtuOcoCrm;
    blnLibera,
    blnLibCom: Boolean;
    arrDuplic : TarrDuplicata;

    strTPDCEX    : String;
    strTIPEXP    : String;
    strEspDocAux : String;
Begin
  FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

  If Not FstrMen001Customizada.IsEmpty Then
    strMen001 := FstrMen001Customizada
  Else If FPedidosVenda.Count > 0 Then
    strMen001 := 'Ref. Ped.Venda: ' + FPedidosVenda.CommaText
  Else
    strMen001 := 'Solicitantes: ' + FOperadores.CommaText;

  strMen002 := '';

  FCliEst := fRetEstadoCliente(FCliFil);

  strTipFre := '9';
  strTipPed := 'A';
  strEntFat := 'S';
  strZerTax := 'S';
  blnLibera := FLibera;
  blnLibCom := False;

  strTPDCEX    := fCfgSis('TPDCEX', VarString, IIF(fEmptyStr(strEmpAbs), fEmpOri, strEmpAbs));
  strTIPEXP    := fCfgSis('TIPEXP', VarString, IIF(fEmptyStr(strEmpAbs), fEmpOri, strEmpAbs));
  strEspDocAux := IIF(fEmptyStr(strEspAbs), FEspDoc, strEspAbs);

  If (SameText(strTPDCEX, '2')) And
     ('3_4_'.Contains(strTIPEXP)) And
     (SameText(strEspDocAux, 'PD')) Then
  Begin
    strTipPed := '';
  End;

  FillChar(recServicos, Sizeof(recServicos) , #0);

  FPesBru := fFormataFloat(FPesBru, 3);

  If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
    objOcoCrm := fAtualizaInformacoesCRM(FNumDoc, FEspDoc, fEmpOri, FCliFil,'','',strLoginUsuarioLogado,IIF(FEspDoc = 'OR',afcOrcamento,afcPedido))
  Else
    objOcoCrm := Nil;

  If Assigned(objOcoCrm) Then
    objOcoCrm.strNomFrm := '[fGravaFatGorTE]';

  If (Not fEmptyStr(strDocAbs)) And (Not fEmptyStr(strEmpAbs)) And
    (Not fEmptyStr(strEspAbs)) Then
  Begin
    If Assigned(objOcoCrm) Then
      objOcoCrm.strInfAdc := '<<csq>><<csq>>Gerado por solicitação de transferência<<csq>>' +
                             'Documento de Origem: ' + strDocAbs + '<<csq>>'+
                             'Espécie de Origem  : ' + strEspAbs + '<<csq>>'+
                             'Empresa de Origem  : ' + strEmpAbs;

    blnLibera := (fCampoTabela('FGO_LIBERA',
                               'FATGOR',
                               ['FGO_NUMDOC', 'FGO_CODEMP', 'FGO_ESPDOC'],
                               [strDocAbs, strEmpAbs, strEspAbs]) > 0);

    blnLibCom := (fCampoTabela('FGO_LIBCOM',
                               'FATGOR',
                               ['FGO_NUMDOC', 'FGO_CODEMP', 'FGO_ESPDOC'],
                               [strDocAbs, strEmpAbs, strEspAbs]) = 0);

    strCodVen := fCampoTabela('FGO_CODVEN',
                               'FATGOR',
                               ['FGO_NUMDOC', 'FGO_CODEMP', 'FGO_ESPDOC'],
                               [strDocAbs, strEmpAbs, strEspAbs]);

    If Assigned(objOcoCrm) Then
      objOcoCrm.strCodOpe := iif(fEmptyStr(strCodVen), FCodOpe, strCodVen);
  End;

  FTabPre := fRetTabelaPreco(FCliFil, iif(fEmptyStr(strCodVen), FCodOpe, strCodVen));

  {ATUALIZANDO A TRANSPORTADORA - KM}
  FCodTra := fRetTransportadoraEntregaAtiva(FCliFil);

  If fEmptyStr(FCodTra) Then
    FCodTra := fCfgSis('TRASUG');

  Result := fGravaFatGor(FAutInc,
                     fEmpOri,
                     FNumDoc,
                     FEspDoc,
                     FCliFil,
                     iif(fEmptyStr(strCodVen), FCodOpe, strCodVen),
                     FCodTra,
                     '',
                     VS_Date,
                     fTime(),
                     FConPagMsk,
                     FCliEst,
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     0,
                     '',
                     '',
                     '',
                     '',
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     FTotGer,
                     FTotGer,
                     FTotCus,
                     FTotMed,
                     IIF(FEspDoc = 'OR', '1', strTipFre),
                     0,
                     FTotGer,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     FPesBru,
                     FPesLiq,
                     0,
                     arrDuplic,
                     '',
                     '',
                     strMen001,
                     strMen002,
                     False,
                     '',
                     '',
                     '',
                     0,
                     '',
                     '',
                     0.0,
                     0.0,
                     FCodOpe,
                     FCndPgo,
                     fGetForPag,
                     recServicos,
                     'N',
                     VS_Date,
                     0,
                     VS_Date,
                     '',
                     strTipPed,
                     '',
                     IIF(blnLibera, 1, 0),
                     strEntFat,
                     0,
                     FTabPre,
                     'N',
                     0.0,
                     '',
                     '',
                     False,
                     'N',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     blnLibera,
                     VS_Date,
                     strZerTax,
                     'V',
                     VS_Date,
                     'P',
                     0,
                     fAutIncEnderecoDeEntrega,
                     '',
                     '',
                     blnLibCom,
                     '',
                     Nil,
                     fEmpOri,
                     fEmpOri,
                     0,
                     0,
                     0,
                     '',
                     objOcoCrm,
                     '',
                     0,
                     0,
                     '',
                     '',
                     0,
                     '',
                     0,
                     '',
                     '',
                     '',
                     'N',
                     '',               // strNumGui
                     '',               // strOrcOri
                     '',               // strCodTpA
                     '',               // strPlaVei
                     '',               // strKm_Vei
                     '',               // strCodPor
                     '',               // strRelAba
                     False,            // blnGravarDavPv
                     false,            // blnAlterado
                     0,                // dtaImpSep
                     0,                // horImpSep
                     '',               // strNumPedRefOR
                     '',               // strEmpPedRefOR
                     '',               // strLatitu
                     '',               // strLongit
                     '',               // strRaio__
                     nil,              // objFazenda
                     'S',              // strEnvLib
                     0,                // fltFreRat
                     '',               // strNumPedAba
                     '',               // strEspPedAba
                     '',               // strEmpPedAba
                     '',               // strObsL01
                     '',               // strObsL02
                     'N',              // strVenPre
                     'N',              // strTemBri
                     'N',              // strEdiPes
                     0,                // fltTaxEnt
                     '',               // strCodSup
                     'N',              // strOrcEsp
                     '',               // strProspe
                     '',               // strCodOco
                     False,            // blnImpSfaPag
                     '',               // strCodEmbarcacao
                     0,                // fltDesOpeGor
                     '',               // strCliCon
                     '',               // strInRqCp
                     '',               // strOriGor
                     '',               // strBarCom
                     'S',              // strPD_Exp
                     0,                // dtaValOrc
                     '',               // strCodRot
                     0,                // fltTotBri
                     0,                // fltBolAdt
                     False,            // blnBolVen
                     0,                // fltTaxJur
                     'N',              // strFatTot
                     '',               // strTraRdp
                     '',               // strCliLoj
                     '',               // strSeqDmp
                     0,                // dtaDtFiCo
                     0,                // dtaDtInCo
                     0,                // dtaDtInSe
                     0,                // dtaDtBxSe
                     0,                // hraHrFiCo
                     0,                // hraHrInCo
                     0,                // hraHrInSe
                     0,                // hraHrBxSe
                     nil,              // cdsExpRet
                     'N',              // strUsaQue
                     '',               // strDocQue
                     '',               // strCodPrj
                     '',               // strTpOper
                     '',               // strNLeads
                     '',               // strCupDes
                     'S',              // strNotPau
                     0,                // dtaDtCtVn
                     0,                // fltVlCtVn
                     '',               // strCodCat
                     '',               // strMen003
                     '',               // strMen004
                     'GERACAO TE');    // strMen005
End;

class function TPreparaGeracaoTE.fGravarPreparaGeracaoTE_MultiLoja(strNumDoc,
                                                                   strEspDoc,
                                                                   strEmpDoc,
                                                                   strCodIte,
                                                                   strEmpOri,
                                                                   strEmpDes,
                                                                   strNumLot: String;
                                                                   fltQtdIte: Double;
                                                                   Var strAutInc: String;
                                                                   blnLibera: Boolean = True;
                                                                   strEmpIte: String = ''): Boolean;
  Var
    qryTemp: TUniQuery;
    blnTransacaoAberta: Boolean;

  procedure pInserirRegistroPrepTE;
  begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'INSERT INTO PREPTE (' +
        ' AUTOINCREM, PRE_EMPORI, PRE_EMPDES, PRE_CODITE, PRE_QTDITE, PRE_CODOPE, PRE_DTACAD, PRE_HORCAD, ' +
        ' PRE_NUMDOC, PRE_ESPDOC, PRE_EMPDOC, PRE_NUMLOT, PRE_LIBERA, PRE_DOCABS, PRE_ESPABS, PRE_EMPABS) ' +
        '   VALUES ( ' +
        ' :AUTINC, :EMPORI, :EMPDES, :CODITE, :QTDITE, :CODOPE, :DTACAD, :HORCAD, ' +
        ' :NUMDOC, :ESPDOC, :EMPDOC, :NUMLOT, :LIBERA, :DOCABS, :ESPABS, :EMPABS ) ';

    strAutInc := fRetAutoIncrem('PREPTE', VS_strCodEmp);
    qryTemp.ParamByName('AUTINC').AsString   := strAutInc;
    qryTemp.ParamByName('EMPORI').AsString   := strEmpOri;
    qryTemp.ParamByName('EMPDES').AsString   := strEmpDes;
    qryTemp.ParamByName('CODITE').AsString   := strCodIte;
    qryTemp.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    qryTemp.ParamByName('NUMLOT').AsString   := strNumLot;
    qryTemp.ParamByName('LIBERA').AsString   := IIF(blnLibera, 'S', 'N');
    qryTemp.ParamByName('DOCABS').AsString   := strNumDoc;
    qryTemp.ParamByName('ESPABS').AsString   := strEspDoc;
    qryTemp.ParamByName('EMPABS').AsString   := strEmpDoc;
    qryTemp.ParamByName('QTDITE').AsFloat    := fltQtdIte;
    qryTemp.ParamByName('DTACAD').AsDateTime := Trunc(fNow());
    qryTemp.ParamByName('HORCAD').AsDateTime := fNow() - Trunc(fNow());
    qryTemp.ParamByName('NUMDOC').Clear();
    qryTemp.ParamByName('ESPDOC').Clear();
    qryTemp.ParamByName('EMPDOC').Clear();
    qryTemp.ExecSQL();
  end;

  procedure pValidarEmpresas();
  begin
    If (Not fEmptyStr(strEmpIte)) And (strEmpIte = strEmpDoc) And (strEmpIte <> strEmpDes) Then
      Raise Exception.Create('ATENÇÃO! Houve uma inconsistência ao gerar a solicitação de abastecimento. '+#10+#13+
                             'A empresa de destino é diferente da empresa multi-lojas do pedido original.'+#10+#13+
                             'Por favor, entre em contato com a citel!');

  end;

begin
  Result := True;
  blnTransacaoAberta := fInTransaction();

  Try
    qryTemp := fCriaQuery(nil);

    Try
      If (Not blnTransacaoAberta) Then
        fStartTransaction();

      pValidarEmpresas();
      pInserirRegistroPrepTE();

      If (Not blnTransacaoAberta) Then
        fCommit();
    Except
      On E: Exception Do
      Begin
        Result := False;
          fRollBack;
        pMensagensErro(E.Message, '[TPreparaGeracaoTE.fGravarPreparaGeracaoTE_MultiLoja]');
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

Function TPreparaGeracaoTE.fSQLItem(strItens: String): String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE   ';
  strSQL := strSQL + '   I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   I.ITE_CODMAR AS CODMAR, ';
  strSQL := strSQL + '   I.ITE_CODUNI AS UNIDAD, ';
  strSQL := strSQL + '   I.ITE_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   I.ITE_PESOIT AS PESOIT, ';
  strSQL := strSQL + '   I.ITE_PESLIQ AS PESLIQ, ';
  strSQL := strSQL + '   I.ITE_INCPIS AS INCPIS, ';
  strSQL := strSQL + '   G.ITE_PRECUS AS UNITAR, ';
  strSQL := strSQL + '   G.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '   G.ITE_PREMED AS PREMED, ';
  strSQL := strSQL + '   G.ITE_IMPULT AS IMPULT, ';
  strSQL := strSQL + '   G.ITE_MEDSIC AS MEDSIC, ';
  strSQL := strSQL + '   G.ITE_PREULT AS PREULT, ';
  strSQL := strSQL + '   G.ITE_PREVE1 AS PREVE1, ';
  strSQL := strSQL + '   G.ITE_PREVE2 AS PREVE2, ';
  strSQL := strSQL + '   G.ITE_PREVE3 AS PREVE3, ';
  strSQL := strSQL + '   G.ITE_PREVE4 AS PREVE4, ';
  strSQL := strSQL + '   G.ITE_PREVE5 AS PREVE5, ';
  strSQL := strSQL + '   G.ITE_PREVE6 AS PREVE6, ';
  strSQL := strSQL + '   G.ITE_PREVE7 AS PREVE7, ';
  strSQL := strSQL + '   G.ITE_ICMSAI AS ICMSAI, ';
  strSQL := strSQL + '   G.ITE_IMPFED AS IMPFED, ';
  strSQL := strSQL + '   G.ITE_OUTVAL AS OUTVAL  ';
  strSQL := strSQL + ' FROM  ';
  strSQL := strSQL + '   CADITE I  ';
  strSQL := strSQL + ' INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND ';
  strSQL := strSQL + '                        G.ITE_CODEMP = :CODEMP ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '   I.ITE_CODITE IN (' + strItens + ') ';

  Result := strSQL;
End;

function TPreparaGeracaoTE.fSQLPedidosLiberacao: String;
begin
  Result :=
    ' SELECT ' +
    '   B.FGO_NUMDOC, ' +
    '   B.FGO_ESPDOC, ' +
    '   B.FGO_CODEMP ' +
    ' FROM ' +
    '   FATGOR A ' +
    '   INNER JOIN EXTGOR C ' +
    '     ON C.FGO_SEQFGO = A.AUTOINCREM ' +
    '   INNER JOIN FATGOR B ' +
    '     ON C.FGO_NMPDAB = B.FGO_NUMDOC ' +
    '     AND C.FGO_ESPDAB = B.FGO_ESPDOC ' +
    '     AND C.FGO_EMPDAB = B.FGO_CODEMP ' +
    '   INNER JOIN EXTGOR D ' +
    '     ON D.FGO_SEQFGO = B.AUTOINCREM ' +
    ' WHERE A.FGO_JAFATU = 0 ' +
    '   AND A.FGO_ESPDOC = "PD" '+
    '   AND A.FGO_CODEMP = ' + fEmpOri.QuotedString +
    '   AND ( ' +
    '     (A.FGO_LIBERA <> B.FGO_LIBERA) ' +
    '     OR (A.FGO_LIBCOM <> B.FGO_LIBCOM) ' +
    '     OR (C.FGO_ENVLIB <> D.FGO_ENVLIB) ' +
    '   ) ';
end;

Function TPreparaGeracaoTE.fGravaFatDorTE: Boolean;
  Var
    fltTotPes,
    fltTotGer,
    fltTotCus,
    fltTotMed,
    fltQtdIte,
    fltTEPREV,
    fltFat_TE,
    fltICMSai : Double;

    strDocAbs,
    strEmpAbs,
    strEspAbs,
    strCodVen,
    strDesIte,
    strTEPREV,
    strCodAbf,
    strCodSit,
    strEntRet,
    strTipAbf: String;
Begin
  fltQtdIte := FPrepTe.FieldByName('PRE_QTDITE').AsFloat;

  If Not FItens.Locate('CODITE', FPrepTe.FieldByName('PRE_CODITE').AsString, []) Then
  Begin
    Result := False;
    pMensagemOk('Item ' + FPrepTe.FieldByName('PRE_CODITE').AsString + ' não localizado!');
    Exit;
  End;

  strDocAbs := FPrepTe.FieldByName('PRE_DOCABS').AsString;
  strEmpAbs := FPrepTe.FieldByName('PRE_EMPABS').AsString;
  strEspAbs := FPrepTe.FieldByName('PRE_ESPABS').AsString;

  If fCfgSis('UTIROM', varString) = 'S' Then
  Begin
    If fCfgSis('SUG_TE', varBoolean) Then
      strEntRet := 'E'  // Entrega
    Else
      strEntRet := 'R'; // Retira
  End
  Else
  Begin
    strEntRet:=  IIf(VS_strExpRetiraEntregaDocFat = 'T', 'E', VS_strExpRetiraEntregaDocFat);
  End;

  {Identifica qual preço será utilizado!}
  strTEPREV := fGetTEPREV(FPrepTe.FieldByName('PRE_EMPORI').AsString, FCliFil);

  strCodAbf := fGetCodAbf(FPrepTe.FieldByName('PRE_CODITE').AsString, fEmpOri);

  strCodSit := fCampoTabela('ABF_CODSIT_SAI_CCO', 'ABFICM', ['ABF_CODABF','ABF_ESTADO'], [strCodAbf, fRetUFEmpresa(fEmpOri)]);

  strTipAbf := fGetTipoAbfCliente(FCliFil);

  If (fCfgSis('IMPCF4') = 'S') And (Not strTipAbf.IsEmpty) Then
    fltICMSai := fCampoTabela('ABF_ALQICM' + strTipAbf, 'ABFICM', ['ABF_CODABF','ABF_ESTADO'], [strCodAbf, fRetUFEmpresa(fEmpOri)])
  Else
    fltICMSai := FItens.FieldByName('ICMSAI').AsFloat;

  If CST_SUBSTITUICAO.Contains(strCodSit) Then
    fltFat_TE := fRetClienteFilialFatorTE_ST(FPrepTe.FieldByName('PRE_EMPORI').AsString, FCliFil)
  Else
    fltFat_TE := fRetClienteFilialFatorTE(FPrepTe.FieldByName('PRE_EMPORI').AsString, FCliFil);

  If (strTEPREV = 'IMP') Then
    fltTEPREV := FItens.FieldByName('IMPULT').AsFloat
  Else If (strTEPREV = 'SIC') Then
    fltTEPREV := FItens.FieldByName('MEDSIC').AsFloat
  Else If (strTEPREV = 'CFI') Then
    fltTEPREV := FItens.FieldByName('PRECUS').AsFloat
  Else If (strTEPREV = 'CSD') Then
  Begin

    fltTEPREV := fCalculaCustoReal(FItens.FieldByName('PRECUS').AsFloat,
                                   fltICMSai,
                                   FItens.FieldByName('IMPFED').AsFloat,
                                   0,
                                   FItens.FieldByName('OUTVAL').AsFloat);
  End
  Else
  Begin
    fltTEPREV := FItens.FieldByName('PRE' + strTEPREV).AsFloat;
  End;

  If (fltFat_TE > 0) Then
    fltTEPREV := (fltTEPREV * fltFat_TE);

  fltTEPREV := fFormataFloat(fltTEPREV, fCfgSis('DECUNI', varInteger));

  fltTotGer := (fltQtdIte * fltTEPREV);
  fltTotCus := (fltQtdIte * FItens.FieldByName('PRECUS').AsFloat);
  fltTotMed := (fltQtdIte * FItens.FieldByName('PREMED').AsFloat);
  fltTotPes := (fltQtdIte * FItens.FieldByName('PESOIT').AsFloat);

  strDesIte := FItens.FieldByName('DESITE').AsString;

  If (fCfgSis('IMPREF', varBoolean)) Then
  Begin
    If (fCfgSis('MONDES', varString) = '1') Then
      strDesIte := strDesIte +
                   IIF(Not fEmptyStr(FItens.FieldByName('REFERE').AsString), ' ' + FItens.FieldByName('REFERE').AsString, '')
    Else
      strDesIte := IIF(Not fEmptyStr(FItens.FieldByName('REFERE').AsString), FItens.FieldByName('REFERE').AsString + ' ', '') +
                   strDesIte;
  End;

  if (not fEmptyStr(strDocAbs)) and
     (not fEmptyStr(strEmpAbs)) and
     (not fEmptyStr(strEspAbs)) then
  begin
    strCodVen := fCampoTabela('FGO_CODVEN',
                               'FATGOR',
                               ['FGO_NUMDOC', 'FGO_CODEMP', 'FGO_ESPDOC'],
                               [strDocAbs, strEmpAbs, strEspAbs]);
  end;

  strAutIncFdo := '';
  Result := fGravaFatDor(strAutIncFdo,
                         FAutInc,
                         fEmpOri,
                         FCliFil,
                         iif(fEmptyStr(strCodVen), FCodOpe, strCodVen),
                         FItens.FieldByName('CODITE').AsString,
                         FItens.FieldByName('CODMAR').AsString,
                         '',
                         FNumDoc,
                         FEspDoc,
                         '',
                         VS_Date,
                         fTime(),
                         FConPagMsk,
                         FCliEst,
                         strDesIte,
                         FItens.FieldByName('REFERE').AsString,
                         FItens.FieldByName('UNIDAD').AsString,
                         FItens.FieldByName('CODFOR').AsString,
                         fltQtdIte,
                         fltTEPREV,
                         fltTEPREV,
                         fltTEPREV,
                         fltTotGer,
                         fltTotGer,
                         fltTotCus,
                         fltTotMed,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         FCodOpe,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         copy(VS_strClaVen,1,4),
                         '000',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         fltTotGer,
                         0.0,
                         0.0,
                         0.0,
                         fltTotPes,
                         0.0,
                         0.0,
                         False,
                         '',
                         '',
                         '',
                         0,
                         '',
                         '',
                         0.0,
                         'NOR',
                         FItens.FieldByName('INCPIS').AsString,
                         FCodOpe,
                         FCndPgo,
                         '',
                         fGetForPag,
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         '',
                         '',
                         0,
                         'N',
                         '',
                         0.0,
                         FPrepTe.RecNo,
                         0.0,
                         fltTEPREV,
                         '',
                         0.0,
                         '',
                         '',
                         FALSE,
                         FTabPre,
                         '',
                         '',
                         '',
                         0.0,
                         '',
                         0.0,
                         strEntRet, //IIf(VS_strExpRetiraEntregaDocFat = 'T', 'E', VS_strExpRetiraEntregaDocFat),
                         '',
                         'N',
                         '',
                         0,
                         fltTotCus,
                         0,
                         0,
                         '',
                         FPrepTe.FieldByName('PRE_NUMLOT').AsString,
                         '',
                         False,
                         IIF(FEmpFat, fEmpOri, ''),
                         '',
                         '',
                         '',
                         '',
                         '',
                         0,
                         0,
                         '',
                         '',
                         0,
                         '',
                         '',
                         0,
                         0,
                         FItens.FieldByName('PESOIT').AsFloat);
End;

Function TPreparaGeracaoTE.fGeraTodos(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;

  With FEmpresas Do
  Begin
    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    While Not Eof Do
    Begin
      FDocsAbs.Close;
      FDocsAbs.ParamByName('EMPORI').AsString := fEmpOri;
      FDocsAbs.ParamByName('EMPDES').AsString := FieldByName('PRE_EMPDES').AsString;
      FDocsAbs.Open;
      FDocsAbs.First;

      While Not FDocsAbs.Eof Do
      Begin
        FDicItemLote.Clear;

        If (FTipoDefinicaoDoVendedorNosPedidosGeradosDeTE.AgruparPorVendedorSolicitante) Then
        Begin
          Result := fGeraPedidoPorSolicitante(FieldByName('PRE_EMPDES').AsString,
                                              FDocsAbs.FieldByName('PRE_DOCABS').AsString,
                                              FDocsAbs.FieldByName('PRE_ESPABS').AsString,
                                              FDocsAbs.FieldByName('PRE_EMPABS').AsString);
        End;

        Result := Result And fGeraPedido(FieldByName('PRE_EMPDES').AsString,
                                         FDocsAbs.FieldByName('PRE_DOCABS').AsString,
                                         FDocsAbs.FieldByName('PRE_ESPABS').AsString,
                                         FDocsAbs.FieldByName('PRE_EMPABS').AsString);

        If Not Result Then
          Break;

        FDocsAbs.Next;
      End;

      Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

  End;
End;

function TPreparaGeracaoTE.fGetForPag: String;
begin
  Result := IIF(fCfgSis('USAFPG', varBoolean), IIF(fEmptyStr(FForPag), '001', FForPag), '');
end;

Function TPreparaGeracaoTE.fPedidoBloqueado: Boolean;
begin

  Result := False;

  If (fCfgSis('LPPDBL') = 'S') Then
  Begin
    {*********************************************}
    {* BLOQUEIA PEDIDOS A VISTA CASO CONFIGURADO *}
    {******************************************LA*}
    If (fCfgSis('LIBVIS') = 'S') And (fStatusCndPag(FConPagMsk) = A_VISTA) Then
    Begin
      Result := True;
    End;

  End
  Else
  Begin
    Result := True;
  End;

end;

Function TPreparaGeracaoTE.fGeraPedidosVenda: Boolean;
Var
  strEmpFis: String;
    frmAguarde: TfrmGravando;
Begin
  Result := True;

  strEmpFis := fCfgSis('EMPPRO');

  If (Not fEmptyStr(strEmpFis)) And (fRetEmpresaFisica <> strEmpFis) Then
    Exit;

  If Not fLock_Unlock('PEDIDOS_PREPARACAO_TE_' + fRetEmpresaFisica, True, False) Then
    Exit;

  FEmpresas := fCriaQuery;
  FDocsAbs  := fCriaQuery;
  FLiberar  := fCriaQuery;

  Try
    Try
      With FEmpresas Do
      Begin
        FDocsAbs.SQL.Text := fSQLSelecionaDocsAbs;

        SQL.Text := fSQLSelecionaEmpresas;
        ParamByName('EMPORI').AsString := fEmpOri;
        Open;

        If Not IsEmpty Then
        Begin
          If fEmptyStr(fCfgSis('CNDPTE')) Then
          Begin
            If Not fCarregarConfigParaGerarOrcamento(FConPagMsk, FCndPgo, FForPag, FieldByName('EMP_CLIFIL').AsString) Then
            Begin
              FCndPgo    := fCndPagto;
              FConPagMsk := '01000';
              FForPag    := '001';
            End;

            If fCfgSis('USACND', varBoolean) And fEmptyStr(FCndPgo) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não há nenhuma condição de pagamento à vista que a empresa "'+VS_strCodEmp+'" tenha acesso para que o sistema possa gerar os pedidos/orçamentos de transferência de estoque.'+#10#13+
                                    'Antes de continuar, acesse o cadastro de condição de pagamento e altere o acesso da empresa a uma condição à vista ou informe uma condição de pagamento válida na configuração: "'+'CFG_CNDPTE - '+fRetNomCfg('CNDPTE')+'"', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 250);
              Result := False;
              Exit;
            End;
          End
          Else
          Begin
            If fCfgSis('USACND', varBoolean) Then
            Begin
              FCndPgo    := fCfgSis('CNDPTE');
              FConPagMsk := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [FCndPgo], False);
              FForPag    := fCampoTabela('CND_CODFPG', 'CADCND', ['CND_CODIGO'], [FCndPgo], False);
              If fEmptyStr(FForPag) Then
              Begin
                If fStatusCndPag(FConPagMsk) = A_VISTA Then
                  FForPag := '001'
                Else
                  FForPag := '008'
              End;
            End
            Else
            Begin
              FCndPgo    := '';
              FConPagMsk := fCfgSis('CNDPTE');
              If fStatusCndPag(FConPagMsk) = A_VISTA Then
                FForPag := '001'
              Else
                FForPag := '008'
            End;
          End;

          FEmpFat := fCfgSis('EMPFAT', varBoolean);
          FLibera := Not fPedidoBloqueado;
          FSomLiq := fCfgSis('PESLIQ') = 'SOMA';
          FFatLiq := fCfgSis('FATPLI', varDouble);

          pCriarFormularios(TfrmGravando, frmAguarde);
          Try
            frmAguarde.lblGravando.Caption := 'Aguarde, gerando pedidos de transferência de estoque...';
            frmAguarde.fExecutarAcao := fGeraTodos;
            frmAguarde.ShowModal;
          Finally
            pFreeAndNil(frmAguarde);
          End;
        End;

        Close;
      End;

      With FLiberar Do
      Begin
        SQL.Text := fSQLPedidosLiberacao;
        Open;

        If Not IsEmpty Then
        Begin
          pCriarFormularios(TfrmGravando, frmAguarde);
          Try
            frmAguarde.lblGravando.Caption := 'Aguarde, Liberando pedidos de transferência ...';
            frmAguarde.fExecutarAcao := fAtualizarDadosLiberacaoPedidosTransferencia;
            frmAguarde.ShowModal;
          Finally
            pFreeAndNil(frmAguarde);
          End;
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TPreparaGeracaoTE.fGeraPedidosVenda]');
      End;
    End;
  Finally
    fLock_Unlock('PEDIDOS_PREPARACAO_TE_' + fRetEmpresaFisica, False, False);

    If Assigned(FEmpresas) Then
      FreeAndNil(FEmpresas);

    If Assigned(FDocsAbs) Then
      FreeAndNil(FDocsAbs);

    If Assigned(FLiberar) Then
      FreeAndNil(FLiberar);
  End;
End;

Function TPreparaGeracaoTE.fSQLSelecionaItensLiberacao: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + ' P.AUTOINCREM AS AUTINC, ';
  strSQL := strSQL + '   PRE_CODITE AS CODITE, ';
  strSQL := strSQL + '   ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   PRE_QTDITE AS QTDITE, ';
  strSQL := strSQL + '   PRE_EMPORI AS EMPORI, ';
  strSQL := strSQL + '   PRE_EMPDES AS EMPDES, ';
  strSQL := strSQL + '   IFNULL(PRE_NUMLOT,"") AS NUMLOT, ';
  strSQL := strSQL + '   PRE_CODOPE AS CODOPE, ';
  strSQL := strSQL + '   PRE_DTACAD AS DTACAD, ';
  strSQL := strSQL + '   PRE_HORCAD AS HORCAD, ';
  strSQL := strSQL + '   PRE_LIBERA AS LIBERA, ';
  strSQL := strSQL + '   CONCAT(ITE_CODFOR,"-",';
  strSQL := strSQL + '   FOR_NOMFOR) AS NOMFOR,';
  strSQL := strSQL + '       0.0000 AS SALORI, ';
  strSQL := strSQL + '       0.0000 AS SALDES, ';
  strSQL := strSQL + '   ITE_CNV_ML AS CNV_ML, ';
  strSQL := strSQL + '   CAST("" AS CHAR(20)) AS INCRES ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   PREPTE P ';

  strSQL := strSQL + ' INNER JOIN CADITE ON ITE_CODITE = PRE_CODITE ';
  strSQL := strSQL + ' LEFT  JOIN CADFOR ON FOR_CODFOR = ITE_CODFOR ';
  strSQL := strSQL + ' LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  strSQL := strSQL + ' WHERE ';

  If FAculumarDigitacao Then
  Begin

    strSQL := strSQL + ' FALSE ';

  End Else
  Begin

    strSQL := strSQL + '   PRE_LIBERA = "N"     AND ';
    strSQL := strSQL + '   PRE_NUMDOC IS NULL       ';

  End;

  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   DESITE, DTACAD, HORCAD ';

  Result := strSQL;
End;

Function TPreparaGeracaoTE.fSQLUpdateIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' UPDATE PREPTE SET ';
  strSQL := strSQL + '   PRE_LIBERA = "S" ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   AUTOINCREM = :AUTOIN ';

  Result := strSQL;
End;

Function TPreparaGeracaoTE.fSQLDeleteIte: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' DELETE FROM PREPTE  ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   AUTOINCREM = :AUTOIN ';

  Result := strSQL;
End;

Class Function TPreparaGeracaoTE.fLiberaItensDocumento(strNumDoc, strEspDoc, strEmpDoc: String):Boolean;
Var
  qryLib: TUniQuery;
begin
  qryLib := fCriaQuery();

  Try
    qryLib.SQL.Add(' UPDATE PREPTE SET          ');
    qryLib.SQL.Add('   PRE_LIBERA = "S"         ');
    qryLib.SQL.Add(' WHERE                      ');
    qryLib.SQL.Add('   PRE_DOCABS = :DOCABS AND ');
    qryLib.SQL.Add('   PRE_ESPABS = :ESPABS AND ');
    qryLib.SQL.Add('   PRE_EMPABS = :EMPABS     ');

    qryLib.ParamByName('DOCABS').AsString := strNumDoc;
    qryLib.ParamByName('ESPABS').AsString := strEspDoc;
    qryLib.ParamByName('EMPABS').AsString := strEmpDoc;

    qryLib.ExecSQL;

    Result := True;

  Finally
    FreeAndNil(qryLib);
  End;
end;

Function TPreparaGeracaoTE.fSelecionaItensLiberacao: Boolean;
Begin
  If Not Assigned(FUpdateIte) Then
  Begin
    FUpdateIte := fCriaQuery;
    FUpdateIte.SQL.Text := fSQLUpdateIte;
    FIteLib    := TZClient.Create(Nil, fSQLSelecionaItensLiberacao);
  End;

  If Not Assigned(FDeleteIte) Then
  Begin
    FDeleteIte := fCriaQuery;
    FDeleteIte.SQL.Text := fSQLDeleteIte;
  End;

  Result := FIteLib.fAbreClient(True, 'TPreparaGeracaoTE.fSelecionaItensLiberacao');

  If Not FIteLib.IsEmpty Then
    pCarregaSaldos;

  FIteLib.pAlinhaCampoCentro('CODITE');
  FIteLib.pAlinhaCampoCentro('EMPORI');
  FIteLib.pAlinhaCampoCentro('EMPDES');
  FIteLib.pAlinhaCampoCentro('CODOPE');
  FIteLib.pAlinhaCampoCentro('DTACAD');
  FIteLib.pAlinhaCampoCentro('HORCAD');
End;

Procedure TPreparaGeracaoTE.pLiberaRegistro(strAutInc: String);
Begin
  With FUpdateIte Do
  Begin
    Close;
    ParamByName('AUTOIN').AsString := strAutInc;
    ExecSQL;
  End;
End;

procedure TPreparaGeracaoTE.pAtualizaAutoincremPedido;
begin
  If Assigned(FIteLib) Then
  If AutincPedidoCompra<> '' Then
  Begin
    FIteLib.First;
    while not FIteLib.Eof Do
    Begin
      If FIteLib.FieldByName('INCRES').AsString = '' Then
      Begin
        FIteLib.Edit;
        FIteLib.FieldByName('INCRES').AsString := AutincPedidoCompra;
        FIteLib.Post;
        pInsereITELIB_RES
      End;
      FIteLib.Next;
    End;
  End;
  {}
end;

procedure TPreparaGeracaoTE.pAtualizaStatusGeraOcorrenciaCRM(strDocAbs, strEspAbs, strEmpAbs: String);
begin

  {Atualiza status pedido criado}
  TUpdateStatus.New(TParamStatus.New()
                      .NumDoc(FNumDoc)
                      .EspDoc(FEspDoc)
                      .CodEmp(fEmpOri)).pExecute();

  {Gera ocorrência CRM}
  If (VS_strHabilitarCRM) Then
    TUpdateOccurrenceCRM.New()
      .NumDoc(FNumDoc)
      .EspDoc(FEspDoc)
      .CodEmp(fEmpOri)
      .AcaFat(afcPDTransferenciaGerado)
      .strNomFrm('[TPreparaGeracaoTE.pAtualizaStatusGeraOcorrenciaCRM]')
      .pRun();

  {Atualiza status pedido origem}
  TUpdateStatus.New(TParamStatus.New()
                      .NumDoc(strDocAbs)
                      .EspDoc(strEspAbs)
                      .CodEmp(strEmpAbs)).pExecute();

end;

procedure TPreparaGeracaoTE.pCarregaSaldos;
begin
  If Assigned(FIteLib) Then
  Begin
    FIteLib.First;
    while not FIteLib.Eof Do
    Begin
      FIteLib.Edit;
      FIteLib.FieldByName('SALORI').AsFloat := fRetornaSaldoFisico(FIteLib.FieldByName('CODITE').AsString,
                                                                   FIteLib.FieldByName('EMPORI').AsString,
                                                                   FIteLib.FieldByName('CNV_ML').AsFloat);
      FIteLib.FieldByName('SALDES').AsFloat := fRetornaSaldoFisico(FIteLib.FieldByName('CODITE').AsString,
                                                                   FIteLib.FieldByName('EMPDES').AsString,
                                                                   FIteLib.FieldByName('CNV_ML').AsFloat);
      FIteLib.Post;
      FIteLib.Next;
    End;
  End;
end;

procedure TPreparaGeracaoTE.pDefinicaoDoVendedor;
begin
  FTipoDefinicaoDoVendedorNosPedidosGeradosDeTE := fCfgSis('VEN_TE', varInteger);
  FCodOpe := FTipoDefinicaoDoVendedorNosPedidosGeradosDeTE.GetValue;
end;

Procedure TPreparaGeracaoTE.pExcluiRegistro(strAutInc: String);
Begin
  With FDeleteIte Do
  Begin
    Close;
    ParamByName('AUTOIN').AsString := strAutInc;
    ExecSQL;
  End;
End;

Function TPreparaGeracaoTE.fLiberaItensLoop(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Try
    With FIteLib Do
    Begin
      DisableControls;
      pgbProgresso.Position       := 0;
      pgbProgresso.Properties.Max := RecordCount;
      Application.ProcessMessages;

      Filter   := 'LIBERA = ' + QuotedStr('S');
      Filtered := True;

      First;

      fStartTransaction;
      While Not Eof Do
      Begin
        pLiberaRegistro(FieldByName('AUTINC').AsString);

        Next;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
      End;


      fCommit;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TPreparaGeracaoTE.fLiberaItensLoop]');
    End;
  End;

  FIteLib.Filtered := False;
  FIteLib.EnableControls;
End;

Function TPreparaGeracaoTE.fLiberaItens: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Liberando itens...';
    frmGravando.fExecutarAcao := fLiberaItensLoop;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TPreparaGeracaoTE.fLiberaItens]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Function TPreparaGeracaoTE.fExcluiItensLoop(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Try
    With FIteLib Do
    Begin
      DisableControls;
      If fTemRegistrosMarcados Then
      Begin
        Filter   := 'LIBERA = ' + QuotedStr('S');
        Filtered := True;
        First;
        pgbProgresso.Position       := 0;
        pgbProgresso.Properties.Max := RecordCount;
        Application.ProcessMessages;
        fStartTransaction;
        While Not Eof Do
        Begin
          pExcluiRegistro(FieldByName('AUTINC').AsString);
          Next;
          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;
        End;
        fCommit;
      End
      Else
      Begin
        fStartTransaction;
        pExcluiRegistro(cdsIteLib.FieldByName('AUTINC').AsString);
        fCommit;
      End;
    End;
    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TPreparaGeracaoTE.fExcluiItensLoop]');
    End;
  End;

  FIteLib.Filtered := False;
  FIteLib.EnableControls;
End;

Function TPreparaGeracaoTE.fExcluiItens: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Excluindo itens...';
    frmGravando.fExecutarAcao := fExcluiItensLoop;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TPreparaGeracaoTE.fexcluiItens]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Function TPreparaGeracaoTE.fMarcaTodosLoop(pgbProgresso: TcxProgressBar): Boolean;
Begin
  With FIteLib Do
  Begin
    DisableControls;
    pgbProgresso.Position       := 0;
    pgbProgresso.Properties.Max := RecordCount;
    Application.ProcessMessages;

    First;
    While Not Eof Do
    Begin
      Edit;
      If FLibReg Then
        FieldByName('LIBERA').AsString := 'S'
      Else
        FieldByName('LIBERA').AsString := 'N';
      Post;

      Next;

      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    EnableControls;
  End;

  Result := True;
End;

Function TPreparaGeracaoTE.fMarcaTodos(blnMarcar: Boolean): Boolean;
Begin
  Try
    FLibReg := blnMarcar;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Atualizando itens...';
    frmGravando.fExecutarAcao := fMarcaTodosLoop;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TPreparaGeracaoTE.fMarcaTodos]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Procedure TPreparaGeracaoTE.pMarcaDesmarca;
Begin

  With FIteLib Do
  Begin
    If IsEmpty Then
      Exit;

    Edit;
    If FieldByName('LIBERA').AsString = 'S' Then
      FieldByName('LIBERA').AsString := 'N'
     Else
      FieldByName('LIBERA').AsString := 'S';
    Post;
  End;

End;

class procedure TPreparaGeracaoTE.pRegravarDadosPreparacaoTransferencia(
  qryPrepTe: TUniQuery);
  var
    recDados: TDadosPrepTe;
begin
  If (Not Assigned(qryPrepTe)) Then
    Exit;

  If (Not qryPrepTe.Active) Then
    Exit;

  If (qryPrepTe.IsEmpty) Then
    Exit;

  qryPrepTe.First;
  While Not qryPrepTe.Eof Do
  Begin
    FillChar(recDados, SizeOf(recDados), #0);
    recDados.strAutInc := qryPrepTe.FieldByName('AUTOINCREM').AsString;
    recDados.strCodIte := qryPrepTe.FieldByName('PRE_CODITE').AsString;
    recDados.strCodOpe := qryPrepTe.FieldByName('PRE_CODOPE').AsString;
    recDados.strDocAbs := qryPrepTe.FieldByName('PRE_DOCABS').AsString;
    recDados.dtaDtaCad := qryPrepTe.FieldByName('PRE_DTACAD').AsDateTime;
    recDados.strEmpAbs := qryPrepTe.FieldByName('PRE_EMPABS').AsString;
    recDados.strEmpDes := qryPrepTe.FieldByName('PRE_EMPDES').AsString;
    recDados.strEmpDoc := qryPrepTe.FieldByName('PRE_EMPDOC').AsString;
    recDados.strEmpOri := qryPrepTe.FieldByName('PRE_EMPORI').AsString;
    recDados.strEspAbs := qryPrepTe.FieldByName('PRE_ESPABS').AsString;
    recDados.strEspDoc := qryPrepTe.FieldByName('PRE_ESPDOC').AsString;
    recDados.dtaHorCad := qryPrepTe.FieldByName('PRE_HORCAD').AsDateTime;
    recDados.strLibera := qryPrepTe.FieldByName('PRE_LIBERA').AsString;
    recDados.strNumDoc := qryPrepTe.FieldByName('PRE_NUMDOC').AsString;
    recDados.strNumLot := qryPrepTe.FieldByName('PRE_NUMLOT').AsString;
    recDados.fltQtdIte := qryPrepTe.FieldByName('PRE_QTDITE').AsFloat;
    Self.pInserirPreparacaoTransferencia(recDados);
    qryPrepTe.Next;
  End;
end;

procedure TPreparaGeracaoTE.pSet_INCFDO_REQVEN(strAutIncFdo, strAutIncPREPTE: String);
Var
  qryReqVen: TUniQuery;
begin

  If fEmptyStr(strAutIncFdo) Then
    Exit;

  If fEmptyStr(strAutIncPREPTE) Then
    Exit;

  qryReqVen := fCriaQuery;

  Try

    qryReqVen.Close;
    qryReqVen.SQL.Clear;
    qryReqVen.SQL.Add('UPDATE REQVEN SET SEQ_FATDOR = :FATDOR WHERE SEQ_PREPTE = :PREPTE');

    qryReqVen.ParamByName('FATDOR').AsString := strAutIncFdo;
    qryReqVen.ParamByName('PREPTE').AsString := strAutIncPREPTE;
    qryReqVen.ExecSQL;

  Finally
    FreeAndNil(qryReqVen);
  End;

end;

procedure TPreparaGeracaoTE.pSet_NumeroEspecieDocumento;
begin
  If fCfgSis('TIPPRE', varString) = '2' Then
  Begin
    FNumDoc := fRetSequencialPedido;
    FEspDoc := 'PD';
  End Else
  Begin
    FNumDoc := fRetSequencial('PRO_OR', '', fTamDocCadRec);
    FEspDoc := 'OR';
  End;
end;

Function TPreparaGeracaoTE.fTemRegistrosMarcados: Boolean;
Begin
  Result := FIteLib.Locate('LIBERA', 'S', []);
End;

procedure TPreparaGeracaoTE.pValidaRegistroComQtdZerada;
const
  strMotivoErro = 'PEDIDO DE VENDA NÃO FOI GERADO POR QUE A QUANTIDADE ESTÁ ZERADA';
  strSQLDelete = 'SELECT * FROM PREPTE WHERE AUTOINCREM = :AUTINC';

Var
  qryDelete: TUniQuery;
begin

  qryDelete := fCriaQuery();

  If FPrepTe.IsEmpty Then
    Exit;

  FPrepTe.First;
  Try
    fStartTransaction;
    Try
      While Not FPrepTe.Eof Do
      Begin
        If FPrepTe.FieldByName('PRE_QTDITE').AsFloat <= 0 Then
        Begin

          qryDelete.Close;
          qryDelete.SQL.Clear;
          qryDelete.SQL.Add(strSQLDelete);
          qryDelete.ParamByName('AUTINC').AsString := FPrepTe.FieldByName('AUTOINCREM').AsString;
          qryDelete.Open;
          If Not qryDelete.IsEmpTy Then
          Begin
            qryDelete.Edit;
            qryDelete.FieldByName('PRE_LOGICP').AsString := strMotivoErro;
            qryDelete.Post;

            fVerificaIntegridade('TPreparaGeracaoTE.fSalvaPreparacao', 'PREPTE', qryDelete, True, False);
            FPrepTe.delete;
          End;
        End
        Else
          FPrepTe.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
       Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(qryDelete);
    FPrepTe.First;
  End;
end;

class procedure TPreparaGeracaoTE.pInserirPreparacaoTransferencia(
  recDados: TDadosPrepTe);
  var
    qryPrepTe : TUniQuery;
begin
  qryPrepTe := fCriaQuery(Nil);
  Try
    qryPrepTe.Close;
    qryPrepTe.SQL.Clear;
    qryPrepTe.SQL.Add(' INSERT IGNORE INTO PREPTE (AUTOINCREM, PRE_CODOPE, PRE_DOCABS, PRE_DTACAD, ');
    qryPrepTe.SQL.Add('                     PRE_EMPABS, PRE_EMPDES, PRE_EMPDOC, PRE_EMPORI, ');
    qryPrepTe.SQL.Add('                     PRE_ESPABS, PRE_ESPDOC, PRE_HORCAD, PRE_LIBERA, ');
    qryPrepTe.SQL.Add('                     PRE_NUMDOC, PRE_NUMLOT, PRE_QTDITE, PRE_CODITE) ');
    qryPrepTe.SQL.Add('             VALUES (:AUTINC, :CODOPE, :DOCABS, :DTACAD, ');
    qryPrepTe.SQL.Add('                     :EMPABS, :EMPDES, :EMPDOC, :EMPORI, ');
    qryPrepTe.SQL.Add('                     :ESPABS, :ESPDOC, :HORCAD, :LIBERA, ');
    qryPrepTe.SQL.Add('                     :NUMDOC, :NUMLOT, :QTDITE, :CODITE) ');

    If fEmptyStr(recDados.strAutInc) Then
      qryPrepTe.ParamByName('AUTINC').AsString := fRetAutoIncrem('PREPTE', VS_strCodEmp)
    Else
      qryPrepTe.ParamByName('AUTINC').AsString := recDados.strAutInc;

    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('CODOPE'), recDados.strCodOpe);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('DOCABS'), recDados.strDocAbs);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('EMPABS'), recDados.strEmpAbs);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('EMPDES'), recDados.strEmpDes);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('EMPDOC'), recDados.strEmpDoc);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('EMPORI'), recDados.strEmpOri);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('ESPABS'), recDados.strEspAbs);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('ESPDOC'), recDados.strEspDoc);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('NUMDOC'), recDados.strNumDoc);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('NUMLOT'), recDados.strNumLot);
    pAtribuirSetandoNullEmVazio(qryPrepTe.ParamByName('CODITE'), recDados.strCodIte);

    qryPrepTe.ParamByName('QTDITE').AsFloat := recDados.fltQtdIte;

    If (recDados.dtaDtaCad <> 0) Then
      qryPrepTe.ParamByName('DTACAD').AsDate := recDados.dtaDtaCad
    Else
      qryPrepTe.ParamByName('DTACAD').AsDate := VS_Date;

    If (recDados.dtaHorCad <> 0) Then
      qryPrepTe.ParamByName('HORCAD').AsDateTime := recDados.dtaHorCad
    Else
      qryPrepTe.ParamByName('HORCAD').AsDateTime := fTime();

    If (Not fEmptyStr(recDados.strLibera)) Then
      qryPrepTe.ParamByName('LIBERA').AsString := recDados.strLibera
    Else
      qryPrepTe.ParamByName('LIBERA').AsString := 'S';

    qryPrepTe.ExecSQL;
  Finally
    FreeAndNil(qryPrepTe);
  End;
end;

function TPreparaGeracaoTE.fItemJaProcessadoComOutroLote(strCodIte,
  strNumLot: String): Boolean;
begin
  Result := False;

  If fEmptyStr(strNumLot) Then
    Exit;

  If fEmptyStr(strCodIte) Then
    Exit;

  If FDicItemLote.ContainsKey(strCodIte) Then
    Exit(FDicItemLote[strCodIte] <> strNumLot);

  FDicItemLote.AddOrSetValue(strCodIte, strNumLot);
end;

function TPreparaGeracaoTE.fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt, strForPag: string; strCodCli: string): boolean;
  var
    qryConsulta: TUniQuery;
    strCliCnd: String;

    function fCarregaCliente: Boolean;
    Begin
      qryConsulta.SQL.Add('SELECT ');
      qryConsulta.SQL.Add('       CLICND.CND_CODCND, CADCND.CND_CODFPG, ');
      qryConsulta.SQL.Add('       CLICND.CND_CNDPAG');
      qryConsulta.SQL.Add('  FROM CADCLI');
      qryConsulta.SQL.Add('  LEFT JOIN CLICND ON CLI_CODCLI = CND_CODCLI');
      qryConsulta.SQL.Add('  LEFT JOIN CADCND ON CND_CODIGO = CND_CODCND');
      qryConsulta.SQL.Add(' WHERE CLI_CODCLI = :CODCLI');
      qryConsulta.ParamByName('CODCLI').AsString := strCodCli;
      qryConsulta.Open;
      Result := qryConsulta.RecordCount > 0;
    End;

begin
  Result := False;
  qryConsulta := fCriaQuery;
  Try
    If (fCfgSis('USACND', varBoolean)) Then
    Begin
      strCliCnd := '';

      if fCarregaCliente Then
      Begin
         strForPag     := qryConsulta.FieldByName('CND_CODFPG').AsString;

        If fEmptyStr(strCliCnd) Then
          strCliCnd := qryConsulta.FieldByName('CND_CODCND').AsString;
      End;

      If not fEmptyStr(strCliCnd) Then
      Begin
        strCodConPgt       := strCliCnd;
        strConPgtMas       := fRetConPagCodCnd(strCliCnd);
        Result := True;
      End;

    End;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TPreparaGeracaoTE.fAutIncEnderecoDeEntrega: String;
begin
  Result := fCampoTabela('AUTOINCREM', 'ENTCLI', ['ETC_CODCLI'], [FCliFil]);
end;

class function TPreparaGeracaoTE.fCarregarDadosPreparacaoTransferencia(
  const strNumDoc, strEspDoc, strCodEmp: String): TUniQuery;
begin
  Result := fCriaQuery(Nil);
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add(' SELECT * ');
  Result.SQL.Add('   FROM PREPTE ');
  Result.SQL.Add('  WHERE PRE_NUMDOC = :NUMDOC ');
  Result.SQL.Add('    AND PRE_ESPDOC = :ESPDOC ');
  Result.SQL.Add('    AND PRE_EMPDOC = :EMPDOC ');
  Result.ParamByName('NUMDOC').AsString := strNumDoc;
  Result.ParamByName('ESPDOC').AsString := strEspDoc;
  Result.ParamByName('EMPDOC').AsString := strCodEmp;
  Result.Open;
end;

{ TReplInfPDTransf }

function TReplInfPDTransf.CodEmp(const AValue: String): IReplInfPDTransf;
begin
  FCodEmp := AValue;
  Result := Self;
end;

constructor TReplInfPDTransf.Create;
begin
  FCodEmp := '';
  FEspDoc := '';
  FNumDoc := '';
  FFieldsFgo := [];
  FFieldsEgo := [];
end;

function TReplInfPDTransf.EspDoc(const AValue: String): IReplInfPDTransf;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TReplInfPDTransf.Fields(const ATable: TEFieldReplInf; const AValue: TArrString): IReplInfPDTransf;
begin
  Case ATable Of
    friFatgor:
      FFieldsFgo := AValue;
    friExtgor:
      FFieldsEgo := AValue;
  End;

  Result := Self;
end;

class function TReplInfPDTransf.New: IReplInfPDTransf;
begin
  Result := TReplInfPDTransf.Create();
end;

function TReplInfPDTransf.NumDoc(const AValue: String): IReplInfPDTransf;
begin
  FNumDoc := AValue;
  Result := Self;
end;

procedure TReplInfPDTransf.pExecute;
var
  LQry: TUniQuery;
  LIdx: Integer;
  LFields: String;
begin
  If (Not (Pred(Length(FFieldsFgo)) > 0) And
    (Not (Pred(Length(FFieldsEgo)) > 0))) Then
    Exit;

  LQry := fCriaQuery();
  LFields := '';

  Try
    LQry.SQL.Add('UPDATE FATGOR D                                            ');
    LQry.SQL.Add('JOIN EXTGOR DE ON DE.FGO_SEQFGO = D.AUTOINCREM             ');
    LQry.SQL.Add('JOIN FATGOR O ON DE.FGO_NMPDAB = O.FGO_NUMDOC              ');
    LQry.SQL.Add('             AND DE.FGO_ESPDAB = O.FGO_ESPDOC              ');
    LQry.SQL.Add('             AND DE.FGO_EMPDAB = O.FGO_CODEMP              ');
    LQry.SQL.Add('JOIN EXTGOR DO ON DO.FGO_SEQFGO = O.AUTOINCREM             ');
    LQry.SQL.Add('SET                                                        ');

    For LIdx := 0 To Pred(Length(FFieldsFgo)) Do
      LFields := LFields + Concat('D.', FFieldsFgo[LIdx], ' = ', 'O.', FFieldsFgo[LIdx], ',');

    For LIdx := 0 To Pred(Length(FFieldsEgo)) Do
      LFields := LFields + Concat('DE.', FFieldsEgo[LIdx], ' = ', 'DO.', FFieldsEgo[LIdx], ',');

    Delete(LFields, Length(LFields), 1);

    LQry.SQL.Add(LFields);
    LQry.SQL.Add('WHERE O.FGO_NUMDOC = :NUMDOC                               ');
    LQry.SQL.Add('  AND O.FGO_ESPDOC = :ESPDOC                               ');
    LQry.SQL.Add('  AND O.FGO_CODEMP = :CODEMP                               ');
    LQry.SQL.Add('  AND D.FGO_JAFATU = 0                                     ');

    LQry.ParamByName('NUMDOC').AsString := FNumDoc;
    LQry.ParamByName('ESPDOC').AsString := FEspDoc;
    LQry.ParamByName('CODEMP').AsString := FCodEmp;

    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
end;


{ TTipoDefinicaoDoVendedorNosPedidosGeradosDeTEHelper }

function TTipoDefinicaoDoVendedorNosPedidosGeradosDeTEHelper.AgruparPorVendedorSolicitante: Boolean;
begin
  Result := (Self = tdvOperadorSolicitanteAgrupandoTodasAsSolicitacoesPorVendedorSolicitante);
end;

function TTipoDefinicaoDoVendedorNosPedidosGeradosDeTEHelper.GetValue: String;
begin
  case Self of
    tdvOperadorLogadoAgrupandoTodasAsSolicitacoes     : Result := strLoginUsuarioLogado;
    tdvOperadorCadastradoAgrupandoTodasAsSolicitacoes : Result := fCfgSis('OPE_TE');
    tdvOperadorSolicitanteAgrupandoTodasAsSolicitacoesPorVendedorSolicitante : Result := '';
    else Result := '';
  end;
end;

function TPreparaGeracaoTE.fEmpOri: String;
Begin
  If fEmptyStr(FstrEmpOri) Then
    Result := VS_strCodEmp
  Else
    Result := FstrEmpOri;
End;

Function TPreparaGeracaoTE.fGeraPedidosVenda(const AstrEmpOri: String): Boolean;
Begin
  FstrEmpOri := AstrEmpOri;
  Try
    Result := fGeraPedidosVenda;
  Finally
    FstrEmpOri := '';
  End;
End;

end.



