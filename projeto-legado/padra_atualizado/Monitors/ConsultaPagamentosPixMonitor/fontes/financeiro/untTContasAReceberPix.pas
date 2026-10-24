unit untTContasAReceberPix;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core, untTypesSistema,
{$ELSE}
  UniClientDataset,
{$ENDIF}
  System.SysUtils, Uni, Data.DB, untTiposPix, System.Variants, System.StrUtils;

Type
  TContasAReceberPix = class
  private
    class var FBaixaAnalitica: Boolean;
    class var FProximoDiaUtil: Boolean;
    class var FAtualizaBolCtr: Boolean;

    class function BaixaParcialReceber(ADuplicata: TDataset;
                                       ADadosPix: TDadosRetornoPixConsulta): Boolean;

    class function BaixaTotalReceber(ADuplicata: TDataset;
                                     ADadosPix: TDadosRetornoPixConsulta): Boolean;

    class function RealizaGravacaoMovimentacaoBancaria(var ADuplicatas: TUniClientDataset;
                                                       var ADadosPix: TDadosRetornoPixConsulta): Boolean;

    class function RealizaGravacaoMovimentacaoBancariaCC(ADatasetCadRec: TUniQuery;
                                                         var ADadosPix: TDadosRetornoPixConsulta): Boolean;

    class function RetornaUltimoSeqBaiCADREC(ANumDup,
                                             AParcel,
                                             ACodEmp,
                                             AEspDoc,
                                             ACodCli: String): Integer;

    class function RetornaDifOri(ADataset: TDataset;
                                 ADataRecebimento: TDateTime): Double;

    class function RetornaDataVencimentoBaixaParcial(ADataset: TDataset;
                                                     ADataRecebimento: TDateTime): TDateTime;

    class function RetornaGRVORI(ANumDup,
                                 AEspDoc,
                                 ACodEmp,
                                 AParcel,
                                 ACodCli: String): Double;

    class procedure AtualizarAutoIncremBOLCTR(AAutoIncremParcial,
                                              AAutoIncremAberta: String);

    class procedure AtualizaBOLCTRBoletosBaixaTotal(AAutoIncremCTR: String);

    class function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;

    class function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True;
                               strCodCid: String = ''; blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                               blnConsideraDomingo: Boolean = False): Boolean;

    class function fEhFeriado(dtaDta: TDateTime; strCodCid: String = ''): Boolean;
  public
    class procedure RealizarBaixaDoContasAReceber(ATxIdPix,
                                                  ACodigoEmpresa: String;
                                                  var ADadosPix: TDadosRetornoPixConsulta);

    class procedure GerarCreditoDeClientePix(ADadosPix: TDadosRetornoPixConsulta);
  end;

implementation
Uses untFuncoesSimples, untMovBan, untTBanCtrRepository, untLogCtr, Math;
{ TContasAReceberPix }

class function TContasAReceberPix.BaixaParcialReceber(
  ADuplicata: TDataset; ADadosPix: TDadosRetornoPixConsulta): Boolean;
  Var
    LSeqBaiNovo: Integer;

    LSQL,
    LHist01,
    LHisBai: String;

    LValorNovaDuplicata,
    LJurosNovaDuplicata,
    LDescontoNovaDuplicata,
    LDespesasNovaDuplicata,
    LJurosCalculado,
    LDescontoCalculado,
    LDespesasCalculado,
    LProporcaoImposto,
    LValorRecebido,
    LValorBaixaDuplicata,
    LValorCorrigido,
    LDesconto,
    LDespesas,
    LJuros,
    LFatorBaixaDuplicata,
    LFatorJurosDuplicata,
    LDiferenca: Double;

    LValorDuplicataAnterior: Double;

    LBaixar,
    LNovaDuplicata: TUniQuery;

    LNovaBaixa,
    LReformaTributaria: Boolean;
