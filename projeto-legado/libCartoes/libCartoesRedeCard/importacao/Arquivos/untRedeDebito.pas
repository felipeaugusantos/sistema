unit untRedeDebito;

Interface

Uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms,

     cxProgressBar,

     untIRedeCardIntegracaoLibCartoes, untRedeCardTipos;

Type
  TRedeDebito = Class(TInterfacedObject, ICartoes)
  Private
    function fRetVal(strVal: String; ATipoData: Boolean = False): Variant;
  Public
    constructor Create;
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    procedure LimparImportacoes;

    class function fRetSQLTabelaReg5: String;
    class function fRetEstruturaReg05: TArrEstruturaReg05;
  End;

Var
  strNomArq: String;
  strDtaArq: String;
  VersaoMenil: Boolean;
  Contador11: Integer;

  intPosicaoAtualFReg5: Integer;

  FReg5: TArrRegistro5;

implementation

uses untTRedeCardFuncoes, Uni;

{ TRedeDebito }

constructor TRedeDebito.Create;
begin
  intPosicaoAtualFReg5 := 0;
  Contador11 := 0;
end;

{********************************************}
{* RETORNA A ESTRUTURA DA TABELA RED_EVDR05 *}
{*REQ. 32397 02/04/2015*******************JU*}
class function TRedeDebito.fRetEstruturaReg05: TArrEstruturaReg05;
begin
  SetLength(Result, 27);

  Result[0].strDescri  := 'RED_TIPREG'; Result[0].strTipCmp  := 'CHAR(2)'      ;
  Result[1].strDescri  := 'RED_NUM_PV'; Result[1].strTipCmp  := 'VARCHAR(9)'   ;
  Result[2].strDescri  := 'RED_NUM_RV'; Result[2].strTipCmp  := 'VARCHAR(9)'   ;
  Result[3].strDescri  := 'RED_DTA_CV'; Result[3].strTipCmp  := 'DATE'         ;
  Result[4].strDescri  := 'RED_VALBRU'; Result[4].strTipCmp  := 'DECIMAL(13,2)';
  Result[5].strDescri  := 'RED_VALDES'; Result[5].strTipCmp  := 'DECIMAL(13,2)';
  Result[6].strDescri  := 'RED_VALLIQ'; Result[6].strTipCmp  := 'DECIMAL(13,2)';
  Result[7].strDescri  := 'RED_NUMCAR'; Result[7].strTipCmp  := 'VARCHAR(19)'  ;
  Result[8].strDescri  := 'RED_TIPTRA'; Result[8].strTipCmp  := 'CHAR(1)'      ;
  Result[9].strDescri  := 'RED_NUM_CV'; Result[9].strTipCmp  := 'VARCHAR(12)'  ;
  Result[10].strDescri := 'RED_DTACRE'; Result[10].strTipCmp := 'DATE'         ;
  Result[11].strDescri := 'RED_STSTRA'; Result[11].strTipCmp := 'CHAR(2)'      ;
  Result[12].strDescri := 'RED_HRATRA'; Result[12].strTipCmp := 'TIME'         ;
  Result[13].strDescri := 'RED_NUMTER'; Result[13].strTipCmp := 'VARCHAR(8)'   ;
  Result[14].strDescri := 'RED_TIPCAP'; Result[14].strTipCmp := 'CHAR(2)'      ;
  Result[15].strDescri := 'RED_NUMRES'; Result[15].strTipCmp := 'VARCHAR(5)'   ;
  Result[16].strDescri := 'RED_VALCOM'; Result[16].strTipCmp := 'DECIMAL(13,2)';
  Result[17].strDescri := 'RED_VALSAQ'; Result[17].strTipCmp := 'DECIMAL(13,2)';
  Result[18].strDescri := 'RED_CODBAN'; Result[18].strTipCmp := 'CHAR(1)'      ;
  Result[19].strDescri := 'RED_CODAUT'; Result[19].strTipCmp := 'VARCHAR(7)'   ;
  Result[20].strDescri := 'RED_BAIXAD'; Result[20].strTipCmp := 'CHAR(1)'      ;
  Result[21].strDescri := 'RED_SEQLOT'; Result[21].strTipCmp := 'VARCHAR(9)'   ;
  Result[22].strDescri := 'RED_DTAARQ'; Result[22].strTipCmp := 'DATE'         ;
  Result[23].strDescri := 'RED_NOMARQ'; Result[23].strTipCmp := 'VARCHAR(255)' ;
  Result[24].strDescri := 'RED_CONCIL'; Result[24].strTipCmp := 'INTEGER DEFAULT 0';
  Result[25].strDescri := 'RED_DTAIMP'; Result[25].strTipCmp := 'DATE'         ;
  Result[26].strDescri := 'RED_MOTAJU'; Result[26].strTipCmp := 'VARCHAR(28)'  ;


