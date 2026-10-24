unit untTChecklistProduto;

interface
  uses
    Data.DB, untZClient, System.Json, System.Classes, UniClientDataSet, untChkMerTypes, Uni;

type
  TChecklistProduto = class
  private
    Type TTipoFiltroDados = (IncluirOuAtualizar, Excluir, Nenhum);
    Type TProcFiltroDados = reference to procedure (pcdsCheckList: TUniClientDataSet; penuFiltro: TTipoFiltroDados);
    type TfuncGetRecItem = reference to function: TRecItemCheckListGarantia;
  Strict Private Type
    TChecklistGravar = class
    Private
      FqryIteCVG: TUniquery;
      FIncIte: String;
      FcdsSource: TUniClientDataSet;

      FTipoCheckList: TTipoCheckList;
      procedure pCriarqryIteCVG;
      procedure pExcluir;
      procedure pInserir;

    public
      procFiltroDados: TProcFiltroDados;
      funcGetRecItem: TfuncGetRecItem;
      function fGravarChecklist(const pstrAutInc: String; pcdsSource: TUniClientDataSet; pTipoCheckList: TTipoCheckList): Boolean;
    end;

  private
    CONST
      VSIM: string = '1';
      VNAO: String = '0';
  private
    FstrAutInc: String;
    FstrCodEmp: String;
    FstrCodIte: String;
    FenuGrupoChklist: TTipoCheckList;

    procedure pFiltrarDados(pcdsCheckList: TUniClientDataSet; penuFiltro: TTipoFiltroDados);

    function fGetAsJsonObject: TJSONObject;

    function fObterAutIncIteGer(const pstrCodIte, pstrCodEmp: String): String;
    procedure pSetIncIte(const Value: String);
  public
    const
      JP_NOME_ITE_CODITE: String = 'produto_codigo';
      JP_NOME_ITE_CODEMP: String = 'empresa';
      JP_NOME_CHECKLIST: String = 'checklist';
      JP_NOME_CVG_CODIGO: String = 'codigo';
      JP_NOME_ITE_CONTEU: String = 'conteudo';
      JP_NOME_CVG_TIPOVG: String = 'grupo';

  public
    cdsItensChkMer: TUniClientDataSet;
    destructor Destroy;Override;


    procedure pAplicarItensChkMer(pcdsItensChkMer: TUniClientDataSet);
    function fApagarChecklist(const pstrCodIte, pstrCodEmp: String; penuGrupo: TTipoCheckList): Boolean;

    function fCarregarChecklist(const pstrAutInc: String; penuGrupoChklist: TTipoCheckList;
        blnSomenteAssociado: Boolean; out pcdsDados: TUniClientDataSet): Boolean;


    procedure pCarregar(const pstrCodIte: String; penuGrupoChklist: TTipoCheckList; blnSomenteAssociado: Boolean; pstrCodEmp: String = '');
    function fCarregarJson(const strJson: String): Boolean;overload;
    function fCarregarJson(const strJson: String; Out blnResult: Boolean): TChekListImportJson;overload;

    procedure pPercorrerItens(pEnviarItemChecklistMercadoria: TProcEnviarItemChecklistMercadoria);

    function fGravar: Boolean;
    function fGetAsStringJson(const blnSomenteItensChecklist: Boolean): String;
    function fGetRecItemCheckListGarantia: TRecItemCheckListGarantia;
    function fGetSQLCheckListGarantiaItem(const blnItem, blnTipo: Boolean; blnSomenteAssociado: Boolean = False): String;

    procedure pInserirItem(recItem: TRecItemCheckListGarantia);

    procedure pLimpar;

  public //class
    function fRefazCheckList(const strCodIte, strCodEmp, strNovoCheckListAsJson: String; penuGrupoChecklist: TTipoCheckList): Boolean;


    property enuGrupoChklist: TTipoCheckList Read FenuGrupoChklist;
    property strCodIte: String Read FstrCodIte;
    property strCodEmp: String Read FstrCodEmp;
    property strAutInc: String Read FstrAutInc Write pSetIncIte;

  end;

implementation