begin
  Try
    LBaixar := fCriaQuery;
    LNovaDuplicata := fCriaQuery;

    LNovaDuplicata.SQL.Text := 'SELECT * FROM CADREC WHERE FALSE';
    LNovaDuplicata.Open;

    LNovaBaixa := LNovaDuplicata.FindField('CTR_NOVBAI') <> Nil;

    LReformaTributaria := (LNovaDuplicata.FindField('CTR_VALCBS') <> Nil) And
                          (LNovaDuplicata.FindField('CTR_VALIBS') <> Nil) And
                          (LNovaDuplicata.FindField('CTR_VAL_IS') <> Nil);

    LSeqBaiNovo := RetornaUltimoSeqBaiCADREC(ADuplicata.FieldByName('CTR_NUMDUP').AsString,
                                             ADuplicata.FieldByName('CTR_PARCEL').AsString,
                                             ADuplicata.FieldByName('CTR_CODEMP').AsString,
                                             ADuplicata.FieldByName('CTR_ESPDOC').AsString,
                                             ADuplicata.FieldByName('CTR_CODCLI').AsString);
    Inc(LSeqBaiNovo);

    If Not fEmptyStr(ADuplicata.FieldByName('CTR_NOSNUM').AsString) Then
      LHist01 := 'Nosso número: ' + ADuplicata.FieldByName('CTR_NOSNUM').AsString + IIF(fEmptyStr(LHist01), '', ' - ' + LHist01);

    LHisBai := 'BAIXA DE DUPLICATA RECEBIDA POR PIX - '+
               ADuplicata.FieldByName('CTR_NUMDUP').AsString + ' ' +
               ADuplicata.FieldByName('CTR_ESPDOC').AsString + ' - ' +
               ADuplicata.FieldByName('CTR_CODCLI').AsString;

    {*****************************************}
    {* BAIXA A DUPLICATA...                  *}
    {**************************************MV*}
    LSQL := '';
    LSQL := LSQL + 'UPDATE ';
    LSQL := LSQL + '  CADREC ';
    LSQL := LSQL + 'SET ';
    LSQL := LSQL + '  CTR_VALANT = :VALANT, ';
    LSQL := LSQL + '  CTR_JURANT = CTR_JURSUJ, ';
    LSQL := LSQL + '  CTR_DESANT = CTR_DESSUJ, ';
    LSQL := LSQL + '  CTR_COBANT = CTR_DESCOB, ';
    LSQL := LSQL + '  CTR_VALDUP = 0, ';
    LSQL := LSQL + '  CTR_JURSUJ = 0, ';
    LSQL := LSQL + '  CTR_DESSUJ = 0, ';
    LSQL := LSQL + '  CTR_DESCOB = 0, ';
    LSQL := LSQL + '  CTR_DTAREC = :DTAREC, ';
    LSQL := LSQL + '  CTR_SEQBAI = :SEQBAI, ';
    LSQL := LSQL + '  CTR_VALORI = :VALORI, ';
    LSQL := LSQL + '  CTR_VALREC = :VALREC, ';
    LSQL := LSQL + '  CTR_PORBAI = :PORBAI, ';
    LSQL := LSQL + '  CTR_HIST01 = :HIST01, ';
    LSQL := LSQL + '  CTR_HISBAI = :HISBAI, ';
    LSQL := LSQL + '  CTR_DOCBAI = :DOCBAI, ';
    LSQL := LSQL + '  CTR_CTABAI = :CTABAI, ';
    LSQL := LSQL + '  CTR_OPEBAI = :OPEBAI, ';
    LSQL := LSQL + '  CTR_DTABAI = ' + untFuncoesSimples.fCurrentDate + ', ';
    LSQL := LSQL + '  CTR_EMPBAI = :EMPBAI, ';
    LSQL := LSQL + '  CTR_CHQPRE = 0, ';
    LSQL := LSQL + '  CTR_CHQAVI = 0, ';
    LSQL := LSQL + '  CTR_DINHEI = 0, ';
    LSQL := LSQL + '  CTR_CARTAO = 0, ';
    LSQL := LSQL + '  CTR_ORDPAG = :ORDPAG, ';
    LSQL := LSQL + '  CTR_VALFIN = 0, ';
    LSQL := LSQL + '  CTR_RECDIN = "N", ';
    LSQL := LSQL + '  CTR_RECCHE = "N", ';
    LSQL := LSQL + '  CTR_RECPRE = "N", ';
    LSQL := LSQL + '  CTR_RECCAR = "N", ';
    LSQL := LSQL + '  CTR_RECORD = "S", ';
    LSQL := LSQL + '  CTR_RECFIN = "N", ';

    LSQL := LSQL + '  CTR_SEQMOD = NULL, ';
    LSQL := LSQL + '  CTR_RESCAI = 0, ';
    LSQL := LSQL + '  CTR_SEQCON = :SEQCON, ';
    LSQL := LSQL + '  CTR_VALIPI = :VALIPI, ';
    LSQL := LSQL + '  CTR_VALRET = :VALRET, ';
    LSQL := LSQL + '  CTR_VALFCP = :VALFCP, ';
    LSQL := LSQL + '  CTR_VALACE = :VALACE, ';
    LSQL := LSQL + '  CTR_VALFRE = :VALFRE, ';

    If LReformaTributaria Then
    Begin
      LSQL := LSQL + '  CTR_VALCBS = :VALCBS, ';
      LSQL := LSQL + '  CTR_VALIBS = :VALIBS, ';
      LSQL := LSQL + '  CTR_VAL_IS = :VAL_IS, ';
    End;

    LSQL := LSQL + '  CTR_DIFORI = :DIFORI, ';
    LSQL := LSQL + '  CTR_NOSNUM = :NOSNUM, ';
    LSQL := LSQL + '  CTR_RECAUT = "N", ';

    If LNovaBaixa Then
    Begin
      LSQL := LSQL + '  CTR_VALCOB = CTR_PIXCOB, ';
      LSQL := LSQL + '  CTR_VALJUR = CTR_PIXJUR, ';
      LSQL := LSQL + '  CTR_VALDES = CTR_PIXDES, ';
      LSQL := LSQL + '  CTR_VALCAL = CTR_PIXCOR, ';
      LSQL := LSQL + '  CTR_JURCAL = :JURCAL, ';
      LSQL := LSQL + '  CTR_FATDUP = :FATDUP, ';
      LSQL := LSQL + '  CTR_FATJUR = :FATJUR, ';
      LSQL := LSQL + '  CTR_NOVBAI = "S", ';
    End;

    LSQL := LSQL + '  CTR_DTABAN = :DTABAN, ';
    LSQL := LSQL + '  CTR_RECPIX = "S",     ';

    //Limpando campos do Pix
    LSQL := LSQL + '  CTR_PIXTIP=NULL,      ';
    LSQL := LSQL + '  CTR_PIXREC=NULL,      ';
    LSQL := LSQL + '  CTR_PIXJUR=NULL,      ';
    LSQL := LSQL + '  CTR_PIXDES=NULL,      ';
    LSQL := LSQL + '  CTR_PIXCOB=NULL,      ';
    LSQL := LSQL + '  CTR_PIXCOR=NULL       ';

    LSQL := LSQL + 'WHERE ';
    LSQL := LSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    LSQL := LSQL + '  CTR_PARCEL = :PARCEL AND ';
    LSQL := LSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    LSQL := LSQL + '  CTR_CODEMP = :CODEMP AND ';
    LSQL := LSQL + '  CTR_CODCLI = :CODCLI AND ';
    LSQL := LSQL + '  ( (CTR_DTAREC IS NULL) OR (CTR_SEQBAI = 0 AND IFNULL(CTR_ID_DOC, "") <> "") ) ';

    LBaixar.SQL.Text := LSQL;

    LValorRecebido          := ADuplicata.FieldByName('CTR_PIXREC').AsFloat;
    LValorDuplicataAnterior := ADuplicata.FieldByName('CTR_VALDUP').AsFloat;
    LValorCorrigido         := ADuplicata.FieldByName('CTR_PIXCOR').AsFloat;
    LDesconto               := ADuplicata.FieldByName('CTR_PIXDES').AsFloat;
    LDespesas               := ADuplicata.FieldByName('CTR_PIXCOB').AsFloat;
    LJuros                  := ADuplicata.FieldByName('CTR_PIXJUR').AsFloat;

    LBaixar.ParamByName('VALREC').AsFloat := LValorRecebido;
    LBaixar.ParamByName('DTAREC').AsDateTime := ADadosPix.DataPagamento;
    LBaixar.ParamByName('PORBAI').AsString := ADadosPix.CodigoPortador;
    LBaixar.ParamByName('SEQBAI').AsInteger := LSeqBaiNovo;

    LBaixar.ParamByName('HIST01').AsString := LHist01;
    If fCfgSis('HISBAI', varBoolean) Then
    Begin
      LBaixar.ParamByName('HIST01').AsString := LBaixar.ParamByName('HIST01').AsString;

      If Not LHist01.IsEmpty Then
        LBaixar.ParamByName('HIST01').AsString := LBaixar.ParamByName('HIST01').AsString +
                                                  #13 + LHisBai;
    End;

    LBaixar.ParamByName('HISBAI').AsString := LHisBai;

    LBaixar.ParamByName('DOCBAI').AsString := ADadosPix.MovBanBaixa;
    If LBaixar.ParamByName('DOCBAI').AsString.IsEmpty Then
      LBaixar.ParamByName('DOCBAI').AsString := ADuplicata.FieldByName('SEQLAN').AsString;

    LBaixar.ParamByName('CTABAI').AsString := ADadosPix.PlanoDeContas;
    LBaixar.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
    LBaixar.ParamByName('EMPBAI').AsString := ADadosPix.CodigoEmpresa;
    LBaixar.ParamByName('ORDPAG').AsFloat := ADuplicata.FieldByName('CTR_PIXREC').AsFloat;

    LBaixar.ParamByName('SEQCON').AsInteger := ADadosPix.SeqConRecebimento;

    LValorNovaDuplicata    := LValorDuplicataAnterior - LValorRecebido;
    LJurosNovaDuplicata    := ADuplicata.FieldByName('CTR_JURSUJ').AsFloat;
    LDescontoNovaDuplicata := ADuplicata.FieldByName('CTR_DESSUJ').AsFloat;
    LDespesasNovaDuplicata := ADuplicata.FieldByName('CTR_DESCOB').AsFloat;
    LValorBaixaDuplicata := LValorRecebido;
    If LNovaBaixa Then
    Begin
      LJurosCalculado    := fFormataFloat((LJuros/LValorRecebido)    * LValorCorrigido, 2);
      LDescontoCalculado := fFormataFloat((LDesconto/LValorRecebido) * LValorCorrigido, 2);
      LDespesasCalculado := fFormataFloat((LDespesas/LValorRecebido) * LValorCorrigido, 2);

      LDiferenca         := (LValorCorrigido - LValorDuplicataAnterior);
      LDiferenca         := fFormataFloat(LDiferenca - (LJurosCalculado + LDespesasCalculado - LDescontoCalculado),2);

      LFatorBaixaDuplicata := (LValorDuplicataAnterior/LValorCorrigido);
      LFatorJurosDuplicata := (LJurosCalculado/LValorCorrigido);

      LValorBaixaDuplicata := LValorRecebido - LJuros - LDespesas + LDesconto;

      LDespesasNovaDuplicata := fFormataFloat(LDespesasCalculado - LDespesas,2);
      LDescontoNovaDuplicata := fFormataFloat(LDescontoCalculado - LDesconto,2);
      LJurosNovaDuplicata    := fFormataFloat(LJurosCalculado - LJuros,2);
      LValorNovaDuplicata    := fFormataFloat((LValorDuplicataAnterior - LValorBaixaDuplicata) + LDiferenca,2);

      LBaixar.ParamByName('JURCAL').AsFloat := LJurosCalculado;
      LBaixar.ParamByName('FATDUP').AsFloat := LFatorBaixaDuplicata;
      LBaixar.ParamByName('FATJUR').AsFloat := LFatorJurosDuplicata;
    End;

    LBaixar.ParamByName('VALORI').AsFloat := LValorBaixaDuplicata;

    // Calcula a proporção do imposto
    Try
      LProporcaoImposto := (LValorRecebido -
                            LJuros +
                            LDesconto) /
                           (LValorNovaDuplicata +
                            LValorRecebido -
                            LJuros +
                            LDesconto);
    Except
      LProporcaoImposto := 0;
    End;

    LBaixar.ParamByName('VALIPI').AsFloat := ADuplicata.FieldByName('CTR_VALIPI').AsFloat * LProporcaoImposto;
    LBaixar.ParamByName('VALRET').AsFloat := ADuplicata.FieldByName('CTR_VALRET').AsFloat * LProporcaoImposto;
    LBaixar.ParamByName('VALACE').AsFloat := ADuplicata.FieldByName('CTR_VALACE').AsFloat * LProporcaoImposto;
    LBaixar.ParamByName('VALFRE').AsFloat := ADuplicata.FieldByName('CTR_VALFRE').AsFloat * LProporcaoImposto;
    LBaixar.ParamByName('VALFCP').AsFloat := ADuplicata.FieldByName('CTR_VALFCP').AsFloat * LProporcaoImposto;

    If LReformaTributaria Then
    Begin
      LBaixar.ParamByName('VALCBS').AsFloat := ADuplicata.FieldByName('CTR_VALCBS').AsFloat * LProporcaoImposto;
      LBaixar.ParamByName('VALIBS').AsFloat := ADuplicata.FieldByName('CTR_VALIBS').AsFloat * LProporcaoImposto;
      LBaixar.ParamByName('VAL_IS').AsFloat := ADuplicata.FieldByName('CTR_VAL_IS').AsFloat * LProporcaoImposto;
    End;

    LBaixar.ParamByName('DIFORI').AsFloat := RetornaDifOri(ADuplicata,
                                                           ADadosPix.DataPagamento);

    LBaixar.ParamByName('NOSNUM').Value := Null;

    LBaixar.ParamByName('VALANT').AsFloat := ADuplicata.FieldByName('CTR_VALDUP').AsFloat;

    LBaixar.ParamByName('DTABAN').AsDateTime := ADadosPix.DataPagamento;

    LBaixar.ParamByName('NUMDUP').AsString := ADuplicata.FieldByName('CTR_NUMDUP').AsString;
    LBaixar.ParamByName('PARCEL').AsString := ADuplicata.FieldByName('CTR_PARCEL').AsString;
    LBaixar.ParamByName('ESPDOC').AsString := ADuplicata.FieldByName('CTR_ESPDOC').AsString;
    LBaixar.ParamByName('CODEMP').AsString := ADuplicata.FieldByName('CTR_CODEMP').AsString;
    LBaixar.ParamByName('CODCLI').AsString := ADuplicata.FieldByName('CTR_CODCLI').AsString;

    LBaixar.ExecSQL;
    LBaixar.Close;

    {*****************************************}
    {* GRAVA NOVA DUPLICATA                  *}
    {**************************************MV*}
    LNovaDuplicata.Append;

    LNovaDuplicata.FieldByName('CTR_CODVEN').AsString := ADuplicata.FieldByName('CTR_CODVEN').AsString;
    LNovaDuplicata.FieldByName('CTR_CODDIG').AsString := ADuplicata.FieldByName('CTR_CODDIG').AsString;

    LNovaDuplicata.FieldByName('CTR_CODREP').Value := ADuplicata.FieldByName('CTR_CODREP').Value;
    LNovaDuplicata.FieldByName('CTR_CODDIG').Value := LNovaDuplicata.FieldByName('CTR_CODVEN').Value;

    LNovaDuplicata.FieldByName('CTR_CODPOR').Value := ADuplicata.FieldByName('CTR_CODPOR').Value;

    LNovaDuplicata.FieldByName('CTR_CODCLI').AsString := ADuplicata.FieldByName('CTR_CODCLI').AsString;
    LNovaDuplicata.FieldByName('CTR_NUMDUP').AsString := ADuplicata.FieldByName('CTR_NUMDUP').AsString;
    LNovaDuplicata.FieldByName('CTR_PARCEL').AsString := ADuplicata.FieldByName('CTR_PARCEL').AsString;
    LNovaDuplicata.FieldByName('CTR_SEQBAI').AsInteger  := 0;
    LNovaDuplicata.FieldByName('CTR_ESPDOC').AsString := ADuplicata.FieldByName('CTR_ESPDOC').AsString;
    LNovaDuplicata.FieldByName('CTR_DTACAD').AsDateTime := ADuplicata.FieldByName('CTR_DTACAD').AsDateTime;
    LNovaDuplicata.FieldByName('CTR_DTAVEN').AsDateTime := RetornaDataVencimentoBaixaParcial(ADuplicata,
                                                                                             ADadosPix.DataPagamento);
    LNovaDuplicata.FieldByName('CTR_VALDUP').AsFloat := LValorNovaDuplicata;
    LNovaDuplicata.FieldByName('CTR_VALORI').AsFloat := ADuplicata.FieldByName('CTR_VALORI').AsFloat;
    LNovaDuplicata.FieldByName('CTR_DESCON').AsString := ADuplicata.FieldByName('CTR_DESCON').AsString;
    LNovaDuplicata.FieldByName('CTR_VALCOM').AsFloat := ADuplicata.FieldByName('CTR_VALCOM').AsFloat;

    LNovaDuplicata.FieldByName('CTR_EMP_PD').Value := ADuplicata.FieldByName('CTR_EMP_PD').Value;

    LNovaDuplicata.FieldByName('CTR_HIST01').AsString := ADuplicata.FieldByName('CTR_HIST01').AsString +
                                                     ' - PAGTO.PARCIAL - DTA. REC.: ' +
                                                     FormatDateTime('dd/mm/yyyy', ADadosPix.DataPagamento) +
                                                     ' - VR. ORIGINAL: ' +
                                                     FormatFloat('#,##0.00', ADuplicata.FieldByName('CTR_PIXCOR').AsFloat) +
                                                     ' - VR. PAGO: ' +
                                                     FormatFloat('#,##0.00', ADuplicata.FieldByName('CTR_PIXREC').AsFloat);

    LNovaDuplicata.FieldByName('CTR_HIST02').AsString := ADuplicata.FieldByName('CTR_HIST02').AsString;
    LNovaDuplicata.FieldByName('CTR_PORBAI').AsString := '';
    LNovaDuplicata.FieldByName('CTR_PORBAI').Clear;
    LNovaDuplicata.FieldByName('CTR_HISBAI').AsString := '';
    LNovaDuplicata.FieldByName('CTR_DOCBAI').AsString := '';

    LNovaDuplicata.FieldByName('CTR_VALJUR').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALDES').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_RESCAI').AsInteger  := 0;

    LNovaDuplicata.FieldByName('CTR_DIFORI').AsFloat := ADuplicata.FieldByName('CTR_DIFORI').AsFloat +
                                                        RetornaDifOri(ADuplicata,
                                                                      ADadosPix.DataPagamento);

    LNovaDuplicata.FieldByName('CTR_NOSNUM').Value := Null;
    If Not ADuplicata.FieldByName('CTR_NOSNUM').AsString.IsEmpty Then
      LNovaDuplicata.FieldByName('CTR_NOSNUM').AsString := ADuplicata.FieldByName('CTR_NOSNUM').AsString;

    LNovaDuplicata.FieldByName('CTR_DTASER').Value := ADuplicata.FieldByName('CTR_DTASER').Value;
    LNovaDuplicata.FieldByName('CTR_DTABOL').Value := ADuplicata.FieldByName('CTR_DTABOL').Value;
    LNovaDuplicata.FieldByName('CTR_BCOBOL').Value := ADuplicata.FieldByName('CTR_BCOBOL').Value;
    LNovaDuplicata.FieldByName('CTR_BCOENV').Value := ADuplicata.FieldByName('CTR_BCOENV').Value;
    LNovaDuplicata.FieldByName('CTR_DTAENV').Value := ADuplicata.FieldByName('CTR_DTAENV').Value;

    LNovaDuplicata.FieldByName('CTR_CODEMP').AsString := ADuplicata.FieldByName('CTR_CODEMP').AsString;

    LNovaDuplicata.FieldByName('CTR_RECAUT').AsString := 'N';

    LNovaDuplicata.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADREC', ADuplicata.FieldByName('CTR_CODEMP').AsString);

    LNovaDuplicata.FieldByName('CTR_ADTCLI').AsString := ADuplicata.FieldByName('CTR_ADTCLI').AsString;

    LNovaDuplicata.FieldByName('CTR_CODEVE').Value := ADuplicata.FieldByName('CTR_CODEVE').Value;
    LNovaDuplicata.FieldByName('CTR_CODCND').Value := ADuplicata.FieldByName('CTR_CODCND').Value;

    LNovaDuplicata.FieldByName('CTR_FATCOM').AsFloat := Abs(IIF(ADuplicata.FieldByName('CTR_FATCOM').AsFloat < 0, ADuplicata.FieldByName('CTR_FATCOM').AsFloat * -1, ADuplicata.FieldByName('CTR_FATCOM').AsFloat));
    LNovaDuplicata.FieldByName('CTR_FATREP').AsFloat := Abs(IIF(ADuplicata.FieldByName('CTR_FATREP').AsFloat < 0, ADuplicata.FieldByName('CTR_FATREP').AsFloat * -1, ADuplicata.FieldByName('CTR_FATREP').AsFloat));

    LNovaDuplicata.FieldByName('CTR_BARCON').Value := ADuplicata.FieldByName('CTR_BARCON').Value;
    LNovaDuplicata.FieldByName('CTR_DOCDIV').Value := ADuplicata.FieldByName('CTR_DOCDIV').Value;
    LNovaDuplicata.FieldByName('CTR_ESPDIV').Value := ADuplicata.FieldByName('CTR_ESPDIV').Value;
    LNovaDuplicata.FieldByName('CTR_EMPDIV').Value := ADuplicata.FieldByName('CTR_EMPDIV').Value;
    LNovaDuplicata.FieldByName('CTR_CLIDIV').Value := ADuplicata.FieldByName('CTR_CLIDIV').Value;

    LNovaDuplicata.FieldByName('CTR_COMDIV').AsFloat := ADuplicata.FieldByName('CTR_COMDIV').AsFloat;
    LNovaDuplicata.FieldByName('CTR_FATDIV').AsFloat := ADuplicata.FieldByName('CTR_FATDIV').AsFloat;

    LNovaDuplicata.FieldByName('CTR_CODDIV').Value := ADuplicata.FieldByName('CTR_CODDIV').Value;

    LNovaDuplicata.FieldByName('CTR_VALIPI').AsFloat := ADuplicata.FieldByName('CTR_VALIPI').AsFloat - LBaixar.ParamByName('VALIPI').AsFloat;
    LNovaDuplicata.FieldByName('CTR_VALRET').AsFloat := ADuplicata.FieldByName('CTR_VALRET').AsFloat - LBaixar.ParamByName('VALRET').AsFloat;
    LNovaDuplicata.FieldByName('CTR_VALACE').AsFloat := ADuplicata.FieldByName('CTR_VALACE').AsFloat - LBaixar.ParamByName('VALACE').AsFloat;
    LNovaDuplicata.FieldByName('CTR_VALFRE').AsFloat := ADuplicata.FieldByName('CTR_VALFRE').AsFloat - LBaixar.ParamByName('VALFRE').AsFloat;
    LNovaDuplicata.FieldByName('CTR_VALFCP').AsFloat := ADuplicata.FieldByName('CTR_VALFCP').AsFloat - LBaixar.ParamByName('VALFCP').AsFloat;

    If LReformaTributaria Then
    Begin
      LNovaDuplicata.FieldByName('CTR_VALCBS').AsFloat := ADuplicata.FieldByName('CTR_VALCBS').AsFloat - LBaixar.ParamByName('VALCBS').AsFloat;
      LNovaDuplicata.FieldByName('CTR_VALIBS').AsFloat := ADuplicata.FieldByName('CTR_VALIBS').AsFloat - LBaixar.ParamByName('VALIBS').AsFloat;
      LNovaDuplicata.FieldByName('CTR_VAL_IS').AsFloat := ADuplicata.FieldByName('CTR_VAL_IS').AsFloat - LBaixar.ParamByName('VAL_IS').AsFloat;
    End;

    LNovaDuplicata.FieldByName('CTR_VALANT').AsFloat := ADuplicata.FieldByName('CTR_VALDUP').AsFloat;

    LNovaDuplicata.FieldByName('CTR_GRVORI').AsFloat := RetornaGRVORI(ADuplicata.FieldByName('CTR_NUMDUP').AsString,
                                                                      ADuplicata.FieldByName('CTR_ESPDOC').AsString,
                                                                      ADuplicata.FieldByName('CTR_CODEMP').AsString,
                                                                      ADuplicata.FieldByName('CTR_PARCEL').AsString,
                                                                      ADuplicata.FieldByName('CTR_CODCLI').AsString);

    If fFormataFloat(LNovaDuplicata.FieldByName('CTR_GRVORI').AsFloat, 2) = 0.00 Then
      LNovaDuplicata.FieldByName('CTR_GRVORI').AsFloat := ADuplicata.FieldByName('CTR_GRVORI').AsFloat;

    LNovaDuplicata.FieldByName('CTR_JURSUJ').AsFloat := LJurosNovaDuplicata;
    LNovaDuplicata.FieldByName('CTR_DESSUJ').AsFloat := LDescontoNovaDuplicata;

    If fCfgSis('MANVEN', varString) = 'S' Then
    begin
      LNovaDuplicata.FieldByName('CTR_JURSUJ').AsFloat := 0.00;
      LNovaDuplicata.FieldByName('CTR_DESSUJ').AsFloat := 0.00;
    end;

    LNovaDuplicata.FieldByName('CTR_JURANT').AsFloat := ADuplicata.FieldByName('CTR_JURSUJ').AsFloat;
    LNovaDuplicata.FieldByName('CTR_PERMOR').AsFloat := ADuplicata.FieldByName('CTR_PERMOR').AsFloat;
    LNovaDuplicata.FieldByName('CTR_PERMUL').AsFloat := ADuplicata.FieldByName('CTR_PERMUL').AsFloat;
    LNovaDuplicata.FieldByName('CTR_DESANT').AsFloat := ADuplicata.FieldByName('CTR_DESSUJ').AsFloat;
    LNovaDuplicata.FieldByName('CTR_DESCOB').AsFloat := LDespesasNovaDuplicata;
    LNovaDuplicata.FieldByName('CTR_COBANT').AsFloat := ADuplicata.FieldByName('CTR_DESCOB').AsFloat;
    LNovaDuplicata.FieldByName('CTR_CARTEI').AsString := ADuplicata.FieldByName('CTR_CARTEI').AsString;
    LNovaDuplicata.FieldByName('CTR_CODCTA').Value := ADuplicata.FieldByName('CTR_CODCTA').Value;

    LNovaDuplicata.FieldByName('CTR_EMPORI').AsString := ADuplicata.FieldByName('CTR_CODEMP').AsString;

    LNovaDuplicata.FieldByName('CTR_DTAEMA').Value := ADuplicata.FieldByName('CTR_DTAEMA').Value;

    If LNovaDuplicata.FindField('CTR_DTASMS') <> Nil Then
      LNovaDuplicata.FieldByName('CTR_DTASMS').Value := ADuplicata.FieldByName('CTR_DTASMS').Value;

    If LNovaDuplicata.FindField('CTR_SEQMPX') <> Nil Then
      LNovaDuplicata.FieldByName('CTR_SEQMPX').Value := ADuplicata.FieldByName('CTR_SEQMPX').Value;

    LNovaDuplicata.Post;

    AtualizarAutoIncremBOLCTR(ADuplicata.FieldByName('AUTOINCREM').AsString,
                              LNovaDuplicata.FieldByName('AUTOINCREM').AsString);

    untLogCtr.GravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                          'BAIXA PARCIAL',
                          'untTContasAReceberPix.BaixaParcialReceber');

    untLogCtr.GravaLogCtr(LNovaDuplicata.FieldByName('AUTOINCREM').AsString,
                          'ALTERAÇÃO DE BAIXA',
                          'untTContasAReceberPix.BaixaParcialReceber');

    FreeAndNil(LNovaDuplicata);

    Result := True;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(LNovaDuplicata);
      Raise Exception.Create(E.Message);
    End;
  End;
