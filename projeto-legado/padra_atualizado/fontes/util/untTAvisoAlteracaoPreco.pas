unit untTAvisoAlteracaoPreco;

interface

uses
  untFuncoesSimples, Uni, UniClientDataSet, DB, Forms, Windows, Dialogs, SysUtils, StrUtils,
  untItensAvisoAlteracaoPreco, Vcl.Controls, untGravando, cxProgressBar,
  System.Classes;

Type
  TTipoAlteracaoPreco = (tpCadPro, tpAltGlb, tpAltInd, tpEntMer, tpLotPre);

  TRecPrecos = record
    fltPreVe1: Double;
    fltPreVe2: Double;
    fltPreVe3: Double;
    fltPreVe4: Double;
    fltPreVe5: Double;
    fltPreVe6: Double;
    fltPreVe7: Double;
    fltPreCus_: Double;
  End;

  TRecDadosProd = record
   strCodIte: String;
   strDesIte: String;
   strCodUni: String;
  End;

  TAvisoAlteracaoPreco = Class
  Private
    cdsItens: TUniClientDataSet;
    fltPctPrc: Double;

    function fCriaCds: Boolean;
    function fCriaFormItens: Boolean;

    // ** ALTERAÇÃO GLOBAL **
    function fCalcularAltGlbAux(pgbProgresso: TcxProgressBar): Boolean;
    function fGetFiltroCdsAltGlb: String;
    // ** END ALTERAÇÃO GLOBAL **

    // ** ALTERAÇÃO INDIVIDUAL **
    function fCalcularAltIndAux(pgbProgresso: TcxProgressBar): Boolean;
    function fGetFiltroCdsAltInd: String;
    // ** END ALTERAÇÃO INDIVIDUAL **

    // ** LOTE DE PREÇOS **
    function fCalcularLotPreAux(pgbProgresso: TcxProgressBar): Boolean;
    function fGetFiltroLotPre: String;
    // ** END LOTE DE PREÇOS **

    // ** ENTRADA DE MERCADORIAS **
    function fCalcularEntMerAux(pgbProgresso: TcxProgressBar): Boolean;
    function fGetFiltroEntMer: String;

    // ** END ENTRADA DE MERCADORIAS **

    // ** CADASTRO DE PRODUTOS **
    function fCalcularCadProAux(pgbProgresso: TcxProgressBar): Boolean;
    function fRetPreVenOld(intTabPreco: Integer): Double;
    function fRetPreVenAtual(intTabPreco: Integer): Double;
    function fRetValMaxCusto: Double;
    function fRetValMaxVenda(intTabPreco: Integer): Double;
    function fRetValMinVenda(intTabPreco: Integer): Double;
    function fRetValMinCusto: Double;
    function fVariacaoMaiorMenorCusto: Boolean;
    function fVariacaoMaiorMenorVenda(intTabPreco: Integer): Boolean;
    // ** END CADASTRO DE PRODUTOS **

    function fCalcular(tpAltPreco: TTipoAlteracaoPreco): Boolean;

  Public
    recDadosProd: TRecDadosProd;
    recPrecosProd,
    recPrecosProdOld: TRecPrecos;

    //FarrPrecosEntMer: TarrPrecos;

    FcdsDados: TDataSet;
    FlstMarcadosEfetivacao: TStringList;

    Constructor Create;
    Destructor Destroy; override;
    function fCriaCdsPrecosEntMer: TDataSet;
    function fVerificaOscilacao(tpAltPreco: TTipoAlteracaoPreco) : Boolean;
  End;

implementation

{ TAvisoAlteracaoPreco }

constructor TAvisoAlteracaoPreco.Create;
begin
  fCriaCds;
  fltPctPrc := fCfgSis('PCTPRC', varDouble);
end;

destructor TAvisoAlteracaoPreco.Destroy;
begin
  If Assigned(cdsItens) Then
    FreeAndNil(cdsItens);

  inherited;
end;

