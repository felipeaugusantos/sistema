{***********************************}
{* Importação de arquivos da CIELO *}
{********************************AJ*}
unit untCieloPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     System.Math, Vcl.Forms, Data.DB,

     Uni, cxProgressBar,

     untICieloIntegracaoLibCartoes, untCieloTipos, untTCieloFuncoes;

Type
  TCieloPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq,
    dtaPag,
    strCodBco,
    strCodAge,
    strNumCco,
    strNumAnt,
    strRegAnt,
    strTraAnt,
    strTipArq,

    FLinhaArquivo,
    FVersaoArquivo: String;

    intPosicaoAtual: Integer;

    function fRetornaTipCar(strTipCar: String): String;

    function fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
    
    function GravarRegistro(ARegistro: TRegistroPgto;
                            ADatasetVerifica,
                            ADatasetNegociacao,
                            ADataSetAjuste: TUniQuery): Boolean;

    function ExistemRegistrosdaVersao015ParaADataSelecionada: Boolean;
    function EhAjuste(ARegistro: TRegistroPgto): Boolean;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaCieloPgto;
  End;

Var
  strNomArq,
  strArqAnt,
  strRO_Ant,
  strEstabelecimentoHeader,
  strCodigoLiquidacao,
  strDataPagamento,
  strDataNegociacao: String;
  intParAju,
  ContadorAjustes,
  ContadorGravame,
  ContadorAjusteTipo04: Integer;

  FRegCieloPgto: TArrRegistroCieloPgto;
  FListaVersao014: TStringList;

implementation

uses untCielo;

{ TCieloPgto }

constructor TCieloPgto.Create;
Begin
  intPosicaoAtual := 0;
  strRegAnt := '';
  strTraAnt := '';
  strTipArq := '';
  strRO_Ant := '';
  strEstabelecimentoHeader := '';
  strCodigoLiquidacao := '';
  strDataPagamento := '';
  strDataNegociacao := '';

  FVersaoArquivo := '';
End;

function TCieloPgto.fRetornaTipCar(strTipCar: String): String;
  Const
    PRODUTOS_ARRAY: Array[0..46] Of String = ('001', '002', '003', '004', '005',
                                              '006', '007', '008', '009', '010',
                                              '012', '019', '020', '021', '029',
                                              '030', '032', '033', '038', '039',
                                              '040', '043', '061', '062', '070',
                                              '072', '082', '083', '084', '096',
                                              '098', '110', '161', '163', '164',
                                              '165', '200', '201', '270', '321',
                                              '322', '324', '330', '342', '378',
                                              '380', '433');
Begin
  Result := 'D';
  If MatchStr(strTipCar, PRODUTOS_ARRAY) Then
    Result := 'C';
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* CIE_CIPGTO                                   *}
{*********************************************AJ*}
class function TCieloPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaCieloPgto;
Begin
  If strTabela = 'CIE_CIPGTO' Then
  Begin
    SetLength(Result, 73);

    Result[0].strDescri  := 'CIE_TIPREG'; Result[0].strTipCmp  := 'VARCHAR(1)'   ;
    Result[1].strDescri  := 'CIE_CODEST'; Result[1].strTipCmp  := 'VARCHAR(10)'  ;
    Result[2].strDescri  := 'CIE_NUM_RO'; Result[2].strTipCmp  := 'VARCHAR(7)'   ;
    Result[3].strDescri  := 'CIE_TIPTRA'; Result[3].strTipCmp  := 'VARCHAR(2)'   ;
    Result[4].strDescri  := 'CIE_DTAAPR'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := 'CIE_CODBCO'; Result[5].strTipCmp  := 'VARCHAR(4)'   ;
    Result[6].strDescri  := 'CIE_CODAGE'; Result[6].strTipCmp  := 'VARCHAR(5)'   ;
    Result[7].strDescri  := 'CIE_NUMCCO'; Result[7].strTipCmp  := 'VARCHAR(14)'  ;
    Result[8].strDescri  := 'CIE_RO_BRU'; Result[8].strTipCmp  := 'DECIMAL(15,2)';
    Result[9].strDescri  := 'CIE_RO_COM'; Result[9].strTipCmp  := 'DECIMAL(15,2)';
    Result[10].strDescri := 'CIE_RO_REJ'; Result[10].strTipCmp := 'DECIMAL(15,2)';
    Result[11].strDescri := 'CIE_RO_LIQ'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := 'CIE_STATUS'; Result[12].strTipCmp := 'VARCHAR(2)'   ;
    Result[13].strDescri := 'CIE_DTAPAG'; Result[13].strTipCmp := 'DATE'         ;
    Result[14].strDescri := 'CIE_NUMANT'; Result[14].strTipCmp := 'VARCHAR(9)'   ;
    Result[15].strDescri := 'CIE_BRUANT'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := 'CIE_PORCOM'; Result[16].strTipCmp := 'DECIMAL(5,2)' ;
    Result[17].strDescri := 'CIE_NUMCAR'; Result[17].strTipCmp := 'VARCHAR(19)'  ;
    Result[18].strDescri := 'CIE_DTAVEN'; Result[18].strTipCmp := 'DATE'         ;
    Result[19].strDescri := 'CIE_VALPAR'; Result[19].strTipCmp := 'DECIMAL(15,2)';
    Result[20].strDescri := 'CIE_NUMPAR'; Result[20].strTipCmp := 'VARCHAR(2)'   ;
    Result[21].strDescri := 'CIE_TOTPAR'; Result[21].strTipCmp := 'VARCHAR(2)'   ;
    Result[22].strDescri := 'CIE_CODAUT'; Result[22].strTipCmp := 'VARCHAR(40)'  ;
    Result[23].strDescri := 'CIE_CODTID'; Result[23].strTipCmp := 'VARCHAR(20)'  ;
    Result[24].strDescri := 'CIE_NUMNSU'; Result[24].strTipCmp := 'VARCHAR(6)'   ;
    Result[25].strDescri := 'CIE_VALTOT'; Result[25].strTipCmp := 'DECIMAL(15,2)';
    Result[26].strDescri := 'CIE_VALPRO'; Result[26].strTipCmp := 'DECIMAL(15,2)';
    Result[27].strDescri := 'CIE_NUM_NF'; Result[27].strTipCmp := 'VARCHAR(9)'   ;
    Result[28].strDescri := 'CIE_NOMARQ'; Result[28].strTipCmp := 'VARCHAR(255)' ;
    Result[29].strDescri := 'CIE_DTAARQ'; Result[29].strTipCmp := 'DATE'         ;
    Result[30].strDescri := 'CIE_CONCIL'; Result[30].strTipCmp := 'VARCHAR(1) DEFAULT ''0''';
    Result[31].strDescri := 'CIE_NUMTER'; Result[31].strTipCmp := 'VARCHAR(8)'   ;
    Result[32].strDescri := 'CIE_DTAANT'; Result[32].strTipCmp := 'DATE'         ;
    Result[33].strDescri := 'CIE_TIPCAR'; Result[33].strTipCmp := 'VARCHAR(1)'   ;
    Result[34].strDescri := 'CIE_TIPFIN'; Result[34].strTipCmp := 'VARCHAR(1)'   ;
    Result[35].strDescri := 'CIE_LIQANT'; Result[35].strTipCmp := 'DECIMAL(15,2)';
    Result[36].strDescri := 'CIE_RO_DEB'; Result[36].strTipCmp := 'VARCHAR(7)'   ;
    Result[37].strDescri := 'CIE_LIQDEB'; Result[37].strTipCmp := 'DECIMAL(15,2)';
    Result[38].strDescri := 'CIE_CODBAN'; Result[38].strTipCmp := 'VARCHAR(3)'   ;
    Result[39].strDescri := 'CIE_CODPRO'; Result[39].strTipCmp := 'VARCHAR(3)'   ;
    Result[40].strDescri := 'CIE_ORIAJU'; Result[40].strTipCmp := 'VARCHAR(2)'   ;
    Result[41].strDescri := 'CIE_TIPNEG'; Result[41].strTipCmp := 'VARCHAR(2)'   ;
    Result[42].strDescri := 'CIE_VENORI'; Result[42].strTipCmp := 'DATE'         ;

    Result[43].strDescri := 'CIE_CHA_UR'; Result[43].strTipCmp := 'VARCHAR(100)' ;
    Result[44].strDescri := 'CIE_TAXANT'; Result[44].strTipCmp := 'DECIMAL(15,2)';
    Result[45].strDescri := 'CIE_TIPARQ'; Result[45].strTipCmp := 'VARCHAR(2)'   ;
    Result[46].strDescri := 'CIE_VERARQ'; Result[46].strTipCmp := 'VARCHAR(3)'   ;
    Result[47].strDescri := 'CIE_CODAJU'; Result[47].strTipCmp := 'VARCHAR(4)'   ;
    Result[48].strDescri := 'CIE_CODPED'; Result[48].strTipCmp := 'VARCHAR(20)'  ;
    Result[49].strDescri := 'CIE_CODVEN'; Result[49].strTipCmp := 'VARCHAR(15)'  ;
    Result[50].strDescri := 'CIE_CODVOR'; Result[50].strTipCmp := 'VARCHAR(15)'  ;
    Result[51].strDescri := 'CIE_TIPCAP'; Result[51].strTipCmp := 'VARCHAR(2)'   ;
    Result[52].strDescri := 'CIE_TIPLAN'; Result[52].strTipCmp := 'VARCHAR(2)'   ;
    Result[53].strDescri := 'CIE_TIPLOR'; Result[53].strTipCmp := 'VARCHAR(2)'   ;
    Result[54].strDescri := 'CIE_TIPANT'; Result[54].strTipCmp := 'VARCHAR(1)'   ;
    Result[55].strDescri := 'CIE_MOVORI'; Result[55].strTipCmp := 'DATE'         ;
    Result[56].strDescri := 'CIE_DTAENV'; Result[56].strTipCmp := 'DATE'         ;
    Result[57].strDescri := 'CIE_MEICAP'; Result[57].strTipCmp := 'VARCHAR(3)'   ;
    Result[58].strDescri := 'CIE_GRUCAR'; Result[58].strTipCmp := 'VARCHAR(2)'   ;
    Result[59].strDescri := 'CIE_VALCOM'; Result[59].strTipCmp := 'DECIMAL(15,2)';
    Result[60].strDescri := 'CIE_COMMIN'; Result[60].strTipCmp := 'DECIMAL(15,2)';
    Result[61].strDescri := 'CIE_TAXADM'; Result[61].strTipCmp := 'DECIMAL(15,2)';
    Result[62].strDescri := 'CIE_TAXMDR'; Result[62].strTipCmp := 'DECIMAL(15,2)';
    Result[63].strDescri := 'CIE_TAXRAP'; Result[63].strTipCmp := 'DECIMAL(15,2)';
    Result[64].strDescri := 'CIE_INDGRA'; Result[64].strTipCmp := 'VARCHAR(1)'   ;
    Result[65].strDescri := 'CIE_INDRAP'; Result[65].strTipCmp := 'VARCHAR(1)'   ;
    Result[66].strDescri := 'CIE_INDZER'; Result[66].strTipCmp := 'VARCHAR(1)'   ;
    Result[67].strDescri := 'CIE_INDREJ'; Result[67].strTipCmp := 'VARCHAR(1)'   ;
    Result[68].strDescri := 'CIE_INDTAR'; Result[68].strTipCmp := 'VARCHAR(1)'   ;
    Result[69].strDescri := 'CIE_TRACON'; Result[69].strTipCmp := 'VARCHAR(30)'  ;
    Result[70].strDescri := 'CIE_NUMLOT'; Result[70].strTipCmp := 'VARCHAR(7)'   ;
    Result[71].strDescri := 'CIE_TRAPRO'; Result[71].strTipCmp := 'VARCHAR(22)'  ;
    Result[72].strDescri := 'CIE_MOTREJ'; Result[72].strTipCmp := 'VARCHAR(3)'   ;
  End;

