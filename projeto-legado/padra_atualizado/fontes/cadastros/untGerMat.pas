unit untGerMat;

interface

uses
  SysUtils, Classes, DB,   Uni, StrUtils, Variants, UniClientDataSet, Forms;

Type
  TGerMat = class(TComponent)
    private
      class var FItensJaExibidosBanner: TStringList;
    Private
      qryIteEst: TUniQuery;
      cdsBanner: TUniClientDataSet;
      function fGetSQLBanner(strTabPre: String): String;
      procedure pCriaClientBanner;
    Public
      function  getCdsBanner: TUniClientDataSet;
      procedure pCarregaProdutosParaBanner(strTabPre: String);
      procedure pCarregaProdutosDaEstrutura(strSeqGer: String);

      function getQryIteEst: TUniQuery;

      Constructor Create(Owner: TComponent); override;
      Destructor  Destroy; override;
End;

function fGravaGerMat(Var strAutInc: String;
                      strCodEmp,
                      strCodIte,
                      strRefere,
                      strObs001,
                      strObs002,
                      strObs003,
                      strObs004,
                      strTipQtd,
                      strObs005,
                      strObs006,
                      strObs007 : String;
                      strTabela : String = ''): Boolean;

function fGravaDetMat(strSeqGer,
                      strSeQuen,
                      strCodEmp,
                      strIteSub,
                      strDescri,
                      strDestino,
                      strRefere:String;
                      fltQtdIte:Double;
                      strCusIte:String;
                      strAcumOp:String;
                      fltQtdPec,
                      fltComPec,
                      fltLarPec,
                      fltEspPec: Double;
                      strAparel,
                      strBenefi: String;
                      fltPerApa,
                      fltPerBen: Double;
                      fltPreSub: Double = 1.000;
                      strTabela: String = ''): Boolean;

function fGravaEteMat(strSeqGer,
                      strCodEte: String;
                      fltValMin,
                      fltValMax: Double) : Boolean;

implementation

uses untfuncoesSimples, untCadPro, untFuncoesImagem;

function fGravaGerMat(var strAutInc: String;
                      strCodEmp,
                      strCodIte,
                      strRefere,
                      strObs001,
                      strObs002,
                      strObs003,
                      strObs004,
                      strTipQtd,
                      strObs005,
                      strObs006,
                      strObs007 : String;
                      strTabela : String = ''): Boolean;
  Var
    qryGerMat: TUniQuery;
    strTable : String;
