unit untParcelamento;

interface

uses Classes, SysUtils, DateUtils, strUtils, untFuncoesSimples,
  untMsgLiberacao,UniClientDataSet,untTLock, Forms;

Type
  TParcela = record
    strNumeroParcela: String;
    dtaVencimento: TDateTime;
    fltSaldo: Double;
    fltAmortizacao: Double;
    fltJuros: Double;
    fltValorParcela: Double;
    fltValorParcelaOriginal: Double;
  end;

Type
  TArrayParcelas = Array Of TParcela;

Type
  TArrayDocsAgrupar = Array Of TDocAgrupamento;

Type
  TParcelamento = class
    private
      FParcelas: TArrayParcelas;
      FValorCorrigido: Double;
      FDesconto: Double;
      FValorDesejado: Double;
      FValorBase: Double;
      FTaxaJuros: Double;
      FDiaFixo: Integer;
      FCarencia: Integer;
      FIntervalo: Integer;
      FDataBase: TDateTime;
      FSimulacao: Boolean;
      FcdsCadRec: TUniClientDataSet;
      FObjLock: TLock ;
      FQtdeParcelas: Integer;
      FUsarDiaFixo: Boolean;
      FDocsAgrupar: TArrayDocsAgrupar;
      FDataPrimeiraParcela: TDateTime;
      FUsarPrimeiraParcela: Boolean;
      function fCoeficienteFinanciamento(fltTaxa: Double; intParcelas: Integer): Double;
      function fValorParcela(fltValorPresente, fltTaxa: Double; intParcelas: Integer): Double;
      procedure setDiaFixo(const Value: Integer);
      procedure setIntervalo(const Value: Integer);
      procedure setTaxaJuros(const Value: Double);
      procedure setCarencia(const Value: Integer);
      procedure setDataBase(const Value: TDateTime);
      procedure setDataPrimeiraParcela(const Value: TDateTime);
      procedure setQtdeParcelas(const Value: Integer);
      procedure setValorCorrigido(const Value: Double);
      procedure setDesconto(const Value: Double);
      procedure setValorDesejado(const Value: Double);
      function GetTotalAmortizacao: Double;
      function GetTotalJuros: Double;
      function GetTotalParcelas: Double;
      procedure pRemoverParcelasCarencia;
    public
      constructor Create;
      destructor Destroy; override;
      function ToString: String; override;
      function GetMensagemLiberacao : TMensagemLiberacao;
      function fDigitarDadosParcelamento: Boolean;

      procedure pRealizarAgrupamento;

      function fGetVencimento(AUltimoVencimento: TDateTime;
                              AParcela: Integer): TDateTime;

      procedure pCalcularParcelas(AUltimoVencimento: TDateTime = 0; AParcela: Integer = -1);
      procedure pCalcularParcelasValorDesejado;
      procedure pAjustaValoresParcelas;

      procedure pAdicionarDocumentoAgrupamento(documento: TDocAgrupamento);
      procedure ClearArrayDocumentos;

      property arrParcelas: TArrayParcelas read FParcelas;
      property fltValorCorrigido: Double read FValorCorrigido write setValorCorrigido;
      property fltDesconto: Double read FDesconto write setDesconto;
      property fltValorDesejado: Double read FValorDesejado write setValorDesejado;
      property fltValorBase: Double read FValorBase;
      property intQuantidadeParcelas: Integer read FQtdeParcelas write setQtdeParcelas;
      property dtaDataBase: TDateTime read FDataBase write setDataBase;
      property blnSimulacao: Boolean read FSimulacao write FSimulacao;
      property cdsCadRec: TUniClientDataSet read FcdsCadRec write FcdsCadRec;
      property objLock: TLock read FObjLock write FObjLock;
      property intIntervaloDias: Integer read FIntervalo write setIntervalo;
      property fltTaxaJuros: Double read FTaxaJuros write setTaxaJuros;
      property intCarencia: Integer read FCarencia write setCarencia;
      property intDiaFixo: Integer read FDiaFixo write setDiaFixo;
      property blnUsarDiaFixo: Boolean read FUsarDiaFixo write FUsarDiaFixo;
      property fltTotalAmortizacao: Double read GetTotalAmortizacao;
      property fltTotalJuros: Double read GetTotalJuros;
      property fltTotalParcelas: Double read GetTotalParcelas;
      property dataPrimeiraParcela: TDateTime read FDataPrimeiraParcela write setDataPrimeiraParcela;
      property blnUsarPrimeiraParcela: Boolean read FUsarPrimeiraParcela write FUsarPrimeiraParcela;
      property ArrayDocsAgrupar: TArrayDocsAgrupar read FDocsAgrupar write FDocsAgrupar;
    end;

