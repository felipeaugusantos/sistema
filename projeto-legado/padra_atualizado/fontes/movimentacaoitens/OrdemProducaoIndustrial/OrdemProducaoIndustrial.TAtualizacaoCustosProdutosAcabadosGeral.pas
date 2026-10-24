unit OrdemProducaoIndustrial.TAtualizacaoCustosProdutosAcabadosGeral;

interface

uses
  Classes,
  Data.DB,
  SysUtils,
  untZClient,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  untCalculoPrecoVenda,
{$ELSE }
  Uni,
  Vcl.Forms,
  cxProgressBar,

  untGravando,
  untFuncoesSimples,
{$ENDIF LINUX}
  untTConfiguracao,
  untPreAlt_Trigger,
  untParCalculaPrecoCusto,
  untPreAlt,
  OrdemProducaoIndustrial.TFiltroProduto,
  OrdemProducaoIndustrial.TProdutoAcabado,
  OrdemProducaoIndustrial.Dados.TCarregaMateriaPrima,
  OrdemProducaoIndustrial.Dados.TCarregaProdutoAcabado,
  OrdemProducaoIndustrial.TOrdemProducao;

Type
  TAtualizacaoCustosProdutosAcabadosGeral = class
    private
    Const
      INTMAXPRECO = 7;
    Var
      FQueryFormulas         : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
      FCdsIteGer             : TZClient;
      FCdsPreAlt             : TZClient;
      FParams                : TParCalculaPrecoCusto;
      FCarregaMateriaPrima   : TCarregaMateriaPrima;
      FCarregaProdutoAcabado : TCarregaProdutoAcabado;

      strAgrupadorPreAlt: String;

      FFiltroProdutoGranel   : TFiltroProduto;
      FFiltroProdutoAcabado  : TFiltroProduto;
      FMargem                : boolean;

      procedure pSetTextoAguarde(strTexto: String);
      function fAtualizaIteGer(strCodigoProdutoAcabado: String; fltPrecoCompra: Double): Boolean;
      procedure pAbreQueryFormulas;
      procedure pAbreCdsIteGer(strCODIGO_PRODUTO, strCODIGO_COR: String);
      function fAtualizaCustosAguarde(prgProgresso: TcxProgressBar) : boolean;
      procedure pSetaNiveis;
      procedure pOrdenaAquisicaoLocksProInc;

    public
      property objFiltroProdutoGranel : TFiltroProduto  read FFiltroProdutoGranel  write FFiltroProdutoGranel;
      property objFiltroProdutoAcabado : TFiltroProduto read FFiltroProdutoAcabado write FFiltroProdutoAcabado;
      property blnMargem : boolean                      read FMargem               write FMargem;

      function ftemFiltro: Boolean;
      constructor Create;
      destructor Destroy; override;

      function fAtualizaCustos : boolean;
  End;

implementation

{ TAtualizacaoCustosProdutosAcabadosGeral }

constructor TAtualizacaoCustosProdutosAcabadosGeral.Create;
begin
  FQueryFormulas := fCriaQuery;
  FCdsIteGer     := TZClient.Create(nil);
  FCdsPreAlt     := TZClient.Create(nil);
  FParams        := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao, False);

  FFiltroProdutoGranel   := TFiltroProduto.Create;
  FFiltroProdutoAcabado  := TFiltroProduto.Create;
  FCarregaMateriaPrima   := TCarregaMateriaPrima.Create;
  FCarregaProdutoAcabado := TCarregaProdutoAcabado.Create;

  FCdsPreAlt.qryQuery.SQL.Text := 'SELECT * FROM PREALT WHERE FALSE';
  FCdsPreAlt.fAbreClient(True, 'TAtualizacaoCustosProdutosAcabadosGeral.Create');
end;

destructor TAtualizacaoCustosProdutosAcabadosGeral.Destroy;
begin
{$IFNDEF LINUX}
  FreeAndNil(FQueryFormulas);
{$ENDIF}
  FreeAndNil(FCdsIteGer);
  FreeAndNil(FCdsPreAlt);
  FreeAndNil(FParams);
  FreeAndNil(FFiltroProdutoGranel);
  FreeAndNil(FFiltroProdutoAcabado);
  FreeAndNil(FCarregaMateriaPrima);
  FreeAndNil(FCarregaProdutoAcabado);
  inherited;
end;

