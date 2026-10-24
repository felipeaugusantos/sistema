unit untNegociacaoOS;

interface

uses
  Classes, StrUtils, SysUtils, DB, Uni, UniClientDataSet, UniDataSetProvider,
  Variants, untConsertoEquipamento, Faturamento.Classes.TEmitirPedido, untTypesSistema;

type
  TNegociacaoOS = class(TComponent)
  private
    FNovNeg: Boolean;
    FAtuCnd: Boolean;
    FAutInc: String;
    FNumNeg: String;
    FStatus: String;
    FCodEmp: String;
    FCodCli: String;
    FNomCli: String;
    FCgcCli: String;
    FCodOpe: String;
    FNomOpe: String;
    FDtaCad: TDateTime;
    FDtaNeg: TDateTime;
    FNegSta: String;
    FTotNeg: Double;
    FPerDes: Double;
    FPerSer: Double;
    FCodCnd: String;
    FConPag: String;
    FCodFpg: String;
    FTipDes: String;
    FVlrDes: Double;
    {* Variáveis totalizador *}
    FTotOse: Double;
    FTotRet: Double;
    FTotIPI: Double;
    FTotFre: Double;
    FTotGer: Double;
    FDesVlr: Double;
    FTotDes: Double;
    FTotPro: Double;
    FTotSer: Double;
    FFinGra: Boolean;

    FForm: String;

    qryNegOSE: TUniQuery;
    qryOrdSer: TUniQuery;
    qryHisDes: TUniQuery;
    qryGravar: TUniQuery;

    objConEqu: TConEqu;
    objEmitirPedido: TEmitirPedido;
    stlManEquAltLck: TStringList;

    procedure pCriaClientOrdSer;
    procedure pCriaClientHisDes;
    procedure pCriaClientIteOrd;
    procedure pCriaClientDocGer;
    procedure pCarregaOrdensServico;
    procedure pCarregaHistorioDesconto;
    procedure pInsereClientOrdSer(aQuery: TUniQuery; aOperac: String = '');
    procedure pGravaNegOse(aDeletar: Boolean = False);
    procedure pGravaNegEqu(aDeletar: Boolean = False);
    procedure pGravaNegDes(aDeletar: Boolean = False);
    procedure pLimparDadosCarregados;
    procedure pAtualizarTribEquGer;
    procedure pAtualizarTribItensEquDet;
    procedure pDestravaELimpaStlManEquLck;
    procedure pLimparValoresIpiST;
    procedure pAtualizarValoresIssFatVenda;
    procedure pAdicionaIteOrd(aAutInc, aNumOSe, aCodEmp: String; aCdsItens: TDataSet);

    function fCarregaTela: Boolean;
    function fGetSelectOrdSer: String;
    function fVerificaExisteGrid(aSeqGer: String): Boolean;
    function fAtualizaOrdemServico: Boolean;
    function fTravaERegistraStlManEquLck(strNumOse, strCodEmp: String): Boolean;

    function  fInicializarFatVenda: Boolean;
    function fRetornaPorcentagemDesc(aDataSet: TDataSet): Double;
  published
    property blnNovNeg: Boolean   read FNovNeg write FNovNeg;
    property blnAtuCnd: Boolean   read FAtuCnd write FAtuCnd;
    property strAutInc: String    read FAutInc write FAutInc;
    property strNumNeg: String    read FNumNeg write FNumNeg;
    property strStatus: String    read FStatus write FStatus;
    property strCodEmp: String    read FCodEmp write FCodEmp;
    property strCodCli: String    read FCodCli write FCodCli;
    property strNomCli: String    read FNomCli write FNomCli;
    property strCgcCli: String    read FCgcCli write FCgcCli;
    property strCodOpe: String    read FCodOpe write FCodOpe;
    property strNomOpe: String    read FNomOpe write FNomOpe;
    property dtaDtaCad: TDateTime read FDtaCad write FDtaCad;
    property dtaDtaNeg: TDateTime read FDtaNeg write FDtaNeg;
    property strNegSta: String    read FNegSta write FNegSta;
    property fltTotNeg: Double    read FTotNeg write FTotNeg;
    property fltPerDes: Double    read FPerDes write FPerDes;
    property fltPerSer: Double    read FPerSer write FPerSer;
    property strCodCnd: String    read FCodCnd write FCodCnd;
    property strConPag: String    read FConPag write FConPag;
    property strCodFpg: String    read FCodFpg write FCodFpg;
    property strTipDes: String    read FTipDes write FTipDes;
    property fltVlrDes: Double    read FVlrDes write FVlrDes;

    property fltTotOse: Double    read FTotOse write FTotOse;
    property fltTotRet: Double    read FTotRet write FTotRet;
    property fltTotIPI: Double    read FTotIPI write FTotIPI;
    property fltTotFre: Double    read FTotFre write FTotFre;
    property fltTotGer: Double    read FTotGer write FTotGer;
    property fltDesVlr: Double    read FDesVlr write FDesVlr;
    property fltTotDes: Double    read FTotDes write FTotDes;
    property fltTotPro: Double    read FTotPro write FTotPro;
    property fltTotSer: Double    read FTotSer write FTotSer;
    property blnFinGra: Boolean   read FFinGra write FFinGra;
  public
    cdsOrdSer: TUniClientDataSet;
    cdsHisDes: TUniClientDataSet;
    cdsIteOrd: TUniClientDataSet;
    cdsDocGer: TUniClientDataSet;

    constructor Create(Owner: TComponent); Reintroduce;
    destructor Destroy; override;

    procedure pLimpar;
    procedure pVerificaNegociacoes(aQry: TUniQuery; aTipCon, aParam: String; aCodEmp: String = ''; aarrOS: TConsultasArray = nil);
    procedure pInserirOSGrid(aNumero, aCodEmp: String);
    procedure pCalculaTotais;
    procedure pCalculaDescontos;
    procedure pInsereHistoricoDesconto(aDesApl, aTipDes: String; aPerPrd, aPerSer, aTotDes: Double);
    procedure pRemoveTrava;
    procedure pCdsDocGerBeforePost(dtsDocGer: TDataSet);

    function fCarregaNegociacao(aNumNeg, aCodEmp: String): Boolean;
    function fVerificaExisteOrdSer(aNumero, aCodEmp: String): Boolean;
    function fGravarNegociacao: Boolean;
    function fExcluirNegociacao(aForm: String): Boolean;
    function fFinalizarNegociacao: Boolean;
end;

implementation

uses
  untFuncoesSimples, untFuncFat;

{ TNegociacaoOS }

constructor TNegociacaoOS.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FNovNeg   := True;
  FFinGra   := False;
  qryNegOSE := fCriaQuery(Self);
  qryOrdSer := fCriaQuery(Self);
  qryHisDes := fCriaQuery(Self);

  pCriaClientOrdSer;
  pCriaClientHisDes;
  pCriaClientIteOrd;
  pCriaClientDocGer;

  stlManEquAltLck := TStringList.Create;
end;

destructor TNegociacaoOS.Destroy;
begin
  If stlManEquAltLck.Count > 0  Then
    pDestravaELimpaStlManEquLck;

  FreeAndNil(stlManEquAltLck);
  FreeAndNil(qryNegOSE);
  FreeAndNil(qryOrdSer);
  FreeAndNil(qryHisDes);
  FreeAndNil(cdsOrdSer);
  FreeAndNil(cdsHisDes);
  FreeAndNil(cdsIteOrd);
  FreeAndNil(cdsDocGer);

  inherited Destroy;
end;

function TNegociacaoOS.fAtualizaOrdemServico: Boolean;
var
  cdsDados : TUniClientDataSet;
begin
  Result := True;
  try
    cdsDados := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsDados, cdsOrdSer);

    cdsDados.Filtered := False;
    cdsDados.Filter   := cdsOrdSer.Filter;
    cdsDados.Filtered := True;

    cdsDados.First;
    cdsIteOrd.EmptyDataSet;

    while not cdsDados.Eof do
    begin
      try
        try
          objConEqu := TConEqu.Create(Nil);
          objConEqu.fVerificaOrdServExiste(cdsDados.FieldByName('NUMOSE').AsString, cdsDados.FieldByName('CODEMP').AsString);

          objConEqu.fltVlrCon := cdsDados.FieldByName('TOTGER').AsFloat - cdsDados.FieldByName('VLRDES').AsFloat;
          objConEqu.fltVlrPro := cdsDados.FieldByName('TOTPRO').AsFloat - cdsDados.FieldByName('VLDPRO').AsFloat;
          objConEqu.fltVlrSer := cdsDados.FieldByName('TOTSER').AsFloat - cdsDados.FieldByName('VLDSER').AsFloat;
          objConEqu.fltDesEsp := cdsDados.FieldByName('VLDPRO').AsFloat;
          objConEqu.fltPorDes := fRetornaPorcentagemDesc(cdsDados);
          objConEqu.fltValDes := 0;

          if (FAtuCnd) then
          begin
            objConEqu.strConPag := FConPag;
            objConEqu.strCodCnd := FCodCnd;
            objConEqu.strCodFpg := FCodFpg;
          end;

          fInicializarFatVenda;

          objConEqu.cdsIteEqu.First;

          while not objConEqu.cdsIteEqu.Eof do
          begin
            objConEqu.cdsIteEqu.Edit;
            objConEqu.cdsIteEqu.FieldByName('PERDES').AsFloat := 0;
            objConEqu.cdsIteEqu.FieldByName('DESESP').AsFloat := 0;

            if (cdsDados.FieldByName('VLDPRO').AsFloat > 0) then
            begin
              objConEqu.cdsIteEqu.FieldByName('PERDES').AsFloat := (cdsDados.FieldByName('VLDPRO').AsFloat / cdsDados.FieldByName('TOTPRO').AsFloat) * 100;
              objConEqu.cdsIteEqu.FieldByName('DESESP').AsFloat := objConEqu.cdsIteEqu.FieldByName('TOTITE').AsFloat * (cdsDados.FieldByName('VLDPRO').AsFloat / cdsDados.FieldByName('TOTPRO').AsFloat);
            end;
            objConEqu.cdsIteEqu.Post;

            objConEqu.cdsIteEqu.Next;
          end;

          objConEqu.cdsSerEqu.First;

          while not objConEqu.cdsSerEqu.Eof do
          begin
            objConEqu.cdsSerEqu.Edit;
            if (cdsDados.FieldByName('VLDSER').AsFloat > 0) then
            begin
              objConEqu.cdsSerEqu.FieldByName('VALSER').AsFloat := objConEqu.cdsSerEqu.FieldByName('VALUNI').AsFloat * (1 - (cdsDados.FieldByName('VLDSER').AsFloat / cdsDados.FieldByName('TOTSER').AsFloat));
              objConEqu.cdsSerEqu.FieldByName('DESESP').AsFloat := objConEqu.cdsSerEqu.FieldByName('VALUNI').AsFloat * (cdsDados.FieldByName('VLDSER').AsFloat / cdsDados.FieldByName('TOTSER').AsFloat);
              objConEqu.cdsSerEqu.FieldByName('PORDES').AsFloat := (cdsDados.FieldByName('VLDSER').AsFloat / cdsDados.FieldByName('TOTSER').AsFloat) * 100;
            end
            else
            begin
              objConEqu.cdsSerEqu.FieldByName('VALSER').AsFloat := objConEqu.cdsSerEqu.FieldByName('VALUNI').AsFloat;
              objConEqu.cdsSerEqu.FieldByName('DESESP').AsFloat := 0;
              objConEqu.cdsSerEqu.FieldByName('PORDES').AsFloat := 0;
            end;

            objConEqu.cdsSerEqu.Post;
            objConEqu.cdsSerEqu.Next;
          end;

          objConEqu.fGravaEquGer(True);

          pAdicionaIteOrd(objConEqu.strAutInc, objConEqu.strNumero, objConEqu.strCodEmp, objConEqu.cdsIteEqu);
        except
          on E: Exception do
            begin
              Result := False;
              pMensagensErro(E.Message, '[TNegociacaoOS.fAtualizaOrdemServico]');
              Exit;
            end;
        end;
      finally
        FreeAndNil(objConEqu);

        if Assigned(objEmitirPedido) then
          FreeAndNil(objEmitirPedido);
      end;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TNegociacaoOS.fCarregaNegociacao(aNumNeg, aCodEmp: String): Boolean;