implementation

uses Math, untConstantes, untCtrNegociacaoParcelamento, untAgrupDuplicatas,
  untGravando, untTypesSistema;

{ TParcelamento }

procedure TParcelamento.ClearArrayDocumentos;
begin
  SetLength(FDocsAgrupar, 0);
end;

constructor TParcelamento.Create;
begin
  SetLength(FDocsAgrupar, 0);
  SetLength(FParcelas, 0);
  FValorCorrigido := 0;
  FValorDesejado  := 0;
  FDesconto  := 0;
  FValorBase := 0;
  FTaxaJuros := 0;
  FDiaFixo   := 1;
  FCarencia  := 0;
  FIntervalo := 30;
  FDataBase  := VS_Date;
  FUsarDiaFixo := False;
  FSimulacao := False;
  FcdsCadRec := TUniClientDataSet.Create(Nil);
  FobjLock := TLock.Create;
end;

destructor TParcelamento.Destroy;
begin
  SetLength(FDocsAgrupar, 0);
  SetLength(FParcelas, 0);

  If Assigned(FcdsCadRec) Then
    FreeAndNil(FcdsCadRec);
  inherited;
end;

{***************************************************************************}
{* O coeficiente de financiamento é um fator que ao ser multiplicado pelo  *}
{* valor a ser financiado, irá nos fornecer o valor de cada prestação.     *}
{***************************************************************************}
{*                                                                         *}
{*                 i                                                       *}
{*         ----------------                                                *}
{*  CF =           1                                                       *}
{*         1 - -----------                                                 *}
{*             ( 1 + i)^n                                                  *}
{*                                                                         *}
{***********************************************************************JC**}
function TParcelamento.fCoeficienteFinanciamento(fltTaxa: Double;
  intParcelas: Integer): Double;
begin
  Result := fltTaxa / ( 1 - ( 1 / Power( 1 + fltTaxa, intParcelas) ) );
end;

function TParcelamento.fDigitarDadosParcelamento: Boolean;
  Var
    frmCtrNegociacaoParcelamento: TfrmCtrNegociacaoParcelamento;
begin
  Try
    pCriarFormularios(TfrmCtrNegociacaoParcelamento, frmCtrNegociacaoParcelamento);

    frmCtrNegociacaoParcelamento.objParcelamento := Self;
    frmCtrNegociacaoParcelamento.ShowModal;

    Result := frmCtrNegociacaoParcelamento.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmCtrNegociacaoParcelamento);
end;

procedure TParcelamento.pRealizarAgrupamento;
  Var
    documento: TDocAgrupamento;
    frmAgrupDuplicatas: TfrmAgrupDuplicatas;
begin
  Self.pRemoverParcelasCarencia;

  If (Not FUsarDiaFixo) And (Not blnUsarPrimeiraParcela) And (FParcelas[0].dtaVencimento < FDataBase+FIntervalo) Then
    Raise ExceptionAutcom.Create('Ao usar Intervalo em dias o vencimento não pode ser menor que ' + FormatDateTime('dd/mm/yyyy',FDataBase+FIntervalo) + '!');

  Try
    If Assigned(FobjLock) Then
      FobjLock.pDestravarTodos;

    pCriarFormularios(TfrmAgrupDuplicatas, frmAgrupDuplicatas);

    frmAgrupDuplicatas.AFormVeio       := 'ACERTO';
    frmAgrupDuplicatas.ParcelasAcerto  := True;
    frmAgrupDuplicatas.objParcelamento := Self;
    frmAgrupDuplicatas.FSelTodas := True;
    SetLength(frmAgrupDuplicatas.arrDocsAgrupar, 0);

    For documento In FDocsAgrupar Do
    Begin
      SetLength(frmAgrupDuplicatas.arrDocsAgrupar, Length(frmAgrupDuplicatas.arrDocsAgrupar) + 1);
      frmAgrupDuplicatas.arrDocsAgrupar[Length(frmAgrupDuplicatas.arrDocsAgrupar) - 1] := documento;
    End;

    If Length(frmAgrupDuplicatas.arrDocsAgrupar) > 0 Then
      frmAgrupDuplicatas.ShowModal;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmAgrupDuplicatas);
