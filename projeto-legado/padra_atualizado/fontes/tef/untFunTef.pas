{**************************************}
{* CLASSE RESPONSÁVEL PELO TEF        *}
{***********************************AF*}
unit untFunTef;

interface

uses Windows, SysUtils, StrUtils, DateUtils, Controls, Forms, Classes, Uni,
     StdCtrls, untFiscal, ExtCtrls, untTypesSistema, System.Generics.Collections,
     untVersaoProg;

Type
  arrTStringList = Array[1..12] Of TStringList;

Type
  TTef = Class(TComponent)
  private
    procedure setCodEcf(const Value: String);
    procedure setTefTra(const Value: String);

  Protected
    FTefTra: String;
    FCodEcf: String;

    blnUsaImp: Boolean;
    strQtdCol : String;
    VS_Tef_G_P: String;
    VS_Tef_Res: String;
    VS_Tef_Ret: String;
    VS_Tef_Imp: String;
    VS_Tef_Req: String;
    VS_Tef_Bkp: String;
    VS_EcfCar : String;
    VS_DesCar : String;
    VS_Tef_Qtd: Integer;
    VS_objFiscal: TFiscalBrd;

    FQtdPar: Integer;
    FTipTra: String;
    FNomRed: String;
    FNomBan: String;
    FstrTipDeb: Char;
    FstrCardSe: String;
    FNumCcd: String;
    FNumNsu: String;
    FstrTipoCartao: String ;

    FLogErr: TStringList;
    FArqLog: String;
    FstrLog: String;

    FCGCEmp: string;
    FCGCCit: string;

    FSaque: Double;

    FChaPix: String;
    FPixS_N: String;

    blnAtvAntesComandos: Boolean ;

    function fImpressaoPendencias(strArqImpressao: String; intContCup: Integer): Boolean;
    function fRetArquivos(strPath: String): TStringList;

    function fVerificaNumeroTransacao(strArqRet, strNumTra: String): Boolean;

    function fConverteTextoTEF(stlTexto: TStringList): String;

    procedure pPosNumerosSeq(strArqImp: String; Var strCCD: String; Var strNSU: String);

    function fLerConteudoArq(const strArquivo: String): String;

    function fVerificaEmptyCcd(strCCD : String) : Boolean;
    function fVerificaEmptyNsu(strNsu : String) : Boolean;

  Public
    frmFormAtual: TForm;
    stlArqTefMod: TStringList;
    stlArqTefCodMod: TStringList;

    blnImpComprovante: Boolean;    

    property strCodEcf: String Read FCodEcf Write setCodEcf;
    property strTefTra: String Read FTefTra Write setTefTra;

    property intQtdPar: Integer Read FQtdPar;
    property strTipTra: String Read FTipTra;
    property strNomRed: String Read FNomRed;
    property strNomBan: String Read FNomBan;
    property strCardSe: String Read FstrCardSe;
    property strTipDeb: Char Read FstrTipDeb ;
    property strNumCcd: String Read FNumCcd;
    property strNumNsu: String Read FNumNsu;
    property strTipoCartao: String Read FstrTipoCartao ;

    property strCGCEmp: String Read FCGCEmp;
    property strCGCCit: String Read FCGCCit;

    property strChaPix: String Read FChaPix write FChaPix;
    property strPixS_N: String Read FPixS_N write FPixS_N;

    {**************************************}
    {* METODO DE CLASSE PARA CRIAR TEF    *}
    {***********************************AF*}
    class function fCriarTEF(Owner: TComponent; strModelo: String; Form: TForm;
      strCodEcf: String; objFiscal: TFiscalBrd; blnImpComprovante: Boolean): TTef;

    {*******************************}
    {* PROCEDURES                  *}
    {****************************WI*}
    procedure pTef_Cnf(strProIde, strNomeRede, strNumTra, strDtaTra, strHoraTra, strChaFin: String);
    procedure pTef_Ncn(strProIde, strNomeRede, strNumTra, strDtaTra, strHoraTra, strChaFin: String);
    procedure pDelArqRet(blnApagaImpCup: Boolean = True);
    procedure pInicializaMatRet(Var arrRetorno: arrTStringList);

    procedure pVerificaCncNcn(blnChamadaADM: Boolean = False; blnOcorrencia: Boolean = False); Virtual;
    function fGeraArqEnvio(lstEnviaTEF: TStringList): Boolean; Virtual;

    procedure pEnviaNcn(strArqAtual: String; blnMensagem: Boolean = True;
      blnApagarArq: Boolean = True; blnDividirValor: Boolean = True);

    procedure pRealizarBackup;
    procedure pRestauraBackup;

    {*******************************}
    {* FUNCOES                     *}
    {****************************WI*}
    function fTef_Atv: Boolean;
    function fTef_Atv_Direto: Boolean;
    function fTef_Adm: Boolean;
    function fTef_Crt(strValorCartao: String; blnApagaImpCup, blnUltCartao: Boolean;
      Var strArqRet: String; blnRotinaPagueFacil: Boolean = False;
      strTipoCartao: string = ''; intParcelas: Integer = 1): Boolean; Virtual;
    function fTef_Chq(strValorCheque: String; blnApagaImpCup: Boolean; Var strArqRet: String): Boolean;
    function fTef_Cnc(strProIde, strValor, strNomeRede, strNumTra, strDtaTra,
      strHoraTra, strChaFin, strArqCan: String): Boolean;
    function fLArqTxt(strCodIde: String; strArquivo: String = ''): TStringList;
    function fArqRet(Var strArqRetorno: String; blnRenomear: Boolean = True;
      strNumTra: String = ''): Boolean;
    function fPegaProxTransacao: String;
    function fTransNegada(strArqImpressao: String): Boolean;
    function fRetArquivoTEF: String;
    function fRetornaMensStatusTEF(frmNomeForm: TForm): String;
    function fRenomearArquivo( strArqOrigem, strArqDestino : String ):Boolean;

    function fProcessaArqPen: Boolean;
    {**************************************}
    {* VIRTUAIS E/OU ABSTRATAS            *}
    {***********************************AF*}
    function fTefFinRet(blnFazerLeituraX: Boolean = False; strArqCancelamento: String = ''; blnCancelamento: Boolean = False; blnChamadaADM: Boolean = False): Boolean; Virtual; Abstract;
    function fTefImpCup(Var blnReimprimir: Boolean; arrMatImp: TStringList;
      blnFazerLeituraX: Boolean; intContadorCupom: Integer; strArqImp: String): Boolean; Virtual; Abstract;
    function fErrImpressora(Var blnReimprimir: Boolean; blnOpcaoSimNao: Boolean = True; blnFechaVinculado: Boolean = True): Boolean; Virtual; Abstract;
    function fPendenciaTEF: Boolean; Virtual; Abstract;
    function fVerificaReducaoZ: Boolean; Virtual; Abstract;

    function fValorSaque: Double; Virtual;

    procedure pEnviaConfirmacoesPendentes;
    function fEnviarCancelamentoCompleto(strArqAtual: String; arrMatRetAtual: arrTStringList): Boolean;

    procedure pPreparaFilaPicotes(fila: TQueue<Integer>; strArqImp: String;
      intQtdVia: Integer);
    function fVerificaPicote(intImpressao: Integer; filaPicote: TQueue<Integer>): Boolean;
    function fParceladoPelaAdministradora: Boolean;

    Constructor Create(Owner: TComponent); Reintroduce;

    Destructor Destroy; Override;

  End;

procedure pRetDadosCartao(strNomRed, strNomBan, strTipTra: String; intQtdPar: Integer; Var strCodCar: String; const AstrCardSe: String; var AstrCodEmp: String; const AstrTipDeb: Char; const AstrTipoCartao: String);
function fSelecionaCartao(qryTabela: TUniQuery; strQtdPar: String; Var arrSel: TConsultasArray; Var strCodCar: String): Boolean;
function fPopularTabelaPOSDOC(var qryPos : TUniQuery): Boolean;
function fPopularTabelaPOSAUT(var qryPos : TUniQuery): Boolean;
function fTefHabilitado(): Boolean;

Var
  VS_objTef: TTef;
  stlNumeroCartao: TStringList;
  stlValorCartao : TStringList;

Const
  TF_strProIde: Integer = 01;
  TF_strNomRed: Integer = 02;
  TF_strNumTra: Integer = 03;
  TF_strDtaTra: Integer = 04;
  TF_strHorTra: Integer = 05;
  TF_strChaFin: Integer = 06;
  TF_intQtdLin: Integer = 07;
  TF_lslLinImp: Integer = 08;
  TF_curValRet: Integer = 09;
  TF_strOcorre: Integer = 10;
  TF_strMensag: Integer = 11;
  TF_strStatus: Integer = 12;

  MSG_TEF_EXCEDEU_TEMPO : String = 'Ocorreu um problema com a rotina do TEF (timeout), favor fechar essa tela e tentar novamente!';

implementation

uses untFuncoes, untFuncoesSimples, DB, untTefBematech,
     untTefSwedaDedicado, untTefPadraoDedicado, untQckFatImpNFCe, untSelPosCCD,
     untLogTef, untTAmarraCartao, untRegrasCadastroCartaoTef;

destructor TTef.Destroy;
begin

  FreeAndNil(stlArqTefMod);
  FreeAndNil(stlArqTefCodMod);
  FreeAndNil(FLogErr);

  inherited;

end;

{**********************************************************}
{* CNF - CONFIRMACAO DA VENDA                             *}
{*******************************************************WI*}
procedure TTef.pTef_Cnf(strProIde, strNomeRede, strNumTra, strDtaTra, strHoraTra, strChaFin: String);
  Var
    lstEnvio: TStringList;
Begin
  If (blnAtvAntesComandos) Then
  Begin
    If Not fTef_Atv Then
    Begin
      Exit;
    End;
  End;

	lstEnvio := TStringList.Create;
  Try
    lstEnvio.Add('000-000 = CNF'             );
    lstEnvio.Add('001-000 = ' + fPegaProxTransacao() );
    lstEnvio.Add('010-000 = ' + strNomeRede  );
    lstEnvio.Add('012-000 = ' + strNumTra    );
    lstEnvio.Add('027-000 = ' + strChaFin    );
    lstEnvio.Add('999-999 = 0'               );

    TLogTef.pLoga('TTef.pTef_Cnf', 'Vai chamar fGeraArqEnvio >> ', lstEnvio.Text);
    fGeraArqEnvio( lstEnvio );
  Finally
    FreeAndNil(lstEnvio);
  End;
End;

{**********************************************************}
{* NCN - NAO CONFIRMACAO DA VENDA                         *}
{*******************************************************WI*}
procedure TTef.pTef_Ncn(strProIde, strNomeRede, strNumTra, strDtaTra, strHoraTra, strChaFin: String);
  Var
    lstEnvio: TStringList;
Begin
  If (blnAtvAntesComandos) Then
  Begin
    If Not fTef_Atv Then
    Begin
      Exit;
    End;
  End;

	lstEnvio := TStringList.Create;
  Try
    lstEnvio.Add('000-000 = NCN'             );
    lstEnvio.Add('001-000 = ' + fPegaProxTransacao() );
    lstEnvio.Add('010-000 = ' + strNomeRede  );
    lstEnvio.Add('012-000 = ' + strNumTra    );
    lstEnvio.Add('027-000 = ' + strChaFin    );
    lstEnvio.Add('999-999 = 0'               );

    TLogTef.pLoga('TTef.pTef_Ncn', 'Vai chamar fGeraArqEnvio >> ', lstEnvio.Text);
    fGeraArqEnvio( lstEnvio );
  Finally
    FreeAndNil(lstEnvio);
  End;
End;

