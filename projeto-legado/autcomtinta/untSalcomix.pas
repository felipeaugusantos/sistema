unit untSalcomix;

interface

uses Forms, Uni, Classes, SysUtils, StrUtils, Dialogs, untFuncoesSimples;

  function fConsultaSalcomix(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSalcomixGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaSalcomixVenda(Sender: TForm; strCodEmp: String;
    Var qryCadSal: TUniQuery): String; stdcall;

  function fDigEmbalagem(Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fRetornaDescricaoSalcomix(qryTinta: TUniQuery): String;

  function fRetornaUniTraProSalcomix(qryCadSal: TUniQuery; fltPreEmb, fltQuanti: Double;
    strIteTin: String): Double;

  function fRetornaUniTraEmbSalcomix(strTipEmb: String): Double;

  function fRetornaPrecoSalcomix(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGTinForSalcomix(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean; stdcall;

  procedure pRetornaDadosSalcomix(strIteTin: String; dicRetorno: TDicionario);

implementation

uses untConsultaCadSal, untConsultaCadSalGeral,untIConfTinta, untTintaMaquina,
  untConsultaCadSalVenda, DB, untFatDigEmbalagem;

function fConsultaSalcomix(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndSal: TStringList;
    stlDesIndSal: TStringList;
    strEmbSal: String;
    strGalSal: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);
  conf          := fGetConfTinta('SAL');

  stlCamIndSal := TStringList.Create;
  stlDesIndSal := TStringList.Create;

  strEmbSal    := AnsiReplaceStr(conf.fGet('EMBSAL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'SALCOMIX', 'EMBSAL', ''), ',', '.');
  strGalSal    := AnsiReplaceStr(conf.fGet('GALSAL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'SALCOMIX', 'GALSAL', ''), ',', '.');

  stlCamIndSal.Add('SAL_DESCRI+SAL_MONTAD');
  stlCamIndSal.Add('SAL_CODPRO');
  stlCamIndSal.Add('SAL_MONTAD');
  stlCamIndSal.Add('SAL_LINHA_');
  stlCamIndSal.Add('SAL_CODSEQ');

  stlDesIndSal.Add('Descricao/Montadora');
  stlDesIndSal.Add('Código');
  stlDesIndSal.Add('Montadora');
  stlDesIndSal.Add('Linha');
  stlDesIndSal.Add('Cód. Seq.');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SAL_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  SAL_CODPRO AS "Código", ';
  strSQL := strSQL + '  SAL_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  SAL_VARIAC AS "Variação", ';
  strSQL := strSQL + '  SAL_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  SAL_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  SAL_CODSEQ AS "Cód. Seq.", ';
  strSQL := strSQL + '  IF(SAL_PREVEN > 0, ROUND(SAL_PREVEN * 0.900, 2) + ' + strEmbSal + ', 0) AS SAL_VENLT, ';
  strSQL := strSQL + '  IF(SAL_PRECUS > 0, ROUND(SAL_PRECUS * 0.900, 2) + ' + strEmbSal + ', 0) AS SAL_CUSLT, ';
  strSQL := strSQL + '  IF(SAL_PREVEN > 0, ROUND(SAL_PREVEN * 3.600, 2) + ' + strGalSal + ', 0) AS SAL_VENGL, ';
  strSQL := strSQL + '  IF(SAL_PRECUS > 0, ROUND(SAL_PRECUS * 3.600, 2) + ' + strGalSal + ', 0) AS SAL_CUSGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SAL_CADSAL ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  SAL_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadSal, frmConsultaCadSal);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadSal, qryConsulta01, 'SAL_CADSAL',
        strSQL, stlCamIndSal, stlDesIndSal, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadSal);

  FreeAndNil(stlCamIndSal);
  FreeAndNil(stlDesIndSal);
  FreeAndNil(qryConsulta01);

end;

function fConsultaSalcomixGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndSal: TStringList;
    stlDesIndSal: TStringList;
    strEmbSal: String;
    strGalSal: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);
  conf          := fGetConfTinta('SAL');

  stlCamIndSal := TStringList.Create;
  stlDesIndSal := TStringList.Create;

  strEmbSal    := AnsiReplaceStr(conf.fGet('EMBSAL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'SALCOMIX', 'EMBSAL', ''), ',', '.');
  strGalSal    := AnsiReplaceStr(conf.fGet('GALSAL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'SALCOMIX', 'GALSAL', ''), ',', '.');

  stlCamIndSal.Add('SAL_DESCRI+SAL_MONTAD');
  stlCamIndSal.Add('SAL_CODPRO');
  stlCamIndSal.Add('SAL_MONTAD');
  stlCamIndSal.Add('SAL_LINHA_');
  stlCamIndSal.Add('SAL_CODSEQ');

  stlDesIndSal.Add('Descricao/Montadora');
  stlDesIndSal.Add('Código');
  stlDesIndSal.Add('Montadora');
  stlDesIndSal.Add('Linha');
  stlDesIndSal.Add('Cód. Seq.');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SAL_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  SAL_CODPRO AS "Código", ';
  strSQL := strSQL + '  SAL_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  SAL_VARIAC AS "Variação", ';
  strSQL := strSQL + '  SAL_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  SAL_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  SAL_CODSEQ AS "Cód. Seq.", ';
  strSQL := strSQL + '  IF(SAL_PREVEN > 0, ROUND(SAL_PREVEN * 0.900, 2) + ' + strEmbSal + ', 0) AS SAL_VENLT, ';
  strSQL := strSQL + '  IF(SAL_PREVEN > 0, ROUND(SAL_PREVEN * 3.600, 2) + ' + strGalSal + ', 0) AS SAL_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SAL_CADSAL ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  SAL_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadSalGeral, frmConsultaCadSalGeral);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadSalGeral, qryConsulta01, 'SAL_CADSAL',
        strSQL, stlCamIndSal, stlDesIndSal, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadSalGeral);

  FreeAndNil(stlCamIndSal);
  FreeAndNil(stlDesIndSal);
  FreeAndNil(qryConsulta01);
end;

function fConsultaSalcomixVenda(Sender: TForm; strCodEmp: String;
  Var qryCadSal: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndSal: TStringList;
    stlDesIndSal: TStringList;
    strEmbSal: String;
    strGalSal: String;
    conf: IConfTinta;
begin
  conf         := fGetConfTinta('SAL');
  stlCamIndSal := TStringList.Create;
  stlDesIndSal := TStringList.Create;

  strEmbSal    := AnsiReplaceStr(conf.fGet('EMBSAL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'SALCOMIX', 'EMBSAL', ''), ',', '.');
  strGalSal    := AnsiReplaceStr(conf.fGet('GALSAL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'SALCOMIX', 'GALSAL', ''), ',', '.');

  stlCamIndSal.Add('SAL_DESCRI+SAL_MONTAD');
  stlCamIndSal.Add('SAL_CODPRO');
  stlCamIndSal.Add('SAL_MONTAD');
  stlCamIndSal.Add('SAL_LINHA_');
  stlCamIndSal.Add('SAL_CODSEQ');

  stlDesIndSal.Add('Descricao/Montadora');
  stlDesIndSal.Add('Código');
  stlDesIndSal.Add('Montadora');
  stlDesIndSal.Add('Linha');
  stlDesIndSal.Add('Cód. Seq.');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  SAL_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  SAL_CODPRO AS "Código", ';
  strSQL := strSQL + '  SAL_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  SAL_VARIAC AS "Variação", ';
  strSQL := strSQL + '  SAL_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  SAL_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  SAL_CODSEQ AS "Cód. Seq.", ';
  strSQL := strSQL + '  IF(SAL_PREVEN > 0, ROUND(SAL_PREVEN * 0.900, 2) + ' + strEmbSal + ', 0) AS SAL_VENLT, ';
  strSQL := strSQL + '  IF(SAL_PREVEN > 0, ROUND(SAL_PREVEN * 3.600, 2) + ' + strGalSal + ', 0) AS SAL_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  SAL_CADSAL ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  SAL_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadSalVenda, frmConsultaCadSalVenda);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadSalVenda, qryCadSal, 'SAL_CADSAL',
        strSQL, stlCamIndSal, stlDesIndSal, '', False, True, 5, True)) Then
  Begin
    If (Not qryCadSal.IsEmpty) Then
    Result := qryCadSal.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadSalVenda);

  FreeAndNil(stlCamIndSal);
  FreeAndNil(stlDesIndSal);

end;

function fRetornaDescricaoSalcomix(qryTinta: TUniQuery): String;
begin
  Result := qryTinta.FieldByName('SAL_LINHA_').AsString + ' ' +
            qryTinta.FieldByName('SAL_DESCRI').AsString + ' ' +
            qryTinta.FieldByName('SAL_CODPRO').AsString;
end;

function fRetornaUniTraProSalcomix(qryCadSal: TUniQuery; fltPreEmb, fltQuanti: Double;
  strIteTin: String): Double;
Var
  conf: IConfTinta;  
begin
  conf := fGetConfTinta('SAL');
  With qryCadSal Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM SAL_CADSAL WHERE SAL_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  Result := qryCadSal.FieldByName('SAL_PRE' + conf.fGet('TRASAL')).AsFloat; //qryCadSal.FieldByName('SAL_PRE' + fArqIniTinta(0, 'SALCOMIX', 'TRASAL', '0')).AsFloat;
  Result := Result;
//  Result := Result + (fltPreEmb / fltQuanti);
  Result := Result * conf.fGetDouble('FATSAL'); //fStrToFloat(fArqIniTinta(0, 'SALCOMIX', 'FATSAL', ''));

  Result := fFormataFloat(Result, 2);

end;

function fRetornaUniTraEmbSalcomix(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('SAL');
  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('EMBSAL')  //fStrToFloat(fArqIniTinta(0, 'SALCOMIX', 'EMBSAL', ''))
  Else
    fltPreEmb := conf.fGetDouble('GALSAL'); //fStrToFloat(fArqIniTinta(0, 'SALCOMIX', 'GALSAL', ''));

  Result := fltPreEmb * conf.fGetDouble('FATSAL'); //fStrToFloat(fArqIniTinta(0, 'SALCOMIX', 'FATSAL', ''));
end;

function fGTinForSalcomix(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  SAL_CADSAL ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  SAL_CODSEQ = :ITETIN ';

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

      strCamFor := 'SAL_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'SAL_QTDB' + fStrZero(IntToStr(intContador), 2);

      arrFormul[intContador].strFormul := FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := (FieldByName(strCamBas).AsFloat);

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
  strSQL := strSQL + '  SAL_CADBAS ';
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

function fRetornaPrecoSalcomix(Sender: TForm; qryTinta: TUniQuery;
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
    strChaFor: String;
    conf     : IConfTinta;
begin

  Result := False;
  conf      := fGetConfTinta('SAL');
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

  If (fConsultaSalcomixVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('SAL_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('SAL_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('SAL_ANOCOR').AsString;

  strChaFor := qryTinta.FieldByName('SAL_LINHA_').AsString + ' ' +
               qryTinta.FieldByName('SAL_DESCRI').AsString + ' ' +
               qryTinta.FieldByName('SAL_MONTAD').AsString + ' ' +
               qryTinta.FieldByName('SAL_CODPRO').AsString;

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  If (strTipEmb = 'LT') Then
  Begin
    strIteEmb := conf.fGet('SALIEM'); //fArqIniTinta(0, 'SALCOMIX', 'SALIEM', '');
  End
  Else
  Begin
    strIteEmb := conf.fGet('SALIGL'); //fArqIniTinta(0, 'SALCOMIX', 'SALIGL', '');
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPreCus := qryTinta.FieldByName('SAL_PRECUS').AsFloat;
  fltPrcTin := qryTinta.FieldByName('SAL_PRECUS').AsFloat;

  If (blnUsaPreCus) Then
  Begin
    fltPrvTin := qryTinta.FieldByName('SAL_PRECUS').AsFloat;
    fltUnitar := qryTinta.FieldByName('SAL_PRECUS').AsFloat;
  End
  Else
  Begin
    fltPrvTin := qryTinta.FieldByName('SAL_PREVEN').AsFloat;
    fltUnitar := qryTinta.FieldByName('SAL_PREVEN').AsFloat;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROSAL'); //fArqIniTinta(0, 'SALCOMIX', 'PROSAL', '');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := strChaFor + strTipEmb;

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
  conf := fGetConfTinta('SAL');
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
    fltPreEmb := fStrToFloat(conf.fGet('EMBSAL')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'SALCOMIX', 'EMBSAL', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := fStrToFloat(conf.fGet('GALSAL')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'SALCOMIX', 'GALSAL', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;

end;

procedure pRetornaDadosSalcomix(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadSal: TUniQuery;
begin
  qryCadSal := fCriaQuery(Nil);

  With qryCadSal Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM SAL_CADSAL WHERE SAL_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('SAL_CODPRO').AsString;
    dicRetorno['montad'] := FieldByName('SAL_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('SAL_LINHA_').AsString;
    Close;
  End;

  FreeAndNil(qryCadSal);
end;

end.