end;

class function TContasAReceberPix.BaixaTotalReceber(
  ADuplicata: TDataset; ADadosPix: TDadosRetornoPixConsulta): Boolean;
  Var
    LAtualizar: TUniQuery;

    LHisBai,
    LSQL: String;
begin
  Try
    LAtualizar := fCriaQuery;
    LHisBai := 'BAIXA DE DUPLICATA RECEBIDA POR PIX - '+
               ADuplicata.FieldByName('CTR_NUMDUP').AsString + ' ' +
               ADuplicata.FieldByName('CTR_ESPDOC').AsString + ' - ' +
               ADuplicata.FieldByName('CTR_CODCLI').AsString;

    LSQL := '';
    LSQL := LSQL + 'UPDATE ';
    LSQL := LSQL + '  CADREC ';
    LSQL := LSQL + 'SET ';
    LSQL := LSQL + '  CTR_VALANT = CTR_VALORI, ';
    LSQL := LSQL + '  CTR_VALORI = :VALORI, ';
    LSQL := LSQL + '  CTR_VALDUP = 0, ';
    LSQL := LSQL + '  CTR_JURANT = CTR_JURSUJ, ';
    LSQL := LSQL + '  CTR_DESANT = CTR_DESSUJ, ';
    LSQL := LSQL + '  CTR_COBANT = CTR_DESCOB, ';
    LSQL := LSQL + '  CTR_JURSUJ = 0, ';
    LSQL := LSQL + '  CTR_DESSUJ = 0, ';
    LSQL := LSQL + '  CTR_DESCOB = 0, ';
    LSQL := LSQL + '  CTR_DTAREC = :DTAREC, ';
    LSQL := LSQL + '  CTR_VALREC = :VALREC, ';
    LSQL := LSQL + '  CTR_VALDES = :VALDES, ';
    LSQL := LSQL + '  CTR_VALJUR = :VALJUR, ';
    LSQL := LSQL + '  CTR_VALCOB = :VALCOB, ';
    LSQL := LSQL + '  CTR_PORBAI = :PORBAI, ';
    LSQL := LSQL + '  CTR_HISBAI = :HISBAI, ';
    LSQL := LSQL + '  CTR_DOCBAI = :DOCBAI, ';
    LSQL := LSQL + '  CTR_CTABAI = :CTABAI, ';
    LSQL := LSQL + '  CTR_OPEBAI = :OPEBAI, ';
    LSQL := LSQL + '  CTR_DTABAI = ' + untFuncoesSimples.fCurrentDate + ', ';
    LSQL := LSQL + '  CTR_EMPBAI = :EMPBAI, ';
    LSQL := LSQL + '  CTR_CHQPRE = 0.00,    ';
    LSQL := LSQL + '  CTR_CHQAVI = 0.00,    ';
    LSQL := LSQL + '  CTR_DINHEI = 0.00,    ';
    LSQL := LSQL + '  CTR_CARTAO = 0.00,    ';
    LSQL := LSQL + '  CTR_ORDPAG = :ORDPAG, ';
    LSQL := LSQL + '  CTR_VALFIN = 0.00,    ';
    LSQL := LSQL + '  CTR_RESCAI = 0,       ';
    LSQL := LSQL + '  CTR_RECDIN = "N",     ';
    LSQL := LSQL + '  CTR_RECCHE = "N",     ';
    LSQL := LSQL + '  CTR_RECPRE = "N",     ';
    LSQL := LSQL + '  CTR_RECCAR = "N",     ';
    LSQL := LSQL + '  CTR_RECORD = "S",     ';
    LSQL := LSQL + '  CTR_RECFIN = "N",     ';
    LSQL := LSQL + '  CTR_BAIMAN = "N",     ';

    If fCfgSis('HISBAI', varBoolean) Then
    Begin
      LSQL := LSQL + '  CTR_HIST01 = CONCAT(IFNULL(CTR_HIST01, ""), ';
      LSQL := LSQL + '                      IF(IFNULL(CTR_HIST01, "") = "", "", "\n"), ';
      LSQL := LSQL + '                      :HISBAI), ';
    End;

    LSQL := LSQL + '  CTR_SEQMOD = NULL,    ';
    LSQL := LSQL + '  CTR_SEQCON = :SEQCON, ';
    LSQL := LSQL + '  CTR_RECAUT = "N",     ';

    LSQL := LSQL + '  CTR_DTABAN = :DTAREC, ';
    LSQL := LSQL + '  CTR_RECPIX = "S",     ';

    //Limpando campos do Pix
    LSQL := LSQL + '  CTR_PIXTIP=NULL,      ';
    LSQL := LSQL + '  CTR_PIXREC=NULL,      ';
    LSQL := LSQL + '  CTR_PIXJUR=NULL,      ';
    LSQL := LSQL + '  CTR_PIXDES=NULL,      ';
    LSQL := LSQL + '  CTR_PIXCOB=NULL,      ';
    LSQL := LSQL + '  CTR_PIXCOR=NULL       ';

    LSQL := LSQL + 'WHERE ';
    LSQL := LSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    LSQL := LSQL + '  CTR_PARCEL = :PARCEL AND ';
    LSQL := LSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    LSQL := LSQL + '  CTR_CODEMP = :CODEMP AND ';
    LSQL := LSQL + '  CTR_CODCLI = :CODCLI AND ';
    LSQL := LSQL + '  CTR_SEQBAI = 0 ';

    LAtualizar.SQL.Text := LSQL;
    
    LAtualizar.ParamByName('VALREC').AsFloat := ADuplicata.FieldByName('CTR_PIXREC').AsFloat;
    LAtualizar.ParamByName('VALORI').AsFloat := ADuplicata.FieldByName('CTR_PIXREC').AsFloat -
                                                ADuplicata.FieldByName('CTR_PIXJUR').AsFloat -
                                                ADuplicata.FieldByName('CTR_PIXCOB').AsFloat +
                                                ADuplicata.FieldByName('CTR_PIXDES').AsFloat;

    LAtualizar.ParamByName('DTAREC').AsDateTime := ADadosPix.DataPagamento;
    LAtualizar.ParamByName('VALDES').AsFloat := ADuplicata.FieldByName('CTR_PIXDES').AsFloat;
    LAtualizar.ParamByName('VALJUR').AsFloat := ADuplicata.FieldByName('CTR_PIXJUR').AsFloat;
    LAtualizar.ParamByName('VALCOB').AsFloat := ADuplicata.FieldByName('CTR_PIXCOB').AsFloat;
    LAtualizar.ParamByName('PORBAI').AsString := ADadosPix.CodigoPortador;
    LAtualizar.ParamByName('HISBAI').AsString := LHisBai;

    LAtualizar.ParamByName('DOCBAI').AsString := ADadosPix.MovbanBaixa;
    If LAtualizar.ParamByName('DOCBAI').AsString.IsEmpty Then
      LAtualizar.ParamByName('DOCBAI').AsString := ADuplicata.FieldByName('SEQLAN').AsString;

    LAtualizar.ParamByName('CTABAI').AsString := ADadosPix.PlanoDeContas;
    LAtualizar.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
    LAtualizar.ParamByName('EMPBAI').AsString := ADadosPix.CodigoEmpresa;
    LAtualizar.ParamByName('ORDPAG').AsFloat := ADuplicata.FieldByName('CTR_PIXREC').AsFloat;

    LAtualizar.ParamByName('SEQCON').AsInteger := ADadosPix.SeqConRecebimento;

    {*****************************************}
    {* DADOS REFERENTES AO FILTRO            *}
    {**************************************MV*}
    LAtualizar.ParamByName('NUMDUP').AsString := ADuplicata.FieldByName('CTR_NUMDUP').AsString;
    LAtualizar.ParamByName('PARCEL').AsString := ADuplicata.FieldByName('CTR_PARCEL').AsString;
    LAtualizar.ParamByName('ESPDOC').AsString := ADuplicata.FieldByName('CTR_ESPDOC').AsString;
    LAtualizar.ParamByName('CODEMP').AsString := ADuplicata.FieldByName('CTR_CODEMP').AsString;
    LAtualizar.ParamByName('CODCLI').AsString := ADuplicata.FieldByName('CTR_CODCLI').AsString;
    LAtualizar.ExecSQL;

    AtualizaBOLCTRBoletosBaixaTotal(ADuplicata.FieldByName('AUTOINCREM').AsString);

    {*************************************}
    {* REALIZA A LIBERAÇÃO AUTOMÁTICA DO *}
    {* DOCUMENTO RECEBIDO PARA EXPEDIR   *}
    {**********************************PZ*}
    pLiberaDoctoParaExpedicaoAutomatico(ADuplicata.FieldByName('CTR_NUMDUP').AsString,
                                        ADuplicata.FieldByName('CTR_ESPDOC').AsString,
                                        ADuplicata.FieldByName('CTR_CODEMP').AsString,
                                        ADuplicata.FieldByName('CTR_CODCLI').AsString,
                                        ADuplicata.FieldByName('CTR_PARCEL').AsString);

    untLogCtr.GravaLogCtr(ADuplicata.FieldByName('AUTOINCREM').AsString,
                          'BAIXA TOTAL',
                          'untTContasAReceberPix.BaixaTotalReceber');

    Result := True;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(LAtualizar);
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(LAtualizar);
end;

