{*********************************}
{* Importação de arquivos do B2W *}
{******************************AJ*}
unit untB2WPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
  TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strCodAut: String;
    strDtaTra: String;
    strDtaPag: String;
    strNumPed: String;
    strStatus: String;
    strMarca_: String;
    strTipPag: String;
    strNumPar: String;
    strTotPar: String;
    fltValBru: Double;
    fltValCom: Double;
    fltValLiq: Double;
    strNomArq: String;
    strDtaArq: String;
    strNumEnt: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroB2WPgto  = Array Of TRegistroPgto;

  TArrEstruturaB2WPgto = Array Of TEstruturaPgto;

  TB2WPgto = Class(TInterfacedObject, ICartoes)
  Private
    strRegAnt: String;
    FModeloImportacao : Integer;
    FPagamentosImportados: boolean;

    procedure pAdicionaLinhaLayoutAntigo(AStringLinha: String);
    procedure pAdicionaLinhaLayoutNovo(AStringLinha: String);
    function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);
    procedure pDefineModeloImportacao(AModeloImportacao : Integer);

    function fRetornaTipoModeloImportacao(AStringLinha: String) : Integer;
    function PagamentosImportados : boolean;

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaB2WPgto;
  End;

Var
  strDtaArq,
  strNomArq: String;

  lstRegistrosJaLancados: TStringList;

Const
  NOMTAB = 'B2W_B2PGTO';
  INICAM = 'B2W_';

implementation

uses untFuncoes, untIDataSet, untB2W;

{ TB2WPgto }

{**********************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE CRÉDITO *}
{* B2W_B2PGTO                                 *}
{*******************************************AJ*}
function TB2WPgto.fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
  Var
    rst     : Variant;
    i       : Integer;
    strZeros: String;
Begin
  If strValor <> '' Then
    rst := strValor
  Else
    rst := '';

  If blnFlt Then
  Begin
    strZeros := '';
    For i := 1 to intCasas do
      strZeros := strZeros + '0';

    rst := fStrToFloat(rst) / StrtoFloat('1' + strZeros);
  End;

  Result := rst;
End;
class function TB2WPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaB2WPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 19);

    Result[0].strDescri  := INICAM + 'TIPREG'; Result[0].strTipCmp  := 'VARCHAR(40)'  ;
    Result[1].strDescri  := INICAM + 'CODEST'; Result[1].strTipCmp  := 'VARCHAR(25)'  ;
    Result[2].strDescri  := INICAM + 'DTAPAG'; Result[2].strTipCmp  := 'DATE'         ;
    Result[3].strDescri  := INICAM + 'DTATRA'; Result[3].strTipCmp  := 'DATE'         ;
    Result[4].strDescri  := INICAM + 'CODAUT'; Result[4].strTipCmp  := 'VARCHAR(20)'  ;
    Result[5].strDescri  := INICAM + 'VALBRU'; Result[5].strTipCmp  := 'DECIMAL(15,2)';
    Result[6].strDescri  := INICAM + 'VALCOM'; Result[6].strTipCmp  := 'DECIMAL(15,2)';
    Result[7].strDescri  := INICAM + 'VALLIQ'; Result[7].strTipCmp  := 'DECIMAL(15,2)';
    Result[8].strDescri  := INICAM + 'NOMARQ'; Result[8].strTipCmp  := 'VARCHAR(255)' ;
    Result[9].strDescri  := INICAM + 'DTAARQ'; Result[9].strTipCmp  := 'DATE'         ;
    Result[10].strDescri := INICAM + 'CONCIL'; Result[10].strTipCmp := 'INT DEFAULT 0';
    Result[11].strDescri := INICAM + 'STATUS'; Result[11].strTipCmp := 'VARCHAR(15)'  ;
    Result[12].strDescri := INICAM + 'NUMPED'; Result[12].strTipCmp := 'VARCHAR(20)'  ;
    Result[13].strDescri := INICAM + 'MARCA_'; Result[13].strTipCmp := 'VARCHAR(20)'  ;
    Result[14].strDescri := INICAM + 'NUMPAR'; Result[14].strTipCmp := 'VARCHAR(2)'   ;
    Result[15].strDescri := INICAM + 'TOTPAR'; Result[15].strTipCmp := 'VARCHAR(2)'   ;
    Result[16].strDescri := INICAM + 'NUMCAR'; Result[16].strTipCmp := 'VARCHAR(19)'  ;
    Result[17].strDescri := INICAM + 'TIPPAG'; Result[17].strTipCmp := 'VARCHAR(15)'  ;
    Result[18].strDescri := INICAM + 'NUMENT'; Result[18].strTipCmp := 'VARCHAR(20)'  ;
  End;
