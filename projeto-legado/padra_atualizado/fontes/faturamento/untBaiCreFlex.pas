unit untBaiCreFlex;

interface

uses untMovFlex, DBClient, Provider, DB, Uni, SysUtils, untFuncoesSimples,
  Classes, Variants, UniClientDataSet, UniDataSetProvider, untTLock;

Type
  TProgresso = procedure(strTexto: String; intAtual, intFinal: Integer) of object;

Type
  TBaiCreFlex = Class(TMovFlexImp)
  private
    FcdsBaiCre : TUniClientDataSet;
    FcdsBaiCreSintetico : TUniClientDataSet;
    FdspBaiCre : TUniDataSetProvider;
    FqryBaiCre : TUniQuery;
    FProgresso: TProgresso;
    FobjLock  : TLock;

    intQtdSel : Integer;
    fltCreSel : Double;
    fltDebSel : Double;
    fltDifSel : Double;

    intQtdGer : Integer;
    fltCreGer : Double;
    fltDebGer : Double;
    fltDifGer : Double;

    fltSldIni : Double;
    fltSldFin : Double;

    function GetCreGer: String;
    function GetCreSel: String;
    function GetDebGer: String;
    function GetDebSel: String;
    function GetDifGer: String;
    function GetDifSel: String;
    function GetQtdGer: String;
    function GetQtdSel: String;

    function fGetDataSetBaiCreSintetico: TDataSet;
    function fGetDataSetBaiCre: TDataSet;
    procedure pCalcularPartes;
    procedure pFormatarCampos;
    procedure pRemoverDebitosSintetico;
    function fTravarDestravarRegistro(strNumDoc, strEspDoc, strCodEmp: String; blnTrava: Boolean): Boolean;
    function fJaMarcouChave(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    procedure pSomaTotais(DataSet: TDataSet; blnSomarGeral: Boolean);
    procedure pZerarTotais;
    procedure pSubtrairTotais(DataSet: TDataSet);
    function fSaldoInicial: Double;
    function GetSldIni: String;
    function GetSldFin: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure pMarcarDesmarcarRegistro(strAutInc: String; blnMarDes: Boolean);
    procedure pMarcarDesmarcarTodos(blnMarDes: Boolean);
    function fLancarCreditosDebitosPartesSintetico(strCreDeb: String): Boolean;
    procedure pGravarLancamentoConciliado(blnConcil: Boolean);
  published
    property DataSetBaiCre: TDataSet read fGetDataSetBaiCre;
    property DataSetBaiCreSin: TDataSet read fGetDataSetBaiCreSintetico;
    property onProgresso: TProgresso read FProgresso write FProgresso;
    property strQtdSel : String Read GetQtdSel;
    property strQtdGer : String Read GetQtdGer;
    property strCreSel : String Read GetCreSel;
    property strCreGer : String Read GetCreGer;
    property strDebSel : String Read GetDebSel;
    property strDebGer : String Read GetDebGer;
    property strDifSel : String Read GetDifSel;    
    property strDifGer : String Read GetDifGer;
    property strSldIni : String Read GetSldIni;
    property strSldFin : String Read GetSldFin;
    property objLock   : TLock  Read FobjLock;
  End;

implementation

{ TBaiCreFlex }

constructor TBaiCreFlex.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FcdsBaiCre := TUniClientDataSet.Create(Self);
  FcdsBaiCreSintetico := TUniClientDataSet.Create(Self);
  FdspBaiCre := TUniDataSetProvider.Create(Self);
  FqryBaiCre := fCriaQuery(Self);
  FobjLock   := TLock.Create;
end;

destructor TBaiCreFlex.Destroy;
begin
  FreeAndNil(FcdsBaiCre);
  FreeAndNil(FcdsBaiCre);
  FreeAndNil(FqryBaiCre);
  FreeAndNil(FcdsBaiCreSintetico);
  FreeAndNil(FobjLock);

  inherited Destroy;
end;

function TBaiCreFlex.fGetDataSetBaiCre: TDataSet;
  Var
    strSQL : String;
begin
  Try
    FcdsBaiCre.Close;
    FcdsBaiCre.SetProvider(FdspBaiCre);
    FdspBaiCre.DataSet := FqryBaiCre;

    With FqryBaiCre Do
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';

      If (strQuebra = 'V') Then
      Begin
        strSQL := strSQL + '  CONCAT(FLE_CODVEN,"-",NOMVEN) AS OPERAD, ';
        strSQL := strSQL + '  NOMVEN AS NOMOPE, ';
        strSQL := strSQL + '  FLE_CODVEN AS CODOPE, ';
      End
      Else
      Begin
        strSQL := strSQL + '  CONCAT(FLE_CODREP,"-",NOMREP) AS OPERAD, ';
        strSQL := strSQL + '  NOMREP AS NOMOPE, ';
        strSQL := strSQL + '  FLE_CODREP AS CODOPE, ';
      End;

      strSQL := strSQL + '  FLE_AUTINC AS AUTINC, ';
      strSQL := strSQL + '  IFNULL(VALCRE, VALDEB) AS VALSEL, ';
      strSQL := strSQL + '  FLE_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  FLE_CREDEB AS CREDEB, ';
      strSQL := strSQL + '  FLE_NUMDOC AS NUMDOC, ';
      strSQL := strSQL + '  FLE_ESPDOC AS ESPDOC, ';
      strSQL := strSQL + '  FLE_CODEMP AS CODEMP, ';
      strSQL := strSQL + '  FLE_DTALAN AS DTALAN, ';
      strSQL := strSQL + '  FLE_TIPPAR AS TIPPAR, ';
      strSQL := strSQL + '  IF(FLE_DTACON IS NULL, "N", "C") AS CONCIL, ';
      strSQL := strSQL + '  IF(FLE_NUMDOC <> "", CONCAT(FLE_NUMDOC, "-", FLE_ESPDOC, "-", FLE_CODEMP), " ") AS DOCUME, ';
      strSQL := strSQL + '  IF(FLE_CODCLI <> "", CONCAT(FLE_CODCLI, "-", CLI_NOMCLI), " ") AS CLIENT, ';
      strSQL := strSQL + '  IF(FLE_CODITE <> "", CONCAT(FLE_CODITE, "-", ITE_DESITE), " ") AS PRODUT, ';
      strSQL := strSQL + '  FLE_HISTOR AS HISTOR, ';
      strSQL := strSQL + '  "D"  AS MARDES, ';
      strSQL := strSQL + '  0.00 AS PEREMP, ';
      strSQL := strSQL + '  0.00 AS VALEMP, ';
      strSQL := strSQL + '  0.00 AS PEVERE, '; // Percentual (Vendedor/Representante)
      strSQL := strSQL + '  0.00 AS VLVERE, '; // Valor (Vendedor/Representante)
      strSQL := strSQL + '  OPE_PEOPFL AS PEOPFL, '; //Percentual de distribuição na baixa de créditos FLEX - Parte do Vendedor
      strSQL := strSQL + '  OPE_PEEMFL AS PEEMFL  '; // Percentual de distribuição na baixa de créditos FLEX - Parte da Empresa
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + ' (' + fSQLBase + ') AS A ';
      strSQL := strSQL + ' ORDER BY CODOPE, FLE_DTALAN, FLE_CODEMP, FLE_ESPDOC, FLE_NUMDOC ';

      Close;
      SQL.Clear;
      SQL.Add( strSQL );
      pSetaParametros(FqryBaiCre);
      Open;

      pSetaClient(FqryBaiCre);
    End;

    FcdsBaiCre.Open;

    pSetaClient(FcdsBaiCre);

    fltSldIni := fSaldoInicial;

    pCalcularPartes;

    pFormatarCampos;

    Result := FcdsBaiCre;
  Except
    On E: Exception Do
      Raise Exception.Create('Erro ao carregar o DataSet da Baixa de Crédito. ' + E.Message );
  End;
end;

function TBaiCreFlex.fGetDataSetBaiCreSintetico: TDataSet;
begin
  Try
    pCloneDataSet(FcdsBaiCreSintetico, FcdsBaiCre, True);

    FcdsBaiCreSintetico.EmptyDataSet;
    FcdsBaiCreSintetico.IndexFieldNames := 'CODOPE';

    FcdsBaiCre.DisableControls;

    FcdsBaiCre.First;
    While Not FcdsBaiCre.Eof Do
    Begin

      If Assigned(onProgresso) Then
        onProgresso('Aguarde, Processando Baixa de Crédito Sintética...', FcdsBaiCre.RecNo, FcdsBaiCre.RecordCount);

      If (FcdsBaiCre.FieldByName('MARDES').AsString = 'M') Then
      Begin
        If FcdsBaiCreSintetico.FindKey([ FcdsBaiCre.FieldByName('CODOPE').AsString ]) Then
          FcdsBaiCreSintetico.Edit
        Else
        Begin
          FcdsBaiCreSintetico.Append;
          FcdsBaiCreSintetico.FieldByName('CODOPE').AsString := FcdsBaiCre.FieldByName('CODOPE').AsString;
          FcdsBaiCreSintetico.FieldByName('NOMOPE').AsString := FcdsBaiCre.FieldByName('NOMOPE').AsString;
          FcdsBaiCreSintetico.FieldByName('OPERAD').AsString := FcdsBaiCre.FieldByName('OPERAD').AsString;
          FcdsBaiCreSintetico.FieldByName('PEREMP').AsFloat  := FcdsBaiCre.FieldByName('PEREMP').AsFloat;
          FcdsBaiCreSintetico.FieldByName('PEVERE').AsFloat  := FcdsBaiCre.FieldByName('PEVERE').AsFloat;

          FcdsBaiCreSintetico.FieldByName('VALSEL').AsFloat  := 0;
        End;

        FcdsBaiCreSintetico.FieldByName('VALSEL').AsFloat := FcdsBaiCreSintetico.FieldByName('VALSEL').AsFloat + FcdsBaiCre.FieldByName('VALSEL').AsFloat;
        FcdsBaiCreSintetico.FieldByName('VALEMP').AsFloat := fFormataFloat((FcdsBaiCreSintetico.FieldByName('VALSEL').AsFloat * FcdsBaiCreSintetico.FieldByName('PEREMP').AsFloat) / 100, 2);
        FcdsBaiCreSintetico.FieldByName('VLVERE').AsFloat := fFormataFloat((FcdsBaiCreSintetico.FieldByName('VALSEL').AsFloat * FcdsBaiCreSintetico.FieldByName('PEVERE').AsFloat) / 100, 2);
        FcdsBaiCreSintetico.Post;
      End;

      FcdsBaiCre.Next;
    End;

    FcdsBaiCreSintetico.IndexFieldNames := 'NOMOPE';
    FcdsBaiCre.EnableControls;

    pRemoverDebitosSintetico;

    Result := FcdsBaiCreSintetico;
  Except
    On E: Exception Do
      Raise Exception.Create('Erro ao carregar o DataSet Sintetizado da Baixa de Crédito. ' + E.Message );
  End;
end;

function TBaiCreFlex.fJaMarcouChave(strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsClone, FcdsBaiCre);
  cdsClone.IndexFieldNames := 'NUMDOC;ESPDOC;CODEMP;MARDES';
  Try
    Result := cdsClone.FindKey([strNumDoc, strEspDoc, strCodEmp, 'M']);
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TBaiCreFlex.fTravarDestravarRegistro(strNumDoc, strEspDoc, strCodEmp: String; blnTrava: Boolean): Boolean;

  function fTabela: String;
  begin
    If (Pos(strEspDoc, 'OR_PD_PR_') > 0) Then
      Result := 'FATGOR'
    Else
      Result := 'MOVGER';
  end;

  Var
    strChave : String;
begin
  Result := True;

  If fEmptyStr(strNumDoc) Then
    Exit;

  If (blnTrava) And (fJaMarcouChave(strNumDoc, strEspDoc, strCodEmp)) Then
    Exit;

  strChave := fTabela + strNumDoc + strEspDoc + strCodEmp;

  If Not FobjLock.fLock_Unlock(strChave, blnTrava, False) Then
  Begin
    Result := False;
    fMensagem('', Format('Esse documento [%s] está sendo utilizado em outra estação por ' +
                         fGetHostLock(strChave), [strNumDoc + '-' + strEspDoc + '-' + strCodEmp]), ['OK']);
  End;
end;

function TBaiCreFlex.GetCreGer: String;
begin
  Result := FormatFloat('#,##0.00', fltCreGer);
end;

function TBaiCreFlex.GetCreSel: String;
begin
  Result := FormatFloat('#,##0.00', fltCreSel);
end;

function TBaiCreFlex.GetDebGer: String;
begin
  Result := FormatFloat('#,##0.00', fltDebGer);
end;

function TBaiCreFlex.GetDebSel: String;
begin
  Result := FormatFloat('#,##0.00', fltDebSel);
end;

function TBaiCreFlex.GetDifGer: String;
begin
  Result := FormatFloat('#,##0.00', fltDifGer);
end;

function TBaiCreFlex.GetDifSel: String;
begin
  Result := FormatFloat('#,##0.00', fltDifSel);
end;

function TBaiCreFlex.GetQtdGer: String;
begin
  Result := IntToStr(intQtdGer);
end;

function TBaiCreFlex.GetQtdSel: String;
begin
  Result := IntToStr(intQtdSel)
end;

function TBaiCreFlex.GetSldFin: String;
begin
  Result := FormatFloat('#,##0.00', fltSldFin);
end;

function TBaiCreFlex.GetSldIni: String;
begin
  Result := FormatFloat('#,##0.00', fltSldIni);
end;

procedure TBaiCreFlex.pCalcularPartes;
begin
  pZerarTotais;
  FcdsBaiCre.DisableControls;
  Try
    With FcdsBaiCre Do
    Begin
      First;
      While Not Eof Do
      Begin

        If Assigned(onProgresso) Then
          onProgresso('Aguarde...', FcdsBaiCre.RecNo, FcdsBaiCre.RecordCount);

        Edit;

        If FieldByName('CREDEB').AsString = 'D' Then
          FieldByName('VALSEL').AsFloat := -Abs(FieldByName('VALSEL').AsFloat)
        Else
          FieldByName('VALSEL').AsFloat := Abs(FieldByName('VALSEL').AsFloat);

        FieldByName('PEREMP').AsFloat := IIF(fCfgSis('ROTFLE') = '1', fCfgSis('PEFLEM', varDouble), FieldByName('PEEMFL').AsFloat);
        FieldByName('PEVERE').AsFloat := IIF(fCfgSis('ROTFLE') = '1', fCfgSis('PEFLVE', varDouble), FieldByName('PEOPFL').AsFloat);
        FieldByName('VALEMP').AsFloat := fFormataFloat((FieldByName('VALSEL').AsFloat * FieldByName('PEREMP').AsFloat) / 100, 2);
        FieldByName('VLVERE').AsFloat := fFormataFloat((FieldByName('VALSEL').AsFloat * FieldByName('PEVERE').AsFloat) / 100, 2);
        Post;

        pSomaTotais(FcdsBaiCre, True);

        Next;
      End;
    End;
  Finally
    FcdsBaiCre.EnableControls;
  End;
end;

procedure TBaiCreFlex.pFormatarCampos;
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To (FcdsBaiCre.FieldCount-1) Do
  Begin
    If (FcdsBaiCre.Fields[intCnt].DataType = ftFloat) Then
      TFloatField(FcdsBaiCre.FindField(FcdsBaiCre.Fields[intCnt].FieldName)).DisplayFormat := '##,#0.00';
  End;
end;

function TBaiCreFlex.fLancarCreditosDebitosPartesSintetico(strCreDeb: String): Boolean;
  Var
    objIntMovFle : TMovFlex;
    intCnt : Integer;
  Const
    INT_PAR_EMP : Integer = 1;
    INT_PAR_OPE : Integer = 2;
begin
  Result := False;
  objIntMovFle := TMovFlex.Create(Nil);
  Try

    If (Not FcdsBaiCreSintetico.IsEmpty) Then
    Begin
      With FcdsBaiCreSintetico Do
      Begin

        First;
        While Not Eof Do
        Begin

          For intCnt := 1 To 2 Do
          Begin
            objIntMovFle.dtaDtaLan := fNow;
            objIntMovFle.strCodEmp := VS_strCodEmp;
            objIntMovFle.strCreDeb := strCreDeb;
            objIntMovFle.strNumDoc := '';
            objIntMovFle.strCodCli := '';
            objIntMovFle.strCodIte := '';
            objIntMovFle.strEspDoc := '';
            objIntMovFle.strSeqDor := '';
            objIntMovFle.strNumPok := '';
            objIntMovFle.strOrigem := 'F';
            objIntMovFle.strCodVba := '';

            If (intCnt = INT_PAR_EMP) Then
            Begin
              objIntMovFle.fltValLan := FieldByName('VALEMP').AsFloat;
              objIntMovFle.strHistor := 'Baixa de Créditos FLEX - Parte Empresa';
              objIntMovFle.strCodVen := FieldByName('CODOPE').AsString;
              objIntMovFle.strCodRep := FieldByName('CODOPE').AsString;
              objIntMovFle.strTipPar := 'E';
            End
            Else
            Begin
              objIntMovFle.fltValLan := FieldByName('VLVERE').AsFloat;
              objIntMovFle.strHistor := 'Baixa de Créditos FLEX - Parte ' + IIF(strQuebra = 'V', 'Vendedor', 'Representante');
              objIntMovFle.strCodVen := FieldByName('CODOPE').AsString;
              objIntMovFle.strCodRep := FieldByName('CODOPE').AsString;
              objIntMovFle.strTipPar := strQuebra;
            End;

            objIntMovFle.pAdiciona;
          End;

          Next;
        End;

        Result := Not fEmptyStr(objIntMovFle.fGravar);
      End;
    End;
  Finally
    FreeAndNil(objIntMovFle);
  End;
end;

function TBaiCreFlex.fSaldoInicial: Double;
  Var
    qrySldIni : TUniQuery;
    strSQL : String;
    strCodOpe : String;
begin
  If strQuebra = 'V' Then
    strCodOpe := strCodVen
  Else
    strCodOpe := strCodRep;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   SUM(IFNULL(VALCRE,0)) - SUM(IFNULL(VALDEB,0)) AS SALANT ';
  strSQL := strSQL + '   FROM ';
  strSQL := strSQL + '     (' + fSQLBase(True, strCodOpe) + ') AS SALDO ';

  qrySldIni := fCriaQuery;
  With qrySldIni Do
  Begin
    Close;
    SQL.Clear;
    SQL.Text := strSQL;
    pSetaParametros(qrySldIni);
    Open;
    Result := FieldByName('SALANT').AsFloat;
    Close;
  End;
  FreeAndNil(qrySldIni);
end;

procedure TBaiCreFlex.pMarcarDesmarcarRegistro(strAutInc: String; blnMarDes: Boolean);
begin
  If FcdsBaiCre.Locate('AUTINC', strAutInc, []) Then
  Begin

    If (blnMardes) And (Not fEmptyStr(FcdsBaiCre.FieldByName('TIPPAR').AsString)) Then
    Begin
      fMensagem('', Format('Não é permitido selecionar um lançamento de baixa "Parte %s"',
                           [IIF(FcdsBaiCre.FieldByName('TIPPAR').AsString = 'E', 'Empresa', IIF(FcdsBaiCre.FieldByName('TIPPAR').AsString = 'V', 'Vendedor', 'Representante'))]), ['OK']);
      Exit;
    End;

    If fTravarDestravarRegistro(FcdsBaiCre.FieldByName('NUMDOC').AsString,
                                FcdsBaiCre.FieldByName('ESPDOC').AsString,
                                FcdsBaiCre.FieldByName('CODEMP').AsString,
                                blnMarDes) Then
    Begin
      FcdsBaiCre.Edit;
      FcdsBaiCre.FieldByName('MARDES').AsString := IIF(blnMarDes, 'M', 'D');
      FcdsBaiCre.Post;

      If (blnMarDes) Then
        pSomaTotais(FcdsBaiCre, False)
      Else
        pSubtrairTotais(FcdsBaiCre);
    End;
  End;
end;

procedure TBaiCreFlex.pMarcarDesmarcarTodos(blnMarDes: Boolean);
  Var
    strTmpAutInc : String;
    strTmpIndex : String;
begin
  strTmpAutInc := FcdsBaiCre.FieldByName('AUTINC').AsString;
  strTmpIndex := FcdsBaiCre.IndexFieldNames;
  pZerarTotais;
  FcdsBaiCre.DisableControls;
  Try
    FcdsBaiCre.IndexFieldNames := 'AUTINC';
    FcdsBaiCre.First;
    While Not FcdsBaiCre.Eof Do
    Begin

      If Assigned(onProgresso) Then
        onProgresso('Aguarde, ' + IIF(blnMarDes, 'Marcando', 'Desmarcando') + ' todos os registros.', FcdsBaiCre.RecNo, FcdsBaiCre.RecordCount);

      If (Not ((blnMarDes) And (Not fEmptyStr(FcdsBaiCre.FieldByName('TIPPAR').AsString)))) And 
         (fTravarDestravarRegistro(FcdsBaiCre.FieldByName('NUMDOC').AsString,
                                   FcdsBaiCre.FieldByName('ESPDOC').AsString,
                                   FcdsBaiCre.FieldByName('CODEMP').AsString,
                                   blnMarDes)) Then
      Begin
        FcdsBaiCre.Edit;
        FcdsBaiCre.FieldByName('MARDES').AsString := IIF(blnMarDes, 'M', 'D');
        FcdsBaiCre.Post;
      End;

      pSomaTotais(FcdsBaiCre, True);

      FcdsBaiCre.Next;
    End;
  Finally
    FcdsBaiCre.FindKey([strTmpAutInc]);
    FcdsBaiCre.IndexFieldNames := strTmpIndex;
    FcdsBaiCre.EnableControls;
  End;
end;

procedure TBaiCreFlex.pRemoverDebitosSintetico;
begin
  FcdsBaiCreSintetico.First;
  While Not FcdsBaiCreSintetico.Eof Do
  Begin
    If fFormataFloat(FcdsBaiCreSintetico.FieldByName('VALSEL').AsFloat, 2) <= 0 Then
    Begin
      FcdsBaiCreSintetico.Delete;
      Continue;
    End;
    FcdsBaiCreSintetico.Next;
  End;
end;

procedure TBaiCreFlex.pGravarLancamentoConciliado(blnConcil: Boolean);
  Var
    stlLisInc : TStringList;
    intCnt : Integer;
    strAutInc : String;
    qryUpDate : TUniQuery;
begin
  stlLisInc := TStringList.Create;

  FcdsBaiCreSintetico.IndexFieldNames := 'CODOPE';

  FcdsBaiCre.DisableControls;
  FcdsBaiCre.First;
  While Not FcdsBaiCre.Eof Do
  Begin
    If (FcdsBaiCre.FieldByName('MARDES').AsString = 'M') And
       (FcdsBaiCreSintetico.FindKey([FcdsBaiCre.FieldByName('CODOPE').AsString])) Then
    Begin
      If (stlLisInc.IndexOf(FcdsBaiCre.FieldByName('AUTINC').AsString) < 0) Then
        stlLisInc.Add(FcdsBaiCre.FieldByName('AUTINC').AsString);
    End;
    FcdsBaiCre.Next;
  End;

  FcdsBaiCre.EnableControls;
  FcdsBaiCreSintetico.IndexFieldNames := 'NOMOPE';

  strAutInc := ''; 
  For intCnt := 0 To (stlLisInc.Count -1) Do
  Begin
    If Not fEmptyStr(strAutInc) Then
      strAutInc := strAutInc + ', ';
    strAutInc := strAutInc + QuotedStr(stlLisInc.Strings[intCnt]);
  End;

  FreeAndNil(stlLisInc);

  If (Not fEmptyStr(strAutInc)) Then
  Begin
    qryUpDate := fCriaQuery;
    With qryUpDate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' UPDATE MOVFLE ');
      SQL.Add('    SET FLE_DTACON = :DTACON, ');
      SQL.Add('        FLE_HORCON = :HORCON, ');
      SQL.Add('        FLE_OPECON = :OPECON  ');
      SQL.Add('  WHERE AUTOINCREM IN ( ' + strAutInc + ' ) ');

      If (blnConcil) Then
      Begin
        ParamByName('DTACON').Value := Null;
        ParamByName('HORCON').Value := Null;
      End
      Else
      Begin
        ParamByName('DTACON').AsDateTime := VS_Date;
        ParamByName('HORCON').AsDateTime := fTime();
      End;
      
      ParamByName('OPECON').AsString := strLoginUsuarioLogado;
      ExecSQL;
    End;
    FreeAndNil(qryUpDate);
  End;