var
  strSQL: String;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + ' SELECT  ';
  strSQL := strSQL + '     NEGOSE.NEG_NRONEG NRONEG, ';
  strSQL := strSQL + '     NEGOSE.NEG_CODEMP CODEMP, ';
  strSQL := strSQL + '     CADCLI.CLI_CODCLI CODCLI, ';
  strSQL := strSQL + '     CADCLI.CLI_NOMCLI NOMCLI, ';
  strSQL := strSQL + '     CADCLI.CLI_C_G_C_ CGCCLI, ';
  strSQL := strSQL + '     CASE NEGOSE.NEG_STATUS WHEN "A" THEN "EM ABERTO" ELSE "FINALIZADA" END NEGSTA, ';
  strSQL := strSQL + '     NEGOSE.NEG_STATUS STATUS, ';
  strSQL := strSQL + '     NEGOSE.NEG_DTACAD DTACAD, ';
  strSQL := strSQL + '     CADOPE.OPE_CODOPE CODOPE, ';
  strSQL := strSQL + '     CADOPE.OPE_NOMOPE NOMOPE, ';
  strSQL := strSQL + '     NEGOSE.NEG_TOTNEG TOTNEG, ';
  strSQL := strSQL + '     NEGOSE.NEG_DTANEG DTANEG, ';
  strSQL := strSQL + '     NEGOSE.NEG_PERDES PERDES, ';
  strSQL := strSQL + '     NEGOSE.NEG_PERSER PERSER, ';
  strSQL := strSQL + '     NEGOSE.NEG_CODCND CODCND, ';
  strSQL := strSQL + '     NEGOSE.NEG_CODFPG CODFPG, ';
  strSQL := strSQL + '     NEGOSE.NEG_TIPDES TIPDES, ';
  strSQL := strSQL + '     NEGOSE.NEG_VLRDES VLRDES, ';
  strSQL := strSQL + '     NEGOSE.NEG_CONPAG CONPAG, ';
  strSQL := strSQL + '     NEGOSE.AUTOINCREM AUTINC ';
  strSQL := strSQL + ' FROM NEGOSE ';
  strSQL := strSQL + ' INNER JOIN CADOPE ON NEGOSE.NEG_CODOPE = CADOPE.OPE_CODOPE ';
  strSQL := strSQL + ' INNER JOIN CADCLI ON NEGOSE.NEG_CODCLI = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + ' WHERE NEGOSE.NEG_NRONEG = :NUMNEG ';
  strSQL := strSQL + '     AND NEGOSE.NEG_CODEMP = :CODEMP ';

  qryNegOSE.Close;
  qryNegOSE.SQL.Clear;
  qryNegOSE.SQL.Add(strSQL);
  qryNegOSE.ParamByName('NUMNEG').AsString := aNumNeg;
  qryNegOSE.ParamByName('CODEMP').AsString := aCodEmp;
  qryNegOSE.Open;

  if not qryNegOSE.IsEmpty then
  begin
    FAutInc := qryNegOSE.FieldByName('AUTINC').AsString;
    FNumNeg := aNumNeg;
    pCarregaOrdensServico;
    pCarregaHistorioDesconto;
    Result := fCarregaTela;
  end
  else
    fMensagem('AVISO', 'Negociação não encontrada!', ['&Ok']);
end;

function TNegociacaoOS.fExcluirNegociacao(aForm: String): Boolean;
begin
  Result := True;

  FForm := aForm;

  fStartTransaction;
  qryGravar := fCriaQuery;

  try
    try
      pGravaNegEqu(True);
      pGravaNegDes(True);
      pGravaNegOse(True);

      fCommit;
    except
      on E: Exception do
      begin
        Result := False;
        fRollback;
        pMensagensErro(E.Message, '[TNegociacaoOS.fExcluirNegociacao]');
      end;
    end;
  finally
    FreeAndNil(qryGravar);

    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'OPERAC<>''D''';
    cdsOrdSer.Filtered := True;

    cdsHisDes.Filtered := False;
    cdsHisDes.Filter   := '';
    cdsHisDes.Filtered := True;
  end;
end;

function TNegociacaoOS.fFinalizarNegociacao: Boolean;
var
  strSQL : String;
  qryAux   : TUniQuery;
begin
  Result := FFinGra;

  if (not Result) then
    Result := fGravarNegociacao;

  if Result then
  begin
    fStartTransaction;
    qryAux := fCriaQuery;

    try
      try
        if not fAtualizaOrdemServico then
        begin
          Result := False;
          fRollback;
          Exit;
        end;

        strSQL := '';
        strSQL := strSQL + ' UPDATE NEGOSE ';
        strSQL := strSQL + ' SET NEG_DTANEG = :DTANEG,  ';
        strSQL := strSQL + '     NEG_STATUS = :STATUS   ';
        strSQL := strSQL + ' WHERE AUTOINCREM = :SEQNEG ';

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Text := strSQL;
        qryAux.ParamByName('SEQNEG').AsString   := FAutInc;
        qryAux.ParamByName('DTANEG').AsDateTime := nOw;
        qryAux.ParamByName('STATUS').AsString   := 'F';
        qryAux.ExecSQL;

        fCommit;
      except
        on E: Exception do
        begin
          Result := False;
          fRollback;
          pMensagensErro(E.Message, '[TNegociacaoOS.fFinalizarNegociacao]');
        end;
      end;
    finally
      FreeAndNil(qryAux);
    end;
  end;
end;

function TNegociacaoOS.fGetSelectOrdSer: String;
begin
  Result := '';
  Result := Result + ' SELECT EQUGER.AUTOINCREM SEQGER, EQU_CODEMP CODEMP, EQU_CODCLI CODCLI, ';
  Result := Result + '     CLI_NOMCLI NOMCLI, CLI_C_G_C_ CGCCLI, EQU_NUMOSE NUMOSE, EQU_TABPRE TABPRE, ';
  Result := Result + '     EQU_DTINOR DTINOR, EQU_DTFIOR DTFIOR, COALESCE(EQU_TOTIPI, 0) TOTIPI, ';
  Result := Result + '     COALESCE(EQU_TOTFRE, 0) TOTFRE, ';
  Result := Result + '     (SELECT SUM(EQUDET.EQU_TOTITE) ';
  Result := Result + '      FROM EQUDET ';
  Result := Result + '      WHERE EQUGER.AUTOINCREM = EQUDET.EQU_SEQGER) TOTPRO, ';
  Result := Result + '     (SELECT SUM(EQUSER.EQU_VALUNI) ';
  Result := Result + '      FROM EQUSER ';
  Result := Result + '      WHERE EQUGER.AUTOINCREM = EQUSER.EQU_SEQGER) TOTSER, COALESCE(EQU_TOTRET, 0) TOTRET, ';
  Result := Result + '     COALESCE(EQU_TOTCBS, 0) + COALESCE(EQU_TOTIBS, 0) + COALESCE(EQU_TOT_IS, 0) TOTREF ';
  Result := Result + ' FROM EQUGER ';
  Result := Result + ' INNER JOIN CADCLI ON EQUGER.EQU_CODCLI = CADCLI.CLI_CODCLI ';
end;

procedure TNegociacaoOS.pGravaNegEqu(aDeletar: Boolean = False);
var
  strSQL: String;
