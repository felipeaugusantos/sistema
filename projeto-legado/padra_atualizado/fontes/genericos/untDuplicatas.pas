unit untDuplicatas;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  SysUtils, untTypesSistema, untConstantes, Data.DB,
  strUtils, Math, Uni, DateUtils;

function fDigDuplicVar(strCndPag: String;
                       intNumDoc: Int64;
                       curTotal : Currency;
                       blnMosTela,
                       blnEditavel,
                       blnHabEditDup: Boolean;
                       dtaDtaBas    : TDateTime;
                       blnPergConf  : Boolean;
                       var arrDuplic: TArrDigDuplicArray;
                       fltImpost    : Double = 0;
                       strUsaChq    : String = 'N';
                       blnDupsRedondas: Boolean = True;
                       blnUsaHist   : Boolean = False;
                       fltValRec    : Double = 0.0;
                       objArredondamento: IArredondaParcela = Nil): Boolean; overload;

function fDigDuplicVar(strCndPag: String;
                       intNumDoc: Int64;
                       curTotal : Currency;
                       blnMosTela,
                       blnEditavel,
                       blnHabEditDup: Boolean;
                       dtaDtaBas    : TDateTime;
                       blnPergConf  : Boolean;
                       var arrDuplic: TArrDigDuplicArray;
                       var arrDuplicata: TarrDuplicata;
                       fltImpost    : Double = 0;
                       strUsaChq    : String = 'N';
                       blnDupsRedondas: Boolean = True;
                       blnUsaHist     : Boolean = False;
                       fltValRec      : Double = 0.0;
                       arrValores: TDoubleArray = Nil;
                       objArredondamento: IArredondaParcela = Nil): Boolean; overload;

function fDigDuplic(var arrDuplicata: TarrDuplicata;
                    strCndPag: String;
                    intNumDoc: Int64;
                    curTotal: Currency;
                    blnMosTela,
                    blnEditavel,
                    blnHabEditDup: Boolean;
                    dtaDtaBas: TDateTime;
                    blnPergConf: Boolean;
                    fltImpost: Double = 0;
                    strUsaChq: String = 'N';
                    blnDupsRedondas: Boolean = True;
                    blnUsaHist: Boolean = False;
                    fltValRec: Double = 0.0;
                    blnFaturamento: Boolean = False;
                    arrValores: TDoubleArray = Nil;
                    strEspDoc: String = '';
                    blnSabDomFeriadoDiasUteis: Boolean = True;
                    blnHabEditValor: Boolean = True;
                    pMostraContaCorrente: TPrcMostraContaCorrente = Nil;
                    strCodCli: String = '';
                    blnPerRep: Boolean = False;
                    blnValoresPadrao: Boolean = True;
                    strCodCnd: String = '';
                    strCodVen: String = '';
                    fSenVar: TGenericFunctionWithArrayParam = Nil;
                    blnFatPed: Boolean = False;
                    blnAgrupVeio: Boolean = False;
                    objArredondamento: IArredondaParcela = Nil;
                    blnManterValoesOriginais: Boolean = False;
                    blnMostrarOpcaoPadrao: Boolean = False;
                    fltDescPrimeraParcela: Double = 0;
                    AFormVeio: String = '';
                    strCodCid: String = '';
                    strOpcDoc: string = '';
                    blnTelaAgrupamento: Boolean = False;
                    const AblnUtilizarDataEmissaoCalcularDiaVencimento: boolean = False;
                    AblnImpConhecimentoFrete: Boolean = False;
                    blnAbreTelaComCreditoAutomatico: Boolean = True;
                    blnConservarValoresDasParcelas: Boolean = False): Boolean;

function fDigDuplicSemTela(var arrDuplicata: TarrDuplicata;
                           Var intQtdDup: Integer;
                           Var curTotalRes: Currency;
                               strCndPag:String;
                               intNumDoc:Int64;
                               curTotal:Currency;
                               blnEditavel,
                               blnHabEditDup:Boolean;
                               dtaDtaBas:TDateTime;
                               blnPergConf: Boolean;
                               fltImpost: Double = 0;
                               strUsaChq: String = 'N';
                               blnDupsRedondas: Boolean = True;
                               blnUsaHist: Boolean = False;
                               fltValRec : Double = 0.0;
                               arrValores: TDoubleArray = Nil;
                               blnSabDomFeriadoDiasUteis: Boolean = True;
                               blnFatPed: Boolean = False;
                               objArredondamento: IArredondaParcela = Nil;
                               fltDescPrimeraParcela: Double = 0;
                               strCodCid: string = '';
                               strOpcDoc: string = '';
                               strCodCnd: string = '';
                               const AblnUtilizarDataEmissaoCalcularDiaVencimento: boolean = False;
                               AblnImpConhecimentoFrete: Boolean = False;
                               blnConservarValoresDasParcelas: Boolean = False): Boolean;

