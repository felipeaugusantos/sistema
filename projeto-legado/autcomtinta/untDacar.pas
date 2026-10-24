unit untDacar;

interface

uses SysUtils, Forms, Classes,
  Uni,
  Dialogs, StrUtils, untFuncoesSimples;

  function fRetornaPrecoDacar(Sender: TForm; qryCadDac: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProDacar(qryCadDac: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;

  function fRetornaDescricaoDacar(strDesCor: String; qryCadDac: TUniQuery): String;

  function fTrocaBase(Sender: TForm; qryCadDac: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
    Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strRefere: String): Boolean;

  function fGTinForDacar(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaDacar(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaDacarGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaDacarVenda(Sender: TForm; strCodEmp: String;
    qryCadDac: TUniQuery): String; stdcall;

  procedure pRetornaDadosDacar(strIteTin: String; dicRetorno: TDicionario);

implementation
uses DB, untFuncEspecificas, untFatTrocaBase,untIConfTinta,untTintaMaquina,untConsultaCadDac,untConsultaCadDacGeral, untConsultaCadDacVenda;

function fRetornaPrecoDacar(Sender: TForm; qryCadDac: TUniQuery;
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
  If (fConsultaDacarVenda(Sender, strCodEmp, qryCadDac) = '-1') Then
  Begin
    Exit;
  End;

  If (Not fTrocaBase(Sender, qryCadDac, strTabPre, strCodEmp, qryCadDac.FieldByName('DAC_CODITE').AsString,
    strCodIte, fltPreCus, fltUnitar, strRefBas)) Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('DACAR -> DESCRIÇÃO DA COR', strDesCor);
  strDesCor := strDesCor + ' ' + strRefBas;

  strIteTin := qryCadDac.FieldByName('DAC_REFERE').AsString +
               qryCadDac.FieldByName('DAC_CODUNI').AsString +
               qryCadDac.FieldByName('DAC_DESCRI').AsString;

  strChaFor := qryCadDac.FieldByName('DAC_DESCRI').AsString + ' ' +
               qryCadDac.FieldByName('DAC_REFERE').AsString + ' ' +
               qryCadDac.FieldByName('DAC_CODUNI').AsString;

  fltPreCus := fltPreCus + qryCadDac.FieldByName('DAC_COLCUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar + qryCadDac.FieldByName('DAC_COLVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar + qryCadDac.FieldByName('DAC_COLVEN').AsFloat;

  dicRetorno['unidad'] := qryCadDac.FieldByName('DAC_CODUNI').AsString;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;

  Result := True;

end;

function fRetornaUniTraProDacar(qryCadDac: TUniQuery; strIteTin,
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
  conf      := fGetConfTinta('DAC');

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
  strSQL := strSQL + '  DAC_CADDAC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(DAC_REFERE, DAC_CODUNI, DAC_DESCRI) = :ITETIN ';

  With qryCadDac Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strSiglaTrava := conf.fGet('TRADAC'); //fArqIniTinta(0, 'DACAR', 'TRADAC', '');
  strCampoTrava := 'DAC_COL' + strSiglaTrava;
  fltFatTrava   := conf.fGetDouble('FATDAC'); //fStrToFloat(fArqIniTinta(0, 'DACAR', 'FATDAC', ''));

  Result := fFormataFloat((qryGen001.FieldByName('ITE_PRE' + strSiglaTrava).AsFloat + 
                           qryCadDac.FieldByName(strCampoTrava).AsFloat) * fltFatTrava, 4);

  FreeAndNil(qryGen001);
end;

function fRetornaDescricaoDacar(strDesCor: String; qryCadDac: TUniQuery): String;
begin
  Result := strDesCor + ' ' +
            qryCadDac.FieldByName('DAC_DESCRI').AsString + ' ' +
            qryCadDac.FieldByName('DAC_REFERE').AsString + ' ' +
            qryCadDac.FieldByName('DAC_CODUNI').AsString;
end;

function fTrocaBase(Sender: TForm; qryCadDac: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
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
      fltCusBas := qryCadDac.FieldByName('DAC_PRECUS').AsFloat - qryCadDac.FieldByName('DAC_COLCUS').AsFloat;
      fltVenBas := qryCadDac.FieldByName('DAC_PREVEN').AsFloat - qryCadDac.FieldByName('DAC_COLVEN').AsFloat;
    End;
  End;

end;

function fGTinForDacar(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  DAC_CADDAC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(DAC_REFERE, DAC_CODUNI, DAC_DESCRI) = :ITETIN ';

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

      strCamFor := 'DAC_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'DAC_QTDB' + fStrZero(IntToStr(intContador), 2);

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
  strSQL := strSQL + '  DAC_CADCOL ';
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

function fConsultaDacar(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndDac: TStringList;
    stlDesIndDac: TStringList;
    qryConsulta01: TUniQuery;
begin

  qryConsulta01 := fCriaQuery(Nil);
  Application.CreateForm(TfrmConsultaCadDac, frmConsultaCadDac);

  stlCamIndDac := TStringList.Create;
  stlDesIndDac := TStringList.Create;

  stlCamIndDac.Add('D.DAC_DESCRI+D.DAC_REFERE');
  stlCamIndDac.Add('D.DAC_REFERE');
  stlCamIndDac.Add('I.ITE_DESITE');

  stlDesIndDac.Add('Descricao/Referencia');
  stlDesIndDac.Add('Referencia');
  stlDesIndDac.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.DAC_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  D.DAC_REFERE AS "Referencia", ';
  strSQL := strSQL + '  D.DAC_CODUNI AS "Unidade", ';
  strSQL := strSQL + '  D.DAC_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  D.DAC_PREVEN, ';
  strSQL := strSQL + '  D.DAC_PRECUS, ';
  strSQL := strSQL + '  D.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DAC_CADDAC D, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  D.DAC_CODITE = I.ITE_CODITE ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadDac, qryConsulta01, 'DAC_CADDAC',
      strSQL, stlCamIndDac, stlDesIndDac, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndDac);
  FreeAndNil(stlDesIndDac);

  FreeAndNil(frmConsultaCadDac);
  FreeAndNil(qryConsulta01);

end;

function fConsultaDacarGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndDac: TStringList;
    stlDesIndDac: TStringList;
    qryConsulta01: TUniQuery;
begin

  qryConsulta01 := fCriaQuery(Nil);
  Application.CreateForm(TfrmConsultaCadDacGeral, frmConsultaCadDacGeral);

  stlCamIndDac := TStringList.Create;
  stlDesIndDac := TStringList.Create;

  stlCamIndDac.Add('D.DAC_DESCRI+D.DAC_REFERE');
  stlCamIndDac.Add('D.DAC_REFERE');
  stlCamIndDac.Add('I.ITE_DESITE');

  stlDesIndDac.Add('Descricao/Referencia');
  stlDesIndDac.Add('Referencia');
  stlDesIndDac.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.DAC_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  D.DAC_REFERE AS "Referencia", ';
  strSQL := strSQL + '  D.DAC_CODUNI AS "Unidade", ';
  strSQL := strSQL + '  D.DAC_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  D.DAC_PREVEN, ';
  strSQL := strSQL + '  D.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DAC_CADDAC D, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  D.DAC_CODITE = I.ITE_CODITE ';
    
  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadDacGeral, qryConsulta01, 'DAC_CADDAC',
      strSQL, stlCamIndDac, stlDesIndDac, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndDac);
  FreeAndNil(stlDesIndDac);

  FreeAndNil(frmConsultaCadDacGeral);
  FreeAndNil(qryConsulta01);

end;

function fConsultaDacarVenda(Sender: TForm; strCodEmp: String;
  qryCadDac: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndDac: TStringList;
    stlDesIndDac: TStringList;
begin

  Application.CreateForm(TfrmConsultaCadDacVenda, frmConsultaCadDacVenda);

  stlCamIndDac := TStringList.Create;
  stlDesIndDac := TStringList.Create;

  stlCamIndDac.Add('D.DAC_DESCRI+D.DAC_REFERE');
  stlCamIndDac.Add('D.DAC_REFERE');
  stlCamIndDac.Add('I.ITE_DESITE');

  stlDesIndDac.Add('Descricao/Referencia');
  stlDesIndDac.Add('Referencia');
  stlDesIndDac.Add('Base');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  D.DAC_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  D.DAC_REFERE AS "Referencia", ';
  strSQL := strSQL + '  D.DAC_CODUNI AS "Unidade", ';
  strSQL := strSQL + '  D.DAC_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  I.ITE_DESITE AS "Base", ';
  strSQL := strSQL + '  D.DAC_PREVEN, ';
  strSQL := strSQL + '  D.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DAC_CADDAC D, ';
  strSQL := strSQL + '  CADITE I ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  D.DAC_CODITE = I.ITE_CODITE ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadDacVenda, qryCadDac, 'DAC_CADDAC',
      strSQL, stlCamIndDac, stlDesIndDac, '', False, True, 5, True) Then
  Begin
    If (qryCadDac.IsEmpty) Then
      Result := '-1'
    Else
      Result := qryCadDac.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndDac);
  FreeAndNil(stlDesIndDac);

  FreeAndNil(frmConsultaCadDacVenda);

end;

procedure pRetornaDadosDacar(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadDac: TUniQuery;
    strSQL: String;
begin

  qryCadDac := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DAC_CADDAC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(DAC_REFERE, DAC_CODUNI, DAC_DESCRI) = :ITETIN ';

  With qryCadDac Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadDac.FieldByName('DAC_DESCRI').AsString;
    Close;
  End;

  FreeAndNil(qryCadDac);
end;

end.
