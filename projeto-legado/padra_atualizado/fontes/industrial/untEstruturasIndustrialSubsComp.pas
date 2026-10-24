unit untEstruturasIndustrialSubsComp;

interface

uses SysUtils, Uni, Classes, UniClientDataSet, Vcl.Controls,
     Variants, StrUtils, cxProgressBar, Forms, StdCtrls,
     untZClient;

Type
  TopcEstIndSubComp = (opcCriarNovaFormula, opcManterFormula);

Type
  TEstruturasIndustrialSubsComp = Class
    private
      FopcEstIndSubComp : TopcEstIndSubComp;
      FProAtu: String;  // Sub - Produto Atual
      FProSub: String;  // Sub - Produto Substituicao
      FRefProSub: String;  // Sub - Produto Substituicao Referencia
      FProEst: String;  // Produto Estrutura
      FCodCor: String;  // Cor
      FCodFor: String;  // Codigo da Formula
      FLinGru: String;
      FMarca : String;
      FStatus: String;
      FPerTol: Double;
      FblnImpAna: Boolean;

      qryEstr: TZClient; // Query de consulta principal
      qryProdEstr: TUniQuery;

     // Query de consulta dos produtos da estrutura principal

      procedure pCarregandoEstruturas; //Carrega o select principal com as estruturas
      procedure pSelecionaProdutosEstrutura(strAutInc, strCodEmp: String); //Carrega o select dos produtos da estrutura
      procedure pIniciaSubstituicaoComponentes(strCodEmp, strCodIte, strCodCor, strRefere: String; fltPesRea: Double); //Gera as novas formulas substituindo o produto atual pelo substituto
      procedure pIniciaAtualizacaoComponentes(strAutInc, strCodEmp: String);
      procedure pDesativaFormulas(strCodIte, strCodCor, strAutoInc, strCodEmp: String);

      function  fImportaAnalise(strCodIte, strCodCor, strAutoInc: String) : Boolean;
      function fRetornaSQLEstrutura: String;
      function fRetornaSQLProdutosEstrutura(strAutInc, strCodEmp: String): String;
      function fSelecaoDeFormulas: Boolean;

    protected
      function getProAtu: String;
      function getProSub: String;
      function getProEst: String;
      function getCodCor: String;
      function getCodFor: String;
      function getRefProSub: String;
      function getLinGru : String;
      function getMarca  : String;


      procedure setProAtu(const Value: String);
      procedure setProSub(const Value: String);
      procedure setProEst(const Value: String);
      procedure setCodCor(const Value: String);
      procedure setCodFor(const Value: String);
      procedure setRefProSub(const Value: String);
      procedure setLinGru(const Value: String);
      procedure setMarca(const Value: String);

    public
      Constructor Create(AOwner: TObject; opcEstIndSubComp : TopcEstIndSubComp = opcCriarNovaFormula); 
      Destructor Destroy; override;

      function fSubstituicaoComponentes(pgbStatus: TcxProgressBar = Nil): Boolean;

      property strProAtu: String Read getProAtu Write setProAtu;
      property strProSub: String Read getProSub Write setProSub;
      property strProEst: String Read getProEst Write setProEst;
      property strCodCor: String Read getCodCor Write setCodCor;
      property strCodFor: String Read getCodFor Write setCodFor;
      property strRefProSub: String Read getRefProSub Write setRefProSub;
      property strCodLinGru: String Read getLinGru Write setLinGru;
      property strCodMarca : String Read getMarca Write setMarca;
      property strStatus : String Read FStatus Write FStatus;
      property fltPerTol : Double Read FPerTol Write FPerTol;
      property blnImpAna : Boolean read FblnImpAna write FblnImpAna;
  End;

implementation

uses untfuncoesSimples, untGerMatInd, Data.DB,
  untEstruturasIndustrialSubsCompSelec;

{ TEstruturasIndustrialSubsComp }

constructor TEstruturasIndustrialSubsComp.Create(AOwner: TObject;
  opcEstIndSubComp: TopcEstIndSubComp);
begin
//  Create(AOwner);
  qryEstr := TZClient.Create(Nil);
  qryProdEstr := fCriaQuery(Nil);
  FopcEstIndSubComp := opcEstIndSubComp;
  
