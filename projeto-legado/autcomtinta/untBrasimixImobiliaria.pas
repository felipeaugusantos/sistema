unit untBrasimixImobiliaria;

interface

uses Forms, Classes, Uni, SysUtils, StrUtils, untFuncoesSimples;

  function fConsultaBrasimixImob(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaBrasimixImobGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaBrasimixImobVenda(Sender: TForm; strCodEmp: String;
    qryCadBzi: TUniQuery): String; stdcall;

  function fRetornaPrecoBrasimixImob(Sender: TForm; qryCadBzi: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fRetornaDescricaoBrasimixImob(strDescri: String; qryTinta: TUniQuery): String;
  function fRetornaReferenciaBrasimixImob(qryTinta: TUniQuery): String;

  function fTrocaBase(Sender: TForm; qryCadBzi: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
    Var strNovBas: String; Var fltCusBas, fltVenBas: Double; Var strRefere: String): Boolean;

  function fRetornaUniTraProBrasimixImob(qryCadBzi: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;

  function fGTinForBrasimixImob(strIteTin: String; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;

  procedure pRetornaDadosBrasimixImobiliaria(strIteTin: String; dicRetorno: TDicionario);

implementation

uses untConsultaCadBzi, untConsultaCadBziGeral, Data.DB, untIConfTinta, untTintaMaquina,
  untConsultaCadBziVenda, untFuncEspecificas, untFatTrocaBase, untConsultas, untTypesSistema;

function fConsultaBrasimixImob(Sender: TForm; strCodEmp: String): String;
begin
  fConsultaBrasimixImobVenda(Sender, strCodEmp, Nil);
end;

function fConsultaBrasimixImobGeral(Sender: TForm; strCodEmp: String): String;
begin
fConsultaBrasimixImobVenda(Sender, strCodEmp, Nil);
end;

function fConsultaBrasimixImobVenda(Sender: TForm; strCodEmp: String; qryCadBzi: TUniQuery): String;
  Var
    arrSel: TconsultasArray;
    qryConsulta01: TUniQuery;
    key: Char;
begin
  If Not Assigned(qryCadBzi) Then
    qryConsulta01 := fCriaQuery(Nil)
  Else
    qryConsulta01 := qryCadBzi;
  Try
     If fPesqCadastroTintas(Sender, conBzi, qryConsulta01, key,arrSel) Then
        Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  Finally
      If Not Assigned(qryCadBzi) Then
        FreeAndNil(qryConsulta01);
  End;

end;

function fRetornaPrecoBrasimixImob(Sender: TForm; qryCadBzi: TUniQuery;
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
  If (fConsultaBrasimixImobVenda(Sender, strCodEmp, qryCadBzi) = '-1') Then
  Begin
    Exit;
  End;

  If (Not fTrocaBase(Sender, qryCadBzi, strTabPre, strCodEmp, qryCadBzi.FieldByName('BZI_CODITE').AsString,
    strCodIte, fltPreCus, fltUnitar, strRefBas)) Then
  Begin
    Exit;
  End;

  strDesCor := fDesCor('BRASIMIX IMOB. -> DESCRIÇÃO DA COR', strDesCor);
  strDesCor := strRefBas + IIF(fEmptyStr(strRefBas), '', ' ') + strDesCor;

  strIteTin := qryCadBzi.FieldByName('BZI_CODIGO').AsString +
               qryCadBzi.FieldByName('BZI_UNIDAD').AsString;

  strChaFor := qryCadBzi.FieldByName('BZI_DESCRI').AsString + ' ' +
               qryCadBzi.FieldByName('BZI_REFERE').AsString + ' ' +
               qryCadBzi.FieldByName('BZI_UNIDAD').AsString;

  fltPreCus := fltPreCus + qryCadBzi.FieldByName('BZI_COLCUS').AsFloat;

  If (blnUsaPreCus) Then
    fltUnitar := fltPreCus
  Else
    fltUnitar := fltUnitar + qryCadBzi.FieldByName('BZI_COLVEN').AsFloat;

  If (strOpcDoc = 'BR') Then
    fltUnitar := fltUnitar + qryCadBzi.FieldByName('BZI_COLVEN').AsFloat;

  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['precus'] := fltPreCus;
  dicRetorno['codite'] := strCodIte;
  dicRetorno['descor'] := strDesCor;
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['chafor'] := strChaFor;

  Result := True;
end;

function fRetornaDescricaoBrasimixImob(strDescri: String; qryTinta: TUniQuery): String;
begin

  Result := qryTinta.FieldByName('BZI_DESCRI').AsString + ' ' +
            qryTinta.FieldByName('BZI_REFERE').AsString + ' ' +
            qryTinta.FieldByName('BZI_UNIDAD').AsString + ' ' +
            strDescri;

end;

function fRetornaReferenciaBrasimixImob(qryTinta: TUniQuery): String;
begin
  Result := qryTinta.FieldByName('BZI_REFERE').AsString;
end;

function fTrocaBase(Sender: TForm; qryCadBzi: TUniQuery; strTabPre, strCodEmp, strCodBas: String;
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
      fltCusBas := qryCadBzi.FieldByName('BZI_PRECUS').AsFloat - qryCadBzi.FieldByName('BZI_COLCUS').AsFloat;
      fltVenBas := qryCadBzi.FieldByName('BZI_PREVEN').AsFloat - qryCadBzi.FieldByName('BZI_COLVEN').AsFloat;
    End;
  End;

end;

function fRetornaUniTraProBrasimixImob(qryCadBzi: TUniQuery; strIteTin, strCodBas, strTabPre: String): Double;
  Var
    strCampoTrava: String;
    strSiglaTrava: String;
    fltFatTrava: Double;
    strSQL: String;

    qryGen001: TUniQuery;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('BZI');
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
  strSQL := strSQL + '  BZI_CADBZI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(BZI_CODIGO, BZI_UNIDAD) = :ITETIN ';

  With qryCadBzi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strSiglaTrava := conf.fGet('TRABRI'); //fArqIniTinta(0, 'Brasimix Imobiliaria', 'TRABRI', '');
  strCampoTrava := 'BZI_COL' + strSiglaTrava;
  fltFatTrava   := conf.fGetDouble('FATBRI'); //fStrToFloat(fArqIniTinta(0, 'Brasimix Imobiliaria', 'FATBRI', ''));

  Result := fFormataFloat((qryGen001.FieldByName('ITE_PRE' + strSiglaTrava).AsFloat +
                           qryCadBzi.FieldByName(strCampoTrava).AsFloat) * fltFatTrava, 4);

  FreeAndNil(qryGen001);
end;

function fGTinForBrasimixImob(strIteTin: String; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  BZI_CADBZI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(BZI_CODIGO, BZI_UNIDAD) = :ITETIN ';

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

      strCamFor := 'BZI_CODC' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'BZI_QTDC' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := FieldByName(strCamBas).AsFloat / 100.0;

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
  strSQL := strSQL + '  BZI_CADCOL ';
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

end;

procedure pRetornaDadosBrasimixImobiliaria(strIteTin: String; dicRetorno: TDicionario);
  Var
    strSQL: String;
    qryCadBzi: TUniQuery;
begin
  qryCadBzi := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZI_CADBZI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(BZI_CODIGO, BZI_UNIDAD) = :ITETIN ';

  With qryCadBzi Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('BZI_CODIGO').AsString;
    dicRetorno['martin'] := FieldByName('BZI_REFERE').AsString;
    Close;
  End;

  FreeAndNil(qryCadBzi);
end;

end.

