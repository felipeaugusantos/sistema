unit untController.CheckListGarantia;

interface

uses
  Vcl.Controls, Vcl.Forms, System.Classes, System.SysUtils,
  untCadCheckListValidacaoGarantia, Data.DB, UniClientDataSet, Uni, untChecklistGarantia, untZClient, untChkMerTypes,
  untFrameCheckListGarantiaMercadoria, untFrameEdicaoChecklistGarantia;

Type
  TGrupoCheckList =  TTipoCheckList;
  TOpcoesCheckList = TModoFrameCheckList;
  TfraEditCkl = TfraEdicaoChecklistGarantia;
  TFraChkGarMer = TframeCheckListGarantiaMercadoria;
 {$SCOPEDENUMS ON}
  TValidacao = (CodigoInvalido, GrupoInvalido, ConteudoInvalido);
 {$SCOPEDENUMS OFF}
  TSetValidacao = Set of TValidacao;

  TParamChkRec = Record
    Frame: TFraChkGarMer;
    Parent: TWinControl;
  end;

  TParamEdit = Record
    Frame: TfraEditCkl;
    Parent: TWinControl;
  end;

  TGuiaCadProdutos = Record
    fraEdit: TParamEdit;
    fraCklGar: TParamChkRec;
    fraCklTro: TParamChkRec;
  end;


Type
  TCheckListGarantiaController = class

  strict private
    class function fGetSQLCheckListGarantiaItem(const blnItem, blnTipo: Boolean; blnSomenteAssociado: Boolean = False): String; static;
    class function fGetSQLObterAutIncIteGer: String; static;
 private

    function fValidaImportacaoCklMer(enuGrupo: tgrupochecklist; strValor: String; inLinhaAtual: Integer; var strMensagem: string): boolean;
  public
    class function fValidarCodEmp(const strCodEmp: String): String;
    class function fUtilizaCadastroCheckListGarantia: Boolean; //CFG_CHKLGA
    Class function fAutorizacaoUsuarioAcesso(blnExibirMsg: Boolean = True): Boolean;
    class procedure pMontarChecklistEmFrmProdutos(Var pGuiaCadProdutos: TGuiaCadProdutos; pOwner: TComponent);
  {$Region 'Métodos de checklist'}
    class function fValidaImportacaoCklGar(strValor: String; inLinhaAtual: Integer; var strMensagem: string): Boolean;
    function fGeraMensagemValidacao(pstrCodigo: String; pSetValidacao: TSetValidacao): String;

    class function fValidaImportacaoCklTro(strValor: String; inLinhaAtual: Integer; var strMensagem: string): Boolean;

    class procedure pAtualizarChecklist(qryGenPre: TUniquery);
    class function fObterAutIncIteGer(const strCodIte, strCodEmp: String): String;
    class function fCriaCdsChecklistVazio: TUniClientDataSet;
    class function fObterChecklistGarantiaItem(const strIncIte: String; enuGrupo: TTipoCheckList; blnSomenteAssociado: Boolean = False): TZClient;


    class function fGravarChcklistGarantiaItemAlteracaoIndividual(const strCodIte,
          strCodEmp, strChecklistAsJson: String; enuGrupo: TTipoCheckList): Boolean;
    class function fGravarChecklistImportacaoProdutos(cdsProcesso: TZClient; const strCodEmp: String): Boolean;Overload;
    class function fGravarChecklistImportacaoProdutos(cdsProcesso: TZClient; QryEmpresa: TUniQuery): Boolean;overload;

    class procedure pImprimirCheckListGarantia(const strCodIte: String;
                    enuGrupo: TTipoCheckList; blnSomenteAssociado: Boolean; strCodEmp: String);
    class procedure pImprimirCheckListGarantiaMercadoriaItem(const strCodIte: String; strCodEmp: String; blnSomenteAssociado: Boolean);
    class procedure pImprimirCheckListTrocaMercadoria(const strCodIte: String; strCodEmp: String; blnSomenteAssociado: Boolean);
    class procedure pExibirChecklist(const strCodIte: String; enuTipoChecklist: TTipoCheckList; Var strSerializado: String; SetModoFrameCheckList: TSetModoFrameCheckList; strCodEmp: String = '');

    class procedure pExibirChecklistGarantia(const strCodIte: String; strCodEmp: String; blnSomenteAssociado: Boolean; SetModoFrameCheckList: TSetModoFrameCheckList = [ExtrairJson]);
    class procedure pExibirChecklistTroca(const strCodIte: String; strCodEmp: String; blnSomenteAssociado: Boolean; SetModoFrameCheckList: TSetModoFrameCheckList = [ExtrairJson]);

    class procedure pExibirChecklistGarantiaAlt(const strCodIte: String; Var strSerializado: String; strCodEmp: String = '');
    class procedure pExibirChecklistTrocaAlt(const strCodIte: String; Var strSerializado: String; strCodEmp: String  = '');



    class function fChecklistAsStringJson(const strCodIte, strCodEmp: String; enuGrupo: TGrupoCheckList): String;
    class function fSQLChecklistJson(enuGrupo: TGrupoCheckList): String;
    class function fProdutoTemChecklist(const strCodIte, strCodEmp: String; enuGrupoCkl: TGrupoCheckList): Boolean;


  {$Endregion}
  {$Region 'Métodos Assistência técnica'}

    class function fObterAssistenciaTecnica(const strCodIte: String; strCodEmp: String = ''): String;
    class function fRetornaNomeAssistenciaTecnica(const strCodAtc: String): String;
    class procedure pImprimirFichaAssistenciaTecnica(const strCodAtc: String);
    class function fCadAssistenciaAtivo(strCodAtc: String): Boolean;

  {$Endregion}
  end;