uses
  untFuncoesSimples, System.SysUtils, System.StrUtils;
{ TChecklistProduto }

destructor TChecklistProduto.Destroy;
begin
  if Assigned(cdsItensChkMer) then
    FreeAndNil(cdsItensChkMer);
  inherited;
end;



function TChecklistProduto.fCarregarChecklist(const pstrAutInc: String; penuGrupoChklist: TTipoCheckList;
            blnSomenteAssociado: Boolean; out pcdsDados: TUniClientDataSet): Boolean;
  Var
    strSQL: String;

    cdsTmp: TZClient;

    blnItem,
    blnFiltrarGrupo: Boolean;
begin

  blnItem := Not fEmptyStr(pstrAutInc);
  blnFiltrarGrupo := penuGrupoChklist.fAsString <> EmptyStr;
  FenuGrupoChklist := penuGrupoChklist;
  strSql := fGetSQLCheckListGarantiaItem(blnItem, blnFiltrarGrupo, blnSomenteAssociado);

  if Assigned(pcdsDados) then
    FreeAndNil(pcdsDados);

  Try
    Result := True;
    cdsTmp := TZClient.Create(Nil);

    cdsTmp.ReadOnly := False;
    cdsTmp.Close;
    cdsTmp.qryQuery.SQL.Clear;
    cdsTmp.qryQuery.SQL.Add(strSQL);

    if blnItem then
      cdsTmp.qryQuery.ParamByName('INCITE').AsString := pstrAutInc;

    If blnFiltrarGrupo then
      cdsTmp.qryQuery.ParamByName('TIPOVG').AsString := penuGrupoChklist.fAsString;

    Try
      cdsTmp.fAbreClient(True);

      pcdsDados := TUniClientDataSet.Create(Nil);
      pcdsDados.Data := cdsTmp.Data;

    Except
      On E: Exception do
      begin
        Result := False;
        raise;
      end;
    End;

  Finally
    if Assigned(cdsTmp) then
      FreeAndNil(cdsTmp);
  End;


end;

function TChecklistProduto.fCarregarJson(const strJson: String; Out blnResult: Boolean): TChekListImportJson;
  Type
  {$Region 'Tipos de métodos locais'}
    TfuncGetValueOfPair = reference to function(const pstrPairName: String; aJsonObject: TJSONObject; Out aJsonValue: TJSONValue): Boolean;
    TfuncGetValueOfPairJsonString = reference to function(const pstrPairName: String; aJsonObject: TJSONObject; Out pstrValue: String): Boolean;
    TfuncGetValueOfPairJSonArray = reference to function(const pstrPairName: String; aJsonObject: TJSONObject; Out jaValue: TJSonArray): Boolean;
  {$Endregion}
  Var
    jValue: TJSONValue;
    joItemCheckList,
    joCheckListMercadotia: TJSONObject;

    jaChklist: TJSONArray;

    lfGetValueOfPair: TfuncGetValueOfPair;
    lfGetValueOfPairString: TfuncGetValueOfPairJsonString;
    lfGetValueOfPairJSonArray: TfuncGetValueOfPairJSonArray;

    i: Integer;
    blnSomenteItens: Boolean;
    recItem: TrecItemCklImportJson;