class function TContasAReceberPix.RealizaGravacaoMovimentacaoBancaria(
  var ADuplicatas: TUniClientDataset; var ADadosPix: TDadosRetornoPixConsulta): Boolean;
  Var
    LSeqLan,
    LTipoLancamento: String;

    LSeqBai: Integer;

    LListaBanCtr: TBanCtrRepository;

    LDataLancamento: TDateTime;
    LHisBai: String;
begin
  Try
    LListaBanCtr := TBanCtrRepository.Create;

    LDataLancamento := ADadosPix.DataPagamento;
    If FProximoDiaUtil Then
      LDataLancamento := fAcertaDataParaDiaUtil(ADadosPix.DataPagamento);

    {*******************}
    {* BAIXA SINTÉTICA *}
    {*******************}
    If Not FBaixaAnalitica Then
    Begin
      ADuplicatas.First;
      While Not ADuplicatas.Eof Do
      Begin
        LListaBanCtr.fAdd(ADuplicatas.FieldByName('CTR_NUMDUP').AsString,
                          ADuplicatas.FieldByName('CTR_PARCEL').AsString,
                          ADuplicatas.FieldByName('CTR_ESPDOC').AsString,
                          ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                          ADuplicatas.FieldByName('CTR_CODCLI').AsString,
                          ADuplicatas.FieldByName('CTR_HIST01').AsString,
                          ADuplicatas.FieldByName('CTR_HIST02').AsString,
                          ADuplicatas.FieldByName('CTR_SEQBAI').AsInteger,
                          ADuplicatas.FieldByName('CTR_PIXREC').AsFloat,
                          ADuplicatas.FieldByName('CTR_PIXJUR').AsFloat,
                          ADuplicatas.FieldByName('CTR_PIXDES').AsFloat,
                          ADuplicatas.FieldByName('CTR_VALDUP').AsFloat);

        ADuplicatas.Next;
      End;

      LSeqLan := fGravaMovBan(ADadosPix.PlanoDeContas,
                              ADadosPix.CodigoPortador,
                              strLoginUsuarioLogado,
                              LDataLancamento,
                              fRetHoraServidor,
                              '',
                              'C',
                              ADadosPix.CodigoEmpresa,
                              ADadosPix.ValorPago,
                              'BAIXA DE DUPLICATA RECEBIDA POR PIX',
                              '',
                              '',
                              '',
                              '',
                              0,
                              '',
                              '',
                              '',
                              '',
                              '',
                              LListaBanCtr.fGetList
                              );

      ADadosPix.MovbanBaixa := LSeqLan;

      ADuplicatas.First;
      Exit(True);
    End;

    {*******************}
    {* BAIXA ANALITICA *}
    {*******************}
    ADadosPix.MovbanBaixa := '';

    LSeqBai := 0;
    If ADuplicatas.FieldByName('CTR_PIXTIP').AsString = 'P' Then
      LSeqBai := RetornaUltimoSeqBaiCADREC(ADuplicatas.FieldByName('CTR_NUMDUP').AsString,
                                           ADuplicatas.FieldByName('CTR_PARCEL').AsString,
                                           ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                                           ADuplicatas.FieldByName('CTR_ESPDOC').AsString,
                                           ADuplicatas.FieldByName('CTR_CODCLI').AsString) + 1;

    LListaBanCtr.fAdd(ADuplicatas.FieldByName('CTR_NUMDUP').AsString,
                      ADuplicatas.FieldByName('CTR_PARCEL').AsString,
                      ADuplicatas.FieldByName('CTR_ESPDOC').AsString,
                      ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                      ADuplicatas.FieldByName('CTR_CODCLI').AsString,
                      ADuplicatas.FieldByName('CTR_HIST01').AsString,
                      ADuplicatas.FieldByName('CTR_HIST02').AsString,
                      ADuplicatas.FieldByName('CTR_SEQBAI').AsInteger,
                      ADuplicatas.FieldByName('CTR_PIXREC').AsFloat,
                      ADuplicatas.FieldByName('CTR_PIXJUR').AsFloat,
                      ADuplicatas.FieldByName('CTR_PIXDES').AsFloat,
                      ADuplicatas.FieldByName('CTR_VALDUP').AsFloat);

    LTipoLancamento := 'C';
    If ADuplicatas.FieldByName('CTR_PIXREC').AsFloat < 0 Then
      LTipoLancamento := 'D';

    LHisBai := 'BAIXA DE DUPLICATA RECEBIDA POR PIX - ' +
               ADuplicatas.FieldByName('CTR_NUMDUP').AsString + ' ' +
               ADuplicatas.FieldByName('CTR_ESPDOC').AsString + ' - ' +
               ADuplicatas.FieldByName('CTR_CODCLI').AsString;

    LSeqLan := fGravaMovBan(ADadosPix.PlanoDeContas,
                            ADadosPix.CodigoPortador,
                            strLoginUsuarioLogado,
                            LDataLancamento,
                            fRetHoraServidor,
                            ADuplicatas.FieldByName('CTR_NUMDUP').AsString + ADuplicatas.FieldByName('CTR_PARCEL').AsString,
                            LTipoLancamento,
                            ADadosPix.CodigoEmpresa,
                            ADuplicatas.FieldByName('CTR_PIXREC').AsFloat,
                            LHisBai,
                            '',
                            ADuplicatas.FieldByName('CTR_CODCLI').AsString,
                            '',
                            ADuplicatas.FieldByName('CTR_NUMDUP').AsString,
                            LSeqBai,
                            ADuplicatas.FieldByName('CTR_PARCEL').AsString,
                            ADuplicatas.FieldByName('CTR_CODEMP').AsString,
                            '',
                            ADuplicatas.FieldByName('CTR_CODEVE').AsString,
                            '',
                            LListaBanCtr.fGetList
                            );

    ADuplicatas.Edit;
    ADuplicatas.FieldByName('SEQLAN').AsString := LSeqLan;
    ADuplicatas.Post;

    Result := Not LSeqLan.IsEmpty;

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a movimentação bancária do Pix.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class function TContasAReceberPix.RealizaGravacaoMovimentacaoBancariaCC(
  ADatasetCadRec: TUniQuery; var ADadosPix: TDadosRetornoPixConsulta): Boolean;
  Var
    LSeqLan,
    LTipoLancamento: String;

    LListaBanCtr: TBanCtrRepository;

    LDataLancamento: TDateTime;
