{*********************************}
{* Importação de arquivos do B2W *}
{******************************AJ*}
unit untB2WPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms, dialogs,

     cxProgressBar, Uni,

     untIB2WIntegracaoLibCartoes, untTB2WFuncoes,
     untB2WTipos;

Type
  TB2WPgto = Class(TInterfacedObject, ICartoesB2W)
  Private
    strRegAnt: String;
    FModeloImportacao : Integer;
    FPagamentosImportados: boolean;

    procedure pAdicionaLinhaLayoutAntigo(AStringLinha: String);
    procedure pAdicionaLinhaLayoutNovo(AStringLinha: String);
    function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0): Variant;
    function fRetVal(strVal: Variant; blnData: Boolean = False): Variant;
  Public
    constructor Create; overload;
    destructor Destroy; override;

    procedure pAdicionaLinha(strString: String);
    procedure pGravarRegistros(var pgbProg: TcxProgressBar);
    procedure pDefineModeloImportacao(AModeloImportacao : Integer);

    function fRetornaTipoModeloImportacao(AStringLinha: String) : Integer;
    function PagamentosImportados : boolean;

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaB2WPgto;
  End;

Var
  strDtaArq,
  strNomArq: String;

  VS_CodigoEmpresa: String;

  lstRegistrosJaLancados: TStringList;

  FRegB2WPgto    : TArrRegistroB2WPgto;

Const
  NOMTAB = 'B2W_B2PGTO';
  INICAM = 'B2W_';

implementation

{ TB2WPgto }

constructor TB2WPgto.Create;
begin
  lstRegistrosJaLancados := Nil;
end;

destructor TB2WPgto.Destroy;
begin
  TB2WFuncoes.FreeAndNilStringLists(lstRegistrosJaLancados);
  inherited;
end;

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

    rst := TB2WFuncoes.fStrToFloat(rst) / StrtoFloat('1' + strZeros);
  End;

  Result := rst;
End;

class function TB2WPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaB2WPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 21);

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
    Result[19].strDescri := INICAM + 'CODEMP'; Result[19].strTipCmp := 'CHAR(3)'      ;
    Result[20].strDescri := INICAM + 'IMPNOV'; Result[20].strTipCmp := 'CHAR(3) DEFAULT ''N'' ';
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

function TB2WPgto.fRetVal(strVal: Variant; blnData: Boolean): Variant;
begin
  If TB2WFuncoes.fEmptyStr(strVal) Then Result := Null
  Else
  Begin
    If blnData Then
      Result := Copy(strVal, 7, 4) + '/' + Copy(strVal, 4, 2) + '/' + Copy(strVal, 1, 2)
    else
      Result := strVal;
  End;
end;

procedure TB2WPgto.pAdicionaLinha(strString: String);
begin
  If Not Assigned(lstRegistrosJaLancados) Then
    lstRegistrosJaLancados := TStringList.Create;

  If Not Assigned(VS_ListaEstabelecimentos) Then
    VS_ListaEstabelecimentos := TStringList.Create;

  Try
    case FModeloImportacao of
     1: pAdicionaLinhaLayoutAntigo(strString);
     2: pAdicionaLinhaLayoutNovo(strString);
    end;
  Except
    Raise;
  End;
end;

procedure TB2WPgto.pAdicionaLinhaLayoutAntigo(AStringLinha: String);
Var
  LintIndiceRegistro: Integer;
  LlstCampos: TStringList;
