unit untGetNetPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, System.Math, Dialogs,  System.Generics.Collections,

     Uni, cxProgressBar,

     untIGetNetIntegracaoLibCartoes, untTGetNetFuncoes, untGetNetTipos;

Type
  TGetNetPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    strRegAnt: String;

    FLinhaArquivo,
    FVersaoArquivo: String;

    intPosicaoAtual: Integer;

    FContadorNegociacao: Integer;

    function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
    function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    function DeveGravarRegistro(ARegistroPgto : TRegistroPgto): Boolean;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);


    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaGetNetPgto;
  End;

Var
  strNomArq: String;

  FRegGetNetPgto    : TArrRegistroGetNetPgto;

Const
  NOMTAB = 'GET_GEPGTO';
  INICAM = 'GET_';
  
implementation

{ TGetNetPgto }

constructor TGetNetPgto.Create;
Begin
  intPosicaoAtual := 0;
  strRegAnt := '';

  FContadorNegociacao := 0;
End;

class function TGetNetPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaGetNetPgto;
Begin
  If strTabela = 'GET_GEPGTO' Then Begin
    SetLength(Result, 51);

    Result[0].strDescri  := 'GET_TIPREG'; Result[0].strTipCmp  := 'VARCHAR(2)'   ;
    Result[1].strDescri  := 'GET_CODEST'; Result[1].strTipCmp  := 'VARCHAR(15)'  ;
    Result[2].strDescri  := 'GET_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
    Result[3].strDescri  := 'GET_DTA_RV'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := 'GET_DTAPAG'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := 'GET_CODBCO'; Result[5].strTipCmp  := 'VARCHAR(9)'   ;
    Result[6].strDescri  := 'GET_CODAGE'; Result[6].strTipCmp  := 'VARCHAR(6)'   ;
    Result[7].strDescri  := 'GET_NUMCCO'; Result[7].strTipCmp  := 'VARCHAR(11)'  ;
    Result[8].strDescri  := 'GET_RV_BRU'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'GET_RV_LIQ'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'GET_VALTAX'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'GET_VALDES'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'GET_VALPAG'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := 'GET_VALENC'; Result[13].strTipCmp := 'DECIMAL(15,2)';
    Result[14].strDescri := 'GET_RVNPAR'; Result[14].strTipCmp := 'VARCHAR(2)'   ;
    Result[15].strDescri := 'GET_RVTPAR'; Result[15].strTipCmp := 'VARCHAR(2)'   ;
    Result[16].strDescri := 'GET_NUMANT'; Result[16].strTipCmp := 'VARCHAR(15)'  ;
    Result[17].strDescri := 'GET_VENORI'; Result[17].strTipCmp := 'DATE'         ;
    Result[18].strDescri := 'GET_LIQANT'; Result[18].strTipCmp := 'DECIMAL(15,2)';
    Result[19].strDescri := 'GET_NUMNSU'; Result[19].strTipCmp := 'VARCHAR(12)'  ;
    Result[20].strDescri := 'GET_DTATRA'; Result[20].strTipCmp := 'DATE'         ;
    Result[21].strDescri := 'GET_NUMCAR'; Result[21].strTipCmp := 'VARCHAR(19)'  ;
    Result[22].strDescri := 'GET_VALVEN'; Result[22].strTipCmp := 'DECIMAL(15,2)';
    Result[23].strDescri := 'GET_TOTPAR'; Result[23].strTipCmp := 'VARCHAR(2)'   ;
    Result[24].strDescri := 'GET_NUMPAR'; Result[24].strTipCmp := 'VARCHAR(2)'   ;
    Result[25].strDescri := 'GET_VALPAR'; Result[25].strTipCmp := 'DECIMAL(15,2)';
    Result[26].strDescri := 'GET_CODAUT'; Result[26].strTipCmp := 'VARCHAR(10)'  ;
    Result[27].strDescri := 'GET_STATUS'; Result[27].strTipCmp := 'VARCHAR(1)'   ;
    Result[28].strDescri := 'GET_NUMTER'; Result[28].strTipCmp := 'VARCHAR(8)'   ;
    Result[29].strDescri := 'GET_MOTAJU'; Result[29].strTipCmp := 'VARCHAR(2)'   ;
    Result[30].strDescri := 'GET_NOMARQ'; Result[30].strTipCmp := 'VARCHAR(255)' ;
    Result[31].strDescri := 'GET_DTAARQ'; Result[31].strTipCmp := 'DATE'         ;
    Result[32].strDescri := 'GET_CONCIL'; Result[32].strTipCmp := 'VARCHAR(1) DEFAULT ''0''';
    Result[33].strDescri := 'GET_TIPPAG'; Result[33].strTipCmp := 'VARCHAR(2)'   ;
    Result[34].strDescri := 'GET_METDAD'; Result[34].strTipCmp := 'VARCHAR(2)'   ;
    Result[35].strDescri := 'GET_CONPAG'; Result[35].strTipCmp := 'VARCHAR(20)'   ;
    Result[36].strDescri := 'GET_ID_REC'; Result[36].strTipCmp := 'VARCHAR(2)';
    Result[37].strDescri := 'GET_CONREC'; Result[37].strTipCmp := 'VARCHAR(118)';
    Result[38].strDescri := 'GET_INFADC'; Result[38].strTipCmp := 'VARCHAR(50)';
    Result[39].strDescri := 'GET_IDEAJU'; Result[39].strTipCmp := 'VARCHAR(20)';

    Result[40].strDescri := 'GET_VERARQ'; Result[40].strTipCmp := 'VARCHAR(10)';
    Result[41].strDescri := 'GET_CHA_UR'; Result[41].strTipCmp := 'VARCHAR(25)';
    Result[42].strDescri := 'GET_CODPRO'; Result[42].strTipCmp := 'VARCHAR(2)' ;
    Result[43].strDescri := 'GET_TIPCAP'; Result[43].strTipCmp := 'VARCHAR(3)' ;
    Result[44].strDescri := 'GET_NUMCON'; Result[44].strTipCmp := 'VARCHAR(18)';
    Result[45].strDescri := 'GET_DTACAN'; Result[45].strTipCmp := 'DATE'       ;
    Result[46].strDescri := 'GET_RV_ORI'; Result[46].strTipCmp := 'VARCHAR(9)' ;
    Result[47].strDescri := 'GET_PAGORI'; Result[47].strTipCmp := 'DATE'       ;
    Result[48].strDescri := 'GET_NUMOPE'; Result[48].strTipCmp := 'VARCHAR(20)';
    Result[49].strDescri := 'GET_CANOPE'; Result[49].strTipCmp := 'VARCHAR(3)' ;
    Result[50].strDescri := 'GET_VALMDR'; Result[50].strTipCmp := 'DECIMAL(15,2)' ;
  End;
