unit untBrasimixAutomotiva;

interface

uses Forms, Uni, Classes, SysUtils,  StrUtils, Dialogs, untFuncoesSimples;

  function fConsultaBrasimixAutomotiva(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaBrasimixAutomotivaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaBrasimixAutomotivaVenda(Sender: TForm; strCodEmp: String;
    Var qryCadBza: TUniQuery): String; stdcall;

  function fDigEmbalagem(Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fRetornaDescricaoBrasimixAutomotiva(qryTinta: TUniQuery): String;

  function fRetornaUniTraProBrasimixAutomotiva(qryCadBza: TUniQuery; fltPreEmb, fltQuanti: Double;
    strIteTin: String): Double;

  function fRetornaUniTraEmbBrasimixAutomotiva(strTipEmb: String): Double;

  function fRetornaPrecoBrasimixAutomotiva(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGTinForBrasimixAutomotiva(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean; stdcall;

  procedure pRetornaDadosBrasimixAutomotiva(strIteTin: String; dicRetorno: TDicionario);

implementation

uses untConsultaCadBza, untConsultaCadBzaGeral, untIConfTinta, untTintaMaquina,
  untConsultaCadBzaVenda, DB, untFatDigEmbalagem, untFuncEspecificas;

function fConsultaBrasimixAutomotiva(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndBza: TStringList;
    stlDesIndBza: TStringList;
    strEmbBza: String;
    strGalBza: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);

  conf  := fGetConfTinta('BZA');
  stlCamIndBza := TStringList.Create;
  stlDesIndBza := TStringList.Create;

  strEmbBza    := AnsiReplaceStr(conf.fGet('EMBBZA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'Brasimix Automotiva', 'EMBBZA', ''), ',', '.');
  strGalBza    := AnsiReplaceStr(conf.fGet('GALBZA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'Brasimix Automotiva', 'GALBZA', ''), ',', '.');

  stlCamIndBza.Add('BZA_DESCRI+BZA_MONTAD');
  stlCamIndBza.Add('BZA_MONTAD');
  stlCamIndBza.Add('BZA_CODUNI');

  stlDesIndBza.Add('Descricao/Montadora');
  stlDesIndBza.Add('Montadora');
  stlDesIndBza.Add('Cód. Universal');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BZA_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  BZA_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  BZA_CODUNI AS "Cód. Universal", ';
  strSQL := strSQL + '  BZA_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  BZA_ARQTXT AS "Tipo", ';
  strSQL := strSQL + '  IF(BZA_PREVEN > 0, BZA_PREVEN + ' + strEmbBza + ', 0) AS BZA_VENLT, ';
  strSQL := strSQL + '  IF(BZA_PRECUS > 0, BZA_PRECUS + ' + strEmbBza + ', 0) AS BZA_CUSLT, ';
//  strSQL := strSQL + '  IF(BZA_PREVEN > 0, (ROUND((BZA_PREVEN / 0.900), 2) * 3.600) + ' + strGalBza + ', 0) AS BZA_VENGL, ';
//  strSQL := strSQL + '  IF(BZA_PREVEN > 0, (ROUND((BZA_PRECUS / 0.900), 2) * 3.600) + ' + strGalBza + ', 0) AS BZA_CUSGL, ';
  strSQL := strSQL + '  IF(BZA_PREVEN > 0, (BZA_PREVEN * 4) + ' + strGalBza + ', 0) AS BZA_VENGL, ';
  strSQL := strSQL + '  IF(BZA_PRECUS > 0, (BZA_PRECUS * 4) + ' + strGalBza + ', 0) AS BZA_CUSGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZA_CADBZA ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  BZA_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + '  TRUE ';

  Application.CreateForm(TfrmConsultaCadBza, frmConsultaCadBza);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadBza, qryConsulta01, 'BZA_CADBZA',
        strSQL, stlCamIndBza, stlDesIndBza, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadBza);

  FreeAndNil(stlCamIndBza);
  FreeAndNil(stlDesIndBza);
  FreeAndNil(qryConsulta01);

end;

function fConsultaBrasimixAutomotivaGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndBza: TStringList;
    stlDesIndBza: TStringList;
    strEmbBza: String;
    strGalBza: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);

  conf := fGetConfTinta('BZA');
  stlCamIndBza := TStringList.Create;
  stlDesIndBza := TStringList.Create;

  strEmbBza    := AnsiReplaceStr(conf.fGet('EMBBZA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'Brasimix Automotiva', 'EMBBZA', ''), ',', '.');
  strGalBza    := AnsiReplaceStr(conf.fGet('GALBZA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'Brasimix Automotiva', 'GALBZA', ''), ',', '.');

  stlCamIndBza.Add('BZA_DESCRI+BZA_MONTAD');
  stlCamIndBza.Add('BZA_MONTAD');
  stlCamIndBza.Add('BZA_CODUNI');

  stlDesIndBza.Add('Descricao/Montadora');
  stlDesIndBza.Add('Montadora');
  stlDesIndBza.Add('Cód. Universal');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BZA_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  BZA_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  BZA_CODUNI AS "Cód. Universal", ';
  strSQL := strSQL + '  BZA_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  BZA_ARQTXT AS "Tipo", ';
  strSQL := strSQL + '  IF(BZA_PREVEN > 0, BZA_PREVEN + ' + strEmbBza + ', 0) AS BZA_VENLT, ';
  //strSQL := strSQL + '  IF(BZA_PREVEN > 0, (ROUND((BZA_PREVEN / 0.900), 2) * 3.600) + ' + strGalBza + ', 0) AS BZA_VENGL, ';
  strSQL := strSQL + '  IF(BZA_PREVEN > 0, (BZA_PREVEN * 4) + ' + strGalBza + ', 0) AS BZA_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZA_CADBZA ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  BZA_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + '  TRUE ';

  Application.CreateForm(TfrmConsultaCadBzaGeral, frmConsultaCadBzaGeral);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadBzaGeral, qryConsulta01, 'BZA_CADBZA',
        strSQL, stlCamIndBza, stlDesIndBza, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadBzaGeral);

  FreeAndNil(stlCamIndBza);
  FreeAndNil(stlDesIndBza);
  FreeAndNil(qryConsulta01);
end;

function fConsultaBrasimixAutomotivaVenda(Sender: TForm; strCodEmp: String;
  Var qryCadBza: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndBza: TStringList;
    stlDesIndBza: TStringList;
    strEmbBza: String;
    strGalBza: String;
    conf: IConfTinta;
begin

  conf := fGetConfTinta('BZA');
  stlCamIndBza := TStringList.Create;
  stlDesIndBza := TStringList.Create;

  strEmbBza    := AnsiReplaceStr(conf.fGet('EMBBZA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'Brasimix Automotiva', 'EMBBZA', ''), ',', '.');
  strGalBza    := AnsiReplaceStr(conf.fGet('GALBZA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'Brasimix Automotiva', 'GALBZA', ''), ',', '.');

  stlCamIndBza.Add('BZA_DESCRI+BZA_MONTAD');
  stlCamIndBza.Add('BZA_MONTAD');
  stlCamIndBza.Add('BZA_CODUNI');

  stlDesIndBza.Add('Descricao/Montadora');
  stlDesIndBza.Add('Montadora');
  stlDesIndBza.Add('Cód. Universal');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BZA_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  BZA_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  BZA_CODUNI AS "Cód. Universal", ';
  strSQL := strSQL + '  BZA_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  BZA_ARQTXT AS "Tipo", ';
  strSQL := strSQL + '  IF(BZA_PREVEN > 0, BZA_PREVEN + ' + strEmbBza + ', 0) AS BZA_VENLT, ';
  //strSQL := strSQL + '  IF(BZA_PREVEN > 0, (ROUND((BZA_PREVEN / 0.900), 2) * 3.600) + ' + strGalBza + ', 0) AS BZA_VENGL, ';
  strSQL := strSQL + '  IF(BZA_PREVEN > 0, (BZA_PREVEN * 4) + ' + strGalBza + ', 0) AS BZA_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZA_CADBZA ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  BZA_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + '  TRUE ';

  Application.CreateForm(TfrmConsultaCadBzaVenda, frmConsultaCadBzaVenda);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadBzaVenda, qryCadBza, 'BZA_CADBZA',
        strSQL, stlCamIndBza, stlDesIndBza, '', False, True, 5, True)) Then
  Begin
    If (Not qryCadBza.IsEmpty) Then
    Result := qryCadBza.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadBzaVenda);

  FreeAndNil(stlCamIndBza);
  FreeAndNil(stlDesIndBza);

end;

function fRetornaDescricaoBrasimixAutomotiva(qryTinta: TUniQuery): String;
begin
  Result := qryTinta.FieldByName('BZA_DESCRI').AsString + ' ' +
            qryTinta.FieldByName('BZA_MONTAD').AsString + ' ' +
            qryTinta.FieldByName('BZA_A_N_O_').AsString + ' ' +
            qryTinta.FieldByName('BZA_ARQTXT').AsString;
end;

function fRetornaUniTraProBrasimixAutomotiva(qryCadBza: TUniQuery; fltPreEmb, fltQuanti: Double;
  strIteTin: String): Double;
Var
  conf: IConfTinta;
begin

  conf := fGetConfTinta('BZA');

  With qryCadBza Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM BZA_CADBZA WHERE BZA_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  Result := qryCadBza.FieldByName('BZA_PRE' + conf.fGet('TRABZA')).AsFloat; //qryCadBza.FieldByName('BZA_PRE' + fArqIniTinta(0, 'Brasimix Automotiva', 'TRABZA', '0')).AsFloat;
  Result := Result / 0.900;
//  Result := Result + (fltPreEmb / fltQuanti);
  Result := Result * conf.fGetDouble('FATBZA'); //fStrToFloat(fArqIniTinta(0, 'Brasimix Automotiva', 'FATBZA', ''));

  Result := fFormataFloat(Result, 2);

end;

function fRetornaUniTraEmbBrasimixAutomotiva(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('BZA');
  
  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('EMBBZA') //fStrToFloat(fArqIniTinta(0, 'Brasimix Automotiva', 'EMBBZA', ''))
  Else
    fltPreEmb := conf.fGetDouble('GALBZA'); //fStrToFloat(fArqIniTinta(0, 'Brasimix Automotiva', 'GALBZA', ''));

  Result := fltPreEmb * conf.fGetDouble('FATBZA');//fStrToFloat(fArqIniTinta(0, 'Brasimix Automotiva', 'FATBZA', ''));
end;

function fGTinForBrasimixAutomotiva(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean; stdcall;
  Var
    strSQL: String;
    strCamFor: String;
    strCamBas: String;
    intPos: Integer;
    intContador: Integer;

    strBases: String;
    dicBases: TDicionario;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  dicBases := TDicionario.Create;
  strBases := '';

  Result := True;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZA_CADBZA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BZA_CODSEQ = :ITETIN ';

  With qryConsulta01 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;

    If (IsEmpty) Then
    Begin
      Close;
      Result := False;
      Exit;
    End;

    For intContador := 1 To 15 Do
    Begin

      strCamFor := 'BZA_CODB' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'BZA_QTDB' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := (FieldByName(strCamBas).AsFloat / 0.900) * fltQtdIte;

      dicBases[arrFormul[intContador].strFormul] := arrFormul[intContador].fltQtdBas;

      {*******************************************}
      {* GUARDA BASES PARA POSTERIOR BUSCA       *}
      {* DOS ITENS                               *}
      {****************************************MV*}
      strBases := strBases + QuotedStr(arrFormul[intContador].strFormul);
      If (Not fEmptyStr(arrFormul[intContador].strFormul)) Then
        strBases := strBases + ', ';

    End;

    strBases := Trim(strBases);
    If (RightStr(strBases, 1) = ',') Then
      strBases := Copy(strBases, 1, Length(strBases)-1);

  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  BAS_CODBAS, ';
  strSQL := strSQL + '  BAS_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  BZA_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  BAS_CODBAS IN (' + strBases + ') ';

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
      stlItensTraMl.Add(FieldByName('BAS_CODITE').AsString);

      arrBaixaPigmentos[intPos].strCodIte   := FieldByName('BAS_CODITE').AsString;
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[FieldByName('BAS_CODBAS').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicBases);
  FreeAndNil(qryConsulta01);

end;

function fRetornaPrecoBrasimixAutomotiva(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
  Var
    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    blnUsaPreCus: Boolean;
    strTipEmb: String;
    intQtdEmb: Integer;

    strIteTin: String;
    fltPreEmb: Double;
    fltEmbala: Double;
    fltPreCus: Double;
    fltUnitar: Double;
    fltPrcTin: Double;
    fltPrvTin: Double;

    strIteEmb: String;

    strMontad: String;
    strA_n_o_: String;

    stlDesEmb: TStringList;
    stlProEmb: TStringList;
    conf: IConfTinta;
begin

  Result := False;

  conf := fGetConfTinta('BZA');
  stlDesEmb := TStringList.Create;
  stlProEmb := TStringList.Create;

  strIteTin := '';

  strTipEmb := '';
  intQtdEmb := 0;
  fltPreEmb := 0.0;
  fltEmbala := 0.0;

  strCodEmp    := dicRetorno['codemp'];
  strOpcDoc    := dicRetorno['opcdoc'];
  blnUsaPreCus := dicRetorno['usaprecus'];
  strTipEmb    := dicRetorno['tipemb'];
  intQtdEmb    := dicRetorno['qtdemb'];

  stlDesEmb.Add('SINTETICO');
  stlDesEmb.Add('LACA');
  stlDesEmb.Add('POLIESTER');
  stlDesEmb.Add('P. U.');
  stlDesEmb.Add('EPOXI');

  If (fConsultaBrasimixAutomotivaVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('BZA_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('BZA_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('BZA_A_N_O_').AsString;

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  If (strTipEmb = 'GL') Then
  Begin

    stlProEmb.Add(conf.fGet('BZAIGL')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZAIGL', ''));
    stlProEmb.Add(conf.fGet('BZAGLA')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGLA', ''));
    stlProEmb.Add(conf.fGet('BZAGPO')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPO', ''));
    stlProEmb.Add(conf.fGet('BZAGPU')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPU', ''));
    stlProEmb.Add(conf.fGet('BZAGPE')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZAGPE', ''));

  End
  Else If (strTipEmb = 'LT') Then
  Begin
  
    stlProEmb.Add(conf.fGet('BZAIEM')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZAIEM', ''));
    stlProEmb.Add(conf.fGet('BZALLA')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZALLA', ''));
    stlProEmb.Add(conf.fGet('BZALPO')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPO', ''));
    stlProEmb.Add(conf.fGet('BZALPU')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPU', ''));
    stlProEmb.Add(conf.fGet('BZALPE')); //stlProEmb.Add(fArqIniTinta(0, 'Brasimix Automotiva', 'BZALPE', ''));

  End;

  If (Not fDigTipoEmbalagem(stlDesEmb, stlProEmb, strIteEmb)) Then
  Begin
    Exit;
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPreCus := qryTinta.FieldByName('BZA_PRECUS').AsFloat / 0.900;
  fltPrcTin := qryTinta.FieldByName('BZA_PRECUS').AsFloat / 0.900;

  If (blnUsaPreCus) Then
  Begin
    fltPrvTin := qryTinta.FieldByName('BZA_PRECUS').AsFloat / 0.900;
    fltUnitar := qryTinta.FieldByName('BZA_PRECUS').AsFloat / 0.900;
  End
  Else
  Begin
    fltPrvTin := qryTinta.FieldByName('BZA_PREVEN').AsFloat / 0.900;
    fltUnitar := qryTinta.FieldByName('BZA_PREVEN').AsFloat / 0.900;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROBZA'); //fArqIniTinta(0, 'Brasimix Automotiva', 'PROBZA', '');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := fRetornaDescricaoBrasimixAutomotiva(qryTinta) + strTipEmb;

  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmb);

  Result := True;

End;

{*******************************************}
{* DIGITAÇÃO DE EMBALAGEM (TIPO E QTD)     *}
{****************************************MV*}
function fDigEmbalagem(Var strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;
Var
  conf: IConfTinta;
begin

  conf := fGetConfTinta('BZA');
  Try
    Application.CreateForm(TfrmFatDigEmbalagem, frmFatDigEmbalagem);
    frmFatDigEmbalagem.strTipEmb      := strTipEmb;
    frmFatDigEmbalagem.edtQtdEmb.Text := IntToStr(intQtdEmb);
    frmFatDigEmbalagem.showModal;
  Finally
    Result := frmFatDigEmbalagem.blnConfirma;
    {*****************************************}
    {* CASO TENHA CANCELADO, SAI, SENAO      *}
    {* ATUALIZA AS VARIAVEIS                 *}
    {**************************************MV*}
    If (Result) Then
    Begin
      strTipEmb := frmFatDigEmbalagem.strTipEmb;
      intQtdEmb := StrToInt(frmFatDigEmbalagem.edtQtdEmb.Text);
    End;
    FreeAndNil(frmFatDigEmbalagem);
  End;

  If (Not Result) Then
    Exit;

  {*****************************************}
  {* LITRO                                 *}
  {**************************************MV*}
  If (strTipEmb = 'LT') Then
  Begin
    fltPreEmb := fStrToFloat(conf.fGet('EMBBZA')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'Brasimix Automotiva', 'EMBBZA', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := fStrToFloat(conf.fGet('GALBZA')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'Brasimix Automotiva', 'GALBZA', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;

end;

procedure pRetornaDadosBrasimixAutomotiva(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadBza: TUniQuery;
begin
  qryCadBza := fCriaQuery(Nil);

  With qryCadBza Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM BZA_CADBZA WHERE BZA_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('BZA_CODSEQ').AsString;
    dicRetorno['montad'] := FieldByName('BZA_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('BZA_ARQTXT').AsString;
    Close;
  End;

  FreeAndNil(qryCadBza);
end;

end.

