unit untWandaProAnt;

interface

uses SysUtils, Uni, Dialogs, Forms, ShareMem, Variants;

Type

  TColWanPro = Record
    strLinha_: String;
    strCodCol: String;
    fltQtdCon: Double;
    fltQtdD21: Double;
    fltQtdD41: Double;

  End;

Type
  TColWanProArray = Array[1..20] Of TColWanPro;

  procedure pGerarBasesWandaProAnt(blnZapearBases: Boolean);

  function fGeraWandaColorProAnt(blnGerarBases, blnZapearBases: Boolean): Boolean;

implementation


uses untInkLayoutReader, untFuncoes,  untFuncoesSimples,untIConfTinta, untFuncTinta;

function fGeraWandaColorProAnt(blnGerarBases, blnZapearBases: Boolean): Boolean;
  Var
    ilrArqTxt: TAutomotiveInkLayoutReader;
    strNomArq: String;
    intCodSeq: Integer;
    intContador: Integer;
    intIndex: Integer;

    strCodSeq: String;
    strLinha : String;
    strCodAkz: String;
    strAltern: String;
    strDescri: String;
    strMontad: String;
    strAnoIni: String;
    strAnoFin: String;
    fltConCus: Double;
    fltConVen: Double;
    fltDilCus: Double;
    fltDilVen: Double;
    fltD41Cus: Double;
    fltD41Ven: Double;

    strLinPig: String;
    arrPigmentos: TColWanProArray;
    qryWanPro: TUniQuery;

    strSQL: String;
    conf: IConfTinta;
