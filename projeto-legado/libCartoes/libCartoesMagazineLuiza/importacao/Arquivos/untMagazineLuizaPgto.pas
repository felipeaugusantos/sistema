{********************************************}
{* Importação de arquivos do MAGAZINE LUIZA *}
{*****************************************AJ*}
unit untMagazineLuizaPgto;

interface

uses System.Classes, System.StrUtils, System.SysUtils, System.Variants,
     Vcl.ComCtrls, Vcl.Forms,

     cxProgressBar, Uni,

     untIMagazineLuizaIntegracaoLibCartoes, untTMagazineLuizaFuncoes,
     untMagazineLuizaTipos;

Type
  TMagazineLuizaPgto = Class(TInterfacedObject, ICartoesMagazineLuiza)
  Private
    function fRetVal(strVal: Variant; blnData: Boolean = False; blnCompleta: Boolean = True): Variant;

    function fGetDados(strValor: String; blnFlt: Boolean = False; intCasas: Integer = 0; AValidaE15: Boolean = False): Variant;

    procedure pValidarSeOArquivoFoiAlterado(strLinhaDoArquivo: String);

    function RetornaValorLista(ALista: TStringList;
                               ANomeCampo: String): String;

    function RetornaPeriodoPagamento: String;
    function RegistroJaImportado(ARegistro: TRegistroPgto): Boolean;

    procedure ValidaSeAsParcelasEstaoNoFormatoCorreto(ANumeroParcela,
                                                      ATotalParcelas,
                                                      ANumeroPedido: String);
  Public
    procedure pAdicionaLinha(strString: String);
    procedure pAdicionaLinhaLayout2026(AStringLinha: String);
    procedure pGravarRegistros(var pgbProg: TcxProgressBar);

    class function fRetSQLTabelaRegPgto(strTabela: String): String;
    class function fRetEstruturaPgto(strTabela: String): TArrEstruturaMagazineLuizaPgto;
  End;

Var
  strDtaArq,
  strNomArq,
  strDtaPag: String;
  lstChave : TStringList;

  VS_CodigoEmpresa: String;

  VS_IndicesCampos: TStringList;

  FRegMagazineLuizaPgto: TArrRegistroMagazineLuizaPgto;

Const
  NOMTAB = 'MLZ_MZPGTO';
  INICAM = 'MLZ_';

implementation

