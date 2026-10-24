unit untMontagemCaixas;

interface

uses Classes, SysUtils, CPDrv, UniClientDataSet;

{$M+}
type
  TLePesoBalanca = class
    private
      FPesBru: Double;
      FPesLiq: Double;
      FTara  : Double;
      FBuffer: String;
      FModBal: String;
      FCommPort: TCommPortDriver;

      function fRetPorta(Var strPorta: String): TPortNumber;
      function fRetBaudRate(strBaud: String): TBaudRate;
      function fRetDataBits(strData: String): TDataBits;
      function fRetParity(strParity: String): TParity;
      function fRetStopBits(strStop: String): TStopBits;

      procedure pOnReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
    public
      function fConectado(msgErro: Boolean = True): Boolean;
      function fDesconectado: Boolean;

      constructor Create;
      destructor Destroy; override;

    published
      property fltPesoBruto: Double read FPesBru;
      property fltPesoLiquido: Double read FPesLiq;
      property fltTara: Double read FTara;
  end;
{$M-}

type
  TItemDaCaixa = record
    strID: String;
    strPedido: String;
    strCodigo: String;
    strDescricao: String;
    strSiglaUnidade: String;
    fltQuantidade: Double;
    fltPeso : Double;
    strCodFab : String;
    strFgoInc : String;
    strCodMcx : String;
  end;

type
  TItensDaCaixa = array of TItemDaCaixa;

{$M+}
type
  TCaixa = class
    private
      FId: String;
      FCodBar: String;
      FItens: TItensDaCaixa;
      FFechada: Boolean;
      FPesoTot: Double;
      FCodMcx: String;
      function fGetTemItens: Boolean;
      procedure pSetaID(Value : String = '');
      procedure pSetaCodBar(Value : String = '');
    public
      procedure pAdicionarItem(item: TItemDaCaixa);
      procedure pRemoverItem(strItemID: String);
      procedure pFecharCaixa;
      procedure pAbreCaixa;
      function fFindItemByID(strItemID: String): Integer;
      function fSomaQtdItem(strItemID: String):Double;
      constructor Create(id : String = ''; strCodBar: String = '');
      destructor Destroy; override;
    published
      property Itens: TItensDaCaixa read FItens;
      property strID: String Read FId;
      property strCodBar: String Read FCodBar;
      property fltPesoTotal: Double Read FPesoTot Write FPesoTot;
      property strCodMcx: String Read FCodMcx Write FCodMcx;
      property blnFechada: Boolean read FFechada;
      property blnTemItens: Boolean read fGetTemItens;
    end;
{$M-}

type
  TCaixas = array of TCaixa;

{$M+}
type
  TMontarCaixas = class
    private
      FLePeso: TLePesoBalanca;
      FCaixas: TCaixas;
      function fGetCaixaAberta: TCaixa;
      function fPodeValidarNumeracaoCaixas():Boolean;

    public
      procedure pNovaCaixa(id : String = ''; strCodBar: String = '');
      procedure pFecharCaixa;
      procedure pCancelarMontagemCaixa;
      function fPesarCaixa(caixa: TCaixa; msgErro: Boolean = True): Double;
      function fPesoCaixa(msgErro: Boolean = True): Double;
      function fPesoProdCaixa(caixa: TCaixa): Double;
      function fBalancaConectada: Boolean;
      function fBuscaCaixa(strID: String): TCaixa;
      function fBuscaCaixaCodBar(strCodBar: String): TCaixa;
      function fBuscaItemNasCaixas(strItemId: String): Boolean;
      function fSomaQtdItemNasCaixas(strItemId: String):Double;
      procedure pAbreCaixa(strID: String);
      constructor Create;
      destructor Destroy; override;

      function fNroCaixasPrefixo(strPrefixCai : String):Integer;

    public
      function fValidarNumeracaoCaixas():Boolean;
      function fValidarNumeracaoCaixasPedido(Const strNumPed:String):Boolean;
      class procedure pCriarCamposDataSetEtiquetaMontagemCaixas(
        const cdsCaixas: TUniClientDataSet);

      class function fRetornaDataSetEtiquetaMontagemCaixas(
        const strFgcCaiId: String): TUniClientDataSet;

    published
      property CaixaAberta: TCaixa Read fGetCaixaAberta;
      property Caixas: TCaixas Read FCaixas;
    end;
{$M-}

implementation

uses untConstantes, untFuncoesSimples, Uni, DB, untTypesSistema;

{ TLePesoBalanca }

constructor TLePesoBalanca.Create;
  Var
    strNomPor: String;
    strBauRat: String;
begin
  FCommPort  := TCommPortDriver.Create(nil);
  FCommPort.OnReceiveData := pOnReceiveData;

  FModBal                 := fCfgSisL('MODBAL');
  strNomPor               := fCfgSisL('PCOBAL');
  strBauRat               := fCfgSisL('RATBAL');

  FCommPort.Port          := fRetPorta(strNomPor);
  FCommPort.PortName      := strNomPor;
  FCommPort.BaudRate      := fRetBaudRate(strBauRat);
  FCommPort.BaudRateValue := StrToIntDef(strBauRat,0);
  FCommPort.DataBits      := fRetDataBits(fCfgSisL('BITBAL'));
  FCommPort.Parity        := fRetParity  (fCfgSisL('PARBAL'));
  FCommPort.StopBits      := fRetStopBits(fCfgSisL('STOBAL'));
end;

destructor TLePesoBalanca.Destroy;
begin
  fDesconectado;
  FreeAndNil(FCommPort);
  inherited;
end;

function TLePesoBalanca.fConectado(msgErro: Boolean = True): Boolean;
begin
  inherited;
  Result := FCommPort.Connect;
  If Not Result And msgErro then
    pMensagemOk('Não foi possível conectar com a Balança.'#13#10 +
                'Verifique as configurações e tente novamente...');
end;

function TLePesoBalanca.fDesconectado: Boolean;
begin
  If FCommPort.Connected then
    FCommPort.Disconnect;
  Result := True;
