unit untCadComissaoFaixaDescTabPrecoDAO;

interface

uses
  untCadComissaoFaixaDescTabPrecoIntf, untConstantes, Uni, untBaseListIntf,
  untRelFatComFaixaDescTabPrecoIntf;

type
  TCadComissaoFaixaDescTabPrecoDAO = class(TObject)
  private
  public
    class function fInsert(objFaixaDescTabPreList: IBaseList): Boolean;
    class function fDelete(objFaixaDescTabPreList: IBaseList): Boolean;
    class function fUpdate(objFaixaDescTabPreList: IBaseList): Boolean;

    class function fDeleteAll: Boolean;

    class function fFindById(strTabPre: String; fltDesIni, fltDesFin: Double): ICadComissaoFaixaDescTabPreco;
    class function fGetAll: TUniQuery;
  end;
  
  FaixaDescTabPrecoDAO = TCadComissaoFaixaDescTabPrecoDAO;

implementation

uses SysUtils, StrUtils, untFuncoesSimples, untFuncoesConsulta;

{ TCadComissaoFaixaDescTabPrecoDAO }

class function TCadComissaoFaixaDescTabPrecoDAO.fDelete(
  objFaixaDescTabPreList: IBaseList): Boolean;
  Var
    strSQL: String;
    qryDelete: TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO DEL_CADFCP ';
  strSQL := strSQL + ' DELETE FROM ';
  strSQL := strSQL + '   CADFCP ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FCP_TABPRE = :TABPRE AND ';
  strSQL := strSQL + '   FCP_TIPOPE = :TIPOPE AND ';
  strSQL := strSQL + '   FCP_DESINI = :DESINI AND ';
  strSQL := strSQL + '   FCP_DESFIN = :DESFIN ';

  Try
    qryDelete := fCriaQuery;

    With qryDelete Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);

      If objFaixaDescTabPreList <> nil Then
      Begin
        objFaixaDescTabPreList.Iterator.Reset;

        While objFaixaDescTabPreList.Iterator.Next Do
        Begin
          ParamByName('TABPRE').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTabPre;
          ParamByName('TIPOPE').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTipOpe;
          ParamByName('DESINI').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesIni;
          ParamByName('DESFIN').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesFin;
          ExecSQL;
        End;
      End;
        Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaDescTabPrecoDAO.fDelete_1]');
    End;
  End;

  strSQL := '';
  strSQL := strSQL + ' DELETE FROM ';
  strSQL := strSQL + '   CADFCP ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FCP_TABPRE = :TABPRE AND ';
  strSQL := strSQL + '   FCP_TIPOPE = :TIPOPE AND ';
  strSQL := strSQL + '   FCP_DESINI = :DESINI AND ';
  strSQL := strSQL + '   FCP_DESFIN = :DESFIN ';

  Try
    With qryDelete Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If objFaixaDescTabPreList <> nil Then
      Begin
        objFaixaDescTabPreList.Iterator.Reset;

        While objFaixaDescTabPreList.Iterator.Next Do
        Begin
          ParamByName('TABPRE').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTabPre;
          ParamByName('TIPOPE').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTipOpe;
          ParamByName('DESINI').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesIni;
          ParamByName('DESFIN').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesFin;
          ExecSQL;
        End;
      End;
        Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaDescTabPrecoDAO.fDelete_2]');
    End;
  End;

  FreeAndNil(qryDelete);
end;

class function TCadComissaoFaixaDescTabPrecoDAO.fDeleteAll: Boolean;
  Var
    qryInsert, qryAux: TUniQuery;
begin
  qryInsert := fCriaQuery(Nil);
  qryAux := fCriaQuery(Nil);
  Try
    Try
      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Text := 'INSERT INTO DEL_CADFCP (' +
                                            'FCP_TABPRE, FCP_TIPOPE, FCP_DESINI, FCP_DESFIN, FCP_COMVIS, FCP_COMPRA, FCP_CODEMP, OPEDEL, DTADEL, HORDEL )' +
                                            ' VALUES (:TABPRE, :TIPOPE, :DESINI, :DESFIN, :COMVIS, :COMPRA, :CODEMP, :OPEDEL, :DTADEL, :HORDEL) ';

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'SELECT * FROM CADFCP ';
      qryAux.Open;

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        qryInsert.Close;
        qryInsert.ParamByName('TABPRE').AsString := qryAux.FieldByName('FCP_TABPRE').AsString;
        qryInsert.ParamByName('TIPOPE').AsString := qryAux.FieldByName('FCP_TIPOPE').AsString;
        qryInsert.ParamByName('DESINI').AsFloat := qryAux.FieldByName('FCP_DESINI').AsFloat;
        qryInsert.ParamByName('DESFIN').AsFloat := qryAux.FieldByName('FCP_DESFIN').AsFloat;
        qryInsert.ParamByName('COMVIS').AsFloat := qryAux.FieldByName('FCP_COMVIS').AsFloat;
        qryInsert.ParamByName('COMPRA').AsFloat := qryAux.FieldByName('FCP_COMPRA').AsFloat;
        qryInsert.ParamByName('CODEMP').AsString := qryAux.FieldByName('FCP_CODEMP').AsString;
        qryInsert.ParamByName('OPEDEL').AsString := strLoginUsuarioLogado;
        qryInsert.ParamByName('DTADEL').AsDateTime := fNow;
        qryInsert.ParamByName('HORDEL').AsString := FormatDateTime('hh:mm:ss', fNow);
        qryInsert.ExecSql;

        qryAux.Next;
      End;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM CADFCP');
      qryAux.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadComissaoFaixaDescTabPrecoDAO.fDeleteAll_2]');
      End;
    End;
  Finally
    qryInsert.Free;
    qryAux.Free;
  End;