uses untMagazineLuiza;

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
    rst := TMagazineLuizaFuncoes.fStrToFloat(rst) / StrtoFloat('1' + strZeros);
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
    SetLength(Result, 29);

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
    Result[21].strDescri := INICAM + 'CODEMP'; Result[21].strTipCmp := 'CHAR(3)'      ;
    Result[22].strDescri := INICAM + 'TAXTRF'; Result[22].strTipCmp := 'DECIMAL(12,2) DEFAULT 0.00';
    Result[23].strDescri := INICAM + 'FIXPAR'; Result[23].strTipCmp := 'DECIMAL(12,2) DEFAULT 0.00';
    Result[24].strDescri := INICAM + 'FIXPED'; Result[24].strTipCmp := 'DECIMAL(12,2) DEFAULT 0.00';
    Result[25].strDescri := INICAM + 'VALMDR'; Result[25].strTipCmp := 'DECIMAL(12,2) DEFAULT 0.00';
    Result[26].strDescri := INICAM + 'TIPEVE'; Result[26].strTipCmp := 'VARCHAR(75) DEFAULT ''''  ';
    Result[27].strDescri := INICAM + 'VER_26'; Result[27].strTipCmp := 'CHAR(1) DEFAULT ''N''     ';
    Result[28].strDescri := INICAM + 'VALSUB'; Result[28].strTipCmp := 'DECIMAL(12,2) DEFAULT 0.00';
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

  Result := Result + ' PRIMARY KEY(MLZ_DTAPAG,MLZ_DTAPED,MLZ_ID_MLZ,MLZ_ID_SEL,MLZ_ID_TRA,MLZ_NUMPAR,MLZ_TIPREG,MLZ_TIPEVE)) ENGINE INNODB ' ;
end;

procedure TMagazineLuizaPgto.pAdicionaLinha(strString: String);
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
    lstCampos.DelimitedText := StringReplace(strString.Replace('; pedidos: ', ', pedidos: '), ' ', EmptyStr, [rfReplaceAll]);

    If Not Assigned(VS_IndicesCampos) Then
    Begin
      VS_IndicesCampos := TStringList.Create;
      VS_IndicesCampos.StrictDelimiter := True;
      VS_IndicesCampos.Delimiter := ';';
    End;

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If Not Assigned(lstChave) Then
      lstChave := TStringList.Create;

    If Not Assigned(VS_DatasPagamento) Then
      VS_DatasPagamento := TStringList.Create;

    Try
      If (Pos('ID do pedido Magazine Luiza', strString) > 0) Then
      Begin
        VS_IndicesCampos.DelimitedText := strString;
        Exit;
      End;

      If lstCampos.Count = 0 Then
        Exit;

      If (Not TryStrToInt(LeftStr(strString, 1), LTestarValorInteiro)) Or
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
                     fGetDados(RetornaValorLista(lstCampos, 'Observações')) + '_' +
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
      If Not TryStrToInt(FRegMagazineLuizaPgto[intRegistro].strTotPar, LTestarValorInteiro) Then
        FRegMagazineLuizaPgto[intRegistro].strTotPar := '01';
      If FRegMagazineLuizaPgto[intRegistro].strTotPar.IsEmpty Then
        FRegMagazineLuizaPgto[intRegistro].strTotPar := '01';

      FRegMagazineLuizaPgto[intRegistro].fltValLiq := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValLiq, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor líquido da parcela'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValBru := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValBru, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor bruto da parcela'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValPed := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValPed, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor bruto do pedido'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValAnt := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValAnt, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor da antecipação'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValCom := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValCom, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor do Serviços de Marketplace por parcela'), True, 0);

      FRegMagazineLuizaPgto[intRegistro].TaxaTransferencia := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].TaxaTransferencia, 0) +
                                                              fGetDados(RetornaValorLista(lstCampos, 'Taxa de transferência'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].ValorFixoParcela := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].ValorFixoParcela, 0) +
                                                             fGetDados(RetornaValorLista(lstCampos, 'Valor fixo por pedido parcelada'), True, 0) +
                                                             fGetDados(RetornaValorLista(lstCampos, 'Valor fixo por parcela'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].ValorFixoPedido := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].ValorFixoPedido, 0) +
                                                            fGetDados(RetornaValorLista(lstCampos, 'Valor fixo por pedido'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].ValorMDR := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].ValorMDR, 0) +
                                                     fGetDados(RetornaValorLista(lstCampos, 'MDR'), True, 0);

      FRegMagazineLuizaPgto[intRegistro].strOrigem := fGetDados(RetornaValorLista(lstCampos, 'Origem'));
      FRegMagazineLuizaPgto[intRegistro].strObserv := fGetDados(RetornaValorLista(lstCampos, 'Observações'));

      FRegMagazineLuizaPgto[intRegistro].strNomArq := strNomArq;
      FRegMagazineLuizaPgto[intRegistro].strDtaArq := strDtaArq;

      FRegMagazineLuizaPgto[intRegistro].ValorSubsidio := 0.00;

      If Not TMagazineLuizaFuncoes.fEmptyStr(FRegMagazineLuizaPgto[intRegistro].strDtaPag) Then
      Begin
        If (VS_DatasPagamento.IndexOf(FRegMagazineLuizaPgto[intRegistro].strDtaPag) < 0) Then
          VS_DatasPagamento.Add(FRegMagazineLuizaPgto[intRegistro].strDtaPag);
      End;

      FRegMagazineLuizaPgto[intRegistro].TipoEvento := FRegMagazineLuizaPgto[intRegistro].strTipReg;

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

        FRegMagazineLuizaPgto[intRegistro].TipoEvento := 'Transferência';
      End
      //Registros de Eventos (pegando o pedido)
      Else If FRegMagazineLuizaPgto[intRegistro].strTipReg = 'Evento' Then
      Begin
        If FRegMagazineLuizaPgto[intRegistro].strOrigem <> '' Then
          FRegMagazineLuizaPgto[intRegistro].strObserv := FRegMagazineLuizaPgto[intRegistro].strOrigem + FRegMagazineLuizaPgto[intRegistro].strObserv;

        If Pos('pedidos:', fGetDados(lstCampos[VS_IndicesCampos.IndexOf('Observações') + 1])) > 0 Then
          FRegMagazineLuizaPgto[intRegistro].PedidoEvento := StringReplace(fGetDados(lstCampos[VS_IndicesCampos.IndexOf('Observações') + 1]), 'pedidos:', EmptyStr, [rfReplaceAll]);

        FRegMagazineLuizaPgto[intRegistro].TipoEvento := FRegMagazineLuizaPgto[intRegistro].strObserv.Split(['|'])[0];
      End;

      If Trim(FRegMagazineLuizaPgto[intRegistro].strID_Mlz) = '' Then
        FRegMagazineLuizaPgto[intRegistro].strID_Mlz := FRegMagazineLuizaPgto[intRegistro].strDtaPag.Replace('/', EmptyStr).Replace(':', EmptyStr);

      If Trim(FRegMagazineLuizaPgto[intRegistro].strID_Sel) = '' Then
        FRegMagazineLuizaPgto[intRegistro].strID_Sel := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;

      FRegMagazineLuizaPgto[intRegistro].strNumPar := TMagazineLuizaFuncoes.fStrZero(FRegMagazineLuizaPgto[intRegistro].strNumPar, 2);
      FRegMagazineLuizaPgto[intRegistro].strTotPar := TMagazineLuizaFuncoes.fStrZero(FRegMagazineLuizaPgto[intRegistro].strTotPar, 2);

      FRegMagazineLuizaPgto[intRegistro].IDRepasse := fGetDados(RetornaValorLista(lstCampos, 'ID do repasse'));

      FRegMagazineLuizaPgto[intRegistro].Versao2026 := 'N';

      FRegMagazineLuizaPgto[intRegistro].CodigoEmpresa := VS_CodigoEmpresa;
      If VS_ListaEstabelecimentos.IndexOf(VS_CodigoEmpresa) < 0 Then
        VS_ListaEstabelecimentos.Add(VS_CodigoEmpresa);
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

    If Not Assigned(VS_ListaEstabelecimentos) Then
      VS_ListaEstabelecimentos := TStringList.Create;

    If Not Assigned(lstChave) Then
      lstChave := TStringList.Create;

    If Not Assigned(VS_DatasPagamento) Then
      VS_DatasPagamento := TStringList.Create;

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

      ValidaSeAsParcelasEstaoNoFormatoCorreto(FRegMagazineLuizaPgto[intRegistro].strNumPar,
                                              FRegMagazineLuizaPgto[intRegistro].strTotPar,
                                              FRegMagazineLuizaPgto[intRegistro].strID_Sel);

      FRegMagazineLuizaPgto[intRegistro].fltValLiq := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValLiq, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor do repasse financeiro da parcela (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValBru := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValBru, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor bruto da parcela (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValPed := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValPed, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor do bruto do pedido para base calculo (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValAnt := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValAnt, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Custo da Antecipação por parcela (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].fltValCom := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].fltValCom, 0) +
                                                      fGetDados(RetornaValorLista(lstCampos, 'Valor de desconto dos Serviços do marketplace por parcela (R$)'), True, 0);

      FRegMagazineLuizaPgto[intRegistro].TaxaTransferencia := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].TaxaTransferencia, 0) +
                                                              fGetDados(RetornaValorLista(lstCampos, 'Taxa de transferência (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].ValorFixoParcela := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].ValorFixoParcela, 0) +
                                                             fGetDados(RetornaValorLista(lstCampos, 'Valor de desconto da Tarifa fixa por parcela (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].ValorFixoPedido := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].ValorFixoPedido, 0) +
                                                            fGetDados(RetornaValorLista(lstCampos, 'Valor de desconto da Tarifa fixa por pedido (R$)'), True, 0);
      FRegMagazineLuizaPgto[intRegistro].ValorMDR := 0.00;

      FRegMagazineLuizaPgto[intRegistro].strOrigem := fGetDados(RetornaValorLista(lstCampos, 'Origem'));
      FRegMagazineLuizaPgto[intRegistro].strObserv := fGetDados(RetornaValorLista(lstCampos, 'Observações'));

      FRegMagazineLuizaPgto[intRegistro].strNomArq := strNomArq;
      FRegMagazineLuizaPgto[intRegistro].strDtaArq := strDtaArq;

      FRegMagazineLuizaPgto[intRegistro].ValorSubsidio := TMagazineLuizaFuncoes.IIF(blnAchouRegistro, FRegMagazineLuizaPgto[intRegistro].ValorSubsidio, 0) +
                                                          fGetDados(RetornaValorLista(lstCampos, 'Valor de reembolso do subsídio a ser pago pelo Magalu por parcela (R$)'), True, 0);

      If Not TMagazineLuizaFuncoes.fEmptyStr(FRegMagazineLuizaPgto[intRegistro].strDtaPag) Then
      Begin
        If (VS_DatasPagamento.IndexOf(FRegMagazineLuizaPgto[intRegistro].strDtaPag) < 0) Then
          VS_DatasPagamento.Add(FRegMagazineLuizaPgto[intRegistro].strDtaPag);
      End;

      FRegMagazineLuizaPgto[intRegistro].TipoEvento := FRegMagazineLuizaPgto[intRegistro].strTipReg;

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

        FRegMagazineLuizaPgto[intRegistro].TipoEvento := 'Transferência';
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

        FRegMagazineLuizaPgto[intRegistro].TipoEvento := FRegMagazineLuizaPgto[intRegistro].strObserv.Split(['|'])[0];
      End;

      If Trim(FRegMagazineLuizaPgto[intRegistro].strID_Mlz) = '' Then
        FRegMagazineLuizaPgto[intRegistro].strID_Mlz := FRegMagazineLuizaPgto[intRegistro].strDtaPag.Replace('/', EmptyStr).Replace(':', EmptyStr);

      If Trim(FRegMagazineLuizaPgto[intRegistro].strID_Sel) = '' Then
        FRegMagazineLuizaPgto[intRegistro].strID_Sel := FRegMagazineLuizaPgto[intRegistro].strID_Mlz;

      FRegMagazineLuizaPgto[intRegistro].strNumPar := TMagazineLuizaFuncoes.fStrZero(FRegMagazineLuizaPgto[intRegistro].strNumPar, 2);
      FRegMagazineLuizaPgto[intRegistro].strTotPar := TMagazineLuizaFuncoes.fStrZero(FRegMagazineLuizaPgto[intRegistro].strTotPar, 2);

      FRegMagazineLuizaPgto[intRegistro].IDRepasse := fGetDados(RetornaValorLista(lstCampos, 'ID do repasse'));
      FRegMagazineLuizaPgto[intRegistro].Versao2026 := 'S';

      FRegMagazineLuizaPgto[intRegistro].CodigoEmpresa := VS_CodigoEmpresa;
      If VS_ListaEstabelecimentos.IndexOf(VS_CodigoEmpresa) < 0 Then
        VS_ListaEstabelecimentos.Add(VS_CodigoEmpresa);
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
  If TMagazineLuizaFuncoes.fEmptyStr(strVal) Then
    Exit(Null);

  Result := strVal;
  If (blnData) Then
  Begin
    If blnCompleta Then
    Begin
      Result := Copy(strVal, 7, 4) + '/' + Copy(strVal, 4, 2) + '/' + Copy(strVal, 1, 2);
      Result := Result + ' ' + Copy(strVal, 12, 8);
    End
    Else
      Result := Copy(strVal, 1, 4) + '/' + Copy(strVal, 6, 2) + '/' + Copy(strVal, 9, 2);
  End;
End;

procedure TMagazineLuizaPgto.pGravarRegistros(var pgbProg: TcxProgressBar);
  Var
    LGravacao: TUniQuery;

    LRegistro: TRegistroPgto;
begin
  LGravacao := Nil;
  Try
    LGravacao := VS_FuncoesExternas.fICriaQuery;
    LGravacao.SQL.Text := TMagazineLuizaFuncoes.RetornaSQLReplace('MLZ_MZPGTO', ['MLZ_CONCIL']);

    TMagazineLuizaFuncoes.CarregaRegistrosJaImportados('MLZ_MZPGTO',
                                                      ['MLZ_CONCIL', 'MLZ_DTAPAG'],
                                                      ['= 1',RetornaPeriodoPagamento]);

    pgbProg.Position := 0;

    If Length(FRegMagazineLuizaPgto) <= 0 Then
      Exit;

    Try
      pgbProg.Properties.Max := Length(FRegMagazineLuizaPgto);
      For LRegistro In FRegMagazineLuizaPgto Do
      Begin
        If LRegistro.strTipReg.Trim.IsEmpty Then
        Begin
          TMagazineLuizaFuncoes.pStepStatusGravacao(pgbProg);

          Continue;
        End;

        If RegistroJaImportado(LRegistro) Then
        Begin
          TMagazineLuizaFuncoes.pStepStatusGravacao(pgbProg);

          Continue;
        End;

        LGravacao.Close;

        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_TIPREG', fRetVal(LRegistro.strTipReg));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_DTAPAG', fRetVal(LRegistro.strDtaPag, True, True));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_DTAPED', fRetVal(LRegistro.strDtaPed, True, True));

        If TMagazineLuizaFuncoes.fEmptyStr(LRegistro.strDtaPed) Then
          TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_DTAPED', LGravacao.ParamByName('MLZ_DTAPAG').Value);

        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_ID_MLZ', fRetVal(LRegistro.strId_Mlz));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_ID_SEL', fRetVal(LRegistro.strId_Sel));
        If (UpperCase(fRetVal(LRegistro.strTipReg)) = 'EVENTO') And
           (LRegistro.strId_Mlz.Trim = '') Then
        Begin
          TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_ID_MLZ', fRetVal(LRegistro.strId_Tra));
          TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_ID_SEL', fRetVal(LRegistro.strId_Tra));
        End;

        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_ID_TRA', fRetVal(LRegistro.strId_Tra));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_NUM_NF', fRetVal(LRegistro.strNum_NF));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_NOMCLI', fRetVal(LRegistro.strNomCli));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_NUMPAR', fRetVal(LRegistro.strNumPar));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_TOTPAR', fRetVal(LRegistro.strTotPar));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_OBSERV', fRetVal(LRegistro.strObserv));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_ORIGEM', fRetVal(LRegistro.strOrigem));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_VALBRU', fRetVal(LRegistro.fltValBru));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_VALLIQ', fRetVal(LRegistro.fltValLiq));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_VALANT', fRetVal(LRegistro.fltValAnt));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_VALPED', fRetVal(LRegistro.fltValPed));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_VALCOM', fRetVal(LRegistro.fltValCom));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_NOMARQ', fRetVal(LRegistro.strNomArq));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_DTAARQ', fRetVal(LRegistro.strDtaArq, True, False));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_PEDEVE', fRetVal(LRegistro.PedidoEvento));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_CODEMP', fRetVal(LRegistro.CodigoEmpresa));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_TIPEVE', fRetVal(LRegistro.TipoEvento));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_TAXTRF', fRetVal(LRegistro.TaxaTransferencia));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_FIXPAR', fRetVal(LRegistro.ValorFixoParcela));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_FIXPED', fRetVal(LRegistro.ValorFixoPedido));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_VALMDR', fRetVal(LRegistro.ValorMDR));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_ID_REP', fRetVal(LRegistro.IDRepasse));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_VER_26', fRetVal(LRegistro.Versao2026));
        TMagazineLuizaFuncoes.CarregaParametroDataset(LGravacao, 'MLZ_VALSUB', fRetVal(LRegistro.ValorSubsidio));

        LGravacao.ExecSQL;

        TMagazineLuizaFuncoes.pStepStatusGravacao(pgbProg);
      End;

    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao gravar a importação do arquivo.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;

    TMagazineLuizaFuncoes.GravarEstabelecimentos;
  Finally
    If Assigned(VS_IndicesCampos) Then
      FreeAndNil(VS_IndicesCampos);

    TMagazineLuizaFuncoes.FreeAndNilDatasets(LGravacao);
    TMagazineLuizaFuncoes.FreeAndNilDatasets(VS_RegistrosJaImportados);

    If Assigned(VS_DatasPagamento) Then
      FreeAndNil(VS_DatasPagamento);
  end;
end;

procedure TMagazineLuizaPgto.pValidarSeOArquivoFoiAlterado(
  strLinhaDoArquivo: String);
  Var
    stlCamposDoArquivo: TStringList;
    blnArquivoValido  : Boolean;
begin
  If strLinhaDoArquivo.IsEmpty Then
    Exit;

  stlCamposDoArquivo := Nil;
  Try
    stlCamposDoArquivo := TStringList.Create;
    stlCamposDoArquivo.Delimiter := ';';

    stlCamposDoArquivo.DelimitedText := strLinhaDoArquivo;

    blnArquivoValido := (stlCamposDoArquivo.Count In [22, 23, 25, 26, 29, 31, 32]);
  Finally
    If Assigned(stlCamposDoArquivo) Then
      FreeAndNil(stlCamposDoArquivo);
  End;

  If Not blnArquivoValido Then
    Raise Exception.Create('O arquivo ' + strNomArq + ' foi modificado em outro programa ou recebeu alterações no layout.'+ #13 +
                           'Para realizar a importação, o arquivo CSV não pode ter sofrido alterações.' + #13 +
                           'Operação cancelada!');
end;

function TMagazineLuizaPgto.RegistroJaImportado(
  ARegistro: TRegistroPgto): Boolean;
  Var
    LTipReg: String;

    LDtaPed,
    LDtaPag : TDateTime;
    LDtaAux: String;
begin
  LTipReg := fRetVal(ARegistro.strTipReg);

  If Not MatchStr(ARegistro.strTipReg, ['Evento', 'Transferência']) Then
    Exit(False);

  LDtaAux := ARegistro.strDtaPed;
  LDtaPed := StrToDateTime(LDtaAux);

  LDtaAux := ARegistro.strDtaPag;
  LDtaPag := StrToDateTime(LDtaAux);

  Result := VS_RegistrosJaImportados.Locate('MLZ_DTAPAG;MLZ_DTAPED;MLZ_ID_MLZ;MLZ_ID_SEL;MLZ_ID_TRA;MLZ_NUMPAR;MLZ_TIPREG',
                                            VarArrayOf([LDtaPag,
                                                        LDtaPed,
                                                        ARegistro.strID_Mlz,
                                                        ARegistro.strID_Sel,
                                                        ARegistro.strID_Tra,
                                                        ARegistro.strNumPar,
                                                        LTipReg]),[]);
end;

function TMagazineLuizaPgto.RetornaPeriodoPagamento: String;
  Var
    LDataInicial: String;
    LDataFinal: String;
begin
  VS_DatasPagamento.Sort;
  LDataInicial := VS_DatasPagamento[0];
  LDataFinal := VS_DatasPagamento[VS_DatasPagamento.Count - 1];

  Result := 'BETWEEN "' + FormatDateTime('yyyy-mm-dd', StrToDateTime(LDataInicial)) + '" AND '+
            '        "' + FormatDateTime('yyyy-mm-dd', StrToDateTime(LDataFinal)) + '" ';
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

procedure TMagazineLuizaPgto.ValidaSeAsParcelasEstaoNoFormatoCorreto(
  ANumeroParcela, ATotalParcelas, ANumeroPedido: String);
  Var
    LParcelaInteger: Integer;
begin
  If Not TryStrToInt(ANumeroParcela, LParcelaInteger) Then
    Raise Exception.Create('A coluna de parcelas do pedido ' + ANumeroPedido + ' possui valor inválido.' +
                           'Baixe novamente o arquivo do portal do Magalu e, sem alterá-lo, exporte para csv. ' +
                           'Depois refaça a importação do novo arquivo.');

  If Not TryStrToInt(ATotalParcelas, LParcelaInteger) Then
    Raise Exception.Create('A coluna de parcelas do pedido ' + ANumeroPedido + ' possui valor inválido.' +
                           'Baixe novamente o arquivo do portal do Magalu e, sem alterá-lo, exporte para csv. ' +
                           'Depois refaça a importação do novo arquivo.');
end;

end.
