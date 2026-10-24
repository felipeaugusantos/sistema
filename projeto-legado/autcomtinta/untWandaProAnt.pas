unit untWandaProAnt;

interface

uses SysUtils, Forms, Uni, Classes,  StrUtils, Dialogs, Math,
  untFuncoesSimples;

  function fConsultaWandaProGeralAnt(Sender: TForm; strCodEmp: String): String; stdcall;
  function fConsultaWandaProVendaAnt(Sender: TForm; strCodEmp: String;
    Var qryCadWan: TUniQuery): String; stdcall;

  function fDigEmbalagemAnt(blnMosCat: Boolean; strLinha: String; Var strTipEmb: String;
    Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double; Var strCatalize: String): Boolean;

  function fRetornaDescricaoWandaProAnt(qryTinta: TUniQuery): String;

  function fRetornaUniTraProWandaProAnt(qryCadWan: TUniQuery; fltPreEmb, fltQuanti: Double;
    strTipPre, strIteTin, strCatalize: String): Double;

  function fRetornaUniTraEmbWandaProAnt(strTipEmb: String): Double;

  function fRetornaPrecoWandaProAnt(Sender: TForm; qryTinta: TUniQuery;
    Var dicRetorno: TDicionario): Boolean;

  function fGTinForWandaProAnt(strIteTin, strTipPre, strLinha, strCatalize: String; fltQtdIte: Double;
    Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
    Var stlItensTraMl: TStringList): Boolean;

  function fRetFatVenAnt(strLinha, strCatalize: String): Double;

  procedure pRetornaDadosWandaPro(strIteTin: String; dicRetorno: TDicionario);

implementation

uses untConsultaCadWanProAnt, untConsultaCadWanProGeralAnt, untConsultaCadWanProVendaAnt,
  untFatDigEmbalagem, StdCtrls, Data.DB, untIConfTinta, untTintaMaquina;


function fConsultaWandaProGeralAnt(Sender: TForm; strCodEmp: String): String; stdcall;
  Var
    strSQL: String;
    stlCamIndWan: TStringList;
    stlDesIndWan: TStringList;
    strEmbWan: String;
    strGalWan: String;

    strLinhaWandaPro: String;
    arrOpcoes: Array Of String;
    intOpcao: Integer;
    qryConsulta01: TUniQuery;
    conf: IConfTinta;
begin
  qryConsulta01 := fCriaQuery(Nil);
  conf  := fGetConfTinta('WCP');
  SetLength(arrOpcoes, 13);

  arrOpcoes[00] := ' 1 Autobase Plus 100:50';
  arrOpcoes[01] := ' 2 Autobase';
  arrOpcoes[02] := ' 3 Autocryl';
  arrOpcoes[03] := ' 4 Wandabase HS';
  arrOpcoes[04] := ' 6 Wandalac';
  arrOpcoes[05] := ' 7 WB Acrilico Universal';
  arrOpcoes[06] := ' 8 Wanda PU HS';
  arrOpcoes[07] := ' 9 Wandacar';
  arrOpcoes[08] := '11 Single Stage Converter';
  arrOpcoes[09] := '13 Autocoat BT100';
  arrOpcoes[10] := '14 Autobase Plus 100:80';
  arrOpcoes[11] := '19 Autobase Plus Baseline 100:50';
  arrOpcoes[12] := '58 Wanda PU MS';

  intOpcao := fGetMenu('Linha', arrOpcoes, 1);
  strLinhaWandaPro := Trim(LeftStr(arrOpcoes[intOpcao-1], 2));

  stlCamIndWan := TStringList.Create;
  stlDesIndWan := TStringList.Create;

  strEmbWan    := AnsiReplaceStr(conf.fGet('EMBWAN'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'COLOR PRO', 'EMBWAN', ''), ',', '.');
  strGalWan    := AnsiReplaceStr(conf.fGet('GALWAN'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'COLOR PRO', 'GALWAN', ''), ',', '.');

  stlCamIndWan.Add('WAN_DESCRI');
  stlCamIndWan.Add('WAN_LINHA_+WAN_CODAKZ');
  stlCamIndWan.Add('WAN_CODAKZ');

  stlDesIndWan.Add('Descricao');
  stlDesIndWan.Add('Linha/Codigo');
  stlDesIndWan.Add('Codigo');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  WAN_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  WAN_CODAKZ AS "Codigo", ';
  strSQL := strSQL + '  WAN_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  WAN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  WAN_ANOINI AS "Ano Inicial", ';
  strSQL := strSQL + '  WAN_ANOFIN AS "Ano Final", ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, WAN_CONVEN + ' + strEmbWan + ', 0) AS WAN_VENLT, ';
  strSQL := strSQL + '  IF(WAN_CONCUS > 0, WAN_CONCUS + ' + strEmbWan + ', 0) AS WAN_CUSLT, ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, (WAN_CONVEN * 4) + ' + strGalWan + ', 0) AS WAN_VENGL, ';
  strSQL := strSQL + '  IF(WAN_CONCUS > 0, (WAN_CONCUS * 4) + ' + strGalWan + ', 0) AS WAN_CUSGL, ';

  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WANPRO_CADWAN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  WAN_LINHA_ = ' + QuotedStr(strLinhaWandaPro) + ' ';

  Application.CreateForm(TfrmConsultaCadWanProGeralAnt, frmConsultaCadWanProGeralAnt);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadWanProGeralAnt, qryConsulta01, 'WANPRO_CADWAN',
        strSQL, stlCamIndWan, stlDesIndWan, '', False, True, 5, True)) Then
  Begin
    If (Not qryConsulta01.IsEmpty) Then
      Result := qryConsulta01.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadWanProGeralAnt);

  FreeAndNil(stlCamIndWan);
  FreeAndNil(stlDesIndWan);
  FreeAndNil(qryConsulta01);