begin
  blnResult := False;
  {$Region 'Implementacao de Métodos locais'}
  lfGetValueOfPair := function(const pstrPairName: String; aJsonObject: TJSONObject; Out aJsonValue: TJSONValue): Boolean
                      begin
                        aJsonValue := Nil;
                        aJsonValue := aJsonObject.GetValue(pstrPairName);
                        Result := Assigned(aJsonValue);
                      end;

  lfGetValueOfPairString := function(const pstrPairName: String; aJsonObject: TJSONObject; Out pstrValue: String): Boolean
                               Var
                                 ljValue: TJSONValue;
                             begin
                               pstrValue := EmptyStr;
                               Result := lfGetValueOfPair(pstrPairName, aJsonObject, ljValue);
                               Result := Result and (ljValue is TJSONString);
                               if Result then
                                 pstrValue := TJSONString(ljValue).Value;
                             end;

  lfGetValueOfPairJSonArray :=
    function(const pstrPairName: String; aJsonObject: TJSONObject; Out jaValue: TJSonArray): Boolean
     Var
        ljValue: TJSONValue;
    begin
      jaValue := Nil;
      Result := lfGetValueOfPair(pstrPairName, aJsonObject, ljValue);
      Result := Result and (ljValue is TJSONArray);

      if Result then
        jaValue := TJSONArray(ljValue);
    end;
  {$Endregion}

  Result := Nil;
  blnSomenteItens := False;
  joCheckListMercadotia := Nil;
  joItemCheckList := Nil;
  Try
    Try
      jValue := TJSONObject.ParseJSONValue(strJson);

      blnResult := (Assigned(jValue) and (jValue is TJSONObject));

      if (Not blnResult) and  ((Assigned(jValue) and (jValue is TJSONArray))) then
      begin
        blnResult := True;
        blnSomenteItens := True;
        jaChklist := TJSONArray(jValue);
      end;

      if Not blnResult then
        Exit;

      Result := TChekListImportJson.Create;

      if (Not blnSomenteItens) then
      begin
        joCheckListMercadotia := TJSONObject(jValue);

        lfGetValueOfPairString(JP_NOME_ITE_CODITE, joCheckListMercadotia, Result.strCodIte);
        lfGetValueOfPairString(JP_NOME_ITE_CODEMP, joCheckListMercadotia, Result.strCodEmp);
        lfGetValueOfPairString(JP_NOME_CVG_TIPOVG, joCheckListMercadotia, Result.strGrupo);

        lfGetValueOfPairJSonArray(JP_NOME_CHECKLIST,joItemCheckList, jaChklist);
      end;

      if Not Assigned(jaChklist) then
        Exit;

      for i := 0 to jaChklist.Count -1 do
      begin
        recItem.strCodigo   := EmptyStr;
        recItem.strConteudo := EmptyStr;

        jValue := jaChklist.Items[i];

        if (jValue is TJSONString) then
        begin
          //item checklist de resultado do tipo NA (não tem conteúdo).
          recItem.strCodigo := TJSONString(jValue).Value;
        end
        else if (jValue is TJSONObject) then
        begin
          joItemCheckList := TJSONObject(jValue);
          lfGetValueOfPairString(JP_NOME_CVG_CODIGO, joItemCheckList, recItem.strCodigo);
          lfGetValueOfPairString(JP_NOME_ITE_CONTEU, joItemCheckList, recItem.strConteudo);
        end;
        if Not fEmptyStr(recItem.strCodigo) then
          result.pAdicionarItem(recItem);
      end;
      blnResult := blnResult and result.fTemItem;
    Except
      On E: Exception do
      begin
        if Assigned(Result) then
          FreeAndNil(Result);
        pMensagensErro(e.Message, 'TfrmChecklistGarantia.fCarregarJson');
      end
    end;
  Finally
    if Assigned(joCheckListMercadotia) then
      FreeAndNil(joCheckListMercadotia);
  End;
end;

function TChecklistProduto.fCarregarJson(const strJson: String): Boolean;
  Var
    i: Integer;
    objCklImportJson: TChekListImportJson;
    blnEliminar: Boolean;