begin
  Try
    LListaBanCtr := TBanCtrRepository.Create;

    LDataLancamento := ADadosPix.DataPagamento;
    If FProximoDiaUtil Then
      LDataLancamento := fAcertaDataParaDiaUtil(ADadosPix.DataPagamento);

    LListaBanCtr.fAdd(ADatasetCadRec.FieldByName('CTR_NUMDUP').AsString,
                      ADatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                      ADatasetCadRec.FieldByName('CTR_ESPDOC').AsString,
                      ADatasetCadRec.FieldByName('CTR_CODEMP').AsString,
                      ADatasetCadRec.FieldByName('CTR_CODCLI').AsString,
                      ADatasetCadRec.FieldByName('CTR_HIST01').AsString,
                      ADatasetCadRec.FieldByName('CTR_HIST02').AsString,
                      ADatasetCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                      0.00,
                      0.00,
                      0.00,
                      ADatasetCadRec.FieldByName('CTR_VALDUP').AsFloat);

    LTipoLancamento := 'C';

    LSeqLan := fGravaMovBan(ADadosPix.PlanoDeContas,
                            ADadosPix.CodigoPortador,
                            strLoginUsuarioLogado,
                            LDataLancamento,
                            fRetHoraServidor,
                            ADatasetCadRec.FieldByName('CTR_NUMDUP').AsString + ADatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                            LTipoLancamento,
                            ADadosPix.CodigoEmpresa,
                            ADadosPix.ValorPago,
                            'CREDITO DE CLIENTE RECEBIDO POR PIX',
                            '',
                            ADatasetCadRec.FieldByName('CTR_CODCLI').AsString,
                            '',
                            ADatasetCadRec.FieldByName('CTR_NUMDUP').AsString,
                            0,
                            ADatasetCadRec.FieldByName('CTR_PARCEL').AsString,
                            ADatasetCadRec.FieldByName('CTR_CODEMP').AsString,
                            '',
                            ADatasetCadRec.FieldByName('CTR_CODEVE').AsString,
                            '',
                            LListaBanCtr.fGetList
                            );

    Result := Not LSeqLan.IsEmpty;

    ADadosPix.MovbanBaixa := LSeqLan;

  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a movimentação bancária do Pix.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