{**********************************************************}
{* DELETA ARQUIVOS: INTPOS.STS / INTPOS.001               *}
{*******************************************************WI*}
procedure TTef.pDelArqRet(blnApagaImpCup: Boolean = True);
  Var
    intContador: Integer;
Begin
  DeleteFile(VS_Tef_Res + 'INTPOS.STS');
  DeleteFile(VS_Tef_Ret);

  If blnApagaImpCup Then
  Begin
    For intContador := 1 To VS_Tef_Qtd Do
    Begin
      If FileExists(VS_Tef_Imp + fStrZero(intContador, 03)) Then
      Begin
        DeleteFile(VS_Tef_Imp + fStrZero(intContador, 03));
      End;
    End;
  End;

  pRealizarBackup;
End;

{**********************************************************}
{* INICIALIZA MATRIZ arrMatRet                            *}
{*******************************************************WI*}
procedure TTef.pInicializaMatRet(Var arrRetorno: arrTStringList);
  Var
    intContador: Integer;
Begin

  For intContador := 1 To 12 Do
  Begin
    arrRetorno[intContador] := TStringList.Create;

    If ( intContador = TF_intQtdLin ) Or ( intContador = TF_curValRet ) Then
      arrRetorno[intContador].Add( '0' )
    Else
      arrRetorno[intContador].Add( '' );

  End;

End;

{**********************************************************}
{* -> VERIFICA CNC / NCN                                  *}
{*******************************************************WI*}
procedure TTef.pVerificaCncNcn(blnChamadaADM: Boolean = False; blnOcorrencia: Boolean = False);
  Var
    arrMatRet    : arrTStringList;
    arrArquivos  : TStringList;
    intContador  : Integer;
    intNcnCnc    : Integer;
    strArqAtual  : String;
    strMensMostra: String;
    blnConsCheque: Boolean;

    strCanCup    : String;
    blnMandaNCN  : Boolean;
Begin
  Screen.Cursor := crHourGlass;
  pMostraMensTEF(frmFormAtual, 'AGUARDE... Verificando pendência.');

  arrArquivos := TStringList.Create;

  If FileExists(VS_Tef_Ret) Then
    arrArquivos.Add(VS_Tef_Ret);

  {************************************}
  {* -> PEGA OS ARQUIVOS TEF CONFIRMA-*}
  {*    DOS                           *}
  {*********************************WI*}
  For intContador := 1 To VS_Tef_Qtd Do
  Begin
    If FileExists(VS_Tef_Imp + fStrZero(intContador, 03)) Then
      arrArquivos.Add(VS_Tef_Imp + fStrZero(intContador, 03));
  End;

  {************************************}
  {* -> VERIFICA ARQUIVO DE CNC       *}
  {*********************************WI*}
  For intContador := 0 To (arrArquivos.Count -1) Do
  Begin
    strArqAtual := UpperCase(arrArquivos.Strings[intContador]);
    blnMandaNCN := False;

    If Pos('INTPOS', strArqAtual) > 0 Then
    Begin
      blnMandaNCN := (fLArqTxt('000', strArqAtual).Strings[0] = 'CNC');
    End
    Else
    Begin
      strCanCup := VS_Tef_Res + 'CANCUP' + ExtractFileExt(strArqAtual);

      If (FileExists(strCanCup)) Then
      Begin
        blnMandaNCN := True;
        strArqAtual := strCanCup;
      End;
    End;

    If blnMandaNCN Then
    Begin
      pEnviaNcn(strArqAtual, True, True, IIF(fCfgSis('SEQTEF', varBoolean), False, True));
    End;

  End;

  {************************************}
  {* -> PROCESSA OS ARQUIVOS          *}
  {*********************************WI*}
  intContador := 0;
  While intContador < arrArquivos.Count Do
  Begin
    Application.ProcessMessages;
    strArqAtual   := UpperCase(arrArquivos.Strings[intContador]);
    strMensMostra := '';

    blnConsCheque := (fLArqTxt('000', strArqAtual).Strings[0] = 'CHQ');

    If (blnConsCheque) Then
    Begin
      {************************************}
      {* -> APAGA ARQUIVO ATUAL           *}
      {*********************************WI*}
      DeleteFile( strArqAtual );
      pRealizarBackup;

      Inc(intContador);
      Continue;
    End;

    {************************************}
    {* INICIALIZA MATRIZ                *}
    {*********************************WI*}
    pInicializaMatRet( arrMatRet );

    arrMatRet[ TF_strProIde ] := fLArqTxt( '001', strArqAtual );   // Numero da Identificacao
    arrMatRet[ TF_strNomRed ] := fLArqTxt( '010', strArqAtual );   // Nome da Rede
    arrMatRet[ TF_strNumTra ] := fLArqTxt( '012', strArqAtual );   // Numero da Transacao
    arrMatRet[ TF_strDtaTra ] := fLArqTxt( '022', strArqAtual );   // Data da Transacao DDMMAAAA
    arrMatRet[ TF_strHorTra ] := fLArqTxt( '023', strArqAtual );   // Hora da Transacao HHMMSS
    arrMatRet[ TF_strChaFin ] := fLArqTxt( '027', strArqAtual );   // Chave para Finalizacao
    arrMatRet[ TF_intQtdLin ] := fLArqTxt( '028', strArqAtual );   // Qtd Linhas do Comprovante
    arrMatRet[ TF_lslLinImp ] := fLArqTxt( '029', strArqAtual );   // Matriz com as linhas para impressao
    arrMatRet[ TF_curValRet ] := fLArqTxt( '003', strArqAtual );   // Valor do Cupom
    arrMatRet[ TF_strMensag ] := fLArqTxt( '030', strArqAtual );   // Mensagem
    arrMatRet[ TF_strStatus ] := fLArqTxt( '009', strArqAtual );   // Status da Transacao
    arrMatRet[ TF_strOcorre ].Strings[0] := '0';                   // Ocorrencia 0-False 1-True

    If Pos( 'IMPCUP', strArqAtual ) > 0 Then
      intNcnCnc := 2
    Else
      intNcnCnc := 1;

    If intNcnCnc = 1 Then
    Begin

      If blnChamadaADM Then
      Begin
        If blnOcorrencia Then
          intNcnCnc := 2
        Else
          intNcnCnc := 1;
      End
      Else
        intNcnCnc := 1;

      {************************************}
      {* NCN -> NAO CONFIRMACAO VENDA     *}
      {*********************************WI*}
      If intNcnCnc = 1 Then
      Begin
        pEnviaNcn(strArqAtual, True, True, IIF(fCfgSis('SEQTEF', varBoolean), False, True));
      End
      Else
      Begin
        pTef_Cnf( arrMatRet[ TF_strProIde ].Strings[0],
                  arrMatRet[ TF_strNomRed ].Strings[0],
                  arrMatRet[ TF_strNumTra ].Strings[0],
                  arrMatRet[ TF_strDtaTra ].Strings[0],
                  arrMatRet[ TF_strHorTra ].Strings[0],
                  arrMatRet[ TF_strChaFin ].Strings[0] );
      End;

      {*****************************************}
      {* MANDEI A NCN DO INTPOS.001, VOU PARA O*}
      {* PRÓXIMO ARQUIVO.                      *}
      {**************************************MV*}
      Inc(intContador);

    End
    Else
    Begin
      {************************************}
      {* CNC -> CANCELAMENTO              *}
      {*********************************WI*}
      If fEnviarCancelamentoCompleto(strArqAtual, arrMatRet) Then
        Inc(intContador);

    End;
    {************************************}
    {* -> APAGA ARQUIVO ATUAL           *}
    {*********************************WI*}
    If Pos('INTPOS', strArqAtual) > 0 Then
    Begin
      DeleteFile( strArqAtual );
      pRealizarBackup;
    End;
  End;

  FreeAndNil(arrArquivos);
  Screen.Cursor := crDefault;
  pMostraMensTEF(frmFormAtual, '');
End;

procedure TTef.pEnviaConfirmacoesPendentes;
  Var
    arrMatRet  : arrTStringList;
    arrArquivos: TStringList;
    strArqAtual: String;
    intContador: Integer;
    blnConsCheque: Boolean;
begin
  Screen.Cursor := crHourGlass;
  pMostraMensTEF(frmFormAtual, 'AGUARDE... Verificando pendência.');

  arrArquivos := TStringList.Create;

  If FileExists(VS_Tef_Ret) Then
    arrArquivos.Add(VS_Tef_Ret);

  {************************************}
  {* -> PEGA OS ARQUIVOS TEF CONFIRMA-*}
  {*    DOS                           *}
  {*********************************WI*}
  For intContador := 1 To VS_Tef_Qtd Do
  Begin
    If FileExists(VS_Tef_Imp + fStrZero(intContador, 03)) Then
      arrArquivos.Add(VS_Tef_Imp + fStrZero(intContador, 03));
  End;

  {************************************}
  {* -> PROCESSA OS ARQUIVOS          *}
  {*********************************WI*}
  intContador := 0;
  While intContador < arrArquivos.Count Do
  Begin
    Application.ProcessMessages;
    strArqAtual   := UpperCase(arrArquivos.Strings[intContador]);

    blnConsCheque := (fLArqTxt('000', strArqAtual).Strings[0] = 'CHQ');

    If (blnConsCheque) Then
    Begin
      {************************************}
      {* -> APAGA ARQUIVO ATUAL           *}
      {*********************************WI*}
      DeleteFile( strArqAtual );
      pRealizarBackup;

      Inc(intContador);
      Continue;
    End;

    {************************************}
    {* INICIALIZA MATRIZ                *}
    {*********************************WI*}
    pInicializaMatRet( arrMatRet );

    arrMatRet[ TF_strProIde ] := fLArqTxt( '001', strArqAtual );   // Numero da Identificacao
    arrMatRet[ TF_strNomRed ] := fLArqTxt( '010', strArqAtual );   // Nome da Rede
    arrMatRet[ TF_strNumTra ] := fLArqTxt( '012', strArqAtual );   // Numero da Transacao
    arrMatRet[ TF_strDtaTra ] := fLArqTxt( '022', strArqAtual );   // Data da Transacao DDMMAAAA
    arrMatRet[ TF_strHorTra ] := fLArqTxt( '023', strArqAtual );   // Hora da Transacao HHMMSS
    arrMatRet[ TF_strChaFin ] := fLArqTxt( '027', strArqAtual );   // Chave para Finalizacao
    arrMatRet[ TF_intQtdLin ] := fLArqTxt( '028', strArqAtual );   // Qtd Linhas do Comprovante
    arrMatRet[ TF_lslLinImp ] := fLArqTxt( '029', strArqAtual );   // Matriz com as linhas para impressao
    arrMatRet[ TF_curValRet ] := fLArqTxt( '003', strArqAtual );   // Valor do Cupom
    arrMatRet[ TF_strMensag ] := fLArqTxt( '030', strArqAtual );   // Mensagem
    arrMatRet[ TF_strStatus ] := fLArqTxt( '009', strArqAtual );   // Status da Transacao
    arrMatRet[ TF_strOcorre ].Strings[0] := '0';                   // Ocorrencia 0-False 1-True

    pTef_Cnf( arrMatRet[ TF_strProIde ].Strings[0],
              arrMatRet[ TF_strNomRed ].Strings[0],
              arrMatRet[ TF_strNumTra ].Strings[0],
              arrMatRet[ TF_strDtaTra ].Strings[0],
              arrMatRet[ TF_strHorTra ].Strings[0],
              arrMatRet[ TF_strChaFin ].Strings[0] );

    {*****************************************}
    {* MANDEI A NCN DO INTPOS.001, VOU PARA O*}
    {* PRÓXIMO ARQUIVO.                      *}
    {**************************************MV*}
    Inc(intContador);

    {************************************}
    {* -> APAGA ARQUIVO ATUAL           *}
    {*********************************WI*}
    DeleteFile( strArqAtual );
    pRealizarBackup;
  End;

  FreeAndNil(arrArquivos);
  Screen.Cursor := crDefault;
  pMostraMensTEF(frmFormAtual, '');