function TAtualizacaoCustosProdutosAcabadosGeral.ftemFiltro: Boolean;
Begin
  Result := (Not fEmptyStr(FFiltroProdutoGranel.strCodigo)) Or
    (Not fEmptyStr(FFiltroProdutoGranel.strLinhaGrupo)) Or
    (Not fEmptyStr(FFiltroProdutoGranel.strCodigoDepartamento)) Or
    (Not fEmptyStr(FFiltroProdutoGranel.strReferencia)) Or
    (Not fEmptyStr(FFiltroProdutoAcabado.strCodigo)) Or
    (Not fEmptyStr(FFiltroProdutoAcabado.strLinhaGrupo)) Or
    (Not fEmptyStr(FFiltroProdutoAcabado.strLinhaGrupo)) Or
    (Not fEmptyStr(FFiltroProdutoAcabado.strReferencia));
End;


procedure TAtualizacaoCustosProdutosAcabadosGeral.pSetaNiveis;
begin
  If ftemFiltro Then
  Begin
    FQueryFormulas.SQL.Clear;
    FQueryFormulas.SQl.Add('CALL pCriaTemporariaNIVEL_CALC;');
    FQueryFormulas.ExecSQL;
  End
  Else
  Begin
    pSetTextoAguarde('Aguarde... Calculando Níveis das estruturas');
    FQueryFormulas.SQL.Clear;
    FQueryFormulas.SQl.Add('CALL pSetNivel("");');
    FQueryFormulas.ExecSQL;
    pSetTextoAguarde('Aguarde... Calculando custo dos produtos acabados.');
  End;
end;

procedure TAtualizacaoCustosProdutosAcabadosGeral.pSetTextoAguarde(strTexto: String);
begin
 {$IFNDEF LINUX}
  If Assigned(frmGravando) Then
  Begin
    frmGravando.lblGravando.Caption := strTexto;
    Application.ProcessMessages;
  End;
 {$ELSE}
  Writeln(DateTimeToStr(fNow) + ' - ' + strTexto);
 {$ENDIF}
end;

procedure TAtualizacaoCustosProdutosAcabadosGeral.pAbreCdsIteGer(strCODIGO_PRODUTO, strCODIGO_COR: String);
var
 i : integer;
begin
  FCdsIteGer.Close;
  FCdsIteGer.qryQuery.Close;
  FCdsIteGer.qryQuery.SQL.Clear;
  FCdsIteGer.qryQuery.SQL.Add('SELECT                                                                                                                 ');
  FCdsIteGer.qryQuery.SQL.Add('  ITEGER.AUTOINCREM,                                                                                                   ');
  FCdsIteGer.qryQuery.SQL.Add('  ITEGER.ITE_CODITE,                                                                                                   ');
  FCdsIteGer.qryQuery.SQL.Add('  ITEGER.ITE_CODEMP,                                                                                                   ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_PRECUS,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_PRECOM,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DESF01,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DESF02,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DESF03,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DESF04,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DESF05,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DESF06,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_ICMENT,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_IPIENT,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_FREENT,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_VALFRE,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_ACRFIN,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_SUBSTI,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DESADB,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_SUBFED,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_ICMSAI,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_IMPFED,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_PREALT,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DESOPE,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_OUTVAL,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_TCIFCU,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_TSCUST,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DEPICO,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_DEICMS,                                                                                                          ');
  FCdsIteGer.qryQuery.SQL.Add('  ITE_FATREG                                                                                                           ');

  For i := 1 To INTMAXPRECO Do
  Begin
    FCdsIteGer.qryQuery.SQL.Add('  ,ITE_PREVE' + IntToStr(i)                                                                                           );
    FCdsIteGer.qryQuery.SQL.Add('  ,ITE_MARBR' + IntToStr(i)                                                                                           );
    FCdsIteGer.qryQuery.SQL.Add('  ,ITE_COMTB' + IntToStr(i)                                                                                           );
  End;

  FCdsIteGer.qryQuery.SQL.Add('FROM                                                                                                                   ');
  FCdsIteGer.qryQuery.SQL.Add('  ITEGER                                                                                                               ');
  FCdsIteGer.qryQuery.SQL.Add('  INNER JOIN CADITE ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE                                                           ');
  FCdsIteGer.qryQuery.SQL.Add('   WHERE CADITE.ITE_CODPAG  = :CODPAG');
  FCdsIteGer.qryQuery.SQL.Add('     AND CADITE.ITE_CODCOR  = :CODCOR');
  FCdsIteGer.qryQuery.SQL.Add('                                              AND LOCATE(ITEGER.ITE_CODEMP, "' + fRetEmpresasUsamPrecoMatriz + '") > 0 ');


  FCdsIteGer.qryQuery.ParamByName('CODPAG').AsString := strCODIGO_PRODUTO;
  FCdsIteGer.qryQuery.ParamByName('CODCOR').AsString := strCODIGO_COR;



