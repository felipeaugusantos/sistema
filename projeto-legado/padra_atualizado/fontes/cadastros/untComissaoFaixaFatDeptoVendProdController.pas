unit untComissaoFaixaFatDeptoVendProdController;

interface

uses
  SysUtils,
  Classes,
  DBAccess,
  VCL.Forms,
  Uni,
  untFuncoesSimples,
  untComissaoFaixaFatDeptoVendProdEntity;

type
  TComissaoFaixaFatDeptoVendProdController = class
  private
    const
      TAB_CAB = 'CADFFD';
      TAB_ITE = 'CADFFI';

      SQL_AUTINC = ' SELECT AUTOINCREM FROM CADFFD WHERE FFD_CODFFD=:CODFFD ';

      SQL_CAB = '  SELECT                      ' +
                '    AUTOINCREM,               ' +
                '    FFD_CODFFD,               ' +
                '    FFD_DESFFD,               ' +
                '    FFD_MARINI,               ' +
                '    FFD_MARFIN,               ' +
                '    FFD_FATINI,               ' +
                '    FFD_FATFIN                ' +
                '  FROM                        ' +
                '    CADFFD                    ' +
                '  WHERE                       ' +
                '    AUTOINCREM=:AUTINC        ';


      SQL_ITE = '  SELECT                      ' +
                '    AUTOINCREM,               ' +
                '    FFI_AUTINC,               ' +
                '    FFI_DEPVEN,               ' +
                '    FFI_DEPPRO,               ' +
                '    FFI_PERCOM,               ' +
                '    FFI_PERBON                ' +
                '  FROM                        ' +
                '    CADFFI                    ' +
                '  WHERE                       ' +
                '    FFI_AUTINC=:AUTINC        ';

      SQL_DEL_CAB = ' DELETE FROM CADFFD WHERE AUTOINCREM=:AUTINC ';
      SQL_DEL_ITE = ' DELETE FROM CADFFI WHERE FFI_AUTINC=:AUTINC ';

      SQL_DEP = ' SELECT DEP_CODIGO, DEP_DESCRI FROM CADDEP WHERE DEP_CODIGO=:CODDEP ';

      SQL_MARGEM = ' SELECT CD.AUTOINCREM FROM CADFFD CD '
                 + ' INNER JOIN CADFFI CI ON (CD.AUTOINCREM = CI.FFI_AUTINC) '
                 + ' WHERE CD.AUTOINCREM<>:AUTINC AND '
                 + ' CI.AUTOINCREM<>:AUTINCITE AND '
                 + ' CI.FFI_DEPVEN=:DEPVEN AND '
                 + ' CI.FFI_DEPPRO=:DEPPRO AND '
                 + ' ((CD.FFD_MARINI BETWEEN :MARINI AND :MARFIN) OR (CD.FFD_MARFIN BETWEEN :MARINI AND :MARFIN) OR (CD.FFD_MARINI<:MARINI AND CD.FFD_MARFIN>:MARFIN)) AND '
                 + ' ((CD.FFD_FATINI BETWEEN :FATINI AND :FATFIN) OR (CD.FFD_FATFIN BETWEEN :FATINI AND :FATFIN) OR (CD.FFD_FATINI<:FATINI AND CD.FFD_FATFIN>:FATFIN)) ';

      SQL_DEP_TODOS = ' SELECT DISTINCT(DEP_CODIGO) DEP_CODIGO FROM CADDEP ';
  public
    function fCarregar(strAutInc : String):TComissaoFaixaFatDeptoVendProdEntity;
    function fSalvar(objComissao : TComissaoFaixaFatDeptoVendProdEntity):Boolean;
    procedure pExcluir(strAutInc : String);
    function fRetornaAutInc(strCodFFD : String):String;
    function fRetornaDescricaoDepto(strCodDep : String):String;
    function fDeptoExiste(strCodDep : String):Boolean;
    function fValidarFaixaMargemEFaturamento(strAutInc : String; fltMarIni, fltMarFin, fltFatIni, fltFatFin : Double; strAutIncIte, strDepVen, strDepPro: String):Boolean;
    function fCodFFDExiste(strCodFFD : String):Boolean;
    function fRetornaTodosDeptos():TStringList;
  end;

implementation

{ TComissaoFaixaFatDeptoVendProdController }