end;

class function TRedeDebito.fRetSQLTabelaReg5: String;
begin
  Result := 'CREATE TABLE RED_EVDR05(                ' +
            '  RED_TIPREG CHAR(02),                  ' +
            '  RED_NUM_PV VARCHAR(09),               ' +
            '  RED_NUM_RV VARCHAR(09),               ' +
            '  RED_DTA_CV DATE,                      ' +
            '  RED_VALBRU DECIMAL(13,2),             ' +
            '  RED_VALDES DECIMAL(13,2),             ' +
            '  RED_VALLIQ DECIMAL(13,2),             ' +
            '  RED_NUMCAR VARCHAR(19),               ' +
            '  RED_TIPTRA CHAR(01),                  ' +
            '  RED_NUM_CV VARCHAR(12),               ' +
            '  RED_DTACRE DATE,                      ' +
            '  RED_STSTRA CHAR(02),                  ' +
            '  RED_HRATRA TIME,                      ' +
            '  RED_NUMTER VARCHAR(08),               ' +
            '  RED_TIPCAP CHAR(02),                  ' +
            '  RED_NUMRES VARCHAR(05),               ' +
            '  RED_VALCOM DECIMAL(13,2),             ' +
            '  RED_VALSAQ DECIMAL(13,2),             ' +
            '  RED_CODBAN CHAR(01),                  ' +
            '  RED_CODAUT VARCHAR(07),               ' +
            '  RED_BAIXAD CHAR(01),                  ' +
            '  RED_SEQLOT VARCHAR(09),               ' +
            '  RED_DTAARQ DATE,                      ' +
            '  RED_NOMARQ VARCHAR(255),              ' +
            '  RED_CONCIL INTEGER DEFAULT 0,         ' +
            '  RED_DTAIMP DATE,                      ' +
            '  RED_MOTAJU VARCHAR(28),               ' +
            '  PRIMARY KEY(RED_NUM_PV,               ' +
            '              RED_NUM_RV,               ' +
            '              RED_NUM_CV,               ' +
            '              RED_TIPREG,               ' +
            '              RED_DTACRE)) ENGINE INNODB';
end;

procedure TRedeDebito.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG5 = 2000;
  Var
    intPosVir: Integer;

    LValores : TStringList;

    function fGetDados: String;
    Begin
      intPosVir := Pos(',', strString);
      Result := Copy(strString, 1, intPosVir-1);
    End;

    procedure pProxRegistro;
    Begin
      Delete(strString, 1, intPosVir);
    End;

