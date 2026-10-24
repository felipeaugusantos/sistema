unit untWanda;

interface

uses SysUtils, Forms, Uni, Classes,  StrUtils, untFuncoesSimples;

  function fConsultaWanda(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaWandaGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaWandaVenda(Sender: TForm; strCodEmp: String;
    Var qryCadWan: TUniQuery): String; stdcall;

  function fDigEmbalagem(Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fRetornaDescricaoWanda(qryTinta: TUniQuery): String;

  function fRetornaUniTraProWanda(qryCadWan: TUniQuery; fltPreEmb, fltQuanti: Double;
    strTipPre, strIteTin: String): Double;

  function fRetornaUniTraEmbWanda(strTipEmb: String): Double;

  function fRetornaPrecoWanda(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  procedure pRetornaDadosWanda(strIteTin: String; dicRetorno: TDicionario);

implementation

uses untConsultaCadWan, untConsultaCadWanGeral, untConsultaCadWanVenda, Data.DB,
  untFatDigEmbalagem;

function fConsultaWanda(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndWan: TStringList;
    stlDesIndWan: TStringList;
    strEmbWan: String;
    strGalWan: String;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  stlCamIndWan := TStringList.Create;
  stlDesIndWan := TStringList.Create;

  strEmbWan    := AnsiReplaceStr(fArqIniTinta(0, 'WANDA', 'EMBWAN', ''), ',', '.');
  strGalWan    := AnsiReplaceStr(fArqIniTinta(0, 'WANDA', 'GALWAN', ''), ',', '.');

  stlCamIndWan.Add('WAN_DESCRI');
  stlCamIndWan.Add('WAN_CODIGO');
  stlCamIndWan.Add('WAN_LINHA_+WAN_CODIGO');
  stlCamIndWan.Add('WAN_REFERE');

  stlDesIndWan.Add('Descricao');
  stlDesIndWan.Add('Codigo');
  stlDesIndWan.Add('Linha/Codigo');
  stlDesIndWan.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  WAN_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  WAN_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  WAN_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  WAN_REFERE AS "Referencia", ';
  strSQL := strSQL + '  WAN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  WAN_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, WAN_CONVEN + ' + strEmbWan + ', 0) AS WAN_VENLT, ';
  strSQL := strSQL + '  IF(WAN_CONCUS > 0, WAN_CONCUS + ' + strEmbWan + ', 0) AS WAN_CUSLT, ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, (WAN_CONVEN * 4) + ' + strGalWan + ', 0) AS WAN_VENGL, ';
  strSQL := strSQL + '  IF(WAN_CONCUS > 0, (WAN_CONCUS * 4) + ' + strGalWan + ', 0) AS WAN_CUSGL, ';

  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WAN_CADWAN ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  WAN_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadWan, frmConsultaCadWan);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadWan, qryConsulta01, 'WAN_CADWAN',
        strSQL, stlCamIndWan, stlDesIndWan, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadWan);

  FreeAndNil(stlCamIndWan);
  FreeAndNil(stlDesIndWan);
  FreeAndNil(qryConsulta01);

end;

function fConsultaWandaGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndWan: TStringList;
    stlDesIndWan: TStringList;
    strEmbWan: String;
    strGalWan: String;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  stlCamIndWan := TStringList.Create;
  stlDesIndWan := TStringList.Create;

  strEmbWan    := AnsiReplaceStr(fArqIniTinta(0, 'WANDA', 'EMBWAN', ''), ',', '.');
  strGalWan    := AnsiReplaceStr(fArqIniTinta(0, 'WANDA', 'GALWAN', ''), ',', '.');

  stlCamIndWan.Add('WAN_DESCRI');
  stlCamIndWan.Add('WAN_CODIGO');
  stlCamIndWan.Add('WAN_LINHA_+WAN_CODIGO');
  stlCamIndWan.Add('WAN_REFERE');

  stlDesIndWan.Add('Descricao');
  stlDesIndWan.Add('Codigo');
  stlDesIndWan.Add('Linha/Codigo');
  stlDesIndWan.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  WAN_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  WAN_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  WAN_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  WAN_REFERE AS "Referencia", ';
  strSQL := strSQL + '  WAN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  WAN_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, WAN_CONVEN + ' + strEmbWan + ', 0) AS WAN_VENLT, ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, (WAN_CONVEN * 4) + ' + strGalWan + ', 0) AS WAN_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WAN_CADWAN ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  WAN_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadWanGeral, frmConsultaCadWanGeral);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadWanGeral, qryConsulta01, 'WAN_CADWAN',
        strSQL, stlCamIndWan, stlDesIndWan, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadWanGeral);

  FreeAndNil(stlCamIndWan);
  FreeAndNil(stlDesIndWan);
  FreeAndNil(qryConsulta01);

end;

function fConsultaWandaVenda(Sender: TForm; strCodEmp: String;
  Var qryCadWan: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndWan: TStringList;
    stlDesIndWan: TStringList;
    strEmbWan: String;
    strGalWan: String;
begin

  stlCamIndWan := TStringList.Create;
  stlDesIndWan := TStringList.Create;

  strEmbWan    := AnsiReplaceStr(fArqIniTinta(0, 'WANDA', 'EMBWAN', ''), ',', '.');
  strGalWan    := AnsiReplaceStr(fArqIniTinta(0, 'WANDA', 'GALWAN', ''), ',', '.');

  stlCamIndWan.Add('WAN_DESCRI');
  stlCamIndWan.Add('WAN_CODIGO');
  stlCamIndWan.Add('WAN_LINHA_+WAN_CODIGO');
  stlCamIndWan.Add('WAN_REFERE');

  stlDesIndWan.Add('Descricao');
  stlDesIndWan.Add('Codigo');
  stlDesIndWan.Add('Linha/Codigo');
  stlDesIndWan.Add('Referencia');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  WAN_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  WAN_CODIGO AS "Codigo", ';
  strSQL := strSQL + '  WAN_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  WAN_REFERE AS "Referencia", ';
  strSQL := strSQL + '  WAN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  WAN_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, WAN_CONVEN + ' + strEmbWan + ', 0) AS WAN_VENLT, ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, (WAN_CONVEN * 4) + ' + strGalWan + ', 0) AS WAN_VENGL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WAN_CADWAN ';
  strSQL := strSQL + 'WHERE ';
//  strSQL := strSQL + '  WAN_CODEMP = ' + VS_strCodEmp;
  strSQL := strSQL + ' TRUE ';

  Application.CreateForm(TfrmConsultaCadWanVenda, frmConsultaCadWanVenda);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadWanVenda, qryCadWan, 'WAN_CADWAN',
        strSQL, stlCamIndWan, stlDesIndWan, '', False, True, 5, True)) Then
  Begin
    If (Not qryCadWan.IsEmpty) Then
      Result := qryCadWan.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadWanVenda);

  FreeAndNil(stlCamIndWan);
  FreeAndNil(stlDesIndWan);
