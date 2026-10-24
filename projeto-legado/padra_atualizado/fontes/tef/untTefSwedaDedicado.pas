unit untTefSwedaDedicado;

interface

uses SysUtils, Classes, Forms, untFiscal, untFunTefDedicado;

Type
  TTefSwedaDedicado = class(TTefDedicado)
  private
    strSeqOperacao: String;
  Public
    function fTefFinRet(blnFazerLeituraX: Boolean = False; strArqCancelamento: String = ''; blnCancelamento: Boolean = False; blnChamadaADM: Boolean = False): Boolean; Override;
    function fTefImpCup(Var blnReimprimir: Boolean; arrMatImp: TStringList;
      blnFazerLeituraX: Boolean; intContadorCupom: Integer; strArqImp: String): Boolean; Override;
    function fErrImpressora(Var blnReimprimir: Boolean; blnOpcaoSimNao: Boolean = True; blnFechaVinculado: Boolean = True): Boolean; Override;
    function fPendenciaTEF: Boolean; Override;
    function fVerificaReducaoZ: Boolean; Override;

    Constructor Create(Owner: TComponent; Form: TForm; strCodEcf: String; objFiscal: TFiscalBrd); Reintroduce;
  End;

implementation

uses
  untFuncoes, untFuncoesSimples, untFunTef, StrUtils, untLogTef;

function TTefSwedaDedicado.fTefFinRet(blnFazerLeituraX: Boolean = False; strArqCancelamento: String = ''; blnCancelamento: Boolean = False; blnChamadaADM: Boolean = False): Boolean;
  Var
    blnRetornoImp  : Boolean;
    blnReimprimir  : Boolean;
    blnTransNegada : Boolean;
    arrArquivos    : TStringList;
    strStatus      : String;
    strArqImpressao: String;
    intContador    : Integer;

    arrMatRet      : arrTStringList;
    blnEnviaNcn    : Boolean;