{  FCdsIteGer.qryQuery.SQL.Add('  INNER JOIN ('+ strSQLTBLFiltro +') TBLFILTRO ON TBLFILTRO.CODIGO_PRODUTO = CADITE.ITE_CODPAG                         ');
  FCdsIteGer.qryQuery.SQL.Add('                                              AND TBLFILTRO.CODIGO_COR = CADITE.ITE_CODCOR                             ');
  FCdsIteGer.qryQuery.SQL.Add('                                              AND LOCATE(ITEGER.ITE_CODEMP, "' + fRetEmpresasUsamPrecoMatriz + '") > 0 ');}


  FCdsIteger.fAbreClient(True, 'TAtualizacaoCustosProdutosAcabadosGeral.pAbreCdsIteGer') ;
end;

procedure TAtualizacaoCustosProdutosAcabadosGeral.pAbreQueryFormulas;
begin
  FQueryFormulas.Close;
  FQueryFormulas.SQL.Clear;
  FQueryFormulas.SQL.Add('SELECT                                                                         ');
  FQueryFormulas.SQL.Add('  GR.ITE_CODITE         AS CODIGO_PRODUTO,                                     ');
  FQueryFormulas.SQL.Add('  GMT_CODCOR            AS CODIGO_COR,                                         ');
  FQueryFormulas.SQL.Add('  IFNULL(GMT_PESREA, 0) AS PESO_REAL,                                          ');
  FQueryFormulas.SQL.Add('  GEIMAT.AUTOINCREM     AS AUTOINCREM_FORMULA,                                 ');
  FQueryFormulas.SQL.Add('  IFNULL(NIVEL, 0) AS ORDEM                                                               ');
  FQueryFormulas.SQL.Add('FROM                                                                           ');
  FQueryFormulas.SQL.Add('  CADITE GR                                                                    ');
  FQueryFormulas.SQL.Add('  INNER JOIN CADITE C ON C.ITE_CODPAG = GR.ITE_CODITE                          ');
  FQueryFormulas.SQL.Add('  INNER JOIN GEIMAT ON GMT_CODITE = C.ITE_CODPAG                               ');
  FQueryFormulas.SQL.Add('                   AND GMT_CODCOR = C.ITE_CODCOR                               ');
  FQueryFormulas.SQL.Add('                   AND GMT_STATUS = "A"                                        ');
  FQueryFormulas.SQL.Add('  LEFT JOIN (SELECT GMT_CODITE, DMT_ITESUB, NIVEL                              ');
  FQueryFormulas.SQL.Add('              FROM NIVEL_CALC                                                  ');
  FQueryFormulas.SQL.Add('             GROUP BY GMT_CODITE) NIVEL ON NIVEL.GMT_CODITE = GEIMAT.GMT_CODITE');

  FQueryFormulas.SQL.Add('WHERE                                                                          ');
  FQueryFormulas.SQL.Add('     GR.ITE_CODDEP IN (' + fRetTipoDepartamentoVarios('PROGRA') + ')           ');
  FQueryFormulas.SQL.Add(' AND C.ITE_CODPAG IS NOT NULL                                                  ');

  //FILTROS GRANEL
  If Not fEmptyStr(FFiltroProdutoGranel.strCodigo) Then
    FQueryFormulas.SQL.Add(' AND C.ITE_CODPAG IN (' + FFiltroProdutoGranel.strCodigo + ')                ');

  If Not fEmptyStr(FFiltroProdutoGranel.strLinhaGrupo) Then
  Begin
    If FFiltroProdutoGranel.ConsiderarTodosGruposDaLinha then
      FQueryFormulas.SQL.Add(' AND GR.ITE_CODGRU IN (SELECT DISTINCT(ITE_CODGRU) ITE_CODGRU FROM CADITE WHERE SUBSTRING(ITE_CODGRU,1,3) = ' +QuotedStr(FFiltroProdutoGranel.linha) + ') ' )
    Else
      FQueryFormulas.SQL.Add(' AND GR.ITE_CODGRU IN (' + FFiltroProdutoGranel.strLinhaGrupo + ')           ');
  End;

  If Not fEmptyStr(FFiltroProdutoGranel.strCodigoDepartamento) Then
    FQueryFormulas.SQL.Add(' AND GR.ITE_CODDEP IN (' + FFiltroProdutoGranel.strCodigoDepartamento + ')   ');

  If Not fEmptyStr(FFiltroProdutoGranel.strReferencia) Then
    FQueryFormulas.SQL.Add(' AND GR.ITE_REFERE = ' + QuotedStr(FFiltroProdutoGranel.strReferencia)        );

  If (FFiltroProdutoGranel.blnApenasAtivo) Then
    FQueryFormulas.SQL.Add(' AND GR.ITE_ITEATI = "S"                                                     ');

   //FILTROS ACABADO
  If Not fEmptyStr(FFiltroProdutoAcabado.strCodigo) Then
    FQueryFormulas.SQL.Add(' AND C.ITE_CODITE IN (' + FFiltroProdutoAcabado.strCodigo + ')               ');

  If Not fEmptyStr(FFiltroProdutoAcabado.strLinhaGrupo) Then
  Begin
    If FFiltroProdutoAcabado.ConsiderarTodosGruposDaLinha then
      FQueryFormulas.SQL.Add(' AND C.ITE_CODGRU IN (SELECT DISTINCT(C.ITE_CODGRU) ITE_CODGRU FROM CADITE C WHERE SUBSTRING(C.ITE_CODGRU,1,3) = ' +QuotedStr(FFiltroProdutoAcabado.linha) + ') '    )
    Else
      FQueryFormulas.SQL.Add(' AND C.ITE_CODGRU IN (' + FFiltroProdutoAcabado.strLinhaGrupo + ')           ');
  End;

  If Not fEmptyStr(FFiltroProdutoAcabado.strCodigoDepartamento) Then
    FQueryFormulas.SQL.Add(' AND C.ITE_CODDEP IN (' + FFiltroProdutoAcabado.strCodigoDepartamento + ')   ');

  If Not fEmptyStr(FFiltroProdutoAcabado.strReferencia) Then
    FQueryFormulas.SQL.Add(' AND C.ITE_REFERE = ' + QuotedStr(FFiltroProdutoAcabado.strReferencia)        );

  If (FFiltroProdutoAcabado.blnApenasAtivo) Then
    FQueryFormulas.SQL.Add(' AND C.ITE_ITEATI = "S"                                                      ');

  FQueryFormulas.SQL.Add(' GROUP BY GR.ITE_CODITE, GMT_CODCOR                                            ');
  FQueryFormulas.SQL.Add(' ORDER BY ORDEM, GR.ITE_CODITE, GMT_CODCOR                                            ');

  FQueryFormulas.Open;