end;

function fDigEmbalagem(Var strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;
begin
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
    fltPreEmb := fStrToFloat(fArqIniTinta(0, 'WANDA', 'EMBWAN', '')) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := fStrToFloat(fArqIniTinta(0, 'WANDA', 'GALWAN', '')) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;
end;

function fRetornaDescricaoWanda(qryTinta: TUniQuery): String;
begin

  Result := qryTinta.FieldByName('WAN_LINHA_').AsString + ' ' +
            qryTinta.FieldByName('WAN_DESCRI').AsString + ' ' +
            qryTinta.FieldByName('WAN_CODIGO').AsString;

end;

function fRetornaUniTraProWanda(qryCadWan: TUniQuery; fltPreEmb, fltQuanti: Double;
  strTipPre, strIteTin: String): Double;
  Var
    strCamTra: String;
    fltFatTra: Double;
begin
  With qryCadWan Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM WAN_CADWAN WHERE WAN_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  If (strTipPre = 'C') Then
  Begin
    strCamTra := 'CON' + fArqIniTinta(0, 'WANDA', 'TRAWAN', '');
    fltFatTra := fStrToFloat(fArqIniTinta(0, 'WANDA', 'FATWAN', '0'));
  End
  Else
  Begin
    strCamTra := 'DIL' + fArqIniTinta(0, 'WANDA', 'TRDWAN', '');
    fltFatTra := fStrToFloat(fArqIniTinta(0, 'WANDA', 'FADWAM', '0'));
  End;

  Result := qryCadWan.FieldByName('WAN_' + strCamTra).AsFloat;
  Result := Result / 0.900;
  Result := Result * fltFatTra;

  Result := fFormataFloat(Result, 2);
end;

function fRetornaUniTraEmbWanda(strTipEmb: String): Double;
  Var
    fltFatTra: Double;
    fltPreEmb: Double;
begin
  If (strTipEmb = 'LT') Then
  Begin
    fltPreEmb := fStrToFloat(fArqIniTinta(0, 'WANDA', 'EMBWAN', ''));
    fltFatTra := fStrToFloat(fArqIniTinta(0, 'WANDA', 'FATWAN', ''));
  End
  Else
  Begin
    fltPreEmb := fStrToFloat(fArqIniTinta(0, 'WANDA', 'GALWAN', ''));
    fltFatTra := fStrToFloat(fArqIniTinta(0, 'WANDA', 'FADWAN', ''));
  End;


  Result := fltPreEmb * fltFatTra;
end;

function fRetornaPrecoWanda(Sender: TForm; qryTinta: TUniQuery;
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
    strTipPre: String;

    strIteEmb: String;

    strMontad: String;
    strA_n_o_: String;

    strConDil: String;
    strChaFor: String;

begin

  Result := False;

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

  If (fConsultaWandaVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('WAN_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('WAN_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('WAN_A_N_O_').AsString;

  strChaFor := qryTinta.FieldByName('WAN_LINHA_').AsString + ' ' +
               qryTinta.FieldByName('WAN_DESCRI').AsString + ' ' +
               qryTinta.FieldByName('WAN_REFERE').AsString + ' ' +
               qryTinta.FieldByName('WAN_MONTAD').AsString + ' ' +
               qryTinta.FieldByName('WAN_CODIGO').AsString;

  If (Pos(qryTinta.FieldByName('WAN_LINHA_').AsString, fArqIniTinta(0, 'WANDA', 'LD1WAN', '')) > 0) Then
  Begin
    strTipPre := IIF(fGetMenu('Tipo de Tinta', ['DILUIDO', 'CONCENTRADO'], 1) = 1, 'D', 'C');
  End
  Else
  Begin
    strTipPre := 'C';
  End;

  If (strTipPre = 'C') Then
    strConDil := 'CON'
  eLSE
    strConDil := 'DIL';

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  If (strTipEmb = 'LT') Then
  Begin
    strIteEmb := fArqIniTinta(0, 'WANDA', 'WANIEM', '');
  End
  Else
  Begin
    strIteEmb := fArqIniTinta(0, 'WANDA', 'WANIGL', '');
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPreCus := qryTinta.FieldByName('WAN_' + strConDil + 'CUS').AsFloat / 0.900;
  fltPrcTin := qryTinta.FieldByName('WAN_' + strConDil + 'CUS').AsFloat / 0.900;

  If (blnUsaPreCus) Then
  Begin
    fltPrvTin := qryTinta.FieldByName('WAN_' + strConDil + 'CUS').AsFloat / 0.900;
    fltUnitar := qryTinta.FieldByName('WAN_' + strConDil + 'CUS').AsFloat / 0.900;
  End
  Else
  Begin
    fltPrvTin := qryTinta.FieldByName('WAN_' + strConDil + 'VEN').AsFloat / 0.900;
    fltUnitar := qryTinta.FieldByName('WAN_' + strConDil + 'VEN').AsFloat / 0.900;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := fArqIniTinta(0, 'WANDA', 'PROWAN', '');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['tippre'] := strTipPre;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := strChaFor + strTipEmb;

  Result := True;

end;

procedure pRetornaDadosWanda(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadWan: TUniQuery;
begin
  qryCadWan := fCriaQuery(Nil);

  With qryCadWan Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM WAN_CADWAN WHERE WAN_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('WAN_CODIGO').AsString;
    dicRetorno['montad'] := FieldByName('WAN_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('WAN_LINHA_').AsString;
    Close;
  End;

  FreeAndNil(qryCadWan);
end;

end.
