{**************************************}
{* CLASSE DE TEF DA BEMATECH          *}
{***********************************AF*}
unit untTefBematech;

interface

uses Windows, SysUtils, Forms, Classes, untFunTef, untFiscal,
  System.Generics.Collections;

Type
  TTefBematech = Class(TTef)
  Private

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

uses untFuncoes, untFuncoesSimples, untQckFatImpNFCe, untLogTef;

{**********************************************************}
{* FINALIZA / IMPRIME INFORMACOES RETORNO                 *}
{*******************************************************WI*}
function TTefBematech.fTefFinRet(blnFazerLeituraX: Boolean = False; strArqCancelamento: String = ''; blnCancelamento: Boolean = False; blnChamadaADM: Boolean = False): Boolean;
  Var
    blnRetornoImp  : Boolean;
    blnReimprimir  : Boolean;
    blnTransNegada : Boolean;
    arrArquivos    : TStringList;
    strStatus      : String;
    strArqImpressao: String;
    intContador    : Integer;
    arrMatRet      : arrTStringList;
    intTentativasATV: Integer;
    strMensag : String;
Begin

  blnRetornoImp  := False;
  blnTransNegada := False;
  strStatus      := '';

  {************************************}
  {* -> PEGA OS ARQUIVOS TEF CONFIRMA-*}
  {*    DOS                           *}
  {*********************************WI*}
  arrArquivos := TStringList.Create;

  If Not blnCancelamento Then
  Begin
    For intContador := 1 To VS_Tef_Qtd Do
    Begin
      If FileExists(VS_Tef_Imp + fStrZero(intContador, 03)) Then
        arrArquivos.Add(VS_Tef_Imp + fStrZero(intContador, 03));
    End;
  End;

  {*****************************************}
  {* INTPOS.001 DEVE SER O ÚLTIMO, POIS SÓ *}
  {* SERÁ CONFIRMADO APÓS A IMPRESSÃO DE   *}
  {* TODOS OS OUTROS CUPONS.               *}
  {**************************************MV*}
  If FileExists(VS_Tef_Ret) Then
    arrArquivos.Add(VS_Tef_Ret);

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

      TLogTef.pLoga('untTefBematech.fTefFinRet', 'While dos arquivos, vai verificar "fTransNegada"');

      {************************************}
      {* -> IMPRIME CUPOM                 *}
      {*********************************WI*}
      If fTransNegada( strArqImpressao) Then
      Begin
        If blnImpComprovante Then
          blnRetornoImp := fTefImpCup( blnReimprimir, fLArqTxt( '029', strArqImpressao ), blnFazerLeituraX, intContador, strArqImpressao )
        Else
        Begin
          pImprimirTef(fConverteTextoTEF(fLArqTxt('029', strArqImpressao)), fLArqTxt( '028-001', strArqImpressao )[0]);
          blnRetornoImp := True;
        End;

        TLogTef.pLoga('untTefBematech.fTefFinRet', '(fTransNegada=True) (fTefImpCup=' + fBoleanoToStr(blnRetornoImp) + ')');

        If (Pos('INTPOS', strArqImpressao) > 0)          And
           (fLArqTxt( '000', strArqImpressao )[0] <> 'CNC') Then
        Begin

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

          If (blnRetornoImp) Then
          Begin

            If (Not blnChamadaADM) Then
            Begin

              If blnUsaImp Then
              Begin

                Application.ProcessMessages;

                If blnImpComprovante Then
                Begin
                  TLogTef.pLoga('untTefBematech.fTefFinRet', '(blnUsaImp=True) And (blnImpComprovante=True)');

                  strStatus := VS_objFiscal.fStatusImpressora;
                  blnReimprimir := False;
                  If (fErrImpressora(blnReimprimir,False)) Then
                  Begin
                    TLogTef.pLoga('untTefBematech.fTefFinRet', 'Vai fechar vinculado e gerencial!');

                    VS_objFiscal.fFechaCNFVinculado(False);
                    VS_objFiscal.fFechaRelatorioGerencial(False);
                  End;
                End;

                Application.ProcessMessages;

              End;

              intTentativasATV := 1;
              While (intTentativasATV <= 3) And
                    (Not fTef_Atv_Direto) Do
              Begin
                If (intTentativasATV < 3) Then
                  strMensag := 'TEF não responde. Clique OK para tentar novamente.'
                Else
                  strMensag := 'Não foi possível obter retorno do Gerenciador TEF.' + sLineBreak +
                               'Favor realizar o recebimento deste cartão no equipamento POS.';

                If (Not fInTransaction) Then
                  pMensagemOk(strMensag)
                Else
                  pMostraMensTEF(frmFormAtual, strMensag);

                TLogTef.pLoga('untTefBematech.fTefFinRet', 'Exibiu ' + IIF(fInTransaction, 'no PANEL', 'ao usuário') + ' a mensagem: ' + strMensag);

                Inc(intTentativasATV);
              End;

              TLogTef.pLoga('untTefBematech.fTefFinRet', '(blnEnviaNcn=False) vai chamar "pTef_Cnf"');

              pTef_Cnf( arrMatRet[ TF_strProIde ].Strings[0],
                        arrMatRet[ TF_strNomRed ].Strings[0],
                        arrMatRet[ TF_strNumTra ].Strings[0],
                        arrMatRet[ TF_strDtaTra ].Strings[0],
                        arrMatRet[ TF_strHorTra ].Strings[0],
                        arrMatRet[ TF_strChaFin ].Strings[0] );
            End;

          End
          Else
          Begin
            {*****************************************}
            {* VOLTAR AQUI: VERIFICAR O ARQUIVO DE PENDENCIA *}
            { FUNCTION DO CLIPPER TEF_FIR_DE }
            { TEM QUE PASSAR PARAMETRO PARA A pEnviaNcn para ver se MOSTRA A MENSGEM
            {**************************************MV*}
            If Not blnReimprimir Then
              pEnviaNcn(strArqImpressao);
          End;

        End;

      End
      Else
      Begin
        TLogTef.pLoga('untTefBematech.fTefFinRet', '(fTransNegada=False)');
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
    TLogTef.pLoga('untTefBematech.fTefFinRet', '(blnChamadaADM=True) vai chamar "pVerificaCncNcn"');
    pVerificaCncNcn( blnChamadaADM, Result );
  End;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  If Result Then
  Begin

    If Not blnCancelamento Then
      pDelArqRet;

  End;

  //Impressora matricial (não fiscal) ou Fiscal
  If blnUsaImp Then
  Begin

    Application.ProcessMessages;

    If blnImpComprovante Then
    Begin
      TLogTef.pLoga('untTefBematech.fTefFinRet', '(blnUsaImp=True) And (blnImpComprovante=True)');

      strStatus := VS_objFiscal.fStatusImpressora;
      blnReimprimir := False;
      If (fErrImpressora(blnReimprimir,False)) Then
      Begin
        TLogTef.pLoga('untTefBematech.fTefFinRet', 'Vai fechar vinculado e gerencial!');

        VS_objFiscal.fFechaCNFVinculado(False);
        VS_objFiscal.fFechaRelatorioGerencial(False);
      End;
    End;

    Application.ProcessMessages;

  End;

  TLogTef.pLoga('untTefBematech.fTefFinRet', 'Finalizando a função, valores: (Result=' + fBoleanoToStr(Result) + ')');

  stlArqTefMod.Clear;

End;

{**********************************************************}
{* -> IMPRIME CUPOM DE RETORNO DA "REDE"                  *}
{*******************************************************WI*}
function TTefBematech.fTefImpCup(Var blnReimprimir: Boolean; arrMatImp: TStringList;
  blnFazerLeituraX: Boolean; intContadorCupom: Integer; strArqImp: String ): Boolean;
  Var
    intPosicao     : Integer;
    intImpressao   : Integer;
    intQtdVia      : Integer;
    txfMatricial   : TextFile;
    blnTirouLeturaX: Boolean;
    intLinha       : Integer;

    strLinhaVinculado: String;
    intQtdLinVinculado: Integer;

    strModVinculado: String;
    blnModoTefAtivo: Boolean;
    filaPicote: TQueue<Integer>;
  Const
    LINHAS_PULAR_GUILHOTINA = #13#10+#13#10+#13#10+#13#10;
Begin
  blnTirouLeturaX := False;
  Result          := True;
  intQtdVia       := fCfgSis('VIAVIS', varInteger);
  blnModoTefAtivo := false;

  filaPicote := TQueue<Integer>.Create;

  pPreparaFilaPicotes(filaPicote, strArqImp, intQtdVia);

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
    If (blnFazerLeituraX And (intContadorCupom = 0)) Or blnReimprimir Then
    Begin
      {************************************}
      {* -> TIRA UMA LEITURA X            *}
      {*********************************WI*}

     // PARADO PARA ACERTAR ARQUIVOS DA GUACU.............. ERRO NAO ESTA EMITINDO LEITURA X

//      Application.ProcessMessages;
//      VS_objFiscal.fFechaCNFVinculado;
//      VS_objFiscal.fFechaRelatorioGerencial(False);

      Application.ProcessMessages;
      Sleep( 1000 );
//      VS_objFiscal.fLeituraX;
      VS_objFiscal.pPausaLeitura;

      While (VS_objFiscal.fStatusImpressora <> '1') Do
      Begin
        //blnModoTefAtivo := blnTravad;
        //VS_objFiscal.fFinalizaModoTEF;
        fMensagem('ATENÇÃO!', 'Impressora não responde.', ['&Ok']);

        If (blnModoTefAtivo) Then
          //VS_objFiscal.fIniciaModoTEF;

      End;

      VS_objFiscal.fFechaCNFVinculado(False);
      VS_objFiscal.fFechaRelatorioGerencial(False);
//      VS_objFiscal.fCancelaCupom(False);

      {************************************}
      {* -> VERIFICA ERRO NA IMPRESSORA   *}
      {*********************************WI*}
      {blnReimprimir := False;
      Result        := fErrImpressora( blnReimprimir, True, False );

      If blnReimprimir Or ( Not Result ) Then
        Exit;}

      {************************************}
      {* -> SALTA LINHA NA IMPRESSORA     *}
      {*********************************WI*}
//      For intLinha := 1 To 3 Do
//        VS_objFiscal.fRelatorioGerencial(fstrEspaco( ' ', StrToInt(strQtdCol) ), False);


      blnTirouLeturaX := True;
    End;

    {************************************}
    {* -> ABRE COMPROVANTE NAO FISCAL   *}
    {*********************************WI*}
    If (Not blnTirouLeturaX) And (intContadorCupom = 0) Then
    Begin
      blnReimprimir := False;
      Result        := fErrImpressora(blnReimprimir, True, False );

      If blnReimprimir Or (Not Result) Then
        Exit;

      {************************************}
      {* -> ABRE CUPOM VINCULADO          *}
      {*********************************WI*}
      strModVinculado := Trim(stlArqTefMod.Values[strArqImp]);
      If fEmptyStr(strModVinculado) Then
        strModVinculado := VS_DesCar;

      VS_objFiscal.fAbreCNFVinculado(strModVinculado, '', '');

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

    If (intPosicao > 1) And (fCfgSis('CORCUP', varBoolean)) Then
    Begin
      If (Not blnTirouLeturaX) Then
      Begin
        VS_objFiscal.fUsaCNFVinculado(LINHAS_PULAR_GUILHOTINA);
      End
      Else
      Begin
        VS_objFiscal.fRelatorioGerencial(LINHAS_PULAR_GUILHOTINA);
      End;
      VS_objFiscal.fAcionaGuilhotina;
    End;

    If intPosicao > 1 Then
      Sleep(1000);

    intQtdLinVinculado := 0;
    For intImpressao := 0 To arrMatImp.Count-1 Do
    Begin
      //Application.ProcessMessages;

      If intQtdLinVinculado = 0 Then
        strLinhaVinculado := '';

      strLinhaVinculado := strLinhaVinculado + fstrEspaco( arrMatImp.Strings[intImpressao], StrToInt(strQtdCol) );
      If (intQtdLinVinculado < 3) And (intImpressao < arrMatImp.Count-1) And ( fVerificaPicote(intImpressao, filaPicote) ) Then
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

        If (Not blnTirouLeturaX) Then
        Begin
          VS_objFiscal.fUsaCNFVinculado(strLinhaVinculado);
          //Sleep( 200 );
          //Application.ProcessMessages;
        End
        Else
        Begin
          VS_objFiscal.fRelatorioGerencial(strLinhaVinculado);
          //Sleep( 200 );
          //Application.ProcessMessages;
        End;

        {************************************}
        {* -> VERIFICA ERRO NA IMPRESSORA   *}
        {*********************************WI*}
        blnReimprimir := False;
        Result        := fErrImpressora( blnReimprimir );

        If blnReimprimir Or ( Not Result ) Then
          Exit;

        If (filaPicote.Count > 0) And (intImpressao+1 = filaPicote.Peek) Then
        Begin
          If (filaPicote.Peek <> arrMatImp.Count) Or (Not fCfgSis('CORCUP', varBoolean)) Then
          Begin
            If (Not blnTirouLeturaX) Then
            Begin
              VS_objFiscal.fUsaCNFVinculado(LINHAS_PULAR_GUILHOTINA);
              VS_objFiscal.fUsaCNFVinculado(LINHAS_PULAR_GUILHOTINA);
            End
            Else
            Begin
              VS_objFiscal.fRelatorioGerencial(LINHAS_PULAR_GUILHOTINA);
              VS_objFiscal.fRelatorioGerencial(LINHAS_PULAR_GUILHOTINA);
            End;
            VS_objFiscal.fAcionaGuilhotina;
          End;
          filaPicote.Dequeue;
        End;

      End;

      intQtdLinVinculado := 0;

    End;

    If Not Result Then
      Break;

    {************************************}
    {* -> SALTA LINHA IMPRESSORA FISCAL *}
    {*********************************WI*}
    //Sleep( 1000 );
    //Application.ProcessMessages;

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

      strLinhaVinculado := '';
      For intLinha := 1 To 3 Do
      Begin
        strLinhaVinculado := strLinhaVinculado + fstrEspaco( ' ', StrToInt(strQtdCol) );
        If intLinha < 3 Then
           strLinhaVinculado := strLinhaVinculado + #10#13;
      End;

      //If intPosicao < intQtdVia Then
      //Begin
        If (Not blnTirouLeturaX) Then
          VS_objFiscal.fUsaCNFVinculado(strLinhaVinculado)
        Else
          VS_objFiscal.fRelatorioGerencial(strLinhaVinculado);
      //End;

    End;

  End;

  {************************************}
  {* -> FINALIZA RELATORIO GERENCIAL  *}
  {*********************************WI*}
  //Impressora matricial (não fiscal)
  If Not blnUsaImp Then
    CloseFile( txfMatricial );

  FreeAndNil(filaPicote);

End;

{**********************************************************}
{* -> VERIFICA ERRO NO ENVIO DE COMANDOS PARA IMPRESSORA  *}
{*    FISCAL                                              *}
{*******************************************************WI*}
function TTefBematech.fErrImpressora(Var blnReimprimir: Boolean; blnOpcaoSimNao: Boolean = True; blnFechaVinculado: Boolean = True): Boolean;
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

  If Not blnImpComprovante Then
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

    If (Trim(strStatus) = '1') Then
    Begin

      If blnReimprimir And blnFechaVinculado Then
      Begin
        VS_objFiscal.fFechaCNFVinculado(False);
        VS_objFiscal.fFechaRelatorioGerencial(False);
      End;

//      If (VS_objFiscal.fVerErro( False )) Then
      Break;

    End;
  End;

  pMostraMensTEF(frmFormAtual, strSalvaMensagem);
End;

{**********************************************************}
{* -> VERIFICA SE EXISTE PENDENCIA A SER PROCESSADA       *}
{*******************************************************WI*}
function TTefBematech.fPendenciaTEF: Boolean;
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
  Begin
    If blnImpComprovante Then
    Begin
      VS_objFiscal.fFechaRelatorioGerencial(False);
    End;
  End;

  If fVerificaReducaoZ Then
    Result := True;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  pDelArqRet;
End;

{**********************************************************}
{* -> VERIFICA NECESSIDADE DE TIRAR UMA REDUCAO Z         *}
{*******************************************************WI*}
function TTefBematech.fVerificaReducaoZ: Boolean;
Begin
  Result := True;
End;

constructor TTefBematech.Create(Owner: TComponent; Form: TForm; strCodEcf: String; objFiscal: TFiscalBrd);
begin

  Inherited Create(Self);

  Self.frmFormAtual := Form;
  Self.strCodEcf    := strCodEcf;
  Self.VS_objFiscal := objFiscal;
end;

end.