Begin
  blnEnviaNcn    := False;
  blnRetornoImp  := False;
  blnTransNegada := False;
  strStatus      := '';

  arrArquivos := TStringList.Create;

  {*****************************************}
  {* INTPOS.001 DEVE SER O PRIMEIRO,       *}
  {**************************************MV*}
  If FileExists(VS_Tef_Ret) Then
    arrArquivos.Add(VS_Tef_Ret);

  {************************************}
  {* -> PEGA OS ARQUIVOS TEF CONFIRMA-*}
  {*    DOS                           *}
  {*********************************WI*}
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

      {************************************}
      {* -> IMPRIME CUPOM                 *}
      {*********************************WI*}
      blnEnviaNcn := False;

      TLogTef.pLoga('untTefSwedaDedicado.fTefFinRet', 'While dos arquivos, vai verificar "fTransNegada"');

      If fTransNegada(strArqImpressao) Then
      Begin
        blnRetornoImp := fTefImpCup( blnReimprimir, fLArqTxt( '029', strArqImpressao ), blnFazerLeituraX, intContador, strArqImpressao );

        If (Not blnRetornoImp) Then
        Begin
          {*****************************************}
          {* CASO TENHA OCORRIDO ERROS NA IMPRES-  *}
          {* SÃO E O USUÁRIO TENHA ESCOLHIDO NÃO   *}
          {* PROSSEGUIR, ENVIA NÃO CONFIRMAÇÃO.    *}
          {**************************************MV*}
          If Not blnReimprimir Then
          Begin
            blnEnviaNcn := True;
          End;
        End;

        TLogTef.pLoga('untTefSwedaDedicado.fTefFinRet', '(fTransNegada=True) (fTefImpCup=' + fBoleanoToStr(blnRetornoImp) + ')');
      End
      Else
      Begin
        TLogTef.pLoga('untTefSwedaDedicado.fTefFinRet', '(fTransNegada=False)');
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

  Result := blnRetornoImp;

  pMostraMensTEF(frmFormAtual, '');

  {************************************}
  {* -> CASO TENHA SIDO CHAMADO PELO  *}
  {*    ADM, ENVIA OU NAO CONFIRMACAO *}
  {*********************************WI*}
  If blnChamadaADM Then
  Begin
    TLogTef.pLoga('untTefSwedaDedicado.fTefFinRet', '(blnChamadaADM=True) vai chamar "pVerificaCncNcn"');
    pVerificaCncNcn( blnChamadaADM, Result )
  End
  Else
  Begin
    TLogTef.pLoga('untTefSwedaDedicado.fTefFinRet', '(blnChamadaADM=False) vai fazer For para enviar os comandos de Confirmação ou Não Confirmação');
    {*****************************************}
    {* ENVIA OS COMANDOS DE CONFIRMAÇÃO OU   *}
    {* DE NÃO-CONFIRMAÇÃO, DEPENDENDO DO RE- *}
    {* SULTADO DO PROCESSO DE IMPRESSÃO.     *}
    {**************************************MV*}
    For intContador := 0 To arrArquivos.Count -1 Do
    Begin

      strArqImpressao := arrArquivos.Strings[intContador];

      pInicializaMatRet( arrMatRet );

      arrMatRet[ TF_strProIde ] := fLArqTxt( '001', strArqImpressao );   // Numero da Identificacao
      arrMatRet[ TF_strNomRed ] := fLArqTxt( '010', strArqImpressao );   // Nome da Rede
      arrMatRet[ TF_strNumTra ] := fLArqTxt( '012', strArqImpressao );   // Numero da Transacao
      arrMatRet[ TF_strDtaTra ] := fLArqTxt( '022', strArqImpressao );   // Data da Transacao DDMMAAAA
      arrMatRet[ TF_strHorTra ] := fLArqTxt( '023', strArqImpressao );   // Hora da Transacao HHMMSS
      arrMatRet[ TF_strChaFin ] := fLArqTxt( '027', strArqImpressao );   // Chave para Finalizacao
      arrMatRet[ TF_intQtdLin ] := fLArqTxt( '028', strArqImpressao );   // Qtd Linhas do Comprovante
      arrMatRet[ TF_lslLinImp ] := fLArqTxt( '029', strArqImpressao );   // Matriz com as linhas para impressao
      arrMatRet[ TF_curValRet ] := fLArqTxt( '003', strArqImpressao );   // Valor do Cupom
      arrMatRet[ TF_strMensag ] := fLArqTxt( '030', strArqImpressao );   // Mensagem
      arrMatRet[ TF_strStatus ] := fLArqTxt( '009', strArqImpressao );   // Status da Transacao
      arrMatRet[ TF_strOcorre ].Strings[0] := '0';                       // Ocorrencia 0-False 1-True

      If blnEnviaNcn Then
      Begin
        TLogTef.pLoga('untTefSwedaDedicado.fTefFinRet', '(blnEnviaNcn=True) vai chamar "pEnviaNcn"');
        pEnviaNcn(strArqImpressao, True, True, False);
      End
      Else
      Begin
        TLogTef.pLoga('untTefSwedaDedicado.fTefFinRet', '(blnEnviaNcn=False) vai chamar "pTef_Cnf"');
        pTef_Cnf( arrMatRet[ TF_strProIde ].Strings[0],
                  arrMatRet[ TF_strNomRed ].Strings[0],
                  arrMatRet[ TF_strNumTra ].Strings[0],
                  arrMatRet[ TF_strDtaTra ].Strings[0],
                  arrMatRet[ TF_strHorTra ].Strings[0],
                  arrMatRet[ TF_strChaFin ].Strings[0] );
      End;

    End;

  End;

  Repeat
    Application.ProcessMessages;
    VS_objFiscal.fExecutaCMD( '.12' );
    Application.ProcessMessages;
  Until (fErrImpressora(blnReimprimir, False, True));

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  If Result Then
  Begin

    strSeqOperacao := '';

    If Not blnCancelamento Then
      pDelArqRet;

  End;

  FreeAndNil( arrArquivos );
  stlArqTefMod.Clear;

end;

function TTefSwedaDedicado.fTefImpCup(Var blnReimprimir: Boolean; arrMatImp: TStringList;
  blnFazerLeituraX: Boolean; intContadorCupom: Integer; strArqImp: String): Boolean;
  Var
    intPosicao     : Integer;
    intImpressao   : Integer;
    intQtdVia      : Integer;
    txfMatricial   : TextFile;
    blnTirouLeturaX: Boolean;

    strModVinculado: String;

    strNomeRede: String;