begin
  if (aDeletar) then
  begin
    strSQL := 'SELECT * FROM NEGEQU WHERE NEG_SEQNEG = :SEQNEG';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add(strSQL);
    qryGravar.ParamByName('SEQNEG').AsString := FAutInc;
    qryGravar.Open;

    while not qryGravar.Eof do
    begin
      fVerificaIntegridade(FForm, 'NEGEQU', qryGravar, True);
      qryGravar.Next;
    end;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM NEGEQU ';
    strSQL := strSQL + ' WHERE NEG_SEQNEG = :SEQNEG ';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Text := strSQL;
    qryGravar.ParamByName('SEQNEG').AsString := FAutInc;
    qryGravar.ExecSQL;
  end
  else
  begin
    cdsOrdSer.DisableControls;

    {*** Deleta do banco registros deletados do grid ***}
    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'OPERAC=''D''';
    cdsOrdSer.Filtered := True;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM NEGEQU ';
    strSQL := strSQL + ' WHERE NEG_SEQNEG = :SEQNEG ';
    strSQL := strSQL + '     AND NEG_SEQGER = :SEQGER ';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Text := strSQL;

    cdsOrdSer.First;

    while not cdsOrdSer.Eof do
    begin
      qryGravar.Close;
      qryGravar.ParamByName('SEQNEG').AsString := FAutInc;
      qryGravar.ParamByName('SEQGER').AsString := cdsOrdSer.FieldByName('SEQGER').AsString;
      qryGravar.ExecSQL;

      cdsOrdSer.Next;
    end;

    {*** Insere registros no banco ***}
    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'OPERAC=''I''';
    cdsOrdSer.Filtered := True;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO NEGEQU ( ';
    strSQL := strSQL + '     AUTOINCREM, ';
    strSQL := strSQL + '     NEG_SEQNEG, ';
    strSQL := strSQL + '     NEG_SEQGER) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '     :AUTINC, ';
    strSQL := strSQL + '     :SEQNEG, ';
    strSQL := strSQL + '     :SEQGER) ';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Text := strSQL;

    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'OPERAC=''I''';
    cdsOrdSer.Filtered := True;

    cdsOrdSer.First;

    while not cdsOrdSer.Eof do
    begin
      qryGravar.Close;
      qryGravar.ParamByName('AUTINC').AsString := fRetAutoIncrem('NEGEQU', FCodEmp);
      qryGravar.ParamByName('SEQNEG').AsString := FAutInc;
      qryGravar.ParamByName('SEQGER').AsString := cdsOrdSer.FieldByName('SEQGER').AsString;
      qryGravar.ExecSQL;

      cdsOrdSer.Next;
    end;

    cdsOrdSer.EnableControls;
  end;
end;

procedure TNegociacaoOS.pGravaNegDes(aDeletar: Boolean = False);
var
  strSQL: String;
begin
  if (aDeletar) then
  begin
    strSQL := 'SELECT * FROM NEGDES WHERE DES_SEQNEG = :SEQNEG';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add(strSQL);
    qryGravar.ParamByName('SEQNEG').AsString := FAutInc;
    qryGravar.Open;

    while not qryGravar.Eof do
    begin
      fVerificaIntegridade(FForm, 'NEGDES', qryGravar, True);
      qryGravar.Next;
    end;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM NEGDES ';
    strSQL := strSQL + ' WHERE DES_SEQNEG = :SEQNEG ';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Text := strSQL;
    qryGravar.ParamByName('SEQNEG').AsString := FAutInc;
    qryGravar.ExecSQL;
  end
  else
  begin
    cdsHisDes.DisableControls;

    cdsHisDes.Filtered := False;
    cdsHisDes.Filter   := 'OPERAC=''I''';
    cdsHisDes.Filtered := True;

    strSQL := strSQL + ' INSERT INTO NEGDES ( ';
    strSQL := strSQL + '     AUTOINCREM, ';
    strSQL := strSQL + '     DES_DESAPL, ';
    strSQL := strSQL + '     DES_TIPDES, ';
    strSQL := strSQL + '     DES_PERDES, ';
    strSQL := strSQL + '     DES_PERSER, ';
    strSQL := strSQL + '     DES_VALDES, ';
    strSQL := strSQL + '     DES_DTADES, ';
    strSQL := strSQL + '     DES_SEQNEG) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '     :AUTINC, ';
    strSQL := strSQL + '     :DESAPL, ';
    strSQL := strSQL + '     :TIPDES, ';
    strSQL := strSQL + '     :PERDES, ';
    strSQL := strSQL + '     :PERSER, ';
    strSQL := strSQL + '     :VALDES, ';
    strSQL := strSQL + '     :DTADES, ';
    strSQL := strSQL + '     :SEQNEG) ';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Text := strSQL;

    while not cdsHisDes.Eof do
    begin
      qryGravar.Close;
      qryGravar.ParamByName('AUTINC').AsString   := fRetAutoIncrem('NEGDES', FCodEmp);
      qryGravar.ParamByName('DESAPL').AsString   := cdsHisDes.FieldByName('DESAPL').AsString;
      qryGravar.ParamByName('TIPDES').AsString   := cdsHisDes.FieldByName('TIPDES').AsString;
      qryGravar.ParamByName('PERDES').AsFloat    := cdsHisDes.FieldByName('PERPRD').AsFloat;
      qryGravar.ParamByName('PERSER').AsFloat    := cdsHisDes.FieldByName('PERSER').AsFloat;
      qryGravar.ParamByName('VALDES').AsFloat    := cdsHisDes.FieldByName('TOTDES').AsFloat;
      qryGravar.ParamByName('DTADES').AsDateTime := cdsHisDes.FieldByName('DTADES').AsDateTime;
      qryGravar.ParamByName('SEQNEG').AsString   := FAutInc;
      qryGravar.ExecSQL;

      cdsHisDes.Next;
    end;

    cdsHisDes.EnableControls;
  end;
end;

procedure TNegociacaoOS.pGravaNegOse(aDeletar: Boolean = False);
var
  strSQL: String;
begin
  if (aDeletar) then
  begin
    strSQL := 'SELECT * FROM NEGOSE WHERE AUTOINCREM = :AUTINC';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add(strSQL);
    qryGravar.ParamByName('AUTINC').AsString := FAutInc;
    qryGravar.Open;

    fVerificaIntegridade(FForm, 'NEGOSE', qryGravar, True);

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM NEGOSE ';
    strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Text := strSQL;
    qryGravar.ParamByName('AUTINC').AsString := FAutInc;
    qryGravar.ExecSQL;
  end
  else
  begin
    if FNovNeg then
    begin
      if fEmptyStr(FNumNeg) then
        FNumNeg := fRetSequencial('PRONEG', '', 12);

      FAutInc := fRetAutoIncrem('NEGOSE', FCodEmp);

      if fEmptyStr(Trim(FNumNeg)) or fEmptyStr(Trim(FAutInc)) then
        raise Exception.Create('Ocorreu um erro ao pegar o próximo número da Negociação' + #13 + 'Tente novamente!')
      else
      begin
        strSQL := strSQL + ' INSERT INTO NEGOSE ( ';
        strSQL := strSQL + '     AUTOINCREM, ';
        strSQL := strSQL + '     NEG_NRONEG, ';
        strSQL := strSQL + '     NEG_DTACAD, ';
        strSQL := strSQL + '     NEG_CODOPE, ';
        strSQL := strSQL + '     NEG_CODCLI, ';
        strSQL := strSQL + '     NEG_DTANEG, ';
        strSQL := strSQL + '     NEG_STATUS, ';
        strSQL := strSQL + '     NEG_TOTNEG, ';
        strSQL := strSQL + '     NEG_CODEMP, ';
        strSQL := strSQL + '     NEG_PERDES, ';
        strSQL := strSQL + '     NEG_PERSER, ';
        strSQL := strSQL + '     NEG_CODCND, ';
        strSQL := strSQL + '     NEG_CODFPG, ';
        strSQL := strSQL + '     NEG_CONPAG, ';
        strSQL := strSQL + '     NEG_TIPDES, ';
        strSQL := strSQL + '     NEG_VLRDES) ';
        strSQL := strSQL + ' VALUES ( ';
        strSQL := strSQL + '     :AUTINC, ';
        strSQL := strSQL + '     :NRONEG, ';
        strSQL := strSQL + '     :DTACAD, ';
        strSQL := strSQL + '     :CODOPE, ';
        strSQL := strSQL + '     :CODCLI, ';
        strSQL := strSQL + '     :DTANEG, ';
        strSQL := strSQL + '     :STATUS, ';
        strSQL := strSQL + '     :TOTNEG, ';
        strSQL := strSQL + '     :CODEMP, ';
        strSQL := strSQL + '     :PERDES, ';
        strSQL := strSQL + '     :PERSER, ';
        strSQL := strSQL + '     :CODCND, ';
        strSQL := strSQL + '     :CODFPG, ';
        strSQL := strSQL + '     :CONPAG, ';
        strSQL := strSQL + '     :TIPDES, ';
        strSQL := strSQL + '     :VLRDES) ';
      end;
    end
    else
    begin
      strSQL := strSQL + ' UPDATE NEGOSE SET ';
      strSQL := strSQL + '     NEG_NRONEG = :NRONEG, ';
      strSQL := strSQL + '     NEG_DTACAD = :DTACAD, ';
      strSQL := strSQL + '     NEG_CODOPE = :CODOPE, ';
      strSQL := strSQL + '     NEG_CODCLI = :CODCLI, ';
      strSQL := strSQL + '     NEG_DTANEG = :DTANEG, ';
      strSQL := strSQL + '     NEG_STATUS = :STATUS, ';
      strSQL := strSQL + '     NEG_TOTNEG = :TOTNEG, ';
      strSQL := strSQL + '     NEG_CODEMP = :CODEMP, ';
      strSQL := strSQL + '     NEG_PERDES = :PERDES, ';
      strSQL := strSQL + '     NEG_PERSER = :PERSER, ';
      strSQL := strSQL + '     NEG_CODCND = :CODCND, ';
      strSQL := strSQL + '     NEG_CODFPG = :CODFPG, ';
      strSQL := strSQL + '     NEG_CONPAG = :CONPAG, ';
      strSQL := strSQL + '     NEG_TIPDES = :TIPDES, ';
      strSQL := strSQL + '     NEG_VLRDES = :VLRDES  ';
      strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';
    end;

    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Text := strSQL;
    qryGravar.ParamByName('AUTINC').AsString   := FAutInc;
    qryGravar.ParamByName('NRONEG').AsString   := FNumNeg;
    qryGravar.ParamByName('DTACAD').AsDateTime := FDtaCad;
    qryGravar.ParamByName('CODOPE').AsString   := FCodOpe;
    qryGravar.ParamByName('CODCLI').AsString   := FCodCli;
    if (FDtaNeg > 0) then
      qryGravar.ParamByName('DTANEG').AsDateTime := FDtaNeg
    else
      qryGravar.ParamByName('DTANEG').Value := Null;
    qryGravar.ParamByName('STATUS').AsString   := FStatus;
    qryGravar.ParamByName('TOTNEG').AsFloat    := FTotDes;
    qryGravar.ParamByName('CODEMP').AsString   := FCodEmp;
    qryGravar.ParamByName('PERDES').AsFloat    := FPerDes;
    qryGravar.ParamByName('PERSER').AsFloat    := FPerSer;
    qryGravar.ParamByName('CODCND').AsString   := FCodCnd;
    qryGravar.ParamByName('CODFPG').AsString   := FCodFpg;
    qryGravar.ParamByName('CONPAG').AsString   := FConPag;
    qryGravar.ParamByName('TIPDES').AsString   := FTipDes;
    qryGravar.ParamByName('VLRDES').AsFloat    := FVlrDes;
    qryGravar.ExecSQL;
  end;
end;

function TNegociacaoOS.fGravarNegociacao: Boolean;
begin
  Result := True;

  fStartTransaction;
  qryGravar := fCriaQuery;

  try
    try
      pGravaNegOse;
      pGravaNegEqu;
      pGravaNegDes;

      fCommit;
    except
      on E: Exception do
      begin
        Result := False;
        fRollback;
        pMensagensErro(E.Message, '[TNegociacaoOS.fGravarNegociacao]');
      end;
    end;
  finally
    FreeAndNil(qryGravar);

    cdsOrdSer.Filtered := False;
    cdsOrdSer.Filter   := 'OPERAC<>''D''';
    cdsOrdSer.Filtered := True;

    cdsHisDes.Filtered := False;
    cdsHisDes.Filter   := '';
    cdsHisDes.Filtered := True;
  end;
end;

procedure TNegociacaoOS.pAtualizarValoresIssFatVenda;
begin
  //define a alíquota de ISS
  objEmitirPedido.objFatVenda.pDefineAliquotaIss();

  //atualiza os valores de ISS no record de serviços da fatVenda
  objEmitirPedido.objFatVenda.FRecSer.fltBasIss :=
    objConEqu.fltVlrSer * (1 - (objEmitirPedido.objFatVenda.fltRedIss / 100));

  objEmitirPedido.objFatVenda.FRecSer.fltValIss := fCalculaValorIss(objEmitirPedido.objFatVenda.FRecSer.fltBasIss, objEmitirPedido.objFatVenda.fltPerIss);

  objEmitirPedido.objFatVenda.FRecSer.fltPerIss := objEmitirPedido.objFatVenda.fltPerIss;

  objEmitirPedido.objFatVenda.FRecSer.fltRedIss := objEmitirPedido.objFatVenda.fltRedIss;

  //atualiza os valores totais de ISS da fatVenda
  objEmitirPedido.objFatVenda.fltTotSer := objConEqu.fltVlrSer;

  objEmitirPedido.objFatVenda.fltBasIss :=
    objEmitirPedido.objFatVenda.fltTotSer * (1 - (objEmitirPedido.objFatVenda.fltRedIss / 100));

  objEmitirPedido.objFatVenda.fltValIss := fCalculaValorIss(objEmitirPedido.objFatVenda.fltBasIss, objEmitirPedido.objFatVenda.fltPerIss);

  objEmitirPedido.objFatVenda.fltPerIss := objEmitirPedido.objFatVenda.fltPerIss;

  objEmitirPedido.objFatVenda.fltRedIss := objEmitirPedido.objFatVenda.fltRedIss;
end;

procedure TNegociacaoOS.pLimparValoresIpiST;
begin
  objConEqu.fltValIpi := 0;
  objConEqu.fltValRet := 0;
  objConEqu.fltTotIpi := 0;
  objConEqu.fltTotRet := 0;
  objConEqu.fltValCbs := 0;
  objConEqu.fltValIbs := 0;
  objConEqu.fltVal_Is := 0;
  objConEqu.fltTotCbs := 0;
  objConEqu.fltTotIbs := 0;
  objConEqu.fltTotIs  := 0;
  objConEqu.pLimparDadosFiscaisTotais();
end;

function TNegociacaoOS.fInicializarFatVenda: Boolean;
var
  dadosItem      : TDadosProduto;
  dadosPedido    : TDadosPedido;
  strInfAdiTinta : String;
  strEmpAnt      : String;
begin
  Result := False;

  {Manter apenas 1 objeto em memória}
  If Not Assigned(objEmitirPedido) Then
    objEmitirPedido := TEmitirPedido.Create(Self);

  objEmitirPedido.blnCriaTmp := not fInTransaction();

  If (objConEqu.cdsIteEqu.RecordCount = 0) And (objConEqu.cdsSerEqu.RecordCount = 0) Then
  Begin
    Result := True;
    pLimparValoresIpiST();

    If Not fEmptyStr(objConEqu.strCodCli) Then
    Begin
      dadosPedido.strCodCli := objConEqu.strCodCli;
      Result := objEmitirPedido.fIniciarPedido(dadosPedido);
    End;

    Exit;
  End;

  Try
    {Limpa "objEmitirPedido"}
    pLimparDadosCarregados;

    Try
      objConEqu.cdsIteEqu.DisableControls;
      objConEqu.cdsIteEqu.First;

      pLimparValoresIpiST();

      strEmpAnt := VS_strCodEmp;

      dadosPedido.blnSfaPag    := False;
      dadosPedido.strEmpLogSfa := strEmpAnt;

      dadosPedido.strCodCli := objConEqu.strCodCli;
      dadosPedido.strCodVen := objConEqu.strCodVen;

      if fCfgSis('USADIG', varBoolean) then
        dadosPedido.strCodDig := objConEqu.strCodDig
      else
        dadosPedido.strCodDig := strLoginUsuarioLogado;

      dadosPedido.sfaStsPagto := sspBranco;
      dadosPedido.strConPag := objConEqu.strConPag;
      dadosPedido.strCodCnd := objConEqu.strCodCnd;
      dadosPedido.strCodFpg := objConEqu.strCodFpg;
      dadosPedido.fltDesEsp := objConEqu.fltDesEsp;
      dadosPedido.strMen001 := '';
      dadosPedido.strMen002 := '';
      dadosPedido.strMenExp := '';
      dadosPedido.strTipPed := IIF((objConEqu.strSubSta = 'B'), 'B', 'A');
      dadosPedido.strTipOpe := IIF((objConEqu.strSubSta = 'B'), 'B', 'V' );
      dadosPedido.strTipFre := '';
      dadosPedido.strTabPre := objConEqu.strTabPre;
      dadosPedido.strTipFin := 'P';
      dadosPedido.strEntFat := 'S';
      dadosPedido.strNumPok := '';
      dadosPedido.dtaGraPed := VS_Date;
      dadosPedido.dtaPreVis := VS_Date;
      dadosPedido.dtaDtaOri := VS_Date;
      dadosPedido.fltValFre := 0;
      dadosPedido.strCodTra := '';
      dadosPedido.dtaHorImp := 0;
      dadosPedido.dtaDtaTra := 0;
      dadosPedido.dtaHorTra := 0;
      dadosPedido.strAutEnt := objConEqu.strEntGer;
      dadosPedido.strEmp_CD := '';
      dadosPedido.blnEnt_CD := False;
      dadosPedido.strCodTra := objConEqu.strCodTra;
      dadosPedido.intQtdTra := objConEqu.intQtdTra;
      dadosPedido.strEspTra := objConEqu.strEspTra;
      dadosPedido.fltValFre := objConEqu.fltValFre;
      dadosPedido.strTipFre := objConEqu.strTipFre;
      dadosPedido.blnVenPre := objConEqu.blnVenPre;

      Result := objEmitirPedido.fIniciarPedido(dadosPedido);

      If Result Then
      Begin
        objConEqu.cdsIteEqu.First;
        Result := (objConEqu.cdsIteEqu.RecordCount > 0) Or (objConEqu.cdsSerEqu.RecordCount > 0);

        While (Not objConEqu.cdsIteEqu.Eof) And (Result) Do
        Begin
          dadosItem.strNumLot := objConEqu.fRetArmazemPrincipal(objConEqu.strCodEmp, objConEqu.cdsIteEqu.FieldByName('CODITE').AsString);
          dadosItem.strCodIte := objConEqu.cdsIteEqu.FieldByName('CODITE').AsString;
          dadosItem.strIdePro := 'NOR';
          dadosItem.strDesIte := objConEqu.cdsIteEqu.FieldByName('DESITE').AsString;
          dadosItem.fltQtdIte := objConEqu.cdsIteEqu.FieldByName('QTDITE').AsFloat;
          dadosItem.fltUnitar := objConEqu.cdsIteEqu.FieldByName('UNITAR').AsFloat;
          dadosItem.fltUniOri := objConEqu.cdsIteEqu.FieldByName('UNIORI').AsFloat;
          dadosItem.strEntRet := objConEqu.cdsIteEqu.FieldByName('ENTRET').AsString;
          dadosItem.strMd5Key := '';
          dadosItem.strPromoc := 'N';
          dadosItem.blnBxSbIt := False;
          dadosItem.strTabIte := objConEqu.cdsIteEqu.FieldByName('TABPRE').AsString;
          dadosItem.strBrinde := objConEqu.cdsIteEqu.FieldByName('BRINDE').AsString;
          dadosItem.strEmpIte := '';
          strInfAdiTinta := '';

          Result := Result And objEmitirPedido.fInserirProduto(dadosItem);

          objConEqu.cdsIteEqu.Edit();
          objConEqu.cdsIteEqu.FieldByName('CLTRIB').AsString := 'N';
          objConEqu.cdsIteEqu.Post();

          objConEqu.cdsIteEqu.Next;
        End;

        dadosItem.strNumLot := '';
        dadosItem.strCodIte := fCfgSis('ITESER', varString);
        dadosItem.strIdePro := 'NOR';
        dadosItem.strDesIte := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [fCfgSis('ITESER', varString)]);
        dadosItem.fltQtdIte := 1;
        dadosItem.fltUnitar := objConEqu.fltVlrSer;
        dadosItem.fltUniOri := objConEqu.fltVlrSer;
        dadosItem.strMd5Key := '';
        dadosItem.strPromoc := 'N';
        dadosItem.blnBxSbIt := False;
        dadosItem.strTabIte := objConEqu.cdsIteEqu.FieldByName('TABPRE').AsString;
        dadosItem.strEmpIte := '';
        strInfAdiTinta := '';

        Result := Result And objEmitirPedido.fInserirProduto(dadosItem);

        //adicionar item de serviço
        objConEqu.pAtualizarDadosServicosFatVenda(objEmitirPedido.objFatVenda.FRecSer);
        pAtualizarValoresIssFatVenda();

        If Result Then
        Begin
          Result := objEmitirPedido.fCalcularTotais And
                    objEmitirPedido.fValidarPedido;

          If Result Then
          Begin
            If (objConEqu.strSubSta = 'B') Then
              objEmitirPedido.objFatVenda.strOpcDoc := 'BR';

            objEmitirPedido.objFatVenda.pCalculaTotGerInterna();
            objEmitirPedido.objFatVenda.pAtualizaTemporariaItens(cdsVenda);

            {Recupera dados calculados}
            pAtualizarTribEquGer();
            pAtualizarTribItensEquDet();
          End;
        End;
      End;
    Finally
      objConEqu.cdsIteEqu.EnableControls;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TNegociacaoOS.fInicializarFatVenda');
  End;
end;

function TNegociacaoOS.fRetornaPorcentagemDesc(aDataSet: TDataSet): Double;
begin
  Result := 0;

  if (aDataSet.FieldByName('VLDPRO').AsFloat > 0) and (aDataSet.FieldByName('VLDSER').AsFloat > 0) then
    Result := (aDataSet.FieldByName('VLRDES').AsFloat / aDataSet.FieldByName('TOTOSE').AsFloat)
  else if (aDataSet.FieldByName('VLDPRO').AsFloat > 0) then
    Result := (aDataSet.FieldByName('VLDPRO').AsFloat / aDataSet.FieldByName('TOTPRO').AsFloat)
  else if (aDataSet.FieldByName('VLDSER').AsFloat > 0) then
    Result := Result + (aDataSet.FieldByName('VLDSER').AsFloat / aDataSet.FieldByName('TOTSER').AsFloat);

  if (Result > 0) then
    Result := Result * 100;
end;

function TNegociacaoOS.fTravaERegistraStlManEquLck(strNumOse, strCodEmp: String): Boolean;
var
  strAux: String;
begin
  Result := False;

  strAux := 'MANEQU_' + strNumOse + '_' + strCodEmp;

  If Not fLock_Unlock(strAux, True, False) Then
  Begin
    fMensagem('Atenção', 'A O.S. ' + strNumOse + ' está sendo alterada em outra estação - ' + fGetHostLock(strAux) +'.' +
                        #13 + 'Aguarde a liberação da O.S. para dar continuidade!', ['&OK']);

    Result := True;
  End
  Else
    stlManEquAltLck.Add(strAux);
end;

function TNegociacaoOS.fVerificaExisteGrid(aSeqGer: String): Boolean;
var
  cdsDados: TUniClientDataSet;
begin
  Result := False;

  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, cdsOrdSer);

  cdsDados.Filtered := False;
  cdsDados.Filter   := cdsOrdSer.Filter;
  cdsDados.Filtered := True;

  cdsDados.First;

  if cdsDados.Locate('SEQGER', aSeqGer, []) then
    Result := True;

  FreeAndNil(cdsDados);
end;

function TNegociacaoOS.fVerificaExisteOrdSer(aNumero, aCodEmp: String): Boolean;
var
  strSQL: String;
  qryAux: TUniQuery;
begin
  strSQL := fGetSelectOrdSer;
  strSQL := strSQL + ' WHERE EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '     AND EQU_CODEMP = :CODEMP ';

  try
    qryAux := fCriaQuery(Self);
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NUMOSE').AsString := aNumero;
    qryAux.ParamByName('CODEMP').AsString := aCodEmp;
    qryAux.Open;

    Result := not qryAux.IsEmpty;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TNegociacaoOS.pAdicionaIteOrd(aAutInc, aNumOSe, aCodEmp: String; aCdsItens: TDataSet);
begin
  aCdsItens.First;

  while not aCdsItens.Eof do
  begin
    cdsIteOrd.Insert;
    cdsIteOrd.FieldByName('SEQGER').AsString  := aAutInc;
    cdsIteOrd.FieldByName('NUMOSE').AsString  := aNumOSe;
    cdsIteOrd.FieldByName('EMPOSE').AsString  := aCodEmp;
    cdsIteOrd.FieldByName('AUTINC').AsString  := aCdsItens.FieldByName('AUTINC').AsString;
    cdsIteOrd.FieldByName('CODITE').AsString  := aCdsItens.FieldByName('CODITE').AsString;
    cdsIteOrd.FieldByName('DESITE').AsString  := aCdsItens.FieldByName('DESITE').AsString;
    cdsIteOrd.FieldByName('UNIDAD').AsString  := aCdsItens.FieldByName('UNIDAD').AsString;
    cdsIteOrd.FieldByName('QTDITE').AsFloat   := aCdsItens.FieldByName('QTDITE').AsFloat;
    cdsIteOrd.FieldByName('UNITAR').AsFloat   := aCdsItens.FieldByName('UNITAR').AsFloat;
    cdsIteOrd.FieldByName('TOTITE').AsFloat   := aCdsItens.FieldByName('TOTITE').AsFloat;
    cdsIteOrd.FieldByName('NUMCMP').AsString  := aCdsItens.FieldByName('NUMCMP').AsString;
    cdsIteOrd.FieldByName('NITCMP').AsInteger := aCdsItens.FieldByName('NITCMP').AsInteger;
    cdsIteOrd.FieldByName('DTACMP').AsDateTime:= aCdsItens.FieldByName('DTACMP').AsDateTime;
    cdsIteOrd.Post;

    aCdsItens.Next;
  end;
end;

procedure TNegociacaoOS.pAtualizarTribEquGer;
var
  recTribEquGer: TTribEquGer;
begin
  If (Assigned(objEmitirPedido)) And (Assigned(objEmitirPedido.objFatVenda)) Then
  Begin
    recTribEquGer.fltBasSim := objEmitirPedido.objFatVenda.fltBasSim;
    recTribEquGer.fltBasIpi := objEmitirPedido.objFatVenda.fltBasIpi;
    recTribEquGer.fltAlqIpi := objEmitirPedido.objFatVenda.fltAlqIpi;
    recTribEquGer.fltTotIpi := objEmitirPedido.objFatVenda.fltTotIpi;
    recTribEquGer.fltBasIcm := objEmitirPedido.objFatVenda.fltBasIcm;
    recTribEquGer.fltAlqIcm := objEmitirPedido.objFatVenda.fltAlqIcm;
    recTribEquGer.fltTotIcm := objEmitirPedido.objFatVenda.fltTotIcm;
    recTribEquGer.fltTotRet := objEmitirPedido.objFatVenda.fltTotRet;
    recTribEquGer.fltTotCbs := objEmitirPedido.objFatVenda.fltTotCBS;
    recTribEquGer.fltTotIbs := objEmitirPedido.objFatVenda.fltTotIBS;
    recTribEquGer.fltTotIs  := objEmitirPedido.objFatVenda.fltTotIS;
    recTribEquGer.fltAlqRet := objEmitirPedido.objFatVenda.fltAlqRet;
    recTribEquGer.fltBasRet := objEmitirPedido.objFatVenda.fltBasRet;
    recTribEquGer.fltPerIss := objEmitirPedido.objFatVenda.fltPerIss;
    recTribEquGer.fltValIss := objEmitirPedido.objFatVenda.fltValIss;
    recTribEquGer.fltBasIss := objEmitirPedido.objFatVenda.fltBasIss;
    recTribEquGer.fltRedIss := objEmitirPedido.objFatVenda.fltRedIss;

    objConEqu.pAdicionarDadosFiscaisTotais(recTribEquGer);
  End;
end;

procedure TNegociacaoOS.pAtualizarTribItensEquDet;
var
  recItem: TTribEquDet;
begin
  If (Assigned(objEmitirPedido)) And (Assigned(objEmitirPedido.objFatVenda)) And
     ((cdsVenda <> nil)) And (cdsVenda.RecordCount > 0) Then
     Begin
    Try
      cdsVenda.DisableControls;
      cdsVenda.First();

      objConEqu.fltTotIpi := 0;
      objConEqu.fltTotRet := 0;
      objConEqu.fltTotCbs := 0;
      objConEqu.fltTotIbs := 0;
      objConEqu.fltTotIs  := 0;
      objConEqu.fltVlrCon := 0;
      objConEqu.fltVlrPro := 0;

      While (Not cdsVenda.Eof) Do
      Begin
        If (fCfgSis('ITESER', varString) = cdsVenda.FieldByName('ITE_CODITE').AsString) Or
           (fCfgSis('SERTER', varString) = cdsVenda.FieldByName('ITE_CODITE').AsString) Then
        Begin
          cdsVenda.Next();
          Continue;
        End;

        recItem.strCodIte := cdsVenda.FieldByName('ITE_CODITE').AsString;

        If (cdsVenda.FieldByName('ITE_BRINDE').AsString = 'S') Then
        Begin
          recItem.strClaFis := objEmitirPedido.objFatVenda.arrMatItens[cdsVenda.RecNo - 1].strClaFis;
          recItem.strCodFis := objEmitirPedido.objFatVenda.arrMatItens[cdsVenda.RecNo - 1].strCodFis;
        End
        Else
        Begin
          recItem.strClaFis := cdsVenda.FieldByName('ITE_CLAFIS').AsString;
          recItem.strCodFis := cdsVenda.FieldByName('ABF_CODFIS').AsString;
        End;

        recItem.strIncPis := cdsVenda.FieldByName('ITE_INCPIS').AsString;
        recItem.fltValIpi := cdsVenda.FieldByName('ITE_VALIPI').AsFloat;
        recItem.fltAlqIpi := cdsVenda.FieldByName('ITE_ALQIPI').AsFloat;
        recItem.fltBasIpi := cdsVenda.FieldByName('ITE_BASIPI').AsFloat;
        recItem.fltValIcm := cdsVenda.FieldByName('ITE_VALICM').AsFloat;
        recItem.fltAlqIcm := cdsVenda.FieldByName('ITE_ALQICM').AsFloat;
        recItem.fltBasIcm := cdsVenda.FieldByName('ITE_BASICM').AsFloat;
        recItem.fltValRet := cdsVenda.FieldByName('ITE_VALRET').AsFloat;
        recItem.fltAlqRet := cdsVenda.FieldByName('ITE_ALQRET').AsFloat;
        recItem.fltBasRet := cdsVenda.FieldByName('ITE_BASRET').AsFloat;
        recItem.fltValCbs := cdsVenda.FieldByName('ITE_VALCBS').AsFloat;
        recItem.fltValIbs := cdsVenda.FieldByName('ITE_VALIBS').AsFloat;
        recItem.fltVal_Is := cdsVenda.FieldByName('ITE_VAL_IS').AsFloat;
        recItem.fltPerBas := cdsVenda.FieldByName('ITE_PERBAS').AsFloat;
        recItem.fltPerRed := cdsVenda.FieldByName('ITE_PERRED').AsFloat;
        recItem.fltVlrCon := (cdsVenda.FieldByName('ITE_TOTITE').AsFloat - cdsVenda.FieldByName('ITE_DESESP').AsFloat) +
                             cdsVenda.FieldByName('ITE_VALFRE').AsFloat +
                             cdsVenda.FieldByName('ITE_VALIPI').AsFloat +
                             cdsVenda.FieldByName('ITE_VALRET').AsFloat +
                             cdsVenda.FieldByName('ITE_DESACE').AsFloat +
                             recItem.fltValCbs +
                             recItem.fltValIbs +
                             recItem.fltVal_Is;

        recItem.fltDesEsp := cdsVenda.FieldByName('ITE_DESESP').AsFloat;

        objConEqu.pAdicionarDadosFiscaisItem(recItem);

        objConEqu.fltTotIpi := objConEqu.fltTotIpi + objConEqu.fltValIpi;
        objConEqu.fltTotRet := objConEqu.fltTotRet + objConEqu.fltValRet;
        objConEqu.fltTotCbs := objConEqu.fltTotCbs + objConEqu.fltValCbs;
        objConEqu.fltTotIbs := objConEqu.fltTotIbs + objConEqu.fltValIbs;
        objConEqu.fltTotIs  := objConEqu.fltTotIs  + objConEqu.fltVal_Is;
        objConEqu.fltVlrCon := objConEqu.fltVlrCon + recItem.fltVlrCon;

        //objConEqu.fltVlrPro := objConEqu.fltVlrPro + recItem.fltVlrCon;
        objConEqu.fltVlrPro := objConEqu.fltVlrPro + (cdsVenda.FieldByName('ITE_TOTITE').AsFloat - cdsVenda.FieldByName('ITE_DESESP').AsFloat);

        cdsVenda.Next();
      End;

      objConEqu.fltVlrCon := objConEqu.fltVlrCon + objConEqu.fltVlrSer;
    Finally
      cdsVenda.EnableControls;
    End;
  End;
end;

procedure TNegociacaoOS.pCalculaDescontos;
begin
  cdsOrdSer.DisableControls;

  cdsOrdSer.First;

  while not cdsOrdSer.Eof do
  begin
    cdsOrdSer.Edit;

    case AnsiIndexStr(UpperCase(FTipDes), ['0', '1', '2', '3']) of
      0:
      begin
        cdsOrdSer.FieldByName('PORDES').AsFloat    := 0;
        cdsOrdSer.FieldByName('VLRDES').AsFloat    := 0;
        cdsOrdSer.FieldByName('TOTDES').AsFloat    := cdsOrdSer.FieldByName('TOTGER').AsFloat;
        cdsOrdSer.FieldByName('VLDPRO').AsFloat    := 0;
        cdsOrdSer.FieldByName('VLDSER').AsFloat    := 0;
      end;
      1:
      begin
        if cdsOrdSer.FieldByName('TOTPRO').AsFloat > 0 then
        begin
          cdsOrdSer.FieldByName('PORDES').AsFloat    := (cdsOrdSer.FieldByName('TOTPRO').AsFloat / FTotPro) * FPerDes;
          cdsOrdSer.FieldByName('VLRDES').AsFloat    := (cdsOrdSer.FieldByName('TOTPRO').AsFloat / FTotPro) * FVlrDes;
          cdsOrdSer.FieldByName('TOTDES').AsFloat    := cdsOrdSer.FieldByName('TOTGER').AsFloat - cdsOrdSer.FieldByName('VLRDES').AsFloat;
          cdsOrdSer.FieldByName('VLDPRO').AsFloat    := cdsOrdSer.FieldByName('VLRDES').AsFloat;
          cdsOrdSer.FieldByName('VLDSER').AsFloat    := 0;
        end
        else
        begin
          cdsOrdSer.FieldByName('PORDES').AsFloat    := 0;
          cdsOrdSer.FieldByName('VLRDES').AsFloat    := 0;
          cdsOrdSer.FieldByName('TOTDES').AsFloat    := cdsOrdSer.FieldByName('TOTGER').AsFloat;
          cdsOrdSer.FieldByName('VLDPRO').AsFloat    := 0;
          cdsOrdSer.FieldByName('VLDSER').AsFloat    := 0;
        end;
      end;
      2:
      begin
        if cdsOrdSer.FieldByName('TOTSER').AsFloat > 0 then
        begin
          cdsOrdSer.FieldByName('PORDES').AsFloat    := (cdsOrdSer.FieldByName('TOTSER').AsFloat / FTotSer) * FPerSer;
          cdsOrdSer.FieldByName('VLRDES').AsFloat    := (cdsOrdSer.FieldByName('TOTSER').AsFloat / FTotSer) * FVlrDes;
          cdsOrdSer.FieldByName('TOTDES').AsFloat    := cdsOrdSer.FieldByName('TOTGER').AsFloat - cdsOrdSer.FieldByName('VLRDES').AsFloat;
          cdsOrdSer.FieldByName('VLDPRO').AsFloat    := 0;
          cdsOrdSer.FieldByName('VLDSER').AsFloat    := cdsOrdSer.FieldByName('VLRDES').AsFloat;
        end
        else
        begin
          cdsOrdSer.FieldByName('PORDES').AsFloat    := 0;
          cdsOrdSer.FieldByName('VLRDES').AsFloat    := 0;
          cdsOrdSer.FieldByName('TOTDES').AsFloat    := cdsOrdSer.FieldByName('TOTGER').AsFloat;
          cdsOrdSer.FieldByName('VLDPRO').AsFloat    := 0;
          cdsOrdSer.FieldByName('VLDSER').AsFloat    := 0;
        end;
      end;
      3:
      begin
        if cdsOrdSer.FieldByName('TOTPRO').AsFloat > 0 then
          cdsOrdSer.FieldByName('VLDPRO').AsFloat    := cdsOrdSer.FieldByName('TOTPRO').AsFloat * (FPerDes / 100)
        else
          cdsOrdSer.FieldByName('VLDPRO').AsFloat    := 0;

        if cdsOrdSer.FieldByName('TOTSER').AsFloat > 0 then
          cdsOrdSer.FieldByName('VLDSER').AsFloat    := cdsOrdSer.FieldByName('TOTSER').AsFloat * (FPerSer / 100)
        else
          cdsOrdSer.FieldByName('VLDSER').AsFloat    := 0;

        cdsOrdSer.FieldByName('VLRDES').AsFloat    := cdsOrdSer.FieldByName('VLDPRO').AsFloat + cdsOrdSer.FieldByName('VLDSER').AsFloat;
        cdsOrdSer.FieldByName('PORDES').AsFloat    := (cdsOrdSer.FieldByName('VLRDES').AsFloat / FTotOse) * 100;
        cdsOrdSer.FieldByName('TOTDES').AsFloat    := cdsOrdSer.FieldByName('TOTGER').AsFloat - cdsOrdSer.FieldByName('VLRDES').AsFloat;
      end;
    end;

    cdsOrdSer.Post;
    cdsOrdSer.Next;
  end;

  cdsOrdSer.EnableControls;
end;

procedure TNegociacaoOS.pCalculaTotais;
var
  cdsDados: TUniClientDataSet;
begin
  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, cdsOrdSer);

  cdsDados.Filtered := False;
  cdsDados.Filter   := cdsOrdSer.Filter;
  cdsDados.Filtered := True;

  cdsDados.First;

  FTotOse := 0;
  FTotRet := 0;
  FTotIPI := 0;
  FTotFre := 0;
  FTotGer := 0;
  FDesVlr := 0;
  FTotDes := 0;
  FTotPro := 0;
  FTotSer := 0;

  while not cdsDados.Eof do
  begin
    FTotOse := FTotOse + cdsDados.FieldByName('TOTOSE').AsFloat;
    FTotRet := FTotRet + cdsDados.FieldByName('TOTRET').AsFloat;
    FTotIPI := FTotIPI + cdsDados.FieldByName('TOTIPI').AsFloat;
    FTotFre := FTotFre + cdsDados.FieldByName('TOTFRE').AsFloat;
    FTotGer := FTotGer + cdsDados.FieldByName('TOTGER').AsFloat;
    FDesVlr := FDesVlr + cdsDados.FieldByName('VLRDES').AsFloat;
    FTotDes := FTotDes + cdsDados.FieldByName('TOTDES').AsFloat;
    FTotPro := FTotPro + cdsDados.FieldByName('TOTPRO').AsFloat;
    FTotSer := FTotSer + cdsDados.FieldByName('TOTSER').AsFloat;

    cdsDados.Next;
  end;

  FreeAndNil(cdsDados);
