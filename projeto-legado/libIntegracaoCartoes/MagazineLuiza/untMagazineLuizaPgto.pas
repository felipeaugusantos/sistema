{********************************************}
{* Importação de arquivos do MAGAZINE LUIZA *}
{*****************************************AJ*}
unit untMagazineLuizaPgto;

interface

uses Classes, StrUtils, SysUtils, Variants, untIIntegracaoCartoes, ComCtrls, Dialogs, Forms;

Type
  TRegistroPgto = Record
    strTipReg: String;
    strDtaPed: String;
    strDtaPag: String;
    strID_Mlz: String;
    strID_Sel: String;
    strID_Tra: String;
    strNum_NF: String;
    strNomCli: String;
    strNumPar: String;
    strTotPar: String;
    fltValBru: Double;
    fltValLiq: Double;
    fltValAnt: Double;
    fltValPed: Double;
    fltValCom: Double;
    strOrigem: String;
    strObserv: String;
    strNomArq: String;
    strDtaArq: String;
    PedidoEvento: String;
    Versao2026: String;
    IDRepasse: String;
    ValorMDR,
    ValorSubsidio: Double;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroMagazineLuizaPgto  = Array Of TRegistroPgto;

  TArrEstruturaMagazineLuizaPgto = Array Of TEstruturaPgto;

  TMagazineLuizaPgto = Class(TInterfacedObject, ICartoes)
  Private
    function fRetVal(strVal: Variant; blnData: Boolean = False; blnCompleta: Boolean = True): Variant;

    function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0; AValidaE15: Boolean = False): Variant;

    function RetornaListaDeCampos(AObjetoCampos: TArrEstruturaMagazineLuizaPgto): TStringList;

    procedure pValidarSeOArquivoFoiAlterado(strLinhaDoArquivo: String);

    function RetornaValorLista(ALista: TStringList;
                               ANomeCampo: String): String;
  Public
    procedure pAdicionaLinha(strString: String);
     procedure pAdicionaLinhaLayout2026(AStringLinha: String);
    procedure pGravarRegistros(pgbProg: TProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaMagazineLuizaPgto;
  End;

Var
  strDtaArq,
  strNomArq,
  strDtaPag: String;
  lstChave : TStringList;

  VS_IndicesCampos: TStringList;

Const
  NOMTAB = 'MLZ_MZPGTO';
  INICAM = 'MLZ_';

implementation

uses untFuncoes,untIDataSet, untMagazineLuiza;

{ TMagazineLuizaPgto }

{************************************************}
{* RETORNA A ESTRUTURA DA  TABELA  DE PAGAMENTO *}
{* MLZ_MZPGTO                                   *}
{*********************************************AJ*}
function TMagazineLuizaPgto.fGetDados(strValor: String; blnFlt: Boolean;
  intCasas: Integer; AValidaE15: Boolean): Variant;
  Var
    rst     : Variant;
    i       : Integer;
    strZeros: String;
Begin
  rst := ' ';
  If strValor <> '' Then
    rst := strValor;

  If blnFlt Then
  Begin
    strZeros := '';
    For i := 1 to intCasas do
      strZeros := strZeros + '0';

    If rst = ' ' Then
      rst := 0;

    If Not strValor.Contains(',') Then
      rst := StringReplace(rst, '.', ',', []);
    rst := fStrToFloat(rst) / StrtoFloat('1' + strZeros);
  End;

  If Not blnFlt Then
  Begin
    If rst = '7E+15' Then
      Raise Exception.Create('Não é possível importar o arquivo ' + strNomArq + '.' + #13 +
                             'O arquivo foi aberto e salvo em um programa de terceiros, como Excel ou Calc. ' +
                             'A importação deve ser realizada a partir do csv convertivo pelo xls "puro" baixado do portal, sem qualquer alteração.' + #13 +
                             'A operação foi cancelada.');

    If AValidaE15 Then
    Begin
      If Pos('E+15', rst) > 0  Then
        Raise Exception.Create('Não é possível importar o arquivo ' + strNomArq + '.' + #13 +
                               'O arquivo foi aberto e salvo em um programa de terceiros, como Excel ou Calc. ' +
                               'A importação deve ser realizada a partir do csv convertivo pelo xls "puro" baixado do portal, sem qualquer alteração.' + #13 +
                               'A operação foi cancelada.');
    End;
  End;

  Result := rst;
end;

class function TMagazineLuizaPgto.fRetEstruturaPgto(strTabela: String): TArrEstruturaMagazineLuizaPgto;
Begin
  If strTabela = NOMTAB Then
  Begin
    SetLength(Result, 23);

    Result[0].strDescri  := INICAM + 'TIPREG'; Result[0].strTipCmp  := 'VARCHAR(40)'  ;
    Result[1].strDescri  := INICAM + 'DTAPAG'; Result[1].strTipCmp  := 'DATETIME'     ;
    Result[2].strDescri  := INICAM + 'DTAPED'; Result[2].strTipCmp  := 'DATETIME'     ;
    Result[3].strDescri  := INICAM + 'ID_MLZ'; Result[3].strTipCmp  := 'VARCHAR(30)'  ;
    Result[4].strDescri  := INICAM + 'ID_SEL'; Result[4].strTipCmp  := 'VARCHAR(33)'  ;
    Result[5].strDescri  := INICAM + 'ID_TRA'; Result[5].strTipCmp  := 'VARCHAR(20)'  ;
    Result[6].strDescri  := INICAM + 'NUM_NF'; Result[6].strTipCmp  := 'VARCHAR(15)'  ;
    Result[7].strDescri  := INICAM + 'NUMPAR'; Result[7].strTipCmp  := 'VARCHAR(2)'   ;
    Result[8].strDescri  := INICAM + 'TOTPAR'; Result[8].strTipCmp  := 'VARCHAR(2)'   ;
    Result[9].strDescri  := INICAM + 'NOMCLI'; Result[9].strTipCmp  := 'VARCHAR(110)' ;
    Result[10].strDescri := INICAM + 'VALBRU'; Result[10].strTipCmp := 'DECIMAL(12,2)';
    Result[11].strDescri := INICAM + 'VALLIQ'; Result[11].strTipCmp := 'DECIMAL(12,2)';
    Result[12].strDescri := INICAM + 'VALANT'; Result[12].strTipCmp := 'DECIMAL(12,2)';
    Result[13].strDescri := INICAM + 'VALPED'; Result[13].strTipCmp := 'DECIMAL(12,2)';
    Result[14].strDescri := INICAM + 'VALCOM'; Result[14].strTipCmp := 'DECIMAL(12,2)';
    Result[15].strDescri := INICAM + 'ORIGEM'; Result[15].strTipCmp := 'VARCHAR(15)'  ;
    Result[16].strDescri := INICAM + 'OBSERV'; Result[16].strTipCmp := 'VARCHAR(250)' ;
    Result[17].strDescri := INICAM + 'NOMARQ'; Result[17].strTipCmp := 'VARCHAR(255)' ;
    Result[18].strDescri := INICAM + 'DTAARQ'; Result[18].strTipCmp := 'DATE'         ;
    Result[19].strDescri := INICAM + 'CONCIL'; Result[19].strTipCmp := 'INT DEFAULT 0';
    Result[20].strDescri := INICAM + 'PEDEVE'; Result[20].strTipCmp := 'VARCHAR(50)'  ;
    Result[21].strDescri := INICAM + 'VER_26'; Result[21].strTipCmp := 'CHAR(1) DEFAULT ''N''     ';
    Result[22].strDescri := INICAM + 'VALSUB'; Result[22].strTipCmp := 'DECIMAL(12,2) DEFAULT 0.00';
  End;
End;

class function TMagazineLuizaPgto.fRetSQLTabelaRegPgto(strTabela: String): String;
Var arrCampos: TArrEstruturaMagazineLuizaPgto;
    intCont  : Integer;
begin
  Result := 'CREATE TABLE ' + strTabela + '(';
  arrCampos := fRetEstruturaPgto(strTabela);

  For intCont := 0 to Length(arrCampos) - 1 do
    Result := Result + arrCampos[intCont].strDescri + ' ' + arrCampos[intCont].strTipCmp + ', ';

  Result := Result + ' PRIMARY KEY(MLZ_TIPREG,MLZ_DTAPAG,MLZ_DTAPED,MLZ_ID_MLZ,MLZ_ID_SEL,MLZ_ID_TRA,MLZ_NUMPAR)) ENGINE INNODB ' ;
end;

procedure TMagazineLuizaPgto.pAdicionaLinha(strString: String);
Var
  lstCampos       : TStringList;
  intRegistro,
  intTestar       : Integer;
  blnAchouRegistro: Boolean;
begin
  lstCampos := Nil;

  Try
    lstCampos := TStringList.Create;
    lstCampos.Delimiter     := ';';
    lstCampos.DelimitedText := StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]);

    If Not Assigned(VS_IndicesCampos) Then
    Begin
      VS_IndicesCampos := TStringList.Create;
      VS_IndicesCampos.StrictDelimiter := True;
      VS_IndicesCampos.Delimiter := ';';
    End;

    If Not Assigned(lstEstabel) Then
      lstEstabel := TStringList.Create;

    If Not Assigned(lstChave) Then
      lstChave := TStringList.Create;

    Try
      If (Pos('ID do pedido Magazine Luiza', strString) > 0) Then
      Begin
        VS_IndicesCampos.DelimitedText := strString;
        Exit;
      End;

      If lstCampos.Count = 0 Then
        Exit;

      If (Not TryStrToInt(LeftStr(strString, 1), intTestar)) Or
         (Pos(';', strString) = 0)  Then
        Exit;

      pValidarSeOArquivoFoiAlterado(StringReplace(strString, ' ', EmptyStr, [rfReplaceAll]));

      intRegistro := lstChave.IndexOf(fGetDados(RetornaValorLista(lstCampos, 'Data da transação')) + '_' +
                                      fGetDados(RetornaValorLista(lstCampos, 'Data do pedido')) + '_' +
                                      fGetDados(RetornaValorLista(lstCampos, 'ID do pedido Magazine Luiza')) + '_' +
                                      fGetDados(RetornaValorLista(lstCampos, 'Método de pagamento')) + '_' +
                                      fGetDados(RetornaValorLista(lstCampos, 'Parcela atual')) + '_' +
                                      strNomArq);


      blnAchouRegistro := intRegistro > -1;
      If Not blnAchouRegistro Then
      Begin
        SetLength(FRegMagazineLuizaPgto, Length(FRegMagazineLuizaPgto) + 1);
        intRegistro := Length(FRegMagazineLuizaPgto) - 1;
        lstChave.Add(fGetDados(RetornaValorLista(lstCampos, 'Data da transação')) + '_' +
                     fGetDados(RetornaValorLista(lstCampos, 'Data do pedido')) + '_' +
                     fGetDados(RetornaValorLista(lstCampos, 'ID do pedido Magazine Luiza')) + '_' +
                     fGetDados(RetornaValorLista(lstCampos, 'Método de pagamento')) + '_' +
                     fGetDados(RetornaValorLista(lstCampos, 'Parcela atual')) + '_' +
                     strNomArq);
      End;

      FRegMagazineLuizaPgto[intRegistro].strTipReg := fGetDados(RetornaValorLista(lstCampos, 'Método de pagamento'));
      FRegMagazineLuizaPgto[intRegistro].strDtaPed := fGetDados(RetornaValorLista(lstCampos, 'Data do pedido'));
      FRegMagazineLuizaPgto[intRegistro].strDtaPag := fGetDados(RetornaValorLista(lstCampos, 'Data da transação'));
      FRegMagazineLuizaPgto[intRegistro].strID_Mlz := fGetDados(RetornaValorLista(lstCampos, 'ID do pedido Magazine Luiza'), False, 0, True);
      FRegMagazineLuizaPgto[intRegistro].strID_Sel := fGetDados(RetornaValorLista(lstCampos, 'ID do pedido Seller'), False, 0, True);
      FRegMagazineLuizaPgto[intRegistro].strID_Tra := fGetDados(RetornaValorLista(lstCampos, 'ID da transação'), False, 0, True);
      FRegMagazineLuizaPgto[intRegistro].strNum_NF := fGetDados(RetornaValorLista(lstCampos, 'Número da nota fiscal'));
      FRegMagazineLuizaPgto[intRegistro].strNomCli := fGetDados(RetornaValorLista(lstCampos, 'Nome do cliente'));
      FRegMagazineLuizaPgto[intRegistro].strNumPar := fGetDados(RetornaValorLista(lstCampos, 'Parcela atual'));
      FRegMagazineLuizaPgto[intRegistro].strTotPar := fGetDados(RetornaValorLista(lstCampos, 'Total de parcelas'));
      If FRegMagazineLuizaPgto[intRegistro].strTotPar = '' Then
        FRegMagazineLuizaPgto[intRegistro].strTotPar := '1';

      FRegMagazineLuizaPgto[intRegistro].fltValLiq := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValLiq, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor líquido da parcela'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValBru := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValBru, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor bruto da parcela'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValPed := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValPed, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor bruto do pedido'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValAnt := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValAnt, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor da antecipação'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValCom := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValCom, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor do Serviços de Marketplace por parcela'), True, 0);

      FRegMagazineLuizaPgto[intRegistro].strOrigem := fGetDados(RetornaValorLista(lstCampos, 'Origem'));
      FRegMagazineLuizaPgto[intRegistro].strObserv := fGetDados(RetornaValorLista(lstCampos, 'Observações'));

      FRegMagazineLuizaPgto[intRegistro].strNomArq := strNomArq;
      FRegMagazineLuizaPgto[intRegistro].strDtaArq := strDtaArq;

      FRegMagazineLuizaPgto[intRegistro].ValorSubsidio := 0.00;

      //Registros de transferência
      If FRegMagazineLuizaPgto[intRegistro].strTipReg = 'Transferência' Then
      Begin
        FRegMagazineLuizaPgto[intRegistro].strDtaPed := FRegMagazineLuizaPgto[intRegistro].strDtaPag;
        FRegMagazineLuizaPgto[intRegistro].strID_Mlz := FRegMagazineLuizaPgto[intRegistro].fltValLiq.ToString
                                                        .Replace(',', EmptyStr).Replace('.', EmptyStr) +
                                                        FRegMagazineLuizaPgto[intRegistro].strDtaPag.Replace('/', EmptyStr).Replace(':', EmptyStr);
        FRegMagazineLuizaPgto[intRegistro].strID_Sel := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;
        FRegMagazineLuizaPgto[intRegistro].strID_Tra := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;

        If Trim(fGetDados(RetornaValorLista(lstCampos, 'external_withdraw_id'))) <> '' Then
        Begin
          FRegMagazineLuizaPgto[intRegistro].strID_Mlz := fGetDados(RetornaValorLista(lstCampos, 'external_withdraw_id'));
          FRegMagazineLuizaPgto[intRegistro].strID_Sel := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;
          FRegMagazineLuizaPgto[intRegistro].strID_Tra := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;
        End;

        FRegMagazineLuizaPgto[intRegistro].strNumPar := '1';
        FRegMagazineLuizaPgto[intRegistro].strTotPar := '1';
      End
      //Registros de Eventos (pegando o pedido)
      Else If FRegMagazineLuizaPgto[intRegistro].strTipReg = 'Evento' Then
      Begin
        If FRegMagazineLuizaPgto[intRegistro].strOrigem <> '' Then
          FRegMagazineLuizaPgto[intRegistro].strObserv := FRegMagazineLuizaPgto[intRegistro].strOrigem + FRegMagazineLuizaPgto[intRegistro].strObserv;

        If Pos('pedidos:', fGetDados(lstCampos[VS_IndicesCampos.IndexOf('Observações') + 1])) > 0 Then
          FRegMagazineLuizaPgto[intRegistro].PedidoEvento := StringReplace(fGetDados(lstCampos[VS_IndicesCampos.IndexOf('Observações') + 1]), 'pedidos:', EmptyStr, [rfReplaceAll]);
      End;

      If Trim(FRegMagazineLuizaPgto[intRegistro].strID_Mlz) = '' Then
        FRegMagazineLuizaPgto[intRegistro].strID_Mlz := FRegMagazineLuizaPgto[intRegistro].strDtaPag.Replace('/', EmptyStr).Replace(':', EmptyStr);

      If Trim(FRegMagazineLuizaPgto[intRegistro].strID_Sel) = '' Then
        FRegMagazineLuizaPgto[intRegistro].strID_Sel := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;

      FRegMagazineLuizaPgto[intRegistro].IDRepasse := fGetDados(RetornaValorLista(lstCampos, 'ID do repasse'));
      FRegMagazineLuizaPgto[intRegistro].Versao2026 := 'N';

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao importar o arquivo.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    If Assigned(lstCampos) Then
      FreeAndNil(lstCampos);
  End;
