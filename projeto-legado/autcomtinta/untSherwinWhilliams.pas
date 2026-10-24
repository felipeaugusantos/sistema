unit untSherwinWhilliams;

interface

uses Classes, Forms, Uni,  SysUtils, untFuncoesSimples, StrUtils;

  function fConsultaSherwinWhilliams(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSherwinWhilliamsGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSherwinWhilliamsVenda(Sender: TForm; strCodEmp: String;
    qryCadShe: TUniQuery): String; stdcall;

  function fRetornaPrecoSherwinWhilliams(Sender: TForm; qryCadShe: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaDescricaoSherwinWhilliams(strDescri: String; qryTinta: TUniQuery): String;
  function fRetornaReferenciaSherwinWhilliams(qryTinta: TUniQuery): String;

  function fTrocaBase(Sender: TForm; qryCadShe: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
    Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strRefere, strDesBas: String): Boolean;

  function fRetornaUniTraProSherwinWhilliams(qryCadShe: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;

  procedure pRetornaDadosSherwinWhilliams(strIteTin: String; dicRetorno: TDicionario);

  function fGTinForSherwinWhilliams(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

implementation

uses untConsultaComp, DB, untFuncEspecificas,
  untFatTrocaBase, untConsultaCadSheVenda, untIConfTinta, 
  untTintaMaquina,untFuncoes;

function fConsultaSherwinWhilliams(Sender: TForm; strCodEmp: String): String; stdcall;
  Var
    strSQL: String;
    stlCamIndShe: TStringList;
    stlDesIndShe: TStringList;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  stlCamIndShe := TStringList.Create;
  stlDesIndShe := TStringList.Create;

  stlCamIndShe.Add('SHE_DESCRI+SHE_UNIDAD');
  stlCamIndShe.Add('SHE_UNIDAD');
  stlCamIndShe.Add('SHE_CODIG2');
  stlCamIndShe.Add('SHE_CODIGO');

  stlDesIndShe.Add('Descrição/Unidade');
  stlDesIndShe.Add('Unidade');
  stlDesIndShe.Add('Cód. 2');
  stlDesIndShe.Add('Código');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SHE_DESCRI AS "Descrição", ';
  strSQL := strSQL + '  SHE_CODIG2 AS "Cód. 2",  ';
  strSQL := strSQL + '  SHE_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  SHE_CODIGO AS "Código", ';
  strSQL := strSQL + '  FORMAT(SHE_PRECUS, 2) As "Preço de Custo", ';
  strSQL := strSQL + '  FORMAT(SHE_PREVEN, 2) AS "Preço de Venda", ';
  strSQL := strSQL + '  SHE_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  SHE_CADSHE.AUTOINCREM AS "AUTOINCREM" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SHE_CADSHE, ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SHE_CODITE = ITE_CODITE ';

  Result := '-1';

  Application.CreateForm(TfrmConsultaComp, frmConsultaComp);

  If (pConsultaEspecifica(Sender, frmConsultaComp, qryConsulta01,
       'SHE_CADSHE', strSQL, stlCamIndShe, stlDesIndShe, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaComp);

  FreeAndNil(stlCamIndShe);
  FreeAndNil(stlDesIndShe);
  FreeAndNil(qryConsulta01);

end;

function fConsultaSherwinWhilliamsGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  Var
    strSQL: String;
    stlCamIndShe: TStringList;
    stlDesIndShe: TStringList;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  stlCamIndShe := TStringList.Create;
  stlDesIndShe := TStringList.Create;

  stlCamIndShe.Add('SHE_DESCRI+SHE_UNIDAD');
  stlCamIndShe.Add('SHE_UNIDAD');
  stlCamIndShe.Add('SHE_CODIG2');
  stlCamIndShe.Add('SHE_CODIGO');

  stlDesIndShe.Add('Descrição/Unidade');
  stlDesIndShe.Add('Unidade');
  stlDesIndShe.Add('Cód. 2');
  stlDesIndShe.Add('Código');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SHE_DESCRI AS "Descrição", ';
  strSQL := strSQL + '  SHE_CODIG2 AS "Cód. 2",  ';
  strSQL := strSQL + '  SHE_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  SHE_CODIGO AS "Código", ';
  strSQL := strSQL + '  FORMAT(SHE_PREVEN, 2) AS "Preço de Venda", ';
  strSQL := strSQL + '  SHE_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  SHE_CADSHE.AUTOINCREM AS "AUTOINCREM" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SHE_CADSHE, ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SHE_CODITE = ITE_CODITE ';

  Result := '-1';

  Application.CreateForm(TfrmConsultaComp, frmConsultaComp);

  If (pConsultaEspecifica(Sender, frmConsultaComp, qryConsulta01,
       'SHE_CADSHE', strSQL, stlCamIndShe, stlDesIndShe, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaComp);

  FreeAndNil(stlCamIndShe);
  FreeAndNil(stlDesIndShe);
  FreeAndNil(qryConsulta01);

end;

function fConsultaSherwinWhilliamsVenda(Sender: TForm; strCodEmp: String;
  qryCadShe: TUniQuery): String; stdcall;
  Var
    strSQL: String;
    stlCamIndShe: TStringList;
    stlDesIndShe: TStringList;
begin

  stlCamIndShe := TStringList.Create;
  stlDesIndShe := TStringList.Create;

  stlCamIndShe.Add('SHE_DESCRI+SHE_UNIDAD');
  stlCamIndShe.Add('SHE_UNIDAD');
  stlCamIndShe.Add('SHE_CODIG2');
  stlCamIndShe.Add('SHE_CODIGO');

  stlDesIndShe.Add('Descrição/Unidade');
  stlDesIndShe.Add('Unidade');
  stlDesIndShe.Add('Cód. 2');
  stlDesIndShe.Add('Código');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SHE_DESCRI AS "Descrição", ';
  strSQL := strSQL + '  SHE_CODIG2 AS "Cód. 2",  ';
  strSQL := strSQL + '  SHE_UNIDAD AS "Unidade", ';
  strSQL := strSQL + '  SHE_CODIGO AS "Código", ';
  strSQL := strSQL + '  SHE_PREVEN, ';
  strSQL := strSQL + '  SHE_CODITE AS "Cód. Item", ';
  strSQL := strSQL + '  ITE_DESITE AS "Descrição Item", ';
  strSQL := strSQL + '  SHE_CADSHE.AUTOINCREM AS "AUTOINCREM" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SHE_CADSHE, ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SHE_CODITE = ITE_CODITE ';

  Result := '-1';

//  Application.CreateForm(TfrmConsultaComp, frmConsultaComp);
//
//  frmConsultaComp.Caption := 'Consulta - Sherwin Whilliams';
  Application.CreateForm(TfrmConsultaCadSheVenda, frmConsultaCadSheVenda);

  If (pConsultaEspecifica(Sender, frmConsultaCadSheVenda, qryCadShe,
       'SHE_CADSHE', strSQL, stlCamIndShe, stlDesIndShe, '', False, True, 5, True)) Then
  Begin
    If (Not qryCadShe.IsEmpty) Then
      Result := qryCadShe.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaComp);

  FreeAndNil(stlCamIndShe);
  FreeAndNil(stlDesIndShe);
  FreeAndNil(frmConsultaCadSheVenda);
end;

function fRetornaPrecoSherwinWhilliams(Sender: TForm; qryCadShe: TUniQuery;
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
    strDesBas: String;
    strChaFor: String;
begin

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
  If (fConsultaSherwinWhilliamsVenda(Sender, strCodEmp, qryCadShe) = '-1') Then
  Begin
    Exit;
  End;

  If (Not fTrocaBase(Sender, qryCadShe, strTabPre, strCodEmp, qryCadShe.FieldByName('SHE_CODITE').AsString,
    strCodIte, fltPreCus, fltUnitar, strRefBas, strDesBas)) Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('SHERWIN WHILLIAMS -> DESCRIÇÃO DA COR', strDesCor);
  strDesCor := qryCadShe.FieldByName('SHE_CODIGO').AsString + ' ' + strDesBas + ' ' + strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strDesCor;

  strIteTin := qryCadShe.FieldByName('SHE_CODSEQ').AsString;

  strChaFor := qryCadShe.FieldByName('SHE_DESCRI').AsString + ' ' +
               qryCadShe.FieldByName('SHE_CODIGO').AsString + ' ' +
               qryCadShe.FieldByName('SHE_CODIG2').AsString + ' ' +
               qryCadShe.FieldByName('SHE_UNIDAD').AsString;

  fltPreCus := fltPreCus + qryCadShe.FieldByName('SHE_COLCUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar + qryCadShe.FieldByName('SHE_COLVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar + qryCadShe.FieldByName('SHE_COLVEN').AsFloat;

  dicRetorno['unidad'] := qryCadShe.FieldByName('SHE_UNIDAD').AsString;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;

  Result := True;
end;

function fTrocaBase(Sender: TForm; qryCadShe: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
  Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strRefere, strDesBas: String): Boolean;
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
    strDesBas := frmFatTrocaBase.strDesBas;
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
      strDesBas := qryCadShe.FieldByName('SHE_DESCRI').AsString;
      fltCusBas := qryCadShe.FieldByName('SHE_PRECUS').AsFloat - qryCadShe.FieldByName('SHE_COLCUS').AsFloat;
      fltVenBas := qryCadShe.FieldByName('SHE_PREVEN').AsFloat - qryCadShe.FieldByName('SHE_COLVEN').AsFloat;
    End
    Else
    Begin
      strDesBas := qryCadShe.FieldByName('SHE_CODIGO').AsString + ' ' + strDesBas;
    End;
  End;

end;

function fRetornaDescricaoSherwinWhilliams(strDescri: String; qryTinta: TUniQuery): String;
begin
  Result := strDescri + ' ' +
            qryTinta.FieldByName('SHE_UNIDAD').AsString;
end;

function fRetornaReferenciaSherwinWhilliams(qryTinta: TUniQuery): String;
begin
  Result := qryTinta.FieldByName('SHE_CODIG2').AsString;
end;

function fRetornaUniTraProSherwinWhilliams(qryCadShe: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;
  Var
    strSiglaTrava: String;
    strCampoTrava: String;
    fltFatTrava: Double;
    strSQL: String;

    qryGen001: TUniQuery;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('SHE');
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
  strSQL := strSQL + '  SHE_CADSHE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SHE_CODSEQ = :ITETIN ';

  With qryCadShe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strSiglaTrava := conf.fGet('TRASHE');
  strCampoTrava := 'SHE_COL' + strSiglaTrava;
  fltFatTrava   := conf.fGetDouble('FATSHE');

  Result := fFormataFloat((fTruncaFloat(qryGen001.FieldByName('ITE_PRE' + strSiglaTrava).AsFloat, 2) +
                           qryCadShe.FieldByName(strCampoTrava).AsFloat) * fltFatTrava, 4);


  FreeAndNil(qryGen001);
end;

procedure pRetornaDadosSherwinWhilliams(strIteTin: String; dicRetorno: TDicionario);
  Var
    strSQL: String;
    qryCadShe: TUniQuery;
begin
  qryCadShe := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SHE_CADSHE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SHE_CODSEQ = :ITETIN ';

  With qryCadShe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('SHE_CODIGO').AsString;
    Close;
  End;

  FreeAndNil(qryCadShe);
end;

function fGTinForSherwinWhilliams(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  SHE_CADSHE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(SHE_CODIGO, SHE_CODIG2, SHE_DESCRI) = :ITETIN ';

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

      strCamFor := 'SHE_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'SHE_QTDB' + fStrZero(IntToStr(intContador), 2);

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
  strSQL := strSQL + '  SHE_CADCOL ';
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

end.