end;

{**********************************************************}
{* -> MANDA NCN -> PARA CARTAO NAO ACEITO                 *}
{*******************************************************WI*}
procedure TTef.pEnviaNcn(strArqAtual: String; blnMensagem: Boolean = True;
      blnApagarArq: Boolean = True; blnDividirValor: Boolean = True);
  Var
    arrMatRet    : arrTStringList;
    strMensMostra: String;
Begin
  Screen.Cursor := crHourGlass;

  {************************************}
  {* INICIALIZA MATRIZ                *}
  {*********************************WI*}
  pInicializaMatRet(arrMatRet);

  arrMatRet[ TF_strProIde ] := fLArqTxt( '001', strArqAtual );   // Numero da Identificacao
  arrMatRet[ TF_strNomRed ] := fLArqTxt( '010', strArqAtual );   // Nome da Rede
  arrMatRet[ TF_strNumTra ] := fLArqTxt( '012', strArqAtual );   // Numero da Transacao
  arrMatRet[ TF_strDtaTra ] := fLArqTxt( '022', strArqAtual );   // Data da Transacao DDMMAAAA
  arrMatRet[ TF_strHorTra ] := fLArqTxt( '023', strArqAtual );   // Hora da Transacao HHMMSS
  arrMatRet[ TF_strChaFin ] := fLArqTxt( '027', strArqAtual );   // Chave para Finalizacao
  arrMatRet[ TF_intQtdLin ] := fLArqTxt( '028', strArqAtual );   // Qtd Linhas do Comprovante
  arrMatRet[ TF_lslLinImp ] := fLArqTxt( '029', strArqAtual );   // Matriz com as linhas para impressao
  arrMatRet[ TF_curValRet ] := fLArqTxt( '003', strArqAtual );   // Valor do Cupom
  arrMatRet[ TF_strMensag ] := fLArqTxt( '030', strArqAtual );   // Mensagem
  arrMatRet[ TF_strStatus ] := fLArqTxt( '009', strArqAtual );   // Status da Transacao
  arrMatRet[ TF_strOcorre ].Strings[0] := '0';                   // Ocorrencia 0-False 1-True

  If StrToIntDef(arrMatRet[ TF_intQtdLin ].Strings[0] , 0) > 0 Then
  Begin
    {************************************}
    {* NCN -> NAO CONFIRMACAO VENDA     *}
    {*********************************WI*}
    pTef_Ncn( arrMatRet[ TF_strProIde ].Strings[0],
              arrMatRet[ TF_strNomRed ].Strings[0],
              arrMatRet[ TF_strNumTra ].Strings[0],
              arrMatRet[ TF_strDtaTra ].Strings[0],
              arrMatRet[ TF_strHorTra ].Strings[0],
              arrMatRet[ TF_strChaFin ].Strings[0] );
  End;

  If blnApagarArq Then
  Begin
    DeleteFile(strArqAtual);
    pRealizarBackup;
  End;

  strMensMostra := 'Cancelada a Transação: ';

  {*****************************************}
  {* MENSAGEM ADICIONAL DO DEDICADO.       *}
  {**************************************MV*}
  If fCfgSis('TIPTEF') = 'E' Then
    strMensMostra := strMensMostra + 'Favor reter o cupom.';

  strMensMostra := strMensMostra + #13+#10+#13+#10;

  If Not fEmptyStr( arrMatRet[ TF_strNomRed ].Strings[0] ) Then
    strMensMostra := strMensMostra + 'Rede: ' + arrMatRet[ TF_strNomRed ].Strings[0] + #13+#10;

  If Not fEmptyStr( arrMatRet[ TF_strNumTra ].Strings[0] ) Then
    strMensMostra := strMensMostra + 'NSU.: ' + arrMatRet[ TF_strNumTra ].Strings[0]+#13+#10;

  If StrToCurr( arrMatRet[ TF_curValRet ].Strings[0] ) > 0  Then
  Begin
    If (blnDividirValor) Or (fCfgSis('DIVTEF', varBoolean)) Then
      strMensMostra := strMensMostra + 'Valor: ' + FormatFloat( '#,##0.00', StrToCurr( arrMatRet[ TF_curValRet ].Strings[0] ) / 100 )+#13+#10
    Else
      strMensMostra := strMensMostra + 'Valor: ' + FormatFloat( '#,##0.00', StrToCurr( arrMatRet[ TF_curValRet ].Strings[0] ))+#13+#10;
  End;

  SetForegroundWindow(Application.Handle);

  If StrToIntDef(arrMatRet[ TF_intQtdLin ].Strings[0] , 0) <= 0 Then
    blnMensagem := False;

  //VS_objFiscal.fFinalizaModoTEF;
  If blnMensagem Then
    fMensagem( '', strMensMostra, ['&O k'] );
  //VS_objFiscal.fIniciaModoTEF;

  pMostraMensTEF(frmFormAtual, '');

  Screen.Cursor := crDefault;
End;

function TTef.fEnviarCancelamentoCompleto(strArqAtual: String; arrMatRetAtual: arrTStringList): Boolean;
  Var
    strCanCup: String;
    blnImpPendenc: Boolean;
    arrMatRet: arrTStringList;
begin
  Result := False;
  strCanCup := VS_Tef_Res + 'CANCUP' + ExtractFileExt(strArqAtual);

  //VS_objFiscal.fFinalizaModoTEF;
  fTef_Cnc( arrMatRetAtual[ TF_strProIde ].Strings[0],
            arrMatRetAtual[ TF_curValRet ].Strings[0],
            arrMatRetAtual[ TF_strNomRed ].Strings[0],
            arrMatRetAtual[ TF_strNumTra ].Strings[0],
            arrMatRetAtual[ TF_strDtaTra ].Strings[0],
            arrMatRetAtual[ TF_strHorTra ].Strings[0],
            arrMatRetAtual[ TF_strChaFin ].Strings[0],
            strCanCup );
  //VS_objFiscal.fIniciaModoTEF;

  {*****************************************}
  {* IMPRESSÃO DO IMPCUP.XXX               *}
  {**************************************MV*}
{      blnImpPendenc := fImpressaoPendencias(strArqAtual, 0);

  If blnImpPendenc Then
    blnImpPendenc := fImpressaoPendencias(strCanCup, 1);}


  If (StrToIntDef(fLArqTxt( '028', strCanCup )[0], 0) > 0) Then
  Begin

    pMostraMensTEF(frmFormAtual, 'AGUARDE, IMPRIMINDO CANCELAMENTO...');
    blnImpPendenc := fImpressaoPendencias(strCanCup, 0);
    pMostraMensTEF(frmFormAtual, '');

    If blnImpPendenc Then
    Begin

      {************************************}
      {* INICIALIZA MATRIZ                *}
      {*********************************WI*}
      pInicializaMatRet( arrMatRet );

      arrMatRet[ TF_strProIde ] := fLArqTxt( '001', strCanCup );   // Numero da Identificacao
      arrMatRet[ TF_strNomRed ] := fLArqTxt( '010', strCanCup );   // Nome da Rede
      arrMatRet[ TF_strNumTra ] := fLArqTxt( '012', strCanCup );   // Numero da Transacao
      arrMatRet[ TF_strDtaTra ] := fLArqTxt( '022', strCanCup );   // Data da Transacao DDMMAAAA
      arrMatRet[ TF_strHorTra ] := fLArqTxt( '023', strCanCup );   // Hora da Transacao HHMMSS
      arrMatRet[ TF_strChaFin ] := fLArqTxt( '027', strCanCup );   // Chave para Finalizacao
      arrMatRet[ TF_intQtdLin ] := fLArqTxt( '028', strCanCup );   // Qtd Linhas do Comprovante
      arrMatRet[ TF_lslLinImp ] := fLArqTxt( '029', strCanCup );   // Matriz com as linhas para impressao
      arrMatRet[ TF_curValRet ] := fLArqTxt( '003', strCanCup );   // Valor do Cupom
      arrMatRet[ TF_strMensag ] := fLArqTxt( '030', strCanCup );   // Mensagem
      arrMatRet[ TF_strStatus ] := fLArqTxt( '009', strCanCup );   // Status da Transacao
      arrMatRet[ TF_strOcorre ].Strings[0] := '0';                   // Ocorrencia 0-False 1-True

      pTef_Cnf( arrMatRet[ TF_strProIde ].Strings[0],
                arrMatRet[ TF_strNomRed ].Strings[0],
                arrMatRet[ TF_strNumTra ].Strings[0],
                arrMatRet[ TF_strDtaTra ].Strings[0],
                arrMatRet[ TF_strHorTra ].Strings[0],
                arrMatRet[ TF_strChaFin ].Strings[0] );

      DeleteFile(strArqAtual);
      DeleteFile(strCanCup);
      pRealizarBackup;
      Result := True;
    End
    Else
    Begin
      pEnviaNcn(strCanCup, True, True, IIF(fCfgSis('SEQTEF', varBoolean), False, True));
    End;

  End
  Else
    DeleteFile(strCanCup);

End;

{**********************************************************}
{* ATV - VERIFICA GERENCIADOR PADRAO                      *}
{*******************************************************WI*}
function TTef.fTef_Atv: Boolean;
  Var
    lstEnvio: TStringList;
    hraInicio : TDateTime;
    strMsg : string;
Begin
  lstEnvio := TStringList.Create;
  hraInicio := fTime();
  try
    Result := False;
    {*****************************************}
    {* GERA ARQUIVO DE ENVIO.                *}
    {**************************************MV*}
    While (Not Result) Do
    Begin
      lstEnvio.Clear;
      lstEnvio.Add('000-000 = ATV');
      lstEnvio.Add('001-000 = ' + fPegaProxTransacao());
      lstEnvio.Add('999-999 = 0');
      TLogTef.pLoga('TTef.pTef_Cnf', 'Vai chamar fGeraArqEnvio >> ', lstEnvio.Text);
      Result := fGeraArqEnvio(lstEnvio);
      pMostraMensTEF(frmFormAtual, 'Verificando se o Gerenciador Padrão do TEF está ativo...');
      Application.ProcessMessages;

      If (SecondsBetween(hraInicio, fTime()) >= 40) Then
      begin
        VS_strUsaTef := 'N';
        strMsg := 'As configurações do sistema indicam o uso do TEF, porém, o gerenciador padrão não está respondendo aos comandos enviados, confirme as configurações do TEF em: ';
        strMsg := strMsg + sLineBreak;

        if fCfgSis('USNFCE', varBoolean) then
          strMsg := strMsg + 'CFG_CITNCC - NFCe: Configurações por ponto de venda'
        else if fUsaSat then
          strMsg := strMsg + 'CFG_CFGSAT - Configurações por ponto de venda'
        else
          strMsg := strMsg + 'CFG_CUPFIS - Configurações - Cupom Fiscal';

        if fInTransaction then
          raise Exception.Create(strMsg)
        else
        begin
          fMensagem('', strMsg, ['&OK']);
          result := False;
          break;
        end;
      end;
    End;
  finally
    pMostraMensTEF(frmFormAtual, '');
    FreeAndNil(lstEnvio);
  end;
End;

function TTef.fTef_Atv_Direto: Boolean;
  Var
    lstEnvio: TStringList;