function TComissaoFaixaFatDeptoVendProdController.fCarregar(strAutInc: String): TComissaoFaixaFatDeptoVendProdEntity;
Var qryCab, qryIte : TUniQuery; objItem : TComissaoFaixaFatDeptoVendProdItemEntity;
begin
  Result := Nil;

  qryCab := fCriaQuery();
  qryIte := fCriaQuery();

  Try
    qryCab.SQL.Add(SQL_CAB);
    qryCab.ParamByName('AUTINC').AsString := strAutInc;
    qryCab.Open;

    If (Not qryCab.IsEmpty) Then
    Begin
      Result := TComissaoFaixaFatDeptoVendProdEntity.Create;
      Result.strAutInc := qryCab.FieldByName('AUTOINCREM').AsString;
      Result.strCodFFD := qryCab.FieldByName('FFD_CODFFD').AsString;
      Result.strDesFFD := qryCab.FieldByName('FFD_DESFFD').AsString;
      Result.fltMarIni := qryCab.FieldByName('FFD_MARINI').AsFloat;
      Result.fltMarFin := qryCab.FieldByName('FFD_MARFIN').AsFloat;
      Result.fltFatIni := qryCab.FieldByName('FFD_FATINI').AsFloat;
      Result.fltFatFin := qryCab.FieldByName('FFD_FATFIN').AsFloat;

      qryIte.SQL.Add(SQL_ITE);
      qryIte.ParamByName('AUTINC').AsString := Result.strAutInc;
      qryIte.Open;

      qryIte.First;
      While (Not qryIte.Eof) Do
      Begin
        objItem           := Result.lstItens.fNew();
        objItem.strAutInc := qryIte.FieldByName('AUTOINCREM').AsString;
        objItem.strDepVen := qryIte.FieldByName('FFI_DEPVEN').AsString;
        objItem.strDepPro := qryIte.FieldByName('FFI_DEPPRO').AsString;
        objItem.fltPerCom := qryIte.FieldByName('FFI_PERCOM').AsFloat;
        objItem.fltPerBon := qryIte.FieldByName('FFI_PERBON').AsFloat;

        qryIte.Next;
      End;
    End;
  Finally
    FreeAndNil(qryCab);
    FreeAndNil(qryIte);
  End;
end;

procedure TComissaoFaixaFatDeptoVendProdController.pExcluir(strAutInc: String);
Var qryExc : TUniQuery;
begin
  qryExc := fCriaQuery();
  Try
    Try
      fStartTransaction();

      qryExc.SQL.Add(SQL_DEL_ITE);
      qryExc.ParamByName('AUTINC').AsString := strAutInc;
      qryExc.ExecSQL;

      qryExc.SQL.Clear;
      qryExc.SQL.Add(SQL_DEL_CAB);
      qryExc.ParamByName('AUTINC').AsString := strAutInc;
      qryExc.ExecSQL;

      fCommit();
    Except
      On E:Exception Do
      Begin
        fRollBack();
        Raise E;
      End;
    End;
  Finally
    FreeAndNil(qryExc);
  End;
end;

function TComissaoFaixaFatDeptoVendProdController.fCodFFDExiste(strCodFFD: String): Boolean;
begin
  Result := (Not fEmptyStr(fRetornaAutInc(strCodFFD)));
end;

function TComissaoFaixaFatDeptoVendProdController.fDeptoExiste(strCodDep: String): Boolean;
Var qryDep : TUniQuery;
begin
  qryDep := fCriaQuery();
  Try
    qryDep.SQL.Add(SQL_DEP);
    qryDep.ParamByName('CODDEP').AsString := fPreencheEspaco(Trim(strCodDep), 3, False, '0');
    qryDep.Open;

    Result := (Not qryDep.IsEmpty);
  Finally
    FreeAndNil(qryDep);
  End;
end;

function TComissaoFaixaFatDeptoVendProdController.fRetornaAutInc(strCodFFD: String): String;
Var qryCab : TUniQuery;
begin
  Result := '';

  qryCab := fCriaQuery();
  Try
    qryCab.SQL.Add(SQL_AUTINC);
    qryCab.ParamByName('CODFFD').AsString := fPreencheEspaco(Trim(strCodFFD), 3, False, '0');
    qryCab.Open;

    If (Not qryCab.IsEmpty) Then
      Result := qryCab.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryCab);
  End;
end;

function TComissaoFaixaFatDeptoVendProdController.fRetornaDescricaoDepto(strCodDep: String): String;
Var qryDep : TUniQuery;
begin
  Result := '';

  If fEmptyStr(Trim(strCodDep)) Then
    Exit('TODOS');

  qryDep := fCriaQuery();
  Try
    qryDep.SQL.Add(SQL_DEP);
    qryDep.ParamByName('CODDEP').AsString := fPreencheEspaco(Trim(strCodDep), 3, False, '0');
    qryDep.Open;

    If (Not qryDep.IsEmpty) Then
      Result := qryDep.FieldByName('DEP_DESCRI').AsString;
  Finally
    FreeAndNil(qryDep);
  End;
end;