end;



procedure TAtualizacaoCustosProdutosAcabadosGeral.pOrdenaAquisicaoLocksProInc;
var
  qryLock: {$IFDEF LINUX} IQuery {$ELSE} TUniQuery {$ENDIF};
begin
  // Adquire X-lock nas linhas 'PREALT' e 'PROALT' de PROINC em ordem
  // alfabetica estavel na conexao global (mesma transacao aberta por
  // fStartTransaction). Os triggers de ITEGER acessam essas duas linhas
  // via SELECT FOR UPDATE em ordem variavel - pre-adquirindo aqui,
  // normalizamos a ordem e eliminamos o ciclo AB<->BA de deadlock.
  qryLock := fCriaQuery;
  try
    qryLock.SQL.Text :=
    'SELECT PRO_AUTINC FROM PROINC ' +
    'WHERE PRO_NOMARQ IN (''PREALT'', ''PROALT'') ' +
    'ORDER BY PRO_NOMARQ FOR UPDATE';
    qryLock.Open;
    qryLock.Close;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryLock);
    {$ENDIF}
  end;
end;

function TAtualizacaoCustosProdutosAcabadosGeral.fAtualizaCustosAguarde(prgProgresso: TcxProgressBar) : boolean;
var
  objOrdemProducao  : TOrdemProducao;
  objProdutoAcabado : TProdutoAcabado;
  fltCustoKilo : double;
  fltPrcMedioKilo: double;
  intCfgPrbAca: Integer;
