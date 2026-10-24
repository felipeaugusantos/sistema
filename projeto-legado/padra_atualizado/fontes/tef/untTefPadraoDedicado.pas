unit untTefPadraoDedicado;

interface

uses SysUtils, Classes, Forms, untFiscal, untFunTefDedicado,
  System.Generics.Collections;

Type
  TTefPadraoDedicado = class(TTefDedicado)
  private
    strSeqOperacao: String;
    procedure pCancelaVinculadoOuGerencial;
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
  untFuncoes, untFuncoesSimples, untFunTef, StrUtils, untQckFatImpNFCe, untLogTef;

function TTefPadraoDedicado.fTefFinRet(blnFazerLeituraX: Boolean = False; strArqCancelamento: String = ''; blnCancelamento: Boolean = False; blnChamadaADM: Boolean = False): Boolean;
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

    intTentativasATV: Integer;
    strMensag : String;
Begin

  blnRetornoImp  := False;
  blnTransNegada := False;
  blnEnviaNcn    := False;
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

      TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', 'While dos arquivos, vai verificar "fTransNegada"');

      If fTransNegada(strArqImpressao) Then
      Begin
        If blnImpComprovante Then
          blnRetornoImp := fTefImpCup( blnReimprimir, fLArqTxt( '029', strArqImpressao ), blnFazerLeituraX, intContador, strArqImpressao )
        Else
        Begin
          pImprimirTef(fConverteTextoTEF(fLArqTxt('029', strArqImpressao)), fLArqTxt( '028-001', strArqImpressao )[0]);
          blnRetornoImp := True;
        End;

        TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', '(fTransNegada=True) (fTefImpCup=' + fBoleanoToStr(blnRetornoImp) + ')');

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

      End
      Else
      Begin
        TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', '(fTransNegada=False)');
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
  begin
    TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', '(blnChamadaADM=True) vai chamar "pVerificaCncNcn"');
    pVerificaCncNcn( blnChamadaADM, Result );
  end
  Else
  Begin
    TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', '(blnChamadaADM=False) vai fazer For para enviar os comandos de Confirmação ou Não Confirmação');
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
        TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', '(blnEnviaNcn=True) vai chamar "pEnviaNcn"');
        pEnviaNcn(strArqImpressao, True, True, False);
      End
      Else
      Begin
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

          TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', 'Exibiu ' + IIF(fInTransaction, 'no PANEL', 'ao usuário') + ' a mensagem: ' + strMensag);

          Inc(intTentativasATV);
        End;

        TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', '(blnEnviaNcn=False) vai chamar "pTef_Cnf"');

        pTef_Cnf( arrMatRet[ TF_strProIde ].Strings[0],
                  arrMatRet[ TF_strNomRed ].Strings[0],
                  arrMatRet[ TF_strNumTra ].Strings[0],
                  arrMatRet[ TF_strDtaTra ].Strings[0],
                  arrMatRet[ TF_strHorTra ].Strings[0],
                  arrMatRet[ TF_strChaFin ].Strings[0] );
      End;

    End;

  End;

  pCancelaVinculadoOuGerencial;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  If Result Then
  Begin

    strSeqOperacao := '';

    If Not blnCancelamento Then
      pDelArqRet;

  End;

  TLogTef.pLoga('untTefPadraoDedicado.fTefFinRet', 'Finalizando a função, valores: (Result=' + fBoleanoToStr(Result) + ')');

  FreeAndNil( arrArquivos );
  stlArqTefMod.Clear;

end;

function TTefPadraoDedicado.fTefImpCup(Var blnReimprimir: Boolean; arrMatImp: TStringList;
  blnFazerLeituraX: Boolean; intContadorCupom: Integer; strArqImp: String): Boolean;
  Var
    intPosicao     : Integer;
    intImpressao   : Integer;
    intQtdVia      : Integer;
    txfMatricial   : TextFile;
    blnTirouLeturaX: Boolean;

    strModVinculado: String;

    strNomeRede: String;
    strLinhaVinculado: String;
    intQtdLinVinculado: Integer;
    intLinha: Integer;
    filaPicote: TQueue<Integer>;
    blnAbriuVinculado : Boolean;
    strLinhas_Pular_Guilhotina: string;
    intQtdeLinhasSalto: Integer;
