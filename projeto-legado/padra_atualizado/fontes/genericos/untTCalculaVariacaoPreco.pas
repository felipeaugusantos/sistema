unit untTCalculaVariacaoPreco;

interface

uses Forms, Data.DB, System.SysUtils, System.Math, Classes, untFuncoesSimples, untConstantes,
     untILiberacao , untLiberacaoFactory, untMsgLiberacao, untGravando, cxProgressBar, Datasnap.DBClient, Uni;

  Type
    TCalculaVariacaoPreco = class
    private
      FfltVariacaoPreve1: Double;
      FfltVariacaoPreve2: Double;
      FfltVariacaoPreve3: Double;
      FfltVariacaoPreve4: Double;
      FfltVariacaoPreve5: Double;
      FfltVariacaoPreve6: Double;
      FfltVariacaoPreve7: Double;

      objLiberacao : ILiberacao;
      FDataSet : TDataSet;
      blnGerouTrava : Boolean;


      procedure pProcessaTemTabelaAcimaDoPermitido;
      function  fTabelaAcimaDoPermitidoIndividual(fltValidacao: Double): Boolean;
      procedure pEscreve(intTabPre: Integer; objTabela : TRegistroMsgLiberaTabela; objLinha  : TLinhaMsgLibera);

      function fRetNewPreve(intTabPreco: Integer): Double;
      function fRetPreve(intTabPreco: Integer): Double;
      function fRetVariacao(intTabPreco: Integer): Double;
      function fRetTeveVariacaoMaior(intTabPreco: Integer): Boolean;
      function fProcessaQryPrg(pgbProgresso: TcxProgressBar): Boolean;
      procedure pSetaIndex(var strIndex: String);
      procedure pSetaIndexAntigo(strIndex: string);
    public
      strCodite: string;
      strDesIte: String;
      strSigUni: String;
      fltPreve1: Double;
      fltPreve2: Double;
      fltPreve3: Double;
      fltPreve4: Double;
      fltPreve5: Double;
      fltPreve6: Double;
      fltPreve7: Double;

      fltNewPreve1: Double;
      fltNewPreve2: Double;
      fltNewPreve3: Double;
      fltNewPreve4: Double;
      fltNewPreve5: Double;
      fltNewPreve6: Double;
      fltNewPreve7: Double;

      blnBloqueia: Boolean;
      blnTemTabelaAcimaDoPermitido: Boolean;
      fltLimite: Double;
      intDecUni: integer;
      strFieldPreve : String;
      strNewFieldPreve : String;

      property fltVariacaoPreve1: Double write FfltVariacaoPreve1;
      property fltVariacaoPreve2: Double write FfltVariacaoPreve2;
      property fltVariacaoPreve3: Double write FfltVariacaoPreve3;
      property fltVariacaoPreve4: Double write FfltVariacaoPreve4;
      property fltVariacaoPreve5: Double write FfltVariacaoPreve5;
      property fltVariacaoPreve6: Double write FfltVariacaoPreve6;
      property fltVariacaoPreve7: Double write FfltVariacaoPreve7;


      procedure pProcessaVariacao;
      function  fTravaPrecosForaPermitido(DataSet: TDataSet): Boolean;
      constructor create();
      destructor Destroy;override;

      function fTravaUnitario: Boolean;

  end;

implementation

{ TCalculaVariacaoPreco }

constructor TCalculaVariacaoPreco.create;
begin
  intDecUni := fCfgSis('DECUNI', varInteger);
  strFieldPreve := 'ITE_PREVE';
  strNewFieldPreve := 'ITE_PREVE';

  fltPreve1 := 0;
  fltPreve2 := 0;
  fltPreve3 := 0;
  fltPreve4 := 0;
  fltPreve5 := 0;
  fltPreve6 := 0;
  fltPreve7 := 0;

  fltNewPreve1 := 0;
  fltNewPreve2 := 0;
  fltNewPreve3 := 0;
  fltNewPreve4 := 0;
  fltNewPreve5 := 0;
  fltNewPreve6 := 0;
  fltNewPreve7 := 0;

  FfltVariacaoPreve1 := 0;
  FfltVariacaoPreve2 := 0;
  FfltVariacaoPreve3 := 0;
  FfltVariacaoPreve4 := 0;
  FfltVariacaoPreve5 := 0;
  FfltVariacaoPreve6 := 0;
  FfltVariacaoPreve7 := 0;
  fltLimite := fCfgSis('PCPRVE', varInteger);
  blnBloqueia := fltLimite > 0;
  objLiberacao := TLiberacaoFactory.fGetLiberacao;