end;

procedure TNegociacaoOS.pCarregaHistorioDesconto;
var
  strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT DES_DESAPL DESAPL, ';
  strSQL := strSQL + '     CASE DES_DESAPL ';
  strSQL := strSQL + '         WHEN "S" THEN "SERVIÇOS" ';
  strSQL := strSQL + '         WHEN "P" THEN "PRODUTOS" ';
  strSQL := strSQL + '         WHEN "PS" THEN "PRODUTOS E SERVIÇOS" ';
  strSQL := strSQL + '     END DESCRI, ';
  strSQL := strSQL + '     CASE DES_TIPDES ';
  strSQL := strSQL + '         WHEN "P" THEN "%" ';
  strSQL := strSQL + '         WHEN "V" THEN "R$" ';
  strSQL := strSQL + '     END DESCRT, DES_TIPDES TIPDES, DES_PERDES PERDES, DES_PERSER PERSER, DES_VALDES VLRDES, DES_DTADES DTADES ';
  strSQL := strSQL + ' FROM NEGDES ';
  strSQL := strSQL + ' WHERE DES_SEQNEG = :SEQNEG ';
  strSQL := strSQL + '     AND DES_DTADES = (SELECT MAX(D.DES_DTADES) ';
  strSQL := strSQL + '                       FROM NEGDES D ';
  strSQL := strSQL + '                       WHERE D.DES_SEQNEG = NEGDES.DES_SEQNEG) ';

  qryHisDes.Close;
  qryHisDes.SQL.Clear;
  qryHisDes.SQL.Add(strSQL);
  qryHisDes.ParamByName('SEQNEG').AsString := FAutInc;
  qryHisDes.Open;
