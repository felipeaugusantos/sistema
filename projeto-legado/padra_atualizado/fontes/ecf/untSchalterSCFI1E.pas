unit untSchalterSCFI1E;

interface

uses untFiscal, Classes, Windows, SysUtils, StrUtils,
     Uni, untFuncoesGenerica, untTypesSistema;

Type TSchalterSCFI1E = class(TFiscal)
  Private
    FPais: TPais;
  Public

    blnModoNovo: Boolean;
    intRetorno: Integer;

	  function fAbreCupom: Boolean; override;
	  function fFechaCupom: Boolean; override;
    function fRegistraItem(strCodIte, strDesIte, strUnidad: String;
      fltAlqIcm, fltQtdIte, fltUnitar: Double; strCodFis: String;
      fltDesEsp: Double; fltTotal: Double = 0): Boolean; override;
    function fRegistraItemVelho(strCodIte, strDesIte, strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double): Boolean;
    function fCancelaItem(strItem: String): Boolean; override;
    function fImpLinFiscal(strAtrib, strLinha: String): Boolean; override;
    function fRegistraAcrDes(strAcrDes, strTip_AC, strVal_AC: String; fltTotal, fltTotImp: Double): Boolean; override;
    function fRegistraModalidades(strCodMod, strDesMod: String; fltValMod: Double; strInfAdi: String): Boolean; override;
    function fLeituraX(strParam: String = 'N'; blnPergunta: Boolean = True): Boolean; override;
    function fReducaoZ(strData, strHora: String): Boolean; override;
    function fAbreGaveta: Boolean; override;
    function fStatusImpressora: String; override;
    function fAbrePortaImpressora: Boolean; override;
    function fCancelaCupom: Boolean; override;
    function fRetornaCOO: String; override;
    function fNumeroSerie: String; override;
    function fexecutaCMD(strCmd: String; blnRetorna: Boolean = False): String; override;
    function fVerErro(blnMostraErro: Boolean = True): Boolean; override;
    function fCalcAliquota(strCodFiscal: String; fltAliquota: Double; intTipRet: Integer = 1): String; override;
    function fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean; override;
    function fRelatorioGerencial(strTexto: String): Boolean; override;
    function fEspacoEntreLinhas(intEspacos: Integer): Boolean; override;
    function fAbreCNFVinculado(strDesFormaPgto, strValor, strNumCupom: String; strQtdPar: String = ''): Boolean; override;
    function fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean; override;
    function fUsaCNFVinculado(strTexto: String): Boolean; override;
    function fRetMensErro: String;
    function fLeituraMemFiscal(strParIni,                     // PARAMETRO INICIAL
                               strParFin: String;             // PARAMETRO FINAL
                               intTipLei: Integer ): Boolean; // TIPO DE LEITURA 0/1 DATA/REDUCAO
    function fCancelaVenda: Boolean;
    function fImprimeLinha(strLinha: String): Boolean;
    function fArredonda(fltValor: Double): Double; reintroduce;

    procedure pFechaPortaImpressora; override;
    procedure pPausaLeitura; override;
    function  fVerificaCupomAberto: Boolean; Override;

    Constructor Create(Owner: TComponent; strPatDll, strPorta: String); Reintroduce;
  {*********************************************************}
  {* Funções criadas para corrigir os warnings na untFiscal*}
  {*                                                       *}
  {* MODELO....: (GENERICA)                                *}
  {* DATA......: 16/07/2014                                *}
  {* AUTOR.....: Marcelo Fagundes                          *}
  {*                                                       *}
  {******************************************************MH*}
    function fLeituraMemoriaFiscal(blnCompleta: Boolean; strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean; override;
    function fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin, strArquivoSaida: String): Boolean; override;
    function fArquivoMFD(strDataIni, strDataFin, strArquivoSaida, strRazSocEmp, strEndereEmp: String): Boolean; override;
    function fModeloEcf: String; override;
    function fNumeroUsuario: String; override;
    function fNumeroCCF: String; override;
    function fDataEcf: TDateTime; override;
    function fHoraEcf: TDateTime; override;
    function fUltimoItemVendido: String;override;
    function fNumeroGNF: String; override;
    function fNumeroGRG: String; override;
    function fNumeroCDC: String; override;
    function fDadosUltimaReducao(Var drzDadosReducao: TDadosReducao): Boolean; override;
    function fVendaBruta: Double; override;
    function fNumeroCaixa: String; override;
    function fNumeroCNPJUsuario: String; override;
    function fNumeroIEUsuario: String; override;
    function fVersaoSoftwareBasico: String; override;
    function fDataGravacaoSoftwareBasico: TDateTime; override;
    function fHoraGravacaoSoftwareBasico: TDateTime; override;
    function fTipoECF: String; override;
    function fMarcaECF: String; override;
    function fGrandeTotal: Double; override;
    function fMFDAdicional: String; override;
    function fSangria(fltValor: Double): Boolean; override;
    function fSuprimento(fltValor: Double; strModalidade: String='Dinheiro'): Boolean; override;
    function fGerarSintegra(blnApenas75: Boolean; strArquivo, strMes, strAno,
      strRazSoc, strEndere, strNumEnd, strComple, strBairro, strCidade,
      strNumCep, strFone01, strNumFax, strContat: String): Boolean; override;
    function fUltimoComandoComErro: Boolean; override;

  End;