Begin
  blnTirouLeturaX := False;
  Result          := True;
  intQtdVia       := StrToIntDef(fCfgSis('VIAVIS'), 2);
  if (not fEmptyStr(fLArqTxt('028-001', strArqImp)[0])) then
    intQtdeLinhasSalto := 0
  else
    intQtdeLinhasSalto := StrToIntDef(fCfgSis('QTLNCO'), 0);

  blnAbriuVinculado := False;

  filaPicote := TQueue<Integer>.Create;

  if (intQtdeLinhasSalto > 1) then
  begin
    arrMatImp.Text := fRetiraLinhasEmBrancoInicio_Fim_Texto(arrMatImp.Text);
    strLinhas_Pular_Guilhotina := '';
    for intPosicao := 1 to intQtdeLinhasSalto do
      strLinhas_Pular_Guilhotina := strLinhas_Pular_Guilhotina + #13#10;
  end
  else
    strLinhas_Pular_Guilhotina := #13#10+#13#10+#13#10+#13#10;

  pPreparaFilaPicotes(filaPicote, strArqImp, intQtdVia);

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
      pCancelaVinculadoOuGerencial;
      Sleep( 1000 );
      //VS_objFiscal.fLeituraX('S', False);
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
      strModVinculado := Trim(stlArqTefMod.Values[strArqImp]);
      If fEmptyStr(strModVinculado) Then
        strModVinculado := VS_DesCar;

      VS_objFiscal.fAbreCNFVinculado(strModVinculado, VS_objFiscal.strTotalSistema, '', True, IntToStr(intQtdPar));
      blnAbriuVinculado := True;

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
        VS_objFiscal.fUsaCNFVinculado(strLinhas_Pular_Guilhotina);
      End
      Else
      Begin
        VS_objFiscal.fRelatorioGerencial(strLinhas_Pular_Guilhotina);
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
        End
        Else
        Begin
          VS_objFiscal.fRelatorioGerencial(strLinhaVinculado);
        End;

        {************************************}
        {* -> VERIFICA ERRO NA IMPRESSORA   *}
        {*********************************WI*}
        blnReimprimir := False;
        Result        := fErrImpressora( blnReimprimir );

        If (blnAbriuVinculado) And (VS_objFiscal.fExcedeuLinhasDocumento) Then
        Begin
          pCancelaVinculadoOuGerencial;
          VS_objFiscal.fAbreCNFVinculado(strModVinculado, VS_objFiscal.strTotalSistema, '', True, IntToStr(intQtdPar));
        End
        Else
        Begin
          If blnReimprimir Or ( Not Result ) Then
            Exit;
        End;

        If (filaPicote.Count > 0) And (intImpressao+1 = filaPicote.Peek) Then
        Begin
          If (filaPicote.Peek <> arrMatImp.Count) Or (Not fCfgSis('CORCUP', varBoolean)) Then
          Begin
            If (Not blnTirouLeturaX) Then
            Begin
              VS_objFiscal.fUsaCNFVinculado(strLinhas_Pular_Guilhotina);
              if (intQtdeLinhasSalto <= 1) then
                VS_objFiscal.fUsaCNFVinculado(strLinhas_Pular_Guilhotina);
            End
            Else
            Begin
              VS_objFiscal.fRelatorioGerencial(strLinhas_Pular_Guilhotina);
              if (intQtdeLinhasSalto <= 1) then
                VS_objFiscal.fRelatorioGerencial(strLinhas_Pular_Guilhotina);
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
      if (intQtdeLinhasSalto > 1) then
        strLinhaVinculado := ReverseString(strLinhas_Pular_Guilhotina)
      else
      begin
      strLinhaVinculado := '';
        For intLinha := 1 To 3 Do
        Begin
          strLinhaVinculado := strLinhaVinculado + fstrEspaco( ' ', StrToInt(strQtdCol) );
          If intLinha < 3 Then
             strLinhaVinculado := strLinhaVinculado + #10#13;
        End;
      end;

      If (Not blnTirouLeturaX) Then
        VS_objFiscal.fUsaCNFVinculado(strLinhaVinculado)
      Else
        VS_objFiscal.fRelatorioGerencial(strLinhaVinculado);
    End;

  End;

  {************************************}
  {* -> FINALIZA RELATORIO GERENCIAL  *}
  {*********************************WI*}
  //Impressora matricial (não fiscal)
  If Not blnUsaImp Then
    CloseFile( txfMatricial );

  FreeAndNil(filaPicote);
end;

function TTefPadraoDedicado.fErrImpressora(Var blnReimprimir: Boolean; blnOpcaoSimNao: Boolean = True; blnFechaVinculado: Boolean = True): Boolean;
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
        pCancelaVinculadoOuGerencial;
      End;

//      If (VS_objFiscal.fVerErro( False )) Then
      Break;

    End;
  End;

  pMostraMensTEF(frmFormAtual, strSalvaMensagem);
end;

function TTefPadraoDedicado.fPendenciaTEF: Boolean;
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
    pCancelaVinculadoOuGerencial;

  If fVerificaReducaoZ Then
    Result := True;

  {************************************}
  {* DELETA ARQUIVO DE RETORNO        *}
  {*********************************WI*}
  pDelArqRet;

  fMensagem('', 'Última transação foi confirmada. Verificar: '+#13+
                ' - Se houve baixa do estoque. '+#13+
                ' - Se foi feito o registro do recebimento no resumo de caixa. '+#13+
                ' - A movimentação do cartão na manutenção de cartões. '+#13+
                ' - O comprovante da transação TEF.', ['&Ok']);
end;

function TTefPadraoDedicado.fVerificaReducaoZ: Boolean;
Begin
  Result := True;
end;

Constructor TTefPadraoDedicado.Create(Owner: TComponent; Form: TForm; strCodEcf: String; objFiscal: TFiscalBrd);
begin
  Inherited Create(Self);

  Self.frmFormAtual := Form;
  Self.strCodEcf    := strCodEcf;
  Self.VS_objFiscal := objFiscal;

  strSeqOperacao := '';
end;

procedure TTefPadraoDedicado.pCancelaVinculadoOuGerencial;
begin
  If blnImpComprovante Then
  Begin
    VS_objFiscal.fFechaCNFVinculado(False); //alex relger
    VS_objFiscal.fFechaRelatorioGerencial(False);
  End;
end;

end.
