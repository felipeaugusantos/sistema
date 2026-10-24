unit untTinGer;

interface

uses
  Uni, SysUtils, StrUtils;

type
  TinGer = class(TInterfacedObject)
  private
    class function fGetCamposTinDetBaixado(): string;
    class function fGetCamposTinDetBaixadoWhere(): string;
    class function fGetCamposTinDetBaixadoWhereCodAca(): string;
    class function fGetCamposTinDetExisteWhere(): string;
  public
    class function fVerificaTinDetBaixado(const strNumDoc, strCodEmp, strEspDoc, strCodAca, strEmpAca, strTexto: string): Boolean; overload;
    class function fVerificaTinDetBaixado(const strNumDoc, strCodEmp, strEspDoc, strTexto: string): Boolean; overload;
    class function fProducaoForaLoja(const strNumDoc, strCodEmp, strEspDoc, strCodAca, strEmpAca: string): Boolean; overload;
    class function fProducaoForaLoja(const strNumDoc, strCodEmp, strEspDoc: string): Boolean; overload;
    class function fVerificaQtdProdDevPigmento(fltQtdDev, fltQtdDevDoc: Double): Boolean;
    class procedure pBaixarFormulacao(const strNumDoc, strCodEmp, strEspDoc, strMotivo: string); overload;
    class procedure pBaixarFormulacao(const strNumDoc, strCodEmp, strEspDoc, strCodAca, strEmpAca, strMotivo: string); overload;
    class function fVerificaTinDetExiste(const strNumDoc, strCodEmp, strEspDoc: string): Boolean; overload;
  end;

implementation

uses
      untFuncoesSimples, untDataSetViewer, Data.DB;

{ TinDet }

class function TinGer.fVerificaTinDetBaixado(const strNumDoc, strCodEmp, strEspDoc, strCodAca, strEmpAca, strTexto: string): Boolean;
var
  qryGen: TUniQuery;
begin
  Result := False;
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                                          ' +
          fGetCamposTinDetBaixado +
        ' FROM                                            ' +
        '   TINDET                                        ' +
          fGetCamposTinDetBaixadoWhereCodAca;

      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.ParamByName('CODACA').AsString := strCodAca;
      qryGen.ParamByName('EMPACA').AsString := strEmpAca;
      qryGen.Open;

      Result := not qryGen.IsEmpty;

      if (Result) and (not fEmptyStr(strTexto)) then
        TDataSetViewer.View(qryGen,
          'Tintas de Máquina já baixadas',
          strTexto,
          True);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

class function TinGer.fGetCamposTinDetBaixado: string;
begin
  Result :=
    '   DET_NUMDOC AS ''Documento''                   ' +
    '   , DET_ESPDOC AS ''Espécie''                   ' +
    '   , DET_CODEMP AS ''Empresa''                   ' +
    '   , DET_CODACA AS ''Código Produto Acabado''    ' +
    '   , DET_EMPACA AS ''Empresa Produto Acabado''   ' +
    '   , DET_DESCRI AS ''Descrição''                 ' +
    '   , DET_EMPPRD AS ''Empresa Produção da Tinta'' '
end;

class function TinGer.fGetCamposTinDetBaixadoWhere: string;
begin
  Result :=
    ' WHERE DET_NUMDOC = :NUMDOC                      ' +
    '   AND DET_CODEMP = :CODEMP                      ' +
    '   AND DET_ESPDOC = :ESPDOC                      ' +
    '   AND DET_BAIXAD <> ''N''                       ' ;
end;

class function TinGer.fGetCamposTinDetBaixadoWhereCodAca: string;
begin
  Result :=
    ' WHERE DET_NUMDOC = :NUMDOC                      ' +
    '   AND DET_CODEMP = :CODEMP                      ' +
    '   AND DET_ESPDOC = :ESPDOC                      ' +
    '   AND DET_CODACA = :CODACA                      ' +
    '   AND DET_EMPACA = :EMPACA                      ' +
    '   AND DET_BAIXAD <> ''N''                       ' ;
end;

class function TinGer.fGetCamposTinDetExisteWhere: string;
begin
  Result :=
    ' WHERE DET_NUMDOC = :NUMDOC                      ' +
    '   AND DET_CODEMP = :CODEMP                      ' +
    '   AND DET_ESPDOC = :ESPDOC                      ' ;
end;

class function TinGer.fProducaoForaLoja(const strNumDoc, strCodEmp, strEspDoc, strCodAca, strEmpAca: string): Boolean;
var
  qryGen: TUniQuery;