begin
  Result := False;
  objCklImportJson := Nil;
  Try
    cdsItensChkMer.First;
    While Not cdsItensChkMer.Eof do
    begin
      cdsItensChkMer.Edit;
      cdsItensChkMer.FieldByName('ASSOCIADO').AsString := '0';
      cdsItensChkMer.Next;
    end;

    objCklImportJson := fCarregarJson(strJson, Result);

    if Not Result then
      Exit;

    cdsItensChkMer.Filtered := False;
    blnEliminar := False;
    Try
      for i := Low(objCklImportJson.arrItensCkl) to High(objCklImportJson.arrItensCkl) do
      begin
        if cdsItensChkMer.Locate('CVG_CODIGO', objCklImportJson.arrItensCkl[i].strCodigo,[]) then
        begin
          cdsItensChkMer.Edit;
          cdsItensChkMer.FieldByName('ASSOCIADO').AsString := VSIM;
          cdsItensChkMer.FieldByName('ITE_CONTEU').AsString := objCklImportJson.arrItensCkl[i].strConteudo;
          cdsItensChkMer.Post;
          if Not blnEliminar then
            blnEliminar := True;
        end;
      end;

      if blnEliminar then
      begin
        {$Region 'Excluindo aqueles não associados'}
        cdsItensChkMer.Filter := ' ASSOCIADO = '+ QuotedStr('0');
        cdsItensChkMer.Filtered := True;
        cdsItensChkMer.first;

        While Not cdsItensChkMer.Eof do
          cdsItensChkMer.Delete;

        cdsItensChkMer.Filtered := False;
        cdsItensChkMer.Filter := EmptyStr;
        {$EndRegion 'Excluindo aqueles não associados'}
      end;
    Except
      On E: Exception do
      begin
        pMensagensErro(e.Message, 'TfrmChecklistGarantia.fCarregarJson');
      end
    end;
  Finally
    if Assigned(objCklImportJson) then
      FreeAndNil(objCklImportJson);
  End;
end;

function TChecklistProduto.fGetAsJsonObject: TJSONObject;
  Var
    jaChklist: TJSONArray;
    joItemCheckList: TJSONObject;
    recItem: TRecItemCheckListGarantia;
    strIndexField: String;
begin
  strIndexField := cdsItensChkMer.IndexFieldNames;
  Result := TJSONObject.Create;

  Result.AddPair(TJSONPair.Create(JP_NOME_ITE_CODITE, TJSONString.Create(FstrCodIte)));
  Result.AddPair(TJSONPair.Create(JP_NOME_ITE_CODEMP, TJSONString.Create(FstrCodEmp)));
  Result.AddPair(TJSONPair.Create(JP_NOME_CVG_TIPOVG, TJSONString.Create(FenuGrupoChklist.fAsString)));

  jaChklist := TJSONArray.Create;

  Result.AddPair(TJSONPair.Create(JP_NOME_CHECKLIST,jaChklist));

  pFiltrarDados(cdsItensChkMer, IncluirOuAtualizar);
  cdsItensChkMer.IndexFieldNames := 'CVG_TIPOVG;CVG_CODIGO';
  cdsItensChkMer.First;
  While Not cdsItensChkMer.Eof do
  begin
    recItem := fGetRecItemCheckListGarantia;
    if RecItem.blnAssociado then
    begin
      if recItem.enuResultado = TTipoResultado.NA then
      begin
        jaChklist.AddElement(TJSONString.Create(recItem.strCodigo))
      end
      else
      begin
        joItemCheckList := TJSONObject.Create;
        joItemCheckList.AddPair(JP_NOME_CVG_CODIGO, TJSONString.Create(RecItem.strCodigo));

        if recItem.fTemConteudo then
          joItemCheckList.AddPair(JP_NOME_ITE_CONTEU, TJSONString.Create(RecItem.strConteudo));

        jaChklist.AddElement(joItemCheckList);
      end;
    end;
    cdsItensChkMer.Next;
  end;
  pFiltrarDados(cdsItensChkMer, Nenhum);
  cdsItensChkMer.IndexFieldNames := strIndexField;
end;

function TChecklistProduto.fGetAsStringJson(const blnSomenteItensChecklist: Boolean): String;
  Var
    joCheckList: TJSONObject;
    jaChecklist: TJSONArray;
begin
  Result := EmptyStr;
  joCheckList := nil;
  Try
    joCheckList := fGetAsJsonObject;
    if Assigned(joCheckList) then
    begin
      if blnSomenteItensChecklist then
      begin
        if joCheckList.GetValue(JP_NOME_CHECKLIST) is TJSONArray then
        begin
          jaChecklist := TJSONArray(joCheckList.GetValue(JP_NOME_CHECKLIST));
          Result := jaChecklist.ToString;
        End
        else
          Result := EmptyStr;
      end
      else
        Result := joCheckList.ToString;
    end;
  Finally
    if Assigned(joCheckList) then
      joCheckList.Free;
  End;