end;

destructor TEstruturasIndustrialSubsComp.Destroy;
begin
  inherited;
end;

function TEstruturasIndustrialSubsComp.fRetornaSQLEstrutura: String;
begin
  //Retorna todos os produtos atuais que sua formula esteja ativa.
  Result := '';
  Result := Result + ' SELECT DISTINCT GER.GMT_CODITE, ';
  Result := Result + '                 I.ITE_DESITE,   ';
  Result := Result + '                 GER.GMT_CODCOR, ';
  Result := Result + '                 C.COR_DESCOR,   ';
  Result := Result + '                 GER.GMT_FORMUL, ';
  Result := Result + '                 GER.GMT_PESREA, ';
  Result := Result + '                 GER.GMT_CODEMP, ';
  Result := Result + '                 GER.AUTOINCREM, ';
  Result := Result + '                 GER.GMT_REFERE, ';
  Result := Result + '                 "S" AS FORSEL   ';
  Result := Result + ' FROM GEIMAT GER                 ';
  Result := Result + '  LEFT JOIN CADITE I ON I.ITE_CODITE = GMT_CODITE ';
  Result := Result + '  LEFT JOIN CADCOR C ON C.COR_CODCOR = GMT_CODCOR ';
  Result := Result + '  INNER JOIN DEIMAT DET ON DET.DMT_SEQGER = GER.AUTOINCREM ';
  Result := Result + '                       AND DET.DMT_CODEMP = GER.GMT_CODEMP ';

  Result := Result + '  WHERE GER.GMT_CODEMP = ' + QuotedStr(VS_strCodEmp);
  If (FStatus = 'A') Or (FStatus = 'I') Then
    Result := Result + '    AND GER.GMT_STATUS = ' + QuotedStr(FStatus);

  Result := Result + '    AND DET.DMT_ITESUB = ' + QuotedStr(FProAtu);  //Filtra pelo produto atual

  If Not fEmptyStr(FProEst) Then
    Result := Result + ' AND GER.GMT_CODITE = ' + QuotedStr(FProEst);

  If Not fEmptyStr(FCodCor) Then
    Result := Result + ' AND GER.GMT_CODCOR = ' + QuotedStr(FCodCor);

  If Not fEmptyStr(FCodFor) Then
    Result := Result + ' AND GER.GMT_FORMUL = ' + QuotedStr(FCodFor);

  If Not fEmptyStr(FLinGru) Then
    Result := Result + ' AND I.ITE_CODGRU = ' + QuotedStr(FLinGru);

  If Not fEmptyStr(FMarca) Then
    Result := Result + ' AND I.ITE_CODMAR = ' + QuotedStr(FMarca);

  Result := Result + '   ORDER BY GER.GMT_CODITE, GER.GMT_CODCOR, GER.GMT_FORMUL, GER.GMT_CODEMP ';
end;

function TEstruturasIndustrialSubsComp.fRetornaSQLProdutosEstrutura(strAutInc,
  strCodEmp: String): String;
begin
  Result := '';
  Result := Result + ' SELECT DMT_SEQGER, ';
  Result := Result + '        DMT_SEQUEN, ';
  Result := Result + '        D.AUTOINCREM, ';
  Result := Result + '        DMT_CODEMP, ';
  Result := Result + '        DMT_ITESUB, ';
  Result := Result + '        DMT_DESCRI, ';
  Result := Result + '        DMT_QTDITE, ';
  Result := Result + '        DMT_PERTOL, ';
  Result := Result + '        IFNULL(ITE_PRECUS, 0) AS DMT_CUSITE, ';
  Result := Result + '        DMT_DESPCA, ';
  Result := Result + '        IFNULL(ITE_DENSID, 0) AS DMT_DENSID, ';
  Result := Result + '        DMT_CODFAS, ';
  Result := Result + '        DMT_SEQITE, ';
  Result := Result + '        (IFNULL(ITE_PRECUS, 0) * DMT_QTDITE) / 100 AS DMT_CUSCAL ';

  Result := Result + '   FROM DEIMAT D    ';

  Result := Result + '   LEFT JOIN CADITE C ON DMT_ITESUB = C.ITE_CODITE ';

  Result := Result + '   LEFT JOIN ITEGER I ON DMT_ITESUB = I.ITE_CODITE AND I.ITE_CODEMP = ' + QuotedStr(strCodEmp);

  Result := Result + '  WHERE DMT_SEQGER = ' + QuotedStr(strAutInc);
  Result := Result + '    AND DMT_CODEMP = ' + QuotedStr(strCodEmp);
  Result := Result + '  ORDER BY DMT_SEQUEN ';