function TAvisoAlteracaoPreco.fGetFiltroCdsAltInd: String;
var
  intTab: Integer;
begin
  Result := 'ITE_PRECUS_VAR > 0';
   For intTab := 1 To Length(VS_strTabPrc) Do
   Begin
    If VS_strTabPrc[intTab] = 'S' Then
      Result := Result + ' OR ITE_PREVE'+IntToStr(intTab)+'_VAR > 0';
   End;
end;

function TAvisoAlteracaoPreco.fGetFiltroEntMer: String;
var
  intTab: Integer;
begin
  Result := 'ITE_CUSVAR > 0';
   For intTab := 1 To Length(VS_strTabPrc) Do
   Begin
    If VS_strTabPrc[intTab] = 'S' Then
      Result := Result + ' OR ITE_PREVAR'+IntToStr(intTab)+' > 0';
   End;
end;

function TAvisoAlteracaoPreco.fGetFiltroLotPre: String;
var
  intTab: Integer;
begin
  Result := 'DIFCUS > 0';
   For intTab := 1 To Length(VS_strTabPrc) Do
   Begin
    If VS_strTabPrc[intTab] = 'S' Then
      Result := Result + ' OR DIFPR'+IntToStr(intTab)+' > 0';
   End;
end;

function TAvisoAlteracaoPreco.fCalcularAltIndAux(pgbProgresso: TcxProgressBar): Boolean;
var
  intTab: Integer;
begin
  Result := False;
  FcdsDados.Filter := fGetFiltroCdsAltInd;
  FcdsDados.Filtered := True;
  FcdsDados.First;

  If FcdsDados.IsEmpty Then
  Begin
    FcdsDados.Filtered := False;
    Exit(False);
  End;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := FcdsDados.RecordCount;

  While Not FcdsDados.Eof Do
  Begin
    cdsItens.Insert;
    cdsItens.FieldByName('CODITE').AsString := FcdsDados.FieldByName('ITE_CODITE').AsString;
    cdsItens.FieldByName('DESITE').AsString := FcdsDados.FieldByName('ITE_DESITE').AsString;
    cdsItens.FieldByName('CODUNI').AsString := FcdsDados.FieldByName('ITE_CODUNI').AsString;

    cdsItens.FieldByName('CUSANT').AsFloat := FcdsDados.FieldByName('ITE_PRECUS').AsFloat;
    cdsItens.FieldByName('CUSNOV').AsFloat := FcdsDados.FieldByName('ITE_PRECUS_NOV').AsFloat;
    If cdsItens.FieldByName('CUSANT').AsFloat > 0 Then
      cdsItens.FieldByName('CUSVAR').AsFloat := FcdsDados.FieldByName('ITE_PRECUS_VAR').AsFloat;

    For intTab := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intTab] = 'S' Then
      Begin
        cdsItens.FieldByName('VENANT'+intTab.ToString).AsFloat := FcdsDados.FieldByName('ITE_PREVE'+intTab.toString).AsFloat;
        cdsItens.FieldByName('VENNOV'+intTab.ToString).AsFloat := FcdsDados.FieldByName('ITE_PREVE'+intTab.toString+'_NOV').AsFloat;
        If cdsItens.FieldByName('VENANT'+intTab.ToString).AsFloat > 0 Then
          cdsItens.FieldByName('VENVAR'+intTab.ToString).AsFloat :=  ABS((((cdsItens.FieldByName('VENNOV'+intTab.toString).AsFloat / cdsItens.FieldByName('VENANT'+intTab.toString).AsFloat)) -1) * 100.00);
      End;
    End;

    cdsItens.Post;
    Result := True;
    FcdsDados.Next;
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  cdsItens.First;
  FcdsDados.Filtered := False;

end;

function TAvisoAlteracaoPreco.fGetFiltroCdsAltGlb: String;
var
  intTab: Integer;
