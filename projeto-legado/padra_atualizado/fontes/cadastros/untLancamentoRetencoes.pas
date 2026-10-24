unit untLancamentoRetencoes;

interface

uses    System.SysUtils, System.Variants, System.Classes,
   Data.DB,
  Datasnap.DBClient, Uni,
  {$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
  {$ELSE}
  UniClientDataSet,
  untFuncoesSimples,
  untCtaDet,
  {$ENDIF}
  untTypesSistema,  MemDS, DBAccess,
  Datasnap.Provider, System.DateUtils,
  untTCadPag, untLogCtp, untZClient;

type
 TRetencao = record
    RET_ALIQUO: Double;
    RET_CODCTA: string;
    RET_CODEVE: string;
    RET_CODFOR: string;
    RET_DIAVEN: Integer;
    RET_FORRET: string;
    RET_TIPRET: Integer;
    RET_TIPVEN: Integer;
    RET_CODPOR: string;
    RET_TIPDOC: Integer;
    RET_Q_GUIA: string;
    RET_CODREC: string;
    ValorRetencao: Double; // Valor calculado da retenção
  end;

  TArrRetencao = array of TRetencao;

  TRetencoesNoFrame = class (TComponent)
  private
    FrrRetencao: TArrRetencao;
    FValorBase: Double;
    FstrNumDup: string;
    strNumDoc,
    strEspDoc,
    strSerie,
    strCodEmp,
    strForCli,
    strNomFor: string;
    dtaDtaDoc: TDate;
    dtaDtaEnt: TDate;
    qryCtaDet: TUniClientDataSet;
    FblnGravouCtpDet: Boolean;
    FTotalREIRRF: Double;
    FTotalVREPIS: Double;
    FTotalVRECOF: Double;
    FTotalRECSSL: Double;
    FTotalRETISS: Double;
    FTotalREINSS: Double;
    FTotalRINSSP: Double;
    function fGetTemRetencao: Boolean;
    procedure pCarregarRetencoes(qry: TUniQuery);
    procedure pZeraValoresRetencao;
    procedure pCalcularRetencoes;
    function fCalcularDataVencimento(ARetencao: TRetencao; var wrdAno: Word; var wrdMes: Word;  var wrdDia: Word;
                                                    var dteVencto: TDateTime; var dteUltDiaMes: TDateTime): TDateTime;

  public
    class function CreateClass(AOWner: TComponent; ACodFor: string): TRetencoesNoFrame;
    destructor Destroy; override;
    procedure pSetCamposIdentificaDocumento(AstrNumDoc, AstrEspDoc, AstrSerie, AstrCodEmp, AstrForCli, AstrNomFor: string; AdtaDtaDoc, AdtaDtaEnt: TDate);

    procedure pSetaValorBase(AValorbase: Double);
    function fRetTotalImpostos: Double;
    function fRetHistoricoRetencao(fltTotDoc, fltTotLiq: Double): String;
    function fCriarParcelasRetencoesFornecedor(AutIncFis: string; blnGravaCadpag: Boolean; AstrLocalOrigem: String = ''): Boolean;
    function fIncluiRETFIS(ARetencao: TRetencao; AIncFis, AIncCTP: String): Boolean;
    procedure pGravarCtpDet(ARetencao: TRetencao; strParcel: String; strLocalOrigem: String = '');

    property TotalREIRRF: Double read FTotalREIRRF;
    property TotalVREPIS: Double read FTotalVREPIS;
    property TotalVRECOF: Double read FTotalVRECOF;
    property TotalRECSSL: Double read FTotalRECSSL;
    property TotalRETISS: Double read FTotalRETISS;
    property TotalREINSS: Double read FTotalREINSS;
    property TotalRINSSP: Double read FTotalRINSSP;

    property TemRetencoes: Boolean read fGetTemRetencao;
    property Retencoes: TArrRetencao read FrrRetencao;
    property ValorBase: Double read FValorBase;
    procedure pAtualizarValorRetencao(const AintIndice: Integer;
      const AdobValorXML: Double);
  end;

 const   RET_TOTAL_VALOR_LIQUIDO = 'Vr.Líquido........:';
         TIPRET_PIS    = 0;
         TIPRET_COFINS = 1;
         TIPRET_CSLL   = 2;
         TIPRET_IRFF   = 3;
         TIPRET_INSS   = 4;
         TIPRET_ISS    = 5;
         TIPRET_INSSP  = 6;


implementation

uses
  untCadPag;

{ TRetencoesNoFrame }

class function TRetencoesNoFrame.CreateClass(AOWner: TComponent; ACodFor: string): TRetencoesNoFrame;
var
  qry: TUniQuery;
begin
  Result := TRetencoesNoFrame.Create(AOWner);
  Result.FValorBase := 0;

  qry := fCriaQuery();
  try
    qry.SQL.Add('SELECT ');
    qry.SQL.Add('       RET_ALIQUO,');
    qry.SQL.Add('       RET_CODCTA,');
    qry.SQL.Add('       RET_CODEVE,');
    qry.SQL.Add('       RET_CODFOR,');
    qry.SQL.Add('       RET_DIAVEN,');
    qry.SQL.Add('       RET_FORRET,');
    qry.SQL.Add('       RET_TIPRET,');
    qry.SQL.Add('       RET_TIPVEN,');
    qry.SQL.Add('       RET_CODPOR,');
    qry.SQL.Add('       RET_TIPDOC,');
    qry.SQL.Add('       RET_Q_GUIA,');
    qry.SQL.Add('       RET_CODREC');
    qry.SQL.Add('  FROM FORRET');
    qry.SQL.Add(' WHERE RET_CODFOR = ' + QuotedStr(ACodFor));
    qry.SQL.Add(' ORDER BY RET_TIPRET');
    qry.Open;

    Result.pCarregarRetencoes(qry);
  finally
    FreeAndNil(qry);
  end;
end;

destructor TRetencoesNoFrame.Destroy;
begin
  SetLength(FrrRetencao, 0);
  FreeAndNil(qryCtaDet);
  inherited;
end;

procedure TRetencoesNoFrame.pZeraValoresRetencao;
begin
  FTotalREIRRF := 0;
  FTotalVREPIS := 0;
  FTotalVRECOF := 0;
  FTotalRECSSL := 0;
  FTotalRETISS := 0;
  FTotalREINSS := 0;
  FTotalRINSSP := 0;
end;

procedure TRetencoesNoFrame.pCarregarRetencoes(qry: TUniQuery);
var
  i: Integer;
begin

  pZeraValoresRetencao;

  SetLength(FrrRetencao, qry.RecordCount);
  i := 0;

  qry.First;
  while not qry.Eof do
  begin
    FrrRetencao[i].RET_ALIQUO := qry.FieldByName('RET_ALIQUO').AsFloat;
    FrrRetencao[i].RET_CODCTA := qry.FieldByName('RET_CODCTA').AsString;
    FrrRetencao[i].RET_CODEVE := qry.FieldByName('RET_CODEVE').AsString;
    FrrRetencao[i].RET_CODFOR := qry.FieldByName('RET_CODFOR').AsString;
    FrrRetencao[i].RET_DIAVEN := qry.FieldByName('RET_DIAVEN').AsInteger;
    FrrRetencao[i].RET_FORRET := qry.FieldByName('RET_FORRET').AsString;
    FrrRetencao[i].RET_TIPRET := qry.FieldByName('RET_TIPRET').AsInteger;
    FrrRetencao[i].RET_TIPVEN := qry.FieldByName('RET_TIPVEN').AsInteger;
    FrrRetencao[i].RET_CODPOR := qry.FieldByName('RET_CODPOR').AsString;
    FrrRetencao[i].RET_TIPDOC := qry.FieldByName('RET_TIPDOC').AsInteger;
    FrrRetencao[i].RET_Q_GUIA := qry.FieldByName('RET_Q_GUIA').AsString;
    FrrRetencao[i].RET_CODREC := qry.FieldByName('RET_CODREC').AsString;
    FrrRetencao[i].ValorRetencao := 0;

    Inc(i);
    qry.Next;
  end;
end;

procedure TRetencoesNoFrame.pGravarCtpDet(ARetencao: TRetencao; strParcel, strLocalOrigem: String);
  Var
    qryInsert: TUniQuery;
    strAutIncCtpDet: String;
begin
  FblnGravouCtpDet := True;
  If Not Assigned(qryCtaDet) Then
    Exit;
  qryInsert := fCriaQuery;
  Try
    if fEmptyStr(strLocalOrigem) Then
      strLocalOrigem := 'frmDesmembrValores';

    qryInsert.SQL.Add('INSERT INTO ');
    qryInsert.SQL.Add('  CTPDET ');
    qryInsert.SQL.Add('( ');
    qryInsert.SQL.Add('  CTP_NUMDUP, ');
    qryInsert.SQL.Add('  CTP_PARCEL, ');
    qryInsert.SQL.Add('  CTP_SERIE_, ');
    qryInsert.SQL.Add('  CTP_CODEMP, ');
    qryInsert.SQL.Add('  CTP_CODFOR, ');
    qryInsert.SQL.Add('  CTP_CODCTA, ');
    qryInsert.SQL.Add('  CTP_EMPORI, ');
    qryInsert.SQL.Add('  CTP_FATCAL, ');
    qryInsert.SQL.Add('  CTP_CODEVE, ');
    qryInsert.SQL.Add('  AUTOINCREM ');
    qryInsert.SQL.Add(') VALUES ( ');
    qryInsert.SQL.Add('  :NUMDUP, ');
    qryInsert.SQL.Add('  :PARCEL, ');
    qryInsert.SQL.Add('  :SERIE_, ');
    qryInsert.SQL.Add('  :CODEMP, ');
    qryInsert.SQL.Add('  :CODFOR, ');
    qryInsert.SQL.Add('  :CODCTA, ');
    qryInsert.SQL.Add('  :EMPORI, ');
    qryInsert.SQL.Add('  :FATCAL, ');
    qryInsert.SQL.Add('  :CODEVE, ');
    qryInsert.SQL.Add('  :AUTINC) ');



    If Not qryCtaDet.Active Then
      qryCtaDet.Open;

    strAutIncCtpDet := fRetAutoIncrem('CTPDET', VS_strCodEmp, qryCtaDet.RecordCount);
    qryCtaDet.First;

    While (Not qryCtaDet.Eof) Do
    Begin
      qryInsert.ParamByName('NUMDUP').AsString := FstrNumDup;
      qryInsert.ParamByName('PARCEL').AsString := strParcel;
      If fEmptyStr(strSerie) Then
        qryInsert.ParamByName('SERIE_').AsString := ''
      Else
        qryInsert.ParamByName('SERIE_').AsString := strSerie;
      qryInsert.ParamByName('CODEMP').AsString := qryCtaDet.FieldByName('CTP_CODEMP').AsString;
      qryInsert.ParamByName('CODFOR').AsString := ARetencao.RET_FORRET;
      qryInsert.ParamByName('CODCTA').AsString := qryCtaDet.FieldByName('CTP_CODCTA').AsString;
      qryInsert.ParamByName('EMPORI').AsString := VS_strCodEmp;
      qryInsert.ParamByName('FATCAL').AsFloat  := qryCtaDet.FieldByName('CTP_FATCAL').AsFloat;
      qryInsert.ParamByName('CODEVE').AsString := qryCtaDet.FieldByName('CTP_CODEVE').AsString;

      If fEmptyStr(qryInsert.ParamByName('CODEVE').AsString) Then
        qryInsert.ParamByName('CODEVE').Clear;

      If fEmptyStr(strAutIncCtpDet) Then
      Begin

        qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);

      End Else
      Begin
        qryInsert.ParamByName('AUTINC').AsString := strAutIncCtpDet;
        strAutIncCtpDet := fNextAutoIncrem(strAutIncCtpDet);
      End;

      Try
        qryInsert.ExecSQL;

        pGravaLogCtpDet(qryInsert.ParamByName('AUTINC').AsString,
                        'INCLUSÃO',
                      strLocalOrigem);
      Except
        FblnGravouCtpDet := False;
        raise;
      End;
      qryCtaDet.Next;
    End;
  Finally
    FreeAndNil(qryInsert);
  End;