begin
  Result := false;
  qryGen := nil;

  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   COUNT(0) AS QTD          ' +
        ' FROM                       ' +
        '   TINDET                   ' +
        ' WHERE DET_NUMDOC = :NUMDOC ' +
        '   AND DET_CODEMP = :CODEMP ' +
        '   AND DET_ESPDOC = :ESPDOC ' +
        '   AND DET_CODACA = :CODACA ' +
        '   AND DET_EMPACA = :EMPACA ' +
        '   AND DET_GEROPR = 1       ';

      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.ParamByName('CODACA').AsString := strCodAca;
      qryGen.ParamByName('EMPACA').AsString := strEmpAca;
      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0;

      If (Not Result) Then
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   COUNT(0) AS QTD          ' +
        ' FROM                       ' +
        '   MOVGER ' +
        ' WHERE GER_NUMDOC = :NUMDOC ' +
        '   AND GER_CODEMP = :CODEMP ' +
        '   AND GER_ESPDOC = :ESPDOC ' +
        '   AND GER_OPRFLJ = "S"     ';

        qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
        qryGen.ParamByName('CODEMP').AsString := strCodEmp;
        qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
        qryGen.Open;

        Result := qryGen.FieldByName('QTD').AsInteger > 0;
      End;

      qryGen.Close; 
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

class function TinGer.fProducaoForaLoja(const strNumDoc, strCodEmp, strEspDoc: string): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Result := false;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                     ' +
        '   COUNT(0) AS QTD          ' +
        ' FROM                       ' +
        '   MOVGER ' +
        ' WHERE GER_NUMDOC = :NUMDOC ' +
        '   AND GER_CODEMP = :CODEMP ' +
        '   AND GER_ESPDOC = :ESPDOC ' +
        '   AND GER_OPRFLJ = "S"     ';

      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.Open;

      Result := qryGen.FieldByName('QTD').AsInteger > 0; 
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

class function TinGer.fVerificaQtdProdDevPigmento(fltQtdDev,
  fltQtdDevDoc: Double): Boolean;
begin
  Result := (fltQtdDev = fltQtdDevDoc);
end;

class function TinGer.fVerificaTinDetBaixado(const strNumDoc, strCodEmp, strEspDoc, strTexto: string): Boolean;
var
  qryGen: TUniQuery;
begin
  Result := False;
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                                          ' +
          fGetCamposTinDetBaixado +
        ' FROM                                            ' +
        '   TINDET                                        ' +
          fGetCamposTinDetBaixadoWhere;

      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.Open;

      Result := not qryGen.IsEmpty;

      if (Result) and (not fEmptyStr(strTexto)) then
        TDataSetViewer.View(qryGen,
          'Tintas de Máquina já baixadas',
          strTexto, 
          True);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

class function TinGer.fVerificaTinDetExiste(const strNumDoc, strCodEmp,
  strEspDoc: string): Boolean;
var
  qryGen: TUniQuery;
begin
  Result := False;
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                                          ' +
          fGetCamposTinDetBaixado +
        ' FROM                                            ' +
        '   TINDET                                        ' +
          fGetCamposTinDetExisteWhere;

      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.Open;

      Result := (Not qryGen.IsEmpty);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

class procedure TinGer.pBaixarFormulacao(const strNumDoc, strCodEmp, strEspDoc, strMotivo: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE                     ' +
        '   TINDET                   ' +
        ' SET                        ' +
        '   DET_BAIXAD = ''1''       ' +
        '   , DET_MOTBAI = :MOTBAI   ' +
        ' WHERE DET_NUMDOC = :NUMDOC ' +
        '   AND DET_ESPDOC = :ESPDOC ' +
        '   AND DET_CODEMP = :CODEMP ';
      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('MOTBAI').AsString := strMotivo;
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;                              
end;

class procedure TinGer.pBaixarFormulacao(const strNumDoc, strCodEmp, strEspDoc, strCodAca, strEmpAca, strMotivo: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' UPDATE                     ' +
        '   TINDET                   ' +
        ' SET                        ' +
        '   DET_BAIXAD = ''1''       ' +
        '   , DET_MOTBAI = :MOTBAI   ' +
        ' WHERE DET_NUMDOC = :NUMDOC ' +
        '   AND DET_ESPDOC = :ESPDOC ' +
        '   AND DET_CODEMP = :CODEMP ' +
        '   AND DET_CODACA = :CODACA ' +
        '   AND DET_EMPACA = :EMPACA ' ;
      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
      qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
      qryGen.ParamByName('CODEMP').AsString := strCodEmp;
      qryGen.ParamByName('CODACA').AsString := strCodAca;
      qryGen.ParamByName('EMPACA').AsString := strEmpAca;
      qryGen.ParamByName('MOTBAI').AsString := strMotivo;
      qryGen.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

end.

