{**************************************}
{* CLASSE DE TEF DA SWEDA             *}
{***********************************AF*}
unit untTefSweda;

interface

uses Windows, SysUtils, Forms, Classes, untFunTef, untFiscal;

Type
  {****************************************}
  {* FUNCOES PARA SWEDA 9000III           *}
  {****************************************}
  {* CASO DIFERENCIAR METODOS HERDAR E    *}
  {* SOBRESCREVER METODOS PARA IMPRESSORA *}
  {* NOVA DEIXAR ESSA CLASSE APENAS OS    *}
  {* METODOS EM COMUM DAS DUAS            *}
  {*************************************AF*}
  TTefSweda = Class(TTef)
  Private

  Public
    function fTefFinRet(blnFazerLeituraX: Boolean = False; strArqCancelamento: String = ''; blnCancelamento: Boolean = False; blnChamadaADM: Boolean = False): Boolean; Override;
    function fTefImpCup(Var blnReimprimir: Boolean; arrMatImp: TStringList; blnFazerLeituraX: Boolean; intContadorCupom: Integer; strArqImp: String): Boolean; Override;
    function fErrImpressora(Var blnReimprimir: Boolean; blnOpcaoSimNao: Boolean = True; blnFechaVinculado: Boolean = True): Boolean; Override;
    function fPendenciaTEF: Boolean; Override;
    function fVerificaReducaoZ: Boolean; Override;

    Constructor Create(Owner: TComponent; Form: TForm; strCodEcf: String; objFiscal: TFiscalBrd); Reintroduce;
  End;

implementation

uses untFuncoesSimples, untFuncoes, untLogTef;

{**********************************************************}
{* FINALIZA / IMPRIME INFORMACOES RETORNO                 *}
{*******************************************************WI*}
function TTefSweda.fTefFinRet(blnFazerLeituraX: Boolean = False; strArqCancelamento: String = ''; blnCancelamento: Boolean = False; blnChamadaADM: Boolean = False): Boolean;
  Var
    blnRetornoImp  : Boolean;
    blnReimprimir  : Boolean;
    blnTransNegada : Boolean;
    arrArquivos    : TStringList;
    strStatus      : String;
    strArqImpressao: String;
    intContador    : Integer;
Begin
  blnRetornoImp  := False;
  blnTransNegada := False;
  strStatus      := '';

  {************************************}
  {* -> PEGA OS ARQUIVOS TEF CONFIRMA-*}
  {*    DOS                           *}
  {*********************************WI*}
  arrArquivos := TStringList.Create;

  If FileExists(VS_Tef_Ret) Then
    arrArquivos.Add(VS_Tef_Ret);

  If Not blnCancelamento Then
  Begin
    For intContador := 1 To VS_Tef_Qtd Do
    Begin
      If FileExists(VS_Tef_Imp + fStrZero(intContador, 03)) Then
        arrArquivos.Add(VS_Tef_Imp + fStrZero(intContador, 03));
    End;
  End;

  {************************************}
  {* -> LOOP PARA DESLIGAMENTO IMPRES.*}
  {*********************************WI*}
  If blnCancelamento Then
    blnReimprimir := True
  Else
    blnReimprimir := False;

  While True Do
  Begin
    Application.ProcessMessages;
    intContador := 0;

    {************************************}
    {* -> PROCESSA OS ARQUIVOS          *}
    {*********************************WI*}
    While intContador <= ( arrArquivos.Count-1 ) Do
    Begin
      Application.ProcessMessages;

      strArqImpressao := arrArquivos.Strings[intContador];

      TLogTef.pLoga('untTefSweda.fTefFinRet', 'While dos arquivos, vai verificar "fTransNegada"');

      {************************************}
      {* -> IMPRIME CUPOM                 *}
      {*********************************WI*}
      If fTransNegada( strArqImpressao) Then
      Begin
        blnRetornoImp := fTefImpCup( blnReimprimir, fLArqTxt( '029', strArqImpressao ), blnFazerLeituraX, intContador, '' );

        TLogTef.pLoga('untTefSweda.fTefFinRet', '(fTransNegada=True) (fTefImpCup=' + fBoleanoToStr(blnRetornoImp) + ')');
      End
      Else
      Begin
        TLogTef.pLoga('untTefSweda.fTefFinRet', '(fTransNegada=False)');
        blnTransNegada := True;
        Break;
      End;
      Inc( intContador );

      If Not blnRetornoImp Then
        Break;

    End;

    If blnTransNegada Then
      Break;

    If ( Not blnRetornoImp ) And ( Not blnReimprimir ) Then
      Break;

    If blnRetornoImp And ( (intContador-1) = (arrArquivos.Count-1) ) Then
      Break;

  End;

  FreeAndNil( arrArquivos );

  Result := blnRetornoImp;

  pMostraMensTEF(frmFormAtual, '');
  

  {************************************}
  {* -> CASO TENHA SIDO CHAMADO PELO  *}
  {*    ADM, ENVIA OU NAO CONFIRMACAO *}
  {*********************************WI*}
  If blnChamadaADM Then
  Begin
    TLogTef.pLoga('untTefSweda.fTefFinRet', '(blnChamadaADM=True) vai chamar "pVerificaCncNcn"');
    pVerificaCncNcn( blnChamadaADM, Result );
  End;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  If Result Then
  Begin
    If Not blnCancelamento Then
    Begin
      pDelArqRet;
    End;
  End;

  If blnUsaImp Then
  Begin

    strStatus := '';
    While True Do
    Begin
      Application.ProcessMessages;

      If ( Length( strStatus ) >= 6 ) And ( Copy( strStatus, 06, 01 ) = '0' ) Then
        Break;

      strStatus := VS_objFiscal.fStatusImpressora;

      If Not VS_objFiscal.fVerErro(True) Then
        Break;

    End;
    Application.ProcessMessages;
    VS_objFiscal.fExecutaCMD( '.12' );
    Application.ProcessMessages;

  End;

