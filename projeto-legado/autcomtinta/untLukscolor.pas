unit untLukscolor;

interface

uses SysUtils, Forms, Classes,  Uni,
  Dialogs, StrUtils, untFuncoesSimples;

  function fRetornaPrecoLukscolor(Sender: TForm; qryCadLks: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaUniTraProLukscolor(qryCadLks: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;

  function fRetornaDescricaoLukscolor(strDesCor: String; qryCadLks: TUniQuery): String;

  function fTrocaBase(Sender: TForm; qryCadLks: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
    Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strDesBas, strRefere, strUniBas: String): Boolean;

  function fGTinForLukscolor(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  function fConsultaLukscolor(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaLukscolorGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaLukscolorVenda(Sender: TForm; strCodEmp: String; qryCadLks: TUniQuery): String; stdcall;

  procedure pRetornaDadosLukscolor(strIteTin: String; dicRetorno: TDicionario);

implementation

uses DB, untFuncEspecificas, untIConfTinta, untTintaMaquina,untFatTrocaBase,
untConsultaCadLks, untConsultaCadLksGeral,
untConsultaCadLksVenda, untTypesSistema, untConsultas;

function fRetornaPrecoLukscolor(Sender: TForm; qryCadLks: TUniQuery;
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
  If (fConsultaLukscolorVenda(Sender, strCodEmp, qryCadLks) = '-1') Then
  Begin
    Exit;
  End;

  If (Not fTrocaBase(Sender, qryCadLks, strTabPre, strCodEmp, qryCadLks.FieldByName('LKS_CODITE').AsString,
    strCodIte, fltPreCus, fltUnitar, strDesBas, strRefBas, strUniBas)) Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('LUKSCOLOR -> DESCRIÇÃO DA COR', strDesCor);
  strDesCor := strDesBas + IIF(fEmptyStr(strRefBas), '', ' ') + strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strUniBas + ' ' + strDesCor;

  strIteTin := qryCadLks.FieldByName('LKS_REFERE').AsString +
               qryCadLks.FieldByName('LKS_UNIDAD').AsString +
               qryCadLks.FieldByName('LKS_DESCRI').AsString;

  strChaFor := qryCadLks.FieldByName('LKS_DESCRI').AsString + ' ' +
               qryCadLks.FieldByName('LKS_REFERE').AsString + ' ' +
               qryCadLks.FieldByName('LKS_UNIDAD').AsString;

  fltPreCus := fltPreCus + qryCadLks.FieldByName('LKS_COLCUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar + qryCadLks.FieldByName('LKS_COLVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar + qryCadLks.FieldByName('LKS_COLVEN').AsFloat;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;

  Result := True;

end;

function fRetornaUniTraProLukscolor(qryCadLks: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;
  Var
    strSiglaTrava: String;
    strCampoTrava: String;
    fltFatTrava: Double;
    strSQL: String;

    qryGen001: TUniQuery;
    conf: IConfTinta;
begin

  qryGen001 := fCriaQuery(Nil);
  conf := fGetConfTinta('LKS');

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
  strSQL := strSQL + '  LKS_CADLKS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(LKS_REFERE, LKS_UNIDAD, LKS_DESCRI) = :ITETIN ';

  With qryCadLks Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strSiglaTrava := conf.fGet('TRALKS');
  strCampoTrava := 'LKS_COL' + strSiglaTrava;
  fltFatTrava   := conf.fGetDouble('FATLKS');

  Result := fFormataFloat((qryGen001.FieldByName('ITE_PRE' + strSiglaTrava).AsFloat +
                           qryCadLks.FieldByName(strCampoTrava).AsFloat) * fltFatTrava, 2);

  FreeAndNil(qryGen001);
end;

function fRetornaDescricaoLukscolor(strDesCor: String; qryCadLks: TUniQuery): String;
begin
  //Result := qryCadLks.FieldByName('LKS_DESCRI').AsString + ' ' +
  //          qryCadLks.FieldByName('LKS_REFERE').AsString + ' ' +
  //          qryCadLks.FieldByName('LKS_UNIDAD').AsString + ' ' +
  Result := strDesCor;
end;

function fTrocaBase(Sender: TForm; qryCadLks: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
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
      fltCusBas := qryCadLks.FieldByName('LKS_PRECUS').AsFloat - qryCadLks.FieldByName('LKS_COLCUS').AsFloat;
      fltVenBas := qryCadLks.FieldByName('LKS_PREVEN').AsFloat - qryCadLks.FieldByName('LKS_COLVEN').AsFloat;
      strDesBas := qryCadLks.FieldByName('LKS_DESCRI').AsString;
      strRefere := qryCadLks.FieldByName('LKS_REFERE').AsString;
      strUniBas := qryCadLks.FieldByName('LKS_UNIDAD').AsString;
    End
    Else
    Begin
      strDesBas := Copy(qryCadLks.FieldByName('LKS_DESCRI').AsString, 1, Pos(' ', qryCadLks.FieldByName('LKS_DESCRI').AsString)) + strDesBas;
    End;
  End;

end;

function fGTinForLukscolor(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  LKS_CADLKS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(LKS_REFERE, LKS_UNIDAD, LKS_DESCRI) = :ITETIN ';

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

      strCamFor := 'LKS_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'LKS_QTDC' + fStrZero(IntToStr(intContador), 2);

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
  strSQL := strSQL + '  LKS_CADCOL ';
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

function fConsultaLukscolor(Sender: TForm; strCodEmp: String): String;
begin
  fConsultaLukscolorVenda(Sender, strCodEmp, Nil);
end;

function fConsultaLukscolorGeral(Sender: TForm; strCodEmp: String): String;
Begin
  fConsultaLukscolorVenda(Sender, strCodEmp, Nil);
end;

function fConsultaLukscolorVenda(Sender: TForm; strCodEmp: String; qryCadLks: TUniQuery): String;
Var
    arrSel: TconsultasArray;
    qryConsulta01: TUniQuery;
    key: Char;
begin
  If Not Assigned(qryCadLks) Then
    qryConsulta01 := fCriaQuery(Nil)
  Else
    qryConsulta01 := qryCadLks;
  Try
     If fPesqCadastroTintas(Sender, conLks, qryConsulta01, key,arrSel) Then
       Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  Finally
      If Not Assigned(qryCadLks) Then
        FreeAndNil(qryConsulta01);
  End;
end;

procedure pRetornaDadosLukscolor(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadLks: TUniQuery;
    strSQL: String;
begin
  qryCadLks := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LKS_CADLKS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(LKS_REFERE, LKS_UNIDAD, LKS_DESCRI) = :ITETIN ';

  With qryCadLks Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('LKS_REFERE').AsString;
    Close;
  End;

  FreeAndNil(qryCadLks);
end;

end.