end;

procedure TNegociacaoOS.pCarregaOrdensServico;
var
  strSQL: String;
begin
  strSQL := fGetSelectOrdSer;
  strSQL := strSQL + ' INNER JOIN NEGEQU ON EQUGER.AUTOINCREM = NEGEQU.NEG_SEQGER ';
  strSQL := strSQL + ' WHERE NEG_SEQNEG = :SEQNEG ';

  qryOrdSer.Close;
  qryOrdSer.SQL.Clear;
  qryOrdSer.SQL.Add(strSQL);
  qryOrdSer.ParamByName('SEQNEG').AsString := FAutInc;
  qryOrdSer.Open;
end;

procedure TNegociacaoOS.pCdsDocGerBeforePost(dtsDocGer: TDataSet);
begin
  if dtsDocGer.FieldByName('IMPSEP').AsBoolean and
     dtsDocGer.FieldByName('LIBPED').AsBoolean then
  begin
    pMensagemOk('É necessário liberar o pedido!');
    dtsDocGer.Cancel;
    Abort;
  end;
end;

function TNegociacaoOS.fCarregaTela: Boolean;
begin
  Result := True;
  FAutInc := qryNegOSE.FieldByName('AUTINC').AsString;
  FNumNeg := qryNegOSE.FieldByName('NRONEG').AsString;
  FCodEmp := qryNegOSE.FieldByName('CODEMP').AsString;
  FCodCli := qryNegOSE.FieldByName('CODCLI').AsString;
  FNomCli := qryNegOSE.FieldByName('NOMCLI').AsString;
  FCgcCli := qryNegOSE.FieldByName('CGCCLI').AsString;
  FCodOpe := qryNegOSE.FieldByName('CODOPE').AsString;
  FNomOpe := qryNegOSE.FieldByName('NOMOPE').AsString;
  FDtaCad := qryNegOSE.FieldByName('DTACAD').AsDateTime;

  if qryNegOSE.FieldByName('DTANEG').AsDateTime > 0 then
    FDtaNeg := qryNegOSE.FieldByName('DTANEG').AsDateTime;

  FNegSta := qryNegOSE.FieldByName('NEGSTA').AsString;
  FStatus := qryNegOSE.FieldByName('STATUS').AsString;
  FTotNeg := qryNegOSE.FieldByName('TOTNEG').AsFloat;
  FPerDes := qryNegOSE.FieldByName('PERDES').AsFloat;
  FPerSer := qryNegOSE.FieldByName('PERSER').AsFloat;

  FCodCnd := qryNegOSE.FieldByName('CODCND').AsString;
  FCodFpg := qryNegOSE.FieldByName('CODFPG').AsString;
  FConPag := qryNegOSE.FieldByName('CONPAG').AsString;
  FTipDes := qryNegOSE.FieldByName('TIPDES').AsString;
  FVlrDes := qryNegOSE.FieldByName('VLRDES').AsFloat;

  {* Ordens de Serviço *}
  cdsOrdSer.DisableControls;

  while not qryOrdSer.Eof do
  begin
    if FStatus <> 'F' then
    begin
      if fTravaERegistraStlManEquLck(qryOrdSer.FieldByName('NUMOSE').AsString, qryOrdSer.FieldByName('CODEMP').AsString) then
      begin
        Result := False;
        cdsOrdSer.EnableControls;
        Exit;
      end;
    end;

    pInsereClientOrdSer(qryOrdSer);

    qryOrdSer.Next;
  end;

  cdsOrdSer.EnableControls;

  {* Histório de Descontos *}
  cdsHisDes.DisableControls;

  while not qryHisDes.Eof do
  begin
    cdsHisDes.Insert;
    cdsHisDes.FieldByName('DESAPL').AsString   := qryHisDes.FieldByName('DESAPL').AsString;
    cdsHisDes.FieldByName('DESCRI').AsString   := qryHisDes.FieldByName('DESCRI').AsString;
    cdsHisDes.FieldByName('TIPDES').AsString   := qryHisDes.FieldByName('TIPDES').AsString;
    cdsHisDes.FieldByName('DESCRT').AsString   := qryHisDes.FieldByName('DESCRT').AsString;
    cdsHisDes.FieldByName('PERPRD').AsFloat    := qryHisDes.FieldByName('PERDES').AsFloat;
    cdsHisDes.FieldByName('PERSER').AsFloat    := qryHisDes.FieldByName('PERSER').AsFloat;
    cdsHisDes.FieldByName('TOTDES').AsFloat    := qryHisDes.FieldByName('VLRDES').AsFloat;
    cdsHisDes.FieldByName('DTADES').AsDateTime := qryHisDes.FieldByName('DTADES').AsDateTime;
    cdsHisDes.FieldByName('OPERAC').AsString   := '';
    cdsHisDes.Post;

    qryHisDes.Next;
  end;

  cdsHisDes.EnableControls;