function TComissaoFaixaFatDeptoVendProdController.fRetornaTodosDeptos():TStringList;
Var qryDep : TUniQuery;
begin
  Result := TStringList.Create;

  qryDep := fCriaQuery();
  Try
    qryDep.SQL.Add(SQL_DEP_TODOS);
    qryDep.Open;

    qryDep.First;
    While (Not qryDep.Eof) Do
    Begin
      Result.Add(qryDep.FieldByName('DEP_CODIGO').AsString);
      qryDep.Next;
    End;
  Finally
    FreeAndNil(qryDep);
  End;
end;

function TComissaoFaixaFatDeptoVendProdController.fSalvar(objComissao: TComissaoFaixaFatDeptoVendProdEntity): Boolean;
Var qryCab, qryIte : TUniQuery; intIndex : Integer;
begin
  Result := False;

  qryCab := fCriaQuery();
  qryIte := fCriaQuery();
  Try
    Try
      fStartTransaction();

      If (fEmptyStr(objComissao.strAutInc)) Then
        objComissao.strAutInc := fRetAutoIncrem(TAB_CAB, VS_strCodEmp);

      qryCab.SQL.Add(SQL_CAB);
      qryCab.ParamByName('AUTINC').AsString := objComissao.strAutInc;
      qryCab.Open;

      If (qryCab.IsEmpty) Then
      Begin
        qryCab.Append;
        qryCab.FieldByName('AUTOINCREM').AsString := objComissao.strAutInc;
        qryCab.FieldByName('FFD_CODFFD').AsString := objComissao.strCodFFD;
      End
      Else
        qryCab.Edit;

      qryCab.FieldByName('FFD_DESFFD').AsString := objComissao.strDesFFD;
      qryCab.FieldByName('FFD_MARINI').AsFloat  := objComissao.fltMarIni;
      qryCab.FieldByName('FFD_MARFIN').AsFloat  := objComissao.fltMarFin;
      qryCab.FieldByName('FFD_FATINI').AsFloat  := objComissao.fltFatIni;
      qryCab.FieldByName('FFD_FATFIN').AsFloat  := objComissao.fltFatFin;
      qryCab.Post;

      qryIte.SQL.Add(SQL_DEL_ITE);
      qryIte.ParamByName('AUTINC').AsString := objComissao.strAutInc;
      qryIte.ExecSQL;

      qryIte.SQL.Clear;
      qryIte.SQL.Add(SQL_ITE);
      qryIte.ParamByName('AUTINC').AsString := objComissao.strAutInc;
      qryIte.Open;

      For intIndex := 0 To Pred(objComissao.lstItens.Count) Do
      Begin
        If (fEmptyStr(objComissao.lstItens[intIndex].strAutInc)) Then
          objComissao.lstItens[intIndex].strAutInc := fRetAutoIncrem(TAB_ITE, VS_strCodEmp);

        qryIte.Append;
        qryIte.FieldByName('AUTOINCREM').AsString := objComissao.lstItens[intIndex].strAutInc;
        qryIte.FieldByName('FFI_AUTINC').AsString := objComissao.strAutInc;
        qryIte.FieldByName('FFI_DEPVEN').AsString := objComissao.lstItens[intIndex].strDepVen;
        qryIte.FieldByName('FFI_DEPPRO').AsString := objComissao.lstItens[intIndex].strDepPro;
        qryIte.FieldByName('FFI_PERCOM').AsFloat  := objComissao.lstItens[intIndex].fltPerCom;
        qryIte.FieldByName('FFI_PERBON').AsFloat  := objComissao.lstItens[intIndex].fltPerBon;
        qryIte.Post;

        Application.ProcessMessages;
      End;

      fCommit();

      Result := True;
    Except
      On E:Exception Do
      Begin
        fRollBack();
        Raise E;
      End;
    End;
  Finally
    FreeAndNil(qryCab);
    FreeAndNil(qryIte);
  End;
end;

function TComissaoFaixaFatDeptoVendProdController.fValidarFaixaMargemEFaturamento(strAutInc : String; fltMarIni, fltMarFin, fltFatIni, fltFatFin : Double; strAutIncIte, strDepVen, strDepPro: String):Boolean;
Var qryFai : TUniQuery;
begin
  qryFai := fCriaQuery();
  Try
    qryFai.SQL.Add(SQL_MARGEM);
    qryFai.ParamByName('AUTINC').AsString := strAutInc;
    qryFai.ParamByName('MARINI').AsFloat  := fltMarIni;
    qryFai.ParamByName('MARFIN').AsFloat  := fltMarFin;
    qryFai.ParamByName('FATINI').AsFloat  := fltFatIni;
    qryFai.ParamByName('FATFIN').AsFloat  := fltFatFin;
    qryFai.ParamByName('AUTINCITE').AsString := strAutIncIte;
    qryFai.ParamByName('DEPVEN').AsString := strDepVen;
    qryFai.ParamByName('DEPPRO').AsString := strDepPro;
    qryFai.Open;

    Result := qryFai.IsEmpty;
  Finally
    FreeAndNil(qryFai);
  End;
end;


end.