end;

procedure TLePesoBalanca.pOnReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
  Var
    strTmp: AnsiString;
    strAux1,
    strAux2,
    strAux3: String;
begin
  strTmp := AnsiString(StringOfChar(' ', DataSize));
  Move(DataPtr^, PAnsiChar(strTmp)^, DataSize);

  If SameStr(UpperCase(FModBal), 'MICHELETTI') Then
  Begin
    If (Length(FBuffer) < 37) Then
      FBuffer := FBuffer + String(strTmp);

    If (Length(FBuffer) >= 37) Then
    begin
      strAux1   := Copy(FBuffer, Pos('PB:', FBuffer) + 03, 09);
      strAux2   := Copy(FBuffer, Pos('PL:', FBuffer) + 03, 09);
      strAux3   := Copy(FBuffer, Pos('T:' , FBuffer) + 02, 09);

      FPesBru   := fStrToFloat(Trim(StringReplace(strAux1, 'kg',  '', [])));
      FPesLiq   := fStrToFloat(Trim(StringReplace(strAux2, 'kg',  '', [])));
      FTara     := fStrToFloat(Trim(StringReplace(strAux3, 'kg',  '', [])));

      FBuffer := '';
    End;
  End;
end;

function TLePesoBalanca.fRetPorta(Var strPorta: String): TPortNumber;
begin
  if (strPorta = 'COM1') then
  begin
    Result   := pnCOM1;
    strPorta := '\\.\COM1';
  end
  else if (strPorta = 'COM2') then
  begin
    Result   := pnCOM2;
    strPorta := '\\.\COM2';
  end
  else if (strPorta = 'COM3') then
  begin
    Result   := pnCOM3;
    strPorta := '\\.\COM3';
  end
  else if (strPorta = 'COM4') then
  begin
    Result   := pnCOM4;
    strPorta := '\\.\COM4';
  end
  else if (strPorta = 'COM5') then
  begin
    Result   := pnCOM5;
    strPorta := '\\.\COM5';
  end
  else if (strPorta = 'COM6') then
  begin
    Result   := pnCOM6;
    strPorta := '\\.\COM6';
  end
  else if (strPorta = 'COM7') then
  begin
    Result   := pnCOM7;
    strPorta := '\\.\COM7';
  end
  else if (strPorta = 'COM8') then
  begin
    Result   := pnCOM8;
    strPorta := '\\.\COM8';
  end
  else if (strPorta = 'COM9') then
  begin
    Result   := pnCOM9;
    strPorta := '\\.\COM9';
  end
  else if (strPorta = 'COM10') then
  begin
    Result   := pnCOM10;
    strPorta := '\\.\COM10';
  end
  else if (strPorta = 'COM11') then
  begin
    Result   := pnCOM11;
    strPorta := '\\.\COM11';
  end
  else if (strPorta = 'COM12') then
  begin
    Result   := pnCOM12;
    strPorta := '\\.\COM12';
  end
  else if (strPorta = 'COM13') then
  begin
    Result   := pnCOM13;
    strPorta := '\\.\COM13';
  end
  else if (strPorta = 'COM14') then
  begin
    Result   := pnCOM14;
    strPorta := '\\.\COM14';
  end
  else if (strPorta = 'COM15') then
  begin
    Result   := pnCOM15;
    strPorta := '\\.\COM15';
  end
  else if (strPorta = 'COM16') then
  begin
    Result   := pnCOM16;
    strPorta := '\\.\COM16';
  end
  else
  begin
    Result   := pnCustom;
    strPorta := '';
  end;
end;

function TLePesoBalanca.fRetBaudRate(strBaud: String): TBaudRate;
begin
  Result  := br110;

  case StrToInt64Def(strBaud,0) of
      110:
      begin
        Result  := br110;
        strBaud := '110';
      end;
      300:
      begin
        Result  := br110;
        strBaud := '300';
      end;
      600:
      begin
        Result  := br110;
        strBaud := '600';
      end;
     1200:
      begin
        Result  := br110;
        strBaud := '1200';
      end;
     2400:
      begin
        Result  := br110;
        strBaud := '2400';
      end;
     4800:
      begin
        Result  := br110;
        strBaud := '4800';
      end;
    14400:
      begin
        Result  := br110;
        strBaud := '14400';
      end;
    19200:
      begin
        Result  := br110;
        strBaud := '19200';
      end;
    38400:
      begin
        Result  := br110;
        strBaud := '38400';
      end;
    56000:
      begin
        Result  := br110;
        strBaud := '56000';
      end;
    57600:
      begin
        Result  := br110;
        strBaud := '57600';
      end;
  end;
end;

function TLePesoBalanca.fRetDataBits(strData: String): TDataBits;
begin
  Result := db5BITS;

  case StrToIntDef(strData,0) of
    5: Result := db5BITS;
    6: Result := db6BITS;
    7: Result := db7BITS;
    8: Result := db8BITS;
  end;
end;

function TLePesoBalanca.fRetParity(strParity: String): TParity;
begin
    Result := ptNONE;

  if (strParity = 'EVEN') then
    Result := ptEVEN
  else if (strParity = 'MARK') then
    Result := ptMARK
  else if (strParity = 'NONE') then
    Result := ptNONE
  else if (strParity = 'ODD') then
    Result := ptODD
  else if (strParity = 'SPACE') then
    Result := ptSPACE;
end;

function TLePesoBalanca.fRetStopBits(strStop: String): TStopBits;
begin
  Result := sb1BITS;

  if (strStop = 'S1') then
    Result := sb1BITS
  else if (strStop = 'S1,5') then
    Result := sb1HALFBITS
  else if (strStop = 'S2') then
    Result := sb2BITS;
end;


{ TCaixa }

constructor TCaixa.Create(id : String = ''; strCodBar: String = '');
begin
  pSetaID(id);
  pSetaCodBar(strCodBar);
  SetLength(FItens, 0);
  FFechada := False;  