end;

procedure TNegociacaoOS.pCriaClientDocGer;
begin
  cdsDocGer := TUniClientDataSet.Create(Self);

  cdsDocGer.FieldDefs.Add('AUTINC', ftAutoInc);
  cdsDocGer.FieldDefs.Add('NUMDOC', ftString, 12);
  cdsDocGer.FieldDefs.Add('ESPDOC', ftString,  2);
  cdsDocGer.FieldDefs.Add('CODEMP', ftString,  3);
  cdsDocGer.FieldDefs.Add('VLRTOT', ftFloat);
  cdsDocGer.FieldDefs.Add('SERIE_', ftString,  3);
  cdsDocGer.FieldDefs.Add('CODCLI', ftString,  8);

  cdsDocGer.FieldDefs.Add('IMPRIM', ftBoolean);
  cdsDocGer.FieldDefs.Add('QTDVIA', ftInteger);
  cdsDocGer.FieldDefs.Add('IMPPRE', ftBoolean);
  cdsDocGer.FieldDefs.Add('IMPTOT', ftBoolean);
  cdsDocGer.FieldDefs.Add('IMPTRM', ftBoolean);

  cdsDocGer.FieldDefs.Add('IMPSEP', ftBoolean);
  cdsDocGer.FieldDefs.Add('SEPVIA', ftInteger);

  cdsDocGer.FieldDefs.Add('LIBPED', ftBoolean);

  cdsDocGer.FieldDefs.Add('PRDAMO', ftBoolean);

  cdsDocGer.FieldDefs.Add('NUMOSE', ftString, 6);
  cdsDocGer.FieldDefs.Add('EMPOSE', ftString, 3);
  cdsDocGer.FieldDefs.Add('EMPITE', ftString, 3);
  cdsDocGer.CreateDataSet;

  cdsDocGer.LogChanges := False;
  cdsDocGer.IndexFieldNames := 'CODEMP';
  cdsDocGer.Open;

  cdsDocGer.FieldByName('IMPPRE').Visible := False;
  cdsDocGer.FieldByName('IMPTOT').Visible := False;

  cdsDocGer.FieldByName('NUMDOC').Alignment := taCenter;
  cdsDocGer.FieldByName('ESPDOC').Alignment := taCenter;
  cdsDocGer.FieldByName('CODEMP').Alignment := taCenter;
  cdsDocGer.FieldByName('SERIE_').Alignment := taCenter;

  TFloatField(cdsDocGer.FieldByName('VLRTOT')).DisplayFormat := '###,##0.00';
