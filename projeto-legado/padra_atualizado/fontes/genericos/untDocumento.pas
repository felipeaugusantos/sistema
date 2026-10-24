unit untDocumento;

interface

uses StrUtils, SysUtils, Uni, untFuncoesSimples, untTypesSistema, Forms,
     untBoleto, untLiberacao, untMsgLiberacao, untCadRec, untAlteraVencimento,
     Data.DB, untLibNfe, untReimpressao, untIDocumento,
     Printers, untPontosImpressao, Vcl.Controls, Winapi.ShellAPI, Winapi.Windows, System.IOUtils;

Type
  TDocumento = class(TInterfacedObject, IDocumento)
  private
    qryDuplic: TUniQuery;
    FAutInc: String;
    arrDupSel : TArrDupSel;
    objLiberacao : TLiberacao;
    objMsg : TMensagemLiberacao;
    FVencimentoAlterado: Boolean;
    FJurosSujerido     : Double;
    FValorCorrigido    : Double;
    FVencimento: TDateTime;
    function fGetDuplicata(blnApenasTitulosEmAberto: Boolean) : Boolean;
    procedure pAdicionarDuplicataVencidaTrava;
    function fTravaDuplicatasVencidas(arrDups: TArrDupSel): Boolean;
    function fAlteraVencimento: Boolean;
    function fGerarPDFDanfe: Boolean;
    procedure pVisualizarPDFGerado(strArquivo: String);
    function VerificaDireitoAcesso(ADirAce: String): Boolean;
    function fFormataAutInc(strAutInc : String) : String;
    function fImprimeBoletoInterna(strAutInc: String; blnPerguntarSaidaVideoImpressao : Boolean; blnApenasGerarPDF : Boolean): Boolean;
  public
    procedure pImprimeNotaFiscal(strAutInc: String; blnValidarDireitoAcesso: Boolean = True);
    function fImprimeBoleto(strAutInc: String): Boolean;
    function fTemBoleto: Boolean;
    function fGetVencimentoAlterado: Boolean;
    function fGetJurosSugerido: Double;
    function fGetVencimento: TDateTime;
    function fGetValorCorrigido: Double;
    function fEhEmissaoDeNotaDeServicoPeloNfeImpressao: boolean;
    function fEhEmissaoDeNotaDeProdutoPeloNfeImpressao: boolean;
    function fEhEmissaoDeCupomFiscalPeloNfeImpressao: boolean;
    procedure pChamaAnexos(strAutInc, strCodCli, strCodEmp : String);
    function fGerarPDFBoleto(strAutInc: String): Boolean;
    Constructor Create;
    Destructor Destroy; override;
  end;


implementation

uses
  untCfgRel, untQckFatImpNFCe, untGravaArquivoPasta, untFuncoesGenerica;

{ TDocumento }

constructor TDocumento.Create;
begin
  FVencimentoAlterado := False;
  FJurosSujerido      := 0;
  FVencimento         := 0;
  FValorCorrigido     := 0;
  objLiberacao := TLiberacao.Create;
  objMsg       := TMensagemLiberacao.Create(Application);
end;

function TDocumento.fGerarPDFBoleto(strAutInc: String): Boolean;
begin
  Result := fImprimeBoletoInterna(strAutInc, False, True);
end;


function TDocumento.fImprimeBoletoInterna(strAutInc: String; blnPerguntarSaidaVideoImpressao : Boolean; blnApenasGerarPDF : Boolean): Boolean;
  Var
    objDuplic: TArrDupCtr;
    LApenasReimpressao,
    blnPreview,
    blnReimprime,
    blnProrrogado: Boolean;
    strHistorico,
    strBoletoImpresso: String;
    fltDesSuj: Double;
    intContador: Integer;