function fDigDuplicSemTelaVar(    blnFinanc: Boolean;
                              Var arrDuplicata: TArrDigDuplicArray;
                              Var intQtdDup: Integer;
                              Var curTotalRes: Currency;
                                  strCndPag:String;
                                  intNumDoc:Int64;
                                  curTotal:Currency;
                                  blnEditavel,
                                  blnHabEditDup:Boolean;
                                  dtaDtaBas:TDateTime;
                                  blnPergConf: Boolean;
                                  fltImpost: Double = 0;
                                  strUsaChq: String = 'N';
                                  blnDupsRedondas: Boolean = True;
                                  blnUsaHist: Boolean = False;
                                  fltValRec : Double = 0.0;
                                  arrValores: TDoubleArray = Nil;
                                  blnSabDomFeriadoDiasUteis: Boolean = True;
                                  blnFatPed: Boolean = False;
                                  objArredondamento: IArredondaParcela = Nil;
                                  fltDescPrimeraParcela: Double = 0;
                                  strCodCid: string = '';
                                  strOpcDoc: string = '';
                                  strCodCnd: string = '';
                                  const AblnUtilizarDataEmissaoCalcularDiaVencimento: boolean = False;
                                  AblnImpConhecimentoFrete: Boolean = False;
                                  blnConservarValoresDasParcelas: Boolean = False): Boolean;

function fRetArred2ParcFornec(strCodFor: String) : Boolean;
function fUtilizaCondicaoPagtoPorVendedor(blnValida: Boolean; strCodCnd, strCodVen: String): Boolean;
function fRetDiaProrrogacaoCtr: Integer;
function fUtilizarComoDataBaseCtrDataEmissaoPedido(blnFatPed: Boolean; const AblnUtilizarDataEmissaoCalcularDiaVencimento: boolean): Boolean;

procedure pZeraDigDuplic(var arrDuplicata: TarrDuplicata);
procedure pAcertaDuplicParaDiasUteis(Var arrDuplicata: TArrDigDuplic; strCodCid: String = '');
procedure pArredondaParcelaComEntrada(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray; strCndPag, strCodCnd: string);


implementation

{$IFDEF LINUX}

{$ELSE}
uses
  untDigDuplicata;
{$ENDIF}

function fRetPerEntrada(strCodCnd: String): Double;
Begin
  Result := 0;

  If fEmptyStr(strCodCnd) Then
    Exit;

  Result := fCampoTabela('CND_PERVEN', 'CADCND', ['CND_CODIGO'], [strCodCnd], False);
End;

procedure pArredondaParcelaComEntrada(fltValTot: Double; intQtdPar: Integer; var arrDigDuplicArray: TArrDigDuplicArray; strCndPag, strCodCnd: string);
var
  intIndice: integer;
  fltValPar,
  fltRestante,
  fltPerEntrada: Double;
  intParcelaRestante: integer;
begin
  if fEmptyStr(strCodCnd) then
  begin
    fltPerEntrada := fRetPerEntrada(fRetCodCnd(strCndPag));
  end
  else
  begin
    fltPerEntrada := fRetPerEntrada(strCodCnd);
  end;

  if fltPerEntrada = 0 then
    Exit;

  if intQtdPar = 1 then
  begin
    arrDigDuplicArray[0].curValor := fltValTot;
  end
  else if intQtdPar = 2 then
  begin
    arrDigDuplicArray[0].curValor := fFormataFloat(((fltValTot * fltPerEntrada) / 100),2);
    arrDigDuplicArray[1].curValor := fltValTot - arrDigDuplicArray[0].curValor;
  end
  else
  begin
    intParcelaRestante := intQtdPar - 1;
    arrDigDuplicArray[0].curValor := fFormataFloat(((fltValTot * fltPerEntrada) / 100),2);
    fltRestante := fltValTot - arrDigDuplicArray[0].curValor;

    fltValPar := fFormataFloat(fltRestante / intParcelaRestante, 2);
    arrDigDuplicArray[1].curValor := fltValPar;

    If (fltValPar * intParcelaRestante < fltRestante) Then
      arrDigDuplicArray[1].curValor := fltValPar + (fltRestante - (fltValPar * intParcelaRestante));

    For intIndice := 2 To intQtdPar -1 Do
    Begin
      arrDigDuplicArray[intIndice].curValor := fltValPar;

      If (intIndice = intQtdPar -1) Then
      Begin
        If (fltValPar * intParcelaRestante > fltRestante) Then
          arrDigDuplicArray[intIndice].curValor := fltValPar + (fltRestante - (fltValPar * intParcelaRestante));
      End;
    End;
  end;
end;

procedure pAcertaDuplicParaDiasUteis(Var arrDuplicata: TArrDigDuplic; strCodCid: String = '');
  Var
    dtaRef: TDateTime;

    function fDataDeVencimentoValidaParaAcerto: Boolean;
    begin
      Result := (Not fEmptyStr(arrDuplicata.dtaDtaVen)         And
                (StrToDate(arrDuplicata.dtaDtaVen) <> VS_Date));
    end;

Begin

  If fDataDeVencimentoValidaParaAcerto Then
  Begin
    dtaRef := StrToDate(arrDuplicata.dtaDtaVen);
    dtaRef := fAcertaDataParaDiaUtil(dtaRef, strCodCid);
    arrDuplicata.dtaDtaVen := DateToStr(dtaRef);
  End;

End;

procedure pAcertaDigDuplicParaDiasUteisVar(Var arrDuplicata: TArrDigDuplicArray; strCodCid: String = '');
  Var
    intContador: Integer;
begin
  For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
    pAcertaDuplicParaDiasUteis(arrDuplicata[intContador], strCodCid);
end;

