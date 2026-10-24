unit untSafrapayPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, ComCtrls,
     Dialogs, Forms, System.Generics.Collections,

     cxProgressBar, Uni,

     untISafrapayIntegracaoLibCartoes, untTSafrapayFuncoes, untSafrapayTipos;

Type
  TSafrapayPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    strVerArq: String;

    function fGetDados(AValor: String;
                       intIni, intTam: Integer;
                       ACampoFloat: Boolean = False): Variant;

    function fRetVal(AValor: Variant;
                     ACampoData: Boolean = False): Variant;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaSafrapayPgto;
  End;

Var
  strNomArq: String;

  FSafrapayRegistrosPgto: TArrRegistroSafrapayPgto;

implementation

{ TSafrapayPgto }

function TSafrapayPgto.fGetDados(AValor: String; intIni, intTam: Integer;
  ACampoFloat: Boolean): Variant;
Var
  LResultado: Variant;
Begin
  LResultado := Trim(Copy(AValor, intIni, intTam));

  If ACampoFloat Then
    LResultado := TSafrapayFuncoes.fStrToFloat(LResultado) / 100;

  Result := LResultado;
End;

function TSafrapayPgto.fRetVal(AValor: Variant; ACampoData: Boolean): Variant;
Begin
  If TSafrapayFuncoes.fEmptyStr(AValor) Then Result := Null
  Else
  Begin
    If ACampoData Then
      Result := Copy(AValor, 1, 4) + '/' + Copy(AValor, 5, 2) + '/' + Copy(AValor, 7, 2)
    else
      Result := AValor;
  End;
End;

class function TSafrapayPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaSafrapayPgto;
Begin
  If strTabela = 'SAF_SAPGTO' Then
  Begin
    SetLength(Result, 38);

    Result[0].strDescri  := 'SAF_CODEST'; Result[0].strTipCmp  := 'VARCHAR(15)'  ;
    Result[1].strDescri  := 'SAF_TIPREG'; Result[1].strTipCmp  := 'VARCHAR(2)'   ;
    Result[2].strDescri  := 'SAF_DTAPAG'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := 'SAF_TIPLAN'; Result[3].strTipCmp  := 'VARCHAR(1)'   ;
    Result[4].strDescri  := 'SAF_DTATRA'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := 'SAF_NUMNSU'; Result[5].strTipCmp  := 'VARCHAR(12)'  ;
    Result[6].strDescri  := 'SAF_TIPPRO'; Result[6].strTipCmp  := 'VARCHAR(1)'   ;
    Result[7].strDescri  := 'SAF_TIPCAP'; Result[7].strTipCmp  := 'INT'          ;
    Result[8].strDescri  := 'SAF_VALBRU'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'SAF_VALDES'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'SAF_VALLIQ'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'SAF_NUMCAR'; Result[11].strTipCmp := 'VARCHAR(19)'  ;
    Result[12].strDescri := 'SAF_TOTPAR'; Result[12].strTipCmp := 'VARCHAR(2)'   ;
    Result[13].strDescri := 'SAF_NUMPAR'; Result[13].strTipCmp := 'VARCHAR(2)'   ;
    Result[14].strDescri := 'SAF_BRUPAR'; Result[14].strTipCmp := 'DECIMAL(15,2)';
    Result[15].strDescri := 'SAF_DESPAR'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := 'SAF_LIQPAR'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := 'SAF_CODBCO'; Result[17].strTipCmp := 'VARCHAR(3)'   ;
    Result[18].strDescri := 'SAF_CODAGE'; Result[18].strTipCmp := 'VARCHAR(6)'   ;
    Result[19].strDescri := 'SAF_NUMCCO'; Result[19].strTipCmp := 'VARCHAR(11)'  ;
    Result[20].strDescri := 'SAF_CODAUT'; Result[20].strTipCmp := 'VARCHAR(6)'   ;
    Result[21].strDescri := 'SAF_CODBAN'; Result[21].strTipCmp := 'VARCHAR(4)'   ;
    Result[22].strDescri := 'SAF_CODPRO'; Result[22].strTipCmp := 'VARCHAR(3)'   ;
    Result[23].strDescri := 'SAF_NUMANT'; Result[23].strTipCmp := 'VARCHAR(9)'   ;
    Result[24].strDescri := 'SAF_TIPAJU'; Result[24].strTipCmp := 'VARCHAR(1)'   ;
    Result[25].strDescri := 'SAF_CODAJU'; Result[25].strTipCmp := 'VARCHAR(4)'   ;
    Result[26].strDescri := 'SAF_DESAJU'; Result[26].strTipCmp := 'VARCHAR(150)' ;
    Result[27].strDescri := 'SAF_NSUAJU'; Result[27].strTipCmp := 'VARCHAR(12)'  ;
    Result[28].strDescri := 'SAF_NOMARQ'; Result[28].strTipCmp := 'VARCHAR(255)' ;
    Result[29].strDescri := 'SAF_DTAARQ'; Result[29].strTipCmp := 'DATE'         ;
    Result[30].strDescri := 'SAF_VERARQ'; Result[30].strTipCmp := 'VARCHAR(6)'   ;
    Result[31].strDescri := 'SAF_CONCIL'; Result[31].strTipCmp := 'INT DEFAULT 0';
    Result[32].strDescri := 'SAF_ID_PIX'; Result[32].strTipCmp := 'VARCHAR(25)'  ;
    Result[33].strDescri := 'SAF_TAXANT'; Result[33].strTipCmp := 'DECIMAL(12,2)';
    Result[34].strDescri := 'SAF_DIAANT'; Result[34].strTipCmp := 'VARCHAR(3)   ';
    Result[35].strDescri := 'SAF_NUM_EC'; Result[35].strTipCmp := 'VARCHAR(9)   ';
    Result[36].strDescri := 'SAF_NUM_RO'; Result[36].strTipCmp := 'VARCHAR(50)  ';
    Result[37].strDescri := 'SAF_DTAPRV'; Result[37].strTipCmp := 'DATE'         ;
  End;