end;


procedure TRetencoesNoFrame.pCalcularRetencoes;
var
  i: Integer;
begin
  pZeraValoresRetencao;
  for i := 0 to High(FrrRetencao) do
  begin
    FrrRetencao[i].ValorRetencao := (FValorBase * FrrRetencao[i].RET_ALIQUO) / 100;
    If FrrRetencao[i].ValorRetencao > 0 then
    begin
      case FrrRetencao[i].RET_TIPRET of
        TIPRET_PIS   : FTotalVREPIS :=  FTotalVREPIS + FrrRetencao[i].ValorRetencao;
        TIPRET_COFINS: FTotalVRECOF :=  FTotalVRECOF + FrrRetencao[i].ValorRetencao;
        TIPRET_CSLL  : FTotalRECSSL :=  FTotalRECSSL + FrrRetencao[i].ValorRetencao;
        TIPRET_IRFF  : FTotalREIRRF :=  FTotalREIRRF + FrrRetencao[i].ValorRetencao;
        TIPRET_INSS  : FTotalREINSS :=  FTotalREINSS + FrrRetencao[i].ValorRetencao;
        TIPRET_ISS   : FTotalRETISS :=  FTotalRETISS + FrrRetencao[i].ValorRetencao;
        TIPRET_INSSP : FTotalRINSSP :=  FTotalRINSSP + FrrRetencao[i].ValorRetencao;
      end;
    end;
  end;