begin
  Result := 'ITE_CUSVAR > 0';
   For intTab := 1 To Length(VS_strTabPrc) Do
   Begin
    If VS_strTabPrc[intTab] = 'S' Then
      Result := Result + ' OR ITE_VENVAR'+IntToStr(intTab)+' > 0';
   End;
end;

function TAvisoAlteracaoPreco.fCalcularAltGlbAux(
  pgbProgresso: TcxProgressBar): Boolean;
var
  intTab: Integer;
begin
  Result := False;
  FcdsDados.Filter := 'ITE_MARDES = '+QuotedStr('M')+ ' AND (' + fGetFiltroCdsAltGlb + ')';
  FcdsDados.Filtered := True;
  FcdsDados.First;

  If FcdsDados.IsEmpty Then
  Begin
    FcdsDados.Filtered := False;
    Exit(False);
  End;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := FcdsDados.RecordCount;

  While Not FcdsDados.Eof Do
  Begin
    cdsItens.Insert;
    cdsItens.FieldByName('CODITE').AsString := FcdsDados.FieldByName('ITE_CODITE').AsString;
    cdsItens.FieldByName('DESITE').AsString := FcdsDados.FieldByName('ITE_DESITE').AsString;
    cdsItens.FieldByName('CODUNI').AsString := FcdsDados.FieldByName('ITE_CODUNI').AsString;

    cdsItens.FieldByName('CUSANT').AsFloat := FcdsDados.FieldByName('ITE_PRECUS').AsFloat;
    cdsItens.FieldByName('CUSNOV').AsFloat := FcdsDados.FieldByName('ITE_PRECUS_NOV').AsFloat;
    cdsItens.FieldByName('CUSVAR').AsFloat := FcdsDados.FieldByName('ITE_CUSVAR').AsFloat;

    For intTab := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intTab] = 'S' Then
      Begin
        cdsItens.FieldByName('VENANT'+intTab.ToString).AsFloat := FcdsDados.FieldByName('ITE_PREVE'+intTab.toString).AsFloat;
        cdsItens.FieldByName('VENNOV'+intTab.ToString).AsFloat := FcdsDados.FieldByName('ITE_PREVE'+intTab.toString+'_NOV').AsFloat;
        If cdsItens.FieldByName('VENANT'+intTab.ToString).AsFloat > 0 Then
          cdsItens.FieldByName('VENVAR'+intTab.ToString).AsFloat := ABS((((cdsItens.FieldByName('VENNOV'+intTab.toString).AsFloat / cdsItens.FieldByName('VENANT'+intTab.toString).AsFloat)) -1) * 100.00);
      End;
    End;

    cdsItens.Post;
    Result := True;
    FcdsDados.Next;
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  cdsItens.First;

  FcdsDados.Filtered := False;
end;


function TAvisoAlteracaoPreco.fCalcularEntMerAux(
  pgbProgresso: TcxProgressBar): Boolean;
var
 intTab: Integer;
begin
  Result := False;
  FcdsDados.Filter   := fGetFiltroEntMer;
  FcdsDados.Filtered := True;
  FcdsDados.First;

  If FcdsDados.IsEmpty Then
  Begin
    FcdsDados.Filtered := False;
    Exit(False);
  End;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := FcdsDados.RecordCount;

  While Not FcdsDados.Eof Do
  Begin
    cdsItens.Insert;
    cdsItens.FieldByName('CODITE').AsString := FcdsDados.FieldByName('ITE_CODITE').AsString;
    cdsItens.FieldByName('DESITE').AsString := FcdsDados.FieldByName('ITE_DESITE').AsString;
    cdsItens.FieldByName('CODUNI').AsString := FcdsDados.FieldByName('ITE_CODUNI').AsString;

    cdsItens.FieldByName('CUSANT').AsFloat := FcdsDados.FieldByName('ITE_CUSANT').AsFloat;
    cdsItens.FieldByName('CUSNOV').AsFloat := FcdsDados.FieldByName('ITE_CUSNOV').AsFloat;
    cdsItens.FieldByName('CUSVAR').AsFloat := FcdsDados.FieldByName('ITE_CUSVAR').AsFloat;

    For intTab := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intTab] = 'S' Then
      Begin
        cdsItens.FieldByName('VENANT'+intTab.ToString).AsFloat := FcdsDados.FieldByName('ITE_PREANT'+intTab.toString).AsFloat;
        cdsItens.FieldByName('VENNOV'+intTab.ToString).AsFloat := FcdsDados.FieldByName('ITE_PRENOV'+intTab.toString).AsFloat;
        cdsItens.FieldByName('VENVAR'+intTab.ToString).AsFloat := FcdsDados.FieldByName('ITE_PREVAR'+intTab.toString).AsFloat;
      End;
    End;

    cdsItens.Post;
    Result := True;
    FcdsDados.Next;
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  cdsItens.First;

  FcdsDados.Filtered := False;