begin
  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  If LeftStr(strString, 2) = '05' Then
  Begin

    If intPosicaoAtualFReg5 = Length(FReg5) Then
    Begin
      SetLength(FReg5, Length(FReg5)+AUMENTO_CAPACIDADE_FREG5);
    End;

    FReg5[intPosicaoAtualFReg5].strTipReg := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNum_PV := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNum_RV := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strDta_CV := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValBru := TRedeCardFuncoes.fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValDes := TRedeCardFuncoes.fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValLiq := TRedeCardFuncoes.fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNumCar := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strTipTra := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNum_CV := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strDtaCre := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strStsTra := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strHraTra := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNumTer := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strTipCap := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strNumRes := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValCom := TRedeCardFuncoes.fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].fltValSaq := TRedeCardFuncoes.fStrToFloat(fGetDados)/100; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strCodBan := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strCodAut := fGetDados; pProxRegistro;
    FReg5[intPosicaoAtualFReg5].strBaixad := 'N';
    FReg5[intPosicaoAtualFReg5].strSeqLot := '';
    FReg5[intPosicaoAtualFReg5].strNomArq := strNomArq;
    FReg5[intPosicaoAtualFReg5].strDtaArq := strDtaArq;
    FReg5[intPosicaoAtualFReg5].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

    If (FReg5[intPosicaoAtualFReg5].strNum_PV <> '') And
       (VS_ListaEstabelecimentos.IndexOf(FReg5[intPosicaoAtualFReg5].strNum_PV) < 0) Then
      VS_ListaEstabelecimentos.Add(FReg5[intPosicaoAtualFReg5].strNum_PV);

    Inc(intPosicaoAtualFReg5);
  End;

  If Not VersaoMenil Then
    Exit;

  If LeftStr(strString, 3) = '011' Then
  Begin

    If intPosicaoAtualFReg5 = Length(FReg5) Then
    Begin
      SetLength(FReg5, Length(FReg5)+AUMENTO_CAPACIDADE_FREG5);
    End;

    Inc(Contador11);

    LValores := TStringList.Create;
    Try
      LValores.StrictDelimiter := True;
      LValores.Delimiter := ',';
      LValores.DelimitedText := strString;

      FReg5[intPosicaoAtualFReg5].strTipReg := RightStr(LValores[0], 2);
      FReg5[intPosicaoAtualFReg5].strNum_PV := LValores[1];
      FReg5[intPosicaoAtualFReg5].strNum_RV := LValores[2];
      FReg5[intPosicaoAtualFReg5].strDtaCre := LValores[3];
      FReg5[intPosicaoAtualFReg5].fltValBru := TRedeCardFuncoes.fStrToFloat(LValores[4])/100;
      FReg5[intPosicaoAtualFReg5].strTipTra := LValores[5];
      FReg5[intPosicaoAtualFReg5].strMotAju := LValores[7];
      FReg5[intPosicaoAtualFReg5].strNumCar := LValores[8];
      FReg5[intPosicaoAtualFReg5].strDta_CV := LValores[9];
      FReg5[intPosicaoAtualFReg5].fltValLiq := TRedeCardFuncoes.fStrToFloat(LValores[4])/100;
      FReg5[intPosicaoAtualFReg5].strNum_CV := LeftStr('000000000000', 12 - Length(IntToStr(Contador11))) + IntToStr(Contador11);

      If Not MatchStr(LValores[18], ['', '00000000']) Then
        FReg5[intPosicaoAtualFReg5].strDtaCre := LValores[18];

      FReg5[intPosicaoAtualFReg5].strStsTra := LValores[17];
      FReg5[intPosicaoAtualFReg5].strHraTra := '00:00:00';
      FReg5[intPosicaoAtualFReg5].strNumTer := '';
      FReg5[intPosicaoAtualFReg5].strTipCap := '';
      FReg5[intPosicaoAtualFReg5].strNumRes := LValores[10];
      FReg5[intPosicaoAtualFReg5].fltValCom := 0.00;
      FReg5[intPosicaoAtualFReg5].fltValSaq := 0.00;
      FReg5[intPosicaoAtualFReg5].strCodBan := LValores[28];
      FReg5[intPosicaoAtualFReg5].strCodAut := LValores[22];
      FReg5[intPosicaoAtualFReg5].strBaixad := 'N';
      FReg5[intPosicaoAtualFReg5].strSeqLot := '';
      FReg5[intPosicaoAtualFReg5].fltValDes := 0.00;
      FReg5[intPosicaoAtualFReg5].strNomArq := strNomArq;
      FReg5[intPosicaoAtualFReg5].strDtaArq := strDtaArq;
      FReg5[intPosicaoAtualFReg5].strDtaImp := FormatDateTime('yyyy-mm-dd', nOw);

      If (FReg5[intPosicaoAtualFReg5].strNum_PV <> '') And
         (VS_ListaEstabelecimentos.IndexOf(FReg5[intPosicaoAtualFReg5].strNum_PV) < 0) Then
        VS_ListaEstabelecimentos.Add(FReg5[intPosicaoAtualFReg5].strNum_PV);

      Inc(intPosicaoAtualFReg5);
    Finally
      FreeAndNil(LValores);
    End;
  End;