end;

procedure TParcelamento.pRemoverParcelasCarencia;
  Var
    arrBkp: TArrayParcelas;
    intPar: Integer;
begin
  SetLength(arrBkp, Length(FParcelas));

  For intPar := 0 To Length(FParcelas) -1 Do
    arrBkp[intPar] := FParcelas[intPar];

  SetLength(FParcelas, 0);

  For intPar := 0 To Length(arrBkp) -1 Do
  Begin
    If Not fEmptyStr(arrBkp[intPar].strNumeroParcela) Then
    Begin
      SetLength(FParcelas, Length(FParcelas) + 1);
      FParcelas[Length(FParcelas) -1] := arrBkp[intPar];
    End;
  End;
end;

function TParcelamento.fValorParcela(fltValorPresente, fltTaxa: Double;
  intParcelas: Integer): Double;
begin
  If fltTaxa = 0 Then
    Result := fltValorPresente / intParcelas
  Else
    Result := fltValorPresente * fCoeficienteFinanciamento(fltTaxa, intParcelas);
end;

function TParcelamento.GetMensagemLiberacao: TMensagemLiberacao;
  Var
    parcela: TParcela;
    duplicata: TDocAgrupamento;
begin
  Result := TMensagemLiberacao.Create(Application);
  Result.Clear;
  Result.pAddTexto('O valor do desconto é maior que o permitido.');
  Result.pAddTexto( '.--------------------------------------------------------------------------------------.');
  Result.pAddTexto( '|                               NEGOCIAÇÃO DE PARCELAMENTO                             |');
  Result.pAddTexto( '|--------------------------------------------------------------------------------------|');
  Result.pAddTexto( '| Total Geral Corrigido  : ' + fPadR(FormatFloat('#,##0.00', FValorCorrigido), 59) + ' |');
  Result.pAddTexto( '| Valor Desconto         : ' + fPadR(FormatFloat('#,##0.00', FDesconto)      , 59) + ' |');

  If blnUsarPrimeiraParcela Then
    Result.pAddTexto( '| Total com Desconto     : ' + fPadR(FormatFloat('#,##0.00', FValorBase)     , 32) +
                                           '1.a Parcela : ' + FormatDateTime('dd/MM/yyyy', dataPrimeiraParcela) + '    |')
  Else
    Result.pAddTexto( '| Total com Desconto     : ' + fPadR(FormatFloat('#,##0.00', FValorBase)     , 59) + ' |');

    Result.pAddTexto( '| Qtd.Parcelas           : ' + fPadR(FQtdeParcelas.ToString, 32) +
                                           ' Data Base  : ' + FormatDateTime('dd/MM/yyyy', FDataBase) + '    |');

  Result.pAddTexto( '| ** Valor Final Desejado: ' + fPadR(FormatFloat('#,##0.00', FValorDesejado) , 59) + ' |' );
  Result.pAddTexto(  '| Taxa Juros Parcelamento: ' +
           fPadR(FormatFloat(fMskDigitos(IIF(fltValorDesejado <> 0, 10, 4)), FTaxaJuros) + '% a.m.', 59) + ' |');

  Result.pAddTexto( '| [' + IIF(FUsarDiaFixo, ' ', 'X') + ']Invervalo em Dias   : ' + fPadR(FIntervalo.ToString, 32) +
                              ' Amortização: ' + fPadR(FormatFloat('#,##0.00', fltTotalAmortizacao), 13) + ' |');

  Result.pAddTexto( '| [' + IIF(FUsarDiaFixo, 'X', ' ') + ']Vencimento Dia Fixo : ' + fPadR(FDiaFixo.ToString, 32) +
                                    ' Juros      : ' + fPadR(FormatFloat('#,##0.00', fltTotalJuros), 13) + ' |' );

  Result.pAddTexto( '| Carência (Nº Parcelas) : ' + fPadR(FCarencia.ToString, 32) +
                                 ' Valor final: ' + fPadR(FormatFloat('#,##0.00', fltTotalParcelas), 13) + ' |' );

  Result.pAddTexto( '|                                                                                      |' );
  Result.pAddTexto( '| ** A taxa de juros do parcelamento será calculada automaticamente caso informe o     |' );
  Result.pAddTexto( '|    "Valor Final Desejado". Se deseja digitar a taxa de juros favor não informar      |' );
  Result.pAddTexto( '|    valor neste campo.                                                                |' );
  Result.pAddTexto( '|--------------------------------------------------------------------------------------|' );
  Result.pAddTexto( '| PARCELA | VENCIMENTO | SALDO DEVEDOR |   AMORTIZAÇÃO |         JUROS |     PRESTAÇÃO |' );
  Result.pAddTexto( '|--------------------------------------------------------------------------------------|' );

  For parcela In FParcelas Do
    Result.pAddTexto( '| ' + fPadR(parcela.strNumeroParcela, 7)                          + ' ' +
                       '| ' + FormatDateTime('dd/MM/yyyy' , parcela.dtaVencimento)        + ' ' +
                       '| ' + fPadL(FormatFloat('#,##0.00', parcela.fltSaldo), 13)        + ' ' +
                       '| ' + fPadL(FormatFloat('#,##0.00', parcela.fltAmortizacao), 13)  + ' ' +
                       '| ' + fPadL(FormatFloat('#,##0.00', parcela.fltJuros), 13)        + ' ' +
                       '| ' + fPadL(FormatFloat('#,##0.00', parcela.fltValorParcela), 13) + ' |' );

  Result.pAddTexto( '.---------------------------------------------------------------------------------------------------------------------------------------.' );
  Result.pAddTexto( '|                                                    DUPLICATAS NEGOCIAÇÃO PARCELAMENTO                                                 |' );
  Result.pAddTexto( '|---------------------------------------------------------------------------------------------------------------------------------------|' );
  Result.pAddTexto( '| DUPLICATA            | EMP |  VENCIM. |   VR. ORIGINAL | PAGAMENTO | VR. MULTA | VR. JUROS | DESP. COBRANÇA |  VR. CORRIGIDO | ATRASO |' );
  Result.pAddTexto( '|---------------------------------------------------------------------------------------------------------------------------------------|' );

  For duplicata In FDocsAgrupar Do
    With duplicata Do
        Result.pAddTexto(  '| ' + fPadR(RightStr(strNumDoc + '-' + strParcel + '-' + strEspDoc, 20), 20) + ' ' +
                         '| ' + fPadC(strCodEmp, 3)                                                    + ' ' +
                         '| ' + fPadR(FormatDateTime('dd/MM/yy', dtaDtaVen), 8)                        + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltValOri), 14)                          + ' ' +
                         '| ' + fPadR(FormatDateTime('dd/MM/yy', dtaDtaPag), 9)                        + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltValMul), 9)                           + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltValJur), 9)                           + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltDesCob), 14)                          + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltValCor), 14)                          + ' ' +
                         '| ' + fPadC(intDiaAtr.ToString, 6)                                           + ' |' );

  Result.pAddTexto( '|---------------------------------------------------------------------------------------------------------------------------------------|' );