end;

function TAvisoAlteracaoPreco.fRetValMaxVenda(intTabPreco: Integer): Double;
begin
  case intTabPreco Of
   1:  Result := recPrecosProdOld.fltPreVe1 + recPrecosProdOld.fltPreVe1  * (fltPctPrc / 100.0);
   2:  Result := recPrecosProdOld.fltPreVe2 + recPrecosProdOld.fltPreVe2  * (fltPctPrc / 100.0);
   3:  Result := recPrecosProdOld.fltPreVe3 + recPrecosProdOld.fltPreVe3  * (fltPctPrc / 100.0);
   4:  Result := recPrecosProdOld.fltPreVe4 + recPrecosProdOld.fltPreVe4  * (fltPctPrc / 100.0);
   5:  Result := recPrecosProdOld.fltPreVe5 + recPrecosProdOld.fltPreVe5  * (fltPctPrc / 100.0);
   6:  Result := recPrecosProdOld.fltPreVe6 + recPrecosProdOld.fltPreVe6  * (fltPctPrc / 100.0);
   7:  Result := recPrecosProdOld.fltPreVe7 + recPrecosProdOld.fltPreVe7  * (fltPctPrc / 100.0);
   Else Result := 0;
  end;
end;


function TAvisoAlteracaoPreco.fRetValMaxCusto: Double;
begin
  Result := recPrecosProdOld.fltPreCus_ + (recPrecosProdOld.fltPreCus_ * (fltPctPrc / 100.0));
end;


function TAvisoAlteracaoPreco.fRetValMinCusto: Double;
begin
  Result := recPrecosProdOld.fltPreCus_ - (recPrecosProdOld.fltPreCus_ * (fltPctPrc / 100.0));
end;

function TAvisoAlteracaoPreco.fRetPreVenOld(intTabPreco: Integer): Double;
begin
  case intTabPreco Of
   1:  Result := recPrecosProdOld.fltPreVe1;
   2:  Result := recPrecosProdOld.fltPreVe2;
   3:  Result := recPrecosProdOld.fltPreVe3;
   4:  Result := recPrecosProdOld.fltPreVe4;
   5:  Result := recPrecosProdOld.fltPreVe5;
   6:  Result := recPrecosProdOld.fltPreVe6;
   7:  Result := recPrecosProdOld.fltPreVe7;
   Else Result := 0;
  end;
end;

function TAvisoAlteracaoPreco.fRetPreVenAtual(intTabPreco: Integer): Double;
begin
  case intTabPreco Of
   1:  Result := recPrecosProd.fltPreVe1;
   2:  Result := recPrecosProd.fltPreVe2;
   3:  Result := recPrecosProd.fltPreVe3;
   4:  Result := recPrecosProd.fltPreVe4;
   5:  Result := recPrecosProd.fltPreVe5;
   6:  Result := recPrecosProd.fltPreVe6;
   7:  Result := recPrecosProd.fltPreVe7;
   Else Result := 0;
  end;
end;