begin
  Result := False;

  FAutInc := strAutInc;

  If Not fGetDuplicata(True) Then
    Exit;

  blnReimprime  := fTemBoleto;
  blnProrrogado := False;
  LApenasReimpressao    := False;
  blnPreview := False;
  FVencimentoAlterado := False;

  If qryDuplic.FieldByName('CTR_VALDUP').AsFloat < 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse tipo de duplicata não emite boleto!', ['&Ok']);
    Exit;
  End;

  SetLength(arrLogLib, 0);

  If (Not fVerificaAcessoSistema('frmImpBoletosIndiv')) Then
  Begin

    If blnReimprime Then
    Begin
      If (Not fVerificaAcessoSistema('PERIMPSPRV')) Then
      Begin
        fMensagem('Atenção', 'Este operador não tem permissão para reimpressão de boletos!', ['&Ok']);
        Exit;
      End;
      LApenasReimpressao := True;
      blnPreview :=  fVerificaAcessoSistema('PERIMPBOLVIDEO');
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Este operador não tem permissão para impressão de boletos!', ['&Ok']);
      Exit;
    End;
  End;

  If (qryDuplic.FieldByName('CTR_VALDUP').AsFloat = 0) And
     (Not qryDuplic.FieldByName('CTR_DTAREC').IsNull) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta operação só está disponível para títulos em aberto!', ['&Ok']);
    Exit;
  End;

  If qryDuplic.FieldByName('POR_IMPBOL').AsString = 'N' Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido impressão de boletos para esse portador!', ['&O k']);
    Exit;
  End;

  Try
    If qryDuplic.FieldByName('CTR_DTAVEN').AsDateTime < VS_Date Then
    Begin
      pAdicionarDuplicataVencidaTrava;
      If (Not fTravaDuplicatasVencidas(arrDupSel)) Then
      Begin
        If (fCfgSis('CTRDTA', varBoolean) = True) And
           (fMensagem('', 'Deseja alterar a data de vencimento?', ['&Sim', '&Não'], 2) = 1) Then
        Begin
          If Not fAlteraVencimento() Then
            Exit;
        End;
      End
      Else
        Exit;
    End;

    If FVencimentoAlterado Then
    Begin
      blnProrrogado := True;
      strHistorico := qryDuplic.FieldByName('CTR_HIST01').AsString;
      strHistorico := strHistorico + #13 +
                      'Em ' + DateToStr(VS_Date) + ', ocorreu prorrogação do vencimento. ' +
                      'Operador: ' + strLoginUsuarioLogado + #13 +
                      'Vencimento Original: ' + qryDuplic.FieldByName('CTR_DTAVEN').AsString + ' - ' +
                      'Vr.Original: ' + FormatFloat('#,##0.00', qryDuplic.FieldByName('CTR_VALDUP').AsFloat) + #13 +
                      'Novo Vencimento    : ' + FormatDateTime('dd/mm/yyyy', FVencimento) + ' - ' +
                      'Novo Valor : ' + FormatFloat('#,##0.00', FValorCorrigido);
      strHistorico := strHistorico + #13 + 'Juros alterado de ' +
                      FormatFloat('#,##0.00', qryDuplic.FieldByName('CTR_JURSUJ').AsFloat) + ' para ' +
                      FormatFloat('#,##0.00', FJurosSujerido) +
                      ' por motivo de prorrogação do vencimento.' + #13;

      If qryDuplic.FieldByName('CTR_DESSUJ').AsFloat <> 0 Then
      Begin
        If (fCfgSis('UTDEFN') = '1') Then
          fltDesSuj := qryDuplic.FieldByName('CTR_DESSUJ').AsFloat
        Else
        Begin
          strHistorico := strHistorico + 'Desconto alterado de ' +
                          FormatFloat('#,##0.00', qryDuplic.FieldByName('CTR_DESSUJ').AsFloat) +
                          ' para 0,00 por motivo de prorrogação do vencimento.' + #13;

          fltDesSuj := 0.0;
        End;
      End
      Else
        fltDesSuj := 0.0;

      If Not fGravaVencimento(FVencimento,
                              fltDesSuj,
                              FJurosSujerido,
                              strHistorico,
                              FAutInc,
                              'TDocumento.fImprimeBoleto') Then
        Raise Exception.Create('Não foi possível fazer a gravação do novo vencimento e acréscimos! Tente Novamente!');
    End;

    If (blnReimprime) And (Not blnProrrogado) And (blnPerguntarSaidaVideoImpressao) Then
    Begin
      If Not LApenasReimpressao Then
      Begin
        blnPreview := fMensagem('','Opção:',['&Vídeo','Impressão']) = 1;
      End;
    End;

    If (blnApenasGerarPDF) And (Not blnPerguntarSaidaVideoImpressao) Then
      blnPreview := True;

    If blnReimprime And (Not blnPreview) And (Not LApenasReimpressao) Then
    Begin
      objLiberacao.Clear;
      objMsg.Clear;
      objMsg.pAddTexto('Existe(m) boleto(s) já impresso(s)');
      strBoletoImpresso := IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_NUMDUP').AsString),'', ' Duplicata: ' + qryDuplic.FieldByName('CTR_NUMDUP').AsString + ' ') +
      IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_CODEMP').AsString),'', ' Emp: ' + qryDuplic.FieldByName('CTR_CODEMP').AsString + ' ') +
      IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_BCOBOL').AsString),'', ' Banco: ' + qryDuplic.FieldByName('CTR_BCOBOL').AsString + ' ') +
      IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_BCOBOL').AsString),'', ' Carteira: ' + qryDuplic.FieldByName('CTR_CARTEI').AsString + ' ') +
      IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_NOSNUM').AsString),'', ' Nosso Núm: ' + qryDuplic.FieldByName('CTR_NOSNUM').AsString + ' ');

      objMsg.pAddTexto(strBoletoImpresso);

      objLiberacao.objMsgLibera.fGetObjectFromJson(objMsg.fGetJsonObject.ToJSON);
      objLiberacao.strDirAce := 'REIBOL';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;

      objLiberacao.pInformaNumDocEspDocCodEmp(qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                                              EmptyStr,
                                              qryDuplic.FieldByName('CTR_CODEMP').AsString);

      If Not objLiberacao.fLibera Then
        Exit;
    End;

    SetLength(objDuplic, qryDuplic.RecordCount);
    qryDuplic.First;
    For intContador := 0 To Pred(qryDuplic.RecordCount) Do
    Begin
      objDuplic[intContador].strNumDup := qryDuplic.FieldByName('CTR_NUMDUP').AsString;
      objDuplic[intContador].strParcel := qryDuplic.FieldByName('CTR_PARCEL').AsString;
      objDuplic[intContador].strCodEmp := qryDuplic.FieldByName('CTR_CODEMP').AsString;
      objDuplic[intContador].strEspDoc := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
      objDuplic[intContador].strCodCli := qryDuplic.FieldByName('CTR_CODCLI').AsString;
      objDuplic[intContador].strAutoIn := qryDuplic.FieldByName('AUTOINCREM').AsString;;
      qryDuplic.Next
    End;

    TBoleto.pAtualizaBoleto(objDuplic, blnReimprime, blnProrrogado, blnPreview, blnApenasGerarPDF);

    If fTemBoleto Then
    Begin
      Result := True;
      pGeraLogLiberacao(qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                        qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                        qryDuplic.FieldByName('CTR_CODEMP').AsString);
    End;

    SetLength(objDuplic, 0);
  Except
    On E: ExceptionAutcom Do
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);

    On E: Exception Do
      fMensagem('ATENÇÃO!', 'Ocorreu um erro ao consultar o boleto da duplicata selecionada:' + #13 + E.Message, ['&Ok']);
  End;
end;

function TDocumento.fGerarPDFDanfe: Boolean;
var
  strAcesso: String;
  libNfe: TLibNfe;
  blnPodeGerarPdfDocumento: Boolean;
  strDirCompleto : String;
  srtNfeImpressaoExe: String;
  LDiretorioDanfe: String;

begin
  inherited;
  Result := False;

  blnPodeGerarPdfDocumento := (Pos(qryDuplic.FieldByName('CTR_ESPDOC').AsString, 'NF_NS_CT_IF') > 0);

  If not blnPodeGerarPdfDocumento Then
    Exit;

  strAcesso := fRetornaChaveAcesso(qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                                   qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                                   qryDuplic.FieldByName('CTR_CODEMP').AsString,
                                   qryDuplic.FieldByName('CTR_CODCLI').AsString,
                                   qryDuplic.FieldByName('GER_SERIE_').AsString,
                                   'C');

  If fEmptyStr(strAcesso) Then
    Exit;

  If Not fRefazLogNfeCasoExcluido(strAcesso) Then
    Exit;

  LDiretorioDanfe := fRetornaDiretorioDanfe;

  Try
    If Not DirectoryExists(LDiretorioDanfe) Then
      CreateDir(LDiretorioDanfe);

    strDirCompleto := LDiretorioDanfe + 'Tela' + strAcesso + '.pdf';

    If (qryDuplic.FieldByName('CTR_ESPDOC').AsString = 'IF') And (Not fCfgSis('PRNFCE', varBoolean)) Then
    Begin
      pImprimirNFCe(qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                    qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                    qryDuplic.FieldByName('CTR_CODEMP').AsString,
                    qryDuplic.FieldByName('CTR_CODCLI').AsString,
                    qryDuplic.FieldByName('GER_SERIE_').AsString,
                    'C',
                    '',
                    False,
                    True,
                    True{PDF});
      Exit(True);
    End;

    If fCfgSis('CITINF', varBoolean) Then
    Begin
      srtNfeImpressaoExe :=  TImpressaoDiretaCitel.fRetNomeNfeImprimirExeCitel;
      If Not FileExists(srtNfeImpressaoExe) Then
      Begin
        fMensagem('', 'Não foi encontrado o arquivo NFeImpressao.exe para a impressão.' + #13#10 +
                      'Arquivo informado:' + srtNfeImpressaoExe, ['&O k']);
        Exit;
      End;
    End;

    If (fEhEmissaoDeNotaDeServicoPeloNfeImpressao or fEhEmissaoDeNotaDeProdutoPeloNfeImpressao or fEhEmissaoDeCupomFiscalPeloNfeImpressao) Then
    Begin
      If (fEhEmissaoDeNotaDeServicoPeloNfeImpressao) Then
        TImpressaoDiretaCitel.pImprimirPDF(qryDuplic.FieldByName('CTR_CODEMP').AsString,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFS',
                                           True,
                                           strDirCompleto,
                                           False)

      Else If (fEhEmissaoDeCupomFiscalPeloNfeImpressao) Then
        TImpressaoDiretaCitel.pImprimirPDF(qryDuplic.FieldByName('CTR_CODEMP').AsString,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFCE',
                                           True,
                                           strDirCompleto,
                                           False)
      Else
        TImpressaoDiretaCitel.pImprimirPDF(qryDuplic.FieldByName('CTR_CODEMP').AsString,
                                           TCfgRel.fGetImpressoraSelecionada,
                                           strAcesso,
                                           'NFE',
                                           True,
                                           strDirCompleto,
                                           False);
    End
    Else
    Begin
      libNfe := TLibNfe.Create(VS_strCodEmp);
      Try
        if qryDuplic.FieldByName('CTR_ESPDOC').AsString = 'CT' then
          libNfe.pReimprimirConhecimentoEletronico(
            Copy(qryDuplic.FieldByName('CTR_NUMDUP').AsString, 4, 9),
            'ImpressaoEmTelaPDF')
        else
          libNfe.pReimprimirDanfe(strAcesso, '', qryDuplic.FieldByName('GER_SERIE_').AsString, 'TelaPDF');
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TDocumento.fGerarPDFDanfe]');
        End;
      End;
      FreeAndNil(libNfe);
    End;

    repeat
    until FileExists(strDirCompleto);

    pVisualizarPDFGerado(strDirCompleto);

    Result := True;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TDocumento.fGerarPDFDanfe]');
  End;