end;

function TChecklistProduto.fGetSQLCheckListGarantiaItem(const blnItem, blnTipo: Boolean;
      blnSomenteAssociado: Boolean = False): String;
begin
  Result :=          ' SELECT  C.AUTOINCREM, C.CVG_CODIGO, C.CVG_DESCRI, C.CVG_TIPORE, C.CVG_TIPOVG, ';

  Result := Result + '         IF(IFNULL(I.AUTOINCREM,"") = "","0","1") AS ASSOCIADO, ';
  Result := Result + '         IF(IFNULL(I.AUTOINCREM,"") = "","0","1") AS SITUACAO, ';

  Result := Result + '         CASE C.CVG_TIPORE ';
  Result := Result + '          WHEN "N" THEN "N/A" ';
  Result := Result + '          ELSE IFNULL(I.ITE_CONTEU,"") ';
  Result := Result + '         END "ITE_CONTEU", ';

  Result := Result + '         I.AUTOINCREM AS "ITE_AUTINC", I2.ITE_CODITE ';

  Result := Result + ' FROM CADCVG C ';

  if blnItem then
  begin
    Result := Result + ' %0:s JOIN ITECVG I ON I.ITE_INCCVG = C.AUTOINCREM AND I.AUTOINCREM = :INCITE ';
    Result := Result + ' %0:s JOIN ITEGER I2 ON I2.AUTOINCREM = I.AUTOINCREM ';
    Result := format(Result,[ifthen(blnSomenteAssociado,'INNER','LEFT')]);
  end
  else begin
    Result := Result + ' LEFT JOIN ITECVG I ON I.ITE_INCCVG = C.AUTOINCREM AND FALSE ';
    Result := Result + ' LEFT JOIN ITEGER I2 ON I2.AUTOINCREM = I.AUTOINCREM AND FALSE ';
  end;

  If blnTipo then
    Result := Result + ' WHERE C.CVG_TIPOVG = :TIPOVG ';

  Result := Result + ' ORDER BY CVG_TIPOVG, CVG_TIPORE, CVG_CODIGO ';
end;

function TChecklistProduto.fGravar: Boolean;
  Var
    objChkGravar: TChecklistGravar;
begin
  objChkGravar := Nil;
  Try
    objChkGravar := TChecklistGravar.Create;

    objChkGravar.funcGetRecItem := fGetRecItemCheckListGarantia;
    Result := objChkGravar.fGravarChecklist(Self.FstrAutInc, Self.cdsItensChkMer, self.enuGrupoChklist);
  Finally
    if Assigned(objChkGravar) then
      FreeAndNil(objChkGravar);
  End;
end;

function TChecklistProduto.fObterAutIncIteGer(const pstrCodIte, pstrCodEmp: String): String;
  Var
    Qry: TUniQuery;
    strSQL: String;
begin
  Result := EmptyStr;
  Qry := Nil;
  strSql := ' SELECT AUTOINCREM, ITE_CODITE FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ';
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.SQL.Add(strSql);
    Qry.ParamByName('CODITE').AsString := pstrCodIte;
    Qry.ParamByName('CODEMP').AsString := pstrCodEmp;
    Qry.Open;
    if Qry.IsEmpty Then
      Exit;
    Result := Qry.FieldByName('AUTOINCREM').AsString;
  Finally
    if Assigned(Qry)Then
      FreeAndNil(Qry);
  End;

end;

function TChecklistProduto.fRefazCheckList(const strCodIte, strCodEmp, strNovoCheckListAsJson: String;
  penuGrupoChecklist: TTipoCheckList): Boolean;
begin
  pLimpar;
  FenuGrupoChklist := penuGrupoChecklist;
  fApagarChecklist(strCodIte, strCodEmp, penuGrupoChecklist);

  pCarregar(strCodIte, penuGrupoChecklist, False, strCodEmp);

  Result := Not fEmptyStr(FstrAutInc);
  Result := Result and fCarregarJson(strNovoCheckListAsJson);

  Result := Result and fGravar;
end;