Begin
  lstEnvio := TStringList.Create;
  Try
    {*****************************************}
    {* GERA ARQUIVO DE ENVIO.                *}
    {**************************************MV*}
    lstEnvio.Clear;
    lstEnvio.Add('000-000 = ATV');
    lstEnvio.Add('001-000 = ' + fPegaProxTransacao());
    lstEnvio.Add('999-999 = 0');

    TLogTef.pLoga('TTef.fTef_Atv_Direto', 'Vai chamar fGeraArqEnvio >> ', lstEnvio.Text);
    Result := fGeraArqEnvio(lstEnvio);
    Application.ProcessMessages;
  Finally
    FreeAndNil(lstEnvio);
  End;
end;

{**********************************************************}
{* ADM - ADMINISTRATIVA                                   *}
{*******************************************************WI*}
function TTef.fTef_Adm: Boolean;
  Var
    lstEnvio       : TStringList;
    strConteudoResp: String;
    strArqImpressao: String;
Begin
  Try
    Result := False;

    If fMensagem( '', 'Confirma ADM?', ['',''], 2 ) <> 1 Then
      Exit;

    If (blnAtvAntesComandos) Then
    Begin
      If Not fTef_Atv Then
      Begin
        Exit;
      End;
    End;

    {************************************}
    {* DELETA ARQUIVO DE RETORNO        *}
    {*********************************WI*}
    pDelArqRet;

    lstEnvio := TStringList.Create;
    lstEnvio.Add('000-000 = ADM'                     );
    lstEnvio.Add('001-000 = ' + fPegaProxTransacao() );
    lstEnvio.Add('565-008 = ' + '1=' + FCGCEmp + ';2=' + FCGCCit );
    lstEnvio.Add('999-999 = 0'                       );

    TLogTef.pLoga('TTef.fTef_Adm', 'Vai chamar fGeraArqEnvio >> ' + strArqImpressao, lstEnvio.Text);
    Result := fGeraArqEnvio( lstEnvio );

    FreeAndNil(lstEnvio);

    If Result Then
    Begin
      {************************************}
      {* VERIFICA RETORNO                 *}
      {*********************************WI*}
      TLogTef.pLoga('TTef.fTef_Adm', 'Vai chamar fArqRet >> ' + strArqImpressao);

      Result := fArqRet(strArqImpressao, False );

      strConteudoResp := fLerConteudoArq(strArqImpressao);
      TLogTef.pLoga('TTef.fTef_Adm', 'Vai chamar fLerConteudoArq >> ' + strArqImpressao, strConteudoResp);

      {*****************************************}
      {* NÃO HÁ LINHAS PARA IMPRIMIR, PORTANTO,*}
      {* APAGA.                                *}
      {**************************************MV*}
      If ( fLArqTxt( '009', strArqImpressao ).Strings[0] = '0')          And
         (StrToInt( fLArqTxt( '028', strArqImpressao ).Strings[0] ) = 0) Then
      Begin
        DeleteFile(strArqImpressao);
        pRealizarBackup;
      End
      Else
      Begin
        {************************************}
        {* FINALIZA ARQUIVO DE RETORNO      *}
        {*********************************WI*}
        If Result Then
        Begin
          //VS_objFiscal.fIniciaModoTEF;
          fTefFinRet( True, '', False, True );
        End;
      End;

    End;
    pMostraMensTEF(frmFormAtual, '');

  Finally
    //VS_objFiscal.fFinalizaModoTEF;
  End;
End;

function TTef.fVerificaEmptyCcd(strCCD : String) : Boolean;
  var
    strAuxCCD : String;
begin
  Result := False;

  strAuxCCD := Trim(fRetiraZerosEsquerda(strCCD));

  if fEmptyStr(strAuxCCD) then
    Result := True;
end;

function TTef.fVerificaEmptyNsu(strNsu : String) : Boolean;
  var
    strAuxNSU : String;
begin
  Result := False;

  strAuxNSU := Trim(fRetiraZerosEsquerda(strNsu));

  if fEmptyStr(strAuxNSU) then
    Result := True;
end;

{**********************************************************}
{* CRT - VENDA COM CARTAO                                 *}
{*******************************************************WI*}
function TTef.fTef_Crt(strValorCartao: String; blnApagaImpCup, blnUltCartao: Boolean;
  Var strArqRet: String; blnRotinaPagueFacil: Boolean;
      strTipoCartao: string; intParcelas: Integer): Boolean;
  Var
    lstEnvio       : TStringList;
    strArqImpressao: String;
    arrMatRet      : arrTStringList;
    blnRenomeia    : Boolean;
    strNumTra      : String;
    strCCD, strNSU : String;
    strCodCar      : String;
    strChave,StrPix: String;
    strConteudoResp: String;
  Const
    strCredito: string = '00001000000000000000000000000000000000000000000000000000000000000000000000000000';
    strDebito: string =  '00000000001000000000000000000000000000000000000000000000000000000000000000000000';
    strCodigoCarteiraDigital_PIX: string = '60110024';
Begin

  If (blnAtvAntesComandos) Then
  Begin
    If Not fTef_Atv Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  pDelArqRet( blnApagaImpCup );

  strNumTra := fPegaProxTransacao();

  lstEnvio := TStringList.Create;
  Try
    lstEnvio.Add('000-000 = CRT'               );
    lstEnvio.Add('001-000 = ' + strNumTra      );
    lstEnvio.Add('003-000 = ' + strValorCartao );

    if blnRotinaPagueFacil then
    begin
      if fCfgSis('TEFPGF') = 'P' then
      begin
        lstEnvio.Add('004-000 = 0');
        lstEnvio.Add('018-000 = '+IntToStr(intParcelas));
        lstEnvio.Add('706-000 = 0');
        lstEnvio.Add('716-000 = '+VS_strRazSoc);
        lstEnvio.Add('730-000 = 1');
        lstEnvio.Add('731-000 = '+IIF(strTipoCartao = 'C', '1', '2') );
        if (strTipoCartao = 'C') and (intParcelas > 1) then
          lstEnvio.Add('732-000 = '+IIF(fCfgSis('PARTEF') = 'E', '3', '2'))
        else
          lstEnvio.Add('732-000 = 1');
        lstEnvio.Add('733-000 = 225');
        lstEnvio.Add('735-000 = AUTCOM');
        lstEnvio.Add('736-000 = '+TVersaoExecutavel.GetVersaoProduto);
        lstEnvio.Add('749-000 = 1');        
      end
      else
      begin
        if (strTipoCartao = 'C') and (intParcelas > 1) then
          lstEnvio.Add('017-000 = ' + IIF(fCfgSis('PARTEF') = 'E', '0', '1'));

        lstEnvio.Add('018-000 = ' + fPadL(IntToStr(intParcelas), 2, '0'));
        lstEnvio.Add('501-001 = ' + IIF(strTipoCartao = 'D', strDebito, strCredito));
        lstEnvio.Add('565-008 = ' + '1=' + FCGCEmp + ';2=' + FCGCCit );
      end;
    end
    else
      lstEnvio.Add('565-008 = ' + '1=' + FCGCEmp + ';2=' + FCGCCit );

    lstEnvio.Add('999-999 = 0'                 );

    TLogTef.pLoga('TTef.fTef_Crt', 'Vai chamar fGeraArqEnvio >> ' + strArqImpressao, lstEnvio.Text);
    Result := fGeraArqEnvio( lstEnvio );
    If Not Result Then
      Exit;
  Finally
    FreeAndNil(lstEnvio);
  End;

  {************************************}
  {* VERIFICA RETORNO                 *}
  {*********************************WI*}
  TLogTef.pLoga('TTef.fTef_Crt', 'Vai chamar fArqRet >> ' + strArqImpressao);

  fArqRet(strArqImpressao, False, strNumTra );

  strConteudoResp := fLerConteudoArq(strArqImpressao);
  TLogTef.pLoga('TTef.fTef_Crt', 'Vai chamar fLerConteudoArq >> ' + strArqImpressao, strConteudoResp);

  {************************************}
  {* FINALIZA ARQUIVO DE RETORNO      *}
  {*********************************WI*}
  Result := fTransNegada( strArqImpressao);

  {************************************}
  {* -> MANDA CONFIRMACAO DO TEF      *}
  {*********************************WI*}
  If Result Then
  Begin
    {*****************************************}
    {* NÃO RENOMEIA O ÚLTIMO CARTÃO.         *}
    {**************************************MV*}
    blnRenomeia := True;
    If blnUltCartao Then
      blnRenomeia := False;

    {************************************}
    {* VERIFICA RETORNO                 *}
    {*********************************WI*}
    TLogTef.pLoga('TTef.fTef_Crt', 'Vai chamar fArqRet >> ' + strArqImpressao);

    fArqRet(strArqImpressao, blnRenomeia );

    strConteudoResp := fLerConteudoArq(strArqImpressao);
    TLogTef.pLoga('TTef.fTef_Crt', 'Vai chamar fLerConteudoArq >> ' + strArqImpressao, strConteudoResp);

    {************************************}
    {* INICIALIZA MATRIZ                *}
    {*********************************WI*}
    pInicializaMatRet( arrMatRet );

    arrMatRet[ TF_strProIde ] := fLArqTxt( '001', strArqImpressao );   // Numero da Identificacao
    arrMatRet[ TF_strNomRed ] := fLArqTxt( '010', strArqImpressao );   // Nome da Rede
    arrMatRet[ TF_strNumTra ] := fLArqTxt( '012', strArqImpressao );   // Numero da Transacao
    arrMatRet[ TF_strDtaTra ] := fLArqTxt( '022', strArqImpressao );   // Data da Transacao DDMMAAAA
    arrMatRet[ TF_strHorTra ] := fLArqTxt( '023', strArqImpressao );   // Hora da Transacao HHMMSS
    arrMatRet[ TF_strChaFin ] := fLArqTxt( '027', strArqImpressao );   // Chave para Finalizacao

    FQtdPar := StrToIntDef(fLArqTxt( '018', strArqImpressao )[0], 1);
    FTipTra := Trim(fLArqTxt( '011', strArqImpressao )[0]);
    FNomRed := Trim(fLArqTxt( '010', strArqImpressao )[0]);
    FNomBan := Trim(fLArqTxt( '040', strArqImpressao )[0]);
    strCodCar := Trim(FLArqTxt( '504', strArqImpressao) [0]);
    strPixS_N := 'N';
    If fEmptyStr(FNomBan) Then
      FNomBan := Trim(fLArqTxt( '010-001', strArqImpressao )[0]);
    pPosNumerosSeq(strArqImpressao, strCCD, strNSU);
    if strCodCar = strCodigoCarteiraDigital_PIX then
    begin
      strNsu    := Trim(FLArqTxt( '012', strArqImpressao) [0]);
      strChave  := Trim(fLArqTxt('027', strArqImpressao) [0]);
      strPix    := 'S';
      strCCD    := Trim(fLArqTxt('521-001', strArqImpressao) [0]);

      if FQtdPar = 0 then
        FQtdPar := 1;
    end
    else
    begin
      if fVerificaEmptyNsu(strNsu) then
        strNsu := Trim(fLArqTxt('012-000', strArqImpressao) [0]);

      if fVerificaEmptyCCD(strCCD) then
        strCCD := Trim(fLArqTxt('013-000', strArqImpressao) [0]);
    end;

    FNumCcd := strCCD;
    FNumNsu := strNSU;
    FChaPix := strChave;
    FPixS_N := strPix;

    {*****************************************}
    {* CASO FOR PARCELADO PELA ADM, O ESTABE-*}
    {* LECIMENTO RECEBE À VISTA              *}
    {**************************************MV*}
    If fParceladoPelaAdministradora Then
      FQtdPar := 1;

    If (Not blnUltCartao) Then
    Begin
      pTef_Cnf( arrMatRet[ TF_strProIde ].Strings[0],
                arrMatRet[ TF_strNomRed ].Strings[0],
                arrMatRet[ TF_strNumTra ].Strings[0],
                arrMatRet[ TF_strDtaTra ].Strings[0],
                arrMatRet[ TF_strHorTra ].Strings[0],
                arrMatRet[ TF_strChaFin ].Strings[0] );
    End;

    strArqRet := strArqImpressao;
  End;