end;

function fConsultaWandaProVendaAnt(Sender: TForm; strCodEmp: String;
  Var qryCadWan: TUniQuery): String; stdcall;
  Var
    strSQL: String;
    stlCamIndWan: TStringList;
    stlDesIndWan: TStringList;
    strEmbWan: String;
    strGalWan: String;

    strLinhaWandaPro: String;
    arrOpcoes: Array Of String;
    intOpcao: Integer;
    conf: IConfTinta;
begin
  SetLength(arrOpcoes, 13);
  conf  := fGetConfTinta('WCP');
  arrOpcoes[00] := ' 1 Autobase Plus 100:50';
  arrOpcoes[01] := ' 2 Autobase';
  arrOpcoes[02] := ' 3 Autocryl';
  arrOpcoes[03] := ' 4 Wandabase HS';
  arrOpcoes[04] := ' 6 Wandalac';
  arrOpcoes[05] := ' 7 WB Acrilico Universal';
  arrOpcoes[06] := ' 8 Wanda PU HS';
  arrOpcoes[07] := ' 9 Wandacar';
  arrOpcoes[08] := '11 Single Stage Converter';
  arrOpcoes[09] := '13 Autocoat BT100';
  arrOpcoes[10] := '14 Autobase Plus 100:80';
  arrOpcoes[11] := '19 Autobase Plus Baseline 100:50';
  arrOpcoes[12] := '58 Wanda PU MS';

  intOpcao := fGetMenu('Linha', arrOpcoes, 1);
  strLinhaWandaPro := Trim(LeftStr(arrOpcoes[intOpcao-1], 2));

  stlCamIndWan := TStringList.Create;
  stlDesIndWan := TStringList.Create;

  strEmbWan    := AnsiReplaceStr(conf.fGet('EMBWAN'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'COLOR PRO', 'EMBWAN', ''), ',', '.');
  strGalWan    := AnsiReplaceStr(conf.fGet('GALWAN'), ',', '.'); //AnsiReplaceStr(fArqIniTinta(0, 'COLOR PRO', 'GALWAN', ''), ',', '.');

  stlCamIndWan.Add('WAN_DESCRI');
  stlCamIndWan.Add('WAN_CODAKZ');

  stlDesIndWan.Add('Descricao');
  stlDesIndWan.Add('Codigo');

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  WAN_LINHA_ AS "Linha", ';
  strSQL := strSQL + '  WAN_CODAKZ AS "Codigo", ';
  strSQL := strSQL + '  WAN_DESCRI AS "Descricao", ';
  strSQL := strSQL + '  WAN_MONTAD AS "Montadora", ';
  strSQL := strSQL + '  WAN_ANOINI AS "Ano Inicial", ';
  strSQL := strSQL + '  WAN_ANOFIN AS "Ano Final", ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, WAN_CONVEN + ' + strEmbWan + ', 0) AS WAN_VENLT, ';
  strSQL := strSQL + '  IF(WAN_CONCUS > 0, WAN_CONCUS + ' + strEmbWan + ', 0) AS WAN_CUSLT, ';
  strSQL := strSQL + '  IF(WAN_CONVEN > 0, (WAN_CONVEN * 4) + ' + strGalWan + ', 0) AS WAN_VENGL, ';
  strSQL := strSQL + '  IF(WAN_CONCUS > 0, (WAN_CONCUS * 4) + ' + strGalWan + ', 0) AS WAN_CUSGL, ';

  strSQL := strSQL + '  AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WANPRO_CADWAN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  WAN_LINHA_ = ' + QuotedStr(strLinhaWandaPro) + ' ';

  Application.CreateForm(TfrmConsultaCadWanProVendaAnt, frmConsultaCadWanProVendaAnt);

  Result := '-1';
  If (pConsultaEspecifica(Sender, frmConsultaCadWanProVendaAnt, qryCadWan, 'WANPRO_CADWAN',
        strSQL, stlCamIndWan, stlDesIndWan, '', False, True, 5, True)) Then
  Begin
    If (Not qryCadWan.IsEmpty) Then
      Result := qryCadWan.FieldByName('AUTOINCREM').AsString;
  End;

  FreeAndNil(frmConsultaCadWanProVendaAnt);

  FreeAndNil(stlCamIndWan);
  FreeAndNil(stlDesIndWan);
