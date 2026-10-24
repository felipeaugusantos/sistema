unit untTransfEmpCarregamento;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, Vcl.Forms, Uni, untFuncFat,
  cxProgressBar, untAuditoriaGravacaoSaldo, untConstantes;

  function fGravaTraCar(strAutoincOri,
                        strAutoincItemOri,
                        strCodEmpOri,
                        strCodEmpCar,
                        strNumDocOri,
                        strEspDocOri: String;
                        dtaDataDocOri: TDate;
                        blnBxSbIt: Boolean): Boolean;
  function fExisteMovGeradoTransfAutomDocVenda(strNumDoc, strEspDoc, strCodCli: String; out strDocs: TArray<String>): Boolean;
  function fExisteDocTransfEmpCarregamento(strNumDoc, strEspDoc, strEntSai: String): Boolean;
  function fRemoveVinculoTransfEmpCarregamento(strNumDoc, strEspDoc, strEntSai: String): Boolean;

const
  SQL_CAPA = 'SELECT DISTINCT MOVGER.* '+
             'FROM TRACAR '+
             'JOIN MOVGER ON MOVGER.AUTOINCREM = CAR_INCORI '+
             'WHERE CAR_INCORI = :AUTOINC '+
             '  AND CAR_EMPORI = :EMPORI '+
             '  AND CAR_EMPCAR = :EMPCAR ';

  SQL_CAMPOS = 'SELECT '+
               'CAR_SEQORI, '+
               'I.ITE_CODITE, '+
               'I.ITE_DESITE, '+
               'I.ITE_CODGRU, '+
               'I.ITE_CODMAR, '+
               'I.ITE_CODUNI, '+
               'I.ITE_CODFOR, '+
               'I.ITE_REFERE, '+
               'G.ITE_PRECUS, '+
               'G.ITE_PREVE1, '+
               'G.ITE_PREMED, '+
               'DET_CODITE, '+
               'DET_CODMAR, '+
               'DET_DESCRI, '+
               'DET_UNIDAD, '+
               'DET_FORITE, '+
               'DET_QTDITE, '+
               'DET_UNITAR, '+
               'DET_UNIORI, '+
               'DET_VLRCON, '+
               'DET_TOTCUS, '+
               'DET_TOTMED, '+
               'DET_DESCON, '+
               'DET_TOTFRE, '+
               'DET_DESESP, '+
               'DET_CODFIS, '+
               'DET_IDEPRO, '+
               'DET_INCPIS, '+
               'DET_ITETIN, '+
               'DET_ITECHA, '+
               'DET_DESCOR, '+
               'DET_TIPEMB, '+
               'DET_QTDEMB, '+
               'DET_PREEMB, '+
               'DET_TIPPRE, '+
               'DET_PRVTIN, '+
               'DET_PRCTIN, '+
               'DET_FATTIN, '+
               'DET_PROEMB, '+
               'DET_ITEEMB, '+
               'DET_LAZQUA, '+
               'DET_PROMOC, '+
               'DET_NUMLOT, '+
               'DET_CODVEN, '+
               'DET_REFERE, '+
               'DET_UNIVIS, '+
               'DET_TAXJUR, '+
               'DET_PESLIQ  ';

  SQL_ITENS = 'FROM TRACAR '+
              'JOIN MOVDET ON MOVDET.AUTOINCREM = CAR_SEQORI '+
              'LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM '+
              'JOIN CADITE I ON I.ITE_CODITE = DET_CODITE '+
              'JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND G.ITE_CODEMP = DET_CODEMP '+
              'WHERE CAR_INCORI = :AUTOINC '+
              '  AND CAR_EMPORI = :EMPORI '+
              '  AND CAR_EMPCAR = :EMPCAR ';

  SQL_SUBITE = 'FROM TRACAR '+
               'JOIN MOVDET ON MOVDET.AUTOINCREM = CAR_SEQORI '+
               'LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM '+
               'JOIN GERMAT ON GMT_CODITE = DET_CODITE '+
               'JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM '+
               'JOIN CADITE I ON I.ITE_CODITE = DMT_ITESUB '+
               'JOIN ITEGER G ON G.ITE_CODITE = DMT_ITESUB AND G.ITE_CODEMP = DET_CODEMP '+
               'WHERE CAR_INCORI = :AUTOINC '+
               '  AND CAR_EMPORI = :EMPORI '+
               '  AND CAR_EMPCAR = :EMPCAR '+
               '  AND ITE_EMPCAR = CAR_EMPCAR ';

type
  TDadosCliente = Record
    strCliNom: String;
    strCliEnd: String;
    strCliBai: String;
    strCliCep: String;
    strCliCid: String;
    strCliEst: String;
    strCliTel: String;
    intCgcCpf: Integer;
    strCliCgc: String;
    strCliIes: String;
  End;

  TMovEmpCar = class(TComponent)
  private
    fatVenda: TFatVenda;
    strEmpOri, strEmpCar, strAutoincOri: String;
    blnBxSbIt: Boolean;
    objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

    function fRetDadosCliente(Const strCodCli: String): TDadosCliente;
    procedure pGeraMovimentos(Const strEmpCar: String; Const blnBxSbIt: Boolean);
    function fGeraMovEmpCarregamento(pgbProgresso: TcxProgressBar): Boolean;
    function fGeraMovEmpSolicitante(pgbProgresso: TcxProgressBar): Boolean;
    procedure pAtualizaTraCarEmpCarregamento(qryMovDet: TUniQuery);
    procedure pAtualizaTraCarEmpSolicitante(Const strNumDoc, strAutInc, strSeqGerDes, strSeqGerOri: String);
    procedure pAtualizaTraCarLogErr(Const strMensagem: String);
    procedure pCarregaItensEmpCarregamento(qryMovDet: TUniQuery; blnPrecoCustoTE: Boolean; pgbProgresso: TcxProgressBar);
    function fGeraMovItensEmpSolicitante(qryMovDet: TUniQuery; strAutInc, strNumDoc, strCodFor, strEstado: String; pgbProgresso: TcxProgressBar): Boolean;
    procedure pProcessaTransferencia(Const strAutoincVenda: String);

    function fEfetivaMovEmpCar: Boolean;
  public
    procedure pProcessaTransferenciasPendentes(Const strEmpOri: String);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  untFuncoesSimples, untGravando, untMovGer, untTypesSistema, untCadIte;

function fGravaTraCar(strAutoincOri,
                      strAutoincItemOri,
                      strCodEmpOri,
                      strCodEmpCar,
                      strNumDocOri,
                      strEspDocOri: String;
                      dtaDataDocOri: TDate;
                      blnBxSbIt: Boolean): Boolean;
  Var
    qryTraCar: TUniQuery;