end;

function TRedeDebito.fRetVal(strVal: String; ATipoData: Boolean = False): Variant;
Begin
  If strVal.Trim.IsEmpty Then
    Exit(Null);

  Result := strVal;
  If Not ATipoData Then
    Exit;

  Result := RightStr(Result, 4) + '-' +
            Copy(Result, 3, 2) + '-' +
            LeftStr(Result, 2);
End;

procedure TRedeDebito.LimparImportacoes;
begin
  SetLength(FReg5, 0);
end;

procedure TRedeDebito.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    qryDados: TUniQuery;
    intCont : Integer;

    LDataImportacao: TDateTime;
begin
  qryDados := Nil;
  Try
    qryDados := VS_FuncoesExternas.fICriaQuery;
    qryDados.SQL.Text := TRedeCardFuncoes.RetornaSQLReplace('RED_EVDR05', ['RED_CONCIL']);

    If Length(FReg5) <= 0 Then
      Exit;

    pgbProg.Position := 0;
    pgbProg.Properties.Max := Length(FReg5)-1;

    LDataImportacao := TRedeCardFuncoes.RetornaDataHoraServidor;

    For intCont := 0 To Length(FReg5)-1 Do
    Begin
      If Not FReg5[intCont].strTipReg.IsEmpty Then
      Begin
        qryDados.Close;

        Try
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_TIPREG', fRetVal(FReg5[intCont].strTipReg));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_NUM_PV', fRetVal(FReg5[intCont].strNum_PV));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_NUM_RV', fRetVal(FReg5[intCont].strNum_RV));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_DTA_CV', fRetVal(FReg5[intCont].strDta_CV, True));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_VALBRU', FReg5[intCont].fltValBru);
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_VALDES', FReg5[intCont].fltValDes);
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_VALLIQ', FReg5[intCont].fltValLiq);
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_NUMCAR', fRetVal(FReg5[intCont].strNumCar));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_TIPTRA', fRetVal(FReg5[intCont].strTipTra));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_NUM_CV', fRetVal(FReg5[intCont].strNum_CV));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_DTACRE', fRetVal(FReg5[intCont].strDtaCre, True));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_STSTRA', fRetVal(FReg5[intCont].strStsTra));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_HRATRA', fRetVal(FReg5[intCont].strHraTra));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_NUMTER', fRetVal(FReg5[intCont].strNumTer));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_TIPCAP', fRetVal(FReg5[intCont].strTipCap));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_NUMRES', fRetVal(FReg5[intCont].strNumRes));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_VALCOM', FReg5[intCont].fltValCom);
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_VALSAQ', FReg5[intCont].fltValSaq);
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_CODBAN', fRetVal(FReg5[intCont].strCodBan));

          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_CODAUT', fRetVal(FReg5[intCont].strCodAut));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_BAIXAD', fRetVal(FReg5[intCont].strBaixad));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_SEQLOT', fRetVal(FReg5[intCont].strSeqLot));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_MOTAJU', fRetVal(FReg5[intCont].strMotAju));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_DTAARQ', fRetVal(FReg5[intCont].strDtaArq, True));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_NOMARQ', FReg5[intCont].strNomArq);
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_DTAIMP', fRetVal(FReg5[intCont].strDtaImp));
          TRedeCardFuncoes.CarregaParametroDataset(qryDados, 'RED_DTAGRV', LDataImportacao);

          qryDados.ExecSQL;
        Except
          On E: Exception Do
            Raise Exception.Create('Ocorreu um erro ao importar o arquivo do Registro 05 da Redecard.' +
                                   'Erro gerado: ' + E.Message);
        End;
      End;

      TRedeCardFuncoes.pStepStatusGravacao(pgbProg);
    End;

    TRedeCardFuncoes.GravarEstabelecimentos;

    pgbProg.Position := pgbProg.Properties.Max;
  Finally
    TRedeCardFuncoes.FreeAndNilDatasets(qryDados);
  End;
end;

end.
