unit untCFGBAN_Dao;

interface

Uses Classes, DateUtils, StrUtils, SysUtils, DB, UniClientDataSet,
     Uni, System.Variants, untCFGBAN_Class, System.Generics.Collections,
     untFuncoesSimples, untSubjectClass, untSubjectIntf, untGravandoObs, VCL.Forms,
     untTypesSistema;

type
  TCFGBanDao = class(TObject)
  private
     FCodemp: String;
     FCodBan: String;
     FCartei: String;
     FNumPos: String;
     FTipLay: String;
     FDuplicataBoleto: PTDuplicataCtr;

     function fGetSQL(const blnUpdate: Boolean): String;
     function fGetSQLlog: String;
     function fGetSQLFindByCfg:String;
  public
     constructor Create(const strCodemp, strCodBan, strCartei, strNumPos, strTipLay: String; ADuplicataBoleto: PTDuplicataCtr = Nil); overload;

     function fFindByCFG(const strVALCFG: String): TCfgBan;
     function fFindAll: TObjectList<TCfgBan>;
     function fInsert(const objCFGBan: TCfgBan): Boolean;
     function fInsertAll(listCFGBan: TObjectList<TCfgBan>; blnMostraAguarde: Boolean = True): Boolean;
  end;

implementation

{ TCFGBanDao }

constructor TCFGBanDao.Create(const strCodemp, strCodBan, strCartei,
  strNumPos, strTipLay: String; ADuplicataBoleto: PTDuplicataCtr = Nil);
begin
  FCodEmp := strCodEmp;
  FCodBan := strCodBan;
  FCartei := strCartei;
  FNumPos := strNumPos;
  FTipLay := strTipLay;

  FDuplicataBoleto := ADuplicataBoleto;
end;

function TCFGBanDao.fFindAll: TObjectList<TCfgBan>;
var
  qryRegistros: TUniQuery;
  CfgBan: TCfgBan;
begin
  Result := TObjectList<TCfgBan>.Create;

  qryRegistros := Nil;
  Try
    qryRegistros := fCriaQuery();

    qryRegistros.SQL.Text := ' SELECT * FROM CFGBAN ' +
                             ' WHERE ' +
                             '   SIS_CODEMP = :CODEMP AND ' +
                             '   SIS_CODBAN = :CODBAN AND ' +
                             '   SIS_CARTEI = :CARTEI AND ' +
                             '   SIS_TIPLAY = :TIPLAY AND ' +
                             '   SIS_NUMPOS = :NUMPOS';

    qryRegistros.ParamByName('CODEMP').AsString := FCodEmp;
    qryRegistros.ParamByName('CODBAN').AsString := FCodBan;
    qryRegistros.ParamByName('CARTEI').AsString := FCartei;
    qryRegistros.ParamByName('TIPLAY').AsString := FTipLay;
    qryRegistros.ParamByName('NUMPOS').AsString := FNumPos;

    qryRegistros.Open;

    if qryRegistros.IsEmpty then
      Exit;

    while not qryRegistros.eof do
    begin
      CfgBan := TCfgBan.Create;
      CfgBan.CodEmp := qryRegistros.FieldByName('SIS_CODEMP').AsString;
      CfgBan.CodBan := qryRegistros.FieldByName('SIS_CODBAN').AsString;
      CFGBan.CodCFG := qryRegistros.FieldByName('SIS_CODCFG').AsString;
      CFGBan.Descri := qryRegistros.FieldByName('SIS_DESCRI').AsString;
      CFGBan.ValCFG := qryRegistros.FieldByName('SIS_VALCFG').AsString;
      CFGBan.Banco_ := qryRegistros.FieldByName('SIS_BANCO_').AsString;
      CFGBan.Cartei := qryRegistros.FieldByname('SIS_CARTEI').AsString;
      CFGBan.NumPos := qryRegistros.FieldByname('SIS_NUMPOS').AsString;
      CFGBan.UltAlt := qryRegistros.FieldByname('SIS_ULTALT').AsDateTime;
      CFGBan.Chave_ := qryRegistros.FieldByname('SIS_CHAVE_').AsString;
      CFGBan.TipLay := qryRegistros.FieldByname('SIS_TIPLAY').AsString;

      Result.Add(CfgBan);

      qryRegistros.Next;
    end;
  Finally
    FreeAndNilDatasets(qryRegistros);
  End;
end;

