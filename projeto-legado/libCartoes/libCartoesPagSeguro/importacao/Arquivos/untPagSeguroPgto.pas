{***************************************}
{* Importação de arquivos do PAGSEGURO *}
{************************************AJ*}
unit untPagSeguroPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms,

     cxProgressBar, Uni,

     untIPagSeguroIntegracaoLibCartoes, untTPagSeguroFuncoes, untPagSeguroTipos;

Type
  TPagSeguroPgto = Class(TInterfacedObject, ICartoes)
  Private
    dtaArq: String;

    intPosicaoAtual: Integer;

    function RetornaTipoDoRegistro(ATipoEvento: String; ALiquidoAntecipacao: Double): String;

    function ImportaRegistro(ARegistro: TRegistroPgto): Boolean;

    function fGetDados(AString: String; intIni, intTam: Integer; blnFlt: Boolean = False): Variant;
    function fRetVal(AValor: Variant; ACampoData: Boolean = False): Variant;
  Public
    constructor Create;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaPagSeguroPgto;
  End;

Const
  INICAM = 'PAG_';

Var
  strNomArq,
  strTipArq: String;

  ImportouPG: Boolean;

  FRegPagSeguroPgto: TArrRegistroPagSeguroPgto;

implementation

{ TPagSeguroPgto }

constructor TPagSeguroPgto.Create;
Begin
  intPosicaoAtual := 0;

  ImportouPG := False;
End;

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* PAG_SEPGTO                                   *}
{*********************************************AJ*}
function TPagSeguroPgto.fGetDados(AString: String; intIni, intTam: Integer;
  blnFlt: Boolean): Variant;
  Var
    LResultado: Variant;
begin
  LResultado := Trim(Copy(AString, intIni, intTam));

  If blnFlt Then
    LResultado := TPagSeguroFuncoes.fStrToFloat(LResultado) / 100;

  Result := LResultado;
end;

class function TPagSeguroPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaPagSeguroPgto;
Begin
  If strTabela = 'PAG_SEPGTO' Then
  Begin
    SetLength(Result, 31);

    Result[0].strDescri  := INICAM + 'TIPREG'; Result[0].strTipCmp  := 'VARCHAR(2)'   ;
    Result[1].strDescri  := INICAM + 'CODEST'; Result[1].strTipCmp  := 'VARCHAR(15)'  ;
    Result[2].strDescri  := INICAM + 'TIPEVE'; Result[2].strTipCmp  := 'VARCHAR(2)'   ;
    Result[3].strDescri  := INICAM + 'DTATRA'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := INICAM + 'DTAPAG'; Result[4].strTipCmp  := 'DATE'         ;
    Result[5].strDescri  := INICAM + 'DTAAJU'; Result[5].strTipCmp  := 'DATE'         ;
    Result[6].strDescri  := INICAM + 'CODAUT'; Result[6].strTipCmp  := 'VARCHAR(6)'   ;
    Result[7].strDescri  := INICAM + 'TIPTRA'; Result[7].strTipCmp  := 'VARCHAR(2)'   ;
    Result[8].strDescri  := INICAM + 'NUM_CV'; Result[8].strTipCmp  := 'VARCHAR(32)'  ;
    Result[9].strDescri  := INICAM + 'CODTRA'; Result[9].strTipCmp  := 'VARCHAR(32)'  ;
    Result[10].strDescri := INICAM + 'CODVEN'; Result[10].strTipCmp := 'VARCHAR(20)'  ;
    Result[11].strDescri := INICAM + 'VALBRU'; Result[11].strTipCmp := 'DECIMAL(15,2)';
    Result[12].strDescri := INICAM + 'VALPAR'; Result[12].strTipCmp := 'DECIMAL(15,2)';
    Result[13].strDescri := INICAM + 'TOTPAR'; Result[13].strTipCmp := 'VARCHAR(2)'   ;
    Result[14].strDescri := INICAM + 'NUMPAR'; Result[14].strTipCmp := 'VARCHAR(2)'   ;
    Result[15].strDescri := INICAM + 'VALLIQ'; Result[15].strTipCmp := 'DECIMAL(15,2)';
    Result[16].strDescri := INICAM + 'TAXANT'; Result[16].strTipCmp := 'DECIMAL(15,2)';
    Result[17].strDescri := INICAM + 'LIQANT'; Result[17].strTipCmp := 'DECIMAL(15,2)';
    Result[18].strDescri := INICAM + 'STAPAG'; Result[18].strTipCmp := 'VARCHAR(2)'   ;
    Result[19].strDescri := INICAM + 'MEIPAG'; Result[19].strTipCmp := 'VARCHAR(2)'   ;
    Result[20].strDescri := INICAM + 'NUMNSU'; Result[20].strTipCmp := 'VARCHAR(12)'  ;
    Result[21].strDescri := INICAM + 'NUMCAR'; Result[21].strTipCmp := 'VARCHAR(19)'  ;
    Result[22].strDescri := INICAM + 'NOMARQ'; Result[22].strTipCmp := 'VARCHAR(255)' ;
    Result[23].strDescri := INICAM + 'DTAARQ'; Result[23].strTipCmp := 'DATE'         ;
    Result[24].strDescri := INICAM + 'CONCIL'; Result[24].strTipCmp := 'INT DEFAULT 0';
    Result[25].strDescri := INICAM + 'PAGPRA'; Result[25].strTipCmp := 'VARCHAR(1)'   ;
    Result[26].strDescri := INICAM + 'CANENT'; Result[26].strTipCmp := 'VARCHAR(2)'   ;
    Result[27].strDescri := INICAM + 'MEICAP'; Result[27].strTipCmp := 'VARCHAR(2)'   ;
    Result[28].strDescri := INICAM + 'TAXINT'; Result[28].strTipCmp := 'DECIMAL(15,2)';
    Result[29].strDescri := INICAM + 'TAXPAR'; Result[29].strTipCmp := 'DECIMAL(15,2)';
    Result[30].strDescri := INICAM + 'PLANO_'; Result[30].strTipCmp := 'VARCHAR(2)'   ;
  End;