end;

procedure TBaiCreFlex.pSomaTotais(DataSet: TDataSet; blnSomarGeral: Boolean);
begin
  If (DataSet.FieldByName('MARDES').AsString = 'M') Then
  Begin
    Inc(intQtdSel);

    If (DataSet.FieldByName('CREDEB').AsString = 'C') Then
      fltCreSel := fltCreSel + Abs(DataSet.FieldByName('VALSEL').AsFloat)
    Else
      fltDebSel := fltDebSel + Abs(DataSet.FieldByName('VALSEL').AsFloat);

    fltDifSel := (fltCreSel - fltDebSel);
  End;

  If (blnSomarGeral) Then
  Begin
    Inc(intQtdGer);

    If (DataSet.FieldByName('CREDEB').AsString = 'C') Then
      fltCreGer := fltCreGer + Abs(DataSet.FieldByName('VALSEL').AsFloat)
    Else
      fltDebGer := fltDebGer + Abs(DataSet.FieldByName('VALSEL').AsFloat);

    fltDifGer := (fltCreGer - fltDebGer);

    fltSldFin := fltSldIni + fltDifGer;
  End;
end;

procedure TBaiCreFlex.pSubtrairTotais(DataSet: TDataSet);
begin
  Inc(intQtdSel, -1);

  If (DataSet.FieldByName('CREDEB').AsString = 'C') Then
    fltCreSel := fltCreSel - Abs(DataSet.FieldByName('VALSEL').AsFloat)
  Else
    fltDebSel := fltDebSel - Abs(DataSet.FieldByName('VALSEL').AsFloat);

  fltDifSel := (fltCreSel - fltDebSel);
end;

procedure TBaiCreFlex.pZerarTotais;
begin
  intQtdSel := 0;
  fltCreSel := 0;
  fltDebSel := 0;
  fltDifSel := 0;

  intQtdGer := 0;
  fltCreGer := 0;
  fltDebGer := 0;
  fltDifGer := 0;
end;

end.