implementation
  uses
    untFuncoesSimples, System.Variants, untConsultas, untCadAssistenciaTecnica,
    untTypesSistema, untTChecklistProduto;


class function TCheckListGarantiaController.fGetSQLCheckListGarantiaItem(const blnItem,
  blnTipo: Boolean; blnSomenteAssociado: Boolean = False): String;
begin
  Result := TfrmCadChecklistValidacaoGarantia.fGetSQLCheckListGarantiaItem(blnItem,
    blnTipo, blnSomenteAssociado);
end;

class function TCheckListGarantiaController.fGetSQLObterAutIncIteGer: String;
begin
  Result := ' SELECT AUTOINCREM FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ';
end;


class function TCheckListGarantiaController.fObterAssistenciaTecnica(const strCodIte: String; strCodEmp: String = ''): String;
  CONST
    SQL_PESQ: String = 'SELECT ITE_CODATC FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ';
  Var
    Qry: TUniQuery;
    strCodEmpAux: String;
begin
  if fEmptyStr(strCodEmpAux) then
    strCodEmpAux := VS_strCodEmp
  else
    strCodEmpAux := strCodEmp;
  Result := EmptyStr;
  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(SQL_PESQ);
    Qry.ParamByName('CODITE').AsString := strCodIte;
    Qry.ParamByName('CODEMP').AsString := strCodEmpAux;
    Qry.Open;
    if Not Qry.IsEmpty then
      Result := Qry.FieldByName('ITE_CODATC').AsString;
    Qry.Close;
  Finally
    if Assigned(Qry) Then
      FreeAndNil(Qry);
  End;
end;

class function TCheckListGarantiaController.fObterAutIncIteGer(const strCodIte, strCodEmp: String): String;
  Var
    Qry: TUniQuery;
    strSQL: String;
begin
  Result := EmptyStr;
  Qry := Nil;
  strSql := fGetSQLObterAutIncIteGer;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.SQL.Add(strSql);
    Qry.ParamByName('CODITE').AsString := strCodIte;
    Qry.ParamByName('CODEMP').AsString := TCheckListGarantiaController.fValidarCodEmp(strCodEmp);
    Qry.Open;
    if Qry.IsEmpty Then
      Exit;
    Result := Qry.FieldByName('AUTOINCREM').AsString;
  Finally
    if Assigned(Qry)Then
      FreeAndNil(Qry);
  End;
end;

class function TCheckListGarantiaController.fObterChecklistGarantiaItem(
  const strIncIte: String; enuGrupo: TTipoCheckList; blnSomenteAssociado: Boolean = False): TZClient;
  Var
    strSql: String;
    blnFiltrarGrupo, blnFiltrarItem: Boolean;
begin
  blnFiltrarItem :=  Not fEmptyStr(strIncIte);
  blnFiltrarGrupo :=  enuGrupo in [TTipoCheckList.Garantia, TTipoCheckList.Troca];
  strSQL := TCheckListGarantiaController.fGetSQLCheckListGarantiaItem(blnFiltrarItem, blnFiltrarGrupo, blnSomenteAssociado);
  Result := Nil;
  Try
    Result := TZClient.Create(Nil);
    Result.Close;
    Result.qryQuery.Sql.Clear;
    Result.qryQuery.Sql.Add(strSQL);

    if blnFiltrarItem Then
      Result.qryQuery.ParamByName('INCITE').AsString := strIncIte;

    if blnFiltrarGrupo then
      Result.qryQuery.ParamByName('TIPOVG').AsString := enugrupo.fAsString;

    Result.Open;
  Except
    on E: Exception do
    begin
      pMensagensErro(e.Message,'TfrmChecklistValidacaoGarantia.fObterChecklistGarantia');
    end;
  End;
