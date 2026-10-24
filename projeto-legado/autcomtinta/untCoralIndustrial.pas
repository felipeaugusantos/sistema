unit untCoralIndustrial;

interface

uses Forms, Classes, Uni, SysUtils,  StrUtils, untFuncoesSimples;

  function fConsultaCoralInd(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaCoralIndGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaCoralIndVenda(Sender: TForm; strCodEmp: String;
    qryCadCor: TUniQuery): String; stdcall;

  function fRetornaDescricaoCoralInd(strDescri: String; qryTinta: TUniQuery): String;
  function fRetornaReferenciaCoralInd(qryTinta: TUniQuery): String;

  function fTrocaBase(Sender: TForm; qryCadCim: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
    Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strDesBas, strRefere, strUniBas: String): Boolean;

  function fRetornaUniTraProCoralInd(qryCadCim: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;

  function fRetornaPrecoCoralInd(Sender: TForm; qryCadCim: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGTinForCoralInd(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  procedure pRetornaDadosCoraIndustrial(strIteTin: String; dicRetorno: TDicionario);

implementation

uses Data.DB,
  untFatTrocaBase, untFuncEspecificas, untConsultas, untTypesSistema;

function fConsultaCoralInd(Sender: TForm; strCodEmp: String): String;
begin
  Result := fConsultaCoralIndVenda(Sender, strCodEmp, Nil);
end;

function fConsultaCoralIndGeral(Sender: TForm; strCodEmp: String): String;
begin
  Result := fConsultaCoralIndVenda(Sender, strCodEmp, Nil);
end;

function fConsultaCoralIndVenda(Sender: TForm; strCodEmp: String; qryCadCor: TUniQuery): String;
  Var
    arrSel: TconsultasArray;
    qryConsulta01: TUniQuery;
    key: Char;
begin
  If Not Assigned(qryCadCor) Then
    qryConsulta01 := fCriaQuery(Nil)
  Else
    qryConsulta01 := qryCadCor;
  Try
     If fPesqCadastroTintas(Sender, conCorInd, qryConsulta01, key,arrSel) Then
       Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  Finally
      If Not Assigned(qryCadCor) Then
        FreeAndNil(qryConsulta01);
  End;
end;

function fRetornaDescricaoCoralInd(strDescri: String; qryTinta: TUniQuery): String;
begin

  //Result := qryTinta.FieldByName('COR_DESCRI').AsString + ' ' +
  //          qryTinta.FieldByName('COR_UNIDAD').AsString + ' ' +
  //          strDescri;
  Result := strDescri;

end;

function fRetornaReferenciaCoralInd(qryTinta: TUniQuery): String;
begin
  Result := '';
end;

function fTrocaBase(Sender: TForm; qryCadCim: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
  Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strDesBas, strRefere, strUniBas: String): Boolean;
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
    strUniBas := frmFatTrocaBase.strUnidad;
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
      fltCusBas := qryCadCim.FieldByName('COR_PRECUS').AsFloat - qryCadCim.FieldByName('COR_COLCUS').AsFloat;
      fltVenBas := qryCadCim.FieldByName('COR_PREVEN').AsFloat - qryCadCim.FieldByName('COR_COLVEN').AsFloat;
      strDesBas := qryCadCim.FieldByName('COR_DESCRI').AsString;
      strUniBas := qryCadCim.FieldByName('COR_UNIDAD').AsString;
    End
    Else
    Begin
      strDesBas := Copy(qryCadCim.FieldByName('COR_DESCRI').AsString, 1, Pos(' ', qryCadCim.FieldByName('COR_DESCRI').AsString)) + strDesBas;
    End;
  End;
  
end;

function fRetornaUniTraProCoralInd(qryCadCim: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;
  Var
    strCampoTrava: String;
    strSiglaTrava: String;
    fltFatTrava: Double;
    strSQL: String;

    qryGen001: TUniQuery;
begin

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
  strSQL := strSQL + '  CORIND_CADCOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COR_CODSEQ = :ITETIN ';

  With qryCadCim Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strSiglaTrava := fArqIniTinta(0, 'Coral Industrial', 'TRACOR', '');
  strCampoTrava := 'COR_COL' + strSiglaTrava;
  fltFatTrava   := fStrToFloat(fArqIniTinta(0, 'Coral Industrial', 'FATCOR', ''));

  Result := fFormataFloat((qryGen001.FieldByName('ITE_PRE' + strSiglaTrava).AsFloat +
                           qryCadCim.FieldByName(strCampoTrava).AsFloat) * fltFatTrava, 4);

  FreeAndNil(qryGen001);
end;

function fRetornaPrecoCoralInd(Sender: TForm; qryCadCim: TUniQuery;
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
    strUniBas: String;
    strChaFor: String;
begin

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTabPre    := dicRetorno['tabpre'];

  Result := False;
  If (fConsultaCoralIndVenda(Sender, strCodEmp, qryCadCim) = '-1') Then
  Begin
    Exit;
  End;

  If (Not fTrocaBase(Sender, qryCadCim, strTabPre, strCodEmp, qryCadCim.FieldByName('COR_CODITE').AsString,
    strCodIte, fltPreCus, fltUnitar, strDesBas, strRefBas, strUniBas)) Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('CORAL IND. -> DESCRIÇÃO DA COR', strDesCor);
  //strDesCor := strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strDesCor;
  strDesCor := strDesBas + IIF(fEmptyStr(strRefBas), '', ' ') + strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strUniBas + ' ' + strDesCor;
  strDesCor := strDesCor + ' ' + qryCadCim.FieldByName('COR_CODIGO').AsString;

  strChaFor := IIF(fEmptyStr(strRefBas), '', ' ') + strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strUniBas;
  strChaFor := strChaFor + ' ' + qryCadCim.FieldByName('COR_CODIGO').AsString;

  strIteTin := qryCadCim.FieldByName('COR_CODSEQ').AsString;

  fltPreCus := fltPreCus + qryCadCim.FieldByName('COR_COLCUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar + qryCadCim.FieldByName('COR_COLVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar + qryCadCim.FieldByName('COR_COLVEN').AsFloat;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;

  Result := True;
end;

function fGTinForCoralInd(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  CORIND_CADCOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COR_CODSEQ = :ITETIN ';

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

    For intContador := 1 To 10 Do
    Begin

      strCamFor := 'COR_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'COR_QTDC' + fStrZero(IntToStr(intContador), 2);

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
  strSQL := strSQL + '  CORIND_CADCOL ';
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

procedure pRetornaDadosCoraIndustrial(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadCid: TUniQuery;
    strSQL: String;
begin
  qryCadCid := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CORIND_CADCOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  COR_CODSEQ = :ITETIN ';

  With qryCadCid Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := qryCadCid.FieldByName('COR_COLID1').AsString + '/' +
                            qryCadCid.FieldByName('COR_COLID2').AsString;
    dicRetorno['martin'] := qryCadCid.FieldByName('COR_DESPRO').AsString;
    Close;
  End;

  FreeAndNil(qryCadCid);
end;

end.
