unit untKilling;

interface

uses SysUtils, Forms, Classes, Uni,
  Dialogs, StrUtils, untFuncoesSimples;

  function fRetornaPrecoKilling(Sender: TForm; qryCadKil: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProKilling(qryCadKil: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;

  function fRetornaDescricaoKilling(strDesCor: String; qryCadKil: TUniQuery): String;

  function fTrocaBase(Sender: TForm; qryCadKil: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
    Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strRefere: String): Boolean;

  function fGTinForKilling(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaKilling(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaKillingGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaKillingVenda(Sender: TForm; strCodEmp: String;
    qryCadKil: TUniQuery): String; stdcall;

  procedure pRetornaDadosKilling(strIteTin: String; dicRetorno: TDicionario);

implementation

uses DB, untFuncEspecificas,
untFatTrocaBase,
untIConfTinta,
untTintaMaquina,
untConsultaCadKil, untConsultaCadKilGeral,
untConsultaCadKilVenda;

function fRetornaPrecoKilling(Sender: TForm; qryCadKil: TUniQuery;
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
  If (fConsultaKillingVenda(Sender, strCodEmp, qryCadKil) = '-1') Then
  Begin
    Exit;
  End;

  If (Not fTrocaBase(Sender, qryCadKil, strTabPre, strCodEmp, qryCadKil.FieldByName('KIL_CODITE').AsString,
    strCodIte, fltPreCus, fltUnitar, strRefBas)) Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('KILLING -> DESCRIÇÃO DA COR', strDesCor);
  strDesCor := strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strDesCor;

  strIteTin := qryCadKil.FieldByName('KIL_REFERE').AsString +
               qryCadKil.FieldByName('KIL_UNIDAD').AsString +
               qryCadKil.FieldByName('KIL_DESCRI').AsString;

  fltPreCus := fltPreCus + qryCadKil.FieldByName('KIL_COLCUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar + qryCadKil.FieldByName('KIL_COLVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar + qryCadKil.FieldByName('KIL_COLVEN').AsFloat;

  dicRetorno['unidad'] := qryCadKil.FieldByName('KIL_UNIDAD').AsString;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;

  Result := True;

end;

function fRetornaUniTraProKilling(qryCadKil: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;
  Var
    strSiglaTrava: String;
    strCampoTrava: String;
    fltFatTrava: Double;
    strSQL: String;

    qryGen001: TUniQuery;
    conf: IConfTinta;
begin

  qryGen001 := fCriaQuery(Nil);
  conf      := fGetConfTinta('KIL');

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
  strSQL := strSQL + '  KIL_CADKIL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(KIL_REFERE, KIL_UNIDAD, KIL_DESCRI) = :ITETIN ';

  With qryCadKil Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strSiglaTrava := conf.fGet('TRAKIL'); //fArqIniTinta(0, 'KILLING', 'TRAKIL', '');
  strCampoTrava := 'KIL_COL' + strSiglaTrava;
  fltFatTrava   := conf.fGetDouble('FATKIL'); //fStrToFloat(fArqIniTinta(0, 'KILLING', 'FATKIL', ''));

  Result := fFormataFloat((qryGen001.FieldByName('ITE_PRE' + strSiglaTrava).AsFloat +
                           qryCadKil.FieldByName(strCampoTrava).AsFloat) * fltFatTrava, 4);

  FreeAndNil(qryGen001);
end;

function fRetornaDescricaoKilling(strDesCor: String; qryCadKil: TUniQuery): String;
begin
  Result := qryCadKil.FieldByName('KIL_DESCRI').AsString + ' ' +
            qryCadKil.FieldByName('KIL_REFERE').AsString + ' ' +
            qryCadKil.FieldByName('KIL_UNIDAD').AsString + ' ' +
            strDesCor;
end;

function fTrocaBase(Sender: TForm; qryCadKil: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
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
      fltCusBas := qryCadKil.FieldByName('KIL_PRECUS').AsFloat - qryCadKil.FieldByName('KIL_COLCUS').AsFloat;
      fltVenBas := qryCadKil.FieldByName('KIL_PREVEN').AsFloat - qryCadKil.FieldByName('KIL_COLVEN').AsFloat;
    End;
  End;

end;

function fGTinForKilling(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  KIL_CADKIL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(KIL_REFERE, KIL_UNIDAD, KIL_DESCRI) = :ITETIN ';

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

    For intContador := 1 To 15 Do
    Begin

      strCamFor := 'KIL_CODC' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'KIL_QTDC' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat;

      If (fEmptyStr(arrFormul[intContador].strFormul)) Then
        Break;

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
  strSQL := strSQL + '  KIL_CADCOL ';
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

function fConsultaKilling(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndKil: TStringList;
    stlDesIndKil: TStringList;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  Application.CreateForm(TfrmConsultaCadKil, frmConsultaCadKil);

  stlCamIndKil := TStringList.Create;
  stlDesIndKil := TStringList.Create;

  stlCamIndKil.Add('K.KIL_DESCRI+K.KIL_REFERE');
  stlCamIndKil.Add('K.KIL_REFERE');
  stlCamIndKil.Add('I.ITE_DESITE');

  stlDesIndKil.Add('Descricao/Referencia');
  stlDesIndKil.Add('Referencia');
  stlDesIndKil.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  K.KIL_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  K.KIL_REFERE AS "Referencia", ';
  strSQL := strSQL + '  K.KIL_CORITE AS "Cor", ';
  strSQL := strSQL + '  K.KIL_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  K.KIL_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  K.KIL_PREVEN, ';
  strSQL := strSQL + '  K.KIL_PRECUS, ';
  strSQL := strSQL + '  K.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  KIL_CADKIL K, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  K.KIL_CODITE = I.ITE_CODITE ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadKil, qryConsulta01, 'KIL_CADKIL',
      strSQL, stlCamIndKil, stlDesIndKil, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndKil);
  FreeAndNil(stlDesIndKil);

  FreeAndNil(frmConsultaCadKil);
  FreeAndNil(qryConsulta01);

end;

function fConsultaKillingGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndKil: TStringList;
    stlDesIndKil: TStringList;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  Application.CreateForm(TfrmConsultaCadKilGeral, frmConsultaCadKilGeral);

  stlCamIndKil := TStringList.Create;
  stlDesIndKil := TStringList.Create;

  stlCamIndKil.Add('K.KIL_DESCRI+K.KIL_REFERE');
  stlCamIndKil.Add('K.KIL_REFERE');
  stlCamIndKil.Add('I.ITE_DESITE');

  stlDesIndKil.Add('Descricao/Referencia');
  stlDesIndKil.Add('Referencia');
  stlDesIndKil.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  K.KIL_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  K.KIL_REFERE AS "Referencia", ';
  strSQL := strSQL + '  K.KIL_CORITE AS "Cor", ';
  strSQL := strSQL + '  K.KIL_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  K.KIL_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  K.KIL_PREVEN, ';
  strSQL := strSQL + '  K.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  KIL_CADKIL K, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  K.KIL_CODITE = I.ITE_CODITE ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadKilGeral, qryConsulta01, 'KIL_CADKIL',
      strSQL, stlCamIndKil, stlDesIndKil, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndKil);
  FreeAndNil(stlDesIndKil);

  FreeAndNil(frmConsultaCadKilGeral);
  FreeAndNil(qryConsulta01);

end;

function fConsultaKillingVenda(Sender: TForm; strCodEmp: String;
  qryCadKil: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndKil: TStringList;
    stlDesIndKil: TStringList;
begin

  Application.CreateForm(TfrmConsultaCadKilVenda, frmConsultaCadKilVenda);

  stlCamIndKil := TStringList.Create;
  stlDesIndKil := TStringList.Create;

  stlCamIndKil.Add('K.KIL_DESCRI+K.KIL_REFERE');
  stlCamIndKil.Add('K.KIL_REFERE');
  stlCamIndKil.Add('I.ITE_DESITE');

  stlDesIndKil.Add('Descricao/Referencia');
  stlDesIndKil.Add('Referencia');
  stlDesIndKil.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  K.KIL_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  K.KIL_REFERE AS "Referencia", ';
  strSQL := strSQL + '  K.KIL_CORITE AS "Cor", ';
  strSQL := strSQL + '  K.KIL_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  K.KIL_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  K.KIL_PREVEN, ';
  strSQL := strSQL + '  K.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  KIL_CADKIL K, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  K.KIL_CODITE = I.ITE_CODITE ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadKilVenda, qryCadKil, 'KIL_CADKIL',
      strSQL, stlCamIndKil, stlDesIndKil, '', False, True, 5, True) Then
  Begin
    If (qryCadKil.IsEmpty) Then
      Result := '-1'
    Else
      Result := qryCadKil.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndKil);
  FreeAndNil(stlDesIndKil);

  FreeAndNil(frmConsultaCadKilVenda);

end;

procedure pRetornaDadosKilling(strIteTin: String; dicRetorno: TDicionario);
  Var
    strSQL: String;
    qryCadKil: TUniQuery;
begin
  qryCadKil := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  KIL_CADKIL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(KIL_REFERE, KIL_UNIDAD, KIL_DESCRI) = :ITETIN ';

  With qryCadKil Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('KIL_REFERE').AsString;
    Close;
  End;

  FreeAndNil(qryCadKil);
end;

end.