end;

procedure TNegociacaoOS.pCriaClientHisDes;
begin
  cdsHisDes := TUniClientDataSet.Create(Self);
  cdsHisDes.FieldDefs.Add('DESAPL', ftString,  2);
  cdsHisDes.FieldDefs.Add('DESCRI', ftString, 19);
  cdsHisDes.FieldDefs.Add('TIPDES', ftString,  1);
  cdsHisDes.FieldDefs.Add('DESCRT', ftString,  2);
  cdsHisDes.FieldDefs.Add('PERPRD', ftFloat     );
  cdsHisDes.FieldDefs.Add('PERSER', ftFloat     );
  cdsHisDes.FieldDefs.Add('TOTDES', ftCurrency  );
  cdsHisDes.FieldDefs.Add('DTADES', ftDateTime  );
  cdsHisDes.FieldDefs.Add('OPERAC', ftString,  1);
  cdsHisDes.CreateDataSet;

  (cdsHisDes.FieldByName('PERPRD') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsHisDes.FieldByName('PERPRD') As TFloatField).EditFormat    := fMskDigitos(2);
  (cdsHisDes.FieldByName('PERSER') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsHisDes.FieldByName('PERSER') As TFloatField).EditFormat    := fMskDigitos(2);
end;

procedure TNegociacaoOS.pCriaClientIteOrd;
begin
  cdsIteOrd := TUniClientDataSet.Create(Self);
  cdsIteOrd.FieldDefs.Add('SEQGER', ftString,  20);
  cdsIteOrd.FieldDefs.Add('NUMOSE', ftString,   6);
  cdsIteOrd.FieldDefs.Add('EMPOSE', ftString,   3);
  cdsIteOrd.FieldDefs.Add('AUTINC', ftString,  20);
  cdsIteOrd.FieldDefs.Add('CODITE', ftString,  fTamCodIte);
  cdsIteOrd.FieldDefs.Add('DESITE', ftString,  57);
  cdsIteOrd.FieldDefs.Add('UNIDAD', ftString,  2);
  cdsIteOrd.FieldDefs.Add('QTDITE', ftFloat);
  cdsIteOrd.FieldDefs.Add('UNITAR', ftFloat);
  cdsIteOrd.FieldDefs.Add('TOTITE', ftFloat);
  cdsIteOrd.FieldDefs.Add('NUMCMP', ftString,  15);
  cdsIteOrd.FieldDefs.Add('NITCMP', ftInteger);
  cdsIteOrd.FieldDefs.Add('DTACMP', ftDateTime);
  cdsIteOrd.CreateDataSet;

  (cdsIteOrd.FieldByName('QTDITE') As TFloatField).DisplayFormat := fCfgSis('DECQTD', varInteger);
  (cdsIteOrd.FieldByName('QTDITE') As TFloatField).EditFormat    := fCfgSis('DECQTD', varInteger);
  (cdsIteOrd.FieldByName('TOTITE') As TFloatField).DisplayFormat := fCfgSis('DECUNI', varInteger);
  (cdsIteOrd.FieldByName('TOTITE') As TFloatField).EditFormat    := fCfgSis('DECUNI', varInteger);
  (cdsIteOrd.FieldByName('UNITAR') As TFloatField).DisplayFormat := fCfgSis('DECUNI', varInteger);
  (cdsIteOrd.FieldByName('UNITAR') As TFloatField).EditFormat    := fCfgSis('DECUNI', varInteger);
end;