begin

  Result := False;
  conf   := fGetConfTinta('WCP');
  qryWanPro := fCriaQuery(Nil);
  strNomArq := conf.fGet('PATWAN') + '\FORMULA.TXT'; //fArqIniTinta(0, 'COLOR PRO', 'PATWAN', '') + '\FORMULA.TXT';
  
  If (Not FileExists(strNomArq)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não encontrei o arquivo ' + strNomArq, ['&Ok']);
    Exit;
  End;

  If (blnGerarBases) Then
  Begin
    pGerarBasesWandaProAnt(blnZapearBases);
    Result := True;
    Exit;
  End;

  ilrArqTxt := TAutomotiveInkLayoutReader.Create;

  ilrArqTxt.strNomArq := strNomArq;
  pZapTable('WANPRO_CADWAN');

  intCodSeq := 1;
  strSQL := '';

  qryWanPro.SQL.Add('INSERT DELAYED INTO WANPRO_CADWAN ( ' +
                    '  WAN_CODSEQ, ' +
                    '  WAN_LINHA_, ' +
                    '  WAN_CODAKZ, ' +
                    '  WAN_ALTERN, ' +
                    '  WAN_DESCRI, ' +
                    '  WAN_MONTAD, ' +
                    '  WAN_ANOINI, ' +
                    '  WAN_ANOFIN, ' +
                    '  WAN_CONCUS, ' +
                    '  WAN_CONVEN, ' +
                    '  WAN_DILCUS, ' +
                    '  WAN_DILVEN, ' +
                    '  WAN_4P1CUS, ' +
                    '  WAN_4P1VEN, ' +
                    '              ' +
                    '  WAN_LINC01, ' +
                    '  WAN_CODC01, ' +
                    '  WAN_QCON01, ' +
                    '  WAN_QD2101, ' +
  	                '  WAN_QD4101, ' +

                    '  WAN_LINC02, ' +
                    '  WAN_CODC02, ' +
                    '  WAN_QCON02, ' +
                    '  WAN_QD2102, ' +
  	                '  WAN_QD4102, ' +
                    '             ' +
                    '  WAN_LINC03, ' +
                    '  WAN_CODC03, ' +
                    '  WAN_QCON03, ' +
                    '  WAN_QD2103, ' +
  	                '  WAN_QD4103, ' +
                    '             ' +
                    '  WAN_LINC04, ' +
                    '  WAN_CODC04, ' +
                    '  WAN_QCON04, ' +
                    '  WAN_QD2104, ' +
  	                '  WAN_QD4104, ' +
                    '             ' +
                    '  WAN_LINC05, ' +
                    '  WAN_CODC05, ' +
                    '  WAN_QCON05, ' +
                    '  WAN_QD2105, ' +
  	                '  WAN_QD4105, ' +
                    '             ' +
                    '  WAN_LINC06, ' +
                    '  WAN_CODC06, ' +
                    '  WAN_QCON06, ' +
                    '  WAN_QD2106, ' +
  	                '  WAN_QD4106, ' +
                    '              ' +
                    '  WAN_LINC07, ' +
                    '  WAN_CODC07, ' +
                    '  WAN_QCON07, ' +
                    '  WAN_QD2107, ' +
  	                '  WAN_QD4107, ' +
                    '             ' +
                    '  WAN_LINC08, ' +
                    '  WAN_CODC08, ' +
                    '  WAN_QCON08, ' +
                    '  WAN_QD2108, ' +
  	                '  WAN_QD4108, ' +
                    '             ' +
                    '  WAN_LINC09, ' +
                    '  WAN_CODC09, ' +
                    '  WAN_QCON09, ' +
                    '  WAN_QD2109, ' +
  	                '  WAN_QD4109, ' +
                    '              ' +
                    '  WAN_LINC10, ' +
                    '  WAN_CODC10, ' +
                    '  WAN_QCON10, ' +
                    '  WAN_QD2110, ' +
  	                '  WAN_QD4110, ' +
                    '             ' +
                    '  WAN_LINC11, ' +
                    '  WAN_CODC11, ' +
                    '  WAN_QCON11, ' +
                    '  WAN_QD2111, ' +
  	                '  WAN_QD4111, ' +
                    '             ' +
                    '  WAN_LINC12, ' +
                    '  WAN_CODC12, ' +
                    '  WAN_QCON12, ' +
                    '  WAN_QD2112, ' +
  	                '  WAN_QD4112, ' +
                    '             ' +
                    '  WAN_LINC13, ' +
                    '  WAN_CODC13, ' +
                    '  WAN_QCON13, ' +
                    '  WAN_QD2113, ' +
  	                '  WAN_QD4113, ' +
                    '             ' +
                    '  WAN_LINC14, ' +
                    '  WAN_CODC14, ' +
                    '  WAN_QCON14, ' +
                    '  WAN_QD2114, ' +
  	                '  WAN_QD4114, ' +
                    '             ' +
                    '  WAN_LINC15, ' +
                    '  WAN_CODC15, ' +
                    '  WAN_QCON15, ' +
                    '  WAN_QD2115, ' +
  	                '  WAN_QD4115, ' +
                    '              ' +
                    '  WAN_LINC16, ' +
                    '  WAN_CODC16, ' +
                    '  WAN_QCON16, ' +
                    '  WAN_QD2116, ' +
  	                '  WAN_QD4116, ' +
                    '            ' +
                    '  WAN_LINC17, ' +
                    '  WAN_CODC17, ' +
                    '  WAN_QCON17, ' +
                    '  WAN_QD2117, ' +
  	                '  WAN_QD4117, ' +
                    '            ' +
                    '  WAN_LINC18, ' +
                    '  WAN_CODC18, ' +
                    '  WAN_QCON18, ' +
                    '  WAN_QD2118, ' +
  	                '  WAN_QD4118, ' +
                    '            ' +
                    '  WAN_LINC19, ' +
                    '  WAN_CODC19, ' +
                    '  WAN_QCON19, ' +
                    '  WAN_QD2119, ' +
  	                '  WAN_QD4119, ' +
                    '              ' +
                    '  WAN_LINC20, ' +
                    '  WAN_CODC20, ' +
                    '  WAN_QCON20, ' +
                    '  WAN_QD2120, ' +
  	                '  WAN_QD4120, ' +
                    '              ' +
                    '  WAN_CODEMP, ' +
                    '  AUTOINCREM ) ' +
                    'VALUES ');

  strSQL := '';
  For intContador := 1 To 1 Do
  Begin
    strSQL := strSQL + '(:CODSEQ' + fStrZero(intContador, 3) + ', ' +
    ' :LINHA_' + fStrZero(intContador, 3) + ', ' +
    ' :CODAKZ' + fStrZero(intContador, 3) + ', ' +
    ' :ALTERN' + fStrZero(intContador, 3) + ', ' +
    ' :DESCRI' + fStrZero(intContador, 3) + ', ' +
    ' :MONTAD' + fStrZero(intContador, 3) + ', ' +
    ' :ANOINI' + fStrZero(intContador, 3) + ', ' +
    ' :ANOFIN' + fStrZero(intContador, 3) + ', ' +
    ' :CONCUS' + fStrZero(intContador, 3) + ', ' +
    ' :CONVEN' + fStrZero(intContador, 3) + ', ' +
    ' :DILCUS' + fStrZero(intContador, 3) + ', ' +
    ' :DILVEN' + fStrZero(intContador, 3) + ', ' +
    ' :D41CUS' + fStrZero(intContador, 3) + ', ' +
    ' :D41VEN' + fStrZero(intContador, 3) + ', ' +

    ' :LINC01' + fStrZero(intContador, 3) + ', ' +
    ' :CODC01' + fStrZero(intContador, 3) + ', ' +
    ' :QCON01' + fStrZero(intContador, 3) + ', ' +
    ' :QD2101' + fStrZero(intContador, 3) + ', ' +
    ' :QD4101' + fStrZero(intContador, 3) + ', ' +

    ' :LINC02' + fStrZero(intContador, 3) + ', ' +
    ' :CODC02' + fStrZero(intContador, 3) + ', ' +
    ' :QCON02' + fStrZero(intContador, 3) + ', ' +
    ' :QD2102' + fStrZero(intContador, 3) + ', ' +
    ' :QD4102' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC03' + fStrZero(intContador, 3) + ', ' +
    ' :CODC03' + fStrZero(intContador, 3) + ', ' +
    ' :QCON03' + fStrZero(intContador, 3) + ', ' +
    ' :QD2103' + fStrZero(intContador, 3) + ', ' +
    ' :QD4103' + fStrZero(intContador, 3) + ', ' +

    ' :LINC04' + fStrZero(intContador, 3) + ', ' +
    ' :CODC04' + fStrZero(intContador, 3) + ', ' +
    ' :QCON04' + fStrZero(intContador, 3) + ', ' +
    ' :QD2104' + fStrZero(intContador, 3) + ', ' +
    ' :QD4104' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC05' + fStrZero(intContador, 3) + ', ' +
    ' :CODC05' + fStrZero(intContador, 3) + ', ' +
    ' :QCON05' + fStrZero(intContador, 3) + ', ' +
    ' :QD2105' + fStrZero(intContador, 3) + ', ' +
    ' :QD4105' + fStrZero(intContador, 3) + ', ' +

    ' :LINC06' + fStrZero(intContador, 3) + ', ' +
    ' :CODC06' + fStrZero(intContador, 3) + ', ' +
    ' :QCON06' + fStrZero(intContador, 3) + ', ' +
    ' :QD2106' + fStrZero(intContador, 3) + ', ' +
    ' :QD4106' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC07' + fStrZero(intContador, 3) + ', ' +
    ' :CODC07' + fStrZero(intContador, 3) + ', ' +
    ' :QCON07' + fStrZero(intContador, 3) + ', ' +
    ' :QD2107' + fStrZero(intContador, 3) + ', ' +
    ' :QD4107' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC08' + fStrZero(intContador, 3) + ', ' +
    ' :CODC08' + fStrZero(intContador, 3) + ', ' +
    ' :QCON08' + fStrZero(intContador, 3) + ', ' +
    ' :QD2108' + fStrZero(intContador, 3) + ', ' +
    ' :QD4108' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC09' + fStrZero(intContador, 3) + ', ' +
    ' :CODC09' + fStrZero(intContador, 3) + ', ' +
    ' :QCON09' + fStrZero(intContador, 3) + ', ' +
    ' :QD2109' + fStrZero(intContador, 3) + ', ' +
    ' :QD4109' + fStrZero(intContador, 3) + ', ' +

    ' :LINC10' + fStrZero(intContador, 3) + ', ' +
    ' :CODC10' + fStrZero(intContador, 3) + ', ' +
    ' :QCON10' + fStrZero(intContador, 3) + ', ' +
    ' :QD2110' + fStrZero(intContador, 3) + ', ' +
    ' :QD4110' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC11' + fStrZero(intContador, 3) + ', ' +
    ' :CODC11' + fStrZero(intContador, 3) + ', ' +
    ' :QCON11' + fStrZero(intContador, 3) + ', ' +
    ' :QD2111' + fStrZero(intContador, 3) + ', ' +
    ' :QD4111' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC12' + fStrZero(intContador, 3) + ', ' +
    ' :CODC12' + fStrZero(intContador, 3) + ', ' +
    ' :QCON12' + fStrZero(intContador, 3) + ', ' +
    ' :QD2112' + fStrZero(intContador, 3) + ', ' +
    ' :QD4112' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC13' + fStrZero(intContador, 3) + ', ' +
    ' :CODC13' + fStrZero(intContador, 3) + ', ' +
    ' :QCON13' + fStrZero(intContador, 3) + ', ' +
    ' :QD2113' + fStrZero(intContador, 3) + ', ' +
    ' :QD4113' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC14' + fStrZero(intContador, 3) + ', ' +
    ' :CODC14' + fStrZero(intContador, 3) + ', ' +
    ' :QCON14' + fStrZero(intContador, 3) + ', ' +
    ' :QD2114' + fStrZero(intContador, 3) + ', ' +
    ' :QD4114' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC15' + fStrZero(intContador, 3) + ', ' +
    ' :CODC15' + fStrZero(intContador, 3) + ', ' +
    ' :QCON15' + fStrZero(intContador, 3) + ', ' +
    ' :QD2115' + fStrZero(intContador, 3) + ', ' +
    ' :QD4115' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC16' + fStrZero(intContador, 3) + ', ' +
    ' :CODC16' + fStrZero(intContador, 3) + ', ' +
    ' :QCON16' + fStrZero(intContador, 3) + ', ' +
    ' :QD2116' + fStrZero(intContador, 3) + ', ' +
    ' :QD4116' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC17' + fStrZero(intContador, 3) + ', ' +
    ' :CODC17' + fStrZero(intContador, 3) + ', ' +
    ' :QCON17' + fStrZero(intContador, 3) + ', ' +
    ' :QD2117' + fStrZero(intContador, 3) + ', ' +
    ' :QD4117' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC18' + fStrZero(intContador, 3) + ', ' +
    ' :CODC18' + fStrZero(intContador, 3) + ', ' +
    ' :QCON18' + fStrZero(intContador, 3) + ', ' +
    ' :QD2118' + fStrZero(intContador, 3) + ', ' +
    ' :QD4118' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC19' + fStrZero(intContador, 3) + ', ' +
    ' :CODC19' + fStrZero(intContador, 3) + ', ' +
    ' :QCON19' + fStrZero(intContador, 3) + ', ' +
    ' :QD2119' + fStrZero(intContador, 3) + ', ' +
    ' :QD4119' + fStrZero(intContador, 3) + ', ' +
             
    ' :LINC20' + fStrZero(intContador, 3) + ', ' +
    ' :CODC20' + fStrZero(intContador, 3) + ', ' +
    ' :QCON20' + fStrZero(intContador, 3) + ', ' +
    ' :QD2120' + fStrZero(intContador, 3) + ', ' +
    ' :QD4120' + fStrZero(intContador, 3) + ', ' +

    ' :CODEMP' + fStrZero(intContador, 3) + ', ' +
    ' :AUTINC' + fStrZero(intContador, 3) + ') ';

    If (intContador < 1) Then
    Begin
      strSQL := strSQL + ', ';
    End;

  End;

  qryWanPro.SQL.Add(strSQL);

  intIndex := 1;

  While (Not ilrArqTxt.Eof) Do
  Begin

    strCodSeq := fStrZero(intCodSeq, 6);
    strLinha  := ilrArqTxt['LINHA_'];
    strCodAkz := ilrArqTxt['CHAVE1'];
    strAltern := ilrArqTxt['SUBCHA'];
    strDescri := ilrArqTxt['DESCRI'];
    strMontad := ilrArqTxt['MONTAD'];
    strAnoIni := ilrArqTxt['ANOINI'];
    strAnoFin := ilrArqTxt['ANOFIN'];
    fltConCus := ilrArqTxt['CONCUS'];
    fltConVen := ilrArqTxt['CONVEN'];
    fltDilCus := ilrArqTxt['DILCUS'];
    fltDilVen := ilrArqTxt['DILVEN'];
    fltD41Cus := ilrArqTxt['4P1CUS'];
    fltD41Ven := ilrArqTxt['4P1VEN'];

    For intContador := 1 To 20 Do
    Begin
      arrPigmentos[intContador].strLinha_ := '';
      arrPigmentos[intContador].strCodCol := '';
      arrPigmentos[intContador].fltQtdCon := 0.0;
      arrPigmentos[intContador].fltQtdD21 := 0.0;
      arrPigmentos[intContador].fltQtdD41 := 0.0;
    End;

    If (fArqIniTinta(0, 'USA_FORMUL', 'WCP', 'S') = 'S') Then
    Begin

      For intContador := 1 To 20 Do
      Begin

        strLinPig := ilrArqTxt['LIN' + fStrZero(intContador, 3)];
        If (fEmptyStr(strLinPig)) Then
          Break;

        arrPigmentos[intContador].strLinha_ := strLinPig;
        arrPigmentos[intContador].strCodCol := ilrArqTxt['COL' + fStrZero(intContador, 3)];
        arrPigmentos[intContador].fltQtdCon := ilrArqTxt['QCON' + fStrZero(intContador, 2)];
        arrPigmentos[intContador].fltQtdD21 := ilrArqTxt['QD21' + fStrZero(intContador, 2)];
        arrPigmentos[intContador].fltQtdD41 := ilrArqTxt['QD41' + fStrZero(intContador, 2)];

      End;

    End;

    qryWanPro.ParamByName('CODSEQ' + fStrZero(intIndex, 3)).AsString := strCodSeq;
    qryWanPro.ParamByName('LINHA_' + fStrZero(intIndex, 3)).AsString := strLinha;
    qryWanPro.ParamByName('CODAKZ' + fStrZero(intIndex, 3)).AsString := strCodAkz;
    qryWanPro.ParamByName('ALTERN' + fStrZero(intIndex, 3)).AsString := strAltern;
    qryWanPro.ParamByName('DESCRI' + fStrZero(intIndex, 3)).AsString := strDescri;
    qryWanPro.ParamByName('MONTAD' + fStrZero(intIndex, 3)).AsString := strMontad;
    qryWanPro.ParamByName('ANOINI' + fStrZero(intIndex, 3)).AsString := strAnoIni;
    qryWanPro.ParamByName('ANOFIN' + fStrZero(intIndex, 3)).AsString := strAnoFin;
    qryWanPro.ParamByName('CONCUS' + fStrZero(intIndex, 3)).AsFloat  := fltConCus;
    qryWanPro.ParamByName('CONVEN' + fStrZero(intIndex, 3)).AsFloat  := fltConVen;
    qryWanPro.ParamByName('DILCUS' + fStrZero(intIndex, 3)).AsFloat  := fltDilCus;
    qryWanPro.ParamByName('DILVEN' + fStrZero(intIndex, 3)).AsFloat  := fltDilVen;
    qryWanPro.ParamByName('D41CUS' + fStrZero(intIndex, 3)).AsFloat  := fltD41Cus;
    qryWanPro.ParamByName('D41VEN' + fStrZero(intIndex, 3)).AsFloat  := fltD41Ven;

    qryWanPro.ParamByName('CODEMP' + fStrZero(intIndex, 3)).AsString := VS_strCodEmp;
    qryWanPro.ParamByName('AUTINC' + fStrZero(intIndex, 3)).AsString := fFormataAutInc(intCodSeq, VS_strCodEmp);

    qryWanPro.ParamByName('LINC01' + fStrZero(intIndex, 3)).AsString := arrPigmentos[01].strLinha_;
    qryWanPro.ParamByName('CODC01' + fStrZero(intIndex, 3)).AsString := arrPigmentos[01].strCodCol;
    qryWanPro.ParamByName('QCON01' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[01].fltQtdCon;
    qryWanPro.ParamByName('QD2101' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[01].fltQtdD21;
    qryWanPro.ParamByName('QD4101' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[01].fltQtdD41;

    qryWanPro.ParamByName('LINC02' + fStrZero(intIndex, 3)).AsString := arrPigmentos[02].strLinha_;
    qryWanPro.ParamByName('CODC02' + fStrZero(intIndex, 3)).AsString := arrPigmentos[02].strCodCol;
    qryWanPro.ParamByName('QCON02' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[02].fltQtdCon;
    qryWanPro.ParamByName('QD2102' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[02].fltQtdD21;
    qryWanPro.ParamByName('QD4102' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[02].fltQtdD41;

    qryWanPro.ParamByName('LINC03' + fStrZero(intIndex, 3)).AsString := arrPigmentos[03].strLinha_;
    qryWanPro.ParamByName('CODC03' + fStrZero(intIndex, 3)).AsString := arrPigmentos[03].strCodCol;
    qryWanPro.ParamByName('QCON03' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[03].fltQtdCon;
    qryWanPro.ParamByName('QD2103' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[03].fltQtdD21;
    qryWanPro.ParamByName('QD4103' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[03].fltQtdD41;

    qryWanPro.ParamByName('LINC04' + fStrZero(intIndex, 3)).AsString := arrPigmentos[04].strLinha_;
    qryWanPro.ParamByName('CODC04' + fStrZero(intIndex, 3)).AsString := arrPigmentos[04].strCodCol;
    qryWanPro.ParamByName('QCON04' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[04].fltQtdCon;
    qryWanPro.ParamByName('QD2104' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[04].fltQtdD21;
    qryWanPro.ParamByName('QD4104' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[04].fltQtdD41;

    qryWanPro.ParamByName('LINC05' + fStrZero(intIndex, 3)).AsString := arrPigmentos[05].strLinha_;
    qryWanPro.ParamByName('CODC05' + fStrZero(intIndex, 3)).AsString := arrPigmentos[05].strCodCol;
    qryWanPro.ParamByName('QCON05' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[05].fltQtdCon;
    qryWanPro.ParamByName('QD2105' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[05].fltQtdD21;
    qryWanPro.ParamByName('QD4105' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[05].fltQtdD41;

    qryWanPro.ParamByName('LINC06' + fStrZero(intIndex, 3)).AsString := arrPigmentos[06].strLinha_;
    qryWanPro.ParamByName('CODC06' + fStrZero(intIndex, 3)).AsString := arrPigmentos[06].strCodCol;
    qryWanPro.ParamByName('QCON06' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[06].fltQtdCon;
    qryWanPro.ParamByName('QD2106' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[06].fltQtdD21;
    qryWanPro.ParamByName('QD4106' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[06].fltQtdD41;

    qryWanPro.ParamByName('LINC07' + fStrZero(intIndex, 3)).AsString := arrPigmentos[07].strLinha_;
    qryWanPro.ParamByName('CODC07' + fStrZero(intIndex, 3)).AsString := arrPigmentos[07].strCodCol;
    qryWanPro.ParamByName('QCON07' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[07].fltQtdCon;
    qryWanPro.ParamByName('QD2107' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[07].fltQtdD21;
    qryWanPro.ParamByName('QD4107' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[07].fltQtdD41;

    qryWanPro.ParamByName('LINC08' + fStrZero(intIndex, 3)).AsString := arrPigmentos[08].strLinha_;
    qryWanPro.ParamByName('CODC08' + fStrZero(intIndex, 3)).AsString := arrPigmentos[08].strCodCol;
    qryWanPro.ParamByName('QCON08' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[08].fltQtdCon;
    qryWanPro.ParamByName('QD2108' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[08].fltQtdD21;
    qryWanPro.ParamByName('QD4108' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[08].fltQtdD41;

    qryWanPro.ParamByName('LINC09' + fStrZero(intIndex, 3)).AsString := arrPigmentos[09].strLinha_;
    qryWanPro.ParamByName('CODC09' + fStrZero(intIndex, 3)).AsString := arrPigmentos[09].strCodCol;
    qryWanPro.ParamByName('QCON09' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[09].fltQtdCon;
    qryWanPro.ParamByName('QD2109' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[09].fltQtdD21;
    qryWanPro.ParamByName('QD4109' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[09].fltQtdD41;

    qryWanPro.ParamByName('LINC10' + fStrZero(intIndex, 3)).AsString := arrPigmentos[10].strLinha_;
    qryWanPro.ParamByName('CODC10' + fStrZero(intIndex, 3)).AsString := arrPigmentos[10].strCodCol;
    qryWanPro.ParamByName('QCON10' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[10].fltQtdCon;
    qryWanPro.ParamByName('QD2110' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[10].fltQtdD21;
    qryWanPro.ParamByName('QD4110' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[10].fltQtdD41;

    qryWanPro.ParamByName('LINC11' + fStrZero(intIndex, 3)).AsString := arrPigmentos[11].strLinha_;
    qryWanPro.ParamByName('CODC11' + fStrZero(intIndex, 3)).AsString := arrPigmentos[11].strCodCol;
    qryWanPro.ParamByName('QCON11' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[11].fltQtdCon;
    qryWanPro.ParamByName('QD2111' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[11].fltQtdD21;
    qryWanPro.ParamByName('QD4111' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[11].fltQtdD41;

    qryWanPro.ParamByName('LINC12' + fStrZero(intIndex, 3)).AsString := arrPigmentos[12].strLinha_;
    qryWanPro.ParamByName('CODC12' + fStrZero(intIndex, 3)).AsString := arrPigmentos[12].strCodCol;
    qryWanPro.ParamByName('QCON12' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[12].fltQtdCon;
    qryWanPro.ParamByName('QD2112' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[12].fltQtdD21;
    qryWanPro.ParamByName('QD4112' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[12].fltQtdD41;

    qryWanPro.ParamByName('LINC13' + fStrZero(intIndex, 3)).AsString := arrPigmentos[13].strLinha_;
    qryWanPro.ParamByName('CODC13' + fStrZero(intIndex, 3)).AsString := arrPigmentos[13].strCodCol;
    qryWanPro.ParamByName('QCON13' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[13].fltQtdCon;
    qryWanPro.ParamByName('QD2113' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[13].fltQtdD21;
    qryWanPro.ParamByName('QD4113' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[13].fltQtdD41;

    qryWanPro.ParamByName('LINC14' + fStrZero(intIndex, 3)).AsString := arrPigmentos[14].strLinha_;
    qryWanPro.ParamByName('CODC14' + fStrZero(intIndex, 3)).AsString := arrPigmentos[14].strCodCol;
    qryWanPro.ParamByName('QCON14' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[14].fltQtdCon;
    qryWanPro.ParamByName('QD2114' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[14].fltQtdD21;
    qryWanPro.ParamByName('QD4114' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[14].fltQtdD41;

    qryWanPro.ParamByName('LINC15' + fStrZero(intIndex, 3)).AsString := arrPigmentos[15].strLinha_;
    qryWanPro.ParamByName('CODC15' + fStrZero(intIndex, 3)).AsString := arrPigmentos[15].strCodCol;
    qryWanPro.ParamByName('QCON15' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[15].fltQtdCon;
    qryWanPro.ParamByName('QD2115' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[15].fltQtdD21;
    qryWanPro.ParamByName('QD4115' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[15].fltQtdD41;

    qryWanPro.ParamByName('LINC16' + fStrZero(intIndex, 3)).AsString := arrPigmentos[16].strLinha_;
    qryWanPro.ParamByName('CODC16' + fStrZero(intIndex, 3)).AsString := arrPigmentos[16].strCodCol;
    qryWanPro.ParamByName('QCON16' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[16].fltQtdCon;
    qryWanPro.ParamByName('QD2116' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[16].fltQtdD21;
    qryWanPro.ParamByName('QD4116' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[16].fltQtdD41;

    qryWanPro.ParamByName('LINC17' + fStrZero(intIndex, 3)).AsString := arrPigmentos[17].strLinha_;
    qryWanPro.ParamByName('CODC17' + fStrZero(intIndex, 3)).AsString := arrPigmentos[17].strCodCol;
    qryWanPro.ParamByName('QCON17' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[17].fltQtdCon;
    qryWanPro.ParamByName('QD2117' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[17].fltQtdD21;
    qryWanPro.ParamByName('QD4117' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[17].fltQtdD41;

    qryWanPro.ParamByName('LINC18' + fStrZero(intIndex, 3)).AsString := arrPigmentos[18].strLinha_;
    qryWanPro.ParamByName('CODC18' + fStrZero(intIndex, 3)).AsString := arrPigmentos[18].strCodCol;
    qryWanPro.ParamByName('QCON18' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[18].fltQtdCon;
    qryWanPro.ParamByName('QD2118' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[18].fltQtdD21;
    qryWanPro.ParamByName('QD4118' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[18].fltQtdD41;

    qryWanPro.ParamByName('LINC19' + fStrZero(intIndex, 3)).AsString := arrPigmentos[19].strLinha_;
    qryWanPro.ParamByName('CODC19' + fStrZero(intIndex, 3)).AsString := arrPigmentos[19].strCodCol;
    qryWanPro.ParamByName('QCON19' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[19].fltQtdCon;
    qryWanPro.ParamByName('QD2119' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[19].fltQtdD21;
    qryWanPro.ParamByName('QD4119' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[19].fltQtdD41;

    qryWanPro.ParamByName('LINC20' + fStrZero(intIndex, 3)).AsString := arrPigmentos[20].strLinha_;
    qryWanPro.ParamByName('CODC20' + fStrZero(intIndex, 3)).AsString := arrPigmentos[20].strCodCol;
    qryWanPro.ParamByName('QCON20' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[20].fltQtdCon;
    qryWanPro.ParamByName('QD2120' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[20].fltQtdD21;
    qryWanPro.ParamByName('QD4120' + fStrZero(intIndex, 3)).AsFloat  := arrPigmentos[20].fltQtdD41;


    If (intIndex Mod 1 = 0) Then
    Begin
      qryWanPro.ExecSQL;
      qryWanPro.Close;
      intIndex := 0;
    End;

    Inc(intIndex);
    Inc(intCodSeq);
    ilrArqTxt.Next;

    Application.ProcessMessages;

  End;

  fGravaAutoIncrem('WANPRO_CADWAN', intCodSeq);
  fGravaCodSeq('WANPRO_CADWAN', intCodSeq);
  Result := True;

end;

procedure pGerarBasesWandaProAnt(blnZapearBases: Boolean);
  Var
    qryCadBas: TUniQuery;
    ilrBases: TAutomotiveBaseInkLayoutReader;
    strNomArq: String;
    intAutInc: Integer;
    blnNovo: Boolean;
    conf: IConfTinta;
begin
  conf      := fGetConfTinta('WCP');
  strNomArq := conf.fGet('PATWAN'); //fArqIniTinta(0, 'COLOR PRO', 'PATWAN', '');
  strNomArq := strNomArq + '\PIGMENTOS.TXT';
  
  If (Not FileExists(strNomArq)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não encontrei o arquivo ' + strNomArq, ['&Ok']);
    Exit;
  End;

  If (blnZapearBases) Then
    pZapTable('WANPRO_CADBAS');

  qryCadBas := fCriaQuery(Nil);

  With qryCadBas Do
  Begin
    SQL.Clear;
    SQL.Add('SELECT * FROM WANPRO_CADBAS');
    Open;
  End;

  intAutInc := 1;

  ilrBases := TAutomotiveBaseInkLayoutReader.Create;
  ilrBases.strNomArq := strNomArq;

  While (Not ilrBases.Eof) Do
  Begin

    blnNovo := False;
    If (qryCadBas.Locate('BAS_LINHA_;BAS_CODBAS',
                         VarArrayOf([ilrBases['LINHA_'], ilrBases['CODCOL']]),
                         [])) Then
    Begin

      If (fFormataFloat(qryCadBas.FieldByName('BAS_PREVEN').AsFloat, 2) = fFormataFloat(ilrBases['PREVEN'], 2)) Then
      Begin
        ilrBases.Next;
        Continue;
      End
      Else If (fFormataFloat(qryCadBas.FieldByName('BAS_EMBALA').AsFloat, 2) <> fFormataFloat(ilrBases['EMBALA']/1000, 2)) Then
      Begin
        ilrBases.Next;
        Continue;
      End;
    End
    Else
    Begin
      blnNovo := True;
    End;

    If (blnNovo) Then
    Begin
      qryCadBas.Append;
      qryCadBas.FieldByName('BAS_EMBALA').AsFloat  := 0.0;      qryCadBas.FieldByName('BAS_CODITE').Value    := Null;

      qryCadBas.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('WANPRO_CADBAS', VS_strCodEmp);
    End
    Else
    Begin
      qryCadBas.Edit;
      qryCadBas.FieldByName('BAS_PREVEN').AsFloat  := ilrBases['PREVEN'];
    End;

    qryCadBas.FieldByName('BAS_LINHA_').AsString := ilrBases['LINHA_'];
    qryCadBas.FieldByName('BAS_CODBAS').AsString := ilrBases['CODCOL'];
    qryCadBas.FieldByName('BAS_DESBAS').AsString := ilrBases['DESCRI'];
    qryCadBas.FieldByName('BAS_PESESP').AsFloat  := ilrBases['PESESP'];
    qryCadBas.FieldByName('BAS_CODEMP').AsString := VS_strCodEmp;

    qryCadBas.Post;

    Inc(intAutInc);
    ilrBases.Next;
  End;

  fGravaAutoIncrem('WANPRO_CADBAS', intAutInc);

end;

end.