End;

function TB2WPgto.fRetornaTipoModeloImportacao(AStringLinha: String): Integer;
begin
  Result := 0;
  If (Pos('"Marca";"Nome Fantasia";"Data pedido";"Data Pagamento";"Data Estorno";', AStringLinha) > 0) Then
    Result := 1;

  If (Pos('Marketplace;Seller;Data de Criação do Lançamento;Pedido;Pedido Site;Status do Pedido;', AStringLinha) > 0) Then
    Result := 2;
end;

class function TB2WPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaB2WPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(B2W_TIPREG,B2W_CODEST,B2W_CODAUT,B2W_DTATRA,B2W_DTAPAG,B2W_NUMPAR,B2W_NUMENT)) ENGINE INNODB ' ;
end;

procedure TB2WPgto.pAdicionaLinha(strString: String);
begin

  If Not Assigned(lstRegistrosJaLancados) Then
    lstRegistrosJaLancados := TStringList.Create;

  Try
    case FModeloImportacao of
     1: pAdicionaLinhaLayoutAntigo(strString);
     2: pAdicionaLinhaLayoutNovo(strString);
    end;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TB2WPgto.pAdicionaLinhaLayoutAntigo(AStringLinha: String);
Var
  intIndiceRegistro: Integer;
  lstCampos: TStringList;
