unit untPpg;

interface

uses SysUtils, Uni, Forms, Classes,  StrUtils, untFuncoesSimples;

  function fConsultaPpg(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaPpgGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaPpgVenda(Sender: TForm; strCodEmp: String;  Var qryCadPpg: TUniQuery): String; stdcall;

  function fDigEmbalagem(Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fRetornaDescricaoPpg(qryTinta: TUniQuery; strDesCor: String): String;

  function fRetornaUniTraProPpg(qryCadPpg: TUniQuery; fltPreEmb,
    fltQuanti: Double; strTipPre, strIteTin: String): Double;

  function fRetornaUniTraEmbPpg(strTipEmb: String): Double;

  function fRetornaPrecoPpg(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGTinForPpg(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean; stdcall;

  procedure pRetornaDadosPPG(strIteTin: String; dicRetorno: TDicionario);

implementation

uses Data.DB,
  untFatDigEmbalagem, untFuncEspecificas,untIConfTinta, untTintaMaquina, untTypesSistema, untConsultas;

function fConsultaPpg(Sender: TForm; strCodEmp: String): String;
  var
    qryConsulta: TUniQuery;
begin
  Try
     Result := fConsultaPpgVenda(Sender, strCodEmp, qryConsulta);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function fConsultaPpgGeral(Sender: TForm; strCodEmp: String): String;
  var
    qryConsulta: TUniQuery;
begin
  try
    Result := fConsultaPpgVenda(Sender, strCodEmp, qryConsulta);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function fConsultaPpgVenda(Sender: TForm; strCodEmp: String; Var qryCadPpg: TUniQuery): String;
Var
    arrSel: TconsultasArray;
    qryConsulta01: TUniQuery;
    key: Char;
begin
  If Not Assigned(qryCadPpg) Then
    qryConsulta01 := fCriaQuery(Nil)
  Else
    qryConsulta01 := qryCadPpg;
  Try
    If fPesqCadastroTintas(Sender, conPPG, qryConsulta01, key,arrSel) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  Finally
    If Not Assigned(qryCadPpg) Then
      FreeAndNil(qryConsulta01);
  End;
end;

function fDigEmbalagem(Var strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;
Var
  conf: IConfTinta;
begin
  conf := fGetConfTinta('PPG');
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
    fltPreEmb := fStrToFloat(conf.fGet('EMBPPG')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'PPG', 'EMBPPG', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := fStrToFloat(conf.fGet('GALPPG')) * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'PPG', 'GALPPG', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;

end;

function fRetornaDescricaoPpg(qryTinta: TUniQuery; strDesCor: String): String;
begin
  Result := qryTinta.FieldByName('PPG_DESCOR').AsString + ' ' +
            qryTinta.FieldByName('PPG_MONTAD').AsString + ' ' +
            qryTinta.FieldByName('PPG_VEICUL').AsString + ' ' +
            qryTinta.FieldByName('PPG_TIPO__').AsString + ' ' +
            qryTinta.FieldByName('PPG_CODCOR').AsString + ' ' +
            strDesCor;
end;

function fRetornaUniTraProPpg(qryCadPpg: TUniQuery; fltPreEmb,
  fltQuanti: Double; strTipPre, strIteTin: String): Double;
  Var
    strTraPpg: String;
    fltTraPpg: Double;
    strSQL: String;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('PPG');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PPG_CADPPG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PPG_CODSEQ = :ITETIN ';

  With qryCadPpg Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strTraPpg := conf.fGet('TRAPPG'); //fArqIniTinta(0, 'PPG', 'TRAPPG', '');
  fltTraPpg := conf.fGetDouble('FATPPG'); //fStrToFloat(fArqIniTinta(0, 'PPG', 'FATPPG', '0'));
  Result    := qryCadPpg.FieldByName('PPG_PRE' + strTraPpg).AsFloat;

  If (strTipPre = 'D') Then
  Begin

     IF (Pos('CUS', strTraPpg) > 0) Then
     Begin
        Result := fFormataFloat((Result / 2.0) + (conf.fGetDouble('PATVCD') / 2.0), 02); //fFormataFloat((Result / 2.0) + (fStrToFloat(fArqIniTinta(0, 'PPG', 'PATVCD', '0')) / 2.0), 02);
     End
     Else
     Begin
        Result := fFormataFloat((Result / 2.0) + (conf.fGetDouble('PATVVD') / 2.0), 02); //fFormataFloat((Result / 2.0) + (fStrToFloat(fArqIniTinta(0, 'PPG', 'PATVVD', '0')) / 2.0), 02);
     End;

  End;

//  Result := fFormataFloat(Result + (fltPreEmb / fltQuanti), 02 );

  Result := fFormataFloat(Result * fltTraPpg, 2);
end;

function fRetornaUniTraEmbPpg(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('PPG');

  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('EMBPPG') //fStrToFloat(fArqIniTinta(0, 'PPG', 'EMBPPG', ''))
  Else
    fltPreEmb := conf.fGetDouble('GALPPG'); //fStrToFloat(fArqIniTinta(0, 'PPG', 'GALPPG', ''));

  Result := fltPreEmb * conf.fGetDouble('FATPPG');  //fStrToFloat(fArqIniTinta(0, 'PPG', 'FATPPG', ''))

end;

function fRetornaPrecoPpg(Sender: TForm; qryTinta: TUniQuery;
  Var dicRetorno: TDicionario): Boolean;
  Var
    {*******************************************}
    {* PARAMETROS                              *}
    {****************************************MV*}
    strCodEmp: String;
    strOpcDoc: String;
    strTipPre: String;
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

    fltPreVcd: Double;
    fltPreVvd: Double;

    strChaFor: String;
    conf: IConfTinta;
begin

  Result := False;

  conf   := fGetConfTinta('PPG');

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

  stlDesEmb.Add('DULON');
  stlDesEmb.Add('DELFLEET');
  stlDesEmb.Add('DELTRON');
  stlDesEmb.Add('OMNI');

  If (fConsultaPpgVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('PPG_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('PPG_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('PPG_A_N_O_').AsString;

  strChaFor := qryTinta.FieldByName('PPG_DESCOR').AsString + ' ' +
               qryTinta.FieldByName('PPG_MONTAD').AsString + ' ' +
               qryTinta.FieldByName('PPG_TIPO__').AsString + ' ' +
               qryTinta.FieldByName('PPG_CODCOR').AsString;

  strTipPre := IIF(fGetMenu('Tipo de Tinta', ['DILUIDO', 'CONCENTRADO'], 1) = 1, 'D', 'C');

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  If (strTipEmb = 'LT') Then
  Begin

    stlProEmb.Add(conf.fGet('PPGLDU')); //stlProEmb.Add(fArqIniTinta(0, 'PPG', 'PPGLDU', ''));
    stlProEmb.Add(conf.fGet('PPGLDF')); //stlProEmb.Add(fArqIniTinta(0, 'PPG', 'PPGLDF', ''));
    stlProEmb.Add(conf.fGet('PPGLDT')); //stlProEmb.Add(fArqIniTinta(0, 'PPG', 'PPGLDT', ''));
    stlProEmb.Add(conf.fGet('PPGLOM')); //stlProEmb.Add(fArqIniTinta(0, 'PPG', 'PPGLOM', ''));

  End
  Else If (strTipEmb = 'GL') Then
  Begin
    stlProEmb.Add(conf.fGet('PPGGDU')); //stlProEmb.Add(fArqIniTinta(0, 'PPG', 'PPGGDU', ''));
    stlProEmb.Add(conf.fGet('PPGGDF')); //stlProEmb.Add(fArqIniTinta(0, 'PPG', 'PPGGDF', ''));
    stlProEmb.Add(conf.fGet('PPGGDT')); //stlProEmb.Add(fArqIniTinta(0, 'PPG', 'PPGGDT', ''));
    stlProEmb.Add(conf.fGet('PPGGOM')); //stlProEmb.Add(fArqIniTinta(0, 'PPG', 'PPGGOM', ''));

  End;

  If (Not fDigTipoEmbalagem(stlDesEmb, stlProEmb, strIteEmb)) Then
  Begin
    Exit;
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPreCus := 0.0;
  fltPrcTin := 0.0;
  fltPrvTin := 0.0;
  fltUnitar := 0.0;

//  If (strTipEmb = 'LT') Then
//    fltPreEmbalagem := fStrToFloat(fArqIniTinta(0, 'PPG', 'EMBPPG', '0'))
//  Else
//    fltPreEmbalagem := fStrToFloat(fArqIniTinta(0, 'PPG', 'GALPPG', '0'));

  If (strTipPre = 'C') Then
  Begin
    fltPreCus := qryTinta.FieldByName('PPG_PRECUS').AsFloat;
    fltPrcTin := qryTinta.FieldByName('PPG_PRECUS').AsFloat;
    If (blnUsaPreCus) Then
    Begin
      fltPrvTin := qryTinta.FieldByName('PPG_PRECUS').AsFloat;
      fltUnitar := qryTinta.FieldByName('PPG_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPrvTin := qryTinta.FieldByName('PPG_PREVEN').AsFloat;
      fltUnitar := qryTinta.FieldByName('PPG_PREVEN').AsFloat;
    End;

  End
  Else If (strTipPre = 'D') Then
  Begin

    fltPreVcd := conf.fGetDouble('PATVCD'); //fStrToFloat(fArqIniTinta(0, 'PPG', 'PATVCD', '0'));
    fltPreVvd := conf.fGetDouble('PATVVD'); //fStrToFloat(fArqIniTinta(0, 'PPG', 'PATVVD', '0'));

    fltPrcTin := (qryTinta.FieldByName('PPG_PRECUS').AsFloat / 2.0) + (fltPreVcd / 2.0);
    fltPreCus := (qryTinta.FieldByName('PPG_PRECUS').AsFloat / 2.0) + (fltPreVcd / 2.0);
    If (blnUsaPreCus) Then
    Begin
      fltPrvTin := (qryTinta.FieldByName('PPG_PRECUS').AsFloat / 2.0) + (fltPreVcd / 2.0);
      fltUnitar := (qryTinta.FieldByName('PPG_PRECUS').AsFloat / 2.0) + (fltPreVcd / 2.0);
    End
    Else
    Begin
      fltPrvTin := (qryTinta.FieldByName('PPG_PREVEN').AsFloat / 2.0) + (fltPreVvd / 2.0);
      fltUnitar := (qryTinta.FieldByName('PPG_PREVEN').AsFloat / 2.0) + (fltPreVvd / 2.0);
    End;

  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROPPG'); //fArqIniTinta(0, 'PPG', 'PROPPG', '');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['tippre'] := strTipPre;
  dicRetorno['embala'] := fltEmbala;
  dicRetorno['descor'] := IIF(strTipPre = 'D', 'DILUIDO', 'CONCENTRADO');

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := strChaFor + strTipEmb;

  pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));  

  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmb);

  Result := True;
end;

function fGTinForPpg(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
begin

  Result := True;

end;

procedure pRetornaDadosPPG(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadPpg: TUniQuery;
    strSQL: String;
begin
  qryCadPpg := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  PPG_CADPPG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PPG_CODSEQ = :ITETIN ';

  With qryCadPpg Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('PPG_CODCOR').AsString;
    dicRetorno['montad'] := FieldByName('PPG_MONTAD').AsString;
    Close;
  End;

  FreeAndNil(qryCadPpg);
end;

end.