procedure TNegociacaoOS.pCriaClientOrdSer;
begin
  cdsOrdSer := TUniClientDataSet.Create(Self);

  cdsOrdSer.FieldDefs.Add('SEQGER', ftString, 20);
  cdsOrdSer.FieldDefs.Add('CODCLI', ftString,  8);
  cdsOrdSer.FieldDefs.Add('NOMCLI', ftString, 60);
  cdsOrdSer.FieldDefs.Add('CGCCLI', ftString, 18);
  cdsOrdSer.FieldDefs.Add('NUMOSE', ftString,  6);
  cdsOrdSer.FieldDefs.Add('TABPRE', ftString,  2);
  cdsOrdSer.FieldDefs.Add('CODEMP', ftString,  3);
  cdsOrdSer.FieldDefs.Add('DTAORC', ftDateTime  );
  cdsOrdSer.FieldDefs.Add('DTACON', ftDateTime  );
  cdsOrdSer.FieldDefs.Add('TOTOSE', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('TOTRET', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('TOTIPI', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('TOTFRE', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('TOTGER', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('PORDES', ftFloat     );
  cdsOrdSer.FieldDefs.Add('VLRDES', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('TOTDES', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('TOTPRO', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('TOTSER', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('VLDPRO', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('VLDSER', ftCurrency  );
  cdsOrdSer.FieldDefs.Add('OPERAC', ftString,  1);
  cdsOrdSer.CreateDataSet;

  (cdsOrdSer.FieldByName('PORDES') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsOrdSer.FieldByName('PORDES') As TFloatField).EditFormat    := fMskDigitos(2);

  cdsOrdSer.Filtered := False;
  cdsOrdSer.Filter   := ' OPERAC<>''D'' ';
  cdsOrdSer.Filtered := True;
end;

procedure TNegociacaoOS.pDestravaELimpaStlManEquLck;
var
  intAux: Integer;
Begin
  For intAux := 0 To stlManEquAltLck.Count - 1 Do
    fLock_Unlock(stlManEquAltLck[intAux], False, False);

  stlManEquAltLck.Clear;
end;

procedure TNegociacaoOS.pInsereHistoricoDesconto(aDesApl, aTipDes: String; aPerPrd, aPerSer, aTotDes: Double);
begin
  cdsHisDes.EmptyDataSet;

  cdsHisDes.Insert;
  cdsHisDes.FieldByName('DESAPL').AsString   := aDesApl;

  case AnsiIndexStr(UpperCase(aDesApl), ['P', 'S', 'PS']) of
    0: cdsHisDes.FieldByName('DESCRI').AsString   := 'PRODUTOS';
    1: cdsHisDes.FieldByName('DESCRI').AsString   := 'SERVIÇOS';
    2: cdsHisDes.FieldByName('DESCRI').AsString   := 'PRODUTOS E SERVIÇOS';
  end;

  cdsHisDes.FieldByName('TIPDES').AsString   := aTipDes;

  case AnsiIndexStr(UpperCase(aTipDes), ['P', 'V']) of
    0: cdsHisDes.FieldByName('DESCRT').AsString   := '%';
    1: cdsHisDes.FieldByName('DESCRT').AsString   := 'R$';
  end;

  cdsHisDes.FieldByName('PERPRD').AsFloat    := aPerPrd;
  cdsHisDes.FieldByName('PERSER').AsFloat    := aPerSer;
  cdsHisDes.FieldByName('TOTDES').AsFloat    := aTotDes;
  cdsHisDes.FieldByName('DTADES').AsDateTime := nOw;
  cdsHisDes.FieldByName('OPERAC').AsString   := 'I';
  cdsHisDes.Post;
end;

procedure TNegociacaoOS.pInsereClientOrdSer(aQuery: TUniQuery; aOperac: String = '');
begin
  cdsOrdSer.Insert;
  cdsOrdSer.FieldByName('SEQGER').AsString   := aQuery.FieldByName('SEQGER').AsString;
  cdsOrdSer.FieldByName('CODCLI').AsString   := aQuery.FieldByName('CODCLI').AsString;
  cdsOrdSer.FieldByName('NOMCLI').AsString   := aQuery.FieldByName('NOMCLI').AsString;
  cdsOrdSer.FieldByName('CGCCLI').AsString   := aQuery.FieldByName('CGCCLI').AsString;
  cdsOrdSer.FieldByName('NUMOSE').AsString   := aQuery.FieldByName('NUMOSE').AsString;
  cdsOrdSer.FieldByName('CODEMP').AsString   := aQuery.FieldByName('CODEMP').AsString;
  cdsOrdSer.FieldByName('TABPRE').AsString   := aQuery.FieldByName('TABPRE').AsString;

  if not aQuery.FieldByName('DTINOR').IsNull then
    cdsOrdSer.FieldByName('DTAORC').AsDateTime := aQuery.FieldByName('DTINOR').AsDateTime;

  if not aQuery.FieldByName('DTFIOR').IsNull then
    cdsOrdSer.FieldByName('DTACON').AsDateTime := aQuery.FieldByName('DTFIOR').AsDateTime;

  cdsOrdSer.FieldByName('TOTOSE').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat + aQuery.FieldByName('TOTSER').AsFloat;
  cdsOrdSer.FieldByName('TOTRET').AsFloat    := aQuery.FieldByName('TOTRET').AsFloat;
  cdsOrdSer.FieldByName('TOTIPI').AsFloat    := aQuery.FieldByName('TOTIPI').AsFloat;
  cdsOrdSer.FieldByName('TOTFRE').AsFloat    := aQuery.FieldByName('TOTFRE').AsFloat;
  cdsOrdSer.FieldByName('TOTGER').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat + aQuery.FieldByName('TOTSER').AsFloat +
    aQuery.FieldByName('TOTRET').AsFloat + aQuery.FieldByName('TOTIPI').AsFloat + aQuery.FieldByName('TOTFRE').AsFloat +
    aQuery.FieldByName('TOTREF').AsFloat;
  cdsOrdSer.FieldByName('TOTPRO').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat;
  cdsOrdSer.FieldByName('TOTSER').AsFloat    := aQuery.FieldByName('TOTSER').AsFloat;
  cdsOrdSer.FieldByName('PORDES').AsFloat    := FPerDes;

  if FPerDes > 0 then
  begin
    if (FTipDes = '1') then
    begin
      cdsOrdSer.FieldByName('VLRDES').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat * (FPerDes / 100);
      cdsOrdSer.FieldByName('TOTDES').AsFloat    := (cdsOrdSer.FieldByName('TOTGER').AsFloat - aQuery.FieldByName('TOTPRO').AsFloat) + (aQuery.FieldByName('TOTPRO').AsFloat * ((100 - FPerDes) / 100));
      cdsOrdSer.FieldByName('VLDPRO').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat * ((100 - FPerDes) / 100);
      cdsOrdSer.FieldByName('VLDSER').AsFloat    := aQuery.FieldByName('TOTSER').AsFloat;
    end
    else if (FTipDes = '2') then
    begin
      cdsOrdSer.FieldByName('VLRDES').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat * (FPerDes / 100);
      cdsOrdSer.FieldByName('TOTDES').AsFloat    := (cdsOrdSer.FieldByName('TOTGER').AsFloat - aQuery.FieldByName('TOTSER').AsFloat) + (aQuery.FieldByName('TOTSER').AsFloat * ((100 - FPerDes) / 100));
      cdsOrdSer.FieldByName('VLDPRO').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat;
      cdsOrdSer.FieldByName('VLDSER').AsFloat    := aQuery.FieldByName('TOTSER').AsFloat * ((100 - FPerDes) / 100);
    end
    else if (FTipDes = '3') then
    begin
      cdsOrdSer.FieldByName('VLRDES').AsFloat    := cdsOrdSer.FieldByName('TOTGER').AsFloat * (FPerDes / 100);
      cdsOrdSer.FieldByName('TOTDES').AsFloat    := cdsOrdSer.FieldByName('TOTGER').AsFloat * ((100 - FPerDes) / 100);
      cdsOrdSer.FieldByName('VLDPRO').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat;
      cdsOrdSer.FieldByName('VLDSER').AsFloat    := aQuery.FieldByName('TOTSER').AsFloat;
    end;
  end
  else
  begin
    cdsOrdSer.FieldByName('VLRDES').AsFloat    := 0;
    cdsOrdSer.FieldByName('TOTDES').AsFloat    := 0;
    cdsOrdSer.FieldByName('VLDPRO').AsFloat    := aQuery.FieldByName('TOTPRO').AsFloat;
    cdsOrdSer.FieldByName('VLDSER').AsFloat    := aQuery.FieldByName('TOTSER').AsFloat;
  end;

  cdsOrdSer.FieldByName('OPERAC').AsString   := aOperac;
  cdsOrdSer.Post;
end;

procedure TNegociacaoOS.pInserirOSGrid(aNumero, aCodEmp: String);
var
  strSQL: String;
  qryAux: TUniQuery;
begin
  strSQL := fGetSelectOrdSer;
  strSQL := strSQL + ' WHERE EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '     AND EQU_CODEMP = :CODEMP ';

  qryAux := fCriaQuery;

  try
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('NUMOSE').AsString := aNumero;
    qryAux.ParamByName('CODEMP').AsString := aCodEmp;
    qryAux.Open;

    if not fVerificaExisteGrid(qryAux.FieldByName('SEQGER').AsString) then
    begin
      if not fTravaERegistraStlManEquLck(aNumero, aCodEmp) then
        pInsereClientOrdSer(qryAux, 'I');
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TNegociacaoOS.pLimpar;
begin
  pDestravaELimpaStlManEquLck;
  FAutInc := '';
  FNumNeg := '';
  FCodEmp := '';
  FCodCli := '';
  FNomCli := '';
  FCgcCli := '';
  FCodOpe := '';
  FNomOpe := '';
  FDtaCad := 0;
  FDtaNeg := 0;
  FNegSta := '';
  FStatus := '';
  FTotNeg := 0;
  FPerDes := 0;
  FPerSer := 0;
  FCodCnd := '';
  FCodFpg := '';
  FConPag := '';
  FTipDes := '0';
  FVlrDes := 0;

  FTotOse := 0;
  FTotRet := 0;
  FTotIPI := 0;
  FTotFre := 0;
  FTotGer := 0;
  FDesVlr := 0;
  FTotDes := 0;
  FFinGra := False;

  qryNegOSE.Close;
  qryOrdSer.Close;
  qryHisDes.Close;

  cdsOrdSer.EmptyDataSet;
  cdsHisDes.EmptyDataSet;
end;

procedure TNegociacaoOS.pLimparDadosCarregados;
begin
  If (Assigned(objEmitirPedido)) Then
  Begin

    {Limpa client da venda "Compartilhado via untFuncFat"}
    If (cdsVenda <> nil) Then
      cdsVenda.EmptyDataSet;

    If Assigned(objEmitirPedido.objFatVenda) Then
    Begin

      {Limpa array de produtos}
      SetLength(objEmitirPedido.objFatVenda.arrMatItens, 0);

      {Limpa record de serviços}
      FillChar(objEmitirPedido.objFatVenda.FRecSer, SizeOf(objEmitirPedido.objFatVenda.FRecSer), #0);
    End;
  End;
end;

procedure TNegociacaoOS.pRemoveTrava;
var
  LintIndex: integer;
  strAux: String;
begin
  strAux := 'MANEQU_' + cdsOrdSer.FieldByName('NUMOSE').AsString + '_' + cdsOrdSer.FieldByName('CODEMP').AsString;

  if stlManEquAltLck.Find(strAux, LintIndex) then
  begin
    fLock_Unlock(stlManEquAltLck[LintIndex], False, False);
    stlManEquAltLck.Delete(LintIndex);
  end;
end;

procedure TNegociacaoOS.pVerificaNegociacoes(aQry: TUniQuery; aTipCon, aParam: String; aCodEmp: String = ''; aarrOS: TConsultasArray = nil);
var
  strSQL,
  strChaves: String;
  intCont  : Integer;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT EQU_NUMOSE NUMOSE, EQU_CODEMP CODEMP, EQU_STATUS EQUSTA, EQU_CODCLI CODCLI, ';
  strSQL := strSQL + '     (SELECT CLI_NOMCLI ';
  strSQL := strSQL + '      FROM CADCLI ';
  strSQL := strSQL + '      WHERE EQUGER.EQU_CODCLI = CADCLI.CLI_CODCLI) NOMCLI, ';
  strSQL := strSQL + '     FORMAT(EQU_VLRCON, 2) VLRCON, NEG_NRONEG NRONEG, ';
  strSQL := strSQL + '     CASE WHEN NEG_STATUS = "F" THEN "FINALIZADA" ELSE "EM ABERTO" END STATUS, ';
  strSQL := strSQL + '     IF(EQU_STATUS = "E", "EM ABERTO", ';
  strSQL := strSQL + '     IF(EQU_STATUS = "F", "ORCAMENTO REALIZADO", ';
  strSQL := strSQL + '     IF(EQU_STATUS = "N", "REPROVADA", ';
  strSQL := strSQL + '     IF(EQU_STATUS = "A", "APROVADA", ';
  strSQL := strSQL + '     IF(EQU_STATUS = "M", "EM MANUTENÇÃO", ';
  strSQL := strSQL + '     IF(EQU_STATUS = "R", "REALIZADA", "")))))) DESSTA ';
  strSQL := strSQL + ' FROM EQUGER ';
  strSQL := strSQL + ' LEFT JOIN NEGEQU ON EQUGER.AUTOINCREM = NEGEQU.NEG_SEQGER ';
  strSQL := strSQL + ' LEFT JOIN NEGOSE ON NEGEQU.NEG_SEQNEG = NEGOSE.AUTOINCREM ';
  strSQL := strSQL + ' WHERE TRUE ';

  if aTipCon = 'C' then
  begin
    strSQL := strSQL + '     AND EQU_CODCLI = :CODCLI ';

    if (not fEmptyStr(aCodEmp)) then
      strSQL := strSQL + '     AND EQU_CODEMP = ' + QuotedStr(aCodEmp);
  end
  else if aTipCon = 'O' then
  begin
    strSQL := strSQL + '     AND EQU_NUMOSE = :NUMOSE ';
    strSQL := strSQL + '     AND EQU_CODEMP = :CODEMP ';
  end
  else
  begin
    strChaves := '';

    for intCont := Low(aarrOS) to High(aarrOS) do
      strChaves := strChaves + IIF(fEmptyStr(strChaves), '', ', ') + QuotedStr(aarrOS[intCont].strCodigo);

    strSQL := strSQL + '     AND EQUGER.AUTOINCREM IN (' + strChaves + ') ';
  end;

  aQry.Close;
  aQry.SQL.Clear;
  aQry.SQL.Text := strSQL;

  if aTipCon = 'C' then
    aQry.ParamByName('CODCLI').AsString := aParam
  else if aTipCon = 'O' then
  begin
    aQry.ParamByName('NUMOSE').AsString := aParam;
    aQry.ParamByName('CODEMP').AsString := aCodEmp;
  end;

  aQry.Open;
end;

end.