end;

function TDocumento.fFormataAutInc(strAutInc : String) : String;
var
  chrLetra: Char;
begin
  Result := '"';
  For chrLetra In strAutInc Do
  Begin
    If chrLetra <> ',' Then
      Result := Result + chrLetra
    Else
      Result := Result + '"' + chrLetra + '"';
  End;
  Result :=  Result + '"';
end;

function TDocumento.fGetDuplicata(blnApenasTitulosEmAberto: Boolean): Boolean;
begin
  Result := False;

  If Not Assigned(qryDuplic) Then
    qryDuplic := fCriaQuery;

  Try
    qryDuplic.Close;
    qryDuplic.SQL.Clear;
    qryDuplic.SQL.Add('SELECT ');
    qryDuplic.SQL.Add('  POR_IMPBOL, ');
    qryDuplic.SQL.Add('  IFNULL(N.GER_SERIE_, M.GER_SERIE_) AS GER_SERIE_, ');
    qryDuplic.SQL.Add('  IFNULL(N.GER_NUMDOC, M.GER_NUMDOC) AS GER_NUMDOC, C.* ');
    qryDuplic.SQL.Add('FROM CADREC C ');
    qryDuplic.SQL.Add('  LEFT JOIN MOVGER M ON M.GER_NUMDOC = CTR_NUMDUP AND ');
    qryDuplic.SQL.Add('                        M.GER_ESPDOC = CTR_ESPDOC AND ');
    qryDuplic.SQL.Add('                        M.GER_CODEMP = CTR_CODEMP AND ');
    qryDuplic.SQL.Add('                        M.GER_CODCLI = CTR_CODCLI     ');
    qryDuplic.SQL.Add('  LEFT JOIN NOTGER N ON N.GER_NUMDOC = CTR_NUMDUP AND ');
    qryDuplic.SQL.Add('                        N.GER_ESPDOC = CTR_ESPDOC AND ');
    qryDuplic.SQL.Add('                        N.GER_CODEMP = CTR_CODEMP AND ');
    qryDuplic.SQL.Add('                        N.GER_CODCLI = CTR_CODCLI ');
    qryDuplic.SQL.Add('  LEFT JOIN CADPOR ON POR_CODPOR = CTR_CODPOR ');
    qryDuplic.SQL.Add('WHERE C.AUTOINCREM IN('+fFormataAutInc(FAutInc)+') ');
    if blnApenasTitulosEmAberto then
      qryDuplic.SQL.Add(' AND CTR_VALDUP > 0.00 AND CTR_DTAREC IS NULL ');
    qryDuplic.Open;

    Result := Not qryDuplic.IsEmpty;
  Except

  End;