class procedure TContasAReceberPix.RealizarBaixaDoContasAReceber(ATxIdPix,
  ACodigoEmpresa: String; var ADadosPix: TDadosRetornoPixConsulta);
  Var
    LConsulta: TUniQuery;

    LDuplicatas: TUniClientDataset;
begin
  FProximoDiaUtil := fCampoTabela('POR_BAIUTL', 'CADPOR', ['POR_CODPOR'], [ADadosPix.CodigoPortador]) = 'S';
  FAtualizaBolCtr := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_BOLCTR', ADadosPix.CodigoEmpresa]) <> 'N';

  Try
    Try
      LConsulta := fCriaQuery;

      LConsulta.SQL.Text := 'SELECT *, CAST("" AS CHAR(70)) AS SEQLAN FROM CADREC ' +
                            'WHERE CTR_EMPPIX=:EMPPIX ' +
                            '  AND CTR_TX_PIX=:TX_PIX ' +
                            '  AND CTR_DTAREC IS NULL ';

      LConsulta.ParamByName('EMPPIX').AsString := ACodigoEmpresa;
      LConsulta.ParamByName('TX_PIX').AsString := ATxIdPix;

      LConsulta.Open;

      If LConsulta.IsEmpty Then
        Raise Exception.Create('Duplicatas não foram encontradas para realizar a baixa!');

      LDuplicatas := fCriaClientDatSet(LConsulta);

      FBaixaAnalitica := fCfgSis('CTR_AS', varString, LDuplicatas.FieldByName('CTR_EMPPIX').AsString) = 'A';

      If Not FBaixaAnalitica Then
        RealizaGravacaoMovimentacaoBancaria(LDuplicatas,
                                            ADadosPix);

      ADadosPix.NumeroDasDuplicatas := EmptyStr;
      ADadosPix.TxBolCadRec := EmptyStr;

      LDuplicatas.First;
      While Not LDuplicatas.Eof Do
      Begin
        If FBaixaAnalitica Then
          RealizaGravacaoMovimentacaoBancaria(LDuplicatas,
                                              ADadosPix);

        If LDuplicatas.FieldByName('CTR_PIXTIP').AsString = 'T' Then
          BaixaTotalReceber(LDuplicatas,
                            ADadosPix)
        Else
          BaixaParcialReceber(LDuplicatas,
                              ADadosPix);

        ADadosPix.NumeroDasDuplicatas := ADadosPix.NumeroDasDuplicatas +
                                         LDuplicatas.FieldByName('CTR_NUMDUP').AsString +
                                         LDuplicatas.FieldByName('CTR_PARCEL').AsString + '-' +
                                         LDuplicatas.FieldByName('CTR_ESPDOC').AsString + '-' +
                                         LDuplicatas.FieldByName('CTR_CODEMP').AsString + ', ';

        If LDuplicatas.FindField('CTR_TX_BOL') <> Nil Then
          ADadosPix.TxBolCadRec := ADadosPix.TxBolCadRec +
                                   LDuplicatas.FieldByName('CTR_TX_BOL').AsString;

        LDuplicatas.Next;
      End;

      ADadosPix.NumeroDasDuplicatas := LeftStr(ADadosPix.NumeroDasDuplicatas,
                                               ADadosPix.NumeroDasDuplicatas.Length - 2);

      ADadosPix.CodigoDoCliente :=  LDuplicatas.FieldByName('CTR_CODCLI').AsString;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(LConsulta);

    If Assigned(LDuplicatas) Then
      FreeAndNIl(LDuplicatas);
  End;
