unit untCadComissaoFaixaMargemTabPrecoDAO;

interface

uses
  untCadComissaoFaixaDescTabPrecoIntf, untConstantes, Uni, untBaseListIntf,
  untRelFatComFaixaDescTabPrecoIntf;

type
  TCadComissaoFaixaMargemTabPrecoDAO = class(TObject)
  private
  public
    class function fInsert(objFaixaMargemTabPreList: IBaseList): Boolean;
    class function fDelete(objFaixaMargemTabPreList: IBaseList): Boolean;
    class function fUpdate(objFaixaMargemTabPreList: IBaseList): Boolean;

    class function fDeleteAll: Boolean;

    class function fFindById(strTabPre: String; fltMarIni, fltMarFin: Double): ICadComissaoFaixaDescTabPreco;
    class function fGetAll: TUniQuery;
  end;
  
  FaixaMargemTabPrecoDAO = TCadComissaoFaixaMargemTabPrecoDAO;

implementation

uses SysUtils, StrUtils, untFuncoesSimples, untFuncoesConsulta;

{ TCadComissaoFaixaMargemTabPrecoDAO }

class function TCadComissaoFaixaMargemTabPrecoDAO.fDelete(
  objFaixaMargemTabPreList: IBaseList): Boolean;
  Var
    strSQL: String;
    qryDelete: TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO DEL_CADFMT ';
  strSQL := strSQL + ' DELETE FROM ';
  strSQL := strSQL + '   CADFMT ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FMT_TABPRE = :TABPRE AND ';
  strSQL := strSQL + '   FMT_MARINI = :MARINI AND ';
  strSQL := strSQL + '   FMT_MARFIN = :MARFIN ';

  Try
    qryDelete := fCriaQuery;

    With qryDelete Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);

      If objFaixaMargemTabPreList <> nil Then
      Begin
        objFaixaMargemTabPreList.Iterator.Reset;

        While objFaixaMargemTabPreList.Iterator.Next Do
        Begin
          ParamByName('TABPRE').AsString := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTabPre;
          ParamByName('MARINI').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesIni;
          ParamByName('MARFIN').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesFin;
          ExecSQL;
        End;
      End;
        Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaMargemTabPrecoDAO.fDelete_1]');
    End;
  End;

  strSQL := '';
  strSQL := strSQL + ' DELETE FROM ';
  strSQL := strSQL + '   CADFMT ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FMT_TABPRE = :TABPRE AND ';
  strSQL := strSQL + '   FMT_MARINI = :MARINI AND ';
  strSQL := strSQL + '   FMT_MARFIN = :MARFIN ';

  Try
    With qryDelete Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If objFaixaMargemTabPreList <> nil Then
      Begin
        objFaixaMargemTabPreList.Iterator.Reset;

        While objFaixaMargemTabPreList.Iterator.Next Do
        Begin
          ParamByName('TABPRE').AsString := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTabPre;
          ParamByName('MARINI').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesIni;
          ParamByName('MARFIN').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesFin;
          ExecSQL;
        End;
      End;
        Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaMargemTabPrecoDAO.fDelete_2]');
    End;
  End;

  FreeAndNil(qryDelete);
end;

class function TCadComissaoFaixaMargemTabPrecoDAO.fDeleteAll: Boolean;
  Var
    qryInsert, qryAux: TUniQuery;
begin
  qryInsert := fCriaQuery(Nil);
  qryAux := fCriaQuery(Nil);
  Try
    Try
      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Text := 'INSERT INTO DEL_CADFMT (' +
                                            'FMT_TABPRE, FMT_MARINI, FMT_MARFIN, FMT_COMVIS, FMT_COMPRA, FMT_CODEMP, OPEDEL, DTADEL, HORDEL )' +
                                            ' VALUES (:TABPRE, :MARINI, :MARFIN, :COMVIS, :COMPRA, :CODEMP, :OPEDEL, :DTADEL, :HORDEL) ';

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'SELECT * FROM CADFMT ';
      qryAux.Open;

      qryAux.First;
      While Not qryAux.Eof Do
      Begin
        qryInsert.Close;
        qryInsert.ParamByName('TABPRE').AsString := qryAux.FieldByName('FMT_TABPRE').AsString;
        qryInsert.ParamByName('MARINI').AsFloat := qryAux.FieldByName('FMT_MARINI').AsFloat;
        qryInsert.ParamByName('MARFIN').AsFloat := qryAux.FieldByName('FMT_MARFIN').AsFloat;
        qryInsert.ParamByName('COMVIS').AsFloat := qryAux.FieldByName('FMT_COMVIS').AsFloat;
        qryInsert.ParamByName('COMPRA').AsFloat := qryAux.FieldByName('FMT_COMPRA').AsFloat;
        qryInsert.ParamByName('CODEMP').AsString := qryAux.FieldByName('FMT_CODEMP').AsString;
        qryInsert.ParamByName('OPEDEL').AsString := strLoginUsuarioLogado;
        qryInsert.ParamByName('DTADEL').AsDateTime := fNow;
        qryInsert.ParamByName('HORDEL').AsString := FormatDateTime('hh:mm:ss', fNow);
        qryInsert.ExecSql;

        qryAux.Next;
      End;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM CADFMT');
      qryAux.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TCadComissaoFaixaMargemTabPrecoDAO.fDeleteAll_2]');
      End;
    End;
  Finally
    qryInsert.Free;
    qryAux.Free;
  End;