begin
  LlstCampos := Nil;
  try
    LlstCampos := TStringList.Create;
    LlstCampos.Delimiter     := ';';
    LlstCampos.DelimitedText := StringReplace(AStringLinha, ' ', EmptyStr, [rfReplaceAll]);
    LlstCampos.DelimitedText := StringReplace(LlstCampos.DelimitedText, 'R$', EmptyStr, [rfReplaceAll]);

    If (Pos('"Marca";"Nome Fantasia";"Data pedido";"Data Pagamento";"Data Estorno";', AStringLinha) <= 0) Then
    Begin
      If Trim(AStringLinha) = '' Then
        Exit;

      If (TB2WFuncoes.fEmptyStr(fGetDados(LlstCampos[6])) And  (fGetDados(LlstCampos[11]) = 'Bloqueado')) Then
        Exit;

      LintIndiceRegistro := lstRegistrosJaLancados.IndexOf(fGetDados(LlstCampos[9]) + Copy(fGetDados(LlstCampos[13]), 2, Length(fGetDados(LlstCampos[13]))) + fGetDados(LlstCampos[10]));

      lstRegistrosJaLancados.Add(fGetDados(LlstCampos[9]) + Copy(fGetDados(LlstCampos[13]), 2, Length(fGetDados(LlstCampos[13]))) + fGetDados(LlstCampos[10]));

      SetLength(FRegB2WPgto, Length(FRegB2WPgto) + 1);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipReg := fGetDados(LlstCampos[10]);

      FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodEst := VS_CodigoEmpresa;

      If VS_ListaEstabelecimentos.IndexOf(VS_CodigoEmpresa) < 0 Then
        VS_ListaEstabelecimentos.Add(VS_CodigoEmpresa);

      if LlstCampos[8] <> '' then
      begin
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := fGetDados(LlstCampos[8]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := fGetDados(LlstCampos[8]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := fGetDados(LlstCampos[9]);
      end
      else
      begin
        if (LlstCampos[10] = 'Despesa_inicial') and
           (Pos('Pedido', LlstCampos[7]) <> 0) then
        begin
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := Copy(LlstCampos[7], Pos('Pedido', LlstCampos[7]) +7, 12);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := Copy(LlstCampos[7], Pos('Pedido', LlstCampos[7]) +7, 12);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := Copy(LlstCampos[7], Pos('Pedido', LlstCampos[7]) +7, 12);
        end
        else
        if (MatchStr(LlstCampos[10], ['Diferenca_credito_desconto', 'Diferenca_debito_desconto'])) and
           (Pos('Processo', LlstCampos[7]) <> 0) then
        begin
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := Copy(LlstCampos[7], Pos('Processo:', LlstCampos[7]) +10, 9);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := Copy(LlstCampos[7], Pos('Processo:', LlstCampos[7]) +10, 9);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := Copy(LlstCampos[7], Pos('Processo:', LlstCampos[7]) +10, 9);
        end
        else
        If (LlstCampos[10] = 'IR') And
           (Pos('ImpostodeRenda', LlstCampos[7]) <> 0) then
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

      If LlstCampos[2] <> '' Then
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(LlstCampos[2])
      Else
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(LlstCampos[5]);

      If FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra = '' Then
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(LlstCampos[3]);

      FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaPag := fGetDados(LlstCampos[6]);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValBru := fGetDados(LlstCampos[12], True, 0);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValCom := 0;
      FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValLiq := fGetDados(LlstCampos[12], True, 0);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strStatus := fGetDados(LlstCampos[11]);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strMarca_ := fGetDados(LlstCampos[0]);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipPag := fGetDados(LlstCampos[14]);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPar := '01';
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strTotPar := '01';
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strImpNov := 'N';

      If LlstCampos[13] <> '' Then
      Begin
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPar := Copy(fGetDados(LlstCampos[13]), 2, Pos('/', fGetDados(LlstCampos[13])) - 2);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTotPar := Copy(fGetDados(LlstCampos[13]), Pos('/', fGetDados(LlstCampos[13])) + 1, 2);
      End;

      FRegB2WPgto[Length(FRegB2WPgto) - 1].strNomArq := strNomArq;
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaArq := Copy(strDtaArq, 7, 4) + '/' + Copy(strDtaArq, 4, 2) + '/' + Copy(strDtaArq, 1, 2);

      strRegAnt := fGetDados(LlstCampos[9]) + Copy(fGetDados(LlstCampos[13]), 2, Length(fGetDados(LlstCampos[13])));
    End;
  finally
    TB2WFuncoes.FreeAndNilStringLists(LlstCampos);
  end;
end;

procedure TB2WPgto.pAdicionaLinhaLayoutNovo(AStringLinha: String);
Var
  LintIndiceRegistro: Integer;
  LlstCampos: TStringList;
begin
  LlstCampos := Nil;
  try
    LlstCampos := TStringList.Create;
    LlstCampos.Delimiter     := ';';
    LlstCampos.DelimitedText := StringReplace(AStringLinha, ' ', '_', [rfReplaceAll]);
    LlstCampos.DelimitedText := StringReplace(LlstCampos.DelimitedText, 'R$', EmptyStr, [rfReplaceAll]);

    If (Pos('Marketplace;Seller;Data de Criação do Lançamento;Pedido;Pedido Site;Status do Pedido;', AStringLinha) <= 0) Then
    Begin
      If Trim(AStringLinha) = '' Then
        Exit;

      If (TB2WFuncoes.fEmptyStr(fGetDados(LlstCampos[11])) And (fGetDados(LlstCampos[5]) = 'Bloqueado')) Then
        Exit;

      LintIndiceRegistro := lstRegistrosJaLancados.IndexOf(fGetDados(LlstCampos[3]));

      lstRegistrosJaLancados.Add(fGetDados(LlstCampos[3]));

      SetLength(FRegB2WPgto, Length(FRegB2WPgto) + 1);

      if not TB2WFuncoes.fEmptyStr(fGetDados(LlstCampos[7])) then
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipReg := fGetDados(LlstCampos[7])
      Else
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipReg := fGetDados(Copy(LlstCampos[10], 1, Pos('_',LlstCampos[10]) - 1));


      FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodEst := VS_CodigoEmpresa;

      If VS_ListaEstabelecimentos.IndexOf(VS_CodigoEmpresa) < 0 Then
        VS_ListaEstabelecimentos.Add(VS_CodigoEmpresa);

      if LlstCampos[3] <> '' then  //se coluna [3] preenchida
      begin
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := fGetDados(LlstCampos[3]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := fGetDados(LlstCampos[3]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := fGetDados(LlstCampos[3]);
      end
      else
      begin
        if (LlstCampos[7] = 'Despesa_inicial') and
           (Pos('Pedido', LlstCampos[10]) <> 0) then
        begin
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := Copy(LlstCampos[10], Pos('Pedido', LlstCampos[10]) + 7, 12);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := Copy(LlstCampos[10], Pos('Pedido', LlstCampos[10]) + 7, 12);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := Copy(LlstCampos[10], Pos('Pedido', LlstCampos[10]) + 7, 12);
        end
        else
        if (MatchStr(LlstCampos[7], ['Diferenca_credito_desconto', 'Diferenca_debito_desconto'])) and
           (Pos('Processo', LlstCampos[10]) <> 0) then
        begin
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strCodAut := Copy(LlstCampos[10], Pos('Processo:', LlstCampos[10]) +10, 9);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPed := Copy(LlstCampos[10], Pos('Processo:', LlstCampos[10]) +10, 9);
          FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumEnt := Copy(LlstCampos[10], Pos('Processo:', LlstCampos[10]) +10, 9);
        end
        else
        If (LlstCampos[10] = 'IR') And
           (Pos('ImpostodeRenda', LlstCampos[10]) <> 0) then
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

      If LlstCampos[2] <> '' Then
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(LlstCampos[2])
      Else
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(LlstCampos[6]);

      If FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra = '' Then
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaTra := fGetDados(LlstCampos[9]);

      FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaPag := fGetDados(LlstCampos[12]);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValBru := fGetDados(LlstCampos[11], True, 0);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValCom := 0;
      FRegB2WPgto[Length(FRegB2WPgto) - 1].fltValLiq := fGetDados(LlstCampos[11], True, 0);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strStatus := fGetDados(LlstCampos[8]);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strMarca_ := fGetDados(LlstCampos[0]);
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strTipPag := 'a vista';
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPar := '01';
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strTotPar := '01';
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strImpNov := 'S';

      If LlstCampos[14] <> '' Then
      Begin
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strNumPar := fGetDados(LlstCampos[14]);
        FRegB2WPgto[Length(FRegB2WPgto) - 1].strTotPar := fGetDados(LlstCampos[14]);
      End;

      FRegB2WPgto[Length(FRegB2WPgto) - 1].strNomArq := strNomArq;
      FRegB2WPgto[Length(FRegB2WPgto) - 1].strDtaArq := Copy(strDtaArq, 7, 4) + '/' + Copy(strDtaArq, 4, 2) + '/' + Copy(strDtaArq, 1, 2);

      strRegAnt := fGetDados(LlstCampos[3]);
    End;
  finally
    TB2WFuncoes.FreeAndNilStringLists(LlstCampos);
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

procedure TB2WPgto.pGravarRegistros(var pgbProg: TcxProgressBar);
Var
  LRegistros : TUniQuery;
  intCont  : Integer;
begin
  LRegistros := Nil;
  Try
    LRegistros := VS_FuncoesExternas.fICriaQuery;
    LRegistros.SQL.Text := TB2WFuncoes.RetornaSQLReplace('B2W_B2PGTO',['B2W_CONCIL']);

    FPagamentosImportados := False;

    pgbProg.Position := 0;

    If Length(FRegB2WPgto) = 0 Then
      Exit;

    pgbProg.Properties.Max      := Length(FRegB2WPgto)-1;
    For intCont := 0 To Length(FRegB2WPgto)-1 Do
    Begin
      If (FRegB2WPgto[intCont].fltValLiq <> 0) And
         (FRegB2WPgto[intCont].strCodAut <> '')
          And(FRegB2WPgto[intCont].strDtaTra <> '') Then
      Begin
        LRegistros.Close;

        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_TIPREG', fRetVal(FRegB2WPgto[intCont].strTipReg));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_CODAUT', fRetVal(FRegB2WPgto[intCont].strCodAut));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_DTATRA', fRetVal(FRegB2WPgto[intCont].strDtaTra, True));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_DTAPAG', fRetVal(FRegB2WPgto[intCont].strDtaPag, True));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_VALBRU', fRetVal(FRegB2WPgto[intCont].fltValBru));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_VALCOM', fRetVal(FRegB2WPgto[intCont].fltValCom));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_VALLIQ', fRetVal(FRegB2WPgto[intCont].fltValLiq));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_STATUS', fRetVal(FRegB2WPgto[intCont].strStatus));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_NOMARQ', fRetVal(FRegB2WPgto[intCont].strNomArq));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_DTAARQ', fRetVal(FRegB2WPgto[intCont].strDtaArq));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_CODEST', fRetVal(FRegB2WPgto[intCont].strCodEst));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_NUMPAR', fRetVal(FRegB2WPgto[intCont].strNumPar));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_TOTPAR', fRetVal(FRegB2WPgto[intCont].strTotPar));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_NUMCAR', '00000000000000');
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_MARCA_', fRetVal(FRegB2WPgto[intCont].strMarca_));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_NUMPED', fRetVal(FRegB2WPgto[intCont].strNumPed));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_TIPPAG', fRetVal(FRegB2WPgto[intCont].strTipPag));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_NUMENT', fRetVal(FRegB2WPgto[intCont].strNumEnt));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_CODEMP', fRetVal(FRegB2WPgto[intCont].strCodEst));
        TB2WFuncoes.CarregaParametroDataset(LRegistros, 'B2W_IMPNOV', fRetVal(FRegB2WPgto[intCont].strimpNov));

        LRegistros.ExecSQL;


        If MatchStr(fRetVal(FRegB2WPgto[intCont].strStatus), ['Liberado','Unlocked']) Then
          FPagamentosImportados := True;
      End;

      TB2WFuncoes.pStepStatusGravacao(pgbProg);
    End;

    TB2WFuncoes.GravarEstabelecimentos;
  Finally
    TB2WFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

end.