function  TChecklistProduto.fGetRecItemCheckListGarantia: TRecItemCheckListGarantia;
begin
  Result.pLimpar;
  if cdsItensChkMer.IsEmpty then
    Exit;

  Result.strCodIte             := FstrCodIte;
  Result.strCodEmp             := FstrCodEmp;
  Result.strIteAutInc          := cdsItensChkMer.FieldByName('ITE_AUTINC').AsString;
  Result.strAutoincrem         := cdsItensChkMer.FieldByName('AUTOINCREM').AsString;
  Result.strCodigo             := cdsItensChkMer.FieldByName('CVG_CODIGO').AsString;
  Result.strConteudo           := cdsItensChkMer.FieldByName('ITE_CONTEU').AsString;
  Result.blnAssociado          := cdsItensChkMer.FieldByName('ASSOCIADO').AsString = VSIM;
  Result.strDescricao          := cdsItensChkMer.FieldByName('CVG_DESCRI').AsString;
  Result.strSituacao           := cdsItensChkMer.FieldByName('SITUACAO').AsString;
  Result.enuResultado.pSetAsString(cdsItensChkMer.FieldByName('CVG_TIPORE').AsString);
  Result.enuChkList.pSetAsString(cdsItensChkMer.FieldByName('CVG_TIPOVG').AsString);
end;

procedure TChecklistProduto.pPercorrerItens(pEnviarItemChecklistMercadoria: TProcEnviarItemChecklistMercadoria);
  Var
    recItem: TRecItemCheckListGarantia;
begin
  if cdsItensChkMer.IsEmpty then
    Exit;
  cdsItensChkMer.First;

  While Not cdsItensChkMer.Eof do
  begin
    recItem := fGetRecItemCheckListGarantia;
    pEnviarItemChecklistMercadoria(recItem);
    cdsItensChkMer.Next;
  end;
end;

procedure TChecklistProduto.pSetIncIte(const Value: String);
begin
  FstrAutInc := Value;
end;

function TChecklistProduto.fApagarChecklist(const pstrCodIte, pstrCodEmp: String; penuGrupo: TTipoCheckList): Boolean;
  Var
    Qry : TUniQuery;
    blnGrupo: Boolean;
    strSql: String;
begin

  blnGrupo := penuGrupo.fAsString <> EmptyStr;

  {$Region 'Montando SQL'}
  strSQL := strSQL + ' DELETE T1 ';
  strSQL := strSQL + ' FROM ITECVG T1 ';

  If blnGrupo then
    strSQL := strSQL + ' JOIN CADCVG C ON T1.ITE_INCCVG = C.AUTOINCREM AND C.CVG_TIPOVG = :TIPOVG ';

  strSQL := strSQL + ' WHERE T1.AUTOINCREM IN (SELECT I.AUTOINCREM ';
  strSQL := strSQL + '                         FROM ITEGER I ';
  strSQL := strSQL + '                         WHERE I.ITE_CODEMP = :CODEMP AND I.ITE_CODITE = :CODITE) ';
  {$EndRegion}

  Result := True;
  Try
    Try
      Qry := fCriaQuery;
      Qry.Close;
      Qry.SQL.Clear;
      Qry.Sql.Add(strSql);
      Qry.ParamByName('CODEMP').AsString := pstrCodEmp;
      Qry.ParamByName('CODITE').AsString := pstrCodIte;

      If blnGrupo then
        Qry.ParamByName('TIPOVG').AsString := penuGrupo.fAsString;

      Qry.Execute;
    Finally
      if Assigned(Qry) then
        FreeAndNil(Qry);
    end;
  Except
    On E: Exception do
    begin
      Result := False;
      pMensagensErro(E.Message,'TChecklistProduto.pApagarChecklist');
    end;
  End;
end;

procedure TChecklistProduto.pAplicarItensChkMer(pcdsItensChkMer: TUniClientDataSet);
begin
  cdsItensChkMer.EmptyDataSet;
  cdsItensChkMer.Data := pcdsItensChkMer.Data;
end;