end;

function TRetencoesNoFrame.fGetTemRetencao: Boolean;
begin
  Result := Length(FrrRetencao) > 0;
end;

procedure TRetencoesNoFrame.pSetaValorBase(AValorbase: Double);
begin
  FValorBase := AValorbase;
  pCalcularRetencoes;
end;

procedure TRetencoesNoFrame.pSetCamposIdentificaDocumento(AstrNumDoc, AstrEspDoc,
  AstrSerie, AstrCodEmp, AstrForCli, AstrNomFor: string; AdtaDtaDoc, AdtaDtaEnt: TDate);
begin
  strNumDoc := AstrNumDoc;
  strEspDoc := AstrEspDoc;
  strSerie := AstrSerie;
  strCodEmp := AstrCodEmp;
  strForCli := AstrForCli;
  strNomFor := AstrNomFor;
  dtaDtaDoc := AdtaDtaDoc;
  dtaDtaEnt := AdtaDtaEnt;
  If Assigned(qryCtaDet) Then
    pFreeAndNil(qryCtaDet);
  pCriaClientTemporariaCtpDet(strNumDoc, '', strSerie, strCodEmp, strForCli, qryCtaDet);

end;

function TRetencoesNoFrame.fRetTotalImpostos: Double;
var
  i: Integer;