function TCFGBanDao.fFindByCFG(const strVALCFG: String): TCfgBan;
var
  qryRegistros: TUniQuery;
begin
  Result := nil;
  qryRegistros := Nil;
 
  Try
    qryRegistros := fCriaQuery();

    qryRegistros.SQL.Text := '';
    qryRegistros.SQL.Text := fGetSQLFindByCfg;

    qryRegistros.ParamByName('CODEMP').AsString := FCodEmp;
    qryRegistros.ParamByName('CODBAN').AsString := FCodBan;
    qryRegistros.ParamByName('CARTEI').AsString := FCartei;
    qryRegistros.ParamByName('NUMPOS').AsString := FNumPos;
    qryRegistros.ParamByName('TIPLAY').AsString := FTipLay;
    qryRegistros.ParamByName('CODCFG').AsString := strVALCFG;

    qryRegistros.Open;

    if qryRegistros.IsEmpty then
      Exit;

    Result := TCfgBan.Create;
    Result.CodEmp := qryRegistros.FieldByName('SIS_CODEMP').AsString;
    Result.CodBan := qryRegistros.FieldByName('SIS_CODBAN').AsString;
    Result.CodCFG := qryRegistros.FieldByName('SIS_CODCFG').AsString;
    Result.Descri := qryRegistros.FieldByName('SIS_DESCRI').AsString;
    Result.ValCFG := qryRegistros.FieldByName('VALCFG').AsString;
    Result.Banco_ := qryRegistros.FieldByName('SIS_BANCO_').AsString;
    Result.Cartei := qryRegistros.FieldByname('SIS_CARTEI').AsString;
    Result.UltAlt := qryRegistros.FieldByname('SIS_ULTALT').AsDateTime;
    Result.Chave_ := qryRegistros.FieldByname('SIS_CHAVE_').AsString;
    Result.TipLay := qryRegistros.FieldByname('SIS_TIPLAY').AsString;
  Finally
    FreeAndNilDatasets(qryRegistros);
  End;
end;

function TCFGBanDao.fGetSQL(const blnUpdate: Boolean): String;
begin
  if not blnUpdate  then
  begin
    Result := ' INSERT INTO CFGBAN '   +
              ' SET ' +
              '   SIS_CODEMP = :CODEMP, ' +
              '   SIS_CODBAN = :CODBAN, ' +
              '   SIS_CODCFG = :CODCFG, ' +
              '   SIS_DESCRI = :DESCRI, ' +
              '   SIS_VALCFG = :VALCFG, ' +
              '   SIS_BANCO_ = :BANCO_, ' +
              '   SIS_CARTEI = :CARTEI, ' +
              '   SIS_NUMPOS = :NUMPOS, ' +
              '   SIS_TIPLAY = :TIPLAY, ' +
              '   SIS_CHAVE_ = :CHAVE_, ' +
              '   SIS_ULTALT = :ULTALT  ';
  end
  else
  begin
    Result := ' UPDATE CFGBAN '   +
              ' SET ' +
              '   SIS_DESCRI = :DESCRI, ' +
              '   SIS_VALCFG = :VALCFG, ' +
              '   SIS_BANCO_ = :BANCO_, ' +
              '   SIS_ULTALT = :ULTALT, ' +
              '   SIS_CHAVE_ = :CHAVE_  ' +
              ' WHERE                   ' +
              '   SIS_CODEMP = :CODEMP AND ' +
              '   SIS_CODBAN = :CODBAN AND ' +
              '   SIS_CODCFG = :CODCFG AND ' +
              '   SIS_NUMPOS = :NUMPOS AND ' +
              '   SIS_TIPLAY = :TIPLAY AND ' +
              '   SIS_CARTEI = :CARTEI ';
  end;
end;

