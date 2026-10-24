unit untMovFlex;

interface

uses Classes, SysUtils, DB, DBClient, Uni, TypInfo, UniClientDataSet,
     untTypesSistema;

type
  TOnScroll = procedure of object;

Type
  TCampoTabela = Record
    Nome    : String;
    Tipo    : TFieldType;
    Tamanho : Integer;
    Formato : String;
    Legenda : String;
    Decimais: Integer;
  End;

  TTipCon = (tpcConciliados, tpcNaoConciliados, tpcTodos);

  TMovFlex = Class(TComponent)
    private
      FCodSeq: String;
      FDtaLan: TDateTime;
      FCodVen: String;
      FCodRep: String;
      FNumDoc: String;
      FEspDoc: String;
      FCreDeb: String;
      FValLan: Double;
      FCodEmp: String;
      FCodCli: String;
      FCodIte: String;
      FHisTor: String;
      FNumPok: String;
      FIncrem: String;

      FQryFle: TUniQuery;
      FCdsFle: TUniClientDataSet;
      FDtsFle: TDataSource;
      FSeqDor: String;
      FTipPar: String;

      FCodVba: String;
      FOrigem: String;
      FCodSup: String;
      FCodFor: String;

      FCampos: Array Of TCampoTabela;

      pOnScroll: TOnScroll;

      procedure pSetDtaLan(Const Value: TDateTime);
      procedure pSetCodVen(Const Value: String);
      procedure pSetCodRep(Const Value: String);
      procedure pSetNumDoc(Const Value: String);
      procedure pSetEspDoc(Const Value: String);
      procedure pSetCreDeb(Const Value: String);
      procedure pSetValLan(Const Value: Double);
      procedure pSetCodCli(Const Value: String);
      procedure pSetCodIte(Const Value: String);
      procedure pSetOrigem(const Value: String);
      procedure pSetCodSup(Const Value: String);
      procedure pSetCodFor(Const Value: String);
      procedure pSetCodEmp(Const Value: String);

      function fPropValor(Campo: String): Variant;
      function fGetSql(strSeqMov: String = ''): String;
      function fDocumentoExiste(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

      procedure pCriaCdsMovFlex;
      procedure pLimpaProperty(Owner: TComponent);
      procedure pAtualizaPropValor(DataSet: TDataSet);
      procedure pAddCampo(Nome, Legenda, Formato: String; Tipo: TFieldType;Tamanho, Decimais: Integer);
      function  fPermitirEmBranco: Boolean;
      class function  fDocOriginadoPelaExpedicaoCP(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;

    protected

      procedure pAfterScroll(DataSet: TDataSet);Virtual;
      procedure pAfterOpen(DataSet: TDataSet);Virtual;

    public

      blnValidarCampos: Boolean;
      blnPermitirEmBranco: Boolean;

      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      procedure pCarrega(strSeqMov: String);
      procedure pAdiciona;
      procedure pLimpaRegistros;

      procedure pAbreQueryCadastro;

      function fGravar: String;

      function fCalculaValorFlexCitel(fltPrecoCusto,
                                      fltPrecoVenda,
                                      fltFatorFlexItem,
                                      fltFatorFlexVendedor: Double): Double;

      procedure pAtualiza(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte: String; fltValLan: Double; strMotDel, strSeqDor: String; blnCredita: Boolean = False);Overload;

      class procedure pExcluir(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strAutInc: String; blnGravarDel: Boolean = False; strMotDel: String = '');Overload;
      class procedure pExcluir(strCodSeq: String);Overload;
      class procedure pExcluirItemDoPedido(strSeqDor: String);

      class function fSaldoFlexDisponivelVendedor(strCodVen: String;
        strNumPed: String = ''; strEmpPed: String = ''): Double;

      class procedure pRestaurarDelMovFle(strNumPed, strEspPed, strEmpPed: String; strCodIte, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTabela, strAutInc, strInd_PD, strInc_Pd: String; Var strIncRes: String);

      class function fExisteDocumento(strNumDoc, strEspDoc, strCodEmp, strCodIte: String): Boolean;
      class function fRetornaValorFlexDoDocumento(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strSeqDor: String; var strCreDeb: String; blnOriExpCP: Boolean = True): Double;
      class procedure pAdicionarVerbaFlex(strNumPok, strNumDoc, strCodVen, strCodSup: String; dtaDtaLan: TDateTime);
      class function fGetQueryPedVba(strNumPok: String): TUniQuery;
    published

      property strCodSeq: String Read FCodSeq Write FCodSeq;
      property strCodVen: String Read FCodVen Write pSetCodVen;
      property strNumDoc: String Read FNumDoc Write pSetNumDoc;
      property strCreDeb: String Read FCreDeb Write pSetCreDeb;
      property strCodEmp: String Read FCodEmp Write pSetCodEmp;
      property strCodCli: String Read FCodCli Write pSetCodCli;
      property strCodIte: String Read FCodIte Write pSetCodIte;
      property strHistor: String Read FHisTor Write FHisTor;
      property strNumPok: String Read FNumPok Write FNumPok;
      property strEspDoc: String Read FEspDoc Write pSetEspDoc;
      property strCodRep: String Read FCodRep Write pSetCodRep;
      property strIncrem: String Read FIncrem Write FIncrem;
      property fltValLan: Double Read FValLan Write pSetValLan;
      property dtaDtaLan: TDateTime Read FDtaLan Write pSetDtaLan;

      property qryMovFle: TUniQuery      Read FQryFle Write FQryFle;
      property cdsMovFle: TUniClientDataSet Read FCdsFle Write FCdsFle;
      property dtsDtaFle: TDataSource    Read FDtsFle Write FDtsFle;
      property strSeqDor: String         Read FSeqDor Write FSeqDor;
      property strTipPar: String         Read FTipPar Write FTipPar;

      property strCodVba: String Read FCodVba Write FCodVba;
      property strOrigem: String Read FOrigem write pSetOrigem;
      property strCodSup: String Read FCodSup Write pSetCodSup;
      property strCodFor: String Read FCodFor Write pSetCodFor;

      property pScroll: TOnScroll Read pOnScroll Write pOnScroll;
  End;

  TMovFlexImp = Class(TComponent)
    private
      FDtaIni: TDateTime;
      FDtaFin: TDateTime;
      FCodVen: String;
      FNomVen: String;
      FCodRep: String;
      FNomRep: String;
      FCodEmp: String;
      FNomEmp: String;
      FCodCli: String;
      FNomCli: String;
      FLinGru: String;
      FNomGru: String;      
      FCodFor: String;
      FNomFor: String;
      FCodMar: String;
      FNomMar: String;      
      FCodPro: String;
      FNomPro: String;      
      FCreDeb: String;
      FQuebra: String;
      FOrigem: String;
      FTipRel: String;
      FDestin: String;
      FQryImp: TUniQuery;
      FarrVen: TConsultasArray;
      FarrEmp: TConsultasArray;
      FarrCli: TConsultasArray;
      FarrSup: TConsultasArray;
      FarrMot: TConsultasArray;
      FarrRed: TConsultasArray;
      FarrFor: TConsultasArray;
      FarrMar: TConsultasArray;
      FarrPro: TConsultasArray;
      FarrGru: TConsultasArray;
      FarrRep: TConsultasArray;
      FPedFle: Boolean;
      FParOpe: Boolean;
      FParEmp: Boolean;
      FAbcPor: String;
      FQtdReg: Integer;
      FOrdAbc: String;
      FConcil: TTipCon;
      FCodSup: String;
      FNomSup: String;
      FCodRed: String;
      FNomRed: String;
      FCodMot: String;
      FDesMot: String;

      FCabLinVen: String;
      FCabLinEmp: String;
      FCabLinCli: String;
      FCabLinMar: String;
      FCabLinPro: String;
      FCabLinGru: String;
      FCabLinFor: String;
      FCabLinSup: String;
      FCabLinRed: String;
      FCabLinMot: String;
      FCabLinRep: String;

      function GetDtaIni: String;
      function GetDtaFin: String;
      
      procedure SetDtaIni(Const Value: String);
      procedure SetDtaFin(Const Value: String);
      procedure SetCodVen(Const Value: String);
      procedure SetCodRep(Const Value: String);
      procedure SetCodEmp(Const Value: String);            
      procedure SetCodCli(Const Value: String);
      procedure SetLinGru(Const Value: String);      
      procedure SetCodFor(Const Value: String);
      procedure SetCodMar(Const Value: String);      
      procedure SetCodPro(Const Value: String);
      procedure SetCreDeb(Const Value: String);
      procedure SetQuebra(Const Value: String);
      procedure SetTipRel(Const Value: String);
      procedure SetDestin(Const Value: String);
      procedure SetOrigem(const Value: String);
      procedure SetCodSup(Const Value: String);
      procedure SetCodRed(Const Value: String);
      procedure SetCodMot(Const Value: String);
    protected
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      Function fSQLBase(blnSaldoAnterior: Boolean = False;
                        strCodVenSalAnt : String = '';
                        blnInnerIte: Boolean = False;
                        blnInnerCli: Boolean = False): String;

      Function fSQLFiltros(blnSaldoAnterior: Boolean = False;
                           strCodVenSalAnt : String = ''): String;
      Function fSaldoAnterior(strCodVen: String): Double;
      procedure pLimpaCabTitulos;
      procedure pSetaParametros(qryDestin: TUniQuery);
    published

      property strDtaIni: String  Read GetDtaIni Write SetDtaIni;
      property strDtaFin: String  Read GetDtaFin Write SetDtaFin;
      property strCodVen: String  Read FCodVen   Write SetCodVen;
      property strCodRep: String  Read FCodRep   Write SetCodRep;
      property strCodEmp: String  Read FCodEmp   Write SetCodEmp;
      property strCodCli: String  Read FCodCli   Write SetCodCli;
      property strLinGru: String  Read FLinGru   Write SetLinGru;
      property strCodFor: String  Read FCodFor   Write SetCodFor;
      property strCodMar: String  Read FCodMar   Write SetCodMar;
      property strCodPro: String  Read FCodPro   Write SetCodPro;
      property strCreDeb: String  Read FCreDeb   Write SetCreDeb;
      property strQuebra: String  Read FQuebra   Write SetQuebra;
      property strOrigem: String  Read FOrigem   Write SetOrigem;
      property strTipRel: String  Read FTipRel   Write SetTipRel;
      property strDestin: String  Read FDestin   Write SetDestin;
      property qryQryImp: TUniQuery Read FQryImp   Write FQryImp;
      property arrVended: TConsultasArray Read FarrVen Write FarrVen;
      property arrEmpres: TConsultasArray Read FarrEmp Write FarrEmp;
      property arrClient: TConsultasArray Read FarrCli Write FarrCli;
      property arrSuperv: TConsultasArray Read FarrSup Write FarrSup;
      property arrRedeDe: TConsultasArray Read FarrRed Write FarrRed;
      property arrFornec: TConsultasArray Read FarrFor Write FarrFor;
      property arrMarca_: TConsultasArray Read FarrMar Write FarrMar;
      property arrProdut: TConsultasArray Read FarrPro Write FarrPro;
      property arrGrupo_: TConsultasArray Read FarrGru Write FarrGru;
      property arrRepres: TConsultasArray Read FarrRep Write FarrRep;
      property arrCodMot: TConsultasArray Read FarrMot Write FarrMot;

      property strNomVen: String  Read FNomVen;
      property strNomRep: String  Read FNomRep;
      property strNomEmp: String  Read FNomEmp;
      property strNomCli: String  Read FNomCli;
      property strNomGru: String  Read FNomGru;
      property strNomFor: String  Read FNomFor;
      property strNomMar: String  Read FNomMar;
      property strNomPro: String  Read FNomPro;
      property strNomSup: String  Read FNomSup;
      property strNomRed: String  Read FNomRed;
      property strDesMot: String  Read FDesMot;

      property blnPedFle: Boolean read FPedFle write FPedFle;
      property blnParEmp: Boolean read FParEmp write FParEmp;
      property blnParOpe: Boolean read FParOpe write FParOpe;

      property strAbcPor: String  read FAbcPor write FAbcPor;
      property intQtdReg: Integer read FQtdReg write FQtdReg;
      property strOrdAbc: String  read FOrdAbc write FOrdAbc;
      property tpcConcil: TTipCon read FConcil write FConcil;

      property strCodSup: String  Read FCodSup Write SetCodSup;
      property strCodRed: String  Read FCodRed Write SetCodRed;
      property strCodMot: String  Read FCodMot Write SetCodMot;

      property strCabLinVen: String Read FCabLinVen Write FCabLinVen;
      property strCabLinEmp: String Read FCabLinEmp Write FCabLinEmp;
      property strCabLinCli: String Read FCabLinCli Write FCabLinCli;
      property strCabLinGru: String Read FCabLinGru Write FCabLinGru;
      property strCabLinFor: String Read FCabLinFor Write FCabLinFor;
      property strCabLinMar: String Read FCabLinMar Write FCabLinMar;
      property strCabLinPro: String Read FCabLinPro Write FCabLinPro;
      property strCabLinSup: String Read FCabLinSup Write FCabLinSup;
      property strCabLinRed: String Read FCabLinRed Write FCabLinRed;
      property strCabLinMot: String Read FCabLinMot Write FCabLinMot;
      property strCabLinRep: String Read FCabLinRep Write FCabLinRep;
  End;

implementation

uses StrUtils, Variants, untFuncoesSimples, untFuncoesConsulta;

constructor TMovFlexImp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FQryImp := fCriaQuery(Self);
  FPedFle := True;
  FConcil := tpcTodos;
end;

destructor TMovFlexImp.Destroy;
begin
  inherited Destroy;
end;

function TMovFlexImp.fSaldoAnterior(strCodVen: String): Double;
  Var
    strSQL : String;
    qryAux : TUniQuery;
Begin
  Try
    qryAux := fCriaQuery;           

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(FLE_CODVEN, "-", NOMVEN) AS QUEBRA, ';
    strSQL := strSQL + '  SUM(IFNULL(VALCRE,0)) - SUM(IFNULL(VALDEB,0)) AS SALANT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' (' + fSQLBase(True, strCodVen) + ') AS SALDO ';
    strSQL := strSQL + 'GROUP BY QUEBRA ';
    strSQL := strSQL + 'ORDER BY QUEBRA ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      pSetaParametros(qryAux);
      Open;

      Result := FieldByName('SALANT').AsCurrency;

      Close;
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function TMovFlexImp.fSQLBase(blnSaldoAnterior: Boolean = False;
                              strCodVenSalAnt : String = '';
                              blnInnerIte: Boolean = False;
                              blnInnerCli: Boolean = False): String;

  function fInnerLeft(blnInner: Boolean): String;
  begin
    Result := IfThen(blnInner, 'INNER', 'LEFT');
  end;

begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  SQL_NO_CACHE ';
  Result := Result + '  MOVFLE.AUTOINCREM AS FLE_AUTINC, ';
  Result := Result + '  FLE_CODVEN, ';
  Result := Result + '  V.OPE_NOMOPE AS NOMVEN, ';
  Result := Result + '  FLE_CODREP, ';
  Result := Result + '  R.OPE_NOMOPE AS NOMREP, ';
  Result := Result + '  FLE_CODSUP, ';
  Result := Result + '  S.OPE_NOMOPE AS NOMSUP, ';
  Result := Result + '  FLE_CODFOR, ';
  Result := Result + '  F.FOR_NOMFOR AS NOMFOR, ';
  Result := Result + '  FLE_DTALAN, ';
  Result := Result + '  FLE_NUMDOC, ';
  Result := Result + '  FLE_ESPDOC, ';
  Result := Result + '  FLE_CODEMP, ';
  Result := Result + '  FLE_CODCLI, ';
  Result := Result + '  C.CLI_NOMCLI, ';
  Result := Result + '  C.CLI_CODRED, ';
  Result := Result + '  FLE_CODITE, ';
  Result := Result + '  ITE_DESITE, ';
  Result := Result + '  FLE_HISTOR, ';
  Result := Result + '  FLE_CREDEB, ';
  Result := Result + '  IF(FLE_CREDEB = "C", FLE_VALLAN, NULL) AS VALCRE, ';
  Result := Result + '  IF(FLE_CREDEB = "D", FLE_VALLAN, NULL) AS VALDEB, ';
  Result := Result + '  FLE_TIPPAR, ';

  If (FQuebra = 'M') Or (FOrigem = 'V') Then
  Begin
    Result := Result + ' FLE_CODVBA, ';
    Result := Result + ' CADVBA.VBA_CODMOT, ';
    Result := Result + ' MOTVBA.VBA_DESMOT AS DESMOT, ';
  End;

  Result := Result + '  FLE_DTACON,   ';
  Result := Result + '  V.OPE_PEOPFL, ';
  Result := Result + '  V.OPE_PEEMFL  ';
  Result := Result + 'FROM ';
  Result := Result + '  MOVFLE ';

  If (FQuebra = 'M') Or (FOrigem = 'V') Then
  Begin
    Result := Result + IIF(FQuebra = 'M', 'INNER', 'LEFT') + ' JOIN CADVBA ON CADVBA.VBA_CODVBA = MOVFLE.FLE_CODVBA ';
    Result := Result + IIF(FQuebra = 'M', 'INNER', 'LEFT') + ' JOIN MOTVBA ON MOTVBA.VBA_CODMOT = CADVBA.VBA_CODMOT ';
  End;

  Result := Result + '  INNER JOIN CADOPE V ON V.OPE_CODOPE = FLE_CODVEN ';
  Result := Result + '   LEFT JOIN CADOPE S ON S.OPE_CODOPE = FLE_CODSUP ';
  Result := Result + fInnerLeft(blnInnerIte) + ' JOIN CADITE I ON I.ITE_CODITE = FLE_CODITE ';
  Result := Result + fInnerLeft(blnInnerCli) + ' JOIN CADCLI C ON C.CLI_CODCLI = FLE_CODCLI ';
  Result := Result + '   LEFT JOIN CADOPE R ON R.OPE_CODOPE = FLE_CODREP ';
  Result := Result + '   LEFT JOIN CADFOR F ON F.FOR_CODFOR = ITE_CODFOR ';
  Result := Result + 'WHERE (FLE_ESPDOC <> "PR" ';
  Result := Result + '   OR  (FLE_ESPDOC = "PR" ';
  Result := Result + '  AND   FLE_CREDEB = "D")) ';
  Result := Result + fSQLFiltros(blnSaldoAnterior, strCodVenSalAnt);
end;

Function TMovFlexImp.fSQLFiltros(blnSaldoAnterior: Boolean = False;
                                 strCodVenSalAnt : String = ''): String;
begin
  Result := '';

  If Not blnSaldoAnterior Then
  Begin
    If (FDtaFin > 0) Then
      Result := Result + ' AND FLE_DTALAN BETWEEN :DTAINI AND :DTAFIN ';
  End
  Else
  Begin
    Result := Result + ' AND FLE_DTALAN < :DTAINI ';

    If (Not fEmptyStr(strCodVenSalAnt)) Then
    Begin
      If SameText(FQuebra,'V') Then
        Result := Result + ' AND FLE_CODVEN = ' + QuotedStr(strCodVenSalAnt)
      Else If SameText(FQuebra,'R') Then
        Result := Result + ' AND FLE_CODREP = ' + QuotedStr(strCodVenSalAnt)
      Else If SameText(FQuebra, 'M') Then
        Result := Result + ' AND CADVBA.VBA_CODMOT = ' + QuotedStr(strCodVenSalAnt);
    End;
  End;

  If Not fEmptyStr(FCodVen) Then
    Result := Result + fStrLocate(Nil, FarrVen, 'FLE_CODVEN', 'CODVEN', False, False, FCodVen);

  If Not fEmptyStr(FCodRep) Then
    Result := Result + fStrLocate(Nil, FarrRep, 'FLE_CODREP', 'CODREP', False, False, FCodRep);

  If Not fEmptyStr(FCodEmp) Then
    Result := Result + fStrLocate(Nil, FarrEmp, 'FLE_CODEMP', 'CODEMP', False, False, FCodEmp);

  If Not fEmptyStr(FCodCli) Then
    Result := Result + fStrLocate(Nil, FarrCli, 'FLE_CODCLI', 'CODCLI', False, False, FCodCli);

  If Not fEmptyStr(FCodSup) Then
    Result := Result + fStrLocate(Nil, FarrSup, 'FLE_CODSUP', 'CODSUP', False, False, FCodSup);

  If Not fEmptyStr(FCodMot) Then
    Result := Result + fStrLocate(Nil, FarrMot, 'CADVBA.VBA_CODMOT', 'CODMOT', False, False, FCodMot);

  If Not fEmptyStr(FCodRed) Then
    Result := Result + fStrLocate(Nil, FarrRed, 'CLI_CODRED', 'CODRED', False, False, FCodRed);

  If Not FPedFle Then
    Result := Result + ' AND FLE_ESPDOC <> "PD" ';

  If FParEmp Then
    Result := Result + ' AND FLE_TIPPAR = "E" ';

  If FParOpe Then
    Result := Result + ' AND FLE_TIPPAR IN ("V", "R") ';

  If SameText(FQuebra,'V') Then
    Result := Result + ' AND FLE_CODVEN IS NOT NULL '
  Else If SameText(FQuebra,'R') Then
    Result := Result + ' AND FLE_CODREP IS NOT NULL ';

  If Not fEmptyStr(FLinGru) Then
  Begin
    If Length(arrGrupo_) > 1 Then
      Result := Result +  fStrLocate(Nil, FarrGru, 'ITE_CODGRU', 'CODGRU', False, False, FLinGru)
    Else
    Begin
      If RightStr(FLinGru,3) = '000' Then
        Result := Result + ' AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
      Else
        Result := Result + ' AND ITE_CODGRU = :CODGRU ';
    End;
  End;

  If Not fEmptyStr(FCodFor) Then
    Result := Result + fStrLocate(Nil, FarrFor, 'ITE_CODFOR', 'CODFOR', False, False, FCodFor);

  If Not fEmptyStr(FCodMar) Then
    Result := Result + fStrLocate(Nil, FarrMar, 'ITE_CODMAR', 'CODMAR', False, False, FCodMar);

  If Not fEmptyStr(FCodPro) Then
    Result := Result + fStrLocate(Nil, FarrPro, 'ITE_CODITE', 'CODPRO', False, False, FCodPro);

  If FCreDeb <> 'T' Then
    Result := Result + ' AND FLE_CREDEB = :CREDEB ';

  If (Not fEmptyStr(FOrigem)) And (FOrigem <> 'T') Then
    Result := Result + ' AND FLE_ORIGEM = :ORIGEM ';

  If (Not blnSaldoAnterior) And (FConcil <> tpcTodos) Then
  Begin
    Case FConcil Of
      tpcConciliados:    Result := Result + ' AND FLE_DTACON IS NOT NULL ';
      tpcNaoConciliados: Result := Result + ' AND FLE_DTACON IS NULL     ';
    End;
  End;
end;

function TMovFlexImp.GetDtaIni: String;
begin
  If FDtaIni = 0 Then
    Result := ''
  Else
    Result := FormatDateTime('dd/mm/yyyy', FDtaIni);
end;

function TMovFlexImp.GetDtaFin: String;
begin
  If FDtaFin = 0 Then
    Result := ''
  Else
    Result := FormatDateTime('dd/mm/yyyy', FDtaFin);
end;

procedure TMovFlexImp.SetDtaIni(Const Value: String);
begin
  If fEmptyStr(fTiraCaracEspeciais(Value)) Then
  Begin
    FDtaIni := 0;
    FDtaFin := 0;
  End
  Else
    FDtaIni := StrToDate(Value);
end;

procedure TMovFlexImp.SetDtaFin(Const Value: String);
begin
  If fEmptyStr(fTiraCaracEspeciais(Value)) Then
  Begin
    If (FDtaIni > 0) Then
      Raise Exception.Create('A data final deve ser informada!')
    Else
      FDtaFin := 0;
  End
  Else
  Begin
    If (FDtaIni = 0) Then
      Raise Exception.Create('A data inicial deve ser informada!')
    Else If (FDtaIni > StrToDate(Value)) Then
      Raise Exception.Create('A data final deve ser maior que a data inicial!')
    Else
      FDtaFin := StrToDate(Value);
  End;
end;

procedure TMovFlexImp.SetCodRed(const Value: String);
begin
  If (Value = '00000') Then
  Begin
    FCodRed := Value;
    FNomRed := '+1';
  End
  Else
  Begin
    FCodRed := '';
    FNomRed := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomRed := fCampoTabela('RED_DESRED', 'CADRED', ['RED_CODRED'], [Value]);
      If Not fEmptyStr(FNomRed) Then
        FCodRed := Value
      Else
        Raise Exception.Create('O código da Rede de Lojas não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetCodRep(Const Value: String);
begin
  If (Value = '000') Then
  Begin
    FCodRep := Value;
    FNomRep := '+1';
  End
  Else
  Begin
    FCodRep := '';
    FNomRep := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomRep := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [Value]);
      If Not fEmptyStr(FNomRep) Then
        FCodRep := Value
      Else
        Raise Exception.Create('O código do representante não existe!');
    End;
  End;  
end;

procedure TMovFlexImp.SetCodVen(Const Value: String);
begin
  If (Value = '000') Then
  Begin
    FCodVen := Value;
    FNomVen := '+1';
  End
  Else
  Begin
    FCodVen := '';
    FNomVen := 'TODOS';

    If (Not fEmptyStr(Value)) Then
    Begin
      FNomVen := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [Value]);
      If Not fEmptyStr(FNomVen) Then
        FCodVen := Value
      Else
        Raise Exception.Create('O código do vendedor não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetCodCli(Const Value: String);
begin
  If (Value = '00000000') Then
  Begin
    FCodCli := Value;
    FNomCli := '+1';
  End
  Else
  Begin
    FCodCli := '';
    FNomCli := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomCli := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [Value]);
      If Not fEmptyStr(FNomCli) Then
        FCodCli := Value
      Else
        Raise Exception.Create('O código do cliente não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetCodEmp(const Value: String);
begin
  If (Value = '000') Then
  Begin
    FCodEmp := Value;
    FNomEmp := '+1';
  End
  Else
  Begin
    FCodEmp := '';
    FNomEmp := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomEmp := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [Value], False);
      If Not fEmptyStr(FNomEmp) Then
        FCodEmp := Value
      Else
        Raise Exception.Create('O código da empresa não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetCodFor(Const Value: String);
begin
  If (Value = '00000000') Then
  Begin
    FCodFor := Value;
    FNomFor := '+1';
  End
  Else
  Begin
    FCodFor := '';
    FNomFor := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomFor := fCampoTabela('FOR_NOMFOR','CADFOR',['FOR_CODFOR'], [Value]);
      If Not fEmptyStr(FNomFor) Then
        FCodFor := Value
      Else
        Raise Exception.Create('O código do fornecedor não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetCodMar(const Value: String);
begin
  If (Value = '000000') Then
  Begin
    FCodMar := Value;
    FNomMar := '+1';
  End
  Else
  Begin
    FCodMar := '';
    FNomMar := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomMar := fCampoTabela('MAR_DESMAR','CADMAR',['MAR_CODMAR'], [Value]);
      If Not fEmptyStr(FNomMar) Then
        FCodMar := Value
      Else
        Raise Exception.Create('O código da marca não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetCodPro(Const Value: String);
begin
  If (Value = '00000') Then
  Begin
    FCodPro := Value;
    FNomPro := '+1';
  End
  Else
  Begin
    FCodPro := '';
    FNomPro := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomPro := fCampoTabela('ITE_DESITE','CADITE',['ITE_CODITE'], [Value], False);
      If Not fEmptyStr(FNomPro) Then
        FCodPro := Value
      Else
        Raise Exception.Create('O código do produto não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetQuebra(const Value: String);
begin
  If Pos(Value, 'VFM') > 0 Then
    FQuebra := Value
  Else
    Raise Exception.Create('A Quebra do relatório deve ser (V)endedor, (F)ornecedor ou (M)otivo da Verba!');
end;

procedure TMovFlexImp.SetCreDeb(Const Value: String);
begin
  If Pos(Value, 'CDT') > 0 Then
    FCreDeb := Value
  Else
    Raise Exception.Create('O Campo lançamento deve ser (C)rédito, (D)ébito ou (T)odos!');
end;

procedure TMovFlexImp.SetLinGru(const Value: String);
begin
  If (LeftStr(Value,3) = '000') Then
  Begin
    FLinGru := Value;
    FNomGru := '+1';
  End
  Else
  Begin
    FLinGru := '';
    FNomGru := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomGru := fCampoTabela('GRU_DESGRU','CADGRU',['GRU_CODGRU'], [Value]);
      If Not fEmptyStr(FNomGru) Then
        FLinGru := Value
      Else
        Raise Exception.Create('O Código da Linha/Grupo não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetTipRel(Const Value: String);
begin
  If Pos(Value, 'AS') > 0 Then
    FTipRel := Value
  Else
    Raise Exception.Create('O Campo tipo do relatório deve ser (A)nalítico ou (S)intético!');
end;

procedure TMovFlexImp.SetDestin(Const Value: String);
begin
  If Pos(Value, 'V_I_E_') > 0 Then
    FDestin := Value
  Else
    Raise Exception.Create('O Campo destino deve ser (V)ídeo, (I)mpressora ou (E)xcel!');
end;

procedure TMovFlexImp.SetOrigem(const Value: String);
begin
  If Pos(Value, 'VFT') > 0 Then
    FOrigem := Value
  Else
    Raise Exception.Create('O campo origem deve ser (V)erba, (F)lex ou (T)odos!');
end;

procedure TMovFlexImp.pLimpaCabTitulos;
begin
  FCabLinVen := '';
  FCabLinEmp := '';
  FCabLinCli := '';
  FCabLinMar := '';
  FCabLinPro := '';
  FCabLinGru := '';
  FCabLinFor := '';
  FCabLinSup := '';
  FCabLinRed := '';
  FCabLinMot := '';
  FCabLinRep := '';
end;

procedure TMovFlexImp.pSetaParametros(qryDestin: TUniQuery);
begin
  With qryDestin Do
  Begin
    If (FDtaIni <> 0) And (Params.FindParam('DTAINI') <> Nil) Then
      ParamByName('DTAINI').AsDateTime := FDtaIni;

    If (FDtaFin <> 0) And (Params.FindParam('DTAFIN') <> Nil) Then
      ParamByName('DTAFIN').AsDateTime := FDtaFin;

    If (Not fEmptyStr(FCodVen)) And (Params.FindParam('CODVEN') <> Nil) Then
      pSetaParam(FCodVen, FarrVen, FCabLinVen, 'CODVEN', qryDestin);

    If (Not fEmptyStr(FCodEmp)) And (Params.FindParam('CODEMP') <> Nil) Then
      pSetaParam(FCodEmp, FarrEmp, FCabLinEmp, 'CODEMP', qryDestin);

    If (Not fEmptyStr(FCodCli)) And (Params.FindParam('CODCLI') <> Nil) Then
      pSetaParam(FCodCli, FarrCli, FCabLinCli, 'CODCLI', qryDestin);

    If (Not fEmptyStr(FLinGru)) And (Params.FindParam('CODGRU') <> Nil) Then
      pSetaParam(FLinGru, FarrGru, FCabLinGru, 'CODGRU', qryDestin);

    If (Not fEmptyStr(FCodFor)) And (Params.FindParam('CODFOR') <> Nil) Then
      pSetaParam(FCodFor, FarrFor, FCabLinFor, 'CODFOR', qryDestin);

    If (Not fEmptyStr(FCodMar)) And (Params.FindParam('CODMAR') <> Nil) Then
      pSetaParam(FCodMar, FarrMar, FCabLinMar, 'CODMAR', qryDestin);

    If Not fEmptyStr(FCodPro) And (Params.FindParam('CODPRO') <> Nil) Then
      pSetaParam(FCodPro, FarrPro, FCabLinPro, 'CODPRO', qryDestin);

    If Not fEmptyStr(FCodRep) And (Params.FindParam('CODREP') <> Nil) Then
      pSetaParam(FCodRep, FarrRep, FCabLinRep, 'CODREP', qryDestin);

    If Not fEmptyStr(FCodSup) And (Params.FindParam('CODSUP') <> Nil) Then
      pSetaParam(FCodSup, FarrSup, FCabLinSup, 'CODSUP', qryDestin);

    If Not fEmptyStr(FCodRed) And (Params.FindParam('CODRED') <> Nil) Then
      pSetaParam(FCodRed, FarrRed, FCabLinRed, 'CODRED', qryDestin);

    If Not fEmptyStr(FCodMot) And (Params.FindParam('CODMOT') <> Nil) Then
      pSetaParam(FCodMot, FarrMot, FCabLinMot, 'CODMOT', qryDestin);

    If (FCreDeb <> 'T') And (Params.FindParam('CREDEB') <> Nil) Then
      ParamByName('CREDEB').AsString := FCreDeb;

    If (FOrigem <> 'T') And (Params.FindParam('ORIGEM') <> Nil) Then
      ParamByName('ORIGEM').AsString := FOrigem;
  end;
end;

procedure TMovFlexImp.SetCodSup(Const Value: String);
begin
  If (Value = '000') Then
  Begin
    FCodSup := Value;
    FNomSup := '+1';
  End
  Else
  Begin
    FCodSup := '';
    FNomSup := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FNomSup := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [Value]);
      If Not fEmptyStr(FNomSup) Then
        FCodSup := Value
      Else
        Raise Exception.Create('O código do supervisor não existe!');
    End;
  End;
end;

procedure TMovFlexImp.SetCodMot(Const Value: String);
begin
  If (Value = '00000') Then
  Begin
    FCodMot := Value;
    FDesMot := '+1';
  End
  Else
  Begin
    FCodMot := '';
    FDesMot := 'TODOS';

    If Not fEmptyStr(Value) Then
    Begin
      FDesMot := fCampoTabela('VBA_DESMOT', 'MOTVBA', ['VBA_CODMOT'], [Value]);
      If Not fEmptyStr(FDesMot) Then
        FCodMot := Value
      Else
        Raise Exception.Create('O código do motivo da verba não existe!');
    End;
  End;
end;

constructor TMovFlex.Create(AOwner: TComponent);
begin
  Inherited Create(AOwner);

  blnValidarCampos := False;
  blnPermitirEmBranco := False;

  pAddCampo('FLE_CODSEQ', 'Sequencial',            '',                ftString,  00, 0);
  pAddCampo('FLE_DTALAN', 'Data lançamento',       '99/99/9999',      ftDate,    00, 0);
  pAddCampo('FLE_CODVEN', 'Cod. Vendedor',         '',                ftString,  03, 0);
  pAddCampo('FLE_NUMDOC', 'Número Documento',      '',                ftString,  12, 0);
  pAddCampo('FLE_CREDEB', 'Crédito/Débito',        '',                ftString,  01, 0);
  pAddCampo('FLE_VALLAN', 'Valor Lançamento',      '##,#0.00',        ftFloat,   00, 2);
  pAddCampo('FLE_CODEMP', 'Empresa',               '',                ftString,  03, 0);
  pAddCampo('FLE_CODCLI', 'Cliente',               '',                ftString,  08, 0);
  pAddCampo('FLE_CODITE', 'Produto',               '',                ftString,  fTamCodIte, 0);
  pAddCampo('FLE_HISTOR', 'Histórico',             '',                ftMemo,    00, 0);
  pAddCampo('FLE_NUMPOK', 'Nº Pocket',             '',                ftString,  30, 0);
  pAddCampo('FLE_ESPDOC', 'Espécie',               '',                ftString,  02, 0);
  pAddCampo('FLE_CODREP', 'Representante',         '',                ftString,  03, 0);
  pAddCampo('AUTOINCREM', 'AutoIncremento',        '',                ftString,  20, 0);
  pAddCampo('FLE_SEQDOR', 'Sequencial FATDOR',     '',                ftString,  20, 0);
  pAddCampo('FLE_TIPPAR', 'Tipo de Parte',         '',                ftString,  01, 0);
  pAddCampo('FLE_ORIGEM', 'Origem',                '',                ftString,  01, 0);
  pAddCampo('FLE_CODVBA', 'Código da Verba',       '',                ftString,  06, 0);
  pAddCampo('FLE_CODSUP', 'Supervisor',            '',                ftString,  03, 0);
  pAddCampo('FLE_CODFOR', 'Fornecedor',            '',                ftString,  08, 0);

  FQryFle := fCriaQuery(Self);
  FDtsFle := TDataSource.Create(Self);

  pCriaCdsMovFlex;
end;

destructor TMovFlex.Destroy;
begin
  FreeAndNilProperties(Self);
  Inherited Destroy;
end;

procedure TMovFlex.pAddCampo(Nome, Legenda, Formato: String; Tipo: TFieldType;
  Tamanho, Decimais: Integer);
begin
  SetLength(FCampos, length(FCampos) + 1);
  FCampos[length(FCampos) - 1].Nome     := Nome;
  FCampos[length(FCampos) - 1].Tipo     := Tipo;
  FCampos[length(FCampos) - 1].Tamanho  := Tamanho;
  FCampos[length(FCampos) - 1].Formato  := Formato;
  FCampos[length(FCampos) - 1].Legenda  := Legenda;
  FCampos[length(FCampos) - 1].Decimais := Decimais;
end;

function TMovFlex.fGravar: String;
  Var
    intCon: Integer;

    procedure pAbreQuery;
    begin
      With FQryFle Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fGetSql(FCodSeq));
        Open;
      End;
    end;

begin

  Result := '';

  With FCdsFle Do
  Begin
    First;
    While Not Eof Do
    Begin
      pAbreQuery;

      If FQryFle.IsEmpty Then
      Begin
        FQryFle.Append;
        FCodSeq := fAtualizaProCod('MOVFLE', 'FLE_CODSEQ');
        FIncrem := fRetAutoIncrem('MOVFLE', VS_strCodEmp);
        FCodEmp := VS_strCodEmp;
      End
      Else
        FQryFle.Edit;

      For intCon := 0 To Fields.Count -1 Do
      Begin
        If (Fields[intCon].DataType = ftString) And fEmptyStr(Trim(Fields[intCon].AsString)) Then
          FQryFle.FieldByName(Fields[intCon].FieldName).Value := Null
        Else If (Fields[intCon].DataType = ftDate) And (Not fDataValida(FieldByName(Fields[intCon].FieldName).AsDateTime)) Then
          FQryFle.FieldByName(Fields[intCon].FieldName).Value := Null
        Else
          FQryFle.FieldByName(Fields[intCon].FieldName).Value := Fields[intCon].Value;
      End;

      FQryFle.FieldByName('FLE_CODSEQ').AsString := FCodSeq;
      FQryFle.FieldByName('FLE_CODEMP').AsString := FCodEmp;
      FQryFle.FieldByName('AUTOINCREM').AsString := FIncrem;

      FQryFle.Post;
      FQryFle.Close;

      Result := Result + FCodSeq + ',';

      Next;
    End;
  End;

  Result := Copy(Result, 1, Length(Result) -1);

  pLimpaRegistros;

end;

function TMovFlex.fPermitirEmBranco: Boolean;
begin
  Result := blnPermitirEmBranco;
end;

procedure TMovFlex.pSetCodSup(Const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FCodSup := Value;
    Exit;
  end;

  If Not fEmptyStr(Value) Then
  Begin
    If Not fEmptyStr(fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [Value])) Then
      FCodSup := Value
    Else
      Raise Exception.Create('O código do supervisor não existe!');
  End;
end;

class function TMovFlex.fDocOriginadoPelaExpedicaoCP(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
Var
  strSQL   : String;
  qryAux   : TUniQuery;
  strTabAux: String;
Begin

  Result := False;

  If (Pos(strTabela, 'MOVGER_NOTGER_') <= 0) Then
    Exit;

  Try

    If (strTabela = 'MOVGER') Then
      strTabAux := 'AUXMOV'
    Else
      strTabAux := 'AUXNOT';

    qryAux := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  AUX_OPCDOC ';
    strSQL := strSQL + 'FROM   ';
    strSQL := strSQL +    strTabela + ' ';
    strSQL := strSQL + '  LEFT JOIN ' + strTabAux + ' ON AUX_SEQGER = ' + strTabela + '.AUTOINCREM ';
    strSQL := strSQL + 'WHERE  ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND  ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND  ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND  ';
    strSQL := strSQL + '  AUX_OPCDOC IN ("EI","CP") ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;

      Result := Not IsEmpty;
    End;

  Finally
    FreeAndNil(qryAux);
  End;

End;

class function TMovFlex.fRetornaValorFlexDoDocumento(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strSeqDor: String; var strCreDeb: String; blnOriExpCP: Boolean = True): Double;
  Var
    qryFle : TUniQuery;
    strSQL : String;
    blnProcessarRotina : Boolean;
begin

  Try
    Result := 0;

    qryFle := fCriaQuery(Nil);

    blnProcessarRotina := True;

    If (blnOriExpCP) Then
      blnProcessarRotina := fDocOriginadoPelaExpedicaoCP(strTabela,
                                                         strNumDoc,
                                                         strEspDoc,
                                                         strCodEmp,
                                                         strCodCli);

    If (blnProcessarRotina) Then
    Begin

      strSQL := '';
      strSQL := strSQL + 'SELECT   ';
      strSQL := strSQL + '  FLE_VALLAN, ';
      strSQL := strSQL + '  FLE_CREDEB  ';
      strSQL := strSQL + 'FROM     ';
      strSQL := strSQL + '  MOVFLE ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  FLE_NUMDOC = :NUMDOC AND  ';
      strSQL := strSQL + '  FLE_ESPDOC = :ESPDOC AND  ';
      strSQL := strSQL + '  FLE_CODEMP = :CODEMP AND  ';
      strSQL := strSQL + '  FLE_CODITE = :CODITE AND  ';
      strSQL := strSQL + '  FLE_SEQDOR = :SEQDOR      ';

      With qryFle Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('SEQDOR').AsString := strSeqDor;
        Open;

        strCreDeb := FieldByName('FLE_CREDEB').AsString;

        Result := FieldByName('FLE_VALLAN').AsFloat;
      End;

    End;

  Finally
    FreeAndNil(qryFle);
  End;
end;

function TMovFlex.fPropValor(Campo: String): Variant;
  Var
    Index: Integer;
    Count: Integer;
    Lista: PPropList;
begin
  Count := GetPropList(Self, Lista);
  For Index := 2 To Count -1 Do
  Begin
    If RightStr(UpperCase(String(Lista^[Index].Name)), 6) = RightStr(Campo, 6) Then
      Result := GetPropValue(Self, String(Lista^[Index].Name));
  End;
  FreeMem(Lista);
end;

procedure TMovFlex.pLimpaProperty(Owner: TComponent);
  Var
    Index: Integer;
    Count: Integer;
    Lista: PPropList;
    Info : PPropInfo;
begin
  Count := GetPropList(Owner, Lista);
  If Count > 2 Then
  Begin
    For Index := 2 To Count -1 Do
    Begin
      Info := Lista^[Index];
      Case Info^.PropType^.Kind Of
        tkInteger, tkFloat            : SetPropValue(Owner, String(Lista^[Index].Name), 0);
        tkString, tkLString, tkWString: SetPropValue(Owner, String(Lista^[Index].Name),'');
      End;
    End;
  End;
  FreeMem(Lista);
end;

procedure TMovFlex.pAtualiza(strNumDoc, strEspDoc, strCodEmp, strCodCli,
  strCodIte: String; fltValLan: Double; strMotDel, strSeqDor: String; blnCredita: Boolean = False);
  Var
    qryDel: TUniQuery;
begin
  qryDel := fCriaQuery(Nil);

  With qryDel Do
  Begin
    {**************************************************}
    {* QUANDO FOR EXPEDIÇÃO PARCIAL, DEVE ABATER      *}
    {* O VALOR DOS PRODUTOS QUE ESTÃO SENDO FATURADOS.*}
    {* SE ABATER O VALOR TOTAL, EXCLUI O MOVLE DO PD  *}
    {***********************************************MM*}
    SQL.Clear;
    SQL.Add(' UPDATE    ');
    SQL.Add('   MOVFLE  ');
    SQL.Add(' SET  ');

    If (blnCredita) Then
      SQL.Add('   FLE_VALLAN = FLE_VALLAN + :VALLAN ')
    Else
      SQL.Add('   FLE_VALLAN = FLE_VALLAN - :VALLAN ');

    SQL.Add(' WHERE     ');
    SQL.Add('   FLE_NUMDOC = "' + strNumDoc + '" AND ');
    SQL.Add('   FLE_ESPDOC = "' + strEspDoc + '" AND ');
    SQL.Add('   FLE_CODEMP = "' + strCodEmp + '" AND ');
    SQL.Add('   FLE_CODCLI = "' + strCodCli + '" AND ');
    SQL.Add('   FLE_CODITE = "' + strCodIte + '" AND ');
    SQL.Add('   FLE_SEQDOR = "' + strSeqDor + '"     ');

    ParambyName('VALLAN').AsFloat := fltValLan;
    ExecSQL;

    If (Not blnCredita) Then
    Begin
      SQL.Clear;
      SQL.Add(' SELECT    ');
      SQL.Add('   *       ');
      SQL.Add(' FROM      ');
      SQL.Add('   MOVFLE  ');
      SQL.Add(' WHERE     ');
      SQL.Add('   FLE_NUMDOC = "' + strNumDoc + '" AND ');
      SQL.Add('   FLE_ESPDOC = "' + strEspDoc + '" AND ');
      SQL.Add('   FLE_CODEMP = "' + strCodEmp + '" AND ');
      SQL.Add('   FLE_CODCLI = "' + strCodCli + '" AND ');
      SQL.Add('   FLE_CODITE = "' + strCodIte + '" AND ');
      SQL.Add('   FLE_SEQDOR = "' + strSeqDor + '" AND ');
      SQL.Add('   IFNULL(FLE_VALLAN,0) = 0             ');
      Open;

      If (Not IsEmpty) then
      Begin
        First;
        While Not Eof Do
        Begin
          fVerificaIntegridade('TMoveFlex.pAtualiza', 'MOVFLE', qryDel, True, False, strMotDel);
          Next;
        End;

        SQL.Clear;
        SQL.Add(' DELETE    ');
        SQL.Add(' FROM      ');
        SQL.Add('   MOVFLE  ');
        SQL.Add(' WHERE     ');
        SQL.Add('   FLE_NUMDOC = "' + strNumDoc + '" AND ');
        SQL.Add('   FLE_ESPDOC = "' + strEspDoc + '" AND ');
        SQL.Add('   FLE_CODEMP = "' + strCodEmp + '" AND ');
        SQL.Add('   FLE_CODCLI = "' + strCodCli + '" AND ');
        SQL.Add('   FLE_CODITE = "' + strCodIte + '" AND ');
        SQL.Add('   FLE_SEQDOR = "' + strSeqDor + '" AND ');
        SQL.Add('   IFNULL(FLE_VALLAN,0) = 0             ');

        ExecSQL;
      End;
    End;
  End;

  FreeAndNil(qryDel);
end;

procedure TMovFlex.pAtualizaPropValor(DataSet: TDataSet);
  Var
    Index: Integer;
    Count: Integer;
    Lista: PPropList;
    Field: Integer;
begin

  pLimpaProperty(Self);

  Count := GetPropList(Self, Lista);

  With DataSet Do
  Begin
    For Field := 0 To Fields.Count -1 Do
    Begin
      If Fields[Field].Value <> Null Then
      Begin
        For Index := 2 To Count -1 Do
        Begin
          If RightStr(UpperCase(String(Lista^[Index].Name)), 6) = RightStr(Fields[Field].FieldName, 6) Then
            SetPropValue(Self, String(Lista^[Index].Name), Fields[Field].Value);
        End;
      End;
    End;
  End;

  FreeMem(Lista);

end;

procedure TMovFlex.pCarrega(strSeqMov: String);
  Var
    intCon: Integer;
begin

  With FQryFle Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSql(strSeqMov));
    Open;

    If Not IsEmpty Then
    Begin
      FCdsFle.Append;

      For intCon := 0 To Fields.Count -1 Do
      Begin
        FCdsFle.FieldByName(Fields[intCon].FieldName).Value := Fields[intCon].Value;
      End;

      FCdsFle.Post;
      pAtualizaPropValor(FCdsFle);
    End;

    Close;
  End;

end;

procedure TMovFlex.pCriaCdsMovFlex;
  Var
    intCont: Integer;
begin
  FCdsFle := TUniClientDataSet.Create(Self);

  FCdsFle.AfterOpen   := pAfterOpen;
  FCdsFle.AfterScroll := pAfterScroll;

  For intCont := 0 To Length(FCampos) -1 Do
  Begin
    With FCdsFle.FieldDefs.AddFieldDef Do
    Begin
      Name        := FCampos[intCont].Nome;
      DataType    := FCampos[intCont].Tipo;

      If FCampos[intCont].Tamanho  > 0 Then Size      := FCampos[intCont].Tamanho;
      If FCampos[intCont].Decimais > 0 Then Precision := FCampos[intCont].Decimais;
    End;
  End;

  FCdsFle.CreateDataSet;
  FDtsFle.DataSet := FCdsFle;
end;

procedure TMovFlex.pAbreQueryCadastro;
begin
  With FQryFle, SQL Do
  Begin
    AfterOpen   := pAfterOpen;
    AfterScroll := pAfterScroll;

    Close;
    Clear;
    Add(fGetSql);
    Open;

    FDtsFle.DataSet := FQryFle;
  End;
end;

procedure TMovFlex.pAfterScroll(DataSet: TDataSet);
begin
  If Not DataSet.Active Then
    Exit;

  If DataSet.State = dsBrowse Then
    pAtualizaPropValor(DataSet);

  If Assigned(pScroll) Then
    pScroll;
end;

procedure TMovFlex.pAfterOpen(DataSet: TDataSet);
  Var
    intCont: Integer;
    fldCampo: TField;
begin
  For intCont := 0 To Length(FCampos) -1 Do
  Begin
    fldCampo := DataSet.FindField(FCampos[intCont].Nome);

    If fldCampo = nil Then
      Continue;

    fldCampo.DisplayLabel := FCampos[intCont].Legenda;

    Case FCampos[intCont].Tipo Of
      ftFloat: Begin
                 TFloatField(fldCampo).EditFormat    := FCampos[intCont].Formato;
                 TFloatField(fldCampo).DisplayFormat := FCampos[intCont].Formato;
               End;
      ftDate : fldCampo.EditMask := FCampos[intCont].Formato;
    End;
  End;
end;

procedure TMovFlex.pAdiciona;
  Var
    intCont: Integer;
begin
  With FCdsFle Do
  Begin
    Append;
    For intCont := 0 To Fields.Count -1 Do
      Fields[intCont].Value := fPropValor(Fields[intCont].FieldName);
    Post;
  End;
end;

procedure TMovFlex.pLimpaRegistros;
begin
  FCdsFle.EmptyDataSet;
  pLimpaProperty(Self);
end;

class procedure TMovFlex.pRestaurarDelMovFle(strNumPed, strEspPed,
  strEmpPed: String; strCodIte, strNumDoc, strEspDoc, strCodEmp, strCodCli, strTabela, strAutInc, strInd_PD, strInc_Pd: String; Var strIncRes: String);
  Var
    qryDor      : TUniQuery;
    qryDel      : TUniQuery;
    objIntMovFle: TMovFlex;
    fltValTmp   : Double;
    strCreDebDoc : String;
begin
  qryDor := fCriaQuery(Nil);
  qryDel := fCriaQuery(Nil);
  objIntMovFle := TMovFlex.Create(Nil);
  Try
    With qryDor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT *    ');
      SQL.Add('   FROM FATDOR  ');
      SQL.Add('  WHERE FDO_NUMDOC = :NUMDOC ');
      SQL.Add('    AND FDO_ESPDOC = :ESPDOC ');
      SQL.Add('    AND FDO_CODEMP = :CODEMP ');
      SQL.Add('    AND FDO_CODITE = :CODITE ');
      SQL.Add('    AND LOCATE(FATDOR.AUTOINCREM, ' + QuotedStr(strIncRes) + ') <= 0 ');
      SQL.Add('    AND FDO_JAFATU = 0 ');
      SQL.Add('    AND FDO_SEQIND = :SEQIND ');
      If Not fEmptyStr(strInc_Pd) Then
       SQL.Add('   AND AUTOINCREM = :AUTINC ');

      ParamByName('NUMDOC').AsString := strNumPed;
      ParamByName('ESPDOC').AsString := strEspPed;
      ParamByName('CODEMP').AsString := strEmpPed;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('SEQIND').AsString := strInd_PD;
      If Not fEmptyStr(strInc_Pd) Then
        ParamByName('AUTINC').AsString := strInc_Pd;
      Open;

      First;
      While Not Eof Do
      Begin
        If (Pos(FieldByName('AUTOINCREM').AsString, strIncRes) > 0) Then
        Begin
          Next;
          Continue;
        End;

        qryDel.Close;
        qryDel.SQL.Clear;
        qryDel.SQL.Add(' SELECT * ');
        qryDel.SQL.Add('   FROM DEL_MOVFLE ');
        qryDel.SQL.Add('  WHERE FLE_NUMDOC = :NUMDOC ');
        qryDel.SQL.Add('    AND FLE_ESPDOC = :ESPDOC ');
        qryDel.SQL.Add('    AND FLE_CODEMP = :CODEMP ');
        qryDel.SQL.Add('    AND FLE_CODITE = :CODITE ');
        qryDel.SQL.Add('    AND FLE_SEQDOR = :AUTINC ');
        qryDel.ParamByName('NUMDOC').AsString := FieldByName('FDO_NUMDOC').AsString;
        qryDel.ParamByName('ESPDOC').AsString := FieldByName('FDO_ESPDOC').AsString;
        qryDel.ParamByName('CODEMP').AsString := FieldByName('FDO_CODEMP').AsString;
        qryDel.ParamByName('CODITE').AsString := FieldByName('FDO_CODITE').AsString;
        qryDel.ParamByName('AUTINC').AsString := FieldByName('AUTOINCREM').AsString;
        qryDel.Open;

        If (Not qryDel.IsEmpty) Then
        Begin
          objIntMovFle.fltValLan := qryDel.FieldByName('FLE_VALLAN').AsFloat;
          objIntMovFle.strCreDeb := qryDel.FieldByName('FLE_CREDEB').AsString;
          objIntMovFle.strNumDoc := qryDel.FieldByName('FLE_NUMDOC').AsString;
          objIntMovFle.dtaDtaLan := qryDel.FieldByName('FLE_DTALAN').AsDateTime;
          objIntMovFle.strCodVen := qryDel.FieldByName('FLE_CODVEN').AsString;
          objIntMovFle.strCodRep := qryDel.FieldByName('FLE_CODREP').AsString;
          objIntMovFle.strCodCli := qryDel.FieldByName('FLE_CODCLI').AsString;
          objIntMovFle.strCodIte := qryDel.FieldByName('FLE_CODITE').AsString;
          objIntMovFle.strCodEmp := qryDel.FieldByName('FLE_CODEMP').AsString;
          objIntMovFle.strNumPok := qryDel.FieldByName('FLE_NUMPOK').AsString;
          objIntMovFle.strEspDoc := qryDel.FieldByName('FLE_ESPDOC').AsString;
          objIntMovFle.strSeqDor := qryDel.FieldByName('FLE_SEQDOR').AsString;
          objIntMovFle.strHistor := qryDel.FieldByName('FLE_HISTOR').AsString;
          objIntMovFle.strOrigem := 'F';
          objIntMovFle.strCodVba := '';
          objIntMovFle.pAdiciona;
          objIntMovFle.fGravar;

          strIncRes := strIncRes + FieldByName('AUTOINCREM').AsString + '_';

          fltValTmp := fRetornaValorFlexDoDocumento(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strAutInc, strCreDebDoc);

          If (fltValTmp <> 0) Then
          Begin
            objIntMovFle.pAtualiza(FieldByName('FDO_NUMDOC').AsString,
                                   FieldByName('FDO_ESPDOC').AsString,
                                   FieldByName('FDO_CODEMP').AsString,
                                   FieldByName('FDO_CODCLI').AsString,
                                   FieldByName('FDO_CODITE').AsString,
                                   fltValTmp,
                                   '',
                                   FieldByName('AUTOINCREM').AsString,
                                   True);
          End;

          qryDel.Delete;
        End
        Else
        Begin
          strIncRes := strIncRes + FieldByName('AUTOINCREM').AsString + '_';
          fltValTmp := fRetornaValorFlexDoDocumento(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strAutInc, strCreDebDoc);

          If (fltValTmp <> 0) Then
          Begin
            objIntMovFle.pAtualiza(FieldByName('FDO_NUMDOC').AsString,
                                   FieldByName('FDO_ESPDOC').AsString,
                                   FieldByName('FDO_CODEMP').AsString,
                                   FieldByName('FDO_CODCLI').AsString,
                                   FieldByName('FDO_CODITE').AsString,
                                   fltValTmp,
                                   '',
                                   FieldByName('AUTOINCREM').AsString,
                                   True);
          End;
        End;

        Next;
      End;

    End;
  Finally
    FreeAndNil(qryDor);
    FreeAndNil(qryDel);
    FreeAndNil(objIntMovFle);
  End;
end;

function TMovFlex.fGetSql(strSeqMov: String = ''): String;
  Var
    intCon: Integer;
begin
  Result := '';
  Result := Result + ' SELECT ';

  For intCon := 0 To Length(FCampos) -1 Do
    Result := Result + FCampos[intCon].Nome + ',';

  Result := Copy(Result, 1, Length(Result) -1);

  Result := Result + ' FROM     ';
  Result := Result + '   MOVFLE ';
  Result := Result + ' WHERE    ';

  If fEmptyStr(strSeqMov) Then
    Result := Result + ' FALSE  '
  Else
    Result := Result + ' FLE_CODSEQ = ' + QuotedStr(strSeqMov);

end;

class procedure TMovFlex.pExcluir(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strAutInc: String; blnGravarDel: Boolean = False; strMotDel: String = '');

  Function fGetSQL(blnDelete: Boolean): String;
  Begin
    Result := '';
    If (blnDelete) Then
    Begin
      Result := Result + ' DELETE ';
      Result := Result + '   FROM MOVFLE  ';
    End
    Else
    Begin
      Result := Result + ' SELECT * ';
      Result := Result + '   FROM MOVFLE  ';
    End;
    Result := Result + ' WHERE FLE_NUMDOC = "' + strNumDoc + '" ';
    Result := Result + '   AND FLE_ESPDOC = "' + strEspDoc + '" ';
    Result := Result + '   AND FLE_CODEMP = "' + strCodEmp + '" ';

    If Not fEmptyStr(strCodCli) Then
      Result := Result + '   AND FLE_CODCLI = "' + strCodCli + '" ';

    If Not fEmptyStr(strCodIte) Then
      Result := Result + ' AND FLE_CODITE = "' + strCodIte + '" ';

    If Not fEmptyStr(strAutInc) Then
      Result := Result + ' AND FLE_SEQDOR = "' + strAutInc + '" ';
  End;

  Var
    qryDel: TUniQuery;
begin
  qryDel := fCriaQuery(Nil);
  Try
    If (blnGravarDel) Then
    Begin
      With qryDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fGetSQL(False));
        Open;
      End;
      fVerificaIntegridade('TMoveFlex.pExcluir', 'MOVFLE', qryDel, True, False, strMotDel);
    End;

    With qryDel Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQL(True));
      ExecSQL;
    End;
  Finally
    FreeAndNil(qryDel);
  End;
end;

class procedure TMovFlex.pExcluir(strCodSeq: String);
  Var
    qryDel: TUniQuery;
begin
  qryDel := fCriaQuery(Nil);

  With qryDel Do
  Begin
    SQL.Add(' DELETE    ');
    SQL.Add(' FROM      ');
    SQL.Add('   MOVFLE  ');
    SQL.Add(' WHERE     ');
    SQL.Add('   FLE_CODSEQ = "' + strCodSeq + '" ');

    ExecSQL;
  End;

  FreeAndNil(qryDel);
end;

class procedure TMovFlex.pExcluirItemDoPedido(strSeqDor: String);
  Var
    qryDel: TUniQuery;
begin
  If fEmptyStr(strSeqDor) Then
    raise Exception.Create('Parâmetro incorreto na chamada do procedimento "pExcluirItemDoPedido"');

  qryDel := fCriaQuery(Nil);

  With qryDel Do
  Begin
    SQL.Add(' DELETE    ');
    SQL.Add(' FROM      ');
    SQL.Add('   MOVFLE  ');
    SQL.Add(' WHERE     ');
    SQL.Add('   FLE_SEQDOR = "' + strSeqDor + '" ');
    ExecSQL;
  End;

  FreeAndNil(qryDel);
end;

procedure TMovFlex.pSetDtaLan(Const Value: TDateTime);
begin
  If Not blnValidarCampos Then
  Begin
    FDtaLan := Value;
    Exit;
  end;

  If Value > 0 Then
    FDtaLan := Value
  Else
    Raise Exception.Create('O Data de lançamento deve ser informada!');
end;

procedure TMovFlex.pSetNumDoc(Const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FNumDoc := Value;
    Exit;
  end;

  If Not fEmptyStr(Value) Then
    FNumDoc := Value
  Else If (Not fPermitirEmBranco) Then
    Raise Exception.Create('O Nº do documento deve ser informado!')
  Else
    FNumDoc := '';
end;

procedure TMovFlex.pSetEspDoc(Const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FEspDoc := Value;
    Exit;
  end;

  If Not fEmptyStr(Value) Then
  Begin
    If fDocumentoExiste(FNumDoc, Value, FCodEmp) Then
      FEspDoc := Value
    Else
      Raise Exception.Create('Documento de vendas informado não existe!');
  End
  Else If (Not fPermitirEmBranco) Then
    Raise Exception.Create('A espécie do documento deve ser informada!')
  Else
    FEspDoc := '';
end;

procedure TMovFlex.pSetCreDeb(Const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FCreDeb := Value;
    Exit;
  end;

  If Pos(Value, 'DC') > 0 Then
    FCreDeb := Value
  Else
    Raise Exception.Create('O Campo deve ser (C)rédito ou (D)ébito!');
end;

procedure TMovFlex.pSetValLan(Const Value: Double);
begin
  If Not blnValidarCampos Then
  Begin
    FValLan := Value;
    Exit;
  end;

  If Value > 0 Then
    FValLan := Value
  Else
    Raise Exception.Create('O valor do lançamento deve ser maior que zero!');
end;

procedure TMovFlex.pSetCodVen(Const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FCodVen := Value;
    Exit;
  end;

  If Not fEmptyStr(Value) Then
  Begin
    If Not fEmptyStr(fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [Value])) Then
      FCodVen := Value
    Else
      Raise Exception.Create('O código do vendedor não existe!');
  End
  Else
    Raise Exception.Create('O código do vendedor deve ser informado!');
end;

procedure TMovFlex.pSetCodCli(Const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FCodCli := Value;
    Exit;
  end;

  If Not fEmptyStr(Value) Then
  Begin
    If Not fEmptyStr(fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [Value])) Then
      FCodCli := Value
    Else
      Raise Exception.Create('O código do cliente não existe!');
  End
  Else If (Not fPermitirEmBranco) Then
    Raise Exception.Create('O código do cliente deve ser informado!')
  Else
    FCodCli := '';
End;

procedure TMovFlex.pSetCodEmp(const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FCodEmp := Value;
    Exit;
  End;

  If Not fEmptyStr(Value) Then
  Begin
    If Not fEmptyStr(fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [Value], False)) Then
      FCodEmp := Value
    Else
      Raise Exception.Create('O código da empresa não existe!');
  End
  Else
    Raise Exception.Create('O código da empresa deve ser informado!');
end;

procedure TMovFlex.pSetCodFor(const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FCodFor := Value;
    Exit;
  end;

  If Not fEmptyStr(Value) Then
  Begin
    If Not fEmptyStr(fCampoTabela('FOR_NOMFOR', 'CADFOR', ['FOR_CODFOR'], [Value])) Then
      FCodFor := Value
    Else
      Raise Exception.Create('O código do fornecedor não existe!');
  End
end;

procedure TMovFlex.pSetCodIte(Const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FCodIte := Value;
    Exit;
  end;

  If Not fEmptyStr(Value) Then
  Begin
    If Not fEmptyStr(fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [Value], False)) Then
      FCodIte := Value
    Else
      Raise Exception.Create('O código do produto não existe!');
  End
  Else If (Not fPermitirEmBranco) Then
    Raise Exception.Create('O código do produto deve ser informado!')
  Else
    FCodIte := '';
end;

procedure TMovFlex.pSetCodRep(const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FCodRep := Value;
    Exit;
  end;

  If Not fEmptyStr(Value) Then
  Begin
    If Not fEmptyStr(fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [Value])) Then
      FCodRep := Value
    Else
      Raise Exception.Create('O código do representante não existe!');
  End
  Else
    Raise Exception.Create('O código do representante deve ser informado!');

end;

function TMovFlex.fCalculaValorFlexCitel(fltPrecoCusto,
                                         fltPrecoVenda,
                                         fltFatorFlexItem,
                                         fltFatorFlexVendedor: Double): Double;
begin
  Result := fltPrecoVenda - ( fltPrecoCusto * fltFatorFlexItem );

  If Result < 0 Then
    Result := 0;

  Result := fFormataFloat(Result * fltFatorFlexVendedor, 2);
end;

function TMovFlex.fDocumentoExiste(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    strSQL: String;
    strTabela: String;
    strAbvTab: String;
    qryGenGer: TUniQuery;
begin
  strTabela := IfThen(Pos(strEspDoc, 'PD_OR_') > 0, 'FATGOR', 'MOVGER');
  strAbvTab := IfThen(Pos(strEspDoc, 'PD_OR_') > 0, 'FGO_', 'GER_');

  Try

    qryGenGer := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  AUTOINCREM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' ' + strTabela + ' ';
    strSQL := strSQL + 'WHERE ';

    If Pos(strEspDoc, 'PD_OR_') <= 0 Then
    Begin
      strSQL := strSQL + '  GER_TIP_FC = "C"     AND ';
      strSQL := strSQL + '  GER_ORIDOC = "V"     AND ';
    End;

    strSQL := strSQL + '  ' + strAbvTab + 'NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  ' + strAbvTab + 'ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  ' + strAbvTab + 'CODEMP = :CODEMP ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result    := Not IsEmpty;
      Close;
    End;

  Finally
    FreeAndNil(qryGenGer);
  End;

end;

procedure TMovFlex.pSetOrigem(const Value: String);
begin
  If Not blnValidarCampos Then
  Begin
    FOrigem := Value;
    Exit;
  end;

  If Pos(Value, 'VF') > 0 Then
    FOrigem := Value
  Else
    Raise Exception.Create('O campo origem deve ser (V)erba ou (F)lex!');
end;

class procedure TMovFlex.pAdicionarVerbaFlex(strNumPok, strNumDoc, strCodVen, strCodSup: String; dtaDtaLan: TDateTime);
  Var
    intCnt : Integer;
    objMovFlex : TMovFlex;
    arrValores : Array[1..3] Of Double;
    arrCreDebi : Array[1..3] Of String;
    arrHistori : Array[1..3] Of String;
    qryPedVba : TUniQuery;
begin
  objMovFlex := TMovFlex.Create(Nil);
  qryPedVba := fGetQueryPedVba(strNumPok);

  qryPedVba.First;
  While Not qryPedVba.Eof Do
  Begin

    arrValores[1] := qryPedVba.FieldByName('VERBADISPONIVEL').AsFloat;
    arrCreDebi[1] := 'C';
    arrHistori[1] := 'CRÉDITO REFERENTE VERBA DISPONÍVEL';

    arrValores[2] := qryPedVba.FieldByName('VERBACONCEDIDA').AsFloat;
    arrCreDebi[2] := 'D';
    arrHistori[2] := 'DÉBITO REFERENTE VERBA CONCEDIDA';

    arrValores[3] := qryPedVba.FieldByName('VERBAITENS').AsFloat;
    arrCreDebi[3] := 'D';
    arrHistori[3] := 'DÉBITO REFERENTE VERBA ITENS';

    For intCnt := Low(arrValores) To High(arrValores) Do
    Begin
      If (fFormataFloat(arrValores[intCnt], 2) <> 0) Then
      Begin
        objMovFlex.strNumDoc := strNumDoc;
        objMovFlex.strEspDoc := 'PD';
        objMovFlex.dtaDtaLan := dtaDtaLan;
        objMovFlex.strCodVen := strCodVen;
        objMovFlex.strCodSup := strCodSup;
        objMovFlex.strCreDeb := arrCreDebi[intCnt];
        objMovFlex.fltValLan := Abs(arrValores[intCnt]);
        //objMovFlex.fltValBon := Abs(arrValores[intCnt]);
        objMovFlex.strHistor := arrHistori[intCnt];
        objMovFlex.strCodIte := '';
        objMovFlex.strOrigem := 'V';
        objMovFlex.strCodEmp := VS_strCodEmp;
        objMovFlex.strNumPok := qryPedVba.FieldByName('NUMEROPEDIDO').AsString;
        objMovFlex.strCodVba := qryPedVba.FieldByName('CODIGOLANCAMENTO').AsString;
        objMovFlex.strCodCli := qryPedVba.FieldByName('CODIGOCLIENTE').AsString;
        objMovFlex.strCodFor := qryPedVba.FieldByName('CODIGOFORNECEDOR').AsString;
//        objMovFlex.strOpeInc := strLoginUsuarioLogado;
//        objMovFlex.dtaDtaInc := VS_Date;
        objMovFlex.pAdiciona;
        objMovFlex.fGravar;
      End;
    End;

    qryPedVba.Next;
  End;

  FreeAndNil(objMovFlex);
  FreeAndNil(qryPedVba);
end;

class function TMovFlex.fGetQueryPedVba(strNumPok: String): TUniQuery;
begin
  Result := fCriaQuery(Nil);
  Result.Close;
  Result.SQL.Clear;
  Result.SQL.Add(' SELECT CODIGOLANCAMENTO, ');
  Result.SQL.Add('        CODIGOFORNECEDOR, ');
  Result.SQL.Add('        CODIGOCLIENTE,    ');
  Result.SQL.Add('        NUMEROPEDIDO,     ');
  Result.SQL.Add('        IFNULL(VERBADISPONIVEL, 0.00) AS VERBADISPONIVEL, ');
  Result.SQL.Add('        IFNULL(VERBACONCEDIDA, 0.00) AS VERBACONCEDIDA, ');
  Result.SQL.Add('        IFNULL(VERBAITENS, 0.00) AS VERBAITENS ');
  Result.SQL.Add('   FROM FSPEDIDOVERBA ');
  Result.SQL.Add('  WHERE NUMEROPEDIDO = :NUMPED ');
  Result.ParamByName('NUMPED').AsString := strNumPok;
  Result.Open;
end;

class function TMovFlex.fExisteDocumento(strNumDoc, strEspDoc, strCodEmp,
  strCodIte: String): Boolean;
  Var
    qryGenGer : TUniQuery;
begin
  qryGenGer := fCriaQuery;
  Try
    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT AUTOINCREM ');
      SQL.Add('   FROM MOVFLE ');
      SQL.Add('  WHERE FLE_NUMDOC = :NUMDOC ');
      SQL.Add('    AND FLE_ESPDOC = :ESPDOC ');
      SQL.Add('    AND FLE_CODEMP = :CODEMP ');
      SQL.Add('    AND FLE_CODITE = :CODITE ');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := (Not IsEmpty);
      Close;
    End;
  Finally
    FreeAndNil(qryGenGer);
  End;
end;

class function TMovFlex.fSaldoFlexDisponivelVendedor(
  strCodVen: String; strNumPed: String = ''; strEmpPed: String = ''): Double;
Var
  qrySaldo : TUniQuery;
begin
  qrySaldo := fCriaQuery;

  try
    if fVerificaExisteFuncaoBanco('fRetornaSaldoFlexProfissional') then
    begin
      qrySaldo.SQL.Text := 'SELECT fRetornaSaldoFlexProfissional(:CODVEN, :NUMPED, :EMPPED) ';
      qrySaldo.ParamByName('CODVEN').AsString := strCodVen;
      qrySaldo.ParamByName('NUMPED').AsString := strNumPed;
      qrySaldo.ParamByName('EMPPED').AsString := strEmpPed;
      qrySaldo.Open;

      Result := qrySaldo.Fields[0].AsFloat;
      Exit;
    end;

    qrySaldo.Close;
    qrySaldo.SQL.Clear;
    qrySaldo.SQL.Add(' SELECT SUM(IF(FLE_CREDEB = "C", FLE_VALLAN, -FLE_VALLAN)) AS SALDO ');
    qrySaldo.SQL.Add('   FROM MOVFLE ');
    qrySaldo.SQL.Add('  WHERE FLE_CODVEN = :CODVEN ');
    qrySaldo.SQL.Add('    AND (FLE_ESPDOC <> "PR" ');
    qrySaldo.SQL.Add('     OR  (FLE_ESPDOC = "PR" ');
    qrySaldo.SQL.Add('    AND   FLE_CREDEB = "D")) ');

    If (Not fEmptyStr(strNumPed)) And
       (Not fEmptyStr(strEmpPed)) Then
    Begin
      qrySaldo.SQL.Add(' AND NOT (FLE_NUMDOC = :NUMDOC AND FLE_ESPDOC = "PD" AND FLE_CODEMP = :CODEMP) ');
      qrySaldo.ParamByName('NUMDOC').AsString := strNumPed;
      qrySaldo.ParamByName('CODEMP').AsString := strEmpPed;
    End;

    qrySaldo.ParamByName('CODVEN').AsString := strCodVen;
    qrySaldo.Open;
    Result := qrySaldo.FieldByName('SALDO').AsFloat;
    qrySaldo.Close;
  finally
    FreeAndNil(qrySaldo);
  end;
end;

end.