function TAvisoAlteracaoPreco.fRetValMinVenda(intTabPreco: Integer): Double;
begin
  case intTabPreco Of
   1:  Result := recPrecosProdOld.fltPreVe1 - recPrecosProdOld.fltPreVe1  * (fltPctPrc / 100.0);
   2:  Result := recPrecosProdOld.fltPreVe2 - recPrecosProdOld.fltPreVe2  * (fltPctPrc / 100.0);
   3:  Result := recPrecosProdOld.fltPreVe3 - recPrecosProdOld.fltPreVe3  * (fltPctPrc / 100.0);
   4:  Result := recPrecosProdOld.fltPreVe4 - recPrecosProdOld.fltPreVe4  * (fltPctPrc / 100.0);
   5:  Result := recPrecosProdOld.fltPreVe5 - recPrecosProdOld.fltPreVe5  * (fltPctPrc / 100.0);
   6:  Result := recPrecosProdOld.fltPreVe6 - recPrecosProdOld.fltPreVe6  * (fltPctPrc / 100.0);
   7:  Result := recPrecosProdOld.fltPreVe7 - recPrecosProdOld.fltPreVe7  * (fltPctPrc / 100.0);
   Else Result := 0;
  end;
end;


function TAvisoAlteracaoPreco.fCalcularCadProAux(
  pgbProgresso: TcxProgressBar): Boolean;
var
  intTab: Integer;
begin

  If fltPctPrc = 0 Then
   Exit(False);

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := 100;

  cdsItens.Insert;
  cdsItens.FieldByName('CODITE').AsString := recDadosProd.strCodIte;
  cdsItens.FieldByName('DESITE').AsString  := recDadosProd.strDesIte;
  cdsItens.FieldByName('CODUNI').AsString  := recDadosProd.strCodUni;

  cdsItens.FieldByName('CUSANT').AsFloat := recPrecosProdOld.fltPreCus_;
  cdsItens.FieldByName('CUSNOV').AsFloat := recPrecosProd.fltPreCus_;
  If cdsItens.FieldByName('CUSANT').AsFloat > 0 Then
    cdsItens.FieldByName('CUSVAR').AsFloat := ABS(((cdsItens.FieldByName('CUSNOV').AsFloat /  cdsItens.FieldByName('CUSANT').AsFloat) -1) * 100.00);

  pgbProgresso.Position := 50;
  Application.ProcessMessages;

  Result :=   fVariacaoMaiorMenorCusto;

  For intTab := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intTab] = 'S' Then
    Begin
      cdsItens.FieldByName('VENANT'+intTab.toString).AsFloat := fRetPreVenOld(intTab);
      cdsItens.FieldByName('VENNOV'+intTab.toString).AsFloat := fRetPreVenAtual(intTab);
      If cdsItens.FieldByName('VENANT'+intTab.toString).AsFloat > 0 Then
        cdsItens.FieldByName('VENVAR'+intTab.toString).AsFloat := ABS((((cdsItens.FieldByName('VENNOV'+intTab.toString).AsFloat / cdsItens.FieldByName('VENANT'+intTab.toString).AsFloat)) -1) * 100.00);

      If Not Result then
        Result :=  fVariacaoMaiorMenorVenda(intTab);
      cdsItens.Post;
      cdsItens.Edit;
    End;
  End;

  pgbProgresso.Position := 100;
  Application.ProcessMessages;

  If cdsItens.State = dsEdit Then
    cdsItens.Post;

end;

function TAvisoAlteracaoPreco.fCalcularLotPreAux(
  pgbProgresso: TcxProgressBar): Boolean;
var
  intTab: Integer;