End;

class function TGetNetPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaGetNetPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(GET_TIPREG,GET_CODEST,GET_NUM_RV,GET_DTA_RV,GET_DTAPAG,GET_NUMPAR,GET_CODAUT,GET_NUMNSU,GET_IDEAJU,GET_TIPPAG)) ENGINE INNODB ' ;
end;

function TGetNetPgto.DeveGravarRegistro(ARegistroPgto : TRegistroPgto): Boolean;
begin
  Result := False;

  If ARegistroPgto.strTipReg.Trim.IsEmpty Then
    Exit;

  If ARegistroPgto.strCodEst.Trim.IsEmpty Then
    Exit;

  If MatchStr(ARegistroPgto.strDtaPag.Trim, [EmptyStr, '00000000']) Then
    Exit;

  if ARegistroPgto.strTipReg = '6' then
  begin
    if MatchStr(ARegistroPgto.strTipPag, ['GL', 'AL']) then
    begin
      if ARegistroPgto.fltRV_Liq = 0 then
        Exit;
    end;
  end;

  Result := True;
end;

function TGetNetPgto.fGetDados(intIni, intTam: Integer;
  blnFlt: Boolean): Variant;
Var
  rst: Variant;
Begin
  rst := Trim(Copy(FLinhaArquivo, intIni, intTam));
  If blnFlt Then rst := TGetNetFuncoes.fStrToFloat(rst) / 100;

  Result := rst;
