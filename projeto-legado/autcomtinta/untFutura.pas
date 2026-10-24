unit untFutura;

interface

uses SysUtils, Forms, Classes,
   Uni,
  Dialogs, StrUtils, untFuncoesSimples;

  function fRetornaPrecoFutura(Sender: TForm; qryCadFut: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProFutura(qryCadFut: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;

  function fRetornaDescricaoFutura(strDesCor: String; qryCadFut: TUniQuery): String;

  function fTrocaBase(Sender: TForm; qryCadFut: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
    Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strRefere: String): Boolean;

  function fGTinForFutura(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaFutura(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaFuturaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaFuturaVenda(Sender: TForm; strCodEmp: String;
    qryCadFut: TUniQuery): String; stdcall;

  procedure pRetornaDadosFutura(strIteTin: String; dicRetorno: TDicionario);

implementation

uses DB, untFuncEspecificas,untFatTrocaBase,untIConfTinta,untTintaMaquina,untConsultaCadFut,untConsultaCadFutGeral,untConsultaCadFutVenda;

function fRetornaPrecoFutura(Sender: TForm; qryCadFut: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
  Var

    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    strIteTin: String;
    blnUsaPreCus: Boolean;

    {*******************************************}
    {* VARIÁVEIS INTERNAS                      *}
    {****************************************MV*}
    fltPreCus: Double;
    fltUnitar: Double;
    strCodIte: String;
    strDesCor: String;
    strTabPre: String;
    strRefBas: String;
begin

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
  If (fConsultaFuturaVenda(Sender, strCodEmp, qryCadFut) = '-1') Then
  Begin
    Exit;
  End;

  If (Not fTrocaBase(Sender, qryCadFut, strTabPre, strCodEmp, qryCadFut.FieldByName('FUT_CODITE').AsString,
    strCodIte, fltPreCus, fltUnitar, strRefBas)) Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('FUTURA -> DESCRIÇÃO DA COR', strDesCor);
  strDesCor := strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strDesCor;

  strIteTin := qryCadFut.FieldByName('FUT_REFERE').AsString +
               qryCadFut.FieldByName('FUT_UNIDAD').AsString +
               qryCadFut.FieldByName('FUT_DESCRI').AsString;

  fltPreCus := fltPreCus + qryCadFut.FieldByName('FUT_COLCUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar + qryCadFut.FieldByName('FUT_COLVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar + qryCadFut.FieldByName('FUT_COLVEN').AsFloat;

  dicRetorno['unidad'] := qryCadFut.FieldByName('FUT_UNIDAD').AsString;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strIteTin;

  Result := True;

end;

function fRetornaUniTraProFutura(qryCadFut: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;
  Var
    strSiglaTrava: String;
    strCampoTrava: String;
    fltFatTrava: Double;
    strSQL: String;

    qryGen001: TUniQuery;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('FUT');
  qryGen001 := fCriaQuery(Nil);

  With qryGen001 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ITE_PRECUS, ITE_PREVE' + strTabPre + ' AS ITE_PREVEN');
    SQL.Add('FROM ITEGER WHERE ITE_CODITE = :CODBAS AND ITE_CODEMP = :CODEMP ');

    ParamByName('CODBAS').AsString := strCodBas;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADFUT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(FUT_REFERE, FUT_UNIDAD, FUT_DESCRI) = :ITETIN ';

  With qryCadFut Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strSiglaTrava := conf.fGet('TRAFUT'); //fArqIniTinta(0, 'FUTURA', 'TRAFUT', '');
  strCampoTrava := 'FUT_COL' + strSiglaTrava;
  fltFatTrava   := conf.fGetDouble('FATFUT'); //fStrToFloat(fArqIniTinta(0, 'FUTURA', 'FATFUT', ''));

  Result := fFormataFloat((qryGen001.FieldByName('ITE_PRE' + strSiglaTrava).AsFloat +
                           qryCadFut.FieldByName(strCampoTrava).AsFloat) * fltFatTrava, 4);

  FreeAndNil(qryGen001);
end;

function fRetornaDescricaoFutura(strDesCor: String; qryCadFut: TUniQuery): String;
begin
  Result := qryCadFut.FieldByName('FUT_DESCRI').AsString + ' ' +
            qryCadFut.FieldByName('FUT_REFERE').AsString + ' ' +
            qryCadFut.FieldByName('FUT_UNIDAD').AsString + ' ' +
            strDesCor;
end;

function fTrocaBase(Sender: TForm; qryCadFut: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
  Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strRefere: String): Boolean;
begin

  {*******************************************}
  {* strTabPre: PREÇO DE VENDA 1 OU 2        *}
  {****************************************MV*}
  Try
    Application.CreateForm(TfrmFatTrocaBase, frmFatTrocaBase);
    frmFatTrocaBase.strCodBas := strCodBas;
    frmFatTrocaBase.strCodEmp := strCodEmp;
    frmFatTrocaBase.strTabPre := strTabPre;
    frmFatTrocaBase.showModal;
  Finally
    Result    := frmFatTrocaBase.blnConfirma;
    strNovBas := frmFatTrocaBase.edtCodIte.Text;
    fltCusBas := frmFatTrocaBase.fltCusBas;
    fltVenBas := frmFatTrocaBase.fltVenBas;
    strRefere := frmFatTrocaBase.strRefere;
    FreeAndNil(frmFatTrocaBase);
  End;

  If (Not Result) Then
  Begin
    fltCusBas := 0.0;
    fltVenBas := 0.0;
    strRefere := '';
  End
  Else
  Begin
    If (strNovBas = strCodBas) Then
    Begin
      fltCusBas := qryCadFut.FieldByName('FUT_PRECUS').AsFloat - qryCadFut.FieldByName('FUT_COLCUS').AsFloat;
      fltVenBas := qryCadFut.FieldByName('FUT_PREVEN').AsFloat - qryCadFut.FieldByName('FUT_COLVEN').AsFloat;
    End;
  End;

end;

function fGTinForFutura(strIteTin: String; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
  Var
    strSQL: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strColorantes: String;
    dicColorantes: TDicionario;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  dicColorantes := TDicionario.Create;
  strColorantes := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADFUT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(FUT_REFERE, FUT_UNIDAD, FUT_DESCRI) = :ITETIN ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If (IsEmpty) Then
    Begin
      Result := False;
      Exit;
    End;

    For intContador := 1 To 5 Do
    Begin

      strCamFor := 'FUT_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'FUT_QTDB' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat * 0.077;

      dicColorantes[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

      {*******************************************}
      {* GUARDA COLORANTES PARA POSTERIOR BUSCA  *}
      {* DOS ITENS                               *}
      {****************************************MV*}
      strColorantes := strColorantes + QuotedStr(arrFormul[intContador].strFormul);
      If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
        strColorantes := strColorantes + ', ';

    End;

    strColorantes := Trim(strColorantes);
    If (RightStr(strColorantes, 1) = ',') Then
      strColorantes := Copy(strColorantes, 1, Length(strColorantes)-1);

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  COL_CODCOL, ';
  strSQL := strSQL + '  COL_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADCOL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COL_CODCOL IN (' + strColorantes + ') ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    intPos := 0;
    SetLength(arrBaixaPigmentos, RecordCount);

    While (Not Eof) Do
    Begin

      {*******************************************}
      {* ITENS QUE TEM QUE FAZER TRANSFERENCIA   *}
      {* DE SALDO EM ML                          *}
      {****************************************MV*}
      stlItensTraMl.Add(FieldByName('COL_CODITE').AsString);

      arrBaixaPigmentos[intPos].strCodIte   := FieldByName('COL_CODITE').AsString;
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicColorantes[FieldByName('COL_CODCOL').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicColorantes);
  FreeAndNil(qryConsulta01);

end;

function fConsultaFutura(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndFut: TStringList;
    stlDesIndFut: TStringList;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);
  Application.CreateForm(TfrmConsultaCadFut, frmConsultaCadFut);

  stlCamIndFut := TStringList.Create;
  stlDesIndFut := TStringList.Create;

  stlCamIndFut.Add('F.FUT_DESCRI+F.FUT_REFERE');
  stlCamIndFut.Add('F.FUT_REFERE');
  stlCamIndFut.Add('I.ITE_DESITE');

  stlDesIndFut.Add('Descricao/Referencia');
  stlDesIndFut.Add('Referencia');
  stlDesIndFut.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  F.FUT_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  F.FUT_REFERE AS "Referencia", ';
  strSQL := strSQL + '  F.FUT_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  F.FUT_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  F.FUT_PREVEN, ';
  strSQL := strSQL + '  F.FUT_PRECUS, ';
  strSQL := strSQL + '  F.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADFUT F, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  F.FUT_CODITE = I.ITE_CODITE ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadFut, qryConsulta01, 'FUT_CADFUT',
      strSQL, stlCamIndFut, stlDesIndFut, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndFut);
  FreeAndNil(stlDesIndFut);

  FreeAndNil(frmConsultaCadFut);
  FreeAndNil(qryConsulta01);

end;

function fConsultaFuturaGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndFut: TStringList;
    stlDesIndFut: TStringList;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  Application.CreateForm(TfrmConsultaCadFutGeral, frmConsultaCadFutGeral);

  stlCamIndFut := TStringList.Create;
  stlDesIndFut := TStringList.Create;

  stlCamIndFut.Add('F.FUT_DESCRI+F.FUT_REFERE');
  stlCamIndFut.Add('F.FUT_REFERE');
  stlCamIndFut.Add('I.ITE_DESITE');

  stlDesIndFut.Add('Descricao/Referencia');
  stlDesIndFut.Add('Referencia');
  stlDesIndFut.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  F.FUT_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  F.FUT_REFERE AS "Referencia", ';
  strSQL := strSQL + '  F.FUT_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  F.FUT_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  F.FUT_PREVEN, ';
  strSQL := strSQL + '  F.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADFUT F, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  F.FUT_CODITE = I.ITE_CODITE ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadFutGeral, qryConsulta01, 'FUT_CADFUT',
      strSQL, stlCamIndFut, stlDesIndFut, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndFut);
  FreeAndNil(stlDesIndFut);

  FreeAndNil(frmConsultaCadFutGeral);
  FreeAndNil(qryConsulta01);

end;

function fConsultaFuturaVenda(Sender: TForm; strCodEmp: String;
  qryCadFut: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndFut: TStringList;
    stlDesIndFut: TStringList;
begin

  Application.CreateForm(TfrmConsultaCadFutVenda, frmConsultaCadFutVenda);

  stlCamIndFut := TStringList.Create;
  stlDesIndFut := TStringList.Create;

  stlCamIndFut.Add('F.FUT_DESCRI+F.FUT_REFERE');
  stlCamIndFut.Add('F.FUT_REFERE');
  stlCamIndFut.Add('I.ITE_DESITE');

  stlDesIndFut.Add('Descricao/Referencia');
  stlDesIndFut.Add('Referencia');
  stlDesIndFut.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  F.FUT_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  F.FUT_REFERE AS "Referencia", ';
  strSQL := strSQL + '  F.FUT_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  F.FUT_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  F.FUT_PREVEN, ';
  strSQL := strSQL + '  F.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADFUT F, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  F.FUT_CODITE = I.ITE_CODITE ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadFutVenda, qryCadFut, 'FUT_CADFUT',
      strSQL, stlCamIndFut, stlDesIndFut, '', False, True, 5, True) Then
  Begin
    If (qryCadFut.IsEmpty) Then
      Result := '-1'
    Else
      Result := qryCadFut.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndFut);
  FreeAndNil(stlDesIndFut);

  FreeAndNil(frmConsultaCadFutVenda);

end;

procedure pRetornaDadosFutura(strIteTin: String; dicRetorno: TDicionario);
  Var
    strSQL: String;
    qryCadFut: TUniQuery;
begin
  qryCadFut := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FUT_CADFUT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(FUT_REFERE, FUT_UNIDAD, FUT_DESCRI) = :ITETIN ';

  With qryCadFut Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadFut.FieldByName('FUT_DESCRI').AsString;
    Close;
  End;

  FreeAndNil(qryCadFut);
end;

end.