end;

function TParcelamento.GetTotalAmortizacao: Double;
  Var
    parcela: TParcela;
begin
  Result := 0;
  For parcela in FParcelas Do
    Result := Result + parcela.fltAmortizacao;
end;

function TParcelamento.GetTotalJuros: Double;
  Var
    parcela: TParcela;
begin
  Result := 0;
  For parcela in FParcelas Do
    Result := Result + parcela.fltJuros;
end;

function TParcelamento.GetTotalParcelas: Double;
  Var
    parcela: TParcela;
begin
  Result := 0;
  For parcela in FParcelas Do
    Result := Result + parcela.fltValorParcela;
end;

procedure TParcelamento.pAdicionarDocumentoAgrupamento(
  documento: TDocAgrupamento);
begin
  SetLength(FDocsAgrupar, Length(FDocsAgrupar) + 1);
  FDocsAgrupar[Length(FDocsAgrupar) - 1] := documento;
end;

function TParcelamento.fGetVencimento(AUltimoVencimento: TDateTime;
  AParcela: Integer): TDateTime;
begin
  If FUsarDiaFixo And (FDiaFixo > 0) Then
  Begin
    Result := AUltimoVencimento;

    If Not ((AParcela = 0) And (DayOf(Result) <= FDiaFixo)) Then
    Begin
      If MonthOf(Result) = 12 Then
        Result := EncodeDateTime(YearOf (Result) + 1, 1, 1, 0, 0, 0, 0)
      Else
        Result := EncodeDateTime(YearOf (Result), MonthOf(Result) + 1, 1, 0, 0, 0, 0);
    End;

    If DaysInAMonth(YearOf(Result), MonthOf(Result)) >= FDiaFixo Then
      Result := EncodeDateTime(YearOf(Result), MonthOf(Result), FDiaFixo, 0, 0, 0, 0)
    Else
    Begin
      Result := EncodeDateTime(YearOf(Result), MonthOf(Result),
                               DaysInAMonth(YearOf(Result), MonthOf(Result)), 0, 0, 0, 0);

    End;
  End
  Else
    Result := IncDay(AUltimoVencimento, FIntervalo);