begin
  Result := 0;

  for i := 0 to High(FrrRetencao) do
  begin
    If (FrrRetencao[i].RET_TIPRET <> TIPRET_INSSP) And (FrrRetencao[i].RET_ALIQUO > 0) then
      Result := Result + FrrRetencao[i].ValorRetencao;
  end;
end;

function TRetencoesNoFrame.fRetHistoricoRetencao(fltTotDoc, fltTotLiq: Double): String;
var
  strLinha: string;
  retencao: TRetencao;
begin
  strLinha := StringOfChar(' ', 100);
  Insert('Vr. Serviço.......:', strLinha, 1);
  Insert(fPadL(FormatFloat('#0.00', fltTotDoc), 15), strLinha, 21);
  Result := Copy(strLinha, 1 , 36);
  For retencao in FrrRetencao do
  Begin
    If retencao.ValorRetencao = 0 then
      Continue;

    Case retencao.RET_TIPRET Of
      TIPRET_PIS   : Begin
                       strLinha := StringOfChar(' ', 100);
                       Insert('Retenção de PIS...:', strLinha, 1);
                       Insert(fPadL(FormatFloat('#0.00', retencao.ValorRetencao), 15), strLinha, 21);
                     End;
      TIPRET_COFINS: Begin
                       strLinha := StringOfChar(' ', 100);
                       Insert('Retenção de COFINS:', strLinha, 1);
                       Insert(fPadL(FormatFloat('#0.00', retencao.ValorRetencao), 15), strLinha, 21);
                     End;
      TIPRET_CSLL  : Begin
                       strLinha := StringOfChar(' ', 100);
                       Insert('Retenção de CSSL..:', strLinha, 1);
                       Insert(fPadL(FormatFloat('#0.00', retencao.ValorRetencao), 15), strLinha, 21);
                     End;
      TIPRET_IRFF  : Begin
                       strLinha := StringOfChar(' ', 100);
                       Insert('Retenção de IRRF..:', strLinha, 1);
                       Insert(fPadL(FormatFloat('#0.00', retencao.ValorRetencao), 15), strLinha, 21);
                     End;
      TIPRET_INSS  : Begin
                       strLinha := StringOfChar(' ', 100);
                       Insert('Retenção de INSS..:', strLinha, 1);
                       Insert(fPadL(FormatFloat('#0.00', retencao.ValorRetencao), 15), strLinha, 21);
                     End;
      TIPRET_ISS   : Begin
                       strLinha := StringOfChar(' ', 100);
                       Insert('Retenção de ISS...:', strLinha, 1);
                       Insert(fPadL(FormatFloat('#0.00', retencao.ValorRetencao), 15), strLinha, 21);
                     End;
      TIPRET_INSSP : Begin
                       strLinha := StringOfChar(' ', 100);
                       Insert('INSS Patronal...:', strLinha, 1);
                       Insert(fPadL(FormatFloat('#0.00', retencao.ValorRetencao), 15), strLinha, 21);
                     End;

    End;
    Result := Result + #$A#$D + Copy(strLinha, 1 , 36);

  End;
  Result := Result + #$A#$D + RET_TOTAL_VALOR_LIQUIDO + fPadL(FormatFloat('#0.00', fltTotLiq), 16) + #$A#$D;