end;

class function TContasAReceberPix.RetornaDifOri(ADataset: TDataset;
                                                ADataRecebimento: TDateTime): Double;
begin
  Result := 0;

  If ADataset.FieldByName('CTR_PIXCOR').AsFloat < 0 Then
    Exit;

  Result := ADataset.FieldByName('CTR_PIXCOR').AsFloat;

  If fCfgSis('UTDEFN') = '2' Then
  Begin
    If (ADataRecebimento <= ADataset.FieldByName('CTR_DTAVEN').AsDateTime +
                            ADataset.FieldByName('CTR_QTDDAV').AsInteger) Then
      Result := Result - (ADataset.FieldByName('CTR_VALDUP').AsFloat +
                          ADataset.FieldByName('CTR_JURSUJ').AsFloat +
                          ADataset.FieldByName('CTR_DESCOB').AsFloat -
                          ADataset.FieldByName('CTR_DESSUJ').AsFloat)
    Else
      Result := Result - (ADataset.FieldByName('CTR_VALDUP').AsFloat +
                          ADataset.FieldByName('CTR_JURSUJ').AsFloat +
                          ADataset.FieldByName('CTR_DESCOB').AsFloat );
  End
  Else
    Result := Result - (ADataset.FieldByName('CTR_VALDUP').AsFloat +
                        ADataset.FieldByName('CTR_JURSUJ').AsFloat +
                        ADataset.FieldByName('CTR_DESCOB').AsFloat -
                        ADataset.FieldByName('CTR_DESSUJ').AsFloat);
end;

class function TContasAReceberPix.RetornaUltimoSeqBaiCADREC(ANumDup,
                                                            AParcel,
                                                            ACodEmp,
                                                            AEspDoc,
                                                            ACodCli: String): Integer;
  Var
    LConsulta: TUniQuery;
begin
  Try

    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT ' +
                          '  MAX(CTR_SEQBAI) AS QTD ' +
                          'FROM ' +
                          '  CADREC ' +
                          'WHERE ' +
                          '  CTR_NUMDUP = :NUMDUP AND ' +
                          '  CTR_PARCEL = :PARCEL AND ' +
                          '  CTR_CODEMP = :CODEMP AND ' +
                          '  CTR_ESPDOC = :ESPDOC AND ' +
                          '  CTR_CODCLI = :CODCLI ';

    LConsulta.ParamByName('NUMDUP').AsString := ANumDup;
    LConsulta.ParamByName('PARCEL').AsString := AParcel;
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
    LConsulta.ParamByName('ESPDOC').AsString := AEspDoc;
    LConsulta.ParamByName('CODCLI').AsString := ACodCli;
    LConsulta.Open;

    Result := LConsulta.FieldByName('QTD').AsInteger;
    LConsulta.Close;
  Finally
    FreeAndNil(LConsulta);
  End;

end;

class function TContasAReceberPix.RetornaDataVencimentoBaixaParcial(ADataset: TDataset;
                                                                    ADataRecebimento: TDateTime): TDateTime;
Begin
  Result := ADataRecebimento;

  If fCfgSis('MANVEN', varString) = 'S' Then
  Begin
    Result := ADataset.FieldByName('CTR_DTAVEN').AsDateTime;
  End;
End;

class function TContasAReceberPix.RetornaGRVORI(ANumDup,
                                                AEspDoc,
                                                ACodEmp,
                                                AParcel,
                                                ACodCli: String): Double;
  Var
    LConsulta: TUniQuery;
Begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text :=  ' SELECT ' +
                           '   IF(CTR_SEQBAI = 0, CTR_VALORI, CTR_GRVORI) AS VALORI ' +
                           ' FROM ' +
                           '   CADREC ' +
                           ' WHERE ' +
                           '   CTR_NUMDUP = :NUMDUP AND ' +
                           '   CTR_ESPDOC = :ESPDOC AND ' +
                           '   CTR_CODEMP = :CODEMP AND ' +
                           '   CTR_PARCEL = :PARCEL AND ' +
                           '   CTR_CODCLI = :CODCLI ' +
                           ' ORDER BY ' +
                           '   CTR_PARCEL, ' +
                           '   CTR_SEQBAI  ' +
                           ' LIMIT 1 ';

    LConsulta.ParamByName('NUMDUP').AsString := aNumDup;
    LConsulta.ParamByName('ESPDOC').AsString := AEspDoc;
    LConsulta.ParamByName('CODEMP').AsString := ACodEmp;
    LConsulta.ParamByName('PARCEL').AsString := AParcel;
    LConsulta.ParamByName('CODCLI').AsString := ACodCli;

    LConsulta.Open;

    Result := 0;
    If Not LConsulta.IsEmpty Then
      Result := LConsulta.FieldByName('VALORI').AsFloat;

  Finally
    FreeAndNil(LConsulta);
  End;
End;

class procedure TContasAReceberPix.AtualizaBOLCTRBoletosBaixaTotal(
  AAutoIncremCTR: String);
  Var
    LConsulta,
    LAtualiza: TUniQuery;

    LTabelaExiste: Boolean;
begin
  If Not FAtualizaBolCtr Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    Try
      LConsulta.SQL.Text := 'SHOW CREATE TABLE BOLCTR';
      LConsulta.Open;

      LTabelaExiste := Not LConsulta.IsEmpty;
    Except
      LTabelaExiste := False;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;

  If Not LTabelaExiste Then
    Exit;

  Try
    LAtualiza := fCriaQuery;

    LAtualiza.SQL.Text := 'UPDATE BOLCTR SET BOL_TIPBAI="T" ' +
                          ' WHERE BOL_SEQCTR=' + AAutoIncremCtr.QuotedString;

    LAtualiza.ExecSQL;

    FreeAndNil(LAtualiza);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar o registro.' + #13 +
                             'Erro gerado: ' + E.Message + ' - [AtualizaBOLCTRBoletosBaixaTotal]');
  End;
end;

class procedure TContasAReceberPix.AtualizarAutoIncremBOLCTR(AAutoIncremParcial,
                                                             AAutoIncremAberta: String);
  Var
    LConsulta,
    LAtualiza: TUniQuery;

    LTabelaExiste: Boolean;
Begin
  If Not FAtualizaBolCtr Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    Try
      LConsulta.SQL.Text := 'SHOW CREATE TABLE BOLCTR';
      LConsulta.Open;

      LTabelaExiste := Not LConsulta.IsEmpty;
    Except
      LTabelaExiste := False;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;

  If Not LTabelaExiste Then
    Exit;

  Try
    LAtualiza := fCriaQuery;

    LAtualiza.SQL.Text := 'UPDATE BOLCTR SET BOL_SEQCTR=' + AAutoIncremAberta.QuotedString + ', ' +
                          ' BOL_TIPBAI="P" WHERE BOL_SEQCTR=' + AAutoIncremParcial.QuotedString;

    LAtualiza.ExecSQL;

    FreeAndNil(LAtualiza);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar o registro.' + #13 +
                             'Erro gerado: ' + E.Message + ' - [AtualizarAutoIncremBOLCTR]');
  End;
End;

class function TContasAReceberPix.fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;
begin
  Result := dtaOrigem;
  While (fDiaDeFolga(Result, True, IIF(fCfgSis('FEMUCP', varBoolean), strCodCid, ''))) Do
  Begin
    Result := Result + 1;
  End;
end;

class function TContasAReceberPix.fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True;
                                              strCodCid: String = ''; blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                                              blnConsideraDomingo: Boolean = False): Boolean;
  Const
    SABADO = 7;
    DOMINGO = 1;