procedure pZeraDigDuplic(var arrDuplicata: TarrDuplicata);
begin
  FillChar(arrDuplicata, SizeOf(arrDuplicata), #0);
end;

procedure pZeraDigDuplicVar(Var arrDuplicata: TArrDigDuplicArray); overload;
begin
  FillChar(arrDuplicata, SizeOf(arrDuplicata), #0);
end;

procedure pZeraDigDuplicVar(Var arrDuplicata: TarrDuplicata); overload;
begin
  FillChar(arrDuplicata, SizeOf(arrDuplicata), #0);
end;


function fDigDuplic(var arrDuplicata: TarrDuplicata;
                    strCndPag:String;
                    intNumDoc:Int64;
                    curTotal:Currency;
                    blnMosTela,
                    blnEditavel,
                    blnHabEditDup:Boolean;
                    dtaDtaBas:TDateTime;
                    blnPergConf: Boolean;
                    fltImpost: Double = 0;
                    strUsaChq: String = 'N';
                    blnDupsRedondas: Boolean = True;
                    blnUsaHist: Boolean = False;
                    fltValRec : Double = 0.0;
                    blnFaturamento: Boolean = False;
                    arrValores: TDoubleArray = Nil;
                    strEspDoc: String = '';
                    blnSabDomFeriadoDiasUteis: Boolean = True;
                    blnHabEditValor: Boolean = True;
                    pMostraContaCorrente: TPrcMostraContaCorrente = Nil;
                    strCodCli: String = '';
                    blnPerRep: Boolean = False;
                    blnValoresPadrao: Boolean = True;
                    strCodCnd: String = '';
                    strCodVen: String = '';
                    fSenVar: TGenericFunctionWithArrayParam = Nil;
                    blnFatPed: Boolean = False;
                    blnAgrupVeio: Boolean = False;
                    objArredondamento: IArredondaParcela = Nil;
                    blnManterValoesOriginais: Boolean = False;
                    blnMostrarOpcaoPadrao: Boolean = False;
                    fltDescPrimeraParcela: Double = 0;
                    AFormVeio: String = '';
                    strCodCid: String = '';
                    strOpcDoc: string = '';
                    blnTelaAgrupamento: Boolean = False;
                    const AblnUtilizarDataEmissaoCalcularDiaVencimento: boolean = False;
                    AblnImpConhecimentoFrete: Boolean = False;
                    blnAbreTelaComCreditoAutomatico: Boolean = True;
                    blnConservarValoresDasParcelas: Boolean = False): Boolean;
  Var
    intQtdDup : Integer;
    curTotalRes: Currency;
    arrDuplicataPadrao,
    arrDuplicataSave: TarrDuplicata;
    intContador: Integer;
    blnManterValoresPadrao: Boolean;
   {$IFNDEF LINUX}
    frmDigDuplicata : TfrmDigDuplicata;
   {$ENDIF}
begin
  blnManterValoresPadrao := arrDuplicata[0].blnManterValoresPadrao;

  If blnMostrarOpcaoPadrao Then
  Begin
    For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
      arrDuplicataSave[intContador] := arrDuplicata[intContador];

    fDigDuplicSemTela(arrDuplicata,
                      intQtdDup,
                      curTotalRes,
                      strCndPag,
                      intNumDoc,
                      curTotal,
                      blnEditavel,
                      blnHabEditDup,
                      dtaDtaBas + IIF(Pos(strEspDoc, 'DV_TR_') > 0, fCfgSis('QTTRDV'), 0),
                      blnPergConf,
                      fltImpost,
                      strUsaChq,
                      blnDupsRedondas,
                      blnUsaHist,
                      fltValRec,
                      arrValores,
                      blnSabDomFeriadoDiasUteis,
                      blnFatPed,
                      objArredondamento,
                      fltDescPrimeraParcela,
                      strCodCid,
                      strOpcDoc,
                      strCodCnd,
                      AblnUtilizarDataEmissaoCalcularDiaVencimento,
                      AblnImpConhecimentoFrete,
                      blnConservarValoresDasParcelas);

    // SALVA OS VALORES PADROES CALCULADOS
    For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
      arrDuplicataPadrao[intContador] := arrDuplicata[intContador];

    If Not blnManterValoresPadrao Then
      For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
        arrDuplicata[intContador] := arrDuplicataSave[intContador];
  End;

  If blnManterValoesOriginais Then
  Begin
  	intQtdDup   := StrToIntDef(Copy(strCndPag,0,2), 0);
    curTotalRes := curTotal;
    Result := True;
  End
  Else Result := fDigDuplicSemTela( arrDuplicata,
                                    intQtdDup,
                                    curTotalRes,
                                    strCndPag,
                                    intNumDoc,
                                    curTotal,
                                    blnEditavel,
                                    blnHabEditDup,
                                    dtaDtaBas + IIF(Pos(strEspDoc, 'DV_TR_') > 0, fCfgSis('QTTRDV'), 0),
                                    blnPergConf,
                                    fltImpost,
                                    strUsaChq,
                                    blnDupsRedondas,
                                    blnUsaHist,
                                    fltValRec,
                                    arrValores,
                                    blnSabDomFeriadoDiasUteis,
                                    blnFatPed,
                                    objArredondamento,
                                    fltDescPrimeraParcela,
                                    strCodCid,
                                    strOpcDoc,
                                    strCodCnd,
                                    AblnUtilizarDataEmissaoCalcularDiaVencimento,
                                    AblnImpConhecimentoFrete,
                                    blnConservarValoresDasParcelas );


  {*************************************************************}
  {* VERIFICA SE IRA MOSTRAR A TELA DE EXIBIÇÃO DAS DUPLICATAS *}
  {**********************************************************DV*}

  arrDuplicata[0].blnManterValoresPadrao := blnManterValoresPadrao;

  If (blnMosTela) Then
  Begin
   {$IFDEF LINUX}
    Raise Exception.Create('blnMosTela = True nao pode ser utilizada em compilacao linux');
   {$ELSE}
    Try
      pCriarFormularios(TfrmDigDuplicata, frmDigDuplicata);

      frmDigDuplicata.arrDuplicata := @arrDuplicata;

      If blnMostrarOpcaoPadrao Then
        frmDigDuplicata.arrDuplicataPadrao := arrDuplicataPadrao;

      frmDigDuplicata.blnMostrarOpcaoPadrao  := blnMostrarOpcaoPadrao;

      frmDigDuplicata.chkValPad.Checked := arrDuplicata[Low(arrDuplicata)].blnManterValoresPadrao;

      frmDigDuplicata.blnAgrupVeio    := blnAgrupVeio;
      frmDigDuplicata.AFormVeio       := AFormVeio;
      frmDigDuplicata.intQtdPar       := intQtdDup;
      frmDigDuplicata.blnEditavel     := blnEditavel;
      frmDigDuplicata.blnHabEditDup   := blnHabEditDup;
      frmDigDuplicata.blnHabEditValor := blnHabEditValor;
      frmDigDuplicata.curTotalPed     := curTotalRes;
      frmDigDuplicata.blnPergConf     := blnPergConf;
      frmDigDuplicata.strEspDoc       := strEspDoc;
      frmDigDuplicata.btnValoresPadrao.Visible := blnValoresPadrao;
      frmDigDuplicata.pMostraContaCorrente := pMostraContaCorrente;
      frmDigDuplicata.blnTelaAgrupamento := blnTelaAgrupamento;

      If (Not blnUsaHist) Then
      Begin
        frmDigDuplicata.btnHistorico.Visible := False;
        frmDigDuplicata.edtHist02.Visible    := False;
        frmDigDuplicata.btnHistorico.Enabled := False;
        frmDigDuplicata.edtHist02.Enabled    := False;
      End;

      If strUsaChq = 'N' Then
      Begin
        frmDigDuplicata.lblCheques.Visible := False;
        frmDigDuplicata.lblCheques2.Visible := False;
        frmDigDuplicata.edtChq01.Visible := False;
        frmDigDuplicata.edtChq02.Visible := False;
        frmDigDuplicata.edtChq03.Visible := False;
        frmDigDuplicata.edtChq04.Visible := False;
        frmDigDuplicata.edtChq05.Visible := False;
        frmDigDuplicata.edtChq06.Visible := False;
        frmDigDuplicata.edtChq07.Visible := False;
        frmDigDuplicata.edtChq08.Visible := False;
        frmDigDuplicata.edtChq09.Visible := False;
        frmDigDuplicata.edtChq10.Visible := False;
        frmDigDuplicata.edtChq11.Visible := False;
        frmDigDuplicata.edtChq12.Visible := False;

        frmDigDuplicata.edtChq13.Visible := False;
        frmDigDuplicata.edtChq14.Visible := False;
        frmDigDuplicata.edtChq15.Visible := False;
        frmDigDuplicata.edtChq16.Visible := False;
        frmDigDuplicata.edtChq17.Visible := False;
        frmDigDuplicata.edtChq18.Visible := False;
        frmDigDuplicata.edtChq19.Visible := False;
        frmDigDuplicata.edtChq20.Visible := False;
        frmDigDuplicata.edtChq21.Visible := False;
        frmDigDuplicata.edtChq22.Visible := False;
        frmDigDuplicata.edtChq23.Visible := False;
        frmDigDuplicata.edtChq24.Visible := False;

        frmDigDuplicata.lblTotVen.Left  := 635;
        frmDigDuplicata.lblTotDig.Left  := 635;
        frmDigDuplicata.lblVlFalta.Left := 635;
        frmDigDuplicata.edtTotVen.Left  := 635;
        frmDigDuplicata.edtTotDig.Left  := 635;
        frmDigDuplicata.edtVlFalta.Left := 635;
        frmDigDuplicata.Width := 755;

      End;

      frmDigDuplicata.blnFaturamento  := blnFaturamento;
      frmDigDuplicata.fltValRec       := fltValRec;
      frmDigDuplicata.strCndPag       := strCndPag;
      frmDigDuplicata.dtaDtaBas       := dtaDtaBas;
      frmDigDuplicata.blnDupsRedondas := blnDupsRedondas;
      frmDigDuplicata.strCodCli       := strCodCli;
      frmDigDuplicata.blnPerRep       := blnPerRep;
      frmDigDuplicata.strCodCnd       := strCodCnd;
      frmDigDuplicata.strCodVen       := strCodVen;
      frmDigDuplicata.fSenVar         := fSenVar;

      if (fCfgSis('BADAUT', varBoolean)) And (Not blnAbreTelaComCreditoAutomatico) then
      Begin
        Result := True;
      End
      Else
      Begin
        frmDigDuplicata.ShowModal;

        Result := frmDigDuplicata.blnConfirma;
      End;

      If Result Then
        arrDuplicata[Low(arrDuplicata)].blnManterValoresPadrao := frmDigDuplicata.chkValPad.Checked;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDigDuplic]');
      End;
    End;

    pFreeAndNil(frmDigDuplicata);
    {$ENDIF}
  End;

end;

{**********************************************}
{* RETORNA ARRED 2a PARC DO CAD DE FORNECEDOR *}
{*******************************************IV*}
function fRetArred2ParcFornec(strCodFor: String) : Boolean;
  Var
    strSQL: String;
    qryGen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  FOR_VLRED2 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;

      Result := FieldByName('FOR_VLRED2').AsString = 'S';

      Close;
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryGen);
  {$ENDIF LINUX}
  End;
End;

function fRetDiaProrrogacaoCtr: Integer;
Var
  strDiaPro: String;
Begin
  strDiaPro := fCfgSis('DIPRPD', varString);
  Result    := strToIntDef(strDiaPro, 0);
End;

function fUtilizarComoDataBaseCtrDataEmissaoPedido(blnFatPed: Boolean; const AblnUtilizarDataEmissaoCalcularDiaVencimento: boolean): Boolean;
Begin
  Result := False;

  If (blnFatPed)                     And
     (AblnUtilizarDataEmissaoCalcularDiaVencimento) Then
    Result := True;
End;

function fUtilizaCondicaoPagtoPorVendedor(blnValida: Boolean;
  strCodCnd, strCodVen: String): Boolean;
  Var
    qryVenCnd: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin
  Result := fCfgSis('USACND', varBoolean) And
            fCfgSis('CNPVEN', varBoolean);

  If Result And blnValida Then
  Begin
    qryVenCnd := fCriaQuery;

    With qryVenCnd, SQL Do
    Begin
      Add('SELECT *');
      Add('FROM VENCND');
      Add('WHERE');
      Add('  CND_CODVEN = :CODVEN AND ');
      Add('  CND_CODCND = :CODCND     ');

      ParamByName('CODVEN').AsString := strCodVen;
      ParamByName('CODCND').AsString := strCodCnd;

      Open;
      Result := IsEmpty;
      Close;
    End;

  {$IFNDEF LINUX}
    FreeAndNil(qryVenCnd);
  {$ENDIF LINUX}
  End;
End;

{********************************************}
{* CRIADO PARA UTILIZACAO DE OUTRAS         *}
{* VARIAVEIS SEM FICAR PRESO A arrDuplicata *}
{*****************************************AF*}
function fDigDuplicVar(strCndPag: String;
                       intNumDoc: Int64;
                       curTotal : Currency;
                       blnMosTela,
                       blnEditavel,
                       blnHabEditDup: Boolean;
                       dtaDtaBas    : TDateTime;
                       blnPergConf  : Boolean;
                       var arrDuplic: TArrDigDuplicArray;
                       fltImpost    : Double = 0;
                       strUsaChq    : String = 'N';
                       blnDupsRedondas: Boolean = True;
                       blnUsaHist     : Boolean = False;
                       fltValRec      : Double = 0.0;
                       objArredondamento: IArredondaParcela = Nil): Boolean;
Var
  arrDuplicata: TarrDuplicata;
begin
  pZeraDigDuplic(arrDuplicata);

  Result := fDigDuplicVar(strCndPag,
                          intNumDoc,
                          curTotal,
                          blnMosTela,
                          blnEditavel,
                          blnHabEditDup,
                          dtaDtaBas,
                          blnPergConf,
                          arrDuplic,
                          arrDuplicata,
                          fltImpost,
                          strUsaChq,
                          blnDupsRedondas,
                          blnUsaHist,
                          fltValRec,
                          nil,
                          objArredondamento);
end;

{********************************************}
{* CRIADO PARA UTILIZACAO DE OUTRAS         *}
{* VARIAVEIS SEM FICAR PRESO A arrDuplicata *}
{*****************************************AF*}
function fDigDuplicVar(strCndPag: String;
                       intNumDoc: Int64;
                       curTotal : Currency;
                       blnMosTela,
                       blnEditavel,
                       blnHabEditDup: Boolean;
                       dtaDtaBas    : TDateTime;
                       blnPergConf  : Boolean;
                       var arrDuplic: TArrDigDuplicArray;
                       var arrDuplicata: TarrDuplicata;
                       fltImpost    : Double = 0;
                       strUsaChq    : String = 'N';
                       blnDupsRedondas: Boolean = True;
                       blnUsaHist     : Boolean = False;
                       fltValRec      : Double = 0.0;
                       arrValores: TDoubleArray = Nil;
                       objArredondamento: IArredondaParcela = Nil): Boolean;
	Const
  	arrLetra : Array[0..25] Of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
  Var
    intIndice  : Integer;
    intQtdDup  : Integer;
    strAux     : String;
    intContador: Integer;
    {$IFNDEF LINUX}
    frmDigDuplicata : TfrmDigDuplicata;
    {$ENDIF}
begin

  Result := True;

  SetLength(arrDuplic,0);
  strCndPag   := fTiraCaracEspeciaisParenteses(strCndPag);

  intContador := 0;
  intQtdDup   := StrToIntDef(Copy(strCndPag,0,2),0);
  strAux      := Copy(strCndPag,3,Length(strCndPag)-1);
  strAux      := AnsiReplaceStr(strAux,'.','');
  intIndice   := 1;
  SetLength(arrDuplic,intQtdDup);

  If intQtdDup = 0 Then
    Exit;

  If (fltImpost > 0) Then
    curTotal := curTotal - fltImpost;

	While intContador <= intQtdDup -1 Do
  Begin
  	arrDuplic[intContador].intNumDup := intNumDoc;
    arrDuplic[intContador].strSequen := arrLetra[intContador];
		arrDuplic[intContador].dtaDtaVen := FormatDateTime('DD/MM/YYYY',(dtaDtaBas + StrToIntDef(Copy(strAux,intIndice,3),0)));
    Inc(intContador);
		intIndice := intIndice + 3;
  End;

	{********************************}
  {* DESDOBRA VALOR DE DUPLICATAS *}
  {*****************************DV*}
  If intQtdDup = 1 Then
  	ArrDuplic[0].curValor := curTotal

  Else
  Begin

    If (blnDupsRedondas) Then
      pArredondaParcelaRedonda(curTotal, intQtdDup, ArrDuplic)
    Else
    Begin
      If (objArredondamento = Nil) Then
        pArredondaParcelaDefault(curTotal, intQtdDup, ArrDuplic)
      Else
        objArredondamento.pArredondaParcela(curTotal, intQtdDup, ArrDuplic);
    End;

  End;

  If (fltImpost > 0) Then
  Begin
    curTotal := curTotal + fltImpost;
    arrDuplic[0].curValor := arrDuplic[0].curValor + fltImpost;
  End;

	{*************************************************************}
  {* VERIFICA SE IRA MOSTRAR A TELA DE EXIBIÇÃO DAS DUPLICATAS *}
  {**********************************************************DV*}
  If blnMosTela Then
  Begin
   {$IFDEF LINUX}
    Raise Exception.Create('blnMosTela = True nao pode ser utilizada em compilacao linux');
   {$ELSE}
  	Try
    	pCriarFormularios(TfrmDigDuplicata, frmDigDuplicata);
      frmDigDuplicata.intQtdPar     := intQtdDup;
      frmDigDuplicata.blnEditavel   := blnEditavel;
      frmDigDuplicata.blnHabEditDup := blnHabEditDup;
      frmDigDuplicata.curTotalPed   := curTotal;
      frmDigDuplicata.blnPergConf   := blnPergConf;
      frmDigDuplicata.arrDuplicata  := @arrDuplicata;

      If (Not blnUsaHist) Then
      Begin
        frmDigDuplicata.btnHistorico.Visible := False;
        frmDigDuplicata.edtHist02.Visible    := False;
        frmDigDuplicata.btnHistorico.Enabled := False;
        frmDigDuplicata.edtHist02.Enabled    := False;
      End;

      If strUsaChq = 'N' Then
      Begin
        frmDigDuplicata.lblCheques.Visible := False;
        frmDigDuplicata.lblCheques2.Visible := False;
        frmDigDuplicata.edtChq01.Visible := False;
        frmDigDuplicata.edtChq02.Visible := False;
        frmDigDuplicata.edtChq03.Visible := False;
        frmDigDuplicata.edtChq04.Visible := False;
        frmDigDuplicata.edtChq05.Visible := False;
        frmDigDuplicata.edtChq06.Visible := False;
        frmDigDuplicata.edtChq07.Visible := False;
        frmDigDuplicata.edtChq08.Visible := False;
        frmDigDuplicata.edtChq09.Visible := False;
        frmDigDuplicata.edtChq10.Visible := False;
        frmDigDuplicata.edtChq11.Visible := False;
        frmDigDuplicata.edtChq12.Visible := False;

        frmDigDuplicata.edtChq13.Visible := False;
        frmDigDuplicata.edtChq14.Visible := False;
        frmDigDuplicata.edtChq15.Visible := False;
        frmDigDuplicata.edtChq16.Visible := False;
        frmDigDuplicata.edtChq17.Visible := False;
        frmDigDuplicata.edtChq18.Visible := False;
        frmDigDuplicata.edtChq19.Visible := False;
        frmDigDuplicata.edtChq20.Visible := False;
        frmDigDuplicata.edtChq21.Visible := False;
        frmDigDuplicata.edtChq22.Visible := False;
        frmDigDuplicata.edtChq23.Visible := False;
        frmDigDuplicata.edtChq24.Visible := False;

        frmDigDuplicata.lblTotVen.Left  := 635;
        frmDigDuplicata.lblTotDig.Left  := 635;
        frmDigDuplicata.lblVlFalta.Left := 635;
        frmDigDuplicata.edtTotVen.Left  := 635;
        frmDigDuplicata.edtTotDig.Left  := 635;
        frmDigDuplicata.edtVlFalta.Left := 635;
        frmDigDuplicata.Width := 755;

      End;

      frmDigDuplicata.fltValRec       := fltValRec;
      frmDigDuplicata.strCndPag       := strCndPag;
      frmDigDuplicata.dtaDtaBas       := dtaDtaBas;
      frmDigDuplicata.blnDupsRedondas := blnDupsRedondas;

      frmDigDuplicata.ShowModal;

      Result := frmDigDuplicata.blnConfirma;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fDigDuplicVar]');
      End;
    End;

    pFreeAndNil(frmDigDuplicata);
    {$ENDIF}
  End;

  If (Assigned(arrValores)) And (Sum(arrValores) = curTotal) Then
  Begin
    If StrToIntDef(LeftStr(strCndPag, 2), -1) = Length(arrValores) Then
    Begin
      For intContador := Low(arrValores) To High(arrValores) Do
      Begin
        arrDuplicata[intContador].curValor := arrValores[intContador];
      End;
    End;
  End;