end;


class function TCheckListGarantiaController.fProdutoTemChecklist(const strCodIte, strCodEmp: String;
  enuGrupoCkl: TGrupoCheckList): Boolean;
  Var
    Qry: TUniquery;
    strSQL: String;
begin
  Qry := Nil;
  Result := False;

  strSQL := 'SELECT COUNT(1) AS TOTAL ';
  strSQL := strSQL + ' FROM ITEGER I ';
  strSQL := strSQL + ' JOIN ITECVG I2 ON I2.AUTOINCREM = I.AUTOINCREM ';
  strSQL := strSQL + ' JOIN CADCVG C ON C.AUTOINCREM = I2.ITE_INCCVG AND C.CVG_TIPOVG = :GRUPO ';
  strSQL := strSQL + ' WHERE I.ITE_CODITE = :CODITE AND I.ITE_CODEMP = :CODEMP ';

  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add(strSQL);
    Qry.ParamByName('CODITE').AsString := strCodIte;
    Qry.ParamByName('CODEMP').AsString := strCodEmp;
    Qry.ParamByName('GRUPO').AsString := enuGrupoCkl.fAsString;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    Qry.First;
    Result := Qry.FieldByName('TOTAL').AsInteger > 0;

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry)
  End;
end;

class function TCheckListGarantiaController.fRetornaNomeAssistenciaTecnica(const strCodAtc: String): String;
  Var
    Qry: TUniquery;
begin
  Result := EmptyStr;
  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add('SELECT ATC_NOMEMP FROM CADATC WHERE ATC_CODIGO = :CODIGO ');
    Qry.ParamByName('CODIGO').AsString := strCodAtc;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    Result := Qry.FieldByName('ATC_NOMEMP').AsString;
  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry)
  End;
end;

class function TCheckListGarantiaController.fSQLChecklistJson(enuGrupo: TGrupoCheckList): String;
begin
  Result :=          ' SELECT CONCAT("[", ';
  Result := Result + '               GROUP_CONCAT(T2.CHKLST order by T2.CONTEUDO, T2.CVG_TIPORE DESC), ';
  Result := Result + '               "]") AS CKLJSN ';
  Result := Result + ' FROM ITEGER T1 ';

  Result := Result + ' INNER JOIN (SELECT T3.AUTOINCREM, T3.CONTEUDO, T3.CVG_TIPORE, ';
  Result := Result + '                   IF(T3.CONTEUDO = "N", ';

                                            // "XXXXX"
  Result := Result + '                      CONCAT(''"'',T3.CVG_CODIGO,''"''), ';

  //                                        {"CODIGO":"XXXX","CONTEUDO":"XXXXX"}
  Result := Result + '                      CONCAT(''{"CODIGO":"'', T3.CVG_CODIGO, ';
  Result := Result +                              ' ''","CONTEUDO":"'',T3.ITE_CONTEU, ''"}'')) AS CHKLST ';

  Result := Result + '             FROM (SELECT T4.AUTOINCREM, T4.ITE_INCCVG, T4.ITE_CONTEU, T5.CVG_CODIGO, ';
  Result := Result + '                          T5.CVG_TIPOVG, T5.CVG_TIPORE, T5.CVG_DESCRI, ';
  Result := Result + '                          CASE IFNULL(T4.ITE_CONTEU,"") ';
  Result := Result + '                            WHEN "" THEN "N" ';
  Result := Result + '                            WHEN "N/A" THEN "N" ';
  Result := Result + '                          ELSE "S" END AS CONTEUDO ';
  Result := Result + '                   FROM ITECVG T4 ';
  Result := Result + '                   JOIN CADCVG T5 ON T5.AUTOINCREM = T4.ITE_INCCVG ';

  if enuGrupo in [TTipoCheckList.Garantia,TTipoCheckList.Troca]  then
    Result := Result + Format(' AND T5.CVG_TIPOVG = %s ',[QuotedStr(enuGrupo.fAsString)]);

  Result := Result + '                   order by T5.CVG_TIPORE ASC) T3 ';
  Result := Result + '             ) T2 ON T2.AUTOINCREM = T1.AUTOINCREM ';

  Result := Result + ' WHERE T1.ITE_CODITE = G.ITE_CODITE AND T1.ITE_CODEMP = G.ITE_CODEMP ';
  Result := Result + ' GROUP BY T1.ITE_CODITE, T1.ITE_CODEMP ';