End;

{**********************************************************}
{* CHQ - VENDA COM CHEQUE                                 *}
{*******************************************************WI*}
function TTef.fTef_Chq(strValorCheque: String; blnApagaImpCup: Boolean; Var strArqRet: String): Boolean;
  Var
    lstEnvio       : TStringList;
    strArqImpressao: String;
    strConteudoResp: String;
Begin

  If (blnAtvAntesComandos) Then
  Begin
    If Not fTef_Atv Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  pDelArqRet( blnApagaImpCup );

	lstEnvio := TStringList.Create;
 	lstEnvio.Add('000-000 = CHQ'                     );
 	lstEnvio.Add('001-000 = ' + fPegaProxTransacao() );
 	lstEnvio.Add('003-000 = ' + strValorCheque       );
  lstEnvio.Add('565-008 = ' + '1=' + FCGCEmp + ';2=' + FCGCCit );
	lstEnvio.Add('999-999 = 0'                       );

  TLogTef.pLoga('TTef.fTef_Chq', 'Vai chamar fGeraArqEnvio >> ' + strArqImpressao, lstEnvio.Text);
  Result := fGeraArqEnvio( lstEnvio );

  If Not Result Then
  Begin
   FreeAndNil(lstEnvio);
   Exit;
  End;
  FreeAndNil(lstEnvio);

  {************************************}
  {* VERIFICA RETORNO                 *}
  {*********************************WI*}
  TLogTef.pLoga('TTef.fTef_Chq', 'Vai chamar fArqRet >> ' + strArqImpressao, strConteudoResp);

  fArqRet(strArqImpressao, False );

  strConteudoResp := fLerConteudoArq(strArqImpressao);
  TLogTef.pLoga('TTef.fTef_Chq', 'Vai chamar fLerConteudoArq >> ' + strArqImpressao, strConteudoResp);
  {************************************}
  {* FINALIZA ARQUIVO DE RETORNO      *}
  {*********************************WI*}
  Result := fTransNegada( strArqImpressao);

  {************************************}
  {* -> MANDA CONFIRMACAO DO TEF      *}
  {*********************************WI*}
  If Result Then
  Begin

    {************************************}
    {* VERIFICA RETORNO                 *}
    {*********************************WI*}
    TLogTef.pLoga('TTef.fTef_Chq', 'Vai chamar fArqRet >> ' + strArqImpressao);

    fArqRet(strArqImpressao );

    strConteudoResp := fLerConteudoArq(strArqImpressao);
    TLogTef.pLoga('TTef.fTef_Chq', 'Vai chamar fLerConteudoArq >> ' + strArqImpressao, strConteudoResp);

    strArqRet := strArqImpressao;

    {*****************************************}
    {* NÃO HÁ LINHAS PARA IMPRIMIR, PORTANTO,*}
    {* APAGA.                                *}
    {**************************************MV*}
    If StrToInt( fLArqTxt( '028', strArqImpressao ).Strings[0] ) = 0 Then
    Begin
      DeleteFile(strArqRet);
      pRealizarBackup;
      strArqRet := '';
    End;

  End;

End;

{**********************************************************}
{* CNC - CANCELAMENTO                                     *}
{*******************************************************WI*}
function TTef.fTef_Cnc(strProIde, strValor, strNomeRede, strNumTra, strDtaTra,
  strHoraTra, strChaFin, strArqCan: String): Boolean;
  Var
    lstEnvio       : TStringList;
    strArqImpressao: String;
    strConteudoResp: String;
Begin

  If (blnAtvAntesComandos) Then
  Begin
    If Not fTef_Atv Then
    Begin
      Result := False;
      Exit;
    End;
  End;

	lstEnvio := TStringList.Create;

 	lstEnvio.Add('000-000 = CNC'             );
 	lstEnvio.Add('001-000 = ' + fPegaProxTransacao() );
 	lstEnvio.Add('003-000 = ' + strValor     );
 	lstEnvio.Add('010-000 = ' + strNomeRede  );
 	lstEnvio.Add('012-000 = ' + strNumTra    );
 	lstEnvio.Add('022-000 = ' + strDtaTra    );
 	lstEnvio.Add('023-000 = ' + strHoraTra   );
	lstEnvio.Add('999-999 = 0'               );

  TLogTef.pLoga('TTef.pTef_Cnf', 'Vai chamar fGeraArqEnvio >> ', lstEnvio.Text);
  Result := fGeraArqEnvio( lstEnvio );

  FreeAndNil(lstEnvio);

  If Result Then
  Begin
    {************************************}
    {* VERIFICA RETORNO                 *}
    {*********************************WI*}
    TLogTef.pLoga('TTef.fTef_Cnc', 'Vai chamar fArqRet >> ' + strArqImpressao);

    Result := fArqRet(strArqImpressao, False );

    strConteudoResp := fLerConteudoArq(strArqImpressao);
    TLogTef.pLoga('TTef.fTef_Cnc', 'Vai chamar fLerConteudoArq >> ' + strArqImpressao, strConteudoResp);

    {************************************}
    {* FINALIZA ARQUIVO DE RETORNO      *}
    {*********************************WI*}
    If Result Then
    Begin
      fRenomearArquivo(strArqImpressao, strArqCan);
    End;

  End;
End;

{**********************************************************}
{* GRAVA ARQUIVO TXT DE ENVIO PARA TEF                    *}
{*******************************************************WI*}
function TTef.fGeraArqEnvio(lstEnviaTEF: TStringList): Boolean;
	Var
    strNomeArqReq  : String;
    strNomeArqRen  : String;
    strNomeArqRes  : String;
    strNomeArqPen  : String;
    intAssign      : Integer;
    intQtdSegundos : Integer;
    timHoraAnterior: TTime;

    //blnModoTefAtivo: Boolean;
Begin
  Result := False;

  Try
    {************************************}
    {* CRIA ARQUIVO                     *}
    {*********************************WI*}
    intAssign     := 0;
    strNomeArqReq := VS_Tef_Req + 'INTPOS.TMP';
    strNomeArqRen := VS_Tef_Req + 'INTPOS.001';
    strNomeArqRes := VS_Tef_Res + 'INTPOS.STS';
    strNomeArqPen := VS_Tef_Req + 'INTPOS.PEN';

    While (intAssign <= 10) Do
    Begin
      Try
        lstEnviaTEF.SaveToFile(strNomeArqReq);
        Result := TRUE;
        Break;
      Except
      On E: Exception Do
        Begin
          Result := FALSE;
          Sleep( 1000 );
          Inc(intAssign);
        End;
      End;
    End;

    {************************************}
    {* RENOMEIA ARQUIVO                 *}
    {*********************************WI*}
    fRenomearArquivo( strNomeArqReq, strNomeArqRen );

    {************************************}
    {* CASO TENHA GERADO O ARQUIVO DE   *}
    {* ENVIO, RENOMEIA O MESMO          *}
    {*********************************WI*}
    If Result Then
    Begin
      timHoraAnterior := fTime();
      Screen.Cursor := crHourGlass;

      While True Do
      Begin
        Application.ProcessMessages;
        If FileExists( strNomeArqRes ) Then
        Begin
          DeleteFile(strNomeArqRes );
          pRealizarBackup;
          Result := True;
          Break;
        End;
        intQtdSegundos := SecondOfTheDay( fTime() ) - SecondOfTheDay( timHoraAnterior );
        If ( intQtdSegundos > 7 ) Then
        Begin

          If Pos(fLArqTxt( '000', strNomeArqRen)[0], 'CNF_NCN') > 0 Then
            fRenomearArquivo(strNomeArqRen, strNomeArqPen);

          //blnModoTefAtivo := blnTravad;
          //VS_objFiscal.fFinalizaModoTEF;
          fMensagem( '', 'Gerenciador Padrão não está ativo e será ativado automáticamente.', ['&Ok'] );

          //If (blnModoTefAtivo) Then
            //VS_objFiscal.fIniciaModoTEF;

          WinExec(PAnsiChar(AnsiString(VS_Tef_G_P)), SW_NORMAL);
          Sleep(1000);

          SetForegroundWindow(Application.Handle);

          If FileExists(strNomeArqPen) Then
            fRenomearArquivo(strNomeArqPen, strNomeArqRen);

          Result := False;
          Break;
        End;
      End;
      Screen.Cursor := crDefault;
    End;
  Except
    fMensagem( '', 'Erro na geração do arquivo ('+strNomeArqReq+')', ['&O k'] );
  End;

End;

{**********************************************************}
{* EFETUA LEITURA DENTRO DO TXT DE RETORNO TEF            *}
{*******************************************************WI*}
function TTef.fLArqTxt(strCodIde: String; strArquivo: String = ''): TStringList;
  Var
    lstRetorno    : TStringList;
    strLinha      : String;
    blnPrimeiraVez: Boolean;
    lstArquivo    : TStringList;
    intLinhas     : Integer;
Begin

  sleep(100);
	lstRetorno     := TStringList.Create;
  Result         := lstRetorno;
  blnPrimeiraVez := True;

  If (strCodIde = '028') Or (strCodIde = '003') Then
    lstRetorno.Add( '0' )
  Else
    lstRetorno.Add( '' );


  If fEmptyStr( strArquivo ) Then
    strArquivo := VS_Tef_Ret;

  If Not FileExists( strArquivo ) Then
  Begin
    fMensagem( '', 'Não foi possível efetuar a leitura do arquivo ('+strArquivo+')', ['&O k'] );
  End
  Else
  Begin
    {************************************}
    {* PROCESSA ARQUIVO TXT             *}
    {*********************************WI*}

    lstArquivo := TStringList.Create;
    lstArquivo.LoadFromFile(strArquivo);

    For intLinhas := 0 To lstArquivo.Count - 1 Do
    Begin
      Application.ProcessMessages;

      strLinha := '';
      strLinha := lstArquivo[intLinhas];
      strLinha := AnsiReplaceStr( strLinha, '"', '' );
      strLinha := Trim( strLinha );

      If ( LeftStr( strLinha, 03 ) = strCodIde ) Or
         (AnsiStartsText(strCodIde, strLinha))   Then
      Begin

        If blnPrimeiraVez Then
        Begin
          blnPrimeiraVez := False;
          lstRetorno.Clear;
        End;

        lstRetorno.Add( Copy( strLinha, 11, Length( strLinha )-10 ) );
        If Not ( LeftStr( strLinha, 03 ) = '029' ) Then
        Begin
          Break;
        End;
      End;
    End;

    FreeAndNil(lstArquivo);

    Result := lstRetorno;
  End;
End;

{**********************************************************}
{* VERIFICA SE FOI RETORNADO O ARQUIVO "INTPOS.001"       *}
{*******************************************************WI*}
function TTef.fArqRet(Var strArqRetorno: String; blnRenomear: Boolean = True;
  strNumTra: String = ''): Boolean;
  Var
    strArquivo: String;
    blnConfirma: Boolean;
    dtaHraIni : TDateTime;
    strMsgPnl : String;