end;

function TDocumento.fGetJurosSugerido: Double;
begin
  Result := FJurosSujerido;
end;

function TDocumento.fImprimeBoleto(strAutInc: String): Boolean;
var
  objDuplic: TArrDupCtr;
  LApenasReimpressao,
  blnPreview,
  blnReimprime,
  blnProrrogado: Boolean;
    strHistorico,
    strBoletoImpresso: String;
    fltDesSuj: Double;
    intContador: Integer;
begin
  Result := False;

  FAutInc := strAutInc;

  If Not fGetDuplicata(True) Then
    Exit;

  blnReimprime  := fTemBoleto;
  blnProrrogado := False;
  LApenasReimpressao    := False;
  blnPreview := False;
  FVencimentoAlterado := False;

  If qryDuplic.FieldByName('CTR_VALDUP').AsFloat < 0 Then
  Begin
    fMensagem('ATENÇÃO!', 'Esse tipo de duplicata não emite boleto!', ['&Ok']);
    Exit;
  End;

  SetLength(arrLogLib, 0);

  If (Not fVerificaAcessoSistema('frmImpBoletosIndiv')) Then
  Begin

    If blnReimprime Then
    Begin
      If (Not fVerificaAcessoSistema('PERIMPSPRV')) Then
      Begin
        fMensagem('Atenção', 'Este operador não tem permissão para reimpressão de boletos!', ['&Ok']);
        Exit;
      End;
      LApenasReimpressao := True;
      blnPreview :=  fVerificaAcessoSistema('PERIMPBOLVIDEO');
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Este operador não tem permissão para impressão de boletos!', ['&Ok']);
      Exit;
    End;
  End;

  If (qryDuplic.FieldByName('CTR_VALDUP').AsFloat = 0) And
     (Not qryDuplic.FieldByName('CTR_DTAREC').IsNull) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta operação só está disponível para títulos em aberto!', ['&Ok']);
    Exit;
  End;

  If qryDuplic.FieldByName('POR_IMPBOL').AsString = 'N' Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido impressão de boletos para esse portador!', ['&O k']);
    Exit;
  End;

  Try
    If qryDuplic.FieldByName('CTR_DTAVEN').AsDateTime < VS_Date Then
    Begin
      pAdicionarDuplicataVencidaTrava;
      If (Not fTravaDuplicatasVencidas(arrDupSel)) Then
      Begin
        If (fCfgSis('CTRDTA', varBoolean) = True) And
           (fMensagem('', 'Deseja alterar a data de vencimento?', ['&Sim', '&Não'], 2) = 1) Then
        Begin
          If Not fAlteraVencimento() Then
            Exit;
        End;
      End
      Else
        Exit;
    End;

    If FVencimentoAlterado Then
    Begin
      blnProrrogado := True;
      strHistorico := qryDuplic.FieldByName('CTR_HIST01').AsString;
      strHistorico := strHistorico + #13 +
                      'Em ' + DateToStr(VS_Date) + ', ocorreu prorrogação do vencimento. ' +
                      'Operador: ' + strLoginUsuarioLogado + #13 +
                      'Vencimento Original: ' + qryDuplic.FieldByName('CTR_DTAVEN').AsString + ' - ' +
                      'Vr.Original: ' + FormatFloat('#,##0.00', qryDuplic.FieldByName('CTR_VALDUP').AsFloat) + #13 +
                      'Novo Vencimento    : ' + FormatDateTime('dd/mm/yyyy', FVencimento) + ' - ' +
                      'Novo Valor : ' + FormatFloat('#,##0.00', FValorCorrigido);
      strHistorico := strHistorico + #13 + 'Juros alterado de ' +
                      FormatFloat('#,##0.00', qryDuplic.FieldByName('CTR_JURSUJ').AsFloat) + ' para ' +
                      FormatFloat('#,##0.00', FJurosSujerido) +
                      ' por motivo de prorrogação do vencimento.' + #13;

      If qryDuplic.FieldByName('CTR_DESSUJ').AsFloat <> 0 Then
      Begin
        If (fCfgSis('UTDEFN') = '1') Then
          fltDesSuj := qryDuplic.FieldByName('CTR_DESSUJ').AsFloat
        Else
        Begin
          strHistorico := strHistorico + 'Desconto alterado de ' +
                          FormatFloat('#,##0.00', qryDuplic.FieldByName('CTR_DESSUJ').AsFloat) +
                          ' para 0,00 por motivo de prorrogação do vencimento.' + #13;

          fltDesSuj := 0.0;
        End;
      End
      Else
        fltDesSuj := 0.0;

      If Not fGravaVencimento(FVencimento,
                              fltDesSuj,
                              FJurosSujerido,
                              strHistorico,
                              FAutInc,
                              'TDocumento.fImprimeBoleto') Then
        Raise Exception.Create('Não foi possível fazer a gravação do novo vencimento e acréscimos! Tente Novamente!');
    End;

    SetLength(objDuplic, qryDuplic.RecordCount);
    qryDuplic.First;

    For intContador := 0 To Pred(qryDuplic.RecordCount) Do
    Begin
      objDuplic[intContador].strNumDup := qryDuplic.FieldByName('CTR_NUMDUP').AsString;
      objDuplic[intContador].strParcel := qryDuplic.FieldByName('CTR_PARCEL').AsString;
      objDuplic[intContador].strCodEmp := qryDuplic.FieldByName('CTR_CODEMP').AsString;
      objDuplic[intContador].strEspDoc := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
      objDuplic[intContador].strCodCli := qryDuplic.FieldByName('CTR_CODCLI').AsString;
      objDuplic[intContador].strAutoIn := qryDuplic.FieldByName('AUTOINCREM').AsString;;
      qryDuplic.Next
    End;

    If blnReimprime And (Not blnProrrogado) Then
    Begin
      If Not LApenasReimpressao Then
      Begin
        blnPreview := fMensagem('','Opção:',['&Vídeo','Impressão']) = 1;
      End;
    End;

    If blnReimprime And (Not blnPreview) And (Not LApenasReimpressao) Then
    Begin
      objLiberacao.Clear;
      objMsg.Clear;
      objMsg.pAddTexto('Existe(m) boleto(s) já impresso(s)');
      strBoletoImpresso := IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_NUMDUP').AsString),'', ' Duplicata: ' + qryDuplic.FieldByName('CTR_NUMDUP').AsString + ' ') +
      IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_CODEMP').AsString),'', ' Emp: ' + qryDuplic.FieldByName('CTR_CODEMP').AsString + ' ') +
      IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_BCOBOL').AsString),'', ' Banco: ' + qryDuplic.FieldByName('CTR_BCOBOL').AsString + ' ') +
      IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_BCOBOL').AsString),'', ' Carteira: ' + qryDuplic.FieldByName('CTR_CARTEI').AsString + ' ') +
      IfThen(fEmptyStr(qryDuplic.FieldByName('CTR_NOSNUM').AsString),'', ' Nosso Núm: ' + qryDuplic.FieldByName('CTR_NOSNUM').AsString + ' ');

      objMsg.pAddTexto(strBoletoImpresso);

      objLiberacao.objMsgLibera.fGetObjectFromJson(objMsg.fGetJsonObject.ToJSON);
      objLiberacao.strDirAce := 'REIBOL';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnSempreVariavelUsuario := True;

      objLiberacao.pInformaNumDocEspDocCodEmp(qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                                              EmptyStr,
                                              qryDuplic.FieldByName('CTR_CODEMP').AsString);

      If Not objLiberacao.fLibera Then
        Exit;
    End;

    TBoleto.pAtualizaBoleto(objDuplic, blnReimprime, blnProrrogado, blnPreview);

    If fTemBoleto Then
    Begin
      Result := True;
      pGeraLogLiberacao(qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                        qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                        qryDuplic.FieldByName('CTR_CODEMP').AsString);
    End;

    SetLength(objDuplic, 0);
  Except
    On E: ExceptionAutcom Do
      fMensagem('ATENÇÃO!', E.Message, ['&Ok']);

    On E: Exception Do
      fMensagem('ATENÇÃO!', 'Ocorreu um erro ao consultar o boleto da duplicata selecionada:' + #13 + E.Message, ['&Ok']);
  End;
end;

procedure TDocumento.pAdicionarDuplicataVencidaTrava;
var
  intContador : Integer;
begin
  SetLength(arrDupSel, qryDuplic.RecordCount);
  qryDuplic.First;
  For intContador := 0 To Pred(qryDuplic.RecordCount) Do
  Begin
    arrDupSel[intContador].strNumDoc := qryDuplic.FieldByName('CTR_NUMDUP').AsString;
    arrDupSel[intContador].strEspDoc := qryDuplic.FieldByName('CTR_ESPDOC').AsString;
    arrDupSel[intContador].strCodEmp := qryDuplic.FieldByName('CTR_CODEMP').AsString;
    arrDupSel[intContador].strCodCli := qryDuplic.FieldByName('CTR_CODCLI').AsString;
    arrDupSel[intContador].dtaDtaCad := qryDuplic.FieldByName('CTR_DTACAD').AsDateTime;
    arrDupSel[intContador].dtaDtaVen := qryDuplic.FieldByName('CTR_DTAVEN').AsDateTime;
    arrDupSel[intContador].fltVlrRec := qryDuplic.FieldByName('CTR_VALDUP').AsFloat;
    arrDupSel[intContador].strParcel := qryDuplic.FieldByName('CTR_PARCEL').AsString;
    arrDupSel[intContador].strSeqBai := '';
    qryDuplic.Next;
  End;
end;

function TDocumento.fTravaDuplicatasVencidas(arrDups: TArrDupSel): Boolean;
  Var
    intCnt : Integer;
    fltTotDup : Double;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('IMPRESSÃO DE DUPLICATAS VENCIDAS NÃO PERMITIDO!', alCentro, teAmbos, '', 89);

  fltTotDup := 0;

  objTabela := TRegistroMsgLiberaTabela.Create;

  For intCnt := Low(arrDups) To High(arrDups) Do
  Begin
    fltTotDup := fltTotDup + arrDups[intCnt].fltVlrRec;

    If intCnt = Low(ArrDupSel) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlCabecalho;
      objLinha.pAddColuna(''  , 'DOCUMENTO'  , 17 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'CLIENTE'    , 21 , alEsquerda , teAutcom);
      objLinha.pAddColuna(''  , 'DT.CADASTRO', 11 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'DT.VENCTO'  , 10 , alCentro   , teAutcom);
      objLinha.pAddColuna(''  , 'VALOR'      , 19 , alDireita  , teAutcom);
      objTabela.lstLinhas.Add(objLinha);
    End;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DOCUMENTO'  , arrDups[intCnt].strNumDoc +
                                       arrDups[intCnt].strParcel + '-' +
                                       arrDups[intCnt].strEspDoc + '-' +
                                       arrDups[intCnt].strCodEmp                                                   , 17 , alEsquerda );
    objLinha.pAddColuna('CLIENTE'    , arrDups[intCnt].strCodCli + '-' + fRetNomCliente(arrDups[intCnt].strCodCli) , 21 , alEsquerda );
    objLinha.pAddColuna('DT.CADASTRO', FormatDateTime('dd/mm/yyyy', arrDups[intCnt].dtaDtaCad)                     , 11 , alCentro   );
    objLinha.pAddColuna('DT.VENCTO'  , FormatDateTime('dd/mm/yyyy', arrDups[intCnt].dtaDtaVen)                     , 10 , alCentro   );
    objLinha.pAddColuna('VALOR'      , FloatToStrF(arrDups[intCnt].fltVlrRec, ffFixed, 11, 2)                      , 19 , alDireita  );
    objTabela.lstLinhas.Add(objLinha);

    If intCnt = High(ArrDupSel) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''      , 'TOTAL'                                , 65 , alDireita, teAutcom );
      objLinha.pAddColuna('VALOR' , FloatToStrF(fltTotDup, ffFixed, 11, 2) , 19 , alDireita);
      objTabela.lstLinhas.Add(objLinha);

    End;
  End;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'IMPBVE';
  objLiberacao.strSenLib := fCfgSisL('IMPBVE');
  objLiberacao.strMsgSen := 'Impressão de duplicatas vencidas';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := Not objLiberacao.fLibera;