end;

function fDigDuplicSemTela(var arrDuplicata: TarrDuplicata;
                           Var intQtdDup: Integer;
                           Var curTotalRes: Currency;
                               strCndPag:String;
                               intNumDoc:Int64;
                               curTotal:Currency;
                               blnEditavel,
                               blnHabEditDup:Boolean;
                               dtaDtaBas:TDateTime;
                               blnPergConf: Boolean;
                               fltImpost: Double = 0;
                               strUsaChq: String = 'N';
                               blnDupsRedondas: Boolean = True;
                               blnUsaHist: Boolean = False;
                               fltValRec : Double = 0.0;
                               arrValores: TDoubleArray = Nil;
                               blnSabDomFeriadoDiasUteis: Boolean = True;
                               blnFatPed: Boolean = False;
                               objArredondamento: IArredondaParcela = Nil;
                               fltDescPrimeraParcela: Double = 0;
                               strCodCid: string = '';
                               strOpcDoc: string = '';
                               strCodCnd: string = '';
                               const AblnUtilizarDataEmissaoCalcularDiaVencimento: boolean = False;
                               AblnImpConhecimentoFrete: Boolean = False;
                               blnConservarValoresDasParcelas: Boolean = False): Boolean;
var
  arrDupAux: TArrDigDuplicArray;
  intContador: Integer;
