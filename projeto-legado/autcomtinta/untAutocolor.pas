unit untAutocolor;

interface

uses Forms, Uni, Classes, SysUtils, StrUtils, Dialogs, untFuncoesSimples;

  function fConsultaAutocolor(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaAutocolorGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaAutocolorVenda(Sender: TForm; strCodEmp: String;
    Var qryCadAut: TUniQuery): String; stdcall;

  function fDigEmbalagem(Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fRetornaDescricaoAutocolor(qryTinta: TUniQuery): String;

  function fRetornaUniTraProAutocolor(qryCadAut: TUniQuery; fltPreEmb, fltQuanti: Double;
    strIteTin: String): Double;

  function fRetornaUniTraEmbAutocolor(strTipEmb: String): Double;

  function fRetornaPrecoAutocolor(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGTinForAutocolor(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean; stdcall;

  procedure pRetornaDadosAutocolor(strIteTin: String; dicRetorno: TDicionario);

implementation

uses untConsultaCadAut, untConsultaCadAutGeral, untIConfTinta, untTintaMaquina,
  untConsultaCadAutVenda, DB, untFatDigEmbalagem;

function fConsultaAutocolor(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndAut: TStringList;
    stlDesIndAut: TStringList;
    strEmbAut: String;
    strGalAut: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);

  conf := fGetConfTinta('AUT');  

  stlCamIndAut := TStringList.Create;
  stlDesIndAut := TStringList.Create;

  strEmbAut    := AnsiReplaceStr(conf.fGet('AUTPLT'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPLT', ''), ',', '.');
  strGalAut    := AnsiReplaceStr(conf.fGet('AUTPGL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPGL', ''), ',', '.');

  stlCamIndAut.Add('AUT_DESCRI+AUT_MONTAD');
  stlCamIndAut.Add('AUT_CODIGO');
  stlCamIndAut.Add('AUT_MONTAD');

  stlDesIndAut.Add('Descricao/Montadora');
  stlDesIndAut.Add('Código');
  stlDesIndAut.Add('Montadora');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AUT_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  AUT_CODIGO AS "Código", ';
  strSQL := strSQL + '  AUT_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  AUT_REFERE AS "Referencia", ';
  strSQL := strSQL + '  AUT_ANOINI AS "Ano Inicial", ';
  strSQL := strSQL + '  AUT_ANOFIN AS "Ano Final", ';
  strSQL := strSQL + '  IF(AUT_PREVEN > 0, AUT_PREVEN + ' + strEmbAut + ', 0) AS AUT_VENLT, ';
  strSQL := strSQL + '  IF(AUT_PRECUS > 0, AUT_PRECUS + ' + strEmbAut + ', 0) AS AUT_CUSLT, ';
  strSQL := strSQL + '  IF(AUT_PREVEN > 0, (AUT_PREVEN * 4) + ' + strGalAut + ', 0) AS AUT_VENGL, ';
  strSQL := strSQL + '  IF(AUT_PRECUS > 0, (AUT_PRECUS * 4) + ' + strGalAut + ', 0) AS AUT_CUSGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  AUT_CADAUT ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  AUT_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + '  TRUE ';

  Application.CreateForm(TfrmConsultaCadAut, frmConsultaCadAut);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadAut, qryConsulta01, 'AUT_CADAUT',
        strSQL, stlCamIndAut, stlDesIndAut, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadAut);

  FreeAndNil(stlCamIndAut);
  FreeAndNil(stlDesIndAut);
  FreeAndNil(qryConsulta01);

end;

function fConsultaAutocolorGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndAut: TStringList;
    stlDesIndAut: TStringList;
    strEmbAut: String;
    strGalAut: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);

  conf  := fGetConfTinta('AUT');

  stlCamIndAut := TStringList.Create;
  stlDesIndAut := TStringList.Create;

  strEmbAut    := AnsiReplaceStr(conf.fGet('AUTPLT'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPLT', ''), ',', '.');
  strGalAut    := AnsiReplaceStr(conf.fGet('AUTPGL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPGL', ''), ',', '.');

  stlCamIndAut.Add('AUT_DESCRI+AUT_MONTAD');
  stlCamIndAut.Add('AUT_REFERE');
  stlCamIndAut.Add('AUT_CODIGO');
  stlCamIndAut.Add('AUT_MONTAD');

  stlDesIndAut.Add('Descricao/Montadora');
  stlDesIndAut.Add('Referencia');
  stlDesIndAut.Add('Código');
  stlDesIndAut.Add('Montadora');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AUT_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  AUT_CODIGO AS "Código", ';
  strSQL := strSQL + '  AUT_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  AUT_REFERE AS "Referencia", ';
  strSQL := strSQL + '  AUT_ANOINI AS "Ano Inicial", ';
  strSQL := strSQL + '  AUT_ANOFIN AS "Ano Final", ';
  strSQL := strSQL + '  IF(AUT_PREVEN > 0, AUT_PREVEN + ' + strEmbAut + ', 0) AS AUT_VENLT, ';
  strSQL := strSQL + '  IF(AUT_PREVEN > 0, (AUT_PREVEN * 4) + ' + strGalAut + ', 0) AS AUT_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  AUT_CADAUT ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  AUT_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + '  TRUE ';

  Application.CreateForm(TfrmConsultaCadAutGeral, frmConsultaCadAutGeral);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadAutGeral, qryConsulta01, 'AUT_CADAUT',
        strSQL, stlCamIndAut, stlDesIndAut, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadAutGeral);

  FreeAndNil(stlCamIndAut);
  FreeAndNil(stlDesIndAut);
  FreeAndNil(qryConsulta01);
end;

function fConsultaAutocolorVenda(Sender: TForm; strCodEmp: String;
  Var qryCadAut: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndAut: TStringList;
    stlDesIndAut: TStringList;
    strEmbAut: String;
    strGalAut: String;
    conf: IConfTinta;
begin

  stlCamIndAut := TStringList.Create;
  stlDesIndAut := TStringList.Create;

  conf  := fGetConfTinta('AUT');

  strEmbAut    := AnsiReplaceStr(conf.fGet('AUTPLT'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPLT', ''), ',', '.');
  strGalAut    := AnsiReplaceStr(conf.fGet('AUTPGL'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPGL', ''), ',', '.');

  stlCamIndAut.Add('AUT_DESCRI+AUT_MONTAD');
  stlCamIndAut.Add('AUT_REFERE');
  stlCamIndAut.Add('AUT_CODIGO');
  stlCamIndAut.Add('AUT_MONTAD');

  stlDesIndAut.Add('Descricao/Montadora');
  stlDesIndAut.Add('Referencia');
  stlDesIndAut.Add('Código');
  stlDesIndAut.Add('Montadora');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  AUT_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  AUT_CODIGO AS "Código", ';
  strSQL := strSQL + '  AUT_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  AUT_REFERE AS "Referencia", ';
  strSQL := strSQL + '  AUT_ANOINI AS "Ano Inicial", ';
  strSQL := strSQL + '  AUT_ANOFIN AS "Ano Final", ';
  strSQL := strSQL + '  IF(AUT_PREVEN > 0, AUT_PREVEN + ' + strEmbAut + ', 0) AS AUT_VENLT, ';
  strSQL := strSQL + '  IF(AUT_PREVEN > 0, (AUT_PREVEN * 4) + ' + strGalAut + ', 0) AS AUT_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  AUT_CADAUT ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  AUT_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + '  TRUE ';

  Application.CreateForm(TfrmConsultaCadAutVenda, frmConsultaCadAutVenda);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadAutVenda, qryCadAut, 'AUT_CADAUT',
        strSQL, stlCamIndAut, stlDesIndAut, '', False, True, 5, True)) Then
  Begin
    If (Not qryCadAut.IsEmpty) Then
      Result := qryCadAut.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadAutVenda);

  FreeAndNil(stlCamIndAut);
  FreeAndNil(stlDesIndAut);

end;

function fRetornaDescricaoAutocolor(qryTinta: TUniQuery): String;
begin
  Result := qryTinta.FieldByName('AUT_DESCRI').AsString + ' ' +
            qryTinta.FieldByName('AUT_CODIGO').AsString + ' ' +
            qryTinta.FieldByName('AUT_REFERE').AsString;
end;

function fRetornaUniTraProAutocolor(qryCadAut: TUniQuery; fltPreEmb, fltQuanti: Double;
  strIteTin: String): Double;
Var
  conf: IConfTinta;  
begin
  conf  := fGetConfTinta('AUT');

  With qryCadAut Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM AUT_CADAUT WHERE AUT_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  Result := qryCadAut.FieldByName('AUT_PRE' + conf.fGet('TRAAUT')).AsFloat; //qryCadAut.FieldByName('AUT_PRE' + fArqIniTinta(0, 'AUTOCOLOR', 'TRAAUT', '0')).AsFloat;
  Result := Result / 0.900;
//  Result := Result + (fltPreEmb / fltQuanti);
  Result := Result * conf.fGetDouble('FATAUT'); //fStrToFloat(fArqIniTinta(0, 'AUTOCOLOR', 'FATAUT', ''));

  Result := fFormataFloat(Result, 2);

end;

function fRetornaUniTraEmbAutocolor(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('AUT');

  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('AUTPLT') //fStrToFloat(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPLT', ''))
  Else
    fltPreEmb := conf.fGetDouble('AUTPGL'); //fStrToFloat(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPGL', ''));

  Result := fltPreEmb * conf.fGetDouble('FATAUT'); //fStrToFloat(fArqIniTinta(0, 'AUTOCOLOR', 'FATAUT', ''));
end;

function fGTinForAutocolor(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean; stdcall;
begin

  Result := True;

end;

function fRetornaPrecoAutocolor(Sender: TForm; qryTinta: TUniQuery;
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
    conf: IConfTinta;
begin

  Result := False;

  conf := fGetConfTinta('AUT');

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

  If (fConsultaAutocolorVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('AUT_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('AUT_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('AUT_ANOINI').AsString;

  strChaFor := qryTinta.FieldByName('AUT_DESCRI').AsString + ' ' +
               qryTinta.FieldByName('AUT_CODIGO').AsString + ' ' +
               qryTinta.FieldByName('AUT_REFERE').AsString + ' ' +
               qryTinta.FieldByName('AUT_MONTAD').AsString + ' ' +
               qryTinta.FieldByName('AUT_VARIAN').AsString;

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  If (strTipEmb = 'LT') Then
  Begin
    strIteEmb := conf.fGet('AUTIEM') //fArqIniTinta(0, 'AUTOCOLOR', 'AUTIEM', '');
  End
  Else
  Begin
    strIteEmb := conf.fGet('AUTIGL'); //fArqIniTinta(0, 'AUTOCOLOR', 'AUTIGL', '');
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPreCus := qryTinta.FieldByName('AUT_PRECUS').AsFloat / 0.900;
  fltPrcTin := qryTinta.FieldByName('AUT_PRECUS').AsFloat / 0.900;
  
  If (blnUsaPreCus) Then
  Begin
    fltPrvTin := qryTinta.FieldByName('AUT_PRECUS').AsFloat / 0.900;
    fltUnitar := qryTinta.FieldByName('AUT_PRECUS').AsFloat / 0.900;
  End
  Else
  Begin
    fltPrvTin := qryTinta.FieldByName('AUT_PREVEN').AsFloat / 0.900;
    fltUnitar := qryTinta.FieldByName('AUT_PREVEN').AsFloat / 0.900;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROAUT'); //fArqIniTinta(0, 'AUTOCOLOR', 'PROAUT', '');
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
  conf  := fGetConfTinta('AUT');
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
    fltPreEmb := fStrToFloat(conf.fGet('AUTPLT')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPLT', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := fStrToFloat(conf.fGet('AUTPGL')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'AUTOCOLOR', 'AUTPGL', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;

end;

procedure pRetornaDadosAutocolor(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadAut: TUniQuery;
begin
  qryCadAut := fCriaQuery(Nil);

  With qryCadAut Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM AUT_CADAUT WHERE AUT_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('AUT_CODIGO').AsString;
    dicRetorno['montad'] := FieldByName('AUT_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('AUT_REFERE').AsString;
    Close;
  End;

  FreeAndNil(qryCadAut);
end;

end. 