end;

function TDocumento.VerificaDireitoAcesso(ADirAce: String): Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    LDescricaoDireito : String;
begin
  objLiberacao.Clear;

  If ADirAce.Equals('frmImpBoletosIndiv') Then LDescricaoDireito := 'IMPRESSÃO DE BOLETOS - [CADASTRO DE CLIENTE > F6 - CONTA CORRENTE]'
  Else LDescricaoDireito := 'REIMPRESSÃO DE DOCUMENTOS - [CADASTRO DE CLIENTE > F6 - CONTA CORRENTE]';


   objLiberacao.objMsgLibera.pAddTexto(LDescricaoDireito, alCentro, teAmbos, '', 89) ;

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DOCUMENTO'  , 17 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'    , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CADASTRO', 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENCTO'  , 10 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VALOR'      , 19 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('DOCUMENTO'  , qryDuplic.FieldByName('CTR_NUMDUP').AsString +
                                     qryDuplic.FieldByName('CTR_PARCEL').AsString + '-' +
                                     qryDuplic.FieldByName('CTR_ESPDOC').AsString + '-' +
                                     qryDuplic.FieldByName('CTR_CODEMP').AsString                                , 17 , alEsquerda );
  objLinha.pAddColuna('CLIENTE'    , qryDuplic.FieldByName('CTR_CODCLI').AsString + '-' + fRetNomCliente(qryDuplic.FieldByName('CTR_CODCLI').AsString) , 21 , alEsquerda );
  objLinha.pAddColuna('DT.CADASTRO', FormatDateTime('dd/mm/yyyy', qryDuplic.FieldByName('CTR_DTACAD').AsDateTime)                     , 11 , alCentro   );
  objLinha.pAddColuna('DT.VENCTO'  , FormatDateTime('dd/mm/yyyy', qryDuplic.FieldByName('CTR_DTAVEN').AsDateTime)                     , 10 , alCentro   );
  objLinha.pAddColuna('VALOR'      , FloatToStrF(qryDuplic.FieldByName('CTR_VALDUP').AsFloat, ffFixed, 11, 2)                         , 19 , alDireita  );
  objTabela.lstLinhas.Add(objLinha);

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlTotal;
  objLinha.pAddColuna(''      , 'TOTAL'                                , 65 , alDireita, teAutcom );
  objLinha.pAddColuna('VALOR' , FloatToStrF(qryDuplic.FieldByName('CTR_VALDUP').AsFloat, ffFixed, 11, 2) , 19 , alDireita);
  objTabela.lstLinhas.Add(objLinha);


  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := ADirAce;
  objLiberacao.strMsgSen := LDescricaoDireito;
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  objLiberacao.pInformaNumDocEspDocCodEmp(
                    qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                    qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                    qryDuplic.FieldByName('CTR_CODEMP').AsString);

  Result := objLiberacao.fLibera;