end;


function TRetencoesNoFrame.fCalcularDataVencimento(ARetencao: TRetencao; var wrdAno: Word; var wrdMes: Word;  var wrdDia: Word;
                                                    var dteVencto: TDateTime; var dteUltDiaMes: TDateTime): TDateTime;
begin
  dteVencto := dtaDtaEnt;
  DecodeDate(dteVencto, wrdAno, wrdMes, wrdDia);

  If wrdMes = 12 Then
    dteUltDiaMes := EndOfAMonth(wrdAno + 1, 1)
  Else
    dteUltDiaMes := EndOfAMonth(wrdAno, wrdMes +1);

  DecodeDate(dteUltDiaMes, wrdAno, wrdMes, wrdDia);

  Case ARetencao.RET_TIPVEN Of
    //VENCIMENTO EM DIA FIXO
    0: Result := EncodeDate(wrdAno,
                            wrdMes,
                            IIF(ARetencao.RET_DIAVEN > wrdDia,
                                wrdDia,
                                ARetencao.RET_DIAVEN));
    //VENCIMENTO NO ÚLTIMO DIA DO MÊS
    1: Result := EncodeDate(wrdAno,
                            wrdMes,
                            wrdDia);
    Else
      Result := 0;
  End;

End;


function TRetencoesNoFrame.fCriarParcelasRetencoesFornecedor(AutIncFis: string; blnGravaCadpag: Boolean; AstrLocalOrigem: String = ''): Boolean;
  Var
    wrdAno, wrdMes, wrdDia : Word;
    dteVencto, dteUltDiaMes: TDateTime;
    strLogCta, strHist, strTipRet: String;
    AIncCtp: string;
    Retencao: TRetencao;