Begin
  qryTraCar := fCriaQuery(Nil);

  Try
    Try
      qryTraCar.SQL.Add('INSERT INTO TRACAR( ');
      qryTraCar.SQL.Add('  AUTOINCREM, ');
      qryTraCar.SQL.Add('  CAR_INCORI, ');
      qryTraCar.SQL.Add('  CAR_SEQORI, ');
      qryTraCar.SQL.Add('  CAR_EMPORI, ');
      qryTraCar.SQL.Add('  CAR_EMPCAR, ');
      qryTraCar.SQL.Add('  CAR_NUMDOC, ');
      qryTraCar.SQL.Add('  CAR_ESPDOC, ');
      qryTraCar.SQL.Add('  CAR_DTAENT, ');
      qryTraCar.SQL.Add('  CAR_CODOPE, ');
      qryTraCar.SQL.Add('  CAR_BXSBIT, ');
      qryTraCar.SQL.Add('  CAR_DTAINC, ');
      qryTraCar.SQL.Add('  CAR_HORINC) ');
      qryTraCar.SQL.Add('VALUES( ');
      qryTraCar.SQL.Add('  :AUTOIN, ');
      qryTraCar.SQL.Add('  :INCORI, ');
      qryTraCar.SQL.Add('  :SEQORI, ');
      qryTraCar.SQL.Add('  :EMPORI, ');
      qryTraCar.SQL.Add('  :EMPCAR, ');
      qryTraCar.SQL.Add('  :NUMDOC, ');
      qryTraCar.SQL.Add('  :ESPDOC, ');
      qryTraCar.SQL.Add('  :DTAENT, ');
      qryTraCar.SQL.Add('  :CODOPE, ');
      qryTraCar.SQL.Add('  :BXSBIT, ');
      qryTraCar.SQL.Add('  CURRENT_DATE, ');
      qryTraCar.SQL.Add('  CURRENT_TIME) ');

      qryTraCar.ParamByName('AUTOIN').AsString := fRetAutoIncrem('TRACAR', VS_StrCodEmp);
      qryTraCar.ParamByName('INCORI').AsString := strAutoincOri;
      qryTraCar.ParamByName('SEQORI').AsString := strAutoincItemOri;
      qryTraCar.ParamByName('EMPORI').AsString := strCodEmpOri;
      qryTraCar.ParamByName('EMPCAR').AsString := strCodEmpCar;
      qryTraCar.ParamByName('NUMDOC').AsString := strNumDocOri;
      qryTraCar.ParamByName('ESPDOC').AsString := strEspDocOri;
      qryTraCar.ParamByName('DTAENT').AsDate   := dtaDataDocOri;
      qryTraCar.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryTraCar.ParamByName('BXSBIT').AsString := IIF(blnBxSbIt, 'S', 'N');

      qryTraCar.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fGravaTraCar]');
      End;
    End;
  Finally
    FreeAndNil(qryTraCar);
  End;
end;