var
  ecfImpCab: function (byEst: integer): integer; stdcall;
  ecfLeituraX: function (operador: LPSTR): integer; stdcall;
  ecfReducaoZ: function (operador: LPSTR): integer; stdcall;
  ecfVendaItem3d: function (szCodigo: LPSTR; szDescricao:LPSTR; szQuantidade:LPSTR; szValor:LPSTR; byTaxa:integer; szUnidade:LPSTR; szDigito:LPSTR): integer; stdcall;
  ecfCancItem: function ( szDescr:LPSTR ): integer; stdcall;
  ecfCancItemDef: function (szItem : LPSTR; szDescr:LPSTR): integer; stdcall;
  ecfCancAcresDescSubTotal: function (byAcres:integer; byTipo:integer; szDescr:LPSTR; szValor:LPSTR): integer; stdcall;
  ecfAbreGaveta: function: integer; stdcall;
  ecfStatusImp: function: PChar; stdcall;
  ecfCancDoc: function (operador: LPSTR): integer; stdcall;
  ecfLeituraXSerial: function: PAnsiChar; stdcall;
  ecfStatusEquipo: function: PAnsiChar; stdcall;
  ecfLXGerencial: function (operador: LPSTR): integer; stdcall;
  ecfFimTrans: function (operador: LPSTR): integer; stdcall;
  ChangePort: function (chose:integer): integer; stdcall;
  ecfPagamento: function (byTipo: integer; szPos:LPSTR; szValor:LPSTR; byLmens:integer): integer; stdcall;
  ecfLeitMemFisc: function (byTipo:integer; szDi:LPSTR; szDf:LPSTR; wRi:integer; wRf:integer; archive:LPSTR ): integer; stdcall;
  ecfCancVenda: function (operador: LPSTR): integer; stdcall;
  ecfImpLinha: function (szLinha: LPSTR): Integer; stdcall;
  ecfParamStatusImp: function (pbyUsers: LPSTR; pbyStat1: LPSTR; pbyStat2: LPSTR ): Integer; StdCall;

implementation

uses
      untFuncoes, untFuncoesSimples, untConstantes, Data.DB;

{ TSchalterSCFI1E }

constructor TSchalterSCFI1E.Create(Owner: TComponent; strPatDll, strPorta: String);
begin
  inherited Create(Owner);
  FPais       := fSetaPais;
  FPatDll     := strPatDll + '\DLL32PHI.DLL';
  FPorta      := strPorta;
  blnModoNovo := True;
end;

function TSchalterSCFI1E.fAbreCNFVinculado(strDesFormaPgto, strValor,
  strNumCupom: String; strQtdPar: String = ''): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fAbreCupom: Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfImpCab  := GetProcAddress(h, PChar('ecfImpCab'));
  intRetorno := ecfImpCab(0);
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fAbreGaveta: Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfAbreGaveta := GetProcAddress(h, PChar('ecfAbreGaveta'));
  intRetorno := ecfAbreGaveta;
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fAbrePortaImpressora: Boolean;
  Var
    intPorta: Integer;
    h: Cardinal;
begin

  If SameText(strPorta, 'COM1') Then
    intPorta := 1
  Else
    intPorta := 2;

  h := LoadLibrary(PChar(strPatDll));
  ChangePort := GetProcAddress(h, PChar('ChangePort'));

  Result := (ChangePort(intPorta) = intPorta);
  If (Not Result) Then
  Begin
    intRetorno := 4;
    fVerErro(blnModoNovo);
  End;

  FreeLibrary(h);
end;

function TSchalterSCFI1E.fArquivoMFD(strDataIni, strDataFin, strArquivoSaida,
  strRazSocEmp, strEndereEmp: String): Boolean;
begin
  Result := True; 
end;

function TSchalterSCFI1E.fArredonda(fltValor: Double): Double;
begin
  Result := fFormataFloat(fltValor,2);
end;

function TSchalterSCFI1E.fCalcAliquota(strCodFiscal: String;
  fltAliquota: Double; intTipRet: Integer): String;
  Var
    strPatIni: String;
    strCodEcf: String;
    strAliquota: String;
    qryTmpEcf: TUniQuery;
    strSQL: String;
    strCODSTB: String;
    strCODISE: String;
    strCODNIN: String;
    strCod018: String;
    strCodAtu: String;
    blnPrimei: Boolean;
    strPriCod: String;
    strIdeSer: String;
    strCodAlq: String;
    fltValAlq: Double;