end;

class function TCadComissaoFaixaMargemTabPrecoDAO.fFindById(strTabPre: String;
  fltMarIni, fltMarFin: Double): ICadComissaoFaixaDescTabPreco;
begin

end;

class function TCadComissaoFaixaMargemTabPrecoDAO.fInsert(
  objFaixaMargemTabPreList: IBaseList): Boolean;
  Var
    strSQL: String;
    qryInsert: TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + ' INSERT INTO CADFMT(';
  strSQL := strSQL + '   FMT_TABPRE,';
  strSQL := strSQL + '   FMT_MARINI,';
  strSQL := strSQL + '   FMT_MARFIN,';
  strSQL := strSQL + '   FMT_COMVIS,';
  strSQL := strSQL + '   FMT_COMPRA,';
  strSQL := strSQL + '   FMT_CODEMP ';
  strSQL := strSQL + ') VALUES (';
  strSQL := strSQL + '   :TABPRE,';
  strSQL := strSQL + '   :MARINI,';
  strSQL := strSQL + '   :MARFIN,';
  strSQL := strSQL + '   :COMVIS,';
  strSQL := strSQL + '   :COMPRA,';
  strSQL := strSQL + '   :CODEMP)';

  Try
    qryInsert := fCriaQuery;

    With qryInsert Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);

      If objFaixaMargemTabPreList <> nil Then
      Begin
        objFaixaMargemTabPreList.Iterator.Reset;

        While objFaixaMargemTabPreList.Iterator.Next Do
        Begin
          ParamByName('TABPRE').AsString := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTabPre;
          ParamByName('MARINI').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesIni;
          ParamByName('MARFIN').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesFin;
          ParamByName('COMVIS').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltComVis;
          ParamByName('COMPRA').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltComPra;
          ParamByName('CODEMP').AsString := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strCodEmp;
          ExecSQL;
        End;

        Result := True;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaMargemTabPrecoDAO.fInsert]');
    End;
  End;

  FreeAndNil(qryInsert);
end;

class function TCadComissaoFaixaMargemTabPrecoDAO.fGetAll: TUniQuery;
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
      SQL.Add('  FMT_TABPRE AS TABPRE, ');
      SQL.Add('  FMT_MARINI AS MARINI, ');
      SQL.Add('  FMT_MARFIN AS MARFIN, ');
      SQL.Add('  FMT_COMVIS AS COMVIS, ');
      SQL.Add('  FMT_COMPRA AS COMPRA  ');
      SQL.Add('  FROM CADFMT');
      SQL.Add(' ORDER BY FMT_MARINI ASC');

      Open;
      pSetaClient(qryCadTab);
      
      Result := qryCadTab;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaMargemTabPrecoDAO.fGetAll]');
    End;
  End;
end;

class function TCadComissaoFaixaMargemTabPrecoDAO.fUpdate(
  objFaixaMargemTabPreList: IBaseList): Boolean;
  Var
    strSQL: String;
    qryUpdate: TUniQuery;
begin
  Result := False;

  strSQL := '';
  strSQL := strSQL + ' UPDATE CADFMT SET ';
  strSQL := strSQL + '   FMT_COMVIS = :COMVIS,';
  strSQL := strSQL + '   FMT_COMPRA = :COMPRA ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FMT_TABPRE = :TABPRE AND ';
  strSQL := strSQL + '   FMT_MARINI = :MARINI AND';
  strSQL := strSQL + '   FMT_MARFIN = :MARFIN ';

  Try
    qryUpdate := fCriaQuery;

    With qryUpdate Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);

      If objFaixaMargemTabPreList <> nil Then
      Begin
        objFaixaMargemTabPreList.Iterator.Reset;

        While objFaixaMargemTabPreList.Iterator.Next Do
        Begin
          ParamByName('TABPRE').AsString := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).strTabPre;
          ParamByName('MARINI').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesIni;
          ParamByName('MARFIN').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltDesFin;
          ParamByName('COMVIS').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltComVis;
          ParamByName('COMPRA').AsFloat  := (objFaixaMargemTabPreList.Iterator.CurrentItem As ICadComissaoFaixaDescTabPreco).fltComPra;
          ExecSQL;
        End;

        Result := True;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TCadComissaoFaixaMargemTabPrecoDAO.fUpdate]');
    End;
  End;

  FreeAndNil(qryUpdate);
end;

end.