end;

destructor TCaixa.Destroy;
begin
  SetLength(FItens, 0);
  inherited;
end;

function TCaixa.fFindItemByID(strItemID: String): Integer;
  Var
    index: Integer;
begin
  Result := -1;
  For index := 0 To Length(FItens) -1 Do
    If strItemID = FItens[index].strID Then
    Begin
      Result := index;
      Break;
    End;
end;

function TCaixa.fSomaQtdItem(strItemID: String):Double;
var
  intIndex: Integer;
begin
  Result := 0;

  For intIndex := 0 To Length(FItens) -1 Do
  Begin
    If (strItemID = FItens[intIndex].strID) Then
    Begin
      Result := Result + FItens[intIndex].fltQuantidade;
    End;
  End;
end;

function TCaixa.fGetTemItens: Boolean;
begin
  Result := Length(FItens) > 0;
end;

procedure TCaixa.pAbreCaixa;
begin
  FFechada := False;
end;

procedure TCaixa.pAdicionarItem(item: TItemDaCaixa);
  Var
    index: Integer;
begin
  If FFechada Then
    Raise ExceptionAutCom.Create('Esta caixa já foi fechada!');

  If fEmptyStr(item.strID) Then
    Raise ExceptionAutCom.Create('Produto sem identificação!');

  index := fFindItemByID(item.strID);

  If index = -1 Then
  Begin
    SetLength(FItens, Length(FItens) + 1);
    index := Length(FItens) - 1;
    FItens[index].fltQuantidade := 0;
  End;

  With FItens[index] Do
  Begin
    strID           := item.strID;
    strPedido       := item.strPedido;
    strCodigo       := item.strCodigo;
    strDescricao    := item.strDescricao;
    strSiglaUnidade := item.strSiglaUnidade;
    fltQuantidade   := fltQuantidade + item.fltQuantidade;
    fltPeso         := item.fltPeso;
    strCodFab       := item.strCodFab;
    strFgoInc       := item.strFgoInc;
    Self.strCodMcx  := item.strCodMcx;
  End;

end;

procedure TCaixa.pFecharCaixa;
begin
  If Length(FItens) = 0 Then
    Raise ExceptionAutCom.Create('Esta caixa está vazia!');

  FFechada := True;
end;

procedure TCaixa.pRemoverItem(strItemID: String);
  Var
    index: Integer;
    ItensTmp: TItensDaCaixa;
begin
  If FFechada Then
    Raise ExceptionAutCom.Create('Esta caixa já foi fechada!');

  SetLength(ItensTmp, Length(FItens));

  //Faz uma copia da Matriz de produtos
  For index := Low(FItens) To High(FItens) Do
    ItensTmp[index] := FItens[index];

  SetLength(FItens, 0);

  //insere novamente os itens na Matriz
  For index := Low(ItensTmp) To High(ItensTmp) Do
    If ItensTmp[index].strID <> strItemID Then
      pAdicionarItem(ItensTmp[index]);

  SetLength(ItensTmp, 0);
end;

procedure TCaixa.pSetaID(Value : String = '');
begin
  If fEmptyStr(Value) Then
    FId := fRetSequencial('SEQCAI', VS_strCodEmp)
  Else
    FId := Value;
end;

procedure TCaixa.pSetaCodBar(Value : String = '');
begin
  FCodBar := Value;
end;

{ TMontarCaixas }

constructor TMontarCaixas.Create;
begin
  inherited;
  SetLength(FCaixas, 0);
  FLePeso := TLePesoBalanca.Create;
end;

destructor TMontarCaixas.Destroy;
  Var
    caixa: TCaixa;
begin
  For caixa In FCaixas Do
    caixa.Destroy;

  If Assigned(FLePeso) Then
    FreeAndNil(FLePeso);

  SetLength(FCaixas, 0);

  inherited;
end;

function TMontarCaixas.fBuscaCaixa(strID: String): TCaixa;
  Var
    caixa: TCaixa;
begin
  inherited;
  Result := nil;
  For caixa In Self.Caixas Do
  Begin
    If (caixa.strID = strID) Then
    Begin
      Result := caixa;
      Break;
    End;
  End;
end;

function TMontarCaixas.fBuscaCaixaCodBar(strCodBar: String): TCaixa;
  Var
    caixa: TCaixa;
begin
  inherited;
  Result := nil;
  For caixa In Self.Caixas Do
  Begin
    If (caixa.strCodBar = strCodBar) Then
    Begin
      Result := caixa;
      Break;
    End;
  End;
end;

function TMontarCaixas.fBuscaItemNasCaixas(strItemId: String): Boolean;
  Var
    caixa: TCaixa;
begin
  Result := False;
  For caixa in FCaixas Do
  Begin
    Result := caixa.fFindItemByID(strItemId) <> -1;
    If Result Then
      Break;
  End;
end;

function TMontarCaixas.fSomaQtdItemNasCaixas(strItemId: String):Double;
Var
  caixa: TCaixa;
begin
  Result := 0;

  For caixa in FCaixas Do
    Result := Result + caixa.fSomaQtdItem(strItemId);
end;

function TMontarCaixas.fGetCaixaAberta: TCaixa;
  Var
    intIndex : Integer;
begin
  Result := nil;
  For intIndex := 0 To Length(FCaixas) -1 Do
  Begin
    If Not FCaixas[intIndex].blnFechada Then
    Begin
      Result := FCaixas[intIndex];
      Break;
    End;
  End;
end;

function TMontarCaixas.fNroCaixasPrefixo(strPrefixCai : String):Integer;
Var
  intIndex : Integer;
begin
  Result := 0;
  For intIndex := 0 To Pred(Length(FCaixas)) Do
  Begin
    If FCaixas[intIndex].FId.Contains(strPrefixCai) Then
      Result := Result + 1;
  End;
end;