begin

  strPatIni := fCfgSis('DIRINI');
  strCodEcf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'IMPRESSORA'   , '', strPatIni + '/opcoes_fiscal.ini' );

  Result := '';

  strAliquota := '';

  qryTmpEcf := fCriaQuery;

  With qryTmpEcf Do
  Begin

    strSQL := '';
    strSQL := strSQL + ' SELECT * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADECF ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ECF_CODECF = :CODECF ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODECF').AsString := strCodEcf;
    Open;

    strCODSTB := FieldByName( 'ECF_CODSTB' ).AsString;
    strCODISE := FieldByName( 'ECF_CODISE' ).AsString;
    strCODNIN := FieldByName( 'ECF_CODNIN' ).AsString;

    Close;

  End;

  {*****************************************}
  {* ISENTO                                *}
  {**************************************RL*}
  If Pos( strCodFiscal, CST_ISENTO ) > 0 Then
    strAliquota := 'I'

  {*****************************************}
  {* NÃO TRIBUTADO                         *}
  {**************************************AF*}
  Else If Pos( strCodFiscal, CST_NAO_TRIBUTADO ) > 0 Then
    strAliquota := 'N'

  {*****************************************}
  {* SUBSTITUICAO                          *}
  {**************************************RL*}
  Else If Pos( strCodFiscal, CST_SUBSTITUICAO + CST_ANTECIPACAO_ICMS ) > 0 Then
    strAliquota := 'F'

  {*****************************************}
  {* SERVICOS                              *}
  {**************************************RL*}
  Else If Pos( strCodFiscal, '_SSS_' ) > 0 Then
    strAliquota := 'S'

  {*****************************************}
  {* TRIBUTADO                             *}
  {**************************************RL*}
  Else
  Begin

    If ( fCfgSis('SIMPAU') = 'S' ) Then
//      strAliquota := FloatToStrF( fCfgSis('ICMSIM', varDouble), ffNumber, 5, 2 )
      strAliquota := FloatToStrF(fRetornaAliquotaIcmsInternaDoEstado(fCadEmp('ESTADO')), ffNumber, 5, 2)
    Else
    Begin

      If ( strEstCli = fCadEmp('ESTADO') ) Or fEmptyStr(strIESCli) Then
        strAliquota := FloatToStrF( fltAliquota, ffNumber, 5, 2 )
      Else
      Begin

        strAliquota := FloatToStrF( 0.00, ffNumber, 5, 2 );
        If ( strEstCli = fCadEmp('ESTADO') ) Then
          strAliquota := FloatToStrF( 18.00, ffNumber, 5, 2 )

        Else If ( Pos( strEstCli, '_PR_RJ_MG_RS_SC_SP_' ) > 0 ) Then
          strAliquota := FloatToStrF( 12.00, ffNumber, 5, 2 )

        Else
          strAliquota := FloatToStrF( 7.00, ffNumber, 5, 2 );

        If fEmptyStr( strIESCli ) And ( Not ( strEstCli = fCadEmp('ESTADO') ) ) Then
          strAliquota := FloatToStrF( 18.00, ffNumber, 5, 2 );

      End;

    End;

  End;

  {*****************************************}
  {* SE O TIPO DE RETORNO É 1              *}
  {* PROCURA INDICE                        *}
  {**************************************MA*}
  If ( intTipRet = 1 ) Then
  Begin

    {*****************************************}
    {* VERIFICA ALIQUOTA COM CADASTRO DE     *}
    {* IMPRESSORAS FISCAIS                   *}
    {**************************************MA*}
    If strAliquota = 'F' Then
      strAliquota := fPadR( strCODSTB, 2 )
    Else If strAliquota = 'I' Then
      strAliquota := fPadR( strCODISE, 2 )
    Else If strAliquota = 'N' Then
      strAliquota := fPadR( strCODNIN, 2 )
    Else
    Begin

      With qryTmpEcf Do
      Begin

        strSql := '';
        strSql := strSql + ' SELECT * ';
        strSql := strSql + ' FROM ';
        strSql := strSql + '   ECFALQ ';
        strSql := strSql + ' WHERE ';
        strSql := strSql + '   ECF_CODECF = :CODECF ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODECF').AsString := strCodEcf;
        Open;

        If IsEmpty() Then
          Exit;

        First;

        strCod018 := '';
        strCodAtu := '';
        blnPrimei := True;

        While Not Eof Do
        Begin

          If blnPrimei Then
          Begin
            strPriCod := FieldByName( 'ECF_CODALQ' ).AsString;
            blnPrimei := True;
          End;

          strCodAlq := FieldByName( 'ECF_CODALQ' ).AsString;
          fltValAlq := FieldByName( 'ECF_PERALQ' ).AsFloat;
          strIdeSer := FieldByName( 'ECF_SERVIC' ).AsString;

          If fEmptyStr( strCod018 ) Then
            If FloatToStrF( fltValAlq, ffNumber, 5, 2 ) = FloatToStrF( 18.00, ffNumber, 5, 2 ) Then
              strCod018 := strCodAlq;

          If strAliquota = 'S' Then
          Begin

            If fEmptyStr( strCodAtu ) Then
              strCodAtu := strCodAlq;

          End
          Else
          Begin

            If Pos( strAliquota, 'FIN' ) <= 0 Then
            Begin

              If ( FloatToStrF( fltValAlq, ffNumber, 5, 2 ) = strAliquota ) Then
              Begin
                strCodAtu := strCodAlq;
                Break;
              End;

            End;

          End;

          Next;
        End;

        If fEmptyStr( strCodAtu ) Then
          strCodAtu := strCod018;

        If fEmptyStr( strCodAtu ) Then
          strCodAtu := strPriCod;

        strAliquota := strCodAtu;

        Close;

      End;

    End;

  End;

  Result := AnsiReplaceStr( strAliquota, '.', ',' );

  FreeAndNil(qryTmpEcf);