begin
  Result := True;
  try
    For retencao in FrrRetencao do
    begin
      If (retencao.RET_ALIQUO > 0) And (retencao.ValorRetencao > 0) Then
      Begin
        If blnGravaCadpag Then
        Begin
          FstrNumDup := fRetSequencialCadPag();
          strLogCta := 'INCLUSÃO LIVRO FISCAL';

          Case retencao.RET_TIPRET Of
            0: strTipRet := 'RETENÇÃO DE PIS';
            1: strTipRet := 'RETENÇÃO DE COFINS';
            2: strTipRet := 'RETENÇÃO DE CSSL';
            3: strTipRet := 'RETENÇÃO DE IRRF';
            4: strTipRet := 'RETENÇÃO DE INSS';
            5: strTipRet := 'RETENÇÃO DE ISS';
            6: strTipRet := 'INSS PATRONAL';
          End;

          strHist := strTipRet + ' do documento ' +
                     strNumDoc + '-' + strEspDoc + '-' + strSerie + '-' + strCodEmp +
                     ', Fornecedor: ' + strForCli + '-' + strNomFor +
                     ', emitida em ' + DateToStr(dtaDtaDoc) + '.';
          AIncCtp := fRetAutoIncrem('CADPAG', VS_StrCodEmp);
          Result := Result and fGravaCadPag('frmCadLivroFiscal',                            // Nome Form LOGCTP
                             strLogCta,                                      // Descrição LOGCTP
                             retencao.RET_FORRET,   // Fornecedor
                             FstrNumDup,                                      // Número da duplicata
                             'A',                                            // Parcela
                             strCodEmp,                       // Empresa
                             retencao.RET_CODCTA,   // Centro de Custo
                             '',                                             // Serie do Documento
                             0,                                              // Sequencial de Baixa
                             dtaDtaEnt,                                         // Data do lançamento
                             fCalcularDataVencimento(retencao, wrdAno, wrdMes, wrdDia, dteVencto, dteUltDiaMes), // Data de Vencimento
                             retencao.ValorRetencao,        // Valor da Duplicata
                             retencao.ValorRetencao,        // Valor Original
                             'N',                                            // Previsão?
                             'N',                                            // Veio Boleto
                             'N',                                            // Deposito
                             strHist,                                        // Histórico 1
                             '',                                             // Histórico 2
                             '',                                             // Histórico da Baixa
                             '',                                             // Portador da Baixa
                             '',                                             // Centro de Custo da Baixa
                             '',                                             // Documento da Baixa
                             '',                                             // Operador da Baixa
                             0,                                              // Data do Pagamento
                             0,                                              // Valor Pago
                             0,                                              // Valor de Juros
                             0,                                              // Valor Desconto
                             '',                                             // Empresa
                             retencao.RET_CODEVE,   // Codigo do Evento
                             'N',                                            // Usa Cheque
                             retencao.RET_CODPOR,   // Codigo do Portador
                             strNumDoc,                                      // Número do documento
                             0,
                             0,
                             0,
                             False,
                             0,
                             retencao.RET_TIPDOC.ToString,
                             0,
                            '',
                            '',
                            '',
                            '',
                            AIncCtp,
                            '',
                            '',
                            '',
                            '',
                            '',
                            FormatDateTime('mm/yyyy', dtaDtaDoc),
                            '',
                            '',
                            '',
                            '',
                             0,
                             0,
                             0,
                             0,
                            '',
                             0,
                             0,
                            '',
                            '',
                            '',
                            '',
                            '',
                            retencao.RET_Q_GUIA,
                            retencao.RET_CODREC,
                            '',
                            '',
                            '',
                            'N',
                            '',  // strAutIncFunrural: String = '';
                            '',  // strGnreNumeroDocumento: String = '';
                            '',  // strGnreChaveDeAcesso: String = '';
                            '',  // strGnreNumeroDeControle: String = '';
                            0,   // dtaGnreDataPrevisaoPagamento: TDateTime = 0;
                            '',  // strGnreConvenio: String = '';
                            0,   // fltMulSuj : Double = 0;
                            '',  // strAutIncPix: String = '';
                            0,   // fltGrvOri: Double = 0;
                            0,   // ADtaLiberacao: TDAteTime = 0;
                            0,   // AHorLiberacao: TDateTime = 0;
                            '',  // AOpeLiberacao: String = '';
                            '',  // strGnreChaveDeApuracao: String = '';
                            AutIncFis, // AIncCadFis: string = '';
                            '',  // strQrCode: string = '';
                            'N'); // AUsaMca: String = '';
          If Result Then
          Begin
            pGravarCtpDet(retencao, 'A', AstrLocalOrigem);
            Result := Result and FblnGravouCtpDet And fIncluiRETFIS(retencao, AutIncFis, AIncCtp);
          End;
        End;
      end;
    end;
  Except
    on e: Exception do
    Begin
      pMensagensErro(e.message, '[TRetencoesNoFrame.fCriarParcelasRetencoesFornecedor]');
      Result := False;
    End;
  End;