function TCFGBanDao.fGetSQLFindByCfg: String;
begin
  Result :=  ' SELECT SIS_VALCFG AS VALCFG, CFGBAN.*  FROM CFGBAN ' +
             ' WHERE ' +
             '   SIS_CODEMP = :CODEMP AND ' +
             '   SIS_CODBAN = :CODBAN AND ' +
             '   SIS_CARTEI = :CARTEI AND ' +
             '   SIS_NUMPOS = :NUMPOS AND ' +
             '   SIS_TIPLAY = :TIPLAY AND ' +
             '   SIS_CODCFG = :CODCFG ';

  If Assigned(FDuplicataBoleto) Then
  Begin
    If Not fEmptyStr(FDuplicataBoleto.strNumDup) Then
    Begin
      Result :=  ' SELECT                                     ' +
                 '   IFNULL(CAR_VALCFG,SIS_VALCFG) AS VALCFG, ' +
                 '   CFGBAN.*                                 ' +
                 ' FROM                                       ' +
                 '   CFGBAN                                   ' +
                 '  LEFT JOIN CARBOL                   '+
                 '     ON CAR_CHAVE_ = SIS_CHAVE_      '+
                 '    AND CAR_CODCFG = SIS_CODCFG      '+
                 '    AND CAR_NUMDUP = '+ FDuplicataBoleto.strNumDup.QuotedString +
                 '    AND CAR_PARCEL = '+ FDuplicataBoleto.strParcel.QuotedString +
                 '    AND CAR_ESPDOC = '+ FDuplicataBoleto.strEspDoc.QuotedString +
                 '    AND CAR_CODEMP = '+ FDuplicataBoleto.strCodEmp.QuotedString +
                 '    AND CAR_CODCLI = '+ FDuplicataBoleto.strCodCli.QuotedString +
                 ' WHERE ' +
                 '   SIS_CODEMP = :CODEMP AND ' +
                 '   SIS_CODBAN = :CODBAN AND ' +
                 '   SIS_CARTEI = :CARTEI AND ' +
                 '   SIS_NUMPOS = :NUMPOS AND ' +
                 '   SIS_TIPLAY = :TIPLAY AND ' +
                 '   SIS_CODCFG = :CODCFG ';
    End;
  End;

end;

function TCFGBanDao.fGetSQLlog: String;
begin
  Result := ' INSERT INTO LOGCFB '   +
            ' SET ' +
            '   LOG_CODEMP = :CODEMP, ' +
            '   LOG_CODBAN = :CODBAN, ' +
            '   LOG_CODCFG = :CODCFG, ' +
            '   LOG_DESCRI = :DESCRI, ' +
            '   LOG_VALATU = :VALATU, ' +
            '   LOG_VALANT = :VALANT, ' +
            '   LOG_BANCO_ = :BANCO_, ' +
            '   LOG_CARTEI = :CARTEI, ' +
            '   LOG_NUMPOS = :NUMPOS, ' +
            '   LOG_CODOPE = :CODOPE, ' +
            '   LOG_ULTALT = :ULTALT, ' +
            '   LOG_CHAVE_ = :CHAVE_, ' +
            '   LOG_TIPLAY = :TIPLAY, ' +
            '   AUTOINCREM = :AUTOINCREM ';
end;

function TCFGBanDao.fInsert(const objCFGBan: TCfgBan): Boolean;
var
  qryRegistros: TUniQuery;
  blnUpdate   : Boolean;
  CFGBan      : TCfgBan;