function fExisteMovGeradoTransfAutomDocVenda(strNumDoc, strEspDoc, strCodCli: String; out strDocs: TArray<String>): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('SELECT DISTINCT');
    qryAux.SQL.Add('  CONCAT(CAR_NMDSAI, "-", CAR_ESDSAI, "-", CAR_EMPCAR) AS SAIDA,');
    qryAux.SQL.Add('  CONCAT(CAR_NMDENT, "-", CAR_ESDENT, "-", CAR_EMPORI) AS ENTRADA');
    qryAux.SQL.Add('FROM TRACAR');
    qryAux.SQL.Add('JOIN MOVGER ON MOVGER.AUTOINCREM = CAR_INCORI');
    qryAux.SQL.Add('WHERE GER_NUMDOC = :NUMDOC');
    qryAux.SQL.Add('  AND GER_ESPDOC = :ESPDOC');
    qryAux.SQL.Add('  AND GER_CODEMP = :CODEMP');
    qryAux.SQL.Add('  AND GER_CODCLI = :CODCLI');
    qryAux.SQL.Add('  AND (CAR_INCSAI IS NOT NULL OR CAR_INCENT IS NOT NULL)');
    qryAux.SQL.Add('ORDER BY CAR_EMPCAR');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

    qryAux.Open;

    Result := Not qryAux.IsEmpty;

    If Result Then
    Begin
      SetLength(strDocs, qryAux.RecordCount +1);

      strDocs[0] := '       Saída        |      Entrada       ';

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        strDocs[qryAux.RecNo] := fStrEspaco(qryAux.FieldByName('SAIDA').AsString, 19) +' | '+
                                 fStrEspaco(qryAux.FieldByName('ENTRADA').AsString, 19);
        qryAux.Next;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fExisteDocTransfEmpCarregamento(strNumDoc, strEspDoc, strEntSai: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('SELECT AUTOINCREM');
    qryAux.SQL.Add('FROM TRACAR');

    If strEntSai = 'E' Then
    Begin
      qryAux.SQL.Add('WHERE CAR_NMDENT = :NUMDOC');
      qryAux.SQL.Add('  AND CAR_ESDENT = :ESPDOC');
      qryAux.SQL.Add('  AND CAR_EMPORI = :CODEMP');
    End
    Else
    Begin
      qryAux.SQL.Add('WHERE CAR_NMDSAI = :NUMDOC');
      qryAux.SQL.Add('  AND CAR_ESDSAI = :ESPDOC');
      qryAux.SQL.Add('  AND CAR_EMPCAR = :CODEMP');
    End;

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.Open;

    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fRemoveVinculoTransfEmpCarregamento(strNumDoc, strEspDoc, strEntSai: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    Try
      qryAux.SQL.Add('UPDATE TRACAR');

      If strEntSai = 'E' Then
      Begin
        qryAux.SQL.Add('SET CAR_NMDENT = NULL,');
        qryAux.SQL.Add('    CAR_ESDENT = NULL,');
        qryAux.SQL.Add('    CAR_INCENT = NULL,');
        qryAux.SQL.Add('    CAR_SEQENT = NULL ');
        qryAux.SQL.Add('WHERE CAR_NMDENT = :NUMDOC');
        qryAux.SQL.Add('  AND CAR_ESDENT = :ESPDOC');
        qryAux.SQL.Add('  AND CAR_EMPORI = :CODEMP');
      End
      Else
      Begin
        qryAux.SQL.Add('SET CAR_NMDSAI = NULL,');
        qryAux.SQL.Add('    CAR_ESDSAI = NULL,');
        qryAux.SQL.Add('    CAR_INCSAI = NULL,');
        qryAux.SQL.Add('    CAR_SEQSAI = NULL ');
        qryAux.SQL.Add('WHERE CAR_NMDSAI = :NUMDOC');
        qryAux.SQL.Add('  AND CAR_ESDSAI = :ESPDOC');
        qryAux.SQL.Add('  AND CAR_EMPCAR = :CODEMP');
      End;

      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fRemoveVinculoTransfEmpCarregamento]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

{ TMovEmpCar }

constructor TMovEmpCar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fatVenda := TFatVenda.CreateInstance('VN', False);
  fatVenda.strOpcDocTrue := 'FD';
  fatVenda.blnGravaMovDet2_3 := False;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
end;

destructor TMovEmpCar.Destroy;
begin
  fatVenda.Free;
  inherited;
end;

function TMovEmpCar.fEfetivaMovEmpCar: Boolean;
begin
  //grava MOVGER
  Result := fatVenda.fGMovGer;

  If Result Then
    objAuditoriaSaldo.Adicionar(fatVenda.strAutInc, 'MOVGER');

  If Not Result Then
  Begin
    fRollBack;
    pAtualizaTraCarLogErr('não gravou MOVGER [fEfetivaMovEmpCar]' +
      IIF(Not fEmptyStr(fatVenda.strMsgCancelamento), '. Erro: '+ fatVenda.strMsgCancelamento, ''));
    Exit;
  End;

  //grava MOVDET
  Result := fatVenda.fGMovDet;

  If Not Result Then
  Begin
    fRollBack;
    pAtualizaTraCarLogErr('não gravou MOVDET [fEfetivaMovEmpCar]');
    Exit;
  End;
end;

function TMovEmpCar.fGeraMovEmpCarregamento(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryMovGer, qryMovDet: TUniQuery;
    blnPrecoCustoTE: Boolean;
    recDadosCliente: TDadosCliente;
    fltTotPro, fltTotCus, fltTotMed: Double;
    intIndex: Integer;
    strCodErrosAuditoria: String;
begin
  qryMovGer := fCriaQuery;
  qryMovDet := fCriaQuery;

  Try
    pSetaEmpresaLogada(Self.strEmpCar);

    Try
      qryMovGer.SQL.Add( SQL_CAPA );
      qryMovGer.SQL.Add('AND CAR_INCSAI IS NULL');
      qryMovGer.ParamByName('AUTOINC').AsString := Self.strAutoincOri;
      qryMovGer.ParamByName('EMPORI').AsString  := Self.strEmpOri;
      qryMovGer.ParamByName('EMPCAR').AsString  := Self.strEmpCar;
      qryMovGer.Open;

      If qryMovGer.IsEmpty Then
        Exit(True);

      If Self.blnBxSbIt Then
      Begin
        qryMovDet.SQL.Add( SQL_CAMPOS );
        qryMovDet.SQL.Add(',(DET_QTDITE * DMT_QTDITE) AS SUB_QTDITE');
        qryMovDet.SQL.Add(',(SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_CODITE = DMT_ITESUB ');
        qryMovDet.SQL.Add('  AND LOT_CODEMP = CAR_EMPCAR AND LOT_PRIPRO = "S") AS SUB_NUMLOT');
        qryMovDet.SQL.Add( SQL_SUBITE );
      End
      Else
      Begin
        qryMovDet.SQL.Add( SQL_CAMPOS );
        qryMovDet.SQL.Add( SQL_ITENS );
      End;
      qryMovDet.SQL.Add('AND CAR_INCSAI IS NULL');
      qryMovDet.ParamByName('AUTOINC').AsString := Self.strAutoincOri;
      qryMovDet.ParamByName('EMPORI').AsString  := Self.strEmpOri;
      qryMovDet.ParamByName('EMPCAR').AsString  := Self.strEmpCar;
      qryMovDet.Open;

      If qryMovDet.IsEmpty Then
        Exit(True);

      pProgresso(0, qryMovDet.RecordCount, pgbProgresso);

      objAuditoriaSaldo.Limpar;

      fStartTransaction;

      FillChar(recDadosCliente, SizeOf(recDadosCliente), #0);

      fltTotPro := 0;
      fltTotCus := 0;
      fltTotMed := 0;

      qryMovDet.First;
      While Not qryMovDet.Eof Do
      Begin
        If Self.blnBxSbIt Then
        Begin
          fltTotPro := fltTotPro + (qryMovDet.FieldByName('SUB_QTDITE').AsFloat * qryMovDet.FieldByName('ITE_PREVE1').AsFloat);
          fltTotCus := fltTotCus + (qryMovDet.FieldByName('SUB_QTDITE').AsFloat * qryMovDet.FieldByName('ITE_PRECUS').AsFloat);
          fltTotMed := fltTotMed + (qryMovDet.FieldByName('SUB_QTDITE').AsFloat * qryMovDet.FieldByName('ITE_PREMED').AsFloat);
        End
        Else
        Begin
          fltTotPro := fltTotPro + qryMovDet.FieldByName('DET_VLRCON').AsFloat;
          fltTotCus := fltTotCus + qryMovDet.FieldByName('DET_TOTCUS').AsFloat;
          fltTotMed := fltTotMed + qryMovDet.FieldByName('DET_TOTMED').AsFloat;
        End;

        qryMovDet.Next;
      End;

      fatVenda.blnTemTinta := False;
      fatVenda.strEmp_TE   := Self.strEmpCar;
      fatVenda.strCodEmpTe := Self.strEmpOri;
      fatVenda.strNumDoc := fRetSequencial_TE;
      fatVenda.strEspDoc := 'TE';
      fatVenda.strCodVen := qryMovGer.FieldByName('GER_CODVEN').AsString;
      fatVenda.strCodTra := qryMovGer.FieldByName('GER_CODTRA').AsString;
      fatVenda.strCodCli := fRetornaClienteFilial(Self.strEmpOri, 'C');
      fatVenda.dtaDtaEnt := qryMovGer.FieldByName('GER_DTAENT').AsDateTime;
      fatVenda.strConPag := '01000';
      fatVenda.strCliEst := qryMovGer.FieldByName('GER_ESTADO').AsString;
      fatVenda.strEntFat := fCfgSis('SUG_TE', varString);

      recDadosCliente := fRetDadosCliente(fatVenda.strCodCli);
      blnPrecoCustoTE := (fGetTEPREV(VS_strCodEmp, fatVenda.strCodCli) = 'CUS');

      fatVenda.strCliNom := recDadosCliente.strCliNom;
      fatVenda.strCliEnd := recDadosCliente.strCliEnd;
      fatVenda.strCliBai := recDadosCliente.strCliBai;
      fatVenda.strCliCep := recDadosCliente.strCliCep;
      fatVenda.strCliCid := recDadosCliente.strCliCid;
      fatVenda.strCliEst := recDadosCliente.strCliEst;
      fatVenda.strCliTel := recDadosCliente.strCliTel;
      fatVenda.intCgcCpf := recDadosCliente.intCgcCpf;
      fatVenda.strCliCgc := recDadosCliente.strCliCgc;
      fatVenda.strCliIes := recDadosCliente.strCliIes;

      fatVenda.fltDesEsp := qryMovGer.FieldByName('GER_DESESP').AsFloat;
      fatVenda.fltTotGer := fltTotPro; //é recalculado no pCalculaTotGer abaixo
      fatVenda.fltTotPro := fltTotPro;
      fatVenda.fltTotCus := fltTotCus;
      fatVenda.fltTotMed := fltTotMed;
      fatVenda.strTipFre := qryMovGer.FieldByName('GER_TIPFRE').AsString;
      fatVenda.fltValFre := qryMovGer.FieldByName('GER_TOTFRE').AsFloat;
      fatVenda.fltPesBru := qryMovGer.FieldByName('GER_PESBRU').AsFloat;
      fatVenda.fltPesLiq := qryMovGer.FieldByName('GER_PESLIQ').AsFloat;
      fatVenda.intQtdTra := qryMovGer.FieldByName('GER_VOLUME').AsInteger;
      fatVenda.strEspTra := qryMovGer.FieldByName('GER_ESPECI').AsString;
      fatVenda.strMarTra := qryMovGer.FieldByName('GER_MARCA_').AsString;
      fatVenda.strMen001 := qryMovGer.FieldByName('GER_MEN001').AsString;
      fatVenda.strMen002 := qryMovGer.FieldByName('GER_MEN002').AsString;
      fatVenda.strCodDig := qryMovGer.FieldByName('GER_CODDIG').AsString;
      fatVenda.fltPorDes := qryMovGer.FieldByName('GER_PORDES').AsFloat;
      fatVenda.strCli_Rg := qryMovGer.FieldByName('GER_R_GCON').AsString;
      fatVenda.strCodCnd := qryMovGer.FieldByName('GER_CODCND').AsString;
      fatVenda.strCodFpg := qryMovGer.FieldByName('GER_CODFPG').AsString;
      fatVenda.strCodS01 := qryMovGer.FieldByName('GER_CODS01').AsString;
      fatVenda.strCodS02 := qryMovGer.FieldByName('GER_CODS02').AsString;
      fatVenda.strCodS03 := qryMovGer.FieldByName('GER_CODS03').AsString;
      fatVenda.strCodS04 := qryMovGer.FieldByName('GER_CODS04').AsString;
      fatVenda.strCodS05 := qryMovGer.FieldByName('GER_CODS05').AsString;
      fatVenda.strCodS06 := qryMovGer.FieldByName('GER_CODS06').AsString;
      fatVenda.strDesS01 := qryMovGer.FieldByName('GER_DESS01').AsString;
      fatVenda.strDesS02 := qryMovGer.FieldByName('GER_DESS02').AsString;
      fatVenda.strDesS03 := qryMovGer.FieldByName('GER_DESS03').AsString;
      fatVenda.strDesS04 := qryMovGer.FieldByName('GER_DESS04').AsString;
      fatVenda.strDesS05 := qryMovGer.FieldByName('GER_DESS05').AsString;
      fatVenda.strDesS06 := qryMovGer.FieldByName('GER_DESS06').AsString;
      fatVenda.fltValS01 := qryMovGer.FieldByName('GER_VALS01').AsFloat;
      fatVenda.fltValS02 := qryMovGer.FieldByName('GER_VALS02').AsFloat;
      fatVenda.fltValS03 := qryMovGer.FieldByName('GER_VALS03').AsFloat;
      fatVenda.fltValS04 := qryMovGer.FieldByName('GER_VALS04').AsFloat;
      fatVenda.fltValS05 := qryMovGer.FieldByName('GER_VALS05').AsFloat;
      fatVenda.fltValS06 := qryMovGer.FieldByName('GER_VALS06').AsFloat;
      fatVenda.intPraEnt := qryMovGer.FieldByName('GER_PRAENT').AsInteger;
      fatVenda.fltTotSer := qryMovGer.FieldByName('GER_TOTSER').AsFloat;
      fatVenda.fltBasIss := qryMovGer.FieldByName('GER_TOTSER').AsFloat;
      fatVenda.fltPerIss := qryMovGer.FieldByName('GER_PERISS').AsFloat;
      fatVenda.fltValIss := qryMovGer.FieldByName('GER_VALISS').AsFloat;
      fatVenda.strDesCla := qryMovGer.FieldByName('GER_NATOPE').AsString;
      fatVenda.strClaFis := '5999';
      fatVenda.strTabPre := '1';

      If blnPrecoCustoTE Then
      Begin
        fatVenda.fltTotPro := fltTotCus;
        fatVenda.fltTotGer := fltTotCus;
        fatVenda.fltDesEsp := 0;
        fatVenda.fltValFre := 0;
      End;

      pCarregaItensEmpCarregamento(qryMovDet, blnPrecoCustoTE, pgbProgresso);

      fatVenda.pCalculaPesBruLiq;
      fatVenda.pCalculaTotGer(False, False);
      fatVenda.pCalculaTotGer;

      For intIndex := Low(fatVenda.arrMatItens) To High(fatVenda.arrMatItens) Do
        fatVenda.arrMatItens[intIndex].fltVlrCon := fatVenda.arrMatItens[intIndex].fltTotIte -
                                                    fatVenda.arrMatItens[intIndex].fltDesEsp +
                                                    fatVenda.arrMatItens[intIndex].fltValFre +
                                                    fatVenda.arrMatItens[intIndex].fltDesAce +
                                                    fatVenda.arrMatItens[intIndex].fltValIpi +
                                                    fatVenda.arrMatItens[intIndex].fltValRet +
                                                    fatVenda.arrMatItens[intIndex].fltValCBS +
                                                    fatVenda.arrMatItens[intIndex].fltValIBS +
                                                    fatVenda.arrMatItens[intIndex].fltVal_IS;

      //grava MOVGER e MOVDET
      Result := fEfetivaMovEmpCar;

      //atualiza a TRACAR com os dados do movimento gerado
      If Result Then
        pAtualizaTraCarEmpCarregamento(qryMovDet);

      If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;

      If Result Then
        fCommit
      Else
        fRollback;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[fGeraMovEmpCarregamento]');
      End;
    End;
  Finally
    pSetaEmpresaLogada(Self.strEmpOri);

    FreeAndNil(qryMovGer);
    FreeAndNil(qryMovDet);
  End;
end;

function TMovEmpCar.fGeraMovEmpSolicitante(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryMovGer, qryMovDet: TUniQuery;
    strCodFor, strNumDoc, strEspDoc, strAutInc: String;
    recServicos: TDadosServicos;
    arrDuplic: TarrDuplicata;
    fltTotPro, fltTotCus, fltTotMed: Double;
    strCodErrosAuditoria: String;
begin
  qryMovGer := fCriaQuery;
  qryMovDet := fCriaQuery;

  FillChar(recServicos, SizeOf(recServicos), #0);
  FillChar(arrDuplic, SizeOf(arrDuplic), #0);

  Try
    Try
      qryMovGer.SQL.Add( SQL_CAPA );
      qryMovGer.SQL.Add('AND CAR_INCENT IS NULL');
      qryMovGer.ParamByName('AUTOINC').AsString := Self.strAutoincOri;
      qryMovGer.ParamByName('EMPORI').AsString  := Self.strEmpOri;
      qryMovGer.ParamByName('EMPCAR').AsString  := Self.strEmpCar;
      qryMovGer.Open;

      If qryMovGer.IsEmpty Then
        Exit(True);

      If Self.blnBxSbIt Then
      Begin
        qryMovDet.SQL.Add( SQL_CAMPOS );
        qryMovDet.SQL.Add(',(DET_QTDITE * DMT_QTDITE) AS SUB_QTDITE');
        qryMovDet.SQL.Add(',(SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_CODITE = DMT_ITESUB ');
        qryMovDet.SQL.Add('  AND LOT_CODEMP = CAR_EMPCAR AND LOT_PRIPRO = "S") AS SUB_NUMLOT');
        qryMovDet.SQL.Add( SQL_SUBITE );
      End
      Else
      Begin
        qryMovDet.SQL.Add( SQL_CAMPOS );
        qryMovDet.SQL.Add( SQL_ITENS );
      End;
      qryMovDet.SQL.Add('AND CAR_INCENT IS NULL');
      qryMovDet.ParamByName('AUTOINC').AsString := Self.strAutoincOri;
      qryMovDet.ParamByName('EMPORI').AsString  := Self.strEmpOri;
      qryMovDet.ParamByName('EMPCAR').AsString  := Self.strEmpCar;
      qryMovDet.Open;

      If qryMovDet.IsEmpty Then
        Exit(True);

      pProgresso(0, qryMovDet.RecordCount, pgbProgresso);

      fltTotPro := 0;
      fltTotCus := 0;
      fltTotMed := 0;

      qryMovDet.First;
      While Not qryMovDet.Eof Do
      Begin
        If Self.blnBxSbIt Then
        Begin
          fltTotPro := fltTotPro + (qryMovDet.FieldByName('SUB_QTDITE').AsFloat * qryMovDet.FieldByName('ITE_PREVE1').AsFloat);
          fltTotCus := fltTotCus + (qryMovDet.FieldByName('SUB_QTDITE').AsFloat * qryMovDet.FieldByName('ITE_PRECUS').AsFloat);
          fltTotMed := fltTotMed + (qryMovDet.FieldByName('SUB_QTDITE').AsFloat * qryMovDet.FieldByName('ITE_PREMED').AsFloat);
        End
        Else
        Begin
          fltTotPro := fltTotPro + qryMovDet.FieldByName('DET_VLRCON').AsFloat;
          fltTotCus := fltTotCus + qryMovDet.FieldByName('DET_TOTCUS').AsFloat;
          fltTotMed := fltTotMed + qryMovDet.FieldByName('DET_TOTMED').AsFloat;
        End;

        qryMovDet.Next;
      End;

      strCodFor := fRetornaClienteFilial(Self.strEmpCar, 'F');
      strNumDoc := fAtualizaProCod('ENTGER', 'GER_NUMDOC', 'MOVGER', 1, Nil,
        function (const AValue : String) : String
        begin
          Result := 'E' + RightStr(AValue, fTamDocCadRec - 1);
        end
      );
      strEspDoc := 'PD';

      If fDocumentoFiscalJaExiste(strNumDoc, strEspDoc, VS_strCodEmp, 'F', '', '') Then
      Begin
        pAtualizaTraCarLogErr('não gravou MOVGER [fGeraMovEmpSolicitante]. Erro: O documento: '+ strNumDoc +'-'+ strEspDoc +'-'+ VS_strCodEmp +' já existe!');
        Exit(False);
      End;

      objAuditoriaSaldo.Limpar;

      fStartTransaction;

      Result := fGravaMovGer(strAutInc,
                             strNumDoc,
                             strEspDoc,
                             VS_strCodEmp,
                             '',
                             qryMovGer.FieldByName('GER_CODVEN').AsString,
                             strCodFor,
                             '',
                             'F',
                             VS_Date,
                             fTime(),
                             VS_Date,
                             '01000',
                             qryMovGer.FieldByName('GER_ESTADO').AsString,
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
                             0.0,
                             fltTotPro,
                             fltTotPro,
                             fltTotCus,
                             fltTotMed,
                             '2',
                             0.0,
                             0.0,
                             0.0,
                             0,
                             '',
                             '',
                             'TRANSF. AUTOM. REF. ' + qryMovGer.FieldByName('GER_NUMDOC').AsString + '-' + qryMovGer.FieldByName('GER_ESPDOC').AsString,
                             '',
                             '',
                             '',
                             '',
                             False,
                             '',
                             '',
                             '',  // Empresa do Faturamento
                             0,
                             '',
                             '',
                             False,
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
                             0.0,
                             arrDuplic,
                             '',
                             'N',
                             '1101',
                             '',
                             '',
                             '',
                             0.0,
                             '',
                             '',
                             '',
                             0.0,
                             recServicos,
                             0.0,
                             '',   // GER_ORIDOC DEVE SER NULL
                             'N',
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
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
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
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             0.0,
                             '',
                             0.0,
                             0.0,
                             0,
                             '',
                             'N',
                             '',
                             '',
                             '',
                             '1', //strTabPre
                             '',
                             '',
                             False,
                             0.0,
                             0.0,
                             0.0,
                             'N',
                             '',
                             VS_Date,
                             '',
                             'N',
                             '',
                             '',
                             '',
                             '',
                             '',
                             True);

      If Result Then
        objAuditoriaSaldo.Adicionar(strAutInc, 'MOVGER');

      If Not Result Then
      Begin
        fRollBack;
        pAtualizaTraCarLogErr('não gravou MOVGER [fGeraMovEmpSolicitante]');
        Exit;
      End;

      Result := fGeraMovItensEmpSolicitante(qryMovDet, strAutInc, strNumDoc, strCodFor, qryMovGer.FieldByName('GER_ESTADO').AsString, pgbProgresso);

      If Result And (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;

      If Result Then
        fCommit
      Else
      Begin
        fRollBack;
        pAtualizaTraCarLogErr('não gravou MOVDET [fGeraMovEmpSolicitante]');
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '[fGeraMovEmpSolicitante]');
      End;
    End;
  Finally
    FreeAndNil(qryMovGer);
    FreeAndNil(qryMovDet);
  End;
end;

function TMovEmpCar.fGeraMovItensEmpSolicitante(qryMovDet: TUniQuery; strAutInc, strNumDoc, strCodFor, strEstado: String; pgbProgresso: TcxProgressBar): Boolean;
  Var
    strAutincItem: String;
    fltQtdIte: Double;
    strNumLot: String;
begin
  Result := False;
  qryMovDet.First;
  While Not qryMovDet.Eof Do
  Begin
    strAutincItem := '';

    If Self.blnBxSbIt Then
    Begin
      fltQtdIte := qryMovDet.FieldByName('SUB_QTDITE').AsFloat;
      strNumLot := qryMovDet.FieldByName('SUB_NUMLOT').AsString;
    End
    Else
    Begin
      fltQtdIte := qryMovDet.FieldByName('DET_QTDITE').AsFloat;
      strNumLot := qryMovDet.FieldByName('DET_NUMLOT').AsString;
    End;

    Result := fGravaMovDet(strAutincItem,
                           strAutInc,
                           strNumDoc,
                           'PD',
                           VS_strCodEmp,
                           qryMovDet.FieldByName('ITE_CODITE').AsString,
                           qryMovDet.FieldByName('DET_CODVEN').AsString,
                           '',
                           IIF(Self.blnBxSbIt, qryMovDet.FieldByName('ITE_CODMAR').AsString, qryMovDet.FieldByName('DET_CODMAR').AsString),
                           strCodFor,
                           '',
                           VS_Date,
                           fTime(),
                           VS_Date,
                           '01000',
                           'F',
                           strEstado,
                           IIF(Self.blnBxSbIt, qryMovDet.FieldByName('ITE_DESITE').AsString, qryMovDet.FieldByName('DET_DESCRI').AsString),
                           IIF(Self.blnBxSbIt, qryMovDet.FieldByName('ITE_REFERE').AsString, qryMovDet.FieldByName('DET_REFERE').AsString),
                           IIF(Self.blnBxSbIt, qryMovDet.FieldByName('ITE_CODUNI').AsString, qryMovDet.FieldByName('DET_UNIDAD').AsString),
                           IIF(Self.blnBxSbIt, qryMovDet.FieldByName('ITE_CODFOR').AsString, qryMovDet.FieldByName('DET_FORITE').AsString),
                           fltQtdIte,
                           IIF(Self.blnBxSbIt, qryMovDet.FieldByName('ITE_PREVE1').AsFloat, qryMovDet.FieldByName('DET_UNITAR').AsFloat),
                           IIF(Self.blnBxSbIt, qryMovDet.FieldByName('ITE_PREVE1').AsFloat, qryMovDet.FieldByName('DET_UNIORI').AsFloat),
                           IIF(Self.blnBxSbIt, qryMovDet.FieldByName('ITE_PREVE1').AsFloat, qryMovDet.FieldByName('DET_UNIVIS').AsFloat),
                           IIF(Self.blnBxSbIt, fltQtdIte * qryMovDet.FieldByName('ITE_PREVE1').AsFloat, qryMovDet.FieldByName('DET_VLRCON').AsFloat),
                           IIF(Self.blnBxSbIt, fltQtdIte * qryMovDet.FieldByName('ITE_PREVE1').AsFloat, qryMovDet.FieldByName('DET_VLRCON').AsFloat),
                           IIF(Self.blnBxSbIt, fltQtdIte * qryMovDet.FieldByName('ITE_PRECUS').AsFloat, qryMovDet.FieldByName('DET_TOTCUS').AsFloat),
                           IIF(Self.blnBxSbIt, fltQtdIte * qryMovDet.FieldByName('ITE_PREMED').AsFloat, qryMovDet.FieldByName('DET_TOTMED').AsFloat),
                           0.0,
                           0.0,
                           0.0,
                           '',
                           '',
                           0.0,
                           0.0,
                           0.0,
                           '1101',
                           qryMovDet.FieldByName('DET_CODFIS').AsString,
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
                           False,
                           '',
                           '',
                           '',  // Empresa do Faturamento
                           0,
                           '',
                           '',
                           0.0,
                           'NOR',
                           qryMovDet.FieldByName('DET_INCPIS').AsString,
                           '',
                           0.0,
                           'N',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           '',
                           0.0,
                           0.0,
                           '',
                           0.0,
                           0.0,
                           0,
                           qryMovDet.FieldByName('DET_PROEMB').AsString,
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           'N',
                           '',
                           0.0,
                           '',
                           '',
                           '',
                           '',
                           '',
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0.0,
                           '',
                           '',
                           False,
                           False,
                           '',
                           '',
                           '',
                           '1', //strTabPre
                           '',
                           '',
                           '',
                           '',
                           0.0,
                           '',
                           0.0,
                           0.0,
                           0,
                           'N',
                           '',
                           0,
                           0,
                           0,
                           0,
                           '',
                           strNumLot,
                           'N',
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           0,
                           '',
                           0,
                           0,
                           0,
                           '',
                           '',
                           '',
                           0,
                           0,
                           0,
                           0);

    If Not Result Then
      Exit;

    Result := fAtualizaEstoqueCadIte(qryMovDet.FieldByName('ITE_CODITE').AsString,
                                     'E',
                                     fltQtdIte,
                                     0.0,
                                     strNumLot);

    If Result Then
      pAtualizaTraCarEmpSolicitante(strNumDoc, strAutInc, strAutincItem, qryMovDet.FieldByName('CAR_SEQORI').AsString);

    pProgresso(qryMovDet.RecNo, qryMovDet.RecordCount, pgbProgresso);

    qryMovDet.Next;
  End;
end;

function TMovEmpCar.fRetDadosCliente(const strCodCli: String): TDadosCliente;
  Var
    qryCadCli: TUniQuery;
begin
  qryCadCli := fCriaQuery;
  Try
    qryCadCli.SQL.Add('SELECT CLI_NOMCLI, ');
    qryCadCli.SQL.Add('  CLI_ENDERE, ');
    qryCadCli.SQL.Add('  CLI_BAIRRO, ');
    qryCadCli.SQL.Add('  CLI_C_E_P_, ');
    qryCadCli.SQL.Add('  CLI_CODCID, ');
    qryCadCli.SQL.Add('  CID_ESTADO, ');
    qryCadCli.SQL.Add('  CLI_FONE01, ');
    qryCadCli.SQL.Add('  CLI_CGCCPF, ');
    qryCadCli.SQL.Add('  CLI_C_G_C_, ');
    qryCadCli.SQL.Add('  CLI_I_E_S_  ');
    qryCadCli.SQL.Add('FROM CADCLI ');
    qryCadCli.SQL.Add('JOIN CADCID ON (CADCID.CID_CODCID = CADCLI.CLI_CODCID) ');
    qryCadCli.SQL.Add('WHERE CLI_CODCLI = :CODCLI ');

    qryCadCli.ParamByName('CODCLI').AsString := strCodCli;
    qryCadCli.Open;

    Result.strCliNom := qryCadCli.FieldByName('CLI_NOMCLI').AsString;
    Result.strCliEnd := qryCadCli.FieldByName('CLI_ENDERE').AsString;
    Result.strCliBai := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
    Result.strCliCep := qryCadCli.FieldByName('CLI_C_E_P_').AsString;
    Result.strCliCid := qryCadCli.FieldByName('CLI_CODCID').AsString;
    Result.strCliEst := qryCadCli.FieldByName('CID_ESTADO').AsString;
    Result.strCliTel := qryCadCli.FieldByName('CLI_FONE01').AsString;
    Result.intCgcCpf := qryCadCli.FieldByName('CLI_CGCCPF').AsInteger;
    Result.strCliCgc := qryCadCli.FieldByName('CLI_C_G_C_').AsString;
    Result.strCliIes := qryCadCli.FieldByName('CLI_I_E_S_').AsString;
  Finally
    FreeAndNil(qryCadCli);
  End;
end;

procedure TMovEmpCar.pProcessaTransferenciasPendentes(Const strEmpOri: String);
  Var
    qryTraCar: TUniQuery;
begin
  If (Not fCfgSis('EMPCAR', varBoolean)) Then
    Exit;

  If Not fLock_Unlock('TRANSFEMPCAR_'+ strEmpOri, True, True, True, '', False) Then
    Exit;

  Self.strEmpOri := strEmpOri;

  Try
    qryTraCar := fCriaQuery;

    qryTraCar.SQL.Add('SELECT DISTINCT CAR_INCORI');
    qryTraCar.SQL.Add('FROM TRACAR');
    qryTraCar.SQL.Add('WHERE CAR_EMPORI = :EMPORI');
    qryTraCar.SQL.Add('  AND CAR_TENTAT < 3');
    qryTraCar.SQL.Add('  AND (CAR_INCSAI IS NULL OR CAR_INCENT IS NULL)');
    qryTraCar.SQL.Add('ORDER BY CAR_DTAINC, CAR_HORINC ');

    qryTraCar.ParamByName('EMPORI').AsString  := strEmpOri;
    qryTraCar.Open;

    //processa as transferências pendentes na empresa solicitante
    qryTraCar.First;
    While Not qryTraCar.Eof Do
    Begin
      pProcessaTransferencia(qryTraCar.FieldByName('CAR_INCORI').AsString);

      qryTraCar.Next;
    End;
  Finally
    FreeAndNil(qryTraCar);
    fLock_Unlock('TRANSFEMPCAR_'+ strEmpOri, False, True, True, '', False);
  End;
end;

procedure TMovEmpCar.pProcessaTransferencia(Const strAutoincVenda: String);
  Var
    qryEmpCar: TUniQuery;
begin
  Self.strAutoincOri := strAutoincVenda;

  Try
    qryEmpCar := fCriaQuery;

    qryEmpCar.SQL.Add('SELECT DISTINCT CAR_EMPCAR, CAR_BXSBIT');
    qryEmpCar.SQL.Add('FROM TRACAR');
    qryEmpCar.SQL.Add('WHERE CAR_INCORI = :AUTOINC');
    qryEmpCar.SQL.Add('  AND CAR_EMPORI = :EMPORI');
    qryEmpCar.SQL.Add('  AND (CAR_INCSAI IS NULL OR CAR_INCENT IS NULL)');
    qryEmpCar.SQL.Add('ORDER BY CAR_EMPCAR');

    qryEmpCar.ParamByName('AUTOINC').AsString := strAutoincVenda;
    qryEmpCar.ParamByName('EMPORI').AsString  := Self.strEmpOri;
    qryEmpCar.Open;

    //gera um TE e um PD para cada empresa de carregamento informada nos itens da venda
    qryEmpCar.First;
    While Not qryEmpCar.Eof Do
    Begin
      pGeraMovimentos(qryEmpCar.FieldByName('CAR_EMPCAR').AsString,
                      qryEmpCar.FieldByName('CAR_BXSBIT').AsString = 'S');

      qryEmpCar.Next;
    End;
  Finally
    FreeAndNil(qryEmpCar);
  End;
end;

procedure TMovEmpCar.pAtualizaTraCarEmpCarregamento(qryMovDet: TUniQuery);
  Var
    qryTraCar: TUniQuery;
begin
  qryTraCar := fCriaQuery;
  Try
    qryTraCar.SQL.Add('UPDATE TRACAR');
    qryTraCar.SQL.Add('SET CAR_NMDSAI = :NUMDOC,');
    qryTraCar.SQL.Add('    CAR_ESDSAI = :ESPDOC,');
    qryTraCar.SQL.Add('    CAR_INCSAI = :AUTOIN_DES,');
    qryTraCar.SQL.Add('    CAR_SEQSAI = :SEQGER_DES,');
    qryTraCar.SQL.Add('    CAR_OPEGER = :CODOPE,');
    qryTraCar.SQL.Add('    CAR_DTAGER = CURRENT_DATE,');
    qryTraCar.SQL.Add('    CAR_HORGER = CURRENT_TIME');
    qryTraCar.SQL.Add('WHERE CAR_INCORI = :AUTOIN_ORI');
    qryTraCar.SQL.Add('  AND CAR_SEQORI = :SEQGER_ORI');
    qryTraCar.SQL.Add('  AND CAR_EMPORI = :EMPORI');
    qryTraCar.SQL.Add('  AND CAR_EMPCAR = :EMPCAR');
    qryTraCar.SQL.Add('  AND CAR_INCSAI IS NULL');

    qryMovDet.First;
    While Not qryMovDet.Eof Do
    Begin
      qryTraCar.Close;
      qryTraCar.ParamByName('NUMDOC').AsString     := fatVenda.strNumDoc;
      qryTraCar.ParamByName('ESPDOC').AsString     := fatVenda.strEspDoc;
      qryTraCar.ParamByName('AUTOIN_DES').AsString := fatVenda.strAutInc;
      qryTraCar.ParamByName('SEQGER_DES').AsString := fatVenda.arrMatItens[qryMovDet.RecNo -1].strAutIncDet;
      qryTraCar.ParamByName('CODOPE').AsString     := strLoginUsuarioLogado;
      qryTraCar.ParamByName('AUTOIN_ORI').AsString := Self.strAutoincOri;
      qryTraCar.ParamByName('SEQGER_ORI').AsString := qryMovDet.FieldByName('CAR_SEQORI').AsString;
      qryTraCar.ParamByName('EMPORI').AsString     := Self.strEmpOri;
      qryTraCar.ParamByName('EMPCAR').AsString     := Self.strEmpCar;
      qryTraCar.ExecSQL;

      qryMovDet.Next;
    End;
  Finally
    FreeAndNil(qryTraCar);
  End;
end;

procedure TMovEmpCar.pAtualizaTraCarEmpSolicitante(Const strNumDoc, strAutInc, strSeqGerDes, strSeqGerOri: String);
  Var
    qryTraCar: TUniQuery;
begin
  qryTraCar := fCriaQuery;
  Try
    qryTraCar.SQL.Add('UPDATE TRACAR');
    qryTraCar.SQL.Add('SET CAR_NMDENT = :NUMDOC,');
    qryTraCar.SQL.Add('    CAR_ESDENT = :ESPDOC,');
    qryTraCar.SQL.Add('    CAR_INCENT = :AUTOIN_DES,');
    qryTraCar.SQL.Add('    CAR_SEQENT = :SEQGER_DES');
    qryTraCar.SQL.Add('WHERE CAR_INCORI = :AUTOIN_ORI');
    qryTraCar.SQL.Add('  AND CAR_SEQORI = :SEQGER_ORI');
    qryTraCar.SQL.Add('  AND CAR_EMPORI = :EMPORI');
    qryTraCar.SQL.Add('  AND CAR_EMPCAR = :EMPCAR');
    qryTraCar.SQL.Add('  AND CAR_INCENT IS NULL');

    qryTraCar.ParamByName('NUMDOC').AsString     := strNumDoc;
    qryTraCar.ParamByName('ESPDOC').AsString     := 'PD';
    qryTraCar.ParamByName('AUTOIN_DES').AsString := strAutInc;
    qryTraCar.ParamByName('SEQGER_DES').AsString := strSeqGerDes;
    qryTraCar.ParamByName('AUTOIN_ORI').AsString := Self.strAutoincOri;
    qryTraCar.ParamByName('SEQGER_ORI').AsString := strSeqGerOri;
    qryTraCar.ParamByName('EMPORI').AsString     := Self.strEmpOri;
    qryTraCar.ParamByName('EMPCAR').AsString     := Self.strEmpCar;
    qryTraCar.ExecSQL;
  Finally
    FreeAndNil(qryTraCar);
  End;
end;

procedure TMovEmpCar.pAtualizaTraCarLogErr(Const strMensagem: String);
  Var
    qryTraCar: TUniQuery;
    stlMensagem: TStringList;
begin
  qryTraCar := fCriaQuery;
  stlMensagem := TStringList.Create;
  Try
    qryTraCar.SQL.Add('SELECT * FROM TRACAR');
    qryTraCar.SQL.Add('WHERE CAR_INCORI = :AUTOIN_ORI');
    qryTraCar.SQL.Add('  AND CAR_EMPORI = :EMPORI');
    qryTraCar.SQL.Add('  AND CAR_EMPCAR = :EMPCAR');
    qryTraCar.ParamByName('AUTOIN_ORI').AsString := Self.strAutoincOri;
    qryTraCar.ParamByName('EMPORI').AsString     := Self.strEmpOri;
    qryTraCar.ParamByName('EMPCAR').AsString     := Self.strEmpCar;
    qryTraCar.Open;

    stlMensagem.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow) + ' | Operador: ' + strLoginUsuarioLogado);
    stlMensagem.Add(strMensagem);
    stlMensagem.Add('--------------------------------------------------');

    qryTraCar.First;
    While Not qryTraCar.Eof Do
    Begin
      qryTraCar.Edit;
      qryTraCar.FieldByName('CAR_LOGERR').AsString  := Trim(qryTraCar.FieldByName('CAR_LOGERR').AsString + sLineBreak + stlMensagem.Text);
      qryTraCar.FieldByName('CAR_TENTAT').AsInteger := qryTraCar.FieldByName('CAR_TENTAT').AsInteger +1;
      qryTraCar.Post;

      qryTraCar.Next;
    End;
  Finally
    FreeAndNil(qryTraCar);
    FreeAndNil(stlMensagem);
  End;
end;

procedure TMovEmpCar.pCarregaItensEmpCarregamento(qryMovDet: TUniQuery; blnPrecoCustoTE: Boolean; pgbProgresso: TcxProgressBar);
  Var
    intIndex: Integer;
begin
  SetLength(fatVenda.arrMatItens, 0);
  SetLength(fatVenda.arrMatItens, qryMovDet.RecordCount);

  qryMovDet.First;
  While Not qryMovDet.Eof Do
  Begin
    intIndex := qryMovDet.RecNo -1;

    FillChar(fatVenda.arrMatItens[intIndex], SizeOf(fatVenda.arrMatItens[intIndex]), #0);

    fatVenda.arrMatItens[intIndex].intAutInc := qryMovDet.RecNo;
    fatVenda.arrMatItens[intIndex].strCodIte := qryMovDet.FieldByName('ITE_CODITE').AsString;

    If Self.blnBxSbIt Then
    Begin
      fatVenda.arrMatItens[intIndex].strCodGru := qryMovDet.FieldByName('ITE_CODGRU').AsString;
      fatVenda.arrMatItens[intIndex].strCodMar := qryMovDet.FieldByName('ITE_CODMAR').AsString;
      fatVenda.arrMatItens[intIndex].strDesIte := qryMovDet.FieldByName('ITE_DESITE').AsString;
      fatVenda.arrMatItens[intIndex].strCodUni := qryMovDet.FieldByName('ITE_CODUNI').AsString;
      fatVenda.arrMatItens[intIndex].strCodFor := qryMovDet.FieldByName('ITE_CODFOR').AsString;
      fatVenda.arrMatItens[intIndex].fltQtdIte := qryMovDet.FieldByName('SUB_QTDITE').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniTar := qryMovDet.FieldByName('ITE_PREVE1').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniTmp := qryMovDet.FieldByName('ITE_PREVE1').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniIcm := qryMovDet.FieldByName('ITE_PREVE1').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniOri := qryMovDet.FieldByName('ITE_PREVE1').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniVis := qryMovDet.FieldByName('ITE_PREVE1').AsFloat;
      fatVenda.arrMatItens[intIndex].fltTotIte := fatVenda.arrMatItens[intIndex].fltQtdIte * qryMovDet.FieldByName('ITE_PREVE1').AsFloat;
      fatVenda.arrMatItens[intIndex].fltTotCus := fatVenda.arrMatItens[intIndex].fltQtdIte * qryMovDet.FieldByName('ITE_PRECUS').AsFloat;
      fatVenda.arrMatItens[intIndex].fltTotMed := fatVenda.arrMatItens[intIndex].fltQtdIte * qryMovDet.FieldByName('ITE_PREMED').AsFloat;
      fatVenda.arrMatItens[intIndex].fltDesCon := qryMovDet.FieldByName('DET_DESCON').AsFloat * (fatVenda.arrMatItens[intIndex].fltTotIte / fatVenda.fltTotPro);
      fatVenda.arrMatItens[intIndex].fltDesEsp := qryMovDet.FieldByName('DET_DESESP').AsFloat * (fatVenda.arrMatItens[intIndex].fltTotIte / fatVenda.fltTotPro);
      fatVenda.arrMatItens[intIndex].fltValFre := qryMovDet.FieldByName('DET_TOTFRE').AsFloat * (fatVenda.arrMatItens[intIndex].fltTotIte / fatVenda.fltTotPro);
      fatVenda.arrMatItens[intIndex].strNumLot := qryMovDet.FieldByName('SUB_NUMLOT').AsString;
    End
    Else
    Begin
      fatVenda.arrMatItens[intIndex].strCodGru := qryMovDet.FieldByName('ITE_CODGRU').AsString;
      fatVenda.arrMatItens[intIndex].strCodMar := qryMovDet.FieldByName('DET_CODMAR').AsString;
      fatVenda.arrMatItens[intIndex].strDesIte := qryMovDet.FieldByName('DET_DESCRI').AsString;
      fatVenda.arrMatItens[intIndex].strCodUni := qryMovDet.FieldByName('DET_UNIDAD').AsString;
      fatVenda.arrMatItens[intIndex].strCodFor := qryMovDet.FieldByName('DET_FORITE').AsString;
      fatVenda.arrMatItens[intIndex].fltQtdIte := qryMovDet.FieldByName('DET_QTDITE').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniTar := qryMovDet.FieldByName('DET_UNITAR').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniTmp := qryMovDet.FieldByName('DET_UNITAR').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniIcm := qryMovDet.FieldByName('DET_UNITAR').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniOri := qryMovDet.FieldByName('DET_UNIORI').AsFloat;
      fatVenda.arrMatItens[intIndex].fltUniVis := qryMovDet.FieldByName('DET_UNIVIS').AsFloat;
      fatVenda.arrMatItens[intIndex].fltTotIte := qryMovDet.FieldByName('DET_VLRCON').AsFloat;
      fatVenda.arrMatItens[intIndex].fltTotCus := qryMovDet.FieldByName('DET_TOTCUS').AsFloat;
      fatVenda.arrMatItens[intIndex].fltTotMed := qryMovDet.FieldByName('DET_TOTMED').AsFloat;
      fatVenda.arrMatItens[intIndex].fltDesCon := qryMovDet.FieldByName('DET_DESCON').AsFloat;
      fatVenda.arrMatItens[intIndex].fltDesEsp := qryMovDet.FieldByName('DET_DESESP').AsFloat;
      fatVenda.arrMatItens[intIndex].fltValFre := qryMovDet.FieldByName('DET_TOTFRE').AsFloat;
      fatVenda.arrMatItens[intIndex].strNumLot := qryMovDet.FieldByName('DET_NUMLOT').AsString;
    End;

    fatVenda.arrMatItens[intIndex].fltTaxJur := qryMovDet.FieldByName('DET_TAXJUR').AsFloat;
    fatVenda.arrMatItens[intIndex].fltTotCu2 := 0;
    fatVenda.arrMatItens[intIndex].strCodFis := qryMovDet.FieldByName('DET_CODFIS').AsString;
    fatVenda.arrMatItens[intIndex].strIdePro := qryMovDet.FieldByName('DET_IDEPRO').AsString;
    fatVenda.arrMatItens[intIndex].strIncPis := qryMovDet.FieldByName('DET_INCPIS').AsString;
    fatVenda.arrMatItens[intIndex].strIteTin := qryMovDet.FieldByName('DET_ITETIN').AsString;
    fatVenda.arrMatItens[intIndex].strIteCha := qryMovDet.FieldByName('DET_ITECHA').AsString;
    fatVenda.arrMatItens[intIndex].strDesCor := qryMovDet.FieldByName('DET_DESCOR').AsString;
    fatVenda.arrMatItens[intIndex].strTipEmb := qryMovDet.FieldByName('DET_TIPEMB').AsString;
    fatVenda.arrMatItens[intIndex].fltQtdEmb := qryMovDet.FieldByName('DET_QTDEMB').AsFloat;
    fatVenda.arrMatItens[intIndex].fltPreEmb := qryMovDet.FieldByName('DET_PREEMB').AsFloat;
    fatVenda.arrMatItens[intIndex].strTipPre := qryMovDet.FieldByName('DET_TIPPRE').AsString;
    fatVenda.arrMatItens[intIndex].fltPrvTin := qryMovDet.FieldByName('DET_PRVTIN').AsFloat;
    fatVenda.arrMatItens[intIndex].fltPrcTin := qryMovDet.FieldByName('DET_PRCTIN').AsFloat;
    fatVenda.arrMatItens[intIndex].fltFatTin := qryMovDet.FieldByName('DET_FATTIN').AsFloat;
    fatVenda.arrMatItens[intIndex].strProEmb := qryMovDet.FieldByName('DET_PROEMB').AsString;
    fatVenda.arrMatItens[intIndex].strIteEmb := qryMovDet.FieldByName('DET_ITEEMB').AsString;
    fatVenda.arrMatItens[intIndex].intLazQua := qryMovDet.FieldByName('DET_LAZQUA').AsInteger;
    fatVenda.arrMatItens[intIndex].strPromoc := qryMovDet.FieldByName('DET_PROMOC').AsString;
    fatVenda.arrMatItens[intIndex].strClaFis := '5999';
    fatVenda.arrMatItens[intIndex].strTabPre := '1';
    fatVenda.arrMatItens[intIndex].fltPesLiq := qryMovDet.FieldByName('DET_PESLIQ').AsFloat;

    If (fatVenda.arrMatItens[intIndex].strIdePro <> 'NOR') Then
      fatVenda.blnTemTinta := True;

    If blnPrecoCustoTE Then
    Begin
      If Self.blnBxSbIt Then
      Begin
        fatVenda.arrMatItens[intIndex].fltUniTar := qryMovDet.FieldByName('ITE_PRECUS').AsFloat;
        fatVenda.arrMatItens[intIndex].fltUniOri := qryMovDet.FieldByName('ITE_PRECUS').AsFloat;
        fatVenda.arrMatItens[intIndex].fltUniVis := qryMovDet.FieldByName('ITE_PRECUS').AsFloat;
        fatVenda.arrMatItens[intIndex].fltTotIte := fatVenda.arrMatItens[intIndex].fltQtdIte * qryMovDet.FieldByName('ITE_PRECUS').AsFloat;
      End
      Else
      Begin
        fatVenda.arrMatItens[intIndex].fltUniTar := qryMovDet.FieldByName('DET_TOTCUS').AsFloat / qryMovDet.FieldByName('DET_QTDITE').AsFloat;
        fatVenda.arrMatItens[intIndex].fltUniOri := qryMovDet.FieldByName('DET_TOTCUS').AsFloat / qryMovDet.FieldByName('DET_QTDITE').AsFloat;
        fatVenda.arrMatItens[intIndex].fltUniVis := qryMovDet.FieldByName('DET_TOTCUS').AsFloat / qryMovDet.FieldByName('DET_QTDITE').AsFloat;
        fatVenda.arrMatItens[intIndex].fltTotIte := qryMovDet.FieldByName('DET_TOTCUS').AsFloat;
      End;

      fatVenda.arrMatItens[intIndex].fltTaxJur := 0;
      fatVenda.arrMatItens[intIndex].fltDesCon := 0;
      fatVenda.arrMatItens[intIndex].fltDesEsp := 0;
      fatVenda.arrMatItens[intIndex].fltValFre := 0;
    End;

    pProgresso(qryMovDet.RecNo, qryMovDet.RecordCount, pgbProgresso);

    qryMovDet.Next;
  End;
end;

procedure TMovEmpCar.pGeraMovimentos(Const strEmpCar: String; Const blnBxSbIt: Boolean);
begin
  If fEmptyStr(fRetornaClienteFilial(strEmpCar, 'F', True)) Then
  Begin
    pMensagemSonora('Forecedor não preenchido no cadastro da empresa de carregamento '+ strEmpCar +'. Favor verificar o cadastro da empresa!');
    Exit;
  End;

  Self.strEmpCar := strEmpCar;
  Self.blnBxSbIt := blnBxSbIt;

  //gera TE
  If fChamaTelaGravando(fGeraMovEmpCarregamento, 'Aguarde, gerando transferência da empresa de carregamento '+ strEmpCar +' (saída)') Then
    //gera PD
    fChamaTelaGravando(fGeraMovEmpSolicitante, 'Aguarde, gerando transferência da empresa de carregamento '+ strEmpCar +' (entrada)');
end;

end.