End;

{**********************************************************}
{* -> IMPRIME CUPOM DE RETORNO DA "REDE"                  *}
{*******************************************************WI*}
function TTefSweda.fTefImpCup(Var blnReimprimir: Boolean; arrMatImp: TStringList; blnFazerLeituraX: Boolean; intContadorCupom: Integer; strArqImp: String ): Boolean;
  Var
    strSeqOperacao : String;
    intPosicao     : Integer;
    intImpressao   : Integer;
    intQtdVia      : Integer;
    txfMatricial   : TextFile;
    blnTirouLeturaX: Boolean;
    strLinhaVinculado : String;
    intQtdLinVinculado: Integer;

Begin
  blnTirouLeturaX := False;
  Result          := True;
  intQtdVia       := 02;

  //Impressora matricial (não fiscal)
  If Not blnUsaImp Then
  Begin
    AssignFile( txfMatricial, 'LPT1' );
    ReWrite( txfMatricial );
  End
  Else
  Begin
    {************************************}
    {* -> SE FOR IMPRESSAO REF. A PEN-  *}
    {*    DENCIA (QUEDA DE ENERGIA)     *}
    {*********************************WI*}
    If (blnFazerLeituraX And (intContadorCupom = 0)) Or blnReimprimir Then
    Begin
      {************************************}
      {* -> TIRA UMA LEITURA X            *}
      {*********************************WI*}
      Application.ProcessMessages;
      VS_objFiscal.fExecutaCMD( '.12' );
      Sleep( 1000 );
      Application.ProcessMessages;
      VS_objFiscal.fExecutaCMD( '.12' );
      Application.ProcessMessages;
      Sleep( 1000 );
      VS_objFiscal.fExecutaCMD( '.13S' );
      VS_objFiscal.pPausaLeitura;

      {************************************}
      {* -> VERIFICA ERRO NA IMPRESSORA   *}
      {*********************************WI*}
      blnReimprimir := False;
      Result        := fErrImpressora( blnReimprimir );

      If blnReimprimir Or ( Not Result ) Then
        Exit;

      {************************************}
      {* -> SALTA LINHA NA IMPRESSORA     *}
      {*********************************WI*}
      VS_objFiscal.fExecutaCMD( '.08' + '9' + '' + '5' );

      blnTirouLeturaX := True;
    End;

    {************************************}
    {* -> ABRE COMPROVANTE NAO FISCAL   *}
    {*********************************WI*}
    If (Not blnTirouLeturaX) And (intContadorCupom = 0) Then
    Begin
      {************************************}
      {* -> PEGA SEQ. DE OPERACAO CCO     *}
      {*********************************WI*}
      strSeqOperacao := VS_objFiscal.fRetornaCOO;

      blnReimprimir := False;
      Result        := fErrImpressora(blnReimprimir);

      If blnReimprimir Or (Not Result) Then
        Exit;

      {************************************}
      {* -> ABRE CUPOM VINCULADO          *}
      {*********************************WI*}
      VS_objFiscal.fExecutaCMD( '.19'   +
                 '00'    +
                 fstrEspaco( strSeqOperacao, 04 ) +
                 fstrEspaco( VS_EcfCar, 02 ) +
                 fstrEspaco( '', 20 ) +
                 '01' );

      blnReimprimir := False;
      Result        := fErrImpressora( blnReimprimir );

      If blnReimprimir Or ( Not Result ) Then
        Exit;

    End;

  End;

  If Not Result Then
    Exit;

  {************************************}
  {* -> PROCESSA QTD. DE VIAS         *}
  {*********************************WI*}
  For intPosicao := 1 To intQtdVia Do
  Begin
    {************************************}
    {* -> PROCESSA MATRIZ PARA IMPRESSAO*}
    {*    DAS LINHAS DO CUPOM TEF       *}
    {*********************************WI*}
    intQtdLinVinculado := 0;
    For intImpressao := 0 To arrMatImp.Count-1 Do
    Begin
      Application.ProcessMessages;

      If intQtdLinVinculado = 0 Then
        strLinhaVinculado := '';

      strLinhaVinculado := strLinhaVinculado + '.08' + '0' + '' + fstrEspaco( arrMatImp.Strings[intImpressao], StrToInt(strQtdCol) );

      If (intQtdLinVinculado < 3) And (intImpressao < arrMatImp.Count-1) Then
      Begin
        strLinhaVinculado := strLinhaVinculado + #10#13;
        Inc(intQtdLinVinculado);
        Continue;
      End;

      //Impressora matricial (não fiscal)
      If Not blnUsaImp Then
      Begin
        WriteLn( txfMatricial, fstrEspaco( arrMatImp.Strings[intImpressao], 40 ) );
      End
      Else
      Begin

        VS_objFiscal.fExecutaCMD(strLinhaVinculado);
        Sleep( 200 );
        Application.ProcessMessages;

        {************************************}
        {* -> VERIFICA ERRO NA IMPRESSORA   *}
        {*********************************WI*}
        blnReimprimir := False;
        Result        := fErrImpressora( blnReimprimir );

        If blnReimprimir Or ( Not Result ) Then
          Exit;

      End;

      intQtdLinVinculado := 0;
      
      {//Impressora matricial (não fiscal)
      If Not blnUsaImp Then
      Begin
        WriteLn( txfMatricial, fstrEspaco( arrMatImp.Strings[intImpressao], 40) );
      End
      Else
      Begin
        VS_objFiscal.fExecutaCMD( '.08' + '0' + '' + fstrEspaco( arrMatImp.Strings[intImpressao], StrToInt(strQtdCol) ) );
        Sleep( 200 );
        Application.ProcessMessages;

        {************************************}
        {* -> VERIFICA ERRO NA IMPRESSORA   *}
        {*********************************WI*}
       { blnReimprimir := False;
        Result        := fErrImpressora( blnReimprimir );

        If blnReimprimir Or ( Not Result ) Then
          Exit;

      End;}

    End;

    If Not Result Then
      Break;

    {************************************}
    {* -> SALTA LINHA IMPRESSORA FISCAL *}
    {*********************************WI*}
    Sleep( 1000 );
    Application.ProcessMessages;

    //Impressora matricial (não fiscal)
    If Not blnUsaImp Then
    Begin
      WriteLn( txfMatricial, '' );
      WriteLn( txfMatricial, '' );
      WriteLn( txfMatricial, '' );
      WriteLn( txfMatricial, '' );
    End
    Else
      VS_objFiscal.fExecutaCMD( '.08' + '9' + '' + '5' );
      
  End;

  {************************************}
  {* -> FINALIZA RELATORIO GERENCIAL  *}
  {*********************************WI*}
  //Impressora matricial (não fiscal)
  If Not blnUsaImp Then
    CloseFile( txfMatricial );

End;

{**********************************************************}
{* -> VERIFICA ERRO NO ENVIO DE COMANDOS PARA IMPRESSORA  *}
{*    FISCAL                                              *}
{*******************************************************WI*}
function TTefSweda.fErrImpressora(Var blnReimprimir: Boolean; blnOpcaoSimNao: Boolean = True; blnFechaVinculado: Boolean = True): Boolean;
  Var
    strStatus       : String;
    strSalvaMensagem: String;
Begin
  Result           := True;
  strStatus        := '';
  strSalvaMensagem := fRetornaMensStatusTEF(frmFormAtual);

  //Impressora matricial (não fiscal)
  If Not blnUsaImp Then
    Exit;

  {************************************}
  {* -> VALIDA ERRO NA IMPRESSORA     *}
  {*********************************WI*}
  If VS_objFiscal.fVerErro( False ) Then
    Exit;

  While True Do
  Begin
    Application.ProcessMessages;
    blnReimprimir := False;
    Result        := False;

    If fMensagem( '', 'Impressora não Responde, Tentar Novamente?', ['',''] ) = 1 Then
      blnReimprimir := True;

    pMostraMensTEF(frmFormAtual, 'AGUARDE... Fazendo Leitura da Impressora Fiscal.');

    strStatus := VS_objFiscal.fStatusImpressora;
    strStatus := fStrEspaco( strStatus, 06 );
    If Copy( strStatus, 6, 1 ) = '0' Then
    Begin
      VS_objFiscal.fExecutaCMD( '.12' );
      Break;
    End;
  End;

  pMostraMensTEF(frmFormAtual, strSalvaMensagem);
End;

{**********************************************************}
{* -> VERIFICA SE EXISTE PENDENCIA A SER PROCESSADA       *}
{*******************************************************WI*}
function TTefSweda.fPendenciaTEF: Boolean;
  Var
    blnRetorna: Boolean;
Begin
  Result     := False;
  blnRetorna := True;

  If FileExists( VS_Tef_Imp + '001' )  Or
     FileExists( VS_Tef_Imp + '002' )  Or
     FileExists( VS_Tef_Imp + '003' )  Or
     FileExists( VS_Tef_Imp + '004' )  Or
     FileExists( VS_Tef_Imp + '005' )  Or
     FileExists( VS_Tef_Imp + '006' )  Or
     FileExists( VS_Tef_Imp + '007' )  Or
     FileExists( VS_Tef_Imp + '008' )  Or
     FileExists( VS_Tef_Imp + '009' )  Or
     FileExists( VS_Tef_Imp + '010' )  Or
     FileExists( VS_Tef_Ret )          Then
  Begin
     blnRetorna := False;
  End;

  If blnRetorna Then
    Exit;

  {************************************}
  {* -> VERIFICA CNC / NCN            *}
  {*********************************WI*}
  pVerificaCncNcn;

  If blnUsaImp Then
    VS_objFiscal.fExecutaCMD( '.12' );

  If fVerificaReducaoZ Then
    Result := True;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  pDelArqRet;
  SetForegroundWindow(frmFormAtual.Handle);
End;

{**********************************************************}
{* -> VERIFICA NECESSIDADE DE TIRAR UMA REDUCAO Z         *}
{*******************************************************WI*}
function TTefSweda.fVerificaReducaoZ: Boolean;
  Var
    strStatus : String;
    intPosicao: Integer;
Begin
  intPosicao := 21;
  Result     := True;
  strStatus  := VS_objFiscal.fExecutaCMD( '.28', True );

  If UpperCase( Copy( strStatus, intPosicao, 01 ) ) = 'F' Then
  Begin

    If fMensagem( '', 'É Preciso fazer uma REDUÇÃO Z. Deseja Fazer agora?', ['',''], 2 ) = 1 Then
    Begin

      VS_objFiscal.fExecutaCMD( '.14N' + FormatDateTime( 'DDMMYY', Date ) );
      VS_objFiscal.pPausaLeitura;

      If VS_objFiscal.fVerErro Then
      Begin
        VS_objFiscal.fExecutaCMD( '.13N' );
        VS_objFiscal.pPausaLeitura;
      End
      Else
        Result := False;

    End
    Else
    Begin
      Result := False;
    End;

  End;

End;

constructor TTefSweda.Create(Owner: TComponent; Form: TForm; strCodEcf: String; objFiscal: TFiscalBrd);
begin
  inherited Create(Self);
  Self.frmFormAtual := Form;
  Self.strCodEcf    := strCodEcf;
  Self.VS_objFiscal := objFiscal;
end;

end.