begin
  Result := False;
  FcdsDados.Filter := fGetFiltroLotPre;
  FcdsDados.Filtered := True;
  FcdsDados.First;

  If FcdsDados.IsEmpty Then
  Begin
    FcdsDados.Filtered := False;
    Exit(False);
  End;

  If FlstMarcadosEfetivacao.Count = 0 Then
  Begin
    Exit(False);
  End;

  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := FcdsDados.RecordCount;

  While Not FcdsDados.Eof Do
  Begin
    If FlstMarcadosEfetivacao.IndexOf(QuotedStr(FcdsDados.FieldByName('AUTOINCREM').AsString)) > -1 Then
    Begin
      cdsItens.Insert;
      cdsItens.FieldByName('CODITE').AsString := FcdsDados.FieldByName('ITE_CODITE').AsString;
      cdsItens.FieldByName('DESITE').AsString := FcdsDados.FieldByName('ITE_DESCRI').AsString;
      cdsItens.FieldByName('CODUNI').AsString := FcdsDados.FieldByName('ITE_SIGUNI').AsString;

      cdsItens.FieldByName('CUSANT').AsFloat := FcdsDados.FieldByName('LTP_PRECUS_ANT').AsFloat;
      cdsItens.FieldByName('CUSNOV').AsFloat := FcdsDados.FieldByName('LTP_PRECUS').AsFloat;
      cdsItens.FieldByName('CUSVAR').AsFloat := FcdsDados.FieldByName('DIFCUS').AsFloat;

      For intTab := 1 To Length(VS_strTabPrc) Do
      Begin
        If VS_strTabPrc[intTab] = 'S' Then
        Begin
          cdsItens.FieldByName('VENANT'+intTab.ToString).AsFloat := FcdsDados.FieldByName('LTP_PREVE'+intTab.toString+'_ANT').AsFloat;
          cdsItens.FieldByName('VENNOV'+intTab.ToString).AsFloat := FcdsDados.FieldByName('LTP_PREVE'+intTab.toString).AsFloat;
          cdsItens.FieldByName('VENVAR'+intTab.ToString).AsFloat := FcdsDados.FieldByName('DIFPR'+intTab.toString).AsFloat;
        End;
      End;

      cdsItens.Post;
      Result := True;
    End;

    FcdsDados.Next;
    pgbProgresso.Position := pgbProgresso.Position + 1;
    Application.ProcessMessages;
  End;

  cdsItens.First;

  FcdsDados.Filtered := False;
end;

function TAvisoAlteracaoPreco.fCriaCds: Boolean;
var
  intTab: Integer;
begin
  Result := False;
  Try
    cdsItens := TUniClientDataSet.Create(Nil);

    cdsItens.FieldDefs.Add('CODITE', ftString, fTamCodIte, True);
    cdsItens.FieldDefs.Add('DESITE', ftString, 50, True);
    cdsItens.FieldDefs.Add('CODUNI', ftString, 2, True);

    cdsItens.FieldDefs.Add('CUSANT', ftFloat);
    cdsItens.FieldDefs.Add('CUSNOV', ftFloat);
    cdsItens.FieldDefs.Add('CUSVAR', ftFloat);

    For intTab := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intTab] = 'S' Then
      Begin
        cdsItens.FieldDefs.Add('VENANT'+intTab.toString, ftFloat);
        cdsItens.FieldDefs.Add('VENNOV'+intTab.toString, ftFloat);
        cdsItens.FieldDefs.Add('VENVAR'+intTab.toString, ftFloat);
      End;
    End;

    cdsItens.CreateDataSet;
    cdsItens.LogChanges := False;
    cdsItens.IndexFieldNames := 'DESITE';
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TAvisoAlteracaoPreco.fCriaCds]');
    End;
  End;
end;

function TAvisoAlteracaoPreco.fCriaCdsPrecosEntMer: TDataSet;
var
  intTab: Integer;
  cdsPrecosEntMer: TUniClientDataSet;