end;

class function TCheckListGarantiaController.fAutorizacaoUsuarioAcesso(blnExibirMsg: Boolean = True): Boolean;
  CONST
    DIREITO_ACESSO: String = 'CHKMTG';
begin
  Result := fVerificaAcessoSistema(DIREITO_ACESSO);
  If Not (Result) Then
  Begin
    if blnExibirMsg then
      fMensagem('', 'Esse usuário não tem direito a acessar esta rotina!', ['&Ok']);
  End;
end;

class function TCheckListGarantiaController.fCadAssistenciaAtivo(strCodAtc: String): Boolean;
  Var
    Qry: TUniquery;
begin
  Qry := Nil;
  Result := False;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Clear;
    Qry.Sql.Add('SELECT ATC_SITUAC FROM CADATC WHERE ATC_CODIGO = :CODIGO ');
    Qry.ParamByName('CODIGO').AsString := strCodAtc;
    Qry.Open;

    if Qry.IsEmpty then
      Exit;

    Qry.First;
    Result := Qry.FieldByName('ATC_SITUAC').AsString = 'A';

  Finally
    if Assigned(Qry) then
      FreeAndNil(Qry)
  End;
end;

class function TCheckListGarantiaController.fChecklistAsStringJson(const strCodIte, strCodEmp: String;
  enuGrupo: TGrupoCheckList): String;
  Var
    lcklProduto: TChecklistProduto;
begin
  Result := EmptyStr;
  Try
    lcklProduto := TChecklistProduto.Create;
    lcklProduto.pCarregar(strCodIte, enuGrupo, True, strCodEmp);
    Result := lcklProduto.fGetAsStringJson(True);
  Finally
    If Assigned(lcklProduto) then
      FreeAndNil(lcklProduto);
  End;
end;

class function TCheckListGarantiaController.fUtilizaCadastroCheckListGarantia: Boolean;
begin
 Result := fCfgSis('CHKLGA', varString)  = 'S';
end;


class function TCheckListGarantiaController.fValidaImportacaoCklGar(strValor: String; inLinhaAtual: Integer;
  var strMensagem: string): Boolean;
  Var
    objController: TCheckListGarantiaController;
begin
  objController := Nil;
  Try
    objController := TCheckListGarantiaController.Create;
    Result := objController.fValidaImportacaoCklMer(TGrupoCheckList.Garantia, strValor,inLinhaAtual, strMensagem);
  Finally
    if Assigned(objController) then
      FreeAndNil(objController);
  End;
end;

function TCheckListGarantiaController.fGeraMensagemValidacao(pstrCodigo: String; pSetValidacao: TSetValidacao): String;
Var
  lstrMsg: String;
begin
  if TValidacao.CodigoInvalido in pSetValidacao then
    lstrMsg := 'item não cadastrado'
  else if TValidacao.GrupoInvalido in pSetValidacao then
    lstrMsg := 'grupo checklist inválido'
  else if TValidacao.ConteudoInvalido in pSetValidacao then
    lstrMsg := 'tamanho conteúdo inválido';

 Result := Format('%s - %s',[pstrCodigo, lstrMsg]);
end;

function TCheckListGarantiaController.fValidaImportacaoCklMer(enuGrupo: tgrupochecklist; strValor: String; inLinhaAtual: Integer; var strMensagem: string): boolean;
  Var
    enuGrupoCkl: TGrupoCheckList;
    objChkList: TChecklistProduto;
    objImportJSon: TChekListImportJson;
    strGrupo: String;
    recItemCkl: TRecItemCheckListGarantia;
    SetValidacao: TSetValidacao;
    intIdx: Integer;
    recItemImpJson: TrecItemCklImportJson;