procedure TChecklistProduto.pCarregar(const pstrCodIte: String; penuGrupoChklist: TTipoCheckList;
           blnSomenteAssociado: Boolean; pstrCodEmp: String = '');
  Var
    blnFiltrarItem: Boolean;

begin
  pLimpar;
  FenuGrupoChklist := penuGrupoChklist;
  blnFiltrarItem := Not fEmptyStr(pstrCodIte);

  if blnFiltrarItem then
  begin
    if fEmptyStr(pstrCodEmp) then
      FstrCodEmp := VS_strCodEmp
    else
      FstrCodEmp := pstrCodEmp;

    FstrAutInc := fObterAutIncIteGer(pstrCodIte, FstrCodEmp);

    if fEmptyStr(FstrAutInc) then
    begin
      fMensagem('Atenção!',
                'Não foi possível localizar o produto!'
                  +sLineBreak+'Checklist do item não foi carregado.',
                ['&Ok']);
      pLimpar;
      exit;
    end
    else
      FstrCodIte := pstrCodIte;
  end;

  Try
    fCarregarChecklist(FstrAutInc, penuGrupoChklist, blnSomenteAssociado, cdsItensChkMer);
  Except
    On E: Exception do
    begin
      pMensagensErro(E.Message, 'TChecklistProduto.pCarregar');
    end;
  End;
end;


procedure TChecklistProduto.pFiltrarDados(pcdsCheckList: TUniClientDataSet; penuFiltro: TTipoFiltroDados);
Const
    FILTROS: Array [0..1] of String = (' (SITUACAO = ''1'' ) ',
                                       ' (SITUACAO = ''2'' )  ');

begin
  pcdsCheckList.Filtered := False;

  if penuFiltro in [IncluirOuAtualizar, Excluir] then
    pcdsCheckList.Filter := FILTROS[Ord(penuFiltro)]
  else
    pcdsCheckList.Filter := EmptyStr;

  pcdsCheckList.Filtered := Not fEmptyStr(pcdsCheckList.Filter);
end;

procedure TChecklistProduto.pInserirItem(recItem: TRecItemCheckListGarantia);
  Var
    lRecItem: TRecItemCheckListGarantia;
    blnEditar, blnInserir: Boolean;
begin
  blnEditar := False;
  blnInserir := False;

  if (FenuGrupoChklist.fAsString <> '') and (recItem.enuChkList <> FenuGrupoChklist) then
    Exit;

  if recItem.strAutoincrem <> cdsItensChkMer.FieldByName('AUTOINCREM').AsString Then
  begin
    if cdsItensChkMer.Locate('AUTOINCREM',recItem.strAutoincrem,[]) then
    begin
      lrecItem := fGetRecItemCheckListGarantia;
      if lrecItem = lrecItem then
        Exit;

      blnEditar := True;
    end;
  end
  else
    blnEditar := True;

  if blnEditar then
    cdsItensChkMer.Edit
  else
    blnInserir := True;

  if blnInserir then
  begin
    if recItem.blnAssociado = False then //se não associado, não precisa adicionar porque não vai gravar ITECVG
      Exit;

    cdsItensChkMer.Append;
    cdsItensChkMer.FieldByName('ITE_CODITE').AsString := recItem.strCodIte;
    cdsItensChkMer.FieldByName('ITE_CODEMP').AsString := recItem.strCodEmp;
    cdsItensChkMer.FieldByName('AUTOINCREM').AsString := recItem.strIteAutInc;
    cdsItensChkMer.FieldByName('ITE_INCCVG').AsString := recItem.strAutoincrem;
    cdsItensChkMer.FieldByName('CVG_CODIGO').AsString := recItem.strCodigo;
    cdsItensChkMer.FieldByName('CVG_TIPOVG').AsString := recItem.enuChkList.fAsString;
    cdsItensChkMer.FieldByName('CVG_TIPORE').AsString := recItem.enuResultado.fAsString;
    cdsItensChkMer.FieldByName('CVG_DESCRI').AsString := recItem.strDescricao;
  end;

  if cdsItensChkMer.State in [dsInsert, dsEdit] then
  begin
    cdsItensChkMer.FieldByName('ITE_CONTEU').AsString := recItem.strConteudo;
    cdsItensChkMer.FieldByName('ASSOCIADO').AsString := ifthen(recItem.blnAssociado, VSIM, VNAO);
    cdsItensChkMer.FieldByName('SITUACAO').AsString := recItem.strSituacao;
    cdsItensChkMer.Post;
  end;
