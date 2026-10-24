unit untZynamix;

interface

uses SysUtils, Uni, Forms, Classes,  StrUtils, untFuncoesSimples;

  function fConsultaZynamix(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaZynamixGeral(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaZynamixVenda(Sender: TForm; strCodEmp: String;
    Var qryCadZyn: TUniQuery): String; stdcall;

  function fDigEmbalagem(Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;

  function fRetornaDescricaoZynamix(qryTinta: TUniQuery): String;

  function fRetornaUniTraProZynamix(qryCadZyn: TUniQuery; fltPreEmb,
    fltQuanti: Double; strTipPre, strIteTin: String): Double;

  function fRetornaUniTraEmbZynamix(strTipEmb: String): Double;

  function fRetornaPrecoZynamix(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGTinForZynamix(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
    Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean; stdcall;

  procedure pRetornaDadosZynamix(strIteTin: String; dicRetorno: TDicionario);

implementation

uses untConsultaCadZyn, untConsultaCadZynGeral, untConsultaCadZynVenda, Data.DB,
  untFatDigEmbalagem, untFuncEspecificas,untIConfTinta, untTintaMaquina;

function fConsultaZynamix(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndZyn: TStringList;
    stlDesIndZyn: TStringList;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  Application.CreateForm(TfrmConsultaCadZyn, frmConsultaCadZyn);

  stlCamIndZyn := TStringList.Create;
  stlDesIndZyn := TStringList.Create;

  stlCamIndZyn.Add('ZYN_DESCOR');
  stlCamIndZyn.Add('ZYN_DESCOR+ZYN_TIPO__');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_CODCOR');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_DESCOR');
  stlCamIndZyn.Add('ZYN_CODCOR');
  stlCamIndZyn.Add('ZYN_CODATC');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_A_N_O_+ZYN_TIPO__');

  stlDesIndZyn.Add('Descrição Cor');
  stlDesIndZyn.Add('Descrição Cor/Tipo');
  stlDesIndZyn.Add('Montadora/Cód. Cor');
  stlDesIndZyn.Add('Montadora/Descrição Cor');
  stlDesIndZyn.Add('Cód. Cor');
  stlDesIndZyn.Add('Cód. AUTCOL');
  stlDesIndZyn.Add('Montadora/Ano/Tipo');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ZYN_DESCOR AS "Descrição Cor", ';
  strSQL := strSQL + '  ZYN_VEICUL AS "Veiculo", ';
  strSQL := strSQL + '  ZYN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  ZYN_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  ZYN_TIPO__ AS "Tipo", ';
  strSQL := strSQL + '  ZYN_CODCOR AS "Cód. Cor", ';
  strSQL := strSQL + '  ZYN_CODATC AS "Cód. AUTCOL", ';
  strSQL := strSQL + '  ZYN_PRECUS, ';
  strSQL := strSQL + '  ZYN_PREVEN, ';
  strSQL := strSQL + '  (ZYN_PRECUS * 3.6) AS ZYN_PRECUS_GL, ';
  strSQL := strSQL + '  (ZYN_PREVEN * 3.6) AS ZYN_PREVEN_GL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ZYN_CADZYN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM <> -1 ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadZyn, qryConsulta01, 'ZYN_CADZYN',
      strSQL, stlCamIndZyn, stlDesIndZyn, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndZyn);
  FreeAndNil(stlDesIndZyn);

  FreeAndNil(frmConsultaCadZyn);
  FreeAndNil(qryConsulta01);

end;

function fConsultaZynamixGeral(Sender: TForm; strCodEmp: String): String;
  Var
    strSQL: String;
    stlCamIndZyn: TStringList;
    stlDesIndZyn: TStringList;
    qryConsulta01: TUniQuery;
begin
  qryConsulta01 := fCriaQuery(Nil);

  Application.CreateForm(TfrmConsultaCadZynGeral, frmConsultaCadZynGeral);

  stlCamIndZyn := TStringList.Create;
  stlDesIndZyn := TStringList.Create;

  stlCamIndZyn.Add('ZYN_DESCOR');
  stlCamIndZyn.Add('ZYN_DESCOR+ZYN_TIPO__');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_CODCOR');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_DESCOR');
  stlCamIndZyn.Add('ZYN_CODCOR');
  stlCamIndZyn.Add('ZYN_CODATC');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_A_N_O_+ZYN_TIPO__');

  stlDesIndZyn.Add('Descrição Cor');
  stlDesIndZyn.Add('Descrição Cor/Tipo');
  stlDesIndZyn.Add('Montadora/Cód. Cor');
  stlDesIndZyn.Add('Montadora/Descrição Cor');
  stlDesIndZyn.Add('Cód. Cor');
  stlDesIndZyn.Add('Cód. AUTCOL');
  stlDesIndZyn.Add('Montadora/Ano/Tipo');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ZYN_DESCOR AS "Descrição Cor", ';
  strSQL := strSQL + '  ZYN_VEICUL AS "Veiculo", ';
  strSQL := strSQL + '  ZYN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  ZYN_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  ZYN_TIPO__ AS "Tipo", ';
  strSQL := strSQL + '  ZYN_CODCOR AS "Cód. Cor", ';
  strSQL := strSQL + '  ZYN_CODATC AS "Cód. AUTCOL", ';
  strSQL := strSQL + '  ZYN_PREVEN, ';
  strSQL := strSQL + '  (ZYN_PREVEN * 3.6) AS ZYN_PREVEN_GL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ZYN_CADZYN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM <> -1 ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadZynGeral, qryConsulta01, 'ZYN_CADZYN',
      strSQL, stlCamIndZyn, stlDesIndZyn, '', False, True, 5, True) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndZyn);
  FreeAndNil(stlDesIndZyn);

  FreeAndNil(frmConsultaCadZynGeral);
  FreeAndNil(qryConsulta01);
end;

function fConsultaZynamixVenda(Sender: TForm; strCodEmp: String;
  Var qryCadZyn: TUniQuery): String;
  Var
    strSQL: String;
    stlCamIndZyn: TStringList;
    stlDesIndZyn: TStringList;
begin

  Application.CreateForm(TfrmConsultaCadZynVenda, frmConsultaCadZynVenda);

  stlCamIndZyn := TStringList.Create;
  stlDesIndZyn := TStringList.Create;

  stlCamIndZyn.Add('ZYN_DESCOR');
  stlCamIndZyn.Add('ZYN_DESCOR+ZYN_TIPO__');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_CODCOR');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_DESCOR');
  stlCamIndZyn.Add('ZYN_CODCOR');
  stlCamIndZyn.Add('ZYN_CODATC');
  stlCamIndZyn.Add('ZYN_MONTAD+ZYN_A_N_O_+ZYN_TIPO__');

  stlDesIndZyn.Add('Descrição Cor');
  stlDesIndZyn.Add('Descrição Cor/Tipo');
  stlDesIndZyn.Add('Montadora/Cód. Cor');
  stlDesIndZyn.Add('Montadora/Descrição Cor');
  stlDesIndZyn.Add('Cód. Cor');
  stlDesIndZyn.Add('Cód. AUTCOL');
  stlDesIndZyn.Add('Montadora/Ano/Tipo');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ZYN_DESCOR AS "Descrição Cor", ';
  strSQL := strSQL + '  ZYN_VEICUL AS "Veiculo", ';
  strSQL := strSQL + '  ZYN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  ZYN_A_N_O_ AS "Ano", ';
  strSQL := strSQL + '  ZYN_TIPO__ AS "Tipo", ';
  strSQL := strSQL + '  ZYN_CODCOR AS "Cód. Cor", ';
  strSQL := strSQL + '  ZYN_CODATC AS "Cód. AUTCOL", ';
  strSQL := strSQL + '  ZYN_PREVEN, ';
  strSQL := strSQL + '  (ZYN_PREVEN * 3.6) AS ZYN_PREVEN_GL, ';
  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ZYN_CADZYN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  AUTOINCREM <> -1 ';

  Result := '-1';
  If pConsultaEspecifica(Sender, frmConsultaCadZynVenda, qryCadZyn, 'ZYN_CADZYN',
      strSQL, stlCamIndZyn, stlDesIndZyn, '', False, True, 5, True) Then
  Begin
    If (Not qryCadZyn.IsEmpty) Then
      Result := qryCadZyn.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(stlCamIndZyn);
  FreeAndNil(stlDesIndZyn);

  FreeAndNil(frmConsultaCadZynVenda);