begin
  lstCampos := TStringList.Create;
  try
    lstCampos.Delimiter     := ';';
    lstCampos.DelimitedText := StringReplace(AStringLinha, ' ', EmptyStr, [rfReplaceAll]);
    lstCampos.DelimitedText := StringReplace(lstCampos.DelimitedText, 'R$', EmptyStr, [rfReplaceAll]);

    If (Pos('"Marca";"Nome Fantasia";"Data pedido";"Data Pagamento";"Data Estorno";', AStringLinha) <= 0) Then
    Begin
      If Trim(AStringLinha) = '' Then
        Exit;

      If (fEmptyStr(fGetDados(lstCampos[6])) And  (fGetDados(lstCampos[11]) = 'Bloqueado')) Then
        Exit;

      If (strRegAnt <> fGetDados(lstCampos[9]) + Copy(fGetDados(lstCampos[13]), 2, Length(fGetDados(lstCampos[13])))) Or
         (strRegAnt + fGetDados(lstCampos[9]) + Copy(fGetDados(lstCampos[13]), 2, Length(fGetDados(lstCampos[13]))) = '') Then
      Begin
        intIndiceRegistro := lstRegistrosJaLancados.IndexOf(fGetDados(lstCampos[9]) + Copy(fGetDados(lstCampos[13]), 2, Length(fGetDados(lstCampos[13]))) + fGetDados(lstCampos[10]));
        If intIndiceRegistro >= 0 Then
        Begin
          FRegB2WPgto[intIndiceRegistro].fltValLiq := FRegB2WPgto[intIndiceRegistro].fltValLiq + fGetDados(lstCampos[12], True, 0);
          FRegB2WPgto[intIndiceRegistro].fltValCom := FRegB2WPgto[intIndiceRegistro].fltValCom + fGetDados(lstCampos[12], True, 0);

          strRegAnt := fGetDados(lstCampos[9]) + Copy(fGetDados(lstCampos[13]), 2, Length(fGetDados(lstCampos[13])));

          Exit;
        End;

        lstRegistrosJaLancados.Add(fGetDados(lstCampos[9]) + Copy(fGetDados(lstCampos[13]), 2, Length(fGetDados(lstCampos[13]))) + fGetDados(lstCampos[10]));

        SetLength(FRegB2WPgto, Length(FRegB2WPgto) + 1);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipReg := fGetDados(lstCampos[10]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodEst := '0';

        if lstCampos[8] <> '' then
        begin
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := fGetDados(lstCampos[8]);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := fGetDados(lstCampos[8]);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := fGetDados(lstCampos[9]);
        end
        else
        begin
          if (lstCampos[10] = 'Despesa_inicial') and
             (Pos('Pedido', lstCampos[7]) <> 0) then
          begin
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := Copy(lstCampos[7], Pos('Pedido', lstCampos[7]) +7, 12);
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := Copy(lstCampos[7], Pos('Pedido', lstCampos[7]) +7, 12);
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := Copy(lstCampos[7], Pos('Pedido', lstCampos[7]) +7, 12);
          end
          else
          if (MatchStr(lstCampos[10], ['Diferenca_credito_desconto', 'Diferenca_debito_desconto'])) and
             (Pos('Processo', lstCampos[7]) <> 0) then
          begin
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := Copy(lstCampos[7], Pos('Processo:', lstCampos[7]) +10, 9);
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := Copy(lstCampos[7], Pos('Processo:', lstCampos[7]) +10, 9);
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := Copy(lstCampos[7], Pos('Processo:', lstCampos[7]) +10, 9);
          end
          else
          If (lstCampos[10] = 'IR') And
             (Pos('ImpostodeRenda', lstCampos[7]) <> 0) then
          begin
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := '99-900000001';
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := '99-900000001';
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := '99-900000001';
          end
          else
          begin
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := '';
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := '';
          end;
        end;

        If lstCampos[2] <> '' Then
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(lstCampos[2])
        Else
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(lstCampos[5]);

        If FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra = '' Then
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(lstCampos[3]);

        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaPag := fGetDados(lstCampos[6]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValBru := fGetDados(lstCampos[12], True, 0);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValCom := 0;
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValLiq := fGetDados(lstCampos[12], True, 0);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strStatus := fGetDados(lstCampos[11]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strMarca_ := fGetDados(lstCampos[0]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipPag := fGetDados(lstCampos[14]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPar := '01';
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTotPar := '01';

        If lstCampos[13] <> '' Then
        Begin
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPar := Copy(fGetDados(lstCampos[13]), 2, Pos('/', fGetDados(lstCampos[13])) - 2);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strTotPar := Copy(fGetDados(lstCampos[13]), Pos('/', fGetDados(lstCampos[13])) + 1, 2);
        End;

        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNomArq := strNomArq;
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaArq := Copy(strDtaArq, 7, 4) + '/' + Copy(strDtaArq, 4, 2) + '/' + Copy(strDtaArq, 1, 2);
      End
      Else
      Begin
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValLiq := FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValLiq + fGetDados(lstCampos[12], True, 0);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValCom := FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValCom + fGetDados(lstCampos[12], True, 0);
      End;

      strRegAnt := fGetDados(lstCampos[9]) + Copy(fGetDados(lstCampos[13]), 2, Length(fGetDados(lstCampos[13])));
    End;
  finally
    if Assigned(lstCampos) then
      FreeAndNil(lstCampos);
  end;
end;

procedure TB2WPgto.pAdicionaLinhaLayoutNovo(AStringLinha: String);
Var
  intIndiceRegistro: Integer;
  lstCampos: TStringList;
begin
  lstCampos := TStringList.Create;
  try
    lstCampos.Delimiter     := ';';
    lstCampos.DelimitedText := StringReplace(AStringLinha, ' ', '_', [rfReplaceAll]);
    lstCampos.DelimitedText := StringReplace(lstCampos.DelimitedText, 'R$', EmptyStr, [rfReplaceAll]);

    If (Pos('Marketplace;Seller;Data de Criação do Lançamento;Pedido;Pedido Site;Status do Pedido;', AStringLinha) <= 0) Then
    Begin
      If Trim(AStringLinha) = '' Then
        Exit;

      If (fEmptyStr(fGetDados(lstCampos[11])) And (fGetDados(lstCampos[5]) = 'Bloqueado')) Then
        Exit;

      If (strRegAnt <> fGetDados(lstCampos[3])) Or (strRegAnt = '') Then
      Begin
        intIndiceRegistro := lstRegistrosJaLancados.IndexOf(fGetDados(lstCampos[3]));
        If intIndiceRegistro >= 0 Then
        Begin
          FRegB2WPgto[intIndiceRegistro].fltValLiq := FRegB2WPgto[intIndiceRegistro].fltValLiq + fGetDados(lstCampos[12], True, 0);
          FRegB2WPgto[intIndiceRegistro].fltValCom := FRegB2WPgto[intIndiceRegistro].fltValCom + fGetDados(lstCampos[12], True, 0);

          strRegAnt := fGetDados(lstCampos[3]);

          Exit;
        End;

        lstRegistrosJaLancados.Add(fGetDados(lstCampos[3]));

        SetLength(FRegB2WPgto, Length(FRegB2WPgto) + 1);
        if not fEmptyStr(fGetDados(lstCampos[7])) then
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipReg := fGetDados(lstCampos[7])
        Else
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipReg := fGetDados(Copy(lstCampos[10], 1, Pos('_',lstCampos[10]) - 1));

        FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodEst := '0';

        if lstCampos[3] <> '' then
        begin
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := fGetDados(lstCampos[3]);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := fGetDados(lstCampos[3]);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := fGetDados(lstCampos[3]);
        end
        else
        begin
          if (lstCampos[7] = 'Despesa_inicial') and
             (Pos('Pedido', lstCampos[10]) <> 0) then
          begin
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := Copy(lstCampos[10], Pos('Pedido', lstCampos[10]) + 7, 12);
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := Copy(lstCampos[10], Pos('Pedido', lstCampos[10]) + 7, 12);
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := Copy(lstCampos[10], Pos('Pedido', lstCampos[10]) + 7, 12);
          end
          else
          if (MatchStr(lstCampos[7], ['Diferenca_credito_desconto', 'Diferenca_debito_desconto'])) and
             (Pos('Processo', lstCampos[10]) <> 0) then
          begin
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := Copy(lstCampos[10], Pos('Processo:', lstCampos[10]) +10, 9);
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := Copy(lstCampos[10], Pos('Processo:', lstCampos[10]) +10, 9);
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := Copy(lstCampos[10], Pos('Processo:', lstCampos[10]) +10, 9);
          end
          else
          If (lstCampos[10] = 'IR') And
             (Pos('ImpostodeRenda', lstCampos[10]) <> 0) then
          begin
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := '99-900000001';
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := '99-900000001';
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := '99-900000001';
          end
          else
          begin
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := '';
            FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := '';
          end;
        end;

        If lstCampos[2] <> '' Then
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(lstCampos[2])
        Else
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(lstCampos[6]);

        If FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra = '' Then
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(lstCampos[9]);

        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaPag := fGetDados(lstCampos[12]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValBru := fGetDados(lstCampos[11], True, 0);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValCom := 0;
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValLiq := fGetDados(lstCampos[11], True, 0);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strStatus := fGetDados(lstCampos[8]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strMarca_ := fGetDados(lstCampos[0]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipPag := 'a vista';
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPar := '01';
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTotPar := '01';
        If lstCampos[14] <> '' Then
        Begin
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPar := fGetDados(lstCampos[14]);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strTotPar := fGetDados(lstCampos[14]);
        End;

        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNomArq := strNomArq;
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaArq := Copy(strDtaArq, 7, 4) + '/' + Copy(strDtaArq, 4, 2) + '/' + Copy(strDtaArq, 1, 2);
      End
      Else
      Begin
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValLiq := FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValLiq + fGetDados(lstCampos[11], True, 0);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValCom := FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValCom + fGetDados(lstCampos[11], True, 0);
      End;

      strRegAnt := fGetDados(lstCampos[3]);
    End;
  finally
    if Assigned(lstCampos) then
      FreeAndNil(lstCampos);
  end;


end;

function TB2WPgto.PagamentosImportados: boolean;
begin
 result := FPagamentosImportados;
end;

procedure TB2WPgto.pDefineModeloImportacao(AModeloImportacao: Integer);
begin
    FModeloImportacao := AModeloImportacao;
end;

procedure TB2WPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;
    arrCampos: TArrEstruturaB2WPgto;

  function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Begin
    If fEmptyStr(strVal) Then Result := Null
    Else
    Begin
      If blnData Then
        Result := Copy(strVal, 7, 4) + '/' + Copy(strVal, 4, 2) + '/' + Copy(strVal, 1, 2)
      else
        Result := strVal;
    End;
  End;

begin
  strSQL    := 'REPLACE INTO ' + NOMTAB + ' (';
  arrCampos := fRetEstruturaPgto(NOMTAB);
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> INICAM + 'CONCIL') Then
      strSQL := strSQL + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ') VALUES (';
  For intCont := 0 to Length(arrCampos) - 1 do
    If (arrCampos[intCont].strDescri <> INICAM + 'CONCIL') Then
      strSQL := strSQL + ':' + arrCampos[intCont].strDescri + ',';
  strSQL := Copy(strSQL, 1, Length(strSQL) - 1) + ')';

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  FPagamentosImportados := False;

  pgbProg.Position := 0;

  If Length(FRegB2WPgto) > 0 Then
  Begin
    pgbProg.Max      := Length(FRegB2WPgto)-1;
    For intCont := 0 To Length(FRegB2WPgto)-1 Do
    Begin
      If (FRegB2WPgto[intCont].fltValLiq <> 0) And
         (FRegB2WPgto[intCont].strCodAut <> '') And
         (FRegB2WPgto[intCont].strDtaTra <> '') Then
      Begin
        Application.ProcessMessages;
        With qryDados Do
        Begin
          Close;

          ParamByName(INICAM + 'TIPREG').Value     := fRetVal(FRegB2WPgto[intCont].strTipReg);
          ParamByName(INICAM + 'CODAUT').Value     := fRetVal(FRegB2WPgto[intCont].strCodAut);
          ParamByName(INICAM + 'DTATRA').Value     := fRetVal(FRegB2WPgto[intCont].strDtaTra, True);
          ParamByName(INICAM + 'DTAPAG').Value     := fRetVal(FRegB2WPgto[intCont].strDtaPag, True);
          ParamByName(INICAM + 'VALBRU').Value     := fRetVal(FRegB2WPgto[intCont].fltValBru);
          ParamByName(INICAM + 'VALCOM').Value     := fRetVal(FRegB2WPgto[intCont].fltValCom);
          ParamByName(INICAM + 'VALLIQ').Value     := fRetVal(FRegB2WPgto[intCont].fltValLiq);
          ParamByName(INICAM + 'STATUS').Value     := fRetVal(FRegB2WPgto[intCont].strStatus);
          ParamByName(INICAM + 'NOMARQ').AsString  := fRetVal(FRegB2WPgto[intCont].strNomArq);
          ParamByName(INICAM + 'DTAARQ').Value     := fRetVal(FRegB2WPgto[intCont].strDtaArq);
          ParamByName(INICAM + 'CODEST').Value     := fRetVal(FRegB2WPgto[intCont].strCodEst);
          ParamByName(INICAM + 'NUMPAR').Value     := fRetVal(FRegB2WPgto[intCont].strNumPar);
          ParamByName(INICAM + 'TOTPAR').Value     := fRetVal(FRegB2WPgto[intCont].strTotPar);
          ParamByName(INICAM + 'NUMCAR').Value     := '00000000000000';
          ParamByName(INICAM + 'MARCA_').Value     := fRetVal(FRegB2WPgto[intCont].strMarca_);
          ParamByName(INICAM + 'NUMPED').Value     := fRetVal(FRegB2WPgto[intCont].strNumPed);
          ParamByName(INICAM + 'TIPPAG').Value     := fRetVal(FRegB2WPgto[intCont].strTipPag);
          ParamByName(INICAM + 'NUMENT').Value     := fRetVal(FRegB2WPgto[intCont].strNumEnt);

          ExecSQL;
        End;

        If MatchStr(fRetVal(FRegB2WPgto[intCont].strStatus), ['Liberado','Unlocked']) Then
          FPagamentosImportados := True;
      End;

      pgbProg.Position := pgbProg.Position + 1;
    End;

    Try
      qryDados.Close;
      qryDados.SQL := 'REPLACE INTO ESTCAR (CAR_CODEST, CAR_NOMOPE) VALUES (:ESTAB, "B2W")';
      qryDados.ParamByName('ESTAB').AsString := '0';
      qryDados.ExecSQL;
    Except
      Raise Exception.Create('A tabela ESTCAR não foi criada. Entre em contato com a Citel!');
    End;

    If Assigned(lstRegistrosJaLancados) Then
      FreeAndNil(lstRegistrosJaLancados);
  End;
end;

end.