begin
  Result := True;

  strTable := IIF(strTabela.IsEmpty, 'GERMAT', strTabela);

  Try

    If strTable.Equals('GERMAT') Then
      strAutInc := fRetAutoIncrem(strTable, strCodEmp);

    qryGerMat := fCriarQuery('SELECT * FROM '+strTable+' WHERE FALSE', nil);
    With qryGerMat Do
    Begin

      If Not Active Then
        Open;

      Insert;
      FieldByName('AUTOINCREM').AsString := strAutInc;
      FieldByName('GMT_CODEMP').AsString := strCodEmp;
      FieldByName('GMT_CODITE').AsString := strCodIte;
      FieldByName('GMT_REFERE').AsString := strRefere;
      FieldByName('GMT_OBS001').AsString := strObs001;
      FieldByName('GMT_OBS002').AsString := strObs002;
      FieldByName('GMT_OBS003').AsString := strObs003;
      FieldByName('GMT_OBS004').AsString := strObs004;
      FieldByName('GMT_OBS005').AsString := strObs005;
      FieldByName('GMT_OBS006').AsString := strObs006;
      FieldByName('GMT_OBS007').AsString := strObs007;
      FieldByName('GMT_TIPQTD').AsString := strTipQtd;
      Post;

    End;

  Except
    On E: Exception Do
    Begin
      qryGerMat.Cancel;
      pMensagensErro(E.Message, '[fGravaGerMat]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGerMat);
end;



function fGravaDetMat(strSeqGer,
                      strSeQuen,
                      strCodEmp,
                      strIteSub,
                      strDescri,
                      strDestino,
                      strRefere:String;
                      fltQtdIte:Double;
                      strCusIte:String;
                      strAcumOp:String;
                      fltQtdPec,
                      fltComPec,
                      fltLarPec,
                      fltEspPec: Double;
                      strAparel,
                      strBenefi: String;
                      fltPerApa,
                      fltPerBen: Double;
                      fltPreSub: Double = 1.000;
                      strTabela: String = ''): Boolean;
  Var
    strAutInc: String;
    qryDetMat: TUniQuery;
    strTable : String;
begin

  Result := True;

  Try

    strTable := IIF(strTabela.IsEmpty, 'DETMAT', strTabela);

    If strTable.Equals('DETMAT') Then
      strAutInc := fRetAutoIncrem(strTable, strCodEmp);

    qryDetMat := fCriarQuery('SELECT * FROM '+strTable+' WHERE FALSE', nil);
    With qryDetMat Do
    Begin

      If Not Active Then
        Open;

      Insert;
      FieldByName('AUTOINCREM').AsString  := strAutInc;
      FieldByName('DMT_SEQGER').AsString  := strSeqGer;
      FieldByName('DMT_SEQUEN').AsString  := strSeQuen;
      FieldByName('DMT_CODEMP').AsString  := strCodEmp;
      FieldByName('DMT_ITESUB').AsVariant := IIF(strIteSub = '', Null, strIteSub);
      FieldByName('DMT_DESCRI').AsVariant := IIF(strDescri = '', Null, strDescri);
      FieldByName('DMT_DESPCA').AsVariant := IIF(strDestino = '', Null, strDestino);
      FieldByName('DMT_REFERE').AsVariant := IIF(strRefere = '', Null, strRefere);
      FieldByName('DMT_QTDITE').AsFloat   := fltQtdIte;
      FieldByName('DMT_CUSITE').AsFloat   := fStrToFloat(strCusIte);
      FieldByName('DMT_ACUMOP').AsVariant := IIF(strAcumOp = '', 'S', strAcumOp);
      FieldByName('DMT_PRESUB').AsVariant := fltPreSub;

      If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
      Begin
        FieldByName('DMT_QTDPEC').AsFloat  := fltQtdPec;
        FieldByName('DMT_COMPEC').AsFloat  := fltComPec;
        FieldByName('DMT_LARPEC').AsFloat  := fltLarPec;
        FieldByName('DMT_ESPPEC').AsFloat  := fltEspPec;
        FieldByName('DMT_APAREL').AsString := strAparel;
        FieldByName('DMT_BENEFI').AsString := strBenefi;
        FieldByName('DMT_PERAPA').AsFloat  := fltPerApa;
        FieldByName('DMT_PERBEN').AsFloat  := fltPerBen;
      End;

      Post;

    End;


  Except
    On E: Exception Do
    Begin
      qryDetMat.Cancel;
      pMensagensErro(E.Message, '[fGravaDetMat]');
      Result := False;
    End;
  End;

  FreeAndNil(qryDetMat);
end;

function fGravaEteMat(strSeqGer,
                      strCodEte: String;
                      fltValMin,
                      fltValMax: Double) : Boolean;
  Var
    qryEteMat : TUniQuery;
Begin
  Result := True;
  Try
    qryEteMat := fCriaQuery(Nil);
    With qryEteMat, SQL Do
    Begin
      Close;
      Clear;
      Add(' INSERT INTO ETEMAT( AUTOINCREM, ');
      Add('                     ETM_SEQMAT, ');
      Add('                     ETM_CODETE, ');
      Add('                     ETM_VALMIN, ');
      Add('                     ETM_VALMAX) ');
      Add('             VALUES( :AUTINC,    ');
      Add('                     :SEQMAT,    ');
      Add('                     :CODETE,    ');
      Add('                     :VALMIN,    ');
      Add('                     :VALMAX)    ');

      ParamByName('AUTINC').AsString := fRetAutoIncrem('ETEMAT',VS_strCodEmp);
      ParamByName('SEQMAT').AsString := strSeqGer;
      ParamByName('CODETE').AsString := strCodEte;
      ParamByName('VALMIN').AsFloat  := fltValMin;
      ParamByName('VALMAX').AsFloat  := fltValMax;

      Try
        ExecSQL;
      Except
        On E : Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, 'fGravaEteMat');
        End;
      End;
    End;

  Finally
    FreeAndNil(qryEteMat);
  End;
End;

function TGerMat.fGetSQLBanner(strTabPre: String): String;
begin

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  G.AUTOINCREM AS AUTINC, ';
  Result := Result + '  G.GMT_CODITE AS CODITE, ';
  Result := Result + '  I.ITE_DESITE AS DESITE, ';
  Result := Result + '  ('+ fGetSQLITE_PREVE('T', strTabPre) +') AS PREVEN ';
  Result := Result + 'FROM ';
  Result := Result + '  GERMAT G ';
  Result := Result + '  INNER JOIN CADITE I ON I.ITE_CODITE = G.GMT_CODITE     ';
  Result := Result + '  INNER JOIN ITEGER T ON T.ITE_CODITE = G.GMT_CODITE AND ';
  Result := Result + '                         T.ITE_CODEMP = G.GMT_CODEMP     ';
  Result := Result + 'WHERE ';
  Result := Result  + '  G.GMT_CODEMP = :CODEMP ';
End;

function TGerMat.getCdsBanner: TUniClientDataSet;
begin
  Result := cdsBanner;
end;

function TGerMat.getQryIteEst: TUniQuery;
begin
  Result := qryIteEst;
end;