end;

function fDigEmbalagem(Var strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double): Boolean;
Var
  conf: IConfTinta;
begin
  conf:= fGetConfTinta('ZYN');
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
    fltPreEmb := conf.fGetDouble('EMBZYN') * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'EMBZYN', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := conf.fGetDouble('GALZYN') * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'GALZYN', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;

end;

function fRetornaDescricaoZynamix(qryTinta: TUniQuery): String;
begin
  Result := qryTinta.FieldByName('ZYN_DESCOR').AsString + ' ' +
            qryTinta.FieldByName('ZYN_MONTAD').AsString + ' ' +
            qryTinta.FieldByName('ZYN_TIPO__').AsString + ' ' +
            qryTinta.FieldByName('ZYN_CODCOR').AsString;
end;

function fRetornaUniTraProZynamix(qryCadZyn: TUniQuery; fltPreEmb,
  fltQuanti: Double; strTipPre, strIteTin: String): Double;
  Var
    strTraZyn: String;
    fltTraZyn: Double;
    strSQL: String;
    conf: IConfTinta;
begin
  conf   := fGetConfTinta('ZYN');
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ZYN_CADZYN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ZYN_CODSEQ = :ITETIN ';

  With qryCadZyn Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  strTraZyn := conf.fGet('TRAZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'TRAZYN', '');
  fltTraZyn := conf.fGetDouble('FATZYN'); //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'FATZYN', '0'));
  Result    := qryCadZyn.FieldByName('ZYN_PRE' + strTraZyn).AsFloat;

  If (strTipPre = 'D') Then
  Begin

     IF (Pos('CUS', strTraZyn) > 0) Then
     Begin
        Result := fFormataFloat((Result / 2.0) + (fStrToFloat(conf.fGet('PATVCD')) / 2.0), 02); //fFormataFloat((Result / 2.0) + (fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'PATVCD', '0')) / 2.0), 02);
     End
     Else
     Begin
        Result := fFormataFloat((Result / 2.0) + (fStrToFloat(conf.fGet('PATVVD')) / 2.0), 02); //fFormataFloat((Result / 2.0) + (fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'PATVVD', '0')) / 2.0), 02);
     End;

  End;

//  Result := fFormataFloat(Result + (fltPreEmb / fltQuanti), 02 );

  Result := fFormataFloat(Result * fltTraZyn, 2);
end;

function fRetornaUniTraEmbZynamix(strTipEmb: String): Double;
  Var
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf := fGetConfTinta('ZYN');
  
  If (strTipEmb = 'LT') Then
    fltPreEmb := conf.fGetDouble('EMBZYN') //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'EMBZYN', ''))
  Else
    fltPreEmb := conf.fGetDouble('GALZYN'); //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'GALZYN', ''));

  Result := fltPreEmb * conf.fGetDouble('FATZYN');  //fltPreEmb * fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'FATZYN', ''))

end;

function fRetornaPrecoZynamix(Sender: TForm; qryTinta: TUniQuery;
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
    conf: IConfTinta;
begin

  Result := False;
  conf      := fGetConfTinta('ZYN');
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
  stlDesEmb.Add('ZYNAMIX');

  If (fConsultaZynamixVenda(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('ZYN_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('ZYN_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('ZYN_A_N_O_').AsString;

  strTipPre := IIF(fGetMenu('Tipo de Tinta', ['DILUIDO', 'CONCENTRADO'], 1) = 1, 'D', 'C');

  If (Not fDigEmbalagem(strTipEmb, intQtdEmb, fltPreEmb, fltEmbala)) Then
  Begin
    Exit;
  End;

  If (strTipEmb = 'LT') Then
  Begin

    stlProEmb.Add(conf.fGet('ZYNLDU')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDU', ''));
    stlProEmb.Add(conf.fGet('ZYNLDF')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDF', ''));
    stlProEmb.Add(conf.fGet('ZYNLDT')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNLDT', ''));
    stlProEmb.Add(conf.fGet('ZYNLOM')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNLOM', ''));
    stlProEmb.Add(conf.fGet('ZYNLZY')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNLZY', ''));

  End
  Else If (strTipEmb = 'GL') Then
  Begin

    stlProEmb.Add(conf.fGet('ZYNGDU')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDU', ''));
    stlProEmb.Add(conf.fGet('ZYNGDF')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDF', ''));
    stlProEmb.Add(conf.fGet('ZYNGDT')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNGDT', ''));
    stlProEmb.Add(conf.fGet('ZYNGOM')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNGOM', ''));
    stlProEmb.Add(conf.fGet('ZYNGZY')); //stlProEmb.Add(fArqIniTinta(0, 'ZYNAMIX', 'ZYNGZY', ''));

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
    fltPreCus := qryTinta.FieldByName('ZYN_PRECUS').AsFloat;
    fltPrcTin := qryTinta.FieldByName('ZYN_PRECUS').AsFloat;
    If (blnUsaPreCus) Then
    Begin
      fltPrvTin := qryTinta.FieldByName('ZYN_PRECUS').AsFloat;
      fltUnitar := qryTinta.FieldByName('ZYN_PRECUS').AsFloat;
    End
    Else
    Begin
      fltPrvTin := qryTinta.FieldByName('ZYN_PREVEN').AsFloat;
      fltUnitar := qryTinta.FieldByName('ZYN_PREVEN').AsFloat;
    End;

  End
  Else If (strTipPre = 'D') Then
  Begin

    fltPreVcd := conf.fGetDouble('PATVCD'); //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'PATVCD', '0'));
    fltPreVvd := conf.fGetDouble('PATVVD'); //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'PATVVD', '0'));

    fltPrcTin := (qryTinta.FieldByName('ZYN_PRECUS').AsFloat / 2.0) + (fltPreVcd / 2.0);
    fltPreCus := (qryTinta.FieldByName('ZYN_PRECUS').AsFloat / 2.0) + (fltPreVcd / 2.0);
    If (blnUsaPreCus) Then
    Begin
      fltPrvTin := (qryTinta.FieldByName('ZYN_PRECUS').AsFloat / 2.0) + (fltPreVcd / 2.0);
      fltUnitar := (qryTinta.FieldByName('ZYN_PRECUS').AsFloat / 2.0) + (fltPreVcd / 2.0);
    End
    Else
    Begin
      fltPrvTin := (qryTinta.FieldByName('ZYN_PREVEN').AsFloat / 2.0) + (fltPreVvd / 2.0);
      fltUnitar := (qryTinta.FieldByName('ZYN_PREVEN').AsFloat / 2.0) + (fltPreVvd / 2.0);
    End;

  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROZYN'); //fArqIniTinta(0, 'ZYNAMIX', 'PROZYN', '');
  dicRetorno['itetin'] := strIteTin;

  dicRetorno['iteemb'] := strIteEmb;
  dicRetorno['tipemb'] := strTipEmb;
  dicRetorno['qtdemb'] := intQtdEmb;
  dicRetorno['preemb'] := fltPreEmb;
  dicRetorno['tippre'] := strTipPre;
  dicRetorno['embala'] := fltEmbala;

  dicRetorno['montad'] := strMontad;
  dicRetorno['a_n_o_'] := strA_n_o_;
  dicRetorno['chafor'] := fRetornaDescricaoZynamix(qryTinta) + strTipEmb;

  pFormataValores(dicRetorno, fCfgSis('DECUNI', varInteger));  

  FreeAndNil(stlDesEmb);
  FreeAndNil(stlProEmb);

  Result := True;
end;

function fGTinForZynamix(strIteTin: String; fltQtdIte: Double; Var arrFormul: TForMulTinDetArray;
  Var arrBaixaPigmentos: TBaixaPigmentosArray; Var stlItensTraMl: TStringList): Boolean;
begin
  Result := False;
end;

procedure pRetornaDadosZynamix(strIteTin: String; dicRetorno: TDicionario);
  Var
    strSQL: String;
    qryCadZyn: TUniQuery;
begin
  qryCadZyn := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ZYN_CADZYN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ZYN_CODSEQ = :ITETIN ';

  With qryCadZyn Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('ZYN_CODCOR').AsString;
    dicRetorno['montad'] := FieldByName('ZYN_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('ZYN_TIPO__').AsString;
    Close;
  End;

  FreeAndNil(qryCadZyn);
end;

end.