begin


  enuGrupoCkl.pSetAsString('');
  case enuGrupo of
    TGrupoCheckList.Garantia: strGrupo := 'garantia';
    TGrupoCheckList.Troca: strGrupo := 'troca';
  end;

  objChkList := Nil;
  objImportJSon := Nil;
  Result := False;
  Try
    objChkList := TChecklistProduto.Create;
    objImportJSon := objChkList.fCarregarJson(strValor, Result);

    if Not Result then
    begin
      strMensagem := Format('Checklist de %s não é válido',[strGrupo]);
      Exit;
    end;

    objChkList.pCarregar(EmptyStr, enuGrupoCkl, False);

    for intIdx := Low(objImportJSon.arrItensCkl) to Low(objImportJSon.arrItensCkl) do
    begin
      SetValidacao := [];
      recItemImpJson := objImportJSon.arrItensCkl[intIdx];

      if objChkList.cdsItensChkMer.Locate('CVG_CODIGO', recItemImpJson.strCodigo,[]) then
      begin
        recItemCkl := objChkList.fGetRecItemCheckListGarantia;
        if Not (recItemCkl.enuChkList = enuGrupo) then
          include(SetValidacao, TValidacao.GrupoInvalido);

        if Length(recItemImpJson.strConteudo) > recItemCkl.fTamanhoConteudo then
          include(SetValidacao, TValidacao.ConteudoInvalido);
      end
      else
        SetValidacao := [TValidacao.CodigoInvalido];

      Result := SetValidacao = [];

      if Not Result then
      begin
        strMensagem := fGeraMensagemValidacao(recItemImpJson.strCodigo, SetValidacao);
        Exit;
      end;


    end;
  Finally
    if Assigned(objChkList) then
      FreeAndNil(objChkList);

    if Assigned(objImportJSon) then
      FreeAndNil(objImportJSon);

  end;
end;

class function TCheckListGarantiaController.fValidaImportacaoCklTro(strValor: String; inLinhaAtual: Integer;
  var strMensagem: string): Boolean;
  Var
    objController: TCheckListGarantiaController;
begin
  objController := Nil;
  Try
    objController := TCheckListGarantiaController.Create;
    Result := objController.fValidaImportacaoCklMer(TGrupoCheckList.Troca, strValor,inLinhaAtual, strMensagem);
  Finally
    if Assigned(objController) then
      FreeAndNil(objController);
  End;
end;

class function TCheckListGarantiaController.fValidarCodEmp(const strCodEmp: String): String;
begin
  if fEmptyStr(strCodEmp) then
    Result := VS_strCodEmp
  else
    Result := strCodEmp;
end;

class procedure TCheckListGarantiaController.pAtualizarChecklist(qryGenPre: TUniquery);
  Var
    objField, objFieldNov: TField;
    blnContinuar: Boolean;
    strCodIte: String;
begin
  strCodIte := qryGenPre.FindField('ITE_CODITE').AsString;
  objField := qryGenPre.FindField('TMP_CKLGAR');
  objFieldNov := qryGenPre.FindField('TMP_CKLGAR_NOV');
  blnContinuar := Assigned(objField) and Assigned(objFieldNov);

  If blnContinuar then
  begin
    if objField.AsString <> objFieldNov.AsString then
      TCheckListGarantiaController.fGravarChcklistGarantiaItemAlteracaoIndividual(strCodIte, VS_strCodEmp,
        objFieldNov.AsString, TTipoCheckList.Garantia);
  end;


  objField := qryGenPre.FindField('TMP_CKLTRO');
  objFieldNov := qryGenPre.FindField('TMP_CKLTRO_NOV');
  blnContinuar := Assigned(objField) and Assigned(objFieldNov);

  If blnContinuar then
  begin
    if objField.AsString <> objFieldNov.AsString then
      TCheckListGarantiaController.fGravarChcklistGarantiaItemAlteracaoIndividual(strCodIte, VS_strCodEmp,
        objFieldNov.AsString, TTipoCheckList.Troca);
  end;
end;


class procedure TCheckListGarantiaController.pExibirChecklist(const strCodIte: String;
  enuTipoChecklist: TTipoCheckList; Var strSerializado: String; SetModoFrameCheckList: TSetModoFrameCheckList; strCodEmp: String = '');
  Var
    frmChecklist: TfrmChecklistGarantia;
begin
  frmChecklist := Nil;
  Try
    frmChecklist := TfrmChecklistGarantia.CreateChecklist(Nil, enuTipoChecklist, strCodIte);
    frmChecklist.fraChecklist.blnSomenteOpcoesItem := True;
    frmChecklist.blnPermitirEdicao := Not (TModoFrameCheckList.Leitura in SetModoFrameCheckList);
    frmChecklist.blnHabilitaExportacaoJson := TModoFrameCheckList.ExtrairJson in SetModoFrameCheckList;

    if Not fEmptyStr(strSerializado) then
    begin
      frmChecklist.fraChecklist.pCarregarChecklistDeJson(strSerializado);
    end;

    frmChecklist.ShowModal;
    If frmChecklist.ModalResult = mrOk then
    begin
      frmChecklist.fraChecklist.checkListProduto.pAplicarItensChkMer(frmChecklist.fraChecklist.cdsDados);
      strSerializado := frmChecklist.fraChecklist.checkListProduto.fGetAsStringJson(True);
      if strSerializado = '[]' then
        strSerializado := Emptystr;
    end;
    frmChecklist.Release;
  Finally
    if Assigned(frmChecklist) Then
      pFreeAndNil(frmChecklist);
  End;