end;

function TEstruturasIndustrialSubsComp.fSelecaoDeFormulas : Boolean;
Begin
  Try
    pCriarFormularios(TfrmEstruturasIndustrialSubsCompSelec, frmEstruturasIndustrialSubsCompSelec);
    frmEstruturasIndustrialSubsCompSelec.dtsSource.DataSet := qryEstr;
    frmEstruturasIndustrialSubsCompSelec.ShowModal;
    Result := (frmEstruturasIndustrialSubsCompSelec.ModalResult = mrOK);
  Finally
    FreeAndNil(frmEstruturasIndustrialSubsCompSelec);
  End;
End;

function TEstruturasIndustrialSubsComp.fSubstituicaoComponentes(
  pgbStatus: TcxProgressBar): Boolean;

    procedure pInformacao(strMsg: String);
    begin
      If Assigned(pgbStatus) Then
        TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strMsg;
      Application.ProcessMessages;
    end;

    procedure pProgress(intPos, intMax: Integer);
    Begin
      If Assigned(pgbStatus) Then
      Begin
        pgbStatus.Properties.Max := intMax;
        pgbStatus.Position := intPos;
        Application.ProcessMessages;
      End;
    End;

begin
  Result := True;
  
  Try
    Try
      pInformacao('Carregando Estruturas, Aguarde....');

      pCarregandoEstruturas;

      If not fSelecaoDeFormulas Then
        Exit(false);

      pInformacao('Iniciando Substituição, Aguarde....');

      With qryEstr Do
      Begin
        Filter := 'FORSEL = ' + QuotedStr('S');
        Filtered := True;

        fStartTransaction;

        First;
        While Not Eof Do
        Begin
          pProgress(qryEstr.RecNo, qryEstr.RecordCount);

          if FopcEstIndSubComp = opcCriarNovaFormula Then
          Begin
            pSelecionaProdutosEstrutura(FieldByName('AUTOINCREM').AsString, FieldByName('GMT_CODEMP').AsString);
            pIniciaSubstituicaoComponentes(FieldByName('GMT_CODEMP').AsString, FieldByName('GMT_CODITE').AsString,
                                           FieldByName('GMT_CODCOR').AsString, FieldByName('GMT_REFERE').AsString,
                                           FieldByName('GMT_PESREA').AsFloat);
          End
          Else
            pIniciaAtualizacaoComponentes(FieldByName('AUTOINCREM').AsString, FieldByName('GMT_CODEMP').AsString);;

          Next;
        End;

        If Not IsEmpty Then
        Begin
          fCommit;
          fMensagem('INFORMAÇÃO','Estruturas substituidas com sucesso !',['&Ok']);
        End
        Else
        Begin
          fRollBack;
          fMensagem('INFORMAÇÃO','Não Existem Estruturas para serem substituidas !',['&Ok']);
        End;
      End;

    Except
      on E: Exception do
      begin
        fRollBack;
        Result := False;
      end;
    End;
  Finally
    FreeAndNil(qryEstr);
    FreeAndNil(qryProdEstr);
  End;
end;

function TEstruturasIndustrialSubsComp.getCodCor: String;
begin
  Result := FCodCor;
end;

function TEstruturasIndustrialSubsComp.getCodFor: String;
begin
  Result := FCodFor;
end;

function TEstruturasIndustrialSubsComp.getLinGru: String;
begin
  Result := FLinGru;
end;

function TEstruturasIndustrialSubsComp.getMarca: String;
begin
  Result := FMarca;
end;

function TEstruturasIndustrialSubsComp.getProAtu: String;
begin
  Result := FProAtu;