begin
  If blnConsideraSabadoAndDomingoComoDiaUtil Then
    Exit(fEhFeriado(dtaDta, strCodCid));

  Result := (DayOfWeek(dtaDta) = DOMINGO);
  If Not Result Then
    Result := fEhFeriado(dtaDta, strCodCid);

  If blnConsideraSabado Then
  Begin
    Result := (DayOfWeek(dtaDta) In [DOMINGO, SABADO]);
    If Not Result Then
      Result := fEhFeriado(dtaDta, strCodCid);
  End
  Else If (blnConsideraDomingo) Then
  Begin
    If DayOfWeek(dtaDta) = DOMINGO then
      Result := fEhFeriado(dtaDta, strCodCid);
  End;
end;

class function TContasAReceberPix.fEhFeriado(dtaDta: TDateTime; strCodCid: String = ''): Boolean;
  Var
    intCont: Integer;
    strDTa: String;
begin
  intCont := 0;
  strDta := FormatDateTime('yyyy-mm-dd', dtaDta);

  intCont := intCont + fCampoTabela('COUNT(*) AS QTD', 'CADFER', ['FER_DTAFER'], [strDta], False);

  If Not fEmptyStr(strCodCid) Then
  Begin
    intCont := intCont + fCampoTabela('COUNT(*) AS QTD', 'FERCID', ['FCI_DTAFER', 'FCI_CODCID'], [strDta, strCodCid], False);
  End;

  Result := intCont > 0;
end;

class procedure TContasAReceberPix.GerarCreditoDeClientePix(
  ADadosPix: TDadosRetornoPixConsulta);
  Var
    LNovaDuplicata: TUniQuery;

    LPortadorDuplicata,
    LCentroDeCustosDuplicata: String;
begin
  Try
    LNovaDuplicata := fCriaQuery;

    {*****************************************}
    {* GRAVA NOVA DUPLICATA                  *}
    {**************************************MV*}
    LNovaDuplicata.SQL.Text := 'SELECT * FROM CADREC WHERE FALSE';

    LNovaDuplicata.Open;
    LNovaDuplicata.Append;

    LNovaDuplicata.FieldByName('CTR_CODVEN').AsString := RightStr(ADadosPix.ChaveParaCreditoCliente, 3);
    LNovaDuplicata.FieldByName('CTR_CODDIG').AsString := RightStr(ADadosPix.ChaveParaCreditoCliente, 3);

    LNovaDuplicata.FieldByName('CTR_CODCLI').AsString := Copy(ADadosPix.ChaveParaCreditoCliente, 21, 08);
    LNovaDuplicata.FieldByName('CTR_NUMDUP').AsString := Copy(ADadosPix.ChaveParaCreditoCliente, 01, 12);
    LNovaDuplicata.FieldByName('CTR_CODEMP').AsString := Copy(ADadosPix.ChaveParaCreditoCliente, 17, 03);
    LNovaDuplicata.FieldByName('CTR_PARCEL').AsString := 'A';
    LNovaDuplicata.FieldByName('CTR_SEQBAI').AsInteger := 0;
    LNovaDuplicata.FieldByName('CTR_ESPDOC').AsString := 'CC';
    LNovaDuplicata.FieldByName('CTR_DTACAD').AsDateTime := ADadosPix.DataPagamento;
    LNovaDuplicata.FieldByName('CTR_DTAVEN').AsDateTime := ADadosPix.DataPagamento;
    LNovaDuplicata.FieldByName('CTR_VALDUP').AsFloat := ADadosPix.ValorPago * (-1);
    LNovaDuplicata.FieldByName('CTR_VALORI').AsFloat := ADadosPix.ValorPago * (-1);
    LNovaDuplicata.FieldByName('CTR_DESCON').AsString := 'N';
    LNovaDuplicata.FieldByName('CTR_VALCOM').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_FATCOM').AsFloat := 0.00000000;

    LPortadorDuplicata := fCampoTabela('SIS_VALCFG',
                                       'CFGSIS',
                                       ['SIS_CODCFG', 'SIS_CODEMP'],
                                       ['CFG_PORCCP', ADadosPix.CodigoEmpresa]);

    LCentroDeCustosDuplicata := fCampoTabela('SIS_VALCFG',
                                             'CFGSIS',
                                             ['SIS_CODCFG', 'SIS_CODEMP'],
                                             ['CFG_EVECCP', ADadosPix.CodigoEmpresa]);

    LNovaDuplicata.FieldByName('CTR_CODPOR').Value := Null;
    If Not LPortadorDuplicata.IsEmpty Then
      LNovaDuplicata.FieldByName('CTR_CODPOR').AsString := LPortadorDuplicata;

    LNovaDuplicata.FieldByName('CTR_CODEVE').Value := Null;
    If Not LCentroDeCustosDuplicata.IsEmpty Then
      LNovaDuplicata.FieldByName('CTR_CODEVE').AsString := LCentroDeCustosDuplicata;

    LNovaDuplicata.FieldByName('CTR_EMP_PD').AsString := fRetEmpresaOperador(LNovaDuplicata.FieldByName('CTR_CODVEN').AsString);
    If LNovaDuplicata.FieldByName('CTR_EMP_PD').AsString.IsEmpty Then
      LNovaDuplicata.FieldByName('CTR_EMP_PD').AsString := LNovaDuplicata.FieldByName('CTR_CODEMP').AsString;

    LNovaDuplicata.FieldByName('CTR_HIST01').AsString := 'REF. LANC. CREDITO POR PIX';
    LNovaDuplicata.FieldByName('CTR_HIST02').AsString := '';

    LNovaDuplicata.FieldByName('CTR_RESCAI').AsInteger  := 0;

    LNovaDuplicata.FieldByName('CTR_DIFORI').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALREC').AsFloat := 0.00;

    LNovaDuplicata.FieldByName('CTR_NOSNUM').Value := Null;

    LNovaDuplicata.FieldByName('CTR_DTASER').Value := Null;
    LNovaDuplicata.FieldByName('CTR_DTABOL').Value := Null;
    LNovaDuplicata.FieldByName('CTR_BCOBOL').Value := Null;
    LNovaDuplicata.FieldByName('CTR_BCOENV').Value := Null;
    LNovaDuplicata.FieldByName('CTR_DTAENV').Value := Null;

    LNovaDuplicata.FieldByName('CTR_RECAUT').AsString := 'N';

    LNovaDuplicata.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADREC', LNovaDuplicata.FieldByName('CTR_CODEMP').AsString);

    LNovaDuplicata.FieldByName('CTR_ADTCLI').AsString := 'N';
    LNovaDuplicata.FieldByName('CTR_RECFIN').AsString := 'N';

    LNovaDuplicata.FieldByName('CTR_VALIPI').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALRET').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALACE').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALFRE').AsFloat := 0.00;
    LNovaDuplicata.FieldByName('CTR_VALFCP').AsFloat := 0.00;

    If (LNovaDuplicata.FindField('CTR_VALCBS') <> Nil) And
       (LNovaDuplicata.FindField('CTR_VALIBS') <> Nil) And
       (LNovaDuplicata.FindField('CTR_VAL_IS') <> Nil) Then
    Begin
      LNovaDuplicata.FieldByName('CTR_VALCBS').AsFloat := 0.00;
      LNovaDuplicata.FieldByName('CTR_VALIBS').AsFloat := 0.00;
      LNovaDuplicata.FieldByName('CTR_VAL_IS').AsFloat := 0.00;
    End;

    LNovaDuplicata.FieldByName('CTR_VALANT').AsFloat := 0.00;

    LNovaDuplicata.FieldByName('CTR_GRVORI').AsFloat := ADadosPix.ValorPago * (-1);

    LNovaDuplicata.FieldByName('CTR_JURSUJ').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_JURANT').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_PERMOR').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_PERMUL').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_DESSUJ').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_DESANT').AsFloat := 0;
    LNovaDuplicata.FieldByName('CTR_DESCOB').AsFloat := 0;

    LNovaDuplicata.FieldByName('CTR_EMPORI').AsString := LNovaDuplicata.FieldByName('CTR_CODEMP').AsString;

    If LNovaDuplicata.FindField('CTR_SEQMPX') <> Nil Then
      LNovaDuplicata.FieldByName('CTR_SEQMPX').AsString := ADadosPix.AutoIncremMovPix;

    LNovaDuplicata.Post;

    untLogCtr.GravaLogCtr(LNovaDuplicata.FieldByName('AUTOINCREM').AsString,
                          'INCLUSÃO',
                          'untTContasAReceberPix.BaixaParcialReceber',
                          strLoginUsuarioLogado,
                          ADadosPix.SeqConRecebimento,
                          0,
                          '',
                          'S');

    RealizaGravacaoMovimentacaoBancariaCC(LNovaDuplicata,
                                          ADadosPix);

    FreeAndNil(LNovaDuplicata);
  Except
    On E: Exception Do
    Begin
      FreeAndNil(LNovaDuplicata);
      Raise Exception.Create(E.Message);
    End;
  End;
end;

end.