end;


function TDocumento.fGetValorCorrigido: Double;
begin
  Result := FValorCorrigido;
end;

function TDocumento.fGetVencimento: TDateTime;
begin
  Result := FVencimento;
end;

function TDocumento.fGetVencimentoAlterado: Boolean;
begin
  Result := FVencimentoAlterado;
end;

Function TDocumento.fTemBoleto: Boolean;
Var
  strSQL: String;
  qryAux: TUniQuery;

begin
  inherited;

  Try
    qryAux := fCriaQuery;

    {*****************************}
    {* CARREGA OBS DO MOVGER/X   *}
    {**************************AF*}
    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM FROM CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM IN('+fFormataAutInc(FAutInc)+') AND ((CTR_NOSNUM IS NOT NULL) OR (COALESCE(CTR_BCOBOL, "")= "999" ';
    strSQL := strSQL + '                       AND CTR_DTABOL IS NOT NULL)) ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := Not IsEmpty;
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

destructor TDocumento.Destroy;
begin
  FreeAndNil(objLiberacao);
  FreeAndNil(objMsg);
  If Assigned(qryDuplic) Then
    FreeAndNil(qryDuplic);
end;

function TDocumento.fAlteraVencimento: Boolean;
var
  fltPerJur, fltPerMul, fltValDup, fltValdes, fltValAcr: Double;
  dteDataVenc: TDate;
  frmAlteraVencimento: TfrmAlteraVencimento;
begin
  Result := False;

  pCriarFormularios(TfrmAlteraVencimento, frmAlteraVencimento);
  try
    frmAlteraVencimento.dteDataVenc   := qryDuplic.FieldByName('CTR_DTAVEN').AsDateTime;
    frmAlteraVencimento.fltValDup     := qryDuplic.FieldByName('CTR_VALDUP').AsFloat;
    frmAlteraVencimento.fltDesSuj     := qryDuplic.FieldByName('CTR_DESSUJ').AsFloat;
    frmAlteraVencimento.fltJurSuj     := qryDuplic.FieldByName('CTR_JURSUJ').AsFloat;
    frmAlteraVencimento.fltDesCob     := qryDuplic.FieldByName('CTR_DESCOB').AsFloat;
    frmAlteraVencimento.strAutoincrem := qryDuplic.FieldByName('AUTOINCREM').AsString;
    frmAlteraVencimento.strBcoBol     := qryDuplic.FieldByName('CTR_BCOBOL').AsString;

    frmAlteraVencimento.ShowModal;
    If frmAlteraVencimento.blnConfirma Then
    Begin
      fltPerJur := frmAlteraVencimento.fltTaxaJuros;
      fltPerMul := frmAlteraVencimento.fltTaxaMulta;
      dteDataVenc := frmAlteraVencimento.dteDataVenc;

      If (fCfgSis('UTDEFN') = '1') Or (qryDuplic.FieldByName('CTR_DTAVEN').AsDateTime >= dteDataVenc) Then
        fltValdes := qryDuplic.FieldByName('CTR_DESSUJ').AsFloat
      Else
        fltValdes := 0;

      fltValDup := qryDuplic.FieldByName('CTR_VALDUP').AsFloat -
                   fltValdes +
                   qryDuplic.FieldByName('CTR_JURSUJ').AsFloat +
                   qryDuplic.FieldByName('CTR_DESCOB').AsFloat;

      fltValAcr := fCalculaJurosCadCtr(qryDuplic.FieldByName('CTR_DTAVEN').AsDateTime,
                                       DateToStr(dteDataVenc),
                                       fltValDup, fltPerJur, fltPerMul, 9999, qryDuplic.FieldByName('CTR_BCOBOL').AsString);


      FVencimentoAlterado := True;
      FJurosSujerido  := qryDuplic.FieldByName('CTR_JURSUJ').AsFloat + fltValAcr;
      FVencimento     := dteDataVenc;
      FValorCorrigido := qryDuplic.FieldByName('CTR_VALDUP').AsFloat -
                         fltValdes +
                         FJurosSujerido +
                         qryDuplic.FieldByName('CTR_DESCOB').AsFloat;

      Result := True;
    End;

  finally
    FreeAndNil(frmAlteraVencimento);
  end;
end;

function TDocumento.fEhEmissaoDeCupomFiscalPeloNfeImpressao: boolean;
begin
  Result := fCfgSis('PRNFCE', varBoolean) and (qryDuplic.FieldByName('CTR_ESPDOC').AsString='IF');
end;

function TDocumento.fEhEmissaoDeNotaDeProdutoPeloNfeImpressao: boolean;
begin
  Result := fCfgSis('CITINF', varBoolean) and (qryDuplic.FieldByName('CTR_ESPDOC').AsString='NF');
end;

function TDocumento.fEhEmissaoDeNotaDeServicoPeloNfeImpressao: boolean;
begin
  Result := fCfgSis('CITINF', varBoolean) and (fCfgSis('EMPSER')='PREFEITURA DE ARARAS') and (qryDuplic.FieldByName('CTR_ESPDOC').AsString='NS');
end;

procedure TDocumento.pImprimeNotaFiscal(strAutInc: String; blnValidarDireitoAcesso: Boolean = True);
var
  reiReimpressao: TReimpressao;
begin
  inherited;

  FAutInc := strAutInc;

  If Not fGetDuplicata(False) Then
    Exit;

  SetLength(arrLogLib, 0);

  If blnValidarDireitoAcesso and (Not VerificaDireitoAcesso('RIMPDC')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este operador não tem permissão para reimpressão de documentos!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(qryDuplic.FieldByName('GER_NUMDOC').AsString) Then
  Begin
    pMensagemOk('Este documento não tem produtos para visualização.');
    Exit;
  End;

  If qryDuplic.FieldByName('CTR_ESPDOC').AsString = 'NF' Then
    If fGerarPDFDanfe Then
      Exit;

  If qryDuplic.FieldByName('CTR_ESPDOC').AsString = 'IF' Then
    If fGerarPDFDanfe Then
      Exit;

  reiReimpressao := TReimpressao.Create(qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                                        qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                                        0,
                                        0,
                                        qryDuplic.FieldByName('CTR_CODCLI').AsString,
                                        qryDuplic.FieldByName('CTR_CODEMP').AsString,
                                        '',
                                        False,
                                        'C',
                                        True,
                                        False,
                                        False,
                                        IIf(qryDuplic.FieldByName('CTR_ESPDOC').AsString = 'AJ', 'AJ', ''),
                                        '',
                                        True,
                                        0,
                                        False,
                                        '',
                                        True,
                                        False,
                                        '');

  reiReimpressao.blnTelaReimpressao := True;
  reiReimpressao.pReimprimeDocumento(False, True, False, True, SameText(qryDuplic.FieldByName('CTR_ESPDOC').AsString, 'PD'));
  reiReimpressao.Free;
  pGeraLogLiberacao(qryDuplic.FieldByName('CTR_NUMDUP').AsString,
                    qryDuplic.FieldByName('CTR_ESPDOC').AsString,
                    qryDuplic.FieldByName('CTR_CODEMP').AsString);
end;

procedure TDocumento.pVisualizarPDFGerado(strArquivo: String);
  Var
    Pdir: Pchar;

begin

  Try

    GetMem(Pdir, 256);
    StrPCopy(Pdir, strArquivo);
    shellExecute(0, nil, PChar(strArquivo), nil, Pdir, SW_NORMAL);
    FreeMem(Pdir, 256);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Erro ao enviar documento para impressora.' + #13#10 +
        'Por favor, reenvie a nota.');
    End;
  End;

end;

procedure TDocumento.pChamaAnexos(strAutInc, strCodCli, strCodEmp : String);
Var
  strCaminhoPastaAntiga: String;
begin
  inherited;

  If fEmptyStr(StrAutInc) Then
     Exit;

  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);

    strCaminhoPastaAntiga := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTR\' + strAutInc;

    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTR\' +
                                                            fStrZero( strCodCli, 8  ) + '-' +
                                                            fStrZero( strCodEmp, 3  ) + '-' +
                                                            fStrZero( strAutInc, 20 ) ;
    If DirectoryExists( strCaminhoPastaAntiga ) Then
    Begin
       TDirectory.Move( strCaminhoPastaAntiga, frmGravaArquivoPasta.strCaminhoPasta );
       Sleep(500);
    End;

    frmGravaArquivoPasta.Caption := 'Pasta ( Arquivos Anexos )';
    frmGravaArquivoPasta.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravaArquivoPasta);

end;

end.


