unit untCFGBAN_Dao;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  UniClientDataSet, VCL.Forms, untGravandoObs,
{$ENDIF }
  Classes, DateUtils, StrUtils, SysUtils, DB,
  Uni, System.Variants, untCFGBAN_Class, System.Generics.Collections,
  untFuncoesSimples, untSubjectClass, untSubjectIntf;

type
  TCFGBanDao = class(TObject)
  private
     FCodemp: String;
     FCodBan: String;
     FCartei: String;
     FNumPos: String;
     FTipLay: String;

     function fGetSQL(const blnUpdate: Boolean): String;
     function fGetSQLlog: String;
  public
     constructor Create(const strCodemp, strCodBan, strCartei, strNumPos, strTipLay: String); overload;

     function fFindByCFG(const strVALCFG: String): TCfgBan;
     function fFindAll: TObjectList<TCfgBan>;
     function fInsert(const objCFGBan: TCfgBan): Boolean;
     function fInsertAll(listCFGBan: TObjectList<TCfgBan>; blnMostraAguarde: Boolean = True): Boolean;
  end;

implementation

{ TCFGBanDao }

constructor TCFGBanDao.Create(const strCodemp, strCodBan, strCartei,
  strNumPos, strTipLay: String);
begin
  FCodEmp := strCodEmp;
  FCodBan := strCodBan;
  FCartei := strCartei;
  FNumPos := strNumPos;
  FTipLay := strTipLay;
end;

function TCFGBanDao.fFindAll: TObjectList<TCfgBan>;
var
  qryRegistros: TUniQuery;
  CfgBan: TCfgBan;
begin
  Result := TObjectList<TCfgBan>.Create;

  qryRegistros := fCriaQuery();

  with qryRegistros do
  begin
    SQL.Text := '';
    SQL.Text := ' SELECT * FROM CFGBAN ' +
                ' WHERE ' +
                '   SIS_CODEMP = :CODEMP AND ' +
                '   SIS_CODBAN = :CODBAN AND ' +
                '   SIS_CARTEI = :CARTEI AND ' +
                '   SIS_TIPLAY = :TIPLAY AND ' +
                '   SIS_NUMPOS = :NUMPOS' ;

    ParamByName('CODEMP').AsString := FCodEmp;
    ParamByName('CODBAN').AsString := FCodBan;
    ParamByName('CARTEI').AsString := FCartei;
    ParamByName('TIPLAY').AsString := FTipLay;
    ParamByName('NUMPOS').AsString := FNumPos;

    Open;

    if not IsEmpty then
    begin
      while not eof do
      begin
        CfgBan := TCfgBan.Create;
        CfgBan.CodEmp := FieldByName('SIS_CODEMP').AsString;
        CfgBan.CodBan := FieldByName('SIS_CODBAN').AsString;
        CFGBan.CodCFG := FieldByName('SIS_CODCFG').AsString;
        CFGBan.Descri := FieldByName('SIS_DESCRI').AsString;
        CFGBan.ValCFG := FieldByName('SIS_VALCFG').AsString;
        CFGBan.Banco_ := FieldByName('SIS_BANCO_').AsString;
        CFGBan.Cartei := FieldByname('SIS_CARTEI').AsString;
        CFGBan.NumPos := FieldByname('SIS_NUMPOS').AsString;
        CFGBan.UltAlt := FieldByname('SIS_ULTALT').AsDateTime;
        CFGBan.Chave_ := FieldByname('SIS_CHAVE_').AsString;
        CFGBan.TipLay := FieldByname('SIS_TIPLAY').AsString;

        Result.Add(CfgBan);

        Next;
      end;
    end;
  end;

  qryRegistros.Free;
end;

function TCFGBanDao.fFindByCFG(const strVALCFG: String): TCfgBan;
var
  qryRegistros: TUniQuery;