end;

procedure TParcelamento.pCalcularParcelas(AUltimoVencimento: TDateTime = 0; AParcela: Integer = -1);
  Var
    intNumParc: Integer;
    intParcela: Integer;
    dtaUltimoVencto: TDateTime;
    fltTaxa, fltUltimoSaldo: Double;
begin
  If FUsarDiaFixo And (FIntervalo <> 30) Then
    Raise ExceptionAutcom.Create('Para utilizar dia fixo o intervalo deve ser de 30 dias!');

  intNumParc := AParcela;
  If intNumParc < 0 Then
    intNumParc := 0;

  dtaUltimoVencto := FDataBase;
  fltUltimoSaldo  := FValorBase;

  If AUltimoVencimento = 0 Then
  Begin
    SetLength(FParcelas, 0);
    SetLength(FParcelas, FQtdeParcelas + FCarencia);
  End;

  For intParcela := 0 To Length(FParcelas) -1 Do
  With FParcelas[intParcela] Do
  Begin
    If (AParcela >= 0) And (intParcela <= AParcela) Then
    Begin
      If (intParcela = 0) And (blnUsarPrimeiraParcela) Then
        dtaUltimoVencto := AUltimoVencimento;

      If (AParcela = intParcela) Then
        dtaVencimento   := AUltimoVencimento
      Else
      Begin
        dtaUltimoVencto := FParcelas[intParcela].dtaVencimento;
        fltUltimoSaldo := FParcelas[intParcela].fltSaldo;
        Continue;

      End;

    End
    Else if (intParcela = 0) and (blnUsarPrimeiraParcela) then
    begin
      dtaVencimento   := dataPrimeiraParcela;
      dtaUltimoVencto := dataPrimeiraParcela;
    end
    else
      dtaVencimento := fGetVencimento(dtaUltimoVencto,
                                       intParcela);

//    dtaVencimento := fGetVencimento;

    fltTaxa := (FTaxaJuros / 100) / 30 * (dtaVencimento - dtaUltimoVencto);

    fltJuros := fFormataFloat(fltUltimoSaldo * fltTaxa, 2);

    If Succ(intParcela) > FCarencia Then
    Begin
      fltValorParcela := fFormataFloat(fValorParcela(fltUltimoSaldo,
        fltTaxa, FQtdeParcelas + FCarencia - intParcela), 2);

      Inc(intNumParc);

      strNumeroParcela := fStrZero(intNumParc.ToString, 3);
    End
    Else
      strNumeroParcela := '';

    fltAmortizacao := fFormataFloat(fltValorParcela - fltJuros, 2);

    fltSaldo := fltUltimoSaldo - fltAmortizacao;

    fltUltimoSaldo  := fltSaldo;
    dtaUltimoVencto := dtaVencimento;
  End;

end;

procedure TParcelamento.pAjustaValoresParcelas;
  Var
    iQtdParc,
    intParcela : integer;
    flTotPorParc,
    flTotGeral,
    flTotDiferenca: Double;