end;

procedure TChecklistProduto.pLimpar;
begin
  FstrAutInc := EmptyStr;
  FstrCodEmp := EmptyStr;
  FstrAutInc := EmptyStr;
  FenuGrupoChklist.pSetAsString('');
  if Assigned(cdsItensChkMer) and cdsItensChkMer.Active then
    cdsItensChkMer.Close;
end;

{ TChecklistProduto.TChecklistGravar }

function TChecklistProduto.TChecklistGravar.fGravarChecklist(const pstrAutInc: String;
  pcdsSource: TUniClientDataSet; pTipoCheckList: TTipoCheckList): Boolean;

begin
  Result := True;
  Self.FIncIte := pstrAutInc;
  FcdsSource := pcdsSource;
  FTipoCheckList := pTipoCheckList;
  Try
    Try
      pExcluir;
      pInserir;
    Except
      On E: Exception do
      begin
        Result := False;
        pMensagensErro(e.Message, 'TChecklistProduto.fGravar');
      end;
    end;
  Finally

    if Assigned(FqryITECVG) then
      FreeAndNil(FqryITECVG);

  End;
end;

procedure TChecklistProduto.TChecklistGravar.pCriarqryIteCVG;

begin
  Try
    If Not Assigned(FqryIteCVG) Then
      FqryITECVG := fCriaQuery;
    if FqryITECVG.Active then
      FqryITECVG.Close;
    FqryITECVG.SQL.Clear;
  Except
    On E: Exception do
      pMensagensErro(e.Message,'TChecklistProduto.TChecklistGravar.pCriarqryIteCVG');
  End;
end;

procedure TChecklistProduto.TChecklistGravar.pExcluir;
  Var
    strSQL: String;
    blnFiltrarTipo: Boolean;
begin
  blnFiltrarTipo := Self.FTipoCheckList in [TTipoCheckList.Garantia, TTipoCheckList.Troca];

  strSQL := strSQL + ' DELETE T ';
  strSQL := strSQL + ' FROM  ITECVG T ';

  if (blnFiltrarTipo) Then
    strSQL := strSQL + ' JOIN CADCVG C ON C.AUTOINCREM = T.ITE_INCCVG AND C.CVG_TIPOVG = :TIPO ';

  strSQL := strSQL + ' WHERE T.AUTOINCREM = :INCITE ';


  pCriarqryIteCVG;
  FqryIteCVG.Sql.Add(strSql);
  FqryIteCVG.ParamByName('INCITE').AsString := FIncIte;

  if (blnFiltrarTipo) Then
    FqryIteCVG.ParamByName('TIPO').AsString := Self.FTipoCheckList.fAsString;

  FqryIteCVG.ExecSQL;
end;

procedure TChecklistProduto.TChecklistGravar.pInserir;
    CONST
    SQL_INSERT: String = 'INSERT INTO ITECVG (AUTOINCREM, ITE_INCCVG, ITE_CONTEU) VALUES (:AUTOINCREM, :ITE_INCCVG, :ITE_CONTEU) ';

  Var
    recItem: TRecItemCheckListGarantia;
begin
  if FcdsSource.IsEmpty Then
    Exit;

  pCriarqryIteCVG;
  FqryIteCVG.Sql.Add(SQL_INSERT);

  FcdsSource.First;
  While Not FcdsSource.Eof do
  begin
    recItem := funcGetRecItem;
    FqryIteCVG.ParamByName('AUTOINCREM').AsString := Self.FIncIte;
    FqryITECVG.ParamByName('ITE_INCCVG').AsString := recItem.strAutoincrem;
    FqryITECVG.ParamByName('ITE_CONTEU').AsString := recItem.fGetConteudo;
    FqryITECVG.ExecSQL;
    FcdsSource.Next;
  end;
end;


end.