end;

class function TCadComissaoFaixaDescTabPrecoDAO.fFindById(strTabPre: String;
  fltDesIni, fltDesFin: Double): ICadComissaoFaixaDescTabPreco;
begin

end;

class function TCadComissaoFaixaDescTabPrecoDAO.fInsert(
  objFaixaDescTabPreList: IBaseList): Boolean;
  Var
    strSQL: String;
    qryInsert: TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO CADFCP(';
  strSQL := strSQL + '   FCP_TABPRE,';
  strSQL := strSQL + '   FCP_TIPOPE,';
  strSQL := strSQL + '   FCP_DESINI,';
  strSQL := strSQL + '   FCP_DESFIN,';
  strSQL := strSQL + '   FCP_COMVIS,';
  strSQL := strSQL + '   FCP_COMPRA,';
  strSQL := strSQL + '   FCP_CODEMP ';
  strSQL := strSQL + ') VALUES (';
  strSQL := strSQL + '   :TABPRE,';
  strSQL := strSQL + '   :TIPOPE,';
  strSQL := strSQL + '   :DESINI,';
  strSQL := strSQL + '   :DESFIN,';
  strSQL := strSQL + '   :COMVIS,';
  strSQL := strSQL + '   :COMPRA,';
  strSQL := strSQL + '   :CODEMP)';

  Try
    qryInsert := fCriaQuery;

    With qryInsert Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);

      If objFaixaDescTabPreList <> nil Then
      Begin
        objFaixaDescTabPreList.Iterator.Reset;

        While objFaixaDescTabPreList.Iterator.Next Do
        Begin
          ParamByName('TABPRE').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTabPre;
          ParamByName('TIPOPE').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTipOpe;
          ParamByName('DESINI').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesIni;
          ParamByName('DESFIN').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesFin;
          ParamByName('COMVIS').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltComVis;
          ParamByName('COMPRA').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltComPra;
          ParamByName('CODEMP').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strCodEmp;
          ExecSQL;
        End;

        Result := True;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaDescTabPrecoDAO.fInsert]');
    End;
  End;

  FreeAndNil(qryInsert);
end;

class function TCadComissaoFaixaDescTabPrecoDAO.fGetAll: TUniQuery;
  Var
    qryCadTab: TUniQuery;
begin
  Result := nil;
  
  Try
    qryCadTab := fCriaQuery;

    With qryCadTab Do
    Begin
      SQL.Add('SELECT ');
      SQL.Add('  0 AUTINC, ');
      SQL.Add('  FCP_TABPRE AS TABPRE, ');
      SQL.Add('  FCP_TIPOPE AS TIPOPE, ');
      SQL.Add('  FCP_DESINI AS DESINI, ');
      SQL.Add('  FCP_DESFIN AS DESFIN, ');
      SQL.Add('  FCP_COMVIS AS COMVIS, ');
      SQL.Add('  FCP_COMPRA AS COMPRA  ');
      SQL.Add('  FROM CADFCP');
      SQL.Add(' ORDER BY FCP_DESINI ASC');

      Open;
      pSetaClient(qryCadTab);
      
      Result := qryCadTab;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaDescTabPrecoDAO.fGetAll]');
    End;
  End;
end;

class function TCadComissaoFaixaDescTabPrecoDAO.fUpdate(
  objFaixaDescTabPreList: IBaseList): Boolean;
  Var
    strSQL: String;
    qryUpdate: TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + ' UPDATE CADFCP SET ';
  strSQL := strSQL + '   FCP_COMVIS = :COMVIS,';
  strSQL := strSQL + '   FCP_COMPRA = :COMPRA ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FCP_TABPRE = :TABPRE AND ';
  strSQL := strSQL + '   FCP_TIPOPE = :TIPOPE AND ';
  strSQL := strSQL + '   FCP_DESINI = :DESINI AND';
  strSQL := strSQL + '   FCP_DESFIN = :DESFIN ';

  Try
    qryUpdate := fCriaQuery;

    With qryUpdate Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);

      If objFaixaDescTabPreList <> nil Then
      Begin
        objFaixaDescTabPreList.Iterator.Reset;

        While objFaixaDescTabPreList.Iterator.Next Do
        Begin
          ParamByName('TABPRE').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTabPre;
          ParamByName('TIPOPE').AsString := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTipOpe;
          ParamByName('DESINI').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesIni;
          ParamByName('DESFIN').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesFin;
          ParamByName('COMVIS').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltComVis;
          ParamByName('COMPRA').AsFloat  := (objFaixaDescTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltComPra;
          ExecSQL;
        End;

        Result := True;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaDescTabPrecoDAO.fUpdate]');
    End;
  End;

  FreeAndNil(qryUpdate);
end;

end.