Begin
  pZeraDigDuplicVar(arrDupAux);
  if not blnConservarValoresDasParcelas then
  begin
    pZeraDigDuplicVar(arrDuplicata);
  end
  else
  begin
    SetLength(arrDupAux, 26);
    for intContador := Low(arrDuplicata) to high(arrDuplicata) do
      arrDupAux[intContador] := arrDuplicata[intContador];
  end;

  Result := fDigDuplicSemTelaVar(False,
                                 arrDupAux,
                                 intQtdDup,
                                 curTotalRes,
                                 strCndPag,
                                 intNumDoc,
                                 curTotal,
                                 blnEditavel,
                                 blnHabEditDup,
                                 dtaDtaBas,
                                 blnPergConf,
                                 fltImpost,
                                 strUsaChq,
                                 blnDupsRedondas,
                                 blnUsaHist,
                                 fltValRec,
                                 arrValores,
                                 blnSabDomFeriadoDiasUteis,
                                 blnFatPed,
                                 objArredondamento,
                                 fltDescPrimeraParcela,
                                 strCodCid,
                                 strOpcDoc,
                                 strCodCnd,
                                 AblnUtilizarDataEmissaoCalcularDiaVencimento,
                                 AblnImpConhecimentoFrete,
                                 blnConservarValoresDasParcelas);

  for intContador := Low(arrDupAux) to high(arrDupAux) do
    arrDuplicata[intContador] := arrDupAux[intContador];