End;

procedure TGetNetPgto.pAdicionaLinha(strString: String);
Var
  strOperad: String;
Const
  AUMENTO_CAPACIDADE_FREG  = 200;

begin
  FLinhaArquivo := strString;

  If intPosicaoAtual >= Length(FRegGetNetPgto) - 1 Then
  Begin
    SetLength(FRegGetNetPgto, Length(FRegGetNetPgto)+AUMENTO_CAPACIDADE_FREG);
  End;

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If fGetDados(001,01 ) = '0' Then
  Begin
    dtaArq    := fGetDados(002,08);
    strRegAnt := fGetDados(001,01);

    FVersaoArquivo := Trim(fGetDados(100,03));

    FContadorNegociacao := 0;
  End
  Else If (Pos(fGetDados(001,01), '1_2_3_5_') > 0) Then
  Begin
    If (fGetDados(001,01) = '1') Or (fGetDados(001,01) = '5') Or
       (((fGetDados(001,01) = '2') Or (fGetDados(001,01) = '3')) And (strRegAnt <> '1')) Then
      Inc(intPosicaoAtual);

    If (fGetDados(001,01) = '1') Then
    Begin
      FRegGetNetPgto[intPosicaoAtual-1].strTipReg := fGetDados(169,02);
      FRegGetNetPgto[intPosicaoAtual-1].strNum_RV := fGetDados(022,09);
      FRegGetNetPgto[intPosicaoAtual-1].strDta_RV := fGetDados(031,08);
      FRegGetNetPgto[intPosicaoAtual-1].strCodBco := fGetDados(047,03);
      FRegGetNetPgto[intPosicaoAtual-1].strCodAge := fGetDados(050,06);
      FRegGetNetPgto[intPosicaoAtual-1].strNumCco := fGetDados(056,11);
      FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru := fGetDados(085,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq := fGetDados(097,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValTax := fGetDados(109,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValDes := fGetDados(121,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValPag := fGetDados(145,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValEnc := fGetDados(157,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strRVNPar := fGetDados(171,02);
      FRegGetNetPgto[intPosicaoAtual-1].strRVTPar := fGetDados(173,02);
      FRegGetNetPgto[intPosicaoAtual-1].strNumAnt := fGetDados(190,15);
      FRegGetNetPgto[intPosicaoAtual-1].strVenOri := fGetDados(205,08);
      FRegGetNetPgto[intPosicaoAtual-1].fltLiqAnt := fGetDados(225,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strTipPag := fGetDados(017,02);
      FRegGetNetPgto[intPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;

      If FVersaoArquivo = '10' Then
      Begin
        FRegGetNetPgto[intPosicaoAtual-1].Metadado01 := fGetDados(287,02);
        FRegGetNetPgto[intPosicaoAtual-1].ContaPagamento := fGetDados(289,20);
      End;

      If (fGetDados(169,02) = 'AC') OR (fGetDados(169,02) = 'CS')Then
      Begin
        FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(039,08);
        FRegGetNetPgto[intPosicaoAtual-1].strCodEst := fGetDados(175,15);
        FRegGetNetPgto[intPosicaoAtual-1].strNumNSU := fGetDados(022,09);
        FRegGetNetPgto[intPosicaoAtual-1].strNumAnt := fGetDados(190,15);
        FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := fGetDados(031,08);
        FRegGetNetPgto[intPosicaoAtual-1].strNumCar := '00000000000000';
        FRegGetNetPgto[intPosicaoAtual-1].fltValVen := fGetDados(085,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].strTotPar := fGetDados(173,02);
        FRegGetNetPgto[intPosicaoAtual-1].strNumPar := fGetDados(171,02);
        FRegGetNetPgto[intPosicaoAtual-1].fltValPar := fGetDados(085,12,True);
        fRegGetNetPgto[intPosicaoAtual-1].fltValPag := fGetDados(225,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].fltValDes := fGetDados(213,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].strCodAut := '00000';
        FRegGetNetPgto[intPosicaoAtual-1].strStatus := 'C';
        FRegGetNetPgto[intPosicaoAtual-1].strNumTer := '00000000';
      End;

      FRegGetNetPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
      FRegGetNetPgto[intPosicaoAtual-1].strNomArq := strNomArq;
    End
    Else If (fGetDados(001,01) = '2') Or (fGetDados(001,01) = '3') Then
    Begin
      If (strRegAnt = '2') Or (strRegAnt = '3') Then
      Begin
        FRegGetNetPgto[intPosicaoAtual-1].strTipReg := FRegGetNetPgto[intPosicaoAtual-2].strTipReg;
        FRegGetNetPgto[intPosicaoAtual-1].strNum_RV := FRegGetNetPgto[intPosicaoAtual-2].strNum_RV;
        FRegGetNetPgto[intPosicaoAtual-1].strDta_RV := FRegGetNetPgto[intPosicaoAtual-2].strDta_RV;
        FRegGetNetPgto[intPosicaoAtual-1].strCodBco := FRegGetNetPgto[intPosicaoAtual-2].strCodBco;
        FRegGetNetPgto[intPosicaoAtual-1].strCodAge := FRegGetNetPgto[intPosicaoAtual-2].strCodAge;
        FRegGetNetPgto[intPosicaoAtual-1].strNumCco := FRegGetNetPgto[intPosicaoAtual-2].strNumCco;
        FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru := FRegGetNetPgto[intPosicaoAtual-2].fltRV_Bru;
        FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq := FRegGetNetPgto[intPosicaoAtual-2].fltRV_Liq;
        FRegGetNetPgto[intPosicaoAtual-1].fltValTax := FRegGetNetPgto[intPosicaoAtual-2].fltValTax;
        FRegGetNetPgto[intPosicaoAtual-1].fltValDes := FRegGetNetPgto[intPosicaoAtual-2].fltValDes;
        FRegGetNetPgto[intPosicaoAtual-1].fltValPag := FRegGetNetPgto[intPosicaoAtual-2].fltValPag;
        FRegGetNetPgto[intPosicaoAtual-1].fltValEnc := FRegGetNetPgto[intPosicaoAtual-2].fltValEnc;
        FRegGetNetPgto[intPosicaoAtual-1].strRVNPar := FRegGetNetPgto[intPosicaoAtual-2].strRVNPar;
        FRegGetNetPgto[intPosicaoAtual-1].strRVTPar := FRegGetNetPgto[intPosicaoAtual-2].strRVTPar;
        FRegGetNetPgto[intPosicaoAtual-1].strNumAnt := FRegGetNetPgto[intPosicaoAtual-2].strNumAnt;
        FRegGetNetPgto[intPosicaoAtual-1].strVenOri := FRegGetNetPgto[intPosicaoAtual-2].strVenOri;
        FRegGetNetPgto[intPosicaoAtual-1].fltLiqAnt := FRegGetNetPgto[intPosicaoAtual-2].fltLiqAnt;
        FRegGetNetPgto[intPosicaoAtual-1].strTipPag := FRegGetNetPgto[intPosicaoAtual-2].strTipPag;
        FRegGetNetPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
        FRegGetNetPgto[intPosicaoAtual-1].strNomArq := strNomArq;

        FRegGetNetPgto[intPosicaoAtual-1].Metadado01 := FRegGetNetPgto[intPosicaoAtual-2].Metadado01;
        FRegGetNetPgto[intPosicaoAtual-1].ContaPagamento := FRegGetNetPgto[intPosicaoAtual-2].ContaPagamento;
      End;

      If (fGetDados(001,01) = '2') Then
      Begin
        FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(123,08);
        FRegGetNetPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,15);
        FRegGetNetPgto[intPosicaoAtual-1].strNumNSU := fGetDados(026,12);
        FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := fGetDados(038,08);
        FRegGetNetPgto[intPosicaoAtual-1].strNumCar := fGetDados(052,19);
        FRegGetNetPgto[intPosicaoAtual-1].fltValVen := fGetDados(071,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].strTotPar := fGetDados(107,02);
        FRegGetNetPgto[intPosicaoAtual-1].strNumPar := fGetDados(109,02);
        FRegGetNetPgto[intPosicaoAtual-1].fltValPar := fGetDados(111,12,True);
        FRegGetNetPgto[intPosicaoAtual-1].strCodAut := fGetDados(131,10);
        FRegGetNetPgto[intPosicaoAtual-1].strStatus := fGetDados(144,01);
        FRegGetNetPgto[intPosicaoAtual-1].strNumTer := fGetDados(160,08);

        If FVersaoArquivo = '10' Then
        Begin
          FRegGetNetPgto[intPosicaoAtual-1].IDRecorrencia := fGetDados(188,02);
          FRegGetNetPgto[intPosicaoAtual-1].ConteudoRecorrencia := fGetDados(190,118);
          FRegGetNetPgto[intPosicaoAtual-1].InformacoesAdicionais := fGetDados(310,50);
        End;
      End
      Else If (fGetDados(001,01) = '3') Then
      Begin
        If fGetDados(134,02) <> 'PF' Then
          FRegGetNetPgto[intPosicaoAtual-1].strTipReg := 'AJ'
        Else
          FRegGetNetPgto[intPosicaoAtual-1].strTipReg := 'AF'; //Ajuste futuro

        FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(034,08);

        FRegGetNetPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,15);
        FRegGetNetPgto[intPosicaoAtual-1].strNum_RV := fGetDados(017,09);
        FRegGetNetPgto[intPosicaoAtual-1].strNumNSU := fGetDados(042,20);
        FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := fGetDados(126,08);
        FRegGetNetPgto[intPosicaoAtual-1].strNumCar := fGetDados(086,19);
        strOperad := fGetDados(063,01);
        FRegGetNetPgto[intPosicaoAtual-1].fltValVen := fGetDados(063,13,True);
        FRegGetNetPgto[intPosicaoAtual-1].strTotPar := FRegGetNetPgto[intPosicaoAtual-1].strRVTPar;
        FRegGetNetPgto[intPosicaoAtual-1].strNumPar := FRegGetNetPgto[intPosicaoAtual-1].strRVNPar;
        FRegGetNetPgto[intPosicaoAtual-1].fltValPar := fGetDados(063,13,True);
        FRegGetNetPgto[intPosicaoAtual-1].strCodAut := '0';
        FRegGetNetPgto[intPosicaoAtual-1].strStatus := fGetDados(144,01);
        FRegGetNetPgto[intPosicaoAtual-1].strNumTer := fGetDados(136,08);
        FRegGetNetPgto[intPosicaoAtual-1].strMotAju := fGetDados(076,02);
        FRegGetNetPgto[intPosicaoAtual-1].strTipPag := fGetDados(134,02);
        FRegGetNetPgto[intPosicaoAtual-1].IdentificadorAjuste := Trim(fGetDados(042,20));

        If strOperad = '-' Then
        Begin
          FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru := FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru * (-1);
          FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq := FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq * (-1);
          FRegGetNetPgto[intPosicaoAtual-1].fltValPag := FRegGetNetPgto[intPosicaoAtual-1].fltValPag * (-1);
        End;

        If FRegGetNetPgto[intPosicaoAtual-1].strDtaTra = '00000000' Then
           FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := FRegGetNetPgto[intPosicaoAtual-1].strDtaPag;

      End;
    End
    Else If fGetDados(001,01) = '5' Then
    Begin
      Inc(FContadorNegociacao);

      FRegGetNetPgto[intPosicaoAtual-1].strTipReg := 'NR';

      FRegGetNetPgto[intPosicaoAtual-1].strDtaPag := fGetDados(025,08);

      FRegGetNetPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,15);
      FRegGetNetPgto[intPosicaoAtual-1].strNum_RV := RightStr(fGetDados(033,20), 09);
      FRegGetNetPgto[intPosicaoAtual-1].strNumNSU := fGetDados(033,20);
      FRegGetNetPgto[intPosicaoAtual-1].strDtaTra := fGetDados(017,08);
      FRegGetNetPgto[intPosicaoAtual-1].strDta_RV := fGetDados(017,08);
      FRegGetNetPgto[intPosicaoAtual-1].strNumCar := '***';
      FRegGetNetPgto[intPosicaoAtual-1].fltValVen := fGetDados(055,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strTotPar := '01';
      FRegGetNetPgto[intPosicaoAtual-1].strNumPar := '01';
      FRegGetNetPgto[intPosicaoAtual-1].fltValPar := fGetDados(091,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strCodAut := IntToStr(FContadorNegociacao);
      FRegGetNetPgto[intPosicaoAtual-1].strStatus := fGetDados(148,01);
      FRegGetNetPgto[intPosicaoAtual-1].strMotAju := Trim(fGetDados(053,02));

      FRegGetNetPgto[intPosicaoAtual-1].fltRV_Bru := fGetDados(055,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltRV_Liq := fGetDados(091,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].fltValPag := fGetDados(091,12,True);

      FRegGetNetPgto[intPosicaoAtual-1].strCodBco := fGetDados(116,03);
      FRegGetNetPgto[intPosicaoAtual-1].strCodAge := fGetDados(119,06);
      FRegGetNetPgto[intPosicaoAtual-1].strNumCco := fGetDados(125,20);
      FRegGetNetPgto[intPosicaoAtual-1].fltValTax := fGetDados(079,12,True);
      FRegGetNetPgto[intPosicaoAtual-1].strTipPag := fGetDados(053,02);

      FRegGetNetPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
      FRegGetNetPgto[intPosicaoAtual-1].strNomArq := strNomArq;
      FRegGetNetPgto[intPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
    End;

    If (FRegGetNetPgto[intPosicaoAtual-1].strCodEst <> '') And
       (VS_ListaEstabelecimentos.IndexOf(FRegGetNetPgto[intPosicaoAtual-1].strCodEst) < 0) Then
      VS_ListaEstabelecimentos.Add(FRegGetNetPgto[intPosicaoAtual-1].strCodEst);

    strRegAnt := fGetDados(001,01);
  End;
end;

function TGetNetPgto.fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
Begin
  If TGetnetFuncoes.fEmptyStr(strVal) Then
    Result := Null
  Else
  Begin
    Result := strVal;
    If blnData Then
      Result := Copy(strVal, 5, 4) + '/' + Copy(strVal, 3, 2) + '/' + Copy(strVal, 1, 2);
  End;
End;

procedure TGetNetPgto.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    LRegistros : TUniQuery;
    intCont  : Integer;
    strSQL   : String;
begin
  strSQL := TGetnetFuncoes.RetornaSQLReplace('GET_GEPGTO',['GET_CONCIL']);

  LRegistros := Nil;
  Try
    LRegistros := VS_FuncoesExternas.fICriaQuery;
    LRegistros.SQL.text := strSQL;

    pgbProg.Position := 0;

    If Length(FRegGetNetPgto) > 0 Then
    Begin
      pgbProg.Properties.Max      := Length(FRegGetNetPgto) - 1;
      For intCont := 0 To Length(FRegGetNetPgto) - 1 Do
      Begin
        If DeveGravarRegistro(FRegGetNetPgto[intCont]) Then
        Begin
          LRegistros.Close;

          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_TIPREG', fRetVal(FRegGetNetPgto[intCont].strTipReg));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_CODEST', fRetVal(FRegGetNetPgto[intCont].strCodEst));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_NUM_RV', fRetVal(FRegGetNetPgto[intCont].strNum_RV));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_DTA_RV', fRetVal(FRegGetNetPgto[intCont].strDta_RV, True));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_DTAPAG', fRetVal(FRegGetNetPgto[intCont].strDtaPag, True));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_CODBCO', fRetVal(FRegGetNetPgto[intCont].strCodBco));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_CODAGE', fRetVal(FRegGetNetPgto[intCont].strCodAge));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_NUMCCO', fRetVal(FRegGetNetPgto[intCont].strNumCco));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_RV_BRU', fRetVal(FRegGetNetPgto[intCont].fltRV_Bru));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_RV_LIQ', fRetVal(FRegGetNetPgto[intCont].fltRV_Liq));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_VALDES', fRetVal(FRegGetNetPgto[intCont].fltValDes));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_VALTAX', fRetVal(FRegGetNetPgto[intCont].fltValTax));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_VALPAG', fRetVal(FRegGetNetPgto[intCont].fltValPag));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_VALENC', fRetVal(FRegGetNetPgto[intCont].fltValEnc));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_RVNPAR', fRetVal(FRegGetNetPgto[intCont].strRVNPar));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_RVTPAR', fRetVal(FRegGetNetPgto[intCont].strRVTPar));
          If (FRegGetNetPgto[intCont].strNumAnt <> '') And (StrToInt64(FRegGetNetPgto[intCont].strNumAnt) <> 0) Then
            TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_NUMANT', fRetVal(FRegGetNetPgto[intCont].strNumAnt));
          If (FRegGetNetPgto[intCont].strNumAnt <> '') And (StrToInt64(FRegGetNetPgto[intCont].strNumAnt) <> 0) Then
            TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_VENORI', fRetVal(FRegGetNetPgto[intCont].strVenOri, True));
          If (FRegGetNetPgto[intCont].fltLiqAnt > 0) Then
            TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_LIQANT', fRetVal(FRegGetNetPgto[intCont].fltLiqAnt));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_NUMNSU', fRetVal(FRegGetNetPgto[intCont].strNumNSU));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_DTATRA', fRetVal(FRegGetNetPgto[intCont].strDtaTra, True));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_NUMCAR', fRetVal(FRegGetNetPgto[intCont].strNumCar));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_VALVEN', fRetVal(FRegGetNetPgto[intCont].fltValVen));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_TOTPAR', fRetVal(FRegGetNetPgto[intCont].strTotPar));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_NUMPAR', fRetVal(FRegGetNetPgto[intCont].strNumPar));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_VALPAR', fRetVal(FRegGetNetPgto[intCont].fltValPar));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_CODAUT', fRetVal(FRegGetNetPgto[intCont].strCodAut));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_STATUS', fRetVal(FRegGetNetPgto[intCont].strStatus));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_NUMTER', fRetVal(FRegGetNetPgto[intCont].strNumTer));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_TIPPAG', fRetVal(FRegGetNetPgto[intCont].strTipPag));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_MOTAJU', fRetVal(FRegGetNetPgto[intCont].strMotAju));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_NOMARQ', fRetVal(FRegGetNetPgto[intCont].strNomArq));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_DTAARQ', fRetVal(FRegGetNetPgto[intCont].strDtaArq, True));

          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_METDAD', fRetVal(FRegGetNetPgto[intCont].Metadado01));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_CONPAG', fRetVal(FRegGetNetPgto[intCont].ContaPagamento));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_ID_REC', fRetVal(FRegGetNetPgto[intCont].IDRecorrencia));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_CONREC', fRetVal(FRegGetNetPgto[intCont].ConteudoRecorrencia));
          TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_INFADC', fRetVal(FRegGetNetPgto[intCont].InformacoesAdicionais));

          Try
            LRegistros.ParamByName('GET_IDEAJU').AsString := '';
            If FRegGetNetPgto[intCont].IdentificadorAjuste <> '' Then
              TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_IDEAJU',  FRegGetNetPgto[intCont].IdentificadorAjuste);
          Except
            //para que versões mais antigas, sem rodar o script funcionem
          end;

          If LRegistros.SQL.text.Contains('GER_VERARQ') Then
             TGetNetFuncoes.CarregaParametroDataset(LRegistros,'GET_VERARQ', FRegGetNetPgto[intCont].VersaoArquivo);

          LRegistros.ExecSQL;
        End;
        TGetNetFuncoes.pStepStatusGravacao(pgbProg);
      End;

      TGetNetFuncoes.GravarEstabelecimentos;

      pgbProg.Position := Length(FRegGetNetPgto) - 1;
    End;
  Finally
    SetLength(FRegGetNetPgto, 0);
    TGetNetFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

end.