begin
  Try
    cdsPrecosEntMer := TUniClientDataSet.Create(Nil);

    cdsPrecosEntMer.FieldDefs.Add('ITE_CODITE', ftString, fTamCodIte, True);
    cdsPrecosEntMer.FieldDefs.Add('ITE_DESITE', ftString, 50, True);
    cdsPrecosEntMer.FieldDefs.Add('ITE_CODUNI', ftString, 2, True);

    cdsPrecosEntMer.FieldDefs.Add('ITE_CUSANT', ftFloat);
    cdsPrecosEntMer.FieldDefs.Add('ITE_CUSNOV', ftFloat);
    cdsPrecosEntMer.FieldDefs.Add('ITE_CUSVAR', ftFloat);

    For intTab := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intTab] = 'S' Then
      Begin
        cdsPrecosEntMer.FieldDefs.Add('ITE_PREANT'+intTab.toString, ftFloat);
        cdsPrecosEntMer.FieldDefs.Add('ITE_PRENOV'+intTab.toString, ftFloat);
        cdsPrecosEntMer.FieldDefs.Add('ITE_PREVAR'+intTab.toString, ftFloat);
      End;
    End;

    cdsPrecosEntMer.CreateDataSet;
    cdsPrecosEntMer.LogChanges := False;
    cdsPrecosEntMer.IndexFieldNames := 'ITE_CODITE';

    Result := cdsPrecosEntMer;

  Except On
    E:Exception Do
    Begin
      pMensagensErro(E.Message, '[TAvisoAlteracaoPreco.fCriaCdsPrecosEntMer]');
      Result := Nil;
    End;
  End;


end;

function TAvisoAlteracaoPreco.fVariacaoMaiorMenorVenda(
  intTabPreco: Integer): Boolean;
begin
  Result := False;

  If fRetPreVenAtual(intTabPreco) > fRetValMaxVenda(intTabPreco) Then
    Exit(True);

  If fRetPreVenAtual(intTabPreco) < fRetValMinVenda(intTabPreco) Then
    Exit(True);
end;

function TAvisoAlteracaoPreco.fVariacaoMaiorMenorCusto: Boolean;
begin
  Result := False;

  If recPrecosProd.fltPreCus_ > fRetValMaxCusto Then
    Exit(True);

  If recPrecosProd.fltPreCus_ < fRetValMinCusto Then
    Exit(True);
end;

function TAvisoAlteracaoPreco.fVerificaOscilacao(
  tpAltPreco: TTipoAlteracaoPreco): Boolean;
begin
  cdsItens.EmptyDataSet;

  // True = Houve variação maior/menor que o permitido (cdsItens populado!)
  Result := fCalcular(tpAltPreco);

  // Result = False = Sem qualquer alteração que infringe a regra da CFG_PCTPRC
  If Result Then
    Result := fCriaFormItens
  Else
    Result := True;
end;

function TAvisoAlteracaoPreco.fCalcular(tpAltPreco: TTipoAlteracaoPreco): Boolean;
begin
  Result := False;
  Case tpAltPreco Of
    tpCadPro: Result := TfrmGravando.fExecuta(fCalcularCadProAux, frmGravando, 'Verificando alterações de preço...');
    tpAltGlb: Result := TfrmGravando.fExecuta(fCalcularAltGlbAux, frmGravando, 'Verificando alterações de preço...');
    tpAltInd: Result := TfrmGravando.fExecuta(fCalcularAltIndAux, frmGravando, 'Verificando alterações de preço...');
    tpEntMer: Result := TfrmGravando.fExecuta(fCalcularEntMerAux, frmGravando, 'Verificando alterações de preço...');
    tpLotPre: Result := TfrmGravando.fExecuta(fCalcularLotPreAux, frmGravando, 'Verificando alterações de preço...');
  End;
end;

function TAvisoAlteracaoPreco.fCriaFormItens: Boolean;
begin
  Try
    pCriarFormularios(TfrmItensAvisoAlteracaoPreco, frmItensAvisoAlteracaoPreco);
    frmItensAvisoAlteracaoPreco.dtsItens.DataSet := cdsItens;
    frmItensAvisoAlteracaoPreco.ShowModal;
  Finally
    Result := frmItensAvisoAlteracaoPreco.blnConfirma;
    FreeAndNil(frmItensAvisoAlteracaoPreco);
  End;
end;


end.