end;

function TRetencoesNoFrame.fIncluiRETFIS(ARetencao: TRetencao; AIncFis, AIncCTP: String): Boolean;
var lQry: TUniQuery;
    lQryCadPag: TUniQuery;
const
    intInsert = 0;
    intUpdate = 1;
    intDelete = 2;
begin
  lQry := fCriaQuery;
  lQryCadPag := fCriaQuery;
  try
    Result := True;
    try
       lQry.SQL.Add('INSERT INTO RETFIS (');
       lQry.SQL.Add('AUTOINCREM,');
       lQry.SQL.Add('RET_ALIQUO,');
       lQry.SQL.Add('RET_CODCTA,');
       lQry.SQL.Add('RET_CODEVE,');
       lQry.SQL.Add('RET_DIAVEN,');
       lQry.SQL.Add('RET_FORRET,');
       lQry.SQL.Add('RET_TIPRET,');
       lQry.SQL.Add('RET_TIPVEN,');
       lQry.SQL.Add('RET_CODPOR,');
       lQry.SQL.Add('RET_BASRET,');
       lQry.SQL.Add('RET_VALRET,');
       lQry.SQL.Add('RET_INCFIS,');
       lQry.SQL.Add('RET_CTPFOR,');
       lQry.SQL.Add('RET_NUMDUP,');
       lQry.SQL.Add('RET_PARCEL,');
       lQry.SQL.Add('RET_Q_GUIA,');
       lQry.SQL.Add('RET_TIPDOC,');
       lQry.SQL.Add('RET_CODREC,');
       lQry.SQL.Add('RET_CTPEMP,');
       lQry.SQL.Add('RES_CTPSER');
       lQry.SQL.Add(') VALUES (');
       lQry.SQL.Add(':AUTOINCREM,');
       lQry.SQL.Add(':RET_ALIQUO,');
       lQry.SQL.Add(':RET_CODCTA,');
       lQry.SQL.Add(':RET_CODEVE,');
       lQry.SQL.Add(':RET_DIAVEN,');
       lQry.SQL.Add(':RET_FORRET,');
       lQry.SQL.Add(':RET_TIPRET,');
       lQry.SQL.Add(':RET_TIPVEN,');
       lQry.SQL.Add(':RET_CODPOR,');
       lQry.SQL.Add(':RET_BASRET,');
       lQry.SQL.Add(':RET_VALRET,');
       lQry.SQL.Add(':RET_INCFIS,');
       lQry.SQL.Add(':RET_CTPFOR,');
       lQry.SQL.Add(':RET_NUMDUP,');
       lQry.SQL.Add(':RET_PARCEL,');
       lQry.SQL.Add(':RET_Q_GUIA,');
       lQry.SQL.Add(':RET_TIPDOC,');
       lQry.SQL.Add(':RET_CODREC,');
       lQry.SQL.Add(':RET_CTPEMP,');
       lQry.SQL.Add(':RES_CTPSER');
       lQry.SQL.Add(');');
       lQry.ParamByName('AUTOINCREM').AsString := fRetAutoincrem('RETFIS', VS_StrCodEmp);

       lQry.ParamByName('RET_ALIQUO').AsFloat := ARetencao.RET_ALIQUO;
       lQry.ParamByName('RET_BASRET').AsFloat := FValorBase;
       lQry.ParamByName('RET_VALRET').AsFloat := ARetencao.ValorRetencao;
       lQry.ParamByName('RET_TIPDOC').AsString := ARetencao.RET_TIPDOC.ToString;
       lQryCadPag.SQL.Text := 'SELECT * FROM CADPAG WHERE AUTOINCREM = "'+AIncCTP+'"';
       lQryCadPag.Open;
       Result := Not LQryCadPag.IsEmpty;
       If Result Then
       Begin
         lQry.ParamByName('RET_CTPFOR').AsString := lQryCadPag.FieldByName('CTP_CODFOR').AsString;
         lQry.ParamByName('RET_NUMDUP').AsString := lQryCadPag.FieldByName('CTP_NUMDUP').AsString;
         lQry.ParamByName('RET_PARCEL').AsString := lQryCadPag.FieldByName('CTP_PARCEL').AsString;
         lQry.ParamByName('RET_CTPEMP').AsString := lQryCadPag.FieldByName('CTP_CODEMP').AsString;
         lQry.ParamByName('RES_CTPSER').AsString := lQryCadPag.FieldByName('CTP_SERIE_').AsString;
         lQry.ParamByName('RET_CODCTA').AsString := ARetencao.RET_CODCTA;
         If fEmptyStr(lQry.ParamByName('RET_CODCTA').AsString) Then
           lQry.ParamByName('RET_CODCTA').Clear;
         lQry.ParamByName('RET_CODEVE').AsString := ARetencao.RET_CODEVE;
            If fEmptyStr(lQry.ParamByName('RET_CODEVE').AsString) Then
              lQry.ParamByName('RET_CODEVE').Clear;
         lQry.ParamByName('RET_DIAVEN').AsInteger := ARetencao.RET_DIAVEN;
         lQry.ParamByName('RET_FORRET').AsString :=  ARetencao.RET_FORRET;
         lQry.ParamByName('RET_TIPRET').AsString := ARetencao.RET_TIPRET.ToString;
         lQry.ParamByName('RET_TIPVEN').AsString := ARetencao.RET_TIPVEN.ToString;
         lQry.ParamByName('RET_CODPOR').AsString := ARetencao.RET_CODPOR;
         //Portador vazio (FORRET sem portador) vai NULL; '' viola a FK_RETFIS_05 com CADPOR
         If fEmptyStr(lQry.ParamByName('RET_CODPOR').AsString) Then
           lQry.ParamByName('RET_CODPOR').Clear;
         lQry.ParamByName('RET_Q_GUIA').AsString := ARetencao.RET_Q_GUIA;
         lQry.ParamByName('RET_TIPDOC').AsString := ARetencao.RET_TIPDOC.ToString;
         lQry.ParamByName('RET_CODREC').AsString := ARetencao.RET_CODREC;
         lQry.ParamByName('RET_INCFIS').AsString := AIncFis;
         lQry.ExecSQL;
       End;
    Except
      on E: Exception do
      Begin
        pMensagensErro(e.message, '[TRetencoesNoFrame.fIncluiRETFIS]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(lQry);
    FreeAndNil(lQryCadPag);
  End;
end;

procedure TRetencoesNoFrame.pAtualizarValorRetencao(const AintIndice: Integer; const AdobValorXML: Double);
var
  LintContador: Integer;
begin
  for LintContador := 0 to High(FrrRetencao) do
  begin
    if FrrRetencao[LintContador].RET_TIPRET = AintIndice then
    begin
      FrrRetencao[LintContador].ValorRetencao := AdobValorXML;
      Break;
    end;
  end;
end;


end.