function TMontarCaixas.fPesarCaixa(caixa: TCaixa; msgErro: Boolean = True): Double;
begin
  If FLePeso.fConectado(msgErro) Then
    caixa.fltPesoTotal := FLePeso.fltPesoBruto;
  Result := caixa.fltPesoTotal;
end;

function TMontarCaixas.fPesoCaixa(msgErro: Boolean = True): Double;
begin
  Result := 0;
  If FLePeso.fConectado(msgErro) Then
    Result := FLePeso.fltPesoBruto;
end;

function TMontarCaixas.fBalancaConectada: Boolean;
begin
  Result := FLePeso.fConectado;
end;

function TMontarCaixas.fPesoProdCaixa(caixa: TCaixa): Double;
Var
  index: Integer;
  fltPeso: Double;
begin
  fltPeso := 0;

  For index := 0 To Length(caixa.FItens) -1 Do
    fltPeso := fltPeso + (caixa.FItens[index].fltPeso * caixa.FItens[index].fltQuantidade);

  Result := fltPeso;
end;

function TMontarCaixas.fPodeValidarNumeracaoCaixas: Boolean;
begin
  Result := (fCfgSis('MCVEXS', VarString) = 'S') And
            (Not (fCfgSis('CSQCAI', VarString) = '1'));
end;

class function TMontarCaixas.fRetornaDataSetEtiquetaMontagemCaixas(
  const strFgcCaiId: String): TUniClientDataSet;
var
  qryFgoCai : TUniQuery;
  intCols   : Integer;
  fltPeso   : Double;
  strTexto  : String;
  strValue  : String;
  strTextoDes : string;
  strTextoDun : string;
  strValueDes : string;
  strValueDun : string;
  strTextoQuc  : string;
  strValueQuc  : string;