end;

function TEstruturasIndustrialSubsComp.getProEst: String;
begin
  Result := FProEst;
end;

function TEstruturasIndustrialSubsComp.getProSub: String;
begin
  Result := FProSub;
end;

function TEstruturasIndustrialSubsComp.getRefProSub: String;
begin
  Result := FRefProSub;
end;

procedure TEstruturasIndustrialSubsComp.pCarregandoEstruturas;
begin
  Try
    With qryEstr.qryQuery Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLEstrutura);
      qryEstr.fAbreClient(True, 'TEstruturasIndustrialSubsComp.pCarregandoEstruturas');

      TFloatField(qryEstr.FieldByName('GMT_PESREA')).DisplayFormat := '#,##0.00';
    End;
  Except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[TEstruturasIndustrialSubsComp.pCarregandoEstruturas]');
    end;
  End;
end;

procedure TEstruturasIndustrialSubsComp.pDesativaFormulas(strCodIte, strCodCor,
  strAutoInc, strCodEmp: String);
  var
    qryCons: TUniQuery;
begin
  Try
    Try
      qryCons := fCriaQuery(nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE GEIMAT ');
        SQL.Add('    SET GMT_STATUS = "I"      ');
        SQL.Add('  WHERE GMT_CODITE = :CODITE  ');
        SQL.Add('    AND GMT_CODCOR = :CODCOR  ');
        SQL.Add('    AND GMT_CODEMP = :CODEMP  ');
        SQL.Add('    AND AUTOINCREM <> :AUTOIN ');
        SQL.Add('    AND GMT_STATUS = "A"      ');
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODCOR').AsString := strCodCor;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('AUTOIN').AsString := strAutoInc;
        ExecSQL;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[TEstruturasIndustrialSubsComp.pDesativaFormulas]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;


function TEstruturasIndustrialSubsComp.fImportaAnalise(strCodIte, strCodCor, strAutoInc: String) : Boolean;
  var
    qryAnalise: TUniQuery;
begin

  Try
    Try
      qryAnalise := fCriaQuery(nil);
      qryAnalise.Close;
      qryAnalise.SQL.Clear;
      qryAnalise.SQL.Add('SELECT                                                ');
      qryAnalise.SQL.Add('  DISTINCT GEIANA.*                                   ');
      qryAnalise.SQL.Add('FROM                                                  ');
      qryAnalise.SQL.Add('  GEIMAT                                              ');
      qryAnalise.SQL.Add('  INNER JOIN GEIANA ON GAN_SEQGMT = GEIMAT.AUTOINCREM ');
      qryAnalise.SQL.Add('WHERE                                                 ');
      qryAnalise.SQL.Add('      GMT_CODCOR = :CODCOR                            ');
      qryAnalise.SQL.Add('  AND GMT_CODITE = :CODITE                            ');
      qryAnalise.SQL.Add('  AND GMT_STATUS = "A"                                ');
      qryAnalise.SQL.Add('  AND GEIMAT.AUTOINCREM <> :AUTINC                    ');
      qryAnalise.ParamByName('CODITE').AsString := strCodIte;
      qryAnalise.ParamByName('CODCOR').AsString := strCodCor;
      qryAnalise.ParamByName('AUTINC').AsString := strAutoInc;
      qryAnalise.Open;

      Result := fGravaGeiAna(strAutoInc, qryAnalise);

    Except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TEstruturasIndustrialSubsComp.pImportAnalise]');
      end;
    End;
  Finally
    FreeAndNil(qryAnalise);
  End;

end;

procedure TEstruturasIndustrialSubsComp.pIniciaAtualizacaoComponentes(strAutInc, strCodEmp: String);
  Var
    qryUpdate : TUniQuery;