End;

class function TCieloPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaCieloPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(CIE_TIPREG,CIE_CODEST,CIE_NUM_RO,CIE_DTAPAG,CIE_DTAVEN,CIE_NUMPAR,CIE_CODAUT,' +
                     'CIE_TIPTRA,CIE_STATUS,CIE_NUMNSU,CIE_VALPAR)) ENGINE INNODB ' ;
end;

function TCieloPgto.GravarRegistro(ARegistro: TRegistroPgto; ADatasetVerifica,
  ADatasetNegociacao, ADataSetAjuste: TUniQuery): Boolean;
begin
  Result := True;

  if EhAjuste(ARegistro) then
  begin
    if ADataSetAjuste.Active then
    begin
      Exit(ADataSetAjuste.IsEmpty);
    end;
  end;

  If ARegistro.strTipReg <> 'B' Then
  Begin
    If ARegistro.strStatus = '01' Then
      Exit;

    If ADatasetVerifica.Active Then
    Begin
      Result := ADatasetVerifica.IsEmpty;
      Exit;
    End;
  End
  Else
  Begin
    If ADatasetNegociacao.Active Then
    Begin
      Result :=  ADatasetNegociacao.IsEmpty;
      Exit;
    End;
  End;
end;

function TCieloPgto.EhAjuste(ARegistro: TRegistroPgto): Boolean;
var
  LValidacaoOk: Boolean;
  TIPNEG,
  VERARQ,
  ORIAJU,
  TIPREG,
  TIPTRA,
  STATUS,
  CODAUT,
  NUMNSU: String;
  RO_LIQ: Double;
begin
  LValidacaoOk := False;

  TIPNEG := ARegistro.TipoNegociacao;
  VERARQ := ARegistro.VersaoArquivo;
  TIPREG := ARegistro.strTipReg;
  ORIAJU := ARegistro.OrigemAjuste;
  TIPTRA := ARegistro.strTipTra;
  STATUS := ARegistro.strStatus;
  RO_LIQ := fRetVal(ARegistro.fltRO_Liq);
  CODAUT := ARegistro.strCodAut;
  NUMNSU := ARegistro.strNumNsu;

  if ((TIPNEG.isEmpty) or (TIPNEG <> 'CE')) then
    LValidacaoOk := True
  else if TIPNEG.Equals('CE') then
    LValidacaoOk := True;

  if LValidacaoOk then
  begin
    if (VERARQ.isEmpty) or (VERARQ <> '15') then
    begin
      if (TIPREG.Equals('8')) and (ORIAJU <> EmptyStr) then
        LValidacaoOk := True
      else if (not (MatchStr(TIPREG, ['3','B']))) and
              (MatchStr(TIPTRA, ['03','04','02'])) and
              ((STATUS.Equals('01')) and (RO_LIQ <> 0)) then
      begin
        if not ((ORIAJU.Equals('51')) and
                (CODAUT = '000000')  and
                (NUMNSU = '000000')) then
          LValidacaoOk := True
        else
          LValidacaoOk := False;
      end;
    end
    else
      LValidacaoOk := False;
  end;
  Result := LValidacaoOk;
end;

function TCieloPgto.ExistemRegistrosdaVersao015ParaADataSelecionada: Boolean;
  Var
    LConsulta: TUniQuery;

    LItem,
    LDataImportada: String;

    LDados: TStringList;
begin
  Result := False;

  If Not Assigned(FListaVersao014) Then
    Exit;

  If FListaVersao014.Count = 0 Then
    Exit;

  If Not TCieloFuncoes.ExisteScriptsDaCieloVersao015 Then
    Exit;

  LDados := Nil;
  LConsulta := Nil;
  Try
    LDados := TStringList.Create;
    LDados.Delimiter := '|';
    LDados.StrictDelimiter := True;

    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT CIE_DTAPAG ' +
                          'FROM CIE_CIPGTO ' +
                          'WHERE CIE_DTAPAG=:DTAPAG ' +
                          '  AND CIE_CODEST=:CODEST ' +
                          '  AND CIE_VERARQ="015" ' +
                          'LIMIT 10 ';

    For LItem In FListaVersao014 Do
    Begin
      LConsulta.Close;

      LDados.DelimitedText := LItem;

      LConsulta.ParamByName('DTAPAG').AsString := fRetVal(LDados[1], True);
      LConsulta.ParamByName('CODEST').AsString := LDados[0];
      LConsulta.Open;

      Result := Not LConsulta.IsEmpty;

      If Result Then
      Begin
        If Length(LDados[1]) = 8 Then
          LDataImportada := Copy(LDados[1], 7, 2) + '/' + Copy(LDados[1], 5, 2) + '/' + Copy(LDados[1], 1, 4)
        Else
          LDataImportada := Copy(LDados[1], 5, 2) + '/' + Copy(LDados[1], 3, 2) + '/' + Copy(LDados[1], 1, 2);

        Raise Exception.Create('Não é permitido importar arquivos da versão 015 e 014 para o mesmo período de pagamento.' + #13 +
                               'A data de pagamento ' + LDataImportada +
                               ' e estabelecimento ' + LDados[0] + ' já possui arquivos da versão 015 (atual) importados.');
      End;
    End;
  Finally
    TCieloFuncoes.FreeAndNilDatasets(LConsulta);

    If Assigned(LDados) Then
      FreeAndNil(LDados);
  End;
end;

function TCieloPgto.fGetDados(intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
  Var
    rst: Variant;
Begin
  rst := Trim(Copy(FLinhaArquivo, intIni, intTam));
  If blnFlt Then
    rst := TCieloFuncoes.fStrToFloat(rst) / 100;

  Result := rst;
End;

procedure TCieloPgto.pAdicionaLinha(strString: String);
Const
  AUMENTO_CAPACIDADE_FREG  = 2000;

  Var
    blnArquivoComRegistroInconsistente: Boolean;
begin
  FLinhaArquivo := strString;

  If fGetDados(064,03) = '099' Then
  Begin
    If MatchStr(strTipArq, ['04', '06']) Then
      Exit;
  End;

  Try
    If intPosicaoAtual >= Length(FRegCieloPgto) - 1 Then
    Begin
      SetLength(FRegCieloPgto, Length(FRegCieloPgto)+AUMENTO_CAPACIDADE_FREG);
    End;

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If strArqAnt <> strNomArq Then
    Begin
      strArqAnt := strNomArq;
      intParAju := 1;
    End;

    blnArquivoComRegistroInconsistente := (strTipArq <> '') And
                                          (StrToInt(strTipArq) In [4, 6]) And
                                          (fGetDados(001,01) <> '') And
                                          (StrtoInt(fGetDados(001,01)) In [1, 6, 7]) And
                                          ((StrtoInt(fGetDados(001,01)) In [6, 7]) Or
                                           (StrtoInt(fGetDados(125,06)) > 0))  And
                                          (StrtoInt(fGetDados(024,02)) In [1,2,3]) And
                                          (strTraAnt = '01') And
                                          (StrToInt(strRegAnt) In [1, 6]);

    If blnArquivoComRegistroInconsistente Then
      Raise Exception.Create('O arquivo ' + strNomArq + ' possui registros com cartões faltando.' + #13 +
                             'Número do RO sem registros: ' + strRO_Ant + #13 +
                             'Peça um novo arquivo para VAN!');

    If fGetDados(001,01) = '0' Then
    Begin
      dtaArq    := fGetDados(012,08);
      strTipArq := fGetDados(048,02);
      strEstabelecimentoHeader := fGetDados(002,10);

      ContadorAjusteTipo04 := 0;

      FVersaoArquivo := fGetDados(071,03);
    End
    Else If fGetDados(001,01) = '5' Then
    Begin
      dtaPag    := fGetDados(021,08);
      strCodBco := fGetDados(145,04);
      strCodAge := fGetDados(150,05);
      strNumCco := fGetDados(155,14);
      strNumAnt := fGetDados(012,09);
    End
    Else If (fGetDados(001,01) <> '') And
            ((MatchStr(fGetDados(001,01), ['1', '2', '6', '7', '8', 'A', 'B'])) Or ((fGetDados(001,01) = '3') And (strTipArq = '04'))) Then
    Begin
      If ((MatchStr(fGetDados(001,01), ['1', '6', '7', '3', '8', 'B'])) Or
         ((strRegAnt = '2') And (fGetDados(001,01) = '2'))) Then
        Inc(intPosicaoAtual);

      If (MatchStr(fGetDados(001,01), ['1', '6', '7'])) Then
      Begin
        FRegCieloPgto[intPosicaoAtual-1].strTipReg := fGetDados(001,01);
        FRegCieloPgto[intPosicaoAtual-1].fltLiqDeb := 0;
        FRegCieloPgto[intPosicaoAtual-1].CalculaLiqDeb := True;

        If fGetDados(001,01) = '1' Then
        Begin
          FRegCieloPgto[intPosicaoAtual-1].strTipTra := fGetDados(024,02);
          FRegCieloPgto[intPosicaoAtual-1].strDtaApr := fGetDados(026,06);
          FRegCieloPgto[intPosicaoAtual-1].strDtaPag := fGetDados(032,06);
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Bru := fGetDados(045,13,True);
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Com := fGetDados(059,13,True);
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Rej := fGetDados(073,13,True);
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Liq := fGetDados(087,13,True);
          FRegCieloPgto[intPosicaoAtual-1].strCodBco := fGetDados(100,04);
          FRegCieloPgto[intPosicaoAtual-1].strCodAge := fGetDados(104,05);
          FRegCieloPgto[intPosicaoAtual-1].strNumCco := fGetDados(109,14);
          FRegCieloPgto[intPosicaoAtual-1].strStatus := fGetDados(123,02);
          FRegCieloPgto[intPosicaoAtual-1].strTipFin := fGetDados(161,01);
          FRegCieloPgto[intPosicaoAtual-1].strNum_RO := fGetDados(012,07);
          FRegCieloPgto[intPosicaoAtual-1].fltLiqAnt := 0;
          If MatchStr(fGetDados(024,02), ['03', '02', '04']) Then
            FRegCieloPgto[intPosicaoAtual-1].fltLiqDeb := fGetDados(087,13,True);

          FRegCieloPgto[intPosicaoAtual-1].CodigoProduto := fGetDados(233,03);
          FRegCieloPgto[intPosicaoAtual-1].CodigoBandeira := fGetDados(185,03);
          FRegCieloPgto[intPosicaoAtual-1].OrigemAjuste := fGetDados(146,02);
          FRegCieloPgto[intPosicaoAtual-1].VencimentoOriginal := fGetDados(038,06);

          strTraAnt := fGetDados(024,02);
          If (fGetDados(024,02) = '04') Then
          Begin
            FRegCieloPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,10);
            FRegCieloPgto[intPosicaoAtual-1].strNumCar := '';
            FRegCieloPgto[intPosicaoAtual-1].strDtaVen := fGetDados(032,06);
            FRegCieloPgto[intPosicaoAtual-1].fltValPar := fGetDados(045,13,True);
            FRegCieloPgto[intPosicaoAtual-1].strNumPar := RightStr('0' + InttoStr(intParAju) , 2);
            FRegCieloPgto[intPosicaoAtual-1].strTotPar := RightStr('0' + InttoStr(intParAju) , 2);
            FRegCieloPgto[intPosicaoAtual-1].strCodAut := RightStr(FRegCieloPgto[intPosicaoAtual-1].strNum_RO, 6);
            FRegCieloPgto[intPosicaoAtual-1].strCodPid := '';
            FRegCieloPgto[intPosicaoAtual-1].strNumNSU := RightStr(FRegCieloPgto[intPosicaoAtual-1].strNum_RO, 6);
            FRegCieloPgto[intPosicaoAtual-1].fltValTot := fGetDados(087,13,True);
            FRegCieloPgto[intPosicaoAtual-1].fltValPro := fGetDados(087,13,True);
            FRegCieloPgto[intPosicaoAtual-1].strNum_NF := '';
            FRegCieloPgto[intPosicaoAtual-1].strNumTer := '';

            inc(intParAju);
          End;
        End
        Else If (fGetDados(001,01) = '6') Then
        Begin
          FRegCieloPgto[intPosicaoAtual-1].strDtaPag := dtaPag;
          FRegCieloPgto[intPosicaoAtual-1].strCodBco := strCodBco;
          FRegCieloPgto[intPosicaoAtual-1].strCodAge := strCodAge;
          FRegCieloPgto[intPosicaoAtual-1].strNumCco := strNumCco;
          FRegCieloPgto[intPosicaoAtual-1].strStatus := '01';
          FRegCieloPgto[intPosicaoAtual-1].strNumAnt := strNumAnt;
          FRegCieloPgto[intPosicaoAtual-1].strTipTra := '01';
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Bru := fGetDados(041,13,True);
          FRegCieloPgto[intPosicaoAtual-1].fltBruAnt := fGetDados(041,13,True);
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Liq := fGetDados(083,13,True);
          FRegCieloPgto[intPosicaoAtual-1].fltLiqAnt := fGetDados(055,13,True);
          FRegCieloPgto[intPosicaoAtual-1].strDtaAnt := fGetDados(021,08);
          FRegCieloPgto[intPosicaoAtual-1].strNum_RO := fGetDados(029,07);
          FRegCieloPgto[intPosicaoAtual-1].VencimentoOriginal := fGetDados(021,08);
          strTraAnt := '01';
        End
        Else
        Begin
          FRegCieloPgto[intPosicaoAtual-1].strDtaPag := fGetDados(092,08);
          FRegCieloPgto[intPosicaoAtual-1].strCodBco := strCodBco;
          FRegCieloPgto[intPosicaoAtual-1].strCodAge := strCodAge;
          FRegCieloPgto[intPosicaoAtual-1].strNumCco := strNumCco;
          FRegCieloPgto[intPosicaoAtual-1].strStatus := '01';
          FRegCieloPgto[intPosicaoAtual-1].strNumAnt := strNumAnt;
          FRegCieloPgto[intPosicaoAtual-1].strTipTra := '03';
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Bru := fGetDados(049,14,True); //Valor do RO Antecipado
          FRegCieloPgto[intPosicaoAtual-1].strDtaAnt := fGetDados(041,08);
          FRegCieloPgto[intPosicaoAtual-1].fltBruAnt := fGetDados(100,14,True); //Valor do Ajuste de Débito
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Liq := fGetDados(114,14,True); //Valor Compensado do Ajuste
          FRegCieloPgto[intPosicaoAtual-1].fltLiqAnt := 0;
          FRegCieloPgto[intPosicaoAtual-1].strRo_Deb := fGetDados(085,07);
          FRegCieloPgto[intPosicaoAtual-1].strNum_RO := fGetDados(034,07);
          strTraAnt := '01';

          If (strRegAnt = '2') Then
          Begin
            FRegCieloPgto[intPosicaoAtual-1].strCodEst := FRegCieloPgto[intPosicaoAtual-2].strCodEst;
            FRegCieloPgto[intPosicaoAtual-1].strNumCar := '0000000000000000';
            FRegCieloPgto[intPosicaoAtual-1].strDtaVen := fGetDados(092,08);
            FRegCieloPgto[intPosicaoAtual-1].fltValPar := fGetDados(114,14,True);
            FRegCieloPgto[intPosicaoAtual-1].strNumPar := '01';
            FRegCieloPgto[intPosicaoAtual-1].strTotPar := '01';
            FRegCieloPgto[intPosicaoAtual-1].strCodAut := fGetDados(034,07);
            FRegCieloPgto[intPosicaoAtual-1].strCodPid := '';
            FRegCieloPgto[intPosicaoAtual-1].strNumNSU := fGetDados(034,07);
            FRegCieloPgto[intPosicaoAtual-1].fltValTot := fGetDados(114,14,True);
            FRegCieloPgto[intPosicaoAtual-1].fltValPro := fGetDados(114,14,True);
            FRegCieloPgto[intPosicaoAtual-1].strNum_NF := '0';
            FRegCieloPgto[intPosicaoAtual-1].strNumTer := '0';

            FRegCieloPgto[intPosicaoAtual-1].CalculaLiqDeb := False;
          End;
        End;

        If (fGetDados(001,01) = '1') Then
          FRegCieloPgto[intPosicaoAtual-1].strTipCar := fRetornaTipCar(fGetDados(233,03))
        Else
          FRegCieloPgto[intPosicaoAtual-1].strTipCar := 'A';
        FRegCieloPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
        FRegCieloPgto[intPosicaoAtual-1].strNomArq := strNomArq;
        FRegCieloPgto[intPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
      End
      Else If (fGetDados(001,01) = '2') Then
      Begin
        If (strRegAnt = '2') Then
        Begin
          FRegCieloPgto[intPosicaoAtual-1].strTipTra := FRegCieloPgto[intPosicaoAtual-2].strTipTra;
          FRegCieloPgto[intPosicaoAtual-1].strTipReg := FRegCieloPgto[intPosicaoAtual-2].strTipReg;
          FRegCieloPgto[intPosicaoAtual-1].strDtaApr := FRegCieloPgto[intPosicaoAtual-2].strDtaApr;
          FRegCieloPgto[intPosicaoAtual-1].strDtaPag := FRegCieloPgto[intPosicaoAtual-2].strDtaPag;
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Bru := FRegCieloPgto[intPosicaoAtual-2].fltRO_Bru;
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Com := FRegCieloPgto[intPosicaoAtual-2].fltRO_Com;
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Rej := FRegCieloPgto[intPosicaoAtual-2].fltRO_Rej;
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Liq := FRegCieloPgto[intPosicaoAtual-2].fltRO_Liq;
          FRegCieloPgto[intPosicaoAtual-1].strCodBco := FRegCieloPgto[intPosicaoAtual-2].strCodBco;
          FRegCieloPgto[intPosicaoAtual-1].strCodAge := FRegCieloPgto[intPosicaoAtual-2].strCodAge;
          FRegCieloPgto[intPosicaoAtual-1].strNumCco := FRegCieloPgto[intPosicaoAtual-2].strNumCco;
          FRegCieloPgto[intPosicaoAtual-1].strStatus := FRegCieloPgto[intPosicaoAtual-2].strStatus;
          FRegCieloPgto[intPosicaoAtual-1].strNumAnt := FRegCieloPgto[intPosicaoAtual-2].strNumAnt;
          FRegCieloPgto[intPosicaoAtual-1].fltBruAnt := FRegCieloPgto[intPosicaoAtual-2].fltBruAnt;
          FRegCieloPgto[intPosicaoAtual-1].strTipCar := FRegCieloPgto[intPosicaoAtual-2].strTipCar;
          FRegCieloPgto[intPosicaoAtual-1].strTipFin := FRegCieloPgto[intPosicaoAtual-2].strTipFin;
          FRegCieloPgto[intPosicaoAtual-1].strDtaArq := FRegCieloPgto[intPosicaoAtual-2].strDtaArq;
          FRegCieloPgto[intPosicaoAtual-1].strNomArq := FRegCieloPgto[intPosicaoAtual-2].strNomArq;
          FRegCieloPgto[intPosicaoAtual-1].strDtaAnt := FRegCieloPgto[intPosicaoAtual-2].strDtaAnt;
          FRegCieloPgto[intPosicaoAtual-1].fltLiqAnt := FRegCieloPgto[intPosicaoAtual-2].fltLiqAnt;
          FRegCieloPgto[intPosicaoAtual-1].strRO_Deb := FRegCieloPgto[intPosicaoAtual-2].strRO_Deb;

          FRegCieloPgto[intPosicaoAtual-1].CodigoBandeira := FRegCieloPgto[intPosicaoAtual-2].CodigoBandeira;
          FRegCieloPgto[intPosicaoAtual-1].CodigoProduto := FRegCieloPgto[intPosicaoAtual-2].CodigoProduto;
          FRegCieloPgto[intPosicaoAtual-1].OrigemAjuste := FRegCieloPgto[intPosicaoAtual-2].OrigemAjuste;
          FRegCieloPgto[intPosicaoAtual-1].VencimentoOriginal := FRegCieloPgto[intPosicaoAtual-2].VencimentoOriginal;
          FRegCieloPgto[intPosicaoAtual-1].VersaoArquivo := FRegCieloPgto[intPosicaoAtual-2].VersaoArquivo;
        End;

        FRegCieloPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,10);
        FRegCieloPgto[intPosicaoAtual-1].strNum_RO := fGetDados(012,07);
        FRegCieloPgto[intPosicaoAtual-1].strNumCar := fGetDados(019,19);
        FRegCieloPgto[intPosicaoAtual-1].strDtaVen := fGetDados(038,08);
        FRegCieloPgto[intPosicaoAtual-1].fltValPar := fGetDados(047,13,True);
        FRegCieloPgto[intPosicaoAtual-1].strNumPar := fGetDados(060,02);
        FRegCieloPgto[intPosicaoAtual-1].strTotPar := fGetDados(062,02);
        FRegCieloPgto[intPosicaoAtual-1].strCodAut := fGetDados(067,06);
        FRegCieloPgto[intPosicaoAtual-1].strCodPid := fGetDados(073,20);
        FRegCieloPgto[intPosicaoAtual-1].strNumNSU := fGetDados(093,06);
        FRegCieloPgto[intPosicaoAtual-1].fltValTot := fGetDados(114,13,True);
        FRegCieloPgto[intPosicaoAtual-1].fltValPro := fGetDados(127,13,True);
        FRegCieloPgto[intPosicaoAtual-1].strNum_NF := fGetDados(140,09);
        FRegCieloPgto[intPosicaoAtual-1].strNumTer := fGetDados(153,08);

        If (FRegCieloPgto[intPosicaoAtual-1].strTipTra = '04') Then
        Begin
          If FRegCieloPgto[intPosicaoAtual-1].strCodAut = '000000' Then
          Begin
            Inc(ContadorAjusteTipo04);

            FRegCieloPgto[intPosicaoAtual-1].strCodAut := TCieloFuncoes.fStrZero(IntToStr(ContadorAjusteTipo04), 6);
          End;
        End;

        FRegCieloPgto[intPosicaoAtual-1].CalculaLiqDeb := True;
      End
      Else If MatchStr(fGetDados(001,01), ['A', 'B']) Then
      Begin
        If fGetDados(001,01) = 'A' Then
        Begin
          strCodigoLiquidacao := fGetDados(064,20);
          strDataPagamento := fGetDados(008,06);
          strDataNegociacao := fGetDados(002,06);
        End
        Else
        Begin
          FRegCieloPgto[intPosicaoAtual-1].strTipReg := fGetDados(001,01);
          FRegCieloPgto[intPosicaoAtual-1].strTipTra := RightStr(fGetDados(031,03), 2);
          FRegCieloPgto[intPosicaoAtual-1].strDtaApr := strDataNegociacao;
          FRegCieloPgto[intPosicaoAtual-1].strDtaPag := strDataPagamento;
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Bru := fGetDados(034,14,True);
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Com := fGetDados(062,05,True);
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Rej := 0;
          FRegCieloPgto[intPosicaoAtual-1].fltRO_Liq := fGetDados(048,14,True);
          FRegCieloPgto[intPosicaoAtual-1].strStatus := '01';
          FRegCieloPgto[intPosicaoAtual-1].strTipFin := '';
          FRegCieloPgto[intPosicaoAtual-1].strNum_RO := RightStr(strCodigoLiquidacao,07);

          FRegCieloPgto[intPosicaoAtual-1].strCodEst := strEstabelecimentoHeader;
          FRegCieloPgto[intPosicaoAtual-1].strDtaVen := strDataNegociacao;
          FRegCieloPgto[intPosicaoAtual-1].fltValPar := fGetDados(034,14,True);
          FRegCieloPgto[intPosicaoAtual-1].strNumPar := '01';
          FRegCieloPgto[intPosicaoAtual-1].strTotPar := '01';
          FRegCieloPgto[intPosicaoAtual-1].strCodAut := TCieloFuncoes.fPadL(IntToStr(ContadorAjustes), 6, '0');
          FRegCieloPgto[intPosicaoAtual-1].strCodPid := strCodigoLiquidacao;
          FRegCieloPgto[intPosicaoAtual-1].strNumNSU := TCieloFuncoes.fPadL(IntToStr(ContadorAjustes), 6, '0');
          FRegCieloPgto[intPosicaoAtual-1].fltValTot := fGetDados(034,14,True);
          FRegCieloPgto[intPosicaoAtual-1].fltValPro := fGetDados(034,14,True);
          FRegCieloPgto[intPosicaoAtual-1].fltLiqDeb := fGetDados(048,14,True);
          FRegCieloPgto[intPosicaoAtual-1].strTipCar := ' ';
          FRegCieloPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
          FRegCieloPgto[intPosicaoAtual-1].strNomArq := strNomArq;
          FRegCieloPgto[intPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
          FRegCieloPgto[intPosicaoAtual-1].CodigoBandeira := fGetDados(028,03);
          FRegCieloPgto[intPosicaoAtual-1].VencimentoOriginal := fGetDados(008,06);

          FRegCieloPgto[intPosicaoAtual-1].fltRO_Com := FRegCieloPgto[intPosicaoAtual-1].fltRO_Com / 10;

          Inc(ContadorAjustes);
        End;
      End
      Else If fGetDados(001,01) = '3' Then
      Begin
        FRegCieloPgto[intPosicaoAtual-1].strTipReg := fGetDados(001,01);
        FRegCieloPgto[intPosicaoAtual-1].strTipTra := RightStr(fGetDados(095,03), 2);
        FRegCieloPgto[intPosicaoAtual-1].strDtaApr := fGetDados(082,08);
        FRegCieloPgto[intPosicaoAtual-1].strDtaPag := fGetDados(074,08);
        FRegCieloPgto[intPosicaoAtual-1].fltRO_Bru := fGetDados(098,18,True);
        FRegCieloPgto[intPosicaoAtual-1].fltRO_Com := 0;
        FRegCieloPgto[intPosicaoAtual-1].fltRO_Rej := 0;
        FRegCieloPgto[intPosicaoAtual-1].fltRO_Liq := fGetDados(098,18,True);
        FRegCieloPgto[intPosicaoAtual-1].strStatus := '01';
        FRegCieloPgto[intPosicaoAtual-1].strTipFin := '';
        FRegCieloPgto[intPosicaoAtual-1].strNum_RO := RightStr(fGetDados(012,20),07);

        FRegCieloPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,10);
        FRegCieloPgto[intPosicaoAtual-1].strDtaVen := fGetDados(082,08);
        FRegCieloPgto[intPosicaoAtual-1].fltValPar := fGetDados(098,18,True);
        FRegCieloPgto[intPosicaoAtual-1].strNumPar := '01';
        FRegCieloPgto[intPosicaoAtual-1].strTotPar := '01';
        FRegCieloPgto[intPosicaoAtual-1].strCodAut := TCieloFuncoes.fPadL(IntToStr(ContadorGravame), 6, '0');
        FRegCieloPgto[intPosicaoAtual-1].strNumNSU := RightStr(fGetDados(012,20),06);
        FRegCieloPgto[intPosicaoAtual-1].strCodPid := fGetDados(012,20);
        FRegCieloPgto[intPosicaoAtual-1].fltValTot := fGetDados(098,18,True);
        FRegCieloPgto[intPosicaoAtual-1].fltValPro := fGetDados(098,18,True);
        FRegCieloPgto[intPosicaoAtual-1].fltLiqDeb := fGetDados(098,18,True);
        FRegCieloPgto[intPosicaoAtual-1].TipoNegociacao := fGetDados(090,02);
        FRegCieloPgto[intPosicaoAtual-1].CodigoBandeira := fGetDados(092,03);
        FRegCieloPgto[intPosicaoAtual-1].VencimentoOriginal := fGetDados(082,08);
        FRegCieloPgto[intPosicaoAtual-1].strTipCar := ' ';
        FRegCieloPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
        FRegCieloPgto[intPosicaoAtual-1].strNomArq := strNomArq;
        FRegCieloPgto[intPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;

        Inc(ContadorGravame);
      End
      Else If fGetDados(001,01) = '8' Then
      Begin
        FRegCieloPgto[intPosicaoAtual-1].strTipReg := fGetDados(001,01);
        FRegCieloPgto[intPosicaoAtual-1].strTipTra := fGetDados(012,02);
        FRegCieloPgto[intPosicaoAtual-1].strDtaApr := fGetDados(014,06);
        FRegCieloPgto[intPosicaoAtual-1].strDtaPag := fGetDados(068,06);
        FRegCieloPgto[intPosicaoAtual-1].fltRO_Bru := fGetDados(074,14,True);
        FRegCieloPgto[intPosicaoAtual-1].fltRO_Com := fGetDados(156,04,True);
        FRegCieloPgto[intPosicaoAtual-1].fltRO_Rej := 0;
        FRegCieloPgto[intPosicaoAtual-1].fltRO_Liq := fGetDados(102,14,True);
        FRegCieloPgto[intPosicaoAtual-1].strStatus := '01';
        FRegCieloPgto[intPosicaoAtual-1].strTipFin := '';
        FRegCieloPgto[intPosicaoAtual-1].strNum_RO := fGetDados(062,06);

        FRegCieloPgto[intPosicaoAtual-1].strCodEst := fGetDados(002,10);
        FRegCieloPgto[intPosicaoAtual-1].strDtaVen := fGetDados(145,06);
        FRegCieloPgto[intPosicaoAtual-1].fltValPar := fGetDados(074,14,True);
        FRegCieloPgto[intPosicaoAtual-1].strNumPar := '01';
        FRegCieloPgto[intPosicaoAtual-1].strTotPar := '01';
        FRegCieloPgto[intPosicaoAtual-1].strCodAut := fGetDados(026,36);
        FRegCieloPgto[intPosicaoAtual-1].strNumNSU := fGetDados(062,06);
        FRegCieloPgto[intPosicaoAtual-1].strCodPid := '';
        FRegCieloPgto[intPosicaoAtual-1].fltValTot := fGetDados(074,14,True);
        FRegCieloPgto[intPosicaoAtual-1].fltValPro := fGetDados(074,14,True);

        FRegCieloPgto[intPosicaoAtual-1].strCodBco := fGetDados(116,04);
        FRegCieloPgto[intPosicaoAtual-1].strCodAge := fGetDados(120,05);
        FRegCieloPgto[intPosicaoAtual-1].strNumCco := fGetDados(125,20);
        FRegCieloPgto[intPosicaoAtual-1].strNumTer := fGetDados(162,08);

        FRegCieloPgto[intPosicaoAtual-1].OrigemAjuste := fGetDados(220,02);
        If FRegCieloPgto[intPosicaoAtual-1].OrigemAjuste <> '' Then
          FRegCieloPgto[intPosicaoAtual-1].fltLiqDeb := fGetDados(102,14,True);

        FRegCieloPgto[intPosicaoAtual-1].strTipCar := 'PX';
        FRegCieloPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
        FRegCieloPgto[intPosicaoAtual-1].strNomArq := strNomArq;
        FRegCieloPgto[intPosicaoAtual-1].VersaoArquivo := FVersaoArquivo;
      End;
    End;

    If (intPosicaoAtual > 0) And (FRegCieloPgto[intPosicaoAtual-1].strCodEst <> '') Then
    Begin
      If (VS_ListaEstabelecimentos.IndexOf(FRegCieloPgto[intPosicaoAtual-1].strCodEst) < 0) Then
        VS_ListaEstabelecimentos.Add(FRegCieloPgto[intPosicaoAtual-1].strCodEst);

      If FListaVersao014.IndexOf(Concat(FRegCieloPgto[intPosicaoAtual-1].strCodEst, '|',
                                        FRegCieloPgto[intPosicaoAtual-1].strDtaPag)) < 0 Then
        FListaVersao014.Add(Concat(FRegCieloPgto[intPosicaoAtual-1].strCodEst, '|',
                                   FRegCieloPgto[intPosicaoAtual-1].strDtaPag));
    End;

    strRegAnt := fGetDados(001,01);
    If (strRegAnt <> '0') And (intPosicaoAtual > 0) Then
      strRO_Ant := FRegCieloPgto[intPosicaoAtual-1].strNum_RO;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao importar os registros do arquivo ' + strNomArq + '.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TCieloPgto.fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
Begin
  If TCieloFuncoes.fEmptyStr(strVal) Then
    Exit(Null);

  Result := strVal;
  If blnData Then
  Begin
    If Length(strVal) = 8 Then
      Exit(Copy(strVal, 1, 4) + '/' + Copy(strVal, 5, 2) + '/' + Copy(strVal, 7, 2));

    Result := Copy(strVal, 1, 2) + '/' + Copy(strVal, 3, 2) + '/' + Copy(strVal, 5, 2);
  End;
End;

procedure TCieloPgto.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    LInserir: TUniQuery;
    LRegistrosPagos: TUniQuery;
    intCont  : Integer;
    LSQL   : String;
    
    LValidaIndice,
    LNegociacao,
    LAjustes: TUniQuery;
begin
  LValidaIndice := Nil;
  Try
    Try
      LValidaIndice := VS_FuncoesExternas.fICriaQuery;
      LValidaIndice.SQL.Text := 'SHOW INDEX FROM CIE_CIPGTO WHERE KEY_NAME="IDX_CIE_CIPGTO_20"';
      LValidaIndice.Open;

      If LValidaIndice.IsEmpty Then
      Begin
        LValidaIndice.Close;
        LValidaIndice.SQL.Text := 'ALTER TABLE CIE_CIPGTO  ' +
                                  ' ADD INDEX IDX_CIE_CIPGTO_20(CIE_DTAPAG,CIE_CODEST,CIE_TIPREG,CIE_CODTID,CIE_VENORI,CIE_CODBAN,CIE_RO_LIQ)';
        LValidaIndice.ExecSQL;
      End;
    Except
      //Não pode parar o processamento da rotina
    End;
  Finally
    TCieloFuncoes.FreeAndNilDatasets(LValidaIndice);
  End;

  LRegistrosPagos := Nil;
  LNegociacao := Nil;
  LAjustes := Nil;
  LInserir := Nil;

  Try
    Try
      LRegistrosPagos := VS_FuncoesExternas.fICriaQuery;
      LNegociacao := VS_FuncoesExternas.fICriaQuery;
      LAjustes := VS_FuncoesExternas.fICriaQuery;


      LRegistrosPagos.SQL.Text := 'SELECT * FROM CIE_CIPGTO WHERE ' +
                                  ' CIE_DTAPAG = :DTAPAG AND  ' +
                                  ' CIE_CODEST = :CODEST AND  ' +
                                  ' CIE_CODAUT = :CODAUT AND  ' +
                                  ' CIE_NUMPAR = :NUMPAR AND  ' +
                                  ' CIE_DTAVEN = :DTAVEN AND  ' +
                                  ' CIE_TIPTRA = :TIPTRA AND  ' +
                                  ' CIE_STATUS="01"           ';

      LNegociacao.SQL.Text := 'SELECT * FROM CIE_CIPGTO WHERE ' +
                              ' CIE_DTAPAG = :DTAPAG AND  ' +
                              ' CIE_CODEST = :CODEST AND  ' +
                              ' CIE_TIPREG = "B" AND      ' +
                              ' CIE_CODTID = :CODTID AND  ' +
                              ' CIE_VENORI = :VENORI AND  ' +
                              ' CIE_CODBAN = :CODBAN AND  ' +
                              ' CIE_RO_LIQ = :RO_LIQ      ';


      LAjustes.SQL.Text := 'SELECT * FROM CIE_CIPGTO A WHERE ' +
                           ' ( ' +
                           '   ( ' +
                           '    (CIE_TIPNEG IS NULL OR CIE_TIPNEG <> "CE") AND' +
                           '    (CIE_DTAPAG = :DTAPAG) ' +
                           '   ) OR ' +
                           '   (CIE_TIPNEG = "CE" AND CIE_DTAAPR = :DTAAPR) ' +
                           ' ) AND ' +
                           ' (CIE_VERARQ IS NULL OR CIE_VERARQ <> "015") AND ' +
                           ' ( ' +
                           '   (CIE_TIPREG = "8" AND CIE_ORIAJU) OR ' +
                           '   (CIE_TIPREG NOT IN ("3", "B") AND CIE_TIPTRA IN ("03", "04", "02") ' +
                           '   AND CIE_STATUS = "01" AND A.CIE_RO_LIQ <> 0 AND ' +
                           '   NOT (A.CIE_ORIAJU = "51" AND A.CIE_CODAUT = "000000" AND A.CIE_NUMNSU = "000000") AND ' +
                           '   (SELECT COUNT(F.CIE_CODAUT) FROM CIE_CIPGTO F ' +
                           '   WHERE F.CIE_TIPTRA NOT IN ("03", "04", "02") AND CIE_STATUS = "01" ' +
                           '   AND CIE_CODEST = A.CIE_CODEST AND CIE_CODAUT = A.CIE_CODAUT ' +
                           '   AND CIE_NUM_RO = A.CIE_NUM_RO AND IF(A.CIE_NUMPAR <> "00", CIE_NUMPAR = A.CIE_NUMPAR, TRUE) ' +
                           '   AND CIE_DTAVEN = A.CIE_DTAVEN AND CIE_DTAPAG = A.CIE_DTAPAG) = 0 ' +
                           ' ) ' +
                           ' ) AND ' +
                           ' CIE_CODEST = :CODEST AND ' +
                           ' CIE_CODAUT = :CODAUT AND ' +
                           ' CIE_NUMPAR = :NUMPAR AND ' +
                           ' CIE_DTAVEN = :DTAVEN AND ' +
                           ' CIE_NUM_RO = :NUM_RO AND ' +
                           ' CIE_NUMNSU = :NUMNSU AND ' +
                           ' CIE_VALPAR = :VALPAR AND ' +
                           ' CIE_CONCIL = 1 ';


      LSQL := TCieloFuncoes.RetornaSQLReplace('CIE_CIPGTO', ['CIE_CONCIL']);

      LInserir := VS_FuncoesExternas.fICriaQuery;

      LInserir.SQL.Text := LSQL;

      pgbProg.Position := 0;

      If ExistemRegistrosdaVersao015ParaADataSelecionada Then
        Exit;

      If Length(FRegCieloPgto) > 0 Then
      Begin
        pgbProg.Properties.Max := Length(FRegCieloPgto);
        For intCont := 0 To Length(FRegCieloPgto) - 1 Do
        Begin
          If ((FRegCieloPgto[intCont].strTipReg <> '') And (MatchStr(FRegCieloPgto[intCont].strTipReg, ['1', '6', '7', '3', '8', 'B'])) And
             (FRegCieloPgto[intCont].strCodEst <> '')) Then
          Begin
            LRegistrosPagos.Close;
            LNegociacao.Close;

            If Not Concat(fRetVal(FRegCieloPgto[intCont].strStatus),
                          fRetVal(FRegCieloPgto[intCont].strTipReg)).Equals('01B') Then
            Begin
              TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'CODEST', fRetVal(FRegCieloPgto[intCont].strCodEst));
              TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'CODAUT', fRetVal(FRegCieloPgto[intCont].strCodAut));
              TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'NUMPAR', fRetVal(FRegCieloPgto[intCont].strNumPar));
              TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'DTAPAG', fRetVal(FRegCieloPgto[intCont].strDtaPag, True));
              TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'DTAVEN', fRetVal(FRegCieloPgto[intCont].strDtaVen, True));
              TCieloFuncoes.CarregaParametroDataset(LRegistrosPagos, 'TIPTRA', fRetVal(FRegCieloPgto[intCont].strTipTra));
              LRegistrosPagos.Open;
            End;

            If (fRetVal(FRegCieloPgto[intCont].strTipReg) = 'B') Then
            Begin
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'CODEST', fRetVal(FRegCieloPgto[intCont].strCodEst));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'DTAPAG', fRetVal(FRegCieloPgto[intCont].strDtaPag, True));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'CODTID', fRetVal(FRegCieloPgto[intCont].strCodPid));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'VENORI', fRetVal(FRegCieloPgto[intCont].VencimentoOriginal, True));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'CODBAN', fRetVal(FRegCieloPgto[intCont].CodigoBandeira));
              TCieloFuncoes.CarregaParametroDataset(LNegociacao, 'RO_LIQ', fRetVal(FRegCieloPgto[intCont].fltRo_Liq));
              LNegociacao.Open;

              If Not LNegociacao.IsEmpty Then
              Begin
                LNegociacao.Edit;
                LNegociacao.FieldByName('CIE_CONCIL').AsInteger := 0;
                LNegociacao.Post;
              End;
            End;

            if EhAjuste(FRegCieloPgto[intCont]) then
            begin
              LAjustes.Close;
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'DTAPAG', fRetVal(FRegCieloPgto[intCont].strDtaPag, True));
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'DTAAPR', fRetVal(FRegCieloPgto[intCont].strDtaApr, True));
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'CODEST', fRetVal(FRegCieloPgto[intCont].strCodEst));
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'CODAUT', fRetVal(FRegCieloPgto[intCont].strCodAut));
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'NUMPAR', fRetVal(FRegCieloPgto[intCont].strNumPar));
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'DTAVEN', fRetVal(FRegCieloPgto[intCont].strDtaVen, True));
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'NUM_RO', fRetVal(FRegCieloPgto[intCont].strNum_RO));
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'NUMNSU', fRetVal(FRegCieloPgto[intCont].strNumNSU));
              TCieloFuncoes.CarregaParametroDataset(LAjustes, 'VALPAR', fRetVal(FRegCieloPgto[intCont].fltValPar));
              LAjustes.Open;
            end;

            If GravarRegistro(FRegCieloPgto[intCont],
                              LRegistrosPagos,
                              LNegociacao,
                              LAjustes) Then
            Begin
              LInserir.Close;

              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPREG', fRetVal(FRegCieloPgto[intCont].strTipReg));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODEST', fRetVal(FRegCieloPgto[intCont].strCodEst));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUM_RO', fRetVal(FRegCieloPgto[intCont].strNum_RO));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAAPR', fRetVal(FRegCieloPgto[intCont].strDtaApr, True));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAPAG', fRetVal(FRegCieloPgto[intCont].strDtaPag, True));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODBCO', fRetVal(FRegCieloPgto[intCont].strCodBco));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODAGE', fRetVal(FRegCieloPgto[intCont].strCodAge));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMCCO', fRetVal(FRegCieloPgto[intCont].strNumCco));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_BRU', fRetVal(FRegCieloPgto[intCont].fltRO_Bru));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_LIQ', fRetVal(FRegCieloPgto[intCont].fltRO_Liq));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_COM', fRetVal(FRegCieloPgto[intCont].fltRO_Com));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_REJ', fRetVal(FRegCieloPgto[intCont].fltRO_Rej));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_STATUS', fRetVal(FRegCieloPgto[intCont].strStatus));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_PORCOM', fRetVal(FRegCieloPgto[intCont].fltPorCom));

              If (FRegCieloPgto[intCont].strNumAnt <> '') Then
                TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMANT', fRetVal(FRegCieloPgto[intCont].strNumAnt));
              If (FRegCieloPgto[intCont].fltBruAnt > 0) Then
                TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_BRUANT', fRetVal(FRegCieloPgto[intCont].fltBruAnt));

              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMNSU', fRetVal(FRegCieloPgto[intCont].strNumNSU));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAVEN', fRetVal(FRegCieloPgto[intCont].strDtaVen, True));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMCAR', fRetVal(FRegCieloPgto[intCont].strNumCar));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VALTOT', fRetVal(FRegCieloPgto[intCont].fltValTot));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TOTPAR', fRetVal(FRegCieloPgto[intCont].strTotPar));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMPAR', fRetVal(FRegCieloPgto[intCont].strNumPar));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VALPAR', fRetVal(FRegCieloPgto[intCont].fltValPar));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VALPRO', fRetVal(FRegCieloPgto[intCont].fltValPro));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODAUT', fRetVal(FRegCieloPgto[intCont].strCodAut));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODTID', fRetVal(FRegCieloPgto[intCont].strCodPid));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUMTER', fRetVal(FRegCieloPgto[intCont].strNumTer));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPCAR', fRetVal(FRegCieloPgto[intCont].strTipCar));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPFIN', fRetVal(FRegCieloPgto[intCont].strTipFin));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPTRA', fRetVal(FRegCieloPgto[intCont].strTipTra));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NUM_NF', fRetVal(FRegCieloPgto[intCont].strNum_NF));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_NOMARQ', fRetVal(FRegCieloPgto[intCont].strNomArq));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAARQ', fRetVal(FRegCieloPgto[intCont].strDtaArq, True));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_DTAANT', fRetVal(FRegCieloPgto[intCont].strDtaAnt, True));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_LIQANT', fRetVal(FRegCieloPgto[intCont].fltLiqAnt));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_RO_DEB', fRetVal(FRegCieloPgto[intCont].strRO_Deb));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_ORIAJU', fRetVal(FRegCieloPgto[intCont].OrigemAjuste));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODBAN', fRetVal(FRegCieloPgto[intCont].CodigoBandeira));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_CODPRO', fRetVal(FRegCieloPgto[intCont].CodigoProduto));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_TIPNEG', fRetVal(FRegCieloPgto[intCont].TipoNegociacao));
              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VENORI', fRetVal(FRegCieloPgto[intCont].VencimentoOriginal, True));

              If FRegCieloPgto[intCont].strTipReg = '7' Then
              Begin
                FRegCieloPgto[intCont].fltLiqDeb := FRegCieloPgto[intCont].fltRO_Liq;

                If FRegCieloPgto[intCont].CalculaLiqDeb Then
                Begin
                  FRegCieloPgto[intCont].fltLiqDeb := (SimpleRoundTo(FRegCieloPgto[intCont].fltRO_Liq *
                                                                (FRegCieloPgto[intCont].fltValPar /
                                                                 LInserir.ParamByName('CIE_BRUANT').Value), -2)) * (-1);
                End;
              End;

              TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_LIQDEB', fRetVal(FRegCieloPgto[intCont].fltLiqDeb));

              If (Pos('CIE_VERARQ', LSQL) > 0) Then
                TCieloFuncoes.CarregaParametroDataset(LInserir, 'CIE_VERARQ', fRetVal(FRegCieloPgto[intCont].VersaoArquivo));
            
              LInserir.ExecSQL;
              LRegistrosPagos.Close;
            End;
          End;

          TCieloFuncoes.pStepStatusGravacao(pgbProg);
        End;
      End;

      SetLength(FRegCieloPgto, 0);
      TCieloFuncoes.GravarEstabelecimentos;
    Finally
      TCieloFuncoes.FreeAndNilDatasets(LRegistrosPagos);
      TCieloFuncoes.FreeAndNilDatasets(LNegociacao);
      TCieloFuncoes.FreeAndNilDatasets(LAjustes);
      TCieloFuncoes.FreeAndNilDatasets(LInserir);
    End;
    pgbProg.Position := pgbProg.Properties.Max;
    Application.ProcessMessages;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar os registros. Erro gerado: ' + E.Message);
  End;
end;

end.