end;

class procedure TCheckListGarantiaController.pExibirChecklistGarantia(const strCodIte: String; strCodEmp: String; blnSomenteAssociado: Boolean; SetModoFrameCheckList: TSetModoFrameCheckList = [ExtrairJson]);
  Var
    strJson: String;
begin
  strJson := EmptyStr;

  if blnSomenteAssociado and (Not TCheckListGarantiaController.fProdutoTemChecklist(strCodIte, strCodEmp, TTipoCheckList.Garantia)) then
    Exit;

  TCheckListGarantiaController.pExibirChecklist(strCodIte,TTipoCheckList.Garantia, strJson, SetModoFrameCheckList, strCodEmp);
end;

class procedure TCheckListGarantiaController.pExibirChecklistGarantiaAlt(const strCodIte: String; Var strSerializado: String; strCodEmp: String = '');
begin
  TCheckListGarantiaController.pExibirChecklist(strCodIte, TTipoCheckList.Garantia, strSerializado, [ExtrairJson], strCodEmp);
end;

class procedure TCheckListGarantiaController.pExibirChecklistTroca(const strCodIte: String; strCodEmp: String; blnSomenteAssociado: Boolean; SetModoFrameCheckList: TSetModoFrameCheckList = [ExtrairJson]);
  Var
    strJson: String;
begin
  if blnSomenteAssociado and (Not fProdutoTemChecklist(strCodIte, strCodEmp, TTipoCheckList.Troca)) then
    Exit;
  strJson := '';
  TCheckListGarantiaController.pExibirChecklist(strCodIte, TTipoCheckList.Troca, strJson, SetModoFrameCheckList, strCodEmp);
end;

class procedure TCheckListGarantiaController.pExibirChecklistTrocaAlt(const strCodIte: String; Var strSerializado: String; strCodEmp: String = '');
begin
  TCheckListGarantiaController.pExibirChecklist(strCodIte, TTipoCheckList.Troca, strSerializado, [ExtrairJson], strCodEmp,);
end;



class procedure TCheckListGarantiaController.pImprimirCheckListGarantia(const strCodIte: String;
  enuGrupo: TTipoCheckList; blnSomenteAssociado: Boolean; strCodEmp: String);
  Var
    strCodEmpAux: String;
    strIncIte: String;
begin
  strIncIte := EmptyStr;
  if Not fEmptyStr(strCodIte) then
  begin
    if fEmptyStr(strCodEmp) Then
      strCodEmpAux := VS_strCodEmp
    else
      strCodEmpAux := strCodEmp;

    strIncIte := TCheckListGarantiaController.fObterAutIncIteGer(strCodIte, strCodEmpAux);
  end;

  if fEmptyStr(strIncIte) then
  begin
    pMensagemOk('Produto não localizado!');
    Exit;
  end;

  TfrmCadChecklistValidacaoGarantia.pImprimirCheckListGarantia(strIncIte, enuGrupo, blnSomenteAssociado);
end;

class procedure TCheckListGarantiaController.pImprimirCheckListGarantiaMercadoriaItem(const strCodIte: String; strCodEmp: String; blnSomenteAssociado: Boolean);
  Var
    enuGrupo: TTipoCheckList;
begin
  enuGrupo := TTipoCheckList.Garantia;

  if blnSomenteAssociado and (Not fProdutoTemChecklist(strCodIte, strCodEmp, enuGrupo)) then
    Exit;

  TCheckListGarantiaController.pImprimirCheckListGarantia(strCodIte, enuGrupo, True, strCodEmp);
end;

class procedure TCheckListGarantiaController.pImprimirCheckListTrocaMercadoria(const strCodIte: String; strCodEmp: String; blnSomenteAssociado: Boolean);
  Var
    enuGrupo: TTipoCheckList;
begin
  enuGrupo := TTipoCheckList.Troca;

  if blnSomenteAssociado and (Not TCheckListGarantiaController.fProdutoTemChecklist(strCodIte, strCodEmp, enuGrupo)) then
    Exit;

  TCheckListGarantiaController.pImprimirCheckListGarantia(strCodIte, enuGrupo, True, strCodEmp);
end;