begin
  Try
    qryUpdate := fCriaQuery;
    With qryUpdate, Sql Do
    Begin
      Add(' UPDATE DEIMAT ');
      Add(' SET DMT_ITESUB = :ITESUB');
      Add('WHERE DMT_SEQGER = :SEQGER ');
      Add('  AND DMT_CODEMP = :CODEMP ');
      Add('  AND DMT_ITESUB = :ITESUB_ATU');

      ParamByName('ITESUB_ATU').AsString := FProAtu;
      ParamByName('ITESUB').AsString     := FProSub;
      ParamByName('SEQGER').AsString     := strAutInc;
      ParamByName('CODEMP').AsString     := strCodEmp;

      ExecSQL;

    End;

  Except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[TEstruturasIndustrialSubsComp.pIniciaAtualizacaoComponentes]');
    end;

  End;

  FreeAndNil(qryUpdate);

end;

procedure TEstruturasIndustrialSubsComp.pIniciaSubstituicaoComponentes(
  strCodEmp, strCodIte, strCodCor, strRefere: String; fltPesRea: Double);
  var
    strAutoinc: String;
    strCodForm: String;
    intSequenc: Integer;
begin
  strAutoinc := '';
  strCodForm := '';
  intSequenc := 0;

  //Grava cabecalho da nova formula
  fGravaGerMat(strAutoInc,
               strCodEmp,
               strCodIte,
               strCodCor,
               strCodForm,
               strRefere,
               '',
               '',
               '',
               '',
               'A',
               fltPesRea,
               VS_Date,
               fNow,
               0,
               0);

  //Grava os itens da nova formula
  qryProdEstr.First;
  With qryProdEstr Do
  Begin
    While Not Eof Do
    Begin
      intSequenc := intSequenc + 1;

      fGravaDetMat(strAutoInc,
                   intSequenc,
                   FieldByName('DMT_SEQITE').AsString,
                   VS_strCodEmp,
                   IIF(FieldByName('DMT_ITESUB').AsString = FProAtu,FProSub,FieldByName('DMT_ITESUB').AsString),
                   FieldByName('DMT_DESCRI').AsString,
                   FieldByName('DMT_DESPCA').AsString,
                   FieldByName('DMT_QTDITE').AsFloat,
                   IIF(FieldByName('DMT_ITESUB').AsString = FProAtu,fltPerTol,FieldByName('DMT_PERTOL').AsString),
                   FieldByName('DMT_CODFAS').AsString);

      Next;
    End;
  End;

  //Importa Análises da Fórmula Ativa
  if FblnImpAna then
    if not fImportaAnalise(strCodIte, strCodCor, strAutoInc) then
      raise Exception.Create('Erro ao importar Análises');

  pDesativaFormulas(strCodIte,strCodCor,strAutoInc,strCodEmp);
end;

procedure TEstruturasIndustrialSubsComp.pSelecionaProdutosEstrutura(strAutInc,
  strCodEmp: String);
begin
  Try
    With qryProdEstr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSQLProdutosEstrutura(strAutInc, strCodEmp));
      Open;
    End;
  Except
    on E: Exception do
    begin
      pMensagensErro(E.Message, '[TEstruturasIndustrialSubsComp.pSelecionaProdutosEstrutura]');
    end;
  End;
end;

procedure TEstruturasIndustrialSubsComp.setCodCor(const Value: String);
begin
  If (FCodCor <> Value) Then
    FCodCor := Value;
end;

procedure TEstruturasIndustrialSubsComp.setCodFor(const Value: String);
begin
  If (FCodFor <> Value) Then
    FCodFor := Value;
end;

procedure TEstruturasIndustrialSubsComp.setLinGru(const Value: String);
begin
  If FLinGru <> Value Then
    FLinGru := Value;

end;

procedure TEstruturasIndustrialSubsComp.setMarca(const Value: String);
begin
  If FMarca <> Value Then
    FMarca := Value;

end;

procedure TEstruturasIndustrialSubsComp.setProAtu(const Value: String);
begin
  If (FProAtu <> Value) Then
    FProAtu := Value;
end;

procedure TEstruturasIndustrialSubsComp.setProEst(const Value: String);
begin
  If (FProEst <> Value) Then
    FProEst := Value;
end;

procedure TEstruturasIndustrialSubsComp.setProSub(const Value: String);
begin
  If (FProSub <> Value) Then
    FProSub := Value;
end;

procedure TEstruturasIndustrialSubsComp.setRefProSub(const Value: String);
begin
  If (FRefProSub <> Value) Then
    FRefProSub := Value;
end;

end.