End;

destructor TCalculaVariacaoPreco.Destroy;
begin
  If Assigned(objLiberacao) Then
    objLiberacao.Clear;
end;

function TCalculaVariacaoPreco.fRetNewPreve(intTabPreco: Integer): Double;
begin
  case intTabPreco Of
   1:  Result := fltNewPreve1;
   2:  Result := fltNewPreve2;
   3:  Result := fltNewPreve3;
   4:  Result := fltNewPreve4;
   5:  Result := fltNewPreve5;
   6:  Result := fltNewPreve6;
   7:  Result := fltNewPreve7;
   Else Result := 0;
  end;
end;

function TCalculaVariacaoPreco.fRetPreve(intTabPreco: Integer): Double;
begin
  case intTabPreco Of
   1:  Result := fltPreve1;
   2:  Result := fltPreve2;
   3:  Result := fltPreve3;
   4:  Result := fltPreve4;
   5:  Result := fltPreve5;
   6:  Result := fltPreve6;
   7:  Result := fltPreve7;
   Else Result := 0;
  end;

end;

function TCalculaVariacaoPreco.fRetVariacao(intTabPreco: Integer): Double;
begin
  case intTabPreco Of
   1:  Result := FfltVariacaoPreve1;
   2:  Result := FfltVariacaoPreve2;
   3:  Result := FfltVariacaoPreve3;
   4:  Result := FfltVariacaoPreve4;
   5:  Result := FfltVariacaoPreve5;
   6:  Result := FfltVariacaoPreve6;
   7:  Result := FfltVariacaoPreve7;
   Else Result := 0;
  end;
end;

function TCalculaVariacaoPreco.fRetTeveVariacaoMaior(intTabPreco: Integer): Boolean;
begin
  case intTabPreco Of
   1:  Result := fltLimite < FfltVariacaoPreve1;
   2:  Result := fltLimite < FfltVariacaoPreve2;
   3:  Result := fltLimite < FfltVariacaoPreve3;
   4:  Result := fltLimite < FfltVariacaoPreve4;
   5:  Result := fltLimite < FfltVariacaoPreve5;
   6:  Result := fltLimite < FfltVariacaoPreve6;
   7:  Result := fltLimite < FfltVariacaoPreve7;
   Else Result := False;
  end;
End;

function TCalculaVariacaoPreco.fTabelaAcimaDoPermitidoIndividual(fltValidacao: Double): Boolean;
begin
  if blnTemTabelaAcimaDoPermitido Then
    Exit(blnTemTabelaAcimaDoPermitido);


  Result :=  fltLimite < fltValidacao;

End;

