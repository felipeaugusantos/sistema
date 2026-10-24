unit untSuvinil;

interface

uses SysUtils, Forms, Classes, Uni,
  Dialogs, StrUtils, untFuncoesSimples;

  function fRetornaPrecoSuvinil(Sender: TForm; qryCadSuv: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProSuvinil(qryCadSuv: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;

  function fRetornaDescricaoSuvinil(strDesCor: String; qryCadSuv: TUniQuery): String;

  function fTrocaBase(Sender: TForm; qryCadSuv: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
    Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strRefere: String): Boolean;

  function fGTinForSuvinil(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaSuvinil(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSuvinilGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSuvinilVenda(Sender: TForm; strCodEmp: String;
    qryCadSuv: TUniQuery): String; stdcall;

  procedure pRetornaDadosSuvinil(strIteTin: String; dicRetorno: TDicionario);

implementation

uses DB, untFuncEspecificas, untIConfTinta, untTintaMaquina,untConsultaCadSuv,
untConsultaCadSuvGeral,
untConsultaCadSuvVenda,
untFatTrocaBase;

function fRetornaPrecoSuvinil(Sender: TForm; qryCadSuv: TUniQuery;
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
    strChaFor: String;
begin

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
  If (fConsultaSuvinilVenda(Sender, strCodEmp, qryCadSuv) = '-1') Then
  Begin
    Exit;
  End;

  If (Not fTrocaBase(Sender, qryCadSuv, strTabPre, strCodEmp, qryCadSuv.FieldByName('SUV_CODITE').AsString,
    strCodIte, fltPreCus, fltUnitar, strRefBas)) Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('SUVINIL -> DESCRIÇÃO DA COR', strDesCor);
  strDesCor := strDesCor + ' ' + strRefBas;

  strIteTin := qryCadSuv.FieldByName('SUV_REFERE').AsString +
               qryCadSuv.FieldByName('SUV_UNIDAD').AsString +
               qryCadSuv.FieldByName('SUV_DESCRI').AsString;

  strChaFor := qryCadSuv.FieldByName('SUV_DESCRI').AsString + ' ' +
               qryCadSuv.FieldByName('SUV_REFERE').AsString + ' ' +
               qryCadSuv.FieldByName('SUV_UNIDAD').AsString;

  fltPreCus := fltPreCus + qryCadSuv.FieldByName('SUV_COLCUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar + qryCadSuv.FieldByName('SUV_COLVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar + qryCadSuv.FieldByName('SUV_COLVEN').AsFloat;

  dicRetorno['unidad'] := qryCadSuv.FieldByName('SUV_UNIDAD').AsString;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;

  Result := True;

end;

function fRetornaUniTraProSuvinil(qryCadSuv: TUniQuery; strIteTin,
  strCodBas, strTabPre: String): Double;
  Var
    strCampoTrava: String;
    strSiglaTrava: String;
    fltFatTrava: Double;
    strSQL: String;

    qryGen001: TUniQuery;
    conf: IConfTinta;
begin

  qryGen001 := fCriaQuery(Nil);
  conf := fGetConfTinta('SUV');

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
  strSQL := strSQL + '  SUV_CADSUV ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(SUV_REFERE, SUV_UNIDAD, SUV_DESCRI) = :ITETIN ';

  With qryCadSuv Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strSiglaTrava := conf.fGet('TRASUV');
  strCampoTrava := 'SUV_COL' + strSiglaTrava;
  fltFatTrava   := conf.fGetDouble('FATSUV');

  Result := fFormataFloat((qryGen001.FieldByName('ITE_PRE' + strSiglaTrava).AsFloat + 
                           qryCadSuv.FieldByName(strCampoTrava).AsFloat) * fltFatTrava, 4);

  FreeAndNil(qryGen001);
end;

function fRetornaDescricaoSuvinil(strDesCor: String; qryCadSuv: TUniQuery): String;
begin
  Result := strDesCor + ' ' +
            qryCadSuv.FieldByName('SUV_DESCRI').AsString + ' ' +
            qryCadSuv.FieldByName('SUV_REFERE').AsString + ' ' +
            qryCadSuv.FieldByName('SUV_UNIDAD').AsString;
end;

function fTrocaBase(Sender: TForm; qryCadSuv: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
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
      fltCusBas := qryCadSuv.FieldByName('SUV_PRECUS').AsFloat - qryCadSuv.FieldByName('SUV_COLCUS').AsFloat;
      fltVenBas := qryCadSuv.FieldByName('SUV_PREVEN').AsFloat - qryCadSuv.FieldByName('SUV_COLVEN').AsFloat;
    End;
  End;

end;

function fGTinForSuvinil(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  SUV_CADSUV ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(SUV_REFERE, SUV_UNIDAD, SUV_DESCRI) = :ITETIN ';

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

      strCamFor := 'SUV_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'SUV_QTDB' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat;

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
  strSQL := strSQL + '  SUV_CADCOL ';
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

function fConsultaSuvinil(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndSuv: TStringList;
    stlDesIndSuv: TStringList;
    qryConsulta01: TUniQuery;
begin

  qryConsulta01 := fCriaQuery(Nil);
  Application.CreateForm(TfrmConsultaCadSuv, frmConsultaCadSuv);

  stlCamIndSuv := TStringList.Create;
  stlDesIndSuv := TStringList.Create;

  stlCamIndSuv.Add('S.SUV_DESCRI+S.SUV_REFERE');
  stlCamIndSuv.Add('S.SUV_REFERE');
  stlCamIndSuv.Add('I.ITE_DESITE');

  stlDesIndSuv.Add('Descricao/Referencia');
  stlDesIndSuv.Add('Referencia');
  stlDesIndSuv.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  S.SUV_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  S.SUV_REFERE AS "Referencia", ';
  strSQL := strSQL + '  S.SUV_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  S.SUV_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  S.SUV_PREVEN, ';
  strSQL := strSQL + '  S.SUV_PRECUS, ';
  strSQL := strSQL + '  S.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SUV_CADSUV S, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  S.SUV_CODITE = I.ITE_CODITE ';

  If Not fGetConfTinta('SUV').fGetBoolean('ANTIGO') Then
    strSQL := strSQL + '  AND S.SUV_REFERE NOT LIKE "%ANTIGO%" ';

//  strSQL := strSQL + '  S.SUV_CODEMP = I.ITE_CODEMP AND ';
//  strSQL := strSQL + '  S.SUV_CODEMP = ' + QuotedStr(strCodEmp);

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadSuv, qryConsulta01, 'SUV_CADSUV',
      strSQL, stlCamIndSuv, stlDesIndSuv, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndSuv);
  FreeAndNil(stlDesIndSuv);

  FreeAndNil(frmConsultaCadSuv);
  FreeAndNil(qryConsulta01);

end;

function fConsultaSuvinilGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndSuv: TStringList;
    stlDesIndSuv: TStringList;
    qryConsulta01: TUniQuery;
begin

  qryConsulta01 := fCriaQuery(Nil);
  Application.CreateForm(TfrmConsultaCadSuvGeral, frmConsultaCadSuvGeral);

  stlCamIndSuv := TStringList.Create;
  stlDesIndSuv := TStringList.Create;

  stlCamIndSuv.Add('S.SUV_DESCRI+S.SUV_REFERE');
  stlCamIndSuv.Add('S.SUV_REFERE');
  stlCamIndSuv.Add('I.ITE_DESITE');

  stlDesIndSuv.Add('Descricao/Referencia');
  stlDesIndSuv.Add('Referencia');
  stlDesIndSuv.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  S.SUV_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  S.SUV_REFERE AS "Referencia", ';
  strSQL := strSQL + '  S.SUV_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  S.SUV_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  S.SUV_PREVEN, ';
  strSQL := strSQL + '  S.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SUV_CADSUV S, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  S.SUV_CODITE = I.ITE_CODITE AND ';

  If Not fGetConfTinta('SUV').fGetBoolean('ANTIGO') Then
    strSQL := strSQL + '  AND S.SUV_REFERE NOT LIKE "%ANTIGO%" ';


  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadSuvGeral, qryConsulta01, 'SUV_CADSUV',
      strSQL, stlCamIndSuv, stlDesIndSuv, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndSuv);
  FreeAndNil(stlDesIndSuv);

  FreeAndNil(frmConsultaCadSuvGeral);
  FreeAndNil(qryConsulta01);

end;

function fConsultaSuvinilVenda(Sender: TForm; strCodEmp: String;
  qryCadSuv: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndSuv: TStringList;
    stlDesIndSuv: TStringList;
begin

  Application.CreateForm(TfrmConsultaCadSuvVenda, frmConsultaCadSuvVenda);

  stlCamIndSuv := TStringList.Create;
  stlDesIndSuv := TStringList.Create;

  stlCamIndSuv.Add('S.SUV_DESCRI+S.SUV_REFERE');
  stlCamIndSuv.Add('S.SUV_REFERE');
  stlCamIndSuv.Add('I.ITE_DESITE');

  stlDesIndSuv.Add('Descricao/Referencia');
  stlDesIndSuv.Add('Referencia');
  stlDesIndSuv.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  S.SUV_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  S.SUV_REFERE AS "Referencia", ';
  strSQL := strSQL + '  S.SUV_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  S.SUV_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  S.SUV_PREVEN, ';
  strSQL := strSQL + '  S.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SUV_CADSUV S, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  S.SUV_CODITE = I.ITE_CODITE ';

  If Not fGetConfTinta('SUV').fGetBoolean('ANTIGO') Then
    strSQL := strSQL + '  AND S.SUV_REFERE NOT LIKE "%ANTIGO%" ';

//  strSQL := strSQL + '  S.SUV_CODEMP = I.ITE_CODEMP AND ';
  //strSQL := strSQL + '  S.SUV_CODEMP = ' + QuotedStr(strCodEmp);

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadSuvVenda, qryCadSuv, 'SUV_CADSUV',
      strSQL, stlCamIndSuv, stlDesIndSuv, '', False, True, 5, True) Then
  Begin
    If (qryCadSuv.IsEmpty) Then
      Result := '-1'
    Else
      Result := qryCadSuv.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndSuv);
  FreeAndNil(stlDesIndSuv);

  FreeAndNil(frmConsultaCadSuvVenda);

end;

procedure pRetornaDadosSuvinil(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadSuv: TUniQuery;
    strSQL: String;
begin

  qryCadSuv := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SUV_CADSUV ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(SUV_REFERE, SUV_UNIDAD, SUV_DESCRI) = :ITETIN ';

  With qryCadSuv Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadSuv.FieldByName('SUV_DESCRI').AsString;
    Close;
  End;

  FreeAndNil(qryCadSuv);
end;

end.