begin
  If fEmptyStr(strFgcCaiId) Then
    Exit(Nil);

  Result := TUniClientDataSet.Create(nil);
  pCriarCamposDataSetEtiquetaMontagemCaixas(Result);
  qryFgoCai := fCriaQuery();
  Try
    qryFgoCai.SQL.Add('SELECT DISTINCT                       ');
    qryFgoCai.SQL.Add('  FC.FGC_FGOINC,                      ');
    qryFgoCai.SQL.Add('  FC.FGC_QUANTD,                      ');
    qryFgoCai.SQL.Add('  FC.FGC_CAI_ID,                      ');
    qryFgoCai.SQL.Add('  FG.FGO_DTAENT,                      ');
    qryFgoCai.SQL.Add('  FG.FGO_NUMDOC,                      ');
    qryFgoCai.SQL.Add('  FG.FGO_ESPDOC,                      ');
    qryFgoCai.SQL.Add('  FG.FGO_CODEMP,                      ');
    qryFgoCai.SQL.Add('  FC.FGC_NUMFAT,                      ');
    qryFgoCai.SQL.Add('  FC.FGC_TIPFAT,                      ');
    qryFgoCai.SQL.Add('  FC.FGC_EMPFAT,                      ');
    qryFgoCai.SQL.Add('  (SELECT                                             ');
    qryFgoCai.SQL.Add('    F1.FDO_CODVEN                                     ');
    qryFgoCai.SQL.Add('  FROM                                                ');
    qryFgoCai.SQL.Add('    FATDOR F1                                         ');
    qryFgoCai.SQL.Add('  WHERE F1.AUTOINCREM = FC.FGC_FDOINC) AS FDO_CODVEN, ');
    qryFgoCai.SQL.Add('  (SELECT                                             ');
    qryFgoCai.SQL.Add('    F2.FDO_CODVE2                                     ');
    qryFgoCai.SQL.Add('  FROM                                                ');
    qryFgoCai.SQL.Add('    FATDOR F2                                         ');
    qryFgoCai.SQL.Add('  WHERE F2.AUTOINCREM = FC.FGC_FDOINC) AS FDO_CODVE2, ');
    qryFgoCai.SQL.Add('  CL.CLI_BAIRRO,                      ');
    qryFgoCai.SQL.Add('  CL.CLI_C_E_P_,                      ');
    qryFgoCai.SQL.Add('  CL.CLI_CODCLI,                      ');
    qryFgoCai.SQL.Add('  CL.CLI_NOMCLI,                      ');
    qryFgoCai.SQL.Add('  CL.CLI_ENDERE,                      ');
    qryFgoCai.SQL.Add('  CL.CLI_ENDNUM,                      ');
    qryFgoCai.SQL.Add('  CL.CLI_ENDCOM,                      ');
    qryFgoCai.SQL.Add('  CL.CLI_CODCID,                      ');
    qryFgoCai.SQL.Add('  CL.CLI_FANSOB,                      ');
    qryFgoCai.SQL.Add('  EX.FDO_NUMCMP,                      ');
    qryFgoCai.SQL.Add('  EG.FGO_SEPEXP,                      ');
    qryFgoCai.SQL.Add('  EG.FGO_OPEEXP,                      ');
    qryFgoCai.SQL.Add('  CR.REG_CODREG,                      ');
    qryFgoCai.SQL.Add('  CR.REG_DESREG,                      ');
    qryFgoCai.SQL.Add('  CT.TRA_NOMTRA,                      ');
    qryFgoCai.SQL.Add('  FC.FGC_DETINC,                      ');
    qryFgoCai.SQL.Add('  FG.FGO_PESBRU,                      ');
    qryFgoCai.SQL.Add('  FD.FDO_QTDITE,                      ');
    qryFgoCai.SQL.Add('  EG.FGO_CODROT,                      ');
    qryFgoCai.SQL.Add('  MC.MCX_ALTURA,                      ');
    qryFgoCai.SQL.Add('  MC.MCX_LARGUR,                      ');
    qryFgoCai.SQL.Add('  MC.MCX_PROFUN,                      ');
    qryFgoCai.SQL.Add('  CD.CID_NOMCID,                      ');
    qryFgoCai.SQL.Add('  CD.CID_ESTADO,                      ');
    qryFgoCai.SQL.Add('  IT.ITE_CODFAB,                      ');
    qryFgoCai.SQL.Add('  FD.FDO_DESCRI,                      ');
    qryFgoCai.SQL.Add('  FD.FDO_CODITE,                      ');
    qryFgoCai.SQL.Add('  OP.OPE_NOMOPE,                      ');
    qryFgoCai.SQL.Add('  OE.OPE_NOMOPE AS NOMEXP,            ');
    qryFgoCai.SQL.Add('  OV.OPE_NOMOPE AS NOMVD1,            ');
    qryFgoCai.SQL.Add('  O2.OPE_NOMOPE AS NOMVD2,            ');
    qryFgoCai.SQL.Add('  FD.FDO_TOTPES,                      ');
    qryFgoCai.SQL.Add('  (SELECT GROUP_CONCAT(CONCAT("-", BR.BAR_CODBAR, "-")) FROM ');
    qryFgoCai.SQL.Add('   ITEBAR BR WHERE IT.ITE_CODITE = BR.BAR_CODITE) AS BAREMB, ');
    qryFgoCai.SQL.Add('  (SELECT COUNT(DISTINCT FCC.FGC_CAI_ID) FROM FGOCAI FCC ');
    qryFgoCai.SQL.Add('    WHERE FCC.FGC_FGOINC = FG.AUTOINCREM) AS TOTAL_CAIXA_PEDIDO, ');
    qryFgoCai.SQL.Add('  FA.INDICADOR,                                      ');
    qryFgoCai.SQL.Add('  (SELECT SUM(TP.FDO_TOTPES) FROM FATDOR TP          ');
    qryFgoCai.SQL.Add('    WHERE TP.FDO_SEQGER = FG.AUTOINCREM) AS PESO_TOTAL_PEDIDO, ');
    qryFgoCai.SQL.Add('  EM.EMP_NOMFAN AS FANEMP,                           ');
    qryFgoCai.SQL.Add('  EM.EMP_NOMEMP AS NOMEMP,                           ');
    qryFgoCai.SQL.Add('  UN.UNI_SIGUNI AS UNIDAD                            ');
    qryFgoCai.SQL.Add(' FROM                                                ');
    qryFgoCai.SQL.Add('   FGOCAI FC                                         ');
    qryFgoCai.SQL.Add('   LEFT JOIN FATDOR FD                               ');
    qryFgoCai.SQL.Add('     ON FD.AUTOINCREM = FC.FGC_FDOINC                ');
    qryFgoCai.SQL.Add('   LEFT JOIN FATGOR FG                               ');
    qryFgoCai.SQL.Add('     ON FG.AUTOINCREM = FD.FDO_SEQGER                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADEMP EM                               ');
    qryFgoCai.SQL.Add('     ON EM.EMP_CODEMP = FD.FDO_CODEMP                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADITE IT                               ');
    qryFgoCai.SQL.Add('     ON IT.ITE_CODITE = FD.FDO_CODITE                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADUNI UN                               ');
    qryFgoCai.SQL.Add('     ON UN.UNI_CODUNI = FD.FDO_UNIDAD                ');
    qryFgoCai.SQL.Add('   LEFT JOIN EXTGOR EG                               ');
    qryFgoCai.SQL.Add('     ON FG.AUTOINCREM = EG.FGO_SEQFGO                ');
    qryFgoCai.SQL.Add('   LEFT JOIN EXTDOR EX                               ');
    qryFgoCai.SQL.Add('     ON EX.FDO_SEQFDO = FD.AUTOINCREM                ');
    qryFgoCai.SQL.Add('   LEFT JOIN ENTREG ER                               ');
    qryFgoCai.SQL.Add('     ON ER.ENT_CODIGO = EG.FGO_CODROT                ');

    If fCfgSis('ROTEMP', varBoolean) Then
      qryFgoCai.SQL.Add(' AND ER.ENT_CODEMP = FG.FGO_CODEMP ');

    qryFgoCai.SQL.Add('   LEFT JOIN CADCLI CL                               ');
    qryFgoCai.SQL.Add('     ON CL.CLI_CODCLI = FG.FGO_CODCLI                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADREG CR                               ');
    qryFgoCai.SQL.Add('     ON CR.REG_CODREG = IFNULL(ER.ENT_CODREG, CL.CLI_CODREG) ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADTRA CT                               ');
    qryFgoCai.SQL.Add('     ON CT.TRA_CODTRA = FG.FGO_CODTRA                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADCID CD                               ');
    qryFgoCai.SQL.Add('     ON CD.CID_CODCID = CL.CLI_CODCID                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADOPE OE                               ');
    qryFgoCai.SQL.Add('     ON OE.OPE_CODOPE = EG.FGO_OPEEXP                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADOPE OV                               ');
    qryFgoCai.SQL.Add('     ON OV.OPE_CODOPE = FD.FDO_CODVEN                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADOPE O2                               ');
    qryFgoCai.SQL.Add('     ON O2.OPE_CODOPE = FD.FDO_CODVE2                ');
    qryFgoCai.SQL.Add('   LEFT JOIN CADOPE OP                               ');
    qryFgoCai.SQL.Add('     ON OP.OPE_CODOPE = EG.FGO_SEPEXP                ');
    qryFgoCai.SQL.Add('   LEFT JOIN MNTCXA MC                               ');
    qryFgoCai.SQL.Add('     ON MC.MCX_CODIGO = FC.FGC_CODMCX                ');
    qryFgoCai.SQL.Add('   LEFT JOIN (SELECT ID.*,                           ');
    qryFgoCai.SQL.Add('                     @INDICADOR := @INDICADOR + 1 AS INDICADOR ');
    qryFgoCai.SQL.Add('                FROM (SELECT DISTINCT                          ');
    qryFgoCai.SQL.Add('                             ID1.FGC_CAI_ID AS CAI_ID,         ');
    qryFgoCai.SQL.Add('                             ID1.FGC_FGOINC                    ');
    qryFgoCai.SQL.Add('                        FROM FGOCAI ID1                        ');
    qryFgoCai.SQL.Add('	               WHERE ID1.FGC_FGOINC IN (SELECT ID2.FGC_FGOINC FROM FGOCAI ID2          ');
    qryFgoCai.SQL.Add('	                                         WHERE ID2.FGC_CAI_ID = :CAI_ID)) ID,          ');
    qryFgoCai.SQL.Add('                     (SELECT @INDICADOR := 0) AS LINHA) FA ON FA.CAI_ID = FC.FGC_CAI_ID ');
    qryFgoCai.SQL.Add('  WHERE FC.FGC_CAI_ID = :CAI_ID                      ');
    qryFgoCai.SQL.Add('  ORDER BY FC.FGC_CAI_ID                             ');

    qryFgoCai.ParamByName('CAI_ID').AsString := strFgcCaiId;
    qryFgoCai.Open;

    Result.Append;
    Result.FieldByName('CAIXA').AsString   := Copy(qryFgoCai.FieldByName('FGC_CAI_ID').AsString,
                                                     Pos('-', qryFgoCai.FieldByName('FGC_CAI_ID').AsString) + 1,
                                                     3);
    Result.FieldByName('PEDIDO').AsString  := qryFgoCai.FieldByName('FGO_NUMDOC').AsString
                                            + '-'
                                            + qryFgoCai.FieldByName('FGO_ESPDOC').AsString
                                            + '-'
                                            + qryFgoCai.FieldByName('FGO_CODEMP').AsString;
    Result.FieldByName('CLIENTE').AsString := qryFgoCai.FieldByName('CLI_CODCLI').AsString;
    (* CAMPOS LAYOUT 165 *)
    Result.FieldByName('NOMROT').AsString  := qryFgoCai.FieldByName('FGO_CODROT').AsString;
    Result.FieldByName('DTAROT').AsString  := qryFgoCai.FieldByName('FGO_DTAENT').AsString;
    Result.FieldByName('NOMTRA').AsString  := qryFgoCai.FieldByName('TRA_NOMTRA').AsString;
    Result.FieldByName('NOMCLI').AsString  := qryFgoCai.FieldByName('CLI_NOMCLI').AsString;
    Result.FieldByName('NOMCID').AsString  := qryFgoCai.FieldByName('CID_NOMCID').AsString;
    Result.FieldByName('NUMPED').AsString  := qryFgoCai.FieldByName('FGO_NUMDOC').AsString;
    Result.FieldByName('NOMSEP').AsString  := qryFgoCai.FieldByName('FGO_SEPEXP').AsString
                                            + '-'
                                            + qryFgoCai.FieldByName('OPE_NOMOPE').AsString;
    Result.FieldByName('NOMCNF').AsString  := qryFgoCai.FieldByName('FGO_OPEEXP').AsString
                                            + '-'
                                            + qryFgoCai.FieldByName('NOMEXP').AsString;
    Result.FieldByName('NOMVD1').AsString  := qryFgoCai.FieldByName('NOMVD1').AsString;
    Result.FieldByName('NOMVD2').AsString  := qryFgoCai.FieldByName('NOMVD2').AsString;
    Result.FieldByName('NUMVOL').AsString  := qryFgoCai.RecordCount.ToString;
    Result.FieldByName('CODBAR').AsString  := qryFgoCai.FieldByName('BAREMB').AsString;
    Result.FieldByName('LSTITE').AsString  := Result.FieldByName('PEDIDO').AsString;
    Result.FieldByName('CLICOD').AsString  := qryFgoCai.FieldByName('CLI_CODCLI').AsString;
    Result.FieldByName('CODOPE').AsString  := strLoginUsuarioLogado;
    Result.FieldByName('NOMOPE').AsString  := fRetNomeOperador(strLoginUsuarioLogado);
    Result.FieldByName('TCAXFE').AsString  := FormatFloat('00/', qryFgoCai.FieldByName('INDICADOR').AsInteger) + FormatFloat('00', qryFgoCai.FieldByName('TOTAL_CAIXA_PEDIDO').AsInteger);
    Result.FieldByName('BAICLI').AsString  := qryFgoCai.FieldByName('CLI_BAIRRO').AsString;
    Result.FieldByName('CEPCLI').AsString  := qryFgoCai.FieldByName('CLI_C_E_P_').AsString;
    Result.FieldByName('CIDCLI').AsString  := qryFgoCai.FieldByName('CID_NOMCID').AsString;
    Result.FieldByName('ENDCLI').AsString  := qryFgoCai.FieldByName('CLI_ENDERE').AsString + ', '
                                            + qryFgoCai.FieldByName('CLI_ENDNUM').AsString + '- '
                                            + qryFgoCai.FieldByName('CLI_ENDCOM').AsString;
    Result.FieldByName('ESTCLI').AsString  := qryFgoCai.FieldByName('CID_ESTADO').AsString;
    Result.FieldByName('FANSOB').AsString  := qryFgoCai.FieldByName('CLI_FANSOB').AsString;
    Result.FieldByName('NUMDOC').AsString  := qryFgoCai.FieldByName('FGO_NUMDOC').AsString;
    Result.FieldByName('NUMCMP').AsString  := qryFgoCai.FieldByName('FDO_NUMCMP').AsString;
    Result.FieldByName('CODROT').AsString  := qryFgoCai.FieldByName('FGO_CODROT').AsString;
    Result.FieldByName('CODFAB').AsString  := qryFgoCai.FieldByName('ITE_CODFAB').AsString;

    Result.FieldByName('ALTURA').AsString       := qryFgoCai.FieldByName('MCX_ALTURA').AsString;
    Result.FieldByName('LARGURA').AsString      := qryFgoCai.FieldByName('MCX_LARGUR').AsString;
    Result.FieldByName('PROFUNDIDADE').AsString := qryFgoCai.FieldByName('MCX_PROFUN').AsString;

    Result.FieldByName('CODREG').AsString := qryFgoCai.FieldByName('REG_CODREG').AsString;
    Result.FieldByName('DESREG').AsString := qryFgoCai.FieldByName('REG_DESREG').AsString;

    Result.FieldByName('FANEMP').AsString := qryFgoCai.FieldByName('FANEMP').AsString;
    Result.FieldByName('NOMEMP').AsString := qryFgoCai.FieldByName('NOMEMP').AsString;

    intCols  := 1;
    fltPeso  := 0;
    strValue := StringOfChar(' ' , 54);
    strTexto := EmptyStr;
    While Not qryFgoCai.Eof Do
    Begin
      fltPeso := fltPeso
               + (qryFgoCai.FieldByName('FDO_TOTPES').AsFloat
               /  qryFgoCai.FieldByName('FDO_QTDITE').AsFloat
               *  qryFgoCai.FieldByName('FGC_QUANTD').AsFloat);

      If intCols = 4 Then
        intCols:= 1;

      insert(fPadL(FormatFloat('##0', qryFgoCai.FieldByName('FGC_QUANTD').AsFloat), 4), strValue, Trunc(IIF(intCols = 1, 1, (intCols-1)*18)));
      insert(Copy(fPadR(qryFgoCai.FieldByName('ITE_CODFAB').AsString, 13), 1 , 13) , strValue, Trunc((IIF(intCols = 1, 1, (intCols-1)*18) + 5)));
      strValue := Copy(strValue, 1, 54);

      strValueDes := FormatFloat('##0', qryFgoCai.FieldByName('FGC_QUANTD').AsFloat) + ' - ' +
                     qryFgoCai.FieldByName('FDO_CODITE').AsString + ' - ' +
                     qryFgoCai.FieldByName('FDO_DESCRI').AsString;
      strValueDes := Copy(strTextoDes, 1, 54);
      strValueDes := strTextoDes + #13;
      strTextoDes := strTextoDes + strValueDes;

      strValueDun := FormatFloat('##0', qryFgoCai.FieldByName('FGC_QUANTD').AsFloat) + ' - ' +
                     qryFgoCai.FieldByName('FDO_CODITE').AsString + ' - ' +
                     qryFgoCai.FieldByName('FDO_DESCRI').AsString + ' - ' +
                     qryFgoCai.FieldByName('UNIDAD').AsString ;

      strValueDun := strValueDun + #13;
      strTextoDun := strTextoDun + strValueDun;

      strValueQuc := FormatFloat('##0', qryFgoCai.FieldByName('FGC_QUANTD').AsFloat) + ' - ' +
                     qryFgoCai.FieldByName('UNIDAD').AsString + ' - ' +
                     qryFgoCai.FieldByName('FDO_CODITE').AsString + ' - ' +
                     qryFgoCai.FieldByName('FDO_DESCRI').AsString ;

      strValueQuc := strValueQuc + #13;
      strTextoQuc := strTextoQuc + strValueQuc;

      qryFgoCai.Next;

      Inc(intCols);
      If intCols = 4 Then
      Begin
        strTexto := strTexto + strValue + #13;
        strValue := StringOfChar(' ' , 54);
      End;
    End;

    If intCols < 4 Then
      strTexto := strTexto + strValue;

    Result.FieldByName('LSTFAB').AsString  := strTexto;
    Result.FieldByName('LSTDES').AsString  := strTextoDes;
    Result.FieldByName('LSTDUN').AsString  := strTextoDun;
    Result.FieldByName('LSTQUC').AsString  := strTextoQuc;
    Result.FieldByName('PESO').AsString    := FormatFloat(',0.00', fltPeso);
    Result.FieldByName('TOTPES').AsString  := Result.FieldByName('PESO').AsString;
    Result.FieldByName('PESPED').AsString  := FormatFloat(',0.00', qryFgoCai.FieldByName('PESO_TOTAL_PEDIDO').AsFloat);

    Result.Post;
  Finally
    FreeAndNil(qryFgoCai);
  End;