End;

class function TSafrapayPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaSafrapayPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(SAF_TIPREG,SAF_CODEST,SAF_NUMNSU,SAF_DTATRA,SAF_TIPLAN,SAF_DTAPAG,SAF_NUMPAR,SAF_CODAUT)) ENGINE INNODB ' ;
end;

procedure TSafrapayPgto.pAdicionaLinha(strString: String);
  Var
    LPosicaoAtual: Integer;
begin
  If strString.Trim.IsEmpty Then
    Exit;

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If fGetDados(strString,001,02) = 'A0' Then
  Begin
    dtaArq    := fGetDados(strString,009,08);
    strVerArq := fGetDados(strString,003,06);
  End
  Else If MatchStr(fGetDados(strString,001,02), ['CV', 'AJ']) Then
  Begin
    SetLength(FSafrapayRegistrosPgto, Length(FSafrapayRegistrosPgto) + 1);

    LPosicaoAtual := Length(FSafrapayRegistrosPgto)-1;

    FSafrapayRegistrosPgto[LPosicaoAtual].strTipReg := fGetDados(strString,001,02);
    FSafrapayRegistrosPgto[LPosicaoAtual].strCodEst := fGetDados(strString,003,15);
    FSafrapayRegistrosPgto[LPosicaoAtual].strNumNSU := fGetDados(strString,018,12);
    FSafrapayRegistrosPgto[LPosicaoAtual].strDtaTra := fGetDados(strString,030,08);
    FSafrapayRegistrosPgto[LPosicaoAtual].strVerArq := strVerArq;
    FSafrapayRegistrosPgto[LPosicaoAtual].strDtaArq := dtaArq;
    FSafrapayRegistrosPgto[LPosicaoAtual].strNomArq := strNomArq;

    If (fGetDados(strString,001,02) = 'CV')  Then
    Begin
      FSafrapayRegistrosPgto[LPosicaoAtual].strTipLan := fGetDados(strString,044,01);
      FSafrapayRegistrosPgto[LPosicaoAtual].strDtaPag := fGetDados(strString,045,08);
      FSafrapayRegistrosPgto[LPosicaoAtual].strTipPro := fGetDados(strString,053,01);
      FSafrapayRegistrosPgto[LPosicaoAtual].strTipCap := fGetDados(strString,054,01);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltValBru := fGetDados(strString,055,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltValDes := fGetDados(strString,066,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltValLiq := fGetDados(strString,077,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].strNumCar := fGetDados(strString,088,19);
      FSafrapayRegistrosPgto[LPosicaoAtual].strNumPar := fGetDados(strString,107,02);
      FSafrapayRegistrosPgto[LPosicaoAtual].strTotPar := fGetDados(strString,109,02);
      If FSafrapayRegistrosPgto[LPosicaoAtual].strTotPar <> '00' Then
      Begin
        FSafrapayRegistrosPgto[LPosicaoAtual].fltBruPar := fGetDados(strString,123,11,True);
        FSafrapayRegistrosPgto[LPosicaoAtual].fltDesPar := fGetDados(strString,134,11,True);
        FSafrapayRegistrosPgto[LPosicaoAtual].fltLiqPar := fGetDados(strString,145,11,True);
      End
      Else
      begin
        FSafrapayRegistrosPgto[LPosicaoAtual].fltBruPar := FSafrapayRegistrosPgto[LPosicaoAtual].fltValBru;
        FSafrapayRegistrosPgto[LPosicaoAtual].fltDesPar := FSafrapayRegistrosPgto[LPosicaoAtual].fltValDes;
        FSafrapayRegistrosPgto[LPosicaoAtual].fltLiqPar := FSafrapayRegistrosPgto[LPosicaoAtual].fltValLiq;
      End;
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodBco := fGetDados(strString,156,03);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodAge := fGetDados(strString,159,06);
      FSafrapayRegistrosPgto[LPosicaoAtual].strNumCco := fGetDados(strString,165,11);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodAut := fGetDados(strString,182,06);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodBan := fGetDados(strString,188,04);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodPro := fGetDados(strString,192,03);
      FSafrapayRegistrosPgto[LPosicaoAtual].strNumAnt := fGetDados(strString,199,09);

      FSafrapayRegistrosPgto[LPosicaoAtual].DataPrevisaoPagamento := fGetDados(strString,315,08);

      If FSafrapayRegistrosPgto[LPosicaoAtual].strCodBan = 'PIX' Then
      Begin
        FSafrapayRegistrosPgto[LPosicaoAtual].strNumCar := 'PIX';
        FSafrapayRegistrosPgto[LPosicaoAtual].strID_Pix := fGetDados(strString,469, 25);
      End;
    End
    Else If (fGetDados(strString,001,02) = 'AJ')  Then
    Begin
      FSafrapayRegistrosPgto[LPosicaoAtual].strNumPar := fGetDados(strString,038,02);

      FSafrapayRegistrosPgto[LPosicaoAtual].strTotPar := fGetDados(strString,375,02);
      If FSafrapayRegistrosPgto[LPosicaoAtual].strTotPar = '' Then
        FSafrapayRegistrosPgto[LPosicaoAtual].strTotPar := FSafrapayRegistrosPgto[LPosicaoAtual].strNumPar;

      FSafrapayRegistrosPgto[LPosicaoAtual].strNSUAju := fGetDados(strString,040,12);
      FSafrapayRegistrosPgto[LPosicaoAtual].strDtaPag := fGetDados(strString,067,08);
      FSafrapayRegistrosPgto[LPosicaoAtual].strTipLan := fGetDados(strString,066,01);
      FSafrapayRegistrosPgto[LPosicaoAtual].strTipCap := fGetDados(strString,075,01);
      FSafrapayRegistrosPgto[LPosicaoAtual].strTipAju := fGetDados(strString,076,01);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodAju := fGetDados(strString,077,04);
      FSafrapayRegistrosPgto[LPosicaoAtual].strDesAju := fGetDados(strString,081,150);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltValBru := fGetDados(strString,231,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltValDes := fGetDados(strString,242,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltValLiq := fGetDados(strString,253,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltBruPar := fGetDados(strString,231,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltDesPar := fGetDados(strString,242,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].fltLiqPar := fGetDados(strString,253,11,True);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodBco := fGetDados(strString,264,03);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodAge := fGetDados(strString,267,06);
      FSafrapayRegistrosPgto[LPosicaoAtual].strNumCco := fGetDados(strString,273,11);
      FSafrapayRegistrosPgto[LPosicaoAtual].strNumCar := fGetDados(strString,284,19);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodBan := fGetDados(strString,303,04);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodAut := fGetDados(strString,339,06);
      FSafrapayRegistrosPgto[LPosicaoAtual].strCodPro := fGetDados(strString,307,03);
      FSafrapayRegistrosPgto[LPosicaoAtual].strNumAnt := fGetDados(strString,310,09);

      FSafrapayRegistrosPgto[LPosicaoAtual].TaxaAntecipacao := fGetDados(strString,414,5,True);

      FSafrapayRegistrosPgto[LPosicaoAtual].DiasAntecipados := fGetDados(strString,419,03);
      FSafrapayRegistrosPgto[LPosicaoAtual].NumeroEC := fGetDados(strString,422,09);
      FSafrapayRegistrosPgto[LPosicaoAtual].NumeroRO := fGetDados(strString,431,50);
    End;

    If (Length(FSafrapayRegistrosPgto) <= 0) Then
      Exit;

    If (FSafrapayRegistrosPgto[LPosicaoAtual].strCodEst <> '') And
       (VS_ListaEstabelecimentos.IndexOf(FSafrapayRegistrosPgto[LPosicaoAtual].strCodEst) < 0) Then
      VS_ListaEstabelecimentos.Add(FSafrapayRegistrosPgto[LPosicaoAtual].strCodEst);
  End;
end;

procedure TSafrapayPgto.pGravarRegistros(pgbProg: TcxProgressBar);
Var
  LGravacao,
  LValidaNovosCampos : TUniQuery;

  LRegistroPgto: TSafrapayRegistro;
begin
  LGravacao := Nil;
  LValidaNovosCampos := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LValidaNovosCampos := VS_FuncoesExternas.fICriaQuery;

    LGravacao.SQL.Text := TSafrapayFuncoes.RetornaSQLReplace('SAF_SAPGTO', ['SAF_CONCIL']);
    LValidaNovosCampos.SQL.Text := 'SELECT * FROM SAF_SAPGTO WHERE FALSE';
    LValidaNovosCampos.Open;

    pgbProg.Position := 0;

    If Length(FSafrapayRegistrosPgto) = 0 Then
      Exit;

    pgbProg.Properties.Max := Length(FSafrapayRegistrosPgto)-1;
    For LRegistroPgto In FSafrapayRegistrosPgto Do
    Begin
      LGravacao.Close;

      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TIPREG', fRetVal(LRegistroPgto.strTipReg));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_CODEST', fRetVal(LRegistroPgto.strCodEst));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_DTAPAG', fRetVal(LRegistroPgto.strDtaPag, True));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_CODBCO', fRetVal(LRegistroPgto.strCodBco));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_CODAGE', fRetVal(LRegistroPgto.strCodAge));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NUMCCO', fRetVal(LRegistroPgto.strNumCco));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_VALBRU', fRetVal(LRegistroPgto.fltValBru));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_VALDES', fRetVal(LRegistroPgto.fltValDes));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_VALLIQ', fRetVal(LRegistroPgto.fltValLiq));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_BRUPAR', fRetVal(LRegistroPgto.fltBruPar));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_DESPAR', fRetVal(LRegistroPgto.fltDesPar));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_LIQPAR', fRetVal(LRegistroPgto.fltLiqPar));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_DTATRA', fRetVal(LRegistroPgto.strDtaTra, True));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_CODAUT', fRetVal(LRegistroPgto.strCodAut));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NUMCAR', fRetVal(LRegistroPgto.strNumCar));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_ID_PIX', fRetVal(LRegistroPgto.strID_Pix));

      If LRegistroPgto.strNumNSU <> '000000000000' Then
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NUMNSU', fRetVal(LRegistroPgto.strNumNSU))
      Else
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NUMNSU', fRetVal(LRegistroPgto.strNSUAju));

      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TIPLAN', fRetVal(LRegistroPgto.strTipLan));

      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TIPPRO', Null);
      If LRegistroPgto.strTipPro <> '' Then
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TIPPRO', fRetVal(LRegistroPgto.strTipPro));

      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TIPCAP', fRetVal(LRegistroPgto.strTipCap));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TOTPAR', RightStr(fRetVal(LRegistroPgto.strTotPar), 2));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NUMPAR', RightStr(fRetVal(LRegistroPgto.strNumPar), 2));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_CODBAN', fRetVal(LRegistroPgto.strCodBan));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_CODPRO', fRetVal(LRegistroPgto.strCodPro));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NUMANT', fRetVal(LRegistroPgto.strNumAnt));

      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NSUAJU', Null);
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TIPAJU', Null);
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_CODAJU', Null);
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_DESAJU', Null);
      If LRegistroPgto.strTipReg = 'AJ' Then
      Begin
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NSUAJU', fRetVal(LRegistroPgto.strNSUAju));
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TIPAJU', fRetVal(LRegistroPgto.strTipAju));
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_CODAJU', fRetVal(LRegistroPgto.strCodAju));
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_DESAJU', fRetVal(LRegistroPgto.strDesAju));
      End;

      If LValidaNovosCampos.FindField('SAF_TAXANT') <> Nil Then
      Begin
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_TAXANT', fRetVal(LRegistroPgto.TaxaAntecipacao));
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_DIAANT', fRetVal(LRegistroPgto.DiasAntecipados));
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NUM_EC', fRetVal(LRegistroPgto.NumeroEC));
        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NUM_RO', fRetVal(LRegistroPgto.NumeroRO));

        TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_DTAPRV', fRetVal(LRegistroPgto.DataPrevisaoPagamento, True));
      End;

      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_DTAARQ', fRetVal(LRegistroPgto.strDtaArq, True));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_NOMARQ', fRetVal(LRegistroPgto.strNomArq));
      TSafrapayFuncoes.CarregaParametroDataset(LGravacao, 'SAF_VERARQ', fRetVal(LRegistroPgto.strVerArq));

      LGravacao.ExecSQL;

      TSafrapayFuncoes.pStepStatusGravacao(pgbProg);
    End;

    TSafrapayFuncoes.GravarEstabelecimentos;

    pgbProg.Position := Length(FSafrapayRegistrosPgto) - 1;
    Application.ProcessMessages;
  Finally
    TSafrapayFuncoes.FreeAndNilDatasets(LGravacao);
    TSafrapayFuncoes.FreeAndNilDatasets(LValidaNovosCampos);
  End;
end;

end.
