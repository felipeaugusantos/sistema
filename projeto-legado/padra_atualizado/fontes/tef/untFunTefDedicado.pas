  unit untFunTefDedicado;

interface

uses SysUtils, Classes, Controls, Forms, DateUtils, untFunTef, Windows;

Type
  TTefDedicado = class(TTef)
  public
    procedure pVerificaCncNcn(blnChamadaADM: Boolean = False; blnOcorrencia: Boolean = False); Override;
    function fGeraArqEnvio(lstEnviaTEF: TStringList): Boolean; Override;
    function fTef_Crt(strValorCartao: String; blnApagaImpCup, blnUltCartao: Boolean;
      Var strArqRet: String; blnRotinaPagueFacil: Boolean = False;
      strTipoCartao: string = ''; intParcelas: Integer = 1): Boolean; Override;
    function fValorSaque: Double; Override;
    function fEnviarValorComVirgula: Boolean;

    constructor Create(Owner: TComponent); Reintroduce;
  End;

implementation

uses
  untFuncoes, untFuncoesSimples, StrUtils;

constructor TTefDedicado.Create(Owner: TComponent);
  Var
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
  inherited Create(Owner);

  {************************************}
  {* CONFIGURAÇÃO PARA TS             *}
  {*********************************WI*}
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

  blnAtvAntesComandos := False;
end;

function TTefDedicado.fEnviarValorComVirgula: Boolean;
begin
  Result := True;

  If (Not (fCfgsis('VIRTEF', varBoolean))) And (fCfgSis('USNFCE', varBoolean)) Then
    Result := False
  Else If (Not (fCfgsis('VRTFSA', varBoolean))) And (fCfgSis('USASAT', varBoolean)) Then
    Result := False
  else if (not fCfgSis('VRTEEC', varBoolean)) and (Assigned(VS_objFiscal)) then
    Result := False;
end;

function TTefDedicado.fGeraArqEnvio(lstEnviaTEF: TStringList): Boolean;
	Var
    strNomeArqReq  : String;
    strNomeArqRen  : String;
    strNomeArqRes  : String;
    strNomeArqPen  : String;
    intAssign      : Integer;
    intQtdSegundos : Integer;
    timHoraAnterior: TTime;
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
          SysUtils.DeleteFile(strNomeArqRes );
          pRealizarBackup;
          Result := True;
          Break;
        End;

        intQtdSegundos := SecondOfTheDay( fTime() ) - SecondOfTheDay( timHoraAnterior );
        
        If ( intQtdSegundos > 7 ) Then
        Begin

          If Pos(fLArqTxt( '000', strNomeArqRen)[0], 'CNF_NCN') > 0 Then
            fRenomearArquivo(strNomeArqRen, strNomeArqPen);

          fMensagem( '', 'ERRO DE COMUNICAÇÃO - CLIENT do TEF não está em execução. FAVOR ATIVÁ-LO.', ['&Ok'] );

          Result := False;
          Break;
        End;
      End;
      Screen.Cursor := crDefault;
    End;
  Except
    On E: Exception Do
      fMensagem( '', 'Erro na geração do arquivo ('+strNomeArqReq+'): ' + E.Message, ['&O k'] );
  End;
end;

function TTefDedicado.fTef_Crt(strValorCartao: String; blnApagaImpCup,
  blnUltCartao: Boolean; var strArqRet: String; blnRotinaPagueFacil: Boolean;
      strTipoCartao: string; intParcelas: Integer): Boolean;
begin

  If (fEnviarValorComVirgula) Then
  Begin
    strValorCartao := FloatToStrF(fStrToFloat(strValorCartao) / 100, ffNumber, 12, 2);
    strValorCartao := AnsiReplaceStr(strValorCartao, '.', '');
    strValorCartao := fPadL(strValorCartao, 13, '0');
  End
  Else
  Begin
    strValorCartao := fTiraCaracter(strValorCartao);
    strValorCartao := fPadL(strValorCartao, 12, '0');
  End;

  Result := inherited fTef_Crt(strValorCartao, blnApagaImpCup, blnUltCartao, strArqRet, blnRotinaPagueFacil, strTipoCartao, intParcelas);
end;

function TTefDedicado.fValorSaque: Double;
  Var
    arrArquivos: TStringList;
    stlArqRet: TStringList;
    intContador: Integer;
begin
  Result := 0;

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

  For intContador := 0 To arrArquivos.Count -1 Do
  Begin
    stlArqRet := fLArqTxt('200-000', arrArquivos[intContador]);

    If stlArqRet.Count > 0 Then
    Begin
      Result := Result + fStrToFloat(stlArqRet[0]);
    End;

  End;

  FreeAndNil(arrArquivos);
end;

procedure TTefDedicado.pVerificaCncNcn(blnChamadaADM: Boolean = False; blnOcorrencia: Boolean = False);
  Var
    arrMatRet    : arrTStringList;
    arrArquivos  : TStringList;
    intContador  : Integer;
    intNcnCnc    : Integer;
    strArqAtual  : String;
    strMensMostra: String;
    blnConsCheque: Boolean;
Begin
  If fCfgSis('SEQTEF', varBoolean) Then
  Begin
    inherited pVerificaCncNcn(blnChamadaADM, blnOcorrencia);
    Exit;
  End;
  
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
    strMensMostra := '';

    blnConsCheque := (fLArqTxt('000', strArqAtual).Strings[0] = 'CHQ');

    If (blnConsCheque) Then
    Begin
      {************************************}
      {* -> APAGA ARQUIVO ATUAL           *}
      {*********************************WI*}
      SysUtils.DeleteFile( strArqAtual );
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
      pEnviaNcn(strArqAtual, True, True, False);
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

    {************************************}
    {* -> APAGA ARQUIVO ATUAL           *}
    {*********************************WI*}
    SysUtils.DeleteFile( strArqAtual );
    pRealizarBackup;
  End;

  FreeAndNil(arrArquivos);
  Screen.Cursor := crDefault;
  pMostraMensTEF(frmFormAtual, '');
end;

end.