procedure TGerMat.pCarregaProdutosDaEstrutura(strSeqGer: String);
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT                      ';
    strSQL := strSQL + '  DMT_ITESUB AS CODITE,     ';
    strSQL := strSQL + '  ITE_DESITE AS DESITE,     ';
    strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI,     ';
    strSQL := strSQL + '  DMT_QTDITE AS QTDITE      ';
    strSQL := strSQL + 'FROM                        ';
    strSQL := strSQL + '  DETMAT                    ';
    strSQL := strSQL + '  INNER JOIN CADITE ON ITE_CODITE = DMT_ITESUB  ';
    strSQL := strSQL + '  INNER JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI  ';
    strSQL := strSQL + 'WHERE                                           ';
    strSQL := strSQL + '  DMT_SEQGER = :SEQGER                          ';

    With qryIteEst Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SEQGER').AsString := strSeqGer;
      Open;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.message, '[TGerMat.pCarregaProdutosDaEstrutura]');
  End;

end;

procedure TGerMat.pCarregaProdutosParaBanner(strTabPre: String);
Var
  qryBanner: TUniQuery;
  objOutputStream : TBytesStream;
  LArrRecNo: TArray<String>;
begin
  Try

    qryBanner := fCriaQuery(Nil);

    If (Not Assigned(cdsBanner)) Then
    Begin
      pCriaClientBanner;
    End
    Else
      cdsBanner.EmptyDataSet;

    With qryBanner Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLBanner(strTabPre));
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      SetLength(LArrRecNo, 0);
      If RecordCount > fCfgSis('BANQTD', VarInteger) Then
      Begin
        First;
        While Not Eof Do
        Begin
          If FItensJaExibidosBanner.IndexOf(FieldByName('CODITE').AsString) = -1 Then
          Begin
            SetLength(LArrRecNo, Length(LArrRecNo)+1);
            LArrRecNo[Length(LArrRecNo)-1] := RecNo.ToString;
            FItensJaExibidosBanner.Add(FieldByName('CODITE').AsString);
          End;

          If Length(LArrRecNo) >= fCfgSis('BANQTD', VarInteger) Then
            If (RecordCount - RecNo) >= fCfgSis('BANQTD', VarInteger) Then
              Break;

          Next;
        End;
      End;

      If FItensJaExibidosBanner.Count >= RecordCount Then
        FItensJaExibidosBanner.Clear;

      If Length(LArrRecNo) < fCfgSis('BANQTD', VarInteger) Then
        FItensJaExibidosBanner.Clear;

      First;

      While Not Eof Do
      Begin
        If Length(LArrRecNo) > 0 Then
        Begin
          If Not MatchStr(RecNo.ToString, LArrRecNo) Then
          Begin
            Next;
            Continue;
          End;
        End;

        If cdsBanner.RecordCount >= fCfgSis('BANQTD', VarInteger) Then
          Break;

        cdsBanner.Insert;
        cdsBanner.FieldByName('AUTINC').AsString := FieldByName('AUTINC').AsString;
        cdsBanner.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
        cdsBanner.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
        cdsBanner.FieldByName('PREVEN').AsFloat  := FieldByName('PREVEN').AsFloat;

        If fRetornaPathImagem(False) <> '' Then
        Begin
          objOutputStream := TBytesStream.Create;
          Try
            If fCarregaImagemPrincipalProdutoDB(FieldByName('CODITE').AsString, objOutputStream, False) Then
              TBlobField(cdsBanner.FieldByName('IMAGEM')).LoadFromStream(objOutputStream);
          Finally
            If Assigned(objOutputStream) Then objOutputStream.Free;
          End;
        End;


        cdsBanner.Post;

        Next;
      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TGerMat.CarregaProdutosParaBanner]')
  End;

  FreeAndNil(qryBanner);
End;

procedure TGerMat.pCriaClientBanner;
begin
  Try
    cdsBanner := TUniClientDataSet.Create(Nil);
    cdsBanner.AggregatesActive := True;

    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'AUTINC'; DataType := ftString; Size := 020; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Size := 100; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'PREVEN'; DataType := ftFloat;               Required := False; End; //(12,02)
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'IMAGEM'; DataType := ftBlob;                Required := False; End;

    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'DESCOM'; DataType := ftString; Size := 50;  Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'TABPRE'; DataType := ftString; Size := 100; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'VIGENC'; DataType := ftString; Size := 30;  Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'EMPRES'; DataType := ftString; Size := 200; Required := False; End;

    cdsBanner.CreateDataSet;

    cdsBanner.LogChanges := False;

    TBlobField.Create(cdsBanner.FieldByName('IMAGEM') as TBlobField);
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TGerMat.pCriaClientBanner]');
  End;
end;

{ TGerMat }

constructor TGerMat.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  qryIteEst := fCriaQuery(Self);

end;

destructor TGerMat.Destroy;
begin
  If (Assigned(cdsBanner)) Then
    FreeAndNil(cdsBanner);

  FreeAndNil(qryIteEst);

  inherited destroy;
end;

initialization
  TGerMat.FItensJaExibidosBanner := TStringList.Create;
finalization
   FreeAndNil(TGerMat.FItensJaExibidosBanner);
end.