begin
  // Ajusta parcelas para que diferença fique na ultima parcela;

  iQtdParc     := 0;
  flTotGeral   := 0;

  For intParcela := 0 To Length(FParcelas) -1 Do
  Begin
    If (FParcelas[intParcela].strNumeroParcela <> '') And (FParcelas[intParcela].fltValorParcela > 0.00) Then
    Begin
      iQtdParc   := iQtdParc + 1;
      flTotGeral := fFormataFloat(flTotGeral + FParcelas[intParcela].fltValorParcela,2);
    End;
  End;

  flTotPorParc := fTruncaFloat( (flTotGeral / iQtdParc), 2);

  flTotDiferenca := flTotGeral - (iQtdParc * flTotPorParc);

  For intParcela := 0 To Length(FParcelas) -1 Do
  Begin
    If (FParcelas[intParcela].strNumeroParcela <> '') And (FParcelas[intParcela].fltValorParcela > 0.00) Then
    Begin
      FParcelas[intParcela].fltValorParcelaOriginal := FParcelas[intParcela].fltValorParcela;
      FParcelas[intParcela].fltValorParcela := flTotPorParc;
    End;
  End;

  //Acerta a diferenca na ultima parcela
  If flTotDiferenca <> 0.00 Then
  With FParcelas[High(FParcelas)] Do
  Begin
    fltValorParcela := fltValorParcela + flTotDiferenca;
  End;

End;

procedure TParcelamento.pCalcularParcelasValorDesejado;
  Var
    intIteracoes  : Integer;
    fltDiferenca  : Double;
    fltTaxaInicial: Double;
    fltTaxaFinal  : Double;
begin
  FTaxaJuros := 100.00;
  pCalcularParcelas;

  If fltTotalParcelas < fltValorDesejado Then
    Raise ExceptionAutcom.Create('O valor final desejado ultrapassa uma taxa ' +
      'de juros de 100.00% a.m.!');

  fltTaxaInicial := 0.0;
  fltTaxaFinal   := 100.0;

  For intIteracoes := 1 To 100 Do
  Begin
    FTaxaJuros := fFormataFloat((fltTaxaInicial + fltTaxaFinal) / 2, 10);

    pCalcularParcelas;

    If fFormataFloat(fltValorDesejado, 2) = fFormataFloat(fltTotalParcelas, 2) Then
      Break;

    If fltTotalParcelas < fltValorDesejado Then
    Begin
      If FTaxaJuros = fltTaxaInicial Then
        Break;

      fltTaxaInicial := FTaxaJuros;
    End
    Else
    Begin
      If FTaxaJuros = fltTaxaFinal Then
        Break;

      fltTaxaFinal := FTaxaJuros;
    End
  End;

  fltDiferenca := fFormataFloat(fltValorDesejado - fltTotalParcelas, 2);

  //Acerta a diferenca na ultima parcela
  If fltDiferenca <> 0.00 Then
  With FParcelas[High(FParcelas)] Do
  Begin
    fltJuros        := fltJuros + fltDiferenca;
    fltValorParcela := fltValorParcela + fltDiferenca;
  End;
end;

procedure TParcelamento.setCarencia(const Value: Integer);
begin
  If Value < 0 Then
    Raise ExceptionAutcom.Create('Não permitido um valor negativo para carência!');

  If Value > 999 Then
    Raise ExceptionAutcom.Create('A quantidade máxima para carência é 999!');

  FCarencia := Value;
end;

procedure TParcelamento.setDesconto(const Value: Double);
begin
  If Value < 0 Then
    Raise ExceptionAutcom.Create('O valor do desconto não deve ser negativo!');

  If Value >= FValorCorrigido Then
    Raise ExceptionAutcom.Create('O valor do desconto não pode ser maior ou igual o valor corrigido!');

  FDesconto  := Value;
  FValorBase := FValorCorrigido - FDesconto;
end;

procedure TParcelamento.setDataBase(const Value: TDateTime);
begin
  If Value <= 0 Then
    Raise ExceptionAutcom.Create('Informe um valor válido para data base de cálculo!');

  If fEmptyStr(fTiraCaracEspeciais(DateToStr(Value))) Then
  Begin
    Raise ExceptionAutcom.Create('A data deve ser preenchida!');
  End
  Else
  Begin
    If Value < VS_Date Then
    Begin
      Raise ExceptionAutcom.Create('A data deve ser maior ou igual a data atual!');
    End;
  End;

  FDataBase := Value;