Begin
  Result     := False;
  strArquivo := VS_Tef_Ret;
  strMsgPnl := '';

  pMostraMensTEF(frmFormAtual, 'Aguardando resposta do Gerenciador Padrão...');

  dtaHraIni := fNow();

  While True Do
  Begin
    Application.ProcessMessages;

    If (SecondsBetween(fNow(), dtaHraIni) > 100) Then
    Begin
      If (fCfgSis('TEFEXC', varBoolean)) Then
      Begin
        TLogTef.blnExcedeuTempoTEF := True;
        strMsgPnl := 'Tempo de espera excedido...';
        TLogTef.pLoga('TTef.fArqRet', 'Vai sair da função pois excedeu o tempo!');
        Result := False;
        Break;
      End;
    End;

    If FileExists( strArquivo ) Then
    Begin

      blnConfirma := True;

      If (Not fEmptyStr(strNumTra)) Then
      Begin
        blnConfirma := fVerificaNumeroTransacao(strArquivo, strNumTra);
      End;

      If blnConfirma Then
      Begin
        pRealizarBackup;
        Result := True;
        Break;
      End
      Else
      Begin
        DeleteFile(strArquivo);
        pRealizarBackup;
      End;
    End;
  End;
  pMostraMensTEF(frmFormAtual, strMsgPnl);

  If Result Then
  Begin
    If blnRenomear Then
    Begin
      strArqRetorno := fRetArquivoTEF;
      {************************************}
      {* RENOMEIA ARQUIVO                 *}
      {*********************************WI*}
      fRenomearArquivo( strArquivo, strArqRetorno );
    End
    Else
    Begin
      strArqRetorno := strArquivo;
    End;
  End;

End;

{**********************************************************}
{* PEGA PROXIMO NUMERO DE TRANSACAO                       *}
{*******************************************************WI*}
function TTef.fParceladoPelaAdministradora: Boolean;
begin
  Result := (FTipTra = '12');
end;

function TTef.fPegaProxTransacao: String;
Begin

  If fEmptyStr(strTefTra) Then
    strTefTra := '000001';

  Result := strTefTra;

  strTefTra := RightStr( '000000' + IntToStr(StrToInt(Result) + 1), 06);

End;

{**********************************************************}
{* -> VERIFICA SE A TRANSACAO FOI NEGADA                  *}
{*******************************************************WI*}
function TTef.fTransNegada(strArqImpressao: String): Boolean;
  Var
    strMsg : String;
    strMsgAdic : String;
Begin
  Try
    Result := True;

    {************************************}
    {* VALIDA STATUS DE TRANSACAO       *}
    {*********************************WI*}
    If fLArqTxt( '009', strArqImpressao ).Strings[0] <> '0' Then
    Begin
      If StrToInt( fLArqTxt( '028', strArqImpressao ).Strings[0] ) = 0 Then
      Begin
        strMsg := fLArqTxt( '030', strArqImpressao ).Strings[0];

        strMsgAdic := '';

        If strMsg.Contains('ERRO NO CAMPO: VALOR') Then
        Begin
          If fCfgSis('USNFCE', varBoolean) Then
            strMsgAdic := 'Verifique a necessidade de alterar a configuração: "CFG_VIRTEF"'
          Else If fCfgSis('USASAT', varBoolean) Then
            strMsgAdic := 'Verifique a necessidade de alterar a configuração: "CFG_VRTFSA"';
        End;

        TLogTef.pLoga('TTef.fTransNegada', 'Exibiu a mensagem ao usuário: Transação Negada.' + sLineBreak + strMsg + sLineBreak + strMsgAdic);
        SetForegroundWindow(Application.Handle);
        fMensagem( '', 'Transação Negada.' + sLineBreak + strMsg + sLineBreak + strMsgAdic, ['&OK'] );
      End;
      Result := False;
    End
    Else
    Begin
      {************************************}
      {* QUANDO NAO EXISTIR LINHAS PARA   *}
      {* SEREM IMPRESSAS                  *}
      {*********************************WI*}
      If StrToInt( fLArqTxt( '028', strArqImpressao ).Strings[0] ) = 0 Then
      Begin
        strMsg := fLArqTxt( '030', strArqImpressao ).Strings[0];
        TLogTef.pLoga('TTef.fTransNegada', 'Exibiu a mensagem ao usuário: ' + strMsg);
        fMensagem('', strMsg, ['&OK']);
      End
      Else IF StrToInt(fLArqTxt( '028', strArqImpressao ).Strings[0]) > 0 Then
      Begin
        If Not fEmptyStr(fLArqTxt( '030', strArqImpressao ).Strings[0]) Then
        Begin
          strMsg := fLArqTxt( '030', strArqImpressao ).Strings[0];
          pMostraMensTEF(frmFormAtual, strMsg);
          TLogTef.pLoga('TTef.fTransNegada', 'Exibiu a mensagem no PANEL: ' + strMsg);
        End;
      End;
    End;

    {************************************}
    {* DELETA ARQUIVO DE RETORNO        *}
    {*********************************WI*}
    If Not Result Then
    Begin
      TLogTef.pLoga('TTef.fTransNegada', 'Result FALSE, vai deletar os arquivos de retorno!');
      DeleteFile( strArqImpressao );
      DeleteFile( ExtractFilePath( strArqImpressao ) + 'INTPOS.STS' );
      pRealizarBackup;
    End;

  Finally
    //VS_objFiscal.fIniciaModoTEF;
  End;

  TLogTef.pLoga('TTef.fTransNegada', 'Finalizando a função, valores: ' + fBoleanoToStr(Result));
End;

{**********************************************************}
{* -> RETORNA NOME DE ARQUIVO PARA CUPOM TEF              *}
{*******************************************************WI*}
function TTef.fRetArquivoTEF: String;
  Var
    intContador: Integer;
Begin

  For intContador := 1 To VS_Tef_Qtd Do
  Begin
    If Not FileExists(VS_Tef_Imp + fStrZero(intContador, 03)) Then
    Begin
      Result := VS_Tef_Imp + fStrZero(intContador, 03);
      Break;
    End;
  End;

End;

function TTef.fRetornaMensStatusTEF(frmNomeForm: TForm): String;
  Var
    intContador: Integer;
Begin
  Result := '';
  For intContador := 0 To frmNomeForm.ComponentCount-1 Do
  Begin
    If frmNomeForm.Components[intContador].Name = 'pnlStatusCaixa' Then
    Begin
      Result := (frmNomeForm.Components[intContador] As TPanel).Caption;
      Break;
    End;
  End;
End;

{**********************************************************}
{* -> RENOMEIA ARQUIVO                                    *}
{*******************************************************WI*}
function TTef.fRenomearArquivo(strArqOrigem, strArqDestino: String): Boolean;
  Var
    intQtdSegundos : Integer;
    timHoraAnterior: TTime;
Begin
  Result := False;

  timHoraAnterior := SysUtils.Time;

  While True Do
  Begin
    Application.ProcessMessages;

    If RenameFile( strArqOrigem, strArqDestino ) Then
    Begin
      Sleep(300);
      pRealizarBackup;
      Result := True;
      Break;
    End;

    intQtdSegundos := SecondOfTheDay( SysUtils.Time ) - SecondOfTheDay( timHoraAnterior );
    If ( intQtdSegundos > 5 ) Then
      Break;
  End;

End;

function TTef.fConverteTextoTEF(stlTexto: TStringList): String;
  Var
    intContador: Integer;
begin
  Result := '';

  For intContador := 0 To stlTexto.Count -1 Do
  Begin
    Result := Result + AnsiReplaceStr(stlTexto[intContador], '"', '');
    If intContador < stlTexto.Count -1 Then
      Result := Result + #13#10;
  End;
end;

{**************************************}
{* CRIA UM TEF DE ACORDO COM A        *}
{* IMPRESSORA SELECIONADA             *}
{***********************************AF*}
class function TTef.fCriarTEF(Owner: TComponent; strModelo: String; Form: TForm;
  strCodEcf: String; objFiscal: TFiscalBrd; blnImpComprovante: Boolean): TTef;
begin

  Result := Nil;

  If fCfgSis('TIPTEF') = 'E' Then
  Begin
    If blnImpComprovante Then
    Begin
      If (strModelo = 'SWEDA ST120') Then
        Result := TTefPadraoDedicado.Create(Owner, Form, strCodEcf, objFiscal)
      Else If (strModelo = 'SWEDA 9000III') Or (strModelo = 'SWEDA 7000') Then
        Result := TTefSwedaDedicado.Create(Owner, Form, strCodEcf, objFiscal)
      Else If Assigned(objFiscal) Then
        Result := TTefPadraoDedicado.Create(Owner, Form, strCodEcf, objFiscal);
    End
    Else
    Begin
      Result := TTefPadraoDedicado.Create(Owner, Form, strCodEcf, objFiscal);
    End;
  End

  Else If (Not blnImpComprovante) Then
  Begin
    Result := TTefPadraoDedicado.Create(Owner, Form, strCodEcf, objFiscal);
  End

  Else If (strModelo = 'BEMATECH-MP2100THFI / MP40')  Or
          (strModelo = 'BEMATECH-MP25FI OU SUPERIOR') Or
          (strModelo = 'BEMATECH-MP20')               Or
          (strModelo = 'SWEDA ST120')                 Or
          (strModelo = 'ELGIN 1FIT')                  Or
          (strModelo = 'DARUMA FS700 OU SUPERIOR')    Or
         ((strModelo = 'DARUMA') And (VS_strUsaTef = 'S')) Then
  Begin
    Result := TTefBematech.Create(Owner, Form, strCodEcf, objFiscal);
  End;

  If Assigned(Result) Then
  Begin
    Result.blnImpComprovante := blnImpComprovante;
  End;

end;

constructor TTef.Create(Owner: TComponent);
  Var
    strPathLocal: String;
    strPastaLog: String;
  function fPermiteCriarImpressoraFiscal: Boolean;
    Var
      blnTef_TS: Boolean;
  begin
    blnTef_TS := fCfgSis('TEF_TS', varBoolean);
    Result := (blnTef_TS)                                 And
              (DirectoryExists('\\tsclient\c\TEF_DIAL\'));
  end;
begin
  FstrCardSe := '' ;
  FstrTipDeb := '0' ;
  FstrTipoCartao := 'C' ;
  blnAtvAntesComandos := True;
  stlArqTefMod := TStringList.Create;
  stlArqTefCodMod := TStringList.Create;

  //blnUsaImp    := Not VS_blnTesTef; //VARIAVEL DE TESTE -->> False para teste
  blnUsaImp    := Not VS_blnTesTef;
  strPathLocal := fCfgSisL('DIRINI');
  strTefTra    := fCfgSisL('TEFTRA');
  strQtdCol    := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'QTDCOL', '', strPathLocal + '/opcoes_fiscal.ini');
  VS_Tef_G_P   := fArqIni(0, 'TEF', 'PATHGP',  '');
  VS_Tef_Res   := fArqIni(0, 'TEF', 'RESPOSTA',   '');
  VS_Tef_Ret   := fArqIni(0, 'TEF', 'ARQRETORNO', '');
  VS_Tef_Imp   := fArqIni(0, 'TEF', 'IMPRESSAO',  '');
  VS_Tef_Req   := fArqIni(0, 'TEF', 'REQUISICAO', '');
  VS_Tef_Bkp   := '';
  VS_Tef_Qtd   := 10;

  If fEmptyStr(strQtdCol) Then
    strQtdCol := '40';

  If fEmptyStr(VS_Tef_G_P) Then
    VS_Tef_G_P := 'C:\TEF_DIAL\TEF_DIAL.EXE';

  If fEmptyStr(VS_Tef_Res) Then
    VS_Tef_Res := 'C:\TEF_DIAL\RESP\';

  If fEmptyStr(VS_Tef_Ret) Then
    VS_Tef_Ret := 'C:\TEF_DIAL\RESP\INTPOS.001';

  If fEmptyStr(VS_Tef_Imp) Then
    VS_Tef_Imp := 'C:\TEF_DIAL\RESP\IMPCUP.';

  If fEmptyStr(VS_Tef_Req) Then
    VS_Tef_Req := 'C:\TEF_DIAL\REQ\';

  If fEmptyStr(VS_Tef_Bkp) Then
    VS_Tef_Bkp := 'C:\TEF_DIAL\BKP\';

  If RightStr(VS_Tef_Bkp, 1) <> '\' Then
    VS_Tef_Bkp := VS_Tef_Bkp + '\';

  FLogErr := TStringList.Create;

  strPastaLog := ExtractFilePath(VS_Tef_G_P);
  FArqLog := strPastaLog + 'LOG'+ FormatDateTime('hhnnsss', fTime());

  If fPermiteCriarImpressoraFiscal Then
  Begin
    VS_Tef_G_P := '\\tsclient\c\TEF_DIAL\TEF_DIAL.EXE';
    VS_Tef_Res := '\\tsclient\c\TEF_DIAL\RESP\';
    VS_Tef_Ret := '\\tsclient\c\TEF_DIAL\RESP\INTPOS.001';
    VS_Tef_Imp := '\\tsclient\c\TEF_DIAL\RESP\IMPCUP.';
    VS_Tef_Req := '\\tsclient\c\TEF_DIAL\REQ\';
    VS_Tef_Bkp := '\\tsclient\c\TEF_DIAL\BKP\';

    strPastaLog := ExtractFilePath(VS_Tef_G_P);
    FArqLog := strPastaLog + 'LOG'+ FormatDateTime('hhnnsss', fTime());

    If Not DirectoryExists(strPastaLog) Then
      CreateDir(strPastaLog);
  End;

  If Not DirectoryExists(strPastaLog) Then
    CreateDir(strPastaLog);

  FCGCEmp := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp], False);
  FCGCCit := fCfgSis('SFTSAT', varString);

  pRestauraBackup;