begin
  try
    Result := True;

    pSetaNiveis;

    pAbreQueryFormulas;

    If Assigned(prgProgresso) Then
    Begin
      prgProgresso.Position := 0;
      prgProgresso.Properties.Max := FQueryFormulas.RecordCount;
      prgProgresso.Visible  := True;
    End;

    FQueryFormulas.First;
    strAgrupadorPreAlt := '';

    intCfgPrbAca := fCfgSis('PRBACA', varInteger);

    pPreAltDefineVariaveisAltPre(fNow,'ATUALIZACAO CUSTO DE ACABADOS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
    while Result and (not FQueryFormulas.Eof) do
    begin
      try
        objOrdemProducao := TOrdemProducao.Create;
        try
          pAbreCdsIteGer(FQueryFormulas.FieldByName('CODIGO_PRODUTO').AsString, FQueryFormulas.FieldByName('CODIGO_COR').AsString);
          objOrdemProducao.objFormula.fltPesoReal := FQueryFormulas.FieldByName('PESO_REAL').AsFloat;

          FCarregaMateriaPrima.pAlimentaListaMateriaPrimaCadastro(FQueryFormulas.FieldByName('AUTOINCREM_FORMULA').AsString,  objOrdemProducao.objFormula.lstMateriasPrimas);

          FCarregaProdutoAcabado.fltPesoReal := FQueryFormulas.FieldByName('PESO_REAL').AsFloat;
          FCarregaProdutoAcabado.objFiltroProduto.pClonaObjeto(FFiltroProdutoAcabado);
          FCarregaProdutoAcabado.pAlimentaListaProdutoAcabadoCadastro(FQueryFormulas.FieldByName('CODIGO_PRODUTO').AsString, FQueryFormulas.FieldByName('CODIGO_COR').AsString, objOrdemProducao.lstProdutosAcabados);

          objOrdemProducao.pSetaBaixaPerfeitaProdutosAcabados;

          Case intCfgPrbAca Of
          1: Begin
               fltCustoKilo := objOrdemProducao.fRetornaCustoKilo;

               for objProdutoAcabado in objOrdemProducao.lstProdutosAcabados do
               begin
                 if objProdutoAcabado.fltQuantidadeEnvasada <> 0 then
                 begin
                   Result := fAtualizaIteGer(objProdutoAcabado.strCodigo, objProdutoAcabado.fRetornaCustoUnitario(fltCustoKilo));
                   if not Result then
                     break;
                 end;
               end;
             End;
          2: Begin
               fltPrcMedioKilo := objOrdemProducao.fRetornaPrecoMedioKilo;

               for objProdutoAcabado in objOrdemProducao.lstProdutosAcabados do
               begin
                 if objProdutoAcabado.fltQuantidadeEnvasada <> 0 then
                 begin
                   Result := fAtualizaIteGer(objProdutoAcabado.strCodigo, objProdutoAcabado.fRetornaPrcMedioUnitario(fltPrcMedioKilo));
                   if not Result then
                     break;
                 end;
               end;
             End;
          End;

          fStartTransaction;

          // Corrige deadlock: pre-adquire X-lock em PROINC('PREALT','PROALT')
          // em ordem deterministica, antes dos triggers de ITEGER dispararem.
          pOrdenaAquisicaoLocksProInc;

          Result := FCdsIteGer.fSalva;

          Result := Result and FCdsPreAlt.fSalva;

          if Result then
            Result := fCommit
          else
            fRollBack;

        finally
          FreeAndNil(objOrdemProducao);
        end;
      except
        on E: Exception do
        begin
          {$IFDEF LINUX}
          Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
          {$ENDIF}
          fRollBack;
          raise Exception.Create(e.message);
        end;
      end;

      FQueryFormulas.Next;

      If Assigned(prgProgresso) Then
        prgProgresso.Position := FQueryFormulas.RecNo;

     {$IFDEF LINUX}
      TTaskLock.pZerarTentativasLock(Format(spIdLockProdAcabadosIndustrial, [VS_strCodEmp]));
     {$ELSE}
      Application.ProcessMessages;
     {$ENDIF}
    end;

    strAgrupadorPreAlt := '';

  except
    On E: Exception Do
    Begin
    {$IFNDEF LINUX}
      pMensagensErro(E.Message, 'TAtualizacaoCustosProdutosAcabadosGeral.fAtualizaCustos');
      Result := False;
    {$ELSE}
      Writeln(DateTimeToStr(fNow) + ' - ' + E.ClassName, ': ', E.Message);
      Raise;
    {$ENDIF}
    end;
  end;

end;

function TAtualizacaoCustosProdutosAcabadosGeral.fAtualizaIteGer(strCodigoProdutoAcabado: String; fltPrecoCompra: Double): Boolean;
Var
  i: Integer;
  strCampo: String;

  fltPrecoCompraAntigo,
  fltCustoAntigo: Double;

  arrPrecoAntigo,
  arrMargemAntigo: Array[1..INTMAXPRECO] Of Double;
Begin

  Result := True;
  try
    FCdsIteGer.Filtered := False;
    FCdsIteGer.Filter   := 'ITE_CODITE = ' +  QuotedStr(strCodigoProdutoAcabado);
    FCdsIteGer.Filtered := True;

    If Not FCdsIteGer.IsEmpty Then
    Begin
      FCdsIteGer.First;
      While (not FCdsIteGer.Eof) and Result Do
      Begin
        fltCustoAntigo       := FCdsIteGer.FieldByName('ITE_PRECUS').AsFloat;
        fltPrecoCompraAntigo := FCdsIteGer.FieldByName('ITE_PRECOM').AsFloat;

        For i := Low(arrPrecoAntigo) To High(arrPrecoAntigo) Do
        Begin
          arrPrecoAntigo[i]  := FCdsIteGer.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat;
          arrMargemAntigo[i] := FCdsIteGer.FieldByName('ITE_MARBR' + IntToStr(i)).AsFloat;
        End;

        FCdsIteGer.Edit;
        FCdsIteGer.FieldByName('ITE_PRECOM').AsFloat := fltPrecoCompra;
        FCdsIteGer.FieldByName('ITE_PREALT').AsString := strAgrupadorPreAlt;

        FParams.pLimparCampos;
        FParams.curPreCom := FCdsIteGer.FieldByName('ITE_PRECOM').AsFloat;
        FParams.curDesF01 := FCdsIteGer.FieldByName('ITE_DESF01').AsFloat;
        FParams.curDesF02 := FCdsIteGer.FieldByName('ITE_DESF02').AsFloat;
        FParams.curDesF03 := FCdsIteGer.FieldByName('ITE_DESF03').AsFloat;
        FParams.curDesF04 := FCdsIteGer.FieldByName('ITE_DESF04').AsFloat;
        FParams.curDesF05 := FCdsIteGer.FieldByName('ITE_DESF05').AsFloat;
        FParams.curDesF06 := FCdsIteGer.FieldByName('ITE_DESF06').AsFloat;
        FParams.curICMSEnt:= FCdsIteGer.FieldByName('ITE_ICMENT').AsFloat;
        FParams.curIPIEnt := FCdsIteGer.FieldByName('ITE_IPIENT').AsFloat;
        FParams.curFrete  := FCdsIteGer.FieldByName('ITE_FREENT').AsFloat;
        FParams.curValFre := FCdsIteGer.FieldByName('ITE_VALFRE').AsFloat;
        FParams.curAcrFin := FCdsIteGer.FieldByName('ITE_ACRFIN').AsFloat;
        FParams.curSubsti := FCdsIteGer.FieldByName('ITE_SUBSTI').AsFloat;
        FParams.curDesAdb := FCdsIteGer.FieldByName('ITE_DESADB').AsFloat;
        FParams.curSubFed := FCdsIteGer.FieldByName('ITE_SUBFED').AsFloat;
        FParams.curTCIFCu := FCdsIteGer.FieldByName('ITE_TCIFCU').AsFloat;
        FParams.curTSCust := FCdsIteGer.FieldByName('ITE_TSCUST').AsFloat;
        FParams.curDePiCo := FCdsIteGer.FieldByName('ITE_DEPICO').AsFloat;
        FParams.curDeICMS := FCdsIteGer.FieldByName('ITE_DEICMS').AsFloat;
        FParams.curFatReg := FCdsIteGer.FieldByName('ITE_FATREG').AsFloat;

        FCdsIteGer.FieldByName('ITE_PRECUS').AsFloat := FParams.fCalculaPrecoCusto(false);

        For i := 1 To Length(VS_strTabPrc) Do
        Begin

          If FMargem Then
            strCampo := 'ITE_MARBR' + IntToStr(i)
          Else
            strCampo := 'ITE_PREVE' + IntToStr(i);

          FCdsIteGer.FieldByName(strCampo).AsFloat := fCalculaPrecoVenda(IIF(FMargem, 2, 1),
                                                                         FCdsIteGer.FieldByName('ITE_PRECUS').AsFloat + FCdsIteGer.FieldByName('ITE_OUTVAL').AsFloat,
                                                                         FCdsIteGer.FieldByName('ITE_PREVE' + IntToStr(i)).AsFloat,
                                                                         FCdsIteGer.FieldByName('ITE_MARBR' + IntToStr(i)).AsFloat,
                                                                         FCdsIteGer.FieldByName('ITE_ICMSAI').AsFloat,
                                                                         FCdsIteGer.FieldByName('ITE_IMPFED').AsFloat,
                                                                         FCdsIteGer.FieldByName('ITE_DESOPE').AsFloat,
                                                                         FCdsIteGer.FieldByName('ITE_COMTB' + IntToStr(i)).AsFloat);
        End;

        FCdsIteGer.Post;
        If (Not VS_blnPreAltViaTrigger) Then
          Result := fGravaPreAlt(FCdsIteGer.FieldByName('ITE_CODITE').AsString,
                               fltCustoAntigo,
                               FCdsIteGer.FieldByName('ITE_PRECUS').AsFloat,

                               arrPrecoAntigo[1],
                               FCdsIteGer.FieldByName('ITE_PREVE1').AsFloat,
                               arrMargemAntigo[1],
                               FCdsIteGer.FieldByName('ITE_MARBR1').AsFloat,

                               arrPrecoAntigo[2],
                               FCdsIteGer.FieldByName('ITE_PREVE2').AsFloat,
                               arrMargemAntigo[2],
                               FCdsIteGer.FieldByName('ITE_MARBR2').AsFloat,

                               arrPrecoAntigo[3],
                               FCdsIteGer.FieldByName('ITE_PREVE3').AsFloat,
                               arrMargemAntigo[3],
                               FCdsIteGer.FieldByName('ITE_MARBR3').AsFloat,

                               arrPrecoAntigo[4],
                               FCdsIteGer.FieldByName('ITE_PREVE4').AsFloat,
                               arrMargemAntigo[4],
                               FCdsIteGer.FieldByName('ITE_MARBR4').AsFloat,

                               arrPrecoAntigo[5],
                               FCdsIteGer.FieldByName('ITE_PREVE5').AsFloat,
                               arrMargemAntigo[5],
                               FCdsIteGer.FieldByName('ITE_MARBR5').AsFloat,

                               arrPrecoAntigo[6],
                               FCdsIteGer.FieldByName('ITE_PREVE6').AsFloat,
                               arrMargemAntigo[6],
                               FCdsIteGer.FieldByName('ITE_MARBR6').AsFloat,

                               arrPrecoAntigo[7],
                               FCdsIteGer.FieldByName('ITE_PREVE7').AsFloat,
                               arrMargemAntigo[7],
                               FCdsIteGer.FieldByName('ITE_MARBR7').AsFloat,

                               fltPrecoCompraAntigo,
                               fltPrecoCompra,

                               'ATUALIZACAO CUSTO DE ACABADOS',
                               FCdsPreAlt,
                               FCdsIteGer.FieldByName('ITE_CODEMP').AsString,
                               strLoginUsuarioLogado)
        Else
          Result := True;
        FCdsIteGer.Next;
      End;
    End;

  Except
    On E: Exception Do
    Begin
    {$IFDEF LINUX}
      Raise;
    {$ELSE}
      Result := False;
      pMensagensErro(E.Message, 'TAtualizacaoCustosProdutosAcabadosGeral.fAtualizaPrecoAcabado');
    {$ENDIF}
    End;
  End;
End;

function TAtualizacaoCustosProdutosAcabadosGeral.fAtualizaCustos: boolean;
begin
{$IFDEF LINUX}
  Result := fAtualizaCustosAguarde(nil);
{$ELSE}
  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    try
      frmGravando.lblGravando.Caption := 'Aguarde... Calculando custo dos produtos acabados.';
      frmGravando.fExecutarAcao := fAtualizaCustosAguarde;
      frmGravando.ShowModal;
      Result := frmGravando.blnConfirma;
    finally
      pFreeAndNil(frmGravando);
    end;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'TAtualizacaoCustosProdutosAcabadosGeral.fAtualizaCustos');
    End;
  End;
{$ENDIF}
end;

end.