End;

function fDigDuplicSemTelaVar(    blnFinanc: Boolean;
                              Var arrDuplicata: TArrDigDuplicArray;
                              Var intQtdDup: Integer;
                              Var curTotalRes: Currency;
                                  strCndPag:String;
                                  intNumDoc:Int64;
                                  curTotal:Currency;
                                  blnEditavel,
                                  blnHabEditDup:Boolean;
                                  dtaDtaBas:TDateTime;
                                  blnPergConf: Boolean;
                                  fltImpost: Double = 0;
                                  strUsaChq: String = 'N';
                                  blnDupsRedondas: Boolean = True;
                                  blnUsaHist: Boolean = False;
                                  fltValRec : Double = 0.0;
                                  arrValores: TDoubleArray = Nil;
                                  blnSabDomFeriadoDiasUteis: Boolean = True;
                                  blnFatPed: Boolean = False;
                                  objArredondamento: IArredondaParcela = Nil;
                                  fltDescPrimeraParcela: Double = 0;
                                  strCodCid: string = '';
                                  strOpcDoc: string = '';
                                  strCodCnd: string = '';
                                  const AblnUtilizarDataEmissaoCalcularDiaVencimento: boolean = False;
                                  AblnImpConhecimentoFrete: Boolean = False;
                                  blnConservarValoresDasParcelas: Boolean = False): Boolean;
	Const
  	arrLetra : Array[0..25] Of Char = ('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z');
  Var
  	intIndice   : Integer;
    strAux      : String;
    intContador : Integer;
    intDiaPro   : Integer;
    intPriPrz   : Integer;
    intPrzAtu   : Integer;
    intPrzOri   : Integer;
    blnAltDtaBas: Boolean;
    blnProrrogou: Boolean;
    blnVoltarImp: Boolean;