Begin
  blnTirouLeturaX := False;
  Result          := True;
  intQtdVia       := StrToIntDef(fCfgSis('VIAVIS'), 2);

  strNomeRede := fLArqTxt('010', strArqImp)[0];

  //Impressora matricial (não fiscal)
  If Not blnUsaImp Then
  Begin
    AssignFile(txfMatricial, 'LPT1');
    ReWrite(txfMatricial);
  End
  Else
  Begin
    {************************************}
    {* -> SE FOR IMPRESSAO REF. A PEN-  *}
    {*    DENCIA (QUEDA DE ENERGIA)     *}
    {*********************************WI*}
    ///////REMOVER QUANDO PEGAR A TÉRMICA
    If (blnFazerLeituraX And (intContadorCupom = 0)) Or blnReimprimir Then
    Begin
      {************************************}
      {* -> TIRA UMA LEITURA X            *}
      {*********************************WI*}

      Application.ProcessMessages;
      VS_objFiscal.fExecutaCMD( '.12' );
      Sleep( 1000 );
      VS_objFiscal.fLeituraX('S', False);
      blnTirouLeturaX := True;
    End;

    {************************************}
    {* -> ABRE COMPROVANTE NAO FISCAL   *}
    {*********************************WI*}
    //////REMOVER A CONDICAO DA LEITURAX QUANDO PEGAR A TERMICA
    If (Not blnTirouLeturaX) And (intContadorCupom = 0) Then
    Begin
       blnReimprimir := False;
      Result        := fErrImpressora(blnReimprimir, True, False );

      If blnReimprimir Or (Not Result) Then
        Exit;

      strSeqOperacao := VS_objFiscal.fRetornaCOO;

      {************************************}
      {* -> ABRE CUPOM VINCULADO          *}
      {*********************************WI*}
      strModVinculado := Trim(stlArqTefCodMod.Values[strArqImp]);
      If fEmptyStr(strModVinculado) Then
        strModVinculado := VS_DesCar;

      VS_objFiscal.fExecutaCMD( '.19'   +
                 '00'    +
                 RightStr( strSeqOperacao, 04 ) +
                 fstrEspaco( strModVinculado, 02 ) +
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

    If intPosicao > 1 Then
      Sleep(1000);

    For intImpressao := 0 To arrMatImp.Count-1 Do
    Begin

      //Impressora matricial (não fiscal)
      If Not blnUsaImp Then
      Begin
        WriteLn( txfMatricial, fstrEspaco( arrMatImp.Strings[intImpressao], 40 ) );
      End
      Else
      Begin

        VS_objFiscal.fExecutaCMD( '.08' + '0' + '' + fstrEspaco( arrMatImp.Strings[intImpressao], StrToInt(strQtdCol) ) );
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

    End;

    If Not Result Then
      Break;

    {************************************}
    {* -> SALTA LINHA IMPRESSORA FISCAL *}
    {*********************************WI*}
    //Impressora matricial (não fiscal)
    If Not blnUsaImp Then
    Begin
      WriteLn( txfMatricial, '' );
      WriteLn( txfMatricial, '' );
      WriteLn( txfMatricial, '' );
      WriteLn( txfMatricial, '' );
    End
    Else
    Begin
      VS_objFiscal.fExecutaCMD( '.08' + '9' + '5');
    End;

  End;

  {************************************}
  {* -> FINALIZA RELATORIO GERENCIAL  *}
  {*********************************WI*}
  //Impressora matricial (não fiscal)
  If Not blnUsaImp Then
    CloseFile( txfMatricial );
    
end;

function TTefSwedaDedicado.fErrImpressora(Var blnReimprimir: Boolean; blnOpcaoSimNao: Boolean = True; blnFechaVinculado: Boolean = True): Boolean;
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

    //VS_objFiscal.fFinalizaModoTEF;
    If blnOpcaoSimNao Then
    Begin
      If fMensagem( '', 'Impressora não Responde, Tentar Novamente?', ['',''] ) = 1 Then
        blnReimprimir := True
      Else
      Begin
        Result := False;
        //VS_objFiscal.fIniciaModoTEF;
        Break;
      End;
    End
    Else
    Begin
      fMensagem( '', 'Impressora não Responde!', ['&OK'] );
      blnReimprimir := True;
    End;
    //VS_objFiscal.fIniciaModoTEF;

    pMostraMensTEF(frmFormAtual, 'AGUARDE... Fazendo Leitura da Impressora Fiscal.');

    strStatus := VS_objFiscal.fStatusImpressora;

    If Copy( strStatus, 6, 1 ) = '0' Then
    Begin
      VS_objFiscal.fExecutaCMD( '.12' );
      Break;
    End;
  End;

  pMostraMensTEF(frmFormAtual, strSalvaMensagem);
end;

function TTefSwedaDedicado.fPendenciaTEF: Boolean;
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

  {*****************************************}
  {* ENVIA CONFIRMAÇÕES, CASO TENHA DESLI- *}
  {* GADO A MÁQUINA.                       *}
  {**************************************MV*}
  pEnviaConfirmacoesPendentes;

  If blnUsaImp Then
    VS_objFiscal.fExecutaCMD( '.12' );

  If fVerificaReducaoZ Then
    Result := True;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  pDelArqRet;

  fMensagem('', 'Última transação foi confirmada. Favor reimprimir último cupom.', ['&Ok']);
end;

function TTefSwedaDedicado.fVerificaReducaoZ: Boolean;
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
end;

Constructor TTefSwedaDedicado.Create(Owner: TComponent; Form: TForm; strCodEcf: String; objFiscal: TFiscalBrd);
begin
  Inherited Create(Self);

  Self.frmFormAtual := Form;
  Self.strCodEcf    := strCodEcf;
  Self.VS_objFiscal := objFiscal;

  strSeqOperacao := '';
end;

end.