end;

procedure TTef.setTefTra(const Value: String);
begin
  FTefTra := Value;
  fAtuCfgSis('TEFTRA', FTefTra);
end;

procedure TTef.setCodEcf(const Value: String);
  Var
    qryGen: TUniQuery;
begin
  FCodEcf := Value;

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Add('SELECT   ');
    SQL.Add('  *      ');
    SQL.Add('FROM     ');
    SQL.Add('  ECFMOD ');
    SQL.Add('WHERE    ');
    SQL.Add('  ECF_CODECF = :CODECF AND ');
    SQL.Add('  ECF_IDENTI = "3" ');
    ParamByName('CODECF').AsString := FCodEcf;
    Open;
  End;

  VS_EcfCar := qryGen.FieldByName('ECF_CODMOD').AsString;
  VS_DesCar := qryGen.FieldByName('ECF_DESMOD').AsString;
  FreeAndNil(qryGen);
end;

function TTef.fRetArquivos(strPath: String): TStringList;
  Var
    arquivos: TSearchRec;
begin

  REsult := TStringList.Create;

  If FindFirst(strPath, faArchive, arquivos) = 0 Then
  Begin
    Repeat
      Result.Add(arquivos.Name);
    Until FindNext(arquivos) <> 0;
    FindClose(arquivos);
  End;

end;

{*****************************************}
{* ATENÇÃO: UTILIZAR ESSA FUNÇÃO APENAS  *}
{* PARA IMPRIMIR AS PENDENCIAS.          *}
{**************************************MV*}
function TTef.fImpressaoPendencias(strArqImpressao: String; intContCup: Integer): Boolean;
  Var
    blnRetornoImp  : Boolean;
    blnReimprimir  : Boolean;
    strStatus      : String;
Begin
  blnRetornoImp := False;
  blnReimprimir := True;

  While True Do
  Begin
    Application.ProcessMessages;

    {************************************}
    {* -> IMPRIME CUPOM                 *}
    {*********************************WI*}
    If blnImpComprovante Then
      blnRetornoImp := fTefImpCup( blnReimprimir, fLArqTxt( '029', strArqImpressao ), False, intContCup, '' )
    Else
    Begin
      pImprimirTef(fConverteTextoTEF(fLArqTxt('029', strArqImpressao)), fLArqTxt( '028-001', strArqImpressao )[0]);
      blnRetornoImp := True;
    End;

    If ( Not blnRetornoImp ) And ( Not blnReimprimir ) Then
      Break;

    If (blnRetornoImp) Then
    Begin
      Application.ProcessMessages;

      If blnImpComprovante Then
      Begin
        strStatus := VS_objFiscal.fStatusImpressora;
        blnReimprimir := False;
        If (fErrImpressora(blnReimprimir)) Then
        Begin
          VS_objFiscal.fFechaCNFVinculado(False); //alex relger
        End;
      End;
      Application.ProcessMessages;

      Break;
    End;

  End;

  Result := blnRetornoImp;

End;


function TTef.fProcessaArqPen: Boolean;
  Var
    strArqPen: String;
    arrMatRet: arrTStringList;
    strMensMostra: String;
begin
  strArqPen := VS_Tef_Req + 'INTPOS.PEN';

  Result := False;
  strMensMostra := '';
  If Not FileExists(strArqPen) Then
  Begin
    Result := True;
    Exit;
  End;

  If Not fTef_Atv Then
  Begin
    Exit;
  End;

  If fLArqTxt( '000', strArqPen)[0] = 'NCN' Then
  Begin

    pInicializaMatRet(arrMatRet);

    arrMatRet[ TF_strProIde ] := fLArqTxt( '001', strArqPen );   // Numero da Identificacao
    arrMatRet[ TF_strNomRed ] := fLArqTxt( '010', strArqPen );   // Nome da Rede
    arrMatRet[ TF_strNumTra ] := fLArqTxt( '012', strArqPen );   // Numero da Transacao
    arrMatRet[ TF_strDtaTra ] := fLArqTxt( '022', strArqPen );   // Data da Transacao DDMMAAAA
    arrMatRet[ TF_strHorTra ] := fLArqTxt( '023', strArqPen );   // Hora da Transacao HHMMSS
    arrMatRet[ TF_strChaFin ] := fLArqTxt( '027', strArqPen );   // Chave para Finalizacao
    arrMatRet[ TF_intQtdLin ] := fLArqTxt( '028', strArqPen );   // Qtd Linhas do Comprovante
    arrMatRet[ TF_lslLinImp ] := fLArqTxt( '029', strArqPen );   // Matriz com as linhas para impressao
    arrMatRet[ TF_curValRet ] := fLArqTxt( '003', strArqPen );   // Valor do Cupom
    arrMatRet[ TF_strMensag ] := fLArqTxt( '030', strArqPen );   // Mensagem
    arrMatRet[ TF_strStatus ] := fLArqTxt( '009', strArqPen );   // Status da Transacao
    arrMatRet[ TF_strOcorre ].Strings[0] := '0';                 // Ocorrencia 0-False 1-True

    strMensMostra := 'Última transação foi cancelada: '+#13+#10+#13+#10;

    If Not fEmptyStr( arrMatRet[ TF_strNomRed ].Strings[0] ) Then
      strMensMostra := strMensMostra + 'Rede: ' + arrMatRet[ TF_strNomRed ].Strings[0] + #13+#10;

    If Not fEmptyStr( arrMatRet[ TF_strNumTra ].Strings[0] ) Then
      strMensMostra := strMensMostra + 'NSU.: ' + arrMatRet[ TF_strNumTra ].Strings[0]+#13+#10;

    If StrToCurr( arrMatRet[ TF_curValRet ].Strings[0] ) > 0  Then
      strMensMostra := strMensMostra + 'Valor: ' + FormatFloat( '#,##0.00', StrToCurr( arrMatRet[ TF_curValRet ].Strings[0] ) / 100 )+#13+#10;

  End;

  fRenomearArquivo(strArqPen, VS_Tef_Req + 'INTPOS.001');

  Sleep(2500);

  If Not fEmptyStr(strMensMostra) Then
  Begin
    SetForegroundWindow(Application.Handle);
    //VS_objFiscal.fFinalizaModoTEF;
    fMensagem( '', strMensMostra, ['&O k'] );
  End;

  Result := True;

end;

{*****************************************}
{* FAZ BACKUP DA PASTA RESP.             *}
{**************************************MV*}
procedure TTef.pRealizarBackup;
  Var
    stlArquivos: TStringList;
    intContador: Integer;
begin

  If Not DirectoryExists(VS_Tef_Bkp) Then
    CreateDir(VS_Tef_Bkp);

  stlArquivos := fRetArquivos(VS_Tef_Bkp + '*.*');
  For intContador := 0 To stlArquivos.Count -1 Do
  Begin
    DeleteFile(VS_Tef_Bkp + stlArquivos[intContador]);
  End;
  FreeAndNil(stlArquivos);

  stlArquivos := fRetArquivos(VS_Tef_Res + '*.*');
  For intContador := 0 To stlArquivos.Count -1 Do
  Begin
    CopyFile(PChar(VS_Tef_Res + stlArquivos[intContador]),
             PChar(VS_TEf_bkp + stlArquivos[intContador]),
             True);
  End;
  FreeAndNil(stlArquivos);

end;

{*****************************************}
{* RESTAURA OS ARQUIVOS DE BACKUP PARA A *}
{* PASTA RESP.                           *}
{**************************************MV*}
procedure TTef.pRestauraBackup;
  Var
    stlArquivos: TStringList;
    intContador: Integer;
begin
  stlArquivos := fRetArquivos(VS_Tef_Bkp + '*.*');
  For intContador := 0 To stlArquivos.Count -1 Do
  Begin
    CopyFile(PChar(VS_Tef_Bkp + stlArquivos[intContador]),
             PChar(VS_TEf_Res + stlArquivos[intContador]),
             True);
  End;
  FreeAndNil(stlArquivos);
end;

function TTef.fVerificaNumeroTransacao(strArqRet, strNumTra: String): Boolean;
  Var
    strTraRes: String;
    intQtdTen: Integer;
begin

  intQtdTen := 0;

  Result := False;

  While (intQtdTen <= 5) And
        (Not Result)     Do
  Begin

    Try
      strTraRes := fLArqTxt('001', strArqRet)[0];
      Result    := (strTraRes = strNumTra);
      Break;
    Except
      Sleep(300);
      Inc(intQtdTen);
      Result := False;
    End;

  End;
end;

function TTef.fVerificaPicote(intImpressao: Integer; filaPicote: TQueue<Integer>): Boolean;
begin
  Result := (filaPicote.Count = 0);
  If Not Result Then
  Begin
    Result := (intImpressao+1 < filaPicote.Peek);
  End;
end;

function TTef.fValorSaque: Double;
begin
  Result := 0;
end;