begin
  if Not Assigned(objCFGBan) then
    Exit(False);

  qryRegistros := Nil;
  CFGBan := Nil;

  Try
    qryRegistros := fCriaQuery();
    blnUpdate    := False;
    CFGBan       := fFindByCFG(objCFGBan.CodCFG);

    if Assigned(CFGBan) then
      blnUpdate := true;

    //Aqui comparo se o valor passado é diferente do anterior no banco de dados,
    //se sim, gravo o log e atualizo o registro, se não, não faço nada.
    if ((blnUpdate) and (CFGBan.VALCFG = objCFGBan.VALCFG)) then
      Exit(False);

    qryRegistros.SQL.Text := '';
    qryRegistros.SQL.Text := fGetSQLlog;

    qryRegistros.ParamByName('CODEMP').AsString := objCFGBan.CodEmp;
    qryRegistros.ParamByName('CODBAN').AsString := objCFGBan.CodBan;
    qryRegistros.ParamByName('CODCFG').AsString := objCFGBan.CodCFG;
    qryRegistros.ParamByName('DESCRI').AsString := objCFGBan.Descri;
    qryRegistros.ParamByName('VALATU').AsString := objCFGBan.VALCFG;
    qryRegistros.ParamByName('TIPLAY').AsString := objCFGBan.TipLay;

    if blnUpdate then
      qryRegistros.ParamByName('VALANT').AsString := CFGBan.VALCFG
    else
      qryRegistros.ParamByName('VALANT').AsString := '';

    qryRegistros.ParamByName('BANCO_').AsString := objCFGBan.BANCO_;
    qryRegistros.ParamByName('CARTEI').AsString := objCFGBan.Cartei;
    qryRegistros.ParamByName('NUMPOS').AsString := objCFGBan.NumPos;
    qryRegistros.ParamByName('CODOPE').AsString := objCFGBan.CodOpe;
    qryRegistros.ParamByName('ULTALT').AsDateTime := objCFGBan.UltAlt;
    qryRegistros.ParamByName('CHAVE_').AsString := objCFGBan.Chave_;
    qryRegistros.ParamByName('TIPLAY').AsString := objCFGBan.TipLay;
    qryRegistros.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGCFB', objCFGBan.CodEmp);
    qryRegistros.ExecSQL;

    qryRegistros.SQL.Clear;
    qryRegistros.SQL.Text := fGetSQL(blnUpdate);

    qryRegistros.ParamByName('CODEMP').AsString := objCFGBan.CodEmp;
    qryRegistros.ParamByName('CODBAN').AsString := objCFGBan.CodBan;
    qryRegistros.ParamByName('CARTEI').AsString := objCFGBan.Cartei;
    qryRegistros.ParamByName('NUMPOS').AsString := objCFGBan.NumPos;
    qryRegistros.ParamByName('CODCFG').AsString := objCFGBan.CodCFG;
    qryRegistros.ParamByName('DESCRI').AsString := objCFGBan.Descri;
    qryRegistros.ParamByName('VALCFG').AsString := objCFGBan.VALCFG;
    qryRegistros.ParamByName('TIPLAY').AsString := objCFGBan.TipLay;
    qryRegistros.ParamByName('BANCO_').AsString := objCFGBan.BANCO_;

    qryRegistros.ParamByName('CHAVE_').AsString := objCFGBan.Chave_;

    qryRegistros.ParamByName('ULTALT').AsDateTime := objCFGBan.UltAlt;
    qryRegistros.ExecSQL;
  Finally
    if Assigned(CFGBan) then
      FreeAndNil(CFGBan);

    FreeAndNilDatasets(qryRegistros);
  End;

  Result := True;
end;

function TCFGBanDao.fInsertAll(listCFGBan: TObjectList<TCfgBan>;
blnMostraAguarde: Boolean = True): Boolean;
var
  i: Integer;
  CFGBan: TCfgBan;
  strParameter: array of String;
  FGravando : IObserver_;
  FSubject  : ISubject_;
begin
  if Assigned(listCFGBan) then
  begin
    if listCFGBan.Count > 0  then
    begin
      if blnMostraAguarde then
      begin
        FGravando := TGravandoObs.Create;
        FSubject  := TSubject.Create;
        FSubject.pAddObserver(FGravando);

        //Preparando array de parametros que será responsavel pelas notificações com o objeto observador.
        SetLength(strParameter,4);
        strParameter[0] := 'TcxProgressBar';
        strParameter[1] := IntToStr(listCFGBan.Count);
        strParameter[2] := 'Aguarde... Salvando Configurações.';

        //Enviando notificação que vai atualizar os observadores.
        FSubject.pNotify(strParameter);
      end;

      try
        for i := 0 to listCFGBan.Count-1 do
        begin
          //Application.ProcessMessages;
          if blnMostraAguarde then
          begin
            //Atualizando os observadores
            strParameter[3] := IntToStr(i);
            FSubject.pNotify(strParameter);
          end;

          CFGBan := listCFGBan.Items[i];
          fInsert(CFGBan);
        end;
      except
        on e: Exception do
        begin
          if blnMostraAguarde then
          begin
            //Enviando a notificação para desalocar os observadores e destruir os objetos criados na memória
            strParameter[0] := 'Fechar';
            FSubject.pNotify(strParameter);
            Finalize(strParameter);
          end;

          fMensagem('', 'Ocorreu um erro ao salvar as configurações do banco' + #13 + 'Erro: ' + e.Message, ['&Ok']);
          Result := False;
          Exit;
        end;
      end;

      if blnMostraAguarde then
      begin
        //Enviando a notificação para desalocar os observadores e destruir os objetos criados na memória
        strParameter[0] := 'Fechar';
        FSubject.pNotify(strParameter);
        Finalize(strParameter);
      end;
    end
    else
    begin
      Result := False;
      Exit;
    end;
  end
  else
  begin
    Result := False;
    Exit;
  end;

  Result := True;
end;

end.