end;

function fDigEmbalagemAnt(blnMosCat: Boolean; strLinha: String; Var strTipEmb: String;
  Var intQtdEmb: Integer; Var fltPreEmb, fltEmbala: Double; Var strCatalize: String): Boolean;
Var
  conf: IConfTinta;
begin
  conf  := fGetConfTinta('WCP');
  Try
    Application.CreateForm(TfrmFatDigEmbalagem, frmFatDigEmbalagem);
    frmFatDigEmbalagem.strTipEmb      := strTipEmb;
    frmFatDigEmbalagem.edtQtdEmb.Text := IntToStr(intQtdEmb);
    frmFatDigEmbalagem.cmbCatalize.ItemIndex := IIF(strCatalize = '4:1', 1, 0);
    If (Not blnMosCat) Then
    Begin
      frmFatDigEmbalagem.cmbCatalize.Visible := False;
      frmFatDigEmbalagem.lblCatalize.Visible := False;
      //frmFatDigEmbalagem.Width := frmFatDigEmbalagem.Width - (frmFatDigEmbalagem.cmbCatalize.Width * 2);
    End
    Else
    Begin
      If (strLinha = '8') Then
        frmFatDigEmbalagem.cmbCatalize.AddItem('2:1', Nil);

      frmFatDigEmbalagem.cmbCatalize.AddItem('4:1', Nil);
      frmFatDigEmbalagem.cmbCatalize.ItemIndex := 0;
    End;
    frmFatDigEmbalagem.showModal;
  Finally
    Result := frmFatDigEmbalagem.blnConfirma;
    {*****************************************}
    {* CASO TENHA CANCELADO, SAI, SENAO      *}
    {* ATUALIZA AS VARIAVEIS                 *}
    {**************************************MV*}
    If (Result) Then
    Begin
      strTipEmb   := frmFatDigEmbalagem.strTipEmb;
      intQtdEmb   := StrToInt(frmFatDigEmbalagem.edtQtdEmb.Text);
      strCatalize := frmFatDigEmbalagem.cmbCatalize.Text;
    End;
    FreeAndNil(frmFatDigEmbalagem);
  End;

  If (Not blnMosCat) Then
  Begin
    strCatalize := '';
  End;

  If (Not Result) Then
    Exit;

  {*****************************************}
  {* LITRO                                 *}
  {**************************************MV*}
  If (strTipEmb = 'LT') Then
  Begin
    fltPreEmb := conf.fGetDouble('EMBWAN') * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'EMBWAN', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(0.9, 4);
  End
  {*****************************************}
  {* GALÃO                                 *}
  {**************************************MV*}
  Else
  Begin
    fltPreEmb := conf.fGetDouble('GALWAN') * intQtdEmb; //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'GALWAN', ''), 0) * intQtdEmb;
    fltEmbala := fFormataFloat(3.6, 4);
  End;
