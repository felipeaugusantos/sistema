unit untGlasurit;

interface

uses Forms, Uni, Classes, SysUtils,  StrUtils, Dialogs, untFuncoesSimples;

  function fConsultaGlasurit(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaGlasuritGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaGlasuritVenda(Sender: TForm; strCodEmp: String;
    Var qryCadGla: TUniQuery): String; stdcall;

  function fDigEmbalagem(Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fRetornaDescricaoGlasurit(qryTinta: TUniQuery): String;

  function fRetornaUniTraProGlasurit(qryCadGla: TUniQuery; fltPreEmb, fltQuanti: Double;
    strIteTin: String): Double;

  function fRetornaUniTraEmbGlasurit(strTipEmb: String): Double;

  function fRetornaPrecoGlasurit(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGTinForGlasurit(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean; stdcall;

  procedure pRetornaDadosGlasurit(strIteTin: String; dicRetorno: TDicionario);

implementation

uses untConsultaCadGla, untConsultaCadGlaGeral,untIConfTinta, untTintaMaquina,
  untConsultaCadGlaVenda, DB, untFatDigEmbalagem;

function fConsultaGlasurit(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndGla: TStringList;
    stlDesIndGla: TStringList;
    strEmbGla: String;
    strGalGla: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);
  conf          := fGetConfTinta('GLA');

  stlCamIndGla := TStringList.Create;
  stlDesIndGla := TStringList.Create;

  strEmbGla    := AnsiReplaceStr(conf.fGet('EMBGLA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'GLASURIT', 'EMBGLA', ''), ',', '.');
  strGalGla    := AnsiReplaceStr(conf.fGet('GALGLA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'GLASURIT', 'GALGLA', ''), ',', '.');

  stlCamIndGla.Add('GLA_DESCRI+GLA_MONTAD');
  stlCamIndGla.Add('GLA_CODPRO');
  stlCamIndGla.Add('GLA_MONTAD');
  stlCamIndGla.Add('GLA_LINHA_');
  stlCamIndGla.Add('GLA_CODSEQ');

  stlDesIndGla.Add('Descricao/Montadora');
  stlDesIndGla.Add('Código');
  stlDesIndGla.Add('Montadora');
  stlDesIndGla.Add('Linha');
  stlDesIndGla.Add('Cód. Seq.');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GLA_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  GLA_CODPRO AS "Código", ';
  strSQL := strSQL + '  GLA_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  GLA_VARIAC AS "Variação", ';
  strSQL := strSQL + '  GLA_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  GLA_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  GLA_CODSEQ AS "Cód. Seq.", ';
  strSQL := strSQL + '  IF(GLA_PREVEN > 0, ROUND(GLA_PREVEN * 0.900, 2) + ' + strEmbGla + ', 0) AS GLA_VENLT, ';
  strSQL := strSQL + '  IF(GLA_PRECUS > 0, ROUND(GLA_PRECUS * 0.900, 2) + ' + strEmbGla + ', 0) AS GLA_CUSLT, ';
  strSQL := strSQL + '  IF(GLA_PREVEN > 0, ROUND(GLA_PREVEN * 3.600, 2) + ' + strGalGla + ', 0) AS GLA_VENGL, ';
  strSQL := strSQL + '  IF(GLA_PRECUS > 0, ROUND(GLA_PRECUS * 3.600, 2) + ' + strGalGla + ', 0) AS GLA_CUSGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GLA_CADGLA ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  GLA_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadGla, frmConsultaCadGla);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadGla, qryConsulta01, 'GLA_CADGLA',
        strSQL, stlCamIndGla, stlDesIndGla, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadGla);

  FreeAndNil(stlCamIndGla);
  FreeAndNil(stlDesIndGla);
  FreeAndNil(qryConsulta01);

end;

function fConsultaGlasuritGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndGla: TStringList;
    stlDesIndGla: TStringList;
    strEmbGla: String;
    strGalGla: String;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);
  conf     := fGetConfTinta('GLA');

  stlCamIndGla := TStringList.Create;
  stlDesIndGla := TStringList.Create;

  strEmbGla    := AnsiReplaceStr(conf.fGet('EMBGLA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'GLASURIT', 'EMBGLA', ''), ',', '.');
  strGalGla    := AnsiReplaceStr(conf.fGet('GALGLA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'GLASURIT', 'GALGLA', ''), ',', '.');

  stlCamIndGla.Add('GLA_DESCRI+GLA_MONTAD');
  stlCamIndGla.Add('GLA_CODPRO');
  stlCamIndGla.Add('GLA_MONTAD');
  stlCamIndGla.Add('GLA_LINHA_');
  stlCamIndGla.Add('GLA_CODSEQ');

  stlDesIndGla.Add('Descricao/Montadora');
  stlDesIndGla.Add('Código');
  stlDesIndGla.Add('Montadora');
  stlDesIndGla.Add('Linha');
  stlDesIndGla.Add('Cód. Seq.');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GLA_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  GLA_CODPRO AS "Código", ';
  strSQL := strSQL + '  GLA_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  GLA_VARIAC AS "Variação", ';
  strSQL := strSQL + '  GLA_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  GLA_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  GLA_CODSEQ AS "Cód. Seq.", ';
  strSQL := strSQL + '  IF(GLA_PREVEN > 0, ROUND(GLA_PREVEN * 0.900, 2) + ' + strEmbGla + ', 0) AS GLA_VENLT, ';
  strSQL := strSQL + '  IF(GLA_PREVEN > 0, ROUND(GLA_PREVEN * 3.600, 2) + ' + strGalGla + ', 0) AS GLA_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GLA_CADGLA ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  GLA_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadGlaGeral, frmConsultaCadGlaGeral);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadGlaGeral, qryConsulta01, 'GLA_CADGLA',
        strSQL, stlCamIndGla, stlDesIndGla, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadGlaGeral);

  FreeAndNil(stlCamIndGla);
  FreeAndNil(stlDesIndGla);
  FreeAndNil(qryConsulta01);
end;

function fConsultaGlasuritVenda(Sender: TForm; strCodEmp: String;
  Var qryCadGla: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndGla: TStringList;
    stlDesIndGla: TStringList;
    strEmbGla: String;
    strGalGla: String;
    conf: IConfTinta;
begin
  conf         := fGetConfTinta('GLA');
  stlCamIndGla := TStringList.Create;
  stlDesIndGla := TStringList.Create;

  strEmbGla    := AnsiReplaceStr(conf.fGet('EMBGLA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'GLASURIT', 'EMBGLA', ''), ',', '.');
  strGalGla    := AnsiReplaceStr(conf.fGet('GALGLA'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'GLASURIT', 'GALGLA', ''), ',', '.');

  stlCamIndGla.Add('GLA_DESCRI+GLA_MONTAD');
  stlCamIndGla.Add('GLA_CODPRO');
  stlCamIndGla.Add('GLA_MONTAD');
  stlCamIndGla.Add('GLA_LINHA_');
  stlCamIndGla.Add('GLA_CODSEQ');

  stlDesIndGla.Add('Descricao/Montadora');
  stlDesIndGla.Add('Código');
  stlDesIndGla.Add('Montadora');
  stlDesIndGla.Add('Linha');
  stlDesIndGla.Add('Cód. Seq.');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GLA_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  GLA_CODPRO AS "Código", ';
  strSQL := strSQL + '  GLA_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  GLA_VARIAC AS "Variação", ';
  strSQL := strSQL + '  GLA_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  GLA_ANOCOR AS "Ano", ';
  strSQL := strSQL + '  GLA_CODSEQ AS "Cód. Seq.", ';
  strSQL := strSQL + '  IF(GLA_PREVEN > 0, ROUND(GLA_PREVEN * 0.900, 2) + ' + strEmbGla + ', 0) AS GLA_VENLT, ';
  strSQL := strSQL + '  IF(GLA_PREVEN > 0, ROUND(GLA_PREVEN * 3.600, 2) + ' + strGalGla + ', 0) AS GLA_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GLA_CADGLA ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  GLA_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadGlaVenda, frmConsultaCadGlaVenda);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadGlaVenda, qryCadGla, 'GLA_CADGLA',
        strSQL, stlCamIndGla, stlDesIndGla, '', False, True, 5, True)) Then
  Begin
    If (Not qryCadGla.IsEmpty) Then
    Result := qryCadGla.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadGlaVenda);

  FreeAndNil(stlCamIndGla);
  FreeAndNil(stlDesIndGla);

end;

function fRetornaDescricaoGlasurit(qryTinta: TUniQuery): String;
begin
  Result := qryTinta.FieldByName('GLA_LINHA_').AsString + ' ' +
            qryTinta.FieldByName('GLA_DESCRI').AsString + ' ' +
            qryTinta.FieldByName('GLA_CODPRO').AsString;
end;

function fRetornaUniTraProGlasurit(qryCadGla: TUniQuery; fltPreEmb, fltQuanti: Double;
  strIteTin: String): Double;
Var
  conf: IConfTinta;
begin
  conf := fGetConfTinta('GLA');
  With qryCadGla Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM GLA_CADGLA WHERE GLA_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  Result := qryCadGla.FieldByName('GLA_PRE' + conf.fGet('TRAGLA')).AsFloat; //qryCadGla.FieldByName('GLA_PRE' + fArqIniTinta(0, 'GLASURIT', 'TRAGLA', '0')).AsFloat;
  Result := Result;
//  Result := Result + (fltPreEmb / fltQuanti);
  Result := Result * conf.fGetDouble('FATGLA'); //fStrToFloat(fArqIniTinta(0, 'GLASURIT', 'FATGLA', ''));

  Result := fFormataFloat(Result, 2);

end;

function fRetornaUniTraEmbGlasurit(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('GLA');
  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('EMBGLA') //fStrToFloat(fArqIniTinta(0, 'GLASURIT', 'EMBGLA', ''))
  Else
    fltPreEmb := conf.fGetDouble('GALGLA'); //fStrToFloat(fArqIniTinta(0, 'GLASURIT', 'GALGLA', ''));

  Result := fltPreEmb * conf.fGetDouble('FATGLA'); //fStrToFloat(fArqIniTinta(0, 'GLASURIT', 'FATGLA', ''));
end;

function fGTinForGlasurit(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
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
  strSQL := strSQL + '  GLA_CADGLA ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  GLA_CODSEQ = :ITETIN ';

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

      strCamFor := 'GLA_FORM' + fStrZero(IntToStr(intContador), 2);
      strCamBas := 'GLA_QTDB' + fStrZero(IntToStr(intContador), 2);

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
  strSQL := strSQL + '  GLA_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + GetInToOr('BAS_CODBAS', strBases);

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

function fRetornaPrecoGlasurit(Sender: TForm; qryTinta: TUniQuery;
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
  conf   := fGetConfTinta('GLA');
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

  If (fConsultaGlasuritVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('GLA_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('GLA_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('GLA_ANOCOR').AsString;

  strChaFor := qryTinta.FieldByName('GLA_LINHA_').AsString + ' ' +
               qryTinta.FieldByName('GLA_DESCRI').AsString + ' ' +
               qryTinta.FieldByName('GLA_MONTAD').AsString + ' ' +
               qryTinta.FieldByName('GLA_CODPRO').AsString;

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  If (strTipEmb = 'LT') Then
  Begin
    strIteEmb := conf.fGet('GLAIEM'); //fArqIniTinta(0, 'GLASURIT', 'GLAIEM', '');
  End
  Else
  Begin
    strIteEmb := conf.fGet('GLAIGL'); //fArqIniTinta(0, 'GLASURIT', 'GLAIGL', '');
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPreCus := qryTinta.FieldByName('GLA_PRECUS').AsFloat;
  fltPrcTin := qryTinta.FieldByName('GLA_PRECUS').AsFloat;
  
  If (blnUsaPreCus) Then
  Begin
    fltPrvTin := qryTinta.FieldByName('GLA_PRECUS').AsFloat;
    fltUnitar := qryTinta.FieldByName('GLA_PRECUS').AsFloat;
  End
  Else
  Begin
    fltPrvTin := qryTinta.FieldByName('GLA_PREVEN').AsFloat;
    fltUnitar := qryTinta.FieldByName('GLA_PREVEN').AsFloat;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROGLA'); //fArqIniTinta(0, 'GLASURIT', 'PROGLA', '');
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
  conf := fGetConfTinta('GLA');
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
    fltPreEmb := fStrToFloat(conf.fGet('EMBGLA')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'GLASURIT', 'EMBGLA', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := fStrToFloat(conf.fGet('GALGLA')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'GLASURIT', 'GALGLA', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;

end;

procedure pRetornaDadosGlasurit(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadGla: TUniQuery;
begin
  qryCadGla := fCriaQuery(Nil);

  With qryCadGla Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM GLA_CADGLA WHERE GLA_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('GLA_CODPRO').AsString;
    dicRetorno['montad'] := FieldByName('GLA_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('GLA_LINHA_').AsString;
    Close;
  End;

  FreeAndNil(qryCadGla);
end;

end.