end;


procedure TMagazineLuizaPgto.pAdicionaLinhaLayout2026(AStringLinha: String);
  Var
  lstCampos       : TStringList;

  intRegistro,
  LTestarValorInteiro: Integer;

  blnAchouRegistro: Boolean;
begin
  lstCampos := Nil;

  Try
    lstCampos := TStringList.Create;
    lstCampos.Delimiter     := ';';
    lstCampos.DelimitedText := StringReplace(AStringLinha.Replace('; pedidos: ', ', pedidos: '), ' ', EmptyStr, [rfReplaceAll]);

    If Not Assigned(VS_IndicesCampos) Then
    Begin
      VS_IndicesCampos := TStringList.Create;
      VS_IndicesCampos.StrictDelimiter := True;
      VS_IndicesCampos.Delimiter := ';';
    End;

    If Not Assigned(lstEstabel) Then
      lstEstabel := TStringList.Create;

    If Not Assigned(lstChave) Then
      lstChave := TStringList.Create;

    Try
      If (Pos('Número do pedido;', AStringLinha) > 0) Then
      Begin
        VS_IndicesCampos.DelimitedText := AStringLinha;
        Exit;
      End;

      If lstCampos.Count = 0 Then
        Exit;

      intRegistro := lstChave.IndexOf(fGetDados(RetornaValorLista(lstCampos, 'Data do repasse')) + '_' +
                                      fGetDados(RetornaValorLista(lstCampos, 'Data do pedido')) + '_' +
                                      fGetDados(RetornaValorLista(lstCampos, 'Número do pedido')) + '_' +
                                      fGetDados(RetornaValorLista(lstCampos, 'Forma de pagamento')) + '_' +
                                      fGetDados(RetornaValorLista(lstCampos, 'Parcela atual')) + '_' +
                                      strNomArq);


      blnAchouRegistro := intRegistro > -1;
      If Not blnAchouRegistro Then
      Begin
        SetLength(FRegMagazineLuizaPgto, Length(FRegMagazineLuizaPgto) + 1);
        intRegistro := Length(FRegMagazineLuizaPgto) - 1;
        lstChave.Add(fGetDados(RetornaValorLista(lstCampos, 'Data do repasse')) + '_' +
                     fGetDados(RetornaValorLista(lstCampos, 'Data do pedido')) + '_' +
                     fGetDados(RetornaValorLista(lstCampos, 'Número do pedido')) + '_' +
                     fGetDados(RetornaValorLista(lstCampos, 'Forma de pagamento')) + '_' +
                     fGetDados(RetornaValorLista(lstCampos, 'Parcela atual')) + '_' +
                     strNomArq);
      End;

      FRegMagazineLuizaPgto[intRegistro].strTipReg := fGetDados(RetornaValorLista(lstCampos, 'Forma de pagamento'));
      FRegMagazineLuizaPgto[intRegistro].strDtaPed := fGetDados(RetornaValorLista(lstCampos, 'Data do pedido'));
      FRegMagazineLuizaPgto[intRegistro].strDtaPag := fGetDados(RetornaValorLista(lstCampos, 'Data do repasse'));
      FRegMagazineLuizaPgto[intRegistro].strID_Mlz := fGetDados(RetornaValorLista(lstCampos, 'Número do pedido').Replace('LU-', EmptyStr), False, 0, True);
      FRegMagazineLuizaPgto[intRegistro].strID_Sel := fGetDados(RetornaValorLista(lstCampos, 'Número do pedido'), False, 0, True);
      FRegMagazineLuizaPgto[intRegistro].strID_Tra := fGetDados(RetornaValorLista(lstCampos, 'ID da transação'), False, 0, True);
      FRegMagazineLuizaPgto[intRegistro].strNum_NF := fGetDados(RetornaValorLista(lstCampos, 'Número da nota fiscal'));
      FRegMagazineLuizaPgto[intRegistro].strNomCli := fGetDados(RetornaValorLista(lstCampos, 'Nome do cliente'));
      FRegMagazineLuizaPgto[intRegistro].strNumPar := fGetDados(RetornaValorLista(lstCampos, 'Parcela atual').Replace('N/A', '01').Split(['/'])[0]);
      FRegMagazineLuizaPgto[intRegistro].strTotPar := fGetDados(RetornaValorLista(lstCampos, 'Total de parcelas').Replace('N/A', '01'));
      If Not TryStrToInt(FRegMagazineLuizaPgto[intRegistro].strTotPar, LTestarValorInteiro) Then
        FRegMagazineLuizaPgto[intRegistro].strTotPar := '01';
      If FRegMagazineLuizaPgto[intRegistro].strTotPar.IsEmpty Then
        FRegMagazineLuizaPgto[intRegistro].strTotPar := '01';


      FRegMagazineLuizaPgto[intRegistro].fltValLiq := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValLiq, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor do repasse financeiro da parcela (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValBru := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValBru, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor bruto da parcela (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValPed := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValPed, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor do bruto do pedido para base calculo (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValAnt := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValAnt, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Custo da Antecipação por parcela (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValCom := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValCom, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor de desconto dos Serviços do marketplace por parcela (R$)'), True, 0);

      FRegMagazineLuizaPgto[intRegistro].ValorMDR := 0.00;

      FRegMagazineLuizaPgto[intRegistro].strOrigem := fGetDados(RetornaValorLista(lstCampos, 'Origem'));
      FRegMagazineLuizaPgto[intRegistro].strObserv := fGetDados(RetornaValorLista(lstCampos, 'Observações'));

      FRegMagazineLuizaPgto[intRegistro].strNomArq := strNomArq;
      FRegMagazineLuizaPgto[intRegistro].strDtaArq := strDtaArq;

      FRegMagazineLuizaPgto[intRegistro].ValorSubsidio := IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].ValorSubsidio, 0) +
                                                          fGetDados(RetornaValorLista(lstCampos, 'Valor de reembolso do subsídio a ser pago pelo Magalu por parcela (R$)'), True, 0);


      //Registros de transferência
      If FRegMagazineLuizaPgto[intRegistro].strTipReg = 'Transferência' Then
      Begin
        FRegMagazineLuizaPgto[intRegistro].strDtaPed := FRegMagazineLuizaPgto[intRegistro].strDtaPag;
        FRegMagazineLuizaPgto[intRegistro].strID_Mlz := FRegMagazineLuizaPgto[intRegistro].fltValLiq.ToString
                                                        .Replace(',', EmptyStr).Replace('.', EmptyStr) +
                                                        FRegMagazineLuizaPgto[intRegistro].strDtaPag.Replace('/', EmptyStr).Replace(':', EmptyStr);
        FRegMagazineLuizaPgto[intRegistro].strID_Sel := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;
        FRegMagazineLuizaPgto[intRegistro].strID_Tra := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;

        If Trim(fGetDados(RetornaValorLista(lstCampos, 'external_withdraw_id'))) <> '' Then
        Begin
          FRegMagazineLuizaPgto[intRegistro].strID_Mlz := fGetDados(RetornaValorLista(lstCampos, 'external_withdraw_id'));
          FRegMagazineLuizaPgto[intRegistro].strID_Sel := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;
          FRegMagazineLuizaPgto[intRegistro].strID_Tra := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;
        End;

        FRegMagazineLuizaPgto[intRegistro].strNumPar := '01';
        FRegMagazineLuizaPgto[intRegistro].strTotPar := '01';
      End
      //Registros de Eventos (pegando o pedido)
      Else If FRegMagazineLuizaPgto[intRegistro].strTipReg = 'Evento' Then
      Begin
        If FRegMagazineLuizaPgto[intRegistro].strOrigem <> '' Then
          FRegMagazineLuizaPgto[intRegistro].strObserv := FRegMagazineLuizaPgto[intRegistro].strOrigem + FRegMagazineLuizaPgto[intRegistro].strObserv;

        If FRegMagazineLuizaPgto[intRegistro].strObserv.Contains(',pedidos:') Then
          FRegMagazineLuizaPgto[intRegistro].PedidoEvento := Copy(FRegMagazineLuizaPgto[intRegistro].strObserv,
                                                                  Pos(',pedidos:', FRegMagazineLuizaPgto[intRegistro].strObserv) + 9,
                                                                  FRegMagazineLuizaPgto[intRegistro].strObserv.Length);
      End;

      If Trim(FRegMagazineLuizaPgto[intRegistro].strID_Mlz) = '' Then
        FRegMagazineLuizaPgto[intRegistro].strID_Mlz := FRegMagazineLuizaPgto[intRegistro].strDtaPag.Replace('/', EmptyStr).Replace(':', EmptyStr);

      If Trim(FRegMagazineLuizaPgto[intRegistro].strID_Sel) = '' Then
        FRegMagazineLuizaPgto[intRegistro].strID_Sel := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;

      FRegMagazineLuizaPgto[intRegistro].strNumPar := fStrZero(FRegMagazineLuizaPgto[intRegistro].strNumPar, 2);
      FRegMagazineLuizaPgto[intRegistro].strTotPar := fStrZero(FRegMagazineLuizaPgto[intRegistro].strTotPar, 2);

      FRegMagazineLuizaPgto[intRegistro].IDRepasse := fGetDados(RetornaValorLista(lstCampos, 'ID do repasse'));
      FRegMagazineLuizaPgto[intRegistro].Versao2026 := 'S';

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao importar o arquivo.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  Finally
    If Assigned(lstCampos) Then
      FreeAndNil(lstCampos);
  End;
end;

function TMagazineLuizaPgto.fRetVal(strVal: Variant; blnData: Boolean = False; blnCompleta: Boolean = True): Variant;
Begin
  If fEmptyStr(strVal) Then
    Result := Null
  Else
  Begin
    If (blnData) Then
    Begin
      If blnCompleta Then
      Begin
        Result := Copy(strVal, 7, 4) + '/' + Copy(strVal, 4, 2) + '/' + Copy(strVal, 1, 2);
        Result := Result + ' ' + Copy(strVal, 12, 8);
      End
      Else
        Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 6, 2) + '/' + Copy(strVal, 9, 2);
    End
    else
      Result := strVal;
  End;
End;

procedure TMagazineLuizaPgto.pGravarRegistros(pgbProg: TProgressBar);
  Var
    qryDados : IDataSet;
    intCont  : Integer;
    strSQL   : String;

    LTabelaPgto: IDataSet;
begin
  LTabelaPgto := objFunctions.fGetDataSet;
  LTabelaPgto.SQL := 'SELECT * FROM ' + NOMTAB + ' WHERE FALSE';
  LTabelaPgto.Open;

  strSQL := RetornaSQLReplace(NOMTAB,
                              RetornaListaDeCampos(fRetEstruturaPgto(NOMTAB)),
                              ['MLZ_CONCIL']);

  qryDados := objFunctions.fGetDataSet;
  qryDados.Close;
  qryDados.SQL := strSQL;

  pgbProg.Position := 0;


  If Length(FRegMagazineLuizaPgto) <= 0 Then
    Exit;

  Try
    pgbProg.Max      := Length(FRegMagazineLuizaPgto)-1;
    For intCont := 0 To Length(FRegMagazineLuizaPgto)-1 Do
    Begin
      If (FRegMagazineLuizaPgto[intCont].strTipReg.Trim = '') Then
        Continue;

      Application.ProcessMessages;
      qryDados.Close;

      qryDados.ParamByName(INICAM + 'TIPREG').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strTipReg);
      qryDados.ParamByName(INICAM + 'DTAPAG').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strDtaPag, True, True);
      qryDados.ParamByName(INICAM + 'DTAPED').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strDtaPed, True, True);

      If fEmptyStr(FRegMagazineLuizaPgto[intCont].strDtaPed) Then
        qryDados.ParamByName(INICAM + 'DTAPED').Value := qryDados.ParamByName(INICAM + 'DTAPAG').Value;

      qryDados.ParamByName(INICAM + 'ID_MLZ').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strId_Mlz);
      qryDados.ParamByName(INICAM + 'ID_SEL').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strId_Sel);
      If (UpperCase(fRetVal(FRegMagazineLuizaPgto[intCont].strTipReg)) = 'EVENTO') And
         (FRegMagazineLuizaPgto[intCont].strId_Mlz.Trim = '') Then
      Begin
        qryDados.ParamByName(INICAM + 'ID_MLZ').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strId_Tra);
        qryDados.ParamByName(INICAM + 'ID_SEL').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strId_Tra);
      End;

      qryDados.ParamByName(INICAM + 'ID_TRA').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strId_Tra);
      qryDados.ParamByName(INICAM + 'NUM_NF').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strNum_NF);
      qryDados.ParamByName(INICAM + 'NOMCLI').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strNomCli);
      qryDados.ParamByName(INICAM + 'NUMPAR').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strNumPar);
      qryDados.ParamByName(INICAM + 'TOTPAR').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strTotPar);
      qryDados.ParamByName(INICAM + 'OBSERV').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strObserv);
      qryDados.ParamByName(INICAM + 'ORIGEM').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strOrigem);
      qryDados.ParamByName(INICAM + 'VALBRU').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].fltValBru);
      qryDados.ParamByName(INICAM + 'VALLIQ').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].fltValLiq);
      qryDados.ParamByName(INICAM + 'VALANT').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].fltValAnt);
      qryDados.ParamByName(INICAM + 'VALPED').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].fltValPed);
      qryDados.ParamByName(INICAM + 'VALCOM').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].fltValCom);
      qryDados.ParamByName(INICAM + 'NOMARQ').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strNomArq);
      qryDados.ParamByName(INICAM + 'DTAARQ').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].strDtaArq, True, False);
      qryDados.ParamByName(INICAM + 'VER_26').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].Versao2026);
      qryDados.ParamByName(INICAM + 'VALSUB').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].ValorSubsidio);

      If LTabelaPgto.FindField(INICAM + 'PEDEVE') <> Nil Then
        qryDados.ParamByName(INICAM + 'PEDEVE').Value  := fRetVal(FRegMagazineLuizaPgto[intCont].PedidoEvento);



      qryDados.ExecSQL;

      pgbProg.Position := pgbProg.Position + 1;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a importação do arquivo.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;

  If Assigned(VS_IndicesCampos) Then
    FreeAndNil(VS_IndicesCampos);