procedure TCalculaVariacaoPreco.pEscreve(intTabPre: Integer; objTabela : TRegistroMsgLiberaTabela; objLinha  : TLinhaMsgLibera);
begin
  If VS_strTabPrc[intTabPre] = 'S' Then
  Begin
    If fRetTeveVariacaoMaior(intTabPre) Then
    Begin
      blnGerouTrava := True;
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('COD.'          , strCodIte                          ,7 ,alEsquerda);
      objLinha.pAddColuna('DESCRICAO'     , strDesIte                          ,55,alEsquerda);
      objLinha.pAddColuna('UN'            , fRetSiglaUni(strSigUni)            ,6 ,alCentro  );
      objLinha.pAddColuna('TAB'           , IntToStr(intTabPre)                ,5 ,alCentro  );
      objLinha.pAddColuna('PR.VENDA ATUAL', FormatFloat(fMskDigitos(intDecUni),fRetPreve(intTabPre)) ,14,alDireita );
      objLinha.pAddColuna('NOVO PR.VENDA' , FormatFloat(fMskDigitos(intDecUni), fRetNewPreve(intTabPre)),14,alDireita );
      objLinha.pAddColuna('VARIACAO'      , FormatFloat('#0.00', (fRetVariacao(intTabPre))) + '%',11 ,alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;
  End;
end;

function TCalculaVariacaoPreco.fProcessaQryPrg(pgbProgresso: TcxProgressBar): Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  intTabPre : integer;
Begin
  Result := True;
  blnGerouTrava := False;
  pgbProgresso.Properties.Max := FDataSet.RecordCount -1;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Alteração do Preço de Venda Com variação muito elevada.');
  objLiberacao.objMsgLibera.pAddTexto('Será necessário liberação para continuar.');

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;

  objLinha.pAddColuna('', 'COD.'          , 7  , alEsquerda, teAutcom);
  objLinha.pAddColuna('', 'DESCRICAO'     , 55 , alEsquerda, teAutcom);
  objLinha.pAddColuna('', 'UN'            , 4  , alCentro  , teAutcom);
  objLinha.pAddColuna('', 'TAB'           , 5  , alCentro  , teAutcom);
  objLinha.pAddColuna('', 'PR.VENDA ATUAL', 14 , alDireita , teAutcom);
  objLinha.pAddColuna('', 'NOVO PR.VENDA' , 14 , alDireita , teAutcom);
  objLinha.pAddColuna('', 'VARIACAO'      , 11  , alDireita , teAutcom);
  objTabela.lstLinhas.Add(objLinha);
  FDataSet.First;

  While not FDataSet.Eof Do
  Begin
    strCodite := FDataSet.FieldByName('ITE_CODITE').AsString;
    strDesIte := FDataSet.FieldByName('ITE_DESITE').AsString;
    If FDataSet.FieldByName('ITE_CODUNI_NOV').AsString <> '' Then
      strSigUni := fRetSiglaUni(FDataSet.FieldByName('ITE_CODUNI_NOV').AsString)
    Else
      strSigUni := fRetSiglaUni(FDataSet.FieldByName('ITE_CODUNI').AsString);
    fltPreve1 := FDataSet.FieldByName(strFieldPreve + '1').AsFloat;
    fltPreve2 := FDataSet.FieldByName(strFieldPreve + '2').AsFloat;
    fltPreve3 := FDataSet.FieldByName(strFieldPreve + '3').AsFloat;
    fltPreve4 := FDataSet.FieldByName(strFieldPreve + '4').AsFloat;
    fltPreve5 := FDataSet.FieldByName(strFieldPreve + '5').AsFloat;
    fltPreve6 := FDataSet.FieldByName(strFieldPreve + '6').AsFloat;
    fltPreve7 := FDataSet.FieldByName(strFieldPreve + '7').AsFloat;

    fltNewPreve1 := FDataSet.FieldByName(strNewFieldPreve + '1_NOV').AsFloat;
    fltNewPreve2 := FDataSet.FieldByName(strNewFieldPreve + '2_NOV').AsFloat;
    fltNewPreve3 := FDataSet.FieldByName(strNewFieldPreve + '3_NOV').AsFloat;
    fltNewPreve4 := FDataSet.FieldByName(strNewFieldPreve + '4_NOV').AsFloat;
    fltNewPreve5 := FDataSet.FieldByName(strNewFieldPreve + '5_NOV').AsFloat;
    fltNewPreve6 := FDataSet.FieldByName(strNewFieldPreve + '6_NOV').AsFloat;
    fltNewPreve7 := FDataSet.FieldByName(strNewFieldPreve + '7_NOV').AsFloat;

    pProcessaVariacao;

    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      pEscreve(intTabPre, objTabela, objLinha);
    End;

    FDataSet.Next;
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'VARPRE';
  objLiberacao.strMsgSen := 'Libereção para alteração do preço de venda acima do permitido';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

End;


function TCalculaVariacaoPreco.fTravaUnitario: Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  intTabPre : integer;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Alteração do Preço de Venda Com variação muito elevada.');
  objLiberacao.objMsgLibera.pAddTexto('Será necessário liberação para continuar.');

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;

  objLinha.pAddColuna('', 'COD.'          , 7   , alEsquerda, teAutcom);
  objLinha.pAddColuna('', 'DESCRICAO'     , 55  , alEsquerda, teAutcom);
  objLinha.pAddColuna('', 'UN'            , 4   , alCentro, teAutcom);
  objLinha.pAddColuna('', 'TAB'           , 5   , alCentro  , teAutcom);
  objLinha.pAddColuna('', 'PR.VENDA ATUAL', 14  , alDireita , teAutcom);
  objLinha.pAddColuna('', 'NOVO PR.VENDA' , 14  , alDireita , teAutcom);
  objLinha.pAddColuna('', 'VARIACAO'      , 11   , alDireita , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    pEscreve(intTabPre, objTabela, objLinha);
  End;


  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'VARPRE';
  objLiberacao.strMsgSen := 'Libereção para alteração do preço de venda acima do permitido';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  result := objLiberacao.fLibera;

  objLiberacao.Clear;

end;

procedure TCalculaVariacaoPreco.pSetaIndex(var strIndex: String);
Begin
  strIndex := '';

  If FDataSet is TClientDataSet Then
  Begin
    strIndex:= TClientDataSet(FDataSet).IndexFieldNames;
    TClientDataSet(FDataSet).IndexFieldNames := 'ITE_CODITE';
  End;

  If FDataSet is TUniQuery Then
    TUniQuery(FDataSet).IndexFieldNames := 'ITE_CODITE';
End;


procedure TCalculaVariacaoPreco.pSetaIndexAntigo(strIndex: string);
begin
  If strIndex <> '' Then
    TClientDataSet(FDataSet).IndexFieldNames := strIndex;
end;

function TCalculaVariacaoPreco.fTravaPrecosForaPermitido(DataSet: TDataSet): Boolean;
var frmGravando: TfrmGravando;
    strIndex: String;
begin
  If Not blnBloqueia Then
    Exit(True);

  FDataSet := DataSet;
  pSetaIndex(strIndex);


  pCriarFormularios(TfrmGravando, frmGravando);
  Try

    frmGravando.fExecutarAcao := fProcessaQryPrg;
    frmGravando.lblGravando.Caption := 'Aguarde, Verificando preço de venda dentro do permitido';
    frmGravando.ShowModal;
    If blnGerouTrava Then
      Result := objLiberacao.fLibera
    Else
      Result := True;
    objLiberacao.Clear;

    blnGerouTrava := False;
  Finally
    FreeAndNil(frmGravando);
    pSetaIndexAntigo(strIndex);
  End
End;

procedure TCalculaVariacaoPreco.pProcessaTemTabelaAcimaDoPermitido;
var
  intTabPre: Integer;
begin
  blnTemTabelaAcimaDoPermitido := False;
  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intTabPre] = 'S' Then
    Begin
      case intTabPre Of
       1:  blnTemTabelaAcimaDoPermitido := fTabelaAcimaDoPermitidoIndividual(FfltVariacaoPreve1);
       2:  blnTemTabelaAcimaDoPermitido := fTabelaAcimaDoPermitidoIndividual(FfltVariacaoPreve2);
       3:  blnTemTabelaAcimaDoPermitido := fTabelaAcimaDoPermitidoIndividual(FfltVariacaoPreve3);
       4:  blnTemTabelaAcimaDoPermitido := fTabelaAcimaDoPermitidoIndividual(FfltVariacaoPreve4);
       5:  blnTemTabelaAcimaDoPermitido := fTabelaAcimaDoPermitidoIndividual(FfltVariacaoPreve5);
       6:  blnTemTabelaAcimaDoPermitido := fTabelaAcimaDoPermitidoIndividual(FfltVariacaoPreve6);
       7:  blnTemTabelaAcimaDoPermitido := fTabelaAcimaDoPermitidoIndividual(FfltVariacaoPreve7);
      end;
    End;
  End;
end;

procedure TCalculaVariacaoPreco.pProcessaVariacao;
var
  intTabPre: Integer;
begin
  blnTemTabelaAcimaDoPermitido := False;

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intTabPre] = 'S' Then
    Begin
      case intTabPre Of
        1: fltVariacaoPreve1 := ABS((fltNewPreve1/fltPreve1 -1) * 100);
        2: fltVariacaoPreve2 := ABS((fltNewPreve2/fltPreve2 -1) * 100);
        3: fltVariacaoPreve3 := ABS((fltNewPreve3/fltPreve3 -1) * 100);
        4: fltVariacaoPreve4 := ABS((fltNewPreve4/fltPreve4 -1) * 100);
        5: fltVariacaoPreve5 := ABS((fltNewPreve5/fltPreve5 -1) * 100);
        6: fltVariacaoPreve6 := ABS((fltNewPreve6/fltPreve6 -1) * 100);
        7: fltVariacaoPreve7 := ABS((fltNewPreve7/fltPreve7 -1) * 100);
      End;
    End;
  end;

  pProcessaTemTabelaAcimaDoPermitido
end;


end.