class procedure TCheckListGarantiaController.pImprimirFichaAssistenciaTecnica(const strCodAtc: String);
begin
  TfrmCadAssistenciaTecnica.pImprimirFichaAssistenciaTecnica(strCodAtc);
end;

class procedure TCheckListGarantiaController.pMontarChecklistEmFrmProdutos(var pGuiaCadProdutos: TGuiaCadProdutos; pOwner: TComponent);
begin
  Try
    pGuiaCadProdutos.fraEdit.Frame := TfraEdicaoChecklistGarantia.Create(pOwner);
    pGuiaCadProdutos.fraEdit.Frame.Parent := pGuiaCadProdutos.fraEdit.Parent;
    pGuiaCadProdutos.fraEdit.Frame.Align := alClient;

    pGuiaCadProdutos.fraCklGar.Frame := TframeCheckListGarantiaMercadoria.Create(pOwner);
    pGuiaCadProdutos.fraCklGar.Frame.Name := 'fraCklMerGar';
    pGuiaCadProdutos.fraCklGar.Frame.Parent := pGuiaCadProdutos.fraCklGar.Parent;
    pGuiaCadProdutos.fraCklGar.Frame.Align := alClient;
    pGuiaCadProdutos.fraCklGar.Frame.Tag := 1;
    pGuiaCadProdutos.fraCklGar.Frame.enuGrupo := TTipoCheckListGrupo.Garantia;
    pGuiaCadProdutos.fraCklGar.Frame.pSetFrameEdicao(pGuiaCadProdutos.fraEdit.Frame);
    pGuiaCadProdutos.fraCklGar.Frame.blnSomenteLeitura := True;
    pGuiaCadProdutos.fraCklGar.Frame.blnSomenteOpcoesItem := True;
    pGuiaCadProdutos.fraCklGar.Frame.pFiltrarSomenteAtivos(True);
    pGuiaCadProdutos.fraCklGar.Frame.pOcultarPainel(True);

    pGuiaCadProdutos.fraEdit.Frame.pSetFrameCheckList(TTipoCheckListGrupo.Garantia, pGuiaCadProdutos.fraCklGar.Frame);

    pGuiaCadProdutos.fraCklTro.Frame := TframeCheckListGarantiaMercadoria.Create(pOwner);
    pGuiaCadProdutos.fraCklTro.Frame.Name := 'fraCklMerTro';
    pGuiaCadProdutos.fraCklTro.Frame.Parent := pGuiaCadProdutos.fraCklTro.Parent;
    pGuiaCadProdutos.fraCklTro.Frame.Align := alClient;
    pGuiaCadProdutos.fraCklTro.Frame.Tag := 2;
    pGuiaCadProdutos.fraCklTro.Frame.enuGrupo := TTipoCheckListGrupo.Troca;
    pGuiaCadProdutos.fraCklTro.Frame.pSetFrameEdicao(pGuiaCadProdutos.fraEdit.Frame);
    pGuiaCadProdutos.fraCklTro.Frame.blnSomenteLeitura := True;
    pGuiaCadProdutos.fraCklTro.Frame.blnSomenteOpcoesItem := True;
    pGuiaCadProdutos.fraCklTro.Frame.pFiltrarSomenteAtivos(True);
    pGuiaCadProdutos.fraCklTro.Frame.pOcultarPainel(True);

    pGuiaCadProdutos.fraEdit.Frame.pSetFrameCheckList(TTipoCheckListGrupo.Troca, pGuiaCadProdutos.fraCklTro.Frame);

  Except
    On E: Exception do
    begin
      pMensagensErro(e.Message, 'TCheckListGarantiaController.pMontarChecklistEmFrmProdutos');
    end;
  End;
end;

class function TCheckListGarantiaController.fGravarChcklistGarantiaItemAlteracaoIndividual(const strCodIte,
  strCodEmp, strChecklistAsJson: String ; enuGrupo: TTipoCheckList): Boolean;
  Var
    objChecklistProduto: TChecklistProduto;
begin
  objChecklistProduto := TChecklistProduto.Create;
  Try
    Result := objChecklistProduto.fRefazCheckList(strCodIte, strCodEmp, strChecklistAsJson, enuGrupo);
  Finally
    if Assigned(objChecklistProduto) then
      FreeAndNil(objChecklistProduto);
  End;
end;

class function TCheckListGarantiaController.fGravarChecklistImportacaoProdutos(cdsProcesso: TZClient;
  const strCodEmp: String): Boolean;

  Var
    strCodIte: String;

    cdsProcessoITE_CODITE,
    cdsProcessoITE_CKLGAR,
    cdsProcessoITE_CKLTRO: TField;