end;

function TMontarCaixas.fValidarNumeracaoCaixas: Boolean;
  Var
    intIndex : Integer;
    objCaixa: TCaixa;
    stlPedidos: TStringList;
    strPedido: String;
begin
  Result := True;

  If (Not fPodeValidarNumeracaoCaixas) Then
    Exit;

  stlPedidos := TStringList.Create;

  Try
    For objCaixa in FCaixas Do
    Begin
      strPedido := Copy(objCaixa.strID, 1, 12);
      If (stlPedidos.IndexOf(strPedido) < 0) Then
        stlPedidos.Add(strPedido);
    End;

    For intIndex := 0 To PRed(stlPedidos.Count) Do
      Result := Result And Self.fValidarNumeracaoCaixasPedido(stlPedidos[intIndex]);
  Finally
    FreeAndNil(stlPedidos);
  End;
end;

function TMontarCaixas.fValidarNumeracaoCaixasPedido(const strNumPed: String): Boolean;
var
  objCaixa: TCaixa;
  intQtd: Integer;
  intMax: Integer;
  intMin: Integer;
  intIdCaixa: Integer;
begin
  Result := True;

  If (Not fPodeValidarNumeracaoCaixas) Then
    Exit;

  intQtd := 0;
  intMax := Integer.MinValue;
  intMin := Integer.MaxValue;

  For objCaixa in FCaixas Do
  Begin
    If (Not (Copy(objCaixa.strID, 1, 12) = strNumPed)) Then
      Continue;

    Inc(intQtd);

    intIdCaixa := StrToIntDef(Copy(objCaixa.strID, 14, 3), -1);

    If (intIdCaixa < intMin) then
      intMin := intIdCaixa;

    If (intIdCaixa > intMax) then
      intMax := intIdCaixa;
  End;

  If (intQtd = 1) Then
    Result := (intMax = 1) And (intMin = 1)
  Else if (intQtd > 1) then
    Result := (intMin = 1) And (intQtd = (1 + intMax - intMin));