procedure pRetDadosCartao(strNomRed, strNomBan, strTipTra: String; intQtdPar: Integer; Var strCodCar: String; const AstrCardSe: String; var AstrCodEmp: String; const AstrTipDeb: Char; const AstrTipoCartao: String);
  Var
    qryAux: TUniQuery;
    LstrTefCit: String;
    LFiltroPesquisaCartao: TParamEntradaPesquisaCartao;
    LRetornoPesquisaCartao: TRetornoPesquisaCartao;

  procedure pOpenDadosCartao(const AtpacBusca: TTipoPesquisaAmarrarCartao);
  begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT CAR_CODCAR, CAR_CODEMP ');
    qryAux.SQL.Add('  FROM CADCAR ');
    qryAux.SQL.Add(' WHERE :QTDPAR BETWEEN CAR_SUGPAR AND CAR_MAXPAR ');

    If AtpacBusca = tpaEmpresa Then
    begin
      qryAux.SQL.Add(' AND CAR_CODEMP = :CODEMP ');
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    end
    else If AtpacBusca = tpaEmpresaNull Then
    begin
      qryAux.SQL.Add(' AND CAR_CODEMP IS NULL ');
    end
    else If AtpacBusca = tpaEmpresaNotNull Then
    begin
      qryAux.SQL.Add(' AND CAR_CODEMP IS NOT NULL ');
    end ;

    if VS_blnTefCitel then
    begin
      LstrTefCit := fCfgSis('TEFCIT', varString) ;
      qryAux.SQL.Add('   AND ' + IfThen(LstrTefCit=OPCAO_CLISITEF, 'CAR_TFTRED', 'CAR_TFRED2') + ' = :NOMRED ');
      qryAux.SQL.Add('   AND ' + IfThen(LstrTefCit=OPCAO_CLISITEF, 'CAR_TFTBAN', 'CAR_TFBAN2') + ' = :NOMBAN ');
      qryAux.SQL.Add('   AND COALESCE(CAR_CARDSE, "") = :CARDSE ');
      qryAux.SQL.Add('   AND COALESCE(CAR_TIPDEB, "0") = :TIPDEB ');
      qryAux.ParamByName('CARDSE').AsString := AstrCardSe;
      qryAux.ParamByName('TIPDEB').AsString := AstrTipDeb;
    end
    else
    begin
      qryAux.SQL.Add('   AND CAR_NOMRED = :NOMRED ');
      qryAux.SQL.Add('   AND CAR_NOMBAN = :NOMBAN ');
      qryAux.SQL.Add('   AND CAR_TIPTRA = :TIPTRA ');
    end;
    qryAux.SQL.Add('   AND CAR_STATUS = "S" ');
    qryAux.SQL.Add(' ORDER BY CAR_MAXPAR, CAR_CODEMP ');
    qryAux.ParamByName('QTDPAR').AsInteger := intQtdPar;

    qryAux.ParamByName('NOMRED').AsString := strNomRed;
    qryAux.ParamByName('NOMBAN').AsString := strNomBan;

    if not VS_blnTefCitel then
      qryAux.ParamByName('TIPTRA').AsString := strTipTra;

    qryAux.Open;
    pGravaLogCadCar(qryAux) ;
  end;

begin
  if fCadastroCartaoParamAutTef then
  begin
    FillChar(LFiltroPesquisaCartao, SizeOf(TParamEntradaPesquisaCartao), #0);
    LFiltroPesquisaCartao.codigo_empresa := VS_strCodEmp ;
    LFiltroPesquisaCartao.tipo_cartao := TUtilCadastroCartaoTef.fGetTipoCartao(AstrTipoCartao) ;
    LFiltroPesquisaCartao.tipo_debito := AstrTipDeb ;
    LFiltroPesquisaCartao.parcela := intQtdPar ;
    LFiltroPesquisaCartao.codigo_rede := strNomRed ;
    LFiltroPesquisaCartao.codigo_bandeira := strNomBan ;
    LFiltroPesquisaCartao.codigo_cardse := AstrCardSe ;

    LRetornoPesquisaCartao := TRetornoDadosCartaoTef.fRetornaCodigoCartao(LFiltroPesquisaCartao);

    strCodCar := LRetornoPesquisaCartao.codigo_cartao ;
    AstrCodEmp := LRetornoPesquisaCartao.codigo_empresa ;
    exit ;
  end ;

  qryAux := fCriaQuery(Nil);
  Try
    pOpenDadosCartao(tpaEmpresa);

    If (qryAux.IsEmpty) Then
    begin
      pOpenDadosCartao(tpaEmpresaNull);
      If (qryAux.IsEmpty) Then
        pOpenDadosCartao(tpaEmpresaNotNull);
    end ;

    strCodCar := qryAux.FieldByName('CAR_CODCAR').AsString;
    AstrCodEmp := qryAux.FieldByName('CAR_CODEMP').AsString;
    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure TTef.pPosNumerosSeq(strArqImp: String; Var strCCD: String; Var strNSU: String);
  var
    objAmarraCartao : TAmarraCartao;
    strCodCar: string;
begin
  objAmarraCartao := TAmarraCartao.Create(FNomRed, FNomBan, FTipTra, FQtdPar, FstrCardSe, FstrTipDeb, FstrTipoCartao);
  Try
    objAmarraCartao.pPosNumerosSeq(strArqImp, strCCD, strNSU, strCodCar);
  Finally
    FreeAndNil(objAmarraCartao);
  End;
End;

procedure TTef.pPreparaFilaPicotes(fila: TQueue<Integer>;
  strArqImp: String; intQtdVia: Integer);
  Var
    strPicotes: String;
    stlValores: TStringList;
    strValor: String;
    intContador: Integer;
    intQtdLin: Integer;
begin
  strPicotes := fLArqTxt('028-001', strArqImp)[0];

  If fEmptyStr(strPicotes) Then
  Begin
    For intContador := 1 To intQtdVia Do
    Begin
      fila.Enqueue(MaxInt); //Não aciona guilhotina no meio da impressão
    End;
  End
  Else
  Begin
    intQtdLin := StrToInt(fLArqTxt('028-000', strArqImp)[0]);
    stlValores := TStringList.Create;
    ExtractStrings([':'], [], PWideChar(strPicotes), stlValores);

    For intContador := 1 To intQtdVia Do
    Begin
      For strValor In stlValores Do
      Begin
        fila.Enqueue(StrToInt(strValor));
      End;

      If intContador <> intQtdVia Then
      Begin
        fila.Enqueue(intQtdLin);
      End;
    End;
    FreeAndNil(stlValores);
  End;
end;

function fSelecionaCartao(qryTabela: TUniQuery; strQtdPar: String; Var arrSel: TConsultasArray; Var strCodCar: String): Boolean;
  Var
    strSQL     : String;
    strWhere   : String;
    qryConsulta: TUniQuery;
begin
  Result := False;
  strCodCar := '';

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CAR_CODCAR,       ';
    strSQL := strSQL + '  CAR_DESCAR,       ';
    strSQL := strSQL + '  CAR_CODEMP,       ';
    strSQL := strSQL + '  CAR_SUGPAR,       ';
    strSQL := strSQL + '  CAR_MAXPAR,       ';
    strSQL := strSQL + '  CAR_PERDES,       ';
    strSQL := strSQL + '  CAR_PERIOD,       ';
    strSQL := strSQL + '  CAR_CONCON,       ';
//    strSQL := strSQL + '  CAR_POSCCD,       ';
//    strSQL := strSQL + '  CAR_POSNSU,       ';
    strSQL := strSQL + '  AUTOINCREM        ';
    strSQL := strSQL + 'FROM                ';
    strSQL := strSQL + '  CADCAR            ';

    strWhere := ' WHERE TRUE ';
    strWhere := strWhere + ' AND CAR_STATUS = "S"  ';
    strWhere := strWhere + ' AND ' + strQtdPar + ' BETWEEN CAR_SUGPAR AND CAR_MAXPAR ';

    strWhere := strWhere + ' AND (CAR_CODEMP = "" OR ';
    strWhere := strWhere + '      CAR_CODEMP IS NULL OR ';
    strWhere := strWhere + '      CAR_CODEMP = ' + QuotedStr(VS_strCodEmp) + ') ';

    If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strWhere := strWhere + '  AND (IFNULL(CAR_PORBAI, "") = "" ';
      strWhere := strWhere + '  OR LOCATE(CAR_PORBAI, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';

      strWhere := strWhere + '  AND (IFNULL(CAR_PORTAX, "") = "" ';
      strWhere := strWhere + '  OR LOCATE(CAR_PORTAX, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';

      strWhere := strWhere + '  AND (IFNULL(CAR_PORBAD, "") = "" ';
      strWhere := strWhere + '  OR LOCATE(CAR_PORBAD, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    If Not Assigned(qryTabela) Then
      qryConsulta := fCriaQuery(Nil)
    Else
      qryConsulta := qryTabela;

    Result := fConsulta([strSQL, strWhere],
                        ['Código', 'Descrição', 'Empresa', 'Min.Par.', 'Max.Par.', 'Desconto(%)', 'Prazo', 'Conta Contábil', 'AUTOINCREM'],
                        ['CAR_DESCAR','CAR_CODEMP','CAR_CODCAR'],
                         '',
                         'CADCAR',
                         'untFunTef',
                         'Selecione o Cartão',
                         qryConsulta,
                         Nil,
                         True,
                         arrSel,
                         'CAR_CODCAR');

    If Result Then
      strCodCar := qryConsulta.FieldByName('CAR_CODCAR').AsString;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  If Not Assigned(qryTabela) Then
    FreeAndNil(qryConsulta);

End;

function fPopularTabelaPOSDOC(var qryPos : TUniQuery): Boolean;

  Var
    intIndice : Integer;

  procedure pInsert(strDescri: String);
  begin
    intIndice := intIndice + 1;
    qryPos.Insert;
    qryPos.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('POSDOC', VS_strCodEmp);
    qryPos.FieldByName('DOC_INDICE').AsInteger := intIndice;
    qryPos.FieldByName('DOC_DESCRI').AsString := strDescri;
    qryPos.Post;
  end;

begin
  If Not fTabelaExiste('POSDOC', True) Then
    Result := False
  Else
  Begin
    Try
      With qryPos Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM POSDOC ORDER BY DOC_INDICE');
        Open;

        If (IsEmpty) Then
        Begin
          intIndice := 0;
          pInsert('DOC= ');
          pInsert('DOC=');
          pInsert('DOC:');
          pInsert('CV:               ');
          pInsert('CV: ');
          pInsert('CV:');
          pInsert('NSU BERGS:');
          pInsert('COMPROV: ');
          pInsert('NSU HOST ');
          pInsert('COMPR:');
        End;

        Result := (Not IsEmpty);
      End;
    Except
      Result := False;
    End;
  End;
end;

function fPopularTabelaPOSAUT(var qryPos : TUniQuery): Boolean;

  Var
    intIndice : Integer;

  procedure pInsert(strDescri: String);
  begin
    intIndice := intIndice + 1;

    qryPos.Insert;
    qryPos.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('POSAUT', VS_strCodEmp);
    qryPos.FieldByName('AUT_INDICE').AsInteger := intIndice;
    qryPos.FieldByName('AUT_DESCRI').AsString := strDescri;
    qryPos.Post;
  end;

begin
  If Not fTabelaExiste('POSAUT', True) Then
    Result := False
  Else
  Begin
    Try
      With qryPos Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT * FROM POSAUT ORDER BY AUT_INDICE');
        Open;

        If (IsEmpty) Then
        Begin
          intIndice := 0;
          pInsert('AUT= ');
          pInsert('AUT=');
          pInsert('AUT:');
          pInsert('AUTORIZ.=');
          pInsert('AUTO: ');
          pInsert('AUTO:');
          pInsert('NSU BANDEIRA:');
          pInsert('AUTORIZACAO:      ');
          pInsert('AUTORIZACAO: ');
        End;

        Result := (Not IsEmpty);
      End;
    Except
      Result := False;
    End;
  End;
end;

function fTefHabilitado: Boolean;
begin
  Result := True ;

  if Assigned(VS_objTef) then
    Exit ;


  if VS_blnTefCitel then
    Exit ;

  Result := False ;
end;

function TTef.fLerConteudoArq(const strArquivo: String): String;
Var
  stlArq: TStringList;
  intCnt: integer;
  strCodLin: string;
begin
  try
    stlArq := TStringList.Create;
    try
      stlArq.LoadFromFile(strArquivo);

      if fCfgSis('ARQRED') = 'S' then
      begin
        Result := '';
        for intCnt := 1 to stlArq.Count -1 do
        begin
          strCodLin := copy(stlArq[intCnt], 1,3);
          if strCodLin <> '029' then
          begin
            if not fEmptyStr(Result) then
              Result := Result +#13+ stlArq[intCnt]
            else
              Result := Result + stlArq[intCnt];
          end;
        end;
      end
      else
        Result := stlArq.Text;
    except
    end;
  finally
    FreeAndNil(stlArq);
  end;
end;


end.