End;

class function TPagSeguroPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaPagSeguroPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(PAG_CODEST,PAG_TIPREG,PAG_DTAPAG,PAG_TIPEVE,PAG_DTATRA,PAG_CODAUT,PAG_NUMPAR,PAG_NUMNSU)) ENGINE INNODB ' ;
end;

function TPagSeguroPgto.ImportaRegistro(ARegistro: TRegistroPgto): Boolean;
begin
  Result := True;

  If ARegistro.strTipEve = '04' Then
    Exit;

  If ARegistro.strTipReg = '' Then
  Begin
    Result := False;
    Exit;
  End;

  If ARegistro.strCodEst = '' Then
  Begin
    Result := False;
    Exit;
  End;

  If ARegistro.strTipTra <> '09' Then
  Begin
    If ARegistro.strMeiPag = '00' Then
    Begin
      Result := False;
      Exit;
    End;
    If ARegistro.strTipTra <> '01' Then
    Begin
      If ARegistro.strCodVen = '' Then
      Begin
        Result := False;
        Exit;
      End;
    End;
  End;
end;

procedure TPagSeguroPgto.pAdicionaLinha(strString: String);
  Const
    AUMENTO_CAPACIDADE_FREG  = 2000;
begin
  If intPosicaoAtual >= Length(FRegPagSeguroPgto) - 1 Then
  Begin
    SetLength(FRegPagSeguroPgto, Length(FRegPagSeguroPgto)+AUMENTO_CAPACIDADE_FREG);
  End;

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  Try
    If fGetDados(strString, 001,01) = '0' Then
    Begin
      dtaArq := fGetDados(strString, 012,08);
    End
    Else If (fGetDados(strString, 001,01) = '1') Then
    Begin
      Inc(intPosicaoAtual);

      FRegPagSeguroPgto[intPosicaoAtual-1].strTipEve := fGetDados(strString, 040,02);
      FRegPagSeguroPgto[intPosicaoAtual-1].fltLiqAnt := fGetDados(strString, 269,13,True);

      FRegPagSeguroPgto[intPosicaoAtual-1].strTipReg := RetornaTipoDoRegistro(FRegPagSeguroPgto[intPosicaoAtual-1].strTipEve,
                                                                              FRegPagSeguroPgto[intPosicaoAtual-1].fltLiqAnt);

      FRegPagSeguroPgto[intPosicaoAtual-1].strCodEst := fGetDados(strString, 002,10);
      FRegPagSeguroPgto[intPosicaoAtual-1].strDtaTra := fGetDados(strString, 012,08);
      FRegPagSeguroPgto[intPosicaoAtual-1].strDtaAju := fGetDados(strString, 026,08);
      FRegPagSeguroPgto[intPosicaoAtual-1].strTipTra := fGetDados(strString, 042,02);
      FRegPagSeguroPgto[intPosicaoAtual-1].strCodTra := fGetDados(strString, 046,32);
      FRegPagSeguroPgto[intPosicaoAtual-1].strCodVen := fGetDados(strString, 078,20);
      FRegPagSeguroPgto[intPosicaoAtual-1].fltValBru := fGetDados(strString, 098,13,True);
      FRegPagSeguroPgto[intPosicaoAtual-1].fltValPar := fGetDados(strString, 111,13,True);

      FRegPagSeguroPgto[intPosicaoAtual-1].PagamentoAPrazo := 'M';

      FRegPagSeguroPgto[intPosicaoAtual-1].TaxaIntermediacao := 0.00;
      FRegPagSeguroPgto[intPosicaoAtual-1].TaxaParcelamento := 0.00;

      If strTipArq = '02' Then
      Begin
        FRegPagSeguroPgto[intPosicaoAtual-1].PagamentoAPrazo := fGetDados(strString, 124,1);
        FRegPagSeguroPgto[intPosicaoAtual-1].Plano := Trim(fGetDados(strString, 125,2));
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumPar := fGetDados(strString, 127,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strTotPar := fGetDados(strString, 129,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strDtaPag := fGetDados(strString, 131,08);
        FRegPagSeguroPgto[intPosicaoAtual-1].fltValLiq := fGetDados(strString, 243,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].fltTaxAnt := fGetDados(strString, 256,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].strStaPag := fGetDados(strString, 282,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strMeiPag := fGetDados(strString, 286,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumNSU := fGetDados(strString, 387,14);
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumCar := fGetDados(strString, 401,06) + '*********' + fGetDados(strString, 407,04);
        FRegPagSeguroPgto[intPosicaoAtual-1].strCodAut := fGetDados(strString, 411,06);
        FRegPagSeguroPgto[intPosicaoAtual-1].strCod_CV := fGetDados(strString, 417,32);

        FRegPagSeguroPgto[intPosicaoAtual-1].CanalDeEntrada := fGetDados(strString, 318,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].MeioDeCaptura := fGetDados(strString, 322,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].TaxaIntermediacao := fGetDados(strString, 191,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].TaxaParcelamento := fGetDados(strString, 178,13,True);

        If FRegPagSeguroPgto[intPosicaoAtual-1].strTipReg = 'TF' Then
          FRegPagSeguroPgto[intPosicaoAtual-1].strNumNSU := fGetDados(strString, 046,32);
      End
      Else
      Begin
        FRegPagSeguroPgto[intPosicaoAtual-1].Plano := Trim(fGetDados(strString, 124,2));
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumPar := fGetDados(strString, 126,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strTotPar := fGetDados(strString, 128,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strDtaPag := fGetDados(strString, 138,08);
        FRegPagSeguroPgto[intPosicaoAtual-1].fltValLiq := fGetDados(strString, 172,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].fltTaxAnt := fGetDados(strString, 159,13,True);
        FRegPagSeguroPgto[intPosicaoAtual-1].strStaPag := fGetDados(strString, 185,02);
        FRegPagSeguroPgto[intPosicaoAtual-1].strMeiPag := '04';
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumNSU := fGetDados(strString, 219,14);
        FRegPagSeguroPgto[intPosicaoAtual-1].strNumCar := fGetDados(strString, 233,06) + '*********' + fGetDados(strString, 239,04);
        FRegPagSeguroPgto[intPosicaoAtual-1].strCodAut := fGetDados(strString, 243,06);
        FRegPagSeguroPgto[intPosicaoAtual-1].strCod_CV := fGetDados(strString, 249,32);

        FRegPagSeguroPgto[intPosicaoAtual-1].CanalDeEntrada := '';
        FRegPagSeguroPgto[intPosicaoAtual-1].MeioDeCaptura := '';
      End;

      FRegPagSeguroPgto[intPosicaoAtual-1].strDtaArq := dtaArq;
      FRegPagSeguroPgto[intPosicaoAtual-1].strNomArq := strNomArq;

      If (Not FRegPagSeguroPgto[intPosicaoAtual-1].strCodEst.IsEmpty) Then
      Begin
        If (VS_ListaEstabelecimentos.IndexOf(FRegPagSeguroPgto[intPosicaoAtual-1].strCodEst) < 0) Then
          VS_ListaEstabelecimentos.Add(FRegPagSeguroPgto[intPosicaoAtual-1].strCodEst);
      End;

    End;
  Except
    Raise;
  End;
end;

function TPagSeguroPgto.fRetVal(AValor: Variant;
  ACampoData: Boolean = False): Variant;
Begin
  If String(AValor).Trim.isEmpty Then
    Exit(Null);

  Result := AValor;
  If ACampoData Then
    Result := Copy(AValor, 1, 4) + '/' +
              Copy(AValor, 5, 2) + '/' +
              Copy(AValor, 7, 2);
End;

procedure TPagSeguroPgto.pGravarRegistros(pgbProg: TcxProgressBar);
  Var
    LGravacao: TUniQuery;

    LRegistroPgto: TRegistroPgto;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TPagSeguroFuncoes.RetornaSQLReplace('PAG_SEPGTO', ['PAG_CONCIL']);

    pgbProg.Position := 0;

    If Length(FRegPagSeguroPgto) = 0 Then
      Exit;

    pgbProg.Properties.Max := Length(FRegPagSeguroPgto)-1;
    For LRegistroPgto In FRegPagSeguroPgto Do
    Begin
      LGravacao.Close;

      If Not ImportaRegistro(LRegistroPgto) Then
      Begin
        pgbProg.Position := pgbProg.Position + 1;

        Continue;
      End;

      If MatchStr(LRegistroPgto.strTipReg, ['PG', 'AP', 'AJ', 'TF']) Then
        ImportouPG := True;

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TIPREG', fRetVal(LRegistroPgto.strTipReg));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODEST', fRetVal(LRegistroPgto.strCodEst));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TIPEVE', fRetVal(LRegistroPgto.strTipEve));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUM_CV', fRetVal(LRegistroPgto.strCod_CV));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_DTATRA', fRetVal(LRegistroPgto.strDtaTra, True));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_DTAPAG', fRetVal(LRegistroPgto.strDtaPag, True));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_DTAAJU', fRetVal(LRegistroPgto.strDtaAju, True));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TIPTRA', fRetVal(LRegistroPgto.strTipTra));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TOTPAR', fRetVal(LRegistroPgto.strTotPar));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMPAR', fRetVal(LRegistroPgto.strNumPar));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_VALPAR', fRetVal(LRegistroPgto.fltValPar));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODAUT', fRetVal(LRegistroPgto.strCodAut));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMNSU', fRetVal(LRegistroPgto.strNumNSU));

      If (Not MatchStr(fRetVal(LRegistroPgto.strMeiPag), ['03', '08', '11'])) Then
      Begin
        If LRegistroPgto.strCodAut.Trim.IsEmpty Then
          TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODAUT', LeftStr(LRegistroPgto.strCodVen, 6));

        If LRegistroPgto.strNumNsu.Trim.IsEmpty Then
        Begin
          If Not Concat(LRegistroPgto.strTipTra, LRegistroPgto.strCodVen).Equals('09') Then
            TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMNSU', LeftStr(LRegistroPgto.strCodVen, 11))
          Else
            TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMNSU', LeftStr(LRegistroPgto.strCodTra, 11));
        End;

        If LGravacao.ParamByName('PAG_CODAUT').AsString.IsEmpty Then
          TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODAUT', LGravacao.ParamByName('PAG_NUMNSU').AsString);
      End
      Else If LRegistroPgto.strMeiPag.Equals('11') Then
      Begin
        TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODAUT', RightStr(fRetVal(LRegistroPgto.strCodTra), 6));
        TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMNSU', RightStr(fRetVal(LRegistroPgto.strCodTra), 11));
      End;

      If LGravacao.ParamByName('PAG_NUMNSU').AsString.IsEmpty Then
        Continue;

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NUMCAR', fRetVal(LRegistroPgto.strNumCar));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODTRA', fRetVal(LRegistroPgto.strCodTra));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CODVEN', fRetVal(LRegistroPgto.strCodVen));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_VALBRU', fRetVal(LRegistroPgto.fltValBru));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_VALLIQ', fRetVal(LRegistroPgto.fltValLiq));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_LIQANT', fRetVal(LRegistroPgto.fltLiqAnt));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TAXANT', fRetVal(LRegistroPgto.fltTaxAnt));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_STAPAG', fRetVal(LRegistroPgto.strStaPag));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_MEIPAG', fRetVal(LRegistroPgto.strMeiPag));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_NOMARQ', fRetVal(LRegistroPgto.strNomArq));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_DTAARQ', fRetVal(LRegistroPgto.strDtaArq, True));

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_PAGPRA', fRetVal(LRegistroPgto.PagamentoAPrazo));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_CANENT', fRetVal(LRegistroPgto.CanalDeEntrada));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_MEICAP', fRetVal(LRegistroPgto.MeioDeCaptura));

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TAXINT', fRetVal(LRegistroPgto.TaxaIntermediacao));
      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_TAXPAR', fRetVal(LRegistroPgto.TaxaParcelamento));

      TPagSeguroFuncoes.CarregaParametroDataset(LGravacao, 'PAG_PLANO_', fRetVal(LRegistroPgto.Plano));

      LGravacao.ExecSQL;

      TPagSeguroFuncoes.pStepStatusGravacao(pgbProg);
    End;

    TPagSeguroFuncoes.GravarEstabelecimentos;

    pgbProg.Position := Length(FRegPagSeguroPgto) - 1;
    Application.ProcessMessages;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LGravacao);
  End;
end;

function TPagSeguroPgto.RetornaTipoDoRegistro(ATipoEvento: String;
  ALiquidoAntecipacao: Double): String;
begin
  Result := 'PG';

  If strTipArq = '03' Then
    Result := 'AP'
  Else If (ATipoEvento = '04') Then
    Result := 'TF'
  Else If (ATipoEvento <> '01') Then
    Result := 'AJ'
  Else If (ALiquidoAntecipacao <> 0) Then
    Result := 'AT';
end;

end.