end;

function TSchalterSCFI1E.fCancelaCupom: Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfCancDoc := GetProcAddress(h, PChar('ecfCancDoc'));
  intRetorno := ecfCancDoc(PAnsiChar(AnsiString(strCodVen + '-' + strNomVen)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fCancelaItem(strItem: String): Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  If fEmptyStr(strItem) Then
  Begin
    ecfCancItem := GetProcAddress(h, PChar('ecfCancItem'));
    intRetorno := ecfCancItem(PAnsiChar(AnsiString('CANCELAMENTO DO ITEM ' + strItem)));
  End
  Else
  Begin
    ecfCancItemDef := GetProcAddress(h, PChar('ecfCancItemDef'));
    intRetorno := ecfCancItemDef(PAnsiChar(AnsiString(strItem)), PAnsiChar(AnsiString('CANCELAMENTO DO ITEM ' + strItem)));
  End;
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fCancelaVenda: Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfCancVenda := GetProcAddress(h, PChar('ecfCancVenda'));
  intRetorno := ecfCancVenda(PAnsiChar(AnsiString(strCodVen + '-' + strNomVen)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fDadosUltimaReducao(
  var drzDadosReducao: TDadosReducao): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fDataEcf: TDateTime;
begin
  Result := 0; 
end;

function TSchalterSCFI1E.fDataGravacaoSoftwareBasico: TDateTime;
begin
  Result := 0;
end;

function TSchalterSCFI1E.fEspacoEntreLinhas(intEspacos: Integer): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fEspelhoMFD(strTipoFiltro, strFiltroIni, strFiltroFin,
  strArquivoSaida: String): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fexecutaCMD(strCmd: String;
  blnRetorna: Boolean): String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fFechaCNFVinculado(blnVerErro: Boolean = True): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fFechaCupom: Boolean;
  Var
    h: Cardinal;
    strMinLeg,
    strCupMan,
    strImpPag: string;
    blnImpPag: Boolean;
begin
  blnImpPag := ((fltImpPag <> 0.00) And (fltPeImPg <> 0.00)) Or
               ((fltFedImp <> 0.00) And (fltPeImFd <> 0.00)) Or
               ((fltEstImp <> 0.00) And (fltPeImEs <> 0.00)) Or
               ((fltMunImp <> 0.00) And (fltPeImMn <> 0.00));

  If blnImpPag Then
  Begin
    If Not fUsaImpostoFonteIBPT Then
    Begin
      If fltImpPag < 1000 Then
        fImprimeLinha(fPadR('Vlr.Apr.Trib "R$' + FormatFloat('#,##0.00', fltImpPag) +
                            '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 40))
      Else
        fImprimeLinha(fPadR('Vlr.Ap.Trib "R$' + FormatFloat('#,##0.00', fltImpPag) +
                            '(' + FormatFloat('#,##0.00', fltPeImPg) + '%)', 40));
    End
    Else
    Begin
      strImpPag := '';
      strImpPag := strImpPag + VAL_APR_IBPT;

      If (fltFedImp <> 0.00) Then
        strImpPag := strImpPag + FormatFloat('#,##0.00', fltFedImp) + FEDERAL;

      If (fltEstImp <> 0.00) Then
        strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltEstImp) + ESTADUAL;

      If (fltMunImp <> 0.00) Then
        strImpPag := strImpPag + '/' + FormatFloat('#,##0.00', fltMunImp) + MUNICIPAL;

      strImpPag := strImpPag + FONTE_IBPT;
      strImpPag := Copy(fPadR(strImpPag, 40), 1, 40);
      fImprimeLinha(strImpPag);
    End;
  End;

  strMinLeg := '';
  strCupMan := '';

  strCgcCpf := fFormataCpfCgc(strCgcCpf, FPais);
  If Pos('/', strCgcCpf) > 0 Then
  Begin
    strCgcCpf := 'CNPJ: ' + strCgcCpf;
    strIesCli := 'IES.: ' + strIesCli;
  End
  Else
  Begin
    strCgcCpf := 'CPF: ' + strCgcCpf;
    strIesCli := 'RG.: ' + strRG_Cli;
  End;

  If fCfgSis('IMPCAC', varBoolean) Then
    fImprimeLinha(fPadR('Cupom Fiscal: ' + strNumDoc + '-IF', 40 ));

  fImprimeLinha(fPadR(LeftStr( strNomCli, 31 ) + '-' + strCodCli, 40 ));
  fImprimeLinha(fPadR(strEndCli + ' - ' + strBaiCli, 40 ));

  If Not blnImpPag Then
    fImprimeLinha(fPadR(strCepCli + ' - ' + strCidCli + '-' + strEstCli, 40 ));

  fImprimeLinha(fPadR(strCGCCPF + ' - ' + strIESCli, 40 ));

  If (fCadEmp('ESTADO') = 'MG') And
     (fCfgSis('MINLEG', varBoolean)) Then
  Begin
    strMinLeg := fPadR( 'MINAS LEGAL:' + Trim(fTiraCaracEspeciais(fNumeroCNPJUsuario, True, True, True)) + ' ' +
                        FormatDateTime('ddmmyyyy', fDataEcf) +
                        fPadL(AnsiReplaceStr(FloatToStrF(fltTotSis, ffNumber, 12, 2), '.', ''), 8, ' '), 40);

    fImprimeLinha(strMinLeg);
  End
  Else
  If fCfgSis('CUPMAN', varBoolean) Then
  Begin
    strCupMan := fPadR( 'CUPOM MANIA, CONCORRA A PRÊMIOS VEND:' + strNomVen, 40);
    strCupMan := strCupMan + fPadR( 'ENVIE SMS P/ 6789:' + Trim(fTiraCaracEspeciais(fNumeroIEUsuario, True, True)) +
                                    FormatDateTime('ddmmyyyy', fDataEcf) +
                                    fRetornaCOO +
                                    RightStr(fNumeroCaixa, 3), 40);
    fImprimeLinha(strCupMan);
  End;

  If(fEmptyStr(strMinLeg) And fEmptyStr(strCupMan)) Then
  Begin
    fImprimeLinha(fPadR('Vendedor: ' + strNomVen, 40 ));
  End;

  h := LoadLibrary(PChar(strPatDll));
  ecfFimTrans := GetProcAddress(h, PChar('ecfFimTrans'));
  intRetorno := ecfFimTrans(PAnsiChar(AnsiString(strCodVen + '-' + strNomVen)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);

end;

function TSchalterSCFI1E.fFechaRelatorioGerencial(blnVerErro: Boolean = True): Boolean;
begin
  Result := fFechaCupom;
end;

function TSchalterSCFI1E.fGerarSintegra(blnApenas75: Boolean; strArquivo,
  strMes, strAno, strRazSoc, strEndere, strNumEnd, strComple, strBairro,
  strCidade, strNumCep, strFone01, strNumFax, strContat: String): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fGrandeTotal: Double;
begin
  Result := 0;
end;

function TSchalterSCFI1E.fHoraEcf: TDateTime;
begin
  Result := 0;
end;

function TSchalterSCFI1E.fHoraGravacaoSoftwareBasico: TDateTime;
begin
  Result := 0;
end;

function TSchalterSCFI1E.fImpLinFiscal(strAtrib,
  strLinha: String): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fImprimeLinha(strLinha: String): Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfImpLinha := GetProcAddress(h, PChar('ecfImpLinha'));
  intRetorno := ecfImpLinha(PAnsiChar(AnsiString(strLinha)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fLeituraMemFiscal(strParIni, strParFin: String;
  intTipLei: Integer): Boolean;
  Var
    h: Cardinal;
    strDtaIni: String;
    strDtaFin: String;
    strRedIni: String;
    strRedFin: String;
begin

  strDtaIni := '';
  strDtaFin := '';
  strRedIni := '';
  strRedFin := '';

  If intTipLei = 0 Then
  Begin
    strDtaIni := FormatDateTime('ddmmyy', StrToDate(strParIni));
    strDtaFin := FormatDateTime('ddmmyy', StrToDate(strParFin));
  End
  Else
  Begin
    strRedIni := strParIni;
    strRedFin := strParFin;
  End;

  h := LoadLibrary(PChar(strPatDll));
  ecfLeitMemFisc := GetProcAddress(h, PChar('ecfLeitMemFisc'));
  intRetorno := ecfLeitMemFisc(intTipLei+1, PAnsiChar(AnsiString(strDtaIni)), PAnsiChar(AnsiString(strDtaFin)),
    StrToIntDef(strRedIni, 0), StrToIntDef(strRedFin, 0), PAnsiChar('saida.txt'));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);

end;

function TSchalterSCFI1E.fLeituraMemoriaFiscal(blnCompleta: Boolean;
  strTipoFiltro, strFiltroIni, strFiltroFin: String): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fLeituraX(strParam: String;
  blnPergunta: Boolean): Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfLeituraX := GetProcAddress(h, PChar('ecfLeituraX'));
  intRetorno := ecfLeituraX(PAnsiChar(AnsiString(strCodVen + '-' + strNomVen)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fMarcaECF: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fMFDAdicional: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fModeloEcf: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fNumeroCaixa: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fNumeroCCF: String;
begin
  Result := ''; 
end;

function TSchalterSCFI1E.fNumeroCDC: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fNumeroCNPJUsuario: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fNumeroGNF: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fNumeroGRG: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fNumeroIEUsuario: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fNumeroSerie: String;
  Var
    h: Cardinal;
    strRetorno: String;
    intPos: Integer;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfStatusEquipo := GetProcAddress(h, PChar('ecfStatusEquipo'));
  strRetorno := String(StrPas(ecfStatusEquipo));
  FreeLibrary(h);

  intRetorno := 0;
  If AnsiStartsText('Erro', strRetorno) Then
  Begin
      intPos := Pos(':', strRetorno);
    intRetorno := StrToInt(Copy(strRetorno, intPos + 2, 5));
    fVerErro(blnModoNovo);
  End
  Else
    Result := RightStr(strRetorno, 9);
end;

function TSchalterSCFI1E.fNumeroUsuario: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fReducaoZ(strData, strHora: String): Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfLeituraX := GetProcAddress(h, PChar('ecfReducaoZ'));
  intRetorno := ecfLeituraX(PAnsiChar(AnsiString(strCodVen + '-' + strNomVen)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fRegistraAcrDes(strAcrDes, strTip_AC,
  strVal_AC: String; fltTotal, fltTotImp: Double): Boolean;
  Var
    intAcres: Integer;
    h: Cardinal;
    strValor: String;
begin

  Result := True;
  If (strTip_AC <> '$') Or (fFormataFloat(fStrToFloat(strVal_AC), 2) = 0.0) Then
  Begin
    Exit;
  End;

  intAcres := IIF(strAcrDes = 'D', 0, 1);
  strValor := AnsiReplaceStr(FloatToStrF(fStrToFloat(strVal_AC), ffFixed, 12, 2), ',', '');

  h := LoadLibrary(PChar(strPatDll));
  ecfCancAcresDescSubTotal := GetProcAddress(h, PChar('ecfCancAcresDescSubTotal'));
  intRetorno := ecfCancAcresDescSubTotal(intAcres, 0, '', PAnsiChar(AnsiString(strValor)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fRegistraItem(strCodIte, strDesIte,
  strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double;
  strCodFis: String; fltDesEsp: Double; fltTotal: Double = 0): Boolean;
  Var
    h: Cardinal;
    strUnitar: String;
    strQtdIte: String;
    strDigitos: String;
    strAlqIcm: String;
begin

  strUnitar  := FloatToStrF(fltUnitar, ffFixed, 12, 2);
  strDigitos := IIF(fCfgSis('DECQTD', varInteger) > 3, 3, fCfgSis('DECQTD', varInteger));
  strQtdIte := fPadL(FloatToStrF(fltQtdIte, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 7, '0');

  strAlqIcm := fCalcAliquota(strCodFis, fltAlqIcm);

  h := LoadLibrary(PChar(strPatDll));
  ecfVendaItem3d := GetProcAddress(h, PChar('ecfVendaItem3d'));
  intRetorno := ecfVendaItem3d(PAnsiChar(AnsiString(fStrZero(strCodIte, 13))),
                               PAnsiChar(AnsiString(Copy(strDesIte, 1, 64))),
                               PAnsiChar(AnsiString(strQtdIte)),
                               PAnsiChar(AnsiString(fStrZero(strUnitar, 9))),
                               StrToInt(strAlqIcm),
                               PAnsiChar(AnsiString(Copy(strUnidad, 1, 2))),
                               PAnsiChar(AnsiString(strDigitos)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fRegistraItemVelho(strCodIte, strDesIte,
  strUnidad: String; fltAlqIcm, fltQtdIte, fltUnitar: Double): Boolean;
  Var
    h: Cardinal;
    strUnitar: String;
    strDigitos: String;
    strQtdIte: String;
begin

  strUnitar  := FloatToStrF(fltUnitar, ffFixed, 12, 2);
  strDigitos := IIF(fCfgSis('DECQTD', varInteger) > 3, 3, fCfgSis('DECQTD', varInteger));
  strQtdIte := fPadL(FloatToStrF(fltQtdIte, ffFixed, 12, fCfgSis('DECQTD', varInteger)), 7, '0');

  h := LoadLibrary(PChar(strPatDll));
  ecfVendaItem3d := GetProcAddress(h, PChar('ecfVendaItem3d'));
  intRetorno := ecfVendaItem3d(PAnsiChar(AnsiString(fStrZero(strCodIte, 13))),
                               PAnsiChar(AnsiString(Copy(strDesIte, 1, 64))),
                               PAnsiChar(AnsiString(strQtdIte)),
                               PAnsiChar(AnsiString(fStrZero(strUnitar, 9))),
                               fFloatToInt(fltAlqIcm),
                               PAnsiChar(AnsiString(Copy(strUnidad, 1, 2))),
                               PAnsiChar(AnsiString(strDigitos)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fRegistraModalidades(strCodMod, strDesMod: String;
  fltValMod: Double; strInfAdi: String): Boolean;
  Var
    h: Cardinal;
    strValor: String;
    intLinAdi: Integer;
    intContador: Integer;
begin

  strValor := AnsiReplaceStr(FloatToStrF(fltValMod, ffFixed, 12, 2), ',', '');
  strValor := fStrZero(strValor, 10);

  If fEmptyStr(strInfAdi) Then
    intLinAdi := 0
  Else If Length(strInfAdi) <= 40 Then
    intLinAdi := 1
  Else
    intLinAdi := 2;

  h := LoadLibrary(PChar(strPatDll));
  ecfPagamento := GetProcAddress(h, PChar('ecfPagamento'));
  intRetorno := ecfPagamento(0, PAnsiChar(AnsiString(fStrZero(strCodMod, 2))), PAnsiChar(AnsiString(strValor)), 0);
  FreeLibrary(h);

  If (intRetorno = 0) Then
  Begin
    For intContador := 0 To intLinAdi-1 Do
    Begin
      If intContador = 0 Then
      Begin
        If (Not fImprimeLinha(Copy(strInfAdi, 01, 39))) Then
        Begin
          Result := False;
          Exit;
        End;
      End
      Else
      Begin
        If (Not fImprimeLinha(Copy(strInfAdi, 40, 40))) Then
        Begin
          Result := False;
          Exit;
        End;
      End;
    End;
  End;

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fRelatorioGerencial(strTexto: String): Boolean;
  Var
    h: Cardinal;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfLXGerencial := GetProcAddress(h, PChar('ecfLXGerencial'));
  intRetorno := ecfLXGerencial(PAnsiChar(AnsiString(strCodVen + '-' + strNomVen)));
  FreeLibrary(h);

  Result := fVerErro(blnModoNovo);
end;

function TSchalterSCFI1E.fRetMensErro: String;
begin
  Result := '';
  Case intRetorno Of
    01: Result := 'Erro de checksum';
    02: Result := 'Timeout RX';
    03: Result := 'Memória insuficiente';
    04: Result := 'Impressora fora de linha ou desligada';
    10: Result := 'Erro de sobreposição';
    11: Result := 'Erro de paridade';
    12: Result := 'Erro de sobreposição e paridade';
    13: Result := 'Erro de formato';
    14: Result := 'Erro de sobreposição e formato';
    15: Result := 'Erro de paridade e sobreposição';
    16: Result := 'Erro de sobreposição, paridade e formato';

    20: Result := 'Erro no cadastro de bancos';
    21: Result := 'Banco não cadastrado';
    22: Result := 'Moeda não cadastrada';
    23: Result := 'Extenso excedido';
    65: Result := 'Em venda';
    66: Result := 'Limite de cabeçalho alcançado';
    68: Result := 'Cabeçalho impresso';
    69: Result := 'Não começou venda';
    70: Result := 'Valor inválido';
    73: Result := 'Valor a menor';
    74: Result := 'Valor a maior';
    78: Result := 'Número máximo de Reduções Z alcançado';

    79: Result := 'Erro de comunicação';
    80: Result := 'Palavra reservada';
    81: Result := 'Papel próximo do fim';
    82: Result := 'Data não localizada';
    84: Result := 'Erro de memória fiscal';
    85: Result := 'Perda da RAM';
    86: Result := 'Não houve pagamento';
    87: Result := 'Cupom já totalizado';
    88: Result := 'Não pode cancelar venda';
    89: Result := 'Comando não completo';
    90: Result := 'Cupom aberto';
    91: Result := 'Não há cupom a cancelar';

    92: Result := 'Tabela de taxa não inicializada';
    94: Result := 'Seleção de taxa inválida';
    95: Result := 'Cancelamento inválido';
    96: Result := 'Nada a retificar';
    97: Result := 'Redução não localizada';
    98: Result := 'Cabeçalho não carregado';
    99: Result := 'Impressora em intervenção técnica';
    100: Result := 'Impressora em período de venda';
    101: Result := 'Somente com intervenção técnica';
    102: Result := 'Desconto inválido';
    103: Result := 'Limite de linhas alcançado';

    104: Result := 'Somente após o total';
    105: Result := 'Dados inválidos';
    106: Result := 'Alteração de taxa não disponível';
    107: Result := 'Comando inválido';
    108: Result := 'Não houve o fechamento do dia';
    109: Result := 'Erro irrecuperável';
    110: Result := 'Alteração inválida';
    111: Result := 'Data já alterada';
    112: Result := 'Alíquota não carregada';
    113: Result := 'Fechamento diário não realizado';
    114: Result := 'Abertura do dia inválida';

    115: Result := 'Fechamento já realizado';
    116: Result := 'Ajuste somente de +/- 1 hora';
    117: Result := 'Acréscimo inválido';
    118: Result := 'Pagamento incompleto';
    121: Result := 'Erro de gravação na memória fiscal';
    126: Result := 'Comando fora de seqüência';
    127: Result := 'Autenticação sem papel';
    132: Result := 'Queda de energia';
    133: Result := 'Data inválida';
    134: Result := 'Item fora da faixa';
    135: Result := 'Item não vendido';
    136: Result := 'Parâmetro errado';

    137: Result := 'Limite de valor ultrapassado';
    138: Result := 'Relógio fora de operação';
    139: Result := 'Pagamento não definido';
    140: Result := 'Limite de autenticação excedido';
    141: Result := 'Comando inválido';
    142: Result := 'Posição já programada';
    143: Result := 'Posição inexistente';
    144: Result := 'Cupom vinculado pendente';
    145: Result := 'Excesso de documentos vinculados';
    147: Result := 'Em horário já solicitado';
    148: Result := 'Oscilador do relógio desativado';

    149: Result := 'Formas de pagamento não inicializadas';
    150: Result := 'Inscrição Estadual inválida';
    151: Result := 'Extenso excedido';
    152: Result := 'Cupom está com subtotal zerado';
    153: Result := 'Codificação do GT já programada';
    154: Result := 'Não há vinculados a cupom';
    155: Result := 'Redução não permitida';
    156: Result := 'Caracter repetido na codificação do GT';
    157: Result := 'Caracter proibido na codificação do GT';

    606: Result := 'Não foi possível setar os parâmetros configuráveis da porta serial';
    707: Result := 'Não foi possível programar os parâmetros setados referentes à porta serial';
    808: Result := 'Não foi possível limpar a fila de transmissão';
    809: Result := 'Não foi possível limpar a fila de recepção';
    909: Result := 'Ocorreu um erro na programação interna dos timeouts da porta serial';
    1010: Result := 'A porta serial requisitada está bloqueada por outro aplicativo.';
    1020: Result := 'A porta serial já encontra-se aberta e não pode ser aberta pelo aplicativo corrente.';

    1030: Result := 'Ocorreu um problema desconhecido na recepção de retorno simples da impressora.';
    7121: Result := 'Ocorreu um problema a nível de hardware na porta serial do micro.';
  End;



end;

function TSchalterSCFI1E.fRetornaCOO: String;
  Var
    h: Cardinal;
    strRetorno: String;
    intPos    : Integer;
begin
  Result := '';
  h := LoadLibrary(PChar(strPatDll));
  ecfLeituraXSerial := GetProcAddress(h, PChar('ecfLeituraXSerial'));
  strRetorno        := String(StrPas(ecfLeituraXSerial));
  FreeLibrary(h);

  intRetorno := 0;
  If AnsiStartsText('Erro', strRetorno) Then
  Begin
    intPos := Pos(':', strRetorno);
    intRetorno := StrToInt(Copy(strRetorno, intPos + 2, 5));
    fVerErro(blnModoNovo);
  End
  Else
    Result := Copy(strRetorno, 22, 6);
end;

function TSchalterSCFI1E.fSangria(fltValor: Double): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fStatusImpressora: String;
  Var
    h: Cardinal;
    intPos: Integer;
    strRetorno: String;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfStatusImp := GetProcAddress(h, PChar('ecfStatusImp'));
  Result       := StrPas(ecfStatusImp);
  FreeLibrary(h);

  intRetorno := 0;
  If AnsiStartsText('Erro', strRetorno) Then
  Begin
      intPos := Pos(':', strRetorno);
    intRetorno := StrToInt(Copy(strRetorno, intPos + 2, 5));
    fVerErro(blnModoNovo);
  End;
end;

function TSchalterSCFI1E.fSuprimento(fltValor: Double;
  strModalidade: String): Boolean;
begin
  Result := true;
end;

function TSchalterSCFI1E.fTipoECF: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fUltimoComandoComErro: Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fUltimoItemVendido: String;
begin
  Result := '';
end;

function TSchalterSCFI1E.fUsaCNFVinculado(strTexto: String): Boolean;
begin
  Result := True;
end;

function TSchalterSCFI1E.fVendaBruta: Double;
begin
  Result := 0;
end;

function TSchalterSCFI1E.fVerErro(blnMostraErro: Boolean): Boolean;
  Var
    strMen: String;
begin
  Result := True;
  strMen := fRetMensErro;
  If (Not fEmptyStr(strMen)) And (blnMostraErro) Then
  Begin
    fMensagem('', strMen, ['&Ok']);
    Result := False;
  End;
end;

function TSchalterSCFI1E.fVerificaCupomAberto: Boolean;
Var h: Cardinal;
    strUsers, strStat1, strStat2: AnsiString;
begin
  h := LoadLibrary(PChar(strPatDll));
  ecfParamStatusImp := GetProcAddress(h, PChar('ecfParamStatusImp'));
  intRetorno := ecfParamStatusImp( PAnsiChar(strUsers), PAnsiChar(strStat1), PAnsiChar(strStat2) );

  If Trim(String(strStat1)) = '65' Then
    Result:=True
  Else
    Result:=False; 

  FreeLibrary(h);
end;

function TSchalterSCFI1E.fVersaoSoftwareBasico: String;
begin
  Result := '';
end;

procedure TSchalterSCFI1E.pFechaPortaImpressora;
begin
  inherited;
  //
end;

procedure TSchalterSCFI1E.pPausaLeitura;
begin
  inherited;
  //
end;

end.