begin
  Result := nil;
  qryRegistros := fCriaQuery();

  with qryRegistros do
  begin
    SQL.Text := '';
    SQL.Text := ' SELECT * FROM CFGBAN ' +
                ' WHERE ' +
                '   SIS_CODEMP = :CODEMP AND ' +
                '   SIS_CODBAN = :CODBAN AND ' +
                '   SIS_CARTEI = :CARTEI AND ' +
                '   SIS_NUMPOS = :NUMPOS AND ' +
                '   SIS_TIPLAY = :TIPLAY AND ' +
                '   SIS_CODCFG = :CODCFG ';


    ParamByName('CODEMP').AsString := FCodEmp;
    ParamByName('CODBAN').AsString := FCodBan;
    ParamByName('CARTEI').AsString := FCartei;
    ParamByName('NUMPOS').AsString := FNumPos;
    ParamByName('TIPLAY').AsString := FTipLay;
    ParamByName('CODCFG').AsString := strVALCFG;

    Open;

    if not IsEmpty then
    begin
      Result := TCfgBan.Create;
      Result.CodEmp := FieldByName('SIS_CODEMP').AsString;
      Result.CodBan := FieldByName('SIS_CODBAN').AsString;
      Result.CodCFG := FieldByName('SIS_CODCFG').AsString;
      Result.Descri := FieldByName('SIS_DESCRI').AsString;
      Result.ValCFG := FieldByName('SIS_VALCFG').AsString;
      Result.Banco_ := FieldByName('SIS_BANCO_').AsString;
      Result.Cartei := FieldByname('SIS_CARTEI').AsString;
      Result.UltAlt := FieldByname('SIS_ULTALT').AsDateTime;
      Result.Chave_ := FieldByname('SIS_CHAVE_').AsString;
      Result.TipLay := FieldByname('SIS_TIPLAY').AsString;
    end;
  end;

  qryRegistros.Free;
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
              '   SIS_ULTALT = :ULTALT  ' +
              ' WHERE                   ' +
              '   SIS_CODEMP = :CODEMP AND ' +
              '   SIS_CODBAN = :CODBAN AND ' +
              '   SIS_CODCFG = :CODCFG AND ' +
              '   SIS_NUMPOS = :NUMPOS AND ' +
              '   SIS_TIPLAY = :TIPLAY AND ' +
              '   SIS_CARTEI = :CARTEI ';

  end;
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
  if Assigned(objCFGBan) then
  begin
    qryRegistros := fCriaQuery();
    blnUpdate    := False;
    CFGBan       := fFindByCFG(objCFGBan.CodCFG);

    try
      with qryRegistros do
      begin
        if Assigned(CFGBan) then
           blnUpdate := true;

        //Aqui comparo se o valor passado é diferente do anterior no banco de dados,
        //se sim, gravo o log e atualizo o registro, se não, não faço nada.
        if ((blnUpdate) and (CFGBan.VALCFG = objCFGBan.VALCFG)) then
        begin
          qryRegistros.free;
          Result := False;
          CFGBan.Free;
          Exit;
        end;

        SQL.Text := '';
        SQL.Text := fGetSQLlog;

        ParamByName('CODEMP').AsString := objCFGBan.CodEmp;
        ParamByName('CODBAN').AsString := objCFGBan.CodBan;
        ParamByName('CODCFG').AsString := objCFGBan.CodCFG;
        ParamByName('DESCRI').AsString := objCFGBan.Descri;
        ParamByName('VALATU').AsString := objCFGBan.VALCFG;
        ParamByName('TIPLAY').AsString := objCFGBan.TipLay;

        if blnUpdate then
           ParamByName('VALANT').AsString := CFGBan.VALCFG
        else
           ParamByName('VALANT').AsString := '';

        ParamByName('BANCO_').AsString := objCFGBan.BANCO_;
        ParamByName('CARTEI').AsString := objCFGBan.Cartei;
        ParamByName('NUMPOS').AsString := objCFGBan.NumPos;
        ParamByName('CODOPE').AsString := objCFGBan.CodOpe;
        ParamByName('ULTALT').AsDateTime := objCFGBan.UltAlt;
        ParamByName('CHAVE_').AsString := objCFGBan.Chave_;
        ParamByName('TIPLAY').AsString := objCFGBan.TipLay;
        ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('LOGCFB', objCFGBan.CodEmp);
        ExecSQL;

        SQL.Text := '';
        SQL.Text := fGetSQL(blnUpdate);

        ParamByName('CODEMP').AsString := objCFGBan.CodEmp;
        ParamByName('CODBAN').AsString := objCFGBan.CodBan;
        ParamByName('CARTEI').AsString := objCFGBan.Cartei;
        ParamByName('NUMPOS').AsString := objCFGBan.NumPos;
        ParamByName('CODCFG').AsString := objCFGBan.CodCFG;
        ParamByName('DESCRI').AsString := objCFGBan.Descri;
        ParamByName('VALCFG').AsString := objCFGBan.VALCFG;
        ParamByName('TIPLAY').AsString := objCFGBan.TipLay;
        ParamByName('BANCO_').AsString := objCFGBan.BANCO_;

        if not blnUpdate then
           ParamByName('CHAVE_').AsString := objCFGBan.Chave_;

        ParamByName('ULTALT').AsDateTime := objCFGBan.UltAlt;
        ExecSQL;

        if Assigned(CFGBan) then
           CFGBan.Free;
      end;

    except
      on e: Exception do
      begin
        qryRegistros.free;

        if Assigned(CFGBan) then
           CFGBan.Free;

        Raise Exception.Create(E.Message);
      end;
    end;
  end
  else
  begin
    Result := False;
    Exit;
  end;

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
     {$IFNDEF LINUX}
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
     {$ENDIF}

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