end;

procedure TParcelamento.setDataPrimeiraParcela(const Value: TDateTime);
begin
  If (Value < date) and (blnUsarPrimeiraParcela) Then
    Raise ExceptionAutcom.Create('A Data deve ser maior ou igual a data de hoje. Informe um valor válido para o campo Primeira parcela à vista!');

  FDataPrimeiraParcela := Value;
end;

procedure TParcelamento.setDiaFixo(const Value: Integer);
begin
  If (Value < 1) Or (Value > 31) Then
    Raise ExceptionAutcom.Create('o dia fixo deve estar entre 1 e 31 dias!');

  FDiaFixo := Value;
end;

procedure TParcelamento.setValorCorrigido(const Value: Double);
begin
  If Value <= 0 Then
    Raise ExceptionAutcom.Create('O valor corrigido deve deve maior que zero!');

  FValorCorrigido := Value;
  FValorBase := FValorCorrigido - FDesconto;
end;

procedure TParcelamento.setValorDesejado(const Value: Double);
begin
  If (fFormataFloat(Value,2) < fFormataFloat(FValorBase,2)) And (Value <> 0.00) Then
    Raise ExceptionAutcom.Create('O valor final desejado não pode ser menor ' +
      'que o valor base para cálculo do parcelamento!');

  FValorDesejado := Value;
end;

function TParcelamento.ToString: String;
  Var
    parcela: TParcela;
    duplicata: TDocAgrupamento;
