unit untComissaoFaixaFatDeptoVendProdFatorController;

interface

uses
  SysUtils,
  Classes,
  DBAccess,
  VCL.Forms,
  Uni,
  untFuncoesSimples,
  untComissaoFaixaFatDeptoVendProdFatorEntity;

type
  TComissaoFaixaFatDeptoVendProdFatorController = class
  private
    const
      TAB_CAB = 'CADFDF';
      TAB_ITE = 'CADFIF';

      SQL_AUTINC = ' SELECT AUTOINCREM FROM CADFDF WHERE FDF_CODFDF=:CODFDF ';

      SQL_CAB = '  SELECT                      ' +
                '    AUTOINCREM,               ' +
                '    FDF_CODFDF,               ' +
                '    FDF_DESFDF,               ' +
                '    FDF_MARINI,               ' +
                '    FDF_MARFIN,               ' +
                '    FDF_FATINI,               ' +
                '    FDF_FATFIN                ' +
                '  FROM                        ' +
                '    CADFDF                    ' +
                '  WHERE                       ' +
                '    AUTOINCREM=:AUTINC        ';


      SQL_ITE = '  SELECT                      ' +
                '    AUTOINCREM,               ' +
                '    FIF_SEQFDF,               ' +
                '    FIF_DEPVEN,               ' +
                '    FIF_DEPPRO,               ' +
                '    FIF_FATCOM,               ' +
                '    FIF_PERBON                ' +
                '  FROM                        ' +
                '    CADFIF                    ' +
                '  WHERE                       ' +
                '    FIF_SEQFDF=:AUTINC        ';

      SQL_DEL_CAB = ' DELETE FROM CADFDF WHERE AUTOINCREM=:AUTINC ';
      SQL_DEL_ITE = ' DELETE FROM CADFIF WHERE FIF_SEQFDF=:AUTINC ';

      SQL_DEP = ' SELECT DEP_CODIGO, DEP_DESCRI FROM CADDEP WHERE DEP_CODIGO=:CODDEP ';

      SQL_MARGEM = ' SELECT CD.AUTOINCREM FROM CADFDF CD '
                 + ' INNER JOIN CADFIF CI ON (CD.AUTOINCREM = CI.FIF_SEQFDF) '
                 + ' WHERE CD.AUTOINCREM<>:AUTINC AND '
                 + ' CI.AUTOINCREM<>:AUTINCITE AND '
                 + ' CI.FIF_DEPVEN=:DEPVEN AND '
                 + ' CI.FIF_DEPPRO=:DEPPRO AND '
                 + ' ((CD.FDF_MARINI BETWEEN :MARINI AND :MARFIN) OR (CD.FDF_MARFIN BETWEEN :MARINI AND :MARFIN) OR (CD.FDF_MARINI<:MARINI AND CD.FDF_MARFIN>:MARFIN)) AND '
                 + ' ((CD.FDF_FATINI BETWEEN :FATINI AND :FATFIN) OR (CD.FDF_FATFIN BETWEEN :FATINI AND :FATFIN) OR (CD.FDF_FATINI<:FATINI AND CD.FDF_FATFIN>:FATFIN)) ';

      SQL_DEP_TODOS = ' SELECT DISTINCT(DEP_CODIGO) DEP_CODIGO FROM CADDEP ';
  public
    function fCarregar(strAutInc : String):TComissaoFaixaFatDeptoVendProdFatorEntity;
    function fSalvar(objComissao : TComissaoFaixaFatDeptoVendProdFatorEntity):Boolean;
    procedure pExcluir(strAutInc : String);
    function fRetornaAutInc(strCodFDF : String):String;
    function fRetornaDescricaoDepto(strCodDep : String):String;
    function fDeptoExiste(strCodDep : String):Boolean;
    function fValidarFaixaMargemEFaturamento(strAutInc : String; fltMarIni, fltMarFin, fltFatIni, fltFatFin : Double; strAutIncIte, strDepVen, strDepPro: String):Boolean;
    function fCodFDFExiste(strCodFDF : String):Boolean;
    function fRetornaTodosDeptos():TStringList;
  end;

implementation

{ TComissaoFaixaFatDeptoVendProdFatorController }