begin

  Result := True;

  blnVoltarImp := False;
  if not blnConservarValoresDasParcelas then
  begin
    SetLength(arrDuplicata, 26);
    pZeraDigDuplicVar(arrDuplicata);
  end;

	intContador  := 0;
	intPriPrz    := 0;
  intDiaPro    := fRetDiaProrrogacaoCtr;
  blnAltDtaBas := fUtilizarComoDataBaseCtrDataEmissaoPedido(blnFatPed, AblnUtilizarDataEmissaoCalcularDiaVencimento) or fCfgSis('DTPFAT', VarBoolean);
  blnProrrogou := False;

  strCndPag := fTiraCaracEspeciaisParenteses(strCndPag);
	intQtdDup := StrToIntDef(Copy(strCndPag,0,2), 0);

  If fEmptyStr(strCndPag) Or (intQtdDup = 0) Then
  Begin
    intQtdDup := 0;
    Exit;
  End;

  if not blnConservarValoresDasParcelas then
    SetLength(arrDuplicata, intQtdDup);

	strAux := Copy(strCndPag,3,Length(strCndPag)-1);
  strAux := AnsiReplaceStr(strAux,'.','');
  intIndice := 1;

  If (fltImpost > 0) And (fFormataFloat(curTotal,2) > 0) And (fFormataFloat(curTotal - fltImpost, 2) > 0) Then
  Begin
    curTotal := curTotal - fltImpost;
    blnVoltarImp := True;
  End;

	While intContador <= intQtdDup -1 Do
  Begin
  	arrDuplicata[intContador].intNumDup := intNumDoc;

    If blnFinanc Then
      arrDuplicata[intContador].strSequen := fStrZero(IntToStr(Succ(intContador)), 3)
    Else
      arrDuplicata[intContador].strSequen := arrLetra[intContador];

    //ARMAZENA O PRAZO DA PARCELA ATUAL
    intPrzAtu := StrToIntDef(Copy(strAux,intIndice,3),0);

    //ARMAZENA O PRAZO ORIGINAL DA PARCELA ATUAL
    intPrzOri := intPrzAtu;

    //SE A PRIMEIRA PARCELA FOI PRORROGADA, AJUSTA OS PRAZOS DAS DEMAIS PARCELAS, MANTENDO OS MESMOS INTERVALOS.
    If (blnProrrogou) Then
      intPrzAtu := intPrzAtu - intPriPrz;

    //ARMAZENA O VENCIMENTO DA PARCELA ATUAL
		arrDuplicata[intContador].dtaDtaVen := FormatDateTime('DD/MM/YYYY',(dtaDtaBas + intPrzAtu));

    if AblnImpConhecimentoFrete And (fCfgSis('NOCTFI', varBoolean)) and (fCfgSis('CTECPG', varString)='2') then
    begin
      //Se a primeira parcela for <= data atual
      if (intContador = 0) and ((dtaDtaBas + intPrzAtu) <= fNow())then
      begin
        dtaDtaBas := (fNow()+1)-intPrzAtu;
        arrDuplicata[intContador].dtaDtaVen := FormatDateTime('DD/MM/YYYY',(dtaDtaBas + intPrzAtu));
      end;
    end;

    //SE ESTIVER UTILIZANDO A DATA DE EMISSÃO DO PEDIDO DE VENDA, COMO BASE PARA CALCULO DAS PARCELAS,
    //E A PRIMEIRA PARCELA JÁ ESTIVER VENCIDA OU COM O VENCIMENTO NA DATA DE HOJE, IRÁ ALTERAR A DATA BASE PARA DATE + CFG_DIPRPD.
    If (blnAltDtaBas) And (strToDate(arrDuplicata[intContador].dtaDtaVen) <= VS_DATE) And (dtaDtaBas < VS_Date) Then
    Begin
      intPriPrz := intPrzOri;
      dtaDtaBas := IncDay(VS_DATE, intDiaPro);

      If (fFormataFloat(curTotal, 2) = 0.00) Or (strCndPag = '01000') Then
        dtaDtaBas := VS_DATE;

      arrDuplicata[intContador].dtaDtaVen := FormatDateTime('DD/MM/YYYY', dtaDtaBas);
      blnProrrogou := True;
    End;

    Inc(intContador);
		intIndice := intIndice + 3;
  End;

	{********************************}
  {* DESDOBRA VALOR DE DUPLICATAS *}
  {*****************************DV*}
  If intQtdDup = 1 Then
  Begin
    if not blnConservarValoresDasParcelas then
    	ArrDuplicata[0].curValor := curTotal;
  End
  Else
  Begin

    If fltDescPrimeraParcela > 0 Then
      curTotal := curTotal + fltDescPrimeraParcela;

    If (blnDupsRedondas) Then
    Begin
      If Int(curTotal / intQtdDup) < 1 Then
        blnDupsRedondas := False;
    End;

    If (blnDupsRedondas) And (curTotal > 1) Then
    begin
      if not blnConservarValoresDasParcelas then
        pArredondaParcelaRedonda(curTotal, intQtdDup, ArrDuplicata);
    end
    Else
    Begin
      If (objArredondamento = Nil) Then
      begin
        if (not blnConservarValoresDasParcelas) and (ArrDuplicata[0].curValor = 0) then
          pArredondaParcelaDefault(curTotal, intQtdDup, ArrDuplicata);
      end
      Else
        objArredondamento.pArredondaParcela(curTotal, intQtdDup, ArrDuplicata);
    End;
  End;

  If (fCfgSis('PERPAG', varBoolean)) And (Copy(strCndPag, 3, 3) = '000') And (Pos(strOpcDoc, 'PD_OR_VN') > 0) Then
  Begin
    if not blnConservarValoresDasParcelas then
      pArredondaParcelaComEntrada(curTotal, intQtdDup, ArrDuplicata, strCndPag, strCodCnd);
  End;

  If (fltImpost > 0) And (blnVoltarImp) And (fFormataFloat(curTotal, 2) > 0) Then
  Begin
    curTotal := curTotal + fltImpost;
    if not blnConservarValoresDasParcelas then
      arrDuplicata[0].curValor := arrDuplicata[0].curValor + fltImpost;
  End;

  If fltDescPrimeraParcela > 0 Then
  Begin
    curTotal := curTotal - fltDescPrimeraParcela;
    if not blnConservarValoresDasParcelas then
      arrDuplicata[0].curValor := arrDuplicata[0].curValor - fltDescPrimeraParcela;
  End;

  curTotalRes := curTotal;

  If (Assigned(arrValores)) And (fFormataFloat(Sum(arrValores),2) = fFormataFloat(curTotal,2)) Then
  Begin
    If StrToIntDef(LeftStr(strCndPag, 2), -1) = Length(arrValores) Then
    Begin
      if not blnConservarValoresDasParcelas then
      begin
        For intContador := Low(arrValores) To High(arrValores) Do
        Begin
          arrDuplicata[intContador].curValor := arrValores[intContador];
        End;
      end;
    End;
  End;

  If Not blnSabDomFeriadoDiasUteis Then
    pAcertaDigDuplicParaDiasUteisVar(arrDuplicata, strCodCid);
end;


end.