begin
  Result := True;

  cdsProcessoITE_CODITE := cdsProcesso.FindField('ITE_CODITE');
  cdsProcessoITE_CKLGAR := cdsProcesso.FindField('ITE_CKLGAR_NOV');
  cdsProcessoITE_CKLTRO := cdsProcesso.FindField('ITE_CKLTRO_NOV');

  if Not (Assigned(cdsProcessoITE_CKLGAR) AND Assigned(cdsProcessoITE_CKLTRO)) then
  Exit;

  strCodIte := cdsProcessoITE_CODITE.AsString;

  if Not fEmptyStr(cdsProcessoITE_CKLGAR.AsString) then
    TCheckListGarantiaController.fGravarChcklistGarantiaItemAlteracaoIndividual(strCodIte, strCodEmp,
      cdsProcessoITE_CKLGAR.AsString, TGrupoCheckList.Garantia);

  if Not fEmptyStr(cdsProcessoITE_CKLTRO.AsString) then
    TCheckListGarantiaController.fGravarChcklistGarantiaItemAlteracaoIndividual(strCodIte, strCodEmp,
      cdsProcessoITE_CKLTRO.AsString, TGrupoCheckList.Troca);

end;

class function TCheckListGarantiaController.fGravarChecklistImportacaoProdutos(cdsProcesso: TZClient;
  QryEmpresa: TUniQuery): Boolean;
  Var
    strCodIte, strCodEmp: String;
    cdsProcessoITE_CODITE,
    cdsProcessoITE_CKLGAR,
    cdsProcessoITE_CKLTRO,
    qryEmpresaEMP_CODEMP: TField;
begin

  cdsProcessoITE_CODITE := cdsProcesso.FindField('ITE_CODITE');
  cdsProcessoITE_CKLGAR := cdsProcesso.FindField('ITE_CKLGAR_NOV');
  cdsProcessoITE_CKLTRO := cdsProcesso.FindField('ITE_CKLTRO_NOV');
  qryEmpresaEMP_CODEMP := QryEmpresa.FindField('EMP_CODEMP');

  Result := True;

  if Not (Assigned(cdsProcessoITE_CKLGAR) or Assigned(cdsProcessoITE_CKLTRO)) then
    Exit;

  cdsProcesso.First;
  While Not cdsProcesso.Eof do
  begin
    strCodIte := cdsProcessoITE_CODITE.AsString;
    QryEmpresa.First;
    While Not QryEmpresa.Eof do
    begin
      strCodEmp := qryEmpresaEMP_CODEMP.AsString;
      IF Assigned( cdsProcessoITE_CKLGAR) then
      begin
        TCheckListGarantiaController
          .fGravarChcklistGarantiaItemAlteracaoIndividual
            (strCodIte, strCodEmp, cdsProcessoITE_CKLGAR.AsString, TTipoCheckList.Garantia);
      end;

      if Assigned(cdsProcessoITE_CKLTRO) then
      begin
        TCheckListGarantiaController
          .fGravarChcklistGarantiaItemAlteracaoIndividual
            (strCodIte, strCodEmp, cdsProcessoITE_CKLTRO.AsString, TTipoCheckList.Troca);
      end;
      QryEmpresa.Next;
    end;
    cdsProcesso.Next;
  end;
end;

class function TCheckListGarantiaController.fCriaCdsChecklistVazio: TUniClientDataSet;
  Var
    QryTmp: TZClient;
    strSQL: String;
begin
  QryTmp := Nil;
  Try
    strSQL := ' SELECT I.*, I2.ITE_CODITE, I2.ITE_CODEMP, C.CVG_CODIGO ';
    strSQL := strSQL + ' FROM ITECVG I ';
    strSQL := strSQL + ' LEFT JOIN ITEGER I2 ON I.AUTOINCREM = I2.AUTOINCREM ';
    strSQL := strSQL + ' LEFT JOIN CADCVG C ON C.AUTOINCREM = I.ITE_INCCVG ';
    strSQL := strSQL + ' WHERE FALSE ; ';

    QryTmp := TZClient.Create(Nil);
    QryTmp.Close;
    QryTmp.qryQuery.SQL.Clear;
    QryTmp.qryQuery.Sql.Add(strSQL);
    QryTmp.Open;
    Result := TUniClientDataSet.Create(Nil);
    Result.Data := QryTmp.Data;
  Finally
    if Assigned(QryTmp) Then
      QryTmp.Free;
  End;
end;

end.