end;

procedure TMontarCaixas.pAbreCaixa(strID: String);
begin
  If CaixaAberta = Nil Then
  Begin
    If fBuscaCaixa(strID) <> Nil Then
      fBuscaCaixa(strID).pAbreCaixa;

  End
  Else
    Raise ExceptionAutCom.Create('Já existe uma caixa aberta!');

end;

procedure TMontarCaixas.pCancelarMontagemCaixa;
begin
  If fGetCaixaAberta <> nil Then
  Begin
    If Not FCaixas[Length(FCaixas) - 1].blnFechada Then
    Begin
      FCaixas[Length(FCaixas) - 1].Destroy;
      SetLength(FCaixas, Length(FCaixas) - 1);
    End;
  End
  Else
    Raise ExceptionAutCom.Create('Não há caixa em montagem para ser cancelada!');
end;

class procedure TMontarCaixas.pCriarCamposDataSetEtiquetaMontagemCaixas(
  const cdsCaixas: TUniClientDataSet);
begin
  With cdsCaixas, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'CAIXA';   DataType := ftString; Size := 0017; Required := False; End;
    With AddFieldDef Do Begin Name := 'PESO';    DataType := ftString; Size := 0015; Required := False; End;
    With AddFieldDef Do Begin Name := 'PEDIDO';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'CLIENTE'; DataType := ftString; Size := 0100; Required := False; End;
    (* CAMPOS LAYOUT 165 *)
    With AddFieldDef Do Begin Name := 'NOMROT';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'DTAROT';  DataType := ftString; Size := 0005; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMTRA';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMCLI';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMCID';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'TOTPES';  DataType := ftString; Size := 0015; Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMPED';  DataType := ftString; Size := 0012; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMSEP';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMCNF';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMVD1';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMVD2';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMVOL';  DataType := ftString; Size := 0015; Required := False; End;
    With AddFieldDef Do Begin Name := 'TOTVOL';  DataType := ftString; Size := 0015; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODBAR';  DataType := ftString; Size := 0012; Required := False; End;
    With AddFieldDef Do Begin Name := 'LSTITE';  DataType := ftString; Size := 2000; Required := False; End;
    With AddFieldDef Do Begin Name := 'CLICOD';  DataType := ftString; Size := 0008; Required := False; End;
    With AddFieldDef Do Begin Name := 'PESPED';  DataType := ftString; Size := 0015; Required := False; End;

    With AddFieldDef Do Begin Name := 'CODOPE';  DataType := ftString; Size := 0003; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMOPE';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'TCAXFE';  DataType := ftString; Size := 0015; Required := False; End;

    With AddFieldDef Do Begin Name := 'BAICLI';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'CEPCLI';  DataType := ftString; Size := 0008; Required := False; End;
    With AddFieldDef Do Begin Name := 'CIDCLI';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODFAB';  DataType := ftString; Size := 0025; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDCLI';  DataType := ftString; Size := 0200; Required := False; End;
    With AddFieldDef Do Begin Name := 'ESTCLI';  DataType := ftString; Size := 0002; Required := False; End;

    With AddFieldDef Do Begin Name := 'BAIENT';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'CEPENT';  DataType := ftString; Size := 0008; Required := False; End;
    With AddFieldDef Do Begin Name := 'CIDENT';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDENT';  DataType := ftString; Size := 0200; Required := False; End;
    With AddFieldDef Do Begin Name := 'ESTENT';  DataType := ftString; Size := 0002; Required := False; End;

    With AddFieldDef Do Begin Name := 'FANSOB';  DataType := ftString; Size := 0100; Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMDOC';  DataType := ftString; Size := 0012; Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMCMP';  DataType := ftString; Size := 0015; Required := False; End;
    With AddFieldDef Do Begin Name := 'LSTFAB';  DataType := ftString; Size := 2000; Required := False; End;
    With AddFieldDef Do Begin Name := 'LSTDES';  DataType := ftString; Size := 2000; Required := False; End;
    With AddFieldDef Do Begin Name := 'LSTDUN';  DataType := ftString; Size := 2000; Required := False; End;
    With AddFieldDef Do Begin Name := 'LSTQUC';  DataType := ftString; Size := 2000; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODROT';  DataType := ftString; Size := 0005; Required := False; End;

    With AddFieldDef Do Begin Name := 'ALTURA';       DataType := ftString; Size := 0015; Required := False; End;
    With AddFieldDef Do Begin Name := 'LARGURA';      DataType := ftString; Size := 0015; Required := False; End;
    With AddFieldDef Do Begin Name := 'PROFUNDIDADE'; DataType := ftString; Size := 0015; Required := False; End;

    With AddFieldDef Do Begin Name := 'CODREG';  DataType := ftString; Size := 0008; Required := False; End;
    With AddFieldDef Do Begin Name := 'DESREG';  DataType := ftString; Size := 0100; Required := False; End;

    With AddFieldDef Do Begin Name := 'CAI_ID';  DataType := ftString; Size := 0005; Required := False; End;

    With AddFieldDef Do Begin Name := 'FANEMP';  DataType := ftString; Size := 0060; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMEMP';  DataType := ftString; Size := 0060; Required := False; End;

    CreateDataSet;
    Open;

    EmptyDataSet;

    Filter   := EmptyStr;
    Filtered := False;
  End;
end;

procedure TMontarCaixas.pFecharCaixa;
begin
  If fGetCaixaAberta <> nil Then
    fGetCaixaAberta.pFecharCaixa
  Else
    Raise ExceptionAutCom.Create('Não há caixa para ser fechada!');
end;

procedure TMontarCaixas.pNovaCaixa(id : String = ''; strCodBar: String = '');
begin
  If fGetCaixaAberta <> nil Then
    Raise ExceptionAutCom.Create('Ainda há uma caixa para ser fechada!');

  SetLength(FCaixas, Length(FCaixas) + 1);
  FCaixas[Length(FCaixas) - 1] := TCaixa.Create(id, strCodBar);
end;

end.