end;

procedure TMagazineLuizaPgto.pValidarSeOArquivoFoiAlterado(
  strLinhaDoArquivo: String);
  Var
    stlCamposDoArquivo: TStringList;
    blnArquivoValido  : Boolean;
begin
  If strLinhaDoArquivo.IsEmpty Then
    Exit;

  stlCamposDoArquivo           := TStringList.Create;
  stlCamposDoArquivo.Delimiter := ';';

  stlCamposDoArquivo.DelimitedText := strLinhaDoArquivo;

  //Verifica se foi adicionada coluna a mais no arquivo
  blnArquivoValido := (stlCamposDoArquivo.Count In [22, 23, 25, 26, 29, 31, 32]);

  FreeAndNil(stlCamposDoArquivo);

  If Not blnArquivoValido Then
    Raise Exception.Create('O arquivo ' + strNomArq + ' foi modificado em outro programa ou recebeu alterações no layout.'+ #13 +
                           'Para realizar a importação, o arquivo CSV não pode ter sofrido alterações.' + #13 +
                           'Operação cancelada!');
end;

function TMagazineLuizaPgto.RetornaListaDeCampos(
  AObjetoCampos: TArrEstruturaMagazineLuizaPgto): TStringList;
  Var
    LContador: Integer;
begin
  Result := TStringList.Create;

  For LContador := 0 To Length(AObjetoCampos) - 1 Do
    Result.Add(AObjetoCampos[LContador].strDescri);
end;

function TMagazineLuizaPgto.RetornaValorLista(ALista: TStringList;
  ANomeCampo: String): String;
begin
  Try
    Result := ALista[VS_IndicesCampos.IndexOf(ANomeCampo)];
  Except
    Result := EmptyStr;
  End;
end;

end.