end;

function fRetornaDescricaoWandaProAnt(qryTinta: TUniQuery): String;
begin
  Result := qryTinta.FieldByName('WAN_DESCRI').AsString + ' ' +
            qryTinta.FieldByName('WAN_CODAKZ').AsString + ' ' +
            qryTinta.FieldByName('WAN_LINHA_').AsString;
end;

function fRetornaUniTraProWandaProAnt(qryCadWan: TUniQuery; fltPreEmb, fltQuanti: Double;
  strTipPre, strIteTin, strCatalize: String): Double;
  Var
    strCamTra: String;
    fltFatTra: Double;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('WCP');
  With qryCadWan Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM WANPRO_CADWAN WHERE WAN_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
  End;

  If (strTipPre = 'C') Then
  Begin
    strCamTra := 'CON' + conf.fGet('TRAWAN'); //fArqIniTinta(0, 'COLOR PRO', 'TRAWAN', '');
    fltFatTra := conf.fGetDouble('FATWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FATWAN', '0'));
  End
  Else If (Pos(qryCadWan.FieldByName('WAN_LINHA_').AsString, '8_58') > 0) And (strCatalize = '4:1') Then
  Begin
    strCamTra := '4P1' + conf.fGet('TRDWAN'); //fArqIniTinta(0, 'COLOR PRO', 'TRDWAN', '');
    fltFatTra := conf.fGetDouble('FADWAM'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FADWAM', '0'));
  End
  Else
  Begin
    strCamTra := 'DIL' + conf.fGet('TRDWAN'); //fArqIniTinta(0, 'COLOR PRO', 'TRDWAN', '');
    fltFatTra := conf.fGetDouble('FADWAM'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FADWAM', '0'));
  End;

  Result := qryCadWan.FieldByName('WAN_' + strCamTra).AsFloat;
  Result := Result / fRetFatVenAnt(qryCadWan.FieldByName('WAN_LINHA_').AsString, strCatalize);
  Result := Result * fltFatTra;

  Result := fFormataFloat(Result, 2);
end;

function fRetornaUniTraEmbWandaProAnt(strTipEmb: String): Double;
  Var
    fltFatTra: Double;
    fltPreEmb: Double;
    conf: IConfTinta;
begin
  conf  := fGetConfTinta('WCP');
  If (strTipEmb = 'LT') Then
  Begin
    fltPreEmb := conf.fGetDouble('EMBWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'EMBWAN', ''));
//    fltFatTra := fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FATWAN', ''));
  End
  Else
  Begin
    fltPreEmb := conf.fGetDouble('GALWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'GALWAN', ''));
//    fltFatTra := fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FADWAN', ''));
  End;

  fltFatTra := conf.fGetDouble('FATWAN'); //fStrToFloat(fArqIniTinta(0, 'COLOR PRO', 'FATWAN', ''));
//  If (fArqIniTinta(0, 'COLOR PRO', 'TRAWAN', '') = 'CUS') Then
  if (conf.fGet('TRAWAN') = 'CUS') then
  Begin
    fltFatTra := 1 - Frac(fltFatTra);
  End;


  Result := fltPreEmb * fltFatTra;
end;

function fRetornaPrecoWandaProAnt(Sender: TForm; qryTinta: TUniQuery;
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
    strCatalize: String;

    fltFatVen: Double;
    strLinhasDil: String;
    strChaFor: String;
    conf: IConfTinta;
begin

  Result := False;
  conf   := fGetConfTinta('WCP');
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

  If (fConsultaWandaProVendaAnt(Sender, strCodEmp, qryTinta) = '-1') Then
  Begin
    Exit;
  End;

  strIteTin := qryTinta.FieldByName('WAN_CODSEQ').AsString;
  strMontad := qryTinta.FieldByName('WAN_MONTAD').AsString;
  strA_n_o_ := qryTinta.FieldByName('WAN_ANOINI').AsString;

  strChaFor := qryTinta.FieldByName('WAN_DESCRI').AsString + ' ' +
               qryTinta.FieldByName('WAN_CODAKZ').AsString + ' ' +
               qryTinta.FieldByName('WAN_LINHA_').AsString + ' ' +
               qryTinta.FieldByName('WAN_MONTAD').AsString;
{
  strLinhasDil := fArqIniTinta(0, 'COLOR PRO', 'LD1WAN', '')        + '_' +
                  fArqIniTinta(0, 'COLOR PRO', 'LD1ABS_100_50', '') + '_' +
                  fArqIniTinta(0, 'COLOR PRO', 'LD1ABS_100_80', '') + '_' +
                  fArqIniTinta(0, 'COLOR PRO', 'LD1PU_MS', '')      + '_' +
                  fArqIniTinta(0, 'COLOR PRO', 'LD1PU_HS', '')      + '_';
}
  strLinhasDil := conf.fGet('LD1WAN')         + '_' +
                  conf.fGet('LD1ABS_100_50')  + '_' +
                  conf.fGet('LD1ABS_100_80')  + '_' +
                  conf.fGet('LD1PU_MS')       + '_' +
                  conf.fGet('LD1PU_HS')       + '_';

  If (Pos(fStrZero(qryTinta.FieldByName('WAN_LINHA_').AsString, 3), strLinhasDil) > 0) Then
  Begin
    strTipPre := IIF(fGetMenu('Tipo de Tinta', ['DILUIDO', 'CONCENTRADO'], 1) = 1, 'D', 'C');
  End
  Else
  Begin
    strTipPre := 'C';
  End;

  If (strTipPre = 'C') Then
    strConDil := 'CON'
  Else
    strConDil := 'DIL';

  If (Not fDigEmbalagemAnt((strConDil = 'DIL') And (Pos(qryTinta.FieldByName('WAN_LINHA_').AsString, '008_058') > 0),
                         qryTinta.FieldByName('WAN_LINHA_').AsString,
                         strTipEmb,
                         intQtdEmb,
                         fltPreEmb,
                         fltEmbala,
                         strCatalize)) Then
  Begin
    Exit;
  End;

  If (strTipPre = 'C') Then
    strCatalize := '';

  If (Pos(qryTinta.FieldByName('WAN_LINHA_').AsString, '8_58') > 0) And (strCatalize = '4:1') Then
    strConDil := '4P1';

  fltFatVen := fRetFatVenAnt(qryTinta.FieldByName('WAN_LINHA_').AsString, strCatalize);

  If (strTipEmb = 'LT') Then
  Begin
    strIteEmb := conf.fGet('WANIEM'); //fArqIniTinta(0, 'COLOR PRO', 'WANIEM', '');
  End
  Else
  Begin
    strIteEmb := conf.fGet('WANIGL'); //fArqIniTinta(0, 'COLOR PRO', 'WANIGL', '');
  End;

  dicRetorno['unidad'] := fRetUnidadeItem(strIteEmb);

  fltPreCus := qryTinta.FieldByName('WAN_' + strConDil + 'CUS').AsFloat / fltFatVen;
  fltPrcTin := qryTinta.FieldByName('WAN_' + strConDil + 'CUS').AsFloat / fltFatVen;

  If (blnUsaPreCus) Then
  Begin
    fltPrvTin := qryTinta.FieldByName('WAN_' + strConDil + 'CUS').AsFloat / fltFatVen;
    fltUnitar := qryTinta.FieldByName('WAN_' + strConDil + 'CUS').AsFloat / fltFatVen;
  End
  Else
  Begin
    fltPrvTin := qryTinta.FieldByName('WAN_' + strConDil + 'VEN').AsFloat / fltFatVen;
    fltUnitar := qryTinta.FieldByName('WAN_' + strConDil + 'VEN').AsFloat / fltFatVen;
  End;

  dicRetorno['precus'] := fltPreCus;
  dicRetorno['unitar'] := fltUnitar;
  dicRetorno['prctin'] := fltPrcTin;
  dicRetorno['prvtin'] := fltPrvTin;
  dicRetorno['codite'] := conf.fGet('PROWAN'); //fArqIniTinta(0, 'COLOR PRO', 'PROWAN', '');
  dicRetorno['itetin'] := strIteTin;
  dicRetorno['linha_'] := qryTinta.FieldByName('WAN_LINHA_').AsString;
  dicRetorno['catali'] := strCatalize;

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

function fGTinForWandaProAnt(strIteTin, strTipPre, strLinha, strCatalize: String; fltQtdIte: Double;
  Var arrFormul: TForMulTinDetArray; Var arrBaixaPigmentos: TBaixaPigmentosArray;
  Var stlItensTraMl: TStringList): Boolean;
  Var
    strSQL: String;
    strLinFor: String;
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
  strSQL := strSQL + '  WANPRO_CADWAN ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  WAN_CODSEQ = :ITETIN ';

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

      If (strTipPre = 'C') Then
      Begin
        strLinFor := 'WAN_LINC' + fStrZero(IntToStr(intContador), 2);
        strCamFor := 'WAN_CODC' + fStrZero(IntToStr(intContador), 2);
        strCamBas := 'WAN_QCON' + fStrZero(IntToStr(intContador), 2);
      End
      Else If (Pos(strLinha, '8_58') > 0) And (strCatalize = '4:1') Then
      Begin
        strLinFor := 'WAN_LINC' + fStrZero(IntToStr(intContador), 2);
        strCamFor := 'WAN_CODC' + fStrZero(IntToStr(intContador), 2);
        strCamBas := 'WAN_QD41' + fStrZero(IntToStr(intContador), 2);
      End
      Else
      Begin
        strLinFor := 'WAN_LINC' + fStrZero(IntToStr(intContador), 2);
        strCamFor := 'WAN_CODC' + fStrZero(IntToStr(intContador), 2);
        strCamBas := 'WAN_QD21' + fStrZero(IntToStr(intContador), 2);
      End;

      arrFormul[intContador].strFormul := FieldByName(strLinFor).AsString + FieldByName(strCamFor).AsString;
      arrFormul[intContador].fltQtdBas := (FieldByName(strCamBas).AsFloat / fRetFatVenAnt(strLinha, strCatalize)) * fltQtdIte;

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
  strSQL := strSQL + '  BAS_LINHA_, ';
  strSQL := strSQL + '  BAS_CODBAS, ';
  strSQL := strSQL + '  BAS_CODITE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  WANPRO_CADBAS ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CONCAT(BAS_LINHA_, BAS_CODBAS) IN (' + strBases + ') ';

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
      arrBaixaPigmentos[intPos].fltQtdBaixa := dicBases[FieldByName('BAS_LINHA_').AsString + FieldByName('BAS_CODBAS').AsString];
      Inc(intPos);
      Next;
    End;

    Close;
  End;

  FreeAndNil(dicBases);
  FreeAndNil(qryConsulta01);
end;
function fRetFatVenAnt(strLinha, strCatalize: String): Double;
begin
  Result := 0.900;
  If (Pos(strLinha, '8_58') > 0) Then
  Begin
    If (strCatalize = '4:1') Then
      Result := 0.750
    Else If (strCatalize = '2:1') Then
      Result := 0.640
  End;
end;

procedure pRetornaDadosWandaPro(strIteTin: String; dicRetorno: TDicionario);
  Var
    qryCadWan: TUniQuery;
begin
  qryCadWan := fCriaQuery(Nil);

  With qryCadWan Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM WANPRO_CADWAN WHERE WAN_CODSEQ = :ITETIN');
    ParamByName('ITETIN').AsString := strIteTin;
    Open;
    dicRetorno['codtin'] := FieldByName('WAN_CODAKZ').AsString;
    dicRetorno['montad'] := FieldByName('WAN_MONTAD').AsString;
    dicRetorno['martin'] := FieldByName('WAN_LINHA_').AsString;
    Close;
  End;

  FreeAndNil(qryCadWan);
end;

end.