function TComissaoFaixaFatDeptoVendProdFatorController.fCarregar(strAutInc: String): TComissaoFaixaFatDeptoVendProdFatorEntity;
Var qryCab, qryIte : TUniQuery; objItem : TComissaoFaixaFatDeptoVendProdFatorItemEntity;
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
      Result := TComissaoFaixaFatDeptoVendProdFatorEntity.Create;
      Result.strAutInc := qryCab.FieldByName('AUTOINCREM').AsString;
      Result.strCodFDF := qryCab.FieldByName('FDF_CODFDF').AsString;
      Result.strDesFDF := qryCab.FieldByName('FDF_DESFDF').AsString;
      Result.fltMarIni := qryCab.FieldByName('FDF_MARINI').AsFloat;
      Result.fltMarFin := qryCab.FieldByName('FDF_MARFIN').AsFloat;
      Result.fltFatIni := qryCab.FieldByName('FDF_FATINI').AsFloat;
      Result.fltFatFin := qryCab.FieldByName('FDF_FATFIN').AsFloat;

      qryIte.SQL.Add(SQL_ITE);
      qryIte.ParamByName('AUTINC').AsString := Result.strAutInc;
      qryIte.Open;

      qryIte.First;
      While (Not qryIte.Eof) Do
      Begin
        objItem           := Result.lstItens.fNew();
        objItem.strAutInc := qryIte.FieldByName('AUTOINCREM').AsString;
        objItem.strDepVen := qryIte.FieldByName('FIF_DEPVEN').AsString;
        objItem.strDepPro := qryIte.FieldByName('FIF_DEPPRO').AsString;
        objItem.fltFatCom := qryIte.FieldByName('FIF_FATCOM').AsFloat;
        objItem.fltPerBon := qryIte.FieldByName('FIF_PERBON').AsFloat;

        qryIte.Next;
      End;
    End;
  Finally
    FreeAndNil(qryCab);
    FreeAndNil(qryIte);
  End;
end;

procedure TComissaoFaixaFatDeptoVendProdFatorController.pExcluir(strAutInc: String);
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

function TComissaoFaixaFatDeptoVendProdFatorController.fCodFDFExiste(strCodFDF: String): Boolean;
begin
  Result := (Not fEmptyStr(fRetornaAutInc(strCodFDF)));
end;

function TComissaoFaixaFatDeptoVendProdFatorController.fDeptoExiste(strCodDep: String): Boolean;
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

function TComissaoFaixaFatDeptoVendProdFatorController.fRetornaAutInc(strCodFDF: String): String;
Var qryCab : TUniQuery;
begin
  Result := '';

  qryCab := fCriaQuery();
  Try
    qryCab.SQL.Add(SQL_AUTINC);
    qryCab.ParamByName('CODFDF').AsString := fPreencheEspaco(Trim(strCodFDF), 3, False, '0');
    qryCab.Open;

    If (Not qryCab.IsEmpty) Then
      Result := qryCab.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryCab);
  End;
end;

function TComissaoFaixaFatDeptoVendProdFatorController.fRetornaDescricaoDepto(strCodDep: String): String;
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

function TComissaoFaixaFatDeptoVendProdFatorController.fRetornaTodosDeptos():TStringList;
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

function TComissaoFaixaFatDeptoVendProdFatorController.fSalvar(objComissao: TComissaoFaixaFatDeptoVendProdFatorEntity): Boolean;
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
        qryCab.FieldByName('FDF_CODFDF').AsString := objComissao.strCodFDF;
      End
      Else
        qryCab.Edit;

      qryCab.FieldByName('FDF_DESFDF').AsString := objComissao.strDesFDF;
      qryCab.FieldByName('FDF_MARINI').AsFloat  := objComissao.fltMarIni;
      qryCab.FieldByName('FDF_MARFIN').AsFloat  := objComissao.fltMarFin;
      qryCab.FieldByName('FDF_FATINI').AsFloat  := objComissao.fltFatIni;
      qryCab.FieldByName('FDF_FATFIN').AsFloat  := objComissao.fltFatFin;
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
        qryIte.FieldByName('FIF_SEQFDF').AsString := objComissao.strAutInc;
        qryIte.FieldByName('FIF_DEPVEN').AsString := objComissao.lstItens[intIndex].strDepVen;
        qryIte.FieldByName('FIF_DEPPRO').AsString := objComissao.lstItens[intIndex].strDepPro;
        qryIte.FieldByName('FIF_FATCOM').AsFloat  := objComissao.lstItens[intIndex].fltFatCom;
        qryIte.FieldByName('FIF_PERBON').AsFloat  := objComissao.lstItens[intIndex].fltPerBon;
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

function TComissaoFaixaFatDeptoVendProdFatorController.fValidarFaixaMargemEFaturamento(strAutInc : String; fltMarIni, fltMarFin, fltFatIni, fltFatFin : Double; strAutIncIte, strDepVen, strDepPro: String):Boolean;
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