begin
  Result := '';
  Result := Result + '.--------------------------------------------------------------------------------------.' + #13#10;
  Result := Result + '|                               NEGOCIAÇÃO DE PARCELAMENTO                             |' + #13#10;
  Result := Result + '|--------------------------------------------------------------------------------------|' + #13#10;
  Result := Result + '| Total Geral Corrigido  : ' + fPadR(FormatFloat('#,##0.00', FValorCorrigido), 59) + ' |' + #13#10;
  Result := Result + '| Valor Desconto         : ' + fPadR(FormatFloat('#,##0.00', FDesconto)      , 59) + ' |' + #13#10;

  If blnUsarPrimeiraParcela Then
    Result := Result + '| Total com Desconto     : ' + fPadR(FormatFloat('#,##0.00', FValorBase)     , 32) +
                                           '1.a Parcela : ' + FormatDateTime('dd/MM/yyyy', dataPrimeiraParcela) + '    |' + #13#10
  Else
    Result := Result + '| Total com Desconto     : ' + fPadR(FormatFloat('#,##0.00', FValorBase)     , 59) + ' |' + #13#10;

  Result := Result + '| Qtd.Parcelas           : ' + fPadR(FQtdeParcelas.ToString, 32) +
                                           ' Data Base  : ' + FormatDateTime('dd/MM/yyyy', FDataBase) + '    |' + #13#10;

  Result := Result + '| ** Valor Final Desejado: ' + fPadR(FormatFloat('#,##0.00', FValorDesejado) , 59) + ' |' + #13#10;
  Result := Result + '| Taxa Juros Parcelamento: ' +
           fPadR(FormatFloat(fMskDigitos(IIF(fltValorDesejado <> 0, 10, 4)), FTaxaJuros) + '% a.m.', 59) + ' |' + #13#10;

  Result := Result + '| [' + IIF(FUsarDiaFixo, ' ', 'X') + ']Invervalo em Dias   : ' + fPadR(FIntervalo.ToString, 32) +
                              ' Amortização: ' + fPadR(FormatFloat('#,##0.00', fltTotalAmortizacao), 13) + ' |' + #13#10;

  Result := Result + '| [' + IIF(FUsarDiaFixo, 'X', ' ') + ']Vencimento Dia Fixo : ' + fPadR(FDiaFixo.ToString, 32) +
                                    ' Juros      : ' + fPadR(FormatFloat('#,##0.00', fltTotalJuros), 13) + ' |' + #13#10;

  Result := Result + '| Carência (Nº Parcelas) : ' + fPadR(FCarencia.ToString, 32) +
                                 ' Valor final: ' + fPadR(FormatFloat('#,##0.00', fltTotalParcelas), 13) + ' |' + #13#10;

  Result := Result + '|                                                                                      |' + #13#10;
  Result := Result + '| ** A taxa de juros do parcelamento será calculada automaticamente caso informe o     |' + #13#10;
  Result := Result + '|    "Valor Final Desejado". Se deseja digitar a taxa de juros favor não informar      |' + #13#10;
  Result := Result + '|    valor neste campo.                                                                |' + #13#10;
  Result := Result + '|--------------------------------------------------------------------------------------|' + #13#10;
  Result := Result + '| PARCELA | VENCIMENTO | SALDO DEVEDOR |   AMORTIZAÇÃO |         JUROS |     PRESTAÇÃO |' + #13#10;
  Result := Result + '|--------------------------------------------------------------------------------------|' + #13#10;

  For parcela In FParcelas Do
    Result := Result + '| ' + fPadR(parcela.strNumeroParcela, 7)                          + ' ' +
                       '| ' + FormatDateTime('dd/MM/yyyy' , parcela.dtaVencimento)        + ' ' +
                       '| ' + fPadL(FormatFloat('#,##0.00', parcela.fltSaldo), 13)        + ' ' +
                       '| ' + fPadL(FormatFloat('#,##0.00', parcela.fltAmortizacao), 13)  + ' ' +
                       '| ' + fPadL(FormatFloat('#,##0.00', parcela.fltJuros), 13)        + ' ' +
                       '| ' + fPadL(FormatFloat('#,##0.00', parcela.fltValorParcela), 13) + ' |' + #13#10;


  Result := Result + #13#10;
  Result := Result + #13#10;

  Result := Result + '.---------------------------------------------------------------------------------------------------------------------------------------.' + #13#10;
  Result := Result + '|                                                    DUPLICATAS NEGOCIAÇÃO PARCELAMENTO                                                 |' + #13#10;
  Result := Result + '|---------------------------------------------------------------------------------------------------------------------------------------|' + #13#10;
  Result := Result + '| DUPLICATA            | EMP |  VENCIM. |   VR. ORIGINAL | PAGAMENTO | VR. MULTA | VR. JUROS | DESP. COBRANÇA |  VR. CORRIGIDO | ATRASO |' + #13#10;
  Result := Result + '|---------------------------------------------------------------------------------------------------------------------------------------|' + #13#10;

  For duplicata In FDocsAgrupar Do
    With duplicata Do
      Result := Result + '| ' + fPadR(RightStr(strNumDoc + '-' + strParcel + '-' + strEspDoc, 20), 20) + ' ' +
                         '| ' + fPadC(strCodEmp, 3)                                                    + ' ' +
                         '| ' + fPadR(FormatDateTime('dd/MM/yy', dtaDtaVen), 8)                        + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltValOri), 14)                          + ' ' +
                         '| ' + fPadR(FormatDateTime('dd/MM/yy', dtaDtaPag), 9)                        + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltValMul), 9)                           + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltValJur), 9)                           + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltDesCob), 14)                          + ' ' +
                         '| ' + fPadL(FormatFloat('#,##0.00', fltValCor), 14)                          + ' ' +
                         '| ' + fPadC(intDiaAtr.ToString, 6)                                           + ' |' + #13#10;

  Result := Result + '|---------------------------------------------------------------------------------------------------------------------------------------|' + #13#10;
end;

procedure TParcelamento.setIntervalo(const Value: Integer);
begin
  If Value > 999 Then
    Raise ExceptionAutcom.Create('O intervalo máximo é de 999 dias!');

  If Value <= 0 Then
    Raise ExceptionAutcom.Create('O intervalo deve ser maior que zero!');

  FIntervalo := Value;
end;

procedure TParcelamento.setQtdeParcelas(const Value: Integer);
begin
  If Value <= 0 Then
    Raise ExceptionAutcom.Create('A quantidade de parcelas deve ser maior que zero!');

  If Value > 999 Then
    Raise ExceptionAutcom.Create('A quantidade máxima de parcelas é 999!');

  FQtdeParcelas := Value;
end;

procedure TParcelamento.setTaxaJuros(const Value: Double);
begin
  If Value <= 0 Then
    Raise ExceptionAutcom.Create('A taxa de juros deve ser maior que zero!');

  FTaxaJuros := Value;
end;

end.

